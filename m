Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE63BF074
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfIZKxd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:53:33 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:21918 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbfIZKww (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:52:52 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqM3x030423;
        Thu, 26 Sep 2019 06:52:48 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku7cd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3m0ZnZER1ZaiNM8rnCmi/MqNrnMQZp1MMEyi3AiUCKbzB8QPXIGnnVam/GNhCP2pFSlQBqGtrS6hraHqeQz2NRtETsmn1uTqX1x1nzn/CQx+IhnkY5jVsiLE87J82lNRPxcSYU114nRFlSN+ewHdBIK3z0vFGlnc5RC5g49jrNy7FsiZS8/lNDCsan9FzYEd0vK+rEE0XlIhdQzYZnBEOD7k2U+tgnNDK2kuv/25gB/HdmGxgyfhrpTTNzs20ArGqR5v4q5CRuSJIWTV9WyLNHLcNTwxw01+iMSzxMeoDLc4kbORM06rL5Fr+DbxDWHRBUhlfUazeKCEz1I58jDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcho7dNaBtNYW5hFLUgvhiw90bmxoe0Gvww+cecPTYg=;
 b=d8niedwgn16EW3N4Pmp2WNWT0PiIYVne7bgQXcCDtH8sf2HZ/UsH7upWF/ikgl2JGfvNrMr0RlwgNQefsQV3T1JADjQj90pM73gJ7TJOuSYAak/1P0p6GLDE2/tF3m8JGyybtEM23U7OnjG13IcuzVFJKumCedg6RWk6F1g79KStW2OFrREHuD83Lm1fLJ3qP/whmkJSNTA1hOEFDe2yHL16a5EBIPU3d7hvw7pWZe7zrAM9TiM5sO69o11k/I1KonNSKojAO4f42j5wREqwHpaNX3VcmzoKWRrONMIyxZwdUeEBrUVr0Gi6VWODcF/VztLWlg38wpMGjfyThO6ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcho7dNaBtNYW5hFLUgvhiw90bmxoe0Gvww+cecPTYg=;
 b=sTb4qL/SquBZ8FylMgWah2HVCIAfx5mvffizLU5NK2DuDHbr/oHo5bZcmb520ZB7P1yIrFp3muL1uPALVJD9MSLVYEOxzg7Dwiq5civVN53uvmMxBmzTBicugkGPsqRkPwrF1ePWmdQDUvMB3Q/aR2CVB4xdaykMUhOfbxSHaco=
Received: from BN6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:405:6f::27)
 by CY1PR0301MB0604.namprd03.prod.outlook.com (2a01:111:e400:4c29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 10:52:45 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN6PR03CA0089.outlook.office365.com
 (2603:10b6:405:6f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.22 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:44 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:44 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqiHD014894
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:44 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:43 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 13/19] spi: spidev: use new `delay` field for spi transfers
Date:   Thu, 26 Sep 2019 13:51:41 +0300
Message-ID: <20190926105147.7839-14-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(186003)(26005)(486006)(36756003)(11346002)(446003)(50226002)(2616005)(5660300002)(476003)(44832011)(126002)(47776003)(86362001)(426003)(336012)(2906002)(7696005)(51416003)(76176011)(246002)(356004)(478600001)(50466002)(70586007)(70206006)(8676002)(48376002)(1076003)(305945005)(316002)(7416002)(106002)(2870700001)(7636002)(2201001)(107886003)(54906003)(4326008)(110136005)(8936002)(14444005)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB0604;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cddd51b3-c296-451b-90c7-08d7426fa97c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:CY1PR0301MB0604;
X-MS-TrafficTypeDiagnostic: CY1PR0301MB0604:
X-Microsoft-Antispam-PRVS: <CY1PR0301MB0604CEE423A147DDEB0248DBF9860@CY1PR0301MB0604.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YufJBGxFPPMJPMmc09AVYgY/HUOtN0M0vT1+HXb2AFjl8jDH5T2lCKDBeDnoEdnGiNeVJ9PFafEcaKfqzNMPlGnCjhN3BL5yl/NmO0Ek75wPC3fgkEadIFNBW0n20oOfTbmeFK2MDl32LD7t0vFqQpuAX76TLm1qBnJCKDUKKqqRSY0tdQwWNtFzN5KWwl3lfLaMwMoC6VH+b0S1mF9r/9ZLWSiDW0KMl5/F1dBm780guPfGgkrTylt9OfENv9Rpr60qeU0SOZALuqu4K66C8ujYXbVrs/uHFNnSmx5e/hc56uxsoMhXDv2n20kPii1c/dNTKjNgTwyl05BfxFyZtIlmEgpMt7rTspKrmL/3qbz5DKHVrNcLuniNVT7EUtaPurEgHztyHf87b/WmolqmgrWlDmzUSlEWpLTGkpCE7H0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:44.7149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd51b3-c296-451b-90c7-08d7426fa97c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB0604
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=720 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260103
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

