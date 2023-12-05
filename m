Return-Path: <linux-iio+bounces-617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBE98043F8
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 02:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F461F21338
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 01:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5910E8;
	Tue,  5 Dec 2023 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="u+d27jhB"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA83102
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 17:23:00 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2874B875F5;
	Tue,  5 Dec 2023 02:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701739378;
	bh=IKZ/DOdRN7p1xXSFE4d18VkTSQxuXuHgV6EH8xpkvnU=;
	h=From:To:Cc:Subject:Date:From;
	b=u+d27jhBwpGzkTORpiugf6VjdtGGabPL/p8xG7BFAmmDT32UoCRkMhL6F30ShDA4E
	 o9CwCZocwolRkHg2p4JF26SZMwo09uvkzBCtmF7WVTOBrW3SsUyUU/P8gAV1kEYghg
	 NUiG23CBZPt1kn6Nn9t6qJ3xkGwerrUlwX2G1Ud3f1ACBXoespIW9ZiAPoA6CF1OKJ
	 rDaW26PvaOn3n0KgMO172RhCjVzIZZANNa/cP+PTswbUny7TD99M8sgw9lbJF8ZvPt
	 SUd9YtzQlE1cM1OCnDhsX8TJVTFk9JVEGtsCoELXEWJ0UCs95l9JQkKWw4U5IfEXfV
	 vJ8HQZtUBr49g==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH] iio: light: isl76682: Space consistency
Date: Tue,  5 Dec 2023 02:22:34 +0100
Message-ID: <20231205012246.104503-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add missing space between { } to be consistent with the other { } .
No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/light/isl76682.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
index 15a68609985b6..a17970fb3758e 100644
--- a/drivers/iio/light/isl76682.c
+++ b/drivers/iio/light/isl76682.c
@@ -328,7 +328,7 @@ static int isl76682_probe(struct i2c_client *client)
 
 static const struct i2c_device_id isl76682_id[] = {
 	{ "isl76682" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl76682_id);
 
-- 
2.42.0


