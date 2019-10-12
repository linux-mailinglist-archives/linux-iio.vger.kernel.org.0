Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0EED528B
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 23:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfJLVMs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 17:12:48 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17415 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfJLVMs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 17:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570914750; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=jSTxJ7kPuTh8aGmoy3IA/H01K5kTW/Kyfjo8Q0F4N2J2X+AAeN6y/w+xV5n3G5ShF4jojCFRiMCFhhoek5ZWFqVNx8C2Z7MHr4DzgJkCxmni52HRPHOFjQSUq8PdGsuklHlvhXmsbLrQgSLRAqGvqs2fBVd3TD02ZgkMwdYZdAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1570914750; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8/kaIE4NfI4XhvoyRoRN1pVv6GqkrxUXGjoHgdIXfKo=; 
        b=FwyWNr/UGBYYORKVZoKVmCqway7gQaZPyvdjEBIPd97KRpXE0q+qRLzrTolr9vVvUDWGTFgsgMm3kSYXfWuhXCXFgI33Dafshae5IAFeJbeAY3cIaUW0LRdqH8e+YyAf7grY6P8T73wMqJ5Ir5Ofg1Np2dCedZioDRlr4SSOOrY=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1570914749773563.7230504150479; Sat, 12 Oct 2019 14:12:29 -0700 (PDT)
Date:   Sat, 12 Oct 2019 20:58:07 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <20191012205807.GA20156@nessie>
References: <20191012192525.21040-1-dan@dlrobertson.com>
 <20191012192525.21040-3-dan@dlrobertson.com>
 <8e55c408-acd8-0e8c-38a8-e48406b8bce6@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <8e55c408-acd8-0e8c-38a8-e48406b8bce6@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>
> No comment other than thank you for ignoring my previous comments.  :(
>

Oh, no! Sorry, it looks like I missed you in the To and CC list in my reply :/

Cheers,

 - Dan

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl2iPl8ACgkQRcSmUsR+
QqVqFg//a2/lcbkBGgRYzLWGjBu12JMaS4hLb3eEwFByZbaZ+rQyjRRoKw0IDIEF
hKVO2ZpzUcwQW5A0LYdvgdKFSjI0GDm4lmjLUe20HB+7VeMiqcQZcs3bTnVCwDNn
Uvat+Lr7yWwZZMFD+tbVH/IDQynjXaTZeMrnCMs+bVSyjwCs0z5457lvbzGEEROs
RcRzWmDNVIg1bX+b/UAlVfw205q/s7JO6t5mwtCnyeHdO/BYegIgYTsXcx7ZFds7
P8ol09daL8Llws1f6ldx+XNX+RNRDGuSA2vjRwkkvDJt3FcwEG5BDXJzBDB2DNaP
Zn/bE+eqIoeeZY/2MXXuiZrokEbmxRPeqCkSjpjP0OIA65lcw3Ww0/GWdDSI45Ci
rQEEouZ9l3ZZx8mT4cAvZwliPpuIpMd50k0ZX40pONwG0L8NBFE60pYFJS0YeB93
jdGSIP66mwobMx3CRx1DjQQr33yaYCgSLtwC+HuVHuT4ZBy1wzCuUcS6vR69/wr4
ahyjufhsy6cuGsBN4H2YtHg/msEGoaQTjGek86VKfE4fuS1vydx8QQ5F5B0gDucm
MPqcEfKhVQaSvh5zVJ4hU0cmIJeFp6VKjLRKfqWfT9f+zaPb4+LwAGqp2MOYZScb
d9Zd1wBu4oIOlvhjPQpWEw+a9VFfGi9p/etphoYcXM17W6iOY4k=
=vj3G
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

