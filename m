Return-Path: <linux-iio+bounces-19871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE34AC3434
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE623B1311
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447F1F03EF;
	Sun, 25 May 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAwH+Xah"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3EEC2;
	Sun, 25 May 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748172740; cv=none; b=CG7KQaVPbuxy3b0eeW2fR5mhS0LYkG+Enf+YHRzyjE0By6a0HQ+NGg1ZRSwZG5HslaXHUrmVb1Hj83adPTOqiqKZbM2fXZimTSaX/7ox6gnLq/BbTO2EGSUhMuYzhEZKRbLInk0G3WVhnQK92Jo/ULcLm9mhZYgHccQsgL+j6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748172740; c=relaxed/simple;
	bh=IS1wb38MfaateYqeVeqtlnAVjvCpJl3gvukcwDBCU9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMqhRx7/Mzd5UNVLPVKU8XpatDRoLSJAkNHkmTSxOWQvdEW1i1PaMaCzZtU/mtyf9bI1Zr/RtQeQjq/Q7nWd80UlEgCSMILWi/JgkIKdVS8i2UAumzutxdFMp2p+KxoswRlpV2T3+vfqttknBCgozcT6rbYflOPfLslk/8l3r6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAwH+Xah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC51C4CEEA;
	Sun, 25 May 2025 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748172739;
	bh=IS1wb38MfaateYqeVeqtlnAVjvCpJl3gvukcwDBCU9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PAwH+Xah1ZiGUKSL/jCtN6/tt0F59HduBUBnvHEc00yxE+J+gGPMrRlQFxkzvcOkV
	 cUoVVgjGmXVC8MrX7V7qvLiDfRKNcQ9Pu2GDLb3Yd0OVQNmo/hycV2SQ+adUBVLvJr
	 r2zHGltarAjROqq0rNCraYEf5THSDZUFEPIQXzsFhgK6C5dJBPP55RWpIZtd4W2HzZ
	 A7VHbGA+BQUjDyULUA7YKokrxqMz5tjFm//9fnzp6xJuI4DkOiqoJFsaM90A/RW39M
	 PsYaZ5yISkJK2KuXKzCdaZR8ap2MYqxdExCnOlr0X5tqs/nT5tH6U+DlDtAygcJdYv
	 PfLn71UkEoziw==
Date: Sun, 25 May 2025 12:32:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/12] iio: accel: adxl313: introduce channel
 scan_index
Message-ID: <20250525123211.6ac11af5@jic23-huawei>
In-Reply-To: <20250523223523.35218-3-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:13 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a scan_mask and scan_index to the iio channel. The scan_index
> prepares the buffer usage.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Squash stuff that is only needed for buffer usage into the patch
that adds buffered support.  This is a case where I'm not convinced
the code is complex enough to warrant a multi step approach.


> ---
>  drivers/iio/accel/adxl313_core.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 2f26da5857d4..9c2f3af1d19f 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -171,9 +171,10 @@ static const int adxl313_odr_freqs[][2] = {
>  	[9] = { 3200, 0 },
>  };
>  
> -#define ADXL313_ACCEL_CHANNEL(index, axis) {				\
> +#define ADXL313_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
> -	.address = index,						\
> +	.scan_index = (index),						\
> +	.address = (reg),						\
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##axis,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> @@ -187,10 +188,19 @@ static const int adxl313_odr_freqs[][2] = {
>  	},								\
>  }
>  
> +enum adxl313_chans {
> +	chan_x, chan_y, chan_z,
> +};
> +
>  static const struct iio_chan_spec adxl313_channels[] = {
> -	ADXL313_ACCEL_CHANNEL(0, X),
> -	ADXL313_ACCEL_CHANNEL(1, Y),
> -	ADXL313_ACCEL_CHANNEL(2, Z),
> +	ADXL313_ACCEL_CHANNEL(0, chan_x, X),
> +	ADXL313_ACCEL_CHANNEL(1, chan_y, Y),
> +	ADXL313_ACCEL_CHANNEL(2, chan_z, Z),
> +};
> +
> +static const unsigned long adxl313_scan_masks[] = {
> +	BIT(chan_x) | BIT(chan_y) | BIT(chan_z),
> +	0
>  };
>  
>  static int adxl313_set_odr(struct adxl313_data *data,
> @@ -419,6 +429,7 @@ int adxl313_core_probe(struct device *dev,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adxl313_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
> +	indio_dev->available_scan_masks = adxl313_scan_masks;
>  
>  	ret = adxl313_setup(dev, data, setup);
>  	if (ret) {


