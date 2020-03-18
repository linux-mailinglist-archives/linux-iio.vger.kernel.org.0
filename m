Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD751189FF8
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCRPxa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 11:53:30 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:17482 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbgCRPx3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 11:53:29 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IFO94U022581;
        Wed, 18 Mar 2020 10:34:50 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0b-00010702.pphosted.com with ESMTP id 2yu7rktc43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 10:34:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mi4bz6F4HXW9ESZ6+OZy7wc6kedM++ffiYKEVlayslWKvm+RqNuY0ZRKEaAK1U+B3WSDeCJ8foMKr2vXj4YkI5Loci7RLUyg22EomOIUtPUGPf/w+NwsZuDKbeOAhuYnbWOqMZhOOuXUf4tuCOW1g1yKW5WVTQFfCZPHO/Wy25+D1AclrJl+O62zQByQbr5cESFhI2DFfqZpRFny+TG2yehF/GB0ZC6FszhTBwLOggXIcqCqBZt6fc9DTTIBHKEr8NlWXcd8EHTxw8c9nEtPMOOfeA/fMH2ar2BCs9QVimL2zBbyMipzVbS0sICxVft/1Wf2QMgUsHNnaJFxpcKMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOktaHaR1FeDsyEa8//7X4tR7mSqAymI3aS7yWxRvEo=;
 b=ix27+nh32LDjCnBcTZPCjgZ0sl80Dp43wx2lwsSlfB6hLI5YW/+RA7gMF1yEO/pAB2PHEStzm41vvGEsbjEk4UIcr7JCMDUrPM6x1GqOXzc8+RX/NPcvIGwlE9qd9AYQenXDTaidzKjFbY5IfRabj8e9yLfGhZHdqidtqfP7jMR4VCtvlT0KjQVO7v8A1BfgWb5nVap+NRJu3xNDKvJZydlT9WDTUYz+OTPyf1X0xSM97eFTOXRESk1ZKJ9GdfGnLbN9/MoBTXAi0HOiPG0ppWD+34aoonaRU5mbrZBdJ5ziWhP5yxRd8F7NwOCScQ7dGhlg4JEt4ybeSH33GDJXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOktaHaR1FeDsyEa8//7X4tR7mSqAymI3aS7yWxRvEo=;
 b=i916ByATC0ODQBA9EhQOJRVYw+rlCk4nr6lYHpRjRxsyiKqM2SJRwp/QAMCwd0boWQMJePPHIJeT8zK1aQJIKS1bvuklCgIOO6QQCVJti/BfzrHj8fsmj4RL6DXneuNs5psViXtJWkSJFhQQtAyZAtGj+tXeKGiC2V+LzPzeZG0=
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN4PR0401MB3709.namprd04.prod.outlook.com
 (2603:10b6:803:48::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 15:34:49 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::d05b:1953:4111:38e4%5]) with mapi id 15.20.2793.023; Wed, 18 Mar 2020
 15:34:49 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Michael Auchter <michael.auchter@ni.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: dac: ad5686: add of_match_table
Date:   Wed, 18 Mar 2020 10:34:33 -0500
Message-Id: <20200318153434.62833-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318153434.62833-1-michael.auchter@ni.com>
References: <20200318153434.62833-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM3PR14CA0146.namprd14.prod.outlook.com
 (2603:10b6:0:53::30) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xaphan.phire.org (66.90.216.181) by DM3PR14CA0146.namprd14.prod.outlook.com (2603:10b6:0:53::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend Transport; Wed, 18 Mar 2020 15:34:48 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [66.90.216.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bff450c7-af71-4d52-5d0d-08d7cb51e4e3
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3709:|SN4PR0401MB3709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR0401MB3709B6A91CE8C78D21496A3087F70@SN4PR0401MB3709.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(66556008)(66476007)(8676002)(2906002)(81166006)(81156014)(66946007)(2616005)(36756003)(6506007)(44832011)(6512007)(6486002)(5660300002)(110136005)(478600001)(16526019)(316002)(52116002)(956004)(4326008)(8936002)(6666004)(26005)(186003)(1076003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3709;H:SN4PR0401MB3646.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSaic7SFmiCuUpeKlcXGjgUavpyhdjCEeEh83OxLuHvv4ESltRM6MTZ7e6USWc92udW1rFcnXY+qZrCl+9ImMXuJG+wLwODjfnivgiZjjwiowWetAunvb+Romq4fERpUiM/X2uyXnnm/CmkKxxGs+Z1T2z4GfQCjfDoEe9BTzyXqKyJEjPNWV/bIXHPfAjW21EeljfTq8w1Ouuj1fAMQWd7yYbjQa3wvkA0+J79bHKBGEDgqj7S9ZdOXshFQJymc416aiJ26LhMQP8Ze0nC+6HVktctKuhAgDb08RGEYIR5nwIftaqCih6ah6qp/NITfJra/xfrvJauFRV+f5z868ffcfVl1uvyhW51q1pvDeV6/J4xkC9G5VF4LCAzdP8tvSUTZjg88SOPFWlK3KaEj2/Mgr667VD5viGQa5I7g5wP9X0MYt8Df+YNbZW9oYiX9
X-MS-Exchange-AntiSpam-MessageData: g2mag1oytM0hk+xDR5ubFXE64gTi2Lk3sDOyib0QdssXmVaP9pW3qNueQ8HzCyoe+jMwgCoQPeNobZ2IkSxzLZYP0Ahwp2Vi/Vt9N2pYKjl/pwCtMZA+BZ6wsp+1cZc0JJVr3oNqc+garYt8SuRhaA==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff450c7-af71-4d52-5d0d-08d7cb51e4e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 15:34:49.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHeVEuzkXyc2NcyC68dYne0o6lSxZ3X4inxqGaX4d7mVdkjmEhqDJVb+GfDZ8dEVYK47G9b1BGq9xJmMophYCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3709
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_07:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30 phishscore=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003180073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add of_match_table to this driver, so devices can be probed based on
device tree contents.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/iio/dac/ad5696-i2c.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index f100a5fe4219..26818bccffa2 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -88,9 +88,28 @@ static const struct i2c_device_id ad5686_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
 
+static const struct of_device_id ad5686_of_match[] = {
+	{ .compatible = "adi,ad5311r" },
+	{ .compatible = "adi,ad5671r" },
+	{ .compatible = "adi,ad5675r" },
+	{ .compatible = "adi,ad5691r" },
+	{ .compatible = "adi,ad5692r" },
+	{ .compatible = "adi,ad5693" },
+	{ .compatible = "adi,ad5693r" },
+	{ .compatible = "adi,ad5694" },
+	{ .compatible = "adi,ad5694r" },
+	{ .compatible = "adi,ad5695r" },
+	{ .compatible = "adi,ad5696" },
+	{ .compatible = "adi,ad5696r" },
+	{ .compatible = "adi,ad5338r" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad5686_of_match);
+
 static struct i2c_driver ad5686_i2c_driver = {
 	.driver = {
 		.name = "ad5696",
+		.of_match_table = of_match_ptr(ad5686_of_match),
 	},
 	.probe = ad5686_i2c_probe,
 	.remove = ad5686_i2c_remove,
-- 
2.24.1

