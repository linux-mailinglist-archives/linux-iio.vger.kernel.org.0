Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C453584D44
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2019 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbfHGNcf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Aug 2019 09:32:35 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:34824 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388123AbfHGNcf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Aug 2019 09:32:35 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77DS392029236;
        Wed, 7 Aug 2019 09:31:59 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2053.outbound.protection.outlook.com [104.47.34.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u7wxfgatk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 09:31:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sopc7JJd5zK9F+0Fvk+BbPEqBjPVn7T47oYaQePWQXUvFfx8gc28N1IK0Hk/HW+HUnJHVlUFHKnwnERcsHhTzv8ekmOZ8PFtMXArv4rNpuGsyV43QD/E/oLS3XRaQbX0qbhVNpKLdtigzmmMA/QOadqYOWwhnh+/NTwdCsJYReEmvlqc8EpD1crCZfWh5AZUPVw/fClwnWVtfx7oFHqxXqAnzNX0EFbvzIPc0udMNVv+7DXXgkWl2NzaJkdjsFv3QPQajAdOoi7JMAtY0/IwTxQktIlRoHnEvyz8dE7zLrvMViIK4kX46RebHJajYrZqbb7o35aT/AbsDW44vFhKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oETMkr97yzEp1xU4FUK7lcoSoEr6Bt8FHYMUiwCJUl4=;
 b=J74h99af7IahM9SMGY0RC7zmxIijDGUg9lgE9bsw9fGXPqMf2YvPH8SPuFgaQhX74vh/9jX9F4/Z8MV6mr6EzXnoCGZPAH62uD/GPqBuaH4J0D9SKecK/oOaZ2fFEHRqiNral5U2JJUPnCUTLHuqDess/0rIkruAjTdm0m2w413IolKZw9knBliW5c3Rc87vaEdfYp+eixSuVjNjY2ifbeB88JA0sWU+e4n7b6BAiyjm/SvXhdlSBtftNrQ21byYd/ffkpoYBh/X4XZfiB8cMR0m4/2dvXDgRgfCrUFO3FeTu2F1K/AgQ/pIWqhNGic43pvKTj7/LAq5pG82DBaCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oETMkr97yzEp1xU4FUK7lcoSoEr6Bt8FHYMUiwCJUl4=;
 b=q2gUSUFq+kCIBY4e4/EJzbBmgFf8/NDM8RqxihtD5IPdCulY4llATpmEkGp0gLkxkEvfo7cls9jUBHAEkk1rRzznY+e1Do4ing3JIqNZLluaOUW+28mu39VzYFRCWQi7clsEQqdV2nQQ3bXnyldW2oTpCPXp+65WD+fwMXh3r1Y=
Received: from MWHPR03CA0004.namprd03.prod.outlook.com (2603:10b6:300:117::14)
 by BN7PR03MB4468.namprd03.prod.outlook.com (2603:10b6:408:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16; Wed, 7 Aug
 2019 13:31:56 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by MWHPR03CA0004.outlook.office365.com
 (2603:10b6:300:117::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15 via Frontend
 Transport; Wed, 7 Aug 2019 13:31:55 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Wed, 7 Aug 2019 13:31:54 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x77DVp4e028935
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 7 Aug 2019 06:31:51 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Aug 2019 09:31:53 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 2/4] MAINTAINERS: Add Beniamin Bia for AD7606 driver
Date:   Wed, 7 Aug 2019 16:31:35 +0300
Message-ID: <20190807133137.11185-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807133137.11185-1-beniamin.bia@analog.com>
References: <20190807133137.11185-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(246002)(16586007)(7416002)(8936002)(356004)(6666004)(48376002)(6916009)(70206006)(70586007)(50226002)(47776003)(76176011)(8676002)(966005)(5660300002)(7696005)(4326008)(51416003)(316002)(2351001)(36756003)(107886003)(26005)(2906002)(186003)(86362001)(106002)(446003)(2616005)(11346002)(476003)(426003)(336012)(6306002)(54906003)(44832011)(7636002)(126002)(305945005)(478600001)(50466002)(4744005)(486006)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB4468;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d5d2b24-d1a0-45ab-c7e9-08d71b3b9d82
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN7PR03MB4468;
X-MS-TrafficTypeDiagnostic: BN7PR03MB4468:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN7PR03MB4468D6A2EBF90F579AD0ACA5F0D40@BN7PR03MB4468.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 01221E3973
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UjOzTci4BphNBjW6FyUClOroEHjk35yFDcAEhbetukQ1g6Df8ZsRMBp+FtxwuAWwDJU/fTtNUma7YgwlTprCmlLJazVbcYHykBDu+6u2vZqM6Yem4H6qFR5eRinMTQHVKf6E7RYYHqKBNFuZlRI4VZ0y/yqJFbcC4MtUU0Gv+DiTM1f4Mpt5tNu5lcj3xPQU1wdd+P2+V6/wuNpLx/J5ZSd3HCcoFaVnThq7qoLpo/XDD3Q67E52SY40y4O4QYMVSVCM2f9cNodmSXm0PbR9ZBZLKG9kqUIC28ACJ8ukTLbu27pPu4g2EypvJnnT35QsJjCg53iiPwjdr+wr5Ks4lT+BR7veRnl8g97zpWfSIFiNLoW/OY4mFPI3dbjY7wUz16ILKBvg5kEorfu+xIOHgbpJPnlScaIiGD1dC+Iv9Sk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2019 13:31:54.8562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5d2b24-d1a0-45ab-c7e9-08d71b3b9d82
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4468
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070147
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Beniamin Bia as maintainer for AD7606 driver.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
-nothing changed

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad498428b38c..052d7a8591fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -895,6 +895,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 
 ANALOG DEVICES INC AD7606 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
+M:	Beniamin Bia <beniamin.bia@analog.com>
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
-- 
2.17.1

