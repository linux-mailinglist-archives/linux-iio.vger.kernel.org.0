Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC35E5B5
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2019 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfGCNrB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 09:47:01 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45154 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbfGCNrA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 09:47:00 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63BXQPO006726;
        Wed, 3 Jul 2019 07:37:36 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tg45rb98v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 07:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTp7MjxLT17g1yQ5rSMnGEoQkR+L64VK3v62ud5gYmk=;
 b=ntaJh6tNLo16tYIHnW7/EzWj5sXskePeCk19galgfkH4iohegvCsx23UVbQiud+E3swq0mP1h5XWwzlA3sr9RZf6Uqhx+cBttE1WkpAkW2IYby7ln1tYmf7gkyTd1bfIyxij3HbpRKncOFcJUWowjZvuT9XhbFg0LjWNVw/g6p4=
Received: from MWHPR03CA0035.namprd03.prod.outlook.com (2603:10b6:301:3b::24)
 by BN7PR03MB3825.namprd03.prod.outlook.com (2603:10b6:408:24::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Wed, 3 Jul
 2019 11:37:34 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MWHPR03CA0035.outlook.office365.com
 (2603:10b6:301:3b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.17 via Frontend
 Transport; Wed, 3 Jul 2019 11:37:33 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Wed, 3 Jul 2019 11:37:33 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x63BbXqL016753
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 3 Jul 2019 04:37:33 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Jul 2019 07:37:32 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 3/5] iio: adc: ad7606: Allow reconfigration after reset
Date:   Wed, 3 Jul 2019 17:36:46 +0300
Message-ID: <20190703143648.24402-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703143648.24402-1-beniamin.bia@analog.com>
References: <20190703143648.24402-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(189003)(199004)(486006)(70586007)(2616005)(246002)(44832011)(2906002)(5660300002)(54906003)(446003)(48376002)(50226002)(70206006)(50466002)(4744005)(126002)(6666004)(356004)(7636002)(11346002)(305945005)(476003)(86362001)(426003)(107886003)(72206003)(26005)(77096007)(16586007)(8936002)(1076003)(6916009)(336012)(106002)(186003)(51416003)(316002)(478600001)(76176011)(2351001)(7696005)(4326008)(8676002)(47776003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3825;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cfab63b-3cf6-4290-4675-08d6ffaad6ed
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN7PR03MB3825;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3825:
X-Microsoft-Antispam-PRVS: <BN7PR03MB3825508598EDEDA49FC31B4EF0FB0@BN7PR03MB3825.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 00872B689F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kVSbKMy0nWx36IUOguKpsd+xPGUE9RQIXlM/tEScO3GKTu+eJkS0RGeUOwlOiWGdf6ye491koSky40ALBPfMYzTMuJAq/rg0bdha46NSMp0Bwv/iql+wVx9ay7Z34voxUqNOfTEPP1FjpsXQViurBqczbEapoQ/FJz/WKrCteSqB0bZf4OQVFlvBnGoUz81o4fkP6zhxcPau+gcJZi2TQoaoyockxLvIlT8KV+3NJFS5VpDyS2Ey3nySXZDBTpmQVCDKPV+NsPea0SCpFQf+0Q3s/RCHIcrNVE/bwxvewCU608Yvh/KqyGP/5Rk/5OKmaqi/fsnAkHuJ5bJ9/IsaL+TerZvoRZhJzHsM+y4DB5e/nHOKhblptkPHqPl07IYtxUu/N1fSl2th9zn2qVoXsyagB5usCwMFGP9nfYDNlP4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2019 11:37:33.3900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfab63b-3cf6-4290-4675-08d6ffaad6ed
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3825
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=757 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030140
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to datasheet, ad7616 require at least 15ms after a restart
to fully reconfigure and being able to receive new commands via spi.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7606.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 9eec3db01a17..a6034cf7238a 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -594,6 +594,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
+	/* AD7616 requires al least 15ms to reconfigure after a reset */
+	if (msleep_interruptible(15))
+		return -ERESTARTSYS;
+
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-- 
2.17.1

