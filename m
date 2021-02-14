Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FB531B276
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhBNUlw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 15:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhBNUlF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2021 15:41:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93962C061574
        for <linux-iio@vger.kernel.org>; Sun, 14 Feb 2021 12:40:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id t2so2682883pjq.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Feb 2021 12:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=NDIl2OndUREy22Wbgiw8a/mTsfQYG+EKytPcmVJqjjc=;
        b=JZSGopE2UJ1LFRWuaC4z1UCCWBwv8c2w33WbQxz7Ttsr4g5EPDnc68fRkZZuILyJHU
         Ic5oGgv804zPt/yd1HalaY0mxztc0mEpcmMiASK8xpI004K0mZlkfhQBWiLZzMVN+yiN
         sjNTTA7S8UNeXMHJHYDVxIO8hkh7mMO5fbFhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=NDIl2OndUREy22Wbgiw8a/mTsfQYG+EKytPcmVJqjjc=;
        b=jbJKxsTHNHyRTgUYs9DOVkAFqcAYUWikz0sfvvw0BI6OvDX3a1deWNpdPsygGASynI
         KW4VudfE1yO+6c4foqi26vrWPLn6v/fequVK1lVVhTWZdPg+2DSugpkDXhVHAByQc9ok
         Nj3Cv9HxPRHLNY5PHMgHr0FR0sVs/zGe7H9MVETUjx5otPWbj0B6spIJESLxixaEpVAG
         CDifAP/cPWw4+mgQLOJNcWWbRr9KjGVygOWhEcRxZrnAyF+0L4zw06DQBKZ7pVGkTGXp
         I6aXrW1jTKO8nTkHbhl+3O85blcniD17ssgvedd2wQLIV2mUPKsHJY5BX864ckGcuNAB
         S+Cw==
X-Gm-Message-State: AOAM5315sXmhWhIjSzL20i/DaYUetpsuy5XwHdcKbAi3ciXBUdJVFKZw
        BHoixUOFYQZxPaqGsnTVYd7NPQ==
X-Google-Smtp-Source: ABdhPJyjmnQVWecCG3IF+JAHFKPheb9yb44mbxnlZk+hPUzr60RuhSUAgDth7XpkHq/dv4S7Wa0L8w==
X-Received: by 2002:a17:90a:bc98:: with SMTP id x24mr4379433pjr.5.1613335200004;
        Sun, 14 Feb 2021 12:40:00 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:5849:e2a:a78c:51ce])
        by smtp.gmail.com with ESMTPSA id z15sm15297704pjz.41.2021.02.14.12.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 12:39:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210214124809.4abfa363@archlinux>
References: <20210211024601.1963379-1-swboyd@chromium.org> <20210211024601.1963379-4-swboyd@chromium.org> <20210214124809.4abfa363@archlinux>
Subject: Re: [PATCH v6 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>
Date:   Sun, 14 Feb 2021 12:39:58 -0800
Message-ID: <161333519805.1254594.18000613822693540497@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2021-02-14 04:48:09)
> On Wed, 10 Feb 2021 18:46:01 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > Add support for a ChromeOS EC proximity driver that exposes a "front"
> > proximity sensor via the IIO subsystem. The EC decides when front
> > proximity is near and sets an MKBP switch 'EC_MKBP_FRONT_PROXIMITY' to
> > notify the kernel of proximity. Similarly, when proximity detects
> > something far away it sets the switch bit to 0. For now this driver
> > exposes a single sensor, but it could be expanded in the future via more
> > MKBP bits if desired.
> >=20
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>=20
> I'm fine with this, but want to leave a little time for others to take
> one last look.  We've missed the coming merge window now anyway.
>=20
> If I seem to have forgotten this in a couple of weeks, feel free to
> give me a bump.
>=20

Ok no problem. Gwendal had some comments on v5 that may be applicable
here too but I think they mostly mean that the resume handler may not be
needed if cros ec is fixed. Having the resume handler shouldn't hurt
though unless I missed something. Gwendal?
