Return-Path: <linux-iio+bounces-9671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D28097D704
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F203D1F24FC9
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C017BEB3;
	Fri, 20 Sep 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="iPOEKJwr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13B17BB32;
	Fri, 20 Sep 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843178; cv=fail; b=Xzkuut+/KDwoQgd6EcvMeGQz+ioeYwYGogEQt/7Uxh/UZtjMtAUkZZfHL8GvjFt266/NnatukBpK4OWUkgmNB4XyOpETtdhz+mS/NAYLvULtDpXahTH/7rT3RDEiBoj8nwGa2ZeOxGdDXDlQZ2+dVocc6eOf+gVNF7hHZW+3oVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843178; c=relaxed/simple;
	bh=BCqJt1jO6Dxa3fnK+VBvYJpDu18cPQNBngbr3PHG+Uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=miE2+AWmg8sV2ZUMpPsyv6pp5VovRb77iQit2QGSadUxMmmJVyjzQ7EHO1u7HgDhS03oT+TykhqUlZE20JkCFQxJIK4Az5k1WzMr6ZK7vlefqzZZVqQFI+6F1q+d24tYYfN3rPJ1P5PFw/KgX7y4a97EGX6ZHCIY0FOsoyiniAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=iPOEKJwr; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KDnJif024531;
	Fri, 20 Sep 2024 14:39:20 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazlp17010001.outbound.protection.outlook.com [40.93.78.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41nt89v29y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 14:39:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDhirxFFT6mRLHz0GAxkoXPtETG2DxcvgqozqRQr+178DC51UMrDA8Q/cHdBfzSV69ghU3Yf7ZPOsWGul9AaP4FZKwZ8wC0jOfl3vTVONT7rVjaqItPe8ylYWvv9cyzwdhqojpn5rF0hwd36t38XK7sY47E9KrjpngZ4FU43JfztRfdedWLUVBq8TlaZNCE3gMjD9p0MrVvXMBpw1WDwLPogLs3vjuzit7xSjxFI4wMinkWXTa7ajdZqcO11UoWuZM5e6Q/FulrknP2mbavlnHT9VTwsom7FbyglL6R4FkFx8Dw78P2cfbbhAmAUjFmjOKAQLE+4XoAjYNADxU5yew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCqJt1jO6Dxa3fnK+VBvYJpDu18cPQNBngbr3PHG+Uc=;
 b=hjzV0gHmsu8GJA4JtTcctichDoCTe3mEADrDL/ZqGvOc0hzYE/JMl468OVgU0PXEbbF9ZXEpfENfLRKi0Cq25YEaMgwcYcQbMurWOQbTnLrcfjcGJUSrrOSdbvkZrw5lShgCTlnnyFBMbQfOG5gDFgI+ljcQP3TF8c+xgvrImD5KA2oiHpAFOk8t9FO9xR0sPvGX/mRQcOH8GtyDViTd2yTKzAOtKyN1tqA6tnQsY1OIS/VclzYBc153uHLdgpKQgjOxo2n4W6P571C8cyfubx65bNxVOiyfklj9ml7QKFfgqP0F14W+XNEhXTP3GAaJVh1Khd8rI/Yw36s9VrALoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCqJt1jO6Dxa3fnK+VBvYJpDu18cPQNBngbr3PHG+Uc=;
 b=iPOEKJwrMqxOG1BLoK8vXfcKCC6AbfZPFu5tZ21PoUPjl+B027nTtqjzVogisiCTYLmLViQvNPrs4JQ/Z6rNeGTIbF5yKlSH1KWm0oZC0+hjOC9qguFeOQanGEdmegzbIpxw0AWLTFFra8Y2Q4ebOTUZ+KBYJiONVXn8oBS+YbKUtaT6M2bAfSNlQXiPbVHJnI7kT0YzpZRW+Gc84wnfdUU0GoNUwXA0SsJ1mrJjF5/R0em9GD5+oDwK80rD7F/PIgYUL89/4TVXaSq7eEO6X1uD9pSFGrVQBWpAdbrO0yNSpHNiQnEolJgU1NSqpzdy6jSAgsjcwj4PcT0vi/FxgQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEUP281MB3594.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 14:39:14 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 14:39:14 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        INV Git Commit
	<INV.git-commit@tdk.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp
 bindings to mpu6050
Thread-Topic: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp
 bindings to mpu6050
Thread-Index: AQHbC2IfeuX4VZuHAkKKXmmMZBovk7Jgrk2AgAAQmDk=
Date: Fri, 20 Sep 2024 14:39:14 +0000
Message-ID:
 <FR3P281MB1757A18AD6B116CF34E9B811CE6C2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240920133615.167726-1-inv.git-commit@tdk.com>
 <20240920133615.167726-2-inv.git-commit@tdk.com>
 <43982b29-e456-4e7b-9cda-322ff876a276@kernel.org>
In-Reply-To: <43982b29-e456-4e7b-9cda-322ff876a276@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEUP281MB3594:EE_
x-ms-office365-filtering-correlation-id: a01a1792-37ac-4a6f-64cb-08dcd981ffba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mEuD8J5tV2OW3PL/8+hhLKFbizTjtf9T+NH6SzBTEJFIiK6n+S6lDFNuDd?=
 =?iso-8859-1?Q?6QmAUCA8u8B7N/6ycRRw+zUVWboExrV2/CZLHSdvUM0c9XqsRNo8Xe6pDA?=
 =?iso-8859-1?Q?hHy5au3pGtlcmNlmUG3r2jbNv585OE3Cbe3iA37/dRnpkxgkA80QbdS+sm?=
 =?iso-8859-1?Q?OOOeZzPtOUiw0fNNSZLJ/nRdHYk4K+RWVoGIvTCTEJ+Ux8plrc5dRzMraa?=
 =?iso-8859-1?Q?MnOLFpxcMlVgsrD4V/SkX8u/hsIa4PErcdAFvBiDcOJ4j9+iH64qxyCud7?=
 =?iso-8859-1?Q?dO01SaQHAny94O1WOA61zGSCaKtkmaiWBaMH4/ZrQea8D+gWMsTDjebUvT?=
 =?iso-8859-1?Q?qa7lTjR3B1/jujf1j+5z3bjRU6cEnOY954RFYgeqWrShyzujP7Djiq7xSP?=
 =?iso-8859-1?Q?SE/HIDOKfUUP0X27BspoITbx52FkeIhmSKWbV5XcxSlQHRUOnrJQlcd89x?=
 =?iso-8859-1?Q?y4uZZbxg4RFp00IFwoLVWtfXRI2sBqC/pa684TXv7QeLn6Ztq18Te6FRRR?=
 =?iso-8859-1?Q?O1iWKiRweF85JVfY1OX7XnVEZ1nBYmwCOHO5uIIA3qWV7z1nuBRgWHfgq3?=
 =?iso-8859-1?Q?5WASggR2m0hsGjvsMgl9LBD4Qt1pJh/mqZVJlc3J2iWCeYpb2c2eNDG6Mb?=
 =?iso-8859-1?Q?pL02/BSYMsz+uURPrhxJ+NOQV8mtfAkibS6pdwsgYQcIqIBFzwiyTH32zk?=
 =?iso-8859-1?Q?HHjbBa/Gez6/J21EzkLvpFRwZbc/Z80wVGLvqHolEcQCCS5Uf4kq9RYugV?=
 =?iso-8859-1?Q?qMc7lEiaL7/co1eZD5EtWud4QaFLkNw4Gwb3/s5RvwinXC1WNQJKwr9bpU?=
 =?iso-8859-1?Q?CmuC57PgaiqMUvvTuDA+Qe1PmQN6Q79sk/APEg7MGqf2jENFThLdCEyP7b?=
 =?iso-8859-1?Q?liiRFSNuHhy8JNv0LsdDO8tovoIUZAJivaVfLJy3bJezdjEyA3UZNn7uN9?=
 =?iso-8859-1?Q?8RIpIr01MLrMmk4U9jU0QPe5jNX1qgK3i/HdAbJjJGP/uQuIU6W/TJt8Z7?=
 =?iso-8859-1?Q?jGGoFNEiiRdJMqXP9y+T9zD2t+WaGstoGhX4+H6RwpOuQHwgDTRZOGtiGo?=
 =?iso-8859-1?Q?e86xTPFKUTFYSvbKNgurYNABravKzTaYsucHXXsKN5okC68dBr2lANeQvi?=
 =?iso-8859-1?Q?P0DJLRjVR7aXVaDfJNBmzGKG/0LHZD+ezu4xc/nwoI6amLs0EYsPgg+tSP?=
 =?iso-8859-1?Q?GjqBlrF6bPkFU2yCkb+dskGgCSxmDtdlTPqV+pFw+QWvt9ng6QsKsZ4B1b?=
 =?iso-8859-1?Q?vI8Y+GXsLJcE3vw7LqovKXIL5kVS0zXR6qlr96n2xS7VHB10nQpIhYpUgn?=
 =?iso-8859-1?Q?MTJ+aP1syABVhqlj5xFv6LThQoYkHACgneovWTrZvmDMOpe8mXN4AjQqas?=
 =?iso-8859-1?Q?XvStbX7R4C/zhwzEPzD8Eh2KBXzVUHkA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VyqSs0bK/rcnrX1V2JWLglz0OHhUQEuPjgOp+3J/1fmOkHVZ56G971xGPJ?=
 =?iso-8859-1?Q?q3/chJfgFI8GHlAVuf2rdb6q87ihMj+aS6Tn1RSr64EGTLZiWN38gRXomT?=
 =?iso-8859-1?Q?vcNzRjfjyCFnc6tnzv5CJ57lwVr4B7sBniUmtreH6IJqAtex/fupNoKOxI?=
 =?iso-8859-1?Q?eEQj77YX1YQqlmjTnbz2+KBMtzILydp+CbvtWR3sUIoqHJ9Vi37ztxqqTv?=
 =?iso-8859-1?Q?DPoCY1s4hJExusFSqhvmrqrguy2cS9Fn2dbeUniETG7//5WiUERnh/J5d/?=
 =?iso-8859-1?Q?nWlr7aXQ+1CvhRTR2/pjWI7foWaZXU1mfVcYMhLOWNImuFn/hOmHUafpGF?=
 =?iso-8859-1?Q?gTsT1qtG6y8sixFJNlgbd62aPIpmcXDXSqZ1wH/bm2jv0eEYmWeZZXc1Um?=
 =?iso-8859-1?Q?PJ+Dm2LHB3YVwWvnic+YYDQSyNXE75h5Vu/ozFMifRtPHK1Ceb2p30FxzC?=
 =?iso-8859-1?Q?9/woDKHqOj63Tqb+nvtNZTW2v19WigCpXK9DJPgKdbGL81q/d2HAx4LULr?=
 =?iso-8859-1?Q?mUPuHqQO49WofkiGzSIhiiChjP+I/jtrSfoQoXKwq/RNFvbGB4Tt/K1Ffp?=
 =?iso-8859-1?Q?bcq0eg/oeT6GBU2GA4GKgWGnaBnfvZbsyU9CWIJrcjPaCf1JNL529K5IQZ?=
 =?iso-8859-1?Q?ZCnYyoJyTfu8xn/WCu/tCsUOGYFlsyXm67N6au5Y0tzEoyv8xjCmBeTghy?=
 =?iso-8859-1?Q?yEq6qs/j/6ft1sbaoapWWno4Sn4dmsRrY7vgauhe+87S6YBT5hajfNl3FB?=
 =?iso-8859-1?Q?uPWRTuUQH1J6GXx009K3V5BuW8xh31eiQSsCk9Q/9Pp1HyWcCu5lWcSxmf?=
 =?iso-8859-1?Q?iqLSMVNn4+KtPxba4tsdKmJhBvoAh8iaFqtVSoLT+1phdJ06dDfk9Wf/rF?=
 =?iso-8859-1?Q?vdABIwwwKjlfWmP3ZMo2kXsIrwHempHsLs7/F5e1YAlAmCrEySke8Mr9+X?=
 =?iso-8859-1?Q?tikn1So/XlAlSpTKUvcYJN/dpozhPnUxth2vOZfWvT/L8bPLDk8h/YUtbs?=
 =?iso-8859-1?Q?3lxemn+PzFUn/8sEP8YjzIK4N8W0ajb9+/xsMTkjhwenhe9ukZZ49ijVeq?=
 =?iso-8859-1?Q?GTEjg4D5gQqMGdGH/QIUdUzzmkLNeCq9RvbrWExbMFZrsEDfdzBo7Z+zUL?=
 =?iso-8859-1?Q?fR7iO9nsAR9D5tjvLc4ljQj7F4Y1eE5XpzhlVs6GKcwBuEc5d9h60jqzLV?=
 =?iso-8859-1?Q?GqLIgcxNBrCm9W6OxkNiidEck+L2klVF9IZCgygk+muP9hzJb3RDdeLn38?=
 =?iso-8859-1?Q?6kMyhH9+OIcsAEV1KoifAnu+dgG07EYGKx+LQX7x5Oj1lZN0hHQRsWzzl8?=
 =?iso-8859-1?Q?1Th+Qc+NjjFSvFoOuGOryFkTufXC7WZfFLwhcBY5gX4ZHG8u16T6uvsN3x?=
 =?iso-8859-1?Q?lLSf9dESfVjb6YO0NcfgHDd1Oe7Gb6lFhWTujlXHK7YKbxOyO0gqRb9tQa?=
 =?iso-8859-1?Q?mI50yQBC3TizdKBMq0cbOgMqIIED1/rWpEBsR/YmfZbZZZqN6eVgnTzOn8?=
 =?iso-8859-1?Q?4oo+rtjwsLIpQ+2T0c04F7WlzVo+JDiDkmZk/ZfwVyz3xb1VWEjXeXpYHv?=
 =?iso-8859-1?Q?vlu9PkEbxZnTn+0WJAEL240mEBvLDDDlF8lLpWylpmiESoDlFqBI+lNUNN?=
 =?iso-8859-1?Q?min3XblZimLaXoVjh19A7v9TJc8cPzxApgsg/58cS3zwXp+EXV6OUmlWh2?=
 =?iso-8859-1?Q?U8X5KfGRgYFojNTfK/sfa5G13vtKT1is/g7k8ETHnyGnhKH+G70HzbRsUH?=
 =?iso-8859-1?Q?S7Uw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a01a1792-37ac-4a6f-64cb-08dcd981ffba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 14:39:14.4010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hifC2ufsXlJrkrdKsXoDmAjk8hCFhnDg0LefpTHUyEAr+U96xyZfFgCYlGYf1qgjlILnfT2O4WnAOweO4CamawfEzQU+v9u/eGTQUDbpWj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3594
X-Proofpoint-ORIG-GUID: gSIaClFC9Xi78ml-8qCcWjp4QZvQJqJ6
X-Proofpoint-GUID: gSIaClFC9Xi78ml-8qCcWjp4QZvQJqJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200107

Hello,=0A=
=0A=
sorry about that, since there are no modifications at all in the patches an=
d just sent them with the added email lists, I wasn't thinking there was a =
need to update the version.=0A=
=0A=
I will resend with an updated version number to the right lists then, even =
if the patches are strictly the same.=0A=
=0A=
Sorry about that.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent:=A0Friday, September 20, 2024 15:39=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>; jic23@kernel.org <jic23@kern=
el.org>; robh@kernel.org <robh@kernel.org>; krzk+dt@kernel.org <krzk+dt@ker=
nel.org>; conor+dt@kernel.org <conor+dt@kernel.org>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org=
>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Subject:=A0Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/h=
p bindings to mpu6050=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On 20/09/2024 15:36, inv.git-commit@tdk.com wrote:=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> IAM-20680HT & HP are 2 variants of IAM-20680 fully compatible.=0A=
> They just have better specs, temperature range and a bigger FIFO.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
You just sent it... please do not send the same over and over again. See=0A=
submitting patches. Your contributions should be versioned and provide=0A=
changelog in cover letter or within patch's changelog (---).=0A=
=0A=
Sending the same over and over will get the same answer: nope.=0A=
=0A=
Best regards,=0A=
Krzysztof=0A=
=0A=

