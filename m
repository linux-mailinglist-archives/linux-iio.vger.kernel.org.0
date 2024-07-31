Return-Path: <linux-iio+bounces-8112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07088943310
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 17:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CF61F28A88
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 15:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C701BBBF7;
	Wed, 31 Jul 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU8/J9El"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213D1799F;
	Wed, 31 Jul 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439188; cv=none; b=C0CuZe2BwE70F3sgbVufZSE9To5DiSC6anlUwirQ+t2MjscFtuWoE/16w+vYVGMcNamy1xiPb+LSZlAuTxz4oX/QTsft4oL6j2GYRiFQS4+nm2F7DO96DsnfnWb1PggQ8Yc47/0Wi3WcXDE9xKobnGeedZr93BSqWjva0TMUWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439188; c=relaxed/simple;
	bh=M4l/MvBogF76/75u0nQ1zmhwmlxJgPNmJ1Dn9CGWYbg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=tjyoOYt1HmPrtgJ4MBoIl9DHop2Is4O8jjjSkjz1JtGOJfD9G7KR9jZrWTIlgWpK4Fgeun0Xi2uW7GspR2NnkNdube1Mj4cs3M+Rn5xxSijP4+4reesUPsSQ3XPxWnURDpGab9iJmqmPKgms/UZNvuQ8Z9RHIsr1PxYJCYM5ALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU8/J9El; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C74C116B1;
	Wed, 31 Jul 2024 15:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722439188;
	bh=M4l/MvBogF76/75u0nQ1zmhwmlxJgPNmJ1Dn9CGWYbg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oU8/J9ElYttHWJsYCZ3hPaH/+UwwToM2MnKMOLV576yB0u3X3sp+amzxgtLggRtx5
	 +yQPMtUpjJs9zAvbU+WiDyPWf6qVT7x3Wgg7oHbKK3Io5LePyvPrsHMUg9+HX3GQDn
	 lVboCjMT7QcSxtwkY8+0AX1nWh5JT+7KP2KLfw3OvW0YwFS38gQZOhBuVqK8S9jAjq
	 P6C2Yg28fuG95mAX1H9OYVk2jiPduLGVclCCOKKsIBFWodSsE3c7AWjv96g3L54yc9
	 1lI63Vz76YDf4HL6tW5d6eHQlkPtdAfkFr2dEJ43CspuNskdsUIgfWscdNAwE/AD12
	 KFKdVeoXIQ2Mg==
Date: Wed, 31 Jul 2024 09:19:46 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-doc@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
In-Reply-To: <20240731-ad7625_r1-v1-1-a1efef5a2ab9@baylibre.com>
References: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
 <20240731-ad7625_r1-v1-1-a1efef5a2ab9@baylibre.com>
Message-Id: <172243918673.970734.12577572126650200260.robh@kernel.org>
Subject: Re: [PATCH RFC 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs


On Wed, 31 Jul 2024 09:48:03 -0400, Trevor Gamblin wrote:
> This adds a binding specification for the Analog Devices Inc. AD7625,
> AD7626, AD7960, and AD7961 ADCs.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 +++++++++++++++++++++
>  MAINTAINERS                                        |   9 ++
>  2 files changed, 185 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml:120:1: [error] syntax error: expected <block end>, but found '-' (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/iio/adc/adi,ad7625.example.dts'
Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml:120:1: did not find expected key
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/iio/adc/adi,ad7625.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml:120:1: did not find expected key
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240731-ad7625_r1-v1-1-a1efef5a2ab9@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


