Return-Path: <linux-iio+bounces-7501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B092E98D
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 15:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB761C22049
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188515ECFD;
	Thu, 11 Jul 2024 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOSfd26U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2C4CE09;
	Thu, 11 Jul 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704724; cv=none; b=tz3DJn5P629Q6vOcm2gwIFbxDXFB9hLfa5Y0u0vOzoGd7ZIhhktkuI6D8PBj0YbhW71xgMQnOFGKXN7cYSBbdCDzHRA6JCWwd15DTXC88dkIrxeXJSA4KrRgKQX3uFzO7ZRX65wtUf78nZl2olPEuByAknI/P0lViUcizc02X4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704724; c=relaxed/simple;
	bh=E2JFJChgR6SYN7VvQ0Zsh/Ba2zODl10+/v1/8FOzLB4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qtHPgw/4+VeOjIdQexHnYQDZ4qjOAxGuk2NFh1iRIp/zLoVuS6jm1gWa/Sho3w/w99D+JQ1tCFltMbD5JGtm5CAM7zS6sGAkCluz+akjMmDi4WhkELXje2IhhrhAWqhnxquMn+4CfQpxeYuO1m68IMCkZl3yC/2ULv9QFZTINFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOSfd26U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB98C116B1;
	Thu, 11 Jul 2024 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720704724;
	bh=E2JFJChgR6SYN7VvQ0Zsh/Ba2zODl10+/v1/8FOzLB4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OOSfd26UyvGbBskF1EdHmCd/hU8tQ263ut3qFCp6kbFvtMOwiXrsksVM1T/O2vOPp
	 IKtexmbmRYK4BiLEC84zKp2xsUI7AS1G3Me+Zy4w4NjBMt41FyvM6eOs5mCu4nsLaH
	 gCweSMskbrXBPBttLvBXhiI2kZBLEGy/p+4zBXvgAJZsbZ45sYnNA+wqWJrr5x1dZI
	 Whs1mIRieccNXpBSKVvO2w2iTD8vQ5/vTbQ2dr0Acy06xhw+7VMplmb4Rqkii+5H3k
	 0MAQ6tq++Mu11R9RMX5/Jy6erYzyXsbAsjNBJt7PI7/QIf3MtCpxFswyrB++VnL1o0
	 9mIH3NooitTEg==
Date: Thu, 11 Jul 2024 07:32:03 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 linux-iio@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
In-Reply-To: <20240711114221.62386-4-kimseer.paller@analog.com>
References: <20240711114221.62386-1-kimseer.paller@analog.com>
 <20240711114221.62386-4-kimseer.paller@analog.com>
Message-Id: <172070472328.2037442.12046185046472232081.robh@kernel.org>
Subject: Re: [PATCH v6 3/6] dt-bindings: iio: dac: Generalize DAC common
 properties


On Thu, 11 Jul 2024 19:42:18 +0800, Kim Seer Paller wrote:
> Introduce a generalized DAC binding that can be used by DACs that have
> similar properties adding output-range-microamp and output-range-microvolt.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/dac.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,max11410.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,max11410.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,max11410.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.example.dtb: channel@30: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.example.dtb: channel@31: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.example.dtb: channel@38: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1015.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1015.example.dtb: channel@4: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dtb: channel@4: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dtb: channel@5: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dtb: channel@6: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dtb: channel@7: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.example.dtb: channel@4: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads7924.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads7924.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads7924.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads7924.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.example.dtb: channel@11: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.example.dtb: channel@22: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.example.dtb: channel@23: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7292.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7292.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7292.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7292.example.dtb: channel@4: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7292.example.dtb: channel@5: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7292.example.dtb: channel@6: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7292.example.dtb: channel@7: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dtb: channel@4: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.example.dtb: channel@4: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.example.dtb: channel@5: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.example.dtb: channel@6: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.example.dtb: channel@7: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7124.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7124.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7124.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7124.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/maxim,max34408.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/maxim,max34408.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dtb: channel@39: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dtb: channel@9: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dtb: channel@a: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dtb: channel@e: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dtb: channel@f: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dtb: channel@44: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dtb: channel@47: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb: channel@4: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb: channel@5: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb: channel@6: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.example.dtb: channel@7: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.example.dtb: channel@13: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.example.dtb: channel@14: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.example.dtb: channel@15: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5755.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5755.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5755.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5755.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dtb: channel@4: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dtb: channel@5: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@4: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@5: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@6: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@7: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: channel@6: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.example.dtb: channel@16: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.example.dtb: channel@17: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.example.dtb: channel@19: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/ti,tmp421.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/ti,tmp421.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,ltc2991.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,ltc2991.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,ltc2991.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,ltc2991.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/ti,tmp464.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/ti,tmp464.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/ti,tmp464.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/national,lm90.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/national,lm90.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/national,lm90.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,ltc2992.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,ltc2992.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/gateworks-gsc.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/gateworks-gsc.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/gateworks-gsc.example.dtb: channel@b: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.example.dtb: channel@6: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.example.dtb: channel@4f: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-ldb.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-ldb.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-pixel-combiner.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/fsl,imx8qxp-pixel-combiner.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/iqs269a.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/iqs269a.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/iqs269a.example.dtb: channel@2: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/iqs269a.example.dtb: channel@3: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/iqs269a.example.dtb: channel@4: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/iqs269a.example.dtb: channel@5: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/iqs269a.example.dtb: channel@6: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/iqs269a.example.dtb: channel@7: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.example.dtb: channel@0: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.example.dtb: channel@1: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.example.dtb: channel@4c: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dtb: channel@4f: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dtb: channel@44: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dtb: channel@147: 'oneOf' conditional failed, one must be fixed:
	'output-range-microamp' is a required property
	'output-range-microvolt' is a required property
	from schema $id: http://devicetree.org/schemas/iio/dac/dac.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240711114221.62386-4-kimseer.paller@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


