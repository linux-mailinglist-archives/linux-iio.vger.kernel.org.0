Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D278F32100D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Feb 2021 05:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhBVEnm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 23:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhBVEnj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2021 23:43:39 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C484C061574;
        Sun, 21 Feb 2021 20:42:59 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p5so2100511plo.4;
        Sun, 21 Feb 2021 20:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nKtPFB1xyx73OQfeVTdioOSSM0I1Aror0iPkO5KBpc0=;
        b=Re2HcRKTF4oDMZmpesnJOT49BwGsqOQ5KGgusmwalLvCB7TfEYfXSeo69BzwRE689o
         z58SuWtj9UWQPTrO8Z6Ukn520ek2bdjIgYtTZh+TbOboMuZSsw+36lHU8Ya/QD29l5ki
         0giww37q0kTVuFy3iMPRR99RUBLWtg0PPIl+y96/9d0yXJHhCPfjRnXiJXZjBQw36mkp
         Ok8D7aZp4iitcIBZLJhf+1dLyovaqdm9lQK0Y0yd5hn7JHKWdg4t6aqvUrG3zoic/fqL
         ZQ4UHyytn1+2ls0uNt/rARQjCI9kM74p5UWoxT7ro7xyVwBBaqNf6JyfIprf7vHvg0K1
         YWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nKtPFB1xyx73OQfeVTdioOSSM0I1Aror0iPkO5KBpc0=;
        b=nB/PzMQnvoaAiGT/4WawLQj+/EGbyeQLs8gpfCugHTaL0waZjMqwtzcLYqqLZVnsYL
         GELGX3xYfN4gj+/hL3DpRIWrljxfunnRPqLlScGsybh5hBinyQ802E0YqlMOJ5C5pxA4
         9AVCVV7THtLOotDufKPOi/urQKTRLtVcsgctlKEfSmlOiTpx/Gx7ra0/qhbHzpCTk3ER
         ZcShhxw6MvJCSiqmyVNmhQQfrGaSCCBHKwuxiHWrok7sdPWOCuCemBu/bVlhWh1DNIY7
         0utGg/Oe9ZmSUhDkTARSWWPVCR8K65Jd2GajpT3hS+yFMUQRoY1A0qsPj9KWbyBLH2+W
         sjrA==
X-Gm-Message-State: AOAM531m2aFY8knn25llX7cBeQn93ygECXySnxZVyASZV2kCThYm1CmI
        XA2Ybz42+jTN5enHta8CZvk=
X-Google-Smtp-Source: ABdhPJx4YWkwy4GkpN7j67wTtgRujttnGXkdr8fmpug5JI4lVDWB4gqo8OpDW5W+tWoXKI3txVZKjw==
X-Received: by 2002:a17:90a:6589:: with SMTP id k9mr21210384pjj.100.1613968978881;
        Sun, 21 Feb 2021 20:42:58 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id js15sm8400296pjb.37.2021.02.21.20.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 20:42:58 -0800 (PST)
Date:   Mon, 22 Feb 2021 13:42:51 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 09/22] counter: Return error code on invalid modes
Message-ID: <YDM2SzQgL+GAHhUV@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <58e7c59bb7c7bb94c8655903308842d9d9e9907a.1613131238.git.vilhelm.gray@gmail.com>
 <d5b53db8-395a-b77e-77fb-49f7fd0da231@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H+2x3VvQXXETcoRB"
Content-Disposition: inline
In-Reply-To: <d5b53db8-395a-b77e-77fb-49f7fd0da231@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--H+2x3VvQXXETcoRB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2021 at 10:43:06AM -0600, David Lechner wrote:
> On 2/12/21 6:13 AM, William Breathitt Gray wrote:
> > Only a select set of modes (function, action, etc.) are valid for a
> > given device configuration. This patch ensures that invalid modes result
> > in a return -EINVAL. Such a situation should never occur in reality, but
> > it's good to define a default switch cases for the sake of making the
> > intent of the code clear.
> >=20
> > Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > Cc: Alexandre Torgue <alexandre.torgue@st.com>
> > Cc: David Lechner <david@lechnology.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
>=20
> Reviewed-by: David Lechner <david@lechnology.com>
>=20
> (In response to Jonathan's comment, I think this is fine rather than
> adding more churn to change all of the breaks to returns - but will
> keep that in mind for future changes.)

Due to some other updates I'm making to this patchset, I went ahead
already and updated the breaks to returns in the few places where
applicable. The changes to this patch are minor, but being pedantic I'll
hold off on adding your Reviewed-by line until the next revision so you
have the opportunity to formally approve it.

William Breathitt Gray

--H+2x3VvQXXETcoRB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAzNkIACgkQhvpINdm7
VJK9rRAAyu8elp03L+LXeHNMXyjon3ijwzzn9y1RotPVZbIO3A1Ikd8HPRaFB1a2
mveObCiWyOmduF/wqTfzTD0yJ1PlfzyHmqynlw4rqAx5WIc1Tq3vezkl4EoVQCz4
kgaAZrcDNVcRXT2nrmGp7g4LP6hjTlTBD6hYWibN3II8b4iyFO/8VWCJO4U/ipJs
wjPNtbh9Zn6Eak6yIbGRGsaZ3g//Bk4I5AQGzCk2fKnh8i8W9FHgNzVvZ5nf2VFf
VuAplEmvItTnc4Ua1Qc0YzffEzasDbef0/lVaRyq95DsdJCLLoIxfYXiuvx8P25f
O0dR1GkfiFsviq0syAydVjOWvtyEeQZAJbwsuZCVu19ENhNNrk9BGh9WE94vG+Xi
2hFhG1Q6bCDnEQvoqUbBswvdQLtzHRUvfpoo8ZNfwRpjFqsp1bBBebdOO6TKWnH6
+7QvSQF2nEgCT2yxdnv9iu8mrp1wgg8fho+X4uQ+Iqil5lnPu2iG3aud6ooMwWOa
YfMwFdHhEotekumCwqXexOkCWOu8wJHrAPcbm+ojv5NBCsFhHvJ7aq5On9+zF+8g
BDhWcoRhQhfR6v6u2E52S8KdrQyr1x+mq2rbEy6URexMGlbJL7bPuaYNUHI43hfy
pPTwE5lV+R17oNpB0TSDABOVo7Y//VFE3DpwKlsSNx3QYOAhxEE=
=oo0o
-----END PGP SIGNATURE-----

--H+2x3VvQXXETcoRB--
