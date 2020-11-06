Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD762A9B2F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Nov 2020 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgKFRus (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Nov 2020 12:50:48 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:62702 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbgKFRus (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Nov 2020 12:50:48 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6HmTgh004037;
        Fri, 6 Nov 2020 18:50:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=eMPMn91cCHyM/mIF1zD+SFO1I52TNwQPU0lvOZDdToE=;
 b=0O4Jge/UIjwArzKM0JVlUhlUH2fxXAeEsWZ/yltz9MTsSYTFpAAsLtrDg5WdoAaQMkru
 OkOK7UK0R3L+9OB6aiNpgOJos37Wn0LlneVS3Acz3XA1pRVfLxnzPOHsSZCK1in3fkcw
 qaBmoSUorZLH8wyf974OfunbogdJ/BzF5uq45ziSn9U/0blx1S3KGzCrE8K+xkqcMMlj
 6YKylkhBXg9ycxHSdsWiWvQBtPN4c8aK69cxW+7mTPr5MSqBF7ehIk59p+Xc5IdqO29p
 0yTiYR3SFpJhRFkqcuv2eQtEUxcCcAGb1JrKjGihNHLsHOADmwMANFBpe7bs/w2ZaoeI eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h00ewstr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 18:50:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7865D100034;
        Fri,  6 Nov 2020 18:50:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67B612150EE;
        Fri,  6 Nov 2020 18:50:34 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG1NODE3.st.com (10.75.127.3)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 18:50:33
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <mchehab+huawei@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] docs: ABI: testing: iio: stm32: remove re-introduced unsupported ABI
Date:   Fri, 6 Nov 2020 18:50:16 +0100
Message-ID: <1604685016-2434-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove unsupported ABI that has been re-introduced due to a rebase hunk.
This ABI has been moved in the past in commit b299d00420e2
("IIO: stm32: Remove quadrature related functions from trigger driver")

This also fixes a couple of warnings seen with:
./scripts/get_abi.pl validate 2>&1|grep iio

Fixes: 34433332841d ("docs: ABI: testing: make the files compatible with ReST output")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../ABI/testing/sysfs-bus-iio-timer-stm32          | 24 ----------------------
 1 file changed, 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
index a10a4de..c4a4497 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
+++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
@@ -109,30 +109,6 @@ Description:
 		When counting down the counter start from preset value
 		and fire event when reach 0.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
-KernelVersion:	4.12
-Contact:	benjamin.gaignard@st.com
-Description:
-		Reading returns the list possible quadrature modes.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode
-KernelVersion:	4.12
-Contact:	benjamin.gaignard@st.com
-Description:
-		Configure the device counter quadrature modes:
-
-		channel_A:
-			Encoder A input servers as the count input and B as
-			the UP/DOWN direction control input.
-
-		channel_B:
-			Encoder B input serves as the count input and A as
-			the UP/DOWN direction control input.
-
-		quadrature:
-			Encoder A and B inputs are mixed to get direction
-			and count with a scale of 0.25.
-
 What:		/sys/bus/iio/devices/iio:deviceX/in_count_enable_mode_available
 KernelVersion:	4.12
 Contact:	benjamin.gaignard@st.com
-- 
2.7.4

