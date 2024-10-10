Return-Path: <linux-iio+bounces-10392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBA1998A57
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 16:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAD11C24302
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD481E9077;
	Thu, 10 Oct 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TuQUNCre"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DF1CCEE3;
	Thu, 10 Oct 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570992; cv=fail; b=k8jQ3V52/Ow3Q87vdygRXtaNL9z/WHvJlV/PctKAzAubMSh1NX21ja3QRL2hmEt5glBBAYkx7QH75W9qvSf07zAv3EYTd7QyNYFePQ269nY09Wc+yCua62IJdhFCMk/B5pYa2gZRhxxL+GmM8tQIKvN8nloPGFhn3FZ+3Lqrq1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570992; c=relaxed/simple;
	bh=Q4/uiOGe9AA5hP/FwMu6f8QA5KEIDixzqZ/TnRbclmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dt7kSj66tJrSs3J2rOqQ0zVAGehxOV2ty7Dpo2ZHLp00WT3Tn4jQOmaNQFyZPm4pcIQAEwf57a2YU6Apjj/Nb5OmQih/1Mo93pDnYDB80JU5KlQwgj/UlYi3Fhg5am9nmzdeChcF9UsWNnoa0MMRivFpxvedJx/lDZK5SOiYdWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TuQUNCre; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ADmS3U026544;
	Thu, 10 Oct 2024 10:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jCz5p
	rh1i9IK00vZTEsUU3wel8f+gbvccqp8D+1q24I=; b=TuQUNCrecSWrj6TQXZzS0
	6AQAavDb+vkPK6Qn0HptJCZM5YcIPg4aF7mZeE1JfUYMi8jFVgclRWOCwPzEytzj
	m4IiI8Qy5kDp4/mBBLOJLfXyfG9sAWEY+ZmlNiXTqKWKVmytu3OWQc0XVtc7IHM4
	+ffEQ/RlQk6FmFBnPldykYEdA+63KRfvt7kelTp5nNzZjKzZB2DJD1rS9YD0y5fC
	cOWh4ifWYdldAOJUPBQgyL84oGICCwLPd8MfKN/C1WFjnQpIUAW7NefDha1x3oly
	WgUTbd5eabOpZk60FE8dBNZh9/+bAksjJAKfmE209+etYZXoAoUmfQWSPyiC921U
	A==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 426b991bav-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 10:35:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sK4u41WraOiTOlTO/zIuA8nooqFgmm378+pyMOrEHmhgDGxMfXbBuHxueytJNpNbuOETxKy8XQ7ym24Tjlk0LZOtgT6b4xp6YCRCDUb5i4d8wOzZt7yk9FBO9RLOwllXchfhZGRYAn332ngJxTa+KDq8iATNrat59z7oTTDdvrGZ1e5vEIpbUo8X1vGRbhKqLkegFm/6jpOa2SLcIuCUfZx6qtTy9ilr42lsBhd1MQB5YIRjs3AqYgQxNk80OIw1owbDGwupEKXsdA12OQtiuBl6z8z9gYfZBbIw0NMlHYtjZBtSMuUBoh6gQjiBb7T2NkrjF0zfyqOXRfyKas2GCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCz5prh1i9IK00vZTEsUU3wel8f+gbvccqp8D+1q24I=;
 b=SKWPxRnSjscPlK1ynmy/GI5emBxFjBgmQHsRc8x7rA5SJEZccrSAXm71BZ8flwBhduydk5T8AOpSsxHj9qGmUzpKmEyKm1nybaRFihUX7dpft7E4FhxvHLbVFbu0GD6wp8r/V1LhF4rQKwbJgR/vP4624TAeJecAa7msijKzmm7jP6oiVtiQNQklUla/SjT47CCDEtyNNa/Gklk7aeiZd5y2ecLA/HinxlHw4p0SlC5ocYt3Ti/9d8Nw45I5USp3lWpygopNdvXO2wP4sTpx02OpWRCjjVYV5xclQMnTUQPDGZWBtMYt/SM919rK7RwwdASB9zuuMtAHCyeaERNP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DM6PR03MB4315.namprd03.prod.outlook.com (2603:10b6:5:101::16)
 by IA3PR03MB7665.namprd03.prod.outlook.com (2603:10b6:208:50c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 14:35:52 +0000
Received: from DM6PR03MB4315.namprd03.prod.outlook.com
 ([fe80::ce2e:9ae8:e448:2f00]) by DM6PR03MB4315.namprd03.prod.outlook.com
 ([fe80::ce2e:9ae8:e448:2f00%3]) with mapi id 15.20.8005.020; Thu, 10 Oct 2024
 14:35:52 +0000
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
Thread-Index: AQHbBQ9UZ8Eg5c7ZH02X3bsabDe+u7JXhtkAgBKfBtCAAzYggIAS3Isg
Date: Thu, 10 Oct 2024 14:35:52 +0000
Message-ID:
 <DM6PR03MB4315A13F69DE8B4EFB4030E3F3782@DM6PR03MB4315.namprd03.prod.outlook.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
	<20240912121609.13438-4-ramona.nechita@analog.com>
	<20240914180648.592cd69e@jic23-huawei>
	<DM6PR03MB4315306944DE2E5E8CD3B236F36A2@DM6PR03MB4315.namprd03.prod.outlook.com>
 <20240928153109.52ff4c5e@jic23-huawei>
In-Reply-To: <20240928153109.52ff4c5e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHJu?=
 =?us-ascii?Q?ZWNoaXRhXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVl?=
 =?us-ascii?Q?ZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjBmYWU2NzItODcxNC0xMWVmLWJi?=
 =?us-ascii?Q?NTUtM2NlOWY3NDc1YjhlXGFtZS10ZXN0XGYwZmFlNjc0LTg3MTQtMTFlZi1i?=
 =?us-ascii?Q?YjU1LTNjZTlmNzQ3NWI4ZWJvZHkudHh0IiBzej0iMjQ2NCIgdD0iMTMzNzMw?=
 =?us-ascii?Q?NDQ1NDk4NjgxODkyIiBoPSJGOWpHUHdxcVNzRjJkZTBxUEJwdk90QTl5RnM9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFEZ0RBQUFraXBxeklSdmJBUkNaVHJaRWlYbklFSmxPdGtTSmVjZ0RBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFTZ0lBQU80QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQWZweWNXZ0FBQUFBQUFBQUFBQUFBQUo0QUFB?=
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
x-ms-traffictypediagnostic: DM6PR03MB4315:EE_|IA3PR03MB7665:EE_
x-ms-office365-filtering-correlation-id: 3d907787-747c-4201-c677-08dce938d773
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CXDdQfuqpbeJ4eKisF+ver78+1On9w3CyTaMZzNv5JXFE/5znSxAAxCRA+1b?=
 =?us-ascii?Q?veADdShfWUotdgryZuhTPGLaB30YuM+hQIpSk6qNaNNZezRj2+m4OF3Ttf9t?=
 =?us-ascii?Q?Y8LcW+DYUqMIZc3L0Eke725FUBH84nd2zTEGHZzMWxpMEUbR72omqWVsMF3X?=
 =?us-ascii?Q?yY33IpS4qPOEf0rbGYT0v+KV7aH1sUZELK1YCpIio+Igcmqa4GSL7f1E19sB?=
 =?us-ascii?Q?6lK3joqETsQK4PGfs5TTEL04noOGHCGHT8oygCXzc9hkuo4fQImLNKAyVtbH?=
 =?us-ascii?Q?Q9PKmEeJw+PMhxCcCEynlarmUgYIcYxTgbBmGxE/AwelMim3931oHuELbM3b?=
 =?us-ascii?Q?kZV3IafxxbVf2R5v+NWTD/IBa8xzMFSMMN9OreBVIXmvsxI3ienv/Y/u0gUu?=
 =?us-ascii?Q?yPVfG/Plh4dOAmN+WBRoQMq5feoHcvMZ6S5Ct71fKu6L1ljJ6rBj3zDJYSDb?=
 =?us-ascii?Q?pizyX1/Yv47Vn90OGhga/HEPQ2IuBiPMmXw98QbFaG6FqUXb/Vv20WNC649W?=
 =?us-ascii?Q?osDH88cTZO/ykVY7ZxreppYySwqSaNltpBvaRAPcZOcBSE58paWjPdvwhV/2?=
 =?us-ascii?Q?ZvGMGf0JmR+pN8iUIiA3NEKhuhBEuxbiW9/hk2nUbxU9b2F0atCXMS1zyAT/?=
 =?us-ascii?Q?4ljiATc9yGfVq3x2qmqeZ9JkTTMz04bXgF2WroYbkYbQhF0tZ3jcitmgpgOi?=
 =?us-ascii?Q?SHOa9wtXDAa4ML/PliqimwAslYw9NlQkaUCuD6LwMsSa16AE3oGZGg+PdRUm?=
 =?us-ascii?Q?EDpSOfsrZ3V/iStGlzka+dCneT29om8aKtnqLc3WQuJwDP/b8M7w+LnYnY9i?=
 =?us-ascii?Q?9hsPCV+3/q4G0CdpJwHKUlAeCqMsCZJ6hZG8F/3SlOt1SsTMWDIjP0agcuub?=
 =?us-ascii?Q?0rZ6Wxga2y0Fvwrd8jruG0C8sLyijqc6ePxOfa/3UGfZrdbHffDOYurBg/Uj?=
 =?us-ascii?Q?q4Cs8x78q+yvmOxpztjiUNVGsjOWGeutXXM7CHi3w1FR5A2JMu2L+rGAYrmO?=
 =?us-ascii?Q?kgbzjeKHUjvs7jTDDbNDXSXA8aEas/507SSK4D5eBjoj3fC3pV8ULIB/dh66?=
 =?us-ascii?Q?+cieW5HASChUDbFgTfkqzLznyCdu0hMr7TV/Eb+8DRLTPd9Vi0P4D8odK18p?=
 =?us-ascii?Q?NR7/HLc0yEZvV3OOvkk+Ux5EpyHpcWAK7ZjJt3SjCJPho25o+uUhZHYKBiR8?=
 =?us-ascii?Q?ItfXM5dNzzMo30C2Vli5Fr8+1FW6KyWqmKEtIH/dMraLzTibNDIFIk6zG8T4?=
 =?us-ascii?Q?cpq6GPfw0knRqesPmQDiW6Pn9PiSVxMkCAq6nSZ7BzpsGTqwbQin94S+iVWT?=
 =?us-ascii?Q?pZcuzFK7brwUp10OSD1ZYnHZTyJrmJsp4rMDpxRg0jhDGw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4315.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0tFQyhkUEHTRfNb3pH0A5ZwPxewGIW3YDW2/HeCw3ibPF+TyDarzcyAADqjH?=
 =?us-ascii?Q?BnHALXh5iIG0FaM+/CrVRwF0u8dY51OjXQkgCAb9YzgCq86z5LNCLiCRFLn3?=
 =?us-ascii?Q?cgOoML9Y78MwJ5yNlQqlbVLpVujSyzcXTaKB0ozymJqNhPwnaJbtEHIGKJRQ?=
 =?us-ascii?Q?Oxu5lS3sdrl8vFjmIIcsMJrXNMZuwsikz+5+EVvPRao1T3XnoAeFJ7bwuQgF?=
 =?us-ascii?Q?bClQoQ7rJwnYySSSkwVdZFp9dWl0eEfs41ocTEtME/JrgDjWNx/0mR9LZkfb?=
 =?us-ascii?Q?1lvzU7UccVJwvawx4sMkV44ZPSuuYZiSo4CWw5quQGuwGPwb9/xbBgdqbKN3?=
 =?us-ascii?Q?1oXiFqRjR7AKjqXMmmVxHq2OzmC/TxmtpeP6/0t6O5pOZaM9cmqRlf1qfT/j?=
 =?us-ascii?Q?o3fgu0KbUis6vfJUEutRijAfE4tgMEZEBbgCSY3m1301NXtFbH0SBDP54Q1y?=
 =?us-ascii?Q?aFz3urq6XUVTMIhirl1fU7y7LnSv3nzrifJBXvIEDLYLja7EqzaRYfH9YwIB?=
 =?us-ascii?Q?VDEUvr1vhGuWggbleP+F+t9N88Cp06ML8o/Mtah0ljdbgyivCcK4UdTVljeT?=
 =?us-ascii?Q?QF6VT/ozBcruaB9Hs9f65/s+o34bKJwxqUGCVpURP9Z3kXlUWS2u7zQG2ZEC?=
 =?us-ascii?Q?13C03aWXMyoZnWX3bTKhNc6Xm0XduSSKokEUZEpauh2ahgbtP015Zbq4ejc8?=
 =?us-ascii?Q?Kiz6OY/JWXwOQGpCKxKEFfeWCta+x6tGhgdFoQhY2XEhRtcDP/0VmaV6XjVm?=
 =?us-ascii?Q?7ScPa/g7PbFKc4w05f7r5QpojS8HbXB6jymI1aqEcqWRWc5W4FGX7qkz9u/E?=
 =?us-ascii?Q?fTLmaRmeJILPUeqONYSqwRztipDOhuJbHPOhkIY2veGe+7C0ZKfQFZSSGUZJ?=
 =?us-ascii?Q?JJ+37WHOVvN/8n73OrjyWQSfoZ+9uLY5GS+zjM15kaiBYxAR09PxN8AgBE4a?=
 =?us-ascii?Q?JPaLBozUyFhnvOuknvRBKh2VavUoWFs1tzGFg2NFSrv06GRfYPT5YPxcUMBM?=
 =?us-ascii?Q?HqPjdeL2p975b8d1LWTHMIu4OBM/N13+OPydQ+sDNoV4Q6UCH/9hlhRVjnCG?=
 =?us-ascii?Q?TYAyIFdRslKVMenwRWxhXq7yU7qKKUpTuJNZ4xrwxJAVUMqJJ6TA6Unhgs8w?=
 =?us-ascii?Q?ks7dDWd9BPP/AV2t6yARzsYn/WYQEUFde1fKtijwhbwlSDC9yaqa6Q4k2Scz?=
 =?us-ascii?Q?IvvDJwXCzmu3e6YwZGypEZEwUVlf8PeTiT1dsK5rCaqYYkdZERtuAQ2MpIiE?=
 =?us-ascii?Q?tIjlVj5KQiJ4QaX37IHGgqWtl4im4KuuCSw2QcvohfLdFcac5+Xy5gMxP6FK?=
 =?us-ascii?Q?0LP20S+/QqNQckwwMzqvVdcNqnDvEBgkWggvSmgYg0P4P6eM4aLkdYgUsArb?=
 =?us-ascii?Q?eKH6jtMgVQVejEEZLSFdJ9fXQzqUxU0bl1N5J9NeNZCfL5+XGKQ+4xE7r9nC?=
 =?us-ascii?Q?o9u4nCOwjQfR6SfBbVt0gytY9Q/ySppEXOJyP7RhUEJChpCHn9WSqdlbuLvi?=
 =?us-ascii?Q?DAeNIyB3FqerhePWvL7SYl1Q4XnVnBAUCPAMoQEzHmsRDvq+jeJH8zUEoa6T?=
 =?us-ascii?Q?Kcr5sTEC7ZBe5hGPPBfLmvhTCRNUypn0SxCUmfr9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d907787-747c-4201-c677-08dce938d773
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 14:35:52.1875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwSAd3wbP3tdRTBQov678nZ4X8p4SwyeaGvVcO5HXFXji+aKWEkGFXtUrxmKXhggYRwsTpvDw19zLKqau60DKsWgOx2EZAKY5Hj2FmIJ9Wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7665
X-Proofpoint-GUID: 6VmXMW81ziViqzN2JI_EPhSjNKJcvSIB
X-Proofpoint-ORIG-GUID: 6VmXMW81ziViqzN2JI_EPhSjNKJcvSIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100097

Hello Jonathan,

>> >> +
>> >> +	ret =3D ad7779_reset(indio_dev, reset_gpio);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	ad7779_powerup(st, start_gpio);
>> >> +	if (ret)
>> >> +		return ret;
>> >What powers the device down again if we hit an error?
>> >
>> >Probably need a devm_add_action_or_reset() or if it self powers down ma=
y a comment on that. =20
>>=20
>> In the powerup function there are only some register writes and the=20
>> start gpio is only a synchronization pulse (perhaps the name powerup is =
not very appropriate), would an action or reset be necessary in this case? =
Since the regulators are not used in the driver, should there be a function=
 disabling them anyway?
>>=20
>If there is nothing useful to do indeed not but when I see a power up, I r=
ather expect a power down.  Is there anything that can do that or is it a c=
ase of it will go to sleep anyway for some other reason?

I don't think there would be anything to do in a powerdown function specifi=
cally, but I could rename the powerup function to "_config" or something si=
milar, to make it more intuitive.

>
Best Regards,
Ramona


