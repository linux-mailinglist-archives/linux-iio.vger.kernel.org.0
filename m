Return-Path: <linux-iio+bounces-24975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF553BD0652
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0CDB4EB621
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E78E2E5415;
	Sun, 12 Oct 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I61ilg8x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC61EF091;
	Sun, 12 Oct 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760283864; cv=none; b=WLq4IWvggCffY6wDnx2R2rAykXC9kK+vnu++4DQ6jnZrpdIjoU8/y9CDbt5ar7FBYZ+4JStJsDD0Q2MZbGHVIDTMEOcK1H88AiXYYhdeDOpq8qPLdrGwdbNdtpol98B4SyPy4GXM6pG7j3jebL1HUymNN8V1Wg1R9x+pvq3SYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760283864; c=relaxed/simple;
	bh=jvMiToE63eManCA44zRL5tk+r48YRGBD/0Ye03AuOng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gaz9dZ5N/3yCI1KJECC6QTaJUIX80jK4iksVzOWGxOmTTVPSXIXufZPg7v3NdCPLru9aFRlxg+rGHGhOwn8j357L9jllU2RaLOCs4AGNdEY3DI+3LT5yOYA+oepO0MtpgfiBbEkDeOSSR8TEIeK1inH+/MY+Vpy4e9PVeZC0w3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I61ilg8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73342C4CEFE;
	Sun, 12 Oct 2025 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760283863;
	bh=jvMiToE63eManCA44zRL5tk+r48YRGBD/0Ye03AuOng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I61ilg8xv9CdF3M06RRH1H/pC9Dmkl+FaWbiZ4+MMijkNvFZP9u4ZafOUDCwHyfXf
	 Wu44t9dXC8O3CLY3v5Kv1VOqm1bsR2fHhkRgYc201n8yFgdGtQRbW5ejP40g6JizBf
	 aMUZxBxQ2Q9SGzPpOyKlhw0Mb7qlOefuqJAUn/2NFqw4B/bbFLrsZjZpG4ze3u47Wj
	 +PD1amoGpp4UMY21U4lvctO3duF+dOi7IPCd/PfRO6Inmgh8UP0vcuXJ/Qin10h2wM
	 I+nCRd44qu+JJt6vTacuoYVTSNVAPL8UXZ/JMBpZZuKxFs5cMbdZsRSjRhGLG4hPpt
	 9A/ki0jGD/13g==
Date: Sun, 12 Oct 2025 16:44:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH v9] dt-bindings: iio: Add Infineon DPS310 sensor
 documentation
Message-ID: <20251012164413.0084ad6d@jic23-huawei>
In-Reply-To: <20251007191612.80164-1-eajames@linux.ibm.com>
References: <20251007191612.80164-1-eajames@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Oct 2025 14:16:12 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> The DPS310 is a barometric pressure and temperature sensor with
> an I2C interface. Remove it from trivial-devices.yaml and add its
> own documentation to allow for consumers of this device such as
> the iio/hwmon bridge.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
LGTM

Applied to the testing branch of iio.git. I'll rebase that on rc1 once available
and then push out as togreg which is the one linux-next picks up.

Thanks,

Jonathan

> ---
>  .../iio/pressure/infineon,dps310.yaml         | 54 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  MAINTAINERS                                   |  1 +
>  3 files changed, 55 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> new file mode 100644
> index 0000000000000..e5d1e6c489393
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/infineon,dps310.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon DPS310 barometric pressure and temperature sensor
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description:
> +  The DPS310 is a barometric pressure and temperature sensor with an I2C
> +  interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - infineon,dps310
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 0
> +
> +  vdd-supply:
> +    description:
> +      Voltage supply for the chip's analog blocks.
> +
> +  vddio-supply:
> +    description:
> +      Digital voltage supply for the chip's digital blocks and I/O interface.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dps: pressure-sensor@76 {
> +          compatible = "infineon,dps310";
> +          reg = <0x76>;
> +          #io-channel-cells = <0>;
> +          vdd-supply = <&vref1>;
> +          vddio-supply = <&vref2>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 58ff948d93c96..a76c58f3b1de4 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -127,8 +127,6 @@ properties:
>            - ibm,cffps2
>              # IBM On-Chip Controller hwmon device
>            - ibm,p8-occ-hwmon
> -            # Infineon barometric pressure and temperature sensor
> -          - infineon,dps310
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IRPS5401 Voltage Regulator (PMIC)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3773c74b31d6d..bde80ddb99e9d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12217,6 +12217,7 @@ INFINEON DPS310 Driver
>  M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>  F:	drivers/iio/pressure/dps310.c
>  
>  INFINEON PEB2466 ASoC CODEC


