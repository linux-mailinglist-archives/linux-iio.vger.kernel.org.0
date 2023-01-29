Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6094967FFEF
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjA2PmQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjA2PmP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68EE12F1A;
        Sun, 29 Jan 2023 07:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06D1CB80D13;
        Sun, 29 Jan 2023 15:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C99C433D2;
        Sun, 29 Jan 2023 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006931;
        bh=g3NbtPl+zcNFQWbRai8r2Xd/eTChrDkgyXsOGH8xdoc=;
        h=From:To:Cc:Subject:Date:From;
        b=RZcI0smmr+EYVR77iK7VmaJQ4DUziPPXAmXAr1JUy7lYGNA4fMU49bfrTYsk8F7fn
         44N69y81QZMXZm5hgvpS3JSO2NeNNKQcBEF0gn1iOvNzFWVHkD3ZKWt5lYlsMMYIxx
         NH6Q3bTQ6Ip5nWGDvRCdkFlhBslCXMmRFz3y8ZjboIWZ5djz2VkVAxj4VsuMXajKZb
         mUi/KNyyScYJOBhYdUP4tj0hclZ+L5mG9YK+2yGXoxA9iZ//aXtSP1ldJs/tVFqUc+
         pZgbSTvRwLMgP0gGccY4zaO0psbnVWDEWwG/sIy01KKMwf3QnVj8KG6lj72uo3LbVG
         SF5SS8aiEO+vA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH v2 00/12] staging: iio: accel: adis16203 Inclinometer cleanup and graduation
Date:   Sun, 29 Jan 2023 15:55:50 +0000
Message-Id: <20230129155602.740743-1-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

v2:
 - Device tree binding docs fixes.
 - --no-renames so that the whole driver is in the patch 11 email for
   easy review of what I am proposing we move out of staging.

Whilst taking a look at what we still have in staging, I noticed that this
driver was (probably) only still there due to the need to define some ABI
for the odd 180 degree offset channel (same as the other channel
minus 180 degrees).

Rather than leaving the driver in staging for ever, let us just drop that
channel and move on. The rest of the series is trivial driver cleanup.

Note this is only build tested, so would be great if people can take
a good look.  If anyone happens to have one of these that would be even
better (they are still marked for production use more than 12 years after
the driver was submitted).

There are lots of features we could support if anyone wanted to, but
it should be functional for basic channel reading without the bells
and whistles.  I've tried to incorporate the relevant device tree bindings
however (multiple interrupt lines, supplies and reset gpio).

Cc: Barry Song <baohua@kernel.org>
(mostly for comedy value, not expecting you to remember the driver :)

Jonathan Cameron (12):
  staging: iio: accel: adis16203: More conventional header ordering
  staging: iio: accel: adis16203: Drop excessive register comments
  staging: iio: accel: adis16203: Rename incli channel registers
  staging: iio: accel: adis16203: Drop the 180 degree offset channel
  staging: iio: accel: adis16203: Simplify handling of calibbias
  staging: iio: accel: adis16203: Drop driver name define
  staging: iio: accel: adis16203: Make units explicit in name of delay
    define
  staging: iio: accel: adis16203: Trivial whitespace cleanup
  staging: iio: accel: adis16203: Drop setting drvdata as nothing gets
    it
  staging: iio: accel: adis16203: Trivial style cleanup
  staging: iio: accel: adis16203: Move out of staging
  dt-bindings: iio: accel: Add ADIS16203 Inclinometer

 .../bindings/iio/accel/adi,adis16203.yaml     |  64 ++++
 drivers/iio/accel/Kconfig                     |  12 +
 drivers/iio/accel/Makefile                    |   1 +
 drivers/iio/accel/adis16203.c                 | 231 +++++++++++++
 drivers/staging/iio/accel/Kconfig             |  12 -
 drivers/staging/iio/accel/Makefile            |   1 -
 drivers/staging/iio/accel/adis16203.c         | 315 ------------------
 7 files changed, 308 insertions(+), 328 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
 create mode 100644 drivers/iio/accel/adis16203.c
 delete mode 100644 drivers/staging/iio/accel/adis16203.c

-- 
2.39.1

