Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDB36076B8
	for <lists+linux-iio@lfdr.de>; Fri, 21 Oct 2022 14:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJUMNA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Oct 2022 08:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJUMM7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2022 08:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90791263F1F;
        Fri, 21 Oct 2022 05:12:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0080261E7D;
        Fri, 21 Oct 2022 12:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011A7C433C1;
        Fri, 21 Oct 2022 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666354377;
        bh=JdJ5B84yNz/GdB+7anELbV/AldAz+hRG0C+zdQCJoa4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ckZmsfgZaNu9HiiSzMfte/1EwUeXXP9jMo4Reqgp5XceBAHKAG/ZXs4AEFmPk2yu6
         WcXCMbLX7to7489zX0gYnLqTMOl0tZYhuNMDLPjNEH7j2oPnINYqZtNwXvf1HkKWi4
         pOISx9ceJ1xqq5GhWOvHqXv4YQF8NNQ9n+SwNB0BXPDexQK250ScoHhEeBvAb5yMtW
         SNsRgGEr3+wCKTcBvlS4/1gX8D1BFfCKEQovmIlUf4hvYzkhfHX5ucUbQ6JB4Gpflt
         Eb4Tc3S5YB+0eKxzW87UHh33JOHwYdJmWLDIvHP/JYTnf1b7w2DZ3Sg+pQRlMuZeuL
         p2i1voLW4GxcA==
Date:   Fri, 21 Oct 2022 14:12:53 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Matt Ranostay <matt.ranostay@konsulko.com>, jic23@kernel.org,
        gupt21@gmail.com, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v6 2/3] HID: mcp2221: change 'select GPIOLIB' to imply
In-Reply-To: <CAO-hwJKzUaJ3V6cdX3geyRM7QxHL0LXgz=o5-J39fyO-vk7OCg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2210211412080.29912@cbobk.fhfr.pm>
References: <20221001005208.8010-1-matt.ranostay@konsulko.com> <20221001005208.8010-3-matt.ranostay@konsulko.com> <CAO-hwJKzUaJ3V6cdX3geyRM7QxHL0LXgz=o5-J39fyO-vk7OCg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Oct 2022, Benjamin Tissoires wrote:

> > To avoid recursive dependencies on GPIOLIB when 'imply IIO' is requested
> > with other drivers we should switch GPIOLIB to an imply.
> >
> > This isn't the most ideal solution but avoids modifiying the Kconfig for
> > other drivers, and only requires a singular IS_REACHABLE(CONFIG_GPIOLIB)
> > check.
> >
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/hid/Kconfig       | 2 +-
> >  drivers/hid/hid-mcp2221.c | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 185a077d59cd..745fc38794ad 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -1252,7 +1252,7 @@ config HID_ALPS
> >  config HID_MCP2221
> >         tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
> >         depends on USB_HID && I2C
> > -       depends on GPIOLIB
> > +       imply GPIOLIB
> >         help
> >         Provides I2C and SMBUS host adapter functionality over USB-HID
> >         through MCP2221 device.
> > diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> > index 4d10a24e3e13..fb54f1c6fd9c 100644
> > --- a/drivers/hid/hid-mcp2221.c
> > +++ b/drivers/hid/hid-mcp2221.c
> > @@ -915,9 +915,11 @@ static int mcp2221_probe(struct hid_device *hdev,
> >         mcp->gc->can_sleep = 1;
> >         mcp->gc->parent = &hdev->dev;
> >
> > +#if IS_REACHABLE(CONFIG_GPIOLIB)
> >         ret = devm_gpiochip_add_data(&hdev->dev, mcp->gc, mcp);
> >         if (ret)
> >                 return ret;
> > +#endif
> 
> Hi Matt,
> 
> This patch actually breaks my CI because devm_gpiochip_add_data() is
> not the only one function that should be protected against
> CONFIG_GPIOLIB.
> 
> I am getting:
> ---
> ERROR: modpost: "gpiochip_get_data" [drivers/hid/hid-mcp2221.ko] undefined!
> ---
> 
> Can you also protect gpiochip_get_data() and make sure that the driver
> is not completely buggy after? I assume a simple #if around all of the
> calls will be worse than the current non compiling situation.

Benjamin,

this should be fixed in hid.git via 3d74c9eca1a2bda. If you still see 
issues with that applied, please speak up :)

Thanks,

-- 
Jiri Kosina
SUSE Labs

