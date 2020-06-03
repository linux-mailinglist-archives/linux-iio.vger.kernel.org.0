Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F841ECF88
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 14:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCMMe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 08:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCMMe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jun 2020 08:12:34 -0400
Received: from localhost (unknown [151.48.128.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF67A20678;
        Wed,  3 Jun 2020 12:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591186353;
        bh=hSaB01wJ5SzeNv6o6og0/u+bPkW4lOG3qgwZeBcBWVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0+p8jWyZWuSu2F2mDxOgNuFgWsR2tZZ0B6/84+PqE9k1Ri5E/w1ZqxWsQSTLLpHf
         knBeVN9Ojsk/e2SQExmygY0ltht7ZLv+A2I697y27DIx1G2vHmnARzCDk8P8WBLhVW
         tD0nnyJMFg/hZKk7BnQRmD2GNVkYe764D7U9pEc8=
Date:   Wed, 3 Jun 2020 14:12:27 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
Message-ID: <20200603121227.GE544784@lore-desk.lan>
References: <20200529121616.GD3198@localhost.localdomain>
 <26401237-5e3b-faf7-35c7-9d6e22f6d239@geanix.com>
 <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
 <e9964fda-3b83-2e23-299a-7ab7d50529af@geanix.com>
 <20200603080619.GA544784@lore-desk.lan>
 <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com>
 <20200603102841.GC544784@lore-desk.lan>
 <d3288925-0891-8c72-b0e7-2b71ff50e1d3@geanix.com>
 <20200603105105.GD544784@lore-desk.lan>
 <a6716a15-abf9-3218-00b8-fb7f257e5649@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <a6716a15-abf9-3218-00b8-fb7f257e5649@geanix.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 03/06/2020 12.51, Lorenzo Bianconi wrote:
> > > > >=20
> > > > > Hmm, suspend again for 15s.
> > > > >=20
> > > > > https://gist.github.com/sknsean/911ae4ae2e74ebe1e7eca1405c645ff1
> > > > >=20
> > > > > [  105.520634] PM: suspend exit
> > > > > [  105.540206] ts_ref 1591097307780181385, ts 2861700000, sample_=
time
> > > > > 1591097310641881385
> > > > >=20
> > > > > [  105.548416] ktime_get_real_ns: 1591097322928175385
> > > > >=20
> > > > > CLOCK_REALTIME isn't ready in the resume function. I think we nee=
d to link
> > > > > it to CLOCK_BOOTTIME (Which ticking under suspend) instead.
> > > >=20
> > > > With latest patch it seems to me the time reported is now monotonic=
 so it seems
> > > > correct. What is the clocktype you set? you can check it in:
> > > > /sys/bus/iio/devices/iio:device<x>/current_timestamp_clock
> > >=20
> > > default: realtime
> > >=20
> > > In the dump above the ktime_get_real_ns(first fifo dump after suspend=
) -
> > > ts_ref + ts is =3D 12,286294 sec...
> > >=20
> > > /Sean
> >=20
> > right. Could you please add to the dump log the ts_ref value in st_lsm6=
dsx_resume()
> > just after iio_get_time_ns()?
> >=20
> Sure,
>=20
> [  173.849649] ktime_get_real_ns: 1591097391339190269
>=20
> [  173.855244] ts_ref 1591097386868224810, ts 4488650000, sample_time
> 1591097391356874810
>=20
> [  173.855272] ktime_get_real_ns: 1591097391344812894
>=20
> [  173.861256] PM: suspend devices took 0.080 seconds
>=20
> [  173.875214] Disabling non-boot CPUs ...
> [  173.887482] sensor->ts_ref[1] =3D 1591097391377130644
>=20
> [  173.906546] PM: resume devices took 0.020 seconds
>=20
> [  174.028152] OOM killer enabled.
> [  174.031331] Restarting tasks ... done.
> [  174.078636] PM: suspend exit
> [  174.127877] ts_ref 1591097391377130644, ts 4531750000, sample_time
> 1591097395908880644
>=20
> [  174.136383] ktime_get_real_ns: 1591097405112347968
>=20
> [  174.145841] ts_ref 1591097391377130644, ts 4570200000, sample_time
> 1591097395947330644
>=20
> [  174.154031] ktime_get_real_ns: 1591097405129995760
>=20
> Missing 13,73 sec :(
>=20
> If the CLOCK_REALTIME was updated in resume(), I think the first patch
> proposal was better.

Can you please try to use CLOCK_BOOTTIME instead?

Regards,
Lorenzo

>=20
> /Sean

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXteTqQAKCRA6cBh0uS2t
rK9oAQCAaWRFGlfEudLlQrH3k2Dej+IS0HeDyLPuA/UIY5OoMgD/TrMcxwl6gAhO
vUN+qzrBotQ+dcSm4OSQbRanKhMuwAQ=
=TRoW
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
