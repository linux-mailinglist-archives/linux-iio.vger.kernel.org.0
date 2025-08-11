Return-Path: <linux-iio+bounces-22572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B09B20A74
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 15:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B6B7B087C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AD62DAFA3;
	Mon, 11 Aug 2025 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b="HxK4HRha"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00015a02.pphosted.com (mx0a-00015a02.pphosted.com [205.220.166.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E62DCF71
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918767; cv=none; b=lpWEh1/vLXY8AEkGPG8ECCaQwSoY5dJ9Nls0UZvSWgwWYbpN2Ne20hSlRAv2CFLFRNXKr2vgqhWXRPNasr107SvrjTH42VkbBgEb9HxsRqf29Cm6B/lw3aisMP1ssAx3ICDwkNJJ0y6FQPS+3TnBWZQGGm4ODBRxxbKoSFC/MFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918767; c=relaxed/simple;
	bh=P5Rv2wDrohWwmpzC+FWfidwLOl5GPypHJFJqF2S82LY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KY9FVy37q3ICCfk5zdvKTocifGb3cBpvELyK7ZaR/LV9D8Kkg5oOHVT3jWnj0dp55ye4OXXlO6I40V58HwLvV8oOJ48dj7vNwyTHT4X4D8OKYcCpfZkMcftpjqasffdl7YGyPryeEnRKLvaKKeaDDEUwJuEzoEaJCQEHBWXnzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com; spf=pass smtp.mailfrom=belden.com; dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b=HxK4HRha; arc=none smtp.client-ip=205.220.166.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=belden.com
Received: from pps.filterd (m0264209.ppops.net [127.0.0.1])
	by mx0a-00015a02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B72BNS000905;
	Mon, 11 Aug 2025 09:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=podpps1; bh=w3WI5TL+w0X2KYP+tlmIma2BYPwmqBPmSt5zR
	HRycS8=; b=HxK4HRhaXPlfZWeXso5bh0JCFKNSjX1726B+TGrwl0rkmKSsxIF9n
	0U3HuH3D0BdWkpsszacdY4GQSD/0Aw7zXntAvt+17XYquYX/Bu8rtw/BESNX/TNF
	OcyTbLHZvKmsK3nS7gDQi2B5BTvstzC3PPgLcrXk646Iyt8QmreBomWa21X9yQcU
	m3CC4Ml2fRfH/mgzMIOjcuzzB7AlpnndVErI5bYxXsQJgvbyeMdaqv+QqeznEqCT
	S871gtHC4GJsFO9Z2q+gQdUs4fNA+HH0SYmA2gZm2jESRyiQ7abs2jcDqXZHsnvS
	QjJN9Lvdfu3r8YpjTef9CBkLjR5sZ2q5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 48e2nb32s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Aug 2025 09:09:14 -0400 (EDT)
Received: from m0264209.ppops.net (m0264209.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BD9Elb010109;
	Mon, 11 Aug 2025 09:09:14 -0400
Received: from relay1.belden.com ([12.161.118.81])
	by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 48e2nb32rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Aug 2025 09:09:14 -0400 (EDT)
Received: from pps.filterd (dcric1ppa01pb.mcp.local [127.0.0.1])
	by dcric1ppa01pb.mcp.local (8.18.1.2/8.18.1.2) with ESMTP id 57B0Jo7L013072;
	Mon, 11 Aug 2025 09:09:12 -0400
Received: from chbrn1lab0001 ([10.1.2.194])
	by dcric1ppa01pb.mcp.local (PPS) with ESMTPS id 48ekja1kd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:09:12 -0400 (EDT)
Received: from chbrn1rnd0001.netmodule.intranet (chbrn1lab0001.netmodule.intranet [10.121.114.100])
	by chbrn1lab0001 (Postfix) with ESMTP id 670FB3A0120;
	Mon, 11 Aug 2025 13:09:11 +0000 (UTC)
From: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
To: linux-iio@vger.kernel.org, marius.cristea@microchip.com,
        rene.straub@belden.com
Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
Subject: [PATCH] iio/adc/pac1934: fix channel disable configuration
Date: Mon, 11 Aug 2025 13:09:04 +0000
Message-Id: <20250811130904.2481790-1-aleksandar.gerasimovski@belden.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=947
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110084
X-Authority-Analysis: v=2.4 cv=bpVMBFai c=1 sm=1 tr=0 ts=6899eb7a cx=c_pps
 a=cuOCxa8MntS3/AsasmU/aA==:117 a=cuOCxa8MntS3/AsasmU/aA==:17
 a=2OwXVqhp2XgA:10 a=WDlp8lUfAAAA:8 a=_v5trmpiMvKuf-VRmTkA:9
X-Proofpoint-GUID: oU1RMHetZWmZEM1-j_J75WxAOf1o5-4q
X-Proofpoint-ORIG-GUID: oNdgirSZ1QZEnzJnGU3Uy6hwvmPSC1Ag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDA2NiBTYWx0ZWRfX9iR7WQIWL06x
 qByDk8EHLYH4QhIsIK9IPIz/UfsAv0eHSq+Pds3NCzhT89mtW1VtGFHpqXiDvrpVU3tHF4ss5GG
 xUtq/HxVP7RStZC7ywtDlc1xEriQrIp4tHb2688SiwbIM7iZjRMwg0Zq/cgVebp7Vd9xD1Fv6w5
 CigpujBUYnaTDZMDb9QnQsQOryzXau/CC4sMscNP/dVt9C2tCWccaXwmZCGUd2ZutMpvEPWmQWQ
 zeBXto7eWs38Er9t6d6YlrFjYFOfZdkEdRtBCd/Vne9jcuB0MsbfeL/hv2bIZHuuQ9OiB16a7Gq
 5Ob2NwRaKwU3X8zcDI3r6FPT5BQL1zn0deyy3cD9ehnSWO991xy3GIcYpC/BhRnceVdsPAHRNmJ
 YpOO9fEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090066
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam

There are two problems with the chip configuration in this driver:
- First, is that writing 12 bytes (ARRAY_SIZE(regs)) would anyhow
  lead to a config overflow due to HW auto increment implementation
  in the chip.
- Second, the i2c_smbus_write_block_data write ends up in writing
  unexpected value to the channel_dis register, this is because
  the smbus size that is 0x03 in this case gets written to the
  register. The PAC1931/2/3/4 data sheet does not really specify
  that block write is indeed supported.

This problem is probably not visible on PAC1934 version where all
channels are used as the chip is properly configured by luck,
but in our case whenusing PAC1931 this leads to nonfunctional device.

Signed-off-by: Rene Straub <rene.straub@belden.com>
Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
---
 drivers/iio/adc/pac1934.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 09fe88eb3fb0..2e442e46f679 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -88,6 +88,7 @@
 #define PAC1934_VPOWER_3_ADDR			0x19
 #define PAC1934_VPOWER_4_ADDR			0x1A
 #define PAC1934_REFRESH_V_REG_ADDR		0x1F
+#define PAC1934_SLOW_REG_ADDR			0x20
 #define PAC1934_CTRL_STAT_REGS_ADDR		0x1C
 #define PAC1934_PID_REG_ADDR			0xFD
 #define PAC1934_MID_REG_ADDR			0xFE
@@ -1265,8 +1266,23 @@ static int pac1934_chip_configure(struct pac1934_chip_info *info)
 	/* no SLOW triggered REFRESH, clear POR */
 	regs[PAC1934_SLOW_REG_OFF] = 0;
 
-	ret =  i2c_smbus_write_block_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
-					  ARRAY_SIZE(regs), (u8 *)regs);
+	/*
+	 * Write the three bytes sequentially, as the device does not support
+	 * block write.
+	 */
+	ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_STAT_REGS_ADDR,
+					regs[PAC1934_CHANNEL_DIS_REG_OFF]);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client,
+					PAC1934_CTRL_STAT_REGS_ADDR + PAC1934_NEG_PWR_REG_OFF,
+					regs[PAC1934_NEG_PWR_REG_OFF]);
+	if (ret)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client, PAC1934_SLOW_REG_ADDR,
+					regs[PAC1934_SLOW_REG_OFF]);
 	if (ret)
 		return ret;
 
-- 
2.34.1


**********************************************************************
DISCLAIMER:
Privileged and/or Confidential information may be contained in this message. If you are not the addressee of this message, you may not copy, use or deliver this message to anyone. In such event, you should destroy the message and kindly notify the sender by reply e-mail. It is understood that opinions or conclusions that do not relate to the official business of the company are neither given nor endorsed by the company. Thank You.

