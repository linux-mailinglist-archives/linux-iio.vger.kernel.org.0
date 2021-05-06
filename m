Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8033750AB
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 10:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhEFIXT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 04:23:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231929AbhEFIXQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 May 2021 04:23:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FEEF61157;
        Thu,  6 May 2021 08:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620289339;
        bh=2aNSA4/e/m7w3Vo3+GBiUiVbabK3hDsdf8MVH9V984g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5RukAgEcm+70DbqB4Sn4LU7f1FwYL/elMB/qsasYJTgOA2/MupyQOazqjQ/OL35S
         ihv5HN073+Y7rVQRrIgVZwzResbzGt9kE38tFCUKyKfY1GqM+sefx2+fx3AivTBlkI
         oC/TP8FVhoaNni/0BJCPcloTVsboIGGv61F5hXXgTH1uJMZA8batHuZ8d7lUCFD3Gz
         AqrILyiFNAYDZo+mxm3tFisbsozy/ri8McZRwbwPg0cnimXt+qeCqT1f6pRnmuMQ37
         LAYS1XnCSM22HeNRV2guA+MlQzVZ2xP8gqd85JsuISw0zrc5hMKo7sn+8jzosAqR5U
         Dq6GDuLRcY6Rw==
Date:   Thu, 6 May 2021 10:22:13 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: iio: imu: st_lsm6dsx: sample rate?
Message-ID: <YJOnNb4+3OFnLLC1@lore-desk>
References: <1b645b15-f866-ee45-1b92-8dd32340409a@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M+kUiB5Rx8ZmsLWz"
Content-Disposition: inline
In-Reply-To: <1b645b15-f866-ee45-1b92-8dd32340409a@geanix.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--M+kUiB5Rx8ZmsLWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> Any specific reason to why the 12.5Hz sample rate is implemented as 13Hz ?
>=20

Hi Sean,

what is the device you are referring to? I guess now all devices support
12.5Hz.

Regards,
Lorenzo

> Br,
> /Sean=20

--M+kUiB5Rx8ZmsLWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYJOnMwAKCRA6cBh0uS2t
rOreAQDr2ykf4DfQIUQad6EyaUUkkqJTUWUPj4UyYQnjf8pPEwD/cu3b8pKJ+K/Z
5Pi9Pngd3p5Fri/PYgZba6TrHXdhKg8=
=K5AD
-----END PGP SIGNATURE-----

--M+kUiB5Rx8ZmsLWz--
