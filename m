Return-Path: <linux-iio+bounces-17361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB41A75B1B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958F71888FD2
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B331B1D7E57;
	Sun, 30 Mar 2025 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LERlvur5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6488F6C;
	Sun, 30 Mar 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354083; cv=none; b=YQ/su7hHeJfYMu6NkFXC8CiuvR0svRcVzVhrA17tEuFXF+s9sslT55Zqhs3UliquutqvPJ9X/gqq95Y+ApK+4BtjI9VX2u/ZdE0e/Ym0zrQn41Y8nl95DaArYHeAESjm/4l4S8dv9PWFXaDqXlU6r0DUjvzFIxoggFSY74lGZek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354083; c=relaxed/simple;
	bh=E6TymVFKzaKldCeIMXBr+IVWmwwY2H0z+CBcD6tiPQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKZvZUnBMDxaCEa2Z+Azq2eJAIC6Z/y6trTWiUVJV5HBIAjuneUjZmIWd6zpkyqTW4hcj2qe75yyiz+uKfTMijVpJnHqzy2tDdpEZowpSmqPg2nZCq3SMkSgp861IsPNp2hWNXbb1QCEI8Txw9iiBtJMYUkx3ab56Z8GHtrLQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LERlvur5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8328AC4CEDD;
	Sun, 30 Mar 2025 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743354082;
	bh=E6TymVFKzaKldCeIMXBr+IVWmwwY2H0z+CBcD6tiPQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LERlvur5PuhImnlOADPprlfXTweobrqcoCV4yoRbvAijSsEiuDc+gik5rfLUeMFYl
	 wlhF6SIYsg4kafgQ5iFv3qxEY97iMxR6bQNQZaClroNw8/AcU3mOERY4u5Ixdjg+mr
	 NZbueUecuIVbXasecmcEU6cGt2P+u0GhkcSTfcubd8ibMrup+qyIE9gwEUzeO1R6BN
	 OtQz9ieGNAQNOvMOSOCzExdBUXV5WxJwrc6ZFN9yXl4p/5heVtzVhLWQqNzZWENdNS
	 GSXyojgZ6Fr4eGha40e63ekklkVnfYQZzzmSiD4NMxQA3qIXiURk4xRajJauJh4xWd
	 pgxHtgizNsd2A==
Date: Sun, 30 Mar 2025 18:01:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: dac: ad3552r-hs: add support for internal ramp
Message-ID: <20250330180114.637e1a21@jic23-huawei>
In-Reply-To: <20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
	<20250321-wip-bl-ad3552r-fixes-v1-4-3c1aa249d163@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 21:28:51 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> The ad3552r can be feeded from the HDL controller by an internally
> generated 16bit ramp, useful for debug pourposes. Add debugfs a file
> to enable or disable it.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/ad3552r-hs.c | 106 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 100 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 37397e188f225a8099745ec03f7c604da76960b1..41fe78d982a68980db059b095fc27b37ea1a461b 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/iio/backend.h>
> @@ -65,6 +66,18 @@ static int ad3552r_hs_reg_read(struct ad3552r_hs_state *st, u32 reg, u32 *val,
>  	return st->data->bus_reg_read(st->back, reg, val, xfer_size);
>  }
>  
> +static int ad3552r_hs_set_data_source(struct ad3552r_hs_state *st,
> +				      enum iio_backend_data_source type)
> +{
> +	int ret;
> +
> +	ret = iio_backend_data_source_set(st->back, 0, type);
> +	if (ret)
> +		return ret;
> +
> +	return iio_backend_data_source_set(st->back, 1, type);
> +}
> +
>  static int ad3552r_hs_update_reg_bits(struct ad3552r_hs_state *st, u32 reg,
>  				      u32 mask, u32 val, size_t xfer_size)
>  {
> @@ -483,6 +496,66 @@ static int ad3552r_hs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>  	return st->data->bus_reg_write(st->back, reg, writeval, 1);
>  }
>  
> +static ssize_t ad3552r_hs_show_data_source(struct file *f, char __user *userbuf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct ad3552r_hs_state *st = file_inode(f)->i_private;
> +	enum iio_backend_data_source type;
> +	int ret;
> +
> +	ret = iio_backend_data_source_get(st->back, 0, &type);
> +	if (ret)
> +		return ret;
> +
> +	switch (type) {
> +	case IIO_BACKEND_INTERNAL_RAMP_16BIT:
> +		return simple_read_from_buffer(userbuf, count, ppos,
> +					       "backend-ramp-generator", 22);

Probably better to use a const string and then you can use strlen() to get
the length from that.  I don't much like counting characters!

> +	case IIO_BACKEND_EXTERNAL:
> +		return simple_read_from_buffer(userbuf, count, ppos,
> +					       "iio-buffer", 10);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t ad3552r_hs_write_data_source(struct file *f,
> +					    const char __user *userbuf,
> +					    size_t count, loff_t *ppos)
> +{
> +	struct ad3552r_hs_state *st = file_inode(f)->i_private;
> +	char buf[64];
> +	int ret;
> +
> +	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> +				     count);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[count] = 0;
> +
> +	if (count == 10 && !strncmp(buf, "iio-buffer", 10)) {
> +		ret = ad3552r_hs_set_data_source(st, IIO_BACKEND_EXTERNAL);
> +		if (ret)
> +			return ret;
> +	} else if (count == 22 && !strncmp(buf, "backend-ramp-generator", 22)) {

As above, I'd like to see some strlen() on const strings for this.
FWIW strncmp doesn't care about NULL terminators as such so just ensure you only
compare the characters.


> +		ret = ad3552r_hs_set_data_source(st,
> +			IIO_BACKEND_INTERNAL_RAMP_16BIT);
> +		if (ret)
> +			return ret;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
...

Thanks,

Jonathan



