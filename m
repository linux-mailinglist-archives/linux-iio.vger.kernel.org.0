Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B222323FF9A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHIRvv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgHIRvu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Aug 2020 13:51:50 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C15C061787;
        Sun,  9 Aug 2020 10:51:49 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t6so3212183qvw.1;
        Sun, 09 Aug 2020 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n0x8YNxsCm7bGHeqbF8zvvR+sEvGuDkwyk/DAgXQhHw=;
        b=S3Iu1VC36rllT2s/b3IGvShcgQCYwpTombmTvT1JjcO53Se++BrGPfwLnk2xaZHEF9
         DxK+kzM6G3uurL1qyVeBfPOcgCIGYORyMsExe0q8yvod6CSnZ/71K9Rvupf2a/KmqMhF
         RRzFBT0+FCutZXj9u5OeN1fYhxoAm56KD7n5MZssC1kSSMWq4mEMrrOIkQp1dxZ3PJIB
         OpMB8TtMAHOXKlBcb/zL6xNtjRLq6Ic+zjKgLYayJCfHHdtF6CNam+3owtyNvqVH1k30
         GRG6Tz5HILGt1L8kx1TSRiBn9/5ZHwXpiSXbLJkvTOobQBq7R0qvY6mmyc/2VSBQ1XUS
         f7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n0x8YNxsCm7bGHeqbF8zvvR+sEvGuDkwyk/DAgXQhHw=;
        b=djB7P8av9Jn0gy7g65hHfVIdNQoDErizoEQIpLk5YWMLZGaYHoTb6rkPqAlhqeV5Sm
         TgUfKzzn5hAI3rp6WUchU7Dk6oHMIzT8Y9jtpXra0H5FD83T/noO4aRfwba80GUz16D4
         0yb5Am0rtND5s0siYw8G5sCwM0bexN8kb35wDJdBL9KrvI2gflE/s9bi0DSK7S+DGSQ4
         KLI7VnkgyvYN4jCpDtenI8SmHRwgY46PdOlnsJKaYjgfS3hoxojRqIhY5Q2sbyy7D8JF
         GbJtKUPv/EEYxdMxFfIKsmOXwInmH0DYQhX3aVfnKx8H4qhK9jHwgjriKsjHGf4C3F9X
         h16A==
X-Gm-Message-State: AOAM533lo1/ASwI0nShjbzE3Z8d/G0OgMm6hE1ZTluXqYZVLFPcgCFXC
        hpMfZtneiKeHLgq9pUbynj4=
X-Google-Smtp-Source: ABdhPJz12sgXjE+X2nALn9osOEpYrHt9vHeEldiICmpuV68vmmG56WGukiYmWeKacikankoCPBRBtw==
X-Received: by 2002:a0c:d64b:: with SMTP id e11mr18066172qvj.169.1596995508936;
        Sun, 09 Aug 2020 10:51:48 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id i18sm13211332qtv.39.2020.08.09.10.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 10:51:48 -0700 (PDT)
Date:   Sun, 9 Aug 2020 13:51:45 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v4 0/5] Introduce the Counter character device interface
Message-ID: <20200809175145.GB6542@shinobu>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
 <20200809144800.6b067dea@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20200809144800.6b067dea@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 09, 2020 at 02:48:00PM +0100, Jonathan Cameron wrote:
> On Tue, 21 Jul 2020 15:35:46 -0400
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > The following are some questions I have about this patchset:
> >=20
> > 1. Should I support multiple file descriptors for the character device
> >    in this introduction patchset?
> >=20
> >    I intend to add support for multiple file descriptors to the Counter
> >    character device, but I restricted this patchset to a single file
> >    descriptor to simplify the code logic for the sake of review. If
> >    there is enough interest, I can add support for multiple file
> >    descriptors in the next revision; I anticipate that this should be
> >    simple to implement through the allocation of a kfifo for each file
> >    descriptor during the open callback.
>=20
> What is the use case?  I can conjecture one easily enough, but I'm not
> sure how real it actually is.  We've been around this question a few
> times in IIO :)
>=20
> Certainly makes sense to design an interface that would allow you to
> add this support later if needed though.

I don't have any particular use case in mind, but I figured it would be
useful. For example, a counter device can have multiple channels with
their own events, but any particular channel might be counting the
signals of an independent device unrelated to the other channels; in
this scenario, two independent user applications might need access to
the same counter device.

Of course, supporting multiple file descriptors is something that can be
added later so perhaps it's best for us to wait until the need arises
with a real-life use case.

> >=20
> > 2. Should struct counter_event have a union for different value types,
> >    or just a value u8 array?
> >=20
> >    Currently I expose the event data value via a union containing the
> >    various possible Counter data types (value_u8 and value_u64). It is
> >    up to the user to select the right union member for the data they
> >    received. Would it make sense to return this data in a u8 array
> >    instead, with the expectation that the user will cast to the
> >    necessary data type?
>=20
> Be careful on alignment if you do that. We would need to ensure that the
> buffer is suitable aligned for a cast to work as expected.

That's a fair point. It's probably safer to continue with a union which
also has the benefit of making the possible returned types clearer to
see in the code.

> >=20
> > 3. How should errors be returned for Counter data reads performed by
> >    Counter events?
> >=20
> >    Counter events are configured with a list of Counter data read
> >    operations to perform for the user. Any one of those data reads can
> >    return an error code, but not necessarily all of them. Currently, the
> >    code exits early when an error code is returned. Should the code
> >    instead continue on, saving the error code to the struct
> >    counter_event for userspace to handle?
>=20
> I'd argue that errors are expected to be rare, so it isn't a problem
> to just fault out hard on the first one.

All right, that should help keep the error logic simple too then.

William Breathitt Gray

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8wN6YACgkQhvpINdm7
VJJS2A//eaJ/jtLitKdyaRHiFbB4//bIf3sPQQxG2eJSu3eztaFphLlkMxdDijrY
OiBq5wsBkHYvcpy/z2A+XqY/PFzCpMrr/tAyuxiEeKB95WjzTUZl59CbUDOqqtwz
8wx1DcymzHfvwun1AQDfXPyMXD/Np0zdQTaY2vmjyllC5otFSfW2VfFh/RIzxQ2A
FCtP9ogxam3Pl1GZ20e76C8f+tH8M25xP9Aj3h8R7XV2NiR6xE/WuhOlsmfAHyue
cvYBfyS8YnTvZaDu1L88kqgEoXqJXqTXKTfxRYLRgEQD0DN/i7IndPgApUoya93O
kBiGMexlfBeGOMaMgs29ZoFUflyg6ZjxcgrlCGt7jGHP8cmTex6TDw3f/BSGloPq
ED5rh5rPnYzWy0mqenPgZU2V6VCZeApcGwhakCpSYFVdM4Lp4yiktdFTpzC9LkXY
jeQvOXAespYNJH1llge4DfLwctqclMZVJg0flDDCUCQA75sy6vrPE73Nb+T3XChu
TEu+P8gRFJbxi9Rg/l/7p+P30s4e2a1YKJfWdYStcHSougEHJq+9x8zUaejWAMwo
YB8+NaDRnhUi6DVgTLwrib6uvwOyGj94P2qn8Y1RhkqUzQh0vSlG0z/gyss298H8
WCSZNFOLbS9pTLd77PpNxf7HkBCkg+/M14ZmjimDQMZwRMP0yGA=
=+ft6
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
