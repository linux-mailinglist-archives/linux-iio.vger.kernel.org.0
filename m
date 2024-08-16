Return-Path: <linux-iio+bounces-8511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A136F953F18
	for <lists+linux-iio@lfdr.de>; Fri, 16 Aug 2024 03:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BEC2B2154C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Aug 2024 01:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE172837B;
	Fri, 16 Aug 2024 01:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ikxGOCC3"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABD1D69E;
	Fri, 16 Aug 2024 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772927; cv=fail; b=dz9KFu2k8u5XeN6nWcM6LXj1pm8hNr4ZUUSMjsFt5XWz0K/KKx+oe3kVqiGesiY5+6f2jW5sg3NlDYeaDdUurPSWhoPvLVtyf4P9RlUGEGJ2mjyEdaFxX5lh4aSaWiNLJTgt1FYd6FKQiY6kMydNpcJY5//dm4d9AiAlhlxyQfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772927; c=relaxed/simple;
	bh=tyIxqiRHmkfEibBuMesbIQ8G9ZX0piCemHlyNlQOTR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J6hTFSD/IDgWBbQoGVr835KJGYrQWIGHqNacAYHflh4Ty+spSILXq+QepTP+yQu5V7mO7po/NIAhnBl86QtMtnkZsFs3LZroBzoGFSAyNvSrkR5J3ZT26CV/iMwQlBkoO0Nor0dKyv/ES7rM7TchVATiCfU8xy09gW3cAik32h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ikxGOCC3; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGLJ2GywJIw/RJJhMiP8ufM5PN3uRaWsCHkH/6uVkMg32BmZw98N0rT/m56kNJXCIn5Pk0byUdYbDIIeSGzayG4O0ykUyMp71T6U/kLcGP1165S0lUsnUIagM9YnaPJzrFia8EH+DFHIj8kDDznN1zi6+5EQyUVn2krzSSZSm1z4W0wOTqOFk6Bd42No3EalTYeSx1AIC+w0BUj40tVUblPGz1bEZkekgaabD00ciSJv7uH8WuujW1QhJH2v0Kv0ha9RmlqJ4qSOpMM10c9Ptu/Etf0cSwWfbpeYRkpv3CuTucDTA+1Q3grMSnlA8ghrKR6Z0uBP+8Bzbo8UyaAeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyIxqiRHmkfEibBuMesbIQ8G9ZX0piCemHlyNlQOTR0=;
 b=tOxAFfTy9Sn02fwkK6nqrIWEdRkEvUYbTE1MkrSRkfST++hvG5V64dSr4+PvqL1q0DT7dAEEjEDwWjay6zCUuMwxXAwsoRi85U6CM49SemkvuiRjv83sc7gSfMBiRpz/U/dDpHqZg3NAs1NjagP/G2bn9OPR7Db4Zoh0aPEeZTlaStBkYDWwh8I63Udwum9ftYpD78xlNePOz6BtOR+TsnjaOcq7FcQwcMaED8HcjURLTSNBktI+vBSykZQbyjxf92M9sP7IUhj4vndXnPeGYFpzpNqTTl852pa+KIEUL0p5DOqKpFNwSCe/Ej/kEx54C0CHOuWnykzP+h07TX6K7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyIxqiRHmkfEibBuMesbIQ8G9ZX0piCemHlyNlQOTR0=;
 b=ikxGOCC3GtLhqV6mJhI3hd2mMountXcB+ql5iDq+9wHM0k2WyGiVBh4AqRWXElTupkf534SJJJ16SeieqlfQHaSoPX5wjACR4PYlDtAS07fvqexahCzbJE5zlFunkqqj5ZuE85H8ggNMp0XLKs+0sWGjdb9RS42Be0i2pudPM8qNwa6iGw2NtkNAucRXJXsIX/uwX3yFtVaoxQ8T4Bq/8dylXBRFcQTIZ3zvqKHNmJSovjgZ/Fxi60t1c8xEvRtDS4MhPB4QrHYA9hNF1oRMO7L7IiGMJ2Z+OlSLxYegovECSsC2awJ2Rnv/O5REZ+BALM5ubc31Fzhsa/WVP3h4hw==
Received: from PAVPR10MB6988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:303::9)
 by AS5PR10MB8124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:677::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 01:48:36 +0000
Received: from PAVPR10MB6988.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96e6:9bd:de49:f770]) by PAVPR10MB6988.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96e6:9bd:de49:f770%4]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 01:48:36 +0000
From: "Li, Hua Qian" <HuaQian.Li@siemens.com>
To: "conor@kernel.org" <conor@kernel.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "Zeng, Chao" <chao.zeng@siemens.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, "Su, Bao
 Cheng" <baocheng.su@siemens.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add everlight pm16d17 binding
Thread-Topic: [PATCH 2/3] dt-bindings: iio: Add everlight pm16d17 binding
Thread-Index: AQHa7vRPltSArXBM502Gv6SdqMbe2LIlU7qAgAPLLYA=
Date: Fri, 16 Aug 2024 01:48:36 +0000
Message-ID: <a458a2cbc96a23c0a2ef89327e1f8bcd2e2777e6.camel@siemens.com>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
	 <f6476e06cd8d1cf3aff6563530612c536cd45716.1723527641.git.jan.kiszka@siemens.com>
	 <20240813-captivity-spellbind-d36ca0f31e22@spud>
In-Reply-To: <20240813-captivity-spellbind-d36ca0f31e22@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR10MB6988:EE_|AS5PR10MB8124:EE_
x-ms-office365-filtering-correlation-id: 098b3d16-9e0c-4d04-38a1-08dcbd958b75
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3hYbGdLL2Q2VG96bU14YWdUSlFFazRnSDY1WU9lMk11ZmhkMTE3dDloMlgz?=
 =?utf-8?B?V1VTckx6MkF6V1VJRTNmdDlDWkVXVWZtSVlmb0kzWWVZczJ3SnNQa0s4eksr?=
 =?utf-8?B?UThNc20vQll0Qm0xbmloSVQ1UnZDcEM3OVpUZlp6em40TTNNeXpkRy92alVZ?=
 =?utf-8?B?K3hqWnY4NllFN1hEUVFnc0tXN2NvZytlN010bXpEQlBENk8wZVZ0bnZQQ0Mv?=
 =?utf-8?B?MDR2UzlrdEJ4NlBreDNwOGdJNzk5SGRtSUtlZjRvMkc0aitudFBhRlp3TFVG?=
 =?utf-8?B?TzM5U1VLM3Ruc0VnZ1JwY1hlWFU1ckdTUlkrdEUxcUFqWjdxb1ZlWDFuZEM0?=
 =?utf-8?B?MjEzVUw0ZXJKcUZSdFhiQ0NHK2xyZHloK09yb1E1R0Jkc1QyQmhHMWUrejMz?=
 =?utf-8?B?SmI5d3Y0Wm9CWmpTNVd4TWoxWm85bUZRYnM4alhkMkJEdUNoTEllell1SmFC?=
 =?utf-8?B?L1hmY2s4bVVEc1Z5MzFJL3lONGx3S0NrTDF3M2NHV3JRWlk3N2NyRXZoSE5U?=
 =?utf-8?B?UmhLWThvQm1DUXFDZ01UTWZCakJRejJZa0krbTUxZUdTNVIvcVJlaWN4ZktC?=
 =?utf-8?B?K2ZLRitGZDVyd3dhdCtiTkQ3S3AzanJiVnBLeWlST1BRVDRPQVJmV0tFOWVk?=
 =?utf-8?B?VXQxdnYxb0F5SmVJOWhDT1JhNmNIaTFhSFBRZWJHTzB2M1BtWnpRNEFTbGtF?=
 =?utf-8?B?WmdlTzJSNXJWa09YMlIrYmh1bDdHZU5EV3FPUkd5a1hrekNMdW5uM1dKM2VO?=
 =?utf-8?B?U1FCU2tsNjFITW93WXQvZk5xRW8xVUg1VlFyVUUxSnZPSDJadjh2bG5MWkdE?=
 =?utf-8?B?Z2xrdGdTNEZsVmZRWm90UkhKcDg4VkZPZmVKbFhYM3VRVnVGbVJGSWd4dXFU?=
 =?utf-8?B?MUwzQWtlenhVTWVZU0N2cE9FL2xOdUg0ZGpia1R4VzJMaGJQNVR3S1pObEVm?=
 =?utf-8?B?TGVwSm45NlFuRVJteWxqUXNOODgxY0tPQk1yVy9qelUvZkRoVk54UkNrWHJi?=
 =?utf-8?B?QVJUSU5xamhPOGNoN3BtVHVQc25sTm5VUW1Fdm8vVmtQcTE4QllEdVhsM2c3?=
 =?utf-8?B?NitZVEgxamxhcnhVNVcrU1RxTUhNTERUcFcrTVJKY2Y4cnQzSlVIV2NOQjFV?=
 =?utf-8?B?bEFlRGtHVDdXNFdOaFY2VThyaDVQOWtnVGNMazUyaEppT0YvRVJEaUl3NkUz?=
 =?utf-8?B?NDIzMHdPeTZFMHNiVUp6OWpmMnJidTgzczc5V3NVUFBiOG9WK25EMHlrSFNH?=
 =?utf-8?B?OExVVXU3WDR3bldiQUNLamszVTVhWCsyVHNmODNSejE2QVRlYWJqYkNBaUZq?=
 =?utf-8?B?NjdOc0thSFpKendMSGhtWS96M2h3SUhZcWVLQmRuTW1sS2VtazdaL0J3ZUxu?=
 =?utf-8?B?SFc0V1lBRjAxSEV2cTJ2WnFndUY1NXZOaUdhUEp4QUhjeEIraHcxVnBDbzRv?=
 =?utf-8?B?SkJXWkJ3NTgxVVVSdU9VRjZLdW9GVVhJU09tMDBLRWhUUHM1M0hBMG9lUmhV?=
 =?utf-8?B?bUJuaE1MVUFRSUY1VVBHOTg5SUs1amRRS3pKUy9USktIM3JuMGNNcFRQWS9l?=
 =?utf-8?B?ZlEwZGl2WThSTWJPOCtnMG9sSCs2Qm5neGhwb3RoM05zWlYwa2E5VXpNcVJy?=
 =?utf-8?B?N0RjN3NpcGExQTZLSlo1YkFac2hDdmxMRTlmVThXYURrbXd2U0NEQlgrZi9R?=
 =?utf-8?B?MWpRaDJPRkVFV1l2MUsxQUszK1d4WXVxc1R0Qnd4VjdZL3l5aXhhWTMybEYr?=
 =?utf-8?B?ejhwaENDM0V4M1lURmQzeDdQdENodjVMQUVySEtheFhkVk9CRFo1dFZ1NlNs?=
 =?utf-8?Q?o0R6fTlM1ULfmSKXPJw/Acqn+9690+wibviCI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR10MB6988.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHBJeEcwckw5a2hkVkxGTFdvUmxYb0FPNjdlMXdwaTZNcWE1M2NsVnRxZXJX?=
 =?utf-8?B?S0FvWjM1OElRSllOb0E3S1NOOGJtKyt2dHdydDlxVy9TRElXZjJLUForbnJh?=
 =?utf-8?B?Njdaa2tZOGxhd2tvaXNtSG91K1FHMHozZUtvWFFGVTV4bkJrRC8rUHVGZjBJ?=
 =?utf-8?B?UUpMcUFxWmRmcFpweEN6OThjRUhxVGN1WHEyL3phTE1wVkdzYmpzQStiTCt2?=
 =?utf-8?B?QnlzbEtiNXhEYmhpcklKcUxDQ2NQVDRuVnBta1NnRnY2RXp0K2t5QU54YzBB?=
 =?utf-8?B?STFqN2V3S1RrNlZhZFYxUkZrMW9mbUdpT2dhSzhzd3lZU01aYSt0UUh4bzVY?=
 =?utf-8?B?OHFlUzZqb24ydGdSdGlrNzB5RndPdzBIckluRU1xdktkZTMzWnNQZkZPeXMx?=
 =?utf-8?B?QnBxMW9UV3BWRUw3T00yaGZ5bm5vYzlvS3R4OGVPM0NvVUkralo3TkZ1Mk9v?=
 =?utf-8?B?Zlc4YStNZTV1N25BQmFTa2FKRUtBZVNsSks2MlduZmliQlpxanBrMVNWYWxY?=
 =?utf-8?B?VGZuNUIzU0dvWU80UkxjVlExdis3blhaWEVHZXhiUWRoYzlHQi9FYnRCR3Uy?=
 =?utf-8?B?b1g0NFlvbWJIVW1XWlNHblcxcUtlcE1nTytHTXppMjlmdHloYlN4enc0RzVs?=
 =?utf-8?B?amgyK2FKMGEyOExnT3lLSXFJeFdDZy9ZRjRyN0Jrb0ZUdmd6UGo0RmYzTFg0?=
 =?utf-8?B?d1BhSVJQcDNPb1J0L29JUURleTAycVpEc0Y3eWpwRkgwRnFnbWo4ZXNtbVJz?=
 =?utf-8?B?aGdsRlZlSUlqcXJBYTJpK0hmcTFJYlV1UGhoL2RHUUJoRTY3UDVOTFN0VzRD?=
 =?utf-8?B?YzNKVnkyWTlKcjluNXhsMkpzck1ZVjJ5b0g3elEyWm9rZXFkcmhMVFBReUlN?=
 =?utf-8?B?aXhKK3V4bGs3NzRRVXdsVEdjcGJ5NUhIR0txVHpDREZJZHdHaTUvRXhON0hW?=
 =?utf-8?B?YVJKL01RS2JHQU9MZ3RvOHVSMGI5OUJJelpDclhrUU1OZnpKTHNWY0JHUjBH?=
 =?utf-8?B?SG1yY0dNTytNdXM4ellMUS9jL2ZYRGhSYVI3Yk9hWWg0emdheE1zeGZIOXFs?=
 =?utf-8?B?c0JwK2JUMFdiOGlLRXhITDFMNU1MaXRVN2sxL1JRN2dNRitNZ01OZkc2SkxP?=
 =?utf-8?B?ekVxYlU0RXFrR3dNeGdJTEFGd0hUT2l0Yzg0UEhpdElIN0ZjTnVxeUFjNm5M?=
 =?utf-8?B?dTRmbCtNTWRYcysyRHUrTldtTmJYNE04ZlVoTlh0aExRcUZieTBGR3dhK3gy?=
 =?utf-8?B?UlFTYk5QRTAxU1NFSU90WnlRMm40cGpUcVM3WkNDZFJYQUJkRmVPaUZTdHF2?=
 =?utf-8?B?NzJ2eHlwNFcwRFVtbkgyaGRYZEt6SzAzUGtjVzhKMk1rZS92czNZS2NsU0xG?=
 =?utf-8?B?OS9kL015K0xYMDY3cXBpSVdtMnRXalA1K0pCS3RlcWlBWERGbUR1eW9PU0pL?=
 =?utf-8?B?WG1lWlN1alV2Rjk5czAvZ1ExQlN3TGltU2V4ZGU0b2I4NDQyRnk3dlJRbmV4?=
 =?utf-8?B?RkhnVFlFckJVM1FEWHpWcm9RM2NWS29Xb2d0M2Zoa1RpYS93Q0h5NlZKa09B?=
 =?utf-8?B?SmgvL2pDYzJxMGlhbUlNa0laQmNzeThDaU9lTW9rSUFXNnJrOEo3dFFRMWow?=
 =?utf-8?B?YkJ0ZENYWHhiczFBMjkrbTZlRVQwNTBQNGdueERiY2hqTEY5ZFFjUlNVd01Z?=
 =?utf-8?B?ZjFMaldWUkpRdjAvb3JGc3c5dXRnNlVRSTZKVHljNEZVVkRYUm9HVXdFcDBh?=
 =?utf-8?B?bGFLV3dTdlZaSkNDdjJ1NjlWUmhiNVRuVGtsMnhqb21KazVTcHcyT3g5Sysy?=
 =?utf-8?B?dGcwQmdlT3VicE44N3lsbXNxanNpd3RsZ0JkdTFzM2Yyb3pNNUlkejVWSG9X?=
 =?utf-8?B?cTFzSU0yVHRoWmQrbW5jQ1hKeUhFYzkrUENqcGhlY2ZJT1JCQWhnSGFrUU9R?=
 =?utf-8?B?d21HVjNZelhFbVlvTEtsSFFxOUZMSjBpbkhZdlhuRlNVQk50ZVlQWDM2ZmIr?=
 =?utf-8?B?N3hHRXdIeHpjc1NiMVJvV29kU21ZYllDbnNVdE9nbmI2WURLZzkzLzBzeXZk?=
 =?utf-8?B?a1pqVkpjOS9ObmdEN1ZXWnozdWNhb0swSWE5aTM0U1ovNHc0YWJaN3BDQWdl?=
 =?utf-8?B?UWM3REZSTmswRVpjUlI1NHdGZGY2SEJCb3BpOTd3Q0JPeVorT2FNTzZPc1Bt?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F884E686A273E146A47B62EBD47227A8@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR10MB6988.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 098b3d16-9e0c-4d04-38a1-08dcbd958b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 01:48:36.7045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6/SD51Uq4Vh6USfhiQzsKBhNf5JV6hEbHn5AAJqWjFD4Pi+zMIKsYEKIunz0CnDIjUeCbWgW8eYKjJY0idkmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8124

T24gVHVlLCAyMDI0LTA4LTEzIGF0IDE2OjUyICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFR1ZSwgQXVnIDEzLCAyMDI0IGF0IDA3OjQwOjQxQU0gKzAyMDAsIEphbiBLaXN6a2Egd3Jv
dGU6DQo+ID4gRnJvbTogQ2hhbyBaZW5nIDxjaGFvLnplbmdAc2llbWVucy5jb20+DQo+ID4gDQo+
ID4gQWRkIHRoZSBiaW5kaW5nIGRvY3VtZW50IGZvciB0aGUgZXZlcmxpZ2h0IHBtMTZkMTcgc2Vu
c29yLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENoYW8gWmVuZyA8Y2hhby56ZW5nQHNpZW1l
bnMuY29tPg0KPiA+IENvLWRldmVsb3BlZC1ieTogQmFvY2hlbmcgU3UgPGJhb2NoZW5nLnN1QHNp
ZW1lbnMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhb2NoZW5nIFN1IDxiYW9jaGVuZy5zdUBz
aWVtZW5zLmNvbT4NCj4gDQo+IERpdHRvIGhlcmUgSmFuLg0KPiANCj4gPiAtLS0NCj4gPiDCoC4u
Li9paW8vcHJveGltaXR5L2V2ZXJsaWdodCxwbTE2ZDE3LnlhbWzCoMKgwqDCoMKgIHwgOTUNCj4g
PiArKysrKysrKysrKysrKysrKysrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgOTUgaW5zZXJ0aW9u
cygrKQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2lpby9wcm94aW1pdHkvZXZlcmxpZ2h0LHBtMTZkMTcueQ0KPiA+IGFtbA0K
PiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9paW8vcHJveGltaXR5L2V2ZXJsaWdodCxwbTE2ZDE3DQo+ID4gLnlhbWwNCj4gPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vcHJveGltaXR5L2V2ZXJsaWdodCxw
bTE2ZDE3DQo+ID4gLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAw
MDAwMDAwMDAwMC4uZmFkYzMwNzUxODFhDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKw0KPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9wcm94aW1pdHkvZXZlcmxp
Z2h0LHBtMTZkMTcNCj4gPiAueWFtbA0KPiA+IEBAIC0wLDAgKzEsOTUgQEANCj4gPiArIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICslWUFN
TCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDoNCj4gPiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2No
ZW1hcy9paW8vcHJveGltaXR5L2V2ZXJsaWdodCxwbTE2ZDE3LnlhbWwjDQo+ID4gKyRzY2hlbWE6
IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4g
PiArdGl0bGU6IEV2ZXJsaWdodCBQTS0xNkQxNyBBbWJpZW50IExpZ2h0ICYgUHJveGltaXR5IFNl
bnNvcg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gK8KgIC0gQ2hhbyBaZW5nIDxjaGFv
LnplbmdAc2llbWVucy5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICvCoCBU
aGlzIHNlbnNvciB1c2VzIHN0YW5kYXJkIEkyQyBpbnRlcmZhY2UuIEludGVycnVwdCBmdW5jdGlv
biBpcw0KPiA+IG5vdCBjb3ZlcmVkLg0KPiANCj4gQmluZGluZ3Mgc2hvdWxkIGJlIGNvbXBsZXRl
LCBldmVuIGlmIHNvZnR3YXJlIGRvZXNuJ3QgdXNlIHRoZQ0KPiBpbnRlcnJ1cHRzLiBDYW4geW91
IGRvY3VtZW50IHRoZW0gcGxlYXNlLg0KPiANCj4gPiArwqAgRGF0YXNoZWV0Og0KPiA+IGh0dHBz
Oi8vZW4uZXZlcmxpZ2h0LmNvbS9zZW5zb3IvY2F0ZWdvcnktcHJveGltaXR5X3NlbnNvci9kaWdp
dGFsX3Byb3hpbWl0eV9zZW5zb3IvDQo+IA0KPiBEbyB5b3UgaGF2ZSBhIGxpbmsgdG8gYSBkYXRh
c2hlZXQ/IFRoZSBsaW5rIHRvIHRoZSBwbTE2ZDE3IGhlcmUgNDA0cw0KPiBmb3INCj4gbWUuDQo+
IA0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArwqAgY29tcGF0aWJsZToNCj4gPiArwqDC
oMKgIGVudW06DQo+ID4gK8KgwqDCoMKgwqAgLSBldmVybGlnaHQscG0xNmQxNw0KPiA+ICsNCj4g
PiArwqAgcmVnOg0KPiA+ICvCoMKgwqAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gK8KgIHBzLWdh
aW46DQo+ID4gK8KgwqDCoCBkZXNjcmlwdGlvbjogUmVjZWl2ZXIgZ2FpbiBvZiBwcm94aW1pdHkg
c2Vuc29yDQo+ID4gK8KgwqDCoCAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzINCj4gPiArwqDCoMKgIGVudW06IFsxLCAyLCA0LCA4XQ0KPiA+ICvCoMKgwqAgZGVm
YXVsdDogMQ0KPiA+ICsNCj4gPiArwqAgcHMtaXRpbWU6DQo+IA0KPiBIb3cgZGlkIHlvdSBnZXQg
aXRpbWUgZnJvbSBjb252ZXJzaW9uIHRpbWU/IFRvIHRoZSBsYXltYW4gKGxpa2UgbWUhKQ0KPiBj
b252ZXJzaW9uLXRpbWUgd291bGQgbWFrZSBtb3JlIHNlbnNlLi4uDQo+IA0KPiBBbHNvLCAicHMi
PyBUaGUgd2hvbGUgdGhpbmcgaXMgYSBwcm94eSBzZW5zb3IsIHNvIHdoeSBoYXZlIHRoYXQNCj4g
cHJlZml4DQo+IG9uIHByb3BlcnRpZXMuIFdoYXQgaXMgbWlzc2luZyBob3dldmVyIGlzIGEgdmVu
ZG9yIHByZWZpeC4NCj4gDQo+ID4gK8KgwqDCoCBkZXNjcmlwdGlvbjogQ29udmVyc2lvbiB0aW1l
IGZvciBwcm94aW1pdHkgc2Vuc29yIFttc10NCj4gPiArwqDCoMKgICRyZWY6IC9zY2hlbWFzL3R5
cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0cmluZw0KPiANCj4gSW5zdGVhZCBvZiBhIHN0cmluZywg
cGxlYXNlIHVzZSB0aGUgLXVzIHN1ZmZpeCwgYW5kIHB1dCB0aGlzIGluDQo+IG1pY3Jvc2Vjb25k
cyBpbnN0ZWFkLg0KPiANCj4gSW4gdG90YWwsIHRoYXQgd291bGQgYmUgcy9wcy1pdGltZS9ldmVy
bGlnaHQsY29udmVyc2lvbi10aW1lLXVzLy4NCj4gDQo+IEkgd291bGQsIGhvd2V2ZXIsIGxpa2Ug
dG8ga25vdyB3aHkgdGhpcyBpcyBhIHByb3BlcnR5IG9mIHRoZQ0KPiBoYXJkd2FyZS4NCj4gV2hh
dCBmYWN0b3JzIGRvIHlvdSBoYXZlIHRvIGNvbnNpZGVyIHdoZW4gZGV0ZXJtaW5pbmcgd2hhdCB2
YWx1ZSB0bw0KPiBwdXQNCj4gaW4gaGVyZT8NCj4gDQo+ID4gK8KgwqDCoCBlbnVtOg0KPiA+ICvC
oMKgwqDCoMKgIC0gIjAuNCINCj4gPiArwqDCoMKgwqDCoCAtICIwLjgiDQo+ID4gK8KgwqDCoMKg
wqAgLSAiMS42Ig0KPiA+ICvCoMKgwqDCoMKgIC0gIjMuMiINCj4gPiArwqDCoMKgwqDCoCAtICI2
LjMiDQo+ID4gK8KgwqDCoMKgwqAgLSAiMTIuNiINCj4gPiArwqDCoMKgwqDCoCAtICIyNS4yIg0K
PiA+ICvCoMKgwqAgZGVmYXVsdDogIjAuNCINCj4gPiArDQo+ID4gK8KgIHBzLXd0aW1lOg0KPiA+
ICvCoMKgwqAgZGVzY3JpcHRpb246IFdhaXRpbmcgdGltZSBmb3IgcHJveGltaXR5IHNlbnNvciBb
bXNdDQo+ID4gK8KgwqDCoCAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9z
dHJpbmcNCj4gDQo+IEFsbCBvZiB0aGUgc2FtZSBjb21tZW50cyBhcHBseSBoZXJlLiBFLmcuIHdo
eSAid3RpbWUiIGlzbnRlYWQgb2YNCj4gIndhaXRpbmctdGltZSIgYW5kIHNvIG9uLg0KPiBJIHdv
dWxkIHJlYWxseSBsaWtlIHRvIGtub3cgd2h5IHRoZXNlIHRoaW5ncyBhcmUgcHJvcGVydGllcyBv
ZiB0aGUNCj4gaGFyZHdhcmUsIHJhdGhlciB0aGFuIHNvbWV0aGluZyB0aGF0IHNvZnR3YXJlIHNo
b3VsZCBjb250cm9sLg0KPiANCj4gPiArwqDCoMKgIGVudW06DQo+ID4gK8KgwqDCoMKgwqAgLSAi
MTIuNSINCj4gPiArwqDCoMKgwqDCoCAtICIyNSINCj4gPiArwqDCoMKgwqDCoCAtICI1MCINCj4g
PiArwqDCoMKgwqDCoCAtICIxMDAiDQo+ID4gK8KgwqDCoMKgwqAgLSAiMjAwIg0KPiA+ICvCoMKg
wqDCoMKgIC0gIjQwMCINCj4gPiArwqDCoMKgwqDCoCAtICI4MDAiDQo+ID4gK8KgwqDCoMKgwqAg
LSAiMTYwMCINCj4gPiArwqDCoMKgIGRlZmF1bHQ6ICIxMi41Ig0KPiA+ICsNCj4gPiArwqAgcHMt
aXItbGVkLXB1bHNlLWNvdW50Og0KPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246IElSIExFRCBkcml2
ZSBwdWxzZSBjb3VudA0KPiA+ICvCoMKgwqAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVm
aW5pdGlvbnMvdWludDMyDQo+IA0KPiBBbGwgY3VzdG9tIHByb3BlcnRpZXMgcmVxdWlyZSBhIHZl
bmRvciBwcmVmaXgsIG5vdCAicHMiLiBBZ2Fpbiwgd2hhdA0KPiBtYWtlcyB0aGlzIGEgcHJvcGVy
dHkgb2YgdGhlIGhhcmR3YXJlLCByYXRoZXIgdGhhbiBzb21ldGhpbmcgdGhhdA0KPiBzb2Z0d2Fy
ZSBzaG91bGQgY29udHJvbD8NCj4gDQo+ID4gK8KgwqDCoCBtaW5pbXVtOiAxDQo+ID4gK8KgwqDC
oCBtYXhpbXVtOiAyNTYNCj4gPiArwqDCoMKgIGRlZmF1bHQ6IDENCj4gPiArDQo+ID4gK8KgIHBz
LW9mZnNldC1jYW5jZWw6DQo+ID4gK8KgwqDCoCBkZXNjcmlwdGlvbjogfA0KPiA+ICvCoMKgwqDC
oMKgIFdoZW4gUFMgb2Zmc2V0IGNhbmNlbCBmdW5jdGlvbiBpcyBlbmFibGVkLCB0aGUgcmVzdWx0
IG9mDQo+ID4gc3VidHJhY3RpbmcgYW55DQo+ID4gK8KgwqDCoMKgwqAgdmFsdWUgc3BlY2lmaWVk
IGJ5IHRoZSBQUyBvZmZzZXQgY2FuY2VsIHJlZ2lzdGVyIGZyb20gdGhlDQo+ID4gaW50ZXJuYWwg
UFMNCj4gPiArwqDCoMKgwqDCoCBvdXRwdXQgZGF0YSBpcyB3cml0dGVuIHRvIHRoZSBQUyBvdXRw
dXQgZGF0YSByZWdpc3Rlci4NCj4gDQo+IEFnYWluLCB3aGF0IG1ha2VzIHRoaXMgYSBwcm9wZXJ0
eSBvZiB0aGUgaGFyZHdhcmU/IFdoYXQgaGFyZHdhcmUNCj4gcmVsYXRlZA0KPiBmYWN0b3JzIGRl
dGVybWluZSB0aGF0IHZhbHVlIHRoYXQgeW91IHB1dCBpbiBoZXJlPw0KPiANCj4gVGhhbmtzLA0K
PiBDb25vci4NCg0KQ2VydGFpbiBwYXJhbWV0ZXJzIHN1Y2ggYXMgY29udmVyc2lvbiB0aW1lLCB3
YWl0IHRpbWUsIG9yIHNhbXBsaW5nIHJhdGUNCmFyZSBkaXJlY3RseSB0aWVkIHRvIHRoZSBwaHlz
aWNhbCBjaGFyYWN0ZXJpc3RpY3MgYW5kIGNhcGFiaWxpdGllcyBvZg0KdGhlIHNlbnNvci4gVGhl
c2UgcGFyYW1ldGVycyBhcmUgdHlwaWNhbGx5IGRldGVybWluZWQgYnkgdGhlIHNlbnNvcg0Kc3Bl
Y2lmaWNhdGlvbnMsIGFuZCB0aGUgZGF0YXNoZWV0IHVzdWFsbHkgcHJvdmlkZXMgcmVjb21tZW5k
ZWQgdmFsdWVzDQpmb3IgdGhlc2UgcGFyYW1ldGVycy4gQmVsb3cgaXMgYW4gZXhjZXJwdCBmcm9t
IHRoZSBkYXRhc2hlZXQ6DQoNCi8qDQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLSst
LS0tLS0rLS0tLS0tKy0tLS0tLSstLS0tLSstLS0tLS0tLS0tKw0KfCBQYXJhbWV0ZXIgICAgICAg
ICAgICAgfCBTeW1ib2x8IE1pbiAgfCBUeXAgIHwgTWF4ICB8IFVuaXR8IENvbmRpdGlvbnwNCist
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tKy0tLS0tLSstLS0tLS0rLS0tLS0tKy0tLS0t
Ky0tLS0tLS0tLS0rDQp8IFBTIEEvRCBjb252ZXJzaW9uIHRpbWV8IFRQUyAgIHwgMjEuNCB8IDI1
LjIgfCAyOC45IHwgbXMgIHwgUFMNCkEvREM9MTZiaXQgIHwNCnwgUFMgd2FpdCB0aW1lIHNldHRp
bmcgIHwgVFBTV0FJVHwgMTAuNnwgMTIuNSB8IDE0LjMgfCBtcyAgfCAxMi41bXMNCnNldHRpbmcg
fA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0rLS0tLS0tKy0tLS0tLSstLS0tLS0r
LS0tLS0rLS0tLS0tLS0tLSsNCiovDQoNCg0KSG93ZXZlciwgdGhlcmUgYXJlIHNvbWUgc2ltaWxh
ciBjYXNlcyBpbiB0aGUga2VybmVsLCBhcyBmb2xsb3dzOg0KDQpEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaWlvL3Byb3hpbWl0eS9kZXZhbnRlY2gtc3JmMDQueWFtbA0KICAgIC0g
c3RhcnR1cC10aW1lLW1zDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL3By
b3hpbWl0eS9zZW10ZWNoLHN4OTMxMC55YW1sDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaWlvL3Byb3hpbWl0eS9zZW10ZWNoLHN4OTMyNC55YW1sDQpEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaWlvL3Byb3hpbWl0eS9zZW10ZWNoLHN4OTM2MC55YW1sDQogICAg
LSBzZW10ZWNoLGF2Zy1wb3Mtc3RyZW5ndGgNCiAgICAtIHNlbXRlY2gscGgwMS1yZXNvbHV0aW9u
DQogICAgLSBzZW10ZWNoLGlucHV0LWFuYWxvZy1nYWluDQogICAgLSAuLi4NCkRvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vcHJveGltaXR5L3Zpc2hheSx2Y25sMzAyMC55YW1s
DQogICAgLSB2aXNoYXksbGVkLWN1cnJlbnQtbWljcm9hbXANCg0KVGhpcyBpcyB3aHkgd2UgYXJl
IGxldmVyYWdpbmcgdGhlIGhhcmR3YXJlIHByb3BlcnRpZXMuDQoNClRoYW5rcywNCkh1YSBRaWFu
DQoNCj4gDQo+ID4gK8KgwqDCoCAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzINCj4gPiArwqDCoMKgIGRlZmF1bHQ6IDANCj4gPiArwqDCoMKgIG1heGltdW06IDY1
NTM1DQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArwqAgLSBjb21wYXRpYmxlDQo+ID4gK8Kg
IC0gcmVnDQo+ID4gKw0KPiA+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0K
PiA+ICtleGFtcGxlczoNCj4gPiArwqAgLSB8DQo+ID4gK8KgwqDCoCBpMmMgew0KPiA+ICvCoMKg
wqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArwqDCoMKgwqDCoMKgwqAgI3Np
emUtY2VsbHMgPSA8MD47DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoCBsaWdodHNlbnNvcjog
cG0xNmQxN0A0NCB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJl
dmVybGlnaHQscG0xNmQxNyI7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4
NDQ+Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcy1nYWluID0gPDE+Ow0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBzLWl0aW1lID0gIjAuNCI7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcHMtd3RpbWUgPSAiMTIuNSI7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcHMtaXItbGVkLXB1bHNlLWNvdW50ID0gPDE+Ow0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHBzLW9mZnNldC1jYW5jZWwgPSA8MjgwPjsNCj4gPiArwqDCoMKgwqDCoMKgwqAg
fTsNCj4gPiArwqDCoMKgIH07DQo+ID4gLS0gDQo+ID4gMi40My4wDQo+ID4gDQoNCi0tIA0KSHVh
IFFpYW4gTGkNClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

