Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9660186B71
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 13:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgCPMwm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 08:52:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34002 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730982AbgCPMwm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 08:52:42 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02GCpqkA024413;
        Mon, 16 Mar 2020 08:52:21 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yrv64ny47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 08:52:21 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02GCqKUd027799
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 16 Mar 2020 08:52:20 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 16 Mar 2020 08:52:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 16 Mar 2020 08:52:19 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 16 Mar 2020 08:52:19 -0400
Received: from nsa.sphairon.box ([10.44.3.98])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02GCqD8H003537;
        Mon, 16 Mar 2020 08:52:17 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v2 2/6] iio: imu: adis: Add irq mask variable
Date:   Mon, 16 Mar 2020 13:53:08 +0100
Message-ID: <20200316125312.39178-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316125312.39178-1-nuno.sa@analog.com>
References: <20200316125312.39178-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-16_03:2020-03-12,2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160064
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

 drivers/iio/imu/adis_trigger.c | 26 ++++++++++++++++++++++++--
 include/linux/iio/imu/adis.h   |  2 ++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index 9e393819d238..21eddffc50d3 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -34,6 +34,20 @@ static inline void adis_trigger_setup(struct adis *adis)
 	iio_trigger_set_drvdata(adis->trig, adis);
 }
 
+static inline int __adis_validate_irq_mask(struct adis *adis)
+{
+	if (!adis->irq_mask) {
+		adis->irq_mask = IRQF_TRIGGER_RISING;
+		return 0;
+	} else if (adis->irq_mask != IRQF_TRIGGER_RISING &&
+		   adis->irq_mask != IRQF_TRIGGER_FALLING) {
+		dev_err(&adis->spi->dev, "Invalid IRQ mask:%08lx\n",
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
 
+	ret = __adis_validate_irq_mask(adis);
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
 
+	ret = __adis_validate_irq_mask(adis);
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
2.25.1

