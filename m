Return-Path: <linux-iio+bounces-21666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEC5B0550B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894161C22108
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E623274FCB;
	Tue, 15 Jul 2025 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="q7j3iUxZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586F271466;
	Tue, 15 Jul 2025 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568552; cv=fail; b=Bt1dcSZHq0Ezs4NSw4Huy4ssBQxz0w7eOUTdPn394Y108KLL5iLVD/6TA5bD/qvtQtSh2t9q8aCXY1RB5lJyoeWmM6e3KKwVF6PN7FGER+y5zAu88+qwjcZDsFHMijZW2prdDmQNsj6DqoX+LcYV1H84jsCkATUY9qshL2Xwnkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568552; c=relaxed/simple;
	bh=LDTPb0Btt0CqqmVDDMBPBCcj1HdWYNc9hblk7DB+bKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u0AGOklBSJyE5k/GZJhl+xeJCK3e6useIRWY1w8skJn24+0l//Bs9O7bxcHaqksmVHwinpDflFLZlcU9F+z21nzBDu80QTFOwCMpi+ynamEVbWNtSHeuUA5T0801ZyioBzKTn88IF6VkvNGjX+Bxv3CVPx3UtOU/8XtP8tgVqeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=q7j3iUxZ; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EMgIdS000387;
	Tue, 15 Jul 2025 08:35:28 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012018.outbound.protection.outlook.com [40.107.149.18])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47uh2mhxgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 08:35:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzYfDVBpV9Xo0/MChCEcyjsCnkY7qoYOczuc8d9TUBOCv726QQp6sxQC30UYB8tlIYEobfZkeXnkUmwS5qzeUMaZvgj9dPELhX0drt0/kWmZ7ksNVQ/jJJV4Q8ISf+svqdk/fhm/bC/6ECISIF1MViHdEeIIwcETMOWYOqJTP2KJx2MMs97wer8S7O7NMJeXkrmmjlPooAe6WkwYapu82tih8EEfoMHvPBiWnD/Sf4vaDNCDrASTpoSQ8enJnrwlkRFsvaerBd6QBi0/UKNNx5i5zINGWkt328zh+7Dnwfb26kG7vqSl9uhv7aJxqEzexzDHq3W3rN2HAwpDb6TqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDTPb0Btt0CqqmVDDMBPBCcj1HdWYNc9hblk7DB+bKA=;
 b=n7nvyXLYcKJBlOF9XBguwDqKQhpkSF/hHAazPCm5XS1ADHfpNWysnxXK/4w+BOFNKHQO/uzvUoRZZGrvU8GRjFfTHA3Ndqxhrk2wiVxs/zY1mLjTaqBTVHELq391XlDG4u4549E18wKChcqMP+GK3eLjNxF/byO+Ed9ceMbdRKG5a0Q2dBGt++Tn0C6sOZMFRNQNw39H8zR2qnoo9XhGgIGP8PnwIrrCUwLh64qUdEaHaKilaP9LRFI+Y5CUrEz08dgJ5J1hEcPsxlE1K5J/VHORllHT8IKKjDub3q/pYb52ME20Aoy2OGD/r8GOVW8IrhI2tACibyGBq9gfjMe9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDTPb0Btt0CqqmVDDMBPBCcj1HdWYNc9hblk7DB+bKA=;
 b=q7j3iUxZhPWhyPaM6k7Kgxutd+8aSaADIZwtmSuJ0mqwFxbmTRtw4/jR08iI3SgY4erxXOoE7jxneFvzQiJWxPu/05qkm9wEjdllvPFtt6ulyVSzev0ml8qtfkWchrRMLkuIq3vwYYzQp7DphJoZHIkODb44IZlkxTLJb2ObJJsQBGsB9pDBCidNsDPnDGOzmjfV6+ztN3/U0DdmQ5Tktj9nqN/Ka4Yib9Zd8FmAEff57sgyISKB9tzuaK1k93x57dSZ+CouVre3Y1JvG3bg4EJA3JaVFM93FtUqVrtN5n1RDTO081typAWBMqOdA7zzb/BxdtZbgN8mW+UFVdtYnQ==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR4P281MB3436.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:35:12 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 08:35:12 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/8] dt-bindings: iio: imu: Add inv_icm45600
Thread-Topic: [PATCH v2 1/8] dt-bindings: iio: imu: Add inv_icm45600
Thread-Index: AQHb8XjGNSzfw0LPWUy8flLtSCneZ7QxIDwAgAG8biA=
Date: Tue, 15 Jul 2025 08:35:12 +0000
Message-ID:
 <FR2PPF4571F02BCBA3AC546A6256C7F95B98C57A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-1-bf76d8142ef2@tdk.com>
 <65d7009e-dc4a-44b4-88fe-b5c7e1ecdfc1@kernel.org>
In-Reply-To: <65d7009e-dc4a-44b4-88fe-b5c7e1ecdfc1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR4P281MB3436:EE_
x-ms-office365-filtering-correlation-id: 3d922481-e086-4860-a9f5-08ddc37a8404
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7416014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWJJTnZOQVpwQnZlOHNKZThLYktFWUNJb0VaZ1F4a1NkQmdnTGhmWHNsMXZH?=
 =?utf-8?B?anJKVklROWEyUkZITVBMeUlTbkpCd2lJSS9ydjQ5SnlZclAzWGFNdUtBdnk2?=
 =?utf-8?B?cExSZWF4a3ZWS0twQlIwbnVLVjZmcVo5N0txUEFOQXFaWU5vTkdwY1c5Z21q?=
 =?utf-8?B?akpScnlsNEU2ZWwxMG43VnlUb3A4ekZ0UEVWR1JxYTFFTGExdlowcU1SQWFP?=
 =?utf-8?B?d09hWUgwZ0lKK0YwNFJjc3dDZFFuQWdMN1BOMlg4SjZxOUpxUTg0YW1yL28x?=
 =?utf-8?B?THRNb0QxaU1NWXBGYkhPNUpZbzJqbFdtR2wxcjZzNWczdGpKTG91S3M4Zlk5?=
 =?utf-8?B?L0NIaHJscUk1OUw3Sks3ZFhxc3oweUk0cUhZSjNkRVR3endNc0VjTlM2U3Zl?=
 =?utf-8?B?YWhkbFQ1eXRxTFdmazQwdmRnYXlYYVFjV0V3TFVTTXpNSXNzcVI5YlZOUmZG?=
 =?utf-8?B?WE1Ka0ZJaWFuODZ4dERXQmJsQTY3SjRRQ1FSQTFQNmpZL3BtcmVkVWg1TFFn?=
 =?utf-8?B?NUJBNDh5bGVlNVFBdHZLSXFidUR0cTNoRHp3Y25xcnBPVTNSVkxaNXdRL2Ny?=
 =?utf-8?B?WThWSktSS3E2RncvWjlKQ0ZWL3QvRDdaVUJvOTQ2UW9WMmd3eFQ4TGJqalBw?=
 =?utf-8?B?Nm56L3gyTEtFVnBYS3pNYmVMM2pUMHRmRVFVMnFGR1ZEekV0cE51UFBmdjVT?=
 =?utf-8?B?Q2pHNGxnaUNla2dMM2ZJamo5MUJxQklEOXBzUW01T2wvMWliWE5tS2Z0dWx6?=
 =?utf-8?B?V3pUV2N2RlpIS3NtcVFTaUVLT3RGTkZoenJFZDRIQ3JIN1p3Y2xFemlFcE1O?=
 =?utf-8?B?VnNaU0dRWDNMNzhzZjgwQ24ycUM0S2JselI0WU5pc2hjeW4weHpuTmcxNktO?=
 =?utf-8?B?L3BPRi9mVWgvYVplZlEzUTdyQ0gveGxER1FObGdCOUlyNlpFQjNNUmthRTc1?=
 =?utf-8?B?UVVFV2VIckV5eTl5ODh1WlZSS2Nrd3pwTXNzNDJnK0ZwTEFFd285SjhMSjhN?=
 =?utf-8?B?bElRTUlRRE1jaW9vWnlLcTQxYSs3dUtmVzR1Q1JTcDd6OUZ0bVNORjJRVE5r?=
 =?utf-8?B?VWUwbUpLZUo1bUJlY05GcWZYQVExNE04Z2pjYTM5K05lSGRLbWN3Tit0NlJP?=
 =?utf-8?B?QVloYUhPVExkYlJQZzhhQkx2RVdwUXV1aHhWaHg2bmZNQ296a0VxYWxmZFBs?=
 =?utf-8?B?T1A5S3FQUHR2TGRnbmZNN01mT0VXQjRwa2Q3NVlOZ1g2bis3dW5qeGh4cmsy?=
 =?utf-8?B?ZldMb2RuV1VVM0t5SWNqNFM5bE10a1BOWjZ5ZEVLeloyNitHS0xFblMzT3hz?=
 =?utf-8?B?Q01QSWowaVBSUHBqN2l4cFJUM1ljcVhTcUhBY2l5QVBvRkM2cGhkc0tHalpI?=
 =?utf-8?B?dGp6OWVHU3FTdzd1bXpxc1N3N3RCRXhPTU1meHFheXlHcUpXUmNINHAwbXh5?=
 =?utf-8?B?TFA2T0xybjB2dlRQN1V1NEFPOVZYWUdqWnAwUzVpYXBzeUgwWHFMd1BwYzFJ?=
 =?utf-8?B?aE05elpqVTZKNDFlTzNSWUNpaUw3Q2tyRnE2aG0wL0JDYUFvbXl6TTVQbG1E?=
 =?utf-8?B?SEl3aEFQb2NwYzZCUWR2MWtHMC92V2pwM1orQTVOcHVGcGFkVmRVaGF6RjRi?=
 =?utf-8?B?NnN6K2VhMFFML1NGZEdpM0dmb09FRnpJSG1pQUMrVXlQYThlS21nK0kyV3Fo?=
 =?utf-8?B?RTlmRTAxMlg4UUNmQ245NVhCbUgrTFRsanBXTStWZ3IvZDlKQVBZK3N3R3Ev?=
 =?utf-8?B?dDBXMkRmbzFZUGlOVUtoSVg0a3Nsa25BRlNYKzJjYVcxaE50NHlHejdPeWlI?=
 =?utf-8?B?R1lhOEtKNDI5ME5lSlVUTE41ekJPVDRLc2swZmVlZzVpOWx5WU9GdTAyOXpo?=
 =?utf-8?B?SWhhaHlCM1EwcVNsckRoZFJMQU1EOXlPc1JadWVxdTVnV21Gc1dVUkFhYlJZ?=
 =?utf-8?B?MGpKaHQ4YS84ZFhxc1NQclBUVUZrUisvV0cxYTNKS0REeHZ4WmZrenkwdkFi?=
 =?utf-8?B?SmhoUFdxTDBCNlJCVzNXczRWWG9oM3hyUGtJVmV5bjdETmVORXpNQlNTUnk2?=
 =?utf-8?Q?TFW5DL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnNCSkRvMUs2dU5uZ3NoMExGcDBQUm5PQmNDcEZlQk52ODM0dmg4QWVLc0lk?=
 =?utf-8?B?SFJpdU5FNTVNUGpmenBnSGQvVWN0YUczbWNVblpTeG5HTzFhN0IzWmNyOThp?=
 =?utf-8?B?YXQvcStac3FrSnphQ0hVUXEvUmVRQXZ3NEErcVRxVmtqZHdkN2JqY0RHQk1M?=
 =?utf-8?B?Z3hyU1E3U1dtdVBZR1ZSSnlaOTkwNk4vM1NYeW1vYjNuNWFJdUVhL1crK2Vr?=
 =?utf-8?B?STJKQi94bzhhWmhhQUVWMkw3d24xNTkyaEpVNFYrc3BvU2ErNUFPTzhuL2dn?=
 =?utf-8?B?WkVXVUg5TjFOL053bXZhaGF2OWxXRVBNcndFbmFuSUluaUZCQTlTK0t4eThW?=
 =?utf-8?B?MWo2SWpLTjRYeisxQThtQ0gzRlk5MHhmTkJZNit1NEpMRWUweTRtdmY4UVRs?=
 =?utf-8?B?d2VDQjhlRzdxQzRMbWxlRkJTNkhNMHltUTZuVmpLSnROOTFJRUFjSDhFODlU?=
 =?utf-8?B?TXowMVpCL0tUVlB6RlBiK3J0SEowQWVlMTNvSUFkQ0pGQlhNTktob3Q5TWRh?=
 =?utf-8?B?MjNHMHdDQmNoUWRWSy82bVNGdnNORENHMW5nL0NHT29WcFUzMTN6TVluZGFw?=
 =?utf-8?B?SitNQ21hbXBNK3laUmdUWm5MTGd2YjdYM01PendWMHVxS2pxVjR5Q1l0NExN?=
 =?utf-8?B?MGNzSStMMFRHekpFZERSSDgxenJnNU5RT3QxeEswTlNtZk84LzVVaFRJTEFw?=
 =?utf-8?B?VE03djBhcUplbEdDcTY1b0YyYXlKdDRPQ3YxQkRRNDV5dHdmMUZLSkZoUzR2?=
 =?utf-8?B?VVJXTkhsak5KbDhYemFwSm1jb0pBUHdBZFlLaXAxWGJCU0ZuOXNXMk5QYUc0?=
 =?utf-8?B?UGdLT3V6amlOOXVNNnY1clVoTFRlRk9EaHRJdjVvQmtrN2NkbW5uMVlReHFl?=
 =?utf-8?B?bFRlUHIxNk1oNzVTQWJsOVViSHN2eUs4VHc4dy9CM1N6N3RHUWJwUkpTejFX?=
 =?utf-8?B?N29jTDJCcjFlWVovSE41NXBIQ01id3djdWw1SHZ6RHl4VU5MYUVxc1hVR0FC?=
 =?utf-8?B?OXdFYmY0UUpiS1ZnTmNtbnNLN3RzeGtrR1pNNlBkNlV6YU9wZ1EyZkdQc2Q2?=
 =?utf-8?B?dUsvbVhzT05GK1kvaWxjL0hYWW91NG96MnFzUU81Vzdva1ZWVXZIeVFzUDlH?=
 =?utf-8?B?YklXejg3SDk3TGo3ckxBNTlFUWZ0NFRlcTBPd01ycXVSQVNwWTNzYUJaV3py?=
 =?utf-8?B?SlBLTC83VGtoWC9xWm9Jc2pkOHMrdWVNRXFOR0dlSVJWS0lwcmxWK0kwdEJV?=
 =?utf-8?B?d0t6OVU1SnltaGhpN0tFbjV5Y2JBRCtEQXYzbGp3Mk5GZHRDdG5MVGxuTkJs?=
 =?utf-8?B?RmIwcXNPUFNyNzAwNmgzQVBlb09OWkI4WjZnY053T1dQa1NqN3MyOVIwSWxm?=
 =?utf-8?B?OHpieURrdUp1dDArcFpSSzBveDhpTnFPYjFnaXREVFpobGptRURya29wcy9E?=
 =?utf-8?B?NXVaOStKWUVqVldTRjVabU9BUHREU2VqTDRoL1lickdiZU9GRmJUUkFJRDlq?=
 =?utf-8?B?QkhndzQzNTZVN2d4SEd5aTc4SFpYOHRVekhYWE82Y0FjMVBHMkdqR25YVElW?=
 =?utf-8?B?eHdIQ1BtN0RzRENPM09uazJzQTVWeEhWcmE2c2gzWnpHZC9IWFp2NWFrU1RH?=
 =?utf-8?B?aytMVWhyc0t5T0FPVnJCakpMWHNVVjFSbVkxVXZYMVpDdDJRWnRyZXFhUjVI?=
 =?utf-8?B?MTVUVHpJMlliR3o0b2lWYXVER3NkM3FySG03RTk3bXNoQ0FCZ2F6djFFUzJj?=
 =?utf-8?B?SGlxVWwrTTcrSDVoTVFvdVM4YUIxclFKcGpXWXprbkVva295Z1NFVXdpQ2Ey?=
 =?utf-8?B?S2FrQ3dVUFJRMDFqcDUrQ0JKN0NsKzEyNXo0VHlOQmQyaGVsTDRGYjg5ZEpF?=
 =?utf-8?B?Tkg2MUxDU0t6M1JKMnFRNEtnb1VLNGhiczhYK291QWhyanBad1cyOC8xTnZ3?=
 =?utf-8?B?UVRId2p6Z0dpV0psNm5zbEM4eVkxbVlBZ1N2My9wTWMvaXhUeWh4S0Y0S1ps?=
 =?utf-8?B?amI3bityQ0h4ank0VEpaWmlISGM5c1p5M0sxa0VEbWdybEhQRkQraXl3Z1hG?=
 =?utf-8?B?dUUzb29PWWFVL21md1RjenduOUl0bFdXdXAzMHFiYm8vZ2xQWVdtc3IvbSs4?=
 =?utf-8?Q?3bVSxWOsM15OB1+7be+/DRcQ1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d922481-e086-4860-a9f5-08ddc37a8404
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 08:35:12.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvVGkCeZRqcxZNrbzaDpBdZHbNKl0DWA2oKdEkOPKyaTxgBqsdPRyXM8N3V6MO17GcCwHANJ8Qkabxz41OXGyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3436
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA3NyBTYWx0ZWRfX2ug2nKeK+kkC
 MAGUf2puPdkI6sRnXl9SzlCMVHOH2iLmRNhwgzzfc6Xy0ygMqrqGoAV2DY8HqStalPK2AMpirB6
 94yi0m0KjSxY9VXWX7mBeO05d7ZE2M8W+s94ZwCKB0pkQNvtzqLMiYWMz1m6pG2zfSTzEz975lb
 UhebtWWHztOl9wiEd871llhijbO8raxonM6MqN6IUCbmiFwZtctoTU+ItX0dMelffaSvDWIfFzd
 WQmzY0MnVAvEfNxv9K3Y33RPpFBNZtGpie8pLkDs0bI5UUOOtcnvrfEFCNdjOXDabNrkYbIn2b2
 wYXVPdZN1YcgyHa2CnSe5jUXlEZRNyeHW4razyFx9MlN+NFot1KkJwkz4LNEGgBJ17V7HnxSybh
 iYpBxmG8AlV+fbchU9MJf/TdLlLWTgdkYawprvw2M+jDspxC7vqOuOt6JxDfbVYIi7HcRwLz
X-Proofpoint-GUID: v8817ofP3lRRGbv_9Xiccoec78zW0Alv
X-Proofpoint-ORIG-GUID: v8817ofP3lRRGbv_9Xiccoec78zW0Alv
X-Authority-Analysis: v=2.4 cv=MdZsu4/f c=1 sm=1 tr=0 ts=687612d0 cx=c_pps
 a=5NL3v2yKTvONhDxV9W2bFw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=Y6JY5ha0l-_eApP2-78A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150077

Pg0KPg0KPkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4gDQo+U2Vu
dDogTW9uZGF5LCBKdWx5IDE0LCAyMDI1IDc6MzkgQU0NCj5UbzogUmVtaSBCdWlzc29uIDxSZW1p
LkJ1aXNzb25AdGRrLmNvbT47IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBE
YXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoSA8bnVuby5zYUBh
bmFsb2cuY29tPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwu
b3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPg0KPkNjOiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS84XSBkdC1iaW5kaW5n
czogaWlvOiBpbXU6IEFkZCBpbnZfaWNtNDU2MDANCj4NCj5PbiAxMC8wNy8yMDI1IDEwOjU3LCBS
ZW1pIEJ1aXNzb24gdmlhIEI0IFJlbGF5IHdyb3RlOg0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAg
ICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWluSXRlbXM6
IDENCj4+ICsgICAgbWF4SXRlbXM6IDINCj4+ICsNCj4+ICsgIGludGVycnVwdC1uYW1lczoNCj4+
ICsgICAgbWluSXRlbXM6IDENCj4+ICsgICAgbWF4SXRlbXM6IDINCj4+ICsgICAgaXRlbXM6DQo+
PiArICAgICAgZW51bToNCj4+ICsgICAgICAgIC0gSU5UMQ0KPj4gKyAgICAgICAgLSBJTlQyDQo+
DQo+VGhpcyBjYW4gYmUgc2ltcGxlcg0KPg0KPm1pbkl0ZW1zOiAxDQo+aXRlbXM6DQo+ICAtIGVu
dW06IFsgaW50MSwgaW50MiBdDQo+ICAtIGNvbnN0OiBpbnQgMg0KPg0KPmFuZCB1c2UgbG93ZXJj
YXNlIGFueXdheS4NCkhlbGxvIEtyenlzenRvZiwgdGhhbmtzIGZvciB5b3VyIHJldmlldy4NCk9r
LCBnb3QgaXQhDQo+DQo+PiArICAgIGRlc2NyaXB0aW9uOiBDaG9vc2UgY2hpcCBpbnRlcnJ1cHQg
cGluIHRvIGJlIHVzZWQgYXMgaW50ZXJydXB0IGlucHV0Lg0KPj4gKw0KPj4gKyAgZHJpdmUtb3Bl
bi1kcmFpbjoNCj4+ICsgICAgdHlwZTogYm9vbGVhbg0KPj4gKw0KPj4gKyAgdmRkLXN1cHBseToN
Cj4+ICsgICAgZGVzY3JpcHRpb246IFJlZ3VsYXRvciB0aGF0IHByb3ZpZGVzIHBvd2VyIHRvIHRo
ZSBzZW5zb3INCj4+ICsNCj4+ICsgIHZkZGlvLXN1cHBseToNCj4+ICsgICAgZGVzY3JpcHRpb246
IFJlZ3VsYXRvciB0aGF0IHByb3ZpZGVzIHBvd2VyIHRvIHRoZSBidXMNCj4+ICsNCj4+ICsgIG1v
dW50LW1hdHJpeDoNCj4+ICsgICAgZGVzY3JpcHRpb246IGFuIG9wdGlvbmFsIDN4MyBtb3VudGlu
ZyByb3RhdGlvbiBtYXRyaXgNCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJs
ZQ0KPj4gKyAgLSByZWcNCj4+ICsgIC0gaW50ZXJydXB0cw0KPj4gKyAgLSBpbnRlcnJ1cHQtbmFt
ZXMNCj4NCj5NaXNzaW5nIHN1cHBsaWVzDQpBcmUgc3VwcGxpZXMgYWx3YXlzIHJlcXVpcmVkID8N
ClRoZXkgYXJlIG5vdCBwcmVzZW50IGZvciBpbnZlbnNlbnNlLGljbTQyNjAwMCBub3IgZm9yIHN0
LGxzbTZkc3guDQo+DQo+PiArDQo+PiArYWxsT2Y6DQo+PiArICAtICRyZWY6IC9zY2hlbWFzL3Nw
aS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1sIw0KPj4gKw0KPj4gK3VuZXZhbHVhdGVkUHJvcGVy
dGllczogZmFsc2UNCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+ICsgIC0gfA0KPj4gKyAgICAjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4+ICsgICAgaTJjIHsNCj4+ICsgICAg
ICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47
DQo+PiArDQo+PiArICAgICAgICBpY200NTYwNUA2OCB7DQo+DQo+SXQgZG9lcyBub3QgbG9vayBs
aWtlIHlvdSB0ZXN0ZWQgdGhlIERUUyBhZ2FpbnN0IGJpbmRpbmdzLiBQbGVhc2UgcnVuDQo+YG1h
a2UgZHRic19jaGVjayBXPTFgIChzZWUNCj5Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvd3JpdGluZy1zY2hlbWEucnN0IG9yDQo+aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vd3d3LmxpbmFyby5vcmcvYmxvZy90aXBzLWFuZC10cmlja3MtZm9yLXZhbGlkYXRpbmct
ZGV2aWNldHJlZS1zb3VyY2VzLXdpdGgtdGhlLWRldmljZXRyZWUtc2NoZW1hL19fOyEhRnRyaHRQ
c1dEaFo2dHchRHNlNnpJcWdSbVE4bnh6ZG1wQzdVdTk2V0JWd05XYnFsXzRXbmZQd2p1SVNiYXV2
N0dHc0RPMnpTRFRxNFRFelNlYjBzNmZjYm1GUiRbbGluYXJvWy5db3JnXQ0KPmZvciBpbnN0cnVj
dGlvbnMpLg0KPk1heWJlIHlvdSBuZWVkIHRvIHVwZGF0ZSB5b3VyIGR0c2NoZW1hIGFuZCB5YW1s
bGludC4gRG9uJ3QgcmVseSBvbg0KPmRpc3RybyBwYWNrYWdlcyBmb3IgZHRzY2hlbWEgYW5kIGJl
IHN1cmUgeW91IGFyZSB1c2luZyB0aGUgbGF0ZXN0DQo+cmVsZWFzZWQgZHRzY2hlbWEuDQo+DQo+
KHNlZSBob3cgb3RoZXIgYmluZGluZ3Mgb3IgRFRTIGNhbGwgdGhpcyB0eXBlIG9mIGRldmljZSkN
Cj4NCkkgc3VjY2Vzc2Z1bGx5IHJhbiAibWFrZSBkdF9iaW5kaW5nX2NoZWNrIiB3aXRoIHVwLXRv
LWRhdGUgdGVzdGluZyBicmFuY2guDQpJJ2xsIHRyeSBkdGJzX2NoZWNrIGFzIHN1Z2dlc3RlZCwg
dGhhbmtzIQ0KDQo+PiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJpbnZlbnNlbnNlLGljbTQ1
NjA1IjsNCj4+ICsgICAgICAgICAgICByZWcgPSA8MHg2OD47DQo+PiArICAgICAgICAgICAgaW50
ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzI+Ow0KPj4gKyAgICAgICAgICAgIGludGVycnVwdC1uYW1l
cyA9ICJJTlQxIjsNCj4+ICsgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDcgSVJRX1RZUEVfRURH
RV9SSVNJTkc+Ow0KPj4gKyAgICAgICAgICAgIHZkZC1zdXBwbHkgPSA8JnZkZD47DQo+PiArICAg
ICAgICAgICAgdmRkaW8tc3VwcGx5ID0gPCZ2ZGRpbz47DQo+PiArICAgICAgICAgICAgbW91bnQt
bWF0cml4ID0gIjAiLCAiLTEiLCAiMCIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
IjEiLCAiMCIsICIwIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAiMCIsICIwIiwg
IjEiOw0KPj4gKyAgICAgICAgfTsNCj5CZXN0IHJlZ2FyZHMsDQo+S3J6eXN6dG9mDQo+DQo=

