Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC1731C4F8
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 02:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBPB1k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 20:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhBPB1k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 20:27:40 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068E7C061788;
        Mon, 15 Feb 2021 17:27:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id kr16so66339pjb.2;
        Mon, 15 Feb 2021 17:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cpP1ahAbYan7YrhKGABY7qWKdkXmh1J8OMHCMFf0SeI=;
        b=aoUt/JAVVyZWrlbnPdFWPTtECiCDrkWw0PZguZKigVVFgc5qwZGJjYiPd5dbwTu31m
         4FosxisgDEvys+q00Jl9n3zTX551puDWyzKBtC9aGzfNel55RJcolxngGvtuR+tkrhKO
         03Sn/IwH4sjnNveqar68xFfrkZqMXrwfmErJ9UBSN42wVeofYUVVpS+b5tEpZnX8izCT
         1WweRKYjX8v6DE41T+7fQtG+43ScIZ5YciuRtWwaWfxdgqDRceiPCwLeK4OISr5N+2N2
         MsgC5CWOUVaL94U1KtZxMpzs4gOueffK2axcnnQsiHxjxFWdEsf816hEclVlxkeOfk2s
         tvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpP1ahAbYan7YrhKGABY7qWKdkXmh1J8OMHCMFf0SeI=;
        b=Lj1ZC86n+3+7UV2RF2KfJdfsfX3pfmTtDq4xAn8ciV6lrgVLthDcuxZ7Ys1mHCe03m
         Wf7Ah+5lTY6w4Gi6dl3VaNf8M+60mwUPiNtxuglyk/GMgqG9lbzOQm7wZ22DNJwf6x44
         f1k850hBc73UKnMPr8KNmi9RFYCmHk1WW8XpkRrdla35k2Ces5CyO2/IAFfdLKjaT6+f
         fLkk7JtC8/9y6wxVy6w8afUKQwU59A2lKeKsBd7RbiFAXQKPhn3ENoepzrSMtyIfo7L6
         +9hF+rJSm5fqn7LMPmzF7saVa7SYdq4wFJwXzAsAB/tALDut/xVJPJ2akQUI9wh+6EbH
         IlcA==
X-Gm-Message-State: AOAM5311Nw15sZOOp/AJ1Rrzdgoo9ytO2WRUjqgbSNucVbNbzSj7numR
        V2Ej9IgIOGL71PgmYS8wTfM=
X-Google-Smtp-Source: ABdhPJxo90mkA+P5tI6ctkDDRI6HmZSiLwFtseUgjjIOvHod2nOVgNMt+VfUkzRX9aWtvjLuDYkq6A==
X-Received: by 2002:a17:902:e9d4:b029:e3:4192:8de with SMTP id 20-20020a170902e9d4b02900e3419208demr11335432plk.57.1613438819185;
        Mon, 15 Feb 2021 17:26:59 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id n10sm10056704pgk.91.2021.02.15.17.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 17:26:58 -0800 (PST)
Date:   Tue, 16 Feb 2021 10:26:52 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 10/22] counter: Standardize to ERANGE for limit
 exceeded errors
Message-ID: <YCsfXGzfEgRAD9p9@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <7fa80c10fcd10d1d47d1bddced2b2cca3ff59ba9.1613131238.git.vilhelm.gray@gmail.com>
 <20210214171021.41b3e4e3@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LCIwYMzstikRFa/y"
Content-Disposition: inline
In-Reply-To: <20210214171021.41b3e4e3@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--LCIwYMzstikRFa/y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2021 at 05:10:21PM +0000, Jonathan Cameron wrote:
> On Fri, 12 Feb 2021 21:13:34 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > ERANGE is a semantically better error code to return when an argument
> > value falls outside the supported limit range of a device.
>=20
> #define	ERANGE		34	/* Math result not representable */
>=20
> Not generally applicable to a parameter being out of range
> despite the name.
> #define	EINVAL		22	/* Invalid argument */
> Is probably closer to what we want to describe here.
>=20
> Jonathan

The comment for ERANGE in error-base.h may be terse to a fault. I
believe there's a connotation here provided by ERANGE that is absent
=66rom EINVAL: primarily that the device buffer is incapable of supporting
the desired value (i.e. there is a hardware limitation).

This is why strtoul() returns ERANGE if the correct value is outside the
range of representable values: the result of the operation is valid in
theory (it would be an unsigned integer), but it cannot be returned to
the user due to a limitation of the hardware to support that value (e.g.
32-bit registers) [1].

The changes in this patch follow the same logic: these are arguments
that are valid in theory (e.g. they are unsigned integers), but the
underlying devices are incapable of processing such a value (e.g. the
104-QUAD-8 can only handle 24-bit values).

[1] https://stackoverflow.com/a/34981398/1806289

William Breathitt Gray

--LCIwYMzstikRFa/y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmArHzgACgkQhvpINdm7
VJIx5BAA6jicWLlVTYqEHvX6K51XipDK7p5f6FQAAriMLEauLvpeW+e4yUHkKwYS
xLjPabXpTHvPkAsjW96EgIxx2WTze/Ev8FJXRG0QIEaujtxJJ5L1rK1UYN1y6zXt
/Mmv3gTJeKDq5AWHmMlLlFj5rXiXELi2U+FNz8kO6uIHAUpsRgatL/uWwujGfPO/
qP4zDz8IzhFU1ml90Wl+dZLO1nCQrM0CIi5sTFTvd4vBl9hV299mMuHJYFCIttGU
T6QGtuoirMIS1SFYE7/RmapuakagCTRgeD/CPsaNhSBegqVJ+ouIcUpAV3mtBg44
VoweVhNDW8zG+n67KiTOACOEY4w4KFNfLwIH0ofMZ1GKyraqmlkf56wvCkQ04BoA
LlD0eD3CoIZQjt+2L9tSc3gm/VugwGukmiJzQGAcfSv7cXeolPkYw9PD3h0wYdeT
pUSYg2XS8bPCVmgjs4rVEjJEcXCpyTCOqqe6oUXyIBItCujTwKp2INaLdK0m/pUf
zJgyT3uze5jKrKlsCWDbAgXoigrHAvNbb7YOR+yMYh50n9M4hOHDbBn3VbPUWjMk
K+zLEh07ITk9D9IksCGvGacIMIJhCTFxmh0L+azrysOUCBzicvdIar7vfofbjV/t
+ct7S8NTEYO/cBuf4CI4EKWAyGZSr+loGy9kfBeA+bT/Cf5AaCM=
=oLJj
-----END PGP SIGNATURE-----

--LCIwYMzstikRFa/y--
