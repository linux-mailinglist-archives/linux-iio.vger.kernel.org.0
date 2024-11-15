Return-Path: <linux-iio+bounces-12336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E3D9CFA1F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 23:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9491F281DE
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 22:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647A9191F99;
	Fri, 15 Nov 2024 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SfX6T/Ph"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF41917ED;
	Fri, 15 Nov 2024 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710267; cv=fail; b=lfhk/Zimem/tLms3ao7c4ll33jw+t/zWhL2JdKghj9nB3d8wmNHJFWtkBHuY3G/NcRuBKhhDSBPwsoXL1pc9ObrxAcNJWfIhZTt1EmGt5tM/q/2KwQpKBPMyMePEs0bWlqkvR+5OzTYbhKhYOHSW0qd1CUq3ncLWzfKgsLGTH88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710267; c=relaxed/simple;
	bh=+G0hXt0YFvegDB0CaFcMY5DS+zU+nN1NdqEDyxUcszA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PjwmErrDpAuUf4oGlb+zuBTt+7ZwSGPL9zTQcMTKUSZsQhsyb2kgzdHN13XQYwE7nZqLaif5QCur0tZPYhIzZMAxqzk9JrvrVUD64iCMhl8Xi16Bxi6b5LR2ILPaWhbgSC+CZ49ioKUMk8IThQ66CL+EssJP31F0hojyLH5gOcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SfX6T/Ph; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh/f1l0UuTEbY4zlLr5HYx35igjsluPo+le25ysbvZOybpEk7S/a4GWvV8VdSoCawmAiRu7DzjNh3x0qKAqzBTn1U6931f4z1fr8T/AAFwxmx1iVs011a/7EDhOuqQS6c0iXpdBZ6VT93PsP97Iou0W/8tyPpts85cT80PTUmj+RZOeRuSLyMlTVkD/IgdwPkWBwLSVfBLiU0e8KxE7DbRlicu08EIULvgErau6dEGZ6ZnhrIcO5mW7yymlb1YjNO0q3cmy73VA6y0zWRR+ap6o8lXk68kiOTxNlDsTeQPd1vfP2rhWTB/DU4Vtz1ZL2moaMgKuj43mG9nnC3ef5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv5w6s1W6BQZoTBRMND6vKGPojLIb3U3B9rnTM6jPp4=;
 b=Nt+YzFHS1/n6DOf8V0lwQXQivPUIV5iiPEXTCWpAfh3NeGIsHxTWeI1FBLhf0t8gurbTWkEnBH9pZmVYKfYY6y3nPz77E/sL6YXyd59IRknaMFO74WXobDYuZVTLAeO4uBDcAHR6T+VzbSW/F6uAF5ChgAIZFUZ/F/nyxYoAZNilAuQOjaELAmg2Uu4X2tqjxwNoJQG2QvxEvMDW4PI3f+crNc4djwxuQBUECUMdJGaxo7tbA4wcLsYDRX7PuyQ06HC8iPBY/YTCv56yycylandoqW7xRdVGnNWqXVSn3hrAa2BkDWxbiEunKsWRO6LhzAfJ9q3ETDdeU3OKXijmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv5w6s1W6BQZoTBRMND6vKGPojLIb3U3B9rnTM6jPp4=;
 b=SfX6T/PhJe1KoiC80wF7Oh46AGFgGH/8CJ2s+YVVM5+2kYXvcefs3d5UnGE8KmwPM+raI+pyJ0zAuvV7tM3Hpo/JvipEk4Vz1puIRLRGlejsSiENED2W6ZZG3VjB79JkDJKwcTFpOyc26K4qw9o70ErtJyAMU6rUEROrwIfSR/N8OEEMGHgAWLMo5bh2O7TukEWLYM+ehSWPXAY1QpB7zw92Mxj2T5/QjrmNIFnCRpr6cKheN/noW3Z1RTX0dNsFohn28+yG5yKk15nxeXMwUK/gMJa8wmCv6nrL2N2LEYHwvyHKtylA9qSH0MGR2FfDoxd+wULGrlfB9fot0taOBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 22:37:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 22:37:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 15 Nov 2024 17:37:22 -0500
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Add
 invensense,iam20380 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-iam20380-v2-1-d8d9dc6891f5@nxp.com>
References: <20241115-iam20380-v2-0-d8d9dc6891f5@nxp.com>
In-Reply-To: <20241115-iam20380-v2-0-d8d9dc6891f5@nxp.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Han Xu <han.xu@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731710256; l=964;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WfTu6EuiXLAJ+/aqdSvH3d/c7jGXnBfPWQvuMks4BBE=;
 b=kKD19isN6dzjVN5uTPvFXVKH7PdRjJUK2tojM9csfjGGZUqciVQ3wLRm8iLwirMy4OCC3gt06
 PimIeHpyohXAF7p0EaVOcCjLdz7++SZ6PK/ADVTa7xNJCc2Wnbi54+S
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 1621779f-fc7c-49ef-807e-08dd05c61e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vjg5N2doZ1pvRzJnTzlrWEJRQ3h4eFk5amNheVNNUTRWbHUrR004UVhtVFYw?=
 =?utf-8?B?K2R0NG0vMjI3a3FOUllxNGpkNVBKUE8zcGVUa3JyeCt3dXVQUXkrZ3lpY3li?=
 =?utf-8?B?UnJsMWRGOUgxaENJNk91Sm55NWtZNzRLNW5QajV2elJJUXduNHBMbnZ1N1Bx?=
 =?utf-8?B?RkJQQVprdVExMnBzQmpHRnBqdDZEK2dLS0VpeW1wSE1zQjBLNkJQdlZxRDZW?=
 =?utf-8?B?b1ZxV3Y3YWljUkp5TVU0TGJHSkk4d2JCMVBKWHc4VExXTjJvVjV2c010ZUs2?=
 =?utf-8?B?RmVyVXFWbXpJWVFncjVsMUtnS3NMQSs4Ny95K1FpYnJJK083MTdEdFU0RnZZ?=
 =?utf-8?B?b2g3cUtrQXZXZ01aUWJtd21tNGpnNC8zSnRhWkpaTDdvSElEMmlzbzJJL1VU?=
 =?utf-8?B?NnQ4bEkrdjRnMURrRSt5SWxVbmlpUUZ3RmdxY0FwMWJ1dDllL3hQUVdhS1lF?=
 =?utf-8?B?eG5XZ2NWc3F2c3BnRzF5Sm16dkpMd0JOS3JhalRWa0JoTU9yMi9vNGRTMHJM?=
 =?utf-8?B?YVlCRGlzckpzWlpZSHFkaGlKeHFkNGdXS2ZVSDhlVjRFaWhscnBUUGhwZzcx?=
 =?utf-8?B?aWJvR1VTQzU0Zi9tUm82ZVErZnhRbTdSb2lwVFN5dU5vdERIdy8ySHd4WXN6?=
 =?utf-8?B?WVMyOWRKOUFCRGV5aHpVTUpnYmdZM1MxMXpCMVpLeHk4NEU2WktKQUsxY29t?=
 =?utf-8?B?MUZtczJGanZwMy9lV2p1dndGQ3FibXpvTXhpVloyTlVVTTBpZFZKbjFROURx?=
 =?utf-8?B?dmp5YXdUMFF3aTg4cmgwU3A2WlhhRGpSNUdBaXVZWVBQc1VXeDI4VzV2ZzZn?=
 =?utf-8?B?eFZTZ01ib0U1R1VkQjhKMEczeVVML1FwZDFXODVVbWpyZnIvWHp0Zjgrc3lj?=
 =?utf-8?B?TUlZQkdJMlJsK09yQkhDcGlmeDhjbmxGRjM3STNlY25GOXRTTHN0ZkpZeDhx?=
 =?utf-8?B?UXJFcHFTOUZTaVEvUCtIMVlEdXpoQ0ZIZEJ1dTJDWHdVNHMvZS9IUzhVVUU0?=
 =?utf-8?B?QkVZNEo2NVZJeUQ0RkErcGdxZStWWk5sTXBERFVMYkZabzFrN1ZuUnlYUVlq?=
 =?utf-8?B?ZXhLank5VWRvUm5Dak9nR3IrVXdDQ3JOb282WWZYUU82TTVVVkVtMnFuUVFB?=
 =?utf-8?B?R0QydFpFREFMMVI5WGpCRUJLNXFaUlAzazFKWWtzS1Y5VDF5dTdjbDgvRmpO?=
 =?utf-8?B?cjlHUS9Yc0F3QVNsY1RUS2I4Ynhma2FFK3dFZ3VtTk9vd0NXU3FXajMzd1VB?=
 =?utf-8?B?RE1rMWo3cjcyZ1ZCb05GUmJDSm9Wdzl3SXA1VVQrRlB2SmgzdW9wWWFNeVFH?=
 =?utf-8?B?ekNGU01GdEJCbEJ0Wlp3bzAxeGNIUTdvTjNtdFhxNzlvN1pZcnZRLzVKbGMx?=
 =?utf-8?B?cGsva3NHRm5WNEs3eUpMaEV1bTVPbzFpSzkyelZpY2RHdVh4UE9odm1qVjUy?=
 =?utf-8?B?UW5qWWpiRWo5T0lzeE1aZTUvQzJDRDV3aVpoVFhZS1BlTXNPemZQejFMS1dz?=
 =?utf-8?B?RWhMVXRIeE5ZT0Z6WkRUSVd3RXExN0J6S3ZTVGNtUlUyMWVVckFnd21zeEFI?=
 =?utf-8?B?a21TbE1YVE5Yd3FabURRMnkzOGNCY25BbUxWajVJaGpraDFnY2NxZnZFVE1R?=
 =?utf-8?B?UUNYLzViaFMzcDFlRW8yUGRQYUFvNkNscWNkUS9zalhGeFBLZUhsNjJVclpP?=
 =?utf-8?B?WGdaeFpKM1JTaU9OUk1XT3Y1N0ZKUFBaRkFsZXB6b3FMODA3UjBxdkpsMTZQ?=
 =?utf-8?B?NVR1VnZqNFpiYVdLaG53SDFXM3JFbmE0T3BvZ1Z5RHNlT0dhUk9oeEZ5ODg5?=
 =?utf-8?Q?4XoXJzW0NrZKVp5u04Gj5QnVbER/DCvHmROSY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlNaQm53ZEU2M1NuU3RBV3VXZ0VDUzhlL1BTWi9pUUdPQ0NCcVhIcVVTdmE0?=
 =?utf-8?B?bHZrWWRIam1BU3h4WFlsV01VRTVmTDBBdi9LWUdMY0p6cHNIUG5XRlA3c3pt?=
 =?utf-8?B?Vkh3ZC9rZmlkYUlhaVg4VHJQVzZGQWhJc3RBQjIwVnlhSjdkb3FFV3VtN1E3?=
 =?utf-8?B?NGhLaVlWK1NHWXJCYUlNb0h3cnRFYUI5QTZobDdkMllRbE9NUlpYZ2hZbkln?=
 =?utf-8?B?SU5TbW1uL3Z0cVFnRkhEV0tPYWpZcEt0RGF5d0h6WFE3UnNGMDdiZW1RZkNy?=
 =?utf-8?B?UU1vTG0vc1hSVFhOY2pYSmN2RUFKRDdTdXUzbzVMM1J4RlY0NldENjQ5aTlz?=
 =?utf-8?B?Wit4M24vb0NyRXdURXFaYVkvVEJqN2l3aTl0b29NR1FoU2tqYzdIaE1oMUxm?=
 =?utf-8?B?L2hrb2pEYTRpQ1puTUFHQ09iMjFmRzdrUUtLRHBqazU4TnlDVDhWbzdidlIy?=
 =?utf-8?B?UTVtK2JrR2gwWnlVSDZEQW52blZyWndCME5NT1dUMGIrWTBoUUxEUmdKL3M4?=
 =?utf-8?B?MDc0TkgyZU05L1J0ZXh3OGlacEpEWmgyR2tVcUNvbzcwaW1yOCthQ3hDdk54?=
 =?utf-8?B?dUFINUZRM2VyQkZyYVBLRjVZcUNnYzNZTDZJMnJ2UDFCdCtFdWhCMmhvbzRQ?=
 =?utf-8?B?c0p3NW0zSXlwdXQwTWttUEF3Q05qMHNhNzQxZnM2b25Qb2x2ZlFqQ1dDQTNK?=
 =?utf-8?B?RmQwa09ad1ExUS9aT244WWhwcGwxMStpVUlYeWRXQTFxSzJqekdpVndTeXZB?=
 =?utf-8?B?UHVoSFlEV1dsSWI2aUYyVkZNcW9qTkgwUHZHdTU3eTNYdEg2b2twTUVPYW8v?=
 =?utf-8?B?T1VaazVBQzBLZTQyRHFFOXJuYkJaNlBtbm56dFRINXNKclFoTDdLRFNkdVFp?=
 =?utf-8?B?U0ZuLzlwN2xISlVkcXVTS0RQRXRHSUVHb3grZm9SK2pCRFFya1BiWHFrMThJ?=
 =?utf-8?B?OWFqL2lKKzZYOTU1bE1yMkMyRDJ3RVV1aHRGbDhYbDVFUVdFRG92OE5yNVJF?=
 =?utf-8?B?V0g1YnhxbFIvd3RVVnJQcGUxeWJseTRmSEhjVTY0VjRBUzBvWEFUYy80NHFL?=
 =?utf-8?B?cHEyMDhJdGtyTFF3Z0hJaUJ2UXBtMTBRdUJKb0ZxeTRJcHE5MGVlczg4NDFN?=
 =?utf-8?B?a3B1amRVRlhpQXd3aVphMVV2MUU2eFBEZktYdzVGdmN0RktJRGtmVTltWHdQ?=
 =?utf-8?B?ZzdsMG5oWFBJNlZDTWFWZWtOa3BKUndscnV2dlRHd3J0T2hJVUU3U1lRVjlu?=
 =?utf-8?B?b25ZaGNEMUpxOVh1V2RqQS9HN2F4Z0Z2aGJXM2FtQXo4Q2h5WlV5UDRwSnRI?=
 =?utf-8?B?Y0NUdFR0aWNxQS9WbEg0c25xditRTHN5dnZhN3lSbk9XanEwcTBHdVhCRE9p?=
 =?utf-8?B?U2IrZnUyWDJEZVdBVW1pN1ZWNFdvK0JuYWRLY0JwN0hmWjk4OC90Q256eFhF?=
 =?utf-8?B?VlRaRWlDTjhtSnJ2ZE9hTnNhWERGVlNyMGQ2b3VsYmVtNGtnOFdnOTcwbzVt?=
 =?utf-8?B?V3ZHS3BjL1VBLzNma2NXZWpiUm5VMlR1MWxqRGVVYWVRbHVXelQwZ2pPL3JU?=
 =?utf-8?B?TUQyUkdPb2cyQ3hZZDdhYVhiZU9PUzJLclc1Nm9WQVdVS2UwT1RmNVpHT2Jo?=
 =?utf-8?B?emZKZjhPVy9XRHZkazhlY053SkF4SXpDNGFCU2dUbmc0eWM1MDZxRkZ2d0cz?=
 =?utf-8?B?QmVKL2d2TWN1aTdkaXZDSXBxakN6dTJlbEliaHdsUzVnSzBoVURsTjZzZVIz?=
 =?utf-8?B?bmpQekhPMWpsTnNDR3V6cjBSL2ZNVDh4WDNKNHF1TlVYTXkwMm9WTnVxYlpk?=
 =?utf-8?B?WVU1WlMrbFl1c3QwbG9rbXorQURLcDdPMDhVTmRyL3lpRTVTaXNiakhKVE8r?=
 =?utf-8?B?cXhiRmpLSHE2cVZmeUU1bDA3WitZMGpsRjN4U2dqV1hwdXliWTFBemloSDdr?=
 =?utf-8?B?YXNzUkpTckVWREt3RXFmbHlzeUNkaHdHRWIvL0hmaUFWZzJYMFFXY0VjUHNZ?=
 =?utf-8?B?alJvOUpnQ0x3WHVmdzVaQ3lubzd0YS9UYlJjbXN6a1ltNGk4V2o0UWJxWHhM?=
 =?utf-8?B?V2g2MEtFTVZ3bXRlRVZEMDZSZTBvakk1V3pZdi8wQ0pDRlE1ZWRjWlZXUUt1?=
 =?utf-8?Q?tgPuioBUwYxaj3+bR/Xlyb9Ur?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1621779f-fc7c-49ef-807e-08dd05c61e71
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 22:37:42.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hM6/9/k40lpQecDsYv2AR3EmUG+MCuMI3kusW29MfYeJkPG0felg1GEaO2AJs5DrVu0d8IijxvVvO4TwOTVppA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

From: Han Xu <han.xu@nxp.com>

Add compatible string "invensense,iam20380" for the Invensense IAM20380
sensor. The IAM20380 is similar to the IAM20680, but only supports gyro.

Signed-off-by: Han Xu <han.xu@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index f91954870a44c..0bce71529e34c 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - invensense,iam20380
           - invensense,iam20680
           - invensense,icm20608
           - invensense,icm20609

-- 
2.34.1


