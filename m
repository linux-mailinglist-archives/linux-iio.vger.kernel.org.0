Return-Path: <linux-iio+bounces-1164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7A881A5C1
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 17:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392601C225F7
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F38846544;
	Wed, 20 Dec 2023 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXv6r7np"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C34645F;
	Wed, 20 Dec 2023 16:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44E9C433C8;
	Wed, 20 Dec 2023 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703091386;
	bh=TLXV2ADb5J8JDHjsS/AkjVpwjgDSB5XD0RxrIDny//g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rXv6r7npm46RE/ucuLLJO8lpq5fd/23hYUca/zFPSNobcouc1M/hoSLCkbAw8CPYW
	 qSWdDFRt9Ln/742NjtbTz+SUxMSF1kT6B+ndDMIYgwjPnRG7YEPTiblt9GNNKKbUEO
	 H44IgBByN2wrnOhDh8vg3ZTT1rT7l9Ms0FWj0AOcqmABMvXQV4UyNUffAQk3fBNcAX
	 GpB76TvzwuHiN5aeKeTtReqbe+cEazBYw4+Iusw4//48gG0L1eQrqnXeGyM24XmniI
	 P/JmH61j43D4sq9ZPbhr6vQUxrXS2OiVOS7lq4pUnBIUcZnYsIm0X5JYaoz1Lu+kJ2
	 tuGfQ4drpYfDQ==
Received: (nullmailer pid 683161 invoked by uid 1000);
	Wed, 20 Dec 2023 16:56:24 -0000
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20231220-iio-backend-v4-1-998e9148b692@analog.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
 <20231220-iio-backend-v4-1-998e9148b692@analog.com>
Message-Id: <170309138435.683144.1812971328993385650.robh@kernel.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
Date: Wed, 20 Dec 2023 10:56:24 -0600


On Wed, 20 Dec 2023 16:34:04 +0100, Nuno Sa wrote:
> The ad9467 will make use of the new IIO backend framework which is a
> provider - consumer interface where IIO backends provide services to
> consumers. As such, and being this device a consumer,  add the new
> generic io-backend property to the bindings.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml: io-backends: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231220-iio-backend-v4-1-998e9148b692@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


