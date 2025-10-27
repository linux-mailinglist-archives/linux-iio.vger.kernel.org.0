Return-Path: <linux-iio+bounces-25538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659CC1153A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 21:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E58146448D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 20:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19332E7631;
	Mon, 27 Oct 2025 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g255Wozy"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D82DC331;
	Mon, 27 Oct 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595734; cv=fail; b=GluuV8T4dEoF2xgrBFCuv/PIs/M9kwa2qF5tFTsWZidvG3ikFtO9nv6TmYHrn0dpJ1rnQw/Vk2k2IL01M+o4NXHgHMnRPv+HEgqrw+dc0cgVBD2N7G5TX71CaPZLCaj0wQ6dC1mVKXi7qLDSu3oYnI+0urMVdmAI7OXzbbubsao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595734; c=relaxed/simple;
	bh=c4686o//XQ93ZDWO2+x94jsAlumh9S/pQjyXq5pgFxM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QGD6VWN/81z5OuoYRcrxA037Ppt2SiSgbkT2AKpmlzMroEXIMK+qGNck/XJ519v3rdWZhl0tRrA1iJo1hQvfh++0NEeq2SuuUXkcHjVwhbAW/wkTKm9eIEe5bIRUU/11zPZaF3pNaLuGe3YIv/ccwE2G8dJYbEJQhhwLXrE3fQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g255Wozy; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IamXaun8cSq7SblOR9pgk69X6cid1BovaCT9lr4NMmSXXSLEQ5DexCUXnfc7i0y41XnS41sMiCNhMllLIWPioQLJpsI+LdgFiaG6+E7g02l6qx5OY1ESS6m/LGX5SMxSOPD5VXr3+iGprii7jaQACdxERp82NnkeVc1tYvhEq79cfHTEw/yJ1cDsO6KZWVGEd14HwsS1YIegheHL3MZyha+WkGSMRYWPIz/bhes6UlYS4/ev7UqyhzvPGlyUfGywpf1RRc0la9VHSUvbqio2/dbT016ZSJCb266dSe1aUtfREmYtG+AdWkVBxXHSu/vNYgEcATRYgmN26bAKr2yDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBb9IKIuG5wSCggm3AHV/gmtTSCtzJ2jX6+iRDUCPrk=;
 b=ZIqjlWtP9W/lOVZ1XQ4tELpl7gIaXPdg+t83sYgFRKXiUYa0MbAPKMoHgWFbGxDF4SNNN95TNrGYbcroF+SdqKzSicPfojpkoypegQGFZtLZ/03pFi2CaWRDR7VUitfFVVLejqA6xqmEh3YBReXQkJTmxCCJIs8kBw1TlbTU9FH5YBtdqJcRF1lqBMfcUrD15Da2gJGmKV29CVgIAotWNDRhuzQuCWCxnuotKyT/xg2dgOLqrLHZMpgVagPhCmm55wGE46i9CdYxggnWHmcXNsFb8Wq9ttTGWLDDz1/tPgbYnXONS3zxDNnrdANIyyuDnsMGBobJBYBfbQ4DVAMZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBb9IKIuG5wSCggm3AHV/gmtTSCtzJ2jX6+iRDUCPrk=;
 b=g255Wozyv0h+I8S/3m9meM3dqUET2TtcwWyhn0n4SjmexhwZrSFm3wcJjNrrBPTNGLv3OG+XU8nhQUAp4dZW3jwyBJuYhXOTf+ldgXCIvrCFDshX1rISakm8kNEe4bhgkC3o1GEFO1vFL+WgL0pXOobO1BkfQ+pdwCmRwTCw6bATWdOON6OrM4RMRkXj5wgoMg1x1t7mVW3nY+EPSHBmKRuJj5gRe6wZYOx2sDfy3AASm0qphQP+hZgO992UVugQa8rDTb5JLRzsmdCRYNFaoDkwPjCn1JCo8KiWjBFhEB2a2ppReTIHWXC+iP3/3KBgtP4zbTLkawYysVUY4JkyVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB11919.eurprd04.prod.outlook.com (2603:10a6:800:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 27 Oct
 2025 20:08:46 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 20:08:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 0/5] i3c: Add basic HDR mode support
Date: Mon, 27 Oct 2025 16:08:28 -0400
Message-Id: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3R/2gC/3XPwU7DMAwG4FeZciYodpw63Yn3QAiljctyoJ1SV
 A1NfXeyCZEWxPG3/P2Wr2qWnGRWx8NVZVnSnKaxBH44qP4UxjfRKZas0KAzgK1Otn+NMesOHHn
 fGpDOq7J9zjKky73p+aXkU5o/pvx5L17gNv3bsYA22qAPHFwki/Q0Xs6P/fSubg0LVtUiVYVFN
 R6Dkc6iY9wru1HWVGWL6hrk2KMM8FvRjwJjuCoqyoZBQpk7ZrdX7h/liiIi8DQwo5O9ajYKNn8
 137eoZbZguKp1Xb8AdwL67qoBAAA=
X-Change-ID: 20250129-i3c_ddr-b15488901eb8
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
 Frank Li <Frank.Li@nxp.com>, Carlos Song <carlos.song@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761595722; l=2955;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=c4686o//XQ93ZDWO2+x94jsAlumh9S/pQjyXq5pgFxM=;
 b=n2p798ddk4ySQKPN9Pknc703JAYFif6sEe7vg9HvdN0GkZms9sBDJJw1Tmf5fZC9/d0uyZ+iq
 h5wwA0JV1NICSB5G8yZrgW4xTyuWPPKyxxjxolybAh7ptRoEUtUym9g
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH1PEPF00013303.namprd07.prod.outlook.com
 (2603:10b6:518:1::12) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB11919:EE_
X-MS-Office365-Filtering-Correlation-Id: 2902e1c1-0b11-452f-6774-08de1594a2c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGhNTktmcVpiaHBTVFpWU0dtenllKzNEVVdRQW1idjlxTWJob1g1enpOTm9w?=
 =?utf-8?B?bERBWldFRDhzKzhzUjJiTTNYRCt2SEFKRFlwNm54L2FaeWJuSUdPTktZRmVE?=
 =?utf-8?B?bTlqemFJQTRGOXBaRlBGdmxsRUtrNmFWYnhWSXpEazNEcEQwUlVUbDlrYmxJ?=
 =?utf-8?B?WVRCTGtPcEZNUGZUdExaUzVKZERXMDNGcnlWZDBMWGdvTWkrRkZBS09UTWU1?=
 =?utf-8?B?UnMrd2g4ZGJ4cm5XSyt4R0RxVVpWY3JnRStzaW03dXVQZnZBSlhnL3psdXpi?=
 =?utf-8?B?TURyVkdWZ0Z3VzU1OGs5V2pCaEF1S2hRaW5ZdHZiSmk3UllpaWJLTjhpSEhV?=
 =?utf-8?B?VlN4K3k2OXRGUTJMUSsyL0JVSzdUdWM4RXRKNm9wWnAxYkRFb3pONkZKbVJR?=
 =?utf-8?B?RHpUQTEvWFNzZENpZVZuWVVYZTNBUkQyUS8rK3hoekMvQUFNOW5XQUhjcGZS?=
 =?utf-8?B?d2NmeUNuK3hDdW55OG8wckViRUJBMlAvVStGbGUybC9ZY1VObEtJRDBxVElR?=
 =?utf-8?B?cjFXbk5VeC9DSkFHRm9SZFNvL0RZQmx1TjRqcjlyUERaV0NWbG51SllBQ3BT?=
 =?utf-8?B?MUNUaGg4QXlyekxlUnhuQnBYQ2NSNnlUanF3MVBOVVpnd3RjQVZmSlJpb2Zj?=
 =?utf-8?B?WUY2RGJCTW9GamFWQUNyckE3M200YWp4UHFFcm9PZm9jVGU3a1M2SUJrNEtn?=
 =?utf-8?B?RFc0em81dGx2dWtVdldsUmJEK3kwMTZZRmNGYmNsYlFpZEZwSVBjVTZ4RW8y?=
 =?utf-8?B?Qk9sRDBHK2lvMnJWcGVEOXI5V2ZLdDZqNjJSdFZVaG00V045QTlZL2ZQNUFX?=
 =?utf-8?B?dU1UV3dxMkZMZ0tTWSt4Z3p5YmI5dEdCTWhlMWFVRythQWhkRm1mVXBTTlR2?=
 =?utf-8?B?L29uVk1tYVI3WUp1Q0g2QU1uWE9mT1pJN0FUSWFHbVZYam0zQkpRekZjQ1FB?=
 =?utf-8?B?TnhMdjhtbmlDQ3VoZ0QrL0tSQVdseHN0S0h3R09od2dxUFkwTWZhRkdFaVNK?=
 =?utf-8?B?dTA2L1JSOE5IL3BEQzBZTUx0WWJOb1lyWFhsay8rbm1RU3hMcU1kZWplRVlN?=
 =?utf-8?B?blNHRndFYy9vQTRzYkpmSTRxZ0twdEFlVzRycWVHS2R0N2IzTGxLTEZRWVFm?=
 =?utf-8?B?UzhYeXg0cVdwaW42WkE4MGpRdzJGSXh1Y3ROcWVLMUthYTNGbGFJb0hhNEVV?=
 =?utf-8?B?ZnNEMldESWV0b3Y4LzJtRzlLaU0xVjVMZDN2Y3lHM2xOOWQwQThCWXRRUUhH?=
 =?utf-8?B?Y0IxaW5UWFVSWCs2TG14dlFtekRCNkt2WjJja3FtYjRVWUtqVi9uU2syeDZk?=
 =?utf-8?B?SlpGMTBmTHp5dFBmTnp3RmZ0R2ZxMXdEdVZLN3g0N2hiTVN6R2xYVGh4SmEw?=
 =?utf-8?B?YjM5ZHNJUU0rV1NrMGxNdzM0S1JyL2JBakxiWVZNN0kvMDUvVENQNDFZTk1D?=
 =?utf-8?B?SnRRVHY2Wk44SmxTTEJHSHUrMmpCd1htcEpIbW1ZQkREbURGanpxUnBCVDZl?=
 =?utf-8?B?M0tiSHRZZEtVZjlON3dHR1ZDNC9paEN1WkZxc3Mva0hKUFZSeEhCOEZXQ0RU?=
 =?utf-8?B?Zm1xNnBGY1ZMMWxMTy9jbGtxN0wrYnNhWDVnS1p5WlJuNWhHeStuMjRSbzJm?=
 =?utf-8?B?MDdsbW1IR3lRcFVNN3FxNmVCalVabUd0MmxQblI1cGsvZ0p3UkQza2VVaW96?=
 =?utf-8?B?UE1UZDNkMDVsL1lFRGY4MWxHeUM1WUlYckxoS2xzNFYyZ29ybEZUU1gvUzFW?=
 =?utf-8?B?dlJ5WmNsSTFnNXFSa1llSVB3c0RqYk1qNG02UFliQ2FmTFQycktLZnJTdHVF?=
 =?utf-8?B?SkNGZ2NvY0JjS1U0K2tJZ2E0NU1zeElRVlBDellUdkJLUXZoVWR6Ym9nMnd4?=
 =?utf-8?B?UUg2TldXaG9Ib2VJVHRUSmc0OEMyenZXK2dVWGFTMmFHSDZMZjBVVUxoSFJD?=
 =?utf-8?B?T3UrOVZocGxtWklWNGZuQ2NqSkdwV2plQUR0eFBNRkdzQ0QzSWV1K0ZBbk1G?=
 =?utf-8?B?MzhqQ0hYWGNkQ084MDlZTkpUdU1WK0tmZVl0WFlQRjJoZG1sWkJtOWMzTXVR?=
 =?utf-8?Q?EM+J+5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RllKblJ3cDVPNDNNREdiaC92cjZLaUYvMjFiTXp0V2E2N0VVVFBuM05aWEl6?=
 =?utf-8?B?K0pZeUZ5TWF5Z1Rhb0NSdTdrT0lKTjhvOVNrY1RoWEY4bm5wbEhvQmRtNGxo?=
 =?utf-8?B?emZlY1hGVEN1N0pTS2NrOEE2d05CMjM0OXQ1WE53bTlNZm1KcU1IQTBjb3RX?=
 =?utf-8?B?NCtYQVJBcEZDa1lBQXlUcGpqR1ZhV05QS1FqNVpTZnBNU3QvNmV2MXEvNCs4?=
 =?utf-8?B?aGZiZ2t4SWZtOXZrYUhJaVhBMEdXSlphMlFmNy9pRDYxUE1qa2M2QUk0akp6?=
 =?utf-8?B?R005RmYyelFyR2NBN3p3VGhyTStHQUNVMDRzMllXN0FiZVhKVmM3R1Z4VUd2?=
 =?utf-8?B?SWpBNE1JSlJ5Q0lnalhSVWxQcitQaXBCNXpuSTV0MTFOUUFaQUxtWCtEZVRp?=
 =?utf-8?B?UXZkNms0eWlIcVpwWFBhU01GWHArRWZVeSs1TGVkak55SlQzdDFIaTlCU2ly?=
 =?utf-8?B?TzNNY2g2MEhDNjdOeVBRd0w3NXg0b2FjaVVIK25rWStENkxTSnpWMnN1ZWhW?=
 =?utf-8?B?aDc5MVE1UU5EVlRrRGkyL3I0NEh1UmRIRFkxR0cyUjBibWlwY2VXWWRWRm8z?=
 =?utf-8?B?VmhCQ0x2ZFpUc2lDMFkwb1AxR0pCczhNdGdYZFV4NjVrODkvU1RxWWRQR1pG?=
 =?utf-8?B?TE1TYlNma0VnLzZLekpnenFXMGRJYkNVcGd6TmwzOFdCSEFpVlJJV2dsVytw?=
 =?utf-8?B?RjYxQ3l4NWFjaWZpNVZ4OXUwSFBWTlZTc2J5K2ZqWnJndXQremQ3VWxpRzBH?=
 =?utf-8?B?YUV2K1NaMzJqMU1vOEROS3pPZmtqdml5Q1ZtUk85L3JjbTBqZjdyNGFwbnps?=
 =?utf-8?B?cUtlNjNPS0MvV3hNeWFmdWs2Um9HWXFMSWdrcGhUeTZPQkM3eUYvYUtQVXRI?=
 =?utf-8?B?N1hRcndtUDluNHVkelRyYnZNSUZ2QmIrOENESkJETXI5L0U5d0VMY2dpQmpi?=
 =?utf-8?B?U2lxaDNFU3pXQnNGT29aZlQ1T1lQWGtMUFFJdk5BWkI4V2VMYUQ4U3FNRDgx?=
 =?utf-8?B?cGtva0xvZG4xVTVwR1Y4UEhEK3NhUnRGcG9xZjc1MXRITWZxTWlqd2dYelJm?=
 =?utf-8?B?ZzErallERlk4dWl6bEh2R1BpUkNoVU02Ui8vakpveGZFZGwrL0t1RnBUWGw4?=
 =?utf-8?B?eEd0TW9jUVBxMzRkUTJPK1I2cCs3QzhhcWQ0UWIweENXbTlvcktYUDVlbXg1?=
 =?utf-8?B?YkNod2lwcVJyOUduZ3oxcHY0RGhkVE1YZWlIclByVEhLZWtDc296S3B1aG9M?=
 =?utf-8?B?ekp3THpsRUZoT3lpNzd0V2pmSTJpcm9ZUkZvRzRiVk1OU2J4blA3b1F3MTJp?=
 =?utf-8?B?ZHJzWDNyeTJyY1N2Ymh0S0hDVWhRclVwanZYaUp0L0M5NHIxbFNhSXVNbkdW?=
 =?utf-8?B?ZUZQYW1aSVFVRnZ4dUpKdkJLdlFESFVlTWtxdEh0c0laWkxKTm95cG0wME9k?=
 =?utf-8?B?cDhHRldZWUt6RG9mVndVMUc4SWRxNDdHdkR1RjdvNjNIQ1c0cFBEdkJOaTRF?=
 =?utf-8?B?MnJsam03WjhGekxwNDhDYW5nWGpIN0FVQ3VlUXJpV0hyTGFZOUlxaVhvTzVy?=
 =?utf-8?B?a2hJL0d5TDJmM3R0bnBwQUQ4eGdzdjlBZFZrT0lVeHpEREd2blNac0JHTTM5?=
 =?utf-8?B?ZTB4OTBYS3hjMGQ2a0d5YVlmYmlVSC9zLyt4bGRMM0lSVlV4aUtXdk5GSE1X?=
 =?utf-8?B?djdBcFVwKzR0bG41aGlFTC85THJLdFNHNEVRTlJvRnBwaExsRUN5bFlVOWYw?=
 =?utf-8?B?dC95V2FMM3MvQjhlb00yZkJEMlU0dVArcllBSlRHWXN4ZHY3TEhVMS9UWTUv?=
 =?utf-8?B?a3VwNXhWcm9VSTNJQms3N3p6VkNYWnozMFdMeEZ0TTZOYjNIZlR3THRiZ3RB?=
 =?utf-8?B?M3IybGMwZVU1T2piaERCdDJkNWRGNFZrdUJxNXFaekYzb0JQNWFHQWFJUlIw?=
 =?utf-8?B?RXc0alJyTERhVEQzY05FOHp4RVF5dDF1dnlMRWVpM05aUDM0akh5US9xQmJM?=
 =?utf-8?B?ZS9oMTNJU1VNUFVtZXR2UnJvMHNIbUV3TGIyQi8ya0hrbzlpbkw1ZnduQmwz?=
 =?utf-8?B?Z3haS0p4RTE4V1ZrNEQvNnZIZHB3Zld0d0Nvd3AvSFAxa1VvSGJxejVVajI4?=
 =?utf-8?Q?s21k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2902e1c1-0b11-452f-6774-08de1594a2c1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 20:08:46.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJzWfOznRQxt/pa3Z3XFa35d6UNYhmNR4lAlOsAXVyr+ghkusrE5ffkhSjwcWXIbANjpdLzNQfGVij4re0uIJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11919

Add basic HDR mode support, only support private transfer, not support
CCC command.

Update i3c framework API to allow pass down mode and extend driver callback
function.

Implement HDR transfer in svc i3c master driver.

Simplifed HDR flow is (ref i3c spec line 5514) Figure 129

<--              SDR            ---> | <--- HDR
START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)

                                    ----> |
HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT

Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
read/write command.

svc hardware can auto issue SDR part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7:
- add explicit define for I3C_HDR_*
- add missed include files.
- detail see each patches' change log
- CONFIG_DEBUG_ATOMIC_SLEEP=y
- Link to v6: https://lore.kernel.org/r/20251014-i3c_ddr-v6-0-3afe49773107@nxp.com

Changes in v6:
- remove acpi part
- collect Conor Dooley ack tags
- Link to v5: https://lore.kernel.org/r/20251007-i3c_ddr-v5-0-444184f7725e@nxp.com

Changes in v5:
- Just realized missed CC mail list devicetree@vger.kernel.org and resend
- Link to v4: https://lore.kernel.org/r/20251007-i3c_ddr-v4-0-3afea5105775@nxp.com

Changes in v4:
- use master's hdr_cap to check HDR cap.
- add mmc5603 support.
- Link to v3: https://lore.kernel.org/r/20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com

Changes in v3:
- Add new patch for change rnw to union for svc.
- Detial changes see each patch's change log.
- Link to v2: https://lore.kernel.org/r/20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com

Changes in v2:
- Add sensor driver, which use HDR mode read/write data.
- change priv_xfer to i3c_xfer.
- Link to v1: https://lore.kernel.org/r/20250129-i3c_ddr-v1-0-028a7a5d4324@nxp.com

---
Frank Li (5):
      i3c: Add HDR API support
      i3c: master: svc: Replace bool rnw with union for HDR support
      i3c: master: svc: Add basic HDR mode support
      dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
      iio: magnetometer: Add mmc5633 sensor

 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 drivers/i3c/device.c                               |  27 +-
 drivers/i3c/internals.h                            |   6 +-
 drivers/i3c/master.c                               |  20 +-
 drivers/i3c/master/svc-i3c-master.c                | 115 +++-
 drivers/iio/magnetometer/Kconfig                   |  12 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/mmc5633.c                 | 588 +++++++++++++++++++++
 include/linux/i3c/device.h                         |  40 +-
 include/linux/i3c/master.h                         |   4 +
 10 files changed, 775 insertions(+), 42 deletions(-)
---
base-commit: df05ef50ada6a8e2fe758adf1b8fa35eea801b2d
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


