Return-Path: <linux-iio+bounces-16895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85F2A63553
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F6616F90B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8061A23B9;
	Sun, 16 Mar 2025 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx2QcL7h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA86519E997;
	Sun, 16 Mar 2025 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742124167; cv=none; b=Zgrd6sPEYgw7HHUlSP8nyPJnOK7QOh9WgkioVqRwNYiKRStGV8cKRelHUYGSS0NDZtNJMjZUYemd7AvXN3NUg4JX7kzIRyxnc5blBjHXyN6OXIic6Y3dzMFxXXXlizqiSdm+cu1l1tS/c9hecvfvM7IK7vtuEJ5VhjOxoTLds3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742124167; c=relaxed/simple;
	bh=R9W3cFQ9XueTg/Y/8vuQmPZTaWSWiUkWlorI9h8XGac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oW8zBzikPbna/8Iu8LKSbA1guWTG4H3RWgHsAsSJnzLH1kfS98U8+LT4+lgPZ4RL8/tOkaKrDSwKROmfsUjObC2OBTeuYAD9WfQah2o1WQNnue2d8U0hapX/R84w79DEViWu7l9aavJEyn7PFM126lpSoC3T0zFsWv3mMgnF2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx2QcL7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640D7C4CEDD;
	Sun, 16 Mar 2025 11:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742124166;
	bh=R9W3cFQ9XueTg/Y/8vuQmPZTaWSWiUkWlorI9h8XGac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rx2QcL7hgEFe1QluOrkxsuicQUbmNRkjbUTpRHZWxiWVeNJ5VtZlm30g9nuOw7KPd
	 IeZH1Tz0ZGtqCHGlLmnCfqKAMCVkTMUig+iuJYrCLz9GnjDthtuVWLTUTF296X1B6g
	 vxntZVWgaoOysktEPjIrDXEmTepTsqfC7WUDNwv3G1N42b/PAllgXSJYT3Cx8RjV/g
	 rc4rGWK72Zq6j6QMnfhzGinTOBeFLanOIVPJrm46QgK0FnZDU9hcTrkzBdRAgYlXZ5
	 SZlK8KiJ64OZ9rbgCsV4GnBX9UA/tSUP26qudMI6iN+w3d5ufMy3kSR4qc9Mq7AOeH
	 Rb5pqYDVaN9MQ==
Date: Sun, 16 Mar 2025 11:22:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v4 05/14] iio: accel: adxl345: add single tap feature
Message-ID: <20250316112057.638626bd@jic23-huawei>
In-Reply-To: <20250313165049.48305-6-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 16:50:40 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the single tap feature with a threshold in 62.5mg/LSB points and a
> scaled duration in us. Keep singletap threshold in regmap cache but
> the scaled value of duration in us as member variable.
> 
> Both use IIO channels for individual enable of the x/y/z axis. Initializes
> threshold and duration with reasonable content. When an interrupt is
> caught it will be pushed to the according IIO channel.
> 

> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Hi Lothar,

A few things in here are from the discussion that was continuing
on v3 so I may have said more replying to that.

Anyhow, for now I'll hold off on applying from this point on as
a few more things to respond to inline.

Jonathan

>  
>  #include "adxl345.h"
> @@ -31,6 +33,33 @@
>  #define ADXL345_INT1			0
>  #define ADXL345_INT2			1
>  
> +#define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
> +
> +enum adxl345_axis {
> +	ADXL345_Z_EN = BIT(0),
> +	ADXL345_Y_EN = BIT(1),
> +	ADXL345_X_EN = BIT(2),
> +	/* Suppress double tap detection if value > tap threshold */
> +	ADXL345_TAP_SUPPRESS = BIT(3),
> +};
As per feedback (after you sent this!) on v3, I'd drop
the last value out of the enum, or just use defines and a u8 for
the one place this is used for local variable storage.


> @@ -198,6 +387,132 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int adxl345_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	bool int_en;
> +	int ret = -EFAULT;
Not used?

> +
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (dir) {
> +		case IIO_EV_DIR_SINGLETAP:
> +			ret = adxl345_is_tap_en(st, chan->channel2,
> +						ADXL345_SINGLE_TAP, &int_en);
> +			if (ret)
> +				return ret;
> +			return int_en;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int adxl345_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = adxl345_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> +
So in my brief reply to the v3 discussion I suggested perhaps
factoring out everything from here...
> +	switch (type) {
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP,
> +					   min(val, 0xFF));
> +			break;
> +		case IIO_EV_INFO_TIMEOUT:
> +			ret = adxl345_set_tap_duration(st, val, val2);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
to here, so as to allow simple direct returns.

I think that will make the code more readable given the need to reenable
measurements and that you want to leave it off on error.

> +
> +	if (ret)
> +		return ret; /* measurement stays off */
> +
> +	return adxl345_set_measure_en(st, true);
> +}


