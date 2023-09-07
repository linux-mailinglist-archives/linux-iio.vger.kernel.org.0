Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3731797EB7
	for <lists+linux-iio@lfdr.de>; Fri,  8 Sep 2023 00:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbjIGWdH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Sep 2023 18:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjIGWdG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Sep 2023 18:33:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A751BC7
        for <linux-iio@vger.kernel.org>; Thu,  7 Sep 2023 15:32:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF22C433C8;
        Thu,  7 Sep 2023 22:32:58 +0000 (UTC)
Date:   Thu, 7 Sep 2023 18:32:55 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [GIT PULL] First set of Counter fixes for 6.6
Message-ID: <ZPpPl8V97juxRNyT@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hkGJ/AjSEAaO41c6"
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--hkGJ/AjSEAaO41c6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.6a

for you to fetch changes up to df8fdd01c98b99d04915c04f3a5ce73f55456b7c:

  counter: microchip-tcb-capture: Fix the use of internal GCLK logic (2023-09-05 12:25:14 -0400)

----------------------------------------------------------------
First set of Counter fixes for 6.6

The counter_get_ext() function would incorrectly refer to the first
element of the extensions array to handle component array extensions
when they are located at a different index; a fix is provided to index
to the correct element in the array for this case. A fix for the
microchip-tcb-capture is provided as well to correct an inverted
internal GCLK logic for clock selection.

----------------------------------------------------------------
Dharma Balasubiramani (1):
      counter: microchip-tcb-capture: Fix the use of internal GCLK logic

Fabrice Gasnier (1):
      counter: chrdev: fix getting array extensions

 drivers/counter/counter-chrdev.c        | 4 ++--
 drivers/counter/microchip-tcb-capture.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--hkGJ/AjSEAaO41c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZPpPlwAKCRC1SFbKvhIj
K32TAP0RDnKDstj6vGh82+avylpBc9VnZlPKhhNoxl6gQ/sF7wD+OOnkxTdJpxw7
Wu//mRVsluGDVFEkaqXJ6Ot3SVEJCwI=
=t7Em
-----END PGP SIGNATURE-----

--hkGJ/AjSEAaO41c6--
