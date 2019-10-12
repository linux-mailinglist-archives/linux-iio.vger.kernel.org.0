Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B364D50C3
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 17:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfJLPu3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 11:50:29 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17409 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfJLPu3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 11:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570895418; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=eIthmr2DE1iqsL+l7kiWklE9vhLgqPMOKFc7m/1+q9s33jP/iHKV1WsrarYHYh0kWRkvBQIdDr/eEjaTRxHiyIgkmWWg18hOXhRaJmG3ETMVWBJ6riBMWQPP/Bg6eOKRtG9egD1LrFzKLpqOfcz3XxHFnCF0WmgeVj+aD096ZTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1570895418; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XT1UzgCGaseEWEDYLymVrPJuvAsUptmGPsOVyIfBiZQ=; 
        b=NdkOyMY5QgBckJzBRt89/Ku04gFXGA1s9En1Rz2gtO+GhMHkgap+Z1qY79U8aZSgGlH4AU85X7i8t8j0KMBa3+6CFSGh30IrdyfBKCdt9Fatn4MBs3gJv4aTplI8YUuq120KB8hPDdzYX75CngPZD8+TGWVQd0JVru6VED4ZNYU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1570895418054430.6876645675419; Sat, 12 Oct 2019 08:50:18 -0700 (PDT)
Date:   Sat, 12 Oct 2019 15:35:56 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <20191012153556.GA15972@nessie>
References: <20191012035420.13904-1-dan@dlrobertson.com>
 <20191012035420.13904-3-dan@dlrobertson.com>
 <20191012104033.006b33f9@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20191012104033.006b33f9@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks again everyone for the informative feedback!

On Sat, Oct 12, 2019 at 10:31:07AM +0100, Jonathan Cameron wrote:
> Apologies for not pointing this out in V1 but all new IIO bindings need
> to be in the yaml format rather than plain text.

No problem. I'll use the yaml format in v3.

On Fri, Oct 11, 2019 at 11:11:31PM -0700, Randy Dunlap wrote:
> > +config BMA400
> > +	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
> > +	depends on I2C
> > +	select REGMAP
> > +	select BMA400_I2C if (I2C)
>
> Since this already has "depends on I2C", the "if (I2C)" above is not needed.
> Or maybe BMA400 alone does not depend on I2C?

Good catch. I'll remove the I2C depends from BMA400_I2C.

On Sat, Oct 12, 2019 at 10:39:54AM +0300, Andy Shevchenko wrote:
> On Sat, Oct 12, 2019 at 10:07 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 10/11/19 8:54 PM, Dan Robertson wrote:
>
> > > +config BMA400_I2C
> > > +     tristate
> > > +     depends on BMA400
> > > +     depends on I2C
> > > +     select REGMAP_I2C
> > > +
> >
> > The bma400_i2c driver seems to use some OF interfaces.
> > Should it also depend on OF?
>
> Please, avoid unnecessary and strict dependencies when it's limiting
> the area of use the driver.
> The driver does not depend to OF. Why to stick with OF?
>
> The actual change has to be done is to switch from
>
> > #include <linux/of.h>
>
> to
>
> #include <linux/mod_devicetable.h>

Ah! Did not know about mod_devicetable.h. I'll make this change in the next
version.

On Sat, Oct 12, 2019 at 10:40:33AM +0100, Jonathan Cameron wrote:
> > +static const struct attribute_group bma400_attrs_group = {
> > +	.attrs = bma400_attributes,
>
> No need to supply any attrs at all if the core is doing everything
> for you, so get rid of these.

Good catch.

> > +int bma400_probe(struct device *dev,
> > +		 struct regmap *regmap,
> > +		 const char *name)
>
> Try to avoid unnecessary line breaks.  There are stilly only
> so many lines on a computer monitor :)

Will do. I'll do a quick audit of the patchset for other short lines, but
please don't hesitate to point out others you may find.

> > +		/*
> > +		 * If the softreset failed, try to put the device in
> > +		 * sleep mode, but still report the error.
> > +		 */
>
> Silly question.  Why is soft_reset preferred to sleep mode?

Not a silly question. I actually debated this when initially implementing the
driver. The datasheet describes soft-reset behavior in section 4.9, the
following snippet from the datasheet is particularly relevant:

> The softreset performs a fundamental reset to the device which is largely
> equivalent to a power cycle. Following a delay, all user configuration
> settings are overwritten with their default state...

Sleep mode is the default power-mode, so the only real difference would be that
the oversampling ratio, sampling frequency, and scale would all be reset to
their defaults with a soft-reset. If we just set the power-mode to sleep mode,
the user configuration registers would be preserved.

I can add a comment about the behavior of a softreset in bma400_remove.

Cheers,

 - Dan

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl2h8tUACgkQRcSmUsR+
QqXXexAAn6WqMzmR61/5wDBZCnPZnCbvs880K5bAC0hhlTwqhCdRpMAguG3eOYuA
wEV3sAxYBuZRfbHF2RTVX9X0SBZm3upvKS79KXZepW86Ksr38ih2MhtKvMiIgZuV
wVxhE2yUfJamnzZQrATpTheZLHJEfnUvsnP5SxJi/At/2UeEBZUtUrmZHK48t0T5
4PumqOS2C460mavQE4sWne3afeDrizMH9VLwF6G9faK/o3TZcBjvlEWjrRSznA25
8oXQGOHbh+EenHOFSnDkblEWPTLxcd8iVZkbIHvtpTgLVQ7ZMKh3dKq05N7jlrgZ
7eYYi/KA04VTsqJJ2GAs4paiNUVKbDxwebRb5AqwJSr3O0NOm6zuWc4WAc/G6yWe
TF7noDatfBWCu2cbxF5ukNEQ62gs7H2HvEb9wFfvoM6Ufau44fg5JsQhWb144+8T
ZVMe4UQExdKAVoxtwdijODhQLzkeQsoVB6Zbcs7UgLWjvDCIGcp3HhN5U1KZ+Z/k
HacIvMwTpegBme9wHgnSh0/mwElGPtDWhJoUYDvKxn8VUincQHiuXy67c2ZSETTU
bcEhcLi6dD0tv2OPRlR5chBpneyNDVD6OOjLYXSjaR/Xd53a+YCtCAN+uximSt+Y
0s3RFPM9MJplihfKAuidkap0SBJEyIlJ8Hcj8A5+5vXmc37EKjg=
=KrGT
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

