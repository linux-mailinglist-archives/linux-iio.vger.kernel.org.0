Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F692D2BC4
	for <lists+linux-iio@lfdr.de>; Tue,  8 Dec 2020 14:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgLHNQJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Dec 2020 08:16:09 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23754 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbgLHNQI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Dec 2020 08:16:08 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B8D9kI5009873;
        Tue, 8 Dec 2020 08:15:25 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3584x99akd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 08:15:25 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0B8DFOg4049673
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Dec 2020 08:15:24 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 8 Dec 2020
 08:15:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 8 Dec 2020 08:15:23 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B8DFKdT000595;
        Tue, 8 Dec 2020 08:15:22 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v3 2/3] Documentation/ABI/testing: Add documentation for AD5766 new ABI
Date:   Tue, 8 Dec 2020 15:19:56 +0200
Message-ID: <20201208131957.34381-2-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208131957.34381-1-cristian.pop@analog.com>
References: <20201208131957.34381-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_09:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080081
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New interface is proposed for dither functionality. This future allows
composing  an external signals to the selected output channel.
The dither signal can be turned on/off, scaled, inverted, or it can be
selected from different sources.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-dac-ad5766      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
new file mode 100644
index 000000000000..361bbd0862df
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
@@ -0,0 +1,45 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_pwr
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Dither power on/off. Write 0 to power on dither or 1 to power it off.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_invert
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Inverts the dither applied to the selected DAC channel. Dither signal is
+		not inverted (default) Dither signal is inverted.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Returns possible scalings available for the current channel:
+		"NO_SCALING 75%_SCALING 50%_SCALING 25%_SCALING"
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Scales the dither before it is applied to the selected channel.
+		NO_SCALING - No scaling
+		75%_SCALING - 75% scaling
+		50%_SCALING - 50% scaling
+		25%_SCALING - 25% scaling
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_source_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Returns possible dither sources available for the selected channel:
+		"NO_DITHER N0 N1"
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_source
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Selects dither source applied to the selected channel.
+		NO_DITHER - No dither applied
+		N0 - N0 dither signal applied
+		N1 - N1 dither signal applied
-- 
2.17.1

