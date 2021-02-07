Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DFF312127
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 04:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBGDWa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 22:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGDW2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2021 22:22:28 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12680C061756
        for <linux-iio@vger.kernel.org>; Sat,  6 Feb 2021 19:21:43 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k13so1011718pfh.13
        for <linux-iio@vger.kernel.org>; Sat, 06 Feb 2021 19:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=J8aByEx4plaMl5Ii2PzH3W/CgTfnQKhyYr110Lcchrs=;
        b=mFu/sUbRMlghzahoygXzzYY0xBX6vQfrZgIuts7d7SdErQg69aS0OHiShJVbR8ocxB
         zYLQnliOyY08jeKFPrYgg+wLxR3OH3PWfOofT0BqTxr+ho9ndgRCrbIWB0KrKgi9T5iQ
         sk5Ya4/FeuiO891lUp4m0ZF/1PP69cJ4umVzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=J8aByEx4plaMl5Ii2PzH3W/CgTfnQKhyYr110Lcchrs=;
        b=TGz33czuYXqEBuMJEn4siMdtqp2SmM4OY9G2XgPttG7borI548WzPUWoHUO4WMfXUY
         8rVcTDDZ72ILPviqrUvc3pyi3tsq/81pxdXs9+lrQCQKe4yl13k0HdGpYylG4f9FcVmw
         9tX1VWZT9S0mUmNmqQCTTsNS/eSJpV+BRf/xMHRIH749X3h2MIllYu3O+vEeaLEqFllq
         IAqYf9Au1P3XTb3cjZIZ9I4Hn9nTtFFA8A0xnvIjdrhq9YT8n5sZ4j9FFYSLpfrCarui
         iKi3FtRxKjnp0J+qfnZslP8upBJJ3ikjVLYiWsFdf4N3dIHxbWSWRhai01SVVThIORWT
         butQ==
X-Gm-Message-State: AOAM533Xc/q1WDkrMwI8Wy6WRrH6o6pcBeUjgpBV9z89D436dl0toLde
        haGc2KRN0jZjTH0GGWMYISFHmQ==
X-Google-Smtp-Source: ABdhPJwhwyicDF4yN4qXAJMR6YjwkSPDz3Q+Vn402tMQ9b4zaNH0rTvNy2HQr6IlbfuqrdidvmE2iA==
X-Received: by 2002:a63:551f:: with SMTP id j31mr11668546pgb.432.1612668102161;
        Sat, 06 Feb 2021 19:21:42 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2c64:7ee8:fefb:fab2])
        by smtp.gmail.com with ESMTPSA id u19sm1499571pjy.20.2021.02.06.19.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 19:21:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210206161711.6f555434@archlinux>
References: <20210202184434.42644-1-swboyd@chromium.org> <20210202184434.42644-4-swboyd@chromium.org> <20210206161711.6f555434@archlinux>
Subject: Re: [PATCH v4 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>
Date:   Sat, 06 Feb 2021 19:21:39 -0800
Message-ID: <161266809977.76967.12637197400196121672@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2021-02-06 08:17:11)
> On Tue,  2 Feb 2021 10:44:34 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > +static struct platform_driver cros_ec_mkbp_proximity_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "cros-ec-mkbp-proximity",
> > +             .of_match_table =3D of_match_ptr(cros_ec_mkbp_proximity_o=
f_match),
> I'm going to assume we know no one is going to use this with
> ACPI via PRP0001 given presumably the firmware on these devices
> is tightly controlled.

Correct.

>=20
> However, we should should still drop the of_match_ptr
> as it will lead to an unused warning for cros_ec_mkbp_proximity_of_match
> if anyone builds this without CONFIG_OF + it sets a general bad
> precedence that I'd rather wasn't around for people to copy.
> Note that in general we are slowly ripping these out of IIO but
> probably lots still there.
>=20
> If this is all that is needed in this version I'll just do it
> whilst applying unless anyone shouts.
>=20

Agreed. Thanks for fixing that last little bit.
