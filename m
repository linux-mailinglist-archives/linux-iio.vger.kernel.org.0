Return-Path: <linux-iio+bounces-12254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664499C8BD7
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 14:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0E4B338DE
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D8E1F892A;
	Thu, 14 Nov 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=l2task.onmicrosoft.com header.i=@l2task.onmicrosoft.com header.b="TJrGAveB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=l2task.onmicrosoft.com header.i=@l2task.onmicrosoft.com header.b="OUrKydIR";
	dkim=pass (2048-bit key) header.d=aerq.com header.i=@aerq.com header.b="MfV/MGg1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx-relay67-hz1.antispameurope.com (mx-relay67-hz1.antispameurope.com [94.100.132.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77221F9EC0
	for <linux-iio@vger.kernel.org>; Thu, 14 Nov 2024 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.132.234
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590348; cv=fail; b=YghmqqFHzOKlYbSzhjzkm313U8PstwJeyI29HyLMeNrhB7sZf2Rb6pKW7ZzxbCmkvpxByNcUEcd5vxJHhOV7I2rLLjhm0Ofuez4M3bJWgkgreVre6qS0d/5ch6Now9QFnJPhkTZOJSEtdk/u+UIJayo93Mn/iIh/5tAqzmP1Mj8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590348; c=relaxed/simple;
	bh=7p/L9E2BxFmbDaPJn3Om6p82K/LjTIqN0YNq0StaQHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lryDjW4KNQeSto3H/6VK5FEoyOUyixIb5QDSUB/EjugBsT7/cvBxhusNpTvb/F7O3El2sbvgq+wKi/5jlvTqAL5szWlZvedGfC1QkiiQmNzQNTyPHsKmU229Mjg4o1Rz3eZAlI5wU6Zmh4CubqHRqcwRYIEavM90TdjMG5aMGsg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerq.com; spf=pass smtp.mailfrom=aerq.com; dkim=fail (1024-bit key) header.d=l2task.onmicrosoft.com header.i=@l2task.onmicrosoft.com header.b=TJrGAveB reason="signature verification failed"; dkim=fail (1024-bit key) header.d=l2task.onmicrosoft.com header.i=@l2task.onmicrosoft.com header.b=OUrKydIR reason="signature verification failed"; dkim=pass (2048-bit key) header.d=aerq.com header.i=@aerq.com header.b=MfV/MGg1; arc=fail smtp.client-ip=94.100.132.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerq.com
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com ([104.47.17.104]) by mx-relay67-hz1.antispameurope.com;
 Thu, 14 Nov 2024 14:18:02 +0100
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=NDXNLXfLOfcvAFwAVQQw5qoTcKYDu3mD1TtjoNuBQ3YKaF+sq1UfQsW+HSZwxinwgq7OmO5cw1QKZMQMr2oHf0S9k2Cn6Ub+HoUkUsA2NhijXXdLqDEsirt9ZojYHiUAdrSBqXp9olkEgSFFsVVotP0puuWq/f+E14q2YQ5e6W5TQ0eAfNN33mA4XfkKsjdAXhCIY0hqHseiYOceyQoLF1RIZbhSrVV3rwT3prlcL3yBbwj2smP4Bg5pVs1vXUvb47krmzM3jKFLiuBTE5gPzpdiFtumksFqr6zh25c2GVzok15QTpQnoPzD6O+KOZJgkNqrpQ2rHt+h25HlFvFzBw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6XOIQqsbUM00Ny1tqxDL+n0jVOIrfKOr3xBsKlp2O4=;
 b=WNN8oZdZrh8id7HaPQDLNjBwbOUSjiKIlvITHXO3u4vufB3XXbitnVYVoY9dYhVbryLgkIjYPmzaWSBqY2zis3DDuVZlTnJSzqH4/r+PsHi4TEQ/wNEcmkxf4+ueh2EQWWv5msfe1XoddN1HPKSOgmsAiiXrpxdT9mflXi7rqXQjcIMrkbW0j0p+XZph3cBaKmu6oSyWriCZcFL86xTz8f6ElbwMNSWxvrUdJU9KdvoXPFDYfEosEmbeMC6miaIGhQzAezNt7mmr+TKycVvwlpH6cLgE/UT7npRDCXRkKhW6NXUsTjr4lRKCaiWUaJN44guT1V8JmwhsxzMTNc6c1g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.169.0.179) smtp.rcpttodomain=kernel.org smtp.mailfrom=aerq.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=aerq.com; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6XOIQqsbUM00Ny1tqxDL+n0jVOIrfKOr3xBsKlp2O4=;
 b=TJrGAveBbTNVruMnz5Ki7R1bWqS8RY01BWbENz7IUGkcksHvSmbMZFLlvRzlgm77YycgYbrWJcpN4NDCujDdS4j5O6WFckBkf+r1KNffEE8q7nEkmt4ueCzV/ehQbhErNjd3xSjhClT9HP5xWp5PTP50CWnDXXmRE8Ir+PDUHIo=
Received: from PR1P264CA0104.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::15)
 by DU4PR10MB8322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:566::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 13:17:45 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:2cf:cafe::47) by PR1P264CA0104.outlook.office365.com
 (2603:10a6:102:2cf::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 13:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;dmarc=fail action=quarantine
 header.from=aerq.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 aerq.com discourages use of 52.169.0.179 as permitted sender)
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Thu, 14 Nov 2024 13:17:45 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
	 (::ffff:104.47.17.104) by eu2.smtp.exclaimer.net (52.169.0.179) with
	 Exclaimer Signature Manager ESMTP Proxy eu2.smtp.exclaimer.net
	 (tlsversion=TLS12, tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Thu, 14
	 Nov 2024 13:17:45 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 4412768
X-ExclaimerImprintLatency: 1036775
X-ExclaimerImprintAction: ce8892d06b264c34b52c05ba7ef2924f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l44GfKMjje0LOdSVH6t8UzKXslvyAesaahIwsSQ/ntgkkUvH1cujCKxpyIomQFt9bKnnaG2O6TTcRarH7OqzJPcaNXHW3MwaiNBA05CVdBH37chXIkK2aHGxAf9CLC6+tLSpq7qfySFXGUgmthYc8GRA2rbZU9NBrWNSC+hzklRV+5e58Suyj75tQ03BZ/iH5vQvQyfOvSef3RfvYE57vO9uduDH8EZfB3m6nBFkT0Dbb8bKPZyGSajYuBREwKFaUpr/ngVrQkPEdWyDIgunB1xPkITMZo1iR8mNdyo+7MbXo2zDkM/15x6rRyn6024+Y70Yc1TQh8HnwR2ZtGS6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/v12EbgC27xgEy0kTzTgePH2uZ3vBbeSUHBdd0MBA4=;
 b=rZ+ZmA5B+0n5fg30/wyDYLvpVjqBl173Gc0c0vysT7GhaBMJPPfgr01lFTLIGHqRJ5bTvuiakGXJ/EShMov7OIBnppQhM2RH0mLSioY+iluw55cZYFwfWDP5vJZDcaJFwrq4/iJL6Ry1vzMJR/9AdviEu98ACyFTv+KQYgZgotViKNyp5oE9AwxityW5tZ9kJyH7QirrL6s+pt8DWTPJIGQUFyXuCo3KKlVre9gskAY3SUPvwyIClqwtaosDeBgktRfw2uX1sMfxaMkhED6S49+hZPtHi+SP81hfc00sr3rNp98N/slhFEPUHVXLbJp3hcvSSpOz7y071VjtGbC/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/v12EbgC27xgEy0kTzTgePH2uZ3vBbeSUHBdd0MBA4=;
 b=OUrKydIRmAmvrfxECYy2iWlylbbKeom4zmiKstevlCSwtrZE3nDDh5J2y59ftZyFKOyiVJBWj0Yp5oSnK6ZoNzHPTJ1dikb1KUwMOFrMgNOkAHo7YTf7Z7Ij1ieKKNZk4EpXFm0lbgQSYx5XBlxGQF7D+bSx0AUgCdV1IxknSuA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aerq.com;
Received: from DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45d::9)
 by DU0PR10MB5218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 13:17:40 +0000
Received: from DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8c9c:7279:978a:f67d]) by DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8c9c:7279:978a:f67d%5]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 13:17:39 +0000
From: Cibil <cibil.pankiras@aerq.com>
To: jic23@kernel.org,
	ktsai@capellamicro.com,
	lars@metafoo.de
CC: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cibil Pankiras <cibil.pankiras@aerq.com>
Subject: [PATCH] iio: light: cm3232: Reset before reading HW ID
Date: Thu, 14 Nov 2024 14:16:56 +0100
Message-ID: <20241114131656.1707358-1-cibil.pankiras@aerq.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45d::9)
X-MS-TrafficTypeDiagnostic:
	DB9PR10MB7291:EE_|DU0PR10MB5218:EE_|AM4PEPF00025F95:EE_|DU4PR10MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 94db491d-d04f-4109-c5fb-08dd04aeba51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?AxUJv4F8KOAhmI3HgD51fbsANpo58YJTGHfzqKfyoAL1Fgo9L7fYSRXvlum1?=
 =?us-ascii?Q?F9SdutU6BJwlovsTakAjpiqvcExyVJtmi4fukU/aLY3+Mo7SilIdOysOO5AR?=
 =?us-ascii?Q?5K3bMCks3NImJjJaup6Uyk+FJhjxjymnBGw7Msj+2v2KLDFu5/hZ1ybjh2pT?=
 =?us-ascii?Q?WgJCui2Bvqvyg68sTyeGRqo90dn1YY8YJnvpFgpUDKHEAZnAauV9EHiVUQRD?=
 =?us-ascii?Q?Ix5i/nhgx5KrFMsCtKA6CjHSFjdep11tnUZsGf6L0fyDaO+fdLOzGI+AlYoi?=
 =?us-ascii?Q?6MKBrU6xhua3aYkHqg2MR9KJDAhBDWTCh05RUmHgHxGIyJLuDNvCBcpP5YMP?=
 =?us-ascii?Q?ju20mMp2RYgl6aHnKI9dMFPgZbidFaimOl12j4Byc3g3pgSe9NeWbkdOImuB?=
 =?us-ascii?Q?RPE48k0BiHjudX9sRF2HYjv1PF6PR2Q8Ioy4z/HgRATyxFg8vqkoUXftcMS+?=
 =?us-ascii?Q?PPJZXAf0zEJtlhD0dkS9rXRspt5hnQ/B+tPA1MVQxPQMaO6+ssjH0q/3PnDO?=
 =?us-ascii?Q?huukESCmS/hU0dHNR+hqagBK1A1ZI91VjomutfYakqhktl0Wj+ThmVhEr7EN?=
 =?us-ascii?Q?b4RWEkF3gHgU92mrvqv7QHhnmSbBF0vXgRot6w1yOGXaIdsuaxS4OJEC72Kr?=
 =?us-ascii?Q?nclL3xavC8hBCbwmw/A990fqVwBayxvaMk7OhYzm3Jgjkf/8iT4JYVqGS4w7?=
 =?us-ascii?Q?ZtfzfdBIF+prZALUO+CHRTUaEwo8ihVihtWLbJvdtwUonq54QG1gOjt6aVQG?=
 =?us-ascii?Q?SQvWHHYH3lokkFV1CcDDSO+y6jM8Ee04C4yfkf70xckv9nSSkDjzoWt+J6FT?=
 =?us-ascii?Q?ZcHMcgQBWpK554Nvhb8DmtuWpcBo5Y+tNrjqm+Q0YheO9oZkH8E5R31Xo12i?=
 =?us-ascii?Q?oEkwzJut6Od+FDtPUYB+Cc/IptputpRMCb1I86PEY5d+R6xgA47rdCCOPqvX?=
 =?us-ascii?Q?0AylOkK6FwRcHrqdxd30xItAcTDHt/4tVC6mwZkOiz6FIWeY8xcOnoSjoOjD?=
 =?us-ascii?Q?5JtZCe0Seay/ZSM6/j/z+YQ7aEXcGAzKUgq83lFvYkO2fXpRsElVNMfTL8W9?=
 =?us-ascii?Q?fF8q81gH+wTatBu3EwHB2kD6fZKW/7MKo0ZPMIMlEKmYan5awGFoViSZtbNw?=
 =?us-ascii?Q?zNaVuZI/ESFp9R9at4OptAsOpjvtEUzF21vFFt3nhDh7vDmHnBo7ZG+kB0vd?=
 =?us-ascii?Q?/cOk2xwSGF6kqLCBXTvwEqzsWLoXdzsvhc9/81HpjqRqcBxWvOddPqbzYlSX?=
 =?us-ascii?Q?K4Mms1RzzCB7RJc94h1fRmzCMkfrrlhaIalzZyX+t4uHkxFpLhWvgaLpiyZb?=
 =?us-ascii?Q?mDgXNUN/vndKIwbuyzMEmRAT6imXeA5NcDojiQakS8xmeKTT8UCh6zxT4WYA?=
 =?us-ascii?Q?QpR3jmY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5218
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9abd7498-1623-4af5-966d-08dd04aeb6e2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|14060799003|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fx2n9llE6R7vzeXreyrMoOcEoCFDZ5j1NUoYTLZNjOk060axagKJYNKG6sw9?=
 =?us-ascii?Q?qfmpQVtQcOFCZbVhNShEMhqKiNmFneJy0D6g1gjfLDligfTPv4zHDSsB8fev?=
 =?us-ascii?Q?3GTO/wVX8MzMP6U5eGJk1lbWzytf5FUN8RV7CWrpOyQ2LUaCBM8IBIfUdiQE?=
 =?us-ascii?Q?oqIES4UyDi5i43gjNSQYXQnAkNAcZb3cGlM+SoSnaYSpSZttLwMZPcIdCn7r?=
 =?us-ascii?Q?YSFG44GKVL6KBCBRU2ZPTC7pFhkBa87QdNkodcnraCE2xqQvFO79itzsTOTm?=
 =?us-ascii?Q?2g0KNqDCNv6Lp22qmZvp5si0+WhFH+CoWCnzB7cJDyXJZe8TaYR/Dqfzt9ZN?=
 =?us-ascii?Q?tsVLUM79hEmwVuntHP8mDZMLFiOnCWCEHYhx6p+JuwfMAAuV3EHV9bcYVVbD?=
 =?us-ascii?Q?Z2hT9qbWXktjYTRBUy/GZBNaeJTRow8wuK9YTiJ4+vmbHZEfx6OatQl52oU1?=
 =?us-ascii?Q?wa2br93UUYhQOFgGRA5b+uQlUFwUowmJf7bqzuuVRJHpp2hYt5VKSWsnnBQ0?=
 =?us-ascii?Q?J+ZeWomPPoU0Gt/extmLhrzgQPcKFTyPk4y7ltsdyX4ZnQIqoJBmzZlu3UMe?=
 =?us-ascii?Q?2mmoRHufP69SFu2zBQo4HEItEw1QwrrRYFpbqV5Qro7qTCUvJgPo+GWw0+FM?=
 =?us-ascii?Q?G7WRjqUbnLJn21pjEyEYTUo/c743IRvIxR54/11nYnJ9r8MTaVBa+ZWNPUPG?=
 =?us-ascii?Q?9eCcL8eOj3CCijEDOXFwLlc9GqaNrGfiQPuvBQQJq4aMOK8hrG0fIrPODDjk?=
 =?us-ascii?Q?Ix2OcOJqdq7h9BbgUJ8A66lAsS+5hiMawO8BzwAh1zezNEKLA/5nJlq9znDU?=
 =?us-ascii?Q?7kxUUei80J95MgRHE7UaKkAPlDRUct/HT08MImCwVqPWVejm9sqnMjK5kx2o?=
 =?us-ascii?Q?LN3xVSsk6fIluc3j/GS0+nILyqikyhYcCaq6+h+9rBz7+YJkNda1l2gwdAob?=
 =?us-ascii?Q?gUIeyemhGl0XWpj5Wz0vrpAFpsiBfqTSw08GJfF25UBquKOSbmGWpcaZscUO?=
 =?us-ascii?Q?rwM4121aKpz0P37dgiMNI1b3YSz9EScVjKLfYGVSYSezTmBAqfbJ1b3zewoT?=
 =?us-ascii?Q?k4n3yVARToQr0ZxbmMz1q1D0KA02M9C7Aux7IKJyCdHXxzgb/EIqLd0BqcgU?=
 =?us-ascii?Q?XZP/z0q/7r/YzzA1OZG5rL1cymi9QXFFZJAqc7YQOPZa9sUtjqXE8UIN1sbD?=
 =?us-ascii?Q?dRkreWFP3khq0bUaC8khClO/v7d3UUMrXlxsT23XVH2PrQ8hmpgZ5NfsHgUE?=
 =?us-ascii?Q?prF14t9BIIeUWOtZad82giJw9ZBMsRq9zzckqSTZsMtiI6IbSVqmNoto91Aa?=
 =?us-ascii?Q?+WZ62IzI6fATsr0ZaAu0pzn+vfiq1EmO8ew3B9M8M5M7W/cufZoy+JjoHrGs?=
 =?us-ascii?Q?6NxZs0D4f/5R7262mcwF0/V1+/Vv9nFajiUl7yK84IMATbVXZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(14060799003)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 13:17:45.0876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94db491d-d04f-4109-c5fb-08dd04aeba51
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8322
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----1852AE4FDE1479EB8EF3900BEB95A59E"
X-cloud-security-sender:cibil.pankiras@aerq.com
X-cloud-security-recipient:linux-iio@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: cibil.pankiras@aerq.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay67-hz1.antispameurope.com with 4Xq10r4S9WzKvfd
X-cloud-security-connect: mail-db8eur05lp2104.outbound.protection.outlook.com[104.47.17.104], TLS=1, IP=104.47.17.104
X-cloud-security-Digest:e04e1126f59e9eb9a808d9913bd75888
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:2.359
DKIM-Signature: a=rsa-sha256;
 bh=+BZQkN1N/AaHDw9gCv7d5tSCnymoz7/B8Qp+eYbPgOY=; c=relaxed/relaxed;
 d=aerq.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1731590281; v=1;
 b=MfV/MGg1ycKNAyLvfV3t2/IXEv3l3rYOeAdUd5MlEYpfZeKa4xZ2AB+bRGE3lTcU4MSj9rvY
 LfUMrY5hecxajIuuTGnnU+6RaKot/MA+i9S2Dsc4caV5izHWmlpiQvN1wt66rAf+OaoWa3DpSdJ
 5kGnb6F4H59sfcGaDskB7OZKWziWJy+SA7H/MC4Hmt4/oluH8wboU7KTd0BeeKov9BeAQ/qdg7I
 8pPhlpeDDoRdOx9Oa/0hlA8uC0U7xFDy6xgiHt7tZoM5kARn9eI/PjPM6NJcPryzuVOxyMxWO1/
 TMVcujrM8F9t0wQY4b8QohS3w4kzmG/v1V1fPxo36yaMg==

This is an S/MIME signed message

------1852AE4FDE1479EB8EF3900BEB95A59E
To: jic23@kernel.org,
	ktsai@capellamicro.com,
	lars@metafoo.de
CC: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cibil Pankiras <cibil.pankiras@aerq.com>
Subject: [PATCH] iio: light: cm3232: Reset before reading HW ID
Date: Thu, 14 Nov 2024 14:16:56 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
MIME-Version: 1.0

From: Cibil Pankiras <cibil.pankiras@aerq.com>

According to the datasheet, the chip requires a reset before any data
can be read. This commit moves the device identification logic to
occur after the reset to ensure proper initialization.

Cc: Kevin Tsai <ktsai@capellamicro.com>
Signed-off-by: Cibil Pankiras <cibil.pankiras@aerq.com>
---
 drivers/iio/light/cm3232.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 2c80a0535d2c..db33671c448c 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -89,6 +89,15 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
=20
 	chip->als_info =3D &cm3232_als_info_default;
=20
+	/* Disable and reset device */
+	chip->regs_cmd =3D CM3232_CMD_ALS_DISABLE | CM3232_CMD_ALS_RESET;
+	ret =3D i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
+					chip->regs_cmd);
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "Error writing reg_cmd\n");
+		return ret;
+	}
+
 	/* Identify device */
 	ret =3D i2c_smbus_read_word_data(client, CM3232_REG_ADDR_ID);
 	if (ret < 0) {
@@ -99,15 +108,6 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
 	if ((ret & 0xFF) !=3D chip->als_info->hw_id)
 		return -ENODEV;
=20
-	/* Disable and reset device */
-	chip->regs_cmd =3D CM3232_CMD_ALS_DISABLE | CM3232_CMD_ALS_RESET;
-	ret =3D i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
-					chip->regs_cmd);
-	if (ret < 0) {
-		dev_err(&chip->client->dev, "Error writing reg_cmd\n");
-		return ret;
-	}
-
 	/* Register default value */
 	chip->regs_cmd =3D chip->als_info->regs_cmd_default;
=20
--=20
2.34.1

------1852AE4FDE1479EB8EF3900BEB95A59E
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQLwYJKoZIhvcNAQcCoIIQIDCCEBwCAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw0MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYcMIIFBKADAgECAhEA
9Gd2dWqooci+mODZrEp3jjANBgkqhkiG9w0BAQsFADCBljELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEY
MBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0yMjEy
MDUwMDAwMDBaFw0yNTEyMDQyMzU5NTlaMCgxJjAkBgkqhkiG9w0BCQEWF2NpYmls
LnBhbmtpcmFzQGFlcnEuY29tMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKC
AgEA3KjVoDjwt7dzo2kYHmDSJF56s8Qic8T678jVaiU59HU6HTd82J1O/fVSgvcC
MEtfME/o9DnBrSo9gekpSu6xzPQ9J5BzcHARX8q8jSckqGmRuB8BiBXt/37/86wJ
KFiBxwpYmvndg34Yy6nJ5ZFSIbORUuCqLvxOgFCpuhTl61h78hXQiDzt8j7J01tG
dVlXxuD8aRfx9TBEAWIpDZZAKwyc52G9OwSGloMs9XTS80YBsodR9IFHbnun2ehi
12Ckxjn2kkeIaYO1Ho2XpJefNG19cgBKxvvunlxRWS9Cfe5NprKM5ET2ZNXfGQRD
Vn23XHd+j+1QXphy506Pq7fzaRytAKwRFp/rqTyDL6636CH+j/1dl2G85a3CLefI
FL1XUQBQrQEgFKg2A+MzGspG3FUCHgm5KAZ07HMJUQ9mH75ICezyzJZmqPlPl+dK
sdCCWj4aLLs3IpM59oO50EcPu1/vao5SnVIeKZFriMPkvSqb5+YO2YnSm1O2xuQs
m/BudFjdyRVDytv+kJYpQtBboFUsAtZYctvHMcCLjw2aW62vFx9u0MhYbEYCQMcy
Axz6/UMUQd248D9oDpaH2KK360i7MJXLLN/EPPhkQoBKFLAC2JuqpKORH/iPkKL7
5DRVVJyJPL5qxSmnIT08Od9/nB+e+iRuVY7PLDr5V3Ic7MkCAwEAAaOCAdAwggHM
MB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBQcj6s6
KDLo2jTzIh9RYgJhxClrejAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAd
BgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1BgwrBgEE
AbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMw
WgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdv
UlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYI
KwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28uY29t
L1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0Eu
Y3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAiBgNVHREE
GzAZgRdjaWJpbC5wYW5raXJhc0BhZXJxLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEA
Ey4wNfZFPxgodEZLXjkWw5S0iqqnhkPcYYvGaovLdu9F4sviuMGlFYrWNRiGPh4m
gNPaRziZkQm3y64c9FAqLLLBF4zc0Tex1Em2Sj/zkbDWfmu3rzpY0pKVI9KsxmWo
Z11GTnLlZCDXuHGOmDH6pqf0iH6oVtJH72rh+/7BC7SmhwcaWLHaoL3If1YbrZME
jIB6SBxqKawe3fRum1KCeShTgrzhvQWAJQ5kLjOz/S6EqzxfEicTJok2Tdr8ITZE
6tfXDqUzu1XPu/d8UiuiT11Rt56HnDpMMsLejku5Fkxs2/0TkD3fL/wCpN8qMfbP
PGftGM+v58FTSBlbWrOObDGCA78wggO7AgEBMIGsMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA9Gd2dWqo
oci+mODZrEp3jjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDExMTQxMzE3NTZaMC8GCSqGSIb3DQEJ
BDEiBCAzvqaFxTqGNI2TtRqfm2fU3dlNtLFmhQEo9bNLb5BwtjB5BgkqhkiG9w0B
CQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoG
CCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMC
BzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgB3/MUcoohI9+58+Tlk
vAL0XdlGOUEwcUQdIFd2vAI7aAW4D8TcFhVDU7Yui/D+Hmu8lmViJF2+jABYJbzt
a4JG6RfKNsGgWlEmvqFYFLOvQYrsLWTEKujhNTWldAS86NOXClFmYUVomz80OJf+
8qh9RRT1od+7bo6uPQPKdEkiWy0U0YJg0YjbbJfSRb9PgHVnyy1EyqEmeCRsWAp0
EQfA6gt52S4htwQ7iZA4x/OHpj4BJLAttJHpq+SUKWRUe5l4MKyVkuJtCd+2YGFa
CeIDpVkh67nG78yqPsCPwMpWLpPEm5cOIvxpLSCmkpFU9uHxuw9ijqxdZhQCVzRU
q8CK6Jspg3ujgHl3uYi0v0Y5egCPpYXPTuyIKeqZVNHlLK9vNbMwiHBoLEJlAPBt
c5FfbvQiOhbOAD418Hnhc8nWyNN3iD8tB1SX9XZhAJDud+WYk2S1mzRdJne5oXsH
o33ToH6Si+kizo+HHPZWhmVNhzAoYkzuw2Ie6krBHo8HY/U9YYRlRi9qt6AJ3VOD
LDIuKNuMdQWHAJ3Lfi+vsmeAjOVZc6fXUsaPi50eMSsMVJPJjV3+1r42aPWDguVw
PHCTVsO3xmbQakNkBzcaFu6c7m/rEPYWERDCz4r1iv0e2JUQoz5mOQ7HaTqGAqut
CFc/HfNj1zRO3nNmoD75v5d/Tw==

------1852AE4FDE1479EB8EF3900BEB95A59E--


