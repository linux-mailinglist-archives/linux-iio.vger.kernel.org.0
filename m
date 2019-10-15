Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B210ED6CEB
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 03:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfJOBcf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 21:32:35 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17480 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJOBcf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 21:32:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571103143; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=fQe3SUtVLWyArmDxIaOgAZ87/LpCghdwOqhkrdv9USl0bckrWy/iD+w+AhTdNSwmT3ns81f1COzo1/dfyQ/P0ts7h+QJIPNB+dCk9ZntCcAa94lLDXZRp7KxVrqGzTKTj5W/Fg/WUe+KQ+f4+NH3ShZbYK0QsDGNVDk4ikrPsTM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1571103143; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1XGFFlKtZ9jhKURStoDOqZlNX+HfNJjwr20EIbnsVo4=; 
        b=M0OZHeoJz4dUmwFqSI8fHIx9itwyxYUQUPvH2AXp5B2aspHHinovG3K1iMO36ZheJsPFLUlD6s8EMx5mwP2Q3V50hT84VAMKJ4feKuF+ifyLp8/am/i7qaqlakOS6dcD4gRaGi2HwVfQYH0SKijBQgod2d4Ldhs8zGMD6jSByXA=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1571103141913682.352444499071; Mon, 14 Oct 2019 18:32:21 -0700 (PDT)
Date:   Tue, 15 Oct 2019 01:17:50 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191015011750.GA20979@nessie>
References: <20191012192525.21040-1-dan@dlrobertson.com>
 <20191012192525.21040-2-dan@dlrobertson.com>
 <20191014171521.GA29335@bogus>
 <20191014172731.GA30646@nessie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20191014172731.GA30646@nessie>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Thanks for the note. Should running `make dt_binding_check` be added to
> `Documentation/devicetree/bindings/submitting-patches.rst`?

Sorry, I missed the `writing-schema.rst` documentation.

Cheers,

 - Dan

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl2lHj4ACgkQRcSmUsR+
QqWOQw/9Eo1Q10BBXWVyP1OId54T7pXJDI7zFU0zyKjpPZblkcIr8j1zY9xcW21l
X8A7bUZ0X4cMh/f56jhjnnp0bHZNS8mNbvqUeWM5Z2ntPq7uKmd6ag+bUYuraxrK
smqbPYai8RrVMtTtGrJQvsZIZyvQ1Upppa1XIctOFbBxXot6Mvp9lYWiaOp6jeHe
RNIhWCWVHyztekQGbdrHU499aF2xIVvuU0torqaJC8UVbdDDBitpxA2cOFkuOuQi
RzruAEOywfxx9oR076KstPtgGBKT768NF/BFstdGqMxKBac7aqWU/kOvyBUE/wkw
AMEyWBBuNmSgWRw/kFBtB8OkVkOt2qDbN+085SgzgqNgil0tBfeBQ0jtgN2tdPy6
G2zfwD7RjpxAadyJ7TiA989sbvA1GMmzbjBTCdhwUHUFGnhHi24mVKCWw0og9xdJ
/TRxYjGisSz5Qsk14vmMBw1bE73giKghMq+gDdHWtqERDvbEY0h2sf+omVkDWC0P
q0R/yjsqETT/ALGwI9IM2M9tgCy4OYm+mxHLKcWGWzW0G+jkT76Xf+ITXrEMoesT
WWUNgGYe8dvgIohbtOVVNmzeNgBa7+WKMhdvQfjcPu8hlgwgwkh0VimP9ugiA/D0
XGIoQrL6jldP6QGvIIkvhtiFcCkfGfANhy8J2HU5AbIbgM8g0OQ=
=ANkC
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

