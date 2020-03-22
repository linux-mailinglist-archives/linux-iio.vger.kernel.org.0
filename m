Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A25F18EB35
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgCVRyE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:54:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24272 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbgCVRyC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:54:02 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02MHjHgB001989;
        Sun, 22 Mar 2020 13:54:00 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs5v5aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 13:54:00 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02MHrw96059317
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 22 Mar 2020 13:53:59 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 22 Mar 2020 10:53:57 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 22 Mar 2020 10:53:57 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02MHro3h027953;
        Sun, 22 Mar 2020 13:53:55 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <Laszlo.Nagy@analog.com>,
        <Andrei.Grozav@analog.com>, <Michael.Hennerich@analog.com>,
        <Istvan.Csomortani@analog.com>, <Adrian.Costina@analog.com>,
        <Dragos.Bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v12 2/8] include: fpga: adi-axi-common.h: add version helper macros
Date:   Sun, 22 Mar 2020 19:53:19 +0200
Message-ID: <20200322175325.42469-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322175325.42469-1-alexandru.ardelean@analog.com>
References: <20200322175325.42469-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_06:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=964
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003220107
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The format for all ADI AXI IP cores is the same.
i.e. 'major.minor.patch'.

This patch adds the helper macros to be re-used in ADI AXI drivers.

Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/fpga/adi-axi-common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
index ebd4e07ae3d8..141ac3f251e6 100644
--- a/include/linux/fpga/adi-axi-common.h
+++ b/include/linux/fpga/adi-axi-common.h
@@ -16,4 +16,8 @@
 #define ADI_AXI_PCORE_VER(major, minor, patch)	\
 	(((major) << 16) | ((minor) << 8) | (patch))
 
+#define ADI_AXI_PCORE_VER_MAJOR(version)	(((version) >> 16) & 0xff)
+#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
+#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
+
 #endif /* ADI_AXI_COMMON_H_ */
-- 
2.17.1

