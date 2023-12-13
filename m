Return-Path: <linux-iio+bounces-636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966680585A
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 16:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2CF1C210D7
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AAB68E8D;
	Tue,  5 Dec 2023 15:17:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D1BA;
	Tue,  5 Dec 2023 07:16:55 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d8d28e4bbeso1878116a34.3;
        Tue, 05 Dec 2023 07:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701789414; x=1702394214;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PIL2R5QWcyrDJIIlZYpvgWP7i5DDM3sfGQ6GQVJmqyE=;
        b=wnuY7JIcN4LZuwOOMM1JkiZcNOVPGx8rBhnLmI0Z54jC3VH9FB+n7wtEJE+T7qHc3c
         lC3nxo3m7db0tp/eZsxDDPc7zPTfBMqlxDNz5aFdIZfz7lPMKEupbIwodkciC52w6AMX
         xM5dqdPmNUQgz5oSR9sDLhrx836KDhXSimGiOFmuUM+kUS6hsePt8JQZ/IyGdMg0JD4k
         uQOPNqTvsQrEe6mcJdM5cQl1GXZJXnehE8Z4VIcp6fyELdAXy7mZR6SftP6eRQVHRYRt
         C4Jz2uWjZ+1tv2YnZMLPKMo6PEhJLPakqwMbchpE/ULOkrOYwoMwRXDyvnGSEnlMybFJ
         Eq/A==
X-Gm-Message-State: AOJu0Yxnu5I3izaBe1G4IYU4/wNtHd8UGaY99AdDW8N+LEdkB3yr87uT
	PyQ5SlcDyuIf6uu4j5jmWg==
X-Google-Smtp-Source: AGHT+IEhOsKceKiNrJehVdlZj58kZKlSDVOmPMSaw8HpLasVjTg3PdH3MbioSc00+OCdV1KBAtZBvA==
X-Received: by 2002:a05:6830:43a8:b0:6bd:152f:9918 with SMTP id s40-20020a05683043a800b006bd152f9918mr6197492otv.14.1701789412544;
        Tue, 05 Dec 2023 07:16:52 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o11-20020a0568301c4b00b006d87c7497e7sm1454992otg.1.2023.12.05.07.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:16:51 -0800 (PST)
Received: (nullmailer pid 3083183 invoked by uid 1000);
	Tue, 05 Dec 2023 15:16:50 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: devicetree@vger.kernel.org, ChiaEn Wu <chiaen_wu@richtek.com>, linux-kernel@vger.kernel.org, Ceclan Dumitru <dumitru.ceclan@analog.com>, Jonathan Cameron <jic23@kernel.org>, andy@kernel.org, linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>, linus.walleij@linaro.org, Niklas Schnelle <schnelle@linux.ibm.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Rob Herring <robh+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, brgl@bgdev.pl, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>, Michael Walle <michael@walle.cc>
In-Reply-To: <20231205134223.17335-1-mitrutzceclan@gmail.com>
References: <20231205134223.17335-1-mitrutzceclan@gmail.com>
Message-Id: <170178941047.3083151.15161174214123068689.robh@kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: adc: add AD7173
Date: Tue, 05 Dec 2023 09:16:50 -0600


On Tue, 05 Dec 2023 15:42:20 +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>  .../bindings/iio/adc/adi,ad7173.yaml          | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231205134223.17335-1-mitrutzceclan@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


