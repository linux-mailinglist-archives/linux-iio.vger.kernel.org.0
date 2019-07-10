Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426BC648D4
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2019 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfGJPC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jul 2019 11:02:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47588 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJPC2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2019 11:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UkJApDVtYdjMZ/Ry2QgZ6VYCCwj+gEO2YxXHCf2mZhU=; b=f2E0/B7VukYp8wrlzR1MyP8vF
        CNF7UQFCyToADC3pQib4MtOu0YqRmK9PRe87TNaHkya7/jexN8YOIOpXlXEqczXyMrRKtnTgK4Adr
        b52ZmIRNqY/4ZOfJURi/7bpBrLoCHBqUweWotftHSbiojG8e1BNpG9eCxO1AL/op7o3yE=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hlE6u-0007xy-Im; Wed, 10 Jul 2019 15:02:20 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 9F8DCD02D51; Wed, 10 Jul 2019 16:02:19 +0100 (BST)
Date:   Wed, 10 Jul 2019 16:02:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@knernel.org, Joao.Pinto@synopsys.com
Subject: Re: [PATCH v3 1/3] regmap: add i3c bus support
Message-ID: <20190710150219.GE14859@sirena.co.uk>
References: <cover.1562767521.git.vitor.soares@synopsys.com>
 <7deb1300474b68ebb6fc3ecb02577e4f657250a5.1562767521.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <7deb1300474b68ebb6fc3ecb02577e4f657250a5.1562767521.git.vitor.soares@synopsys.com>
X-Cookie: Visit beautiful Vergas, Minnesota.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2019 at 04:56:37PM +0200, Vitor Soares wrote:
> Add basic support for i3c bus.
> This is a simple implementation that only give support
> for SDR Read and Write commands.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0l/foACgkQJNaLcl1U
h9BZPwf/WPHj9YcR+r2Om/TweeAd3+ERdBF7OVYLsMho7Wh2Yu4ERp5W9oapTfrD
NktupKnonwBoMO+mXGXbnIwP0AwNouliXGCqKKohFHw4LJcEPYSwETopror8nwgU
SKGDdEMJtUurQcgDGMAtXB3nWYjAOQJVUgwmLTBQs3apb25uum0AOpu0TQhHPkti
8tHrWbii5lsXzL5w3eRXV8hTvW7/cDXY+mkzEYcLG+I2PByHTpqRK8Ina8hGAw/i
hIKmFBS+n79F8qimM5CJQZFbGD9beT5j6vaBFuP488ltvfY9DIry8e4rfyXfT2z+
p/wOzZKQh7QNqUvalWGsGFujFfJDxw==
=ww1C
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
