Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE4F1D30F4
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 15:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgENNRx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 09:17:53 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57762 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgENNRx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 09:17:53 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04ED9Xa4020333;
        Thu, 14 May 2020 09:17:38 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3100x5yeaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 09:17:38 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 04EDHbdm059585
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 May 2020 09:17:37 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 09:17:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 14 May 2020 09:17:35 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 May 2020 09:17:35 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04EDHUak017033;
        Thu, 14 May 2020 09:17:33 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
CC:     <ludovic.desroches@microchip.com>, <eugen.hristev@microchip.com>,
        <jic23@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <ak@it-klinger.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/8] iio: proximity: ping: pass reference to IIO device via call-stack
Date:   Thu, 14 May 2020 16:17:03 +0300
Message-ID: <20200514131710.84201-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514131710.84201-1-alexandru.ardelean@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_03:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since there will be some changes to how iio_priv_to_dev() is implemented,
it could be that the helper becomes a bit slower, as it will be hidden away
in the IIO core.

For this driver, the IIO device can be passed directly as a parameter to
the ping_read() function, thus making it immune to the change of
iio_priv_to_dev().

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/proximity/ping.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
index 12b893c5b0ee..ddc43a5a2ef8 100644
--- a/drivers/iio/proximity/ping.c
+++ b/drivers/iio/proximity/ping.c
@@ -89,14 +89,13 @@ static irqreturn_t ping_handle_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int ping_read(struct ping_data *data)
+static int ping_read(struct iio_dev *indio_dev, struct ping_data *data)
 {
 	int ret;
 	ktime_t ktime_dt;
 	s64 dt_ns;
 	u32 time_ns, distance_mm;
 	struct platform_device *pdev = to_platform_device(data->dev);
-	struct iio_dev *indio_dev = iio_priv_to_dev(data);
 
 	/*
 	 * just one read-echo-cycle can take place at a time
@@ -236,7 +235,7 @@ static int ping_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		ret = ping_read(data);
+		ret = ping_read(indio_dev, data);
 		if (ret < 0)
 			return ret;
 		*val = ret;
-- 
2.17.1

