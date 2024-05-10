Return-Path: <linux-iio+bounces-4920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA678C1EE8
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 09:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8B01C20E35
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 07:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594515ECC1;
	Fri, 10 May 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0tl1lcq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C81DFEA;
	Fri, 10 May 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325685; cv=none; b=jJ3SK9wzBauK6HGs8RivdczDS1klwiRP6KEK1+ky6Hp715DWsXWJOsuGA3I7TxRV7YR1LOGJ3V3ApdTDPTVkGLW3wLt8+ygOPkBbebTF9YnBmZIgL8SEYDvh4a5ATvhfkXMTeFo4A13sEtos8lIWlWTn6RhcCtQqqzkIIyOfegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325685; c=relaxed/simple;
	bh=CRlufBsEbWIRod4jJHaad7SQ+08UlCRsxSu1B2VBLhU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=smWGJ1c4Eqk7C80OdudZfbDGUwJ0oYLJcYQKTI5sHQKdWVzcwKXrHkqRH64sn04dUXLeOVD3NkGxS2peKr9Q660bblSYClUX3OYdpJt62bgSnQ/G9tsI8qKMHy50DltzUwEogVGl6bnXLvGqAEfdHVZfAbkSH4Up7T9ww9uLd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0tl1lcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF0EC113CC;
	Fri, 10 May 2024 07:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715325685;
	bh=CRlufBsEbWIRod4jJHaad7SQ+08UlCRsxSu1B2VBLhU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=S0tl1lcqj8Bik0LppcLisGZoo55rD2MWAjidKwdsqcbtbwVbnWxbeHvUw10jjb/Mh
	 /5DfT175Fq4UgJZOhEH5L+ZotDXvYZBz0z0b4+rjMbcA2WyDLq5nDPfxQC0EcljT1f
	 w+9az8cunxBnLhabmhPvLLPqQYOTB2fxqPLz81FILN0pJ6dr77QHJ834XhtYzoJPJy
	 SkfB7Iu4miTaMNy5psF3H0g+W3+m7st8tg1Vw5iQYMmwf4vYYxfPnO0Kh8/cRNsLt7
	 l7of/QDBntdjgOGKRzOGrn8wkZQy2/280FBR5KH/+TXRybYmXt4jPh0W46k0kD0MNw
	 5Urv4wg1vF3Bw==
Date: Fri, 10 May 2024 02:21:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, Guenter Roeck <linux@roeck-us.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20240510064053.278257-2-Mariel.Tinaco@analog.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
 <20240510064053.278257-2-Mariel.Tinaco@analog.com>
Message-Id: <171532568373.3099714.15391241523800053923.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add docs for ad8460


On Fri, 10 May 2024 14:40:52 +0800, Mariel Tinaco wrote:
> This adds the bindings documentation for the 14-bit
> High Voltage, High Current, Waveform Generator
> Digital-to-Analog converter.
> 
> Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad8460.yaml          | 67 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dts:22.17-27: Warning (reg_format): /example-0/spi/dac@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dts:19.13-29.11: Warning (spi_bus_bridge): /example-0/spi: incorrect #address-cells for SPI bus
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dts:19.13-29.11: Warning (spi_bus_bridge): /example-0/spi: incorrect #size-cells for SPI bus
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dts:20.19-28.15: Warning (avoid_default_addr_size): /example-0/spi/dac@0: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dts:20.19-28.15: Warning (avoid_default_addr_size): /example-0/spi/dac@0: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/dac/adi,ad8460.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240510064053.278257-2-Mariel.Tinaco@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


