Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9651EBF49
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFBPqm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 11:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBPqm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 11:46:42 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F212EC08C5C0;
        Tue,  2 Jun 2020 08:46:41 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id g7so1964391qvx.11;
        Tue, 02 Jun 2020 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qzSEuCpyscmKEcqXp1a7EbLdA2hmWwk/OzqJUNtkEjE=;
        b=fYWMOkvOHbZel3XZmvxrN5Glw2gpYA1wRb8wfd7mkJlG3OO0PQYyYtwAdyUDVHSWRX
         GuvfsCuJyJ80lxs3We0lAJYHzMLQ4PyU8imyQvB53L2EYY9r72CEyoFZ2WTo0HwkmzDd
         787UFM7zLfmhgQYYEu0CXW6prlVh0RrDsh9Dos4pF8AoypQb7dBUjIfNRrOj6fJZDtOL
         nwQfGSlGsl9YIO7RDBK8kVLGIGXNurmcRQImUI2D7DNYeTwfZKRzPpXkxI168UwrGddt
         j+Qybk/9l7xHzO8zYtMuZLrrdGgWKxiE7cm66AKK8FHw3hWPVmyNJqa1GQDOKpyzIGwo
         5pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qzSEuCpyscmKEcqXp1a7EbLdA2hmWwk/OzqJUNtkEjE=;
        b=ryyNYb7XhSgsTARgyLLXHJY3oyn4/15/ZeUMpCGPQWi0+LBqpRLJTE68rZBMPCSPO8
         I4mwnzdRk2fErmTaVt6+dUFR2UolndEzB1IjWBQl0elKY+4gMDnnzOMLjU9RnvGdIBEH
         Nwo4sf8FRwIHaMg5jgxfMIUMFvWB5BnTqfzD9o5LOOB5qDYeAa4bXqioWh1yMeEICU48
         eiLjuOe8PVZglpj1Ha3g127nifte1VfQPCNbpj/s+8afZQmV2XK+7JB1viVxpUVKCDXk
         z7lHhtM12Hhdppdau3RbmlT1qpQzM9ovnirk7RU3wYrQ7wLOgb9pvGAlZ3bqBAlPL7gu
         DMQw==
X-Gm-Message-State: AOAM530YWENL138LIFZ2WwLp+ZM4VUfwo6dZ5qGHULz4mTRt8ANAdqZJ
        TktCOUGfn5Bku4xXyErlP+yfKEptursXeg==
X-Google-Smtp-Source: ABdhPJw7LGOlr2xz60gu8um0AANDyr0R16BDgMgY1Hm2PlzxLQfK3UQtshToBzP2YwPv56kOjyJaSA==
X-Received: by 2002:ad4:4b25:: with SMTP id s5mr11431931qvw.212.1591112801117;
        Tue, 02 Jun 2020 08:46:41 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id w94sm2899533qte.19.2020.06.02.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 08:46:40 -0700 (PDT)
Date:   Tue, 2 Jun 2020 11:46:26 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v2 0/4] Introduce the Counter character device interface
Message-ID: <20200602154626.GA5082@shinobu>
References: <cover.1589654470.git.vilhelm.gray@gmail.com>
 <20200524172542.31ff6ac7@archlinux>
 <20200524175439.GA14300@shinobu>
 <20200531161813.658ffdfb@archlinux>
 <20200531171351.GA10597@shinobu>
 <ac473c9a-f9cd-21ae-8f8f-d5181df2c134@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <ac473c9a-f9cd-21ae-8f8f-d5181df2c134@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 10:18:07AM -0500, David Lechner wrote:
> On 5/31/20 12:14 PM, William Breathitt Gray wrote:
> > Yielding the following /dev/counter0 memory layout:
> >=20
> > +------------+-----------------+------------+-------------------+
> > | Byte 0     | Byte 1 - Byte 8 | Byte 9     | Byte 10 - Byte 17 |
> > +------------+-----------------+------------+-------------------+
> > | Boundary 0 | Count 0         | Boundary 1 | Count 1           |
> > +------------+-----------------+------------+-------------------+
>=20
> A potential pitfall with this sort of packing is that some platforms
> do not support unaligned access, so data would have to be "unpacked"
> before it could be used.

Since the user defines the format of this data, they could reorganize it
to a more streamline alignment; for example:

# echo "C0 C1 C0E0 C1E0" > counter0/chrdev_format

Yielding the following /dev/counter0 memory layout instead:

+-----------------+------------------+------------+------------+
| Byte 0 - Byte 7 | Byte 8 - Byte 15 | Byte 16    | Byte 17    |
+-----------------+------------------+------------+------------+
| Count 0         | Count 1          | Boundary 0 | Boundary 1 |
+-----------------+------------------+------------+------------+

In the future, we could also define a padding argument to give users
more control over the exact offsets:

# echo "C0E0 P7 C0 C1E0 P7 C1" > counter0/chrdev_format

Yielding the following /dev/counter0 memory layout instead:

+------------+-----------------+------------------+------------+
| Byte 0     | Byte 1 - Byte 7 | Byte 8 - Byte 15 | Byte 16    |
+------------+-----------------+------------------+------------+
| Boundary 0 | Padding         | Count 0          | Boundary 1 |
+------------+-----------------+------------------+------------+
+-------------------+-------------------+
| Byte 17 - Byte 23 | Byte 24 - Byte 31 |
+-------------------+-------------------+
| Padding           | Count 1           |
+-------------------+-------------------+

I not sure it's best to introduce padding support with this patchset
given how much is already changing, but I don't anticipate packing
alignment to be something difficult to support in the future with this
interface.

William Breathitt Gray

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl7WdDsACgkQhvpINdm7
VJLCEhAArR5Z9rXla2JfgRiAGmqDThaapfbMiWbFcBbq6mdhn4a4+7+xcqkJIC+L
kBzFsq8MLeKihP8osMCt2Oct25/39Ica1qQEa0CsrzQ8xA2hM1+6oKBeOICpbd9r
HbPi2UlQajM63wey38/tJM3Nqwtz1ADdyNjXSHDXsUQTsx9GaB2pYD9qE1CkTGbU
9KDLIF7lX6olggVMKe9eyZY5MfsyeNVlGaMG/xZtaCehGCFDk9011mF5zVHrV9ya
79X5Gqm19BXFvnoEh2qbFkOMxUirIGEDZszdZtwMHKofYziL4QLAoSfEHrS/8GCL
8/SMpjuPi9WIMRA70htNgdsKEKsykx8d6rV8eASLIVqX8OrF4lfpTg7caWLWfVSM
2eRxRoyWICYfUPO5SMKKQoj+sBZxaM0GtgJecbt5Z5glRbYxODzkBHufffioIBU8
eNyA7mgtYi3ElWeQL2sxOV2UNHDwLzrouB2TBOM2ycNY7Mfo37tqt2MO7YdoGMi3
deUo9zeAgxbLyIx8YlDeQ1CdrSzAPpl3pPmkZG8zGf553Dyyww8AE+b87fyMcMkC
gAx+JnFU4ujy9DRE9mlcavropCZt4BLCtOs7EW7JqqUDXxoCcSnKugOmbWwEA18q
gcEbKztvUIOAelXICTgen8AqPt0nvI9R0/cF876yspBg/sw5e/I=
=Uj3v
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
