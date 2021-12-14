Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C624748D8
	for <lists+linux-iio@lfdr.de>; Tue, 14 Dec 2021 18:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhLNRGB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 12:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhLNRGA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 12:06:00 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9869CC061574
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 09:06:00 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id m25so18956001qtq.13
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 09:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aE0ecRisHoCBbi7AP/QrvmM3rx6QI6s6VdoOTUKbFAE=;
        b=SASlNZ8O2pVnyVRi9gm43dLYRVHemLA7ujO3Xk1yZRZ5fIzhhuN81/tdLnmMQkdv7I
         fjR9lEdJ9rXMAKryGdHUUWAInl0CJsuUiQQOSrCsDBpC8dJYBHj0WZFS5H5/rwQeIlaR
         GnuNuscdcDPH9OzyUjsWqOsmKt1h7pB/+AXZhzMXcAIjHwOdYWxpRsUxTvkH9Zu5+OX9
         7oxehQtur+MTMkwcBXwhbQqb3K7kAm7N3IED2GdVQhwrd+aESAwI9ecNncwtCx5C19U5
         U/ifOKoTUPFjVTwq1CrcVvjVAk2y8xo6BQOnoi361jqmJSrOfp52vOppCC4XTeuF+RAI
         NVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aE0ecRisHoCBbi7AP/QrvmM3rx6QI6s6VdoOTUKbFAE=;
        b=qujr2L5yaF2rNwvHbZcT5FOwqc5l78aPMrq5eRIr9GltXzPzxEITJB/U5RWXQGzcO0
         iGKv5y5gsD5Mi0t77g4XAYoREw/HC8ifwyZRU3bw1wEXp8Sm4d6T6/XvXdvBCvVycl+F
         Rldyn/zok0hJ4gNcVe98HlC5GaU8ayw9pZ1xwKV/etzLnNuPhrc24NKDwENAFZmVwUW8
         p33YBgY/ql2MeF0wC2DXlKxGn9UPXNFNAxAQhEuhYFcJM5YBp/ncdMlHz3XufRLabHbX
         b+xqduWLeC2tnKGjF2PUxKQNwah11juJu8ZvSptBsryjS/U2vOmI3rkVNLYENBhDixuI
         4APg==
X-Gm-Message-State: AOAM530WnOHy54FQCI1TfZwKEXw+aa0S/NfJBq3qbpvbgtmVEBp0JV6/
        y1W3CI4AMBRsqxJPhGMLnVs=
X-Google-Smtp-Source: ABdhPJzd2yY+LSXCSL+M+fkoJvXJa4BimcdBARcDV6h324cLskcPad9V6uE4/38dG4B0/eq3bKvb0Q==
X-Received: by 2002:ac8:5f0a:: with SMTP id x10mr7387238qta.607.1639501559756;
        Tue, 14 Dec 2021 09:05:59 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id j14sm287783qkp.28.2021.12.14.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:05:59 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:05:55 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 04/17] staging:iio:adc:ad7280a: Split buff[2] into tx
 and rx parts
Message-ID: <YbjO80QVwTuCI80D@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-5-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-5-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As the __cacheline_aligned will ensure that the first of these two buffers
> is appropriate aligned, there is no need to keep them as a single array
> which is confusing given the first element is always tx and the second
> rx.  Hence let us just have two parts and name them separately.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> ---
>  drivers/staging/iio/adc/ad7280a.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 4d866e5fe43c..1f7ea5fb1e20 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -153,7 +153,8 @@ struct ad7280_state {
>  	unsigned char			cb_mask[AD7280A_MAX_CHAIN];
>  	struct mutex			lock; /* protect sensor state */
>  
> -	__be32				buf[2] ____cacheline_aligned;
> +	__be32				tx ____cacheline_aligned;
> +	__be32				rx;
>  };
>  
>  static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
> @@ -196,18 +197,18 @@ static int __ad7280_read32(struct ad7280_state *st, unsigned int *val)
>  {
>  	int ret;
>  	struct spi_transfer t = {
> -		.tx_buf	= &st->buf[0],
> -		.rx_buf = &st->buf[1],
> -		.len = 4,
> +		.tx_buf	= &st->tx,
> +		.rx_buf = &st->rx,
> +		.len = sizeof(st->tx),
>  	};
>  
> -	st->buf[0] = cpu_to_be32(AD7280A_READ_TXVAL);
> +	st->tx = cpu_to_be32(AD7280A_READ_TXVAL);
>  
>  	ret = spi_sync_transfer(st->spi, &t, 1);
>  	if (ret)
>  		return ret;
>  
> -	*val = be32_to_cpu(st->buf[1]);
> +	*val = be32_to_cpu(st->rx);
>  
>  	return 0;
>  }
> @@ -219,9 +220,9 @@ static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
>  			(val & 0xFF) << 13 | all << 12;
>  
>  	reg |= ad7280_calc_crc8(st->crc_tab, reg >> 11) << 3 | 0x2;
> -	st->buf[0] = cpu_to_be32(reg);
> +	st->tx = cpu_to_be32(reg);
>  
> -	return spi_write(st->spi, &st->buf[0], 4);
> +	return spi_write(st->spi, &st->tx, sizeof(st->tx));
>  }
>  
>  static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
> -- 
> 2.34.1
> 
