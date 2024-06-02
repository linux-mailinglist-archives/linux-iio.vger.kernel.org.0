Return-Path: <linux-iio+bounces-5656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476268D78BC
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 00:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4B928124E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 22:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984AA2F877;
	Sun,  2 Jun 2024 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="adqdgAhX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1F7FB;
	Sun,  2 Jun 2024 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717365935; cv=none; b=Mo8pVrAgaFz6Hah/mOkIHUP8szDaroJa8lD9VB0pDgmo1ZQ9+joaz76C4yn1XhP8VPDWx7l/CyQhPs5KAEPvXblXgedcOuLuy+6TyvuUgOLSGmgMn8QCPmEPo5gYhLJKjGFgDsjks8K0fyfDzkfU3EHoqRfiyJy6uzR1qOHKMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717365935; c=relaxed/simple;
	bh=akI2cmYIH8BRhGrXNcxVtTqIuIkhwvFFlVn7D/0tHyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ZgR4Hjr69VoluH1gHXTTv1DHOCQZ/1KkTdaKUHod7RH1nIkUH6AIARXxcbxHq1W1UK4aVPwQW5QKm6lHc9WRP2IwV7uzC4yi8cwkQfEShhJdUCpt02gYbpVbDW0CLnI/W8SFp7Gdq4Hubmcg83WD+GnSP9jc+20xmhAHVozhGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=adqdgAhX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452LglLC005399;
	Sun, 2 Jun 2024 22:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BMPHGXGIxR/ObxS147U4qy
	ITCbYNRDZJlVpWfB7Bp2M=; b=adqdgAhXoGiXgY5rxz9ayDMoZVQw0qUmZuqMhb
	jhZGCZiF3jn45gc1NegaDfwKbf6ncypxilqXPk6Uo7jz0lacvwIUxW9FwKYthmaw
	DqycM9nPzEeQ+h53yOb2RzToP2U09nV0kNMkAjnqJf3gY0K951Zgs7rDnLsO6Vh7
	oYE1IItrAMcLz3219bQT2+TsRrYPQtUIEpLsoQAjpH0UM320pjktwKqiXtlnpCl9
	R2IdHuyEhAz3kMZ55ZiOjl872sLsOEv3YueO34nBiTJG+TcO4NM10U0m84x1h39H
	trfcyKBX2WI9e3EJyqCSXtDwg7gKRAG/zuoqappfqD8c5cbA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw59je0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 22:05:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 452M5Lj8019001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 22:05:21 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 15:05:21 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 15:05:20 -0700
Subject: [PATCH] counter: ftm-quaddec: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-ftm-quaddec-v1-1-1bbdf705ad31@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJ/sXGYC/x3MwQ6CMAyA4VchPdtkLIroqxgOZeukiZvagiEhv
 LvT43f4/w2MVdjg2myg/BGTZ6loDw2EicqdUWI1eOePrnMec8Q0Z3wvFCMHPF+cP3U9U2p7qNF
 LOcn6H96G6pGMcVQqYfptHlKWFTPZzAr7/gUzV89MfwAAAA==
To: Patrick Havelange <patrick.havelange@essensium.com>,
        "William Breathitt
 Gray" <wbg@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LWs6Db7PNHnpGTHPqfvUnMN0fyMDayy0
X-Proofpoint-ORIG-GUID: LWs6Db7PNHnpGTHPqfvUnMN0fyMDayy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020193

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/counter/ftm-quaddec.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/counter/ftm-quaddec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index aea6622a9b13..200876f3ec04 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -322,6 +322,7 @@ static struct platform_driver ftm_quaddec_driver = {
 
 module_platform_driver(ftm_quaddec_driver);
 
+MODULE_DESCRIPTION("Flex Timer Module Quadrature decoder");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com>");
 MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com>");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240602-md-ftm-quaddec-7902568eaf18


