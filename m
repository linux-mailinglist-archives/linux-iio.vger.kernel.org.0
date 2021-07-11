Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D23C3B44
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhGKJPU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 05:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKJPU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Jul 2021 05:15:20 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6DC0613DD;
        Sun, 11 Jul 2021 02:12:34 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id o7so8307247vss.5;
        Sun, 11 Jul 2021 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DOZ/sOH8+Rsjf9K6KjxQGtE06rD3YjMce9ekhraHpxU=;
        b=raHJHXqXoadd7fB11PI/hhlLA5jkvLxzqckn09EqGMk9zwQ9Afw7soUgyZGaJbVTK7
         mJiAwhhPLcHUm3fS1dMHR+qHYCIMboe7z+C4hYDgjupKfwL2+H8eoBHm6V4P0Cqaqpdk
         a3j3AhhdRxMhx25uqvQJULvi5+YzZHR424jmJTperMKDtwFw/4mGBR6wM5pYYe2VQFYZ
         keLvgnIUg6yX9v5y44S7qLtsYCNYMkfkUeNtkTbrQ7/QBuWvImRkyuz5DZgyFiKI8A31
         K8TJ8aWz9W1t4LmIAjs7pp0AHyrVlk3EA3VhEUQl7OYPw0uhUWltdT3ETlakiU18auGv
         dQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DOZ/sOH8+Rsjf9K6KjxQGtE06rD3YjMce9ekhraHpxU=;
        b=k6RTvibveJHWWJ03PWoW5YRfT5QjSsfBF2M4gP8HYqCREr7pkoq+vwUh5mPKtk6w3t
         2J68ZrZIPKTDMhn8oMuzQSCvdvYdIvwfBV/FewHphhX2lh4L+usHlGwkujCe8+/IirFg
         XrkOUmIyTgXdLY6olpkMWgoGOXRO1ZzIkd9gsaT1fPyFgKcYZ/8tkoHbUtrGk/KnF9Ix
         kf+ENk3ueEbb7RJSx194PkFrtR/WBKKWllFtCO1x3KPOv/OQPYIVXosEdB1heE08miR0
         Ff+MjQ0HWr03cfqD9+X/QyzYvca570505wHXz9+LMENTbRN9i0Dov2YSf++U2sBFY69a
         PYUw==
X-Gm-Message-State: AOAM532JdZGelJr7BytSmoX7Y5cXZFlzea1jWPxnPL5AGcuBUeRXFfot
        y4pThpTjBHN/5Ah+pz8MWzM=
X-Google-Smtp-Source: ABdhPJy4sYlbAvD925USY3o7g3cekIAiQWfPOcpJSUajkbSVOf7KKojVP1744YeqH/lV+OQ7fAEwHg==
X-Received: by 2002:a67:8013:: with SMTP id b19mr3288366vsd.33.1625994752311;
        Sun, 11 Jul 2021 02:12:32 -0700 (PDT)
Received: from shinobu ([193.27.12.133])
        by smtp.gmail.com with ESMTPSA id e20sm1570374vsb.22.2021.07.11.02.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 02:12:31 -0700 (PDT)
Date:   Sun, 11 Jul 2021 18:12:23 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>, jic23@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de
Subject: Re: [PATCH v12 15/17] counter: Implement events_queue_size sysfs
 attribute
Message-ID: <YOq19zTsOzKA8v7c@shinobu>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <e298043c880b350a42bdc40452376a3708bf533b.1625471640.git.vilhelm.gray@gmail.com>
 <1a624011-0b43-ac42-be53-a42f81923e5a@linux.intel.com>
 <YOl1frCrophjhk7y@shinobu>
 <fbf1ba4c-412b-fe22-0e79-76e968a00fb4@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QSOFuI5CHXQO+dHV"
Content-Disposition: inline
In-Reply-To: <fbf1ba4c-412b-fe22-0e79-76e968a00fb4@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--QSOFuI5CHXQO+dHV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 10, 2021 at 10:43:22AM -0500, David Lechner wrote:
> On 7/10/21 5:25 AM, William Breathitt Gray wrote:
> >> and after that
> >>
> >> [   16.564403] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> [   16.570725] WARNING: lock held when returning to user space!
> >> [   16.577044] 5.13.0-next-20210706+ #4 Not tainted
> >> [   16.582198] ------------------------------------------------
> >> [   16.588507] cat/331 is leaving the kernel with locks still held!
> >> [   16.595214] 1 lock held by cat/331:
> >> [   16.599103]  #0: ffff888102bb3630
> >> (&counter->chrdev_lock){+.+.}-{3:3}, at: counter_chrdev_open+0x21/0x60
> >> [counter]
> >>
> >> Jarkko
> > I'm not sure how to resolve this warning. The purpose of this lock is to
> > limit chrdev to a single open at a time. To accomplish this I grab this
> > lock in counter_chrdev_open() and hold it until counter_chrdev_release()
> > is called. Is there a better way to accomplish this?
>=20
> How about using an atomic flag, e.g test_and_set_bit()?

Yes, I think this might work: atomically test and set the bit to lock
and atomically clear it to unlock. I'll replace the mutex with an atomic
flag.

By the way, what is the difference between test_and_set_bit() and
test_and_set_bit_lock()?

William Breathitt Gray

--QSOFuI5CHXQO+dHV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmDqtfcACgkQhvpINdm7
VJJoJw/8DNxxfECJciiVQx9aysjKNMY0qReiNt0Ua1DGfW7g2h9MFwl+YZo/NqN0
JySbFvJ4DHIeUed1KOfr7bH4J0/PEG20xbEO14wHUyWBehXomn5/67lrDnzJ82Px
ih54U7JEEqdoda6eswt3U1dkvCwJF9lOzQDLe4xLFy127I/bctSDVncYpbFRcYlJ
VHf6EuD4Tu30IGYhLbDWIrZgv+nMXWzpx4m0cUPFhFJO2oW83GSYVKo0yB14NLJo
lmfzrmoX+9SPI3LLiu47yphY2nKSfvvb7Wi+ScOnUSvDd9a43Tb51tiZGoobbgGa
pWu5WXPnNcR5XYmIXx2vxxWx7XLAR+mxW85VO2MeQGQtsbiFeGUHuvbexqAu3JeA
EC6wySkTB35hgaesvsJMsBNfGdlQZjzydIidJqK0/uKEfqTL0+wJrnq5YsSkJ//o
DSRjEZor8+mYj6rDHLH2AIZRUKA7ddqzZWII693FJ6075iMWW2ptqznPx1ln/uiB
kXD3tuAuOv0fN4J7FJ+pOBWSszVUOIV26CoidHSmWXAKjdrx7HAwuYCgI/TaIgsy
G971rJubdTI0t/G1LOmQh0QvRcqeSiaOjMK8kbF1XGEJcRAOGM2ih8klUCZhDt6r
UyvmHW85UUQly1l4G7vtXa6X0cQ8sckFlwEQz1kjP/i3HAP/qbo=
=Lh1x
-----END PGP SIGNATURE-----

--QSOFuI5CHXQO+dHV--
