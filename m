Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8E342D40
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 15:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCTOVm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 10:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhCTOVT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 10:21:19 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7789FC061574;
        Sat, 20 Mar 2021 07:21:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z10so5952804qkz.13;
        Sat, 20 Mar 2021 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I2g5ot8UtQ1c4+rslP3syBNHQIBZC4IcIwVJDN5wL/4=;
        b=GMkBfOwcgOGsbi3qJqSXBiTQ4YMwmQrGxh/EmmOxujK3KQNqk9byQAxTP0hAxB0KTr
         LtEtMfMrJr/7XhgnlDpJuTYFynHgXwqDdDleVQCOrgHVNAH5BQqa/z56fOCSPh8DIzht
         JlGxwR0e0BCsYfm/TICquw8gImoCCtQmOGwRtlnasqitoZ3Tjl5YWbP42nPLEghA9fI4
         j1pkDHSJJBntyf6aSwo9TnX/II7dpcBY7V3lSwBOp3fAJD6ZPQVWhR4QhC2MujQ4CzQn
         anWaxRuXF7fbgR0CCbG6iwFMZrm3HVE6dtRQvbZ0rD93NaK7iBbDkrzTUzqe+v1fGiSS
         bSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I2g5ot8UtQ1c4+rslP3syBNHQIBZC4IcIwVJDN5wL/4=;
        b=rQzLPhyugwiI29ftspMOE/4xWUD5viBRBn6ugYCaSL1SzgmerVhA8vsXIpc3WBoh3g
         j2GhTy2BVyjl/Qu2eZfhbemWxFzx363hSTDNVDnYPz4BdnEryK3/62UY+NH4ePRzR95N
         YzAajnfGPzmxsHnhtcv0xwnfheu93ZTXTnyfv1N93btZoLD/jisLVUHYLvbmJHBR0sIv
         2D/y9BRFPEKgpx+BP8FaEqGn/zchtAxBuLkeAwBIsKRhFm/+3lv/F+Za+YvyIXTeXUJO
         uuM0pgXbJvUCt2tZ9IYbj5yr4PHSYMmSDGPXmniqvOPTOaQ2HkZf6mjTH2hEWqXr8Ywo
         TWRg==
X-Gm-Message-State: AOAM532uyLwfI0FpMAfU96bzI0oKd0t2h/HAQ3wCbdBNPN3ft0OmL9/N
        HlIoBpcE8cCYKNf/If9l+mg=
X-Google-Smtp-Source: ABdhPJxELRLQCSpZ12p7JC96wQrEN1jTX/4aZdyy+PjlcLQLkUsJwjiVAKqdzG5rP4DjGwnILVOZzw==
X-Received: by 2002:a37:9ccc:: with SMTP id f195mr3046569qke.397.1616250067647;
        Sat, 20 Mar 2021 07:21:07 -0700 (PDT)
Received: from smtp.gmail.com ([2804:d57:1705:3400:a073:5a5f:5d7f:f02a])
        by smtp.gmail.com with ESMTPSA id l5sm5677325qtj.21.2021.03.20.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 07:21:06 -0700 (PDT)
Date:   Sat, 20 Mar 2021 11:21:01 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Guoqing chi <chi962464zy@163.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        chiguoqing@yulong.com
Subject: Re: [PATCH] iio: adc: ad7292: Modify the bool initialization
 assignment
Message-ID: <YFYEzYmdA7+St3WD@smtp.gmail.com>
References: <20210319062706.5135-1-chi962464zy@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319062706.5135-1-chi962464zy@163.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Okay, looks good to me.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 03/19, Guoqing chi wrote:
> From: Guoqing Chi <chiguoqing@yulong.com>
> 
> A bool initializer is best assigned to false rather than 0.
> 
> Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>
> ---
>  drivers/iio/adc/ad7292.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> index 70e33dd1c9f7..3271a31afde1 100644
> --- a/drivers/iio/adc/ad7292.c
> +++ b/drivers/iio/adc/ad7292.c
> @@ -260,7 +260,7 @@ static int ad7292_probe(struct spi_device *spi)
>  	struct ad7292_state *st;
>  	struct iio_dev *indio_dev;
>  	struct device_node *child;
> -	bool diff_channels = 0;
> +	bool diff_channels = false;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -- 
> 2.17.1
> 
> 
