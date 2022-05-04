Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E11519762
	for <lists+linux-iio@lfdr.de>; Wed,  4 May 2022 08:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344938AbiEDGeV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 May 2022 02:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345025AbiEDGeS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2022 02:34:18 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1121B6
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 23:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651645843;
  x=1683181843;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=5wMnkyiO2g8eiWCgCr9D8xJQRBEoRtsW5TEp5jSKZuk=;
  b=Bfj7c1k6laaC6g7Naf9Ws75f6up177WEdKQeAL/qOouSPwwvx/udGpGZ
   xXfveoK9lBIQGssQIJdXK9vmOxZ29j68rFV70aSL0UlGRxhzkX/MIUnWO
   DQq2HW6W5ptUZQByGa06PIsZ9ScQZkU6bSgVhgsWpPfN8VzVfcv9qNVbu
   h3adjzjQt9hYOD2hoJblmwb40xyWmM8i1h03EdRWHE3uPu8uCAcmrw7Ex
   kNaZoK89jW/nGvBhMQ6Vgrk1r5qs/cvoR74EV3w/YALXbuBRY3gLpgxrm
   k0eEwlBGHHjD/k/XlDzgPR+mkwBvvAPlsQFNyg722uz9NgBu38LYsdXD3
   A==;
Date:   Wed, 4 May 2022 08:30:39 +0200
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
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
        =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
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
Subject: Re: [PATCH 29/92] iio: adc: ti-adc084s021: Fix alignment for DMA
 safety
Message-ID: <YnIdjynOxRvbkG2a@axis.com>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-30-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503085935.1533814-30-jic23@kernel.org>
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

On Tue, May 03, 2022 at 10:58:32AM +0200, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_ALIGN definition.
> 
> Update the comment to include 'may'.
> 
> Fixes: 3691e5a69449 ("iio: adc: add driver for the ti-adc084s021 chip")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Mårten Lindahl <martenli@axis.com>

Acked-by: Mårten Lindahl <marten.lindahl@axis.com>

> ---
>  drivers/iio/adc/ti-adc084s021.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> index c9b5d9aec3dc..6464541319af 100644
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
> +	u16 tx_buf[4] __aligned(IIO_ALIGN);
>  	__be16 rx_buf[5]; /* First 16-bits are trash */
>  };
>  
> -- 
> 2.36.0
> 
