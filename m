Return-Path: <linux-iio+bounces-21446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD313AFCC62
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 15:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C391E3A88BE
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD971D63D8;
	Tue,  8 Jul 2025 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="q/y9FvJJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0D12CD8B
	for <linux-iio@vger.kernel.org>; Tue,  8 Jul 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982325; cv=fail; b=TfWrCs/w8u1AchC9tuAXnjCHNBg2ie9yZBvE0KeKcmH/j4nNKOLRE21UyLjeqaiQrn9g8fn3aLIy4xUaL/oC4yw8q8TvrzpI7Q2QNPs1BR4YOWj112GCBRpJQ7PHGJvS+Yqe3mZ6+IHlrYATY3z1bCVAzIZWaE/P5aVoXL1ZoMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982325; c=relaxed/simple;
	bh=V1wZUD3cgHMOQprhKi8HSkDFsugJjWBy11a42dfbZbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pUO3wNfZ6MkFBKywAMMNgPYxRKQyUg65u0h7f4nw1tr8g+IsMGQATWhj0y+IiGGIjYabEBIMMCIaqSFpSdy05kCHfef373RUmHt3vdTxtxtUaqG4z7jqwB/sNid3KEcRSWq4g+xF4U9Q94zMErRqSJjVDpkxMdMBg4gmJJyamiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=q/y9FvJJ; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567Mt2rR024994;
	Tue, 8 Jul 2025 12:21:46 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010009.outbound.protection.outlook.com [52.101.169.9])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47pte429up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 12:21:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWITHBeFpOmBnlvMbOfgXskwuaZ+jpabPkUyqx/LXrndBD2opPDlJqH4iJvYzHN1PERkAA88pNpURoSZ9fXMsgEeRJP+/c36B+FrVIZZE0Yo+blJYOw/RmbDs3xqdbW17mqYSuShbCaMRqMzW2P0yNH/0KhfilBJWImhZR7r+PsVrogaoarcWW5sJDBU709zAFmV5aMr1AwCJC0NkRkErbHGMeMNjBh+/MmuLTPsbXs749wlx7aJ2WG4sou0gJXEdqmNt3pNlKsADXgAMLfSqspdezXR8DTnR63AuDWc8Ylvpr4fx6YVqDLULu3WElFUsfoOFtLyaQdErhghqoviBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZoQVX+VbKt2c9fxrPBEHB2EoDwit4iIwt29tKrwc70=;
 b=HLb8GrffurH56leHO/wQIBnIcKHFVV49zUiR2GL6V8fdNzJstx3R+s7JrmA3IHgjn8UH+SxtcioGfeHa12di3wml4Xfuh7upr77RWSp2eMlCkhgy3QH+1LmRkCyQWJ3zKKNHRY7lokIxVDNUm4ypsZZ+HZfpwZlTHHMq4g0sfQ/2oSpzTVxGuG4tJ8LyKNgIPWCN7/OlNue0I08hzCn2RGLz3eJUqQ4Vvmd8Ijoe+pkqHNSdxsRMx0efeV2IgNt9z4/cD7h5IxiXNDFgLAeeRHPRpADUo6FMz8e9eidDKL/YQBAHnEqofw1INlwJPs2nRb4iDcqbCX4LoGjJJRGREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZoQVX+VbKt2c9fxrPBEHB2EoDwit4iIwt29tKrwc70=;
 b=q/y9FvJJXBWrQDdTOTKgByX+gr2p5c0ivslroFTpADPW9AMBeFpUJJbK+n9JC63yQdQvJGqpLcYq079Yrnk3f4eGMksXtRspXtETZEd+RZc9/QlnB717SfvYwhPR+u06IXEMyGqjyYjMlZgHsKWfKRrRHI5OEEtNn0NOKFlpapTd1hiHM1gXcAETNbLbIZTr99sOWDjSURHwHIA4qwDelEkxMbx5A8kDpBxT/JDVHDBPqI1mb9Ty4I/AG67hd+W+ocUvzkAbKAP/3VrTTkvaD7ullu7kKPu67GjnDSFQJWUotJ5wtS1kt4BZ2ZHRgD0hoJ1N2pQ66GC9A287EErFUg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR4P281MB3410.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 12:21:40 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%7]) with mapi id 15.20.8880.026; Tue, 8 Jul 2025
 12:21:39 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Sean Nyekjaer <sean@geanix.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Argument
Thread-Topic: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Argument
Thread-Index: AQHb701xWPPwUANIV0SBqYJxy5Bpk7Qm9S4igAEUKgCAABQmMg==
Date: Tue, 8 Jul 2025 12:21:39 +0000
Message-ID:
 <FR3P281MB1757E1352768510879500A3CCE4EA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o>
	<FR3P281MB1757FE243D78E8F78DA6C576CE4FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <20250708113508.000027fb@huawei.com>
In-Reply-To: <20250708113508.000027fb@huawei.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR4P281MB3410:EE_
x-ms-office365-filtering-correlation-id: 29539827-cc24-4487-642f-08ddbe19fdd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|19092799006|1800799024|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4L53a0BxmIwB8/5XVZDxJuZPxaYBlxoXIJl2XfPueB/F/8A69gvz+iih+2?=
 =?iso-8859-1?Q?4qjjF9VNLS7RDJgAHI9ewiX9Lm/Yu8qVFEehvJ7J4iFcbsxBGE+lvnLYMe?=
 =?iso-8859-1?Q?1FzZumejQmwdgf60/6JrTN28HZLL/vE2wnsBgyLp7va1ZTdqNe/NXFCPU4?=
 =?iso-8859-1?Q?cU5CpM0qtirkU37wg3h0XXpRq9VAUmoAOETeTxA0KjKSijH3DQja0WL4wZ?=
 =?iso-8859-1?Q?w6Ytjdh4/kCKQq5kss1irPyYSe6YhHeR9v2+pkVZac+0ML5fcTvDu1AiBX?=
 =?iso-8859-1?Q?5bSaFuC45OsEd+OT2gIwKDiP1oPWvpqyRE5B3Q7nmbldVWYk2toiABZpLf?=
 =?iso-8859-1?Q?sJVP/L1rVmfGCZXvuDqzWPyWUq9RyQgdryl/dm+AE/1KKMqhsq0fmBJS7X?=
 =?iso-8859-1?Q?xYzsy2P7Rrgq90J0d6lzu05YHNBWvPEff6e4L5tZkxj9wVZ9ivBaHpIEWE?=
 =?iso-8859-1?Q?AXq0nbe2aJrB3tQW1cdDV6fq34n8sVK+eDZV+L5O9xuPYBZ2TEKmlahDHt?=
 =?iso-8859-1?Q?PyC4mSHgx0WvEhxCvBDyd7kB2JFA03zYL9m8u8HY7E2pqxqp+cv/NCdy3k?=
 =?iso-8859-1?Q?hZE50u/h5RANQ7MnV32QtGQhxb5wVR8/yk5m8OcycTZF0GAzDUcxQqKtHt?=
 =?iso-8859-1?Q?mT8NkIYpPybD019ahN2zgjMCkRGpg7HKEY8OQgA9e3kDsFiWg+D7s2/agF?=
 =?iso-8859-1?Q?VJgJEELC7VLgX6yhx5J3ViOnG0S6HEtvX+FtJ3iwVmoBwQu3aAFOaP1bQy?=
 =?iso-8859-1?Q?X35KsIFg9UpWUyGPA9kXSiGxqUHoX43XnjoVA4/lAcWJ+zlcYJ4tqkMzyR?=
 =?iso-8859-1?Q?hqaTMSA5McGtuGef48FjHVyhKU+JS4yNjAnZgAWhoXBA7pwky+5XwNi72k?=
 =?iso-8859-1?Q?EstlLXJFXF7Zp4v0Z/dr+Mk/aGEU8zq3pnEbFCViAabDfAKVAvJLSqgCJr?=
 =?iso-8859-1?Q?c2Oi2vfMEiiJi17cyFEt80IerBsLUfI+0XO+/Gft9PfhqBkwKadfahM9h+?=
 =?iso-8859-1?Q?tTozbxNO/tWNCohCxHp68qx5gXKyIyaz4Jefi/irlkwS4IXJP63kJvOvmX?=
 =?iso-8859-1?Q?cIbDXoXuysgIEE0FUeDaFHfMH9Ys+RZuOM752MEqW3u2zx3/Pexb69/qVJ?=
 =?iso-8859-1?Q?OPR+Act0T7F8LsZCMQmduHujpCThd48e2anTjIcCbsAnoZMs/iajAgXzCb?=
 =?iso-8859-1?Q?edoGuqDqyqnvPuWAZbh04ndMHNb7psbdahQKoJU/7J6gSXXsjAuGOhqfZj?=
 =?iso-8859-1?Q?1vSRBUuzgpXY8+2AGViO1vtiGfU170EPWQhDZ+5uipJLVSinhux6arnMta?=
 =?iso-8859-1?Q?vmV/0M/D3eS5NU7qMyuEPGJ1mI/gXnZlMVMSqz0kFLqhvvLDj2Otgm3B42?=
 =?iso-8859-1?Q?/y6ZwpOJaAjoj4F+KATkS5hsPKCW1rUNBrLpWzqy0sA2yMYEzoT8cMnPxi?=
 =?iso-8859-1?Q?sftjqiAWuclJMhg/T1bzbm50HTR7iJjMHsdo8Gb2gvw1PPaeUVrnpAN/Ns?=
 =?iso-8859-1?Q?RypdfI2wJGVt2X672ysJeFvJ9FhjNct46/PAIha3IbbyoVWCh4MW0d+iRZ?=
 =?iso-8859-1?Q?BefJ1bw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(19092799006)(1800799024)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vBN1zU4WytANWm4lhU+HwHfDBzZ2QmA+njVNcHpu1bFWz5HUZcle9SIfv2?=
 =?iso-8859-1?Q?01cxyYhh8E5KHiVmqcG67gebelNrrarzc5qTsodLLUy0FWFOsgJ6YlvDYc?=
 =?iso-8859-1?Q?5j7LComCWo1GOpbqVWN7nK+vwUKIfKz9CW6znJyRvePJfjcMT5mCJtiLKl?=
 =?iso-8859-1?Q?/4fklahjWpaB9/0iyNZp+CgujQq2m4fOt0eNe8jVrnjePB3sn0P5bJrT1A?=
 =?iso-8859-1?Q?aq6TXBSeHvDokzWVnn+aEFAU1sAZY+HLM19erOip00vhiqA76A/vJ+HKXn?=
 =?iso-8859-1?Q?hIlK7eutP0T8Rop8jUXklw94BgCkW4MmL8Oqnjkm4IgK3Gk2s5pYBZIkR4?=
 =?iso-8859-1?Q?VGtj/Hy69xLcFbNODbgrKxJPsMurZO5jq3PZQH+bXSPcc8N9R5Mi7Y0ePR?=
 =?iso-8859-1?Q?GnszmIl8N0zz7C9PwUeVBdDsCBOauu6/dM5Oufs1So7zza7xKGREGvyFWm?=
 =?iso-8859-1?Q?YG68LrYMerpZeAAn8oV8zTBJq+kh5GDtd5DWt7qgjQmsiMzUg2N3e5FWoG?=
 =?iso-8859-1?Q?1eJs7r1yvUxFLJe+bTFE9x5WjqhkNghomaIWOgCkpWtX9nr3qoGgwDyH7B?=
 =?iso-8859-1?Q?Mq1sRy9tHTNH9wmRCrPGpcM5SR2ePMu+oL9z50k7D1E43IWQWbXbgK1UiQ?=
 =?iso-8859-1?Q?GD580dVkc1nFuwxEHi17CG8/3A/4dPVlemgn/2RA9ps/9HOkKrdI0FORi5?=
 =?iso-8859-1?Q?KKFlrUQFQHYQidJTQk13P1jTi3mypnZPmd6TMST0ztPC1kD6NjgDe74gwz?=
 =?iso-8859-1?Q?iFUQgJNXVry8a8ULGuTYwFRWcJx2+s97ikSKGskaGIz72lP4bZM3zTk4iQ?=
 =?iso-8859-1?Q?6FF4wKBqCH1Qw2YVO+16Iqua4TXzf6LKtBMT7E+JO0I4CZN1D0uKb+lHa9?=
 =?iso-8859-1?Q?bCpHilRlqev4nJaZGl5/4gLuIvkHUmt2ONrzDuUf4U1TpbsZxShgwrovvb?=
 =?iso-8859-1?Q?6+UPGdZcz+FWtU5usvYEl08PHXoqrFKIf7DNBVEbj6w030kaYUKvWjOEHA?=
 =?iso-8859-1?Q?MkX9Tg9PhN2Mpjgqqt7Gw1Dk5mcJrDe1CZA0Mgj0qfVtRL2y/mwaojnmFL?=
 =?iso-8859-1?Q?ej2cCvWZq4DsQXmc/lLCgWxNyCpR59pByOMYRlSa2Zmg9QXtZZDDh/Bsnx?=
 =?iso-8859-1?Q?BSOPr/3Bc+0s6dFAQo1VpQEzpyf3e8H/70rlIFhPXxzIew1HUIjaaWaSLZ?=
 =?iso-8859-1?Q?JVyp2N10rquutcPVQvBKooZ71sUNENDcYZmaP3ksfn5AVs+b2NxcW48pf9?=
 =?iso-8859-1?Q?hRadtQlBddRJQiVpqRpF6wu1LJl5ARzm4TRSF0ghLeXHcjzQPx8g+TcJur?=
 =?iso-8859-1?Q?nfDZpPMLFCFgNoObzF8gpoLj8mKP7qxXfTWz7fYiCiHh9qvrtw+q3faFbn?=
 =?iso-8859-1?Q?swWNGph/yBOaTiOcOS07kVwc8KtSSZhJLzPqwBVojk3lnjtsllI2oYGNmQ?=
 =?iso-8859-1?Q?TEr+9UrBEre+PVjiNHM4ZVsYWNVJ8hWy2x+whwxYb54UZ5PeUmpB2Dk0oL?=
 =?iso-8859-1?Q?dO6FpSOe0/iF/swJJ4ZWqX/VUNAWx5bIIQ6zY3vRzR6w/FCucHvoe7hTE7?=
 =?iso-8859-1?Q?04mDwvojwEHRXYgV2PHUoRhXJituga1nIAiCiErxOePX5j9LIwSXs8vvWP?=
 =?iso-8859-1?Q?uZKgd74/RFCa9daBti6w9OCeIkCgKMcKpB0AogXZwrkq5gNYk7JyJz97Uq?=
 =?iso-8859-1?Q?Z3LBz66eWjQU6skEqrox/v9XmejsXSG5xz0f0b1EHRHBFmb9cdmfXI/cRb?=
 =?iso-8859-1?Q?moFQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29539827-cc24-4487-642f-08ddbe19fdd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 12:21:39.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kS72oUvYrLSKL5Nri8o3dKvR3YP/ik6/v3WHiXe8RVJhWsPQPxm4HZz29VGK1b4nGUf/x5bhDoMlbaoihrSWg6SMnLOXEDV3S/ZhFwP+Ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3410
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwMSBTYWx0ZWRfX3exVHmIw794Z
 fphykbPWCVVD026CuGXc1pPX19a0TSsigCp4W6sYtR5x93nw0BFo56gwHUHe4oGcjAVZ9krGUrr
 fVb8BRkApghbXNgjHunS1PI8bb7nmupPOEZRmwcQa9QeduwIatxEwIsIIfodXTAmxVDa9EdN9bc
 6bQm4pvKuuI9+DwF4L5VRwcv3tRg3xXrt3CjfmVd9U7hRchfZFDLZTPB28bRWhihlbd0r1/LgQl
 KL51VrxQ4Kx+KuZMPICO8yjFdWaLxJO5r7diseASt7mroEuKcfe88DrymjRhTCkpZdep2zREOS8
 ivoNZp+LrtMk/p+RDCZ5QdWkHvVJ7UcIJqbeOCwPWlEHy5F3yKBpaus8STqW06BOHi7ELPrv/r5
 0C+ZDyjfC9K/3/KezjnsiuXo44bhbU6QtZ0Q6t9BUvsUxO3ZMyLsB16wjwLn13Ge0NcLnVfe
X-Proofpoint-ORIG-GUID: jPDiN9-3svMiAQ7JOJ5oZoJ67ummfUwf
X-Proofpoint-GUID: jPDiN9-3svMiAQ7JOJ5oZoJ67ummfUwf
X-Authority-Analysis: v=2.4 cv=S93ZwJsP c=1 sm=1 tr=0 ts=686d0d5a cx=c_pps
 a=KiKCefL2muacZo4MUmsDLA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=i0EeH86SAAAA:8 a=In8RU02eAAAA:8 a=ilKATfAMAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=iUvM5lliyOPup2oNgu8A:9 a=wPNLvfGTeEIA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=73awMTU50e6eLoBjGbzZ:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080101

>=0A=
>________________________________________=0A=
>From:=A0Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
>Sent:=A0Tuesday, July 8, 2025 12:35=0A=
>To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
>Cc:=A0Sean Nyekjaer <sean@geanix.com>; Jonathan Cameron <jic23@kernel.org>=
; David Lechner <dlechner@baylibre.com>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; Andy Shevchenko <andy@kernel.org>=0A=
>Subject:=A0Re: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Arg=
ument=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Mon, 7 Jul 2025 18:13:33 +0000=0A=
>Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:=0A=
>=0A=
>> >Hi,=0A=
>> >=0A=
>> >I'm having some weird issues with reading the temperature of the icm426=
05.=0A=
>> >Kernel version: 6.16.0-rc5=0A=
>> >=0A=
>> ># cat /sys/bus/iio/devices/iio:device2/name=0A=
>> >icm42605-accel=0A=
>> >=0A=
>> >When reading the temperature I get:=0A=
>> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw=0A=
>> >cat: read error: Invalid argument=0A=
>> >=0A=
>> >But if I read from the accelerometer first, I will go better:=0A=
>> ># cat /sys/bus/iio/devices/iio:device2/in_accel_x_raw=0A=
>> >-378=0A=
>> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw=0A=
>> >600=0A=
>> >=0A=
>> >Then after "some" time, I re-read the temperature I recieve=0A=
>> >"Invalid argument" again.=0A=
>> >=0A=
>> >I have traced the -EINVAL to inv_icm42600_temp_read() because I receive=
=0A=
>> >INV_ICM42600_DATA_INVALID.=0A=
>> >=0A=
>> >Register dump diff:=0A=
>> >--- invalid-read=0A=
>> >+++ ok-read=0A=
>> >@@ -10,14 +10,14 @@=0A=
>> > 0x1a =3D 0x00000010=0A=
>> > 0x1b =3D 0x00000000=0A=
>> > 0x1c =3D 0x00000000=0A=
>> >-0x1d =3D 0x00000080=0A=
>> >-0x1e =3D 0x00000000=0A=
>> >-0x1f =3D 0x00000080=0A=
>> >-0x20 =3D 0x00000000=0A=
>> >-0x21 =3D 0x00000080=0A=
>> >-0x22 =3D 0x00000000=0A=
>> >-0x23 =3D 0x00000080=0A=
>> >-0x24 =3D 0x00000000=0A=
>> >+0x1d =3D 0x00000002=0A=
>> >+0x1e =3D 0x00000038=0A=
>> >+0x1f =3D 0x000000fe=0A=
>> >+0x20 =3D 0x00000085=0A=
>> >+0x21 =3D 0x000000fe=0A=
>> >+0x22 =3D 0x000000df=0A=
>> >+0x23 =3D 0x000000f8=0A=
>> >+0x24 =3D 0x0000003a=0A=
>> > 0x25 =3D 0x00000080=0A=
>> > 0x26 =3D 0x00000000=0A=
>> > 0x27 =3D 0x00000080=0A=
>> >@@ -26,7 +26,7 @@=0A=
>> > 0x2a =3D 0x00000000=0A=
>> > 0x2b =3D 0x00000000=0A=
>> > 0x2c =3D 0x00000000=0A=
>> >-0x2d =3D 0x00000000=0A=
>> >+0x2d =3D 0x00000008=0A=
>> > 0x2e =3D 0x00000000=0A=
>> > 0x2f =3D 0x00000000=0A=
>> > 0x30 =3D 0x000000ff=0A=
>> >@@ -59,11 +59,11 @@=0A=
>> > 0x4b =3D 0x00000000=0A=
>> > 0x4c =3D 0x00000032=0A=
>> > 0x4d =3D 0x00000099=0A=
>> >-0x4e =3D 0x00000000=0A=
>> >+0x4e =3D 0x00000002=0A=
>> > 0x4f =3D 0x00000009=0A=
>> > 0x50 =3D 0x00000009=0A=
>> > 0x51 =3D 0x00000016=0A=
>> >-0x52 =3D 0x00000000=0A=
>> >+0x52 =3D 0x00000060=0A=
>> > 0x53 =3D 0x0000000d=0A=
>> > 0x54 =3D 0x00000031=0A=
>> > 0x55 =3D 0x00000000=0A=
>> >=0A=
>> >Will the iio core retry a read? If the -EINVAL is returned,=0A=
>> >inv_icm42600_accel_read_raw() is call once more.=0A=
>> >=0A=
>> >One more thing...=0A=
>> >When I'm removing the module, the kernel prints this:=0A=
>> >inv-icm42600-i2c 1-0068: Runtime PM usage count underflow!=0A=
>> >=0A=
>> >I will continue investigate this=0A=
>> >Br,=0A=
>> >Sean  =0A=
>> =0A=
>> Hello Sean,=0A=
>> =0A=
>> this is expected behavior since the temperature returned is not the exte=
rnal=0A=
>> temperature but the temperature of the mechanical component (MEMS). It w=
ill=0A=
>> only work if the chip is on, meaning accelerometer and/or gyroscope is o=
n.=0A=
>> =0A=
>> That's why you can get temperature after reading accel data since it is=
=0A=
>> turning the chip. But after a short while autosuspend is putting the chi=
p=0A=
>> back off and you cannot read temperature anymore.=0A=
>> =0A=
>> You need to turn one sensor continuously on with a buffer, and then you =
can=0A=
>> read temperature all the time since the chip is running.=0A=
>> =0A=
>> Temperature data are here only to do temperature compensation of the acc=
el=0A=
>> and gyro data.=0A=
>=0A=
>That is rather non-intuitive behavior.  Could we make a read of the temper=
ature=0A=
>channel turn on one of the components?  Given expected use case it shouldn=
't commonly=0A=
>happen but if not too horrendous to implement it would be better to avoid =
the error=0A=
>seen here.=0A=
=0A=
Hello Jonathan,=0A=
=0A=
the problem here is which sensor to turn on? Accel or gyro, or accel+gyro?=
=0A=
And the temperature reported will be completely different if it is accel=0A=
and/or gyro running, since gyro is heating much more than accel.=0A=
=0A=
This is not a classical temperature sensor, but an internal one for measuri=
ng=0A=
temperature of the mechanical part while running. The usual use case on our=
=0A=
side is polling the temperature at low frequency (10Hz, 20Hz) while accel=
=0A=
and/or gyro are running to do temperature compensation on the data read.=0A=
=0A=
We generally want to avoid temperature data in the FIFO because reporting=
=0A=
temperature at high frequency is not useful, and it is consuming space in=
=0A=
the FIFO. We prefer to have more space in the FIFO for accel and gyro data=
=0A=
and do polling of temperature.=0A=
=0A=
Temperature reporting while the chip is off makes absolutely no sense that'=
s=0A=
why it is not supported by the chip, even if it can be non-intuitive.=0A=
=0A=
Perhaps we can use another error returning code rather than invalid value?=
=0A=
Otherwise, tell me what you think is the best to do.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
> =0A=
>> =0A=
>> Thanks,=0A=
>> JB=0A=
>=0A=
>=

