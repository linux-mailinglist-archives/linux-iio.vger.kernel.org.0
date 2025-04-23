Return-Path: <linux-iio+bounces-18555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CBFA981A5
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 09:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2797F3AF211
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EEC26AABD;
	Wed, 23 Apr 2025 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I6bKnoAU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964426A0D0;
	Wed, 23 Apr 2025 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394673; cv=fail; b=CkZnHHI8OSByo/Sn/YSeKuB/jFbBZCnzV5U0PEWMH06SrUqbhiHJsMcdpYAF+vTLyH6ohzRx3h0mCaPyTP90J1Av8qweUyM7pk+hbBvtXJ2xrgCcUTtgvuzDPQYRb2oVmxrOpuH2KNTgMnfynU1LAhc0wwBJQaUKShkCVeQIskI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394673; c=relaxed/simple;
	bh=csg2NhNwf5s33l77vT17habZeZxyl7olTKkkwbcErWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N01qwMI7tnxV3e6kSMqeIYxfd1TMovQ+zbklbHZ7421AVgdj1sDbQxkPwRvfvlv61a0ehG4/Gskh3LEDWHiLjTHLg1UaQB2ntHh5T2XLET8xvqkzq82yskkwPWTIeKBLtRn2qDVC5NjHTdNwV5Qciv37W3zw30+NCwxUshxFnaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I6bKnoAU; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N53rdD029478;
	Wed, 23 Apr 2025 03:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YnTKr
	rXnd8EWzxyU2r9e0ejQWV3ff5Kt7ldqSw5988k=; b=I6bKnoAUxeMNpC5vOnBBp
	Qn4lULTvmQb48lFQi1XzUmoQAaVN73KA+oxF0c43srLJ3LtC6qrwaSB8rMuTPoYL
	So6PG9PgnOvLtsiy8tmavThamkkrpoSyvPGFJXNZj/NevcCPu3oAnNoIiVWy57+P
	8vOJMzS+QQuwo55aon8Mj5N45c3sjieSi8ZThkmdYVFOOuJqHe7+mFCaMwVz5JEr
	d1S6CF8Xys2h+LjlooiUaqN8cVnlNcQqYN8oGJCFcJkMGThyrz2lxdkssEIW9pnB
	OqcPtcNcdXi58HS+oE/0Gcb1o/M7aQAIcR28twkLBdcee9xDaSqLT1b8PZt/Z6mM
	g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012036.outbound.protection.outlook.com [40.93.6.36])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 466jjsjcg6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 03:50:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcJ3FnNekkoUHW9CeDYdUQw+udwEiTkxFzgG9CwYdKbfjh6+23tjNSPUda9PX9s4KIdsolF5iY5WbANPeSRzmo9PURXNopvKeVRgfkUJCKFHWUX0Zulyjb3mRbpN2PeIGbPelg4U7l5K+uOkcMbnA4Qljjhvj03XfYgfUjOVf+Za/ABJ9KJQdspnu4d+rZe/gENriGiaMnp1ckyO2zNywzW54iOmOuQUrA8u0gJzZnUKCuWPbNxSlZlL1h8bMR1UeVi1ZJFcKOiN8uHO9gFsSqlMSkZrSiaG9wYMBF/3gDCVnykmWBmmQyIbNgtwbmYL8L/42UDEPhu1ysDY37gjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnTKrrXnd8EWzxyU2r9e0ejQWV3ff5Kt7ldqSw5988k=;
 b=xTbP7nRxHFSeBCHUhqftN2aYIQu+E4Rdp07IfLR8TP9kY7KNLRCeNOeiiYGP6XYHM5EC9GN2VEMw+rhT391D/lhNeNB8U4q+y0DiAzqu10dJK4y5YDbBvrz9x3ByJIBaFiX/MZWZfM0vcAKmVggEZ/NaWp30c8D294AhM3qwW7h8GUtTHr2rR9vvXHenj4Q7Yc6NPLiPPU9yAWzErJ+v1iP/bvCzBpKVNc3epcQ8PE7kYAKgmSOC99g7Bbb0TTLo1uXQqNpvJdYRLVlvvAo+vz+FPdJ2nz2mnDir4mFElw5ymCl+KLYAsrjn0kF5KEyPj+Bi35qhtOwq7dC/o3MTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by BY1PR03MB7237.namprd03.prod.outlook.com (2603:10b6:a03:523::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 07:50:52 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 07:50:51 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<noname.nuno@gmail.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Topic: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Thread-Index: AQHbsnVyrRgqZmjV0EKE05LwnZhDMLOuIxIAgAKtwoA=
Date: Wed, 23 Apr 2025 07:50:51 +0000
Message-ID:
 <PH0PR03MB7141E6D1A077B0E02368CBDDF9BA2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
	<20250421-togreg-v5-3-94341574240f@analog.com>
 <20250421144800.0db0a84e@jic23-huawei>
In-Reply-To: <20250421144800.0db0a84e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|BY1PR03MB7237:EE_
x-ms-office365-filtering-correlation-id: f11ef979-315f-458d-f740-08dd823b91eb
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?whDDOtqPQtcGKJ5Jcury7X/QdvmZEiE4YQowPCBbN2vi6ANLN0L/Hqbo80?=
 =?iso-8859-1?Q?z5mq4PfeA3WND0gb1ymHKKQh/yfTiaU6Y0vwE5VqxLKbqMVq6i4ej12BBP?=
 =?iso-8859-1?Q?J2pLpx2lvcmlt16/L0mDixRmVYUaswNGkbH/QRWjYhQ6XCVWBWBLKQDIbf?=
 =?iso-8859-1?Q?kfRKTz8ldnhKOjM6+pQuw4SE8ReWJcZqeCeJvcS/cEzBkhAK+9EJoSPbft?=
 =?iso-8859-1?Q?TXVQZ+USyduLqXpOE97+syisZWsXGeZa/Hoo5nvcLvfzyQWByj4+9z30K8?=
 =?iso-8859-1?Q?l08db2DnObtKJi4D8p600/tskXHPAYgaIK6cDFKFvh10mP7pEMi4OhczVx?=
 =?iso-8859-1?Q?CVEAqD62hmhG01XYKUGTeU18ed25NGOo0E4QYk61TPUSsrITXx4O5yJe4t?=
 =?iso-8859-1?Q?aQW4NDRiIZ2V+XVmEJ+/SRgCt6ShRXlOrV4acihtyy5Wi/y+A8w0fIZuwS?=
 =?iso-8859-1?Q?6DcLlXS6UjgSYtnDDiVRa9phVwHxApT1ypI2LxtcvjI9Ku/v1BewePN647?=
 =?iso-8859-1?Q?Ul6Kqz2I/mfsHo3kLFTUj/zxt6Df2wG88AIDq9O2UIn5y5tinVZT6hi8zT?=
 =?iso-8859-1?Q?chFofw99eH8Qv0Z/tBRRCI4+aFHkxlqWPsULgYIAwJNMkzn4gJboYDQOJz?=
 =?iso-8859-1?Q?qg5hseRnrXrTZF0wq/SmuVf31Bo7HcbhGBVt3cdxJDi6swAns4JGtmV8es?=
 =?iso-8859-1?Q?Hj/VCm03gVnI3FCtd4frIk2dfjeJNokrj6Z6lqXGBZ8x69ALKQqrizQKmx?=
 =?iso-8859-1?Q?wN5Aw9SfVwY2Emq3EiMMHsjMzrdvdodMR5r46fhYxiJFJQvVMbjX2ln6bg?=
 =?iso-8859-1?Q?5MhePEEpYJXdvUf9YRDFkOnzseDHkcpwUCcJANnFqZr6BD3TmtxtqSFfnF?=
 =?iso-8859-1?Q?vhz0dCMjJZmsBJnlahV6RRFxmtM9GJIx8QUvEBRkD7761Za+25trNHBfTH?=
 =?iso-8859-1?Q?uptwSzun76zVZsuaTafCruPQtZ0z6NFdGDejZRJkr81rwPYtPVVXhPxxM2?=
 =?iso-8859-1?Q?l5ucQ4jKb6uCRUvZHQhaC+OX4obAPpiPFWDPVDermTapRXQmxsK2n0KRJk?=
 =?iso-8859-1?Q?RDFAd8sXhASbHxHHv8Qc61lhg7uCW2zOiFIStO385nbUqMX+QIBED13YC2?=
 =?iso-8859-1?Q?SwSJh+j0i6gV+yeca2zEZTRU8i8vu0xMaJ7tH9dyhV/MioYOs42QLeG3Ht?=
 =?iso-8859-1?Q?HlucPzdqDZad+ChUV730g8AGKWmoZE+1aZrYmQ9res6EKmKwx3SoLXLFup?=
 =?iso-8859-1?Q?16DevCkoDOeMjFQuwUODnW5q+o1g29IdhwmvY9pQlAh592ZgnXTiz9xNFx?=
 =?iso-8859-1?Q?zRa1oT4srmwHsnsnQopaPYi3bGj1IYDNOgnHcW1MNV7nvMW/3hRCX/7Yb0?=
 =?iso-8859-1?Q?ZBZSloVzjdjUadeEsEItI3wTII0Cfajx8PsXgMT2VHfCfeOc2xUglFVY/H?=
 =?iso-8859-1?Q?JYI/ozxhaH79SLaEar2xvfXO5k/f9R8iTP9AdKIikF4FYtPsAgnWGJ3cB0?=
 =?iso-8859-1?Q?sKRito/PACOKr/bxPGpAHbCb9b1ZZnHz6JYF0NdfutqrZxqLXdM3LvOh1x?=
 =?iso-8859-1?Q?Dh/9KiI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sBjjHoM4wL8Y5dlpqs8+QnmBmFJFacS0rij8euI/zPoqPqm7PdnCGEpcNN?=
 =?iso-8859-1?Q?rJD+NBedfNv+1H0epgm/Ow5dDt22gVJ1JFGPSMV4+imlXIZF1B772lFrUd?=
 =?iso-8859-1?Q?eFp9mMkklLMzwDStJ5RUWuc5msemSWWwEo0UAgzRbN1zqUTnkmu7snoq0V?=
 =?iso-8859-1?Q?SIsCD2IDn9p0Q01T3PACak6aDQbPVf2/Geu5psBXEBo/8c3yTzVwxBlp9c?=
 =?iso-8859-1?Q?5pOj77KV0x8lVjaaTR1AQ6MEyvrljbsgPcedoPovIUwGKYddIXTdZGs5v2?=
 =?iso-8859-1?Q?W4V+sFADjyzalBRvdhSvgOKJdfPpqR8piabrUB+DUb0BQZGbsFlW0183nr?=
 =?iso-8859-1?Q?rBGliAkPkYpkePDDtjgi/L45l0+auK/exU3gMm9K5C/6pgse8C4EIlbU6u?=
 =?iso-8859-1?Q?rF5007MKq3dS062yprtNvC+ESJqK+VQHr3P9ctB3UbQQWz5tUXeG7uq+/C?=
 =?iso-8859-1?Q?1wsQtWQSz6W/JyXxTdiQ1eByFFfdlEbDlV72DYhWpU0g9odHABeoSGMyXn?=
 =?iso-8859-1?Q?x/Cr2zhK+76UykkU9NkUS44pIZT2IVGTEAgDEcs1+mqe/b1EhAyi/JGe2t?=
 =?iso-8859-1?Q?P20olb6goTnVI2jJuiLtpEfu84XNGGVgAMMvsxA3gYZCNFt8gB+aKGQBZl?=
 =?iso-8859-1?Q?xWeKfSJNTQ6R+0M7EHgJOOh38nlnEWQm8EVxKQNYTLFkbE6yikEHRx3d9n?=
 =?iso-8859-1?Q?cciQg32u32pmBaPVLj5xv4Hw/lzMCaeGEQNQ4le5qjy9OocLjuSnLT6N+E?=
 =?iso-8859-1?Q?Peex8ZvnwdYek2ZVHojhf2kI8odVotXR9YMxNkhGl7xNhtms2CDThjmpEi?=
 =?iso-8859-1?Q?/sCrE7rq6JzAZfNZKdg44h5dwjUL43DyyhhxGOEynNyejKJut3p7oMog1u?=
 =?iso-8859-1?Q?Vr4OGUg+DiRosVV/SQqeJVjyesZ6niofvLhdcju/fW+b9gj4yZqaWi+ST0?=
 =?iso-8859-1?Q?W5ci/cXg+YEb/DxKUTtCTRxl1TEwM0t+PS9wZYfrJddaFj63TZVzZ6jJXn?=
 =?iso-8859-1?Q?UVKDy93gQpWuTNvtJxzp5Bp5bdwRQpzoAKKWEqKCu1iDErUBFxow5isoci?=
 =?iso-8859-1?Q?ax8HZ9brMIzDHSYOoXs21zv8xiAlLTf4+heN+DoDaDJW32PWs1q0WueH2e?=
 =?iso-8859-1?Q?0lzheDHYxgA5OKE65YLDE/uip4CHHsTZkDI3lGN789+RjVGNnl+BG8MQqg?=
 =?iso-8859-1?Q?fQwJgNcQrK+yOb8gOHy6MVecKBtJ613dX2rltNyTfxeUW9Bp9xdluVBmFH?=
 =?iso-8859-1?Q?siHqANmJL1mg2Was2NyTCet+ldkaMdowYb9LdNRs8c60qvbeQtKp3OxrFq?=
 =?iso-8859-1?Q?+IFgOishrZMRTZhJ7q+fXvMwvuSe30LffItzh8voA+3SQ1u93LRe4kMVjH?=
 =?iso-8859-1?Q?IBxzS/fEAYH+R/zAHflhenqERxtVMGLJcpTMrHvg0+iXFZuVwPYSsKlRmC?=
 =?iso-8859-1?Q?+xoOF25VLZdUAI2jreeioh+77rUr+PVBBESUmoPKRSdhKZLFT+A0Qp8Ppk?=
 =?iso-8859-1?Q?F67HwWVzV2MUYKA1GuFV7dGjoNWNr7UOqjaFN3OZwyxgkSPK2yxrSK6r6k?=
 =?iso-8859-1?Q?pe1gK74LtjKQMGdaoXKkNVeHahoVt69n1bIG4p1udBu2VA4FnhI9K3OGMI?=
 =?iso-8859-1?Q?olkqMfrUQ+WsdElNLTD1WjMoJPquEnp8Lo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f11ef979-315f-458d-f740-08dd823b91eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 07:50:51.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vb4mPrxgdvtx9im1Brafn6QUEwVzsfNf5trcbXwqJHGG+A0mpPatr2BkEbwuvjb3iVEkPFu/JU0ploUbmHxH5/NvQZjyov8eLka327tRRJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7237
X-Authority-Analysis: v=2.4 cv=L6cdQ/T8 c=1 sm=1 tr=0 ts=68089bdf cx=c_pps a=dbnGGe82Z6Ok/5ez5STjcQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=iTyjyjCOPuktkfFwnuUA:9 a=wPNLvfGTeEIA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: Km1AfwyJLAAoCLSUao63aIT8QV3DQYV7
X-Proofpoint-GUID: Km1AfwyJLAAoCLSUao63aIT8QV3DQYV7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1MiBTYWx0ZWRfX1yzxVkT9Q+8k INYYv2TOBhmn9JvUx4SZM88gVD+FpT4KpqEo/4iq/TLVQyiyELy6Kw3YEMtBE7J8RXA7+5/0cUV 4+AWzhUDoJSmtJ+TlU7COt4RIFKSRj7cj4Ns262f3vBKPNxLSNQFAxcHr6OP4dsBYb08ekjNNtQ
 jDPFq7/gO8jnlkbgxeiOVgsG0zNe9XIy59VV/zk/9M3XxGS7/43UZy5gJx/SrWXbe51Wh1255KC 5j7RALzuX4z1YZCx5Xc6GI2dbt8qPr4j+22jhDgBdhPDcmEweB61JsQYoThWPPwapxonBLQeFFt Ic2obwOdrOPMCt97a2G6bRfphYMqoy/SpCBXGooHH0cmzdmUHvRQ4jR+PUhA72TJsK6+LBGVUUP
 bTZm+JKlh2Yrg3aGxvq3DssokR/Mr2sbSCYFMTTdyWGJU3hiXbtsC5abmGN2UlZBgO9DpEKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230052

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, April 21, 2025 9:48 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; David
> Lechner <dlechner@baylibre.com>; Nuno S=E1 <noname.nuno@gmail.com>; Sa,
> Nuno <Nuno.Sa@analog.com>; Andy Shevchenko <andy@kernel.org>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel=
.org
> Subject: Re: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
> AD3531R
>=20
> [External]
>=20
> On Mon, 21 Apr 2025 12:24:54 +0800
> Kim Seer Paller <kimseer.paller@analog.com> wrote:
>=20
> > The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> > low-power, 16-bit, buffered voltage output DACs with software-
> > programmable gain controls, providing full-scale output spans of 2.5V o=
r
> > 5V for reference voltages of 2.5V. These devices operate from a single
> > 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> > variants include a 2.5V, 5ppm/=B0C internal reference, which is disable=
d
> > by default.
> >
> > Support for monitoring internal die temperature, output voltages, and
> > current of a selected channel via the MUXOUT pin using an external ADC
> > is currently not implemented.
> >
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Hi.
>=20
> Just one thing from a final pre merge look through.
>=20
> The initialization of powerdown mode works but only because the NORMAL
> mode =3D=3D 0.  That should be setting it explicitly for each set of 4 ch=
annels
> as needed.
>=20
> I don't really mind how you solve that.  There are lots of options
> to build up the 4 fields in each of those registers.
>=20
> Jonathan
>=20
> > diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> > new file mode 100644
> > index
> 0000000000000000000000000000000000000000..05bd191e5225bd267f42ba
> 36bbd42a18e6f22291
> > --- /dev/null
> > +++ b/drivers/iio/dac/ad3530r.c
> > @@ -0,0 +1,503 @@
>=20
> > +
> > +static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
> > +					 uintptr_t private,
> > +					 const struct iio_chan_spec *chan,
> > +					 const char *buf, size_t len)
> > +{
> > +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +	unsigned int mask, val, reg;
> > +	bool powerdown;
> > +
> > +	ret =3D kstrtobool(buf, &powerdown);
> > +	if (ret)
> > +		return ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +	mask =3D GENMASK(chan->address + 1, chan->address);
>=20
> I think maybe we need a macro to get the mask from the channel number?
> Using address for this seems overkill given how simple that maths is.
> Ideally that macro could perhaps be used in the code below to avoid
> all the defines I suggested.

The motivation for using the chan->address field was to hide the calculatio=
n a bit.
However, would using a macro like=20
#define AD3530R_OP_MODE_CHAN_MSK(chan)	GENMASK(2 * chan + 1, 2 * chan)=20
be a good approach in this case? This drops the need for the address field =
and
can also be used to explicitly set the operating mode for the 4 fields of t=
he register.
What do you think?

>=20
>=20
> > +	reg =3D chan->channel < AD3531R_MAX_CHANNELS ?
> > +	      AD3530R_OUTPUT_OPERATING_MODE_0 :
> > +	      AD3530R_OUTPUT_OPERATING_MODE_1;
> > +	val =3D (powerdown ? st->chan[chan->channel].powerdown_mode : 0)
> > +	       << chan->address;
> > +
>=20
>=20
> > +static int ad3530r_setup(struct ad3530r_state *st, int vref,
> > +			 bool has_external_vref)
> > +{
>=20
> > +
> > +	if (has_external_vref)
> > +		st->vref_mv =3D range_multiplier * vref / 1000;
> > +
> > +	/* Set operating mode to normal operation. */
> > +	ret =3D regmap_write(st->regmap,
> AD3530R_OUTPUT_OPERATING_MODE_0,
> > +			   AD3530R_NORMAL_OPERATION);
> Is this actually doing that?  I think the register is lots of 2 bit
> fields and this is only setting it for the first channel?
>=20
> This works because that value is 0.  Logically however we should set it
> to
> 	(AD3530R_NORMAL_OPERATION << 6) |
> 	(AD3530R_NORMAL_OPERATION << 4) |
> 	(AD3530R_NORMAL_OPERATION << 2) |
> 	(AD3530R_NORMAL_OPERATION << 0)
>=20
> Or possibly better as
>=20
> 	FIELD_PREP(AD3530R_OP_MODE_0_CHAN0_MSK,
> AD3530R_NORMAL_OPERATION) |
> 	FIELD_PREP(AD3530R_OP_MODE_0_CHAN1_MSK,
> AD3530R_NORMAL_OPERATION) |
>=20

Considering the above macro, would this also suffice?

	val =3D FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(0), AD3530R_NORMAL_OP) |
	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(1), AD3530R_NORMAL_OP) |
	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(2), AD3530R_NORMAL_OP) |
	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(3), AD3530R_NORMAL_OP);

	ret =3D regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0, val);
	...

> etc
>=20
> Names are a bit long, so maybe consider shortening some of the defines.
>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (st->chip_info->num_channels > AD3531R_MAX_CHANNELS) {
>=20
> If we have it explicit that we have multiple fields this will become more
> obvious.
> However I'd use the number 4 here rather than the number of channels the
> AD3531R happens
> to have.
>=20
>=20
> > +		ret =3D regmap_write(st->regmap,
> AD3530R_OUTPUT_OPERATING_MODE_1,
> > +				   AD3530R_NORMAL_OPERATION);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	for (i =3D 0; i < st->chip_info->num_channels; i++)
> > +		st->chan[i].powerdown_mode =3D AD3530R_POWERDOWN_32K;
> > +
> > +	st->ldac_gpio =3D devm_gpiod_get_optional(dev, "ldac",
> GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->ldac_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
> > +				     "Failed to get ldac GPIO\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct regmap_config ad3530r_regmap_config =3D {
> > +	.reg_bits =3D 16,
> > +	.val_bits =3D 8,
> > +	.max_register =3D AD3530R_MAX_REG_ADDR,
> > +};

