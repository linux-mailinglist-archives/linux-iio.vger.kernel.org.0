Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D916565BF36
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jan 2023 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbjACLoI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Jan 2023 06:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbjACLn3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2023 06:43:29 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2081.outbound.protection.outlook.com [40.107.14.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002E7FCFF;
        Tue,  3 Jan 2023 03:43:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbFjC+Z9v+5INInA/edBHY8GXijD+CtYWoVZS8e5/QdjwvOM+7p0cExQbdLOgjp7MhmuX99z7P6xHZpQp5ke3TBaLGm8QvUF9yYAQC56LBMLcXWw04DNsC7m+CEkI8SnRUpsUBeN8Miwj9pYa1YQTtF1P7qs33g3jq9L8k+h3ILLw2ftcrn+chshP0Z/fFTe3go3qmCvoNdDuoPm1UegTxytrFYKcYHHkGRc23eFzHKlFb8dj2r/3E63PLvwsnUQNsbxRJxpSBK7PZ2AMNWRSsy2ebkxPwoPBPSRE3vwafCh9VIk+A+wj193SwAz+83PYOrGr5XmoK07GGDBq2yKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUA1Y63Uw21wUYxnYvIX5RtT4aJhxnM75O+48C2EUFE=;
 b=bpMKjysHK5w0W0cb8JuKO97adMtM5amRuiTtMarKiyttxxHzYCbNcUo0q0T8XR6wYHLENmb3wpr1IpkN9CK21mZbjoTXkt1Q3AGGRcNg5LqanzaYWC6UavhRbQ09B4nqcBZkG1e0kXB62Wj+JVlKWrrdJ7zn+jA4AV0Z+gvSt+3cptQtQRBXBjudpFfAmlnRfATAw21rBsx/MX5MrwpPvGe7K/mFo0VcFw4thDwVSsp6T2w+uzygX22tiSvXohMaPB+HT+KnKDJ5WwsMDyGKGkA5jlYZidckgCmAHJ0EA9X0EgaRHooTfP58xolZdNP0gwCgu2yt7PHrSaSdoaUbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUA1Y63Uw21wUYxnYvIX5RtT4aJhxnM75O+48C2EUFE=;
 b=NHB2ugotrOifgnPdr4b6fVSHG+wjDdXK/js9+SBJcwY+H0WHvZ6OxamJ6lO6GwNlmKyjgRkl5r7kbI7IpkxKHR7Ekp2AEbQuLJZBxK8d1IbODZercB/x/JZqj4YFCusv+omK2XsUsjte96qWNbMhxNq+kqGzszwbpgp1o3KreKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 11:43:16 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 11:43:16 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        haibo.chen@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/3] add imx93 adc support
Date:   Tue,  3 Jan 2023 19:43:55 +0800
Message-Id: <20230103114359.2663262-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecd289a-ff63-4147-a5d9-08daed7fb3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OxisELYyDb2+gxKNUAHS1SBI0ZveV/RWoePFWH9PTYzP1P2MefcOJ5TEkIG5VmBNTWGh/0ZpZ8+d0dSj6QxVBPBaAT33IOgxqDo3h6+6lLV4q6IV1mgAWcuPK9dD7uMC0MbqzBo7F8xcqW9c5xkIctmXFXJ/6n4CLeu7neFeOWg+B+Hqbc+/toVleeekAn927wmWLdoWpSwjfafuONubrpYJuyGIk+Cs4Tjh5W67c8Y/LHNRKnTZu73i1xqUhwFO+beegzukJF5afYXSpROaX80FiYq3OxB8t4dXPWxozsZhqjVGnaKf3MQOFpwpekZxotF3mpeY3D2DGdAED5HxD2iOD/G3HJCObzwGbpdMze/Edb2f6Q6XEyZuUxPF87iZdla1eHOvCiEHb0Yo8NcVdawHJ5G1kYRgPTgy45BX4ryXK3pOF1RtaGrzi0a+lAoyBiHj/R34yHAM7wY7aqnK2Ws7M3/s2tq+g1qENQjFnBxowMu4n0n5fnP4B8dgTJkPfyogu2nOfK7M5pgEBlwg3j9xUj4GKkX7yUx+3xgMdSSm9e1V3YZAa6/H257gHXlE/jTJwdJaVWw7Y5vsVA4MJBEEvWzhXPgbv1N86mUSD1Vbwj8awayN5Sop+fphZimyMaaMw//a/WN0EtKP2MfWKLTkelLbXyuA9QWgb/yiC1bYr1CW6ZGeRe8PuZSdJFXKOSLYWn3vn9ntFBGv299AC64CGMtx1mkyzdiTeTo+D0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(6512007)(9686003)(26005)(52116002)(6666004)(186003)(2906002)(6506007)(478600001)(6486002)(66556008)(66946007)(1076003)(66476007)(2616005)(4326008)(8676002)(41300700001)(316002)(83380400001)(5660300002)(7416002)(36756003)(38350700002)(38100700002)(8936002)(86362001)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fo3Ax0K3vLTObFWw8qbBWlUSJQUM82M4Me1BrAC1TeewE+hvtM33jrWxpcAk?=
 =?us-ascii?Q?5VoK8gKInqqxM6T/Sg0GPG/wm2MspMIj2QQ92DhJLYzwmPq/ynO56O6P83MR?=
 =?us-ascii?Q?X+HwicHtZ9uuXkwZfgxCz9zeyeNEl/x03pZUDFCAYoRlGZrW65oKrE91rEZD?=
 =?us-ascii?Q?c5ws74/h7v9ouOk3FQhAMT7/brDR+bOYHUK/wrfZgEF1CfyHac9bePEDk+RX?=
 =?us-ascii?Q?9bITIzqM1O4Kmgk/wgPl9pl5WOU8jNQHL+vTWlAnPiy38UPtL3wgkJxXOkYg?=
 =?us-ascii?Q?pJ4auHDpfQoE6B0/CGTmA4Va4ui17mG3W4uCcGHhq3loKi0SZDFRjM+8FfIF?=
 =?us-ascii?Q?1sd5z2c7dgCtAfhzw9CGjmjSFdN5kl3xETzwn9Gkt2h8xZpQb/R/xi2VLhby?=
 =?us-ascii?Q?dtJ1yDnjoqfBbyiNnu8JBoCPQeYzcdN2v9h/2ONOWO9WvFaIM/XryfRLo998?=
 =?us-ascii?Q?9lcaffsTQReOk81VOVmh+UkcSz3CLi8Zpqc/g24aN7Rx6TtMc0PWjymJIwcI?=
 =?us-ascii?Q?IovkvQhHSpZFulXl1yvwXOO68zWFMdkPvwSKlwFiCNAusMJ4LSlSe0Rk7fCl?=
 =?us-ascii?Q?UuVHAzBZsr2ERBoGFJVcNjGzfSsx9VYlQHQXHeI1MeB9r/ZDNKAv+OBiTxFB?=
 =?us-ascii?Q?OH4ib7fk5d1vfLxELqWZASlBCtkfHqCkWKAQ95laoH9tIZubPLBe57QgG8QQ?=
 =?us-ascii?Q?X/tetJqgBcZyWKzTwZjHSCcLiUVn7JBykVcN/sGNp8doH658k+zzvQiujDT1?=
 =?us-ascii?Q?JinSZxi52dOpCppOj5CefX5qBJIYCOdAfvI6ZIUpMPeiWto43mPstRtezcF9?=
 =?us-ascii?Q?jPnmDHGHEHAkjveKku2k4pRDmPW+kCZ6+kB9U8xML1AtJGDzSL9xSw3Giodc?=
 =?us-ascii?Q?Us0xfYnxtzOR673d75j4ad3p/GoUOc5VDfEOkniqzAbes+sQ9AXaRz8McNWJ?=
 =?us-ascii?Q?vfWoTh1K8zCXXeEtMgcEw7+SmP3T2VbrbWW5Fv0xBIXH3lsqBXueHQZ3IcCF?=
 =?us-ascii?Q?9EhfPoD/uTdci6P3gB6hNTYNjX3zuZnyxtVjCjAu1Wd3DL7CIFtOsIYD9ec5?=
 =?us-ascii?Q?I4Dhz/hL4kAkzCjigMOLuhtZcrRsI/plaHOdifwyBbbbL2L8XOVWWJOG9FMP?=
 =?us-ascii?Q?Woab4hcjMbr0RAjhtIwEdOZis5+S5s4di23JbFEuuPIrOefy/MrEi/Ubph0i?=
 =?us-ascii?Q?MnK5bUsUqirIIyPR7wIxhUEKjxlfPxtom/Ajr+Bnu6dGHTvyGgMUt5XnXGuB?=
 =?us-ascii?Q?E+wQOIiZimQ3aIZTsjFh1Xp8oAwRBRX9C9Zs3NVj7YwkQMYqlnLlvlT7np/G?=
 =?us-ascii?Q?iHutsNYKD5UdIzpQ3ghw/9FYbgmGsyBUbKthIbEEWvVelfZfBCBaQZCCzBBE?=
 =?us-ascii?Q?MmEO72jdPTZE98pEkt6RGx5lU3PU3R0d/Zp9sjEdvLUyPBfwPgU3J8KP+hnZ?=
 =?us-ascii?Q?ZvBnbO9tM1QA1yALBJsM+pc+aEC1NhJHWjl/Xk6RLqDOy2fslP3L7sHGUXze?=
 =?us-ascii?Q?zQneDTjgxIi68fCg3mwhIJYjXgilmxgqmgqRaahrnwYxKL8bGOagzUPsRVht?=
 =?us-ascii?Q?uzyNrNz1xDC3Yd3u19OWUJNWF1WEikBLegW+bUt+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecd289a-ff63-4147-a5d9-08daed7fb3ca
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 11:43:16.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrE/+y/2eO/jEQIPUUgiuDRro9lQHOJCJEaW4T4ELfTGfAyctYr6lxLwTJCYfYCLJJzSIIMOBpWS47i8201DVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

V5:
  -For ADC driver, use dev_err_probe() to replace dev_err() in dev_err_probe(). 
  -Add imx93_adc_power_down() in the probe error path.
  -Re-order the function in imx93_adc_remove(), make them inverse in probe().
  -Remove the pm_runtime_get_sync(dev) in imx93_adc_remove(), because this driver
   enable the pm_runtime autosuspend feature, and config the delay as 50ms. So when
   called imx93_adc_remove(), this device still in runtime resume state, no need to
   force resume the device back.
  -no changes for binding doc and dts.

V4:
  For ADC driver, re-define the ADC status show the relation to specific register bit.
  Redo the imx93_adc_remove(), change the return error sequence in imx93_adc_read_raw(),
  and use a direct string for indio_dev->name.
  For dt-bings, change the commit title and add maintainer's reviewed by tag
  For dts, no change.

V3:
  For dt-bings, add some change according to review comments, and pass dt_binding_check.
  For dts, add #io-channel-cells = <1>; to pass dtbs_check
  For ADC driver, no change.

V2:
  For ADC driver, add change according to matainer's commets.

Haibo Chen (3):
  iio: adc: add imx93 adc support
  dt-bindings: iio: adc: Add NXP IMX93 ADC
  arm64: dts: imx93: add ADC support

 .../bindings/iio/adc/nxp,imx93-adc.yaml       |  81 +++
 MAINTAINERS                                   |   4 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |  12 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  13 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/imx93_adc.c                   | 477 ++++++++++++++++++
 7 files changed, 597 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
 create mode 100644 drivers/iio/adc/imx93_adc.c

-- 
2.34.1

