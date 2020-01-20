Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2D14275B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgATJgx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:36:53 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:5392 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgATJgw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 04:36:52 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9Tq6R007127;
        Mon, 20 Jan 2020 01:36:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=DrWVSr7Cs3DFBetOePiInj5YUVsHPg01H9tlrc3z8hM=;
 b=A09odEJuoLFB2tTBnZLKiyW0zUTrJkDfcQtd14lW6og54lgkEHoqV6A/pqvHDK38XcIm
 wQxHgZXv4EDIhV8ssPaC8FTBoIJxmj/fiOZdhHzZ2Pa7eTWe3VSko600iiKszvCtM7oq
 p19K6+R3n59bLcdQcv0QsHtfXmublThKgZf4oOQEGK2evS1CgiKuKfJ8v+05SGPUAcHP
 rTxt/UI+BncNGDZUyvIcvzdhWoKjCcTxH+97kPrSUAMWoWL6Ob5mTRhaFqLttsLSQFdU
 cE16Bw0mlXbwNVBN6NCIj4PKiLmwUjsWd6cx0wFdJ8eZtAKX9+n7yD7vo6jlhCxRJDEb tA== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by mx0a-00328301.pphosted.com with ESMTP id 2xm1gqrmsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 01:36:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgFbtGMqaxoTi85+pnrFNesjpVWgO53p5TovXhMPr0eC5CBMe24lMe8SKTQk6miEFQChs9pmku7ER5H2nW5AdbbJcFXFLVVaMe6eOP+pFWTOk8l1nURmfG1PELiL1NSUxMcTukesMRwLEFnyqgqsPt1XtscuROApUWnp7J72fw6K5x47g2dqxjFXVrpDF6AaWOlHJTF2U8m6MTmA99VyQQeQHqzUDpSidQMXMBDfURriyZbePJ8H5uaDtibKEV0DTlBjTnKy/7ePD0z/L92vixfcBNl3tSKvmyGCYDsACsMHsyJIUJDyiUgZuDXCr4JMm4RM1cFV3AatGDBe9PDW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrWVSr7Cs3DFBetOePiInj5YUVsHPg01H9tlrc3z8hM=;
 b=Ce4qva6e05BKEzrStmluWZaDo5UINK9wHx8+sHAuircNV5kXPXnB4N/tjGjkvaY1nKH7HzAcmrsAPvPl2FsfBVL9LGX/Hv2g7z78NypW+mTu7rXlO707wquolMsOVLMJ+uSKXVzI5VeU4tXFEvLXMh1OtoWNZ4G1RWq/KlHFZavg1hged+g54X0REMB+d5cT7yk3shtjF7yJ15SrBmUTUJMpINOZqnJSLJbanDQntoGd5sVby42Yxzzhy9WE2vZXVVSNamPh+FYcjlTLMLpJ43Aim9xqxDt9UW5EdplDqeZw1ilywjlHUg2Mrl6NAYeUjje1vfXSbnabKKfHrg5rYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrWVSr7Cs3DFBetOePiInj5YUVsHPg01H9tlrc3z8hM=;
 b=W8VPi6vkb7FC6B+jrKMfHl4K7l6Zw2AkjFeEqkYtIZi55r9Ds48+VL54UyvdrjFTijxElgkHpvvDbdOHwFN1uZYLwod1BibH5wSI27N6X7mMmanLnBxRPq+PmeJ9xNLTRfjT77/IAKqSVBAOkb8uz3K1LBbBTWDazZ5XELyqkFQ=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3183.namprd12.prod.outlook.com (20.179.82.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 09:36:47 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:36:47 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 1/9] dt-bindings: iio: imu: inv_mpu6050: add missing entry for mpu6000
Date:   Mon, 20 Jan 2020 10:36:12 +0100
Message-Id: <20200120093620.9681-2-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120093620.9681-1-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:36:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 072fb128-26c7-4879-3a6c-08d79d8c4463
X-MS-TrafficTypeDiagnostic: MN2PR12MB3183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3183EBBDC802FD347DF5749EC4320@MN2PR12MB3183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(966005)(7696005)(52116002)(6666004)(8936002)(478600001)(186003)(16526019)(8676002)(86362001)(2906002)(26005)(316002)(81156014)(81166006)(54906003)(956004)(107886003)(2616005)(6486002)(1076003)(4744005)(66946007)(36756003)(5660300002)(66556008)(4326008)(66476007)(562404015);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3183;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjnOrl9vUajdPaPXPSngrT+epR5Avrct+7zhgT3JwvuEcsy9cMzl9UHJCSqkaQ6WFnewlGNSlCIAZnGcFG18SENnc45n3UweVg06pbGRRjH/p7pQBQ05x8sZfXar58HVzmqCFOro2+z+eLpn9lXkivNIo15/yjWAH9YsE+ADiXuh6TdqlOTlgjH1Xqy8KSK/ahftb6Yp8yPgu7JgurQzJKzCgTn2ue0TQT9IP7XXj5daetDR4YQMICDbJ//9TcqE3okxvHbwF+G7Ig3rrunCnsjoYF+1dctQH6tWZBQLWwxBKWE//cs9HXNqS3Mm6zrFZonRPVP1WILQSVPU0qDCw/4WfBC9sYmCXBQG2AGrScwE6QQvcwAkk3Xktx6idFE8OsC2TzOO63Untaoiik6Kd++wyl+gEbtqH4JVIipw/cC84xsP/FEqVv1U36ivZneyXMqKvS1qNJoaDwwOkyr8Jzxim9/AT0s1qgHJOHSxT+FDNSWntTBhbUrYHzVv3mKVgnb7pvHq2+2ffnD2wkX8pP418xwUWjGLEQeut/nk90+WfNfnFium7cXQ5/MuNROP
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072fb128-26c7-4879-3a6c-08d79d8c4463
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 09:36:46.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0ZOYJ+DtFXzcdPZ1Q49kgFkUh/9gA0I4mAEnCxfrTRz/PznMDh8ECpFZQ80r1yF9mf24MglKRf/5YY3HM6TEXn+Ix1X0ZWDh0cg0Fez5i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3183
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=883
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

mpu6000 is spi only.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index c5ee8a20af9f..38483ea31fd4 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -4,6 +4,7 @@ http://www.invensense.com/mems/gyro/mpu6050.html
 
 Required properties:
  - compatible : should be one of
+		"invensense,mpu6000"
 		"invensense,mpu6050"
  		"invensense,mpu6500"
 		"invensense,mpu6515"
-- 
2.17.1

