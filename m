Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F7AE49F
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfIJH0w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Sep 2019 03:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfIJH0w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Sep 2019 03:26:52 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B40E20872;
        Tue, 10 Sep 2019 07:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568100412;
        bh=zcQ+/4Qjd7f5ox0FR881AFUaH1vfizRkSCzURee6OqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ev3dPfff/mm4TZXc1NhUzu8GBLYiSys2DmiGe32Q3Od9A6e4JgU1mVPCOFBC/2r/W
         lFeKgOncW7t3QViwTnhTbVRz4LOHicR3asNvhHSDz0yWORlLyum7wXz9P4ls8R8N0Y
         wtA7IhxZUUHMx/Lkmw72L+TSQS3naWMgEj9pGpks=
Date:   Tue, 10 Sep 2019 09:26:46 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190910072646.GB2712@localhost.localdomain>
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-5-sean@geanix.com>
 <20190909120546.GE2990@localhost.localdomain>
 <6e987a54-250c-c146-cff8-99fa33255f9b@geanix.com>
 <20190910071250.GA2712@localhost.localdomain>
 <58121fe6-067f-4515-3375-735ca7b41df6@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <58121fe6-067f-4515-3375-735ca7b41df6@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 10/09/2019 09.12, Lorenzo Bianconi wrote:
> > probably a silly question..are you tracing the interrupt line with an
> > oscilloscope or a logical analyser? If you dump interrupt counters in
> > /proc/interrupts will you see an interrupt storm for the selected irq
> > pin?
> >=20
>=20
> Not a silly question ;-)
>=20
> An Oscilloscope :-)

ack, thx

Could you please try to carry out the following test?
1- set the FIFO watermark to a high level (e.g. 128)
   $echo 256 > /sys/bus/iio/devices/iio:device{x}/buffer/length
   $echo 128 > /sys/bus/iio/devices/iio:device{x}/buffer/watermark
2- set a low acc odr (e.g 13Hz)
   $echo 13 > /sys/bus/iio/devices/iio:device{x}/sampling_frequency
3- start reading from the accel and generate a wake-upp event

Is still happen? Are you able to decode bus transaction? (register addresse=
s,
data read, ..)

> The interrupt counter is stopping.
> If I switch to IRQ_TYPE_LEVEL_HIGH, (to test if additional readings of the
> event and FIFO registers would help. It results in interrupt storm and the
> line continues to stay high.
>=20

@Denis, @Mario, @Armando: any thoughts about this?

Regards,
Lorenzo

> /Sean

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXdQMwAKCRA6cBh0uS2t
rO3vAQCcuXGUqj+PfLdrjjkC34bd9M4RYa7A3MJx3zqXqnsSRgD9FMi3vo5/rTPc
dtVnbegGj1kkCdeCT5EyXMnF43Msvg8=
=T4Rz
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
