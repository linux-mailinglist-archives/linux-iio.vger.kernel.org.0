Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A8655FE9
	for <lists+linux-iio@lfdr.de>; Mon, 26 Dec 2022 05:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiLZE0y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Dec 2022 23:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZE0w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Dec 2022 23:26:52 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2080.outbound.protection.outlook.com [40.107.103.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2E5EA1;
        Sun, 25 Dec 2022 20:26:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb8EFy3StozFHPLgexex548vFsqvkr8UjLCeQTbV+Fp+ecBVk8oAFW1DdpcarGXFEOMQRuLtU8j4sRfLyfJ3EuYeE9N84SFd/gVXRZauyAJM3n8lih2EWYS/OerfLrdxlOH1fLi3tvKC+1Rgr2XIPGjCHBSUU2NvSZEhhUbvjxWkm2nkjIpWs/7dGsFlwFCRfe7EpI8qsqJVCn31MqJDsw4LciL3mmF700Iam6GN9Pu1M7cdbtfZmjf/jVIdlreqkSTVMe9Q4pPJXzI7ZihZ9ipcmryn20C2vliwZLX8g9d0pC8M1o3djojZT0f7tIOcV6gWmBDvEY5dDqOZRjamrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09ws7bObJwpta2LKW0xMdmQx/gYyIQt5iMeCLNtKeoI=;
 b=nbG+5ufTRyDc15oGSqGKTXwR/2fBGUJTxRDC8bRjQtDLXirQu+GGFFikFT5peppv/kBF39fu4+c6fX0WHskQQumE0k2sXDhxn8K2gEmxfisdGfM5yVHpvqSJbtOLZbBRkfTiIl906rq+ygmAi8zgnx/6mMdNQ/+QhcIKQX25haNzTQDDKG4+1mV0ZYOfZw6S2ni0UUi2atadCWa6rj+0tJoBS2u35sgLCiFvH1tp8GjUJG4U+s2/UdtQEJqW5B2FlDEmR8aeZSJMZKs0ELqMkkzxog0027U0chG5NM23Sj7yoci7o/R0nzZPb1MlSp28EiABR7UJvnFIwkB4puqs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09ws7bObJwpta2LKW0xMdmQx/gYyIQt5iMeCLNtKeoI=;
 b=Rdm5E31M5mmB//sBXgiAWLLc5piKlePFWd2RUEMd3N5vMx+YRJR+YHBYStVXvi9VAkpvMqPJV7cQzOlRGwGueGzA8Hbcdb+Z4lurx0GCDecjIuKhmn4qFJgrCfxlxOreFdyzad1ACouOzcKhOCjQ5w0VHsCucyUfFrF3K6qrpDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB7792.eurprd04.prod.outlook.com (2603:10a6:102:c0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Mon, 26 Dec 2022 04:26:44 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5944.016; Mon, 26 Dec 2022
 04:26:44 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        haibo.chen@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/3] add imx93 adc support
Date:   Mon, 26 Dec 2022 12:27:16 +0800
Message-Id: <20221226042719.694659-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PA4PR04MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 1455c7f1-69a4-44b0-e246-08dae6f9649b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHz4p42eJRbatm0FkZu4+NPJ/BPbLGe8pvLE8Pa8iRqVSAhTQKB4BoaHukGSjBHwOwuJ7HBt/JTKDZaKuYiMTAcphCGZKAsljnrHXL68p+dzP4GZFLCn4AiMGXbubOPzSn1rHIG78e8Wp+DgehblWOLPpPkze03OkboJOe6gky/7TuAVa2q0TOeUbbzVzfU5NoL6yRZO76m64unjXHpRdKKNkvM6JDFtJA3IWMbhxQpQ9ZvuaHlD3BRbZs1Xu0dI0Bk0XMZlJAjb01plQ7Xp4gz5CaIYuy6m18jW3AaGr/LzHO3MVzKznrA3F6R10jSvSqTnY/aBrt++gP/JlnaqI/c+QULAD10K8jki4lC4tHIeQ6uZa722w4DcZrplhIZ5OM6MY+rSuzBmZAbhWincj3BkFE4M0HkFHhvZoRtY8rzUhASr21Kx9x9EdjOS3V/qRGwgbJCtlO7lEB24Q6flSKMNrpHPszOtXSbkULpqp6PDw318AJJxMQaKns8MuOXPLIrZvLE2cYGUxSFoTsCrWDgQfRehUlOvf44qVxPvwxVdy47WM8dRtJrFpsXHXKvsaQ6vYat34bHJ0QTNe7ZgnPwC39RrUrjl3e1ERahDttYggEUL3vMM6qLthsRMIjEtq8avVEAaRw0mQRx0QpVDNvS+RtX8/ds5RjpjbD3c9IOMWwIRSJLAZbfg1FZpilRXRqHk2yyk91mcgSMn2cTMHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(478600001)(6486002)(6666004)(2906002)(316002)(52116002)(36756003)(38100700002)(83380400001)(38350700002)(1076003)(2616005)(26005)(9686003)(6506007)(186003)(6512007)(86362001)(5660300002)(7416002)(41300700001)(8676002)(4326008)(66476007)(66556008)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dCEmoNoH9ip2NCCx9VBRj4TQ0/y3XvM60UZ/ygJmpZtz5PrtxqyUO/hUSkd5?=
 =?us-ascii?Q?tK925lkcxPAheFtujMpUaZfof1tB42vp0s9UWd/56o1yVzfLFfniGi1d8vHg?=
 =?us-ascii?Q?WmxTQ6guCeumPuFksawRFJgvlhB8hfnNKEpZlpzZWkSvCNS2NmbO1+M35jsh?=
 =?us-ascii?Q?6aRWGAw/7E9lbdoVgdS0eA0L3eY7/vNnp+FIPQfbwj/raLk+bMcIgzxPxJvM?=
 =?us-ascii?Q?v/+EgFP/7Sw7m3GpSn8cucq4Bj/VOOo/OltHYS4RVSJxrCqMvP08T0xyKUpm?=
 =?us-ascii?Q?ih4zY2i6XgL0unCOXr0KP3X2eaBqiS7i1Yx1EQjy5o2jXx0L/gItyQ+y8SFY?=
 =?us-ascii?Q?iKSOsOQJCATAjs/1n2HBl3DhqGeAytpyxwdjQkEeM9b/nqYNYrx4JK/tLmL2?=
 =?us-ascii?Q?NhOvaw1XCbyB+1ms+PfvvVtkR73PWe7APsdVQMwXgKJZGmKuLzbtEwEJRKtb?=
 =?us-ascii?Q?/xYjuLWW+6ViQudM2DX1P4nHs26/dEIHn9ePqLw4N68X482YkVN8Fgtv96T4?=
 =?us-ascii?Q?4VLlDkFt63M8piUirbY0Zq4X1OJ7OUN8HlLUXQaX6AGjpbFf8Ov3oW1EvEZ3?=
 =?us-ascii?Q?dn/Lhlmx/Yy3C/Q5k2O3bz0McMrjXnDqHormykes/9YEESl0mbwnqcM3TN3q?=
 =?us-ascii?Q?2dxprtzIs9qMWQynHiAAIH26wRZM+QVMCHjtOOQyAcew9eE0OgELJmWiPXTs?=
 =?us-ascii?Q?w48PlUCuDRQGNH8thU2M0z1SPmG/g/oNJeoR113VDjD6yprO56x3Bof4vpbz?=
 =?us-ascii?Q?MqUoTkgfrQTlo7c9zKrndm/eWYPJCaef1TewMG237W0biwoKkwX2K1AqfJyp?=
 =?us-ascii?Q?XnLTfVJyDY7kYQcrdyhWJnGdynUBwby+Ln2B6HPQ4JsgM9jvcPKnO9K4iKqb?=
 =?us-ascii?Q?twf/2GS2zlHOl4kCUHapORUt+z8AeE4LnrYn3xqs3dpSxoub1jWNwhXFtRc0?=
 =?us-ascii?Q?ijaH0mxQ/q2t3OaBO3JvrA+FYPyN4EXLIeW1TXBJ6K8GeL9LI9voaJwMIBPl?=
 =?us-ascii?Q?O44bVgggakI4QB+0noovxNKugvl+VgIaMyF7QvTwiVI1qNbe8SzxyZ4G9OVK?=
 =?us-ascii?Q?CCqjZg8MRwb+LbDj7T5PtwvPmD63zpbjWBjGUoiJqZtF0M0zOcei9U+GShuh?=
 =?us-ascii?Q?LYZh90QfwrN8V/UyoW+PxXR7R4KJHSzf4cIPGFvvhIQCrAsBNkdulLRC5kSe?=
 =?us-ascii?Q?ef4kHDwCHBJegbDfrlZzi4Qu5CLm403kNnsqqsK7Up2ZI/VJ4ku0E8PR6KBS?=
 =?us-ascii?Q?H/gI87J/7kMDt4Aw+3DxoNQHsP2Kq6Lx0nEkdqiQSeZpRVWyETuaIDscsD4I?=
 =?us-ascii?Q?RKMaQUkOFTQ3Ti3D3jXv6m4w8rauVFDow8NDOr3rOSRUdEMWxxQCbbyqloUc?=
 =?us-ascii?Q?c0WfCIUhfka6A7Y+sNWzzs8YIjPnGjNcdxm46Fr/cINtbX7nVjP9zE0Iz1Fa?=
 =?us-ascii?Q?2tg5M3jD1NrfLgYWXa2KuvpzxVE0bQirEbrUoY5SndH8JxXHEVrqoBUzDrX/?=
 =?us-ascii?Q?oi8wFUIOFSe3pskLcn+ZTPrRRdxaxZsFuDEWe/nef6U/GjrvUTy/xZBrj8QU?=
 =?us-ascii?Q?VIeTveMli9Xcw8VqQw1LJa6oc7qhN+KbOgXaE/Cn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1455c7f1-69a4-44b0-e246-08dae6f9649b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 04:26:43.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwSjBUjJDxxFhsVwfB3HRjengoS+3p91CvVpF5JwrW7OdClS399SQVtEjDndOKoDHW56UgAZickcVMoTP29EuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7792
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

