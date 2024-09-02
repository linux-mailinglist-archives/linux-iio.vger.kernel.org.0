Return-Path: <linux-iio+bounces-9004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F585968861
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 15:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BB61C228F9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A15205E05;
	Mon,  2 Sep 2024 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="kgdP7Sho"
X-Original-To: linux-iio@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022093.outbound.protection.outlook.com [40.107.149.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E353AC;
	Mon,  2 Sep 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282301; cv=fail; b=BGzBo+qbRvZNQ9VtmoGfonya6gtottHYgQHfFizVnvUnmoZwXKZsfWej4tT89klBLfamgbycXpgZx6zj4vofaBZimfrI2S4XeLbI/jfHWK/rlry9MMzd7bIE+OMR0Rgo7pXVzg0kR/3Apbw0sy31+tOjS8Jbmrry0gsDhbJUFEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282301; c=relaxed/simple;
	bh=ndohd8JS7pAuNM8geznIRNuBEXvUmJi8UYNJYdkFuG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XKUrPCBJASI9oon4q69//g2CE0U0AK/dFKaQ+9nkmvXxtzPvBKRzkzTbF8KZvYl2M/MwVOcdpuKaWfjufS0Y5BUgfmqZ0lB/Fl3GqoBHVoDI6AMQ60NMGpIurev1Tj8DgCArk9+1OjgOGmsv4IqU8IQCJYiNlTbbQzMloO3dYHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=kgdP7Sho; arc=fail smtp.client-ip=40.107.149.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKm7OeHIoa1PLRWDyQ7LO8Y3OP42gx27K7c3vbketBRBUXL79ugdydZ6nJ4cni4BBl4Cc8MdrXXPjiWiSHsS4H6occ/WJHGqiDIs0LZqjVa75p0E2YjzwTuXlBjZcZgmc7jNWq/8+1bMjO96ZJq4uH7nX+abRTVs+hhDk/20KzUAA8UBM+2T2iNFSgWf/gEUI9epyoZU2XW3fIXmXdHODwQbmxXV6IgQP/O45ni9hGFDFKDwteUXldi3glfuVok1JI1dw9j7zRSoDsa8LuatKB6ibYXagoI6cMkVvVkpmHv5//H2XjQg1FUMZOVZICWWjdVlj97EI8Ad2G/D+f+hyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hGZotU2caBgxQL0e47G3U9CRFEWjij1nhX6TtyN/WQ=;
 b=lXUYp0QEEcTnZI0482NNOa48hB77amNnviwsGSRkLsXZJZHTrDdw9+hqHr8fZD3ILUL69kkeX/ycPmxPsGwQwiaBAkm8qVJU85nVu8U5K+4bae5Dl5t4Z2qluvCxcf/zG3KX0sL29OhuHIsd2DdDYLZLvqExvXrZE2Ne1EPpFmGcXP7Mo9htAVDyfoEUD8NK0Oq1Sme+x7K6WBTGoCm53h6uxtcaM+7+p55sGp8tvyI+kpXL7S8MUod3YeHnPSc4z7u5TIw3RogtBUr/JHdR/M8UxGf4zcJpPbwFqTNYxUexYttT1W5G4cvMPKjvhifePGnRul5CgJmhJopzqLdAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hGZotU2caBgxQL0e47G3U9CRFEWjij1nhX6TtyN/WQ=;
 b=kgdP7ShotENmSLJT+gR2LZUYLauLSvqUUgfUBxtA7jN4PpF/LNHW8ix0lwQZEwGirdFpTpoqFQZPuaVvESJLlaY5biDLOBQ/8jSnPzaN3fnWqa4Lq+uEQl1+NyK1vtxCkgkpbEITaxaIo9h+cFsiyvE940ClCzW2UYSmlnLdq4UQqWAmH0H9LMsRBdPZCEvjaKQ4SDq6vPLoqIvHXwCOZBDrHckfnAZPaBjSg6Nh8o0EE2LNPgFiuKAzEHkBULA0qutKfBTjO5Qj3spsVy4H16LoLRS+ZlQvQC9fzXV2ZRSKY1o+l7tZz34Z19WBxU/6xIdknEwmrDpGh1VVc26Fww==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FR2P281MB0267.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Mon, 2 Sep 2024 13:04:55 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 13:04:55 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>
CC: Conor Dooley <conor@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: AW: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Thread-Index: Adr60bwOPjoiJD3QTreu2+tBMAOlGgADMoEAAAKm5gAALa+fAABmA43g
Date: Mon, 2 Sep 2024 13:04:55 +0000
Message-ID:
 <BE1P281MB2420EBD112C4F7A96598AE05EF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	<20240830-chaos-unrivaled-04c5c4c6add9@spud>
	<766b9892-ef54-4f0a-96dd-19e8a1b3279c@roeck-us.net>
 <20240831131824.03141d4a@jic23-huawei>
In-Reply-To: <20240831131824.03141d4a@jic23-huawei>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FR2P281MB0267:EE_
x-ms-office365-filtering-correlation-id: d80b1177-31a4-4556-b920-08dccb4fd788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3/1QWBEJ7hh39ovDnhiaHlLS5bzix29rBLX6rZDSVYVCA46NAF0ysK/qBqXz?=
 =?us-ascii?Q?Z6gB/pO+jEg32261LYKyoQbqUmn3+DjyO/3ztnyKdUkPXMLGcUWWwfvk4Vyl?=
 =?us-ascii?Q?jRpmtPs9lWM5nsYAm3vHuWLWe6nuNCgLx+Y5O5TybBTvRMis/kWC/3jGJCa5?=
 =?us-ascii?Q?dwETzC3ikRqhzA2GMXQxjbLsDjcqhZLQQbMtFVeDTfITvs27JvNSizO+v/1A?=
 =?us-ascii?Q?uh1G0NReJ7kRwKkGWDzf9SN4xl5oTqf5+Pk4UClQ7upLt5vW56h7ErjFZJgU?=
 =?us-ascii?Q?L/9bPRYbiQkUkjyqREZpG4j4KQ/M/oVypwlZXEJLOX0gyajb/FROjcWYm+At?=
 =?us-ascii?Q?mJ3HAiRSdnQ90zIF01g0JrHf0A3DOykNdmYGqKOmzYvuBdMAxA/1QnIO6a9g?=
 =?us-ascii?Q?9Zlqdc8RfTu86su1dhifaC5ESPb2cFhyMs3FsnRBf+R4z3plEQkLmtqmu3w6?=
 =?us-ascii?Q?sOLrGAcUMLeVyvmX2DYDcF1rHlLjXrkRRfz3FlTF3akF/vGa3Ah/Zj4HAz26?=
 =?us-ascii?Q?njxZSWW5YBq1VUzIbresHPCVb1Wbzfwdhv8fFJHN9nDYf0xep+ZV44FwGXkc?=
 =?us-ascii?Q?GYig5zNKUOcPPeDQ1jY5ss1cemR5WubSNNsigbvKvkxWQEoXn7nOJwsUCnNG?=
 =?us-ascii?Q?F2t7w+C23dfDM16RqbAshDzT5EyiBFN8vq991EqIbXiSN/syNDqmhJyGKwas?=
 =?us-ascii?Q?792AXbFxtzmLbScNNwD7iez/xioTjUkB/e7Ws5002lXY2+Bum7LOINwwHhUA?=
 =?us-ascii?Q?uzm1g7tdYn495aJQPHbY8n9iKLt3aswG3CJ7L1Wwi4/a4urQ2Ll5hXkTeCMt?=
 =?us-ascii?Q?i0ekzU0MZr5uBPAQxKeMRPye8zY07/sV1CZnxr4NdAJZ8YIas9FFUehuQBtd?=
 =?us-ascii?Q?06ELe+z4YI2X6SFgXJEw/ebvLsUpvb1r9x8RiuaHkaMGOCV/idxiec2cX3DM?=
 =?us-ascii?Q?lC0BW5mun+oFA1uvi4TWdK62/Q+f0odEfBNLG0d/xXjTEFwf5chYEo3Q4C5h?=
 =?us-ascii?Q?oPRYZ7Dqfo2g1x39SDpn2pDFEJRKxvkNegBKJNqD8lBgJegvstymhIMmpVrt?=
 =?us-ascii?Q?fuumfMg4upM8mC+DKhXF3tgZn1GEoutQjZH2Y1Z7/0/ZfPRbgIPT/HlPqcTL?=
 =?us-ascii?Q?GkfsrdrX2JH+hLM+w/SOhq7ViXE9/zWDiy+wiKooauAHbSMX2c+apPHtSWlc?=
 =?us-ascii?Q?gIcWuAsExR7Lg5oT5aoxg1h+PZlcjWl5zDF9n3Xqdf9fUykkwOn5OUCuTgOe?=
 =?us-ascii?Q?DwYcYvUqHqnMufcenIAg+DRUejPsaiCucR0p3Q1Qg+R2+HL13+1kZkvokSvO?=
 =?us-ascii?Q?BCj5vwYKOIUrv5zEVylHNxBQnIGOg4/wYDUnBG7cQDrcN2x1tmeQfQzmqYu8?=
 =?us-ascii?Q?JvPDs3+479ueXVrHlck2lmJtqlIV2jgrVKeTZdrdc6JiYl5zCQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ph4qh6YK1j+zhGGTAf2INdb9Os0UiLfYbDihh/CFjWgJecgY9/ckojSvtnah?=
 =?us-ascii?Q?2lKpFUuc58Ixr3GbKPD+OHK0Edq8xP2cESkuqUSPxk5fO7ubot/ZxSBBfiuw?=
 =?us-ascii?Q?JeQA3jKsjpF+qSGQ12ts96i0otGLJ7QPt5memUDfHne9c531FISDUKsR+dFN?=
 =?us-ascii?Q?d+s5wl6hkSwk6X5yKRxjg/b7ZrOgqO1HzUKQVeLITO4GJ9EaoosQ/NMKu9zX?=
 =?us-ascii?Q?ETGuymp3Ib5VTa7wqJM65+eqyyy+Si1ywRbYSrzztKyhnyeEMj7N/7dG5txk?=
 =?us-ascii?Q?gQybAxE5xdjzRJ8YGwD4TG4siID5/bvJiPUZFzvlLJxllB/a4R09qyERyOFL?=
 =?us-ascii?Q?RCIOCd+yjb3VE/mOJu1r3ATFKZY9b1ubHc1/CsvUSENqCmRt+ZvvGB8YVf6t?=
 =?us-ascii?Q?thxcG5ZkPz/zyDO/vJ+D49U50eDiv1za/ohSeSmba0CCVT4vsri120wjYxAz?=
 =?us-ascii?Q?UVLGfAKSFlIXaiPDXZXF/m80/5/EA8zX1eUw8C8zUNP8BSu+4twnIOKjv3LD?=
 =?us-ascii?Q?+43lG5D06lr7NaTid3RbFxC6wmqFPkkqhnc3s6Q/Yx9AOtZ/dOFv4qOdPAxh?=
 =?us-ascii?Q?ySkSmnJ6brJ8QZR63KJFMKBfH3fx8LgzQqDM80L376Q1RJXijJkMTk2G8cgK?=
 =?us-ascii?Q?wIug4EMLVVJYd4OpLlfhCSMW0VVMW5MWPtrlFghVm0G+a7QHv8X2Z5FtdETg?=
 =?us-ascii?Q?MSgtLOO0YlEYgWaIwmP+qaMmgTpJOuNymZPLmIm+l0Ha1NL/OI0oOWfU4Otj?=
 =?us-ascii?Q?WfAH8bVkpuxyTQxCM3skj4nXgaWFUjdo04x4RtmbCR0gpRsyT5O3fC94yj+o?=
 =?us-ascii?Q?vF+2FUUYyXTb0j2klvIrwvmEPPN8pm2enDFzpxjA04V4N9MSmAnPLc4sg1F5?=
 =?us-ascii?Q?5uXzSdm7dvzc0G0Tuj9wLoHyaHORzF8yv8xVczzs/v8qFyUHINaW/fsHKSD2?=
 =?us-ascii?Q?eBTj9eLxmV8AwJyo4G35wKQWHkUXiQ/kPqPfYkxzK5lxTeM3C7yUx5RUcPmV?=
 =?us-ascii?Q?KY1K851EsAafrz5Pwhl/Vvvhtkz/QPsygj5CwchP2L7KpQXGwSZGMfEWodHw?=
 =?us-ascii?Q?k03fN+6W7ATvRObGB6Z1JSYbkQvh7zZdur+AGy73jeIID9Q+Q4Mhjf9+lEyb?=
 =?us-ascii?Q?X9ex8EyJwRKsh1mnVyUkWDJiSkrNDr13Na8lJV8O3tvD4UZChSYJw/N5aJuM?=
 =?us-ascii?Q?t3maU1lDrV03fUTh4wN5zkFRsLT0tKp/RlKyerFxq9YCmK8vjbITsPmoHras?=
 =?us-ascii?Q?s8RfurgqlhixZaNcEy/9UPS+w6WUaZvT0zfHNL5MzdGJqHqqDkp/PuTaEegM?=
 =?us-ascii?Q?wIS0MWA/caA6XrNwR5HlOdAP6gIEe6hQX1ZMkIPbE5yThhvamxzPSF2EUolJ?=
 =?us-ascii?Q?PYcuhS+Tu5ndUwx5bj9p+YNPOAUk9sfaNNg7XiiWXqbW5vQaoKQ3sY0ISrzk?=
 =?us-ascii?Q?9RUSpN1rjJNayPp3RAvs73BVCDdQYJ5QLSqJp1WyXL+wyXRCgiAzZmdijpSx?=
 =?us-ascii?Q?X8ZXORJ9KojVWzZ8g6a4KHJasdcDQL2tia+FWf5toIaL016PI/5L0EmTbR3+?=
 =?us-ascii?Q?8GALZl6KKLB3BQK+mx1YcQOTOUQJmN2nL1ez+K8KgC0eIrq3sTH1QzfM+QK6?=
 =?us-ascii?Q?yyM5f1MHU6PCvScElVudVPWY96e+VlMSGXT1sMBRSzcYcEFjG9KjnICvwZFg?=
 =?us-ascii?Q?h+kYzg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d80b1177-31a4-4556-b920-08dccb4fd788
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 13:04:55.8118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGn3mYcZ2+qxhTYnLSnkN07xC3ZF74Dn2PhRs89g4kyQatV5uwxB3X/oKoQ4S0Ft+Y7lLDbNOiTFiH+rRImsNAOnsso6tuV1GLwkBy5QMtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0267

> On Fri, 30 Aug 2024 07:30:16 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> > On 8/30/24 06:14, Conor Dooley wrote:
> > > Hey Tobias, Guenter, Jonathan,
> > >
> > > On Fri, Aug 30, 2024 at 11:49:53AM +0000, Sperling, Tobias wrote:
> > >>  From b2e04ce5500faf274654be5284be9db4f3abefce Mon Sep 17 00:00:00
> 2001
> > >> From: Tobias Sperling <tobias.sperling@softing.com>
> > >> Date: Fri, 23 Aug 2024 12:08:33 +0200
> > >> Subject: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
> > >>
> > >> Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-ch=
annel
> > >> analog-to-digital converters. These ADCs have a wide operating range=
 and
> > >> a wide feature set. Communication is based on an I2C interface.
> > >> The driver provides the functionality of manually reading single cha=
nnels
> > >> or sequentially reading all channels automatically.
> > >>
> > >> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
> > >> ---
> > >>   .../devicetree/bindings/hwmon/ti,ads71x8.yaml |  85 +++++++++++
> > >
> > > If this is a "generic" adc, why is it going into hwmon?
> > > I would have expected this to be in iio/adc, and use more typical adc
> > > bindings, even if the driver is in hwmon.
> > >
> > > Guenter/Jonathan wdyt?
> > >
> >
> > Same thought here. While the chip supports limits, making it suitable f=
or
> > hardware monitoring, its primary use seems to be as ADC, not as hardwar=
e
> > monitoring device. The hardware monitoring API isn't well suited for th=
e
> > fast sample rate supported by this chip.
>=20
> Agreed, looks like a typical IIO ADC.
>=20
> If the particular board needs it for hardware monitoring we have
> the bridge that should work for that (iio-hwmon).

Just some addition. In theory the chip also provides the possibility to use=
 some
channels as GPIO making it not only work as ADC.
But yes, driver mainly implements reading of the ADC. Will try to make it a=
n
IIO ADC device then.

> Jonathan
>=20
> >
> > Guenter
> >

Regards
Tobias

