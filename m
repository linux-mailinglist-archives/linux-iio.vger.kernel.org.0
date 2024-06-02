Return-Path: <linux-iio+bounces-5645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF808D76F9
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD8128208E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE27D086;
	Sun,  2 Jun 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CjKyccrL"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2135.outbound.protection.outlook.com [40.107.7.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC575805;
	Sun,  2 Jun 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343396; cv=fail; b=M9L1HKzH4ajIrJxNTSfKqig1MvURfr6XIW2gEHTz/gULPByt1XjlcHu/RBYwoeF1RtZ57loH4ONs/Wo/HT7NAsy0Qd6ih8dvc1HIe77kKLYU3wCQEscM7RNpYjz0OGbA/HKHP4B9CQbF6fk5CHI5cGN+2gsNnD6XeCN5CUXs790=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343396; c=relaxed/simple;
	bh=97GeDKeK+xEHoScDnbbTVgW8llwgFM39N/QRBVPmqq4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Pz7mn+yf/BOQObaIGZm8euYl/RhXSp6vgNyyzJcrneE3GYsQJF0m/64NB5gg7A5F7aoXWC3ABFEWELNDCWUBR9FNF8fH2rYYpeFRNiy6FL5IcXJy8LQpQc08+120yKA4FxVA0UCtTOuRJxwDWAGuqXwRUyV0oHouh0u6AdrDRJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=CjKyccrL; arc=fail smtp.client-ip=40.107.7.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKbS25KlW27hrUk7Si7irdH2r/Lb8n4cgotwOp9u7PklhEmo43y07WKeWxbi1YE1K1LyyDzlNxGMRoRZpg1TkNLbGt545k3AfUn9wXD4UKOfZCwlPU0/bnzQr69CH5dKdA3XfPB2GT8ecgJO13i9I1sUQR8VQct9pSG+400ubq5gcY9rBYB9jpU+xNNuLuwAnORXjM4bpN2/yJggf3WlvECh9cLAEDt5VMSUGfSqgtE90CBcTU8uK13VI7yCXMprycc+BvjAf4+4SsEJGEPZpFP/Ctp+aQY2Z8CiUHgr+j5tA0yB+31pqZirgKtscRNCqtMDhGmmabe/4PMGiqJTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVfG+wQyRamdJoCgBA74E+TfSzjOFox9bjlnskKXf0I=;
 b=GEwrB0Isjb5GiBBqf1csxCldLtNqSerCxXwiyhfc6pTHAt3DPCpNAHZXxD8cEd2XYidUMd9yn4v8IqDjTlQQKJn2V7F9sLpyQKDmUtHAe6lOHjj+PzweOEn4GMcodOXiSkC8zCbqXz+Y5K39nSz/BxL0dSAsVsuFIRA0xS4GMRlgYjX0PrkNptJYTPjLH8XqLu1QCcv5WozmvoiPvnARBbQJ+6esaYepqs4HWvlXhmQsyEnQbHLaydAPGHYBrXfUSG9630Njf0YIO4Z3OayGuUdOxMecvIUDTsKEzlYvGqUBfzoI+bVr2ydsWUtTw/HZiKkBhsRG6qYLnwxag2UyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVfG+wQyRamdJoCgBA74E+TfSzjOFox9bjlnskKXf0I=;
 b=CjKyccrL3WkmpYt7AHpexiBJDcY28UEGj0Y9s6RfjFqw/0EkLOSDPb4VVPlv1dElNrAz9JKvC7GpdTJvYDTdURgcMQN1nhUHTzMoXgQAKRnC2K0InLED1Z8/EX1SbwgsI4Tj1iKjR8Mqnv52CuYeV2zCXcB5uaqG3Quxrcs4GRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7512.eurprd04.prod.outlook.com (2603:10a6:20b:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Sun, 2 Jun
 2024 15:49:44 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 15:49:44 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 02 Jun 2024 17:49:42 +0200
Subject: [PATCH v6 7/7] arm64: dts: add description for solidrun cn9132
 cex7 module and clearfog board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240602-cn9130-som-v6-7-89393e86d4c7@solid-run.com>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
In-Reply-To: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Konstantin Porotchkin <kostap@marvell.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 1102b491-d652-4434-9e39-08dc831b9f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2VLbDNuOFZJcDJ3bXNoWlFSVzh0K3NpS0RUTXMzdFBocUVWS0o3aC9pSE1F?=
 =?utf-8?B?ZzlFZFFTREIyUm1zOVVKWnhleWo4MU1PWXdWdTJWQXB2eG13S0tzdXYwa0tl?=
 =?utf-8?B?eHJJVkNjRzBKdDFPdjBPRlcxZnJxNk5vdERFV1ZxV2FlUCtaU1lUNTI3Y2Q0?=
 =?utf-8?B?cytoWkMxcXVqMXRFREhGMUw5aGthc29YRXQrNEQxM29pcVlJaUkwcnk1T1pB?=
 =?utf-8?B?SGxhK3BHcDhNbmpWcC9QVkt1Tnl1NitPanpmcUdhVEFaSy9aT1ZaWXlPSnBq?=
 =?utf-8?B?bFpKdFdPWFYzb3orYVRhd2RmSUEwMXkyYVlic2krRms2bktYRDFJdmVIUmQw?=
 =?utf-8?B?UTZzd1U0Vlp0NUN6bEFyTDJBRFhUS0h6am1zSENqZDRDSWZlcHlCTG5ZK3ZW?=
 =?utf-8?B?cGUvdWRLRjQzeWRvRG1BNG94QTJxUVo3NWlXTDdqQ1NnRThhVWo3VVFXdk5v?=
 =?utf-8?B?Ty9Vb0doR2ladVQvRVYxL01Wd3pVRGoyWlJ5YUU3aXJnWFltSFRnTHcwQ2Yx?=
 =?utf-8?B?amRVMnlIOGtIWVVoZFNOVUhOcXpSSGFPMWpzRUVobE5HQ2VvbUdsRElVN0Z1?=
 =?utf-8?B?eHJnOFhDMHIwOTFuMFo5ZDVvWlBnTXV6MWNIVXI2NGxLRWsrVC9OMjVPdkZ0?=
 =?utf-8?B?MUR0Tk1SYnp0N0hoeFEzMTRoZkxRSGtmR1UyelFuRWN3S25kNGtnM2JaTTNx?=
 =?utf-8?B?WnQySDFrQ3dWS1M0d2w1eG5MeTF5Y3Nva1NIYlVUaTJtaktDc0RqUFhxbVN4?=
 =?utf-8?B?b0tYTnlDc1Q4cCt4OG9DN0l3VnNqTWo4QVNQRk96WTNGTDVJN2JGQ043NkVJ?=
 =?utf-8?B?S3hTRGpNZTdMd3NnYStPc0FmU3h6S1lYT3Y1bXlBWno0MkZCenR1dmgrdlk2?=
 =?utf-8?B?K21RMGJ0dk4yZmdiUks3M1hBWXpnSHFlM0pZc2ZuTkJsaW04Skc5OXdUVEpC?=
 =?utf-8?B?cFA5cm5NWjh1Mk9mcHRjNTJ4QkpwM2pTMmlNUk9xWFF4TnJXaU0wbUFiM1JM?=
 =?utf-8?B?WE16c3l5cmpxN283QUN0UE9obkZ5bG1waWxGUERwRjI1YS8xdTdQVmJ2aXY2?=
 =?utf-8?B?TVg5RUd0TXpTczRLcnJkcFZkcFZiN3I4RmVra21HRXQvUmx1Rm9CNStySGpr?=
 =?utf-8?B?Mk8rTWNuakg1bzlUQ0NUZ0pFa1B1TVp3TEhOQVlPdE1vY0plM1BDYld6WlB2?=
 =?utf-8?B?SXhlZTBBSVZROFFvejRudlB4ODFJRjdncHMxVXV6bFZ3em1xWlNsVStNWjZG?=
 =?utf-8?B?Q1ppK01QM1dGTW1Udnpnd2NZRVROQTFLaVUzMXRldkR5WGVKcE1VUldlS2VO?=
 =?utf-8?B?WVlVM242NGl0SWcrbzhlWGtWUndsZnc0T28zSHBKL1dUT1l2UVMyQ3BQdmxR?=
 =?utf-8?B?cmFVejZIdFdFVnRHSHJyM0t6VVI2akU2OGRTdHdad2xQMDliWkFmMmlCR3pE?=
 =?utf-8?B?S0FvK1ArV21oWFJ2VWdhNWVxRC9FQ0dlOUhQRFhvK1h0UThIdXNzZ1NPRFE4?=
 =?utf-8?B?UkkvTGoxQlM1d0RnaWJjNHF1TXJaUXcySUthaFFnM2RWMVhkNHcybFQraUhn?=
 =?utf-8?B?bU5GYVhTZUY2cmYzVEY0UE1XQXhaUm05MnhlQjFqTmFwYm92emF1SHJzVjVJ?=
 =?utf-8?B?U0YrSmt3S1lUWEZnMTJvdUxFOUtsNENwSHMvbWNmbEx2YldJWWYxek9RaEx5?=
 =?utf-8?B?TkZKSkVUdHAzcTkxSnh1QzNPUWpzU1BoVGt5c3N4NndjMERvWmM2dTZSUVBK?=
 =?utf-8?B?RGI1U0cwL0lTV1hId0tmMnlDY2RkYVFsVkJVNUtrU3BnNUx1c01nQjR3V1hh?=
 =?utf-8?B?clJFeEZoc1RnSFJaMUo5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3k1NUVsK1ZZNVNZMWhGbk5wUHhkUnZrbURXd1o1dUt4WEsxRFpXRHI1eXJF?=
 =?utf-8?B?NHNGYS9GcklnVmhzOWExdDhzNmVvRGZWQW03Z2srTlE3RVJBdGdUOVprSlo1?=
 =?utf-8?B?cW1HTVd6cTcweTFRbWQ5NFVSZGF4eEtoVWhYYWljMFp2c0ZVS1ZxYjkyZTlI?=
 =?utf-8?B?NWVvaXlBaHRNZlMrVEY4YTREaWl0QVJCMm1NZi9heGxLMXFucllOSnlNQmh3?=
 =?utf-8?B?bGx4c3FGSExuZ0h4ajUrZVV1dkZoNHQwRU1BWGxZMkswd3ArdlRUdDUrdkNL?=
 =?utf-8?B?cXhwNENMQzgzZ2REWG0zNTFDejJRa2NUWGo0M3NaQ3RaaWdqR0Y4UktnTWg2?=
 =?utf-8?B?ZFBSaVZKaGZtUitqYjZlTFNmN1c5WHBmVE5LeU5YNlRPQTZ1d2RXVWt0cWV2?=
 =?utf-8?B?Wlp2bGZiWTRvTm1nYTNuSEZsUVFzRU9EaVo4YXVtWk8vd2dDUlRXbFVLMGg2?=
 =?utf-8?B?SzJVa0ZWUHRyc1RmSEwrK1Y4MGZjR3ZkK3BDWEpGb1J4OW43b05FOHgzT29Y?=
 =?utf-8?B?aGNxY2UzYkJwVC9ZZS92NERUZW10ZUwzL3Z0V1hOMXVTYmxPV2QxVTlGQ0hI?=
 =?utf-8?B?YW9GTXhJUE9JdUtOdkNRUk5kejhFblRnS3BNdUllNG5hYk1rTmtSODZCaDdI?=
 =?utf-8?B?VmFJNEs3eG1NWk9tSTJvc2x5bi9tS0JRMEQ3dU9ieEY1M2ZUOG5WQnB4QVdG?=
 =?utf-8?B?UFgwU3ZTUDNGL2IzZmM0NDU3azRsQi9OVnRZSEcycjVLcUxSMGJibDc0aW5y?=
 =?utf-8?B?RDcxRk83NmZSWTU0KzhlSGcwWk5IY1BFMVFWS0ZzOEpqMDBNQllzV2Y5UTRO?=
 =?utf-8?B?MTczeWdhc3pRVWFqdzM5QS9MTTc2WW5uREZuQXVEblA1UGZQd1pkQWVUV0RH?=
 =?utf-8?B?TWgwVVJVdXUxYnlVaEQ4MkFKTHMwQ2doaitqSlkzdHRRWlIwZXljQTR0cysz?=
 =?utf-8?B?VXZ0dFRvcVJPRjk2MExGc1BIcE5vNjNCVTFrOGI5TW1QelJCczBxQ29YdzEz?=
 =?utf-8?B?NFArOEdQSy9Qa0ZJYmJKeUh5UzJDZ2pqSVJ3Y1ltQTZWMWloYU96akNjb1VJ?=
 =?utf-8?B?QUkrL0c5ZUhPdUkrYUFlay8vMkdUVmZVOXF5aFhjUHZVbzVtS2tobEtOc3Vh?=
 =?utf-8?B?STFSV0s3cUp4WGpVRWtiRStyRXpia0hLWUM1ZlpLZ003SzYyN3FtK29RNklU?=
 =?utf-8?B?Zkg1eDZ6cUhIbHpLcll4UlBNc1hUQXJkcDI1aVQ0R2pQeVpDY3RwOEpaWEs2?=
 =?utf-8?B?L1NYUjZnQmZqOFZ3UWsxb2IvWmpQcDhzU2dFejFnM3BnSE85U3oxeDNHeVln?=
 =?utf-8?B?ekcrK0QyVVlUc3NPR1NMR2dFa2pkNHorbmFnN0lLb1lJUDdldnRkRXdlSnN4?=
 =?utf-8?B?REttVHE1eEgxQW5SOTJqZmJZMmRWV1JXR1lmdEFFNi85MWdyQjdHejMzM1V3?=
 =?utf-8?B?dEZkdHp6THJUVndsRG5PSDl1MURWVUhxRzM5QmhoZm1Ed2YwQm1VUk5yUDJE?=
 =?utf-8?B?eHJuaDJxazk2eVNrS3drYVYvYVdQNUJKMzZGNHlsUzhCY1ZLUXh1WmtKamtC?=
 =?utf-8?B?eVgwWHN3WlFWWDZzM25ycHlmbWNpaHhBcTRUdUIyeXRMVDZFVzFoVmZ0MWxz?=
 =?utf-8?B?eWErOFF4NnlLc052S09LMjZ4dGhSL3B3V2dsNklrMVNjanc4UkltZEIrdnla?=
 =?utf-8?B?a212VFNIWkZvdHVqdXdwRHJWSjZuM2FxVGNWVE5ZaEZwaTZOdWMvWktGeU0r?=
 =?utf-8?B?My9vM1cvM1h0Y012NlJRWmZ0RjRLekRPTnAvUzU3c2poVU5HSVRJcFFLaWUz?=
 =?utf-8?B?UmJZVDc0Q2tHb0hzSGhVaFZ4b29OTWJ0ZklQOVY5dWhLTDlscW80WGdjSWlk?=
 =?utf-8?B?Y1VHV0Jmd3BhVFFyVlN3aVVlY1RCQ21CNHRLWE1JQUdsanBUOGdMbEhtaEZ6?=
 =?utf-8?B?U21qK3VUVTFTamYvMm83S0p4UEdBR1BGK2dnT0s5dVdSQSsvWTlRelVNZUFO?=
 =?utf-8?B?Y0hEOFcrbWNIT3dtd0g5YUgrUW95MWRFUmNGUmwySnJBSGJJSlBGdkYwS2J1?=
 =?utf-8?B?Wm1NN0NtNGdkUnFDL0JYbU5qT2lnUjJ1T3Jlc2dGdElLWVdQOFFVSEFSeHF4?=
 =?utf-8?Q?kr8spZ7vyDcZLNKyJSMqW1V9M?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1102b491-d652-4434-9e39-08dc831b9f6f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 15:49:44.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X19nqDjp+20fi8liEs6q9gpsRc7uLru3sWhizH2chgIy/i5RYl5M28TMSKxXwDaXQcuX6FDU+gRm3vciiDXYcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7512

Add description for the SolidRun CN9132 COM-Express Type 7 module, and
the Clearfog evaluation board.

The COM-Express module includes:
- CN9130 SoC
- 2x 88F8215 Southbridges
- eMMC
- SPI Flash
- DDR-4 SODIMM connector
- 1GBase-T Ethernet PHY

The Clearfog Evaluation board provides:
- 1x 10Gbps SFP+
- 2x 5GBase-T RJ45
- 4x 1GBase-T RJ45 on DSA switch with 2.5Gbps cpu link
- 1x full-size PCI-E x4
- 2x M.2 with PCI-E x1
- 1x M.2 with PCI-E x2
- 2x M.2 with PCI-E x1 and USB-2.0
- 1x M.2 with USB-2.0, USB-3.0 and 2x SIM slots
- 1x mini-PCI-E x1
- 2x SATA (Laptop-Style connector with data and power)
- 3x USB-3.0 Type-A
- microSD slot

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/Makefile            |   1 +
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts | 673 ++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi | 712 ++++++++++++++++++++++++
 3 files changed, 1386 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 16f9d7156d9f..ce751b5028e2 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -31,3 +31,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9131-cf-solidwan.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9132-clearfog.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
new file mode 100644
index 000000000000..0f53745a6fa0
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9132 Clearfog.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "cn9130.dtsi"
+#include "cn9132-sr-cex7.dtsi"
+
+/ {
+	model = "SolidRun CN9132 Clearfog";
+	compatible = "solidrun,cn9132-clearfog",
+		     "solidrun,cn9132-sr-cex7", "marvell,cn9130";
+
+	aliases {
+		ethernet1 = &cp0_eth2;
+		ethernet2 = &cp0_eth0;
+		ethernet3 = &cp2_eth0;
+		ethernet4 = &cp1_eth0;
+		i2c7 = &carrier_mpcie_i2c;
+		i2c8 = &carrier_ptp_i2c;
+		mmc1 = &cp0_sdhci0;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_wake0_pins>;
+
+		button-0 {
+			label = "SW2";
+			gpios = <&cp1_gpio2 8 GPIO_ACTIVE_LOW>;
+			linux,can-disable;
+			linux,code = <BTN_2>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_batlow_pins &cp2_rsvd4_pins>;
+
+		/* LED11 */
+		led-io-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			function-enumerator = <0>;
+			default-state = "off";
+			gpios = <&cp1_gpio1 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* LED12 */
+		led-io-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DISK;
+			function-enumerator = <1>;
+			default-state = "off";
+			gpios = <&cp2_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	/* CON4 W_DISABLE1/W_DISABLE2 */
+	rfkill-m2-wlan {
+		compatible = "rfkill-gpio";
+		label = "m.2 wlan (CON4)";
+		radio-type = "wlan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_10g_phy_rst_01_pins>;
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&cp1_gpio2 11 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* CON5 W_DISABLE1/W_DISABLE2 */
+	rfkill-m2-wlan {
+		compatible = "rfkill-gpio";
+		label = "m.2 wlan (CON5)";
+		radio-type = "wlan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_10g_phy_rst_23_pins>;
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&cp1_gpio2 10 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* J21 W_DISABLE1 */
+	rfkill-m2-wwan {
+		compatible = "rfkill-gpio";
+		label = "m.2 wwan (J21)";
+		radio-type = "wwan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp2_rsvd3_pins>;
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&cp2_gpio1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* J21 W_DISABLE1 */
+	rfkill-m2-gnss {
+		compatible = "rfkill-gpio";
+		label = "m.2 gnss (J21)";
+		radio-type = "gps";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp2_rsvd8_pins>;
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&cp2_gpio1 8 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* J14 W_DISABLE */
+	rfkill-mpcie-wlan {
+		compatible = "rfkill-gpio";
+		label = "mpcie wlan (J14)";
+		radio-type = "wlan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp2_rsvd2_pins>;
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&cp2_gpio1 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp";
+		i2c-bus = <&com_10g_sfp_i2c0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&com_10g_int0_pins>;
+		mod-def0-gpios = <&cp0_gpio1 24 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+&com_smbus {
+	/* This bus is also routed to STM32 BMC Microcontroller (U2) */
+
+	power-sensor@40 {
+		compatible = "ti,ina220";
+		reg = <0x40>;
+		#io-channel-cells = <1>;
+		label = "vdd_12v0";
+		shunt-resistor = <2000>;
+	};
+
+	adc@48 {
+		compatible = "ti,tla2021";
+		reg = <0x48>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* supplied by chaoskey hardware noise generator circuit */
+		channel@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&cp0_eth_phy0 {
+	/*
+	 * Configure LEDs default behaviour:
+	 * - LED[0]: link is 1000Mbps: On (yellow): 0111
+	 * - LED[1]: link/activity: On/Blink (green): 0001
+	 * - LED[2]: Off (green): 1000
+	 */
+	marvell,reg-init = <3 16 0xf000 0x0817>;
+
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			/* link */
+			reg = <0>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		led@1 {
+			/* act */
+			reg = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		led@2 {
+			/* 1000 */
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+	};
+};
+
+/* SRDS #4 - 10GE */
+&cp0_eth0 {
+	phys = <&cp0_comphy4 0>;
+	phy-mode = "10gbase-r";
+	managed = "in-band-status";
+	sfp = <&sfp>;
+	status = "okay";
+};
+
+&cp0_eth2 {
+	phy-mode = "2500base-x";
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+
+	fixed-link {
+		speed = <2500>;
+		full-duplex;
+		pause;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Both COM and Carrier Board have a PCA9547 i2c mux at 0x77.
+	 * Describe them as a single device merging each child bus.
+	 */
+
+	i2c-mux@77 {
+		i2c@0 {
+			/* Routed to Full PCIe (J4) */
+		};
+
+		i2c@1 {
+			/* Routed to USB Hub (U29) */
+		};
+
+		i2c@2 {
+			/* Routed to M.2 (CON4) */
+		};
+
+		i2c@3 {
+			/* Routed to M.2 (CON5) */
+		};
+
+		i2c@4 {
+			/* Routed to M.2 (J21) */
+		};
+
+		carrier_mpcie_i2c: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			/* Routed to mini-PCIe (J14) */
+		};
+
+		carrier_ptp_i2c: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+
+			/* Routed to various optional PTP related components */
+		};
+	};
+};
+
+&cp0_mdio {
+	ethernet-switch@4 {
+		compatible = "marvell,mv88e6085";
+		reg = <4>;
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sw_phy1: ethernet-phy@1 {
+				reg = <0x11>;
+			};
+
+			sw_phy2: ethernet-phy@2 {
+				reg = <0x12>;
+			};
+
+			sw_phy3: ethernet-phy@3 {
+				reg = <0x13>;
+			};
+
+			sw_phy4: ethernet-phy@4 {
+				reg = <0x14>;
+			};
+		};
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet-port@1 {
+				reg = <1>;
+				label = "lan1";
+				phy-handle = <&sw_phy1>;
+				phy-mode = "internal";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_YELLOW>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@2 {
+				reg = <2>;
+				label = "lan2";
+				phy-handle = <&sw_phy2>;
+				phy-mode = "internal";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_YELLOW>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@3 {
+				reg = <3>;
+				label = "lan3";
+				phy-handle = <&sw_phy3>;
+				phy-mode = "internal";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_YELLOW>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@4 {
+				reg = <4>;
+				label = "lan4";
+				phy-handle = <&sw_phy4>;
+				phy-mode = "internal";
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_YELLOW>;
+						function = LED_FUNCTION_LAN;
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&cp0_eth2>;
+				phy-mode = "2500base-x";
+
+				fixed-link {
+					speed = <2500>;
+					full-duplex;
+					pause;
+				};
+			};
+		};
+	};
+};
+
+/* SRDS #0,#1,#2,#3 - PCIe */
+&cp0_pcie0 {
+	num-lanes = <4>;
+	phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_comphy3 0>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	/*
+	 * configure unused gpios exposed via pin headers:
+	 * - J7-10: PWRBTN
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_pwrbtn_pins>;
+};
+
+/* microSD */
+&cp0_sdhci0 {
+	pinctrl-0 = <&cp0_mmc0_pins>, <&cp0_mmc0_cd_pins>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&cp0_spi1 {
+	/* add CS1 */
+	pinctrl-0 = <&cp0_spi1_pins>, <&cp0_spi1_cs1_pins>;
+
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+/* J38 */
+&cp0_uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_uart2_pins>;
+	status = "okay";
+};
+
+&cp0_utmi {
+	/* M.2 "CON5" swaps D+/D- */
+	swap-dx-lanes = <1>;
+};
+
+&cp1_ethernet {
+	status = "okay";
+};
+
+/* SRDS #2 - 5GE */
+&cp1_eth0 {
+	phys = <&cp1_comphy2 0>;
+	phy-mode = "5gbase-r";
+	phy = <&cp1_eth_phy0>;
+	managed = "in-band-status";
+	status = "okay";
+};
+
+/* SRDS #0,#1 - PCIe */
+&cp1_pcie0 {
+	num-lanes = <2>;
+	phys = <&cp1_comphy0 0>, <&cp1_comphy1 0>;
+	status = "okay";
+};
+
+/* SRDS #4 - PCIe */
+&cp1_pcie1 {
+	num-lanes = <1>;
+	phys = <&cp1_comphy4 1>;
+	status = "okay";
+};
+
+/* SRDS #5 - PCIe */
+&cp1_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp1_comphy5 2>;
+	status = "okay";
+};
+
+&cp1_pinctrl {
+	/*
+	 * configure unused gpios exposed via pin headers:
+	 * - J7-8: RSVD16
+	 * - J7-10: THRM
+	 * - J10-1: WAKE1
+	 * - J10-2: SATA_ACT
+	 * - J10-8: THERMTRIP
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_rsvd16_pins &cp1_sata_act_pins &cp1_thrm_irq_pins>,
+		    <&cp1_thrm_trip_pins &cp1_wake1_pins>;
+};
+
+/* SRDS #3 - SATA */
+&cp1_sata0 {
+	status = "okay";
+
+	/* only port 1 is available */
+	/delete-node/ sata-port@0;
+
+	sata-port@1 {
+		phys = <&cp1_comphy3 1>;
+	};
+};
+
+&cp1_utmi {
+	/* M.2 "CON4" swaps D+/D- */
+	swap-dx-lanes = <0>;
+};
+
+&cp1_xmdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_xmdio_pins>;
+	status = "okay";
+
+	cp1_eth_phy0: ethernet-phy@8 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&com_10g_int1_pins>;
+		interrupt-parent = <&cp1_gpio2>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+&cp2_ethernet {
+	status =  "okay";
+};
+
+/* SRDS #2 - 5GE */
+&cp2_eth0 {
+	phys = <&cp2_comphy2 0>;
+	phy-mode = "5gbase-r";
+	phy = <&cp2_eth_phy0>;
+	managed = "in-band-status";
+	status = "okay";
+};
+
+&cp2_gpio1 {
+	pinctrl-names= "default";
+	pinctrl-0 = <&cp2_rsvd9_pins>;
+
+	/* J21 */
+	m2-wwan-reset-hog {
+		gpio-hog;
+		gpios = <9 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+		output-low;
+		line-name = "m2-wwan-reset";
+	};
+};
+
+/* SRDS #0 - PCIe */
+&cp2_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp2_comphy0 0>;
+	status = "okay";
+};
+
+/* SRDS #4 - PCIe */
+&cp2_pcie1 {
+	num-lanes = <1>;
+	phys = <&cp2_comphy4 1>;
+	status = "okay";
+};
+
+/* SRDS #5 - PCIe */
+&cp2_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp2_comphy5 2>;
+	status = "okay";
+};
+
+&cp2_pinctrl {
+	/*
+	 * configure unused gpios exposed via pin headers:
+	 * - J7-1: RSVD10
+	 * - J7-3: RSVD11
+	 * - J7-5: RSVD56
+	 * - J7-6: RSVD7
+	 * - J7-7: RSVD27
+	 * - J10-3: RSVD31
+	 * - J10-5: RSVD5
+	 * - J10-6: RSVD32
+	 * - J10-7: RSVD0
+	 * - J10-9: RSVD1
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp2_rsvd0_pins &cp2_rsvd1_pins &cp2_rsvd5_pins>,
+		    <&cp2_rsvd7_pins &cp2_rsvd10_pins &cp2_rsvd11_pins>,
+		    <&cp2_rsvd27_pins &cp2_rsvd31_pins &cp2_rsvd32_pins>,
+		    <&cp2_rsvd56_pins>;
+};
+
+/* SRDS #3 - SATA */
+&cp2_sata0 {
+	status = "okay";
+
+	/* only port 1 is available */
+	/delete-node/ sata-port@0;
+
+	sata-port@1 {
+		phys = <&cp2_comphy3 1>;
+	};
+};
+
+&cp2_xmdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp2_xmdio_pins>;
+	status = "okay";
+
+	cp2_eth_phy0: ethernet-phy@8 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&com_10g_int2_pins>;
+		interrupt-parent = <&cp2_gpio2>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
new file mode 100644
index 000000000000..afc041c1c448
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
@@ -0,0 +1,712 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/*
+ * Instantiate the first external CP115
+ */
+
+#define CP11X_NAME		cp1
+#define CP11X_BASE		f4000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe2000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f4600000
+#define CP11X_PCIE1_BASE	f4620000
+#define CP11X_PCIE2_BASE	f4640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+/*
+ * Instantiate the second external CP115
+ */
+
+#define CP11X_NAME		cp2
+#define CP11X_BASE		f6000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe5000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f6600000
+#define CP11X_PCIE1_BASE	f6620000
+#define CP11X_PCIE2_BASE	f6640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+/ {
+	model = "SolidRun CN9132 COM Express Type 7 Module";
+	compatible = "solidrun,cn9132-sr-cex7", "marvell,cn9130";
+
+	aliases {
+		ethernet0 = &cp0_eth1;
+		gpio3 = &cp1_gpio1;
+		gpio4 = &cp1_gpio2;
+		gpio5 = &cp2_gpio1;
+		gpio6 = &cp2_gpio2;
+		i2c0 = &cp0_i2c0;
+		i2c1 = &cp0_i2c1;
+		i2c2 = &com_clkgen_i2c;
+		i2c3 = &com_10g_led_i2c;
+		i2c4 = &com_10g_sfp_i2c0;
+		i2c5 = &com_smbus;
+		i2c6 = &com_fanctrl_i2c;
+		mmc0 = &ap_sdhci0;
+		rtc0 = &cp0_rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 51 102 153 204 255>;
+		#cooling-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_fan_pwm_pins &cp0_fan_tacho_pins>;
+		pwms = <&cp0_gpio2 7 40000>;
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	v_1_8: regulator-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	ap_vhv: regulator-ap-vhv-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "ap-vhv-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		pinctrl-0 = <&cp0_reg_ap_vhv_pins>;
+		pinctrl-names = "default";
+		gpios = <&cp0_gpio2 21 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	cp_vhv: regulator-cp-vhv-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "cp-vhv-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		pinctrl-0 = <&cp0_reg_cp_vhv_pins>;
+		pinctrl-names = "default";
+		gpios = <&cp0_gpio2 17 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&ap_pinctrl {
+	ap_mmc0_pins: ap-mmc0-pins {
+		marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3", "mpp4", "mpp5",
+					   "mpp6", "mpp7", "mpp8", "mpp9", "mpp10", "mpp12";
+		marvell,function = "sdio";
+		/*
+		 * mpp12 is emmc reset, function should be sdio (hw_rst),
+		 * but pinctrl-mvebu does not support this.
+		 *
+		 * From pinctrl-mvebu.h:
+		 * "The name will be used to switch to this setting in DT description, e.g.
+		 * marvell,function = "uart2". subname is only for debugging purposes."
+		 */
+	};
+};
+
+&ap_sdhci0 {
+	bus-width = <8>;
+	pinctrl-0 = <&ap_mmc0_pins>;
+	pinctrl-names = "default";
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};
+
+&ap_thermal_ic {
+	polling-delay = <1000>;
+
+	trips {
+		ap_active: trip-active {
+			temperature = <40000>;
+			hysteresis = <4000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&ap_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 4>;
+		};
+
+		map1 {
+			trip = <&ap_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+&cp0_eth1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_eth1_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&cp0_eth_phy0>;
+	status = "okay";
+};
+
+&cp0_gpio1 {
+	status = "okay";
+
+	/*
+	 * Tacho signal used as interrupt source by pwm-fan driver.
+	 * Hog IO as input to ensure mvebu-gpio irq driver`s
+	 * irq_set_type can succeed.
+	 */
+	pwm-tacho-irq-hog {
+		gpio-hog;
+		gpios = <26 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+		input;
+		line-name = "fan-tacho";
+	};
+};
+
+&cp0_gpio2 {
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	com_eeprom: eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+
+	eeprom@53 {
+		compatible = "atmel,spd";
+		reg = <0x53>;
+	};
+};
+
+&cp0_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9547";
+		reg = <0x77>;
+		i2c-mux-idle-disconnect;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		com_clkgen_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			/* clock-controller@6b */
+		};
+
+		com_10g_led_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			/* Routed to B2B Connector as I2C_10G_LED_SCL/SDA */
+		};
+
+		com_10g_sfp_i2c0: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			/* Routed to B2B Connector as I2C_SFP0_CP0_SCL/SDA */
+		};
+
+		com_smbus: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			/* Routed to B2B Connector as SBM_CLK/DAT */
+		};
+
+		com_fanctrl_i2c: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			/* fan-controller@2f (assembly option) */
+		};
+	};
+};
+
+&cp0_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_mdio_pins>;
+	status = "okay";
+
+	cp0_eth_phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&cp0_spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi1_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		com_10g_int0_pins: cp0-10g-int-pins {
+			marvell,pins = "mpp24";
+			marvell,function = "gpio";
+		};
+
+		cp0_eth1_pins: cp0-eth1-pins {
+			marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
+				       "mpp4", "mpp5", "mpp6", "mpp7",
+				       "mpp8", "mpp9", "mpp10", "mpp11";
+			/* docs call it "ge1", but cp110-pinctrl "ge0" */
+			marvell,function = "ge0";
+		};
+
+		cp0_fan_pwm_pins: cp0-fan-pwm-pins {
+			marvell,pins = "mpp39";
+			marvell,function = "gpio";
+		};
+
+		cp0_fan_tacho_pins: cp0-fan-tacho-pins {
+			marvell,pins = "mpp26";
+			marvell,function = "gpio";
+		};
+
+		cp0_i2c0_pins: cp0-i2c0-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "i2c0";
+		};
+
+		cp0_i2c1_pins: cp0-i2c1-pins {
+			marvell,pins = "mpp35", "mpp36";
+			marvell,function = "i2c1";
+		};
+
+		cp0_mdio_pins: cp0-mdio-pins {
+			marvell,pins = "mpp40", "mpp41";
+			marvell,function = "ge";
+		};
+
+		cp0_mmc0_pins: cp0-mmc0-pins {
+			marvell,pins = "mpp56", "mpp57", "mpp58", "mpp59",
+				       "mpp60", "mpp61";
+			marvell,function = "sdio";
+		};
+
+		cp0_mmc0_cd_pins: cp0-mmc0-cd-pins {
+			marvell,pins = "mpp55";
+			marvell,function = "sdio_cd";
+		};
+
+		cp0_pwrbtn_pins:  cp0-pwrbtn-pins {
+			marvell,pins = "mpp31";
+			marvell,function = "gpio";
+		};
+
+		cp0_reg_ap_vhv_pins: cp0-reg-ap-vhv-pins {
+			marvell,pins = "mpp53";
+			marvell,function = "gpio";
+		};
+
+		cp0_reg_cp_vhv_pins: cp0-reg-cp-vhv-pins {
+			marvell,pins = "mpp49";
+			marvell,function = "gpio";
+		};
+
+		cp0_spi1_pins: cp0-spi1-pins {
+			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+			marvell,function = "spi1";
+		};
+
+		cp0_spi1_cs1_pins: cp0-spi1-cs1-pins {
+			marvell,pins = "mpp12";
+			marvell,function = "spi1";
+		};
+
+		cp0_uart2_pins: cp0-uart2-pins  {
+			marvell,pins = "mpp50", "mpp51";
+			marvell,function = "uart2";
+		};
+	};
+};
+
+&cp0_thermal_ic {
+	polling-delay = <1000>;
+
+	trips {
+		cp0_active: trip-active {
+			temperature = <40000>;
+			hysteresis = <4000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cp0_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 4>;
+		};
+
+		map1 {
+			trip = <&cp0_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+/* USB-2.0 Host */
+&cp0_usb3_0 {
+	phys = <&cp0_utmi0>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* USB-2.0 Host */
+&cp0_usb3_1 {
+	phys = <&cp0_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp1_gpio1 {
+	status = "okay";
+};
+
+&cp1_gpio2 {
+	status = "okay";
+};
+
+&cp1_rtc {
+	status = "disabled";
+};
+
+&cp1_spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp1_spi1_pins>;
+	status = "okay";
+
+	tpm@0 {
+		reg = <0>;
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		spi-max-frequency = <10000000>;
+		pinctrl-names  = "default";
+		pinctrl-0 = <&cp1_tpm_irq_pins>;
+		interrupt-parent = <&cp1_gpio1>;
+		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&cp1_syscon0 {
+	cp1_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		com_10g_int1_pins: cp1-10g-int-pins {
+			marvell,pins = "mpp50";
+			marvell,function = "gpio";
+		};
+
+		cp1_10g_phy_rst_01_pins: cp1-10g-phy-rst-01-pins {
+			marvell,pins = "mpp43";
+			marvell,function = "gpio";
+		};
+
+		cp1_10g_phy_rst_23_pins: cp1-10g-phy-rst-23-pins {
+			marvell,pins = "mpp42";
+			marvell,function = "gpio";
+		};
+
+		cp1_batlow_pins: cp1-batlow-pins {
+			marvell,pins = "mpp11";
+			marvell,function = "gpio";
+		};
+
+		cp1_rsvd16_pins: cp1-rsvd16-pins {
+			marvell,pins = "mpp29";
+			marvell,function = "gpio";
+		};
+
+		cp1_sata_act_pins: cp1-sata-act-pins {
+			marvell,pins = "mpp39";
+			marvell,function = "gpio";
+		};
+
+		cp1_spi1_pins: cp1-spi1-pins {
+			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+			marvell,function = "spi1";
+		};
+
+		cp1_thrm_irq_pins: cp1-thrm-irq-pins {
+			marvell,pins = "mpp34";
+			marvell,function = "gpio";
+		};
+
+		cp1_thrm_trip_pins: cp1-thrm-trip-pins {
+			marvell,pins = "mpp33";
+			marvell,function = "gpio";
+		};
+
+		cp1_tpm_irq_pins: cp1-tpm-irq-pins {
+			marvell,pins = "mpp17";
+			marvell,function = "gpio";
+		};
+
+		cp1_wake0_pins: cp1-wake0-pins {
+			marvell,pins = "mpp40";
+			marvell,function = "gpio";
+		};
+
+		cp1_wake1_pins: cp1-wake1-pins {
+			marvell,pins = "mpp51";
+			marvell,function = "gpio";
+		};
+
+		cp1_xmdio_pins: cp1-xmdio-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "xg";
+		};
+	};
+};
+
+&cp1_thermal_ic {
+	polling-delay = <1000>;
+
+	trips {
+		cp1_active: trip-active {
+			temperature = <40000>;
+			hysteresis = <4000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cp1_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 4>;
+		};
+
+		map1 {
+			trip = <&cp1_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+/* USB-2.0 Host */
+&cp1_usb3_0 {
+	phys = <&cp1_utmi0>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp1_utmi {
+	status = "okay";
+};
+
+&cp2_ethernet {
+	status = "okay";
+};
+
+&cp2_gpio1 {
+	status = "okay";
+};
+
+&cp2_gpio2 {
+	status = "okay";
+};
+
+&cp2_rtc {
+	status = "disabled";
+};
+
+&cp2_syscon0 {
+	cp2_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		com_10g_int2_pins: cp2-10g-int-pins {
+			marvell,pins = "mpp50";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd0_pins: cp2-rsvd0-pins {
+			marvell,pins = "mpp0";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd1_pins: cp2-rsvd1-pins {
+			marvell,pins = "mpp1";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd2_pins: cp2-rsvd2-pins {
+			marvell,pins = "mpp2";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd3_pins: cp2-rsvd3-pins {
+			marvell,pins = "mpp3";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd4_pins: cp2-rsvd4-pins {
+			marvell,pins = "mpp4";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd5_pins: cp2-rsvd5-pins {
+			marvell,pins = "mpp54";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd7_pins: cp2-rsvd7-pins {
+			marvell,pins = "mpp7";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd8_pins: cp2-rsvd8-pins {
+			marvell,pins = "mpp8";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd9_pins: cp2-rsvd9-pins {
+			marvell,pins = "mpp9";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd10_pins: cp2-rsvd10-pins {
+			marvell,pins = "mpp10";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd11_pins: cp2-rsvd11-pins {
+			marvell,pins = "mpp11";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd27_pins: cp2-rsvd27-pins {
+			marvell,pins = "mpp11";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd31_pins: cp2-rsvd31-pins {
+			marvell,pins = "mpp31";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd32_pins: cp2-rsvd32-pins {
+			marvell,pins = "mpp32";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd55_pins: cp2-rsvd55-pins {
+			marvell,pins = "mpp55";
+			marvell,function = "gpio";
+		};
+
+		cp2_rsvd56_pins: cp2-rsvd56-pins {
+			marvell,pins = "mpp56";
+			marvell,function = "gpio";
+		};
+
+		cp2_xmdio_pins: cp2-xmdio-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "xg";
+		};
+	};
+};
+
+&cp2_thermal_ic {
+	polling-delay = <1000>;
+
+	trips {
+		cp2_active: trip-active {
+			temperature = <40000>;
+			hysteresis = <4000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&cp2_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 4>;
+		};
+
+		map1 {
+			trip = <&cp2_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+/* USB-2.0/3.0 Host */
+&cp2_usb3_0 {
+	phys = <&cp2_utmi0>, <&cp2_comphy1 0>;
+	phy-names = "utmi", "comphy";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp2_utmi {
+	status = "okay";
+};
+
+/* AP default console */
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.35.3


