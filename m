Return-Path: <linux-iio+bounces-25633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6100C1CFFA
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 20:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD5F3BE5F8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 19:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398E359700;
	Wed, 29 Oct 2025 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mxtY+0wP"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DB3596E2;
	Wed, 29 Oct 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766064; cv=fail; b=VByCqUfCdTdxihE6HkSiNDgsZq80AToUnabHeuJe8pfhLa+MyLuHDN+x0eN86a/qo1n98C8UVoMUQgcOWlb+2FZqglHuG7fQ6uZXFpg6T6dYXfVoBWnuyO7bltGNkQ1dYUsFkmAuxnggWPFC41ZWxcrqK/009HtgSG74VNEPAis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766064; c=relaxed/simple;
	bh=KK1oNIM/zIMsFVR86H33vkdH9t5hrl9gCA+JeL46gkI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l+uAk2gCJD9XIiUNEFfvfoQf06Ig2UE5vnKiTe8ESVHToue/axVKSSjDx0gZKzASaoGdbH1mH5tktjP5WxCATfzVmf1STa+tDQb+sHvMhpVQo97mb4jB83tk1VmnFl2BTPg1nKWAvzDk3ACDvq7NE61sw5+9Uno809/W73M47jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mxtY+0wP; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvAu6Mme48Oepn0Xh6p8FakEORnJN0Bac7rmhrX72G97w0MmF+1SSwKNqKzRSTapncWPkp7ETjPs8iRuk5kYdmAk4VozyzCTIbP34J9vSY1FTRDA9rhj1TcipWpruGet1pkhQKfo/4xkJ8/ul7OzecJBvM0QrRkec97En5WE/EhJg0GTDId1PjHAaqvO/xJ9KmuQ8d/bfdvU8fVt7xsjWvJg56sy0VSI6R9OGhTELxTvaONGfnNUfA5nEfVfdgUNQfFgAJxY4ptuOrBTOJ+l5OqS73Y2BJW2Tnd7U69BA8hBMjLzaUn8gBgxWAtfsgPsMt9UXXVV3NsK1lLmJHjrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHeBD08XI1zqKE3rCEPD/ErAR4Ou0yuJmryW2r+V/nc=;
 b=LQw563MCqWY08KbY4hyYvm++ljMSTbWb6qUfrTRNAVMqDk+sBDyEB0wr8Pi54lkNMT9K+2OzmBxO5Fd8MvtB+3yZ4JoniSXOU+m8MbBWEKRwpXPSE4v3T7Uym7kEwtPvSpf5/Gq2wG2kfhwRpnwZSScobmvk/ZPcDbkT3BfF8Yufq+9LzGELrqQEH95Gu/ekA0pYB+CEzmER2tLNRoXtPhPIZ8bVggHbggW5DD7EWeKtMLHXuyql5KLGE3PO1bEhFpdI2PyMYlTdom1b7ZTUewuGB8Qz57SvtuZ0Rk7/NKqVsPzMMa6nkRaJVTL3vsDVntOEKCEkwcJt9jY9Oaatcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHeBD08XI1zqKE3rCEPD/ErAR4Ou0yuJmryW2r+V/nc=;
 b=mxtY+0wP2cHucQ9nsKe/0R9ORDPByQprLrvsdDakBO/QPF1iXNjbaQJFuUW0q4ZDUsK2AjRwZRA+an58nzaNQx1k0AdQx5pcN4DP7shldVzYLHVHX4dkjWmArOVfz/LLontcX7Vlh7XUzfMizk4SVlGQtk+CeG0DOsIu4j5USmQL0jJWFK+BzCp7DDNw3OwA0xTdOxej16fujSJ3yYuwpNAEmgddWKOR2ZAq0zw2h0aYYHmJIO4R9ffW7jHsYSvxEKXzs8MvyCxGXEFKVxLCgZSDD/4sAT50i4Yk9nqMghYPD4OXED0YCfypINFY717qZO4OX00XWtgt75ekLIZBCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 19:27:39 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:27:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:27:19 -0400
Subject: [PATCH 2/2] arm64: dts: imx8qxp-mek: Add sensors under i2c1 bus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qxp_sensor-v1-2-e97ee1de96d8@nxp.com>
References: <20251029-qxp_sensor-v1-0-e97ee1de96d8@nxp.com>
In-Reply-To: <20251029-qxp_sensor-v1-0-e97ee1de96d8@nxp.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761766047; l=1466;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KK1oNIM/zIMsFVR86H33vkdH9t5hrl9gCA+JeL46gkI=;
 b=8BL5Tz6yoHVcQbCM1gNALJ2D7M/PFyBu1/cpKs5c9B8deJCV7n8TrvssmqIB8lUfE47n2SNvl
 34OA8BeAuwuAzlNQtF5VU0/vLkJ3cYRmlFUPhgFQ0yGcS4wsVT604et
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P221CA0033.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::25) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: dd38d302-d04f-4a74-b9af-08de17213911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUVXZ1dSVFI5MCtuRFEveGpSTDJFMjRlQmgwUWduN1JjQzYyOVdxZ2Q0NTdJ?=
 =?utf-8?B?WWo1c0drenptRVVsWU9Na0EvZzZWTHA4ZDFwZzBOa1NYK3VzZFNhK2lhTHM5?=
 =?utf-8?B?Y0Qzd0VIOG5IaWJTcy9aclRnOXRuejNEdEtnbEx2WWNxRVJLOHdDRlo1aTlv?=
 =?utf-8?B?NlI1RkNFNnVjUEd0ZGZYaWZZUW94TTBPL21xdkFNMU1IdUZGdVJrT216aEhl?=
 =?utf-8?B?Y0NKY3JZbnVGOWpiL2FSbHppS1R5elA4cHY3TUVVMFNobkY4czUydUNObkxu?=
 =?utf-8?B?SFRlWVVFOWdoaC8wa3JtdTNLNk1pUmx4ODZvUjVpcitWZnRHemhQZTJjQ0J1?=
 =?utf-8?B?cUl5NnZHR0QzZUdxL1JCR2lSTTYrNXc0Z0Q2ZWMzeGN5UE5Iak1jTkw1T3No?=
 =?utf-8?B?dEZHRTJHcFY5TExXR1RmVUl6MjRERUlUbFcvU045cGtESlNRR3lnT05majlH?=
 =?utf-8?B?OHVDdHduaU1vVFlWNGc0THBKUXlqWkFHZzZrY2JOd2NZWTEwNEhxd0hWNER3?=
 =?utf-8?B?eEZuSHNZZUhVQi93ajBtS2FvNW5paUtJd1JiZ0pnYTFWVkJXM0JlR2c0OFJG?=
 =?utf-8?B?VnVIT1Exb3FTb2lOZEltMHpHRUNZdnkvY0lkaWxnYnk2UWVab3ZqeURHVjJz?=
 =?utf-8?B?Y3JNM04xbGljejFtMDVJL0NNUHI2dVJGK2Q0ZFBjMHhIMXhPeW5NSHpEU1dF?=
 =?utf-8?B?aUFWWEdqWnVvcnNZZGlWWHV0RHVWODVsZkhCNHpsODVTR2NXckZlNTJXSWxo?=
 =?utf-8?B?MHVIbG9IR1Joem1Xa3MwY3FTUjJEcU9LUXZaRFRqc2QwOEJCb3JKWFY2UVJh?=
 =?utf-8?B?TXdxNkpYWjRaMndLY3B0YlZZRUlnT3EvN2tsQWpFK3E1ejFaU1RtTkpoNGtt?=
 =?utf-8?B?cHR0Q3hoWmtIOXJyUEkvY2hxSGVDRVZzVWpRUVRONzY1NHZvNlBkbGpKRXgw?=
 =?utf-8?B?eVBJY0s1SFZ1R003MXQzZ1Q5TDJiTTV5b3VkTHhwQVJiaFFxWTR0R3hiZUly?=
 =?utf-8?B?U3pNbVdQWElxU0pYL3JmckRJRzBYR3FHVWhyQldNdWU4b3ZkSCtOdURqbWZ6?=
 =?utf-8?B?eWpYdnZ1NjUyd3pMMjJkQjFaQ3ZKQ2hMZTl1dzJ2MWtLcXIySy80Nlc2a1lT?=
 =?utf-8?B?ZERhNjZXSU9ZMlRsTys3VEMxRFFyNWg1RXVoQndlN2R0U2s0WEhpWmQ5Z1V2?=
 =?utf-8?B?ZDQ0VTRwbHdDNS9WYnpOdlFJSlJVYWxLMUNDTnNKK1ZlclNCNGdza082L3lH?=
 =?utf-8?B?SmREYmlISEErLytzcVR4YjlLRDdhazZCQ08yQmxiNjZ6bmZLZlU2S1NwMDgw?=
 =?utf-8?B?eC9BTWlIalR1QndLUXFlNE9ySldvL0dzN0ZFSlZjcHZrbUVUL1hCbkhmQ285?=
 =?utf-8?B?c3UyYkVoN21SUFZ6RFR0dDduQ05Tbm41MHRRRW1JSjlOL1R1MGxXbzBnTEx0?=
 =?utf-8?B?bmlldy8vUEJRVzdFMlg2elorNEd1ZVhjeGVMMXlIYS9IZEhJZkNLSVBtQllw?=
 =?utf-8?B?aG8xRldCRXNlWWhLUzBpNDhrVzNCN1VYUy95T21aS2pxSTBPbCtPVHdwSEpu?=
 =?utf-8?B?YzA3MjJjR3FLSmorS3RlNU9za3pzWnVIMm1yV3lRTThFdWNJYmJtWk53cUZS?=
 =?utf-8?B?d1VNUGRaNlhWNWFMaTRpRVA1dGJKSkFGbGt6VXNETWZ0S1VZZytkZm1aa2tv?=
 =?utf-8?B?dnRZcTM5ZUxnNk1ycnhhd2JYN0hZZnhaVDVOOUpWY01VZGxrc1BLZEp2VjhM?=
 =?utf-8?B?azBaSkNaS1lWSUdUWE12dllkekxyZzh2ZFFPL2Zlc3lZWENCRzJBZTlRYmhq?=
 =?utf-8?B?WHVlbitvc2VYaFVjLzhHRFBWekp6OFNOWHBDckk1SXBINEJhcVp5SkZNZUp4?=
 =?utf-8?B?eCt6VG9HWjZnQmYrcURTa0YyeTdoWXMybitLNFd1aXVuLzZWYVBnUDd5MWM1?=
 =?utf-8?B?ZndjS21tTmxoaDdSSmVnT3BnNmVjcVYxZ1UzSHVFQUJUd3BjNkUrMnhvRDFM?=
 =?utf-8?B?dEN1eVRVZWcrSC9kaDYxRUllRW9EVE9xL1lOTXM5SVVVRTdsMFlDUzBqNkVO?=
 =?utf-8?B?eWhnWkRxM0lGa1R1Mld6eXNqeHFzRks5cXZPUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2JJSkN1WkN0KzZOTmY5bktWZUdoYldzcThUY0FmWXhDd0tMclgwQmM0cnRQ?=
 =?utf-8?B?K0ZRZUErV25SdTRMb1hMZVlqenlmV2t6VFJSU3NHWnprWFUrOWJpQlVBYjhp?=
 =?utf-8?B?M3lGVXZzUUNVVTkwR2JUWEYydGUzd3N0VlZOOUZKSCtkekhST3NLWS9MMXlN?=
 =?utf-8?B?cHMvWnVHUTd1bVZQRytEYzRBLzRXK0hIMEEyZndUN0xIVkRsL1drdS96VDg1?=
 =?utf-8?B?NG9ocWNYVHBSbzRqYng3UnFmRnF6bmU5MTZLRVkrYkluZnluWFJ5THF1R2JK?=
 =?utf-8?B?Skl6bE1mU0s4Vlg2WWVGWWduREU4QzdOV3JVWmRvaHhxY3lyajdzdDRhQXcx?=
 =?utf-8?B?L3JVelA5ZFpUUEQzSzFPZk9GZE1uTVczbHVYUnFrZzluK3NtV0QzQWwrUlB1?=
 =?utf-8?B?cHNad2N3eFZ2RGpVWnBodDJBY0FEZ1BaK0JmVHJFSDNrWGQwd09zcHVTbVJ3?=
 =?utf-8?B?bVRCVm43U3lEYzZkc0trZ3JIL0J4cDljOGt2b3FKeDFQTzFEZERqWkhzbWg5?=
 =?utf-8?B?Z21GRVFKcEttbUlhWUM1ZG02WFJ0NmhadmhTekhBMWVKMlk5UEJRVFFHaTIv?=
 =?utf-8?B?M1Q5bjYxTW5XcXlqMjdHYTNBcmxDZmIra1JNS1UzdG5VVUZFdkJSV3BvdmFs?=
 =?utf-8?B?UUlBQit2RXVXcVE0c0l1YkQrNmdTeXhiYUJTZjk0OXVGRE9obCtxQ0xJMFJK?=
 =?utf-8?B?TTR3dW1nMWVrYlRIV3QwdVdHZ2hlbjU4QTRlRytGSHh5VGhGZlFyLzJ4Z2p3?=
 =?utf-8?B?emJ2aUMrNnZvejdxbWRtYkxkMCtveE8vMGhCWUhlMEtQTWJaR2FZaUZlai9K?=
 =?utf-8?B?VXBFTU1MTGZLUUExdUh0MllRL01KMDJjZWJQdDFtNTNpeG8zYVA4V20xMkEy?=
 =?utf-8?B?R0pjQlRNVk5aaTJVM1F2Y21UUWhrS3lyTUxLRndDeEEvZVg3MytLcENVajN2?=
 =?utf-8?B?T1FQQkJrcGNhckdMajBHU2djdWwzaUIvYUdiRWRJc09xMjBtY2YrSTFLeHpk?=
 =?utf-8?B?MFhFQU1SZGxMQnFaZ1RCS2I3U2ZYcWVPYjBPSWFVcnZONFplVXhLUTB4TzRp?=
 =?utf-8?B?Y3FraG04L2N1TU0wcFJZVHRGQjdEOUtwQ20ramVOdmd2NEw0THUyeklCRGsz?=
 =?utf-8?B?QXNvMGN4eEJqUFplVUpmUWhFQmhNWUoyVUc3VzJEYW1jMWhjZEFOeDJrZUFC?=
 =?utf-8?B?ZG5HdFRhbi83NXRaMVV0TVBkWGNXOGtiL3NTN055Ym9MbzR0MlVjSWxZekZV?=
 =?utf-8?B?ZXh2QkVQdTdGN2JFRVJ2YTFsSXhhUmdMb05mRUloY1YvUmhLSVJDc0dQN05X?=
 =?utf-8?B?N2hVTmxaYkpmTjRSdzYzWHJVQmFpUWI0QUNGWDdTdlVaN24wcm1OeEI1ZENx?=
 =?utf-8?B?dkNtbG1lM2FqYzVtSWY1QTNvOVdCS0Q3dTdZS3prZm5xME1JZHZPRUtTZUky?=
 =?utf-8?B?SEljaDBYdHRUY2F3V3l0WkhJY2FXTVZCMGdEV2ZrbFVWQXBMKzdxUTBSTUxw?=
 =?utf-8?B?bE0xTTRRYlpZYVVCK0hMUXlvdnJuUVZwS1I5UEFpd1c3eWhWcjBUTG10VjhG?=
 =?utf-8?B?RE53YllnN2xiaTZiZXNwaDIyKzZBZDdCQm5XVytzQjZ6dW90OVo1N3g5WnRk?=
 =?utf-8?B?RHpiVG5DWnNYR0o2MHdwQ08vSDhwaUpPNjZBYk1IcUdlYkxUMVlFc05ZWURs?=
 =?utf-8?B?L0pCTHU1NzErQU5rSW1UbDB0d0tMWTh5bmJMNHVXR0RPSDMxZi92VFhOSnNE?=
 =?utf-8?B?U29qTEZtVU1lTGluc0w1M2VLZU9UTlVrZ3IwT2p4VFNMT2dmeHRsTkFWaE43?=
 =?utf-8?B?TU9qLzlocDY2aU9xMUI3Mlh6aCtjakxQQVg4ejc1Q2tvc2dnZTVnT0hWQkUz?=
 =?utf-8?B?ZkxuaHF0RUdqZWV1TEV6Y3lFTkpNR2xhZnZ4M2J2R0VwZ092SHRSQWkrNXE5?=
 =?utf-8?B?ZTFzZHB4OUIrNHV5TnkzYTA1ZkpMM21CanE1eDZZcUhOcEdTTENLMkhmOHJE?=
 =?utf-8?B?UmNNZW5UL2cvS1U3dXhrZVc2VEZ3VFlGMFgrUzV1bEYwSlpRSERwYVpvYzNq?=
 =?utf-8?B?Ly9yZUhlMzlkTU13VTAvWlgwd01WZFZnOUJaOHh4bVpmR1N4TzdFZGJySmZ5?=
 =?utf-8?Q?88j0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd38d302-d04f-4a74-b9af-08de17213911
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:27:39.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZY4Pl1UqrkgTFOzGlQi7txhxqa7Zb4BeveuUGYRB19v6jZldiDCTVasK8Y2gX5l3YuLr7UA7YV4aN8bbvZA1eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019

Add sensors under i2c1 bus.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 7b033744554105de6dbc4366f21e3c90f1768deb..9a96018e6f0680ac503135726f4899aca121e7f6 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -450,10 +450,36 @@ i2c@2 {
 			#size-cells = <0>;
 			reg = <2>;
 
+			accelerometer@1e {
+				compatible = "nxp,fxos8700";
+				reg = <0x1e>;
+			};
+
+			gyroscope@21 {
+				compatible = "nxp,fxas21002c";
+				reg = <0x21>;
+			};
+
 			pressure-sensor@60 {
 				compatible = "fsl,mpl3115";
 				reg = <0x60>;
 			};
+
+			/* Ref SCH-54536 */
+			pressure-sensor@77 {
+				compatible = "meas,ms5611";
+				reg = <0x77>;
+			};
+
+			inertial-meter@68 {
+				compatible = "invensense,icm20602";
+				reg = <0x68>;
+			};
+
+			inertial-meter@69 {
+				compatible = "invensense,iam20380";
+				reg = <0x69>;
+			};
 		};
 
 		i2c@3 {
@@ -483,6 +509,12 @@ light-sensor@44 {
 				interrupt-parent = <&lsio_gpio1>;
 				interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 			};
+
+			/* Ref SCH-54536 */
+			light-sensort@60 {
+				compatible = "vishay,vcnl4035";
+				reg = <0x60>;
+			};
 		};
 	};
 

-- 
2.34.1


