Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDFF11CE8E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2019 14:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfLLNlM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Dec 2019 08:41:12 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31692 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729429AbfLLNlM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Dec 2019 08:41:12 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCDX8B9014903;
        Thu, 12 Dec 2019 14:40:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=EECYZHFR16QeGgFp8/nIGvYQcr9i/Ememz5tKDUC7IA=;
 b=H3BkUzaf4191aRzb5CY9tFXYTu803HE6HHHS9YoAEoV7PNVILci/IItZH/WbUSzlVPsU
 9CNFAkvfaHMueqZlOpikrX97h/H+cMzboyxXa6jSVr/enrTYglb3w2YE6puE00BoZV5G
 jhDgrQxAmDLlK8IklJkV5XYkSs3h9SUYLYGqmGCJvjurJia0yOAtYPUWll6mCvvujyAk
 zidS3Qh8u7C4FneSeICkTAUehW4BosnPKSHvFGOidJ5EBXFuhhl8CAwQlha++oGkimDb
 eOhqx8aegSHDcEqkOsk32X1+kd3QtwEPdqI1PKwvaj7T2dqaqPmH8SpeudTaxA2A1uP6 AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wt5wv4ufc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 14:40:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 80B0410002A;
        Thu, 12 Dec 2019 14:40:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5088621F637;
        Thu, 12 Dec 2019 14:40:39 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 12 Dec 2019 14:40:38
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <marcelo.schmitt1@gmail.com>, <Jonathan.Cameron@huawei.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>
Subject: [PATCH] dt-bindings: iio: ad7192: Fix DTC error in reg schema
Date:   Thu, 12 Dec 2019 14:40:37 +0100
Message-ID: <20191212134037.1049-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_03:2019-12-12,2019-12-12 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add minimum field to be compliant to json-schema

Fixes: d898f9ac542f9 ("dt-bindings: iio: adc: Add dt-schema for AD7292")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
index b68be3aaf587..d804a8a78bea 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -53,6 +53,7 @@ patternProperties:
         description: |
           The channel number. It can have up to 8 channels numbered from 0 to 7.
         items:
+          minimum: 0
           maximum: 7
 
       diff-channels:
-- 
2.15.0

