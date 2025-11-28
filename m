Return-Path: <linux-iio+bounces-26539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D686C91B06
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DAE3A5C60
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EB930AAB3;
	Fri, 28 Nov 2025 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="w9RdneJM"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazhn15011022.outbound.protection.outlook.com [52.102.183.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8B302140;
	Fri, 28 Nov 2025 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.183.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764326343; cv=fail; b=kFbz99+VTZxPLqISBUWlMcbP7q1dXlfWRC6VV8aKsmO3qT+8Tc1hFa43ltchuMb1uX81PzlOHwVZwv+iNopUDHAZ+NK5M4HIctvz19BpE8NCcK02oFTtMrNhBOWQw/GEFWEuIb9KedBUTomYOEbtA2uUJsDv4leGPCfvh7/d3fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764326343; c=relaxed/simple;
	bh=qlvYtu3wscvMPo/Zao3+Erc6cFs61JKLz3PUEB62rgA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BucXj9I9hLxhtsGhHcR0pJ35k4SPUk8muCLB6b7tKc9rOLOskkmt0s+ICB1Q5HSTqABEEH68FS4MUr9vwQ+/WE5MdKdrmKSCwv0P86aMo/b/DLMhQ7DAobgwsATeEaxcClM2c5JCXsqlAbaJl1YDCZ+YbwsBEZWKVHgYFKSYQic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=w9RdneJM; arc=fail smtp.client-ip=52.102.183.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQNt5ebGbRAbU822Z+nGMeCgxEQkOny29As4VzsrgRZokBu3a5jaiMFymOb4zED/HdofjCK5kXmy3bF7D+I3V2wwarUAdMdRwmJDT2iCctBwTMqw15kYW0D62z8MDrpCk8A2LTIbZvZR3XWol5y1BWEbalr0rCPD91DhmmlhEQ9KrHB49wwET/1cIJ+SXKbE9EfKqb9jbLO0PDicHxT191j5t9oxp+n9tLBS7FeACZ0ZVbWoqUiEsoWj/0qlBd1ID/kSO303pnz1NOSvtqFHnNiimB4z1/JC9hWxtvHOBb1nVrjGrfkCMQhfpQTD7JURh1ynx/i/PaWNX2ihYy2xmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlvYtu3wscvMPo/Zao3+Erc6cFs61JKLz3PUEB62rgA=;
 b=FaU8XNy5Ty2KG97VosZzRISvXlKtjv666/58oLNw7eX6RdFrCGDXVn0M7o1Hpb5wliGBjjjGZvxHvNq52/Az8MLbokEyfXH5EE3m97Udbo/8neX89jPl4IszzH/hcEpRnEIhB69E6SAXJlaPeGovs4Arh2GJMbi7sZDqDahjKqUKRYyPqIRxMPR6nntHwB8Gq7rrZgLfqe8VeVhM/Z1yYnMp9zmWJmLfrDwgR+aHtwL4nINl5yH9VrM4urfbg2wNayzKiJftKy/PVR2tYGheAl7j4Mt58x5viROc/D3gDsgr/2+1h9pGQccpyodJLa1zsxewydyORpjgx+7PPhxX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.28) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlvYtu3wscvMPo/Zao3+Erc6cFs61JKLz3PUEB62rgA=;
 b=w9RdneJMcJUWF8wHeOS080yRgnub6wgMRyGokChtEegvOBItnQvn8ULU3NOQG5MPOgBkGJdvPGYuIam7SFcHri2hUO+zKWtpL+vNeKvrMB0cViPdXxT+HrrJDkzaKrndgBvi0HawADlCF7cWIgCFVC6CCXucViT1mol8mKFLL+E=
Received: from DU7PR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::20) by GV0P278MB1994.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:6e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 10:38:58 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::2) by DU7PR01CA0038.outlook.office365.com
 (2603:10a6:10:50e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 10:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.28)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.28; helo=ZRZP278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver02.de.seppmail.cloud (2a01:4f8:272:5fe6::218) by
 DU6PEPF00009523.mail.protection.outlook.com (2603:10a6:18:3::4) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 10:38:57 +0000
Received: from hz-glue04.de.seppmail.cloud (unknown [10.11.0.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4dHqXc5j3Kz11Bn;
	Fri, 28 Nov 2025 11:38:56 +0100 (CET)
Received: from hz-glue04.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue04.de.seppmail.cloud (Postfix) with SMTP id 4dHqXc5BJnz1x7k;
	Fri, 28 Nov 2025 11:38:56 +0100 (CET)
X-SEPP-Suspect: fce2eebba26b4ea98a129c8c4940514d
Received: from hz-scan04.de.seppmail.cloud (unknown [10.11.0.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue04.de.seppmail.cloud (Postfix) with ESMTPS id 4dHqXc4WCPz1x7c;
	Fri, 28 Nov 2025 11:38:56 +0100 (CET)
Received: from hz-scan04 (localhost [127.0.0.1])
	by hz-scan04.de.seppmail.cloud (Postfix) with SMTP id 4dHqXc3x5dz6q4d;
	Fri, 28 Nov 2025 11:38:56 +0100 (CET)
Received: from hz-m365gate04.de.seppmail.cloud (unknown [10.11.0.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan04.de.seppmail.cloud (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 11:38:54 +0100 (CET)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011028.outbound.protection.outlook.com [40.93.85.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate04.de.seppmail.cloud (Postfix) with ESMTPS id 4dHqXX2xTkz1w9x;
	Fri, 28 Nov 2025 11:38:52 +0100 (CET)
Received: from DUZPR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::11) by ZR1P278MB1659.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:a6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 10:38:49 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::38) by DUZPR01CA0032.outlook.office365.com
 (2603:10a6:10:468::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 10:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 10:38:49 +0000
Received: from GVAP278CU002.outbound.protection.outlook.com (40.93.86.6) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 28 Nov 2025 10:38:48 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 GV1PPFF28618029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Fri, 28 Nov 2025 10:38:45 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:38:44 +0000
Date: Fri, 28 Nov 2025 11:38:41 +0100
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: linus.walleij@linaro.org, brgl@kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	morbidrsa@gmail.com, jth@kernel.org, wim@linux-watchdog.org,
	linux@roeck-us.net, nathan@kernel.org, nsc@kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Subject: Re: [PATCH 2/2] mcb: Remove MODULE_ALIAS from all mcb client drivers
Message-ID: <aSl7sWjt6fqgirvI@MNI-190>
References: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
 <20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com>
 <CAHp75VfhM5GuYY1qUKgBhePDo4oe5k3K1ZDTPbYJNr5NtjVVfQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHp75VfhM5GuYY1qUKgBhePDo4oe5k3K1ZDTPbYJNr5NtjVVfQ@mail.gmail.com>
X-ClientProxiedBy: MA2P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::15) To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|GV1PPFF28618029:EE_|DU2PEPF0001E9C2:EE_|ZR1P278MB1659:EE_|DU6PEPF00009523:EE_|GV0P278MB1994:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e54fd2-9dbe-40d1-a5ee-08de2e6a55c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Z05LYStwbU5xakd1WmNHZ0RTWHpSSERXSG9pY21ZM1VoY2RBM3hxUlZkbVhZ?=
 =?utf-8?B?WXBJYjB2aHlBSEtwUlFRdXdtZG1jSnhySFhhNkJYM2ZHSklRYzJkK3JGaEFS?=
 =?utf-8?B?aHp3SU91NzNlUHdRbnVjRWlRZTYvajM5YlR2RDA0VTZZYXhFMlNUbXBuZXNH?=
 =?utf-8?B?bWhIOUdvNXJHeUNYTU9OdWU1Y096K05QMlp6S1Y0d0ZtZHBaU1RJanhmT1pD?=
 =?utf-8?B?NHkrZVRYdnR0dEpqSnlGZ1lwVU8zUHFUcmk5TVJFT3hhNFhJazF6T1ZWZDh2?=
 =?utf-8?B?ODV3VzFrSDBoUDNaTWgxSkNlamM2aWFhWWJ2RTN4Q01Ya3I0MnpabDJwTDg1?=
 =?utf-8?B?TGZCZnFtYlVsTFVFS0pzTlhvZzV1UlErTFdFYWR1N2tIQUtXZmZEVHNNR0lt?=
 =?utf-8?B?N0wxNU10MU5aemNKQlRTSGpOTUZXMlNBV3dnbU5YZ2FBL2hPMFpmVXpVcUty?=
 =?utf-8?B?WW5DMlBiaG40dlZyUjBWbVBobzEvdUtSOWlXcTFvY0lwRyt6RnhlNkdDVHdk?=
 =?utf-8?B?SVNyeWd3b0lnaEtxeVlrYzV3bTAyUjVObFlwVkYwaGtnUGRkSm9mempRMjhX?=
 =?utf-8?B?YlliZmFnMVRxUWdseEJ5clc0ZEJpTUpOWGhEV3Fvbm1kcGxidWllb0JuVXg0?=
 =?utf-8?B?QWpUZE1OanJscUNKeStkRUR6Zk9RY1VSNlJFakJoalpkUW93MkZjQkFPZ2U4?=
 =?utf-8?B?ZHBZeitDMEdOdHFDR1p0ejhuNzZkK0RVKzA3UERkSHpjeUtWZDZCZkptQ1hV?=
 =?utf-8?B?RVdpS3EzRjFlZFB1T2tiQlJNbGh3WDN2QkpicXRlajB1N0VZNW9YUHVLTTI5?=
 =?utf-8?B?L1Jna2dvdnpDdDhJWC9wUWxtN0hxUGZqOHliSlNVVzVCWHJObWVyWkpZSzFY?=
 =?utf-8?B?YUtSTXlkcFRiQUpET3hnVXJCcFg3TzJ3MWI1ek5STEZPQ21wdmFnSFQ3M1F4?=
 =?utf-8?B?bDlzQ2xxcG1VVnoyRGtBdmdlL3BVRzh6Q3FwekxJcGN0ZTNyR08xL3ZWa2JI?=
 =?utf-8?B?ME5iYXFiYWEwTjJnU2xZdFdsMS8rR2hHc1VZanBScEVrK015V2VUMzRzOXNt?=
 =?utf-8?B?c2Zub2JJWkJYNzNwUnZoeVVqUElsL3ZGTEdjZitaS251WXhPdXNiWStuSFRj?=
 =?utf-8?B?OGZpcUlNN3NEc0YxWEdremZDUWZpbmVKaDE5dURHQzFUQ0p5OUJWc2VBVkpn?=
 =?utf-8?B?R3IrV0habldocWZPZkU0aERveDBKOVhTb1o4eGJOanlrdTRoUHZlYTZMLzdK?=
 =?utf-8?B?Ukl1a1pTUWh4UVpxeXErUTQ0amtSVUROVUxlYitjUEprZTRYTkFEVUxGeG9X?=
 =?utf-8?B?eWpNemZ2a2xFd2k5T2k5R2lXUkVWK2ZtdjFtYVFmQkRRTThudXdlQzRNOTVK?=
 =?utf-8?B?NkNQNHpoMjZSZzFEUG5DZVluSEoxRUNQc1YwakVVTmlpS1cwb29EYkJzdTRs?=
 =?utf-8?B?ZGh0aTJzUDJxY3c0ZlcwVEFDaEFpNEFHdGtZNEtQc3NnaWpCMmk2YWF6MkJL?=
 =?utf-8?B?Zk9vTmMyMlAyeGhna0M5MWU3c2ZnVlFHTlAxY2ZYYTFLUjg1aTh1OUhzMlV2?=
 =?utf-8?B?RWxFVVFERnVCeGY0RythVlhtSEREQTVuK2YzOWJtSnA2U3pldkdqM016aGkr?=
 =?utf-8?B?OEVkWEs1TGpuZ3pRQlkxOUhJZ0h3cHplT05qN21hYytLczAyTSswNTdNR0RB?=
 =?utf-8?B?cnlVbjdxYnRhNmhEZllUc3U4RFZxYzdXYzMzTURkVnhodngzdnlKMnRHcHpM?=
 =?utf-8?B?b3pjaE0yUEcwZkpXMDA0UTNIU21vaG5aL28rcVc5eEd0NUJZaWcra2NHUU1l?=
 =?utf-8?B?aG1GUi84cXIxd3JKN2dzOWR5UERid0twWU9RUlJSSE1kNnVkUWJyUnV0OFk3?=
 =?utf-8?B?Q24rUVFtN2xBOVcvSkZ5eW5uNXdtVmFoZ21leTNxUlVMeEh3d0xIcDFrdnF5?=
 =?utf-8?B?RWFFM3plWGFTVGJqMlhwTElXb1kwakJKNDJFd3dFeEpqdmhBVUszd0F1VkN1?=
 =?utf-8?B?UWhuZWljR2FzMXJlVUtWaFZBWnp2b2x3ZmIzdm8xNENNZ1VxZHNyZzRlMFk1?=
 =?utf-8?Q?N+LSVD?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPFF28618029
X-CodeTwo-MessageID: cfe625c0-f2d2-4da1-9267-53bdbeb06d09.20251128103848@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 116df752-9126-4f00-d0dd-08de2e6a4df8
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|14060799003|36860700013|35042699022|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?K2VNSU1iSXl0aGNoWERvS0wrUmlySk0yclpZS2dTQ0hkYSsyZEZTb0JwR3JZ?=
 =?utf-8?B?eFBWZTNMTUxlR1RyVVdpbDJ2SjdrOUJRWFdnS2kyM1RRL2xIR0QvRVJZRndx?=
 =?utf-8?B?OVAvdG9YcE9jQ0lzNFBodXU0SkxWWUpCQ1d2ajI0eUM1QXp6T0w2a2xHaW1j?=
 =?utf-8?B?MFEwQjdCK2diWllsU2J5bHpJa2ZoUWdEMHpYaXB4S28zZXo4bmdta0tyY09z?=
 =?utf-8?B?L1l2MlFTRWxWbHJraGIvbzZlY0pleDJtd0RVaXZsZ2VYb3A4dEhTdTNhSVlx?=
 =?utf-8?B?UHR3RUsrQWhvc1k5cjB1cjhxbVRITmQwY0NpaDB2NCs3MTU0RmVxaE8xOW9h?=
 =?utf-8?B?TDRDVFVmbXZYNHRIK21ZWHc0Vy8xdnNrZjlmYXRPdy9PaGQ3ZmZOMXdrSGtz?=
 =?utf-8?B?UGJPdG1sL01JU3dFVVJEWkVEVFlXcXkwb3JKb2hnK1M5SFpDQzkrSnEwc2lY?=
 =?utf-8?B?dllpQlUyV2xDM0pXaUh6bG9wUDFNQWhLdTlzSXRVcjRKcllveFl1a3pNQUpu?=
 =?utf-8?B?cmV4czRrc3JhUDJDeVplbXJFNnRpZm8yVk9pMHFJVXUvV0JVRUtFNm1uMDJz?=
 =?utf-8?B?Tzg3b3hjRk0zaitOTEtZd3ZzaHc1ejRuaUNySWRtb3VNMExyTWlUZENDNHo5?=
 =?utf-8?B?Unc1cHNvcDRhOWEwajlQUGh2TG1WMzROTnFUbnRpQnZkdU50bjVzM29yRXJU?=
 =?utf-8?B?ZXV3enBUZElmT2d6V1FKNGVmdGpyeW5IdGFmTXJ5TDFySXJnZ1JOVVpHdHZ0?=
 =?utf-8?B?NUVQUDIyMzRlOXFGbnhmWjlHYXRueG4wczA1SndKMEpFV241WlZkWHA1N2Zr?=
 =?utf-8?B?aUFpNEFjOU5xTzV6Zm1LMTE2ZU9SMnZVc240Nmp4SzNZYnpYRUllRVBkcVIy?=
 =?utf-8?B?cGMvTHJuWnd1VU1DeUdzMnBjTW8rMkJ3a1R5ZE1FbFZxT3lCbGhPKzVhcDN1?=
 =?utf-8?B?TkpYSFJEZzBVQ2k1STM0RkFEdU9uVlhUS0hRZGFFOSttL1N1d1kxbDVxeVBO?=
 =?utf-8?B?MGRsOVAwQlFtNDlkMTRHaE15WmlyS1BleXoxbFRZcnU0MjcwdnQ1V0lrWWN0?=
 =?utf-8?B?bnRBMjBQVUEyaWtjclE1anlqbTNGK1E2Z0NXWWpFMGMxZTlqejg5bllxQjNC?=
 =?utf-8?B?blBDWW9OMXVIa1VSbG54N1lxK3IveDlIZ0FxRWVySWJXcFpsaXdhK2tBQmN3?=
 =?utf-8?B?WlJ1YkI0SGZHQS9hWGUwKy8vZk1IaEw3RnFUaDdNYm9BdnZRcHJ3ajl0OWdH?=
 =?utf-8?B?MjZBbHd1aHgvY0lmT2pISnRjYlJxbFpqOFdGNi9ZaUdoVVlSTmpFUHVjemo5?=
 =?utf-8?B?cURDUkVLanAxKzM0emZKQk5JdExBcjdKRzh1M1lTRVBTOUJLRTlRdjB4QmxW?=
 =?utf-8?B?V1RHNnFhNS9OdkFQY0RCbU50KzhtV2tucnJnUUw2a2xkcSs0TnZMKzk5Uk4r?=
 =?utf-8?B?ck9zeXd1Nk5pVjJmUjY2YUJQNkNUSEpCeUc2YkNWWHI0TVRua013T09QRjBO?=
 =?utf-8?B?Y1luM3VVS1JqZzhJZ1VWdkI3eFlUL24vNHYrMnJpdFByRU5xRjFYTHdKMXdx?=
 =?utf-8?B?TEJiRmNHOUtHNDBMU3RudzY4c1kwb1l3Nk5zZlNIbm5DLzlNd2ZWaGZWTzI5?=
 =?utf-8?B?NEVZOEx2WnFUQlZ2MzZFUHhaZVV5b1pBaHlXSWg5eUVIUzNsRFpJNDlXdXVJ?=
 =?utf-8?B?cFhjMUt1cWdkeEY2V01HQ0hzcFlwemRxVjR3NVcyQXdLK2VTZmxHTDQ5Uy84?=
 =?utf-8?B?SkorN251WFFmQmZQcUN1ZiszNGsxa2dBZnRvMkZBNERqbnVQRUJsaStGQWth?=
 =?utf-8?B?dGhZcWtyVWdNWlhleUpodTZScUZmVXhBVnd5S0hzWFI4T1FWcmdmV0l4UzZT?=
 =?utf-8?B?Tk42VVY3ckF3NWxiZVlNYWJreGYvb2FGald6YUVuVVRpcFcxUHJuY1QzRExN?=
 =?utf-8?B?M0JLMmhicm9ON1ZCblJCKytUWm8raTlpakJ2WmxRQzZXZ1hEckdNNWVXenpy?=
 =?utf-8?B?a3lBT0k5eTEybFZPUUZDcGNNYzFBT0dUdlUxclh2ZUNTYXZROGdzd0hDUll3?=
 =?utf-8?B?bC9CWnNZbkZyNGdaeEEzN2lBZG5zc3ZnQUtDdmt3YlNDN01WOEwydEVxRGkx?=
 =?utf-8?Q?uMsg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(35042699022)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1659
X-SEPP-CCCVersion: 2025-11-05T14:36:24+01:00 6c313bee
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.28];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.28];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	500bafc7-37b6-4438-5335-08de2e6a5132
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|82310400026|36860700013|7416014|376014|1800799024|35042699022|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG5NQjEvWGZLVkphTnA5T0d0UTlya3ZkUVMyRUZFSmNLUWlNQnV5c0x6RURl?=
 =?utf-8?B?cnlUNjVndWFDSlZ3V1IvV3c1WnQ1VXFHcnpJZkZUMU1zNHFOV0NnR1hRbkRO?=
 =?utf-8?B?U1FTNGZJUGdUODVXUDRXelA3d1FsT3QvL0tZdFdzOVVrM1BMOTc3N2tlekl5?=
 =?utf-8?B?MitMTVdkZ2o3ZXpWRGFWR05tei9naXl1bkNNNjZJMTJ4eHI3RnAwMWtxdFhr?=
 =?utf-8?B?cXFUU2YwMHV6alZRUVoyOVNsSWNBTU9rZkt1aHN6RnNCcHd1eVpRUWEzUVZn?=
 =?utf-8?B?RnB4NDNwQUlaWXV6cjJiTDRWVVRISzBwQmJyY0dzMytTVThIaTcrYkdodGx2?=
 =?utf-8?B?b2k3ZkN3SXhOeXplL042Y2RmVWh2UXB3ejRPVE9jSkx0R3pLb0dlZU5YVVRH?=
 =?utf-8?B?enBIbmhFWkdyMEEvd29OcUlEa3VaOHlCeGRHNkIzQ1AvM3k0bVYrUUZrTHhr?=
 =?utf-8?B?b2Rqc3RaRERLUHplTEZyZXNIam00Sm9BMmtVN0w0L3ZjWU1nY3BtSTQxeS9o?=
 =?utf-8?B?ejlHLzBpTjFPWlpXY3dyZEFGWFVXUExRSitTS3hYMjIzYlFVOGt6d3RsNHht?=
 =?utf-8?B?RExKWjN1UlBQZXVmS096K2hQS2M4a3QyLy9acHRyRS9lcEFUVDBURDNYZUti?=
 =?utf-8?B?WVZ4dnZJN3JwWW04dFpEMGtBenZ5SStrNjdLNDdaOTYrZGE3dlROSCtDWkY0?=
 =?utf-8?B?V05JcFRadHRWM1UwSUFQeEt0V1hzeXNFNUZRaHk2dG55ZWtJVy8raXdtOFdS?=
 =?utf-8?B?Ulc2U3RJSmUxSVdVZUhZdENuNUVCcDZEN21Va1U2d255cW5vbnhFQk9ab004?=
 =?utf-8?B?dWorZlFUQlpPSDVYQUttYjk2eVlBL1RhdEJYcWg1YWtHUXRETzQ1WUFIdDdE?=
 =?utf-8?B?MmwyNDEra2ZvVWF1cWszWXhDNks3QS9vczBsRmtmWlRsZzJabVdkTnhDazYx?=
 =?utf-8?B?MWNpeWNtTEU2OVgyNUg4UTNQZXluU2hBUHltK0dTeTY1V1NWQSthbm1WZ0F5?=
 =?utf-8?B?eUVpbGNNWWZQMXBCUzlCc3BmT3BzVUMvOTk1QlFpVTZhQUdSK1hhTGhYNjhy?=
 =?utf-8?B?ODhKSGpkTU41ZGNWZDNsZDlITGFQNXkxUEVZc3o1Nms5TlRjOHhyWDJCTDFZ?=
 =?utf-8?B?Mm90UEhCblZrUFpPRWZFS0pYb1ZlekhiOGlxdzdhKytZdWIwZnJYSTNBQUpi?=
 =?utf-8?B?U0M0dDFtWlpNamRQL01oblcyUzVhM0FVZFF1WEtyL3U0WXpsdnpKbkY0UStM?=
 =?utf-8?B?d1ZjdEZHQlhCOWRBWjlIbGprdG5iSUozdytnTm9yeGFyNmhVU2V6Q2syT0Vz?=
 =?utf-8?B?SnBKMmNvZ0pCcGdpcjdNdUFLU0xBWDdJTkZFRTZZKy9NTitNbUZVT0hXMEtG?=
 =?utf-8?B?bFFjaEhQeEdqUzhiNVUwSXRrNDhzR0xONktzM0RlaGtnaFprZE1vaTJSRlpK?=
 =?utf-8?B?VXJnU0txeWtHcHhKQXNld2pTVDdTZU50aWZ1UmdkQjdWMWhkZFFkVUdLV2tV?=
 =?utf-8?Q?p+1nsLTgKN9MV5fWyp1R1COLPvO?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:272:5fe6::218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRZP278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17011028.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(10070799003)(82310400026)(36860700013)(7416014)(376014)(1800799024)(35042699022)(34020700016)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 10:38:57.1918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e54fd2-9dbe-40d1-a5ee-08de2e6a55c0
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:272:5fe6::218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1994

On Thu, Nov 27, 2025 at 06:12:29PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 27, 2025 at 5:56=E2=80=AFPM Jose Javier Rodriguez Barbarin
> <dev-josejavier.rodriguez@duagon.com> wrote:
> >
> > MODULE_ALIAS information is no longer needed as now all mcb client
> > drivers are reporting such information through MODULE_DEVICE_TABLE.
>=20
> While this is not a big change, I still would recommend to split on
> per-driver basis, and with pushing the first one as kinda a fix after
> v6.19-rc1 (to v6.19-rcX) allows other maintainers to apply the rest on
> driver-basis. This helps everybody I assume.
>=20

Understood. This was my first patch that touches more than one subsystem
and I was doubting to send one unique patch or one patch per driver.=20
Good to know that.=20

Thank you so much.

>=20
> --=20
> With Best Regards,
> Andy Shevchenko

