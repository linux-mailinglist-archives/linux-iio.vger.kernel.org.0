Return-Path: <linux-iio+bounces-24347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AA0B901B8
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 12:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4321042437E
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4A30101C;
	Mon, 22 Sep 2025 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="pJnroNV8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7FC2FFF98;
	Mon, 22 Sep 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537339; cv=fail; b=nDdnmBH1yBdmDpPp3XLk5xTnkF4v4kv3P+9nZTOzOpafQJ3rXNGW02S/7Otqea8OSxefzmZoVttM3GMbkIrM5wkQQv7xfEXayuCFMCac8zTQ4+NWEuAh2ATM02ZjatxYuPJOAYAb7C61DU5csRXJvmV79oGWgf2tpNSrg5mHw/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537339; c=relaxed/simple;
	bh=gHKQ3rNgjBuvQWZzrG3RZXcdNMvNzmKzXoUjJ2RGT1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pLf/oJxOCandcwsmS+CuKdTUcqTvtyBqvJM6+WQdCCA5zIUyh2/moVtaNtT1EArMx4716jtmBMHPCDVUUgJzZlq/9lznFxjr5TWppbbhUzA/REYXb2ChQUwirXCqI6njZlLl7YhzqW9Zc/P+yVkorwriW9mWtqu4yOgQ/JzJSHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=pJnroNV8; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LMt1kf002684;
	Mon, 22 Sep 2025 08:52:07 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012030.outbound.protection.outlook.com [40.107.149.30])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 499nmks366-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 08:52:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbxMmANbjO0nmPMwRNgclQfwfW2sPrKxMDq/wGYCaNdIRaR3572U8tMom8Dwi2OTNhmzKgQf96bi+O7kEo0GIDadomWKlM5RuW+RjAp9WWgfsgqtWRyJu8ZFwAO3oNWQeyyZQTB98X64Mv8+nYl5HBvMYWqI3DdeSB254lPbSCkj+BgmUZkjpCN0jL6pAFv3mj+KvS+3gelcApTuY0vTRvirsRQYSRB8NFrFD+X89SWgzSei9l81SnP0q/X0/Y8Vr2uAoZdn3mV59v4HeQek8WA+oi2Q5zs0tX3tgBwEH5+f6pXrH9m00EW2ggezUV4yJ+hTUWctjTZUHoDb0FsWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHKQ3rNgjBuvQWZzrG3RZXcdNMvNzmKzXoUjJ2RGT1k=;
 b=xMJFLHamY7In+oTB2FpRJOtSLs2QHlQNJMwHYk1lnTQmbRFQIBejjK/LAGPAMxFBs7SFr89tNo/3J+IDt+EwusAhFT1AtqlKsxHFzXLXuwP/0qNVLCrtfnu+XxLEn2wGNNPqIYPO+aT2L/udrZqN/bOhj4QOcSzOtyWqenAbnq3wNVlzEBdN1c5S8Qt5KeyqCAIbTcxY+jGEdLyLPpQYfpDRL5O0bNkveRls/8hIiv1GVjX7QJSywYTaIR7oThUlGJd1z/X/gLl4SDV1k33QiJ34w6jTkl73tvEzx70jaMGZqBKydVgngu9V3PLUsB/R9qUzFZ87tqrBq7VYUW202w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHKQ3rNgjBuvQWZzrG3RZXcdNMvNzmKzXoUjJ2RGT1k=;
 b=pJnroNV8sz/WsYXQW+rSIZyBgtx0MOUJi0yjYJ5c7Zno+FsRiH2/oEQBTrCI+mAgR70pD2y6kcS2JBxzMWkWTZL2faioz4F/jdJB2fz5KzYe4gvxYUwCGjy0ns/021h3SuOMJPCUHCaRScydshkD4/TEW7MaIcQsJpsoaAn62jZwuoNhNnJY56Wm8O5ZMjogB8Hbcb9W+cTJM/YZq3kqGJShLt6cPs6qNlP3QswdbyspBwReab++3bD7QxGsipvCqbhByoevAxDpmk8UToJSHsyY9Ip2hbC1vTIRn73tdpF2NV65NKZqiU1vP8o+555MuK+nuiIZ3LbZaDTCW8LDyw==
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::2d)
 by FR6P281MB5153.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 08:52:00 +0000
Received: from FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c8a5:5cca:6c1b:3aac]) by FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c8a5:5cca:6c1b:3aac%4]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 08:52:00 +0000
From: Remi Buisson <Remi.Buisson@tdk.com>
To: Remi Buisson <Remi.Buisson@tdk.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Frank Li <Frank.Li@nxp.com>
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
Subject: RE: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Topic: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in iio
 devices
Thread-Index: AQHcEd4ztutuCFLUl0eAj91guc48ZbRs1gyAgBXxAsCAAFqbAIABf+HggBp1G3A=
Date: Mon, 22 Sep 2025 08:52:00 +0000
Message-ID:
 <FR2PPF4571F02BCC81AF28562AE548DBC228C12A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
 <20250820-add_newport_driver-v5-3-2fc9f13dddee@tdk.com>
 <aKbk9WYtfb5L5la4@smile.fi.intel.com>
 <FR2PPF4571F02BCCFD984FDD99C69CAE7298C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aLmY2mKg_FsPOpsq@smile.fi.intel.com>
 <FR2PPF4571F02BCEB6C4FA4B3641299A72C8C03A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:
 <FR2PPF4571F02BCEB6C4FA4B3641299A72C8C03A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2PPF4571F02BC:EE_|FR6P281MB5153:EE_
x-ms-office365-filtering-correlation-id: 0f4180c5-0a99-4721-b28e-08ddf9b54b59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|38070700021|3613699012;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZktKNjk5SndmdnN6c09RalFjZTBrWWE5aU1CbWl2d0RDNXZ5TlJLQXllYTUx?=
 =?utf-8?B?enovRGwwcjIwUTM4VFJ3azNTbnRTYXh0a1BudHNjRW1TL0xJV3ovYmVuTzBV?=
 =?utf-8?B?MHZPYi94NG1LZzdxUVF2Y1hyVVZtNWRIQlI2ZUdic1ZMRXpIMUJ2bkNqQmNh?=
 =?utf-8?B?bjUxdHlWRXlWS1RUa3ZXellTSXNldE5MdnRpempiblNITCtyVnJaaGJDV3lW?=
 =?utf-8?B?c3NRaGtQYjNtU0k1dlFZRDdVL3ZRQ1FNT1Y4TitXeUhtSHI2WFFZY2w2TmlY?=
 =?utf-8?B?ZDNCWXA0SFJQOXowOHN2dE00d3ZodjU4RFdkMHM5TGVQWWpWVkVJNUtmb0JX?=
 =?utf-8?B?VEx4U3NtVlJYOXRhbXQ0OU9IdWo3U2lrVGUwVEdwYUZzTGJWamdLSGI2aE44?=
 =?utf-8?B?UlJ3ZVZqNE5JYnd0eDl4SXJxTkhOWFpRRFd1MkxJV1hkRjA4Ymp0NlRncEtK?=
 =?utf-8?B?NmNiaVBzOFExYnoxUTZrREVqekI4SDY4NW5reGx1amJZd0xPUHB3OTI4ZWRG?=
 =?utf-8?B?QjVRL1d4SWFLTTdkYWFKblhkZThnOHFVU0NFMUVjMmExTkt3MExEUmVscFBr?=
 =?utf-8?B?MG1DTnNTTlpQNDh2Tk56N25uU3crM0FHQXd6L3ROOCtkanpYRitZc1o2a1lS?=
 =?utf-8?B?eW1GRll3ZVdqYTFrMVRaWkt5a3RzaDhPeUliODAxa0xVOWVNRWZGaEhxMDM5?=
 =?utf-8?B?cWU2czI0Y0psR3UvMWJFelRYR3dPVkdIcm9ERnhQa1R6TzN6MitsT09zS04w?=
 =?utf-8?B?TW5Wd2tlc1JjeWlTdktpTjRqbHN2WVJ5MW81SjNlZGpyK2NWZGtDdlA4YjlD?=
 =?utf-8?B?ZTZnUk85TWZRMGpDaWlSalFjdkI5Uk8vRWFVaEZ5bmtYNHMxcUY3WWR1TTRv?=
 =?utf-8?B?ZDU0RWRxaUk3eE5SZjBMN3Fvc0FXeUZjQTFkY1dzdkRsL3BXbnNSY2RhRnMw?=
 =?utf-8?B?VytVc1pUY2hVaWFWVlFSa28zRTJLSFpxU01yb3BieDZiSTgxWkNEQVlxSndn?=
 =?utf-8?B?MDhvdDd6akMwSnZER1dNZ01rYVlwMWhmQUhydHFMM3hLbXRJUS9WdnhSSGxB?=
 =?utf-8?B?R01XM2lsSlJHSzFvOXlkOEZDL2ZTLzB1Mmc5MWdHaGF1Kzk5NlF4ZFBBVGtQ?=
 =?utf-8?B?VXI1MExHUXNkVW52MHNNdmpsZzd6VnFjdG53YXNHeHoreXJNWThTNEVycDFl?=
 =?utf-8?B?NExpNXU3Tmw3S2RGZ1dBZUh0TzJISGxJU1orYzBqeDU0MlZJQjBSTk5RZ1Zs?=
 =?utf-8?B?cWIweHQ2bDIzNGd2Yitqc0d3OE4yVnhwWExoN2RRMjZjbDhFeElkK241Z1I3?=
 =?utf-8?B?dldkbmlPd0k5ZzNPek5pbGViaDQ3aHIybUgvRnFiN3VUNjVOT045SkEwVWVY?=
 =?utf-8?B?QU16Ni9VNnk4bU1aZTZ4eXFZSWlPbHFHaXA0YWdidi92QWo5c1hjc2tDaHFP?=
 =?utf-8?B?ZzQyMkxZNXljckU1OTNLbVpsNk5JOTl6MzdsRlA2Z2RhSU1QOG91SlM2L1Bz?=
 =?utf-8?B?NDBaYlZRTlYvRzRrdkM3ZWhSUlcxTEhONXhBemQ0bXRYeHU5c2swbXdMWVlZ?=
 =?utf-8?B?MFRreG1uWSszNzdmejhMU3h1cHpGc0NmSGwwOWhLVVQ2OEFwMVBkNkdCZW9F?=
 =?utf-8?B?Z2EyS0d5cW5VckpLSHFJTnQvcGQ2SUhNUkRSYlplRi9ZY2g2ZCtWWEs1em53?=
 =?utf-8?B?S0ZPR093dUloeGE4Uno1MWNyZStiUGFjY1g1LzAzOTF5clpDNkV4cWNaNkdL?=
 =?utf-8?B?cktYMW43YUxzVHVLTDlhWUozd3NXK2E3SXlFZENiR2EvSXB0NTdmNGM5dnho?=
 =?utf-8?B?bVJKMVVKTTFFVS8zVmtubjgvSytiS29uNGgwV1NmeFNUcTlKTkRDeGVQR1No?=
 =?utf-8?B?Q0ttbUt1ckE3VTdkUnlNbmZHQkZMcDZHMXBBK1Z5am9GZ0JyQ0xUVG9MMVZq?=
 =?utf-8?B?dmNpaXVvUEV6aHFXcFNYdEpJbXo1R1ZoQWQ2NXo3QjdKa1VyaHM3bGRnOVF3?=
 =?utf-8?B?Z0JucmJtMWhRYjVoWEJvTmpCcjFiR0Z1eUkxQ0JaSGtQMkxRM2Q3WERTendu?=
 =?utf-8?Q?r5qRTZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(38070700021)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1VXSDVZS3dCNy9BZ0d1cTVYb3UvVkJ3TTF0SS91SmdpLzR2VzlDTzBmakll?=
 =?utf-8?B?ZmtDbTViUXptN1RQS3BYSzMzbVc3b3c4dEhuOWNySXBMdFhCbEx5VXlSNE8y?=
 =?utf-8?B?NjJ1YzRjUFJ4RVk1Y1JNWk1DbFVMQlFhT0lNbGE1dTVSL0o4L1R2dTdJOEl6?=
 =?utf-8?B?RDBvU0hWb3NzMTF3OVhobS9TelBSTmw0dEtNVFpVQ0NnQlR2QnNCbnZxcGQ2?=
 =?utf-8?B?dnhxZFJxVk1yNXFyOEFUK2ErSFRxV3d3c2lMSW9FbDh0QUZZYmhRalJDb21B?=
 =?utf-8?B?a0s2ZVRIdmRaT0dsN3QxMUZUYUZwV2xINlRMZ0J6OC9OMVFKb0hiOW5qbVZY?=
 =?utf-8?B?RjdLZDN6am9RcHpmYnZNK2hKMFZLL2JJSHRDYlBva3NqY3ZnYTBSL0NJQTdl?=
 =?utf-8?B?V3VLbzlCUDluVTJkRzBQYXcwbGZrVFNBbS9USXNKN0VJR011RHlQKzFEQ1FL?=
 =?utf-8?B?M3l6b1NTT1B4MVRkTGh5Y2F4T2dQaVZzeVNZalNuL1RDVWhrT2xDSTgrcDcv?=
 =?utf-8?B?VmlyMVVzNkp4YUZpWWs4Y2xCcys5cXZOTTVuVnNaeXJsMGRGbzVGbzNuYkJ4?=
 =?utf-8?B?bEMzRkZUTHgwb0tTZGJCRE5iSmx6bjZYb0pCaGU2M1RuNkh2cW5GUWRtQXI1?=
 =?utf-8?B?a1pGZTJrM2ZtUmhlZzJIMjRIOE8vSzUyM2krRGFRdWNmU0U0bHF3RnF4RTVP?=
 =?utf-8?B?SHFrN0gyK3BJNTgwT3E4b3htdmNZS016bCszOUw0UFpyeWpwTlhxOTQ2a28w?=
 =?utf-8?B?RklJaHhTZjlTUzMxTlVxQVJ0eWhrR2taUURhYXNzUjlpR3VKd0Q3c1g0NWRJ?=
 =?utf-8?B?Q0RQQ1RrZzEvTjRIZHdZcmpvbUFqYkVXNi81L2NmV2xqRkY3blJvd1cyMGpB?=
 =?utf-8?B?TlBINFp5RHZDTG1SckVLenlGM01sTS9SMFlYZUI3V24ySDBtOVpyNTlBQXc3?=
 =?utf-8?B?bzgvbkRpZ1FyNEd6K045SXhqcWNmVElwVGFna0RKOXgvZFJkRHNpUjF5VEJM?=
 =?utf-8?B?VzZkWHBXb0xzWHlkNWlia0JJQzRoVGxBR2ZrRHR4bkZjcTBJTjRzaCt5QlNP?=
 =?utf-8?B?YUxUSm0rL04ydm5WaFg1dHY4VWg1R1QwVEtzYktUNm81ci9seGFMeDRoR1BB?=
 =?utf-8?B?SkhaRU96REJzZXdUVXMzK1htNUtMdlRBZnMxbC9WRktYSXZhMEVtUXd5MTBl?=
 =?utf-8?B?Qjd3MUJ1YWdDRHhBT3VMbkxqTkQxRjU4NkhXd0Nyb1J0MWtQdS9nKzlmdDBD?=
 =?utf-8?B?SlJlTlRwSVZnc0NlK2orY041eHd0ZHZsbGFYU0kvZ1Nac2FEcXJ2ekNlRUpS?=
 =?utf-8?B?ZXFGOTN3Q0VNY0I2cG1BRFdEejVMSUp4WEdreEpxU3dIdVdwSmdEMWRQd0Vz?=
 =?utf-8?B?ckpyd0RFU1JteWsvcFlwc2twNnNDK1MxMVRIZXNvOFI3VDZwQ1prTzEzUFpZ?=
 =?utf-8?B?R0VwbnViVUNvWnJLSjdQMjZjVERybmsxZ1kyNjlOZUMreDN2cCtDUTcreC9J?=
 =?utf-8?B?UUZJMWw5SlNCR01hUURBRnhuOE1CallhQlpNVmRLZDk3WDBNck5JbWFCdmpT?=
 =?utf-8?B?N3VDdW5SUHoyTWlSTmRoay9zeVprL2YyTXBjZk9GbEs1dVBPY1Zua25IYWJQ?=
 =?utf-8?B?cDU4YWFQM00wWHpEWm54ZnRsVGZRZzFPNnQ1MnBLVitSb0IvWTc3YzdIM3Bn?=
 =?utf-8?B?eDY4V1VRZy9xZzAzZGx5TEltUUJ4UURCY3lwMTJGV3lzNFlTUFYveVlkQUds?=
 =?utf-8?B?REFlWkZUTnU2Z3ZKK2l1NFplQnp4b2JxMUxobmtTaDNYTmU0TE1vUmgwY3JO?=
 =?utf-8?B?cE9Ma2pPWU5FRXFXb3kxZklKRzgwTytXVHBpMy96TEZ6MERydkk2elJ1VHVM?=
 =?utf-8?B?Tld6UmJTZ3Zxczl0YURISU9tdjBLU25US0Z4cTgwUWV4amVjVmo5aGZJSnVu?=
 =?utf-8?B?QjVpVzlpbE9oZUxWT1c0NlFHbGllWjVrWHFXSlRPK2hZOVdtUGxsc1k4dzVK?=
 =?utf-8?B?bUFwR1J3aUV0ZzFxVXdDMXVNUW5jUUozckFabXQrOVpnL25aSHRXbmIxbUNZ?=
 =?utf-8?B?SWxxQVZGYkNzenM0c1pjM1h4ekEzS0IybDNCZTRSb1Y0SktiOXAwdExPSFFV?=
 =?utf-8?Q?MkEvx5YseUnOPOK7JeHfDI8xb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4180c5-0a99-4721-b28e-08ddf9b54b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 08:52:00.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvcvr4ciUXaXmCn9nPJykkJye0Y698e35dsqI3EW3LLG8rtd2PdiEdTsD+0LHr/GC8ChWL6g87UDH1sVhlspAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB5153
X-Proofpoint-GUID: vO9nKODsV2SeCRwhziGKf6TbkD-93_Ij
X-Proofpoint-ORIG-GUID: vO9nKODsV2SeCRwhziGKf6TbkD-93_Ij
X-Authority-Analysis: v=2.4 cv=Y9v4sgeN c=1 sm=1 tr=0 ts=68d10e37 cx=c_pps
 a=xYlzcMvyAqRjWpF/8gTk4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=Uwzcpa5oeQwA:10 a=QyXUC8HyAAAA:8 a=oO2kte6CjEoIfacSOHwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0NCBTYWx0ZWRfX+o9Ui0q7+HNN
 LxOXwkffjHTbD7kvSEK5v1sqbIozWB6NsW6rI8VYPVRaBKCwTsZtAmU9F1vx6F/CzQY0RxNw1Ov
 yoit4YvQi4eOAf4Zo2CK8DyfIO9gzx9KG6KLUu7l1FLrookgwjWU45fmIWdmm05GvAVWT/zknmh
 u+zAbI8UhUzA24Lok8QKwk8nKgRzvNNB8rgwPvNw8coTy1uOKr5LQ6izZPo48r5HV8N/5x6a8Ku
 beszg/HYgMK4v50ga2BU+kZ5fkBZa6oEGruCVkGfKwTemflirikqsuvjamzBZXeMsfKVUCCFpKv
 DgD44E265H1OycORxmXAZhYO/qFqWXDEFqUmk5sKk0b7q0ax8SfyqRL++n2fGe1j7SvuMP8PjuO
 UVUaZBe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200044

DQo+PitDYyBJwrNDIHBlb3BsZSB0byBjb21tZW50IG9uIHRoZSByZXR1cm5lZCB2YWx1ZXMgb24g
dGhlIHJlZ21hcC4gU2VlIGJlbG93Lg0KSSBkaWQgbm90IHNlZSBhbnkgZmVlZGJhY2sgeWV0IG9u
IHRoZSBiZWxvdyBJM0Mgc2xpY2luZyBpc3N1ZSwgYnV0IEkgbWF5IGhhdmUgbWlzc2VkIGl0Lg0K
SG93IHNob3VsZCB3ZSBwcm9jZWVkIGdvaW5nIGZvcndhcmQ/DQoNCj4+DQo+Pk9uIFRodSwgU2Vw
IDA0LCAyMDI1IGF0IDAxOjAxOjMyUE0gKzAwMDAsIFJlbWkgQnVpc3NvbiB3cm90ZToNCj4+PiA+
RnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+IA0KPj4+
ID5TZW50OiBUaHVyc2RheSwgQXVndXN0IDIxLCAyMDI1IDExOjIxIEFNDQo+Pj4gPk9uIFdlZCwg
QXVnIDIwLCAyMDI1IGF0IDAyOjI0OjIxUE0gKzAwMDAsIFJlbWkgQnVpc3NvbiB2aWEgQjQgUmVs
YXkgd3JvdGU6DQo+Pg0KPj4NCj4+PiA+PiArCS8qIFRyeSB0byByZWFkIGFsbCBGSUZPIGRhdGEg
aW4gaW50ZXJuYWwgYnVmZmVyLiAqLw0KPj4+ID4+ICsJc3QtPmZpZm8uY291bnQgPSBmaWZvX25i
ICogcGFja2V0X3NpemU7DQo+Pj4gPj4gKwlyZXQgPSByZWdtYXBfbm9pbmNfcmVhZChzdC0+bWFw
LCBJTlZfSUNNNDU2MDBfUkVHX0ZJRk9fREFUQSwNCj4+PiA+PiArCQkJCXN0LT5maWZvLmRhdGEs
IHN0LT5maWZvLmNvdW50KTsNCj4+PiA+PiArCWlmIChyZXQgPT0gLUVOT1RTVVBQIHx8IHJldCA9
PSAtRUZCSUcpIHsNCj4+PiA+DQo+Pj4gPlN0cmljdGx5IHNwZWFraW5nIHRoaXMgaXMgYSBiaXQg
b2YgbGF5ZXJpbmcgaXNzdWUsIGRvIHdlIGhhdmUgb3RoZXIgbWVhbnMgdG8NCj4+PiA+Y2hlY2sg
dGhlIHN1cHBvcnQgYmVmb3JlIGV2ZW4gdHJ5aW5nPw0KPj4+IA0KPj4+IE5vIHVuZm9ydHVuYXRl
bHksIHdlIGNhbid0IHdpdGggY3VycmVudCBJM0MgcmVnbWFwIGltcGxlbWVudGF0aW9uLg0KPj4+
IEkyQyBhbmQgU1BJIHJlZ21hcHMgYXJlIGFibGUgdG8gc3BsaXQgdHJhbnNmZXJzIGFjY29yZGlu
ZyB0byBtYXhfcmVhZF9sZW4uDQo+Pj4gQnV0IGZvciBJM0MsIGl0IGlzIGxlZnQgdG8gdGhlIGNv
bnRyb2xsZXIgZHJpdmVyLCB3aGljaCB1c3VhbGx5IG9ubHkgcmV0dXJucyBhbiBlcnJvci4NCj4+
DQo+PkhhdmUgaXQgYmVlbiBkaXNjdXNzZWQgd2l0aCBJwrNDIG1haW50YWluZXJzIC8gc3Rha2Vo
b2xkZXJzPyBCZWNhdXNlIHRoaXMga2luZCBvZiBBUElzDQo+PndpbGwgYmUgaGFyZCB0byBmb2xs
b3cgYW5kIGV2ZW4gY2hhbmdlIGZvciBib3RoIHNpZGVzIGNhbGxlciBhbmQgY2FsbGVlLg0KPlRo
YW5rcyBmb3Igb3BlbmluZyB0aGUgZGlzY3Vzc2lvbi4NCj5XZSBpbXBsZW1lbnRlZCB0aGUgbWFu
YWdlbWVudCBvZiBlcnJvciwgaW4gYSB3YXkgdGhhdCAod2UgdGhpbmspIG1ha2VzIHNlbnNlLA0K
PndoYXRldmVyIHRoZSBiZWxvdyBsYXllcnMgYXJlIGRvaW5nLk5vIGZlZWRiYWNrIGZyb20gSTND
LA0KPg0KPj4NCj4+PiA+PiArCQkvKiBSZWFkIGZ1bGwgZmlmbyBpcyBub3Qgc3VwcG9ydGVkLCBy
ZWFkIHNhbXBsZXMgb25lIGJ5IG9uZS4gKi8NCj4+PiA+PiArCQlyZXQgPSAwOw0KPj4+ID4+ICsJ
CWZvciAoaSA9IDA7IGkgPCBzdC0+Zmlmby5jb3VudCAmJiByZXQgPT0gMDsgaSArPSBwYWNrZXRf
c2l6ZSkNCj4+PiA+PiArCQkJcmV0ID0gcmVnbWFwX25vaW5jX3JlYWQoc3QtPm1hcCwgSU5WX0lD
TTQ1NjAwX1JFR19GSUZPX0RBVEEsDQo+Pj4gPj4gKwkJCQkJCSZzdC0+Zmlmby5kYXRhW2ldLCBw
YWNrZXRfc2l6ZSk7DQo+Pj4gPj4gKwl9DQo+Pj4gPj4gKwlpZiAocmV0KQ0KPj4+ID4+ICsJCXJl
dHVybiByZXQ7DQo+Pg0KPg0K

