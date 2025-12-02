Return-Path: <linux-iio+bounces-26620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01C6C9B854
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 13:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81E43A76BA
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9146430FC39;
	Tue,  2 Dec 2025 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="u3TYyyGB"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021099.outbound.protection.outlook.com [52.101.65.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B527E7EC;
	Tue,  2 Dec 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680012; cv=fail; b=ExldcOgwDkwteomfabAJGVmY6EoHm9vWMWnMzSx7jQHOKkEkWMH04Rnb/X5ApbINwDI8bOUOZDvVOaZwfqJxKbceLp3LuaE1/5lnceGKOzPMxfpf781O37p9z7KycHxoTGUDmqkYZJpMzHkhCb4FYYOuqc5uSXJM1r1eSFL+DrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680012; c=relaxed/simple;
	bh=3A5fLDkJADFUxeOllggaO4hPQboxTgptNgbWyyQPqTM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mIfZzU6sai50F+0h+mNmyqJLR0GVboVTEk1fD7KUaV/LyCDElg3XNjd81omSTSOc/M3JhP7xpfIRk+vUqm92LNdTRNO9baOQFLgH/AgkHKWh2ChPc1JpNfi1Ik0u209HmiMrzTBgeh3MXvsYEUjwcSez929AaY5EG1g6fjPQ9tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=u3TYyyGB; arc=fail smtp.client-ip=52.101.65.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NM+uxxXX4NDrGv9BP16BuUd9wA7fpyzAFcK8YwzQmKam+FsMkrDBUfnLxu0Msb81521pFK4JCbS9D7fm8d87vSWBrHdqRf4O7AbQnBUliC2E68ypX+VSmA4mohGhCmbCKMg5R7Qg2hMxVQ+2MbjsG/BuKX7geUxRfkqqjEgMHSwkrH+rOCVPJOty0iRTnfD8CcP8X+21vw8g7Q97uSfBYjpJTHtu7iuWkM3IvTD/NJg0dISZUsGNx+xU7sRFR878+qOZeIJKdFl7hAfEfQXpyaiG5eiPUAsWiOIo9LjKZpWGBcL7FNLB8/LgFYWJMk8QyFh7r8tTljiqllWF+yHwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDwj9dxrIa0V2IEtj5gG5UKRuNGXDgQd0/Hvu9SDYaM=;
 b=HolO/BR1MOK2+hDSd8hEOp4NrymMaOOD90YB30Yt+CEfBVrf94woOeNqAyY9YatJT+bfflclhXUAjBv5Oi10MWiywrt5wm4N2G0t5z/5IYCtNwgpyur7LLDel0UG5SGymO2rxHaajdIh8lk48xKaH7Zgkr5LNWaoIq6i97wjWjvbVtOzDkM22wUR1ptHfbtl8a5EcO525TlbkOiUM/1caT+ACszpK+QeujzlLn2VoN8BJAWGw4WQ2xHE2AmrWPcRS14uxZfX9F3oSOAF4HJCm14BtNiBe1YHD2FwVp4nWthEKQq9oOQYJx20K0EKOyUAHKXunuea3s9Y/Tc8eUC0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDwj9dxrIa0V2IEtj5gG5UKRuNGXDgQd0/Hvu9SDYaM=;
 b=u3TYyyGBR8yxcZLwYpV7d4L/VkDj6qVB1bCUaGQExFs6D19OhEWD//qqxTpLg8wRpUy9A8zK0w2BS3fZnkRp+XZI9Zawd50gpAZBRctwjrRee1Vc+9bc/mxdQMJdP46C13xE5Ms0EwUubNDyJ2q3nKGTNFaoRhnuoZtnkXETNvYd3iupAIqObdH/ndiqOBmgG08XRUDzRSiZkoh34ggnOtMgmkZk4331l1AQhhWyI9asCmdxSx4JrxtVUsd6FYXrUX8UjUwjDmBTVlIcqGLeMQXvpdM80JUKegbIlRwhkeiMtDBcGi9Tfje6CK77FFpTcdtU6bXd0rfq06T6uHvkeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GVXPR06MB9178.eurprd06.prod.outlook.com (2603:10a6:150:1c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 12:53:24 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 12:53:24 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 02 Dec 2025 12:53:08 +0000
Subject: [PATCH v2 1/2] iio: adc: ad9467: fix ad9434 vref mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-ad9434-fixes-v2-1-fa73d4eabbea@vaisala.com>
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
In-Reply-To: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764680002; l=909;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=3A5fLDkJADFUxeOllggaO4hPQboxTgptNgbWyyQPqTM=;
 b=lEBfxxlwj7yQdagt1yXTd7UYo4AjrdncnhIVuwvkHrF2/qFl1swc51y4ISUEIrQ3o2cbYdsWm
 QWv5KkfPXrLCWbU5DzueWBV1Ydk5lJmDdudtPVnf2FoY2z2x0eryUK5
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: HE1PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:7:28::24) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GVXPR06MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: a453d471-6c16-4c55-0a21-08de31a1c778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b21GaUxSWHJsSlR2aWkxTGdlcmJGV0ZNa1pkdXBwUFR4bE5FbGxra0tYNldh?=
 =?utf-8?B?d1hsWERCV2RPSkFSNUVWMU83OThqWXcybmgvVzBaLzNPRnd0aisyN3Nod3o5?=
 =?utf-8?B?MGYraTJJYUVqcUhOWXNpWUdQbkZMYzJ6SW5zSjJ5Lzd3MEJmK1NnOUVGbjgw?=
 =?utf-8?B?YzZTS2FpczdVNTR4U24xcVdBOGJlQzFkNDhYT2JLT01SZlNPTFlZU0VjZjRX?=
 =?utf-8?B?RDdhTVBqSE11T05SeU1hZjRHbXNObWJxZitKc3V2TWNCejl1NFlXelJMOW9G?=
 =?utf-8?B?SzRaRkhqeG5rR2UwalZleFNPWDl2N2hEVENueFlwVktJd1F0U0VQdUVrUWdn?=
 =?utf-8?B?OWpRemZkM3E4NGNsZjFvb2tkM0VzdWRiaGhrNlBoRVgrOWR1ZmE0MU5HcFI2?=
 =?utf-8?B?SFEwWWVJTHJHakhKb3hIYW5BdUl5ZzNoSDVKZUtvRmgraWQ1clBKRnJ5dm85?=
 =?utf-8?B?V1FodzJtVGRyOEUwQkVEbm56WE9FWUQvdGEvR1k3SUwyckxkSTF3dVViOGdY?=
 =?utf-8?B?MFNOQi9QZVZ3SnhTdEkyM3ZvRmVuOStqMnoyWU85eFowRk1FNWlJWDh5Q2dz?=
 =?utf-8?B?L1NnaVV3RU53b1VSdS9pRXJRTVRQNkltb0xZUmcrRDIrTlFCaURtRlFZbll3?=
 =?utf-8?B?Tzl3cW8zMG1qOEdDUkRFbVQ2Vktha29mL2RkcFNCeVFReUozVEZDUUpvTEtZ?=
 =?utf-8?B?NE1pQXBzU1MxTitBQ0FYZnhTNnI2M1FPak1kc3MrR3RSN3JacEFhQ21md3Nt?=
 =?utf-8?B?SStZb0xBSDlyd0VqVXd4L2pWUnMyNDB2QTlzVWZXSWI4Z2R2MFVjQ05RRTdk?=
 =?utf-8?B?dDhJaDMwUlUwbFhac0RBU2JyVDFMR1N5NkdmQldGMlE3U0tGaUlUb0NYbC81?=
 =?utf-8?B?SDhDMUdXK09IaW93QjlycHg2R0NXN29oZktzRSt2SXZHMUp1R2RWYVBRNjQ0?=
 =?utf-8?B?NnA0MHZ6S3RycEtGc3ZJMG9hZ0xTa1E3SG9mcElKSnVTYXNpTE5raVhLa1Q4?=
 =?utf-8?B?aEhlNXp1UDZhRDdoUUJHVkFPNFo3M3ZuaGNUSzhxR0hXOWxxWlZ6UVlUdGFM?=
 =?utf-8?B?L0hpdnI5TVVXTUNPUzB3TkxqcHNGbngyQWNONW1DK3VMN3EwTVNzZStKREpu?=
 =?utf-8?B?bHFSemxnLy9SeTJHSmo3bkMrSmZMN0V6TkovVWY2MzYzdDdXaTQzVm1JRi9S?=
 =?utf-8?B?VTJYMnZCaFdVSDY5RVJYU3dwaTVqZCtXQjhMaE5lNTNxcWpWYkxtaHlBSFFp?=
 =?utf-8?B?Nk0zYkwrVzZLQ0szTkkwNTVyUUFSZUl0ZXJycTREQjkyekRtYmRmNk1pZ29B?=
 =?utf-8?B?enFldEF6TUZmUk4zclZmbFBNWjR3WFp6YWM3b0Y4ZEJjREtqdENnNy9LMFhl?=
 =?utf-8?B?a2tLdjI2aHFLOThzU1lUMEdNeGZsWEhERGdFRUNxK3NnNi9ZOVNIRGI5RnY1?=
 =?utf-8?B?WXp6R0FVR3IraS9pWkNVL3hiaXZUUlBleXpCdHVpVXlLWE1ZT3d1ZlRDQjdI?=
 =?utf-8?B?TXlTQ3Q5bGIreGRXMk5PRGl2VU5Fa3drM1RabU9RUE02bUR6REJLQVlkY1FF?=
 =?utf-8?B?YWN4SGpVVGU4bmJUT3h1cmJ3M0ZyKytRSzYvSXhJNWtMVXRSSHpoOVNvVzJr?=
 =?utf-8?B?M2V6UHI0R3FHOUFKVHI2QUk3OGYrM1F4cGVEaWxHdFpKVmtrc3pmRVp4b2Vq?=
 =?utf-8?B?c003d1gweFljNTYxUVc1ZFcwbG9TZVdZajB0cmpQbHhMYkMrV3RtMEQ3WTVX?=
 =?utf-8?B?VzJOdTdLNWFKdGtFZWpqcVBvRVd4U2x6Y3lraEtXTExRZ2RocWJDN3AwbFlI?=
 =?utf-8?B?UVJRWUZkQ1BCYUJObUoycXdIeC85Y21wNzk5RWMyVGpTTnZDalptWm15Y3VR?=
 =?utf-8?B?V3Ara3A1MTdEVktjVTd6N00wN2puenNtT0Z3WHFKVk5uZldSVEtKRDFCbjVa?=
 =?utf-8?B?M3ZNMWp5RGZyclBmUlRXajZrZGdmMStvaWduTFBqOU53QmdNUjZjWnY2TjI1?=
 =?utf-8?B?UVVKam8vN1pKTUFkejVGa05IK0JQMndtcjIzZFBESGFEMDRnLzU1bDhLbmQ2?=
 =?utf-8?Q?Bf/aKE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnFpY1c0UmMzS2d5VGdCa0pkcDcxd09McG84Umk2RWJHSGxDTGh1ODhIRVRw?=
 =?utf-8?B?Um1qQnZ3R1YxVXNHMXBYZ21GOVJsYWR6dCs1SHRvbFFkTmw4UVpSWU56bzh0?=
 =?utf-8?B?VTh5YlRocWtIQitjQ0xEVWR1TlhQWmRkblZYWWNPK2Y3ZlhSMzZ3WXlnRTl6?=
 =?utf-8?B?TllNL0d6VzQ5RGlmNUdyRWxEK1hKT2xnc0JYSVNsQk0rWlNMYndyN2cwUjY5?=
 =?utf-8?B?M2NSMmE4NkZlWjBBaEUrTnZkSDNqYmlwZVdBQ2hxWjdnVnV5ZzhzZDhBTVdy?=
 =?utf-8?B?MEVVdjZLcGF1dDN1MlVPVWh3aXkzcjRwcEdxQ1BhQWxuWHlxd2phcnh4RjdO?=
 =?utf-8?B?RXFnUUt5Y0htTDhMUEpZVkxiVWp2NG44SWp1SnRLcHhzWlZ3U05vMEU2ZjVX?=
 =?utf-8?B?NWlDMm9QamRlTjBkbmZmM0hzVDdscWV2SFZxNzIzaHVTZVpTOEpxR1h0R2pn?=
 =?utf-8?B?QkpWVGNOd3hxamo3RmEwbm16Z09LRWZrdDBXSGM3QmxUUE9oR1pHV2U4TDg5?=
 =?utf-8?B?dnQ1STdlZ04wbGFFOTNnZjBlc0RTWDUrVHpsYm1MbE9ET2QvYVp4Wi9xMTY3?=
 =?utf-8?B?b1c1aWNyemd5SlJMQWJwM0VEZnk3czAwcGFSU21LQlJwS1c1cW5vcFhFTHVC?=
 =?utf-8?B?YkxkcFlNc0VPeTBZRUltSHkxSmZTNTlVYmdkbFI4WnM5S1k4VlFhcm9tY212?=
 =?utf-8?B?bDMxanZ4dkk2Y2EzbWNlZGZNMlo3WHVvb3pkNXZyTHdTYS8vSzBWMytBUWpJ?=
 =?utf-8?B?d2EvQk5TVTVJd2FhaDk5OVJibzRaVnBQZW53MVdWc2Q3SFpvMXpWM1g1Tld2?=
 =?utf-8?B?eTJ3bUpPWFpILytZL2pmTjhHSkpPMTlIbUFwVE9wSDRjVjZYaFZXUTJKajZq?=
 =?utf-8?B?VTRTdmpIVVZGVHBGQmxIWXM4WklVZEp2bWlwbS9kUWxlbXNWM2tIQWRNcW1r?=
 =?utf-8?B?alRsc0Q1TURrTHdncXJrSnBNMk1VM3ByTjVZYUNmUG9pcEdieStYS2sxenli?=
 =?utf-8?B?dS9wWGZObDRWalEzbkhIMUxIclU5bStRYUhnSlRFZ284Z3RGbkpCYXB5dHp0?=
 =?utf-8?B?T2o5TWpENENhZWNseXlVY01jTnh0eGRPczlPbjdrMnFYcFF3ZlM4VFdwTXZk?=
 =?utf-8?B?RllPdVROMWRXWCs1ZHUyMVVCbUxHSEdINnh5THN5WnNIc3NqVExTTTFFbmJG?=
 =?utf-8?B?ZDNTWng0R0EzR1h2NThUeUYweTNaR1VyMEcrOFdaM0hCV1dtTFFyWm0waEFv?=
 =?utf-8?B?YktzeHptd0hZUEdOMmRYRnlrN2ozdTVkYmxqZUMzQlBVdllXd0NjS21BeHd6?=
 =?utf-8?B?Z2VhQStzTE9KcEVGaU9yY3Q3MnowWC9JbDc3YWJxMjA2RldtN29CUnNYTUIy?=
 =?utf-8?B?K1ZEYTNQNlBYYnRXZndLOHBobkZNT0NuUmFPaDczRFVFb1NNRkl4T2xBa0NJ?=
 =?utf-8?B?cmd0c29QbS9hQzRyY0hWSU5FUG9GSUNPV3RBR0FGVlp1Q1hJM2hTQjZmbUpT?=
 =?utf-8?B?K09GaHJPVER6N3cvVWdQTkQxcjV3QkVNS1BaTDg3cyt3eUdobEhGQU9BOC8y?=
 =?utf-8?B?OXlmWWU0bzVmdVlMSTF5ZEJnSmN1WjkrS3ZtWStKeVYya3hwQ0RTTEtabklp?=
 =?utf-8?B?UmpRR0dRNlFFaFpvQ3ZrdVFhNm1qN25XMkNYNUxjZVNFZVhJeHNTYSs2VVY4?=
 =?utf-8?B?ejRHYUMzSkxnOHJlMzB3TGk4aFRsRmI5VjlFSnVJbVdEUXE5dDY4OEN6T2kw?=
 =?utf-8?B?SDltR21VOEFjZW1HUkpLRWs4OTkxcmJtVkIycUdRR3ptb2IzQlQ0bXhvbDl4?=
 =?utf-8?B?SDRuajAwa2M4bWJmQTVtUkVSRU1JcXFnRFFkOHFjdElmN1pBVEV6Vi9hOVdO?=
 =?utf-8?B?UUEwUUFUWi9PUjZlc3ZvbmN4cDlDS25URXdMckEwOXhtRkRZdzlMVVcyQ21W?=
 =?utf-8?B?djA4d1ZzYVV2Nk02Q2RhcHhoYng1eTZXNndSK3NqTlUyYUU3Z0s2TTVVbWsw?=
 =?utf-8?B?dFplNkVuUnhnL0d1bkcxcTlhZWRtQ1F4MFc3QmJnenhoZXNTeExJc3pkUDk4?=
 =?utf-8?B?d2NPT2dNWjZDZFFMT29KRW82TEdnNW5DcFBScklVTFpKenJVZ3RUbnM2ekpQ?=
 =?utf-8?B?cUJsMFZRVE91aGg1TW9tM09nSXRmSXl1RGV3MGVQbkxzaTg5K21xWGNPYTVX?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a453d471-6c16-4c55-0a21-08de31a1c778
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 12:53:23.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ca++uM6pKeX1wkEWY8d7l7IwQ6HblhxXBe69wl0ZPHZG08ANQkEND7g7rUPOkECnsSITK//d7jxlXlVMhYNZuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9178

The mask setting is 5 bits wide for the ad9434
(ref. data sheet register 0x18 FLEX_VREF). Apparently the settings
from ad9265 were copied by mistake when support for the device was added
to the driver.

Fixes: 4606d0f4b05f ("iio: adc: ad9467: add support for AD9434 high-speed ADC")
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f7a9f46ea0dc405e25f312197df4b2131871b4bc..2d8f8da3671dac61994a1864a82cdbef7f54c1af 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -95,7 +95,7 @@
 
 #define CHIPID_AD9434			0x6A
 #define AD9434_DEF_OUTPUT_MODE		0x00
-#define AD9434_REG_VREF_MASK		0xC0
+#define AD9434_REG_VREF_MASK		GENMASK(4, 0)
 
 /*
  * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC

-- 
2.47.3


