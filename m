Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F89B8B8A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 09:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390680AbfITHbo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 03:31:44 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2446 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390886AbfITHbo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 03:31:44 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8K7He9h032292;
        Fri, 20 Sep 2019 03:31:30 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2056.outbound.protection.outlook.com [104.47.48.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v3vbdm3py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 03:31:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVkbP+WcB0uPhEY8ykLYWC7idtKQy6YU5ZWVmcYD2OiXM47ZJK0cnuE9M/+wYEkU09ofWuhmgu6Db2HsffCN0OkHriUmDII7IthWxpmbFvTHgvWA0p+LZqMsQ50cJ/t/wiSLnhErm9sSfZxJIsy067YI73vfqUAJ07sLE6arvFJt1IsOx91IsLcKTrJSzYR0pa8RzZRETTfMurHfG4ht4UvDhDaIaI8poDn8kxLwHw/5AdWESK90XKImq77Y8hev9x1k6JAg8ij02BmhFbA8l8Zh53g3U5HjyIpNFJch8C5tg1Vh1pt5uyK+CSELJYecOf7qFJSjgdGPdlULWPJdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWBGJOZs7TdyMQFjOpp9RIrVuYD4lEfKXcW701vzm+w=;
 b=LZR/zEwPsp1CFWVuP3PTAmh2/XELG3waNhTN/ibDVve0NJCVYrFheDiJJ2fHyuXrEbKDqOVlrmVOz5EjaHxtsKNTVbklrnaLohXOzXqSd+L+SIYub+Q2BvPpTE59+L9I3g7Vzuxgn+XbAWcbxCw8dKFYxXD2CZKtzPOi3bVUZcGS53yUGmzpXsd7z1iznphePg2cCzCxENxCJD3p4qIbAMRSVsIdhioxUlKBd7fOJ555w5tCH23CenyJgi1KDLzVF8ArlT2a1NJoWzuyvPdyxmk8pSGpnCbM1gMTA/erv+OYkP5DQnrOoodqWM1fgOndtYgH9l6onbArwDBfetJfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=pmeerw.net smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWBGJOZs7TdyMQFjOpp9RIrVuYD4lEfKXcW701vzm+w=;
 b=Kqz2VxO21PpwW6rfGQ9ET1zPZyMfpg7Xq4kfL1/FMDZLPqiDfKOyJcrjNSRmjiFaJwoDn3qhdrL4PKOunlZK3eily3PIBm9d4rsUlc6z4umYih/KVnkGCcxDR3imHXNmpX9Ijmtf4N7V4jJTgyXcauH1d8X2WZxb/ZA9RgwNZTs=
Received: from BN6PR03CA0095.namprd03.prod.outlook.com (2603:10b6:405:6f::33)
 by BN8PR03MB4738.namprd03.prod.outlook.com (2603:10b6:408:6d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.22; Fri, 20 Sep
 2019 07:31:27 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN6PR03CA0095.outlook.office365.com
 (2603:10b6:405:6f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Fri, 20 Sep 2019 07:31:27 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.20
 via Frontend Transport; Fri, 20 Sep 2019 07:31:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8K7VLW7020396
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 20 Sep 2019 00:31:21 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 20 Sep 2019 03:31:25 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <matt.ranostay@konsulko.com>, <pmeerw@pmeerw.net>,
        <jic23@kernel.org>, <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: chemical: atlas-ph-sensor: fix iio_triggered_buffer_predisable() position
Date:   Fri, 20 Sep 2019 10:31:22 +0300
Message-ID: <20190920073122.21713-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(356004)(70586007)(70206006)(5660300002)(106002)(7696005)(54906003)(47776003)(186003)(26005)(486006)(126002)(426003)(5024004)(2616005)(14444005)(48376002)(36756003)(50466002)(476003)(51416003)(1076003)(2351001)(44832011)(316002)(6666004)(86362001)(6916009)(336012)(246002)(478600001)(7636002)(305945005)(50226002)(107886003)(8676002)(4326008)(2870700001)(2906002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB4738;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bfdec40-0981-4cfe-350c-08d73d9c8c23
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN8PR03MB4738;
X-MS-TrafficTypeDiagnostic: BN8PR03MB4738:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4738A1000D253846742B3443F9880@BN8PR03MB4738.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0166B75B74
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: peUfUdyf+XJCiTJBi7JXHgESNpJfRe8UoZJdapcQkr7C+zTBkYCHhTc8rBHuhdyRlxmqcw39yPLarIWX6uotfRYyYVo/HSQ5wMV5/3CxD/t/Uxn3D8X65Two4Q0SKyq5OnbvJghU34S8gqBql6qAhu7m7cpUfKuVss/TV6QevOwWvBlOmu1CFXuvXAcZg2EXokBRQj6qC0UJ7ObQyJ18a/fX+Xs2QI2Hc0lNml1fSv1bdFKA4c0x3gZ3pZOuhswEnJpm5V5U86ovCQu+Ah5zV0GYopbjtLjGbo4rZwoREfArnc5N0ZWUwL5aswgGebVVv0XNP1lTPJVYbn+oIvggDWqCX/bH9BLPY0fiCQzud7akmYUT5uJZCUo+7lzt344ACt1Yj5yQl/Q11kXBYsTmp2JVT+QKWxJsv0VnRZ2vXX0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 07:31:27.0363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfdec40-0981-4cfe-350c-08d73d9c8c23
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4738
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-20_01:2019-09-19,2019-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 adultscore=0 spamscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909200077
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

The iio_triggered_buffer_predisable() should be called last, to detach the
poll func after the devices has been suspended.

The position of iio_triggered_buffer_postenable() is correct.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index 3a20cb5d9bff..6c175eb1c7a7 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -323,16 +323,16 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	struct atlas_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_triggered_buffer_predisable(indio_dev);
+	ret = atlas_set_interrupt(data, false);
 	if (ret)
 		return ret;
 
-	ret = atlas_set_interrupt(data, false);
+	pm_runtime_mark_last_busy(&data->client->dev);
+	ret = pm_runtime_put_autosuspend(&data->client->dev);
 	if (ret)
 		return ret;
 
-	pm_runtime_mark_last_busy(&data->client->dev);
-	return pm_runtime_put_autosuspend(&data->client->dev);
+	return iio_triggered_buffer_predisable(indio_dev);
 }
 
 static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {
-- 
2.20.1

