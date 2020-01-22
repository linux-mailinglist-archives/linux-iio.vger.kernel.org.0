Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79E145449
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2020 13:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgAVMPu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jan 2020 07:15:50 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38542 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbgAVMPt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jan 2020 07:15:49 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MCF74Z012293;
        Wed, 22 Jan 2020 07:15:29 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkvrbjpyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 07:15:29 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 00MCFS0R041149
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 22 Jan 2020 07:15:28 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 22 Jan
 2020 07:15:27 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 22 Jan 2020 04:15:26 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00MCF513031122;
        Wed, 22 Jan 2020 07:15:23 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 3/3] MAINTAINERS: add entry for hmc425a driver.
Date:   Wed, 22 Jan 2020 14:17:02 +0200
Message-ID: <20200122121702.30494-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122121702.30494-1-beniamin.bia@analog.com>
References: <20200122121702.30494-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=1 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=853 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001220112
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia and Michael Hennerich as maintainers for HMC425A
attenuator.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec05a06d7ddb..9ae436d67edf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1057,6 +1057,15 @@ F:	drivers/iio/adc/ltc249*
 X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
 
+ANALOG DEVICES INC HMC425A DRIVER
+M:	Beniamin Bia <beniamin.bia@analog.com>
+M:	Michael Hennerich <michael.hennerich@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/amplifiers/hmc425a.c
+F:	Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+
 ANALOGBITS PLL LIBRARIES
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 S:	Supported
-- 
2.17.1

