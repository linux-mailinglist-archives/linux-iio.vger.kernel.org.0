Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08A6B7732
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 12:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfISKNj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 06:13:39 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10702 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727980AbfISKNj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 06:13:39 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8JA7VSK012393
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 06:13:38 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v3vbdht7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 06:13:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUr+JXT4TMdSy2jArE5xMyPZwxtlUlij/NQNjmS4J4IzDTBRPPk1sXYZGv0d0yNdcnZ1J1H/GyUDOBUe/16D7zIHXWO//oBUYKM0VXkBQv1eH3PNnu8ZS4YIk8b0Bp4QeCP8Y33dYFnVJpPkhO+BTWozYWmuyW7EOGjUWEL9ez4380/NH4loGjV2op9hkR8ksNP/OCeZGangCKhF6jpxFnhBa5KUfdZ2RRtJ7c+TAQi1R77oACXRDfIjvXJfyXPYqWe2M+5t3UQnqHsxeQDyLqBxe5Ooh8ZK08bti8GOafTaUeHRw/3sjYK/lys0dOtzzeoLYXi//Li4djjBBP8PWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNJbH4FIIv1mGC6GQRdeP5yqetuVajLFNqs8bD0rkq4=;
 b=XouqfxhhOCzQfiY3uX46rm4JS9vUPxJxUUQqfayiXKZa/l9rSLpRTuu6tjy5ySk46UiVPYgLCuzel81/gdW2IsJ2GMMJt8IKemEjla86pm24Y8ubdyk43SG20QmanV+uXs6RW2+KO52heRSPzrkJwf+piztBYSHcSD+49XJtpssrTT8sUkqy5rBHXIMlt7f9sRn0sWcMQIXdixb29QG2c9xRxB48B8A3cIzKKH3qx6rtMlM/kb929mu8rMkdHz3MkJyc8tE+lA4Rk7GytApNtj3UwwtLqLcgRMg14C5iPc+CVsKF5AA8c9UMpJNOp6fB6phkRNn5Jz2cAHPJmw+21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNJbH4FIIv1mGC6GQRdeP5yqetuVajLFNqs8bD0rkq4=;
 b=r5rr+iDVFNaZ0GDvxdtQcVht7+OqtMbiUBtgfrBZMhzsK3H4Fejl179SvwcyccEseqx+MKq0eBzjE7+w58TLRN9cAzbDXjecqLF7rguALlAdX2uj+/VS2zdG0HTEnZPDUL0L+KU4EwFM1UXF2OvdJBZprPvDNUiK2fq7EWxpeJU=
Received: from BYAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:a02:a8::46)
 by BN6PR03MB3026.namprd03.prod.outlook.com (2603:10b6:404:116::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17; Thu, 19 Sep
 2019 10:13:34 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BYAPR03CA0033.outlook.office365.com
 (2603:10b6:a02:a8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.21 via Frontend
 Transport; Thu, 19 Sep 2019 10:13:34 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.20
 via Frontend Transport; Thu, 19 Sep 2019 10:13:33 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8JADWEj025484
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 03:13:32 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 19 Sep 2019 06:13:32 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: dac: ad7303: replace mlock with own lock
Date:   Thu, 19 Sep 2019 16:13:28 +0300
Message-ID: <20190919131328.13633-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(44832011)(70206006)(70586007)(86362001)(486006)(476003)(126002)(6916009)(36756003)(48376002)(107886003)(50226002)(8676002)(7636002)(246002)(50466002)(305945005)(8936002)(14444005)(426003)(26005)(47776003)(1076003)(2870700001)(186003)(51416003)(2616005)(336012)(316002)(7696005)(106002)(2906002)(356004)(6666004)(478600001)(4326008)(2351001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3026;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c91ea41-e985-499c-d4f3-08d73cea070e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN6PR03MB3026;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3026:
X-Microsoft-Antispam-PRVS: <BN6PR03MB30264E9630615BCCAC7BEA49F9890@BN6PR03MB3026.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: VgNG/enjTQWkDOgl+fMsAkHsmKKsYW8FrpjKYj/hyzYA4Vf8ujX3FcU8YL2nMsTLYLcOhVXID3ObdCNzkOiKTgU1UnFXmICLHGUTgnxiUFdZC9bm+amlG8GZ12juAoem/8RcgZs3dJv7LmNEAqYyZ99cjyxixaShwif81d06nGsA59xQUS9fMTQ2GYnaiXG4VYx2GL8Xi4mS+Q+3If4ZOIh+BmvaPmdt0+bFKl9PjVcYNJ7sVgN8dkna0Kz4UmWSO8Tm0J3MJE4f4SUC3YINalDIkafmXxf26onFIdTQH/DjCq/E1YFF/RIxD1uQ5Q8Ec1njk86hgBg2K4yR8VlVNM/mT4MfS+ywuW8AFk9eweu7SuP+HAERO8CkLn5mC6n5ghASXgwXPvk7cPS6AQTAT3XFe6z0JZ+baX5UvmkoFuo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 10:13:33.3479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c91ea41-e985-499c-d4f3-08d73cea070e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3026
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_03:2019-09-18,2019-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=967 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909190097
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change replaces indio_dev's mlock with the driver's own lock. The lock
is mostly needed to protect state when changing the `config` & `dac_cache`
fields. As such, the lock has been extended to covert the read of these
fields.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/ad7303.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 8de9f40226e6..f45352e80db7 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -41,6 +41,7 @@ struct ad7303_state {
 	struct regulator *vdd_reg;
 	struct regulator *vref_reg;
 
+	struct mutex lock;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -62,9 +63,13 @@ static ssize_t ad7303_read_dac_powerdown(struct iio_dev *indio_dev,
 	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad7303_state *st = iio_priv(indio_dev);
+	int val;
 
-	return sprintf(buf, "%d\n", (bool)(st->config &
-		AD7303_CFG_POWER_DOWN(chan->channel)));
+	mutex_lock(&st->lock);
+	val = (bool)(st->config & AD7303_CFG_POWER_DOWN(chan->channel));
+	mutex_unlock(&st->lock);
+
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
@@ -79,7 +84,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	if (pwr_down)
 		st->config |= AD7303_CFG_POWER_DOWN(chan->channel);
@@ -90,7 +95,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
 	 * mode, so just write one of the DAC channels again */
 	ad7303_write(st, chan->channel, st->dac_cache[chan->channel]);
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return len;
 }
 
@@ -116,7 +121,9 @@ static int ad7303_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
 		*val = st->dac_cache[chan->channel];
+		mutex_unlock(&st->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		vref_uv = ad7303_get_vref(st, chan);
@@ -144,11 +151,11 @@ static int ad7303_write_raw(struct iio_dev *indio_dev,
 		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		ret = ad7303_write(st, chan->address, val);
 		if (ret == 0)
 			st->dac_cache[chan->channel] = val;
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 		break;
 	default:
 		ret = -EINVAL;
@@ -211,6 +218,8 @@ static int ad7303_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
+	mutex_init(&st->lock);
+
 	st->vdd_reg = devm_regulator_get(&spi->dev, "Vdd");
 	if (IS_ERR(st->vdd_reg))
 		return PTR_ERR(st->vdd_reg);
-- 
2.20.1

