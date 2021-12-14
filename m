Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8640F4748D3
	for <lists+linux-iio@lfdr.de>; Tue, 14 Dec 2021 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhLNRFZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 12:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhLNRFZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 12:05:25 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E12C061574
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 09:05:25 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id s9so17780268qvk.12
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 09:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IPD+nA3FQoeMZhYwAqvzDnXwLmfZ4bVPPX3shdoFEYI=;
        b=fBlipuT4Hf/kisdkWmQu0HTGFsJDTovSOBaF/AlE5ypvY3PF73I6O4DBmwv0myqL9S
         KfOhJPrC72MJQ/VTQnijskDRH+DY2ea4SiaqXUcG4R8H0720d4BsMbTcFYp2wheguIp/
         SZgiJZKr9F3YeeLHj8HBdPjhoox3DODpI0Uo2yHMZwulpX5JLm4bFYX3Wkb+9Df2OPEK
         JL5VsVJP7fMORf6qW8Xwt7m0OtXeSIs+EEgZ/aqniPpsDvAAmkKcgA24Gxs6U+jLuTvs
         /pdqQgqLuIJCOBdmlZnkTlcDJNyYnv04oftpISZYnLxOt+QqjitVDQFU7uPiZTrrMRv7
         LaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IPD+nA3FQoeMZhYwAqvzDnXwLmfZ4bVPPX3shdoFEYI=;
        b=GY1trVmUPmubi453ya/DgGam10+44Q4ku8CY5Cu+nKVL1cwThJV3MwLfEYnnWe0l4F
         5s+i/x/9Kv+8aa0df+Ru6yO45PhgCZQVT1DLReq8l9J7B8h/UdiwvPSuzaTwqznQQz/5
         T4JDCMdKap1oBrhUhvnqMNbiZV4k3m0HBUts8oGf5jruqNoElZMVXpK5btG4JAQQQkuR
         7HXhf1WG9hg7DrI5Wr/cCPRv+pMBPY2gsaYRu6PH7CEksOBvqgjVb+2kJrgfvmURia0w
         knB4JqkTBsYPZrxKtKYxZqiog0/sj+CiySqp9cFVBn/BX0v2g80aASP74z1lHWXkRpHs
         eMtw==
X-Gm-Message-State: AOAM530lxrflMwNTMH9lVhc3WgSN4D9+hEb+1HE5x/o0CRkqO0fDf0Va
        nONNZV6/Xvc8G1ViNUE0C+Y=
X-Google-Smtp-Source: ABdhPJwt3YGTvNVAgdzXC0RnPpsJFmA2HKCHIZu3RgeEd/269E3Re6JtYBxiqqbMQk6nHOfDpo4mDw==
X-Received: by 2002:ad4:5a13:: with SMTP id ei19mr6605993qvb.129.1639501524281;
        Tue, 14 Dec 2021 09:05:24 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id x17sm350314qta.66.2021.12.14.09.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:05:23 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:05:20 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 03/17] staging:iio:adc:ad7280a: rename _read() to
 _read_reg()
Message-ID: <YbjO0PBtuiq34Wa1@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-4-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This avoids possible confusion with read back of the channel conversions.
> These two types of reads are of difference sizes with resulting differences
> in the data layout of the response from the hardware.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> ---
>  drivers/staging/iio/adc/ad7280a.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index d169c8a7b5f1..4d866e5fe43c 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -224,8 +224,8 @@ static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
>  	return spi_write(st->spi, &st->buf[0], 4);
>  }
>  
> -static int ad7280_read(struct ad7280_state *st, unsigned int devaddr,
> -		       unsigned int addr)
> +static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
> +			   unsigned int addr)
>  {
>  	int ret;
>  	unsigned int tmp;
> @@ -476,8 +476,8 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
>  	unsigned int msecs;
>  
>  	mutex_lock(&st->lock);
> -	ret = ad7280_read(st, this_attr->address >> 8,
> -			  this_attr->address & 0xFF);
> +	ret = ad7280_read_reg(st, this_attr->address >> 8,
> +			      this_attr->address & 0xFF);
>  	mutex_unlock(&st->lock);
>  
>  	if (ret < 0)
> -- 
> 2.34.1
> 
