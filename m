Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6AFD19127D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCXOJh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 10:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgCXOJg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Mar 2020 10:09:36 -0400
Received: from lore-desk-wlan (unknown [151.48.139.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6C6205ED;
        Tue, 24 Mar 2020 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585058976;
        bh=Go/gEJxsSb2k4b6t2WfRp7YJr4ZMZKBojX6p2V7TSkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwXkQ9nZrgEECjHfcZIzX6b3l+NPy28rFNH9r3uA/kSXRgiTpMnD6HN+agk8BxeIC
         GdpBNkma/xu/s8fGKxpu2A8za7Lg0kb1U1NlJg5/1QbzQiDtYo7m9uDSOyOj2ZG3/i
         NRo0M5hNYQtCkjW+ifvPN/dSASV+aCH2BEYXXaUE=
Date:   Tue, 24 Mar 2020 15:09:26 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Use LIS3MDL with LSM6DSM sensor-hub
Message-ID: <20200324140926.GA1477940@lore-desk-wlan>
References: <f8489de0-c6a4-f786-b936-679eba6d6804@gmail.com>
 <20200314124324.GA144176@lore-desk-wlan>
 <217cb6b1-d3b3-bccf-b081-d4beb0888615@gmail.com>
 <20200319174039.GA1564882@lore-desk-wlan>
 <ef4aa50f-4aa6-cb87-06b6-913e2abbb23c@gmail.com>
 <20200319204937.GB1564882@lore-desk-wlan>
 <37e50d0e-0618-eeba-8cf9-7c1272097a62@gmail.com>
 <20200324082017.GA1387749@lore-desk-wlan>
 <9e34cc2a-dd62-f915-6e82-02af151a26d9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <9e34cc2a-dd62-f915-6e82-02af151a26d9@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> > > > > };
> > > > >=20
> > > > > I'll look into this tomorrow or in the beginning of next week, th=
anks for the help.
> > >=20
> > > Now I've tested this. It looks fine, except for the very first sample:
> > > $ ./iio_generic_buffer -gn lsm6dsm_magn -c 1
> > > iio device number being used is 3
> > > trigger-less mode selected
> > > -3.250836 -2.796192 10.212408 1584976428879020199
> > > 1.893036 2.343738 -0.853224 1584976428917070199
> > > 1.888218 2.343300 -0.852786 1584976428955095199
> > > 1.888218 2.343300 -0.852786 1584976428993145199
> > > 1.889532 2.345490 -0.851472 1584976429031170199
> >=20
> > values seems reasonable but I guess it depends on sensor calibration an=
d how is
> > oriented. Do you have any app to test it?
>=20
> I think the values are correct. If I rotate the sensor the values change.
> And I get similar values when the sensor reach the same orientation as be=
fore.
> The only thing that looks strange, is the very first sample (-3.250836 -2=
=2E796192 10.212408),
> which is not close to any of the other samples. When I plot the samples, =
the other samples
> form a circle, while the first sample is way outside of the circle.

I think this can be due to sensor start-up time

>=20
> What about calibration? Is there any functionality in iio for calibration=
, or in libiio, or will
> this always be part of the application?

AFAIK calibration libraries are done in userspace and usually they are not
open source.

Regards,
Lorenzo

>=20
> Unfortunately we don't got any app for this yet.
>=20
> Regards,
> jimmy
>=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > Is this expected?
> > >=20
> > > Regards,
> > > jimmy

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXnoUlAAKCRA6cBh0uS2t
rEGeAP9KQ3qjivzhOeCwtWWo7uVf7hCmmyua1JgPbZyk1MPuMAD/aSQgyu3/AdHW
xtI1SWE3OQ94l7Ly6+FXUWrxlNMFUQM=
=PMVB
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
