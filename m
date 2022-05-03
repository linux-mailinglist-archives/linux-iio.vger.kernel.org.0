Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89051830F
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 13:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiECLNa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 07:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiECLN3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 07:13:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36C3340EE
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 04:09:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D33DB8189D
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 11:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22411C385B2
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 11:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651576195;
        bh=9VOiH8nWgmCVrUyQiyj0kXchg2qWdEKNCzsJgkuW9To=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XLEhEFItt5NOqpRqL2dXL0qdqlI4AVSgQKOguQ5j83DKTqw10uqNrnF5Cte+4MeO8
         mCEvwQqSmR4Kd2BuZl8YXek7DGDpM5fX6ecVvDCMJb1RfaeABFJLG4yP7H0W9ux8iU
         QyA0Hp0r0NjXvQ1Dy3z5C+azURLr76AEHVblpaFj6uBVC2HRMs3U+reY8kbqKFyUEe
         ULXQMvVLow9hsA3kBcaYe2J5WAme56YKpzVRm1GOhOHGxVHvigg+rdk7UT0uXCLM2W
         6sKhgUJFw4Qjk3fNZsVS8qmhUHGCMAGufHZcyVIU60HH7sBLwn3aKtug3LeeprH/XX
         gWv8cYs763Leg==
Received: by mail-wm1-f54.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so1070856wme.4
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2022 04:09:55 -0700 (PDT)
X-Gm-Message-State: AOAM533Kkgs2/85WWu2Jl5LqfuZ/YPjXewkVy199UF/MHd27xACYqyrH
        1gzqd4ZGE+P4CMq1+UEVht3cENUypC/WCIvjxgU=
X-Google-Smtp-Source: ABdhPJzEuiB6Ai4XGmPvbFOQFYK0Ekms6joYtMrkOYhGTdZtgNpP9Bku51PTSk3kT491D7ZMZFxgV1aKDrLD8yydTZs=
X-Received: by 2002:a1c:5415:0:b0:394:2c89:4f2a with SMTP id
 i21-20020a1c5415000000b003942c894f2amr2929769wmb.144.1651576193348; Tue, 03
 May 2022 04:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220503085935.1533814-1-jic23@kernel.org> <20220503085935.1533814-52-jic23@kernel.org>
In-Reply-To: <20220503085935.1533814-52-jic23@kernel.org>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Tue, 3 May 2022 13:09:37 +0200
X-Gmail-Original-Message-ID: <CAPybu_1VKT-QCX=DWMDHWVWX=K_-oJcVWkYNpQG7QqV4dSYL-A@mail.gmail.com>
Message-ID: <CAPybu_1VKT-QCX=DWMDHWVWX=K_-oJcVWkYNpQG7QqV4dSYL-A@mail.gmail.com>
Subject: Re: [PATCH 51/92] iio: dac: ad5761: Fix alignment for DMA safety
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

On Tue, May 3, 2022 at 10:59 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_ALIGN definition.
>
> Update the comment to include 'may'.
>
> Fixes: 131497acd88a ("iio: add ad5761 DAC driver")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/iio/dac/ad5761.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
> index 4cb8471db81e..2f493f9ae2d2 100644
> --- a/drivers/iio/dac/ad5761.c
> +++ b/drivers/iio/dac/ad5761.c
> @@ -70,13 +70,13 @@ struct ad5761_state {
>         enum ad5761_voltage_range range;
>
>         /*
> -        * DMA (thus cache coherency maintenance) requires the
> +        * DMA (thus cache coherency maintenance) may require the
>          * transfer buffers to live in their own cache lines.
>          */
>         union {
>                 __be32 d32;
>                 u8 d8[4];
> -       } data[3] ____cacheline_aligned;
> +       } data[3] __aligned(IIO_ALIGN);
>  };
>
>  static const struct ad5761_range_params ad5761_range_params[] = {
> --
> 2.36.0
>
