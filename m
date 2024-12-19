Return-Path: <linux-iio+bounces-13676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3CB9F8266
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B235C16849F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF78E1A4F1B;
	Thu, 19 Dec 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFtppZ4u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2901A706F;
	Thu, 19 Dec 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630310; cv=none; b=du2hg5VZGoQrR5ypMoMLAwq63fuUZ5L0fXj2ZTw8E+xwdHiqtpxOCjUzzpwdDXWOdGZvBmi42Y1VeUAL76tL/KLlUXd95r6my2nnsPy5kj5b2OaMBAcL8NWO7pFtPlgxMROItH+hc5okz2XjlcI8pBhAvPFdWfyCQC/x1UzhgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630310; c=relaxed/simple;
	bh=nwvuHko52AL3XUdx41dRyK5V4Zjzq/KZYIM9g4l1EhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCnAhsLxJwQJe58dUrrcgOX3KwkSNlLCZBachWoV+itr0xfRjIS6FfOqLfK1Q/ZtKr6BjdCwYpwDJQDNtVGuJ+qt8CK2p1gv6XHlNuEckpPwMd36UD8d1Zn+8KUkOV/xtWkQJCYS5laH1qyiAkp2BVdbvWa+Y4metK96YFRilyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFtppZ4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3749C4CECE;
	Thu, 19 Dec 2024 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734630310;
	bh=nwvuHko52AL3XUdx41dRyK5V4Zjzq/KZYIM9g4l1EhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SFtppZ4usuhiX7aoLUXytbnT/lWu5KhwI3U1/vPcCGtO8N7U6ru6gj4EwidkQh/lo
	 /R0DGvvREa6ZDKmDbqUcPQpMLdbP+GEJ8VOYp9tksttaPhQ9CxluuUFzB4sQaBhYrg
	 OzSKnhp+kXbS39jjtDMJylnYwfkfUr7UacMhNwBjntcWTmoYa8o4iA0X8i6aIFmUyP
	 DzZ1yWc3xj6y1Wz1zJSHCAztHxEppNQw+XdCwz8Wo/sD2KVmI1Jkf2mW1ncVowQrpI
	 76yewqoguwUwcd0S5qMnw2Wfeh5IIjjDz00g/nObsgS2i5b60iVJBG/+rZ3Pt2crpi
	 mzqFUoFmVTF7A==
Date: Thu, 19 Dec 2024 17:45:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
 jstephan@baylibre.com, dlechner@baylibre.com, jackoalan@gmail.com,
 k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: adc: max1363: make use of
 iio_is_soft_ts_enabled()
Message-ID: <20241219174500.18038922@jic23-huawei>
In-Reply-To: <20241214191421.94172-3-vassilisamir@gmail.com>
References: <20241214191421.94172-1-vassilisamir@gmail.com>
	<20241214191421.94172-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 20:14:19 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

Patch needs a new title.  I'll fix it up.

Use a small fixed size buffer to replace dynamic allocation

with that, applied.

Thanks,


> Drop the recurrent allocation of the data buffer from the trigger
> handler and put it in the iio_priv(). This way, the maximum amount of
> channels is always allocated in favor of simpler code and drop
> of usage of the internal private variable "scan_timestamp" of the
> struct iio_dev.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/adc/max1363.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 9a0baea08ab6..e8d731bc34e0 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -161,6 +161,7 @@ struct max1363_chip_info {
>   * @vref_uv:		Actual (external or internal) reference voltage
>   * @send:		function used to send data to the chip
>   * @recv:		function used to receive data from the chip
> + * @data:		buffer to store channel data and timestamp
>   */
>  struct max1363_state {
>  	struct i2c_client		*client;
> @@ -186,6 +187,10 @@ struct max1363_state {
>  						const char *buf, int count);
>  	int				(*recv)(const struct i2c_client *client,
>  						char *buf, int count);
> +	struct {
> +		u8 buf[MAX1363_MAX_CHANNELS * 2];
> +		aligned_s64 ts;
> +	} data;
>  };
>  
>  #define MAX1363_MODE_SINGLE(_num, _mask) {				\
> @@ -1462,22 +1467,10 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct max1363_state *st = iio_priv(indio_dev);
> -	__u8 *rxbuf;
>  	int b_sent;
> -	size_t d_size;
>  	unsigned long numvals = bitmap_weight(st->current_mode->modemask,
>  					      MAX1363_MAX_CHANNELS);
>  
> -	/* Ensure the timestamp is 8 byte aligned */
> -	if (st->chip_info->bits != 8)
> -		d_size = numvals*2;
> -	else
> -		d_size = numvals;
> -	if (indio_dev->scan_timestamp) {
> -		d_size += sizeof(s64);
> -		if (d_size % sizeof(s64))
> -			d_size += sizeof(s64) - (d_size % sizeof(s64));
> -	}
>  	/* Monitor mode prevents reading. Whilst not currently implemented
>  	 * might as well have this test in here in the meantime as it does
>  	 * no harm.
> @@ -1485,21 +1478,16 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  	if (numvals == 0)
>  		goto done;
>  
> -	rxbuf = kmalloc(d_size,	GFP_KERNEL);
> -	if (rxbuf == NULL)
> -		goto done;
>  	if (st->chip_info->bits != 8)
> -		b_sent = st->recv(st->client, rxbuf, numvals * 2);
> +		b_sent = st->recv(st->client, st->data.buf, numvals * 2);
>  	else
> -		b_sent = st->recv(st->client, rxbuf, numvals);
> +		b_sent = st->recv(st->client, st->data.buf, numvals);
>  	if (b_sent < 0)
> -		goto done_free;
> +		goto done;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, rxbuf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
>  					   iio_get_time_ns(indio_dev));
>  
> -done_free:
> -	kfree(rxbuf);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  


