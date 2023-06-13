Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88B72E911
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jun 2023 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjFMRKt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jun 2023 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjFMRKs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jun 2023 13:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EA8EA
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2023 10:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC322638AA
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2023 17:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8876EC433F0;
        Tue, 13 Jun 2023 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686676245;
        bh=/HjoQiRF1P8rx27fGi3lcjz7tgaAWcCBUXMOXELooYA=;
        h=Date:From:To:Cc:Subject:From;
        b=jrLh3aws/JRqR5zNAw3KlksdOvfbpO/C/x6v4LnN3EZDryJhww/V7WmJmLa48LVPa
         BMjGqhCrkcMNh+b3VJ9Nz9z4+RQlkvFNZo/a5LJ3x0I05FoZKWGXGHqbAtx/x555/k
         DsPNKrQUxLnNNbZcZ4euts0BtYwacoy9nx/mRoJ9g79LTsj7u7VJQlcdMGGHEKGNSb
         ARSpuOnEwXN5AGTxTUq9hBB8GVYY4kleOGXDXfSaWgGsv04fxBjqnrQtI+umxOFI7d
         D0AOcRgnnuvDLGEOK0OLfQm/cz8AJFzWCRGgJGqWqYD/LVCDtx/RxHZC7jvFfI+1Ck
         pPQ+jWT2anYZA==
Date:   Tue, 13 Jun 2023 13:10:42 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, william.gray@linaro.org
Subject: First set of Counter updates for the 6.5 cycle
Message-ID: <ZIijEjyxqt3g6tpj@ishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UOIq0Bu/CXfnrPTl"
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


--UOIq0Bu/CXfnrPTl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counte=
r-updates-for-6.5a

for you to fetch changes up to d428487471ba6640ee8bcdabaf830aec08b85400:

  counter: i8254: Introduce the Intel 8254 interface library module (2023-0=
6-08 10:11:17 -0400)

----------------------------------------------------------------
First set of Counter updates for the 6.5 cycle

Biggest changes in this set include the introduction of a new Intel 8254
interface library module and the refactoring of the existing 104-quad-8
modules to migrate it to the regmap API. Some other minor cleanups
touching tools/counter and stm32-timer-cnt are also present.

Changes
* 104-quad-8
  - Remove reference in Kconfig to 25-bit counter value
  - Utilize bitfield access macros
  - Refactor to buffer states for CMR, IOR, and IDR
  - Utilize helper functions to handle PR, FLAG and PSC
  - Migrate to the regmap API
* i8254
  - Introduce the Intel 8254 interface library module
* stm32-timer-cnt
  - Reset TIM_TISEL to its default value in probe
* tools/counter
  - Add .gitignore
  - Remove lingering 'include' directories on make clean

----------------------------------------------------------------
Rong Tao (2):
      tools/counter: Add .gitignore
      tools/counter: Makefile: Remove lingering 'include' directories on ma=
ke clean

Uwe Kleine-K=F6nig (1):
      counter: stm32-timer-cnt: Reset TIM_TISEL to its default value in pro=
be

William Breathitt Gray (6):
      counter: 104-quad-8: Remove reference in Kconfig to 25-bit counter va=
lue
      counter: 104-quad-8: Utilize bitfield access macros
      counter: 104-quad-8: Refactor to buffer states for CMR, IOR, and IDR
      counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and =
PSC
      counter: 104-quad-8: Migrate to the regmap API
      counter: i8254: Introduce the Intel 8254 interface library module

--UOIq0Bu/CXfnrPTl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZIijEgAKCRC1SFbKvhIj
K9RiAP9ittYzW+zTXTuCWxwwjvbB5M0KsZBkSX972bGR/GeJJQD/XCulurPXXYtw
mg88BCzFVzv/POhqorrIyl+Do7pQBwg=
=a3K3
-----END PGP SIGNATURE-----

--UOIq0Bu/CXfnrPTl--
