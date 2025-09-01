Return-Path: <linux-iio+bounces-23580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F1B3E653
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254493AE2C9
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F66D31A55B;
	Mon,  1 Sep 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="m7266iaq"
X-Original-To: linux-iio@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013015.outbound.protection.outlook.com [40.107.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC06338F45;
	Mon,  1 Sep 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735065; cv=fail; b=QWiBhsF25eETh6z7wGSO09bpxTsbhjcDICoauojyFJly0wNv1FDARefLkTkIbZvJQBaBM2lmDFFkDEYXS916e6OFxcGUdLLBI6gnlwWQXYXEb+8dA0zqUUw5poIe0xRT41LS5Pv55ju6bib4gokDCUMP6f5Oab6R6tvrh0IqLx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735065; c=relaxed/simple;
	bh=qrUdEzRTBZ/8rB5nom9+ISGq1ND/IbE0zz9qmu6R6wA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QOfflh57FMWkSgsfCbnpeCdgXgYBsGy+MWwGqqCV7BhO6I0x1/wp9LC2qB+mkz8kF0gNTQkTh2P/F1QG8n9CJafG3RhY30ULVteO5I3/BkX3bzM6omXqFNqBEooKFWVcGGaoPOg923eV9Pct8DHCVVNSOpjc67yA77/wISdwhk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=m7266iaq; arc=fail smtp.client-ip=40.107.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImQjeWY8Ek9+rAosNYe7WvAwmwOMPw0jFL3Miu/bLZpPVcmzI9BAfF7h3A/4mtiPM+GVuOr9uub8VDcfTVrqwgdQ/TW8UaBmieiqcnDQ13hfreAotulTPyg2xogy723Hjymzk7+1D8SX9HwQdRKZ2SIIRmijceFLHUrPFyNojqiYwx5hhynWA6kuN8AALrOVTi3rHNnQ5cJ6iS/qI1O8teG86nXA/SpnoGupbK2j2Uxg3F16W0OlVokaTKntRt9Qyu5y5s8t+7S+RMmd2OhmcSXyzsmIshJiGgED1zPHuVZE/LWmj/vgb0JtxhyQQNuC+L2wBVMqwjL5QsAmoFzl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV8RtFFCm8nmLGLaCR6Pmwi7JBsOOVX48lyVi7pE7nE=;
 b=G3vTIo0eebQQksP1dYytY8zOv2KJUPoRGe4pAcq48VHUVgcmw9kZCLowYJUjADQpn0O+kBBbzzfQ+6KiV9aeOfu/zSCbdBXK0jEvkOoE1zU+tYCwQGRARo6Z6Wr5h4lOYSxgr2KA8UOPnCILUqVezaHOaG2tlNnOQbFIc6cvNnJdVdrceNdJCxSjc4zskxiiIiRHeOO7GVihj5lBpm/ZZIV0WPcRSHiKctHJ7BcZ6jg/sjxUtE3yMqEAMngbKUCE3tTM9VvP5xIU1cJVqUsMlHjQcmau1UbtF+uNM9d0BtP31Ratuo0gu+ECDJ4B2WrM7/RAJdAmD4nr/4xJKqKJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV8RtFFCm8nmLGLaCR6Pmwi7JBsOOVX48lyVi7pE7nE=;
 b=m7266iaqWV8frP9W4lb+KasYiRiXgalkAYBzTcos+hlm0Tf2sCGWDkj4jm+CtsZvULeOuU72quufg1BWI32LOvyCZhBULHE7YqO0rYCDL0YWUytakT39tfvVTLU2VR7SywFlM4yHmMgoyePZ6PkBVc/1lkbDUvabDU9jKAucfB2lheZfjZX2Hc2OoHK8bXUDb5hkOByDzdIQiTVMBz4UYXem4uh/9tmFtgOB+GXFEvm8sSbVniXMp0q517CiZmuQkRV+aBC/wwRanR0zZlUIZu45RemmEsi8Rmw9efKsFw3oxncVh2NgVnZklh6nHAtPApfMcJqc1i8EO+qIb00K3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5742.apcprd06.prod.outlook.com (2603:1096:101:ba::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.26; Mon, 1 Sep 2025 13:57:37 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 13:57:37 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2 0/2] iio: use int type to store negative error codes
Date: Mon,  1 Sep 2025 21:57:24 +0800
Message-Id: <20250901135726.17601-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::18) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e9810c-9790-4f58-59b2-08dde95f823a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fIhsnCMCkclVPw6K3Le41ophHbAIyFj+Qq9yrPVe0veBq6YvFH7iuISPUSSh?=
 =?us-ascii?Q?N3ksoDq3+hQCQO1mMZI00EBu20qkz34QHCPZqONTJdgXLy5aySjaLcvVKJJ4?=
 =?us-ascii?Q?ouRMTFNRn6Wg8VCSenGvGCcMT2O948Tz3gIid+R18TN5tmWFlcke2g8ztyA+?=
 =?us-ascii?Q?pVXdmez0gmeM4l77UyVKjQoZuPeDunHNx7mWEthc4ScsRkRw/72K+oJx8hb9?=
 =?us-ascii?Q?5dwW5713naMtqdHkOfKftP+EBmYjaC5wVsYpKezYWrKjmnaw7s9Je3QefWpN?=
 =?us-ascii?Q?thAt9AKcQqlMm4lDOkT/pRN0kBjQ+1W3r4huRF0cBBi1spFX2BdifX12DJac?=
 =?us-ascii?Q?FarYPkCFawXQ7u3AFYybP8c0Dak3rxboJxflM+YpJxfKN3gj5fJN3qhX7KVs?=
 =?us-ascii?Q?+GXLgHGeKnjtXVqjViG/PmGBe2mvU41X0LAcZgbuCRjjttY4j9/TgxHwx4CU?=
 =?us-ascii?Q?RAiGmtG4AGEnZo3G4wQLnyK84Sk8QUXr8no9zTBBjlHIkC2uj5gFDFJEYhdn?=
 =?us-ascii?Q?X9arXB2+0XynBogzLSPB58VTBamO776qSIqnH4UOLMR1ey48aUzTidk1piuc?=
 =?us-ascii?Q?ZZAJkZL8p9NgBTIt/+uquiFZZooqkkByhExe8GNQ7wQYQ92mZu6+kcWFToRq?=
 =?us-ascii?Q?H0PQ9F8mE38TQHu6dcWiRTSDB4ZnreBsKxH4QkP8dCol2wGKezBa5BvGhnb8?=
 =?us-ascii?Q?R3nmKb8qPxDVD7twbBJEZ5SVEgd7IjdPeh2OFltE1TIOic2gwuhWxVfJFItl?=
 =?us-ascii?Q?bNiYH7ubH5yJEKHvcNePBpiB/zml39QLmCcWDFDUQI4h11PXO7hliUkMiu4S?=
 =?us-ascii?Q?RPnoHKUStggSWz3sCTRKOqM2x4F/+MyPup/matLUq+Qes/v9mMR2s4AU7DeP?=
 =?us-ascii?Q?grYrLn/jbVEq7grF3HTRflxibdNn9HzN3W2LRDa4FqUk5X6UjF8tTDOFfrbE?=
 =?us-ascii?Q?V5sKfsaVJZ4nNk5Dp0oI6ZiV5f7lWdhrT7uRsSKF/YlxJNFEYRsZItrD59/6?=
 =?us-ascii?Q?C3wTf605mVFdpCW6ZIgEg6NTaDS8gBglW9ttzi6OthW/V/hM9NRMg8yLV9pF?=
 =?us-ascii?Q?acBmymyvsfUGhA51BAgu9s3fj6KHb+q+LrmKXNWtAAA+6iBGLJl+5aRgiI+4?=
 =?us-ascii?Q?1SVOTbC9yihqPP31umxaNkUuassi6ayqjvJ9za8pf9CIGTx+7dl5AcLqa+QY?=
 =?us-ascii?Q?Gbg6NKga7iph5HSZV68Lj9D2uw54z2JfBKRyRzNLF7rnrpAq6y6rcMbeoNXP?=
 =?us-ascii?Q?kWkP1euwOjzX39Qe7Vdnv3woMlNWtPmCiH1qPqI0kk/d3ZWgqtJEQtISAbUi?=
 =?us-ascii?Q?/6xmMllnNbifezw7uRXxElu21BEBD8pSFgasQnqrB6U5Ug8Uthqf7aXqnBYT?=
 =?us-ascii?Q?992RgvSwtGDhrqvYgqquicuXIkMXHIYWlk8RIBkJ6YHMqUA+P2akmj2ULpCG?=
 =?us-ascii?Q?r5v25hcAPqUQDchRYWlCLYcQU+SVJMurToJAlgfnoqHaiosda0PxJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5ilLodsLqLbMS9C/3qDCrQeu1+BLbgnHApnQ4CnxqtilKK3JH+9GtbUxdPh?=
 =?us-ascii?Q?gKsNSWL0LUxoxOba2VkgK1UJFgWPKSrTW90FEbM9UFzjxD/aLyiyHjEJl6/G?=
 =?us-ascii?Q?ziybzrULwuvKVPcTVrnhtKcdjoFArqQpf/qs6U0Z/8Ae05blErvVrDFUxgwG?=
 =?us-ascii?Q?z4I7UAU5iKwa62Lj16cYFtUKhjR/y1vOY8oPTLGCe5n3Zr/u+HGuQLCd8Ssi?=
 =?us-ascii?Q?L8CHtpepMPMLJ1yvDaJ/XC6GuyxEKW3pucrrXu6xIx/2ctjdHCNghUO/ptUe?=
 =?us-ascii?Q?66IeffT9ppLqMRqt8m8kqrs+9uG4pNoZfniXV9xU4oAfc4T531Y7NgdTD6CD?=
 =?us-ascii?Q?1l/K1xjylLdzStcyuvOI+9MgcWx+Mkg8zal59HqXJUDlvRPmF7Z13KWWOFkO?=
 =?us-ascii?Q?l0REInXCnhBU2TN0moY/3jxS9sRCVedhSuMeNN3Jx1GPcjd2O2vYeJM9QEgC?=
 =?us-ascii?Q?xSkYVA4PmZHGtFVFq0ykyiC85wCATzPUXp9bmFQhek07qnn1vrJgXzHPxdOp?=
 =?us-ascii?Q?MxXWBguTrV7ROm/groD1K1694RzsA+HxZzCPsAJrhCzqcPKGT6e1jrdP35oL?=
 =?us-ascii?Q?ivSBSLMdKBrlpndNJZOwuzt60e5F4xVRCQ4SRJwYV6iTJqiLBZzq+f3KEQj1?=
 =?us-ascii?Q?O/zbZFhg7zgirZG9nLoQbOs6sfs4whl+ziSr4UfyES3EdtNLpKZnNVbF+F37?=
 =?us-ascii?Q?JAg3vk54ALDK1wSJl1LUJI0DtABEb+T24L1ubjukSWE/SsorC/MqFIkEYSzl?=
 =?us-ascii?Q?2meX1J7ER7M4TtGZpcD53XgKoapP2mE+mvz/m424/QjJIWHlqhd1PnvAMVVy?=
 =?us-ascii?Q?on7wYVeZxcPhRwtpeSirBZMD6Az1MTBaMXpQ2VNh9sdEBgHuhftEEtGPmD+K?=
 =?us-ascii?Q?FhPwMHgl041D+oawRq+Z4AtqUI90gbJg1PpUOAdz2hFPJ4KHwOHouH/R6kI1?=
 =?us-ascii?Q?kAWL9tIRviQVbrxU3IcfoVMuCMvBX/WAFapn5mV7EyC6hMZV6uPnUMffiZNG?=
 =?us-ascii?Q?IJJLh33XJC65B4Zrfy007QYlKfWgZDfHBks/bXFM9+/M5B0s4LiYTavQSNx7?=
 =?us-ascii?Q?kRpehmGgYFJ6TXuWGVDr+KGSXnw0KVJfBfPuIf/7SEfXndjqnCUV0sCWaeJk?=
 =?us-ascii?Q?y1Z9bVsq/QNy6XA99wbdqykmUKPDgyTeZ3PUZ/0C9v2n9AsUwKmLc+arCDk6?=
 =?us-ascii?Q?C5C3sNlRj7kCFyEFfz1OxYEyj3o/yXR5PCqMKylTooDRzc5thqE0+P+z9hIC?=
 =?us-ascii?Q?di/iPPqHnh6uo37jr4mXv15yTs+D+ZHKAjTCsTeN/TO3qihg2ljzChEz7/B3?=
 =?us-ascii?Q?vJnp79sCs1WA4mXrni3jmYWr+V7XtDj2EaSvItZ+0E8mnm48e8BtSCkoVkJr?=
 =?us-ascii?Q?e6fAMcRnSaH9N4SgZnpeE4U8JDwdSOf8AW5BrJ2/tZfmiftETu5GCAmOkn58?=
 =?us-ascii?Q?w+emPnHvH1yRjQ/3LkTkAg/lm6UbJysgSTTwBpSsG6h89Uf7xlq9Q1bqmMlg?=
 =?us-ascii?Q?om/35ch8SysKNAFXJhnJTVoHhFGIqb6Yy75tuvlrU5Ht2hv/0mhxWjyazxm0?=
 =?us-ascii?Q?VCMyTsxIp75xFnXpiTNrRhTorD0/laaU3Gx7xBQs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e9810c-9790-4f58-59b2-08dde95f823a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:57:37.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVnK/8OfTgCbi1vTvFMPOBD+KlNJdPRLS0miGmm2Yq7wZeS62o4mwXbUjz4YvNbxeV81DBh4ioJChJxkcdUcUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5742

Use int instead of unsigned int for 'ret' variable in ad5360_update_ctrl()
and ad5421_update_ctrl() to store negative error codes or zero returned by
other functions.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Split each driver into a separate patch.
---
Qianfeng Rong (2):
  iio: dac: ad5360: use int type to store negative error codes
  iio: dac: ad5421: use int type to store negative error codes

 drivers/iio/dac/ad5360.c | 2 +-
 drivers/iio/dac/ad5421.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


