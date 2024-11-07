Return-Path: <linux-iio+bounces-12012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292239C1234
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 00:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD9E284FFE
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 23:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4FE2194B3;
	Thu,  7 Nov 2024 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jfSHgzF5"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C714E218D61;
	Thu,  7 Nov 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020601; cv=fail; b=hj/k9GZ0sTIxNAz/Uypd5XUB1m5IPE3r14b5nE7BVIcV9RTeWmF9QgkqbVg3YW17ct28hCIHdZ2d3v4P1j6PdT0ESni3pYvitwlH3Z4OtA3o7/PgISi6UwS20soqMfPjhw9eEa75NI13KLJqf9h+jqKK9+a3w+9qCZPzfZyl1yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020601; c=relaxed/simple;
	bh=978YyUFOfnbYuHXbV4ZoywPThcziwlmR3i0UA2i1+ho=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XJWq/3rt80FmBhTBhYCY+T+suduELNwManCjUTZTsyjN4Bz+K0Ciw2P+X7bXJfxVz+GxfZEWSb3XV/Q7/WV3pHE8tzyIj0X2V5konU3vYZr5fTiMmZhEY/1FCHStvHV7ukezoA+Tn/tgI6HwEWyc8rR1N5QuqzgpKQcswO/QSR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jfSHgzF5; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vc9XREidsQAIEttceYlIGJpqO9B77lJJK6IoXgWQJSX2tmcajug5ZgYPx22PvvGhMQEo1M/RhKM2u1hyzjHQTPuRCYRdJH6P3bv93RvPwjBoC8LDz/64rJX1ZdddDZCkQL7uIR2/BGe5fpyLVuluTr7U1c7/X+1c9S6eIceK+/OAamSzdWEIfJBWgNRvvCI+1YmnGgJeZ5CsMwkdyl3qcKUqwwWFBID6c8o8nGb/eCAru2e3vv1N/StxcqOROHXyzxPwwTP0GJJiWXkGMnxfZtMG1FOYE2b04Nax09HYOg4XR91j4yA5auzcTPrTrwwevLe4WtBGj4knyTl7AD8rpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruhXI9BDcyEKJ61c1OlyrxwnIUQ4QtwbwselMQtOcBs=;
 b=RZW7VamlLzQhlnoMTHPX+wGaqApCjuKTJ5CmKcHeUOBdPOyegXPEw4sK0f2sZ4Cq4yFVq4NNTu9Ty+5Oijs1CftgHO65hIeJdB5t3p03cB8nBfhdLFGUeKUPZVMrsHv7OFAJ1LXsOy4f6vsNVIx+aoiSs4Tj/hDd6hkePszzGQuct0/iZ7FUdaMo3Ji8DBsVDrBMqiF9266rxn9puns0nf48tCQp1zo0u7D4/QC0J4t0jdCAgbGhpy4enICIkxRJ6gXiVKscVHTIXwKYc9nostJoi2wC06qMFUsJ8IE8OojzUlUEMPw1XqzAmiliyWEcz8q3n65GMnwtb0EFKaw/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruhXI9BDcyEKJ61c1OlyrxwnIUQ4QtwbwselMQtOcBs=;
 b=jfSHgzF5Kv1vhrZt7lXBMHHV/NkDDQfJZvCxXi/vXsQR96SrYR+3M6e4wCefe4gBNmsT0F/nQBdpomCDD3viU/fNYKt75i0dJ/C4YEqQfBp/0lFyu/w2/uPcSVKDIE0xDD22GvfOZMpCp0MyW3aYiB8Qlfph/r6rQxqMQ76QMHiyNbJQyE2fPRgYC94ZSqCan2p1y5+Z7Yw+E9p94HpvfzGJ7YQSWEq937HhMStSvFlLSuNl30sSi3+EoYQiHS/LybT2YduHFRZEBhFPp8VUH+3q1RUXWbNC2ABWKkI/+Oh9IL+iF+vjj1Xo9fgDx/2dO3i2JFolTCTmorqn83INYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 23:03:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 23:03:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Nov 2024 18:02:27 -0500
Subject: [PATCH 1/3] dt-bindings: trivial-devices: Add NXP P3T1085UK
 I3C/I2C temperature sensor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241107-p3t1085-v1-1-9a76cb85673f@nxp.com>
References: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
In-Reply-To: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731020590; l=1141;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=978YyUFOfnbYuHXbV4ZoywPThcziwlmR3i0UA2i1+ho=;
 b=ubJ0VjcmaW7PihPRWMxtJ73Mq9Mm5D7g1d2mSPGq/OnrtMGwJOruLgG2rXWArrrKx6zVGMSMV
 rLBHfj0/iKUCjnmJg5T51z7futni8GK7TOFQ/B29n3TxItag/cwqteA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 81daf812-fd40-4bc7-4a95-08dcff805dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmVNeUtzOFRBa1prZ0VVZEFONkJUeEkxWlZENVR3VUlUM2R3WE5USUVsc3Nk?=
 =?utf-8?B?MlVmcE01QmpKNDZoeHhXaEFQYXFoS0RqM3hoeWFwblkveVNrNWVwcE9yRmlN?=
 =?utf-8?B?YkdBRDFUN0VCWktuRWxGZlYwc1QwSnNvM3BjU281YTlodCtYRUhFc1g4YXZ6?=
 =?utf-8?B?V2F6MWlJVC9BV0lLdlNWQjRFSndCTHk0RXlIcnVFT2FpN2VsL29laDVCTE9L?=
 =?utf-8?B?OVptRVdPREoyNk9rQTd1NGlwZkw3VllJcE9xV3FmVkp0S3piTll4MHptN1Mz?=
 =?utf-8?B?SlJTR3g5cWNiK1hoSGUvcnR6WmIraTVIZUtsUDVBMTd3d3gvSE95Rk1qZ0w5?=
 =?utf-8?B?U2VUKzRHVGh5QlhDMndXRXd1MmdYd21lMEVwWXJEeWtNNFFtV1BVY25nYkJE?=
 =?utf-8?B?aTJzZGxDSEF5MTllRnpBNjFRc2xwZEVGZlZXN084eGY5S0t3QWRxcVB6SUNi?=
 =?utf-8?B?ajFobFM1VkFnU3AvMWZySk0vN0hLc0hSUFdZcllQdjlZUFZuOXUrdE9jeis4?=
 =?utf-8?B?dXRZaE1DdVFnR2U4NDAwbUJGMzNsL3oyRE9UR3pINk1NcURYQ0Q0ZXI0R0VU?=
 =?utf-8?B?ZGlEeWlUc3NMZGJYTHFXNGJ2UTV2ZXNETW5FQVd1Z2JUV0ZtRjQ1THUzMTlR?=
 =?utf-8?B?cSsyVlZ2NGF1RnpXd1JBKzhYV3JHRXNudUkwK0t6SjZ0SlBoeXlpVGY4ZWZE?=
 =?utf-8?B?SUd1VldiQXlPZ1FkVHpDYXMrNStYN2ZuT1ltZ3BqNnkyY0owbWhqaWt3S011?=
 =?utf-8?B?M0YzY0tuZFB2Uk9NU2JIeG4xUkNoVVl6NnJBR2tIdHloTjdBcytmZ3ZQOXVo?=
 =?utf-8?B?ZCsrTXhGY1J4L2JIUmswb0REcW9USEZQSGtCMWw4ZHV3OUx0Z3RHR1o4ZDND?=
 =?utf-8?B?eG1hYlU3dThuOWhua3JLUGIvWkVzTi9ucGUzUFRxZEdwejQ0NGthRnozZy9O?=
 =?utf-8?B?SHVySE5Yanl4ZkxYVEJQckZaUlMyZlNQUy8zd1o3STc3WG1OaURYY0dLVTBD?=
 =?utf-8?B?dUxnOUVsVU5NVFU1M21FTXpBUlhaZHY0UFhnSmllbEdrcnpXSUxBOGd1VDl6?=
 =?utf-8?B?SWJqTTh6eUdyOE1aVU53Q2xScVdQNWFMN29nT2NWb3M5Snp6SG1XUlZyYU5y?=
 =?utf-8?B?a3JtL29WRDE1Nmo5L1Z4anpIM1E3dmZ1dCtIbXNvT21MVjQvWFovZHA5b3Vz?=
 =?utf-8?B?THluU1lsdUZTZjZMbGlNVTdRbVhLSS9aUTdTaWlTcDZJMFRMYUYzL0tPTytu?=
 =?utf-8?B?SXNveEhBY0k1OXUybkxKT3BDbTJybk1aMzdabWdoTW1WQlJXT1BQMHBFUlZG?=
 =?utf-8?B?cyt3Vko3Y1lDcjI0Sk9KbmtjWFErc1B5c1JyZU9MOWpBeWVXTlVOMWc2TVFx?=
 =?utf-8?B?VU85bzNsckkvckdhZ0FIZzd1MlZTUWVuZXM2cFplbFhLdDlIaHdKTko5c3dj?=
 =?utf-8?B?bjZmcmdNcGp6bUVSNXdZS2pFZUVnMWZFNEhUT2dvZDM5VVRWWWl5RUhxZC8y?=
 =?utf-8?B?TmxyL0dpWmpVVit5aFIxdnFHb1ZzYWhodkdQeEo1aGw3Y2ZSVTA4bHdaSURl?=
 =?utf-8?B?TUZNNnRCNTQ3cTRmRXBrbnRxSDJUN3dJRGpOYi9reFFJWG0rNFVka2FZckpr?=
 =?utf-8?B?bXlpOUwrdFdlQVdRUkJFa1VyamhobVFxWjhsc0hjQkk4c3hYa3RDK2gwbkt1?=
 =?utf-8?B?KzV5TlhoeWZLNm5VUVZCR0hGMEl3c20wT1hYUDhxMGpSOW9kbUEzTjJBYmVv?=
 =?utf-8?B?YnRvcWF1OTY3cmViWnRKRmZPSGE1b0dlOTRXNnE5VHREZUcxREpPczZDeDlO?=
 =?utf-8?Q?LZFzOInyLuVanMLNcKZ1n6OI2EJfIM+my8GqM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFd5M3EwWFg3WFgzem12TGtZM2hQd0RMbVFadW8vUFd4RmNoZ0ZQMG1pdDlR?=
 =?utf-8?B?bG1oSzkzbkEwVjhzOGh1bCtDZURJZ1FmbVF2Vk1Qd2lZZTZGejZDdmJVZ0Ey?=
 =?utf-8?B?RTdIRVV1cEVHOTZMaTRabUt3ZVYzbHZaSW13aVNGNjNKYlJpZ0JhMSszaUdH?=
 =?utf-8?B?M2xQRUlCNUtiNnphem1ubDh6WE1reWNxbmRObWcxeURXL2VlSTlCNHR6cy9n?=
 =?utf-8?B?dkpLU0ZBQTdwSmRYTE9XR2tlVzd2RUlZZ0lkSWFDUThZYXdZWVphRmVnRnZq?=
 =?utf-8?B?emtqRzNoeXNVbVlSQU9LRFhHSm5Nb25HZ1VSOGJDa09jSk43MHNqZy91aXFj?=
 =?utf-8?B?bW45QjZ3dkN0YjdpZjRZdUhqYk16Q3ovSDJ5WkFsOCs3QU04NXUrQkNWbWQ0?=
 =?utf-8?B?SWJ3V0d6NklQS25FaFFubmhqZU8vc2l6eHYveUhPOE9LNmNGcFlPOC8zblN5?=
 =?utf-8?B?NGwwSnROQm5CNk1XbGZjZ2x4SVBBZG81WG05NitTNEIvMGFBQ1d2MEVUaFNM?=
 =?utf-8?B?OGIvUEJDaCtNaWJGbnY2MDI1K0FWRDVvTElNVnREYVJzc2tCaldhS0xSb1U3?=
 =?utf-8?B?Sy9zYmdhdkttTE5jcDY5NXk3dVJ6Um9pQ0dIYVVTZjVWSjRPRFJGRDZvaWps?=
 =?utf-8?B?S3FmU1Vnc0xHOFc2dTY3R2pSZS9uMXN0S2k5anFIcndyRlZjdTZnNkpjdUVS?=
 =?utf-8?B?R1VEbENVaXNjajFmMDJCVVdpRFAwSnhwc0wxbXJoNDBlVmNHRFdock15MHcy?=
 =?utf-8?B?T2NQN2M5UWxpWlZEVWMxK01JVDRIa1RwUm5NOU1SVHhFaXZKRGJFc3p2dUwv?=
 =?utf-8?B?ZnArcGlMK2lLR0RsUEFVa1I5UzJoQTdBcE4zMWg0UFQ4bjYwTDQ2djF1QitZ?=
 =?utf-8?B?Zk1tcENkZmh4ZWc3NDAwYkRkUENRRTJDR1BUT3FkVzZRaUZzRVBScmoxUUhv?=
 =?utf-8?B?dDFwMXY4a3V2S2NTNkk0TnZXeVVaYzByR1RINzd1VGMwR1pCbEJQdXFmVWxr?=
 =?utf-8?B?SVkvY3dBSGZreWRhZmhaK1NKWWRHZXdrdjVUUW4rVk1hTjB6d2dycSt4dmkz?=
 =?utf-8?B?S1daZzMyRUgrdGVUUVVtMU8xdlplVU5rRHRWYmRvUGczWTdLL2Nna0d0T1Vk?=
 =?utf-8?B?S1M4NlY5UEJwSlhNYTRveWgyVWpPYWpUSEQ2RVNNRXVmaXN4WFpvUGIxYStp?=
 =?utf-8?B?citiSVN0T2s3NTN5Z0M0ZW10TkFiaUFlbUNyZ05NbEpscDkxUmh5K3ZJK1l4?=
 =?utf-8?B?VFJ2dTF6MzlMdFluMDQ4bGVPcGxtRFQvWndienpXcFRuZHkzZEIyNFZ5NTNV?=
 =?utf-8?B?VHJvd3U5T0xzdFJHVnN5VWtKLytraUVpMEJyV0p4OUVpUzdEY0pVOCtaVTJH?=
 =?utf-8?B?V2ptMUhTVlEvY003SklKaUFYVURaMkVRVHJadWFNNXhhcDhMMEFLaStDWEVB?=
 =?utf-8?B?SmthT1BrM3dYMDl0bER5NEppK2RucXJOeVZXSmp5cFBybEdWdWllRjZPdXB3?=
 =?utf-8?B?QlF3aDdLaXJEYUJoek5kVFB0M2I2WlJZaUd0RW83OFJ3SExZcm5rTzcyN3Zk?=
 =?utf-8?B?a0ZPSlVKZ1BBYW9kZE9wcWQweE1TdnhEWVFEMTdFUEhnM1ZsNkNDTG90QUhK?=
 =?utf-8?B?bzZCRDBINWhvM1ZSSnBPSlBYU0JOVWs3R3ZxWHpCRVc3WWdpZXY0KzdwRlVD?=
 =?utf-8?B?Yk5qWThCek1UeUdCMXdjNk1NOFZZYWJyQk1Ma3RQNHFwWTE2WUExWEVaVW54?=
 =?utf-8?B?dEduck5GNXpnL3hWQlhDZDM5blprWk5neTkveDJaNGk4ZDlqMVYxMmZqdERw?=
 =?utf-8?B?RENxMWE4bGlnc0Z2cWxBUmlXcDFSamtlMmxxQUU4cHFGblB1YnBrUW9LOFI5?=
 =?utf-8?B?bTA2aTlNZE02MVMreHg1UnNvZEpKYkpJOXpCK1laN1dpRE5DNHlITnkzbFoy?=
 =?utf-8?B?V29ZRjBnOXVzRldDWHJ4M3c1MUZFTHpGalltbS9SNzBmN29mOXIvM2xqRDRw?=
 =?utf-8?B?RWNkMTk3eFRFVmYvNGxRQ2gxbWkxZGdwNjZaUXdTTFdMTks0V1Y5QmovZDVK?=
 =?utf-8?B?VldVSStvejFRTUoveXJRcTF1b3FtbmpCc2wvUktUNmc1U1ZOKzlpTkNDc0Zu?=
 =?utf-8?Q?ZUjHVQfJ8H8GvwCfhgK2tKahk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81daf812-fd40-4bc7-4a95-08dcff805dfd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 23:03:17.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFHwGZr2ZiKhUTmmSdwFsX0yifVOfB54g3dDA0/negr9hUcOJiO7kTUjzB4dgy6Cym9CeGfxUYU+LGpQecGcVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851

P3T1085UK is a temperature-to-digital converter with a -40 °C to +125 °C
range. The device can be communicated by a controller via the 2-wire serial
I3C (up to 12.5 MHz) and I2C (up to 3.4 MHz) interface.

Add it to trivial-devices.yaml because only one 'reg' and 'interrupts'
needs.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6ecd6432b021b..361943b3d73bc 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -301,6 +301,8 @@ properties:
           - national,lm92
             # Nuvoton Temperature Sensor
           - nuvoton,w83773g
+            # NXP I2C/I3C Temperature Sensor (-40 °C to +125 °C)
+          - nxp,p3t1085
             # OKI ML86V7667 video decoder
           - oki,ml86v7667
             # ON Semiconductor ADT7462 Temperature, Voltage Monitor and Fan Controller

-- 
2.34.1


