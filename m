Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B3EA43AD
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2019 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfHaJca (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Aug 2019 05:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfHaJca (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Aug 2019 05:32:30 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.4.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2F002087E;
        Sat, 31 Aug 2019 09:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567243949;
        bh=zY91YfmZj1kXURmuRFfSk4yPSlDOenC38K/yxLYxZQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihdGFLbDRheheOOVY8ZmCIRK8zAZxvxRdSzMQ+EEfLYCkRQKeid/J0qFpcy0w5TNb
         wsPR5u1C/2vl3JEtjVnTG9GWBAV/b2+kTwW/Z8MyFWTbKViee09oouIiB5GOBWbCs0
         U+dT/2l4jTTlV8EfhTztTzIL7fDgrpU+puQITfeE=
Date:   Sat, 31 Aug 2019 11:32:24 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Jonathan Cameron <jic23@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org
Subject: Re: [BUG] Re: [PATCH] iio: imu: st_lsm6dsx: remove invalid gain
 value for LSM9DS1
Message-ID: <20190831093224.GA5393@lore-desk-wlan.lan>
References: <f2be2f0e064bc7785f9d8f7f6a8598c325b39a45.1566894261.git.lorenzo@kernel.org>
 <20190827210857.718d7f9b@archlinux>
 <37cb0888-50b6-40d2-1289-a78499a90b7c@puri.sm>
 <20190829083714.GA2880@localhost.localdomain>
 <f34694f0-ea7c-0327-532d-7a2904952771@puri.sm>
 <20190830072354.GA5910@localhost.localdomain>
 <531903f2-a4df-87a8-6417-68463261b859@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <531903f2-a4df-87a8-6417-68463261b859@puri.sm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 30.08.19 09:23, Lorenzo Bianconi wrote:
> >> On 29.08.19 10:37, Lorenzo Bianconi wrote:
> >>>> On 27.08.19 22:08, Jonathan Cameron wrote:
> >>>>> On Tue, 27 Aug 2019 10:26:35 +0200
> >>>>> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >>>>>
> >>>>>> Get rid of invalid sensitivity value for LSM9DS1 gyro sensor
> >>>>>>
> >>>>>> Fixes: 687a60feb9c6 ("iio: imu: st_lsm6dsx: add support for accel/=
gyro unit of lsm9ds1")
> >>>>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>>>> The zero degree scale is certainly odd otherwise, so good to tidy
> >>>>> this up.
> >>>>>
> >>>>> Applied to the togreg branch of iio.git.
> >>>>>
> >=20
> > [...]
> >=20
> >>> struct st_lsm6dsx_fs_table_entry in st_lsm6dsx_settings will always h=
ave 4
> >>> elements for fs_avl array and since the array is defined as static the
> >>> uninitialized elements are set to 0.
> >>>
> >>> Could you please share the ops you are getting?
> >>>
> >>
> >> How this oops during startup can look like is appended below. I know
> >> that exactly this change causes it. Can you test this too please?
> >=20
> > I did it but I have no issues
> >=20
> >>
> >> Given the cleanup nature of this patch, I think it's best to revert it
> >> in case of any doubt.
> >>
> >> thanks,
> >>
> >>                           martin
> >>
> >=20
> > is it the full ops? It seems some parts are missing.
> > Are you running some userspace aps reading in_anglvel_scale_available o=
r reading/writing in in_anglvel_scale?
> > Could you please double check if the following patch helps? (just compi=
led)
> >=20
>=20
> it does not, and you're right, the problem should be somewhere else.
> I've yet to debug it further.
>=20
> thanks,

Looking at the previous patch I spotted an issue (not related to the one you
are facing)..actually we can set device gain to 0 forcing to 0 sensor outpu=
t.
I will post a formal patch to fix it.

Regards,
Lorenzo

>=20
>                         martin
>=20
>=20

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXWo+ogAKCRA6cBh0uS2t
rKNnAQClf5V90SWL9kFjgapGZcQ2T3rQomzsy+1qiF2CSKPLwQEAo7BHIiihZ3SS
vPqsszMWKwynLJXWanhomCwoE6mA/QM=
=ty2U
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
