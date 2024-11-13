Return-Path: <linux-iio+bounces-12209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F214D9C79BE
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FA7B367A3
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 16:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA1158DC0;
	Wed, 13 Nov 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T+hWbFU9"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3E171C9;
	Wed, 13 Nov 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513972; cv=fail; b=Y7Z+Y1KBZx1LH7BSovN10jwwcT7YVGoYdMzRVV87DXpGiA4vip2/iGg09d30l4tw2SmooTFWuaM9X7SurRdZQOHuiuQrvLHWnx4BpmYovGOr9loQdHuMfzZmY/H1qP7u/01IIgjn9t4DS+71lzpDFVcqvM71ZCfM0B3GKYCS/+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513972; c=relaxed/simple;
	bh=YQPnuYx3IDPGZlMhdF0DBMwff62Dnc/Agw6PDGroOxs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=rNmJkSkW1PXuvRvj8Psw1R0bnHkwz4By9NapSW+GDf7pxbIXk6QMEI4iQGZzGZLKELKTwadkPIxyZSD02eZy/l3nErrjZmn0AUBDNjrlJ2enWBBhlodzGIAbDkLr1rgaUJtMa9hF3rMV6+T5gcRG+tZCs6VPLA3JmUbcJqkTF1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T+hWbFU9; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6jLC2ISr7h5ZD5YRu1RnAOaV1iREXDcPAQ22I0Oa08pPPG/BQ3bTLoX2MJVf/vLX/SW5NS3WDO/w3xuWMgT/axVos6fsreaR23ZpD5u/ATFUqphhbLdmrS6GciWiBzv72cFt2BSch7oV6KP11f8XuxwKwDgYD7uB+LBs4QGHKf+2zumGQ/cmDrD3KNiDSdAcRfKpLjN6KKqsvOZfyxha+fniUjlYK6pzMTN7e8T+xxoIG2hDKo5yTxlKcg8sWc5sHBSIHfdObDOE8ABfWubljjdIc9KQPALs5gkxdtqp/1mBlS+TPLz/R+BvExFEdjjs8jDyj+4NZkkkpPERiWW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV/hHJYlMujOKABbXxFarkpoE+pc86cxXhs8ad/8bUU=;
 b=wLdodfya2QThGAfOhrbvo4zPXe6fDc3MArjJvm8B1gIPzwHGffnw7o5vxchroD9MNHs1ib0Cb70NpdzC/WIp0u9lRttw0LubsrLABsOPyPyEyZW0e/cweiQGVnCJTAhoJcM1/b3D2zgSWY4MGOFy39tnaLvlY5CejMS1FraAtHWtodu3tPeQUwoYF0RzRC/CiPGerYXNuBkfnqiLXFWT4cbftgCyMEZfC2vvMCXblLc2ixeQEgcQGqJUViHxp/kwpBJ3C28dGh++Obd+7zGpgxU6/OzbrRMjA1vqQe9ic0EIJAYKFg0HU2s6WvEFhMju4JxHKWPpmwdGfIvzHrQRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV/hHJYlMujOKABbXxFarkpoE+pc86cxXhs8ad/8bUU=;
 b=T+hWbFU9foVjzjUE/VfpVpJvPpCRH5MEEIyCzn8bJHpSYkekdZZ7lI/MQ5D/H9mdqxYSfXfjFP48PmDI4WCqNQFWuVo5yAdbhlmKpuB2OCCtgnLk6+Gbz5YfIN59KNPDBSg9b8VkbJYJXFPXF3SW9dx0GlGyhjLBfX5FjZtcW4PQzC17hkVwTlvM4pYdvaECocg88eDon54Athn00lRRJ4gEqGUn69SuL/LOJ6Qq1G1fQsDrvKeVK7JbslZuQ3S40C6M/XDD2/5T5QCsPVU/anchz6BGGfxGZ84RYDPEhvegwHT9NJwIqvm48cY3+O8hwR6D3Whl/N5rPWmWNJN9cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBAPR04MB7400.eurprd04.prod.outlook.com (2603:10a6:10:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 16:06:07 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 16:06:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] iio: gyro: Add support for iam20380 sensor
Date: Wed, 13 Nov 2024 11:05:55 -0500
Message-Id: <20241113-iam20380-v1-0-cae690c4674d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGPONGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0Mj3czEXCMDYwsD3ZRESwODFAsDs6Q0EyWg8oKi1LTMCrBR0bG1tQC
 OyHlIWgAAAA==
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731513964; l=884;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YQPnuYx3IDPGZlMhdF0DBMwff62Dnc/Agw6PDGroOxs=;
 b=1BtF4VZpmBLvx+N7LWTCQhrY69blY8e1/vRUHSffO0LOdMHLv4Hw1CwJpgU+RCdV1l0VfZsHi
 PpHSrbqecDBB5TfaHxHPY/ndzrt7jUSbihcbGYJvB4tWAD+qire6NSZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBAPR04MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: 5615fc09-0e8c-469a-c4ce-08dd03fd1527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZCtCY1RJUkh1S21XRHRUMjZkZzAyU200RnpCRUVxYzI1VnUwRzlJWUtjanpB?=
 =?utf-8?B?MC9VYTZONmZMRFBRWm9hMXlmU25sYlpjeXArZzdza2xZUXpkamZzSmN0WWdi?=
 =?utf-8?B?Ymtvc3JXaXdTTFMvbE0xWEZmbXRvblhlSlByRDE4aGNBeG14dWk4Q042Mm5H?=
 =?utf-8?B?emdoQjI0VjU4SGVHRWxIVTV0U0FaK003anZMRE5DMkFYK0V4S2w4MkN0OGpo?=
 =?utf-8?B?Q3RuTmhwZWhqYnR0Q0hOWjF4SjZleFZoMkw1bitFOTFabVNLbldRNmIzZHVk?=
 =?utf-8?B?K1dYemxtalYvVUhyK3BVZUxhR2RXUU0rMEZwZm5kc3F1MjhvVXE4cmtQcnll?=
 =?utf-8?B?dWlTa0ozTFhpSFZuVm1QUmNCcWRoeDZ4bjdXeUlOVnpyN0xaYjh3cTdmQThC?=
 =?utf-8?B?VEs3UExjLzBmSHRzUW5Sc3dBWGZJYXgyYTl3aFE1OUlqTHZCMEM2TllEWmhQ?=
 =?utf-8?B?MHB4ekc5Q0NkTGtDeGNPSkJEUzJjWDBPdmFnekxtTzh2UERqRHVqUjdFcDRO?=
 =?utf-8?B?ckVSbU9xUnpZL1B0TndhaGFIYThuNXAzNXp6Z2E5aFdqTjB4ZTRXRWFoMlFL?=
 =?utf-8?B?L2I4OTNGbkNEQ1VVKzJBcVNXMFExVURmS2F1NlRoRE0vUHdRWXplTW9WOXh6?=
 =?utf-8?B?dW1tQ0hJQVhZOE02ekx5ZDBacXB2emJzMW9PMzM4aG4rTWlncnB5dlpUZUFh?=
 =?utf-8?B?dDdnVmtaeHFqUkJsSEI5UkhMWFU2L3owTkJ3YmdsQlpxL0JkdjZuTWhZcDVD?=
 =?utf-8?B?K2l0Ti91WnpNSWtlSEIvZWdJSldzeVp4RmkyUXQwaFJlTlBSSHpJUjQxZEhp?=
 =?utf-8?B?V3ljQzJtM1hrN1hLWVByRmFYWUdZdG1QWTRreUtUMmVrRGhhVDZ1cHBIaFh4?=
 =?utf-8?B?UDRxQnZMQytTNGFyeHFjZGlWd2MrakpJNWQ0S1JmNm5tbHJzR2NLMHJLVi90?=
 =?utf-8?B?eml6UFEyNFZXcjBUUXpSWlNReTM4ejNDZXhoL0VSZ1I0WExoNFNmUkV0L1Zl?=
 =?utf-8?B?eG9NQ0lJN0NxWjhHMm9MbHNERkRXd1lNU1cwd1lNWmJRTHhLM3hqM2hFTVVy?=
 =?utf-8?B?K2k1OEc0NndlVEhkVlVGT1RVb1VML25XQmdaQkU0dklPVEJEa1hkNjV3YWZ1?=
 =?utf-8?B?SkZLQXpZcFgvRGM0Y09oMHhIellzd25tWHpFd3k3RHg4TnhuR1Z1aVB5NW04?=
 =?utf-8?B?UU9SL1RuSS9zT2JJVk9yNW8yanNkYnhXZFZCM0RRd0Nlc1JST3NmVDhnYTZO?=
 =?utf-8?B?Q0pNL2ZVdngzalFtalY5RzJBTzZscjBvN0dBYlB2WUFDSWJZazVlbExuOTF1?=
 =?utf-8?B?VVluQ0k1U3ljL01rTmlSTTBLdXc0dlBrb0tBQzJDNStiQ1UySDRsaTUzNThk?=
 =?utf-8?B?WHk0UXRHSVk1Q2dEYTM1OTQ4UHVhb3dUNHE2Z3NJcndCd2tDVVZpc1A5aVds?=
 =?utf-8?B?bE9JdTVOZUZ0M3pYdllxVlRNRnluUW9iTDZCMTFqOWZDRG1RSm9wRmR1bk1P?=
 =?utf-8?B?MWNNai94YThnOWlsajRsRGVWU0RUc2pBZWJnR3ZxaVB6eVQzZ3B4cWFiaXRn?=
 =?utf-8?B?ejdtZi9rMVJ6eEwxOGpDb01ZbEpwajdIQm5JNGpBWW8wOHBuS3lnYkovVVUw?=
 =?utf-8?B?SWNvaks5d2dmU0dCTU9VSUFicTFXM0ZrV3dlT1dQcFArdUovUzAzLzFMbTRh?=
 =?utf-8?B?SUtvSDBnaVoybk5CcytqR2oxWGFEbDBDVksycS9DNnAveSthOGk5VmpvSVFq?=
 =?utf-8?B?ZVA0azVSdzJVQ2UxeFUxdzVUemRGOGxMdXNJMW5PbUcxSWFrVG52aDIzcGxx?=
 =?utf-8?Q?x1RkeG8A9Fxt4/Dn3SzhL7Vnmh1eis8Ahh4zk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXd1M1ptWDBxVUF4VkE4bStwRjNLSWFIMmpJenQ2NWJXTUtTM1p4T0dTTm1v?=
 =?utf-8?B?VnphMGZ0ZEdJbmdVbHQ1VHJkLzFGcUp0bm1tdXVXOTRXWmNpWmNndE9weGNQ?=
 =?utf-8?B?bHhsSElkK2h6ZnVHMllGREh3RzlHaXhNRHJvSUdVblVwa1Q3NGFURytnb25B?=
 =?utf-8?B?aitneXhhY0VLd0p1UERZei9lLzJWRUt6KzdSY1gzV1dBNktaSkJERHJIQUNK?=
 =?utf-8?B?dStNV2Y3eDhnQ3I0MXRIaEpPK0s5Ung4cDBIVGRjY0dYWGlnWUNoQkFETS9O?=
 =?utf-8?B?N1M4L3FsWEZ2clAwZ2Q5UUlzZUc3UTVIOHZ0THpMYjZ5Mjc4eERlQjhMdU4y?=
 =?utf-8?B?UkhrbVYzbFVvdUx5T01yeWZIazVoSDZNUDRqUkRrRzRWdGNrVEc1OVlEZVFL?=
 =?utf-8?B?SWFUYklVakgxRkN4dko4VERMV21wbXFhVjFITTQva1lrcmlxZ2lZbWlDVFBL?=
 =?utf-8?B?ZlorSndzYzI3ZVd3eHF1RWROMElQR3FTY0lyT01XOUlHbTNYbXN2S2FMOFlG?=
 =?utf-8?B?dVpBd3BsTGJJVDVPUUNkMU1OUmcyQVhWbUwrRHAvcVlpVnc3eHhZV1h0eFZt?=
 =?utf-8?B?NDBOMHVYYkZGUHhpK1BEUnlnZmdQek1tQmQ3Sk8vVmxDUHR5cVRweDU1cXo3?=
 =?utf-8?B?K05INENuVzhZS2tOMHdtMHU5WDdzRyt3WkQzN2tZcWRKMTVVRmlaa1B5cXFx?=
 =?utf-8?B?UFhwSFFuazhLYzN3UUVXTVlEdkx1Y1UxZU0zTllaMTFiU2JNb3pOWW1PU3ZM?=
 =?utf-8?B?TkxEYlZYUEtiMnJXeGhIVGthaHRWMzc4U25uMHk2MExoK1lLYklKWUU4U3p5?=
 =?utf-8?B?Wmt6S21TdXZFMms3RDVtMEpvME9ka25IazJwemx4dWE4NDltU2crMlh4SkdL?=
 =?utf-8?B?UmxxYjNIcXkrcmtJQzV5WitxN3NMaHNJRW9zL3RXdGZySnB0dnMvYWdad1I5?=
 =?utf-8?B?WXAxZVBmdFMyYlk2YVIzTTJHN2dROENRR1NxN2RQUUlPbW5nMGJaZzBUWm5x?=
 =?utf-8?B?OG44cjZQQTdtKzN3VXgvNzZrQkZaTnZsZ0FzcFJQOVU0aHZHcDVHOVhMdWNs?=
 =?utf-8?B?T2R5dDlBclN4eEk4ZUVYTHFxc3ZRSm9YMTR2bGorSWEzOFNmK09jZnhBeUM2?=
 =?utf-8?B?UnBoL0ZFOGFWWWZzSFg3WTZGY09LdmloY1dMMlg5YU84TFJKbHU5cExVTjVi?=
 =?utf-8?B?c3V4emJzZ0FkeWJSdXdxcXpzTEtDeWFKTldmb05wYThjVzFsREVvZk5iVXBi?=
 =?utf-8?B?anJpOGh6Z013cDBzQmlON2wxT3pNczhFY0J5eWpVTmlOdkM0aWZWSG45MGN5?=
 =?utf-8?B?Q3BQbmhGd1pyOURFc2tUOUxiZll1TWorMlpBWDF1eVBHY3hVazV1clFncUp6?=
 =?utf-8?B?TkU5S2t0djFKTmJFcnlmdTdJRjRhc3ZqQ0pPS3VsdC9SZ3QrdUw4bHR2YldN?=
 =?utf-8?B?UXNPTW5iOTRhNlhNTmRJWTB3bHltS3B5SURBQ296WXkwRVN5aW9ZWUUyeFM1?=
 =?utf-8?B?RVQ0ckJSdXZGQXJsa2dOVXVPbnVYTG1qS3RPTVhKR0hQRXA4YjVEa3gwb0NP?=
 =?utf-8?B?aWsrK1EyM0RHbk5SVVVzeW9odWxOWUF4dXNvMnJoQUkzbmx3Yjk5Wi9Qa2tH?=
 =?utf-8?B?azZjTEd4U0h3aGEyN2RFdkp0U0J0VU1Pd1A3dXdFMEI1cHMweDFtZHpOcGpy?=
 =?utf-8?B?YjFySEw2V3VQMGVsM2U1bDNJeCs4M2t6dXFFemJZRnVyWU9YelY3M3J3N0lq?=
 =?utf-8?B?aFoxUXljSzdJWit0ZTlieXRlOTdRSVdTaUVhQ2I3TDVqYTZQS1krb3dHYkZT?=
 =?utf-8?B?c3hjYUVTeFhwY2wrMzNSNTkvNFY0ZG1xK08xTDNTaTJCZ3ZZVUJETDlkNHJH?=
 =?utf-8?B?Mi9oUjEwZlhERllwenlQVVNXRHFDeVJlcitYczBJTkV5Nk83d21RR3Rmck5D?=
 =?utf-8?B?c3FXRVEvWjFKSFZjWDZpeVVHRTg5USttSGFBUjJTaXdZT1BlSkIrN3RieEVP?=
 =?utf-8?B?NmZ0a25yTUZTMHkxU3VhT3N6T1NWMjAvdmNmMHRVRnI4N2xuQ3YyOStHY3d0?=
 =?utf-8?B?VnpNOTJxMGpETXVNSTFOYmRPOG1NZFJaME04bm1FWXdLWW9mZSswY2wwdk9M?=
 =?utf-8?Q?Tri97xgLNbvxrB96D0fwj67yN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5615fc09-0e8c-469a-c4ce-08dd03fd1527
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 16:06:07.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cC4Fkh6UtuXDiYkzyS1SDTo+RYbDIuxVx4B6WLBaOWi5W6WPluC84O11bhrFnRfTqGFwp4jdkx9MaV0Pvg4B5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7400

Add iam20380 sensor support.
- add binding doc
- Add support for the Invensense IAM20380 sensor to the MPU6050 driver. It is
  similar to the IAM20680. But IAM20380 only supports gyro and WHOAMI
  register data is difference

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Han Xu (2):
      dt-bindings: iio: imu: mpu6050: Add invensense,iam20380 compatible string
      iio: gyro: Add support for iam20380 sensor

 .../bindings/iio/imu/invensense,mpu6050.yaml       |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 25 ++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  2 ++
 4 files changed, 34 insertions(+)
---
base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc
change-id: 20241112-iam20380-da900d806bf4

Best regards,
---
Frank Li <Frank.Li@nxp.com>


