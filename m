Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8FEC092
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfKAJfg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:36 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:55582 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728981AbfKAJff (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:35 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19Xdid010602;
        Fri, 1 Nov 2019 05:35:22 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwh5s4ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkH9NbTqxuV/RUzpQkwvtu6Sd1T3c4PaKvfYD37pCd37eD/ptqT0Ayv+WbaYr//NV9pIDPNI2h5ad8VxiiMORhukCz7lOAtnlRVm6hc2XA2HXMrv2XJ89BYb0wkn2JdKnZx+K1uZoc39jYMv8uaQSZWkyQh0E5Jh8PQ2pyo5zVpzcL8V+ytRTbJpgBz47SRHvcwHn9lREjoTMwmKznQyglCcHP+Ab3SCIKRj5ZYzz5WT6e7De0OeIq62r+vpPsu2vKvbpbZnOXypq6hVTzTEc4j4o6uL4GCV+QkTJVQnF5auOVxBR+9Fwmh1I2ykU+/BvXPKFP/HlAG+LcO7G8tT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQvYV0WgMQqPwq0ToZ2AEKAmvjg3oPJiAnqxo+fKhrM=;
 b=WYcBYEFfqYvP2Xxutc82GqKfeDb18A6wvD0UOeb6qZ3MmxQJ/anZShD4nPR7YJnNzKpvX+/s0mGi0SfSCkHDOcknMxgUUKmfRsCUS66Kg8LUYp5xvyKFf/moRY/gNgyyKD9P0JD1S4s3LK81txxY+NQnh5+WN9xOR44u1bPKSfVFyhRza7LQN07KGCRceRjIKleUc65CHml2L6g53esVjwN3jMtTJgJGhPmYHMRGlzasHgM+98vJKA1n6IOrjzgNRTjPMi9kqdcA44rLvZw9AoRWfEJ27+GnHi7rmAO0B5rDVRd4BQwvDpbCDIq05UEW2Q0I2qjUCB2QFDXJfP2rjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQvYV0WgMQqPwq0ToZ2AEKAmvjg3oPJiAnqxo+fKhrM=;
 b=fsigeBMIhpPd3P084Ps2e4QH8+HLDg2O10Y0RXH7XYchBVbxd4sigHVudGQZ4+iUqUgHhbRrvL1DnXLr1DvkbwTM+T9OlK2iA0UeQk3fxEXIgsDIhZKCyh9bvX3jRLA9sUS05oFcu6ApD9m1oFa8iMpiSVyXfdRS3svCE6SKfac=
Received: from CH2PR03CA0023.namprd03.prod.outlook.com (2603:10b6:610:59::33)
 by MN2PR03MB5103.namprd03.prod.outlook.com (2603:10b6:208:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Fri, 1 Nov
 2019 09:35:21 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by CH2PR03CA0023.outlook.office365.com
 (2603:10b6:610:59::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.18 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:21 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:20 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19ZDSM025038
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:13 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:20 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 05/10] iio: imu: adis: check ret val for non-zero vs less-than-zero
Date:   Fri, 1 Nov 2019 11:35:00 +0200
Message-ID: <20191101093505.9408-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101093505.9408-1-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(54906003)(110136005)(106002)(7636002)(70206006)(5660300002)(1076003)(316002)(36756003)(4326008)(2870700001)(2906002)(246002)(305945005)(50226002)(107886003)(50466002)(47776003)(4744005)(70586007)(426003)(8676002)(26005)(356004)(44832011)(126002)(8936002)(86362001)(486006)(2616005)(476003)(14444005)(478600001)(11346002)(446003)(6666004)(51416003)(76176011)(48376002)(186003)(336012)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5103;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c179eb3-d8ab-48f4-84b0-08d75eaed056
X-MS-TrafficTypeDiagnostic: MN2PR03MB5103:
X-Microsoft-Antispam-PRVS: <MN2PR03MB510394E8D9E10D131B0E74A1F9620@MN2PR03MB5103.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7KyG9Oln6YXAKWa7JrpUaRG9ygLCaHO/yHvGZmzt7fwylLFJo7gKasXqks8X1ZzHG+ZGcOOykrt6IZ9K5d4JBgHhQ5A+9k5e8CD/mjpmJ7x3wpGEdGewOugLembQhxFrGHtgAsJk0DqiH1gdqFCyCrlJbJlIkD4NmO/ig36KqdHoD/dynMVgR5u6jkogmB0oQEbZB4wQmfvjZ6iF9kRlAdksJQxvhHJrJ7jA2wmMSiX87t1ueIOxWf3SHPTamAHkfyqDatSWbDDc53o12g2TUSsjfSkmUx296iiVFxiaTht53mh44ztZuYfaNZMiVkJ14InXnoqb/xPsLG/H5gU4g7HDVLuzbu7/SlXMowXBPbuGImBZU8yjREcuo/3yzRzJVYB+ClEUUEl00E9TIgjg/H6PA8yg+tW0sJJ6b8oCGSgNDy2vPHUXJxl6MPMDfQF
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:20.8445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c179eb3-d8ab-48f4-84b0-08d75eaed056
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5103
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=826
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADIS library functions return zero on success, and negative values for
error. Positive values aren't returned, but we only care about the success
value (which is zero).

This change is mostly needed so that the compiler won't make any inferences
about some about values being potentially un-initialized. This only
triggers after making some functions inline, because the compiler can
better follow return paths.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 1631c255deab..dc2f9e061d98 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -286,7 +286,7 @@ int adis_check_status(struct adis *adis)
 	int i;
 
 	ret = adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	status &= adis->data->status_error_mask;
-- 
2.20.1

