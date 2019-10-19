Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A512DD60E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2019 03:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfJSBuV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 21:50:21 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17479 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfJSBuU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 21:50:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571449804; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=OWaI5P4CEehv/9Y0b0XMFbIqbX0ug/SQifLBKXN/wQaJCBcmiIla+N8WmZJT3oy+gKsxIRMRONFQskXKUO69Ezedn+IBFsme793WmUGcmDv3peS3cuUhDowMMzLxBaGXhwCXAQuSpf437AJnhIS9tZKiH9vU4Y6I82ekxkDKZes=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571449804; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=X+sorDRmgdOKvUGcHABOo/6lzo+4hMmoIkCm/G9ejtY=; 
        b=SwUeUv6NmGe/smz5MMoGv64w3/5nJMZzaa7f3GbWElniPBZXTUoiCJwmGg8yR/js7bfobFESPLGN8iGCEmH+x+ea/rvQ8TojrVjKP33FEs/bSNX378MRaCI7sM9ppUpWl5Sfa3k9i2uAAwYxzzXiN19pDj6l6XT2BpuQ3x6VLnA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 157144980180417.00672295930474; Fri, 18 Oct 2019 18:50:01 -0700 (PDT)
Date:   Sat, 19 Oct 2019 01:35:26 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <20191019013526.GA8593@nessie>
References: <20191018031848.18538-1-dan@dlrobertson.com>
 <20191018031848.18538-3-dan@dlrobertson.com>
 <487efd2c-b453-6c8b-eaac-7ba168bb4d77@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <487efd2c-b453-6c8b-eaac-7ba168bb4d77@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 09:25:37PM -0700, Randy Dunlap wrote:
> On 10/17/19 8:18 PM, Dan Robertson wrote:
> > +config BMA400
> > +	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
> > +	depends on I2C
> > +	select REGMAP
> > +	select BMA400_I2C if (I2C)
>=20
> Since BMA400 already depends on I2C, the "if (I2C)" above is
> redundant so it's not needed.

You are correct. I'll remove the depends on I2C.

> > +struct bma400_data {
> > +	struct device *dev;
> > +	struct mutex mutex; /* data register lock */
>=20
> needs #include <linux/mutex.h>

Good point.

> > +static int bma400_get_accel_scale_idx(struct bma400_data *data, int va=
l)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 1; i < ARRAY_SIZE(bma400_scale_table); i +=3D 2) {
>=20
> needs #include <linux/kernel.h>
> for ARRAY_SIZE()

Thanks

Cheers,

 - Dan

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl2qaF0ACgkQRcSmUsR+
QqVPdBAAjUpM5443o6S7dD+2/YUIMZg6dC9qCOLlOt2e3oNUNJuTESggWW/xHVkF
tg4keSNYZG+X+aA+EkyJObiWyfHGjGBqkMFZt1ykk8pT1Sdx7CGxD0m3bp57zadD
EJ7Mftk8nzrEaQUYTLfjnCPwBxoucEJqsHfgHKI7kW6IFAzehxeXo0cBPqmrvAK4
0AB71yrq7IjWLDExbPmjlAlwVLQgwtcu+oIyueurtI+Z/6gBPB3NL4xxX0wII5OG
nyPQVq2DvnQIF3XyM0jCbVuh5FCMmhkCDTB0hQzVI5qflgdaS1WCpftp2lXIwE0p
ZMtiN3Q2yf3TFofzBMAq17b7R+hY4eu+XXljE6D92WLbtTbQOYbAYf25tTZPkuSI
NyJrL79iFeFZ8isw0ASTNU2C61JQL38NRj5XzU1f5jdjbqt+8rfF7v2dGMFKEapb
sjQNO6K9iM6hqUP234wfQyt1NOh60kSQksVxNnITEH8QSoxKng8kNb2+veaI4Uva
vG3bPq23G9Mgmd34jAzyyUV1hMn/rMKGcVes5cUSfirY/JWeoXmAZfN9F/BHBpjQ
kvJi360Sha22+K46kbPZV3uVSBPIE4JXPetf/Z/CaYtsdU9hA0LYA4wdFhFZCKJ+
jaD+5dtcEEwbTJuvyu42xxovDarduN+YZl0LP59gnuzeYYgmPl4=
=OKYb
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

