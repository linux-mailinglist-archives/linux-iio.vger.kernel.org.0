Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031C232251A
	for <lists+linux-iio@lfdr.de>; Tue, 23 Feb 2021 06:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBWFPg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Feb 2021 00:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhBWFP2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2021 00:15:28 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B98C061574;
        Mon, 22 Feb 2021 21:14:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z5so4863352pfe.3;
        Mon, 22 Feb 2021 21:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sv+2xHnuMxoZYHZzlSKqDTkD28ImMvhuxWF1qu/hw2M=;
        b=oF1hpcgZsgJA6Wz5ZkZHxTnYjw2yq4knr7L8Dr3qfv5V27hA1y1dFyuRPyBl9Ccb51
         Z0Zed4wnMmPLgjnjNfJTHiyWagan3uwpw4DxXtvv2huyGbqYU8eCt1WgOs4CgGlpGfDj
         PZclBXyUm5Cd6VWrcS0yrJlfB26onKqMJTIkyNOLBuP56+YGQwCGA62q93J8GAWGt6ll
         v4HQAGFTAT+f8K0jNfrp6110o0A7Wn1Pfi46UoDlD3CXobjF1DHA3lGsq5YXwKYFMuXi
         HTCTuK+CDmHoocyGsC4leG3Ot+cP+y//Pv60VgrfydmzlRFzZsuXWsx3gFpOcCB/6ie6
         wmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sv+2xHnuMxoZYHZzlSKqDTkD28ImMvhuxWF1qu/hw2M=;
        b=ADtGMgrIZeus+xvDITF1SwgGVHhX7Pp96vFpy39XyovFAejlF/9bU69azeiYD/hYxX
         lz1ezM9sGJ01bIkj8mHTKoKN1LGNjQNCQmNMVSjfJPuHsiovRqreNIm+an/G29Zhls7i
         IAnHKGLAKeZ5XbqQG6auNvml3FUqd8jgDr2R0jKfWkcZV+SOHDxItBBVGuRCtxVgxUjb
         tXwfnVvJZSGXPX84HCEDbAxlj3Uc0zzNx9YrIcsPJzwCoixE4UpgirTkKWP2tQDf/I6R
         rO27OOdVZSTjTSd/8+Hi+nl84ysuKgzUxt4CQiwj9tQlCh94Ni4xHllnCh+8IrD66ImZ
         9A6g==
X-Gm-Message-State: AOAM532ZigoEmJ+r+GbpnYiRf+3RvhXWG+82btLL1TbZC6cNhIkVJf2j
        zmUs6E6bKNebt6e48b7Whn8=
X-Google-Smtp-Source: ABdhPJyyTbQX1xY/5LRGeepQyY86TC3qofoANb1P6IBA6o/d/HQnaXFWhWzu47ogWesSYM3SPOECmQ==
X-Received: by 2002:aa7:8b48:0:b029:1ec:a315:bdbd with SMTP id i8-20020aa78b480000b02901eca315bdbdmr708936pfd.51.1614057287907;
        Mon, 22 Feb 2021 21:14:47 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i2sm1233145pjj.35.2021.02.22.21.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 21:14:46 -0800 (PST)
Date:   Tue, 23 Feb 2021 14:14:40 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 12/22] counter: Rename counter_count_function to
 counter_function
Message-ID: <YDSPQFMd0sqUBUaq@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <355aaaaf44b36c5de1704e4074a4671abcb9699d.1613131238.git.vilhelm.gray@gmail.com>
 <20210214171340.3cc7b686@archlinux>
 <2b6913ac-0802-f83e-06ba-e89d5318dbd7@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CvbW7fZyFWvbVNT8"
Content-Disposition: inline
In-Reply-To: <2b6913ac-0802-f83e-06ba-e89d5318dbd7@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--CvbW7fZyFWvbVNT8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2021 at 10:56:13AM -0600, David Lechner wrote:
> On 2/14/21 11:13 AM, Jonathan Cameron wrote:
> > On Fri, 12 Feb 2021 21:13:36 +0900
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >=20
> >> The phrase "Counter Count function" is verbose and unintentionally
> >> implies that function is a Count extension. This patch adjusts the
> >> Counter subsystem code to use the more direct "Counter function" phrase
> >> to make the intent of this code clearer. The phrase "Count action" is
> >> adjusted herein as well for the same reason.
> >>
> >> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> >> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> >> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> >> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> >> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> >> Cc: David Lechner <david@lechnology.com>
> >> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> >=20
> > I agree this makes sense in the counter core code, but in the drivers
> > it may not be quite so obvious we are talking about a counter function
> > given some of the bits of hardware do a number of other things.
> >=20
> > I guess up to the various driver maintainers on whether they
> > think the new meaning is clear enough!
> >=20
> > Jonathan
> >=20
>=20
> TBH, I think "counter count function" makes more sense to me.

That's a fair point. I'll revert this for the individual drivers and
leave it up to the maintainers if they want to adjust their namings.
Instead, I'll limit the name changes to the counter core code.

William Breathitt Gray


--CvbW7fZyFWvbVNT8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA0jzYACgkQhvpINdm7
VJLBQg/9GFXoFuC1SgrhZBOf3aVmvp31oECQ/jZrZRo78seSdAy7lyxzby6V8asO
adikRiaumev/b4NJStCUMH9qZ7P+nGRI74Yhd0HFaowh3vHm4DKBZfxcwOuh9sL7
8AUUpqaWFYXPnTn7G/JJv2nVGGlFH8FecIqOjYroMHhI6b8PiueMgqhHnL4bxlyX
AP1zJYt+EztFOCiLB4hglEbc/qS8lTzqE0qcBwAF8RaUC+bqeiFNb3HrrnT7j1dw
j+4o9KyuJ8crppn81jlvU54MM457MMh01sAW6KnvFWxFaUXE7LI/jAV0v3vuX4yi
Ag9kSHRT8zTkPtcQSFApcjwaWRVC7bkvmOLuNl3X4JDJtqb5soVvf5vULzBiUcrf
DtwK3Xiw7LXV8stKJsz8Ot9xASj47e+R6tmJZFmCDvb/M4zK3CZOAmZvYGuxv81t
Mi3SM1MyIBZScC+5Pjydxf5kxpTKfcTYoKYaZ/szQtO3bQMP5iyuiKlInnvj0JSv
ZP89E8JBuihK3C0HGLx4vx3L8n8qaXzoBfkPijnZh+RD2FmTGHuws7YSVkbdApao
jhSh+GnWr6kc+sH/Jo3QhU7I/rwtscxPmtKuhrptLt1D6C9zR6AKgmNWgd8jb9pX
OfT2odtPtlnQZZONRO/UgPnQYk2rWTGvOaaz+gerWbsAzIHiEvM=
=tRzo
-----END PGP SIGNATURE-----

--CvbW7fZyFWvbVNT8--
