Return-Path: <linux-iio+bounces-26592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845FC97288
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 13:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EB83A17BC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60F2F6565;
	Mon,  1 Dec 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="P0OjUI1Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020108.outbound.protection.outlook.com [52.101.84.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB22F1FF5;
	Mon,  1 Dec 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764590405; cv=fail; b=kpzgpIdZSKb7oiZUBtuMcdK1Vb+09RbHr2nJRarSuzvbzX2RL5KpbW+vIzfF4WJGIW88yLH4BIiiEEav/Xp9DiHAlkNin/diJXdTLxz/BND/uaIiJxp43JaZuLcWsN6+4lKRiWQ+xok1zrYGId7u4mIqlPv1Sp/z5uzUrPE74MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764590405; c=relaxed/simple;
	bh=q1p1NQBIFJRVz9CormSetWi6qSDHRNhg9dzmK0qWDTU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=oQ/4s0Wx5VfNnoszOBloB/SyY+E5MOl3WgL9r3L6W/5C8gbFsJQxyzpQqQVMQkVg32a/4l9LvjqQhucSQm3FCHmxWTKxyjSwnuV/cOvubmrp0eCHm3E9zpS4FGfe7QzOQH14lap8vwNM9un0l5uMFSYJuUUrKUdF3UZ1+nBjzVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=P0OjUI1Z; arc=fail smtp.client-ip=52.101.84.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRO9BlU9gLSU5zJ3Pg5EEmgOZ3E57A5Kj/eXYX/TyN2p9QqpsZKzIv6d8WVcYqX0zkPs6YJNFoQFzK+suyvBInwN99egtoonRRA2smdiKypMwtd7Zo6uW8lWX8J8ka7b9Bd8PejfAoSX9taWAb/UfTPEHges2frcvTHlndnFLUYlQXUG7Gq3Rglw04B01PfuiYgkieqvtnAAHDY4FWyKlXwSPJtsVe1B9wBwkQa6ePE8nBWJnGZjeSYqHHPJVeJQYU8eyfdT1g37IsNn5B2QKBaEQijIcf17BVRoZ4zQtVcYPF4e+nGTO8oNEY5woJLghHOEdmZdbyEiQh22VT8NoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzDUsSAf66xsU1Yd5fzb5Y7y40YjnUoor2QKnsarTrg=;
 b=N7sLNwO7GqRX1m3i/8XRLR+tFdgiHQawCSD8nb/nnD1++/FIM2IunLmWKl6/wJJ9mjs6qefNM3L1ipJdgO1JhyubpK109ZhTGQpmlT3ges+BRDu7ezmjris0mGwOsi+Ktpjj/+TOL6U7Z8BJqQBBcNNk84/4JJbJMYkmg8XIoaIMzXfSh82KZdt8ZA6iGHG4phB+3hL1GONBgHsY6g9iXWKyDRPjLifWCePl8Vyr1swQ5o+zd1B1sBLXtyEZ5O6XeJsh6Fc6oYVTn21t0YZPidfcgs8wl0Igvhfpcl6UzfBD9liI4AhJOiXS9uSJbsyfaSuaYseLNFo1+WKDm1NHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzDUsSAf66xsU1Yd5fzb5Y7y40YjnUoor2QKnsarTrg=;
 b=P0OjUI1Zf4WrI4faCkRORrkQyasLZkBhETiRFDeE4EHZgt5wVQFTAGdum6BTDJXs6IRlbmPxuqlV3wQ7OsD86mbDXh5S3DlkozvFsx61UED6KdqOfsQUBQU2p1yZvL8mchkXVv+lXz970dxExmBCKUfhOs5r1HSMyJdZiQPu2zpeXCVJTHGh5p9ucjIGm9CDzLV652d3Cwo98d6/Ora5ebjdYgiFkR+3fDz+Ji7buRmvzKeBfQp7LAOLh4C3KFO/wO9ICo57VxF4nufLHRRCYnjRaA+NEP7plvqcY4cOMNKTYFPWuZQdU1JWrllUcDrNltPRtYwlQeoEuuqtkHmDQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GVXPR06MB9203.eurprd06.prod.outlook.com (2603:10a6:150:1c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:59:57 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 11:59:57 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH 0/2] iio: adc: ad9467: fixes for ad9434
Date: Mon, 01 Dec 2025 11:59:33 +0000
Message-Id: <20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWDLWkC/x3LQQqAIBBA0avIrBPUTKyrRAvTsWZjoRCBePek5
 ePzKxTMhAUWViHjQ4Wu1CEHBv506UBOoRuUUJNUQnIXZj1qHunFwk2IwVsTd2sl9OXO+Id+rFt
 rH1B669heAAAA
X-Change-ID: 20251201-ad9434-fixes-6dfdc86fb881
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764590396; l=562;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=q1p1NQBIFJRVz9CormSetWi6qSDHRNhg9dzmK0qWDTU=;
 b=bL6uWtIquRa9c3pnJCBE10t/6rF4F4cFeIiIohbU3YB7h8g76IP1LDggp7v6J7Wesv6KFvLoJ
 usJhhJZdJDrAHwkFrpIA+Y0H3Zt/nFb3YVwFThjTwVNjvid3iTO3JIZ
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: HE1PR0401CA0118.eurprd04.prod.outlook.com
 (2603:10a6:7:54::47) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GVXPR06MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc43c4f-8726-4878-b7c1-08de30d125b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmV0aWpZUXA1aDV1K3U4MDB6RTVHaU1nNzBtdEtOZzdQVTdlYkhtRTU0VUNB?=
 =?utf-8?B?U2Rib25LVTFpRWV0WTV0QUd4MmE0RStrejh4ZzVEdU8zdGpUYXA5ZzBINnBJ?=
 =?utf-8?B?MlBSY0E1SjhqVEVjS1k1ZHZWZUpRVk5HcENDbzRUdkRwS2lEaVROaTkwMFRL?=
 =?utf-8?B?eUE3Nno2YzNWbFNRTGJqRTNzSk5oR1F3andnTGRtSFhOQzY0YXpCc0JIeDh5?=
 =?utf-8?B?VHJKQ0ErNWk2Z2gwVGExS21tRVE1dUkwOER1NExWZWYwWFV1NEtZUHg2ZmFo?=
 =?utf-8?B?TTNCWUVhbkVmVC9iR28reTVCZzRlQmRsc3FSQ3RPKzlETnpSUEFLYU56Rksx?=
 =?utf-8?B?aXJwQnpXVjZSMkh4WFZlWnRYM2QvMmJwZ09JcUZhaVJTWkM0akZ1RjJ1UWRh?=
 =?utf-8?B?aHZVYUZyUDNqdWZ4N25URXVmZ0I2RzlmaVMzc3RyMlBhNFN5WGRKVXE0WmFK?=
 =?utf-8?B?dEJLWkdWTk9uZGM3enVlVU5hYldvWVBEOVVzR01jUFVoQ3MvdDU3aCtLUHhw?=
 =?utf-8?B?TjFHUjVNVVFPRzBWVWh0OSthMFhETnZFMy9PdEhMTE1kS2xNTnZ1ZkJYUXJS?=
 =?utf-8?B?MTJwbkNqMncvREpLRjkwZFU1QWR5aVBaWTkyMVdwZWJnVm5QS2RzVVVpYVEz?=
 =?utf-8?B?L00yZ3hQcFVKd0gyLzVOUmRMUytNSU14aEtiTjJuMERIU1Z6YUxUQ1IyL0dJ?=
 =?utf-8?B?VktraFFFdnZaM0xqcmRNbFhZSDNSV3l4bHJvYUx5TXErSDh3SGpVVzdtWlBC?=
 =?utf-8?B?Y1V3QjdLdXppc2MxVzRVN21yaFVXV0pXMGNyV3FxZVhUWk8zWjVzMjRDTmpo?=
 =?utf-8?B?a3k1eFVkdlpISWtrZmRmK05BelBuV3NoTW1udm9VQk5QelZJOEVCcGpmeWNF?=
 =?utf-8?B?VjVrN1c0UWdreHM5V01ET0owNTJLRkZtUVlpV1hjQ09iQ25pcnM0cVdnc0Yw?=
 =?utf-8?B?ejU1b3Jvd3ZWSGtSWTRvc3ZsNEtUZCtpUlRsL1BNelYxNFR3UWRKN0NpdnE3?=
 =?utf-8?B?OHNhWkNXMEpvSmx5cXY0dTVOWmhRcWxSMSttckhMUmN2MmdUM1BGcDljd1lM?=
 =?utf-8?B?bjBDdlZLZnFwVWs0Zm00a3RwSzIrZDd4OUVzZGRPbklyT0FuM05Nc0YzUGMz?=
 =?utf-8?B?Z3pBMzhqVDI1aGtYNHc1cUFteUN4c2pPV0dWcDBZQWxuSytoQmI1NVNETWh4?=
 =?utf-8?B?R1l1NGwxM1FDNnNCTnZSbXRLRmxuTkVHbmJncG0vNVNERVhTRDE0eEE0bW90?=
 =?utf-8?B?L3R6TCs4TGxMckRhSktkdVNlK2h3Z3V4ZHR0N21yKzlDcGo2VFN0bXVEaXVG?=
 =?utf-8?B?emJ5R1JmVlpadVBCMTZNUkZzaUdXTXJPZHVtb3M5ZjdxdmErUzllVUp4OXZa?=
 =?utf-8?B?U1cwdUUzQ25tckZlWisrajNldVlobXo2WS9HTXgwMTVyUGFueEFiR2ZzK2M0?=
 =?utf-8?B?bmovZUh5aDI0Tmtqa1o4TFdXMHZhV2N6MXpkT0NRbjZ2dTYwQlM5dTVIVGU2?=
 =?utf-8?B?Tnp1eHJ5NS9LWHB3TUpLMjdJc3FPeWN0WUoxMmZuMXRQNVV3MlJkUllwSFZN?=
 =?utf-8?B?WnhMV1VwVkRwSFB4VnUycXo5MXZNb3A0aGMvYml0V0lwL1lrWGJPcXZJVFpU?=
 =?utf-8?B?djM2NytkaldDS1B4NkdtakRhRVpkQjkwdHhMMWRjMlR5SVUzOEtLL0RyRlpC?=
 =?utf-8?B?MWQzdUtoZnpnLzZ0L3c0OGxPbDdJSlFGWEptWE9ZcDc1TkdEQTd4MjVXVWdy?=
 =?utf-8?B?RDZIbWt4c2N2dFVCcVZteWVrektWVW80SFowMjZka01DdjdkYk53K2RiZ1pN?=
 =?utf-8?B?WTJsdFFXd2lmNlVoRW00MnVMUGFRY1FtbTFwUEQ4dFM0NGFybzdSZHRFaXRo?=
 =?utf-8?B?YU14VEJEYUxyNlpPc2VzRENGVVZyZFdienY2NWxHd2hkZU85NGxTMVZ2Sk81?=
 =?utf-8?B?OVg3MnpRVDBQN0owVWtQMk50bERzUGxaM3VLOHZrODltYm5iY0p4dy96V0xv?=
 =?utf-8?B?OHJvQU4rbFRpTzJGeGt6MmpDazhLejJIK3NXNExDeFp6SW8xZy83REthSEFT?=
 =?utf-8?Q?xayeM7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDUzTkFreXYzc1NrNnZCZFc2eHI1R2lyZS95dHRtbUpmb1Z0MXFMa0xmYjJi?=
 =?utf-8?B?dzJQR2ZmZlNTWnhGVHlQbzZ5dHZOV2F5ZkhpaE9YTkVCVllOQ3hTQ1p3Qmo1?=
 =?utf-8?B?dlVXZ0RObTdUbVlCeGk4bFlEY0ZQZUd5Qmg4cE53QVZSZmtFREVKbHFSUk5S?=
 =?utf-8?B?Qy9xVllVU1VQckhWTkxIZGlVVVNTS1hIWllqOVVESTFObTc5VENwajRtWU1V?=
 =?utf-8?B?SnNGRkhlK2hFQ20xSDEyOUpaaUtESjhROHUwbWJub2hJc1hlOFQ5ODJaREh1?=
 =?utf-8?B?TXUxdXg0OXVRVTZCUmNUVTVtckowTklNcXhqN0lhcnJ6YXdWSE9EenZJMmNU?=
 =?utf-8?B?Ylh6Z0FzMjdtMzBVRUtOb1hpZCtKMkh2K0dBSXAvVldZZlRvZi9qODR0TmNk?=
 =?utf-8?B?WEtjNitTdkF4RWgvNGUxTTFJMG5EclBqRUtpYXNhYnpwR2FUODVUaER3MDJv?=
 =?utf-8?B?MjlzUFVvZDBRYkdhYmw5dGFiMkpueEg0RWVOVFE1UXNJWC9JTGZQWlVVZVRo?=
 =?utf-8?B?S2JnVHhCUjQwS0tEUkFObkZkSnIrbkREMDY5V0VjQVlEb29OZW1QbWhmaHl6?=
 =?utf-8?B?UkdSUWZJb1dRbndoMXh2N0M2MVZPMVkyNnEvMnFOa01BYWpGb0duVm8yYUdr?=
 =?utf-8?B?UUwvNEhFZ0VmaERvMWt1UW9uVnRYQkU1MTNtOEJERWxKWjA3ZmMxRFA3RmlX?=
 =?utf-8?B?blQyaEFGUnltWjc1Ny9Gck95NlBvTzBxZy9LNEpOTEIwbmZJVU55NGFIZDJW?=
 =?utf-8?B?Ni94YWdFZEpVYk5HUytCZGpaOFMva3ptb2xFQ09IbnBpdG1kMG1MbmMyNWMw?=
 =?utf-8?B?dysvZDNjdVdGQXhrMjM0Ymdyb0xadHF2RnphK2hFV01mdE9rbHE0M2FDSFZr?=
 =?utf-8?B?ekZGOXVwS1ptS1RXbEx4eEk3OS82UTlaNHJXZVJHTmtQUk05akFjek1BUk5n?=
 =?utf-8?B?NjBQdlN6ZnVjR0F3Vk53S3ZETXNrTDVtVkJrUlBaSE1NSDFqTEZMVkRaM0JJ?=
 =?utf-8?B?aUgzczB6QWJmVHcwejJJSWxGVE5XY0VtTzM5bHNxWU1NdTE0SHhQQnFYc2Fh?=
 =?utf-8?B?dTZxUVd0cmlLZzlvU0hvSTVMbVBMNEk4bVlsQTVIeUlTbGhXcEIyWUFXcnl5?=
 =?utf-8?B?Y0VhNUh3N2dzdW9qaDFHL3RNVWJjdXNzNjlsSWtXWnNpc21vMXF6NDZkcEJ6?=
 =?utf-8?B?Ui9ncFRRcGFoUFBZbVlzODRFTTNQVVJoWnBSaTZGT3Y5a1FRbzlGdW8zNmpy?=
 =?utf-8?B?KzlrUFVneUl1ZWhQdWhPcklEM0dBUS9pMHBoK1B2Z2xrR3JuOHJ1VGJ2cE90?=
 =?utf-8?B?ZEU4ak55ZXlsRUMyVEJJNHRUODBaYVNIaGg3bExzbVRWTCszWFdJSU9nSWJP?=
 =?utf-8?B?RHY2ZXAwT1JFREpoOGdENGFJeHlLN3ZlUWdkcE1FdVRuWXdKUkFWNHVJZmFI?=
 =?utf-8?B?UkJ2VWp1bkNHN284aGFMcjU4MGxQanM3OTRHeDFiYVFLK0JQTm5PL3dSTjl2?=
 =?utf-8?B?aG5jeExibmpvbnRscDQxanlYZFBKWlExYkh3SCtnNm1id1FTZ1BrNUJjRjdy?=
 =?utf-8?B?KzdON0FXbk5xVElQTi9PME9Zdk91Mmo3TitCaXl3NDRoR2J5bkFKdGRqYTNa?=
 =?utf-8?B?S2djNUpReUMxNHhodWRGQktvandKcytnUHNrV2ZEcmUvbWlGeWdqcWNIR1JR?=
 =?utf-8?B?djRIZHM5bG1WNHFYU3pjOEROSFdqcnduc0cvd0J3cjA3Y2FYZDRVWVh4OHY3?=
 =?utf-8?B?bHc3R0RpcTBJNDNMaUZ5QTd0QjhzQmlHUUF6c3dPVktrbEp6RHdmVVBONkpz?=
 =?utf-8?B?K3pGWnJ0Z3hoTytpNTlWOGlxWHc0QVdBenRtWjZZTnZDbklNL1NDUjZwZG04?=
 =?utf-8?B?eWIzaEhIVmRYVTFxUzNrQTZSSnpNN3JMRUZMVWVEZlNqZXBwU2NMSUYwbG1Q?=
 =?utf-8?B?dmNCMklSaDdLWnVGRVoyVU45QmROS3FjNWFYMFNIa0NNc2xDRTNnSEVFa0VY?=
 =?utf-8?B?aktBYTVhaDlid0p1Mnd2cmxqYnpmdDFaR3JIVUJhZmN0b0ZFWlU1a05obzJz?=
 =?utf-8?B?dHpYUEREZFJ5amhTM3U4ZTRlMVpuQWlFeVFCMHpaeDU1NlVmNjl5ZnNQQlRR?=
 =?utf-8?B?UVFrdU9oQVl4dFlFUGw5SkpQTlMrdW1pL2ZvTW1GcWRHYWJuR3cyeUY1VVI4?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc43c4f-8726-4878-b7c1-08de30d125b1
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:59:57.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W37gRHKrnocyjRoAOpxxo4kVL45dkAu5+bC1D2TALd1Wm0/a0S2n5FjOOPUGV2Q5mYoKixxf9y9Yc4hIsXPnmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9203

Add support for setting offset range for the ad9434 and fixup
vref mask handling.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Tomas Melin (2):
      iio: adc: ad9467: fix ad9434 vref mask
      iio: adc: ad9467: support write/read offset

 drivers/iio/adc/ad9467.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)
---
base-commit: 9b9e43704d2b05514aeeaea36311addba2c72408
change-id: 20251201-ad9434-fixes-6dfdc86fb881

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>


