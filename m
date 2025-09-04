Return-Path: <linux-iio+bounces-23702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E09B439BE
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 13:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A935A22C1
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23F72FC865;
	Thu,  4 Sep 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="A6/mmxvU"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021119.outbound.protection.outlook.com [52.101.65.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E22FAC07;
	Thu,  4 Sep 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984818; cv=fail; b=X2vgoXHf3xvmTSTy61IrUHu90e++BcmLOuENqzYKrKRhfY8Z9XtWY2UA+btSn+4rO9z4vBQD8UXyI+FBWv3x0eo9aQvyOCLgcfo1BqEH4vN9DdClwBKhkEO+K9aHyPnilHL+FVjQcqPh04t2eTEjvABRL32vrQLazmfEC9RrTq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984818; c=relaxed/simple;
	bh=lmyf1E/Nno59TyazfyQAA3dwUV5Id2oIO+BMnmZJhIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aCix3mT09wNfMq8FxiEoKnqzqo2UmmTmXwFtWPt6J5phRzn/N76OnvJEyK6ijANSKSVRoHPcUKYI/iC6qeb3ijbU6Ifdg6co1lI7tnlp+cd8zu82gO1cu+Bbck1c2ZkeYk5xycrwtsGAl3mIAwqmqCdqsRBlsID+PTjggILptNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=A6/mmxvU; arc=fail smtp.client-ip=52.101.65.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V20+iJgfo85GCYbCRjUwtku/WmY6Jfx7QtKwd+5wqy9lteFyedu5aD4vVH+8wKBai0BltbC+0UCzn0RAN52pTSyajd0/CYk+MirvMOcTb2mg7EJGQvvJ1H8tPhzQ4ZxvLJYUP8omi5E1EgP9SnCoreWcUJJ+7lNvbqIZP2tuoCMew/bPWrWk8rGcao6pIDRsrcIE7ddBwj5YYN7jw7zkL1/mcGX2JTd+JqD2+j7DYGSauRp59WRWG0tQpNGtWf06TCokYejFykqJjGz0tiXTM3x5dZxlzhPFeyK9uuV1jJxmrjGzi+n3Q83QzUEPFCHvcCFXVaY1HQqTCFfwsU+3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQHpAu6fCPgZ0Lln/mb8/wF0sISH/fV6QYTDcZGMB5k=;
 b=FwIj0HC6njriH5JTT6NvDuo2tmK6MqqX/ma8skDKf6osYnMr+27dkD04wGEig/moEpoeITc0Gesz2YILCYGt9vgQT275Mu8/vZ0EJn/UWKcw9cw1hzV6+10tSPV/I0ALSSNUg4p+c48lJeALdCOwaWgQo4gE9vpflaKrTC58PRVLiIYmqTGGyJrehD6cx/5VFTeyurdajQfNFSZCeKVFISpeHMz8++8K6WLoVaqZZWPD5WNgBegm+B4AP7+LRZWBp+NlMyTQ/gUEehN2oQ6m2y0Yt5VESizumBoSU7Ke6uwRfe/HF4Y78jrwlWHI3PNSzxE9lX+YmBeUfZ2xpvSv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQHpAu6fCPgZ0Lln/mb8/wF0sISH/fV6QYTDcZGMB5k=;
 b=A6/mmxvU60OImDrdL9a1w7SRz20R9LT+1fRt3PJmMheECgHaIDHa/jpNCmCShiSvlT1j6M6hn+odOcEtjnHO0616KtHLFipOc/4sOS4HQK34twXx0nGf5ZempwqTWUmasiZl5iR7OSkyVTUJViSwN2RHzL0yioJH3XIH3PCkzZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU4SPRMB0014.eurprd02.prod.outlook.com (2603:10a6:10:584::13)
 by DU7PPF132387F5F.eurprd02.prod.outlook.com (2603:10a6:18:3::cc6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 11:20:12 +0000
Received: from DU4SPRMB0014.eurprd02.prod.outlook.com
 ([fe80::2ccc:49c:c33d:cfd5]) by DU4SPRMB0014.eurprd02.prod.outlook.com
 ([fe80::2ccc:49c:c33d:cfd5%5]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 11:20:12 +0000
Message-ID: <df5b2e1a-dca2-7827-7066-4e6f3dd8fcab@axentia.se>
Date: Thu, 4 Sep 2025 13:20:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: afe: current-sense-amplifier: Add
 io-channel-cells
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Primoz Fiser <primoz.fiser@norik.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 upstream@lists.phytec.de
References: <20250903113700.3079626-1-primoz.fiser@norik.com>
 <20250904-tangible-practical-partridge-a1b0e4@kuoka>
 <b6006a1b-0b46-4e0d-9d49-6cc0dbe84814@norik.com>
 <90aa7f8a-9ce1-425d-a988-3c1f9990ec4d@kernel.org>
Content-Language: sv-SE, en-US
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <90aa7f8a-9ce1-425d-a988-3c1f9990ec4d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00003852.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:1a) To DU4SPRMB0014.eurprd02.prod.outlook.com
 (2603:10a6:10:584::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4SPRMB0014:EE_|DU7PPF132387F5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6e1ef4-06f6-47ca-9a8b-08ddeba503c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHlMQUlvdnFSK1Q3ZnYxdFVGdVJGZHBrZTRkTXNWR3RxU0dLWmt4aDFVWW1O?=
 =?utf-8?B?SDFZekVuQkFtSUt6RFRwaGc3aDZNRzUwUWIyZFpFNGt1dDg1V2szcENzRW1h?=
 =?utf-8?B?VkdXb09GcGZha05WdmZUVFVncFA0ZW9xdE1VdnI1dEJOaUd0Q3BYY2ZSbmYx?=
 =?utf-8?B?Nml5S3NCUUpCSG1GSXZBc0ZJVE10OER3WklxYzhKTjhYdHBiek1pVjhPMDVX?=
 =?utf-8?B?Z3VBdkVMajFtVDhMelhqeDVqWGV5cGNBaEZ1S25Ncy9RNmJFNUlpQ1RPRkk5?=
 =?utf-8?B?ZThGekhqZU9BNWIwcldDMkVvbzVZR0twWlgzVGhNWWtsaStnN1JrM1htLzhW?=
 =?utf-8?B?VXRGR1pJUVNJbm1jbWpBbC9ZUituSlNuZzBwYzJTS2tsbWM4YzlONDNDS3lr?=
 =?utf-8?B?N0JXeFAwdUt5cDJBQ1VVS0NrMHBTTUFKS1MvMU1XcEdVVjkzbUkwSWhOeWtC?=
 =?utf-8?B?Tzk4QkpCNjJjaWE0NXUxU2xYWHk2ZDU4QVpqWFNvVkRWdjZ3ZjdybUxMaWF4?=
 =?utf-8?B?MFhaYVl0NnFHM0dzUDZGbHltbUJrdEdYWmtseG9qNkxwb2hGQllIODBaRWd6?=
 =?utf-8?B?d0RNeG15cE1FenAwMm5uMlZrenpsUFdsYTdMRnBhYjZjU3ZCOVV3TGM4TXd6?=
 =?utf-8?B?OGdhSnExUEZHa25MWDFYRnV4UWtpc3NpdFBEa3dwaytPSW5WeWpzWkVQeVpY?=
 =?utf-8?B?STREamUvaEI4UlNHOEVyb3IzZkJpUUNtNjRBWG1KaS94cFovNktuY1B2Z3Fr?=
 =?utf-8?B?MzhpVVdoT1REbE10ZkN6UWJyTzY3OEsvb0hiT1VmSjBQMTlDZXFoRTFmc2la?=
 =?utf-8?B?bUkxQ2QyQTFWa3loNVRjY2pqbWJObGxJNEljVlVrbEFWbVEweFdhVWFlSTZG?=
 =?utf-8?B?OHZYRG82eEdIWHY0SmRlaXJ0c1IzUEVFZzBVeTVJNGF3b2JDdnZ5MHVCanFh?=
 =?utf-8?B?S1Y2TlRCY1JoekxTUXVsN1AvMDk4NDY3TTJlSlRtTTgvQW4rU05DOGtrVWs4?=
 =?utf-8?B?UGdrMENkd0Zmdm9rZWNoLzRSd3F2SHBnWkZzcWg2VkR0aFdqVXY3Y2pHN3BJ?=
 =?utf-8?B?SU1nRTEvc3lDZ1diaVVldWF4c0FSK3kxcTk3NjNUK0NEL2Y4WG9Pa0xoQ2hE?=
 =?utf-8?B?MUJUVldIbkswMUw3dUhMaFpCb3JaZUhUaWJPMlVjdnRsc2x5dWZsMWxrcTNY?=
 =?utf-8?B?dFdxQkg1ajdYc1hYeklQbnBydGkxdlhkVll1azR0dm5UbnZ4V1FUSDh6Zkk4?=
 =?utf-8?B?bVNhOWg0Q2VMYkNQK0g4LzQzSk16QzZYRHFKOUFNRUxCOUNtczZ4SEtBWXJC?=
 =?utf-8?B?dVRXblhKNjk1Y3ZvMlpYL3I0NHJpOFNpSDJHcjZMbHpuaG53ck1Qa3hEdThD?=
 =?utf-8?B?bHIxSUR4c044YTRDUTFUQ29JK1RDZjc1U0V1VVBCTUZCY2dURmppby9VWWI2?=
 =?utf-8?B?dzkxblAzQVVKSzM1TUZRbkxZTzdWQlZVeGpVWUhRUitVdlk0d1Y0M1BIdHV1?=
 =?utf-8?B?Z0ZLVS8yWkhLTnVRa3NwSlVNZ3Q3R1lJUkxzVkJsMFhGQVdPUU9hQk1nMUVp?=
 =?utf-8?B?RmtZK2pReEpyT1ViQnk3ajFuVHMrWnFLUEkvTExDVjhLQ2tHYXNyb08zZk84?=
 =?utf-8?B?WU5QRllIOEZaMVo0emFUdVNWL1d2dzdvRzFac1J1UHVNVENyZnErbmFISTdK?=
 =?utf-8?B?eTcxSUpJcWpaQ05BVVpCSkRmVGNKLzN0bVRRRkhmcWF1NUZvdTRmaHRhSmFl?=
 =?utf-8?B?Tnc3Z25Hak8wZm5wZXk3WnZvWEUzcEJOSHVtUGlzTlB3VllvRnVOdStMZjRG?=
 =?utf-8?B?YTJxNEJ6SC9rSWkyakRtRVB4bzhDT2xKc21QNGVTdUF0aHdEdGpKbWc1RWp0?=
 =?utf-8?B?YVB2R3llTlpCZGxGWXdTRy9YdHFrT3ZSL05va1R5eDRPUEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4SPRMB0014.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0NxcDBqNzhvcE1BWDYyNU9hSFAyeHJtMGl3ZVgwMTVabHoyYmZ2RUw5dkky?=
 =?utf-8?B?aG1yKzErS0FocGgvK2JCMWd2YktCQUNKSHNIQlpRUW9jeXRJQjNybndOeEUx?=
 =?utf-8?B?T09BK005TlgwWjFUSCtNL0pZNXY0S09pY1ZocUZBQkx5ckpwYXg3dmV5eWVH?=
 =?utf-8?B?bmx2WXUwWW1sYzRob3pkbFZKU0VOMG9OMWxVdnplMnRCVExJaHgvMTVoVDFO?=
 =?utf-8?B?Z1ZSZzdocmFXWWoyUksxWWZQZjFvd3RxKzdaVGxjVDdHUTNiWmhUYjJJYTlN?=
 =?utf-8?B?R0JoWlVkbzd4a01xKzJ2OUFtVTRmOHRmdnBwZVVCdFIvY0pSemh5K0pROEcw?=
 =?utf-8?B?RU00M1pIU2tUYURxcEJQczVnZlpYYWN2Vjd6SXJWTUkzbndSSEJBcTgxY3hN?=
 =?utf-8?B?QmdlRmxlMXhwMDk2SktGaU9VMWwwdUV4TWNPajJGblhBOXJ6eC9USHg5YnF4?=
 =?utf-8?B?clpNZXpBSEEyS1pTNHZ5elJYL2hja1dwOEEvcWsrWXVQSURWd25aenFySWFa?=
 =?utf-8?B?RDgzWDNqS1hJOVFUY2h0SVB3S0FFY0dDQ0RVVTZmRFdyYjg1aGlFMDZkSkth?=
 =?utf-8?B?UXpUaVZOTzljRTU1TTd1T1IxSFF5VmYxWGJaNmhxd1JuUXllVE5LVEkrQ2pl?=
 =?utf-8?B?RCtyYXJSVkR0bGFyZEtGTXkxVWJYY1NEalhPTFpqSVZyYWNPakx0ZTVvK0NV?=
 =?utf-8?B?Y280TjNpc2tGUTVmSzFVNS9ac28rRnd6cndXd091bEYyMUJHbmRxUDZHcmxS?=
 =?utf-8?B?b2FxU3JXZ1FjcnZQL0NNMm5uSzM1Qi9jYlU4Unp0bjBFNk1UYjF2bEFQeE9p?=
 =?utf-8?B?N0pEdDRKZmE0N1NmNGNyaTI0UUZDa3BEYXFjTnpIdm1hTFBaajFYRlltY3Rn?=
 =?utf-8?B?L2pzeXVsYzlOWHh0bHo1TzFmaDdzZGJMRjVhcGcvVkNJVnBudW5VTFA3KzR5?=
 =?utf-8?B?Q0ZtakdOckNRVlU2WkVjZFBralpyY0NqNUtjVXE4Rm1nMnlhNitYcGxyd3BJ?=
 =?utf-8?B?M0JwMnJHQUJQZjZxT1VwdFhSUXNxaDFNc3QwbXN5Nlp2SDNBVStIeWFyZ2ZY?=
 =?utf-8?B?V2h2a0JjVXl6aUZJc0hzbkhpZFZ2UFdESlNpc0xmV2NSanhPclYxK3FWZzRl?=
 =?utf-8?B?ZzdvQTRRNkFLQk5PYnNWRmx2c3M4elJjOEhGeWdCcnJSU2kyNFd4ZE55VEVr?=
 =?utf-8?B?azEwMUdycGhtMmF0OVZ1dmU2WFlSVHd4cXAxdW90OFczdlRLM3hnckhUNUth?=
 =?utf-8?B?QUt5THRzQkRHYUN3Y1NQRkUxMmlxTzdSUnpUejJnK3l3SzlMNUt4REduTmls?=
 =?utf-8?B?aTZkV2hOeTF0WlZaYzRQR0NiTjJVaEJpd253cG82WVVHM0lIbjdJT2lQek1C?=
 =?utf-8?B?VEZZTm1kRnh3Ny9oVytpTDg5OUJudzFkSm92ZlRoV3RpbHB4UFhucitYNjB1?=
 =?utf-8?B?S0FvY2NYS2JlRDlzV3VZeVFweEtHa0pMb1BIWWJkaFZDd0plTUZJNmtKTFVr?=
 =?utf-8?B?RzM2WDRvRGR4QURpcy9pb054eXJKMFNOWkFDOGJGQm5pR0FoTGJ5NVBtaFdu?=
 =?utf-8?B?ekRXcVgrRW92blIwS2drbzlsTGdOS2ZaOEFLV0Znd0pQc0pnQ01kTDdNU1dX?=
 =?utf-8?B?dzR3eHgzQjFQaFRZMWV3c2pzODdvS3A4U1ZRYm14TDRxTnBackNuTTNVWXIv?=
 =?utf-8?B?QjF2UjNqb0UxMlFndUZWUU56Zi9NUnhCbGFMUXF2UUtkMXZSVnU0dmdtT2p5?=
 =?utf-8?B?SUxUeFo2b1k3WkltK0k0VkdxckwrOUZjNDcyUDJsR1JmNCtnd05rSFJXVmJL?=
 =?utf-8?B?NW9YajBxTytoQ2pod3p4c3NhRHRBSUFYVFV3dE51NlNVOWJLWHF1ZUQzaFhU?=
 =?utf-8?B?TGhBbGRPYXUxcGV5ZWd0b2RmSnphK2IzdHBOWXE5NUV1WUhNQ3hOL3NSV0xW?=
 =?utf-8?B?eldtUUxhZ2dWeVJ5RlV4N1M0K0t5RGdNanIrWUliR2xSNTFDQ3libVd5aHdW?=
 =?utf-8?B?Y3NEdGJXRUhCYWdhMUJ2cWRPa2xISmJLWE4wVUVlejlraTJuSDNJa3NKNE5t?=
 =?utf-8?B?c2xrNFkvNllTTXRnOHhyT0x1S1ltaGczQkg1WmxxQjZoQzVOMTFjUzl0RVpE?=
 =?utf-8?Q?x9s/LN4qtbf5QYajd4i9cq4K4?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6e1ef4-06f6-47ca-9a8b-08ddeba503c9
X-MS-Exchange-CrossTenant-AuthSource: DU4SPRMB0014.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 11:20:12.3383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wu4iLYc93hNNNN/usshFQI5b8UVcuDhBlHIai84O3JCyY/PbVmUrd7jZQk/Pwi7x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF132387F5F

Hi!

2025-09-04 at 12:44, Krzysztof Kozlowski wrote:
> On 04/09/2025 12:15, Primoz Fiser wrote:
>> Hi Krzysztof,
>>
>> On 4. 09. 25 11:17, Krzysztof Kozlowski wrote:
>>> On Wed, Sep 03, 2025 at 01:36:59PM +0200, Primoz Fiser wrote:
>>>> The current-sense-amplifier is an IIO provider thus can be referenced by
>>>> IIO consumers (via "io-channels" property in consumer device node). Such
>>>> provider is required to describe number of cells used in phandle lookup
>>>> with "io-channel-cells" property, otherwise the following kernel error
>>>> is present:
>>>>
>>>>    OF: /iio-hwmon: could not get #io-channel-cells for /current-sense
>>>
>>> Also, how can I reproduce this error? Do you paste here real errors or
>>> just some invented ones from some out of tree code (hint: such would not
>>> be relevant).
>>
>> I get this error if I apply patch #2 without patch #1. See [1] for more 
>> details.
> Then your warning is not relevant here.
> 
> You said in your commit there is a bug, expressed with that warning, so
> you make this commit. Turns out there is no bug, so all the reasons for
> this commit are gone.
> 
> Rephrase the commit msg to describe accurate reasons WHY you are doing
> this. Drop non-existing warnings and any misleading fixes tag, since
> there is no bug being fixed.

If it's a bug in the conversion or not could be debated. With the old
txt binding it was allowed to add #io-channel-cells, after the yaml
conversion it is no longer allowed to do so. It has always been the
intention that there is an option to add an #io-channel-cells property,
so you could of course claim that the bug was also present in the txt
binding. However, when the txt binding was written, that fact was
implied from the generic iio-bindings.txt which had this in it:

==IIO providers==

Required properties:
#io-channel-cells: Number of cells in an IIO specifier; Typically 0 for nodes
		   with a single IIO output and 1 for nodes with multiple
		   IIO outputs.

So, I claim that the conversion commit is at fault, since it locked
things down (additionalProperties: false) with unintended consequences.

For reference, see commit
f1f99fcbf997 ("dt-bindings: iio: afe: voltage-divider: Add io-channel-cells")
which unfortunately locks the cell count to 1 which is bogus as 0 is
the natural cell count for all the bindings backed by the rescaler
driver. They all have only one output.

Cheers,
Peter

