Return-Path: <linux-iio+bounces-6024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF30B900A2B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 18:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F071C216EB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00EC19A2A8;
	Fri,  7 Jun 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R4U5rZz5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA596D1B9;
	Fri,  7 Jun 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777099; cv=none; b=YlTVQd+H3XrQro0low24h+9xF1A7o9Nx4k3j6bytwh77uV+xyGqis/17cGzgbuvnFbSScFZUlw2zFM8aXkT1SIlfhxZQ56ObwkI3rqcCzHwdRpoi+vdQ3uBUSiK/ui+uZqQYeAAApAbbx0oBXbhiM6xv5kv86FMcvOEoufKUwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777099; c=relaxed/simple;
	bh=62rTEi5JGTfNytOFoVt4sTFxXodoPen0JmPPMiO6/W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=kxPkQREgeGFafdT/9wGQ5Q8ezXGzJ1vDbp+CDkhUpfx78+6jDrggztEsiV8cIPjSyQi25EkdsZCmgrwtrW8fkFM3p6bgi5NQL8BEoSmCCLiTMbvk8TtDrIZ3XCM4wXHr/4SdILvn8uEcuPwv5ZtgGAvodQWuAPjgz5bkO/lDSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R4U5rZz5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457DcGqu031633;
	Fri, 7 Jun 2024 16:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AOfebpdrL/lq80KY6gYHFI
	wPkcYngdV1lGgArMf6bMY=; b=R4U5rZz5miea+u0T0gJgDWYjqSxRdEEkV4E9eZ
	xqrTERd1fx649Lk1DLaI1Z94hJSpBGlmvNb2Enu8u0zpp617JLR06p6YuBAUxLtT
	1ART9FQMj2KzeStj0MqcWFtLyR4JZHJcR5k6amQaSKRHkMH4TSxqRInbQDzwGucc
	OqWze0CeZBDN43cks8pFK+58ZCEF/51XPrW3eMFqaGe78Nj0z/PMoFpSBZGgT4HK
	0bBAyepk61ARl0y/cGZUosDbMhvyCJxXbkOFpf8VTRoT4TFgjS7METiSlkMk3QIS
	y0Oj+rQlySjp/vTjV1VACW/ceBHOpBWgyoMAPU1GeqseBpXA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk8tcc493-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 16:17:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457GHs2v012396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 16:17:54 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 09:17:53 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 7 Jun 2024 09:17:52 -0700
Subject: [PATCH] iio: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-md-drivers-iic-v1-1-9f9db6246083@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAK8yY2YC/x3MwQqDMAyA4VeRnBeoRRzuVYaHtI0zMDtJpgjiu
 1s9fof/38FYhQ1e1Q7Kq5j8ckH9qCCOlD+MkorBO9+41j1xSphUVlZDkYiRQuMddZ2vWyjRrDz
 Idg/ffXEgYwxKOY7X5it52XAi+7PCcZz7T12QfwAAAA==
To: Paul Cercueil <paul@crapouillou.net>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Anand Ashok Dumbre
	<anand.ashok.dumbre@xilinx.com>,
        Michal Simek <michal.simek@amd.com>
CC: <linux-mips@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _z9vmYdy_Nn8E46Sf6JPtW5yxZ0HYiZQ
X-Proofpoint-GUID: _z9vmYdy_Nn8E46Sf6JPtW5yxZ0HYiZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_09,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=912 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406070118

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/ingenic-adc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/xilinx-ams.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/buffer/kfifo_buf.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/iio/adc/ingenic-adc.c  | 1 +
 drivers/iio/adc/xilinx-ams.c   | 1 +
 drivers/iio/buffer/kfifo_buf.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index a7325dbbb99a..af70ca760797 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -920,4 +920,5 @@ static struct platform_driver ingenic_adc_driver = {
 	.probe = ingenic_adc_probe,
 };
 module_platform_driver(ingenic_adc_driver);
+MODULE_DESCRIPTION("ADC driver for the Ingenic JZ47xx SoCs");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index f0b71a1220e0..ee45475c495b 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1430,5 +1430,6 @@ static struct platform_driver ams_driver = {
 };
 module_platform_driver(ams_driver);
 
+MODULE_DESCRIPTION("Xilinx AMS driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Xilinx, Inc.");
diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 05b285f0eb22..38034c8bcc04 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -287,4 +287,5 @@ int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_iio_kfifo_buffer_setup_ext);
 
+MODULE_DESCRIPTION("Industrial I/O buffering based on kfifo");
 MODULE_LICENSE("GPL");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240607-md-drivers-iic-cab420a99216


