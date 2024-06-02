Return-Path: <linux-iio+bounces-5640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7EF8D76E6
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5A2B222CF
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389758AA5;
	Sun,  2 Jun 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bH+VZ+Px"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2135.outbound.protection.outlook.com [40.107.7.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E78537F8;
	Sun,  2 Jun 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343389; cv=fail; b=mhcbY54juqg8UloOXDjXVWodXY4TZpF79kIqv/Bb0HZ7LsakvJ/t2+0euuu6cPqd6wXgXyAR7OmHsxCxryEZOuQLkgPUzprxaEC4RG5QYtyLUPXYuLXJuD0hJjLYg4oa7/InaooIR5UifeEZahZQ7zZa+0sKDkgBwdeBDd6t1AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343389; c=relaxed/simple;
	bh=mQWroSb7kMnehyNzCCHX6s2dTYjFnSgTfg/7QjZ2uJY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NksNt/98+4XHW/tRMntaNLEl2sVp0H0mMwSSkQZqwJ6zql69nWpSv28cAQFk/TS599xL3jcPLhxrNb59TONqoVNwvlMgVnGvz21JiMy0ukqEPUew0VKFoBvjCwqKWzeIlg/upWkW/j/ahAehnAYnspRR90/yBepvsau4vUM6CFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bH+VZ+Px; arc=fail smtp.client-ip=40.107.7.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+CahvoobQLAM4RyQfW2z8COC4Ket2cSW48UXPnTiNgZfojaiypGIl4BvyZHemWRpJxEInG1lK7uXBxnCXg8HsGjdMnyH7pPcktoz7oUuEePOQrAKgAjeQ9WVPUnQxvbSlwnrST2vlvn/L/XoWLoxtLixpAKC1816krjXVRm2+0XM04hI5RB8DL9HRC39y8EfeGk6aDFhI/+xOHq9a7lEQTIG+JHM0cogWMWRMw20BlDWx3QCaCG9+7kaWACfHklCGjyxgfsMYcSo8qhb48AhXrhqixRaS8k0QTeRWf414bBQxNZ13aEW7GAKIpWc3JNWhZzM018cV6g8zFjRyRzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlQy4rBk6ixkdbPr4GAxyRHBN7NhXDroHp6p2aHDx64=;
 b=OLC2w3gLwsNhKczuAb/olULrhayglVA9iy4sJzUYNfCMuATpfaYEJDsm0bqsPp5vtl4IakI5sZsyWfoLFEfZKZBPvkvkzMgPf+F98Va2whUQ/Ai2LpdOjGe6wj4f5trsKAPWEfhECtz29iH5+beKa6E5Gvxe4CBPMF4ufxmW0ZANMGGP3RYeVqvLJMS/pFr5NawODxfhCo/o66AVeYTvt9z7+Cw+uKsK9U6AHKbPSOyi68TXZiKXVShkkWIK7NIjl/oBCke8qZm/Wvw5WqmIdKFIkx+2/bmcMG3F/9POVOzYTr9fTh7jTpEuGuOQmEzVEHxAdL+Yg+OoxjSHx2ECLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlQy4rBk6ixkdbPr4GAxyRHBN7NhXDroHp6p2aHDx64=;
 b=bH+VZ+PxMz1PBZ+DRsxWAPyeKNw94A5+J89bJCJrOvXApz/u+YzPDJX7VchxxqvLQG2IQVdMPjy+xjwxEb49IMioGI+/++mO/K6cX3bInYNBKWWmMx25V/QQaqj2bIhyDlxLSg1njIP4pQLPFalEz6e8H7+xXrMdnAc8+zuED1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7512.eurprd04.prod.outlook.com (2603:10a6:20b:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Sun, 2 Jun
 2024 15:49:40 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 15:49:40 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 02 Jun 2024 17:49:37 +0200
Subject: [PATCH v6 2/7] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240602-cn9130-som-v6-2-89393e86d4c7@solid-run.com>
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
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
X-MS-Office365-Filtering-Correlation-Id: af5af09c-c14d-49b0-5ee0-08dc831b9d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWh5WEoxaWNIRzNSUzIvQ3BhY2kzVU5JaG5URFpDOWVzUGJnR1BDWDNIcWlZ?=
 =?utf-8?B?K0lGWXozQU1aNmNYSU9hRU9kZFN1RVlEOTN3bGJKaDNuK2pDa0s1WGlWcDBp?=
 =?utf-8?B?ZkZib3Q5WkZSM3hUOHNFWldTWUswSU1BYU5UTnVDYjZPRkRhaTNhWmYzQ0pm?=
 =?utf-8?B?aVdaVld6QmNvbHl4S050OGw2anNrYXJpY2JrOGVYWWFtSHAwcFJ3RHNEZHAr?=
 =?utf-8?B?NHluRGtWdDRiY0N2UEdqejlibUkyZnZ0ak1jcHh1UnBIdXJ3MHZQMk9ZYkoy?=
 =?utf-8?B?UnFvWlpxMTNmUzdVcDdvRmZhaDdJeVJBZjdkWjIxYTRGRktLR1orVUF5eXR6?=
 =?utf-8?B?SG1KT3pjVXI5dHJXclJTYUgzdmsyTEEyaXFaOUtERVJmeWV5K3VFcXNMZWZt?=
 =?utf-8?B?c09ia3NWY2xic0llOE9qZ091citTU3lVcjM5UjlKZ0IzMVlqK3o4VFJDVnV6?=
 =?utf-8?B?SmV4YUZqenlNMlJmNklOZVZFWmwvYUdSK1ZSenRwZ3VoektsUXJObWx2Mmdq?=
 =?utf-8?B?aWM5cWRYQ1V6WTg2MHFZMHZhTVMzSiswR0JqcDFVNE5RWHU3dHk4M2Fldm1v?=
 =?utf-8?B?NjdqTHN4NERNNDlXRkJ0RUx1RlB1OEpod3JIa0lBQm9RNEJTcmE2VkdOZWk0?=
 =?utf-8?B?S0NLY0IwOFlSdXdYYThSNDg1VFVNcDIvREtRZFMyVFJlZUhtTkRmeXR3OU12?=
 =?utf-8?B?dHZ4a2hHeGNUMVpPVEl5OFV6NDBFemJDQnh4QURPTTVmOE9MZWMwMFRsbXRk?=
 =?utf-8?B?ZmRnZ1M4alJnYTNSeUl4R2lVMHFiVUFsNWNubnFvMlJIcE80a1pjVVRWTW1z?=
 =?utf-8?B?YVp2dHd5TWZyZDc4N3N3QjdkaWU1OEhFMWxIWVNCWTBJSHVhMUR1WDBNRFln?=
 =?utf-8?B?MCtrdmcvSnNzbFVUQkprSnphYjBMZ21zN3FBRHJ2Y0FNOWx0STVKbDU2eE1N?=
 =?utf-8?B?OEtkdzE0cUU1QjhqNUM4dXZONzFPbzFNbEh4U1I1K3hzVFdIckwwREJLRzRr?=
 =?utf-8?B?UGlCY3FXc1lZem5BeVA0bk00US82a0kzT1FYKy90MllUdGE0dGtzSmZCSnp0?=
 =?utf-8?B?SmpoWmMrcFk5L3grbWtjQ2QzVUIySkk2TFhScGZ3eTFRWGY1dUp0RzBwOUVG?=
 =?utf-8?B?SHFLOStsTFhKYmN0M0h1NmxQOGdYbm9Ec0VYRnpTaG1pME9PUXhmbkhCajlG?=
 =?utf-8?B?TnF0RVNZV25ZYlFPUHNHK1JIYllvcGJwVzJ4TWlVdWc3SEhZQWpiUjFnUVp2?=
 =?utf-8?B?RVN5QXVLSVcvbW5RZ1JXU01wZGtlY1Q1WWJzS04yaUp4Q1kxUE0yeXU1TllR?=
 =?utf-8?B?WXFsYzNmTlFzL0t4VzUvSnpMM0h3b2xGZWU3Z0tlN3dPUGdNMmJKb2hCblBL?=
 =?utf-8?B?Q2ltMXRpdThTWTQ1WC9qaTVnRmNBRC90R3RvSmpGUGkrNENyS0dMSFNxWDlx?=
 =?utf-8?B?Ri92R2c4T0VmTkZZdkNSMHlSR0l4Tlc1dkkyV0ZreldCdXVWclBEQXJYWnU2?=
 =?utf-8?B?c1FRNDArTG14REtFd1hPYmZETjJLMjJBN2pQazBEN3JVQVhJOHd1RWJXdFd3?=
 =?utf-8?B?ZUhlYjVGSzlGNlJXck11TDk4QzhiRzBqbU9OM2cwSHlBZ0NaL3ViWFAvTEY5?=
 =?utf-8?B?eUM0TG5xazZ2ZUpxeWNNVFVFOThsWklEM3dQTWFBRUFQNmRuZnlkZmNHRGFz?=
 =?utf-8?B?RkZQM1NDNEI4MFpQUFN2dzBlTWNyTS8rVHVlT2hxcThZZ0RtUUx3UzhyZFJN?=
 =?utf-8?B?alJ3UVhGeElqRmoyc3JSSlF5L3ZKaStmZnI3K3dFenBxcHAxTDlSMk9nenll?=
 =?utf-8?Q?SlpTawqSH891zVRNofYq+lc74Svtf0ZHdU34g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmNOWmc3cWJha0d5NWhTUW5xS1BITkVBcXBSbVNuaTFOWVNwcG5aMTdNVHJ4?=
 =?utf-8?B?SEs0Mk5OSmFUYm1QMzNWKzczTDJEdktZckt2U0VYNTc4OTlMVW4vT2Y3YWhO?=
 =?utf-8?B?eFZmVWI0SGNIWnJPUkpxZ3o5SXIzcDRuSEgvY0E3dDQ5Y1ZEeFBMQjlWQ0tH?=
 =?utf-8?B?cnV2bHovanNTamorYllRcUZ3ZXhSaWI2aFR1ZDYvcXBQVzJYUXZ4bVhmK3pN?=
 =?utf-8?B?THlFUHJFdjFHZXh2WVRDM05zdGVJR01kK2xHcnBMZnQ0TkRicXpLQ0t6RHc1?=
 =?utf-8?B?Y21WakFPajNjMFNuM1pUZmpZMnVCQ012NERvc2EycEZmdEVIL0hCaHFmazh1?=
 =?utf-8?B?T1hGczhoNHU2dXBsNVQ4K3dyd3ZJK1JvWFVOeTluT2VHbEN6STRvWG5Xdndw?=
 =?utf-8?B?RkZxaVNxZ3dJekxIZlBDSTFOL2NWTGFOMWtleUY3VGxTWEYxaFBQblI0U3hF?=
 =?utf-8?B?K0FhdXM4OURxUzllZEtobUZIZ2l4QU81cDlUdHEzQk5HYlY0MUdnZzBoZVJq?=
 =?utf-8?B?TmxNRnVZSHZqRzJzYzZ3OGI5N2QvTEZyTS8vVFRvSitNSU9NdTluaFh1MU5G?=
 =?utf-8?B?QkNFUGJKcEltYWFFaTV6c0l2THVYaHN2ZjFRZ3lUZlBEVkg1RGZ2R2FBRTc1?=
 =?utf-8?B?OVVTanhRTjB6Ym5VVzROMTRTcnA5Tmg3Zlg4ZkVoL2pSL0RLWnhjM1ZwTzlQ?=
 =?utf-8?B?bzI0TUVqQm9ob1FIV0grTVRZTWRWaFJyMVo5UEtnc3FFb0szQ3lWQjVIb3A1?=
 =?utf-8?B?bzIzUUw3NGpuWDFDT3QvODdOdktyK1MxcmlSWllCVXNEK2V5OEsydGRjdUI3?=
 =?utf-8?B?Wlh5U0xkSFA3NUdBQjZCaUtacFNsU3BsRkZXQ0s5WW9Fa3lmMzdvV2VsWHVl?=
 =?utf-8?B?WWZWMU53b3RkWVlZejNnRThmNGluZ01ROFVEOEdsV21Ic2RhdmswZ2ZFQUxz?=
 =?utf-8?B?cFcvaXdzRERtNCtQUm9MV1VPbXJTZEx1d0dSeWw0L1JCSnR4Z25lYjBxaTU2?=
 =?utf-8?B?aWR5b09WRFRFQlVSK3YvLzVQZ2ZHejBrdFozSkFKK0tGY1pLOHIrTFAxSlFJ?=
 =?utf-8?B?UGNyZTFuamJqS2I5MGtVaktOazNYMWQzMmV5Y2gxdXpnMmN1ZEY4M29NNHBj?=
 =?utf-8?B?Qm1MQ1FuNnhvSTYzTlFSMUhTbW0xTitCVFRwN2ZOT1BzZjZxZUlzUG1BNlFL?=
 =?utf-8?B?eVZzUmZuRzU4R0V2TmRMTUM3eGNyVDRiMmFPc01rQS9vVE11ZWRFanlyS2M1?=
 =?utf-8?B?WmM5TWVJSmRLWlNUTk1HTVh1UWdKWTZDcStHMjVYZWtjMG1lSkY4UjVEVWxQ?=
 =?utf-8?B?bE10QnZTamt3QWJKWkV0ZmRJdklGL2Y4amxIVUZzSEJjZkpCVXBZemErY2tY?=
 =?utf-8?B?bURoNGdkTGFOK3M0ak1ISzZhbXBDSG5lMVdvT2FCNVYraXJUSi9NMktXWlg2?=
 =?utf-8?B?TlRZTVAxZXE5ODllalFVdHpuWVNrYmd1K1pITHhkUy9vc01sMW9ZTXhBeEFE?=
 =?utf-8?B?MmpwKzVmckFPUTduaHNxalhQZlVuWlZtMDVGSkdkaU1LcmtrSC8yT096MFFO?=
 =?utf-8?B?ZFRUQytDQ1ppcEJYZ3kyVFQ0MXFyTTc0MFZmR0xpV3ZyUjRnMUlGdkkxVWtY?=
 =?utf-8?B?ek5mT2JiT0RhWUpvcnpNWTM1Q2FLdWx3SElVZUIxblFZMGVwdWdVbFlaYm0w?=
 =?utf-8?B?K2x0U3VsTnNiYkZaVDVld1BaMGI0b3NtOHZ5cUJyaEw5dE44cllMeHROUVAw?=
 =?utf-8?B?UllPSjZDeGtWZUF5UVFYWFN4anVHQStTZmw1VG1VbmhsWWJmRGpHTmgxV29S?=
 =?utf-8?B?OHFQeDJrbTVxY1dnazZLQWdoOVFCTEdvYUxzbDhYdEg3Zm4yS1gyNkRNNldK?=
 =?utf-8?B?alZRNnV2QTlPdUd2U1lqWXVkMGJRQ21BN1RkZEk2S2VnWVZJUG9xQWJJbTlG?=
 =?utf-8?B?YmplOXdSbURTSGplV0NIZHE2SUhhb1F3S3pLb3k4UmhQMUZCVUdyVEdzb2pW?=
 =?utf-8?B?TGxSQkQ4dUkvTUd4YXRlK2VyMnBPNlVuektLT3A4ZUQvcXh3OTRoMmlQNmtn?=
 =?utf-8?B?Nk4vLzU1N1d3b29Ebko0VmtrRVA4eURmWjVmLzBXbjN4Q2hHSkpxeEN1ZUVU?=
 =?utf-8?Q?wTjEUBV7lMKoDr3gpbR6dTC5X?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5af09c-c14d-49b0-5ee0-08dc831b9d5a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 15:49:40.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAUUKqBHk51hs1gSjiJXEjKeVJeKeKSW7I8h35i0mpYRM8TRfxeRrrJwIBkZjYBV/BWl1Z/53NmzLE19R1aFnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7512

Add bindings for the SolidRun CN9132 COM-Express Type 7 evaluation board.
The CEX is based on CN9130 SoC and includes two southbridges.

Because CN9132 and 9131 are just names for different designs around the
same SoC, no soc compatibles beside marvell,cn9130 are needed.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 74d935ea279c..538d91be8857 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -92,4 +92,12 @@ properties:
           - const: solidrun,cn9130-sr-som
           - const: marvell,cn9130
 
+      - description:
+          SolidRun CN9132 COM-Express Type 7 based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9132-clearfog
+          - const: solidrun,cn9132-sr-cex7
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


