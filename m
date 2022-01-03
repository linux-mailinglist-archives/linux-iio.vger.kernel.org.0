Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4510F483060
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jan 2022 12:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiACLQk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jan 2022 06:16:40 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44810 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbiACLQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jan 2022 06:16:40 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 202NJNcr023402
        for <linux-iio@vger.kernel.org>; Mon, 3 Jan 2022 06:16:40 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3damr7u9b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 03 Jan 2022 06:16:39 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 203BGcSh053629
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-iio@vger.kernel.org>; Mon, 3 Jan 2022 06:16:38 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Jan 2022 06:16:37 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Jan 2022 06:16:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Jan 2022 06:16:37 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 203BGXjJ032120;
        Mon, 3 Jan 2022 06:16:35 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] MAINTAINERS: add maintainer for ADRF6780 driver
Date:   Mon, 3 Jan 2022 13:16:24 +0200
Message-ID: <20220103111624.82262-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: KNiPzla0-Hoa3lwiGMZX5E_rNlBfr7Pa
X-Proofpoint-GUID: KNiPzla0-Hoa3lwiGMZX5E_rNlBfr7Pa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_04,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add myself as maintainer for the ADRF6780 driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7168aa..ffeb0cc83ee5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1127,6 +1127,14 @@ S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/power/supply/adp5061.c
 
+ANALOG DEVICES INC ADRF6780 DRIVER
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
+F:	drivers/iio/frequency/adrf6780.c
+
 ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
 L:	linux-media@vger.kernel.org
-- 
2.34.1

