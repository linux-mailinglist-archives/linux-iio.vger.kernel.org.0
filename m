Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AF12F7771
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jan 2021 12:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbhAOLSe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jan 2021 06:18:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9592 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbhAOLSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2021 06:18:33 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10FBEp75010772;
        Fri, 15 Jan 2021 06:17:52 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 35ya984ab0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 06:17:52 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10FBHoTI025214
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jan 2021 06:17:50 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 15 Jan 2021 03:17:49 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Fri, 15 Jan 2021 03:17:49 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 15 Jan 2021 03:17:48 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10FBHhWL004415;
        Fri, 15 Jan 2021 06:17:45 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v6 2/3] Documentation/ABI/testing: Add documentation for AD5766 new ABI
Date:   Fri, 15 Jan 2021 13:21:04 +0200
Message-ID: <20210115112105.58652-2-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115112105.58652-1-cristian.pop@analog.com>
References: <20210115112105.58652-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-15_06:2021-01-15,2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150069
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New interface is proposed for dither functionality. This future allows
composing  an external signals to the selected output channel.
The dither signal can be turned on/off, scaled, inverted, or it can be
selected from different sources.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changelog v6:
	- Fix type; enable
 .../ABI/testing/sysfs-bus-iio-dac-ad5766      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
new file mode 100644
index 000000000000..7fbcba15bf1e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
@@ -0,0 +1,31 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_enable
+KernelVersion:	5.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Dither enable. Write 1 to enable dither or 0 to disable it.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_invert
+KernelVersion:	5.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Inverts the dither applied to the selected DAC channel. Dither is not
+		inverted by default. Write "1" to invert dither.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale_available
+KernelVersion:	5.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Returns possible scalings available for the current channel.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale
+KernelVersion:	5.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Scales the dither before it is applied to the selected channel.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_source
+KernelVersion:	5.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Selects dither source applied to the selected channel. Write "0" to
+		select N0 source, write "1" to select N1 source.
-- 
2.17.1

