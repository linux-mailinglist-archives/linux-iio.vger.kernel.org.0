Return-Path: <linux-iio+bounces-909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 664C0811BAC
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 18:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBA91F21594
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 17:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948E959B71;
	Wed, 13 Dec 2023 17:55:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6FCD49;
	Wed, 13 Dec 2023 09:55:38 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58d08497aa1so4613524eaf.0;
        Wed, 13 Dec 2023 09:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490137; x=1703094937;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iQGtdcuwZQtYi+ph6QyuuJNxkINZNun39WyUzZSioII=;
        b=fepmZoDprD3yvJQPMh5HjnfeGgNnSPM+RTYu3YbocEV5v4pxarGa0f1oQV07XPkabj
         u3DZPEB24BBHXDv1Z56NKEY8dKBRI16f+KXYhPIDwY6148muWxzeNCLu43UUKbvVWD3W
         Mb6OegYAdUsGgpaz7rIEjx2xDZyLbRrftOKx4JaMvOE4kjUnBY+6Uhlu6OvsKNood7qx
         mUHaE7ZMcL+NB4Y7cXaFYc1QYBVBhaz3u8CyGFv/cSil3PQENdaVZ/ncW7RSmI5un/tM
         Bzw9eJIYHwo1r2SPSO5DBxo6uNuTdT4GtLDXELRDMZjT8Ck2ga/q9oKonZZOe7pbHA2o
         5gCw==
X-Gm-Message-State: AOJu0YwZ6s+xvVHVPLne2+3vu0xqDSNIVh34QOIT0gVbPb3Z/1RzC0r2
	rRjoLiNbtCVQrGLGJdkIPKMxK/C3BQ==
X-Google-Smtp-Source: AGHT+IGrM0+7Hame/CwYfbqJzlDDo/dTHLNEVyFkVVHG6/yf2wP/8XRvaLTO2VSzJMHtG1hHNOfrzw==
X-Received: by 2002:a05:6820:22a4:b0:590:16e7:d767 with SMTP id ck36-20020a05682022a400b0059016e7d767mr6252763oob.3.1702490137241;
        Wed, 13 Dec 2023 09:55:37 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v15-20020a05683011cf00b006ce2db9e6c4sm2854965otq.36.2023.12.13.09.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:55:36 -0800 (PST)
Received: (nullmailer pid 1591681 invoked by uid 1000);
	Wed, 13 Dec 2023 17:55:35 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
In-Reply-To: <20231213-dev-iio-backend-v3-1-bb9f12a5c6dc@analog.com>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
 <20231213-dev-iio-backend-v3-1-bb9f12a5c6dc@analog.com>
Message-Id: <170249013568.1591665.1236116981497856652.robh@kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
Date: Wed, 13 Dec 2023 11:55:35 -0600


On Wed, 13 Dec 2023 16:02:32 +0100, Nuno Sa wrote:
> The ad9467 will make use of the new IIO backend framework which is a
> provider - consumer interface where IIO backends provide services to
> consumers. As such, and being this device a consumer,  add the new
> generic io-backend property to the bindings.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml: io-backends: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231213-dev-iio-backend-v3-1-bb9f12a5c6dc@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


