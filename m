Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE3154DE87
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiFPKAe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jun 2022 06:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiFPKAd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2022 06:00:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D2E5C86E
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 03:00:32 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 03C4E1BF209;
        Thu, 16 Jun 2022 10:00:28 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Merello <andrea.merello@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 0/2] staging: iio: imu: Add CEVA BNO08x through the staging tree
Date:   Thu, 16 Jun 2022 12:00:04 +0200
Message-Id: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,
   this series adds support for the CEVA BNO08x Sensor Hub through the staging
tree.

The driver currently only support reading a rotation vector in quaternion, which
is just one of the many features supported by the device.

What's relevant here is the protocol handling part, which is used to exposed a
triggered buffer and direct access IIO interfaces. The BNO08x family implements
a packed-based protocol which requires parsing on the driver side. This driver
implements such parsing routine by copying the full received packets and
synchronize the possible multiple consumers which might want to access the data.

Sent through the staging tree as the HW platform I used to test is not available
anymore and I cannot guarantee maintainership of the driver.

However I hope the driver can serve as a useful reference for future
developments.

Thanks
  j

Jacopo Mondi (2):
  dt-bindings: staging: iio: imu: Document CEVA BNO08x
  staging: iio: imu: Add CEVA BNO08x driver

 .../bindings/staging/iio/imu/ceva,bno08x.yaml |  63 ++
 MAINTAINERS                                   |   7 +
 drivers/staging/iio/Kconfig                   |   1 +
 drivers/staging/iio/Makefile                  |   1 +
 drivers/staging/iio/imu/bno08x/Kconfig        |  11 +
 drivers/staging/iio/imu/bno08x/Makefile       |   3 +
 drivers/staging/iio/imu/bno08x/bno08x.c       | 618 ++++++++++++++++++
 7 files changed, 704 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/iio/imu/ceva,bno08x.yaml
 create mode 100644 drivers/staging/iio/imu/bno08x/Kconfig
 create mode 100644 drivers/staging/iio/imu/bno08x/Makefile
 create mode 100644 drivers/staging/iio/imu/bno08x/bno08x.c

--
2.35.1

