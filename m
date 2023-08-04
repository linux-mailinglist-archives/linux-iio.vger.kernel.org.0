Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96A176FA58
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 08:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjHDGq1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 02:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjHDGq0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 02:46:26 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A04BB1;
        Thu,  3 Aug 2023 23:46:25 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3745RAYk011332;
        Fri, 4 Aug 2023 02:46:16 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s8gfs3squ-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 02:46:16 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3746kFma016036
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 02:46:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 4 Aug 2023
 02:46:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Aug 2023 02:46:14 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.173])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3746k49i009664;
        Fri, 4 Aug 2023 02:46:07 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v3 0/3] Add new channels for adis16475
Date:   Fri, 4 Aug 2023 09:45:56 +0300
Message-ID: <20230804064559.47192-1-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: FM2-QoP4mYltiQxw68tyP-C46awF1VBF
X-Proofpoint-GUID: FM2-QoP4mYltiQxw68tyP-C46awF1VBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_04,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=676 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308040059
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

changes in v3:
 new patches: 1,2 which add IIO_DELTA_ANGL and IIO_DELTA_VELOCITY channel types
 patch3: 
  - added new flag for presence of delta measuremets in burst data
  - removed available scan mask, a simple check is performed in
  adis16475_update_scan_mode to see if the scan mask is valid and to configure
  the burst data selection based on the scan mask.

Ramona Bolboaca (3):
  iio: Add IIO_DELTA_ANGL channel type
  iio: Add IIO_DELTA_VELOCITY channel type
  iio: imu: adis16475.c: Add delta angle and delta velocity channels

 Documentation/ABI/testing/sysfs-bus-iio |  29 +++++
 drivers/iio/imu/adis16475.c             | 165 +++++++++++++++++++++---
 drivers/iio/industrialio-core.c         |   2 +
 include/uapi/linux/iio/types.h          |   2 +
 tools/iio/iio_event_monitor.c           |   4 +
 5 files changed, 183 insertions(+), 19 deletions(-)

-- 
2.25.1

