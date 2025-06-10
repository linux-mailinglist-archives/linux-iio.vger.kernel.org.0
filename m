Return-Path: <linux-iio+bounces-20359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13552AD3976
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 15:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965799C3890
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B723ABA9;
	Tue, 10 Jun 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Av4ts+gs"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5A23ABA1;
	Tue, 10 Jun 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562147; cv=fail; b=TMUsaoyjVSEVjis+kBz035SIy6dMPPy7ZwfKX3+zLi5BNwwWsFgjOGJ3ev+jzdRTZ8P2O67e9ZzaOx+qju+Ly8fxhcAXKu1To5xVzs39wEdM/6swVa7K+dK2xG2a28Trl/mwIDBEayEGz2/HqkzLfdHawwccLYcDHFrN1Lt2ypw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562147; c=relaxed/simple;
	bh=oZeEyeSxJ5VQK3bPLCcQkX16w/d8U7n2ei4/rrp5Kvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCYOXX6AEfYiYRwaTb++ZdWW5sewdVDBT2Y1COHadu91d4qPheG4qtgjSCuWskjfg9ZW2HbToV7cSC5fM8OhGEoGynaZr39LpAgZqS0h1lEU7JfoJm/TAy9zpqRoOXVzGmDUC3LYNZo2lpIdJSpWWU0igMvnvS6YtkHppzHxjus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Av4ts+gs; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hksYDWc1spR/qidopEza9Xl/4sXwYQ7X+xkq7ztBZrbo4BqojF2UqDYf4aldo2CMRY9aSzTUyAsV129sUhLCFHV852FHfiT4ch7OLNaVNO1VK2tvFK/NhbiDLSWyVWzag1njW2230v9JSpEHeImtGci2brfKxe5R8JTEzLUu7WMQtRJjeYOk/ynngP5hPFpKRXa2lZKkoGJH3K8dTPY0mVUYnHrkh3Vvi3flFwZ0NqsW3FfgWionp4Q19ufggiNmpxeXXZNsLfpbv+a7eQyuMbG/dzrsTyORNTbl5DYY1xK0aB1uypYyuuiCNT7lmkuSWGIpaTTNTdwCm/dDSrtkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZeEyeSxJ5VQK3bPLCcQkX16w/d8U7n2ei4/rrp5Kvk=;
 b=PmJKkee+tq6/8zRiS9v4ddVANdyahdyCMkYPnaj1Yja/gT7KtAeLdT+PBhbjZgNwnpI5AT9v6rXhK4nhthV0bvMeuK8IQjvFsipMYoRwIvQ/bV8wO0uElSXKFPArbBvR4IeczVa6f1A0rrOwrBftFnmKP15qbfkaIwyPRNzRsf/acqWRd6b09MbpV73wTug7lKI1BH4e79d5VRcHtXmCQLjMdQoW2MaOWBOlGNM1yJtRWE1/tl88UmPeSoLS7KssTwqpfzNB1dQ2LhpcUAFkebkOFMXkoo5FPQ3ITJwiXvXNuuJlLqcOCH9XcAgUPuDHfE5HiDV54RGKFgQfevXd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZeEyeSxJ5VQK3bPLCcQkX16w/d8U7n2ei4/rrp5Kvk=;
 b=Av4ts+gsUB3A/2xIz3sQG/VpEgmPoNAFHvV0V2yHH9A8uMFqpcj9875sP/VQJrQ/0ongYU8lbYxW8pEEveXdO2nKcamlixVmfKAe6fkb0Gx4L0ELsHehXrREqjvGcgIXKMG9zPv1+MozpyCYRtSNls+GO4YXz7lw59XBB/MTbIOYotjjmQHWaww/nHiQ1T0iK+LXFCyno2s/O3onLx13B5rUtyLNAeXbT+DbkFi/UfVQce1I+P1t0ax2UG8ooBVwJVCUHVipRGNa0x2o5E0Y9ouKaTNf9xIaf0xLMSWegJ2CssHDZCB7wLckY6GTZb1HfbK9BONbezKe/kV8hWKtfQ==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.24; Tue, 10 Jun
 2025 13:29:01 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 13:29:01 +0000
From: <Victor.Duicu@microchip.com>
To: <conor@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<jic23@kernel.org>, <krzk+dt@kernel.org>, <andy@kernel.org>,
	<linux-kernel@vger.kernel.org>, <Marius.Cristea@microchip.com>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Thread-Index: AQHb0H02VwkVCnAA/0y86KUckGKYY7Pp6dIAgAFrrACABKRxAIAGULeAgAYrnwA=
Date: Tue, 10 Jun 2025 13:29:01 +0000
Message-ID: <c5de1b615c40cd4d4380cf5f340bda3da23f4069.camel@microchip.com>
References: <20250529093628.15042-1-victor.duicu@microchip.com>
	 <20250529093628.15042-2-victor.duicu@microchip.com>
	 <0f68e3f9-cba5-4df3-8e56-2cccbccf35ce@baylibre.com>
	 <20250530-dramatize-camisole-0a1aa9a38281@spud>
	 <91c1d757a4ac051c115a821779a8c1fba764ea05.camel@microchip.com>
	 <20250606-unfeeling-legacy-c7eab453b062@spud>
In-Reply-To: <20250606-unfeeling-legacy-c7eab453b062@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|SN7PR11MB7592:EE_
x-ms-office365-filtering-correlation-id: d862c9e4-84dc-4e10-de6b-08dda822c362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGJGK2owN3VpSWpSNXAyMEgrWVoyUWVQd3ZnNW1WMlhnclZXdWlWaGQ0TEtl?=
 =?utf-8?B?dXBIQ3Y2N0gxeEoxYkpFVmdhTDlqN0dmVlV3ZS9BSXh2RDJhVnpXL1hiSUFP?=
 =?utf-8?B?Z3R3UlQxcnllNmdMdWpuTndUR2trM0FxMDdwNDNxSGtsTnlzNk9kRUU4N1g0?=
 =?utf-8?B?UXNFWjhGRHVxWkVPWk9FK3hwYkZMZXpoL29jOFFQTkZMekJ6SFowclQyYWV3?=
 =?utf-8?B?ZkRsSjl3Z1IzcXV6b2FRdVhzOTZ5NGM4MGVBN3QzYmdzY1dacHlDSURhMEVG?=
 =?utf-8?B?ZWRaQUdMZDVCb0JMbWRYZjBxemowR0NiM1dxc1MxWjBuTHk0S2U5eHM3YUJO?=
 =?utf-8?B?cFg1dWxQV0lWUUp5SnFEaC9XUlJISWNXYjJMMlA0bC84M1krZWZUZENXYURh?=
 =?utf-8?B?QzNXZW5mdkJ5bytEcUNBNmw3aVk2Skt3S05IbFhhQmNxMkxqbzdDQnY0RXJR?=
 =?utf-8?B?anJzNHU4WmROR0hCd2pnSFRKNHdRREdzN3ZtOVUxL0FpTEZyZGJ0a0l5aGhv?=
 =?utf-8?B?Z1VWS3QrTTE1VzdWa1I5M1Q2Zm81ejAwU1pWd25qZkZkaENVTmR4WmVoSTl5?=
 =?utf-8?B?RTFQd2pKcEJkc2NWYzZHVUJCNlFVZExia0tDWlI5c0FNV1VwUjZiRTdwRklY?=
 =?utf-8?B?UUUxZllkR0V2ajJpcm5zWnkvNzdwNVNiVjVwaEZJQitsM01wdTZDb3F4Qldr?=
 =?utf-8?B?L0JqeVhFL054K1JmQStxVllhODBIMWFIRTR6SmlIK0ZBenlxTlpXaHZaeDhC?=
 =?utf-8?B?RDFuVUhQOUhNUEtjTkJIc3g1d2VDdmhEWDAzQThXNEd6OHJuelBrZDc3WlM3?=
 =?utf-8?B?a1QyS3llYi81aURoK3huVHI1WmRieGliRWxVdFBwUHFpNXdKaWQ4RGFFUjZy?=
 =?utf-8?B?dVl6ckNoMzFIR2kyRkhWcThaSzhXbS9GQ2p6WlFtYXNNeUFkeElpbFdjTXp5?=
 =?utf-8?B?MFFoN3lmeVFROUpBNE1iNFcwUm5lUEpFLy90blBlcEhtSnRLRnQ3QmdHTWI3?=
 =?utf-8?B?akpNbVpwVzNVUS83UTBPV3VDQWVXc2Yxd3NjKzRvd1dtUjAzSWp5STR5SG1j?=
 =?utf-8?B?NjNab3hmTFRKUE1CQzdsYXNKa3dnR0lIa0VDYWk3ZGZsSVZSdTd1QVBzUVVE?=
 =?utf-8?B?NGZaNXFOazU4REo3aVdGVDNzek8xSm1BV2xJZ2RvUjMyTCs4YXBYWDBOZkMr?=
 =?utf-8?B?b1JCNEZJZXpGaVVKZVc3c3ZLNytCTDNVYmJmczA5Sm1LTE40WUZZVFAvSEpD?=
 =?utf-8?B?NXI2V3V4MlkvbEZ2bXhGcU96YVRJdWFoak5kSDVIaGF4UFlRK3NrRzVZd0Fq?=
 =?utf-8?B?dEZEWXVDNEF2RVphR2QrVlRTQjRZTklFT1ZLd0ZKZkxBYkJHb045T09YVTBm?=
 =?utf-8?B?YzJmYnU5cm0rcVduaU5lL2NWakoxSTY4SEtLZVRTUWVjNHFkdEt6dmRRME5D?=
 =?utf-8?B?UmtjQmdBN1ZFbVR0UFZtdWFUWFNqU0EvNHZINzkxeTc4WWkyemRkbnpRdDhK?=
 =?utf-8?B?MkpQSWdWY1ZIVWFpVmlOeDJpdU4zd2ovY1dDYktObXIxV3JJdUVlaDRGS050?=
 =?utf-8?B?a0hQRFM2UjYySjNDUDNDYnBZYU9zeXd5cFdlN1FrR2FRNXBTcy9XWnp1Y2Rz?=
 =?utf-8?B?ZVhGdmZpMVdQY0ZLdTVxSmpNQ1JCaER5WFlNL1BtMlRqbGZFQzh1a1IrdnVz?=
 =?utf-8?B?eFJreUhyV0grNUdOeGdaaEFKeHJhOWN5elpTU2FBZ0F0N1E2enFJQlVCajh3?=
 =?utf-8?B?R25wNHlmbHdvMHQwb25ad3RmMVBvdkpZenJ3UHpWZlpBNWV0QW9xODA1WWk3?=
 =?utf-8?B?TUlYWGk0dTd6WDVHdDFJZzd0U2JNbG4zRmhITkZ1WldvUEs3SzJFWXJIRFRh?=
 =?utf-8?B?ZFhMa211QkZoOTh4b2w5NGVJcVRzVkZVb2QrZHNrY1N2MStEK3pLbkZrYkZD?=
 =?utf-8?B?Z1dQS004RDk5bkpJblYzYXZJeDc1U0xjR1I4S3Z4b2VvdW9WZUtkNGFEQzJF?=
 =?utf-8?B?a2FUOG1NT2RRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU5MMktWblo2Q0ltWkROMS9BRjluZ0ZBVzZCQWxGaHpKVGQ5Y3NFOW80dzdO?=
 =?utf-8?B?Y1FJbG9rL3puY0dubGczT3AwelNMSENVaGdJNitnWTRiSkMwNlU5RXNDaVFW?=
 =?utf-8?B?S1UyNkJhbUFyalkyTEpBWFQ4c0luZnhPUk52Wmt1VnZteTlXWTFqaUN5SkZy?=
 =?utf-8?B?NGJlei9EWi9JVDJnb3dxbDRyRUNnVEpKRGMxd0h6S045ZTl4WUw1U0ptVjhy?=
 =?utf-8?B?ODRTR09OdG5ZSnpjc21ncmtrL2xIREpUTktrM2YrSDFFUEhoYXVDS1BMMUtD?=
 =?utf-8?B?VktJTWpObWJTQ0p4VGlIdFhmMnhFd0JoV0U5L0hsaW5xYjZDRitMUzBzTVpO?=
 =?utf-8?B?ekt5TWFpdlJVZVVoQzFZOTE3YzBNcXlKcC9mZzZKN1Fva1VQS21iZDJCb0pZ?=
 =?utf-8?B?V0dUV0lCTVdUWmtndmlNVWpTWXh0TGl6V0t2Q1kxaXNDME0wU2NPcmhlcHlH?=
 =?utf-8?B?SnRvVlZxMWZDMS9yKzJaYzArY0VUSDRpejd6TXlkRTlNdWJQd3lOcEsxN3B6?=
 =?utf-8?B?VllQaUtOTTdpMVdaU0VTaVNXMnZrV053ZVVGamRRbkx1Vkt3N0ZuOVRHUlBw?=
 =?utf-8?B?cEVQZzE3a0NYekhhOWdNcmkzVlZLVXRiSWI2L0k0UFFJaHRCSGdXb3hINzZY?=
 =?utf-8?B?NG4zcmkrZVFLblpsemxoRmFLRmxhOGVrZ1VaWW4vN2QrU3B3NG9iZDVoNVJL?=
 =?utf-8?B?VUpSano1WjNWY08yK3poQmVuL0Y0dXpGQ3krSDZ5OEwxb0JzNHlOY1YwaFoy?=
 =?utf-8?B?emluNmxYT0I4MXBXNTdPSmVlV0ZxM2FaU1RXZFdGU3NKYndUS216Mk1iV1FR?=
 =?utf-8?B?M1dWSGRFN2ZnSnY4Z3BrTVAyckFnNXF0Qko3clVPcVJ0WGkyRVEwTThLRUpi?=
 =?utf-8?B?b0JWL2JhYk1OQmwwRXY2SHdTNU1kdEVqdVlQVEkzOWhNYTl1MG1KdTRqdTVE?=
 =?utf-8?B?bitBSVFpdzJmUVVicC9xdUt3b0hxSmY3cW1mTGdCL0ZxVDI5eEZRQVAwbkdq?=
 =?utf-8?B?VWd3UEc0blNpb3JWdjFqd2NnWHVvUVIzZXFXSU1TSWRSTjFoejZ1cVdKZHYw?=
 =?utf-8?B?WU9qU2d3SU1FbUFIdEptVUdBKzJhc3J0Y2thK1FuamRhd29sa2Q5b1RuZlln?=
 =?utf-8?B?aUtNL2xYTGpCTUZsNW5teUJrb2tDcmNrSjNJUi8wTytiVCtjWlFwUUlCTFVm?=
 =?utf-8?B?ckRGRVpGeWU3Z1YzNy9OR3JrazVyWVNNbkhwR2xEK1ZSdHhMNm5COEJRWTFE?=
 =?utf-8?B?dkxxRDBFeS9hdkQ4UkpEUGNiNmYvb1VSNHJJNWFpTFJMOVBTY1Q3cytUL1Rl?=
 =?utf-8?B?d1loc0xCbTQxU2s3ZVpZdmc5RXo5WlVQK1REbUl6VVNMR3YzaVpvb3NKenIr?=
 =?utf-8?B?OG9pWTdwZStaVTloaEtHV0hPemV4L2xCeU53cTVXRXF4RXJ4M1lhd2tPd2F3?=
 =?utf-8?B?RnVZQzlLZlZLNC9LdEtMelVScWRwNmJPbEFMTWdIaUJHY0dNbnkycWs3TExh?=
 =?utf-8?B?cXJjUmoxOHVmYmhNb2hvQVd1UU9Td2w5OGt4TFM3OWNKc3VRRkJWVjhEczhH?=
 =?utf-8?B?akpoaUk3cmxEeXpXVHBrSUNWZDlnTm9KSWxkWHczYk9UUU5UK2MzYmIzWWY1?=
 =?utf-8?B?dEUyU2VnMGgzaEhBVU1MTVZscGxGRTVTNkwva3p3dWt5UndaalorMUV1M1VR?=
 =?utf-8?B?UFptNllxMUNMNEFsaUpUcEVUTlNBelVCQTYxaHFld2d4MDdMQ2NQbFNlTWha?=
 =?utf-8?B?YTk3UUt6ZVpJcVg4T3BIRTVxb0RYYTU1SWZkVHFxRCsvc0lTc0JHbTgvMmRY?=
 =?utf-8?B?OXFlb2dpbG5lZ0F6YTRiSTluMklNSG5ZQTdYK3VWU1lWYmVLRlFSUWxiMGlK?=
 =?utf-8?B?R1RkaWlreEs4VzF2Uy9zc01URzNoeUVyUjQrR0RiSmVaVEFXQmQ1Rm04M29z?=
 =?utf-8?B?S2tMdDRUOFFqU1ZYQ2Y0SGpobVlEMTBXY2I5STlKMTB5TjhwSXg4bHdINUUy?=
 =?utf-8?B?ay9HQzBTOHdrZm1YOUszUW15cUYvcmt0Ly9uSnE0U0FrR2FkME4zTXRuU3Iy?=
 =?utf-8?B?ZzVNdldXbzBkMFlXelNYV1ErWm9oMStENG5nRlcwTTBFT1M2QmV0eGI4Sk96?=
 =?utf-8?B?T2dGWHZBeHRuVmRSN29WeXcvTDU5aVhRUzZVWEJtYU04QlYyZDg5YVpoL0pu?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90D8BFAE2DF1C34296A2451AD296868B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d862c9e4-84dc-4e10-de6b-08dda822c362
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 13:29:01.6453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mjl2U8knK9KDR7DzrIcZ97DryZl9agkEEWtsBsCukOmgujr7duS1X5IqdKMDajcsRQJy/ESxMvacLoXFUvqRxOBHxg9zkY7WyevdNuGrRa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7592

T24gRnJpLCAyMDI1LTA2LTA2IGF0IDE2OjE1ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IEpvbmF0aGFuLA0KPiANCj4gT24gTW9uLCBKdW4gMDIsIDIwMjUgYXQgMDI6NDg6NTJQTSArMDAw
MCwNCj4gVmljdG9yLkR1aWN1QG1pY3JvY2hpcC5jb23CoHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAy
NS0wNS0zMCBhdCAxNjo1NSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gT24gVGh1
LCBNYXkgMjksIDIwMjUgYXQgMDE6MTM6MzhQTSAtMDUwMCwgRGF2aWQgTGVjaG5lciB3cm90ZToN
Cj4gPiA+ID4gT24gNS8yOS8yNSA0OjM2IEFNLCB2aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNvbcKg
d3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogVmljdG9yIER1aWN1IDx2aWN0b3IuZHVpY3VAbWljcm9j
aGlwLmNvbT4NCj4gPiA+ID4gPiArwqAgbWljcm9jaGlwLHJlY2QxMjoNCj4gPiA+ID4gPiArwqDC
oMKgIGRlc2NyaXB0aW9uOg0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgIEVuYWJsZSByZXNpc3RhbmNl
IGVycm9yIGNvcnJlY3Rpb24gZm9yIGV4dGVybmFsDQo+ID4gPiA+ID4gY2hhbm5lbHMgMQ0KPiA+
ID4gPiA+IGFuZCAyLg0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgIE9taXQgdGhpcyB0YWcgdG8gZGlz
YWJsZSBSRUMgZm9yIGNoYW5uZWxzIDEgYW5kIDIuDQo+ID4gPiA+ID4gK8KgwqDCoCB0eXBlOiBi
b29sZWFuDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICvCoCBtaWNyb2NoaXAscmVjZDM0Og0KPiA+
ID4gPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqAgRW5hYmxl
IHJlc2lzdGFuY2UgZXJyb3IgY29ycmVjdGlvbiBmb3IgZXh0ZXJuYWwNCj4gPiA+ID4gPiBjaGFu
bmVscyAzDQo+ID4gPiA+ID4gYW5kIDQuDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqAgT21pdCB0aGlz
IHRhZyB0byBkaXNhYmxlIFJFQyBmb3IgY2hhbm5lbHMgMyBhbmQgNC4NCj4gPiA+IA0KPiA+ID4g
V2h5IGFyZSB0aGVzZSB0d28gZGV2aWNldHJlZSBwcm9wZXJ0aWVzLCByYXRoZXIgdGhhbiBydW50
aW1lDQo+ID4gPiBjb250cm9scz8NCj4gPiANCj4gPiBUaGUgcGFyYXNpdGljIHJlc2lzdGFuY2Ug
YWRkZWQgdG8gdGhlIHNlcmllcyByZXNpc3RhbmNlIGlzDQo+ID4gZGVwZW5kZW50DQo+ID4gb25s
eSBvbiB0aGUgY2lyY3VpdC7CoA0KPiA+IEl0IGlzIHBvc3NpYmxlIGZvciB0aGUgY2hpcCBhbmQg
dGhlIHRyYW5zaXN0b3IgdG8gYmUgYXQgc29tZQ0KPiA+IGRpc3RhbmNlDQo+ID4gZnJvbSBlYWNo
IG90aGVyLiBUaGUgbWFudWZhY3R1cmVyIGNhbiBhcHByb3hpbWF0ZSB0aGUgZXJyb3IgYWRkZWQN
Cj4gPiBhbmQNCj4gPiBkZWNpZGUgaWYgcmVzaXN0YW5jZSBlcnJvciBjb3JyZWN0aW9uIHNob3Vs
ZCBiZSBhcHBsaWVkLg0KPiANCj4gSSBkb24ndCB0aGluayBJIGJ1eSB0aGlzIGxpbmUgb2YgYXJn
dW1lbnQuIFRoZSBwcm9wZXJ0eSBpcyBub3QNCj4gZGVzY3JpYmluZyB0aGUgaGFyZHdhcmUsIGl0
J3MgbGl0ZXJhbGx5IGJlaW5nIHVzZWQgYXMgYSB0b2dnbGUgZm9yDQo+IHNvbWUNCj4gc29mdHdh
cmUgZmVhdHVyZS4gSXQnZCBiZSBtb3JlIGFjY2VwdGFibGUgaWYgaXQgaW5kaWNhdGVkIHRoYXQg
dGhlDQo+IGNoaXANCj4gYW5kIHRyYW5zaXN0b3Igd2VyZSBkaXN0YW50LCBsZWF2aW5nIHNvZnR3
YXJlIHRvIG1ha2UgYSBkZWNpc2lvbiBvbg0KPiB3aGF0DQo+IHRoYXQgbWVhbnQuIE9uZSB1c2Vy
IChzYXkgYnNkKSBtaWdodCB3YW50IGRlY2lkZSB0aGF0IHRoZSBkcml2ZXINCj4gc2hvdWxkDQo+
IGFsd2F5cyBlbmFibGUgaXQsIGJ1dCBhbm90aGVyIChzYXkgbGludXgpIG1pZ2h0IGV4cG9zZSBp
dCBhcyBhDQo+IGNvbnRyb2wNCj4gdG8gdXNlcnNwYWNlIGRlZmF1bHRpbmcgYmFzZWQgdGhlIGR0
IHByb3BlcnR5Lg0KPiBBZGRpdGlvbmFsbHksIHRoZSBuYW1lIG9mIHRoZSBwcm9wZXJ0eSBpcyBw
cmV0dHkgYXdmdWwsIGFuZCBkb2VzIG5vdA0KPiBldmVuIGhpbnQgYXQgd2hhdCBpdCdzIGRvaW5n
IC0gYW5kIHRoZXJlJ3Mgbm8gbWVudGlvbiBvZiB3aHkgY2hhbm5lbA0KPiAxLzINCj4gYW5kIDMv
NCBhcmUgYm91bmQgdG9nZXRoZXIuDQo+IA0KWW91IGFyZSBjb3JyZWN0IHRoYXQgdGhlIHBhcmFt
ZXRlcnMgcmVjZDEyIGFuZCByZWNkMzQgZG8gbm90IGRpcmVjdGx5DQpkZXNjcmliZSB0aGUgaGFy
ZHdhcmUsIGJ1dCB0aGV5IGNvbnRyb2wgYSBzb2Z0d2FyZSBmZWF0dXJlIG9mIHRoZSBjaGlwDQpp
dHNlbGYuIFJlc2lzdGFuY2UgZXJyb3IgY29ycmVjdGlvbiBpcyBjYXBhYmxlIG9mIGNvdW50ZXJi
YWxhbmNpbmcNCnRoZSBwYXJhc2l0aWMgcmVzaXN0YW5jZSBhZGRlZCB0byB0aGUgZXh0ZXJuYWwg
ZGlvZGVzLCB3aGljaCBjYW4gYmUNCnNpZ25pZmljYW50Lg0KDQpUaGUgbWFudWZhY3R1cmVyIGtu
b3dzIHdoZXJlIHRoZSBjaGlwIGFuZCBkaW9kZSBhcmUgYW5kIGNhbiBkZWNpZGUgaWYNCmNvcnJl
Y3Rpb24gaXMgbmVjZXNzYXJ5LiBUaGUgdXNlciBkb2VzIG5vdCBoYXZlIHRoYXQgaW5zaWdodC4N
Cg0KSSBjYW4gY2hhbmdlIHRoZSBuYW1lIG9mIHRoZSBwYXJhbWV0ZXIgdG8gc29tZXRoaW5nIGxp
a2UNCnJlc2lzdGFuY2VfZXJyX2NvcnJlY3Rpb24gYW5kIG1lbnRpb24gaW4gdGhlIGRlc2NyaXB0
aW9uIHdoaWNoIGNoYW5uZWxzDQphcmUgYWZmZWN0ZWQuDQoNCg0KPiA+IFRoZSB1c2VyIGNhbm5v
dCBpbmZsdWVuY2UgdGhlIHBhcmFzaXRpYyByZXNpc3RhbmNlIG5vciBjYWxjdWxhdGUNCj4gPiBp
dC4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhhdCdzIHN1cGVyIHJlbGV2YW50IGhlcmUsIHNpbmNl
IHRoZSBwcm9wZXJ0eSBoYXMNCj4gbm90aGluZw0KPiB0byBkbyB3aXRoIGluZmx1ZW5jaW5nIG9y
IGNhbGN1bGF0aW5nIHRoZSB2YWx1ZS4gSSBtZWFudCBkZWNpZGluZw0KPiB3aGV0aGVyDQo+IG9y
IG5vdCB0aGUgY29ycmVjdGlvbiBpcyBhcHBsaWVkLCBqdXN0IGFzIHRoZSBkdCBwcm9wZXJ0eSB5
b3UgcHJvcG9zZQ0KPiBkb2VzIG5vdy4NCj4gDQo+IENoZWVycywNCj4gQ29ub3IuDQoNCktpbmQg
UmVnYXJkcywNClZpY3RvciBEdWljdQ0K

