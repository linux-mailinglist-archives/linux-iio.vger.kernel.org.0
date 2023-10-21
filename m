Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829E37D1DBA
	for <lists+linux-iio@lfdr.de>; Sat, 21 Oct 2023 16:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjJUO5f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Oct 2023 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjJUO5e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Oct 2023 10:57:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E351D7
        for <linux-iio@vger.kernel.org>; Sat, 21 Oct 2023 07:57:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22D6C433C7;
        Sat, 21 Oct 2023 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697900252;
        bh=M9rBu8Oafzhfso452ZagSyUtqaMLpPpODYDlxQoaHZQ=;
        h=Date:From:To:Subject:From;
        b=aoh15ZR85PByW24QZbT5uHEUILy3cHP15XAJ5rOimeBI/bvq5Nlc7o5VfPFHnGx6E
         ribxl2q+y+9nERUMe9baQYlZe2bX+PO28zP7kMx2kwHIhunPbjgF7DCCS9ZsYke89I
         ZlUUcazpJDsjzI/0YzDfsSRbFqp2P400HjN80mZMS7BE14VgRKijJmkyKPO8O8s/O3
         zdUZG3IxjqXnZui5/Yto9/ktji3XillcmdV6KotE87zL3fRcZgq/opTkXaGBHDZinG
         +iNlwXE4zdIh7G7ZslpcfRlrz9bIgkuGcG6lrb5CfE0UXmN28q6afIvQ1UZ4IyoqOk
         MX9IUfRamJrNw==
Date:   Sat, 21 Oct 2023 15:57:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO fixes for the 6.6 cycle (probably for 6.7
 merge window given timing)
Message-ID: <20231021155727.511a344c@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit ffd1f150fffe8a708f6ccd15152791d0e8f812b6:

  Merge tag 'iio-fixes-for-6.6a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2023-10-06 16:58:28 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.6b

for you to fetch changes up to bee448390e5166d019e9e037194d487ee94399d9:

  iio: afe: rescale: Accept only offset channels (2023-10-17 20:25:32 +0100)

----------------------------------------------------------------
2nd set of IIO fixes for the 6.6 cycle.

Note, given timing my expectation is these will be queued for the
6.7 merge window but they could go quicker if the 6.6 cycle ends up
being extended.

afe:
  * Allow for channels with offset but no scale.  In this case the scale
    can be assumed to be 1.
adi,ad74115:
  * Add missing dt-binding constraint on number of reset-gpios.
samsung,exynos:
  * Don't request touchscreen interrupt if it is not going to be used,
    getting rid of an incorrect resulting warning message.
xilinx,xadc:
  * Avoid changing preset voltage and themperature thresholds as they
    are typicaly set as part of FPGA image building so should be left
    alone.
  * Fix wrong temperature offset and scale for some devices.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      dt-bindings: iio: add missing reset-gpios constrain

Linus Walleij (1):
      iio: afe: rescale: Accept only offset channels

Marek Szyprowski (1):
      iio: exynos-adc: request second interupt only when touchscreen mode is used

Robert Hancock (2):
      iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thresholds
      iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale

 .../devicetree/bindings/iio/addac/adi,ad74115.yaml |  3 +-
 .../devicetree/bindings/iio/dac/adi,ad5758.yaml    |  3 +-
 .../devicetree/bindings/iio/health/ti,afe4403.yaml |  3 +-
 .../devicetree/bindings/iio/health/ti,afe4404.yaml |  3 +-
 drivers/iio/adc/exynos_adc.c                       | 24 +++++++------
 drivers/iio/adc/xilinx-xadc-core.c                 | 39 ++++++++--------------
 drivers/iio/adc/xilinx-xadc.h                      |  2 ++
 drivers/iio/afe/iio-rescale.c                      | 19 ++++++++---
 8 files changed, 53 insertions(+), 43 deletions(-)
