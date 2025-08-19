Return-Path: <linux-iio+bounces-22990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66925B2C7A2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED707B6861
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E65827F16A;
	Tue, 19 Aug 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="PBYG2lMY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA127EFE3;
	Tue, 19 Aug 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615245; cv=fail; b=pEvjUDeNwfuWI/TB0XVVEjA+44QxJHNjQzmkhfEkPuHalVsu/J0eViTQzdOK8Y3u89YdTlYHeA03qbbx3Tl+S5sCdOyMDNrugPmQWPnhmfHzMYIIRfFBj5UQCtKulWhoPy6n4pg8T4A6dhwDo5FIsEaGIMXZvW8/ulBzu5flkgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615245; c=relaxed/simple;
	bh=tyMT965IzJrwCmjk6jkc4elE0c+LJSTjwbg7x2XzFyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=olSD9lMl3gR2ezXGUPHiChiaKZAz2Yx5+RXV/aJvtoe0RdGZzLMhYJ9dYSLQzjR2UGOgAHoJZhW9HZBSvgZEtmqKSYojNJ13ayULweu47qyMaZmQspsdKJlk9A9WNMyJCrmV7qsh2Bf5XEFQOg3MT190KE2b36n1XplMawq1+wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=PBYG2lMY; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IMabUl015679;
	Tue, 19 Aug 2025 14:53:58 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010026.outbound.protection.outlook.com [52.101.169.26])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 48jgc0t8rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 14:53:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdsrLCL2Nd2ny8FMPC3PYDCAQ0XZ9WokfGB2dJUVSccLuuvn0yOYxZn9TkhJy2CjxQ9C+uzACExzVVcr2cjI/vNdIlsNURPyOwcNhPqWnNOvdouwCof8/07TD5Ge+o93Xilzmyt1AzrOomlWEj4YlKwQh17V2aXOj2xJ46ZMVVTQ0936gIeIwYerllW6G4wvRSbOrTyObVCBcFsiR8Rw/YhSZebcRS9Xca+VJ5sGPB43uL+GwfCU+bdYoPMNH3783aU+YDBTKfz+4JNO+lWgIVi61iViQgbyU4lK2VOsVVZq1AIFQN8K8hyNOlDkszKMfoyESUhwgjxdhhJyTOUAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyMT965IzJrwCmjk6jkc4elE0c+LJSTjwbg7x2XzFyA=;
 b=inIrytT0ap+ISy+sUejqrYEzK00vulIFKknvbDtBSqNXW/ubBI7rd4huNOVx9d1AiwdlnvaKttb24JgwArobYegvpTkCeX7TFFal2F4Y1StLY80qAgOBaAIBb4/pwaIzE+eW9LUhGnW24EtqfZIFwbLkKfDlJZFpZVJ9dHUSPqZIEUS9Rw9D9dSoTwgv2SLOne0CRnxW5VnRCHSC5gC0y+OyOHtJccDS6jEShTdkSWuIQ+vwZ/G6Sm6ppgp2q72gVVdbZMXu4zWLOhYm8yaTEaqERtLgKh7Xu1mh+J0jfkkhFs6QC+8gRLZqlV2EfWr4IhVO9v+wemLh1nhVN8d+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyMT965IzJrwCmjk6jkc4elE0c+LJSTjwbg7x2XzFyA=;
 b=PBYG2lMYLUJQ2KNNyo3TH8qvw5xY83u5HJ+Y4jM0kKcy+1y2QEXDnRMfVJwf0XIcJ6+z7KUi7wZrttXJKhLm3WEeQnuYvWEiDwUUkZP4SKEhD/sjpgBVao+In86xRDEmnvQ7UtkHP6GVn4e/lN2JHzGkxCeTQtvvJ4YxPd43wKts4gcD1zBrWw0G/4qqSXA3m2k/SXDIs3uYQUUBqLDPVEr11mt0EtUIf57VOCx4Be8uygG1UWL5ReQRl9SFMAsUW1mw8qYRI9ahxtTYu4vNPDOK5zKIAw/BWhMkgAMrB4h29s5aVVkuqvj8h4+y8JxcDMGyUBV2yek5ZvwlpPk9KA==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by BEYP281MB4543.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 14:53:51 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 14:53:51 +0000
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
Thread-Index: AQHb8XjGNSzfw0LPWUy8flLtSCneZ7QxIDwAgDjeBiCAAEn6AIAABn1A
Date: Tue, 19 Aug 2025 14:53:50 +0000
Message-ID:
 <FR2PPF4571F02BCD22C5EF19953DF32A8688C30A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-1-bf76d8142ef2@tdk.com>
 <65d7009e-dc4a-44b4-88fe-b5c7e1ecdfc1@kernel.org>
 <FR2PPF4571F02BC2C08BFD80F57AC4F45AA8C30A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <f1269f60-4347-455a-819e-6b35177cca3c@kernel.org>
In-Reply-To: <f1269f60-4347-455a-819e-6b35177cca3c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|BEYP281MB4543:EE_
x-ms-office365-filtering-correlation-id: 3324e514-544d-489d-35fc-08dddf3035cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|10070799003|366016|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?MHVZNVJCaGc5dStBemVEZExLeXNiUWNHSlY1aVk4WEdLcGQxNXFsSWtTTUZQ?=
 =?utf-8?B?OHBOakJCL2F5YlAyNjJXY01Wc3pnNWphUERBR2U0T0kweGVtSlg4WkJodnhu?=
 =?utf-8?B?b0c4VjFScjJNQmtZemtoVWFBTDhBS2ozd0xmR3plOW16WXRUdW5GV1RpQXA1?=
 =?utf-8?B?eWNkRzM0ak84L2RUYnJXNHRURm5aRFpTdVVzang2cmJEUXlEKzZ1QitSSnBL?=
 =?utf-8?B?b3cwU0pvSUtqaXQway9mRWNPRGlpOHFqSDNBSGdGR1JqSEtUOTUrRDBybmRp?=
 =?utf-8?B?TU4zWEtDUkVha0dCVFlsVnczUmxKL0V6eWhrYkdybUVnY3BiQVkxRTJYVzNP?=
 =?utf-8?B?YldLdVI2eU1INjdodm5SVUEvencyZ2NSKzdMYlFialNVQytVNDFreGNHcmts?=
 =?utf-8?B?M3dqdk1xU2t0SWpKQlB0YXJnUC9FMDAzM1dDNXNGUlMvRXcxNlVvOENLNGEz?=
 =?utf-8?B?QVNsRzB2NlNuYTRmZDFBc3R4NDFIeUVtS2FJemJKS3pCemFIeHF3dGszVFlh?=
 =?utf-8?B?K0ZoRlJEc3p5Q2ZmSkRsVkxBZmJ6Yi9kMGR1N3dNL25YdkFIWTlYamNOMVZ6?=
 =?utf-8?B?cU1YQ3Rsa0MvY0ZPNU1kbkxUZ0RvYW1VK2FLOThRRTJCSmJGTUFmM2hkUndv?=
 =?utf-8?B?Z2lSSTNHeU5hbjU0c2hoclNNRUVIcnF2eEpid0tQOXA0eVN1enM4dVFrOVFa?=
 =?utf-8?B?aVA5UFFIamtOTDY2N25EVG9uYlRWRi9rbzdHbVFEL21EQnNNcnRHTVdSSVlC?=
 =?utf-8?B?aWlsU0VlSytrb2xYZi9hWVBjeU1TRno0aTVQVERxWkVCUW51TGVZL012aG5P?=
 =?utf-8?B?WnplNjRIVFhjK1E2RzhCN25iMXl6dFFkWC8zQWZ4Z3o5K0NVcDRsTDJWdmp3?=
 =?utf-8?B?THVJTlM0TmdCc3hwU25qemFQTGdrcDR6OVFGWHBWcWlydDRNZkFGbENZdWph?=
 =?utf-8?B?b1lIRUtHdlg3WXB5czg1TXZmb3pRdzJueHpWdDdjZkpTQkw2YmNOQ2R4Sno1?=
 =?utf-8?B?UlFkM1B0QnlvVkJrdHRST2N2WnNuM2JuSzB1ZVhXMjhMS3picHZrUlFpeC9D?=
 =?utf-8?B?T0tjSEczaXhXOFZiQTAxTnhoTjNzUk5GR3NuQzk1QXFITklrMEpjM2RYVlFE?=
 =?utf-8?B?eXhPUmhLcFh6citmY29mTEhqYi83USttYUJ4OERQZSs4N1ZDZUs1VXFYMnFD?=
 =?utf-8?B?ZEIwZEh6c2NZNFlIYkIzSHBSaWc1TlgxRTJmUzZBYmxNazNYRVJVMFY3VDZ5?=
 =?utf-8?B?S0Q2dUxZNXI0d3N4MEZiS24wNkNZaEhsdW9EaGJmMCtsMGNtUFRTRXNsZzN2?=
 =?utf-8?B?c2M2MFFKTGlHaEdzeElkaXg2aDNab1hYUFV2bENuVHRrMTdPREZXQmoxZFFC?=
 =?utf-8?B?QmZ5SmxlNEJpcG5XSEtKUitLSXhUM3VleTg0YmFXQm1pWE90VzRrQUpCWkht?=
 =?utf-8?B?N25qSjV2bFpXUW14VDRVSkVrMlNZZkdGeTRMbTNTNjJVZDRRbThzazRoeWFE?=
 =?utf-8?B?T3NSa3VVT0I2TEJlTWl2YldsR3ByM1hyMTlRek9GSUJmVmxINGhYWVpXdUM3?=
 =?utf-8?B?cVk0VkhqdlFsdDVNWjBWK05ZdWhGTzN2alFWaGpKZURVR3RQS1pWVnpnYjVi?=
 =?utf-8?B?T3pJcUdDN0hwRHlxOHlRVExWZHF1U2Jpc2xOaS9VV0dKRzhNNE1WaEprOGV6?=
 =?utf-8?B?Y09PYWh0ZFFBSkVPa21UQm1kN0dVbXVQTEk2OTlVWUh0aWpnKzZkZTVJZ3VS?=
 =?utf-8?B?Ym1qZmpmYjhMbTEwb1lZejdFTFpScjNZMGZrci80TEZNU0pLQjl1Wmgrc0tY?=
 =?utf-8?B?eElaUjFmQ2IrNzdlb3E3RHBXOE43TkxsSXBtUEg2SHhWTnFuV3hjNk9Fcy9p?=
 =?utf-8?B?SlA2ZlZDNitXSllKcHRSTXJqUEZRcVkzcllQWVEzbW1ZbmtkQUgzdC9ZOEds?=
 =?utf-8?B?Y0M4TklDS3hROWpQdXNGTlowWWxzVkc0ZEdETk5yN2poamxzRlczNjh2K0Nq?=
 =?utf-8?B?Zm1tQTk5TjJ0UzJQeE4wTFhsZ2dXNkxkaGdKUjhVTTNkQWFSVDlhMVJ5UFpH?=
 =?utf-8?Q?otAD2O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(10070799003)(366016)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWQ0dGIvU3llNTgzRGlveUpJT3hUMGZWU3BvQk9jaDB2OTd4TldudXRCREo5?=
 =?utf-8?B?MEtkQTRlaldqbjdoOUNHSzhaZVFxYVhNOERSRE1oOTJwVUkyTUJ3cXdqWDlD?=
 =?utf-8?B?cnJLM0oxSC80Um9UbDB5bURIUHJlaDk5QkdxVmd2NHh6ZXBLTzgrcGpBRUFK?=
 =?utf-8?B?bVV2M0NLNmlmVDJLc3R4citBaG9vSng2YXprTVpvbGpaV3dVNGFKR1IzbXdv?=
 =?utf-8?B?RU1zMW5kRnFZTXgzMlJ5VUZ6VENYNjBsRDgwc3FkVHZHbjhVQ3pvZXQ2QTIv?=
 =?utf-8?B?ODlaVjQwWHZ6MEhRMmtEZ0kwTDFMazJKNUNlcCtZSFFWT3UxRlFJaS8vUUFV?=
 =?utf-8?B?T1dlWDZ3eVpCODVZRElUQnkxd3d0MU5oZlR3WlhGUXJhZzkyTTRvWnIxZ2tD?=
 =?utf-8?B?K1FWTDRsazNUc1VlMmlzaUNuYUpTdkpYMFlaYWVwTjJPNnFjdEhEOVhpSTdw?=
 =?utf-8?B?V1huVWtKaDFGVm9oT0pid0hSRng0QUhYQTdUNFk5WTF3TzloQVk1SDhsKzVm?=
 =?utf-8?B?NGJIWXZCbTFCa3RQUkdWd0ZBV0ZKLzlqTW1oK0RvbkcyckRnTzNBNk9BNi9h?=
 =?utf-8?B?dnRtR3FlRDhFeDh0Q3l2cjl3R05JVkNpV0tkdGVzWU5PRmpMZGQwM0IzSURt?=
 =?utf-8?B?ZHMrWG45NEdINFFTNUVlczQvZ0JqQWZhVkVId1Q3UGNtTEZCSHplSVpOTUZV?=
 =?utf-8?B?Z3lMZ2t5KzVwT3RkUWp6aW9mbWhocmR1RDYrZmdOWSthVTZLcE5BWi9ielY5?=
 =?utf-8?B?NDJGS0FPTFdya3JvTFZRVFBWWEJrZjFHU1plcDhhQkppNExuYytFZWdHN2tM?=
 =?utf-8?B?Z1BNcitRQXBIUmorS1BHbXhoU3V4K2s0Z3IzTG5qdld2ZTJYektXSVh5WHJ3?=
 =?utf-8?B?Z1A0eExnRVBzcmZ3TTc4L1FwYnNKN29uN3o3dXRlUUhKV2NaOFVrc2N4aWp1?=
 =?utf-8?B?aXNXemx1NGc1YUZqUk1LaHBVd1N1Uzd0RGVrUkN3MUFtTDBBWVpyYnZHYzND?=
 =?utf-8?B?TWdPQm1veU9VaTk5Z0lhRi82WDFzM1kwb0xPVmpqeXBoaHo4YUIzSjAvMkR3?=
 =?utf-8?B?THZkaWtGbmZ6THJKb2pCMjlyYXFzUFVKUm1la201WExHcndoQ1EwdE9aVk9P?=
 =?utf-8?B?Rm1FNklDdzgrQWEwbUZVT0NDaU15QnBzNzlZNlo5SzRDeUU0Q3pUdDJJOVdI?=
 =?utf-8?B?ZmtxOW9hbnB5UjdIdGZ4bHpTUjFxRCtGK0M4TEFpYnN2ZDU2RGFTakMxVmxl?=
 =?utf-8?B?TnJxdUlFbURCNmJ5MUNmRUx3ZUxRL1NxK3hJR2h5MDJoVDVmNEFNT3pkSzZx?=
 =?utf-8?B?bnRMSEdaUWVGSGlFZ2tzb2lHMHhJUGNldmR5b0VQbFhxbFNMMnRzQmNoRzI4?=
 =?utf-8?B?V1liSWVOcGRBekRPS3hHdE12dWxHUTlCTHFVU1VnVlFCaHRCd0YzU3FSOTdl?=
 =?utf-8?B?bHFkQy9XTWQ2d2NNWUhVaFhXRnV4bWVVS2ZoS0RUZG4vYnN5SW1kZ1FIWEVY?=
 =?utf-8?B?THNtWlU1WCtqcVB3RGlNNGtYUWtRZTFQQ2RyWlFGZk1CNnRyZnZYZDFKSWNR?=
 =?utf-8?B?MC9zOHdGSHdpNlpRRWFzMXRUeWVyVGxXY25IbXZqOFNEVlFYanZyaWoraGFM?=
 =?utf-8?B?Z0FudWorSnU3N2ZoaTgxQ3MyZmFFVVFiRnlqbzFqZzQrQjdTbTJWVXMrbTdn?=
 =?utf-8?B?WG4vKytLTDhobHZTb1BYaGswcURTNHlZRWQ5TXRzbllFQ2ZGRUordnV2d2tE?=
 =?utf-8?B?NXNrL29GT0VhcThvc0toNmYzb2duejgybjkwbEhIeENlZ3RWVUNkUWkwbURS?=
 =?utf-8?B?YTlBdmhIcFc5VDJ1VVVkNm5UUkkvR1orbmNqOHhqVExSMlEzZW00NzFpRkpl?=
 =?utf-8?B?RVN1UUFRNnFzeHpLTGZNeXY3aXc0d2daK1JYRHpKZ283SmRobWltK1lSNjJa?=
 =?utf-8?B?UVdSNEJkSXFkK2toNE5UZjRiekw3QkN6OGZuQWxSbklydGN6dTBtQWE2OVhz?=
 =?utf-8?B?cEFJYzhPMDhHbVh2NHpMMnByb3FrZFVYdE5oQ05qUTZuRVRmMDBjdVYyMDk5?=
 =?utf-8?B?bUpDTkZhZDJvVzlSZDNBdG5IcTZEWk1iR1lPSGRPem1qYzkxeFBMUnpyeENP?=
 =?utf-8?B?dFlQcEYveHowbTBmYy9CeStBdG5GRDF0Rmc1djMxTmw4Mm14RmQ1eEg0ZTZP?=
 =?utf-8?Q?EV21tD+VKLAP8Uvly/X5eyJDRErhcJaEpP6i2v9kgEQZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3324e514-544d-489d-35fc-08dddf3035cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 14:53:51.0069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7pl5V3mpujyAdCCGpvcRj7yh1A1c18KIAtHXUksh/985EJ4KazF5TmBTF6K5Cw0Fz/0cAx6/f1EhIXff+urfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB4543
X-Proofpoint-GUID: jHSQBfscZ5WkC4FJbRfwranKwd8Q49Fu
X-Proofpoint-ORIG-GUID: jHSQBfscZ5WkC4FJbRfwranKwd8Q49Fu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAxMyBTYWx0ZWRfXyfBDnofJq+SJ
 /VwrbUd8vcAbfBWfaqyv3MT9ZaS7IoBK/OVncLwQQGPaDwaTM3cCXISiCKgPtZOQyyJDyYOuhYj
 PtbXoNGog2W4D0mzjjKOvn89oePzI5vcXXq26DCrfbkbOn5w8WlqfAJ5jtXF46X1YyS//oSUVvQ
 LNlsQbz5+y01ryZZzzSo30khGgNxpngrPmunfnHL8nTnHWKx+Sso83ptaKADZ12V/tqQE4WUMjh
 PsCahvF0QyU6QOZ9+F1OE3alBKvcsjuAP7s6JqSL+MBmwhNlF4RN5TNAoSq6fLbf2qcthPuR/D5
 RHJWek3GpsjENvITPNMSAvLpn469m/0hJBhps+2RZPJG+aNEKp05XOVN9ecJUBNetmV5ITlUjOF
 UHXkwhZo
X-Authority-Analysis: v=2.4 cv=T/SMT+KQ c=1 sm=1 tr=0 ts=68a49006 cx=c_pps
 a=bNQ2TEIYoMXxDb6/tsdypw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=Jsx2dPa9ajw8zc_NyisA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160013

Pg0KPg0KPkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4gDQo+U2Vu
dDogVHVlc2RheSwgQXVndXN0IDE5LCAyMDI1IDQ6MjkgUE0NCj5UbzogUmVtaSBCdWlzc29uIDxS
ZW1pLkJ1aXNzb25AdGRrLmNvbT47IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+
OyBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBOdW5vIFPDoSA8bnVuby5z
YUBhbmFsb2cuY29tPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBSb2IgSGVy
cmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJu
ZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPg0KPkNjOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS84XSBkdC1iaW5k
aW5nczogaWlvOiBpbXU6IEFkZCBpbnZfaWNtNDU2MDANCj5PbiAxOS8wOC8yMDI1IDEyOjE4LCBS
ZW1pIEJ1aXNzb24gd3JvdGU6DQo+Pj4+ICsgIGludGVycnVwdC1uYW1lczoNCj4+Pj4gKyAgICBt
aW5JdGVtczogMQ0KPj4+PiArICAgIG1heEl0ZW1zOiAyDQo+Pj4+ICsgICAgaXRlbXM6DQo+Pj4+
ICsgICAgICBlbnVtOg0KPj4+PiArICAgICAgICAtIElOVDENCj4+Pj4gKyAgICAgICAgLSBJTlQy
DQo+Pj4NCj4+IEhlbGxvIEtyenlzenRvZiwNCj4+IENvdWxkIHlvdSBwbGVhc2UgaGVscCBtZSB1
bmRlcnN0YW5kIHRoZSBwcm9wb3NlZCBzaW1wbGlmaWNhdGlvbj8NCj4+PiBUaGlzIGNhbiBiZSBz
aW1wbGVyDQo+Pj4NCj4+PiBtaW5JdGVtczogMQ0KPj4+IGl0ZW1zOg0KPj4+ICAtIGVudW06IFsg
aW50MSwgaW50MiBdDQo+PiBUaGlzIHNob3VsZCBiZSB0aGUgb25lLWxpbmVkICJvcmlnaW5hbCIg
bGlzdC4NCj4+PiAgLSBjb25zdDogaW50IDINCj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHRo
aXMgImludCAyIiBkb2VzLg0KPg0KPnNwYWNlIHdhcyBhIHR5cG8sIG9idmlvdXNseQ0KPg0KPj4g
V2h5IGRvIHdlIG5lZWQgYSBjb25zdCBoZXJlID8NCj4NCj5CZWNhdXNlIHlvdSBjYW5ub3QgaGF2
ZSBoZXJlIGludDEuIE9yZGVyIG9mIGl0ZW1zIGlzIGZpeGVkLg0KDQpUaGFua3MgZm9yIHlvdXIg
cHJvbXB0IHJlcGx5Lg0KSSdsbCBmaXggaXQgaW4gbmV4dCBwYXRjaCB2ZXJzaW9uLg0KDQpSZW1p
DQo+DQo+DQo+DQo+QmVzdCByZWdhcmRzLA0KPktyenlzenRvZg0KPg0K

