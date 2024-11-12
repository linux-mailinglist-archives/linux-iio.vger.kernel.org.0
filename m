Return-Path: <linux-iio+bounces-12183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF0B9C5DC8
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 17:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7641F23582
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8AB20D515;
	Tue, 12 Nov 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kgA8mlbp"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED5208224;
	Tue, 12 Nov 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430349; cv=fail; b=tUOILClzfhFlGJ2yDP5Qoyf4gjF0FNnmYw3ut3XY0P/R73oXcY5rXF8NrttN+AZWQlUtIvvuLeneBfZbQnDYk768Rk+b4qlNtGC2TA8ut5HnYZRbh8S4yn8fUVmKGi48nIF3NvLkb375j6RK4BJv0nzsV1NDMBNd5/fAdvs7Qas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430349; c=relaxed/simple;
	bh=pHdcouA8YK+jThZXHKLq4J7wOSdvJ4TG+3dUQln/lGc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gXxwHq3Y+qgiOB1N3gmhxI+q51wHl+BBzstEv+P/9d4MFTCZ7qjAgoKZeXW7dz4UbC7RhqTwUkHvhL+wnAwTYdQC93UzIPoZ/jC9rK675AcfFFlzmOrVxSlziu/x+BeWym/ZL7p5VCbclMKZShb2lglZrStmxIFWL9jMuuKnrI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kgA8mlbp; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxXQMxT7s5oPgrhSPWogO9vzXEbQD9bw/lacePggg1WK2PXyHLJBuNy8JOsIz2vh55Itth2aiszF1t7ie3RM3H7z33TSxNjI/0Xug67k+zKXK+TnzMhYEmpRN9v1rUtIJBgEB6dY4eMSa+woMEgNTAeAZijyHS6vTvtLPnNyo74zPnnqM1DxII4dz/z/yKxRSC8psI16aLi+2eb1e5uIOcJB5U7+y14FuQtKoKLHSC7nfL5jLUdCv9amqs9zlIlzciilbrZB9xcmISOwCLSfKtdDYo5FNN7C3E93ringum2d/HGAIhE284JKjNrVftPCOa7qN87pqyS+XM94xHhieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTxUcGEWHvp7e9+sBMtLPKUzbzbsN2et/K/W1RTGWtc=;
 b=cPi5iVjeG8MSjljjHkdiK22vAnLi/LAx53ZZ1IaMETMxeOLE0qb+cVKSEnOQzmfMJF+3MWIAey8skNos13K29FRXjeuyCnwuUmdXS3EjtiU2N12xyx7OYaxHlqtSOknkJ7k9x/yUN84I4Q0r1bdIqvMoMlaSDR4i+cDMouLLi+FpeCTWw6XqTdb7S5tOdj+ycUd9wCwXaao/Va3YTxtzFos8dr8rXQR7n7mlCkcEZLDpU482zYdvoIIocAWYnhkQkfb4FaxUiJVuHWVytDDtgbCbJWZKARg8b1AYL70ILVk69+3tS6Bta96XUq2xl3AZfGgapqBJEFj/kZCypxMR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTxUcGEWHvp7e9+sBMtLPKUzbzbsN2et/K/W1RTGWtc=;
 b=kgA8mlbpCqF1UyV3SC9YYQCp1w32xN6QpVl6kl8NAPvYuMryiGT+Kf0R0FmWSrxpgy1FA4mod5X8gCMAe/xMwjEQ6EjZsJPwGNsSObs1hnBi8vO5S61S6/0KT684r9a3a0y31Aee8Zr+RFCqTr2ou5mWG9Gws0SSwQtcaRUd+TP4gT+qNcfmI5acojHt7doGqqXHeweR43a3AMr0jc7YWI+KZeKx+7CPyLoYF3YB4VsA7s/FIAmhPkhW90L6OvnwYaCFdK25r12a+Hat2P3cU2yVOvMYN/YhNm0fNzQBzgZ4jO1I4XyI/sfTU5TQPDhtSzCxwXH7IeT4xTM8Oebsng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9562.eurprd04.prod.outlook.com (2603:10a6:10:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 16:52:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 16:52:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 Nov 2024 11:51:59 -0500
Subject: [PATCH v4 1/3] hwmon: tmp108: Add helper function
 tmp108_common_probe() to prepare I3C support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-p3t1085-v4-1-a1334314b1e6@nxp.com>
References: <20241112-p3t1085-v4-0-a1334314b1e6@nxp.com>
In-Reply-To: <20241112-p3t1085-v4-0-a1334314b1e6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731430334; l=2743;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pHdcouA8YK+jThZXHKLq4J7wOSdvJ4TG+3dUQln/lGc=;
 b=GFJW+KjOb1j/+ltPPomYrHhu6LX5ffVbhLVaAmVEsdL4tbyj6INmTjSJqfRN1QYkLoDrwEJNC
 XF/2EGOIqMfCt7rKh6h/Pzv7ie9odDH1JOjw816ELdoW+gVYDKXguT2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca5d2d9-f579-4ef0-37a0-08dd033a6156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTZrY1luTkYvU1p6RTNGaDhEUEFXdVVHai8zRGE5Qm02ckN0QnVQeFJSbUMx?=
 =?utf-8?B?b3U0eUdZSFE4VGVxV01mMkU2anIwR3Q5bmtzdTkzdm1BRTR1VnhrQXJBenp0?=
 =?utf-8?B?VmJMSTN1N2ZmeElLcEVEdHRvSTMvSGttZFlMQ3BrOUNZeVB5N1VDWW10Nndj?=
 =?utf-8?B?UzlnbDRLaVVXejhNVVlQQWlCQTlHc0k5VkR0TGh4R2xxa0s3MVRxY083eHlK?=
 =?utf-8?B?Z05tYnBHTkxnYktmUk1mRHVUV3JiTml4TEt1V0RvVTFDdmhPdzNwOS95dHMy?=
 =?utf-8?B?Z3F5bEdkYjNpaFNvcTE1akdoVGhRbnBPalpka0Q0ZEFsWkZPSEtDMEx0dUcx?=
 =?utf-8?B?M3lkamVlcUdoRTY4VkhQWTRiRjVaNHRUUUtLTHVIaVpjVElTQTB0WXJCM1No?=
 =?utf-8?B?SGZoSEU5OFVvTmkvcW0rVmVGTWZ6YW5NemZ1U0J3ZXk2UjVXTC9Iam8vbTl1?=
 =?utf-8?B?RnczR3FYVHVrZE1YT2pDVzJUR0RLMU56OVhXUXlld2pyRlkvYTRyWHVUa2w2?=
 =?utf-8?B?L2p3MGEyelZiZXorcmUvbzVvRFNiQUVTNEZCcE9ONmliWENOREFOTE5TZWtv?=
 =?utf-8?B?WlBpZ1E5VzEzVTFIMWNCUkhYYUVMMUdBajVXaExUbDhrRnppSC9ZeGRLNlh0?=
 =?utf-8?B?dGpzQk9ldkJYT3FPcVpsRzJobjR5Y0xGKytHMVp0SzErZmx6OW8rMnQvR0c2?=
 =?utf-8?B?MW1GRVBPMmd6d2VkYUowcENWcGRDUXdoc1NJcElqazRtd0FMay90U2JVWXhO?=
 =?utf-8?B?NjlBN1EyemlhMDk5akJ4Ymkvc2VvcXdkZXFmL0hrazFhTnU3cEUvYVl2cjFH?=
 =?utf-8?B?MTdkOWJlL0JwSWYzWFp6b0srSmY1M2g5ek1LRnNhVmtpRkk5Kyt6eUxsWExV?=
 =?utf-8?B?NWtjaDZ0N0xzVXZDMlVWZk5WMms4cXEzN3FWcUhPeW94MXd4azdRRzlvT1dI?=
 =?utf-8?B?WmJnR0JBNCtYNEVyQkdvV1hkY0lrMWdBV241Z1lNYzNEWGJ5SUtvU1pyQ2dL?=
 =?utf-8?B?UDBBcVdIRGlxOG53NEpjYStvc2NYb1ZyQ2gya0d1aktUeE1yS3dibGZmUmJI?=
 =?utf-8?B?dDJqLzhYV3RUbms5dVk2SGx5WjdRUTZwb1Jkc2lyNVlGRUdtbWNtTDBxVlJh?=
 =?utf-8?B?bFU4NUFRR2k1UWdiWWFBRjJXei92bEdHSzd0OHVITjBUWHRJM2J0WjVBaVJG?=
 =?utf-8?B?b0ZNSllBSDdjMGJQTkFhM0xHK2U3N2t3Z3JGbGFoSHBaeW1udW5SUTFxczJo?=
 =?utf-8?B?RkMxa2s1K1QwYjBudWw5RlUrV0YzME40VUs2VVFCYjAvKzFMOFpNdzJQcXkw?=
 =?utf-8?B?VjRuTVNmbG9wM251N01Zd0JoZ3N1cXpkOTQyenF2WGt5dVhSUmhBQWN0MjN6?=
 =?utf-8?B?cGVCSVJncTJFTU9GUGVBOS9NMUhHQWF0WHFMV1NNN29tOXJlZkJxNlo4VnZ1?=
 =?utf-8?B?UzhWcjdidUNGRU1OZll4UVRKUTIxVFBUTFFVU1lCZFB2VlVobGxTT05BZXVo?=
 =?utf-8?B?dHV0NW5jWEMzQVFqQVVjcmpMWVpKVEdtTTh4YVR6bXJxNUE1eHJhcWdKU3l2?=
 =?utf-8?B?VmdnTlk1cXdjQUMreWsvYjMzekpXbHkyQ1dLVTRsQnE4RjBqeHFMWUxjQjRy?=
 =?utf-8?B?Tk9nSFAxclVoWXU5YlRWWnRLNm11d29WQXhYeWlJOHpLWDZVS3RLWEhhSmM5?=
 =?utf-8?B?Uk16NmFFUStkbU5XVDVvZlBrNXlMdjc0aUFBT2ZuMk5VQ1NRMGVTZTRFZ1dH?=
 =?utf-8?B?TGVVazJiZDVCREJ5dk9UR093QW1QS2JnMVNTWlZMclVxN0EyNXhTaG1BZGFP?=
 =?utf-8?B?ZDZIRGttNmtqdHpCZXI3QUc2ZHZPbEJXWjhmQXhIaWF4QlhDZFdFZ2FYbDFv?=
 =?utf-8?Q?q64rrwPmzYGDF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q29Lb2pTV2g4TFk4TUV0R2tHd3dST1ZhdEpzWXRFbnU3eFFpdVlZbGNzaGlN?=
 =?utf-8?B?K0hEcExGTnFiNVlIVEJKeHloSmhzUWZwUFpRQ3dJRDVvdVB5aHd2RzVHWHZY?=
 =?utf-8?B?SjJIVUZ6enE4NTFaQ1VYT1VoTVRiK2ZYbG9tQndRMFJZWDBIUEwreDZ0M2Ez?=
 =?utf-8?B?T3dQbFhuQU5WTVU3QlVWMHNxYnkxbjZ2SHhEMkdQRWdIamRUS2k5QWpvZ1JB?=
 =?utf-8?B?aXVjOWo1NnYwd3VKNGFRd3BDSjI2QTBFTU9Vc2Y3WkV3QUQ4ZGFINXpmUTYv?=
 =?utf-8?B?UnRtdWVXMUdGM2JMSWVOaHY5aGc3Wk04eXk3UEl5L3BwSDE0ZGdFT2lrc3ZJ?=
 =?utf-8?B?OEFYMTFLNXlUaTltK3orL1RoTW02NitkUXNuY3hDdWZSNWh6WXhvakp2OHpZ?=
 =?utf-8?B?ZVJ2U3dxWU1YL281dUNoTDdVNWRUWW5pWDI5YkhwWGhrVkR4SkFFU1NQc2lJ?=
 =?utf-8?B?Z1ZuRURFQ2pSem5wejI1WVEwcURFT2lyenRjcElpUnVLZktaRU8yYUI2YkJR?=
 =?utf-8?B?T1lHN1ZBZVJVeVFOM3lVb1poRmFhYTRCZUo5cEFYell3NmFCRDRWSUpxWjgz?=
 =?utf-8?B?NkNvWnZ4NGhQdHMvbSsvZmZaNWJJd0ZuOGNoVVkzQjE5QUdEbVJoMmdxeTl2?=
 =?utf-8?B?N1VFVjJvMFFlWFBQaWF4QndNSlp6RitsTzNaQ0dVZFRjNUdzWTFHRHBmYkc3?=
 =?utf-8?B?NG13aGFGN1d6QUJpU1RwbzlyU0RIcmtmRkUwUkJHWHdzSjJHcVlwbWhWU2ht?=
 =?utf-8?B?NmdFRXdmMkZLM0dJSXdMMEg4SGpqS3dpeE54QU5ISVFOMzlmRDVLZG5iQ3dV?=
 =?utf-8?B?UyszZ3VhNU55ZGVyeEZHMWUyazBLajRNUUdNNEEvVzZRaUdpK0pyUExOdGFJ?=
 =?utf-8?B?WGUwbkJ0aFJ4QWgvd1J1dEhuWUtReDEzV0pNMEdtWGpHNytEUEpRMEVhZ01i?=
 =?utf-8?B?dmd2Uk1PMUlUd1F3TXN3YVlDUWtvQ05MaUhVb0dYa1VrZ2RqT01oRjVxbWRZ?=
 =?utf-8?B?dFZuUkF5K0gvOG0xSnkrb2pOaUlTWXhmbTJEUnVZT0F4NnRDSTVRWnlKQW81?=
 =?utf-8?B?dHMxUkxPSEtxZnZBSGRHQW1HVWgvZ1lWM0xtb1EycFdTLzJWVGxVSVQzTGkr?=
 =?utf-8?B?My96aW00OWlLR0NBcUN4dmYxQjFCV3BYNVZwQTVkS2FuK3RnRHhXSUxxSjNQ?=
 =?utf-8?B?ZjQ4bW9TRUNpVEdSS3dMWll1ZmJyaktyMldKb1FZaHl3b0I1TGtrOEpmUHdG?=
 =?utf-8?B?Ry9GSC8xZjFIa293YWRYTk9zTDc4Kyt1NWVaT09wM1Q0Y0F6YW43Vm9BVUpY?=
 =?utf-8?B?R0FsQUZjTURTNTN1Y0FYUzk4NTNBbWx1QTFWakE3S3d2VGhCaXJnV3I3Nkc0?=
 =?utf-8?B?MUlnWGRVbkhQc01IK1B1ZytnbS9pNEpnelhBYzZSd2s5SDc3NVJNcG5pd0Zj?=
 =?utf-8?B?MWtvMWRJdVUxRlFxVkZUR1hkcDRpZWRtTytWRDBxNm85VnEzNUtXWC9PdFZU?=
 =?utf-8?B?dHpjZHh6b1lHVGNmd1Noc0xyWlZiRWMzVzdvL1JNaHpwUGxQUHNmaDMvUEtP?=
 =?utf-8?B?VDN4ZzR2bGZBTURZWkU1UmRuR0IydjRDeDhna0lrYS8vMTFCcy9hdUFCMkNW?=
 =?utf-8?B?Sk96V2lidEU3MkRiY3FFeHE4blBIbS9jTnVzM2VjRm9yZlN6endqdSsrWnZN?=
 =?utf-8?B?SURsWW1lZDZneUhlNjhrMzBHMUovUVVNTEJFNkNzZ0IwWkJVUmxaWlF4S0E0?=
 =?utf-8?B?d0hoakJGSnV1bHlZaFJNV092SHR6TzBGVUF6cWozU1Y5Rlp0UnBHODJOcmlR?=
 =?utf-8?B?MG1EN1NZU1NTbjBNT21SeFN2bytBWlo2M3NUMWNhOXVaOXJ6QXhibWx2MFFr?=
 =?utf-8?B?TG5pQWRkNEZobm5YT1Z0M3VvR3VMV0FSN0xQaXkzWXRlbW5WTVozTVAvY2FP?=
 =?utf-8?B?Rzdra0l6RXNhd25MQTVJYWxGejFHdVFndEFXaDhwLzZHbHlSM0ZxbVhaNS9V?=
 =?utf-8?B?ZUNKNXBwQjNFZ0daS1kxN3hsZ3RNeTBrbUVwckxJOWJISERKenlvUVoyVHdx?=
 =?utf-8?B?SktkeGZuaFlEWDllVXFNbHh1SDUxTUx2bWRlMXZFalE5eHZzK0EvdFJ1QUN4?=
 =?utf-8?Q?Nv5egPR/c7cmjf5STK+L+WIok?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca5d2d9-f579-4ef0-37a0-08dd033a6156
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 16:52:23.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAH1C+i38ypPZnvxGO0S9/Pr8EZ6KTj9VBaP7Lr1MdmsLkNa6BKTLZFvv8CAzYL+yUMLgJLQZKVRBls3tfkDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9562

Add help function tmp108_common_probe() to pave road to support i3c for
P3T1085(NXP) chip.

Use dev_err_probe() to simple code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
dev_err_probe() have not involve addition diff change. The difference
always list these code block change regardless use dev_err_probe().
---
change from v2 to v3
- update subject by add  prepare I3C support"
---
 drivers/hwmon/tmp108.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index b561b452d8d39..bfbea6349a95f 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -323,33 +323,19 @@ static const struct regmap_config tmp108_regmap_config = {
 	.use_single_write = true,
 };
 
-static int tmp108_probe(struct i2c_client *client)
+static int tmp108_common_probe(struct device *dev, struct regmap *regmap, char *name)
 {
-	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct tmp108 *tmp108;
-	int err;
 	u32 config;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_err(dev,
-			"adapter doesn't support SMBus word transactions\n");
-		return -ENODEV;
-	}
+	int err;
 
 	tmp108 = devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, tmp108);
-
-	tmp108->regmap = devm_regmap_init_i2c(client, &tmp108_regmap_config);
-	if (IS_ERR(tmp108->regmap)) {
-		err = PTR_ERR(tmp108->regmap);
-		dev_err(dev, "regmap init failed: %d", err);
-		return err;
-	}
+	tmp108->regmap = regmap;
 
 	err = regmap_read(tmp108->regmap, TMP108_REG_CONF, &config);
 	if (err < 0) {
@@ -383,13 +369,30 @@ static int tmp108_probe(struct i2c_client *client)
 		return err;
 	}
 
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, name,
 							 tmp108,
 							 &tmp108_chip_info,
 							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+static int tmp108_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return dev_err_probe(dev, -ENODEV,
+				     "adapter doesn't support SMBus word transactions\n");
+
+	regmap = devm_regmap_init_i2c(client, &tmp108_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return tmp108_common_probe(dev, regmap, client->name);
+}
+
 static int tmp108_suspend(struct device *dev)
 {
 	struct tmp108 *tmp108 = dev_get_drvdata(dev);

-- 
2.34.1


