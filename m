Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C610D320
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 10:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfK2JUD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 04:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2JUD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Nov 2019 04:20:03 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA842176D;
        Fri, 29 Nov 2019 09:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575019203;
        bh=sOEIy/4fHu1rOhGEvkd2QH37t9d1Lo+vUtyO1Pmj/2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2S9ovy50ItCt7RY3XzGjCLm3z8B3W29bQwPA0NWa/Q/HvRkpQNxdhNE49y6IuMa1T
         tqIuow2vkEaiZ6rWDdu0mdHAAA9C7z/F1NRMa87KCDpmyzQR3Y2lohK+yhI7kXJqwU
         cv4bOixVlcCKydHVIG3RWtzGvs22fAIWTjEop/18=
Date:   Fri, 29 Nov 2019 11:19:54 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     jic23@kernel.org, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org
Subject: Re: [RFC/RFT] iio: imu: st_lsm6dsx: do not power-off accel if events
 are enabled
Message-ID: <20191129091954.GA32696@localhost.localdomain>
References: <e9782c23425f455da34c5d171013167551beeb37.1574968509.git.lorenzo@kernel.org>
 <f3a503f1-2371-1e14-027e-a6465b2d243e@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <f3a503f1-2371-1e14-027e-a6465b2d243e@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 28/11/2019 20.18, Lorenzo Bianconi wrote:
> > Do not power-off accel unconditionally if wake-up events are enabled
> > powering off the hw FIFO. At the same time do not power-off the accel
> > sensor if it is 'batched' in the hw FIFO disabling sensor events
> >=20
> > Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Tested-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > This patch is based on https://patchwork.kernel.org/patch/11266301/
> > @Sean: could you please run some tests in your environment?
>=20
> Hi,
>=20
> Works as expected in our environment. :)
>=20
> /Sean

Ack, thx for testing. I will repost adding your tested-by.

Regards,
Lorenzo

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXeDiuAAKCRA6cBh0uS2t
rJZSAQCxBEbKuHeyCljZ/NADsfJlUFdYYs48l+L+gVnm5yltcgEAgEzvUqi3Aid/
nMVtxGU++5bhx6deeUFS/CrpJHpLYg8=
=J5d6
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
