Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3142165A26
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2020 10:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBTJ2d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Feb 2020 04:28:33 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23722 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbgBTJ2d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2020 04:28:33 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01K9DxMu003931;
        Thu, 20 Feb 2020 04:28:31 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8uduknk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 04:28:31 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01K9SU1L037385
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 20 Feb 2020 04:28:30 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 20 Feb
 2020 04:28:26 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 20 Feb 2020 04:28:26 -0500
Received: from analog.ad.analog.com ([10.48.65.180])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01K9SN4x013030;
        Thu, 20 Feb 2020 04:28:23 -0500
From:   Sergiu <sergiu.cuciurean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Sergiu <sergiu.cuciurean@analog.com>
Subject: [PATCH] iio: amplifiers: ad8366: add support for HMC1119 Attenuator
Date:   Thu, 20 Feb 2020 11:28:21 +0200
Message-ID: <20200220092821.11050-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_02:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200069
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds support for the HMC1119 Silicon Digial Attenuator. The
HMC1119 is a broadband, highly accurate, 7-bit digital attenuator,
operating from 0.1 GHz to 6.0 GHz with 31.5 dB attenuation control range
in 0.25 dB steps.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/hmc1119.pdf

Signed-off-by: Sergiu <sergiu.cuciurean@analog.com>
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
2.17.1

