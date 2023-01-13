Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C866A3B3
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jan 2023 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjAMTx0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Jan 2023 14:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAMTxZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2023 14:53:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4D77D247
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2023 11:53:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DA21ECE214E
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2023 19:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD3FC433EF;
        Fri, 13 Jan 2023 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673639601;
        bh=skh+UYLWkMldtkyNes14/Dg9dv8fuDKBczDnVLUMqfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxS6lmUNlA8m1lkgjjMiMLre8oykwY59q4SQbmEUpyUk0pfQlaPyjmZ0aU9KHr9aV
         r3ul2VfehIu16+harGYNzM80OaHmTJrpmE7DfvC6dqRqPXdfNhbgr7f5xOPnpMkeCn
         dPRjcyxq1tp28MylIus9EXDa2HJd+LIJpPnV5Fzlyfiol1sBNOaNONZCfgeWCT3Ibb
         dgSbSqwNKHM/ZdShmblYl7J14GJeyOPR4wm8uOI+OkV6ejWRjMTO1Dul3pTYxlqoSc
         cMcVX1DlBO6O4CZOjj2Ry2WquGbcGhc1MTvJ+HSH5rl49n3I/LgUgYH5zvmI+glHtr
         8KeGV5tiVucJQ==
Date:   Fri, 13 Jan 2023 14:53:17 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] counter: FTM quad: Depend on the Layerscape SoC
Message-ID: <Y8G2rU0R3dvtvSLt@ishi>
References: <20230108074750.443705-1-pbrobinson@gmail.com>
 <20230108074750.443705-3-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WW1UZX7fC+Tce6ji"
Content-Disposition: inline
In-Reply-To: <20230108074750.443705-3-pbrobinson@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--WW1UZX7fC+Tce6ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 08, 2023 at 07:47:49AM +0000, Peter Robinson wrote:
> At the moment only the Freescale LS1021A is the only HW that
> supports this IP block so add an appropriate dependency and
> compile test.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Applied to counter-next, thanks.

William Breathitt Gray

--WW1UZX7fC+Tce6ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY8G2rQAKCRC1SFbKvhIj
Kz4PAQCphFxD4ie6FlbP9MNPc+dcxqoFzavEFWqK+jZPkUwy4QEAkMeUrQTC2qBx
7cv1t6ZRH1tlnJ4C5/NciVzqP3gc3Ak=
=uM1g
-----END PGP SIGNATURE-----

--WW1UZX7fC+Tce6ji--
