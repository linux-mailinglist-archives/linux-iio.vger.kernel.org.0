Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9946D4B0
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 14:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhLHNsY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 08:48:24 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:44879 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbhLHNsU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 08:48:20 -0500
Received: by mail-oo1-f44.google.com with SMTP id t9-20020a4a8589000000b002c5c4d19723so810293ooh.11;
        Wed, 08 Dec 2021 05:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bGYILhGKiOz1OwrfVDoygkYtWCyIstR2qaWFjn+VxLE=;
        b=HRU4lKDIT/WDSvAZG+Jw6234pYrA9v9O8mXp2PrFkmbqLskq6a/r08UgVDaY6UV0Ct
         dXN/pJy9RfO/Ss+jJDsiOqzX0f8y/qzxtdwQQc2IC/zb81jrolUNfgmymMRg/Sah7GDl
         c0JMVckHpthgQbfsjI7MRtIdFYkof3M6i4sqwKS3OJ67NSui6ULjZcu3NI0qt6tCiOaM
         NeLPpHgmReh6/wI7IghEg5miGi+iB/Ro4qK0/UGBuT/lDi6F+KnAJEJ0sMdnl+6bpNWk
         2GLhFhFYCK2HRdv1fZvlyZyey08HlOo255wR4cAzpyPCLf0Zj0Szm9PVJE/rmyrHSpJt
         kStg==
X-Gm-Message-State: AOAM531B0dWU8TczCNansvUVSVwisuTSGtho0iMgR5fUaH0H00qOgL35
        WOWXLrc0rO86bnOaoyzc0A==
X-Google-Smtp-Source: ABdhPJzJYI9dabKVh7ZALOHjcahemXR4MVEdi0zmW+neS40YFgfCxk0d7/kBLE6Hg6GCMxOHsp3PTg==
X-Received: by 2002:a4a:d1b3:: with SMTP id z19mr30579325oor.14.1638971088201;
        Wed, 08 Dec 2021 05:44:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e14sm588501oie.7.2021.12.08.05.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:44:47 -0800 (PST)
Received: (nullmailer pid 3857732 invoked by uid 1000);
        Wed, 08 Dec 2021 13:44:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, jic23@kernel.org
In-Reply-To: <20211208004311.3098571-5-gwendal@chromium.org>
References: <20211208004311.3098571-1-gwendal@chromium.org> <20211208004311.3098571-5-gwendal@chromium.org>
Subject: Re: [PATCH v5 4/5] dt-bindings: iio: Add sx9324 binding
Date:   Wed, 08 Dec 2021 07:44:28 -0600
Message-Id: <1638971068.743379.3857731.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 07 Dec 2021 16:43:10 -0800, Gwendal Grignou wrote:
> Similar to SX9310, add biddings to setup sx9324 hardware properties.
> SX9324 is a little different, introduce 4 phases to be configured in 2
> pairs over 3 antennas.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v5:
> - Use consistent field naming, prefixed with phX.
> 
> Changes in v4:
> - Use const instead of single enum
> - Specify ph0-pin better
> - Recopy type information for phX-pin
> - Fix cut and paste errors.
> 
> Changes in v3:
> - Remove duplicate information.
> - Use intervals instead of enum.
> - Fix filter description.
> 
> Changes in v2:
> - Fix interrupt documentation wording.
> 
>  .../iio/proximity/semtech,sx9324.yaml         | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,ph01-proxraw-strength: 'min' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,ph01-proxraw-strength: 'max' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,ph23-proxraw-strength: 'min' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,ph23-proxraw-strength: 'max' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,avg-pos-strength: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'enum', '$ref' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', '$ref' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	'/schemas/types.yaml#definitions/uint32' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	0 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	16 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	64 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	128 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	256 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	512 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	1024 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	4294967295 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,ph01-proxraw-strength: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('min', 'max', 'default', '$ref' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,ph01-proxraw-strength: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	'/schemas/types.yaml#definitions/uint32' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,ph23-resolution: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'enum', '$ref' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', '$ref' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	'/schemas/types.yaml#definitions/uint32' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	8 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	16 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	32 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	64 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	128 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	256 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	512 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	1024 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,ph23-proxraw-strength: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('min', 'max', 'default', '$ref' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,ph23-proxraw-strength: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	'/schemas/types.yaml#definitions/uint32' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,ph01-resolution: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'enum', '$ref' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', '$ref' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	'/schemas/types.yaml#definitions/uint32' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	8 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	16 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	32 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	64 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	128 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	256 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	512 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	1024 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: properties:semtech,startup-sensor: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'enum', '$ref' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', '$ref' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	'/schemas/types.yaml#definitions/uint32' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	0 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	1 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	2 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	3 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml: ignoring, error in schema: properties: semtech,ph23-proxraw-strength
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
Error: Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.example.dts:31.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Documentation/Makefile:39: The 'sphinx-build' command was not found. Make sure you have Sphinx installed and in PATH, or set the SPHINXBUILD make variable to point to the full path of the 'sphinx-build' executable.

Detected OS: DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04.3 LTS".
Warning: better to also install "convert".
Warning: better to also install "dot".
Warning: better to also install "dvipng".
ERROR: please install "ensurepip", otherwise, build won't work.
Warning: better to also install "fonts-dejavu".
Warning: better to also install "fonts-noto-cjk".
Warning: better to also install "latexmk".
Warning: better to also install "rsvg-convert".
Warning: better to also install "xelatex".
You should run:

	sudo apt-get install imagemagick graphviz dvipng python3-venv fonts-dejavu fonts-noto-cjk latexmk librsvg2-bin texlive-xetex
note: If you want pdf, you need at least Sphinx 2.4.4.
To upgrade Sphinx, use:

Can't build as 2 mandatory dependencies are missing at ./scripts/sphinx-pre-install line 953.
	/usr/bin/python3 -m venv sphinx_2.4.4
	. sphinx_2.4.4/bin/activate
	pip install -r ./Documentation/sphinx/requirements.txt

If you want to exit the virtualenv, you can use:
	deactivate

See https://patchwork.ozlabs.org/patch/1565029

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

