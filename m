Return-Path: <linux-iio+bounces-6907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D82916D82
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EAF4B21C76
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041DC16FF55;
	Tue, 25 Jun 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nwvs7Q2q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23016FF33;
	Tue, 25 Jun 2024 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330748; cv=fail; b=uQFlGdy1qS/+V0YWEfUM7+hLYxFOOttmgIpJXOx3lzB7KYfzOpADI+m4qBsbbLzTiogEbo9qTnT/isRfMIFhYnB2WTu3wNNW98eGYNDgoKDe7GkxYTTGBJnfqW1EfWjVly3o34NloEDUsfTIZOwi5hJ8bHA8e7+HSO1Mj69AemM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330748; c=relaxed/simple;
	bh=GkxSmz9WrdgLeBPcxGvZp5C9tKVHOwA5IX2guhWBvrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tTaK0vm3F9rNf50J7VYujk37c9qMM0DPGHmwxBDD0Gy19e7QyKUkG7UPHILIcB7t/AFNMYQb0e4YqLFfXTFT7IncFedmvWaUlW32PnF2K2UuONvqcLl3qXWmOPC89uItHKBtnKRMHIvmJMJKFaxhDxMQ0znYZu/rjT4awDdVIwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nwvs7Q2q; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PFnB4Y000313;
	Tue, 25 Jun 2024 11:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GxfcG
	hAdrkv5AGxr3WAiLouq14u5ZNBgeUmFWOzUzHw=; b=nwvs7Q2qAe5ralyCulW5r
	nX0zTLH345OIP9LO1XaPnUN+YZ2c9BJkTDwniwa5pokKQauowkvGxexJk+Fc05Oh
	y+GAdfuoyUQVM8EwpDLCgFMqYlrHs1IYii45rH+zhT7Pe49JxXL85L3bNVTM29NG
	se/p7xPBuo3F0KEYskXbM7C62bMOsgcZ8YfX2Im7N6Br34T+eBTnXHxUfzaevQUN
	AFR6Lju2vPHp5Sg9+O2Y2oHUia6xmfrADWYnJJGS2OP2k92zjeWnW2eAGPri5BoA
	O5K4S5c6cYGyPiP/acerEXWeBUs8577M4jHfPLCSWQwV4+HOiQzC8pdD+6tF6AiO
	Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ywuh2k5xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 11:52:04 -0400 (EDT)
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45PFpxvt023116;
	Tue, 25 Jun 2024 11:51:59 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ywuh2k5ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 11:51:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQtifTL/oiEBeSeDcGzJQPC2ibb6h36tE3QBIDmJlkcx01DVy2uDN55OCQBU5tv+b5G25Amb+AXLMKSNOX/05RjHcxshZLD+8bFdN44IH23oIhekpQXmWslAwImneHWWCjU/rFWaATekuCV5JLcY9bzSTI0eftBqEWOV7GbtkihO24u5FmqGngQouWIfGyMHP5rUOJF9NtCPBwkpBVstiJTcrpn08Oaq88oMvSUTkBkTPAcY8dSuUfIk8e+GmwAmMIdaXVhdjfVpgOjvL54YTNGNNvYRKwFtlDECXpa+Wr3+AJPrQgjPjwwNgxz0ojVabzQSuqQF1TGNj9nRWyZ8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxfcGhAdrkv5AGxr3WAiLouq14u5ZNBgeUmFWOzUzHw=;
 b=hqnTHltwAWFRIQt4nkLUcop5KvNouKiWKmliae+47SKvgVud8491is+a6DByitocuPZG2WZ6jfMuMDyTCQxHcHx1lkC1JTql8xnc7TvvAu652b7qDBa/TDUz2IRLH6yA8jVe0452++4ah6elrNsx9DJcNdCPFeaQFBVk4GIjiPxB7ltXi9IMfJhZgoEpHwsNzZM99LvAYJiInzgXFWQ12Fp8izBQv9b1/44iACo8gKsFq66jNogQQRhCYWo6DBfVfTqaBWE8dMwadYFK1emizMObG69RIHHvmSbHM+AWlvzzpg5S4pV6xFon9MHn49vDZ9HZvlSf/VNILmKMlPWz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SA1PR03MB7031.namprd03.prod.outlook.com (2603:10b6:806:337::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:51:27 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:51:27 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Conor Dooley
	<conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Thread-Topic: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Thread-Index: 
 AQHawhTpX5siFTyTZ0ST+He5gHIvWbHPYEeAgAYCRICAAa6KMIAAGsMAgAAKeYCAAXQBYA==
Date: Tue, 25 Jun 2024 15:51:27 +0000
Message-ID: 
 <PH0PR03MB7141EE1309B35372201A6A80F9D52@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
	<20240619064904.73832-5-kimseer.paller@analog.com>
	<20240619-vanity-crowd-24d93dda47b8@spud>
	<20240623144339.6a5087cf@jic23-huawei>
	<PH0PR03MB71419D55571B07479B4F4FB8F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
	<20240624-untracked-molasses-31e8769dddd3@spud>
 <20240624183753.0000218c@Huawei.com>
In-Reply-To: <20240624183753.0000218c@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1jNTJiN2M4NS0zMzBhLTExZWYtYWFmNS?=
 =?iso-8859-1?Q?1mOGU0M2IzM2Q2NmVcYW1lLXRlc3RcYzUyYjdjODctMzMwYS0xMWVmLWFh?=
 =?iso-8859-1?Q?ZjUtZjhlNDNiMzNkNjZlYm9keS50eHQiIHN6PSI4Njk0IiB0PSIxMzM2Mz?=
 =?iso-8859-1?Q?gwNDI4NDAyMjU0MzEiIGg9IjcwR3VqNzEyaUhMM3F6SE1TRXE3YjZlTzBi?=
 =?iso-8859-1?Q?VT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBQ1hWdmlIRjhmYUFSMldnQktBNEFuckhaYUFFb0RnQ2Vz?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SA1PR03MB7031:EE_
x-ms-office365-filtering-correlation-id: d2dda2ee-9fd1-4a88-c8f8-08dc952eacb2
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230038|1800799022|366014|7416012|376012|38070700016;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?gzX4ipvkS2Gfcn/59fJa0VI17EjffqUyhr6f/go7pn3vtA74UHXZDDid2B?=
 =?iso-8859-1?Q?S5yXlzFCvIYl6ZXnJfu322uEiX9KOrBrwgTa19ChcY2TCxeIGbdXOEgDDQ?=
 =?iso-8859-1?Q?NKNqcW56fA1PoovCX34/OGq4RbYku9UU/AYubnzNZno39mJSGYPNGEAObH?=
 =?iso-8859-1?Q?YlXbQ8MvHv4u6eRab40zeyz/aV1/xTu4YMhMzZK6w59CbITbNeTq/ic/ji?=
 =?iso-8859-1?Q?1daJtt2qFDnh6lJJvAyePdX910H1b2rSR2LrHcxA9aTpaR1KQNhateYJBd?=
 =?iso-8859-1?Q?N1KxSVoL7eHFE9yju4WOf0jUHDfD+kg9XvAe5Z7N8G3pu3yIH2uzHKjDxl?=
 =?iso-8859-1?Q?31POtt6GdFmzw9pcSFpHjrGTeIVftXRnWNDTKG6L3EmSRsE3JeJjnbzok3?=
 =?iso-8859-1?Q?Xg8FVRnChuMwlrA3FvL6l2zPs4kjNJR9yN9c8MorYCeG0dKR4ds/zC6LLm?=
 =?iso-8859-1?Q?8JPvWkA2+0tnu/Y2D5zOSZjLlBfal0Lkq7blbwpB4eeCrP9IYlYbKd1siq?=
 =?iso-8859-1?Q?zSqDBixzpRAF9JC3cxFxMCEmyBgkFyx/DvqnvJR1Pa+W1xHnmz2ZgQaR8W?=
 =?iso-8859-1?Q?QsfELcI0jKwtvjVaPH7boXJylIgGunNqJMK/Uqj8lX0lge+gkGAgEDNUEw?=
 =?iso-8859-1?Q?qQiaLj4NGMefFrqZ6NyTzKmclzW7LvHMZiB8+8v+suTuXWCyw6sqn5YYeD?=
 =?iso-8859-1?Q?4+5tDgJyo2xkfZJvLhUGxnVTKFlBcvFVILu92nIMMsJifJ7gDHidP/50G9?=
 =?iso-8859-1?Q?1Cskh6ZUvW8Zm1qLHpVPHZzYFHq6cMtY0g5gPlycroAE1V+WlQ9esiDram?=
 =?iso-8859-1?Q?vVQzH+Dz9ZdVIvagUvHrj7gtLubKJtpv27bIi2WMnHgM/FbNND09skwqNY?=
 =?iso-8859-1?Q?iSzrW1N/wtvO8bsw4s8QGlbSexVaY8VsGNGucTm35SYtEhStoNfr/3olI5?=
 =?iso-8859-1?Q?6ovH9YKvGSCv+b8cEX+kxBzHZZDkPqnap4H+u5M0SK6+ldUbqeSrjmbcAB?=
 =?iso-8859-1?Q?35oSqwZBfKzwxkmnl9apCSNm5oQX9pl1V1nzhn36P7fm1c7zzU1pttz70I?=
 =?iso-8859-1?Q?+T8ai4eITG1MFl0JIhRW/fHMOXEUCiSCGAta8ygxr556RiFSC0KhZdXpC8?=
 =?iso-8859-1?Q?mmsLY8Rxi3+w4MUQ3jPgE+0ls8pYLR7LsthDe0zp0nJkigUyvBepCiaG89?=
 =?iso-8859-1?Q?nB8azz+X7apUG+m5NQ658yx96SKXzniiBGjmtLimd1PLRD3KVm9Iof5wMC?=
 =?iso-8859-1?Q?Kl1JfQGJ5p8vwJC3hbXhyvt6gqwbIPIPE8rkrbXBc1IJzkLrB7/SK2EeGU?=
 =?iso-8859-1?Q?u8yCNDen03Nk0qsyxqvkPlCASG5vxW4gTAtv1UFApZVjfxMcDESv9Mks88?=
 =?iso-8859-1?Q?6+VuukB34PEDpbcBEfvy1Qw7iyYM1J5ukwH9+WmKxmdAYhB1XAxSev6+an?=
 =?iso-8859-1?Q?8SVSMTJBs58X7YKJw3q7S82SvYDpQs+zz0oOVw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?xmkoB/tdvjuiCqKoi2vGQbTF0cpfu2O9bvJRktKGDmCaiyVabLkiEHnbtP?=
 =?iso-8859-1?Q?MLtlb22LT94/gC+/cbEl4s+Sfyx4QWAqaDzDN6CFUDj4WvPPRSi11sz9lU?=
 =?iso-8859-1?Q?AV3jsSjk6N79/qjQKbyGdZsNZwk6VhwpidmFrNoNf5aRP+fFAvyPmHg0wh?=
 =?iso-8859-1?Q?NjIUznWSomt1ZFWAd6ssSpBW5LREAuoU0MSr85rfoqSraBduhiv4GNYl2H?=
 =?iso-8859-1?Q?h/J3fMau6G+AR7qlBr6wqvc4TnmbVVLxASxD3FuM1kxH3ZHvU6eLEG77Qp?=
 =?iso-8859-1?Q?cRzLXtyg/4vYah4qvu5n/AVX1aOql53U0+NtldF2hooGVzyz1ejv/QeirC?=
 =?iso-8859-1?Q?/HH9i8/JqWNH3k2owOClSThCyb0k1hPEfoLGweQSh2aa+EkIPowdDgdcHG?=
 =?iso-8859-1?Q?ejBXDHfm/MYREbjhi5P8ejXacuyNUvrOMUkBp03TmMrTKbD1MRBB6VcBIh?=
 =?iso-8859-1?Q?cgw9+TgnFC6Dsikocmm9xU40jdWuw09Sse7nbGuHdf4hOfxo82bX1ngfie?=
 =?iso-8859-1?Q?Mpkp7Osh6XsJ3EH4aE5Xbz93QxptGeAB7vqbnSZ+AVKBKb1khx4MjyXtqp?=
 =?iso-8859-1?Q?hXq7KeXPX1FmiBuG+YXQTJ6fUhruOSfUzIkV43fei7rG5+0x0AaaHa3eRq?=
 =?iso-8859-1?Q?CfR5cwyxlrTW3GPaOMWcGGHsvbEJ44hB8yStl9xHEa3WPlhA48qInPcJqG?=
 =?iso-8859-1?Q?YIq/lT5hziYLtQmEtOH4mlNyEoAz0W3YKXwCYybogrFtUlyiKl7Zh/RKt6?=
 =?iso-8859-1?Q?Ei6413YdZmLC/+7qI9yxt/QJVHHbiTpmuZRk96MnY3F4apOFmekRu9XNz1?=
 =?iso-8859-1?Q?CcMoEuc/I34MjtZ4v35aYX5fiROJmOtqJPpiQeh6haHRm4ymase65gBz6E?=
 =?iso-8859-1?Q?osqW454mDCKFs1XIYA7GldrAof1R0/1xkGf6elp/r2SaBO3eAu1y2HonPu?=
 =?iso-8859-1?Q?OLsh1XFaQO35IO9QwfLTdLLIVl16u+RwPl7JUxNIZ611wLjmQCFJgxyUAp?=
 =?iso-8859-1?Q?GaUzItOi0V3cm8/llZnIjL5dCx9QJigygOz2IFb2/xiH2IvB5+n4bnwzi7?=
 =?iso-8859-1?Q?05/HXpC962fiuUZB6jzXrVlLIPhMo35odvxVQ70YBdhdaIOOMWhRuFhDIx?=
 =?iso-8859-1?Q?tqoDok7/YhdaMyxza67ntMA10Ot/NS2meYUT5qj2P1sZyNHELofzjV/5T6?=
 =?iso-8859-1?Q?lmHwb/26rZdJ0X+30jZLkK463A3TTVv6QDEE3ywpSpZX4cWnf9Ot6q1ZJ0?=
 =?iso-8859-1?Q?QodmxtIVta2NOauk162lfznq1PRwPE2F/GzRq03HUt1GImdoft/+DoX7fA?=
 =?iso-8859-1?Q?dA/yZ1DRGqROSvVujOQB5BZjLKa1SdxS8D+GM1yuVIPXkLGI0pXVX4pGzQ?=
 =?iso-8859-1?Q?yfG71PLPtTFXy4ZPH8ncQH5+IvvTfL15RDP5vWT6JfIZRxXbOKmdNRat1t?=
 =?iso-8859-1?Q?1APoGmMdhyvcF1Oli3HaQ25PYOmCNjO2FC2kd+KDLkmm5JDB7xG0LnAK8d?=
 =?iso-8859-1?Q?84TE0FB6chj+Rkw3U0CjD1nhUFxkbC9p9hn3xWvCHWDNXK88ZBZniZpuDB?=
 =?iso-8859-1?Q?jtzv96pXIbBEtFMk/2NJ3p9RioahqmcHGorbG9XQAo6mC9ZitVi5Lua0vf?=
 =?iso-8859-1?Q?cBIoA7UGCxBSOnAVnW7afcLiTbuBtJJAos34SUvmUxIWxYxCWqOi1YfA?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dda2ee-9fd1-4a88-c8f8-08dc952eacb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 15:51:27.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMou3M0JXB27HHEYHLEnM2HvbL73qc6vn1JiuY8FJfEF7tUPJTYzCHWqpn1qt7IWfYWkh3PaHM4L3x36NNH6KFo79vy0JutQn5I8K5QHt3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7031
X-Proofpoint-GUID: tJxeM1pEtWh8mVH9j3olPT6abd4Wr1R3
X-Proofpoint-ORIG-GUID: 7_aXOyyOwx2I3uOwGEaV2ZRixWPWRnRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_11,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250118



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Tuesday, June 25, 2024 1:38 AM
> To: Conor Dooley <conor@kernel.org>
> Cc: Paller, Kim Seer <KimSeer.Paller@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.o=
rg;
> devicetree@vger.kernel.org; David Lechner <dlechner@baylibre.com>; Lars-
> Peter Clausen <lars@metafoo.de>; Liam Girdwood <lgirdwood@gmail.com>;
> Mark Brown <broonie@kernel.org>; Dimitri Fedrau <dima.fedrau@gmail.com>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
>=20
> [External]
>=20
> On Mon, 24 Jun 2024 18:00:24 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Mon, Jun 24, 2024 at 03:26:26PM +0000, Paller, Kim Seer wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Sunday, June 23, 2024 9:44 PM
> > > > To: Conor Dooley <conor@kernel.org>
> > > > Cc: Paller, Kim Seer <KimSeer.Paller@analog.com>; linux-
> > > > kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org;
> > > > David Lechner <dlechner@baylibre.com>; Lars-Peter Clausen
> > > > <lars@metafoo.de>; Liam Girdwood <lgirdwood@gmail.com>; Mark
> Brown
> > > > <broonie@kernel.org>; Dimitri Fedrau <dima.fedrau@gmail.com>;
> Krzysztof
> > > > Kozlowski <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Cono=
r
> > > > Dooley <conor+dt@kernel.org>; Hennerich, Michael
> > > > <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> > > > Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.=
yaml
> > > >
> > > > [External]
> > > >
> > > > On Wed, 19 Jun 2024 18:57:59 +0100
> > > > Conor Dooley <conor@kernel.org> wrote:
> > > >
> > > > > On Wed, Jun 19, 2024 at 02:49:03PM +0800, Kim Seer Paller wrote:
> > > > > > +patternProperties:
> > > > > > +  "^channel@[0-4]$":
> > > > > > +    type: object
> > > > > > +    additionalProperties: false
> > > > > > +
> > > > > > +    properties:
> > > > > > +      reg:
> > > > > > +        description: The channel number representing the DAC o=
utput
> > > > channel.
> > > > > > +        maximum: 4
> > > > > > +
> > > > > > +      adi,toggle-mode:
> > > > > > +        description:
> > > > > > +          Set the channel as a toggle enabled channel. Toggle =
operation
> > > > enables
> > > > > > +          fast switching of a DAC output between two different=
 DAC
> codes
> > > > without
> > > > > > +          any SPI transaction.
> > > > > > +        type: boolean
> > > > > > +
> > > > > > +      adi,output-range-microamp:
> > > > > > +        description: Specify the channel output full scale ran=
ge.
> > > > > > +        enum: [3125000, 6250000, 12500000, 25000000, 50000000,
> > > > 100000000,
> > > > > > +               200000000, 300000000]
> > > > >
> > > > > IIO folks, is this sort of thing common/likely to exist on other =
DACs?
> > > >
> > > > Fair point. It is probably time to conclude this is at least modera=
tely
> common
> > > > and generalize it - which will need a dac.yaml similar to the one w=
e have
> for
> > > > ADCs in adc/adc.yaml.  That will need to make this a per channel no=
de
> property
> > > > (same as the adc ones).
> > >
> > > Should I proceed with generalizing common DAC properties in this seri=
es
> and does
> >
> > I think so, yes.
>=20
> Yes, that would great.

I was wondering who would be the designated maintainer for new dac.yaml?

> >
> > > this mean somehow removing these common properties from existing DAC
> bindings?
> >
> > I think that that one is up to Jonathan.
>=20
> We can deprecate them.  At somepoint we can remove them form the
> documented bindings
> but we will need to keep them in drivers forever (which won't be costly i=
n this
> case).
>=20
> Jonathan
>=20
> >
> > > > I'd also expect it to always take 2 values. In many cases the first=
 will be 0
> but
> > > > that is fine.
> > > >
> > > > Jonathan
> > >
> >


