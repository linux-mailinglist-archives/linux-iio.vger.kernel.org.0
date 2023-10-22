Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F977D23BB
	for <lists+linux-iio@lfdr.de>; Sun, 22 Oct 2023 17:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjJVPrc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Oct 2023 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjJVPrb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Oct 2023 11:47:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B4B4
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 08:47:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D56FC433C7;
        Sun, 22 Oct 2023 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989649;
        bh=z0SeSMrzQIWmiVxXly8L+Ygrhna+S4AuyW07v3UN544=;
        h=From:To:Cc:Subject:Date:From;
        b=GLcj/7sMw5T+cGWkUFPUwGTb12RjKwMhDvuTAZUNtXMQzHMpK75rnWNSq3nWYJo/B
         tDlXp9RUuqsARG2gjWRo2Bw649o3p0ZuxfRKSTdeGj0fX6+oVzP6pZgC+E47yyIP2q
         ztm1cdRotPViL8keROjaNf1tzEoI4ckb6Rwe/qBjR2OhLA28Bl8YUbjshR0fHVcUPs
         UmTGS2K/9Rj7hC5OilO2SF0PRC1N05EcM8TyK7rsxfE/WClIGMG+omZc6ghHzmfzhC
         EhyQT3TknFxQGdZpLWWHscdn2DyCJ+YHtHxlA9ONYYo57r4nEnVtB/tAhmToRi8K5c
         gPzlvBoRFnQJQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 0/8] IIO: Use the new cleanup.h magic
Date:   Sun, 22 Oct 2023 16:47:02 +0100
Message-ID: <20231022154710.402590-1-jic23@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

NB: I've only tested the example driver (dummy) changes - others are
build tested only so I'd like to see at least some testing on the
actual hardware.

Recently support was added to the kernel for automated cleanup based on
scope.  If the relevant variable goes out of scope, a destructor
function is called.

In most cases we are dealing with simple locking in which the guard() and
scoped_guard() magic can be used.

The one common more complex case is
iio_device_claim_direct_mode() / iio_device_release_direct_mode() which
takes a mutex only if we are not in buffered mode.
Typically this is used to avoid interfering with a devices configuration
when we are also streaming data into kernel buffers.  It's semantics
are that it will fail if we are in buffered mode (allow us to return
-EBUSY to userspace to indicate it should come back later) and otherwise
take the iio_dev->mlock and hold it until manually released.

Having looked at the various similar cases in Peter's patch set that
introduced this cleanup magic, I came up with the following:
(patch 1)
+DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
+	     iio_device_release_direct_mode(_T),
+	     ({
+			struct iio_dev *dev;
+			int d = iio_device_claim_direct_mode(_T);
+
+			if (d < 0)
+				dev = ERR_PTR(d);
+			else
+				dev = _T;
+			dev;
+	     }),
+	     struct iio_dev *_T);
+

This returns a copy of the struct iio_dev pointer passed in if the lock
was taken, if not it returns ERR_PTR(-EBUSY).
iio_device_release_direct_mode() now safely handles ERR_PTR() and so
cleanup only unlocks the mutex if this succeeded.

It is used as

+ *	CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+ *	if (IS_ERR(claimed_dev))
+ *		return PTR_ERR(claimed_dev);

when claimed_dev goes out of scope, iio_device_release_direct_mode() is
called.  I'm looking for review on whether this is correct / the simplest
approach.

This series is meant to introduce how this is used including adding it
to the dummy / example driver. I've converted a random set of drivers
over and if people are happy, many more would benefit from this treatment.
It's an RFC mostly to indicate to people that there may be dragons!

Jonathan Cameron (8):
  iio: locking: introduce __cleanup() based direct mode claiming
    infrastructure
  iio: dummy: Add use of new automated cleanup of locks and direct mode
    claiming.
  iio: accel: adxl367: Use automated cleanup for locks and iio direct
    mode.
  iio: imu: bmi323: Use cleanup handling for
    iio_device_claim_direct_mode()
  iio: adc: max1363: Use automatic cleanup for locks and iio mode
    claiming.
  iio: proximity: sx9360: Use automated cleanup for locks and IIO mode
    claiming.
  iio: proximity: sx9324: Use automated cleanup for locks and IIO mode
    claiming.
  iio: proximity: sx9310: Use automated cleanup for locks and IIO mode
    claiming.

 drivers/iio/accel/adxl367.c          | 214 ++++++++++-----------------
 drivers/iio/adc/max1363.c            |  63 ++++----
 drivers/iio/dummy/iio_simple_dummy.c | 145 +++++++++---------
 drivers/iio/imu/bmi323/bmi323_core.c |  61 ++++----
 drivers/iio/industrialio-core.c      |   4 +
 drivers/iio/proximity/sx9310.c       | 120 ++++++---------
 drivers/iio/proximity/sx9324.c       | 113 ++++++--------
 drivers/iio/proximity/sx9360.c       | 117 ++++++---------
 include/linux/iio/iio.h              |  25 ++++
 9 files changed, 368 insertions(+), 494 deletions(-)

-- 
2.42.0

