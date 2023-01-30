Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F311681CF2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 22:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjA3VkG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 16:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjA3VkF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 16:40:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99AC1BDD
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 13:40:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C91861262
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 21:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F4EC433D2;
        Mon, 30 Jan 2023 21:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675114803;
        bh=PD7bo53YTs7xjFUyn+12/N1MLUMYgeu2vH+2vdDvJlw=;
        h=Date:From:To:Cc:Subject:From;
        b=Oz/B2/O1A89Ud06gQBqn30eokiWD3arp2ROTrHvT+18TiMqabvIH7E4hOE90a259Q
         ZmE12axY2D/gBDN9Kw6wDpYSWdin0g3zqmYiX/GaGiIKrHKXeOxvpNEnv7CTWVTQZY
         xgmUWMQo/PHQrL4+PdBrs6KTKrMrgOH/leUucXPk4Z4Y5ViU5MBkZOoXMgqz6nXksz
         uDjH21gK6cBDq1824cXv+wbGu9Hg9JGjLN9ZjgU9RI0xQBIRBJfNnAK46fiudNWr5n
         BK3EYJrMO3iEDtX0tEh1Yd2FnkpuTtiLtjMwhAu1te/ZoVkpYw1T6hB9WzGoRF6niU
         zC9v9xfd4RPRw==
Date:   Mon, 30 Jan 2023 16:40:00 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [PULL] First set of Counter updates for the 6.2 cycle
Message-ID: <Y9g5MOWkDGZxovjW@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwwvf/anKkugXtsM"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--pwwvf/anKkugXtsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.2a

for you to fetch changes up to 01f714ee022ecb2667ca8ba909138b1af4cfff2c:

  counter: fix dependency references for config MICROCHIP_TCB_CAPTURE (2023-01-18 09:59:58 -0500)

----------------------------------------------------------------
First set of Counter updates for the 6.2 cycle

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

--pwwvf/anKkugXtsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY9g5MAAKCRC1SFbKvhIj
K/akAQDBy99ngSej8m/W/20U9EivfcFw4vTl8SzguyLV+55uyQEA7qariUxbdJ8G
yeLfA7KR2YqTnaYFUEB/Wl/JKee/5wo=
=W4bQ
-----END PGP SIGNATURE-----

--pwwvf/anKkugXtsM--
