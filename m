Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0142419322
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhI0Les (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 07:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhI0Les (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2021 07:34:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB36C061575;
        Mon, 27 Sep 2021 04:33:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so13370086pjb.5;
        Mon, 27 Sep 2021 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MT15ILJvdwdfJ0S3xCwu9KIiLxiliiJmv2UXlemUS9k=;
        b=CP9rsMVtkPtI1TX4WVrmWdZ5EB8v1jE7T7hIQ+aKIj7w0UIslwSMPgxsSWPNxDp3fM
         9SmAF+8jK2bRThTIxrfPL+ce24bHfYAfXleEeH5FL329lgjUTzWa+5NAaLt4LgDcnIDt
         5U2P50ejKTJp0mjYlTmr+Ky8b6hf09aUcWRI8yUWeEjeDPikWZpq0dlgptfV7F+UOCpB
         ZxgcsAkvOQGuCs2DIL5DRvGaqFIM+SUYzjCtIrR+JR6RhakDVqzGzDp20PWriUsEs3xF
         GNXVmPU4cWydQ1hVf2x8sGWupISaA1gYMsgZknK7b/tm461NRTNoXrg+VpzjmjRbUqcn
         ewCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MT15ILJvdwdfJ0S3xCwu9KIiLxiliiJmv2UXlemUS9k=;
        b=Nqz037nnbaCUzmCvGbYT9iV4PDma5zq+9v48NNV/8wXXk4oco2dKSwz55nsWpMCCqR
         mXbPWMTfJXa8CD2dcvR6uaQG41Ih1aY3+gS7+wvTFuBccTLQvaRjvK/hlCtuKO3TuM43
         JIXid2vLKLn6h/wbAxhkn4cfGzBf+M1UNAz/0oN0A+giKaZguVgiRaD6U4McNJd68+Ul
         7rhEKXwkcxjtBgfLbOa3roP2YhxglyNMJAjdFOQWjejpE+dvzL2ZU/1OzBchETTafoY9
         UOgAfNLsHrEz1bf8iw/z65HMb98CGMVOZLqeU0iuKQ+LygOyza4QhtqIPMB6Y5Vi2qih
         o75g==
X-Gm-Message-State: AOAM532ZQKInLFxhTc/ps3C+7WAGfSPL7QiETD5IcdqmvK39bw8G2gII
        ttHaObgdQdYNd6aTmuLOnn4=
X-Google-Smtp-Source: ABdhPJy+c7oavzzGB1I9sxfTfZAjkTwkMzpRzOHevsnj/eF21dgXZmGd2I5XE8ZTm33UIoLmJUZkQg==
X-Received: by 2002:a17:90a:19e:: with SMTP id 30mr19124557pjc.131.1632742390212;
        Mon, 27 Sep 2021 04:33:10 -0700 (PDT)
Received: from shinobu (113x37x72x25.ap113.ftth.ucom.ne.jp. [113.37.72.25])
        by smtp.gmail.com with ESMTPSA id w142sm16865891pfc.47.2021.09.27.04.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 04:33:09 -0700 (PDT)
Date:   Mon, 27 Sep 2021 20:33:00 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v16 07/14] counter: Add character device interface
Message-ID: <YVGr7PQQThADPNSW@shinobu>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
 <422c765c91d060cdebc4f17f7aeb255d9c1a4e16.1630031207.git.vilhelm.gray@gmail.com>
 <20210912171821.54af145b@jic23-huawei>
 <YUhdyRdzuBtUxOzT@shinobu>
 <20210926161542.5cf99b58@jic23-huawei>
 <YVGbHQnpBTQYm/7/@shinobu>
 <20210927122000.00007d65@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qFJe+gs0QSTquwqB"
Content-Disposition: inline
In-Reply-To: <20210927122000.00007d65@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--qFJe+gs0QSTquwqB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2021 at 12:20:00PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Sep 2021 19:21:17 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > On Sun, Sep 26, 2021 at 04:15:42PM +0100, Jonathan Cameron wrote:
> > > On Mon, 20 Sep 2021 19:09:13 +0900
> > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > >  =20
> > > > On Sun, Sep 12, 2021 at 05:18:42PM +0100, Jonathan Cameron wrote: =
=20
> > > > > On Fri, 27 Aug 2021 12:47:51 +0900
> > > > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > > > >    =20
> > > > > > This patch introduces a character device interface for the Coun=
ter
> > > > > > subsystem. Device data is exposed through standard character de=
vice read
> > > > > > operations. Device data is gathered when a Counter event is pus=
hed by
> > > > > > the respective Counter device driver. Configuration is handled =
via ioctl
> > > > > > operations on the respective Counter character device node.
> > > > > >=20
> > > > > > Cc: David Lechner <david@lechnology.com>
> > > > > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com> =
  =20
> > > > >=20
> > > > > Hi William,
> > > > >=20
> > > > > Why the bit based lock?  It feels like a mutex_trylock() type app=
roach or
> > > > > spinlock_trylock() would be a more common solution to this proble=
m.
> > > > > There is precedence for doing what you have here though so I'm no=
t that
> > > > > worried about it.   =20
> > > >=20
> > > > Hi Jonathan,
> > > >=20
> > > > We originally used a mutex for this, but Jarkko discovered that this
> > > > produced a warning because chrdev_lock would be held when returning=
 to
> > > > user space:
> > > > https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T=
/#m6072133d418d598a5f368bb942c945e46cfab9a5
> > > >=20
> > > > Following David Lechner's suggestion, I decided to reimplement
> > > > chrdev_lock as a bitmap using an atomic flag. =20
> > >=20
> > > Ok.  I'm not sure bit lock was quite what was intended (as there is o=
nly one of them)
> > > but I suppose it doesn't greatly matter. =20
> >=20
> > It didn't cross my mind before, but would declaring chrdev_lock as an
> > atomic_t be a more appropriate solution here because we have only one
> > flag?
> >=20
> > William Breathitt Gray
> >=20
>=20
> It would be less esoteric.  This was the first time I've ever come across=
 the bitlock stuff
> whereas atomics are an every day thing.
>=20
> Thanks,
>=20
> Jonathan

I agree. I'll try that out then and reimplement this using
atomic_inc_and_test() instead of test_and_set_bit_lock().

William Breathitt Gray

--qFJe+gs0QSTquwqB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFRq84ACgkQhvpINdm7
VJKSxw/+K++TD+bpwz9akNC7gg8dm4YlOS7y97Z1JAkS+KcKMbTpdrFJJJbrtIIq
3JJi5iMjTtTsAPPl6Wa1qRCst3ryHR7UTEMJdAy2IR08If2piGn2frklSFH68ejU
0zrSBXnmGPmnVdLudetma4gd6MRY6VVNm8ncTbevE7kgo9QJsYvEFxRsrrf/zeHK
WRBTPNexTxSuclwr7WO612XFr7cUg3iIjdyDw2NMZplkLyFR/HSuw5pX62RFKAe3
z7NhkBsYF+FK4IraGP+2HlUHZ0v02iK86uGgUf4gmFM0tUHcEpN78Gd8lMm1XmE2
bIhnhm3vGrgcdINfcaKIHWTw6l8Xs7WjIlI8cHP8Mmw04euXtcAK2RFxxBdjn8kq
47yxGD2tReXUGSBuv7lXeja+kJ5CU1GHOVcetCQ7qjGXl8bxR/3W0vhetb1uxtLn
LEfXV18JF2eFuXA0vV0fX9BctKWPREOUFGoB+dE/LhlKUTFg/8E2aVFcD3pg7z9I
TBtpGA/mNREX9v4eTDvT5G+cYM44hqfYMMwktyk1pomFfU1L7GFBtNs1l5pU1HvR
UoTUkDJw12nIBwcOSslERLdsoikGTyrtoq3NXebrwI2CTL9sTuQ4SkLNp5m7GASn
4GCmOs7Gnc3vUL4E6jwgKclaJqCxtDSfN/PmYQ43qJT6p0bHrIU=
=xydv
-----END PGP SIGNATURE-----

--qFJe+gs0QSTquwqB--
