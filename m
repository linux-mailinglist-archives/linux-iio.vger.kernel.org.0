Return-Path: <linux-iio+bounces-23151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB84B3201C
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6878B1D21DAB
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052925D535;
	Fri, 22 Aug 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uzTkGBKy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4638259C80;
	Fri, 22 Aug 2025 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878554; cv=none; b=TYVeteNepXnmUM3VIIyGORu7wLVTemgZ683Unu4x55v8ENPkHbEsSLyzYVJ/YmO17eWxgYQ7R+eUqYzMZw3Kblk8NcucF7JIDcPRHdIwEyhKxHmqqyqKU8RCE6CSArQ4oUskJeu0QYlJa50Jc6glm8vmDfjr8ni+2EzDmWfxpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878554; c=relaxed/simple;
	bh=dhOg+VZN44o+CXSOGCZv67OHgoxsMxRqLu16L7rYI6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j01K1MilJyKVkNIruOfevaY3vL+rpJb8aIwtfwcc66XWgdwxsqlr99VTD/ZAFp/YPDd6WeUN93dsGC8bN9BMoYr1RxnE7B4AlAJrfEHBIQ5J9iUENAN5vSncfxfKSIVPsE3PWChBcLzeGPL3bWyU2l9mslzO4t+zsiDHFDTEDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uzTkGBKy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MDoLoZ023469;
	Fri, 22 Aug 2025 12:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kVPHJ
	wR9tC42DMZrTzZ8ZH7JOkyM9RMBG1ATWgTL+3w=; b=uzTkGBKyHuCPdb+E/tfEn
	98Q9FXspC4MQY/3Vzusdr5B1TIICA/C4MJccC43w9gOblfY9E7FuTLwzGe0LLoNk
	BXaIt8DxsiKRt0ZTlgQAuKfqsD6FkGwe4zW3iFYn8BadWgyosRy3AcAXQUwveZYS
	uOat4Mre72GwrbSU7VoJ4B0NDZjNuUZZ1vCAc4GXYyURmlOfW2vL71/dFUi87k1F
	gtsh5JcqT7INhaU5DqlKBQuScaOaUuAMBlotKPEFWRG+XWXiO4DgUsWOcDUAWiji
	+BaLQxQ235iUUj7sKVACjFtB/Ed6QexNw6Vyms8kCx44DjK6yXWQDtcMeM3epQls
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48ppn3sgkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:02:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57MG2H4G058833
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Aug 2025 12:02:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 22 Aug
 2025 12:02:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 22 Aug 2025 12:02:17 -0400
Received: from Ubuntu.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57MG263M000568;
	Fri, 22 Aug 2025 12:02:12 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 1/6] iio: add IIO_ALTCURRENT channel type
Date: Fri, 22 Aug 2025 16:01:50 +0000
Message-ID: <20250822160157.5092-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822160157.5092-1-antoniu.miclaus@analog.com>
References: <20250822160157.5092-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDA5NiBTYWx0ZWRfX00UqaHPM7+Se
 8ZVmPMyPW5ApkhiU7ZsyQMezL4x7WA21OskHvIOZVc5tGLV4LR2W9I/wY/mRPPJ1zwEeCcEDu+2
 9Uo1aS7A9kG1BTNnD/LxbOELzowIidHTUgyfyMxP1RWZ152FFCP9Df5ulZVf6Fkb9xYpJxREson
 twHyckwREcWXYkP3uxR460Lc5AoU0OXmLlYslS3LLX/0EoWOt0XHwChPJ0uMDrXUFrY1H+bVbNn
 KKGMr5t0LJOuPHhHuxWyo2p1SB9QeNHeLKnC5G4h3bJ2lrGY8lXIgrNEQ4mWKttX8n6fgKvUclr
 3ZSIDdcFtEqDxor62W/tySTau0l3kfHO6OmGjoAIAHa9fm9rD7LYmZt4sqjZkQzdG0wZlZQm+Ww
 pV8cd58Hqp/2VJlKp1gQk8O85ZzLGw==
X-Authority-Analysis: v=2.4 cv=frWFpF4f c=1 sm=1 tr=0 ts=68a8948a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=EjsUJ71QB-Y5E-vLWTcA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: P4l6vL-cm2Zx6wNZUK7tGBm2XzrXO4Dr
X-Proofpoint-ORIG-GUID: P4l6vL-cm2Zx6wNZUK7tGBm2XzrXO4Dr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508220096

Add support for IIO_ALTCURRENT channel type to distinguish AC current
measurements from DC current measurements. This follows the same pattern
as IIO_VOLTAGE and IIO_ALTVOLTAGE.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 drivers/iio/industrialio-core.c | 1 +
 include/uapi/linux/iio/types.h  | 1 +
 tools/iio/iio_event_monitor.c   | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f13c3aa470d7..8c9098668772 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -97,6 +97,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_COLORTEMP] = "colortemp",
 	[IIO_CHROMATICITY] = "chromaticity",
 	[IIO_ATTENTION] = "attention",
+	[IIO_ALTCURRENT] = "altcurrent",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 3eb0821af7a4..3c3cc1497a1e 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -52,6 +52,7 @@ enum iio_chan_type {
 	IIO_COLORTEMP,
 	IIO_CHROMATICITY,
 	IIO_ATTENTION,
+	IIO_ALTCURRENT,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index eab7b082f19d..d26aff649f3f 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -64,6 +64,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_COLORTEMP] = "colortemp",
 	[IIO_CHROMATICITY] = "chromaticity",
 	[IIO_ATTENTION] = "attention",
+	[IIO_ALTCURRENT] = "altcurrent",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -187,6 +188,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_COLORTEMP:
 	case IIO_CHROMATICITY:
 	case IIO_ATTENTION:
+	case IIO_ALTCURRENT:
 		break;
 	default:
 		return false;
-- 
2.43.0


