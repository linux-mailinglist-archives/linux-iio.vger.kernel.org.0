Return-Path: <linux-iio+bounces-18244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3769A93683
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 13:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09814178017
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 11:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B1E27465F;
	Fri, 18 Apr 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="NUZ7J1tR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1444155C82;
	Fri, 18 Apr 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744975662; cv=fail; b=A2y7dLwY3ELekz8vABQ+RLRfnt7CaRnaZZfh3eDw+qSeXNs3E6+eowAfgohnvTR0XSMj/WKpwKDa7CEDMfI9MhZL7zz5DqCaTsRREgDnmGy2eB1bw55qf2IKWsZ7DPrVsSXuyI8HJzg8lcwg8o0RWwCVhtwScbJEYbU1uxMCtfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744975662; c=relaxed/simple;
	bh=AZddVUKp5ra0iUmt0mNkATot9HUBAe2Bm7Der8QeHbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s4t7Tp2LaYEmzI9jFwhgStlvyAuII1xl+WLnVYowoAU7/uDWvpXm8uYYoURSzZIIFrauXowvlD+xaD6F58hm2Mkv2Go6bJ+yn6R+QKF+sIYrGX0KBi7mhUP6/j/0jK9l7u03b20pZT/YlLQSYjhfvw6NZpCaJx3fu7x+fFbPuzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=NUZ7J1tR; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HNX5JE011876;
	Fri, 18 Apr 2025 11:27:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4639sm8knd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 11:27:00 +0000 (GMT)
Received: from m0233779.ppops.net (m0233779.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53IBQxsS015218;
	Fri, 18 Apr 2025 11:26:59 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010007.outbound.protection.outlook.com [40.93.77.7])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4639sm8knb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 11:26:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSHlhMqy5wkdh65fV1z8WNuIP0XSkwpo9Ifsgb3MrpysqhmtuY++/BvCEp/UpOrTUw5rOs0/FyfFl/qABlRqB7FpnWyBzeWjyg0nnmS14c61/doVoO2VA9ITD3phTF3q/GLJLlAFzUPmLJACjmTfv9dxkQJA+b7S6tK1VEkvylfktVtYBK3dicTE0DbROkL3z4okka99D/IkiPxZrS3mM7317RQS230Hg8i4LWqyitK9FFEb0CZ6xZOTVFynhxslwlUYAUfvtcBa7cxMxKG7CXS3HvsNnOpMu8D5lEn8Jv7UHG77QZE4fI5bnLQxPCGfYlSEV5bBzKRKt3IY+HJ6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snAmsgWLzumy4H6gOn3FX3EIXzvCr9z50cXWlF9aca0=;
 b=GfqXYBHe8k+cz2O7uFwmz3E1gNwBmaZHkLDaWph+jV1OYzaqCMqfggq8blX6jQQlb9acrF2mwSycpLXs5BFILcASC7l8+9HWLSJV4sVYbM4woYpfkXCTNlGm/wGOg2rgQy6YHy6QxQWAEF/bkeQ96sNUytsYh2JxcKZEAoIXFT1c2hL66dYVQ9103UxAP1HG26jqBi/q/XrW3rJxLRoRf+/NdgR39dNjlSZW+ORq08DmdfFQ25kvxEp+UnSLnnOi+enauVQ7Cseo6ZK//KEtFRhdxFHzOyDcVLahiufzwM5th0ICFSkM58RJpu+Pmb4gBj6+PtpUDh8RYeVYQViyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snAmsgWLzumy4H6gOn3FX3EIXzvCr9z50cXWlF9aca0=;
 b=NUZ7J1tRyq71ThpaA9jTiWR/JM9qQVpZuuQSHtFXEE5sd90ycLtkY4s8rJz3cGuGMEXBe84xLtENWzNdZ3DG8MWe5GAgfR2C42zpcniW+SPTDu2aHZ1ODWCPH9GZC1s80SlEsGnkLjZRDqSb2V8Q9ygogWU0KNMXiJTwB72VeseDyTmcT8FOtmIHeanB76FMMcyR7lEqpIYQoQU2YKWi4mHaJJinimeHOlyJoutvpzLuaGnHyerv+qppehmUiCbLafREcgCgQgSZFCMzWIN6+dOOFA3dkS+uALOsC4OXn9UXlP8FMRUfhwXkQ2FsxE6DRzoZGLR7mTIK3czyrBE8CA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR6P281MB3903.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Fri, 18 Apr
 2025 11:26:39 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8655.024; Fri, 18 Apr 2025
 11:26:39 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko
	<andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        Matthias
 Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin
 Tanislav <cosmin.tanislav@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Petre Rodan
	<petre.rodan@subdimension.ro>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 7/8] iio: imu: inv_mpu6050: align buffer for timestamp
Thread-Topic: [PATCH 7/8] iio: imu: inv_mpu6050: align buffer for timestamp
Thread-Index: AQHbr7lQslH7WJ8s6UK+4uVp7r52ArOoFOKAgAAM7ACAASZgpQ==
Date: Fri, 18 Apr 2025 11:26:39 +0000
Message-ID:
 <FR3P281MB175712512B0A88FAC9DFA009CEBF2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com>
	<aAEzlZoZTsQuWgZa@smile.fi.intel.com> <20250417184620.00006ae6@huawei.com>
In-Reply-To: <20250417184620.00006ae6@huawei.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR6P281MB3903:EE_
x-ms-office365-filtering-correlation-id: 0fe7dd01-2431-4c1a-399b-08dd7e6be32f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qslmiOjgbxfLbuENampH4rqBRRgNhJSfRoHhxR/C1LmwTXIIianYP2NyJP?=
 =?iso-8859-1?Q?uiztdt+MhTpKasPpkri4iRdYQLZuT47+nlkP9lv7+Gd1uYQU4TWW8fbz3u?=
 =?iso-8859-1?Q?O0ptG1jPYIx1Ps4VPhxSIlf/Ixsk47xHfzr/mibCMfJvUpN2jBUl7Sb/ds?=
 =?iso-8859-1?Q?dX8RV52ej8RL+eDJgI8ypMXkiK35fmfKL3gX6hUyCROY7TxciHzmUCzjbh?=
 =?iso-8859-1?Q?msE3YGDDttkOil46NgiDZkDpz/A9ougsjb51EEmPVpDrOK97V4fa0AKIDD?=
 =?iso-8859-1?Q?Z/UmqZhfWjYtS/kwCnfxtv4TtL2O/jJb//cvi2xU5st0gHQnm1nITEcAXO?=
 =?iso-8859-1?Q?bQflaaiswsbWEstOelKlPWl8xwJ8UzWQynmeoENDucmkkiA0+wBSUuqauc?=
 =?iso-8859-1?Q?jD7lYkQju2RMSN6gMuqX66YnOYgBiJFrvrAkGAdBTkzIw+qwSWFqqS/kIR?=
 =?iso-8859-1?Q?0GmOQ9n1aShfY6eiF1dvaAsE3CT2afEPJudpE+XyPJxq1CMn6f+Hu9V5a4?=
 =?iso-8859-1?Q?9yV2F0saqbpTiAvvOLBgAQ0Cda5KuspYIwUyZ9Mtj784s7YXvjzQlh3TJC?=
 =?iso-8859-1?Q?pvkSZSP22XrzkunTbueU8acgPbXJikZ/GYWvsqwuaQ6wtvcewP5bKiPXv4?=
 =?iso-8859-1?Q?FAyUJ7FvqfMEcQxSeDDyZLyZM0iKt6foqOaQCkrGUyRXiYkNPda/XUBP8F?=
 =?iso-8859-1?Q?zWw5FJ8H0U1BX5IcKLGAmX+iVRh4Bqse4bycg8HLM/BrKlOsZo/PQ4sWeQ?=
 =?iso-8859-1?Q?F4D0owDhHB9VLbbRcwrzGTqM8A6+s0xJma4Gevv7m1becCy5zyHmv/EX2X?=
 =?iso-8859-1?Q?kSH2Ke4AbUvlOVVG6RGlQlOCGiHPSSCjNnRvwAlgPlR6Rk4e+TD/ySUUSk?=
 =?iso-8859-1?Q?q/YaaxspNf5P9sogxTmO4/wY4bLv07jx1lYdV+mOWCiSpcRXFtBmIyQobx?=
 =?iso-8859-1?Q?HLaxkv667jcSzlak91fRBJ6H5Tb+iTcr1e82nWBMH0FOOqHUa81JNax/G8?=
 =?iso-8859-1?Q?oJs4BwVX0m+TJ6gS02nEy/W9Vh5hj3Wgnlx56RurTU+HaWAUnP0+jmZKOQ?=
 =?iso-8859-1?Q?YdniwqH2rSNyuNyZl+jP2hMZvl/ubTu9eRHmBm14a4D670LrReaJdUSOAb?=
 =?iso-8859-1?Q?0jrcYQEJ1fyuRCfoq7o4U3uwK09E5yqQg7w2x/Dnn59PmzIPYbHgD6NcdS?=
 =?iso-8859-1?Q?DL8FrfEYlEYd/0ZE8zpFih6KXWKoXqF1FoAp68o8dYtd2/Vh95CMTBLlvT?=
 =?iso-8859-1?Q?fvLeX+azERg311R0ElRXY4gWg5nVYfuAR/6kttifBRjBBzA0ofqSLE+EwS?=
 =?iso-8859-1?Q?zM8XBrvwWvzKr5cB4C4x6pAa9d7NWxCF8p/QVn2J1n6H8JZ6mayT6dN0Sp?=
 =?iso-8859-1?Q?2uzlvK1MJ5MgCkntXf+wpbuXaYrPfhP4zuczDYbVo43L2q1gydugocifLB?=
 =?iso-8859-1?Q?XxrX2iwslCcSjz43DlPdmJ5m/xnJj1Rx8OLXqiyjniWH7p8BFw7F8GIxjV?=
 =?iso-8859-1?Q?VJrxKOfpUsuQ+h3GDnlEjVSXqvMRqBCKzLQS6hCYzFWyHscUZdjEvt63LO?=
 =?iso-8859-1?Q?n0aa716IlwkpBv0LK9BnhzqhDqPw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GmFO6s35UT8QZxlPnOVUV6D0nmzsFg7uWId3S5JLDlQbhBJ1tZBqcN5W7m?=
 =?iso-8859-1?Q?P0/WX7OatfBD8evg+LpeBwJUgTx0PIFFQK34zyptImaGgSiLG2GfBu2SvF?=
 =?iso-8859-1?Q?Gq71n1qez1imIXWjdLIC4ndp9Xf2F6xXubm+qprCWMBzHaYusmT1qtBVv8?=
 =?iso-8859-1?Q?zp79VMkfCwlBSk7joxaLtb8SCCqWbyDsB7ftctyBNdMm3rfK0wvd4g21ki?=
 =?iso-8859-1?Q?3ha++DIRCDoWr1PktENiPz5gPQlOMGFZ0EyDjWkPwZdWHlukteG+vRYqpX?=
 =?iso-8859-1?Q?FhFwWLno10raLTopliPbtWMpRCXRHauIIAcjoJLsoV9CBC8lXdoeMCKMEm?=
 =?iso-8859-1?Q?TES6gUQPX/D/hS/aQ8gJ3Kxvjw8y7AQXkRvC0MC85mI8uDl3thoUj16C1t?=
 =?iso-8859-1?Q?i0iXQIcXziO3M5LHBnEIy5TkC3z883da93BX+lxqyIpy1nAW1dvw73cZv6?=
 =?iso-8859-1?Q?KDxNL3H8SHJ0QkgDOgsTtkxf8BQD32Qlzc6ohQ4Yk6RXRxV1TACJ4cMX+w?=
 =?iso-8859-1?Q?znzV8l3BJoij0gBiLafWRxwyXJHN5QKOXmoY+SA3EJFEMrahtBN3CcvYiP?=
 =?iso-8859-1?Q?c9gjayairyKQnkYaH+7FXPF9AOlwCp8ERW7n1nv47u1AtE/uwwCyfuKXpZ?=
 =?iso-8859-1?Q?QPY4k/8CBk0raw05EqkO7MKqhCjrWA1g3GDyUzIOqGMMYvpfERksW7lRle?=
 =?iso-8859-1?Q?ZF1uXw98jpfULSXUaGoAWDJuIbPNw44WQTgjY/ax0iwweH9u/YaQfxgpmB?=
 =?iso-8859-1?Q?aNjd5byt4YHU8MsySUh+eeSpFkry3Jmufi3NBndhVKdtIqW8RKecar8gfc?=
 =?iso-8859-1?Q?i9rTd507wdXNUbI+aiSXU8/EEzf/TAYByP+UxjGnSm2g4fq9LDUxtu4Qv9?=
 =?iso-8859-1?Q?1jCTk07GWnkgGCTLnUTSWx4anPPbdPlx6S6rhpRGu4Y4Y0+XwZSO0+hXHq?=
 =?iso-8859-1?Q?D48GrpPkbzfOLiryd6gS/WhgXziRbAymvnYPBzQRUAZ7kPSsDHcptiMCB+?=
 =?iso-8859-1?Q?fHopU9TuqbPd89pvc6XkH4zuFnisnEzCz3MOmXj94cAgFAvdlwZGecQ07n?=
 =?iso-8859-1?Q?9T+pZiAqoWt5wAnnLfLjFr4bFSTiA2Ez2xaYN4D8OSYiDlpY30zARi/Kwm?=
 =?iso-8859-1?Q?PyUopQQP4UmbdNutFnx7btEY3BYYELB2ZNnqhgnTLeCLxJJopesL/FYdx3?=
 =?iso-8859-1?Q?eYH9OJDbvxmqiGndkzULQuOTJ/HceynJdRa8KDHJJ/MpaLOcDe3OWXs9dc?=
 =?iso-8859-1?Q?HCtc7GJZDafNYZz0L3oGX6EN6B7+huRfTDqa/27ZboaU1s1wGMXnsIy22Y?=
 =?iso-8859-1?Q?mDyt16By/w5Vwl6mRrP+5xJxE8dJ1SFB0dYkOl6F2O+8jCDIMm2TapnTPC?=
 =?iso-8859-1?Q?iXP69dem4JhBkSLVZV7uG3P68a/zxh85mZ6w6lBUDh2l9ahyhCHyZ0LIyx?=
 =?iso-8859-1?Q?jLvVXpxw5mKWH34QSYpw4BICnLGKRFLbXuTK6OlfLIbD2Dwk0ql8XHIZRv?=
 =?iso-8859-1?Q?L+zgwCzSAucIj9zRvUaeC42SlAu27FPkKsVanD9fFjG8JnjvZYAmfij1s1?=
 =?iso-8859-1?Q?aTTxqMh4XDYBh+67MraglQtP6ptMNAmz8+/XAwJr+90c+UMyn/Hf+y8upB?=
 =?iso-8859-1?Q?7uG/W7K8gAddnnOmSha9l0Ab75Zuvr6F+pipdypElBNxUwJ2ZVKprYzyPg?=
 =?iso-8859-1?Q?rlxPmII8bAOxaWMggHw3vEc6BXsBFXnBq4hqn9u55QrLXboG3eSbeGbFC7?=
 =?iso-8859-1?Q?eKdg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe7dd01-2431-4c1a-399b-08dd7e6be32f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 11:26:39.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ll9TskTYvdcjmUOwXz09YcNvBMwqcZYMdZLADg0+5zgUCz5iOazJ7PaR5Aje7cRi+Ele47xwmzXDSIstKQctikqKGZ+SIc0DUbxyLxx+fc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3903
X-Proofpoint-GUID: hGJfV99282pgoX4EPHuXqrF6mJajXe8-
X-Authority-Analysis: v=2.4 cv=PIcP+eqC c=1 sm=1 tr=0 ts=68023704 cx=c_pps a=v7lO2Q71c9uDhDaeFh6mXA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=rSr9H8QEfjoEvEGaudsA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: YbFzGbaAGkZ-GD3JYBJrTToA2wvuRuFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=916 suspectscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180084

On Thu, 17 Apr 2025 19:46:00, Jonathan Cameron wrote:=0A=
> On Thu, 17 Apr 2025 20:00:05 +0300=0A=
> Andy Shevchenko <andy@kernel.org> wrote:=0A=
> =0A=
> > On Thu, Apr 17, 2025 at 11:52:39AM -0500, David Lechner wrote:=0A=
> > > Align the buffer used with iio_push_to_buffers_with_timestamp() to=0A=
> > > ensure the s64 timestamp is aligned to 8 bytes.  =0A=
> > =0A=
> > Same question as per previous patch.=0A=
> > =0A=
> In this case I don't think we know the position of the timestamp=0A=
> so a structure would be misleading.=0A=
> =0A=
> The comment above the define certainly suggests it is variable..=0A=
=0A=
I confirm timestamp position is changing depending on channels enabled. It=
=0A=
can be at address 8, 16 or 24.=0A=
=0A=
If there is only 1 sensor enabled (6 bytes of data), timestamp is at addres=
s=0A=
8. 2 sensors (12 bytes of data), timestamp will be at address 16. 3 sensors=
=0A=
for MPU-9xxx (19 bytes of data), timestamp will be at address 24.=0A=
=0A=
If the buffer is aligned on 8 bytes, it will always work without any proble=
m.=0A=
=0A=
> =0A=
> /*=0A=
>  * Maximum of 6 + 6 + 2 + 7 (for MPU9x50) =3D 21 round up to 24 and plus =
8.=0A=
>  * May be less if fewer channels are enabled, as long as the timestamp=0A=
>  * remains 8 byte aligned=0A=
>  */=0A=
> #define INV_MPU6050_OUTPUT_DATA_SIZE         32=0A=
=0A=
Thanks,=0A=
JB=

