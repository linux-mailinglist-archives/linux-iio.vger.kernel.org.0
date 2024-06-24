Return-Path: <linux-iio+bounces-6817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E85915239
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AE91F240F7
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37419B5AC;
	Mon, 24 Jun 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cALgQjGh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6F19B3CE;
	Mon, 24 Jun 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242807; cv=fail; b=RgetZrw/BZXPVh0bjFHQs1TNqlyMinKydPktkjtkeCcl1rb3B/0rkccWn0uTEjY1N5RQODXHx8k9XKkU4MahiZI8xjtHFLai11a/H0cBTnGaGP7nU8VGdPX2WPylOhon1uEVlTULXf615iCuuOZGkhNHiwju2zduLESFne0SZEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242807; c=relaxed/simple;
	bh=CtQCo+X4oJRiOUv3fkp8lPxJ05W5xtrR6ioYIVPoTbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ie8GvMyMzE75Lpnk0Eh5OntTsZFK7ESPlTGPG7nnkQf1VhXw4FUXu7OHcEQbZZTZ9MvGBNajAoVk3Ruha5Ac4arIlC94+8ERdB5Vs6xRLlw3dw2fNmE265K1A5F18fV5RiFoyXwe1X8axphqHqgQIy9+yNn7fe1MpRmAU/BTJkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cALgQjGh; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OBg5ZT031303;
	Mon, 24 Jun 2024 11:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BHhpT
	BTwhqWzTCkjvsJEj+AwVMXrfkEByMrYh/Ea9Oo=; b=cALgQjGh99xtSCo62i50O
	QvxUf06rw/HKNtev5iZZWLk3M9YRP6NUewHa027VWYWi7crb5OW7FYZFuePsQSR5
	6nJcQjN6997u3v1aviGGPmxFhtpn4Iv8VGDchWHBgcS/CmKwBLcfuCNhro+FYSFZ
	wO64Wwz30cMjDf37RxY9wyur/bJJBmyNfgL+X1MTC9ERZmWWAKOs6K6PMrk1aHmR
	sykbNdMBv5/YNW7SI9QfaF55ESKEFdr5QsX0YGly0KbjKLHISZaDMvuBvv69c1XP
	pnlq87k67unQHhkdhblErpnoB62ypoHmvdRIdIDiAujf1S5aGJ+5yi3i3cGqjdTD
	A==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ywuh2eje0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 11:26:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dnm/I/pdRm+9qi3t3WfCeWW4DtzGHhBihFJQLHCGfGT2lSXYV1zu8TFL57JdkFk5wMHyJmRF7OJmYO84Yb/NtQMVEbuzty1wXjS9X1jxkdfPTB+OR5qDGLCm82EF7KUCK8nJNrpyAUxSo1PEbe55MF2oYa90Av6qVisi+vAvkcr9+mJA2RSgKnVYLpzFO6sNd0vjcyRNrKIT1lSjaE8S0N+6zQq4Q3POSSvpz+O/BwXONycw9Yq+oFsgEV8uo2SFS/xZcdfpfb1en9nvvJYeMmPiATcadHLtZAe3p2lPkSDMo4qiMLsPoDML/Bd+TsZh8UZuA74cUaXG9Er6kaop7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHhpTBTwhqWzTCkjvsJEj+AwVMXrfkEByMrYh/Ea9Oo=;
 b=f8FHci4l5tjGIfGyltbTwB7MOzxOmc7l+1kM42DHafVEQNlLjffjF/SCzmpRji5qaCL0lYaSCdYgeftRH63DtZC1WS9VjmvDI3SEw0pOW4cBDFvRZcKkZGUDJtJKn6ukuz1LSsEFNPEWisClQeKRXqUKMaGj3LNEgNe8MWJNbznhmGRdP2Pq/r2vWTwyWwmjDEozaKY+AiHbW1MDeMiR1YQ6MAN8VtqkveJJJWBeYwajwPUnqjtOKnKulym0xYBcRXm8NFulaf+udwhjdUY/vpY0IPjAXa5mmSTwoHOXbwCnovGQC0Jn2RuO53xDbjkuYeegMQITODwMmx2EpSJCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by BL1PR03MB5974.namprd03.prod.outlook.com (2603:10b6:208:313::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 15:26:27 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:26:27 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Hennerich,
 Michael" <Michael.Hennerich@analog.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Thread-Topic: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Thread-Index: AQHawhTpX5siFTyTZ0ST+He5gHIvWbHPYEeAgAYCRICAAa6KMA==
Date: Mon, 24 Jun 2024 15:26:26 +0000
Message-ID: 
 <PH0PR03MB71419D55571B07479B4F4FB8F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
	<20240619064904.73832-5-kimseer.paller@analog.com>
	<20240619-vanity-crowd-24d93dda47b8@spud>
 <20240623144339.6a5087cf@jic23-huawei>
In-Reply-To: <20240623144339.6a5087cf@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0xZDI4ZTkwNS0zMjNlLTExZWYtYWFmNS?=
 =?iso-8859-1?Q?1mOGU0M2IzM2Q2NmVcYW1lLXRlc3RcMWQyOGU5MDctMzIzZS0xMWVmLWFh?=
 =?iso-8859-1?Q?ZjUtZjhlNDNiMzNkNjZlYm9keS50eHQiIHN6PSI1MTA0IiB0PSIxMzM2Mz?=
 =?iso-8859-1?Q?cxNjM4NDY0OTY2MjYiIGg9ImNpUHBoUnFLbFZwS3A0L2w2Y2pTcFI3bnJI?=
 =?iso-8859-1?Q?QT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBQnljZHpmU3NiYUFiMW5NOG5sKy8wa3ZXY3p5ZVg3L1NR?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|BL1PR03MB5974:EE_
x-ms-office365-filtering-correlation-id: 389ddc30-a552-4984-3e61-08dc946203b7
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|7416011|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?OBo1hAtTl2JnOohdQdxYP3JOgKb6fiu1kLRLU+6YMJOz/hxrqmCi54GTn7?=
 =?iso-8859-1?Q?Vs4Z3Iimua9U9Tf2Sw1rkIF30cBIsWxeetjo+ZaGkBFMB+FP1bvBv7Kq3o?=
 =?iso-8859-1?Q?rdXmh0BrtZe5OuaDg+bGHueYZVlcsfCS123kQBv75UFfCSKl7yyodW5vyH?=
 =?iso-8859-1?Q?vLSANRV6IXpYQTil7J81qxaiCodsMkz0jtxCQ356MTP0TJMiUYPv7O86F/?=
 =?iso-8859-1?Q?o7tgUHJ5zW/cdHFwk2YSDyvZH5b60l8SJmwplSAlJUsWQ+0DtM+qWs/TKB?=
 =?iso-8859-1?Q?dd2DwBN28+9rPFx32INbWtX4ITbh+zVJj5MymwkHeS39p0HpDleqGfLZzD?=
 =?iso-8859-1?Q?/7busHaRq4s2Fz1Dq95mQW2awauIi9jdrUEu0Kp3vMyuyOwHzkr+k2FBde?=
 =?iso-8859-1?Q?HUwXYlkbuLxWeF3TbUq8MXhIr0Nw9A7QxO6ISSrbzxJq8X9djiIWhJQdMQ?=
 =?iso-8859-1?Q?eyvLlJvA5psrdd+9UZ6GLdBI8JDiU6dgsTjSxqn0hFnnRg8BHPqN2pqeoN?=
 =?iso-8859-1?Q?Wn+bP/5xk4WwA5x5pPg0byA0MZNAun+8CSEVjHnEKUwhEvNVorAaKqf5ZQ?=
 =?iso-8859-1?Q?1+jvWcmS1plwcLlzmhEbJgvfi3d5CjrEGve7uC2PkCfhPOKuI/saUFlhXC?=
 =?iso-8859-1?Q?85xTpS8Tp+KhkMa5lIUtwZIEH18yTnyfpmivH14+rp03HCNg1xWIDG+nBm?=
 =?iso-8859-1?Q?PQ/oBvPQ8YIylgxCJyqQYiDsZ7I2+xfklx5vLaCRYm67pwDn/IBU76CzGa?=
 =?iso-8859-1?Q?isb59G5AGOaZ4dQbesg65sadZGg6UrkF6Ez/jMenfBAPP5LslPLc5bnzL5?=
 =?iso-8859-1?Q?YH+OsinXAuanO5W3/oOudg3d07/KYlxL/okBCFylwPCbzJPbT0+5DwTNgl?=
 =?iso-8859-1?Q?l71+IjIIRPPQMxjKc0Xc+9CA4F4uUPohELQr6AONXHuZKg2oMpeHNtiGyU?=
 =?iso-8859-1?Q?i4Ws/1vuRIjsvfnMWhDVAvfnNNONk8Es0W04bux4pHqDPd8vOCzi9nXkRF?=
 =?iso-8859-1?Q?tvWS8yIhgLG+XZbSEzuTBYWuCAAbLKwsJ2x1+A1nmjP+cWL66077rx/8Aa?=
 =?iso-8859-1?Q?XFN6nk2f9zU79du5NKiNbNZVwtqecsNGMPtWe5ReDVbtt9sCQC5ROvMEjU?=
 =?iso-8859-1?Q?hKIrzw9MKEkkA1ReUrNuOhtL2XSIn07BBpM0RHO+0qOmS1R5SNcV/EiXh8?=
 =?iso-8859-1?Q?tVbGRdUXLQmYW2FToDrGm+8QHNcTV0e0lwFeU868a82OL0MNnu6avNjGXo?=
 =?iso-8859-1?Q?sUyYSoKjOGbSvRSlftYKEEkzH2fWOy0ATlpCZ7JVb3Sboi85yO2oO04NU3?=
 =?iso-8859-1?Q?St6YPOORnKNNg8ppq4QMW8iDpZcR3CllC3ggpbuTUo1G4XVW0Mr0RCnmrR?=
 =?iso-8859-1?Q?Hd3MzJgpS8HBSzZpG925cz7XhHvEPxKeb89o9Sa0tGCt5nnMocT10=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?nlif9qh9B0MddMHxD61Hks9wWdBcAAVajQ+dd2+UtPD7rxsiTFzrmVq4Rj?=
 =?iso-8859-1?Q?F/F1Hg8c2QAGUO/7gIXMFxdYo45TCKply+3IfpTo8OxqHO84ugzPARXCRy?=
 =?iso-8859-1?Q?Ju7YQgsdvRODRFg5wyTB6eSCNqlBLx9GiOUpGe2kQuWMfFrJN7IdBizGwx?=
 =?iso-8859-1?Q?yTjbR2Pbuz6Zc2D7h3wpChtFXvr7GtZV1DG52nvYIMjS89d4kIIdsTLXs3?=
 =?iso-8859-1?Q?wQ0W2zle2QstVqdUFJNi4ylLUxi7Xoj/lYAPCtAT6Io0drq6bsDuF6ekfr?=
 =?iso-8859-1?Q?lKBD2r4Bg/wwE2w5ytPaVV8MMI26Hvj9GNsAfnnQdJtjhQ5O5Ss79cTdLB?=
 =?iso-8859-1?Q?RGCfShjrngfRlfSkZU05GhGvptif8Zy7syV2ElCfjnq7k8PoC7fb2V1oLX?=
 =?iso-8859-1?Q?irJXZ/25MxWQ3wlCoGfr5bzTQtmNLoTbNW2ba/Am5hc7PMVZ8zoBJhOMqM?=
 =?iso-8859-1?Q?2ze/5atNYpU+g2ypWCHaWkeUlk5IDN53cFyFpRufyirhRVe2ipa/ACjLXp?=
 =?iso-8859-1?Q?dm2vdFce8I91mWLRB43NIeOVlolwCTvg7HX4Pa50KYWa5KdsGVaQH3o0OO?=
 =?iso-8859-1?Q?oUQOESYW462XujZJXDHnrcc6EU01Qj+ZEP/o//cFcxANj8BFuYTyyprmAT?=
 =?iso-8859-1?Q?1hrVg0w7QzPoQ+leJl7naXOaFse3EzmqU/Fhcfa2fzoiVsmeoTB8JKLJt1?=
 =?iso-8859-1?Q?i2bm4UQbYPgWr/F/9K4vRBs/xNukwHA3CcrcTDjIbBDyLfjkBzDqvieV0T?=
 =?iso-8859-1?Q?7IL6vB80ukRJLXBlaCUeoUEq4gOmATdJvyFcFCLGJuelUiWzH7hFW8S7FX?=
 =?iso-8859-1?Q?6Y0VmXwLTwoX1rI2AJosUmjkGjMSLnxfQXta8q1du9781Bk2DGmzX6Jx8C?=
 =?iso-8859-1?Q?zrVyTK+lxaKuDB/UjhA3su7QDTjT5yX8uTvcxaRjGKWPsxuUT4R7fW0t5p?=
 =?iso-8859-1?Q?NpJ6YxEPtLBsgWm5cW49jjM1OAY2KoQE7KwWh6AwtSwTvkIHC2kYdWFY1l?=
 =?iso-8859-1?Q?+EpnHmVpjvgVyTBJbwDNc55uO9T+zRx6eK6NgAQFvbx9mDCp0QdryH0wk1?=
 =?iso-8859-1?Q?FP6a0MjgB2Fn/H9HwuiRZN6o0LBx3fGZxfDGCGyeJ15RaWAvVX05eD1Tsw?=
 =?iso-8859-1?Q?i7Eu0Cn6lvoonKDtIVKUR5wdf9g6wWVY0vb8VS3YjNKAJ3PfqDU6tfScfN?=
 =?iso-8859-1?Q?xyfPp7Gg6X3BG4RfOJaBDJkQrWDY5xbCY7YFW9iMSJRIYAI6DuZTQYto+C?=
 =?iso-8859-1?Q?jRj0WfUOUtJ8m8LR7vH/Usl1yM2AejE27hm0JAcRA9aLl6Q4gIQ8R80LIx?=
 =?iso-8859-1?Q?vlxPo6H1xKwvO9EuiRaMpbbQfHIgADu4YxUJA5CDJs5E7NLKnsQq+cINmJ?=
 =?iso-8859-1?Q?LoV3wY3adot4rxi0ps/cdFz0FArXMI05/dDDYLhuOusegbhPuyW+w3Myzv?=
 =?iso-8859-1?Q?ug3lNIlDyu7Ddsd2nnLsek6rZG7n3LtK8vxHa8TP5BdmqEwUbeQBaTOb5p?=
 =?iso-8859-1?Q?xskkRFJF+9gADxJanmkr6BROxRMGcG9Ac4sSfMwOuObRSCHFZCl4ivPGeS?=
 =?iso-8859-1?Q?OMNXVIlR8nuLPSBXd7HKMABAnrlRpU3ex37gKNlCI556GYAmtaNH+MvRkZ?=
 =?iso-8859-1?Q?Rm/Srz2n2kzZ9MBpjA4A7Dm21HUjTHHDKK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 389ddc30-a552-4984-3e61-08dc946203b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 15:26:26.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpNGNmIETORXp+Wi/2aLungctFtyGVrN9swHcP6Y0drXCaviKJ78mJbWWU1vyJPvHx3KfVo8SssxlB4HW5EutCfwxFFFPJX7lfwpn9SAnPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB5974
X-Proofpoint-GUID: E8FyUvkaXzr43x8QrHsMNwdpi4fIMK0S
X-Proofpoint-ORIG-GUID: E8FyUvkaXzr43x8QrHsMNwdpi4fIMK0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_12,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240123



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, June 23, 2024 9:44 PM
> To: Conor Dooley <conor@kernel.org>
> Cc: Paller, Kim Seer <KimSeer.Paller@analog.com>; linux-
> kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kernel=
.org;
> David Lechner <dlechner@baylibre.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> <broonie@kernel.org>; Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor
> Dooley <conor+dt@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
>=20
> [External]
>=20
> On Wed, 19 Jun 2024 18:57:59 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Wed, Jun 19, 2024 at 02:49:03PM +0800, Kim Seer Paller wrote:
> > > +patternProperties:
> > > +  "^channel@[0-4]$":
> > > +    type: object
> > > +    additionalProperties: false
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: The channel number representing the DAC output
> channel.
> > > +        maximum: 4
> > > +
> > > +      adi,toggle-mode:
> > > +        description:
> > > +          Set the channel as a toggle enabled channel. Toggle operat=
ion
> enables
> > > +          fast switching of a DAC output between two different DAC c=
odes
> without
> > > +          any SPI transaction.
> > > +        type: boolean
> > > +
> > > +      adi,output-range-microamp:
> > > +        description: Specify the channel output full scale range.
> > > +        enum: [3125000, 6250000, 12500000, 25000000, 50000000,
> 100000000,
> > > +               200000000, 300000000]
> >
> > IIO folks, is this sort of thing common/likely to exist on other DACs?
>=20
> Fair point. It is probably time to conclude this is at least moderately c=
ommon
> and generalize it - which will need a dac.yaml similar to the one we have=
 for
> ADCs in adc/adc.yaml.  That will need to make this a per channel node pro=
perty
> (same as the adc ones).

Should I proceed with generalizing common DAC properties in this series and=
 does
this mean somehow removing these common properties from existing DAC bindin=
gs?

>=20
> I'd also expect it to always take 2 values. In many cases the first will =
be 0 but
> that is fine.
>=20
> Jonathan


