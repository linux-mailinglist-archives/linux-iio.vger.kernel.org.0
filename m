Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9FC6CE44
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390104AbfGRMuP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 08:50:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54764 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfGRMuP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 08:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cEKz6vzhG50bLPrFj2nQ+q2iCqfHJ5p08/faFuU/tmo=; b=GkRibwu+YUKwTy3cvBnatmb2D
        FD10UfEpSVZg4jJPngQlitY7aA/iWbv18ZQaXaLcxpyYbpNkX66qWKc6LjwyN9nenTpPt1VSAbPp5
        3qdSEVW2GJBLOTnS+rrdpMgZ5BFMCxHAyzCvnzvSZY/2GQQiNPjsoE1+J3mp/bZN76DRg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ho5rN-000564-HM; Thu, 18 Jul 2019 12:50:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A5E4C2742A55; Thu, 18 Jul 2019 13:50:08 +0100 (BST)
Date:   Thu, 18 Jul 2019 13:50:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/4][V2] drivers: spi: core: Add optional delay between
 cs_change transfers
Message-ID: <20190718125008.GD5761@sirena.org.uk>
References: <20190717115109.15168-1-alexandru.ardelean@analog.com>
 <20190717115109.15168-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <20190717115109.15168-2-alexandru.ardelean@analog.com>
X-Cookie: Oh, wow!  Look at the moon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2019 at 02:51:06PM +0300, Alexandru Ardelean wrote:
> Some devices like the ADIS16460 IMU require a stall period between
> transfers, i.e. between when the CS is de-asserted and re-asserted. The
> default value of 10us is not enough. This change makes the delay
> configurable for when the next CS change goes active.

To repeat my previous feedback:

| This looks like cs_change_delay.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0wav8ACgkQJNaLcl1U
h9APhQf/QOouOeq0OOWIhFy4+/g0D4HdPXY0lzPOPRqIa3No7BWtewQIntQ7uARy
/6nZrCA4lT9IuLtQY9TtxBtY3GyY1hLyWXnibxUsD0vZqS7cBjvVdYYv9/FTdDEK
VquUng/K54Vp6Ku0GCfh9EXhEs05w/L4B1cWa1r7FD6gbF5llweQ6A/JP68B2Jzl
mAj3fEjb7brceyU08UiJsfDCIehvVc3vpu5wCyFFj0FzGhJ+IfJdAmFn7C6EmotF
CM8deV1NaeQB0iUkCSVgTj+pBG4UZ0hj0CGju8xXxE6/f/+1BgBp6EpNZj1Tptzg
XIBZ7Xf1k9oTXGZ+05q/wXtv2P9N+w==
=liAJ
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
