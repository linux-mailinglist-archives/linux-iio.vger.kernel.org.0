Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08119076D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 09:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgCXIUY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 04:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgCXIUY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Mar 2020 04:20:24 -0400
Received: from lore-desk-wlan (unknown [151.48.139.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C697207FF;
        Tue, 24 Mar 2020 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585038023;
        bh=QKvx2s6maWbHGLNWsypQpBBQ9isEnujedYm/qx4Y9xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yGJjn34ABq34NpHOMG7QZnyHeoRapz+0TbaP9wqgRXp/GXLyPA7/Z1A5Zywhc+r4j
         bMvXvcBDtvCjml3VHNdTxB84SJDBbPM2GmzYqGMsK+9DY6qOcawf2WFZAUa6zNRm+E
         a/xp4OhSRIX865ffMkEbg/5zXgMqaKb2mKgBy3ho=
Date:   Tue, 24 Mar 2020 09:20:17 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Use LIS3MDL with LSM6DSM sensor-hub
Message-ID: <20200324082017.GA1387749@lore-desk-wlan>
References: <f8489de0-c6a4-f786-b936-679eba6d6804@gmail.com>
 <20200314124324.GA144176@lore-desk-wlan>
 <217cb6b1-d3b3-bccf-b081-d4beb0888615@gmail.com>
 <20200319174039.GA1564882@lore-desk-wlan>
 <ef4aa50f-4aa6-cb87-06b6-913e2abbb23c@gmail.com>
 <20200319204937.GB1564882@lore-desk-wlan>
 <37e50d0e-0618-eeba-8cf9-7c1272097a62@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <37e50d0e-0618-eeba-8cf9-7c1272097a62@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2020-03-19 21:49, Lorenzo Bianconi wrote:
> > > On 2020-03-19 18:40, Lorenzo Bianconi wrote:
> > > > > On 2020-03-14 13:43, Lorenzo Bianconi wrote:
> > > > > > On Mar 11, Jimmy Assarsson wrote:
> > > > > > > Hi,
> > > > > > >=20
> >=20
> > [...]
> >=20
> > > > > > Hi Jimmy,
> > > > > >=20
> > > > > > in order to set the full scale on LIS3MDL you can try the follo=
wing patch (just
> > > > > > compiled, not tested)
> > > > > >=20
> > > > > > Regards,
> > > > > > Lorenzo
> > > > >=20
> > > > > Hi Lorenzo,
> > > > >=20
> > > > > Sorry for the late response and thanks for the patch!
> > > >=20
> > > > Hi Jimmy,
> > > >=20
> > > > ok, I will post the patch, thx for testing.
> > >=20
> > > Great, you can add
> > > Tested-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
> > >=20
> > > > > The patches seems to work.
> > > > > Are there any specific tests that we should carry out?
> > > > > Via the sysfs interface, we've tested reading raw values of each =
channel and
> > > > > configuring ODR and full scale.
> > > >=20
> > > > you can try to enable batching in the hw FIFO doing something like:
> > > >=20
> > > > $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_x_en
> > > > $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_y_en
> > > > $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_magn_z_en
> > > > $echo 1 > /sys/bus/iio/devices/<iio-magn>/scan_elements/in_timestam=
p_en
> > > >=20
> > > > $watermark=3D64
> > > > $echo $((2*watermark)) > /sys/bus/iio/devices/<iio-magn>/buffer/len=
gth
> > > > $echo $watermark > /sys/bus/iio/devices/<iio-magn>/buffer/watermark
> > > >=20
> > > > $generic_buffer -gn lsm6dsm_magn -c <# of samples>
> > >=20
> > > Ok. I don't got any scan_elements nor buffer directory, for any of th=
e devices.
> > > I guess it is not possible to use the FIFO without configuring any in=
terrupt?
> > > We got the following dts:
> > > &spi1 {
> > > 	#address-cells =3D <1>;
> > > 	#size-cells =3D <0>;
> > > 	lsm6dsm@0 {
> > > 		compatible =3D "st,lsm6dsm";
> > > 		reg =3D <0x0>;
> > >=20
> > > 		spi-max-frequency =3D <500000>;
> > > 		st,pullups =3D "true";
> >=20
> > yes, you need to provide the interrupt line doing something like (this =
is from
> > the dts on my rpi):
> >=20
> > 	lsm6dsm@0 {
> > 		...
> > 		interrupt-parent =3D <&gpio>;
> > 		interrupts =3D <21 0x4>;
> > 		...
> > 	};
> >=20
> > > 	};
> > > };
> > >=20
> > > I'll look into this tomorrow or in the beginning of next week, thanks=
 for the help.
>=20
> Now I've tested this. It looks fine, except for the very first sample:
> $ ./iio_generic_buffer -gn lsm6dsm_magn -c 1
> iio device number being used is 3
> trigger-less mode selected
> -3.250836 -2.796192 10.212408 1584976428879020199
> 1.893036 2.343738 -0.853224 1584976428917070199
> 1.888218 2.343300 -0.852786 1584976428955095199
> 1.888218 2.343300 -0.852786 1584976428993145199
> 1.889532 2.345490 -0.851472 1584976429031170199

values seems reasonable but I guess it depends on sensor calibration and ho=
w is
oriented. Do you have any app to test it?

Regards,
Lorenzo

>=20
> Is this expected?
>=20
> Regards,
> jimmy

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXnnCvgAKCRA6cBh0uS2t
rEwCAQCdR4Y+NU6Dki8VMAS4fVyvae53RP1shH/nYr+d+WvTcQEAvIzhi7Y9CApS
MfT4nwoZiI4kK+uxxbf1OAdoZG5seAw=
=UtB8
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
