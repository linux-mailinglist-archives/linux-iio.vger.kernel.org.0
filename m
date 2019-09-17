Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9980FB4ED2
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfIQNKe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 09:10:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31300 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726649AbfIQNKd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 09:10:33 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8HD832V021273;
        Tue, 17 Sep 2019 09:10:30 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2051.outbound.protection.outlook.com [104.47.49.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v0w47nff7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 09:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neDo3f09+kxjdOUt1RjJTQyLNAV+kzI4guvbPuv7MZ1raozKFY6mUIjlCcXvkLSWGxvtEW3Vd/hw0gil0pFLKTlvIWlFRiqICZ5Z+WGg9nKoasDyreQbjAnUJstFEd/JVFm4iRcVaD2Tn/iACGwzozYUNvIQA3wWUT2Fl4eDIlB6vzKjxYsESQMQ1iP0wIlhIVOU0QhW5osn207zKISaMKy6SQCYaRq6UAiXxqT+05sFX4EkhfYbXLD7xjSNI6ddZdthTwopwjkRIE5LBI62tiCfpsqeznhXtrTDl9WL/SE/XCjSiey5ja0pKZX+vZXnU7TLjlCy90MoVnOuESMbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTkvlA1uY8UAkIlpAPVaQ1LbkHo3XVLx+OcwrU3RCrg=;
 b=msDjLXYGFrsGek8W2txdDDZHOpIsT2gELXjr5tytnyfu55zGxQvrRSFIOKQYLXXxUIajK1Ojt2W7lVACWi32jyW4MPNYNqWl+25fPXYeQiN9aqxlXTlnLxcVaUU5coSnfgHTrKND68LDfyxmQKHKAaOuAOfX2WZlB/vANj/I8m7nNAENGHUiE5jXSBndsg4CCj87atqRhwpv2H3Q4S6Oa3R7W/jfpTDEv1KwZzcE2ookY+LP5OVIrR76RMj5Np/yZvaKCdHlMw4mYP/EWkoBYqUHufD2g3F+gIpffFofn1ZEEeYPDv0oHBZnqzoA8VJymJ7aZKL//HobCWq+9LX3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTkvlA1uY8UAkIlpAPVaQ1LbkHo3XVLx+OcwrU3RCrg=;
 b=4RYeE99XBEB3A4QAsE7inF6onTKW7aNCo4a/WLFqoGEKejnLVbSmK4YURPy1u8dYwKDeO+b1fttGnVzSPm4rXQZeYDu7Ea8vuin/GVz6j3DwZEdd+I+yCjYzmwRCnVDOHdGq+53Zr+x5AloH5Zi40LO9LIPKPH8PpmUTYLmpMtU=
Received: from BN3PR03CA0098.namprd03.prod.outlook.com (2603:10b6:400:4::16)
 by DM6PR03MB3595.namprd03.prod.outlook.com (2603:10b6:5:ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17; Tue, 17 Sep
 2019 13:10:28 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN3PR03CA0098.outlook.office365.com
 (2603:10b6:400:4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17 via Frontend
 Transport; Tue, 17 Sep 2019 13:10:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Tue, 17 Sep 2019 13:10:28 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8HDAMM1025443
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 17 Sep 2019 06:10:22 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 17 Sep 2019 09:10:27 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: gyro: adis16130: remove mlock usage
Date:   Tue, 17 Sep 2019 19:10:23 +0300
Message-ID: <20190917161023.3176-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(52314003)(336012)(316002)(48376002)(6916009)(51416003)(7696005)(50466002)(2906002)(8676002)(356004)(8936002)(6666004)(70586007)(70206006)(246002)(5660300002)(478600001)(1076003)(2351001)(7636002)(186003)(305945005)(2870700001)(50226002)(47776003)(4744005)(126002)(44832011)(54906003)(26005)(426003)(36756003)(14444005)(4326008)(476003)(486006)(107886003)(86362001)(2616005)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3595;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d188766f-81dc-435d-4904-08d73b706949
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR03MB3595;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3595:
X-Microsoft-Antispam-PRVS: <DM6PR03MB3595800D851D1CFCA1D3E084F98F0@DM6PR03MB3595.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01630974C0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: U2TikoDDpY1TgiLuu3w2GtV3MQZm4lEZJ/vl3U6cJ+okCoHm7KSdwpVsT/Aj91MHzrdl5DIvuFtZScvKSdMRAJJe19MnoKkL/wBqJHUYJ38l54MpC8hd0Ag0rd24C2lDSmea2NSWVi25/f/ruCW4oxDZZ5sDbkt/HQM0vjYd4sdU3hnI4N7IQmmUOQhda/qS1WBE55mXSn0Mp432orv9lG7dsWoW5053b611PMLINFiULzvyMi91Q+ni9bzkRQoQAT95CAtFwGMbU24vEkw4bXKAewCJGnofdv9EqJKajii91pFOMHVwC8yihLdq5F2Wif8ckU2yCTtqYT2fxfnZuVBwTls4ZfqPuXqBatPpxcEymGN8vBI8dPDXHcOErtE20rMI7drt6yTZcK/32Cvq0yEPD9lJGVJoYGXAd80UbXE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2019 13:10:28.4530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d188766f-81dc-435d-4904-08d73b706949
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3595
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-17_06:2019-09-17,2019-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=1 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909170130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The use of indio_dev's mlock is discouraged. The driver already defines
it's own `bus_lock` in `adis16130_spi_read()`, so using the mlock is
redundant.

The parts supported by this chip are obsoleted anyway, so for now we just
remove mlock as part of a general cleanup, until the driver gets removed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/gyro/adis16130.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
index de3f66f89496..79e63c8a2ea8 100644
--- a/drivers/iio/gyro/adis16130.c
+++ b/drivers/iio/gyro/adis16130.c
@@ -76,9 +76,7 @@ static int adis16130_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		/* Take the iio_dev status lock */
-		mutex_lock(&indio_dev->mlock);
 		ret = adis16130_spi_read(indio_dev, chan->address, &temp);
-		mutex_unlock(&indio_dev->mlock);
 		if (ret)
 			return ret;
 		*val = temp;
-- 
2.20.1

