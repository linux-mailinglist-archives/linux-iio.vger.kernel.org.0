Return-Path: <linux-iio+bounces-6560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5B290E6EE
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 11:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590E51C213DA
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B113F80029;
	Wed, 19 Jun 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Axka7AHo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577D7EEFD;
	Wed, 19 Jun 2024 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789157; cv=fail; b=Jmf+XpnKkyNmEPwDPWvp1/VpUwsxamU/7D7h9qlvk8Yj6tgTT9UhlxJs0lwvYukkgCgS9vC3aQLzbCnHJaZjt/2dITHoEc5gkrXqfMrg/vMB0cY0SJglv0UhIZFeOepFACGInwy2hNogn4j/whloE+3Oaze47NYiMgdwevpHhZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789157; c=relaxed/simple;
	bh=tfNB+uUffLiH9pwpbRoqCMdnIcbYhx4ymtYGRaCxCY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oZxXPrMp6fCgJK3sidqH3Z906QsgEY6BPmBeHLYEIezwV99JpEJTDmcNHy7pKSh7cmN2lovBVpA+93Gcf2cciGB6kUXtzpGnAZHyt0a1VRi4N5YJ71BtHTN37UB4Nk7fCcD3kHnQanKHUQAOFXU0YUbAiN7SNOM21yl8MjVnroI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Axka7AHo; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J6eRZD001428;
	Wed, 19 Jun 2024 05:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=b/IHg
	2blMaJbOhgYHOsrjeGkhtHrqEtaSxeDeQeLWiM=; b=Axka7AHoOqc+S87xOulO5
	wXi5OJsZ+0WGCd46uDBRbnr7d60S2wvBgY1PXC/9Hau1pMS2szv5Jvk5p4Jksisi
	4X1s5Z/AKnIXMehYjlIHmv0aNnFz3BR87HfLlbsU5ZLBaLvob31fnFUiVvjYvqNe
	ZD2PrXLoOdZ/uuagEkt1zNSVkuznIuLb0jClEv1M+cqq5JvG1UWaPIyv3xpiSgj+
	lQeytHgiLdn6EdoPgp4J8exdpZa3tBX/CUfXhCXJqjSRlvY2hoi0W4dOmA1N0GIe
	qQMadcAcxg+iUL8B9UAMzSHGjqujRfZegPQHrvG1vpXP1ACwmcIy9PUzJYIPoETd
	w==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yut928jdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 05:25:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfn0YsKkRhqgnzLyGZIWpbErGNgVGKeGUU1dDD2J4pYzJeXDjToG9JMcLM6SzHnFqKvCzRpCdbRwJy/wNpWQEHWlriCUX7rWS38/r54O48tLi9XgSjw6MCiT2QcZIsfjlsBhOnZEQD+C9Jg3bt7SieDzc9nMH+IcsjatSyKW+M+ZBdjUklpDhltQG4RBhYLC7kwzY7cip3rbgRhXfGtVFK/afIhi87uJeKWzFn6HVpeExKfz7Oertv00OxOslN7CWtwvDot3c8fEzTMsC4ItbOXnD97NiOjSfRxipKoPdDmiSYRNwOla+WGuga7XIsaopD/ctK7iw0IExATXTaSYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/IHg2blMaJbOhgYHOsrjeGkhtHrqEtaSxeDeQeLWiM=;
 b=FnTvouzgeMZDpE5ugBckhlUgsT4k1NKe5a/xOSSbem7KaPu6YyYMNjr3Czsk8OiwfUnKPQ/s/CsEzOxdv+Hxw+cVbGSfkj/rOqDzfw7bsV2l6bT8VpCTSE3RzflQKI6SASrLW5RgA/0NGgpu/F6aE8m4cD7bRacdzyt0Dg6PmtRcdCSS2I3f2ubV5KANqFWsV9yHVkF/6MbVjdHN7d9t8i5N9AokYUO0Z8zTbn7VQpBh7k+IeHp6oPTxDUZ7MlwkwON7kZeQLKCXRME5gBChxw28lBAk6x7w2mUXO2s9fP360FR4lZ7OPs1dmveGUxQYPmnFOmzOK2VvZ69APGv3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DS7PR03MB5576.namprd03.prod.outlook.com (2603:10b6:5:2cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:25:22 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.7677.029; Wed, 19 Jun 2024
 09:25:22 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: kernel test robot <lkp@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jun Yan
	<jerrysteve1101@gmail.com>,
        Matti Vaittinen
	<matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Mario
 Limonciello <mario.limonciello@amd.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: RE: [PATCH 3/3] docs: iio: add documentation for adxl380 driver
Thread-Topic: [PATCH 3/3] docs: iio: add documentation for adxl380 driver
Thread-Index: AQHawW2wzjB9ESvFWEmb7Kejqn0X57HNkCYAgAFBP2A=
Date: Wed, 19 Jun 2024 09:25:22 +0000
Message-ID: 
 <CY4PR03MB33993E7AAEFF707834D2DFAC9BCF2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240618105150.38141-3-antoniu.miclaus@analog.com>
 <202406182244.fOy7IrR8-lkp@intel.com>
In-Reply-To: <202406182244.fOy7IrR8-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1kODBkNGYzYy0yZTFkLTExZWYtYWY0Ni1kNDgx?=
 =?us-ascii?Q?ZDc1MDZkZGVcYW1lLXRlc3RcZDgwZDRmM2QtMmUxZC0xMWVmLWFmNDYtZDQ4?=
 =?us-ascii?Q?MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSI0ODcyIiB0PSIxMzM2MzI2MjcxOTky?=
 =?us-ascii?Q?ODAxMDQiIGg9ImZQT3ZmWWM0a3pESE9qUGVnMS9uK3JyWmF5WT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RG9nNTJhS3NMYUFlenlBWDREc3FNVjdQSUJmZ095b3hVREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBWVBUSTJRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DS7PR03MB5576:EE_
x-ms-office365-filtering-correlation-id: fca91734-2270-4e02-f8ca-08dc9041be94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015|921017;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?BCS9M29RMhVzR01IloUX5zhIHfX2ESJvO+t9fssNT/81/oQWmfv+tU4GYZT7?=
 =?us-ascii?Q?s8+gnrBe/fLlXGh/N8KhmMv1h4nTkczffBf5eARr4G1NomC/FlbbA+vwduIk?=
 =?us-ascii?Q?S0fYz4kFmQsbxFAdU21cjxyHRNYp17qxJ1626eSf7PKMU1x/+4uxUtzfjt8t?=
 =?us-ascii?Q?dCxJD7JdVsV62kKEbnv4THf06o6C/YZBlZqsgmLDGEp4ynlGEFWVmVULkdiB?=
 =?us-ascii?Q?PJNQu99H3yfvDsoA28EzW+o/7xNGEgjDeSF1L4wDsLMzt8PNiFFB5h+l8/aX?=
 =?us-ascii?Q?0oCQbmjmSns46+Z2ElQ7KEYUFxZvHZN5uKATsj1Jx1+ZKlR+Xoda0rmazUT7?=
 =?us-ascii?Q?JYxq3LVjHQWyZiVCL4kBx+7iUdD+X+LIxLiy56xL+yNX/2exzzPSBB1o0Iqt?=
 =?us-ascii?Q?SLGuiR0jRCE+G/68xYQbgOUjLMW3Sq6lkvUHVJ1tvy5Jfs2ywyKDHsQhqZtf?=
 =?us-ascii?Q?Tv2nBs6SGvO0J6ELryNiLbfHNUANQUQwNTPUg1L5t5/DRJhoFGYkpZViQvge?=
 =?us-ascii?Q?MYozS6ZyKgKZJ/I2eznsYUPftExFfkOCWroC2DH5JRn49eluNpRoYyD89nAZ?=
 =?us-ascii?Q?aIQ/yESTCSlq8U2y0mIoWfOdOyt9wyzx9tyYGhv7xwINyMoSBuDKtZJf/uVd?=
 =?us-ascii?Q?6fgltOaCcDA5bsLAzJe/nE1gHXLfCoK2E2hDfVZ9tRncagUzWBBR4Ft3aDYB?=
 =?us-ascii?Q?FQROR7GactIstiAiUqMW998/PR/aTgMfIbwJPpkE0A1jtdqupBblUVB5LdnF?=
 =?us-ascii?Q?Px4lFVJvYZyu01jC0LHxSMv6b+DQKXVhHaJA/8LIdWhba2Y2c/bCfMG4nIWN?=
 =?us-ascii?Q?rTTZ+A1EnhHpB8rZtaTxXXyBP8cYth7sB+45hclhv21ma+8UAAQYHqFXOOci?=
 =?us-ascii?Q?39Utltm+CpvxOr4GNuKh+Zv/RKGrDM1dnMhg3L0Q6iU0fQYYVwDLazO19W7m?=
 =?us-ascii?Q?x6jogeeVGBBUi7HxUKjT3RKV9P/obFgf4wRFKe7wDHjs2NwlYqSkA77m3NlG?=
 =?us-ascii?Q?NXVWbROeP1+rdsJSVFJxzd9D0Naj+jSY0Qjj7iesVkb42ojBhESsljWEw+NH?=
 =?us-ascii?Q?8xHSpLTsLe4VcGPKBEiEbnBRUHoirvg3Snd+FNpenjfG2Ki66y0USR+bCQ3K?=
 =?us-ascii?Q?oIPYRkIdMEO6u9SddxsdSOZIefzIS9r9/JtYmPnbN1bGz5KZoIrxPtfdIFXC?=
 =?us-ascii?Q?mOuH5vJYock5sdj3zBxDMjb1QUvDbQfPyeoqtt/h7F7YSUDdGL3hPQ1Wv1sm?=
 =?us-ascii?Q?kpH7oAFo4WKp6W4ymgZWqrFMby1u/56trqHjAupD8rbzMY6MT8Gv2cjGASz6?=
 =?us-ascii?Q?hs3aXffbDqRpuX2ksk0Nxl5XDG+ywC40QbLNZtZz6NGoqw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?BTNeQ6k4Pu+19xlS3h9QxE37Vxix2Ixzw7NTIbhFkjVelwLDKHCbnXrkIKyr?=
 =?us-ascii?Q?bCDPz44Htc/e9M1NkH4CvDa/Eicf8Mp2vHLRh8mm6ZZ0UujeJS9R68aMqDGq?=
 =?us-ascii?Q?nd5XrhfJoai8kgEeCAgjQ1s35yzjxW8rdaeKGs6Lgk6k10R5tABs8C1N9hLg?=
 =?us-ascii?Q?diOm8skOsbAlpGSmn3BhYWYy76dVKFZjqqkB/Oa54ClK/Av44uoiuvgUjbBI?=
 =?us-ascii?Q?yCsu6aB2qvxP0Pd/duVrF1OVh1S5oAqhU6pAc91gGP8ctgOj6/qSkJ4dJ9tu?=
 =?us-ascii?Q?GGorQi4w3QpRLUVb+1ewI6Bm+u5prUOoLEGWJcp6p6Py04ezyzy/yDavaMOw?=
 =?us-ascii?Q?bnB7nOf/izBU5Ja3A/+D6oTcOF6fIRSZa/Djmh6NkjkeqRJvTzuOh0tXbJkW?=
 =?us-ascii?Q?XsT9PBVJnNQWsZ1UQoZgi/nt3I76ntulUjlK09uA/2uw921X3joikHluTgq9?=
 =?us-ascii?Q?DhSHU1pbz9aV25g+4mSgNIoCKDfkD3ecgKWByh5a+H4V4LSZlPfqD1ePmvLK?=
 =?us-ascii?Q?DJteLyuhfZiRU33o2DLFHrlC73ED3q7BTyRRw9D2IMAA8/A2A+Gp75I65REO?=
 =?us-ascii?Q?zh8ge954QwyDxPMzTRUIPYw9plNj/UchIbNzaZhlEgIw6Jgx+BWki8tThN6S?=
 =?us-ascii?Q?7ud9eohj23VOzuS6k2loFZF+Wr8wCEYCNQ5ARKJ/C4bB2AH0zGUVQtAVGYRx?=
 =?us-ascii?Q?W7L5SxprxSg6KDgmePiB8PyWTnTsWcFXceuae4ykbB7BuVzhUZaV+mHN2wL8?=
 =?us-ascii?Q?MBi9tMpl6GNqudWflcRsm4URxyeI5RBDcicXXqus8UhHT+neWzEFjKERePbU?=
 =?us-ascii?Q?op1N5bK0QAxmTv3DVkqe4ifis4fYvHMs1kNzxqykfnuVIbpnenzsrhb5yxZ3?=
 =?us-ascii?Q?f33NCJr4Qbx6nAY6joRxKR4gN5rcBFvq9qm3zHE6grRm1cz4Cq5EEaJGelq/?=
 =?us-ascii?Q?ZsMxgCLX0/2Q7ojoW4tdryB09F1tmblNgvlVD1yaoNc4qKPUkAnLmxdN0KAJ?=
 =?us-ascii?Q?KiruGF6iPJ3h35WcdG/3BCQi8x8Y4Wzd5zHc/KjqDkcEUMwzKhQ44VTRR+Tq?=
 =?us-ascii?Q?bYcVLBj/c8c+QhiCPX/LPX3dKa2zR60Rcvbv+XWYgCQk9q/RoHCaYT4vh0Xe?=
 =?us-ascii?Q?N5dCEUdmvFj5xcsZUsZC+AXyvuLqSnbw0aiCpTrvb9Hk2qhLLYqX/KLZtpRm?=
 =?us-ascii?Q?I5w5pk4zbOGP2ZWNEcLqHNtkE1vQxxIbDoO6NLDVjk8Ur3AlQQ3DPwdWOCOh?=
 =?us-ascii?Q?T6J91Slwzob5xgIkFplyR3UqEiTweN3hSAWnQULYStkhjeFff3LOd8cL85gK?=
 =?us-ascii?Q?Ml5tRQNMKDtqt0nxe8MjZ4ztjw7zH7y8t3Z0U1qwHYsu2aytr3xxbdF2QBpD?=
 =?us-ascii?Q?RrLEZLacB7TQYR1rtERgLJNyOquSWAg2wgcdkJx3I+PGkUixOu4mzJE++wr+?=
 =?us-ascii?Q?bXKcGe//dD0xk2HafegAyWMsfuKwkZgKaSw2xOfVrImvNi0HmfSYk0f41HUi?=
 =?us-ascii?Q?y2KmqEf6tIPXisdazeMnL18MwYxis+xNZG8X6KxmCJsxgCu9YkGPhhmLTooB?=
 =?us-ascii?Q?67qrYpBfhe+LOiG6/WzXpgrYzWGoLgONzmTbYaB923QEnGbc6TIr8YLkpuZl?=
 =?us-ascii?Q?lA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca91734-2270-4e02-f8ca-08dc9041be94
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 09:25:22.4150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIJi8I8f3zyl5OV/GG/40X8UQ63usOW/m6u4hP2gpBumw8QI++Xs7YjjSMfkAaonU4uQ8QZy3tD1Izugfsyk8B7pYNNKwDMDgM04N+AnM3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5576
X-Proofpoint-GUID: NdLdh9aBgFAH0FgFjWLaWRhBaTS0L2CU
X-Proofpoint-ORIG-GUID: NdLdh9aBgFAH0FgFjWLaWRhBaTS0L2CU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190069

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Tuesday, June 18, 2024 5:12 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Gradinariu, Ramona <Ramona.Gradinariu@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Jun Yan <jerrysteve1101@gmail.com>; Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com>; Matti Vaittinen
> <mazziesaccount@gmail.com>; Mehdi Djait <mehdi.djait.k@gmail.com>;
> Mario Limonciello <mario.limonciello@amd.com>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org
> Cc: oe-kbuild-all@lists.linux.dev
> Subject: Re: [PATCH 3/3] docs: iio: add documentation for adxl380 driver
>=20
> [External]
>=20
> Hi Antoniu,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.10-rc4]
> [cannot apply to jic23-iio/togreg next-20240617]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://urldefense.com/v3/__https://git-scm.com/docs/git-format-
> patch*_base_tree_information__;Iw!!A3Ni8CS0y2Y!7TY303y6Qd4Tevi0Hct2c
> fHJgbP9qlTrlFoYk6IrEVT7JMcy2tiEce06QENuIkGGJVaTH5xlmowBJA$ ]
>=20
> url:    https://urldefense.com/v3/__https://github.com/intel-lab-
> lkp/linux/commits/Antoniu-Miclaus/iio-accel-add-ADXL380-
> driver/20240618-
> 194141__;!!A3Ni8CS0y2Y!7TY303y6Qd4Tevi0Hct2cfHJgbP9qlTrlFoYk6IrEVT7
> JMcy2tiEce06QENuIkGGJVaTH5xZTS2OIg$
> base:   linus/master
> patch link:
> https://urldefense.com/v3/__https://lore.kernel.org/r/20240618105150.38
> 141-3-
> antoniu.miclaus*40analog.com__;JQ!!A3Ni8CS0y2Y!7TY303y6Qd4Tevi0Hct2
> cfHJgbP9qlTrlFoYk6IrEVT7JMcy2tiEce06QENuIkGGJVaTH5xbrkTQag$
> patch subject: [PATCH 3/3] docs: iio: add documentation for adxl380 drive=
r
> reproduce: (https://urldefense.com/v3/__https://download.01.org/0day-
> ci/archive/20240618/202406182244.fOy7IrR8-
> lkp@intel.com/reproduce__;!!A3Ni8CS0y2Y!7TY303y6Qd4Tevi0Hct2cfHJgbP
> 9qlTrlFoYk6IrEVT7JMcy2tiEce06QENuIkGGJVaTH5y0Dc1FTg$ )
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-
> all/202406182244.fOy7IrR8-
> lkp@intel.com/__;!!A3Ni8CS0y2Y!7TY303y6Qd4Tevi0Hct2cfHJgbP9qlTrlFoYk
> 6IrEVT7JMcy2tiEce06QENuIkGGJVaTH5yDCB9XLw$
>=20
> All warnings (new ones prefixed by >>):
>=20
>    Documentation/userspace-api/netlink/netlink-raw.rst:
> :doc:`rt_link<../../networking/netlink_spec/rt_link>`
>    Documentation/userspace-api/netlink/netlink-raw.rst:
> :doc:`tc<../../networking/netlink_spec/tc>`
>    Documentation/userspace-api/netlink/netlink-raw.rst:
> :doc:`tc<../../networking/netlink_spec/tc>`
>    Warning: Documentation/devicetree/bindings/power/wakeup-source.txt
> references a file that doesn't exist:
> Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
>    Warning:
> Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-
> regulator.yaml references a file that doesn't exist:
> Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> >> Warning: Documentation/iio/adxl380.rst references a file that doesn't =
exist:
> Documentation/iio/iio_tools.rst
The file exists on the togreg branch:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=3Dt=
ogreg&id=3D9bc8b4d27c410f62742bad6a05639ee3e13f49eb
The adxl380 patches were created against the master branch:=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>    Warning: Documentation/userspace-api/netlink/index.rst references a fi=
le
> that doesn't exist: Documentation/networking/netlink_spec/index.rst
>    Warning: Documentation/userspace-api/netlink/specs.rst references a fi=
le
> that doesn't exist: Documentation/networking/netlink_spec/index.rst
>    Warning: MAINTAINERS references a file that doesn't exist:
> Documentation/devicetree/bindings/reserved-memory/qcom
>    Warning: MAINTAINERS references a file that doesn't exist:
> Documentation/devicetree/bindings/display/exynos/
>    Using alabaster theme
>=20
> --
> 0-DAY CI Kernel Test Service
> https://urldefense.com/v3/__https://github.com/intel/lkp-
> tests/wiki__;!!A3Ni8CS0y2Y!7TY303y6Qd4Tevi0Hct2cfHJgbP9qlTrlFoYk6IrEV
> T7JMcy2tiEce06QENuIkGGJVaTH5zeR7qKDg$

