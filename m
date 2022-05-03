Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C36651845A
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 14:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiECMfn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 08:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiECMfm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 08:35:42 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45B1EAC0
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 05:32:10 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 41B3CC2BFF
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 12:19:30 +0000 (UTC)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 00B3C1C000C;
        Tue,  3 May 2022 12:19:16 +0000 (UTC)
Date:   Tue, 3 May 2022 14:19:15 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
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
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 24/92] iio: adc: max11100: Fix alignment for DMA safety
Message-ID: <20220503121915.meibvottuyu57kzq@uno.localdomain>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-25-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220503085935.1533814-25-jic23@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Tue, May 03, 2022 at 09:58:27AM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_ALIGN definition.
>
> Update the comment to include 'may'.
>
> Fixes: a8e7e88df9ec ("iio: adc: Add Maxim MAX11100 driver")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks

Acked-by: Jacopo Mondi <jacopo@jmondi.org>

> ---
>  drivers/iio/adc/max11100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> index eb1ce6a0315c..4766d45344f7 100644
> --- a/drivers/iio/adc/max11100.c
> +++ b/drivers/iio/adc/max11100.c
> @@ -33,10 +33,10 @@ struct max11100_state {
>  	struct spi_device *spi;
>
>  	/*
> -	 * DMA (thus cache coherency maintenance) requires the
> +	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.
>  	 */
> -	u8 buffer[3] ____cacheline_aligned;
> +	u8 buffer[3] __aligned(IIO_ALIGN);
>  };
>
>  static const struct iio_chan_spec max11100_channels[] = {
> --
> 2.36.0
>
