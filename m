Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA465524ED
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 22:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiFTUBq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 16:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFTUBq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 16:01:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9101CB0F
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 13:01:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g25so23140333ejh.9
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6HUFyrEv0puvMS7fDiEdYBVBDhlxycKAqEbXpbkp70=;
        b=ozA7QctA0Z2AQuIpppxKdHo6PEGX1qpIuoSAtx6t79kldovD7iA26Wv35YubZRI9vk
         zq6GTD9Rnrld/WgHX+5Mx37nrXEJQ81m7s4XgxBJKbrGonNfGCRNiMux1kmcEw8GBtrs
         7MADHjH6utPRwEvK9PPydRF2NMINvn0NF0j0aNzrhmsYo8D8XYKH/u8iOQKEi+uhYkJJ
         7L2yLN0lhkLDCUbu/dGtY2eF62Z7fU3FPnF27iZrSYPkVFoLUN7ujb0/nvJ8fN8ZZXo5
         96sLaCORVfYwFSGNe4UBFcoHudbTUbgR5hIEe8Eioll2ceN1nV908IBmkjirLz9aaDIn
         5Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6HUFyrEv0puvMS7fDiEdYBVBDhlxycKAqEbXpbkp70=;
        b=wVnv3xUq2oLmwyTW6/hEys8fHsLZsXcf7+M3cr4yU2XOp/VnMrgZek1zxPtWmfu4VP
         +mvHexjHGi0MbgfeFFJcyDvCZfgliQdC0doTmMafNZIydfjxDMXKf487DMMwgF3KYskG
         zVluNNahPoqwSa/A7u32gBIIgjLqiMqYkOP+adpwd2zPcDEikZBim/+HtmQoCU7CKhN2
         XzFxYv7c1BcI9MlP86MEbgEr6AhSJCOZifYmXfDi4kQRm+ExBWK757bWpzNSyVfMT+Ad
         yNXWCLSmCVoWbRO/dOwEalEzWWtBV2ipyRi1Y0pyWZjuK/ocYTFa792Bn9PnyLp+i1UO
         sY+Q==
X-Gm-Message-State: AJIora/tfdOiuU+qntu/Yn+6FCkqjzAT86Ht51RVMSp8jyQpRAci7Wnp
        r4CqdR4wZUJ6gy6S/8fTIADsBhVMc2tHSvvOi+pB0Umk88Rl2A==
X-Google-Smtp-Source: AGRyM1sne1aY5av7B/0L1OI6Mb+bbWCp4D96eGvPZMOLGGL3Au0F1gYsLuVWw+goSjj+7zAxHLGvtsRhNAoRlu/UQlU=
X-Received: by 2002:a17:906:d9d9:b0:710:f2ae:b455 with SMTP id
 qk25-20020a170906d9d900b00710f2aeb455mr23062536ejb.77.1655755303675; Mon, 20
 Jun 2022 13:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220619185839.1363503-1-jic23@kernel.org> <20220619185839.1363503-17-jic23@kernel.org>
 <CAHp75VdTwj6sAQp2r2egFXvr5RQvnDHrOUo45==UT-_6A9GKrg@mail.gmail.com>
 <20220620174044.000061af@Huawei.com> <CAHp75Vd6V0-h82MmDfwWa5e_0_DD1-S7jAmse-fhiAc2nmRc_w@mail.gmail.com>
 <20220620205322.737f4a57@jic23-huawei>
In-Reply-To: <20220620205322.737f4a57@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 22:01:06 +0200
Message-ID: <CAHp75VekQ2sspZmPJ9wLvS-tpRDtYH5fN7PAApP8YiZW49yv7A@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] iio: cdc: ad7746: Move driver out of staging.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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

On Mon, Jun 20, 2022 at 9:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 20 Jun 2022 20:40:17 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jun 20, 2022 at 6:40 PM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > > On Mon, 20 Jun 2022 01:11:36 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Sun, Jun 19, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:

...

> > > > >  drivers/iio/cdc/ad7746.c         | 818 +++++++++++++++++++++++++++++++
> > > > >  drivers/staging/iio/cdc/ad7746.c | 818 -------------------------------
> > > >
> > > > It's a bit hard to review, perhaps you forgot to add -M -C when
> > > > generating this patch?
> > >
> > > Specifically passed --no-renames because this is a direct file move -
> > > I should have stated that though.
> > >
> > > The intent is to allow review of the full driver as being proposed for
> > > move out of staging.
> >
> > In (my) practice it only makes review much harder without any
> > additional benefits. Git is smart to understand renaming and in the
> > diffstat there is a special line about renaming.
> >
> > >  Including the bits that otherwise aren't
> > > visible anywhere in the driver.  I only do this (and ask for it from others)
> > > for staging graduation patches.
> >
> > Perhaps somebody finds that useful, but me :-)
> >
>
> I definitely do as lets me lazy and not apply the patches just do a review
> + where do you comment on something in the original driver that is getting moved?
> That particularly use case only really applies to drivers moving out of staging
> though.  Alternative is to paste the entire driver in the cover letter which
> is not a great solution either...

Ah, I think I got your point. You want somebody to go through the
driver without applying series locally and tell if it looks okay to be
out of the staging, This is fair point, but perhaps I trust you that
much that I believe if anything is left, it's not a blocker of moving
things out of staging.

-- 
With Best Regards,
Andy Shevchenko
