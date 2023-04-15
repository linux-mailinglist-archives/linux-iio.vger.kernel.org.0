Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24ED6E3280
	for <lists+linux-iio@lfdr.de>; Sat, 15 Apr 2023 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDOQlF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Apr 2023 12:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOQlE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Apr 2023 12:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39EE44B2
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 09:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B9560BA6
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 16:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F8BC4339C;
        Sat, 15 Apr 2023 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681576862;
        bh=Avc8BdZ8115rOEBokKQfrLXZ3RLfViwsXVVB9Avsa7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BY1U2w6z288Wd/OceZL0vEBGvE76zWJmasxgd0jCB8a8oW68HSBgGT6vtMdzM8h6/
         Twa2xh2KJkMk98ektXD2pMg3hUrveBzcJxBJlW0L3/hNtjQUkLrPvY7o7njcGuoNNc
         RpFrAqh0+jtEym/QBH8zq0+e4ujnwzU+/v/ZLuqfG0v5EUh6mgwUdoqXk1KP/VaoU3
         Ax4WnxpPEm+31tGMrKtzWKJbMHdbdmT8LmCBxoNSPK7W7VuslCis/D1CWpRZVy9PXG
         Zij/GsU2gPTsbZcVA1M4ne6+8WeGs4UV3nIpJLl2jNhPFg9QPfO18b1Y6GZsgL2uVi
         Lu9tacZ4EeH5w==
Date:   Sat, 15 Apr 2023 17:41:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: adc: ad7192: Fix null pointer dereference
 on probe
Message-ID: <20230415174104.7f1370c0@jic23-huawei>
In-Reply-To: <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
        <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Apr 2023 10:28:11 +0200
Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:

> Pointer to indio_dev structure is obtained via spi_get_drvdata() at
> the beginning of function ad7192_setup(), but the spi->dev->driver_data
> member is not initialized, hence a NULL pointer is returned.
> 
> Fixed by changing ad7192_setup() signature to take pointer to struct
> iio_dev, and get ad7192_state pointer via st = iio_priv(indio_dev);
> 
> Fixes: bd5dcdeb3fd0 iio: adc: ad7192: convert to device-managed functions
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> ---
> Changes in v2: obtained ad7192_state from iio_dev pointer as suggested
> by Jonathan, removed Reviewed-by since the entire patch changed its
> content.

Great. Please just tidy up the Fixes tag formatting and send a v3.

Note that we are very late in current cycle, so I'll only queue these
up now for after 6.4-rc1 is available.  They'll get pulled back into stable
trees after that (in about 3-4 weeks time).

Thanks,

Jonathan

> 
>  drivers/iio/adc/ad7192.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 55a6ab591016..94a9cf34a255 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -380,9 +380,9 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
>   return clock_sel;
>  }
> 
> -static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
> +static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>  {
> - struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
> + struct ad7192_state *st = iio_priv(indio_dev);
>   bool rej60_en, refin2_en;
>   bool buf_en, bipolar, burnout_curr_en;
>   unsigned long long scale_uv;
> @@ -1073,7 +1073,7 @@ static int ad7192_probe(struct spi_device *spi)
>   }
>   }
> 
> - ret = ad7192_setup(st, spi->dev.of_node);
> + ret = ad7192_setup(indio_dev, spi->dev.of_node);
>   if (ret)
>   return ret;
> 
> --
> 2.34.1

