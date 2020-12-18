Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2212DE7DE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Dec 2020 18:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgLRRJD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Dec 2020 12:09:03 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16188 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727787AbgLRRJB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Dec 2020 12:09:01 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BIGkVg6010949;
        Fri, 18 Dec 2020 12:08:19 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35cun963xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 12:08:19 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0BIH8Ii5003026
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 18 Dec 2020 12:08:18 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 18 Dec 2020 12:08:17 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 18 Dec 2020 12:08:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 18 Dec 2020 12:08:17 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BIH8D3U024409;
        Fri, 18 Dec 2020 12:08:15 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v4 2/3] Documentation/ABI/testing: Add documentation for AD5766 new ABI
Date:   Fri, 18 Dec 2020 19:12:30 +0200
Message-ID: <20201218171231.58794-2-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218171231.58794-1-cristian.pop@analog.com>
References: <20201218171231.58794-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_10:2020-12-18,2020-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=884
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180115
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New interface is proposed for dither functionality. This future allows
composing  an external signals to the selected output channel.
The dither signal can be turned on/off, scaled, inverted, or it can be
selected from different sources.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changelog v4:
	- Change to "in_voltageY_dither_enable"
	- Change scale to numbers + 100% for no scaling
	- Possible dither source values: 0 - N0, 1 - N1 
 .../ABI/testing/sysfs-bus-iio-dac-ad5766      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
new file mode 100644
index 000000000000..72100edb88bb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
@@ -0,0 +1,36 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_pwr
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Dither enable. Write 1 to enable dither or 0 to disable it.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_invert
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Inverts the dither applied to the selected DAC channel. Dither is not
+		inverted by default. Write "1" to invert dither.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Returns possible scalings available for the current channel:
+		"100 75 50 25" scaling.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Scales the dither before it is applied to the selected channel:
+		100 - No scaling
+		75 - 75% scaling
+		50 - 50% scaling
+		25 - 25% scaling
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_source
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Selects dither source applied to the selected channel. Write "0" to
+		select N0 source, write "1" to select N1 source.
-- 
2.17.1

