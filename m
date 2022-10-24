Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644BB60B597
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 20:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJXScs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiJXScV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 14:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B7A50C0
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 10:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B9DE614AD
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 16:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A08C433D7;
        Mon, 24 Oct 2022 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666629967;
        bh=lw6Fpe5ExD5wRY1/YBkzqRo6eeRnolQNl01M3sm36VY=;
        h=Date:From:To:Subject:From;
        b=ThdI+7V56i7URktz35CfsQMihZl3PR/JGzXcyn0PG+XLom3jSnDvrINEkIHOPrSkz
         igShBjhWmy1YvRRU1BRtnne1de6Nlz7DPd1ptfN3tK4Zrg86JeHA++gmHtP82DwkFK
         5a2Z/ylzSmBI/ELHmZbj7nAJ93QGQFvJKXTFCwEHABpdYId/ZMzdfBfkF5YMmLVoIM
         J56KUcnuK9FZw/Bb2VQhPIvDBjFfadzHzLe46F97f65NNXDmscWzLquGUfUDHq4WgO
         lMZ38OxNVSexivQjiUsT9c8RCBjiocLzWZ/AVJyMI2pH6/T2CoUvzjLBZxlQ9DABEh
         lpiPD/XaidGiQ==
Date:   Mon, 24 Oct 2022 12:46:05 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of Counter fixes for 6.1 cycle
Message-ID: <Y1bBTQTBCrR/hUqQ@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9KayIbow4MSJMja1"
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--9KayIbow4MSJMja1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.1a

for you to fetch changes up to d501d37841d3b7f18402d71a9ef057eb9dde127e:

  counter: 104-quad-8: Fix race getting function mode and direction (2022-10-23 20:39:26 -0400)

----------------------------------------------------------------
First set of Counter fixes for 6.1 cycle

Typical driver fixes for races and bugs. This also includes a sparse
warning fix for the recently introduced counter_array API: the macro
DEFINE_COUNTER_ARRAY_POLARITY() is reduced to a simple structure
definition rather than multiple data structure definitions.

- 104-quad-8
  * Fix race getting function mode and direction
- microchip-tcb-capture
  * Handle Signal1 read and Synapse
- ti-ecap-capture
  * fix IS_ERR() vs NULL check
- counter
  * Reduce DEFINE_COUNTER_ARRAY_POLARITY() to defining counter_array

----------------------------------------------------------------
Dan Carpenter (1):
      counter: ti-ecap-capture: fix IS_ERR() vs NULL check

William Breathitt Gray (3):
      counter: Reduce DEFINE_COUNTER_ARRAY_POLARITY() to defining counter_array
      counter: microchip-tcb-capture: Handle Signal1 read and Synapse
      counter: 104-quad-8: Fix race getting function mode and direction

 drivers/counter/104-quad-8.c            | 64 +++++++++++++++++++++------------
 drivers/counter/microchip-tcb-capture.c | 18 +++++++---
 drivers/counter/ti-ecap-capture.c       |  7 ++--
 include/linux/counter.h                 |  5 ++-
 4 files changed, 62 insertions(+), 32 deletions(-)

--9KayIbow4MSJMja1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY1bBTQAKCRC1SFbKvhIj
K0yeAQCeECGG9jXMr64j+YXJbqSZo3WUERgSLfTM6IQQf79vfwEAp32d9beQii16
c31vF3643UsIalCS6hnOVuN6JY7+CAA=
=N14Q
-----END PGP SIGNATURE-----

--9KayIbow4MSJMja1--
