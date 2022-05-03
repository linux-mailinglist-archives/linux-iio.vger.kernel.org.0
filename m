Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0225518534
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 15:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiECNPo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiECNPn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 09:15:43 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5905F2E9E6
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=icn3e2ozjZPdJo8YWEQPgiLd3SSqUl5LLboFDxejE0k=; b=Ir1kAWGIed+JLYi4a7+npuqyN+
        7+Cc1QLh5T2eJ3C5UtziTR9FSLVVtGQ//7+Fq6VXThqCFMnZkHc6JjP2wjfk6/Lf6ZAPnBxI0Rxhr
        5bMoaqTRkQQd2ZsYEtPsVsL4QNXHApYh5VO5LPS/pw6XYBpwL6qqQQXvSCuoz/dEKB7pnNm+r5jfa
        wwh2TWfhupaWbmTdQO+OxtdoKl16TINN99xXyzIjEJ2neAIw8gYUrs1IcG0hJmCT2d/Mp8SkB3kbW
        7XGG2Bl2y7J8xZsg//QYlwLtXr8j2uxBUGDQxlftTpnC3sbLAkx48qQSQkQ7E43FoIXdi0hLaCSk8
        FObojbYQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1nlsJM-000068-E6; Tue, 03 May 2022 15:11:28 +0200
Received: from [2001:a61:2ba3:7b01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1nlsJL-000Xeq-PA; Tue, 03 May 2022 15:11:27 +0200
Message-ID: <8536c4e0-e2f7-b5bd-bf49-e28db42a4b50@metafoo.de>
Date:   Tue, 3 May 2022 15:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 02/92] iio: accel: adxl313: Fix alignment for DMA safety
Content-Language: en-US
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
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
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
 <20220503085935.1533814-3-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220503085935.1533814-3-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.5/26530/Tue May  3 10:12:27 2022)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/3/22 10:58, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ____cacheline_aligned is insufficient guarantee for non-coherent DMA.
> Switch to the update IIO_ALIGN definition.
>
> Fixes: 636d44633039 ("iio: accel: Add driver support for ADXL313")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/accel/adxl313_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 9e4193e64765..508fccbd4347 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -46,7 +46,7 @@ EXPORT_SYMBOL_NS_GPL(adxl313_writable_regs_table, IIO_ADXL313);
>   struct adxl313_data {
>   	struct regmap	*regmap;
>   	struct mutex	lock; /* lock to protect transf_buf */
> -	__le16		transf_buf ____cacheline_aligned;
> +	__le16		transf_buf __aligned(IIO_ALIGN);
How about making __aligned(IIO_ALIGN) a macro in case we ever want to 
change it.
>   };
>   
>   static const int adxl313_odr_freqs[][2] = {


