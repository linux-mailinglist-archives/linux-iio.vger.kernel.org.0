Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E2321B631
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jul 2020 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGJNU4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jul 2020 09:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgGJNU4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 10 Jul 2020 09:20:56 -0400
Received: from localhost (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB2520748;
        Fri, 10 Jul 2020 13:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594387255;
        bh=q4XM3vwHzuI5ObRfnkt6S9rYS4OwrGQt42p/jVuuEuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFYUgUJmQpAHMXww3lroTo8qZY/vDzN+2sJj//ZOqKeRYRiZvnnquU1vOckPaFq4N
         TXWfTVag07MGf62l+7UsheSYgAEIi0Z6VhBptr2MgNQBtsbFSJ4VkfES2w1eiDvTum
         Zdb5DzXvjY3rvhpKm6y93h47YD750E8hbVcFnLBI=
Date:   Fri, 10 Jul 2020 15:20:50 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
Message-ID: <20200710132050.GA6694@localhost.localdomain>
References: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
 <20200528210711.GD5419@localhost.localdomain>
 <c4272c37-edf3-edf6-f826-87ab86f40f62@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <c4272c37-edf3-edf6-f826-87ab86f40f62@geanix.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> >   }
> Hi Lorenzo,
>=20
> Will you sent this as a real patch?

Hi Sean,

sure, I will post it so you can test it.

Regards,
Lorenzo

>=20
> /Sean

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXwhrLwAKCRA6cBh0uS2t
rM3mAQCi7EVuAiZ7Te2On91/TGI2cNVNgYM/TlcBXb15nW921wD/VGuaNRTlqPNm
jr5Ok/+8x+1x49BQbZcarnK2nqVHjA8=
=qcA+
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
