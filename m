Return-Path: <linux-iio+bounces-7190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DD89252D3
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 07:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA151C22D96
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 05:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3849644;
	Wed,  3 Jul 2024 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="W8ud0cuf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27ED1C69A;
	Wed,  3 Jul 2024 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719983525; cv=fail; b=l06qTZR5L5w3X6DTHlWLytEj91yWf23khZ4lKwSqLG0LIVdoz1ypPbovmsc8eb7wAGsB+isEpsaoQ3OflgA1H4RNK6PYXlg5N8zVOgmajzgul/x3LVxHi2SfFqtS0IpOTRTjbEzLFwdODpE00TzENSI1HHiphOqqU30Sx4cJreA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719983525; c=relaxed/simple;
	bh=Bkp+rn/x9u56ZSCWfaeVD7TjNNN05yQQvKQY8mxdM2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qrWa5oXucrytTAupOLxf3XkLGwzJS99lHl+W47iwen7MFzbEN/hqgBYiaBZIbUE/oXGRT0RBW7EZulc5aMwEjuLKqNhQI8mOpUKBn1RslhgeihuS2KY0gpEPCx+ZkRBp0CyyJi/pBF1KUmTT2y46XbQq8dvo8gHvtgFbETZfs0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=W8ud0cuf; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4631DVt2028748;
	Wed, 3 Jul 2024 01:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NcACy
	q72ocqsUlUaP1uXKTAW+dkgQoj+uRnLVAAQRdI=; b=W8ud0cufgVqTvpY+FmRsn
	I0jQs8sIBR9cLvJPHYR4ppAkqRXNO/X1b1BAQpnpaEF2elTpjmRq/jbHpa1dF8Xn
	4oEx2r9AQzRzzOeue2iZQbI3g2SS9XBV/wq+56fKLvQwUr39LBoZi87qjetLO4Zf
	pR+ARx5YEiB2JdpoXNYd0MGWkRSf1MomqmSPW+9x/cFCFjuTXocrEBCBV4TrQJtk
	eUsY6cCZEx5H5kVyK3UEt/ksS4bJ1ikuGzRqWIWCLfA6Uv73QpmtUSMnHsnXJmrC
	338um6HLFJBkCnll2C8EWgMao2Zsvk90Ke5FFqT4zEMOFV9gEDRiAFVnyMM+RfZz
	Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 402ew52kw5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 01:11:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMkyRgKhQ36CpellnUsbWBJWTmGHZfOFqilH82lM7Bv3u0Tr+1USg/RTCyL/mNfGgLTbQUD8qma0QYQTj2J0qmHxtuWF9wdy34DaLb8U9zdg8VzepBm/BXrMuA6vCM6kqz9Oy1RB56FvqVUGs0V1HfnRlOtwezZMpArhwjLe0DATk6YRiVhJz9dd7t+N1MpNvIpb0Lk48v2r7Y1ZGif3JjPjW3M12XM7mPNho74I+RNLn6fQCGmZvlEjx8GFbfRP9Z6Suo2WGXG4P+wpX6vB1yeXokQGYVEBFreiwgNzKs88vtPIwwY2DumhrZodERcIVpzKOzoyeHusf3S+XDIECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcACyq72ocqsUlUaP1uXKTAW+dkgQoj+uRnLVAAQRdI=;
 b=cOqE23A9BsiD72JYQfGStZM+v4c7fzcjv+ZUHNBSEkYFqFeTiqgWs9xLIL46LBW2lVMKktgZNiUxA4JU3tliTk2KmyOaaWqZhe0fXLZLS0w+HI1RrcdGeB/5vr1rrU3ZekqcB5/ars+/pBhk6mmnRbstRN/+hhIz2lhF/9JEiv07+GM/RwTZODgu5O3cfj+1B1bI/+3IbcnKBLnxZaA10pWO1e9nGCPqDuhLPhdW1guOJwYaFZvN2ItkJCUyq7olLz2ey2kXYnmiW4IND/tsUXK2ZjcpOgHBQ8VydVaPi3pv7LVzSGTZ1XMCBhmwzi7HxaseZWzODqLb+jC+ooq19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by DS0PR03MB7228.namprd03.prod.outlook.com (2603:10b6:8:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 05:11:39 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 05:11:39 +0000
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
Subject: RE: [PATCH v5 3/6] dt-bindings: iio: dac: Generalize DAC common
 properties
Thread-Topic: [PATCH v5 3/6] dt-bindings: iio: dac: Generalize DAC common
 properties
Thread-Index: AQHazCwgj3SzhZ8j9kex5R/DC81QobHjkOyAgADkR8A=
Date: Wed, 3 Jul 2024 05:11:39 +0000
Message-ID: 
 <PH0PR03MB7141C47BF2CB619B2097FD95F9DD2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
 <20240702030025.57078-4-kimseer.paller@analog.com>
 <20240702-candied-heroism-beb1d66ca352@spud>
In-Reply-To: <20240702-candied-heroism-beb1d66ca352@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1iNzNjZDM2My0zOGZhLTExZWYtYWFmNi?=
 =?iso-8859-1?Q?04NDNhNWJjYTgzMTRcYW1lLXRlc3RcYjczY2QzNjUtMzhmYS0xMWVmLWFh?=
 =?iso-8859-1?Q?ZjYtODQzYTViY2E4MzE0Ym9keS50eHQiIHN6PSI1NDEwIiB0PSIxMzM2ND?=
 =?iso-8859-1?Q?Q1NzA5NTkzMjc1MTQiIGg9IlJFTS9NelhQaWZCZ2p5aHRPYU9raE1OWTR1?=
 =?iso-8859-1?Q?MD0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBQWFzVEI2QjgzYUFVVzdaL3oxbm9uOFJidG4vUFdlaWZ3?=
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
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|DS0PR03MB7228:EE_
x-ms-office365-filtering-correlation-id: 780765bd-9f59-4f31-e392-08dc9b1e9eb9
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?14TRtiUoH5YT/SCB9uw1gCi4qg/jLmJxCXvGsTdmQ66mB9Ds4LyQAeetwq?=
 =?iso-8859-1?Q?XZ2nk2mHFMZF6ai62sJioterz/zlXOyC3pt60PVmS47FC5sRoxpKEk4BG5?=
 =?iso-8859-1?Q?n0TFnbymqifmzZiV+rMgmzioZspfIRrPc8Z9zKol3oRLskD87/Iw70bG1Y?=
 =?iso-8859-1?Q?HZ+HLuMiHVFhHSriDirN+A2nU+8zDf2e1jbKtVbg2/mXxZkjihkSZGRdo0?=
 =?iso-8859-1?Q?kZgZiHV8b7kOk0ysGp48FpNC/9YKTUMztY123kbLTg3Hr7b462zgtMmPwe?=
 =?iso-8859-1?Q?1QB+udIllXHjg3Ha1N3sWQ/XHIy6eLFbwz2BCzFrfJEx4WiYc4UR8jA0ni?=
 =?iso-8859-1?Q?QCXSn6JjAb6ZvuR64bYpuCvDMkC8vCdhzyDPqnpQY1Pn5tnwApUQBIpHt/?=
 =?iso-8859-1?Q?n5oAbwwIOfRjz5KS1FW2z1OpCc+Ybg425om/bS52An5M1ea7GKBtum5RT4?=
 =?iso-8859-1?Q?rT1dYPwPlU/WT9MxVk4po5dHPgooxNPosaBs3Q6Hj7VhvqH/fqQDlXld1N?=
 =?iso-8859-1?Q?ZJ8DlycXZEBJA0LJH/jA7z/AnrWVUEB9vCDGiASlzagCDCHZQBEuEZkxMs?=
 =?iso-8859-1?Q?DZc24QZfHvixG99eY78+ZZFoIXNx3zKqecR6tllgHbJm0pf4b/7O8bBZHJ?=
 =?iso-8859-1?Q?Y7NYIhQ7XV46n8gdkqnWCdq4Mec+eJh8BeamSN8Z2FHKn9HEuurmTDZzAK?=
 =?iso-8859-1?Q?7jL5NPmMTLfnirCWdqRRvWz0qgSA8vVMtreEU5mmucrMz7Fqz3GoqXijFu?=
 =?iso-8859-1?Q?TDHPZL9hEJmquZbAGZ4v1hvvpHbP+cxhAUc9i9x057FhsMER+4buOFcN/f?=
 =?iso-8859-1?Q?qQ0NBLLjyi4LFMxT26uqySRnJ4u9ubf/5Xx4KpUKfymIH0DtO+8H5jXxVH?=
 =?iso-8859-1?Q?LVsREytq64K0gkRZUi6UF+ol6gdoi7ZC/t5Dcjsi4XKoxprCkznXJoP2ai?=
 =?iso-8859-1?Q?CNBmRVsK2mIp0RFXnR8h+uFvxhg1RT8TdO8aHHlX4TzNUDrIePk3noqj4l?=
 =?iso-8859-1?Q?rwUBLKk8yuul3Wqf5uUe24/n+y+Ix58bo0YQZQ9G5zsjdRgcwHd9Egw1l5?=
 =?iso-8859-1?Q?QHS1xfU3CRwbwSoAGzlOM0RDeXgEwJ4sopDnAK5nLgJ621vN5hBeZ45yUB?=
 =?iso-8859-1?Q?kW2LtESrpXjFq7uGVbWKTuKNbuXLNKh7XS3TGOCbmskt83N5QndzcRFDYI?=
 =?iso-8859-1?Q?jCdNwSGig8st6KRoqhxvnIA+ABTpceEmDLv3Tm5TCfNQ9WVozPheRGr4A2?=
 =?iso-8859-1?Q?qY/tuTZs28qh3uFd1f6JK+QHQdm8KZhz8GW0PTytQOO5teocML3Z0+mRPZ?=
 =?iso-8859-1?Q?KJfOngLkaPOG9AEQkvZ4mE7PwAgUdQfQG5KealIwpQWJ0rPPsTyYGoPhW4?=
 =?iso-8859-1?Q?3lhXzl5nPOXTGs7UR6pMkxpV+wywLsK1JhLZo5bGFsaGqJfJBLuHY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?do70XyCzrF44rf3lFpqzHNW/WayC21DI/aU/aQwNMamMa17PitUcWA1SQ8?=
 =?iso-8859-1?Q?IF0dSq8JSEVWRAvFS2F0tnT2K2Y9W2s3HuXi2LwsQ1O6AYPrRz4KYzw03L?=
 =?iso-8859-1?Q?XvGywhPLU3kaK69hhUXII7eKNWQOV2E2HPNH04N8EY7EkkGcJj3ZqHa4oe?=
 =?iso-8859-1?Q?pMDFLnaJglyS3/6kxXKPWGMRXnrejmGDLzMIx5kG6uaB51v8PVQTXgCrfa?=
 =?iso-8859-1?Q?IW+YhqXGX9epujcq0zqLW72wNeasNPZ2etcQec4kuIa/XHK0wTAYyZFB9B?=
 =?iso-8859-1?Q?XLk/o2oUgqCG2gjNvpzaJRG5TCKw19UFQkwdUGhmpeGL119T/7fYXsuT4c?=
 =?iso-8859-1?Q?xzdfDl5ULojGmmOvOdsXLdylu8yKWJ7X+ew2QS4dvdgmPvQZ4P1YJc/1RX?=
 =?iso-8859-1?Q?2VNWNOK3Sq8kRwau9lMJ6lqdUqTImrTo1qEDDI/5kec9j3EOmDul249dTd?=
 =?iso-8859-1?Q?bto4CQBVQ7Vn9627yVVE+VtEq5SknOkWEt5bQnvNzMi8CwqHankKLJD1wi?=
 =?iso-8859-1?Q?bm6EoyUqtoDodIikh2EYh36k5wgaOtK1DzGvsWuLZ6AYaBZ7kkegq7f1D8?=
 =?iso-8859-1?Q?hfP8SCblBWmUZSZyzywxKudlz/waX1Gkp5n4fMjj5EM5YphmAFjQaEBNzQ?=
 =?iso-8859-1?Q?KEScms9zPL3SZz62+Mn52aszkCIJJlqZfRFF6R8niSM5ZLn6IELQa0ftKw?=
 =?iso-8859-1?Q?r33EX/XFYSutTDjoFmXZgd+LMiiE5ObOiA6D1E6uyg+TmQmWcMTCJhX9N4?=
 =?iso-8859-1?Q?x77M8mo8PixobyD5uVGBG+SHG+ho1btmcTzPuJWRQCHhQM+rKCdp7o/U+b?=
 =?iso-8859-1?Q?2AJ4pGAc/yrjFeO35GTOSl1w/7JPRkDOB32bMbGSOxhU7Qd3fKirxVGxLV?=
 =?iso-8859-1?Q?Y4bS19EGEVFwooYTsCPWZdkvDg0cYjbH12lgstdSNwdWAG+ybM9EdJXmRH?=
 =?iso-8859-1?Q?OV8X0dRr9P510J9evjPBQbVfiCjg6ySHzeY72g7EGF/TnU0Izuf+svfOWA?=
 =?iso-8859-1?Q?4tj1ifz0MoN9GwwEZA6p/+tUFcEqsob9i8ScxJbDTDnuVgYS8zZNPDFtbt?=
 =?iso-8859-1?Q?qYnH+g2KdDRUn8NVbegxCUkFo01a79uMXOJCKBdnJOBX1ezYug3JgvgkAv?=
 =?iso-8859-1?Q?0u9Eyp+ukEi0BfBDd1C3bEd/R7wjse1+GW4gqekuEZuVDQuuUq7urilCX3?=
 =?iso-8859-1?Q?Hpn61sQvhbCxRZetMEJJHovmGDGj1Aegfwb0pu68QPiMG9ByksSvO0mwRj?=
 =?iso-8859-1?Q?fx+xFZkcsz+Z9FIbW+dcKObEhG/G8zbdu4aQDMk4HhGMneVm04axl45CS3?=
 =?iso-8859-1?Q?fZFbsLr/2qlvqB1bVz2sDKKv5/DuUJJFB2wJMThQYYphakDDJ7g8nOavja?=
 =?iso-8859-1?Q?YQQXTS5U4dmWudRZvdRf0CFdYtEFzf1s+z9F6frCd7c0TVoQL+4/2lzH6I?=
 =?iso-8859-1?Q?v75H67UkNYU15IkOLxz9dTsVRUL+OVGDx2bk3tPFGXB/8+vs/92u4AOa59?=
 =?iso-8859-1?Q?omrEJCygQ76NHyWEXTIw/aGJc3eKGrWuiAv4YZrugoYopaAZ1mTGbwiFxY?=
 =?iso-8859-1?Q?NWJNDK8tKwCBtM9/s5CAQfhK74R84mk42xZxw3meBbuGYoGQgpylOHAm3Y?=
 =?iso-8859-1?Q?H9x8NiS0wiIZie/sndeusjaZBaVM8/EXM6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 780765bd-9f59-4f31-e392-08dc9b1e9eb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 05:11:39.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1PR2RlAKwCfg2bTKZimD6XqCwMpm1EALvLKZ0NN8YcDj3RPgfCp95znvgw8WY0ATk5/Hh2dQmc1o6qIfK5rGON5Ae5RPZ8BzLIZ0T8nOmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7228
X-Proofpoint-ORIG-GUID: Egn8MNwj0Ri6cF9Dvev2AcfrtRKX6ifc
X-Proofpoint-GUID: Egn8MNwj0Ri6cF9Dvev2AcfrtRKX6ifc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_02,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030036



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, July 2, 2024 11:30 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; David
> Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.de>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> Subject: Re: [PATCH v5 3/6] dt-bindings: iio: dac: Generalize DAC common
> properties
>=20
> [External]
>=20
> On Tue, Jul 02, 2024 at 11:00:22AM +0800, Kim Seer Paller wrote:
> > Introduce a generalized DAC binding that can be used by DACs that have
> > similar properties adding output-range-microamp and output-range-
> microvolt.
> >
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> >  .../devicetree/bindings/iio/dac/dac.yaml      | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/dac.yaml
> > b/Documentation/devicetree/bindings/iio/dac/dac.yaml
> > new file mode 100644
> > index 000000000000..579f52ea6eb1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/dac.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/dac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: IIO Common Properties for DAC Channels
> > +
> > +maintainers:
> > +  - Jonathan Cameron <jic23@kernel.org>
> > +
> > +description:
> > +  A few properties are defined in a common way DAC channels.
>=20
> "for DAC channels"
>=20
> > +anyOf:
> > +  - oneOf:
> > +      - required:
> > +          - reg
> > +          - output-range-microamp
> > +      - required:
> > +          - reg
> > +          - output-range-microvolt
> > +  - required:
> > +      - reg
>=20
> Can't this be more simply written as
>=20
> oneOf:
>   - required:
>       - output-range-microamp
>   - required:
>       - output-range-microvolt
>=20
> required:
>  - reg
>=20
>  ?

I was following the structure used in adc.yaml.
Yes, I think we can simplify it with that.


