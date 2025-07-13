Return-Path: <linux-iio+bounces-21602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4053B03141
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 15:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87AF07A1A80
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEED1F1927;
	Sun, 13 Jul 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9NBbMhw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28131839F4;
	Sun, 13 Jul 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752414475; cv=none; b=cBDJxLe9wZNTDFwrwK9maveKKW5VoGqOGyiksverchCqbelvlJTdXoFh9XyYihPcXDpJVOBgJ/3FHFveS5seQaWCscTlQSziydZ8HbYVlb+SdTEFXmjQaTUw5L/hSSIfNg8ynfhAEbRtS2/NZlnExUvpE2p4+nLzoBC9N6GREUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752414475; c=relaxed/simple;
	bh=I4Unqd70Pah2uecg7+bI8bE+MM+Yo1QABTmHUyxoGtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNvMWwZT87+fTi01wLldRBCKPQvuwqTtY/nJukE1s7gHuLni25Zd/FkNNKToPOcEQfwbxMSD2P8i+8RsWcwGNU68v1uNwY+OLTOFNNthKn0CwWCE+QxJ5OyFBP6wVKUJ1PXkvwoFWCZtR57T5OF0kH9TnuvzmjcVD6TZXnLKRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9NBbMhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73884C4CEE3;
	Sun, 13 Jul 2025 13:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752414475;
	bh=I4Unqd70Pah2uecg7+bI8bE+MM+Yo1QABTmHUyxoGtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H9NBbMhwSn4KuYASYcIpn2AKaslA4nBbX3Zgbijff23Dt+gWCYI9/jt/UL854FNy1
	 sLWIT4fRJv+L/J3KsrSZF2alcAaUpbzTUInH76Rho1hnEWnxnX0iEoZYVa+bM1Chsy
	 Sjg9zeYhyHU7tqe0B6cqe6Kpwjkid6oeZE0JZIhjmOL/AVZ6jEMaNNwc3ZZfkHeCbt
	 s+PRJFb/pfT/bwDXRRhRkb2n1RJX15Jalbj49GsCa+U5HP0dBRuqE5LLUVq3wa96dR
	 I73lkAuaAPuRi037nwTZFYjwyMqZSYaYwXCdYhMllQwEFlB0dICgvfk27LynZhr+mH
	 fhLclxvIzz7rw==
Date: Sun, 13 Jul 2025 14:47:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix temperature reading if
 accel/gyro is off
Message-ID: <20250713144747.667aac5f@jic23-huawei>
In-Reply-To: <20250708-icm42temp-v1-1-81af60aab82a@geanix.com>
References: <20250708-icm42temp-v1-1-81af60aab82a@geanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Jul 2025 14:09:17 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Avoid return invalid argument if one tries to read the temperature,.
> if both the accelerometer and gyro are off. Power the accelerometer on
> before reading the temperature.
> The original state will be restored by runtine_suspend() or the next
> reading of the accelerometer.
I'm not sure we are going ahead with this anyway given the other thread,
but if we did, then relying on runtime_put() in read of a different
channel seems like a bad design. If we think someone is interested
in reading the temperature of this sensor, are they guaranteed to
also be reading the acceleration?

> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index a4d42e7e21807f7954def431e9cf03dffaa5bd5e..f97376bc8bb3dd225236e3f5036fd58af4af35ac 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -399,9 +399,14 @@ int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
>  int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
>  			       unsigned int *sleep_ms)
>  {
> -	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode,
> -					  st->conf.accel.mode, enable,
> -					  sleep_ms);
> +	enum inv_icm42600_sensor_mode accel = st->conf.accel.mode;
> +
> +	if (st->conf.gyro.mode == INV_ICM42600_SENSOR_MODE_OFF &&
> +	    st->conf.accel.mode == INV_ICM42600_SENSOR_MODE_OFF)
> +		accel = INV_ICM42600_SENSOR_MODE_LOW_POWER;
> +
> +	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode, accel,
> +					  enable, sleep_ms);
>  }
>  
>  int inv_icm42600_enable_wom(struct inv_icm42600_state *st)
> 
> ---
> base-commit: 3e28fa06444e7031aba0b3552cce332b776fe267
> change-id: 20250708-icm42temp-6292abddb6e6
> 
> Best regards,


