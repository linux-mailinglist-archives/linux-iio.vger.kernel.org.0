Return-Path: <linux-iio+bounces-11908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E5F9BC2EA
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 03:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA1A1C22080
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 02:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2963D3BB21;
	Tue,  5 Nov 2024 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WukvF/Mj"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66522B9B7;
	Tue,  5 Nov 2024 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772425; cv=fail; b=qgGZ4ug85yOg67Ke4RrziX2RJ9ZwDA3EI6IkGuNmzIos8gqgsG5XS3IKlJA62+UHaMlCnuIn6LokOyFdjECk/Q5RgfQGFiDW87Qc1f3DggV3i59b4Li0e3yEYojOP//K4B4PmzG9H5v8VKU0DqCfaVcpdbcuuPN64k9UG7V8SiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772425; c=relaxed/simple;
	bh=wr+efbJhnwmUasOaEsXuRXJMTD5IdbN2wjsNM0T8WHk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kQQeIIagKh+mmvDxS2NMpgNQtoYSzi+4olqFp5xdEOW19JVE1p818fwj6rYDph0PX2nyCEFvHs+wE9XtRWSsaykbqDM6rtzuIRIdgUDUn06oXMHmNf8LO1fzy9tOh7LYVdHPc1PC6/DVIcqW2oIyfNhdpvrKx70U7FdPXpVU1ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WukvF/Mj; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThAcwnO0+V4SpBMVUNPI14WnLI9/BUhl5yBhHHSWB+3q3N7KcnWRoQssgoy8fPZElgSaota9w+1KINAlNRX5xpf3GpVpohUOpiJESXUuyO2M2RgeHS5KOVVgllaOgn8j7YXiXYNNzCTOyTNTj9DUarMhXEUHQiQLoeQUvIuYk4kPlGDywCAwpV80C2nYrzloVM7PKJy73WBABUf6Gkx//JDwEcoqGt4+/Ueigk3Kh8N23jVcHPJuHy048shALVXvHT3MQVpxf89nCSUU23k8RT2nj34q7AGfaJ3uYxfSjRWYGFVj6G0v3QKQBH+9HQKYaLG/RA8rfhx7fZ8ERWx7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr+efbJhnwmUasOaEsXuRXJMTD5IdbN2wjsNM0T8WHk=;
 b=S0expp9XalC3khXKQtGFA6ocikXvvz26zNUd1j+ionm2kqx3YYblWVolZJi6dhWmSxA2t7ElvgeHRq1RRSP/fD7QqRI1DET2eXNFeQr8JHSxUE0PPCLC35BNsWvtxn6PxEpSa46ULXSHzS+CY2XG27X5Kbo7ql0CpotTRQUb84bApYxlvIGUHqhcGwC8LX78pkL6S9YLT9ZsR7TDdZ7TwP0SWG95KacRWKM03d9O7CDWxPk5ji0POpEcatMyg9nnP97MiUj4u2d5gIupHDsBLERWvOsmp/Z0weFkmt+Ojl28UgWzZ8CUi+MbEI1TWPKk2tFVF1muHmoVe4J+Q3nFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr+efbJhnwmUasOaEsXuRXJMTD5IdbN2wjsNM0T8WHk=;
 b=WukvF/Mjb4XKv4QYEq6bGeRgNHeYfR4yzM4TJqPnrAfOLKvj+TpCkAFF1AvsQZ2ahsw76dOn63oOYNTkdsxuZUCTRFq31OZVD9g8tj6te6D4zZ6il/g09lCI1kTxEN0Ey60f5AsMCGPgSF4zLFeMBAwZQrW3iSynlfPM341QK5WLgraSlDbCt/aBzKtsW6vJu1aTFt9rPK1XCTrIygCHhNv4mCBtzcLgxW9fz7gL5Xv0zzDTWdPfEcTpjepofWee0C2cNyDCxHBWt4ecBuvviPIzpa1K+XZBct04SwJKcYABP+lPaA+uF8CWzBjc0pxxDcMdAX8aA2h4g9f8FwDFhw==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU0PR04MB9323.eurprd04.prod.outlook.com (2603:10a6:10:356::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 02:07:00 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 02:07:00 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Frank Li <frank.li@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, "open list:NXP i.MX 7D/6SX/6UL/93 AND
 VF610 ADC DRIVER" <linux-iio@vger.kernel.org>, "open list:NXP i.MX
 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <imx@lists.linux.dev>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] iio: adc: vf610_adc: use devm_* and dev_err_probe()
 to simple code
Thread-Topic: [PATCH 1/2] iio: adc: vf610_adc: use devm_* and dev_err_probe()
 to simple code
Thread-Index: AQHbLw79xOfNYQuPiE6PFTIBVh4rTbKn8Ifg
Date: Tue, 5 Nov 2024 02:07:00 +0000
Message-ID:
 <DU0PR04MB9496EBA07807C2AE4097ADFA90522@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20241104231200.2745342-1-Frank.Li@nxp.com>
In-Reply-To: <20241104231200.2745342-1-Frank.Li@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DU0PR04MB9323:EE_
x-ms-office365-filtering-correlation-id: e7e5ebec-d93a-48c6-3e25-08dcfd3e88e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?QzFETXpZUDMva1NQSTRFN2kzcnN1b21XT2d3dE12bW53ajhib0NxMm1iU1Z1?=
 =?gb2312?B?RTY2dkJETVArT1pNY2NIRWtodC9nNE82UTBhRXhpVGoyZmRJUXV0RklUTnF2?=
 =?gb2312?B?Qmxmbktjd05PcThwNDJGa3BlaEhnUklGYlNHcFF0YVJTcWw4bm5EQmZNOVFO?=
 =?gb2312?B?M0pTV3Q0YWpHaHRRS0lwSTRrb0tUdHpaL3hCY3BBYngyL2lJTlNJT3JNZ0ww?=
 =?gb2312?B?TWI3cEVxc2NNTzM2VEFFdFpWMU1sdFdBbVROdTc2bXV1NFhUeFdDVWhoSlND?=
 =?gb2312?B?S3UvVjBrY2EzNGdXbjhXd3VvOTJremRLOWkrTDNNNFFoTldKNHFLRFVKUTBW?=
 =?gb2312?B?UzJaNG1JeENOSGwvcitNMlZiV1JyeFMrYlQxVWRiWnNmeHd2MnpLZ2dpQ1Az?=
 =?gb2312?B?L3NVSzZ4MGdYNkh4dVZjeWhVNmxvR25NdlN3S1ZXY1JjQnBuM2tmbDNCVDNo?=
 =?gb2312?B?MkRjSXFDTjZyYTU5K0hha3FKS3R3TGRJbUpGMGorRGJ5LzA2TTdkMGNRZDA5?=
 =?gb2312?B?UDJrK0xMeGVvYmxLS3V4TGd2OGdhbGZIaitKTnNtSmFseEo1Nk5PNC8rRjBj?=
 =?gb2312?B?VG9aZ2dRY0htU2F4aitpWVkvL0NYcGt6SDVUY3VtYnEyVEVrMVYyNCtOVWht?=
 =?gb2312?B?TEZBUUZwaVVCVkJUQmxGSGZ0d0N2ZVZjbmZTaTNVN2dMZmEzdUl0M1RLcVBl?=
 =?gb2312?B?WEFFeVp6YlNQMEhGSVRRQSszaVFsOFJJdVkva3F3R0ZiNjM5YUFQZDlhRlE1?=
 =?gb2312?B?MHB4UnF0VWIxTXVjLzUzSDRCbGx1UEIxSHBpeGJzTTJzTWpmVlpjWkc0Nno4?=
 =?gb2312?B?UTZPWnI2NFdid2VyQWhweFpXOU5ZREJubkU3SWNIYU9aRXlBb3QvVnZrZmdl?=
 =?gb2312?B?TG1ZUzRnTlNzOG1qek05UTcvWkN6VUpUYmpJYWwrYSs4L255QVZvSVBpbVoy?=
 =?gb2312?B?YVo2WWhyeEN5Mnh0QVpmQWZFVU83OUhPckVhV3pqYkNlbmpXQ0tXcjZhSnhQ?=
 =?gb2312?B?aW40aHpCdnI4Qzkza09HVlNnTUc0ODcvV0NncHpqTzBnWmxiTXFDcjdCckM3?=
 =?gb2312?B?bU5pOE1TV29BU29QdW50WGNsV2NCY2RUMnhrWkJST2JpTElvVHhwRHpxR1g1?=
 =?gb2312?B?dHU4NDdiNTRqUU13U3NVRHlBa1VWNEJVWERBNGZ6U2FvZ2xhaklTeXNnOXlD?=
 =?gb2312?B?TUJPRDNZRU1SeUdaZ0tTUWJ4UGhyRUFjdkc1a3NyVVZFUTIwQ1dKeDRBVm5X?=
 =?gb2312?B?ZWZLMDlzYUJmeUN4eVdDbXdDQ2tIbmppRGtmaWk2bFVyTDFPWHRvU05OR2FD?=
 =?gb2312?B?SW9FTXRFclEvTkNyWkloVHI4RkNzS1hhS21jNkFBQTQ0ZmZqOXBNRDFhbFdI?=
 =?gb2312?B?WTdIcGpvWlpOaytneVZqTUNpVzZRMGN0bGVQVEVIQ0wzODhvTTY0LzJabkRB?=
 =?gb2312?B?c0xIc1ZlWmhRQUYvSlgwL0xQYW9GOGM2eG1SQ01JNXVqRFJxMU5kd0UrK3RB?=
 =?gb2312?B?NmVIUFo1VDl0M3B0MHdxN1pVVEtaYnVGRGVYSjFrbXgrTktjL1Q3elZMam1I?=
 =?gb2312?B?TWNWM1VhMGVOcHZBNWVvc1hSRVoxNEQ4NzZwcFlFWEphVXZsc2pUQnNLdXJO?=
 =?gb2312?B?cUhJYUpYd1h3QmlJOGt4b0xiREwzV1RlV2xzejJQSWI3bGhXS1U1L2pkR3Y3?=
 =?gb2312?B?T0ZWYld2NTkrYTJRNDZVRW9MbHFWbW9YTVVmWCtYOXR6UXhITGJ4SDNyeGxx?=
 =?gb2312?B?OFY3UThrSDFDRWVTRDFjSUs3Yi9EdFJsWW50azJkMXQ1S0J3NkpXVDJXTjZO?=
 =?gb2312?Q?7Fs48cnsTvX8xpk9OP+M931BTfICiu99Xue4s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZzhPR2llSkFld2N4a1Y3NjcyZHM0dmlrQkpCVEVnbC94b1dsc2dtM250RFJa?=
 =?gb2312?B?Qldtc05ScEtYN0JpdHhvZFh4Ly9lN0VLVjYxcE5SZVlqUmpSM29Hb011QjNI?=
 =?gb2312?B?OERUTXpqQkp1M3BUUUdSRWh4aDFGcno4aUZOSnJKa2JLTWt0YUJqU0pQTlp4?=
 =?gb2312?B?ZXBsaDZQK1p2aWxUQWJSaERYU3VQdC83L3J1RGRpalBlSUd3OVhraFM4dHM3?=
 =?gb2312?B?d1ZBUmM3cjdnZTMwcjlrYTMzUkNhTHY4My91U3JiSTdYaU53bHdZU3FDWEwr?=
 =?gb2312?B?OWhwckxnMXczeWp4K0ZHUEZwKy9DRDZWemtkY2FvSWVsbXVuWHJkaUVIbklz?=
 =?gb2312?B?Smh5L0s3VFBYdjdjMGZ3ZjlUaVp3WHorMUZXTzlxSzREWVBlOXk1Wm5JY0Zt?=
 =?gb2312?B?SmlSZ0NOaTJqdks4OFJkaFV6RC8wMmdZVFovNEl6Vm5UWVNDUjJtTnhmMUpN?=
 =?gb2312?B?aHFJbFppenpZOHZDU1dIaVY3Yi9ocDFXUUV5NEFsc2xlREdSK2dFZHoybkR5?=
 =?gb2312?B?ZTh0dUQzOEtJMFVyRlkyNzlXWTR1aURzeDArM2VFM05WbFBVaWp5a2xlNDJD?=
 =?gb2312?B?VEM2RUhNVXhVS0F1WUJsL3NBT3UzWTVSVWQvQTVmNjQ1bDN1Zm1UazJwSzd0?=
 =?gb2312?B?MlZod3ZxRWo2N1ZsOS90U2k0ZVVKTGJ0eDhQd0U5QnRibk9sdkd4Yk8rbkRJ?=
 =?gb2312?B?L3FSMnpyc1V2L2ZVVFNkMnBYbjRldHRNQVZGS2ZtODQ3VDZvQnNyZytsUDZp?=
 =?gb2312?B?U0JxT1h0SEo1ejZtR1A0b3MrbVZ0Q0F0ZVYwd0FUbnIwZHZ5QnJoZXVuY2hX?=
 =?gb2312?B?REdWSGVaVlQ5b3ZxUzZENUFpTm8xVlhvU3FUYXIwZEsxeTJ2Y1NodDVDT05r?=
 =?gb2312?B?andOMGtpNk5Ec2tDY0IyUTNvbXo0S0lqeHRCWGs3Z1dzMnZpOGFWQndKclFw?=
 =?gb2312?B?aUllUEw1bjJ0Z1BES203SDJLcXU2UDBYTGVuc050Ujl4NGFUNllPWTltN0FF?=
 =?gb2312?B?V3hoQ1pVSHloaFBhdFhrcmdnaUg5T014TXNJWGZQZEt0eGxYNmFlVHFrRzhM?=
 =?gb2312?B?UUxRbHFhVTlQT0xDZXQvTGFTUE9WSUM0UjlrcmNSWWp2VnBNM3dQcHBNWlY2?=
 =?gb2312?B?bEJKOGxuUlBQMVVSZnV4aUtiOWw4V2ZadXl2bndVNmltMlZzY250R1VqWjFw?=
 =?gb2312?B?L2FndjltNHBPVHp5dXl5WCtWVzBZanVtNFVmcGtDRWlKZlF4UzdvOGtNZDNT?=
 =?gb2312?B?V0NaY2dRc0ZoWU5CKzJRVHpUYkVrTzd4cUQxL1pMZUxvd0JqcDQvRzQxSFRu?=
 =?gb2312?B?aEdkczdQQnRGdW8wRytFWGcxL0pCRWs0V3BvUXUzL3kyeDNQbGIwZGZuYUVX?=
 =?gb2312?B?cjVEOFhMNExzMnRGUlIzYWJIZWF0dEMySDYxLysxOSs3OVg2ckhnMTdzK24y?=
 =?gb2312?B?c3YzeXYwOENnd3BBcDFOSWFQZG9oMkl0SW44NHhnU2dmVHhBVFVkN0FZVXNT?=
 =?gb2312?B?ckZKRTFEOWpKYnZJSlluSGl6UGI0a0hiK1locTFhZHJaSkljRnNhRFRvZFJv?=
 =?gb2312?B?VVlZcWg5NTcxRXdtK1FXSzVSb1NxRmlvOU1mZ0EvOEh5L3piN0g4ejRwYmNh?=
 =?gb2312?B?Z0M4eVlGWElENlluNnBBNXhHNWp5ZVI3MUVFcjZzdExUR011dGRNM3RaQXIx?=
 =?gb2312?B?N3Fmb1dwWGRsNmJuT3pEYWdhY1BoajNUdENzaTJRYWNFdm1pSHhWQ1hVWis4?=
 =?gb2312?B?clYwVUN1WkYweUVsUjR0d1owVUozeVNhc244UFNpUjVTMkJZbzhZKzNCRTBW?=
 =?gb2312?B?MzBYQm4zQ0RZSDJJWk1BaG5ESVZCVVhobHh5U1Q1bng4N0ZhSjNSeW1FMjgz?=
 =?gb2312?B?S3o3Tnp6TjIzSHRQZlBqVnJrL05JN1UyVFE0T0JJSVdGSUY3Tjg5S1Nhc3JJ?=
 =?gb2312?B?d29JVGhsbVVaTWtTRkZJS25xbk5ZbldVQndKbWZEdHBsM3ZRaitaOVIzQ3FF?=
 =?gb2312?B?VXdTRTR3NVFJZXNTNmxMaHhIMDRQbzQyYWZJUlpIcDJ3WWVRZmVzNjBONWRy?=
 =?gb2312?B?RHRZdzFWaFE0OGVHUXl2cWNGWHNLWHprVWxZRTBIZG05VTNuTG9yK2RzQ0RR?=
 =?gb2312?Q?+hi8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e5ebec-d93a-48c6-3e25-08dcfd3e88e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 02:07:00.6330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xs6y+MhHvDnEjMLHz3O5uzBzkiZBo3oDo5cWusx0y22jCLSJQ8BGuz8G0+/GwuX+3/tBTWRO/oSbc29C68MCVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9323

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTHUwjXI1SA3OjEyDQo+IFRvOiBCb3VnaCBDaGVuIDxo
YWliby5jaGVuQG54cC5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqaWMyM0BrZXJuZWwub3Jn
PjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBvcGVuIGxpc3Q6TlhQIGku
TVgNCj4gN0QvNlNYLzZVTC85MyBBTkQgVkY2MTAgQURDIERSSVZFUiA8bGludXgtaWlvQHZnZXIu
a2VybmVsLm9yZz47IG9wZW4NCj4gbGlzdDpOWFAgaS5NWCA3RC82U1gvNlVMLzkzIEFORCBWRjYx
MCBBREMgRFJJVkVSIDxpbXhAbGlzdHMubGludXguZGV2PjsNCj4gb3BlbiBsaXN0IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBpaW86IGFkYzog
dmY2MTBfYWRjOiB1c2UgZGV2bV8qIGFuZCBkZXZfZXJyX3Byb2JlKCkgdG8NCj4gc2ltcGxlIGNv
ZGUNCj4gDQo+IFVzZSBkZXZtXyogYW5kIGRldl9lcnJfcHJvYmUoKSBzaW1wbGlmeSBwcm9iZSBm
dW5jdGlvbiBhbmQgcmVtb3ZlDQo+IHZmNjEwX2FkY19yZW1vdmUoKS4NCg0KUmV2aWV3ZWQtYnk6
IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBD
aGVuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMgfCA3NyArKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygr
KSwgNTggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL3Zm
NjEwX2FkYy5jIGIvZHJpdmVycy9paW8vYWRjL3ZmNjEwX2FkYy5jIGluZGV4DQo+IDRkODNjMTI5
NzVjNTMuLjRlNzM3YjE5M2MwMTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy92ZjYx
MF9hZGMuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvdmY2MTBfYWRjLmMNCj4gQEAgLTgyMywx
MCArODIzLDggQEAgc3RhdGljIGludCB2ZjYxMF9hZGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldikNCj4gIAlpbnQgcmV0Ow0KPiANCj4gIAlpbmRpb19kZXYgPSBkZXZtX2lp
b19kZXZpY2VfYWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKHN0cnVjdCB2ZjYxMF9hZGMpKTsNCj4g
LQlpZiAoIWluZGlvX2Rldikgew0KPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgYWxs
b2NhdGluZyBpaW8gZGV2aWNlXG4iKTsNCj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+IC0JfQ0KPiAr
CWlmICghaW5kaW9fZGV2KQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCAt
RU5PTUVNLCAiRmFpbGVkIGFsbG9jYXRpbmcgaWlvDQo+ICtkZXZpY2VcbiIpOw0KPiANCj4gIAlp
bmZvID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gIAlpbmZvLT5kZXYgPSAmcGRldi0+ZGV2Ow0K
PiBAQCAtODQyLDI3ICs4NDAsMjIgQEAgc3RhdGljIGludCB2ZjYxMF9hZGNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAlyZXQgPSBkZXZtX3JlcXVlc3RfaXJxKGlu
Zm8tPmRldiwgaXJxLA0KPiAgCQkJCXZmNjEwX2FkY19pc3IsIDAsDQo+ICAJCQkJZGV2X25hbWUo
JnBkZXYtPmRldiksIGluZGlvX2Rldik7DQo+IC0JaWYgKHJldCA8IDApIHsNCj4gLQkJZGV2X2Vy
cigmcGRldi0+ZGV2LCAiZmFpbGVkIHJlcXVlc3RpbmcgaXJxLCBpcnEgPSAlZFxuIiwgaXJxKTsN
Cj4gLQkJcmV0dXJuIHJldDsNCj4gLQl9DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCWRldl9lcnJf
cHJvYmUoJnBkZXYtPmRldiwgcmV0LCAiZmFpbGVkIHJlcXVlc3RpbmcgaXJxLCBpcnEgPSAlZFxu
IiwNCj4gK2lycSk7DQo+IA0KPiAtCWluZm8tPmNsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2
LCAiYWRjIik7DQo+IC0JaWYgKElTX0VSUihpbmZvLT5jbGspKSB7DQo+IC0JCWRldl9lcnIoJnBk
ZXYtPmRldiwgImZhaWxlZCBnZXR0aW5nIGNsb2NrLCBlcnIgPSAlbGRcbiIsDQo+IC0JCQkJCQlQ
VFJfRVJSKGluZm8tPmNsaykpOw0KPiAtCQlyZXR1cm4gUFRSX0VSUihpbmZvLT5jbGspOw0KPiAt
CX0NCj4gKwlpbmZvLT5jbGsgPSBkZXZtX2Nsa19nZXRfZW5hYmxlZCgmcGRldi0+ZGV2LCAiYWRj
Iik7DQo+ICsJaWYgKElTX0VSUihpbmZvLT5jbGspKQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9i
ZSgmcGRldi0+ZGV2LCBQVFJfRVJSKGluZm8tPmNsayksDQo+ICsJCQkJICAgICAiZmFpbGVkIGdl
dHRpbmcgY2xvY2ssIGVyciA9ICVsZFxuIiwNCj4gKwkJCQkgICAgIFBUUl9FUlIoaW5mby0+Y2xr
KSk7DQo+IA0KPiAgCWluZm8tPnZyZWYgPSBkZXZtX3JlZ3VsYXRvcl9nZXQoJnBkZXYtPmRldiwg
InZyZWYiKTsNCj4gIAlpZiAoSVNfRVJSKGluZm8tPnZyZWYpKQ0KPiAgCQlyZXR1cm4gUFRSX0VS
UihpbmZvLT52cmVmKTsNCj4gDQo+IC0JcmV0ID0gcmVndWxhdG9yX2VuYWJsZShpbmZvLT52cmVm
KTsNCj4gLQlpZiAocmV0KQ0KPiAtCQlyZXR1cm4gcmV0Ow0KPiAtDQo+IC0JaW5mby0+dnJlZl91
diA9IHJlZ3VsYXRvcl9nZXRfdm9sdGFnZShpbmZvLT52cmVmKTsNCj4gKwlpbmZvLT52cmVmX3V2
ID0gZGV2bV9yZWd1bGF0b3JfZ2V0X2VuYWJsZV9yZWFkX3ZvbHRhZ2UoJnBkZXYtPmRldiwNCj4g
InZyZWYiKTsNCj4gKwlpZiAoaW5mby0+dnJlZl91diA8IDApDQo+ICsJCXJldHVybiBpbmZvLT52
cmVmX3V2Ow0KPiANCj4gIAlkZXZpY2VfcHJvcGVydHlfcmVhZF91MzJfYXJyYXkoZGV2LCAiZnNs
LGFkY2stbWF4LWZyZXF1ZW5jeSIsDQo+IGluZm8tPm1heF9hZGNrX3JhdGUsIDMpOw0KPiANCj4g
QEAgLTg3OSw1MiArODcyLDIxIEBAIHN0YXRpYyBpbnQgdmY2MTBfYWRjX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJaW5kaW9fZGV2LT5jaGFubmVscyA9IHZmNjEw
X2FkY19paW9fY2hhbm5lbHM7DQo+ICAJaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMgPSBBUlJBWV9T
SVpFKHZmNjEwX2FkY19paW9fY2hhbm5lbHMpOw0KPiANCj4gLQlyZXQgPSBjbGtfcHJlcGFyZV9l
bmFibGUoaW5mby0+Y2xrKTsNCj4gLQlpZiAocmV0KSB7DQo+IC0JCWRldl9lcnIoJnBkZXYtPmRl
diwNCj4gLQkJCSJDb3VsZCBub3QgcHJlcGFyZSBvciBlbmFibGUgdGhlIGNsb2NrLlxuIik7DQo+
IC0JCWdvdG8gZXJyb3JfYWRjX2Nsa19lbmFibGU7DQo+IC0JfQ0KPiAtDQo+ICAJdmY2MTBfYWRj
X2NmZ19pbml0KGluZm8pOw0KPiAgCXZmNjEwX2FkY19od19pbml0KGluZm8pOw0KPiANCj4gLQly
ZXQgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9zZXR1cChpbmRpb19kZXYsICZpaW9fcG9sbGZ1bmNf
c3RvcmVfdGltZSwNCj4gLQkJCQkJTlVMTCwgJmlpb190cmlnZ2VyZWRfYnVmZmVyX3NldHVwX29w
cyk7DQo+IC0JaWYgKHJldCA8IDApIHsNCj4gLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ291bGRu
J3QgaW5pdGlhbGlzZSB0aGUgYnVmZmVyXG4iKTsNCj4gLQkJZ290byBlcnJvcl9paW9fZGV2aWNl
X3JlZ2lzdGVyOw0KPiAtCX0NCj4gKwlyZXQgPSBkZXZtX2lpb190cmlnZ2VyZWRfYnVmZmVyX3Nl
dHVwKCZwZGV2LT5kZXYsIGluZGlvX2RldiwNCj4gJmlpb19wb2xsZnVuY19zdG9yZV90aW1lLA0K
PiArCQkJCQkgICAgICBOVUxMLCAmaWlvX3RyaWdnZXJlZF9idWZmZXJfc2V0dXBfb3BzKTsNCj4g
KwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgcmV0
LCAiQ291bGRuJ3QgaW5pdGlhbGlzZSB0aGUNCj4gK2J1ZmZlclxuIik7DQo+IA0KPiAgCW11dGV4
X2luaXQoJmluZm8tPmxvY2spOw0KPiANCj4gLQlyZXQgPSBpaW9fZGV2aWNlX3JlZ2lzdGVyKGlu
ZGlvX2Rldik7DQo+IC0JaWYgKHJldCkgew0KPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDb3Vs
ZG4ndCByZWdpc3RlciB0aGUgZGV2aWNlLlxuIik7DQo+IC0JCWdvdG8gZXJyb3JfYWRjX2J1ZmZl
cl9pbml0Ow0KPiAtCX0NCj4gKwlyZXQgPSBkZXZtX2lpb19kZXZpY2VfcmVnaXN0ZXIoJnBkZXYt
PmRldiwgaW5kaW9fZGV2KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9i
ZSgmcGRldi0+ZGV2LCByZXQsICJDb3VsZG4ndCByZWdpc3RlciB0aGUNCj4gK2RldmljZS5cbiIp
Ow0KPiANCj4gIAlyZXR1cm4gMDsNCj4gLQ0KPiAtZXJyb3JfYWRjX2J1ZmZlcl9pbml0Og0KPiAt
CWlpb190cmlnZ2VyZWRfYnVmZmVyX2NsZWFudXAoaW5kaW9fZGV2KTsNCj4gLWVycm9yX2lpb19k
ZXZpY2VfcmVnaXN0ZXI6DQo+IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGluZm8tPmNsayk7DQo+
IC1lcnJvcl9hZGNfY2xrX2VuYWJsZToNCj4gLQlyZWd1bGF0b3JfZGlzYWJsZShpbmZvLT52cmVm
KTsNCj4gLQ0KPiAtCXJldHVybiByZXQ7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyB2b2lkIHZmNjEw
X2FkY19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgLXsNCj4gLQlzdHJ1Y3Qg
aWlvX2RldiAqaW5kaW9fZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+IC0Jc3Ry
dWN0IHZmNjEwX2FkYyAqaW5mbyA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+IC0NCj4gLQlpaW9f
ZGV2aWNlX3VucmVnaXN0ZXIoaW5kaW9fZGV2KTsNCj4gLQlpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9j
bGVhbnVwKGluZGlvX2Rldik7DQo+IC0JcmVndWxhdG9yX2Rpc2FibGUoaW5mby0+dnJlZik7DQo+
IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGluZm8tPmNsayk7DQo+ICB9DQo+IA0KPiAgc3RhdGlj
IGludCB2ZjYxMF9hZGNfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpIEBAIC05NzIsNyArOTM0
LDYgQEANCj4gc3RhdGljIERFRklORV9TSU1QTEVfREVWX1BNX09QUyh2ZjYxMF9hZGNfcG1fb3Bz
LCB2ZjYxMF9hZGNfc3VzcGVuZCwNCj4gDQo+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZl
ciB2ZjYxMF9hZGNfZHJpdmVyID0gew0KPiAgCS5wcm9iZSAgICAgICAgICA9IHZmNjEwX2FkY19w
cm9iZSwNCj4gLQkucmVtb3ZlICAgICAgICAgPSB2ZjYxMF9hZGNfcmVtb3ZlLA0KPiAgCS5kcml2
ZXIgICAgICAgICA9IHsNCj4gIAkJLm5hbWUgICA9IERSSVZFUl9OQU1FLA0KPiAgCQkub2ZfbWF0
Y2hfdGFibGUgPSB2ZjYxMF9hZGNfbWF0Y2gsDQo+IC0tDQo+IDIuMzQuMQ0KDQo=

