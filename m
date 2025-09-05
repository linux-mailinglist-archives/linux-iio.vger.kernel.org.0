Return-Path: <linux-iio+bounces-23786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C33B45D1E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B3F3A840D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8930215A;
	Fri,  5 Sep 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EeXTrWA7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4631D74D;
	Fri,  5 Sep 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087634; cv=none; b=fWjU8Ya/zbInpKNrRBXuWCw+WSn2XZStqo9ugjhCo+xlLCaestKF3lDzsOf2KRYtmPNepWUy6b59TuOjNjWRQ/46rGh+QhR6J0OiTk31ES5OMlRmOdOdzdHnoO9lZDsMkl6kCiYIYnI53fycnszqcPhOQWJzqYxGo/8C6nlcG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087634; c=relaxed/simple;
	bh=bQJbBlDb2plSFmN3rMuQrvP2t8272xYYiasY74ESFkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ffh2+mi/qbYvkOEA6lCdTuAkaQskW903W/dPXDHJuZs0C1nqED+ktsednnwBVITKUpjA53z1qcnHi0OI8mBMQB+5UAGNskoz7qOBfFMJtW9bYwhLToZ8YeMoTHkHsxiP15sVWND43/VcpL0FTYDFSJIgME5W4WZgN2zrx6RsZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EeXTrWA7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585EDjNP002489;
	Fri, 5 Sep 2025 11:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VWyl2
	GKKUtzXeEMO5licX2jrTgAUwAr9qFjnFnbI/NA=; b=EeXTrWA7oTZajJ8ZL9vmj
	mLbt7+lJ0YPlA/hJRQg9LpNQnWh9uSLg3iI3LukJgu2/ZeEXaHLfOPh0TdBk6a0J
	AeKpYheIgMLE1zQAnw53sg/8CKSoq2doZ2j1N/d+QccNZX0vW6o/B0TFJsZo7eF3
	m3OG5LJyf0kGcshhZMzEOikIFe27Wgv+PI+prjlw3kV7adoZJf9v9EFqIyaUDN/s
	oIa6wbVHyv3uArL3tC5NBvjJZ0MykfJ2JOYjSzRvFh8U3+7hNvLuM+dD5XsG9LoS
	rXJSun6eE/Kqzfxn6baB6Yc6FDagGb1Z/HjP7YMcHDd5OmZv0XeH+RUOTSfw3dql
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48uu54xcv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 11:53:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 585FraOk063316
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Sep 2025 11:53:36 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 5 Sep 2025 11:53:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 5 Sep 2025 11:53:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Sep 2025 11:53:36 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 585FrKPl020487;
	Fri, 5 Sep 2025 11:53:23 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <jonath4nns@gmail.com>
Subject: [PATCH v3 3/4] math.h: Add 64-bit fractional numbers types
Date: Fri, 5 Sep 2025 06:49:32 -0300
Message-ID: <f9ebbb830fab46201dacbffa4cbe223782f0acf3.1757001160.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757001160.git.Jonathan.Santos@analog.com>
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: c_p8oEdeRg8jk9CDobSP_QX96q5shPQH
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=68bb0781 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=24LePxzCA9kSruUjZT8A:9
X-Proofpoint-GUID: c_p8oEdeRg8jk9CDobSP_QX96q5shPQH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0NyBTYWx0ZWRfX4sTihd8AJk2U
 /gPNwftnXm6bs3nWa5rBL0DFfr/YFDjMp1nrG1naMpJrcauTL4k/69cLhzaFyItpXSJvp9r2Tmw
 otnrKbJKQMLmZsV98Ly7KJsc+XP6uHlwCR5pg/xSjj7ERSvLxgTBV5DWeuyrgkbVY5Clob9k9+v
 FsjM/VU0KTWSxUcOBJAFYK5h/Yn90epvDqydY118fciEyMnTyIN6BICungRMMiM6tKK6M3XMo6S
 a5Vz0GAL+QuFmxd60/Ti4h68wEAbmT+6ybRddLF1EbBZv0flGeKqhcU1g8COaLzPZ0iviWIASe9
 D/xqwvHx6x8e0oDTxl4E0gYdOPMPB8qzoliImCznZujOI1v6EHOUa1BKJwYwU8cgeUUatA+l32W
 8HQQpEJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300047

Extend fractional numbers types to include __u64 and __s64 data types.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* New patch.
* OBS: Andy suggested to support long types, but the macro was made for
  data types like __TYPE. So i have added the __u64 and __s64 types.
---
 include/linux/math.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/math.h b/include/linux/math.h
index 0198c92cbe3e..ff28a0dcfaa8 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -130,6 +130,8 @@ __STRUCT_FRACT(s16)
 __STRUCT_FRACT(u16)
 __STRUCT_FRACT(s32)
 __STRUCT_FRACT(u32)
+__STRUCT_FRACT(s64)
+__STRUCT_FRACT(u64)
 #undef __STRUCT_FRACT
 
 /* Calculate "x * n / d" without unnecessary overflow or loss of precision. */
-- 
2.34.1


