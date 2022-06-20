Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE4C552425
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 20:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiFTSk5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 14:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245638AbiFTSk4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 14:40:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89081FA7C
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 11:40:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s12so22817540ejx.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/Dpkn/Q6MELgDYLR+cyotBApzw4H+/1+EvkSLoBGb0=;
        b=RjBWdk7DOqvi+O7EFL4qktsl/3v/Q228XngOVLbnm8s31bwJq5kClSqshDD747G5y5
         of/+nPtVHT3bs/5DjbJVpSDo/Q73rOKcxZmwiGk7X95lzBB/0xIBQ+8iul1hd2+2aMMy
         JqrDG+WIDylxBuTaYn2jmi0loZz2LzLzlNLUXHCxuyQAzgYFtpkdbGYEdUwy0YawTewH
         vKMN7mjCjwovQtuCb5x1aM3g6K0Kw1ebp1wiTaBMk4pUyLNludQymbz4KXNLTE8/7O0x
         VSUwk0QYM29BBRIliYLH94b3kRbDBJr60Fp0RVLLx95mSTOWMUYzv1/lDceqAaiqo/T3
         00RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/Dpkn/Q6MELgDYLR+cyotBApzw4H+/1+EvkSLoBGb0=;
        b=ewXllHL2VVXikcJFH6AcNTh+yfLtwZBVb19Zmx+FKILoEdpQ9oWq/XWJ8adC/Amo7x
         ESl2jbJ/Jrq+YDz7mkeLIEAAylH9ICvuc9WIrljyetBLJuQ9O2Gu5OAdZw/qCdUD7JOf
         OXh2ggiduEk/BFvLQPhIsumUURoD4RD1a9oin7F574jIK6WyF6dnM+Ssq5iriZ8Dwm6a
         DsVCZ8F3K3FA9Hanto0kbYE896FFMMhG3ZvFZlcePwD0Gw7HGolhWLwQjkqsYXnxiUgS
         OS4JfO41YuCRa7WgMdgU5W4+OCoyveuzTS6t6QYY5ABdULSTNBOZ7X/EEz4TI3vS/9Ix
         k7NA==
X-Gm-Message-State: AJIora8JFDxd7p+NkPLDwvPxClx7RMAjYGEeI6fYhgo1DRZNM3oppIfu
        HLlpjwoHiSYQhGkXJyZq+e+cSwhI+RAPALtqrEE=
X-Google-Smtp-Source: AGRyM1t76krSbnh+hA3mQDKmbGOCU8F+AcUziXEwX/UKJXbPqc9B1KXla6Jxm1af6w09nUeFSoWvjq3HYhKqMBdF9/4=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr22467905ejh.497.1655750454455; Mon, 20
 Jun 2022 11:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220619185839.1363503-1-jic23@kernel.org> <20220619185839.1363503-17-jic23@kernel.org>
 <CAHp75VdTwj6sAQp2r2egFXvr5RQvnDHrOUo45==UT-_6A9GKrg@mail.gmail.com> <20220620174044.000061af@Huawei.com>
In-Reply-To: <20220620174044.000061af@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 20:40:17 +0200
Message-ID: <CAHp75Vd6V0-h82MmDfwWa5e_0_DD1-S7jAmse-fhiAc2nmRc_w@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] iio: cdc: ad7746: Move driver out of staging.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 20, 2022 at 6:40 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Mon, 20 Jun 2022 01:11:36 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sun, Jun 19, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> > >  drivers/iio/cdc/ad7746.c         | 818 +++++++++++++++++++++++++++++++
> > >  drivers/staging/iio/cdc/ad7746.c | 818 -------------------------------
> >
> > It's a bit hard to review, perhaps you forgot to add -M -C when
> > generating this patch?
>
> Specifically passed --no-renames because this is a direct file move -
> I should have stated that though.
>
> The intent is to allow review of the full driver as being proposed for
> move out of staging.

In (my) practice it only makes review much harder without any
additional benefits. Git is smart to understand renaming and in the
diffstat there is a special line about renaming.

>  Including the bits that otherwise aren't
> visible anywhere in the driver.  I only do this (and ask for it from others)
> for staging graduation patches.

Perhaps somebody finds that useful, but me :-)

-- 
With Best Regards,
Andy Shevchenko
