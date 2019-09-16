Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4FB3A41
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 14:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfIPMZO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 08:25:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36906 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732490AbfIPMZO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 08:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UpOy94Kk05newuEYV/41V7dmlT4Lz2VFaz56TX7gBF8=; b=CiI6oTAnkt3REl35f0JoiivqZ
        kci7oVKqLJ+95/kgphayD4VxMZREXsmIpO2lfPpBx4luYpBRmphfZHCn2s5lyfA9ZYo6NTGGfsL8q
        y7++5JC+uTYHC4FJnWdIrl2xmDTum/rxlQPhcUNPslj9l0Lw/rHL3NUgwyQmW2RmeH7TY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9q43-0004Ai-2f; Mon, 16 Sep 2019 12:25:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 22DA82741A0D; Mon, 16 Sep 2019 13:25:06 +0100 (BST)
Date:   Mon, 16 Sep 2019 13:25:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, jic23@kernel.org,
        f.fainelli@gmail.com, linus.walleij@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Message-ID: <20190916122505.GC4352@sirena.co.uk>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
 <20190913114550.956-4-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7U7nS7UhGMyosb9W"
Content-Disposition: inline
In-Reply-To: <20190913114550.956-4-alexandru.ardelean@analog.com>
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--7U7nS7UhGMyosb9W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2019 at 02:45:38PM +0300, Alexandru Ardelean wrote:

> -	u16		cs_change_delay;
> -	u8		cs_change_delay_unit;
> +	struct spi_delay	cs_change_delay;

This breaks the build as there is a user of this interface.

--7U7nS7UhGMyosb9W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/fyEACgkQJNaLcl1U
h9AR2Af8D01ThOEZ5vESTf3rqD3pj7SjkSwmXmtdE8km6WNwCuP/WAlc6Lrgj02m
yPoEFSxsQq97A47hALIaE3WogYwp5YTeN4rI8yeELVQItYThT8CPHYaQa8RuWtJB
qIp3h1PlKVmOnSNPtNsW1/rfxxgeJNzX6GZf1UWDHjfkSIexZBrVWgb/YP3p3n2k
YTyaVloShnXeUA6BXfla9Z05BHc5aCu5KBCfLyJ8uTPIeD6mIP6b3ympe6sn6+Kw
i1zrIFYvEU/J2ZN0IaZXsKRMgMD2XRPjaDlMyygOm9hr6y2SGEyOt8ml37ISXJ4w
bFoisz9mWYHBsC9+53nBiKsGV+OrlQ==
=pg1e
-----END PGP SIGNATURE-----

--7U7nS7UhGMyosb9W--
