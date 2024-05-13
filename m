Return-Path: <linux-iio+bounces-5004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6668C3EBD
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 12:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B3C1F21A4B
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24861149E10;
	Mon, 13 May 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="CN5xrsc4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1631487EC
	for <linux-iio@vger.kernel.org>; Mon, 13 May 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595613; cv=fail; b=IAikmDYpZGI76H09HM6wN/2A2YDWYIEw3NVa7sQacx1Xnr4wHQHQvjlMD/hcOr5nE3x08u4SiJGwE1lHWow3iee4Ntk7/zSxrpPcF4j7L8hX00vy0oHEHePBgobin9YblGsHTvqoqPfYGEueVkb031nW82s/sAS7N7PcIy9VC5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595613; c=relaxed/simple;
	bh=nAVjm26dKreBvRNv0w2LD19wmpu0pDTgzwaWUu5ZFns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PjGw9Afbk+46NXTIOvPupBSgiBEu+SsJ5mzV8GKOHzW9PlbucLR+mGiX5WwrhYTvKo++N/S5BhlbnfQE25/CF9lDbIgne+hJvSHMqDXsaVVJvn88ndlxkjCa9OdMthpTnpZupgRAYUfBPgVAJdhdpQSdSKFXrc/n+Fn3yIfN2sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=CN5xrsc4; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D3fJ6Q017678;
	Mon, 13 May 2024 09:18:40 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3y3b66raya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 09:18:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPU3ym197e2CrD8IFHnPdM+qHzoN8kRsf8PC8UamUE4SB3UlgfDWlAP5m3wuWYxGIXdLMfeEMnzhHZI+vfoV4lnipxoXtIfwmXXH6/AwB0/43cSNbCJetYjmLdyEOAPUZaytxa1fIrLrzzqM2JBYXpxhHmFXvtRMpnFwVQ/VPjslYPeJIgk0gXPzQ9WNs+w6yjQSfq2yMTuw3m5ctJCHeEt154iDVEoLd+qrKhivH3RwNMWUJHG/rnRDklvIip7aEZZPjNVNZ+kT4/U6810PjK3dZJ+zbRsDFsCL1FNxuLaK2xuO2KBKEHnbMihfktrFbHa6DQwr9sKxVqdqO/XfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8STK5tWvRqOsBMibzdiGwQJDAQukunXbOz5toPszL98=;
 b=ZsF1bndgAgO8X643kB0pAv3TK2BEk3XUEH5AEeyCsaspUIg4OhPfgqJGKEdsoVDUkuRMx1LJlGpFC8uzYbezwY2SnWjg+qBcuNHU6UnoATNKbSFc/6JL4hOcd0EfIafAvq5BTUSfVqVrJg7t/3Uge86g2um0CtSBBt5Kzib1gCXZGI0SjDzht/hTCOecPMNtZGEePir0XmIWeJJEoHZSy/kME9d7rhtMZdKCk4FRKNu0CqTabxNjurIyzBPtk94H5Hf4QGkjjdNsyevXtfZtuEV4+AdCl0eCKtOGPfQHJz8FKWQ+ipHN/hQhVZQkK9APhwVL2gCxS76WMmTJnI67Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8STK5tWvRqOsBMibzdiGwQJDAQukunXbOz5toPszL98=;
 b=CN5xrsc4+2nnopKAkG/YITYGGjLN0bLEYcF/nFFDa88fJ1/sBUXsSyzNKOZUwvGpuPu8uktNXG8W/0E2Jznw/TEYJ/JA00mztW8hAX2keGf55dOkWv4gpTSko36p+U0/dQvHaq9jdW4TMxqy5+31efx+BX3HQqEVXUw1h8h7CR8yJI5J5m7/V+hDUKzhiVDvCZV+mgNCrU1D1jWqypCeFf8aHU62Z0hFv2B37AARdT8J4KZCoMOmzcbh+fAPtJlcpmA1rO2E3QziE91KqZRX0W+SJXwE/G3IXWh6QK9KEVlM3g4oUZKfNi2tXYyY5ohGCa9dJwipDgQPdJpUMjk24Q==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB2878.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22; Mon, 13 May
 2024 09:18:34 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7587.021; Mon, 13 May 2024
 09:18:34 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        INV Git Commit
	<INV.git-commit@tdk.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de"
	<lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: add support of accel low-power
 mode
Thread-Topic: [PATCH] iio: imu: inv_icm42600: add support of accel low-power
 mode
Thread-Index: AQHaoGmx3kJNOgoKOESrYpcRCRIEpLGO5IcAgAXe//k=
Date: Mon, 13 May 2024 09:18:34 +0000
Message-ID: 
 <FR3P281MB175734C16B7C8F430874A866CEE22@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240507103056.291643-1-inv.git-commit@tdk.com>
 <20240509141326.00000684@Huawei.com>
In-Reply-To: <20240509141326.00000684@Huawei.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR0P281MB2878:EE_
x-ms-office365-filtering-correlation-id: 7b489a66-9465-4cbf-17da-08dc732da9f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|38070700009|3613699003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?zpH/BW8ABppTBw6QWd2olNbQI/ypaPB9pjRXLZFHAb+o9uUqedvSAJdmyM?=
 =?iso-8859-1?Q?/xXtuQ0RFSLf/0ummjD3NItrZutcut5e5m/lVeQsH5fk9TfGsdH01+tbSD?=
 =?iso-8859-1?Q?1IX/n83q/CxHTfUgYa87VliPbwcRMnj34M8x+O8UQ86eyARg1dTTmiY8x9?=
 =?iso-8859-1?Q?7y+w2i4/zWVzQJI+txcNmY5iCBFSXfDPC29U3s1dV9/OCwwae3Lc/2XW4E?=
 =?iso-8859-1?Q?KF/sVIrk8SW5k3+H8zKUJrg9TVQaCVzfSWqvBI6xcJy3AMbJc1nll374L/?=
 =?iso-8859-1?Q?6bbgwVNbjEyfNJaCymON93osAgxZNPUhouL9nSrlXpKlqo/lGCXwTCF70a?=
 =?iso-8859-1?Q?2WckaZdsn5MNxJli+UDWT+fQuOr/xGzLaIKakesf/KIt8XrZFKoHIPXCx/?=
 =?iso-8859-1?Q?t6H+h/rqosRzfLIsYc1puwZbUvN+Po3yYmzhewatKDoYCu66Zi0PRQ6kGg?=
 =?iso-8859-1?Q?YIBqcB20EBAkrnPlsN8PmSUrbr8b8cXDjUANZ4R+uV0MKM3CeVyqw+x3f4?=
 =?iso-8859-1?Q?xvHLBTppgROhc3KmTwaJx1LQKdYQdfkcntPuDUOPPNYWJcvIgLYi9I4JQ5?=
 =?iso-8859-1?Q?LoC3WczxBIqmZvbFaNcetOmL/cL9t4m3qLfCWcbSZ7DRbih14Y5F4fVZvN?=
 =?iso-8859-1?Q?t1F5aC7ZA26PoNEIOtLDqlZ5UrL0WJvvKccEiVch4wzdTxu/MqrLjp3yP5?=
 =?iso-8859-1?Q?9nWjx57vBFILzdkUhgUoFksBhGZTUh44AHsF/qewwmi14IxoRfF+FuUr5q?=
 =?iso-8859-1?Q?ImUazI4scHpMevYPJUgcUfVcW5Jp5CCNzP3CA7RziRDMlrIVIn2QGmwTEY?=
 =?iso-8859-1?Q?di0ERgUz/Ne2vtO6XMz79rsJjLORaCSUYwRaVRbMHsX1IeTHOo/VfuqkyG?=
 =?iso-8859-1?Q?uoaUckzAsHIAcLfBbZYhD9lTiLz+j0fw9+mcuBYbx5I8d5pYcoheKLyINh?=
 =?iso-8859-1?Q?AUuNdrFJp9SQBQzKVtZccFxLAz/1BK3MClrUB8KRtp0Fa1lSwncaUmhsAb?=
 =?iso-8859-1?Q?tROKA5GaOt+3mX8LzL/JXwcf/TL1owygKsaCb/ab1jaGg6xVse5TJei0yy?=
 =?iso-8859-1?Q?9ocPj+i1EKlE3oWku1HaqXLs3trlvZvXmKF0nC4HQzItixe7T/G5H4N8h1?=
 =?iso-8859-1?Q?lN1LTekczGo+SgPRwE3aM002L7iWCR86vlri9+i7OkvbA4MJCtVF4afNzC?=
 =?iso-8859-1?Q?xkhmF+KyR08orDPmaj0XtNR2yzSuq9fU6kXovWRN4/dXbIDqIaUMvfXhJG?=
 =?iso-8859-1?Q?f047N2rpOsN2UUKzEel64atQloItt/M2pnW8onXTv6COrmirkkpFOYxRAK?=
 =?iso-8859-1?Q?uPy1pYDqk9ose6hsR3ikVTEo9YiQ+rZx2PGZ83T7xt/YGU5QiIKyg/otN5?=
 =?iso-8859-1?Q?qVkdWG/2RPCm822MD9hR5WH6yZ5zDgXBhotmMP9uVZGNoXbNfeOmQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(3613699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?25XKvWstveoa1d67k2fH8h2Q5G7oFkFiL4OW9RL1iOygypifEa/XM0XhkF?=
 =?iso-8859-1?Q?0gdTyZhUsA3+PRIvGDSitX5/r9VXJg7fJUZSxeUBE83Bd3qksHOuZOHNob?=
 =?iso-8859-1?Q?6fItm+YxAUZAZOps1II8F4mQIJis/GKHHAm6h1gQ7x56XggjJDyAIaHSMw?=
 =?iso-8859-1?Q?VjF5idRM8a2kW9JefwY1zZMWzWVV5qwvbiqjLRp7wcCwqtVNblQtIzFOqN?=
 =?iso-8859-1?Q?bH89xq10QgO9sEEA6P65tOXksXmjJ5vNnzNxuBrXIvY3Uv9AEBhX/PNOqF?=
 =?iso-8859-1?Q?hoDApJhiRtMiXKoWgROa9IYcmfgVg/wu65xBB8JNlKQVZWOPoHcdScy8zc?=
 =?iso-8859-1?Q?ftl5de5G69RvTa4ZbghQXuSHnzZ7gchB6yqhgJQrKJA0LQ0YZ/mUkRNy+O?=
 =?iso-8859-1?Q?zKa2c03JBK6fmwb+qFEW64VBTymCS2cnouQEPqaYctTwRG0ERp7i/bRUWc?=
 =?iso-8859-1?Q?a1JZa1IbNz1WplEqrJSMajzFnlRB4AZ5ndU0GvRVzg3JnSBozgFaT1WKPl?=
 =?iso-8859-1?Q?zxepYL0BmcAzyOP/lbsxlPy6r+jwpss0evJEYHyb5DZborhxrhnUFWU8Zu?=
 =?iso-8859-1?Q?yRKhmONaY63/WZOVBbQ89PAcVsVyAF7lwaKOWSvIYlIpDCJ3lwf/KxShp9?=
 =?iso-8859-1?Q?ZLTvMuVJFX0lKc4cn92lyS/XWaFIfK6XbTtQRpl48FkCokSRtBU+ZtQka7?=
 =?iso-8859-1?Q?Et75ptOfkZgZc0IQKBV7CjsDhnbd7YwrkYsP77UjGkbjJt0Zuhyf8hvqJ/?=
 =?iso-8859-1?Q?APA7QAXlUHNq2pfSQYA9qjZ3Q2Wc18OIcJxShLxQUR3mV1d/+BBMI6a5NZ?=
 =?iso-8859-1?Q?kyIkWi9Hp/Z9fzG84IPSCDHh+JaGi7YqadOCDAMIQmhmhkd1S5IwFMdjdf?=
 =?iso-8859-1?Q?LwEAcU4K3z8FYnEStNanM8dIP2Z6rVjSPcss+UVPu7AOMCl+xh69pQPnlN?=
 =?iso-8859-1?Q?U2v3XFRNS0CjMkC9rX3MaaxmdwDMVgaxImqCVx0PwBnvFqSF7v3pG6eMZ2?=
 =?iso-8859-1?Q?NguHIBdE7lAgFSQRhWXdCI5wvv/BTeiLYkCqTHsb6vb8E61rS51kVPixQ0?=
 =?iso-8859-1?Q?MfZ1UKxe2lcSF3sajOLzo5uEPoZLuFFM9m4cKKVvebIzKsDK0F9yb6RRcC?=
 =?iso-8859-1?Q?hxNCmR+KGbfsYrzo8En7ZJZPxRJg9YDSchLStBvlTve6UHo6HISU8Jfcpz?=
 =?iso-8859-1?Q?e+ieK5XU1KibySe8LFMcA3zWqbl2zGPNXNj790oHLqRMmE4weB7mgzmu4K?=
 =?iso-8859-1?Q?LXRlyQkRdT+6PBJV6ggYXJK9v+C3q7XEYmzkmaeZ+jQQCcFmHNjBD7pVdY?=
 =?iso-8859-1?Q?/du4DyJn5CU0A52EUIK0Ajp1hQKJuy/Qi1SP+gv5ne5KPGZAxgFxfh6Cio?=
 =?iso-8859-1?Q?y2HiE9SpbLsHZ1+4xpn1MkkrV8aw1T7ytTlFvj0gyCvXXnuMkkL0DFoelB?=
 =?iso-8859-1?Q?2+aKFerr+PIBk3sV7eF6i5nhmigElupDmy68qc84UqFzew688lixBhp771?=
 =?iso-8859-1?Q?we0phYLYzTCyYtI68xz+7Z5oGR/aP6iFmm7wnh96La3xd2GZO3qbIXsbJ1?=
 =?iso-8859-1?Q?tIKlEAZahdA1BFUDM7TpJKml9L3PmcCNnJXPoVBmEDnQVeVtlFWKglog9S?=
 =?iso-8859-1?Q?UfOR7DucFBpMjAFoUowwlglS2t+OIIOEGYfWjONL02i9AwX6q4Dq+JIbJD?=
 =?iso-8859-1?Q?eqbt9WHmHsi2zeuSF97Byu9oFAaKtV33QWNOSSOxayuhemxwMjbouVD5Yi?=
 =?iso-8859-1?Q?kR4A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b489a66-9465-4cbf-17da-08dc732da9f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 09:18:34.1197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+t663/xpzFzIY4XS+ciIQs0yr3rjKgK1xQiKZ+U6eEDZLg++E1qnXaDsdhUzG72jNTuTN6sLbYsT98hbeKOBV72EKMMTCnNoDs7a+Y82yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2878
X-Proofpoint-ORIG-GUID: biwSSq6aD1ILV7L3lqz-v_skE89wKlJ8
X-Proofpoint-GUID: biwSSq6aD1ILV7L3lqz-v_skE89wKlJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405130057

Hello Jonathan,=0A=
=0A=
sorry for the patch malformation, I will send a V2 fixed.=0A=
=0A=
Our chips have usually 2 working modes called "low-noise" and "low-power".=
=0A=
=0A=
"Low-noise" is the standard mode where the chip (ADC/MEMS) runs continuousl=
y with high precision oscillator. Measures are the best with the less jitte=
r (low noise), you can use the highest possible frequencies (> 500Hz), but =
power consumption is high, and you cannot use the lowest frequencies (< 12.=
5Hz).=0A=
=0A=
"Low-power" is duty cycling the chip, turning ADC and MEMS on only when mea=
suring and then turns it off. Power consumption is then much lower (low pow=
er), you can use the lowest frequencies (< 12.5Hz), but measures have more =
jitter, and you cannot use the highest frequencies.=0A=
=0A=
Depending on the use case, you may prefer to have the "low-noise" mode with=
 better measures and high frequencies, or the "low-power" mode with less po=
wer consumption and low frequencies. The main point is the frequencies avai=
lability depending on the power mode.=0A=
=0A=
We could have the driver switching automatically from low-noise to low-powe=
r to support all possible frequencies, but we need to arbitrary choose the =
mode for the common frequencies, and the configured hardware bias in bias r=
egisters are not the same depending on the power mode. We prefer handling a=
ll this from userspace, switching the mode when needed depending on the use=
 case and dealing with the 2 sets of hardware bias depending on the modes.=
=0A=
=0A=
I hope I am clear enough with my description.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Sent:=A0Thursday, May 9, 2024 15:13=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc:=A0jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de=
>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jean-Baptiste Man=
eyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Subject:=A0Re: [PATCH] iio: imu: inv_icm42600: add support of accel low-pow=
er mode=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Tue,  7 May 2024 10:30:56 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Add channel attributes "power_mode" and "power_mode_available" for=0A=
> setting accel power mode (low-noise or low-power).=0A=
> =0A=
> Differents ODRs and filter are possible depending on the power mode.=0A=
> Thus make ODRs and filter dynamic and check values when applying.=0A=
Hi Jean-Baptiste=0A=
=0A=
No Sign-off?=0A=
=0A=
We have never provided this sort of control because it's near=0A=
impossible for user space to know what to do with it.=0A=
=0A=
Various attempts happened in the past to provide enough info=0A=
to userspace, but didn't succeed because what low power means=0A=
is incredibly chip dependent.  As a general rule everyone wants=0A=
low power, but at 0 perf cost :)=0A=
=0A=
What are the results of low power mode? Normally it maps as=0A=
something we can enable when some other set of states is set or=0A=
automatically control based on how often the device is being accessed etc.=
=0A=
=0A=
For example, what do we loose by choosing this mode for everything=0A=
below 200Hz?=0A=
=0A=
I see there is some reference to 'low noise' - what does that actually=0A=
mean for this device? Is it oversampling or running lower resolution on=0A=
the ADCs?  If so those are the things to look at as ways to control=0A=
this.  Choose lowest power to meet a given set of requirements.=0A=
=0A=
Jonathan=0A=

