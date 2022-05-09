Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE6251F786
	for <lists+linux-iio@lfdr.de>; Mon,  9 May 2022 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiEIJMa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 May 2022 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiEIIih (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 May 2022 04:38:37 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5851F8F28
        for <linux-iio@vger.kernel.org>; Mon,  9 May 2022 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1652085282;
  x=1683621282;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=7RhS52DYu2l/NpguTng0NvOzXM7WDN0hxKXMztDohzg=;
  b=Jtnv7k0RD9ZtKh/zkdnlFFLSR7Yk/TQO/Ah24CThrtsLmNUAjtJgVLdy
   KXXiUCuV2Bhnq/RPgR3Da4PW2m+08ineaL/MniM7l2HEAMISVsZlm+3XK
   1JbAXQiXx2cMMV/ZhwG6mLeWhA2W+c/+ZBjyJpdFB/J7313jxu+sGiga9
   Ub3OGLCdCwa7yPw0YxEcc7w0ZJYL0M72UIhGg9EqgB7mZaKkSyjkY/Wdm
   sr66MKlVx+pcPgykIcwKLhlKOL65Mcu99IQuc4bcg8JrTutWlisoFk3aF
   /kF25XCPALYBQzYW2OlwtkHJz2EzRYQv6HgSfPAIYXgr22sZdZb/yL/M2
   A==;
Date:   Mon, 9 May 2022 10:34:16 +0200
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Alexandru Lazar <alazar@startmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Alexandru Tachici" <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        David Lechner <david@lechnology.com>,
        "Ivan Mikhaylov" <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        "Michael Hennerich" <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        "Navin Sankar Velliangiri" <navin@linumiz.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "Ricardo Ribalda" <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        "Rui Miguel Silva" <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        "Tomas Melin" <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 29/92] iio: adc: ti-adc084s021: Fix alignment for DMA
 safety
Message-ID: <YnjSCNPpbIJPC+LO@axis.com>
References: <20220508175712.647246-1-jic23@kernel.org>
 <20220508175712.647246-30-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220508175712.647246-30-jic23@kernel.org>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 08, 2022 at 07:56:09PM +0200, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_DMA_MINALIGN definition.
> 
> Update the comment to include 'may'.
> 
> Fixes: 3691e5a69449 ("iio: adc: add driver for the ti-adc084s021 chip")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Mårten Lindahl <martenli@axis.com>
> Acked-by: Nuno Sá <nuno.sa@analog.com>

Acked-by: Mårten Lindahl <marten.lindahl@axis.com>

> ---
>  drivers/iio/adc/ti-adc084s021.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> index c9b5d9aec3dc..1f6e53832e06 100644
> --- a/drivers/iio/adc/ti-adc084s021.c
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -32,10 +32,10 @@ struct adc084s021 {
>  		s64 ts __aligned(8);
>  	} scan;
>  	/*
> -	 * DMA (thus cache coherency maintenance) requires the
> +	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache line.
>  	 */
> -	u16 tx_buf[4] ____cacheline_aligned;
> +	u16 tx_buf[4] __aligned(IIO_DMA_MINALIGN);
>  	__be16 rx_buf[5]; /* First 16-bits are trash */
>  };
>  
> -- 
> 2.36.0
> 
