Return-Path: <linux-iio+bounces-243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CA07F3862
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 22:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D91CB215CA
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2236584ED;
	Tue, 21 Nov 2023 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02155B9;
	Tue, 21 Nov 2023 13:35:32 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALGheNC024638;
	Tue, 21 Nov 2023 16:35:19 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ueu275f05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 16:35:19 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ALLZHn1056973
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Nov 2023 16:35:17 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 21 Nov
 2023 16:35:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 21 Nov 2023 16:35:16 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ALLZ5SE019986;
	Tue, 21 Nov 2023 16:35:07 -0500
From: <marcelo.schmitt@analog.com>
To: <beniamin.bia@analog.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: Marcelo Schmitt <marcelo.schmitt@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] MAINTAINERS: Add MAINTAINERS entry for AD7091R
Date: Tue, 21 Nov 2023 18:35:05 -0300
Message-ID: <1a36ac71c6b9fbde68e29ad3dc030cef10e3d252.1700595310.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
References: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _8W0S1nH5ZkRbu7g5WqsFXfFnWSuONuY
X-Proofpoint-GUID: _8W0S1nH5ZkRbu7g5WqsFXfFnWSuONuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_11,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=885 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311210168

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

The driver for AD7091R was added in
ca693001: iio: adc: Add support for AD7091R5 ADC
but no MAINTAINERS file entry was added for it since then.
Add a proper MAINTAINERS file entry for the AD7091R driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0a91dc8251..008f0e73bead 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1126,6 +1126,16 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 F:	drivers/iio/adc/ad4130.c
 
+ANALOG DEVICES INC AD7091R DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	http://ez.analog.com/community/linux-device-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
+F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.c
+F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.h
+F:	drivers/iio/adc/drivers/iio/adc/ad7091r5.c
+
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alexandru Tachici <alexandru.tachici@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.42.0


