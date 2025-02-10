Return-Path: <linux-iio+bounces-15285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F51FA2F4FD
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225AB3A58AA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFAB24FBE9;
	Mon, 10 Feb 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UazmHJL+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E11F4629;
	Mon, 10 Feb 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207947; cv=none; b=F9VuIR8lVmjRaoq7B+puDPZXYipveCjcseu5CnEx7Samu17UDzEe2uWpavFrw3qqcUwMKpVD90IzhNVyg4A9RJ795JVj5UZvlhlZ/B87pHUMeJRdaHzJud1nQnClHsPvvOH3G9IC9WuKMfThuvgLFeqSiE93RnPKokLsBaM0Pds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207947; c=relaxed/simple;
	bh=86mtpW/G4xNuSFW1y68vusyqOuEtCXCn2mBA60c/wGc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lPlovNxrnUn7JT8GRdc6zADvZ/ETktVM4m5DAMF2T40hd8IpEgM19NpIPDl7lYEyhw4jBnJMtumq97F9aGBrluS8AdIZ5jvWR6O0ebC+GzdRYBN7Kz1C6rQJO5NXcH/UUyxxovVZE8OguHoysD5I66o+ikaWg9G5CK+1+H8C2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UazmHJL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339F4C4CED1;
	Mon, 10 Feb 2025 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739207946;
	bh=86mtpW/G4xNuSFW1y68vusyqOuEtCXCn2mBA60c/wGc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=UazmHJL+MscqwjOk5sKkRDhpPLij3+E6FOx2nSgjcqDNNidrgaGxFQj+1fDKbOMmV
	 JEOvMacBN3/xGrd6qE57rY3QMVJjOeX6NdS7hjPib72eL9pVv88upSeF2ZadBWuAzo
	 fXyWyEdtLE5E4e9XmsuPP0S5Wp9aCL14HXVXuGNzbFGt2lTeNMfz6/zxBV8PtmjrKV
	 Fn+9ryQrJk2+VWNMyceUbsRrqNx2nGIGxDtcL/G8nl0psslL1/k2p3OsQqCgmxD1j/
	 7xFN0s/enGAiadBQx7sg1KYTK1qlr5GR/tCg4G3qr3pOZ1ftbPqS1Qx8cvYz/FMNvc
	 cTlaz/TiwT49w==
Date: Mon, 10 Feb 2025 11:19:05 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-1-160df18b1da7@baylibre.com>
References: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
 <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-1-160df18b1da7@baylibre.com>
Message-Id: <173920794511.669517.12561205201983200892.robh@kernel.org>
Subject: Re: [PATCH v4 1/9] dt-bindings: iio: dac: adi-axi-adc: add ad7606
 variant


On Mon, 10 Feb 2025 17:10:51 +0100, Angelo Dureghello wrote:
> From: Guillaume Stols <gstols@baylibre.com>
> 
> A new compatible is added to reflect the specialized version of the HDL.
> We use the parallel interface to write the ADC's registers, and
> accessing this interface requires to use ADI_AXI_REG_CONFIG_RD,
> ADI_AXI_REG_CONFIG_WR and ADI_AXI_REG_CONFIG_CTRL in a custom fashion.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   | 70 +++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb: adc@0: pwm-names: ['convst1'] is too short
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250210-wip-bl-ad7606_add_backend_sw_mode-v4-1-160df18b1da7@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


