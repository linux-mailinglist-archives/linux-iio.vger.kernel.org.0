Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531B3CF4F0
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 10:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfJHIW1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 04:22:27 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:10326 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730518AbfJHIW1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Oct 2019 04:22:27 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x988IM1g029636;
        Tue, 8 Oct 2019 04:22:24 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2051.outbound.protection.outlook.com [104.47.50.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vemxatxq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 04:22:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1MvKK/orlSKJSpWlZD/5QpZ8Q5F7diW6JMANnSIh97dv2egK5QKYPUl+j5kbQRcpkCfU3s57K1gptn+QHvVFAe9NmyyOfxHKqieNk8124vjoDuofBfXx+sk/DbIUY/6Spm1G9n+jfXXNVqLN1/EYuBNjBWOj0UYP2GYlt/YLN3Qaaq9mlgtgqHqyg5PgAHbuBVPBeqosGydRQ5kcOufMiX+CtoZrAFtCRaM5s00tWuKq3HRaTMnuJWysPmKd9YPLt9959OVYKgoAd4XndNn3YskNzfOfTWsAqIjMBa58WqBkAoi7dVEW/8WFh+vtRxXm2WKS3wK+rJWsLDwv6jPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yYZzEsdEJHE7yeXc5A37cmOJSihDzDZYJeBEWlL5+I=;
 b=UfO/RUSbB0t1BH0zMjUJRFHkDUIgy/T8AW86TqmRgW4mYpcJftBMlsuJ4kblRhh3G+wPJJDFgEGSgpJaCvr0Lyp3gzg4mHc2p9OHMjhpep5M4x+2TZpx9QJbLcvnLTJrJeQQ97YMCZPkM6UxWNCd/7Azlhfc4HCGembiObSROVM13KAkXfNicvWKijem2J3X0CYAr3K24CHqSmxej+HDl9pfeTi46sdEDpHgIVhzIG7ziOIigtDr/DkMfb2MnC1OO3vgpONKnqaSFm2A0eaV2Dr2UrSjcMI6Ce1ezaapTaP6OSVboq/g1q+SJx/xrZVkDARACIKfVJvhLap8FFANfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yYZzEsdEJHE7yeXc5A37cmOJSihDzDZYJeBEWlL5+I=;
 b=L/LZDks/54B0dsClpeVlPmgO/yo6wlqCMLChM1MMYielhj5PcVZLaIzjqVEIzB1Q44RWJmjrnYXyTiFgUE7K/z8OFbhRwzatGsI3deB6u63pErQk7QqhUOHPeO1kWvq5F3I5l/uTMDqhyI3GT9ZBGJgdV1P7u8H8gBpiFT+zqmc=
Received: from BN6PR03CA0013.namprd03.prod.outlook.com (2603:10b6:404:23::23)
 by SN6PR03MB4237.namprd03.prod.outlook.com (2603:10b6:805:c1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Tue, 8 Oct
 2019 08:22:22 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR03CA0013.outlook.office365.com
 (2603:10b6:404:23::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24 via Frontend
 Transport; Tue, 8 Oct 2019 08:22:22 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2327.21
 via Frontend Transport; Tue, 8 Oct 2019 08:22:21 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x988MLjM019540
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Oct 2019 01:22:21 -0700
Received: from saturn.ad.analog.com (10.48.65.130) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 8 Oct 2019 04:22:20 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: gyro: adis16260: replace mlock with ADIS lib's state_lock
Date:   Tue, 8 Oct 2019 11:22:25 +0300
Message-ID: <20191008082225.4526-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919115716.25909-1-alexandru.ardelean@analog.com>
References: <20190919115716.25909-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39850400004)(136003)(189003)(199004)(54534003)(246002)(316002)(476003)(50466002)(4326008)(47776003)(336012)(54906003)(11346002)(8676002)(356004)(2616005)(126002)(478600001)(36756003)(44832011)(14444005)(486006)(305945005)(6916009)(7636002)(70586007)(48376002)(426003)(2906002)(2870700001)(76176011)(51416003)(50226002)(2351001)(106002)(5660300002)(70206006)(186003)(26005)(86362001)(446003)(7696005)(1076003)(107886003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4237;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d80494a-6383-42fb-e557-08d74bc8a46e
X-MS-TrafficTypeDiagnostic: SN6PR03MB4237:
X-Microsoft-Antispam-PRVS: <SN6PR03MB4237A54C73449DDF5BFE9404F99A0@SN6PR03MB4237.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 01842C458A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2bW5Ub2ZudjR1iLJiQJKw+oBh9fxy7XfGuoB9QTO5JuIc3LUQW8GnEcf/oEg25wcM7pxKAhW7hF16WGsEkn/oZJqiN0nwV6pYjRs/ZA0J6Mh80habgfxvsgKSYIVwM234MqwaygaYGFvGBPMtQYcLOhvdvqU7JLKLeAYwULzvhcZfdbiwf8Ou/RylXwsLMRiFSK6HNK+rgUtSbgyhibUiEu3YNZJ4PKQakkj4hClcyFp7lHEPJV03B7ECru4GfxsPRV6DAw/g1j5dwHjSqiUBp5MM1kFZDGwDXf5k0DRsjZN9qs3Mv86D1QKrW7LllM7Rylguhiais8Jf//ZSk7TY/1S5EvOOaSrZqDp6DwCLjyUSJE2fjDaKdNziWWqh1jpHtkDjMyF3M+Tz6t7CBQ7O5QqEV3dGRDStfKU6NEIpU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 08:22:21.9250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d80494a-6383-42fb-e557-08d74bc8a46e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4237
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=1
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080084
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change uses the ADIS library's state_lock to protect the state of the
`max_speed_hz` change that is done during the set of the sampling
frequency.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* use ADIS library's state_lock instead indio_dev's mlock ; vs just
  removing it (as V1 did)

 drivers/iio/gyro/adis16260.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 207a0ce13439..726a0aa321a8 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -293,7 +293,7 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&adis->state_lock);
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
 		else
@@ -308,9 +308,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 			adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
 		else
 			adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
-		ret = adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
+		ret = __adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
 
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&adis->state_lock);
 		return ret;
 	}
 	return -EINVAL;
-- 
2.20.1

