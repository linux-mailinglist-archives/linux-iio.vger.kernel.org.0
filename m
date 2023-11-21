Return-Path: <linux-iio+bounces-229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E737F2B10
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 11:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F10A282073
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 10:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352E1482CD;
	Tue, 21 Nov 2023 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5AB95;
	Tue, 21 Nov 2023 02:57:27 -0800 (PST)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35b2144232bso784215ab.3;
        Tue, 21 Nov 2023 02:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564246; x=1701169046;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IWHRjyzNCrwuh+4RgzXhICmV3TY97RZEZ35SyiqAe3c=;
        b=ODy4zyV51nwCSIYN8iYewQFnx9SM2/868fCC9HQDmtsIeQLJUf1xJ0UMxa2fEfMY6o
         Fuy1G4eNy4jb3LkKSMCxRca8w6XFiMbHPYYx7tYcbjN5H9MbbOWqPUa4iODRIRqQkbLp
         +pFwwWrYMLFfFGBrTt330mvH47tZBfruev9KguZkxepAYcmn7cxhAaIDE/UoVKga2Btz
         bOMTr8q01ZZd9MCcGf9q0iDZ+MOgSdKa0EZQkdWcpOG9yMFMQRxxtHZE467qYNAwsais
         uklxW3YbGa0FQCYKjDhUgMf6HpDQufHltx6iNl05G+hCHNaxV7M+KnNLG8kkPSzke1x1
         msTg==
X-Gm-Message-State: AOJu0YzTCE6MRUxtuPVq+xyrNlUew8pjKF70u7eg/BG+h8Lpzd/J1Lq1
	YW3XXfHBeTgfdcbt4DPBTiTzXiIQNQ==
X-Google-Smtp-Source: AGHT+IE4vUY5D8ruxozBz7YxFXj7QoJPOhStL5fM6GhhgtGsTmq8vQk09z4qIRi7Nc4M6dDvhUx8wg==
X-Received: by 2002:a92:d0c8:0:b0:35b:110f:8127 with SMTP id y8-20020a92d0c8000000b0035b110f8127mr1829805ila.26.1700564246331;
        Tue, 21 Nov 2023 02:57:26 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z6-20020a023446000000b004665bc0a20esm1072609jaz.172.2023.11.21.02.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:57:25 -0800 (PST)
Received: (nullmailer pid 1245593 invoked by uid 1000);
	Tue, 21 Nov 2023 10:57:21 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20231121100012.112861-1-kimseer.paller@analog.com>
References: <20231121100012.112861-1-kimseer.paller@analog.com>
Message-Id: <170056424171.1245555.12202034703605429855.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: frequency: add admfm2000
Date: Tue, 21 Nov 2023 03:57:21 -0700


On Tue, 21 Nov 2023 18:00:11 +0800, Kim Seer Paller wrote:
> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V1 -> V2: Removed '|' after description. Specified the pins connected to
>           the GPIOs. Added additionalProperties: false. Changed node name to gpio.
>           Aligned < syntax with the previous syntax in the examples.
> 
>  .../bindings/iio/frequency/adi,admfm2000.yaml | 130 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml:14:5: [warning] wrong indentation: expected 2 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231121100012.112861-1-kimseer.paller@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


