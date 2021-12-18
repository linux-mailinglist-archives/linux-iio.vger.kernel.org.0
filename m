Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF35479C8A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 21:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhLRUV6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 15:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbhLRUV5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 15:21:57 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99695C061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:21:57 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 193so5618746qkh.10
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AfkGemvMvzy1UoVuGAka1wLotWeaP+pAXJqQMQroBNw=;
        b=MlbYGiCZlww6+uiSysXq9bSATo0x9bmll6F+sUal/DM0PYWYFEKDcGQ4iboBXE2OeO
         esNUhT4Fbudw07jiGNcSYQYP20f0zXa8g4hIrliPDLnUOxsbzaVNe14GWmOSgn0My885
         XTSYhwl8SNtsOPJkdiScRLEI0coc3j6IcLmPoD+D3d0+B1YuDEv1ykbxFVGiOfx+63MK
         JEvWzcAZUpWqhwKSABRCgHYWajZ3LgNlbXu++M2+ut+VgU8ZkFns8vE2zfJQxK9TJkgm
         5fH/L4dR8vxLpw2GGSeni++9dpGrclMqfiMEbBER75HO4JLDkpdh1paJnRLXAHhxscJ9
         TMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AfkGemvMvzy1UoVuGAka1wLotWeaP+pAXJqQMQroBNw=;
        b=lWhtuXTYXbUXOOD3cMeIz00pLI2Y+IYXPvN5wJ2euIWZT/tAJqpFMgu5sgIiLSnx/z
         5hmnSggTDg9tFvEhKFWnRE6FkRH4Y3v61XzAT+H5qARhJ67WWYFse5lDSd8JtQT8GsLp
         qJgIqnSCbNc2sYIeocxvclTnc4hoxXD0u6KznjhoPHkzUIyCdJ+55uW5UM/uVnKG3Jc2
         4YeGKsFVGefY7H6JsRbp61f1LL5lpyPgt/sVGPZ9XpZRI/WTEqz1T/lLfmMaH0yNdjo8
         +jHeWhhqOyZnlQDqzF8cPeYFEGQ/lNoUq/sBMOt87+bETn80A6wcJUSslgXvvsyzBHIJ
         AUeQ==
X-Gm-Message-State: AOAM532YQ+7ueV/YGfS3Ic/mvzm05en3V1kc0srv9t8XAEJQ2QW1h+4P
        ++XaKZ1UKEAExUsZj/IVPdnmiwjZ4NM=
X-Google-Smtp-Source: ABdhPJwwFLTSMdTiWLTrvOMedQF6iZi/XqJz5F3zKXF2BZhJ6PYSUbdqX5Z5A4iBVgdMTGGFVTwgpw==
X-Received: by 2002:a05:620a:191a:: with SMTP id bj26mr5588325qkb.37.1639858916562;
        Sat, 18 Dec 2021 12:21:56 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id x13sm8299399qkp.102.2021.12.18.12.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 12:21:56 -0800 (PST)
Date:   Sat, 18 Dec 2021 17:21:52 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 09/17] staging:iio:adc:ad7280a: Trivial comment
 formatting cleanup
Message-ID: <Yb5C4FyHsQSnUYE6@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-10-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-10-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> IIO uses the
> /*
>  * stuff
>  * more stuff
>  */
> 
> multi-line style, so use that here as well.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> ---
>  drivers/staging/iio/adc/ad7280a.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 58bddd07df0c..b186dda03432 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -139,9 +139,10 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
>  	       ((addr & 0x10) >> 4);
>  }
>  
> -/* During a read a valid write is mandatory.
> - * So writing to the highest available address (Address 0x1F)
> - * and setting the address all parts bit to 0 is recommended
> +/*
> + * During a read a valid write is mandatory.
> + * So writing to the highest available address (Address 0x1F) and setting the
> + * address all parts bit to 0 is recommended.
>   * So the TXVAL is AD7280A_DEVADDR_ALL + CRC
>   */
>  #define AD7280A_READ_TXVAL	0xF800030A
> @@ -180,7 +181,7 @@ static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
>  	crc = crc_tab[val >> 16 & 0xFF];
>  	crc = crc_tab[crc ^ (val >> 8 & 0xFF)];
>  
> -	return  crc ^ (val & 0xFF);
> +	return crc ^ (val & 0xFF);
>  }
>  
>  static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
> @@ -193,12 +194,12 @@ static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
>  	return 0;
>  }
>  
> -/* After initiating a conversion sequence we need to wait until the
> - * conversion is done. The delay is typically in the range of 15..30 us
> - * however depending an the number of devices in the daisy chain and the
> - * number of averages taken, conversion delays and acquisition time options
> - * it may take up to 250us, in this case we better sleep instead of busy
> - * wait.
> +/*
> + * After initiating a conversion sequence we need to wait until the conversion
> + * is done. The delay is typically in the range of 15..30us however depending on
> + * the number of devices in the daisy chain, the number of averages taken,
> + * conversion delays and acquisition time options it may take up to 250us, in
> + * this case we better sleep instead of busy wait.
>   */
>  
>  static void ad7280_delay(struct ad7280_state *st)
> -- 
> 2.34.1
> 
