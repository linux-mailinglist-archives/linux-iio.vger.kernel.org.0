Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E182651F1F2
	for <lists+linux-iio@lfdr.de>; Mon,  9 May 2022 00:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiEHWfe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 May 2022 18:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiEHWfd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 May 2022 18:35:33 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50B6BC02
        for <linux-iio@vger.kernel.org>; Sun,  8 May 2022 15:31:41 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f7d621d1caso126843307b3.11
        for <linux-iio@vger.kernel.org>; Sun, 08 May 2022 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rEGh1Yn4FvygAdmRpmsvPiaQVL+Z8fdxBGLuCY76iqk=;
        b=Sb4erGkH2Qi/HswRJQWL+mmKPxrQcNqxVOgUI71qLYIZmhew7MsfrVbE15gs0eO+NN
         nbJcYPC4/aKGEgoB8k7Oe61vddwWxdU28NNc8Ho2Pd6bnMVuRpWdwJJsRXujv84UQbc7
         yByqtSUvr3SCKOSxNPuWcCM59I6xoZSNDjJzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rEGh1Yn4FvygAdmRpmsvPiaQVL+Z8fdxBGLuCY76iqk=;
        b=Y6Ae1BqY5I8J1DBuFsDHfgkFcQnPfcX9op39rWPaVQwT/iQnpoCiSYM2ZlIN5xEjga
         CfTpHmRqz6Z1MXOVQ8lBUNIKzZnvgQQgQC6TelnONkyhOkQj3TGqGviXfZ0ixHSkV4i8
         3p5LuywFt4vnKHJ9kvmvRNaHhyOEhBbaZNsXKkTFe6B4ur5pOpCXrMB+tBqiuSagfQYZ
         0eXu7DCT3R6uuPQyguJCEySIeBRBvfg8mjoHK4vpO5oQLKcIYpd/0GM9WeuQHvC5gXMN
         0WsczWZZAB0qXFpjRSWiOTeh/5KhCHtGsREx7B6stdwl2Yj1aKKRTzRTv9X3nnI3rsPh
         InkA==
X-Gm-Message-State: AOAM5306kvaHfdrMbPsDKPg6XBd72peQc58y72lyUhjW5MYv92oiATW1
        k9ZbMcAVo3pOqQXuzY9uuGWGNfGcVOLy6ZrGk7k=
X-Google-Smtp-Source: ABdhPJyoQnjih7fu0GNDY7mf6zAqgwNmMpRvceO9ALr8gkJnkRXlCCodGIbEJIK71UNvAscr9Tw/zjnQx1HGW7qR7OA=
X-Received: by 2002:a81:3dc6:0:b0:2f8:f29:b429 with SMTP id
 k189-20020a813dc6000000b002f80f29b429mr11558527ywa.393.1652049101037; Sun, 08
 May 2022 15:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220508175712.647246-1-jic23@kernel.org> <20220508175712.647246-61-jic23@kernel.org>
In-Reply-To: <20220508175712.647246-61-jic23@kernel.org>
From:   Michael Welling <mwelling@ieee.org>
Date:   Sun, 8 May 2022 15:31:30 -0700
Message-ID: <CAGWnavDCrNX=9ZiPDqEExQCB=5_nEwxVTqsWoxxKphU5==wpew@mail.gmail.com>
Subject: Re: [PATCH v2 60/92] iio: dac: mcp4922: Fix alignment for DMA safety
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Alexandru Lazar <alazar@startmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?Q?M=C3=A5rten_Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 8, 2022 at 10:56 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_DMA_MINALIGN definition.
>
> Fixes: 1b791fadf3a1 ("iio: dac: mcp4902/mcp4912/mcp4922 dac driver")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Welling <mwelling@ieee.org>
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/mcp4922.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
> index cb9e60e71b91..6c0e31032c57 100644
> --- a/drivers/iio/dac/mcp4922.c
> +++ b/drivers/iio/dac/mcp4922.c
> @@ -29,7 +29,7 @@ struct mcp4922_state {
>         unsigned int value[MCP4922_NUM_CHANNELS];
>         unsigned int vref_mv;
>         struct regulator *vref_reg;
> -       u8 mosi[2] ____cacheline_aligned;
> +       u8 mosi[2] __aligned(IIO_DMA_MINALIGN);

Acked-by: Michael Welling <mwelling@ieee.org>

>  };
>
>  #define MCP4922_CHAN(chan, bits) {                     \
> --
> 2.36.0
>
