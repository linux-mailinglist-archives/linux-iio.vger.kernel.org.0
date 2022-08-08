Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9387D58C657
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiHHK1h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 06:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiHHK1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 06:27:36 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2252708
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 03:27:34 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id u12so6159845qtk.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 03:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=KhJECMjUSc7EaJ1jEIykER6ACIgEIKMCXe9qfgXQTLA=;
        b=Rgqqg+u7Omxv62hJ1F6IvC/koiJ9vri9M6r3Tw53awrmfnNh+zmFhV4relFxURnNcy
         u8fizaTOlhcF3kcrcFUrnMGINCeYwx+0IGu74BBalphEraAtofS28VAy+Wq2lJoTA3DK
         wZqRa4wa36+jARpbPZd4IRrJVWC1i+fc0FWV0aUl0xSFZH1jCXu+RSipLB30dB2u0Vvv
         7Y77tTOzq6c7QsyBwmB9t5KZgPjdTbRS94z4ctenf4HZcwbTN4vZUzTQKT6ryz7hi/n9
         qk8x6+WG7JERwHoTMnUE+YX5wN52CsEeLbCBtOe1dkfEPI0JhsrqDUQDv1++vqQVvZnD
         T/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=KhJECMjUSc7EaJ1jEIykER6ACIgEIKMCXe9qfgXQTLA=;
        b=r7goBdFPhVi9QbID9Xz/aaXOw56+om2P9VJULb/HYSzP1Uj8hjD+UBpdB8IrUAqrCk
         xrWv2ccu6x6UqhobGu4BH6KSQGAvYWUEoyPov9L/AeYDN1iZP71o/ixaiQtrvzm1Pxtz
         K6B/xpItLGoq1q2Q5PXI7ozK1tik0ww1N6OP1AE5EwV+Ylwfh1ryD0gDLYvYu96usmQG
         TpVEklRcE+CYUxMDZuvlullM5mdYBJGGU0tA8qdn/uq4O7l7sKCwJxIMZWl/13gdcn4K
         tyjcUTod0FOTBjqPwCaAoTJArWYLP0JEFDeBq12YEP3hTEuppbIWYV++bUn+gAOgLaqK
         wHbw==
X-Gm-Message-State: ACgBeo1j0Cu1NTEQVba81tsyVoBPecDJ3/dFt5SokZD48nuXeTLczmxe
        KU3Qfb4q8XpkZjIe6FJXU3HbO5vZDgTKMVKQN5M=
X-Google-Smtp-Source: AA6agR638tYBTFeKo7hMIFO94bjEst9W4YVWlm8BLsaHwveM443yiQj0Ju2wiO2gDJqB7SigEEic+DWwvw6NZg2UiOc=
X-Received: by 2002:ac8:7f88:0:b0:342:e9dc:ee77 with SMTP id
 z8-20020ac87f88000000b00342e9dcee77mr9479109qtj.384.1659954454036; Mon, 08
 Aug 2022 03:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220807185618.1038812-1-jic23@kernel.org> <20220807185618.1038812-5-jic23@kernel.org>
 <CAHp75Vf5PX3UsyofUWbaw7ndntp0fSrLhRP2fcQGnjA_wOTZ+w@mail.gmail.com>
 <6MIAGR.E5WEOO3MXOKZ2@crapouillou.net> <CAHp75VeEtkSUioMLafQuS+kiyEU71SEjcMj8ZLUEv_AJk2mx+g@mail.gmail.com>
 <3AJAGR.1Z7AWJJTEDPB1@crapouillou.net> <CAHp75VdOy-b=eVKauszmSw4wgQDp1o5wUV8QPyW9NKuaGk17MQ@mail.gmail.com>
 <2LKAGR.8070IXEHVPDS3@crapouillou.net>
In-Reply-To: <2LKAGR.8070IXEHVPDS3@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 12:26:57 +0200
Message-ID: <CAHp75VcRMvTQOQso1hwCAnGDGKm4W6Es4=TF-E5OT04-kFnpfg@mail.gmail.com>
Subject: Re: [PATCH 4/6] iio: proximity: srf04: Use pm_ptr() to remove unused
 struct dev_pm_ops
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 8, 2022 at 12:17 PM Paul Cercueil <paul@crapouillou.net> wrote:
> Le lun., ao=C3=BBt 8 2022 at 12:09:35 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Mon, Aug 8, 2022 at 11:49 AM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>  Le lun., ao=C3=BBt 8 2022 at 11:39:56 +0200, Andy Shevchenko
> >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> >>  > On Mon, Aug 8, 2022 at 11:35 AM Paul Cercueil
> >> <paul@crapouillou.net>
> >>  > wrote:
> >>  >>  Le lun., ao=C3=BBt 8 2022 at 11:28:12 +0200, Andy Shevchenko
> >>  >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> >>  >>  > On Sun, Aug 7, 2022 at 8:46 PM Jonathan Cameron
> >> <jic23@kernel.org>
> >>  >>  > wrote:
> >>  >
> >>  > ...
> >>  >
> >>  >>  >>  In this case we can't simply use DEFINE_RUNTIME_DEV_PM_OPS()
> >>  >> because
> >>  >>  >>  that would provide suspend and resume functions without the
> >>  >>  >>  checks the driver is doing before calling runtime_pm
> >> functions
> >>  >>  >>  (whether the necessary GPIO is provided).  It may be
> >> possible to
> >>  >>  >>  clean that up in future by moving the checks into the
> >> callbacks.
> >>  >>  >
> >>  >>  > ...
> >>  >>  >
> >>  >>  >>   static const struct dev_pm_ops srf04_pm_ops =3D {
> >>  >>  >>  -       SET_RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
> >>  >>  >>  -                               srf04_pm_runtime_resume,
> >> NULL)
> >>  >>  >>  +       RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
> >>  >>  >>  +                      srf04_pm_runtime_resume, NULL)
> >>  >>  >>   };
> >>  >>  >
> >>  >>  > static DEFINE_RUNTIME_DEV_PM_OPS(...);
> >>  >>  >
> >>  >>  > ?
> >>  >>
> >>  >>  Read the commit message?
> >>  >
> >>  > Yes, and I'm not sure how that part is relevant. The callbacks
> >> won't
> >>  > be called if pm_ptr() equals no-op, no?
> >>
> >>  Have a look at the definition of DEFINE_RUNTIME_DEV_PM_OPS(). I
> >> believe
> >>  it does not do what you think it does.
> >>
> >>  What the commit message says is that using
> >> DEFINE_RUNTIME_DEV_PM_OPS()
> >>  would add .suspend/.resume callbacks, which aren't provided with the
> >>  current code.
> >
> > Effectively the use of DEFINE_RUNTIME_DEV_PM_OPS() enables system
> > sleep with the same callbacks as runtime PM. I don't see any
> > disadvantages of using it instead of keeping runtime PM only. That
> > said, I don't see the commit message that describes that nuance. It
> > rather says, as I said, something irrelevant.
>
> Probably no disavantages, yes, but that would be a functional change,
> so I can understand why it's not done in this patchset. That doesn't
> mean it cannot be done later, though, but somebody would need to test
> it on hardware.

This is a fair point.

--=20
With Best Regards,
Andy Shevchenko
