Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148A044AD9A
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 13:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbhKIMex (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 07:34:53 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41072 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242647AbhKIMev (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 07:34:51 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A97XMEe019699;
        Tue, 9 Nov 2021 07:32:05 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c7156xter-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 07:32:04 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1A9CW3p7053014
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Nov 2021 07:32:03 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 9 Nov 2021 07:32:02 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 9 Nov 2021 07:32:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Tue, 9 Nov 2021 07:32:02 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A9CVsT0007733;
        Tue, 9 Nov 2021 07:32:01 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 4/4] iio:filter:admv8818: Add sysfs ABI documentation
Date:   Tue, 9 Nov 2021 14:31:27 +0200
Message-ID: <20211109123127.96399-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109123127.96399-1-antoniu.miclaus@analog.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: JU0N3Abg7pvmQWk5AsskCmBZafEG25D1
X-Proofpoint-ORIG-GUID: JU0N3Abg7pvmQWk5AsskCmBZafEG25D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add initial ABI documentation for admv8818 filter sysfs interfaces.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-filter-admv8818 | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
new file mode 100644
index 000000000000..7fa5b0819055
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
@@ -0,0 +1,60 @@
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
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_mode_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading this returns the valid values that can be written to the
+		on_altvoltage0_mode attribute:
+
+		- auto -> enable/register the clock rate notifier
+		- manual -> disable/unregister the clock rate notifier
+		- bypass -> bypass LPF/HPF and disable/unregister the clock rate notifier
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_mode
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute configures the filter mode.
+		Reading returns the actual mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_band_pass_bandwidth_3db_frequency
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Store the band pass bandwidth frequency value applied.
+		Reading returns the bandwidth frequency scaled.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_band_pass_center_frequency
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Store the band pass center frequency value applied.
+		Reading returns the center frequency scaled.
-- 
2.33.1

