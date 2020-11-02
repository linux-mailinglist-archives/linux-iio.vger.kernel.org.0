Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34E12A2C77
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 15:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKBORy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 09:17:54 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38440 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbgKBORm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 09:17:42 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2ECNpm001670;
        Mon, 2 Nov 2020 09:17:40 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34j3bwkrdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 09:17:40 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0A2EHd2c037203
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 2 Nov 2020 09:17:39 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 2 Nov 2020
 09:17:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 2 Nov 2020 09:17:38 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0A2EHJQF027353;
        Mon, 2 Nov 2020 09:17:35 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v7 5/5] dt-bindings:iio:adc:adc.txt: Add documentation for channel label attribute
Date:   Mon, 2 Nov 2020 16:20:00 +0200
Message-ID: <20201102142000.68916-5-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102142000.68916-1-cristian.pop@analog.com>
References: <20201102142000.68916-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_07:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020113
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

