Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198AC519274
	for <lists+linux-iio@lfdr.de>; Wed,  4 May 2022 01:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbiECXym (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 19:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiECXym (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 19:54:42 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 16:51:05 PDT
Received: from anchovy1.45ru.net.au (anchovy1.45ru.net.au [203.30.46.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B92D1C4
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 16:51:05 -0700 (PDT)
Received: (qmail 13180 invoked by uid 5089); 3 May 2022 23:44:23 -0000
Received: by simscan 1.2.0 ppid: 12846, pid: 12848, t: 0.0668s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.22?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 3 May 2022 23:44:21 -0000
Message-ID: <a49eea15-d8f6-1152-f8a0-7daa1b23cc52@electromag.com.au>
Date:   Wed, 4 May 2022 07:44:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 81/92] iio: potentiometer: ad5272: Fix alignment for DMA
 safety
Content-Language: en-AU
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
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
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-82-jic23@kernel.org>
From:   Phil Reid <preid@electromag.com.au>
In-Reply-To: <20220503085935.1533814-82-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/05/2022 16:59, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_ALIGN definition.
> 
> Fixes: 79e8a32d2aa9 ("iio: ad5272: Add support for Analog Devices digital potentiometers")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Phil Reid <preid@electromag.com.au>

Reviewed-by: Phil Reid <preid@electromag.com.au>

> ---
>   drivers/iio/potentiometer/ad5272.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
> index d8cbd170262f..e023c0f92242 100644
> --- a/drivers/iio/potentiometer/ad5272.c
> +++ b/drivers/iio/potentiometer/ad5272.c
> @@ -50,7 +50,7 @@ struct ad5272_data {
>   	struct i2c_client       *client;
>   	struct mutex            lock;
>   	const struct ad5272_cfg *cfg;
> -	u8                      buf[2] ____cacheline_aligned;
> +	u8                      buf[2] __aligned(IIO_ALIGN);
>   };
>   
>   static const struct iio_chan_spec ad5272_channel = {


-- 
Regards
Phil Reid

