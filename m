Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C35E78105D
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378632AbjHRQ3F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378684AbjHRQ27 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 12:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153DE3C0A
        for <linux-iio@vger.kernel.org>; Fri, 18 Aug 2023 09:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A427D6218E
        for <linux-iio@vger.kernel.org>; Fri, 18 Aug 2023 16:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9679FC433C7;
        Fri, 18 Aug 2023 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692376137;
        bh=+NcaldpIQVmkvpVnVqQ5XaYdWi6XguM0xKct5EPVYuM=;
        h=Date:From:To:Subject:From;
        b=ixhaCVbFOjcYp8Xip6pqhQr7Fvn681YHLA+8g3tnb0J33NgBuh983qyqvAO3sf/+P
         QkUnxlrqTRXEigWBAskR3RKL3YNgsiqawjZEpIMcqO3HTGAqnCwi7s8lDYzKmlnlEp
         IqS4x3PEIitQ3VtE1Hq49TMFR2apvO21KVDZrgBBQUUCXlhiu/MCUMweYCQsQXyoIQ
         vJ7bm2QZ+kgxy6GxOWi50gCgGTcpL6uC1yoLzcsiUdU2P9eZL0bqj8uSQccG4ZE9my
         WCvvcH/aQ77Be/UfHXDHAANjMQcTMj38tkdFXcVeDGys3RyALP2S/3x6ukt128noFQ
         XCnyiMApQOCig==
Date:   Fri, 18 Aug 2023 12:28:53 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [GIT PULL] First set of Counter updates for the 6.6 cycle
Message-ID: <ZN+cRfEqnKvzTMh3@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cPHUKrXJijZ5Mpi/"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--cPHUKrXJijZ5Mpi/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counte=
r-updates-for-6.6a

for you to fetch changes up to 39266b642ccdc154b48eae11263920956fa0e89e:

  counter: rz-mtu3-cnt: Reorder locking sequence for consistency (2023-08-1=
6 09:41:29 -0400)

----------------------------------------------------------------
First set of Counter updates for the 6.6 cycle

This set consists primarily of minor clean-ups. The counter_priv()
'const' attribute change does yield a small improvement in reducing
the binary size.

Changes
* rz-mtu3-cnt
  - Reorder locking sequence for consistency
* Documentation
  - sysfs-bus-counter: Fix indentation
* counter
  - Declare counter_priv() to be const
* microchip-tcb-capture
  - Explicitly include correct DT includes

----------------------------------------------------------------
Biju Das (2):
      Documentation: ABI: sysfs-bus-counter: Fix indentation
      counter: rz-mtu3-cnt: Reorder locking sequence for consistency

Rob Herring (1):
      counter: Explicitly include correct DT includes

Uwe Kleine-K=F6nig (1):
      counter: Declare counter_priv() to be const

 Documentation/ABI/testing/sysfs-bus-counter | 8 ++++----
 drivers/counter/microchip-tcb-capture.c     | 1 -
 drivers/counter/rz-mtu3-cnt.c               | 4 ++--
 include/linux/counter.h                     | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

--cPHUKrXJijZ5Mpi/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZN+cRQAKCRC1SFbKvhIj
K7pHAP44okBbceXXA0Jqhqejmi/PFlvEjR1xrWvefxoyzw4UsQD7BXhGbhPfnFOt
ID1oVAxKNVYi0pNTZohxVw1BoYgQxAM=
=++ls
-----END PGP SIGNATURE-----

--cPHUKrXJijZ5Mpi/--
