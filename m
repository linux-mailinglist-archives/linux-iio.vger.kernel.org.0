Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A484CDF6A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfJGKeP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 06:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfJGKeO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 06:34:14 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B284206C2;
        Mon,  7 Oct 2019 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570444454;
        bh=BvDNLerIvFluGg2r8rsjC015TzbTUpca+rYuGZkUR10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovNqeMhF+eDlZU/ypY2V169htMjo1uk7RHhegaivzuIczJ/M5ujRWij4wEonv9sSI
         IeZEvDK3R3mGAqQkfDpnj/aOcz7bgNBdBPOnmAGcGVUzRsMwFIDWEMEa5FZhFusQUt
         0+OG5HVVr5pD0gtkb2A/mN6mOfyL2QJDgXPHb8Co=
Date:   Mon, 7 Oct 2019 12:34:09 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [BUG] iio: imu: st_lsm6dsx: read error when resuming from suspend
Message-ID: <20191007103409.GB3192@localhost.localdomain>
References: <128e9528-593f-271b-708f-ef197c08f3bb@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <128e9528-593f-271b-708f-ef197c08f3bb@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20

Hi Sean,

> I'm seeing this error sometimes when resuming:
> st_lsm6dsx_i2c 1-006a: failed to read fifo status (err=3D-13)

it seems the error is directly reported by regmap/i2c driver you are runnin=
g,
it is not related to the last series I sent.

>=20
> I doesn't matter if it's the ism330 or another wake source.
> I have not enabled fifo readings.
>=20
> I have tried the "[PATCH 00/13] various st_lsm6dsx fixes and missing bits=
=E2=80=8B"
> same results.
>=20
> The regmap_read in st_lsm6dsx_handler_thread for the event seems to be
> reading something as the event is reported correctly.
>=20
> Later events are reported correctly...

So IIUC the system just reports a sporadic error sometimes during resume bu=
t it
is able to recover, right?

Regards,
Lorenzo

>=20
> /Sean

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXZsUnwAKCRA6cBh0uS2t
rJbDAP9lcPP7rSLlnZkmQlTNPWS/09WQnfEyhzWmcFn2VQLIrQD+LQHdfRQTfY+Z
ehSQ+mucfdhX6islHEXIwbqXdJBfuAs=
=+usR
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
