Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE09666EBA
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jan 2023 10:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjALJyr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Jan 2023 04:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbjALJyL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2023 04:54:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E19322
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2023 01:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8036AB81DF5
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2023 09:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA8BC433EF;
        Thu, 12 Jan 2023 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673517069;
        bh=bVVokIO8Bk+UD32EJ0En9xmFm+lTz3x8IM4zjqIGZ4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kFUM2D3ODUVMXJduaLVN9NWvcjhPQffyJqkvX3yNPk+YzXG2/iSQTo2xZU2kSRK8Q
         UguocOlcqW2RfTVBX1KgbTtE1F36JuLZ2o1xviXrDanpAQK7D3BibPhAc3eBwam9N5
         9qXacbNlPBZzOJlBv2eLTO3p2itaWu/e0mvscbzR86t2vzS4vrrwBsdLOqndmsADwi
         eD5zhN9xbmlop4F+EI6GY/921umTcD7k2Y1ImJq8w9PtY4Zf8S6lvCBcE5GNq4u2aI
         s9V9XN/8CFpD86MvsskYhlElsg3/ASy/WBJUZynr+r+TJj+GmUtLLFypZ1sCfwJ2hU
         mZhCNRhxDniRw==
Date:   Thu, 12 Jan 2023 10:51:03 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Philippe De Muyter <phdm@macq.eu>, linux-iio@vger.kernel.org
Subject: Re: sysfs mount_matrix for st_lsm6dsx gyro
Message-ID: <Y7/YB1CmEzbnNogP@lore-desk>
References: <20230111120940.GA23351@frolo.macqel>
 <20230111171732.00006941@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LKGZTq5Vcgf/dffh"
Content-Disposition: inline
In-Reply-To: <20230111171732.00006941@Huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--LKGZTq5Vcgf/dffh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 11 Jan 2023 13:09:40 +0100
> Philippe De Muyter <phdm@macq.eu> wrote:
>=20
> > Hello Lorenzo and list,
> >=20
> > I do not find a "*mount_matrix" entry in sysfs for a 'ism330dlc_gyro'
> > iio device.
> > Is that normal ?
> > Is a fix available ?
>=20
> Looks like the channel definition for the gyro does not include an
> appropriate ext_info entry unlike the accelerometer channels which
> have one with mount_matrix support.
>=20
> From a quick glance looks like a simple fix. Add that entry.

I am not sure if accel and gyro can be mounted with a different orientation.
Do you think we should have a per-sensor mount_matrix?

Regards,
Lorenzo

> >=20
> > Some more info :
> >=20
> > I have backported  drivers/iio/imu/st_lsm6dsx to linux-4.9 in order
> > to drive a ism330dlc imu on a custom board.  The chip is correctly
> > detected and two devices are created in /sys/bus/iio/devices/
> >=20
> > the first one (where name is 'ism330dlc_gyro') has the following entrie=
s :
> >=20
> >  me@proto4:~$ ls /sys/bus/iio/devices/iio\:device1/
> >  buffer                      in_anglvel_x_raw  sampling_frequency
> >  current_timestamp_clock     in_anglvel_y_raw  sampling_frequency_avail=
able
> >  dev                         in_anglvel_z_raw  scan_elements
> >  in_anglvel_scale            name              subsystem
> >  in_anglvel_scale_available  power             uevent
> >  me@proto4:~$
> >=20
> > the second one (where name is 'ism330dlc_accel') has those entries :
> >=20
> >  me@proto4:~$ ls /sys/bus/iio/devices/iio\:device2
> >  buffer                    in_accel_x_raw  sampling_frequency
> >  current_timestamp_clock   in_accel_y_raw  sampling_frequency_available
> >  dev                       in_accel_z_raw  scan_elements
> >  events                    mount_matrix    subsystem
> >  in_accel_scale            name            uevent
> >  in_accel_scale_available  power
> >  me@proto4:~$
> >=20
> > The 'mount_matrix' entry is only present in the 'ism330dlc_accel' device
> > but not in the 'ism330dlc_gyro' device.
> >=20
> > On a similar board, but with mpu9250 imu, I get only one iio:deviceX
> > entry but with two *mount_matrix entries :=20
> >=20
> > 	in_accel_mount_matrix
> > 	in_anglvel_mount_matrix
> >=20
> > In both cases, I would have expected only one 'iio:deviceX' entry with
> > only one 'mount_matrix' entry.
>=20
> There are multiple devices because the driver predates the addition
> of multiple buffer support to IIO and IIRC is capable of producing data
> at different sampling rates for the accelerometer and the gyros.
> Hence when it was implemented the only choice was to register multiple
> devices in order to get the multiple buffers. It's ABI now so we can't
> fix it in an old driver unfortunately.  We'd do this differently today..
>=20
> The double mount_matrix for the mpu9250 is a little odd and I can't
> immediately spot why that one is happening.
>=20
>=20
> >=20
> > Best regards
> >=20
> > Philippe
> >=20
>=20

--LKGZTq5Vcgf/dffh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY7/YBgAKCRA6cBh0uS2t
rAGmAQCQXcK7LlyQLCH+HmfBEOAdPWA+tx+0Bz9Ae8oVcoUs+gEAwTb4zatyA2Xq
0pREix6q38vgM82i8nzTQZWF4kXzTA0=
=NnCm
-----END PGP SIGNATURE-----

--LKGZTq5Vcgf/dffh--
