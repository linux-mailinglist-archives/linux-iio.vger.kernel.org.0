Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1660A1541F0
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgBFKcX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:32:23 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:11136 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgBFKcW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 05:32:22 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016AGhJh020601;
        Thu, 6 Feb 2020 02:32:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=1xvdr2Ts39k1DirXZnoomdhUJEKx970MzI8Vk28DhTs=;
 b=q2nhwADNOckrycSkwahx2yv+8Ux0S8eeU0zI8yQtCKlbgT27nOZAu09fhm6qrGhM/V9w
 xzHRJvcScgErnMabIhOwau69vPNMHWGORMnPzMM12onInI+z07PNgTJX+eiuXW0g45CL
 cIqDHvhxMpQc57VJfCB1b2hMpwj3C/I7X3qvJYxjYIabL0JkaNtbP7DrRa4gq7q/fqIG
 Aivk4T5W0BBSz/076O1talUqMfSo33HnLT+EhL3SEuV81TutY9CpBCv67zN+R711kY8v
 Xei3fH8XiRg6EUSRj0pOYYZARKxDIQ4anGOIMdbzz/FmIF0ahxU82hxfE3BS1l9c0x7d 9Q== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00328301.pphosted.com with ESMTP id 2xyhqf0tb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 02:32:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FALp71ILexMELJF3i6Cp6f2Xs0DnUmlNeJThGTeIil1CdgJ/8mxI/DdublW03IctV5TCd5M6l+I4R+SyHJNaQP7NkddUbjEpm67kJiCZ7eiIZfrJfWmXXufTFhqieku85WEUubpETrM+pLhM7aUsqV09X0XdKXnpg5kWs+DDbwDUlKosHCVXrlyebFMHWBP8Fku2AU7pNkaoR+z+1E/5bvtD3XCquCAYNhs1D1fES727JarWBrdPV0ZWyM/3fAHVkWRfY+l9DWK7i6AE0TXW++zs5iyR9n/uq4y/AFbtE8508KP7y2eRRLIqbsVFqI+F0r44ynq22oeT5b+3SYj8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xvdr2Ts39k1DirXZnoomdhUJEKx970MzI8Vk28DhTs=;
 b=iVGnsdPXPe5N/OFLDzpsqo8vz+qEr7wXIHabR0KQ/eJAyPeB16yUBsgWXt8CUfQGDmK6ycabJ2hD3DzB37XPjIK+faUJzLqZPWj7qA0TjnPi07gmOz06gkIkaZRTDnFiyPUN+n2WPbzefwCAaOcuNIVd6z4Ny2JhoT8EtTfkZs90GmjbVsJYknPlRe3aPh8354uIP6YpY3R7HnkAk/XeYwHjeH0VN78bkZx8+pT1Y6FDfuTytgqFu3ROF0/JaSW6yGrWRtLTytzYArc8CkbyzorwoGDMgfJ2B/tlX4AxD7XQX4krr5IM5mf2E4QXHLbcKCqn1yyQDKOzueiULI5TjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xvdr2Ts39k1DirXZnoomdhUJEKx970MzI8Vk28DhTs=;
 b=guB+bKdTkiHyOVrKIGU+jWr02a6i6DGOvj5otUzBrCaA8n0OP7ZaUVDTLVX3tvgbfK6L3OyURC44mTlvcQ+ujL1nbpnNpD2Dj2wt3AV0aSJvdmiOrAC4lj604hA+eIVwE6EWxvnkCdZdpuagA6VtKryup48tfaVUrw3vABQzwNw=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4085.namprd12.prod.outlook.com (20.180.16.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 10:32:16 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 10:32:16 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 6/6] dt-bindings: add description for new supported chips
Date:   Thu,  6 Feb 2020 11:31:05 +0100
Message-Id: <20200206103105.23666-7-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206103105.23666-1-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 10:32:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8604601-041e-49d5-86fe-08d7aaefd5dc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40856B5287A3ADD5FBCAE441C41D0@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(966005)(478600001)(2616005)(956004)(86362001)(2906002)(26005)(5660300002)(186003)(16526019)(107886003)(6666004)(6486002)(1076003)(81156014)(8676002)(81166006)(4326008)(8936002)(36756003)(54906003)(52116002)(66476007)(316002)(66946007)(66556008)(7696005)(562404015);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4085;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZEng4Ag9sWFxlYaVbWDL2XoHwsw3J7/a8PdWsfXB2A5nUVDKWKhxOeS3DRWtwRRXtinv2/ORWyc9a7Z55DNhYeARf53ZuSfbtAColpYZ9ozJi85jZ/aYPcd3vOqi0pp5jduqmYlXz9rro9pBk8L59XdoYu9Csj4DNT40czC7B3evz/Vp4aLwuJOHFG2De1noY7FHhdEE2/4U6Dz9/OY5yiDWISDegh+O1eJqw/FiEwMj0Qepit8f4gSe4fPIludMsEmyVm8QKBzymoC08Z/1gaQHBlXHApKwGpVq5EjB0jYnBN203VcL6RzUcgZTmOqYP+PKLc2Boe3FqCfaV9fxJc1XBy1WE1IjAb3RZPHlGyQP4HlpzbHdxHzMa0ULxbFX+4Bx872/uRn7VYKyoBXwXgFSdRi9LCKYOcpJ1TvOT92gBWC24/IM94VA5O6Alfn0lURuX16biyG9djRvTc2BAvSbqpBLWtpFuYkdEfGvXUIdX3e+LNmFfos5TQg1GKTqZOwA9KrZ7kvNLH9eSSK0A3mFpVPK6qfwhIJEvDytvkq0k3X2JAXyt7cSoubD9ro
X-MS-Exchange-AntiSpam-MessageData: hGt4/RbJDR1JZeQ2PY2vOUjdVIvoZ/nmSplcjf8QEQoX2gnywSB2OMFOF6PX1a/nPRlYHiLShDYNpTIWeGlhqjQyGANpB0xixw/BwKv1RTYe2GOdBTsuEXKS0sAvfdSIUBSAQtSCVfhnb76sgUFAWw==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8604601-041e-49d5-86fe-08d7aaefd5dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 10:32:16.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cyC2w7UMKscFzZa41Ogpz4RC6RVdNxfqi63SLqRFcrzMxNhcU26JOohMaSoXZSbV1oCLnYdCNtKHSOdWNVamBQf8uiy1OD1b6H+BC9sWco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=782 spamscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060080
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing mpu6000 and new icm20609, icm20689, icm20690, and
iam20680.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index c5ee8a20af9f..f2f64749e818 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -4,6 +4,7 @@ http://www.invensense.com/mems/gyro/mpu6050.html
 
 Required properties:
  - compatible : should be one of
+		"invensense,mpu6000"
 		"invensense,mpu6050"
  		"invensense,mpu6500"
 		"invensense,mpu6515"
@@ -11,7 +12,11 @@ Required properties:
 		"invensense,mpu9250"
 		"invensense,mpu9255"
 		"invensense,icm20608"
+		"invensense,icm20609"
+		"invensense,icm20689"
 		"invensense,icm20602"
+		"invensense,icm20690"
+		"invensense,iam20680"
  - reg : the I2C address of the sensor
  - interrupts: interrupt mapping for IRQ. It should be configured with flags
    IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
-- 
2.17.1

