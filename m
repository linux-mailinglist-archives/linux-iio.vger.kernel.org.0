Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1294E75D9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 17:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbfJ1QMa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Oct 2019 12:12:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61586 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390825AbfJ1QM2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Oct 2019 12:12:28 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9SFuC3Q007135;
        Mon, 28 Oct 2019 17:11:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=hs9ioC3FUJXhQf7N0szd3cgJObNevzhxvfuz9gmEXh8=;
 b=Wpap3FJf02ByLfmEWx9FQx24YE+6nbvxX+EN3K5zctz/trU6NDbryNX/JyB1H3gE2ek0
 dMPzjXS5+0UNs5glJx6oenf+5J2GngjIF6W6FNzEJHcle1jkF9Ou/9pP9DX6fnXqaUYw
 cvHq1pbCilG4b42kPTIpNmd9tirQPM+Uxet39c04osMVx9YetBlsVzXcjJan65YtInrB
 puMnJYmDkQNXGguQ0/Wtx3MKsDpFBdeVGj7TjsLV0v9/R4ozcTZlE/3HwDKFTanm1Ynq
 IewwaAMIjqBxe0P4LmeDTNrMXB9P55iufz7iZEUGxEKxtlzQ3Cj1eBtOU7GKLXkzXwFU QQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vvbm0b68j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 17:11:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 861EB100038;
        Mon, 28 Oct 2019 17:11:55 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 713B32B1E79;
        Mon, 28 Oct 2019 17:11:55 +0100 (CET)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 28 Oct
 2019 17:11:55 +0100
Received: from localhost (10.48.0.192) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 28 Oct 2019 17:11:54 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: stm32-adc: add max clock rate property
Date:   Mon, 28 Oct 2019 17:11:47 +0100
Message-ID: <1572279108-25916-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572279108-25916-1-git-send-email-fabrice.gasnier@st.com>
References: <1572279108-25916-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_06:2019-10-28,2019-10-28 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add optional dt property to tune maximum desired analog clock rate.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
index 4c0da8c..8de9331 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
@@ -53,6 +53,8 @@ Optional properties:
   analog input switches on stm32mp1.
 - st,syscfg: Phandle to system configuration controller. It can be used to
   control the analog circuitry on stm32mp1.
+- st,max-clk-rate-hz: Allow to specify desired max clock rate used by analog
+  circuitry.
 
 Contents of a stm32 adc child node:
 -----------------------------------
-- 
2.7.4

