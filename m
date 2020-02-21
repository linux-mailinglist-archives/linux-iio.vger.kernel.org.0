Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BDD16831A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 17:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgBUQSd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 11:18:33 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52386 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727213AbgBUQSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 11:18:33 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LGIVlp009407;
        Fri, 21 Feb 2020 11:18:31 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8ucu7ma6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 11:18:31 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01LGIUFj011166
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 21 Feb 2020 11:18:30 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 21 Feb
 2020 11:18:29 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 21 Feb 2020 11:18:29 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01LGIR75026502;
        Fri, 21 Feb 2020 11:18:27 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: [PATCH v2] iio: amplifiers: ad8366: add support for HMC1119 Attenuator
Date:   Fri, 21 Feb 2020 18:18:26 +0200
Message-ID: <20200221161826.21291-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220092821.11050-1-sergiu.cuciurean@analog.com>
References: <20200220092821.11050-1-sergiu.cuciurean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_05:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

This change adds support for the HMC1119 Silicon Digial Attenuator. The
HMC1119 is a broadband, highly accurate, 7-bit digital attenuator,
operating from 0.1 GHz to 6.0 GHz with 31.5 dB attenuation control range
in 0.25 dB steps.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/hmc1119.pdf

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 95972ab60f42..62167b87caea 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -5,6 +5,7 @@
  *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
  *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
  *   ADL5240 Digitally controlled variable gain amplifier (VGA)
+ *   HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
  *
  * Copyright 2012-2019 Analog Devices Inc.
  */
@@ -27,6 +28,7 @@ enum ad8366_type {
 	ID_AD8366,
 	ID_ADA4961,
 	ID_ADL5240,
+	ID_HMC1119,
 };
 
 struct ad8366_info {
@@ -62,6 +64,10 @@ static struct ad8366_info ad8366_infos[] = {
 		.gain_min = -11500,
 		.gain_max = 20000,
 	},
+	[ID_HMC1119] = {
+		.gain_min = -31750,
+		.gain_max = 0,
+	},
 };
 
 static int ad8366_write(struct iio_dev *indio_dev,
@@ -84,6 +90,9 @@ static int ad8366_write(struct iio_dev *indio_dev,
 	case ID_ADL5240:
 		st->data[0] = (ch_a & 0x3F);
 		break;
+	case ID_HMC1119:
+		st->data[0] = ch_a;
+		break;
 	}
 
 	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
@@ -118,6 +127,9 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 		case ID_ADL5240:
 			gain = 20000 - 31500 + code * 500;
 			break;
+		case ID_HMC1119:
+			gain = -1 * code * 250;
+			break;
 		}
 
 		/* Values in dB */
@@ -164,6 +176,9 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 	case ID_ADL5240:
 		code = ((gain - 500 - 20000) / 500) & 0x3F;
 		break;
+	case ID_HMC1119:
+		code = (abs(gain) / 250) & 0x7F;
+		break;
 	}
 
 	mutex_lock(&st->lock);
@@ -246,6 +261,7 @@ static int ad8366_probe(struct spi_device *spi)
 		break;
 	case ID_ADA4961:
 	case ID_ADL5240:
+	case ID_HMC1119:
 		st->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
 			GPIOD_OUT_HIGH);
 		indio_dev->channels = ada4961_channels;
@@ -298,6 +314,7 @@ static const struct spi_device_id ad8366_id[] = {
 	{"ad8366",  ID_AD8366},
 	{"ada4961", ID_ADA4961},
 	{"adl5240", ID_ADL5240},
+	{"hmc1119", ID_HMC1119},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad8366_id);
-- 
2.20.1

