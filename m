Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26285AEA56
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 14:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfIJM1r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Sep 2019 08:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbfIJM1r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Sep 2019 08:27:47 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1DC520872;
        Tue, 10 Sep 2019 12:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568118466;
        bh=kVECXgqXuOUdTN+AbJc+ulBVlUTUV5LcLoUN5tn05oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xNEyvdkngzfZG4Scpm8HWF2patdUuf5NLJfJoRkQ2LJt9BRbMIfbpKqW/pW2hq42O
         20AK4anHabXgQq2I2I6EzMrTzUcxMQpNdWCXtovDBluf2j28XqZ32A/Lo6Y4l5HLjx
         yoaBEI1imNP94c1PJ1lSo5GZLY4f/IQSmhl6av/4=
Date:   Tue, 10 Sep 2019 14:27:40 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190910122740.GC2712@localhost.localdomain>
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-5-sean@geanix.com>
 <20190909120546.GE2990@localhost.localdomain>
 <6e987a54-250c-c146-cff8-99fa33255f9b@geanix.com>
 <20190910071250.GA2712@localhost.localdomain>
 <58121fe6-067f-4515-3375-735ca7b41df6@geanix.com>
 <20190910072646.GB2712@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <20190910072646.GB2712@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > probably a silly question..are you tracing the interrupt line with an
> > > oscilloscope or a logical analyser? If you dump interrupt counters in
> > > /proc/interrupts will you see an interrupt storm for the selected irq
> > > pin?
> > >=20
> >=20
> > Not a silly question ;-)
> >=20
> > An Oscilloscope :-)
>=20
> ack, thx
>=20
> Could you please try to carry out the following test?
> 1- set the FIFO watermark to a high level (e.g. 128)
>    $echo 256 > /sys/bus/iio/devices/iio:device{x}/buffer/length
>    $echo 128 > /sys/bus/iio/devices/iio:device{x}/buffer/watermark
> 2- set a low acc odr (e.g 13Hz)
>    $echo 13 > /sys/bus/iio/devices/iio:device{x}/sampling_frequency
> 3- start reading from the accel and generate a wake-upp event
>=20
> Is still happen? Are you able to decode bus transaction? (register addres=
ses,
> data read, ..)
>=20
> > The interrupt counter is stopping.
> > If I switch to IRQ_TYPE_LEVEL_HIGH, (to test if additional readings of =
the
> > event and FIFO registers would help. It results in interrupt storm and =
the
> > line continues to stay high.
> >=20

Could you please try to enable the LIR (Latched interrupt - BIT(0) in 0x58)?
Please remember that on ISM330DLC the interrupt will be automatically clear=
ed
reading the wake up src register after a time slice equals to 1/ODR so the =
it
will be set for longer time if you run the device at low ODR

Regards,
Lorenzo

>=20
> @Denis, @Mario, @Armando: any thoughts about this?
>=20
> Regards,
> Lorenzo
>=20
> > /Sean



--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXeWugAKCRA6cBh0uS2t
rLKdAQCI8qZS4QRo01OlFSVlmm+jhBEj2OR2lNyZnrh0sK6QDwEAvxotz41rT5Ds
7f+TABtVsFGqd+tl9z1Gz6hy1u2KxQY=
=S7w0
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
