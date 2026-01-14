Return-Path: <linux-iio+bounces-27778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA42D1EE40
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC17A301D49F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985CF396D3E;
	Wed, 14 Jan 2026 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g96PgUI6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA7396D04;
	Wed, 14 Jan 2026 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394868; cv=none; b=HVq+hC4vy2sLTZTMT7HL0d/hPIT6TrsgYkeyMuRbfzAPjuuOa8kbMCVNIonAZOW/lhLS7WAVvWT3rLxQ/F2jF897SQc9C726hJHRQBgbQUCZa38r5Fx4FwntGCZvMXBfi0WmSIOxgCSr73RZUNpNYz0LRBzxdhL/X2LBUilSdBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394868; c=relaxed/simple;
	bh=H5o1lngnkgid4Mct3Ao0a0z5WstH3Z+sWEyVtXwo6Mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCL5sO/zsUVqTnclxx4GUa6WtYlKV4Lb2zuQRsjhc0amdWb3xmL0mwbW7glxt+TL+o8thu31X96CQ4VQRBmpWhoXGSjTbc4kwgkkj4FqXiLqZ4jvYVNZgAm1k7xPoTJpA0ZPNjasPxNsi/g/mdxN/tq26tPGMLkU9oF6fQ+11Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g96PgUI6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EC4sF03765846;
	Wed, 14 Jan 2026 07:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Xfhrp
	qJOi/7CdNnnDIaYpQSCvUDQAHJGt8dk+WvpmHU=; b=g96PgUI6vc9G5YclUifen
	OWOesu2bIjtPVd7iKE1GsNeFjzEB5J5kRs7JiCispC1WDHmbES048pgeudj8sIpE
	sDoOAslx1bJUl/C2a1iJVzhYG1JtAHmPvI5hFKcNqk1HBO/iTA9EJkI+14j0vw2i
	lrUaccAbSViq/wInvehqpSphzWF2QV7aohAnMWMInvUCdFQBxNEcHPUCV7+1IKv/
	1Ra0upmJ8cLXLfkHNEUWeWCLmX1XuC94ALuGM8TQimsifytRuCBvnwUBSjnMEiyP
	TZHjWYkkfFYMuc3PRvzLWfBS0o1qEZ1TEQVIXwG1IdAkNlbjFEHmVVrEgUBUcUMS
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bpau08gse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 07:47:31 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60EClUvv061487
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Jan 2026 07:47:30 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 14 Jan
 2026 07:47:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Jan 2026 07:47:30 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60EClEsu001741;
	Wed, 14 Jan 2026 07:47:17 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v6 3/5] units: add conversion macros for percentage related units
Date: Wed, 14 Jan 2026 06:27:03 -0300
Message-ID: <dde9b98e2ab2bfdb5806ee413732cdfeb6c1c90b.1768350772.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768350772.git.Jonathan.Santos@analog.com>
References: <cover.1768350772.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwNiBTYWx0ZWRfX+ZFvT/pUBQQy
 ph3CtbcKkSxw8cUW/brOjKjn5fhDlgAjOS/csLTcTKBKyTaXQSoR3FP2042vwFteWNoeY43jnui
 sC6EtLT+IbkwC3emW0HCtDbBey3JHhXXvQR5/cCuc0v32++wLMe2hNz8blnp4Cw207eVeFtWTUw
 nQuUAjN6VrFeP1+VU2bfSSyA3sokdJb7zvD743hnXKir7lFA00edYhdy/aP3vk98qMgW+OQXEpP
 JCwt1KuiS45tJPojefMcwJg6RzSBlIF7oM5Ymv9OZCxJfmI96QmunJVY2eR7no/TFRxA0ORGyOF
 Ed8SO2ZMhBPItf/6BS15w1+SKUEVQvPxAE8AFI0HmNHREfpD+ZnYKcpbnUmA3JTFCIeCr7L20v0
 q015b3z+g/cQWt1ieEp5YMojZXgX8GwVX4CP9/JAycFwAX2NYIxm4sFNHg7aSAihvqTeFlUC8ZR
 WUZwcD6PN11tmF2omhw==
X-Authority-Analysis: v=2.4 cv=YcWwJgRf c=1 sm=1 tr=0 ts=69679063 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=1YHlEUoW5VistbXv4qEA:9
X-Proofpoint-ORIG-GUID: cidquhaKtVSdI7q6pfrgHxmZMgPAze9H
X-Proofpoint-GUID: cidquhaKtVSdI7q6pfrgHxmZMgPAze9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140106

Add macros to convert between ratio and percentage related units,
including percent (1/100), permille (1/1,000), permyriad (1/10,000,
also equivalent to one Basis point) and per cent mille (1/100,000).
Those are  Used for precise fractional calculations in engineering,
finance, and measurement applications.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v6 Changes:
* Use Pattern PER* for all percentage-related macros. BASIS_POINTS is now
  PERMYRIAD.
* Include macros for Per mille and per cent mille units.

v5 Changes:
* Included PERCENT macro along with BASIS_POINTS.
* Adjusted commit description and comment in the code to add more context and
  examples.

v4 Changes:
* New patch.
---
 include/linux/units.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index 00e15de33eca..3471c5a38dcf 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -21,6 +21,25 @@
 #define PICO	1000000000000ULL
 #define FEMTO	1000000000000000ULL
 
+/*
+ * Percentage and related scaling units
+ *
+ * These macros define scaling factors used to convert between ratio and
+ * percentage-based representations with different decimal resolutions.
+ * They are used for precise fractional calculations in engineering, finance,
+ * and measurement applications.
+ *
+ * Examples:
+ *   1%     = 0.01    = 1 / PERCENT
+ *   0.1%   = 0.001   = 1 / PERMILLE
+ *   0.01%  = 0.0001  = 1 / PERMYRIAD (1 basis point)
+ *   0.001% = 0.00001 = 1 / PERCENTMILLE
+ */
+#define PERCENT		100
+#define PERMILLE	1000
+#define PERMYRIAD	10000
+#define PERCENTMILLE	100000
+
 #define NANOHZ_PER_HZ		1000000000UL
 #define MICROHZ_PER_HZ		1000000UL
 #define MILLIHZ_PER_HZ		1000UL
-- 
2.34.1


