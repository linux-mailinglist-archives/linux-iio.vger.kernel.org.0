Return-Path: <linux-iio+bounces-18678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE2DA9DA1F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 12:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA8B1BA498A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FAC21E0BD;
	Sat, 26 Apr 2025 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAohL+zO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4A4A11;
	Sat, 26 Apr 2025 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745663735; cv=none; b=TuOfnQhlx/5isj6eOW4cAdqsxaWftIWBPANT1uZ826PUtFqkhuQ2dbXdozee+chmUOQI75lUIqn0IV2INW8uJs2i8Ez1JN6xZVtoisWQciF4Y/jrOvpqxr5FZaSYn/Nve92OD+LkZWe/YS188rth3SOe7SIWnhdkNHPSZMz+RW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745663735; c=relaxed/simple;
	bh=i8cDxMGUpkLnVgo9XK3kLh6sBf1XEthOL/++p313vBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMk2QNntTRHV4S6clGW7WEqpPuApwa5VRVPVJMn7wfvZPmNMPam2b503FIB3IYtvL3b0Jp8dSgcKYw18+K9/8bMcRCKC2pZ4yk0oqGT7Z1xvfCccFAreKXO5P/BV5AfmGbYTd3AqBEX0Dj1ZDob0hI+EDn+6t4GjDnW5T1i92e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAohL+zO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E761C4CEE2;
	Sat, 26 Apr 2025 10:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745663735;
	bh=i8cDxMGUpkLnVgo9XK3kLh6sBf1XEthOL/++p313vBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CAohL+zOpOLy87N5MjephXKH1v0BxnNRdO/GD9WYEXLhJb2bnwFH88g+N97KqAHIS
	 0d3XjWiZBkJKeHLKO9+Bgg4kYMSKKwUMIgLThWuqR+xV5mXTvSMFZKBKn29lyR5StN
	 7JrQxhmTvws3rwtdh2AQ+7h0YhfD/xMcA/5SgEMKLrfZVW8REe+Sx4yCV9KyJmcC9N
	 o/8xiRq31kgsOZteSfmhuUsaJeAckyrqnBVod/BKO3a+/RPZeLgPYHwjYV9d5ydSum
	 UftcjICtZ65jJMXyx24LCnlmVWKHmun8YYMmLiY1fqmiSj690hEP3/tekVcwAy/tR3
	 ZPcwv2n362u7w==
Date: Sat, 26 Apr 2025 11:35:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: sca3000: remove duplicated code in
 sca3000_read_data()
Message-ID: <20250426113527.20b2069b@jic23-huawei>
In-Reply-To: <20250425235130.56122-1-andrew.lopes@alumni.usp.br>
References: <20250425235130.56122-1-andrew.lopes@alumni.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 20:50:51 -0300
Andrew Ijano <andrew.ijano@gmail.com> wrote:

> Remove duplicated code between sca3000_read_data() and
> sca3000_read_data_short() functions.
> 
> The common behavior is centralized in just one sca3000_read_data()
> function and used for every case.
> 
> Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
> Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>

Look at the helpers that exist for spi sequences like this.
This is an old driver so may not be making full use of newer infrastructure.

In particular a lot of these can probably become spi_w8r8()and
it may make sense to move the SCA3000_READ_REG() to the callers to avoid the
need for these helpers at all.

Note that is not an appropriate change for the large reads though as
spi_write_then_read() bounces all buffers and so would add a copy
to those high(ish) performance paths.

> ---
>  drivers/iio/accel/sca3000.c | 82 ++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index aabe4491efd7..c4b1da7f8de1 100644
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
>  
>  /**
> @@ -309,7 +313,7 @@ static int sca3000_reg_lock_on(struct sca3000_state *st)
>  {
>  	int ret;
>  
> -	ret = sca3000_read_data_short(st, SCA3000_REG_STATUS_ADDR, 1);
> +	ret = sca3000_read_data(st, SCA3000_REG_STATUS_ADDR, 1);
As above this could be simply
	ret = spi_w8r8(st->spi, SCA3000_READ_REG(SCA3000_REG_STATUS_ADDR));
	if (ret)
		return ret;
	return !(ret & SCA3000_LOCKED);


I think...
You will want to walk through how that helper is implemented to check it
ends up doing the same thing as the existing code though and remove
st->rx as part of the conversion.


>  	if (ret < 0)
>  		return ret;
>  
> @@ -412,7 +416,7 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
>  	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg);
>  	if (ret)
>  		goto error_ret;
> -	ret = sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
> +	ret = sca3000_read_data(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
>  	if (ret)
>  		goto error_ret;
>  	return st->rx[0];
> @@ -432,7 +436,7 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->lock);
> -	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
> +	ret = sca3000_read_data(st, SCA3000_REG_REVID_ADDR, 1);
>  	if (ret < 0)
>  		goto error_ret;
>  	dev_info(&indio_dev->dev,
> @@ -575,7 +579,7 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
>  {
>  	int ret;
>  
> -	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
>  	if (ret)
>  		goto error_ret;
>  	switch (SCA3000_REG_MODE_MODE_MASK & st->rx[0]) {
> @@ -665,7 +669,7 @@ static int sca3000_read_3db_freq(struct sca3000_state *st, int *val)
>  {
>  	int ret;
>  
> -	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
>  	if (ret)
>  		return ret;
>  
> @@ -703,7 +707,7 @@ static int sca3000_write_3db_freq(struct sca3000_state *st, int val)
>  		mode = SCA3000_REG_MODE_MEAS_MODE_OP_2;
>  	else
>  		return -EINVAL;
> -	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
>  	if (ret)
>  		return ret;
>  
> @@ -732,7 +736,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
>  				return -EBUSY;
>  			}
>  			address = sca3000_addresses[chan->address][0];
> -			ret = sca3000_read_data_short(st, address, 2);
> +			ret = sca3000_read_data(st, address, 2);
>  			if (ret < 0) {
>  				mutex_unlock(&st->lock);
>  				return ret;
> @@ -742,7 +746,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
>  					     chan->scan_type.realbits - 1);
>  		} else {
>  			/* get the temperature when available */
> -			ret = sca3000_read_data_short(st,
> +			ret = sca3000_read_data(st,
>  						      SCA3000_REG_TEMP_MSB_ADDR,
>  						      2);

For this spi_w8r16() may be applicable.


>  			if (ret < 0) {
> @@ -830,7 +834,7 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
>  	int len = 0, ret, val;
>  
>  	mutex_lock(&st->lock);
> -	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> +	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
>  	val = st->rx[0];
>  	mutex_unlock(&st->lock);
>  	if (ret)
> @@ -969,32 +973,6 @@ static const struct attribute_group sca3000_attribute_group = {
>  	.attrs = sca3000_attributes,
>  };
>  
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
>  /**
>   * sca3000_ring_int_process() - ring specific interrupt handling.
>   * @val: Value of the interrupt status register.
> @@ -1008,7 +986,7 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
>  	mutex_lock(&st->lock);
>  
>  	if (val & SCA3000_REG_INT_STATUS_HALF) {
> -		ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
> +		ret = sca3000_read_data(st, SCA3000_REG_BUF_COUNT_ADDR,
>  					      1);
>  		if (ret)
>  			goto error_ret;
> @@ -1017,7 +995,7 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
>  		 * num_available is the total number of samples available
>  		 * i.e. number of time points * number of channels.
>  		 */
> -		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
> +		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR,
>  					num_available * 2);
This is the one case were spi_write_then_read() is probably not appropriate due to the
large buffers that are potentially involved.
I think this will be the only remaining case to use the old infrastructure.

Thanks,

Jonathan

