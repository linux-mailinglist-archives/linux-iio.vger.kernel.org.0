Return-Path: <linux-iio+bounces-27765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B40D1E35E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0136230581B6
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84882395245;
	Wed, 14 Jan 2026 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ue5CJKxT"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020129.outbound.protection.outlook.com [52.101.84.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F416389462;
	Wed, 14 Jan 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387617; cv=fail; b=tiobrNSbd5+Ip1rJg21A8ovxApPAXYvRUOBoyU2euWukHDXnBaLSCSJ/Wra8R2MZ85uzqd62Tj0nR5OTfHAtxKWYUIN9/LXU8/rCawfNf1szO2OJ2NBUtIpV+6U9gx0g2sE5g8JgKE7n827K9RmSkQ9Rz8OVMDzooJz5bvAl7NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387617; c=relaxed/simple;
	bh=wLEVmHkWeC5ztoqLHXmbhrpWAgbNBBBevtKMqQ7wiGQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Z4+G/p4kg+dFlzuC3btgHNYe7XoFLppiAPNpcmMrJHZr14HNObEn53b5SolbmkBb/rVjfwV/tQGudnLlgmQsmBWAIVDXRzoBSUa85Wz9YHDlOdCICCEFa+XPfPINc+Be1M3O7ZSeg+k/d/gagsBCw/AX2GHkf2B6IKZO0z3YNdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ue5CJKxT; arc=fail smtp.client-ip=52.101.84.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4/YbzBtkLwGJhvx2KgI/uMQOXIz7Oy18xxMO0rqNL3iBNtyKP/O04CVwckAsU7iQuF9tYaIHSjaeIDGAKEHpeDiAu51ml/P/CAKD3H3gfHIj60Pk9q6kFyp1CRXcY46w0xj/9XW06e+3NKJkRLLq06chFq5oxqfGKW18axpL+Ent0AcwvFcRsQ1ncoBK6l5tlIdL8aCx+p8b66Bslno9siexgbzYTrB0c5TtxXn+NjXj3PJr2CFMUuLQWQ81jrmemQv/WuHeG26mTaHUv9fFEtXfVm0z8vksfpFZKOQm4leP5ifT3o09DRXkK2OJxN3Pp1svoSXBtY4I1eeTc80hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCQ3Jf3okO6vAdKOZyNRI+lZfzWLl+NqGsR5lKeeWPU=;
 b=jUKtrkTWxN8VDd5Jot3n7L7aVPWvPss+89zpYaoNDDvnvQLDm/tOPmEwUPvkmvbtGCXAA/bIAm4snWrs2Y7FoWmsxPONPKOlHjB1pQX2Dk2SkqE/F3cdA+nnckMpoBgBqd3AbITKGmY+zddlCQm5+QrqmpJHovU9Jebm8jOEDzwOaiH37CIv2yQJ9LjJMoyjEAEtwQVsQvP5K4MTI9uHn+IwD2Dgfy8f5nSQXgYl38YkK8uXeUBv/uyo9oTnKnn85tpWuoRdJBQHBNFteTJ+9dOK0+Nlk8Hw8hMSfrbRd/29Q3niT3VQVvBwLB4YM52eDeBdFkretIeiJbu09jFUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCQ3Jf3okO6vAdKOZyNRI+lZfzWLl+NqGsR5lKeeWPU=;
 b=ue5CJKxTKIuE0sf+kGfahmdHamGWcQQEdM9P5SCE9RY1pI9oN7HE8z97cY+wUPvGyjNlcfhlUnfF+Jkgo31cSYUgHrBOoHCsBxXC++h4xSLKtWg22hoFqzy8N7SYOwHFlN3fZAZM2NTjzReaDj5SxP1DPDmGQRhdR5hBjfJglzHj/7bfIgCZrz9VHOY0rLuY+m4rl/VPs+gE38hbxE5/Df6arl7J0zTkihkqu0VGyGzwLKMe1F1lfIPWVEWEA20LzXxgC6IQE8KLKKaEHWaexrhbeif894K6C5EuHn+9stMvmo3QHbwx3IHwLnyZ8BtfO4+xFUjiP3/GSLpabEIM6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS5PR06MB8943.eurprd06.prod.outlook.com (2603:10a6:20b:655::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:46:11 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:46:11 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 14 Jan 2026 10:45:52 +0000
Subject: [PATCH v3 3/4] iio: adc: adi-axi-adc: define supported iio-backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-b4-ad9467-optional-backend-v3-3-d2c84979d010@vaisala.com>
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
In-Reply-To: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768387568; l=1101;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=wLEVmHkWeC5ztoqLHXmbhrpWAgbNBBBevtKMqQ7wiGQ=;
 b=ZOv+tSNNZweuW8G1ihk5+9JBimg4ZhESKscv/mP1i7pZGI1VRW36X9NA8iw2aUXchtDxEirsr
 zRut1gN9hutCQv0TsNQ1zxLNpluma6eHRK5cQodfUUFwPf0VFbj3m4t
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVZP280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::13) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS5PR06MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 777051e1-410f-4304-cc54-08de535a2198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmluTy9zdTRsRkFVS1dFa0x0WW9JSVJweFV2MkVrcitIN1FRQm41cXRBZDVm?=
 =?utf-8?B?THdqRjBWQ21lYkx1TEk5OUF3TkoxR1dWYVV0YW1zR0NXd2R1ZTVQeDFFcXNq?=
 =?utf-8?B?NFlveDVINURCeS9aNzFKWFVQeVRsUE1RbzZMMlpXNXZQakp0U3FZNXpMWFVa?=
 =?utf-8?B?YnZxbXhuenB2TVBqbDJSVzk5MVhWMWhVbjcrVHpHWkFxOW93RG9rSHprV2Fm?=
 =?utf-8?B?YjEzK0plSlhKUXN3L1R6N0FDa3Q3VkRVMHd2bzBsYXlPYXRmaGVzSFVtWGx6?=
 =?utf-8?B?OFV1T3lCekdWb05TcklKV05ITkpxUmFkYmFaY2JGaU1jZStKQ2o3TWQvUTF2?=
 =?utf-8?B?OVlaZHhPOHBHOHduMTNlMEJ6dzRPZ2NZd0F0ZENaSUJRR3BsdUZLSUhKMTZq?=
 =?utf-8?B?N09Wc0d5U3ZXY2taS0dTbjZaQnlhRks1cExGUmlNcDljRmROVjVpaFdYWE9y?=
 =?utf-8?B?RzJYd2pOYk5LMFRVVkFvSTY2S0IvQnBuNzJpWUhTWkN5eDg5aEFwUUl2VzBs?=
 =?utf-8?B?Y01iNDMzaExieUVwSVBVMVZlSGp5MWIzdEZwekZjNXlpLzQxR25taWdsTEhF?=
 =?utf-8?B?QXcrYktPTTFZdjZZUFFpR1ljSkdpWnVsRDRMbjBMMjZ3YjY3K1dPQ2pqenNa?=
 =?utf-8?B?SzgwckQ2TERUdmRPSlRIT2s2K3JFRkppRVdoT1U0K1QzaDNRaEJBak9Ed0xs?=
 =?utf-8?B?QTRNbUZYckdtSE5HanlNL1RIa09sY1pWUlZlV3F0Mi9SckVtY1NqU21SWE9l?=
 =?utf-8?B?RStSeDNxenZhVWo0UE1vSGdyMm1ORVN1aDJWZlR1TldTKzNJSVUwWDJhWW14?=
 =?utf-8?B?L2RIV3Bib1V5Mk1XYTYrZFJ0cjBvZGd6cW9SZE9wOFlHWVBEdUxiNFh2ajFs?=
 =?utf-8?B?V3ZWeXFqNngzNUtkL2FKWGpqTjZqM25FUTlabVR0RGF5QVNGRjY3b3o5bUI4?=
 =?utf-8?B?K3EzYy8vb09KYXZzcVgrNzNXVXdMczZ5RWZET2ZhYWhIcGhueWR5SElMeTZ2?=
 =?utf-8?B?T25WNEVQd2VJWUxvK1AxMXVNRC9idkg1RUJFZHFpcmdnUS9vKzdZS0Yrc1Qz?=
 =?utf-8?B?SjE5ZWNMQmhtbkNENHk5NzBGSW85TytRK1dkUXBWeHdUWHN3R2hjL3grS0F2?=
 =?utf-8?B?TjFHQmdDNzlCOWlQQ1luajJQcHc1cVZiRUtlZDNva3I1QWNMY1BEbWtURFpY?=
 =?utf-8?B?ZUZtcFhZYXdlR2RSVDZEWUd1bU1rYmJOSXVvazJDbkI3TmxaRGxLU2lzUzl3?=
 =?utf-8?B?U2J6TVFPN1JZblBLa3V1VGRRNzBQNmcyRG1NVjQ5U0NEdkpBaTZRQmc4dXlG?=
 =?utf-8?B?bFhlSDFuTUJCT2pVK2RUdnI5dW5nbHkrTHdCdmNuTWk0dHB5T1hkS3BtU0ZK?=
 =?utf-8?B?UFhld3diSjlCa083aGhDZ2lKdHhneDdqUmR1dzVGcVIyMm1RSHlVTWphS2wx?=
 =?utf-8?B?UjlicndhamsvaTVEMjhlMW5tR2ZJcjRLZ1k0aW5BYmhTS1JSRWJBRFc4MWtL?=
 =?utf-8?B?b2hEL0xhNjBCTFhrZUY4S001K0grUWNZUWdxTUNzQ0JXcHo5T0laVmQwb3Ji?=
 =?utf-8?B?RFlUV3I1cVpEalN2K0Vlb3FwenBmbC9WR3loakJ4WFl2OExDYzhUdWpJbnZT?=
 =?utf-8?B?alF2RDFJTHZnYnFzclNaZWcwWmgxS1ZxTjFzWkJubWx6TnZGd056dDZkQVFx?=
 =?utf-8?B?NW0zVWFPc2o1YjNZWWVlUFg1dVIwT3BoaUNBYjcxb2dUbHgyd2FJL2g1dEZy?=
 =?utf-8?B?bEVQWE9yQ0NBM1UxVHpsZlFMc3VrelQ1dFBCWU9EWXJJRnFoMVJ6WUp1NDZU?=
 =?utf-8?B?UXBxMmpXVEVTMlFHMWc4dzBEUE5hY0RYTkRHeUJQeDhIRytJRzA4cm9scnlx?=
 =?utf-8?B?RWhzL0JyMGs2d1RHRGFSMUUyak9SZ0R2cXhCcDlzNE5GaDU2RHBDeHNrUzRn?=
 =?utf-8?B?RXRmNlJIdkRRMUdUbTJqT2lOUHFnVHpGWjBNenU0SmNLZCtkRHNiVDMvU2Q0?=
 =?utf-8?B?cUExcG9hM1FLaGd4QktITS9lRXZDbmQ3ZUc0K2hCYnl0RUVqdEhVM05iaWFr?=
 =?utf-8?B?UlU3RWpkcU9KRG9BREFPU3RkYVJRaEwzTFFhcUpGbmlpU0NTeEJNZCtKazhw?=
 =?utf-8?B?L2kwK056c3Z4K2lmaVFlUi84THhoRUl4bUJaMTJGeWlpMmZGUzBQdHJ2WE0r?=
 =?utf-8?Q?fRK/ReK90UkjqIBluj0y/xA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3RRNjV2MzJWVXRxZGh3ODYrZHp3VHpybmNkTDVZcGxvL0o2eHFjNkszVHJY?=
 =?utf-8?B?cmRnVWNueVRmTjBsdGhpQWpVenJhZjNudHdhelVvai9wQ1UvS05XaTZYbzBx?=
 =?utf-8?B?Z3A3RGxpVG10eTlqdjVldUpFS1pRMFdaOWVNTTJzVGZrT0h0Q25oZzF0VG5h?=
 =?utf-8?B?ZDFoOXMvakpmQ0lYL1lQbGRFeHFiSWhxVW5kdVlmdjd5TWMrL2ozdXZ4NTd2?=
 =?utf-8?B?dmJRVVFDUHZhYklsaW10RU9vWmJqR3VzUHl4Zmc1VjBJelozRE4xMGRGZ0hr?=
 =?utf-8?B?SnMzMzczOHdzZnViYjBseUFHckhDUldkblNjZm45b3VNU1hDUVVUYTBTWitm?=
 =?utf-8?B?ajlVellVWUVtdzVGVVRZWktqWnBnakprZXZGU1hPcUtMeHNwMzZWdXZvS2NH?=
 =?utf-8?B?aVZTZzdrdElva3NVT1VtK2ZBK2NCQWVjeFZIOVViZGJFMVFGeHlzcC9LTWxv?=
 =?utf-8?B?c2FnMU15RkVBUFllNmY4Wk1Yb0UxK0d6UUZHSVhXRkg3THQrMUlMKyswT0Fz?=
 =?utf-8?B?dHowWXRsYkE5ZHZta3VaV0U3WGRVTkZFWUdMbzRzMVRPWFRhbmZocStZTWFM?=
 =?utf-8?B?MmxQMlZkdW5DdHBTbXM5c3lSTy90OG04VHFzU0VQeUtpTFdQRDlaOUk5Z3hL?=
 =?utf-8?B?YU1SVVM5d2JxaVNwZ3B3SG9LMm1CUERFQlpNUFQyNS9zMEFnL1lhY2s3Y2Zj?=
 =?utf-8?B?cytPVitQdDJqazNLVGFQdlExL3ZEWVp2NkdzS0JjcDdGTk1jUUlWbmxsb2hR?=
 =?utf-8?B?ZVBOdUhqVjBiLzFzaWw2aDBPZnREUngxNTBYbWI4QlhpcHpDcStBbW5TNktK?=
 =?utf-8?B?elplVDNMNDlhQndHZGxXUURtTW9HdHp3N2RaSVZPQ2xQZzJmelBjNVY2SUdp?=
 =?utf-8?B?KzNyWFJIYnJMcnUwcnRKL3RMejU3MFNLdEpDV3oxbmVFY3NhVXo3MnpMMVJ5?=
 =?utf-8?B?OTh0allXUHFtQ3QxOEo3ZWJFemkxVHdHUU5yU1h0NHhFNldnZ1RKd0Y2V0dU?=
 =?utf-8?B?UC9qUFRib3JweUtIcCs4MDhNNmJ2NVY2dkxNSmhaNW1LWUJ2UEY1WWhKN3hO?=
 =?utf-8?B?bEpnTnlQK3o4UXRXdzB5U3ZxZEVtRDlLV1llRXFHOFFUaGxBT0dRRTYwaWlO?=
 =?utf-8?B?OTY0aCszVUhsY0U2ZlEyVnYyRllmSDB6NFNocEVlV24vWm00bEVPSXlxd3Aw?=
 =?utf-8?B?VU0yS1A5bENKSzVPREtzb3pwcUJSZ29xbjlQRHhEdkwyTFNvMy9zU3Nldzhi?=
 =?utf-8?B?RnY1U0d0WEtlb3A2eUxsWEVvZStVUEwxVjJSdElBVDNmYmJjRm5ZNDkxS1lM?=
 =?utf-8?B?MlBuay9IOXdwdU5vRzdld3MyNUp2QndkZTF2dXpXdnREeThNc0pMb29WbVF1?=
 =?utf-8?B?Z3hYaWNabDBhb2U5eFgyQWFaYXFXYVJyWWh6Q0tKQmNWUVg4V0JWVHJpNkhJ?=
 =?utf-8?B?NUZ5cE5nR3JLSjcxeDlJaUZoNEhiZWZyRFptazJ5M1hvQ01FSW80bGdNenV2?=
 =?utf-8?B?cDFPem5YQndjUW1nQmQ2VW5rb3RHbEpydlNURzdFK0hTSVlDdTRoSEdLRUZ3?=
 =?utf-8?B?UStLSnh4cnpxVTVkTHV4bWhaWVlrdDYyUW4zcERHd1psUDJxOW5RT0tlVTBW?=
 =?utf-8?B?ZzlOM0FVb2NrMUdlNjh6QWEvdzlNcUVJQ1VsdGJVSm5QQUVFNXpZZ1pJYzlI?=
 =?utf-8?B?VGE1VytUc2JtditLSkg5YkhoUDBab1hZOFZjdmJFcTZramZMUGRIZFd1Q1VN?=
 =?utf-8?B?ZUxXUGtzRWZvRVdmbVMrUjJyV1lhdHg0SVIvWENCdDdzOXpUNkNNakgwK1Va?=
 =?utf-8?B?bDhaYkZ3TCsySkVEejNWeFBwOS9YNnJqbUpCZ1d2ZGY4eTRTTlExU1NTc2Nr?=
 =?utf-8?B?ZGg4a2xXdjRXVDVyWC96MDBiOWhRcDhKNXhpVzhUYW1OaDVQeTlQTEZjdzAx?=
 =?utf-8?B?OUNNUHZwUlY2dzNaOHErMnpIRmZid3dDYWoraDFNOXZMZWFoNGVYaE9UZ05i?=
 =?utf-8?B?eTg4TzJLazR4WUs4VUZ6empSRlVENC9YdmdoRWpkU1V6ais3MWdGcENUc3Y4?=
 =?utf-8?B?NjhZbzZZalFZdHgzNXpib3k5eVgvVlU4alJRMGI0dUpkbUNUMzZFRmdMYW9X?=
 =?utf-8?B?dXRxTWxNNkQwL05GVzlSVndqWTF0MjEyTXlrQzlYeXdGVDh1bkVCK0NqVlR3?=
 =?utf-8?B?WVNkRlNxR3U0T2hVbkR0WlQrUGxzQjBJN1pzang4cWd0NjNQSVdXbkNCcVlr?=
 =?utf-8?B?NEkwVkcrdVNiU3RVWmdlNEUxckZUZmx4K01rdUdiakJJd0dwYlYvS3ZOS2dY?=
 =?utf-8?B?ZWdEdXBQNXU3UFkyWUV3MXhNOVl0dkZTZW05RXgycmVlc28vQmo5M0F2Mm13?=
 =?utf-8?Q?7hui7en/7H9TmhX0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777051e1-410f-4304-cc54-08de535a2198
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:46:11.0100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU3QsXrV2RyAQQYRv9QEG5tpf8PY5pQmCIBtcuZPoaoMgX/xQ/5LjJXOHF6CB1P8NdrNcvzOkCOZCugi4eaFJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8943

axi-adc and axi-ad485x backend variants provide calibration support,
whereas the axi-ad408x does not. Set accordingly.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/adi-axi-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 14fa4238c2b96b1ac722d537bc49ed4ca8e36925..968e35b0a29e0da3b4cfb8a33944b9c23e3cdb4e 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -626,6 +626,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 static const struct iio_backend_info adi_axi_adc_generic = {
 	.name = "axi-adc",
 	.ops = &adi_axi_adc_ops,
+	.caps = IIO_BACKEND_CAP_CALIBRATION,
 };
 
 static const struct iio_backend_ops adi_ad485x_ops = {
@@ -650,6 +651,7 @@ static const struct iio_backend_ops adi_ad485x_ops = {
 static const struct iio_backend_info axi_ad485x = {
 	.name = "axi-ad485x",
 	.ops = &adi_ad485x_ops,
+	.caps = IIO_BACKEND_CAP_CALIBRATION,
 };
 
 static const struct iio_backend_ops adi_ad408x_ops = {

-- 
2.47.3


