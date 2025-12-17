Return-Path: <linux-iio+bounces-27148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD88BCC7ABB
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06E9F304CC0D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C699357700;
	Wed, 17 Dec 2025 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="s+crq8iI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714093570D6;
	Wed, 17 Dec 2025 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975415; cv=none; b=GKv3AfuIYyEiM+UNWGqg7Y/4rif8WoZYiDzR8xk92CnMLa73PrAqjQc9zrR3vwrKpnKVMd+RVEK/q2MzjggPDfehfFa0wpv0VGN/ZPEGRz7wwgLerwh4l9LyEEcyk/7WZ30Rdd/0Ie0WOhCx9RQ+oHfM9T21RXj5HJbgX/RTqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975415; c=relaxed/simple;
	bh=zeOx5EaLSn62bNEemjccHZxbuN1xZoEsEcuNn8Nbe5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCZc0VEEzbm8+yptCt4Tpc0uqcazK3vVYC4Ry2m/i5ansfn5gDah/0zgKNNhTei8KeTpiw+/j00pAXQxHFrDk/CaB13gW/kRmaGmjhunqrJI/TaB9bpjnxpqEWH747o4PGIS/r+qZiAVIZzUKkgWfr20vE/4p/X7koES5mUcRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=s+crq8iI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHBhfGo3979181;
	Wed, 17 Dec 2025 07:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MTMjG
	MC5SJAkXk6C1bjM7QtmsJWg6xmkN0XIE0t2m9U=; b=s+crq8iIoO3CqH53CG1by
	yQE3dOWYm+1wezI6N6huLsScidtK3wXQMW5n7u/Uvv1InegztiFlu8/b4rV/wF2j
	XAuqxesWcdJDKpdKUWimRgvhnN+M1XHYizSYbu7+NWUUY/7T+zAN5jdz9jPlKdgq
	7P3CHCX8hPmUmwXWLA0XrcqTm2p1AcPMJYt9n1igMDpJv/UJc7VAQPFYhT36sCYQ
	L1GVH9IhIhbVRg9mNcsEs/CueEbSX0zbv25iUmtFXVgRBpSQOXN5h9EcxRy7xQu+
	hpX9IXb/OPCIbe93snHXX2sPn8cjYlQ2SMDpuA7g6WzwoHlm1BpbAXhEaetWgycr
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b3bbevpu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:43:17 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHChGwU043092
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:43:16 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 17 Dec
 2025 07:43:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:43:16 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCh0hM015895;
	Wed, 17 Dec 2025 07:43:03 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v5 3/5] units: add PERCENT and BASIS_POINTS macros
Date: Wed, 17 Dec 2025 02:52:45 -0300
Message-ID: <43504217d5b3c32da946bed0ce4d81e216f7c7c7.1765900411.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1765900411.git.Jonathan.Santos@analog.com>
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: tMcPpgMAaUy8skCfP8sEL1Y-Moh4bGO5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5OCBTYWx0ZWRfX2yffeJlc55MM
 B8t8bps7Yaj39/jYNOFbhhyJCt9oHUIWlE480n6lRZlVFi0pf6TlmkP8aNnBxSSKHjoTE8Fc9E6
 /y1v6NtTsvmWOLvOCwhIFVUDdbxNaa4iSflYU24eKrFtzFv5alw/Wdz9nj8t16yEn3hO8Cnb4Jb
 XoYR8TcQZaC/rZHn7e/SQezOnWg9n3G3R6NecmhHYYykp30r9bPeZv8kEHclqgKwz39IUZDCI9k
 9JFp7Yli/qCmoOYzA0ZH9yBm6OqTYpOhJXAhx83EdZdD53CJf1P9QoTffhYUCSt08EUBsQ5GdPQ
 0thKf9ClfQi2YTzxnsFmJT1fJMgJl9F8IXTTd/XXYo36+uniRaimY9h+FDpp26+u8LVLGwcAk46
 +9xVUFD1YRWYHlNHsrp7PFEMjtXEQA==
X-Authority-Analysis: v=2.4 cv=YqsChoYX c=1 sm=1 tr=0 ts=6942a565 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=mC2XmM8-ksuXMLBNdLcA:9
X-Proofpoint-GUID: tMcPpgMAaUy8skCfP8sEL1Y-Moh4bGO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170098

Add macros for percentage related units, with basis points defined as
1/100th of a percent. Basis points are commonly used in finance and
engineering to express small percentage changes with precision.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v5 Changes:
* Included PERCENT macro along with BASIS_POINTS.
* Adjusted commit description and comment in the code to add more context and
  examples.

v4 Changes:
* New patch.
---
 include/linux/units.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index 00e15de33eca..9c2fbcf04c81 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -21,6 +21,20 @@
 #define PICO	1000000000000ULL
 #define FEMTO	1000000000000000ULL
 
+/*
+ * Percentage and basis point units
+ *
+ * Basis points are 1/100th of a percent (1/100), commonly used in finance,
+ * engineering or other applications that require precise percentage
+ * calculations.
+ *
+ * Examples:
+ *   100% = 10000 basis points = BASIS_POINTS
+ *   1%   = 100 basis points   = PERCENT
+ */
+#define PERCENT		100UL
+#define BASIS_POINTS	10000UL
+
 #define NANOHZ_PER_HZ		1000000000UL
 #define MICROHZ_PER_HZ		1000000UL
 #define MILLIHZ_PER_HZ		1000UL
-- 
2.34.1


