Return-Path: <linux-iio+bounces-8202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CB7946A03
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5903281C1A
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7DB14D447;
	Sat,  3 Aug 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8VOsRTP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1921DDCE;
	Sat,  3 Aug 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722694413; cv=none; b=oRDBRZxzARuMv4oNxHqe2u4Lqk7Zl20lqnfNs2rdDQP9QVk+ZOH90ghlxq9ipw/+5Q4LtlrCaaRVW/FrKThbMsgKssCIcNHozlH0i+JlLTpw8GDklhlBL7UfsS7bdoVcbq8IUla+IvXl4RORsaU8YbzS+bnrLf1QH71GKVso4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722694413; c=relaxed/simple;
	bh=VbBofw26+dYf5sGYYe6g+rj+qSgMitZL0LQvUHFaMbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qty6dWk2OzsHwocsECPFBgrzLk1dBw/ZHU6OZq/5Dtjx2tRYm8HdgBFWBDy5Qm2eZDHVs6PwhpV/Z/+T96VP25lDcLWUOolkcBzI5SKVPwG1ViU14l6JTS5kkSlYMWl664bdQwnd0ejYHBbD8x63joXHNWfH2PDuSFzzbVN3Qg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8VOsRTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466C2C116B1;
	Sat,  3 Aug 2024 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722694412;
	bh=VbBofw26+dYf5sGYYe6g+rj+qSgMitZL0LQvUHFaMbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g8VOsRTPGN9KMNvnDX4wwJASmVjdmleSl24p0SFvO5oIouLgpvermAUTYhl6zUYFf
	 3SJmP+aWwp4uwhZ9r/DhTt/ScZHLa3Ls9lwrBzywT9/pDWoA5DYpbZtOkCuRnldseK
	 ZdJ4eSuu32T2XKe0I2Y3wmwaU3Dy69khCg4ysbelKuzNjmmttpwtukjou+lyYSEja5
	 KmqozBK0Y03pTcctogi8gJi8RIOheOAwJw6gtkbXsFYDGDEBlTs6MsJWW4XjyJtX9c
	 ZExHsUrQRjAjKD5tZZnHdhBsa/Gfk4XwmdWSZ9pH49n7UDqf2TEMYidTZBISgnhPs/
	 IsdzPw+9/U28Q==
Date: Sat, 3 Aug 2024 15:13:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: light: ltr390: Calculate 'counts_per_uvi'
 dynamically
Message-ID: <20240803151327.6212d29b@jic23-huawei>
In-Reply-To: <20240731063706.25412-4-abhashkumarjha123@gmail.com>
References: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
	<20240731063706.25412-4-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 12:07:05 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> counts_per_uvi depends on the current value of gain and resolution.
> Hence, we cannot use the hardcoded value 96.
> The `counts_per_uvi` function gives the count based on the current gain
> and resolution (integration time).
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
A few additional minor comments inline as you are doing a v6 anyway.

Thanks,

Jonathan

> ---
>  drivers/iio/light/ltr390.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index d3ce43f20..84c084bec 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -46,6 +46,8 @@
>  #define LTR390_UVS_MODE	      BIT(3)
>  #define LTR390_SENSOR_ENABLE  BIT(1)
>  
> +#define LTR390_FRACTIONAL_PRECISION 100
> +
>  /*
>   * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
>   * the sensor are equal to 1 UV Index [Datasheet Page#8].
> @@ -120,6 +122,16 @@ static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
>  	return 0;
>  }
>  
> +static int ltr390_counts_per_uvi(struct ltr390_data *data)
> +{
> +	int orig_gain = 18;
> +	int orig_int_time = 400;

add const to these two.

> +	int divisor = orig_gain * orig_int_time;
I'd use this orig_gain * orig_int_time inline.

> +	int gain = data->gain;

Use this data->gain inline.

> +
> +	return DIV_ROUND_CLOSEST(23 * gain * data->int_time_us, 10 * divisor);
> +}
> +
>  static int ltr390_read_raw(struct iio_dev *iio_device,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
> @@ -160,8 +172,8 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
>  			if (ret < 0)
>  				return ret;
>  
> -			*val = LTR390_WINDOW_FACTOR;
> -			*val2 = LTR390_COUNTS_PER_UVI;
> +			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
> +			*val2 = ltr390_counts_per_uvi(data);
>  			return IIO_VAL_FRACTIONAL;
>  
>  		case IIO_LIGHT:


