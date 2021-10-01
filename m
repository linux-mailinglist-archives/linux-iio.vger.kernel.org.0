Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0402E41ED40
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 14:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhJAMWU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Oct 2021 08:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230498AbhJAMWT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Oct 2021 08:22:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 737A0619F7;
        Fri,  1 Oct 2021 12:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633090835;
        bh=+xzFgefDRScH/Z4Vj5bFVrab00uhlzlw2k4c0w7AdzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPdCkCA1VisIueGQE6T0zdhB19ry1JKu8TavGxutZvYOnAd6QTtzUaTZMaJLZaDMX
         BOrIbP4z6vt+lywp2Xbm+uo3i/Kqjb8Z51L4gYaI+YtdOajN6WIJFPeCf31lhboPDD
         OpAY6cnTODcRJk2HxhSFw14aIDcOjfZxjLddq2n6/bFmVu/x2CmNOHjpP+iTH/wh7t
         XbO/GwU6pcyFvD/yvveB1h4nPks0zoxGaesbYasSw3IL0FpQ4Tz5ZqFOxdVPa3xh1P
         q2FKZbf8vtd5xf9we7JoAQYPlZrms3Y2I4uvwJ40aVoYOh13yfxbGlVw2L61v+xAAl
         CSYhj6zxCY92w==
Date:   Fri, 1 Oct 2021 13:19:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: st_pressure_spi: Add missing entries SPI to device
 ID table
Message-ID: <20211001121944.GA5080@sirena.org.uk>
References: <20210927134153.12739-1-broonie@kernel.org>
 <20210930173852.208f1815@jic23-huawei>
 <AM8PR10MB4801DD2B605277F3D97CAF87EDAA9@AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <AM8PR10MB4801DD2B605277F3D97CAF87EDAA9@AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: "Pok pok pok, P'kok!"
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 30, 2021 at 06:35:23PM +0000, Denis CIOCCA wrote:

> I am not very familiar with how much the kernel would like to keep 'probing id' consistent. I perfectly understand the value of doing this (maintain ID compatibility) but I also see increase confusion in maintaining half in a way and half in another.

The goal is not to maintain compatibility, the goal is to be able to
load the driver as a module on DT systems.  For historical reasons SPI
uses the platform device IDs to load modules bound with DT, if there is
no platform ID for a DT ID then userspace won't be able to find and load
the module.

> I personally think that we should drop the '-press' thing for all the devices since they all are single-chip (meaning that the name used identify univocally that is a pressure sensor).

The DT bindings are an ABI, you can't really remove compatibles only
deprecate them.

> If you think that compatibility is more important here, I think the patch is fine but this should be done in the i2c part as well so that it's at least congruent withing the driver.

I2C doesn't have this issue with modaliases so it's not an issue there.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFW/N8ACgkQJNaLcl1U
h9DOvQf/czx32Hlljeb7UZKE5kg0nBQdOFdZbfsUdeGomrL1YWU9p4QH7uEqCSsT
vGpW0Vz0BBiLsaboTjRGlDSx4e64mPF2tX9QtUp1usJjGqQVNMqhHsxfQIaysSvo
8ExN0JXqyTaItKKvqMXgR+Y1QRpZv7+4IZ+sEcoYKHl1zOFanacrBLWQz5KYhloI
5OQKx+UPqADqLsYI0Yb5CrnLN93224M4YBusVkq1kWRLpKE85SKbCwtrHi6TM9eh
mIuTWADFsm4j1Fuvyo73o03gWLZ8SUbmXek0m+8Zdelmn/0cQirAT58YF5M5p26i
QN5CBATKqDNXXoeDV+GAhKOJATBRCg==
=HXak
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
