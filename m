Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5A1391ED
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 14:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgAMNQA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 08:16:00 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5658 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728665AbgAMNP7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 08:15:59 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DDCY4e025708;
        Mon, 13 Jan 2020 14:15:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=DU1Kp8lh2uFkanGLFhtVCisPZCszaBxv5SgsLyQ1bx0=;
 b=EtavOXx/JdnjibUoR7WnFypLoKMkRohpE5L/Nb81EOal4LSsz/5uTlINyd4wZ0v4P992
 xZBqWFbOPXSUD74IL1Z4L+mmRF+lGgBy+o8EM35keWM3XB2s4HbsE/fTnFdivv/SO9uR
 gKIf5AM//8nZh+s6ihTSOG56U7BL2x/vBDf24X6c83oPdEYn+5Rpt7xzV87MJMBu/QRb
 2bDzK6ENeUhu1NyPuBL7wR0Hbq+YcCPRwnSXi1Y4/H+8hX6NE+uCtl2+X+v+BvlB0onm
 w6XngRN5MWimVD+I3RiHa9aTYP+gLdxgDu3pr1IiAsVZkqwKVQjebx29KbGbX/lx9UPr sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf78s07du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 14:15:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A03BF10003A;
        Mon, 13 Jan 2020 14:15:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 925452B820F;
        Mon, 13 Jan 2020 14:15:34 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan 2020 14:15:34
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <etienne.carriere@st.com>
Subject: [PATCH 2/2] iio: dac: stm32-dac: better handle reset controller failures
Date:   Mon, 13 Jan 2020 14:14:26 +0100
Message-ID: <1578921266-6025-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578921266-6025-1-git-send-email-fabrice.gasnier@st.com>
References: <1578921266-6025-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_03:2020-01-13,2020-01-13 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

Use devm_reset_control_get_optional_exclusive() instead of
devm_reset_control_get_exclusive() as reset controller is optional.

Nevertheless if reset controller is expected but reports an
error, propagate the error code to the caller. In such case
a nice error trace is emitted unless we're deferring the probe
operation.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/dac/stm32-dac-core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index 4d93446..7e5809b 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -147,8 +147,16 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	priv->common.vref_mv = ret / 1000;
 	dev_dbg(dev, "vref+=%dmV\n", priv->common.vref_mv);
 
-	rst = devm_reset_control_get_exclusive(dev, NULL);
-	if (!IS_ERR(rst)) {
+	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (rst) {
+		if (IS_ERR(rst)) {
+			ret = PTR_ERR(rst);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "reset get failed, %d\n", ret);
+
+			goto err_hw_stop;
+		}
+
 		reset_control_assert(rst);
 		udelay(2);
 		reset_control_deassert(rst);
-- 
2.7.4

