Return-Path: <linux-iio+bounces-12182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D49C5DC2
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92626281FA6
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C2E2076DA;
	Tue, 12 Nov 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m4W955na"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B792076B4;
	Tue, 12 Nov 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430344; cv=fail; b=eOFXRU++1yllpsHUMbtjjvac2WWVEIcBxSYCpgL2Dc6MJpxkyPaDZvnnLuWuH8j3rKSGrCLpa9ME/7w3dsANO7gmAEL0uNvr4+bebJJDrso2WTFBVTNHFKzH4ERLa+idyjzLfEDP4Ti8kaxQMiflq1Z4zN76H9S0WohatpkjYJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430344; c=relaxed/simple;
	bh=NLjq9yLNIMP9PSylIePrKvWOVpttIjtKVnzJh6J3noI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=oGtASZ14YUd/hNpNSSRbCbZpnZ5/jgh4hJbVbyZZsAkw6uKmXjXYZ989FS1s6K2KLcVg2HVr9UT5AWUNmurNiki/xdqogTBueGskV+ZuKRYu0p/JHb4DBX+1se0ZztYgVK5gwV/zBrrmVUHI49sNyUQt98lTRVpdkmqct8Vv41w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m4W955na; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqYnRbhjLfXswc/U0gkf/Ej+1KzVT6r4LVbJJA43YkZNUH1gVhaUzjJIi7rEfeYuHiRYehiSIDsqVFHxW1phbGzwuU8KrPTLc/XVfHSXVcoxc2V91VL5N5cY3u7W8DWxROEKLynDIH4/CqXKf/Xa3zMfcpwMzw2O0drmwA1FsyjlOFVPOTEDQ3txoER1Dd3UscViWLwczCZirfhbdJdINyhWFHE0sjBJki6SGRr/htvC1jg483x1ixf1dx8f3A8p4hBgWeHNbFfL9fPOBljKzpHx7BfxizzjKFsc0IYcx8Fat9Anqyv+IN+WsSX+/hCMcDVye5Iu3pt5x68fIZNiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQJWp+odirb1eo5VNqFHbxw4h3zqN1HGu+6IWZR3epk=;
 b=gUHdyp2umXWzSi3MBmGoIT6PEKHrhda53EKGxnHPNL3h+m4pr/NspQuoJiTC+A6y99WMtx1lUK/v+tDdbLiJuQOcFkxQqJN8AzpPhInkyrHVTkFxgHc4dB6sBdEgoQX59gyiW0aQjzQokGZuO5rkxj4cc5ldBdY5S0xoo7JpXtPwCNvjic6x7Hw/078eyz/sSFOBYWNoqCSQeqQT3r3ThUXp7dt/SyDDdt0K5ugoj3vqHOy7zh6G3bQrtRe2wG0KxXFK/GU/RDTz0yaL71MT1zFLqrUIKq1VJxbb6KDIjfS03QlNhEvgaAHBGww9hCxQZeQ+YlyHD+W+KimVGQGtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQJWp+odirb1eo5VNqFHbxw4h3zqN1HGu+6IWZR3epk=;
 b=m4W955na12Cos7v/D5iUM1d4rgRiOkz8xvndQ73FE5vZ/WLKMD4W9Y8cd4qxXeLZ/P8+96AxsccM9jACy/xhx8fJd/9DJbDMepgxMsE8BNUUnwN9Q2D6WBmdpaIAyJVCp1RGpNQyvDcglxd5dpjqHIjXSNTOJJREkZn0zKqodmzzsOR4heGUQeHaPy12PrmLrjCyW0y9seKT2ETyBxW0ENE3aMQC6pX2mZPZlrzUXet+fjXU6CIReLdlFdPNRC5llRrAUWSdg8pTPCANM0xn1uxyqr5z98q4oTuxS/UwSgJDdXH0G0aYUGlV2RD2j//TQiv1JPcbxbkNSA/7DWMukg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 16:52:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 16:52:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/3] hwmon: tmp108: Add support for P3T1085
Date: Tue, 12 Nov 2024 11:51:58 -0500
Message-Id: <20241112-p3t1085-v4-0-a1334314b1e6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK6HM2cC/2XMQQ6DIBCF4asY1qVhQAS66j2aLhChsqgSMMTGe
 PeiG226fJP5/gUlG71N6FYtKNrskx+HMupLhUyvh5fFvisbUUJrACJwYBMQybFrOyloY1pDLCr
 fIVrn5730eJbd+zSN8bOHM2zX/0YGTLDSolQkbwRz92EOVzO+0VbI9KzkoWhRjZZKEc2Vdd2vY
 icFcChWVOscB+CcaH1S67p+Aap8iewIAQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731430334; l=2055;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NLjq9yLNIMP9PSylIePrKvWOVpttIjtKVnzJh6J3noI=;
 b=11iyagOEabvUFe/y0D6dSyn/r8r7GXdoclapA1eVKhgoQONEDxCrNr8w+vHdD2gUGoEF/VbiE
 2XWAmnDcY/hDhFQTKEX+2jyNuI3yogtr/KHuHsbNlV4KJbU/tyg3LWz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7612785b-8b4c-40ee-fc8d-08dd033a5ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2hKcVZoVjhYRS80bWhIOVcxNFVaaUlpVytaTS9TRzVGZkpJM3RVVGdMQ2FV?=
 =?utf-8?B?aG1RRzhzZUk3SnQzSmxUbjd1ZWRWM3VhbW11Z292R25aNkY1bUtjRzRQRXJW?=
 =?utf-8?B?R3FRMU10RmtrNDdBUjBzTkNaTGl3ZnZaOFBibWNtT2gzSHZGUzhzc1dSUXJX?=
 =?utf-8?B?L2dGWVdOay9UNEhvdmpjUUVpdXI1cy83Q1Z2aG9ZOE5ZaVJVc0s4cWtYWDFu?=
 =?utf-8?B?WUgrWEVkWEc0RGVrdktGOElVczlSTjZEK0pqWUVQMFBNeWU5RFFPN05xM29n?=
 =?utf-8?B?WkZMT3M4VXFSWXhvOUZoUU9FTEFlbmlub21RbzdxRXZVS3lGaFNVUVowRGls?=
 =?utf-8?B?K1VmWlQ5V3d1QS9hYXpTRnpNakQvYWNFU1M4Vk5QUWFnbUVlU2dWU05SalZK?=
 =?utf-8?B?dDFMQ3FwaU9qT0liTmlIVnFKQXh0OEUrQzUzTmswK2FFVSsrMHFpdVlsYXJE?=
 =?utf-8?B?eko0WXJuM0ViZVErOGRQcEpvOVhVY0V6c3FsbWdkRjZLdXJYMWs0OCt4WDlM?=
 =?utf-8?B?OXZmaTRUTUN4OGNMaGZQeTNOQUlFRnJFdXJyNzkzZHkxYVg1T3ZLeitJMmNR?=
 =?utf-8?B?NkJIOEhxOUVUalpvRmNEeUV6b0V1dGtFVGJRMlhxSktrRk9PdjA1R25vNkFu?=
 =?utf-8?B?aURVeEVNUWhwSlRwRVM4TVZReTdkMmc5cGJ5SDJVczJDaXhOMXVTeWlLV1Qy?=
 =?utf-8?B?dktTMThUa2NHU1NpL3VqR29ybGp3WjN3N0Q1UWQrWEtYMTQwYVJQWVdiYjdN?=
 =?utf-8?B?bklMazdXYXdhenpCdE5iVFB6SENORW9XQ2UzS3JudDBJWUV2b1prcU9kOGZm?=
 =?utf-8?B?YmxCNW5VZ0xpQmlqaUJzOGdkaXBNREJFVFNXM3IzdUQ2QU10NFNBRHFWeFhl?=
 =?utf-8?B?RXc4VUxsQjVDbGJ4YklRQTlhOWFkUWl6eXhPQWMwZGszNHJUSTJjOWVxcXQx?=
 =?utf-8?B?OEhrNDRraVc3anEvNEpER2VnM29PN0x3bzhlcWtiR3N0OFpncG52U1J0Zlo3?=
 =?utf-8?B?NFRYbU9vN3hhUk9HbEU3cG5xekxaWXlqMC9oeGhldDEzelFwUnRDcWczR3NW?=
 =?utf-8?B?Z0JLbnZESWp3OHpTdEtRZndVU3k3dkNMYklGMGYwYzEwRURLV2hla3h0enhI?=
 =?utf-8?B?c3VjcUc0a0FWNktlMzRpMGNCVWErNXovR2RaVEhwaXBvazRzMEdjd0Z1K3I2?=
 =?utf-8?B?MUZQb3J3R21EeTlaZWE2T0RVVVFuU1lzWjFjd0VKYkc3cThCWnUyUy9aRGpV?=
 =?utf-8?B?UU15cmtmSmF2Tm1vSm84ZmRDZkw2Nm1SK3E4RjA0ZGhHTk5VRFRzWjQrR0JI?=
 =?utf-8?B?aFJ3TlBDdjV0QjBNWFlCTVRrU3hHQklaR3NvODlqLzFxZG9JUjhWM20yRlFz?=
 =?utf-8?B?eXkwMlp0UUNqT0xFdFpaRFVsOUplaXczZi93K1kwMnU0VEg2cGNIWVhNSzF4?=
 =?utf-8?B?c01HT0YvWnIrS1g0WmRoNk5OeS9ES1BrakJFbGw2eHRINUNReXh3Wk9qb3hB?=
 =?utf-8?B?a2RNdzV0OFJjdENKSHZ4WDVnNzdQYnl2SFZpU04zU0M1VklzVndrMm9lcVd1?=
 =?utf-8?B?aXFyMkRVNFdhWCtGSWpYcmU4ajdkNW55ZU5nN3c1SUFRR1pOV3Q4VHFXSEpI?=
 =?utf-8?B?UDNJKzZiSjlQM1VCUC9xaklCWXgwaTU1Q3d3Wk5ubkpjSXlFNkZUKzBpV3Ja?=
 =?utf-8?B?eGZQb3E2Y3lQZTJkQkMrTE9qa0psUzBvTGFiRnNCb0xXZlRIZ1ozdmg1aEVp?=
 =?utf-8?B?NHdaTGdUbmQ1MmthdEZrSnI4V1BRNG56aDlhNC9DNFFFbDYzR2pyNlRWVFRm?=
 =?utf-8?B?V2NCSDArcjNQbFRSU05BQ2NLa1ZDWUlTN2lxUkZTYzRaZEZnMUhSQUtLSmQr?=
 =?utf-8?B?UlBUNURYU1ZNdkNWeWsxUzd3djNlNjM1eFFIcG1oWlhwTVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWlDVHlBWmtwZFhUcWM3ZFJrR3FMQmFyNHExUU5kQU05RnFhaENCZDRYWTJh?=
 =?utf-8?B?RFl2bGlXeHlIU0VESTNGOXpLTm5nS2V0UkgyOUIzQllIMm1FMzk5M3VIbURs?=
 =?utf-8?B?WnFMM0txMkZWbTJrOTBvYVVsWFB4NHJoczdxeTVNM055dHdodWora2hFR2E2?=
 =?utf-8?B?c3czSzQxZGhCSndoRUx2STBQZjQ4M1l5Z0ljOHFjbG5kY1loSytUWW5aaGhi?=
 =?utf-8?B?RWNiRE4rR2cySEZOZ2Z2V3p0eGdseC92bmRpWW9FOEw4UndvcjJyVnBIaGVr?=
 =?utf-8?B?VEUreHg0TGpGSDZpUjBNa1h4RlFXWk5Cbi9XdC8vcS9oZzlaZGc5VTRKNVp1?=
 =?utf-8?B?ZzZ0a0VLcE9NOVdmMnc0U0FjRjJGSkpjSTByd1dlMzVLY2hKRVFJT3REMGx1?=
 =?utf-8?B?emtEK1FBLzhzUmtZNklid3BkQ1lsK2RlQTBKWlAyOGN4Qk9KZXI3dGhMVFVW?=
 =?utf-8?B?TnN2L0p5QTJqVG1sVkZnYmZacXJWbFkrZWdKd2syZmRGRzRzdlRJdld3MTJE?=
 =?utf-8?B?czRVaVUrN1J5QkZsNjNMR3RaeGVmTDNCYzZOZVkycHVBNEZPTVdMRUgrUlJR?=
 =?utf-8?B?L2JMV2hYSXh4WUl2YjR2aUV5RGtGM3I5VExLRkQxdUVKZDhIWVZsdHIwNzRU?=
 =?utf-8?B?NnJyM0RUb3BrN1pBUDRiSG16UWkrR1Y3WnV4NThBenFueEpkOE5McWF0aXA0?=
 =?utf-8?B?NGtBYSswaThHd000ZjFvZEx0SnNGRW9QRlBKZHIzdTY3OVRvdkNUUklKQ0Nv?=
 =?utf-8?B?ZlFKaStpWlhqMys1cmxoQXZLWUdMazFUSnJMbHEyZ2JCRDBvTk95bVM2OWJ6?=
 =?utf-8?B?c2pQTyt0MlIyUi9NZmlHTjdCZUYzTFh0L05sNmpFOGlCU29xUjJZWVN4eGVR?=
 =?utf-8?B?N0kyUzFTSU5uRkhoeisvYUdxMkY1bUlkeFNQb1ozNm9DRjhWaVl3eTNNN2RW?=
 =?utf-8?B?amNibThKc1Rpb1M0MzhrWUplblc1Mkw4QllYdnJZZHNNc3dPYy9JQmRkSjQw?=
 =?utf-8?B?V2pkMTFkRFIzOWZGYXcvWENEdTFHRUhqMGNXWDNtU21DVUpRRnhrWC9BLzN6?=
 =?utf-8?B?Qm1HdjVCUzJVTm9iVGcwcmoweHNXU0I5ZEtpS1h2Kzd0M0Z6Y1VCZkFrY3o3?=
 =?utf-8?B?QWczRmY2UWJLWTR4bTY0Z1FpV08xelJpZXAwOVJUSzhCZThMTGYrTVpzMmtO?=
 =?utf-8?B?RTNlc0NZOE5qbTR4ditBRUhCQmJZVURiSHQvblg1KzF0SFJrc2ZoaVVpTTVl?=
 =?utf-8?B?M1R2dXI4eEpUUFBoVTM5VEk4ZHByYTQ1bG5DeWhnQkhzY3NBY05Bb3lLQUZp?=
 =?utf-8?B?aUorcTRSdld3SURZMytoLzczYnhwUDlZTlZSNUp6d3FrZzZkaVNuckMyMHRr?=
 =?utf-8?B?MmsyOE5BRElsMytIWVYwNmpjWllGNW5sQWpsR3FiVm9UaG1pT0lnc0h3NTFG?=
 =?utf-8?B?WVIySU1McUViT1p3WGpDYVEzUk5IdHE3c2J6eG9qZ0RQaU5ZZ1VWUWVtSVgr?=
 =?utf-8?B?T3ZXZnVEZkhiUithRVdiMUhOeTNXaGZIQ3ZFOHlaNnhaU1loTytoK25yVjRx?=
 =?utf-8?B?V3ZRWm5BQWpPSXVnUDJUNE1EcFRabTMwNkhZeGZsdWpJTjZ3a1FoNHU1eS8v?=
 =?utf-8?B?S1dKWHo5b1VtaU1jVlpidTNtSm5tWm5TOGZvWXlLMm9ZV09VTXVYc1VDWjdu?=
 =?utf-8?B?NXVoc1JoN05meHdmcmRUb3lyMStnM2w4d1pIYTAvRThxNmNCT2ZzYzdXTmNy?=
 =?utf-8?B?YVFtZGxwY3JVanFLUm8ranlEZmR4VUd3N1FxNE56djhlL0dmd2tqelo1YzYz?=
 =?utf-8?B?bnhMclQ1R09xODdvN0pMcisxS1ZHVUpoNitRcTlWRmhwMzIvd1Q5b05aRG1Y?=
 =?utf-8?B?R0FiUmJySUhVSXdHMk1uRmxWNklNOE9QR2ErUVMrVGphdXdBbEhaTENxaTdh?=
 =?utf-8?B?UlFtdHJ3SmRIOUZjQjlIMU5rRWpmemdYbnVheU84SStJTDZkcDE2UWYzUm05?=
 =?utf-8?B?bklpVzg5NUp3dGQrUEJYblVBeGY0ZStHQldvMExQU2NtbEpBZjNKOFp2ajlH?=
 =?utf-8?B?UGpLbkZwVU9iRGNER3ZUNmVuckk3QktWNTQ5NzdvVXhVNDVNYlIxVThBVE1U?=
 =?utf-8?Q?RGE7wjYLqsmE6v4JmMBwRpnLj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7612785b-8b4c-40ee-fc8d-08dd033a5ea7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 16:52:18.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j48R29uLkUdAa79ppY4PS96jKHPPdbjYDxDmyTLt4LsN8oFxyMwKneObP5p6xnHXjGghmrTeuQ2IeV/Y71yQTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897

Add basic function support for P3T1085 temperature sensor.
- reuse tmp108 driver
- Update imx93-9x9-qsb.dts

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Jean Delvare <jdelvare@suse.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>

Changes in v4:
- remove first 2 patches, which already applied
- change to use module_i3c_i2c_driver
- Link to v3: https://lore.kernel.org/r/20241111-p3t1085-v3-0-bff511550aad@nxp.com

Changes in v3:
- Change cover letter subject
- Split compatible string change to a new patch
- Remove i3c/master.h
- Update document about p3t1085
- Link to v2: https://lore.kernel.org/r/20241108-p3t1085-v2-0-6a8990a59efd@nxp.com

Changes in v2:
- Amost rewrite and reuse existed TMP108 driver
- Link to v1: https://lore.kernel.org/r/20241107-p3t1085-v1-0-9a76cb85673f@nxp.com

---
Frank Li (3):
      hwmon: tmp108: Add helper function tmp108_common_probe() to prepare I3C support
      hwmon: tmp108: Add support for I3C device
      arm64: dts: imx93-9x9-qsb: add temp-sensor nxp,p3t1085

 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts |  5 ++
 drivers/hwmon/Kconfig                           |  1 +
 drivers/hwmon/tmp108.c                          | 74 ++++++++++++++++++-------
 3 files changed, 61 insertions(+), 19 deletions(-)
---
base-commit: f3272f4a58ea775b71067cf0f31e3e29f7fb19f5
change-id: 20241107-p3t1085-fbd8726cbc0e

Best regards,
---
Frank Li <Frank.Li@nxp.com>


