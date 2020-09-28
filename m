Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFEC27AA59
	for <lists+linux-iio@lfdr.de>; Mon, 28 Sep 2020 11:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgI1JKf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Sep 2020 05:10:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10516 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbgI1JKe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Sep 2020 05:10:34 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08S97DPH020689;
        Mon, 28 Sep 2020 05:10:33 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4ej0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 05:10:33 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08S9AVXJ065280
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 28 Sep 2020 05:10:32 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 28 Sep 2020 02:10:25 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 28 Sep 2020 02:10:28 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 28 Sep 2020 02:10:25 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08S9ANjW026287;
        Mon, 28 Sep 2020 05:10:27 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v7 2/5] iio:Documentation: Add documentation for label channel attribute
Date:   Mon, 28 Sep 2020 12:09:56 +0300
Message-ID: <20200928090959.88842-2-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928090959.88842-1-cristian.pop@analog.com>
References: <20200928090959.88842-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_07:2020-09-24,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=875 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If a label is defined for this channel add that to the channel specific
attributes. This is useful for userspace to be able to identify an
individual channel.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changes in v7:
 - Specify affected only channels which we are implementing in this patch
   set. 
 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a9d51810a3ba..4a72ee43dee8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1715,6 +1715,16 @@ Description:
 
 		Raw counter device counters direction for channel Y.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_label
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Optional symbolic label to a device channel.
+		If a label is defined for this channel add that to the channel
+		specific attributes. This is useful for userspace to be able to
+		better identify an individual channel.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
 KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org
-- 
2.17.1

