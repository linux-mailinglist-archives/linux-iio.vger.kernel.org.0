Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6509C164749
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 15:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSOlV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 09:41:21 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:36730 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbgBSOlU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 09:41:20 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JEdZTC016941;
        Wed, 19 Feb 2020 06:41:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=QN9IlZdTIswfuX6DlTgo4hiDqK7JGVTkqXAy1bHxHgw=;
 b=byeUyvJ7lPDwhpmG1zCd7wPe9tIFnQzJnieExjV90S8tLN35J3E67nQOBYt3XSsZy3kk
 tMA5t1CDbJaXdacZl2bvhhL51j1tldRLZtghOMkc6aU+XbLz38sJuKq9sdDpIQ6XAzQv
 s1UPxeikyizD/9oJ66mARJpkOAjX46a3nNO5u6oEHd/KlMclc4KV//xK0Wf883r4+lSt
 uJ3LcvzHEZHD1bdJn0O26H4lXg40TYDLkrvIoLOEMLv0WaEOPqCPZ4mIaklNpuxaG10i
 V2c+Gwj/a9bs4B2W6Ym2ucpPzn9LLvGxq2VW/Asrjk8G9Ujb47Yiif4ywuwgrW0ZpN/K qw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00328301.pphosted.com with ESMTP id 2y8uem893f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 06:41:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA+QAmAUUmY8Wx9OgpELQ41dVxbVyhaXDoGwoPAbSOcOAuaVgnyUyGKhfKjS3z3aCQQxIGdjS10tb8XXNlpajImJ7+6Dp4sdcwe7vhz9dW+wdx4KYKl+UDvRI96SyXuRpEW90NZhWaV06C2bZ34oBCbC0v6g6zAu+dZ8Uma37moxpeU3Ox2+MG4kI93yB06zkqMQgY4ol42R6DWRBuyAirtsGOqakBO3A9Im+BJmt183WilS3jxzcZ6Wmf14QmkwJPumY1T5FZ10EsW4QBdgypgENhkxR6elcBJR2NBb8nrLtcpIM/nC4Nv5+PtgRugORDrZQaEFg9UW6KYEGlqMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN9IlZdTIswfuX6DlTgo4hiDqK7JGVTkqXAy1bHxHgw=;
 b=jy1Oetcm3x7FkXSSqT9FqWQWCLTx2tBx0cexkIHlPuiR4arbKyzIbQh/5W1NaqZDhQ07FRo2UJRf5mNQ53n2f6o0e+7wgzb/ziXcfwY/6uROVnBwAAEsf+jqHuUxyngBQajZoh468BjEOz2oxLDRF9LL6IENmfLv4STGJpsdEV5hbpyKpPmaR+USt5e5BwfMqKNSpmRu56qfKsbRsVu4usBG5OUotIA8QNw7z0Q/UvHjdNnqLJgUdWvmrDtwYgvwEXcL/MCvY0cE7v4CaS1IJBv78cNumbrENehnrBIStuTT4N2eRd1BDLvbXlU8IRVybuhe+ca0sYGVJ07yWugRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN9IlZdTIswfuX6DlTgo4hiDqK7JGVTkqXAy1bHxHgw=;
 b=Gtb2TLw8plPFJCn30qtvZPYPnaPMBYJKOD7uvqA/QNcSbzreqovjmXwSTckit1kWGmxddxhPVPCo84565CWc3EDcG48DKwJlEGLahc9Fdpy19DNNAaOtm1n2R0CXQCDWat/nGjnUFrb4krbywCcpTjV4uAfFdZgAzqKaWizG6fY=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4213.namprd12.prod.outlook.com (20.180.5.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 14:41:17 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:41:17 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 13/13] iio: imu: inv_mpu6050: temperature only work with accel/gyro
Date:   Wed, 19 Feb 2020 15:39:58 +0100
Message-Id: <20200219143958.3548-14-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219143958.3548-1-jmaneyrol@invensense.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 14:41:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e729fb5-7e87-4f4f-1519-08d7b549c6e4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB421326EC5CD1C3038A74C5A6C4100@CH2PR12MB4213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39850400004)(136003)(189003)(199004)(4744005)(2906002)(36756003)(16526019)(6666004)(26005)(86362001)(107886003)(2616005)(66556008)(66476007)(4326008)(5660300002)(66946007)(81166006)(186003)(478600001)(81156014)(7696005)(8936002)(1076003)(8676002)(6486002)(52116002)(316002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4213;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SteKXXVxKOOc+niJboEKejo22z0eB4Sy2XSr4QKcnAMq+ZhsoqacA7HickP/9oYYNWEA0R1ZCfWxde2RtfC0hQaEIMmqxGNnIHgy8srWtCQQDxIXT94iHvREUWiYuEKlavZjg61knkZCymjDu7yrfQE50Hq+cFEXgdlJYeaI188chiyjZnIqW7XhE8wlS+msJDZfpZk1EbKuJnIrYWQ9WyWW32LNQTryNaChWCHxCiGCmWKooh6FdGWBUykPunx568h0JORn4CbtT9PzZ3ocEsLvDfyOcPThYgdSIDM4mXnGmczvktundxKyEmvuAw9n87MoHw0SmGXrY4JTO5Lr9Op+d4NHVeBw/d2wn2IDpoiFEv6T7DtBci9Eb4pAsNfz223EG/tf4bSxc0dOXBBQc16F2nt0I6JdReIvexopn5uVLLOY9oLMCh9vvuFkvT0R
X-MS-Exchange-AntiSpam-MessageData: WRacVBU53HD+rmW4UDnMCmYv3N885iKRqU2HoWBNpwuZ1XHcdcshzu6utPT0l9Z7SvoaUqJ781z2lkxVJge1qX3GM0GSCdN2R8lzlwSSuxN8ViyuZODBREl3thge3PK5QjFxqtZ4B+swTXDHb5QsgA==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e729fb5-7e87-4f4f-1519-08d7b549c6e4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:41:17.3666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z68FCYl1JPES5M4yJAwYxbRM+4BOL01nr8cjAkLK0C98rQScVgrTS2Cm90THkfZpODumfQpDPXnT2XH1GQ1jGaP3hWubsLXJqEIhxuKNMQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002190113
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Temperature sensor works correctly only when accel and/or gyro
is turned on. Prevent polling value if they are not running.
Anyway it doesn't make sense to use it without sensor engines
on.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 750fbc2614f0..94a989368b94 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -597,6 +597,11 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 					      chan->channel2, val);
 		break;
 	case IIO_TEMP:
+		/* temperature sensor work only with accel and/or gyro */
+		if (!st->chip_config.accl_en && !st->chip_config.gyro_en) {
+			result = -EBUSY;
+			goto error_power_off;
+		}
 		if (!st->chip_config.temp_en) {
 			result = inv_mpu6050_switch_engine(st, true,
 					INV_MPU6050_SENSOR_TEMP);
-- 
2.17.1

