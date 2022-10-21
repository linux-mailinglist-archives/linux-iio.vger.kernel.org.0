Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B796076E4
	for <lists+linux-iio@lfdr.de>; Fri, 21 Oct 2022 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJUM3b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Oct 2022 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJUM31 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2022 08:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD16100F
        for <linux-iio@vger.kernel.org>; Fri, 21 Oct 2022 05:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666355359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S48ylw533Pf5RHDIbTsTarWOR8Y9zjHAHy6qIQJTww8=;
        b=CaI9oTOdbijvRf6laf6LUt54JJYZSBn++OYsI0MGriatFlurQGh8Dlhml+RzhUww3Ym3+N
        uVbJZqNmPdB6BiTLC340NT+4uh1Zxj78VuBCXHVyfmaKdQ+MMpFYogGucLh1RI9VaMpWwr
        riL64++nsJKP+4qrYBW/MS9Z9KGyAI0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-qMJ8-C4nNYujjnMbhSk6Vw-1; Fri, 21 Oct 2022 08:29:18 -0400
X-MC-Unique: qMJ8-C4nNYujjnMbhSk6Vw-1
Received: by mail-lf1-f69.google.com with SMTP id i9-20020ac25229000000b004a24f6e0f78so989043lfl.23
        for <linux-iio@vger.kernel.org>; Fri, 21 Oct 2022 05:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S48ylw533Pf5RHDIbTsTarWOR8Y9zjHAHy6qIQJTww8=;
        b=KK8vZ0ryGzEQdQkNl+FqKspHlhLR/BB7570Ybk/kyx0BA2Z/+HGIZ9kYjux24RccgK
         JQfIE/Vsu5q5o6CG64/Tyxwqy2AyrdKfPGNtWIggyQig+seWLQBK+xFlRpDz956+Q3ba
         JMse0wFwkfdWOGv/OR5emfoot0hPlJ7jA8bMMGEP4svT52UwGjDYjiZ7aJdfvbEbziSo
         l38bCsgIKLlCl261UeWeXtN5dEIOoH429ABI1FUft1EzCUJk7cSsLJPBnJXHAxh3VbnV
         mu/ikAh5oU2aXrQyN6sGILJr4sSG1H17UZaL8A4uyi9cKtTU+39X9ykSzgn1so1ipQ9e
         ybYQ==
X-Gm-Message-State: ACrzQf3gpM1zQNW49QANhVy9AEUb0l9jWNwl/3vH89gUv/Q1bxX+hVhv
        aqDKybcMlFyuQ+LNvajgvLtBG9FCA5EfN8aYhSv+Z/8vXmU7GbK2916NlsZOMpRBnp8Em43gPBD
        NqVsyUukRLC/guWPSA1FmTP3WsEUmEYRUxMUK
X-Received: by 2002:a2e:8554:0:b0:26f:a8a6:f9e8 with SMTP id u20-20020a2e8554000000b0026fa8a6f9e8mr6352099ljj.148.1666355357020;
        Fri, 21 Oct 2022 05:29:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Y5E6jBmtGFIGOezPrwwz2s0w4RvmCSZU0l4Puy3SyVTkvCs5MmgaDjZ7gIl/mZwDrU8DFJ+D4J7R4fzucnRo=
X-Received: by 2002:a2e:8554:0:b0:26f:a8a6:f9e8 with SMTP id
 u20-20020a2e8554000000b0026fa8a6f9e8mr6352093ljj.148.1666355356791; Fri, 21
 Oct 2022 05:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221001005208.8010-1-matt.ranostay@konsulko.com>
 <20221001005208.8010-3-matt.ranostay@konsulko.com> <CAO-hwJKzUaJ3V6cdX3geyRM7QxHL0LXgz=o5-J39fyO-vk7OCg@mail.gmail.com>
 <nycvar.YFH.7.76.2210211412080.29912@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2210211412080.29912@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 21 Oct 2022 14:29:04 +0200
Message-ID: <CAO-hwJL9zBY4C5fv3-O2D+f9ac3ZUOnqY8L8zGTBgA46PNdv0A@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] HID: mcp2221: change 'select GPIOLIB' to imply
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>, jic23@kernel.org,
        gupt21@gmail.com, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 21, 2022 at 2:13 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 21 Oct 2022, Benjamin Tissoires wrote:
>
> > > To avoid recursive dependencies on GPIOLIB when 'imply IIO' is requested
> > > with other drivers we should switch GPIOLIB to an imply.
> > >
> > > This isn't the most ideal solution but avoids modifiying the Kconfig for
> > > other drivers, and only requires a singular IS_REACHABLE(CONFIG_GPIOLIB)
> > > check.
> > >
> > > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > > ---
> > >  drivers/hid/Kconfig       | 2 +-
> > >  drivers/hid/hid-mcp2221.c | 2 ++
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > > index 185a077d59cd..745fc38794ad 100644
> > > --- a/drivers/hid/Kconfig
> > > +++ b/drivers/hid/Kconfig
> > > @@ -1252,7 +1252,7 @@ config HID_ALPS
> > >  config HID_MCP2221
> > >         tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
> > >         depends on USB_HID && I2C
> > > -       depends on GPIOLIB
> > > +       imply GPIOLIB
> > >         help
> > >         Provides I2C and SMBUS host adapter functionality over USB-HID
> > >         through MCP2221 device.
> > > diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> > > index 4d10a24e3e13..fb54f1c6fd9c 100644
> > > --- a/drivers/hid/hid-mcp2221.c
> > > +++ b/drivers/hid/hid-mcp2221.c
> > > @@ -915,9 +915,11 @@ static int mcp2221_probe(struct hid_device *hdev,
> > >         mcp->gc->can_sleep = 1;
> > >         mcp->gc->parent = &hdev->dev;
> > >
> > > +#if IS_REACHABLE(CONFIG_GPIOLIB)
> > >         ret = devm_gpiochip_add_data(&hdev->dev, mcp->gc, mcp);
> > >         if (ret)
> > >                 return ret;
> > > +#endif
> >
> > Hi Matt,
> >
> > This patch actually breaks my CI because devm_gpiochip_add_data() is
> > not the only one function that should be protected against
> > CONFIG_GPIOLIB.
> >
> > I am getting:
> > ---
> > ERROR: modpost: "gpiochip_get_data" [drivers/hid/hid-mcp2221.ko] undefined!
> > ---
> >
> > Can you also protect gpiochip_get_data() and make sure that the driver
> > is not completely buggy after? I assume a simple #if around all of the
> > calls will be worse than the current non compiling situation.
>
> Benjamin,
>
> this should be fixed in hid.git via 3d74c9eca1a2bda. If you still see
> issues with that applied, please speak up :)
>

Oh, I wasn't Cc-ed on that series, and my bot still hasn't updated my CI branch.

Thanks for the fix Matt :)

Cheers,
Benjamin

