Return-Path: <linux-iio+bounces-5382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9010C8D1413
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 07:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1695A1F22BB5
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 05:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884F4D13B;
	Tue, 28 May 2024 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hw+c1S3T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD9F4EB;
	Tue, 28 May 2024 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716875623; cv=fail; b=V/XdJmePsCcEBNC7wCx9DDbm2amQQ6tGpIylViWteGzv0dngKWGj/1+e0o5zownkA13vHPeupjGANbqY+O+UQWLFFVsTP+PuK+qD4OZiEDFhAJgjIplmywpVI5CrF73Byu2x82uID3hJ+8E5+VQ/FvtV/3tlYxrSDmnZCRqNFaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716875623; c=relaxed/simple;
	bh=9BmffTM/MEiXshO/Bl+J9MdLzYMYO/Qbw+ZnMpJQkFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sw4QmxhyHOHwi82GsSxjEvcNVJIkghw+xqGmdOOzjcjrgzTgCuBUBHHTAA105Ij8+nxwEX3Ymia2S7/b+wlgdAJXC4E944nWqF+6fZkLd1Fk00s/zRKFsa4vv5I2qV70O0yO+Fc9UuLRWRsZFHKIiD57jxJXN7r2+iUaQhIE104=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hw+c1S3T; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RMXX8w027189;
	Tue, 28 May 2024 01:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=o7sWZ
	l4pt027ohNdlAlzgi3qele/kRwdBCpxjym8DEA=; b=hw+c1S3TAxvWDrtp952xc
	5K39eZ8jtI2LPsQNcrAl5iw5Yh1aBmaofL6UfhidMf7gWoQm9Gi5JjC9ovGTzEY4
	YS3yDXmBDIsJL5Ur/JBQIH39rfIZUk5901vg1nugKc62Ci4g7cm020QnXktNmf5/
	sKSgex2EdlzqPklH/4VVuIg4zXWgvMmrfPjcirXI7ViQYans0k3hXfrNYTKdbXZP
	GJ569W1Och5NQwsShe2DfymAI1B7txpZgF8GtUz0JcmH0vEUzsccIL4E6AAFRoj4
	yvZE4kQbP6XiPxNIuS6jZPHJ6kbezr1TZT1o9F4XEkfp5gNve9sbAfvb8ro34CsR
	w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ybcm3r3n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 01:53:14 -0400 (EDT)
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 44S5gVmF013961;
	Tue, 28 May 2024 01:53:14 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ybcm3r3my-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 01:53:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUdIsuOjpMO33DLbfPgEacZlLeOKFp9e763D21aDvzKaKFM/oF6Nt3qrYx7hZ0MosGJo9XaF4QymHk36++g7U4yBNBmbaMfRZGmKlv/WMKtBiGM57PpdDLMp2iZbwHdnzfsMal3RErJCYezQEea6gRDNNnoGIuD1m1rnLzUbCWMv9L/lVuEMfbUQrIdNPp0gvEt4wFX40Z7tG0LWLwxpNB4h3CX8zl6vKfU4tb45fA3dVG/izInp6ow9OUE2bgi1TPTEQmsXEFcZZDrVpSOWKAMLvYnr+15Z/wu3yvCCN66+Nsl1vHMlMQ9+Bprxc7O3ROhzBQN18vpJnGe80gXZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7sWZl4pt027ohNdlAlzgi3qele/kRwdBCpxjym8DEA=;
 b=U1V2YwZzZoOsXg0MwzJuIWRcvaIMYug+llVVY7dYCtKCvsvpPgl5UixesZ2DCpqFbl6G2uEadLk0+LlE7hDSDostThWbN4cPfkjvLaPMAHNjCRNo+PYledQL3PAB6o4WEoyhLdYdgeKmIWmRH6BRwmNsXEpiubAviT2wg7bVKYlyJ8U+WEivbSdiVVQr101zHhvIllfc5c1L128ayVodoQivaNl+BlYhgDTJj5KWcHnoNCl+N9m6/T/oTCJ3tYRREXHuT+Dmgs/hw1Eg8cBk8hoP0xki+7Y471SzOxqNKeCMq6jzZEAvZUEO27arpjtXiVCd6pAgmnMdZfEhqWG3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SJ0PR03MB5853.namprd03.prod.outlook.com (2603:10b6:a03:2d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 05:53:11 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 05:53:11 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
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
Subject: RE: [PATCH v2 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Thread-Topic: [PATCH v2 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Thread-Index: AQHarTL5ZvaNfW73mUS5PgW0J4JQWrGsJL7A
Date: Tue, 28 May 2024 05:53:11 +0000
Message-ID: 
 <PH0PR03MB71413F8B4F8CF840E4AA6879F9F12@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
	<20240523031909.19427-6-kimseer.paller@analog.com>
 <20240523180210.00006b84@Huawei.com>
In-Reply-To: <20240523180210.00006b84@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy04ZDdiNWQ3MC0xY2I2LTExZWYtYWFmMS?=
 =?iso-8859-1?Q?0xNDc1NWIzNWRkYzhcYW1lLXRlc3RcOGQ3YjVkNzItMWNiNi0xMWVmLWFh?=
 =?iso-8859-1?Q?ZjEtMTQ3NTViMzVkZGM4Ym9keS50eHQiIHN6PSI5NDgyIiB0PSIxMzM2MT?=
 =?iso-8859-1?Q?M0OTE4Nzc4MzYwNTAiIGg9Ik4yQ0VUMk5VVzVPRjlHODVLK0M1aEUzMjVD?=
 =?iso-8859-1?Q?bz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBQVM5Wk5RdzdEYUFiSG5vblo4NHNpU3NlZWlkbnppeUpJ?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SJ0PR03MB5853:EE_
x-ms-office365-filtering-correlation-id: 2717ccf6-306b-4ad0-6f24-08dc7eda7559
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?2niPLoHsTK9JfbLjJYMH87+Aq0iiASRIw+818PzVpbibRtpY1PMrBRvsL+?=
 =?iso-8859-1?Q?Qg3xL/w26put3j+qhhE7SoZvfI03HmtsgNn7rKyGNmx9HhaXchtOS7/CS8?=
 =?iso-8859-1?Q?RGJx2A/FOHH1WZwC+5D+SV4flWwSCGhEJ9aYqdone1ueKqSFdWPcj2+PM+?=
 =?iso-8859-1?Q?WRwP/nGVEaEcRuHDFNYKpM0AS1MFLClo+0Tuf1J6mz4EWS+V5Xaj+v1sDe?=
 =?iso-8859-1?Q?K0keiM27ZM4gqcs6QUjJ3MWjWrMdHuuf0SQ0mom/QVL4dlUiGdeDOBPi3Q?=
 =?iso-8859-1?Q?JYKE0DvELoG07Crc8zl5S/SYoRKumOEJ3ZWCqcA3dZylnQVl4zrLh5OCZJ?=
 =?iso-8859-1?Q?9o4m9I5fzlRxOazo28jcTlGnE3D/slT4C7khGakbDHSwfB40hAt5YwnaDk?=
 =?iso-8859-1?Q?WDGsvLXvV6M2sWQo/aJoUNopRs4DnWcYH6kdOtFww3EvI1KvMNcAy8Hyp/?=
 =?iso-8859-1?Q?YJOAWS7pGj4s8dBC2knQk6QmDnvD+t+5VCs448tbms/cuzqGVAbSKmUGWT?=
 =?iso-8859-1?Q?1FBsAJhKAVzN7GwPe7dK8harruK0i1A5FwZItBiIm7W6XBuRhbdYf48uhP?=
 =?iso-8859-1?Q?skctL9Og1vwR8qu6lop/iqTBlG9jJAcw4muwrAlvWYzdW62W7qu/y+jhDb?=
 =?iso-8859-1?Q?0TkDmcN629OhYHhSSHiBCk3XPvAjOsjpVM22L57var4A/EVmreBLGGaqsA?=
 =?iso-8859-1?Q?uWekWCs8piBu5VQR2D0cfHSjtT9k8W9wq9p8K5ucsfI8ZCt8s/ECdDz7+V?=
 =?iso-8859-1?Q?ex6mLpXEtMBe/fFNuos8+8fwMTUSIoRWw5zLFM4P51jyeCRwNrOu76PU3N?=
 =?iso-8859-1?Q?3YNEDeg9rokWVovbYQlqqPthlqfHrf2KzBt4eEJIySO+Wmy5ZVOgM5fjDM?=
 =?iso-8859-1?Q?9F79FWzWK3W5ZnyCnnO2uDHQ2tEJZczra/9r9tQNRWbxTJmYmZ0hFuMHw+?=
 =?iso-8859-1?Q?YnIJ8eyukzb5bny145jvNpAVleQpGgz08VADlEn9xB8AVN/lY1vVHFjHfV?=
 =?iso-8859-1?Q?9tVaqFGSyu1Iz/rHt0Tx+VHV8D9lZkuzbFNyfbBFrjQwFH/0oHlXyrfL0w?=
 =?iso-8859-1?Q?Ckgq5hjnT1JSOcapl+ldzhctU0uQEYLQmOPpiOddLEcWDqTcWGNCv7ldkF?=
 =?iso-8859-1?Q?E+JHKZB/RW9IkOoc45dEQycYCzghR0O1jzUQhjngvHtBlENnUSg0H4GGmY?=
 =?iso-8859-1?Q?a4fsE+sZXUQ547sosR7DfBcDQ5IQQbNmeVHe5eToar70tSxB7Vf2MT4G3H?=
 =?iso-8859-1?Q?buOHDBzF7XrjOITYimZi8yI+lUh0ltcjl9hZqiNBZdYndlqO7pbCLm6CIF?=
 =?iso-8859-1?Q?g07ZWCWOIefYaHMgG5ys6cK2MxhWbui/WjEeQDWRn4g/mKyE116UhZ4yN3?=
 =?iso-8859-1?Q?7C/UvNQ/UNr+rvsih6cNtmPlRuiAWYJQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ULhBPlTLX2BH2T4aEg3sn9PLhIPIwiEBP2Q0kwAjADTAcejuNdFAv9WfDj?=
 =?iso-8859-1?Q?1H7/RpDwVj9epJRihu4anXinbZBvjxeIF18S3NaxalCBawzVbYieZ7cQis?=
 =?iso-8859-1?Q?dWH6OsBzXOX40xp+kedN6bmEBqNsXv5hOfY5Y6O0EPXyavsgVNNEm+DGvq?=
 =?iso-8859-1?Q?3Cb/cGsfbrNgmwuu5ovqAgtt++CVYLRJHjqRVx2ac729Ti7BoNrq+IlBJX?=
 =?iso-8859-1?Q?XjGTNu2KfdPsxMMVagslkAt5sgtmo2Eq2WsZS3URKaW8v4R0k+ypP3L1/W?=
 =?iso-8859-1?Q?f0pHVTzCCzOwSe/BYRsDGzpS4ZmiamN8p1bewA/tlNFl50LkkEQDsDrQi7?=
 =?iso-8859-1?Q?tfixkUdWL//ZDa2URiHsYKSWfH2DEBE1gPsIE6khQaVODYMR60XE+6bRwD?=
 =?iso-8859-1?Q?BcaG58Cautj8R7Whm3agWf2KQLT5TLm/2BZ2nGHTEPx66A2GFUTM6KgL0N?=
 =?iso-8859-1?Q?LrR6uwI8jwRk7ouOR6Rjr9YyQckFSJfqeKwAY4VeQrbGAkZzIA731EH6JY?=
 =?iso-8859-1?Q?KGKcKuJk9fw17wm65LpgEm8kKKnt6uZWn6VKT0EILUW5PRV4tnGB3mC3Tc?=
 =?iso-8859-1?Q?fQPjUDtHQZSO5FKHsoVPyUXz7fE124AZU+RotbrKc6FVdqXLT9ZcpETAB/?=
 =?iso-8859-1?Q?2ofXNLRTmPvkilTJhSWcveiPbxWO82WO7sfQv9hZYwGjSJgvCAjsYUw3JS?=
 =?iso-8859-1?Q?EW6uvKKwmE+LijV96DJD11xqr4UdGPmL1hPd2vWgIK6+/x/s0ALu8PTIeW?=
 =?iso-8859-1?Q?3994acddOHJoCgzxGk4b8AeKPQ3Mq2VMj6MUGO2tqeI6cf8+NU1FzxQBFU?=
 =?iso-8859-1?Q?cmFiShHFUw2zV7S2O2vlKJwDacC49I36g2+d8r1MKhAkYrvmtK7R+C6ajg?=
 =?iso-8859-1?Q?akIUmNB/xAt98ktNmrgU6NkialH336VaSi1MoHvjlR6HxsfAdzro5OF+6W?=
 =?iso-8859-1?Q?NTBVAlZmVyhmQw7MRKuoF3pMUCFLuQ3sDVzwCM/orwULhVQJ2eMRQR7eqE?=
 =?iso-8859-1?Q?j89/0AyoSjj9SCrdzjE8LzqEQUTVnfTrDqucJLhITUUdg2uAvRcIpNx4UE?=
 =?iso-8859-1?Q?ybQBLfR25HswtKFmXRDJYARn55J3qvkzvNzhWreiZc9ezzrYhvjO/ygsIw?=
 =?iso-8859-1?Q?LUvEL+KG38fpwmh6XTPyBVDjzTMvve4YHUiNYAuZJzhj6sOxox7cqpvnKn?=
 =?iso-8859-1?Q?vW5vIlHlMreQPzS4idQP1w4HLcGVxUmCclzmSvmsjnt49ed/QwQKxWKISk?=
 =?iso-8859-1?Q?5l86tZTI9un39SsHSWanplBkewGu4uKPTEdFfuO41kA978JI0pO9iTi920?=
 =?iso-8859-1?Q?nbbOpEDQQGgbpNw5w9Aetiu65s/80nWVK1W14b9JZX0i5lEvKFbK99Q8LK?=
 =?iso-8859-1?Q?5L/csrZFfwyN8VP5Bd0BfQdnW8HU0aT8WMOBLWWeipp0SClhKSjzMAo1bu?=
 =?iso-8859-1?Q?QNxJnOOvBXqqTSuONfIkv9S75wCt4qdDdokA3JS8ExQUBjEYWhtZFX+eRj?=
 =?iso-8859-1?Q?I5UvsqgtmYc8nwSyPOrWb684JDv8lGhTsPA1Tv+lgvs7BqYuPn9jY8gZ16?=
 =?iso-8859-1?Q?Fq9macs7v7KuY99ZLtszAaEYS5Vt7tFafY3S+NOVXgsQG2nKIRPYz6fJZy?=
 =?iso-8859-1?Q?ULtKEhdMbJ7dN6Ca/JBUtIVydDtYJSW0CB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2717ccf6-306b-4ad0-6f24-08dc7eda7559
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 05:53:11.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zl4gu6KDhEFs6hoYFUC6iLHcLxif3Eo43Vj77/q8oVwxBWeS8VcWgQl+qLuF23bUSYzkisnSYhANfVX3EnbKw760qRCCqwfGTunW8ReikQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5853
X-Proofpoint-GUID: q_N0ggMRJNdIg-849q7zZvCuSjZEpxBb
X-Proofpoint-ORIG-GUID: 9qEwLi5zPhFuIdRiqYiZIECx4LEhmBu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_03,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280042


> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Friday, May 24, 2024 1:02 AM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; David
> Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.de>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> Subject: Re: [PATCH v2 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
> LTC2672
>=20
> [External]
>=20
> On Thu, 23 May 2024 11:19:09 +0800
> Kim Seer Paller <kimseer.paller@analog.com> wrote:
>=20
> > LTC2664 4 channel, 16 bit Voltage Output SoftSpan DAC
> > LTC2672 5 channel, 16 bit Current Output Softspan DAC
> >
> > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Hi Kim,
>=20
> A few minor things inline,
>=20
> Jonathan
>=20
> > diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> > new file mode 100644
> > index 000000000000..488b841e6c66
> > --- /dev/null
> > +++ b/drivers/iio/dac/ltc2664.c
> > @@ -0,0 +1,802 @@
>=20
>=20
> > +static int ltc2664_set_span(const struct ltc2664_state *st, int min, i=
nt max,
> > +			    int chan)
> > +{
> > +	const struct ltc2664_chip_info *chip_info =3D st->chip_info;
> > +	const int (*span_helper)[2] =3D chip_info->span_helper;
> > +	int span, ret;
> > +
> > +	st->iio_channels[chan].type =3D chip_info->measurement_type;
> > +
> > +	for (span =3D 0; span < chip_info->num_span; span++) {
> > +		if (min =3D=3D span_helper[span][0] && max =3D=3D
> span_helper[span][1])
> > +			break;
> > +	}
>=20
> Sanity check for no match?
>=20
> > +
> > +	ret =3D regmap_write(st->regmap, LTC2664_CMD_SPAN_N(chan),
> > +			   (chip_info->id =3D=3D LTC2672) ? span + 1 : span);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return span;
> > +}
> > +
> > +static int ltc2664_channel_config(struct ltc2664_state *st)
> > +{
> > +	const struct ltc2664_chip_info *chip_info =3D st->chip_info;
> > +	struct device *dev =3D &st->spi->dev;
> > +	u32 reg, tmp[2], mspan;
> > +	int ret, span;
> > +
> > +	mspan =3D LTC2664_MSPAN_SOFTSPAN;
> > +	ret =3D device_property_read_u32(dev, "adi,manual-span-operation-
> config",
> > +				       &mspan);
> > +	if (!ret) {
> > +		if (!chip_info->manual_span_support)
> > +			return dev_err_probe(dev, -EINVAL,
> > +			       "adi,manual-span-operation-config not
> supported\n");
> > +
> > +		if (mspan > ARRAY_SIZE(ltc2664_mspan_lut))
> > +			return dev_err_probe(dev, -EINVAL,
> > +			       "adi,manual-span-operation-config not in
> range\n");
> > +	}
> > +
> > +	st->rfsadj =3D 20000;
> > +	ret =3D device_property_read_u32(dev, "adi,rfsadj-ohms", &st->rfsadj)=
;
> > +	if (!ret) {
> > +		if (!chip_info->rfsadj_support)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "adi,rfsadj-ohms not supported\n");
> > +
> > +		if (st->rfsadj < 19000 || st->rfsadj > 41000)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "adi,rfsadj-ohms not in range\n");
> > +	}
> > +
> > +	device_for_each_child_node_scoped(dev, child) {
> > +		struct ltc2664_chan *chan;
> > +
> > +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to get reg property\n");
> > +
> > +		if (reg >=3D chip_info->num_channels)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "reg bigger than: %d\n",
> > +					     chip_info->num_channels);
> > +
> > +		chan =3D &st->channels[reg];
> > +
> > +		if (fwnode_property_read_bool(child, "adi,toggle-mode")) {
> > +			chan->toggle_chan =3D true;
> > +			/* assume sw toggle ABI */
> > +			st->iio_channels[reg].ext_info =3D
> ltc2664_toggle_sym_ext_info;
>=20
> chan->ext_info =3D ...

Hi Jonathan,=20

I noticed that the struct ltc2664_chan does not currently have an ext_info =
field.
Based on your comment, I'm considering adding this field to the structure y=
et=20
I'd like to understand how this would interact with the iio_chan_spec. I'd =
see this
by adding 'st->iio_channels[reg].ext_info =3D chan->ext_info' after that. I=
s that right
approach? I'd appreciate more details on how you picture this. Thanks

Kim




