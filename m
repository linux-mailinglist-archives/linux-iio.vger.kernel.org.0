Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B441518311
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiECLOh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiECLOf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 07:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305A03464D
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 04:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F95615BD
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 11:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E3CC385AE
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651576263;
        bh=B8q9HhldHlAUc/NCqTmw6vwJdvjSz4moVfptDX6PM40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FOLeMZ03WTNpwF2TKJevQlAksChKdAAFb0sgeZ4d3XZnI8M+1YujJlBrQQ38+XKy7
         l+to5JsXVJPdkCHSU/5fArKtiu0mz9WB7tnEvP7rpS3JXLWsTSdd6WQtcyTS9elbik
         CMhYm7CjoxYk9cubttrVQVSTiSh8/PLWQ9idFpeTd15ohM/jLx8YnHEHS1809F4jQs
         7+D0tlv0KZJl8WNN20S/7htEEdKqK7WvyT7l0R4sUtWkL3xdnVJ+UNxl84CQuFmsgZ
         od6/DhwFFrAzMWkH0yHLFyF09FwwxEAp2HvM1n7x23KjYjRGyn3EyIHWZ8N79jFO8j
         KDNw3scdJJkMQ==
Received: by mail-wr1-f47.google.com with SMTP id e2so22879439wrh.7
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2022 04:11:02 -0700 (PDT)
X-Gm-Message-State: AOAM531DBqW2Rr6h6KSh5Ex+0ChjmZywb0LHuoN0a9l3n8x7EXDhnQ4n
        /70/SE2dn4xilCtI8/AQNGzp0Jn6gjtdPm/ZIDI=
X-Google-Smtp-Source: ABdhPJzNXH1pKsTbpJ1ijG8mcU1o7mopDXt0Ve5UH6WCc6slqf4j/Uv5PfUQNIqmRaxApobqXU1s4rSTScyGV8+I7dA=
X-Received: by 2002:a5d:6b84:0:b0:20a:e230:383b with SMTP id
 n4-20020a5d6b84000000b0020ae230383bmr11980947wrx.107.1651576261318; Tue, 03
 May 2022 04:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220503085935.1533814-1-jic23@kernel.org> <20220503085935.1533814-65-jic23@kernel.org>
In-Reply-To: <20220503085935.1533814-65-jic23@kernel.org>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Tue, 3 May 2022 13:10:44 +0200
X-Gmail-Original-Message-ID: <CAPybu_2JTmqPZaDmTT0OMuURDxWZNGgQkGThGAxr1C2QV8rR1A@mail.gmail.com>
Message-ID: <CAPybu_2JTmqPZaDmTT0OMuURDxWZNGgQkGThGAxr1C2QV8rR1A@mail.gmail.com>
Subject: Re: [PATCH 64/92] iio: dac: ti-dac7612: Fix alignment for DMA safety
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
        =?UTF-8?Q?M=C3=A5rten_Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 3, 2022 at 11:01 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_ALIGN definition.
>
> Updated help text to 'may' require buffers to be in their own cacheline.
>
> Fixes: 977724d20584 ("iio:dac:ti-dac7612: Add driver for Texas Instruments DAC7612")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Cc: Ricardo Ribalda <ribalda@kernel.org>
> ---
>  drivers/iio/dac/ti-dac7612.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
> index 4c0f4b5e9ff4..d118df004539 100644
> --- a/drivers/iio/dac/ti-dac7612.c
> +++ b/drivers/iio/dac/ti-dac7612.c
> @@ -31,10 +31,10 @@ struct dac7612 {
>         struct mutex lock;
>
>         /*
> -        * DMA (thus cache coherency maintenance) requires the
> +        * DMA (thus cache coherency maintenance) may require the
>          * transfer buffers to live in their own cache lines.
>          */
> -       uint8_t data[2] ____cacheline_aligned;
> +       uint8_t data[2] __aligned(IIO_ALIGN);
>  };
>
>  static int dac7612_cmd_single(struct dac7612 *priv, int channel, u16 val)
> --
> 2.36.0
>
