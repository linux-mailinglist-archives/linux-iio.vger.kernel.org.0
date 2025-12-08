Return-Path: <linux-iio+bounces-26934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E745CAD268
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 13:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47263304DEC9
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFC22E973A;
	Mon,  8 Dec 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="26SHnjTP"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023088.outbound.protection.outlook.com [52.101.72.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8B18A93F;
	Mon,  8 Dec 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197075; cv=fail; b=D+FXt6VW3QbXKtU3KlgsPtbnDBoPJPjHWdXeZ+oHnhNC4FT30EVg5LSvKNR0id5+AaItIQs7C9TEkNLYIzctzL0HsklXI/npwZqs3DAicDj2Crei64slJE5VzZ4PGUcdSj0qVT3I/l18lFV28EOfNBHkmyvuYmZMM3BV6oZI0nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197075; c=relaxed/simple;
	bh=aSOPgU6+eJOUXRGaoyIxjzqswP1EshqFyTnU8Z/pi64=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=hePMZ/3qt9ltndDZHOp1fK/a4INm2AvM7z7kDNqynAqkYgty07MBUlCISiAa3rSkcPT77RaPmpJu/s4iLsy2dF0vNEtgMhzR3t0+rCHETJO8DlgK4CJLVMEcOu61SXjtBxBcAHnWrh5VAxr79tNc8ymgpsB2vkfnNF9ROXh8VKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=26SHnjTP; arc=fail smtp.client-ip=52.101.72.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrHYQ7CFotiTj9jDnVdBzAzXCd3+ta9dNDuB5UBcvyAZXMXWcSdnW8FgBgv+HRK5obuk3LLEcPeMd5iHno1t0Lpux9rO1Mtv6o2FCGQiquqDWMdUZEV97g/86NN2UkWLW3xfl8SgNTwSOZacFwd8XP89EzA3rHBS5Lt8ZNK327lcAQbRAGzS7DQG+yHXU7mNiRl6OjIl7Cmg9EiUrOFWuS3of6Bp5NQB/17ol7MaeYtw9+j8hyJ8ElXP0K6N9+G0lLe+uwowKGvgQgNV4/xY5zmBz48oIBS99DTx5cLsiBMf9CyByvBFaPDSjaT3BPcpR04x1afiFwZsKr4bDvbT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJiUS24zZbO91cH2XA62LzjgD+8xgGFu8tZKPguEiow=;
 b=dZfJEcymlr7Zjq7VbBlvVu7sUgYBCe0CdqALk9YNkij8P0YIFDUkMZMvDBYTpySvnrFYQOIAfdW5s5sjAM+SICwCXWLuwBmn764nn0hg3ayq56JJIqxq4QrCw2CORd4ssofj7Y9RH/TdDZER/VblzaM1NzlgSEUiwtRwQ1/ipQtGbhkLUnMqomx12ZDxoGTtRayzTJ5PG8HOrouCFp9XLQZRPOKvV7OB2ypf1haGdFVC+qpA7qdafRFYyjmpp/ZMy4MlD2pXvarUih70jFlEJl2rZES/EgBodEvBROuU43LgC95hwYABsbcCtXOHsnSiGRgbfaeuYPesGi4ekrD+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJiUS24zZbO91cH2XA62LzjgD+8xgGFu8tZKPguEiow=;
 b=26SHnjTPf5At0adIRbG1aEdB1nyPt0ZjBBr18CJBsuvd6RJd6PUdvAgO7GBdfA3NDU7xB0e07YJdGJ8WZQ0HLy8BBWQfkT9Ijfi9r48xJpajkr2q72wJI/sPcYyMypEZ8bNVn/sCtSZsxaR8F7b/0sh+TzFNRsYz6ZuM/4M+08NzWBt3lYTC+JVUUeCV1XlzX3/oQHapk00L4g+Nwm/YBtv3/kYVIpvlrOZVs4z7zuP1Ky4nBGkWDKZJgc1VH0qV6egMTq56f1NM1ZT3UoDTbhPaEsr43N/Nm0GCmW8SLUtCZsnBZKSN2lQYfYEpHwX7LtyI9mipzq7EGb/cSWprVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV4PR06MB10452.eurprd06.prod.outlook.com (2603:10a6:150:2e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 12:31:08 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 12:31:08 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v3 0/3] iio: adc: ad9467: add support for ad9211
Date: Mon, 08 Dec 2025 12:30:56 +0000
Message-Id: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAADFNmkC/22MQQrCMBBFr1JmbSSTNE3jynuIi9BM7YC2kkhQS
 u9u2pUFF3/xPrw3Q6LIlOBUzRApc+JpLKAPFXSDH28kOBQGJZVBJbXwIZQ5hShaZ0PntKmxNVC
 EZ6Se31vsci08cHpN8bO1M67v30xGIQVaSc5SE3rEc/ac/N0fu+kBayirX7neyarIHk2DvbOWy
 OzlZVm+Ber0fOMAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765197067; l=1537;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=aSOPgU6+eJOUXRGaoyIxjzqswP1EshqFyTnU8Z/pi64=;
 b=Ti3XaInRvbqnA+NZycHymrL4OCXYQCjQWGIGGpGZMi+5bRB8cC0CT1bVz9EC5brZ/8GzwBxwI
 zMr49449t0RBOAyL6OJOP3FeGxr87xClsUnagm9YeL7OFkc7+O5KqPB
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF0004F092.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::62d) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV4PR06MB10452:EE_
X-MS-Office365-Filtering-Correlation-Id: bf42c1b8-b162-4f12-67b1-08de3655a9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFJRL1Q0QnVIazdsT0ZTYmpsL1JMSXdneFd3cVBYVnN0UDBCM1FTRW14a0FW?=
 =?utf-8?B?WUJyTmFsSE8vWHRSU2FmQmJCR09UT0ZodGxSelRUTWo5aTduQkF0YjFHaW9K?=
 =?utf-8?B?NHl1TTZrSkdXSmVwdmhKZDdmTXRlSEJIY0VWYmlJYUlFSkJDYURQK3NIU0Jn?=
 =?utf-8?B?OFdSUHZPZWN4MHdRNXFhREVhVXFwZlBKbGp2cDhRdnZWSHRMZHUvS3RrbDh3?=
 =?utf-8?B?NXRDcUVDSXQwdVRFTnhBd2RmYnp2T3EyalZpdlI2Z2tKRnJsSUVBeXFNeVNU?=
 =?utf-8?B?YlB1djlsT0ttbFhDakRBMDdqOFZxWDZoYzl2cWVDeFJPZFJadTVoR3NDTTZk?=
 =?utf-8?B?Z1VrWU1YZHlDd0JCalhFbGVLNEF5ZmhWMTVjaW15aVVpTXRUR0ZrNXoxM1JJ?=
 =?utf-8?B?azJwcm9UUlJhb1plQTgrbG13NE1BSXN5OVRjc0Jta1V0UG5pOFh1Y29wUlhq?=
 =?utf-8?B?akh5YkQzRFNMQ09LS0JuN1V5RnRYM1dTbGhWN09EcytLdjczWm9oVlBEQmNE?=
 =?utf-8?B?VHJZVnd4Z2p1SnF5blAzTWg2VDdQUDNVRE1nVzlibFF1S04zV2VUKzhhdjNN?=
 =?utf-8?B?RWRHVzU5aW9OV3JTbUQ0MVlZamJWd3laOW5yU3FHOFMvTmZ2RWJaYXJUQTVs?=
 =?utf-8?B?R0JZSzZObDRqWDU1QzJHOFhlOUEzbHRRNTRJWUJ2Uk9WRXl5SVA2UTU2bW1u?=
 =?utf-8?B?em4rc1dpaTlKOUdmVmhCenp4T096cVhpUnoreUhBa0tuajg3QWxNMFU4M21y?=
 =?utf-8?B?MXlia1BTRW8zYjhQa003eGRvOGxuYzM5Ly9SMjRvQ2x6QlZ6UlRtR2Y2MlFk?=
 =?utf-8?B?cmUzQzZZeEliUnNmOVhRWDF1YUZ3Q0diNEVUd1hLbTJOdEw1VDNjQnlnWnJ4?=
 =?utf-8?B?SEQ5SSt3b21PMzgvdXlVNzkyV0JtOFVZYldTMGpwM3pCQ2NjWHprNklybkN3?=
 =?utf-8?B?cXNvMitoRjZ2R1BscitzM0RzMFE1SVBNVWF4dFVpMWlIYTJ1eXhJeVQ5dXVy?=
 =?utf-8?B?Y3ltRWZsL3N0WUowbU9YNHQ2MVN1a01XdXE0M04vL0U0NXJvWmdTdDlzelhL?=
 =?utf-8?B?bmtuSkM5c0V4NHdJVGtIZEFHM0ZFMWovek81bWRHNE5JVUJLQjZHZHF6WkhF?=
 =?utf-8?B?ZklhYVd2NXJFeEdOMUlDUktDOEZVb0ZaZFpkY1k0YUlBL09HandWMTZseXlz?=
 =?utf-8?B?d1Y4bVVlYVZSWVV5Y1k2ZExRajUxcGZGSWVNay9LMytpVGRlaHkxVzhBT2lG?=
 =?utf-8?B?Qzd0QWI3S2tnNTI2WmtWRUx3dGptZ1B5YlJkaG1KNjhmdHZqc25TMlZ0M2xX?=
 =?utf-8?B?V3pQU0lnTDNLaDhMQzlySHJ0aXZ0a2dGYU9DVnU2TXYwRnpMVUM1N21ONVlt?=
 =?utf-8?B?ZnZjTkNsVDZiQXEvaTc1YmpBOGVzVy9DK0Jyb3NwNWNpTDk3TmpZZ2FtNUU5?=
 =?utf-8?B?SzBGS243RWdGbitOTk1peW5mYzBZZFM1ZmtLdlFFZEphK2twSTdoRFplZ3VU?=
 =?utf-8?B?QWRoREZUOWp6cC9veXI5VXBSSnVwa2ltOVBJblVvQWI4Nk41OThWMSt4YmZV?=
 =?utf-8?B?RjZYTzlFNENLVG4yZFVTMUZlOHduYnRaOVFkc3d6UFdvMzRRRWRQZ2JHWWtS?=
 =?utf-8?B?TTBJYnNvVndmakpBcnBrK05uaG03UDhpWUhreTMzMFJCaStneHRGZWhFVnBt?=
 =?utf-8?B?K3dzVU1rRUdZU0tWbEcvUUkzTXF4R05TN011MnNTQlZVeStKcTJVK3FoQk9z?=
 =?utf-8?B?K3VKUG53Qk5kaGxHNVpSQkhhRGFrV1paQUZZdFc1cXlqdkVmbys5MXBSdWEz?=
 =?utf-8?B?UlRodXZNa2ZlRTZ0VGNhV3YvdithbXJxZG84L0RjNkptdFpLZFJjNURGM25O?=
 =?utf-8?B?bTJ1Sys0U1h2dmFKeUJha0kzMUc3TWd2WkJicHAxRUNob3REanM0SFJ5Ukhi?=
 =?utf-8?B?Q24xKzlXc0ZweTlTdzJwcE1nQTZUb29uL2JjWXlORlBYMzV3dHRuK2cySUVh?=
 =?utf-8?B?OEd2Y1BGNlRjeUpYdEdoQnJEZFJJQUl0dW9EQ2x5WFc4Vms3WGxTaEZPMysy?=
 =?utf-8?Q?yR0whf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVFaNGVmOW5KUHhEZzhYbG9lVDYzMTcyLzViYm81TXFmUFQvZDl4NllBdkxH?=
 =?utf-8?B?V0NXYjhiOUF6TDkzOHZPR1RubTNVc09LVU9hZDZvSDMzc0FBOWhIUU54U01w?=
 =?utf-8?B?a1ltUFlZeEsyYXhTZUF3ZXFCN1gyUlMvY1hFMHFPcjNCcWgzOHp6MWhsRDVX?=
 =?utf-8?B?RTMzTWwvazBVdis2OThHU2dXNUo5OWFUM3QwVjdMSTJJV3hzQlRxc2w2TFJO?=
 =?utf-8?B?TTN0YUZQUmhZQ3ZMcVV0Nm9NOEdiR3JtVWM5cTJlQmcxZWVqNEk5dXNxSGt1?=
 =?utf-8?B?OTBuNDlCTDVlbVBOekJtdGpNeWMyVU9Gb3Z2aUdPTGorS0hPaTJGNzg4dzRo?=
 =?utf-8?B?cVN3VUdLOUwyMTZDT1lvY09EOFBlcGJMRk1CT1JDcmI5WHo3ZXg1VnB0bUIy?=
 =?utf-8?B?bXNrNWk2cm5yV1RGS0JPcjV5bFc0N09XemF5NTZOYityTm1zTU5RVnJ5ckM1?=
 =?utf-8?B?RGhRL3p3UHJlYzBLN0puRThtSG5xQzZQWFJlUGRJOGd1SWRpbkwzSnNtWEdT?=
 =?utf-8?B?bFdnc3FGemgzdU11ZVdWWGltL1dESk5DQW1LcDVSL0RUaCsvSDhNMzRBMm1I?=
 =?utf-8?B?Zk5HV3hWWXUra2dNcGVKczEwYVYrUjJqNE5udlJNVW4rQkhwVllLNnptUkh3?=
 =?utf-8?B?cVE2bzIwWWhxRHRqNTA4SXZ4Vk1mMWsreVFGRVk5SnprZjRwMzFXb0pVSzRN?=
 =?utf-8?B?ZnM3NlZFYVo4Z3dlZ2t6ZkJBMDdYUFMvb0dRcXA1QXlBQnFEUEJMTTUzVW1S?=
 =?utf-8?B?L3pRYnBkQXVuOElzZzlSU2xtMy9HSnlnSWhuenE5dlBIOEJHMkYycy9oRXNU?=
 =?utf-8?B?VVZBQUJ6bi9US0J3Um9BeWRXVUJPd1RqSW80cUhJRkQvbm03NzZrWXdNdEJR?=
 =?utf-8?B?a2ErSUdJK2pNZElzVTlvbjltS1UrcFlQL25xbVJ4OG1rQUlsQWlCdDJBbXNt?=
 =?utf-8?B?ZVYxNC9JY0V6MU4vd0xHaEdYSUFwM2g4UkVRU3phK0tFZW9ZVzljbmE0KzZ2?=
 =?utf-8?B?TnY2VU5hUFZUb1M5S0dnY3JlVUYvakJWOGhyU1VZMklER0dKMXI3YlBtcGRr?=
 =?utf-8?B?bVNQZnlyaURMVXpBSU80Z0hMZjV3NjNsbzI0VVdPblVDRGx2Z0lDTTdmRWJj?=
 =?utf-8?B?aEl1OS9oRWNsZ2RYU3RUNTk1Vm4yZUFHT1Z3bFpPZk9mOXFnaytvQnk1cFVw?=
 =?utf-8?B?U2szRTBpd20waW5EMXJ5U2JrU3lEWCtHclR6aFN4V0RNRjdvOFlubHhSWVNB?=
 =?utf-8?B?WjQrOXVUbWdMVXJBcytqNHEraDhzdEs4cTZEQlBkY1pOODJHU1VGMkYvL252?=
 =?utf-8?B?a2dwVjFZUkRyMzZNUVZTV0sycEhkVHJoYVZHMm9sM3F4Q01Dc1hoN25YdEMw?=
 =?utf-8?B?ZlhJOGRWeHNFcGwwd2t6RGF3ckZidGVLQ01idXR3Z1Q2ZDYrVnlpUGl3Ym1K?=
 =?utf-8?B?OWp6eUZhOVoyTTdlU3hURE5EdHpncDFDM0VGbjY5TDBINElvUWtyZjlNSloz?=
 =?utf-8?B?TlIwbTZDZUYweFF3LzhiYWZoWkpZWm5xTGVvTDl4d09jTXptcjNOZHVGcm1h?=
 =?utf-8?B?d1pSUDJ6SkQ4d0k3ZlV4ZGNCRmNJZGRyNHRwblBqUWczemxGZk1sRXN3bzdC?=
 =?utf-8?B?dytmcTdLTzNWemdPU3Bzb3Y3MlBwbjJocFNNaytTM2JJdVJRdG5WZUZzVlFF?=
 =?utf-8?B?RWxBc2E0S3VwNmVSeDJNT29TSGRCMkYwMXp3OWJmcmdDN2pGNjRROHJhRk5h?=
 =?utf-8?B?TEJoV29WMXRMUGY4NmpKSHI3ME0zZkEwdXY3L2VmQlcxYU9UelBYcytnRjBZ?=
 =?utf-8?B?UXJTT1BrZUVXcGVYK0hrenBXZTMzR1FQOHp0OGxhekMycTRORVByRzJwSFpS?=
 =?utf-8?B?ZW41ZE1QcXZhYWt0aTE4a1FQRXNUdERUMks3aUpSRCtvNHROS3NBWFhJaXRX?=
 =?utf-8?B?RWREL0xzanRicUhIL0h2cTVsakF2dlBuVEx2TjcyVWJnLzB5cldzWHcvbzRw?=
 =?utf-8?B?WVJuMUQ1alNGRzJpbTRyYXA0UHBhbkdBZ0IyL2RNZ0tMYU82VWtCS1o4ZHcy?=
 =?utf-8?B?VmxEb3NyL3FlcllQbjB3cm5LKzhqR2xvbEpKa1J6bjh0aG5kcXplVjluaVJ2?=
 =?utf-8?B?TWxVOUZUOG1oWDcwNm9samFPbnI0dFlqZHV0Qzk3VTVHNkNTaDN6QStWR0pU?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf42c1b8-b162-4f12-67b1-08de3655a9b0
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 12:31:08.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DMgD10SXfhf5wT9/SWRf4tbzf6Nk7SCeZ1+0mbz4BpuRR9eJg7cfjCifv/1a5jPxTa3uUOotgvAbHpb3GdTEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR06MB10452

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
      iio: adc: ad9467: add support for ad9211
      iio: adc: ad9467: drop kernel.h in favor of array_size.h

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |  2 +
 drivers/iio/adc/ad9467.c                           | 46 +++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251203-add-ad9211-897dc9354185

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>


