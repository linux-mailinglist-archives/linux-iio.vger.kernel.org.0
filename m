Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94068D68BF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 19:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfJNRmE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 13:42:04 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17433 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfJNRmE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 13:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571074914; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=UoaKiyg+jQdvyC/HhihkyXN4vATpVe1FzZda6S9x50vCOlNQChj6l5iHpkER9D0llDqinnyxy87QDh7AsSbYI1R6tUS+Yc9N7XUd++mhMtwEWC+9LCdXQcb9LeLrP0ZdX4fxoCd47YXj6CNUBOKbiY5hUS2bVtB9waqVcpz06YA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1571074914; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=sz/CQBl0duYZalGaCIYiBg7xruUCOAaCokFPhXphtJM=; 
        b=MIsc+Kk2VqXzXnM1/cUjHBsaqsKYgb2HxWrSK+t+42eapnh/VsbfRGsIXElno0vaxJa1iowXYn4GToHUFGt38z6/otN6+GyHtkfx6HBY0NnXaSehiir4wtcEnVozzp+HZhYuTXTAL9zh1KqHpQPbRvGTTnuK/VaYCyvTnxwobak=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1571074913103134.03014784679272; Mon, 14 Oct 2019 10:41:53 -0700 (PDT)
Date:   Mon, 14 Oct 2019 17:27:31 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191014172731.GA30646@nessie>
References: <20191012192525.21040-1-dan@dlrobertson.com>
 <20191012192525.21040-2-dan@dlrobertson.com>
 <20191014171521.GA29335@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20191014171521.GA29335@bogus>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Fails 'make dt_binding_check':

Thanks for the note. Should running `make dt_binding_check` be added to
`Documentation/devicetree/bindings/submitting-patches.rst`?

Cheers,

 - Dan

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl2kr/cACgkQRcSmUsR+
QqWFXg/9FsPJaiW55rPeVJ+BAFKW2BQd/QKN+TynZB/aEydTO/ohevd2G/u2C2Ak
4z1zFgAqBumsGcEeoy7P1PpIaqLiJ1WBOr4H87bGGIRvjHvyTVStldh6hIQ/k7PI
WbK9+no+FJ/Wwjgdcyty1Ni6lp8shMtJexTynIeymvYPKnC9LvdUp5buGe7FylRS
F69iFget4xN9QciFFr27mq0wx+RtSOM5L42stvTjz8SBj/TMTUt9ROuwgr3TlPUN
lUJT+nOQAhZZPT4vXsAgte5D2Fl+KmOi459cmqoshotihZnmZRmWYgLHpKFM4dju
AEl4acLIMopFdBM9jFBJCLBb/lQbIlX3mf4E6rR2bBGt49Vc3x/yGKgddj9s+wyp
8Xq5rlAplIZf+enrooHLxAXeUM2I1IizdZooGFY00zAXo7ZxpwNcyvL2g4iC/ezY
wuNjaKuboGWCLbnKYi5CJrTSTUSt8pqVH+KFm58W5gPQrW2ZwFilDZYs1ZqM2inM
/hhGAgBHP0U7p7cQZr4jr+qp6Idinns3RQCsYcZv1iRre4MSnmx3B5i7iOjjzlcn
HCofz25ssaz6fDOA1bRhl6bhPhlXeQ5JGc+q1ELIp4Bawoc/05LtAPznIOlBEEqj
UMO5CAycCKUG5FdtrTLXOYaHOsYHM9biuBKIuXd/ZxipDQ/VSQA=
=36QZ
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

