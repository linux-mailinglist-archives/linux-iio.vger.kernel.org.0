Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4050A142796
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgATJrk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:47:40 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:33686 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbgATJrk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 04:47:40 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9SwM5025978;
        Mon, 20 Jan 2020 01:37:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=vLQTJETV/5icW+gIXrvxlzritXE+3qPJ+7/Afb6p9z8=;
 b=UWnDo/kpxFVIYSB3CX8TJ3jRMJkZptwWreURoT5HZhzfvTgRqUpS/M/WpxOzeOpDMn1S
 HLfF8SaCwea4k6DEe6cAD+ryUDxwk9dJZncIFFUlOaRTw+FWvfDfKuWzFEMWxEE4CLph
 6e+uvoZf8JrtVaWxkAGpQnjqQHu5WqDztrcSL2hf9oILeVZFAgwTtvqcaw/WSBerf3YI
 aahVzHiqOm9lvV9CyNaaEPy2nnqczIEXXKOA4aeOztIgUirUrTBewsa2D6RubSWEhRCc
 /ynifcHuegVynFzkcoDCte2+pJPuYOrbwubdOqlMURVqjQLFjXIkT3a6BC3F4tw9fTMf UA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00328301.pphosted.com with ESMTP id 2xkxuu0mxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 01:37:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExOH+MUxy51NKMfq6lGlR8e70FcVfOdGNwzQqD6Pef4flp0el4DTGGE1ZsKf+WFrWUiD9WDZdyuJ3JNEcxsyTC0oVEj2pIK3rdK/fZ5dHPMW3K7xfodkEJXVsh5JDoQuMBaiDfuMK02+czny/0KgCAsVUUS35DKZOoCG1XTAh6ZT31JRkNMWtOf1u8XqW0rJlFvXwCckMoCNZvAx6z7K9Or5jixPcujLw0eqsaRIYyab22fkFjOQ6ZsBf9N8/E+pm93C0y3FRKcZP8lW6wGbJIVqi+9O2hpDWC/ZrYl8cEWf+X9yZ4Oxoo3OcOu6Ha3UEhpP4R6lR9Dgyc8GN8VjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLQTJETV/5icW+gIXrvxlzritXE+3qPJ+7/Afb6p9z8=;
 b=ES3QJ2GAB1za8t5qWZLpO6BC0TlPtm4eRWAWaTQWvmDLJZ0kJRjVhj0chEwgQml6SvFa2EalNuMrRJ4QbWx3Vnu9+9GB3GP4H0xbe0RN/vD2kk0mrfDGaIpPoiKkZCxEnc3z80BCfVfDeo6TfXBRjX2kE8y8tz5IKm77D0XxpIXGXz/fA+oJqpbJaAUjpzRE/+G3+zMhx0+pDCIY3Q6RAoVCKGbfSwXJeKJyAato0kt0gSNj+3KfSFaQYDXCQok933nEoHFaT3waRnJh13GQIdB019iGFONUbci+g+c2KkA/k5eZrtcv+QaQdMVV98HIJrXzvGmcHf1hRUIQEXUNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLQTJETV/5icW+gIXrvxlzritXE+3qPJ+7/Afb6p9z8=;
 b=LX+IkQvuJhitgUh5Z94TFSuT+K+/9vGCyLZFH01DLBf3iznaKYoMBf+R7d6wjJlyOMarlwbySQ46oxJdMRsImwSxejrgpjxkr2iHayNaw35RWKiRMUC2XvgFigEYaQmedRdyPHoionNNaEg2+zw5DlTNY5wNwG0rl8arR4o8Edk=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 09:37:00 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:37:00 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 6/9] dt-bindings: add description for iam20680
Date:   Mon, 20 Jan 2020 10:36:17 +0100
Message-Id: <20200120093620.9681-7-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120093620.9681-1-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:36:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4226cfd0-b27f-40c7-025c-08d79d8c4cad
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40484916DCA64AA496004D98C4320@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(66946007)(66476007)(66556008)(7696005)(52116002)(4744005)(86362001)(36756003)(107886003)(5660300002)(6666004)(2906002)(8676002)(81166006)(186003)(81156014)(54906003)(1076003)(8936002)(478600001)(4326008)(16526019)(316002)(956004)(2616005)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4048;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGs/wA4BoXlS2t6v3dylZaqFPuQX3WKrAv1RQMK5FhzlKQi6IzDzzKjP1xoTn8y0u20lEE+O1ZDQpWtYmWAyh7aoDXJgaa98aBeYkxd90CvvkLbWFDwoFb8EBeXg9U3rkc4F2KBME5snvsL+/7Y3Xi34dC/lOswWEkQ6hJclVgJsVKzeodrx4lT2hg6d+/OQ3PlrbOK4ccPpr9vl/NDNdH1RFU2/XBtA8z30BYVzmKRSzmwXPuh9deePU9CEN+YuP9s4p1ivCLY1gxTVOvYjiKkQSng6+8v096cATZ+a5JZoHbEhjG3h2zwFqxS0Oli/hOLWfD9yA2dMDAKbG2d/xGfmQcOy4mJpkS2S1/HWRKck0d8w8cavQKHOUmxGMgg/e5p97pfHfnQa6OTKV+742eqQiCpDde/NvEIxbjTib4P0wzuB14jRenZJ7sULjfpa
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4226cfd0-b27f-40c7-025c-08d79d8c4cad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 09:37:00.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld2e4ZhKTP1Er04eVmsOoqdcNmc1ZTABsaWoIYyeAxI95S0xoW4bvQF4fcS83fcZP8/gBm8WrSLIcx4GjmRLjQvzpg1EfSY7H+cJ8h4ivP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=732 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

New supported chip.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index 606daa145975..29cec46e27ec 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -15,6 +15,7 @@ Required properties:
 		"invensense,icm20609"
 		"invensense,icm20689"
 		"invensense,icm20602"
+		"invensense,iam20680"
  - reg : the I2C address of the sensor
  - interrupts: interrupt mapping for IRQ. It should be configured with flags
    IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
-- 
2.17.1

