Return-Path: <linux-iio+bounces-16819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4987A60B4B
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 09:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EB03AC7FA
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75E619DF4B;
	Fri, 14 Mar 2025 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ernyX5Ah"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE7EAD7;
	Fri, 14 Mar 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940728; cv=none; b=AtpbLncuKC0vndiTDTV7aFJprSe+wU29+TaAyxhpDwIfA7SyNnLDgMFuTv4pLH0k3r0t7NEN1f3U8NEfAxKl/0rcisgvov27I2tg2tW1UMEXIAx2RtQ2HsI1Wh36RVUxf9RS2jD3cUNLhxUyLiyw+H+l8tt8pMEx4orADQ5v0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940728; c=relaxed/simple;
	bh=0n02eITWIzf/++JmvY0KKczZbmpT4M52h+UOP3gyX1g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FuSGHdXI2UcyOf/54kGDkaeD8CZCvjXOOovNTB6NcnLFKeHLkeBLqprkK86/P2gEkTt93ZgZzcbpFq0eekRtxp5kKKayc688uMEkZ6wmA7XLXweTdhyS8QBuEd6FS/1rZ/wrPiz1JO6na81yXvuVrZZkHSwkLKF9XQIEtqorVdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ernyX5Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DF0C4CEE3;
	Fri, 14 Mar 2025 08:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741940727;
	bh=0n02eITWIzf/++JmvY0KKczZbmpT4M52h+UOP3gyX1g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ernyX5AhaKGHwsNYKemwwl6b7FOv05dkpRXhpU5QS+zhW5D7DNpEo5YRcsxACotTO
	 dxDHIIcVX9E10h2Rzz5V4Kq96KUxuFuxvpb0S6mVtXF+Z5vYsWxpHGxjAMzuMDu0+C
	 StPKm+3Rz0/sbTXytr5TzT6kF9aATfKUbLTLUSjJQbghCxcokeUANygDzT8bohdsFK
	 XLQ2ubvepmUDzbNSJeQ4CYGwI4QpYthXPSdS9ni+dgdfKPhDzLJQFoe12XoHlUp/vw
	 jX28yQDa5nkawQdXf1hGV3ASGoxbetnLybGPSphwAt079jT71u8Btk+GbGko8d6bNA
	 Q7MHme6WdhGsg==
Date: Fri, 14 Mar 2025 03:25:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-input@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Chen Zhong <chen.zhong@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Sen Chu <shen.chu@mediatek.com>
To: "Lu.Tang" <Lu.Tang@mediatek.com>
In-Reply-To: <20250314073307.25092-6-Lu.Tang@mediatek.com>
References: <20250314073307.25092-1-Lu.Tang@mediatek.com>
 <20250314073307.25092-6-Lu.Tang@mediatek.com>
Message-Id: <174194072655.964967.9270640013940045148.robh@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: pmic: mediatek: Add pmic documents


On Fri, 14 Mar 2025 15:32:31 +0800, Lu.Tang wrote:
> Add new pmic mfd and adc documents for mt8196
> 
> Signed-off-by: Lu.Tang <Lu.Tang@mediatek.com>
> ---
>  .../iio/adc/mediatek,spmi-pmic-auxadc.yaml    |  31 ++++
>  .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
>  .../bindings/mfd/mediatek,mt6685.yaml         |  50 +++++
>  .../bindings/mfd/mediatek,spmi-pmic.yaml      | 173 ++++++++++++++++++
>  .../pinctrl/mediatek,mt65xx-pinctrl.yaml      |   1 +
>  5 files changed, 256 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,spmi-pmic-auxadc.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6685.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/mediatek,mt6685.example.dts:25.17-31: Warning (reg_format): /example-0/spmi/mfd@9:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/mfd/mediatek,mt6685.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/mediatek,mt6685.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/mediatek,mt6685.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/mediatek,mt6685.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/mediatek,mt6685.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/mediatek,mt6685.example.dts:23.19-28.15: Warning (avoid_default_addr_size): /example-0/spmi/mfd@9: Relying on default #address-cells value
Documentation/devicetree/bindings/mfd/mediatek,mt6685.example.dts:23.19-28.15: Warning (avoid_default_addr_size): /example-0/spmi/mfd@9: Relying on default #size-cells value
Documentation/devicetree/bindings/mfd/mediatek,mt6685.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6685.example.dtb: mfd@9: '#address-cells', '#size-cells', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6685.yaml#
Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.example.dts:31.17-31: Warning (reg_format): /example-0/spmi/pmic@4:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.example.dts:29.31-109.15: Warning (avoid_default_addr_size): /example-0/spmi/pmic@4: Relying on default #address-cells value
Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.example.dts:29.31-109.15: Warning (avoid_default_addr_size): /example-0/spmi/pmic@4: Relying on default #size-cells value
Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.example.dtb: pmic@4: '#address-cells', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,spmi-pmic.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250314073307.25092-6-Lu.Tang@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


