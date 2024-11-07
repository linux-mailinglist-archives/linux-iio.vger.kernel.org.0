Return-Path: <linux-iio+bounces-12013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559EB9C1237
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 00:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B1A1F23755
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 23:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54F21A4B5;
	Thu,  7 Nov 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S6PrkWjG"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53CD21A4A3;
	Thu,  7 Nov 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020607; cv=fail; b=OUEWmVKWS/V4KKMwVNDsyOLpfMEJgoTMZlqV7tPwitT1AskFxbD4mPhG8dUL0pWu1QMAfL6PU9EWEFuGS1WdDgO2fkXQu8qVO+E40IH18KNeNtmoeh0TiMB5Hhj25bKix+WqZXjeTCmVJIy7XR6UB2V61wSUX77ZfbrIzr3MXdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020607; c=relaxed/simple;
	bh=1o2wdv4gqaWnXskqvSbL+ed4Q5AuNMkgQRffjjHgeMU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rYC6vRE7LdcbFF+8aeuEWCkqJCCAHRam+7wcN2GP5w/zKEcq10w6C24abuYtbkwrW1CuvwJ3GJYAubtBTT20KGdePE4G5l0q8hdzP5Ph5AQ5pDTxBfybTL7JmJnH9Uz3bZdLRqXTFroXobr9+MsguzwgGKLQo0rDgdWz1e83X2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S6PrkWjG; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4jkRzhMOL48P4zKJlB/CNM+7k8Do9JtDFJyStTwuzBQYj7Rs6ZuEqQuJhLlmTkrvKBSuIr98w/tDWuDhlcqRs5kyn5JV+ep94jbXNr3E9CrpTogeR4Om0h4vWa9skcaWk5FtlgL6qV4dhTc8Cp+MntggR980Y5tA593XL6EY7bF5N4NhLHpQ+waZuIlnl1VXg43BJQNPondku2WGOe+RXCpXHitjYrfKoNpM5P0Xxs4NZjSakgATvsPFWiQtTqYqNKFATr+H4cwn2k1ol+qFp7SbaBlznX+J5OOYAZ82NF/PZBjNFVYA9mRPf5GE/lzFgb7uYDd3WOvokzvCHT8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4jpQRHA2wXLqR7H/sC/XWgVEchK+V9PTWhYv9dnidY=;
 b=gTT9On9BVeaRStE2q/VW7hWQ1iTvzx3hn3zv0ww2gG52JAm0WdQhp9iqPd48D0Yy6CR1AgcXZeT99AaAFioO/y5/kILG/hnjPIDLpEJzlAiW79+UahDA4WGSekZ4dC1d79Wog42QHIeF0S4iAzpty/fUTl0dBxqbptESExD5VWAnwj3ARKxIZ+bfUfcbm9ct4V7ET5olEdi+pB2x3BWp5hL7HmY+baBa0EGH4hoKfsdDZ4VCCHA3pdigeFiksM//Z646HGCbrfNKjts34IZGjCqw70XroPYQSIaV5kgNIGqhgCGYPZcDsE4Ym+YcORMZ7ZxQsXf5BXMTq7PGvFWtlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4jpQRHA2wXLqR7H/sC/XWgVEchK+V9PTWhYv9dnidY=;
 b=S6PrkWjGJk2sXr3fmjM6iFCyS/tyC/ZNIrcYxXYgpy2IHI9s9Y0QXsI18D3b9gm9kZxMVc81yYjZb6ZYCerwnZofPz/V9idC/fcPDCrtRGumYvmxFgRglpW9n8uMQ0Enyocx8/3lBnZptxLcjcyGIPBOQceyilnDZUHa52dqExG/Yjw7j9UEQeWzTVp3i177xGC/ueWXddC/RyB8sPuQiTdkyzg3yzpGgYe9O6+NLCV9oTt3S8i5FvnI1IksEaLJuWqoPzioeqFm2XcIVyzcUQJWO89jGD1x/jvUt5yY/fp098mjdlIPfHmPRNrkVvear98Sci7w9wkhW8t7qgwjDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 23:03:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 23:03:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Nov 2024 18:02:28 -0500
Subject: [PATCH 2/3] iio: temperature: Add support for P3T1085
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-p3t1085-v1-2-9a76cb85673f@nxp.com>
References: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
In-Reply-To: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731020590; l=10073;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Sz9Q+6YHuWSvSb3gpsYVOO4SXJ4eqmHsQQa4pS5GzUk=;
 b=lsoTv4hN1Ve8RM+YdWsugsKlVV4t11d86e/xmDqtTx/XXjnpB0MZPuIdogPoVshikHUZSBvVk
 kPTnK070/emAOCCNRMnqdl1DQSn8oBwpJCvHEWk+WJmd6L7h5UyHImV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: c2739906-3d82-42e0-3cb6-08dcff80607b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2VWb3lmb053VlVWMUdwNlBRRzVmeWd4NkhQclFYMjV1VzdJQlF5YWJqdkti?=
 =?utf-8?B?VEczd1ppSTU4SmNTUE1nM2FlcmxhUmhJMm9VMXZwbGxhNGpCblNyMkpwdmF2?=
 =?utf-8?B?UjU4amp3VWF3dG9CcVB1TmkyNGVJWHFsaWdDeWxGYnJjejQvendDZnB1a3Y1?=
 =?utf-8?B?VXl2UDQ3Y3NTR1JtQkVua1pzOW4zOGMxUTJPWjEzSmg5MWM1TUdKTG9wSUtp?=
 =?utf-8?B?NVl6Y0tENEFBKzhwcFdTM08wRXhFUk44Z0xyMEUrdjlRMmhIaHB3U2Uwbkpw?=
 =?utf-8?B?ai95MUk1RUJRMUU2bmwzU0FmdzRqNDNLdDYzMG5LVFRLcEFmR01HQi9LU2Jn?=
 =?utf-8?B?Wi9FZFNDSnZWdHkwWFZvZmsyQ1labG4xd2IvSlJMbzdyRE9nbTZpTnNKTFFs?=
 =?utf-8?B?L1dvSTBFbGJqRDNGdHlneTVnRG9lY0R1RmZMdldxbnVPUkt6Y0JFZjJmZmQz?=
 =?utf-8?B?QmpzU09jNTA3L0wzN3F0cFpoTkhkSzdLc2xQNGEvQ0MwbjNpTVRPOEZoY3Qx?=
 =?utf-8?B?TkZLQ3dGNkI5YkJnbGM1MlJSMVl5YWFlSFM1a1JmbmRENEtrNnE1UnRJcDZx?=
 =?utf-8?B?eWJndkJvNlppMUZUTS9GbVVoZU5GL2JlRTRLY0NLK3lZOXZZNDZhSURmUkV1?=
 =?utf-8?B?bFpTamp1dXJnamxJNWNLQk5uNFo0L3cyTW9JSFh0c2FpU1NRa1R1NFJaSVZX?=
 =?utf-8?B?dlNSMUNtYlhOTlFtbUNHSzFTbnlVVDFla25nNmpyZW94L0U2TU9KQkJXZHQ3?=
 =?utf-8?B?SnEyenl5ZkNvMEZvNGRIS3JiNFR1d0hHQTZDcXI3MEx0aVVCd3lzZjNXLzVI?=
 =?utf-8?B?a0JqWFJRL0l3b3hhYnVWMHRRZXI1OVFZaGxKWWQ1d01aTjBMdXl2dU9GSnJ3?=
 =?utf-8?B?NUJVSzU1M1VtR0hidUtFOGxxbDdtWTNtZzROdG11ZDRmRUxjMEZ4OXp0VndD?=
 =?utf-8?B?cnF1empGejBHNC9GSUViUkZ3aGF2bDJlcFRDSXpmdUdCQ1hpUlpyR1h3UEpa?=
 =?utf-8?B?a1NZWE9SYTJkdHAzUGE1NEl3SzArM1JlVVZHRStieTZ3R1NCVDMvTWJXeWV0?=
 =?utf-8?B?eEN0RkFJUXdVUG9ocTNOamlaTjF1eVpJYmVHREJsY0Q1Y0NTVmk3REo4VUlp?=
 =?utf-8?B?d0llYk9icXA1anRISy9yWEtOMFRnMXBNbzZxWkpmbXdXSnhwK2VuKzBQQkRL?=
 =?utf-8?B?dXR0Y2VaS05EK3FLOHBPRHRVRkcwUmxoUHRuYXIxY1Vra0d5TGtGNHFKRDJ6?=
 =?utf-8?B?bXJ3OXVjTzQ2WHNHUTh6dS8xbXJvZXlIcGMzaXhScmZmRmQxYWUwYlQraHlT?=
 =?utf-8?B?aUZnWmlYQnVqTGk0eW93blQzRndKYkJLZHI5TUp4dXZuK1BHWGs5QXlTby9o?=
 =?utf-8?B?ZmNVa3NnYVBBVDh5ZzFyNzZaREwremNZemxVSCtidDZLYmhsbjVlcHp2bTI3?=
 =?utf-8?B?NFNzNUFmdnlpM2QwOS80NVgrRy9uc2s1cDVNckI5YVEvOGVqNUF4QS9IVzJJ?=
 =?utf-8?B?LzR2N2pESjFpNC81L1RBQU0rYTR0THpyWTdSZ0pENDcvdzlmY0I0Nk9VZnFI?=
 =?utf-8?B?azY3SWdrT215dUlyakw1S0doNmVsRnBYQ1M2aTlkRHhQL2hSR3ZIaUJEb1Rz?=
 =?utf-8?B?SHVxd0FIRVVSTkhMak1xNkFkVVlzdG9Va1RnUTNDMXlYc29hc2NkcnhQVmF6?=
 =?utf-8?B?NW1NSjR0ZUFsZE1kcVMrWEo0MlA3SFlVVWZwTXJyYjFwMmF5V0wwV3lGN3Va?=
 =?utf-8?B?YlhkRytOais2WlNiVVJ3ZGV6QjVQZkV4ZkhqK0FmMi9DNE1CckZGNytkdXJH?=
 =?utf-8?Q?1+DjxyzlBd2eu+1qyBqTiWFyErfOE6LOCq92A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXJmVVF3eXRiYnNlSU9Tam16dktvR2gxbUU3Vmw1L0ZadnlselpkTHFweEd2?=
 =?utf-8?B?RG5HQVV3d09mQWVqUDBBUUc2YWZJVXVpMlBJZUo2bzNzN0pid0RZWHNaa1E0?=
 =?utf-8?B?TFQ3NHFMZE5hSWJOOGJmaGtTdDBnZ0kzNkl4TitONy8yd3pzdWgrOEJ2VUoy?=
 =?utf-8?B?Y2RIOFpjMlVGTHRMcUkxU3ZDaFFOOExyMFE3VUEvTFB2Smw4azB4UEZUdW8r?=
 =?utf-8?B?Wks1dGNMUFNhc1JTRkt1dENISjBsZytIMzJOMWNtdklJaC9Pck1VZGZWSXAx?=
 =?utf-8?B?UHhVZFJQUkpDemRwMDUrRno5VHZGb09QVFBvMGxSRG1zcWRkUjJjbG9WeEho?=
 =?utf-8?B?UTIvbWl5QmNBeDNyem03Tm9jZEVLbCtnVEVMYnUrTUlSQU1QTTlnSWZZTWZX?=
 =?utf-8?B?YTFqdW1rT2s2cWRqU0RmVW9WdGdQMGdzMEFNT1lnVE1JdDNydVJ6aFJTOEFs?=
 =?utf-8?B?NDVWL3I2a0hiS2RMaEMrT1VBUEo5NTJWMjJodkZ1dDJOT0lDN1RqZTR3SjF1?=
 =?utf-8?B?aTY5L0hGMWF2ampRRHhEdWhXYVpJR2ZuTjZONUxyb2pQS05LQVBtSUI4bXlx?=
 =?utf-8?B?TUprVm5BWWRMNk9oSUhudTU3SVF6SUhPMTVWMys4cElqQzkyWWs3R2l2SC9E?=
 =?utf-8?B?cVBmL0lNWHdFMzhkdUJhb0dqSkNyZk82SGJPME1rNkM0bHk5UytqTjdpTWpI?=
 =?utf-8?B?MUkxQndpU3Y5a041QW9YS3FGclZmYUZpZGgvYlN5OWxMQVZDWEhvcWU3MjNh?=
 =?utf-8?B?QUgxOCtlVGdxc1BBbkl0QmRiUEcwT1NmamZLVnArSVdRNXMrNmtGM1QxM0Fi?=
 =?utf-8?B?TmxEbmpielpDVHI2S0V3a0NucURFUEZ6RDVHWTBQQStXVjBwYzVVTjkwNy8r?=
 =?utf-8?B?WXQxSkNYV0d0MjhjbndGSitFcWw3S2lSQmVtSkpycGNJU2ZwQ3huQjVjVFBh?=
 =?utf-8?B?L2NBMUJYcWNPY1l4WHJFTDB6MzVNVUR0dUtpL1ZvTUFieXZ3Z3ZHd3dZdnZ6?=
 =?utf-8?B?VXpsZlJEdFdzczZmQi9OWUFJVnEvLzMxM2Rnbis2UmcwYlB4RHZBYVcwRXVu?=
 =?utf-8?B?dXAxVCtPTnkwdUcvbzg5S0tvTHdaaEVEQWNGSTlZNUw5Vmc1RzVYdWVCUzNl?=
 =?utf-8?B?T01FNktMVzh3RDRZcE1zS1BWbVF2Slh2QktLb2NudnJBQllOeklGc2hUMXUw?=
 =?utf-8?B?Zm9DVlRobjA1RG1BZERsQzRGQU5ET2wrbjIxOG5JMDV6Z0xmejQyWVhYelN0?=
 =?utf-8?B?V1ZNamNlV2QzN29yZ3JrK3VOSzRnNXRrMitIVTdUY3Q4ZElsazJCY1dpMmJ1?=
 =?utf-8?B?bFM0OTZ4UHFURW55UlFxZ2xYT3N3SnVhcVRoZDBTMEozaXBOSElwYWtQVnUw?=
 =?utf-8?B?aTZMWDZHeW10QjdwbUVSK1AyK2xaa1kwY0NjK3Z2ck52alRvaEoxZWZxM1Zp?=
 =?utf-8?B?TjFTSTY4ajFEZENRbVh0anBNSFdVcjJEbTQxTGMvc3B3dE5LQ3hHdUp4Y2Z6?=
 =?utf-8?B?QW9LSXQ5cGRtS1o1YVZsSU9rRzRzTjlEam9RS0xHbkJESXVvMW5seFIvK0VM?=
 =?utf-8?B?NU9rUjRmcHFlTGtrbHViSE8zN21mZy93cDFucHJaTFJEcjdVNjdoaG9BaEF3?=
 =?utf-8?B?MENtK3JKVW91OFhyUjJnNEdQVzhGSGZGeVNYdXJpbkRNWkxyUjBKcFJJaHQv?=
 =?utf-8?B?Tk5iNHA0TnNvTVVoSzFsR0pneGVzMExjWjU4ayt6cWdleEY3Znpaamk4SUw5?=
 =?utf-8?B?WjJKSEhkakZZYTZESEozSTJsVVFpS28wL0hlM0RLa003VkZCYm5yWFVXalVR?=
 =?utf-8?B?UWY4blZOc3lPc2NLVEpkQUpnbHpqb0NTTVpNUTdtSjZ6YmZ6cU92MWxaNkRH?=
 =?utf-8?B?dDk4aUxJUFlsSU9ydy9YaVBGdGFWMGRlMXdscUE4dEltZHluT0YrSTdLSmIz?=
 =?utf-8?B?dklVRDI2c0cvL2gvK1lobEtIWDV0VTljaUFvbWVwUUdlamo2ODBMRmxSRUNS?=
 =?utf-8?B?YkZJTitQUVpLTlRHZkhtaFdjSkdKdkplK2VKNm9nYXlHT3NpUmRjbUQ2NW55?=
 =?utf-8?B?UEFidVhmK3FRWXI4R01xZ1VrVmp3U2tYVWR1R1NEejB0ZXR6S3NBdkFWQWlS?=
 =?utf-8?Q?kC57UdmuLjMrtPiY0b7h8DQNb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2739906-3d82-42e0-3cb6-08dcff80607b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 23:03:22.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRVPMWvdlKcQ9n88JbbK4CHqeu2weYlzlkvBxSnMPdfXa1BdQHMRDIfQmbSCoy2eEvZpbQD/Nhe7Rp896hrFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851

From: Carlos Song <carlos.song@nxp.com>

Add basic function support for P3T1085 temperature sensor.

P3T1085UK is a temperature-to-digital converter with a -40 °C to +125 °C
range. The device can be communicated by a controller via the 2-wire serial
I3C (up to 12.5 MHz) and I2C (up to 3.4 MHz) interface.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/temperature/Kconfig            |  1 +
 drivers/iio/temperature/Makefile           |  2 +
 drivers/iio/temperature/p3t/Kconfig        | 29 +++++++++++
 drivers/iio/temperature/p3t/Makefile       |  5 ++
 drivers/iio/temperature/p3t/p3t1085.h      | 31 ++++++++++++
 drivers/iio/temperature/p3t/p3t1085_core.c | 79 ++++++++++++++++++++++++++++++
 drivers/iio/temperature/p3t/p3t1085_i2c.c  | 68 +++++++++++++++++++++++++
 drivers/iio/temperature/p3t/p3t1085_i3c.c  | 59 ++++++++++++++++++++++
 8 files changed, 274 insertions(+)

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 1244d8e17d504..7cdd49279aba2 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -182,4 +182,5 @@ config MCP9600
 	  This driver can also be built as a module. If so, the module
 	  will be called mcp9600.
 
+source "drivers/iio/temperature/p3t/Kconfig"
 endmenu
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 07d6e65709f7f..d5e89c20d58b6 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -19,3 +19,5 @@ obj-$(CONFIG_TMP007) += tmp007.o
 obj-$(CONFIG_TMP117) += tmp117.o
 obj-$(CONFIG_TSYS01) += tsys01.o
 obj-$(CONFIG_TSYS02D) += tsys02d.o
+
+obj-y += p3t/
diff --git a/drivers/iio/temperature/p3t/Kconfig b/drivers/iio/temperature/p3t/Kconfig
new file mode 100644
index 0000000000000..09e925024b66f
--- /dev/null
+++ b/drivers/iio/temperature/p3t/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config IIO_P3T1085
+	tristate
+	depends on (I2C || I3C)
+
+config IIO_P3T1085_I2C
+	tristate "NXP P3T1085 temperature sensor I2C driver"
+	depends on I2C
+	select IIO_P3T1085
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for NXP P3T1085 I2C temperature
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called p3t1085_i2c
+
+config IIO_P3T1085_I3C
+	tristate "NXP P3T1085 temperature sensor I3C driver"
+	depends on I3C
+	select IIO_P3T1085
+	select REGMAP_I3C
+	help
+	  Say yes here to build support for NXP P3T1085 I3C temperature
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called p3t1085_i3c
diff --git a/drivers/iio/temperature/p3t/Makefile b/drivers/iio/temperature/p3t/Makefile
new file mode 100644
index 0000000000000..21aaeb51e044d
--- /dev/null
+++ b/drivers/iio/temperature/p3t/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_IIO_P3T1085) += p3t1085_core.o
+obj-$(CONFIG_IIO_P3T1085_I2C) += p3t1085_i2c.o
+obj-$(CONFIG_IIO_P3T1085_I3C) += p3t1085_i3c.o
diff --git a/drivers/iio/temperature/p3t/p3t1085.h b/drivers/iio/temperature/p3t/p3t1085.h
new file mode 100644
index 0000000000000..b018a04e4aee4
--- /dev/null
+++ b/drivers/iio/temperature/p3t/p3t1085.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP P3T1085 Temperature Sensor Driver
+ *
+ * Copyright 2024 NXP
+ */
+#ifndef P3T1085_H
+#define P3T1085_H
+
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+
+#define P3T1085_REG_TEMP		0x0
+#define P3T1085_REG_CFGR		0x1
+#define P3T1085_REG_HIGH_LIM		0x2
+#define P3T1085_REG_LOW_LIM		0x3
+
+#define P3T1085_RESOLUTION_10UC		62500
+
+enum p3t1085_hw_id {
+	P3T1085_ID,
+};
+
+struct p3t1085_data {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+int p3t1085_probe(struct device *dev, int irq, int hw_id, struct regmap *regmap);
+
+#endif /* P3T1085_H */
diff --git a/drivers/iio/temperature/p3t/p3t1085_core.c b/drivers/iio/temperature/p3t/p3t1085_core.c
new file mode 100644
index 0000000000000..4b00e606a6d04
--- /dev/null
+++ b/drivers/iio/temperature/p3t/p3t1085_core.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP P3T1085 Temperature Sensor Driver
+ *
+ * Copyright 2024 NXP
+ */
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include "p3t1085.h"
+
+static int p3t1085_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long mask)
+{
+	struct p3t1085_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(data->regmap, P3T1085_REG_TEMP, val);
+		if (ret < 0) {
+			dev_err(data->dev, "failed to read temperature register\n");
+			return ret;
+		}
+		*val = *val >> 4;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec p3t1085_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+};
+
+static const struct iio_info p3t1085_info = {
+	.read_raw = p3t1085_read_raw,
+};
+
+int p3t1085_probe(struct device *dev, int irq, int hw_id, struct regmap *regmap)
+{
+	struct p3t1085_data *data;
+	struct iio_dev *iio_dev;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(iio_dev);
+	data->dev = dev;
+	data->regmap = regmap;
+
+	iio_dev->name = "p3t1085";
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->info = &p3t1085_info;
+
+	iio_dev->channels = p3t1085_channels;
+	iio_dev->num_channels = ARRAY_SIZE(p3t1085_channels);
+
+	return devm_iio_device_register(dev, iio_dev);
+}
+EXPORT_SYMBOL_NS(p3t1085_probe, IIO_P3T1085);
+
+MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
+MODULE_DESCRIPTION("NXP P3T1085 driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/temperature/p3t/p3t1085_i2c.c b/drivers/iio/temperature/p3t/p3t1085_i2c.c
new file mode 100644
index 0000000000000..20e5f7a68dd9e
--- /dev/null
+++ b/drivers/iio/temperature/p3t/p3t1085_i2c.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP P3T1085 Temperature Sensor Driver
+ *
+ * Copyright 2024 NXP
+ */
+
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "p3t1085.h"
+
+static const struct regmap_config p3t1085_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+};
+
+static int p3t1085_i2c_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id;
+	struct regmap *regmap;
+	int ret;
+
+	id = i2c_client_get_device_id(client);
+	if (!id)
+		return -EINVAL;
+
+	regmap = devm_regmap_init_i2c(client, &p3t1085_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
+
+	ret = p3t1085_probe(&client->dev, client->irq, id->driver_data, regmap);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to probe\n");
+
+	return 0;
+}
+
+static const struct of_device_id p3t1085_i2c_of_match[] = {
+	{ .compatible = "nxp,p3t1085", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, p3t1085_i2c_of_match);
+
+static const struct i2c_device_id p3t1085_i2c_id_table[] = {
+	{ "p3t1085", P3T1085_ID },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, p3t1085_i2c_id_table);
+
+static struct i2c_driver p3t1085_driver = {
+	.driver = {
+		.name = "p3t1085_i2c",
+		.of_match_table = p3t1085_i2c_of_match,
+	},
+	.probe = p3t1085_i2c_probe,
+	.id_table = p3t1085_i2c_id_table,
+};
+module_i2c_driver(p3t1085_driver);
+
+MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
+MODULE_DESCRIPTION("NXP P3T1085 i2c driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_P3T1085);
diff --git a/drivers/iio/temperature/p3t/p3t1085_i3c.c b/drivers/iio/temperature/p3t/p3t1085_i3c.c
new file mode 100644
index 0000000000000..0007d79aa0a6d
--- /dev/null
+++ b/drivers/iio/temperature/p3t/p3t1085_i3c.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP P3T1085 Temperature Sensor Driver
+ *
+ * Copyright 2024 NXP
+ */
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "p3t1085.h"
+
+static const struct i3c_device_id p3t1085_i3c_ids[] = {
+	I3C_DEVICE(0x011B, 0x1529, (void *)P3T1085_ID),
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(i3c, p3t1085_i3c_ids);
+
+static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
+{
+	const struct regmap_config p3t1085_i3c_regmap_config = {
+		.reg_bits = 8,
+		.val_bits = 16,
+	};
+	int ret;
+
+	const struct i3c_device_id *id = i3c_device_match_id(i3cdev,
+							    p3t1085_i3c_ids);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &p3t1085_i3c_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	ret = p3t1085_probe(&i3cdev->dev, 0, (uintptr_t)id->data, regmap);
+	if (ret)
+		return dev_err_probe(&i3cdev->dev, ret, "Failed to probe\n");
+
+	return 0;
+}
+
+static struct i3c_driver p3t1085_driver = {
+	.driver = {
+		.name = "p3t1085_i3c",
+	},
+	.probe = p3t1085_i3c_probe,
+	.id_table = p3t1085_i3c_ids,
+};
+module_i3c_driver(p3t1085_driver);
+
+MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
+MODULE_DESCRIPTION("NXP p3t1085 i3c driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_P3T1085);

-- 
2.34.1


