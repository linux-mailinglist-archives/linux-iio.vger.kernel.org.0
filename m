Return-Path: <linux-iio+bounces-20351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9207FAD37F9
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 15:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5029E4EBB
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5E529CB51;
	Tue, 10 Jun 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nXXf3lSN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207328B7F5;
	Tue, 10 Jun 2025 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559862; cv=none; b=sWD8J9Qwtt1PrQARHKpCwmd8T1+Vw7hMzVROpNyME9mHhxMN4oZL5J44lLLsubp3jPgYmwYuTRMUJAyclvPiAMQl+2Fjtetd1H3lQAZPAs3lsWJIBqlaxJbZZ1a8uKNtOi9qW5oN27UbZgcAl9UgeZMHkwNpwsyOhMuApfv27qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559862; c=relaxed/simple;
	bh=P4g3vC26jV6W0ExQIrc/lPLhlltAcwIuHV+vgYazxr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zm5QxreFpHKdVwOiDUja1fNcLc6WYNXAqKvzr27Y4+xcjzgDQOfWh7gK881EgRtcx7WXMUswpy1/3BmsAAEGFsKcjkDRvlqICxYT4t140gfhXCRgsAng1srUVxemtq33Xu6BILx8sqDGrAkG9npv0huMopcaSSOQUJ6jdHzQvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nXXf3lSN; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACLEvP010672;
	Tue, 10 Jun 2025 14:50:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	38uKaBZ1vK3ex/cxNpuaM1uYPLDT4KoCoxyuRnJRdDA=; b=nXXf3lSNgwNMuH0w
	nLld5c69c3mbSsvSbMYpSr42Q0WOosrYVX2cBFPK+9fNUY7bqH2s5nbKaLGfnpsq
	yQJvaD1XSRQyCcInzk6t1/gGxCA5L+xbmRUgUehSn0PoyZfSQEgQPfsZdc9BYR1w
	sZHny1f9rEOGGo3t4OALBMdib07MJw0j6ocvjuu3pqFigmU+Wrdc/B149jnaDuSC
	36d6MvJvLn+yEwmggN7jvHWOgGW7oZLo/T7+MmFYs+r7yEAUyXj/RRN5h64hNJc/
	ozp1IrariQlH2mUCiOtW+SM/fm3RN3s2bL3bfrk0buJirWnrPd00DOCC5Y2lbVlm
	qQzlMw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474y052j0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 14:50:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0712A40045;
	Tue, 10 Jun 2025 14:49:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3F90DB4BF99;
	Tue, 10 Jun 2025 14:49:01 +0200 (CEST)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 14:49:00 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>, Lee
 Jones <lee@kernel.org>,
        <linux-iio@vger.kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
Subject: [PATCH 3/5] iio: trigger: stm32-timer: Fix build warnings about export.h
Date: Tue, 10 Jun 2025 14:48:53 +0200
Message-ID: <20250610124855.269158-4-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610124855.269158-1-antonio.borneo@foss.st.com>
References: <20250610124855.269158-1-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01

After commit a934a57a42f6 ("scripts/misc-check: check missing #include
<linux/export.h> when W=1") and commit 7d95680d64ac ("scripts/misc-check:
check unnecessary #include <linux/export.h> when W=1") we get the build
warning with W=1:

drivers/iio/trigger/stm32-timer-trigger.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

Fix it.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 925b864facca1..3b9a3a6cbb25c 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/export.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/timer/stm32-timer-trigger.h>
-- 
2.34.1


