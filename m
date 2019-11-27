Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5807710AD36
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2019 11:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfK0KHg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Nov 2019 05:07:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1264 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726537AbfK0KHg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Nov 2019 05:07:36 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARA78Z8032339;
        Wed, 27 Nov 2019 11:07:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=9tjm8fNHXd7RQHbuYQoITgl8ZEvG9cJE+90w2nU8sfU=;
 b=qa/4NoKEDSzC0bbGBLnavax+pgzTcNiOdWZAy9YsZwtUEjb7FYQCEPSRllDjTbN3IdnX
 UojIu3TVSkFQWm/JzsQTjVvdbW7CZ+rqsraHgSnm69inuICIC3HS7f49qUJYkPUJymKF
 a1wltB9XWTKH7Og/vidIKNlPdCIfpldcmJj5aMZMVJQSMiUMdqxOP8Fl5mEuJ8GL4lVK
 DbL8SQwVPzny+2CDlQdUC/+Ur6LK8Trzy4Uuc1di3MlCOXaudLkMzIF08SF7VRX+yfJJ
 40MzuqvD2URqX2OdFUYpD2hCoyZ6GG3dXDW3uAHda3mLXh53VEtzPAT+RZ+dYVnDdbRU Dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxsawxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 11:07:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4958810002A;
        Wed, 27 Nov 2019 11:06:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 941992AEF1C;
        Wed, 27 Nov 2019 11:06:59 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 27 Nov 2019 11:06:59
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>,
        <olivier.moysan@st.com>
Subject: [INTERNAL][PATCH] iio: adc: stm32-dfsdm: fix single conversion
Date:   Wed, 27 Nov 2019 11:06:57 +0100
Message-ID: <20191127100657.24485-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_02:2019-11-27,2019-11-27 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Apply data formatting to single conversion,
as this is already done in continuous and trigger modes.

Fixes: 102afde62937 ("iio: adc: stm32-dfsdm: manage data resolution in trigger mode")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index e493242c266e..0339ecdd06bd 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1204,6 +1204,8 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 
 	stm32_dfsdm_stop_conv(adc);
 
+	stm32_dfsdm_process_data(adc, res);
+
 stop_dfsdm:
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 
-- 
2.17.1

