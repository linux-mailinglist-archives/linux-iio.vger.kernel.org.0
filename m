Return-Path: <linux-iio+bounces-17173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592FCA6BCD5
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 15:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF7816CED9
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 14:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63651191484;
	Fri, 21 Mar 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rBsrMy6n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58A4C85
	for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566737; cv=none; b=XDMoU6W+Y0ehmaREKtUN05sbSlYHJs36puNKCTyJtJijJEwgNXnaEP0pCu4KX98Qyu7XPUCyg8X5pYMDS7Mu20OE/HnOvPs61RvSz3mmUy6olrdjktt3QV7dRxsXm9XODXy9ForN/IVdZTPZKGnKVF5mEuam2evHNwe261GM9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566737; c=relaxed/simple;
	bh=bfFRi4z/7jSJjPvsuOLCgub6ogXLiNJvQoKAD9aoDm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/X7pqcB4vvStY128BEQzQyoUPORbdAGQtvwvyqn4nWB95m/sm1y+HYEM0nT08oNIFUZGXhKqElYs051un+NHWCVazbZ39XHE95e8jKesvI+vpjtnMS3S/OnLmw6uSvQ7oA1KCjpp7OIUt0vo5Ldu0ebwFSK5gwGUYywh5z1W84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rBsrMy6n; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3912c09be7dso1317488f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742566732; x=1743171532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTCuNlHeDEjqfiQIo2HNGd6+ErszhZgpd1Iv8erXCzE=;
        b=rBsrMy6nrvXBVBwFm1+CIYoJ9DiwwwCJlrGI0cVIePVp6cQP7fWIb1J5WjzAooO9hg
         9qzrw6QK5pwQuYBKtQFGOV0YGaBziTstS1QJ3Pv782EW7fK7xMDo88r4JJyL+hAbn8mI
         yzKOErgNvFHBVtXuV5a4y8245DioAupxs2AF9oiHm1m52kQAbRs6goqW+x7BFWAJDvVf
         10dXpart+oYh42kZtDMOxNwGkGAVYkn/jxiRiWHtb/wjJ55duV0/7JpCBdmKoNaCYdsV
         elIB224nxy7vimowTNMyJ6ixNIFC5n2s2I0EW6h2CCVPus2uxjS9Q7AwcPC8uF+VwIdx
         3ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566732; x=1743171532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTCuNlHeDEjqfiQIo2HNGd6+ErszhZgpd1Iv8erXCzE=;
        b=Fsg1rByxYDx6ydhwJp5FCiwEosMU2llqHAZ8P+qQJBq1wvcbnHE3e3YBK8DbKKItjT
         L8YJyKDNl4NqW+xcGNjawbbDQCb6D4gRP+VixiOXvI2Op/KT6nKt51gA4v9THKEh+g8O
         f8nXjbzFKpXyoaG1BvE8j65NEpZJ36hUKNsIC5eieFjswSD73bkd9UPEgBo/3vHfVjve
         YGzCuHHbYMICaCWx5s5IHNy5sy2FoN7zIxZCCjDyHxiVFWDjI0DdcIAOSGgFK0GUlGmh
         wRGQmlO7KiHsLVJsKfkiOebJiHsudDr3/47fvLI64ZdSneuomJqqLyFGmuAA65BgZrFP
         GW5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvSCTktXgGrO6zCPU0WvBb6ihSRaQ0g98ki42VgMcxqnYupVEILnmq8d6vYpmZQSGaDBS7Sd99s3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvC0Ei+AFszisNohwPt+F+XQxIJJxRXNPqTRjeYKkovBfcHxbf
	rcbUW75T1/Ul3gzsBak3YmpO85mnkoTMXxapCn2PDOhKc1hPfFYja2eOPvrjyLM=
X-Gm-Gg: ASbGnctKLxAVRF7fuIZSpoVLGNGcMjSX2yDhc2bJAH7ClzlObtAixsCNrtiBaQ9BsNd
	f22xGTqDPKN/v0P5TZluPwG2GI0fPvojYbhzatObZPMmDniGClYR5Pc+WM/zpIUj2JyQJE8SEed
	4E9V2SZfIqUF3LK0KjZFXQMjWJ64yZn/t6cuOLwA2lCo+FaY+x7SjcYVp6gI+zz9hIejxJPApsJ
	WvN74PqsYNjwwjw1zF1FKMgVZs+RJYtEw5FWrzCFtPc5yWl3NssrPTdyNbEUHEQ5nTBgjhdrnWE
	QJ9iblClA4gMi/s3F56ZEBE+fz255K8jszHj0d6JVQyHf+T2IdWDnp8w6YG+bzgFSJhsYpHmnX3
	eoNs=
X-Google-Smtp-Source: AGHT+IHa7BgLygegVfy/7chkhJMYNIbp+e7r7rdlSTbhjyTD35Fk5o6wqITu97HanApN/HYlGGD+gQ==
X-Received: by 2002:a5d:64cc:0:b0:390:f0ff:2bf8 with SMTP id ffacd0b85a97d-3997f8f6555mr3776150f8f.10.1742566731818;
        Fri, 21 Mar 2025 07:18:51 -0700 (PDT)
Received: from dfj (host-87-8-62-49.retail.telecomitalia.it. [87.8.62.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3c90sm2556348f8f.36.2025.03.21.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:18:51 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:17:33 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7380: disable offload before using SPI bus
Message-ID: <7fcwd33q7ddeiwuga2hhsdc43zse736i6ka5i55lk2qbfdsgwc@gmgan46wcnrh>
References: <20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-v1-1-6912ac8c0ae0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-v1-1-6912ac8c0ae0@baylibre.com>

On 20.03.2025 11:21, David Lechner wrote:
> Move disabling of the SPI offload before attempting to use the SPI bus
> to write a register in ad7380_offload_buffer_predisable().
> 
> This caused a crash in the spi_engine_irq() interrupt handler due to
> being in an invalid state.
> 
> Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Angelo Dureghello <adureghello@baylibre.com>

Thanks.

> ---
>  drivers/iio/adc/ad7380.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..a2b41980c942e4cd1575bfe4f3846e297ad5d01d 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -1211,6 +1211,9 @@ static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
>  	struct ad7380_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +	spi_unoptimize_message(&st->offload_msg);
> +
>  	if (st->seq) {
>  		ret = regmap_update_bits(st->regmap,
>  					 AD7380_REG_ADDR_CONFIG1,
> @@ -1222,10 +1225,6 @@ static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
>  		st->seq = false;
>  	}
>  
> -	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> -
> -	spi_unoptimize_message(&st->offload_msg);
> -
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
> change-id: 20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-a801dcfb9c00
> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 

