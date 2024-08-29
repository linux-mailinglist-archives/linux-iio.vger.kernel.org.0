Return-Path: <linux-iio+bounces-8862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530AD964437
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D34B266BF
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15C61946A4;
	Thu, 29 Aug 2024 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8xHVF6X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495E018D63A;
	Thu, 29 Aug 2024 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933874; cv=none; b=Mfp8WAfBINWWi22DQ758KTn7ymgrkNIwmSu6uj7xie1J1m3qv+xuna+L6PbzNgjB7DUHHhiUwd7+oCkIC6YNnFza3RLXOB+mSZpnyu9jqfZLwADbAqh/LprOm+QpJhx/a76BEL20AVBOjlU8clMh/eVp2OoZgbdLJevZZjRbjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933874; c=relaxed/simple;
	bh=2HmjvO3I63oTxuLi3YmKG7PkAMJTgnJlaCqIEZRVxbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsPVtSPBeWcT4c9p8s1fJ1Quqyd1qaZm7/QJyt3jw2lmH7VTcIsSO1i/S/f8/Qgvo2TaYLchMPwNbOIMlr8CiQV3eHXFWeR1r/ykaT6s74mSxcLkgr2etd+Qm4QHNiTBiqkMXkf+GLdBiW66xM8PTBY/Yavvc22mextrTG7ZKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8xHVF6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE18C4CEC1;
	Thu, 29 Aug 2024 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724933873;
	bh=2HmjvO3I63oTxuLi3YmKG7PkAMJTgnJlaCqIEZRVxbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8xHVF6XNOgtUnEf//lcAGtR/uzDwBDLmMZazA5+4wJsvh5ZflONth3CES3tQDzBw
	 GEMViDWyt5v/4ocRxT6mjY1NRxuzg0NqFo3ortixgnD4+1oTCMNmroHlNILyAeb9Gl
	 g/7rMtdoypDCowLn2Y1fEnUq8TKr27fENgXWF513dH6VpP4Qs21rZnBwM9wfLmelJd
	 eMP2ft2hF3GU4D6H+QlZcXUbuOXBOzy7HYOy52DFwcOG8/Rr5B022ZERrgPu2KsrXO
	 Ki4QoM8/zy352SXrl4tjj3KZWP0e1gpfV2vY0YPoDiHHgk+7Iqd0GVHbNDUkR1M7hy
	 z/3tS3lF3C+4Q==
Date: Thu, 29 Aug 2024 13:17:46 +0100
From: Lee Jones <lee@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
	mripard@kernel.org, tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com, u.kleine-koenig@pengutronix.de,
	samuel@sholland.org, jernej.skrabec@gmail.com, sre@kernel.org,
	wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, lars@metafoo.de, jic23@kernel.org,
	jonathan.cameron@huawei.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 00/15] Add Battery and USB Supply for AXP717
Message-ID: <20240829121746.GP6858@google.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>

On Wed, 21 Aug 2024, Chris Morgan wrote:

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

Note to self: Send ib-mfd-for-iio-power-6.12 once tested

-- 
Lee Jones [李琼斯]

