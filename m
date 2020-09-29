Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562B927CCC4
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbgI2Mij (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 08:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732771AbgI2Mie (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 08:38:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C452075F;
        Tue, 29 Sep 2020 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601383113;
        bh=1agHRxXJKhB2RD26+gZ4x8RWV4EKhITxeEYpiuBbO3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWmjA8UFdsFWnaqLQDJfMWuIbOP31zKYrwaHNjRkhgkkbyol6UJQNOL2g65mEmM7z
         r3wh0aEAIXzhRSusZ2U0MLVqmtsLu8t/8GK56UP3hceV/6s4ECE+CCU/O8tZzN6Rvf
         K42OX9LCLHmQUHnGEYx+BhHjmTGzPz+rvHs8rKnU=
Date:   Tue, 29 Sep 2020 13:37:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
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
Message-ID: <20200929123734.GC4799@sirena.org.uk>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
 <160132172369.55460.9237357219623604216.b4-ty@kernel.org>
 <b1174f9be2ce65f6b5ebefcba0b48e792926abbc.camel@perches.com>
 <20200929113745.GB4799@sirena.org.uk>
 <alpine.DEB.2.22.394.2009291344590.2808@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2009291344590.2808@hadrien>
X-Cookie: I left my WALLET in the BATHROOM!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2020 at 01:46:19PM +0200, Julia Lawall wrote:
> On Tue, 29 Sep 2020, Mark Brown wrote:

> > Feel free to submit patches to b4.  Ideally things like this wouldn't be
> > being sent as serieses in the first place, there's no dependencies or
> > interactions between the patches.

> It was suggested (a long time ago, not with respect to this patch in
> particular) that sending such patches in a series is useful because it
> allows people who are not interested in the 18 patches to skip over them
> more easily.  So there are two conflicting needs...

I'm not convinced that there are huge numbers of people reading LKML as
a list TBH, and if you are sending things as a series then the way
you're doing it at the minute where you don't CC the cover letter to
people makes things confusing as it's unclear if there are dependencies
to worry about.

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9zKo0ACgkQJNaLcl1U
h9BJ9wf4mEIT3UglAONn9EPv4I6DolXuWfJHGs52mxyy1JeuXGyjVMYRuKfw8ZE5
TbgRR0pAg1aZUsqI/T/PWSVDmUCNzL6QM4RbG8ZUSFw47v509iCABBidbK+PLnwo
y5A+IrAPTDVviLFNJm2SfFN3XEgpsGmOqhyuhKiGNeLOryaPNvOmiRF6cwND7Vbq
97kDmafX0KgHVsmK/br50D/XJpOJSR9T2hB5hjQRoVl44a6aV0eZWwDDZyH57kat
KO59OyGGHDyWrsF9oHWajymCB1kMZZ4YLiwCyjx98g74uRLSiSaGwrsr4IeXGn66
Mmpn90mfVDnP/Es10vbKsC+JZShG
=qH7V
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
