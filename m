Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F199D3D1BA1
	for <lists+linux-iio@lfdr.de>; Thu, 22 Jul 2021 04:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhGVB3Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 21:29:24 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:35332 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhGVB3X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 21:29:23 -0400
Received: by mail-io1-f51.google.com with SMTP id d9so4633179ioo.2;
        Wed, 21 Jul 2021 19:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=XI6tuL7/pBray3N0tX9rszM1IBJlHOCQO5uHh9acEo4=;
        b=FCL10oc4gQvZrtepYM6PCht54qbxGMIHiVA2FezPdQBbHZznDvszBfYztg1Z1N23Az
         k8SYG9Pxfjl3HTkk74qDZzc4vYvIW2vziIcCSvcRQSRbwJciaynpI2cZyPQy0aGo944K
         KzV+L05wm9eZJZPYgu2/ahtu73ab5N3ZUMD97yVRpDI7Q2wxxY5qwYSVF8hbBilm3t0A
         Kfx0ejaWQQvJKMzshP+AK64Z788HqQicbzVJThEMOgDXuqnIJGZbw/mVf9vhErk8DiLb
         J2dh7Jr8J3aF19+061GI70TofvvMTXcvTulW+/TmKvFtXhz/im1MD4Eg77/jYf3DCEMv
         6YqA==
X-Gm-Message-State: AOAM533//9HzZS6gLq+pt2LM/59K4R/GhA/+ACCm2s1y2wulEfLszkIZ
        C2Y9uyaYpHLEXbzUFGO4QQ==
X-Google-Smtp-Source: ABdhPJwXoy7EEZp6Wh13QVY0SHOwBaW96b1k1tbwI0rV34cnGkXvWAGvtONpzuXfoWM82+w6jJOlqQ==
X-Received: by 2002:a05:6638:3a12:: with SMTP id j18mr34051615jaj.75.1626919799407;
        Wed, 21 Jul 2021 19:09:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c7sm13492038ile.69.2021.07.21.19.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:09:58 -0700 (PDT)
Received: (nullmailer pid 3145318 invoked by uid 1000);
        Thu, 22 Jul 2021 02:09:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     citral23 <cbranchereau@gmail.com>
Cc:     lars@metafoo.de, contact@artur-rojek.eu,
        linux-mips@vger.kernel.org, paul@crapouillou.net, jic23@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210721105317.36742-7-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com> <20210721105317.36742-7-cbranchereau@gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc Documentation
Date:   Wed, 21 Jul 2021 20:09:56 -0600
Message-Id: <1626919796.931159.3145317.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Jul 2021 12:53:17 +0200, citral23 wrote:
> Signed-off-by: citral23 <cbranchereau@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ingenic,adc.yaml         | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml: properties:ingenic,use-internal-divider: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml: properties:ingenic,use-internal-divider: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml: properties:ingenic,use-internal-divider: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml: ignoring, error in schema: properties: ingenic,use-internal-divider
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
Documentation/devicetree/bindings/iio/adc/ingenic,adc.example.dt.yaml:0:0: /example-0/adc@10070000: failed to match any schema with compatible: ['ingenic,jz4740-adc']
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1508137

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

