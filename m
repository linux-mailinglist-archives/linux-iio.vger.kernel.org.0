Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3DA5652D2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiGDK4c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 06:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiGDK4a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 06:56:30 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C43EE27
        for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2022 03:56:29 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2648CRac019046;
        Mon, 4 Jul 2022 06:56:21 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h2fv7m2qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 06:56:21 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 264AuJbA009436
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jul 2022 06:56:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 4 Jul 2022
 06:56:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 4 Jul 2022 06:56:18 -0400
Received: from euswvd-wpr-708.reddog.microsoft.com ([10.140.226.204])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 264Au7Bv000846;
        Mon, 4 Jul 2022 06:56:16 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jic23@kernel.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: [PATCH 2/3] Documentation: ABI: testing: add max11410 doc
Date:   Mon, 4 Jul 2022 10:53:58 +0000
Message-ID: <20220704105400.106-2-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220704105400.106-1-Ibrahim.Tilki@analog.com>
References: <20220704105400.106-1-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: pn-zNAQagt_ox9swM2azcMD_5xsrd1XZ
X-Proofpoint-GUID: pn-zNAQagt_ox9swM2azcMD_5xsrd1XZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=940 spamscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040047
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Added documentation for Analog Devices max11410 adc userspace sysfs.

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-max11410         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max11410

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max11410 b/Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
new file mode 100644
index 000000000..c18658fbf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
@@ -0,0 +1,14 @@
+What:		/sys/bus/iio/devices/iio:deviceX/filter
+Date:		June 2022
+KernelVersion:  5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configures the digital filters.
+		There are 4 configurations available:
+
+		========  ===================================
+		fir50/60  Simultaneous 50/60Hz FIR rejection.
+		fir50     50Hz FIR rejection.
+		fir60     60Hz FIR rejection.
+		sinc4     SINC4.
+		========  ===================================
-- 
2.36.1

