Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6B6BFAB0
	for <lists+linux-iio@lfdr.de>; Sat, 18 Mar 2023 15:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCROLJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Mar 2023 10:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCROLI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2023 10:11:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5AC2701
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 07:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CD25B81A65
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 14:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C293FC433EF;
        Sat, 18 Mar 2023 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679148658;
        bh=c5BvFbGl7rblWnb3eyZ9yJNYuxjL1GxwjpHzxDg/Jgs=;
        h=Date:From:To:Cc:Subject:From;
        b=o//jZFhKH6+F/QR3nkLIZx5fyZEar89dWzA8KMe0G0appwq/AWK1JF57YNSJSNBW7
         uL4/O4OgE7KTvdtiphRcRxtnyewtcFRqZKGvhYA4pX7tSujXAspctoG3UR4YliOqS9
         At9r9+OO8jXWWO466cEjhhb51Fflss10gJylpJRc7JIER29oYir9Wv6p0OB5EzFcYG
         50VP0XdMJDDseWVWd9AhXUz0J03CMJafXpaCQpktzyPD76HehP8Z2GYITox0yOdb73
         hZ/d9BF8vyZ/9RhkAUXqwO7Fx3jt7VYhIyy95Li6GymglXJwHEv5GLCTR71qKEqHGh
         rE3uLqgvLlwIA==
Date:   Sat, 18 Mar 2023 10:10:55 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, william.gray@linaro.org
Subject: [GIT PULL] First set of Counter driver fixes for 6.3
Message-ID: <ZBXGb2rwkcGtkArk@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fp1mM+j+blawsLNC"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Fp1mM+j+blawsLNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-6.3a

for you to fetch changes up to 00f4bc5184c19cb33f468f1ea409d70d19f8f502:

  counter: 104-quad-8: Fix Synapse action reported for Index signals (2023-03-18 09:26:40 -0400)

----------------------------------------------------------------
First set of Counter driver fixes for 6.3

This set consists of two fixes for the 104-quad-8 driver:
	- fix a read race condition between the FLAG and CNTR registers
	  (as a result 25-bit count values are no longer supported)
	- invert condition check to report correct Index Synapse action

----------------------------------------------------------------
William Breathitt Gray (2):
      counter: 104-quad-8: Fix race condition between FLAG and CNTR reads
      counter: 104-quad-8: Fix Synapse action reported for Index signals

 drivers/counter/104-quad-8.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

--Fp1mM+j+blawsLNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZBXGbwAKCRC1SFbKvhIj
K/weAQDtLhIR0XAj0jxIRN0osWRQhX+yCtMm/YU02R0eCej8wgD7BMvkqqgZcSVm
KFgYBqxjrs+Wgb+BSAHGk/dBu3jbiwc=
=0H6+
-----END PGP SIGNATURE-----

--Fp1mM+j+blawsLNC--
