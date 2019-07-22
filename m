Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DF57057A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 18:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfGVQcJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 12:32:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54876 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbfGVQcJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 12:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m8yZMwUEiFcccV1SSNyMVjuNbCe2CWQuQkyxqZQmz/A=; b=XDKGkgBe4UhiABZFc+jlkWPgv
        IRYyV0OE3GgSpmospTKxfgN3IIF1fRIZAQbQ80NQqoYjXS4RJ1tjX00qEGdgQhsourEy4GVhJ4MC0
        VBXWaXryk8xLmDNTgkZ4zgaXagftmA07e/ooktiXKx7PYDCqk+nOJhctcnbU6sKqne3o0=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpbEK-0000DV-3R; Mon, 22 Jul 2019 16:32:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D594D27416F9; Mon, 22 Jul 2019 17:32:02 +0100 (BST)
Date:   Mon, 22 Jul 2019 17:32:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/4][V3] spi: Add optional stall delay between cs_change
 transfers
Message-ID: <20190722163202.GG4756@sirena.org.uk>
References: <20190722124747.4792-1-alexandru.ardelean@analog.com>
 <20190722124747.4792-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Content-Disposition: inline
In-Reply-To: <20190722124747.4792-2-alexandru.ardelean@analog.com>
X-Cookie: No skis take rocks like rental skis!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 22, 2019 at 03:47:44PM +0300, Alexandru Ardelean wrote:
> Some devices like the ADIS16460 IMU require a longer period between
> transfers, i.e. between when the CS is de-asserted and re-asserted. The
> default value of 10us is not enough. This change makes the delay
> configurable for when the next CS change goes active, allowing the default
> to remain 10us is case it is unspecified.

For the third time:

| This looks like cs_change_delay.

>  #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
>  	u8		bits_per_word;
>  	u8		word_delay_usecs;
> +	u8		cs_change_delay;
>  	u16		delay_usecs;
>  	u32		speed_hz;
>  	u16		word_delay;

This patch doesn't apply and even if it did it won't compile because you
are trying to add a field with the same name as an existing one.

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl015QIACgkQJNaLcl1U
h9D5fwf/Wo4+Hmy98fxnDeg7DpbiGSC8Ran91cmRVruDQ85ReTVXSyjGLF7QuDPU
h5eXuOE2jwzrDrqVmX1CK8kXQCF5k9I9SiLWZZlPBxVAFGQmOBufa2voUWHN3zr7
lhESGw8Ayl7JzHYF6KRvtGSIFq5vJ2fhLLFH+lDZ0ewq7A92U99OqyjaZD0gZCo7
Nb3YJ2wASgP37haiibEHvpddA585QtGgcCjqdxybeoIxAqkez/2RTijc3DBRcXeb
VsseUyF20RRXnICBpBgUnonhzzwN7jwf1VIOM4aKGiWIIXGRqiKO3OD9akqXodSG
owJ6FsifVUS4oEXPHb76eFpu1x5A0g==
=+XeL
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--
