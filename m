Return-Path: <linux-iio+bounces-9793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC9987543
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 16:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B1B1F223ED
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377E4137745;
	Thu, 26 Sep 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JFkNxR9c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2E67A0D;
	Thu, 26 Sep 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360100; cv=fail; b=CyF0Qkxgu3Q6NqqCpawixJbM0Jdg0ldkwg0Wh25ZxX9WY/b0VvVOLrt3EaEC7d74N5rp8jVogYLG0cVFoZaHVyH1HqOv0sbWZEeTRnFx+uolZTbsqvvf3uzv6JnvJbFvILsyjq+C9d0VjGWRsdFl620vBEmy5T4Ml9AtZy9Ynvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360100; c=relaxed/simple;
	bh=LZ43wYyGpfHCMuNUGM1p0vfIWIhfuNo3Uj7TBqlwo9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N23HkCgR1457Zenx6MEbTt5iS8Si7oZ5ilPkHZ81qpPIt+BHtU7EH7qL35FlEYWz8vn/lILW5tzb6iIo5tLESssrMtER3OkiPkEIl7JKdVkgmfsZjpofm1nRZ93x/w3d5ZjQUxR0CoLn8xsm7xVkhvD94TIvqOP1HgvpN5gv7Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JFkNxR9c; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q9Puv9002760;
	Thu, 26 Sep 2024 09:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=E/WLX
	g55jKT2sQj59Ase1vq3axtGl/GjhvKAJD6VKuo=; b=JFkNxR9cwUhtDFsDT/cs4
	Jiod3C8tQJPPPJd3rSDKepwLp26WQGIGQdc3rqVdymR14zlt/EUydZ37JAutiNZs
	YJSkA87T1WqQ6GBkxpAjeHsrD25I1yl6ibq39L8Jk7ANQTjc51tz/B8sVdBlTKyz
	gLJaKZes+xFYI9Q4JRmtqMd+wrLeUOTyL14I4pLrzlEW0fjK1xyJEe4oFzVZSfAz
	KD6DCqB+/Lx1H+FJoUt+z83LCFGjjDeRZa/sW/t88+rd0LKm2f7ZT9ikUVTYEfj3
	6Hux+phixzbb5JTVXXF5kuqjteOWtcuyS5BewONRcXpu7z3TAOtbKPrmkUPyRndg
	w==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41w4yr8vay-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 09:42:02 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLOEHjmyX9X/eJMWErG/HK3W9YoVb4GxXA9h6G79ce9JtKAHHl4zE7+IMKk35NfVfA0j3nup/0PHpRttE/yT6frVonjhIhqMNLGrCCmbGfW95aWXTfx1CSjvnNGNa4wbq3l/YtDCpDWtmvTnesW5NoAT49DKLp6e8BfH/CxHnwnSLjXBdolS0R1odm0AGrxfohXob/2SrFfLkfBA+KuO3CxYwRIV4st4D5AeHertngD7+UuFVoiYjeEAOP4QWNrqwi9O1JraEMLT41+6vZyxXKiYEEip53IrAoO/jJ8ihUG+gmsec9JWWTb0YCDS+83+qzZbOpBVnrJl6vuP2N1reQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/WLXg55jKT2sQj59Ase1vq3axtGl/GjhvKAJD6VKuo=;
 b=t3Vwj09yeK/wHucxlextns8HTtzXhBHTQle3hMpUq2mWkMMhr6GfIA81IubhuCumngy7Jl5aSb81PiuNHIlg8bbs0ENOS14I1OHc1EYkvNfDvdd4qGaDEh95uvSvCxfqemZ+sVQxZYMYLwnKyREGsAhzLJSFTOExzbgm43+LU/nBj+P0HORdI02GST5MN2RLGReNscsDwLYogAesdywLuJc6x84ihQAmYSZC2qiiK118SoPUf/jt8FyWoUaz/FdIHsCDX7ueZjjIg5qoP/XkpNgp9Sp7ZdAQzeKX7i9fKViiOQeKvVJhkv2aKNpn/PTk8htyJbKArlD+JiFXYyHSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DM6PR03MB4315.namprd03.prod.outlook.com (2603:10b6:5:101::16)
 by BY5PR03MB5048.namprd03.prod.outlook.com (2603:10b6:a03:1e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 13:41:57 +0000
Received: from DM6PR03MB4315.namprd03.prod.outlook.com
 ([fe80::ce2e:9ae8:e448:2f00]) by DM6PR03MB4315.namprd03.prod.outlook.com
 ([fe80::ce2e:9ae8:e448:2f00%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 13:41:57 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Tanislav, Cosmin"
	<Cosmin.Tanislav@analog.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Ivan Mikhaylov
	<fr0st61te@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Thread-Topic: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Thread-Index: AQHbBQ9UZ8Eg5c7ZH02X3bsabDe+u7JXhtkAgBKfBtA=
Date: Thu, 26 Sep 2024 13:41:57 +0000
Message-ID:
 <DM6PR03MB4315306944DE2E5E8CD3B236F36A2@DM6PR03MB4315.namprd03.prod.outlook.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
	<20240912121609.13438-4-ramona.nechita@analog.com>
 <20240914180648.592cd69e@jic23-huawei>
In-Reply-To: <20240914180648.592cd69e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHJu?=
 =?us-ascii?Q?ZWNoaXRhXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVl?=
 =?us-ascii?Q?ZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTYyNjk0ZGYtN2MwZC0xMWVmLWJi?=
 =?us-ascii?Q?NGQtM2NlOWY3NDc1YjhlXGFtZS10ZXN0XDE2MjY5NGUxLTdjMGQtMTFlZi1i?=
 =?us-ascii?Q?YjRkLTNjZTlmNzQ3NWI4ZWJvZHkudHh0IiBzej0iNDcyOCIgdD0iMTMzNzE4?=
 =?us-ascii?Q?MzE3MTQxODAwOTUxIiBoPSJiM3NBLzhCSmdScnpCRFZwS1Ewak9ncGJBekU9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFEZ0RBQUQzTnpQWkdSRGJBUWJ5WXprTG9wcXNCdkpqT1F1aW1xd0RBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFTZ0lBQU80QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQTNMaFNmZ0FBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dC?=
 =?us-ascii?Q?bEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tB?=
 =?us-ascii?Q?WlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJm?=
 =?us-ascii?Q?QUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBTzRB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQXpnQUFB?=
 =?us-ascii?Q?QU1BQUFCT0FBQUFBQUFBQUdFQVpBQnBBRjhB?=
x-dg-refone:
 Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR03MB4315:EE_|BY5PR03MB5048:EE_
x-ms-office365-filtering-correlation-id: 3201ad52-0025-42ec-9a7f-08dcde30fdb4
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gqb1XiUzfVoFVOX4QnyRmPZXgluYUCUpK6QqZfJEV7i8tcy+rLgxjx3CX++m?=
 =?us-ascii?Q?oU/O7OGWfr1VhecAoF6SOmuvYT8SmipIBe7fO6tU9HZ4USSaWWwgJqONUQab?=
 =?us-ascii?Q?pTwZ6oDxS0w4KOy3E+ToInpN4Bve/EY49W94D2Os4E3sJcfmECKTDSecJrIl?=
 =?us-ascii?Q?sUa4cCaEGrcfjGQIzPyYG4HX69d/wbYAFXVIntBD8NFYl/n1vzSJ+gj9T2gI?=
 =?us-ascii?Q?iwqWeoK3D13MrMB+BhoaoWfMuabQ/3k1qp/2kd0EZM2NaeUSTMUAGnr/pAza?=
 =?us-ascii?Q?6ShM2eGgbWlXiu/q3PHqpxqD82dShZ2jG3wIBSbWfC2u0UgKqDgCcOOMt95F?=
 =?us-ascii?Q?wpKruIijYsp5qet22cfOq73UU06AGbnZ4Vny4l4eBfexuBcTuVltjIHmaelA?=
 =?us-ascii?Q?xV0Gl1SerbyVIZf9GkkQer5Y/Ww+5xXz71jitPwvRmyqIm55CMBwlN6oOj/7?=
 =?us-ascii?Q?R5Z+jgRTZl75yGlouSr4vo2byjraySNa8PG+GULfmFYsGQO6OYfkB5wcCx/g?=
 =?us-ascii?Q?MGXW9yLfC09kHmUTFrVomNOmjmXFGmCy2TglkX0uGmJeS6g6CFMUfyUUdyEa?=
 =?us-ascii?Q?NjaiTQqwdD01KQt1aHF77+wcvmpWBWtlT0XqT0Sic8PCppoeLpjH2fyAdk35?=
 =?us-ascii?Q?i7ip9+r+LahCpxWcBvJpj4VJ7WhO+LSqjO36ybVu9xOB6w2wi4kNfiBvhN/8?=
 =?us-ascii?Q?+JFGVS665Qg+qkcPVRMzshdxB58sPEdid+huDnUa4v9MxqhLMbofMD6qndwc?=
 =?us-ascii?Q?hL0onVd8bwBIscJdzmNnzHZJraEBaxImBCdeLb/BxXEP2yauWfAESIDlcZAL?=
 =?us-ascii?Q?jWXqW403CZ9q+7+O8/Yw0BcO7vpDALjOPxKfVYoDrWz8wfkr4HeLOMUHY2Tj?=
 =?us-ascii?Q?pmCa4I/zlL264X3bLLXj4vPrWVJqM8AsG9DDPcEG6zcg1szAkx3+a60EfoDq?=
 =?us-ascii?Q?6xGBUFgY68zzNr81jz5K/ArDqmSPvEt7HjBv3mOVYfWDIv3/KzuGJWmaJcma?=
 =?us-ascii?Q?XspzH6XruVXynu81Esv6mZeIa5VEka/umQaFj2FT1wFZaFmf1rf7lirnWY+N?=
 =?us-ascii?Q?XB4yaq8xi5Yl7dOVil/r378gSClLhxUl/6PoiNlyuopls4qKIWE+xWRypIqO?=
 =?us-ascii?Q?QAMSm/jEsay13xLw3J3GOSlRipDL8MvN39rl9ztIb8EFtd4E/ofNqhdYU7wE?=
 =?us-ascii?Q?bKzzugn7WAggN4Cn9PiZeVJ36lR40YxboqXe4X0uRM5sI06OrEUMa76kMkCD?=
 =?us-ascii?Q?JSNaTR3EurVrr09czwATkvtMSuzhp8srAwTVIw9y0hd4gICnpX3rb2R/FjnA?=
 =?us-ascii?Q?CUOe9Tr/jWaMsynEa0IGYr/0AcqNb0DrLxnPMclIvBlvxxHBXIBqkAMyTMox?=
 =?us-ascii?Q?Ct/FOX3G2FHai9+b2V4QJuLgfWvxayXBhozvNPOverVE+kt7+w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4315.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mrc/Uv9KczVdDQS0XIOwRTmbVyX82Mvvdl7PAw9XslXJGb15RHSrdXCFMVcT?=
 =?us-ascii?Q?fC+0hokSiF2q7F8rJLg3vec48BhOMMoLkIGiTP/SuKxSwbo5JrvM3LLgHzXz?=
 =?us-ascii?Q?gu76NKV1m/iftRvOLnB1rQMK0LUJzkPQqZhD57awERUjGDUA5AiL64H8RrC9?=
 =?us-ascii?Q?cL9qskUME0hTTBAuRD0iBjtu63lUhO9umlN1eXPFybjaZMl7ggUzLH9fO8Fn?=
 =?us-ascii?Q?PlA+/QB2Frr2P2SYX2YNQPaKrqOz6x/hau+MP8dRCmgAyDR9UI2P7bCZO2Xf?=
 =?us-ascii?Q?vOytsHbfZosWK410F9roDzJ77ZJqp2qk2pbHNyA80Q9uBhhOBhb/PBquFw8l?=
 =?us-ascii?Q?17vFTVPzQlya3Fk7gpJBtOEdyAIAbeB+3qweBxS8BpUnE30ntEW3z6hjqI5q?=
 =?us-ascii?Q?dTcZJ90pIsybYu9sc/3z0QczHx3mvBJ5yLICDrd0xaY5TYmPH5pA527TyBb+?=
 =?us-ascii?Q?FMxOI9DHgjs1MpTeJa9Cduz22ntKfkkWRcycW+1ZJe2wDLv/6g7E0qvsp1Th?=
 =?us-ascii?Q?2rQuma+ByWb3g/WYvrJgKebUWCD19DzK8+ol6UxzEDGGQDVq3IR0JYnTH5/6?=
 =?us-ascii?Q?HfKMiO74urZh9J1lVDegdVpSV30LwWzgowtCsuKex8qwufmiHbfERk7uNT/k?=
 =?us-ascii?Q?mX7XzWJ3cIKYGwV8BkHZ4BTtnLhyjQ5tOsWqOCIE+UpKTSYqagmPcMN4lRf3?=
 =?us-ascii?Q?50QQOFZ3q+mzMFFfOheJYm0ZNzMaRJ6atjICXA+ZPhqH4JgxhmtM+Jgsy/oS?=
 =?us-ascii?Q?zE0yo3bwnC4HLY7TGKBlL/aRHMrS5C+MxJVhKQRQkH48baJaqvNf6BjPkxDr?=
 =?us-ascii?Q?OBftxqtxEiFxDXcN5rRNy5w6lMkT6/87nI9e2KhA8bIbCqRFr5OwqmJUTDXE?=
 =?us-ascii?Q?G3GG+ao1UeB5ON2Rgp7ojSxTk+rfoRdAi/I+1s34iqvL4MpslsWBxoQYT5Mx?=
 =?us-ascii?Q?xoRZ1KEJf2fjbOLEcW1UwxQk1kAV7+FBrUhFXTKyYk8ykjl/OwqJwpG3wxvU?=
 =?us-ascii?Q?HQZRzHWZ/5mfIqvltRNHUEMP7Ty+2yCN/ARPtRO8t5e13CHoVcec3bv7bV61?=
 =?us-ascii?Q?4zlWNuJjxL8UEM5aBnjF3g6rbAbpQUeXFVWlxycgD0yWfPe50Z3pXfQophXt?=
 =?us-ascii?Q?x73t2rZAGV2S5PCst7uCHeZxZnQdY10nuyBxEU38c3GjCvXzleCgDAB2Uw7L?=
 =?us-ascii?Q?xjBCYEkm0MBG/1b2uUQRf0vf/cPkVtEcX1qiQKY7sBx168Z9paYjMK4CMJCZ?=
 =?us-ascii?Q?IuC7qhysiuo12yit2Vmo1VAspCNtf9v3KlAIrAHi6jEVjiCWign2T51IlMta?=
 =?us-ascii?Q?gFmupm1de+ivnksivExLztVyt5t4x4wFuFBzelyA9udDefYzVIe7k3HmRkux?=
 =?us-ascii?Q?qs6Mra8lf3pjC94E+kCFpvlMx5J44Jb2B3kdogSbVMBCai1Pjzf/UgY0fsnf?=
 =?us-ascii?Q?LsVa/ZmOl/7IJbsCgb8n3GkdIBhlAkuwc3TQ0rIrLKR1OCYlbEYZAv4oox2R?=
 =?us-ascii?Q?dtRxQmFfUYgnIzJQF0mlEXn95xWUlwlSR3qTT9jc52xXh8q68TaDk+QKMiut?=
 =?us-ascii?Q?/XhIJmqM5kLe90QvjPhUjFEUP0GAAgMGgx2qj6y7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3201ad52-0025-42ec-9a7f-08dcde30fdb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 13:41:57.5903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMFqmKUZKdZCHKNVzEJzNBZ7PRivgz4Ux+khmHqqOZG/Fku/v4JIcCtI1CtpwY/clK5OvnLGldZuNs1N2pLAuVOt24BlR/AUFdOkAVJdNpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5048
X-Proofpoint-ORIG-GUID: 9vpOMtAnvCODCYPhV8i8KU5e-BGf0Ofq
X-Proofpoint-GUID: 9vpOMtAnvCODCYPhV8i8KU5e-BGf0Ofq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260094

Hello all,

There is another thing that I forgot to mention inline with my last email.

> Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of=20
> sending out data both on DOUT lines interface,as on the SDO line.
> The driver currently implements only the SDO data streaming mode. SPI=20
> communication is used alternatively for accessing registers and=20
> streaming data. Register access are protected by crc8.
>=20
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Hi Ramona,

....

>> +static int ad7779_probe(struct spi_device *spi) {
>> +	struct iio_dev *indio_dev;
>> +	struct ad7779_state *st;
>> +	struct gpio_desc *reset_gpio, *start_gpio;
>> +	int ret;
>> +
>> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	st =3D iio_priv(indio_dev);
>> +
>> +	st->mclk =3D devm_clk_get_enabled(&spi->dev, "mclk");
>> +	if (IS_ERR(st->mclk))
>> +		return PTR_ERR(st->mclk);
>> +
>> +	if (!spi->irq)
>> +		return dev_err_probe(&spi->dev, ret,
>> +				     "DRDY irq not present\n");
>> +
>> +	reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_L=
OW);
>> +	if (IS_ERR(reset_gpio))
>> +		return PTR_ERR(reset_gpio);
>> +
>> +	start_gpio =3D devm_gpiod_get(&spi->dev, "start", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(start_gpio))
>> +		return PTR_ERR(start_gpio);
>> +
>> +	crc8_populate_msb(ad7779_crc8_table, AD7779_CRC8_POLY);
>> +	st->spi =3D spi;
>> +
>> +	st->chip_info =3D spi_get_device_match_data(spi);
>> +	if (!st->chip_info)
>> +		return -ENODEV;
>> +
>> +	ret =3D ad7779_reset(indio_dev, reset_gpio);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ad7779_powerup(st, start_gpio);
>> +	if (ret)
>> +		return ret;
>What powers the device down again if we hit an error?
>
>Probably need a devm_add_action_or_reset() or if it self powers down may a=
 comment on that.

In the powerup function there are only some register writes and the start g=
pio is only a synchronization pulse (perhaps the name powerup is not very a=
ppropriate),=20
would an action or reset be necessary in this case? Since the regulators ar=
e not used in the driver, should there be a function disabling them anyway?


Best Regards,
Ramona


