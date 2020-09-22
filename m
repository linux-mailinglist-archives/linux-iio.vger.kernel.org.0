Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2199274861
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 20:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIVSlk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 14:41:40 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:5048 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgIVSlj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 14:41:39 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08MITM3Q020944;
        Tue, 22 Sep 2020 13:41:20 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-00010702.pphosted.com with ESMTP id 33nft7q5s1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 13:41:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atwxWq8876qCgULlXLTwqXkdkqmzgYp5aVUBrcGvcV2tcLvf6AyyUAtFRGdRPh24w3P6/RfM1f+D3XAieuB+zOzLnYckg2h3asK0ORoaGsP0aLfarNswydK2r2BukYn9julXpTgoC6g/1JWEui3X6AmCXY7Q2Wxwtq+QiqTDXzSQh8YSmuWIcrbZ8yVA//6qXFW4eLqSWdqPKRbRsNxn/R4JE4xK0rL9d1uVfVdQyeH9wbqP/k6uNVNOKr2m7sxW9+ha3XS2JMSxEiemV3l2m3fopURMLCBukSbx/uJOUGCYjdgvr2aDuNwsr7UcBSCIMGyxo2rQmVbQSTC3Cei1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T0v4W36TETaAEWp+nfk2OAgBQmflNxhKNlkAEecUnM=;
 b=cN9FyAnDZNHW3xgNE0ZflWlOZFUq9ReUoAsxuhJuVA+CzksV9tFvS2xAKlLnrdPPwYqEdT/fstODj6g9h7fQgf1w1/aL1aHpAFnhThNSiCFd4mI1b3t6tQ3tQqzXxhd+8ieF8AvM+TOeh73tPVACT79JcfzMmieX2GEwYic3QP9u1gQFEewJZ6DmfEj9wZWTQluk05bxuhDWx5VuDc6nlsuctC3MMPv0xD2yzrKheDHTQRj0XGYQs6BllCSOXQnOd7/aZ6l+lNcOdgcGr3ab/3nPJYNGNElNHv9C9MzTObaoR+uWa1wi+ntqSafw8Y1pzi8iDOTqaDQCWFRsyisVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T0v4W36TETaAEWp+nfk2OAgBQmflNxhKNlkAEecUnM=;
 b=QGgIIrAj70aNtKlDGj7cX1uhLkR87cjbkVa/FXb4+3fDd26loma9nMxzLadkXzKjLn5P78VBUvaxbIEUdKzD97n8lfvi5u9yXc+qFSaX841B7Nm2EAzGRBmRspZcbabfFKovZy+ZXUv6jKX1tuvZLRw3w2SmqLFehcDe8YUMPb8=
Authentication-Results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB4909.namprd04.prod.outlook.com
 (2603:10b6:805:95::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 18:41:19 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3391.023; Tue, 22 Sep 2020
 18:41:19 +0000
From:   Michael Auchter <michael.auchter@ni.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Michael Auchter <michael.auchter@ni.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: dac: ad5686: add of_match_table
Date:   Tue, 22 Sep 2020 13:40:11 -0500
Message-Id: <20200922184012.557622-2-michael.auchter@ni.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922184012.557622-1-michael.auchter@ni.com>
References: <20200922184012.557622-1-michael.auchter@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:805:ca::16) To SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2605:a601:ab6f:2000:2739:a39e:9b12:ab20) by SN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:805:ca::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 22 Sep 2020 18:41:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31870255-3c9b-4e6e-7225-08d85f271862
X-MS-TrafficTypeDiagnostic: SN6PR04MB4909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR04MB49093EE9EB97CD0F51EF2BC6873B0@SN6PR04MB4909.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2gBpPoMO2qWbTFtTGpm+LxXths/XyaQMxJuVt1ELfxaBaMOTWvCsQhTHJd/0rnDs4Gj+4WEAedvOpjM4KT0rSkdeseRXp4yIXvJ36x+Ymy/Y8FOW7Wtg7cY3IltJ/V00C3TfPLx7UG/886LYOp3qmq7LuN85H9AurjcFohO+o99RTcrn3BsjVpEU+mhJ7Do7c7Xnj6NIJvaIJHa8U4m1oVFj5uSBS2bEe+RAbz5Cvswd2zMjQFtKJeGUrQ5+GCjyMk0a4D3pFrSGfSgOeaixpWaD+7nsMXVP7UTsYycDcin7T2Tn/kiIKnBTZkE6hEnu/ATU0PK3A8Ewthngf/rrU8y4VlQGgMnUGyu9iLUb1cUNRPa1EdvagFS5Eqll1hX0qI59VTRamXNF+yCnGjGMFdpbzKBM8yikFimt/qKm4sA0vt6nRuDy7nV198vHqF5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(346002)(376002)(366004)(52116002)(66946007)(6512007)(44832011)(66556008)(478600001)(186003)(6486002)(5660300002)(6666004)(2616005)(8676002)(2906002)(16526019)(4326008)(36756003)(6506007)(66476007)(8936002)(86362001)(69590400008)(1076003)(110136005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vQzsZQ1W2z2vwva0/WABJMfuKqkoVCcUmhbra0pq4cRaZd9WwDT6WfKO7rQi2CQ0ozbcncrNzkEBThLY0fZw+4aULapE6wx137pU7r2dXTJMHNrJRXnvy2L4XHWfdWkTTcnC2c9k9/BFCUyrymGYXC46S8iUJ8RerRWdC5zJCJ1st/nj+21G1WtriXjsWCmLT8UY4u/q4dpO6bMZ+4apvbkMeodRQL7QWEzbx1EWdXCcVCLaI9t+1RS0ZLpC6J+HW59mhhrj0RBCkBcmmtcQrCG15/XeyLuUjSe0x5T/s0tGg/+mOvlhKj4x6hnvQ/ZgDRddWW+KMAozZLp+nKzbgBBQuaLcGhNm/gNURVdVlItn0vM77GZjFAV1S+tFb4mvJ0gzFemc3a2LwzZFoJSHICiBpMQvX8HWWeEItchI2AeI88h8DVSGZTKp09Jwau0TiZyGAr+kYyz1j7kZpjHb+0qWH/KdXFhqwqut+U8Sb/p2Q9jaMfajAY1J4KAOoAPh3VYq3H3817eNQZ69sCVys91hdUs7R2CJDLeThu+2fxLxpTYsGD2RzNorjfa0vIaE1L9Xmt1Ov3mssYS12LYpRj5/WTbbKhVa098noYKDWc1aWE07x+lULBeV1+2nR+euG01wo14D+nV44OWWpjIvnm+BiOtsYuhfdzHFJxPAK2e5vJ6O2iUkjybFvm9M//+rNfL/HDZ6uMQUXdpRtwVHdQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31870255-3c9b-4e6e-7225-08d85f271862
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 18:41:19.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67UaEu1veZOGigth6Z26yuODbi9ruG09cx1Z43gEAumXUWbKLO9aQJYyWLYrdhlTkHZRSwudoj+xeIPcSZmnSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4909
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_17:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220144
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add of_match_table to this driver, so devices can be probed based on
device tree contents.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
Changes since v1:
- Drop of_match_ptr() use

 drivers/iio/dac/ad5696-i2c.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 89e7b063b7bb..a39eda7c02d2 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -88,9 +88,28 @@ static const struct i2c_device_id ad5686_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
 
+static const struct of_device_id ad5686_of_match[] = {
+	{ .compatible = "adi,ad5311r" },
+	{ .compatible = "adi,ad5338r" },
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
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad5686_of_match);
+
 static struct i2c_driver ad5686_i2c_driver = {
 	.driver = {
 		.name = "ad5696",
+		.of_match_table = ad5686_of_match,
 	},
 	.probe = ad5686_i2c_probe,
 	.remove = ad5686_i2c_remove,
-- 
2.25.1

