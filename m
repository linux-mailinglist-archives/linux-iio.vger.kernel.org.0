Return-Path: <linux-iio+bounces-25049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3631BDAA6E
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CC43A72E5
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477E9302179;
	Tue, 14 Oct 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HdQjlS7C"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4ED19F48D;
	Tue, 14 Oct 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460025; cv=fail; b=fqLC1NOdcxRc2UYuUrZeeTGWUp+9VITDVW4IvrW2fRpXKarSRgYUf1hhBRabZfJqWfqKBWkNQmdzz0XZM0+N4IHzRa6xerTk/HTykRiKpyUCbHAqnJEXqY3rihZyzrrjL62ugqeGgej5DY4Jtv18BdsIdGqo96LMLKBIAXi6ibc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460025; c=relaxed/simple;
	bh=1+FyYD/7G1SBUqInsagfIhCxFAMMNm9XZUO5oN93A2s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TiMJoIJcDa07QWxYV9w1WiAUjRYR5fEjr5bO9ZNXprA8K+utvBUG6Epraw06TxWQxoQqiK75emJDQ2Hcz+ABMYVuu6y34gMuTGL+1KsjenngOB/WbmGf+LqJtYj6jXpZxCj/PWLFZWIL4SNBTDzT/tQNba/p/kg22h2tXPga8wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HdQjlS7C; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwQxHoXdmdU3jJuSv/sSagJEKLekG/GXE6n99BlATBIsWymRaedCAqs7qEQBXJF867u63E4Np7GQ7QCmF6F5H08uAm9AP0gaLw+Kk0579fnJzRnbDy2SayCwCSzVXbKzFMOtZGwIv9oMmwsKifhsS9wxOZkfb6mkKQ6CApf0/YT+Psu2H8MolyDfFTDc7+gymdK56aYdLQV/BpzdqXMCi4zsdKLX2QWc/CYUFQiJev98DGbtWCEwljDYq/k8af/Y8POblHZ/NCk13fpVm6NChx4++k9F53rJFDP1E/yczu32fFwHVsT1GxLasku8v/cOT1zk0vnfZsu/9gq37/D7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DB2Jh1jQ7EhxUSwaJfC4GG6WpAUHSuR6n3d+JGE3sRc=;
 b=ROS7qBcoO3c4fCOrfwDQNfT4GNVc+ENE02n8PaPbXbSPXGpWZIwKUYsJnzpDXFV3qNWvKK7Yt1gZyZWx3z+kMZFHJEgh5lVLcD/2PY+J5QKH19e2TXJ36KS1kl8cWKw32/3PmzLmdK19cgxOH8UtGpiwltFitV/S6IycXQX6WS9noD2uubyJ7OR7YU1kOcB0SqVdD1LCeRf+Z/23Rx9zIQ7rJpQvwekoM02A3dLN8JOEgk3CVmiZ3UGH9N+hp95NruzsQX8TmHxqyxp9nSbMV6sugzeRieGBODRO05rlW5Kg4iW7fMyazjbUbZF8DCFBfGlPotHGK6E5z+YkdQvaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DB2Jh1jQ7EhxUSwaJfC4GG6WpAUHSuR6n3d+JGE3sRc=;
 b=HdQjlS7COaHNJ5TYzLab48q1uL4g5BJRv8/Yf32pzkJ8LLQYCzSBcAqfaMt/eHtq7PN9a35TLTHoPow8GTva02JQeEMkCdeUiWnWkWj0/ymGwmH9HAfy76IeD9t0RoAJWMeeH8Z/O33EojH8hM90cOS/W3ysaHKmbS5rq0ZOCMLGR7xf60rvvhKRfDmoll1nUJkACRmo96OPdA0cQuE8ilqMR8jv0HGzW6qNb3ogpcydKLrUo83iVHiSJ5HHpOII68NnUgal8ywtQKoHhIZQ/Sa9+t/HSwGEcZRA5ZfYGzk+oqqHQrCjp1w77biAizMLhEvvL1da8FSaDNk+N69lvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10946.eurprd04.prod.outlook.com (2603:10a6:150:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 16:40:18 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:40:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 0/5] i3c: Add basic HDR mode support
Date: Tue, 14 Oct 2025 12:39:59 -0400
Message-Id: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN987mgC/3XMwW7CMAzG8VdBOS/IcZwm5cR7oGlKG3fksBalq
 AKhvvsMhwU27fhZ/v1vauaSeVa7zU0VXvKcp1FG87ZR/TGOn6xzkq0Q0IHBVmfbf6RUdGcchdC
 C4S4o+T4VHvLlUTq8yz7m+TyV6yO8mPv1b2MxGjRgiD66RBZpP15O2376UvfCglW1SFWhqCZgB
 O4sOo+vyj4pC1VZUV2DPvXIg/mt6EcZAF8VibJx4Ch35717Ve4f5UQRkQk0eI+Oq1rX9Rvse0h
 RdAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760460014; l=2717;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1+FyYD/7G1SBUqInsagfIhCxFAMMNm9XZUO5oN93A2s=;
 b=hjugAUzVd06zLlMf1+Qor8n7ekKu12hiCvpe1x/r+TAYRMOjYMT1ZSSYlpaCHci1LVpgJOH7U
 FLYNbaxZNO5AoijglDM+X+mSu0IHmoQdnPGZQIXaAD//zlUe+WRzf7X
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: 553e5867-3443-4bbd-1bb4-08de0b405c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak0vQ2JaUUlBMnNPdnB0TVRoVnZDVFdPcUZxYVNLd3VjNjhlTG12SXhCVDhw?=
 =?utf-8?B?Z2t4THhhb3A2SXJ4Q1VhbjNzVFI0S0I4dEwxVWllZklvS21lTVRiaXlsc21Q?=
 =?utf-8?B?bzJ4UVBsQi9zOVpsdU9HT2YwRWRjQkhSRjVxQlBkZzFHOW5EMEhFVTY5ZE02?=
 =?utf-8?B?TWw0Q1hKTFdaK0NRYW16bDdxNkV0V3QwaUVLNnVMZW1XUmc5RjRqWTkyN21o?=
 =?utf-8?B?VlczWFV1NW5ML0F0L2w2dlRaNVVoYnppd3oxUDhxcVdzL2J1SnN4WDJQTitS?=
 =?utf-8?B?MFJ1QkZuY1RxQlI5RXI2cTdjbnlxSU1YbXE1VHYrNStSYy9VWnBiaGRQbW8w?=
 =?utf-8?B?UTBYL2p0bFlWSlJsbTFSVjNnZUZKTEk4RVFWdDk3ajB2VTVKRUlyb2EyRXdY?=
 =?utf-8?B?L3JiT3g0LzdoREdSWmFBRXBBSmhiWEJsRUo4OVMxRUV2WG5YM0syN0J1Rmsr?=
 =?utf-8?B?TGcyT2ZZTmFMSXo0OCs3K2QrVXJ0OGlsM2R1eDFwclhpMWF1c2doQ25aNkZP?=
 =?utf-8?B?WGVTVFFFZmFENHM2bThXbHY5NmgyTmFpSDlaUU1TV3hUdGhyRzBYR3Mvejll?=
 =?utf-8?B?MXBkNUtWY2dDUGlxVHlUTGpJenU3NHNyeExVV1BHTjJpM1RnbnRYTW5oT3Q1?=
 =?utf-8?B?dlhRUWtDUENucjlOSHNsM29FcjYvTEJtQ2xTWTFqcXFDMVdEbkE3QUV1NUNU?=
 =?utf-8?B?bDhNRlFpQ1BWZmIxNktacnI4NWRlL2cxdCtiSjI0TW9keXZuZVk5bTlGMmxa?=
 =?utf-8?B?N080TzBvQzBQUWlNdk8yOTRnb1NXNlcyNmMwYUdJMTNrMm9CeGsxNGVmUTBP?=
 =?utf-8?B?dXdhS3B1QVE4WmZ5MXBvNG9qYTBHWVpMcVNMUFllUkhxRkt2cXVyWm4wZXhG?=
 =?utf-8?B?Tngxc1dWQXhvb0hlSTdvRnlGL3ZWUU1yZ2VFQTJFVEk5ZEpzTktKaTlreE5Q?=
 =?utf-8?B?c2RNWkpGVFVEc0ZRdlRlbHdyRG9pbG1SVENLQjBlc1BaRXFyNVkxT3pLdCtu?=
 =?utf-8?B?cXF4Nmw5R3F1bnFuWVBxOW5VOEp4cmhNcTlNR1I2RUdiVFlsREdFM1B3YXdz?=
 =?utf-8?B?RHllSXVZcHFwV3ZYeFR2QWZpUmY0US8wcjAzNUVwd0dVeTVxS01mQVN2QUFz?=
 =?utf-8?B?T1BkcG9KTEN1Nk8yZ21uS1Vtb1pGS1lWYkRyY255TzBYUUZUUnRwTVhjSW0v?=
 =?utf-8?B?TWxYeWtnaGt3Yk5XcnRBRXBCdFZ3bEE3OUZURndWM2VSOVBTOGJXSEdqd2h0?=
 =?utf-8?B?anB3MFVrTTVwUXNYcmY4aVpYWlFIZzNOdzJHMGs4RklYKzZuWnZCMW41Nmov?=
 =?utf-8?B?YzA3OW01T0l1LzE4aUR4OXp3dGZvejVDY3pycWV3QzZiSXpQS0ZvSmplc1Vz?=
 =?utf-8?B?YXV1NGdxYTErWXNlZEFnMkUwZmhtZ0ZXNk4yM1BrMGhkSURJS0Irc2ZwVG1D?=
 =?utf-8?B?QUNMZzAxS2JOYlVsVWpwL2JOVVc4SWlLcUdKZWx1WGxVMFNUclU5VENleHEy?=
 =?utf-8?B?Q2ZRK0hYb2VsSXlJUGdmcnBiQVIxdWF4cmM5bHNiaGtIZ2NvejRXVjkyUlp5?=
 =?utf-8?B?ME1haVh5dWpCWitpNTFsY0ZnNGxuK1NiRTJRSzNhcitublprSFNWdFVlQU9q?=
 =?utf-8?B?NjkrRDYrRHN1QWlXbUtkNGF2TXVLWWt5Vjh0QXlYc2ZtWXlkQzNTc2VpdHlX?=
 =?utf-8?B?ZG9ETkVaZGlGYkpRQTBmME1XMzJ6U0RFWk14MWljR0dvckpKYVJESzNHSkxy?=
 =?utf-8?B?cytGS3VUNEptN21odUxaZ0drQ3dtcWFMT25TR2R5YndSdi9SR1hoOEdXVXRB?=
 =?utf-8?B?NFE0dms2WXl4QmlIcGE1Y3RWRnFWTUtvYktZaXF1RmE1OFY1WXNJQzBnbUVp?=
 =?utf-8?B?TXNZbVFVUFdNRm1VRVVFb1I1VEZVUldiclNQWTJRQW4xK2dYbXh4dncwZCtL?=
 =?utf-8?B?WnEzVEN6c2RJekdyMnc5QURZdFFRL3M0S3ZrWlluQk1tTVQvT2Y4OVZyNlhy?=
 =?utf-8?B?WFRmTHZiUFpXdDFtaWd1WVk3UFB6VkRqVUQ0Mk5Uckt4aWl4ZlRJWFBUNHJM?=
 =?utf-8?Q?fGNoie?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUZ0ZFN5aGYrNFc4aTJEYmlaSWJXOER0U0JRYW9lNGN3YWZ3dldObEUxemZG?=
 =?utf-8?B?M3hQS1l2YjIxT1h1TlJnMU1CL1lkcmpvMU1QQktaTmNuU2VvZFloRVJZUVcw?=
 =?utf-8?B?dldVZjZnMmhRUnR3OVFCVWxZUXZNMlNFU01CV0N0NUxRN3N1dW51aWs3TjUr?=
 =?utf-8?B?dldDZ3k0QW9ZSmNKeXZ3TnpwRG5OZG5NSXJNKysxVXlua3lrelByRjVCM25L?=
 =?utf-8?B?d0RRckZxSTE5ckZCVUF3d3JGL2MxZTdEVllZOXdzdnpNczltQXVKbWZTVlJl?=
 =?utf-8?B?ejhRQmpPSE83SFpCL2R3TldYcVNOQSt5REF0Zityc3B1QjFUVXRxditzZ2VZ?=
 =?utf-8?B?WWxnVmZhalVQejNKNUI2SEpaZlE2Z2ZqbEFNeS9jbWFDb0pmWG9TUnVnVUI0?=
 =?utf-8?B?RThlaWRkcDlldGozRnJkb0xzVUdobDhrcDJxVXloNzREYTFZNE5ZYmVlb2cv?=
 =?utf-8?B?ZFl6TjNCaDJKbzdJMUZnSTdhYkRrNE9KTkluYVQ1Ni81WG5aNUtxeElvYzl1?=
 =?utf-8?B?bEtmSEVDd3VrNUlIT3h6eGlFaDk0UkY2MjIyVTZZbWJYZDFEN2JBa29Oc3RH?=
 =?utf-8?B?WDd4dm9JcE9LVTNDbTFHMW1ZRlRWY1F1VFFUOGMzSTIyZjdJakRyTFc4bktG?=
 =?utf-8?B?OXkvYWduZHM3WGhJRXV4YUFKYUl0d1N3OHluQVZnaG5XRzg3WmQzdFlaVGdR?=
 =?utf-8?B?cjhEb3hGTmZmN0xkSnhHTVY1MURPWEhLUzlKTXE2QXRodFd2ejB3aXdiZkE5?=
 =?utf-8?B?bkRqRmVJOUJ2ZXFDc0tKeWlmc0VHUDdrVFpPMElmcm5JZzZxL1UrMXZsLzJ5?=
 =?utf-8?B?Z0xZSHVlazFTNE1paElKd1p2OE5KZVlVMGdMbFhRa3VhUWlZZkJ4NklYdXRQ?=
 =?utf-8?B?clBnREhDb0x6V21RN2RkWVV2L2tGZnBPMkhYNWo2b05XbEVod3c5TTlqaVhI?=
 =?utf-8?B?eGJQSWtBazhreW9zOHBRaHU3UHN4MUZ3UjJvelFmNmtGTkwya2w3WnVpdHMy?=
 =?utf-8?B?SFdWK2ZxaGlxMy9BZllLdERsNnlIckRtNWwxU1lJR0VZN3QyQUF3Z0RxVU9z?=
 =?utf-8?B?bVhkTVJXT1kvbXdlejlZa2NjT3ZBZ1J4K2ZsT3lTV21yM3lBMDVvakhMRnZt?=
 =?utf-8?B?OVpnM011czVTZGNpdldnTWxacnB1ZWcwMHYrQ3c2eERCd040Qnk0SnpydDd5?=
 =?utf-8?B?SHJzMzBwVTkzaUdVd2ZYTW9BdzBUN09DcWpYYkw3dkVDUHZML2tyT3JYUWJJ?=
 =?utf-8?B?NEFiQ3FuOTZ4Tm1heXVIT0oxK2xJdm9PcUt1Mk1Qakt3WC9vRG5zdW9vUjVW?=
 =?utf-8?B?Q0JFUFBjNVJaZ1F5Q0NDdExjUzhDcHdCZDdFNGc5WkU5ODhiM2FJbm1lditt?=
 =?utf-8?B?ckhRdWZiYkY5QUpmUDF0Z3BzWCtIanhONmtKdzIrSkZCWEpIZ0VPUTFsb3Z0?=
 =?utf-8?B?TmxMblFoTDRnOWl0dTAwNlo1M3RKTnpxZXFFaHY5Y1I2L0tqOUdFL2xPbUhV?=
 =?utf-8?B?cXJxdUJFK0RBaE9Od2NTS1ljdjZjSWVZTmRCWU1BL3lVcGtxeHhiZkdDTVQz?=
 =?utf-8?B?b0UzbWtOaUJuNGExRkk1ZUJwTGV0bUtIWjlGRjlhMzIwcmhkMWZYc1JzV1BZ?=
 =?utf-8?B?OUorOEFGZ0FTYlc2dzhJN090T1pnNnlOU0VzaCt1Sm4vYWhURTJWV2NLR1Y2?=
 =?utf-8?B?cXVBcjE0RzVSWU94ZFkrWUdlNFIwRXpLL3N5cUZEMHN2TStvN3BkbjQ4R0NR?=
 =?utf-8?B?SmNxL2QyZWVDL3licjBiRjR3QzRkV2UyMzNYSkl0cW1WNXp4YU52NkxsU1Aw?=
 =?utf-8?B?VlpRdWNVV0hsUW9uSjVkTEw3RENLK1hiWVM2eVM0N09lWU91MFI5RGZrcnVP?=
 =?utf-8?B?ZE9tVHBCbGN3anpURVh0N1RGM1ZFaHdOc2x0Qkw5RUJtT0xqOWJLMlZsdWVr?=
 =?utf-8?B?bU9FV2ZybDQzalFxNHdOcVVSekVZem5oZG1NanR1dkw4U0pJNWlCa2wvK0Z4?=
 =?utf-8?B?Vit2bDVyQnBFL3NXWSswOVNZdFpyZW1JT2lBYWxlRUpjMW8yeU5HRUpOMzI3?=
 =?utf-8?B?RnBhWUZrMUpnVU9QZ3pScVZyZkswTmFPb2xrRDlkSURlQk93OVgwTUNVYnor?=
 =?utf-8?Q?o+Nw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553e5867-3443-4bbd-1bb4-08de0b405c20
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:40:18.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcasiEBLbadlZtfpZ3dBxSqghm6k9ak8Fik132ppxdaWraKKgRrkbHB+fvpRQmecGGyB/Mcogq36U2giH3nXXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10946

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
 drivers/i3c/master.c                               |  19 +-
 drivers/i3c/master/svc-i3c-master.c                |  96 +++-
 drivers/iio/magnetometer/Kconfig                   |  12 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/mmc5633.c                 | 571 +++++++++++++++++++++
 include/linux/i3c/device.h                         |  34 +-
 include/linux/i3c/master.h                         |   4 +
 10 files changed, 737 insertions(+), 37 deletions(-)
---
base-commit: 1e546ca7362028be9e96445645c95307f7092731
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


