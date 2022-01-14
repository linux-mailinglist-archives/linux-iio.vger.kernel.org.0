Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6E248EAA1
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jan 2022 14:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiANN0j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jan 2022 08:26:39 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47118 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235222AbiANN0j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jan 2022 08:26:39 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20E7RMcY009035;
        Fri, 14 Jan 2022 08:26:26 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3djsuqtrc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 08:26:25 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 20EDQO0i048695
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jan 2022 08:26:24 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Jan 2022 08:26:24 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Jan 2022 08:26:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Jan 2022 08:26:23 -0500
Received: from NSA-L01.ad.analog.com ([10.32.224.71])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20EDQCBs015112;
        Fri, 14 Jan 2022 08:26:15 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Julia Pineda <julia.pineda@analog.com>
Subject: [PATCH] iio: adis16480: fix buffering for devices with no burst mode
Date:   Fri, 14 Jan 2022 14:26:08 +0100
Message-ID: <20220114132608.241-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: DKbJ83KjHp1L9s1_HgixvdADDocf5VeH
X-Proofpoint-ORIG-GUID: DKbJ83KjHp1L9s1_HgixvdADDocf5VeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_04,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140089
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The trigger handler defined in the driver assumes that burst mode is
being used. Hence, for devices that do not support it, we have to use
the adis library default trigger implementation.

Tested-by: Julia Pineda <julia.pineda@analog.com>
Fixes: 941f130881fa9 ("iio: adis16480: support burst read function")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16480.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index ed129321a14d..f9b4540db1f4 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1403,6 +1403,7 @@ static int adis16480_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	const struct adis_data *adis16480_data;
+	irq_handler_t trigger_handler = NULL;
 	struct iio_dev *indio_dev;
 	struct adis16480 *st;
 	int ret;
@@ -1474,8 +1475,12 @@ static int adis16480_probe(struct spi_device *spi)
 		st->clk_freq = st->chip_info->int_clk;
 	}
 
+	/* Only use our trigger handler if burst mode is supported */
+	if (adis16480_data->burst_len)
+		trigger_handler = adis16480_trigger_handler;
+
 	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
-						 adis16480_trigger_handler);
+						 trigger_handler);
 	if (ret)
 		return ret;
 
-- 
2.33.1

