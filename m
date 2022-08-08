Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE7858C616
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 12:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiHHKKP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 06:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiHHKKN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 06:10:13 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14F2258
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 03:10:12 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z3so6098922qtv.5
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=V46UWcZ20IJykGTHE9HEgOPqv6UjvkWHWE9JR8CghiU=;
        b=bpEBEaxGvwRS5mhJTWRZJMXQ6oXIhOzpDTpb8JPGHpOMV9onMVJKirCAJ9hv+pCnXa
         HQ9mUgC9NOgkmiacDnpJxj45RIyE7WsNLw7Akq3QybL3oy5xTGXdwHsLPyMxR9drN7hg
         W56qYgKR5SriEO1TXIAB/ZtBHhhYIEv1InEKhGQ+BAVIsz5oD2Mj0LNVB87Qq8zfeGAS
         vYB0xYR0EJD1ycEBT13qj6hrFvq/gew3CZPDFit0qNs38oISABJ5a+fPQnlW1paSHocs
         IQXvgBCo2LIXEgNa5cpMQYrYly79wEHotzAYWlcq8+le5UO/SSi4sEbp69W65uM8Ldax
         HMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=V46UWcZ20IJykGTHE9HEgOPqv6UjvkWHWE9JR8CghiU=;
        b=HFNm06nUNBGcWJEUlJld/+aMnFinLu8rtXxt+4muONMZLKEzRVAF210EJ4gfxmsfhH
         E8cBM05PLaQVnBL8QzGqjDNb3yQjzLGBjseppVMRW/eek0M/YJLfBcwc/EhBIV97k1j8
         UQB4jgWfXAhdSMuR1+BtmnTnV/6Gbbjn05ubDcwandeJkOLSkWvBPkoxrXvVks6ihzns
         MPYTZrW7yPnoGJgB6Urz14eoKnl+nFmzW5lkjpic4FEs+bt3/qPh0tIMj3ZMts7A++hi
         WJw7vlXGAZO8w5Duj8BUEodUi6lzLB9wk86QV8wW5tWhX054MwFdzzKCRNEfcXhgd4yq
         4gxA==
X-Gm-Message-State: ACgBeo38lHwicBsWQSP8miKhmXmrSmyx1R/wgZ5A8JwHm1zMJI45ci9a
        VmAFhtyoGvV13/3jlNKWP5WwRVTBibSdRX4wKlcG+HWl9/0=
X-Google-Smtp-Source: AA6agR4DlyBywKg8eyy50YPJ9RL2qQjSQan6EXQVdBkvp5fxd4WJOY8H79Rsbn8To6/z9YSMic48V5YkewStrjfj7CE=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr15347181qta.429.1659953411854; Mon, 08
 Aug 2022 03:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220807185618.1038812-1-jic23@kernel.org> <20220807185618.1038812-5-jic23@kernel.org>
 <CAHp75Vf5PX3UsyofUWbaw7ndntp0fSrLhRP2fcQGnjA_wOTZ+w@mail.gmail.com>
 <6MIAGR.E5WEOO3MXOKZ2@crapouillou.net> <CAHp75VeEtkSUioMLafQuS+kiyEU71SEjcMj8ZLUEv_AJk2mx+g@mail.gmail.com>
 <3AJAGR.1Z7AWJJTEDPB1@crapouillou.net>
In-Reply-To: <3AJAGR.1Z7AWJJTEDPB1@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 12:09:35 +0200
Message-ID: <CAHp75VdOy-b=eVKauszmSw4wgQDp1o5wUV8QPyW9NKuaGk17MQ@mail.gmail.com>
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

On Mon, Aug 8, 2022 at 11:49 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
>
>
> Le lun., ao=C3=BBt 8 2022 at 11:39:56 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Mon, Aug 8, 2022 at 11:35 AM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>  Le lun., ao=C3=BBt 8 2022 at 11:28:12 +0200, Andy Shevchenko
> >>  <andy.shevchenko@gmail.com> a =C3=A9crit :
> >>  > On Sun, Aug 7, 2022 at 8:46 PM Jonathan Cameron <jic23@kernel.org>
> >>  > wrote:
> >
> > ...
> >
> >>  >>  In this case we can't simply use DEFINE_RUNTIME_DEV_PM_OPS()
> >> because
> >>  >>  that would provide suspend and resume functions without the
> >>  >>  checks the driver is doing before calling runtime_pm functions
> >>  >>  (whether the necessary GPIO is provided).  It may be possible to
> >>  >>  clean that up in future by moving the checks into the callbacks.
> >>  >
> >>  > ...
> >>  >
> >>  >>   static const struct dev_pm_ops srf04_pm_ops =3D {
> >>  >>  -       SET_RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
> >>  >>  -                               srf04_pm_runtime_resume, NULL)
> >>  >>  +       RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
> >>  >>  +                      srf04_pm_runtime_resume, NULL)
> >>  >>   };
> >>  >
> >>  > static DEFINE_RUNTIME_DEV_PM_OPS(...);
> >>  >
> >>  > ?
> >>
> >>  Read the commit message?
> >
> > Yes, and I'm not sure how that part is relevant. The callbacks won't
> > be called if pm_ptr() equals no-op, no?
>
> Have a look at the definition of DEFINE_RUNTIME_DEV_PM_OPS(). I believe
> it does not do what you think it does.
>
> What the commit message says is that using DEFINE_RUNTIME_DEV_PM_OPS()
> would add .suspend/.resume callbacks, which aren't provided with the
> current code.

Effectively the use of DEFINE_RUNTIME_DEV_PM_OPS() enables system
sleep with the same callbacks as runtime PM. I don't see any
disadvantages of using it instead of keeping runtime PM only. That
said, I don't see the commit message that describes that nuance. It
rather says, as I said, something irrelevant.

--=20
With Best Regards,
Andy Shevchenko
