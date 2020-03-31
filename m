Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432FD1995B5
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 13:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgCaLsp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 07:48:45 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55022 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730562AbgCaLsp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 07:48:45 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VBdxBE005080;
        Tue, 31 Mar 2020 07:48:26 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6hfnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 07:48:26 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 02VBmOfJ027929
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 31 Mar 2020 07:48:25 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Mar 2020 04:48:23 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Mar 2020 04:48:23 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 31 Mar 2020 04:48:23 -0700
Received: from NSA-L01.ad.analog.com (nsa-l01.ad.analog.com [10.32.224.203])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02VBmGgA024975;
        Tue, 31 Mar 2020 07:48:21 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v3 2/6] iio: imu: adis: Add irq mask variable
Date:   Tue, 31 Mar 2020 13:48:07 +0200
Message-ID: <20200331114811.7978-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331114811.7978-1-nuno.sa@analog.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_04:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310107
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are some ADIS devices that can configure the data ready pin
polarity. Hence, we cannot hardcode our IRQ mask as IRQF_TRIGGER_RISING
since we might want to have it as IRQF_TRIGGER_FALLING.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v2:
 * Add kernel doc-string for `irq-mask`.

Changes in v3:
 * Removed unnecessary inline;
 * Renamed `__adis_validate_irq_mask` to `adis_validate_irq_mask` to keep lib consistency;
 * Cosmetics in logs.

 drivers/iio/imu/adis_trigger.c | 26 ++++++++++++++++++++++++--
 include/linux/iio/imu/adis.h   |  2 ++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index a36810e0b1ab..df88b74f4c2b 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -34,6 +34,20 @@ static void adis_trigger_setup(struct adis *adis)
 	iio_trigger_set_drvdata(adis->trig, adis);
 }
 
+static int adis_validate_irq_mask(struct adis *adis)
+{
+	if (!adis->irq_mask) {
+		adis->irq_mask = IRQF_TRIGGER_RISING;
+		return 0;
+	} else if (adis->irq_mask != IRQF_TRIGGER_RISING &&
+		   adis->irq_mask != IRQF_TRIGGER_FALLING) {
+		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
+			adis->irq_mask);
+		return -EINVAL;
+	}
+
+	return 0;
+}
 /**
  * adis_probe_trigger() - Sets up trigger for a adis device
  * @adis: The adis device
@@ -54,9 +68,13 @@ int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 
 	adis_trigger_setup(adis);
 
+	ret = adis_validate_irq_mask(adis);
+	if (ret)
+		return ret;
+
 	ret = request_irq(adis->spi->irq,
 			  &iio_trigger_generic_data_rdy_poll,
-			  IRQF_TRIGGER_RISING,
+			  adis->irq_mask,
 			  indio_dev->name,
 			  adis->trig);
 	if (ret)
@@ -96,9 +114,13 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 
 	adis_trigger_setup(adis);
 
+	ret = adis_validate_irq_mask(adis);
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
 			       &iio_trigger_generic_data_rdy_poll,
-			       IRQF_TRIGGER_RISING,
+			       adis->irq_mask,
 			       indio_dev->name,
 			       adis->trig);
 	if (ret)
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index ac94c483bf2b..ed41c6b96d14 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -87,6 +87,7 @@ struct adis_data {
  * @msg: SPI message object
  * @xfer: SPI transfer objects to be used for a @msg
  * @current_page: Some ADIS devices have registers, this selects current page
+ * @irq_mask: IRQ handling flags as passed to request_irq()
  * @buffer: Data buffer for information read from the device
  * @tx: DMA safe TX buffer for SPI transfers
  * @rx: DMA safe RX buffer for SPI transfers
@@ -113,6 +114,7 @@ struct adis {
 	struct spi_message	msg;
 	struct spi_transfer	*xfer;
 	unsigned int		current_page;
+	unsigned long		irq_mask;
 	void			*buffer;
 
 	uint8_t			tx[10] ____cacheline_aligned;
-- 
2.17.1

