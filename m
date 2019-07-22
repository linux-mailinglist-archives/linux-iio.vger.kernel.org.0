Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206F96FF53
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfGVMMD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 08:12:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfGVMMD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 08:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S4t16HIUPnCbhziqB2+zkxTZKxU7JFhv2tuj8/RBo4o=; b=SBg3FViA4rjUMwkAkYeYZOmjX
        ORXJPv5gcs6T3FhnWx44QwXRbXKamdzPTMCjZabb1SmzYWSJTGDt3saQhD8qWuLbbiwh2Cplv0WNG
        Y+6urRRP6EaXCchNDqpKHBmLFDaKrOeLY4v2RME6+1vhDhJjw5f1B1ancNKSVJcyepFxk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXAV-0007Zy-S6; Mon, 22 Jul 2019 12:11:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2CA022740463; Mon, 22 Jul 2019 13:11:51 +0100 (BST)
Date:   Mon, 22 Jul 2019 13:11:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 04/22] docs: spi: convert to ReST and add it to the kABI
 bookset
Message-ID: <20190722121151.GC4756@sirena.org.uk>
References: <cover.1563792333.git.mchehab+samsung@kernel.org>
 <be171b438013f8824425595e3d637f5e7d466249.1563792334.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
In-Reply-To: <be171b438013f8824425595e3d637f5e7d466249.1563792334.git.mchehab+samsung@kernel.org>
X-Cookie: No skis take rocks like rental skis!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 22, 2019 at 08:07:31AM -0300, Mauro Carvalho Chehab wrote:
> While there's one file there with briefily describes the uAPI,
> the documentation was written just like most subsystems: focused
> on kernel developers. So, add it together with driver-api books.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

>  Documentation/spi/{spidev => spidev.rst}      |  30 +++--

This is clearly a userspace focused document rather than a kernel
internal one.

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl01qAYACgkQJNaLcl1U
h9C/jAf/aVqimYa1UmKiGKUzAjJ7xHpCgN2Jv8reBvmRUujt0MfS8X11JQpMJ2vJ
0/i4Tng1d2SSKYBZIEcRezqYBu5yIK2UQ5UKUqPEeqb4jpv5LEST5SGRt/E5O+dr
4F5c+9eMguLuls6dq/jd9FBggEO9o4NLwolSsQgLJvgzdezT/VmHsXxhInqQMoKA
TZj698Au2qmpfL6OEuT6GrVI3aMor4EJyWFqMQH3mIYTMzCj52dihXLKdOFvzxJQ
qMk4sVMckaBbd71/B/XDG1+YKZVECMBx/tErZDUnVEQTIzIMJhZ3HduVscuWXA1z
KyUgiOx/PpAD5PcF1ldmQYQfT018ig==
=2J7c
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
