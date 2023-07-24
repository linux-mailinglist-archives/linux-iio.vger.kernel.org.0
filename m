Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30AD75FA08
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGXOkO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjGXOkK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 10:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EACB1AA
        for <linux-iio@vger.kernel.org>; Mon, 24 Jul 2023 07:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1925611C0
        for <linux-iio@vger.kernel.org>; Mon, 24 Jul 2023 14:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29A2C433C9;
        Mon, 24 Jul 2023 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690209602;
        bh=z0ohDqmF+/nk7E/o2qtIFYPq1uT6d+/o0Fl2MBwX9NA=;
        h=Date:From:To:Cc:Subject:From;
        b=OZ85PcdbUq6MnZD1ygei4qhqUbaYWhoSZ6IANTG9x3cjWJvUmomhAiit2+G3CR1L9
         2UssYs8u/zGbg+ojZHpq4masVfnF5yGrgg6ecB18qFZfefX1RE+3MJ49TB9afiQ5/V
         RjAYoE6ItBydSimgZAyLPb6yXK94j2BGc2GCpg9uy/BJWT+X7Qkw7ovhX40RthVyfK
         tz/qFG4o9omMt/H/RlD5iMWRegbQOmItcuwym7tDbtcei25M0hP1H6uAnB+PMoYkz3
         32BvylirQAzJUCgN5uJY1NtsD97RJGZzOPyMJTREVoNxdBGEIZFr2N5ejGuY+ATUlY
         qAk0L7MMglJTg==
Date:   Mon, 24 Jul 2023 10:39:59 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [GIT PULL] Second set of Counter fixes for 6.5
Message-ID: <ZL6NP1yrUuFHAiso@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2aVOM6QoV7PP8s3Z"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--2aVOM6QoV7PP8s3Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.5b

for you to fetch changes up to aead78125a987f48944bff2001f61df72b95afc4:

  tools/counter: Makefile: Replace rmdir by rm to avoid make,clean failure (2023-07-24 10:29:52 -0400)

----------------------------------------------------------------
Second set of Counter fixes for 6.5

The I8254 Kconfig entry is repositioned to resolve a misplacement
causing the "Counter support" submenu items to disappear in menuconfig.
The tools/counter/Makefile clean recipe is adjusted to replace rmdir
with an equivalent set of rm to prevent failure if someone tries to
clean the counter directory without building it first.

----------------------------------------------------------------
Anh Tuan Phan (1):
      tools/counter: Makefile: Replace rmdir by rm to avoid make,clean failure

William Breathitt Gray (1):
      counter: Fix menuconfig "Counter support" submenu entries disappearance

 drivers/counter/Kconfig | 14 +++++++-------
 tools/counter/Makefile  |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

--2aVOM6QoV7PP8s3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZL6NPwAKCRC1SFbKvhIj
K0sSAQDD0yaqZWOpMAvL+SiqVGOWuKL1Iekn7BExo4qRzME/8wEA7Icw4UTZxGtJ
Dov+hB1MVM/Dw1PFbeF6hIJsrFBu/QY=
=FMdF
-----END PGP SIGNATURE-----

--2aVOM6QoV7PP8s3Z--
