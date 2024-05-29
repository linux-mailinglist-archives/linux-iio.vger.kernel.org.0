Return-Path: <linux-iio+bounces-5456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F538D3B4F
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD861F28A35
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BF8181BB3;
	Wed, 29 May 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vIin7n0y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB01386C6;
	Wed, 29 May 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997579; cv=fail; b=inouSsLw8Gr54D1FUeNmQmgBmvRdRRm3o5Fs/l0QW09vGlee2CiM1/tIWqydgx3vmljyjRtig9qPurAF1m9fKsUJbD7D3KHmmDBRHwDHucyFC1hxQo/iGsR9lhZHfdeVoCaXCf4L+9VClTpCeZJAStZsO6fMzQ9kdPC85/8LbZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997579; c=relaxed/simple;
	bh=1bjX5QAlkEk7D9NNF5KXKa2ZeZeJpzT4O8p5UURfZl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qzH8SKs/b4C41B1FeYD41tkEal4vyRQrfh4DZ7310pvllcdNJCPt3P6AtVV+QN5uIvsjnQR+mO/rbBgY1G2cemb4wfxO84OeKXV+rBCMC2IO/Rz4XBblkAvQG2jzb9HyHGtqM0kpy6xFchIuJBRuNaZHxgu5hLNtmcWKgu5BlYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vIin7n0y; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TBu4ad021449;
	Wed, 29 May 2024 11:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SJEpQ
	ZvCmHiZdJI9Sjuo48JFNtGl2q2cdgBiVB4xnlw=; b=vIin7n0yoyEgnu+Alf7SS
	67pe4sm1/qfUBzb0KKzWhl9EBHeKz1zvqOZVtZZUJTfUFF25is0e1j0YpLIrf1jx
	m9HEL8BcPqAi73AifS3ubbPNveiv6ww2GCA9dhgvrtdzBA2nVNadB09efhCvTS3L
	jUbatRMcrct6OeG+9Me1AD5OJpSVHnfCMSmwpJ8aWjbS57vXM92hopJXsLuyV8WI
	e9hgvMGg3twuf3RhNzWtkzXhme8JS4W52mbzSS1LQV7jKniXaQNBrYoj053ZjQzJ
	UWfoWZUj85yk57DMbweeq9PXrFyVmD9+wBuZM6LZo1RTuOWCeN5hb2gPeWDyHZ1Z
	A==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ybcw2fjn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 11:46:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6k0ZLxXPB/SNEX38VHnR3N+JaNstH5yANnil+9nxP5dmcZmEJQ5tioxiw3o75a6ItuaCdDQ4wZnXLlwyPc1roUpMpOdfR4AzwFs2iheqX7j0SZC9orREgGSLiX9fruvL/MhNLK3Q9hHU4LcOMPed2zoZcj/jwagom7R+dob6BujvmNSGcd5A3/OOGCZTYs3dzazsfSP3JN02N2rXh5lswDA46LQbyiRQs78ZeG1YV/9TsS1d1a3MqBs94XYWfr2UCfHBAFSAmulys2KBCY0u6dYD+1ZFjmjbg+nNMTbgAgvWcfcxlLCjmYQtYz2IFefLL5OBvLpiM2uKIQDi8gZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJEpQZvCmHiZdJI9Sjuo48JFNtGl2q2cdgBiVB4xnlw=;
 b=fLePPqYPW7F9NOT7ZeNKTpMv7lKYoLhKRiJ/DcoDPR2eJ3SY3hJGZK4zW7EaarsLKxY7eaY4CxCMblS26NqGI1HwrtVJ6eRDea4fDa5rBbpKirMfLO6AtquCZ1r19XPgkoziqbkdZL02LtQY78z2oth0Q2BXE5tv/RFsoiudFlMm1Hgfg3WpgZA4CR5xWD9kQZm43GxdHH91pTQAD1NnnLB0wqEQpPp+Nkhoc1yKSumQpKJLx617U9oP5R0QiTFsANs3jg0YC7fOfEmBezDTrXNHuV9DSrfKLz3Dc/nRwnS6BhsOE3XQF/9GJxlVzOfwYwuZov/aono+25uTO9o0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB4320.namprd03.prod.outlook.com (2603:10b6:805:fd::16)
 by DM4PR03MB6063.namprd03.prod.outlook.com (2603:10b6:5:392::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 15:45:58 +0000
Received: from SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f]) by SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 15:45:58 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        Marius
 Cristea <marius.cristea@microchip.com>,
        "Schmitt, Marcelo"
	<Marcelo.Schmitt@analog.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Ivan
 Mikhaylov <fr0st61te@gmail.com>,
        Marcus Folkesson
	<marcus.folkesson@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: iio: adc: add support for ad777x family
Thread-Topic: [PATCH] drivers: iio: adc: add support for ad777x family
Thread-Index: AQHarD+43ERipWM1gkKh9ZW8mJCjp7GjTUqAgAsEBnCAAAsrgIAACZWw
Date: Wed, 29 May 2024 15:45:58 +0000
Message-ID: 
 <SN6PR03MB432024DCE5978841F016A71FF3F22@SN6PR03MB4320.namprd03.prod.outlook.com>
References: <20240522120005.18197-1-ramona.nechita@analog.com>
 <Zk3-qxCb0zfR440Q@smile.fi.intel.com>
 <SN6PR03MB432071701D6A19C3B4C0C33FF3F22@SN6PR03MB4320.namprd03.prod.outlook.com>
 <ZldFpSQPAmAhbW2I@smile.fi.intel.com>
In-Reply-To: <ZldFpSQPAmAhbW2I@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccm5lY2hpdGFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy04OTViY2ViMy0xZGQyLTExZWYtYmIwYy0wMGUw?=
 =?us-ascii?Q?MjIzZWY3NGRcYW1lLXRlc3RcODk1YmNlYjUtMWRkMi0xMWVmLWJiMGMtMDBl?=
 =?us-ascii?Q?MDIyM2VmNzRkYm9keS50eHQiIHN6PSI1MzQ0IiB0PSIxMzM2MTQ3MTE1Njcx?=
 =?us-ascii?Q?MDQ5NjkiIGg9IlJVRXo3UkF6bDBwWXp2ZTBJMkxaRjhNNkNBOD0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?REpPN2xMMzdIYUFXZ2FVbjNUdituaGFCcFNmZE8vNmVFREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBM0xoU2ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4320:EE_|DM4PR03MB6063:EE_
x-ms-office365-filtering-correlation-id: 3497c1dc-d63e-4960-1063-08dc7ff66f1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|376005|366007|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?LF9wye5TDr7X8qvKdFRnvq0vIvv3whwxBdLuEC0A6dURxJy/gte9wT5RinLC?=
 =?us-ascii?Q?PQ92Y289ZBMwAkeQJjxhOtHGgPWBhsRrFDEs4XdXkUbbUkL3WQ+/aq+eN/Xh?=
 =?us-ascii?Q?wZ/U8AVgHJD2SshF2EvUauRzsyCk6Vf8A8kwlDSwATXpLfIRk8KHBlT9xpsb?=
 =?us-ascii?Q?pLaBu43DI18f1B8Mu2v7RrpQsU/TB9v5tjLocETKNOzFiYsBxrjP2bL7VxE3?=
 =?us-ascii?Q?kGN+aUZHur7yIv8gNpJydwDI+4dh311pE5wZkMLJ4LeeSKqSJJlkjNQkpH11?=
 =?us-ascii?Q?bC7xbPd9SEQh98egqVTc7gG3kzkV/Y83Ux/ZcjPZHxHR4cFWY5R7ZWhYSSgE?=
 =?us-ascii?Q?3v7sAqnoxaeMatcuwxxK98gDYwUSZzJtFRW4oxu3vM7xFIqYgj91igOWBEw2?=
 =?us-ascii?Q?eMG5xzQtF/ToTj55Fz0Lsx0BPNt1cd2Mp2BMSJxbct6Ecw+FXGcg/lXQReki?=
 =?us-ascii?Q?IwxSQy72cgQAaABcPuONXlCsrPucmId83Ok7ns8WFD9Gu3YaLnfleAgyZmlZ?=
 =?us-ascii?Q?zfwYbky7DzvTR4erwxcbPiVGdYk90D5p9FmHoCuXmUVL14Eo0ZG56kGsfTZx?=
 =?us-ascii?Q?qNThTB+e9SZ71DDm1fSR/WNMr/4aV0XW2pOSBoS7JHf2dqyKtZ157UVMKcfU?=
 =?us-ascii?Q?nE2lBmQPfrBqbNDYw40NKZwKWhzH5BbscHdhBF2F8UREoZz0XVkLQy457PWp?=
 =?us-ascii?Q?2RnrYvyzwT0txH14MPjwdpRJiqBG+t+3KU8uQ4Yan5KR91Zp4jDQCf2dLEXZ?=
 =?us-ascii?Q?BvkECBJaUa2Up/a/zoFRfss3AlgmDjTXlZd6Wdq2QXdNeaPPP4Xxqg+V0Zu3?=
 =?us-ascii?Q?C+p8Im40QemLrpwydrDrfhK4hd+8Bmn2rbReXoNChgUBJNSHRRX/pPN0dS3X?=
 =?us-ascii?Q?8ZrHPKVNVYnWYdXmoN7Dztah1BaauHeOkSCH4U5X/0IAKDsZBLOyaOKleIoF?=
 =?us-ascii?Q?WQwpC6o2i1q7PSS4Ns1qBQlKQZzZ7lyNSQVhJtPe19vzFXIGkF5T7wi/5ltQ?=
 =?us-ascii?Q?Yq1YX4YX6N20TqCA2D/+RvYno6KJkqfPN8XmbJyEhzBVJ/tZillGrsTmQuqj?=
 =?us-ascii?Q?Q2FXndA8zzJ5W/oWzgd2ggTsGT7mPnCi+Jnae3IBUX96sdKe9V5owf3d8Wm9?=
 =?us-ascii?Q?RXdOvmvS1f7SJLUpTIahv9E46ycxJa6DCA7Dr1TaFL7sQaDTQH3FHofiqvYD?=
 =?us-ascii?Q?pikTq71nh53HY+e89Sjgs1oNxrlUOxumk6RPZZybDJFtRvnl8IsJsejNfXes?=
 =?us-ascii?Q?OXfaq1vKlC5uRkCgtIbCypR2wxuL0laWys8JvIdhYI5f0BldbWtwOn7f93Ap?=
 =?us-ascii?Q?tYcH87sywuerqYLUUinkhqGFOAuwkx3kD7XAcl//o1gM7Q=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB4320.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DiHu07DSsNfmXV1wgBX3KUlpfh9VIaqQMUhM2432RGiKLWqkw0yJ6N9CBPMo?=
 =?us-ascii?Q?UBTS8Gn8cu6Ic0iyx6i5hnoNIxnWD51CkPAbiqaP2Zw1lDrF6wiQmTZ29CWu?=
 =?us-ascii?Q?RVzol/qG4OneoMojI/Xv3j7Ka55ElTq1VThjHPXlPS0jPSCrN5mgz6WBHwcW?=
 =?us-ascii?Q?lbb0gJV3Hxpo0MK+rtIZIai/pql+TTFXo38nCe9v3i06hivSC5mxBySDy2ca?=
 =?us-ascii?Q?Sa+ryKqV4wJUupr0Ln5ssnatCv4JwC6XDkPbGQhyjdtvxXBPO8I54Y5PMDmu?=
 =?us-ascii?Q?S6YnmTfy3k3Eeum4bj8/2g4aCAZo2/5jlnvPNqqAUhfHEpnGbmgyoHp7XRSd?=
 =?us-ascii?Q?J+clgP9lNOcbTQT9nhkNXYkszCHB+LRoaUStim3FAeDw9VeE+mHai148IUPM?=
 =?us-ascii?Q?RFAtsXf5Vg3Xjj5kPN0uHoDtt6/PE0cm0RnAX1aRDweMGaWUORcdwkh4wgjX?=
 =?us-ascii?Q?EnielgMJn3Q6630eA10S7sUnC9KE+cuOElYqSh0LJonYH7Yd1BNQZXJ0JB8u?=
 =?us-ascii?Q?4cbqPC2xtyX2P6a4zsZh3qwQIw+r8X2l248H/H8MpcV1VG8CujSyVoFO+QgR?=
 =?us-ascii?Q?ZplFui7Qi959xCaF28kZYfYJP0rzPTtXWDi9vCFuX5nfmFmLW12O199Vo1Y9?=
 =?us-ascii?Q?OxAChxGNlD06lTIspku44bW5BBw7bQviLgOSuGxcuu41LawcDCvSbTAMtO/2?=
 =?us-ascii?Q?9Gd9aKq5iqEWLD0NMRkDPrZd6TCEGo9dZzbZi+6TnmJyLNPxYRdSJrqq3hDj?=
 =?us-ascii?Q?u17dIIz0Xz699W3h3SY7H6AtxwAb0ivsGHDawt0dkc+5NGcqyhlSU5T1MeiV?=
 =?us-ascii?Q?kvIT9fITyCF7il6zkt8McJTLCjvv7X0ckaqf7887vlAJCyfgf3+5j1/nNwpI?=
 =?us-ascii?Q?ipi9Oi8FI78HPjj49BlVff5YYSMvOLQCVg7q7UBwtE4db2YooO78q9TJqPHk?=
 =?us-ascii?Q?/y/xCCpPUmWmcA9+vLdgIcsqxdqZ4O7WqWOcI0Fbd6lSWwaDXiwvdWzEywq9?=
 =?us-ascii?Q?YUsRoahZDtUe1FvD79bkPQ6ooxeGupUYpFnrYAMVEfSlixNYKqeVqQpz6mFx?=
 =?us-ascii?Q?14tZTmwQxMG7D0VlaX/C38dYLg/I9iYiatDHiukjwjNLuzGeVpwJpAILdzb4?=
 =?us-ascii?Q?Sp3VrqqUcwY8gjELziCf8m83j8NLuzzVMzJfBb5Dij7tOCCYICzbAxpO1PJI?=
 =?us-ascii?Q?YjK91OAkwUFpghgCjwI9rNSr/7mHdA9vHpC3cwHT4MtSywuEp6txIjKvas13?=
 =?us-ascii?Q?A9dSNkbjNKrJCX5PDK3SxIor+Ak9ZKGkO4HuwyBFhygxZOl+Lnuyt9QWJbCy?=
 =?us-ascii?Q?IScA+EJPCUZj3h5ir5v1TQa4yUjGyDk3rNCYWVGNkyst3n4IyRWCd1lfnK4V?=
 =?us-ascii?Q?pYZDYWMgil/JH69Uu11Yjw9ixGIQeDy6G+8jxVwBN0fiOA743hvYRqax7hdB?=
 =?us-ascii?Q?OXuaVQ65RYWxTwmjsVcYgmRWZQfhS64/scJCY77ABrmMkZBaY9K5ydEKtl5/?=
 =?us-ascii?Q?vNKeVhLdySLND16xmjwsm+WN7UYDz6zqJYjVyi78Ydja0sZxU5u7t+yJuIei?=
 =?us-ascii?Q?1YpOMrk+ZNfMRXi3yo5nmf6oGa08ip2THhFCkvaW?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3497c1dc-d63e-4960-1063-08dc7ff66f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 15:45:58.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjYNm0b1pJ7XZPGBwSTpnigrscQhOqkeSttVRVJrfbgoVfDvy7/6iDkhkJog77srMieMkxdqP7qlcni8Y861he8VWmWQUPBxagd7xMNZ428=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6063
X-Proofpoint-ORIG-GUID: UqLxxliRahX-iDgPhqKGBNa8oQIpa4Pj
X-Proofpoint-GUID: UqLxxliRahX-iDgPhqKGBNa8oQIpa4Pj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=857 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405290107

>On Wed, May 29, 2024 at 03:01:06PM +0000, Nechita, Ramona wrote:
>
>...
>
>> >> +	/*
>> >> +	 * DMA (thus cache coherency maintenance) requires the
>> >> +	 * transfer buffers to live in their own cache lines.
>> >> +	 */
>> >> +	u8			reg_rx_buf[3] ____cacheline_aligned;
>> >> +	u8			reg_tx_buf[3];
>> >
>> >> +	u8			spidata_rx[32];
>> >> +	u8			spidata_tx[32];
>> >
>> >These will not be cache aligned. Is it a problem?
>>=20
>> No, it should be fine without the alignment.
>
>I.o.w. it means that only reg_*x_buf are supposed to be in the different c=
ache lines, correct?

Yes, that was how I intended.

>
>...
>
>> >Btw, can't you use regmap for IO?
>>=20
>> Unfortunately, I don't think regmap could be used, because of the crc=20
>> and the fact that data is shifted out on the SPI SDO line in the=20
>> interrupt. I consider perhaps adding regmap to the mix might complicate =
things a bit.
>
>Can you add this into the comment area of the patch?

Sure thing, I will wait a little to see if there are any new comments on th=
e v2 of the patch and I will make sure to add this as well in the next vers=
ion.

>
>...
>
>> >> +	ret =3D ad777x_spi_write(st, AD777X_REG_SRC_N_LSB, lsb);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +	ret =3D ad777x_spi_write(st, AD777X_REG_SRC_N_MSB, msb);
>> >> +	if (ret)
>> >> +		return ret;
>> >
>> >Can you use 16-bit writes?
>> >Same Q to all similar LSB/MSB write groups.
>>=20
>> I cannot do 16-bit writes due to how the spi functions on the chip and=20
>> because the registers for MSB/LSB are at different addresses.
>
>They are supposed to be on the different addresses.
>You mean the distance between them > than stride?

I may be misunderstanding this, but the spi read/write expects HeaderBit+Ad=
dr+/-Data+CRC. Writing two=20
consecutive registers would mean creating a buffer with this format for eac=
h address and
sending all of them at once, correct? I feel like that would overcomplicate=
 the code a bit, but
I can do it if it seems appropriate.

>
>...
>
>> >> +	ret =3D devm_add_action_or_reset(&spi->dev,
>> >> +				       ad777x_clk_disable,
>> >> +				       st->mclk);
>> >> +	if (ret)
>> >> +		return ret;
>> >
>> >So, what's wrong with the _enabled() API?
>>=20
>> Sorry, I am not sure what you mean here by _enabled() API, is there a=20
>> different mechanism that can be used for this type of operations?
>
>devm_clk_get_enabled()

I will look into this and update it if it is the case with the review from =
the v2 patch as well.

>
--
Best Regards,
Ramona Nechita



