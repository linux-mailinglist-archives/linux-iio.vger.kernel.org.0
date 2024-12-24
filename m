Return-Path: <linux-iio+bounces-13766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFDD9FB9B3
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 07:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83B61884D74
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 06:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4915098F;
	Tue, 24 Dec 2024 06:14:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021142.outbound.protection.outlook.com [40.107.51.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE4219FF;
	Tue, 24 Dec 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735020848; cv=fail; b=Uy/mmDwpMMLaWU/MFiIlpWEp+4+3nKzlFJyGz/Mdq1AA+wdvKG0GIAyHz+4mWYTlf8YHBtlwnisKR65fenMcTGC8h97/liGZkerqiQ06fDrzk+zgB3svKiYikRXjmQCXjFkpzbOuLu6IT7o42p5LjqzNnsFIICbrtJ+X2NwzKhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735020848; c=relaxed/simple;
	bh=XTjJdc1ptLtB9jv2Xckipe0kSB7QDNnS8L0eQEhCJ3s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MNsW9iM2YATNHJo70tSqvmCyw0jcf4luzMiD1kvWemd9CCZpc4023uVuHQZ7jKoH8Fhz5CVf/Ca1dc/fpqhQjmXOerxdResMmGUazViwd24rijw4kNy0OwE3g+jFwbNetKys4ITyyMRFwSf5KYt5nAJigI5BZpQdlheE/W7F4lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcI8SRilYokvqcJ9Rwe5KXUS1k3DFgDYpgjEuOnoPnDDW3QHf/zK1m8/TZ03RVZjQg6qxivtBhwFNOxpUL+olwCkQoe4l8pTrut0/X8qYyyM/4sfx5MS8b6ioh2ibzebPvAnv+GM6EaUmi3ezxowbvarG+D4gDL+TNNhaKOowwyn36RZv0QgnXDuD2gH/yBMxjun9lx5XmAlmGu2e85g1FCIahRBs3Wh+C1dsDnwznxCl7M8vypFIvcBArjZWBNbncD5tAekI8r0Wqx8/aavlYgHhhK++KoO6YdM08CHsVAPDyFiPiZtkgYCjNckJYzBpKqkYJqIcBVo4OoiIYx3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOe8CPTP6iR/bdtqP3UXjksym6Xg/gEJzczJw7jD0ik=;
 b=ic7HjMNg628TM/dHGWXIGb0fEz/ET5HVS4XryxExpaTU8cWAsObNHPiTqbrACVJABG0FQ/d2XdkKzG3vDkeB1WruMAFcgRPWGHsUsPsrnFrbGpkHRvqdkqzTXfxxGA98/7ebqT328pjVGgo8mw1/JXfQIQLmcUusnIx7H7HyuwErxQW3FQT4tgSWbYuPoeD5q5MlR/NZgEFEidKcvM6C9GVXlceebVrQNkYyPgIslvDAzrpoIwpJwP9ZAbwBGW5AbzPIAhFiaT1CWKjoqUgBlM2zEvV3n6ivchBlVVGWxvR9h2hVLwlhxCzClPWamwtTOy2ZtTmTmdJSI9g9vjBv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by MA0P287MB0331.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 06:14:01 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%4]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 06:14:01 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: jic23@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Julien Stephan <jstephan@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andreas Dannenberg <dannenberg@ti.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: light: opt3001: Add Support for OPT3004 Light Sensor
Date: Tue, 24 Dec 2024 11:43:14 +0530
Message-Id: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::9) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|MA0P287MB0331:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c2d948-1ac9-44fe-13ba-08dd23e22899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OORHjomq/TkwE48DqYQcRRQHXbzYBeloyUrOhRb3mAZqotlvl245ZBwWjObE?=
 =?us-ascii?Q?A8mGGaaH9SkszYde7z9CwRhzURbwBF+oRUoVnXQAhT2mqnupUv5vbmkI2GGD?=
 =?us-ascii?Q?dAkdvj6iuy2Ge9SHgt8GQJU0wMuoefMTYIe//Y3pt05IHv0MHYU34q0K3ssY?=
 =?us-ascii?Q?ZKxCEPpsJW08Z3hmc93J/uJuNvZecJF8oWue5P5VkMCOkFv6jEUNuz0XEma/?=
 =?us-ascii?Q?zfgQYRK1vJo8ZjmJzE/39Mgs1EdY728A3jLRJiKaoE/OWy4HcB7MpWkrX83V?=
 =?us-ascii?Q?EUrUXVFmp2GuzDqib4OyTsTJDRG7PpIu++1y96NjVeSnEXgzSippFSPuGvqe?=
 =?us-ascii?Q?x5fkn3ZhtdxRUKbcXsA9C2aBdw8G720dg2cfiEwm++U7DtB+mBIt6JnD/FwZ?=
 =?us-ascii?Q?85nivuLUQ4y5Ox+rGasgltSzD+pliSrcTNQL6KaVWxh2LejpdAINNpG8DuKu?=
 =?us-ascii?Q?59zwQuwl7CYQoo65thiKc9cO/v3BGM7Kj5sFmpCVzvW7EJYrgf3Rv0++51NA?=
 =?us-ascii?Q?wU5NV7iYSkMTW5Mm3i7PjzCPwmJDLFia7D6Cl/EW77zgzIT1M5tpjHQ/kUCm?=
 =?us-ascii?Q?wHBIR6HauqqMrYwJxclrjL6Q86ZmKFlJhLDZxPvtChCQGYMMxmrAfcL+2UbR?=
 =?us-ascii?Q?jsU2xkQAWIb6rWkDn+A7TlsurY6p+j0fsFM9N+se9IyJS1V1h5fV+Yrxztm6?=
 =?us-ascii?Q?Ko0vpObKUxwKLLXEgDl4G3SZ7MzfUBgDJNf31g3wUq03+EpzJhQdc+CDunMr?=
 =?us-ascii?Q?JhXcndVnn4ocTfCtvRF3l+dcaTCQqWYhjETfLFCaSqnY0FWtBkTfbULpvS+X?=
 =?us-ascii?Q?J9TLKuN4GWqojoaeAWbfeVzZbuHhRkC0T8FSKaKx/cmjjldMIjVbZZhKncKP?=
 =?us-ascii?Q?CQN771vu/oXDBio6U3yBEK6CgwXEvtpSJKOvVSKIZk8BOVWU7LigJ+ulFU+W?=
 =?us-ascii?Q?C7XIPoofem5EnVRBpRbPfjw6Ld85UOGoB8fHydqVPYyxn2SxDvGbSXx6Yp8k?=
 =?us-ascii?Q?ieFuGtZ6rPmvFf0bgzzzrxKeqyTVVVBzBsYYF9HNti8GG/sHLKlZ38jxHeL1?=
 =?us-ascii?Q?eUpANtR8tyOQxKU1S7aAkCBxsH7PJyulQG7m5iGgU62pQuS8+ZyZIwZsCp2j?=
 =?us-ascii?Q?b9aW7YsuOf7a3obBOwdalbgEWxktxDmgdnE1C31I6stnajAFUBO8Nt+Ye7Kp?=
 =?us-ascii?Q?nFroSy9+49JIfkuVxAxDkvPwoKhENenxi7ujNDVfKYzYudM1GQxmKXcztQu7?=
 =?us-ascii?Q?H4yYG5aEEB8P31tg06K5dOAb7qdA+HUL4JljCgypjIPoY7TICBsJtaLEt+vL?=
 =?us-ascii?Q?594Jan5wDYGUl1N9X3OhjT+8Fo8Z2nZDk7+53dvfp57CGh6IurorGFu9+rut?=
 =?us-ascii?Q?asHCdU7HJHJKEy7oAhnfdzHpiYNonSM1qBdsz53WR/sty4tyHMDdKXUkM7AL?=
 =?us-ascii?Q?A2RxsE/V8aGFE1U1Xu8Lg7stFkuo1g6G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?waurPNi+aEWMSWydKbR3Qf0YpTMMVjTw5SHM2AKkVi7XKPLPGivL4sSHA30l?=
 =?us-ascii?Q?pEl55s5cjm0uMzRI9YdbIF5eQJYLjG48rUFKymoasqVm41siWrKA8+yjSjxW?=
 =?us-ascii?Q?9ZhjBsBjdWhmpoDDw4/GhtdJuEM0he+XF876LrVC3Mm/GAGpdwcE0cl6Q5KU?=
 =?us-ascii?Q?DIpFRuBDKDGD8Do8kb2jd4kcPemo4qTo0v4v8YgpjPLM1rrEUTuLqMfHm3Jw?=
 =?us-ascii?Q?0/52Gq4p9AYu7YT06uqHC1oPep03usBe3G0CzTY71IqNj6aRXg3RqLbbYi4W?=
 =?us-ascii?Q?JKSS0Q5mOWONhCyZHpz+HpfkXRg/uKFr8YxttfwDRamItZ8sZb3jWWUqvToG?=
 =?us-ascii?Q?Nk4FRq0hBiINhfOPxsG0SpJQu58UHC3a9DVfFvLi41RF2DaDGPLeaNru5fSj?=
 =?us-ascii?Q?DmZGwAaJKMHbT2LukNw/CSi1crCXwwwgTka1w2Qom4Eof+IF/BBMjgfurP5T?=
 =?us-ascii?Q?3BDT99itxOmQwL/DqiAd+GKdMSEb9po2/w7CTPh51Kpxf2VXmVUuOVlLrUQM?=
 =?us-ascii?Q?20+fTC3lHTrEIQnG/CCLBI+zT4cPWcQqkMOlmtiOtc4pfQ/vKI2OTA7DMqdF?=
 =?us-ascii?Q?NM0apTA1JvwYhv54AU0WSmjo0CnXe2qJXb/2TvtrTvK+B9b6xEAtzT7Ri/1O?=
 =?us-ascii?Q?9nud7Uz++xMS4WpBhCgMN2f0RQ+mkyQpVzv7JlxopxYEnAeWjAa4J6a9kN88?=
 =?us-ascii?Q?0LAyzZngE1iVEjn5J2ojUWLSMphQ+XBu2dk+XVzWARIfx4EgNi6Rkn00DnBd?=
 =?us-ascii?Q?KYKtdOw2X2itWxrDlO21LAZN32KKIQaW8a0ptjGokHVJZ1jghBKSK2WKsBxV?=
 =?us-ascii?Q?1df90KwtlRc2sWwln89lP7QE4NmVdGgQ0R+MASO/z6WkHXGEVJSKST0A7RwA?=
 =?us-ascii?Q?QxylkUgSPj20E9IcrcWIxSObHEZZj0KKKTb1hNuR9jkEmlNbMcp/BJaR/UKc?=
 =?us-ascii?Q?hsq379LDVUoVFfMc5h6HzNUPOAb0mDY++W2taTZIZh4E8Xn+HOy17cjQ7Abw?=
 =?us-ascii?Q?t34HNlqj5Q5ZYYqse+z6R4Vhld9Bymcn3DZsXV2eNY3Hm+wFpHcXBmu7mQ52?=
 =?us-ascii?Q?QlrTRVu6ST6EhJhKnni/LkIlQbGU35JKu4NelKGG6ZwpfmITizDqddDdtsWP?=
 =?us-ascii?Q?vFEex3vXYiDYiV8mIY6/ElUxmaFZ8ryUzPRGebcVoUuHu56kR9k5A+bDNcdO?=
 =?us-ascii?Q?DYglXaI7M1QWMKDAA+wETpTw9sOSMDMePjvNpMCakRMWKHfnpbot8JKUtEnR?=
 =?us-ascii?Q?+RZ7wgdoA0fLDac2isY+9Azuftr1UCVcr+QPNB96eyIHQYEh1u1PTnL/7rAd?=
 =?us-ascii?Q?DgO5OJKQnVM2YW4l8bGbF9FceAAeo2HfBS/KEW3ExX9BWH5Fp3MuVTyJgmJ8?=
 =?us-ascii?Q?OonuwqbLTHH8OvOkg/3XBGKf5zmdPSpaIbA7YlgY99Z4sC/bc2qyxyUwrkJ7?=
 =?us-ascii?Q?U+a8KcdisHqVekQUKdWauZJdc6GQUz7DKpB8bH8SQRdW57ClTzIs6sbxYAuN?=
 =?us-ascii?Q?+qITCwDumkVrarZxc5542tZ+MfCmFt16P5nRq7ckegtL/febXB4Kxbku0oDh?=
 =?us-ascii?Q?QeRo/h76mtr4ZPQPD4Y7dHmMlmtWiHSIyhyXz4C4vQLeCV3uwzrpvsuwUo1H?=
 =?us-ascii?Q?bQqbLOSQk2RUFfRdG6+goNg=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c2d948-1ac9-44fe-13ba-08dd23e22899
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 06:14:00.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7F/Ku1zbO1dCKTG3AFqGykPeGniHdAGwYwNets5hk0m2n8p56WBifKwme+VxE3W17/2F1oWrsAOMgon5qHqUQCk3evjYZE97uh01I9/w1SA9xSGmTaqublAgOoZ2BFGp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0331

Add Support for OPT3004 Digital ambient light sensor (ALS) with
increased angular IR rejection                                 

Hardevsinh Palaniya (2):
  dt-bindings: iio: light: opt3001: add compatible for opt3004
  iio: light: opt3001: Add Support for opt3004 light sensor

 Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml | 1 +
 drivers/iio/light/Kconfig                                   | 3 ++-
 drivers/iio/light/opt3001.c                                 | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1


