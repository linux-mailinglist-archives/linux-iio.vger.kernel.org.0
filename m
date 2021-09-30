Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F0541DFAD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350217AbhI3RBn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 13:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350044AbhI3RBn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 13:01:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0729B617E6;
        Thu, 30 Sep 2021 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633021200;
        bh=pz88m8P8ZpvshD/iwZyDE/bM0M1ct6cHGYg1d/8SGy8=;
        h=From:To:Cc:Subject:Date:From;
        b=uEvK7W1MN0qKQcQiWqf/9vWeU1uYrmiZCibKWUuCTG5Fbua55EszM7VzDtnmVJSuv
         +u7pd8YapPBzuSdgGAYiJJTSGbnGpXTKiUWzLWuZX1grDP1f+OIfRt6sLXrVCesBEl
         kJXNQKSCGJWJXezyPlmLgJkCfFG0WjhKjFRlDLSWpoSZkVz1hF1s8Wk6blSU9rnR0g
         235jw/YtpxtvRp/99MmzHiAaonj9qjc+DZaqQfTlNopIb47ac0ld/1U1wid+xUZ/T+
         uQ4ATK9rnFno3SfPnwFzWJONN9d9CiK3EfQltNwGI0yoaaQhfDNlYhtFixGzqFhHEg
         +OzzVjJRJ2+Tg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] counter: microchip-tcb-capture: Tidy up a false kernel-doc /** marking.
Date:   Thu, 30 Sep 2021 18:03:47 +0100
Message-Id: <20210930170347.101153-1-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Deals with
W=1 warning This comment starts with '/**', but isn't a kernel-doc comment.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/microchip-tcb-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 79e0c84a3b81..0ab1b2716784 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) 2020 Microchip
  *
  * Author: Kamel Bouhara <kamel.bouhara@bootlin.com>
-- 
2.33.0

