Return-Path: <linux-iio+bounces-24216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13550B80065
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B5A3B3E98
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CF22ED85F;
	Wed, 17 Sep 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXtJT7AT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFEF2EC099;
	Wed, 17 Sep 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119498; cv=none; b=Wuf+F0IjCWd5f85OzUWpBrpeSrBF79Qx0Nfa5f0U2DD9i63Fw+pvmKXvrcdgaM9cNnYykA3s566uT7JfQex+Ey1a7x2OVa9kFL4cfHUfcxz5CML4QOdXhfyvo3hmscLJBh9DTOW7uT62VG/Xw4cc9P88fwOcT8//dGatbZjtymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119498; c=relaxed/simple;
	bh=zoFxlFeDfJ9IQFXuKWRcKxPewhHlGZisi9uLW9jTBrQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=gSMImt/TvZBWlxU/1UWb1qG6it+mY+L2+uOnJGeWNrJFPXPwbHQBpCgNXYHQZi8R0VDz5oalpWomqtE3lB0TLXGgumYAhy+gmSE/MT646Ytl1c+Lrh69Fe80I/foU44Ymp8HvZCAEzpinU5bvfOFWw/KwNjotRhF6k5EtVPyj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXtJT7AT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE726C4CEE7;
	Wed, 17 Sep 2025 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758119498;
	bh=zoFxlFeDfJ9IQFXuKWRcKxPewhHlGZisi9uLW9jTBrQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=CXtJT7ATL5/GhBGyCX4rK5FEm5NJqDcC4mp4KE4/nECUiUX8K1j4DOHRm9uc+7yH/
	 k/NJMfCC5zWQpGhGY0Ruoyt2m7TQTQnPsX2tHeq++q8p5+Xo5JGkaZgqjaFr1XcUcb
	 yy07WLEPTC9vG888FW4qwB+gd0dgi/zoqok37i7UspES7bj+uW/ptUhs5LZMrBn4CA
	 oS1djzJfGV8Bn1z9hXOU4+TY7osDywaEVbpFOfL5ZM1FJxLBiNGPTWInaxV2Ya+KzZ
	 qbzw7hepGCOYSMNvPXm0vE/+aYkWNHFTy14s872Oom5zhr9vPuBXw0WIBAMVKmXJet
	 CdHoiLm0Q5vqQ==
Date: Wed, 17 Sep 2025 09:31:36 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
To: Marius Cristea <marius.cristea@microchip.com>
In-Reply-To: <20250917-iio-emc1812-v1-1-0b1f74cea7ab@microchip.com>
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
 <20250917-iio-emc1812-v1-1-0b1f74cea7ab@microchip.com>
Message-Id: <175811949688.2007543.2579513958253379108.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: add support for
 EMC1812


On Wed, 17 Sep 2025 15:21:57 +0300, Marius Cristea wrote:
> This is the devicetree schema for Microchip EMC1812/13/14/15/33
> Multichannel Low-Voltage Remote Diode Sensor Family.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../iio/temperature/microchip,emc1812.yaml         | 223 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 229 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/temperature/microchip,emc1812.yaml: allOf:1:then:patternProperties: '^channel@1$' should not be valid under {'pattern': '^\\^[a-zA-Z0-9,\\-._#@]+\\$$'}
	hint: Fixed strings belong in 'properties', not 'patternProperties'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/temperature/microchip,emc1812.yaml: allOf:3:then:patternProperties: '^channel@4$' should not be valid under {'pattern': '^\\^[a-zA-Z0-9,\\-._#@]+\\$$'}
	hint: Fixed strings belong in 'properties', not 'patternProperties'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/temperature/microchip,emc1812.example.dtb: temperature-sensor@4c (microchip,emc1813): channel@2:reg:0:0: 2 is greater than the maximum of 1
	from schema $id: http://devicetree.org/schemas/iio/temperature/microchip,emc1812.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250917-iio-emc1812-v1-1-0b1f74cea7ab@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


