Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5979AFD42
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2019 14:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfIKM76 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Sep 2019 08:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfIKM76 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Sep 2019 08:59:58 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BD0206A1;
        Wed, 11 Sep 2019 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568206797;
        bh=2vD6C//Bj3jn3QlPhAE0CxbI+jGv4+38gw97L9WpEME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKLCBezpPsJEU4jXBoSlbmipX3v/8gZlQntm1jhvPMwS/y0v6/U3bc1qJDeli4CW/
         0zrBflfyRCtkUHV4eycn03ZJTcvtovbfEjpC0wwdCPLPVYRgamc/lJVVc6z9LSuHcc
         KyervXJJGWNVIrRrTHYNt+m2dT9GgY3RSIqANcr0=
Date:   Wed, 11 Sep 2019 14:59:51 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190911125951.GA4291@localhost.localdomain>
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-5-sean@geanix.com>
 <20190909120546.GE2990@localhost.localdomain>
 <6e987a54-250c-c146-cff8-99fa33255f9b@geanix.com>
 <20190910071250.GA2712@localhost.localdomain>
 <58121fe6-067f-4515-3375-735ca7b41df6@geanix.com>
 <20190910072646.GB2712@localhost.localdomain>
 <20190910122740.GC2712@localhost.localdomain>
 <632ea600-509e-ad83-4752-6e6fc3000345@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <632ea600-509e-ad83-4752-6e6fc3000345@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 11, Sean Nyekjaer wrote:
>=20
> On 10/09/2019 14.27, Lorenzo Bianconi wrote:
> > > Could you please try to carry out the following test?
> > > 1- set the FIFO watermark to a high level (e.g. 128)
> > >     $echo 256 > /sys/bus/iio/devices/iio:device{x}/buffer/length
> > >     $echo 128 > /sys/bus/iio/devices/iio:device{x}/buffer/watermark
> > > 2- set a low acc odr (e.g 13Hz)
> > >     $echo 13 > /sys/bus/iio/devices/iio:device{x}/sampling_frequency
> > > 3- start reading from the accel and generate a wake-upp event
> > >=20
> > > Is still happen? Are you able to decode bus transaction? (register ad=
dresses,
> > > data read, ..)
> > >=20
>=20
> Do you still want this tested?

no, not necessary

>=20
> [...]
>=20
> > Could you please try to enable the LIR (Latched interrupt - BIT(0) in 0=
x58)?
> > Please remember that on ISM330DLC the interrupt will be automatically c=
leared
> > reading the wake up src register after a time slice equals to 1/ODR so =
the it
> > will be set for longer time if you run the device at low ODR
>=20
>=20
> "iio: imu: st_lsm6dsx: enable LIR for sensor events"
> "iio: imu: st_lsm6dsx: enable clear on read for latched interrupts"
> Does allow us to get events and buffered reads simultaneously.
>=20

cool :)

Regards,
Lorenzo

> I will drop PATCH 6/6.
>=20
> /Sean

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXjvxAAKCRA6cBh0uS2t
rObTAQCrCJgXGPUa7MKWjcaJRoWrtUQQ1cnS8tLYZssS4v8o/AD/akSr0oGPfKHu
mi3ye7icjZuUVeCCsaAmJbzRELfoZAI=
=XKU0
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
