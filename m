Return-Path: <linux-iio+bounces-23877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76224B48575
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 09:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8721B20806
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 07:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518222E9757;
	Mon,  8 Sep 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DOt95Lvd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723F2E7BDE;
	Mon,  8 Sep 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316977; cv=none; b=dN4dViEvg//nS1vLHMSktXkDUQ1GtS4mvr0sZW7vU3tS4qstQpw1SfFdQr8UarryNk71n1fBYaVLBLrlGnNfHS/79SHHr/gF4xpJTQmToRMCF6pw0FyjhX/zR2sHmJBvnzXYULTltNYjP1uxIB6ULyBkuDbQ1pgOOXaO+w/P46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316977; c=relaxed/simple;
	bh=SWOMMJnqHYPK6Vqh6ctVMBuYoeTbaP1PK12sHnybwqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGRPYypZc0KNOXDC9KmoA9sucjnkQvaVWRdW9Ye2CdGnfncyQQzqSW1y7Per5Ey6JY2qYdwNHA9ebMQJHoLJ+Qa7Z/7EOAepLZpFYGJwOrOSmfIjjGyYxiej8JRE3R4Z2JEsRSRVk2C5oZ357yipdCX1hJOrfeiQ4DeMWQ8M+eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DOt95Lvd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588403RA005861;
	Mon, 8 Sep 2025 03:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NFjIx
	q+qwV5ssj6/hMukVubAke/jydqEL8Uwl1w/bWQ=; b=DOt95Lvd+zQWzn2ncnJaH
	XX14c2q99ImUhD8VHBNSIr9iSKEMBAzmXKgQrEQrSQcABaGs1NUnzW8OnfUn68mg
	WeTRKHvEy+EI3pS2ahyAMDxHUGzChhQWi+Fn3Ba81WeipW2rLZUiec/lpO1P40CA
	3BlanZqZgvcNBIPxhgyKEBL78Xj1lhciQhYtk4xzoH3QC2Ligu03wNOE3lTpugDs
	OLXSdGTLhri5RoOHyWwQrkJDtwru9GvO28c+z9Hk/OmSpAkUyGZpFSESJcLUdtK7
	L+T1lBVMs9mPIdXQ8zm9TD+AGQdM76x9SNaAcQbkfW6kg/f4QjG0ozaNiK64O/Hi
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 491qqfgufg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 03:36:06 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5887a5av036434
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Sep 2025 03:36:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Sep
 2025 03:36:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Sep 2025 03:36:05 -0400
Received: from Ubuntu.ad.analog.com ([10.132.255.227])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5887ZpEd004718;
	Mon, 8 Sep 2025 03:35:57 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner
	<dlechner@baylibre.com>
Subject: [PATCH v7 1/6] iio: add IIO_ALTCURRENT channel type
Date: Mon, 8 Sep 2025 07:35:21 +0000
Message-ID: <20250908073531.3639-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908073531.3639-1-antoniu.miclaus@analog.com>
References: <20250908073531.3639-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNSBTYWx0ZWRfX5obTjZHe889q
 cIY4sqKTZJcKdY//NiT/EG4ML5aMw1jKlgXd6WZs9dVXosMYfxEiluwuMvltKhDfcgYb4jAwdjA
 Uv4m2c2D5tuLU6N9FaYiuCtHr+OI9teB7VW3lE7JjNPIH/CzJBfC7qwBWdUFT3l8RRvkyjcuZFo
 /E3ozwapMxdQ+Ya7L4n2bv0dhn/y3VdiXIM4JFi4lKecTaq8fuMuNVPG6rQWQ8NSSH0+/zjw0r2
 4l7rVdMyKTkJMoDvetQS0oUKNfHjWiq43e8jM8fm6Lhtl5cfOu5jgF3zkK+b5UmtVLgSuXRahl0
 kbCQz6KXV4dhye0QtRucxflBmALYeC3C9Y1WvCI0Z3/k1I/vjMGU6scvxJLaVLko1ODrHXzW7HW
 hn5JieWW
X-Authority-Analysis: v=2.4 cv=EJkG00ZC c=1 sm=1 tr=0 ts=68be8767 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=EjsUJ71QB-Y5E-vLWTcA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: tv7kte5n4s0wlQYMnutpOhrh4Cy2QSEy
X-Proofpoint-GUID: tv7kte5n4s0wlQYMnutpOhrh4Cy2QSEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509080035

Add support for IIO_ALTCURRENT channel type to distinguish AC current
measurements from DC current measurements. This follows the same pattern
as IIO_VOLTAGE and IIO_ALTVOLTAGE.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v7.
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


