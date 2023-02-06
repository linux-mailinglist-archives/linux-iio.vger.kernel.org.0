Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2681D68C045
	for <lists+linux-iio@lfdr.de>; Mon,  6 Feb 2023 15:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBFOiF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Feb 2023 09:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjBFOiF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2023 09:38:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7DD1A491
        for <linux-iio@vger.kernel.org>; Mon,  6 Feb 2023 06:38:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00C3560F0B
        for <linux-iio@vger.kernel.org>; Mon,  6 Feb 2023 14:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD8AC433D2;
        Mon,  6 Feb 2023 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675694283;
        bh=3eN6LHM49qbniARLLNLotRv7usFI65xgWIJGTgFw4Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RC07gaIr+n8ez+rKGQrWHU2lepyYnW7YInV41j2iXR2U3LX48QP0jJcRkhXrAQIPT
         penKnYzdRNSwfC/zHmLpNQHXWcYyHxNw8P6TF6waOFppVn+2XIyoFjy/hw3uibKkup
         KF8PknpOcKjjCR0DED9sL+ic5bLReQhPHwbWLMkw+MVKZjdY46C9ITR6QReYCRNRoo
         XYaI4trIqziVUgNCQa0Az82mAdyI2kTrvfKP3kdyBs5j5tP9MPxouDYmkBYDdY5ESL
         zvM5KUQ7pGFdOsI3qWHhC15+iOPEI5dCIUxxTsRb0HvoPw09p30x9XpovHgLFzo27U
         hBsxLR3F5nGSw==
Date:   Mon, 6 Feb 2023 15:37:59 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Philippe De Muyter <phdm@macq.eu>, linux-iio@vger.kernel.org
Subject: Re: st_lsm6dsx : first two values of ism330dlc_gyro are wrong
Message-ID: <Y+EQx+GC/2Icb2cJ@lore-desk>
References: <20230205101223.GA10729@frolo.macqel>
 <20230205141342.10dbc447@jic23-huawei>
 <Y+DPMBFHo9UxU+fK@lore-desk>
 <20230206143328.000056cc@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zkmdsE3eiHA2hYL"
Content-Disposition: inline
In-Reply-To: <20230206143328.000056cc@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--4zkmdsE3eiHA2hYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 6 Feb 2023 10:58:08 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Sun, 5 Feb 2023 11:12:23 +0100
> > > Philippe De Muyter <phdm@macq.eu> wrote:
> > >  =20
> > > > Hello Lorenzo and list,
> > > >=20
> > > > I use the imu/st_lsm6dsx (i2c) driver to drive a ism330dlc imu.
> > > >=20
> > > > Every time I start a new acquisition of gyro values, the first two
> > > > values read are wrong, as can be see here :
> > > >=20
> > > >  $ sudo ./iio_generic_buffer -n ism330dlc_gyro -g -c 10 -a
> > > >  iio device number being used is 1
> > > >  trigger-less mode selected
> > > >  No channels are enabled, enabling all channels
> > > >  Enabling: in_anglvel_z_en
> > > >  Enabling: in_timestamp_en
> > > >  Enabling: in_anglvel_y_en
> > > >  Enabling: in_anglvel_x_en
> > > >  -0.138924 -0.915246 0.470628 1675591514696125669
> > > >  -0.012699 -0.362151 0.143208 1675591514772675669
> > > >  0.001989 -0.076500 0.035190 1675591514849250669
> > > >  0.002295 -0.076194 0.035343 1675591514925825669
> > > >  0.002142 -0.076041 0.035343 1675591515002400669
> > > >  0.001989 -0.076041 0.035343 1675591515078975669
> > > >  0.001836 -0.076347 0.035649 1675591515155525669
> > > >  0.001836 -0.076500 0.035649 1675591515232075669
> > > >  0.001989 -0.076500 0.035649 1675591515308625669
> > > >  0.001989 -0.076347 0.035649 1675591515385200669
> > > >  Disabling: in_anglvel_z_en
> > > >  Disabling: in_timestamp_en
> > > >  Disabling: in_anglvel_y_en
> > > >  Disabling: in_anglvel_x_en
> > > >  $
> > > >=20
> > > > Is that a normal behaviour for a gyro in that family or is it be ca=
used
> > > > by a software or hardware bug ? =20
> > >=20
> > > So, some random thoughts on what might be going on...
> > > 1) Stale data in the fifo.  Could you run this experiment twice whils=
t being
> > >    careful not to move the device between the runs.  If we still see =
the wrong
> > >    values at the start then it's not that... =20
> >=20
> > When the device is powered-down we set the FIFO in bypass mode and in-f=
light
> > samples are discarded.
> >=20
> > >=20
> > > 2) Device takes a little whilst to stabilize. Possibly this is down t=
o the
> > >    low pass filters requiring a few samples before they deliver stabl=
e output.
> > >    From a quick glance I don't think we provide any userspace control=
 of those
> > >    filters and I think LPR1 is left in default state of disabled. =20
> >=20
> > I would say this issue is related to the "Accelerometer and gyroscope
> > turn-on/off time" (section 3.9 in the sensor application note).
> >=20
> > https://www.st.com/resource/en/application_note/an5125-ism330dlc-3d-acc=
elerometer-and-3d-gyroscope-with-digital-output-for-industrial-applications=
-stmicroelectronics.pdf
> >=20
> > @Jonathan: do you think we should discard these sample in the driver or=
 in the
> > user-space app? I would say this can be a general issue. What do you th=
ink?
>=20
> In driver.  This isn't an uncommon problem for sensors and userspace woul=
d in=20
> general have no idea how many samples to drop.  Also dependent on the sam=
pling
> rates etc so if we support control of those, we'll want to have the driver
> drop the right number of samples.  Though yikes at the top end. You can h=
ave
> to drop 540 samples... Ah well. That is at 6kHz sampling so still not ver=
y long.
>=20
> The only alternative would be to expose the current number to drop to use=
rspace
> but then existing userspace code would not drop them.  Hence I think it n=
eeds
> to be in driver.

ack, I will work on it.

Regards,
Lorenzo

>=20
> Jonathan
>=20
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > You could try messing with the sampling frequency as that may affect =
the number
> > > of bad samples you see and give us more of a clue (it affects lpf2 di=
rectly).
> > >=20
> > > Jonathan
> > >  =20
> > > >=20
> > > > Best regards
> > > >=20
> > > > Philippe
> > > >  =20
> > >  =20
> >=20
>=20

--4zkmdsE3eiHA2hYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+EQxwAKCRA6cBh0uS2t
rDGkAQCLRJso4EQoZvQOcK/1Q2jZzc81E6yMFLLYMXOVHl/5lwD+KsDC4fbcKs90
flU5idboY1H7THTiK6iSZ4MgqeR/NAc=
=gwuB
-----END PGP SIGNATURE-----

--4zkmdsE3eiHA2hYL--
