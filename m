Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2181315D82
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 03:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhBJCnI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Feb 2021 21:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbhBJClV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2021 21:41:21 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7E3C061788
        for <linux-iio@vger.kernel.org>; Tue,  9 Feb 2021 18:40:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id my11so2216915pjb.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Feb 2021 18:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=6eNQGsk4HfU/BlZLIbxmLsaentzXDgONZtzHmgIk+94=;
        b=FFkxJJ5A38wj8D1VMPVZT1EAEfwIvO0q51FuE8nKboz6uO59YleKf4PFyWFeQ7E8fU
         56rhuVXqfBFFqaWbD17lQN8GHZSkR0JejudPFLqPoIUpNeAYRUWHHT5F6phDvOuifg/k
         jYZdqKsDotiKWE+Aqc/oyAh2BIZfLE0vp/VRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=6eNQGsk4HfU/BlZLIbxmLsaentzXDgONZtzHmgIk+94=;
        b=Ydaun81cxHUd4I+ttvsXpio8dxgz8HLRgTId41YbO0mIygSoMvqrB6iqnj+Bj/x1DG
         wNFHgZmYR+LpYo0u/203PvJqDg/T7+b2QETpnvvF3pL/t/S322Ze4SEVl89TYdojj7Oi
         +BC6cqq+kx/aOlPX3WgEOALCjtsXAXVmO9/IsfVjxLTl98evepgMmvOeDOJIwhTPjfxJ
         n1WNKTxm2jWYXsf358K98h7PrkTKp/I1ndkxvto2uoCD9QzNhP+Px7955ZbIPqGpdPJB
         P6pWurynqXiE/FbpBMuC0cW8q/q+icyQJQm7RRTb7W0ExCyTJFHP6P7srATAsopnTHnc
         uPFg==
X-Gm-Message-State: AOAM532h1gTkglH1n/eMl6TRXgif4cNE+kNBap7ICRc++KiKKf/DNnJK
        DtCTyY//FTZud3USk0N9wxYxjw==
X-Google-Smtp-Source: ABdhPJxv+SLGQmwvm2KqiQAVxiHCI6kYLMJxuHglZZUaUiqTqjl7Bs+TQuEqoEYxqsMKrHkVcj49lA==
X-Received: by 2002:a17:90a:f481:: with SMTP id bx1mr953131pjb.35.1612924841043;
        Tue, 09 Feb 2021 18:40:41 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:58e2:748e:a316:9823])
        by smtp.gmail.com with ESMTPSA id s23sm262214pgj.29.2021.02.09.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 18:40:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <161266809977.76967.12637197400196121672@swboyd.mtv.corp.google.com>
References: <20210202184434.42644-1-swboyd@chromium.org> <20210202184434.42644-4-swboyd@chromium.org> <20210206161711.6f555434@archlinux> <161266809977.76967.12637197400196121672@swboyd.mtv.corp.google.com>
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
Date:   Tue, 09 Feb 2021 18:40:37 -0800
Message-ID: <161292483736.418021.16202438322972245028@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Stephen Boyd (2021-02-06 19:21:39)
> Quoting Jonathan Cameron (2021-02-06 08:17:11)
> > On Tue,  2 Feb 2021 10:44:34 -0800
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >=20
> > > +static struct platform_driver cros_ec_mkbp_proximity_driver =3D {
> > > +     .driver =3D {
> > > +             .name =3D "cros-ec-mkbp-proximity",
> > > +             .of_match_table =3D of_match_ptr(cros_ec_mkbp_proximity=
_of_match),
> > I'm going to assume we know no one is going to use this with
> > ACPI via PRP0001 given presumably the firmware on these devices
> > is tightly controlled.
>=20
> Correct.
>=20
> >=20
> > However, we should should still drop the of_match_ptr
> > as it will lead to an unused warning for cros_ec_mkbp_proximity_of_match
> > if anyone builds this without CONFIG_OF + it sets a general bad
> > precedence that I'd rather wasn't around for people to copy.
> > Note that in general we are slowly ripping these out of IIO but
> > probably lots still there.
> >=20
> > If this is all that is needed in this version I'll just do it
> > whilst applying unless anyone shouts.
> >=20
>=20
> Agreed. Thanks for fixing that last little bit.

Seems Rob wanted a small tweak to the binding so I'll resend this now
and drop the of_match_ptr() usage.
