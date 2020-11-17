Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA492B5F0D
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 13:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgKQMZu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 07:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgKQMZu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 07:25:50 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF1C0613CF
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2020 04:25:50 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id v20so7159493qvx.4
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2020 04:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gADBUQ9Hae6TrHG2WXhgqR0ilSCLKu5qzspZRGuFCcQ=;
        b=HHVpgSwES/RzV9qCoD3T83yzWbkiPtbDhJRgKOEfJ1Naefp+wXOgfWt3XJpD4cxIpk
         IZHMpD6GIYaSSU1BSWdqJapoZ0P9cDGQti8jTPZuR3oIQgBssK3U710v8byPOEvxqZjZ
         elouPSvf3pIcX7Rc24n+vVIXHgEhKLey9DCDZTneSDaXzriFnucGq3RkbbfUie4rppDB
         XGZYRKK1RymTzcwjGATzo5rYJfIgKKJlPG2veMWcDxZ0y3yvEywQRp8UrABZHjuyJI/3
         c5XSpdC1NEDezXjfMW+5b2FN4GCDIDXD3atxefmpIf0GgyjvUxe1RNnacjzbeYsl/eaq
         QNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gADBUQ9Hae6TrHG2WXhgqR0ilSCLKu5qzspZRGuFCcQ=;
        b=bnedAjM/51xSB7m5uGjdvSy89WvQQtsUEejVH5YBr+AavxfPBSoR4NpOg4I8P8IxEN
         cMWyyu7VSQ1jmRhbmEzs/+B7HA4OnxaOhyXrEe5159Ih/fbDrRr/28xMeUwIXEks4yud
         5hjmpzMSrZLxEEW3kug4URSp1feGggbQSf7LyoTEYrJTg/ariAe5T6vgmLNCxVGg+xQB
         9H06k/Dr/aYzH8vw7MFYi+EDuEA/UUKAkm0r4rsqtblQA0mgrrGiApv8eGFeiA2ZH506
         1zUm6KRBBhFj/0+eRrmSeTW0/IUBc+bPnwbILgEB+niMj8jIC49UEq15MSV4WVxcsfte
         q9tQ==
X-Gm-Message-State: AOAM530aoB6/qSksxZcyWLRoJo6+zYoXOsa3U1QCVPMopyxDqDPGY1wL
        jNIZsTtzvEETysZ6eLym6zs=
X-Google-Smtp-Source: ABdhPJzYEZOOf689Mkp2upgEYPTg01QHMBm5QpPlHo+8aWErAi8apOAd/F7uFNJ+JxnjH6eMtJy38A==
X-Received: by 2002:a0c:ab1e:: with SMTP id h30mr20453703qvb.55.1605615949545;
        Tue, 17 Nov 2020 04:25:49 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id f202sm13683253qke.112.2020.11.17.04.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 04:25:48 -0800 (PST)
Date:   Tue, 17 Nov 2020 07:25:41 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Holger Assmann <h.assmann@pengutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org
Subject: Re: Counter device Interface for reading out input capture
Message-ID: <X7PBRc1e/TbOPYmT@shinobu>
References: <e8c99989-f018-dd90-2144-e09c05a3731b@pengutronix.de>
 <20201106124217.GA4015@shinobu>
 <0fa25b7a-92f9-8eb7-088e-2ef3a2edf2a0@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nSRaz29Y8MvsNho9"
Content-Disposition: inline
In-Reply-To: <0fa25b7a-92f9-8eb7-088e-2ef3a2edf2a0@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--nSRaz29Y8MvsNho9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 11:54:17AM +0100, Ahmad Fatoum wrote:
> Hello William,
>=20
> On 06.11.20 13:42, William Breathitt Gray wrote:
> > On Thu, Nov 05, 2020 at 07:46:14PM +0100, Ahmad Fatoum wrote:
> >> It doesn't look like the counter device API is yet made to support such
> >> an input capture mode (latching a counter value on an external event, =
e.g.
> >> to timestamp incoming rising edges to measure jitter between pulses).
> >
> > Regarding the Counter subsystem, I'm developing a Counter character
> > device API that supports timestamps for counter devices:
> > https://lore.kernel.org/linux-arm-kernel/157d1edf-feec-33b5-7ad5-94f993=
16ca6e@lechnology.com/T/
>=20
> Any chance we could have a "raw" timestamp as well like the network
> stack offers (cf. SOF_TIMESTAMPING_{RAW,SYS}_HARDWARE)?
>=20
> The API currently only exposes a ktime (i.e. CLOCK_MONOTONIC), which the
> raw timer count can't be readily converted to. For our use case of
> measuring jitter, the raw value is sufficient.

Sure, we can add support for a "raw" timestamp. I can see how this could
be more useful in certain circumstances rather than the ktime value.
I'll open a discussion about it when I submit the next revision of the
Counter character device patchset. :-)

William Breathitt Gray

--nSRaz29Y8MvsNho9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+zwTAACgkQhvpINdm7
VJJYTQ/+PfehxFKZUm1Zo/rIlQG7MY2iPsOOAwVrwt/jAl0dIRd68h/68ZFoT0/p
+hVVClbTv/TwNIAyJLgFHS6UNAJlYx9pU1sbVtyzzGDD4H83u1lfdUeO+9t3DvBy
qRmlVZrv2Shl9eIJvChVPupOv8E+DYyG8uIIXKzAakF8bQeFGiI611mV3s4rDDEW
1MiygpAN81LZmTP3h3wVV4uClvI+MliGBCGPv5BjYjSl3tnqAvSjFjsOiNovD9ue
OFQUkZQbpEBaQWuIpGL5i6YZEfpYp084AWoXhOiIhQjAQTY+V2RQ4ADp4wsLNodf
kEBdZ0FLJx1rrhm4iDAaWMxs7vCo/pVH0bB2ZNv2vqbAUjIM5+g0rRgGdvd53DMI
1Y8+l+DFPraDB7mbM6Gp36pQIABzQc/0K9oq++g4h12q8H/gmsEb004C0GMP1fsF
zosN+xYqGvBjiwq7Doq4n8mU3Batwz5+WxtoKBM7m3TX/OykSbB3ne0yGPjGGM1u
SepLf4E+GLNqHHdmbXj6/Vsq4qaeEk7vDUs12BPNvrX/AnfLzLcdCBI21Ln0sv8B
UbKYOghdfjA31mRltI4tDtpujgm1euhDDGE+ebZK/JcYzoBfl9tpPtd1dDrp3Qx5
IOc7cqPKybWsTDiwuWw/l31953+aX9hYZsHs6b0PpdKhBN7bN7w=
=lBqg
-----END PGP SIGNATURE-----

--nSRaz29Y8MvsNho9--
