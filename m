Return-Path: <linux-iio+bounces-26961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E22CAEF09
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 06:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32A2E300D66D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 05:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C519629DB99;
	Tue,  9 Dec 2025 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="SD4Ivexm"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023101.outbound.protection.outlook.com [52.101.72.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A45D241CB7;
	Tue,  9 Dec 2025 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765258443; cv=fail; b=h6NK54dhRDbpZwmfJUN/ORfq/zDsywcxJ6YLhP/RhKYfecHniEvBQC0GgUMEleFrPpD6iUwk+xPcNOAFXH5sLNE6JA0KwINbTfmzjTVvjm/tU2/zlIIs7Egc3MwliyEEv0yNHah4RqORwCpU0m6Mcbbn7+9AasRBesvlkzh+CCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765258443; c=relaxed/simple;
	bh=Ld+27AeBB8OeGqYzu25g8XBP8/B1KIZ9oJDN25v4fgk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TW4H999FtdpMe7DGaHNFAc/wsC2fyjwRdwK2mIEnDOkbGvCnkAZN5DU5ix5UccD3PXR+2pZIGSUwFwCWIXzEr/W8nsIgMSlKPR7RcqaUBH5M6yKl+SPCFb6IVYQPaX8OtZpZytU7KuUgaoInz+4iFlqed3JAS6mp+JMFvRwO2jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=SD4Ivexm; arc=fail smtp.client-ip=52.101.72.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdJgaHI96jEIBaO0opGtK0kbzixu/9EHhjn7XgkZkYeBRdOMNga3Vy0k3GPwgeFwmLCfYMsUc0kp2yZ0eEiQz3CbXNvPhL8VkXX9OLy0x28C2DmGZrsKLagMcrxsMpiXG0laEIXov8Ko8JO+Tlo3hpmNzRtrGsyIqn3Z+0+by7Tw/UwR8TuWO2ZShc6CnZ+p9PubZB0G9lTVW7VKjOUoAvnyaXybuV2kXAKk3c4Lvo5B9zTDl5xp682A2hHhlfqdv2quCVP7cW+vloBKzg9Lut3Xmv8iIiSzuDQ4Mq40A+IBfwocG+QXd4WrKKAFZnOziQ7R7BU9AVuxKYr9zbGwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJjgdWUbn64BzhfxZC8r6dQNFdX9JgcPg5ibaYJbpwM=;
 b=YluoKfF4uxj0j0HMb3QuNDtCANOzGfxtWa+GaMGfgtwCX2L5pJfvYv66Q4ESSNv3MHDZZYYlh47m6AdeB1QUtk9vMx1s5X0Z3r2rD3brn9mfEqVVJ+y+wqnn8G+vXYI9bV1cK03DEjFFSEZ9eE7NHdYJOlNLWYpH35540/gAeBQS++KzuI8x5ngmfWgpeLKHoJ8kfp5pYnXZaIE+QHnoa7x5/v+4YF+uC6bzyInp/r6YuZU2Gn1wax3MN9ba+rppBembmQBbEwLZ8O0HQJhMU0oat4ScoOCTxS/kST8s5g6qc0u65VxbuXNxXV04wqApWq66Y4dBqvRRkuia5z1Dhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJjgdWUbn64BzhfxZC8r6dQNFdX9JgcPg5ibaYJbpwM=;
 b=SD4Ivexm/Q86+ON1g98TbNwgGNMaP8mE1sBnecfjih6UqzaB1UE3LRa326e9RjTcP50nwyxlJBaSxtyqIPwZZJ4HB14OpbU+B4jtzPr2vpDRKa83O8KcN6SAwqJ6Rb4zNJ+y1PLCQwqrDFSjnjPMWSvD+PGNhnERmR2WTXdkJ5v4VTFsehk6xOcnTQPe3BoowCwfD+MYnss0tcZQPhdmQqyIh8n7kcuogAoixSNa0JjQRhlN9I1QhWYvPTZKr/RIxlHdgomG9N1VqSr13SHBxjpOHCQ1giWjFIhDxXiA5RDg2h3hcZ0mn7/N8UzpqKom7LKshy5PQ44Fwh5BcVF85A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VE1PR06MB7053.eurprd06.prod.outlook.com (2603:10a6:800:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 05:33:51 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 05:33:51 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v4 0/3] iio: adc: ad9467: add support for ad9211
Date: Tue, 09 Dec 2025 05:32:25 +0000
Message-Id: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGm0N2kC/23PTQ7CIBCG4as0rMUw/JTiynsYFwQGS6KtAUM0T
 e8u7aqNLlh8kzxvwkQypoiZnJqJJCwxx3GoQx4a4no73JBGXzfhjCvgTFDrfX2GA9DOaO+MUBI
 6RSp4JgzxvcYu17r7mF9j+qztAsv1b6YAZRQ0Q6Ox9QHgXGzM9m6PbnyQJVT4Fssd5hVbUC0Eo
 zWi+sVii7sdFhU7aepHgjXg5B7P8/wFxPLihiABAAA=
X-Change-ID: 20251203-add-ad9211-897dc9354185
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765258430; l=1698;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=Ld+27AeBB8OeGqYzu25g8XBP8/B1KIZ9oJDN25v4fgk=;
 b=E/P6/A9KBdxn7l5VdXcJxBPIQee9JDT+60i9npL6hdc8NJDqVZ9fJXU3xTsDmhaZFdANfSbas
 /hU04TiLgPjAxXn0DmHsX5/zfHa0gHevvuTuZOK9MLDS4bVZ14u0pkv
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF00002E6A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::38) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VE1PR06MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f497b4-e504-4d45-588e-08de36e488da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTZsVnU3bkhTM0pxYUNlWEN5SE1SZVJhRjBtNDRxTWVTZmtNWVFlVGRyRVVL?=
 =?utf-8?B?SThYdWJMUkwydElnK2NtaGw2RzRzWWJLTzh0aE0yZ1dGYkVwUkEzakplNkk1?=
 =?utf-8?B?U3lnVmRVZjRXQ0JvSHMxQjFXeHRRaVBvRjdwRTRva0ZwR0tqTUFsUlQ3MUNW?=
 =?utf-8?B?RGZDRnRGOGZSMHFhS3lDQ05WbEd6dW54WjdoQ3Q4aUZRdmR5MlY0R1dMOVMw?=
 =?utf-8?B?bW9wbHZMR0J1VVU2aklNcko0V1NCa3UyVVZobmhHM2pXVTd3QUlSTlRKeE45?=
 =?utf-8?B?R28vUG9VL0ZBd0RzcW1RalNsY2ZrbERKTVljc25FcE9BamoyRHBBWnVWNG5Z?=
 =?utf-8?B?TkVrVnJvaG16MzJXa0tKRWFXM2NHUzZxMlB1aTRtclhFWlUycnROQ0F1aDNl?=
 =?utf-8?B?bUJYTndLL3JyQVdVZmRHNkdSeGp0YmI4N1B3bTArVFErSzRXc2F1UTNkNUNK?=
 =?utf-8?B?eStSMnlxMWJKWmFKbGVtQjlUMHFCdHZUVmZrbS8xaVRHYjU1UVFPR0czWFJV?=
 =?utf-8?B?elJwOGQvUTlqU0RxcDdyWW1HQnFEVkhkanZWUGR3emJHUThsZGJ6TUtmbjlY?=
 =?utf-8?B?TlZETzlPWC9JVzZuZjRjcGZHajQzdVF0UFVobTJ5TitDSE5LeitIbjNDR3lz?=
 =?utf-8?B?Rnc2ZDZJTDlBNW4wSmxpczhmbnZ4bzZzQUcwd2dMWnZnZDRPNXJlNUVLOHgw?=
 =?utf-8?B?R1ZXT0ZiRFhRMTZGaEZUVTMvdTZLOEt4WjFpWTZRQVN2ZDA4c0J3NDJWckdl?=
 =?utf-8?B?QzlPdjAzVGY0cGRISWFvSjcyQUFvMUpqMVZCblc0R1BET2JPVGhDOWZmOGNj?=
 =?utf-8?B?d1FObjFSYVpkRmJIWnJEbXo3Ti9zbS9Ia0g1RVJKT3Z5ait4L2JiMGg1cVJM?=
 =?utf-8?B?Q2pRMnJzMUUrdzZHUkdGVzhVWEpTOE1UNmN4RWs3aUtkaDdTcmtTNkNhWjda?=
 =?utf-8?B?NFRoVmFOemFjeHlYZXRXQXdaQklDME5WajJPNnh5aWxDMFJYT2RMTEV3TjFE?=
 =?utf-8?B?K2UxV2FvUmgxbVNpL0dRNmVDSWlGVjFwNUs0c1FNMkFpNGlrblZsTkpuellW?=
 =?utf-8?B?OE51UXV3dWxHeCtOSm05M1FsVktiNkdvU0srTVRiS3A4VWdxd2w1SlZHWVNP?=
 =?utf-8?B?OC8wYjlrZkFWUmkwMHBEVmJIMURROWVTR2R0eTdodkc5VnEyc2RxdWE1d3Fr?=
 =?utf-8?B?NTNRTWYzYjF4Q3crRGM3Wnd3OGROODZXYmFCZ2hNdDVWT0o3d2w1UG55YzVi?=
 =?utf-8?B?ajE5TjJTWW5IbnBPblJlUnU4azVFd0R6YTZodFltR1ZrSGZhS3lHWUtiTTdx?=
 =?utf-8?B?RkpxaVFtdlQ2aUdOMUtkWVZLeTRlak5PSk9NSGVUYlFsVXRTZ2haTnpXa0pp?=
 =?utf-8?B?dlB1ZWtOamEvKzZNd1RseWkzak5abU1MUUZabTBlaG93ZUNDSTZMeWtGR084?=
 =?utf-8?B?VDgyTVVwcXRVQkp1ajNob3dWVTJwTDVMY1N2ZG1BUGJMNHYrbEVxMFpGaDEv?=
 =?utf-8?B?VExtbXgzaFphUUdWREpxY0lXYUhEZ25xVTZnVDNHT2pqL25vZnlwV0FwcGlK?=
 =?utf-8?B?OGNZSEowOWhwb1J5ZGJ2WkV3RnlnTDJCR3R5T3N2MURvdG16dmRwL2RRWHM4?=
 =?utf-8?B?TDZNb2VLTWttSFdnbXZMTDBiOTlpcEpTNktubng2UEVGR3NoRllGRUFERmJi?=
 =?utf-8?B?Wk9ISGhVbkVHcjZyK1dTQWMrUG4vSUFpNndsVHMrcHAzMHZVRWZGL3p0MlhV?=
 =?utf-8?B?MVJVWElsalo4T2dEUFFYZmNXdkdlTmNDS1Q0OW1Wbi9oZXgrOThiMk1Xb1JJ?=
 =?utf-8?B?UXRaZHJ2MHBsTjRGTnpTNzFGK0xzNGZBdDRkM3ZBVU03YUVYZFZiVnZwU05N?=
 =?utf-8?B?cUFWeEVMZWYxTklWK1pKRytnUnNhMFpQdEZNZm9oQXZvZmhJRk81ellTWk5h?=
 =?utf-8?B?amM2b003U0tDdmxTRkNxWHVBRVNobklnZ1E2VFBUSWhYOHpJcTZOa29uaENx?=
 =?utf-8?B?Q0xJa1d3aXYreDgyWnZJMWpuMitIektYeUVtWVEydnBoc1JhdGJtRGhkWCtQ?=
 =?utf-8?Q?n9JO37?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmR1d01EN2RSVjF1K3dJb29IT3lCT0NUMU5BOFljeGI4R3hUZ2kvbFN5ZmVD?=
 =?utf-8?B?UXpGRWFjMGppNWVxSm1RM2JLSXVJT280am9wUjJNSHprN0xSbDRJN1hUM3BE?=
 =?utf-8?B?TDVibDNIN295TUg0MFY1T3ZKcVlJL1JlRjhXenlJa0tnejlzMFM5MmYxQ1ha?=
 =?utf-8?B?SWlGQ1YwTGx2Mk16SXBxTDZxay93WG1LNXVSTHFUNXZQZC85MjdhMVdZZGhV?=
 =?utf-8?B?dURYUHJIUTJtSEJXR05VaGtDSEp0ZUl5YS83K3hNbzA0dlpYYUJndmlCNmpn?=
 =?utf-8?B?N1RFYlk5Z29Ka3VXVGR1Y1g3TDVBTzEwbjN6KzQ0YlByRFNoYTA0c2ZKOTYr?=
 =?utf-8?B?aGJsaDF5Qk5yWjlURDgxMWl0ZXRTaDlqTlNMbXo5bzZNL3F3bVhjcm9TOGtj?=
 =?utf-8?B?c2l2ZVNHTUQ5ODV6eUx6M3pzVEtZWDNxVURDUDRpYU1zeUFCR2JtZVM0Tklm?=
 =?utf-8?B?WjRtb0E2K1FxTlg1T1A0OUdlWFFkM0tOVVhPWVdyUTQ1RXgvanUwRmVPQkdL?=
 =?utf-8?B?V3dmbGpTb05wL1hVVjl6MnBrZzZ3RUxoSXo2ZUJwaWt0OTVxQTIybVp0Z2ZQ?=
 =?utf-8?B?YTVndlZRUzErVTFUM0NNY0tIKy9WVUNxUVlGbTkrV0RSVnRmSndmZnJYbStG?=
 =?utf-8?B?VENWSUVtbUw0QTVNOEtIdmEwelB4TERSakdaS2owT3BEM1V6U3BSOGcxd0Rv?=
 =?utf-8?B?K09lRzh1SzlFZ00xeTRhWDJKcHBMVU1ic1NMdC9yUmVRbFQvVjZhSWFyT2Nk?=
 =?utf-8?B?TFZ4VVQ2RzhIdDlEQlZweG1BUFVRcENWYkZ3T20zalI2eU5tY255aDkyb2pp?=
 =?utf-8?B?WjdVdlhsd1RqUTBQU2R2VHNpN3BrOG01ZTR0enpjeCt4dkVHMHZibU9qdjBn?=
 =?utf-8?B?ZGE0ZGpLY3NYNjNSNGNiajFKUHlMQmdSbngwOVpLQk5tckg4R1JDV1llYjVS?=
 =?utf-8?B?UHhkbElYU0U1S21lczRQOVhSbVVxdG8ramE3RnBjM2pBckd5RG1QdnUrRUl6?=
 =?utf-8?B?Z2xYY0ZJNTlzNktGUDhjWDcyMzRYUlFHZ1dZS0c3UUx5aGhMUlByWmVUdEZr?=
 =?utf-8?B?ZHRJa08yTnZxc0xhYnZxV2F6cXQvNm1ZdUNoL0RYNFpjVk5jQ1ZZRDhha1lW?=
 =?utf-8?B?eW5NVDUxTjg0eXo0eWFHVGxhZG9OTnBSaTJYc1pNQTUxcXpKMk5sYTNTNmdD?=
 =?utf-8?B?OS9MUVM3UHZReFloc3gxMzlMYmJjbUhBV0krVGEyUkxORVhtWnREMFBPcFNk?=
 =?utf-8?B?cDJJMHU1QXlaRHRNK2t3SWNCU0g5QzIrd0Z0Z2lMT2tlbnNQT2N4RCtwaEFr?=
 =?utf-8?B?T0RtZnBRazIvSmRHcGp5eWpUV2FBR08wS1ZGSmFrR2xlWlFHdTFrQTZhN2pD?=
 =?utf-8?B?K3pSWTRuQmpJRi96SUZJYU4yeW9OTUMxVldhazBaS1RSb3VVUkZnSjVhVWtE?=
 =?utf-8?B?VnBUZ3lmSmZSc2t2UFd1dGQ0TjZ4TUFaUXhVcWU4SkUwaG90Y0ptazRaWXZY?=
 =?utf-8?B?VzZzdUJHcWd0b0xDSXVmVFA3UzhNU3BlSDVnRzF1TkpqM0RjVkg5WGoyUEZS?=
 =?utf-8?B?c0xWdys0OU9NaVVjNTllOFNxU1BhM0hNOGR6WnRNZDZPeEVrODJZamFJKzV4?=
 =?utf-8?B?NGhPek1oNUVGbDF3K2c1VDV0NloxS3M3TTNmcHl3R2JJYUJ6eTNUS2d6Q1pz?=
 =?utf-8?B?aFp6WEMwM0JlTTJEa1pocDc1dWgrWlFZOUdzMzk1RXdvRHhTWE1EUE1sTmt6?=
 =?utf-8?B?SGpsWFV4TzE5MitPK1hFMCsycS9BMUVXaCt4S0txWWlTWXQraGlmMkpWK2w2?=
 =?utf-8?B?TnArbi92bGNYWjFiZ2RESFhXUXUwellBZnBXRzZ4dmtYUy9acjZ6VFlpK05Z?=
 =?utf-8?B?S2RmUTRVMFZvMUpjODRXMmtGZkNwSTRRZHdHUUsrS21xWEJiWFBkUDRXWW9D?=
 =?utf-8?B?U1BwQjBEVlJmUGkzQ2pPZ2NFVUxTWi80OHhrMTFVVis3bnFodmh6dFg2b2hy?=
 =?utf-8?B?R2tRK0VqellVZ0lQQncxQ1BzL3NrWkhkN1JTSk5zNHpMNGdzSVJ4M2dSdXZN?=
 =?utf-8?B?dGN2SytCa3lQRXdnWUhxUmdIcmhvTjNidFdmWEtQVVFhamZmN01GSGJvaFhZ?=
 =?utf-8?B?aCtnc2FyREZHdHhQSGNBcmFSdXh0aE9LTTUyNEV6RGhzMjZGNHYvb2RYMExN?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f497b4-e504-4d45-588e-08de36e488da
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 05:33:51.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oPbJ3Bj5uf1hOr6Sy1vscNX1hLFP4DumIiVMVfLwHDn+oJmXKvd4pO/xHSDpA1ZfvLwYZzWiKieUkg/elqc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7053

This series adds support for the ad9211, a variant of the already
supported devices.

Example usage:

$ cat name 
ad9211
$ cat in_voltage_scale_available 
0.957031 0.976562 0.996093 1.015625 1.035156 1.054687 1.074218
1.093750 1.113281 1.132812 1.152343 1.162109 1.171875 1.181640
1.191406 1.201171 1.220703 1.240234 1.259765 1.279296 1.298828
1.318359 1.337890 1.357421 1.376953 1.396484 1.416015 1.425781
1.435546 1.445312 1.455078 1.464843

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v4:
- Add commit which sorts include headers
- Drop array_size.h patch
- Link to v3: https://lore.kernel.org/r/20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com

Changes in v3:
- Add Cleanup kernel.h in favor of array_size.h patch
- Drop redundant empty line
- Amend commit messages
- Link to v2: https://lore.kernel.org/r/20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com

Changes in v2:
- Use HZ_PER_MHZ
- Update commit message texts.
- Link to v1: https://lore.kernel.org/r/20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com

---
Tomas Melin (3):
      dt-bindings: adc: ad9467: add support for ad9211
      iio: adc: ad9467: sort header includes
      iio: adc: ad9467: add support for ad9211

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |  2 +
 drivers/iio/adc/ad9467.c                           | 64 ++++++++++++++++++----
 2 files changed, 54 insertions(+), 12 deletions(-)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251203-add-ad9211-897dc9354185

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>


