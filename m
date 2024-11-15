Return-Path: <linux-iio+bounces-12335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F7A9CFAEF
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2024 00:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D105AB27B80
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 22:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B431917EB;
	Fri, 15 Nov 2024 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mc/5LrvS"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792F18BBB0;
	Fri, 15 Nov 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710265; cv=fail; b=p+fS3Z3WJvmAvxBNW6DykCEtrOTB7cMraH5fLHuHeq1CVnNMwzqncyk6dgMKdtO6JF/BQvJ06bdde78rsCFIw7FAvzZAoNLZcwZKosybt9yrZaC7oBYE8GdbOeL02fG5U8Avt4Zo8SxHoEh/tXCNU4kG7O9OBUAzhvEXwAYBT0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710265; c=relaxed/simple;
	bh=kjMCDYqZ8Q0GKM+6wh4PKvoyFeb6qTn8RV62c3ajxqk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=amhaz74iPdRmxz1ymiT8kJcYyYRQH5+reeNxYf5XrTnZk6u2kH9ekRNtJ7Tms/OwAMCvyd08r3/RvcoCWeOMNaviAENKN0xmiQm0p8NGN81TPrNRfMhQGLpaI9M09qmnGed0sWVYncXhLp62qMt1/9uof+OjrEZr3GapRQ0l7GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mc/5LrvS; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V14cvxb1RIknOXGj7d5YOCerPYTLfL0irfetNS2tnWLXNKfwoRLXID43PNCFoPk5pXBgKStdaYFjcuPo8U7tgxYr8arWKOAT6hHQmgFiiAYHy/K5gGgSm7rRySPuQ98DGzhJjrDNPFbJ6JQPjybyGYKhvBihCChTF87b/ltaOPhg/HcTx522SCZf3Ij/BBMAuy1pvws5EQsh54YbZhEptpXpR1LmFEQLvex2fZlu3unXTgkbcJmgZ5StQgt9hwdmziMqrM+qAPHEiFiref2FrA5+p/JKzjFaQeY7tFyZ4Mw3+Z1hQ+rGS410vOisjLrJPRy6c0hyXSHGYTaIXUun4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbFh9Rvq3cjKOYLuJ6VMD22mWj7frmXHQlqgQep/QlA=;
 b=ov6DNViKhjZXrnKJSRoDfGlxHNFuLwAwmDbQ83v7OdEqJT8w7Rn3xJl4Om/1XP3bf9F3IGho1/Zoxl+5Jq0nSIZ1y6PDJfPc+24g3a1yOxN9HdjcrPbdt4galnx0xTGw8hwRRnIeTTltfRfo3BDCYcpuHzTNCAX/vMkRntHoVMS8tlaTXeXHkOsYRc/x/oFxyoL+ic8I1l9uZCOy5fa1mPBfWb7j/ElCt08XYiqTbonpluWtodkJO4lYDiEnIR/dwHdHM6EBOwA5+nA6kCmjqBRy4nIb1h5fHMkiluuD2Cfa7jswWM6hb0oNKNzmt5kDxx0AcdXmqHijzwCmlEu/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbFh9Rvq3cjKOYLuJ6VMD22mWj7frmXHQlqgQep/QlA=;
 b=Mc/5LrvSGtg9ZbrLiDtTqicA0/jkjiVaI9t5Q11dWQKwJHjJfsI79h7CnPYOytscbvcTEAngWnLzGZ+4XLWmL9XhnYcAmnq/ojnMniBhZ8qjM/So8TkCjxAq9QalirdICuZMSEiKOQ7IjH98EFpDxgPZ7LLJ1me2umaS4TcpX3Y81FzUSIM5/xnp9e4ab58DZCi9j6mtz1jFsc04p4U7TzgS2K81zPneB2BYGUEI+m2ethaGNymWRgrYxFPyBSvLl+hZ7jGXPMZ5HJVAW9UEBJl4L7Fd8l+mUVJsQPWhYMUp55RIofoSM1p6Eh/bXn129l/Hicll1RubOIh3RRYDOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 22:37:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 22:37:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/2] iio: gyro: Add support for iam20380 sensor
Date: Fri, 15 Nov 2024 17:37:21 -0500
Message-Id: <20241115-iam20380-v2-0-d8d9dc6891f5@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACHNN2cC/0XMQQ7CIBCF4as0sxYzUIKtK+9hukCY2lmUNmBIT
 cPdxSbG5f/y8u2QKDIluDY7RMqceAk11KkBN9nwJMG+NihUWkqpBNtZYduh8LZH9B2ax6ih3td
 II28HdR9qT5xeS3wfcpbf9Ye0fyRLgcJZMj06bS7a38K2nt0yw1BK+QDf0POOngAAAA==
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Han Xu <han.xu@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731710256; l=1139;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kjMCDYqZ8Q0GKM+6wh4PKvoyFeb6qTn8RV62c3ajxqk=;
 b=QPvgQiNuNuNnWknHqB07zUFogtiqJnmswYIZAmgWnA2XuPlVolA9ZA6vrfD5lSmYKPHnBd2g5
 Fk/bJaWRJUZCeCjmoQs6scRxQpIY2JocSJxNNMQNCoDN8xJMEnVnaKY
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
X-MS-Office365-Filtering-Correlation-Id: b0496884-c07f-4803-a5ea-08dd05c61c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXhVWEVQdzVXRnh2R2hXdFptQTk0ZHVqN2RiR04xSDFqdE9hSjY2em1YWFZM?=
 =?utf-8?B?SEJkejJDWm4wRGNHNVJtTllOM2RVWVB5RHFZUXNpSnlpUnhWZW1IMnJ0UVZY?=
 =?utf-8?B?Nm1JMHhoK3IxTk5DMWlnc3JqUEtxSEZPNmJXS0NCZ1FiUkxlcGhSVUdtOXRy?=
 =?utf-8?B?dzN5VlFMR0tEQlhlUnhVZU96TzhTTkw2NEI2b0V4VXVUZm8vUFJOU3huRFhp?=
 =?utf-8?B?czlKOWp3cmhXMFExMTlEbTdNNUtKWHVSeGNXVkgyNlFNL1NwOCtaUHJ4L3Nj?=
 =?utf-8?B?ZHV5ek9ieWdCdU9ucnZwVUNyanZBYStqK0hNYVVVdVA0OUhUWFNFQzYxQ28y?=
 =?utf-8?B?MUliNFRBaVRMTmYxbzVUdFNyTjdUM05sckJJQjB5N3hySWVneSt1YWwwU1Q2?=
 =?utf-8?B?TFNIaWltN3E0bDdpVGt0bS9Wd2lRY3NPYmR5MHJsdWQwaEsvTy8zTEEyRHRF?=
 =?utf-8?B?TTRaSlJTZUI4N3ArS1R2dnJROVUxMHNpczc3N2RHZ0pnbE91L3lrVEJFT3lF?=
 =?utf-8?B?aTFiaUdCMWZOc3J4YzJmRmJ4OUxyL2FPVVU2RDBGemYvdUcvSUNyOTJUQ0Qz?=
 =?utf-8?B?NEc1NW1mU3BPaVlkOHdWTUpaejFUZ0t3L0hnSStWekhwMUYxRnE5RHBuVDJZ?=
 =?utf-8?B?V2RuWXlkSkVldzJ0bEVTY3J3T3V3VnRsUWpVci9meSs4UllzVEN1bGx0RElQ?=
 =?utf-8?B?TjFGYzZRd1hXK1NaYVc3dU9FUGdIemJKSXZtVFJZclZJVU9TaVRkL3ZLZFFL?=
 =?utf-8?B?aFFvcEl1UUxqZStEZ0hoMy9PNGtPcElOTkwwendubHFoL0JSMkVUWWR6OHl6?=
 =?utf-8?B?eWwraEJOYTUrQ2ZVdzdsVnppZTZJbHFmYnE0cTdrUjNabW40MFIrQ2ZXbXJq?=
 =?utf-8?B?WkwzVEwwMEUzbkhmWXo0clVSM2lza3pnQVhFN0dGM3lmbEtLbVZTa1FpbFd5?=
 =?utf-8?B?SFJTQ1h5QldnMzMrR2ZTRnRPSERIVzkrRWhCaWdrTUJiUDRTaytjNkptbmZy?=
 =?utf-8?B?dDVPM0xobDAzeWNwRzJVRTRqaVJPcm1URmx1VjhqdFJuTDFjTzVmVzc0aDVP?=
 =?utf-8?B?akt4ekxHdEozNGl1UEdEVHNKRTJjYVJnY21ObVdXWlpaVThJNEVNbUw0RnYw?=
 =?utf-8?B?eHh2UEFBY3Z5RFV2VkgzOUJaZDRsS2h6WFFMSWxMaGd0ZHp3K0cvL09WbW02?=
 =?utf-8?B?VW05U24wME1mR2daZUlJWFlhbTRsdGNmS0wvaXZPUkVZSWV5b1QxUjdVcVVw?=
 =?utf-8?B?akhtSlZaSWU2YmlQT0xVNlNvS1dNYk1KbjU3OXZOYU9MbG1jZlBOalNCRG5p?=
 =?utf-8?B?QlNwUGpMODlHVlJOK3hKcnFxeEQvK2NMNGkydWhVYmwrK0VZaFlVYURmU1R0?=
 =?utf-8?B?aTJndnRUM3RYRDZ1aDVrNVpEZHhva1hBQndYd3RqVEd0eEdleWs5cGV4dWRW?=
 =?utf-8?B?cmY2dG5ldnozMzV0c1g1bVE4OFJYSk1CVERMSUFJRzg0ZWVzZ3Y1UHQ3WEhI?=
 =?utf-8?B?U1ZBNmhBd0ZTTXBjdlJ4TERBWXJzVTZBTjNpdldDbU5aUkxhK2xQdHFMdzk4?=
 =?utf-8?B?ZzdMUlduR2l2cHZHU3owSVhZTStrMGNzZXR2dGF5VW14UlpTa0pSZFRJWVBL?=
 =?utf-8?B?S3Z4bTQxWXFwT1JTams4L0lMYWxPZFczYUpwMVp4OXg4MmJxT1pqSU52cTBN?=
 =?utf-8?B?MVBSV2I1QzBBdmN5VDM0ZHJjS292eTBIWFRkeUNRR1VVNjFVeG1NYzlxVlRT?=
 =?utf-8?B?VGUxQlBLZ1dHOUk1d3JOU3pMaXlYRy8xd25md2IvcXdWWWNnM25UM25YdGsx?=
 =?utf-8?B?YzlCT2Y0TkZjTm9vb3dZMVZQekMranFncGFZTnIrWUFCMlRGMUQvZ2FpNTZh?=
 =?utf-8?Q?qBl7q8e2Z7MGd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTRVVTUyVTVzdW5RMGlkczh6MDRJVW1iSUxMWUZXUnBGZnkrWEx2a3ltZ05P?=
 =?utf-8?B?MTdUbXg1YjIydFYzMHdFT1kxWGt5QWtDT1F3b25XUGpJeGxsK3YyOThQUGFU?=
 =?utf-8?B?T055dE9tRkpNVkJjWk52YnN5cGVLbnk2UE1uSGJzeDhvRzJQb2d1S201MitL?=
 =?utf-8?B?a0tpYWpjMDZuSHRtQUpndzkxVVByQnloNSs0eVlYRENZTmM2NU5jTWJqb0Q5?=
 =?utf-8?B?TXhic2x2VkFnNTB3MSs2U3NOUFMxQ2Q3clBoWjcvYW81SURuZTRHSDlBWDZ5?=
 =?utf-8?B?TTNZZFpiMXJJOUJlRTJ0N0N0NVhqakhiRXpHZ0RUTy9QRmYyQWVPalBCaHBv?=
 =?utf-8?B?V2U3WUs3RnlwbUFoSXF0aHdDZTY3N1VKUnQ0ZWo4V0x3TmNVTTFIK3kxeVJ3?=
 =?utf-8?B?K3RtZjEybWs2Q2NidFNHOUQ5WS9laU1BbzZTdlpGQnV3L0NQSUFFNlhQaG1p?=
 =?utf-8?B?cWtBaEVSNDB0N3NNMVkyL3k2MUR3dG14VWVEYXJST1BiSlpXL0t2YXFDYysy?=
 =?utf-8?B?TzFlbDBmYXgvYjM1L09hVHdrajFNKzY5UzBNTHJnUlRLeUI5VVFiRStKMXFv?=
 =?utf-8?B?ZlBNZzh6SDhnUExtR2hRdkJhcS9mQTFsblJ6Rk1nR0h3UzJKOGtWK3Y5bXMx?=
 =?utf-8?B?NjIzOG54WXRXMDBxVFh1YzFHN0pZS1F0amFWTnQrdEJiRzNRMS9MRGZtVEJT?=
 =?utf-8?B?SVc0b3JBYklJS0tOVGxEMnN1U213YzVyVk1TVm9oMjVOU21YWEtVOXNHcU40?=
 =?utf-8?B?cVpoeWdkU2s3elFTV1ptZDJVRGRYTDRaZm1zOEJ1K1g5b3FuY0ZtK2FvTmw3?=
 =?utf-8?B?ZVJobkZrV2Y2amorSXcybVRVemlrV0dPTjVtcStFSEljZFcvaEgvSHlzZUti?=
 =?utf-8?B?NGRmMjBqc29xOEFqVUU0NnZMaHZYWnVLdExnSS9IN0dUZ21OanBxRms4NVMv?=
 =?utf-8?B?NTMvbW16ZTY3MXNCdmVnQXA4VGM5elR0Y2plZ3pNREQ1S2R2RkRySHN1aGJi?=
 =?utf-8?B?dUVuQU9keVFJOXhuQmk5c3plN2VQeGdpK1hFRCtxWndqckRwQTZ2Ty9yRXhh?=
 =?utf-8?B?d3pCRW1aUlhac3JoaW4rUyt0VnN0STJJRDM2ZXBuVnc1WWpsZDBMY3NYelRS?=
 =?utf-8?B?cFMrb1lJSlRhZmlkbU1LcERBajdDcUtsWjd3OExLdk05djdoSmNranBkdlFM?=
 =?utf-8?B?MGxSWTEvZ0VBcHcxbG9qcnNKRXZXL2UxTFFsZ0N6cGxkVG11VGxVVng0MW1I?=
 =?utf-8?B?MXJsWXAxUzIvUDBNY1MxS0cyMUEwelhsVDFkbTFqb1p4c0RoMmo3ZGtIempI?=
 =?utf-8?B?dkVHZGs4QURTUk9WaDQyZ3hvVEFIakM1UzJVRTZJcWJ0NVAwaUlncUdxYVgy?=
 =?utf-8?B?QkthZnRGcXZlYXY2dDdjUEZkSTFRbkVYQUtlWlBDQzFSdlBsWWJNZXhZaXYv?=
 =?utf-8?B?YUcza05aUDExRjZhaFF4WmJEZEdIWDh0bGVHTUs5Z2prTm9XNW40UytkMEVU?=
 =?utf-8?B?TjdsblBabk9vMUxWaDExWkxvTkR3aVRjM0xES3dGZFB3NkxQYnFBV2oxNEIz?=
 =?utf-8?B?Z1gyU3NYcmZoSjE5WU1iZUFjZDZ1aVFMOUt0WGh2cFRIVlcwUUMwQXJyZW4x?=
 =?utf-8?B?bXF2TWZnSzFKK2NldjU5d3JLYkFNRkRmTDZnR0xGRjNxaCt2SEo2M2NQZ2xw?=
 =?utf-8?B?c0lNMW8wU25qU0RDckdKQ2FnN3B3bHZaeFdMdzlWV3RmVUt0eVJtV1BaTkVZ?=
 =?utf-8?B?MmlHeFB4NzJVQnNnVGtMY3BmMHEyaG52SHJEdW1seTZuQnZNRG5wemNJQzF3?=
 =?utf-8?B?OHVsOWx4UmdJYWJibU8zZGNBTFFjcEVnN3dETkQxdzArSWZveG0xOWIzK0dI?=
 =?utf-8?B?S25KcDM1WDlCQ3E3TXRLSTNDSkFITmhqNDFnNC94b1ZFYlRZMmhTeS9WNEhs?=
 =?utf-8?B?SS93cHZMNzZsYWNuVFVaUTZlTkRWbjJhWVFMcFlteEwyQ1NMM3E3L0pvNVhn?=
 =?utf-8?B?Y29iNENJUlgweFM2YUNMY0o5a0d3eHNTWVgvcHVJc1hTbE5LOTkwOHBJZGNj?=
 =?utf-8?B?QTl0TFgrTm5HTVp2VDV2Q25XZDFjSGtOU1JqRm56bEpEeFJld1U4TEUrdlNl?=
 =?utf-8?Q?AB3LcL883ttdApsd03dLPHgQl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0496884-c07f-4803-a5ea-08dd05c61c91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 22:37:39.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ419vmhK2l76ZPq6aXmzwjB6ygPdC3n9S7bJy+3FQ+45ma8omej7FSF2elQhA78/Or03FCQEePGBSxabCcLeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

Add iam20380 sensor support.
- add binding doc
- Add support for the Invensense IAM20380 sensor to the MPU6050 driver. It is
  similar to the IAM20680. But IAM20380 only supports gyro and WHOAMI
  register data is difference

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- Add Conor Dooley's ack tag for binding doc
- use iio_chan_spec
- Add spi part
- Link to v1: https://lore.kernel.org/r/20241113-iam20380-v1-0-cae690c4674d@nxp.com

---
Han Xu (2):
      dt-bindings: iio: imu: mpu6050: Add invensense,iam20380 compatible string
      iio: gyro: Add support for iam20380 sensor

 .../bindings/iio/imu/invensense,mpu6050.yaml       |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 25 ++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |  5 +++++
 5 files changed, 39 insertions(+)
---
base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc
change-id: 20241112-iam20380-da900d806bf4

Best regards,
---
Frank Li <Frank.Li@nxp.com>


