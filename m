Return-Path: <linux-iio+bounces-22610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4D8B2203C
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 10:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B11165DD0
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1842D6E6E;
	Tue, 12 Aug 2025 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FYNuhxfm"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BAC2DCF44;
	Tue, 12 Aug 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985942; cv=fail; b=A1i2WMoSjXD6fRe1ZdfTUV0OdHjEUVHelyF+RNjJorLHjZ0WvM0DnqvmlEpkrNplKFssM2JXKlOy+XGYHLmfTKUBxJyKRtBkGDUdUrwYssMNzecDF6Q9Vw9Mt1dPwndsaQFjHr6zGtWeIiFrtPe7aOpERBEjEzC5D4HAdlXK93s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985942; c=relaxed/simple;
	bh=KPXh7I3tBHiASF3Tj7lVPAfyDZcBnrLHYK0UAzxoNOg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=UpmjR9dds5fzyBs5FprELf2Nj0D5UQpD/LfJNPNj87kKnrk6qO1CgP0nBHVHeFKlRpwz12ZV7tOHjx8WrwaPKxGxow/8nYcO5sYrpKZMfZDEaJ0Ww0YxhEuAGKsf3jxtMCNufyt3U+RkScSsWn8jtnM9Yv6gdUdb/gjvuiZmrGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FYNuhxfm; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAwRcQGQ5kAUsCeFuCXTOamjiLcCr5j2nkU5mAmljTclnEx0e992c2IyqplTxFszdVFFpyWjm/EFJ3XuOrZ+s8Xa6QGtQ3ITqqSiOStAm+U66fgwi4iodwdWb/eOttr3SpDi2kdvVclH4ljctdsMe+RFqMpjtDP/3ryNz0DRY5dFQYPlrtgnsmUnlkBvpyUeR+rsKwEbxlgxbbI7lO/Sa5MDGe5PtzRGm8zk0pLVudUlcPNhh268kSbbVcJ+zucni++GR9m3/5et5AlvEwnOdUwVJmwtQR+6DBs8zzNyNGZd7fc3HRk6o4/8Q7p6uNCjM86CKzDidAKttnTH70wYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8kjeP1Y315we4HO1L60USysyc5o325vVN090wb89hg=;
 b=Ro9bulhRsoRTHMbuqX0ixHUqeDVz7wfapoiIoN1xX3lD5Z9qUykYckEqij2cNLiM03fbdgYv7HSw+efJ5WcPxzvwTQHhtt15mEA8foTB2FUnr1VJgb8nEhCoNER+bshde9y3Zd5YpfPb9hzVhzFvffiGlGG/e8tbozeRIZX9VLfuXCK3R7Ed+GgoxbX7pj/0bNQd4nHmB6yJ9iqtmaejGxOoxE7Hoem1761Qx+4KIcBOLbmyNG2uLOwwzQkWHouVu9LoUhG3UxTNEgwKeU/kmGzstl9/sjXOX7Oy94BJ0L+NVLe6xi/fBg3FLRjovN3HbbPruIGRUHNuGHy2L43FpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8kjeP1Y315we4HO1L60USysyc5o325vVN090wb89hg=;
 b=FYNuhxfmbNM/c/BmZx6eqivyedaiHAP6RfVYWrWmignLwARulrLMvIVYMJtUjKlz0cGuSrTq5hKL1Jr99dYUvshJ4MjIqcSBsVqnISE8mfIQdBpf8CdZ6sdQuBizH1kYo+X4mCu1gWjnA8bRNJ/Qh6h2QHASwtkE06BVPm+aN4RgOVZ3OOyeaRYP0mjhSIB0JZdkPYToefG+YWvBS+1/WMKRu0tGzryGJfqFe80+LgIG1rBRi6x2nkK430o5Mfsr00OGUZND3L98ZyoPg6pMMWpOup/q7qXOHihYDs7J4WO5KuLwc3//ioyAxEhKWinaSlwq1XC0EWFe9Eb16YIdBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA4PR04MB7984.eurprd04.prod.outlook.com (2603:10a6:102:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 08:05:35 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 08:05:35 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v2 0/2] Keep imx93 ADC works even calibration failed.
Date: Tue, 12 Aug 2025 16:04:21 +0800
Message-Id: <20250812-adc-v2-0-0260833f13b8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIX1mmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Mj3cSUZF0LY8tUE8sUU9OUREsloMqCotS0zAqwKdGxtbUAVzqADVU
 AAAA=
X-Change-ID: 20250812-adc-839e49d55da9
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, primoz.fiser@norik.com
Cc: linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754985925; l=1557;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=KPXh7I3tBHiASF3Tj7lVPAfyDZcBnrLHYK0UAzxoNOg=;
 b=fiwnurpNMTz3rI3EP2JfXt0kCcKPU1U7QAAVqtmJEgrdKEv1ITAXclpK627fNphxLn1QPLvfY
 FEJnwlAYQuiCLJ8DwnJbvZHSnfC8JmL8oRo/Xv37Se2W7UmwAH4J66d
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA4PR04MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 1145adc9-4cd7-48c1-5327-08ddd977043d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2R1QWZGd1JPOS9ncEgzOW1hNlNxRThjYi9VeHFCbDV2NGpIZXdwcWx2NC9Q?=
 =?utf-8?B?Z01pZ2JyV2ZRZHBZaEQyWlY1MWVZTi9QcGpnTlM2dENRVTFkUFpJNGxpTU5Z?=
 =?utf-8?B?Tk5jTFM3a1ZIQjQ1T1RvYytJN2hlVTQwWXh5bFRIYzJ5RnhMakdPMjNzSlZP?=
 =?utf-8?B?TkhBMS9JZXRuQ01ucFZ2RVE5RWs5Qml1VnJqeklzQ09Cb2JFdnl0cEJ2Z3No?=
 =?utf-8?B?U3k0T0lQUzJaK1h3eFI4R0kxcVZlb1pXNG5NWWYvd0pUN1ZmQUxzMXZmWVlC?=
 =?utf-8?B?NWhuMzdHODY5czBPVWhEalJmdVFSTTZVVkNCUlRQK2N2S0FZeXgxVUdYSDY1?=
 =?utf-8?B?N29KTy9sMGdHT3hXaHpmbk9YOThLYVhBY1F6RFVaVUJpYXZaNU5MME04UkVn?=
 =?utf-8?B?UE1jTWU5SFdrRStBMC9kSFFKdEtldmx5ZFM4dVpveWhQTEFxSEdmY2lRTjNi?=
 =?utf-8?B?VzYrZjlOK09jc2ovVUk1SjRPNHErVUlRZFY5OUlpeUxYbUdNSUpsUSt3Uy9o?=
 =?utf-8?B?VDJGd003WGNOclVhTFkxU2ZoaWZ6RmhySHltaXQ4NkVWVFZaVzlXd0JIbUs3?=
 =?utf-8?B?MFBLTmE0SUF0enRRZVRLRENhVUQ5U1J3aS9ydk9odTVRY3VvV0xBWWpoNTVv?=
 =?utf-8?B?Q1N4S0pRM2hWOFFUZk1DOUhmQjRtNXdGU0dSWWFmSHExL1hPTUVWeU5iditY?=
 =?utf-8?B?UW1GMVMvaUllWTVmb1VDUW5ucEpQVXg3OXVrYW9VQndMNXYxUGhqQURnanow?=
 =?utf-8?B?NzJjUXJpKzNDbkpaancycE5uZ1ROWHZrdzFoa3dHR0dKWTJpQVZhZm55em1o?=
 =?utf-8?B?MWQvaTFPSW50RGM2TGJId3NtUHpFQ0dYUkJWNlJ4Z3BMUVFXUkxvSVBOaWZs?=
 =?utf-8?B?VjJaZVprcEtFOFlVbW1laWdvNWhEcVFSQUJ3STVkV1FuRFBuYld1cXNCV2Nn?=
 =?utf-8?B?eUkyZ3R0SFRkVkJ0bzJERkRISjA0Y0UwOFJsTDNzdTlrZzA3c1dMaFZRbTJK?=
 =?utf-8?B?c3NpL3NNdGpSeWVtMXdESWdvcGhUbE5TNHpuYjlqMnFWK2RzS2cvUVVzOG9t?=
 =?utf-8?B?ay96M1I2dTRpZkxJdTZFTFJYZTRSWWpEODJiZTJPeGhJblF0NkoyclNkcHM4?=
 =?utf-8?B?MjVXeUVqbk56a05uUEJrL0lRVUZpV2JlQ0lmak1XMEFNL1RpVVk5TmtVNllH?=
 =?utf-8?B?RlFOSjJhLytNMFhITHFWL0tSQUZyTk4vdUFaNWtBREVxUDhPMC94N1R5ZmNl?=
 =?utf-8?B?RmdUK25xSFI5N2tMWUlHckVEWVp3MG1nNHVSUjVmV3p1cm1RSUxnVWYrTll0?=
 =?utf-8?B?RjFLbUZIaldJRTJ4TlhXYTVjbE1oeHFHSjF5dlE5dXVtUnNUazQxQ0RBOWY1?=
 =?utf-8?B?N0hPclFVSmFFUTBCcTRScHQwSksyMnJielVMbWxOTmNBaFpOZ3pUY0ZFOC9U?=
 =?utf-8?B?RjJzcm9adHZsbmRzT1JtZjIvbHVKckZtc2h1UjdJMVhWU2h4NWdBMlFFczRP?=
 =?utf-8?B?cmkrL1hMc1AwL1FQaXRyQ2xDak1XcGdKNHFXVGdtcndObWZDcGlMQ2JhVjZn?=
 =?utf-8?B?UDhpazF2T0ZoUFRrN3hHam9INmhmaFlnUzlpZWtYWW9qejRHQUh3bWNuZ21Q?=
 =?utf-8?B?anlOR3E3VXBVZlRUWVBobEs2ZWRsVnA3SnMrQll6MHlORUY0eU5HSE5obW1D?=
 =?utf-8?B?LzlMZm8vNG9GaUJmUmwzb00zNHNCRDFwRnVDU3FrVHR6cXIxZWF5akJIQnF0?=
 =?utf-8?B?M3ZBNk9IVlhOdGhNa08wVDQ5YmVMOHdNUnBjVFR4M0FnVGV1dDJDY2R3TjBo?=
 =?utf-8?B?VXc0YXl0VW4wUmxNR3I3NkJ3SFZuWGpYVEtxcDVmTWx4Uk1pRVJpWnpjR1Bv?=
 =?utf-8?B?OFZQVkl2OXB4SktjL3k3YTJZdTRkRVp2WlIwYjV6cllzTStsZkRkeXhrM2hi?=
 =?utf-8?B?QnNwQUhBU2tSK29XdGdQOWRCSWRhZ2VmZ2xFdUZrVTlqMU0ra0svTWZzZXFC?=
 =?utf-8?B?SXpkbjhmTkh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0tKeXoraXNubHpIemZSU3FENUZGSEh5UzlMRDY0K0hqSCtnZWRmeFZpTE5G?=
 =?utf-8?B?L0NDVXNIR0lWN2N5Ym16ZFBNaVFLOVR3eENIK2pZVXNiSXJkQzBuOVNLUU5Q?=
 =?utf-8?B?WkNjQS9Zcm1Fa0MxQ0J3a0JGQW5YZ3ZGcjE4VFBXV2EwTk9nNEJzcFAvMzUw?=
 =?utf-8?B?ZWZVUUtFeUFtTTJJYTgwRE9DQjBwV1dwVlZVc1B4WUU5eXRSMUI5dG4zOXlB?=
 =?utf-8?B?Q1pGME14SjBUc1czWUxPUlhKQ0xQcjMyVlNWMEhBVzROWjdsODRoaUNlbGpr?=
 =?utf-8?B?NFZQL0FkK3NqLzlWYTQ4Q210NE90dlUyU1piNytBNk1KRWt6TDJRZFFQVGs3?=
 =?utf-8?B?bUZIYmdlY1dBcDNuY0R5NGswZnEycmZBRVBGbXJ0MkdVb2N5S3hZc21LTVgx?=
 =?utf-8?B?QW1BaWdvUWF2bVg2V01lckNOMWRLc1RMcDBreFN6V3U2RWlUcE9rNFQwaVJB?=
 =?utf-8?B?VlhhcnltNVd2OEVsakZueitHaGJSSWwxcGo0MkpLb3lTZjRzcTZRUzNnOHdO?=
 =?utf-8?B?WVAwcnE0UXhoNkloVXhrMWxFRzJ2YUtSVGIwNEJ1NkIzaXFsRGdmOTNwOEJL?=
 =?utf-8?B?bHJVOUtwVXdwNFBtVTN5VjJLb3lPSklRd0tncHVJd01salF3dGN1N0NyQ0NL?=
 =?utf-8?B?QlV6WDM1VkM2eUhYNEV3ZDRhWUthRDJVUjljemQ3SFhPWmZZcDg2clBzc1pU?=
 =?utf-8?B?bFR2c2RIQTl5RnNXQzJGVVRCUHZjUlkrMVJxbC9mUVBxd3FWbk5pSDhvaHZG?=
 =?utf-8?B?TFNpdUhleG0xNnRrNERTV0ZycEQwa0ZXUGltSG1CRzVXY0hOTk5sbEJvOXln?=
 =?utf-8?B?dkw2MGVkbnlRYlltMklDZEdyeVVmZUIrdG5DRnppQXM4VFVFajJYSEpFMmZp?=
 =?utf-8?B?WWlzWjRHM3F5U3BlbEJxRC9EVW56a25HVUhLZW56SlFZcS9ZYy9XM1M1c2ti?=
 =?utf-8?B?NXdTOWMxSlBjQ1YvbnF4SmdKUERGWGZLSnRQVEZlY0VxeEMzQ1lMUW9QOWsy?=
 =?utf-8?B?eTg5QWdUazVGVzBRMVFiaWh5b1FGL3pYN0dDTkR5ZWFvUjZSUWhIaG1pWnYy?=
 =?utf-8?B?cUM0Mi9lVkJCVjZ5R3h1bHJsWEtteTFqQU9QUEZENnFVK2pKNkd3dWF2YWpu?=
 =?utf-8?B?Qis0bGNaejUwSkZNSU5LaElwc1REa0IyaUZxLzJwZXBzWS9GM08rZW5TUi9z?=
 =?utf-8?B?ZzdSVm5RdVNBQkg3OHFwL1E1N3E3LzdnaHkzTUhQRE90MTN2N2RDVWhTZWUz?=
 =?utf-8?B?STRYNktvUXQzZEE3SFNqaFUzaEZMVGxxeVZNSXZxT1RTOEgwbVhzd096QWg1?=
 =?utf-8?B?Sm1qdm1iUFlWZXVHbXdRV3VONCtIbTZ0em5hWWl2TnQyUmc5Nk4vSzBwRmJD?=
 =?utf-8?B?YXNzdzNYZEtFdVFza3hEeGRDQ3d3dklYY0NPT0lYcGdSUUlrWTlJTmNFMTRm?=
 =?utf-8?B?alNUbDJhUVIxeDRaMjZuSkJETUNMNjUrUG5LWVVpUGxBUHJTNXRpOXZFN2o0?=
 =?utf-8?B?ZmdCRzFBNkF5M0FqQ2pNbTJna1ZRR0dIYjZOZ2sxRWFCbk5kWnkwanB5Tk42?=
 =?utf-8?B?SVRMY01CbkxiRmdGTXZMQ2dPQzVuUXIyenhOSGVRL01WVEM1THNQNnR6WXZV?=
 =?utf-8?B?OTZYMHYwQkFlS1RaeHBQRFRVa2FGWU1Sdjk0SnQzdzBwWjJSaEFBM1FkYjcy?=
 =?utf-8?B?SWxBSDRUSUFibHRCbHg3UndGdFVWSzdxMGlxelhpdEhPNWZzMDRIeWRZRUM1?=
 =?utf-8?B?UWY2cTRDazJPdkFJUzVkYXJ4WlUzcU9rVk5RNEE4L1FuNEhySG5jcUljOTJ6?=
 =?utf-8?B?YU9KcHd5MXBVdE9VNGdRTDFpdW1zdVI5ck9iZDJMUXJobHppL2dBeEtvZFd6?=
 =?utf-8?B?Z0h2RHl3dThCN00rMU5VaElBeXR5dld0UlB2L2RZMUwrZ1RsMG8vMkhoaWVu?=
 =?utf-8?B?aUszTjVENis5RXYwT2c0a1ZJeUhJTDBhOFJlZ0pLMGY2bFY5aWxobkp5bUZ0?=
 =?utf-8?B?K1ZjVEpLdEErRGZRZXIzSm1WRUdnQmhOUjJHbDJ6WWhLTkdGbUcvalpVckVs?=
 =?utf-8?B?QXN5bWdnejhYZTJLeDhHR0Y3WjJqaUgyN0UybkRNbUxoVDZxWXhyTjAwZ3gx?=
 =?utf-8?Q?BrPpsO92131tsLGMws5QLrA4R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1145adc9-4cd7-48c1-5327-08ddd977043d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:05:35.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHiAaHc1kWRQLCBv0kPbhevzl1cC9ckXH1barNv/V6xli1tl3QTPnVkfaAPSTQQ8M2x0q27cQHB99LY8UX+sMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7984

imx93 ADC calibration has requirement for reference voltage:
  ADC reference voltage Noise < 1.8V * 1/2^ENOB

Some boards can't meet such requirement, ADC calibration failed on these
boards, and adc can't be used. This is not appropriate, board can't meet
this requirement do not means ADC can't work, just means ADC can't work
that accurate. Here add an optimization, keep adc works even calibration
failed.

Changes in V2:
- add patch 1 to keep one style of the hex values according to
  Andy Shevchenko's suggestion.
- keep {} when give the calibration failed warning log.

For the register 0x3A0, it is a new added register in latest imx93 RM,
please refer to this link:
https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-9-processors/i-mx-93-applications-processor-family-arm-cortex-a55-ml-acceleration-power-efficient-mpu:i.MX93

Patch v1 also pass test on one customer board, refer to this topic:
https://patchwork.kernel.org/project/linux-iio/patch/20250710073905.1105417-2-primoz.fiser@norik.com/

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Haibo Chen (2):
      iio: adc: imx93_adc: keep one style of the hex values
      iio: adc: imx93_adc: load calibrated values even calibration failed

 drivers/iio/adc/imx93_adc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)
---
base-commit: 2674d1eadaa2fd3a918dfcdb6d0bb49efe8a8bb9
change-id: 20250812-adc-839e49d55da9

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


