Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E001E2C7558
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbgK1VtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733291AbgK1SQ4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:16:56 -0500
Received: from localhost.localdomain (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D75B246B9;
        Sat, 28 Nov 2020 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606579136;
        bh=lmQAo5lUYleEDPYPRR8Ekw2Yw9kLt4BUohqrHjvI3Nw=;
        h=From:To:Cc:Subject:Date:From;
        b=aVbMhUY0Gyd80N0yrUVIlrlAJyaDPk+3Q0SxVoZU4IGXb54s7kjnjsLADWaqgbS4g
         YA+R3XJMKUgqPMKcx/Ab0s5yzemU3QH0xzSFqaNf5t6y0r+w8xXPGOZAB6jniO6rOn
         hXoUNc+yhYp/aBv/bJIr6zbXE61UuCqQmXevM6J4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: fix warnings about passing signed values to %u
Date:   Sat, 28 Nov 2020 15:56:48 +0000
Message-Id: <20201128155648.376646-1-jic23@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In reality, we already know both of these values are positive
but it is still better to make that explicit at the point of use
with abs().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/iio/industrialio-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c2e4c267c36b..00644666f7fe 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -608,14 +608,14 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 			return scnprintf(buf, len, "-%d.%06u%s", abs(vals[0]),
 					-vals[1], scale_db ? " dB" : "");
 		else
-			return scnprintf(buf, len, "%d.%06u%s", vals[0], vals[1],
+			return scnprintf(buf, len, "%d.%06u%s", vals[0], abs(vals[1]),
 					scale_db ? " dB" : "");
 	case IIO_VAL_INT_PLUS_NANO:
 		if (vals[1] < 0)
 			return scnprintf(buf, len, "-%d.%09u", abs(vals[0]),
 					-vals[1]);
 		else
-			return scnprintf(buf, len, "%d.%09u", vals[0], vals[1]);
+			return scnprintf(buf, len, "%d.%09u", vals[0], abs(vals[1]));
 	case IIO_VAL_FRACTIONAL:
 		tmp2 = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp1 = vals[1];
-- 
2.29.2

