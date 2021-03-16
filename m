Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2833DF91
	for <lists+linux-iio@lfdr.de>; Tue, 16 Mar 2021 21:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhCPUwj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Mar 2021 16:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232093AbhCPUv5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Mar 2021 16:51:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D54D64F39;
        Tue, 16 Mar 2021 20:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615927917;
        bh=V7nZ/wUA4PSv3Qcc8nLkGnVR8xNvrXQFP886MTk40b0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r10UtbQbtA6DUDNmcPc7vDr0mvE/boynuT7HHJfqnRMV/J4zzuI2HniOcOCiGwuen
         /mwp2CdVoqBDS7mSwHtWGM0ONyg/IoxAOC0eaxQOWb83iuYnQ18hxixwHRw6YNMlsw
         rPCTmdWhLiUN9YeoONJGmfiOI1EmhbRGf+xykKUa3D3ouGRfyAyDd2QyxVgYEo6xxG
         4lTbkNzFlxPPBk30RGHzRTkmVmMktwC3XA3e67tIBL1MHFizyrWr9Cj2HeP36T9Vw9
         1wmhNZDbpTo7xJ0AjqN8C1PXRPSWeTi2r/xWj2PFV0ggdzwob7mWDJfqhONwgcISBz
         xFadXktdvTB3w==
Date:   Tue, 16 Mar 2021 20:51:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: More cleanup of standard unit properties
Message-ID: <20210316205154.GF4309@sirena.org.uk>
References: <20210316194824.3526913-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <20210316194824.3526913-1-robh@kernel.org>
X-Cookie: Results vary by individual.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 16, 2021 at 01:48:24PM -0600, Rob Herring wrote:
> Properties with standard unit suffixes already have a type and don't need
> type references. Fix a few more cases which have gotten added.

Acked-by: Mark Brown <broonie@kernel.org>

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBRGmkACgkQJNaLcl1U
h9B8VQf/Qt51KMcXwNANHSlYrtixnqP6+Lb7Sy0ifRpBT5ipmyfxnErRzPg8axY4
lWKfoyVrfaZjIvJSLWkXGA2YB3syiY8N38U2qiFV5bTNdquw9GIBpk2OU4K8ffsG
y/jvco6VEzDSViGZrBCW8nH7BsWrClRn625/aObf+hDjAkrJomVKmytp24k0zCw1
be+lcJqINLsEehCehhnwsvmzle7IJU2ST5H7S/tP2v98INu/2GR5i6wb+tcmpLSs
V+r8mEcs9to2AawWshiPvcZOj4Z1Vur5YEyCPF5AYfyZdQXGqVUBO8GfSKVBK1Ra
jpDDGDEiiNP4zATt5sBWFFFGcSLqnw==
=yuJq
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
