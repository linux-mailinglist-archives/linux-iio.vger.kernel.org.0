Return-Path: <linux-iio+bounces-18596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0900A9A8FA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 11:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F6F1B8623F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4424F22489A;
	Thu, 24 Apr 2025 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tI2oTELJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182BF19F40B;
	Thu, 24 Apr 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488165; cv=fail; b=tdW0kboAuWPJgbbxVUjFQ3RXUfOE9pCL+UfN3r9REVyUBZoISL9qP1nuDAK22NcW56ygbhZAPsYR30TlhVMHLyoPLiSLTOjrkGP435ZEJ4IuwLizdmjRSnz+MZpu7Fh08l/dMqx3rRy4xUvOwLruxKRW+esjq23DhmkYxgm+MqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488165; c=relaxed/simple;
	bh=EikcNuG/586SDp4NVTYYEStoVA4NgxNHBQesHUPYC9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RFdcHjzJOJje1r0GEM5dX3hnd2Xwo5/V6OGzoDYy2areAuP1KSdkv2tLLQ6Ar3GBc3+iZI6CH8h/GaW2ClVjB4+ghq5Fd1LnV1CuWAR+vLPDnCRsaLw4zC+UTUIB2ZmDVAqIo1Edbk/pgKDLu/nEeqdyWHGboFqjhMgTU18QofA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tI2oTELJ; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O5cbE4012300;
	Thu, 24 Apr 2025 05:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wowHi
	/QljWISmVa/M20JhNwAZd4VnHT6YGBANTnykMk=; b=tI2oTELJJkz57LwPqtYKi
	snzOp1WZFTTkC8EKKEhuMHhnSv9Z01+dGdmEUQnEDHY5M5rnKOJNTAx/iFDnWo/E
	hqFCmbqzcSDZsRsV6kbicR7N2VWjG6G5W9+vxFSgizq8UinmIy5VDUUnrbnxZLrK
	k5mvjzTULMcj06lh4inup9zQOIXC9f0sIZY7ZGstNO9UDRgkyZ2FnmtXdS9C0Mz4
	4SJUIcT+0iS6X+AeQ9+Kx0hVTRR7QDSO5Brl7CMd25akBYSikC+dLy2n7z6nNf84
	gRb6FYRq4iLXZ23NCcQUr2QV78PG407dxFMwaGWRp4obwhbERO+oGydHViJr8y4n
	Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012038.outbound.protection.outlook.com [40.93.6.38])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 466jn5fdej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 05:48:54 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pp2m6j4FdknsI+dTu0hnm3ifc5C9whUrNrxTWa7OhRjFWdIegqGyjl8M2ucxF/xw2zPnMlRLr7Jr1AV7meX+ZsjR96kAL7RgVs4m30f+oT8DkgoU064yGCmT+y30kPMNUXw5ILYLAHxruDj/StKSFyM+/9FhxCLPcsJFd0fZww08+a6Xi4elHAw89uoJTSJS/sGt+kdVmYItla1tjinaySfzzKd1b8AqXH/D8HPVf7wqm/FpldfgmPI9gOJaFsj1wSx7IstmI3zG9JM7E2AXLoF9yu2Jpo3Cfv5Npvl3y5yZedLeR1RXeNNvM3rv/v1/3zTn/bYArcIAoqepchggSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wowHi/QljWISmVa/M20JhNwAZd4VnHT6YGBANTnykMk=;
 b=lwAidfyFlgD5l4xGPg7GxW2CKfANLgYR/chpILrqQJ6ZibJoREd5RSlOl23mobp5ICP5V96NB9s+EmhKwOYOH48yg5k6ZZapEYFrYQAz2Gc5SYRywO/nj2GSk9R7Jn+G7ZeXH8PZt9V5250x32UxvMuFVDHQoYDQVs70NoB9lqJqmeET6TQehvFxitwOPdfeV0OGl+LTJ13IWYHO9BgvSvFl9cySu2tqN3qKfFwcYt8MQLUed8PaL0aZGuXQwoYMNoG/75IViMQpFQQdtVaxLbj/lL+KFEJyFS4NI0+i2dSP9bNGMnthxWYJ47MaqeF/MvilYx3bkgHdajKPPE0Ezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by CH4PR03MB7602.namprd03.prod.outlook.com (2603:10b6:610:236::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 09:48:51 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 09:48:51 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Andy Shevchenko <andy@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Topic: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Index: AQHbsnVyrRgqZmjV0EKE05LwnZhDMLOvzK8AgAETIrCAAJq9AIABGw4g
Date: Thu, 24 Apr 2025 09:48:50 +0000
Message-ID:
 <PH0PR03MB714184F6DDA26F9A89C05283F9852@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
 <20250421-togreg-v5-3-94341574240f@analog.com>
 <aAexmOU1e-7hXq6Y@smile.fi.intel.com>
 <PH0PR03MB71410D0F7716DAB4A2103AA1F9BA2@PH0PR03MB7141.namprd03.prod.outlook.com>
 <aAkaMp9R_ukoW-RQ@smile.fi.intel.com>
In-Reply-To: <aAkaMp9R_ukoW-RQ@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|CH4PR03MB7602:EE_
x-ms-office365-filtering-correlation-id: d5cd1b36-7854-48e5-73d8-08dd831537c8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cRxIz43hBiZRf4oCq819Nn67IyDUPHKJaS9O6hPiePNni79CnjIstPxQi9?=
 =?iso-8859-1?Q?pkqCTWEAp3jpsYb2dgrTZuf9CzwyrbRWfhxTeLuXEk3IVaz5FCfhzOtGSI?=
 =?iso-8859-1?Q?vEEvphrMCZRFrn9Npw4VZ0uktSYC+PEG0dUhW0mPkd2+yKEUdreaXtQ26n?=
 =?iso-8859-1?Q?pxKcWa5bXdDxUdMAz++ZPSNV0ETLA0LIuNvOvsCd/z8GIfPRmMszcJ1OxK?=
 =?iso-8859-1?Q?4Dr+2PEXq7+Htx7HhneoDEzQPwCwTgV2KnmpPrF++6hP3wJpVG0jcNbkkV?=
 =?iso-8859-1?Q?+3D0UpQtHXT19fDEAN67uXxRDNWzZ7LYxk6REl5k8Z5r2m0QqfzG8354vP?=
 =?iso-8859-1?Q?/NuPrqgnvK3DoKNf4fgW0JjWCrGGZ6X9sKHTT1CqbDjwfl3Hqw1kvfyaww?=
 =?iso-8859-1?Q?/ycdTvKRPa6q/+gUPiwn8qLb4OIwAya4tR3Pj9wmDJcshNhomriu5PKguM?=
 =?iso-8859-1?Q?W6C54ALag+LUHFqR1VKHCiPGH+WWoyoc9/qPWreqg4iP9kUkIPZIjGIQbp?=
 =?iso-8859-1?Q?gm61Hq7HhOQC/1xuHIUUMalojAs1XBkf9KnDcRlRXAnKXUX7StyC45iP+I?=
 =?iso-8859-1?Q?y05BCYIHejC7LGI82aQB/qPwkWCXm1E700UigrHUcP7JBmj3FW8Wks/Zdd?=
 =?iso-8859-1?Q?RdLnD+bYR39lv5KeiF6l8mIRtXUSJjqfTtTPYbYuTPeJlfIlgsKApAf2i0?=
 =?iso-8859-1?Q?6Cg8osQ19RdbY4hhSzMmEQyVmizZWc40oymG9Vhx9kmEnBp2wPvvBjZhoQ?=
 =?iso-8859-1?Q?CARXgkOZJHfpNhAB4XcCi4eKo4uiR5/sBhH35FeZpHaZBsPGaZk+D2NNY7?=
 =?iso-8859-1?Q?HjrL28KeXe/58LxXba/t9SRKqVh/2AyMBdWyRiLNSalDNPbZrr/rb2YoDn?=
 =?iso-8859-1?Q?Q46KcrmUumJ4UPlmwuZB883cPykyVKiYFyWYYrnhGHgYpmO+ulEmakO3yO?=
 =?iso-8859-1?Q?TJZZTh0OzQZ2cCZ1X1xRfwZ/x6Dzv+SewzFDRMqoyU1F+eKg7b2K4ZcOL5?=
 =?iso-8859-1?Q?ESLS2OmH0zcfpRB4b0hSzW4i7VS/GdGGiG7eu4E785zv0O4/k4jL+ESmc2?=
 =?iso-8859-1?Q?iGxGF+VC4XMPTGI/lkeBHBWe68tzOeVtOEn4v3q5RgjCLUnl5kZ4MuZ2wT?=
 =?iso-8859-1?Q?0BwDjJQQoRBSF4VTAyRrA4Y09b1HOus+k1yzIPBnCXnVqyvI6uP94jTM0v?=
 =?iso-8859-1?Q?rIgWFPyGlqvZ4XELkmReh9VprKrNNFJ4W+o8uyR0V0vfHIQTSJThP7v0Oe?=
 =?iso-8859-1?Q?zUOrK+rv9kD9cFYuOOuWhZOP+CZIEAOmVfxA1T0TX76QJInkDJNwLrhx2G?=
 =?iso-8859-1?Q?4v5KfHDRSmbRiE02ApapycHCL8Y6iwzeoGKjdEBi7aXSvfZEQUR10QUFSh?=
 =?iso-8859-1?Q?8qCVduNKVkanxwLX3+TV2J8fITrrdN2rxBcoOS7js+vx9dnOq+9jKHXXZu?=
 =?iso-8859-1?Q?7E+ruBIRENMr9V3u6s3EvTCUf20onekA8DD8bo9e9EjLZh9lUktXOxm2lb?=
 =?iso-8859-1?Q?XBxCHthIp5ZgODFMO2DMAQrePCdu9BNHLphLkdllUyVFS3/pu+mLN4xTUA?=
 =?iso-8859-1?Q?Lgw2ejY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XN+7Ax5+JedT2ykX6hg35DvE03QOmPUSROrn2InzvD7CD0dtxUBn3ecjHk?=
 =?iso-8859-1?Q?ISP1F3IGZ3gttsh1KZ1kBq3WWiKtYSVwWhVnvnvpTYtvYGOzDLUnx5O/Cr?=
 =?iso-8859-1?Q?WJefSiO7nloMBrJRadvdonYZgvoAC6//+wE/su4ieWRhys3e0ZaBHuaFAc?=
 =?iso-8859-1?Q?hvSLdyxdkSMsZRK8UefKPd9Qx1f2ogqfhzWzijKSHRtsd/89v7J0DP+fdF?=
 =?iso-8859-1?Q?U42eJz/HL4kcFJByiUyTttqLLORXVlqxeb4oJcFeoIW35TntMmIwJ3Yqsz?=
 =?iso-8859-1?Q?3M0VuyyeRA5OJrgENTGMH4sJ/BhgvYyVUUdpmit2WadZz4K5NtzjWjbffd?=
 =?iso-8859-1?Q?0mDrHWOWI3nIVfI7sjuz405Llxa2ZCTm/LU05l8tUDroPDOCgQkrfucSR/?=
 =?iso-8859-1?Q?DdDzQipaAZqCS3hcCwsMea02ud09wkG51JFPuuuHn8gBfucmTeXWndRt1N?=
 =?iso-8859-1?Q?ciIs9XAg7T2oy78L1rASdT7pEUsEc8+A75qtSVMGDtaFPeWfBkz+iInHkB?=
 =?iso-8859-1?Q?0/lNiySIFe22+R0sqHMj6RyUqhvLJUNKCVE3xZKQHCVKdPq9J0/kD9L5Os?=
 =?iso-8859-1?Q?ccEaeRi0PoGUxclP+OrGNhD/vKWKaybgzSQI0KfzwN/vt/akfKwjjNxrXc?=
 =?iso-8859-1?Q?ZgZPltYH4qOWGn1j7Re/tYA0cmMpRJJ6GhIhjOojuE5bVzz31QFeG8eAK6?=
 =?iso-8859-1?Q?RXdgWtjHOXunCT5kpqjVqVi6xyRPE6Tvg9kdSBUd8TogN/+Kn9L5t/NjBt?=
 =?iso-8859-1?Q?L9SaJAcv8jxwqPNOLJ+34b8HQdH7bhuHlatFcm4c06v9T6HyhTjGJa8yvq?=
 =?iso-8859-1?Q?2afKCrb13J2yWXSgyGmvUiUFU2CD1LoFAs09fvU7LfKfW5IiesK+2mQmW5?=
 =?iso-8859-1?Q?aArBy34KjxWFsvms6d5jpKN44HY3HZcZnwvNYFFCjBF8RoOv4Qhc27WHno?=
 =?iso-8859-1?Q?mzrkDTZC8eFJJ3KYrDeNNyHMz9weV6XWt4ZrlrATgPofok6KUHOHBzvA8O?=
 =?iso-8859-1?Q?OAen1Oo+du9AhHrxZcnZz9nKlFW6Tl0oK1JWSGvpV9qsveRN37duCCiLZx?=
 =?iso-8859-1?Q?q8shon0DfPBSlrL3uSVpAyvRn6dS3P0rz4P/WkiLcY8kJeOcZcsSAJv6eh?=
 =?iso-8859-1?Q?X7GniAoeEfh4EhiaS5mmepik0ytONS0+hIW4YiqzS9mU71tYmQzfcvjJ1T?=
 =?iso-8859-1?Q?L1pu0FimoRLF04JDwxIFAg0qIrP2soA74oAl5Rm2GFKCTtCSn0f62d6sbk?=
 =?iso-8859-1?Q?RpSVYPo2JPUMsFsNcCcZ484kWW8npQO+tnFc1w0l3ydB1rgdOThue1z61D?=
 =?iso-8859-1?Q?Fu117T5KoGo2P2X0h5JB3MEOFLFRfdG0q27bKOn6ZpjfYsGD59DwPgDdYj?=
 =?iso-8859-1?Q?z63YtSuMtpCTX+MCUnrkcIS5GMEYFKBhq/yz39fi4ca3Djyl+EHgrQkiQ+?=
 =?iso-8859-1?Q?UHjmi0rgXZZ4muZJZXNd/FaRGx3QV9LHvfGmIw84/PRSTL7dzrNrgtu4sh?=
 =?iso-8859-1?Q?+7UQYEtp68ZX90lMUC8BF4bKm05QzoLexc3y4ByLRCpL9BgLV/HQQF0wqY?=
 =?iso-8859-1?Q?b0WGtFVJ4VSB5fyMunF7xK51/nFaxvI8N2gN+XVhxSwOooT1129bznFUtv?=
 =?iso-8859-1?Q?DLI45Bon2Trf0QJOmtktz/oSHqYjvVoKKV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cd1b36-7854-48e5-73d8-08dd831537c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 09:48:50.9389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNUNE3EKOOFlWDFuAVXdV5Gr5BgqVy8v40uvIEYW4C1XNoV31Av+0U51gt50qTp8t4Bi5r079+HZCHM8XVL17NM+HWDUjuoO6qv5p1W3pIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7602
X-Proofpoint-GUID: sTJIpDmbp3Vam1KV_V9I_chmS2NdKXoq
X-Authority-Analysis: v=2.4 cv=bNQWIO+Z c=1 sm=1 tr=0 ts=680a0906 cx=c_pps a=BX/OqAvQ3O7aab6wCuJmTQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=Piq76OM-RhPO37aF9j0A:9 a=wPNLvfGTeEIA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: sTJIpDmbp3Vam1KV_V9I_chmS2NdKXoq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2NCBTYWx0ZWRfX1URymJ1gr8zf Cs585SRktJ2bc5dWmlGXM6U5eF6c+XjVIEy9nvlNdymBKDuruU2o2o/Wpno57s13N8c5RKPZsDg 1N3LmwFJJLMyFsbfliltbGtvohwjOkIOyN4zjvyypMeZO+h/oB/PyZiggZS+DlJgrNyE7XU6BoT
 zdpBiH20Ycw0s1ZzxC6pXHiok40+RF6z+0Oof61Jy/anKowLcS90oiegUK3xyx7IDJqiq6lkApK E7LVlRP9U/DJPyE4w9DZLE77/flFs72kIkFGUgG6eEbTVMJbhgV6VF6F9+JK65NzmBXjO9Mh7Qu hot8zL9s6r+gpXGfHHyqinsNQdbz3n4wlADgFdIzoR+J5YVxlUSemoSNrnA1ESxGDEpPXQUATHJ
 k0trQpx0JKrpPNU2GShQI636i70Jq3Ens4H45OwF2jwRSB2tekrF/63/+CbZmKDnwT7xPEXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240064

> -----Original Message-----
> From: Andy Shevchenko <andy@kernel.org>
> Sent: Thursday, April 24, 2025 12:50 AM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; David Lechner
> <dlechner@baylibre.com>; Nuno S=E1 <noname.nuno@gmail.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
> AD3531R
>=20
> [External]
>=20
> On Wed, Apr 23, 2025 at 07:53:37AM +0000, Paller, Kim Seer wrote:
> > > From: Andy Shevchenko <andy@kernel.org>
> > > Sent: Tuesday, April 22, 2025 11:11 PM
> > > On Mon, Apr 21, 2025 at 12:24:54PM +0800, Kim Seer Paller wrote:
>=20
> First of all, there are a lot of comments left without replies while some=
 of
> them commented as "agree I will follow your advice". This is confusing. T=
he
> rule of thumb is to not reply with positive at all, just only for the thi=
ngs
> that you want to clarify. And with that remove a lot of unneeded (you agr=
ee
> with) context!
>=20
> ...
>=20
> > > > +		st->vref_mv =3D range_multiplier * vref / 1000;
> > >
> > > MILLI?
> >
> > Yes this is milli, will change this also to vref_mV
> >
> > 	st->vref_mV =3D range_multiplier * vref_mV / 1000;
>=20
> Ah, I was not clear enough, MILLI in capital letters is defined constant =
which
> you may use instead of 1000.
>=20
> ...
>=20
> > > > +	vref =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> > > > +	if (vref < 0 && vref !=3D -ENODEV)
> > > > +		return vref;
> > > > +
> > > > +	has_external_vref =3D vref !=3D -ENODEV;
> > >
> > > Wouldn't be better just make this 0 when it's =3D=3D -ENODEV and chec=
k just
> the
> > > value without having this additional boolean variable (note, I haven'=
t
> checked
> > > the meaning of Vref =3D=3D 0 in case it's possible in real life and h=
ardware
> behaves
> > > adequately)?
> >
> > I think it could be simpler to set vref to 0 when it's -ENODEV and chec=
k its
> value directly
> > without having additional boolean variable. I'll try this approach.
>=20
> But double check that hardware doesn't support Vref =3D=3D 0 in real life=
.

I confirm that the hardware doesn't support Vref =3D=3D 0, as also stated i=
n the datasheet.
=20
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20


