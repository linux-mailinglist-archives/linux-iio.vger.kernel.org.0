Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B032A2C59
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 15:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgKBOOA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 09:14:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10098 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgKBON7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 09:13:59 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2EA0gi021842;
        Mon, 2 Nov 2020 09:13:57 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34h1s4xmhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 09:13:57 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0A2EDt7g044377
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 2 Nov 2020 09:13:56 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 2 Nov 2020 06:13:54 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 2 Nov 2020 06:13:54 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0A2EDbsG027259;
        Mon, 2 Nov 2020 09:13:52 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v7 2/5] iio:Documentation: Add documentation for label channel attribute
Date:   Mon, 2 Nov 2020 16:16:56 +0200
Message-ID: <20201102141659.41875-2-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102141659.41875-1-cristian.pop@analog.com>
References: <20201102141659.41875-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_07:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=871 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011020113
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

