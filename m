Return-Path: <linux-iio+bounces-24920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8ABCE231
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 19:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C047E4F0929
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA0234984;
	Fri, 10 Oct 2025 17:44:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87A22157F;
	Fri, 10 Oct 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118285; cv=none; b=NC0L3LmR0s6X04oR3pnFZO3IgczuEN7zU9qYV/T+izRKtpqnChfUy9LDGLvKpUq24Gzb5TmQuv0v27he9IXSOrSe08Aa3yRRGVYlgpERsIJi8dYOT4sS/fUwYNNqNfnwLjTvN91spdHyipEDWjjfAPX0HTb9qNTa+Jgn4lHDlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118285; c=relaxed/simple;
	bh=xa/LDCE1IR+Wes0Wpil4GLi0GhmjvATifvtOD9qRiuM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeOHSzW5FsiIZ29pqKVme/gRQ90+RPZ4bBxRB+dxWTFtWrs2YbatgJNDLWfr+mIJsmZvfV3zxMc6UBqCmEdqnwodYczyrg2Zo3/Xk6zLEzE5y1kcRK7ZHq7foI2rQAieQjDRkK4nRjujz3p3U87+Uk8oLpZsHRL26Zkt0ff9Zto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjvDZ0qVdz6M4PW;
	Sat, 11 Oct 2025 01:41:18 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1424A1402F0;
	Sat, 11 Oct 2025 01:44:40 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Oct
 2025 18:44:39 +0100
Date: Fri, 10 Oct 2025 18:44:37 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Francesco Lavra <flavra@baylibre.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
Message-ID: <20251010184437.00004428@huawei.com>
In-Reply-To: <20251009173609.992452-3-flavra@baylibre.com>
References: <20251009173609.992452-1-flavra@baylibre.com>
	<20251009173609.992452-3-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu,  9 Oct 2025 19:36:09 +0200
Francesco Lavra <flavra@baylibre.com> wrote:

> The rate at which accelerometer or gyroscope sensor samples are fed
> to the hardware FIFO (batch data rate, or BDR) does not have to
> coincide with the sensor sampling frequency (output data rate, or
> ODR); the only requirement is for the BDR to not be greater than
> the ODR. Having a BDR lower than the ODR is useful in cases where
> an application requires a high sampling rate for accurate detection
> of motion events (e.g. wakeup events), but wants to read sensor
> sample values from the device buffer at a lower data rate.
> To support the above use case, add a sampling_frequency sysfs
> attribute to the buffer directory of st_lsm6dsx IIO devices, which
> controls the BDR for a given sensor independently from the "main"
> sampling_frequency attribute (which controls the ODR); introduce a
> new `bdr` field in struct st_lsm6dsx_sensor to keep track of the
> current BDR value, and use this field instead of the `odr` field in
> the code that deals with the FIFO data rate. In the sensor hub
> driver, make the bdr value always mirror the odr value, since there
> is no separate configuration setting to control the BDR for data
> produced by the sensor hub functionality.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

A few additional trivial things from me.  In general this looks fine.
Whilst that buffer/sampling_frequency isn't common it's been part
of the ABI for a while for this sort of thing.

My only slight concern is backwards compatibility. 
Perhaps you can add something on what happens if main sampling_frequency
is modified by a user who doesn't know anything about buffer/sampling_frequency?

Given that's a new interface and the ABI always allows a write to one
value to change any other maybe we have to say the main sampling frequency
write updates the buffer one and a write to the buffer one after that is needed
to set it to a different value?

That is a bit ugly but it is backwards compatible I think.



> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 8a9d2593576a..5912ea76d493 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -56,6 +56,7 @@
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
>  
> @@ -105,7 +106,7 @@ static int
>  st_lsm6dsx_get_decimator_val(struct st_lsm6dsx_sensor *sensor, u32 max_odr)
>  {
>  	const int max_size = ARRAY_SIZE(st_lsm6dsx_decimator_table);
> -	u32 decimator =  max_odr / sensor->odr;
> +	u32 decimator =  max_odr / sensor->bdr;

No idea why there is a bonus space after = but good to cleanup whilst you are
here.

>  	int i;

> +static ssize_t st_lsm6dsx_bdr_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct iio_dev *iio_dev = dev_to_iio_dev(dev);
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	int integer, fract;
> +	int ret;
> +	u32 bdr;
> +	u8 data;
> +
> +	ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
> +	if (ret)
> +		return ret;

Add blank line after this sort of error handling return.  Slightly helps
with readability.

> +	bdr = integer * 1000 + fract;
> +	ret = st_lsm6dsx_check_odr(sensor, bdr, &data);
> +	if (ret < 0)
> +		return ret;
Here as well.
> +	bdr = ret;

Probably here as well.

> +	if (!iio_device_claim_direct(iio_dev))
> +		return -EBUSY;
> +	/* the batch data rate must not exceed the sensor output data rate */
> +	if (bdr <= sensor->odr)
> +		sensor->bdr = bdr;
> +	else
> +		ret = -EINVAL;
> +	iio_device_release_direct(iio_dev);
Add one before the final return.
> +	return (ret < 0) ? ret : len;
> +}



