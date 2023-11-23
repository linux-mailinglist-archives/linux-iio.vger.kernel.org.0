Return-Path: <linux-iio+bounces-287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3CE7F628B
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 16:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278201C21042
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0595835EF6;
	Thu, 23 Nov 2023 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD010D47;
	Thu, 23 Nov 2023 07:17:15 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-35c37437974so1705915ab.3;
        Thu, 23 Nov 2023 07:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700752635; x=1701357435;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+yY19p563G8OSSXylhy9KOWXS629PQLFFG7Uq17T5RU=;
        b=odqt9PpHNwYscwcWkLdkN7xXKerGAqpLXO3bTcE1qRNXZkpjycEWheYeW4RjylxPKV
         qqhYw5zN5ZaXIjhfWy9nd1TXpVq9fhPNTXRDfHAZwGZQktAvHNTvfd3MndXD1IEApGmg
         tmfWvzt21XQgHf7+XoY/tCbt1jar+7iGMGGtbnbqWqipJaORCN/o9DGJ05TeXGmZDl1x
         l3AgOm8BvgLnLQiH7rsaGpnWEk6QOW0Wu1oOirvrdXmjG3bZcYJPxGup0iRIjkeCe71k
         DTWwTNU8it/L2BbBGhBIePNkgfyuGOs4xhqW+0oY0n150DbL14VqUB8mt6Gi/k/opXiK
         7U7Q==
X-Gm-Message-State: AOJu0Yw2cNzccosBldBM8YZOOKPG+kHXlhxTxfAAA6poW6UCzeJzkK6i
	5A1sRYGn2raTzxPp4HwXXxTsuIYpOg==
X-Google-Smtp-Source: AGHT+IG+g4c8+ocqLetuuJmohu+2ppSGCRxT1hmFGAlnRWUN7YB9gxhSO4PgUq/+5rDqREknCEfiJA==
X-Received: by 2002:a05:6e02:14c:b0:35a:fc0c:ac89 with SMTP id j12-20020a056e02014c00b0035afc0cac89mr5928449ilr.24.1700752634917;
        Thu, 23 Nov 2023 07:17:14 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id bz10-20020a056e02268a00b003594b40e4e2sm430380ilb.0.2023.11.23.07.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 07:17:14 -0800 (PST)
Received: (nullmailer pid 1371344 invoked by uid 1000);
	Thu, 23 Nov 2023 15:17:11 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: mitrutzceclan <mitrutzceclan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Haibo Chen <haibo.chen@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>, ChiaEn Wu <chiaen_wu@richtek.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, brgl@bgdev.pl, Michael Walle <michael@walle.cc>, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>, linux-gpio@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>, andy@kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-iio@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20231123140320.30409-1-user@HYB-hhAwRlzzMZb>
References: <20231123140320.30409-1-user@HYB-hhAwRlzzMZb>
Message-Id: <170075263187.1371189.16895617630597856845.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: adc: add AD7173
Date: Thu, 23 Nov 2023 08:17:11 -0700


On Thu, 23 Nov 2023 16:02:55 +0200, mitrutzceclan wrote:
> From: Dumitru Ceclan <mitrutzceclan@gmail.com>
> 
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
> V4 -> V5
>  - Use string enum instead of integers for "adi,reference-select"
>  - Fix conditional checking in regards to compatible
> 
>  .../bindings/iio/adc/adi,ad7173.yaml          | 169 ++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: properties:required: ['compatible', 'reg', 'interrupts'] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: properties: 'required' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: properties:required: ['compatible', 'reg', 'interrupts'] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231123140320.30409-1-user@HYB-hhAwRlzzMZb

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


