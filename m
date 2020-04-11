Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED7681A5318
	for <lists+linux-iio@lfdr.de>; Sat, 11 Apr 2020 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgDKRXE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Apr 2020 13:23:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45135 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgDKRXE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Apr 2020 13:23:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id m67so5313674qke.12;
        Sat, 11 Apr 2020 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Ayr3d044SiKn+0TAPDMyKPpqh+ya5/Ml+HLoEx/aHI=;
        b=SF2b+rsNf7n3Y7ncNeM6Z+GZ8p5q0su6HbWASI6ylQzlFJ16Fw0DWrYblTsVxm0Ovw
         4SbeqaYcxqh7f8UzLa4TmKrwDDS4qzOZhvn66II0fnz+wi8Z7RLi0O1qg6I4bd0YIVi2
         Wy3FCamlP2ed+At7XvF9OusgQ9/LOqS4OTuOq2Vy8bdHl4c8mCO261jfGSecr6BMcwwt
         jPg9TxjK4qdrVRIAgMY2ZPxQ+2HvXQbWdPHA1EWEm2/rQO/dhJUckXma+EsT4HEdmgLR
         ljFwBeSp55zmBQPAfdjy60D4/ZU6nyWHqKyzpxOGDHr/r2fhrVeqdC4j9WkOABG/uc5c
         6LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Ayr3d044SiKn+0TAPDMyKPpqh+ya5/Ml+HLoEx/aHI=;
        b=bATjYKSOL9rnNa/OK3F1fQYmfdeY9ljMBiZGM9Ejd3Vhthnq2l5uiiYeT4V2BkZlO6
         doDdi0pquJWjReUwvd3iKnaCLQJxGnHBzCuofoB70bxWug2FsCec86KrsnWuVsjhTsUe
         gugt9GjCKQzbWi01P08RHVuGKMrOhBDyleMAvCgJLHSV1LdscTXqUIXD/Zz6QGjJJwas
         QhxaIxygER14ujdIKrlC55zSKJDsW4LuKESu6zq8t3B+9gBTfg6n4bTaK4gEw4hNVbkn
         LenVE87r7PU0SIgCqnJ+ItqwmT0N0F4M0TStiDsQY+RkmfWK481w1whG7bv2U07P1Ca+
         0lCw==
X-Gm-Message-State: AGi0PuZphHwS7GB3RaFl5Ydax/79tY2xpsLXLUR5euur4wLC1OspSV97
        6s+3pIhpTE5bf/zRuID/KFE=
X-Google-Smtp-Source: APiQypLRbj9x/M6LU2b+6Naa9xWB3R34biG+yS19O+uI116m27K8PWcX4EoCx+U0X25dFZgIABeD6g==
X-Received: by 2002:a37:9b4a:: with SMTP id d71mr9111643qke.382.1586625783226;
        Sat, 11 Apr 2020 10:23:03 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u27sm4152409qtc.73.2020.04.11.10.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 10:23:02 -0700 (PDT)
Date:   Sat, 11 Apr 2020 13:22:59 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce a counter inkernel API
Message-ID: <20200411172259.GB95806@icarus>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 05:58:03PM +0200, Kamel Bouhara wrote:
> Hello everyone,
>=20
> This series introduce a basic inkernel API for the counter subsystem and
> add a new rotary encoder driver that use a counter interface instead of
> the GPIO existing one.
>=20
> See commit log in 0001-counter-add-an-inkernel-API.patch for further
> details.
>=20
> Kamel Bouhara (3):
>   counter: add an inkernel API
>   Input: rotary-encoder-counter: add DT bindings
>   Input: add a rotary encoders based on counter devices
>=20
>  .../input/rotary-encoder-counter.yaml         |  67 ++++++
>  drivers/counter/counter.c                     | 213 ++++++++++++++++++
>  drivers/input/misc/Kconfig                    |   9 +
>  drivers/input/misc/Makefile                   |   1 +
>  drivers/input/misc/rotary_encoder_counter.c   | 152 +++++++++++++
>  include/linux/counter.h                       |  27 +++
>  6 files changed, 469 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/rotary-encode=
r-counter.yaml
>  create mode 100644 drivers/input/misc/rotary_encoder_counter.c
>=20
> --
> 2.25.0

Hello Kamel,

I'm not inherently opposed to adding an in-kernel API for the Counter
subsystem, but I'm not sure yet if it's necessary for this particular
situation.

Is the purpose of this driver to allow users to poll on the rotary
encoder position value? If so, perhaps instead of an in-kernel API, the
polling functionality should be added as part of the Counter subsystem;
I can see this being a useful feature for many counter devices, and
it'll keep the code contained to a single subsystem.

By the way, I'm going to be submitting a major update to the Counter
subsystem code in the next couple weeks that isolates the sysfs code
=66rom the rest of the subsystem -- it'll likely affect the interface and
code here -- so I'll probably wait to decide for certain until that
patch lands; I anticipate it making things easier for you here after
it's merged.

For now, I want to get a better high-level understanding about how users
would interact with this driver to use the device (input_setup_polling
is a new call for me). That should help me understand whether an
in-kernel API is the best choice here.

William Breathitt Gray

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6R/OYACgkQhvpINdm7
VJJULA//cJf3iV5J+NsneoTVZ26SG+cQdVz4UFAUmrQ7lKokM+KB49/vO6JjzUXa
kXebfHwgqvjcnCwiyEmHqvkVR5QDH1Qo9uryOrBzY2Uz/HGmUI7DB8OZXTa0J6Vf
Udy0T/jiwC7iTy2IGKt0svVAauesGdFA052BHCt+1fbarvKjr+ZBwDLQjPEy7rOU
NYcpVoOH4bPtQbgvDLGp01dmw1nvzSmjxrCHF0ARy8funxA7Bng69jQcGWiaWRjm
PAyqb8CBIfQ4clIrEwGh5Hhj/oYUFMIf8pB0fFM5mZ39ISqwKF9nedQZ6hYmvgXH
xNRDOWP63UksmBVXp1vtZjiHUdrH07sF+cRRgrwQkn3bkJfR8sQAA2oRDCBieMA3
hRBWjmw31IGzmI0HtzYjsFLvFUuK1Yoe7F+EGdvdrVmRQmtom3pzZ8AcDdpB6h8R
Hr/v9jKXPc54UKOe66rKhMe7aTx4H/7nG3kxnZSzNKWFhwV+dCjy8D1X9HxEKoZp
WRAfsClBsNGzJBqVSO3ryFrIzRuJuYLtGNbKhBbTJvc0nRpJAuJbSnw0ZRf9kGZg
KJ0nNPdweo26YbxYkT2hyNJantJCYc9GmyLy+FubdgF3skX47nnIusRtpoBYe/hd
AZ/ERtySq9+Tv+dQzk8xrWxAYGdoIVCdub93jaSnWAYoyKZJs7g=
=Rx8J
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
