Return-Path: <linux-iio+bounces-22173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DA8B180B8
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 13:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09447A8C2B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9137238C2D;
	Fri,  1 Aug 2025 11:09:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B902222BF;
	Fri,  1 Aug 2025 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046554; cv=none; b=A5urcjKsYItkx1MfTXuwhKzVnOv4bBdCfZWHSAC25TtNRun3hPQz7a2sP09zwgzVbgW9SGxpxeJEdWOXIMU6gce+bsHCWqLA6guayw1OCMk+cEuyTpPUF8x/6qTErhXAM0GaUusOaLDT9OXBciP+czyYy3n+3rDqGlJ7U7d7/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046554; c=relaxed/simple;
	bh=NigLUa4w/k1HoW/MmyxPaMDOUX2e4G69nrz7iA1pm3c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C61btOZee80j3u3qnX0PFQS46pBgBNSDVTRCfYfv/j18SW5bjElxB945KZ8kyjc7n7R/qgaltYtlbSeRri4r9hN8OVjG5J0RlOLxwnqsEc6lw/owq1mHzEClbV9nw7FYsAlhMQpgCuN7f0srQlsmsnzJeca7wz48x77dNqV4tos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4btjpN5WDnz6D9J3;
	Fri,  1 Aug 2025 19:07:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EACD1402FE;
	Fri,  1 Aug 2025 19:09:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 1 Aug
 2025 13:09:03 +0200
Date: Fri, 1 Aug 2025 12:09:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] iio: adc: ad7476: Simplify chip type detection
Message-ID: <20250801120901.00004a67@huawei.com>
In-Reply-To: <0ed3a1e9346d84d20838e89a531e8d99f95bcb97.1754041258.git.mazziesaccount@gmail.com>
References: <cover.1754041258.git.mazziesaccount@gmail.com>
	<0ed3a1e9346d84d20838e89a531e8d99f95bcb97.1754041258.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 1 Aug 2025 13:07:13 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ad7476 driver uses a table of structures for defining the IC variant
> specific data. Table is indexed using enum values, which are picked by
> SPI ID.
> 
> Having the table and an enum adds extra complexity. It is potentially
> unsafe if someone alters the enumeration values, or size of the IC data
> table.
> 
> Simplify this by dropping the table and using individual structures for
> the IC specific data, and storing the IC specific structure's address
> directly in the SPI ID data.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> 100% Untested.
> No functional changes intended

One tiny thing inline, otherwise looks good to me.  This aligns with
how we prefer to do things these days.  Tends to end up easier to read
than the enum array thing and best of all removes any temptation to use
the enum for anything else.

>  
>  static const struct iio_info ad7476_info = {
> @@ -312,7 +306,7 @@ static int ad7476_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  	st->chip_info =
> -		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> +		(struct ad7476_chip_info *)spi_get_device_id(spi)->driver_data;

Switch to spi_get_device_match_data()
which checks via generic firmware paths first (so DT here) and then the
old school tables.  Also returns a void * so gets rid of need to cast.

Only works with all pointers (or a lot of care) because a value 0 is a
fail to match.  So kind of enabled by your patch.

Jonathan


>  
>  	reg = devm_regulator_get(&spi->dev, "vcc");
>  	if (IS_ERR(reg))
> @@ -408,41 +402,41 @@ static int ad7476_probe(struct spi_device *spi)
>  }


