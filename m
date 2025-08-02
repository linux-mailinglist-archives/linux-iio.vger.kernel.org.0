Return-Path: <linux-iio+bounces-22188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7DEB18E25
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 13:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAC817DE14
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12245221FB6;
	Sat,  2 Aug 2025 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS/xVOb9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A91E7C23;
	Sat,  2 Aug 2025 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754133168; cv=none; b=riRPuwN0xtQnIDcYwGXLTvHA6igtGPGpON7ECRgS1Ey3tRZ2OPVePygr+hGS6yNyZxijyNOnB95YKriSac+0Mj0P3BFAMf/UkBTnpuFtnK29jC55CSg7BO0zI1ehA29cZNtD+I42edODxB7DCvCu8zi3DJzoyQzCV/TwxyAJngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754133168; c=relaxed/simple;
	bh=c755nBEa9bQXGf+BATDawtAt/ZtiYh8OMcGeTiO/fyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmS4he+C7SsOinb2Z7WEbbRAKB6J3TpFnw9ovzYjp+wVjFMqQsies/ly0oI3Sv0shY6hzM3UK7l+2weNUxjJC+46BIKyhm1qt6ne7q3LZpiDJSALRBxsGTNmK66FBzK5ftnTp9vBRUNTlJO7TUklb+cyc48oEtS3VWK6Z8NyHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS/xVOb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5BDC4CEEF;
	Sat,  2 Aug 2025 11:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754133168;
	bh=c755nBEa9bQXGf+BATDawtAt/ZtiYh8OMcGeTiO/fyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jS/xVOb9R41WZ9owNE3eIiX4LaNg88SS1n50SxPyK/lID/ZY9bu8pUtSmgTCmgDex
	 2IkTUt+5IQeVJ2U805apBYwIZ3upPqkS18T1LKThaFLLEvH7qFqeAyp4Q3jYn0BuSY
	 BY7HJAlaI6NngCsyWnHCrLRb6TPl2YG/xWgAyT5r9SyAKyI0hn9TUEK9xmdtcOGKtS
	 IpV7XD1ODNw9l1uxgh4f7BAcdEW/zsf0/SZ62w+lKRt1xK/kVufrrk0dxahJmyTn50
	 vDdmvmq9nDLnHGx5OqpaGcMV/wc767iAF4p/ezbq5l6XcbocjzZSNuWTlFdIPxBT6V
	 KLF1ArNt5ANWA==
Date: Sat, 2 Aug 2025 12:12:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, conor+dt@kernel.org,
 mranostay@gmail.com, ~lkcamp/patches@lists.sr.ht,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, William Breathitt Gray <wbg@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: proximity: Add Lidar-lite-v2
Message-ID: <20250802121238.108ebfad@jic23-huawei>
In-Reply-To: <20250801224112.135918-1-rodrigo.gobbi.7@gmail.com>
References: <20250801224112.135918-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Aug 2025 19:39:15 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> Move existing ABI documentation from trivial to
> a dedicated binding file since Lidar is not a trivial
> device considering power-enable and mode control pin.
> 
> Also, add a fallback compatible for v3, which has the
> same pinout and is already supported by the driver.
> 
> Fixes: b257c1a45e99 ("iio: pulsedlight-lidar-lite-v2: add lidar-lite-v3 property")
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> I was unsure about sending a new v0 patch for this or send a v2. To avoid losing
> the lore about this topic, I`m sending a v2. If this is not correct, I can send a
> new patch later.
> 
> On 7/3/25 18:26, David Lechner wrote:
> > On 7/1/25 5:30 PM, Rodrigo Gobbi wrote:  
> >> The compatible grmn,lidar-lite-v3 is managed by the same
> >> driver of pulsedlight,lidar-lite-v2, which is a trivial device.  
> > 
> > As a general rule of thumb, using the driver as justification for
> > dt-bindings is never a good reason. The bindings describe the hardware,
> > not the driver.
> > 
> > Assuming I found the correct datasheet [1], I see a power enable pin
> > and a mode control pin, so I would say that this isn't a trivial device.
> > Therefore this will need it's own new file. We could at least add
> > power-gpios and power-supply properties. How to handle the mode pin
> > isn't so clear to me though, so might omit that for now.  
> About the mode control pin and the data being returned within PWM, it`s also
> unclear to me how to describe that here. Looking other kind of existing iio
> devices, couldn`t find a reference for it so I`ve not described that.

So far we've never supported a sensor with a PWM output.  Needs some capture logic
and whilst there is some supported in the kernel, I don't think we have the
infrastructure to describe the sensor beyond it. It relies on an odd combination
of triggering via a light pull low that the device then drives high.  To make
that work with a standard capture unit is probably a case of wiring multiple pins
or some external components.

+CC counters subsystem maintainer William.

https://static.garmin.com/pumac/LIDAR_Lite_v3_Operation_Manual_and_Technical_Specifications.pdf
for reference

However, I'm also in agreement with others that this is an unusual case where
we are very likely to missdesign a DT-binding without having explored what the
driver stack looks like and so are best just leaving a gap for now.

Even if we did describe the mode stuff it would be optional so not describing it
for now should be fine.


> 
> Also, I`m quoting the driver author about this binding due the maintainer ref for it.
> 
> Dear @Matt Ranostay, I`ve noticed you were the original driver author.
> During the discussion about adding lidar-v3 as trivial [1], we noticed that
> this HW is not actually a trivial due other pins like power-enable
> and mode control. We are considering moving v2 and v3 (which was not documented)
> out of trivial and this is what this patch is trying to do. 
> Also, we need a maintainer for the binding file and I`ve quoted you there.
> I would appreciate your comments or suggestions over this topic.
> 
> Tks and regards to all.
> 
> Changelog:
> v2: creating an initial binding for lidar v2 and v3 (fallback to v2)
>     also, moving v2 out of trivial
> v1: https://lore.kernel.org/all/20250701223341.36835-1-rodrigo.gobbi.7@gmail.com/#t
> ---
>  .../proximity/pulsedlight,lidar-lite-v2.yaml  | 54 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 54 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> new file mode 100644
> index 000000000000..f49a1c365f3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Pulsedlight LIDAR-Lite v2 range-finding sensor
> +
> +maintainers:
> +  - Matt Ranostay <mranostay@gmail.com>
> +
> +description: |
> +  Support for LIDAR_Lite v2 and v3 laser rangefinders. These devices
> +  can use a simple I2C communication bus or can operate in a PWM mode using a
> +  mode control pin to trigger acquisitions and return the measured distance.
> +  It also have a power enable pin, which can be used to shut off the device.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - grmn,lidar-lite-v3
> +          - const: pulsedlight,lidar-lite-v2
> +      - const: pulsedlight,lidar-lite-v2
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-gpios:
> +    description: GPIO that can be driven low to shut off power to the device.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        proximity@62 {
> +            compatible = "grmn,lidar-lite-v3", "pulsedlight,lidar-lite-v2";
> +            reg = <0x62>;
> +            vdd-supply = <&vdd_5v0>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 8da408107e55..347897b999c9 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -313,8 +313,6 @@ properties:
>            - onnn,adt7462
>              # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
>            - plx,pex8648
> -            # Pulsedlight LIDAR range-finding sensor
> -          - pulsedlight,lidar-lite-v2
>              # Renesas HS3001 Temperature and Relative Humidity Sensors
>            - renesas,hs3001
>              # Renesas ISL29501 time-of-flight sensor


