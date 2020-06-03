Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861A71ED056
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFCM4g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 08:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgFCM4g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jun 2020 08:56:36 -0400
Received: from localhost (unknown [151.48.128.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A3E620772;
        Wed,  3 Jun 2020 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591188995;
        bh=6u4PniF5LrDCkYoRSWbjSTPC4fPHICKqbyotBlCP+D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xcbf7l05UnTat3ZUhryJvisaM4lk7mry3ViXmkl+rkOsf+jep2rgIIfPwAe8qTay9
         iROenAGEP1GUL8MMAd34UlB1/hJih6Rq72t9sG8IwbKD+gMCK7I6osSB58OInni8Aq
         dAEfQqKGGD3xSkKxB+K3j7rCSWyrPY0DaZKEyoQk=
Date:   Wed, 3 Jun 2020 14:56:30 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
Message-ID: <20200603125630.GF544784@lore-desk.lan>
References: <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
 <e9964fda-3b83-2e23-299a-7ab7d50529af@geanix.com>
 <20200603080619.GA544784@lore-desk.lan>
 <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com>
 <20200603102841.GC544784@lore-desk.lan>
 <d3288925-0891-8c72-b0e7-2b71ff50e1d3@geanix.com>
 <20200603105105.GD544784@lore-desk.lan>
 <a6716a15-abf9-3218-00b8-fb7f257e5649@geanix.com>
 <20200603121227.GE544784@lore-desk.lan>
 <55fb09cf-76ab-0c42-7283-0836838f2deb@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <55fb09cf-76ab-0c42-7283-0836838f2deb@geanix.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 03/06/2020 14.12, Lorenzo Bianconi wrote:
> > >=20
> > >=20
> > > On 03/06/2020 12.51, Lorenzo Bianconi wrote:
> > > > > > >=20
> > > > > > > Hmm, suspend again for 15s.
> > > > > > >=20
> > > > > > > https://gist.github.com/sknsean/911ae4ae2e74ebe1e7eca1405c645=
ff1
> > > > > > >=20
> > > > > > > [  105.520634] PM: suspend exit
> > > > > > > [  105.540206] ts_ref 1591097307780181385, ts 2861700000, sam=
ple_time
> > > > > > > 1591097310641881385
> > > > > > >=20
> > > > > > > [  105.548416] ktime_get_real_ns: 1591097322928175385
> > > > > > >=20
> > > > > > > CLOCK_REALTIME isn't ready in the resume function. I think we=
 need to link
> > > > > > > it to CLOCK_BOOTTIME (Which ticking under suspend) instead.
> > > > > >=20
> > > > > > With latest patch it seems to me the time reported is now monot=
onic so it seems
> > > > > > correct. What is the clocktype you set? you can check it in:
> > > > > > /sys/bus/iio/devices/iio:device<x>/current_timestamp_clock
> > > > >=20
> > > > > default: realtime
> > > > >=20
> > > > > In the dump above the ktime_get_real_ns(first fifo dump after sus=
pend) -
> > > > > ts_ref + ts is =3D 12,286294 sec...
> > > > >=20
> > > > > /Sean
> > > >=20
> > > > right. Could you please add to the dump log the ts_ref value in st_=
lsm6dsx_resume()
> > > > just after iio_get_time_ns()?
> > > >=20
> > > Sure,
> > >=20
> > > [  173.849649] ktime_get_real_ns: 1591097391339190269
> > >=20
> > > [  173.855244] ts_ref 1591097386868224810, ts 4488650000, sample_time
> > > 1591097391356874810
> > >=20
> > > [  173.855272] ktime_get_real_ns: 1591097391344812894
> > >=20
> > > [  173.861256] PM: suspend devices took 0.080 seconds
> > >=20
> > > [  173.875214] Disabling non-boot CPUs ...
> > > [  173.887482] sensor->ts_ref[1] =3D 1591097391377130644
> > >=20
> > > [  173.906546] PM: resume devices took 0.020 seconds
> > >=20
> > > [  174.028152] OOM killer enabled.
> > > [  174.031331] Restarting tasks ... done.
> > > [  174.078636] PM: suspend exit
> > > [  174.127877] ts_ref 1591097391377130644, ts 4531750000, sample_time
> > > 1591097395908880644
> > >=20
> > > [  174.136383] ktime_get_real_ns: 1591097405112347968
> > >=20
> > > [  174.145841] ts_ref 1591097391377130644, ts 4570200000, sample_time
> > > 1591097395947330644
> > >=20
> > > [  174.154031] ktime_get_real_ns: 1591097405129995760
> > >=20
> > > Missing 13,73 sec :(
> > >=20
> > > If the CLOCK_REALTIME was updated in resume(), I think the first patch
> > > proposal was better.
> >=20
> > Can you please try to use CLOCK_BOOTTIME instead?
> >=20
>=20
> With CLOCK_BOOTTIME and only the ts_ref reset.
>=20
> [ 4978.971598] ts_ref 4987298377539, ts 19975950000, sample_time
> 5007274327539
>=20
> [ 4978.971618] ktime_get_real_ns: 1591102209947858582
> [ 4978.974386] ts_ref 4987298377539, ts 20014375000, sample_time
> 5007312752539
>=20
> [ 4978.974408] ktime_get_real_ns: 1591102209950647832
> [ 4978.977333] ts_ref 4987298377539, ts 20052825000, sample_time
> 5007351202539
>=20
> [ 4978.977355] ktime_get_real_ns: 1591102209953595374
> [ 4978.980179] ts_ref 4987298377539, ts 20091250000, sample_time
> 5007389627539
>=20
> [ 4978.980199] ktime_get_real_ns: 1591102209956438707
> [ 4979.002747] ts_ref 4987298377539, ts 20129700000, sample_time
> 5007428077539
>=20
> [ 4979.002893] ktime_get_real_ns: 1591102209979130499
> [ 4979.009099] PM: suspend devices took 0.070 seconds
>=20
> [ 4979.022969] Disabling non-boot CPUs ...
> [ 4979.035611] sensor->ts_ref[1] =3D 5007372366999
> [ 4979.056233] PM: resume devices took 0.030 seconds
> [ 4979.157652] OOM killer enabled.
> [ 4979.160828] Restarting tasks ... done.
> [ 4979.203811] PM: suspend exit
> [ 4979.272383] ts_ref 5007372366999, ts 20171250000, sample_time
> 5027543616999
>=20
> [ 4979.279816] ktime_get_real_ns: 1591102224105489426
> [ 4979.288129] ts_ref 5007372366999, ts 20209700000, sample_time
> 5027582066999
>=20
> [ 4979.295147] ktime_get_real_ns: 1591102224120826134
> [ 4979.303178] ts_ref 5007372366999, ts 20248125000, sample_time
> 5027620491999
>=20
> [ 4979.310393] ktime_get_real_ns: 1591102224136066468
> [ 4979.318377] ts_ref 5007372366999, ts 20286575000, sample_time
> 5027658941999
>=20
> [ 4979.325395] ktime_get_real_ns: 1591102224151074634
>=20
> /Sean

Looking at the timestamps it seems to me the suspend lasts for ~20s, is it
correct? Anyway I agree with you I think we need to use my first patch. Can=
 you
please give it a whirl with CLOCK_BOOTIME?

Regards,
Lorenzo

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXted+wAKCRA6cBh0uS2t
rFnjAP9lfPSyTPm6RTeGUlNEJxLDiPLRHXDc9v6hNn85a7lRngD/Wa61wzT/F9yF
yB+Ths2k2wJXscM67ztxBEtttyjIFAc=
=palq
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
