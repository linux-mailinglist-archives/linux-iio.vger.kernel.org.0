Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF89145A20C
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 12:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhKWL55 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 06:57:57 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29322 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236690AbhKWL54 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 06:57:56 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ANAQJFo009170;
        Tue, 23 Nov 2021 06:54:48 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cg6mm02wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 06:54:47 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1ANBskPB035315
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 06:54:46 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Tue, 23 Nov 2021
 06:54:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 23 Nov 2021 06:54:45 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1ANBsf0i026107;
        Tue, 23 Nov 2021 06:54:44 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 3/3] Documentation:ABI:testing:admv1013: add ABI docs
Date:   Tue, 23 Nov 2021 13:53:36 +0200
Message-ID: <20211123115336.65827-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123115336.65827-1-antoniu.miclaus@analog.com>
References: <20211123115336.65827-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ynV-WJZ81v6bKh2guvOpsRd31cExjisy
X-Proofpoint-ORIG-GUID: ynV-WJZ81v6bKh2guvOpsRd31cExjisy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_04,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230066
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the use of the Local Oscillator Feedthrough Offset
calibration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v5:
 - rework the custom device attributes based on the feedback received in v4
 - add frequency translation modes custom attributes.
 .../testing/sysfs-bus-iio-frequency-admv1013  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
new file mode 100644
index 000000000000..3ff80909f007
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
@@ -0,0 +1,55 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_phase_i
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior path quadrature I phase shift.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_phase_q
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior path quadrature Q phase shift.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_calibbias_i
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Positive
+		side.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_calibbias_q
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Positive
+		side.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage1_calibbias_i
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Negative
+		side.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage1_calibbias_q
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Negative
+		side.
+
+What:		/sys/bus/iio/devices/iio:deviceX/freq_mode_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading this returns the valid values that can be written to the freq_mode attribute.
+
+		- if -> Intermediate Frequency
+		- iq -> Quadrature I/Q mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/freq_mode
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute configures the frequency mode.
+		Reading returns the actual mode.
-- 
2.34.0

