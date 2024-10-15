Return-Path: <linux-iio+bounces-10601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7799E02C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 10:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF212835B8
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 08:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A021AB512;
	Tue, 15 Oct 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TOoT2WJK"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6C19ABDE;
	Tue, 15 Oct 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979358; cv=fail; b=MIHKKn5ICV84Hrh8y0B+8uj5t1u7yzlBKLgU64e6C20p9gfn+GbnDAYUxxHPE7Rs8tsrrh3MSX5a1/8aYN+a506w3t4ZR4A6LluyT8Si2EkBfeLkgXtP9CLuafOf5iru0QHJxgao/bhjiXpNxahQMGejSSx2NrrPgPseiW6gxrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979358; c=relaxed/simple;
	bh=Ew3GSTNMnw0oGuqOyWPnzRU0YXsMggpAlvAcgk7cygg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qH8e1/qYK7q5aAv2L9cRDrXYOKyke2UKrvvbfwUMrQ4r8zVE8qzcgeSByseIy7NtXwkMK1LJUjh/J73rGOmQKHSTitKZ9vfeEboiMhJar0NwO5xxXijPyhcDxD/6mcN25eXeuCN1EXgpwy63JWjbWlqJ8xYgb+gBR2UVLnt85vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TOoT2WJK; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQeoMZC5VenakNH5MYXn6CHHNwFCk4vi8epSI4szRjZKUNpoUKGI/GLOSwVaHxhvBcrTgdV+EQZZCLA5WxLTWDWx53QXS9Xf7O36vRpsRgO7rCcVGCvhH6F0+u69GsbBf9xij9PBfh4d0xAjYQPIXuCLQvkW4GVaS7NWoITUOoAhB6NZtDUDkJvvz498LjaW3iw18/z26TMqy2aLzb2Ppbo+2OG/+9CigGklzFpmS51vM659534Eu7hV3ljohuxwjan1IMagy9dwrX6iktaOvMligXHBg+QTZHrtZenWTQ6Tq5qKPVV6j95P8bcRqXjXCHMFwncZNoow30h0t95FdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew3GSTNMnw0oGuqOyWPnzRU0YXsMggpAlvAcgk7cygg=;
 b=is8FGIlAUQXfyMdNPmnVTVAQ00Qvf2pWiZBe8IKAxtgpE1oCJ1iWKzzR7n/oqWZRMpPaWLXDYpk07JLV4wxcplBpl0Ko7dtLY8fg/6x2t1jPnCqeghgLRNqTSgdJRsIIOBhUfqC/WbnJPC7nDGzWDLY/ETCyJ3uUqf1/vZhpLAwOx14pNNmuZ5XHixvuT8oRkLsTAxdVrJoKZVoqxa3YZyxrh0VYipD/Dqv/yxtsOkhPXGkRjbuJi04JXyXw0RSJSiWd8T12eiJuHyOQhhaMED0eR312bBhzYaDDTeBc+LyNCgWM/V57QiNx1/uG2FTVNQfq8aLyqTl4RHObAnokGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew3GSTNMnw0oGuqOyWPnzRU0YXsMggpAlvAcgk7cygg=;
 b=TOoT2WJK05Ch36aPpTKObKmlS3GoITOllZ1TfszduuLS+9zC+0IixtEa8KdYM5aRYg5RUnC9KA0JDEaf3RvxvPlprBtMBb7VnaPn0cpwL2k9sqZUs1zC/LpM3hVuKdCkcXRszOFf/xu2cqyhIG2qTyHr9fQYM0QzvNJdr8eo019p9ckIe6CAWOLxaevzctEcf6wjwH41CNFD/lBvzFaruaOinnbN3vgWEJUebqqou7d2CaA5sLXyWXWs6DjbkRkE6Yag3F2JsMkK+hAweyhdkEGPBasapkzvQGq1KX7wfLsJMs89l5luW4sXNOTFrWDgLtMy3xt9wviTN1VvSYqssg==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by CY8PR11MB7898.namprd11.prod.outlook.com (2603:10b6:930:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 08:02:32 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 08:02:31 +0000
From: <Victor.Duicu@microchip.com>
To: <jic23@kernel.org>, <matteomartelli3@gmail.com>
CC: <Marius.Cristea@microchip.com>, <lars@metafoo.de>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3] iio: adc: pac1921: add ACPI support to Microchip
 pac1921.
Thread-Topic: [PATCH v3] iio: adc: pac1921: add ACPI support to Microchip
 pac1921.
Thread-Index: AQHbG+PKEPvLhD9Z8kyz4OqBIGT5XrKC5MYAgAMlW4CAAF6LAIAAMjKAgADehAA=
Date: Tue, 15 Oct 2024 08:02:31 +0000
Message-ID: <b068aa0765abc36890b3d88e8a71234a9e47be74.camel@microchip.com>
References: <20241011134454.45283-1-victor.duicu@microchip.com>
	 <172872753469.9340.10387646359307852048@njaxe.localdomain>
	 <e4cad20ed2f8d31bf71bc595ab54c64d96bfb4b4.camel@microchip.com>
	 <172892078642.158534.11658754591922958169@njaxe.localdomain>
	 <20241014194605.285e3909@jic23-huawei>
In-Reply-To: <20241014194605.285e3909@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|CY8PR11MB7898:EE_
x-ms-office365-filtering-correlation-id: 333f0a3f-ac81-4365-f713-08dcecefb879
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDlJUkcyRHlzTnpIMVA1WUF5YnVpSFJQeXBkc243NlRRRURHa0p5eHU5aUtN?=
 =?utf-8?B?eG9XQ3V5am5LMTRtYityQ053S28ySHZ5aXhZNVhqaUZRM0hvYWhKeFRidnFz?=
 =?utf-8?B?Q0V3eUlPa3E2d0hCRThqc1ZCQWtWM3VYa3dWYnhCV0pkSm9tTEE5NGQyVTJt?=
 =?utf-8?B?WXg4RXRjOFZiRjJHV1UvTHlERkRzYUl0T0w2WnIzVUlBUU4wazNEbEc5ak5u?=
 =?utf-8?B?ZUFSOWxwZklVNzBDbUJrWmo2Sm5ndVlqby9CL3NoUHRDdHZlTWptcENEMWpl?=
 =?utf-8?B?VVBpYmtkUkIwbnB4RDNvOWN0amJTVWJldWFmQVJJVk1aeTA0RGJ2S0pCS0Qr?=
 =?utf-8?B?eG1aY1Y1Y1U2aHhkQ0ZRVnlTNTRnQlZZSzJHdVZvQnpMKzNwdXVzOFozeDZs?=
 =?utf-8?B?R1dRbmJxSzVYbTF0eU82c3hmSlpPRm1sSm0xTk05dlhTUzEwY3VBbllWMXpk?=
 =?utf-8?B?dHBWKy9MdGFvRHhWaHZOSlBNSW4wRU9UNlZRU1dLUE1jUFowK3pvUG1abS85?=
 =?utf-8?B?RXp4Sk5yMUJYSmxLMHNVVFdxdWhOL09ES3Q3SEVQdzA3ZFM2dldBM1BXZi94?=
 =?utf-8?B?ODNmaDdhbWFCaFhsVVpsTTVXYXk5ajVzU0E2NkY1eFh0VzhNeGFBN3l1MDdu?=
 =?utf-8?B?TE9uVXk0VEJjcEpWTGdFbmRLUFcrNm5wSHBRbjZkUzl4U1U0aGlTSGVXL2wr?=
 =?utf-8?B?RFFUbzd1ckxjZWVKTXhDNmFZV29RTVU0K1Q0THlRSzVqVTFhc0J3V015SEJY?=
 =?utf-8?B?VzlIV2VpeDJpREZQU2J3SmVsckQxSHBxS0dRRkZ4YlVua1F2VDc4M1NnWCt5?=
 =?utf-8?B?enFXRWRKRFdWRUl4dHhhTDh4TDk4ZHB2Mzc2TzZETFhIellSYnRzMytxMWhO?=
 =?utf-8?B?YWdRbGFGSy9wUFE5ZEtINTVGUG9aMXgzVktBY3loSzl0cFdmNW5zWUVjdits?=
 =?utf-8?B?RkRaZG4xY0h1OXNzZitaWGVGRzRzbk9QVnp0RzhqRWFiUFhvOVhMOWNvbFpa?=
 =?utf-8?B?VFpOVzFjODJWMVFaTUd6czJkcnZ2TXJNMXNMK1h0dXJBUFVvd2ZNWmJjYkVW?=
 =?utf-8?B?VGUxTDZvbW9SMzlNZ0I3QUJLS3Y4cUxkQ0pXQkV3WDVLYlRUTUVLb0o2TkFI?=
 =?utf-8?B?V2ozMHdhdlNjWUEzSUJFSkhueFdEK0YveUNSakE0WjQvNU5taVV0MG9SOWpr?=
 =?utf-8?B?d3kyVXA2aFN1QmgvVEhtZ2RtTk9LQ2tRRHgvM2FFWEZXSWdvTDZCb3JFS04z?=
 =?utf-8?B?c1R6S3BzQlljMy93MzNJdlpmUWMvZ3lXdHgvcTl0cTlnTTdtWnZBTXJ0bnUx?=
 =?utf-8?B?bTh0THBXdmswNEozU1UzeWNoNkI5RWpKdktBaldXazQ3b0FDZkZMM0poMUxq?=
 =?utf-8?B?OCtRN2UvRDloemFxckt4K1pKRncrZ1pKRDdlUXdhLzBsRnN0bFdqMklqaFlS?=
 =?utf-8?B?OHl1Y280UGZmb2lzK2hrNnBMdVZ6c29sSEUvSUdvY2RLNmFHMUxHWDlNczdR?=
 =?utf-8?B?anZqK1BLUFNFeU5VZ0JuL1JSeFd6dnFuTGx3NFBlWlVZSW9MMEs5ZlhFS2pM?=
 =?utf-8?B?WDZFenUvYXA2NDRIaE5EZFBuRDM0d0NDU2NtL2lRRUM5UmJOUjh6aEEyL1Uw?=
 =?utf-8?B?a1o5Mzh3UnlpRW1TODVnSEs4eUcvMUZWYVcrZC91ZHpodkhleDdqN2RkUElR?=
 =?utf-8?B?a1N0MHRBTjlDdlRXcE92MWtucnBGeEg0TUR0NDE2cGlJdnkxYzkxWEhTVFlx?=
 =?utf-8?B?TDlUREhyUGUzajdNakJ1QUZDSllna05xdENoTUFJY2xrcWltTGxiZ2ZEdXJt?=
 =?utf-8?B?YWlPYW9LbXl1cDZOV21RQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmVOMDNXbTkzWnFzN3paQ2F2MEluYUVCK0kzcmR2aUFDQkQzdjJVbVVkRzcw?=
 =?utf-8?B?V0J6WXlocUw1ck84UnJGdDVlQ0NGeVlMamYzTjFNbjMrcVJvQ0VhREVBSFoy?=
 =?utf-8?B?UDNURFhOeVlESzFGaTVjNThCWVJXSm5UclREVDU1Q2w5d0hVeUl5NFp1UExJ?=
 =?utf-8?B?TElmRWpwUlhuVTJ4dC92OFZ4Qy96YVUyYmZRMjdYT1pkUFg2VXVidGZQcVhF?=
 =?utf-8?B?THkxa25rL2dtb2RaWkJKZVc0d2gwNEU3cFVOV2E2Z0t3aHhmemRIaWxGaUFD?=
 =?utf-8?B?VDdURWpLVk1tOGdUYnNyRWVBaEp6NXk0YXp6YVh3UHFwV0VTOWRTcGpvU3FQ?=
 =?utf-8?B?bjI1TU5XZzhSU04yN1dJNXVPbDY1TDBDaVh3ZEpSVmJtRUpyeXJCcE9yR25E?=
 =?utf-8?B?OWlkV1FXdXFqSDNCdjFTclVmaUEwdkJwdmtHbUtpNUtWVk1HTyt6LzJ4TXhJ?=
 =?utf-8?B?MC8zcDgzaVAxZ25MLzVVOU16S1IwcDNnMXZ6ekFRZzdrUklOY0RZclcySW1C?=
 =?utf-8?B?R2dtamFqVjQvb1YyUkIxSGpxMVVBS2U1eGRvRVRzVXo1SWE0OTZFS1lkTjZr?=
 =?utf-8?B?d1U4WjFkN284aTFidHJoUHhHb2ltdjhpdnRCdFdGZzZlOTgvNEpsNjRyTnJq?=
 =?utf-8?B?TkI2QWROZllSTEVQenEwZkF1bHpRWFgyYldkQTBobUM4S1VwK0R5VDdVeE4y?=
 =?utf-8?B?UDF2SUNDd2pNL2daVW1KUGtwR2Y0NEFBYXFlR0M0TUxWQWEydUpRZHUwa3ho?=
 =?utf-8?B?aTlhZisrZGozRjN2d3FQbFFVcUVHYVh5T2dxWndKSmthSXI1TytaMTJWT2JV?=
 =?utf-8?B?REI4Nk0xWC9oc2tNNlZFNll0NktvVm5QRTkycWE3akdGU1NNMXkxQmlBbm9Z?=
 =?utf-8?B?dld1SVI5MGZrYmFZSnB6WURJTDhYcjg3dlppa2NoSlo0SUdydGU5NkpucnpW?=
 =?utf-8?B?OXRrVFFLWTduWW9mb2dHaERja1VTdENTN2ozemtxelQ5L1I4K1F1WUxIZDIr?=
 =?utf-8?B?WC9hQjFoeXF1UUo0MzVYeEVueG1jMWNvUDRWN0kvdC9rNE5qMXdSVTBJT21M?=
 =?utf-8?B?dnlFaURvWjVqV1F6eXE0eHpiYlovSVJsTUJxVXdLUkowMVB1RnFiS09KT094?=
 =?utf-8?B?Zjc2eVUxVHJYRDdCRGt6d21MWHFFWE9IZEh6T2lZOFB6eS9CNUQrblAvYXhQ?=
 =?utf-8?B?NXB5NnVKaXJtdm9Bd1NwYmcySDRXNXV6WFVDbWZjbGJIYllaR3NhZEVrVDdm?=
 =?utf-8?B?eERJbzVjOWtaQno2OVpZM2l1cFBMZmFGazZUVDBNWnd0RllHY2owenRCdHQ5?=
 =?utf-8?B?WkdBdTdnRU9ISllVclIvd0FBYzZmY1BHS2Jma2cvR1AvcWdPY2k0Y2lrNVVp?=
 =?utf-8?B?ZklCbHp4cmsycCthVkMxSzBwUzdFdlVkZXBnaGxXQXdpT3EzVEx5Q3d4dXEv?=
 =?utf-8?B?K3dDRlNrYXJhc2tVZDRKdVpYUkRhM3RJbzkyWlBxdUR0VFV1QlRzRXVEdWdI?=
 =?utf-8?B?YzJJZWtjblZDUXVxYTBSWlR0RVZkTDZwVzRhYldLNVFiT29LWlJ4T1dVZGFG?=
 =?utf-8?B?Y2dMUU9RNXZ5eG90ckpiTFpncEZlR0RkL29CTDBwdGdqUWFjR2hsK2V3dFNz?=
 =?utf-8?B?TXVESkRKSTFNWHV1OWk0N0FSczVpcUZRRmFYWHBBMHM5UkdLYlRMK1lKZWZs?=
 =?utf-8?B?eUc1ZkdjV01uTjRVby9SR0RJRFZ1dHhDeDBwc1laalprZDF4TzJ6R0ExK0xV?=
 =?utf-8?B?N1Q5eG5Bek1vbHFWemE2Zk5IVnJ1b0dQYksyTUpkZGVnc1FGSU0rdS9KSWlT?=
 =?utf-8?B?aHpHMmF3Sm9EQjlBc0NzZFdEL1hNU2duekRGckNhMGhhUEpUK0RLNVBtejZP?=
 =?utf-8?B?S3FrN0syQi9JL3hpaEFZYXVNSnJ3Q2V4a01oMWgwUXZPTWc5QVp1c2V4YU9X?=
 =?utf-8?B?am9WTWlmVzd4SGtsTUo3M2NHL2JDaGhWbTRZRGRUdGhZM3JKazluWk0yNE54?=
 =?utf-8?B?dWMwNk1tT055Njd1SFRLU1Nyci9OV3JFeThBbXVSUjkvWGVmeEZQTVFXNG91?=
 =?utf-8?B?WXJBZHpIVEdlN3g4ZTdIR3FhWWpkNUp1UDBqQ0Z4Z0pxYkdjdmIzS2xvRm54?=
 =?utf-8?B?NFBiRnBvUmxKaVBNWlVBRm4yWGhoSzEwNU1JY1R4d3hOM2pkZmZXNEZndlFy?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <180B61B2F323D84E9C5C73A1739471EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333f0a3f-ac81-4365-f713-08dcecefb879
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 08:02:31.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ghgUQQE0+cD5UBrHgF7iNAGayEN/77sQ/ZzsmQYmvNPEp3/yyWGRBD/scacQQXxwuaos4YSk0vDbM1FmqT5vY3MXYQixFuY6VsxT0bzt9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7898

T24gTW9uLCAyMDI0LTEwLTE0IGF0IDE5OjQ2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+ID4gDQo+ID4g
PiA+ID4gK3N0YXRpYyBpbnQgcGFjMTkyMV9wYXJzZV9vZl9mdyhzdHJ1Y3QgaTJjX2NsaWVudCAq
Y2xpZW50LA0KPiA+ID4gPiA+IHN0cnVjdA0KPiA+ID4gPiA+IHBhYzE5MjFfcHJpdiAqcHJpdiwN
Cj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ID4gPiA+ICt7DQo+
ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBpbnQgcmV0Ow0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAg
c3RydWN0IGRldmljZSAqZGV2ID0gJmNsaWVudC0+ZGV2Ow0KPiA+ID4gPiA+ICvCoMKgwqDCoMKg
wqAgdTY0IHRlbXA7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgcmV0ID0g
ZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTY0KGRldiwgInNodW50LXJlc2lzdG9yLQ0KPiA+ID4gPiA+
IG1pY3JvLQ0KPiA+ID4gPiA+IG9obXMiLCAmdGVtcCk7DQo+ID4gPiA+IA0KPiA+ID4gPiBTaW5j
ZSB0aGUgZHJpdmVyIHdvdWxkIGRpc2NhcmQgYSB2YWx1ZSBvdXQgb2YgSU5UIGJvdW5kYXJpZXMs
IEkNCj4gPiA+ID4gZG9uJ3QNCj4gPiA+ID4gc2VlIHRoZQ0KPiA+ID4gPiBuZWVkIHRvIHJlYWQg
YSB2YWx1ZSBsYXJnZXIgdGhhbiB1MzIgdGhhdCB3b3VsZCBiZSBkaXNjYXJkZWQNCj4gPiA+ID4g
YW55d2F5Lg0KPiA+ID4gPiBUbyBteQ0KPiA+ID4gPiB1bmRlcnN0YW5kaW5nLCBkZXZpY2VfcHJv
cGVydHlfcmVhZF91MzIoKSBzaG91bGQgZmFpbCBmb3IgYW4NCj4gPiA+ID4gb3ZlcmZsb3dpbmcg
dmFsdWUNCj4gPiA+ID4gdGh1cyBJIHdvdWxkIGtlZXAgZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMy
KCkgaGVyZSwgYW5kIGF0IHRoYXQNCj4gPiA+ID4gcG9pbnQNCj4gPiA+ID4gdGhlIHRlbXANCj4g
PiA+ID4gdmFyIHdvdWxkIG5vdCBiZSBuZWNlc3NhcnkgYXMgd2VsbC4gSSB0aGluayBpdCB3b3Vs
ZCBhbHNvIGhlbHANCj4gPiA+ID4gdG8NCj4gPiA+ID4ga2VlcCB0aGUgcGF0Y2gNCj4gPiA+ID4g
ZGlmZiBjb25maW5lZCBpbiB0aGUgQUNQSSBleHRlbnNpb24gY29udGV4dC4NCj4gPiA+IA0KPiA+
ID4gSWYgdGhlIHZhbHVlIGluIC5kdHNvIGlzIGdyZWF0ZXIgdGhhbiAzMmIsIGF0IGNvbXBpbGF0
aW9uIGl0IHdpbGwNCj4gPiA+IGJlDQo+ID4gPiB0cnVuY2F0ZWQsIGFuZCB0aGUgaW5jb3JyZWN0
IHZhbHVlIHdpbGwgYmUgYWNjZXB0ZWQgYnkgdGhlDQo+ID4gPiBkcml2ZXIuIEJ5DQo+ID4gPiBh
ZGRpbmcgIi9iaXRzLyA2NCIgaW4gdGhlIGRldmljZXRyZWUgdG8gc2h1bnQgcmVzaXN0b3IgdGhl
IHZhbHVlDQo+ID4gPiB3aWxsDQo+ID4gPiBub3QgYmUgdHJ1bmNhdGVkLiBUaGlzIHdheSB2YWx1
ZXMgb24gMzJiIGFuZCA2NGIgY2FuIGJlIHJlYWQNCj4gPiA+IGNvcnJlY3RseS4NCj4gPiA+IA0K
PiA+IA0KPiA+IEkgc2VlIHlvdXIgcG9pbnQgYnV0IGlmIEkgdW5kZXJzdGFuZCB0aGlzIGNvcnJl
Y3RseSB3aXRoIHRoaXMNCj4gPiBjaGFuZ2UgdGhlDQo+ID4gc2h1bnQtcmVzaXN0b3ItbWljcm8t
b2htcyBmaWVsZCBpbiB0aGUgRFQgc2hvdWxkIGFsd2F5cyBiZQ0KPiA+IHNwZWNpZmllZA0KPiA+
IHdpdGggL2JpdHMvIDY0LCBldmVuIGZvciB2YWx1ZXMgaW4gMzJiaXQgYm91bmRhcmllcy4gSSBt
aWdodCBiZQ0KPiA+IHdyb25nDQo+ID4gYnV0IHRoaXMgbG9va3MgbGlrZSBzb21ldGhpbmcgdGhh
dCBzaG91bGQgYmUgZG9jdW1lbnRlZCBpbg0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncywgZXNwZWNpYWxseSBzaW5jZSBhbGwgdGhlIG90aGVyDQo+ID4gc2h1bnQtcmVzaXN0
b3ItbWljcm8tb2htcyBpbnN0YW5jZXMgbG9vayB0byBiZSBpbnRlcnByZXRlZCBhcyB1MzIuDQo+
ID4gQWxzbywgSSB0aGluayB0aGF0IHN1Y2ggY2hhbmdlIHdvdWxkIGZpdCBiZXR0ZXIgaW4gYSBk
aWZmZXJlbnQNCj4gPiBwYXRjaCBhcw0KPiA+IGl0IGlzIG5vdCByZWxhdGVkIHRvIHRoZSBpbnRy
b2R1Y3Rpb24gb2YgQUNQSSBzdXBwb3J0Lg0KPiANCj4gSSdsbCBhc2sgdGhlIHNpbGx5IHF1ZXN0
aW9uLiBIb3cgYmlnIGEgc2h1bnQgcmVzaXN0b3IgZG8geW91IGhhdmU/DQo+IElmIGl0J3MgbmVj
ZXNzYXJ5IHRvIGNoYW5nZSB0aGVtIG92ZXIgdGhhdCBpcyBmaW5lIGJ1dCBpZiB0aGF0IG1lYW5z
DQo+IGV4aXN0aW5nIGR0IGlzIHdyb25nLCB0aGVuIHlvdSdkIG5lZWQgdG8gbWFpbnRhaW4gY29t
cGF0aWJpbGl0eS4NCj4gU28gdGVzdCB3aXRoIGEgMzIgYml0IGR0IHZhbHVlIGFuZCA2NCBiaXQu
IFByb2JhYmx5IG5lZWQgdG8gdHJ5DQo+IDY0IGJpdCBhbmQgaWYgaXQgZmFpbHMgdHJ5IDMyIGJp
dHMuDQoNClRoZSBtYXhpbXVtIHJlc2lzdG9yIHdlIHVzZSBpcyA0Sy4gSSBhZ3JlZSBub3cgdGhh
dCBpdCBpcyB1bm5lY2Vzc2FyeQ0KdG8gY2hhbmdlIHRoZSBkZXZpY2V0cmVlIHRvIHJlYWQgNjRi
IHZhbHVlcy4gSSB3aWxsIHVuZG8gdGhvc2UgY2hhbmdlcw0KYW5kIHJlYWQgb25seSAzMmIgdmFs
dWVzLg0KDQo+IA0KPiA+IA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIGlm
IChyZXQpDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGRl
dl9lcnJfcHJvYmUoZGV2LCByZXQsDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkNhbm5vdCBy
ZWFkIHNodW50DQo+ID4gPiA+ID4gcmVzaXN0b3INCj4gPiA+ID4gPiBwcm9wZXJ0eVxuIik7DQo+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKHBhYzE5MjFfc2h1bnRfaXNf
dmFsaWQodGVtcCkpDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRUlOVkFMLCAiSW52YWxpZA0KPiA+ID4gPiA+IHNodW50
DQo+ID4gPiA+ID4gcmVzaXN0b3I6ICV1XG4iLA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBy
aXYtPnJzaHVudF91b2htKTsNCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBlcnJvciBzaG91bGQgYmUg
cmV0dXJuZWQgd2hlbiB0aGUgc2h1bnQgaXMgTk9UIHZhbGlkLg0KPiA+ID4gPiANCj4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBwcml2LT5yc2h1bnRfdW9obSA9ICh1MzIpdGVt
cDsNCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSB0ZW1wIHZhciBzaG91bGQgbm90IGJlIG5lY2Vzc2Fy
eSBpZiBzd2l0Y2hpbmcgYmFjayB0bw0KPiA+ID4gPiBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIo
KSwNCj4gPiA+ID4gb3RoZXJ3aXNlIEkgd291bGQgcmVtb3ZlIHRoZSB1bm5lY2Vzc2FyeSBleHBs
aWNpdCBjYXN0IGZvciB0aGUNCj4gPiA+ID4gYWJvdmUNCj4gPiA+ID4gcmVhc29uLg0KPiA+ID4g
PiANCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIHBhYzE5MjFfY2FsY19jdXJyZW50X3NjYWxlcyhw
cml2KTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4g
PiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsNCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gTWF0dGVvIE1h
cnRlbGxpDQoNClRoYW5rIHlvdSwNClZpY3RvciBEdWljdQ0KDQo=

