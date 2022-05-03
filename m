Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB4518403
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 14:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiECMRj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiECMRi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 08:17:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0004532EED
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 05:14:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q23so23122466wra.1
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2022 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WvhcR22Y3Oab/jXLQw00raN4f0J/xXF92yBjLNPEqLI=;
        b=LlUkXxTW67PMssJYuZQNymkw/2xKEniAPGW32fwkVrQnjID9G/w7sQioRDWzdalGFp
         357KkX/LWhU5Dico9VCzQ/OReUhvw60tz2Db+xmW4/vTSotw3bMr1VsyG1P0gyzNgt6G
         jSrDUvCF9XI8YCbIW7+ATncC0gmNpYDGUITAGx6wvqCIcjJGXtTKbgENq7eAodXFNTFw
         CEQhvfHKqdhPQ5GY5Zyl0QjZVH42JdVEIkA0tPBt0eTuqcJSHGmPPxFgxl7pA086Y6wm
         /DUIf2hqiFovYicOT6tjk+BvZ2k3vSaPHD0503ZYmP3u7ofn3Q4zzSxDCJ05xooF8bKB
         6VOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WvhcR22Y3Oab/jXLQw00raN4f0J/xXF92yBjLNPEqLI=;
        b=bo/k4/Nsr0Y35kQZa6NHZKWfb3Nbcv+Zugie0wCHEPpuGCjRjKip9SgAeF54vnZt0G
         F8hjojXxiUthiXt6FU0A6UImzO80kdtt3iZMJLZo8qLx3Rd4ULpD/UxRt7kM1jhoLiB5
         kuGM8whds8f3K4KGCrrVI3k6h/7aMqXzBLKzeUSQF3wlQglUqxwGVHtNYizEl94oiK4K
         BowUEUf0o2ZmBse6ti2MiR/DnYI2UINJ82xm6taz6OEnFQRkRETYhUMc8gn2AnUKCxsd
         4RYAKMpKIf/sXD+tqzyki1iTRJfIVKp25jQEXsJwwlOG5WM9juXd3YbuIU9khwhjzIa+
         jExQ==
X-Gm-Message-State: AOAM533fpJx6Amimm8jAT7WNBiAW3+h+SEYlz3IpPcmh6UbFj8bZYsd8
        Y715xNtvc0Elzp+pDxvzu5CwXInH6ZkJjceh
X-Google-Smtp-Source: ABdhPJxuYWcqQECLsRPOdXnjdmlnPKVgN1MSHpVNRfWvX+6t/sUKkHtqIWe99b6JlGNVv1eevZT0+g==
X-Received: by 2002:a05:6000:154b:b0:20c:4cc7:91b3 with SMTP id 11-20020a056000154b00b0020c4cc791b3mr12584301wry.421.1651580044557;
        Tue, 03 May 2022 05:14:04 -0700 (PDT)
Received: from arch-thunder (a109-49-33-111.cpe.netcabo.pt. [109.49.33.111])
        by smtp.gmail.com with ESMTPSA id bh19-20020a05600c3d1300b003942a244f45sm1451545wmb.30.2022.05.03.05.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 05:14:04 -0700 (PDT)
Date:   Tue, 3 May 2022 13:14:01 +0100
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?utf-8?Q?M=C3=A5rten?= Lindahl <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 75/92] iio: gyro: fxas210002c: Fix alignment for DMA
 safety
Message-ID: <20220503121401.e63zxcpab465k5d7@arch-thunder>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-76-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503085935.1533814-76-jic23@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,
Thanks for fixing this.

On Tue, May 03, 2022 at 09:59:18AM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_ALIGN definition.
> 
> Updated the comment to 'may' require.
> 
> Fixes: a0701b6263ae ("iio: gyro: add core driver for fxas21002c")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>

Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>

Cheers,
   Rui
> ---
>  drivers/iio/gyro/fxas21002c_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index 410e5e9f2672..d89dab48956a 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -150,10 +150,10 @@ struct fxas21002c_data {
>  	struct regulator *vddio;
>  
>  	/*
> -	 * DMA (thus cache coherency maintenance) requires the
> -	 * transfer buffers to live in their own cache lines.
> +	 * DMA (thus cache coherency maintenance) may require the
> +	 * transfer buffers live in their own cache lines.
>  	 */
> -	s16 buffer[8] ____cacheline_aligned;
> +	s16 buffer[8] __aligned(IIO_ALIGN);
>  };
>  
>  enum fxas21002c_channel_index {
> -- 
> 2.36.0
> 
