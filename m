Return-Path: <linux-iio+bounces-27114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39879CC2842
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 13:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB36230253D6
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA2E34C9AC;
	Tue, 16 Dec 2025 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="AcvNdeG6"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021140.outbound.protection.outlook.com [40.107.130.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650B834C815;
	Tue, 16 Dec 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885285; cv=fail; b=jDj40vU90jA0HS3G2cKJF0sXIHXZaBEhfwc3IS/TK1DWyqaLUS2Bci6cMJZ4nC90zaTn9IeAJkFl3/ZD6vdtBScpd9V3JGfg0E9V4oYiwIREPmBD9jxlVkdjXwlIch5lor1mThAfj4Cg6PF3RxcB7G4T7CAAizaBUyw9H3bomCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885285; c=relaxed/simple;
	bh=PkrWiUGhQs1UyUpQ/Se6I1+lfgU7b0VdUU1MqZ74wbI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lLcKUH9iH8hWaJ0DMg7sUdd20riPvnsbByH7s3g2wGQRAWUXR5RG8M2kIRhZeZGYflpIBdRBVaQs9krvr9PFeHsOY9Vwb57tvlSZVSIq4Ozlh950EX/GDnhz5DFPCsAH8ZiUoCKDfVUIBSOrXkSesXrfYNREr5EmUUBr79du1rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=AcvNdeG6; arc=fail smtp.client-ip=40.107.130.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCTYSbd5XI/sZ9aMm2dquF+vEyqtjfC26atB+8ErGzRa9AKKomUTgW2Xf4U0JBxNGiXpvpK9v7QS5N3z0IzDL7cnTV1IwQaVA8usVtjO+2FRboZ+PaCbFaRukWhYCRsLgHYAO5P/mRbMw5yH6A5NJg12+Mw54Kww7UsFMQrsN4mv59QtLO+FMCkzM/hKdYEF7ykSfONbjC0LsaufDD6o9BBh/rLXHFWRNam74/Zy4NNzwdzFb4QjiwNOiRFizbD1gN6utxYD+I7jfCUI84fK3gb+KxkmY3J8oF4uxxvQLmHWTmK46RssP6LStNymrFfsOYFO3HrYp75C3x7mp05qCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhrmv0zocQ5+oIfeqjB02K11USX+ozWq29XX6nFF8Lg=;
 b=Ox/olH+z87j/jyJwkQKzcCx0kBpba7YahG/ebCnNanjqhQKwjiJipap+w3l5HDk802BJPwfNcf4qaRMVJNPul/RutC+KnBy2ooAkBxfS0fnbeSJW8z/JeI7vRzSywOif3dxr75zzxjn/uLkKa9S2l98mDwwXGZjgNpJdcES+oCclkYNSEMZ+slSxCaoNKQ6he0+5uoUZG0wYZP4pr8JVWWIBf5dbPOlWs4fe9BYjTOcgvHswpzUkg6CX+9ZvdyZATeurJmXyYmGmICFmw1WJw/BdrZoc412k3hEJcns/wpLPhBcP8jbDeT3dooyeelQ3AhIpYze2XOeNyf7Wf0X2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhrmv0zocQ5+oIfeqjB02K11USX+ozWq29XX6nFF8Lg=;
 b=AcvNdeG6I8WxJbJVAs4BnzzeWb7j83sh4OycA17MH4z+jhhwhHHfUOBegDOh2QkRulSFqOUriLEvyv0MuqXyxjO3Zrw9x5ktTGPFQinKZpCaLu5CTkky+tFYBjfQqiiMXnblDK9gp0CYw7VawLLYUsS+cXcgh92HsxG/8OEFhTwTir9zb9udhDhKYiTydzrxIUDfK5kRHTrlaoaOzMJfVGR9x/mmvfxSLjuVq2d8pmmae/Zs5AphO5u6Al4lE8ZOun52QYR3uGks30u6EhRnGObBlc4V3Lwjrld7szwa7dA6EiN5qreA4bvPkvsV1fAX9aECshXsgXwlyQEYnukgqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DU4PR06MB10185.eurprd06.prod.outlook.com (2603:10a6:10:626::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 11:41:12 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 11:41:11 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 16 Dec 2025 11:40:06 +0000
Subject: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
In-Reply-To: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765885270; l=2946;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=PkrWiUGhQs1UyUpQ/Se6I1+lfgU7b0VdUU1MqZ74wbI=;
 b=ynWy2XaL5Pd2/0VKEXCe99nCMKSll30zDFoiaTfWKRDVbSfRuDphYkS0dhUBeG6EKzbwahjz/
 bAu8FpWYZ52AqxN3GAOlfErcfQQuhksdpaeesBzcPG6VKiOxkFvoBfB
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV2PEPF0000383B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:b) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DU4PR06MB10185:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f3323a-3040-4655-92f6-08de3c980326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2FHNGRkRG9QWUFobVhYOFp3cHhmdkg2elA4TytnTXhGQU1CVGpQZHU2aSs0?=
 =?utf-8?B?cXJlZEJWc2JSTm5lNmlPdUpTM3pXRXF4R2RkbStsZ3dRckNJRVBlS3FQQS9u?=
 =?utf-8?B?Z29FY1JFSVNoSUJaUXRLcFVzcGtLRFk0bXhsRWJhVHpHMEZCMmRnd3hteVkw?=
 =?utf-8?B?c2syazlYK05iSXQyNm5oNTl6R2R1N0tnZXUvQy9DMnd5akxNMmVOVlJhdkpa?=
 =?utf-8?B?a29uVHM5ZXRjUnI5Ry92TFJSZmVnQVNVTXRjRjh5WW0xb2QzM1pqTkhtRXh3?=
 =?utf-8?B?bkppdEgrUE1CdFFWZlhVQnhRNzAyczBiOWxPNzFCYWRoTlZjUS95eGo1SmZh?=
 =?utf-8?B?ZXV2R2JUWkllR0lHWTBzL3Q5T1Q5SFZLVlVYbU9IdXo3MS9xV0YyaEJ6UXZY?=
 =?utf-8?B?MUU3YlRXVGNuQnk3YzNXbWwza1pLVnVONktrNXpTRDlyd3YwRlBJQW04b0t0?=
 =?utf-8?B?ZEdNRm9JeDJqNVkvLzVPemkwRVRCT0djRmxmUkI5ek8rTDVYb1ljVXkxQnZN?=
 =?utf-8?B?SXFtbFdWYmwyOUF5ZEhTU24zcnVzbWJtVlg4NTV5UzBqYm5obUlYMGJBejBt?=
 =?utf-8?B?a0xzcG1odTlWanFVMXIrRTZ3dUphVXZJeWE5QlJmT2NhaWszZGQ2MUhSV1ZT?=
 =?utf-8?B?eWtCVzdJSFFJQ2dmK0tvUjNPU1ZsNTdOTjJsdFdqVnFoTTVhQzMwTjhzUzYx?=
 =?utf-8?B?WEtPZ3JtZCtSOS9qUm02OEo3QzV2bUt0NXFUM21TdTFKQm53YlNpUE8rQWhE?=
 =?utf-8?B?RHFWaVNLOEV4a1REbjNYRWYvQVp5QjRvM2ZnK0g5U09aUTYvMGQzNXpMM2Nk?=
 =?utf-8?B?QndTZjJzc3RjVGErVFVsMnVXNHNBUjVJN1p0a0IxRzZibjZCT0NRcVpvRnFV?=
 =?utf-8?B?dEFTbjg1SzBpYVJkbGxIUklLeEVxS1R6S04zcU5hOHplYzJIWmxpVWo2Zy82?=
 =?utf-8?B?RmhPNUZ5aEJiS29xQnpKUWQ2b2gvbDhHQnJZZVBYV0hKTWthQzFFUEd0NS9Y?=
 =?utf-8?B?S3U0L2QyS1pjWWpwbmFKT2F2K3dDUmVaUGxieGNmNndQOWNtODVDa0E1eGVk?=
 =?utf-8?B?T0xBMVBCdVlNbkx1Q0syZ0hNUWdWTWpTcFpRM0U0NDV3ZmxsbWxOSTF5UUZC?=
 =?utf-8?B?WmhWNTBVaXlJeGMxcVRDRXBnMEZvY2JyUWNhbEJ5MytnOUZaUm9ZMGhOZ3RI?=
 =?utf-8?B?RnRieTNyQ3gxTFFiTEkvdDNPSzF6L05RcG51ZURQM1ZoRlZDUFlEa1c0MVdT?=
 =?utf-8?B?UllVNmYrOWdOelF0SHp5SFZzcG91RVpBNVJYMTdCUW5aTHlQcWdjeldCM2Mz?=
 =?utf-8?B?a1BlWkFYbzEwU0FhVGdJS3A4dy90QkJVZnAvOXpmdTVlTXVtVGxRcEx3WlVT?=
 =?utf-8?B?QWVrTkVlZVl3MXpvWElna0diWGxjWGNiTHUwbS84L0JFVWI2Ty9ibXBkTm5r?=
 =?utf-8?B?Y0liWDR5Q2QrOEYvelhQWWRhcWFBbVo3MGtJdEEvT010ekorVkFKMmZEYWFm?=
 =?utf-8?B?RXFHeDl1UEo4KzliVUo2dFo1N1RyeWNBMU1YOExFN0QrMlBiT0VlTk5nU1pG?=
 =?utf-8?B?Rk1KL0wxanRFS292OFZVMGxwVEl2bms4ZGNiMkZCZXQxODlIRW9KVkpaa1JY?=
 =?utf-8?B?WTgzejZPRjBYQW4zcC9OQVpxREdRMk0rK1FXNVcyWDFnNksweXpDWld6M0Rh?=
 =?utf-8?B?Z1psNU1ndEl5TUFBbVA2SUlLZ3NKcjBySmF6TGdlNmJuYjRyZWhPOXFMdTYz?=
 =?utf-8?B?RGlNOHV6czNiYW5tdVUxbGZVSlhyRUNncWVWU0NiMVJHcUk5VHRmTDFSQjlk?=
 =?utf-8?B?eENVSG1RUy82NDEvaDRBeks4ZktmZWxGczlSY1YvTkJKZThNRVhsdzFwZmZH?=
 =?utf-8?B?SHM3L1B6bTlwL2M5ajh2TXpUSEg0UWxNNXVMT2Qvb0hFZFdjdDZ6OU0yYnZs?=
 =?utf-8?B?VkJ6eTJVTUF2ODBmN0NtTmV4a0tyb0VUNHB3Q1VNRDRZak1BUUtUdE1INWFh?=
 =?utf-8?B?MUx3cmFYY2hOZklVSzJ3aTN0WXNGNVVhQXlEUnl4dDNvWlR6OEVNRnJxeWdH?=
 =?utf-8?Q?mRzJrv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHUzcUR1TEtWdlgvcUJWdlR5K1FWUFhrUzIwbitlYW1jdkpXYk50SnVjOWUv?=
 =?utf-8?B?K01tWVpOOTRXeUVNQVBmcTE3SmtzWEgycDVqdDJCRjl6d2MxaU5RanBnMnhX?=
 =?utf-8?B?RmJXb0YxRU1nTGt2Mnpsb0tjV2hlcXVXbm9ISnArU25XM2I2TCtRa1UwWU9R?=
 =?utf-8?B?eVhwYXdKSU9xQVltbTVTVm1yK1hLTXQ4SERaditsR3V6UHowU2tydHpIM1dW?=
 =?utf-8?B?eWhTQzFSZ2JpMzRTSHhFd0FLbnNHbnVlUzBkVGRJTTZVQ1V0MjFPc09QMnli?=
 =?utf-8?B?R2ZqMzFMaWhaL2RnQndSVlIyZmtaR3hpQzErWlBoK0llTnFVMFdCVWNzZktY?=
 =?utf-8?B?Wi90c0p0L3hCS2x5NUk5QTNSY29vL29Wb216RzR2UHFncHgxTXRDU0hzZHlu?=
 =?utf-8?B?WjhZSjJqRkdJYVdkQ1dGbm4vR1hnekx3dHN4MUZvVFpuMFYwNTdhQ2NEN3k3?=
 =?utf-8?B?Mmp1bTJsRUFhcGphdVVmTWJiMjkrK1BCV3hHZ3l6TmFsYkdwdGEwUTB5clor?=
 =?utf-8?B?MVFxZzJEdVUwWmJUSnIzYm14RkprN2dXZXFhQW5BZDY4LzRzcU9kdnloV1BK?=
 =?utf-8?B?TFh3bmI0b3FNWHV2blZld3JVM2RIWkxaczVKS1lyTDlFaTFsNDVEVU43Um1z?=
 =?utf-8?B?dXdKS2haMEZ2Rjg0RE9jVGtqdTNwMDhsSW8xZ2pLZGo5bERnQnFybTNlRzl4?=
 =?utf-8?B?dmlRUW94REVEZlpCNStWYVBwcWlPUFRHWE4vSWJjMjY3NzN2UUg3SGZHQWpx?=
 =?utf-8?B?cXFva0ZTNWt0NFpseTNUUG1xN083N3VsSnl6ZHovUmIrbUMya1M3MDVHb1c4?=
 =?utf-8?B?YSswM0RuU0MwOW5SMk15Q2duWVBtdisxOWFiTzJhSmNEM2dSK2FDZVMxSVVY?=
 =?utf-8?B?T3VZWDFWT1l0a2krVW5YNGFuUE8yaGxqMlJwc3pza2x0M2Qwb2JQd3JtOUg3?=
 =?utf-8?B?a2hZVVdEbFVrMWtkd3FvQWNQRVpib3EzVmxkQ1FBdjdBZ3dyeW9LWkVKTUZH?=
 =?utf-8?B?NmYvejh1M1dJdzlua0RCVE9yY1g3TUJMblM3T0xjc210WFVpbFZleWJaVFpO?=
 =?utf-8?B?VG9Rb3drem1Vc28xYUcxNDJUd0hoZzMvZEZzZHJPbWdlOVZZdnV0eHFUSGdQ?=
 =?utf-8?B?YUYrQXl4OTIzcTZoSWJMdkgxeS9kaFdrMzZyb0VtK0ZiMWVIY21pZktHeXdm?=
 =?utf-8?B?RG1WN3lFQXcrZjcxK2h3dmxwSitRZmZybGhkZ20xUEhzajNqOTFIaTJuTzBw?=
 =?utf-8?B?ZVlMY0djUzl5c0RrajljeDc1L1VIMEVGaFJnWlROKzQ0RkxoeS9Yd29FM3ph?=
 =?utf-8?B?VDRBeW5ZZWNka2o1aWhWTWJSYlpmTkR3UHBQdWdkb2VkT0VMaFloc3dPQTJX?=
 =?utf-8?B?MG1WMWV5d2luWHZsNjRvbUViRjR1eU5pNGVhQ1VkdXNjM05kbkhvUzlkRTlQ?=
 =?utf-8?B?SXZ2Yi9zZElZaEZaUWpCZ2FPb1pqMU9idWZHd3NFODZZVTkxVG9KUkkxVW5D?=
 =?utf-8?B?KzNMVkF2WkxqaEthT0s5OXpqSUlrYmJvRzNQdFZ2QTdMWWRlcm5rR1NZZk5I?=
 =?utf-8?B?YUtuUnNPcEJwMkFmSnNyVzVXUFV2L2VMb3RIREljYXRWQjEvODRvdjcyRnNw?=
 =?utf-8?B?WEs5MkprcFNacW9zSlZLOFF6RnFTZ0hzVWc0ZmlNYzJ2cFd6QU42bkN6UTB5?=
 =?utf-8?B?MU01MUlEZE5scThqT2pQeVJBd3pFNkZRUGZnb2dmYlFMRGhkbmhieVA1Zm8x?=
 =?utf-8?B?LzBqNXlkWWVDdURINGRKRHY2NGtWVStDTWZXazR2a05Pam5sa1pRUlBwT0pv?=
 =?utf-8?B?VjlkZmFsR3ROL2RJYmpmT0xFenMxN1N3QWpmK01FOVlodzhtdm0rNjBiVStL?=
 =?utf-8?B?ck11TXVKb2gzUmNUMXRYV3lNMmNHQzBnUllIZURhbllBdXQ4UW5zUmdvT2xS?=
 =?utf-8?B?NGFuMDRUcWhRNENSWUZaekFrUUpsSmw1T2lYb3RFWGJESWNMY2h1eU82MFFR?=
 =?utf-8?B?QUI2ZVB2d25qeVJOUXZwcVR4QU8rR3ZYaXNWazFCQnFRUE50MTNCeFUyeWw2?=
 =?utf-8?B?N0graWg3M0l0VTJqbUNoVkhDQXlBdjBSNU1nWmpuNVlZczNjRTZORUxoYXlV?=
 =?utf-8?B?b0dVYXdUUXFhSWZ0ZDB4bmw2cEVjYU80Q25wWXM4Z3djME1QeU1wWHVFT3FD?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f3323a-3040-4655-92f6-08de3c980326
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 11:41:11.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnZf7zBAhZ412JIT8sS89PTK0cMOO4TJ21vopw9+/kAi9OE1MRJfb6ZG07pRA9aNo4WzpssuT9k6RkdqLVkABA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10185

Not all users can or want to use the device with an iio-backend.
For these users, let the driver work in standalone mode, not coupled
to the backend or the services it provides.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 60fc3361b2689a4c38287c613ef93fe00338e5fa..37b8f88da6681d44f3fbbb6c8c171ae7117b9090 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -1000,6 +1000,9 @@ static int ad9467_update_scan_mode(struct iio_dev *indio_dev,
 	unsigned int c;
 	int ret;
 
+	if (!st->back)
+		return -EOPNOTSUPP;
+
 	for (c = 0; c < st->info->num_channels; c++) {
 		if (test_bit(c, scan_mask))
 			ret = iio_backend_chan_enable(st->back, c);
@@ -1066,6 +1069,7 @@ static int ad9467_iio_backend_get(struct ad9467_state *st)
 {
 	struct device *dev = &st->spi->dev;
 	struct device_node *__back;
+	unsigned int nr_nodes = 0;
 
 	st->back = devm_iio_backend_get(dev, NULL);
 	if (!IS_ERR(st->back))
@@ -1084,6 +1088,7 @@ static int ad9467_iio_backend_get(struct ad9467_state *st)
 	for_each_node_with_property(__back, "adi,adc-dev") {
 		struct device_node *__me;
 
+		nr_nodes++;
 		__me = of_parse_phandle(__back, "adi,adc-dev", 0);
 		if (!__me)
 			continue;
@@ -1100,6 +1105,10 @@ static int ad9467_iio_backend_get(struct ad9467_state *st)
 		return PTR_ERR_OR_ZERO(st->back);
 	}
 
+	st->back = NULL;
+	if (!nr_nodes)
+		return -ENOENT;
+
 	return -ENODEV;
 }
 
@@ -1294,8 +1303,8 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
 
 	debugfs_create_file("in_voltage_test_mode_available", 0400, d, st,
 			    &ad9467_test_mode_available_fops);
-
-	iio_backend_debugfs_add(st->back, indio_dev);
+	if (st->back)
+		iio_backend_debugfs_add(st->back, indio_dev);
 }
 
 static int ad9467_probe(struct spi_device *spi)
@@ -1352,21 +1361,25 @@ static int ad9467_probe(struct spi_device *spi)
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
 
+	/* Using a backend is optional */
 	ret = ad9467_iio_backend_get(st);
-	if (ret)
+	if (ret && ret != -ENOENT)
 		return ret;
 
-	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
-	if (ret)
-		return ret;
+	if (!ret) {
+		ret = devm_iio_backend_request_buffer(&spi->dev, st->back,
+						      indio_dev);
+		if (ret)
+			return ret;
 
-	ret = devm_iio_backend_enable(&spi->dev, st->back);
-	if (ret)
-		return ret;
+		ret = devm_iio_backend_enable(&spi->dev, st->back);
+		if (ret)
+			return ret;
 
-	ret = ad9467_calibrate(st);
-	if (ret)
-		return ret;
+		ret = ad9467_calibrate(st);
+		if (ret)
+			return ret;
+	}
 
 	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)

-- 
2.47.3


