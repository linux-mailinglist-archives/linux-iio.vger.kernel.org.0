Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC4451E897
	for <lists+linux-iio@lfdr.de>; Sat,  7 May 2022 18:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbiEGQoj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 May 2022 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348250AbiEGQoj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 May 2022 12:44:39 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD03369E1
        for <linux-iio@vger.kernel.org>; Sat,  7 May 2022 09:40:51 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so9918759fac.9
        for <linux-iio@vger.kernel.org>; Sat, 07 May 2022 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ecQuwZsS0gxUPHpMTjQNxjCMtikWo/Xt5OrjJ7prn8Y=;
        b=d/ZtouxzAcVYg1et6bp/rRfsm6mN3GbIt6IWEqD4egNukRI1QT+emaU3q0MqszUDfB
         RYn5fI0PEVKKAdRs2qL2rSwRtzR/tGLFU9lKr6YnCMWMWKKx/VdkECh9XJszSdezNt6z
         ndMWhctllzMYdvfOnCHs4eupHoYCqbVbHz8eJFFl8Rrxn7wEu/RsTGMrok5LLjT3pBmi
         CEHNzY4GAiYvYgpgfdFfQPtMJJZRl69rw1MryLzMPVtYlVfvhef0347gKKAQEfLLOnmc
         DrQANtrq3nhlytidOSi/ZcIrF4vifb0r1M6TJqupgcgffpU0Xn66ACZ3ZZaaCVdyxtiF
         I+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ecQuwZsS0gxUPHpMTjQNxjCMtikWo/Xt5OrjJ7prn8Y=;
        b=G4TOOLxR1JhHE5qbopye74TvDc6ZxvNPOoWVuQOlmFOZSdfTlXB+PQDxJfTCL6f7A/
         xFSYVYznw0+Gqk+tRWhqHIwzBrvIj/UoCcctxnlA8k8bMg/LxDS+DNbjBMamJFeXTiWr
         8VbMEIzel9PZ/o5qMb2fs1T4+9Narz3Ypbdp3LThgdkXqWDIBdn35Nta3QuyJ9g4NRVD
         fM9T5gy9yQJAJjVq5WGpDPfroCMtHx7agL9svgLne+R72rUCtUukQ8qxP+TDGt3XJ2/O
         0VvtcgwpOb9TWsHkZxtsVsH3pNHh1xrfAVn63fmcROFeKwS+EBQCdlKiSwtWyj0KmeP2
         ma9g==
X-Gm-Message-State: AOAM530iNEzJtv9Qw0TFWHPb0s2qohygdHw5e4sDTzHFIfzjfIFKjwxo
        eZS3HpfTL4Yhn0hwJe8EO+M=
X-Google-Smtp-Source: ABdhPJx7wHW/LmqCQTJAh8AhLo6WhulbRycX0s+ubJVUAfdsUatd9hMGlAzMpjROoEVZv4EXHcnzUg==
X-Received: by 2002:a05:6870:51c9:b0:dd:ab37:c358 with SMTP id b9-20020a05687051c900b000ddab37c358mr3480176oaj.173.1651941651119;
        Sat, 07 May 2022 09:40:51 -0700 (PDT)
Received: from localhost ([2804:30c:948:9000:5c5a:dce4:e33d:b8d4])
        by smtp.gmail.com with ESMTPSA id s63-20020aca4542000000b00325cda1ffa6sm2796517oia.37.2022.05.07.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 09:40:50 -0700 (PDT)
Date:   Sat, 7 May 2022 13:40:48 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
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
        =?iso-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 11/92] iio: adc: ad7292: Fix alignment for DMA safety
Message-ID: <YnahEHTjZkZGzZzI@marsc.168.1.7>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-12-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503085935.1533814-12-jic23@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 05/03, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_ALIGN definition.
> 
> Fixes: 506d2e317a0a ("iio: adc: Add driver support for AD7292")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Thanks,
Marcelo

> ---
>  drivers/iio/adc/ad7292.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> index 3271a31afde1..08985fc5c200 100644
> --- a/drivers/iio/adc/ad7292.c
> +++ b/drivers/iio/adc/ad7292.c
> @@ -80,7 +80,7 @@ struct ad7292_state {
>  	struct regulator *reg;
>  	unsigned short vref_mv;
>  
> -	__be16 d16 ____cacheline_aligned;
> +	__be16 d16 __aligned(IIO_ALIGN);
>  	u8 d8[2];
>  };
>  
> -- 
> 2.36.0
> 
