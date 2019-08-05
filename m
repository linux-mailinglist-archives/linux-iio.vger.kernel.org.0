Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F6081D59
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfHENhI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 09:37:08 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40960 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbfHENhI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 09:37:08 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75DNCM5025497;
        Mon, 5 Aug 2019 09:37:05 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u5448sb81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 09:37:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZTnA31dg2I2ttmd+vwtpeXP0qJDUJVL4ZqwY1wlAPozsliIe1groGviszIw7RYPYwegTslDWwfPxoErnRp7zqY9fChBVa0ih7fMk4aoe+ZiPgTSgt3ArQwhrnQ54mhtWscCw4BGp4pixUyMEK/gVOfKYlFogrkdl6cmAcoOIe6kuU69gLhxiWEVRHwRzQoi3EK4Y9ZI0PuV4pk7yTwqEFrwefsydNtGCqv2oLxL9eksek53JKG7gobnouZjltkAi2Nu6uvJg7uzKWshozhDyx3p865dSbGVC4t7YkntqOwIkWGc28dCvqUrmdFZe94FuMrlrSzuuFc/y+b10ovMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZULgjRf4MNJogrxBoQQeMs2RO7KJPrg/HkrAuRoY0s=;
 b=GcSmGvBi5smmhgbTGm0BoowHdNH9b8Q9HttffDFR7sNJJnyb37I/W5vDLlSkyJR/dtSSCQ5lDVithRfNzSl47Zua338v5Dg9Do4FAQetuqVNhAFU//oOjo98CawUEPWUupbm6t+S109pTx9nlgWTwlHlMz/l86Ey/sQqniX3vg32/+zHinPd2AVDmA4baIiHhCl5045AoUFiKLAE8cyWtMOcZdj+z+kFLbFKrkLJ/56D9BJvGpW1M64EmeygxdArvFA2h7ErWa0Dxlfjrp1YiASSnj8VtKY7ZY2S5/kfxR7gkwC/eUi6rvRYe9wNOSSWGyvYEAlcW1VJdOE/29HBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZULgjRf4MNJogrxBoQQeMs2RO7KJPrg/HkrAuRoY0s=;
 b=BhjKMCSaw9TOPRglPCrYrb48I/hnZfzGrOIoRR7ZltTaQgtsloYpXa8fXQfecp7eaqJ0KMACuehSi/iTPrJbAZQ6AzQMUunvCFNnwabo0N8Bxu9pdPeCB4fDrvzgVPkydA2tbS2KyAX+F74ZXGag7SXjz/uAUgAkOSmNhdkbTeU=
Received: from BYAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:a02:a8::46)
 by DM6PR03MB3852.namprd03.prod.outlook.com (2603:10b6:5:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14; Mon, 5 Aug
 2019 13:37:03 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BYAPR03CA0033.outlook.office365.com
 (2603:10b6:a02:a8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.16 via Frontend
 Transport; Mon, 5 Aug 2019 13:37:02 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Mon, 5 Aug 2019 13:37:02 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x75Dax7a012174
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 5 Aug 2019 06:36:59 -0700
Received: from nsa.sphairon.box (10.44.3.90) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 5 Aug
 2019 09:37:01 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <stefan.popa@analog.com>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>
Subject: [PATCH] iio: frequency: adf4371: Fix output frequency setting
Date:   Mon, 5 Aug 2019 15:37:16 +0200
Message-ID: <20190805133716.7808-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.44.3.90]
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(199004)(189003)(16526019)(316002)(2906002)(2870700001)(186003)(5820100001)(426003)(106002)(336012)(23676004)(3846002)(6116002)(26005)(6916009)(476003)(356004)(486006)(53416004)(2351001)(70586007)(6666004)(246002)(47776003)(50466002)(7636002)(7736002)(126002)(86362001)(50226002)(36756003)(54906003)(45776006)(4326008)(2616005)(8936002)(107886003)(70206006)(305945005)(5660300002)(478600001)(8676002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3852;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33fc7bf0-93fb-4188-1911-08d719a9ffab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DM6PR03MB3852;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3852:
X-Microsoft-Antispam-PRVS: <DM6PR03MB385223CD27443BF357064FBD99DA0@DM6PR03MB3852.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 01208B1E18
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: aoI5+Osb+3gubbrieCyFdKc4HHuK5u/jvs4eHw7/O3Qx0tna5ZYtNz8BxnGZEX3hoDiQJXOiVUq/idz/IDr6XRLTKlGI5vsmCf7vfR3gd+Feo4FMwkTRIGMBaubwJu8KaXhYokJocJhrSt5HuI93YhQT/irOs/drMBoyxbdW/jTuj5NBSPMvrIU8URWJnJ3LkglbFhC/itFO746Vi/EVScwcNjuEYcM2WKJLVNNcMQQiKeX/FENT0pSJ4UNO9Ii2dCyi1CAX1dKaP2XA5WzzoBCLXMQDkW1Jom2t/wk1cTZHgVKr4FWYij1SzrYHeKz6xkV4r3SVAccE02M3ioW4AyC1CW1scnKzBU9Ig6fiNOdIWnr4RokUGpU4T6wq/Gx73uBsGibSIk8snbCq+lVwag+b3wVLbLuem2fp+sn4rc0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2019 13:37:02.4293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fc7bf0-93fb-4188-1911-08d719a9ffab
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3852
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050150
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The fract1 word was not being properly programmed on the device leading
to wrong output frequencies.

Fixes: 7f699bd14913 (iio: frequency: adf4371: Add support for ADF4371 PLL)
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/frequency/adf4371.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index e48f15cc9ab5..ff82863cbf42 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -276,11 +276,11 @@ static int adf4371_set_freq(struct adf4371_state *st, unsigned long long freq,
 	st->buf[0] = st->integer >> 8;
 	st->buf[1] = 0x40; /* REG12 default */
 	st->buf[2] = 0x00;
-	st->buf[3] = st->fract2 & 0xFF;
-	st->buf[4] = st->fract2 >> 7;
-	st->buf[5] = st->fract2 >> 15;
+	st->buf[3] = st->fract1 & 0xFF;
+	st->buf[4] = st->fract1 >> 8;
+	st->buf[5] = st->fract1 >> 16;
 	st->buf[6] = ADF4371_FRAC2WORD_L(st->fract2 & 0x7F) |
-		     ADF4371_FRAC1WORD(st->fract1 >> 23);
+		     ADF4371_FRAC1WORD(st->fract1 >> 24);
 	st->buf[7] = ADF4371_FRAC2WORD_H(st->fract2 >> 7);
 	st->buf[8] = st->mod2 & 0xFF;
 	st->buf[9] = ADF4371_MOD2WORD(st->mod2 >> 8);
-- 
2.22.0

