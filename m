Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF45727FDFE
	for <lists+linux-iio@lfdr.de>; Thu,  1 Oct 2020 13:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgJALCv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Oct 2020 07:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbgJALCv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Oct 2020 07:02:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93AE20B1F;
        Thu,  1 Oct 2020 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601550170;
        bh=xYiMC3INrKF34oEyrsmUUrqjbwI/zSijaQlQHN9HorA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KEei53PbBIIkdzQLDb/7K/52YSbflBQYn3bG/m713eKa8/9nV0fPPDI4yq6H+/fvV
         xVqht4hR38nzz4Qgnh/AAp0mk+5WyFzIOOYfEFPMoUP75ral06RLc43LxHUnNG4hb1
         tZZP4hijlYOR/icBsCoZV1jH7RB2VuKegMZKFfws=
Date:   Thu, 1 Oct 2020 12:01:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-acpi@vger.kernel.org, David Lechner <david@lechnology.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
        openipmi-developer@lists.sourceforge.net,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-ide@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-wireless@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate
 statements
Message-ID: <20201001110150.GA6715@sirena.org.uk>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
 <160132172369.55460.9237357219623604216.b4-ty@kernel.org>
 <b1174f9be2ce65f6b5ebefcba0b48e792926abbc.camel@perches.com>
 <20200929113745.GB4799@sirena.org.uk>
 <db26d49401dc0bd6b9013a603a155f9827f404a4.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <db26d49401dc0bd6b9013a603a155f9827f404a4.camel@perches.com>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 12:33:39PM -0700, Joe Perches wrote:
> On Tue, 2020-09-29 at 12:37 +0100, Mark Brown wrote:

> > Feel free to submit patches to b4.

> Have you tried the existing option to send
> thank you's on a specific ranges of patches?

I am relying on b4 to identify which patches that I've downloaded are in
the pushed branches.  Given that it explicitly lists the patches that
are applied it appears to be doing an OK job here.

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl91tx4ACgkQJNaLcl1U
h9D1IAf/a6Dh+mjW+LjpuCd+hkWCJa8iJTLmYSy9suf32mX9fM1T/gbOLQ1RJtu4
ZQP0A5w52htIbRIWtYHrgtZQGXrq2SIm+peRmnKP0DXly+Fj0/G0zxg4lqxKzXtV
+XpQjLbvcjF6JIV1ok5ScRg5HH8bfLJQvbGBbpmL9pvI+WniF4smB5bQRwd3qWEf
MrBNI79S+kr1Cvjxnya+/TP7O4TtOQzzpB695ejEGvqxlTJQM5GGaZTLNJlBivOz
ygXvOFlrffOajvN1K7URe41xznaDG4+c8pfziFXllSoEGp3yzANBNTtCGEvny0SY
Nx0W3O8/sebfFJPHQ89w2atWG/nVEQ==
=onQ8
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
