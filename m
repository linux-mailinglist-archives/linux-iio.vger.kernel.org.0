Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B0F5043D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfFXIJf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 04:09:35 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24676 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbfFXIJf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 04:09:35 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O88PRw025043;
        Mon, 24 Jun 2019 04:09:12 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2055.outbound.protection.outlook.com [104.47.50.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9h86cqs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 04:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw9XZWHXnjFo/2Xi0CM4TgJxFVpNoMjwC82UF/Mevn8=;
 b=4wnzatpBpsZ6nPCONUTq3J2OJEJku90xmds0ILc6uWTR0EcRusmEBqDB8Gk13qJrAGdEFbu9836DHsXIoBAkBQF8mesI/r+x5IHn1yXo3n8TLNioY5+J9uDOjhL8y8kr9szp57hIwIcvuUTS6slPo2QxMBAOFwE9WlLFy7wY+/Y=
Received: from BN6PR03CA0017.namprd03.prod.outlook.com (10.168.230.155) by
 BY2PR03MB554.namprd03.prod.outlook.com (10.141.141.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 08:09:10 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR03CA0017.outlook.office365.com
 (2603:10b6:404:23::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.13 via Frontend
 Transport; Mon, 24 Jun 2019 08:09:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Mon, 24 Jun 2019 08:09:09 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5O898Cp019134
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Jun 2019 01:09:08 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 24 Jun 2019 04:09:07 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V3 1/5] iio: adc: ad7124: Remove input number limitation
Date:   Mon, 24 Jun 2019 11:08:41 +0300
Message-ID: <20190624080845.18537-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(54534003)(37524003)(8936002)(8676002)(2906002)(48376002)(478600001)(6916009)(2616005)(50466002)(305945005)(47776003)(70586007)(70206006)(246002)(336012)(426003)(44832011)(7636002)(72206003)(476003)(126002)(36756003)(486006)(4326008)(5660300002)(186003)(26005)(77096007)(7696005)(356004)(6666004)(86362001)(51416003)(107886003)(1076003)(2351001)(50226002)(316002)(54906003)(106002)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB554;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e0922e-52c0-4a6c-8a3b-08d6f87b3c13
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BY2PR03MB554;
X-MS-TrafficTypeDiagnostic: BY2PR03MB554:
X-Microsoft-Antispam-PRVS: <BY2PR03MB554454228689B6F33EBF2C481E00@BY2PR03MB554.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 007814487B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cZu0Kju0Nr1qgHmM/PxMm1YcKCKi+vo7o1JoziMkKlChQ8LSJifEuQ1AtevqflW85w2UFtmZZv3sRDeD0onZg3k00U1lPSS0pe7aXYelriuu6pGayM1/3a2uq6V0ATH71Y80hhdAG/Gckn9OrdB+BO8fYXNd1hF43+1MPP8iiXd8Q8XiS2gRziRRRac9bGVQmUCalRfjsCcM5a9H7RmthycydUo+nhdWuk1GhTTx99srCFaSvMJIppLLSF4KBoLd0i2E1ZVddILrg3p23kY8PAV0xcIx5TL5F7ZnQmsH0ASU4i/R+dDLgTL1ssE2beStYeRgGCz5Qs79rDBFe8PPcQCnLulTfoyZMD+0viUyRGbfaIc0i82BUjdQJ7JVwnGHYbyVnHeDGOkw5zcP5wckoVPUhnT0YN1PatyMTus/d7Y=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2019 08:09:09.1082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e0922e-52c0-4a6c-8a3b-08d6f87b3c13
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB554
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=819 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240068
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver limits the user to use only 4/8 differential inputs, but this
device has the option to use pseudo-differential channels. This will
increase the number of channels to be equal with the number of inputs so 8
channels for ad7124-4 and 16 for ad7124-8.

This patch removes the check between channel nodes and num_inputs value.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---

Changelog v2:
- nothing changed here

Changelog v3:
- nothing changed here

 drivers/iio/adc/ad7124.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 659ef37d5fe8..810234db9c0d 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -462,13 +462,6 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			goto err;
 
-		if (ain[0] >= st->chip_info->num_inputs ||
-		    ain[1] >= st->chip_info->num_inputs) {
-			dev_err(indio_dev->dev.parent,
-				"Input pin number out of range.\n");
-			ret = -EINVAL;
-			goto err;
-		}
 		st->channel_config[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
 		st->channel_config[channel].bipolar =
-- 
2.17.1

