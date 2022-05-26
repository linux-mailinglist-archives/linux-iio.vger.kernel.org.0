Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB76534FEC
	for <lists+linux-iio@lfdr.de>; Thu, 26 May 2022 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347543AbiEZNaV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 May 2022 09:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347541AbiEZNaT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 May 2022 09:30:19 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883BD80B4
        for <linux-iio@vger.kernel.org>; Thu, 26 May 2022 06:30:18 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QDMhUT032607;
        Thu, 26 May 2022 09:30:16 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3g93vdnpcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 09:30:16 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 24QDUEVV011892
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 May 2022 09:30:14 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 May 2022 09:30:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 26 May 2022 09:30:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 26 May 2022 09:30:13 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 24QDTvG8027216;
        Thu, 26 May 2022 09:30:07 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 4/5] dt-bindings: iio: dac: AD5770R: update maintainers
Date:   Thu, 26 May 2022 16:46:01 +0300
Message-ID: <20220526134603.75216-5-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220526134603.75216-1-alexandru.tachici@analog.com>
References: <20220526134603.75216-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: w1f1lblZ5Rg8O818Ki6WIA4RT0GtIAV3
X-Proofpoint-ORIG-GUID: w1f1lblZ5Rg8O818Ki6WIA4RT0GtIAV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_07,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=767
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260066
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Update bindings maintainerns section.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
index fb2c48fc7ce4..24ac40180ac1 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices AD5770R DAC device driver
 
 maintainers:
-  - Mircea Caprioru <mircea.caprioru@analog.com>
+  - Alexandru Tachici <alexandru.tachici@analog.com>
 
 description: |
   Bindings for the Analog Devices AD5770R current DAC device. Datasheet can be
-- 
2.25.1

