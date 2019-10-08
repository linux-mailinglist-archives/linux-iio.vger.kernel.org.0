Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977BECFCA6
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJHOoO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 10:44:14 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17478 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJHOoO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Oct 2019 10:44:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570545850; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=XRrV7pyCThipqclKUM2Ky5bqi/GNdFf7j9T/FxLOeVPVsDVbRQe9gJ99QnAdlOF5ahFAbNMx2wyPiJZt3OWackGod/nhYIO5r4bFJp/7Qm9cucOHXnob5W9fV2kHpu//OF7I/HDTXzYnLI4nZA4GqcVq3jcfO/PXmRRge0LftCU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1570545850; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/JtGJI/LSl4yi67OOHIZfNwrdK+iHIc6JyX2j7v59Rs=; 
        b=MVRxIK4yi0PF44rkH4ipNGFNDZTD5y2OU5Wm/ILPID/DENLFJlZc8MmeJSy4lLI+W0dxSHbLLuQar4t9YhIp8+cr6T1I6djRFglvURAAaMROmZ9FThRpDJNLbBYUNxnFUBwvhd7y9uWg1eVp9WgwuE6JC3Yfwj/AGeAxGNbD00c=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 15705458495321015.360847600824; Tue, 8 Oct 2019 07:44:09 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:29:46 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: (bma400) add driver for the BMA400
Message-ID: <20191008142946.GA7784@nessie>
References: <20190925013941.20431-1-dan@dlrobertson.com>
 <20190925013941.20431-2-dan@dlrobertson.com>
 <20191006093754.61a12172@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20191006093754.61a12172@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jonathan,

Thanks for the review! I _think_ I've made all the changes you mentioned
locally. I'll run some more tests and clean it up a bit before submitting the
next patchset version.

> So my first thought was that Bosch have been moderately good at keeping their
> interfaces consistent across generations.  Seems not this time from
> a quick look!

Originally I had hoped to extend the bma180 driver, but there did seem to be a
reasonably large change in the interfaces. I also hope to add support for some
of the newer features and SPI. I think it would be possible to merge the two
drivers, but I think it would require pretty close to a complete overhaul of
the bma180 driver. If this is something you'd like to explore, I can probably
order a breakout board for the BMA180 and BMA220 and work on a way to create a
driver that supports all three.

> I'd also expect a modern driver to have DT bindings.  Might let that go if
> it was being used with ACPI but neither is true here.

Good catch. The DT bindings will be very simple in the initial version of the
driver. I'll add the bindings and some documentation.

> See the docs for struct iio_info -> read_avail.

Nice! I missed this. This fits exactly what I needed.

Cheers,

Dan

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl2cnVUACgkQRcSmUsR+
QqXyLA//eu9Q/gGMKF3BqJN9CTa7BhBQaCeEjUJ9R9mD79eaF7uOXJ+wgUZwSFtk
0VtFigIzrigNGiZX4h21kqGf5zKaYUEgQZXaA4UbRgEwDVGQXqe2p4SidEWRh90K
KcD/AO4fh3DlXipMH7ZkAzfLDPnHqf27b0W759prlrgYYIYSjZUIk9YKoIVSHFlJ
i8h6/nsvqMWMeGM7z1W4ZPU3KmSM9jr+mZXPKgdooan2cAKk0FuZwQSLXhnRDi8F
55MaT1Syr9BwOKTDX8K4h4K9UOwo7cFPqo24Ihwa1vDT2bQLK8e4T8K/GbcybfQd
cAvI5VOdS3f88DF0cGHNMrPLd25yzahu5SINI7oAqrUtXhKsoxg06AFR4R3UtH+u
uYtQ37aqbz11awHmA9rJ5MSvoTv6KrA8wsEwu/gk+QGM6Hu5RBX1lCLcGCeNt766
yfk88E6PtLkEofn1Mggeb+m3+jEHNl2ezy/jFjY2hytn269A0INgfWIz1YeEsmx1
JJT8MnJvYRWG9X9Sumcss6ExnNqRY6XDtaS/iGQoeS53r+yDjezwdoKhmuFpsnXu
l2ObWLSmoUN/S/E8jjoo8jWYlgfvB2IBl9P5krUq1U3ZI74DT0Ziwa9GsjwbtM2J
8JXOFHYJXOAXfOaGsvzfgYC4ZK0UBr7fK9hLvud9r2bDJXn+o+4=
=hT/h
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

