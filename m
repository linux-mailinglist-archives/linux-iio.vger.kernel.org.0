Return-Path: <linux-iio+bounces-26265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DEDC631C2
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 10:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D701234CDAD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ECD32693E;
	Mon, 17 Nov 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1J8R6y/A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73932572A;
	Mon, 17 Nov 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370597; cv=fail; b=ETcPk/PS2uJA4+K7Jasz6WSZs84LaUJYCuWfUmEsvEntVwZ3/JXUXdQovHTsttwE5ZLG0bn63QzDD83xHfwprvocxqiGW5UyYvwPSWhRrxRz4cIw77Lq0+sslbf5WVe84GNuu7PQX92ips7Zn7knvgZykkf1/GlvVPDd6M44WbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370597; c=relaxed/simple;
	bh=cXNqVoQbwk0uGAg3UpfvQmQIbXVtkhihD8Ttf4yqrgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AOOP0B5+6cGdQLbc2xYI7JAAIUTgicvJWw2svqE6rJV4V8sQCK/cJFQOooDfEkoDs6xnE4nWG5O6jb5v9xK673bzEGVe+FmXqz59wY1QdGi+R8p5B52J9jr7uP5PptFsoJJH4oRxzzL7dlhPXAprKeGTO0NzwD8LcQCuliXQHTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1J8R6y/A; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AH8H2bM2416160;
	Mon, 17 Nov 2025 04:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=l4Q0g
	2uauySqFhSswDC4fnNS0pmc8vmn1sasqb/gg0Q=; b=1J8R6y/At2upEPQ6c8Rp4
	BYM42Jg3olQaOTNnBhxs2NBSz66FViUiOdr7RIu6wUkjy0Fa8HtX38qN4qBg4UTG
	3u/DghZh85/P9kwwTKG8Uc1EsnI2unSsaEfKu9gtD1PK89w9g3UafFUsFfYItveH
	xdNIa2QFcVQGJcVlQN3rvSTZ+khboX5FJn/4bmrnBkg3IVhT4oqb/e7p9NsXoQQZ
	3ra3gglvB3tNir+r1OK2Ji6/s05U2qMlguBdDyUbwFLtoUmJQagrmGig61K0haft
	O1Bxj86WcePuD+jw1SZTgXSKq1BgQq+waHKddl505hrj57L5xdaAbHwYUCqeHUFI
	A==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ag02er6em-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 04:09:37 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoB0uKKZIvNaCHH3iSho/ZCG3AoONhDeydgJv/676mQF8Yic+ce1VcwElOIHv0e2DRmM9r5c7nIqYLUrsdpRuyfaorcXWCDj9mQwZo9v6V5kMu5CZqjWKyVC+KiNW5DRnFveAaJZTxZsiwVC47/VObdkJbpcT8N4hrt/4K+rEr4118PXesfS8O3dI7/lVWwNxEV1emXG443yzzOEto8DJ6iJ/n1Uw1nt/qZqtVe1/hyhUw9MT5e9vVbEhP6cBUx4922NRdn2gxOb3/kCiX3CSKIa01hEFp3Z0J1L2oXi7jiM/BN8d8k0l6/WeGNn05FG6jvu4wt2ecIbnod7QHcvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4Q0g2uauySqFhSswDC4fnNS0pmc8vmn1sasqb/gg0Q=;
 b=vLmpCbUVWp1nqV0Y5A27v4pb2VDq2UGLGMyVuByExABVECWQk9ovy8abnTnkssvsK0NNG/DcWCbI1kUhDWlO5b2kRGshf4+Zmgfov3LRZxcYl4Eh0UnHfagFhFeZWCuvN43VWP4A0DKr+yyDhIYvHSTHrNDVxMzZ1y7H7AcVnxRLNrwXcPcVsu50abcHqM3mfCyYD4xORaeQZHBgC3bIUWTDanqiiF0ltUae+GkDPV7/umHnkRVUlFWHJDKI01zbmsbP2R2lx49x0TMIvoWTxN0SyzGP8P2xxBpG+/TFHAZHyf1BWpF8GO8VlzvdsCm5LknRGmv1A8z7PM7pPPE6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DS4PR03MB8375.namprd03.prod.outlook.com (2603:10b6:8:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 09:09:35 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%6]) with mapi id 15.20.9253.011; Mon, 17 Nov 2025
 09:09:35 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: RE: [PATCH 2/2] iio: frequency: adf4377: add clk provider support
Thread-Topic: [PATCH 2/2] iio: frequency: adf4377: add clk provider support
Thread-Index: AQHcVV+l1Jr2UUzTkUWDtnYr/KlfNbTz/ouAgAKZa8A=
Date: Mon, 17 Nov 2025 09:09:34 +0000
Message-ID:
 <CY4PR03MB3399661C6863F9430EA86A9A9BC9A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20251114120908.6502-1-antoniu.miclaus@analog.com>
	<20251114120908.6502-3-antoniu.miclaus@analog.com>
 <20251115172407.2c00d58c@jic23-huawei>
In-Reply-To: <20251115172407.2c00d58c@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DS4PR03MB8375:EE_
x-ms-office365-filtering-correlation-id: a9016e0d-289a-403c-f1a7-08de25b90718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yJNBlmLg/kD2E+XV27iWms4gdwA2nfZ5Iwm6E4NQg+ZLY9iKVbks9NdVL7og?=
 =?us-ascii?Q?yjYW4x57udgSSpVsoke+s5Ev4KCgrVq/8v+0h0aAz33kRiqqiE2MGyboDG6M?=
 =?us-ascii?Q?HQVqP3FHxrMCjmDKm4xnkiSCjLVTjf6BQGtTjb8t2NNPBgy0LH5ydbgVZsOR?=
 =?us-ascii?Q?WE3hMBiC58W2nSgg2a55GZRCFqoJhGNVf+P35IMEsrKpCqcu249qWdjpWJkr?=
 =?us-ascii?Q?DXH6oEAt2YW+MCNqa33d3D2nPXOlXlmqFxYEk22iU0rZ2Atr2PxI6RyGwHu6?=
 =?us-ascii?Q?NdBIUA1eMEU7FWJRvnqyBRMseg5q552yxw1KveJMFWrnGP55Mp91F6g8tdYK?=
 =?us-ascii?Q?MrOc1YG491iauIu0306oczTcqX32iZsMw6axqHZFVTCGHsbgmmpVNty3U7p1?=
 =?us-ascii?Q?QCiO9byVscaeT1Im2JUbX/mjWrkb7ixxX5zmddErqah+M+pjbcWN6gbl3a1W?=
 =?us-ascii?Q?Xue8bE17BU2U2SSF92bOaonYAtex3rWZLdGUv7IqCjwjhJQMOd4UR/ZhwKDX?=
 =?us-ascii?Q?2pJmfFbOrCm/08u6S+Ob+QN9GM8VRb/9JBO+wJ+MQdchJoqEzAdP88MddAAc?=
 =?us-ascii?Q?molYsw0vmoRjiCQvWE5wq/A4Se55bF56PoShISRtbSgrXFvrh8N6xHSFRR/4?=
 =?us-ascii?Q?zVG4ljypFVRkjZYxuKK7MI0hZt+lRf4d/e094BWM2AyYV2GzChmrg6PCI1Hq?=
 =?us-ascii?Q?CNWz0n8Xi9L7eqBZWVGMVcGFwZ5w6QOubzu4byuBpYBBl83Uh375DUvoR6NR?=
 =?us-ascii?Q?QzpFOmrHKsD0/RMo5YIJh/RSfxGPbcS50k87yDmLfjOXBqIiwBfZt5/yOe4M?=
 =?us-ascii?Q?bulC87jUuwglC9pxxujgSRvBL1dWwlI4zKca6vzhGky9UJfbLB/XfrFoyP7e?=
 =?us-ascii?Q?QUL4hEazRI/cHS9t4xl3yiZbYKRbvYZXuG/Mm2PUcQqI8AQE7Evp6QudpwLA?=
 =?us-ascii?Q?6cxASAtifuF11p5LIQeX1M/162M1NeZCrebdFq+ekjUkAOYk/pZjaG3Hg0Aw?=
 =?us-ascii?Q?1WDcBxpQu0eof5hdFzt5ylp9MPy9UelQCJM9ICRW6F0kfzmdmIoXvrldupLP?=
 =?us-ascii?Q?MrBh0WQbRYot9FpzY32ZbqgXFGFYXUgK7/JBx7CGh4LvhpRJd0XypiRDMVTk?=
 =?us-ascii?Q?AwWivRSb3frYwNuIRdDnaMdSQSTxgkWW0fYTrK+OMmjW8DsgdeJw/nQBxEbl?=
 =?us-ascii?Q?1IIo8Eel7scwVkoXr2z+dLrUu1hXqS7iuePfMLas+/9k4GRgYITP7UND+L+d?=
 =?us-ascii?Q?ZFnJMVFhRHFeq98t4B/KsfWKBdtJPx7+jsNIgAAOzjeAiQ7/LTpZLoslg4Fp?=
 =?us-ascii?Q?bgxhRcE+Qn/X3l2aSsNno0Rc0WRpPlRwJsKdjSNipp5vor4W6cMXcy1YFpmY?=
 =?us-ascii?Q?5Wj0R5ACkDWm89a9JX3dbZAD98tvcpOEAkAM7dnPt9S83dG8s4+ospOw9Z87?=
 =?us-ascii?Q?9wYvt1ln1A//P/LpaoaEXz3lU/CB861/ryMR9L6aCWLljR5tZBss3yEUZ9fs?=
 =?us-ascii?Q?n3E4tWK5j6damMuc31pA0ZBwuB/lkLr4FgCY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AWEculv6fLsVdf9Zbw68lcCtT1I8BPW0+63CFhpHlIYE2yh6UO5PGT+ohxjZ?=
 =?us-ascii?Q?aUYW4NVykK2g2cz0+ZORTRQo3uYxxh2/hu1puZIj9Wm3xRG+ACgON/J6AFDh?=
 =?us-ascii?Q?MVqo7CiylPEiboprNa+aeep+h7BbNiWBF9CcF7pJE/JCq4Z6ondz2y6BPYiL?=
 =?us-ascii?Q?JIMf/zDeAw7/UvakYOQ67+1cef7sXvHKWKJUwcduxDl7z1vxVg3+mQxybNYx?=
 =?us-ascii?Q?lnF6Tcbt52I4vMG/q/Vfvom+OLuYcty9NYtD3QipcX56P8Iv9wlt64FqqaIJ?=
 =?us-ascii?Q?iJ0N6EMviJ0brVSkcR00BX5X16bl1k115aizu+5ElscMhbzNJiTVksQs7ySu?=
 =?us-ascii?Q?M8fIwn5rphZxVtRj22kw+oUnWkqq+8EFFSCALBiTVG84bzynJPBu92JLKmhE?=
 =?us-ascii?Q?l4MiyW9tzFrBKEhOerhFRLfs8gyy9zToGzebEmD7TVLK2tcAKVrwA9VuOwCf?=
 =?us-ascii?Q?ldG4g4gtv/zwA7bXEREHLXCIDK/SniCLRVhXUMYGPhv+dqJTPW8AvTsQDvBW?=
 =?us-ascii?Q?qg4Sv3QilqvBLvH4QbLVnKplsLng7YX6DcsGsIMvWRM2c3AUPtY1Gmg49QUa?=
 =?us-ascii?Q?nIWFeiyR984/DhSM63v6MhSVrLdhAU4VgkakAhawH7G0XeImSZ5ixLFY9Y/W?=
 =?us-ascii?Q?Wuo+UQVBzkA2CYN2S6yqcL4wy8J4jWCkgQs3MxcxLaGzNuhkwhX+gYJQfhDt?=
 =?us-ascii?Q?N5pcXaWPTwEt3ZiTkYLcLyW5AM2HN9tcmcaFxuxNQFAPtAXpCWSkLOHgSl4Z?=
 =?us-ascii?Q?VQDzri/ijLUM3hkObr8E9sFxw3lZPMuKt8CDq61ZGtB/fdDIMUxXOQSIWXXY?=
 =?us-ascii?Q?EDDp+Awl3JnW+htyhYwMvjwEFCza7aBqlXIfYN7dbp+LydeKWiSTUj2bHi9s?=
 =?us-ascii?Q?oUxybau5pfI2IDMj196lODTYJmJta8bvfsv7a61Qbgkc4ngTQj1Oo0zwFF0a?=
 =?us-ascii?Q?MCTXJCDi4jFyieAgl5F7vGsJvPEVjqfntUinKNIR8NIkK7rlPSYxb/Fk6KAW?=
 =?us-ascii?Q?vRTCnIMlMNFtfIFrBpStbSzZOr4U95Lx5/HYRWRSVHAQWmugpBMd/imnMkt4?=
 =?us-ascii?Q?axpvGc0I7FZyGdaEXq2PFaYY+/uzrq5vLAnoQ8XATI2Z4ruIb0PmcdOtKtiG?=
 =?us-ascii?Q?Noipnn48CIwX7JUbFU2dUadw8ftqoQotWAckQuEIBfomdIGvsv9/oHPrceFJ?=
 =?us-ascii?Q?StcC7M6F2hbGik4+91VjHmoLYCaHM/1wPTqfQ1hdme1sA06px3goeUllbzeF?=
 =?us-ascii?Q?8uKOjkXt0z9568EtFIFqhcLO5U8UOTC7o5+hTBfsQts40D3/y20b1FkhFm/C?=
 =?us-ascii?Q?18lQBuCeQSXxjXMmFHCR+Phl7xPpVIjNMwcWYK8+w8YiwlWxLcBeea6IPF4n?=
 =?us-ascii?Q?fO8GRZsX2DJO3xPVNCVaYHK8BXRs/1V+t3ZZy36XTFnpMGq5qDuIYy6w5WPl?=
 =?us-ascii?Q?fs75xQ9leh24eIKiG4TBYPLG1jSAPSFKh5wmJPz/e5jBIXYSDmYxPkfN1XsU?=
 =?us-ascii?Q?mW1xIzwXBrUCgQI4mgipDJ0wfI31qtJgRCF2ULxA2p2Czy1KtdiOHOUpDEcv?=
 =?us-ascii?Q?6Og5fTpj5esiyKAAeq1rGOKIVle9UVNktjDR2mM0OPRW1PUd7mDqtdZeLTrz?=
 =?us-ascii?Q?NA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9016e0d-289a-403c-f1a7-08de25b90718
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 09:09:35.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Uc9TV51yn9Zp3yrR99z0kMTq9xfEldKGJC/jBlvMSLZZC3annvZ17/VhvESx2RNbidAEHIBiW98RXlSzFXJe1AzZwjS4nTKp4n3515YUyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8375
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDA3NiBTYWx0ZWRfX61uOQQPx8WQJ
 oX0NIsxgL5oFtfMEL9JOAPZQXGamr9hr18h8AEFora2wCGoZ0RDpnHHcJMdEHXMTWei88fzXLrG
 /OVg1YUuaaQ6VzZZd7D+5MzQ85oFzyIPNZaoPhNxtl7wGbic03nAagoc6Y8BHofXd3vwFmZ6yj8
 EytY3ygr6gyRirfcH02If4oNNlDT8szGB25GQETBU7y7Ofz98Qkmq19YO2B25OcXcSw0T+BkObP
 bryvPc7gB+OZcMHjuzk39iDq9Db4JZXBAGwTF+gGNM6iCk+5bxCgBT34yaFFmYvWiH0un4y4N9A
 1omI6SmlHSkDtZBLixvjD96NibA4upViSlMz1kwVAascRgBbKngKOER0HAYdjR4cC9FSqqoc3px
 +/jQKGWSZxtMsnN5r6sbhLuP7r+uYw==
X-Authority-Analysis: v=2.4 cv=VqUuwu2n c=1 sm=1 tr=0 ts=691ae651 cx=c_pps
 a=NRkibxwGrRsmaa9wFTKTPQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=ZjcQBk31BLpZNlfsepoA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: losG1XOmFOURqcE7shV-dNRBHiwXdo8f
X-Proofpoint-ORIG-GUID: losG1XOmFOURqcE7shV-dNRBHiwXdo8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170076

Hi Jonathan,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, November 15, 2025 7:24 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: robh@kernel.org; conor+dt@kernel.org; linux-iio@vger.kernel.org; linu=
x-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> clk@vger.kernel.org; Michael Turquette <mturquette@baylibre.com>; Stephen
> Boyd <sboyd@kernel.org>
> Subject: Re: [PATCH 2/2] iio: frequency: adf4377: add clk provider suppor=
t
>=20
> [External]
>=20
> On Fri, 14 Nov 2025 12:09:08 +0000
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add clk provider feature for the adf4377.
> >
> > Even though the driver was sent as an IIO driver in most cases the
> > device is actually seen as a clock provider.
> >
> > This patch aims to cover actual usecases requested by users in order to
> > completely control the output frequencies from userspace.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> Given this new code is basically a clock driver, I'd expect to see some
> relevant folk +CC.
>=20
> Added Michael, Stephen and linux-clk.
>=20
> One question from me right at the end around whether it makes sense
> to register an IIO device with no channels.  I left the rest so it was
> easy for the people added to the thread to see all the code.
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> > ---
> >  drivers/iio/frequency/adf4377.c | 131
> +++++++++++++++++++++++++++++++-
> >  1 file changed, 129 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/frequency/adf4377.c
> b/drivers/iio/frequency/adf4377.c
> > index 08833b7035e4..08dc2110cf8c 100644
> > --- a/drivers/iio/frequency/adf4377.c
> > +++ b/drivers/iio/frequency/adf4377.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/bits.h>
> >  #include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> >  #include <linux/clkdev.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > @@ -435,9 +436,14 @@ struct adf4377_state {
> >  	struct gpio_desc	*gpio_ce;
> >  	struct gpio_desc	*gpio_enclk1;
> >  	struct gpio_desc	*gpio_enclk2;
> > +	struct clk		*clk;
> > +	struct clk		*clkout;
> > +	struct clk_hw		hw;
> >  	u8			buf[2] __aligned(IIO_DMA_MINALIGN);
> >  };
> >
> > +#define to_adf4377_state(h)	container_of(h, struct adf4377_state,
> hw)
> > +
> >  static const char * const adf4377_muxout_modes[] =3D {
> >  	[ADF4377_MUXOUT_HIGH_Z] =3D "high_z",
> >  	[ADF4377_MUXOUT_LKDET] =3D "lock_detect",
> > @@ -929,6 +935,120 @@ static int adf4377_freq_change(struct
> notifier_block *nb, unsigned long action,
> >  	return NOTIFY_OK;
> >  }
> >
> > +static void adf4377_clk_del_provider(void *data)
> > +{
> > +	struct adf4377_state *st =3D data;
> > +
> > +	of_clk_del_provider(st->spi->dev.of_node);
> > +}
> > +
> > +static unsigned long adf4377_clk_recalc_rate(struct clk_hw *hw,
> > +					      unsigned long parent_rate)
> > +{
> > +	struct adf4377_state *st =3D to_adf4377_state(hw);
> > +	u64 freq;
> > +	int ret;
> > +
> > +	ret =3D adf4377_get_freq(st, &freq);
> > +	if (ret)
> > +		return 0;
> > +
> > +	return freq;
> > +}
> > +
> > +static int adf4377_clk_set_rate(struct clk_hw *hw,
> > +				unsigned long rate,
> > +				unsigned long parent_rate)
> > +{
> > +	struct adf4377_state *st =3D to_adf4377_state(hw);
> > +
> > +	return adf4377_set_freq(st, rate);
> > +}
> > +
> > +static int adf4377_clk_prepare(struct clk_hw *hw)
> > +{
> > +	struct adf4377_state *st =3D to_adf4377_state(hw);
> > +
> > +	return regmap_update_bits(st->regmap, 0x1a,
> ADF4377_001A_PD_CLKOUT1_MSK |
> > +				  ADF4377_001A_PD_CLKOUT2_MSK,
> > +
> FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 0) |
> > +
> FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 0));
> > +}
> > +
> > +static void adf4377_clk_unprepare(struct clk_hw *hw)
> > +{
> > +	struct adf4377_state *st =3D to_adf4377_state(hw);
> > +
> > +	regmap_update_bits(st->regmap, 0x1a,
> ADF4377_001A_PD_CLKOUT1_MSK |
> > +			   ADF4377_001A_PD_CLKOUT2_MSK,
> > +			   FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 1)
> |
> > +			   FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK,
> 1));
> > +}
> > +
> > +static int adf4377_clk_is_enabled(struct clk_hw *hw)
> > +{
> > +	struct adf4377_state *st =3D to_adf4377_state(hw);
> > +	unsigned int readval;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(st->regmap, 0x1a, &readval);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return !(readval & (ADF4377_001A_PD_CLKOUT1_MSK |
> ADF4377_001A_PD_CLKOUT2_MSK));
> > +}
> > +
> > +static const struct clk_ops adf4377_clk_ops =3D {
> > +	.recalc_rate =3D adf4377_clk_recalc_rate,
> > +	.set_rate =3D adf4377_clk_set_rate,
> > +	.prepare =3D adf4377_clk_prepare,
> > +	.unprepare =3D adf4377_clk_unprepare,
> > +	.is_enabled =3D adf4377_clk_is_enabled,
> > +};
> > +
> > +static int adf4377_clk_register(struct adf4377_state *st)
> > +{
> > +	struct spi_device *spi =3D st->spi;
> > +	struct clk_init_data init;
> > +	struct clk *clk;
> > +	const char *parent_name;
> > +	int ret;
> > +
> > +	if (!device_property_present(&spi->dev, "#clock-cells"))
> > +		return 0;
> > +
> > +	if (device_property_read_string(&spi->dev, "clock-output-names",
> &init.name)) {
> > +		init.name =3D devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
> > +
> fwnode_get_name(dev_fwnode(&spi->dev)));
> > +		if (!init.name)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	parent_name =3D of_clk_get_parent_name(spi->dev.of_node, 0);
> > +	if (!parent_name)
> > +		return -EINVAL;
> > +
> > +	init.ops =3D &adf4377_clk_ops;
> > +	init.parent_names =3D &parent_name;
> > +	init.num_parents =3D 1;
> > +	init.flags =3D CLK_SET_RATE_PARENT;
> > +
> > +	st->hw.init =3D &init;
> > +	clk =3D devm_clk_register(&spi->dev, &st->hw);
> > +	if (IS_ERR(clk))
> > +		return PTR_ERR(clk);
> > +
> > +	st->clk =3D clk;
> > +
> > +	ret =3D of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_get,
> clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->clkout =3D clk;
> > +
> > +	return devm_add_action_or_reset(&spi->dev,
> adf4377_clk_del_provider, st);
> > +}
> > +
> >  static const struct adf4377_chip_info adf4377_chip_info =3D {
> >  	.name =3D "adf4377",
> >  	.has_gpio_enclk2 =3D true,
> > @@ -958,8 +1078,6 @@ static int adf4377_probe(struct spi_device *spi)
> >
> >  	indio_dev->info =3D &adf4377_info;
> >  	indio_dev->name =3D "adf4377";
> > -	indio_dev->channels =3D adf4377_channels;
> > -	indio_dev->num_channels =3D ARRAY_SIZE(adf4377_channels);
> >
> >  	st->regmap =3D regmap;
> >  	st->spi =3D spi;
> > @@ -979,6 +1097,15 @@ static int adf4377_probe(struct spi_device *spi)
> >  	if (ret)
> >  		return ret;
> >
> > +	ret =3D adf4377_clk_register(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!st->clkout) {
> > +		indio_dev->channels =3D adf4377_channels;
> > +		indio_dev->num_channels =3D ARRAY_SIZE(adf4377_channels);
>=20
> Why register a channel free iio device? Probably better to just not regis=
ter
> it at all in this path.

There was a similar discussion on adf4350 clock provider support and we end=
ed up using this approach.
https://github.com/torvalds/linux/commit/a1a09713b40dfc1c0b7d1f9233a7698c93=
a9af05
I wanted to stick to something that was accepted at some point in time.

Regards,
Antoniu
> > +	}
> > +
> >  	return devm_iio_device_register(&spi->dev, indio_dev);
> >  }
> >


