Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220FAD7445
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfJOLLi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:11:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48898 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfJOLLi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jyqwbpgPH38QVb9gb8sryesFmn7GzhP74eJ85yXQfBQ=; b=Jb6nnfLnuhofmDi4AiE1yMQXJ
        /o3/VGeCQDzWgGcTDTUtkFC4+Fpr8HfaY9dUUKCB7b+jllxkOyHWIHCVDTn0URp421E8u+kUERNq+
        AUy4le7PuZfQvLsipTwqQHoKvXx7u2bNwZBUD7ThgK/Ht8GraN935YRZM+5lgPMDT6GYo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKjf-00020H-C7; Tue, 15 Oct 2019 11:11:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 701C427419E4; Tue, 15 Oct 2019 12:11:26 +0100 (BST)
Date:   Tue, 15 Oct 2019 12:11:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        jic23@kernel.org, f.fainelli@gmail.com, linus.walleij@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com
Subject: Re: [PATCH v4 04/19] spi: sprd: convert transfer word delay to
 spi_delay struct
Message-ID: <20191015111126.GA4030@sirena.co.uk>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
 <20190926105147.7839-5-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20190926105147.7839-5-alexandru.ardelean@analog.com>
X-Cookie: Yes, but which self do you want to be?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2019 at 01:51:32PM +0300, Alexandru Ardelean wrote:
> The Spreadtrum SPI driver is the only user of the `word_delay` field in
> the `spi_transfer` struct.

This doesn't apply against current code, please check and resend.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2lqV0ACgkQJNaLcl1U
h9CHiQf9GnqkNc3cR7NIFRHuaNNvuhYAgTsUs8m4UlwI7cQ/XcISc7kD1fUMD3tu
By1lFV/xCEANfVBa8wDijwRyvK5RMcTXYFuPZAetNPoRb006+se0MZbPeukeTjlw
JSA7tlI9mnu5p+5lXHQxIIigZnVdcgCqujQ3AG3lPW3YUHt8BIrVJqPGNkvhBDkF
YLjLMMUvSJpskjMq9OLBCtKhevA7ZHMdvfuxJ22h5BQPsNZWZxZJv7QAMdhXA7VI
nkJjcxeyvBY0GzAz5vi3SJGlLFDAec1qvF16d7mOre/0bWCRTNML0gyIt0wNiwZs
80Dr9YLhjDBQmNejzh3MvVO6sStBxQ==
=wgwp
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
