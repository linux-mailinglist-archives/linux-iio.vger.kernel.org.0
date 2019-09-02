Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 757AEA5757
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 15:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfIBNJ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 09:09:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42896 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729729AbfIBNJ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2019 09:09:27 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82D96Ic016107;
        Mon, 2 Sep 2019 09:09:07 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uqnt8b1wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 09:08:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJgPmHmpWc6shlfUgROUrLsP6Xt55blR/B2JNDY2KGy5Bs0uJlBEGUu7zJ3DX4/NE+onUcxC8j5Ss3aEMUwJq3GP2oigg16Vak6N4QDCAYJMCYON1P4mwrslmQOOifBIMXkkwXYiw9pvwtaWglpNCDi4wAHGSSk6KsYNYY4GDCN0jrvAwdrDqdvIOdFl+tHU4VDRkggM2jvvncky5yLuuSTA8cJ6KmhjImgk3q3B6pbEiY+Hcy0/kVPLySKQTBlOkxzG6tH8VD/8l30w4cojbvsOpIkFAKcQgLfaulW7XIykvkUynTv1hSXb92axcilU3cvz/ZjAwm6oVXgUaUeGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jwG4u59GQqLDzY0gYR/7m+TIzIvFpY9PHbvdvEYJ5o=;
 b=Vy5rc+9NqIikKeaikdTBpPXPz6Wsx6iO8G9jjd6jg0rxjyn3ci/+BZe88eFVbehnNg/fZJX4p/K5/eH2mlGb4z2nImEUUXnfbu7pkZGrgkscYnWhjCkQt+TkhPKQgkLwc0jtOddSA3iC9OkupT/JMbDLlr5glVu/AnsEZNZMj8nDGiIq51hM1z8+tXb+joyn/JRljqPwlF26MMNk4ZmdI4J8OmP6FckvEAG4mkbdGO3CChti7UUYXVoKkWU++RSd0b7rYgjApFT8cbv/Uy3mzt99flhL76msri4CkkDFovOYhMnxurcHUqW6gTSL5kc4NCJX5BicR3q3xQ1h+TxzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jwG4u59GQqLDzY0gYR/7m+TIzIvFpY9PHbvdvEYJ5o=;
 b=PIETs5Qq2xahs2UrJFC9Fd5ObtCU8BnmtckDfzFFcbFWQXy0jY9nCoRRincl7ox5l4vP+S098V369kXVJMt1iamd/aq0Xk/+pbascCO/dYhyUM/u3vGSl8Cn5JCTQ2mN4dT0wqQ+zdx+Vh6vv98uhKAZm436wlw1N3n7rxJth+Y=
Received: from MWHPR03CA0040.namprd03.prod.outlook.com (2603:10b6:301:3b::29)
 by BYAPR03MB3576.namprd03.prod.outlook.com (2603:10b6:a02:aa::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.22; Mon, 2 Sep
 2019 13:08:40 +0000
Received: from BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR03CA0040.outlook.office365.com
 (2603:10b6:301:3b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.20 via Frontend
 Transport; Mon, 2 Sep 2019 13:08:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT037.mail.protection.outlook.com (10.152.77.11) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2220.16
 via Frontend Transport; Mon, 2 Sep 2019 13:08:39 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x82D8cLQ027133
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 2 Sep 2019 06:08:39 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.107) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 2 Sep 2019 09:08:38 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V4 1/4] iio: adc: ad7192: Add sysfs ABI documentation
Date:   Mon, 2 Sep 2019 16:08:28 +0300
Message-ID: <20190902130831.23057-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(199004)(189003)(54534003)(2906002)(2351001)(426003)(356004)(6666004)(476003)(126002)(486006)(6916009)(70206006)(47776003)(70586007)(2616005)(478600001)(50466002)(316002)(16586007)(186003)(48376002)(36756003)(26005)(106002)(54906003)(336012)(1076003)(50226002)(107886003)(8936002)(5660300002)(246002)(305945005)(7696005)(4326008)(86362001)(7636002)(51416003)(8676002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3576;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 639eea12-509e-46e1-72a3-08d72fa6ac0d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BYAPR03MB3576;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3576:
X-Microsoft-Antispam-PRVS: <BYAPR03MB35764970065904214736848D81BE0@BYAPR03MB3576.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 01480965DA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: tR+tdaTGHpvXtQcY/uEYV1Ypzn7+27NcSVI1QgRioBfFpRE+mEkla0neCyH1ADmPh7KykRSNmxsk3igyr/qiQyJlxQY5Co7WcQ0bzk9vyTcdiH2zCUVuGhnvbrKAHuCDdV5Yc2BqmN4Yn3WKle94Q3BFjumsaY9n/+oIFdRpBAP74T6FltoAmsRsycS6A4Dmd1IrZROf04CF6FtnGkA3RJBAALi4Gdm/awZ6n7BvLTMREL/EH/ATDdcGrO1VsdjWId+PmECYnEscWE4MiCNtxvxGMH6k0pTlrjn0bzsaoFNHkqCFrEYaM4t3o5+kduwVP+Hztfm6/Yfq/MxkbBkzIrm41cglTe4Vp8pRoO3haDfkudj7OxZA5CKMLv7zAmxFJZOJB3koWH2CtzrTYDOt/1ZhpGmswx08nAmf3FyriSA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2019 13:08:39.2872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639eea12-509e-46e1-72a3-08d72fa6ac0d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3576
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=1 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909020148
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add initial ABI documentation for ad7192 adc sysfs interfaces.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
Changelog V2:
- no changes here

Changelog V3:
- no changes here

Changelog V4:
- added sysfs ABI documentation

 .../ABI/testing/sysfs-bus-iio-adc-ad7192          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
new file mode 100644
index 000000000000..74a2873045bf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
@@ -0,0 +1,15 @@
+What:		/sys/bus/iio/devices/iio:deviceX/ac_excitation_en
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading gives the state of AC excitation.
+		Writing '1' enables AC excitation.
+
+What:		/sys/bus/iio/devices/iio:deviceX/bridge_switch_en
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This bridge switch is used to disconnect it when there is a
+		need to minimize the system current consumption.
+		Reading gives the state of the bridge switch.
+		Writing '1' enables the bridge switch.
-- 
2.17.1

