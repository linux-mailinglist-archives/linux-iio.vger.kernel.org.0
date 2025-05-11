Return-Path: <linux-iio+bounces-19422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA0AAB27FD
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 13:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569281897028
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980122D78B;
	Sun, 11 May 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVtp7ti0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76B229B13;
	Sun, 11 May 2025 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746963266; cv=none; b=Z/3Idc95mFn+5IUnTmYu6/Y5sLiX12sqMo+wsgVCQpKZOHfHyBnuDEqQy4ySrtmq5EbuA5M4jnxG96Tcp0HCUde/CL2voE9/gIDiqqTnwBAjZqpn+cHHbizaPO8iqcwk9eTJfsKzTFgBqYq+LWGZY14rB4QXMX+9TdKR/gd1qWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746963266; c=relaxed/simple;
	bh=UTY+TckcOL9SD6HcZaxJi7PMiU4aqhm+b+2hm84H7dA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smrSfTlvyuk6OaxKPKhpHxYEOL0BqWzIMyNsWnzRiY21yBgm7AcdKqH+cJPOOZJHq7kTjUVOMrdn24Zh4fI50LP3tXu8aYKEdtFc2BUuekNC++SJV5rd0bf9Qx8Avojk4CAWj8C5CDXqjwSQCXJD6EJNgVKQaUWP8nUh27fgtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVtp7ti0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85078C4CEE4;
	Sun, 11 May 2025 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746963265;
	bh=UTY+TckcOL9SD6HcZaxJi7PMiU4aqhm+b+2hm84H7dA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fVtp7ti0ZMMxxwbll/vKXC3wOsDtGV/r4hxe3CcNOcbgg5xT4Qq6Zua0wlZHiryP1
	 TmwCqcjWhDE748P5HzqvN+Jj2RKsA3jxL2fAKjIZMavt7bcOt6YDAqWNJs3h4MVBGc
	 yml4VRcH1Yxi1i0KqZPZQCS1vmqT4HCT+xkoTxZfzoNTv7DxyVlwfBFau+5D1wipis
	 keaJ98EOes+sIQY3qBm4TSvJ/SQb8eUY19tXVoRBCrCshRVHK/FYPGF/FmNbqBtFyq
	 zirgjhWSj+ZakN8g40cDRWuyPqMUVWqjD/27t4BcwZjSpisIC/2BWEkkoQ4qLqUD4a
	 Rrr+5adg6AATA==
Date: Sun, 11 May 2025 12:34:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
Message-ID: <20250511123416.729eb50f@jic23-huawei>
In-Reply-To: <20250510190759.23921-1-andrew.lopes@alumni.usp.br>
References: <20250510190759.23921-1-andrew.lopes@alumni.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 May 2025 16:07:09 -0300
Andrew Ijano <andrew.ijano@gmail.com> wrote:

> Remove usages of sca3000_read_data() and sca3000_read_data_short()
> functions, replacing it by spi_w8r8() and spi_w8r16() helpers. Just
> one case that reads large buffers is left using an internal helper.
> 
> This is an old driver that was not making full use of the newer
> infrastructure.
> 
> Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>

A few things inline but clearly main thing is to reply to Andy's other
points on v3.

> ---
>  drivers/iio/accel/sca3000.c | 169 +++++++++++++++---------------------
>  1 file changed, 72 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index aabe4491efd7..7794efc35970 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -281,10 +281,11 @@ static int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
>  	return spi_write(st->us, st->tx, 2);
>  }
>  
> -static int sca3000_read_data_short(struct sca3000_state *st,
> -				   u8 reg_address_high,
> -				   int len)
> +static int sca3000_read_data(struct sca3000_state *st,
> +			     u8 reg_address_high,
> +			     int len)

I'd keep this where the original sca3000_read_data() is
That will give a shorter, more obvious diff and puts the code near where it
is called helping review.

>  {
> +	int ret;
>  	struct spi_transfer xfer[2] = {
>  		{
>  			.len = 1,
> @@ -296,7 +297,10 @@ static int sca3000_read_data_short(struct sca3000_state *st,
>  	};
>  	st->tx[0] = SCA3000_READ_REG(reg_address_high);
>  
> -	return spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
> +	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
> +	if (ret)
> +		dev_err(&st->us->dev, "problem reading register\n");
> +	return ret;
>  }

...

>  /**
> @@ -412,10 +416,8 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
>  	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg);
>  	if (ret)
>  		goto error_ret;
> -	ret = sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
> -	if (ret)
> -		goto error_ret;
> -	return st->rx[0];
> +
> +	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_CTRL_DATA_ADDR));
>  error_ret:
>  	return ret;
This shows the age of the code.  Just return in error paths above rather
than a error_ret: label

Might be a good idea to do a precursor patch tidying up any cases of this
before the one doin gthe spi changes in ehre.

>  }
> @@ -432,13 +434,13 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->lock);

Another patch to use guard(mutex)(&st->lock); etc would be help clean this
up by allowing direct return in the error path.

> -	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
> +	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_REVID_ADDR));
>  	if (ret < 0)
>  		goto error_ret;
>  	dev_info(&indio_dev->dev,
>  		 "sca3000 revision major=%lu, minor=%lu\n",
> -		 st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
> -		 st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
> +		 ret & SCA3000_REG_REVID_MAJOR_MASK,
> +		 ret & SCA3000_REG_REVID_MINOR_MASK);
>  error_ret:
>  	mutex_unlock(&st->lock);
>  


>  static int sca3000_read_raw(struct iio_dev *indio_dev,
> @@ -722,6 +724,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret;
>  	u8 address;
> +	__be16 raw_val;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -732,25 +735,24 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
>  				return -EBUSY;
>  			}
>  			address = sca3000_addresses[chan->address][0];
> -			ret = sca3000_read_data_short(st, address, 2);
> +			ret = spi_w8r16(st->us, SCA3000_READ_REG(address));

spi_w8r16be() then no need for the endian conversion below.


>  			if (ret < 0) {
>  				mutex_unlock(&st->lock);
>  				return ret;
>  			}
> -			*val = sign_extend32(be16_to_cpup((__be16 *)st->rx) >>
> -					     chan->scan_type.shift,
> +			raw_val = (__be16) ret;
> +			*val = sign_extend32(be16_to_cpu(raw_val) >> chan->scan_type.shift,
>  					     chan->scan_type.realbits - 1);
>  		} else {
>  			/* get the temperature when available */
> -			ret = sca3000_read_data_short(st,
> -						      SCA3000_REG_TEMP_MSB_ADDR,
> -						      2);
> +			ret = spi_w8r16(st->us,
> +						SCA3000_READ_REG(SCA3000_REG_TEMP_MSB_ADDR));

As above. spi_w8r16be()


>  			if (ret < 0) {
>  				mutex_unlock(&st->lock);
>  				return ret;
>  			}
> -			*val = (be16_to_cpup((__be16 *)st->rx) >>
> -				chan->scan_type.shift) &
> +			raw_val = (__be16) ret;
> +			*val = (be16_to_cpu(raw_val) >> chan->scan_type.shift) &
>  				GENMASK(chan->scan_type.realbits - 1, 0);
>  		}
>  		mutex_unlock(&st->lock);

>  

As above. Put the new implementation of this here so we can easily see what
changed.

> -static int sca3000_read_data(struct sca3000_state *st,
> -			     u8 reg_address_high,
> -			     u8 *rx,
> -			     int len)
> -{
> -	int ret;
> -	struct spi_transfer xfer[2] = {
> -		{
> -			.len = 1,
> -			.tx_buf = st->tx,
> -		}, {
> -			.len = len,
> -			.rx_buf = rx,
> -		}
> -	};
> -
> -	st->tx[0] = SCA3000_READ_REG(reg_address_high);
> -	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
> -	if (ret) {
> -		dev_err(&st->us->dev, "problem reading register\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
Jonathan

