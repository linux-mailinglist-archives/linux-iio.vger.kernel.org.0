Return-Path: <linux-iio+bounces-20239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE3ACF124
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 15:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24E97AAD0D
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3D825F78E;
	Thu,  5 Jun 2025 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Aiajd2Vz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958625E83D;
	Thu,  5 Jun 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131011; cv=fail; b=tFgYXWvRehJTGDACCvZMTJXX+yTd3GjgGDFEhuVGXikZc/CBqTzhVmor+2t1HCrk259/S7rq3TPuOhf7YAGIPR4hXgl5KEAkOeD9faHixqffKZkw5f+W0KTc+rcPVpIQ/3MYTR6NSYDmPVd7DCwikwnoW2IVY9V7EV1BxFwUq1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131011; c=relaxed/simple;
	bh=zEW1icrqAb1hOTJ+8uBTRMuj10DptvxKq8h13tKnj78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QIRp+BxZFIYTKbg/80e9Yz76XNcRQrhmVjZeoMDP744VbTOltItylKO1pBMZGeNVr09GIq03uvrAz407Q687nKHxPNAui8y5mWk6hfPmMyhS2gpv8uNIkOTLfSbKEf38iXQHFQB6LsGAJifK7qoSzgZDQSIuVQxQ/3liItFXPAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Aiajd2Vz; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555DGbRr002510;
	Thu, 5 Jun 2025 09:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zEW1i
	crqAb1hOTJ+8uBTRMuj10DptvxKq8h13tKnj78=; b=Aiajd2VzohI2Rz0vH8LXt
	2yBmJhA2b9rIueaGQr3mV0yUxUqQpJ3kBYe45nmmUGGLpBZhF1XpeXKLG2bPJQdd
	K23fS5PLzlU2BvZqxwzFGST6SWKDvuuVfMkquWqMoL/l69GGZ8Qn2cJAzL6nMqUh
	BYuHWlME6MZEQ9ofFn5a4MDh67LJTmhZEDInolPIFcdSgfvU8zXinujfyjTHJ1Rs
	uc3LPIw0V++DY3bPSeo05ik2rTRL2hMkmIDLtbxmoxHfpf1nV4S7auB7MmvuXje8
	65TvYXVd77EmffeTm7CjZ6GbzQWS9enPn/NG/Qtqb0+BANrx9IdoAfgJIYzwU1wH
	g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 472wm4uars-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 09:42:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCuVJQB8p6TDlin44pDc6q5q1qcFNnM/grkqqz7RYPoKrIHrQAgJRLclZ6amyyVeic32kH/zTz0VTWFhOsLpiDaZIqXZS/SA6YMSA+dlJY5p8rDrhNZZszXT9fVaR3+UNBlGXOvsXGnJq03ESCgqGP1OQv7K7wLQSA5BB2As7vdb9kfuq/uBGckZlehjhlNknbqoTneTgzvZSefnBGQXtDPtR5FAl6zOzZlYJKRMu/xdzkWA7KRx3i7kzjJVwRCr8NGL/D8t9Vxf+EBaE2JwSYRLj+88mGdyIl/pzo7ysjWFGq4T6wUd6v0VcXe3kNSaaRRrbXlgmIbDkbwUEo5wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEW1icrqAb1hOTJ+8uBTRMuj10DptvxKq8h13tKnj78=;
 b=uO0ZCJWOO7COiqeZVQHYUdunzdtvbMpshQ44db/1YWOm8Y6z/7iAC2Y3biB9VhlAuKzhDDbepzMAMp51mEEjOwGm9sgm2LaM/9SE+Ibu6jcKSFHAoS3yF1CsSTqqB+7bq7efcpYiWNS6C6nXKWfv+/wlLmJ3dF5X7WkBebBR19MGzqcfENOMovQFI/ZmKWrFPASqSjFiNWMeoIejnwKBBfmU1wVVGZyTerZ9FI6tP5JP5A7LQ0fRUFQvJ4yb81G1KUC0Mhc9g+pC+KxG8yhH2ZH9GuBGJuWBhQYvIeqqB65yAL1OETsBK4OnS2FmwirLz9BbTkYQsi2GPrXrFdxOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6335.namprd03.prod.outlook.com (2603:10b6:510:aa::13)
 by CH5PR03MB7959.namprd03.prod.outlook.com (2603:10b6:610:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 13:42:51 +0000
Received: from PH0PR03MB6335.namprd03.prod.outlook.com
 ([fe80::6e6d:c16e:3cc5:93ad]) by PH0PR03MB6335.namprd03.prod.outlook.com
 ([fe80::6e6d:c16e:3cc5:93ad%4]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 13:42:51 +0000
From: "Ioan-daniel, Pop" <Pop.Ioan-daniel@analog.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Miclaus, Antoniu"
	<Antoniu.Miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        "Schmitt, Marcelo"
	<Marcelo.Schmitt@analog.com>,
        Esteban Blanc <eblanc@baylibre.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 5/5] iio: adc: ad7405: add ad7405 driver
Thread-Topic: [PATCH v6 5/5] iio: adc: ad7405: add ad7405 driver
Thread-Index: AQHb1VWTJV9Tfvg7qUOVVYtohOITTrPzH24AgAFxqXA=
Date: Thu, 5 Jun 2025 13:42:50 +0000
Message-ID:
 <PH0PR03MB63350BE9DC927335D0FEBEE2D16FA@PH0PR03MB6335.namprd03.prod.outlook.com>
References: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
 <20250604133413.1528693-6-pop.ioan-daniel@analog.com>
 <aEBlqPqxd0-C7j63@smile.fi.intel.com>
In-Reply-To: <aEBlqPqxd0-C7j63@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6335:EE_|CH5PR03MB7959:EE_
x-ms-office365-filtering-correlation-id: 1f804983-d737-4e4d-8b9a-08dda436dd95
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1VHcG1MYkpwM3RzU3h2U1V3RDkzRUMwaUZXT1hhNGZwNHVDR3VjdUgrcUVs?=
 =?utf-8?B?MU5yOE9xeGMxZ2F4WkZPdFlVZjc1dVpWQ2MrKzZLMnA5Sm5oVEJTUFM4STA2?=
 =?utf-8?B?cTAyZUVickhmNnF0WXR2MjA4RDIzZXhwbWhYSXZrVDllaEpRa0x2SjVRdUUy?=
 =?utf-8?B?a2ZsQVA5TTFLaEl3ZXg4eFZtY2lKTVZjdU53THN4M1FJS0NFa1Ryd0NlVHIz?=
 =?utf-8?B?K1p6eTRUR1pLRlUweWJ0aDY4eUxha004dUtJTUZNdXZOMUdTMkdSODRpOTlo?=
 =?utf-8?B?Vk9IcnpHSU5BQ1BQZ3FsMGNVekRkQ0p6WlJwb1U2b0RQdE1oZzlKNE1wd0xD?=
 =?utf-8?B?Q3VYTjhlaWg3VjFMUWQwSUg3cHBZV1JqMU9tQWpheUtpK3pGSHR1SGJUQ1Bs?=
 =?utf-8?B?ekM1QlgyZ2g4SzNNY0lhS0R6bDJHeWtraWtPS0xGMWRNeGxZVVRPTzNDUENr?=
 =?utf-8?B?MEFRa0RwNWEvakNUdFFZYUNYQXhxU0xtVG42czhQNDJFcXlwOHVrWm1HM1Z1?=
 =?utf-8?B?NnZtSzhhbE8vMmk3ZERSVkdhakhlOGpQN2tDdVlWeWRWMXdzcFh2bmFUcmZr?=
 =?utf-8?B?WjFLN1MwK0FpMXpNeitINlR4ZmJvUnd2c29tTWYwT3lqY1NsREgrT1FQVU1v?=
 =?utf-8?B?NU5kSlNMUlZZSFIvdURCUjlSNlNxbjRmdnp2OG0zSTczK0E1eTd2MTZXOE9o?=
 =?utf-8?B?LzhtaTBKL1h2S0dOWjFndHFta01NdkxIUjdLcjhIMWVBVS9Kb2lhdjNiVHJo?=
 =?utf-8?B?NndTK2N3UkUzZkswbndENUFtUTNuZ0V5T2xKNkJCQzB5QlFYOHRPY0RzdFQ3?=
 =?utf-8?B?cEJuRnp0aVJpMmFPWHlGN0kyeUlFZU5GOFRESFlaZGlWYUh0b0lmQzdacFkx?=
 =?utf-8?B?aWlsclFnazNzVVkvdUMxczRIdDNpeGY0VGhXdWpBcEVjNm0yVjVOcnhBdGt1?=
 =?utf-8?B?a2ZJQXNvb3dsWWRtZU9xMGtKRXE4eTAzajFIbUxEWnlKSWtRWHhrUzhnLzVF?=
 =?utf-8?B?bmtzaHBWR3FZNWFsdWtVc2VidnNsZ3pBL3ZoV0wvbXdXQ1ZRaHVmaDA4Sk9Y?=
 =?utf-8?B?WmdYUVh0dThLd1FqNUhRTXl1YjFLVnJPUDdvb2tEd0pYbDhwMnFJemlBblp4?=
 =?utf-8?B?UXFVS2dFeDV1aEprTXoxTTBNUnpvaTYwdkFYY3pwelp4VmZJYzI1aFJocEx3?=
 =?utf-8?B?c2dla2tDZjM1M0hOS1NaY2dMaFhHekg2S0NxMHk1Qk9CdjUwQmVEK0I2Tmt3?=
 =?utf-8?B?MmNEVkM0NklHKzRBT2tCV0tpK0dPOXdrV1p0Z2Y4MlVlbEttelFEYWZMdjNy?=
 =?utf-8?B?RFkwQ3d3MElSNVJYenJYSktrUUE4WDkyR00xTElrR1Zha3N3b2xhZ2RhY3E1?=
 =?utf-8?B?U1dFdmdBTzR5TGNSVW5SaUFtQmN1dFczTDRPbFJHM0xkbDB3M0ZNaFEzeUVl?=
 =?utf-8?B?bTQyb1IrNk5CbHhrcnRYTU1ZTUtOZkxiNTlOblM4QnBXRXprRlpva0xmQU1p?=
 =?utf-8?B?bmVVMmF2bWNWeC9DNjFpc08xQTNuM0R1K0RleFFNckdCUnZWMnBYV1NCdFU1?=
 =?utf-8?B?NXhFUmR0bnkzeEN6UVl5TnhhZy9GVE5xSjM2aE82ZGhHZFRMYm54VGN2Y1R5?=
 =?utf-8?B?WVRSK1F3YjNiKzRZTVdqazArL0h0MVRTbDlzODN0dVByRTZ5L216UkFyb05v?=
 =?utf-8?B?eElyOEZzVXRNa21veFVZcDYzOXBwMzFBYmVyYkZRYlZUazlPWW83MFFIcHZU?=
 =?utf-8?B?T2NvZjVndy9YcGpEZ3JiRkdnQnh6VGFXNnk2aGUrdWU0cS9KM205NXIxdjNi?=
 =?utf-8?B?YXpaWnJFeHpRcGVabko2S3FTcUFtUkVsaWNxcUZmRzR2d3JZUUpCd1Nhd2d3?=
 =?utf-8?B?WWp0TmE0UElPRy81MEhUczB2TmladDlBcjQ5QTRvNHlJRTcvSTY0TkErZ0hy?=
 =?utf-8?B?azMveEQxNGE4NWJsZ01qNWw5ZHdVQTBycUkzdWJ0VG5oMTMwdHI0dFRiZTZz?=
 =?utf-8?Q?1H2kvOuPbcJC4JyCbMazNIMhYYtlO8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6335.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3pjWmJ6aU5MZ2czODVxY2VKMVMrR005V0RVcG5lcm1GRmt5TWx0NmM0aWxr?=
 =?utf-8?B?cmMxTy9neEdpVTFSZFdKVGVUNkR0S05ZZk50Sm9CL1VRdXpvMGZJejR5QlJs?=
 =?utf-8?B?VUpObzc4Y3JWakhBZUJ0QnhDMlVLMVdUUVJ4QkY4aXpqTlpIU2F3NVRWLzZv?=
 =?utf-8?B?K3JIZTRpTTEyVFhPbVhheXNTY21paTFIbzFJb08zU2ljZ0FYL1ROQkE2NVhM?=
 =?utf-8?B?TkhsdWhMbGZ6YlZ3eXNFVjBRQnk0dHZ6REtnaWtCUkNKVzFQZ3V0VlJmbDNT?=
 =?utf-8?B?c2YwRkhwNWJGazlmdUcyWWhOK01zc3hvbG43VjNuRXpEN0xzM0Q1THhqeXMv?=
 =?utf-8?B?QkZnSVpTR1VscmFBYStjazBIUzVqZlRINGxBMFJ1VzNMQ2lpbFZQVWlGcmpV?=
 =?utf-8?B?VHduSW51czB3bFZBYlpNNHljUDQ4N0paWjlZWU02RGxWN2FueEpCcDBFeXdZ?=
 =?utf-8?B?V2JxZER6MXRkYjJuTHlGVHNKbzFnRWluaW4vKzJOcUxvZlZNQ0I4bm1aendy?=
 =?utf-8?B?Y3lycEZHNncrb044K0huRUdhWXpCYWJNYjhTbFVnSU5ueGsyZTlGcitveHdL?=
 =?utf-8?B?U3A4NzIyMmhOTnRZenZqYU00aWE5V0VPUGtEMG0wMGtkT3VOVG1uOUE4SDhP?=
 =?utf-8?B?Q2RTSVFERVBnTU5oaVRFTnVtY3RMamJtcGNTUjAyNURRc2tXdmRLUGhJRHVr?=
 =?utf-8?B?SHFjMTFTTFhySVdlcWxBZU5QU1NBTFQ1QWZjeWlrRDRIb29qcVhJZlZka3I4?=
 =?utf-8?B?TXVnRFJCNEZFMVFWc2YzUTFOVXE4dnNpRm5pc3RoaVd2WmpDYlNwL1JwVFZ2?=
 =?utf-8?B?V2NuWkV4UGFoclRIeUtCUjhTamRETUZ4dnJQVGhUZldmV2hZSDgxeWMybmpa?=
 =?utf-8?B?UHdEQ3kydXFNZG5pMjRqaFc2OU9IU2xYV1ZrVGFaZHoxRmVSUHMwVm9JUHAw?=
 =?utf-8?B?RzFqcDhOQkNSSDY2a2RzemJqN3hNODZKZkN1NzJabXlyaU4xWVIwNFBXRHBn?=
 =?utf-8?B?NmNISDlnZndxRFRtM3VZSDhDVFZ2cUNQcHhJNnRjUndmb0diSExhbFk2dEpz?=
 =?utf-8?B?RHhzOVFzZUtqYmkrblRxeUZnOUVHOW5XYlprWUZ3RjNDeDQvUElqME54dHU5?=
 =?utf-8?B?eW9FRHpnazhzQkwvS3ZuaGtOSHFTbUtudkdiL2xqY1V1cEdqZ1Z6OXJubU5T?=
 =?utf-8?B?MTRkeWJ6aVk0bjJkZkNrbmQ4WG4raWJsSnRPMm1uUFl6Yjg0bFJ2NllyRDc5?=
 =?utf-8?B?OE1YY2hLOFRjVUVTdmdMUWhJYmV3bmNqVzdYOUhkWVdIUW1HdmVmeHJFZEVq?=
 =?utf-8?B?UXUxbXlsVVpKU3FUTlErNEhLS3BDOFFpYU5sLzhsVUphREZuc2JUNUxPUnla?=
 =?utf-8?B?RWhjdGdGeGxCemg0M3ZNNVdWTzI2M0pWc2NzazEybUp1UUlNbk5wZmVnNDhn?=
 =?utf-8?B?Ry8vMU1DSXY5c0FtWTNyckFhUmlMOW9jSFl6SGZBbUlKS3p4MHlQWTJsRWhp?=
 =?utf-8?B?Zm1MWUFad3g2ZEVBc2FRTERwT2JSSUFvUmRFdElIdU9KcHJheVhoWmN5cTR0?=
 =?utf-8?B?ZkJicURNYnl2WnFtLzk0SUpwSVp4clZpNDBxb1hpMDlZU0NXcHlNcG1KeUVv?=
 =?utf-8?B?ZE5MNzlyOWV5V3RRa3ZsN3A2bVJTSXNDVDJqQ1hNWFF2SWdTTHByTVB4T01L?=
 =?utf-8?B?aVYvT3RhZUFHTzR5Y2cybmM2bkRWSzdqenZ0Sjd2WitYUWhHOTYvQzRIR3JS?=
 =?utf-8?B?dmpGbUZobEhaUDNyVkRyaFVwYjQ2SGEvYTREWWw4NzZ1c2ZOU0l6N1A4N0Ey?=
 =?utf-8?B?cXk2Zm9nVytpQlhYc0s1VXB1cnU5ZE05UENVQmVBTWM0RG1QS2kzTEtjWGhx?=
 =?utf-8?B?VFpxMHA1TUlaTHpubG1YejYwZkZtU0I4MitFZDBkdFBWTzdjK0VIVUdqNzdm?=
 =?utf-8?B?WkpNSVJTU2tkeHk1cWRKQVB3MUxCSHVLdHdzTHdDaSt6N2ZIZ21PQjk3bUM4?=
 =?utf-8?B?Sm9qbkVST1N3ajhQN1VTeUpWbStPSEphcmRTUW0vOW1pcE5LZE43ZDNUYXBt?=
 =?utf-8?B?SzR1U3cwL0QzRjBZalJIMjF5QlRJVG84b05jZGVKSXlJL2lPVTVLZXJpN093?=
 =?utf-8?B?dTlVNmhnejRrbytac3IvT2V2UzBaYkxRTzRqOFdlbmVUT3gyRlYrMG5KQmtn?=
 =?utf-8?B?QVE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6335.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f804983-d737-4e4d-8b9a-08dda436dd95
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 13:42:50.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s67cua7xMqbXXcwGN2WIi1ns7HKVG1Yrb2y3esIojDtT99WuKMuON+beBMr5tVxc0mK1YIRbUkH9v0JX2Fw+cLOwKieBCs0CJPOPLi76SVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7959
X-Proofpoint-GUID: Fq4N2EuC3BmGZplyco1IPqvCn7IDiY3h
X-Authority-Analysis: v=2.4 cv=LpKSymdc c=1 sm=1 tr=0 ts=68419edf cx=c_pps
 a=KWtdrS0GCFg1xs2m4eMxng==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=fszjNdCi-tmyZtv8EYsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Fq4N2EuC3BmGZplyco1IPqvCn7IDiY3h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDExNiBTYWx0ZWRfX3JfRqESf2OKR
 63QfmtyVAVJg8B9GjOU2JJ+G/DQdoDRgbcsSizdowvZczXSK4O5BNs2CjpU4SiwCfdWkLkpwMmS
 tlVkvmkdeD8OodBNXrP9kapYep27ZUmNRYy+c8sXKtJykR0wbS9MuAIEPBg3enuRHbKwo7BdfYj
 8U9XDYhd71qKIwmoWP8v7NyxZL14+A8MI6IRou5X8KbdZw4kMdkgRePHD/1mLFKnaokR9Be7Loy
 SO3TR3+heTonwAByFBzbIVRzk9ojCr+BKQUDFaMXdvjjyZPmpxGgUdacJASGX/iZr4ihwCjXds5
 xxo4Lr4EZXKV0Lo4XAkKsDuUlKK4d4MzE9qyexA3GiR/uyJXLqs+qhYJWl1HMLhMza4DC2ndSfF
 CNM3aBWWdULiYjWScTFaCE1nqUbfEdkakNlmhERNOQTIcg8qPFSKN7zpzNGmnSe1c/oj7ETC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=412 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050116

DQoNCj4gDQo+IE9uIFdlZCwgSnVuIDA0LCAyMDI1IGF0IDA0OjM0OjA3UE0gKzAzMDAsIFBvcCBJ
b2FuIERhbmllbCB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlIEFENzQwNS9BRFVNNzcw
eCwgYSBoaWdoIHBlcmZvcm1hbmNlIGlzb2xhdGVkIEFEQywNCj4gPiAxLWNoYW5uZWwsIDE2LWJp
dCB3aXRoIGEgc2Vjb25kLW9yZGVyIM6jLc6UIG1vZHVsYXRvciB0aGF0IGNvbnZlcnRzIGFuDQo+
ID4gYW5hbG9nIGlucHV0IHNpZ25hbCBpbnRvIGEgaGlnaCBzcGVlZCwgc2luZ2xlLWJpdCBkYXRh
IHN0cmVhbS4NCj4gDQo+IEhtbS4uLg0KPiBIYXZlIHlvdSBzZWVuIHRoZXNlPw0KDQpIaSEgDQpK
dXN0IGEgcXVlc3Rpb24gZm9yIG15IGNsYXJpZmljYXRpb24uIA0KRXhjZXB0IGZvciBjb21tZW50
IGZyb20gRGF2aWQgTGVjaG5lciwgd2hhdCBzaG91bGQgSSBkbyBpbiB0aGUNCm5leHQgcGF0Y2gg
dGhhdCBpcyBkaWZmZXJlbnQgZnJvbSB0aGlzIHBhdGNoIHJlZ2FyZGluZyB5b3VyIHJlcXVlc3Rz
Pw0KLi4uDQoNCg==

