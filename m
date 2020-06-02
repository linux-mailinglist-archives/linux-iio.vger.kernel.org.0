Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3AA1EB378
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 04:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgFBCrb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Jun 2020 22:47:31 -0400
Received: from sender4-op-o17.zoho.com ([136.143.188.17]:17799 "EHLO
        sender4-op-o17.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFBCra (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2020 22:47:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591066024; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MJJ5QKfrJFjnTYM84/HZGbFVeGVgA6GxzNT7SQN4uT+VGoHJXkQ1xn6oVm2H/nF1IjfKPFO15j+zqUw9f28ojq9AU0NWfSQt5Y9g5zt3h21osC6OjRvLxHuzhwZt4PT6bs9er5eKQJ11T3Dgpx8gZy3Ja6Lw8pSMa8Ae0r1RHjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591066024; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=5Le+vCqVpMITTbs0qSlK5KfKRHD4qjAERmXAasge8ko=; 
        b=czm7okk8jHdkusGJRYWA7Cy8U90jcyUa8NuXaovtMixdpIQAvrEHFj0ic2BhTzj03EebNuPxSee0X1edqq5bG0nsy9hftyzFG+2v+FEp1mfMlCiUvBcw5WI7bGTRm3fSQHDtu90oztNmjdnq2H5lG+e7YR8RBg5gGiwoPCay9AU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-108-48-181-150.washdc.fios.verizon.net [108.48.181.150]) by mx.zohomail.com
        with SMTPS id 1591066022393356.62204498834217; Mon, 1 Jun 2020 19:47:02 -0700 (PDT)
Date:   Tue, 2 Jun 2020 02:46:50 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iio: accel: bma400: add support for bma400 spi
Message-ID: <20200602024650.GA16553@gothmog.test>
References: <20200530191010.4302-1-dan@dlrobertson.com>
 <20200530191010.4302-2-dan@dlrobertson.com>
 <20200531101024.69918a76@archlinux>
 <20200531101345.2e50720b@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20200531101345.2e50720b@archlinux>
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2020 at 10:14:06AM +0100, Jonathan Cameron wrote:
> On Sun, 31 May 2020 10:10:24 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Sat, 30 May 2020 19:10:10 +0000
> > Dan Robertson <dan@dlrobertson.com> wrote:
> >=20
> > > Add basic support for the Bosch Sensortec BMA400 3-axes ultra-low pow=
er
> > > accelerometer when configured to use SPI.
> > >=20
> > > Signed-off-by: Dan Robertson <dan@dlrobertson.com> =20
> >=20
> > Hi Dan.
> >=20
> > Code looks good, but one suggestion for a possible optimization inline.
> >=20
> > I did wonder if it would be possible to use standard spi regmap to
> > do this, but it seems there is only a single pad parameter for both
> > reads and writes so that won't work.
>=20
> Changed my mind.  See below.

Yeah I had hoped for the same too.

> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.

Thanks!

> Note however that we should add spi stuff to the device tree binding
> docs.  That can happen as a follow up patch.=20

Will do.

Cheers,

 - Dan

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJlBAABCABPFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl7VvZgxFIAAAAAAFQAT
cGthLWFkZHJlc3NAZ251cGcub3JnZGFuQGRscm9iZXJ0c29uLmNvbQAKCRBFxKZS
xH5CpZlED/9abWISN0gTSOQ0W+/GbkyytJi9xAUu2gRVc56JUXG3kT4hOce/300z
8faRR4et8YmtAvnxZCT7EMOJF4Jr9iCsvwj/Cmu/HwnPIGq8RFX/UbxtCnox3xWg
GUNV8QRU1mwUsoCj9caY91geQ/s0ZWBZYeoF0gnkrxVMVFEhrovHXskEnVRBs7t3
I0n4UMeEXKPRPgp0Yg2561hl22gXERd+OXS1wODG+Tts+BZ3V2zMATscjTDZC4r4
2B89ib3Xn8CJ5fMTfYuEtcgFoIU3TjYO0el8SzP8ho+pIuwOZophZnYzO5wOy+vE
sQm8ncIc15ofbodLb3yWwPfNQMQjP2l6Kfuia1LzyZCZBHprpqHIzDIHGsfxIkMt
DPtSQKzXyPa9RP64yqQj5nJa2bD9tvQFBT9pAYbxVbhCP/KwWVCSlsjQ60DhOJMY
3FZLv9NllpdnXCceTUNerrLIWgmgvhObI2a5Mt5HZr3RN6Ap8+gP6h75K97EKJ1h
Q2wcN4ah1h4gU92+CRBeCmZcQ2Z6u9roDJuwiDolFrD1fI0Du/UJ4deCPGWBY/po
lT1G9dlFLbZGFuyVP7+9x0o17Z+y8h4o64S4JUNLTfKIMqbf3+fAennpIVOtRGhF
twaTmhGMUlxDKuPnxfHoXr5zKibFskzDXgEHpqnNZEz4L85k+Yhh7Q==
=hL4u
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
