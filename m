Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DA614B356
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgA1LK7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 06:10:59 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38168 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgA1LK7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jan 2020 06:10:59 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SBAl90021270;
        Tue, 28 Jan 2020 06:10:47 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xrgdbrejb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 06:10:47 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 00SBAk5J055721
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 28 Jan 2020 06:10:46 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 28 Jan
 2020 06:10:44 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 28 Jan 2020 06:10:44 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00SBAcpH004280;
        Tue, 28 Jan 2020 06:10:42 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ekigwana@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 3/3] MAINTAINERS: add entry for ADF4360 PLL driver
Date:   Tue, 28 Jan 2020 13:13:02 +0200
Message-ID: <20200128111302.24359-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200128111302.24359-1-alexandru.ardelean@analog.com>
References: <20200128111302.24359-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_03:2020-01-24,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280090
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Edward Kigwana <ekigwana@gmail.com>

Add entry in the MAINTAINERS file for the ADF4360 PLL driver.

Signed-off-by: Edward Kigwana <ekigwana@gmail.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e699fe378e71..d7a404084ad9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -462,6 +462,14 @@ ADDRESS SPACE LAYOUT RANDOMIZATION (ASLR)
 M:	Jiri Kosina <jikos@kernel.org>
 S:	Maintained
 
+ADF4360 PLL DRIVER
+M:	Edward Kigwana <ekigwana@gmail.com>
+W:	http://ez.analog.com/community/linux-device-drivers
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
+F:	drivers/iio/frequency/adf4360.c
+
 ADF7242 IEEE 802.15.4 RADIO DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 W:	https://wiki.analog.com/ADF7242
-- 
2.20.1

