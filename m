Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C041E43E8C9
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 21:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhJ1TLS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 15:11:18 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44978 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1TLR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 15:11:17 -0400
Received: by mail-oi1-f174.google.com with SMTP id y207so9676502oia.11;
        Thu, 28 Oct 2021 12:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=XmEzD8UGM0B6lT2koXtP1BSAMmUSnegly1xx1AG9g2c=;
        b=3rZzKj4N3J7MgZ/LN5ym6F+1DMdHGR5VIQKaf920o87PNPScZUjDuXe0XsPnA3Q+PK
         ZSUlQPuGAj5jXZdt9icPHT4tpfYK7tCInPCpp+IODLwuLgUnmeC93Ynn/1gJZwuTLI3i
         AUqDqq4SvSrGl7bOTPw0iAXmNh4/V5TL7UPqpRIDI3iy4usVHy8X1/rBkYClZlzJ3GFb
         rLtrYma6HHMnG3cUyV1bA0teNFVNoO57JuhmvY5NO2a0UUyzystnn63r9tk1ecm4SiAA
         FQKX/fJJTGAX2Or4b0LgmFCbabyKzlyle9FI6qX0RqaMxEomOHLatPfTi7goxAGsMXVn
         d3sg==
X-Gm-Message-State: AOAM533uU1cEPTwFyDq2a4ZiU0iOR8SwmkyWzuLYEGX5xh89v0Rk1nc3
        fsNTYh6QUi5Zw/yLrGwwvg==
X-Google-Smtp-Source: ABdhPJyk3XPWRtCE8GCcVYJDoWZdr+u2qz+lIrXlSKuZERbw161dS8WkqAlD/UaQMrw4XlOhPGM0NA==
X-Received: by 2002:aca:5b56:: with SMTP id p83mr4513069oib.119.1635448129942;
        Thu, 28 Oct 2021 12:08:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d4sm1610105otu.57.2021.10.28.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 12:08:48 -0700 (PDT)
Received: (nullmailer pid 409848 invoked by uid 1000);
        Thu, 28 Oct 2021 19:08:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        cosmin.tanislav@analog.com, Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
In-Reply-To: <20211028135608.3666940-2-demonsingur@gmail.com>
References: <20211028134849.3664969-1-demonsingur@gmail.com> <20211028135608.3666940-1-demonsingur@gmail.com> <20211028135608.3666940-2-demonsingur@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: add AD74413R
Date:   Thu, 28 Oct 2021 14:08:48 -0500
Message-Id: <1635448128.075316.409847.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 16:56:04 +0300, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Add device tree bindings for AD74413R.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/addac/adi,ad74413r.yaml      | 163 ++++++++++++++++++
>  include/dt-bindings/iio/addac/adi,ad74413r.h  |  30 ++++
>  2 files changed, 193 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>  create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: patternProperties:^channel@[0-3]$:properties:reg: 'minimum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: patternProperties:^channel@[0-3]$:properties:reg: 'maximum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: patternProperties:^channel@[0-3]$:properties:adi,ch-func: 'minimum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: patternProperties:^channel@[0-3]$:properties:adi,ch-func: 'maximum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: patternProperties:^channel@[0-3]$:properties:adi,gpo-config: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: patternProperties:^channel@[0-3]$:properties:reg: 'anyOf' conditional failed, one must be fixed:
	'minimum' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'maximum' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('minimum', 'maximum' were unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: properties:adi,rsense-resistance-ohms: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml: ignoring, error in schema: patternProperties: ^channel@[0-3]$: properties: adi,gpo-config
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
Error: Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dts:23.32-33 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1547508

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

