Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C47A58C8B2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2019 04:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfHNCPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 22:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfHNCPv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Aug 2019 22:15:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6556F20842;
        Wed, 14 Aug 2019 02:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748950;
        bh=zNGBnoS6dsumvSQAk/THnjmLN330VYdItfdLp0kALgs=;
        h=From:To:Cc:Subject:Date:From;
        b=EXY8WXL9tqWDuL5Oka4XluTuxL+h24YDLCwTSFOi6oHPt8EBhUNZlOqRbJW37Xq9p
         kvGb8ppG28eboHW8Pj8E1VyGKSziB06aW6qRZ8FSnwIrZYeFmD+3qL/EZWQLkgOJbA
         YCpUXMKiyXPbeAiVeSsiRI+1ssUkwCTFfH5m8fc8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/68] iio: adc: max9611: Fix misuse of GENMASK macro
Date:   Tue, 13 Aug 2019 22:14:39 -0400
Message-Id: <20190814021548.16001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Joe Perches <joe@perches.com>

[ Upstream commit ae8cc91a7d85e018c0c267f580820b2bb558cd48 ]

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
Fixes: 69780a3bbc0b ("iio: adc: Add Maxim max9611 ADC driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/max9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 0538ff8c4ac1d..ce9af43fa2de7 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -86,7 +86,7 @@
 #define MAX9611_TEMP_MAX_POS		0x7f80
 #define MAX9611_TEMP_MAX_NEG		0xff80
 #define MAX9611_TEMP_MIN_NEG		0xd980
-#define MAX9611_TEMP_MASK		GENMASK(7, 15)
+#define MAX9611_TEMP_MASK		GENMASK(15, 7)
 #define MAX9611_TEMP_SHIFT		0x07
 #define MAX9611_TEMP_RAW(_r)		((_r) >> MAX9611_TEMP_SHIFT)
 #define MAX9611_TEMP_SCALE_NUM		1000000
-- 
2.20.1

