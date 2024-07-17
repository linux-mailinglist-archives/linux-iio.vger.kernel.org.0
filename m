Return-Path: <linux-iio+bounces-7649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE509334E3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 03:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D98281273
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 01:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C7EDC;
	Wed, 17 Jul 2024 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SfzuuNYb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8214C81;
	Wed, 17 Jul 2024 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721178472; cv=fail; b=u8SWaoF4Ps4n90hP4eJJHXo3OmZOi8zGWNDSGAlNCgcQ4+z7JttxtH4OQbcGvQHA76ZqlMwH7UR1oG1IUc160dl3FzmpD8RoHr+7jQ4sMma/4EeoeH2jnufmo0YK6GNB9Lmse5CmFtG9tnEXblzMhE9UXHEPKxp8m5es1KG1y/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721178472; c=relaxed/simple;
	bh=NLpRw89Jy8lm4VDk/uyJ01pnwvJaUHCc86Kdc2ssiOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oXq5HeZ5YD2O7qRyxiu+l0NVDl1sa+5Gb6xcSOQPmNDepkNj34uKWNjhmAMU+p7GrIVcjfDk0ehl5Op1+Yfci5smDUeBJi2R1BxJluBuoJIfpycBMie9jrPsQOeSlYUNkgMejq4bbaprZLr7dbm4tr1LGNLoDz3dhsXImAVm+PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SfzuuNYb; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHcVQB000904;
	Tue, 16 Jul 2024 21:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NLpRw
	89Jy8lm4VDk/uyJ01pnwvJaUHCc86Kdc2ssiOo=; b=SfzuuNYb2bGvELgFgfMIU
	2dgBQg1JovkRjPrmjoJjMYjzCMWefhm43NcmvM0DXLDdaDwPYBqox5nSUbLse5M4
	XlSvXxNYMwGTtdDyp6AqGhDlQEqxXpuL6vsWDt+l5uRLYaq7gIescNxoktJMkh5v
	/mfmH2/zQdlri+y5e399eV8boH8bzMY58Q8d+cr9QjxwEBS8kpa09BXzMlILrMVa
	9N9yvPzljxZjevYNSKZcr6wd9Y+9E2wx1iSHJeFANbx+Solopd14zCrqDgh/HfyC
	fWCJ18IJrKkSbWJ6nWJE0sReOxEDotZNRY284OgSt0L4lIH/7IAmTtDosyazeVDv
	A==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40dweks1ee-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 21:07:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnnU1ffnGloC6wHp+OZbqaSDpsQjVE3YeRGu/XLxKXmlSFqSUv+nVkSYqq9jaUM0a62JMvGleCqP+syHjVx4hEEhBlkU5XUwWoupRAfceMUKrOY0i+aFi4x5M1B7we2w24NefV43R3GUig69Ey/KrW6O6we03UQeAlm4hQatd4q1ib1bAfKNe23MhCPnpGkY68aqUKwRwgsVEEx5T2Go4nLT05DMT5xjTAqFEU1oU0URz9WsCuVu9eA0sLNps24HyRl7glg9bf/EFCw9aswxZSnhJwFw+/rg29BkdaQ20e7AGIQ77QnfghY6C1n/ZSnmUvIL9ivDNsPIndJvqBQ10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLpRw89Jy8lm4VDk/uyJ01pnwvJaUHCc86Kdc2ssiOo=;
 b=Yr//HtEMKYYOsn4BxviE+JTjalY22Fy2mSnkcSDK2477Gk/coK/Lsu9mjrQTebR8wwEgFdtHytOPB+heIDFejyX17DfAMKpphxY/SMQCRmN+H/DjeSAwKGENjWvjX6UrBfdA75AhCZNOimCR1r8GZrZoHLBp/WEXG6wmXNxby+nSgnH5IrnsgoG5wkL8AUfy1p0VDJ7V+1KMBSNiKNFtSE2xJGH1i3KOCRUgGkOKWf7v2Fudiw2eGy5XDf0JAYeG/xRLA9TiFBsDHwjO0KzPUlizg7i7wzTpUdR3jlr6QQhwL7Dp7LeK3YIUmHZ4Ha2m1ty/cxAY/tDekAIJagDwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SJ0PR03MB5485.namprd03.prod.outlook.com (2603:10b6:a03:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 01:07:31 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 01:07:31 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>
Subject: RE: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Topic: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Thread-Index: AQHa1fIKypoGO0+cUUGRLiCsvbmNpLH3+UYAgACfTOCAAO1OgIAAl5fQ
Date: Wed, 17 Jul 2024 01:07:31 +0000
Message-ID: 
 <PH0PR03MB7141D593AF504A455AABA4D6F9A32@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240714133000.5866-1-kimseer.paller@analog.com>
 <20240714133000.5866-5-kimseer.paller@analog.com>
 <20240715-numbness-chooser-d1bcb0438ba5@spud>
 <PH0PR03MB7141E98ECA32AF462D3AFF15F9A22@PH0PR03MB7141.namprd03.prod.outlook.com>
 <20240716-supremacy-reseller-4fd6207d2099@spud>
In-Reply-To: <20240716-supremacy-reseller-4fd6207d2099@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1lZTZkNGYwNi00M2Q4LTExZWYtYWFmOC?=
 =?iso-8859-1?Q?1iN2I2MDBmNjM3NDlcYW1lLXRlc3RcZWU2ZDRmMDgtNDNkOC0xMWVmLWFh?=
 =?iso-8859-1?Q?ZjgtYjdiNjAwZjYzNzQ5Ym9keS50eHQiIHN6PSI1NzE0IiB0PSIxMzM2NT?=
 =?iso-8859-1?Q?Y1MjA0ODAxNjExNjEiIGg9Im9sZGxocG4zWG1GS3pIeHVQMERBZ29MK05m?=
 =?iso-8859-1?Q?Zz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBQ0pmU0t4NWRmYUFTRkZnRkkzanRvK0lVV0FVamVPMmo0?=
 =?iso-8859-1?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBM0xoU2ZnQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SJ0PR03MB5485:EE_
x-ms-office365-filtering-correlation-id: 485c5876-15bc-42d0-66c4-08dca5fcd5bd
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?tSeZESpGTI6lHoDNjSxCgUbx7wO5tW6Xo0kJ0l4CxTgZIlZpBaTnjeaCU0?=
 =?iso-8859-1?Q?CC+ZGjMwBJlT4caS1VqNHe7CIaBguCchnhy06Dq2yPm7jtnds1XnMWo+E/?=
 =?iso-8859-1?Q?4U+GXNLM1XEc31FyJTjHFGfHduuVx9Lg+8xaWn0tblGNP+RbBbjwwMaRyQ?=
 =?iso-8859-1?Q?F0U8ZBL5nYqJrq8JAOkFdhb7RqjXuL6K1nLMeZqC0POkcD2G3CO6/2Crog?=
 =?iso-8859-1?Q?K9eF7nvA6aoYFyyM2si+Aed/HZdqli+de+9VQHnvIOLH2y/HHaS5H2M9n0?=
 =?iso-8859-1?Q?j814vg2oMOn3rms5X66KgHPSMf/AU7R/mn85HPgGCi5/u3rwR8yeC8Je+9?=
 =?iso-8859-1?Q?u51Gek0q2lwj/QSuP0CqoZD9kCH9R4EAZYJqf+RMCCsrjUtbXOeWuKJB+t?=
 =?iso-8859-1?Q?diVV+aOHyUzquoxLMhPwIvPO397kgIwocNhIWsyo86eiJnxVb2XFTtMAw3?=
 =?iso-8859-1?Q?wSQmH6G53//A/Si/8qWmRu/+SA0pwcpMdCm5xFnZ5T5qmTiG6/2EYm8R0f?=
 =?iso-8859-1?Q?ldm5DuTDy+Gx44xQ8wTdQ0TXiVm9hhQFuDsYdIA3boRc0/shf4LRLgLXht?=
 =?iso-8859-1?Q?e3IHPP5gQsVyiA6lX3eZrZwSumqQkIEmPYPuzTJqdB/jaLS3BnePyGwkxq?=
 =?iso-8859-1?Q?6LZC7svikI77nLUzxBB39DOFJIbjKccoK7a8Nmx8jPUsJ9LfL1ccIr6rSm?=
 =?iso-8859-1?Q?1QWtQoHGJ/o9GEGRQwN4FJTqhfQFGCsz1kaY2hTY/3pHZ3I2+1yTJ1HwcY?=
 =?iso-8859-1?Q?h4zLh+/PEma3jFQ0rXZGy9dk4KcKQNqn7tGy6d5+M9dVEgSCuU/GyGJDSH?=
 =?iso-8859-1?Q?didcFZYC0cDP8dvqZuTEA8mvxWtUFb/QEBx3UNwBImcRZCyNcRcdzWJFjE?=
 =?iso-8859-1?Q?lpR4MpwNEGvpvRCYxFAJ8ZEVPlRJ02lfTnPXxSje6X//alDcmP49EdwfBi?=
 =?iso-8859-1?Q?Bqy9b6gYOJsEp/TyxHJBATBuNu2/gGrc1RQduCB+ad5KDvsA3sNwN+yao/?=
 =?iso-8859-1?Q?F+WthkexziWMUUiCXtf1cJEjTl8KZ5UWyDgDwqmQGSj7yGvcdIQT0CbCtx?=
 =?iso-8859-1?Q?SP3DVvXuScQnXWm0yRTDDTDMiXMWv8CbdSjpvArKFv1V+hLN+mVXYIZcl2?=
 =?iso-8859-1?Q?LI0LHmQ1hz4xl52ERBhVDn/7K0oI6EgUNnz0GjCB4l2jhz2zq8tnYf7EMx?=
 =?iso-8859-1?Q?QYu8ChWHl+EKg0UAqVgV5LJGlOS4kJUJnRYxvgl9m4GYacQCjBXrAeiJp6?=
 =?iso-8859-1?Q?7Dg9TXCIm/I4gVHhKcMib9BVdtDKdutkTMxFM6srXY080Weoi2adLV2Bi7?=
 =?iso-8859-1?Q?3+xbu2kdwnqMyr9F9JCxbLCJkoc36fOiidl+7m3uI6ILvEVUh9QvZTNuD7?=
 =?iso-8859-1?Q?AiztFdghgt1J4K+7CkOEKrUghtMjSaG1g4LurrQJWdh/zzqAi+aL7cVLiS?=
 =?iso-8859-1?Q?jpauZ9Ueky7Cv0uQwJ+BYzENduJy1rXcNnAAeQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?GUrCHObz2k8Xy6CtVWv6OaGe0+10JMhBrqPPhHapwKHuhvOxy56m5QlBGG?=
 =?iso-8859-1?Q?W8o3nWmwtlaBvOGKImRrybFGIJhp+1Q/g07hQvsq/MAyzrkH3Fl9LuKmNb?=
 =?iso-8859-1?Q?zOZQ5JJxhLX9D5hKuq56QdjPm7w1ndajS0L5U45hX7rb5xbYqYG774QzX2?=
 =?iso-8859-1?Q?2sPZIOraM3aLjtsnk+1g+4dsTNWgKR7P9QV0/Ie4oTfwmA7a/NnSIekmAJ?=
 =?iso-8859-1?Q?nVi+t2/CJZnfJjRpss434BAGmW7nr5SyO57emyY+927yk3+PISC9+BZdqJ?=
 =?iso-8859-1?Q?kglg/BSO++q3vYTBYyoWVdUx9gIfstQmhjdilqJ5V0cjbZBhv/AlqCK/Fo?=
 =?iso-8859-1?Q?NO1kcIGN2m9GJnxp+EFXf1RbZt/Nycz936Nv+mXeQPDbjQo1xdJYuF+Ss8?=
 =?iso-8859-1?Q?ErSBfKeUNjVPU5diw+XcEIN5mn3bxI9Fy/hZ96d5uol+fWRNByJezLgrEa?=
 =?iso-8859-1?Q?mKWPZs4bpU2K+Z4pbCr1t93v+2Hc8lO/gWbS+/ta4qlCaNB0TeP6DUrqEz?=
 =?iso-8859-1?Q?oGdUCP4wdKN0SIJYtMnmKJSl3tGfJkxbNAbgtRViL/3jTHzezRzcg4FrdN?=
 =?iso-8859-1?Q?B2o43O1tvz/hhgd2vb7T27JUhN/e+Uh6cZ6prCqE/MuPi/R22D+uEKiOC/?=
 =?iso-8859-1?Q?ubqBAVbJHQHnLYr6j6o6sYP4BbqUXFX9y1BvfzD+oZFEGjm11R2QRYiQeQ?=
 =?iso-8859-1?Q?OdPFXGHsqj8n4dh1M0+8Pp+2jsJrpt9b2yTxXsRFU2qpNbwUzKZY5f4Yrj?=
 =?iso-8859-1?Q?zadjGL10EX6x5SE3UAFSCVDNgXmODkva4Gf7LiNn15PcHtRDrPtnSWoIZm?=
 =?iso-8859-1?Q?sMfXDcpyxMct59cI8du17A12F2UAhpbVbWuV2juEfu+CYXqOdNfscXhbQ4?=
 =?iso-8859-1?Q?ISteoVy6G8Z6WPRFszebrYrHwRn7hHQt+LwIGJB+4ZU71idLRw9hjZcS+B?=
 =?iso-8859-1?Q?OwRtCX7ERiZFby+9FJiV1OzZDNYimaI8zrW34OYQT/aJtMgGIlNhaGNAs1?=
 =?iso-8859-1?Q?qLoNJDsZB0b64Ciq7y4ePAwoD82p6hFQZzxDLimTuju2iMxdT3kk61oiAn?=
 =?iso-8859-1?Q?wCxzOyTsf0DZgkOVofSh84Hpn7cOWCjLcSK+Q/YfFFL5wENJZ3pTGN1+lI?=
 =?iso-8859-1?Q?Brp7YxTQazytYs2LQ4qYSUy21zr1R97NKujyOzPdQKdyMT0f6PDkaNWtOA?=
 =?iso-8859-1?Q?QYLn03iJtYfqGiR6dUHFC0ASsiAo7vpcvGcrt5eMfQQAjClEiTGbSK54gk?=
 =?iso-8859-1?Q?9TAV/w/Ojc24LCRmLX3b9DfcikcnJWu597kb8ybPd9/Q35Gzc+XpYFmyn7?=
 =?iso-8859-1?Q?ttNkrhamn7/bYCNl8DraZz4eV2gdJVX75EqPkWHwm8js6ViqjJMTH23RUY?=
 =?iso-8859-1?Q?oMo4anO4xUUPqGO89bTYNItbXoSAaSqUUc7e+uQrcJL9m9uvTTN6GQFxDv?=
 =?iso-8859-1?Q?ph0rgn7CAnp7jOefYW1nteTn+Lw0MPJIwY6ap1lR2VbG0LL1Fsk5DNNs2J?=
 =?iso-8859-1?Q?+g8bR7PT8r9OQosUlPfcx8L0KQ4z3YeZZ40e3JUsxDnJZu0gCS9s+9qGzb?=
 =?iso-8859-1?Q?6uRkarAZ+OsLVtMRI5Qw314o3uUWTAdbjC6DC20/FnSQiRz89G9Or0rVKv?=
 =?iso-8859-1?Q?JvuApodjv3PTyxlkHmI+etUW4jCCD1wx8y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 485c5876-15bc-42d0-66c4-08dca5fcd5bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 01:07:31.5696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pk+XDnlA5DYbiyVJMDHkPxI0eVMPbzm8BsSBCwBS048sCJwth7Hc5ADzT+iCxf2YsVLz1JGZORcJDqVx1naMI+Q+K1BK7LayjMdUFoRlzbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5485
X-Proofpoint-ORIG-GUID: xQAn8S0ltB0miDMFvKz5kpMWAd00leIR
X-Proofpoint-GUID: xQAn8S0ltB0miDMFvKz5kpMWAd00leIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-16_03,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170007



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, July 16, 2024 11:58 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; David
> Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.de>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> Subject: Re: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
>=20
> [External]
>=20
> On Tue, Jul 16, 2024 at 01:50:23AM +0000, Paller, Kim Seer wrote:
> >
> >
> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Tuesday, July 16, 2024 12:18 AM
> > > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > > devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; Davi=
d
> > > Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.de>=
;
> > > Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> <broonie@kernel.org>;
> > > Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> > > <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Hennerich, Michael
> > > <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> > > Subject: Re: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.ya=
ml
> > >
> > > [External]
> > >
> > > On Sun, Jul 14, 2024 at 09:29:58PM +0800, Kim Seer Paller wrote:
> > > > Add documentation for ltc2664.
> > > >
> > > > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > >
> > > IIRC I gave you a reviewed-by on v5, was there a particular reason yo=
u
> didn't
> > > add it?
> >
> > I made changes to the 'output-range-microvolt' logic in v6, which I tho=
ught
> > might require a new review. If your 'Reviewed-by' tag still applies, pl=
ease let
> me know.
>=20
> IIRC what I said was along the lines of "with the logic from the
> previous version, Reviewed-by: Conor Dooley <conor.dooley@microchip.com>"=
.
> Is that what you did?

Yes. Additionally, considering Krzysztof's recent comment about the mixed=20
indentation in the example section, should I send a new patch version that
includes this indentation fix along with adding your Reviewed-by tag?



