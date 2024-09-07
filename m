Return-Path: <linux-iio+bounces-9273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58ED970266
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63631C21362
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ADA15C126;
	Sat,  7 Sep 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3oiQbe2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B7947A;
	Sat,  7 Sep 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725715822; cv=none; b=gCeDPSv59RLStylUgBb/486hj3T3ymuKM8zEDaSvdyZdO1+fjsUHd88kDTobugibZMvUrzSooRAz7McU/2y8zO3iu+vjRy3fAlLEcvpB+NfHP2JduR9CxA4bMvx8j5VQU8fN6XTA89sgIT9Qsnyq9QVgwpvC88JDqY/LOiUzX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725715822; c=relaxed/simple;
	bh=aY18vlW/L4kb/gRa6VcsduMXnD5MdEnK7MC9k8KzS2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0hG/OwP+hUEqMe9LjxPRG1q+hQrhfPEH1vj7LWGhsPgCwPTVrGFTO+GP8CSqo3ah3P9vrDYzsoccjdzolTf/W4dCTJIUYKDHccGc8AhjTF/Ml3Z+lAiLhC/Fxdcff++DwqqnNXI/5tH7StRgpB+LSVLVBu2KxfMD7acIsFJPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3oiQbe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87618C4CEC2;
	Sat,  7 Sep 2024 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725715821;
	bh=aY18vlW/L4kb/gRa6VcsduMXnD5MdEnK7MC9k8KzS2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D3oiQbe2QgRd3H0U4NZ1b7p7SZtUJeQAxP7E53oY4EVY44Q/yf1BHh3URlksXF8h2
	 h27FzkWsjkaDXQMfqd6qISAMjG1VzPU8XO6cwsnAD4sCPhPj69SgGKFNAQrHPDVbFx
	 azd73H7wzlJqUuDDNhpGu3CPlGy9XyMNJBKASgKmJ+LBKXl1cGXLUtaayMm4h9Iukk
	 JrjdMwO/xcCWdmg+44vy6Bj9oPdq+hidsQv2KAiUDMW33rGxvYdYbbfWnP0+mCuj4D
	 xgXwUx4g+FVhGY5gTPDknXab7iXRLbHSw/QGLYg7dlScYxNe53hPWUk6K8Q+6LEV8f
	 a/hHcK3/mcsCg==
Date: Sat, 7 Sep 2024 14:30:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
 mripard@kernel.org, tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
 u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
 jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 jonathan.cameron@huawei.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 00/15] Add Battery and USB Supply for AXP717
Message-ID: <20240907143011.56ab068f@jic23-huawei>
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 16:54:41 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for monitoring the USB charger and battery charger on the
> AXP717 PMIC. This required some driver refactoring of the axp20x USB
> and battery charger as the AXP717 is somewhat different but can still
> benefit from some common elements.
> 
> Note that as of now the charging current now value may be incorrect as
> the scale and offsets were not documented in the datasheet. I suspect
> the scale is 1 and the offset is somewhere around 450mA though.
Applied 1, 8 and 12 to the IIO togreg branch.

I was waiting for some mess related to my tree to pan out upstream.
Unfortunately that leaves us rather tight on timing for the coming
merge window but hopefully Greg will take a last minute pull request
for char-misc.

Jonathan

> 
> Changes from V3:
>  - Remove accidental AXP717_BOOST regulator in header file, as it is
>    not part of this patch series.
>  - Add an absolute min/max constraint for input-current-limit-microamp
>    in device tree documentation.
>  - Correct an issue found by kernel test robot <lkp@intel.com> by
>    explicitly adding linux/bitfield.h include. Details here:
>    https://lore.kernel.org/oe-kbuild-all/202408201228.Hee4eSYl-lkp@intel.com/
> 
> Changes from V2:
>  - Added constraints for input-current-limit-microamp constraints for
>    x-powers,axp20x-usb-power-supply.yaml.
>  - Used FIELD_GET() and removed unnecessary -EINVAL per comments from
>    Jonathan Cameron.
> 
> Changes from V1:
>  - Refactored against mainline to remove BOOST pre-requisite.
>  - Corrected commit subjects for DT bindings.
>  - Split refactoring and AXP717 support into different patches.
>  - Added IRQ for VBUS over voltage. There appears to be a bug
>    with the VBUS fault IRQ because it is assigned IRQ num 0.
>  - Corrected battery driver to report POWER_SUPPLY_PROP_VOLTAGE_MIN
>    and POWER_SUPPLY_PROP_VOLTAGE_MAX instead of *_DESIGN.
> 
> 
> Chris Morgan (15):
>   iio: adc: axp20x_adc: Add adc_en1 and adc_en2 to axp_data
>   power: supply: axp20x_battery: Remove design from min and max voltage
>   power: supply: axp20x_battery: Make iio and battery config per device
>   power: supply: axp20x_usb_power: Make VBUS and IIO config per device
>   dt-bindings: power: supply: axp20x: Add input-current-limit-microamp
>   power: supply: axp20x_usb_power: add input-current-limit-microamp
>   dt-bindings: power: supply: axp20x-battery: Add monitored-battery
>   dt-bindings: iio: adc: Add AXP717 compatible
>   dt-bindings: power: supply: axp20x: Add AXP717 compatible
>   dt-bindings: power: supply: axp20x: Add AXP717 compatible
>   mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
>   iio: adc: axp20x_adc: add support for AXP717 ADC
>   power: supply: axp20x_usb_power: Add support for AXP717
>   power: supply: axp20x_battery: add support for AXP717
>   arm64: dts: allwinner: h700: Add charger for Anbernic RG35XX
> 
>  .../bindings/iio/adc/x-powers,axp209-adc.yaml |  12 +
>  .../x-powers,axp20x-battery-power-supply.yaml |   7 +
>  .../x-powers,axp20x-usb-power-supply.yaml     |  72 ++-
>  .../sun50i-h700-anbernic-rg35xx-2024.dts      |  21 +
>  drivers/iio/adc/axp20x_adc.c                  | 182 +++++-
>  drivers/mfd/axp20x.c                          |  25 +-
>  drivers/power/supply/axp20x_battery.c         | 591 ++++++++++++++++--
>  drivers/power/supply/axp20x_usb_power.c       | 353 ++++++++++-
>  include/linux/mfd/axp20x.h                    |  26 +
>  9 files changed, 1188 insertions(+), 101 deletions(-)
> 


