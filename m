Return-Path: <linux-iio+bounces-21564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC16B01AB5
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080E01C80A52
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5328C2D2;
	Fri, 11 Jul 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="k+99yqUd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A93C26;
	Fri, 11 Jul 2025 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233990; cv=fail; b=TMzuTPZjPTqhaBFJ0He8BfygGPcyeLGwTY5o41Fgcx6FIg76ug5ntjnces//qNhsSfNpLA15JcEqZb3gTxf53/WaY/h5gfTDvn3nT4S/hamCn1x0+tapc2shaMf+Sq3YPPseGGp1JC/32dmaUxTGw6UtefA0q2amW5SAy0SzZ2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233990; c=relaxed/simple;
	bh=6lMQ+cHAUFghdhJb+ZSsrCvEFiQ07jBrFBPitJYJPSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sIssNKsL9STlQ6eAyt818aJzCuORl5r7ayTGU33WDyHP0BAmrxmrcDFI++IUdN69Biiz3r0yi0vZi2IPgkg/AVzn2c+pJnPNLl5e86i/VN3pluEocnBk7vQ/rhJJgFq98h+qZQ5QNU4mjwO5Y0lFKyCdZXgdPWxLJkIIS6L9FOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=k+99yqUd; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ANNOUH031256;
	Fri, 11 Jul 2025 11:39:38 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010001.outbound.protection.outlook.com [52.101.171.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47pwe3vxbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 11:39:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu1hN3D5IpHLO5HFMISv9SWqKvigaDCjKDSYJTSlAymAtvI3ctGLy5qimCwF4IvKR8PUrYfV9LxO6WTGk/LUrjp5OsJxY2VYZOM5tPYwiEuYsplpUo6OL+7qIpLpnwcwh8lkfmGTBzUtEVn1sjdsExiMHg15yjuCdgNmT945RtePz3QxibGv8JAPWFEwlhCdT9qQbTNapRkyx1Liut+azHg89LZQHKb2ZaMLJVZPdnwLmd2MKxf0aKY3Xz5zRn5PNjicOlAKtcWDPYajISKhLOvogp92rBQ4xg5s8BbNumW27bKtg3jxcKR4VnXFGKCVqMAvCS/vAPHKTpJ6Lnqy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lMQ+cHAUFghdhJb+ZSsrCvEFiQ07jBrFBPitJYJPSg=;
 b=noBTvWiNW4WLeK0j6tVtSMy3vnce+k/+F5bCbjS12LcjAbauHXgikLygxXMz6ySvc3GwN5XOSfV7mUjsaqGA96OktXcAjtx49SB2O0CykEqy3pqBezCUlAEuyXbsFR1uvE1mVGSX0NFnE9dcQSCK3XrMhAwGeeJwpr7wDN34rz9PP3XC31mY8th0uD0PoBq979UIfUbYd0ELaRyC4j74C95yfp40rKnlPcX+5Wk5ShbVUrDK8h88DSMsx8+GONYDFqzhup+l+KhjgNxmcuNRT/tequfRoZtKeEXfe1QgfZXJtH2trexRsLJgrVhRqJKxJ40+U2TSIax09QfMRm4AyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lMQ+cHAUFghdhJb+ZSsrCvEFiQ07jBrFBPitJYJPSg=;
 b=k+99yqUdrCUHfauSUTmP184RnPryaXnQwaHFovH18XLypL0MG05htXjduIybZq7k0DLUmue6mlJRybPYf9JFlOORGqbvY2A5LoRqR3eolEcBl8kPxNQUaJp2ZiHxPkQOET5hgxMsHPgaNU05eGKGI4BhC3Ouw+UocmxSfXvR0OW/tKUIE2OXDKDX2h3KCUF0DfgH0JME86REtVz+BX8rNjeI1+3IjXsx38LwOM/4Q7FiQL6Q+xtwfVVC5xvfXLaddHaW+yKe0a1nx6B9ToYOOaRZypbkw9fhT5+rVJ9BPA1NAXv+/ZVQA60f7ZopZRn6R/4OLuKcPNWtPD/6U37mJw==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR5P281MB4140.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:106::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 11:39:31 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::903d:f362:450:c7bf%3]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 11:39:31 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Thread-Topic: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Thread-Index: AQHb8XjFFPwNlXicDEKbiHsXjh6cu7QrF22AgAG2dfA=
Date: Fri, 11 Jul 2025 11:39:31 +0000
Message-ID:
 <FR2PPF4571F02BC601FD554873EE9C90C848C4BA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
 <aG-ID7O3HgVc1EOX@smile.fi.intel.com>
In-Reply-To: <aG-ID7O3HgVc1EOX@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR5P281MB4140:EE_
x-ms-office365-filtering-correlation-id: 4ff5559b-7bf4-4c36-f893-08ddc06f9a40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|7053199007|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3lKY1pQYjlENEkxeWYrQ3RPQXhYdmRVck1YdVFsTVpBak9tYlI4ZEsxd3Rs?=
 =?utf-8?B?b0NvUjJwQ2s5ZHh4WThiSzBaT1B5aHVQa3hHdUY5OE0vSFV6eGZLQTVKdDd6?=
 =?utf-8?B?NGRrNmQrSVFVMkIyY0JsUWpmcjE0MVNuelFhalBENUVJeE56Ukd3TEpDOFpX?=
 =?utf-8?B?ZWdtY2ZwSDZBbkwwQ3VPb2w0REFMQTROR0g1OTBHQWxXb0pJTFFXdG1WRnJu?=
 =?utf-8?B?QXAzREhoU1JUVlRCZjFoM1ZPeVAzV2o0ampCeHhjZmUzdFVQejh4RDZQM05N?=
 =?utf-8?B?ZGhaMzdDemIyNWJEemdVRGlBcjJqNytNWVRZeFQxSUZySjVYUS9LdURpcCtu?=
 =?utf-8?B?ZHFaMkVwTGpqWll5eEN4VkNhNW5vZTRpYkFjS3VHV0U0TkN0MVUxZllmUllQ?=
 =?utf-8?B?Ui83QjI4NHk4QnJuajQzdjFaOVAzaTIrV2RnclBYZHRZa2JmTFBlcE82VUIr?=
 =?utf-8?B?cXNkUE82NTdmVE1mOWJqOXRQaHRRVzNVb2hENjlDRUtVY0Zzd1RIZVM4cmZD?=
 =?utf-8?B?VXZSNWpab1p0MDZsNFFEb05ydHRhYlQrTkRmQ2hjbXlYdHBFTkd0VmtPRmtu?=
 =?utf-8?B?cEpiekRDK0tibGs1VnJ1SXZiSFF2SU8zRFYrSFVHUFdUZEd0UisxRjlHVy8y?=
 =?utf-8?B?b2lnRkEvMEN3NmhsVjF2MXFsQUJLbDhwSllNS28xMVFmb2NybW8rREdMaHcz?=
 =?utf-8?B?SXdLdFhXYUNRRkdSWXhoRFB1L005V1dsSHh1ZlFtRXZzR1ovZFdsa29XUDBp?=
 =?utf-8?B?NWptWDFpUFpwRGUwNXlYVjQ4N2V5TkpBZXliZzFpVVM1WWJ2UkY4TEJZYlFX?=
 =?utf-8?B?ZDM4akNRZmw2cmhHZ0VPUjNqV1Q1MmkxdzRsYlpOKzIrcmFBdExMWDl0Q3Nl?=
 =?utf-8?B?UXRmUW5lTlVTbCtMUUovbXhXbmEwNGVtWUJkZkIvdXE5RzdzT21sckFCMmhE?=
 =?utf-8?B?elRxM2lUTnU5dXNBZUtWbVdlNEVDeVV3NlE3QUFKT1NjT2JGSUpJTlYweEFx?=
 =?utf-8?B?dUw5V0pZUVlRNXhyS1pQalhaR3BFSTcxYlZLZUtoUThsWG80VG1rYmE1YXds?=
 =?utf-8?B?UjVBc3haZXozNW4vMWJnNEZuYXgzVEQ5aWlQaWJmOU5oMWcyVUdFK3RDN2Jo?=
 =?utf-8?B?aDlFVWRRYzN6UnVjeURiWjYvdjF0Z3hvT1FHUndXMk1SclZjYldaZnN3Q0gz?=
 =?utf-8?B?b2FyRTF1UVZJUG82ZnNvVG5WYVJMVVdVbGwrR1V2RXNhT1JHUmlMME12R1Ur?=
 =?utf-8?B?SFNDUGhCL3VDL2pyQXJReUZvNzE0NjJ1ZWhBTGk2S1QrYTVPRUwyUXZvMUZs?=
 =?utf-8?B?QndVYVhlc3VZZzh2T1NUU0RDWWFXcThCQnlycUhKdTUzUjdwL2FFNThCaGVl?=
 =?utf-8?B?em1DckFMZGlDZTZ1Rk1hRy85OHdDNkh4WElCRDVCeTRtTHpHS1dvTkhFRng1?=
 =?utf-8?B?U3YwdGZPY2RlVlhvK3BVRnF3YzZIaFZNNDdMWjFlM29pSU1uU1luRm9CWUdQ?=
 =?utf-8?B?dlhWMnE2L1VJM1plUkxzSkd0VCs4L0hzSmV3V2c0WDl0SDQ3S2xmRE9oM0FP?=
 =?utf-8?B?U3BvK1VZaklqU3d3ejJVVWxyb01sMlZWZ0daVlA4R2NpMm9QMGFWTEt5bkZr?=
 =?utf-8?B?MllKNmhjWmViVVd0UUhPVGdBVVdTTnpsZFYxWGhUQm1LV2VHQm1KZzBsTExB?=
 =?utf-8?B?SENuS3E5Nlp6c0xjbFZJTlplOXNuakVGUHlaVmtiQ1dWbjBOTDAvY1FnSC9E?=
 =?utf-8?B?UUtDUlY2Z1RKVk1VLzU1dkw4dDYzbC9PQnNWWTVYa3RpKzMzVWZ1eENPVkpp?=
 =?utf-8?B?dGRyMTZnQ3ptdWdtUkY5eFhaMEp2ZHJLQmRIV0pjYjBlRThrbERxbFFTa2xj?=
 =?utf-8?B?eEdJVG1MS1FycFNuaVVyOVVaVnVWbHY4LytWQ1dEeVVKZngrTGNLN2E2clRv?=
 =?utf-8?B?ZU9pTjVtbXVTOW1RT2tOWFdHM0diSXlJTEMzMFdGamVOQnB4WDFtdkpMclF6?=
 =?utf-8?B?cm9kcDk3cWg3SXVjcXdXUnNlNWFKNzdMMHVOcWFLWG51bGdxSVdyMEFUV3RQ?=
 =?utf-8?Q?X0973e?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(7053199007)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHNIdHFWcEs4TnNqcEJDczZqZGpMRDh1TVRFL0E1Z2JXN3JhRiswMnBXL0lC?=
 =?utf-8?B?RG9oMVd6UkN4WVNVUFU1WFFhcGkrMURBdUp1dDd3L2VEU2dvY3UzUWlGQWkw?=
 =?utf-8?B?UDJqY085N0NoN2t2bDEzUjlyZnFXclFxQ1I0OUFadVROTzZRdWFMQjMybHlo?=
 =?utf-8?B?NjZnZGVDRlZSKytUbkhOY01WdjVtSGpWcjlpZ3pIMkJWQW9kMk9lOVR0SG5h?=
 =?utf-8?B?S0lNVW9tNDdFeDlKUEFGRXc3Y09nbDF5SitkSlVVQ2NpUHNFR1BmSWI1b1JL?=
 =?utf-8?B?TU9Edlh3a2M4Vm9mM0dJS0hrNDllRTU2WGlLZVVtOXJWM3Zmckd0WnlUTVdB?=
 =?utf-8?B?V1JnbEVwOEtPNUFSOG1sUTRhbGZrQ1U3ay9hWGRDc3gvanNYYTBjQnFkSU1G?=
 =?utf-8?B?Z2JlbWx0TFd4elZ2dFAzQlcvcGJoVkcrN3RsV2VpcE8vNkxSajBRWHFlQWxM?=
 =?utf-8?B?QWZUemxVRmduTVlBQkJERHIvMENaQmpEeENnT0hJaVRNZzV3dnNVekJoaG1n?=
 =?utf-8?B?R2h4TnZMNFZLNUh0NnhzOVlWaTRpSkduWmJvSmwyUlV0OGJ5czY1UmszS2JB?=
 =?utf-8?B?Qk1uN2lqa0RvbWlRMk5pUmJieDlEQTJUU0hXU3RQS0xUK2ZSK1lsdFlZV0hm?=
 =?utf-8?B?Snl5SDJqazY4NmtnTlNHTHhFMkFUbkxXSjlWbXM1WlphZDUrWVVuK04zMmFI?=
 =?utf-8?B?eUZvSFhFSnJTekNIaUR1WEFiYWxFUWZtQWJHVEYyRlpQckt6U3dqYVVUc3Jh?=
 =?utf-8?B?U3BrYVBkZnNOWkJqb0lLZGV0dkNVdDc1djJuYjdrS29nL3NIdElGRUdtUkl2?=
 =?utf-8?B?NDl2VzU2WHV6b1ZXdUltQkphMzlhRjJkbVlUK2lZTXZlaThtajRaTlRsSnpn?=
 =?utf-8?B?cmZNanhVdVFBVkUvbWdFWG9HTFBncDVkMHdVVFBuc0dmZ2NSaHVBT1ZCaUZr?=
 =?utf-8?B?Zk9lQjhZdndDVlA0VlhoWmZoSC9SQXhJaXMrSTJramF6My80WWNTK1VVWllr?=
 =?utf-8?B?MXZWVkdINjkxenJJK2ZWWjdpcllVMG1tZE4yYmFoNlVzbjlZZzhGcGVtMURn?=
 =?utf-8?B?N2pnN096c3JCaEc2Ym1hUXBZSFRiRDBZVnR0MVE3eWVEUm4wMXh5Y1VGc1Z3?=
 =?utf-8?B?NFc5cUovRjQxYXY5RFgvNXlYdi8xeS9NSENjbTVDaHY1YUpReE5kQlZhZmNH?=
 =?utf-8?B?a3FhenlsMTNGbGFkYWk1aDVUbWVHYUZLTWdsQ1I0eFBpRWw0V1BXSDdudFRN?=
 =?utf-8?B?aGtaTHVOaVpYWno4SkpCNEloa1A4Rzh2cWxSVkxOaDM0eFQvQ3poMUNDLzZQ?=
 =?utf-8?B?ZnpYRjZPbGtLdmV3eXcrMGc4R2g2alR3SDlTVDduOSs1YUtnRm9QT3NmcFRW?=
 =?utf-8?B?R3pINThKZW16VDRmNDBNQ0ZDUVNxUVkxUWluUjN6VnNlR2V2OUZqQjh6K2tG?=
 =?utf-8?B?TG12OXdId1FqVnBMMmZwTkF0WURFa09OZFp5TkRqdlc2K3lyQ3NpU3VBTzJR?=
 =?utf-8?B?ZTJQaDVxemdpYmRrYTY1OEhhQVY5aWl4dWVnVkMzSWpVWHdEVmlIdVUxMnJH?=
 =?utf-8?B?UFBGSVBmWE9CU1hpMEo4aVpQeDJUZjJuZHdNb0t3NytaaEVoU2lFS2RwQWhO?=
 =?utf-8?B?ZTZwZ2hTR242cnpGZlVQWXhjTVpKREV6SHVEaEVKdnpSMk80VUpKUmoyZ3Mx?=
 =?utf-8?B?RVphOXAvcE9BdklPOFRZU1pxQlhSeEJENTNrbFhUdHJMMU8yMGRveHJVczhi?=
 =?utf-8?B?Q2lZOCtPU2pJaE9kdmh4Nm5qa0ZURUJ2cEc0U3JzemVnaGVwakJOSEwxWTg2?=
 =?utf-8?B?VUVQZEo1bkZFUUhscE9EOUZQQ2txZWVjK3NzZkF3RlZocUUweEw2S3liQnlD?=
 =?utf-8?B?VVlCNDJ4enVMdFlFZnFkZ2NzbDdEcFZPa09JdmZvMXl0Y1dja1RkYXU2TjNV?=
 =?utf-8?B?NGtOdzMrNnJvMUNxblJpUkpCZ3JpeFgzU3g2OUl2Vmo1ZEdwS3ZmdXdCWVJ4?=
 =?utf-8?B?TXVyT1cySXBlUW5xclpMQjRMb0JibThBU2lNenJ4NURURGpoZ24wdEcxeGgx?=
 =?utf-8?B?c0RUaHBITy9oNldCSFF4VjZHS005M245M0trVGdjeDdUdCtVcFYzWTFoalgz?=
 =?utf-8?Q?QjPazyBGS29v2XUVQIjBALvzU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff5559b-7bf4-4c36-f893-08ddc06f9a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 11:39:31.7815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbOpoA/37dHz54AJbtwFXK9UiAyTzLMqx/QX1G5j22OlUr541AB0dLVgEkYCSowhxtwAQoYYrGqnNaJvzz5R9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4140
X-Authority-Analysis: v=2.4 cv=W6w4VQWk c=1 sm=1 tr=0 ts=6870f7fa cx=c_pps
 a=G9K15T5z16SjyuUhTghJyw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=QyXUC8HyAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=O5uQ62c_SmOG9cPH9acA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfX4scmcQUf66xV
 Kj+ZZm20DUdmFMtJAAjt0ux/ANXiD+wC+Lr7NfqDdtk6VJKkEPCxKyxpmlryqjXN/zzEOe/HQtt
 l+XKxK+REnfV3bPUJ+QnqP4v5ZBT3FrXtOFzvsLzn4Ocijmt+p7uWYbxZgvgcuc32GXGODEDJtP
 pRzQNKu5ybZRC00pI9I+lTchu2GgG3ghdodV87v1bG4q8iB393m9oPqvjfBR7K62UwYUCm5Aq0H
 MEIttiUWaRBszMy77QViK2QdIgiYkVPKxtNPXRyin4NyyGQJaUhppQYtTnH/gfwwSM1ghzTCBAm
 6t8ur/mS8nd7cy8j3epaJpIdgbKQE4/6rWU7r+ci1NnO1SEwIKT50ul9Y7uwMu1nqDF5kp9k1Zm
 8n5R0Maq2u22fxWibvJ/L5zBMOM4y3Yc020BjyBcLGngihBgQbU7wOKiSuux57SKbDA/iOCI
X-Proofpoint-ORIG-GUID: 0sJv-heyepuXtgbKghvQMmC54hWFjBO5
X-Proofpoint-GUID: 0sJv-heyepuXtgbKghvQMmC54hWFjBO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110082

Pg0KPg0KPkZyb206IEFuZHkgU2hldmNoZW5rbyBhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20g
DQo+U2VudDogVGh1cnNkYXksIEp1bHkgMTAsIDIwMjUgMTE6MzAgQU0NCj5UbzogUmVtaSBCdWlz
c29uIFJlbWkuQnVpc3NvbkB0ZGsuY29tDQo+Q2M6IEpvbmF0aGFuIENhbWVyb24gamljMjNAa2Vy
bmVsLm9yZzsgRGF2aWQgTGVjaG5lciBkbGVjaG5lckBiYXlsaWJyZS5jb207IE51bm8gU8OhIG51
bm8uc2FAYW5hbG9nLmNvbTsgQW5keSBTaGV2Y2hlbmtvIGFuZHlAa2VybmVsLm9yZzsgUm9iIEhl
cnJpbmcgcm9iaEBrZXJuZWwub3JnOyBLcnp5c3p0b2YgS296bG93c2tpIGtyemsrZHRAa2VybmVs
Lm9yZzsgQ29ub3IgRG9vbGV5IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzhdIGlpbzogaW11OiBpbnZfaWNt
NDU2MDA6IGFkZCBuZXcgaW52X2ljbTQ1NjAwIGRyaXZlcg0KPg0KPk9uIFRodSwgSnVsIDEwLCAy
MDI1IGF0IDA4OjU3OjU3QU0gKzAwMDAsIFJlbWkgQnVpc3NvbiB2aWEgQjQgUmVsYXkgd3JvdGU6
DQo+PiBGcm9tOiBSZW1pIEJ1aXNzb24gcmVtaS5idWlzc29uQHRkay5jb20NCj4+IA0KPj4gQ29y
ZSBjb21wb25lbnQgb2YgYSBuZXcgZHJpdmVyIGZvciBJbnZlblNlbnNlIElDTS00NTYwMCBkZXZp
Y2VzLg0KPj4gSXQgaW5jbHVkZXMgcmVnaXN0ZXJzIGRlZmluaXRpb24sIG1haW4gcHJvYmUvc2V0
dXAsIGFuZCBkZXZpY2UNCj4+IHV0aWxpdHkgZnVuY3Rpb25zLg0KPj4gDQo+PiBJQ00tNDU2eHgg
ZGV2aWNlcyBhcmUgbGF0ZXN0IGdlbmVyYXRpb24gb2YgNi1heGlzIElNVSwNCj4+IGd5cm9zY29w
ZSthY2NlbGVyb21ldGVyIGFuZCB0ZW1wZXJhdHVyZSBzZW5zb3IuIFRoaXMgZGV2aWNlDQo+PiBp
bmNsdWRlcyBhIDhLIEZJRk8sIHN1cHBvcnRzIEkyQy9JM0MvU1BJLCBhbmQgcHJvdmlkZXMNCj4+
IGludGVsbGlnZW50IG1vdGlvbiBmZWF0dXJlcyBsaWtlIHBlZG9tZXRlciwgdGlsdCBkZXRlY3Rp
b24sDQo+PiBhbmQgdGFwIGRldGVjdGlvbi4NCj4NCj4uLi4NCj4NCj4+ICsgICAgICAgSU5WX0lD
TTQ1NjAwX1NFTlNPUl9NT0RFX05CDQo+DQo+V2hhdCBkb2VzIHRoZSBfTkIgc3RhbmQgZm9yPyBO
dW1iZXIgb2YgQnVsbGV0cz8NCg0KSGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyAh
DQoNCkkgd2lsbCByZW5hbWUgaXQgdG8gc29tZXRoaW5nIG1vcmUgZXhwbGljaXQgbGlrZSBJTlZf
SUNNNDU2MDBfU0VOU09SX01PREVfTlVNQkVSDQoNCj4NCj4uLi4NCj4NCj4+ICtzdHJ1Y3QgaW52
X2ljbTQ1NjAwX3NlbnNvcl9jb25mIHsNCj4+ICsgICAgICAgaW50IG1vZGU7DQo+PiArICAgICAg
IGludCBmczsNCj4+ICsgICAgICAgaW50IG9kcjsNCj4+ICsgICAgICAgaW50IGZpbHRlcjsNCj4N
Cj5Bbnkgb2YgdGhlbSBjYW4gaG9sZCBuZWdhdGl2ZSB2YWx1ZT8NCg0KWWVzLCB3aGVuIHNldHRp
bmcgdGhlIGNvbmZpZ3VyYXRpb24sIGEgbmVnYXRpdmUgdmFsdWUgbWVhbnMgImtlZXAgcHJldmlv
dXMgY29uZmlndXJlZCB2YWx1ZSIuDQpMaWtlIGluIHRoZSBJTlZfSUNNNDU2MDBfU0VOU09SX0NP
TkZfSU5JVCBtYWNybyBiZWxvdy4NCg0KPg0KPj4gK307DQo+DQo+Li4uDQo+DQo+PiArI2RlZmlu
ZSBJTlZfSUNNNDU2MDBfU0VOU09SX0NPTkZfSU5JVCAgICAgICAgICAgICAgICAgICAgICAgIHst
MSwgLTEsIC0xLCAtMX0NCj4NCj5VbnVzZWQuDQpUaGlzIGlzIHVzZWQgaW4gbGF0ZXIgcGF0Y2gg
b2YgdGhlIHNlcmllLg0KSSB3aWxsIG1vdmUgdGhpcyBkZWZpbml0aW9uIHRvIHRoZSBwYXRjaCB1
c2luZyBpdC4NCg0KPg0KPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KPj4gKyNp
bmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4+
ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4N
Cj4+ICsjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2ly
cS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgv
bXV0ZXguaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPj4gKyNpbmNsdWRl
IDxsaW51eC9wcm9wZXJ0eS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4+ICsj
aW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4
L3R5cGVzLmg+DQo+DQo+Li4uDQo+DQo+PiArc3RhdGljIGludCBpbnZfaWNtNDU2MDBfaXJlZ19y
ZWFkKHN0cnVjdCByZWdtYXAgKm1hcCwgdW5zaWduZWQgaW50IHJlZywNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTggKmRhdGEsIHNp
emVfdCBjb3VudCkNCj4+ICt7DQo+PiArICAgICAgIGludCByZXQ7DQo+PiArICAgICAgIHU4IGFk
ZHJbMl07DQo+PiArICAgICAgIHNzaXplX3QgaTsNCj4+ICsgICAgICAgdW5zaWduZWQgaW50IGQ7
DQo+PiArDQo+PiArICAgICAgIGFkZHJbMF0gPSBGSUVMRF9HRVQoSU5WX0lDTTQ1NjAwX1JFR19C
QU5LX01BU0ssIHJlZyk7DQo+PiArICAgICAgIGFkZHJbMV0gPSBGSUVMRF9HRVQoSU5WX0lDTTQ1
NjAwX1JFR19BRERSX01BU0ssIHJlZyk7DQo+PiArDQo+PiArICAgICAgIC8qIEJ1cnN0IHdyaXRl
IGFkZHJlc3MuICovDQo+PiArICAgICAgIHJldCA9IHJlZ21hcF9idWxrX3dyaXRlKG1hcCwgSU5W
X0lDTTQ1NjAwX1JFR19JUkVHX0FERFIsIGFkZHIsIDIpOw0KPg0KPnNpemVvZigpPw0KU3VyZSwg
d2lsbCBiZSBiZXR0ZXIuDQoNCj4NCj4+ICsgICAgICAgdWRlbGF5KElOVl9JQ000NTYwMF9JUkVH
X0RFTEFZX1VTKTsNCj4NCj5TZWUgYmVsb3cuIFRoaXMgaXMgYWxzbyB3ZWlyZC4NClRoaXMgZnVu
Y3Rpb24gaW1wbGVtZW50IGluZGlyZWN0IHJlZ2lzdGVyIGFjY2VzcywgcmVxdWlyaW5nIGZvbGxv
d2luZyBzZXF1ZW5jZSB0byBiZSBhcHBsaWVkOg0KMS4gd3JpdGUgaW5kaXJlY3QgcmVnaXN0ZXIg
YWRkcmVzcw0KMi4gd2FpdCBmb3IgdGhlIGRhdGEgcmVnaXN0ZXIgdG8gYmUgdXBkYXRlZA0KMy4g
cmVhZCByZWdpc3RlciBhZGRyZXNzDQpJIHdpbGwgYWRkIGEgY29tbWVudCB0byBleHBsYWluIHdo
YXQncyBpcyBnb2luZyBvbiBoZXJlLg0KDQo+DQo+PiArICAgICAgIGlmIChyZXQpDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArDQo+PiArICAgICAgIC8qIFJlYWQg
dGhlIGRhdGEuICovDQo+PiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7DQo+
PiArICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHJlZ21hcF9yZWFkKG1hcCwgSU5WX0lDTTQ1
NjAwX1JFR19JUkVHX0RBVEEsICZkKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgZGF0YVtp
XSA9IGQ7DQo+PiArICAgICAgICAgICAgICAgICAgICAgIHVkZWxheShJTlZfSUNNNDU2MDBfSVJF
R19ERUxBWV9VUyk7DQo+DQo+Q2FuIGZzbGVlcCgpIGJlIHVzZWQgaGVyZT8NCkkgd2lsbCB1c2Ug
ZnNsZWVwIHRoZXJlLg0KSXMgaXQgcmVjb21tZW5kZWQgdG8gdXNlIGZzbGVlcCBldmVyeXdoZXJl
IGVsc2UgaW4gcGxhY2Ugb2Ygb3RoZXIgc2xlZXAgQVBJcz8NCg0KPg0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KPg0KPlRoaXMgaXMgd2VpcmQuIEZpcnN0IHlvdSBhc3NpZ24gYSBn
YXJiYWdlIHRvIHRoZSBvdXRwdXQsIGRlbGF5IGFuZCByZXR1cm4NCj5hbiBlcnJvci4gSXQgc2Vl
bXMgZW50aXJlIGNvZGUgaXMgYnJva2VuLi4uDQo+UGxlYXNlLCBmaXggYWxsIHRoZXNlIGFuZCB0
cnkgYWdhaW4sIEkgc3RvcCBteSByZXZpZXcgaGVyZS4NCg0KQWdyZWVkLCBkYXRhIGFzc2lnbm1l
bnQgbXVzdCBiZSBhdm9pZGVkIGluIGNhc2Ugb2YgZXJyb3IuDQpJdCdzIHByb2JhYmx5IHNhZmVy
IHRvIGtlZXAgdGhlIGRlbGF5IGV2ZW4gaW4gY2FzZSBvZiBmYWlsdXJlIHRvIG1ha2Ugc3VyZSB0
aGUgZGV2aWNlIGlzIHJlYWR5IGJlZm9yZSBuZXh0IG9wZXJhdGlvbi4NCg0KPg0KPj4gKyAgICAg
ICB9DQo+PiArDQo+PiArICAgICAgIHJldHVybiAwOw0KPj4gK30NCj4NCj4tLSANCj5XaXRoIEJl
c3QgUmVnYXJkcywNCj5BbmR5IFNoZXZjaGVua28NCj4NCj4NCj4NCg==

