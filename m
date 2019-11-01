Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7E4EC09B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfKAJfn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65220 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729072AbfKAJfm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:42 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19XUH7003902;
        Fri, 1 Nov 2019 05:35:30 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhjrw1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejILztXPFyFbl9bvv6vri1e3hHL61ef7ZLic+XB8Y4teCYynL0Y3TVqguoH8TQPSmfM6tO26H/tl7C9fVa/CLHdNmP11C6KGMGbirVab+4fihRPpptaCNF+NAOKxq6LBuROS7tlmMONOersTSd1sdDoE2kU3hY2zPv2zdT6c6ymdupE7lwSkRaZDIO5AkGe+SI2CbndbwEV6SmCCb10smrUq8ZMUwl2vCjPTqkUdUQi0S87NzdKNYZD4tz8giVTdkJ3IkXacf6ekSmfsAoYltG++Ond2EYmkN3GtsLLhG8Wp/yBmWrZdIggfhUla1PUeBro6A5hn3FX2pHoFs0eiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAEsj+9LhmJetlL3s1pIRNs7VvOSWs4OtR+XG031FlI=;
 b=UZNsqRO0jjQo+LIayQP9RAo3dokLPUGjfmWgu5gXo7mmvBwTMCEquVsjDE9emXyt+hwfEljpWOVA0v2HX+8vwThBdNcn7t+E2zJwUy9YtiaYCmNIW89NgNXSPK88aKPPAW1gXlu8e2qMy6Pigm7YcQXQ051B6Xk8Epam02MYqq0ah/TsPHiJNpc79+RBwKrhettNOA2UzoO8KdDC7Vl8HAAR+0CdsPSAgKuf336v8QHyvXm/4EjQwWdp6qKFWTw+d7dcn+66B8SYGdxVW+0YzSRNmW0LOUnv03L9iy88lWdzZAjkxBNYf6L6AJyFkUVXbymYdbgK4BOnlawux/eIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAEsj+9LhmJetlL3s1pIRNs7VvOSWs4OtR+XG031FlI=;
 b=J3Q01ClSvCrhJE9KX/q5VoIXqnwGOEKAueYQUwa7odJWgbWzO1eh3RNNECXgKiBBJez26iJTTiNO7IY51OCsvkLAOOBwcjZuCYlASpAw6Wrl3SQdEh/1CAb9J1476mkF5LcRrI+cfaTW8dXHZlgajysbAcgIxIAtLRmci2PDU8w=
Received: from CY4PR03CA0010.namprd03.prod.outlook.com (2603:10b6:903:33::20)
 by MN2PR03MB4622.namprd03.prod.outlook.com (2603:10b6:208:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Fri, 1 Nov
 2019 09:35:28 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by CY4PR03CA0010.outlook.office365.com
 (2603:10b6:903:33::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19ZJlH025103
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:19 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:25 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 08/10] iio: imu: adis16480: assign bias value only if operation succeeded
Date:   Fri, 1 Nov 2019 11:35:03 +0200
Message-ID: <20191101093505.9408-9-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101093505.9408-1-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(8936002)(110136005)(316002)(51416003)(54906003)(106002)(246002)(1076003)(50226002)(7696005)(76176011)(8676002)(5660300002)(47776003)(2870700001)(70206006)(36756003)(305945005)(7636002)(478600001)(50466002)(107886003)(446003)(336012)(26005)(2616005)(86362001)(476003)(126002)(2906002)(486006)(356004)(11346002)(426003)(44832011)(70586007)(186003)(4326008)(6666004)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4622;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8a33a64-4a55-47f3-d6ac-08d75eaed420
X-MS-TrafficTypeDiagnostic: MN2PR03MB4622:
X-Microsoft-Antispam-PRVS: <MN2PR03MB46225C4BEF6A8119F143BE9CF9620@MN2PR03MB4622.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBN1Z7l4qo7q28vJhmI/KF2amc/WZ1fbra4GXDPlsVF7NzQgUnmUs3NSybG+HHapRSoCiEfrnAb6dgkghp7PNsF6LVuygVzFQqRPkYtb1sN6H72iDNOVkNZ6TdLCmeBjMTr7ly00ZF26l3HqFPk/Kqi9mgqheKsO3UFhboE4yJ+rpPW23FWpBsbK3rHDIqOtdQfuBSq8yYuQObaRhozne6jgpLvi0jibUSpYLKoPixO2Lcep/ablAblRk9dhuduLpszqEpuwQAqx/65nQhM/NvwgRuz7uSG+OxrH3t3YaH+ucttL1eqzo61hCxxmnZDn3nAnnJIR0SfUH3sSzSll0AGMuDMe2FilzEa8RXVQ9c3OlawGHbDmXa0mm0kodh0EUSPQJ2XMZG8jgGKtwgZstDuNcXild0vPOevLkFmYuXnaC0smVi6ilFs+yaJC+ixK
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:27.1285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a33a64-4a55-47f3-d6ac-08d75eaed420
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4622
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This was found only after the whole thing with the inline functions, but
the compiler actually found something. The value of the `bias` (in
adis16480_get_calibbias()) should only be set if the read operation was
successful.

Fixes: 2f3abe6cbb6c9 ("iio:imu: Add support for the ADIS16480 and similar IMUs")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index b9e2695bcfad..c0e7e768be41 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -451,12 +451,14 @@ static int adis16480_get_calibbias(struct iio_dev *indio_dev,
 	case IIO_MAGN:
 	case IIO_PRESSURE:
 		ret = adis_read_reg_16(&st->adis, reg, &val16);
-		*bias = sign_extend32(val16, 15);
+		if (ret == 0)
+			*bias = sign_extend32(val16, 15);
 		break;
 	case IIO_ANGL_VEL:
 	case IIO_ACCEL:
 		ret = adis_read_reg_32(&st->adis, reg, &val32);
-		*bias = sign_extend32(val32, 31);
+		if (ret == 0)
+			*bias = sign_extend32(val32, 31);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.20.1

