Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D793B534FEB
	for <lists+linux-iio@lfdr.de>; Thu, 26 May 2022 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347542AbiEZNaT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 May 2022 09:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347539AbiEZNaT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 May 2022 09:30:19 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88982D9E82
        for <linux-iio@vger.kernel.org>; Thu, 26 May 2022 06:30:18 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QAwU4q032618;
        Thu, 26 May 2022 09:30:10 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3g93vdnpbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 09:30:10 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 24QDU9ig043041
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 May 2022 09:30:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 26 May
 2022 09:30:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 26 May 2022 09:30:08 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 24QDTvG4027216;
        Thu, 26 May 2022 09:30:00 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 0/5] dt-bindings: iio: update maintainers
Date:   Thu, 26 May 2022 16:45:57 +0300
Message-ID: <20220526134603.75216-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 4KYzOXG21DkeP12Rt0zdKOTEfcMyqbzU
X-Proofpoint-ORIG-GUID: 4KYzOXG21DkeP12Rt0zdKOTEfcMyqbzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_07,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=1 priorityscore=1501 mlxlogscore=614
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
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

Some of the emails in bindings maintainers section are not
working anymore. Update them with current ones.

Alexandru Tachici (5):
  dt-bindings: iio: accel: ADIS16240: update maintainers
  dt-bindings: iio: adc: AD9467: update maintainers
  dt-bindings: iio: adc: axi-adc: update maintainers
  dt-bindings: iio: dac: AD5770R: update maintainers
  dt-bindings: iio: imu: adis16480: update maintainers

 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 2 +-
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml      | 1 -
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml     | 1 -
 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 2 +-
 Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 2 +-
 5 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.25.1

