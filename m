Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F63B19F6
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbfIMIqy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:54 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:12732 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387792AbfIMIqy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:54 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gi83020152;
        Fri, 13 Sep 2019 04:46:48 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2053.outbound.protection.outlook.com [104.47.40.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytcwh99c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdEhegvscTd2BBpXm+maRW5UG0LbSHxbBNVmeMHaXrjj297MbS9AWYFNdODc4TbKKXsxJAn2IzeDek24HAD+jgiCxzCtHN9AqlfwpMmtidKnxFEAJUl/dztYksz5siSM8Kj3HGBtgom4OwWARbvD8YHEQenqH87oKxf+J1Ly6X1q3Vxep0Japi0TYdrFbD4QewH0yR3ioPW66WDOuvjrkpGhrHXHcoqLIlBCcIhgr188gv3ol+s90Yjof008+IH6+3kdHwRZxXMxC+wRUe4sw7gQ4kJA1ZbfWwQkyJqRuvtfVRn6hWfnIQ94jNZKhvMp1y1oRgm60QrxL//4BTW8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcho7dNaBtNYW5hFLUgvhiw90bmxoe0Gvww+cecPTYg=;
 b=IS57/vUqLHpV4lIBXTuHoIETjd30FL+kJhbfcdtlLwe8+wTfs+4wPBxwE4zyYBjNhWOWVDnDP4eJE6/KW8Fcec09JiNrKB5QmnisjTXr88k+aplL4kE3yv0rNPzVH25pX+lbNw6dTuk261lT4Ov6FEScoZMdbVDJQdIlNnWRHMe/b2pTOHKun8ktmfO1OjCoTplj1H7Q1Sewj59yuci+zjP0g1ShnbPp2EZ4tx9pjJjb1bp9UKxsgy2dSr9SO11/p6Uw5OckXBitVlBH9jMRLvGclS/JrT/BDn9q+oZunNGMEVwR6/Vq6qcDgxIlGKfsJWB4jwDr9dmEerXWhExWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcho7dNaBtNYW5hFLUgvhiw90bmxoe0Gvww+cecPTYg=;
 b=qtgkwIBCaZLnrOLIeNigt1ExnpadBNslgEqreFsXUjbxBPQ25bhnZwehknl5kFR8jVTf/DTJokkOCz07K6BirQFoaSC/vj1dKFx0h1Ya8DainG8uVRowe1BKIyPSQabRLumVj/V1mZy7qJIIHjMdoq/ptGSrgzILDanamVCfPk0=
Received: from CH2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:59::14)
 by MN2PR03MB4877.namprd03.prod.outlook.com (2603:10b6:208:aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17; Fri, 13 Sep
 2019 08:46:45 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by CH2PR03CA0004.outlook.office365.com
 (2603:10b6:610:59::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.13 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:45 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kdtm030741
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:39 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:44 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 13/15] spi: spidev: use new `delay` field for spi transfers
Date:   Fri, 13 Sep 2019 14:45:48 +0300
Message-ID: <20190913114550.956-14-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(1076003)(5660300002)(11346002)(446003)(107886003)(336012)(50466002)(2616005)(26005)(7696005)(76176011)(305945005)(51416003)(8936002)(36756003)(7636002)(50226002)(14444005)(7416002)(2906002)(186003)(426003)(4326008)(2870700001)(44832011)(8676002)(126002)(110136005)(246002)(106002)(2201001)(70206006)(70586007)(486006)(478600001)(47776003)(316002)(476003)(48376002)(356004)(86362001)(54906003)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4877;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ed6d18b-f31e-450f-ed63-08d73826e85c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:MN2PR03MB4877;
X-MS-TrafficTypeDiagnostic: MN2PR03MB4877:
X-Microsoft-Antispam-PRVS: <MN2PR03MB487709F0A9BE1AF6B053D9CDF9B30@MN2PR03MB4877.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2O8ulFftCn2n2WSMY4L5G3L+F1FkZhoTnzRNtDcALnw4uc3PlQ+YllsumUzig3VDQ2u/vfGTWvEYE25Nu3+gWUSOaakM1Eram6bNg99eZnfIlyOY8DrwKtFiKynEuAQTIGcN29tD4tP9XB/zUjBErX6GzftNtC3DtGib8RqlbwVj3XgMFLAT/rbZ/b0WZwL055Y9qi47clPH3ixWoEFqbQ8vyoGfHDCZRfA5BgrQHQro9d1qvDjaHRWAMoDC6ZweprGUOLBgc7DS7fgcGS3VmETG0K9aMZ7y2E0e0sn6GYSTcHuGHctap+A7W8Z1tqAaoZiiNKMRtxYSi8agtjwHO9Gv8fhJLPWYQbnsCAQUbY+8luTyXeWCpOAb8wxK5O4VB7XVnips8BT3xh7cc6uvlZtDewKOybFvj4H+vkKxVzE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:45.3210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed6d18b-f31e-450f-ed63-08d73826e85c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4877
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=690
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The `delay` field has type `struct spi_delay`.
This allows users to specify nano-second or clock-cycle delays (if needed).

Converting to use `delay` is straightforward: it's just assigning the
value to `delay.value` and hard-coding the `delay.unit` to
`SPI_DELAY_UNIT_USECS`.

This keeps the uapi for spidev un-changed. Changing it can be part of
another changeset and discussion.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 495319c2fa11..6b6afd27f4a1 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -265,7 +265,8 @@ static int spidev_message(struct spidev_data *spidev,
 		k_tmp->tx_nbits = u_tmp->tx_nbits;
 		k_tmp->rx_nbits = u_tmp->rx_nbits;
 		k_tmp->bits_per_word = u_tmp->bits_per_word;
-		k_tmp->delay_usecs = u_tmp->delay_usecs;
+		k_tmp->delay.value = u_tmp->delay_usecs;
+		k_tmp->delay.unit = SPI_DELAY_UNIT_USECS;
 		k_tmp->speed_hz = u_tmp->speed_hz;
 		k_tmp->word_delay.value = u_tmp->word_delay_usecs;
 		k_tmp->word_delay.unit = SPI_DELAY_UNIT_USECS;
-- 
2.20.1

