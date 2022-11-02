Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C89616F0F
	for <lists+linux-iio@lfdr.de>; Wed,  2 Nov 2022 21:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiKBUqR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Nov 2022 16:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKBUqP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Nov 2022 16:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F77675
        for <linux-iio@vger.kernel.org>; Wed,  2 Nov 2022 13:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9138861C01
        for <linux-iio@vger.kernel.org>; Wed,  2 Nov 2022 20:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51B1C433D7;
        Wed,  2 Nov 2022 20:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667421968;
        bh=CwVmQAaE2WZ6ogKXeNLvxkY94Kv8audFV2Zivl872Xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A5BLwTcLJZn1ZJ+HZykMaxJDb91lv/P+MkRwiV/nlFcA05emUwbpIWxaRuB4OswX4
         OSox6IOi/4+YXIIXcqQkLTNrs1QvkSW0a3hFCyKLKhkqCYn0UtrD/77/bo8OAc9RoA
         tzwZOJSzwr9VkKeGomH9Um7pIj+Ii9PhzPZKgPy22yswAk0dN0zNuTZjIwKnjWQNMg
         3dC1BMAX38xXSHkWS08rVhyTql+VOQUeARrTwQAo1JReM+70Kr3AZAS869gS/4jgwj
         wYetVjexyWEh2duMPo+dSwIOdhmEdxD3EyycfVXew/HFWUzKP4luxsLirzDP4JRPa9
         0jSQNrEV4qU9Q==
Date:   Wed, 2 Nov 2022 21:46:05 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's .probe_new
Message-ID: <Y2LXDS04ojezKtz/@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jonathan Cameron <jic23@kernel.org>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
 <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
 <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
 <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
 <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
 <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
 <20221031233843.4rbcfs3hstlkv7il@pengutronix.de>
 <Y2EzPJvntyGbSKW8@smile.fi.intel.com>
 <20221101214939.seiuaj7un4cbcbpn@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FhkCvZjqV7l/JE1W"
Content-Disposition: inline
In-Reply-To: <20221101214939.seiuaj7un4cbcbpn@pengutronix.de>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--FhkCvZjqV7l/JE1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Uwe,

> What I consider "churn" though is this discussion. I will stop my
> participation here. That's a bit sad because in my eyes all patches in
> this series have a positive value and the discussion about (from my POV)
> incomprehensible minor details destroyed my motivation to work on the
> quest to convert all drivers to .probe_new() :-\

To get less pain of such a conversion, team up with Stephen Kitt who
also works on converting the drivers to probe_new[1].

Happy hacking,

   Wolfram

[1] http://patchwork.ozlabs.org/project/linux-i2c/list/?submitter=Kitt&series=&q=&archive=&delegate=&state=*
(but it might be that he did more and just not CC the i2c list anymore)

--FhkCvZjqV7l/JE1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNi1w0ACgkQFA3kzBSg
KbauTQ//eC3wDm2cpHP5XG8VmUtEJ4X2hgVnDbv+M9HAcQufmJkWnjrErGGuNjiv
pI71aHbcS3wkvV4xhcgzFsMmuzvwnib59qmoiDW+9pOSi4M5+CGDEiXAZM0IVQky
Am+zB+gg+bHYC3EszRV9WvvnRzraOGixpdndUDFEY9sCY9Vc4s2H5ifeKyJ9/2aT
/MxHuuHnLmCg+GxJduqjakwQdIZxdhIPLfNEMLJEWyVIoGV3nPNxGrr/kvN96m0y
rFd1hJpIUK6ZcBavvyIIE/A1aQx8e96QPoIdEPIehXWk/+CyKQXSkomkMLDoNGTi
u6spsXKZgX8tn/uDnabxzdWdU990vukKiCFriTeS+wqcyzWUc2I37/SOaBlWbMkJ
kIBMCmb9iWxV0kuDAXEacMr3neHawmTDfh4W8EyMbjFqfrnS7MkRt4xHYXnGGzdD
sBktF2gWSc33jYl4RA9ylVxqWzOARRgsQlYd/fsLHFq3dtdgqpzRflNrXD5yJy6B
2d95K3laXKtgeUBezQzhFMxK+Ke1y8Capm1Jqz5npqqjoPaPqGXh2/4sTGsMTeeA
C6p2YhGEBhPvhQ9yHBzrO9EAU3qDZhUuE6Mzjb4HHY5rs75RNEvIn25cDRGzHTKT
2qUan2Y+9EYHEVvvWlaixyeoiZCU9khcHPg0O1ZO5iFExwh8mEQ=
=AGF3
-----END PGP SIGNATURE-----

--FhkCvZjqV7l/JE1W--
