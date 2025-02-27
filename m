Return-Path: <linux-iio+bounces-16129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C2A4822B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D35F19C62AC
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80C323908B;
	Thu, 27 Feb 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Mmdbh03C"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF7237168;
	Thu, 27 Feb 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667263; cv=none; b=NOYM4OQrVVHV19t/U6ZNagPVSJGZzwQQkrYNP6A9k9vxuwU0Mgb4N4L/b1aX4bu25yeebGQwWjpm4MXR6lWR/6tcWA/UTztlFVUp1EVpY8lKeollxc3X4TjiQBvaCregdUTOGJL3l0MXS3rGanJt2xkPXfu40fj885JcsAxrG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667263; c=relaxed/simple;
	bh=lEJxavsE7gnbY6rHB+4b/7XAqg6RcAICRcsan3oliz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ml7E3ROZAJQR4IJ+3gw46K7mgMCZcl2BSfTx25010SZBEegEF8xKHy4k5mC9H7MSSJl6rSYqrX0l9d1U0SXFDG1xG6aIfgUysKklCeRxSxgpO8KtbbEOlTA84vy7rAcdjrW8+A/WbmzKpebm/xV7Np9e5iWT020muc6+kT0/F7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Mmdbh03C; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DFE30A06EC;
	Thu, 27 Feb 2025 15:40:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=2dMTzqRKOVP6zI4y+SKJ
	qu8AaktMKU/o6Ry3f8HrIys=; b=Mmdbh03CFS54/KUj2nEgo42yT4zFs70n5xpy
	jBJrzNAo60+wWrx9xmMYb99nXJ4qT4RdCiwluBUoMKFF707JouzOhdWcQfOwDUQB
	32lgBa1vN2H5Op6jahoKT+lT4wju5ErXowj9CV7fi+h/NaAnN31tZX6mnACYesWR
	5z+bg6dSUXD2604CN8NfX/TpQfKK8gjbjEcXHLBEH6WygxYvcFQrQmmYFaMumB7g
	d2gFa1AAasaiXWRXUe6mba6/eLqMNgg4vGIBuvQLjNv8iQPdZfk9oEap1rLlYGy0
	LDD0Crkoumr36o45vYOQ//PO0wAoptVzX72o3eyANmg3I8iVvl7o8jCqwsqiF9KL
	q69t+v1q3ahicWQJSk4sEiWuSh/cWZuJAvJ0IuF6MijImxz955346RKwE7Q1nU8x
	otBqQUr75/BHONH2k5cBAMZ1Exs9Dp3QXeTKHQ2LBf+68jm6vUf7jNOTkWYDJwNs
	UWLLFCqnXzwERM1x0bmZY1PnF47kpmzIe+w/kWSXQ9QHbS1K9KV12vgXuCXa5HI5
	Mt9pE70b35HkKxKLhDnQz+bG1yxbh8DwQFDXExiT5i8r54vhh1v2b2aV22bpr1FK
	OvYUIZiXa0giHZBHgOQRt2WIObs51DRpA4UKCghjBzE4i5QZoUwr+7xDbv1vRqhx
	0NUOtwI=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>
Subject: [PATCH v6 1/3] include: uapi: counter: Add microchip-tcb-capture.h
Date: Thu, 27 Feb 2025 15:40:18 +0100
Message-ID: <20250227144023.64530-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227144023.64530-1-csokas.bence@prolan.hu>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1740667259;VERSION=7985;MC=472284457;ID=1452434;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



