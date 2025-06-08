Return-Path: <linux-iio+bounces-20311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901D8AD12E8
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAD03AABB9
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5EE14EC73;
	Sun,  8 Jun 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYwkCxpE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D87FD;
	Sun,  8 Jun 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749395849; cv=none; b=jq6lAyzoPf93Km+WADWGSI7882XvFlkZWuR1LJmlZRhgT1/RIPUXsyQe7q1WT5dLU3J61WY6z/Rqy5+V9lenW1Uo9Z6AEolBDvIjRDAL03fkP2ADlvSDTiAYmg/XP03OOegBvjA6MJXQuTPKJQ7oVpLT+NzgHFjZ65H1N7ZUsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749395849; c=relaxed/simple;
	bh=V8Es+s6jaSFCR6QcZAWrXJSPWaYNOVOXQ5lW3/SjqtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKolSLZd2KSTzMcFWvU0RMGn0uyedLz9jq2g3PQtLEnfUeOJuz+x4dgUAezpfPFulhsNhPmLcTTu3SMs7SVzTFggHGRHxI4NkVPUvC4NmEEQrxttyHbfJK0ohigX7M/NmGPgtNoA9xO4n4pR0zJSfD7npDqV97QMXrm9BSUYn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYwkCxpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C9C4CEEE;
	Sun,  8 Jun 2025 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749395848;
	bh=V8Es+s6jaSFCR6QcZAWrXJSPWaYNOVOXQ5lW3/SjqtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dYwkCxpEg8gqcEzyBLh5y+RMnKziNcKRF77eYs+qf9F0aVLVC8CqvhLHyBqxUrV+p
	 zmUhIvMfFxFZ2AS12V8j1ifMyJNUSdl42w8sT9M2KnT6HaRIB+J+0xKTcd+qKfD87t
	 XxbKALOGWX0LCmbBiZpSi38LLRkdsWNNYnpclNFK/QVlPTvYTQHfB2k9G22LdZa8uq
	 GBDYstLSyMNKGVrvwKT2SGB6PGCLuBfVljspIyTF/l2jT5XffSLlS3x2MafJNb+0Px
	 O/ItdiflZaj+dH9/4DH+OJIM1BbNbYu/02ICPYBDYRenKc4nEgKtCZmDkOnep7hpop
	 tjRBmjsj4CuDg==
Date: Sun, 8 Jun 2025 16:17:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/11] iio: accel: adxl313: introduce channel buffer
Message-ID: <20250608161719.1f2813d5@jic23-huawei>
In-Reply-To: <20250601172139.59156-3-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Jun 2025 17:21:30 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a scan_mask and scan_index to the iio channel. The scan_index
> prepares the buffer usage. According to the datasheet, the ADXL313
> uses 13 bit in full resolution. Add signedness, storage bits and
> endianness.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

I'd normally expect to see this in the same patch where it is first used.

There is little benefit in adding unused data on it's own - so combine this
with patch 6.  If there was something particularly unusual to discuss
and highlight for review, a separate patch might make sense, but I'm not
seeing that here.

Jonathan

> ---
>  drivers/iio/accel/adxl313_core.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 2f26da5857d4..06a771bb4726 100644
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
> @@ -183,14 +184,26 @@ static const int adxl313_odr_freqs[][2] = {
>  	.info_mask_shared_by_type_available =				\
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
>  	.scan_type = {							\
> +		.sign = 's',						\
>  		.realbits = 13,						\
> +		.storagebits = 16,					\
> +		.endianness = IIO_BE,					\
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
> @@ -419,6 +432,7 @@ int adxl313_core_probe(struct device *dev,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adxl313_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
> +	indio_dev->available_scan_masks = adxl313_scan_masks;
>  
>  	ret = adxl313_setup(dev, data, setup);
>  	if (ret) {


