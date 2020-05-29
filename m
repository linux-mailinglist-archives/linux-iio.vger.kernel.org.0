Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158631E7CF0
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 14:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2MQY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 08:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:32850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgE2MQW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 May 2020 08:16:22 -0400
Received: from localhost (unknown [151.48.140.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA652074D;
        Fri, 29 May 2020 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590754582;
        bh=DzJ6kfKL15s5LpC0JpMAXh9XAb27lOkL6urF26OUm2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpZI7Tw+Tf7yHjxwxmQ/0+bRi2FHu5vPY5bXmIu7cMzkNqPjOKISghSjVtvCGybfr
         4uLZyzgaLPH9ZM5vyFPotOCVj8BcCpWn3xOJKW4Wsy/s7BHkeJvKQSKFdrFJzc0cyN
         /CO6WWptm3/p0FI9Yf9VBwhb3tnmWONPBkVQ6JyU=
Date:   Fri, 29 May 2020 14:16:16 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
Message-ID: <20200529121616.GD3198@localhost.localdomain>
References: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
 <20200528210711.GD5419@localhost.localdomain>
 <3c629741-43f1-3d3a-2b40-40ddfd773e86@geanix.com>
 <20200529074443.GA3198@localhost.localdomain>
 <5bb0fca9-97a4-4bad-1314-1f275ab632ff@geanix.com>
 <20200529085052.GC3198@localhost.localdomain>
 <08c824c2-dfb2-7a5c-b6fd-8258d6ce3808@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <08c824c2-dfb2-7a5c-b6fd-8258d6ce3808@geanix.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 29, Sean Nyekjaer wrote:
>=20
> >=20
> > Ack, values seem properly updated, while values reported to the upsersp=
ace are
> > using wrong value? could you please try to dump ts samples reading the =
hw queue
> > after the resume?
> >=20
> > Regards,
> > Lorenzo
> >=20
>=20
> I have add the raw timestamps to the trace:
> https://gist.github.com/sknsean/1eb3c074d6f2d134632582a4771322bb
>=20
> Both with and without the proposed patch :)
>=20
> /Sean

are these values from the hw FIFO? can you please add sensor->ts_ref to the=
 trace and
a log into st_lsm6dsx_reset_hw_ts?

Regards,
Lorenzo

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXtD9DgAKCRA6cBh0uS2t
rMehAQDWvcFq7ryP9PW20NwtcgwRtuGfwfK5mDNLB1oZt/BC7wEAgXMb/wsg9PHx
pEbZursACRYq+2r6OZMu6+c+F6Qhfw0=
=Matk
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
