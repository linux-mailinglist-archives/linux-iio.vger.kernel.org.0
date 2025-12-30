Return-Path: <linux-iio+bounces-27422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE973CEA070
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 16:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8AD130550E7
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DE032570E;
	Tue, 30 Dec 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V9KINiqz"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011031.outbound.protection.outlook.com [40.107.130.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42D31ED91
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106663; cv=fail; b=P7u6a8KH5H2sMK65eX9KSi34j4eeTr9CLjwNUqhmYLOKc8opbifkRwKlt8n7BdvyJXsbkIxc+gV0VI4jR/KR7oehQme1N46UWQV3T5cAz7zJSOmkEUto2U4HWbDahnV3HMhZC8KF/xB5JuVKAOV1VzB7uGqThhYwGdEBcAsaKDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106663; c=relaxed/simple;
	bh=pvUiOPMCTJWNx2micqtCvA3T+cIKsW90x0zyOErHXYs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nP4oltbXKImU6HLw2ceOFSBJ/pEy+a5Ev8mLnPrZ7C81PDvL4LODSu0YclFCtlWrhsqPnjGKEOcU60qL9BnJFdMY5plntCIF62OyzrYMjAiqcOi7uJP7iETIzQ1T2EHgvlFv9pa8bGPYupZIDZIntn0pWcA2qcfOQzf4WozwG5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V9KINiqz; arc=fail smtp.client-ip=40.107.130.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZCZllUre+aMVAPtHY/XDmycWZHFar4jdVJNp1UaCvzwZBAcoFz+JvPCDbA2ek7WDW+ZMYW94cHYKvQ2NRjipWHxpP1wVerZxMWdjw+oxDYQPlqq3QgVYQe2OJTvXkyMDIoYlWMaXG9P/uJc/dbbTYn8ngAyAIhdMYfKmnp8n4z4Iecy+3C9C6WtXCyE4xl1oxqJPLOHRTClDzEwKtUj3C1QEvNkk7m2bIz2tSnoSiFIv/1fMEs9HDuHKlhcKbmtplF3rMuV4wmTNL3/ofmCi98XlP3RAY9XMqyYscX+lpg2w539+8a1A+vFCLT/5kjdoIi61ZgylB3moIrxNAWQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n/qdXGSTWILb0wKfLwUPwZP7tpBJCeTzJcE64uwfLE=;
 b=GoxL0FhF/QvRzuMScNialt61q7IxYqw9PGlIqXvmU3PjZF2E+xqH8MsuV6THrq1uxE0FfymyC+Gi0DMbBiGCMiBZUnN8lrEHSlH+2zcOSVMq9tDDs57HkL/nPOeR1QhOsFLcsciYMxjmmUiBZuYFg1twNBD4J5hguM6X+CyzrkK40J/xU0UcmkIlHQfTwKw8G6ht6neWFxWjjRDX0wYBv1EW2LM3wxLGDUNQT8x7+cnTRfnykCQN6fyyImqAyFK8PwCfkrybr2Jt/fGEoZtE/gYXoDIepStMNMW5nA6DK+lH0vzhqzkffMNjACOoNmSeNxAB6eWSd4BQuc6QUKZZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n/qdXGSTWILb0wKfLwUPwZP7tpBJCeTzJcE64uwfLE=;
 b=V9KINiqzI1eOmoWJeEBHejbpUmQeJ4xzYfxSueajL9+T8YDOj7dK3KFOl5GPCbISZCY0hsyHnqpKoQyBNeZ0jCZEqUUHuZrcWTywBtc70eL3+Xj5Hrs9SZDKtGpHPxRY2yTKcRnjgrx2yrQSqNT2/yJH6RGHeb7Cxurv80SdY9cYIOulO/8qVsTuoI/N+/iEqQ/8HOyuCex3/rJL2aoUWwiFOSwyP1BOeCjd+gMDGO3XRxL8mpO/M0ND6WiROgK1J1DxkuEJSi15/FJiRDv1UUTyumO+A5JBXn62Lrwol6SdedJFqbYo4oStQfT8FZv5a77ftG/uf8+yc48pCuIgMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM9PR04MB8306.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 14:57:37 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 14:57:36 +0000
From: Frank Li <Frank.Li@nxp.com>
To: jonathan.cameron@huawei.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	andriy.shevchenko@intel.com,
	carlos.song@nxp.com,
	fluturel.adrian@gmail.com,
	linux-i3c@lists.infradead.org,
	linux-iio@vger.kernel.org,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev
Subject: [PATCH 1/1] i3c: Add stub functions when I3C support is disabled
Date: Tue, 30 Dec 2025 09:57:18 -0500
Message-Id: <20251230145718.4088694-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:510:325::27) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM9PR04MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: d8721580-22c5-4f28-2d58-08de47b3c541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+fsPHgdRaoSsa56xtf7MsBB2RkfH+hrfH7UprL0yzOMD6OxTsedLkCPS9bN?=
 =?us-ascii?Q?m52DtJkSgkF+6nN3hRr70LyGMRiT/fhQ+WMjPK5viQaCkxt4Mk15k9uZ9iQ5?=
 =?us-ascii?Q?mAVOjnFraSllWI59B3AqBv58Y2y3raZtzN/u+NoDq1PNSYNXQZuS2OJLMPyW?=
 =?us-ascii?Q?h8pxzOJ/nPWx0+ZfQasdViPv0yEOuWvK9nA46KnrySYqf32ZYECvyc8+n5ax?=
 =?us-ascii?Q?IQYI9twCTurbOGxOgOmF0cKYiuDh014v3OWIJfsV2kvwChULWCQYI/OHfVXM?=
 =?us-ascii?Q?DeWWBzva0U86LwvLiW2hsS9OQc7PxEzeZ9I4GRqgmKO4TU4hOfS8bGoDG4t5?=
 =?us-ascii?Q?hrWzsZL1SzJaNE27D6RUQsbLbUq9Z7mRiq7PCrp+pWyld333AFAOQGvzquQG?=
 =?us-ascii?Q?oo7c4IT8k1Q9/0KgpobRRsQMshLSvyZmJJ+WWqb4VQEdVEnjfLBCz8JO2IJb?=
 =?us-ascii?Q?x9oQEgvVtu7i8CRILS1W7idC11XifbuUlG4PoGWTUMRHhQwyDeOpGrcMMNUA?=
 =?us-ascii?Q?WodAY32POYYQ6quJ8QF6Xgiv1sY6u3+OSDY4a2t1sXu8M8ZQr+5NCYLyvOkQ?=
 =?us-ascii?Q?GqPhZbdnfS9qTF43JMqnsaOoww7oI6E/qAaflms5xvsTFDQhoXiJuvtV91nf?=
 =?us-ascii?Q?g5J1NiQgZz6yyVyeQpqQfs7aq7qZdoJWb7Bl9j37sB8Zn+se8ISxgi5sEQN5?=
 =?us-ascii?Q?tN2FByix/705sqI+nOjpOnCPB0O5Tfz5qIxnlOpz1kF7l5owOtApUIOymG8F?=
 =?us-ascii?Q?tfcCe1qE16tJrZFTQOAh3qnuslJOqFZvk8vO0sjoC2h/3GKlJ6e/qIaGPACI?=
 =?us-ascii?Q?Yl2RUAfX6Z3m+eKae7lDuFR0DFjn0gowHqxcoG1TtzHDPaPZVOXvo6wYXKdu?=
 =?us-ascii?Q?zqqqA2eC+HF+mKt8E0hdzIHlBrssv+uyGAB3Hdqq2/jPzr/nDZM1T6/8yM0M?=
 =?us-ascii?Q?Rh3aBFEJR7jrEGIj/Z1i+6OYYSNQWgEU2XBMdeXQeDtg4jP0wzi5e8+duRgN?=
 =?us-ascii?Q?iJ2GcBBC0imhLfqMisPqOCYk4BcNiHuBuj45qWWwm8ubAdQc3lS7uFU1ikCR?=
 =?us-ascii?Q?NhLmh5NBHZB8qCISneeZabL3bPYZOCoXDlbXhOJYQm7rHUhelBvME1bMJzAy?=
 =?us-ascii?Q?kSnZcKxEyIsrx+fE2YcizKJs2Nk4gLmRMYELiJWASIEaV8kjF3hlzwE7eAfA?=
 =?us-ascii?Q?2zVXqGFC7iPnoSCZ2I/mZiBy4TsYvQAwUexhOsS0nL1gjuePwnC8eo/gFxkM?=
 =?us-ascii?Q?GK7auqFDOa75PEQN0mMSnhCz5dzbBWehp7hSGTIprKwPLFPkJliI1fOK12Nj?=
 =?us-ascii?Q?YjirQpWDo3CBcNLuUoU7sjY037ItXLBvl1ZeMfagXtYXtuYjhS6I6tHuJQ9y?=
 =?us-ascii?Q?S2bJ2/KMz5WKfXvoNlsy80r/V/Yloc0lP9F2FhXckp/JITov8i9cLAe/43kv?=
 =?us-ascii?Q?B5F0VZ3+WWM6kg4S1Fh94BJg/uljau1L8dTyt9bMON18Q07n0dNXs+cAQxmM?=
 =?us-ascii?Q?i1P3+pIlAherr4nPxfhUkYVCKhtXLIsrQ4t1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GkFDVVuJY+zjqC0h7ZruMCFJTtGhRMN7zMl1FRzHIVQR57PO/3bMZbfMa9qn?=
 =?us-ascii?Q?SevDPuXAYW5oELe0Qu+PS1UpX4RWKTJMRax1VBfAf1sOmfNdTfnixNthWHUM?=
 =?us-ascii?Q?1Ido1Etjq9T4oasaSbvMQJyyyOPYZGciANigjqqSHMVBCQQ7uvNvaOCQHiDV?=
 =?us-ascii?Q?SS0mHQZHRoJBRaMON0lnXc46hosVSjk0+zDuI3D9dcaXoBGFETPR39hKl0CY?=
 =?us-ascii?Q?gdAmtVUueVW37EHPOmcaocarkcEyFj8PuNunrPY+jeP8ZMxR8j7MrTsLkUaJ?=
 =?us-ascii?Q?JlJ9f3MhMUiicY3ba9FaaN9dwK6B0k3kkR8kpzOjGb9OWUsriZ6adjWFJ3c0?=
 =?us-ascii?Q?z4DUgt5OI/kcvn8I6dDe+NU528F/f/b2xxrI7zLmLFeuNjiMF0qRd1BMV8Yd?=
 =?us-ascii?Q?yFdgYR8WOzJAV62OJVLhrjrKTAJyrdZ7XXdWnuIcMgq/1uzBVwWVQeSXXlK7?=
 =?us-ascii?Q?WkWoIZkGeAuC2BGUxLjyAtq3tUq/5SKyfpVy3Qhq7V8RMm+NbEwEoL6Nx8GC?=
 =?us-ascii?Q?LcpZ+XGHVV+J3/VB8Iz+zZRh0tmpsnUq/TTMTp6+A9lSYFCpUQdb8YhnJmMG?=
 =?us-ascii?Q?4BuqQmhlU06rpQPxronwA1+VqzeUenyAOOsDB2/A+I+fM56lnAQ46w8sbgiY?=
 =?us-ascii?Q?w78hs6Z93l5pMqRTmn3ef2tOW+urwWl3agII24Y1u8O5UAgY/CPjGycuMboS?=
 =?us-ascii?Q?9aKaycU2EcHSYZ4uuTZPS/aFV5L5wdkJDokBIOrioiRm0k1QfXL4xCRj+7wh?=
 =?us-ascii?Q?ckkA2lmKjdmO8AOWrfX70jaYyGRUA7chi+M9s/n9x4E5ZLOyluOWBWqI5/+g?=
 =?us-ascii?Q?B6psB/cqnIjtWHa1vab7ZnVDw0awZ9DiKtUteHrvGQql4gQXP3Shm1UVGu4z?=
 =?us-ascii?Q?2kqQHMRKCXuR4ZOcprxXuQMPiM6PyTVHQULvsMWV59zBUC351mlfjXQOxpNw?=
 =?us-ascii?Q?yBRZome0Tn6wLE1KK6y0XmPLFJRQxm9niZcUpZqlT1UhSjoW8IcjL5Ces2wm?=
 =?us-ascii?Q?T0ezgYjMDclyd8L9OMt6N38Gm2GPiPg9O4mvSCbTo/Pc7GZYdG0w0WpeFYm2?=
 =?us-ascii?Q?c/C1fi8Jac1Rphcb4KjMuITpCAPylmDnPv2t7dUCP/zYXLcSA5C3wBKPdhFx?=
 =?us-ascii?Q?b4o1vtXMdlKA59cvtfTT9RaZ928rRryIYutHgrNviUaiNVAuXr8u2pP6RHZc?=
 =?us-ascii?Q?qH4iV+uJ6Js+loc4PMlkGmGN9MAnbU2rQHyfjij6R4zPkL+z6VZd3t0KfvN2?=
 =?us-ascii?Q?m2qpCFyZ3abdVkYbfYupM7/iSlOIF0dxRRWEB3L2nhfvSdPUwWW2GNnp8rxC?=
 =?us-ascii?Q?8husV5xY5hzK4gvgjF0G8BBZqfOXJijezBHLJILCGrGyOBkqHE1AeTlCMLzl?=
 =?us-ascii?Q?6Hy9M1GgxAi0HrpqeJnQZD9GuyE4VQPf3xZoSoKXMT/kYIssjEzmm1CGy/u/?=
 =?us-ascii?Q?U2UHo+sPeNfBO31pdcIfEdDgbe5eIOIvKK4HsWYs18nr95odmXgLVBX064AH?=
 =?us-ascii?Q?whH/MqMjPYrapi7xVD2FulzMyaS2X191vXHiEm19NwCh9LetRQ0K9JMZyfJC?=
 =?us-ascii?Q?jCtLD0ukoIxDQv7RK7giOmc0Ad8UgkHNXRY0ponqTpcCzCrMFd4ZOPlDDAGg?=
 =?us-ascii?Q?Yz2aqYBHYQs/7Grfjf5OiLdFu7tWJMjTqyTf8fcFZ6l5+8zBJqCRcKDW1Rp5?=
 =?us-ascii?Q?7pWaFAfupUaBiDIlx0PNH4LJ/i15ri3wgCK1tYj0L1/RKjpZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8721580-22c5-4f28-2d58-08de47b3c541
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 14:57:36.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0l3AR7J5nt61F24OIEXIg4Q/Qb+Or4at6pDnP5CUU7EVdO54FFAafOJp5UE7n9fkTE0LB6USoNTEM1Q7czM5hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8306

When I3C is disabled, unused functions are removed by the linker because
the driver relies on regmap and no I3C devices are registered, so normal
I3C paths are never called.

However, some drivers may still call low-level I3C transfer helpers.
Provide stub implementations to avoid adding conditional ifdefs everywhere.

Add stubs for i3c_device_do_xfers() and
i3c_device_get_supported_xfer_mode() only. Other stubs will be introduced
when they are actually needed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512230418.nu3V6Yua-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/i3c/device.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 9fcb6410a584f..1dcce2876029e 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -308,8 +308,23 @@ static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 		      i3c_i2c_driver_unregister,	\
 		      __i2cdrv)
 
+#if IS_ENABLED(CONFIG_I3C)
 int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
 			int nxfers, enum i3c_xfer_mode mode);
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev);
+#else
+static inline int
+i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
+		    int nxfers, enum i3c_xfer_mode mode)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
+{
+	return 0;
+}
+#endif
 
 static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
 					   struct i3c_xfer *xfers,
@@ -358,6 +373,5 @@ int i3c_device_request_ibi(struct i3c_device *dev,
 void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
-u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev);
 
 #endif /* I3C_DEV_H */
-- 
2.34.1


