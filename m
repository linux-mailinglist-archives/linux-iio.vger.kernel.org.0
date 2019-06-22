Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DB44F65D
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfFVO6E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 10:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO6E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:58:04 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6682921530;
        Sat, 22 Jun 2019 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215483;
        bh=lWr+qgY2bqw09CknvI0TC2xVymW8qRn5ItvfrVUlWEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UwZK2s9gCQH1/FVP+FuXc2E381pSILkt1Rn8ATmqDd85sEoSu5zaodbibJ0foZhMC
         xbC+gXDjSsx1aJCvHY0BONhPi8ai+lISKneaSu3SWqiQMgL3BEjXm23vravd9Zbmsz
         sjx1vXM1MZ+cSzXkuLgfMPKxWjlgnupujoJgLp/E=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/14] iio: trig-hrtimer: SPDX header GPLv2
Date:   Sat, 22 Jun 2019 15:55:13 +0100
Message-Id: <20190622145516.3231-12-jic23@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190622145516.3231-1-jic23@kernel.org>
References: <20190622145516.3231-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Clearly stated license text so simple conversion.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/trigger/iio-trig-hrtimer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 7accd0187ba1..14cfb4074f64 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * The industrial I/O periodic hrtimer trigger driver
  *
@@ -6,11 +7,6 @@
  * Copyright (C) 2012, Analog Device Inc.
  *	Author: Lars-Peter Clausen <lars@metafoo.de>
  * Copyright (C) 2015, Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
-- 
2.22.0

