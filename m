Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E28259C8EE
	for <lists+linux-iio@lfdr.de>; Mon, 22 Aug 2022 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiHVTcH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Aug 2022 15:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbiHVTbp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2022 15:31:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFE913D08
        for <linux-iio@vger.kernel.org>; Mon, 22 Aug 2022 12:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1D10CE130D
        for <linux-iio@vger.kernel.org>; Mon, 22 Aug 2022 19:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CF2C433C1;
        Mon, 22 Aug 2022 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661196626;
        bh=BOkPtgB1m3QgHRgJHFCtH2K92dzqdrjOGtpgpZMpU1E=;
        h=Date:From:To:Subject:From;
        b=roIi9BZkSYaKlJxFbjz+cT4GgeTAazy3a7WHpUn+mFZwb6zxEGFOR9MDQZPrRlcNZ
         qxWyuNl4jTpV3di9zmo5t3IJrj4O4ZSLGf9WdSd8Nfwlvx0e6Ig5HIDLoMJsPX4juV
         UCdxCZwsEDS3sYporquiqcUdEjlSLTE9wEy+U2sE9MTB2Megr88slAUD5FINfPwhS6
         MINhxej02jojmbSmNXlrm1PCgWFrdaO/MRJSZC1z968VGLN4Gm6s+mkwGpmnIjyTJF
         vlZrZo9+/Gw5JhNFCg+XONUXP5xthAIt4MnzIqsgjLjTQ4knIcqi4VlGHxp2yTaFgO
         ZpLnaWUKgc5wg==
Date:   Mon, 22 Aug 2022 19:55:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for 6.0
Message-ID: <20220822195558.3b4bcf5a@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.0a

for you to fetch changes up to 0096fc879358ad6b82ee7e790c07b118c515c980:

  iio: light: cm32181: make cm32181_pm_ops static (2022-08-21 18:24:16 +0100)

----------------------------------------------------------------
1st set of IIO fixes for 6.0-rc1

adi,ad7292
 - Prevent duplicate disable of regulator in error path.

bosch,bmg160
 - Correct dt-binding to allow for 2 interrupt pins.

capella,cm3605
 - Fix missing error cleanup due to premature return.

capella,cm32181
 - Fix missing static on local symbol.

microchip,mcp33911
 - Correctly handle sign bit.
 - Fix mismatch between driver and DT binding, including fallback to old
   driver behavior.
 - Use correct formula for voltage calculation.

----------------------------------------------------------------
Christophe JAILLET (1):
      iio: light: cm3605: Fix an error handling path in cm3605_probe()

Krzysztof Kozlowski (1):
      dt-bindings: iio: gyroscope: bosch,bmg160: correct number of pins

Marcus Folkesson (3):
      iio: adc: mcp3911: make use of the sign bit
      iio: adc: mcp3911: correct "microchip,device-addr" property
      iio: adc: mcp3911: use correct formula for AD conversion

Matti Vaittinen (1):
      iio: ad7292: Prevent regulator double disable

sunliming (1):
      iio: light: cm32181: make cm32181_pm_ops static

 .../bindings/iio/gyroscope/bosch,bmg160.yaml       |  2 ++
 drivers/iio/adc/ad7292.c                           |  4 +---
 drivers/iio/adc/mcp3911.c                          | 28 +++++++++++++++++-----
 drivers/iio/light/cm32181.c                        |  2 +-
 drivers/iio/light/cm3605.c                         |  6 +++--
 5 files changed, 30 insertions(+), 12 deletions(-)
