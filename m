Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BBC694379
	for <lists+linux-iio@lfdr.de>; Mon, 13 Feb 2023 11:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBMKxd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Feb 2023 05:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBMKxc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Feb 2023 05:53:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3697DAF
        for <linux-iio@vger.kernel.org>; Mon, 13 Feb 2023 02:53:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1062B81082
        for <linux-iio@vger.kernel.org>; Mon, 13 Feb 2023 10:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A33C433EF;
        Mon, 13 Feb 2023 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676285608;
        bh=DclADwXESlv0CdpKzzrx7O8ly9v6KEp1WSmse8pO3dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLTEBxpa7ekSCasii/18t0iWR/JIRTy7TLsyzXby2yUZM2OUoyy2xEq/dlzDdmkSK
         SrojsqaqZQJ2U8QINvl67y7uJgb0FQMg59bmR8G6+RshYPZdQMvzVE1FJfB0J7Psez
         tGnktKCLLKqsAv//wRJoLNhmhg9rrwPL6ZkADrLFHJ5enIqQO7DUedSv+kbo7Li2w5
         H3EiKIAsEpruLTLoGRedt7nG/aaCV9AD6a7fwLYE+qLXxsTu9xlYtnh+y37vxem+w7
         DhczZexr0a3KRTSqeC6LrreGnqr3I2DKIBx//GTYUK6dzR6QDd3+HyG67afHyfqMGQ
         4Cib73AaRSjuw==
Date:   Mon, 13 Feb 2023 11:53:24 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Philippe De Muyter <phdm@macq.eu>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: no answer after some
 iio_generic_buffer test cycles
Message-ID: <Y+oWpKubqhgvCOVx@lore-desk>
References: <1228b9ed2060b99d0df0f5549a37c8b520ea5429.1675867224.git.lorenzo@kernel.org>
 <Y+i9rImVqH7iVets@lore-desk>
 <20230213091957.GA4925@frolo.macqel>
 <20230213101654.GA5438@frolo.macqel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fILDq95J0M28iEc1"
Content-Disposition: inline
In-Reply-To: <20230213101654.GA5438@frolo.macqel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--fILDq95J0M28iEc1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo,

Hi Philippe,

>=20
> On Mon, Feb 13, 2023 at 10:19:57AM +0100, Philippe De Muyter wrote:
> > I have a bug, with our without the patch : frequently
> > my test, using a loop around iio-generic-buffer, blocks on the poll sys=
call.
> > No value comes anymore.  This happens both with the gyro as with the ac=
cel
> > component.
> >=20
> > More info follows.
>=20
> Here is the way I test :
>=20
>  # iio/lsiio=20
>  Device 001: ism330dlc_gyro
>  Device 002: ism330dlc_accel
>  Device 000: ina3221x
>  # for axis in x y z; do echo 1 >/sys/bus/iio/devices/iio\:device1/scan_e=
lements/in_anglvel_${axis}_en; done
>  # echo 416 > /sys/bus/iio/devices/iio\:device1/sampling_frequency
>  # while true; do  sudo iio/iio_generic_buffer -n ism330dlc_gyro -g -c 6 =
-a; sleep 2; done
>  iio device number being used is 1
>  trigger-less mode selected
>  Auto-channels selected but some channels are already activated in sysfs
>  Proceeding without activating any channels
>  0.002291 -0.073762 0.033139=20
>  0.003971 -0.075289 0.035583=20
>  0.003971 -0.076969 0.036194=20
>  0.004123 -0.074220 0.037110=20
>  0.003207 -0.074678 0.034667=20
>  0.002596 -0.073456 0.035277=20
>  iio device number being used is 1
>  trigger-less mode selected
>  Auto-channels selected but some channels are already activated in sysfs
>  Proceeding without activating any channels
>  0.002138 -0.074067 0.034819=20
>  0.003512 -0.075442 0.034819=20
>  0.001985 -0.074373 0.035430=20
>  0.002902 -0.074373 0.035888=20
>  0.002138 -0.074220 0.036346=20
>  0.003360 -0.076053 0.035277
>=20
> After a quick time, iio_generic_buffer gets blocked in the poll syscall.

are you running level or edge interrupts? If you are using edge ones can you
please check your kernel has the following fix?

commit 3f9bce7a22a3f8ac9d885c9d75bc45569f24ac8b
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Sat Nov 14 19:39:05 2020 +0100

    iio: imu: st_lsm6dsx: fix edge-trigger interrupts

> Hitting 'CTRL-C' kills the iio_generic_buffer process, and the next one
> then receives values.
>=20
> This happens with both gyro and accel.
>=20
> Do you encounter the same problem ?
>=20
> My kernel is actually a 4.9 one with a backport of iio core infrastructure
> and iio/imu/st_lsm6dsx of 6.2, but I could have missed something importan=
t.

Are you able to test with an upstream kernel?

Regards,
Lorenzo

>=20
> Best regards
>=20
> Philippe

--fILDq95J0M28iEc1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY+oWpAAKCRA6cBh0uS2t
rERUAP46kdAxPfg8oQpxN0pzJK+R6/nrowk+4YORUHCbZ0rfIAD+L7CO83zAojgI
qR5vPyBuHGfheFmf3HWu4atPnNn3NAM=
=it3p
-----END PGP SIGNATURE-----

--fILDq95J0M28iEc1--
