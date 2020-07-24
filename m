Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00A22CF82
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 22:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXUg1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXUg1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 16:36:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233EFC0619D3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:36:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so6136833pjw.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Dy+affn1QORYZlFPKm/x9JIhEFQzu25LJvzw99XqiwY=;
        b=LujJsvf/f+p9A4gGM4h4h0jBGhjPrBlLldp5dfOBmdiiDJVk5Xyht7AMvYDbxh4/wN
         WjYHKWyM+oUgDwTtbT7Z/Lgojy07LPerTRrTq0h9myasMDkNtC+JvCzUhkURq/g/q1sj
         UqAR+Ejtt+NaZFNvD8yW1s4M4k9VUt5i1rB0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Dy+affn1QORYZlFPKm/x9JIhEFQzu25LJvzw99XqiwY=;
        b=ttfl04UjAMMgHxpP26tmbKz9Z3K4n9YkVMDcN3Hbv4LNwvdfrVgwPfYHtbSR+CICZh
         bnBYKBND+2aAGk7V67WqrH6tRASVAwcYS2Po7G6XH2Hhn1lmk1mADPpRWFkNACwhiTcN
         cnNo4po1LX2SExHudb8G/Hl22gCBA7qiHMWNw3GVOsTh+mkTKzYeYEi7MzJEJl8IdvWH
         VJ9jsxr31pNiCfiCZ7AU1of1ANJ3WyKGEVtcDxlCYJRZ0albqgQaLrv7NuHERzIytc0E
         lheAZnoSfZwPKvgMxsWfCNlDwKYpxIznVaOWlY6/OZWFbu5A8FayGaoJLAqtngl5LjPr
         1G8Q==
X-Gm-Message-State: AOAM532puEZrpRNjR2koyR7uYsvFds9/KIJ8lo0uydH1GsRTzlbAxNjj
        j7Rb75IKj//i+PuFPwEO8uROnQ==
X-Google-Smtp-Source: ABdhPJxBsAlQQsX3hKJcGQY2Tl4jpcFRsySRkE6k0M9nhFkVafNR4Kto9u5e7d8a1XKOONykUINPHQ==
X-Received: by 2002:a17:90b:3807:: with SMTP id mq7mr4111009pjb.221.1595622986584;
        Fri, 24 Jul 2020 13:36:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id s14sm7104841pjl.14.2020.07.24.13.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 13:36:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=VsBkaMWSNFGimx3jFk==xsK+_NL-i1M0Dr_X9sc4EL9Q@mail.gmail.com>
References: <20200723230344.1422750-1-swboyd@chromium.org> <20200723230344.1422750-4-swboyd@chromium.org> <CAD=FV=VsBkaMWSNFGimx3jFk==xsK+_NL-i1M0Dr_X9sc4EL9Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: sx9310: Enable regulator for svdd supply
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:36:24 -0700
Message-ID: <159562298499.3847286.12070936748717235003@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Doug Anderson (2020-07-24 13:25:01)
> On Thu, Jul 23, 2020 at 4:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >         /*
> >          * Last reading of the proximity status for each channel.
> >          * We only send an event to user space when this changes.
> > @@ -914,21 +916,31 @@ static int sx9310_probe(struct i2c_client *client,
> >         mutex_init(&data->mutex);
> >         init_completion(&data->completion);
> >
> > +       data->supply =3D devm_regulator_get(&client->dev, "svdd");
> > +       if (IS_ERR(data->supply))
> > +               return PTR_ERR(data->supply);
> > +
> >         data->regmap =3D devm_regmap_init_i2c(client, &sx9310_regmap_co=
nfig);
> >         if (IS_ERR(data->regmap))
> >                 return PTR_ERR(data->regmap);
> >
> > +       ret =3D regulator_enable(data->supply);
> > +       if (ret)
> > +               return ret;
> > +       /* Must wait for Tpor time after initial power up */
> > +       usleep_range(1000, 1100);
>=20
> ret =3D devm_add_action_or_reset(&client->dev, sx9310_regulator_disable, =
supply);
> if (ret)
>   return ret;
>=20
> static void sx9310_regulator_disable(void *regulator) {
>   regulator_disable(regulator);
> }
>=20
> Then drop all changes below this line.

Ok. I originally had code to turn off the supply during suspend/resume
but I removed it because I wasn't sure that the device would be OK with
the IO interface dropping after the device went to sleep.

>=20
>=20
> Seems like you could add support for the other regulator listed in the
> bindings, too?
>=20

Sure. I will use the bulk APIs.
