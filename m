Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056932BABC7
	for <lists+linux-iio@lfdr.de>; Fri, 20 Nov 2020 15:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgKTOWE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Nov 2020 09:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKTOWE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Nov 2020 09:22:04 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EEBC0613CF;
        Fri, 20 Nov 2020 06:22:04 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q5so8926406qkc.12;
        Fri, 20 Nov 2020 06:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EmX/ngNfP74DHbaPRJurA58fwjUYLM23ga/X5HNDtRI=;
        b=BAGMkHJDOW0Dgh1KeR514uFZghcbAcEyrshZBs7gost67aMx1cuXgsMAzOTzZghaab
         ZkB5XdC6+rml+GFvARip3COIXAkRFOgT9M8ZZ3/40xKJoHcspGCtJBwJxWcoiaTCscpu
         yfAdtsl68n5jffq1pG83IedcM0xp4J2FgFhx13PWhB/VHEaPF+N4hrP3XujOm/NgHDNw
         SInh62R6ExXKyc0lbpPr72UKCO40px1hxs/rCls4j89923Zvu2vzMuuV16S4OU+oS4UP
         aosJbNgEY2dVe9Ezr1b3R/MUmOMWb1l6oXO0lPbS0enfYWyDfwAeH78IChMGKWW9KPYI
         BHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EmX/ngNfP74DHbaPRJurA58fwjUYLM23ga/X5HNDtRI=;
        b=a2U61VudAKgVplDoDYTBTWZCyULII4NWO96tn3rJAb3HrdDlLH3nsv5IUAsNRqm89e
         m77mN0efa6OnryimbrJ2Vo1hiRUIueq5xbU3gAyQY19Xalftz2vBBjuLidRbLVYg/dNh
         b3Yxng1Wc+zK09O+sdoKvxUMhjXlHzmSLRoOdEBYZQsPSWdqiL9UK+qRm4Pk+FBsKMQY
         rGJ0g7W+hOp9b6gpeEh9My2ujI+aCx50aN/FPawondzCtCj+UhbPkVbkEXJOKm2QtDZ7
         BaTr13OTi+Fi/fx5QYOjtLhmhqyUNHJTH3g1WtNRFRuRg0Zzvt5cbjJgb1RKZnjmTRQO
         MjGg==
X-Gm-Message-State: AOAM533PD6nLhLb7hTUcVIJ84rcDB5U+MAFofuHB/qC+hy/oWiJhftTN
        DpcSfyMq1RtlI2y4JsarRqhyWLzfz/Q=
X-Google-Smtp-Source: ABdhPJzNpWtTBtnYe+daeWNpk43qANKonaNPrt13DpGL/7oXJGXWtMkWIbPHru0c1eLpYZ0ofFtHMA==
X-Received: by 2002:a37:9ac4:: with SMTP id c187mr12080708qke.159.1605882123440;
        Fri, 20 Nov 2020 06:22:03 -0800 (PST)
Received: from smtp.gmail.com ([2804:d57:1704:a400:2a23:f22c:fae0:6ec8])
        by smtp.gmail.com with ESMTPSA id 21sm2145797qkv.78.2020.11.20.06.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 06:22:02 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:21:58 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org
Subject: Re: [PATCH] iio: adc: ad7292: remove unneeded spi_set_drvdata()
Message-ID: <20201120142158.GA2179@smtp.gmail.com>
References: <20201119142720.86326-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119142720.86326-1-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

LGTM.
Tested on raspberry pi kernel - rpi-5.9.y.

ad7292 was heavily based on ad7768-1. 
Maybe this might apply to ad7768-1 as well.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Tested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 11/19, Alexandru Ardelean wrote:
> This seems to have been copied from a driver that calls spi_set_drvdata()
> but doesn't call spi_get_drvdata().
> Setting a private object on the SPI device's object isn't necessary if it
> won't be accessed.
> This change removes the spi_set_drvdata() call.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/adc/ad7292.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> index ab204e9199e9..70e33dd1c9f7 100644
> --- a/drivers/iio/adc/ad7292.c
> +++ b/drivers/iio/adc/ad7292.c
> @@ -276,8 +276,6 @@ static int ad7292_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	spi_set_drvdata(spi, indio_dev);
> -
>  	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
> -- 
> 2.17.1
> 
