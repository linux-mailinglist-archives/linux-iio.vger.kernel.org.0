Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E30A9B27
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfIEHHb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 03:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbfIEHHb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 03:07:31 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C0DE2168B;
        Thu,  5 Sep 2019 07:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567667250;
        bh=yk4S8TcQR6SHJgGJJjw0SV01szeL0hnASdt2pYxWVnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvPKu0JAAHOiF/DEnOemYRye3KR3WUNXgzPHT8BmHp8zAg1DHosd60sVBkmGk6/c2
         LNqS6Lu4FoP5mqlbWtJX6Ycr4cTzSJMM2dwQVmgr7z2R7sJt6HkPcjJmXWz5AZbs/P
         V+7pd33eP61xLPXIvK2ro93YKZd0zzS8FgZyAWII=
Date:   Thu, 5 Sep 2019 09:07:24 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v3 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190905070724.GD31578@localhost.localdomain>
References: <20190904091732.112281-1-sean@geanix.com>
 <20190904091732.112281-5-sean@geanix.com>
 <20190905063959.GB31578@localhost.localdomain>
 <94ee1cde-7cd3-0184-a551-236191a28025@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <94ee1cde-7cd3-0184-a551-236191a28025@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 05/09/2019 08.39, Lorenzo Bianconi wrote:
> > > Should we include these new defines in device settings?
> > nope if are the same for all available chips..have you double checked?
> >=20
>=20
> lsm6ds3: yes
> lsm6ds3h: yes
> lsm6dsl: yes
> lsm6dsm: yes
> ism330dlc: yes :-)
> lsm6dso: yes
> asm330lhh: yes
> lsm6dsox: yes
> lsm6dsr: yes
> lsm6ds3tr-c: yes
> ism330dhcx: yes
> lsm9ds1_imu: no it have a very different reg layout
>=20
> I would a lot more confidence in patch/work if we only enable these events
> for the devices i actually can test... (The ISM330DLC)

in this case I would prefer to have the register in device settings

Regards,
Lorenzo

>=20
> /Sean

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXC0KgAKCRA6cBh0uS2t
rCrHAQC6enFgFqT/H99hjbvnUc6LbRCXVXWTOYdyQWlrgpERhwD+NPjR9a4U6sKs
SE92oww98eC/3wgxvrRmbe1Sv+u6aQM=
=X618
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
