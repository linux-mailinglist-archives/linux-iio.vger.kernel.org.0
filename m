Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356F21E0DDE
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 13:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbgEYLxy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 07:53:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2594 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390196AbgEYLxy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 07:53:54 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04PBlZmw011653;
        Mon, 25 May 2020 07:53:40 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3170r5x8v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 07:53:39 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 04PBrcBk039925
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 25 May 2020 07:53:38 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 25 May 2020 04:53:37 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 25 May 2020 04:53:36 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 25 May 2020 04:53:36 -0700
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 04PBrUvH018765;
        Mon, 25 May 2020 07:53:33 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     <jic23@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linus.walleij@linaro.org>,
        <lorenzo.bianconi83@gmail.com>, <songqiang1304521@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/3] iio: adc: at91-sama5d2_adc: remove predisable/postenable hooks
Date:   Mon, 25 May 2020 14:38:54 +0300
Message-ID: <20200525113855.178821-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200525113855.178821-1-alexandru.ardelean@analog.com>
References: <20200525113855.178821-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-25_06:2020-05-25,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=860 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 cotscore=-2147483648 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250091
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This should be squashed into the first patch, but it's the more peculiar of
the changes.
I am not sure whether this is correct. The touchscreen channels shouldn't
be enabled by the IIO framework. So, we may need a different way to handle
those if needed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 9abbbdcc7420..f71071096392 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -937,14 +937,6 @@ static int at91_adc_buffer_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
-{
-	if (at91_adc_current_chan_is_touch(indio_dev))
-		return 0;
-
-	return iio_triggered_buffer_postenable(indio_dev);
-}
-
 static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
@@ -995,19 +987,9 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
-{
-	if (at91_adc_current_chan_is_touch(indio_dev))
-		return 0;
-
-	return iio_triggered_buffer_predisable(indio_dev);
-}
-
 static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
 	.preenable = &at91_adc_buffer_preenable,
 	.postdisable = &at91_adc_buffer_postdisable,
-	.postenable = &at91_adc_buffer_postenable,
-	.predisable = &at91_adc_buffer_predisable,
 };
 
 static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
-- 
2.25.1

