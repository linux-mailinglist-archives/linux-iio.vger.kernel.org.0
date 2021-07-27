Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F213D7197
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhG0Iys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 04:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbhG0Iyr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 04:54:47 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06662C061760;
        Tue, 27 Jul 2021 01:54:47 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z18so19500540ybg.8;
        Tue, 27 Jul 2021 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUQsqjQOSepeZI4ZBxOYmEEPPFT7ZXJ+tIn1Wmev4CE=;
        b=BPucyRw+x8i0a+bI6F04Knx1fvWTMQdoZUjVuknizS0lbZ8s7JatONrR/kerk3gRFB
         PUP+oz+Q0TNgd63S5RnTmcXqAgGUmth+4QEhdUraCg7s4lV3xKpAjRpdNUUamIyvENCk
         4A+5mI0BN5NKum0tXazNG6Wko4rhD3t4Yzztb1l7MWXs7ZPJIoSMwO/74dyyTh0sy7U4
         Qhi5+htCA1GMc8f4XdlrPM6MQeL1Y+mfKs7YHNTJ6IY7N2Ec6M7oHXekJn0+TIie2cax
         d5HaGkFoQH3iL5bbg28FFKuHiLfz+9UwqJgMZnl4LuT5gWab7sIEDNwQ/i3QWjMF17sw
         L/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUQsqjQOSepeZI4ZBxOYmEEPPFT7ZXJ+tIn1Wmev4CE=;
        b=dGNVgYSwg9Lr8mlyQnXF8xkPq+6wQ+HOIVKeslXbviBNZnjVZW7ZwUPkyFTF09ANBA
         DNqTr2piuZwKxvasGpjcsJc0lVTV58E4CJ3To1GJzLWbYOQuGFXirm2aRyZBm+xCa6vp
         3D1T1flsbOxoTNe5wtUn5kyQtsthlPqCialeawFw5ZobBwgFbUZ3I/rgK66C2WSTkbG6
         Vtfz5ZQODuRKX+n43BVqZSUP8Nd5nV9I0LVfbis95LdtwpTfLLCucICpMNllxHQggTbI
         ebnix/n2xK/MV6TPe52R/xjajRBIuWdzeoSBd4sh+X4HvPaekF7fWJxWLYl9SH3+MBuk
         k4Ag==
X-Gm-Message-State: AOAM531GtRTlq61iCuBLo0L+OuF57DsvSn4CXudK/e+5hDIjjwvCZNy8
        TBO0o8t7A2lR1dFb+p8g956u3IbZNpEIZXob0hE=
X-Google-Smtp-Source: ABdhPJzXuYXojlsuMaJwiJlSaR7vqcfDAN83lE3jFInIMjdUPefsnTgFAMqrjiCw45cBPsC5Ik0xOvA85wA04ea3pjE=
X-Received: by 2002:a25:ba44:: with SMTP id z4mr9378257ybj.476.1627376086310;
 Tue, 27 Jul 2021 01:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210726182850.14328-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <f23358e3e040cc8522b259669ec61a22c5439394.camel@pengutronix.de>
 <CA+V-a8shgfxffdOTj0cyxz36XVxGxUkq1obPJNOSc94BKUWung@mail.gmail.com> <145309b88353d4127c659dfabd374252cb2afc48.camel@pengutronix.de>
In-Reply-To: <145309b88353d4127c659dfabd374252cb2afc48.camel@pengutronix.de>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 27 Jul 2021 09:54:20 +0100
Message-ID: <CA+V-a8uKe=F_6pEdOkAXG_JitiQ8T9D_d0MDuKXHoo2XvXK=HQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Renesas RZ/G2L A/D converter
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Philipp,

On Tue, Jul 27, 2021 at 9:13 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Tue, 2021-07-27 at 09:02 +0100, Lad, Prabhakar wrote:
> [...]
> > > > +     ret = devm_add_action_or_reset(&pdev->dev,
> > > > +                                    rzg2l_adc_reset_assert, adc->adrstn);
> > > > +     if (ret) {
> > > > +             dev_err(&pdev->dev, "failed to register adrstn assert devm action, %d\n",
> > > > +                     ret);
> > > > +             return ret;
> > > > +     }
> > >
> > > This is the wrong way around. Installing devres actions should be done
> > > after the thing they are supposed to revert in case of error. You should
> > > move this down below the reset_control_deassert(adc->adrstn).
> > >
> > Ouch my understanding was, there won't be any harm in asserting the
> > reset line. Agree with will move this below
> > reset_control_deassert(adc->adrstn).
>
> You are probably right, but it's still better do it correctly. Just
> imagine one of the reset lines turns out to be shared later, or somebody
> else will look at this driver for inspiration.
>
Agreed, will do it the right way!

Cheers,
Prabhakar
