Return-Path: <linux-iio+bounces-25589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF5C153F3
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D11C4F140B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14DA33CE94;
	Tue, 28 Oct 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wwa2nopT"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1233CE84;
	Tue, 28 Oct 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662985; cv=fail; b=ivhIl4ohDUlXV8FwnHnZtcz0ZYmRD/tti6hOfDgYKkHOVkrAvAbLn7zf1Dxr8iOquGeiXgQCogP5UTtrT73XXLphMBakKK5s1pQ7SiUpXOKl5vGQKT+y92bwMC/RCY6WUVVwPwX6m/oy28W7uBo+T5LOAtScynl9jYGqgniWx4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662985; c=relaxed/simple;
	bh=IyO4gvDiMVkIrAv3wfTcayqnmwaqUsnJdgwnigkUdYg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MBOtdMGTh9Ttz7NjHfsNy8ecMlF8TeVOjoXVFntc5kdP4o9dYc2LiBWyhDzdNWCx+HMjqqsItAr/kRgL1BHHEi3hxYGf2oHXfl4dKDaNJp/Cu13FZ4MXulethtOWh6XXQlBQRAYb4M2TtT8ehSO0hiyoZRz5jBM5FNB7mIztBuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wwa2nopT; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6LGJjjb1OIQvlz+37KwuQxDGtODBzrEFXhbbA3JGim/sVJzyosIDRvCc0YBv6FA9ra48LAz7q0anpSxelk7Y99pinemZE980ug/XG8afg/Ubcxb/t2ZTUVPEUeXEUmvxgbgxQZ+s5cUPUxZY/D34PvS6pY3q3YbG7u2dpYQEV9ENZbwxt2EaqTBBflqX9z7ViOE4qEvTA3+P8C9+YNpEH/eyljAqS/6t8zDCyVlzbU7oaxzMemDT1nsc3l6pC0+r6H3At/UZwrDupl7q/MRCpVGrp9jepIcGe9G9cQ7XxFSRyx/Hves54bDJtGEydxmGEjutMXHQHzdmA0L8/7ALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/2t9xOxRR0k6wvZLNSCm6blXDZasSeQSURQqJNw5AE=;
 b=mYO+/oQTIFl0kinEgfkHI1z3xMuPP2t8Z4kHZ1MumKFqE6OLAwURtSO0w+2vU7RaMjT4gBlm1qUqxiiTPFW30QdK3ifZRdggwMae6d3jSIs/6kuDSdz6+cb/Iuy421SqlVVTPwt1WmXMhzaxeDa1P3HYogY8E4S2eg3veyshjql/VUGuXp9wvoqoLIlrVLDTvoFuavp1zvffZGONGagsidFcnZJNIYdIs5Xm2VnjVGIjYW701yV9JhIfEwZq5Bfw5IxqZh+ViEEjiIRKmJLcw5lORA9oyBGqzUUHgv4ex14V0/jEHsJGNyoTDjIwSNkZCWXPrGFC9MaZX7R11pwm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/2t9xOxRR0k6wvZLNSCm6blXDZasSeQSURQqJNw5AE=;
 b=Wwa2nopTM7mZbwx81dIWc78ncCv2sC/cIcJclSEkXVQ4Y+gmICKiFaaElqKKtxIxyfWZyYQL1pN9uFGYaHbK2Nx+xWJvgHYLWNxN3ba9xT6mGQRBhIACctRm4Ur7sCPeoL4Fo4HaW/MW5ydJAQm1M47+MQcqDChiWmlMyAbLWXtw7gC3haftvgtypRqvjYDH89bPJ7yR1u0oFzUKR2AP1Gcx4Oz6k/wmL8CsNmHagUf7NJdEeRpJtghvmYGskiw6D9SINbpOQbijARGZnJFSqjb1WhJmH5BRJt37s5n4tgUpJpBKIC9/8kMdEoT8vL096SZRbEzKE8m/elmOOXvt9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:49:36 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 14:49:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 10:49:01 -0400
Subject: [PATCH v8 5/6] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-i3c_ddr-v8-5-795ded2db8c2@nxp.com>
References: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
In-Reply-To: <20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761662950; l=1253;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IyO4gvDiMVkIrAv3wfTcayqnmwaqUsnJdgwnigkUdYg=;
 b=thpQucEtltU9hy4KRLEnUfVIuw9XlJEMNPvInOjc7Dkemx6gZCqx9B6neaiIuX743pHs9SqJ2
 wLhV75728EhBtqgwks64dYBqobgwPbtSOb01Cd6O97NA3/5BSEmLtHa
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b43af9f-b3af-4fa2-ce00-08de163136d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnpRSE5PekxneWYvU0E1SXBQRC92OGJ4VkdXUWNlV2lXVDVDT05PUXdxNXRj?=
 =?utf-8?B?aTJjc2Q5SzV1dGNhV0I4MmJoQzdDaHptY0N0RTBOZWtkN1pHY1NROGYvOUdP?=
 =?utf-8?B?S2xpVk16Q2pYUUZuTGxJd21Md1dOQlFiYjB6TGRNTnJObW52MXhzMW13K2xX?=
 =?utf-8?B?bmd2ejFCSmU0Z04xZzlZaFNSRExJa2ZYRm5jWHNMeXFWMk1lVm04WFk2Z0Uw?=
 =?utf-8?B?TGw0Qm8zSlYxS3lqNm5CNFk5U01uQ3NEYU5FdFVLVXhRYkN6N1hDSlJzbExX?=
 =?utf-8?B?aW9Ja254S0RTRkk1MHRtUXVyQ0dNN1lBRFRvMzZZRjhGb2xhTGd3Z0x5OWJr?=
 =?utf-8?B?d0xlUkJSY3QveXRoNVc0Q05ZV1RRNTd0dkJZTWtRS2lyYTQ0dEQ5ejBPSlJ1?=
 =?utf-8?B?Wkw0WDdUWWlWSVNGMVFzZGw4Vk56ZEdXZkVwUzI3QWk0bldrV21rSkNoK3h6?=
 =?utf-8?B?TERVMjJFZUpIOU9LaW9PUFhKTnNYc096cS96UHRNbUVlM3B0VVJEWmxVSnht?=
 =?utf-8?B?VmZlV3kzNHNFQ2xDazZoVGZhY2NKdTg3ckEvc1ZESkRRQmlrb012M3NJcjJ5?=
 =?utf-8?B?VTRkRFNtN3JSMm5YM3NJY3hJNU1VSEpCYlhOMG01V2JrbHhPcnhJRFMrUC9N?=
 =?utf-8?B?QS9XVUVBdzhmYWk3Y3dXb1Y5T3lraGhvTjhqend4ci9iWE5KQzFSc0VlQ0ow?=
 =?utf-8?B?NG9PcEE3MUZhcmprUmx5anY1ekQxSFlaTFlGVGJVZmtFcDJqKzQxS3U1RlY5?=
 =?utf-8?B?Nmtwa2NGRjNXRklERnJQQXFQVDdaVnNFRlF2cG1JRjZwRUgwZVNIcVMvZWZ3?=
 =?utf-8?B?VnVlZ3JIMVQycCtsbFZhSHRmL1d4eTdpMDl6RXdVaU1sOFAyRlBRaXpNMUl3?=
 =?utf-8?B?R3psdVQzUXlVMUVvbnloZDd5cXJ6RUNGVEY5WmtJQ3cyb1FibUt1Tm5qU0gy?=
 =?utf-8?B?L1d3ZEk1VlR6TkxEOXhUWkZJb2s3MGR1MmlxZ3dvd3dueEh2ZDh0UnAxZDFs?=
 =?utf-8?B?SDY1aFVpNUZkQnpMZUc2cm00OENYSmJZU3pscnNQTWlPUEpzME5qeEx3T3JZ?=
 =?utf-8?B?NVUrckxHbGJMTUFscC9tMUNFKzdFYXVKMmNkZ3lkVFZZL1ZKa1JlNTJRZnZR?=
 =?utf-8?B?VDA0eStiTk4wOUhwdjFhQXhlVWQ0NjBRbDlSc0lHL2pseDNFdjZQTTFQVGxZ?=
 =?utf-8?B?QjE4WWtMaWxFenllVDZxekZvRWN1ZlRHcHQxejUvUkc3VG9lREdESGc2RlZp?=
 =?utf-8?B?eTA1eUxBa1VCbVRIaTRKREhaTVpLWmhuOTdXczJ4em1ULzY1VmJ1bEFWMWFy?=
 =?utf-8?B?L1A3S01vU1dVU2lGSTV5azlvckFYSlhoWUxXdFdGT3VhVlFNVkRaOTMwdS9y?=
 =?utf-8?B?dHBIWlY4czlFZytQTmRHeTIyUUtuaGlqaUxMd0FldlVsVUhvM0x1NjBGSGdj?=
 =?utf-8?B?RlNOancrTnlXWGtVdHlLR3NrU1lMNXFwMWwrSHdKZk13bkViT3dlV2I5aHRU?=
 =?utf-8?B?VzF1eDBsa0xsdVpLeVRDbmpjeVVFTkE2NXduUDUwc2ZCcFNvU3pRd09PM2wv?=
 =?utf-8?B?WEVqcS92RnFRanpDcko5YW5KYU03L1dOaEZxS2ZXbkx3L0VCSkhkYWVtVHp2?=
 =?utf-8?B?RnFaNDdQcFpUV3FReTl4dXZYaUhFaTczUEdWbVcxWm1PYnVSZnpYSERyUkda?=
 =?utf-8?B?UjR6aUZEYnFPZXJ2MUo5c2FTcVZzVW1hQTQ1YXdjTVNlb2gza1pmUTZNb29B?=
 =?utf-8?B?dmxWa0JvTXhwcXhLT2t2QUNSVW1uNlc2c1ByK0JOWElQeGxpbXNtVExUcEkx?=
 =?utf-8?B?eVh3bSs5WmRzbm5kbWRRSjZGcXlZVElYenZqYlhsWXNqTDFFTW96dWthMm1n?=
 =?utf-8?B?ejQ0UjNTbThOVHlTRktoQ1Q4Zlo3YXdMSGg4dzV5N1dXUzhuK3EyOWtncXZM?=
 =?utf-8?B?KytvU0xENktxamlNaEJGVjFyMjJNdGVySFFlOVlQaEJvRUlKYzRqZnplZWkr?=
 =?utf-8?B?UUdqSUwyZW9iMHh4Tkd0K3VuYzBzMHNpaXg0MmdRVktkcTJ3Ni85MCs4c3pj?=
 =?utf-8?Q?vJ8I15?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE9OWkpqRWllcGh6cTNvU2xHVlZqb3pJbW94dHQyZmFkOHI1ZTlEUHlzQ0Z1?=
 =?utf-8?B?eUNJc0U1REJ6akVsMDNJaHNPQjNQRUVmVmdwQmNzYmxYaXVSYWQ1UXZPTFFl?=
 =?utf-8?B?TE93c0xCV3AwVmdYQm12YmpTWlBaTUlKMGJRU2owclNySlhwemVDUlJLMHg5?=
 =?utf-8?B?WFZOQUsvQzlyNmh1elNsZ2lTR3hLYW1QemtaT1Noa2lUZXBwb3ZFNzd1azlY?=
 =?utf-8?B?QzVUN0lkbjRrOW5SRitoNVhVZk14eFhpMVVtTjIvVmlRZFQyRUp5ZlBKVzhN?=
 =?utf-8?B?NWtsSkExMGJESCtCUGdIM3NpLzFERzVONkJsOEFTbi8xMjAxdkJDcENzUE03?=
 =?utf-8?B?aDBVQVFiRzE2OWhGSENFQlUwVXExQ0EwTHdoQUFyc3ZQZFY4ZTJ0cmR0WjVp?=
 =?utf-8?B?cDJGTHVIU3VMMFdOR3NlcWpWcmZ3c1lXeHIxSmZMQzhNNnBVNkxhR0FDVHQy?=
 =?utf-8?B?TC9NSFVCOGZZbm9zMlFreEhhZjEveG5JaEFyZFdYMURRTkhFdmt5TG9Bay84?=
 =?utf-8?B?WUExbC9XQnFUNjFBZE8wSUhvMDJ1bGpVYkhTYnN4RlNYZEE0ZUNkMmY4TVFO?=
 =?utf-8?B?Qkc3czZmeXkvZ1FLUDNNYlpjODM4dlgvUFhJV1Y5Qmh6aFJhRXhMM1VVVDUz?=
 =?utf-8?B?K2hjM0NNa3E4SDU3TmtST3paR1RuSGJpWTI0ZTBFY3l2cDI0aUhnZHdIcWVH?=
 =?utf-8?B?dXM3dC80dGFwckNRZVV2MjI1cHFaaEFvRlFPNkRPMUZ0VCs0STBzUWpxY0NX?=
 =?utf-8?B?RXJqeWZpUXIwNVB5dUQzd1ZFZ1p5YklucUhHR3JNdW9oQmdTR3JmWFg4UWE5?=
 =?utf-8?B?dE5mM3J4clhmTlBDTitOMitnTXoyUlhpUndzVnF1WXNvbDF3TlkvMTNMYTYv?=
 =?utf-8?B?RUFQS1VVUTgrR0lrQ1NoZG9uemo4UEJZNUJab1JpNlJCZFlZekxVcE9MS3lL?=
 =?utf-8?B?TG5Jck45M1BNZXBGTHhrZ3dIMUdaWTM3RUN1aFRnb3pkOHB4Y3IyWWppVjZE?=
 =?utf-8?B?RnVaei9XZENFN1BwbFZGMmpsazhXRURrbmljdk44Wks4M3FwSFo4NUM5eFZR?=
 =?utf-8?B?OVMweUNoamhkMHpmQTFyWjBTbDhrOFhUdXlWQVphYVpFQUUxV2FVMllidmxK?=
 =?utf-8?B?WTZELy8xV0FDdjhOQ3NsQVlOQkdCTXhEVVlkOThpQ3VCa1YyOTEwTWNwSTN5?=
 =?utf-8?B?bUNhWmFtaFVFNDVZd3hnL1V0RmZJYXhpYUh6aVlZR2h4bndlL0FIWGlUTDEy?=
 =?utf-8?B?YmVpTU5vcXBVU1d2Nno0UmlXZjQwQXpEN1FSVVZxdEtYeG1OcGpwQ1ZrTHRH?=
 =?utf-8?B?RC9RR3hlSm1QY3BtM09QaEFnK3o2S1phbWMzd1ZsL05LS1ZwWnhudFNwWHV1?=
 =?utf-8?B?UzFKMUpNNXpVTCtkUjJOQnhTY21NVWo0Mm9Ca2Q1RGNocjlZWlpINGZDS09Y?=
 =?utf-8?B?NGZVeUtlOGlIeUpVNWVQRTNtMytBcWxOOTRmcVBJR09kTW9zNzRCanpwMmpN?=
 =?utf-8?B?cVptSjVRcWN2VXdkK0p5MWlkaFgvY09yZHVwMklXUzVsbWtZVzU5OEpuV3BH?=
 =?utf-8?B?VXkvNFk1dUdQSnJuM3hodi9qRmtFS0NyK0RaMmErY0dSUmMySUJUeENKZ1JG?=
 =?utf-8?B?aytoMjFFdktvcFNlcEd4WUZRVTVlSVVCM2FZK1lMcDlpdnZiOW1MKzZjRVd2?=
 =?utf-8?B?ZFI3SVprWkk2S2Jnem1zQ01kdWVIdzZxM01FdUJZdG52NVo4c29YT0RCRlJr?=
 =?utf-8?B?WlhWS3dhV2xtNW5UaW40c2V6VjBnQm9QbmIrRU1ZZEpaTWZSWFlMOUxvbitB?=
 =?utf-8?B?aXlKdFA2QUgxL3lxTTNHdXRJRWRPT1lpVW5OVnVuOEw2WUNUSzhSQ0Fkelo4?=
 =?utf-8?B?QWxxd1d4c3A4K1I1YXdrYUlOQ08vcmNaTFJjMDg4QzZuUUdaZnJQeXczTjhh?=
 =?utf-8?B?OUU5ZE9JUGw4ZmNXcXJPMDd4M1JidytoRHVDOUY1RnZGdzRuWURvZmh3d0NS?=
 =?utf-8?B?L1pMbU1MOTJjWDlxNkRvN0tmUEd0LzFlcVUvams2bTN4Rzg2aDZtR1Q4V0hS?=
 =?utf-8?B?WFJ4UEloZDZmblVNYzN5d0gxczZQc2lyeUJsbEM1TVBYbVF1R0VGRUkwNDVD?=
 =?utf-8?Q?GQVS3PtLjxjk4WmoB6/opBQBp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b43af9f-b3af-4fa2-ce00-08de163136d0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:49:36.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsFU6qQlDHaGuN6T1PtKegi1ffIaPFC32zJfJO6vWUjjO8E10/C7+ry6h5hcJoHe+NT5FMywLLnqa9LmtO5l4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

Add compatible string 'memsic,mmc5603' and 'memsic,mmc5633' for
MEMSIC 3-axis magnetometer.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7
- none

Changes in v6:
- add Conor Dooley ack tag.

Changes in v5
- none

Changes in v4
- add memsic,mmc5603

Changes from v1 .. v3
- None
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2eff6f274302add1ef8f6ae9ec9672697bc812ea..94fc8ff4504b5dc2c0fd7b384f6acaae3d5f80a4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -227,6 +227,10 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
+            # MEMSIC 3-axis magnetometer
+          - memsic,mmc5603
+            # MEMSIC 3-axis magnetometer (Support I3C HDR)
+          - memsic,mmc5633
             # MEMSIC 3-axis accelerometer
           - memsic,mxc4005
             # MEMSIC 2-axis 8-bit digital accelerometer

-- 
2.34.1


