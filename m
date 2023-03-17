Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E57F6BE6E5
	for <lists+linux-iio@lfdr.de>; Fri, 17 Mar 2023 11:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCQKeV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Mar 2023 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCQKeT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2023 06:34:19 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475D72FCD8;
        Fri, 17 Mar 2023 03:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUD5xFAsUYiEkOJVu2qBcpzsK97GwXpc3/LI0qYV6oEs721EO6aas4BInh9XqtI6awQX/v2VkEOc/UP7etB2ebrfe9VWbVFcJAaq5++q76LO9LBBjiJBgAWXtbfnJQ6s0rdfvH2oWSzBM0xcQxlh0qppzgIusp6klIp6WnasolxuHnz16Aua+4qV0gBBbxtTGuR/9CkMZ7lONht5dgJETxg6g36RO2xjuh5OnaJSlkVv6kHYhM6hvnZZPnBxDWqGqHHCYppszVbPWT+qlsduWALO6fB9WVU5Exs2v4N2JvhulEaiUW81+8B1NdU6O5s2vs7SWl2yitlc3ubdC1mVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLqLGwj5p4Djjmz1/SaU847Q64pRmHBj6EKCPcXNwp4=;
 b=K/5la9ZFCFprTy4qeLxXDN3FuBzjz4eFPmZ+CKyas8i3CsOxEP5JCJVJa4Vln42f2O/3+lJCUxPgS0M9RyFP+RX6rhe4Zmckxr1uVNLOZbuyDLsiASVtVu6Xtoup51Sq4XwqHosrovzHViesDQSgvLjjaWaqbKhu67kP59Gm8fa0hlrXP7jSnGJwuEyIUIlYh9d+AQQnhsx/774iytmpmw+egxxXj7BJh86NR+KNcXTH8orsEqSlAPWTM+T52fJu4jCSVI01bA5V4u/y9arPd5cwoQ8iL74GZFHkPK1VGPgAd0PzxsQQktGZn25KpyRlwim6bmoTc/JYmVhsitSMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chargebyte.com; dmarc=pass action=none
 header.from=chargebyte.com; dkim=pass header.d=chargebyte.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c4c.onmicrosoft.com;
 s=selector2-c4c-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLqLGwj5p4Djjmz1/SaU847Q64pRmHBj6EKCPcXNwp4=;
 b=JBu+vuhCn/53QDjaIACphDSf+jUcbbebx1Z/eNRo52VtxxjQJnb5l94r985jx7sPK+cLnmXyNF23BicZC1marFdI6nnbOoonv1QEweGqRF974ol0/ObRAHyRhel4N5jfoUGfhArFQ62hAIAEBYPTcPU8/+BaMDXJOuXT24HHA2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chargebyte.com;
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 10:33:47 +0000
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e]) by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e%5]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 10:33:47 +0000
From:   Stefan Wahren <stefan.wahren@chargebyte.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        Stefan Wahren <stefan.wahren@chargebyte.com>
Subject: [PATCH V2 5/8] iio: accel: add support for IIS328DQ variant
Date:   Fri, 17 Mar 2023 11:33:20 +0100
Message-Id: <20230317103323.7741-6-stefan.wahren@chargebyte.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230317103323.7741-1-stefan.wahren@chargebyte.com>
References: <20230317103323.7741-1-stefan.wahren@chargebyte.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:33f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5211:EE_|DB8PR10MB3863:EE_
X-MS-Office365-Filtering-Correlation-Id: d720f611-a04e-46fa-1535-08db26d31729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VaeZofDVLhhHnU28Xc6dbLgvhfo0vrT6yLsX7LLdORu5wXwtdWrMQyYEdN7OLCNCe9BaSZGbwLkpyLWOJ7mX+mkDH3oySZMLE2JjzsvPcdzhiLT4sSrCZ0EsE4fy/D3r+PFxSGLhaZS26TgPCS+aA6+QZlL1DUwwnuHL6BWec6OKj1EemjVmUtrB40sFvt0gmlGiS6Uz2HlEoMqN1eK/Me0B4a4y9rZ1JH7qSBT38gSVh1HB7EIERhz1hrHWc7A8VRTlLa8pSIfBPA3RfcqYVAnc3QXBzm2ymGJfbJRFMUSxgFWCy4Pc8LP+xuo1Z61UZauCh+Zh3qNoQQvk9k4g97TrXTZZ7rigRc/+wGKomyhsCZljJ1XV1w9Ncysu5d2TFntpAs4N5XK3Zn/nKeC9AP/V9NXWM64Hz52YnUwc2Lmds5PqO7igIA1S9y48R4clR0cAwOVx6TctdxmKQNYe+h064ZxbvRH/7ZYzJtl50NSwE6pm+TmZX+LPD/34OKik23vgGrsvtrXwyQ4110rz/dQHHIgnu/6DumAWT/1Z/jHkuBaBT9I/u7CJw6pK4OjGkQEYDQDbFoXjIw7omypKTuA4/xAOtrueTwZoZdVzfcHrGJbaINObMc9bDQKSmtf/hC5+rNpQQYaXTni8iv8IpC68qsLpTRaRFw5SXEdS3qMeRoNIaNG0d8yL8+bCyIpilvp89QCCoS3R8+qGABJzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39850400004)(366004)(451199018)(921005)(38350700002)(38100700002)(66946007)(36756003)(7416002)(478600001)(86362001)(4326008)(2906002)(5660300002)(44832011)(8936002)(110136005)(8676002)(54906003)(316002)(41300700001)(66556008)(52116002)(6506007)(6486002)(966005)(66476007)(2616005)(107886003)(26005)(186003)(6512007)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MTlhMfUC0uSjuhS4p1iU0Vy7Dy5o/pcE1BZyWoyIF1eBBCKYQJQ7zshkZNvp?=
 =?us-ascii?Q?rqJoyMs/Bq/S2UNamYrpKhgAEaZcELD1UYAr2QD8boFtiZOnezfDzqfINDLG?=
 =?us-ascii?Q?d9R4HPI3xVMaj7S3Eg8CCoFopwQBDSSIECxCLSPShWaUBIvgS7kDTyjayBtw?=
 =?us-ascii?Q?+BdM+NEWkcYNTXaw+Oc61JCSSkQT8XFRTcg8ZqJnOUyyhQebStnYBNTws1i8?=
 =?us-ascii?Q?gA6djRT8+mk4l8vpVMjUA/SqJnYqEJIHwb2Jt06byzp6wWfAmiJHrFNvg1vR?=
 =?us-ascii?Q?i8yv1pJiqu4i+klGGn7MZToNqq/hsWe6eF9DKa7Y4tzTwFYepIASZkOBu8xx?=
 =?us-ascii?Q?ZY+cQF0oXDJAdNEKFybTpw6u4WKzEJefkO5UwApjXRQa6GacjOLMHfFgbv3T?=
 =?us-ascii?Q?GsOrjc9XGABOToiM+hnHXHh8UW0PkQRL3cpQglT2eX0RBxqzdP/XkMAxHByr?=
 =?us-ascii?Q?X066ztOoWEiegt/um3mq3o0aCh7MAzV5PWY7gOcUYm5fUncYBxn+a+HV8Fj2?=
 =?us-ascii?Q?sL/GYun5OOAK6i/YNfRXpxEbVNxidJiol4F/a1QJifZKBejPG2dY3Tq7sZbe?=
 =?us-ascii?Q?Ax5dFeY8bunBzSQ9enoUWck1kJj1tGsEHKguTB0RvKqBuvXj1ZQoSK9OoceD?=
 =?us-ascii?Q?EJ0ohDU/A1jcVOlfO3hbK3d/lk67LFxfT/artvxONUbOYJsLXm1doAoAuXKb?=
 =?us-ascii?Q?ZTMea7h52HDgoaXKDDV1kja0+wb0ud5gmfJGXdCnQqP1HyZ17pqOdnh88ra6?=
 =?us-ascii?Q?FhvNpkm50uVSN0YMa2S2mPoaKXqpUgGWJAkH4iZ9y/6d+SA6FiNxVT80Sfsl?=
 =?us-ascii?Q?yVc9hembaWTyVFgYu5n5gxRZSZowXSqcEokPeSc2+P4bi3Z7QS5qBJ/NOXMQ?=
 =?us-ascii?Q?OQGpDL+y1Pn0ASLYI2za288kyCzwSrlGWbZopJhJABDEq70GQq1ILVzHJ453?=
 =?us-ascii?Q?WzQ6sZfJVRkwHEuL+qfHb8uKyE8FdTZwF1ZB2qoF9my2yHEbn6onQpcPUfrG?=
 =?us-ascii?Q?s0DvalrATh68qGoAy7YFLXzS6K1FcMxP7FDzSn5CEOkf/ezqtxb0fcu0o6Ub?=
 =?us-ascii?Q?RgatRt+00n5xvfuiL35BNO2LAFv3g8GKAfmcvlvVxquY7gchNXJvuNB1vXC4?=
 =?us-ascii?Q?YOoW3E82Fi9qtJx0G3ZRpWQXPXMRutsULfhWMvN3LkI50ScpEmp8IFzuzCNL?=
 =?us-ascii?Q?S0rtnEKevxTWvtuv2V1nrxpLv+z1Qr2EqGAJU3wRpoRWkiemgq7e6mgCPt8T?=
 =?us-ascii?Q?0F9/b6GS9C2UDzl2uSVm93WmjHmPvvRm8AEbI3L3yRvgoLEZoZKGx8+/Z6XI?=
 =?us-ascii?Q?tFVabUW/vFs+sNe0MNwZsKZ/JHRdemhs6V7GKD2OqAshopvrQ7C1QgFFYImU?=
 =?us-ascii?Q?8jzXlFMHxOgz8T0Cgi5dTVHoBWmJYP2TQHHlZyzsIjiJ+PG/5dWyTcYofEVT?=
 =?us-ascii?Q?f9N1ZJcqSLpxFVjvDleJlxtREaPUvDZ+I79/U5Ur/a0wroXqnJg4/G4/tEc1?=
 =?us-ascii?Q?W/EwT9tqZOzeee3tNN84ecUZ2uTbd6/K7MCag5rQrU4FjBdfuRPiRjxabEFg?=
 =?us-ascii?Q?6G5gmlKlvzWROah6GXrKMgkacQXztscHpNkkMUr0HmG9gnjmMgr9c7MnXkL0?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: chargebyte.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d720f611-a04e-46fa-1535-08db26d31729
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 10:33:47.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 30547194-0d55-4a2f-900d-687893d3bdc0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SGcys2S6z9yhxpg4tCEsNQLWIpLfWlU0ffApbbeAx7ydRTNKF6DorbXQ/QHOfccvsy2cGjwtXJgv3T0qM5Xv5Epv1+xLke5l4o6B9hoXQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the ST IIS328DQ accelerometer is compatible to the ST LIS331DL,
just add the new compatible to the st_accel framework.

Link: https://www.st.com/resource/en/datasheet/iis328dq.pdf
Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
---
 drivers/iio/accel/st_accel.h      | 1 +
 drivers/iio/accel/st_accel_core.c | 1 +
 drivers/iio/accel/st_accel_i2c.c  | 5 +++++
 drivers/iio/accel/st_accel_spi.c  | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 56ed0c776d4a..e7525615712b 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -39,6 +39,7 @@
 #define LIS302DL_ACCEL_DEV_NAME		"lis302dl"
 #define LSM303C_ACCEL_DEV_NAME		"lsm303c_accel"
 #define SC7A20_ACCEL_DEV_NAME		"sc7a20"
+#define IIS328DQ_ACCEL_DEV_NAME		"iis328dq"
 
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 6b8562f684d5..5f7d81b44b1d 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -517,6 +517,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = H3LIS331DL_ACCEL_DEV_NAME,
+			[1] = IIS328DQ_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
 		.odr = {
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 3f02fd5d5946..fb9e2d6f4210 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -119,6 +119,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "silan,sc7a20",
 		.data = SC7A20_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,iis328dq",
+		.data = IIS328DQ_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -157,6 +161,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS302DL_ACCEL_DEV_NAME },
 	{ LSM303C_ACCEL_DEV_NAME },
 	{ SC7A20_ACCEL_DEV_NAME },
+	{ IIS328DQ_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 5740dc1820bd..f72a24f45322 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -100,6 +100,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lsm303c-accel",
 		.data = LSM303C_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,iis328dq",
+		.data = IIS328DQ_ACCEL_DEV_NAME,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -157,6 +161,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS3DE_ACCEL_DEV_NAME },
 	{ LIS302DL_ACCEL_DEV_NAME },
 	{ LSM303C_ACCEL_DEV_NAME },
+	{ IIS328DQ_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
-- 
2.17.1

