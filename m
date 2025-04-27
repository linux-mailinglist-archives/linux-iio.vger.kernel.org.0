Return-Path: <linux-iio+bounces-18729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E8A9E305
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 14:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7A57A5A00
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D1B8BEE;
	Sun, 27 Apr 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UapWAE06"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389DF9EC;
	Sun, 27 Apr 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745757536; cv=none; b=P9UkgcxwRvNr4Mqu9KI9GxyslvX5jgIcoYzUe0GCL4g4byV9lShmp24g/539vXWPjyy25peDyIKDR+4xFx/8sdhsL4jX+qv8WRgclHL8zHAriOPoYMpz7AHyxQ/4oq0NO4DuaB9r1p4q5x7Fab/qspXUHn6xUkoy7uG+pTMFgWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745757536; c=relaxed/simple;
	bh=S35W/9aqzailueRgElY9DlBTQStTjMqlL6uqjqJp9k4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjSU+McSw4csg23NThTqFiDA1cIOU9fxt92S551ZNUtXrVrtMZqGFT+V9bg3jzkeqHDwRYWka3rulwI4aagcukSTR8NRQplnRtmz1xK+mF/YiQ/YI1BKmzL2EAKVVs3OLDBBEboH2nFxZr69psuG/YBKxHx16qmE4lPyZWSFD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UapWAE06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03931C4CEE3;
	Sun, 27 Apr 2025 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745757535;
	bh=S35W/9aqzailueRgElY9DlBTQStTjMqlL6uqjqJp9k4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UapWAE06JFlaj9EkSf9ZZ2EEIggXbAq3JmfZanBX/VzjxOTjMxUKEdI11taez1ouM
	 N8wJo56yn1byLbF2vCCnsgqTTI8Y6HqZnHnL1Iy8TrGsSsqrNGc0nh1VrycB8F5oMw
	 lcKVBHsNVo/yge8ygtbRXGnTC3St9JDgcF2EZYiMZ11/sE0rg/R8zLyV2VO3HpvkrJ
	 x3cu8l+itkTIjsKu3hPxGSHnMh8KuDyNzOgr4UW5ZdwAjPE75fvSc1fmwawA0RjETR
	 jTryf6cCleEslIwGxy6PTPVL6JVAsg73eLLGK3SL6I0PBWR+IMfuvZ6qBnAT4mR2v3
	 Xz8+ahtacutkw==
Date: Sun, 27 Apr 2025 13:38:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 09/11] iio: accel: adxl345: add inactivity feature
Message-ID: <20250427133847.6f3b164c@jic23-huawei>
In-Reply-To: <20250421220641.105567-10-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 22:06:39 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the inactivity feature of the sensor. When activity and inactivity
> are enabled, a link bit will be set linking activity and inactivity
> handling. Additionally, the auto-sleep mode will be enabled. Due to the
> link bit the sensor is going to auto-sleep when inactivity was
> detected.
> 
> Inactivity detection needs a threshold to be configured, and a time
> after which it will go into inactivity state if measurements under
> threshold.
> 
> When a ODR is configured this time for inactivity is adjusted with a
> corresponding reasonable default value, in order to have higher
> frequencies and lower inactivity times, and lower sample frequency but
> give more time until inactivity. Both with reasonable upper and lower
> boundaries, since many of the sensor's features (e.g. auto-sleep) will
> need to operate beween 12.5 Hz and 400 Hz. This is a default setting
> when actively changing sample frequency, explicitly setting the time
> until inactivity will overwrite the default.
> 
> Similarly, setting the g-range will provide a default value for the
> activity and inactivity thresholds. Both are implicit defaults, but
> equally can be overwritten to be explicitly configured.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Tweaked - see below for why.  Please sanity check I didn't mess it up!


diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index dd8cea5c48f3..a61c97c086e9 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -241,16 +241,14 @@ static const struct iio_event_spec adxl345_all_event_spec[] = {
                .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
                BIT(IIO_EV_INFO_PERIOD),
        },
-};
-
-/* inactivity */
-static const struct iio_event_spec adxl345_inactivity_event_spec = {
+       /* inactivity */
+       {
                .type = IIO_EV_TYPE_THRESH,
                .dir = IIO_EV_DIR_FALLING,
                .mask_separate = BIT(IIO_EV_INFO_ENABLE),
                .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
-                       BIT(IIO_EV_INFO_PERIOD),
-
+               BIT(IIO_EV_INFO_PERIOD),
+       },
 };
 
 static const struct iio_chan_spec adxl345_channels[] = {
@@ -265,14 +263,6 @@ static const struct iio_chan_spec adxl345_channels[] = {
                .event_spec = adxl345_all_event_spec,
                .num_event_specs = ARRAY_SIZE(adxl345_all_event_spec),
        },
-       {
-               .type = IIO_ACCEL,
-               .modified = 1,
-               .channel2 = IIO_MOD_X_AND_Y_AND_Z,
-               .scan_index = -1, /* Fake channel */
-               .event_spec = &adxl345_inactivity_event_spec,
-               .num_event_specs = 1,
-       },
 };
 
 static const unsigned long adxl345_scan_masks[] = {

> ---
>  drivers/iio/accel/adxl345_core.c | 172 ++++++++++++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 680981609d83..b25efcad069b 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -37,11 +37,17 @@

>  
> +/* inactivity */
> +static const struct iio_event_spec adxl345_inactivity_event_spec = {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_PERIOD),
> +
> +};
> +
>  static const struct iio_chan_spec adxl345_channels[] = {
>  	ADXL345_CHANNEL(0, chan_x, X),
>  	ADXL345_CHANNEL(1, chan_y, Y),
> @@ -244,6 +263,14 @@ static const struct iio_chan_spec adxl345_channels[] = {
>  		.event_spec = &adxl345_freefall_event_spec,
>  		.num_event_specs = 1,
>  	},
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
> +		.scan_index = -1, /* Fake channel */
> +		.event_spec = &adxl345_inactivity_event_spec,
> +		.num_event_specs = 1,
Why do we need a separate fake channel for this?

Should reuse the one that we have for freefall which has the same definition.

+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
+		.scan_index = -1, /* Fake channel */
+		.event_spec = &adxl345_freefall_event_spec,
+		.num_event_specs = 1,
+	},

> +	},
>  };
>  
>  static const unsigned long adxl345_scan_masks[] = {
> @@ -287,7 +314,8 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>  {
>  	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
>  
> -	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> +	return regmap_update_bits(st->regmap, ADXL345_REG_POWER_CTL,
> +				  ADXL345_POWER_CTL_MEASURE, val);
>  }

