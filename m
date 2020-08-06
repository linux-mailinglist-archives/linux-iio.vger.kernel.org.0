Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9435823E443
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 01:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHFXDk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgHFXDi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2020 19:03:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F164C061756
        for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2020 16:03:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so127232plk.13
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2020 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=0gDnN//bxk4XCQG+5+85qQKDntN2R3o5FFO9hcqipr4=;
        b=Qz+Tzz7bYWSKTO2D5D1zgMNC/JGFqIwqPZZilBd/61zHOwvpLorhkmc7e7VEaUMNzu
         LnaRmb/RxkNitmzslzS10MrXEJp5npQp/zZZeMPjlconFW4iWIkykeZ/wB04ja2fGUB3
         6OJdfKhct7H5dJi16+7wGmBn1PO/p/GPHw/Y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=0gDnN//bxk4XCQG+5+85qQKDntN2R3o5FFO9hcqipr4=;
        b=l+E4l1l4e3ww63yS+QD/PUaVVEJVsthgjGU6I77EaErczIy4iyvdEWZitu79f3Cecs
         coDyWIKjY8FiPJilJ9800M/j5MIMYbj3CE6Kvwf/idhZRERdZNiUTScldBZo7/qZKy31
         9GnztaGyhskvapt8DIQPg4fvS8fib6Yfs+a1VUrT4mcxkXj9FkBo5bD/XzPf1/2IHn+U
         JyrQ4s+DKpitIDDPjUn2fl0ZHiu05YdrNu7CNpYg8f0D6lZmvRW4rk2RNK2O0QBIkrKC
         /S1C5WYcGbt03zbnyxxrotEEom6pSbkf4H3M7iPZ3NT3RVSgAcnLm/etBa86DSqBiidh
         HWQw==
X-Gm-Message-State: AOAM5302Kc0FEk1U62CQbXmbRbfT18RO6sdL3CpeCDDp2ORIuiBa29Mv
        AnQLtCbAtmpATXsnpfQp+Yrdfg==
X-Google-Smtp-Source: ABdhPJxheayUk8uIULBY6NewH6D0OhojLErEsa5goOKcKVPS5xWNRVsItvYP7z12DSkLAXSq9aVcRA==
X-Received: by 2002:a17:902:7405:: with SMTP id g5mr9862707pll.173.1596755017579;
        Thu, 06 Aug 2020 16:03:37 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id j16sm8166331pgb.33.2020.08.06.16.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 16:03:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_JsqJou=yHsyQB+TUvwbNHDh81g7Lm7oWJfavYmPuYtxhREQ@mail.gmail.com>
References: <20200731164853.3020946-1-campello@chromium.org> <20200731104555.v3.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid> <20200801160639.1410944e@archlinux> <159648122347.1360974.1094560524092762187@swboyd.mtv.corp.google.com> <CAL_JsqLs99Q7o32mqZROQSLuaf-_6vVg_wSVbpMr0u3eD9LVEw@mail.gmail.com> <20200806191451.3ce5ec57@archlinux> <CAL_JsqJou=yHsyQB+TUvwbNHDh81g7Lm7oWJfavYmPuYtxhREQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>, open list:
        IIO SUBSYSTEM AND DRIVERS <linux-iio@vger.kernel.org>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 06 Aug 2020 16:03:35 -0700
Message-ID: <159675501533.1360974.12010874193333451805@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Rob Herring (2020-08-06 15:12:34)
> On Thu, Aug 6, 2020 at 12:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 3 Aug 2020 20:01:06 -0600
> > Rob Herring <robh+dt@kernel.org> wrote:
> >
> > > On Mon, Aug 3, 2020 at 1:00 PM Stephen Boyd <swboyd@chromium.org> wro=
te:
> > > >
> > > > This is mostly a decision for Rob to make, but I would make it requ=
ired
> > > > because the device is always an io channel provider. It may be that=
 it
> > > > isn't providing anything in the DT to something else in the DT but =
it is
> > > > providing this information somewhere so always having to spell that=
 out
> > > > is simple and doesn't hurt.
> > >
> > > I agree. If the user is split in a board file or overlay, we don't
> > > want to have to be adding it to the provider at that time.
> >
> > That is perhaps a reasonable view point for devices with channels that
> > are likely to be used by consumer drivers, but in this particular case =
we
> > are talking about a proximity sensor.  So far I don't think we
> > have any consumer drivers for this type of sensor (I might have forgott=
en
> > one of course!)
>=20
> Indeed, I didn't consider whether it made sense in the first place. So
> should it just not be specified at all in this case? I can't really
> picture what the usecase for a consumer node would be.
>=20

I was thinking that a WiFi DT node may directly grab the channel from
this device and use this for SAR power changes. That would avoid going
all the way to userspace to figure out that something is close proximity
and then tell WiFi to reduce power.
