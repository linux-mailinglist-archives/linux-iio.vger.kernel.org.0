Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CDF27AA5D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Sep 2020 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgI1JKo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Sep 2020 05:10:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15144 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgI1JKj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Sep 2020 05:10:39 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08S955cX023719;
        Mon, 28 Sep 2020 05:10:38 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg5xpqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 05:10:38 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08S9AbBK012322
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 28 Sep 2020 05:10:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 28 Sep
 2020 05:10:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 28 Sep 2020 05:10:31 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08S9ANjZ026287;
        Mon, 28 Sep 2020 05:10:33 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v7 5/5] dt-bindings:iio:adc:adc.txt: Add documentation for channel label attribute
Date:   Mon, 28 Sep 2020 12:09:59 +0300
Message-ID: <20200928090959.88842-5-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928090959.88842-1-cristian.pop@analog.com>
References: <20200928090959.88842-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_07:2020-09-24,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Optional attribute for better identification of the channels.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changes in v7:
 - Add this extra commit
 Documentation/devicetree/bindings/iio/adc/adc.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.txt b/Documentation/devicetree/bindings/iio/adc/adc.txt
index 5bbaa330a250..4b37575bbddc 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/adc.txt
@@ -5,18 +5,24 @@ Optional properties for child nodes:
 - diff-channels : Differential channels muxed for this ADC. The first value
 		specifies the positive input pin, the second value the negative
 		input pin.
+- reg: The channel number.
+- label: Unique name to identify which channel this is.
 
 Example:
 	adc@0 {
 		compatible = "some,adc";
 		...
 		channel@0 {
+			reg = <0>;
+			label = "channel_0_name";
 			bipolar;
 			diff-channels = <0 1>;
 			...
 		};
 
 		channel@1 {
+			reg = <1>;
+			label = "channel_1_name";
 			diff-channels = <2 3>;
 			...
 		};
-- 
2.17.1

