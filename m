Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FE86BE6E6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Mar 2023 11:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjCQKe0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Mar 2023 06:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCQKeZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2023 06:34:25 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDA2ED7D;
        Fri, 17 Mar 2023 03:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpqtu2o1B7YnZYi9sIDL6YkATjRbu8wias2Y25oLePkDAGalLABnDUecAU9/AMGoKBQv/TSLSZ+7r8ZTq+H+GMEQIuT3rGWGhlR9HtnbKP2p3iFEACdO2jnpWBSlud1BDSOf5QhG6QXkGa3WVaWcepAAoxvaS0YVSva3MOWfOC+mQw4/vmGmcSzntz+cYUp/SucLPI/TCULD7A9ek+I4cUNKYCFY6d+xKdvRfxWtf9hEMd7+4bO73v8jgr2ecs2IcZ/WGK2qw+a4YZZl9obYxm2Rn1xuM6/eope+LS354RZzIsa/uUgN66kR3G8V5XExlr/o8qvxyElpQl2qoVtFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHXkshLbgX+yWZhHWpTz+is3prSmtkm8aEp/t3QL8rw=;
 b=ZeRIUSILVRmP7JtAIWISg8BeSENm4H28s0WKQt2PJ9AJQF3FY58MD9CAMOnkoNNMiyUAt4gfYT5E0mRgvqJ5X2XC6DFpYsfUp2zBDJfmuQgwdiHUM2k6oHw+r6DrNZnTlCZA7WvcHPFalheZJJ95G0eUBEL0ibw2UmIzvps5tFDE7Np0zEKXwgbJxmeJICRhT1c42ckglBJja9/9xyuRDVzqw5kseqQ2B4KTJo2t1vJBzBB9jWieI+b9j6MJVwHe+/knCcvXsxwpMTYIE6P/yr6sNSI82uLedyUDV5hXKwlKuB05gzWLJAWoZ4CAYeCL+J5oG726gHcsc/CHQf1chQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chargebyte.com; dmarc=pass action=none
 header.from=chargebyte.com; dkim=pass header.d=chargebyte.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c4c.onmicrosoft.com;
 s=selector2-c4c-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHXkshLbgX+yWZhHWpTz+is3prSmtkm8aEp/t3QL8rw=;
 b=mR1XGHyB2u0sqvEgO+yEZv6bw9mLFkLwYVb+H4vS12LTTaeUNq39v6DaodVAX7O5wDzPClsjdMyRNzi1ZBDTWWxRZMPxWsOeg/A46AUZgshnz9ZGcNDvaq/Q1A7pHZL7qg6EmjnjO0Ivxr3aQi8aV1qv2A1/ZYddMwkeyDQdygU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chargebyte.com;
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 10:33:51 +0000
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e]) by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e%5]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 10:33:51 +0000
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
Subject: [PATCH V2 8/8] ARM: imx_v6_v7_defconfig: Enable Tarragon peripheral drivers
Date:   Fri, 17 Mar 2023 11:33:23 +0100
Message-Id: <20230317103323.7741-9-stefan.wahren@chargebyte.com>
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
X-MS-Office365-Filtering-Correlation-Id: df19906e-f24f-45e9-0787-08db26d319ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouTvVXqTLUH6z6e7fFohkvohEYFeGaoCpEo4sPbyr1lef0ZiUK9OUy85Yxy9Lod1w6ocEZKABGaWK8WQFurLF8Y0OB2lRysVkemWAtZjP6x5/eWKJSnxRyh1kq+A+HrLJzeR+KaNS6+xyJTCgkkxjpg3QDQqKLFAW9CHfNQTtTxLQ0yvJMi2uicPUgj4PV8IATS/PND6HzWFf+5akHjjbrBmXornWTxHLYZm3TVTPRqKpFVtXUTDEQsQ6a49wZcK/LBgGdBbL9vyDaYtPkwO6UB9zdQDBKxonxie0A1qTJ64bR9xN9btdBu4f2mfYa1zIpko1ZJff5wJth24/nWmQyzM2KU95GDtltB/VlAutSFZIUuDZMyM6+T9CxD6Z5bfiyMYsRMVaIO4JpuMHzztgeIDOYF4D8xplGj31899oxcDOk2BobQ7Fu/dnK6/d7KMhKbovh9uMFnULHXRqxYIcC+kS9wQ6KX5xzaiefn6cgnffYG0UXvr4m88+1xloR9A7Ks5nAj1zSK9A/2LlunqYWRcDxvEw/DFsljGicesd1RT9r5kWGpP7EZq6vElYcnPdPk13tFu9xlwxKg4Tq1s4MsiQYO9sZDdnmHtF/I4JMc02ddnnkbRTdZL8EFIAxWy+8tNRMkgELE6sO8kYLF4zHD8k6yd/qjpqsjyJb76q0rQM0vzOrIhpwsP7ROIPa4p1KRzSYcQWIqVziAHpBr4zfgkacTWFmiMPWXoBNjEUfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39850400004)(366004)(451199018)(921005)(38350700002)(38100700002)(66946007)(36756003)(7416002)(478600001)(86362001)(4326008)(2906002)(5660300002)(44832011)(8936002)(110136005)(8676002)(54906003)(316002)(41300700001)(66556008)(83380400001)(52116002)(6506007)(6486002)(66476007)(2616005)(107886003)(26005)(186003)(6512007)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dlh/hGBLpRKXrx4dbQzYmMn+aKXhYdYBxGnpMAlihROL8Ac3vZVo2BRaMj8k?=
 =?us-ascii?Q?6Q40RmPJKyI1395WhzvS74eEGUSZFa+/CQ2DWgHNe+BMOl/E3vNGjgHKl+G3?=
 =?us-ascii?Q?l8e0gRj3WSHR07mNrxYzpb2JfvH6SrC5EnVXui9kli6dMLzVzItWo4eP0Fiz?=
 =?us-ascii?Q?W5TYWPL9G5ePrHQ9C5VwTmnGcS2/phER8cCTLf9CH+6Iz+NzLDrn8drFGBWG?=
 =?us-ascii?Q?hQKlEncKcIGXWt55HrzlOfkUx7wwriRNCeFL+Vt18TrWamI8QAe2iKRHZ6Is?=
 =?us-ascii?Q?+ReoFfXusoZMjuVjeuc3/m4Ocmc+huk4uVrfuI9T/0lPuYGRiZqBDBbceFt0?=
 =?us-ascii?Q?av7PSngNPlXD9ShcUL0DTXBZJ7T/ipGHibIx6kQoRxBJjAjUjjnJ/lEzIskt?=
 =?us-ascii?Q?VUiBwMAM7vpciC92FzTg+W/bAcbIYpuz8PEwuVTnX1y7MqhfCAV0tgf7mzPx?=
 =?us-ascii?Q?JM2jMT3zHjWJbk7AlibIhELsVyzfGbNyjdMhzot7YZsTWfOSnLgyREGQKIPq?=
 =?us-ascii?Q?svOETyDGfGHUeowu/Y458iIodwFj9unFdnPRVamHeVfuTWIHk60Z7pWGkfks?=
 =?us-ascii?Q?tu3LTmZcVebbJai5tGyok/V7ih4hPF+EmDOdh0Uwo+CHP8yrvfpBt1A5gKfg?=
 =?us-ascii?Q?5iiKIh+b3XlDSL8V4oddnw/IdimgM4a/yXJnI+xy5CnNhzBq5acs1kMW4+co?=
 =?us-ascii?Q?N+6fn0oT47+inRSh4LQrTqTw9E1vo/JX2DU+88Is27Kvnw79OqWEqH/rYYti?=
 =?us-ascii?Q?ZsD51EM6yhlrU53MWLn6gtvi+ryHyOHQzfr4IjFlxOSwhfpXfeL1pU81DJsZ?=
 =?us-ascii?Q?RiTzSrVONyBAa1GrFJcnpUW1fqssrwU8lrpEW/zybq32rcf+HKbDf7E3oBuQ?=
 =?us-ascii?Q?1yqPFrY3kXAvyX2o7D4MRSZzPWuJZNYRtjniQnOZhref72m5V7QmvGs3Pj+1?=
 =?us-ascii?Q?fYiQ6dEh9EsksJFpiNucc+mjxSV8lmr7pj9FOhffjuhZAYOJ3IomR3mGoiGO?=
 =?us-ascii?Q?nMaBQJRkJjvUn+w8UySw33pcsdbTNnrzoSk+LmncwVW84FEOzGdWBw3eBoPd?=
 =?us-ascii?Q?5oh5PrtnMEk9NK3VQvhp3yh+suAAJJl1MbQzg8GCqxRZdLSYFvggrfl/f/rG?=
 =?us-ascii?Q?/wHIpZ/uzratpOCNu0RsTJwkLmmlD9xrhfDPXf6p/POtDxhYAWhgdD+t7Mnx?=
 =?us-ascii?Q?FRoT+7bofvCDGv4IBbcm0e6VGF9xWZ89S2l15ij3Q92DKuPLmI71ypQdNIXe?=
 =?us-ascii?Q?FEkp79IIiYQ0nVarprLkMCgMtb0Xiz9MhDtNqNq6YQR89oPpCg6RVFxJzG0V?=
 =?us-ascii?Q?ibDeJNqqGL5L/uK6ICPGY4qj80yCYDuvll5uw12ZC1BcDtqufIS6tE5vYhvp?=
 =?us-ascii?Q?xHo9lqsCfBCFcqZ//LK3qV3yTJPvp+zM0hVyg7ud8cRRy+46PU60btQApp8I?=
 =?us-ascii?Q?z5o3qUZ2SoYQ2rWBLfzQYelYTIkVvpNaaBEDXbY9IgfuvUM9HuQ/ysovN4Pc?=
 =?us-ascii?Q?lO3JOzMT6FostFQHsdJucxhVY+r58+GzK8nyZKWv0LeiYsitYgOHNaxrpfLz?=
 =?us-ascii?Q?aQnZY06qc+AG1fa9cRHTvv3D2uY+ocz4AW2cI7s53UN4Ra0YmqZ+UqV1nKaI?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: chargebyte.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df19906e-f24f-45e9-0787-08db26d319ad
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 10:33:51.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 30547194-0d55-4a2f-900d-687893d3bdc0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BazFcU+lK4tG+quMpo4l3xmix/2WossgjZbqAxrQaDfewSy1MZs6rxNBJZmC+qTEzLGGaMJLVntbwdZDUNXanuAJvIGFWrv4X5jgwm5ApUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We need to enable some drivers in order to use the following peripherals
of Tarragon:
  * QCA7000/7005 Powerline chip
  * One-Wire Master DS2484 with external thermal sensors
  * external 4 pin PWM fan
  * ST IIS328DQ I2C accelerometer

Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 02ccc86a8d4a..3a255dd5a453 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -128,6 +128,7 @@ CONFIG_CS89x0_PLATFORM=y
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROCHIP is not set
 # CONFIG_NET_VENDOR_NATSEMI is not set
+CONFIG_QCA7000_SPI=m
 # CONFIG_NET_VENDOR_SEEQ is not set
 CONFIG_SMC91X=y
 CONFIG_SMC911X=y
@@ -216,6 +217,9 @@ CONFIG_GPIO_PCF857X=y
 CONFIG_GPIO_BD71815=y
 CONFIG_GPIO_STMPE=y
 CONFIG_GPIO_74X164=y
+CONFIG_W1=m
+CONFIG_W1_MASTER_DS2482=m
+CONFIG_W1_SLAVE_THERM=m
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_POWER_RESET_SYSCON_POWEROFF=y
@@ -224,6 +228,7 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_PWM_FAN=y
 CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
@@ -408,6 +413,7 @@ CONFIG_CLK_IMX8MQ=y
 CONFIG_SOC_IMX8M=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_IIO=y
+CONFIG_IIO_ST_ACCEL_3AXIS=m
 CONFIG_MMA8452=y
 CONFIG_IMX7D_ADC=y
 CONFIG_RN5T618_ADC=y
-- 
2.17.1

