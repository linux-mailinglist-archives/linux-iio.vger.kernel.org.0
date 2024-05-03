Return-Path: <linux-iio+bounces-4779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9041E8BAA8C
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 12:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A2328249A
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D22A1509B5;
	Fri,  3 May 2024 10:11:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C17E14EC6A
	for <linux-iio@vger.kernel.org>; Fri,  3 May 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731113; cv=none; b=BnnhmHlWYnmgvIQRyXjZ8mFsRvktyBO+uNcKd2Ck/ebND8al8eYEH2q8VQO1Nd14hzDYWM3IoJ6WkCNAC+KfdzYFwVZ8xB3dlTz+nvDDYpu+kVKjICXcesG44M6ZBWc192pqHTl7wKwjftxDqekRKwaUbGEc2NIhMHyQ3PrW+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731113; c=relaxed/simple;
	bh=/3FhnwBZ82C4QMe8B3pttvqhb4JP3AT+SLb92s2ozqU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT0R9kOHlLPVh7NixwRnXsrt6WGy26qsXtVwNplu3zWADXuHDqpNPNlmi9o3vy5RHFw/08EPSTgcxVa4UrTPsDMWqgX+p9k+JV7NkGJD7L0tndwHcKbJsS99uApBA5ch652c90HAm5LLuJpsl0jh5uAiW+dgJwle+YpA0i07Hlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VW65l4Z3Rz6D99S;
	Fri,  3 May 2024 18:11:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D32F8140C9C;
	Fri,  3 May 2024 18:11:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 May
 2024 11:11:25 +0100
Date: Fri, 3 May 2024 11:11:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <inv.git-commit@tdk.com>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp patch integration
Message-ID: <20240503111124.000070c1@Huawei.com>
In-Reply-To: <20240503090700.235707-1-inv.git-commit@tdk.com>
References: <20240503090700.235707-1-inv.git-commit@tdk.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri,  3 May 2024 09:07:00 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> For fixing commit a5918cecaec3650df in iio tree.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Squashed in and togreg tree updated. Please check it!

I'm not having a good run with this patch, so maybe this is 3rd time lucky ;)

Jonathan

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index bce25ff57ecd..63b85ec88c13 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -503,6 +503,8 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
>  
>  int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
>  {
> +	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
> +	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
>  	struct inv_sensors_timestamp *ts;
>  	int ret;
>  
> @@ -511,7 +513,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
>  
>  	/* handle gyroscope timestamp and FIFO data parsing */
>  	if (st->fifo.nb.gyro > 0) {
> -		ts = iio_priv(st->indio_gyro);
> +		ts = &gyro_st->ts;
>  		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
>  						st->timestamp.gyro);
>  		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
> @@ -521,7 +523,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
>  
>  	/* handle accelerometer timestamp and FIFO data parsing */
>  	if (st->fifo.nb.accel > 0) {
> -		ts = iio_priv(st->indio_accel);
> +		ts = &accel_st->ts;
>  		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
>  						st->timestamp.accel);
>  		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
> @@ -535,6 +537,8 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
>  int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
>  				     unsigned int count)
>  {
> +	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
> +	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
>  	struct inv_sensors_timestamp *ts;
>  	int64_t gyro_ts, accel_ts;
>  	int ret;
> @@ -550,7 +554,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
>  		return 0;
>  
>  	if (st->fifo.nb.gyro > 0) {
> -		ts = iio_priv(st->indio_gyro);
> +		ts = &gyro_st->ts;
>  		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
>  		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
>  		if (ret)
> @@ -558,7 +562,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
>  	}
>  
>  	if (st->fifo.nb.accel > 0) {
> -		ts = iio_priv(st->indio_accel);
> +		ts = &accel_st->ts;
>  		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
>  		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
>  		if (ret)


