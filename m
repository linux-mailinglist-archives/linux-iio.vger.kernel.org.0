Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFAA2CC6B8
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 20:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgLBTds (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 14:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgLBTds (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 14:33:48 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C3C0613CF
        for <linux-iio@vger.kernel.org>; Wed,  2 Dec 2020 11:33:02 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t3so1699749pgi.11
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2020 11:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2ws4aBFfst0FepWJPo86fhaHj1lS3AzxytqLnfxKPd4=;
        b=GZmL0X4/ynrDPfadka+G23nEnhPlejElMpZTjWF/JocZE6VSRNcKdFVLZd8LRQnqMD
         o8sivVoHfFH54KFaxiBXWDPYRZvE/BWqLBulyeyj++9Tq1BrR7BytKWEsKDLwC6O26vO
         ZVwUaoEN9BS7uyrSr5Z6rRQCOKwCHLTo/qT60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2ws4aBFfst0FepWJPo86fhaHj1lS3AzxytqLnfxKPd4=;
        b=uIV1GOJTYnXqGhmhJR+xClxFxAh90SvBkbMHOExTIkhrZPUTOebD5bNVV/ZbwsG+jO
         OtjvFOL+R9EfsHAQOV+AzFA0hreCfWCcXjW4bkuLzC7dieVOfJZ91xDT6RqJaP+MqB1w
         fr7wBX/1dz/8FYPFy3W5k3tIla8/3N3P4ULO/FjXRMlVeojtMi5qEIRR4L/XzQEf3qU+
         5ILdUCOkcb1WHcPJSHB9j2yjX40nAthXvmOILDFTIRCAWMbuJC0LOBx//ISIrWzTYUV0
         8x4BOEuEOLFT/WqJt4T/ExTNyUYaD8iIkUpnZK03fcmLmja8pgL4lKtMXYwE8j5hbxdo
         VKKg==
X-Gm-Message-State: AOAM530t2zlY8lMAvMnLv1GWunujlLAgtIA4NLW9MiQNNMlFJYdPYJJ+
        LpeF1GoQXRfKGU+1VmpLYqtpyA==
X-Google-Smtp-Source: ABdhPJzZ1MAL9lumKbBIW8KjyFiuFLoeK4tjoL2Xa6q6TjanAsmhRI4Zg9IBr1e9CIodzaDnihWo9A==
X-Received: by 2002:a62:2984:0:b029:19c:1300:6b11 with SMTP id p126-20020a6229840000b029019c13006b11mr4096499pfp.74.1606937581780;
        Wed, 02 Dec 2020 11:33:01 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id j11sm433430pgp.82.2020.12.02.11.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:33:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201121150245.4da5c4cf@archlinux>
References: <20201120182944.543428-1-swboyd@chromium.org> <20201121145849.32e14ab9@archlinux> <20201121150245.4da5c4cf@archlinux>
Subject: Re: [PATCH v2] iio: sx9310: Fix semtech,avg-pos-strength setting when > 16
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Date:   Wed, 02 Dec 2020 11:32:59 -0800
Message-ID: <160693757954.2717324.3993650083941744982@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2020-11-21 07:02:45)
> On Sat, 21 Nov 2020 14:58:49 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Fri, 20 Nov 2020 10:29:44 -0800
> > Stephen Boyd <swboyd@chromium.org> wrote:
> > > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/s=
x9310.c
> > > index a2f820997afc..ee1b4ff05a37 100644
> > > --- a/drivers/iio/proximity/sx9310.c
> > > +++ b/drivers/iio/proximity/sx9310.c
> > > @@ -1305,7 +1305,7 @@ sx9310_get_default_reg(struct sx9310_data *data=
, int i,
> > >             if (ret)
> > >                     break;
> > > =20
> > > -           pos =3D min(max(ilog2(pos), 3), 10) - 3;
> > > +           pos =3D min(max(ilog2(pos), 3), 11) - (pos >=3D 32 ? 4 : =
3); =20
> >=20
> > Given this is now rather tricky to read, I'd just do an explicit lookup=
 of
> > the allowed values.  Probably just a switch statement.
> As an alternative, a comment would help saying that it's powers of 2 exce=
pt
> for a gap at 64.
>=20

Ok. I'll update with a comment.
