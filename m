Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038EA1310E3
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2020 11:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAFK6E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jan 2020 05:58:04 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:15830 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgAFK6D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jan 2020 05:58:03 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006At2VK006976;
        Mon, 6 Jan 2020 05:58:00 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xar7bbwv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 05:58:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkkrMDq4WyKlFTUBxofvkilNwpAca6dUuDMOmSwtE2nBe+VeT2WryKPm/WwGr4fwI2Pxv/Y/pwNvRhZS/RVSFLPkgWRgr3nxAqATyRQoCX+KOKaFr/O3EvuukrAr7FA7ULKamRZtXoI/ucXKiHN9tt10KU9suwSz6No0x5qy/YrUlOtbCWOpLpuLINtW9sMStPGDksWE/bMGU3I+P0aigxXgdBS5qGbLONYVf0aaDWDKLWRnqFECi578HNhChKtwBLNOXDCP3nFymphHl4q0RNX/vXCA+gmgb8qAd/xNFVwRCDv2TDUsnH4hcXOKC1V2GiEOx0iVHek2/qbAO+IAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkaRlCpzWCndGsQHYG79pjmcyaxspMVR+hJl/ufqs6I=;
 b=ogUU6ZQ7+Bda/d5PHiqcnQh8K/fXioAzKIkZgtDoHKI2MXwjNXJA2P//FWyhSeIqQzQbLIuS75Uzb/uIB4i7Mtrx0qQoiPK92SkA/zrA5MvVcaJEXH21dMPT3Ug3uJjPAEdA2AXsz5jXAoQHLqNP6L2twZoqGDC4819QFSJQjb38JXxSBA0xcnivlkyR4V6CRhTlBXJuXvw7uzykRf+LZpMXzHskqXA/iQ7k61oaD0NodssHooovzD81UP+JWZyNhLsaxrueUk7dC/kuXhal77UNPLV2Z3d6ztfh1G8Dd7DxTyuMbiP9TC0ciyioNwT1GBk/y8r4Ay4DmQ+eGdsPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkaRlCpzWCndGsQHYG79pjmcyaxspMVR+hJl/ufqs6I=;
 b=WhWMAhzwSu8rA19noOS+aA0yfvjutvglc0OJz+vfntL46AJX6O60TNdluH4DgGh2aIRpmLnKwogBhtSa4V7l85IPk84ts8nCT1EeHPK3LRRvGTSMYYZHN70olVV7vDwyiVP+mIWNmFoadi51OMTExv5IA6mOzcKBReTv+yk4qV8=
Received: from BN3PR03CA0079.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::39) by BYAPR03MB3704.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 10:57:57 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BN3PR03CA0079.outlook.office365.com
 (2a01:111:e400:7a4d::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend
 Transport; Mon, 6 Jan 2020 10:57:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Mon, 6 Jan 2020 10:57:57 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 006AvuNs030663
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 6 Jan 2020 02:57:56 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 6 Jan 2020
 05:57:55 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 6 Jan 2020 02:57:55 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 006AvqeV019287;
        Mon, 6 Jan 2020 05:57:52 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH] iio: ad_sigma_delta: Add custom irq flags
Date:   Mon, 6 Jan 2020 12:57:47 +0200
Message-ID: <20200106105747.8244-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(8676002)(54906003)(110136005)(7636002)(2616005)(478600001)(336012)(8936002)(107886003)(316002)(36756003)(246002)(2906002)(426003)(4326008)(70586007)(6666004)(356004)(70206006)(5660300002)(44832011)(1076003)(186003)(86362001)(7696005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3704;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7bdf5c1-ed9e-47ed-445e-08d7929749dd
X-MS-TrafficTypeDiagnostic: BYAPR03MB3704:
X-Microsoft-Antispam-PRVS: <BYAPR03MB370400242FC83C8FB040397F903C0@BYAPR03MB3704.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0274272F87
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5xSDIdA/VcYXASpJeL6ZvsNmdpe6e0H7B1AXcxpL6hXceYxlvq3py0gtC5AGzRdwPnnbWXvKthgi4c7vf8XVh/FgiyT1MT+3ggZOkWQkrQubE49EllBV9yA/PI6B3mnI9nsn9no9iESi/FdnPIwQ/InL6fLILn0kVkPLN5pZYp2rzC+jCia2j05eh/tD3KxRoe1TaDbYLQolVtAO3pz9Yeendjw60ISPd96kXB3kikJuYzUegbK1+aXZsrdc46kZBBMtO6ax6Ep9nb++/bxR4lXnMFOvFZhy8fO7ce/cdwxnz5zP+hbTudHUys9++wLTE2xUP1VwbrHAYz4upTd2MjstRDAPzVbp1yjc44GYoNHaHOfuji+4lbftJZqpUi5sCmlZkrV+yTNtiLmOrL7hz7w2P4tswWgQ4zE9n+Iqo5UqMw9dXr1gxPIps53JKQU
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 10:57:57.2738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bdf5c1-ed9e-47ed-445e-08d7929749dd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3704
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_04:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060100
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The data-sheet of AD7124, from the Sigma-Delta ADC family,
recommends that the falling edge of the DOUT line should be used for
an interrupt.

The ad_sigma_delta implementation hardcodes the irq trigger type
to low, assuming that all Sigma-Delta ADCs have the same interrupt-type.
This causes unwanted behaviour. If DOUT line is already low, the
interrupt will fire once, when enabled and the irq handler will send a
read request to the device. At this time the device has not yet finished
the previous conversion and will give a bad reading.

This patch allows drivers using the ad_sigma_delta layer to set the
irq trigger type to the one specified in the corresponding data-sheet.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 9 ++++++++-
 include/linux/iio/adc/ad_sigma_delta.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d10bd0c97233..0007df8d50fb 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -454,7 +454,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 
 	ret = request_irq(sigma_delta->spi->irq,
 			  ad_sd_data_rdy_trig_poll,
-			  IRQF_TRIGGER_LOW,
+			  sigma_delta->irq_flags,
 			  indio_dev->name,
 			  sigma_delta);
 	if (ret)
@@ -540,8 +540,15 @@ EXPORT_SYMBOL_GPL(ad_sd_cleanup_buffer_and_trigger);
 int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct ad_sigma_delta_info *info)
 {
+	unsigned long set_trigger_flags;
+
 	sigma_delta->spi = spi;
 	sigma_delta->info = info;
+
+	set_trigger_flags = sigma_delta->irq_flags & IRQF_TRIGGER_MASK;
+	if (set_trigger_flags == IRQF_TRIGGER_NONE)
+		sigma_delta->irq_flags |= IRQF_TRIGGER_LOW;
+
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
 	return 0;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 5ba430cc9a87..94a91731c8e8 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -53,6 +53,7 @@ struct ad_sigma_delta_info {
  * struct ad_sigma_delta - Sigma Delta device struct
  * @spi: The spi device associated with the Sigma Delta device.
  * @trig: The IIO trigger associated with the Sigma Delta device.
+ * @irq_flags: flags for the interrupt used by the triggered buffer
  *
  * Most of the fields are private to the sigma delta library code and should not
  * be accessed by individual drivers.
@@ -60,6 +61,7 @@ struct ad_sigma_delta_info {
 struct ad_sigma_delta {
 	struct spi_device	*spi;
 	struct iio_trigger	*trig;
+	unsigned long		irq_flags;
 
 /* private: */
 	struct completion	completion;
-- 
2.20.1

