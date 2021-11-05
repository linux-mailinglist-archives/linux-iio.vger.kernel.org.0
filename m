Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBC4462B8
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 12:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhKELcc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 07:32:32 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3922 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232477AbhKELc0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Nov 2021 07:32:26 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A50Y995019438;
        Fri, 5 Nov 2021 07:29:46 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c4t6f2pmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 07:29:46 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1A5BTiJK018153
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Nov 2021 07:29:45 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 5 Nov 2021 04:29:43 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 5 Nov 2021 04:29:43 -0700
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A5BTbk2016952;
        Fri, 5 Nov 2021 07:29:41 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 3/3] Documentation:ABI:testing:admv1013: add ABI docs
Date:   Fri, 5 Nov 2021 13:29:30 +0200
Message-ID: <20211105112930.122017-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105112930.122017-1-antoniu.miclaus@analog.com>
References: <20211105112930.122017-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 25fAEDbZ74pFKj2nyww-Bf3sJFjEXCuv
X-Proofpoint-ORIG-GUID: 25fAEDbZ74pFKj2nyww-Bf3sJFjEXCuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111050067
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the use of the Local Oscillator Feedthrough Offset
calibration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../testing/sysfs-bus-iio-frequency-admv1013  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
new file mode 100644
index 000000000000..f52cd55a66c6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
@@ -0,0 +1,27 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_i_lo_feedthrough_offset_calib_positive
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Positive
+		in the Intermediate Frequency mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_i_lo_feedthrough_offset_calib_negative
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Negative
+		in the Intermediate Frequency mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_q_lo_feedthrough_offset_calib_positive
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Positive
+		in the Intermediate Frequency mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_q_lo_feedthrough_offset_calib_negative
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Negative
+		in the Intermediate Frequency mode.
-- 
2.33.1

