Return-Path: <linux-iio+bounces-22755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB1BB27D9D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 11:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17E6587FAF
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B6B2FD7AF;
	Fri, 15 Aug 2025 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="X+P0vnfE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896B2FCBE7;
	Fri, 15 Aug 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251868; cv=none; b=rksRtNbOGiQf0WE5UopiGC14MaAt1/5zeu/iBUZnaw4UrhoANqLGrMaX4uqhBO+C7SklDfXHkpmHQUBNw7evI5DFvQZscSRFNCKlrlp7JvCbO1F5GI0615MmlUW3ogcjOPgm6eVHgtihcqNdUXS29FL6pG7IAG41wO9BNeIDO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251868; c=relaxed/simple;
	bh=hMhsIxucMmhAoUAgF/SC2v8IMCMnjrHLLmm7NfSUNz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdFAn3z6aNWdcwp2JNL2EXgAtAqN2zghMacVhPPb0sXdq7T67PB1VcoUywAZ4lUpE2mue0it5JLEWN6HSzBtBWYC3474B9funjOfxsjfgzUDh0pL3Mce2Is6tqonsuQb9yl35cRkL+nxQ5qoijxi/oChwTfwwZ41gYu0xZXxl0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=X+P0vnfE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F6jfHe027571;
	Fri, 15 Aug 2025 05:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qcsoo
	Ltwd3Efpa9D+0qWpuFNXAv3FaMgs6dAanX5vDk=; b=X+P0vnfEeGJR6cE7ArzJL
	MN8o1Ej5UKJNSn91Nok4+nx2obToAWGHjZQNI/uTT2Px3e7unHF9/eLN5/pRA20h
	yMwjitaD+e5BtiPdyaKGfneWRBnI7Ft4Bk9hAAaAxTAwCbdIZYiNXd/AVeHuKEFN
	3UM0It1YyiF+y1uJnSCrSXko2mz92apwjwZAzhUWYWZi5fWTw1n6tZ/JHs3vt2Vx
	P3VUb1O4MvyjJ8q0y74yDbmbBTTguQyv1WbFqfMhiDanreGUxLF2g+fcYIA47eBX
	bO1BCy9fMml0EY3CfQ9wEq1oCrr1s3RIbhDYLByX6hpbEYNfm8fp4oOOYaqLFjiz
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48h6v1r0bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 05:57:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57F9vUpR034245
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Aug 2025 05:57:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 15 Aug 2025 05:57:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 15 Aug 2025 05:57:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 15 Aug 2025 05:57:30 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.226])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57F9vJit027486;
	Fri, 15 Aug 2025 05:57:25 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 1/5] iio: add IIO_ALTCURRENT channel type
Date: Fri, 15 Aug 2025 09:56:34 +0000
Message-ID: <20250815095713.9830-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815095713.9830-1-antoniu.miclaus@analog.com>
References: <20250815095713.9830-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=DZ0XqutW c=1 sm=1 tr=0 ts=689f048b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=EjsUJ71QB-Y5E-vLWTcA:9
X-Proofpoint-GUID: 1xwjHOmBCZUkYgtrXUXriunrecvVTUml
X-Proofpoint-ORIG-GUID: 1xwjHOmBCZUkYgtrXUXriunrecvVTUml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDAxNyBTYWx0ZWRfX0BOzron5QYMz
 ZlRy4C93FT+JJLZrgmWWCjyxxaIC2rpRL9lpAdEf76uNjL9r70gH8pB3E2EllsZaDNzLjuFFLcW
 v+AWhqX4CL9hSz078XCudlOh8sSB7xA97u43vzxsp+9PJfYqFP7+VW5wK8ee0uHtrL0vIvtUbXP
 Xt1EevkUO38V5706W3YkE5IsQvyniMl6E8sOyEetZbDPPL6eefiQQHMMbSTdBpywbUa2ll9C3G+
 xMBkLyYXMW6Ccj8mpYI7TVAtBt25DHMPE+hWMxWe/nZnAtdQzXXUnkSGBnWaHVsgytz8m4wl9tL
 t/S87Ct/PW6NpCg0fQp1RKJZGJh24U0v8gynu57nirCAiHxIwM9UuYh2aw6haqgFL/UYcsvzh+6
 HKhrapL+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508140017

Add support for IIO_ALTCURRENT channel type to distinguish AC current
measurements from DC current measurements. This follows the same pattern
as IIO_VOLTAGE and IIO_ALTVOLTAGE.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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


