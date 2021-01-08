Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9130A2EF771
	for <lists+linux-iio@lfdr.de>; Fri,  8 Jan 2021 19:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbhAHSey (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Jan 2021 13:34:54 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1358 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbhAHSex (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jan 2021 13:34:53 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108IK5H7015845;
        Fri, 8 Jan 2021 13:34:12 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35wnkjnwmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 13:34:12 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 108IYBLp059766
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 Jan 2021 13:34:11 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 8 Jan 2021 13:34:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 8 Jan 2021 13:34:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 8 Jan 2021 13:34:10 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 108IY6P8025936;
        Fri, 8 Jan 2021 13:34:07 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v5 2/3] Documentation/ABI/testing: Add documentation for AD5766 new ABI
Date:   Fri, 8 Jan 2021 20:37:38 +0200
Message-ID: <20210108183739.27634-2-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108183739.27634-1-cristian.pop@analog.com>
References: <20210108183739.27634-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_08:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=915 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080100
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New interface is proposed for dither functionality. This future allows
composing  an external signals to the selected output channel.
The dither signal can be turned on/off, scaled, inverted, or it can be
selected from different sources.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changelog v5:                                                              
        - Rename property to: "in_voltageY_dither_enable"                  
        - Change scale values to: "1 0.75 0.5 0.25"                        
        - Specify KernelVersion
 .../ABI/testing/sysfs-bus-iio-dac-ad5766      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
new file mode 100644
index 000000000000..6e5e383b2c53
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
@@ -0,0 +1,31 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_ennable
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

