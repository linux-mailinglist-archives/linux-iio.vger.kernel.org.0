Return-Path: <linux-iio+bounces-26369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E44DC7B587
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 19:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FA13A4D49
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ADB2F5A2B;
	Fri, 21 Nov 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfNlwVj2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173CA2E92B0;
	Fri, 21 Nov 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763749857; cv=none; b=iVj/JtjS2Jnt8EIOIjZNf2UaeDlhvZQF0HA1z9CsERqTLCRlTZKuUJBY558nuwUzOcA1II+mM1vUsjN78LlqdRPWJR53T+k49ArHlsqrEPQvYkEcgghXrSbs3wibjVRgw14DDfU2rkl3tDuIyVhF7v+jY91SqLUFoAxlcU4WzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763749857; c=relaxed/simple;
	bh=nuLEuThv9O831xu0F147aRG9883uZgJtP/Du5sjsZgo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=hfWEj4gEilU3PdssnR5jogkRoQUwWm2GK6gmARLXdshKFyTn68BfSVBOfWxgnQBz09i3SeilfHHBqPB5Qu0kW/fj3VONgbfOs4W8nz/Rmu1By8wIYMewao2Ipiq54L3UMgLpYMU3RqmAaWbUz+8e3Ls/mbePidhutipKdAMf7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfNlwVj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81861C116C6;
	Fri, 21 Nov 2025 18:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763749856;
	bh=nuLEuThv9O831xu0F147aRG9883uZgJtP/Du5sjsZgo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=NfNlwVj26byITxx4VpUHKfrCW5wJ2oC/OSIzb2Sl8O/4GDvNM8FIXbM4E45F/dk4X
	 X3g591xQKN2gzgeI6D2cBOiP+h73/ubsVG/tHk0HSIdHWzvbyqltTAal3YsjWGundi
	 R4mx/wSSFIbq39L6xaXbk8o/+4wTtqKd80mE95ky7dnpSsAi6nQJnwAuCxT8APKMqj
	 /qSiRrBsx1v1IfW8ArfvG7TqIqB4S3G9UUwv8lqYYbfG15XahtW+S/ijFoxxh4vbPs
	 uTFZJ8S8CRapm3NY+opKfiD/yMRvjJwoo5odxr99NXaqIM4qitdGWTZ8GgFmx8I8e4
	 wV9YV4gCIDXIA==
Date: Fri, 21 Nov 2025 12:30:54 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 Tobias Sperling <tobias.sperling@softing.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Andy Shevchenko <andy@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
In-Reply-To: <20251121-ads1x18-v1-1-86db080fc9a4@gmail.com>
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <20251121-ads1x18-v1-1-86db080fc9a4@gmail.com>
Message-Id: <176374985488.1690161.9712720079705383605.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118


On Fri, 21 Nov 2025 12:16:14 -0500, Kurt Borja wrote:
> Add documentation for Texas Instruments ADS1018 and ADS1118
> analog-to-digital converters.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads1118.yaml    | 132 +++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml:93:8: [error] empty value in block mapping (empty-values)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: ignoring, error in schema: allOf: 1: if
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: properties:reg: 'anyOf' conditional failed, one must be fixed:
	'maxitems' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: properties:drdy-gpios: 'anyOf' conditional failed, one must be fixed:
	'maxitems' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: properties:interrupts: 'anyOf' conditional failed, one must be fixed:
	'maxitems' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: properties:reg: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'maxitems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('maxitems' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxitems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/cell.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: properties:drdy-gpios: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'maxitems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('maxitems' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxitems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/cell.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: properties:interrupts: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'maxitems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('maxitems' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxitems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/cell.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: allOf:1:if: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: allOf:1:if: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: allOf:1:if: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: allOf:1:if: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: allOf:1:if: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: allOf:1:if: None is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1118.yaml: allOf:1:if: None is not of type 'object', 'boolean'
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 66, in main
    ret |= check_doc(f)
           ~~~~~~~~~^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 37, in check_doc
    dtsch.check_schema_refs()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 241, in check_schema_refs
    self._check_schema_refs(resolver, self)
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
    self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            has_constraint=has_constraint)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
    self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            has_constraint=has_constraint)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 203, in _check_schema_refs
    ref_sch = resolver.lookup(schema['$ref']).contents
              ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
    retrieved = self._registry.get_or_retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 422, in get_or_retrieve
    registry = self.crawl()
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 500, in crawl
    id = resource.id()
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 231, in id
    id = self._specification.id_of(self.contents)
  File "/usr/local/lib/python3.13/dist-packages/referencing/jsonschema.py", line 50, in _dollar_id
    return contents.get("$id")
           ^^^^^^^^^^^^
AttributeError: 'NoneType' object has no attribute 'get'
Lexical error: Documentation/devicetree/bindings/iio/adc/ti,ads1118.example.dts:32.49-70 Unexpected 'IRQ_TYPE_EDGE_FALLING'
Lexical error: Documentation/devicetree/bindings/iio/adc/ti,ads1118.example.dts:33.40-55 Unexpected 'GPIO_ACTIVE_LOW'
FATAL ERROR: Syntax error parsing input tree
make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/iio/adc/ti,ads1118.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251121-ads1x18-v1-1-86db080fc9a4@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


