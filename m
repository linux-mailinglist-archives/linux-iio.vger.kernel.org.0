Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34B468BCE1
	for <lists+linux-iio@lfdr.de>; Mon,  6 Feb 2023 13:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBFMdi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Feb 2023 07:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBFMdi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2023 07:33:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C2D1F902
        for <linux-iio@vger.kernel.org>; Mon,  6 Feb 2023 04:33:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF9060EC5
        for <linux-iio@vger.kernel.org>; Mon,  6 Feb 2023 12:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A05C433EF;
        Mon,  6 Feb 2023 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675686815;
        bh=Spqv92wIsl6CjBIOcDmAGb1/zbMC2RRliapwtLVcY1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fOVVJ7613zQP5TFvumxyI6nkFApZlJFcKh7dq28pTS2nkOuzWlIOK2G5uyO0/p+TA
         sgptx+orUJzLbFKqSVTnx1RoMn/Roid0WklEbGkisf4atIQ5BcEIbuQh+FA1kQQsY8
         FByPWdCohDcogrO6xa69olpJpMxSkmv7v9XVjDlqYcK8+EwPwo84SbxGTDueMhKdql
         n37jyPhKDxxOEk0nL3buKpLJDBzS4lDAnfr+76PKku/07JQr5Mh8Hmp7AiW52jXjgW
         pY7E9UZct3FDzUZ/WqCLBWx8+ho9RH1d7sv2A8Qt++Kc4/NPeEI5YSCPgUBKEgmrji
         8V58EDcHDEvZg==
Date:   Mon, 6 Feb 2023 10:58:08 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Philippe De Muyter <phdm@macq.eu>, linux-iio@vger.kernel.org
Subject: Re: st_lsm6dsx : first two values of ism330dlc_gyro are wrong
Message-ID: <Y+DPMBFHo9UxU+fK@lore-desk>
References: <20230205101223.GA10729@frolo.macqel>
 <20230205141342.10dbc447@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IzsUbq36T+9gtgP9"
Content-Disposition: inline
In-Reply-To: <20230205141342.10dbc447@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--IzsUbq36T+9gtgP9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 5 Feb 2023 11:12:23 +0100
> Philippe De Muyter <phdm@macq.eu> wrote:
>=20
> > Hello Lorenzo and list,
> >=20
> > I use the imu/st_lsm6dsx (i2c) driver to drive a ism330dlc imu.
> >=20
> > Every time I start a new acquisition of gyro values, the first two
> > values read are wrong, as can be see here :
> >=20
> >  $ sudo ./iio_generic_buffer -n ism330dlc_gyro -g -c 10 -a
> >  iio device number being used is 1
> >  trigger-less mode selected
> >  No channels are enabled, enabling all channels
> >  Enabling: in_anglvel_z_en
> >  Enabling: in_timestamp_en
> >  Enabling: in_anglvel_y_en
> >  Enabling: in_anglvel_x_en
> >  -0.138924 -0.915246 0.470628 1675591514696125669
> >  -0.012699 -0.362151 0.143208 1675591514772675669
> >  0.001989 -0.076500 0.035190 1675591514849250669
> >  0.002295 -0.076194 0.035343 1675591514925825669
> >  0.002142 -0.076041 0.035343 1675591515002400669
> >  0.001989 -0.076041 0.035343 1675591515078975669
> >  0.001836 -0.076347 0.035649 1675591515155525669
> >  0.001836 -0.076500 0.035649 1675591515232075669
> >  0.001989 -0.076500 0.035649 1675591515308625669
> >  0.001989 -0.076347 0.035649 1675591515385200669
> >  Disabling: in_anglvel_z_en
> >  Disabling: in_timestamp_en
> >  Disabling: in_anglvel_y_en
> >  Disabling: in_anglvel_x_en
> >  $
> >=20
> > Is that a normal behaviour for a gyro in that family or is it be caused
> > by a software or hardware bug ?
>=20
> So, some random thoughts on what might be going on...
> 1) Stale data in the fifo.  Could you run this experiment twice whilst be=
ing
>    careful not to move the device between the runs.  If we still see the =
wrong
>    values at the start then it's not that...

When the device is powered-down we set the FIFO in bypass mode and in-flight
samples are discarded.

>=20
> 2) Device takes a little whilst to stabilize. Possibly this is down to the
>    low pass filters requiring a few samples before they deliver stable ou=
tput.
>    From a quick glance I don't think we provide any userspace control of =
those
>    filters and I think LPR1 is left in default state of disabled.

I would say this issue is related to the "Accelerometer and gyroscope
turn-on/off time" (section 3.9 in the sensor application note).

https://www.st.com/resource/en/application_note/an5125-ism330dlc-3d-acceler=
ometer-and-3d-gyroscope-with-digital-output-for-industrial-applications-stm=
icroelectronics.pdf

@Jonathan: do you think we should discard these sample in the driver or in =
the
user-space app? I would say this can be a general issue. What do you think?

Regards,
Lorenzo

>=20
> You could try messing with the sampling frequency as that may affect the =
number
> of bad samples you see and give us more of a clue (it affects lpf2 direct=
ly).
>=20
> Jonathan
>=20
> >=20
> > Best regards
> >=20
> > Philippe
> >=20
>=20

--IzsUbq36T+9gtgP9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+DPMAAKCRA6cBh0uS2t
rEFIAP4otQkDSDitEcHMRmYOB/xSUhdIR3Yfn95d/FC3bPhkYQEAzQPMhY8k6WmR
Ubiw9wuO9b45FCGgma3SgGqFl0Kgww8=
=exbI
-----END PGP SIGNATURE-----

--IzsUbq36T+9gtgP9--
