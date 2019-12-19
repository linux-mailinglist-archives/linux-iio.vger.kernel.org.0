Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB141263ED
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 14:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLSNsj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 08:48:39 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38112 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbfLSNsi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 08:48:38 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJDUSv6027337;
        Thu, 19 Dec 2019 08:48:24 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wvtfdmjkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 08:48:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRtNjonv6Cee0F4pdmSIxk+RWK/ElS+FgodIyrgRV/9ZFPUOkLAx5/NbBg1jcHNQPqK4MoqxhtqsLcn0twSUOIkuWNScwPq2s8XY4BWzttFIk1hf89kjFLdHqzhxk5HifiSHgqhsV+zfDf7OaEJroDvHjMJLrwUihkSJQpejrPzIpKQljbIUlrbl+Fkuu03nSdj8qsPCMoiT2PrXh1oCBxuFMfsPJLbUJJKZjhMbwuYolYFdXGV/Phbp4GowCQXlSGl5qARidJ0OE4JBnT0xY/v68pYU/HjLX84Vz/KgSHqjkRgG5h0mWUW0G7WIqqJC1LR2ry/IsdpDaSDLDoxAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BldUfOcuJGTCe52IVtq8qjkqva70Mus3poSArbrOzOU=;
 b=GmcjGl7aew2TKiPS+rWu839nROvnoXe9IZEO3KJTb4K7qljrLlaLRmBMyOVYsSLZTpjLnmibS5PbG4bxE/2/H3RLPxnzoPGMFMufiHFXSTpCYChqQEBDGEB/RW8q6aeH5NZNJp/N4kJtudvN7Ctmt/kmLP0eZm9CZRt/o3tIPnZ1gGNwx1sxg8uf5NcQRE/DaPvDE0KsRupL3EBSuj6HOph0r70MgaCs9StsCSY4CX6TT7FLlcOMeTRQlZfxwjrBZzZXBANtV/Fw1xeWI9lXW/uQAtbuouYZxezEZzunMYMIaqcls5kyzvR1bSJQMseL97GfnMfwtaYs8IYTK0eNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BldUfOcuJGTCe52IVtq8qjkqva70Mus3poSArbrOzOU=;
 b=0tsla9ZGKcx30/u07aeSar4XZdszlT2xblf0yJ5TP/DcD7W4Ux+daXwlaIN5ra5y6OdJ6cNLD+TT2Vx1whzmXaeWmpadac/luAVNskje40nO8lbk3I6qRbJW+zApLCHdoWPk5zWAxwNw15E8co3g7vqRCHihBih3hMLa1XAjm9w=
Received: from SN4PR0501CA0105.namprd05.prod.outlook.com
 (2603:10b6:803:42::22) by DM6PR03MB4603.namprd03.prod.outlook.com
 (2603:10b6:5:15c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Thu, 19 Dec
 2019 13:48:23 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::fe) by SN4PR0501CA0105.outlook.office365.com
 (2603:10b6:803:42::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:48:22 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Thu, 19 Dec 2019 13:48:22 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xBJDmKfn015765
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 05:48:21 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Dec
 2019 05:48:19 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Dec 2019 08:48:19 -0500
Received: from mircea-Latitude-E6540.ad.analog.com ([10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBJDmBOP001170;
        Thu, 19 Dec 2019 08:48:16 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 3/3] MAINTAINNERS: add entry for LTC6952 driver
Date:   Thu, 19 Dec 2019 15:48:10 +0200
Message-ID: <20191219134810.6677-3-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219134810.6677-1-mircea.caprioru@analog.com>
References: <20191219134810.6677-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(2616005)(44832011)(8936002)(316002)(54906003)(7636002)(426003)(336012)(966005)(478600001)(26005)(4326008)(8676002)(5660300002)(6666004)(356004)(246002)(186003)(107886003)(1076003)(86362001)(7696005)(36756003)(2906002)(6916009)(4744005)(70206006)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4603;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1edea47a-8e4b-4952-6bc8-08d7848a1d10
X-MS-TrafficTypeDiagnostic: DM6PR03MB4603:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4603CE804B5496D82C39FADB81520@DM6PR03MB4603.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDXtgv9KWBIf6gfGHb8nD0DnDP+HQDkBjsxx12YSUKNqgWdQrxNzBSsU1/qazpE5jHiP+4GXwAUvc7Wd3jHHndPrY9YfS+p4+p6SwFnDCEAoemc9uQVXR+UwKJa4+ugYFIMTta+U7FYLg6TV7f4+By0lglNRh8AsS7w0LDvqnX4RnB+IV1XUrh7tX6186CeixaDY3HPZo4hqfR9v+iQc3doyYQQscLG/Zy6X1wISkFZggMKACXg8VokhDucduk5pZtd/izMBIuQf+o9I+MByYNaBswGr5NlWAdzDW8lnSGh0KOPSXgmqaCH0v4Kd6JOx0IP0tdkAg5lUwTp+IGs6o7pUxf8JiXJp7iZjfwxdyGnYvRVSJ/tECKoQRCWHy6rKGVVt5+Rty5QGm2IDdC9CR+EK9ramIL9Yz4vOK8r0Fskof6SdJK4bZUxF0diLM5FA17mgkOrLF2cDz5k8/OqxPFcgy7yThV1rZ3A5XD0hTx0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 13:48:22.2621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edea47a-8e4b-4952-6bc8-08d7848a1d10
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4603
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=1 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add an entry for the LTC6952 IIO driver.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896951d11e50..ad05e2890aa1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1049,6 +1049,14 @@ F:	drivers/iio/adc/ltc249*
 X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
 
+ANALOG DEVICES INC LTC6952 DRIVER
+M:	Mircea Caprioru <mircea.caprioru@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/frequency/ltc6952.c
+F:	Documentation/devicetree/bindings/iio/frequency/adi,ltc6952.yaml
+
 ANALOGBITS PLL LIBRARIES
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 S:	Supported
-- 
2.17.1

