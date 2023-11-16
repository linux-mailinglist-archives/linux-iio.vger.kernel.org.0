Return-Path: <linux-iio+bounces-98-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155907EDBBF
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 08:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0E2280ED4
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 07:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48EA5395;
	Thu, 16 Nov 2023 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="js+JrPLE"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA83196
	for <linux-iio@vger.kernel.org>; Wed, 15 Nov 2023 23:05:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpxESFRaYIB9XvT3Bwg6NXEsp8YgZvwxemyVB52F2l+/4VEO+FRScLav6DEbzNBUsEhHsPX3mBmjtuwQfqnDpStS3o+PLi/W/hTPXJcDLhlQrPP/A+IKvTR0TML0WlODOAlVLW1fkYRAMT9abpWsI1kM/jiEPoDuCqPZ6z5I45gkrHVW2aItW+vnF4TwiQ3mb2NHOGa7hMmuxwPcKtC++YKd1WmAn93u+aL0lEgka6+FM7q5bnXJpFYVMOK2c/YMIpaIRqzB9ncGDNFjWJQJ6r6+v8NmbBBDiRQJPgrO80CGCNFufpegyQeWwSzxI3Jmj/l7Uj70bUDE4rywmLJPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlDZmxtvic3ZpEeDnXRcyEJUEsfzecD58E9b+98OPtA=;
 b=PCjdnR+SeQ66c9Be4jziCXfda9m3HoyWZekr3plOeuxgCbzS/ufJVDMNNOeWHmYOlRASy1m7X25EjGQ1n+/7BZlez4Jm7HcTJcQPLALiXboein064GKoMfIkBaoLJHRZKfwJBsm09s2e14Tsd6ugRPXZSn7EmbzmQPRX9MsdNK0Vk8rTwuHnn4te7BKGkasOIaSxjpzOrdIzXCuUeC03EHiwyRXddWjBBHgcjF9ytv9WewrHKI0g1nt4G7aN7YcSkalhoEpWpI+utmT6t7qkNXK8YLxqCVghJe8AXy9CEVzIs5WQNsWTplNVIAraKEoM5IBKBpUT39Wbr0OQLWsOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlDZmxtvic3ZpEeDnXRcyEJUEsfzecD58E9b+98OPtA=;
 b=js+JrPLEXfMaVRLaiwWvagYeG9lB10VM0KocASYyWv6KmEr2dxMNFPL/0QaRCniCow1Y89hl4Qr29Aw/8OasEspDyizNccwjGhei78VtneNTSpXNX9KiyqKCEH365Elx17/qCSmxlemb9BOa6QJqhMpFJT4JZyeiSHdXq5egQx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM8PR04MB8002.eurprd04.prod.outlook.com (2603:10a6:20b:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Thu, 16 Nov
 2023 07:05:09 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::c09:60ad:6ac5:d57f]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::c09:60ad:6ac5:d57f%4]) with mapi id 15.20.7025.007; Thu, 16 Nov 2023
 07:05:09 +0000
From: haibo.chen@nxp.com
To: jic23@kernel.org,
	lars@metafoo.de
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	haibo.chen@nxp.com,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: imx93: add four channels for imx93 adc
Date: Thu, 16 Nov 2023 15:10:26 +0800
Message-Id: <20231116071026.611269-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM8PR04MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e33bd05-11dd-4d45-4580-08dbe6725e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cD+MTKsy9aMeRT/3PZgnxKZz/Pmi4NdikTE66HZz3hUmkGuXQDpHGZQvIe5YJoN56Y1tmKFzxkrbrqi+NjPodp2thcsRHOHBsgHBAgc9QTL27oaIvd5Pp9xOVHBOsLMj4dvdzxLir15DnTAUbDQpQ2ZEEb1c3SvZZHvdvIi/HUza42zdK0jYLfRmUwJID7vvUs7zr4QPm9yR6J16Gib9lZJjl/hP1sdTxc23dVKLLrtX7ozmcTJW4PiInjcx1YEeLRxQrtdUVSe4AA75pslNFGHszrn3LAYGzuKzsC/97+V0RTnFPuIKNbSEV1GPr1ySLprwy8215dMVEouWOQnjLImPJv3f+lEbR59bbEnTwba3MKnLN4WEao86JDphH72TVmk9kYHvbCegFIFjMBPylv1xRNPMvWPLmyXaIMnhsoj2FePg2jO2wnWDTmi+1Kd+aCMu0+oSaXAxFWUQjp3m5PdXMbblKbku6/eAX7WzqZ4jiMQQSIehVjy47nwN5X1zlByQDhx/8SxZYlDDltd8mGxwAEyAwwyZOiQd3v6I22EXGV/S8uQUqPAXyfVU/cMg9syHu0niIpSwFqXcWOhedI8gSH/Y0JskM4ogJ0GOEEFDh/r/1c7AsVDUWnV0VU4i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(52116002)(66556008)(6506007)(66476007)(2906002)(5660300002)(4744005)(86362001)(41300700001)(8676002)(4326008)(8936002)(36756003)(1076003)(316002)(2616005)(6512007)(9686003)(38350700005)(66946007)(6666004)(478600001)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q1WO6rkDzi/dkcXL7VSFCnwMwi2Xocm7/H3DF5/HPIXb5FELUJig2UIg1emF?=
 =?us-ascii?Q?ID++Hbnf9BeN2WOpIteeKFYrWM6FS1AjTcAEz/NgkLo55KOMvpG6nTVlsk6d?=
 =?us-ascii?Q?1bf0tqf1VyjITgRFnAR94UVmAvH4SjoQivC/UF+UwRIMML+ELgipd6l07ibM?=
 =?us-ascii?Q?2S0QCGRPjodp2l4SkO8divN16oQD96yGJ5C/+/qmeZvuHbpH5Xtn6liMSYYc?=
 =?us-ascii?Q?6+3dso8uNCRTM/LUN/G/zYk7FgBW6E7yVUZjpLwFOroKCfEAxp3usvzZ5AyD?=
 =?us-ascii?Q?bSeUXl1EDCUuMQV9nX160qgxHow8qALAx97zP2vIGsx3SVf28mKTB0JypoRq?=
 =?us-ascii?Q?aJ+dPBQU7o3bEcsrMYqmUJ1HhyRvdEQgZPLQA1O3SrPC/oj4ZAfLyy5AYzmO?=
 =?us-ascii?Q?sM4XF/DVoXqh3+c6TQ/OQidpwy3UsmM6Z8ckgreCfKXZsKTnAFaURUh+TPtL?=
 =?us-ascii?Q?zLuyjRUoNsMHFyGDVsWN+F359YD0FKspxM1diggm6DY17EH2G8PiuhRWZKMi?=
 =?us-ascii?Q?U2QitM4rkyLxxrnz+qM/yQQiEwuVTtV9UTFlrFDvW6Mhqr/OfUbskMkATGRP?=
 =?us-ascii?Q?Q+04yz+UaL7H20WQyqhro1r9NLZHsH1bfPb4SiCJkaX14tskf+3eTq/+Ku6F?=
 =?us-ascii?Q?D8aJe84WPRcj0SnsX3sTvDWvuVBFC2IAgcqG+8AItCJpkclcimfAByAFg6MT?=
 =?us-ascii?Q?9K7KhWvR9WjLrh4gUfn3GM5ny1GSH+jeoNQVB3KCaMfR6fEhANMpl1x8kL82?=
 =?us-ascii?Q?+See/HUj7tR1EzmUQoKmj9f4e/o4RJxXJIII7f7pm5NHglxGr8ZvgQMKa9Oz?=
 =?us-ascii?Q?qv7pMdJ2aLmeqXM0HR8vYDoB2GtO75SmdcpitCtjf9URmg6c6/ezw01a3Yi1?=
 =?us-ascii?Q?+spnqQWH+ujT/QViXI21chiW0lkuYMW6oOnf0GIi5lOp8mJiFffEBmkJ4Ufs?=
 =?us-ascii?Q?hCPN1af4DegpOY30uHWhqBQ+BRL51g4CagcWM95s/tawP/C8aN8yaWN2mxOn?=
 =?us-ascii?Q?rjJIkxPYGL8FMctlxkBYd/+GuOstZrFg78XujtvAjovksHW64W0USJvYLH3h?=
 =?us-ascii?Q?Gm15FqKNub0aFI0mEuLMEGu8pANN2XMhHZrrLJ6VBe2DKq69CGSskEOILnSW?=
 =?us-ascii?Q?ekD5xKrsDSPkgkWAhVv8XAbkytLMy8XHhg/XxemqFnjaU8DyaJviuxU7U1CD?=
 =?us-ascii?Q?UEoaQLROjbsS7cCyA4KuFZrslAsaDzGmtUxshHzsRC/aNpGZQBmgjvKngBSj?=
 =?us-ascii?Q?IHyg5uoYaFJG0B3GLbLfN2hzwenu9KNaWcJAsKWHpPzB87yiiJk/XUANF+LN?=
 =?us-ascii?Q?TSptpGw8zKEUDvhDnYfLJHIn+5n+rYEsVLoaT9vKtIGxVAg/PWv/Ud0xb1vc?=
 =?us-ascii?Q?sb/GTer+eCujbmV4l1N4obQ1Jj79w83YufhXFlsf2wPUag0uSBiu9be8CsfO?=
 =?us-ascii?Q?dRCDxV7EYZB+4GPXameSWwbk59gB8dDr6R26MN3F5M4h2+sZh96XB4DueDYV?=
 =?us-ascii?Q?57sBXFazS+HdVsADvcNQAsyu6A8UpGalv18B5nphF5jLG8uj/Dw5CcRogZA0?=
 =?us-ascii?Q?MF0zz/rdVdSk8Gl3AxztLcApw7tlCCkapYMW3Z6I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e33bd05-11dd-4d45-4580-08dbe6725e66
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 07:05:09.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvaqqU7ZlTjVB+vlc0CEOm2bbjq8wR8R4PLsJJTMztkXR2dzONFg9tn9RBzUrCG2mQDQ9puPoKyu979gVUyFRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8002

From: Haibo Chen <haibo.chen@nxp.com>

According to the spec, this ADC totally support 8 channels.
i.MX93 contain this ADC with 4 channels connected to pins in
the package. i.MX95 contain this ADC with 8 channels connected
to pins in the package.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/adc/imx93_adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 9bb1e4ba1aee..4ccf4819f1f1 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -93,6 +93,10 @@ static const struct iio_chan_spec imx93_adc_iio_channels[] = {
 	IMX93_ADC_CHAN(1),
 	IMX93_ADC_CHAN(2),
 	IMX93_ADC_CHAN(3),
+	IMX93_ADC_CHAN(4),
+	IMX93_ADC_CHAN(5),
+	IMX93_ADC_CHAN(6),
+	IMX93_ADC_CHAN(7),
 };
 
 static void imx93_adc_power_down(struct imx93_adc *adc)
-- 
2.34.1


