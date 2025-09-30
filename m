Return-Path: <linux-iio+bounces-24605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA710BAE755
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 21:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E079E1701A4
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED1428C2D2;
	Tue, 30 Sep 2025 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hRzunAMA"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE83289E30;
	Tue, 30 Sep 2025 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260899; cv=fail; b=AS7cTycezux/kuEXDq8EvZ415exG8v+QkAehNARwT1ejZsOqd3P0kRZO5v95J+BqNvootAJ8VP0Mx5B2LESf2xuJ9UrOkz9qtgxT3kk0me8az0+1SN5jdzyW3g8LYrBg9fitmRVolBCsGFSZzltx+fO0UBK0DwfmIorKU52bnAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260899; c=relaxed/simple;
	bh=+KieDoGVhFMQe2UVBzVs/QjVHStddjOF5ES4/KCCTBQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=q+PSCB1727/hkQpE/8Mq7AhBdCos67iv+AfXP+Z7oygqOAjr84Pgd5PV3bjM5DS73eJHUi0vWgsawjeg7Iva5F4dch5LznhqycnnmGpr/qvxe2UJfdw260Hf362l7C+PX1IPcQpth6JnyIS/0Y8pb3QL4xLT4rSzZzO4Lyl3iOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hRzunAMA; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0+qiaQOJi2uEBAJ2j81DyKl+tJiWA8cb8F9ZDBw7M/iIEmixSAUVkcA0E3AWZ7w6LYKoMCGpxM8Yt+hUfbe5k5MFebO6wdREhPzzvjBBCFt0PpIPc10gh2vgLS0mYG+/q2l03papbRQB0RMN7q57fVjQYK+lTRjRXbf1k0MQ7EsSKraAGilVYOg3MwuwQvgzxIgNywWEFSz6g+sYWVuH/7fTIeJod2jB2C2TOrR5FsqQaLTV0siIfJBH/RMGFkBj1mpGlIUQFxLRlSlTQXmANIhgGtMGVSdWsrJ8vyQTQArXf1BcyuEeDuRb0OjRIVbBVudTTCH7xBGiF+aAW3F6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fWrv8+05yNL99Ux8eKMQ+li4bFPvvQ64I6q4XHUp2o=;
 b=BmwKHPmUtN1FUQJglKYp7/Sv/w3sMuu7Qrtwzh9gyM81XBvyeLpj0va5e8kvcjj0u6A/DupMx/NxLlFbobftKiTIp/AJIV1v7clzlbrhNCrFZDtFocH+RYUNdjJC0WXqhdNmxykdK2K8XS2mMjgUXGP46lMbvjAsgokJjQZDe3DMqN66F3Cc7cX6ZjLcRwugbcwtFcgMPwpMt8uT1K1V8ojYgqr/X/GDSHvHZKTo6MsRQk9ISdQW0s6m7m8jNh5jdQhJZM1/Sn00W66HGnJrLhZEZynBkxa0rrSbGXu39HMiEnAkgWrjZ2UVUFuWcS9JzTRMdGddSQ6oyBA9EHvXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fWrv8+05yNL99Ux8eKMQ+li4bFPvvQ64I6q4XHUp2o=;
 b=hRzunAMAJ4LoFOVYbFdOk7AbY1aabUUnBninRAKiNMXweb8A5ejJgpkQNe/jlX4TC+IpiAKxINfiS6q1goG3x+3uAreOEHe8z/vOtBlrBRXV+PxyeerLLzU7jjEWiHsLKixT4DXyFnDkUfLDpLxnoDS4KUKZebkS1LGruIkJqi158pAzIKtYTUg2uatL7sm39ya3RY8zCOaw5guusJ1MxlvaQ9UPW+qV83r+DLu5HZmAobxbwdJvLwLnHAJpsDK7WnW8/DTUJrJuZY/QM6geXFMVl0ZPZ9R0vDBXrZhVI/Tfvyl1QBQc12rzspilEaor/xhDDs+6oDV2tVIxBLzoZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10926.eurprd04.prod.outlook.com (2603:10a6:800:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 19:34:55 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 19:34:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Sep 2025 15:34:22 -0400
Subject: [PATCH v3 3/5] i3c: master: svc: Add basic HDR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-i3c_ddr-v3-3-b627dc2ef172@nxp.com>
References: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
In-Reply-To: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759260882; l=7652;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+KieDoGVhFMQe2UVBzVs/QjVHStddjOF5ES4/KCCTBQ=;
 b=KkTxRzawtPxF2caoLjE8Qu5+yKXf3R3g9PwHjApQO6qVBUNhHFpIwdN6QYf/N3T2dNZi9x6NS
 Jftu6ClGIJDAUqFl9qJWS0DQ8ROsoAwZipK9Dg+3ucWRtrNoNAW7VrU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10926:EE_
X-MS-Office365-Filtering-Correlation-Id: aacf7112-488e-4a0e-8b0e-08de00586f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STBjbVJ2SXNUTTZwS3MwOXlCSjBtOTJDVlpLeWVmVlQ5NzZ0RkVJQ3h3dGJl?=
 =?utf-8?B?UkwzYTZIbHNmUWx5NWpaMnF6WlV3bFRzOFpYaE1jS2JyTGRPNDZVQldnQkVN?=
 =?utf-8?B?NXhacHJQVDNIc0pia2JtanRoSStqNm83WnliOE5lN2p5bVVCdWV2MTZlQUtw?=
 =?utf-8?B?VTJrZWZlY0Z4dEppcWphWWtWaENmMGtOaUhoSFpHeHloeG1VR2FHbVJ0WmJk?=
 =?utf-8?B?ZklvYW1LUzNNUElkRmVlcXB0NjBTZktCY1kzUkt6cndvRnBCSGdCa2pQV0tK?=
 =?utf-8?B?V0E5RkhqcmdKUGZlc09PYzFNNnExVkZDaE4rWlRTN1VudThJNlFDUjJiRlMy?=
 =?utf-8?B?T2pwOEN3VFpGUGkrMG5ZVm1zRHFCTFJhQ0lDeHpTRS8va2FabmJXNEFza25k?=
 =?utf-8?B?dDNUM3dWWklmYWlNcHZZOG1IeWNSb3pPV3k3SnF3emtBTTNPbHNTUnVGVytM?=
 =?utf-8?B?K3hCbG5LS044TkRNSnJuT3AzMXUzaHptMVJaWHlDVnVLVWFkcFNnZVFyVWFu?=
 =?utf-8?B?OGV3c2V4ZWE2ZlhVNjJVcUdJOFdMaWZHWldVbjZ0YUlVc0h2MGoyV3ZQcjBH?=
 =?utf-8?B?Z1hPOUR6V3BJMkFwenVjWFc4NWxKOTVBYjIwMVg5clVVWTRNREpXRXo1QXJa?=
 =?utf-8?B?UWNKZ1AzTVRMbkNmQzRsbzgvZEprTmp3aWpzOENwMWZaQWc3L0FCV05Fckdk?=
 =?utf-8?B?Yk9HdXVxaWI5clVEWXBqSEFsWGtVSFJiK3FKd0tTVEd5MjNtMGRWTjJqYXAv?=
 =?utf-8?B?MXJHc3c4OTFZeW12VDFHeklaMElndE40WE1jakMwMGVXZ3FvM3RaMzdiR0E4?=
 =?utf-8?B?d3NWQkNXaGdpNG1xWHIydXhGcm9EU0dwaGpjVGVMRERPWkJ2MVpuNGEzTzI0?=
 =?utf-8?B?NmVwNVVPdkRiVnpmdldTOFo4cG9tQW4vb1h3WVl3ZXZDSzZGNlFoeGkwK3B0?=
 =?utf-8?B?NXcwTTQ1eFFmMUZ6SVhaVG9qRUV3ZzNvcnprc2RxWEZTd1QyV0phU3F3VUVK?=
 =?utf-8?B?VkhyaHdTcDFwUmFzK1lCSUhLQWExNWZ4L1Zpd2t3WnZ2blhkMWFRNlR3ZkVj?=
 =?utf-8?B?d2d5Q0s0WGhpMU1ia0xteW1xRlRGYUNMclZCVEc0RXdOVldNV21UOEJSejY3?=
 =?utf-8?B?YlN0QTJVeG5XeFlrZ2ZjdFQ3WEtrUFJ5RGViNjFOU3pOVlJnbytlRHdkY1RF?=
 =?utf-8?B?aE1tNXRDdnN3QUprelFVZnNIS3ZCSFc0dThZSCtVN21vVEovSXIrUWZYRDFr?=
 =?utf-8?B?TkVKS3JhK2pvMXhOay8xZUFhM0t1VHpDVFpTdWluUmNDcFg0dVdGdlVYQnlP?=
 =?utf-8?B?MlYwSlJsVFhmbXJMa3dVaUpFM3V2emc2bXJubVhPbVQwcWdJVDJXNGF2VmxL?=
 =?utf-8?B?ZUFURXlOT1NqZkI0OGMvMFlWbkdURDlQSlk0Y2lScko5SWJ6NkQ5cFV4b1VM?=
 =?utf-8?B?cXNEN2xMNHYzUTBDSkxLbEthUlc2dDZBOXBiVHBnUEFwbXpQeEo5VDJVOGdx?=
 =?utf-8?B?c2d1NUxjYlBKY1p3WlJIYXhZSUJ5LzBVYUZlZ0FCYURnU0QwdTY2TzFOdFJB?=
 =?utf-8?B?UDhuQmRUUzV5eUhZbWpWVk5IR0tmWHN5R3p5K2QzQi96VkIzSEdLN0xxK2t6?=
 =?utf-8?B?ajBIWjBhTENmTmpXZk5UVGdQUVJJZ29tc2VraTloZHJzTlRpQ2tZL0pSZjVL?=
 =?utf-8?B?Umh5ODZ2a0JSeFNNbko5dGxNdEhsdHlsVktXeFZralRWOWc3VEJwcHdpM1Vn?=
 =?utf-8?B?WXZzYmxFYVJhZk1kcktUQTdBNjI0dlZlT1BraVo3eVlpRlowS25LS01yVUdF?=
 =?utf-8?B?dWJUNUtFTDl0ajJSd2tTOE5XUkJRaU5sdmExaEV5Z203bXBxYWUwZ0l6UlJx?=
 =?utf-8?B?emQ2QnM3ejJEL2hkMlZTS0NIZ21sbVBFYmdXTlVHbU41VnJ3Tzc1RENidG9s?=
 =?utf-8?B?MC9pWHFzbi80eHdmSmt4Q21FL1hmNmwvU24vQysyYzB3VHBDbWZOUStBT21K?=
 =?utf-8?B?a21oZE5SeG12SEs3cFpSelYrUks5c1lXOGlPR1Q0Qjc0ckFCcDRGRlZIMFFv?=
 =?utf-8?Q?28ORN3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cytObXBEMGNLVWVnNDFkZ3NYSUNmaVh2OWNlbitLVFRuUXRxSjhya2FwQXA1?=
 =?utf-8?B?bUFBdG9pV1d4aXdXbmlQTjE2MTBNZXBZRWVoMmIzQVhGTUtjcCtsWmxodzcr?=
 =?utf-8?B?cjRLR3V3TzJacGlBSzlWdURLUUVjeWZxNWRmejBBc29Bcy81emwzYWJ4MXpM?=
 =?utf-8?B?NHFiWDk4ZTFKelQ0SUNneUVWOUlZY3VHN3NLbzBTdGZyRXVoLzNpaWY5b05X?=
 =?utf-8?B?b1c0bDlPZ2hiTUlFaUI4ZHlGd1k1d1RvWDNVSDVLOEt3Y09KYXhZUTR4WmRa?=
 =?utf-8?B?dnBlQjU3ZnN2NS82V2lEYTNKTmIxZHZrSHF5VnFJeWcyYVhOSjR5VUMrdndG?=
 =?utf-8?B?OUJlamx1SWV0S1B1V296SVp2aXZFQitqVXZOLzF5QWVYYXF0amZyTTdIck1o?=
 =?utf-8?B?VmVDTFJ4d05ZOGpueWcrUjhFVWFVSDRXV2tRNVJCYUdrNnh3RE53Q2hJekoz?=
 =?utf-8?B?NTE5aU5tOEFiYmt0QzYxT0F0WE1Yblp3cE85U3VTQ2lZdTFGTFRISjRKTjVC?=
 =?utf-8?B?QkxJY0YxN3NoZ0M5b2hKNW9UbDdLemMzc0FFdWdqSVZSemxLT1FxVEt4Y1NL?=
 =?utf-8?B?VEJRbXdvRWY3SDlpQTJNSVZSaEt1NnhVWVVnTWtLNFVUUEdlQ3lRWW56SzRF?=
 =?utf-8?B?djFPZklQSDRiSFVyc2FjZVJjMDVGSTFkdlNUeTR2UDcwKzB0eFk4eDZ1elVI?=
 =?utf-8?B?TVZkVEhySGRvL1dVWVZZL2Z2cktQeE1mRDRqS0ZiUUhvakExUURJd0hRZmp2?=
 =?utf-8?B?am8xK2hlc1JuZExKblJ5bUZPS05wRk9BSGxxREg2Qi85L09HYXRPL0wrSHFw?=
 =?utf-8?B?MmgyT0hpVXpIS1pSM3RwQUszanYzcWZvUmJJL3N6NGlPKzI2OENwM2ltS1BC?=
 =?utf-8?B?dWNTbFA5dU4zc2JZeWpFZ3QrQXRSTnZVemFiVmxVLzZidXlrc2tDTnVkRHpY?=
 =?utf-8?B?bys1ZldKN1crbkV1ckNPR0dmS2hLVDRLNnIvNkFlWldCVnlDby83dFhoM0JK?=
 =?utf-8?B?RkJYOXV4UG5kaFRSZ0hycTNId3lMbmF2TUhFK1dqZHkwelNGb3JoN1hLUlUy?=
 =?utf-8?B?dzBweXZjUnFOZm01R0VZYmR4azVuUFhGYkhKa0V2aC8raityUGtKNzNCVXFw?=
 =?utf-8?B?QkQ5RVozYkp6RkEyVHhFam5pVFpielh5Y0dON3poc09XMjhwVzZSajJodDNs?=
 =?utf-8?B?U1NFb2Q0QWxWUHc1ZURDVGVUQ2tidmNxYUZKNzVWSGpwM2dxejdNamx4dnRI?=
 =?utf-8?B?aFREOUMrbmdXWVBWOUJlbHdEaEM3UytJOUQrU2NTdUtwb2pNUlBQT240T3dm?=
 =?utf-8?B?anRWdk9ldFZ1Nk0zeHd6WTBLdTFUZUI3UGdxSFBHeElPNmltcFJnNGpwQytK?=
 =?utf-8?B?SFRua0RISGF2WUthUTF0VURkTkFPZ0dUT1d5NzF0R1pxampJMDhWZm5jVHE3?=
 =?utf-8?B?ei94V2pUblN4VWloK2l3SlFMK2xKZTVtTHg0ODEyM1VXWGFwT0thdHhwVUt5?=
 =?utf-8?B?dldkUmFyU0l5OHNUNVR2ckRUZ2g5NFpuMFJYckc2d09tQ0xVS0JvUEhVNTlH?=
 =?utf-8?B?NFpWV3FacFdYczdRRnBoRGliSGdPbHBncDVOZVNCRHBnUWtTRW02SmhhRTlw?=
 =?utf-8?B?UGhGN29BMktmZi9yS3Y4MFhMVXR3aFNydllZNzVzMVpBdkYvNU1oWHhid2lW?=
 =?utf-8?B?Wm1FZ1hrQnlRQ2o4MXVveHhJbWptNG1qNDFMbEZiOVF3RFlQNGdOTjRhSWxF?=
 =?utf-8?B?ZmVxcWhaK3dlTHR6VmVQZnVUNHBralZULzlSK2E5V3N4SXhNNktpb0FvWkV5?=
 =?utf-8?B?OGNZeFp3ZVFuZWZBNFJVNkRnNkF0bVh3bXRQSWVFV0hYV3MwUURRMm9yN1FX?=
 =?utf-8?B?Mm1MaEEzdU9GMnFhbHhUL29ZWGkxRDJUSFhpWU03NlR5WktxaFc3QW05ODdR?=
 =?utf-8?B?eEVma0MxeXFPM2lFcms3dEhROWFLUGNlaVNEQ1g4bEFsdW15TTZINkNnZXY0?=
 =?utf-8?B?TXJVVDFyYjVzTU0xbVZGaGVnYkN5OU5XYi83NHp5eERLZ1NzNk9wUWVuMlQ2?=
 =?utf-8?B?MEQzeVRIWkVOTjhENFhVemxCOE56c0FZOUR4ZmtsUEdUQUNwQUJRckE2WUJ1?=
 =?utf-8?Q?z1GE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacf7112-488e-4a0e-8b0e-08de00586f17
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 19:34:55.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBMI28fCfCJZcPhdzHed7a97RjoCrrcSP9p0ZaoloKLgDPEzLv2EfVU+myNOTYek4YCo7i8v0h+ylbGACfSREg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10926

Add basic HDR mode support for the svs I3C master driver.

Only support for private transfers and does not support sending CCC
commands in HDR mode.

Key differences:
- HDR uses commands (0x00-0x7F for write, 0x80-0xFF for read) to
distinguish transfer direction.
- HDR read/write commands must be written to FIFO before issuing the I3C
address command. The hardware automatically sends the standard CCC command
to enter HDR mode.
- HDR exit pattern must be sent instead of send a stop after transfer
completion.
- Read/write data size must be an even number.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- rename to svc_cmd_is_read()
- rename to i3c_mode_to_svc_type()
- use local varible bool rnw to reduce change

change in v2
- support HDR DDR write
- rdterm unit is byte, not words (RM is wrong).
---
 drivers/i3c/master/svc-i3c-master.c | 77 +++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 956172dc9d5f1f54d76b4c2917f2d9cf3bd21a85..2cb886cdd259665e6c11b1c19a72d0b6391e03e3 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -40,11 +40,13 @@
 #define   SVC_I3C_MCTRL_REQUEST_NONE 0
 #define   SVC_I3C_MCTRL_REQUEST_START_ADDR 1
 #define   SVC_I3C_MCTRL_REQUEST_STOP 2
+#define   SVC_I3C_MCTRL_REQUEST_FORCE_EXIT 6
 #define   SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK 3
 #define   SVC_I3C_MCTRL_REQUEST_PROC_DAA 4
 #define   SVC_I3C_MCTRL_REQUEST_AUTO_IBI 7
 #define   SVC_I3C_MCTRL_TYPE_I3C 0
 #define   SVC_I3C_MCTRL_TYPE_I2C BIT(4)
+#define   SVC_I3C_MCTRL_TYPE_DDR BIT(5)
 #define   SVC_I3C_MCTRL_IBIRESP_AUTO 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITH_BYTE BIT(7)
@@ -95,6 +97,7 @@
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
 #define   SVC_I3C_MERRWARN_NACK BIT(2)
+#define   SVC_I3C_MERRWARN_CRC	BIT(10)
 #define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
@@ -389,7 +392,17 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 
 static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
 {
-	return rnw_cmd;
+	return (type == SVC_I3C_MCTRL_TYPE_DDR) ? !!(rnw_cmd & 0x80) : rnw_cmd;
+}
+
+static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
+{
+	u32 reg = 0;
+
+	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
+	readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
+			   SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
+	udelay(1);
 }
 
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
@@ -1293,6 +1306,16 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
+		/* DDR command need prefill into FIFO */
+		writel(rnw_cmd, master->regs + SVC_I3C_MWDATAB);
+		if (!rnw) {
+			/* write data also need prefill into FIFO */
+			ret = svc_i3c_master_write(master, out, xfer_len);
+		if (ret)
+			goto emit_stop;
+		}
+	}
 
 	while (retry--) {
 		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
@@ -1386,7 +1409,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
-	else
+	else if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
 		ret = svc_i3c_master_write(master, out, xfer_len);
 	if (ret < 0)
 		goto emit_stop;
@@ -1399,10 +1422,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (ret)
 		goto emit_stop;
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR &&
+	    (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_CRC)) {
+		ret = -ENXIO;
+		goto emit_stop;
+	}
+
 	writel(SVC_I3C_MINT_COMPLETE, master->regs + SVC_I3C_MSTATUS);
 
 	if (!continued) {
-		svc_i3c_master_emit_stop(master);
+		if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+			svc_i3c_master_emit_stop(master);
+		else
+			svc_i3c_master_emit_force_exit(master);
 
 		/* Wait idle if stop is sent. */
 		readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1412,7 +1444,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	return 0;
 
 emit_stop:
-	svc_i3c_master_emit_stop(master);
+	if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+		svc_i3c_master_emit_stop(master);
+	else
+		svc_i3c_master_emit_force_exit(master);
+
 	svc_i3c_master_clear_merrwarn(master);
 	svc_i3c_master_flush_fifo(master);
 
@@ -1459,6 +1495,11 @@ static void svc_i3c_master_dequeue_xfer(struct svc_i3c_master *master,
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 }
 
+static int i3c_mode_to_svc_type(enum i3c_hdr_mode mode)
+{
+	return (mode == I3C_SDR) ? SVC_I3C_MCTRL_TYPE_I3C : SVC_I3C_MCTRL_TYPE_DDR;
+}
+
 static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 {
 	struct svc_i3c_xfer *xfer = master->xferqueue.cur;
@@ -1648,9 +1689,8 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				     struct i3c_priv_xfer *xfers,
-				     int nxfers)
+static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
+				    int nxfers, enum i3c_hdr_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -1658,19 +1698,32 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	struct svc_i3c_xfer *xfer;
 	int ret, i;
 
+	if (mode != I3C_SDR) {
+		/*
+		 * Only support data size less than FIFO SIZE when using DDR
+		 * mode. First entry is cmd in FIFO, so actual available FIFO
+		 * for data is SVC_I3C_FIFO_SIZE - 2 since DDR only supports
+		 * even length.
+		 */
+		for (i = 0; i < nxfers; i++)
+			if (xfers[i].len > SVC_I3C_FIFO_SIZE - 2)
+				return -EINVAL;
+	}
+
 	xfer = svc_i3c_master_alloc_xfer(master, nxfers);
 	if (!xfer)
 		return -ENOMEM;
 
-	xfer->type = SVC_I3C_MCTRL_TYPE_I3C;
+	xfer->type = i3c_mode_to_svc_type(mode);
 
 	for (i = 0; i < nxfers; i++) {
+		u32 rnw_cmd = (mode == I3C_SDR) ? xfers[i].rnw : xfers[i].cmd;
+		bool rnw = svc_cmd_is_read(rnw_cmd, xfer->type);
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
-		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = rnw;
+		cmd->rnw_cmd = rnw_cmd;
 		cmd->in = rnw ? xfers[i].data.in : NULL;
 		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
@@ -1869,7 +1922,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.do_daa = svc_i3c_master_do_daa,
 	.supports_ccc_cmd = svc_i3c_master_supports_ccc_cmd,
 	.send_ccc_cmd = svc_i3c_master_send_ccc_cmd,
-	.priv_xfers = svc_i3c_master_priv_xfers,
+	.i3c_xfers = svc_i3c_master_i3c_xfers,
 	.i2c_xfers = svc_i3c_master_i2c_xfers,
 	.request_ibi = svc_i3c_master_request_ibi,
 	.free_ibi = svc_i3c_master_free_ibi,
@@ -1958,6 +2011,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 
 	svc_i3c_master_reset(master);
 
+	master->base.mode_mask = BIT(I3C_SDR) | BIT(I3C_HDR_DDR);
+
 	/* Register the master */
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &svc_i3c_master_ops, false);

-- 
2.34.1


