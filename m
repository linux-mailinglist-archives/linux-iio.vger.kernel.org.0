Return-Path: <linux-iio+bounces-23370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95D6B3BA47
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 13:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D88A20C03
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9C331578F;
	Fri, 29 Aug 2025 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WgxMIfOu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D330314B82;
	Fri, 29 Aug 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468388; cv=none; b=gjMqBta2OVLuo882IykiDbIk0Z93fK3aj47dtr8p9XtIVOhNGglXsB078/b108DkCFd32gI+NwuJjKJOWrX4xKBX08drIulnjvNxiB7txyLbZen88LY+jBPt+3OiIt3oQG8cYKNI9BzD4bWxq6gqGS1eLvJCVIpspld5v6dsl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468388; c=relaxed/simple;
	bh=G6nOVkGTXpok6bqot82IjAp/OXNE1BV/E0eDoprUz68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdJe8ZtInHXOnKGRP/LFrgB2lTpEhnVpoG7hdQIr4T6FneIWeJTYsubFQMeCORF+rf+syMPO8ioEi/aIOWVdOsJk6QsBV6LCkhYVyIS5eEemAIxahTnYsbYGguaRihWFItNlAt10vC4mqheJLw3klSir/ujHA+JnAnQ465PVlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WgxMIfOu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85MVd018066;
	Fri, 29 Aug 2025 07:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=F31kl
	aYUVRCPSz4pRZF5EWjQOHpF7J0UcjSSI1rO8mc=; b=WgxMIfOuW2TFcg3UCZlwZ
	L8oAL2JOsRjbvCw+LsqnzdO0CO9G4aHLIQCHyDIPSlfJ3hLOcPcRLfpn1MqL3lbH
	AAMpL80UZkj+nOFgi5zOH/1m3mERPQ+kxlN3C+SwjiutCVNp7kBhEVvCmF2c9RfK
	Ma8UNU25lCJUoK26o4iy8V+wOsgbBFW3PWyWYEsYiEbGWA4PGhLqaagvqK9CEkf1
	eoOv2V3uwQe8sdLNLCqkJHkRa5FVipoZb1Q+oXt3aMvtxemaWejsfqOp2sGueCkX
	+g3u0f59m0mWu3/IyDW7wxfCcHW+J6J2B4BnLuzJMFuZVWExyKFWXX22FXNgEuH7
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmag9ff7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 07:52:51 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57TBqnn5036254
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 07:52:49 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 07:52:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 07:52:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 07:52:49 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.226])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57TBqdAS017911;
	Fri, 29 Aug 2025 07:52:44 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 1/6] iio: add IIO_ALTCURRENT channel type
Date: Fri, 29 Aug 2025 11:41:35 +0000
Message-ID: <20250829115227.47712-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829115227.47712-1-antoniu.miclaus@analog.com>
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfX+KItX2teC2pD
 3w3x3iNoaMAokofiUhzp82J4fDMccTp3IZHvY3a0uKtD6+tEyKl7vni2Kd8TPA03foT+CyNZ0pg
 56rMfArzO2GvdSV5WFRZj1M9QJZ3SHJt+fByuKENxetKN/JhAYcO4/12LOjNEC35goF6k6KgWeg
 9UzMZHORTxQutO8VoW+oiLfbZjh+Ts3bSxJcX7raLMCkFiFMLTX3Bt0cVShTEMAtBBBMjyzgbdK
 3z//e+T0LvVjFA4WitXlkiV+zs8N1OSj5n9H2qlJD58AGnuAr4qrxZC2o4wBOyFpy7IR35a2zZs
 EEPa5ohHlQIDFud439AntuC9L4Rcp8yp4qO0TWrDz/q7wbEE1bJvmpcMTAkFdKOMR1mqT+Zh46y
 uZO/pbCw
X-Proofpoint-ORIG-GUID: -aViLCFxxfiR1wOTGyiRjbxksXx65mvo
X-Proofpoint-GUID: -aViLCFxxfiR1wOTGyiRjbxksXx65mvo
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68b19493 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=EjsUJ71QB-Y5E-vLWTcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

Add support for IIO_ALTCURRENT channel type to distinguish AC current
measurements from DC current measurements. This follows the same pattern
as IIO_VOLTAGE and IIO_ALTVOLTAGE.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
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


