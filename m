Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5981893ED
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 03:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCRCPH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 22:15:07 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40835 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRCPH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 22:15:07 -0400
Received: by mail-qv1-f68.google.com with SMTP id cy12so6200820qvb.7;
        Tue, 17 Mar 2020 19:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNhoxWWto3OTBxATPguCKxBnejir/6rqXXsL2C1SRpI=;
        b=avtYE708cQqm4Rs6uB5LNa14AEB6+HCUP4pIFrrwqwuKznNHMQqhppgzehGXdkcC8n
         Jj/GuBv4ScSGA1Mvppdj4U/7e7tRyroZHduT/w62KpaEXK8KWP0bdNESJsfTxCeR6HQG
         lkrDjRUQ9KSf4CBC85dSy7fKj4NJowOZ5bqfGhm3tAXNVEpPcL6LD5hNJaXEGqYtFonW
         zZnEElIYzkSRQt+FEv4C0QzOzB/zZSNh/rhwdHpatbGx82WKV10UbVdNLz8N6FQ3gZQw
         s1mErBGBHJtSzf4kKJ69Ax9Ze3mZaEWVthJ95xcfmL3S3uPoFWyWGEfFrWwHOwoxvnQE
         5z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNhoxWWto3OTBxATPguCKxBnejir/6rqXXsL2C1SRpI=;
        b=OzohwrnyxBKjEjk5/+n7nS4gbGlEO9Ihwc3flNX1UD798poPQzxEbwGwhsyGmo3Zs0
         Xm45IBtaXPkVDKifTNTMd1eXn7wwy1PgEMYI/AHhA6dfnX2uaVj18aZxPfkEnSHua2OH
         Fhg/BB1kLlobRf9FpL7r01BarFUrWJy5eYIg14aCjPk1tE9bke1YZbuE0kHk3bjBi5nY
         Ot3SAS4McgULOAvUq2fMKFK7xyiEiPVWv+ny6pTTVARX54mvov6lHtWzlTutrp5Jj3qT
         GjC7kBtNp0o36/L3kCK4Bpjkzfg8xPVdArUNttP0JA+DpTsP1Wv6JfAOLk9JRi1/g/+x
         ztSg==
X-Gm-Message-State: ANhLgQ1yzsDfws2Fb8AhMOecLBqucVGZl6mqlTmi5GAUNXZLzq1czPNi
        CYMXwyEil/EQOOFLHaIRDP4=
X-Google-Smtp-Source: ADFU+vvU6pH/mf08SGHxjLsH3az/2PjNFKYB2VAjp4Y4Ded+iT//bzPvgndTJsKppFrqIOk+ROQyMw==
X-Received: by 2002:a0c:ed2d:: with SMTP id u13mr2106999qvq.203.1584497706026;
        Tue, 17 Mar 2020 19:15:06 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id x3sm3540710qts.17.2020.03.17.19.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 19:15:04 -0700 (PDT)
Date:   Tue, 17 Mar 2020 22:14:49 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] counter: 104-quad-8: Add lock guards - generic
 interface
Message-ID: <20200318020506.GA45571@icarus>
References: <20200316124929.GA389@syed.domain.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <20200316124929.GA389@syed.domain.name>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 06:19:30PM +0530, Syed Nayyar Waris wrote:
> Add lock protection from race conditions to 104-quad-8 counter driver
> generic interface code changes. Mutex calls used for protection.
>=20
> Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface
> support")
>=20
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> ---
> Changes in v5:
>  - Change spin lock calls to mutex lock calls
>  - Modify the title description.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5xhBkACgkQhvpINdm7
VJJAzw//buE31KKpnVswNZUMEJFGXFI0JLTQ8Zkp+cJtL3wlaA4OgPLq+6Ywm46v
s80WagAdGLA48a++Kzyy+fZyWlhV8btVi11MNtMeckV0nFFYuQmenJc/6IY3E4Uv
l/HuwJbcPkRBp187VkrBTyV5pcEAMMHi6qz+hMqhqqB6eQM6Ci8Cc9RHw8yuaDpr
jO2Tj92wVnofvx7WQ+wwIq+Mpzo3eE9JNRCCP9K+GMjBugBIPcEbLjZNKKTgkT0u
0A1+A8l/ssXkbaqqJJfS0GhhSNXMlfJG3m1RWZdi1vwRyBiOVBJWBzNc7pl7WGFt
ECc6BukRYBnyAGnsKdjtght/7vkyJbbGKp6jzUuE+EQNI4glfP1auxHMkloidWua
y6+aM46JY8doUlBrg2obO0Mf5w74HQJJPNesIGptwuZ8FnjOBjIHVY5jOWTChPrp
Cjcix9o1/rHA5Rf1Ry5S4hPR29rwpT7TJ5/H8n7ACQ03GlsajrcqWDWhg+57Ypu7
QAgft4MTU1WlyFD6i3Bg7kPNrJFSoruz/63bqdYvl6fHqDQWbqVSiCglJ90wl08G
aqGs0e9VpaG3egr1UNQYMIeiMe71aeWReDnPIZx4xKYdgQgzkguz2dGBaWRs3nzR
3plaO1eMWMRnON/cXM/ApN+aSoDm7R5wwUnBArFtDkn+i5S+dek=
=F2+4
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
