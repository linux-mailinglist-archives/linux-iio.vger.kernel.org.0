Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3F1E775C
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 09:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgE2Hou (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 03:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgE2Hou (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 May 2020 03:44:50 -0400
Received: from localhost (unknown [151.48.140.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F51D2074D;
        Fri, 29 May 2020 07:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590738289;
        bh=bbRnKORJVO/YVU55FZR9Anisc5Ub4m8oieKhhfxupwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WucZ+eYhusJF0e0CNMSY0DzJdb6kgbCplH4Hp/+E4CvK7ocnqmSUZJCbncUqBs9C7
         L/bPy3gt1ebCUizF6py9kmRN68p0hvhInkgIhIosyheTRE9gEyr6HgE25yIRxVtL0m
         fGgY43NL2vgb/vKbq9BKe4URd4GKbbifoFgnfxr0=
Date:   Fri, 29 May 2020 09:44:43 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
Message-ID: <20200529074443.GA3198@localhost.localdomain>
References: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
 <20200528210711.GD5419@localhost.localdomain>
 <3c629741-43f1-3d3a-2b40-40ddfd773e86@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <3c629741-43f1-3d3a-2b40-40ddfd773e86@geanix.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 29, Sean Nyekjaer wrote:
>=20
> > >=20
> > > Could a solution, be to call st_lsm6dsx_reset_hw_ts() in st_lsm6dsx_r=
esume()
> > > ?
> >=20
> > yes, I think so. Could you please try to patch below? Thanks.
> >=20
>=20
> Hi Lorenzo,
>=20
> I have tried your patch, and the timestamp seems to behave like before.
>=20
> https://gist.github.com/sknsean/959d3421f66cb49144e7841a8a08a2be
> Sorry NTP have been connected for a while :)
>=20
> I will enable some more debug to trace what is happening.
>=20
> /Sean

Hi Sean,

thx for testing. Is the FIFO enabled before the suspend (in other words, is
st_lsm6dsx_resume_fifo running in st_lsm6dsx_resume?) what is the value of
sensor->ts_ref after the resume?

Regards,
Lorenzo

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXtC9aQAKCRA6cBh0uS2t
rJiBAP9w4fl7vPnlFD4phJbL20XpAUCbuQSDdsRtQ0ut2b+VOAEAqfDEfOM2dZXq
27OoNRfF3A43uOoXvUWa2qIGtZ/p/w8=
=acW0
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
