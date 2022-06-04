Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A570753D778
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiFDP0A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 11:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiFDP0A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 11:26:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622CB4EDFA
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 08:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22999B802C0
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 15:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559AAC385B8;
        Sat,  4 Jun 2022 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654356356;
        bh=5+2chzSm2Pak0GLKEp4T0vYlib6s16yKI2FrPWUK9CE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=loZF+BGDD/Z5fqVodyZViuupJRGYjdQDSrQdSUJ1UbSDTciES+yCtMaxixBAZAyH3
         81SAFwofGKaDMOsM/mEOOI5mC2VMfeAX62YP7RW1kLPsXMqBT3J22+l5rfbiasp17g
         DEPzrjEVno94UDiezzlixP7xp+qkKC0HqIav3pyo9m6woL1q8TZhueCWdMvANwoG6D
         Oiy9SwknRBnYbLEc8cq/CmcoBamtcX7TMSTR5PG7nmQF/lK9p75TnHVrnv8cAXbM3n
         g2RY25DZP2a5N7eiHxDPbS2oQwHtQCAPrvrB9rXSBB9x9LMz3zz13j5hmb9uK+YJEE
         AIF2jjpwTRxtA==
Date:   Sat, 4 Jun 2022 16:34:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: core: drop iio_get_time_res()
Message-ID: <20220604163459.029585ac@jic23-huawei>
In-Reply-To: <20220220163327.424696-1-jic23@kernel.org>
References: <20220220163327.424696-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Feb 2022 16:33:27 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This function was introduced with the ability to pick a clock.
> There are no upstream users so presumably it isn't as obviously useful
> as it seemed at the time.  Hence drop it.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst I normally am pretty rigid in pestering people to review my
patches, this one seems safe enough given it just removes clearly
unused code.

As such, applied to the togreg branch of iio.git so I can forget about it.
(by which I mean mark it applied in patchwork)

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 23 -----------------------
>  include/linux/iio/iio.h         |  1 -
>  2 files changed, 24 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e1ed44dec2ab..5d6c62d4a83d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -320,29 +320,6 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL(iio_get_time_ns);
>  
> -/**
> - * iio_get_time_res() - utility function to get time stamp clock resolution in
> - *                      nano seconds.
> - * @indio_dev: device
> - */
> -unsigned int iio_get_time_res(const struct iio_dev *indio_dev)
> -{
> -	switch (iio_device_get_clock(indio_dev)) {
> -	case CLOCK_REALTIME:
> -	case CLOCK_MONOTONIC:
> -	case CLOCK_MONOTONIC_RAW:
> -	case CLOCK_BOOTTIME:
> -	case CLOCK_TAI:
> -		return hrtimer_resolution;
> -	case CLOCK_REALTIME_COARSE:
> -	case CLOCK_MONOTONIC_COARSE:
> -		return LOW_RES_NSEC;
> -	default:
> -		BUG();
> -	}
> -}
> -EXPORT_SYMBOL(iio_get_time_res);
> -
>  static int __init iio_init(void)
>  {
>  	int ret;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index faf00f2c0be6..13cd5f41b0de 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -313,7 +313,6 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
>  }
>  
>  s64 iio_get_time_ns(const struct iio_dev *indio_dev);
> -unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
>  
>  /* Device operating modes */
>  #define INDIO_DIRECT_MODE		0x01

