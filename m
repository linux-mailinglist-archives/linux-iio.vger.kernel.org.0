Return-Path: <linux-iio+bounces-26419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2AC805E6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 13:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C609343A3A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3C42FF66A;
	Mon, 24 Nov 2025 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="voJon6Vt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE87226CFE;
	Mon, 24 Nov 2025 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986177; cv=fail; b=AuYRJ8YMqJTJk1DkQNi5qbEVuMEu1JFpCmY+MipO2sMwLBVpiTl1m3SRNwTC6TW2DnMgV8sxXgOGjf4yHxF7CtRyiIFTSD0LODU7JqoRDUikYF4wIsPP1NJvPXuQSUV8hW1k2Nk7RIRvF9aBQqt5ULUUso6++KjxYqlTF2QGUwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986177; c=relaxed/simple;
	bh=3WHKOF/1OWntXGunbU9VB8ckUZ+kpyv5kpuoozBZIHc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YrHzRVZcozslVl0dRqTt+k/j6pm8L9taJR1f9qQV5l19fi0mt1W9ma4mSbiHkilH9ARZX1tv96IabBTAVRXeC7Pq2vJmD6WOjE5wq9ulT+p1kP00T//vcI0b5ppLgyw7WwdG61UD59JKLgJa/3fxH22JECpbYceSB10FbaKh9PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=voJon6Vt; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO82if12829992;
	Mon, 24 Nov 2025 07:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3WHKO
	F/1OWntXGunbU9VB8ckUZ+kpyv5kpuoozBZIHc=; b=voJon6VtgV9FOzHqJ9oH/
	N3XNWljuFv0n+GQ9eleuEhvctAlRlLVUap4psU0tVpMQ0D7CxeJmscnYvlxfgqtw
	Mf7BUYKH9WXwXHYpZcGDvukS5UIlRSW1qXfwfBBtj/1NjM9cYCe8t5ztWoIx9At4
	U7GBcNXGE3qQCCusLn/45f+JVExW8IqDWjFru8WfgveVKEGvRbEHSZ6F7qMx9+us
	a7RTI71nHEPYFldl5tBVL4+GQTVwFEohN7RIMVWZ3mNk3wN+zqMFPO83/PMe2gOV
	RmNdIkO9BWEsHTQpFOqL5pgrrdlH+8u0z4gqwzpUvo5+mRqnIUNEslaxker98HFt
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4am8p3jysm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 07:09:21 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyc4Ma13qsoZZTTr9ZsCwFzhhdY0Oymb4E3pVUJcvEeBCu3lCV8eohYRsHNGZUhXuz4o+yISeEcrRw5vFDFBt1hRYiR6yKNgSehsAoDEt8b+ZhPC/pTrvCUh1zcfByTX+7Q85/0v1O+xh3SrWB6oWBHuJ9Mlsg4R4/72Uz8p7Xk4IAYLVkIN4H8sPbz/hLxUu2bMiEYQiGtlr093OuIX+NplRkuQmwdhA9DjM4okzbG/OXa77Eq0lbPakdxJc6Nd44COAIWqFD0D/3z/i291tHKY3KvGSa5s2oAET4SYF0yceLJz7nzo6kdtXgwLTSHO8NpXhGs9X8TYES2HwjgWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WHKOF/1OWntXGunbU9VB8ckUZ+kpyv5kpuoozBZIHc=;
 b=jDzzwvsjKk6IYW987Zru23Y3tU2uT56rcJYZHEQCWkLgyv8Ch6vZfvnVAODQmWVEIS/d+zNi+J2P+Zu7i3yHR2NRNkHlrqPGYB1jU/hUC9+rH/dc3VLtw/R4LhHcGaaxxUMiwFQ5ty3/NC+kW7I4+8oxotczUwslRGYmTLmbL1x0dBbisyS56tZFEpcbdPcHyNOwA1oLlBuLlHxoZXOHU2dBlBEEmJJJJmG1mEZ9mjWbfqFtpXsA5tVaICdA8KBqVyn3sP6fa201F+0PdOuwtBbtoSzNqJZMyrAe0vHw9Jkr27VTrJJnPQ3/QfOZqh6f5ZepoEWww2zuM2ouhs//9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CO1PR03MB5890.namprd03.prod.outlook.com (2603:10b6:303:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:09:18 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:09:18 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        "jic23@kernel.org"
	<jic23@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 0/2] iio: frequency: adf4377: add clock provider
 support
Thread-Topic: [RESEND PATCH v2 0/2] iio: frequency: adf4377: add clock
 provider support
Thread-Index: AQHcWs2nogfUHYzk90OoGttLdSIrqrT+7HSAgALTGbE=
Date: Mon, 24 Nov 2025 12:09:18 +0000
Message-ID:
 <CY4PR03MB3399892478516DB8724CDF549BD0A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20251121095933.19032-1-antoniu.miclaus@analog.com>
 <37d15b55-4483-428f-9950-46f1b0ab2a56@baylibre.com>
In-Reply-To: <37d15b55-4483-428f-9950-46f1b0ab2a56@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CO1PR03MB5890:EE_
x-ms-office365-filtering-correlation-id: bb2695ca-c5cb-40d8-f77a-08de2b524b68
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LeaRXoUGid6nW+wqgYp0vZdSOLVOrgT+Tk0dbj7+VsBdUF9YpRZag7IMKK?=
 =?iso-8859-1?Q?h9WpoKTRVcFLKGPRHHBmW/0u0z4zjEt59gGs+dTjy1qBCCfVMwdtAXeBhm?=
 =?iso-8859-1?Q?TAOQU3gVTYeHFPWjSX+JX76oUIH9I8B+u992gFgV4ks1E5IfHtXVoY+RGS?=
 =?iso-8859-1?Q?gPqR/dMzhIa3Q/Fg0dcLoPpLt7IwCx3EluokPuBx+5c2pWPq9mdNxk8pna?=
 =?iso-8859-1?Q?je+eFKO20XHayJlhTFWtpQVwV44/eMBonYU6RE9OF/h7xG3EaMf0QcYH8G?=
 =?iso-8859-1?Q?n0dpfyveBTXGFFCmFB63f9RhzAYpIXDmetmgx3L4Ls2bXI+rCKT7o+2jDw?=
 =?iso-8859-1?Q?U4AVUPdy2SqQQB1z7S7u+77PSI+fHNb+jtxeoANb3/0dTVZo67K2e7W/nU?=
 =?iso-8859-1?Q?osm9SDLstqXcQtJaUJU7VjdbuRAlqM7OKFWEJZgbFoczKgfz5hNrFaQvvv?=
 =?iso-8859-1?Q?hb+EoJ93Yoo1XTF6XcnCeE9r6Oq93wFu3JqvpMxLec8Hjyg+jLjUEjxvtg?=
 =?iso-8859-1?Q?B4OqcQtpOfjIV35f2LqeYWCapSEqunjYWQda6v5jjlbsOxEAzJhg+fdxa9?=
 =?iso-8859-1?Q?rSvZjgassUoiTdKtxsPIrAOioU7m8xVBtHpBMEQ9j4/HVhP+aEtERtK5Y+?=
 =?iso-8859-1?Q?itDVNOVOIHkAd8m6xvY5931QM6e3XsYBZKt4lTO2wkQu6TsnIjtee6Z+YQ?=
 =?iso-8859-1?Q?P0tOgrQdXQ25sWFkqAQtFtUjA0A3kDcmR9f8+xOzU0gGLy3v7sFv472BJ1?=
 =?iso-8859-1?Q?MCXa3btcZhf/q85joEIAWz87O+ZeEWLo9LIeWR1dsnE58+tALn4Z1i+G6Y?=
 =?iso-8859-1?Q?TiZ30FmytlRO+D0/hKfkt087nWThoVihr1zUvVzCPbku2P3wYL+ZmmZje+?=
 =?iso-8859-1?Q?+WvCoGNlWmyJLq7493NmCoJcl/TeeEXByZNLuDsmfTW2BLwnMnYSNXOnN5?=
 =?iso-8859-1?Q?7nOwcOX2+H11hJ0F0hidxYjE/5dw0jxMN02MtRJrOnxMBOz+tsRLJlhftS?=
 =?iso-8859-1?Q?btHyPqrQg/qvBf7eYl0Emn998XhjNq/CSel3S5iEzzs4z6PqKe9CwbsnQf?=
 =?iso-8859-1?Q?T2jROsByGU0qsJd8t3voLjYQ+afokI/zNLz7lQ+i/0O8b0gTmWzpswVT0w?=
 =?iso-8859-1?Q?kL5ArZ8cMZjW0ufjWX/ouCvjGdiU9ngsIHLgT7npfjBmRhBtv5i4ZMYwKJ?=
 =?iso-8859-1?Q?AiVO+clHdyIxXZmLCnsTBKVmd/mHaxbS6yfVDiTW957l/DSP3/tkhMSKtW?=
 =?iso-8859-1?Q?dzeghK4lqCfmKX4V9V7bpahXRZNiwmjBpOcFB6mLejVCPTaDCZ2jXsb6xT?=
 =?iso-8859-1?Q?tI+MVQ3bOSiTa5o+iC4BhuLwtRHjF03hJO0t+C2RsN7UEFZgbeUrnGt5OA?=
 =?iso-8859-1?Q?ooQrk+3di7hs5ZXJ027UN84WawbyN6ng2vwTUYH60EyFd0Vtwc6v1FpvcT?=
 =?iso-8859-1?Q?t2tnyAwaG7g5rgrScY52RqM90597f1T85lpRG/bmvK4qglQY5zmSL5aQBj?=
 =?iso-8859-1?Q?FJuIZrlodUJ+USYTlPAYQ+HprgJSyU9TDazggEfrfvP1bwIljZ+ymyRw/x?=
 =?iso-8859-1?Q?MjKp+DrCvV2VmporbXKBqjvhxsko?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cdp6og5uExyNT8QZc8dePqMnhMtiMbkorwqlbkRvm+6tEB24yYmxrgpSVc?=
 =?iso-8859-1?Q?DXaUBtAKbV2RS5P8Ftbg97t83trUmwGIIgcYvlrilVYvLeFtwD0YT3u2mu?=
 =?iso-8859-1?Q?br29+B3oLh3sZRk/dIQJIJuIOk8oyNGAsegl9EjfHYEQnim/lniChX9o6d?=
 =?iso-8859-1?Q?10LyEycDvXyQ+cPArX/2KMseQhwmdEz1ZnWo2ecYQ9xESErI8royTvc/TS?=
 =?iso-8859-1?Q?EVnW4krubC3p8GiTn/2owPELQ+oyHZQHefMsN3jqfztCufD+6hO0UKQCUM?=
 =?iso-8859-1?Q?cCh89r8L9/G75Z+ObTJQTvnN2F+TMg0aBS+k+RHstoRrKdPNKp4GC9K/Al?=
 =?iso-8859-1?Q?3BMADRox5mHL9LdvjcQ4bvBkWNs1n2zbx+4Fy7zkqCJ563aqb7gGEd4/9F?=
 =?iso-8859-1?Q?RwRxseB/sc8C3qjCSkKNeLTPoa9y4Rw0xI0DUTq5MSgVxPGTTNIhPgfxYl?=
 =?iso-8859-1?Q?o9JQ6pc6WYGUV0NsZOccyY7HXXnErklcSiacL2tQHhBQwpI1NheWFDGPsB?=
 =?iso-8859-1?Q?UotMyKH3ynmGLrg4GnUjD3qpt89y4HmzbbPat943lx1fEAxJOsHihjdS2s?=
 =?iso-8859-1?Q?vWP1JB5oGoOIbOhmCpzrksvzZy50yCaevcKtG9fYRPZw6Dj188B5x8Pyuq?=
 =?iso-8859-1?Q?5q4DB9C+fGFY0iJD9FeSBFnedUbdZJRWNHVevHvgXl9xxsRs5p0c5SexXR?=
 =?iso-8859-1?Q?2AE9HayVn/LxlYBZZQjuQyR1YkwMradhMpe37/bFCKaJ884x9gwAl6j6zK?=
 =?iso-8859-1?Q?uYyHzleuSoisLGInsnQzTv8Kzc7AdZH5CVjo5nSBZAji0lGxS0GD5t9UVA?=
 =?iso-8859-1?Q?9yu3FXysQMKsBFP1auuj5/HGpGxNwsIc/gbxLw4Fqw6AbcSA+8oCmh8z5/?=
 =?iso-8859-1?Q?phA8zVR0SL0krymX8nnxyzTimCiNOU9sYPd7mBV1sbXtSmcb5f42AaadFS?=
 =?iso-8859-1?Q?YWLPI3WKp8G15FlBKyRPRlpFn777sv7nXKDIY+Zh7iRbOISu0qVDq3QWz9?=
 =?iso-8859-1?Q?HSz7HI50kwcH1iKe6TQ6J0A1ZTO8ACPzSkJ6KN9mK0mmvnb1aWvlnF3bVV?=
 =?iso-8859-1?Q?cwM9DzATPZHlxi+TDqp/IbzBmgz3JSdeo//dgouiRQ2BC33bx2xuSkI7/n?=
 =?iso-8859-1?Q?lJQJkkwluxQXNWS7qKPbmsTi/+zD5U/Cil+dXziTAlbNOqgTsMGNL1Ql0n?=
 =?iso-8859-1?Q?LeQRyIO5BSKT9Jy1pF/wcHSppfo79Dv5B6vHagk6oLPp40PtlfQnXGbtHg?=
 =?iso-8859-1?Q?4v/bTz/eVzYfGIsaUo7pQA8qHoKZNywEm5MzbrrrGVE/VPhI5FuZuRDeHa?=
 =?iso-8859-1?Q?JuC5bVhfvzeYuVXlFWSMIUSCJNpk0YhLw1PMGsDBWgvssTG/UFNDYC9nNK?=
 =?iso-8859-1?Q?hGJJ3lF+9alLMpsNVDJv1RW3usb3aHonQb2RSuNfkwHt/erqoE/8ZQJXW0?=
 =?iso-8859-1?Q?B3JnED6KLFJNp4Nvko0FhHPk5SPgwpEf/Fnzz2NIirmnoywmb0wihBVPKA?=
 =?iso-8859-1?Q?E+om/ghGRZIFQRrxIF+c5oXGyZpSme146Rdf/yvOZ77PoCpoGFEinX7itD?=
 =?iso-8859-1?Q?qZTxsmtvAoK8VLr3kjms1dSAh3Hpgc2bFxkIZ8DuRRmPS+2KqXvKuHLKkr?=
 =?iso-8859-1?Q?g8LxWb+fu7LCMcXBYb/KCCZP0A9qyGiYn2?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2695ca-c5cb-40d8-f77a-08de2b524b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 12:09:18.5462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zsRa1FcdjeU+pRraw+cktdAWifMwqQr25Je01NiW1lM626t70+wPkY+p05ER2Qzo1tbSDcpLih+QxIkTj0/v+npH2G1E8YcgvXADoyFrr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5890
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEwNyBTYWx0ZWRfX0qWrW0LqUI9x
 MgUTLcQzuQ0a1J2taGSlBCURNc1bp6GK/3APCLzhXuDU0lHXZYYC6GkfTW1coDzlDD8yBVxxzix
 J29uNUbsTZ8R8FsJwoSirAaCIld3te4V+hA0nCuXnwnMYbDelcPGV3OouOQUbQVfvaoIA8jIBN4
 ZMyhd749xytueJdPp4XLYgVQloiYcifFnqFO3ippAtadHgLhWpveddBdHJsdlXoRncG8CGPiSX5
 1MsZqY1rZnx7J/Ex8LaokE+P4gC3WZUvuzOA1xrOamyssOjztpfXBH+eNATY3NMSujWkBTre+4P
 2EFV4CWiGl3CdlEvJ3uZK0Zvq8hS+Z/IY+Px1nljqfpdEkRBtlyqpvYochB5+21J8ITnpgvVwXh
 LY5nb08CA5wy5RAzX23IXQpM8RvkoQ==
X-Authority-Analysis: v=2.4 cv=fqLRpV4f c=1 sm=1 tr=0 ts=69244af1 cx=c_pps
 a=skQXzUdJ1yZbsxdDph07EQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=zOGyKT0YU55U2yUfuloA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: J924AUHBykckMpwyTMjVZ0TiyrK9AhDp
X-Proofpoint-ORIG-GUID: J924AUHBykckMpwyTMjVZ0TiyrK9AhDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240107

>On 11/21/25 3:59 AM, Antoniu Miclaus wrote:=0A=
>> This series adds clock provider functionality to the ADF4377 frequency=
=0A=
>> synthesizer driver to address user requests for controlling output=0A=
>> frequencies from userspace.=0A=
>> =0A=
>> While implemented as an IIO driver, the ADF4377 is commonly used as a=0A=
>> clock source. This patch series enables it to function as either:=0A=
>> - A traditional IIO device (when #clock-cells is not specified)=0A=
>> - A clock provider (when #clock-cells is present in device tree)=0A=
>> =0A=
>> The implementation provides standard clock framework integration with=0A=
>> rate control, enable/disable support, and maintains backward=0A=
>> compatibility with existing IIO configurations.=0A=
>> =0A=
>> Antoniu Miclaus (2):=0A=
>>=A0=A0 dt-bindings: iio: frequency: adf4377: add clk provider=0A=
>>=A0=A0 iio: frequency: adf4377: add clk provider support=0A=
>> =0A=
>>=A0 .../bindings/iio/frequency/adi,adf4377.yaml=A0=A0 |=A0=A0 8 ++=0A=
>>=A0 drivers/iio/frequency/adf4377.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 | 119 +++++++++++++++++-=0A=
>>=A0 2 files changed, 125 insertions(+), 2 deletions(-)=0A=
>> =0A=
>=0A=
>When doing a RESEND, please add a note that says why.=0A=
>=0A=
>Also, you still didn't include the clock mailing list or maintainers,=0A=
>so I don't expect this to progress since the last time.=0A=
=0A=
I forgot to mention in the resend patch, but i missed some of the changes =
=0A=
when i sent the first v2 series.=0A=
Should i send a v3 with the mentions + clock mailing list?=0A=
Or do another RESEND PATCH for v2?=0A=
=0A=
=0A=
=0A=
=0A=
=0A=

