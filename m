Return-Path: <linux-iio+bounces-9357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA1970DD2
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 08:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC90B2130C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 06:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5C18DF75;
	Mon,  9 Sep 2024 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="t4wVXqeL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787C171E5A;
	Mon,  9 Sep 2024 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725862964; cv=fail; b=mBU87m8jObOJXPuU16kqMC+vyWGo9Nl3NzFtV4YGLWnEL4Nx2xlhZMRsexa7GCALrIGkkHcq/C+cBJFJhnZkmGTSPrmmrZXlCM8U6MkJyWQKIYpav1po3IlXAQOM37UVPibMrHCem95Blu6Nbls0V+dw7XAf4NkAADdm9geSF7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725862964; c=relaxed/simple;
	bh=x5dVqDAQ7eWdLYe2xq62KUBUd8q/E3w4U1UhV6wFxaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=si9g59G02MjoIDmB9bcOc63gH1DOPxGl5OR6sxyfs8mJXU7yOlDhYYModhzOp8B9JcafsiVmvMMRTqa+J7Nb1Hu0Biin+6xKVMQek59MGvyFD/fQ8SMa2F0TDpxCTH0KNqedCUgWOxyREZVptrsPvtPoB3M9dg0uKUS221rOSBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=t4wVXqeL; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4890EjE4026494;
	Mon, 9 Sep 2024 02:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5Op20
	Hp3zzUcDJXZVF6f5gxHdzgVy9uUxrOhj4uXvdU=; b=t4wVXqeLhfCndeFxYp6SZ
	aN7COEfwWaR7jIF2YiHkjTl5PqvCPV3ujxBjZ6bZ/gB92pfG6DLhnieExsYzVBSm
	2NkzrahbDsqagcuZ/KIUf4x8xj83tQAcfANH08NB9pBB+dwoGeVADKMv+WKRG9XL
	mbpkyvwrmHZ7KG2reRiwrG9nXDlVI6l8LED4rXrcZwYHkvShAyGp6XYlT3li1BlL
	gNdgAT+rqlZp2/fKEk69CzcH7ED+FP6rnO1y2S47k323RX3mSMCiKps1b/fZ2BzN
	p5FZx4ccCWshvX5u+v88rRVTVffYF3LWbEB2iUm/oxaqDhQjqtjNJv/P5HnOzsgI
	A==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012033.outbound.protection.outlook.com [40.93.1.33])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41h8ve2bmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 02:22:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXAqp/I1FzznMwDiPzv91Q2+SYS3RpUDyQIXmrw9woP6eie/V7WOzzWR7UuXg+CDOe63/+VrAF5Fxbrwi8Dcd/nBLyS+axMfJBulZejh74X5Vj0AgdtVCePJKk7Jh5rYL+iqrYanVyq95zw/82FhHmbrMuEGwc2si3hmoLx2Go7Xi9HwNhQHs1QfepO1RX9ZmioEInyT8dmT2dod96zfKVb4eh5VBFDYRGudksD0Nzc+Ej9oJD8hScxAFNOZMrRMimR06oQnV2/0DPffv+Qp1w4Ca5ZPhJ7R1H43MG/kD2orplNTkVxrpT4u06iK1Q7OYfql/W1Z4FN/fP9E1mPdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Op20Hp3zzUcDJXZVF6f5gxHdzgVy9uUxrOhj4uXvdU=;
 b=x4F4EFALXa8thwC5AXE1wSpKxfXPs9G4VG9HpquYnEKl0efAwVYdvWp8K/Z8bzcAG89V/dn6E0qF+oQnrMBIsuBU77/lipLY1ZWcMHB+7YaEh2HZQ6o+lQbXnXBf5Fca+/gRJ6/fyUT67m9Lke2tJU6XRpdyrwYIXf5TV8jh80P1CP4+rCO8OPYPdZQgjIN0dhpDT31IXdBvIbFJ48GrQ0TbqvMV5IULlZ4uYCsWV3rXwnQgx2yRrRSKDEL6R1PpV/ClKHrye1cg/hhidhKTAn5D7zy5ztMmG621l3jL7FZNJ8TNNeg6ZP8o/C0urT3Og3TgdE8PZu34MrhpP0kfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com (2603:10b6:a03:303::18)
 by SJ2PR03MB7427.namprd03.prod.outlook.com (2603:10b6:a03:558::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 06:22:11 +0000
Received: from SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e]) by SJ0PR03MB6224.namprd03.prod.outlook.com
 ([fe80::1405:536e:190d:75e%4]) with mapi id 15.20.7897.021; Mon, 9 Sep 2024
 06:22:11 +0000
From: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau <dima.fedrau@gmail.com>,
        David
 Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<noname.nuno@gmail.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: iio: dac: add docs for ad8460
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: dac: add docs for ad8460
Thread-Index: AQHa/pKf5skOfyLui0S8EMamJYFx1LJMkhyAgAJw9VA=
Date: Mon, 9 Sep 2024 06:22:11 +0000
Message-ID:
 <SJ0PR03MB6224860552845EF2B3339DF591992@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
	<20240904023040.23352-2-Mariel.Tinaco@analog.com>
	<pp3r4ygrialun2x6vtghp27ianggjzs3g3436b6mi6mttfy57a@q7kcwolkkn27>
 <20240907180149.67fdc636@jic23-huawei>
In-Reply-To: <20240907180149.67fdc636@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?iso-8859-1?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG?=
 =?iso-8859-1?Q?10aW5hY29cYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04?=
 =?iso-8859-1?Q?NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kNjJiNGIzZC02ZTczLTExZW?=
 =?iso-8859-1?Q?YtOGMzMi03NDA0ZjE1MjNjZThcYW1lLXRlc3RcZDYyYjRiM2YtNmU3My0x?=
 =?iso-8859-1?Q?MWVmLThjMzItNzQwNGYxNTIzY2U4Ym9keS50eHQiIHN6PSI5MzMyIiB0PS?=
 =?iso-8859-1?Q?IxMzM3MDMzNjUyODExNzgxNTQiIGg9IlEyWFVGQmxvSVZQTW10bFhyRVBx?=
 =?iso-8859-1?Q?cWpXLzI2QT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVT?=
 =?iso-8859-1?Q?FSU1JVRk5DZ1VBQURnREFBQXE0dHVZZ0FMYkFWM2tGbmNzYkVzQVhlUVdk?=
 =?iso-8859-1?Q?eXhzU3dBREFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQV?=
 =?iso-8859-1?Q?NnSUFBTzRBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBM0xoU2ZnQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOE?=
 =?iso-8859-1?Q?FjQUJ5QUc4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdC?=
 =?iso-8859-1?Q?dkFITUFhUUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQU?=
 =?iso-8859-1?Q?FBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFi?=
 =?iso-8859-1?Q?d0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFB?=
 =?iso-8859-1?Q?QVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUU?=
 =?iso-8859-1?Q?JqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFPNEFBQUFBQUFBQU?=
 =?iso-8859-1?Q?NBQUFBQUFBQUFBSUFBQUFBQUFBQUFnQUFBQUFBQUFBemdBQUFBTUFBQUJP?=
 =?iso-8859-1?Q?QUFBQUFBQUFBR0VBWkFCcEFGOEFj?=
x-dg-rorf: true
x-dg-refone:
 d0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCbUFHRUFiQUJ6QUdVQVh3Qm1BRzhBY3dCcEFIUUFhUUIyQUdVQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBOEFBQUFBQUFBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFESUFBQUE9Ii8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6224:EE_|SJ2PR03MB7427:EE_
x-ms-office365-filtering-correlation-id: 9bd0152a-5a91-4efd-49d6-08dcd097bd3f
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Bc/MLxOLZY3fAA5yGwFcxOs6hdfNDJ4pb+aqXTzB3nF1yINqInNQDqFiSI?=
 =?iso-8859-1?Q?Rx4RJDfgKBbu2icPrJgzYm1nuK1wkM2xKiMWyq8i9Aw2cd/ZK/M9XA15w4?=
 =?iso-8859-1?Q?ve7ZJUYh5WFRJ3ahBuBldmEyHdRHYUuNZEfIJ9ufspVfJTH6vJjcpVP7AM?=
 =?iso-8859-1?Q?U8voj/3Rhl9AZmKXaJM2k0YRKY5E3FUjgxOEWWBCXeu56ka4jz36cGObzp?=
 =?iso-8859-1?Q?463AGHMnzU9y9xu3hIGC8sRmXnDzPygw3bUzmRdCtI7oZUAq2sCsj8p+Bx?=
 =?iso-8859-1?Q?fjN7w4E9YNtEDJJPXNXFNJvDsu9hnGIAhl6Y+ATJOgu/AMf6PgMCR5gUuL?=
 =?iso-8859-1?Q?OaYzVcHBYSDLkpsBDs62BAwklZtd3+P1UXbmB6EGTsefRK5cfS8cjKCCo5?=
 =?iso-8859-1?Q?WXjckWMGKS6p+tNoJSQXAnr7sVdQ8rmD/IsVGS92vtrQ+w1vj946AxNc1q?=
 =?iso-8859-1?Q?TXNSulJIkeT4J7mPRV4ZDucz6q80+na/a1p+t76Cz59g+Va8RPo58aLHcM?=
 =?iso-8859-1?Q?7t49ExF2JB2Spi4F0J9lYneP2mkZWXyoiOUG569dIg2J0dXvOlUkYdk7Ze?=
 =?iso-8859-1?Q?/xZJVA+/VvhXOIAl0TAADBd4klrHyJZTZKOM2rtjOaWy8kyP3SP24+SdoT?=
 =?iso-8859-1?Q?DOUNTaHXmoHEInV8L5nzofV48kv6g5KWf8AYULSNnKLVe9NOnfJ0eI7O+2?=
 =?iso-8859-1?Q?/zyKc+Ggqqu5FQ7f2+qFUkdH95u7vHRURup+4n6VXzCzCq3ZQOlQ/lCirF?=
 =?iso-8859-1?Q?0mq+dHQEDYtl0gYe1SWiRqSx9GK30v1m0qAbWd2plc1AnfMgPWJg9a+CxC?=
 =?iso-8859-1?Q?LjkyDrUWf6sb4cxFKKPwqkNnUXQo714hrKC0QYkN/wlkEGhYXRC5kOVUiK?=
 =?iso-8859-1?Q?7lSadDWSX5DlhK82jDKmEzgcYQlF3Ahi64YGnMBhX3JfYgy1uE8DgT5fav?=
 =?iso-8859-1?Q?hCQcN8pWdHeFSYaVO8oVu/Q/LMoZ0fm+pLsQey9Q/RLl4XbiE/RJTlhUF5?=
 =?iso-8859-1?Q?rtO9ZdG0i8zPkscwXZQ7usYNN4+zIJWW+dTEt4hps6Hq6xRdy8WP3Pzmin?=
 =?iso-8859-1?Q?w5hflWVPRdPmJhLaB+nMXI34mef4QOqPebTxlw3UBmgEamhDj/FYFXJ/Di?=
 =?iso-8859-1?Q?n3Gbc6Fl/iQYxviNmShdv7EK87f4j2wNGZNJ+y8cQTiqcNAw6tzq0lYUT4?=
 =?iso-8859-1?Q?78UzQe84OSiaYPsyDIvgYMP/lXsHOVNe7C7uKnizyauVOW8BlkqAlgDlAE?=
 =?iso-8859-1?Q?naeigkkrA+neijxh6ERSpgT2m5T3a9EogPMTCow0LtLdYCF1DFeTjQSttB?=
 =?iso-8859-1?Q?QrS7395XJPbSNdsYOKRRr/kvYx8rx26kNjl/u7KNK9mW8ceoELvBHRAaVP?=
 =?iso-8859-1?Q?p1eDxw6mIofMpoHFgo5pF2lAf1I3WZEQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6224.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?O0Wx8PWDoX+pv3E14kfP1+FrGMadGDrkWUGo8UZ5NN8wSfOy3z9GHrjUyj?=
 =?iso-8859-1?Q?Eb2xp1X36YSIWN9/V42Zawge7WKVJX1MckAKr+cUn74hHAz56uje+FnYYB?=
 =?iso-8859-1?Q?M4YS4jVCgH/JgNy60pmq345EPP4lLNr4Zyo7qRjlrYgAsqBo5jAUqaQG9c?=
 =?iso-8859-1?Q?YVhkwyMpoOFoxE2RW2hDzHzZKNSJFzK9n4nTDfcZVrHxqK3s0Q8ikgS+4L?=
 =?iso-8859-1?Q?2rTYUPPYSMzHsH93Amzkt8ggIsQ37DAH9tFdS4wUV0WGGE59sr9kumxZJ5?=
 =?iso-8859-1?Q?A0FAIRbioze+3tFjNxqPc3cYeGj92vELyXGiczpzAhffjQXdQz0XNvNSbZ?=
 =?iso-8859-1?Q?pmEUbwPYgu5zzT0lGtM51nindZDN5YoOZS/RU/6t7L+IyGHetqyTu+/5JZ?=
 =?iso-8859-1?Q?DHL0rwO9mCQW4fbCVzU7xDPl/YF8N4RAZL89DjY3B9uQAqRsCB2gvKa479?=
 =?iso-8859-1?Q?0P1sDFhsIYUid6sMczswGylyPIV0Rr3EmaFQ9WhGg3FGS9x24P7PsG4KAC?=
 =?iso-8859-1?Q?GYPSxCsbfdpAqLKXjbRIKD9pub5optg85DQ6OZy+5f49B97XUBkfZmrtl1?=
 =?iso-8859-1?Q?+l5I0ueE1v6QqhDNvzqbYyREEpH2FIg+abDm//W8dgw775YjG+ls3jmbUY?=
 =?iso-8859-1?Q?90MjBq1fiyM68QzJLCH4f4zxx8zkCxYTdtFQ1TO4KSPqq3JmKFhyEGt/37?=
 =?iso-8859-1?Q?nqiWKMM/h2irAZQPkUAUkvZJGQTIr4hwo219x7FeZN39NgwSM5P4FPtUC7?=
 =?iso-8859-1?Q?HMj609Et95Fi9a5lkqfmcKZ290BnBje/dUGz7m185Uekra3+1S/I4nUj48?=
 =?iso-8859-1?Q?D7nTCB/14D6wxafxIC0IQl40YBy0Ft1h6lD+ELz3CVbf8W/yhLy2gWqXJR?=
 =?iso-8859-1?Q?601lP/cqQVWkdreACmYi514Yhi1Y0n3GNd/izPxCZ2vy1nLvt3jGZOnPg0?=
 =?iso-8859-1?Q?IVDjWHmhxhhW5mzXgrfxzwUpovdHO5Gyduey03T3QeX8vAeT4si7MbnQQr?=
 =?iso-8859-1?Q?jvnMdveaXUvtoyWWH8eNltlfhPZPgEuEXjsdP9zG4Tktk3jOLKLnresbwk?=
 =?iso-8859-1?Q?bCu9j14QEb5dzmeLHNyyp1gYbHiRSYBW0XGBgGy7g0Tz70xF3asV8WUMqK?=
 =?iso-8859-1?Q?39wYRcACMSdo58lMnTiI8srm4CnfF+38u8UsXohSO0j+Etx8AQkeYEKWyG?=
 =?iso-8859-1?Q?cgaPbSibuvKbmnvvflh/IuKIwanNd+0CC4G1V4Ox7yrPFDTXX4SGFpGAog?=
 =?iso-8859-1?Q?0np0FEK7rG9R9uhKalekPJ426oJTSEj2XohSOFQ3BvcAz0m0EoIeufgwEZ?=
 =?iso-8859-1?Q?2sf5utJGhLv5turFcVUPvkvprzA0LzqZPsjx+JKX1SmG0JhGd3vaccKoLi?=
 =?iso-8859-1?Q?WT4yCJ7qblFuk0sPVy9loNI8m4QwZDICt+diRFKgJe4tUXVw5z7k28YgiA?=
 =?iso-8859-1?Q?38gvN6V7r4AO2y8hvuVGFgCIZ13Kw6y65RDvqcFvXQ3SvxzyiXHy7uHQpg?=
 =?iso-8859-1?Q?bcCDS55xZx5rFF74AV5JcmWDBrD/iLAwvA88u9ywUcQWxxmX1x9GKRBRxq?=
 =?iso-8859-1?Q?jhLqmvRR+KnWcRmKtxtHd4ppHhOnK5gpIb/74eqJw3bDeQHklfzLlw3RLR?=
 =?iso-8859-1?Q?1/zKzhvh7QinlxjiANPjwoGiqsJpz7h6P3?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6224.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd0152a-5a91-4efd-49d6-08dcd097bd3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 06:22:11.3319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /a+5ICcWyTzDHZiPTRmOMBzdsD3LbjYRJvn1a4Lq8ZcAjP/99lNXEwFhds3mmAsgEgVyrF4dY2TevBfGZeksMDOm1ZmrwodjrCLJMzIJm5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7427
X-Proofpoint-GUID: 14BxnhhXf4qfKRtx6Uwi584tTzAuRa4e
X-Proofpoint-ORIG-GUID: 14BxnhhXf4qfKRtx6Uwi584tTzAuRa4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090049



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, September 8, 2024 1:02 AM
> To: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tinaco, Mariel <Mariel.Tinaco@analog.com>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Lars-Peter Clau=
sen
> <lars@metafoo.de>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Conor Dooley <conor+dt@kernel.org>; Marcelo Schmitt
> <marcelo.schmitt1@gmail.com>; Dimitri Fedrau <dima.fedrau@gmail.com>;
> David Lechner <dlechner@baylibre.com>; Nuno S=E1
> <noname.nuno@gmail.com>
> Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add docs for ad8460
>=20
> [External]
>=20
> On Wed, 4 Sep 2024 08:20:53 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> > On Wed, Sep 04, 2024 at 10:30:39AM +0800, Mariel Tinaco wrote:
> > > This adds the bindings documentation for the 14-bit
> >
> > Please do not use "This commit/patch/change", but imperative mood. See
> > longer explanation here:
> > https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.17.1/s
> > ource/Documentation/process/submitting-
> patches.rst*L95__;Iw!!A3Ni8CS0y
> > 2Y!7lj0hq-U2ClkGNYfHqjR3-k-
> ea6TFUFsgEYQokkU95K6TXPHIPU33VxQcl_iH_etJ4k
> > pbPEV39dP1oAd$
> >
> > > High Voltage, High Current, Waveform Generator Digital-to-Analog
> > > converter.
> > >
> > > Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> > > ---
> > >  .../bindings/iio/dac/adi,ad8460.yaml          | 154 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   7 +
> > >  2 files changed, 161 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
> >
> > > +  adi,range-microvolt:
> > > +    description: Voltage output range specified as <minimum, maximum=
>
> > > +    oneOf:
> >
> > This oneOf does not make sense. There is only one condition. Drop.
> >
> > > +      - items:
> > > +          - enum: [0, -10000000, -20000000, -30000000, -40000000, -
> 55000000]
> > > +          - enum: [10000000, 20000000, 30000000, 40000000,
> > > + 55000000]
> >
> > What's the default? It's not a required property.
> >
> > > +
> > > +  adi,range-microamp:
> > > +    description: Current output range specified as <minimum, maximum=
>
> > > +    oneOf:
> > > +      - items:
> > > +          - enum: [-50000, -100000, -300000, -500000, -1000000]
> >
> > I don't understand why 0 is not listed here.
>=20
> I'm not sure why it is a list at all. Seems like the hardware allows a co=
ntinuous
> value so this should just specify max and min.
>=20

That's right, the values can be flexible but only at a certain range.=20
The first element of the array should only be in the negative range, while
The second element of the array should only be in the positive range.

Is there a way to do this with the max and min attribute?

Items:
	Item 1
		min: -10000
		max: 0
	item 2
		min: 0
		max: 10000=20

> >
> > > +          - enum: [50000, 100000, 300000, 500000, 1000000]
> > > +      - items:
> > > +          - const: 0
> > > +          - enum: [50000, 100000, 300000, 500000, 1000000]
> > > +
> >
> > What's the default? It's not a required property.
> >
> > > +  adi,max-millicelsius:
> > > +    description: Overtemperature threshold
> > > +    default: 50000
> > > +    minimum: 20000
> > > +    maximum: 150000
> > > +
> > > +  shutdown-reset-gpios:
> > > +    description: Corresponds to SDN_RESET pin. To exit shutdown
> > > +      or sleep mode, pulse SDN_RESET HIGH, then leave LOW.
> > > +    maxItems: 1
> > > +
> > > +  reset-gpios:
> > > +    description: Manual Power On Reset (POR). Pull this GPIO pin
> > > +      LOW and then HIGH to reset all digital registers to default
> > > +    maxItems: 1
> > > +
> > > +  shutdown-gpios:
> > > +    description: Corresponds to SDN_IO pin. Shutdown may be
> > > +      initiated by the user, by pulsing SDN_IO high. To exit shutdow=
n,
> > > +      pulse SDN_IO low, then float.
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> >
> > Some supplies are for sure required. Devices rarely can operate
> > without power provided.
> >
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +
> > > +additionalProperties: false
> >
> > unevaluatedProperties instead.
> >
> > Best regards,
> > Krzysztof
> >


