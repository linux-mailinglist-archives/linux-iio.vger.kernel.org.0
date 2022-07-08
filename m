Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9056C488
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jul 2022 01:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiGHWvc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Jul 2022 18:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbiGHWvb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jul 2022 18:51:31 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4223737195
        for <linux-iio@vger.kernel.org>; Fri,  8 Jul 2022 15:51:30 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 20so63076qky.5
        for <linux-iio@vger.kernel.org>; Fri, 08 Jul 2022 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wHYMRTHiSAqmdvSgTOSni7ELc+XthEyRIhx24G1ZKOI=;
        b=RKrZnbHtMS8GoCzTJnvYqaY0f7Qij7jWNrs4J0A+U88lPLhVyMlYKtmzL3PU5VWuOF
         p8pNDeSKnhuxo84Szw/uvFEaS1N2tkTjFWn/N9VWd4oWIh2p80m7TCw2OehzHtpTwLCb
         C148z9726q2L5WdT/HEnHwEiSaVdQrW44nq5sdEkN2Dz8j4+WiZOv++1vsWybt6T5j0j
         /UnJDZKU9Tb9X03yuhGBXGGOl9wII3lM218L5wo/ceiH+txjlMuOFKUuO30io37O8BYP
         cgZoe60RXGfvKt0mU8XTZjJCEGP/fCdeS00wort22vib214y6ZyEgANe766bEHnlauVs
         mWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHYMRTHiSAqmdvSgTOSni7ELc+XthEyRIhx24G1ZKOI=;
        b=05ynAWiZGQ8AB9E17hkK6h5gPCA79gXJJ+YJXu9ukGVPa8th96pDz3yb44PSwKvY3l
         gXByGEvSz91qA8qLApTm6xpuN6FpPF8BqRRud35X/DcTyZE1h50NS/zUMDc3sJrdc6ds
         YrQiQcdrrkFhBCIJG6uRQVi1AZ5AeU8Xy/vKwtbmtt/GFyW1u6KydNTR0lTtdB0P0iP/
         1VkhYcedB3MwzpkXwULVlPswgBlk4bx4h8vagZ/8MxbXWFXKIqAAeAx/RQ87POW8drVv
         9hCu0Guu/0bI6dODq4fnnDfpEgtHf4OfMgFoYHhKpjJNdvQOuPQqPJ2J6WaViVh1Zhbs
         8PFQ==
X-Gm-Message-State: AJIora8Jlkx443dW3//dtb7PI4+x0YyiF/MhEAfWX80iNowWCJIwQGeu
        Ar7lqJRulD4wsvbD0MLmjzw=
X-Google-Smtp-Source: AGRyM1v3I4ViKXpV8sfz//dQ7sz3+fc7G/apxgZ8o3hwgSz8CDXpcg6HvgioiOxUlZ/bBT+IYDPDnA==
X-Received: by 2002:a05:620a:4ea:b0:6af:173:1c6 with SMTP id b10-20020a05620a04ea00b006af017301c6mr4106837qkh.256.1657320689214;
        Fri, 08 Jul 2022 15:51:29 -0700 (PDT)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id bn40-20020a05620a2ae800b006b568bdd7d5sm1551285qkb.71.2022.07.08.15.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 15:51:28 -0700 (PDT)
Date:   Fri, 8 Jul 2022 18:51:26 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Thorsten Scherer <t.scherer@eckelmann.de>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7949: Fix error message
Message-ID: <Ysi07nn5JpIUJHS3@shaak>
References: <20220708201720.16523-1-t.scherer@eckelmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708201720.16523-1-t.scherer@eckelmann.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 08, 2022 at 10:17:20PM +0200, Thorsten Scherer wrote:
> Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
> ---
>  drivers/iio/adc/ad7949.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index 44bb5fde83de..12fb5f9971db 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -400,7 +400,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
>  
>  	ret = ad7949_spi_init(ad7949_adc);
>  	if (ret) {
> -		dev_err(dev, "enable to init this device: %d\n", ret);
> +		dev_err(dev, "fail to init this device: %d\n", ret);

Maybe 'failed' or 'unable' instead of 'fail'?

otherwise:

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

Cheers,
Liam

>  		return ret;
>  	}
>  
> -- 
> 2.30.2
> 
