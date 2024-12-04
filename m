Return-Path: <linux-iio+bounces-13080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F84C9E3644
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 10:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75AD3B2F481
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5F519F475;
	Wed,  4 Dec 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="lkKVrRY4"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011044.outbound.protection.outlook.com [52.101.125.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F671993BA;
	Wed,  4 Dec 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303389; cv=fail; b=tYQsl3KqqvKuxdIk6iSutoqoeV7SuJXnAs3JKMrBLKnVQKV6XM6A4QUCFftAzpqz6OvUXvgsTIRFVNUjKpfy4hY5J4ruvvn+uTCRb8c0UWdvPGx8WQ0ajTI0RnSnrJ8f0vCLbfp8WOI9Yx9Jo+O9XEZsA9ma6IYqaobKpghVGDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303389; c=relaxed/simple;
	bh=BjhN1maOv3NJbss6a497TAG9N4ssIuQE195bjuBPEGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e+uZ1D5BioycFujKjYk3175p+6n7gmU/3LuXgIEP1slanVan5oVVKol0W/8OImM7qBC7Jm3xL7XPEM8nEnTPyT/V1kB+KwzppZ5lDYphNZz3MtLQuc5tH3wuyXDv+kKEDiyEchyeAY4CmXXZu650NlHmYL/8J1Y1CWrf+Im339A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=lkKVrRY4; arc=fail smtp.client-ip=52.101.125.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOhyy0ifprq5GdsyCFeXbx0JONQrdT4mxx8jkwaq7I25XOxGizM2jGmJLrYOvmaUe5GVIK7kdiE51yggYBRxmiz+V2TTkqTnQkcJfPgWpZCOTJpbqG5QGWG1UpdIuEkHOCUy8OhgMVwzTOELKM1YvGtQU7jhy71YfXpxQ79VRhWmUFLR0RUX7KD70I7UHNHqvfFnvsmc5PsR9htZWygKFLIv3oxocGUb+xQpjnWCE+jKCuU9sJNUhQb4Xzqsl4u7Mu0ruXQPWqfRo8ygEV4VrI/ji3lucTnEddyaDXwjUc2AKicZGNXJnUVI0B/bPOvvpr/zEPVecnjTmWjRkInpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjhN1maOv3NJbss6a497TAG9N4ssIuQE195bjuBPEGc=;
 b=p/sG21rhf5kIXNJeodxlkW0UKfCLddNEJWRKLeB8X64lo4D8LdNklTpktxG6NUnt76Vt4Ti4WMOonYJA6YevFLh16HU1dWX6Svre3unTvoQ7EWB4IxNVrD3wSdAj8HHyUwud600iHE/zpS/UGY0cka3aVJvJz6ttHjudF+yRuNq2ycW4oiT4And3CitpKUsEJWFR0wAwV2j6+2EIRW7N1+lHO1APiHloOQrW0HSDPvmE7DA+BcsdL9FOHge961Pjr78fOk9LO5vJoxKu8FDJhF3q69syw5C+jXKtGZ13r9p7YfpqY0MYnsjaDhLFk3hDXiGrUs+ItWFBDICERx8kqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjhN1maOv3NJbss6a497TAG9N4ssIuQE195bjuBPEGc=;
 b=lkKVrRY4QB8CoJb4HgF45FRHX/5vbnwkeEZn5bklyWCalJ/nEFIhmEL2ULG/IDoAWPtfJZeD8FGPWSYjGocdTwZRmNHMG5DDwD729tLjN/W8yqFZ+HkeldXc4LbnXWCFQr32EUwEdMK1NnWHYxQ+Pmgf/E1mORh70dyVg29Wpyg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11870.jpnprd01.prod.outlook.com (2603:1096:604:239::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 09:09:42 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8207.014; Wed, 4 Dec 2024
 09:09:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Jonathan Cameron
	<jic23@kernel.org>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 07/14] iio: adc: rzg2l_adc: Enable runtime PM autosuspend
 support
Thread-Topic: [PATCH 07/14] iio: adc: rzg2l_adc: Enable runtime PM autosuspend
 support
Thread-Index: AQHbRYJ4hy3qT+91skeBlNwFnRUcbbLVwu2kgAAIMwA=
Date: Wed, 4 Dec 2024 09:09:41 +0000
Message-ID:
 <TY3PR01MB11346768FFC2040EC8131B02986372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
 <20241203111314.2420473-8-claudiu.beznea.uj@bp.renesas.com>
 <20241203200046.0dfb784a@jic23-huawei>
 <e05191b0-eb3b-472f-bd8f-9d9a28100d0a@tuxon.dev>
In-Reply-To: <e05191b0-eb3b-472f-bd8f-9d9a28100d0a@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11870:EE_
x-ms-office365-filtering-correlation-id: f41714d3-9ff4-4d3f-9f19-08dd14436372
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TTVST3JNazBWcEd2a3dialFrS2NpQWpYK3ROOFc0Z0pSb0JGZmlqMWxiMElL?=
 =?utf-8?B?NTRBSjhWUE96UzlNTS9CdmpZeTRwaUZJUjNNaVB1L3dKbUNHb0pSVytKWTRE?=
 =?utf-8?B?Tk9IenloMVFxVHI3Vm1mdm9RWWM3NlNrWnRWSzhzOUtDZU9TOFE1V01ra3RZ?=
 =?utf-8?B?YmJKU1JZWmJWSThyQ2R6Q0IycUtXaHhYWTAxcXpQY2VtMEQ0b1NTR00zMGFO?=
 =?utf-8?B?TjR0WkdTc2tzMTdjOC9ScWFyeTNrWWszSFpnS0RxaEt2ajVMZlVwSVFRZ1hJ?=
 =?utf-8?B?V1MrTlM3dTFUTzhrRkptZWVTRUlSNzVrK0g2UmkzTnFJdE15b21pRFBHMHlE?=
 =?utf-8?B?TVU0bGVxRy9waEZEYkt5emsyaXhmSk83SlV0NnNKZ3diREs4Wk5QZUFYTTU0?=
 =?utf-8?B?UmdZRUovZTVvczh0MHFCT2NFQVc2RjRZWVRuckpHVjRManVWTjNLZVY3VitT?=
 =?utf-8?B?dXlVOEo1Sk8wWk5hbzVIVVpDY3NtSVVNWmw3VVVoekVpNUcwenRLQzlBNDh4?=
 =?utf-8?B?MUM1U3RIOURUZDh1bzlFT3d1V0RCdjFFVzY0SmJwWDNzdHVKQVg5U1kzRXlv?=
 =?utf-8?B?bVE2N28rcDFtbE51ZDVvY25oWkxrVXF1andsMURvSVV0RmNRMW5pWXpuQTBj?=
 =?utf-8?B?a0gzVEJ1aVJHNlNSdzJQUFVDMkNxU25xem5vN1lZS1huNGcxeEVsTWNkNXFM?=
 =?utf-8?B?UlJXRGJSTzBlWWxiWHlMc2Y0QzhSajBNRUtUQUhibGxiSzk3clh0UUt2QTBv?=
 =?utf-8?B?ZERxbWNRaWI3cmZEa0tKM045cHgwSXBKZ1VWeGQwb0FxcnA1VnBWdUJ1OEFs?=
 =?utf-8?B?Z0JYcnhGNVdJako5YUc5RlRYSk9QNjBOa3JUQVNhZm1xSHlmYy9Kejd3Y0VM?=
 =?utf-8?B?UEVjUzBabWhHSGltZUdHbTJCVlh3bSsvK1puS1V6OWdRYTFmQUpPbndtTW4x?=
 =?utf-8?B?TlhpcElpZ0hXcXdvY2szbGI4QU54UjlTNVpneUFPL3BLY1hHYUlHR1J6MUR4?=
 =?utf-8?B?NFJhSnlwVHdGTUhDZGw1cTkrTFZkcG1ndXBTU2k5d2JPc0lUSS9xZUJqaG9h?=
 =?utf-8?B?Q2JuQ2ViR243UVlXampUVHBoUVMzZGNWSDJyMWluUnNPS2VBT1RQdjRXVHN6?=
 =?utf-8?B?K1ljNjVPQzJacWxYRTB0YUVXbExCRmdHRDNJeWppTkpnbnRPditJTmxlbmEz?=
 =?utf-8?B?ZlZSUjFNb0xQTkpnTDJNYmdvZFJkRW9aSHFQZVhRSFozZmNVYWJyMkcwYjBo?=
 =?utf-8?B?SHU5VnlqNkFORWFBTEZPMjBYNjhDam9MTUkxNnpITVlmeG5pMDRGcld1RjlW?=
 =?utf-8?B?NXYzQmJtMGNEcXJNTnBMUmI4bFY5aG5YeTAzaWVxZXZWQ3ZGTnJkM0FZV1hM?=
 =?utf-8?B?V01BZnkxTmJ2cWhmRmFUcWNrNXhqUHk2VEc4WnY2b01rSUpUQmFweWZmWm1h?=
 =?utf-8?B?TXRva2ZxZDg5WGdXVi9FOEtQekxFQlFVWE1UU1lhOG5BWkN1d3BQRzBwa0Yz?=
 =?utf-8?B?Ykt6ZTdsTTlIK2pkOE5MZFFUalBuUmxTRHpINTAxMUpiMGlkNm9jMVdqZElz?=
 =?utf-8?B?YXZjVGc1YmpTdDRkcFhXTWx3UlYrQ1ZOVG05T1hrV2F6Y2JicG96VCt6M2tU?=
 =?utf-8?B?WjF2SExpb2gzcG9CN3p2cHNRY01VSmQrZklHL05DZ1kyQlNjSHBQb0RIY2dW?=
 =?utf-8?B?YXhrUTFaLzlqY0RIVU1PN1dHNUhGQzNsamdhUEV0Vlo4Z0UvTW1KNmJ0dC80?=
 =?utf-8?B?aG1HMEh6R1YwbC9USTYyVnRVOUZHV1VEdEZJZUVFemlnZTlLN3JtK250S1Bx?=
 =?utf-8?B?eW5DNVlqMWlXYTUxRVNtUTJVUlpQSXJwcVdGaUdQSXZxWDRFSlVpeWs3TXcr?=
 =?utf-8?B?SDlZRjVHaFdFalIvU0dURXI0azRGbDhQQVhLbDVkV3EvTXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlJhMU5vaTJGNmZVU0R0SDNFQUdPdXVBUTB4K2l1R2RYcW93N3JCYk15dG5K?=
 =?utf-8?B?ckw2R29GRmpNMDFpVXd4SHhvajhYY2J6L3ZDazRPMzZMRFkzRTBpWjQveW5I?=
 =?utf-8?B?R2VkeDJ6cDhhaDZDOUFBc1F5NkFsTkNxcWQvZjJGbmZ2QVF0K2JFK3gwNmdN?=
 =?utf-8?B?b0RRSmpKZ0dkZHdLUGtJQ0tGaUpzZk9udkRMazNuWGJXQjI4Y1A4V2pxNjJB?=
 =?utf-8?B?bU5ZaFZGbWdtVy83dW5kZWMyRCtScGNZTHhXNzBIbEtDWWFPS3VqcXJiN2xn?=
 =?utf-8?B?YXZiUDVZRzRFczErRkNkMGE3UEFEUEtCZ21HcVpxdk9TSzNpVTZXQk9EN2tv?=
 =?utf-8?B?cEgxSG5NR0FtSlo3SytGd25oV3FTQldNWnhrZEIwVXFoVS80emVTQjdnek1N?=
 =?utf-8?B?VFk5VDlsbnA2emRmNGFEOExHRSt1V3Ixc0ttSmZYOU9qYlBmTjk3UFN6ZEJ6?=
 =?utf-8?B?amYvak9DWXNrREs1bVdhcVVxV2lKaktpalpBd2lFMjBCMyt1RTlJQXoyZEJK?=
 =?utf-8?B?TWpMdmRrRFNtdDl2NHg5SklFSzNWU09vVGNIdG5GWDR5QlRaSmlwMGRZb0gx?=
 =?utf-8?B?cEpob2RxZG1NOXk2bEpLc2NRbTdXcURBamRHTW9jYlduL2FZSFJ0RkRkeVVZ?=
 =?utf-8?B?T3hVS0N5V3VQdEUvM2VTc2p2RDZPRFZBdkNDMDVDUXRORVhqL2VnaythcmRk?=
 =?utf-8?B?V1FoNmtMdGtpQWFBdFpnU0w4RklUbUhEWmg5Y0Jrdm1BZEp0QXMzdFZ2REt2?=
 =?utf-8?B?VlZMRWhiMUJNM3F5VDZEOWg5cmhqdk9XU3ZJV2ZmSWZLeUU0MEFkVzEvaDBZ?=
 =?utf-8?B?bHNWYVZtZzhSUVpYLzBLWFB0TG5Sc2QvMUcrSGJvQk5LVm9tMWdITllCMkF1?=
 =?utf-8?B?Mnpnc3NiOEpUdEFKbnRtSUNrbHpockxrQUhsRmRtYnhiM3VBc2pzejNpUE1t?=
 =?utf-8?B?dENiOXRPa05VREo4dzJvaHQrWUEySGNCRjQzRVBWS2U1QjRNVFM0a1VTNlR1?=
 =?utf-8?B?SDJUcnN6Z29ZMFJqUTNqM2Q5VGwwRm1LWTF2MUhkbllBeGpxek9sRFpUNTJn?=
 =?utf-8?B?N3NIbys1V2lad0JCRlhRbGtseWJVZGYxMCsxUFBiSFpFTGNhRWdjRzc1NGhh?=
 =?utf-8?B?RWJkZi9LcUIvRjcvci9aa1cxV1crbUdlbUg0cmZlcHpMSHZ2WU4yaGNucUVH?=
 =?utf-8?B?YTgzQklLSy9iUUdmd0dENU00TlZkK09USnR6YVZ2T2owODdmMGpWb0lEUmI2?=
 =?utf-8?B?aGo1S1UyYS90eG8xZEM2bW5aWFVkSjF3ejlFS3g5VVJzeVN2ZkU0Qld4Y2ha?=
 =?utf-8?B?b21mcmJLUG45d1EwOHU4Wkd2YXlLZ3ZMYWVSMTV5cWFmMTFEOFNDUnJ0NTZH?=
 =?utf-8?B?aXo3bVJxY0ZIZ2RaUUFjTVkrdis3UmJsd2wrdGVUeEp4Q2pZbjVxV1pLWE8y?=
 =?utf-8?B?S3dVYWkzK0xXVEpiR0s2V0JNR2hSajJoaFRaVHVrbWROem1WMFh4b0wycnlt?=
 =?utf-8?B?cis3WHlTeThXZ1orV0ZIOC9tc2ROZGY0WUpiTFhYZDJHdk9NR212TjVNK2lV?=
 =?utf-8?B?Y2lBa0t3UjdkMytMSVp2VE9CdCt2by9HMlFteEJFOHptcDBvZ1gwVjM5eGRs?=
 =?utf-8?B?SjkrcEk1WFZZSWJDU3JzY2Q4Uk16amN2Sy9jZDF1L0xzb29aVm9sNnZZUjBq?=
 =?utf-8?B?Njc4QWp2L25yayt1ckVqd0NwTjNrWVhZSWlVcnJuU2g1NFgxdkRYOHA2Vytl?=
 =?utf-8?B?d29ReU5qaWJrSzd1OGFjR0hFVllreDl4MGZCR1krbzJYU2VuZmwwTzN3WnVr?=
 =?utf-8?B?NE9lckIwM3VZeWdWc3FrcURzVUtUQ29xbzlsSzhoMjAwRUdRMk5aUEhCM09F?=
 =?utf-8?B?WXl1Tk9TNUFpMDJOMmQ5bkJ3ajcxQXpDYjlWNkx6UFdJYTYybDBGR0tnQ2Zj?=
 =?utf-8?B?Sm9rS1hKSXROZVN5TXY3VWI4eWIvU0xKOEYvKzVvTW1pc2ZFSXZBY0RESmVo?=
 =?utf-8?B?OEtNMmppL1hMN1pENENPZ3JTc2V6dnplNG95WEI3OFVvU0RQMzRlVDZoQ3RG?=
 =?utf-8?B?WUJuRUFTZDduNFhEdzlUdEtaM1g0ejZDRFZ3ZXZDc3BJeERoYUJGTm9ERFZ1?=
 =?utf-8?B?ZFArL3JRcFUyWVYzSWZDZFVkOE9OLy9ZemFhek5ZUks1ZUc4a2lDSWorcUIr?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41714d3-9ff4-4d3f-9f19-08dd14436372
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 09:09:41.9961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 424VJgAhb5GGO7yJPjZ0ibug3hoFu89YaFbP7Heho2uHC37+W4zw2DhE1pJxAhkMcpR+Hij9/ZGFhAxFNk81b/g15V7aaZkj7BJr0f0If/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11870

SGkgQWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+IFNlbnQ6IDA0IERlY2VtYmVyIDIw
MjQgMDg6MzINCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwNy8xNF0gaWlvOiBhZGM6IHJ6ZzJsX2Fk
YzogRW5hYmxlIHJ1bnRpbWUgUE0gYXV0b3N1c3BlbmQgc3VwcG9ydA0KPiANCj4gSGksIEpvbmF0
aGFuLA0KPiANCj4gT24gMDMuMTIuMjAyNCAyMjowMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToN
Cj4gPiBPbiBUdWUsICAzIERlYyAyMDI0IDEzOjEzOjA3ICswMjAwDQo+ID4gQ2xhdWRpdSA8Y2xh
dWRpdS5iZXpuZWFAdHV4b24uZGV2PiB3cm90ZToNCj4gPg0KPiA+PiBGcm9tOiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+DQo+ID4+IEVuYWJs
ZSBydW50aW1lIFBNIGF1dG9zdXNwZW5kIHN1cHBvcnQgZm9yIHRoZSByemcybF9hZGMgZHJpdmVy
LiBXaXRoDQo+ID4+IHRoaXMgY2hhbmdlLCBjb25zZWN1dGl2ZSBjb252ZXJzaW9uIHJlcXVlc3Rz
IHdpbGwgbm8gbG9uZ2VyIGNhdXNlIHRoZQ0KPiA+PiBkZXZpY2UgdG8gYmUgcnVudGltZS1lbmFi
bGVkL2Rpc2FibGVkIGFmdGVyIGVhY2ggcmVxdWVzdC4gSW5zdGVhZCwNCj4gPj4gdGhlIGRldmlj
ZSB3aWxsIHRyYW5zaXRpb24gYmFzZWQgb24gdGhlIGRlbGF5IGNvbmZpZ3VyZWQgYnkgdGhlIHVz
ZXIuDQo+ID4+DQo+ID4+IFRoaXMgYXBwcm9hY2ggcmVkdWNlcyB0aGUgZnJlcXVlbmN5IG9mIGhh
cmR3YXJlIHJlZ2lzdGVyIGFjY2Vzcw0KPiA+PiBkdXJpbmcgcnVudGltZSBQTSBzdXNwZW5kL3Jl
c3VtZSBjeWNsZXMsIHRoZXJlYnkgc2F2aW5nIENQVSBjeWNsZXMuDQo+ID4+IFRoZSBkZWZhdWx0
IGF1dG9zdXNwZW5kIGRlbGF5IGlzIHNldCB0byB6ZXJvIHRvIG1haW50YWluIHRoZSBwcmV2aW91
cyBkcml2ZXIgYmVoYXZpb3IuDQo+ID4NCj4gPiBVbmxlc3MgeW91IGhhdmUgYSB3ZWlyZCB1c2Vy
IHdobyBpcyBwb2xsaW5nIHNsb3cgZW5vdWdoIHRvIG5vdCB0cmlnZ2VyDQo+ID4gYXV0b3N1c3Bl
bmQgd2l0aCBhIG5vbiB6ZXJvIHBlcmlvZCwgYnV0IGlzIHN0aWxsIHNhdmluZyBwb3dlciBJJ20g
bm90DQo+ID4gY29udmluY2VkIGFueW9uZSB3aWxsIG5vdGljZSBpZiB5b3UganVzdCBlbmFibGUg
dGhpcyBmb3IgYSBzZW5zaWJsZSBhdXRvc3VzcGVuZCBkZWxheS4NCj4gPiBUaGVyZSB3aWxsIG9m
IGNvdXJzZSBiZSBhIHNtYWxsIGluY3JlYXNlIGluIHBvd2VyIHVzYWdlIGZvciBlYWNoIHJlYWQN
Cj4gPiBidXQgaG9wZWZ1bGx5IHRoYXQgaXMgdHJpdmlhbC4NCj4gPg0KPiA+IFNvIEknZCBub3Qg
Z28gd2l0aCBhIGRlZmF1bHQgb2YgMCwgdGhvdWdoIHdoYXQgdmFsdWUgbWFrZXMgc2Vuc2UNCj4g
PiBkZXBlbmRzIG9uIHRoZSBsaWtlbHkgdXNlY2FzZSArIGhvdyBtdWNoIHBvd2VyIGlzIHNhdmVk
IGJ5IGdvaW5nIHRvIHNsZWVwLg0KPiA+DQo+ID4gSWYgeW91IHJlYWxseSB3YW50IHRvIGtlZXAg
MCBJIGRvbid0IG1pbmQgdGhhdCBtdWNoLCBqdXN0IHNlZW1zIG9kZCENCj4gDQo+IEkgYWdyZWUg
d2l0aCB5b3UuIEkgY2hvc2UgaXQgbGlrZSB0aGlzIGFzIEkgZ290IGludGVybmFsIHJlcXVlc3Qg
KG9uIG90aGVyIGRyaXZlcnMgZW5hYmxpbmcNCj4gYXV0b3N1c3BlbmQgc3VwcG9ydCkgdG8ga2Vl
cCB0aGUgcHJldmlvdXMgYmVoYXZpb3IgaW4gcGxhY2UuDQoNCg0KT24gSTJDIGRyaXZlciBhZnRl
ciBldmVyeSB0cmFuc2ZlciB3ZSB0dXJuIG9mZiB0aGUgY2xvY2tzIHRvIHNhdmUgcG93ZXIodHJh
bnNhY3Rpb24gYmFzZWQpLg0KDQpJZiB3ZSBpbnRyb2R1Y2UgYXV0b3N1cGVuZCB3aXRoIDEwMG1z
ZWMsIHdlIGFyZSBjb25zdW1pbmcgcG93ZXIgZm9yIDEwMG1zZWMuIFNvLCB0byBrZWVwDQpwcmV2
aW91cyBiZWhhdmlvdXIsIHdlIGFyZSBzZXR0aW5nIHRoZSB2YWx1ZSB0byAwLCB3aGVuIGF1dG8g
c3VzcGVuZCBmZWF0dXJlIGlzIGludHJvZHVjZWQgdGhlcmUuDQoNCkFEQyBjYXNlIG1heWJlIGRp
ZmZlcmVudCwgeW91IGNhbiBoYXZlIHNlbnNpYmxlIGRlbGF5IGJldHdlZW4gcmVhZGluZyB0aGUg
dGVtcGVyYXR1cmUvdm9sdGFnZQ0KYW5kIG5leHQgcmVxdWVzdCBhcyBpdCB1c2VzIHBvbGxpbmcu
DQoNCkNoZWVycywNCkJpanUNCg==

