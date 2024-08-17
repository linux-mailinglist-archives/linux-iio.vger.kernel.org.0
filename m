Return-Path: <linux-iio+bounces-8525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B69955762
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B0AB2171F
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 11:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA5814883F;
	Sat, 17 Aug 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="D6GfGhwF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2D13E033;
	Sat, 17 Aug 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723893518; cv=fail; b=OpcpL4yFpnTnnD1mzdZNPW7xMcjTBibSEPCHtaH1UDlU3F85Z3RG1MfwmluU30ujEF3s6/v3Y/J0dhQn641DHtMcOpdXYhFQqI3ZzmYA/MuTRt4A5bWx+GUPzCt0aJVvRhURc6G4eiuEs65UthMxOZtKpepQUqKiuEIqY22mA+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723893518; c=relaxed/simple;
	bh=EmGifrT4hYLn4FfEQ63Ox+8yEMDCqpKtVBLfn1KqZoc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TmUJKj3YV3Nr6ACXSy/cF4CE67zjMue5juTctX4aVQ51wikLAg58b6cvzehzqgfJvbTs4J3cLT4qQRpfE5s9ZMAjecMx4Xvtg0ula7eNaADYU4TSVA4g6FNMa3fdPu/5wxCqxaOwZXLk/4tAvYLIZyCPQoFYyfN8DM9NndHNDGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=D6GfGhwF; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47H5JxLK024323;
	Sat, 17 Aug 2024 07:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EmGif
	rT4hYLn4FfEQ63Ox+8yEMDCqpKtVBLfn1KqZoc=; b=D6GfGhwFY8RXDeZBHbYEo
	pJNA81ew5RMw2ByfD3fmW2sw052J7FpQgvFcGeVazH9aDAXdCP3VRG74O+d4k+FF
	NygtWsabYsIJIzvUIjjydT5j/DPk2K32uuNefeIVg14+F33yCwdqKi3NZQ3Ly/Vn
	qHxzuPJ43YyILt0ZtvhC1bHJUpAOTQaB+B+r8VFj7bbjg5JXFPJ2dLNphM8nylty
	PI0ps1VEw8iiTWKJIQu2BVOf3v1RKHcI5/PXf7+n63YWM4bOGOvV9NEo6efU0mIj
	6UQQ8lXf60jGl8yioXvr+5YRWwcSTznLrXZKiqQZk+UQsuRwnYdLr2OQJfhRAKtV
	g==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 412nm8rj5n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Aug 2024 07:18:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNbn75Epqq1KN9J7fmDMZ63Z8tgWNkxTUHKPSyRFDLRm7XhkFONMkf7NVZGpvtmiAkEmJHeZenk1CZsPeT1F7MKEsegRiEeTuG7NCLb7uSYw9JACbidD2RdsNAomNbZ2ZXT4R9J8FEssNevC+XX9PTnTURCUYWbRpaclLFtM/YDy/HXR8kUX4fX0Z0BVreFnPH2WCjmq4tpfKNbRXdNUSDGrTPrJ2pZUOOlvynd0y0XfhHxgndYvbZwCHQPzQSwi90BM+1Pyh/Vh0TukGw+ihzxRxKF4eHmEDFW8TSG9EAniJyz/ibFkShsgFyU8dTjuQ3XgFWRCr1QGAyCKH5fi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmGifrT4hYLn4FfEQ63Ox+8yEMDCqpKtVBLfn1KqZoc=;
 b=YrvjFrUjEJv/ZxwFG8snOUQpYC7O8SPc5i0jXKdy7NAbRnNF6g/SbUapgsBBwvODTk5dGCrJ1TwEyruNYZ7oXjdnPuUOvYnMEI/hPvanBgQ/r7zEIR+dnlzPygTA9JV+BMYnmHHjVbTz5csE43QFvrfs+p4pLZ7ckDK3tKrS44a9DdOafzVP1gIO/2Ixa9uFKhjBovTUvAXkKRfRNn3EhXMNc2r5hl9Ri6ZgoX4y4jRWA3mu1TvCGLwIAdV9AHjINVAGLa65gCSochjabrxAqp5RnzhgGDeDhhV2NWQFlxp44sBfUYn6N5ehKQrr/JFqB/R48HQbcLZ0x+Ivla4RDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by BY5PR03MB5077.namprd03.prod.outlook.com (2603:10b6:a03:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Sat, 17 Aug
 2024 11:18:05 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%4]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 11:18:05 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcelo
 Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: iio: dac: add docs for ad8460
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: dac: add docs for ad8460
Thread-Index: AQHa4kfao6d1lQ6IiEC71XeSdM9+JLIrZ1Jg
Date: Sat, 17 Aug 2024 11:18:05 +0000
Message-ID:
 <SJ0PR03MB6224EB6BB835741EA94DEB7491822@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240730030509.57834-1-Mariel.Tinaco@analog.com>
 <20240730030509.57834-2-Mariel.Tinaco@analog.com>
 <71cbe674-b232-4327-929b-351630907540@kernel.org>
In-Reply-To: <71cbe674-b232-4327-929b-351630907540@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYRzEwYVc1aFkyOWNZWEJ3WkdGMFlWeHliMkZ0YVc1blhE?=
 =?utf-8?B?QTVaRGcwT1dJMkxUTXlaRE10TkdFME1DMDROV1ZsTFRaaU9EUmlZVEk1WlRN?=
 =?utf-8?B?MVlseHRjMmR6WEcxelp5MDFOR1EyTkRBM05TMDFZemhoTFRFeFpXWXRPR015?=
 =?utf-8?B?WVMwM05EQTBaakUxTWpOalpUaGNZVzFsTFhSbGMzUmNOV00wTm1FNU1UZ3RO?=
 =?utf-8?B?V000WVMweE1XVm1MVGhqTW1FdE56UXdOR1l4TlRJelkyVTRZbTlrZVM1MGVI?=
 =?utf-8?B?UWlJSE42UFNJeE5ETTFNaUlnZEQwaU1UTXpOamd6Tmpjd09EQTFNekV6TWpn?=
 =?utf-8?B?eklpQm9QU0pKVkZSR2JUaGFaa2hFUlVzM2JGVXdXbTEwV1dwbVRreFZkRTA5?=
 =?utf-8?B?SWlCcFpEMGlJaUJpYkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNT?=
 =?utf-8?B?RlV4VWxOU1ZVWk9RMmRWUVVGRVowUkJRVUZFT1RVMFpXd3ZSR0ZCWkcxSGRr?=
 =?utf-8?B?dE5UbTlTT1ZBeVdXRTRiM2N5YUVnd09FUkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlNFRkJRVUZFWVVGUlFVRlRaMGxCUVU4MFFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUlVGQlVVRkNRVUZCUVROTWFGTm1aMEZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVbzBRVUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFX?=
 =?utf-8?B?Tm5RbXhCUmpoQlkwRkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21k?=
 =?utf-8?B?Q2FFRkhkMEZqZDBKc1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpz?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVdkQlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RD?=
 =?utf-8?B?YkVGSFRVRmtVVUo1UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdR?=
 =?utf-8?B?VWhOUVZoM1FqQkJSMnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlVVRkJRVUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFV?=
 =?utf-8?B?ZHJRVmgzUW5wQlIxVkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5?=
 =?utf-8?B?QldsRkNha0ZJVVVGamQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJUelJC?=
 =?utf-8?B?UVVGQlFVRkJRVUZEUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUVVGQlowRkJR?=
 =?utf-8?B?VUZCUVVGQlFYcG5RVUZCUVUxQlFVRkNUMEZCUVVGQlFVRkJRVWRGUVZwQlFu?=
 =?utf-8?Q?BBRjhB?=
x-dg-rorf: true
x-dg-refone:
 Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|BY5PR03MB5077:EE_
x-ms-office365-filtering-correlation-id: bc97b1c6-e620-4c7c-1e7b-08dcbeae43f6
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzB0T0xGOTEyVFJzaHAyc0ZhSkhDYlNnNUpPd2xFeUEyWFZaTEhQQzFKeW5O?=
 =?utf-8?B?VEdkdiswRzdETFBuVDZqZ2FjWkJIQnY0aFUrUkxpSStOVE05Ym9sN3M2Y2Mv?=
 =?utf-8?B?bnlGZ1hDZGxQRjhaZXFrK0VXNVk1b3lnSk9PaDBtSXI0Sk5aMkF6dm0xejFh?=
 =?utf-8?B?RTg2ZG9NOHlWRHNBSk5TY1FxaWZjajRWQVNFT3hINTVINDBmTFRTeFU3SEJJ?=
 =?utf-8?B?c25mTVNRL2ZCRk1DdzljUEN6UkJZVGdvYlQyUDdQVEhvVERseGt4V0ZyKytF?=
 =?utf-8?B?V2Y1d1NpVGVicFB4b2dMZHg2L2FLR2JKbU5pNFpvem1DMFZwczlFVUF4MXhu?=
 =?utf-8?B?WFVsMmNoMVdMd01ualR0Wm9aeEh0TS9PZXhHYTkwd1V0ZG9nYkp1L244VGN6?=
 =?utf-8?B?TVFqZHljamQvL3J5dnBqNU9tWmlMZ09CRzA5cUx0b2Z4eldYSHJVYm9JUENT?=
 =?utf-8?B?WXpUU0ZZTjl1R2QxVFkzNWhETXVHWEIxOU1UNG1yc1VSN1NLN3NreFZRWDZq?=
 =?utf-8?B?dmhnSmhZZFZSUTU4bDRiUGdCNDJsUEk0dm5aTUQxWGo4dmE3V1BLM1RySkVD?=
 =?utf-8?B?UnNEeTVhREEyb3NzWVZveDFodXAvWXZUYlVMTmlIeXRrRytmYmg1aCtONElw?=
 =?utf-8?B?K0toSHVtME5tOUVPNTN3TkUzYk94YzM5OEpJN0xTRndqYit1NmlTOEw3MWJN?=
 =?utf-8?B?Mk8zZG44ZTNGUGUzNlQzZ0k1blZ4RTFyd0Fidi9YZGRPRFZ2ejBwY2VhQ3ZX?=
 =?utf-8?B?QU0rMW91alEwU2RrOTVlNXdTRkc5RER0VDZiZk9JL2lQYXB1OTFnM08xZmpl?=
 =?utf-8?B?ekg1WkRLKzNacHc1L1BjZ0lEd3ZJK0FEMEJoR1g4UkFBOU05N2NYRmcrcEIz?=
 =?utf-8?B?aDF5VDZpcTJzTWltTVNtSlFMbDA0RUlWWkt3OVVVSDl1RnhuajBIeXBBY2pk?=
 =?utf-8?B?RjBMV0VnbnlmcTBKWUZzN094aEFaSk1nMkswbHVrNnk0anQyYUxqTVY4cmhu?=
 =?utf-8?B?M1NlaTFJSHZqb2NFZ0J3aExyTGRucmNaeXFVY3FiVkpJTnpLS1RNZmsrbWpw?=
 =?utf-8?B?MjJjYzNEZk9sTlg3VUY1SlViN1lEWnRIV29NcVlYWlVTZlBJN2NDWUxvSmx5?=
 =?utf-8?B?S3VPRFZGbGhGL2tkV0RwMmpDQ1RCWDZLb3Rld2JZMk81T2JmZW03NzdtSXFu?=
 =?utf-8?B?OUJFV25PY2djRWNISVI5N3N2dmhCT1B0SUdQWmhiN3VkaE1XU2l5cXprYXBl?=
 =?utf-8?B?QWdyUU5vNHVlOFlLNTlUMTFZNzl6UmpaM2NqZEc3RzJCSkNkMjE5ZnVGdEl6?=
 =?utf-8?B?K2dOZlRVTmRuMGQyVjgvcUNUNzdKYVBxM1RQN3lhV3hNcDZ4SVluRXkybjZM?=
 =?utf-8?B?Y3pxRnVvWUo4UzhVaUN1RU9tRWNKckswM20ydGtneE9KdkhvZG43Z2VXUHNL?=
 =?utf-8?B?L0d6UEc1N3NKeEx0VTQ5eHM1SWRpSWVlbytwK0ZxUkNXVHdrU3VxdVp1VlBJ?=
 =?utf-8?B?TmtWRlhUSGtxZklLUnZMTHVVdmQvWUZQelF1RHNKZFdlQk8yOVY3eHZFaWQy?=
 =?utf-8?B?cGlKSTFOVGJJWTBsNWtuNlUwc0xJeEJHNXlMNVdFNzUxOS9TMW9NdThpeDFz?=
 =?utf-8?B?ZVVKdFJxNENCRHF3ZUQyaVcxWFh2KzUxQ1NFc2Z3SUUwRkJYRTUwR29LdGZk?=
 =?utf-8?B?M2NqZThhSjlrMFNxK2lMVzA3ZjVreXVWODFZSzNoK3JHOE9SZldxWVRJN2Jl?=
 =?utf-8?B?MkZCUTg5ZnlBSVJmN2hrcnBIQTF3UWlTRTZjTllGSkxWMURzVDFzRGFuZGth?=
 =?utf-8?B?dHNoY1pycStuWFFRcElNbk50ZStKTng3RWRacFl4azkzaTNjbmhQOHJkY253?=
 =?utf-8?B?RzV0MXlQOTZuWHRjcHVMRmY0QThUVWI0Skw5T25tejBoNk5UN2VKTXFHN3NP?=
 =?utf-8?Q?jQb1Vkx57LE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0Z2ZmhFUzBRMEJVQUk4THpSNDZCdnNoNEF4OTZrVjFHQStNQUV4cW5ha3Yv?=
 =?utf-8?B?R2JyMXdVblU2TjdjcDhlVXRwcnRmZGN4WHlBOTkzNUhrOGpXc0RpUjh0MEgz?=
 =?utf-8?B?eVIyTXZVaXowRUI1V0o1NUlXQkNRODRPanFEVjRzQ2NYa0l4bVpXeUx0cmZq?=
 =?utf-8?B?K2lEWVRDclVKR0NGQmxCb1QwYnNVNHBEUGRhOVJJODFSR2lwSnVCdUpxZ2tx?=
 =?utf-8?B?VTNKU3RoUFYwcndveHRYZFRUQ2g4citiYmd6VzA5YXphdVVqV3RwcWxKUVJ0?=
 =?utf-8?B?TlBud0ErMXZEdkdoR1p3eHVjNTVnaDdjOUFxU2pkWUZmcjYxMmRSSFE5VDFn?=
 =?utf-8?B?Y3c0SExJcmREbUFjbnVrd2JUYVpKaDlXTVFubEw2ZnNJdjFSWHQxb3lGU2hQ?=
 =?utf-8?B?am9KamE3V05VSm9MUm95RmtZcHcvUXhsVjBhRHlMd3EzbTYyVHpXUVZLdjBK?=
 =?utf-8?B?ZFBuNm5CRWJHdnc5YUtQbnkvd3c3WUZsOVdZTXJLVHQ2U25tN2s4c1Rwakcr?=
 =?utf-8?B?eGRua2tTaHRZSnpiK1BYT0ZodU9yd2J4RUNoNnpHQ0JyaDdOa3liRFRVR1NB?=
 =?utf-8?B?MmNQWnRIVVVBQ3d5YXY2R2JYS2RxRXdqWE5ZUU4xaWlvUFM0QWVybFY5dkFT?=
 =?utf-8?B?SUxzeEZ3M3BTbGVOM0VqVGZxajR3NXZwWWpvUzVyWkdtVlAvaGJKclAzeGlM?=
 =?utf-8?B?YmJRMEZoL3l3Tk9kRjFweFp2WjJSQ1ZaaW1ERXorY1lCU3lldTBRd3ZGa25w?=
 =?utf-8?B?ODd4UTNaUm9ZOGtIUmE4REtCUmtzQy96MHAxZ0JHVTBXZ1hNVU1jRllJSGRL?=
 =?utf-8?B?WlZtaCs1cHJ6KzNvUlkyTlVGWTZIWVRLTEdJUnRrMm1kVFl2VnJWK09tcVNF?=
 =?utf-8?B?Uk9LTUg5WE5sZjdaeU5GYTl4bHlTcmF0aG1JakhEZS9QQTI3bklYZXVCaHFi?=
 =?utf-8?B?Y0x0a2kxVEM0SW9rbHMzQnROZTJ5dGJVNmRqTG81cThTbENtV0ZJcGVESEVR?=
 =?utf-8?B?MXFqdlI2OGhkTm53RG5LeStta3ZNdytueFhSMEZvc09pdlBaLzFFV00wVmh3?=
 =?utf-8?B?dWxTaWRNRVRxQlRnOG5MUThWdXRzZy9lQzhCSXQ3Z1Eva1JTYlE1N2tOY05z?=
 =?utf-8?B?WVo2L3crUm0zVjdKQ2xQajg3Qk1MbXY5YUsxN1IzWXdsSnFSSFZ2SWtRaTFN?=
 =?utf-8?B?bWlNNGgxZjJnWmJZRGM4UWJ1bXF5RUpiVXR0bmFrMnZUWjZFNXcyaVhITTV0?=
 =?utf-8?B?MncraVo2TjlXZTdnVHJiTnBxSUdGQzl5anB6RU5tVFp0RzdVV2QxTmFDaG5E?=
 =?utf-8?B?MVNzcldXbDBweG5iaVI4SWtOT1BoYmtFc2NDY3EwTEZJWmM3RFVoWVgrL3Ro?=
 =?utf-8?B?Qy8rdWRPQ242cktHMTJrUWZ3a1lkNmxrcTFjSEltamtGSXZDYVFqd3dMcFVP?=
 =?utf-8?B?ekJPZytDZGkwaTFSUlZRYzJOUkpPY2Q2Vm02T1lTb2QvNTF3Ukd6c0wrelBS?=
 =?utf-8?B?SFVuTTIzWVZINGFieDJaZEwzMFVEdDhwbzVZbWluMXpjYVVma3FQN29VTHA5?=
 =?utf-8?B?ZkJ0cmVsUVJwR0tJRG9ET0JYcyttS2RBeUdaaUZQSjdBU0diVUc3amI0Y1Fr?=
 =?utf-8?B?SDZwZklmM0dYYUF0TWJMTGJQMGFvR1o5WEl1bER6ZDRwODBXN3BoV2VOWHFU?=
 =?utf-8?B?VWVENGxYU0prejNiaHFOZDQxeDh6VHBQSmhCaUdvRUpsNjJ3WUlJeWhLRmtM?=
 =?utf-8?B?elFPQ2Y1SFVUUmhtV2dYekJjY21zdjBoMVdUQmNuencwUmpHekRsNEZkSzNK?=
 =?utf-8?B?MFllUVd5aGhSRVBGZXFPakVXM0poeWJ5ekNEQWNJRWNBS1FuSUt4QVVFUWxF?=
 =?utf-8?B?WUFnNzZhdFhkWVdwUHVleUVGbm80TlV1dVVFTDMzdUlyL3RCaDVueFUwMGJT?=
 =?utf-8?B?TU02YU9FNlQ4UUlvSm5wektWMVNidTF2VHk3OUo0U01WOFFZOVpoVGlGdWo0?=
 =?utf-8?B?dStvNWNHVzlicUhSQlloN2RmMERScjVNaXFCdFM2N3lwbFU1Nmp1UDVoTStP?=
 =?utf-8?B?WnN0N21XNmI3QXpVK3F0N0hBWjRyWjJTZkRKcEtCTUNQV0p4V2t6WG5hcHNo?=
 =?utf-8?Q?HExOmTBUlfAarTH2RnUb6PHRX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6224.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc97b1c6-e620-4c7c-1e7b-08dcbeae43f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2024 11:18:05.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTtvuFBXett7mbiaz8D81mmIztJT23oQTj2NNwwgVdqD5Q4ve7U4kwdnkX8sFvXD5kikmd2+OyT4dscAiiWK8pIO4+X3wC/yhGB/K+kom0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5077
X-Proofpoint-ORIG-GUID: wnRXpLVPUytlxWGCOhtA9HEEDSE0nSSo
X-Proofpoint-GUID: wnRXpLVPUytlxWGCOhtA9HEEDSE0nSSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-17_05,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408170080

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDMwLCAyMDI0IDI6
MTUgUE0NCj4gVG86IFRpbmFjbywgTWFyaWVsIDxNYXJpZWwuVGluYWNvQGFuYWxvZy5jb20+OyBs
aW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8amljMjNA
a2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsgUm9iIEhl
cnJpbmcNCj4gPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRA
a2VybmVsLm9yZz47IEhlbm5lcmljaCwNCj4gTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5h
bG9nLmNvbT47IENvbm9yIERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IE1hcmNlbG8g
U2NobWl0dCA8bWFyY2Vsby5zY2htaXR0MUBnbWFpbC5jb20+Ow0KPiBEaW1pdHJpIEZlZHJhdSA8
ZGltYS5mZWRyYXVAZ21haWwuY29tPjsgRGF2aWQgTGVjaG5lcg0KPiA8ZGxlY2huZXJAYmF5bGli
cmUuY29tPjsgTnVubyBTw6EgPG5vbmFtZS5udW5vQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MiAxLzJdIGR0LWJpbmRpbmdzOiBpaW86IGRhYzogYWRkIGRvY3MgZm9yIGFkODQ2
MA0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24gMzAvMDcvMjAyNCAwNTowNSwgTWFyaWVsIFRp
bmFjbyB3cm90ZToNCj4gPiBUaGlzIGFkZHMgdGhlIGJpbmRpbmdzIGRvY3VtZW50YXRpb24gZm9y
IHRoZSAxNC1iaXQNCj4gPiBIaWdoIFZvbHRhZ2UsIEhpZ2ggQ3VycmVudCwgV2F2ZWZvcm0gR2Vu
ZXJhdG9yDQo+ID4gRGlnaXRhbC10by1BbmFsb2cgY29udmVydGVyLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogTWFyaWVsIFRpbmFjbyA8TWFyaWVsLlRpbmFjb0BhbmFsb2cuY29tPg0KPiANCj4g
PiArDQo+ID4gKyAgcmVmaW8tMXAydi1zdXBwbHk6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogRHJp
dmUgdm9sdGFnZSBpbiB0aGUgcmFuZ2Ugb2YgMS4yViBtYXhpbXVtIHRvIGFzIGxvdyBhcw0KPiA+
ICsgICAgICBsb3cgYXMgMC4xMlYgdGhyb3VnaCB0aGUgUkVGX0lPIHBpbiB0byBhZGp1c3QgZnVs
bCBzY2FsZSBvdXRwdXQgc3Bhbg0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+IA0KPiBtYXhJdGVt
czogMQ0KPiBhbmQgZHJvcCBkZXNjcmlwdGlvbiAob3IgdXNlIGl0ZW1zOiAtIGRlc2NyaXB0aW9u
LCBidXQgdGhlbiBkbyBub3QNCj4gcmVwZWF0IHJlZHVuZGFudCBwYXJ0cykNCj4gDQoNClNpbXBs
aWZpZWQgdGhlIGRlc2NyaXB0aW9uIGZvciB0aGlzIGl0ZW0NCg0KICByZWZpby0xcDJ2LXN1cHBs
eToNCiAgICBkZXNjcmlwdGlvbjogUmVmZXJlbmNlIHZvbHRhZ2UgdG8gYWRqdXN0IGZ1bGwgc2Nh
bGUgb3V0cHV0IHNwYW4NCiAgICBtYXhJdGVtczogMQ0KDQpTaG91bGQgSSBwdXQsICJtYXhJdGVt
czogMSIgaW4gdGhlIG90aGVyIHZyZWZzIGFzIHdlbGw/DQoNCj4gPiArICAgIGRlc2NyaXB0aW9u
OiBUaGUgY2xvY2sgZm9yIHRoZSBEQUMuIFRoaXMgaXMgdGhlIHN5bmMgY2xvY2sNCj4gPiArDQo+
ID4gKyAgYWRpLHJzZXQtb2htczoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBTcGVjaWZ5IHZhbHVl
IG9mIGV4dGVybmFsIHJlc2lzdG9yIGNvbm5lY3RlZCB0byBGU19BREogcGluDQo+ID4gKyAgICAg
IHRvIGVzdGFibGlzaCBpbnRlcm5hbCBIVkRBQydzIHJlZmVyZW5jZSBjdXJyZW50IElfUkVGDQo+
ID4gKyAgICBkZWZhdWx0OiAyMDAwDQo+ID4gKyAgICBtaW5pbXVtOiAyMDAwDQo+ID4gKyAgICBt
YXhpbXVtOiAyMDAwMA0KPiA+ICsNCj4gPiArICBhZGkscmFuZ2UtbWljcm92b2x0Og0KPiA+ICsg
ICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgVm9sdGFnZSBvdXRwdXQgcmFuZ2Ugc3BlY2lm
aWVkIGFzIDxtaW5pbXVtLCBtYXhpbXVtPg0KPiA+ICsgICAgb25lT2Y6DQo+IA0KPiBOb3QgYW4g
b25lT2YuDQo+IA0KDQpZb3UncmUgcmlnaHQuIEkgc2hvdWxkIGhhdmUgcHV0IGFsbCB0aGUgcG9z
c2libGUgdmFsdWVzLiBJIHBvcHVsYXRlZCBpdCB3aXRoIGNvbW1vbg0KVmFsdWVzIGZvdW5kIGlu
IHRoZSBkYXRhc2hlZXQNCg0KICBhZGkscmFuZ2UtbWljcm92b2x0Og0KICAgIGRlc2NyaXB0aW9u
OiBWb2x0YWdlIG91dHB1dCByYW5nZSBzcGVjaWZpZWQgYXMgPG1pbmltdW0sIG1heGltdW0+DQog
ICAgb25lT2Y6DQogICAgICAtIGl0ZW1zOg0KICAgICAgICAgIC0gZW51bTogWzAsIC0xMDAwMDAw
MCwgLTIwMDAwMDAwLCAtMzAwMDAwMDAsIC00MDAwMDAwMCwgLTU1MDAwMDAwXQ0KICAgICAgICAg
IC0gZW51bTogWzEwMDAwMDAwLCAyMDAwMDAwMCwgMzAwMDAwMDAsIDQwMDAwMDAwLCA1NTAwMDAw
MF0NCg0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBjb25zdDogLTQwMDAw
MDAwDQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiA0MDAwMDAwMA0KPiANCj4gV2h5IGRvIHlvdSBu
ZWVkIHRoaXMgcHJvcGVydHkgaWYgdGhpcyBjYW5ub3QgYmUgYW55dGhpbmcgZWxzZT8gRHJvcC4N
Cj4gDQo+ID4gKw0KPiA+ICsgIGFkaSxyYW5nZS1taWNyb2FtcDoNCj4gPiArICAgIGRlc2NyaXB0
aW9uOiB8DQo+IA0KPiBEbyBub3QgbmVlZCAnfCcgdW5sZXNzIHlvdSBuZWVkIHRvIHByZXNlcnZl
IGZvcm1hdHRpbmcuDQo+IA0KPiA+ICsgICAgICBDdXJyZW50IG91dHB1dCByYW5nZSBzcGVjaWZp
ZWQgYXMgPG1pbmltdW0sIG1heGltdW0+DQo+ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAgLSBp
dGVtczoNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IDANCj4gPiArICAgICAgICAgIC0gY29uc3Q6
IDUwMDAwDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiAtNTAw
MDANCj4gPiArICAgICAgICAgIC0gY29uc3Q6IDUwMDAwDQo+ID4gKw0KPiA+ICsgIGFkaSx0ZW1w
LW1heC1taWxsaWNlbHNpdXM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogT3ZlcnRlbXBlcmF0dXJl
IHRocmVzaG9sZA0KPiA+ICsgICAgZGVmYXVsdDogNTAwMDANCj4gPiArICAgIG1pbmltdW06IDIw
MDAwDQo+ID4gKyAgICBtYXhpbXVtOiAxNTAwMDANCj4gPiArDQo+ID4gKyAgc2RuLXJlc2V0LWdw
aW9zOg0KPiANCj4gcmVzZXQtZ3Bpb3Mgb3Igc2h1dGRvd24tZ3Bpb3Mgb3IgYW55dGhpbmcgZnJv
bSBncGlvLWNvbnN1bWVyLWNvbW1vbg0KPiB3aGljaCBpcyBub3QgZGVwcmVjYXRlZC4NCj4gDQoN
CkxpZnRlZCBmcm9tIGdwaW8tY29uc3VtZXItY29tbW9uIHlhbWwuIE1hcHBlZCB0byBjb3JyZXNw
b25kaW5nIHBpbnMNCg0KICB3YWtldXAtZ3Bpb3M6DQogICAgZGVzY3JpcHRpb246IENvcnJlc3Bv
bmRzIHRvIFNETl9SRVNFVCBwaW4uIFRvIGV4aXQgc2h1dGRvd24NCiAgICAgIG9yIHNsZWVwIG1v
ZGUsIHB1bHNlIFNETl9SRVNFVCBISUdILCB0aGVuIGxlYXZlIExPVy4NCiAgICBtYXhJdGVtczog
MQ0KDQogIHJlc2V0LWdwaW9zOg0KICAgIGRlc2NyaXB0aW9uOiBNYW51YWwgUG93ZXIgT24gUmVz
ZXQgKFBPUikuIFB1bGwgdGhpcyBHUElPIHBpbg0KICAgICAgTE9XIGFuZCB0aGVuIEhJR0ggdG8g
cmVzZXQgYWxsIGRpZ2l0YWwgcmVnaXN0ZXJzIHRvIGRlZmF1bHQNCiAgICBtYXhJdGVtczogMQ0K
DQogIHNodXRkb3duLWdwaW9zOg0KICAgIGRlc2NyaXB0aW9uOiBDb3JyZXNwb25kcyB0byBTRE5f
SU8gcGluLiBTaHV0ZG93biBtYXkgYmUNCiAgICAgIGluaXRpYXRlZCBieSB0aGUgdXNlciwgYnkg
cHVsc2luZyBTRE5fSU8gaGlnaC4gVG8gZXhpdCBzaHV0ZG93biwNCiAgICAgIHB1bHNlIFNETl9J
TyBsb3csIHRoZW4gZmxvYXQuDQogICAgbWF4SXRlbXM6IDENCg0KUmVwbGFjZWQgZGVzY3JpcHRp
b24gYmFzZWQgb24gdGhlIGRhdGFzaGVldA0KDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogR1BJTyBz
cGVjIGZvciB0aGUgU0hVVERPV04gUkVTRVQgcGluLiBBcyB0aGUgbGluZSBpcyBhY3RpdmUNCj4g
aGlnaCwNCj4gDQo+IERvIG5vdCByZXBlYXQgdGhlIG9idmlvdXMgb3IgcmVkdW5kYW50IHBhcnRz
LiBUaGVyZSBpcyBubyBwb2ludCBpbg0KPiBzYXlpbmcgdGhhdCAiR1BJTyBzcGVjIGlzIGEgR1BJ
TyBzcGVjIGZvciAuLi4iLiBJdCBjYW5ub3QgYmUgYW55dGhpbmcNCj4gZWxzZSB0aGFuIEdQSU8g
c3BlYy4gSW5zdGVhZCBzYXkgc29tZXRoaW5nIHVzZWZ1bC4gSXQncyBjb25mdXNpbmcgdG8NCj4g
aGF2ZSB0d28gcmVzZXQgcGlucywgc28gZXhwbGFpbiB3aGF0IGlzIHRoZSBwdXJwb3NlIG9mIHRo
aXMgcGluLg0KPiANCj4gPiArICAgICAgaXQgc2hvdWxkIGJlIG1hcmtlZCBHUElPX0FDVElWRV9I
SUdILg0KPiANCj4gRHJvcCBsYXN0IHBhcnQgIml0IHNob3VsZCBiZSBtYXJrZWQiLCBiZWNhdXNl
IGl0IGlzIGNsZWFybHkgaW5jb3JyZWN0Lg0KPiBEaWZmZXJlbnQgYm9hcmQgZGVzaWducyBjYW4g
aGF2ZSBpdCBkaWZmZXJlbnRseS4NCj4gDQo+IA0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiAr
DQo+ID4gKyAgcmVzZXQtZ3Bpb3M6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogR1BJTyBzcGVjIGZv
ciB0aGUgUkVTRVQgcGluLiBBcyB0aGUgbGluZSBpcyBhY3RpdmUgbG93LCBpdA0KPiA+ICsgICAg
ICBzaG91bGQgYmUgbWFya2VkIEdQSU9fQUNUSVZFX0xPVy4NCj4gDQo+IEFnYWluLCBtYXJraW5n
IGl0IGFsd2F5cyBhcyBhY3RpdmUgbG93IGlzIG5vdCBjb3JyZWN0LiBJdCBpcyBlbm91Z2ggdG8N
Cj4gc2F5IHRoYXQgbGluZSBpcyBhY3RpdmUgbG93Lg0KPiANCj4gPiArICAgIG1heEl0ZW1zOiAx
DQo+ID4gKw0KPiA+ICsgIHNkbi1pby1ncGlvczoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBHUElP
IHNwZWMgZm9yIHRoZSBTSFVURE9XTiBJTlBVVC9PVVRQVVQgcGluLiBBcyB0aGUNCj4gbGluZSBp
cw0KPiA+ICsgICAgICBhY3RpdmUgaGlnaCwgaXQgc2hvdWxkIGJlIG1hcmtlZCBHUElPX0FDVElW
RV9ISUdILg0KPiANCj4gV2hhdCdzIHRoZSBwdXJwb3NlPw0KPiANCj4gPiArICAgIG1heEl0ZW1z
OiAxDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAt
IHJlZw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6
IC9zY2hlbWFzL3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1sIw0KPiA+ICsNCj4gPiArYWRk
aXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAt
IHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCj4gPiArDQo+
ID4gKyAgICBzcGkgew0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsg
ICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsNCj4gPiArICAgICAgICBkYWNAMCB7DQo+
ID4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYWRpLGFkODQ2MCI7DQo+ID4gKyAgICAgICAg
ICAgIHJlZyA9IDwwPjsNCj4gPiArICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8ODAw
MDAwMD47DQo+ID4gKyAgICAgICAgICAgIGFkaSxyc2V0LW9obXMgPSA8MjAwMD47DQo+ID4gKyAg
ICAgICAgICAgIGFkaSxyYW5nZS1taWNyb3ZvbHQgPSA8KC00MDAwMDAwMCkgNDAwMDAwMDA+Ow0K
PiA+ICsgICAgICAgICAgICBhZGkscmFuZ2UtbWljcm9hbXAgPSA8MCA1MDAwMD47DQo+ID4gKyAg
ICAgICAgICAgIGFkaSx0ZW1wLW1heC1taWxsaWNlbHNpdXMgPSA8NTAwMDA+Ow0KPiANCj4gQ3Vz
dG9tIHByb3BlcnRpZXMgZ28gdG8gdGhlIGVuZC4gU2VlIERUUyBjb2Rpbmcgc3R5bGUuDQo+IA0K
DQpNb3ZlZCBjdXN0b20gYXR0cmlidXRlcyBpbiB0aGUgZW5kDQoNCmV4YW1wbGVzOg0KICAtIHwN
CiAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQoNCiAgICBzcGkgew0KICAg
ICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCiAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQoN
CiAgICAgICAgZGFjQDAgew0KICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhZGksYWQ4NDYwIjsN
CiAgICAgICAgICAgIHJlZyA9IDwwPjsNCiAgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0g
PDgwMDAwMDA+Ow0KDQogICAgICAgICAgICBkbWFzID0gPCZ0eF9kbWEgMD47DQogICAgICAgICAg
ICBkbWEtbmFtZXMgPSAidHgiOw0KDQogICAgICAgICAgICB3YWtldXAtZ3Bpb3MgPSA8JmdwaW8g
ODYgR1BJT19BQ1RJVkVfSElHSD47DQogICAgICAgICAgICByZXNldC1ncGlvcyA9IDwmZ3BpbyA5
MSBHUElPX0FDVElWRV9MT1c+Ow0KICAgICAgICAgICAgc2h1dGRvd24tZ3Bpb3MgPSA8JmdwaW8g
ODggR1BJT19BQ1RJVkVfSElHSD47DQoNCiAgICAgICAgICAgIGNsb2NrcyA9IDwmc3luY19leHRf
Y2xrPjsNCg0KICAgICAgICAgICAgaHZjYy1zdXBwbHkgPSA8Jmh2Y2M+Ow0KICAgICAgICAgICAg
aHZlZS1zdXBwbHkgPSA8Jmh2ZWU+Ow0KICAgICAgICAgICAgdmNjLTV2LXN1cHBseSA9IDwmdmNj
XzU+Ow0KICAgICAgICAgICAgdnJlZi01di1zdXBwbHkgPSA8JnZyZWZfNT47DQogICAgICAgICAg
ICBkdmRkLTNwM3Ytc3VwcGx5ID0gPCZkdmRkXzNfMz47DQogICAgICAgICAgICBhdmRkLTNwM3Yt
c3VwcGx5ID0gPCZhdmRkXzNfMz47DQogICAgICAgICAgICByZWZpby0xcDJ2LXN1cHBseSA9IDwm
cmVmaW9fMV8yPjsNCg0KICAgICAgICAgICAgYWRpLGV4dGVybmFsLXJlc2lzdG9yLW9obXMgPSA8
MjAwMD47DQogICAgICAgICAgICBhZGkscmFuZ2UtbWljcm92b2x0ID0gPCgtNDAwMDAwMDApIDQw
MDAwMDAwPjsNCiAgICAgICAgICAgIGFkaSxyYW5nZS1taWNyb2FtcCA9IDwwIDUwMDAwPjsNCiAg
ICAgICAgICAgIGFkaSxtYXgtbWlsbGljZWxzaXVzID0gPDUwMDAwPjsNCiAgICAgICAgfTsNCiAg
ICB9Ow0KDQo+ID4gKw0KPiA+ICsgICAgICAgICAgICBkbWFzID0gPCZ0eF9kbWEgMD47DQo+ID4g
KyAgICAgICAgICAgIGRtYS1uYW1lcyA9ICJ0eCI7DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0K

