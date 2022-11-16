Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4850C62C816
	for <lists+linux-iio@lfdr.de>; Wed, 16 Nov 2022 19:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiKPSpj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 13:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239367AbiKPSo6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 13:44:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E04C13CEA
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 10:43:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4625B81DFB
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 18:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00696C433C1;
        Wed, 16 Nov 2022 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668624225;
        bh=6zs5XTFxcWlz2PaNko9zc1G9dhVSS6N9P6hxvASH67U=;
        h=Date:From:To:Subject:From;
        b=I0aZI99fvCcDZ7Y6PJMJ/VB5He2Wrtkn3V25ISkIkO7tArs24LQQVbGmf4VaXvKAc
         OIyDrBL7XvMSontys7XV2E1TvtQvaMCnT1taS3d+8z9O+3KgaGM+gN7spLh4LNSqar
         bSRuDO6RKIrKY3xrAW6zwwJ9jQMC3FT3UF8guN+EEEK1mtzmZcJM3SGuOI4gLkoh23
         V0UmACohVyMoxM1Q3R3tnhGTJCCxEU8eQ7A6+0ECSqVp4YGbVh9RvBabpz2K0cpVE2
         IFvqzXwe5g7tq3NuxkdulE7iAGR+VHJOtMBLLMlSrAybEloznCPrqBPdWi6639TghO
         hTpLcv9oDZzow==
Date:   Wed, 16 Nov 2022 18:56:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 3rd set of IIO fixes for 6.1
Message-ID: <20221116185610.4efb044b@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 38e9f21f648ed3f9125fe09378da9b2eb08b12d9:

  Merge tag 'iio-fixes-for-6.1b' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/jic23/iio into char-misc-linus (2022-11-05 11:29:29 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-6.1c

for you to fetch changes up to 398e3479874f381cca8726ca5d8a31e1bf35a3cd:

  dt-bindings: iio: adc: Remove the property "aspeed,trim-data-valid" (2022=
-11-14 20:20:19 +0000)

----------------------------------------------------------------
3rd set of IIO fixes for the 6.1 cycle.

Usual mixed bunch of driver fixes.

* sw-triggers
  - Fix failure to cleanup up list registration in an error path.
* aspeed,adc
  - Drop the trim valid dts property as it doesn't account for unprogrammed
    OTP and that can be easily detected without it.
* avago,apds9960:
  - Fix register address for gesture gain.
* bosch,bma400
  - Fix a memory leak in an error path.
* rohm,rpr0521
  - Fix missing dependency on IIO_BUFFER/IIO_TRIGGERED_BUFFER.
* ti,afe4403/4404
  - Fix out of band read by moving reads down to where they are used.

----------------------------------------------------------------
Alejandro Concepci=C3=B3n Rodr=C3=ADguez (1):
      iio: light: apds9960: fix wrong register for gesture gain

Billy Tsai (2):
      iio: adc: aspeed: Remove the trim valid dts property.
      dt-bindings: iio: adc: Remove the property "aspeed,trim-data-valid"

Chen Zhongjin (1):
      iio: core: Fix entry not deleted when iio_register_sw_trigger_type() =
fails

Dong Chenchen (1):
      iio: accel: bma400: Fix memory leak in bma400_get_steps_reg()

Paul Gazzillo (1):
      iio: light: rpr0521: add missing Kconfig dependencies

Wei Yongjun (2):
      iio: health: afe4403: Fix oob read in afe4403_read_raw
      iio: health: afe4404: Fix oob read in afe4404_[read|write]_raw

 .../devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml      |  7 -------
 drivers/iio/accel/bma400_core.c                              |  4 +++-
 drivers/iio/adc/aspeed_adc.c                                 | 11 +++++---=
---
 drivers/iio/health/afe4403.c                                 |  5 +++--
 drivers/iio/health/afe4404.c                                 | 12 +++++++-=
----
 drivers/iio/industrialio-sw-trigger.c                        |  6 +++++-
 drivers/iio/light/Kconfig                                    |  2 ++
 drivers/iio/light/apds9960.c                                 | 12 ++++++--=
----
 8 files changed, 31 insertions(+), 28 deletions(-)
