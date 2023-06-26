Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A300673EE8B
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jun 2023 00:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjFZWNU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jun 2023 18:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFZWMi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jun 2023 18:12:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1641FD5
        for <linux-iio@vger.kernel.org>; Mon, 26 Jun 2023 15:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F30B160F6F
        for <linux-iio@vger.kernel.org>; Mon, 26 Jun 2023 22:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E4DC433C0;
        Mon, 26 Jun 2023 22:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687817459;
        bh=L5J/oUnov5Ks2cIlJ/lOTvZ5xd8+r8ZWQpnWdjpBjac=;
        h=Date:From:To:Cc:Subject:From;
        b=Jf2pLTPUqk72gVed1pljvF39KKSQj8gfcC5i2pCHtATjKzdvMYwTPxVGCnUlOhkvp
         PT5+crycQgmNKwXBPB1QEvkP0M5Wi9QAol4RrpRo7sb/qvduY0S2AFtmBOw1Y9gW71
         WVMcOXaYXgGAegQqvWL1H9YM7gLpIfO4hs2n5Y+Fz+eB9nNfLROcTaZWCyJ/jMiAJ6
         khMUZSUmG73lMCAuTXfjgYzuOWs+IBH1dg0dpf2edN/AXIXJFmrrlTM5A5rhjiUW24
         VrvUioa8l3fg/+fp6e5yVC/tqMH0Dx6yLNsFt9MPELGcUnhWTDDbnIfyGCHdeOLpKL
         3+fsaIq4Fa+uw==
Date:   Mon, 26 Jun 2023 18:10:56 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [GIT PULL] First set of Counter fixes for 6.5
Message-ID: <ZJoM8IoK3o7LUylZ@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hX76bAP+Yh5CZ5Xb"
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


--hX76bAP+Yh5CZ5Xb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d428487471ba6640ee8bcdabaf830aec08b85400:

  counter: i8254: Introduce the Intel 8254 interface library module (2023-06-08 10:11:17 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.5a

for you to fetch changes up to 9b53a13422162feac7c7ee58e5bc0e0a80a41963:

  counter: Fix menuconfig "Counter support" submenu entries disappearance (2023-06-21 14:20:10 -0400)

----------------------------------------------------------------
First set of Counter fixes for 6.5

In commit d428487471ba ("counter: i8254: Introduce the Intel 8254
interface library module"), the misplacement of the I8254 Kconfig entry
results in the "Counter support" submenu items disappearing in
menuconfig. A fix is provided to reposition the I8254 Kconfig entry to
restore the intended submenu behavior.

----------------------------------------------------------------
William Breathitt Gray (1):
      counter: Fix menuconfig "Counter support" submenu entries disappearance

 drivers/counter/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--hX76bAP+Yh5CZ5Xb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZJoM8AAKCRC1SFbKvhIj
Kw9mAPsEI/CJUpneTnqbFYu2vgZF5xfyNSfaVh8XRjDu6DqcIwEA1M2FZOpKFvPn
MCZPnmC5XNFyZ119Uf50Z+Wgc0wuZAc=
=77ry
-----END PGP SIGNATURE-----

--hX76bAP+Yh5CZ5Xb--
