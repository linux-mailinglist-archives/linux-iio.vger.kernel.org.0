Return-Path: <linux-iio+bounces-16338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F9EA4DF1A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8543B2F65
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284412045A2;
	Tue,  4 Mar 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5maSlvC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A632040BE;
	Tue,  4 Mar 2025 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094612; cv=none; b=qEHQM/i8K+azr65gj3Xag3yMHaq2JBdEQM0+4aC3LAdtDgsIngf7/oQT6P+xGSpn1fE7kVN46jkxoh6/RoEDBCAYHEle4Pc4kIEs+qJJna1zWBSrKFBUn4PemuxvC+jydsvnGNBABztYJFCji4C034/7p0SsIkpCteiUvhkpXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094612; c=relaxed/simple;
	bh=DAF+2kZZ0oDnbkFVJVJ5OSH+2Np9hxUCkbGAdD2yE9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouJLZZzaIbBU20mhSz53BCeManDCN2pLNiWUPe0IeyqZakK10HExg3qT8BksDA4HbkpOpyt2eDk6ypXZ09OhqtSl6D6YKb5jpjcZU8kzJ1Q3RQ11rqUbmB5qRTH1UG+rQOgUKgsMOykFpKhMmJhOgKUcjSF/od53PF8nqkmAECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5maSlvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F26C4CEE5;
	Tue,  4 Mar 2025 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741094612;
	bh=DAF+2kZZ0oDnbkFVJVJ5OSH+2Np9hxUCkbGAdD2yE9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X5maSlvC5PHaXeBbA2gQMLAQxEwb4vSmUSiBoYCGjoo64AE8rhpxyI6+zoYQJPPHJ
	 0rXjye3aPIdTnJU0kXdv+hlE1fgKE4QMUN/1ttU5Ayx7I86i6hbaJPGAXNxe+A4BQb
	 td341pOTPUOOwxhngB+zYWtOzMEdaq2UyMk/c/AEgwvnGqnVKPpYKODkywVG5I6o3J
	 E+V4IR/DaJjPk3MeEUexarcSNo1xyqEvqxVsbbAXo3ClE9xVlNZ+/OFgY8WPu6GkXD
	 Dc3uDHzNXeHWpMrWvW63uDSK8r+jKbq9CdUVc0Ma6qx+g9tB7/RpBEPop/JVqskRB0
	 uVazDmee68cYA==
Date: Tue, 4 Mar 2025 13:23:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 09/15] iio: accel: adxl345: add freefall feature
Message-ID: <20250304132320.5caad2d2@jic23-huawei>
In-Reply-To: <20250220104234.40958-10-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:28 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the freefall detection of the sensor together with a threshold and
> time parameter. A freefall event is detected if the measuring signal
> falls below the threshold.
> 
> Introduce a freefall threshold stored in regmap cache, and a freefall
> time, having the scaled time value stored as a member variable in the
> state instance.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi, one thing inline.

> @@ -855,6 +958,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
>  			return ret;
>  	}
>  
> +	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
> +		ret = iio_push_event(indio_dev,
> +				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +							IIO_MOD_X_OR_Y_OR_Z,
> +							IIO_EV_TYPE_MAG,
> +							IIO_EV_DIR_FALLING),
> +				     ts);
> +		if (ret)
> +			return ret;
> +	}
> +

Seems unlikely to be right. Pushed an event without error yet this function
is returning an error here?

>  	return -ENOENT;
>  }
>  
> @@ -954,6 +1068,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  					 ADXL345_DATA_FORMAT_FULL_RES |
>  					 ADXL345_DATA_FORMAT_SELF_TEST);
>  	unsigned int tap_threshold;
> +	unsigned int ff_threshold;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -973,6 +1088,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
>  	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
>  
> +	ff_threshold = 8;			/*    8 [0x08]            */
> +	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
> +
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1049,6 +1167,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		if (ret)
>  			return ret;
>  
> +		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, ff_threshold);
> +		if (ret)
> +			return ret;
> +
>  		/* FIFO_STREAM mode is going to be activated later */
>  		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
>  		if (ret)


