Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29070A9AE6
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 08:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbfIEGrU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 02:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730778AbfIEGrU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 02:47:20 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7643420693;
        Thu,  5 Sep 2019 06:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567666039;
        bh=6HCrV9hrIAPZo/l8PPnVCY30OxwYxegvejUdNXq92rM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAUs3/aInQ4ndb6VEOyx27xKW6OMBAObYQSJtcth8NDeNW/xsKmWfOmZWGG8bpU+C
         VYe4fC9xPNyYhzKaFntQzxC0yXwG5cjGAhSREufCElWrIlFqtV+98ZMDoSVqV5wb2/
         fEZwNsrDD9h2s8fv9Q3+EyKUbaDGWVAD/Vy9H7H0=
Date:   Thu, 5 Sep 2019 08:47:13 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v3 4/6] iio: imu: st_lsm6dsx: always enter interrupt
 thread
Message-ID: <20190905064713.GC31578@localhost.localdomain>
References: <20190904091732.112281-1-sean@geanix.com>
 <20190904091732.112281-4-sean@geanix.com>
 <20190905063441.GA31578@localhost.localdomain>
 <a40bef10-8f82-e284-806e-4852abeb6400@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <a40bef10-8f82-e284-806e-4852abeb6400@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 05/09/2019 08.34, Lorenzo Bianconi wrote:
> > This chunck is unnecessary since read_fifo() will check number of avail=
able
> > samples in the FIFO and moreover it is obviously broken since you are r=
unning
> > st_lsm6dsx_read_fifo directly instead of using fifo_ops pointer.
>=20
> Thanks for the review :-)
>=20
> I have missed that, I have spend a lot of time rebasing "iio: imu:
> st_lsm6dsx: move interrupt thread to core".
> It could be nice if that patch could be applied in the near future :-)
>=20
> /Sean

I think Jonathan will prefer the patch to be part of the series where it is
actually needed (so up to him). I am fine even if you repost the single pat=
ch
adding requested changes

Regards,
Lorenzo

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXCvbwAKCRA6cBh0uS2t
rHf8AQCHxVFANq0sIegK+JiSLBGNHS8ZR1FjqEwZ+pLKC4PEMgD9H8ouuDcHF99q
I6MU+IBBjkAugh4sINsHAFcEG442xgE=
=daIq
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
