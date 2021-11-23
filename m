Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFD45A3F1
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 14:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhKWNmb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 08:42:31 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53070 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236433AbhKWNma (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 08:42:30 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ANArOFH009162;
        Tue, 23 Nov 2021 08:39:21 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cg6mm0kww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 08:39:21 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1ANDdK57007030
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 08:39:20 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 23 Nov 2021 08:39:19 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 23 Nov 2021 08:39:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 23 Nov 2021 08:39:19 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1ANDdETA000435;
        Tue, 23 Nov 2021 08:39:18 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 4/4] iio:filter:admv8818: Add sysfs ABI documentation
Date:   Tue, 23 Nov 2021 15:39:00 +0200
Message-ID: <20211123133900.133027-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123133900.133027-1-antoniu.miclaus@analog.com>
References: <20211123133900.133027-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: kgfb73q7j9_P-d2qsvthYt3TU2aDdlgW
X-Proofpoint-ORIG-GUID: kgfb73q7j9_P-d2qsvthYt3TU2aDdlgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_04,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add initial ABI documentation for admv8818 filter sysfs interfaces.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - remove bandwidth/center frequency related custom device attributes
 - remove bypass filter mode
 .../ABI/testing/sysfs-bus-iio-filter-admv8818 | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
new file mode 100644
index 000000000000..7211b5d0daa0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
@@ -0,0 +1,44 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_high_pass_3db_frequency
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The cut-off frequency of the ADMV8818 high pass filter. The value is scaled using
+		the `out_altvoltageY_scale` attribute so that GHz frequencies are valid inputs,
+		The accepted range of values for the frequencies is between 1.75GHz and 19.9GHz.
+
+		The default value for the scale is 1000000, therefore MHz frequency values are
+		passed as input.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_low_pass_3db_frequency
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The cut-off frequency of the ADMV8818 low pass filter. The value is scaled using
+		the `out_altvoltageY_scale` attribute so that GHz frequencies are valid inputs,
+		The accepted range of values for the frequencies is between 2.05GHz and 18.85GHz.
+
+		The default value for the scale is 1000000, therefore MHz frequency values are
+		passed as input.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Scale high pass and lowpass filter frequency values to Hz.
+
+What:		/sys/bus/iio/devices/iio:deviceX/filter_mode_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading this returns the valid values that can be written to the
+		on_altvoltage0_mode attribute:
+
+		- auto -> Adjust bandpass filter to track changes in input clock rate.
+		- manual -> disable/unregister the clock rate notifier / input clock tracking.
+
+What:		/sys/bus/iio/devices/iio:deviceX/filter_mode
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute configures the filter mode.
+		Reading returns the actual mode.
-- 
2.34.0

