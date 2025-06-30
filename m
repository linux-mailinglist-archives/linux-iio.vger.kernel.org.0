Return-Path: <linux-iio+bounces-21151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BFAEDA25
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 12:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D793A590A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38726248F4F;
	Mon, 30 Jun 2025 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="rWpVEAyV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E6F9D6;
	Mon, 30 Jun 2025 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280163; cv=fail; b=FVjdMfacz5LH6P6h9YKz+tTaT+qsOx6pe1D+t5kq04BVyTKNfkClI5ZhzHq89EI3JdzmjTxXwQrxXuKzjdjG33PjbmB1Y7fhM547k+GZbMYu2gJN9cGtJ0LOYFWrDboFEOsx5qbpiJ8w/X8R80UvMnM1NlXjHBHfeKUMzl1c7KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280163; c=relaxed/simple;
	bh=aT4h2RUnejRKj2UhK5cgLEdgbzfsm3YHDHUCBzvExvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e9+aE1aS6fGgdLR2PKb8GXiyCxDDKWA3Kb9EDTvaPvO3dzuqbcVgJV9mWK0UPv0egTu2U0ATleVoXKM0QrGYvL1YLPpMPDapSdDK4L+cq9E3ETlrXdBEQv3/WTfXZwLkBccVA11lSwVr9z6N92QdOdnDGludwG/uXwIX6xjrQG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=rWpVEAyV; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNJGMp019744;
	Mon, 30 Jun 2025 10:42:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47j9rn96c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:42:21 +0000 (GMT)
Received: from m0233779.ppops.net (m0233779.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55UAgLoQ025584;
	Mon, 30 Jun 2025 10:42:21 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010054.outbound.protection.outlook.com [52.101.169.54])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47j9rn96c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:42:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIhE6xCtMDnN53a5kHJd9gx2bRZjD5YFg+3AynHcbqV2xagTEiIhA01pUZshRrALxpWKtt9idSxiFOPzTHLtE8cutx6a/9R5W2jcEWCwmwWqvfIf1tnhctL0AmvZslP48tNXQ7FE/negtXMMG5g843IW/Wr3ZWVKfcDnjQUlEq9woYkP29wgqehaUJK1t2+4FR8AYNXA0yFHMIGw83ELo3D1MgdrEFtLTSyok6vnePj2Kw4VDFF7n/NE1RS/rHIAv35PoryERKwBtL7XmCNAz19LC9ZgIyN75XK7Q9QpDXma40LZuQpbGYlJdkJzyumAgHyV/zhVQMVQwpNETHzFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wReSwJKJi4gjOrBYk5z0TXatTiTrs1bHdSBie5Fm7Jo=;
 b=K+aUka9msRIOZL2jqP4hMKYRzW2/FxarC9TKtLDUu4fE/VQyaqgV4F1pW88AqMvsNQugZ6M7p9MzzBquiBqvpBeuF/xJlBqe7zEQZ7H84I1UXOvfhKhCRUj/NZHzBk1J4E9/xpOQyAdhpU1VdM9YyMPRIPrC9MAGPrVHrtCA72PoSS38m/PAcIOzN12elvTCux+XAl2dE2WuJrJhkiRxObB8XqLtPjZODbVN6zFfYqrxqEWp+17dEuXVQAkb+nCmUwDL4yXpkeKe4TTm/Jqw0TDn5y9eZFL6XJII50P9Re8qlRiY29yq1YPVCbKltE53Sje810+h4e1Zj1RUmDvvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wReSwJKJi4gjOrBYk5z0TXatTiTrs1bHdSBie5Fm7Jo=;
 b=rWpVEAyVsbiKw29fq0uJJxIrKahwNEa/SqXoB1T0wWNE98X6UpXPnQTmaIDnjJdkQqxakOP7He+E5b1Zs7zscQ7JSSBuRIwbjPmJKDFyr4KWa5aTFSDWBXBDViNt20FkoC5w9XYxRVs09OZTkFWVpjRjDpPSyLDxK4hEWSiqF/H5fuMxAZcEkxqGuKpvER5ZadG+0yJla+gquqINxXuUafChpAlDGvPNx6OhQcRGUbs52QhID8eyyG7OMWYdCxyE6EcyRs6r8uGP7/utqge7HVupT/nSogo/EC0EkuktxRjk01UYwmnMF876E4KCzVEY9XxqlKgmgQ8mkCk7DQ0Nbg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR4P281MB4532.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 10:42:17 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%7]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 10:42:16 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Rodrigo Gobbi
	<rodrigo.gobbi.7@gmail.com>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
        "nuno.sa@analog.com"
	<nuno.sa@analog.com>,
        "andy@kernel.org" <andy@kernel.org>,
        "~lkcamp/patches@lists.sr.ht" <~lkcamp/patches@lists.sr.ht>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: pressure: invensense,icp101xx: add
 binding
Thread-Topic: [PATCH] dt-bindings: iio: pressure: invensense,icp101xx: add
 binding
Thread-Index: AQHb5uE4D3SFnAQ24Eq9ki9jXqtoi7QYspQAgALVOjs=
Date: Mon, 30 Jun 2025 10:42:16 +0000
Message-ID:
 <FR3P281MB17578076FC5E91F1AE78E3FDCE46A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250626212742.7986-1-rodrigo.gobbi.7@gmail.com>
 <20250628162024.5316e66e@jic23-huawei>
In-Reply-To: <20250628162024.5316e66e@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR4P281MB4532:EE_
x-ms-office365-filtering-correlation-id: 35cff3c1-bb0b-4a2c-2ecb-08ddb7c2c82b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Unq/DySh/Yw7jTjRyMpQ9KIT6qroFIb/2CH8yk8PF7ydCIwLMBYNtE0iIs?=
 =?iso-8859-1?Q?y+5YNJ8J9xJwYRoI6eFwW7F0bbcROLhzq52v4ZHrrtHr7u+pZQxJZ+nU5a?=
 =?iso-8859-1?Q?FpwXx+df6MxO4hGVlF6KaTd3gFQKBeMYUtYJ2jjG9zDbmT6EjKDC+ewrOi?=
 =?iso-8859-1?Q?PkxqFhCw5G0+z6g2qK8puDwHPwBr/1FYrh32WpjB2knPgyYRdOoQGg8m4D?=
 =?iso-8859-1?Q?Fsye27inqQWLDS8UB09U0ud86tHHRWv2jp1W0RQt4a95pXF5M96BlZary1?=
 =?iso-8859-1?Q?H6dRPMO/4jrYXlb8KzsebaQhX45tpJv+f4MJlbgBUbujvJlino7+mu1X1u?=
 =?iso-8859-1?Q?BgmB4MFn/5ibvLT9vO6nEDXbtYrAZcPU6WiMCEkz5WpbIOLz8TLgAVkcF1?=
 =?iso-8859-1?Q?rIV7WpyhaWaSkFXHbL4TQBk0wsCw2f6lnahU/tbadEIt7UHjZcA873ejPU?=
 =?iso-8859-1?Q?G5Vh0sJrOUaCiEGjJ0TDpFsvJiBFeVkOlZGFOB84CKv4wIunAgqurlFy6t?=
 =?iso-8859-1?Q?cZRg4iCiVJ0jXoyJyXQo/d1CMkX0fW6O3QQ0ZDTozrGAVcaMk343+eWDwl?=
 =?iso-8859-1?Q?u+n3NXr9P2c/vTClRMOvoMe9IPuouc1lR+PnWgVpyFq9bysSsIyzQCps/8?=
 =?iso-8859-1?Q?99D298inFUvl93u6c992uVfdkdYohvLcHlL+JwT+eGrbmYw1j2Ii/EmQVP?=
 =?iso-8859-1?Q?7I0vRClqQ7OC3YrYhCGKtiSgjVXhWdnkudPtgYNb+FBRYsg48vkUW81iwh?=
 =?iso-8859-1?Q?cDhKWz7jwQX3Fs1rkfGvofPJanBHdS0e4/3K3BA1H54G0j6CaSWVcMXzCY?=
 =?iso-8859-1?Q?TGvgvg8sW2enuzsnEEGYhjuqIzZvr6twIAl3QVMGwMCl8V2SJshz6UDnF0?=
 =?iso-8859-1?Q?8K7eAwG8kDugkfnkBwypXLmHka59XA6lFpTPSINyv1QyIOgCr+gui1yeWE?=
 =?iso-8859-1?Q?EqQTFndGRe+bS/kuNkaMnQNie/ZyRed5ZkGvLF6b9w26m0XhecbH5IDyIv?=
 =?iso-8859-1?Q?pkyG8Rdl+O/OrmKaS/hQUi1Rzbb4BSuG2a7GmYJNyqp3BwRoTMQTmkTq5a?=
 =?iso-8859-1?Q?90kO7hwamADTInr6zmg6OysLtjdbs6cP9ejH7mnYsHALKVD6wyQmQw/6KF?=
 =?iso-8859-1?Q?/RrZTM3kH6xDIpSZH6XHGTNptyTNG2vEs6wkiIo55kOS9u2jFxvR20qNiy?=
 =?iso-8859-1?Q?5xouP/CBaGyP8PaSCOUuV2cwgXgdFkD6P9tpa99lEKtRUc5HLV6hjmdRoX?=
 =?iso-8859-1?Q?Vrs/zdllny1RIQbFFBVKNOr2skmWDY8JNoCTu53UmrMmPBial0+vGe96me?=
 =?iso-8859-1?Q?xKywjQCy85dpZ3tgRi3/o5T7L1o5PJESW2k533p0q/c+1vQjK97iUC6h0w?=
 =?iso-8859-1?Q?WspolIQC5FQRsb6lA19eWUmz/1UFzeSxaUTaPKiYEKk/wYRBIoHf/pDhaQ?=
 =?iso-8859-1?Q?wf5rMmzpNHivNn9mbnAEu6zNxIeerzt1ThLhRMbACeOuvq204TT9O1RGOY?=
 =?iso-8859-1?Q?w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jKD81/H53qtwWGUnehTvvAfn0f5gFWlFh87iJRrQWm+/kLVsZaubVMQm+t?=
 =?iso-8859-1?Q?FlsGtUsjdmmAWQ66ceyordg5j+TCHu+yn0GkUpTdp7zHWVhELvV5lpE7VF?=
 =?iso-8859-1?Q?vUHYv815qwqUrn8IOhcix/gJV5K4/iZ/n4xJ4CAQhkpIOgrLWYz5dgHWjh?=
 =?iso-8859-1?Q?ZJc7M1je23Jg9tFrxgWtD6g4ZFCRlnTiKYyftM2BbzPC7S8Lq/083e3hsK?=
 =?iso-8859-1?Q?AvYTCEaJg/S/uHvU689zbcwXhKv+vDwqsHlmZQPhOwT6tpuv9rxew8+JUM?=
 =?iso-8859-1?Q?gdxAUgIvqcskLJLzY6xWmPZT8uoyXCa7mqLr+Bp2JwkXZSFmyNcHguzQq5?=
 =?iso-8859-1?Q?mzR1EbZpoF2uToRjngFo8yiADSwQqnqt72AGsFYymnqRrjnSlGNa7iKaRZ?=
 =?iso-8859-1?Q?v5n8cmKGgq/p8E4O6ZWhbEHZP0GmZvoZmR5+vGkNziesAsRRamo6tSYMXL?=
 =?iso-8859-1?Q?1ZTRVjrSszr5UrTKg2hY/ViF6YYI+3yKb+vdcZl0QF6aKZcl17RGIu03JS?=
 =?iso-8859-1?Q?11+/rOOnsHFw7c1kiPdsq9xmJo2KgfW5YeQcxfU7S6s7YKCNehFjvIDrz2?=
 =?iso-8859-1?Q?G997oywY3FQ15XXUpYR/nqiwMH4uz6RD9GCnMVcmwpcz2+CO+DrmhokumJ?=
 =?iso-8859-1?Q?ybHTC4+F0l9TGOCyLNsqelHa/7MAxYwq9HiDHWOvtM+F+eEgbo4ZKIcIp5?=
 =?iso-8859-1?Q?jFt6kWNvWlcJRSCSQyx7uF6q0CC2UIgjrDuYzwPuYsAj48AHwKFSQJOrCA?=
 =?iso-8859-1?Q?dVKa/xHY1ROVeVJoW4jcEtyo5+vARfnkiy/AcieqcXMvV/LSWzQARs0POS?=
 =?iso-8859-1?Q?1waTR6VsgYvC4dyAo0CpFzwCh7xBT8BmHpRAXkyXi06TeVh8Ddnmy8sJDm?=
 =?iso-8859-1?Q?NbjGMCKyf/kB2FXRI42JSq99GajFpp0dKzga3baXJuDOopVFuH9FpHfysv?=
 =?iso-8859-1?Q?2mhOz6KmDRwTT6EDEsMugJVb49K/GxAn4144Oiy1hGc+I9PrKFB1Zi8fsv?=
 =?iso-8859-1?Q?kHUluTAOJlPW/TH6rd/hx9RIerA85AtL80g3EscwZ/3KShTC6hZIG4b/hX?=
 =?iso-8859-1?Q?37OIvgCtExOjH29ObShs0NynTlS0fgJmEPxgejA9VjBe63i2zZAwVQBCZF?=
 =?iso-8859-1?Q?0L1VayhoNtOShNbScfYKOKvHS930kNVBagc3KRYA1cw8PQknUDHUcNW1h0?=
 =?iso-8859-1?Q?9WnrdAu89/+DQS5LLkpD2j6a0Qku43vafXLgjYMTdg+EjYKpZkDMbTSrVZ?=
 =?iso-8859-1?Q?G8GSJefTxEHdYfy1BxZ/CMOZVdM7HhXUj8UVpoxfUsIGZsrYGrnB4hpSvO?=
 =?iso-8859-1?Q?ExXbCpm02U0QgCIucgiVyYu8GAksiBv1mtv2M8jlIzlgKdTowXlR0Fh4Ee?=
 =?iso-8859-1?Q?w2xeuubRlAQz/glOj628r7tiU/pBTqov8JjALf/tsuPIndUuPLyRaaPjxm?=
 =?iso-8859-1?Q?zoMJmuoNTbDtdFaPnFPXGHojD/oZr5wHZ0kLKnRJZU54/mpxIlwQCV0+zq?=
 =?iso-8859-1?Q?R+Q8oS6T9lHowD95mflY3so5Y48XLeR8rM/9pW7OujquS4JIAqABFowNz7?=
 =?iso-8859-1?Q?5yiQr6nLbGsc1iSYI5Jucy++Dlb3pUdpdUZ8r6vqxeCCpgJ1VHNkKTYufc?=
 =?iso-8859-1?Q?UkWYLjkM9z73bK7I1TsEsAbzbpZi0FdhzdrNWJURL0s1Omd/3qGopePg?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cff3c1-bb0b-4a2c-2ecb-08ddb7c2c82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 10:42:16.5739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZurNFY7evY1j2xSNUpXuQiBR3C3QgSj+90scRJIUCnOmG16vfKSo5iwDpew0nuZZANGlxFewnCbLWss3jkoXtBmoErRC1+sMsoMNCEejOSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4532
X-Proofpoint-ORIG-GUID: Vj9DNGaChopoI8GtRt_PQ2I8Tlsm7as8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA4OCBTYWx0ZWRfX6S6TQkePy2a8
 /0mPYKbnO68eRC5t9j04fmvyIyau1Gjs+zSimuod2jJfoElUAHSLPRJw5ua21OZaXhqEbIHkH0n
 rW/w5pnhqcpI2eYZ/ZFOvVOS3ktF9JmgNknaN/G+TEw7tB0VLtxmRl/Aa51rW2mftUSmm5voK+4
 711kcrWHN/gmphiz5PGAdgm0kdozhZBIWGk1q3RbC9ldoZ2lPAavBRYVKBrZGGL6eyc44olaQ3j
 lvavlyv0MM8AmF91k3cF1q2ReGQRFPl9QVDzR82lRKT/FSNkU5oEgqMJzi+P6EAlH6ZegH2mTe+
 vbqtokcAc3olDF0TbrY0LE4APNzn6Qps3U7q7U6miv5o97hKxYF81XeSNhEzaMQPv1XofSltVel
 g13jMHTF9jzJVxGTLK8twzrrE2xj/aYlmtGfffBBItf4njD7eeXBBGOPsTx7kWWMGLY3fvlR
X-Authority-Analysis: v=2.4 cv=RbiQC0tv c=1 sm=1 tr=0 ts=68626a0d cx=c_pps
 a=xZMuTpj+tAAZA5Bl67MBew==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=gEfo2CItAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=NGdr6CL8AAAA:8 a=ly-VakCaskn9YPksLQIA:9
 a=wPNLvfGTeEIA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=FdaAwssBmeZ4pLUej-U4:22
X-Proofpoint-GUID: KyIoOXgmbMryCnSuGK0pMSO-WwKGjY-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300088

>=0A=
>________________________________________=0A=
>From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
>Sent:=A0Saturday, June 28, 2025 17:20=0A=
>To:=A0Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>=0A=
>Cc:=A0dlechner@baylibre.com <dlechner@baylibre.com>; nuno.sa@analog.com <n=
uno.sa@analog.com>; andy@kernel.org <andy@kernel.org>; Jean-Baptiste Maneyr=
ol <Jean-Baptiste.Maneyrol@tdk.com>; ~lkcamp/patches@lists.sr.ht <~lkcamp/p=
atches@lists.sr.ht>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>;=
 linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Jean-Baptiste=
 Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
>Subject:=A0Re: [PATCH] dt-bindings: iio: pressure: invensense,icp101xx: ad=
d binding=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Thu, 26 Jun 2025 18:12:25 -0300=0A=
>Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:=0A=
>=0A=
>> There is no txt file for it, add yaml for invensense,icp101xx family=0A=
>> which is already used in the driver.=0A=
>=0A=
>Don't mention binding in patch title. The dt-bindings prefix makes that ob=
vious.=0A=
>=0A=
>> =0A=
>> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>=0A=
>> ---=0A=
>> Very simple yaml for a i2c device with psu. The pin out for the rest of=
=0A=
>> the family (the other PNs) doesn`t change anything here, since the diff=
=0A=
>> were RESV pins (unused).=0A=
>> =0A=
>> This yaml file falls in the same `category` as others that I`ve submitte=
d, the=0A=
>> driver author, which might be still interested at this hardware, is no l=
ong contributing=0A=
>> (at least for what I`ve looked). Also, it`s email is still "at invensens=
e", not "at tdk", either=0A=
>> way I`ll ping him here due the mention at the "maintainers" field:=0A=
>=0A=
>Try a search for their name in recent mails to the list.  +CC Jean-Baptist=
e at new TDK address.=0A=
>People don't always remember to send a mailmap update when their company e=
mail=0A=
>changes, particularly if it is due to an acquisition.=0A=
>=0A=
>Jean-Baptiste has been active in the last week so not hard to find!=0A=
>=0A=
>> =0A=
>> Dear @Jean-Baptiste Maneyrol, I`ve noticed that since the driver was add=
ed,=0A=
>> there was no binding doc for it and this is what this patch is addressin=
g.=0A=
>> In this case, a maintainer ref is required inside the .yaml file and I w=
ould=0A=
>> like to ask if I can add you in this case.=0A=
>> I would appreciate your comment or suggestion over this topic.=0A=
=0A=
Hello Rodrigo and Jonathan,=0A=
=0A=
no problem for me to be mentioned as the maintainer of the driver. You just=
=0A=
need to update the email address to @tdk.com domain.=0A=
=0A=
There are some fixes to do already mentioned, but after that it is OK. Here=
 is=0A=
my tag.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
>> =0A=
>> Tks all and regards.=0A=
>> ---=0A=
>>  .../iio/pressure/invensense,icp101xx.yaml     | 45 +++++++++++++++++++=
=0A=
>>  1 file changed, 45 insertions(+)=0A=
>>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/inven=
sense,icp101xx.yaml=0A=
>> =0A=
>> diff --git a/Documentation/devicetree/bindings/iio/pressure/invensense,i=
cp101xx.yaml b/Documentation/devicetree/bindings/iio/pressure/invensense,ic=
p101xx.yaml=0A=
>> new file mode 100644=0A=
>> index 000000000000..439f8aaafbd2=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/devicetree/bindings/iio/pressure/invensense,icp101xx=
.yaml=0A=
>> @@ -0,0 +1,45 @@=0A=
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
>> +%YAML 1.2=0A=
>> +---=0A=
>> +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/iio/pres=
sure/invensense,icp101xx.yaml*__;Iw!!FtrhtPsWDhZ6tw!CIWSeuXxYychGWeOLDrarNL=
-Mq6ijPY4NMQPXCqHfpuylsLnNydInuuT_Ghx9UM5ctT9icN-kmVRn-okGdyO6ng$[devicetre=
e[.]org]=0A=
>=0A=
>No wild cards in file names please.  Just pick a device to name the bindin=
g=0A=
>after.  Wild cards have an annoying habit of getting messed up by companie=
s=0A=
>releasing completely non compatible parts in the middle of what we thought=
=0A=
>was a reserved number range.=0A=
>=0A=
>> +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas=
/core.yaml*__;Iw!!FtrhtPsWDhZ6tw!CIWSeuXxYychGWeOLDrarNL-Mq6ijPY4NMQPXCqHfp=
uylsLnNydInuuT_Ghx9UM5ctT9icN-kmVRn-okFzKV_so$[devicetree[.]org]=0A=
>> +=0A=
>> +title: InvenSense ICP-101xx Barometric Pressure Sensors=0A=
>> +=0A=
>> +maintainers:=0A=
>> +  - Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
>=0A=
>I'd assume switch to the TDK address +CC but I'll need an Ack or RB from J=
ean-Baptiste.=0A=
>=0A=
>> +=0A=
>> +description: |=0A=
>> +  Support for ICP-101xx family: ICP-10100, ICP-10101, ICP-10110, ICP-10=
111.=0A=
>> +  Those devices uses a simple I2C communication bus, measuring the pres=
sure=0A=
>> +  in a ultra-low noise at the lowest power.=0A=
>> +  Datasheet: https://product.tdk.com/system/files/dam/doc/product/senso=
r/pressure/capacitive-pressure/data_sheet/ds-000186-icp-101xx.pdf =0A=
>> +=0A=
>> +properties:=0A=
>> +  compatible:=0A=
>> +    const: invensense,icp10100=0A=
>> +=0A=
>> +  reg:=0A=
>> +    maxItems: 1=0A=
>> +=0A=
>> +  vdd-supply: true=0A=
>> +=0A=
>> +required:=0A=
>> +  - compatible=0A=
>> +  - reg=0A=
>> +  - vdd-supply=0A=
>> +=0A=
>> +additionalProperties: false=0A=
>> +=0A=
>> +examples:=0A=
>> +  - |=0A=
>> +    i2c {=0A=
>> +        #address-cells =3D <1>;=0A=
>> +        #size-cells =3D <0>;=0A=
>> +        pressure@63 {=0A=
>> +            compatible =3D "invensense,icp10100";=0A=
>> +            reg =3D <0x63>;=0A=
>> +            vdd-supply =3D <&vdd_1v8>;=0A=
>> +        };=0A=
>> +    };=0A=
>> +...=0A=
>=0A=
>=

