Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECD72B2DB
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jun 2023 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjFKQd5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jun 2023 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKQd4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Jun 2023 12:33:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C84619A
        for <linux-iio@vger.kernel.org>; Sun, 11 Jun 2023 09:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D69E60AF9
        for <linux-iio@vger.kernel.org>; Sun, 11 Jun 2023 16:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90FAC433EF;
        Sun, 11 Jun 2023 16:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686501234;
        bh=n9nEAIZK0BtWgUcmRQzfjev2RTqoylHu9EUq8/C3zvg=;
        h=Date:From:To:Subject:From;
        b=YD/1jHrdguwLLlxbo35/QYkx+BWn0o/OskirKajoTQRTPBDrpPitRVVnYoL4UTfKs
         Aa3yvXxpYk+QLKHxtp6+jhd5Y+tn8ZQiv9x4MoAKaH5w1DWztrRqER9OwfBqgZOMht
         LKf1BOXb87/rt+SV9hubYJsGnpKWpTtft0VVaXEa3ADZ4K74LWDa5d8+Fwtf6ouy0k
         GzpEXHIJ4b7zb2JQeM5G5xTTLawpvtGHkDA4+Oz2SLIqBjTCXyHFuJ7hEFqAJ3Xe2l
         Ar+NCiWAaSqGxgtzySbE6HrMksXQuab1LM2jJG30C3oq48ka7me0HjgrGCAyMoIHum
         tUasVQoes6UHw==
Date:   Sun, 11 Jun 2023 17:33:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO fixes for 6.4 (probably for 6.5 merge window
 given timing)
Message-ID: <20230611173351.5b8c19eb@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 48e156023059e57a8fc68b498439832f7600ffff:

  test_firmware: fix the memory leak of the allocated firmware buffer (2023-05-31 20:31:07 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.4b

for you to fetch changes up to c57fa0037024c92c2ca34243e79e857da5d2c0a9:

  meson saradc: fix clock divider mask length (2023-06-10 18:57:51 +0100)

----------------------------------------------------------------
2nd set of IIO fixes for the 6.4 cycle.

Given how late this pull request is, I'm expecting these to get queued
up for the 6.5 merge window.

- adi,ad7192
  * Fix a null pointer as spi_set_drvdata() is no longer called.
  * Fix wrong check prior to using internal clock.
  * Fix dt-binding to make it clear the voltage reference is required.
- adi,ad74413
  * DIN_SINK should not be set for functions other than digital inputs.
    Enforce that in the driver.
- amlogic,meson-saradc
  * Fix clock divider mask length - affects only meson 8 family.
- freescale,fxls8962af
  * Fix endian type and shift of channels to match with default device setup.
  * Narrow errata handling to FXLS8962AF only as doesn't affect other devices
    supported by this driver.

----------------------------------------------------------------
Fabrizio Lamarque (3):
      iio: adc: ad7192: Fix null ad7192_state pointer access
      iio: adc: ad7192: Fix internal/external clock selection
      dt-bindings: iio: ad7192: Add mandatory reference voltage source

George Stark (1):
      meson saradc: fix clock divider mask length

Rasmus Villemoes (1):
      iio: addac: ad74413: don't set DIN_SINK for functions other than digital input

Sean Nyekjaer (2):
      iio: accel: fxls8962af: fixup buffer scan element type
      iio: accel: fxls8962af: errata bug only applicable for FXLS8962AF

 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml |  5 +++++
 drivers/iio/accel/fxls8962af-core.c                       |  8 ++++----
 drivers/iio/adc/ad7192.c                                  |  8 ++++----
 drivers/iio/adc/meson_saradc.c                            |  2 +-
 drivers/iio/addac/ad74413r.c                              | 11 ++++++-----
 5 files changed, 20 insertions(+), 14 deletions(-)
