Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01793F31DB
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhHTRCA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 13:02:00 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54394 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232701AbhHTRBz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 13:01:55 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17KDkZMa004326;
        Fri, 20 Aug 2021 13:01:07 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3ajdjwrppm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 13:01:06 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 17KH15gA019207
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 13:01:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 20 Aug 2021 13:01:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 20 Aug 2021 13:01:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Fri, 20 Aug 2021 13:01:04 -0400
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.46])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 17KH0YNR013729;
        Fri, 20 Aug 2021 13:01:02 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v4 4/6] Documentation:ABI:testing:add doc for AD3552R ABI
Date:   Fri, 20 Aug 2021 16:59:25 +0000
Message-ID: <20210820165927.4524-5-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210820165927.4524-1-mihail.chindris@analog.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: tVDNLBD-o5gpkim3Acyr3tz0rxCnDaDj
X-Proofpoint-GUID: tVDNLBD-o5gpkim3Acyr3tz0rxCnDaDj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_06,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200095
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for option for enabling precision mode
of ad3552r

Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r
new file mode 100644
index 000000000000..37573245f3d5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r
@@ -0,0 +1,10 @@
+What:		/sys/bus/iio/devices/iio:deviceX/precision_mode_en
+KernelVersion:	5.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Select between fast mode and precison mode.
+		0: Fast mode      - For 12 bits precision, the most significant
+				    bits are used and 16 bits are sent to the
+				    device per channel, lats bits being 0.
+		1: Precision mode - For 16 bits precision, 24 bits are sent to
+				    the device per channel, last bits being 0.
-- 
2.27.0

