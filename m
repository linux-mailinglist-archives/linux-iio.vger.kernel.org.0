Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6C419221
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhI0KXF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhI0KXF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2021 06:23:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCACCC061575;
        Mon, 27 Sep 2021 03:21:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23so12133061pji.0;
        Mon, 27 Sep 2021 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G41HQyC4+WAMCW41WRWgfTs873BjVCWlDt89o58/vJo=;
        b=nBvTmXHxczG2DYg0EHyY/hzUWZIDU3s2oS4w+YfnM+0pIir8EFPTbTo82sCJT8PfjN
         jyamCnBGef6XaxzAhChbONRX7Drov0h3n5mUyw8nfTVLdm3BJGQnvcJx5oSbG0nKJpS7
         cbas5jd76l09vVxaBrm3RRUmdCn/amsS7Ml/stTzMVFsuKqo2A2d7aRT1LKR6EEFQTA7
         NhBknNwmgEf8cgZpDEDY2AwaFU8A5leRTWGWaMBeAaldoTk9qlghzAoKob0iHQzRjOae
         Lyxa4o42bKdxCCcDM5wDkziUcQ+qcruKSKOiSq1k87EUAjRJ542XOrfqtTDELEyLhz0v
         ZZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G41HQyC4+WAMCW41WRWgfTs873BjVCWlDt89o58/vJo=;
        b=gaW57Erm2UK6RwmwhO0Bi2Ke+COKLn8QiOE8gIGH4WiECPbnF05QoWETbBB/cW4SKl
         VCB/cUDevcmtKjp0TSwFX5vUMpIKpQWJjKoUgzMHoqCh3ZOvSNyrmm9mywmu5Vb0Nv3/
         teeE4bsJVjAQ38m+wJo1edMvP9jv20qeeflAKVhQpZblBTuAGch7DgH6FrWNQb0Aizn5
         OOZNycVVhqa6trYgjLysVyi1JXkjzeJeLZ+Ol3X0tN3jwXeL3zWzT3hmqc2giXjhbF6G
         piO66kSj3oOvdgWX9Xsb00S/sUj3PGOFH4+tGLOtTqXF9k5u+rk6D7JsQK84WfXDoXm+
         zZFg==
X-Gm-Message-State: AOAM532wYXOGElOrzOib17VYNqa9wwPPKOgoFwGfgjbGEp6jjNdTlbVL
        2pSy7jMwxHP9eeRmC6r9YSo=
X-Google-Smtp-Source: ABdhPJxK/GBjVs9Jg8V3mVZtN087n4n1ZFvm9LTibJZB6JAYGORREsIdHZXnK4+rdlB/+gNpTqGQaQ==
X-Received: by 2002:a17:902:7783:b0:13d:fee6:8095 with SMTP id o3-20020a170902778300b0013dfee68095mr12083247pll.7.1632738087193;
        Mon, 27 Sep 2021 03:21:27 -0700 (PDT)
Received: from shinobu (113x37x72x25.ap113.ftth.ucom.ne.jp. [113.37.72.25])
        by smtp.gmail.com with ESMTPSA id q18sm16574471pfh.170.2021.09.27.03.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 03:21:26 -0700 (PDT)
Date:   Mon, 27 Sep 2021 19:21:17 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
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
Message-ID: <YVGbHQnpBTQYm/7/@shinobu>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
 <422c765c91d060cdebc4f17f7aeb255d9c1a4e16.1630031207.git.vilhelm.gray@gmail.com>
 <20210912171821.54af145b@jic23-huawei>
 <YUhdyRdzuBtUxOzT@shinobu>
 <20210926161542.5cf99b58@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H/MVuzPDD/iGErPz"
Content-Disposition: inline
In-Reply-To: <20210926161542.5cf99b58@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--H/MVuzPDD/iGErPz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 26, 2021 at 04:15:42PM +0100, Jonathan Cameron wrote:
> On Mon, 20 Sep 2021 19:09:13 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > On Sun, Sep 12, 2021 at 05:18:42PM +0100, Jonathan Cameron wrote:
> > > On Fri, 27 Aug 2021 12:47:51 +0900
> > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > >  =20
> > > > This patch introduces a character device interface for the Counter
> > > > subsystem. Device data is exposed through standard character device=
 read
> > > > operations. Device data is gathered when a Counter event is pushed =
by
> > > > the respective Counter device driver. Configuration is handled via =
ioctl
> > > > operations on the respective Counter character device node.
> > > >=20
> > > > Cc: David Lechner <david@lechnology.com>
> > > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com> =20
> > >=20
> > > Hi William,
> > >=20
> > > Why the bit based lock?  It feels like a mutex_trylock() type approac=
h or
> > > spinlock_trylock() would be a more common solution to this problem.
> > > There is precedence for doing what you have here though so I'm not th=
at
> > > worried about it. =20
> >=20
> > Hi Jonathan,
> >=20
> > We originally used a mutex for this, but Jarkko discovered that this
> > produced a warning because chrdev_lock would be held when returning to
> > user space:
> > https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T/#m6=
072133d418d598a5f368bb942c945e46cfab9a5
> >=20
> > Following David Lechner's suggestion, I decided to reimplement
> > chrdev_lock as a bitmap using an atomic flag.
>=20
> Ok.  I'm not sure bit lock was quite what was intended (as there is only =
one of them)
> but I suppose it doesn't greatly matter.

It didn't cross my mind before, but would declaring chrdev_lock as an
atomic_t be a more appropriate solution here because we have only one
flag?

William Breathitt Gray

--H/MVuzPDD/iGErPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFRmx0ACgkQhvpINdm7
VJIHsxAA4vgQ2N9AG3JBKZ4fdy5G0HIRCQcAbW8p4y0pfsCmeJnK4A5gwyqDpE12
YZRactHayYy1wjbSUfNTV1cToHiN3XI4QXe+VcY8ybHEXHxuUxr9CH9edEXb22YQ
9r3SgyCNgK4f9duQ+gdFxtihSJPgTyQA3v8x2h5aR74AgLh2tLTaFIDS18Tc8/4A
sdp+3CfRTQ5/fxKhACQ9XgHt1qq8chNt9Fxd9UumXNv6x+ppesRx3+mcmP/SEtAd
Zx7TIRc837fgv6lWrY2x8EEkJXcOgMdJDAhTyHNZTG6/FqxZf9X83T0GekBFufz2
p1HjBNxHQNxwMG9A8MDT2vTH7AqBoWWeatmYnW43uPC38ADX3x/hsNBPOp3zoKPR
MjQIq2dJbVUAf5QOjpLxHYQYBw8tC668Bc76n7ut321CIVvv4/TVsqKpLN6zWnTW
bPhqMuzM3fNyMC9+q5tdHefns3yVBHWS10xoneRGYE/h7LrF8qjrFsL/ZVnrT8IB
RefwoLUEXS4+3Gt7pygyzLOuJE/ZciRUGzT5//UAP/D2hMp4oU5VxVCL7pQSMwVE
dLbp6+DbAZMMpNs87fNMUloxN4sRcwttunlaBChWslme1+0flWpfgFyMIbJI9fi8
31xRbk8ixMsFInEmjC9tNeD45FvMVNg8MoPUPtu8ZbzTvimD6Sw=
=Tugq
-----END PGP SIGNATURE-----

--H/MVuzPDD/iGErPz--
