Return-Path: <linux-iio+bounces-14837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3CA24A78
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222BC166512
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2141C5D78;
	Sat,  1 Feb 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLpHOprM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0311C5D68;
	Sat,  1 Feb 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738427878; cv=none; b=u0OQ3CRR6PE47lINvNLycRajOSCjSZuEJYU5qcsNjfz9L27b5BCE5kEUQqacUiO8gEd2KmqVe7rHHXBIzYDTGV5hU6OCSFVN0PBhpq6W/5XezU5MY12Kp68ale3m5EZkO7oFiOwWFPw3+ToyNC2Kb0/3oCa9e+o64OZndRwT3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738427878; c=relaxed/simple;
	bh=+1uXDoqh7n4l1Ik5RnjCTzuNqrOVLeidvJ5uh8kJTk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyAqnl5tkLzMaPd0pLsZPUO6WaY7IxwKsWpjAlKZ7xv2+RuwfNttYm48A3OG7/m8zrESMfGK15Et7JT+mCyd9NLcL/rUgLL6TgOm68FONOOiR0JfwoG5vZw8nGInmSgfjOBJQHGU94g8ZTrJ1VY7ke/iBB/JHY3ZpEYbJil29mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLpHOprM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E172C4CED3;
	Sat,  1 Feb 2025 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738427878;
	bh=+1uXDoqh7n4l1Ik5RnjCTzuNqrOVLeidvJ5uh8kJTk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OLpHOprMI/N4nqh5nNUM1EQmcmzRTCC71fdSSG4zqka76OcU4lHazhkFfMJUiIFCy
	 Skl0QO21rzCKZkFUQp9RUxmp1VRcS94BQu72sAy6D6VWkuoZnzG9/TuIu5jFbZH27/
	 9fW8xySSgObJ8ZxmjBbGJK/nrTtFQateUBJ1eg6RmPigymNEyzYvFiKAYQyBjn3j7r
	 iLm2rd1G+ZcmYYHaRFNZ9QFNhe4vLIcBFgpg4ElEJLgcSY2G/T4PSx78ZK5/XUKg/H
	 bbdB31Bid/195oiT9rP36gOI4opGzJNLgsb821bhgMAa4jAgLju8ZhsryayBz4LPVO
	 CCc6esCnj9N0w==
Date: Sat, 1 Feb 2025 16:37:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 02/12] iio: accel: adxl345: reorganize measurement
 enable
Message-ID: <20250201163753.24a63a06@jic23-huawei>
In-Reply-To: <20250128120100.205523-3-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:50 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> In order to have this function generically available a position at the
> top makes more sense. In upcomming patches for particular features the
> function needs to be available, to turn off measuring while changing
> settings, and turn it on again afterwards.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 54 ++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index ffdb03ed7a25..142f12117627 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -163,6 +163,33 @@ static const unsigned long adxl345_scan_masks[] = {
>  	0
>  };
>  
> +/**
> + * adxl345_set_measure_en() - Enable and disable measuring.
> + *
> + * @st: The device data.
> + * @en: Enable measurements, else standby mode.
> + *
> + * For lowest power operation, standby mode can be used. In standby mode,
> + * current consumption is supposed to be reduced to 0.1uA (typical). In this
> + * mode no measurements are made. Placing the device into standby mode
> + * preserves the contents of FIFO.
> + *
> + * Return: Returns 0 if successful, or a negative error value.
> + */
> +static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
> +{
> +	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
> +
> +	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> +}
> +
> +static void adxl345_powerdown(void *ptr)
> +{
> +	struct adxl345_state *st = ptr;
> +
> +	adxl345_set_measure_en(st, false);
> +}
Why move powerdown?  This looks to be a devm callback, if that's all it used for
leave that down near wherever it is used.
Moving set_measure_en makes sense, just not this user of it.

> +
>  static int adxl345_set_interrupts(struct adxl345_state *st)
>  {
>  	int ret;
> @@ -301,33 +328,6 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -/**
> - * adxl345_set_measure_en() - Enable and disable measuring.
> - *
> - * @st: The device data.
> - * @en: Enable measurements, else standby mode.
> - *
> - * For lowest power operation, standby mode can be used. In standby mode,
> - * current consumption is supposed to be reduced to 0.1uA (typical). In this
> - * mode no measurements are made. Placing the device into standby mode
> - * preserves the contents of FIFO.
> - *
> - * Return: Returns 0 if successful, or a negative error value.
> - */
> -static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
> -{
> -	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
> -
> -	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> -}
> -
> -static void adxl345_powerdown(void *ptr)
> -{
> -	struct adxl345_state *st = ptr;
> -
> -	adxl345_set_measure_en(st, false);
> -}
> -
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>  "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
>  );


