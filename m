Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6B96B6BFF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 23:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCLWf0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 18:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjCLWfZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 18:35:25 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767FD2CFE4
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 15:35:19 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id bo10so7176742qvb.12
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678660518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkExPuFUCCT2ZLn9o1HBYqlIGVStqDHCO2raPRbE9Lk=;
        b=z7vuQ8nDPQsO6U5FQM1Lpt0LGWiKJ+TNR+d1v0RJNb3Y06rOVK5aNvAc3zbFF7e3i8
         h4wgiGz6XpgvUmFedppx2h73U42c+Id5RjNXCNKXgaMBIQWVjvluNPzKDoZHyCiSK0Dk
         YT21k/TGsEtJB+9daf/LeIo+hqT0Ok4BQhvwtZvO1jU9n+VuCZxqOeZ5x66jBuCW249v
         ce4tKFSV3NHoMbzuVQp2wFOTMm5fpF1XMOX74lM0/ZGpehPCJotkN6v5Gs4kvW2NDqGx
         0N7LHcknrQcm9Wj3Y/iCggf71mrJ788IUwGV1Zd+fcrdV7oq9g76KXsr6lSLLgg0yXSf
         hoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678660518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkExPuFUCCT2ZLn9o1HBYqlIGVStqDHCO2raPRbE9Lk=;
        b=1696AbJKR5uzYGGoXzmfJdh5iY4YCQ6Wm/Q9Q8y55tiyB62jxs/b30kocU/GooVsw2
         /yAgWZxeHLNbk3yig8mMWU+sO0qBQIcJZcCPQPxYJEedaLiD7m82BBI8HF/M0eGQ+tGC
         Z23CBeX1yPj0hs4k3olhfXGTYp2lGWDYpzu75BbNQvJV0dq8+GwgMVuObuTe0wHKbE4U
         UGdftDme79lF1Pj2L2ioIcx1E7WSWGzE54LQ46Vt102dlHwhQq1FHu/EtqhnasbygMq/
         95n41qWiXaxgqRazoVaPqeMtYc1+1rRby2XHXuQIhambFkIGa64Xyq6EaiZRXPY4OkJ2
         u42A==
X-Gm-Message-State: AO0yUKWB/tDsSLwq1Hz2RtQMcaDLJJ7jeH3H9rnceyMHoCHtMcWTl79/
        doCbkEliJFOKyKyXu4y4sz0CmaNyBDvOIB73Pjw=
X-Google-Smtp-Source: AK7set9ujlJiFJFaoLeEWvtb6YT8kCXF7TqnTvXGC5DLjy79SFJbaPpyM3/4VM3sIDCkSuTNc8rfog==
X-Received: by 2002:a05:6214:f06:b0:56b:eb9d:4342 with SMTP id gw6-20020a0562140f0600b0056beb9d4342mr10042568qvb.49.1678660518323;
        Sun, 12 Mar 2023 15:35:18 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id g28-20020a05620a109c00b00742e61999a3sm4205901qkk.64.2023.03.12.15.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 15:35:17 -0700 (PDT)
Date:   Sun, 12 Mar 2023 18:35:15 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] counter: 104-quad-8: Fix race condition between FLAG
 and CNTR reads
Message-ID: <ZA5To4HGxrM0qoYP@fedora>
References: <20230312212347.129756-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ohg1rDHLUsdZDA0r"
Content-Disposition: inline
In-Reply-To: <20230312212347.129756-1-william.gray@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Ohg1rDHLUsdZDA0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 12, 2023 at 05:23:47PM -0400, William Breathitt Gray wrote:
> The Counter (CNTR) register is 24 bits wide, but we can have an
> effective 25-bit count value by setting bit 24 to the XOR of the Borrow
> flag and Carry flag. The flags can be read from the FLAG register, but a
> race condition exists: the Borrow flag and Carry flag are instantaneous
> and could change by the time the count value is read from the CNTR
> register.
>=20
> Since the race condition could result in an incorrect 25-bit count
> value, remove support for 25-bit count values from this driver;
> hard-coded maximum count values are replaced by a LS7267_CNTR_MAX define
> for consistency and clarity.
>=20
> Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-=
QUAD-8")
> Cc: stable@vger.kernel.org
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> @@ -156,19 +155,9 @@ static int quad8_count_read(struct counter_device *c=
ounter,
>  {
>  	struct quad8 *const priv =3D counter_priv(counter);
>  	struct channel_reg __iomem *const chan =3D priv->reg->channel + count->=
id;
> -	unsigned int flags;
> -	unsigned int borrow;
> -	unsigned int carry;
>  	unsigned long irqflags;
>  	int i;
> =20
> -	flags =3D ioread8(&chan->control);
> -	borrow =3D flags & QUAD8_FLAG_BT;
> -	carry =3D !!(flags & QUAD8_FLAG_CT);
> -
> -	/* Borrow XOR Carry effectively doubles count range */
> -	*val =3D (unsigned long)(borrow ^ carry) << 24;

The count value is used later on so it should be initialized here; I'll
submit a v3 along with some backports as well for the other stable
kernels.

William Breathitt Gray

--Ohg1rDHLUsdZDA0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZA5TowAKCRC1SFbKvhIj
K1McAQC0qlj/pFqJOdBNrAtOL3qyWM5zS5XN+cuwgfn5lHf4cwEAyHBzBklZFy3x
5sE7fT8R3oi88bMByhaLs4GGeZRAFAI=
=mTRD
-----END PGP SIGNATURE-----

--Ohg1rDHLUsdZDA0r--
