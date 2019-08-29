Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF31A13E2
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 10:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfH2IhU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 04:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2IhU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Aug 2019 04:37:20 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BBC32189D;
        Thu, 29 Aug 2019 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567067839;
        bh=qzIDLlNJL7JQxGZFL7AGowMDk3lbnSv/fcgHGTzNPA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOWS+2Hfmr7ucJuHEO2AuJzX/gS9mozHJgNm75iA0SGnpCJSQKf/a7bU/JNOQqCoj
         hytlsrc4zAFGmjYks+MkY/74HGg11w7t2Ib+GekF64nvViVmC87oayXCEIto+QjtU2
         Hao/GjkxjVBwaKlBGaRk+6h6KetpcWNwre9OC+Wk=
Date:   Thu, 29 Aug 2019 10:37:14 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Jonathan Cameron <jic23@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org
Subject: Re: [BUG] Re: [PATCH] iio: imu: st_lsm6dsx: remove invalid gain
 value for LSM9DS1
Message-ID: <20190829083714.GA2880@localhost.localdomain>
References: <f2be2f0e064bc7785f9d8f7f6a8598c325b39a45.1566894261.git.lorenzo@kernel.org>
 <20190827210857.718d7f9b@archlinux>
 <37cb0888-50b6-40d2-1289-a78499a90b7c@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <37cb0888-50b6-40d2-1289-a78499a90b7c@puri.sm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 27.08.19 22:08, Jonathan Cameron wrote:
> > On Tue, 27 Aug 2019 10:26:35 +0200
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >=20
> >> Get rid of invalid sensitivity value for LSM9DS1 gyro sensor
> >>
> >> Fixes: 687a60feb9c6 ("iio: imu: st_lsm6dsx: add support for accel/gyro=
 unit of lsm9ds1")
> >> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > The zero degree scale is certainly odd otherwise, so good to tidy
> > this up.
> >=20
> > Applied to the togreg branch of iio.git.
> >=20
>=20
> Hi Jon,
>=20
> you have applied this too quickly. I've left that zero value in there
> for a reason, see below:
>=20
>=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> >> ---

[...]

>=20
> You Ooops here and it's pretty obvious! You don't have
> ST_LSM6DSX_FS_LIST_SIZE number of elements in the array anymore, but you
> try to access it (the 4th).

Hi Martin,

according to pahole (x86_64):=20

struct st_lsm6dsx_fs {
	 [...]
	 /* size: 8, cachelines: 1, members: 2 *
};

struct st_lsm6dsx_fs_table_entry {
	[...]
	struct st_lsm6dsx_fs fs_avl[4];                  /*     4    32 */
	/* size: 36, cachelines: 1, members: 2 */
};

struct st_lsm6dsx_settings {
	[...]
	struct st_lsm6dsx_fs_table_entry fs_table[2];    /*   284    72 */
	/* size: 464, cachelines: 8, members: 14 */
};

struct st_lsm6dsx_fs_table_entry in st_lsm6dsx_settings will always have 4
elements for fs_avl array and since the array is defined as static the
uninitialized elements are set to 0.

Could you please share the ops you are getting?

Regards,
Lorenzo

>=20
> I suggest reverting this (if not able to delete it entirely) and start
> over in case this "invalid" value thing hurts and needs to get fixed.
>=20
> I any case, there _is_ something we should do because it's not too
> obvious what constraints the st_lsm6dsx_sensor_settings struct
> definition has. It should be mostly clear when looking at the header but
> a few inline comments might help.
>=20
> thanks,
>=20
>                           martin
>=20
>=20
>=20
> >> +
> >>  		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
> >> -				 hw->settings->fs_table[id].fs_avl[i].gain);
> >> +				 fs_table->fs_avl[i].gain);
> >> +	}
> >>  	buf[len - 1] =3D '\n';
> >> =20
> >>  	return len;
> >=20
>=20

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXWeOtwAKCRA6cBh0uS2t
rACsAP9A5/W8AzrLJfpl0IVgdWU5z+VzqQGvp3RYlYUuCoKT2AD9G4kigQMHhtve
U0CobyD89Ea0PHsQzdWBC8U+2s2QWgU=
=KtMf
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
