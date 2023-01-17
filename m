Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE93266DF6B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 14:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAQNw4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 08:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjAQNwf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 08:52:35 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459E33E618;
        Tue, 17 Jan 2023 05:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTbiGrShRfxpNFFdsYjIH6pu1QX5+rIFL+aM7XGBZI7zIHK4gMNtu34H5TLHvHPXqoZqO7C25ImqJSjc+fDptMpESA3en+Vqp8olxhWibnTCLaY4UKQlm5Ux5og3MLHlrBjgNRMg4/gM4yOottMDz8IcxXvVspeP0oBSXTZLVc4JJro6fED0C8kI80AJBqEhPp2u701J2LkbQOoqX9qOrsZQvYXRxS/MBpx42Lh8rd0FVzO1kkhK/3DKss4XCgOi8G9d2Fs+NFiPiWjPwN5jpZgTtysCWlFmas3R1vyYw6JAsDsXaOA7yQdYK2ROk2UrMeW3TuNGNT5EbLJJtx7KDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iglVQhnjgs0Hblt8fIhOEi7pA7rPjPnQz7K4ysdezOE=;
 b=g5l97PscjkVSUhIa8pjXo/FQ34MCufcSyOSSk4jjZWWGUo/hNqk0wiqYw2f8IWn46L5OYVNP0uA3HN+jeHP0exBJN4TqL6SXR6tWnfd3kab8E56koypjZATkz7EP3zJcvQH/XGVCuc/zdMP35HJ/eiKAxQcHJLQiZjqEs1ktgoNNV4i/i/eappoNegJmvzUkmntsheWFkYnmC1meJlLUyDy4JHl0Ljw5n9pNfGrj36l2CmyN4I3gTJqzX0P33eLv/DcW9qllS59sotANKGjUoYkyS6dHdIE/MYBfWQZjoBwIVf3fh+vAYuqo27H20Xd4gIIlyP5VfKfqaOoELuwX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iglVQhnjgs0Hblt8fIhOEi7pA7rPjPnQz7K4ysdezOE=;
 b=ZaXL/jpmVGr2rXY45npCW78GrlAbw5opBXo3yIV6FsRuVYbM4nZMxLRcO2hXoyEPvX96H1lmFEDsgesJHfa9YubD9Yx/mFt7XDC7uuEUnjY4ys3qHyh5LJ2U6Ko9FWPlsWRVlAPXk2VdkehblrN6q3ADstaEiI19H/SNsAHgoNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 13:51:14 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 13:51:14 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        haibo.chen@nxp.com
Subject: [PATCH v6 0/3] add imx93 adc support
Date:   Tue, 17 Jan 2023 21:51:34 +0800
Message-Id: <20230117135137.1735536-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|VI1PR04MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 8118ab13-0983-4a11-a728-08daf891e5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Lgc7I+KoFSCdmH8XuqO8RBdaE5KJ284x0AiKzmcB+p1rjpBXsmGPWd1CGnlo6qaRq00tf5HJhFch50WHr/CHx2ZPeIMr95XTLhnOt/36RRAtHoAeyWlLMc3TOSOUjmtEEMgKz53UxnM4eYd8JjTb4wvUstm6wFzb1UOfNrYG0quJgAEAKD4/aKOIlhfoExkZIuc9KhsnxjZub2gKhvUYy0v6yoGKAMlvvzWZoGN0Z3sSzCFS+pV29hCs7/70h4KYvHsPC84zDcwW5cldWdpTAKiP67CN6RsGERIqD2hWn8oYa10vaMRcjivV7vFc65LDCJPu4/5tbTZi2qAYkApZxjRpnT4dEE9FAUaxoDsH+To/l+F1vcNOkLS+CWDDAZ9wUdv32KF1HH5too3QIyCh534e870+3e1gV1Yuf83cl2pTV4xXcX2GMZWHIojMdUjFiM5N1N0cOlxLNnkPisbjMihPvzs58+SVdCC7RbW+xQUZLcX4O29dWIVBR3yKgP0LBSI/77vwUadgy0uwC/mGwfy2j50O8PuccMqP8mBZ8BaHzmdIHgHe4VJ6O1oNWcLPo/bKqIjRRxqZ4yNEdQpXsvK00qNU9FY/6VI9+Hr/Meb78z3gqxZE8bhqpSjYdIPnm3q5AW2c7KxAmsQ6kibjNJ/KErxpodIwZBwYvUDfvD8XFPIJIOwkBxhbZADbH2L7a0I776CyTBi7gjU8fZDqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(36756003)(86362001)(66946007)(66556008)(8936002)(8676002)(66476007)(7416002)(2906002)(4326008)(38100700002)(83380400001)(5660300002)(38350700002)(316002)(6666004)(6486002)(52116002)(41300700001)(478600001)(2616005)(6512007)(1076003)(9686003)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6hotdZs9+dJMOCD8aB9auEquJ8Li+92WXy1rKxvOo+5UCMy33c9CJqOl2vi?=
 =?us-ascii?Q?BNqlpq49BRNmnMp30RsXXa3xCnYjhKoAWTKeZn8ckjkY9ZGeE1hc3GZD1obx?=
 =?us-ascii?Q?T5jAiAsOZ5Nn0KtaxR6E+WJ1SXe2ELuEBYiuEINJZHzlFV5JIPkWASPoVlnf?=
 =?us-ascii?Q?wgdfGEwoziXG/flVBUGiCx1NfTwMtmy9XRpNZ3dqKmVuvoxJidz6kPhTJ6kN?=
 =?us-ascii?Q?ygmLb91GnoTgTsDs7kVmR+fkBdR8hIGLYJVJUTTreqUPQGnkMf8+6wRY1xeU?=
 =?us-ascii?Q?6e/zRUVRNX3RAz7LFH6uJDB8xoA+EvWC+gWR5gKA5krQNBZ84o40ufUS1PJ5?=
 =?us-ascii?Q?5ax7g6sUVWQ7ts2gFXm5sRL7ZB5XGZBtQ7aqMCafj8hbXiDtZ/oTgTYaY5Aa?=
 =?us-ascii?Q?Pi3ykaX1ibUJkTEGIGLQSmRkszn3CIJC5bIP3T/+BNvYnGE2OIGXaXaMgYHJ?=
 =?us-ascii?Q?jAD7BgfZzldZzHLVgpfn4tX47qI0qvc1hAcnZN5Fb7EgzVTA8PdjezcLxEVi?=
 =?us-ascii?Q?WwhlrUuRHNt1GOx31GDZpHxhYBbpgvOJY4JUlHu5HjMWv84AJxzL3htNtI6v?=
 =?us-ascii?Q?LeR9DS+QrFZy3dZym+Vu//5FTyixepvcPJUcAszon2vOELgURXQqVup7Ea5C?=
 =?us-ascii?Q?HRz96ta9a9Kqq5sKgtNVRG3V7O+HDwf3u6qLjuExXxOromLi3QloJZ28WQcc?=
 =?us-ascii?Q?0hiHWMdk/oqGXKObqcRrSso7QjbSti7e9Z0gGKIu2gfevfjXI1r8Df5AEoSW?=
 =?us-ascii?Q?X5Tz2mNVm3UqqNEuQxG/e3YR8lJJdrdUHPEt1fy1O/VrYdFe7FTFvkuaPqwl?=
 =?us-ascii?Q?g/5cyCO60Cj3GQwEIbo19d0l6TfE6i6c4rvn+z7O0cG5lrVcbxrPNy4cMXSI?=
 =?us-ascii?Q?4mOq5uhcs90sLLL7XyUKtTPA7PXumtm3OHr6pQF2be5YNJTg3Plyk3eg1oA3?=
 =?us-ascii?Q?01FkIVCHiri6V1s1tMlH6L/OGBSqV7KUcbnCVjOLOljWW7r7LegZPdq5nXz/?=
 =?us-ascii?Q?YwlcTLb3jpwLeyj6tx1O9acpxaE6/mhUHY3fA864uUOR/7b7sgzWriQX4HB3?=
 =?us-ascii?Q?hzNlLN8GGkBLDcAPkOT4qFPEIVKPIbJGozY7ZZ6Oeyc38VBSpQyd7vJLk9yS?=
 =?us-ascii?Q?POfK7OCZ1qIOWpJof5RyIHFzC73o0bYL3gmYgBjJWr3YSzK4xOX0QTnAqhxZ?=
 =?us-ascii?Q?EE6V1ZI6GiHoor/tvBfjcV4Q5JQaEwjQT+dGY9OtG2rsEfg2fwkYsc4KhllA?=
 =?us-ascii?Q?2naNn0F+y3ukBosZkW8Rhm+mliJF9Hl/FySMTtvQoJ2s7uX9sQTOWmaO5nWN?=
 =?us-ascii?Q?Nn0wQHse7GE7HAc6GczWq+IqacRpGQiTjAUOCdDdZmpuY+MuDDIUYfMv3H+2?=
 =?us-ascii?Q?zwClAc3KTns5EshQjS3ec5hEvqU1wYYKo7sI2QITE+h8DIa3HtU6uwTSaMlE?=
 =?us-ascii?Q?6pzsY5wbdg0l8T5lQZ62G2E4q6bNwmJhhwVrNzcekDIrjunN8ylmQpr3JTae?=
 =?us-ascii?Q?NIUWCOYoSZPkvoulxBsMxmnsf7MAGmzicpJy9gkXJ/SMLI0HDmrL54nfEOGP?=
 =?us-ascii?Q?M1zkmxYSFK8IsFS0fLyB48PM9jGkhh6xaHV4iB+H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8118ab13-0983-4a11-a728-08daf891e5d0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:51:13.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/n1IO/DHmESaV9DYYb3UpMghDHh5dt2WGlEY04hOytyZFy2moMK6DRf5uM+TO/gQjXmlsIgBO+MAaYKvrZwdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909
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

V6:
  -Change the Copyright to 2023
  -Power down the ADC if imx93_adc_calibration() if meet issue.
  -Add new error label in probe (error_adc_power_down)
  -Add back the pm_runtime_get_sync(dev) in imx93_adc_remove().
   Though in imx93_adc_remove(), already in pm runtime resume due to the useage
   of autosuspend logic. But call this pm_runtime_get_sync(dev) will make the
   code logic more clear and will make the runtime pm counter balance after
   pm_runtime_put_noidle(dev).

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
 drivers/iio/adc/imx93_adc.c                   | 484 ++++++++++++++++++
 7 files changed, 604 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
 create mode 100644 drivers/iio/adc/imx93_adc.c

-- 
2.34.1

