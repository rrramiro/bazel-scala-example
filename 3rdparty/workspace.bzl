# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output = ctx.path("jar/%s" % jar_name),
        url = ctx.attr.urls,
        sha256 = ctx.attr.sha256,
        executable = False
    )
    src_name = "%s-sources.jar" % ctx.name
    srcjar_attr = ""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output = ctx.path("jar/%s" % src_name),
            url = ctx.attr.src_urls,
            sha256 = ctx.attr.src_sha256,
            executable = False
        )
        srcjar_attr = '\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "com.googlecode.javaewah:JavaEWAH:0.6.6", "lang": "java", "sha1": "45eb0e27524454a02111136cf4da94476b376d11", "sha256": "01ad6da93001066c9741d7bdfdc651aeeb246e9c3adf86c0410b3ea4ebc035e3", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/googlecode/javaewah/JavaEWAH/0.6.6/JavaEWAH-0.6.6.jar", "source": {"sha1": "31a76e904669c1f36b5cca1af8da68097ebcd69f", "sha256": "7526801329a5737ff9146f5466ac2ec752446e9df608ac443c6544435b606cde", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/googlecode/javaewah/JavaEWAH/0.6.6/JavaEWAH-0.6.6-sources.jar"} , "name": "com_googlecode_javaewah_JavaEWAH", "actual": "@com_googlecode_javaewah_JavaEWAH//jar", "bind": "jar/com/googlecode/javaewah/JavaEWAH"},
    {"artifact": "com.twitter:algebird-core_2.11:0.12.1", "lang": "scala", "sha1": "86fa803e493b84157def202de47d2631bb29e46a", "sha256": "f75acb99f5736635631e44858c9e468cb7ba7f06c62d23713054bfffdedb1f4f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/twitter/algebird-core_2.11/0.12.1/algebird-core_2.11-0.12.1.jar", "source": {"sha1": "97b698b48aaf323870a078707fa3929f819f6360", "sha256": "c09945a8ce1c930fcf366a787ad646548c6565a9213e2e8b1350df42aa2bf5c2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/twitter/algebird-core_2.11/0.12.1/algebird-core_2.11-0.12.1-sources.jar"} , "name": "com_twitter_algebird_core_2_11", "actual": "@com_twitter_algebird_core_2_11//jar:file", "bind": "jar/com/twitter/algebird_core_2_11"},
    {"artifact": "org.scala-lang:scala-library:2.11.7", "lang": "java", "sha1": "f75e7acabd57b213d6f61483240286c07213ec0e", "sha256": "b401e1dc0ab03370f4e6078dbc8b8eb478c7cdf97022c13bab61baad21e98158", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-library/2.11.7/scala-library-2.11.7.jar", "source": {"sha1": "b3cf65e92414af4ce51ad3507147cc9f31fd708c", "sha256": "76ae60c4d4a8762aab425691b35122b357f89ffe6f32b0750799a155aabc1b2f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-library/2.11.7/scala-library-2.11.7-sources.jar"} , "name": "org_scala_lang_scala_library", "actual": "@org_scala_lang_scala_library//jar", "bind": "jar/org/scala_lang/scala_library"},
    {"artifact": "org.scala-lang:scala-reflect:2.11.7", "lang": "java", "sha1": "bf1649c9d33da945dea502180855b56caf06288c", "sha256": "8cb825e246d2c7b0cc1a8005e34352132b6018eeb54cf35d24719a29b3885fd2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-reflect/2.11.7/scala-reflect-2.11.7.jar", "source": {"sha1": "c4d5a9d0a7a6956720809bcebca1b2fe978e5dc6", "sha256": "2a121fa8c11455ee3244c83c9a191993cf028b8f00294b91fbffc3765467a59c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-reflect/2.11.7/scala-reflect-2.11.7-sources.jar"} , "name": "org_scala_lang_scala_reflect", "actual": "@org_scala_lang_scala_reflect//jar", "bind": "jar/org/scala_lang/scala_reflect"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
