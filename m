Return-Path: <linux-iio+bounces-21437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348A5AFBA18
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 19:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784F84A0EB8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2E621770A;
	Mon,  7 Jul 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os957C1b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607AF219EB;
	Mon,  7 Jul 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910508; cv=none; b=CKzTpb8GmYp3B5P/t7R1UJE18zzAGcW+QRjmpgNdyQsiGaGD2B1R/wowBzwhsyXvcRjBW9wymsNYZP13HcudQ4mz238V5j1m77+Ww/beRgLFhzJTSs9lQmTvzI2gUr5qnS0YIjRopJJgJ3RwQCajc/ZWu/RT0oK6gmxYK0HBOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910508; c=relaxed/simple;
	bh=38upJ0pBmugxSPEcajDjCdYu6uxaRBbEaf1xbSZkXf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qocBKYFgGGE0uDjyvdcbShCoITjg4iqp+5Ww+3AwhpY6ZaXwCq7rtb1vTksImboFHKARMQEScf1TmkimBI623FpF7yUbGFz4MlcFHDotHE/btqyzCOFhLlxyyOwFUQn/kkKMBxD0iAMyx2DOmDYOn7mOX1N9z+XmGLui0Am3qp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os957C1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8961C4CEE3;
	Mon,  7 Jul 2025 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751910507;
	bh=38upJ0pBmugxSPEcajDjCdYu6uxaRBbEaf1xbSZkXf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=os957C1breH45JkDqec35f+bijw+a347H8WDo7aK13x1cy5gOJd1yWN38gQkRRg+2
	 ZSPJlwCHTmGB1Xf5WQ97u0/Ix5Hpf3Bll9bfx14z2enp62GBUByr4MiHWZkHwmYStJ
	 aB6ToCbi2rihE9faNY98tTQIAbtiPwrPeHZrRQOUFX+xpesWNIk4AwNp7du5lxEwyk
	 iCy6JjMuouIDHF8cTPKbDbflY2Yo30USAgOIRsxCW2aiEoVG0JpCl9zI6J0GWN+VVQ
	 GalYCFjww5qjDlI2GrISCf4SpHITlq/mDEGeMp7QQESQZ5X0TGFoOH79tsam5Crwtw
	 EW7yjnRtKR46Q==
Date: Mon, 7 Jul 2025 18:48:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <andriy.shevchenko@intel.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
 <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v8 00/12] iio: adc: Add support for AD4170 series of
 ADCs
Message-ID: <20250707184815.36386379@jic23-huawei>
In-Reply-To: <cover.1751895245.git.marcelo.schmitt@analog.com>
References: <cover.1751895245.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jul 2025 10:49:46 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Hi,
> 
> AD4170-4 v8 most significant differences from v7 is the timestamp patch comes
> earlier in the series and struct ad4170_state fields have been rearranged
> to better align to cache line boundaries.
> 
> Jonathan, I see you have applied v7 to testing. Thank you. Though, if still
> possible to pick v8 instead, that will provide patches with fewer line removals.
> Totally fine if you prefer to keep v7, though.
Ok. Replaced v7 with v8.

Thanks,

J
> 
> Thank you to all reviewers of previous versions.
> 
> v8 has:
> 
> Patch 1 adds device tree documentation for the parts.
> Patch 2 adds basic device support.
> Patch 3 adds support for calibration scale.
> Patch 4 adds support for calibration bias.
> Patch 5 adds sinc5+avg to filter_type_available IIO ABI documentation.
> Patch 6 adds support for sample frequency along with filter type configuration.
> Patch 7 adds support for buffered ADC reading.
> Patch 8 (was patch 12 on v7) adds timestamp channel
> Patch 9 adds clock provider support
> Patch 10 adds GPIO controller support.
> Patch 11 adds internal temperature sensor support.
> Patch 12 adds support for external RTD and bridge circuit sensors.
> 
> Despite the updates, no functional change has been made in v8.
> This patch series was generated using the "histogram diff" algorithm
> (git format-patch --histogram option).
> 
> Change log v7 -> v8
> 
> [Generic changes]
> - Update patches to make struct ad4170_state fields align well with both 32
>   and 64-bit size cache lines after all patches are applied.
> 
> [Device tree changes]
> - Updated device name in patch description (AD4170 -> AD4170-4).
> - Removed extra blank line at the end of the doc.
> 
> [Basic driver patch]
> - Early declare and use sensor type local variable to reduce diff in ext sensor patch.
> - Make early check of IIO chan type to reduce diff in temperature support patch.
> - Dropped 'int_pin_sel' field from struct ad4170_state. int_pin_sel is now local.
> - Renamed AD4170_MAX_CHANNELS -> AD4170_MAX_ADC_CHANNELS for better readability.
> 
> [Timestamp channel patch]
> - Moved from end of the series to right after buffer support patch.
> - Reworked timestamp patch so it doesn't add 'num_adc_chans' field to struct ad4170_state.
> 
> [Internal temperature sensor patch]
> - Reduced number of line removals in code diff.
> 
> [External sensor patch]
> - Reworded external sensor support patch description.
> - Reduced number of line removals in code diff.
> - Updated ad4170_parse_external_sensor() param: u8 s_type -> unsigned int s_type.
> 
> 
> Link to v7: https://lore.kernel.org/linux-iio/cover.1751289747.git.marcelo.schmitt@analog.com/
> Link to v6: https://lore.kernel.org/linux-iio/cover.1750258776.git.marcelo.schmitt@analog.com/
> Link to v5: https://lore.kernel.org/linux-iio/cover.1749582679.git.marcelo.schmitt@analog.com/ 
> Link to v4: https://lore.kernel.org/linux-iio/cover.1748829860.git.marcelo.schmitt@analog.com/
> Link to v3: https://lore.kernel.org/linux-iio/cover.1747083143.git.marcelo.schmitt@analog.com/
> Link to v2: https://lore.kernel.org/linux-iio/cover.1745841276.git.marcelo.schmitt@analog.com/
> Link to v1: https://lore.kernel.org/linux-iio/cover.1744200264.git.marcelo.schmitt@analog.com/
> 
> 
> Ana-Maria Cusco (1):
>   iio: adc: Add basic support for AD4170-4
> 
> Marcelo Schmitt (11):
>   dt-bindings: iio: adc: Add AD4170-4
>   iio: adc: ad4170-4: Add support for calibration gain
>   iio: adc: ad4170-4: Add support for calibration bias
>   Documentation: ABI: IIO: Add sinc5+avg to the filter_type_available
>     list
>   iio: adc: ad4170-4: Add digital filter and sample frequency config
>     support
>   iio: adc: ad4170-4: Add support for buffered data capture
>   iio: adc: ad4170-4: Add timestamp channel
>   iio: adc: ad4170-4: Add clock provider support
>   iio: adc: ad4170-4: Add GPIO controller support
>   iio: adc: ad4170-4: Add support for internal temperature sensor
>   iio: adc: ad4170-4: Add support for weigh scale, thermocouple, and RTD
>     sens
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |    1 +
>  .../bindings/iio/adc/adi,ad4170-4.yaml        |  554 +++
>  MAINTAINERS                                   |    8 +
>  drivers/iio/adc/Kconfig                       |   16 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ad4170-4.c                    | 3027 +++++++++++++++++
>  6 files changed, 3607 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170-4.yaml
>  create mode 100644 drivers/iio/adc/ad4170-4.c
> 
> 
> base-commit: 66ffb9f5accc6769d1ea7b9d7ac4c5ec477f9575


