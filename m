Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C8936C13B
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhD0Ixb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:53:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45464 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235070AbhD0Ixb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:53:31 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13R8ok86005202;
        Tue, 27 Apr 2021 04:52:37 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3866auh9dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 04:52:37 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 13R8qYPc034005
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Apr 2021 04:52:36 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 27 Apr 2021 01:52:33 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 27 Apr 2021 01:52:33 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 27 Apr 2021 01:52:32 -0700
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 13R8qNJp007577;
        Tue, 27 Apr 2021 04:52:29 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v3 5/6] iio: adis16475: do not directly change spi 'max_speed_hz'
Date:   Tue, 27 Apr 2021 10:54:53 +0200
Message-ID: <20210427085454.30616-6-nuno.sa@analog.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427085454.30616-1-nuno.sa@analog.com>
References: <20210427085454.30616-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Jyb71oQ8Gbx5zR8T3L8yHGE88jXJXda2
X-Proofpoint-GUID: Jyb71oQ8Gbx5zR8T3L8yHGE88jXJXda2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_05:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270065
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With commit 3ba10e37371d ("iio: adis: add burst_max_speed_hz variable"), we
just need to define 'burst_max_speed_hz' and the adis core will take
care of setting up the spi transfers for burst mode. Hence, we fix
a potential race with the spi core where we could be left with an
invalid 'max_speed_hz'.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 51b76444db0b..5654c0c15426 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -645,7 +645,8 @@ static int adis16475_enable_irq(struct adis *adis, bool enable)
 	.timeouts = (_timeouts),					\
 	.burst_reg_cmd = ADIS16475_REG_GLOB_CMD,			\
 	.burst_len = ADIS16475_BURST_MAX_DATA,				\
-	.burst_max_len = ADIS16475_BURST32_MAX_DATA			\
+	.burst_max_len = ADIS16475_BURST32_MAX_DATA,			\
+	.burst_max_speed_hz = ADIS16475_BURST_MAX_SPEED			\
 }
 
 static const struct adis16475_sync adis16475_sync_mode[] = {
@@ -1062,15 +1063,11 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	bool valid;
 	/* offset until the first element after gyro and accel */
 	const u8 offset = st->burst32 ? 13 : 7;
-	const u32 cached_spi_speed_hz = adis->spi->max_speed_hz;
-
-	adis->spi->max_speed_hz = ADIS16475_BURST_MAX_SPEED;
 
 	ret = spi_sync(adis->spi, &adis->msg);
 	if (ret)
 		goto check_burst32;
 
-	adis->spi->max_speed_hz = cached_spi_speed_hz;
 	buffer = adis->buffer;
 
 	crc = be16_to_cpu(buffer[offset + 2]);
-- 
2.31.1

