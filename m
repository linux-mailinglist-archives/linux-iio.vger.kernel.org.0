Return-Path: <linux-iio+bounces-26621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE0C9B857
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2941345A8B
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7CD313525;
	Tue,  2 Dec 2025 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="3RthCedM"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023086.outbound.protection.outlook.com [52.101.83.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA57302143;
	Tue,  2 Dec 2025 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680012; cv=fail; b=FouE6hjCGIwCUfoGlhxmOepz2/IccNt3C9/6rN8ofW6CjshKOzDWZX2Z1Ta0qjzEvyBVaQ8GwVWDZxUXtWnXsdGYXVIPHXEMJQA0hFWfrLO8Asiwb5QKO1qhPQvMmAFXbYxrdK41mxjHN2jCr0B+2HOzFybHF/0TsKrDpccwJQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680012; c=relaxed/simple;
	bh=dhB0Im2AoQytx+WExNM5oofRiSDBPxSeKoORbDp94E8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K+9Dnk96O8YiIVygWh+uWtsUzn/li76JzQszMqyGzn0fWlZUDY9lLwOPdBZxTiTRnZ9bg+URQEL+r0i54l04A7VA+hMUQ72DgE9iSfZpRH8GWNwHwQJCKZc2MeAMgs7nqgd/8I2HC2ShPslTIC3s4lSat275H4/Hz7336w6ZOvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=3RthCedM; arc=fail smtp.client-ip=52.101.83.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jF0fEuz4wcHIyK81iMc3EFqWnbPG3W/rKQ4+jb0IqXQ5KwREZ4HDtZBQDhVghcu/PS2+o/utTcUXv5gLOXl0nCyMG9zPdPS+u+/IVo6fqW74JIbGYeTQ9gJvn4/xmUqBuFzR/rT/StatMAN3sJ2L9aI3uQ5swashbZA5O3iLYrEIRBsgon3v0crpm61snBIvynCtVlWoDHoPtiXAha11im5jm1XdVuVfafVmiRSvPfeS9+RUKUoAQ6vab2M5aoW9qdXjDaZVlXNvl2KN6MmDuWg15t0UAGGyqGxGE3B3i4IonP6AE6CBvmKxDMB0dRHuvhMtlbpZ1TOoTM2ze1te6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XOMbDMEP7zbAKGG6rh0r7dH34K4tdqfCvPQ5LAT54c=;
 b=QQ9//utWaxDPsJuRBsfmcOsbEPQWf4KR7TRmaURZ2FT5+DBb+muMpRHH52fQSYlDGm7csSEl9iPWfSKzjWkGdAQ/bfrL31AIIRduXsDqhB880+1BNUGazSAEDcUZyLdvZdeiO4Mca3KmZleorFPqwLWuJLppZuo++w0v+l8V4CRWE5goU062NDMRqjWoXoxJteunl6WcoHFJdAFuwBGRaiF9TWLgViD+I06Jt28tM97xXegTmf/VUwSlF9BsyvJ3oTxOUU59dgt/D85Pb+3bmNSDWVfJs1usMlXFZagf60ONPVBSD1UUW5tL7DcStsiYAVVDghY/41rJs3Vffyeo2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XOMbDMEP7zbAKGG6rh0r7dH34K4tdqfCvPQ5LAT54c=;
 b=3RthCedMhxXJDofY2Y4H9Lp2aUPNsyFRXWNdzepWvdNQZHlYei6N0vyKjNhcu8Ujg/XvTwNa6CwBYMNhYzVMBtVTwOcrqzgTupMN2lPHRNg6PHNvcQCh/V5UdCjaLCKOAcxZZP89CVlx0CldXlc8cg3lKDqcPKQN1jzYnDWOZ3Ekm658LkzGFxDP4/CIuE5o2R6UbxzFxiA5XOyAeRR2whL+O5qu5MKUXc0Nbpovdy6N3nDTQTNsZa1rNLXV/jRk/vtRcXYomJhqY831OQnt8slnq+IyAmJBHZBsWV3u/Nc/AcDaL5H7ByvTAhKefVtAdE5TgwtNZQw1SdIOYyLBVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV2PR06MB10107.eurprd06.prod.outlook.com (2603:10a6:150:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 12:53:25 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 12:53:25 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 02 Dec 2025 12:53:09 +0000
Subject: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
In-Reply-To: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764680002; l=4070;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=dhB0Im2AoQytx+WExNM5oofRiSDBPxSeKoORbDp94E8=;
 b=iX8q7nhQso/GHtVTGXz4VzlspXX6fKffRfg0fC0uHqKaofyOBRbspcyC2ZA1RJTxED/A4yuZD
 8ILWfX+cwMEDtc1674kfCZOGAv7Qesf18uuuU/WV7Hvgnh9Twjsww2b
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: HE1PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:7:28::24) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV2PR06MB10107:EE_
X-MS-Office365-Filtering-Correlation-Id: 859f1fea-154a-44c6-8b28-08de31a1c819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1FSSFRNMnpvUmx4N0xHWlcvaTFENmVuWDVFQWZVckhIMHBRQUtFcGRXekpk?=
 =?utf-8?B?VmtCcW14L0UyaW40emNFM2hZV01raUMvSnJscklpaUJISmFsMFAxUE9YS1JI?=
 =?utf-8?B?enhoRitBOHBIeEVuS2thRlJsK2dPUE9USGNvOExidUJGRHJnZTNUSmtaQmgx?=
 =?utf-8?B?OE5mRFByZ21zQS9rNE1hZ0ZJVlhBRzR4d1NWaTEzRURVUzlNWFpLL0Eyb210?=
 =?utf-8?B?T1NocUVxUTNsaEJaSWtMRm0rQVN1bUlRbTZGRFoyRFVzMFlOVWxVYS9EMExK?=
 =?utf-8?B?Qk53eGVtMHNYeXAxaFJJWldwUDcrbEZMdEhXTHhzTzFpcFBBK2E3aXJLNytu?=
 =?utf-8?B?ejdBMHpBNmQ3dlQ1L0ZyMzRkQUVaUDhFMXE4a1krd3VsRFpHOEJWSmhqZ2VY?=
 =?utf-8?B?eXdFVnRERjVMS29WWTJwRnlDQzNCTTRFelg3clVhZ1o1OHZ6ZUhEK2tlN3hG?=
 =?utf-8?B?QXd1S1cvbHB1TFp3b0d3T0hhQXZqRHUxQUhxWEFvYlFxZXpqdnEwNitya1Fa?=
 =?utf-8?B?TlRta1FQUlpMWlREUklmOWl2NXZNNHlhUkxXVGxFWWlzMkJieXBNb0NKOU9z?=
 =?utf-8?B?WFlNaGU3TmNwNVc0eVE4M2piVmhOWUdRSEl5cUlDcDExQ1AreVJRMnIyTFNk?=
 =?utf-8?B?bVpyeDBIcC80TjI3WElMQnBwMHU1d0tKb1VvbEttelY0RC9BWW5NcDBuTW5y?=
 =?utf-8?B?dWpRUE5ScTVRSU5FL0RwV2kvSE9ianJZNGROblU2aDhRTHE3OFgyeGd6dU1P?=
 =?utf-8?B?c3VKclNQY2RmY1pNZTBoUDdiMVBSVFFaSHpmOVUzTkFrc3ZKb0RsdEcrc3dL?=
 =?utf-8?B?eWJVKy85WkF4Wlk5SDFRRGFYTHVGeHhGL1FZRVZMamxYdUhvaWY5NUZRSXZQ?=
 =?utf-8?B?UE1Bb01CVjRyT25TcFduUkl6cnZER3dZaWUvV1VDSFlnNnp2dmRNcHUvbFRo?=
 =?utf-8?B?Z0NhZDFLQ2QxR0pZczMrVmFOOVp1czQ3UzFCd2E1ZCt6NGZ0N2gzcHJRZyth?=
 =?utf-8?B?eXY4OXNzN0ltWTU5WndEckhpNGM0bUppVzRMenZaQzBGWk9rY3pNbEY2OHN2?=
 =?utf-8?B?b29DTG1vNDNXdGUyNjl1aGZETGNaeittTmpqODZEL29lYjZwb0FRWnl2QmdF?=
 =?utf-8?B?VmZyeWk4Yk1EOUVHdTZyOVJGL1RCemZQaVZ4QWYvZ1lPZkh6Q2pvYUo0TzFM?=
 =?utf-8?B?TWY5bVpoUnp1REFwYll6ZXJFTmlieUZOdFcvYVhWQnJXRXJidFNLOHhxcis0?=
 =?utf-8?B?L1NvdG16N3ZZeU13QnkvSGprR0FVVHFWV0U3aHZ0SFF1c1NOcmtBeEFKc24w?=
 =?utf-8?B?bHBqRFI2OWtmS21wbTNvSDRqYUh0SHh3dk51YTJNZHpZRnVUYXVmWW1RZUVi?=
 =?utf-8?B?Y0cxTEFNU3ZNUVFqUW82aGpraWNFaE5lYkFoK2JlQjU4VGUzTkQrcU9xZGxu?=
 =?utf-8?B?N2Y2VUwyQWRLS0VyYUNiMTI5Q1JOeDBKaXlCSXlFcWd4OTBJcStBSXFzdEtO?=
 =?utf-8?B?TkhKUG1TSXhyRmlVNTBSbXF4aVdJMXFQSW0vcGlXWnFETXZhK2cwZDB1eDZW?=
 =?utf-8?B?TTNkVEFzWXJLbUFSdWNMMWxZbEhhQW5TUy9wMUlqV1VjUnFDL0IyMktvVFNp?=
 =?utf-8?B?RWJVbnNvTXROdUVyVVFmWkNZUEpDTWp5SUc5NGNEcHAzR3FNdTZkd1RuMkoy?=
 =?utf-8?B?SUQxcEhOQzJQRVcxTzJSek1qTVIyQ0xOOHErSEw5YlQ3M3o0enFNa1lHVnFa?=
 =?utf-8?B?L1VKQU9yYmdCTjVxOEJhMVBFV0FZZjRyWk8zZFVFaDRKaTRpcDJTc3V2RU1D?=
 =?utf-8?B?UGxqUkZiSEQvdkdOd0o2eTRzRjFxZG8wNVlhbEF2RGYvaHA1dUY0MTdTM0xa?=
 =?utf-8?B?Yk41VXVuY3k1M2ZMTlVreHhLOStFSU1iTlBBMjUwS1d4UytUazgzSWh1Y3h0?=
 =?utf-8?B?SDRYbVlremFWdmQrM3FBUVp4SWZoM1Bua1V0ekZrTXZWWUhEU1lPL3hCVXQ3?=
 =?utf-8?B?T3FUZ01uYnJiLzVUSU9EY3RlbkswQU5kNkRDUEJNb2ZlQWUrbFhZVWJBbzFy?=
 =?utf-8?Q?OW5DbS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dy9kYmpsUzlJLy9FUVllUWJRejFUM0w2cGRlS0p6UDBQMFVsNWVXNjlSelM5?=
 =?utf-8?B?UFlkVFlSaDk2aWQrRDF1dzdaamtSc210ZzFGNTF2MllHQllKODloWFJkSTVY?=
 =?utf-8?B?UkJzMy9WTmtmcFp3MWJEYW9SWnQ3NnB3S1M0RjVSSzk5dVgrczl2cDlyZVNm?=
 =?utf-8?B?K0xZSk0wQVhDNkJxWFUrSHJPZVJhdzMyZ0ZyU1NTcDAyL0Y1cjd4Z2o4bUoy?=
 =?utf-8?B?OWlYeUFlblRvZHRlZDhlSXF6aERlWWtqUlpTY0diV21sdnVHVjl0RkhVUERL?=
 =?utf-8?B?ODM1ekk5SWdDbytYV2F3emp1a2R3bDVzRm9XdmtsaWxscVJtQVZZUU1WeHZm?=
 =?utf-8?B?WU9kYjRDS0hhMHdFaEllY3BDNGo3dTQ1aTJnWU85a01rMDdFOVVVQU44eHV1?=
 =?utf-8?B?UEQ0MXNwTlhla3Y0SjBFSGQ2ZXJhRmpXci93NXVWVFNDdVU3bkJHdUpGWlJ4?=
 =?utf-8?B?ZDVmSzhQYllWd3llL0VWQnBnczZmbGE0VjJpcDlqRyt2UXZuVVJOTnNkcWNW?=
 =?utf-8?B?TDNWdWZzM2dIWXZLa0NHV0gwNC9MU2VrcDYxVzFpdHZoVFdvdE9aaDdlZUJG?=
 =?utf-8?B?WTI2Rk5tQlZQNHBvT2c2blRSbFJVNzlYenRTTHpROTMrR2k3ZS90T3JCKzJU?=
 =?utf-8?B?K3hOOU93OWNFRmdxOCtldmgya1BDeWRGM2s3dXM4QWc5VStCSTd0S1BrcW9P?=
 =?utf-8?B?L05maWFBcXIvT1UvQWViNmJPVkVHVXhidndkVm5OdGgwbWhsbFUxanVFd1or?=
 =?utf-8?B?YnZUU0FlSkEwS3NRcG5mWXFrQW5CMGtaZWdrdHU3QTMyNnc5elY4OWx0ZCt4?=
 =?utf-8?B?Qi94UlJJYmEwREdTRThMV3NBOHpic1NlREkzeXdWM09oSUoyMmdpVXlRbUFE?=
 =?utf-8?B?RE5LMWF3ZFdDUGN3czZYZGNhc056UmwzN2NEZmVVbkdERDR2QXNGdkZOZ2tU?=
 =?utf-8?B?N3FvWG84QU9NWXhKbE9nd1M5bThxdXNGd1kwRkpqY0plWEhoV1BqNXlSSklk?=
 =?utf-8?B?ZGxGTnJ3UnIwaHZWQnR5ZS9ncXlQaWtQOHU0bDd1SGR4WEpycmN3MTNLLzVO?=
 =?utf-8?B?V21EdWswa3krS2ZtMldjaGtYS25DL0NjSU9HaFUrTElWdHlPNnpWbzVmODdN?=
 =?utf-8?B?bUNFZGs0eVhMRGtYZld6SGxuVmdNMS9tVks2SXplZHZxV0d3RTFaSUZFSkhI?=
 =?utf-8?B?V2phV3pvazZVeXFyUmtCZFI1LytUU1NUZHdvT2JvMnlrc1RSNFlCSFhPK2l6?=
 =?utf-8?B?M1lFWUZiUjdxaU1UMW1FKzhKRW1nODhUcDR6cGZNSEJNRkFOSGd5UEVuWTR2?=
 =?utf-8?B?VWJoY0xWSnlNVEhFQlFUYlorZlUwRU55R21CaEkwam9FTUR5aUdBc0tEZGhp?=
 =?utf-8?B?UVFTcEc5RXNYSFZHQk9ITStyL01UYWVwbDhLYktZTEFmNzRnSWdEdDNrS1pu?=
 =?utf-8?B?VXFZQXB2K3diR2RjaEp1emE1UStnQklBaEFZVmV5eC9XWEg3Ly9xSDNNaU1P?=
 =?utf-8?B?bXRPdlhXQVFLOHpPb2lyWE1nSjRyY2NJR1hYWjViMG5FUlcwYllESTIyNVg5?=
 =?utf-8?B?SHVjR2Exc25JMlZXOG9BTnhWUWp6M3ppY0tUTXdhcW8rejRDVjlUcHhCSFVR?=
 =?utf-8?B?WkgwWGc3N3NNQlVOUkcyUHFDSmtuTFpMSzh0NHFZcmdqZ1FGWEU3OFZENDRX?=
 =?utf-8?B?c1RJOEVQZWxwdk15eDNBWlE3NUVFRmRhNG1Kcm4vWVl4eXZBMmJ2VlRuN2dH?=
 =?utf-8?B?NGEvelhVcFFkZTBGRVZENHgvNVFPb1ZwMTdWdDAvdFVvcHZucnYzQjNxVlZw?=
 =?utf-8?B?ZGU1L1Vqc0hmRHZtSENBUWE2NDB3UGpGM2ZnSnhQTi9OU2xWNk02VlpPdXNt?=
 =?utf-8?B?NWdXSm5TcGh6cEhwQVBwZ3h6bHIvMFU0Z0VxU3YrT1lOYURsdjhCd1d4RUFi?=
 =?utf-8?B?NWVjN0dGSW94VkJIcDNNd1RvZ3RkeGhvMGZ0YVpUUU9xOWNyL1Aya3ZvNVJL?=
 =?utf-8?B?b2ljMWZDMnB5Q0tHNXFFbXdPZExnZWNTMVpYNkxaYlFhRllXTTgxVVVoQkpW?=
 =?utf-8?B?U3ZWUGJHcDVDMUxvWi9jWGhqTmR6Q3VJQlNpdmxRTG1aVEVaaVhQaGpVeEFX?=
 =?utf-8?B?TS81THk5UVYrZmliTnNhNWp1TGtXcFBRWTlNZWpxN28zNStoOFVGVENhK256?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859f1fea-154a-44c6-8b28-08de31a1c819
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 12:53:25.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 878NWCnf7Xhsd2nKwM5SUE4ezwflmL5cdDh1TPz9Tl5kl9kxoTsqzYFTwliHpMtFT3urw9m2fZLYiHl+cyDMcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB10107

Support configuring output calibration value. Among the devices
currently supported by this driver, this setting is specific to
ad9434. The offset can be used to calibrate the output against
a known input. The register is called offset, but the procedure
is best mapped internally with calibbias operation.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 2d8f8da3671dac61994a1864a82cdbef7f54c1af..c3cf7ae977d4279ce5e80a7c956c3844483eb8bd 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -145,6 +145,7 @@ struct ad9467_chip_info {
 	unsigned int num_lanes;
 	unsigned int dco_en;
 	unsigned int test_points;
+	const int *offset_range;
 	/* data clock output */
 	bool has_dco;
 	bool has_dco_invert;
@@ -234,6 +235,10 @@ static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return 0;
 }
 
+static const int ad9434_offset_range[] = {
+	-128, 1, 127,
+};
+
 static const unsigned int ad9265_scale_table[][2] = {
 	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
 };
@@ -298,7 +303,24 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 }
 
 static const struct iio_chan_spec ad9434_channels[] = {
-	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_shared_by_type =
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.info_mask_shared_by_type_available =
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 12,
+			.storagebits = 16,
+		},
+	},
 };
 
 static const struct iio_chan_spec ad9467_channels[] = {
@@ -367,6 +389,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
 	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
 	.vref_mask = AD9434_REG_VREF_MASK,
 	.num_lanes = 6,
+	.offset_range = ad9434_offset_range,
 };
 
 static const struct ad9467_chip_info ad9265_chip_tbl = {
@@ -499,6 +522,33 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
 	return -EINVAL;
 }
 
+static int ad9467_get_offset(struct ad9467_state *st, int *val)
+{
+	int ret;
+
+	ret = ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
+	if (ret < 0)
+		return ret;
+	*val = ret;
+
+	return IIO_VAL_INT;
+}
+
+static int ad9467_set_offset(struct ad9467_state *st, int val)
+{
+	int ret;
+
+	if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
+		return -EINVAL;
+
+	ret = ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
+	if (ret < 0)
+		return ret;
+	/* Sync registers */
+	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
+				AN877_ADC_TRANSFER_SYNC);
+}
+
 static int ad9467_outputmode_set(struct ad9467_state *st, unsigned int mode)
 {
 	int ret;
@@ -802,6 +852,8 @@ static int ad9467_read_raw(struct iio_dev *indio_dev,
 	struct ad9467_state *st = iio_priv(indio_dev);
 
 	switch (m) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad9467_get_offset(st, val);
 	case IIO_CHAN_INFO_SCALE:
 		return ad9467_get_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -836,6 +888,8 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad9467_set_offset(st, val);
 	case IIO_CHAN_INFO_SCALE:
 		return ad9467_set_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -874,6 +928,10 @@ static int ad9467_read_avail(struct iio_dev *indio_dev,
 	const struct ad9467_chip_info *info = st->info;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*type = IIO_VAL_INT;
+		*vals = info->offset_range;
+		return IIO_AVAIL_RANGE;
 	case IIO_CHAN_INFO_SCALE:
 		*vals = (const int *)st->scales;
 		*type = IIO_VAL_INT_PLUS_MICRO;

-- 
2.47.3


