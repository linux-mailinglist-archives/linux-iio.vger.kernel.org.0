Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE32DA64F5
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfICJTR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 05:19:17 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63972 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbfICJTR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Sep 2019 05:19:17 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8398Cdn028538;
        Tue, 3 Sep 2019 05:18:45 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2054.outbound.protection.outlook.com [104.47.40.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uqnt8cd82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 05:18:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xvl1etb3ovAD2zWRAbsNxSPntOf9Avmmfj1POGoX7j4kgHU2VQKK73NUgYryw1CFcl2k21ZZWgHffgNEPk7YiHSkHUH7KZFrE9w+Gju+NfrBEcFxG8V6e0ruuvQcK2agQHQ/6d8wbelBynqDFMx+vE8b+hRicgL0KjtFxH02CdkybIYMSH3lD+W5IuHq0P6PhqfyXACIJbeOTNHSxeMRj4rFASohwP6lvdKdSRXKGnAPXa9PBdBfqWjSDzlU4xv1DeYqgHt5TOc5a5Rh3wki8YggF9W1JHmpvBr8JrndT5xkArpGsQd88aENx5kzcM0oA2mGXaKmiAdJYPu+aLWNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF+YBXfbVxO15DQNsbmgUvsYSYE1/GXMwO8lfTGwhzI=;
 b=ebVvI5URziS7wWa8cHcs3IP4b+1wIalPOnJWmh7Qe9T1fWcVhT5irHaivezI78+RZ8ghmFCq2HbCH3+zHZ+iHVCmtHBWDCF+B+dCEJ07Ta4drhLQLHW6W1J+Ta0w0oE0cf5UUaHj6/rbqBf+A2Uz1C451SEuoHmlXLDGnIil3IoWW8y3wcdcc+KyKF5JCoKaRkpZ5nQ2tT2u4+6JJkbdzbSR+E1FMDEOAhV27Rsx075EQyg38slTqyloqx+sisKddhCg9H6/lIgswa3djSRwANxfcJTlLXtW0P99F7fnCdFg9MSNJEFN0IgU4z2cH5N5+GLGSFIj5DNt23/ipD+kJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=gmx.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF+YBXfbVxO15DQNsbmgUvsYSYE1/GXMwO8lfTGwhzI=;
 b=JEBcIFwdk1+fUMqF5hkEIJfj0xk8jjy4K5YW4cB2WqdKDYMekuvBWZnZWgA7zy8E+I9HkssGZmKSqmMG13KuyzfCJId8T+keu8zBxz/LrKIqfavgJdlcr/qR8xSiT8XhJsjREhy3holSkJuzQ0tCV1vAaQ30enD4NL9gFfX7Prk=
Received: from BN3PR03CA0087.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::47) by CY4PR03MB3048.namprd03.prod.outlook.com
 (2603:10b6:903:137::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18; Tue, 3 Sep
 2019 09:18:39 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN3PR03CA0087.outlook.office365.com
 (2a01:111:e400:7a4d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Tue, 3 Sep 2019 09:18:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2220.16
 via Frontend Transport; Tue, 3 Sep 2019 09:18:38 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x839IXTM003317
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 3 Sep 2019 02:18:33 -0700
Received: from linux.ad.analog.com (10.32.226.41) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 3 Sep 2019
 05:18:37 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 2/3] iio: accel: adxl372: Fix push to buffers lost samples
Date:   Tue, 3 Sep 2019 12:18:33 +0300
Message-ID: <1567502313-10314-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39850400004)(396003)(136003)(346002)(2980300002)(189003)(199004)(305945005)(7636002)(5660300002)(36756003)(246002)(8676002)(51416003)(7696005)(356004)(2351001)(50226002)(4326008)(107886003)(8936002)(6666004)(50466002)(48376002)(4744005)(478600001)(70586007)(54906003)(316002)(70206006)(2906002)(106002)(16586007)(47776003)(186003)(336012)(26005)(44832011)(486006)(476003)(426003)(126002)(2616005)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3048;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab396802-aefa-4780-4e6a-08d7304fb4ab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:CY4PR03MB3048;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3048:
X-Microsoft-Antispam-PRVS: <CY4PR03MB30488AF24D859BDE4EE8B9C89DB90@CY4PR03MB3048.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 01494FA7F7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: dyzZsrESR5AgfSPOCevwW83uRHjZNiaXe7SKgfU4bhkPN0QOxlwDve1fjY+60CA2wqzzKaLJhseKIhR4U+QdcTWWIHGF/ujRLhKEUjt8W7lzJGDMJRjEUX7wsNMDS1YorGzTz8HdhoGMaEKAMgk1uEdtZzaz9KISQ/KR5ahBK2txW0gJQhWSwsKUrlkt5Y2h+mbk+L4HTCg4hAT3N38QS6kePjTzkaYWcHIWoFjnwxsRRbG3iYWQBxyR4nh6HB/UVH3GMUtzxlD7VHQ+IQ05k1uy2BkaUx1/aszLZcxpxmeE1Shh8w04kYvp9cmlTSP43eY2D4Vymz0Al8dofHlTDGmPYzdw2X84n4Q2W1JwGLk3D4+gID/x8QQ2ZSmuuwm6pHfxO/wEU7QWXEIMP6AeNf1u9kJVEdSi6VnRNfcHnmc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2019 09:18:38.3806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab396802-aefa-4780-4e6a-08d7304fb4ab
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3048
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=1 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=963 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909030097
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

One in two sample sets was lost by multiplying fifo_set_size with
sizeof(u16). Also, the double number of available samples were pushed to
the iio buffers.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index adec37b..72d3f45 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -548,8 +548,7 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
 			goto err;
 
 		/* Each sample is 2 bytes */
-		for (i = 0; i < fifo_entries * sizeof(u16);
-		     i += st->fifo_set_size * sizeof(u16))
+		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
 			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
 	}
 err:
-- 
2.7.4

