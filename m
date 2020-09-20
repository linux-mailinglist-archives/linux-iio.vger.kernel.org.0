Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030B0271489
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 15:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgITN14 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 09:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgITN1y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 09:27:54 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B524620EDD;
        Sun, 20 Sep 2020 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600608473;
        bh=W2Ys2+yKOHYpX/ox4uRQogxuqiNiZBaToqJJsbdBmNI=;
        h=From:To:Cc:Subject:Date:From;
        b=b/G3Btc0n7Vhq/+xl03o/21aBujUhbiIpSMlAZQo/L7oVUUYQFBpF+ztoMFivgMG/
         xXojkTpEIGwBwIpS09LAYBDKa7/8ssrHw3ovtW/wNnLvajYYMVu1tqao2HaF9qUidV
         2n7GCQe8XalLqCiLO1G3MhFYjKJd4shnoH0UQoRo=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2]  iio:trigger: Remove re-poll logic.
Date:   Sun, 20 Sep 2020 14:25:46 +0100
Message-Id: <20200920132548.196452-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This code isn't used by any current mainline drivers (except
via error handling routes that shouldn't exist).  The original
user is long gone.  It is causing issues, so let's drop it.

The main bulk of this mini-series is renaming the function to account
for the change in what it does.

Lars, what impact does doing this have on your patches to mark hrtimer
and irq_work as expiring in hardirq context? I got a bit lost in the
discussion of that series, beyond figuring out his corner needed cleaning up.

Jonathan Cameron (2):
  iio: Fix: Do not poll the driver again if try_reenable() callback
    returns non 0.
  iio:trigger: rename try_reenable() to reenable() plus return void

 drivers/iio/accel/bma180.c             |  9 ++++++---
 drivers/iio/accel/bmc150-accel-core.c  | 12 ++++--------
 drivers/iio/accel/kxcjk-1013.c         | 10 +++-------
 drivers/iio/accel/mxc4005.c            | 16 ++++++----------
 drivers/iio/adc/at91-sama5d2_adc.c     |  8 +++-----
 drivers/iio/gyro/adxrs290.c            |  6 ++----
 drivers/iio/gyro/bmg160_core.c         | 12 ++++--------
 drivers/iio/imu/kmx61.c                | 10 +++-------
 drivers/iio/industrialio-trigger.c     |  6 ++----
 drivers/iio/magnetometer/bmc150_magn.c | 10 +++++-----
 include/linux/iio/trigger.h            |  4 ++--
 11 files changed, 40 insertions(+), 63 deletions(-)

-- 
2.28.0

