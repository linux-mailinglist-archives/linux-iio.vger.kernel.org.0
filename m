Return-Path: <linux-iio+bounces-21803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBFDB0BEDE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 10:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED8E7AE64D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 08:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9366286D76;
	Mon, 21 Jul 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FTrH5P6k"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575522D781;
	Mon, 21 Jul 2025 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086511; cv=fail; b=C9uf05D6yyGEUtLrIgSxntIW5shusace2hIL1ySmS5iOxKPVjN8RsvfZQAueB4JzkVOGiNghHZ1GAQAJovd6/1vvyYpQXq8dfXIIonxcGcjTbzTOPZZPFjYgZaH7TksVtynyXHcxcGv9guxGGeYasT4IxCav0gOaa/X5OP5G8OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086511; c=relaxed/simple;
	bh=i8ERWSW/Inj2+1vK2eKUHhBP7L2JByKmTS8RyQl1jCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kvWP7Q/6bvOQ3HuluEKSZo0h7Q35apsBW/3sbxNtZI9KmMEiiKKO9WDdVruLYOUt2NgGIB4uJkgElMBFUO2Tdt0wO+6/JJyXsSXN1P7BGS3SnbpujohsKWaxh3Qtt1kmZnjfaSZJwYJVWnYhYMZWaDmMwMFUmb1Z5tpOlD71hRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FTrH5P6k; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohgh7Q0pvfpgcdGQS3MGgcQWdLi9PIkTjau6DdwV5weI5AQ+ctkiuvZwhupqHWVUaV/Bcx1g5csGk46fYRIbQ63Pb4fVTPqTPQuLxf+GP5Z+qPAPZ0e0KasTOoTSKcAxb3n27S8ufX7mC+QOBPb7KYqhGFTN2KgnJw1/6/uIpAGPnh17iqXg4qGeFkiLfAbS3l3pRls43D5Ua4Ta164+JHSQjXKwrwWc4AXbONH93/T+1SrcZe+xRa3FhOQrwOBcUyi3IQZxGmNMalEAQHjr0pg3E5YZihySeDZM7sTcxQ7epJaU7MQG0yPnj4FxuvbJaEMb6tEtvAdXSPAyoMlopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aKYTQbJeRwRbj2XwXDu5ME4LH4cwtNUiU/LcJqe4Tg=;
 b=lqrlPdsTiiDpk17jBSQew9g7oY33+o7oO4KBmB8rpXZL16wTvQVgr1M4HhazUqA7W7Gnq9rPl1Vy0esFLnMLR5W35fObRJlbFJbD3WjIPqNPam1yjhps24wpop3YK4go1hSR6qQv5BQwAQ3KEEP5gdZHUx1FRgR41rsXbX9NxbS8naCoXr6mbCLKpBJXE4rDqv0zNbTXnvdxl2y91vniGWXEmaMyXYTNmZEm07DTPni4AdCEAkciWosebIj3svpdOz/sGHeZu6bz1uoWONPO2xOkX8VGDDt+6prJjdJRyRTaBS/LFU+AM3wDGqlYgoTTCYwFHpF8fBj13HMv/jAiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aKYTQbJeRwRbj2XwXDu5ME4LH4cwtNUiU/LcJqe4Tg=;
 b=FTrH5P6kxA0rximsdGYaNlDcH+7357K8TxHIAZCYDtjOfLAk7lyqazh6Z5yivJez6SByKP0ZlJQYdr77LqULppnjZmkjS6Lbo3OpptTc6uCPSD/5FcRjcNDpEixUvqtInDgA7fFhhcrW4uO6dpzSlfSRw/jRNJ84EZ7nUlr9notEFJJ2JVfMnIEDIkfq+VsBtmB6TXLmQrSkwgbFI0/icjZdMlPxZYXDKhAL2xUyvS+w4w51+XGxtpRPO/gY3bEUq8qBZIlg/BTKA1Kgi/A7tZS0KsuUXyU5N1O84jqX19y0t4KH5sdl0JbLXYUxOjckVv57hIpwH5ZQn7/poZPxWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9785.eurprd04.prod.outlook.com (2603:10a6:800:1dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 08:28:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 08:28:23 +0000
Date: Mon, 21 Jul 2025 17:38:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Nuno S? <noname.nuno@gmail.com>
Cc: Primoz Fiser <primoz.fiser@norik.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Haibo Chen <haibo.chen@nxp.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de, andrej.picej@norik.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
Message-ID: <20250721093847.GD4844@nxa18884-linux.ap.freescale.net>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-2-primoz.fiser@norik.com>
 <2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
 <20250713160247.0f22bbfe@jic23-huawei>
 <de2c8e15-14e9-4c61-9a13-97ef1ec567a4@norik.com>
 <6b32118a13e9e28b7cf12152af33642c76367c34.camel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b32118a13e9e28b7cf12152af33642c76367c34.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: 800445a1-c1b7-4f19-4186-08ddc8308e2b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6B97/ThTP23pmRur/5EI5AjHKYZ+pzZAJoduEF4UvymWcPK2BbELFJCRcGwp?=
 =?us-ascii?Q?xevHqBWx9sQaqRhHJJplVzhXpnk5Px+NpgG0LVFN71Jx4+/Rc+hiNdCT6uuW?=
 =?us-ascii?Q?qeS4RE1S9tQ8fxRrYlLADw7vHs0cvCdaoKOn4pciyojWsYkbUC7qAf2SOf0c?=
 =?us-ascii?Q?zdp++HgxN/b9SDSaFEuGKi9dhGRI/oxMPd946EuKn1tjSMq9Z1xBp2JUBPwD?=
 =?us-ascii?Q?6MuhHekXcHbwDOdJv2hJfiYDPsZ1xsAKHbxhqIDnyT7A8rZr5UVWpmxfWoPg?=
 =?us-ascii?Q?h7DSy4vzNp4DIL3q8MaMkKHYIIH+D2Ux4QMVf5xfVEJuDglObg5yjkHUvLO0?=
 =?us-ascii?Q?ewq+5G44xVEogEBTCLGVztDFtJN2O7C6hYyvEgM/3dHKKmr027Mqj/176adB?=
 =?us-ascii?Q?DCKuyLthttyQee9+5Uav0ZSbvRHYWKmA+jrilUyxirqKwrXHh+csymHsTuMT?=
 =?us-ascii?Q?Jy/nZTr39FsiLg+xoZoIpb7Ji5aqL2rEUQtBei/TYPwgXEOp+WviOGzMwUTF?=
 =?us-ascii?Q?uk8uBcB7sienQlZ7xuJDXhKU3DEzqy5ynStkA2Xfpe/nz+DWAa5jRJLeNBMd?=
 =?us-ascii?Q?pKqhoiw/+cTyLtnsWr5GFVwqK/jpoX+wobiEy4XSQZOdykvNdAaJO2y1pIpl?=
 =?us-ascii?Q?qsfZ69xi7HtIeP6+8nXfkj80nmGRbbuXNbFFNbzPudFXbKmrCu5kXCFS0Kiy?=
 =?us-ascii?Q?iQ3oPqaVohLm+ftTyon4M+mZdXfg95oYEUtHdyZQFINgD+7SHUDHP2Ahot8X?=
 =?us-ascii?Q?jkpJwnlVTYRqcOOx87iDxstK5Q28S4X0qaCtNMv1wZcJH46A8aVDBg0p67Q7?=
 =?us-ascii?Q?pfpDwJofSwKbFbCT6q29am/XPZoziCRPiBP8g9w+LxNkWukAAdbzQnDkgMa+?=
 =?us-ascii?Q?o33aFFq0Az2vmxNhtUFRPqIF0eQ612EEm45rQNWrOFieowPyjcxTEFcaMrwC?=
 =?us-ascii?Q?/orPvZnMUjb13Z1WMImFTtNkK5IXPWWcmfdpcRvux3fJHjhjyZ5Eq5uEOZj9?=
 =?us-ascii?Q?bszoMB/sIdQQwT6Wb37HDcR8zDDdQwyymgglplg5YJdVAIXiUtg5tfEb9dWW?=
 =?us-ascii?Q?cTm3LnZDZB3YhdGeIsGrRE6Cl7bHclj0Q3DLFpeTU3focRQrGz2+W4VNn+F5?=
 =?us-ascii?Q?sMA4sKJIx1gjAp6y6md80nBChZz+Nco2+jMCOCZUk9dzymmwKknJ6xvHZy9L?=
 =?us-ascii?Q?HmzFmSTx89KnZ+x5QNNcwCCDcs2jD3R0HJNR6PPOv8/RrXOdM1wqnrKBPFfZ?=
 =?us-ascii?Q?wMfajB9ygElGjXoNXitdDoYxl/1DTAwOqguZUMHR6i0x6jCH27j4w3eP2NnA?=
 =?us-ascii?Q?205tVZSthBr1GK8lIJsaWpOR51IRtiAA79QrQZNFs77rVoVGHw59CMyQeqt2?=
 =?us-ascii?Q?V5ZfOoWJmzToTS7HIN6j4CvH4QgkGCV6Mz4wk75kloX19t1mDQwf21hsq96w?=
 =?us-ascii?Q?35qnH/ZwiIHM1EZiN+hygn6uxx1KV+MGI5E0Vgav6zJkIPR6DTOvAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?plbTWOL90H7xnxdTYKs04wuBxGwq2VWFd0EZPVL+YR8ldQOOtOXw1d6d4p3x?=
 =?us-ascii?Q?PtvjcT+jqsQ3cvMyl3qPjhZAnQVvEYaby0GiaygdwcfcUKJk6bOgGCVQrj2q?=
 =?us-ascii?Q?m+/gkfO2gtj90idFjKebZvuHZPDQ/5HpWK5ADlo/nLSio4YtADcNVhtQLRmE?=
 =?us-ascii?Q?CQokNoG7mdSFc4s6dxODf+EQiRMmywLFExizH7ObJjlDUsBHiW3qqI0ATf1Q?=
 =?us-ascii?Q?n4lIRFBRSBGCUC19DbtdQiAcsDT8daPwMNNqfaTIY5wWr7V4OE0pnpITIEnL?=
 =?us-ascii?Q?leZSvVYTOC9MKRUB1kEreoP5umpJlhPtPkU0jg0qRE8a6ckk3a2aosoai2sc?=
 =?us-ascii?Q?Oyw+bbRXnSWmh+Yg1CB1rqUlu+tQWip237YlwUIbm8sfMCUq7Pvajp0g6c9z?=
 =?us-ascii?Q?jkoN0Wv4oRiSV8gYeK2pkkJ6C/+hgqmTl3e4clfhYZbz7Jej5S1VpKp2LTX8?=
 =?us-ascii?Q?67lt73PqKKA5Smdd/zsNkTj8Mh5I3T7vGzEZWRDtu6dA8UBqF+3tvJxKmp+U?=
 =?us-ascii?Q?N5lbjH5lOBR4yUzB7f8ILjd1hW1dgaKec59/CVFBcT0UnS4KKJxRDMBx8uEo?=
 =?us-ascii?Q?gdlZ62FwTVboHI4lb8L3Wp+BIA8aTTKe/g2nxXth/eW0AbFhGYvfiB1Gsxhe?=
 =?us-ascii?Q?ozTmxqQKkQLLM0QUWAFtTKuZRXr7RRoKQe/VNVdV1hwUYVYCKIYM3k6dBRYk?=
 =?us-ascii?Q?euZ7k14W2Nt28wPKXgjh8MyhkTUsIMguzDodwZTxyBJhPssIeInUyr6idwl1?=
 =?us-ascii?Q?5k2IRPED7THyorEw86+Fbz6nKvuvlO8e8TMHgmJLO+cO1WS2QgR2JtYYzVWu?=
 =?us-ascii?Q?FUhhuZSGVrGfuBoI5+kMyweMAPx5hPmS4i2Gwb5dZfqpNMfYJHElAnFzULX0?=
 =?us-ascii?Q?cP34rvND05gOLNUrQqEXwXrQaa5LldceDSy9OTTLJy7U+vgVUHnJrCjJhMLc?=
 =?us-ascii?Q?SX5/mBOAE07aEcyBd6YrpHA/unWN7VGUw0FZjH2i5C2s+RJ8xpfG0aMFtQOC?=
 =?us-ascii?Q?Zkt7Yj0k/4yK2Y9F8SWoPAzSKQdB5evPNtc0Cb7ARBG5Lzm25lQ2tu/Djg6C?=
 =?us-ascii?Q?lcOC8jROF+1tWeSB9DGfv2m6igshkbRvI0wpzMP8uoOoWcp9fC6i5ockjlwZ?=
 =?us-ascii?Q?/ZfWTVg/H55/4elvVeV4201fbFuj20GP3k/vyf2XrvPfcPc8zcP53qQa1OTJ?=
 =?us-ascii?Q?UiDH9QvBVRT9aRq5LBycsRvMdPW06wdIZTItaulJ3I/Y90Nz0O6TvxCnghQm?=
 =?us-ascii?Q?4x4+uem/PtBd9exPrOtJEBOZUb3e8zs6YZh4i52nFCsasupiLU8tV40DBfjL?=
 =?us-ascii?Q?ul4tZWm090mJfGnrh0fjFgS2YhNQtjMM6Nsrrs9B9CjC2+9MIAIsvguG1N45?=
 =?us-ascii?Q?kzQI/8ki0VMM0n/YZ5n0QoSkmeB8ziD/5KGDCBwsqav5G1FJjDTHm4jTRXdw?=
 =?us-ascii?Q?cjAFlt2uSh8LHRg2JeI6NnCMAW9ysGTeZnUWNqaCIHq5Q7mqRqOatQQMG2nH?=
 =?us-ascii?Q?wR64SqOa8PY3DIsXs2RFwtBDRC1oDPFY8MOmcmztiJBRjSIHK2ZvBtD/FLO0?=
 =?us-ascii?Q?uFBThzz6pGc1KqGFTSfmQceJHaGpoVD4aIVUjKEn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800445a1-c1b7-4f19-4186-08ddc8308e2b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 08:28:22.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKGyFjIJ3aIo+Mg/GJy2W3L5ULQPBI3QE7SEMjv3suynKOGDe/KHCO0zrePenCJ560tWp4akUf91SoZnaLtIrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9785

On Mon, Jul 14, 2025 at 05:11:31PM +0100, Nuno S? wrote:
>On Mon, 2025-07-14 at 07:56 +0200, Primoz Fiser wrote:
>> Hi all,
>> 
>> On 13. 07. 25 17:02, Jonathan Cameron wrote:
>> > On Thu, 10 Jul 2025 10:46:44 -0500
>> > David Lechner <dlechner@baylibre.com> wrote:
>> > 
>> > > On 7/10/25 2:39 AM, Primoz Fiser wrote:
>> > > > From: Andrej Picej <andrej.picej@norik.com>
>> > > > 
>> > > > Document i.MX93 ADC calibration properties and how to set them.
>> > > > 
>> > > > Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> > > > Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>> > > > ---
>> > > > ??.../bindings/iio/adc/nxp,imx93-adc.yaml???????????? | 21 +++++++++++++++++++
>> > > > ??1 file changed, 21 insertions(+)
>> > > > 
>> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-
>> > > > adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>> > > > index c2e5ff418920..d1c04cf85fe6 100644
>> > > > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>> > > > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>> > > > @@ -52,6 +52,27 @@ properties:
>> > > > ???? "#io-channel-cells":
>> > > > ???????? const: 1
>> > > > ??
>> > > > +?? nxp,calib-avg-en:
>> > > > +?????? default: 1
>> > > > +?????? description:
>> > > > +?????????? Enable or disable calibration averaging function (AVGEN).
>> > > > +?????? $ref: /schemas/types.yaml#/definitions/uint32
>> > > > +?????? enum: [ 0, 1 ]
>> > > > +
>> > > > +?? nxp,calib-nr-samples:
>> > > > +?????? default: 512
>> > > > +?????? description:
>> > > > +?????????? Selects number of samples (NRSMPL) to be used during calibration.
>> > > > +?????? $ref: /schemas/types.yaml#/definitions/uint32
>> > > > +?????? enum: [ 16, 32, 128, 512 ]
>> > 
>> > Allow 1 as a value and drop the enabled above.???? Averaging over 1 sample
>> > is same as no averaging and gives simpler binding.
>> > 
>> > > > +
>> > > > +?? nxp,calib-t-sample:
>> > > > +?????? default: 22
>> > > > +?????? description:
>> > > > +?????????? Selects sample time (TSAMP) of calibration conversions in ADC
>> > > > clock cycles
>> > > > +?????? $ref: /schemas/types.yaml#/definitions/uint32
>> > > > +?????? enum: [ 8, 16, 22, 32 ]
>> > > > +
>> > > > ??required:
>> > > > ???? - compatible
>> > > > ???? - reg?? 
>> > > 
>> > > This seem like things that should be set at runtime rather than
>> > > in the devicetree. Unless there is some justification on why
>> > > these values depend on how the chip is wired up?
>> 
>> It depends how ADC 1.8V Vref is wired up, especially how noisy it is.
>> 
>> > 
>> > Further to that, I'd like to see some explanation of why we care
>> > to change it at all. Is it ever a bad idea to enable averaging and
>> > pick a large number of samples for calibration?
>> 
>> This is a snippet from the i.MX93 TRM, chapter Analog-to-Digital
>> Converter (SAR_ADC) describing calibration steps:
>> 
>> 1. Wait for deassertion of functional reset.
>> 2. Configure SAR controller operating clock (MCR[ADCLKSE] = 0).
>> 3. Bring ADC out of Power-down state (MCR[PWDN] = 0).
>> 4. Configure desired calibration settings (default values kept for
>> highest accuracy maximum time).
>> ??? MCR[TSAMP]: Sample time for calibration conversion
>> ??? MCR[NRSMPL]: Number of samples in averaging
>> ??? MCR[AVGEN]: Averaging function enable in calibration
>> 5. Run calibration by writing a one to MCR[CALSTART].
>> 6. Check calibration run status in MSR[CALBUSY]???wait until MSR[CALBUSY]
>> = 0; alternatively, MSR[ADCSTAT] can be
>> used to check status.
>> 7. Check calibration pass/fail status in MSR[CALFAIL] field. If
>> MSR[CALFAIL] = 1 then calibration failed. Detailed status
>> can be checked in CALSTAT.
>> 
>> 
>> See point 4).
>> 
>> Not sure why would there be an option to configure i.MX93 ADC
>> calibration parameters if one use-case (max accuracy max time) to rule
>> them all?
>> 
>
>Sometimes HW guys just want to give you some options. Does not mean we have to
>use them all :).
>
>I guess what Jonathan is interested in, is to understand in what conditions the
>defaults are no good for the calibration? If we can have a set of values that
>should pretty much always work, no need to further complicate the bindings or
>the driver.

Just my understanding, it is hard to use one fixed settings to fit all
kinds of conditions.

                 Noise induced from PCB tracks  Electro- magnetic noise
		     |                           |
		     V                           V
 ---------
|SOC(ADC)|   <---------------------------------<- (~) external Signal
 ---------
                 ^                 ^
                 |                 |
             I/O coupled noise    Internal noise


So OEM A's board may needs different settings compared with OEM B's board.

Regards,
Peng

>
>- Nuno S?? 
>> On the other hand, public TRM doesn't give much more information and
>> > 

