Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFACF682BC8
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 12:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjAaLtC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 06:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjAaLsx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 06:48:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218335B7
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 03:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D1C8614BC
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 11:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7D1C433EF;
        Tue, 31 Jan 2023 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675165729;
        bh=EvkOv8FRUu4XM0P+iFPU8bxcxFwLIJGWpejrNnn8RI4=;
        h=Date:From:To:Cc:Subject:From;
        b=uCFl+pfD4AzYx5C62Kb6j9flVoMZTHAEqlbQ7c12WMcD1gcLQv9kWpQZnJfjlfjT3
         HELzKCtqYQIIXcFel3LctLzeYBbeJZbxC3y9mWjClt4SAEiBo3bBTytMVa5ihPteyL
         sdAyXQKTpTaZq3sZy3F+sWdU/uSiRBNODt5ODJLG2EwWfrWI02nLWih6T8dmPdpbf6
         9qMxKu4Pond0ac8IOwPBadrPbeh/EbupmxJ+XZKIzNzETYyLpGwqF/XwKJl+0QddpY
         TU182JjuLAkpZC2PR8EZXcQxqqkHEnzKHN5CijfeM7IYJfyR3ys0a/flVetOJ37/uo
         0dcvsNHlPhK+w==
Date:   Tue, 31 Jan 2023 06:48:47 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, william.gray@linaro.org
Subject: First set of Counter updates for the 6.3 cycle
Message-ID: <Y9kAHziPNDke+LS4@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OQjbosLMpu+U2NCz"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--OQjbosLMpu+U2NCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.3a

for you to fetch changes up to 01f714ee022ecb2667ca8ba909138b1af4cfff2c:

  counter: fix dependency references for config MICROCHIP_TCB_CAPTURE (2023-01-18 09:59:58 -0500)

----------------------------------------------------------------
First set of Counter updates for the 6.3 cycle

This set of updates consists only of Kconfig cleanup and changes for the
Counter subsystem. In particular, the Kconfig entries are reorganized to
to alphabetical order, and dependencies added to restrict building
certain drivers (intel-qep, ftm-quaddec, and microchip-tcp-capture) to
systems that support them.

Changes
* counter
  - Sort the Kconfig entries alphabetically
* ftm-quaddec
  - Depend on the Layerscape SoC
* microchip-tcp-capture
  - Add appropriate arch deps for TCP driver
  - fix dependency references for config MICROCHIP_TCB_CAPTURE
* intel-qep
  - Depend on X86

----------------------------------------------------------------
Lukas Bulwahn (1):
      counter: fix dependency references for config MICROCHIP_TCB_CAPTURE

Peter Robinson (4):
      counter: Sort the Kconfig entries alphabetically
      counter: intel-qep: Depend on X86
      counter: ftm-quaddec: Depend on the Layerscape SoC
      counter: microchip-tcp-capture: Add appropriate arch deps for TCP driver

 drivers/counter/Kconfig | 91 +++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 44 deletions(-)

--OQjbosLMpu+U2NCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY9kAHwAKCRC1SFbKvhIj
KyjIAP91CQaZtbW2q9K5vTGK53aQqD0eY0EGiDVwBIZlj18F1QEAx211u8YjgEcL
dU2Ge7ISRziIKC2HXgBk4muq3ZZXkAo=
=OBSO
-----END PGP SIGNATURE-----

--OQjbosLMpu+U2NCz--
