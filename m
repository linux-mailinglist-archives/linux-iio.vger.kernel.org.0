Return-Path: <linux-iio+bounces-26356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86827C783BD
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 10:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70E3E4E6B0F
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA27341AC8;
	Fri, 21 Nov 2025 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="R7IaW3o4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CA330B00;
	Fri, 21 Nov 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718664; cv=none; b=pRxxp7Yr5/p6brKy2pN3E5PrOWVUKvdt45FUzrxGOFn4SLSHXkqglXTQxU3IAniUZox+oPMDnwufKzk+ellCRY3fF98nu+F5hA/lj9zHSd6Su4kOyG5ePfT6LT7gJ17TPHDSRH77ItHgbNt6jfKT4raGcmUD1ZZqiek9F4cChgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718664; c=relaxed/simple;
	bh=6KOe791Pr7u5RjMaY4a+gNAFfIO7m/bpz/Pv+qr+iqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klyXEANKaVYJNefTQXK0hlYZCLoVzefTky8wqwR0WYl1tA2KDy7N9LI0q4T2XTMUkX6mL7O9Hx1u6wPZCgctjaIoG1mm5ftPsm9SB7oZuqhJ5wxZVSCv9Z3GvhX6Up99GGmV0AkYF+VNscpVQAfROFsLHRi1MO0vs32rHUJ1yE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=R7IaW3o4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL6cLEe1922873;
	Fri, 21 Nov 2025 04:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mO/c6
	l5pWlyvoLTdTf4hMg476+YS0Jlvvfr0SQtK1U8=; b=R7IaW3o4jpZV1eqQ0y8UF
	uE/bh6V5aZqpbaR0FABiLHYS9RqqYN7zkD8uxuFlgtAlvP6whGQrBqwVvzeRvfgJ
	y7bA0AjBNlV5aM5OxkopllhdWyEA8FMc3U5TOGNz1Z70ncp7U3jcvIdW2iV9Y6wr
	dG5w53TdFh5SGUTpdzjmJyUEbNP3rhV9xOsFUmewUFaviIZkUlDZM3Y/zjCRkbL4
	bdUQcqov8DdUsibKpYGy9tte/HzVFqx7aVDMiGSySseGqvEMjb1xJVdEnUzkWU4Z
	qkFFCuDFGExaKhLGRtp6k0XfZuUgAoNE/s0xCzCzcEb+77d+gDrVRwvem6ej0iND
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aj40c5c8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 04:50:56 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AL9otaB014741
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Nov 2025 04:50:55 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 21 Nov
 2025 04:50:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Nov 2025 04:50:55 -0500
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AL9ogKK026860;
	Fri, 21 Nov 2025 04:50:47 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: frequency: adf4377: add clk provider
Date: Fri, 21 Nov 2025 09:50:26 +0000
Message-ID: <20251121095027.18304-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121095027.18304-1-antoniu.miclaus@analog.com>
References: <20251121095027.18304-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NCBTYWx0ZWRfX0pxKiycE3ep0
 yMOHlmF1kiSFc3UDFaK4T4ZLdSKWeuT+KwGejUiGtCWao8bSipEmF8oB9mWhVLKdrjlqLt9E6In
 6OMC30uyo67+kWLtqhZ15/MW48FTw+ZnitrAcwHCjfailYtRVXYE3g7KAYMuaW8Kc4iVZmTHfGz
 Fr9b+8xvK4u7QrFvXtT3HcCMxXm5AKgZpQdT2ZDVQuNUtM6MZv1VhkrVmSd4YrijY19ubevOvXt
 CLvpO0c9t7iyffmdRQ99toqQWzKKAjehlUt7g9nFBhFSZZK3yjmRvoUUox+nWdXDDTBMFu3Hikt
 eKqhz5EVATnM4DwWo6e83GhuzbXjg5ECPWGn0A/yVPqBRmO0/Ofmd7GuDW9kr2LRZyY2FWpY1nb
 mqv/hxVQ8aoAhjxBKzZ6BfDbVYOzyg==
X-Authority-Analysis: v=2.4 cv=DvhbOW/+ c=1 sm=1 tr=0 ts=69203600 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=WZGvS3g7MfmD9D08EBQA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: -ytv6uYm8sha7scJ_g6nYtlqsvgMTj5t
X-Proofpoint-ORIG-GUID: -ytv6uYm8sha7scJ_g6nYtlqsvgMTj5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210074

Add support for clock provider.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - fix commit title
 - drop _clk suffix for clock names
 - drop additional example and update the existing one
 .../devicetree/bindings/iio/frequency/adi,adf4377.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
index 5f950ee9aec7..be69b9c68e74 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
@@ -40,6 +40,12 @@ properties:
     items:
       - const: ref_in
 
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
   chip-enable-gpios:
     description:
       GPIO that controls the Chip Enable Pin.
@@ -97,6 +103,8 @@ examples:
             spi-max-frequency = <10000000>;
             clocks = <&adf4377_ref_in>;
             clock-names = "ref_in";
+            #clock-cells = <0>;
+            clock-output-names = "adf4377";
         };
     };
 ...
-- 
2.43.0


