Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D38DD2E0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2019 00:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387825AbfJRWIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 18:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387814AbfJRWIa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 18:08:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36465222D1;
        Fri, 18 Oct 2019 22:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436509;
        bh=gzJIr3oEpeI6UESWP5YHp1gXpssUBoR3tv0ZGUfuQ44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8kT2lyYkwwRDvmtah0RcvC2oFSAkiRMAZcP4Uiepi1XziBFPVwjH4kcvgEpXX5v4
         /FDLjmeF9/tcfYKxRd1lDV5G3PS8T2CfZuStcYd90xQHn/ScPStg4QXYrGIChtgtOZ
         PSxlLys8+Pzyqiqg+CWUwq3QlDzHKek7SF0F5Geg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pascal Bouwmann <bouwmann@tau-tec.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 20/56] iio: fix center temperature of bmc150-accel-core
Date:   Fri, 18 Oct 2019 18:07:17 -0400
Message-Id: <20191018220753.10002-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220753.10002-1-sashal@kernel.org>
References: <20191018220753.10002-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Pascal Bouwmann <bouwmann@tau-tec.de>

[ Upstream commit 6c59a962e081df6d8fe43325bbfabec57e0d4751 ]

The center temperature of the supported devices stored in the constant
BMC150_ACCEL_TEMP_CENTER_VAL is not 24 degrees but 23 degrees.

It seems that some datasheets were inconsistent on this value leading
to the error.  For most usecases will only make minor difference so
not queued for stable.

Signed-off-by: Pascal Bouwmann <bouwmann@tau-tec.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/bmc150-accel-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 807299dd45ebf..7e86a5b7ec4e8 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -125,7 +125,7 @@
 #define BMC150_ACCEL_SLEEP_1_SEC		0x0F
 
 #define BMC150_ACCEL_REG_TEMP			0x08
-#define BMC150_ACCEL_TEMP_CENTER_VAL		24
+#define BMC150_ACCEL_TEMP_CENTER_VAL		23
 
 #define BMC150_ACCEL_AXIS_TO_REG(axis)	(BMC150_ACCEL_REG_XOUT_L + (axis * 2))
 #define BMC150_AUTO_SUSPEND_DELAY_MS		2000
-- 
2.20.1

