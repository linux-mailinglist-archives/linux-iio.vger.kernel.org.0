Return-Path: <linux-iio+bounces-10406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F4E998F64
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8698B28712D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6581E231A;
	Thu, 10 Oct 2024 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V853lio1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24251CDA3C;
	Thu, 10 Oct 2024 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583625; cv=none; b=tSOFox4ZUbOl1if6Ke0LIy2m8ka8CNBGObnzhfRpSE1tQ8xCB4z/Ew31KRa6sLwlcUNuQ1BxLc+qK8buhmRTVJY+OBhY7gof0mbl/S3hkPstEA1fUg4PgPxp2SmnrUBBlTx0e+LYzFv/94Rr1TECirC6MynmwXafehYHxaTFk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583625; c=relaxed/simple;
	bh=qi9cRgk9TG4eDsZavzMdDrDeFNNE5/scEdIKsvd2LLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOaPz91fQrigtLEy6wFVISNtPcvZmUUWjSLJMMfvMPm/iBGyNGObD5u0EOVWPJUhGjkfOEbyT5yvYfeVqxrktNVjaH3BJ35b8iYRGBnBFcAd32CZu/rFF7K9aETLhdxj1UBCjrIf+b8OQEp6tKNwkrroj7n4j6SPlQRCSeb8msw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V853lio1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEFEC4CEC5;
	Thu, 10 Oct 2024 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583625;
	bh=qi9cRgk9TG4eDsZavzMdDrDeFNNE5/scEdIKsvd2LLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V853lio1j4AI7YKKUdTPooIZaUvwqwCq3sepX3dystFv7k7ETsGpOrdD+vZ0df2WR
	 KQMDzKEXYBc6vkRA1W/V7qEOmhU9JviOg82onsANvzLTlsgumZXh9bUPCjm4SHTdgJ
	 G92X1XwBLnRsSiNNsns5kw9muLOX6/skgQa4KDzaOHtpcybk/lLZMosQZsuYuTzbJA
	 rDIT/jFi+KKzCy5WLtGorsu+wVZUSQGN74Oq5SaKDNW2YMctQf83kTGd3oZa4IqpHW
	 /C1P88c9RvAX0ppKVAdBnAS3DhbqJ1Mucemkv/4W7fJ3epMUve3It+2BS4uO9txbDi
	 RfMeoGOJmvpyA==
Date: Thu, 10 Oct 2024 19:07:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: pressure: rohm-bm1390: Remove redundant if
 statement
Message-ID: <20241010190700.5466107f@jic23-huawei>
In-Reply-To: <20241010170835.772764-1-colin.i.king@gmail.com>
References: <20241010170835.772764-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 18:08:35 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> From: Colin Ian King <colin.i.king@intel.com>
> 
> There is a check on non-zero ret that is redundant because the
> same check is being performed in a previous if statement and
> also before that. The check is not required, remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@intel.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/pressure/rohm-bm1390.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
> index ccaa07a569c9..f24d9f927681 100644
> --- a/drivers/iio/pressure/rohm-bm1390.c
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -410,23 +410,20 @@ static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples,
>  	if (ret)
>  		return ret;
>  
>  	if (test_bit(BM1390_CHAN_TEMP, idev->active_scan_mask)) {
>  		ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp,
>  				       sizeof(temp));
>  		if (ret)
>  			return ret;
>  	}
>  
> -	if (ret)
> -		return ret;
> -
>  	for (i = 0; i < smp_lvl; i++) {
>  		buffer[i].temp = temp;
>  		iio_push_to_buffers(idev, &buffer[i]);
>  	}
>  
>  	return smp_lvl;
>  }
>  
>  static int bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples)
>  {


