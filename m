Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B16927C884
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgI2Li4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 07:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730404AbgI2Lio (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 07:38:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6554921924;
        Tue, 29 Sep 2020 11:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601379523;
        bh=a1gSTFeVH3iQKCsomWRRIF1vuKiVS5UiB6voFxEywig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdzI0LjRLhiFG0H47FIBQWDcq5DX1OrXKHvX76qVWK0yBh7qixa5RtPKtcE8g49eP
         849mw8WVqgX3AJpUqyOH01WQOeFbrbw/M492DQxRltPOst6YZTph/nyc+VD+s81Egu
         Ct3VdN9U6DSJGkK9104YvlYtXkg0L6SNaTM2JCZ4=
Date:   Tue, 29 Sep 2020 12:37:45 +0100
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
Message-ID: <20200929113745.GB4799@sirena.org.uk>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
 <160132172369.55460.9237357219623604216.b4-ty@kernel.org>
 <b1174f9be2ce65f6b5ebefcba0b48e792926abbc.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <b1174f9be2ce65f6b5ebefcba0b48e792926abbc.camel@perches.com>
X-Cookie: I left my WALLET in the BATHROOM!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 28, 2020 at 05:45:24PM -0700, Joe Perches wrote:
> On Mon, 2020-09-28 at 20:35 +0100, Mark Brown wrote:

> > [1/1] regmap: debugfs: use semicolons rather than commas to separate statements
> >       commit: 7f4a122d0b50b40c64d24a5cf7aafe26dd9487ee

> Rather than replying to the 0/n cover letter to a patch
> series, can you reply to each of the specific patches in
> the patch series you are applying?

> Otherwise, it's a bit difficult to figure out which patches
> you are applying.

Feel free to submit patches to b4.  Ideally things like this wouldn't be
being sent as serieses in the first place, there's no dependencies or
interactions between the patches.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9zHIgACgkQJNaLcl1U
h9AUrQf/V6+K22eTWHbMJo7Z/GUR0aZ8ZbPiLfJjhWnbSq+gQVC1xnbSwQx7hDlv
+AoeDaVjgmnGS3YtW/c1K8e4d2SFvxR89a5I5U/dEtc/j/N/5vnGgwxjLDfN5xUC
lV2F+ftiHGIRzn0ojcUVOj6hEIqnGvkQe17key6Po0TlZuuoZE+eh3mfbajDeYCs
/BJ39skDi0g8xqOY8V8qZAoH/Bowz0xIroEbdg0zbM78UIOi2Fzxl5MSXapN2Cd7
o9QO7lsPCWxberp7ZwIUg6cvYQnjBE4ZZRGsfnzuPRH4fptLRzDSZRJCSW6IqH8s
j8rUaeCv+XQBPjpBvj3FJIUWXyI5QQ==
=kEnh
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
