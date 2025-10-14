Return-Path: <linux-iio+bounces-25053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6836ABDAAA4
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421A23B5B67
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F0303CB0;
	Tue, 14 Oct 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VkaKAlL1"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF978303CBD;
	Tue, 14 Oct 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460038; cv=fail; b=u4izRZ8TII4ir9GyCrekkZAzm9vboV5An4SMbg/742cAqxQaHntIl7HROWA7ZPOGRzTYZm5TB4eTkizTWubsg/86AdW8xVA4bVXLi09nvMyEnaiXodgXqnFJtf8Y7gVxEXpwiW22BtBzh1i8ZmCmjCSpen4m8aTDX83hqE6MwJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460038; c=relaxed/simple;
	bh=Xmm7o6n1T4UYN4JBq9SrII82L5aWkp3/zjQPd7RnAEk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Jv+2w7A16FAExtukaj6IqKUsHAU1IxSLpkc9FYEW/7stunRN6tFcTt1z8rHO1/aTz9wEWh82AYu/nDoDHzbI6NhHukXs+stmbyCWG3tqyjNWQubT35DCCxu3b3pvcNgVYzqvlej4BTqux6X8qeFVdFQ+BzMtC9jt4AS5/d2RqGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VkaKAlL1; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6fPssRkuxTSxmAScotqghD7JaU6Rj+D94Wc2PDu3saHe0TKvVa/2HCVkDFzUp0wbFnOtryRXoPSVpMrUjLVINe5127twHV9KBnplbJ1Usm38syEC89zd8YRpk0JdWpGNGY34VOnaqUI33dJbJSCfL25Ph9RYsi3mpMS7zpsz7a1n0otGNZtItu5pBwjM+NanB/YYMZyD1vs0+VCbeWnC99pJ+GTPVxD+p4vXpLGXep2gLtiNjCTZzGxqcxIxWQ9OordTcntxeZAbPDKcRp71rgTr/MJxMiNvoPZFsBJz0rXgJNFN4KacGe1OcvFqhzjc3r1rmqiOpEou0oJUXtWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o/vNmi7dy9VX+KMp0VoNs3QKUB1EeFZg/0KH3ARhMs=;
 b=grmXjOBni4ix3i1NGORMk5ryRyCOd4UfdEkuwMZpS+ohyey4xXt9nZBsXkUJe2e3PWJ+VbFk6gRHYaHcV+NYKI3pRLZ4Hka4XgEzFdCzMHLVJHjwRoRH2IvN//PcbxLdX+NC5yAUE0nEbmhAMPX+hUJsqrKWnR50+S5TIzlH70ifpRmhwmhDOjWLXmOXLZxHVW4I1sc4Li7Ey3f47+zEOuCeDpLQ9xOO/BVKG7/YJuY/sScyPijxvzaHCW+lP4w5DqoJIqRhgrF50fHkiRuV5ULemq40hP+xYJBo4lXfHELnw1YG4IX1c3qCAoSdzJEWn9l2i4VUcDdAAcy8uHrd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o/vNmi7dy9VX+KMp0VoNs3QKUB1EeFZg/0KH3ARhMs=;
 b=VkaKAlL1sQyPAiWwNzMtVCTdtUAvwBEGWz2CihfdFyJbKWKoEvVRUlS+/e5rjIh8EL/RAvnEV+ab0nW1i81rKTi08pzuq4rPyPfPJm71xjvCd8Zf0BqLtwSx+riq7R/0pdNVPExenb674tO+XRmtmSsP6+US33pqMjSn6Eovd+kxovxQWPIBmRm0q6zJNYH3F0g7J3Xa4bxtmDGVUGoMKBhqaiM/Z/O9a44dbD6y+qpFYiPyhnTewIlI5x+UiOubjDntNyIn0vSzSvjudBSIpH3phEnwIJNazS36xjX3JkqYNRmL/hBCY1/xiL7ghQo7kgwwFE8pNSyo5K8TQu518A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10946.eurprd04.prod.outlook.com (2603:10a6:150:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 16:40:35 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:40:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 12:40:03 -0400
Subject: [PATCH v6 4/5] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-i3c_ddr-v6-4-3afe49773107@nxp.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
In-Reply-To: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760460014; l=1228;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Xmm7o6n1T4UYN4JBq9SrII82L5aWkp3/zjQPd7RnAEk=;
 b=FxwB1fUiN80iYgtbfU53tpqjrgw/RxRzoQtseZB6gsyP6F8/kxAE2fDTOW7OreO/NR4GcKEeN
 CwQC7dlRAIGADEqtxNMfQtOjaVJTGsMx/Uzogc1pnOKikplaUTVGuv8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: e74e9219-c1c8-4fa9-171d-08de0b40663d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFltcU5vb3JVRWk4QVducXhKRFdnZG8zdC9kV1JyeVFkOXl1a2I5R21uYzgz?=
 =?utf-8?B?c1ZKSFFuZVFsOUs5T0E0MGFwdTVVWUhZenVHNFpKWkVXT2xFaUxyYThoWGJB?=
 =?utf-8?B?aWlHRjZFeUFnNGhRNndaZ0x5bXFNNVVCWUlrS0xvcFROMW94MlZHN0FnamRl?=
 =?utf-8?B?WU9RREJyOWtEeVN1R0pVb1gwWWllUlhDSjRyN3lHSjVibis0VGxTWGNrcUNM?=
 =?utf-8?B?OHpuUVdlL3Blamx3MDJWT0Q5YVpyK3pLKzlHT3ZLNmhJdENMNDZYVThNZ24w?=
 =?utf-8?B?czAzS0NXVjRQK3RxN3VlQkJ5ZXRoWVhYVDFDTVo3NWdSN0NtWkx0b0ppallH?=
 =?utf-8?B?bGZaQkdVcjFTQTJhalY0OWpZcHF4NVozSVB1NlFqTjhlMXFVcXFMQ3JIRFd4?=
 =?utf-8?B?Rzh3dWs1TW4rMVp2ZXNldGE2S2xWTlpkOEh1eXBxYVJsK2ZMTis4Y0RKUTBh?=
 =?utf-8?B?UUlvOTRJb3RZZVRoYkdHajlsa1VXa3pEbWR5NFFlcHI1eUxtanA5QzR2L1Az?=
 =?utf-8?B?TzdTQm84aWZDNmNNMDNHcWxQTDJIRGl1R1pid3gvaldaNFl4ZGFWbVFVY0NU?=
 =?utf-8?B?WFlwRnJBY2RyYzE2T0hUWDRQL2gxOHZOem5hMnMxUHUxL1JqSWxqc0UySmp0?=
 =?utf-8?B?M0RxNTBzZmtIT3BGZ2xHdkNiTS9OaHRHVC9NWDhjcWdXY2lNVlhUYXVsSjc5?=
 =?utf-8?B?aTJlb3ZIc0w4a1pacEIvSmEyWk9uUFR0ZWFvcVRiejVzUHNOa080OVkxSVlo?=
 =?utf-8?B?b2NEc21URVkzWWNjNWR5T3JsbUg5SDcvZ2JqOHNpZXl0M1JJQW5JYkhrOVRB?=
 =?utf-8?B?Z1VjM29OSVZIblpIeTBBeURuTVZrRWIwbDAvMm5OTldEdUp0OTdBWkJ0aXZx?=
 =?utf-8?B?U093dHRnci9aYk05bitSN1hPRnRaYkZWOHBEdFBpc3VxNEw5OVVQK3pwTjdI?=
 =?utf-8?B?WW5sdTBQTTlhdkJlYm9zd1FtV0R6eTh1OWVHbkt3UURZbmxrSDlIN1AxWmxT?=
 =?utf-8?B?MDRuU3pCYmVMcWVzZ3FnRGNPY3FaUUJ6QktJSGsxUmhTeVRsL3MzQllaSk5m?=
 =?utf-8?B?bUlyb05IYVpwazVzQnBqY3BRdEhuTDREUmtZRHh4Rk9NSU9MYmMxWWRvS2Rp?=
 =?utf-8?B?bmFzTEpXWGs2RGpqcDJzbUU3Y2FjclkvZXNlZlZWejBIWEUvWFN0Nm82QXZU?=
 =?utf-8?B?aE9RV1Z2d25MM0FPejUweWJkZGV4K2xMMGdGeUtuZUs4MktlbTZxeFMydjgr?=
 =?utf-8?B?aEgvaTJzMmJpOHlJajFXZU5CT0VLbXBHRmNtVkZPOWViNG1BTEJNRE14MUdI?=
 =?utf-8?B?MzdQWjZyZTV2K25MOWw2SWxLQXVsUVhrVzFWWXlvZXZnTDRxRHVmOXVUb1Yv?=
 =?utf-8?B?SkU0cmFLYm96UGRnN1Y4S1U5ZlZ6NDBURTgzaUdDK0V4YkRJd2NFdzQzaUN4?=
 =?utf-8?B?bUNkZkQvNTBWRXhzQ3hLNTBmVXlLQldFSGpiTm9HNWQwQjRnTUNnZkZ2NEc5?=
 =?utf-8?B?V2x3dmdkWm4wWGtXd2YzbVptNWdBTEhKc1ZMQlBTMnF0b1M2T0NGNitPaWZO?=
 =?utf-8?B?WGVLRDBTRHpqZXFEYWlFb3RjTVRkY1FrMlZCRTFhS21acGVBdklPUnJCTXBk?=
 =?utf-8?B?dTRMeFM1d1Y2bXc5R3pLZ09ad1hKMnFpOVBxUmZOK01vMm9vdE5TS3hOWG1s?=
 =?utf-8?B?QXRyQVh5MkNjeXZ5RC9wQmU0RXZJejVoQnZzZHM5d1UvZ2pGWkpkVGo3ODdL?=
 =?utf-8?B?QjhEMVZUOVlGazBJSFVWend6SzlKaWk1cjNhN3plTnlSUW5CTEk0Mm5RZDZv?=
 =?utf-8?B?c2lJVy9pd2plNkVwMC9ITEJDbnlDN1hzTXp6a2k4NXNDNm9ac1VpTVlDMmtP?=
 =?utf-8?B?cWM5Y0YxRGovdll2MGlWL3c4WkJpMHVhcjhsM2czd2gxbUFVN1BpYVdnQVk0?=
 =?utf-8?B?MHlmWjVUZ0J5Zi92bUozUGpaYjlwTmJCNEZvZGQ0ZGNlZTB3NG5IZTNUSEto?=
 =?utf-8?B?T0FsVlhVUDRGWEtEY2ZoMXI3Nnk3YzZkQUk5WDBLbkNnTmtCeE52N2lmMUVF?=
 =?utf-8?Q?EjO90U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDhVREpPdm40NUFaQUxxclI3TDNjUm50T1dTdnRXeCtMUkhwZitOUERJT3pO?=
 =?utf-8?B?dEdOMUxqaGxtOTBMRnFNaXB0bDJFYXQ2VWxSYmpVaTJReWtlemdpTlV0RUhJ?=
 =?utf-8?B?RlUrYm0rUmhvQVNTc1hJVTgxSVhIZUNnVkNVeDBrV0QvOHRSVGNxeGtweW9j?=
 =?utf-8?B?UEtQV25CNTJXQ3FmWWFlSWduWk8xRk9vK3EzNHhWYjNRd2daTG5BVmFKd1Nw?=
 =?utf-8?B?UDNUYmFCd0FRWjgwcDFyeUtvbGJWU1BvZit5am45T2I3OEpYRW1Ga1NkSHhn?=
 =?utf-8?B?OEczUWl4eWkzblhIYTd0TE81ckNoQTUwL3RPbUlVdTJ4eDJsQkx1S0ppaU5W?=
 =?utf-8?B?dHBITFFIUnVwMEl1UXpKRTU3eC9PdW9mZldEN0FoN3lienFsc2FkVGpVRlJ6?=
 =?utf-8?B?cEplMk5NOFhTVEZnMjdSenc3ZEVBTkNVQmkrQTVzWkN2Z1JBUE9rM0hhaHBQ?=
 =?utf-8?B?WVkyUitnSmR0WkxnVXEvbHU2VFU3ZnBkSGN5djk1MkhQNm5TWXdPMHhJekVF?=
 =?utf-8?B?V1h6MEwzV2dVOXpZc2g2eW9LMldJVVlCT2tOdEY4VlllL29idU1RYVNJWGRx?=
 =?utf-8?B?ME1MQzlxKzZ1TFdvd0RwRXdUWlN1QVhGOHdzSmVuUWlTSXFyckJTTDFxMnJ1?=
 =?utf-8?B?bWVVbnNGZ3JJcXI0VTVuZnFOL2FvbU04Y3dSVnA4bFJDYlc2WU82K1VPSjJO?=
 =?utf-8?B?UEIxbHNLTVpwbUN0R0d4bFVNMkdjbklONndNVFRGVGo5Y1lpcW5vMVZFMkVy?=
 =?utf-8?B?NDhiWjRxa1NFQVYvaU9DV1h3OVphenpweVo1NmVVd05nNmZLd1dFNjNXaDFY?=
 =?utf-8?B?cTJLU2pubWNQVHJTZ2VjUllOaTJOaW93U2lsWWU5aDVXaURRK1l6bDJRN1VL?=
 =?utf-8?B?U1VObEU0c1RsMlhxUXk5M3JIb2ZzclhGdjY1b3FzZGdNMHl0QnlQaDdSNHJn?=
 =?utf-8?B?cW9kNFVYWjJkV2RIOWhUSGtYeWlvZk1uOFZmMTBTTTQ2SHZNdnF3UmNjTWMv?=
 =?utf-8?B?QnY0UzdxeFdCWjRhQ2VPdGErNlh2MWVLbWZHaU1KM3FGdTI3WWNwNEc0OGJj?=
 =?utf-8?B?NFhFaFdnZFNzY0pjV1hYaU9aWUNnV2E0SHNCM3hQbGdzTGY1ZFFVaWdyRDVS?=
 =?utf-8?B?WUhQUTZIMm83VU5OUDV6VUNSY0ROWlpESlFxZ1J2ZVMwM2NXek9tbHBVT0cv?=
 =?utf-8?B?S2IyQTlMVGZkbFgvSElPMktON2FsSnJiOFNydTc2dm5teUxTYkJndmhJeHF3?=
 =?utf-8?B?czY3YkJndVVXbHRmRk95ZlZLZ1VDT0hxZEF1RmdzMENBRnRRcTdmNTJtem0v?=
 =?utf-8?B?aGJGN0t5dldlNGk2elN4bDNuRUc3N01FTW5lQkdGRS9JSnNLM0ZJY3hhNjZT?=
 =?utf-8?B?KzJ0T2JvWWhsTXdQSDhEZHpiQjg4YjdLbHVaTVVMakk2QTVRcGlaaW9CK1dM?=
 =?utf-8?B?cmNvcXJuTXo2bWtvNkNkdEFLKzFlZFVPV2xLZWZhTm1lZUQwclhmM2RKU3dL?=
 =?utf-8?B?bnI0Ulc4SngzRlJqbDJLNzBZaHRYNHNjb0NvVjFwWkN4Tlc0cGlHQ1A5NHB3?=
 =?utf-8?B?YWVKM2lpbjQ1dUVYd3YxWlM1VmhydnZ1OHNFK0tZbmUrUy9rbWltTzRPUHJ3?=
 =?utf-8?B?Q2N3amprdFF3cFh1QStxYnpzQ3lsdDRwZmpuUmVQK1dtcnpsYk1TblFJRUEw?=
 =?utf-8?B?bDBOYzlEdEJZb0xmbGloWnFSeC9tNTZQblJ0Rkl5dnZhQTgvaTNtaUZXSnls?=
 =?utf-8?B?VG9vcm44VUp3ZVI1TytaejJ2dmZtdys4Qk5FUXdUMVRQVWl6NDZpS1RxREgx?=
 =?utf-8?B?RklrbGJPQU1RTmlSR2VKajFKSy92aFlaOGMxUTBDdmJhVUsyWG9xVHN4ZXND?=
 =?utf-8?B?Z2lub0NRKzVLV3NNOGlmZWRtRFIzWnUxVTR1bWg5MGtvak5DdG1jRnluNUVh?=
 =?utf-8?B?K0ZJWmtQK3JWWlFocU9LbjFzMEJvempLeWRpczZNYyt4Y3hGQVFaRTFFaWdV?=
 =?utf-8?B?NlUrdXd1ZzlFWll0dTJBNW9KTUFYUEJQelFFUjRYMDJzSTk1djlCSTI4RlNT?=
 =?utf-8?B?S3pUTHp2ZTB6YWRwc3FOSjg2bm9iUy9BMjRVd1lOMEVQZHkvMW5vRFlaQWFp?=
 =?utf-8?Q?ngdQ5OkHmeG6D/t/EqC0xw5o/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74e9219-c1c8-4fa9-171d-08de0b40663d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:40:35.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2dHM06CKIAF1x1zF9cqg3KhV7g5nLYaC8s/u09eiIVkrk3AOOIftc9VtONEevcXYgsxvGb5odWezMhiEnenHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10946

Add compatible string 'memsic,mmc5603' and 'memsic,mmc5633' for
MEMSIC 3-axis magnetometer.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
- add Conor Dooley ack tag.

Changes in v5
- none

Changes in v4
- add memsic,mmc5603

Changes from v1 .. v3
- None
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7609acaa752d5c1c89a26bb007fa38357dee1a28..72786eebfbd63beffd2a09fc20c7aedbe9e96a8e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -225,6 +225,10 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
+            # MEMSIC 3-axis magnetometer
+          - memsic,mmc5603
+            # MEMSIC 3-axis magnetometer (Support I3C HDR)
+          - memsic,mmc5633
             # MEMSIC 3-axis accelerometer
           - memsic,mxc4005
             # MEMSIC 2-axis 8-bit digital accelerometer

-- 
2.34.1


