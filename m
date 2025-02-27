Return-Path: <linux-iio+bounces-16123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD2A4818C
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9B019C338E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F268235346;
	Thu, 27 Feb 2025 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="iIK4vdNz"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7149234979;
	Thu, 27 Feb 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666480; cv=none; b=mz283xLgQ4QB1xUXmXUs9NHNr/S52ZdyqLznrzbLcNebwVBMvDJjer3jMMHGfY2kM6Dvvq7LiCap+rFm4D9pajDOzMIIg9xa0QuZ4SU9Vu9wajZlW+1XCw8wOvvh8ruNoNY2vPyNca6p007odWTv6T+G7ncqvzGJ93sLLi6wR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666480; c=relaxed/simple;
	bh=lEJxavsE7gnbY6rHB+4b/7XAqg6RcAICRcsan3oliz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZYFU3P56kc82m2/e53ko7uOae0E50K+xSqomXcyNcFvOkipXykaU5GZ9o/iF2l9+BYkjrGulyKrD5514l3FYygu3AL9mbwC3ZOt2SC+eNuO/o9cR1Uti+Gh7sfVesHPyaX4urnT135kpZxmiGybGH+6IMk82vlM1QpvW/ZQlVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=iIK4vdNz; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id F3C6EA0D06;
	Thu, 27 Feb 2025 15:27:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=2dMTzqRKOVP6zI4y+SKJ
	qu8AaktMKU/o6Ry3f8HrIys=; b=iIK4vdNzwirARn9ePnH7YdLz9jSue29GshN8
	PMBb+u8yV+/qrMmGUVni7WrsTDhIxQeNil2CdqKK3a0izxDYq0S96UnzGGuOG2X5
	6v8qyLCpiHJfJdU0Ao1eL/DJLWojsA/nA16+mxTdbpFxT/70JWvF0bfQow1HO5xu
	nN5SdtAhb+Y1YYzhs7P+ANn/I/LvmP+mRCEBrfXSZiOb8TNv+2lsFayEtVpaf64y
	95ps7r53PDjpLjmqRRQrvQkVRVmrNiXbvCoHLryAKMMhi0bhd+IlmphxGRqy+XWt
	57YnUW2fBu1XXJF0cLmwVK1wXiaD5oHTeTm9n5Q6fo2sJ12I6nEDTlABhXcGB7aI
	EsaeoxsFfSPLs5cGxOKSvGUY07soWy4vBDcRvLbYF2uydIX76/i0Et+6bYZdDexe
	hXDru6upmu5L6I1ZNeynDsu8rees5A/uWkoTatceSqkAhdV8ser27IR4a4oc2eXs
	96tDLiUUSrF18+jJSgyxtcfix4NcUiGfTzi37uE4MIpWB2pzq1HX+zRBVMEUecS/
	LWzMPJzxobzmYzhbD93nxPDRSkv0GKTWKF1LacWxfDMUqwijNpsCLZ2atPi4kaee
	hP8jsRjrVI61YmK/lomaqrERYWFy9hHhPiUHQ3hcjpPXegA09WKY0hfvqeq5xDhw
	JJKDer4=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>
Subject: [PATCH v5 1/3] include: uapi: counter: Add microchip-tcb-capture.h
Date: Thu, 27 Feb 2025 15:27:46 +0100
Message-ID: <20250227142751.61496-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142751.61496-1-csokas.bence@prolan.hu>
References: <20250227142751.61496-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1740666475;VERSION=7985;MC=289978743;ID=1450426;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852637760

Add UAPI header for the microchip-tcb-capture.c driver.
This header will hold the various event channels, component numbers etc.
used by this driver.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---

Notes:
    New in v5

 MAINTAINERS                                   |  1 +
 .../linux/counter/microchip-tcb-capture.h     | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 include/uapi/linux/counter/microchip-tcb-capture.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e047e20fbd8..d1d264210690 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15579,6 +15579,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/counter/microchip-tcb-capture.c
+F:	include/uapi/linux/counter/microchip-tcb-capture.h
 
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
diff --git a/include/uapi/linux/counter/microchip-tcb-capture.h b/include/uapi/linux/counter/microchip-tcb-capture.h
new file mode 100644
index 000000000000..7bda5fdef19b
--- /dev/null
+++ b/include/uapi/linux/counter/microchip-tcb-capture.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Channel numbers used by the microchip-tcb-capture driver
+ * Copyright (C) 2025 Bence Csókás
+ */
+#ifndef _UAPI_COUNTER_MCHP_TCB_H_
+#define _UAPI_COUNTER_MCHP_TCB_H_
+
+/*
+ * The driver defines the following components:
+ *
+ * Count 0
+ * \__  Synapse 0 -- Signal 0 (Channel A, i.e. TIOA)
+ * \__  Synapse 1 -- Signal 1 (Channel B, i.e. TIOB)
+ */
+
+enum counter_mchp_signals {
+	COUNTER_MCHP_SIG_TIOA,
+	COUNTER_MCHP_SIG_TIOB,
+};
+
+#endif /* _UAPI_COUNTER_MCHP_TCB_H_ */
-- 
2.48.1



