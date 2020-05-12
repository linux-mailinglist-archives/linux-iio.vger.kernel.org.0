Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672FA1CEED4
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 10:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgELIJO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 04:09:14 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58525 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgELIJO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 04:09:14 -0400
X-Originating-IP: 78.193.40.249
Received: from kb-xps (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 79F33FF81A;
        Tue, 12 May 2020 08:09:09 +0000 (UTC)
Date:   Tue, 12 May 2020 10:09:07 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: counter: microchip-tcb-capture
 counter
Message-ID: <20200512080907.GA1634206@kb-xps>
References: <20200511140505.1649111-1-kamel.bouhara@bootlin.com>
 <20200511140505.1649111-5-kamel.bouhara@bootlin.com>
 <20200511161127.GA21385@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511161127.GA21385@bogus>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 11, 2020 at 11:11:27AM -0500, Rob Herring wrote:
> On Mon, 11 May 2020 16:05:04 +0200, Kamel Bouhara wrote:
> > Describe the devicetree binding for the Microchip TCB module.
> > Each counter blocks exposes three independent counters.
> >
> > However, when configured in quadrature decoder, both channel <0> and <1>
> > are required for speed/position and rotation capture (yet only the
> > position is captured).
> >
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > ---
> >  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 29 +++++++++++++++++--
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> >
>

Hello Rob,

>
> My bot found errors running 'make dt_binding_check' on your patch:
>

I upgraded to dtschema-2020.6.dev4 and still the duplicate key issue
isn't detected.

I guess having the way I described two examples using the same node
isn't right ?

Thanks,
Kamel

> Traceback (most recent call last):
>   File "/usr/local/bin/dt-doc-validate", line 64, in <module>
>     ret = check_doc(args.yamldt)
>   File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
>     testtree = dtschema.load(filename, line_number=line_number, duplicate_keys=False)
>   File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 592, in load
>     return yaml.load(f.read())
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
>     return constructor.get_single_data()
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 113, in get_single_data
>     return self.construct_document(node)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 123, in construct_document
>     for _dummy in generator:
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 723, in construct_yaml_map
>     value = self.construct_mapping(node)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 440, in construct_mapping
>     return BaseConstructor.construct_mapping(self, node, deep=deep)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 257, in construct_mapping
>     if self.check_mapping_key(node, key_node, mapping, key, value):
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
>     raise DuplicateKeyError(*args)
> ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>   in "<unicode string>", line 4, column 1
> found duplicate key "examples" with value "[]" (original value: "[]")
>   in "<unicode string>", line 157, column 1
>
> To suppress this check see:
>     http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys
>
> Duplicate keys will become an error in future releases, and are errors
> by default when using the new API.
>
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-mk-schema", line 34, in <module>
>     schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
>   File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 554, in process_schemas
>     sch = process_schema(os.path.abspath(filename))
>   File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 507, in process_schema
>     schema = load_schema(filename)
>   File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 123, in load_schema
>     return do_load(os.path.join(schema_basedir, schema))
>   File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 108, in do_load
>     return yaml.load(tmp)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
>     return constructor.get_single_data()
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 113, in get_single_data
>     return self.construct_document(node)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 123, in construct_document
>     for _dummy in generator:
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 723, in construct_yaml_map
>     value = self.construct_mapping(node)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 440, in construct_mapping
>     return BaseConstructor.construct_mapping(self, node, deep=deep)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 257, in construct_mapping
>     if self.check_mapping_key(node, key_node, mapping, key, value):
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
>     raise DuplicateKeyError(*args)
> ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>   in "<unicode string>", line 4, column 1
> found duplicate key "examples" with value "[]" (original value: "[]")
>   in "<unicode string>", line 157, column 1
>
> To suppress this check see:
>     http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys
>
> Duplicate keys will become an error in future releases, and are errors
> by default when using the new API.
>
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-mk-schema", line 34, in <module>
>     schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
>   File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 554, in process_schemas
>     sch = process_schema(os.path.abspath(filename))
>   File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 507, in process_schema
>     schema = load_schema(filename)
>   File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 123, in load_schema
>     return do_load(os.path.join(schema_basedir, schema))
>   File "/usr/local/lib/python3.6/dist-packages/dtschema/lib.py", line 108, in do_load
>     return yaml.load(tmp)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/main.py", line 343, in load
>     return constructor.get_single_data()
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 113, in get_single_data
>     return self.construct_document(node)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 123, in construct_document
>     for _dummy in generator:
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 723, in construct_yaml_map
>     value = self.construct_mapping(node)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 440, in construct_mapping
>     return BaseConstructor.construct_mapping(self, node, deep=deep)
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 257, in construct_mapping
>     if self.check_mapping_key(node, key_node, mapping, key, value):
>   File "/usr/local/lib/python3.6/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
>     raise DuplicateKeyError(*args)
> ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>   in "<unicode string>", line 4, column 1
> found duplicate key "examples" with value "[]" (original value: "[]")
>   in "<unicode string>", line 157, column 1
>
> To suppress this check see:
>     http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys
>
> Duplicate keys will become an error in future releases, and are errors
> by default when using the new API.
>
> Documentation/devicetree/bindings/Makefile:41: recipe for target 'Documentation/devicetree/bindings/processed-schema-examples.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/processed-schema-examples.yaml] Error 123
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema-examples.yaml'
> Documentation/devicetree/bindings/Makefile:45: recipe for target 'Documentation/devicetree/bindings/processed-schema.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/processed-schema.yaml] Error 123
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema.yaml'
> Makefile:1300: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1287813
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>
> Please check and re-submit.
>

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
