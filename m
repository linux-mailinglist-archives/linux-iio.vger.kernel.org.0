Return-Path: <linux-iio+bounces-26665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA9C9E799
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 10:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020543A8D26
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F12DE1FA;
	Wed,  3 Dec 2025 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="OxSHb2Ut"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021097.outbound.protection.outlook.com [40.107.130.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0F2DCF7D;
	Wed,  3 Dec 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754134; cv=fail; b=dWi1cjxWPQTL+lpy+WaVj5LxRBxuZyVmBo2NPojkkUd0zxteY4cECk9ZKBdJeZnR/JoKdmmGLubBy5QdS5cpVt0ToZNWa9O/QfUjUTx5PV0yU3VRANt+pG/AnyUAfXDjQ4Yyae7wIjd7lj99fqTfbs33q+ZG59Bll/KBlf22F6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754134; c=relaxed/simple;
	bh=FQNGN1BUw/BprjlQxMcNu/FpdcNqVfmCQscdaUNRQtE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dtXdm/gQWw7MqksVjLI2dq3Yp/+Dz/hcB+S5YscXUTsFViBF/dtpAExNHlFgH5jz5He/gjnmKFrKyUq3w66wuWSQZSfk8FwyOnoEj6X8QMIK8zBVFxZESYu7c0Y7rSoQlgOMkRyRCrhVZxDuVpFutkf+WZXtaldPTOcOgL03y1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=OxSHb2Ut; arc=fail smtp.client-ip=40.107.130.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIe11lZot2v1wC+s55RCC3PXNYt+/pdYoxJino/mZDVM98OwjCfiUAcOa/IyMrm7jlX5+BOrVeq74tDXVbuZKn4qpnOXD/C08X+M9VemHfnDm23KzcZL2GJ1XhN7leOA6j9Wq0Vn1OAPNTfoCyKXFaoSp/iQXunKg5THUkpY4mG2Ig19FPuht3wGZso3s6vwcOFzcCD50XSOu7vgB2M1r5mcpfZD/85Jvnw21J3di4S9SveEYyGaWGnSh4K+SBejt5QsiImoNJjmgW8YWt7lkukVRdDOy/x9Htv+vif4gJC9niLp8FdD3YkYs8zJmjztUzQoGV+UgomwsbISRmsqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XptgQHBhJedgBkA/tUZRNlaHQSyBzzrOMheWMggacw=;
 b=oOq6abAQWHUUJt/jvWwgz4fO1MGnCIbJgyq8x7ZnI3+8foukSSL17uuSirU4ipt1zhthFoSv2xTgqejRc3EWqBqvGulXjz1gaHl+6MHF93bLM/N3sMMH2ccsGbxrpUFb61j8qiIp2LNtHo3lHi7YVgcfbqn/nZjf7b+fgQSGIEWmb4KH5Qtl3fXAxZ7FM39NnONrJxnL0SMU4kdn83/BIVq/qtI/tiwGOwoUP+OQfLL5nVoOrUrNZ4HMD7SjA+BIWuQBnUG2gTQxOTNEuTHUqed+p5Z+Ww+vPiClXZKmnmGeFTWF/TrNAQ6gJXt5DVOMtxWbvzkW0sNp6kn9v4wc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XptgQHBhJedgBkA/tUZRNlaHQSyBzzrOMheWMggacw=;
 b=OxSHb2UtC1MK4M9xhRe8U7IxyhE2j3ScJBwIDhCX8aWCjQ5+bKQZAuL33Pmzn0RUHTbx8JrmCfCtzHO/5BX66Gl7ue9Ic/YvYWSsofVgCBASLYrEUrgZlmp2kPEd4rX/q1lwy3n3R34NnL22yJT2xDZuO4zlBiMgfTgmuVVgMMGJPeqUNW4QOgG9f8MxTGR/728Hc0AVg/ozbJdPAEF0cPgLh7q5leEm6nQfPwd4KgvRk1nIWziVM5USFmdCqPirv+hcoPfpQdAYIp9Z551juk3dxkbPZXrY8Esij9DK6Xps1O8hsbl0z16/rWd3TsAuIwzN6/pZoxk53mi2CeCGRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PAXPR06MB7422.eurprd06.prod.outlook.com (2603:10a6:102:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 09:28:41 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:28:41 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 03 Dec 2025 09:28:11 +0000
Subject: [PATCH v3 1/2] iio: adc: ad9467: fix ad9434 vref mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251203-ad9434-fixes-v3-1-38d14f28456f@vaisala.com>
References: <20251203-ad9434-fixes-v3-0-38d14f28456f@vaisala.com>
In-Reply-To: <20251203-ad9434-fixes-v3-0-38d14f28456f@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764754120; l=1065;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=FQNGN1BUw/BprjlQxMcNu/FpdcNqVfmCQscdaUNRQtE=;
 b=BdXvgx9RJ+u1pc9IYjCLDHQWpVMl0OuD//HGkoXUt5eOc3/zeUGERZDr3iawujdjkEc/R/2QY
 7A5pUyaiTMtAFgNtEKn+5mMo2WkItXXifmgcU7MOrrVQzHLmvfUx0DY
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF00011B53.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:d) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PAXPR06MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9ce124-8d10-4c62-0e10-08de324e5937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVZnOXNrQ1o5dUluaXgvZWREY3dRUnh5UVB4LzcvNHIzNHhxelNGL0JWWHFQ?=
 =?utf-8?B?K1F5QzNTMW54VDNZbmRmMzBIbzk5V3FqMmFJQ3QwT05ZdWxXNGhPNHMva242?=
 =?utf-8?B?citxODBPUm5IV292VVlwMmJ6bmxDc3Z3TEpzbnpmM0V0TmdJYVg3N1dHZHhl?=
 =?utf-8?B?R2prdEFBSC9ZV2VtSDVCNHlPcFdVeDZXbnZYNVZyR0JLbVAwTGYyd092aWJK?=
 =?utf-8?B?ekRsTlNyd0VsTmR0cHcxQW90RjNjMmgyeHprWjJhVkF0ZFNxRW43bDhISUhp?=
 =?utf-8?B?dkJ5WCs2S3FFQlYwbVgvdUFpbFNKdk5GbWkyZE9ib1BNM29KL3VqcTNUU0Vu?=
 =?utf-8?B?S2NJNHhEYXJQZXNSNGdobnBMeGNISVBFK1A1WWlSSCttejRMdnppZ0tHUlUy?=
 =?utf-8?B?L2RwaEdKbjNZenZUQzBUZW5rRG8vdDg0UEdWU2kwZm9vdVY0a05MdzJFd1l4?=
 =?utf-8?B?b29iRE9JbnNjVmMxWTBPZVpwMGJnTFRSWm1NS2IxdE5uMkd5ZG9TZ2FEWXlo?=
 =?utf-8?B?eUJYVGxCV1MrdFZOK2draEQ2dmpBQ3FidE1SeU52WWhjMnNveWFWR2JXdXlh?=
 =?utf-8?B?d21rNlNLS2NQVXRoays5eTlqSkI0a2x1L2lvMXZsc0xvQ0t6bVl5MU9sUGd2?=
 =?utf-8?B?c2RQN3MxdUhMWndTa2d4ZjRVQU93Y2dMamFxTXI5NUQ0QVlDQmlrd0dYRlJ0?=
 =?utf-8?B?TXlyNThzUXdEQkVPaWFpR1RBeWxjaTZhc1JuR3h1d1g4Z25pTVUwQ2xGbkNI?=
 =?utf-8?B?MFpqNE5DVHhNMnd5ZkNXbVV5ZGdoRFhoVG4wN1BNMUE3eVhVaDhla1BDVDFX?=
 =?utf-8?B?WUJPVHQwSFo3VTY1MnU4UDZzMHdOWTVyRHJJOFJmVXlkVEV5TnZNMTVsY3F6?=
 =?utf-8?B?cDNrQlM5KzBobWZ3ejBqM0E4c1dNNEYxakpQQTBKK2lKL3BZanJLcStiazNZ?=
 =?utf-8?B?aC9qK0VjeVJIV002b2FYVGNhOGNtTDJYNndzZ2ppamtpOHpJdC92aTZkb3JU?=
 =?utf-8?B?bnJwcmRqb2pET2txOEExVmVtNC9wWmY1elczY0NKN1V1VHU1YUdvdDJpeTNq?=
 =?utf-8?B?U09JZE0vTDVpOFVsMWJvSTFnL0QyMkhPaUpqZXVqaXNJTU1hSE5tYUJCRlNF?=
 =?utf-8?B?cG5qZWdyNkMwUk9kUTlhOFNPSUtvYmpSd1BjWGptVU85V09qTkxaU2ZrUk9S?=
 =?utf-8?B?V1hjTFR5L3B0azV3Y3dKK253YTVQRkIzRlQzWE1KcS9DTmRhZTFqVDZTN3RI?=
 =?utf-8?B?RnNiNUVCMWhkSkRTK1FOUmJWVzM3c0EzVXdvVnJOMkVuWkpmdmxwc2UvZGp3?=
 =?utf-8?B?a1FidHRlWlVETE16QmZkWjZsU0hQRXBBREIwQzVaTmd5d2R6ckhTd1A2REpY?=
 =?utf-8?B?dVdFMXEyVytrUEo2OFFrUktYcERNYUVHMG0wRGhlTU1oYzQzWFpMQzFFcXVF?=
 =?utf-8?B?bklZY055Q2JBaGVZRk0rTkFxSWUzdTVxUktCeDV1bnJIdTZmcFkyTktRaUN2?=
 =?utf-8?B?ZUlmTGZSUnl6Yi84SjNvamJnelBRbUxaTWptVGlscWRuTWdzVDBvU0dBMHZC?=
 =?utf-8?B?UGxaUEVDNmRqMElITlBQemI2aXY3Y0hNUUtVOE5EbWJpdWY0TkVKYTNpWFpN?=
 =?utf-8?B?MGR5WGx2VXhWK0pCbkJRd2VVbCt3OEVSWTBJKzE1YU1KZkFNOFZydnE0cUV2?=
 =?utf-8?B?QUhlZHJoUTF0Y3FkVTVxWkJDMVRzaHk2OUFRam5ieHB1d3oxa2ZZTTBLS0Ix?=
 =?utf-8?B?ODV4djdES2cvU1RkMDFjcjZYN3BwUWhhY2VvR2FCeTJNVkVkYUNIaWxpTjMr?=
 =?utf-8?B?N0hlNmMvcXB5UmJGTE9WVUpndHR5bTF6SVY1SjJnVmlzeU5iRVZRSW05MnNB?=
 =?utf-8?B?eEczRkREK0ZVbFY4T0hkdWNMQjdkbGI3R0hHMUJIMkFOaGZVci9iMERJMzg4?=
 =?utf-8?B?Rzl6b1NQNXc3UDd2OVNWRW1IVmFlRGRtWFFwZk9SVlp2STNVZGRBUnl0TjRh?=
 =?utf-8?B?d0JIUy9UTDJqQ2JFdU85WFB3UWtTb1p3MXpXZDlVbllvSWhJSzZ3MjJYajdN?=
 =?utf-8?Q?56EFtT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnpxRWlDMmYwL0tXenpEdi9SR084bjhidzJTVWRqU2FkaTB0TnpMa0hvcDdF?=
 =?utf-8?B?aWxLU3ozbGhyVnRRWlBJcU5XOEE1YzR6MW9lYjIrNjI3dVJxSDlCTDZiS3I1?=
 =?utf-8?B?bEtlUzgwVHkzeW5jdkFFaTNMdmtYaEpwbi9xc0tTdEV6S3J2am15TS8wamIz?=
 =?utf-8?B?VzBtQkg3NXFyTCtXN05QOHpSN2swL2MrSFg3N0JvRitFaHhKeFc1UnlhbkpV?=
 =?utf-8?B?NzlOS2lOSkhrd0FxaFA0ZHEzV2ZTVWpYbGNMbm1kSmZMYmQ5SDlHZFBjVzlW?=
 =?utf-8?B?dTVSbTZlYXFCV3RxNFNZQzRJZ1M5WjZEY2lzd25SVGlSMzBRM0xHTVFMWW55?=
 =?utf-8?B?azBQcTJsZzVIb3lYQnRuNXBua1JobmJ1K3hsdFNUK1dPc2tyNE1lQmlNdThB?=
 =?utf-8?B?bmpsMnhPOGthQXdXZHcrdlJxUEMzVktyeS82Y2lDY0VVSWtRM0VCbzJidGdw?=
 =?utf-8?B?UmpsM1ExMFNyU2FuMHFQZjJ6b2pTbnlDcXp1d1lQN3V4eUUzVnVEZ3ExNDRs?=
 =?utf-8?B?bjB6c2RGS3hubnphbzIzNmtkZlJIaGJOclRtZXJpREFDYVBXdUQwdzVMTGhG?=
 =?utf-8?B?MHJuQk1tQWZMYmYxTzBIM3BzLzhlK1ovcFZBS3d6YnhtbHVKS0RJWHdCSWtW?=
 =?utf-8?B?U2V0TmNOM1J4OUV1M0Y4aUJBcUM3aEx2OC9TWFFsTHNqTnpHOThVZmlwTXJ0?=
 =?utf-8?B?NXUyZkVCb0k4ektFbStDWS9OakdxNWs2SGlxa2ZxOXdjdVEyZHZJT1dheVA4?=
 =?utf-8?B?NFpydFZWbFRyUFhZU2NvV3AwSC9qc0tmSlVvNk1UZmtsL3c0UFlKSnJSRFd2?=
 =?utf-8?B?L0xVNEtqYnlKSDgwVWkzVDRGN2N6dk1hdDdidmV5ZzRmZ2FRQXdQTzNNZVRS?=
 =?utf-8?B?cWlJYkZyMy9XeTdKcjRtN2RUeGYwOXNHcUNlem13RGJLY1czajl4NHpzWjMy?=
 =?utf-8?B?Q1o5YVZpU3VrOFBhTzg2d3ZXSSsrR1lkMnpCUEloa20va2tlVzR2cmNTVTFO?=
 =?utf-8?B?T3lCYys2MktWQ2NmSEVja2E2Ny9FY3lYeFFVVE8yQ0hXWFRRR3R1ZUx1NzFH?=
 =?utf-8?B?VjQzY0VzV0ZUdjhOc28zdjVtVUxpR0hCbWQ1eko0RVAvZTVzNnN2bUMzZlZB?=
 =?utf-8?B?SEFkTXRCSTZZNE1TcDZIQkFpYnRGM1ZJY2ZUWTJneFRZdm1wbEVmN0xUWk1X?=
 =?utf-8?B?Q1NLdUZTZXBwSW4vVFcySVNDMG10UU9udVpmWmUzQWdkQVlFbXIyVTZPSng5?=
 =?utf-8?B?bkU2N0ttNTlOTTZsUFEvUHBXWWVUOVhHRXNwdVFuRWVPZEVzaE90amxodCsr?=
 =?utf-8?B?cHlwS1U3VHRZNVRPWTlETjhtRWdoeHRmamxsNXA2cW1rOFlCSkhOR0tZdU8r?=
 =?utf-8?B?YVRvMFJQZTJZa1JJeFlMQmxmL0ZzVjh0K09ISHlJcnhFQ1NWYzR2SVhtekx5?=
 =?utf-8?B?cS9tUlRiYjJ4OVA0TkM4OVhwbHI2SUIrQjFnWXhMVm1RTUN1enJibGZqRkIr?=
 =?utf-8?B?Sml1Y1NyV2lVWlVqUFJGanUyT3FpRzdjUW0rUDFnMWtJdjlySVFDdEVZWUVB?=
 =?utf-8?B?VlhRcGpxV2VURWttMWpoR0FSSS9sQmhVVU5BN2NNbEQraTNGUGl3dHB6cmRP?=
 =?utf-8?B?TFpob0E4THZ6K1NzTjNSb2RHUnY0VFVuSXBDUjdIMVk0Z1NhZU5SWjdYcGxs?=
 =?utf-8?B?RjJaL3ZLZEhYaGw4WXZ4dHNuS24wU0NxbUJMMjVzMmx4eWhNWGlYb250L1Mv?=
 =?utf-8?B?dHltSXVPVWFHMVZyQXNnUUhYSFdUOXNEYTBlWTNReFhNcEUzTlUyWEVZVWFl?=
 =?utf-8?B?b2d6NTRkcFM5QjMyL1dWOTdlcmFIMVlKZis5dWRzOURXOWwxQmtFVVVPZVRF?=
 =?utf-8?B?SXc5WlZ0UytxbC8wdmRiOXBhK2c4MmpJS3Uwb0tYWEZlVVk2TjlWei93WUZX?=
 =?utf-8?B?RTJUeW9aRS90U0pLVDlnZzQyY3VNcWVNQ0ZjamtLTEt0dDNlQkRrZGpLU3BC?=
 =?utf-8?B?RktabUIzUXJGU2M5YWp6QWNFQ1AyaEkyL0tQZ1pQd2Rkb3hwYWtIK3lUT2tw?=
 =?utf-8?B?ZGxucGxWTUg4cEtqYUFESlNtb1V3emRSMjZKNlFIbyt4QVVrOFlvM0xIdVJF?=
 =?utf-8?B?WkVCYWtncTAxcGRyQ0VlV1k5UElrTjhFaG54R1pjZTFYaWFYaWZvb0JUdllm?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9ce124-8d10-4c62-0e10-08de324e5937
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:28:41.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASBZ+j4INQY/IJXibdaI04G3TRMT6o/MnD1cPv6pEdKOYINvSdNEUcddrl8U1EHF/MsG91r/gDkwnzXKjb1cGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7422

The mask setting is 5 bits wide for the ad9434
(ref. data sheet register 0x18 FLEX_VREF). Apparently the settings
from ad9265 were copied by mistake when support for the device was added
to the driver.

Fixes: 4606d0f4b05f ("iio: adc: ad9467: add support for AD9434 high-speed ADC")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f7a9f46ea0dc405e25f312197df4b2131871b4bc..2d8f8da3671dac61994a1864a82cdbef7f54c1af 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -95,7 +95,7 @@
 
 #define CHIPID_AD9434			0x6A
 #define AD9434_DEF_OUTPUT_MODE		0x00
-#define AD9434_REG_VREF_MASK		0xC0
+#define AD9434_REG_VREF_MASK		GENMASK(4, 0)
 
 /*
  * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC

-- 
2.47.3


