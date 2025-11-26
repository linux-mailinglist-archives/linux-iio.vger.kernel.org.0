Return-Path: <linux-iio+bounces-26502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D889C8C207
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 22:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F1F44E80C6
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A0533FE20;
	Wed, 26 Nov 2025 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VaWK5QZM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C82DC35C;
	Wed, 26 Nov 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194206; cv=none; b=ju6KkWCUtlyTtHtVVWZ/5PEnDBKiJDp+sSGABF2WGnzdsNmC909Ms7zeBlz+2nEMMov8/TMK8K8Kc69xcriWTO59q6w4pVKdJluTvy9L52NcLQtdI0ZcKDnvoe1DN6FNy1gSeOU3w8RyQ+/SHax1oxkuRS4QVJV7kVFbrNyqCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194206; c=relaxed/simple;
	bh=M4o3rABPwo7lVmOo4euWmfYyRQ9h+u244KQf14Az/fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6SDaWNFrS5B5u47mcLs5AkNmLYZyFhLeNbesAWhto4ysVYhbNeQoS6oqZs0sF+vp9dN4wrkgfMaYfcg2xVnWTQ0tAbG1Sr+o1YuJbL2+adzXYnSsF3DzoBuQgM0gwmo2elR4JdFZLyKa2YoU/sZBoWhL70ODn75hNMe9zw14G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VaWK5QZM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQHC4FZ3402606;
	Wed, 26 Nov 2025 16:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/jxtx
	6QHkTMhkQw0AVUzT3lIVz9+rAPih16QE6v9WZs=; b=VaWK5QZMIFWeC9bUeJ03e
	ApaHl/3HX94nch0173rZrV7MjMQcj7Jbj0yMaLW3V9TZy7+tYROdiyDeB+nBYX45
	yTg6w3Xgm+uWVUMssGy+kUObbUsi4XmA8no+4HBn732BPkzsD9wde4TxWg5qe0Pv
	8i++LXn2cweBufKcWB4Qa+ejpbpPIG8tf0nipgIwQdP11ZfTgdBShz8BIMbdmdHF
	Y3vMiPXgtUbFUWvf44EXSqGgXXNxYSNjz/MCnILmOqoZN4CrlwTx6B6J2RGg6aYn
	DojKzdmZxmtHmyCreuaAtqVhy+23akX1EO83MEAIWA5wZrzrksVAUsJaU6k68nA3
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4anmrux8yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:56:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AQLue5P035516
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Nov 2025 16:56:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 26 Nov
 2025 16:56:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 26 Nov 2025 16:56:40 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AQLuQCU002852;
	Wed, 26 Nov 2025 16:56:29 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt@analog.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 3/4] units: add BASIS_POINTS macro
Date: Wed, 26 Nov 2025 18:56:26 -0300
Message-ID: <6dafbe2577ba5fab28a84daf55111d9ede4a1938.1764101647.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1764101647.git.Jonathan.Santos@analog.com>
References: <cover.1764101647.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE3OCBTYWx0ZWRfX7fMkSCN7xl3j
 PTWjodxym0a0PQnct9ZCyKODTEJ59jqwWMpSPwysTqmB/JsrgXy4M1UjVzZc/rVWbgfg540bAJS
 Q1++OW2ZxQBoI7iNsXm/Rleev9Rsjygr61kATT9j/ET26LAsUsKObSqR76q+mcwkCi42XiVA9Bm
 W39uS0NIZE/VTSisNbUc4I6loeR3qyM5Z4BANLpd9OMT8J+BpDE324ScadhsLL+nwEfAPPTvKCG
 ubH/LP/0U1KcSA8oNh0SaigGn4nktgro43Oinsrw1u3fyUmoOdavi77Th7HruBXENE2pVzLRZ5m
 T/oHB8HpQLUIf7wtP2oxf7BfB05wWe/A3gQ7r2P4bIndwQOqJVEDFR+x30usEsQKv2d/EtCtN8v
 d7mIoDS4e5qX8rf/0ftDjw9ERXPahQ==
X-Proofpoint-GUID: IcvvVsHZkg55UxOC3AIJZsFKEgEkvsvL
X-Authority-Analysis: v=2.4 cv=Qehrf8bv c=1 sm=1 tr=0 ts=69277799 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=vl7k06Wm16_bTdnxtH8A:9
X-Proofpoint-ORIG-GUID: IcvvVsHZkg55UxOC3AIJZsFKEgEkvsvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260178

Add macro for basis points unit, defined as a 1/100th of a percent.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v4 Changes:
* New patch.
---
 include/linux/units.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index 00e15de33eca..da2c24fe5ee7 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -21,6 +21,8 @@
 #define PICO	1000000000000ULL
 #define FEMTO	1000000000000000ULL
 
+#define BASIS_POINTS 10000UL
+
 #define NANOHZ_PER_HZ		1000000000UL
 #define MICROHZ_PER_HZ		1000000UL
 #define MILLIHZ_PER_HZ		1000UL
-- 
2.34.1


