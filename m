Return-Path: <linux-iio+bounces-13314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECFE9EB0D6
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 13:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FAA169D71
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F1519F438;
	Tue, 10 Dec 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScLNuD8t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82323DE98;
	Tue, 10 Dec 2024 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833880; cv=none; b=DCQ3+avgAU9UbzcVRH7nsJD9hTvWv9AEU0ZN2nscJDwWBcciyG4YZaipicvqkqPRRAYsiZTKHURPh0F7+EXJ14C3/fkB3drMH/bqYNF7zbsOgvRNa0JOe1AhGeCn7sRL16TZYcecUo9l/YoH12/E2d+J7WZhMFo2vJ6tR1t08+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833880; c=relaxed/simple;
	bh=DlV0RhTFpJR8lNB52CQEGejifECY3xTyNALQDBsxc2A=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aPzAaPMnDwAPdkZTJ/xx/zt4L5DNKdtJMSjM1YSY1yjIrqwgz3lxWiaW5fAFIijQQXwQ7yOR3awyrugVhN6LEhlo3qa7iauUJuxN6S3qMDPl7tWAfsb3hkVWFw68yRrXG1d0jb7kRoZksnJUN84uF12SAtQizxQKr4wWJ00ZlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScLNuD8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCE4C4CED6;
	Tue, 10 Dec 2024 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733833879;
	bh=DlV0RhTFpJR8lNB52CQEGejifECY3xTyNALQDBsxc2A=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ScLNuD8tYrT8McxlZ622hN2sVkB6DmgdymSvQtHnnFgsCjVd/BwbUusOAqq6kEWJg
	 /WUWyj0fe1zA5k0ptIcipmO01L01uNTrMOWscD9p5X04/fxy6EvIOOqHoqB42twnpO
	 scbuOaO/5017aetMexXvxG3PDjV8Uzv4RsBnZ2+1Ngy1/OpubM+/eoVxif/MWbXNee
	 YxjveOWraE4QI20zuYDP49F6wtUcntkC7Y3urGbDViECvS2Cee4SuAB9RWZ2j/GYsU
	 D+AiEKP6knG+3KWhvpbOsKWmmScLtK70nlTMwdXBrJGgr3zF+7bpQGJP2wWPhuqGNt
	 ixxCuaXc/NZDg==
Date: Tue, 10 Dec 2024 06:31:17 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: aardelean@baylibre.com, Nuno Sa <nuno.sa@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
 dlechner@baylibre.com, jstephan@baylibre.com, 
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, adureghello@baylibre.com, 
 Michael Hennerich <michael.hennerich@analog.com>
To: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-2-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
 <20241210-ad7606_add_iio_backend_software_mode-v2-2-6619c3e50d81@baylibre.com>
Message-Id: <173383387775.3106743.13439791684053589196.robh@kernel.org>
Subject: Re: [PATCH v2 2/9] dt-bindings: iio: dac: adi-axi-adc: Add ad7606
 variant


On Tue, 10 Dec 2024 10:46:42 +0000, Guillaume Stols wrote:
> A new compatible is added to reflect the specialized version of the HDL.
> We use the parallel interface to write the ADC's registers, and
> accessing this interface requires to use
> ADI_AXI_REG_CONFIG_RD,ADI_AXI_REG_CONFIG_WR and ADI_AXI_REG_CONFIG_CTRL
> in a custom fashion.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb: axi-adc@44a00000: '#address-cells', '#size-cells', 'adi_adc@0' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,axi-adc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb: adi_adc@0: pwm-names:0: 'convst1' was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb: adi_adc@0: pwm-names: ['cnvst_n'] is too short
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb: adi_adc@0: 'vdrive-supply' is a required property
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241210-ad7606_add_iio_backend_software_mode-v2-2-6619c3e50d81@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


