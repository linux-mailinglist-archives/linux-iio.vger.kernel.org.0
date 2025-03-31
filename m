Return-Path: <linux-iio+bounces-17474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0497AA767D3
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 16:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AB41888A6F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28302139B6;
	Mon, 31 Mar 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="DcJ+CgvI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390071D89FD
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431293; cv=fail; b=LTAR0RrJiLooJ0XnWpXO1I+Tj52tGZTCDbkQvlWT7xJy/wSuq90fUtE6eHR+AmcFaeEI+Rio14TU79tIRqxTeZJNGcKwOFLbYV18dMrSZEp6QkjcDcpx89oEIgLySQXWl+nC0nfpKVdB5qkqq3JYs5x1vFctHkmeQgmW7LFQqAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431293; c=relaxed/simple;
	bh=VlMGz0P6VFFOFgoCYP3k/OtFRHfFK8vhOBorEuOSONQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ubgdBRR0kkd6V7Tan2qvZ6Z6sjl9AaphIX+GBTSOasrvltXqihMUpGp8Ft5KPPUxbJ82Ir7bPqHlR2e2dBtjz6JqU77iXo6tXz7xOKjz1ODnOTl36mwEKoXmYhYI9i0p/KHELGCuWtgWp2kc4nAAJOtOhqR9bdAY6Y5TECU8UTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=DcJ+CgvI; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UMj201029329;
	Mon, 31 Mar 2025 14:27:43 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazlp17012052.outbound.protection.outlook.com [40.93.78.52])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 45p7839neg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 14:27:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDo/oar4dmmrFPwdSP0AL0F6unkBB+KuSZ6maWzai7mP6M4/Ty7cAYlz4jSmdv6z7NDWsWOPqYaOxYnC9RlfCSHiPex1IWKh14yw4oKNARLSwwniinBCgY5nIclk/CWPWTfilREVjf43rFMk+u5UTB8e/d8xd+xexMdrSRKL247aJio9RBetPzhr6mgay44WwWNocgokqIpWLCmYFZqACMKJW9ySFBgmnpwPWW0KI8tPLNs/GodBw3KKl7OlpGqSAbwDrukjsQXS5HzsiRCcYhPqM3z+S6siE8qxZOK2irDHH2c4y5q2hqzv/KnWwq17499O+FKKJfYJJzr+bQSnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WoeV4SYnCXfeS491kGgVYmo3XbbeD5j2wX6LOugxfE=;
 b=TX9caRifTRFc3EtLA9mHhrGGgWTMSVTU3UCd9uR1qGU2cSWuSdlLJB/nm95oRmRifbiKKIGJbqJOdS9eSjkBF57XM02EkuMHhSe9/e5CmvHyulBd53PDKb6KaB6SJdfRkQfQiUzRJrb3vhTXGEPhDGWEf20l+2aJdkUPyrW5Yv8l69sGVxqLU35jIXAh4b13HUiLMsqE+EBE+uWmRzlG1HxPAW6Ywxi+/UR0sohKrZjHEx0rILc1y4QEj7eXPywiuU3xlb+vQPJyPI0eT0dkERO+N/YQLpOzSw9W8cV3ZC58AcznhNw2YEhYk6EUgnOsnCFU1emOZkrR8+wsSQXKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WoeV4SYnCXfeS491kGgVYmo3XbbeD5j2wX6LOugxfE=;
 b=DcJ+CgvI+fbe9SWvjHGj2i0oYua/QW0muoMIxzyf9GaLGPfBSQasQWgRuo+Q7so6NnLisLuOJ6KJDsRNFt/XOd3FdhZHS13gRheSyICD9R/FZZSZBP3rK9RiPBqEiqASD3Nwko25Ts9AfLmOrq0QYsQBWWjJkJQx9nvkNxjsIz0Pe8KD8zF3IikzvQA/xdzHWftUvMteOzFAOq0DaXjIRGj9rPzxWbqRt69sxUN1k+NSAXpj1FWGNqxM034WavNJyq90UU4HlIwKFlgjYGKWP5ECO2e7sx7UH2/Nas51oVDz+XpPM+V+tMuYArOy15l8ltHxAskY6Zdmi7cbfWfesg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR6P281MB4911.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 14:27:33 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 14:27:33 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Roan van Dijk
	<roan@protonic.nl>, Jyoti Bhayana <jbhayana@google.com>,
        Nishant Malpani
	<nish.malpani25@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>,
        Shen
 Jianping <Jianping.Shen@de.bosch.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Yasin Lee
	<yasin.lee.x@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 15/37] iio: imu: inv_icm42600: Switch to sparse friendly
 iio_device_claim/release_direct()
Thread-Topic: [PATCH 15/37] iio: imu: inv_icm42600: Switch to sparse friendly
 iio_device_claim/release_direct()
Thread-Index: AQHbojaTXjm1UaMEFEOXqpasto4h2LONTP9z
Date: Mon, 31 Mar 2025 14:27:33 +0000
Message-ID:
 <FR3P281MB1757CE98E24FFC8894735A3FCEAD2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-16-jic23@kernel.org>
In-Reply-To: <20250331121317.1694135-16-jic23@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR6P281MB4911:EE_
x-ms-office365-filtering-correlation-id: 36031f8f-c213-4a20-0bec-08dd70602d1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OtAcVLU0Rf5fjPneRoe0uzt2Lv/D0x4BpGmr3vyl6Vx1DrJY8FKnHTFVUW?=
 =?iso-8859-1?Q?dTEih/tyKMHxXpNKSn8C0K6HErcD+dgC8kR7IEvLOIJGwZ4hdVd1wwxcoC?=
 =?iso-8859-1?Q?8/ldwPt2N7kWFSZGvyqPSESlh85mZvaCd2YXz4qGGhbH9d6mN8dNESrOrW?=
 =?iso-8859-1?Q?JMHIAW+QFZxg+XQCnSEpm/cjMAp97FhBoZJpLIX2q0cQEhBXLnZ3DfWwnE?=
 =?iso-8859-1?Q?J3ozbZRzIJjEJYGuCj4GgQQIeVmpN2ssYwWsnD4Du4WKKl1C0OUsvLg07o?=
 =?iso-8859-1?Q?dCBLXLHHAu5Xo7y5nR/Ebi39cKTmL3e5ax4olkiAnm2mPwF64n6Tk3dlRz?=
 =?iso-8859-1?Q?Gf9TbtVInx5xZdQr4zF3IBrXsbrE+wkUg91Snqp7TLmOq6aqp4Mz7ctqbF?=
 =?iso-8859-1?Q?j1IQoM44oVT5HgFp9QHvw63bAh+utDexSGXVOcE8JPTrXxEvZQPvE0KxVt?=
 =?iso-8859-1?Q?pQfQDqzXBCaLoJHdnO2ov8qJOuJYFDwdEsK84UdW3gXGFvV9yfl7NOej/6?=
 =?iso-8859-1?Q?tPKiNRu/ivLQPGP/L7MC40+bn3EJAE6GTKYKHjbjy8m0ZqrJ4+ImxJfMJF?=
 =?iso-8859-1?Q?X0NVmexRsgA/X5HqIbg4bBA8w2rq+FCIszBgD37mDvZfJx5AXhyp6IfeTt?=
 =?iso-8859-1?Q?ZkHOxuxr0WtKAMdZxEaC24tznNL+xH/9NuV0h59JjxDMdJapeqllAmhkKD?=
 =?iso-8859-1?Q?DL9A01CTcFi2Q65A6+/48iSpSBjJNAtIgSABG9BeDwUnDuxU3GPjWMXifZ?=
 =?iso-8859-1?Q?C8o3HtG58m+pV2RaVz3PqHJrnIHQuWuocA9u7yXRTlBdLgu1RRT5OjSSxo?=
 =?iso-8859-1?Q?+tyRGBtMKk08UTbUvTg/N+QFz0Q5hjDWd80IABkmG1fhciSZjSFeH77hN6?=
 =?iso-8859-1?Q?U1Gmw78wm0qVfHMPzDysFEoUc7lwUH9rnHqq1t26+5lpn3DaE2BrLrhRZX?=
 =?iso-8859-1?Q?7fWK+SSqBpG3//hZb6GX+V0lp/d/wZDf/z0q2+6vUlUedcCYhrLLuX8wih?=
 =?iso-8859-1?Q?EdMfpQdfqGwym1m8+qW6UdNp8LhHvD9fPVtdNa9TaNo/dpv/frhD+Uffj7?=
 =?iso-8859-1?Q?gfWwrZ452mfLIQn2HMPwFM1e0zu1ebVD1O8l49RFq9eHXKRg8TncwWZ+2J?=
 =?iso-8859-1?Q?VBqG0OZw2dnROhFJBO2HpmeHh9ytTLxwhgNX8+AyN6PLIiNAY/JhIdoG3a?=
 =?iso-8859-1?Q?uKkRuayjSyKBnYyG1zhFmGhcJRMt5PKLqNYJGZHUWjtWzctKdyb0NmvYCV?=
 =?iso-8859-1?Q?I1nqapQiXMasB9NVBaDuChPapbBvdbO4eNw4palntOv0g51p4pADDLcvUK?=
 =?iso-8859-1?Q?pxUuk4oNGBYN+xPPbMp/0wvfkArdXAaToa/JWhSk4/NeK03G5lkoWldXpr?=
 =?iso-8859-1?Q?tajKdimzHLoujLXfb21e9V3fC8QprLMuACk+IbCanMj459b0K0OQ4P2D/v?=
 =?iso-8859-1?Q?xpE98G3Xe2M7A+A8VHTcV19GK7U8hGDIGUwK8H3FTgFlXTyBlK5nO+Xbzi?=
 =?iso-8859-1?Q?P3ZYM3QL49KXNHEHVRJU8ezIedl6/xhG77AqIKKqnebq4Hmdk+x1n8x77U?=
 =?iso-8859-1?Q?By2HJurE1b2jQSVN2HMpXPQDV0XB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?B/B4SvzOJET4RmTN6pamwOUX3ljqSm1aa5DIHjH71hJ8t2yysspYWTy+d8?=
 =?iso-8859-1?Q?b0lmeIjd6aZ2HtCtN6rpVyhCntyZsIv1oDsrsRmivxmbiQzRLeo7doQe10?=
 =?iso-8859-1?Q?GEdzMt7EIFI6VyLnfIInFdudyXVRPkqRvhT7iE6Z4+Y79QOcoSKKfW4pPy?=
 =?iso-8859-1?Q?/GVStTzMyAYikkhjPty8VZmTnJRMVYH0C21KSbEcxa5m/OYbhd/itg2uDK?=
 =?iso-8859-1?Q?Bhhf9qoQUU4pCWuYU0uJ0gWGTtrTYHxsP0imx0vnvbYC41ofX1qo9fBDSA?=
 =?iso-8859-1?Q?7dUgW0rgOyXoEynMI0erpxFZCwbvuJirH3Nx+D9o7owARoQdtJTMinRvOk?=
 =?iso-8859-1?Q?B86Sbt7+d8wWyIcf0l3x22ysTK6vSlAzzpBGhQyR2qU/rpBKlDpA+LgSd6?=
 =?iso-8859-1?Q?/f2pq+Ubr7R5881ddvNzGEbJeUyK397LLQiGojY1tzhjlnSxp+37uboSzi?=
 =?iso-8859-1?Q?uwaegd7bEDcJVxXqFoPBTy969k2ApoqIv5sU4efiijscsLkWBL8ZTqFRZo?=
 =?iso-8859-1?Q?uk1S0GxhoYiVoVM4fcQADkM9qlZcKaAlbm3AP8wKkuPvb1qz5zTWJ08Y51?=
 =?iso-8859-1?Q?JRX1irYiwp7vGuk26JUaAu94gIQAzm4lsEqv4ViTOHIOfl42wcqBwBFUvD?=
 =?iso-8859-1?Q?l9k9iJhGM7PWESYZ2ssad0b8sEzdV0FD1CivY6P7ABCZCsRy+IDvN85mhe?=
 =?iso-8859-1?Q?wgR+ghsB+YiHWl+qgvmlzxVqvBS5zfQPIuxW+ZY8PHH1WKuRbUGt5go4Ad?=
 =?iso-8859-1?Q?5eReY/niddPQqrFXGEwdyObC/2EBiDJ8YD/ShkiPrswpoUDRJsQ+OeH1ON?=
 =?iso-8859-1?Q?XT2l/1ueeP9dm6nfPyT4u4I6qUQoFfMwFNI+qYpbohEiet/t8p9NR4RIlV?=
 =?iso-8859-1?Q?hSCf4s5UVxfNZVKTd4/JA+gRcU/LEJkvxY0HLO7SuVN+O8wwkjy1rL93nh?=
 =?iso-8859-1?Q?b51tcu1jNXhoDyU7fFtkjg+yAXQ1SXGqvOh/U6KwNzBg4t90iprMnI8zoe?=
 =?iso-8859-1?Q?N53gYE3mJSH+lbAQFHts/EWoTvs9LokZDDQrT0CPu0HADUsjrxqbLu9/86?=
 =?iso-8859-1?Q?dTPkEc20qeZnwPmbjOduNFynLQb0CPPNhm5xGQ6TZ7q6KQWnBPdOmwB2kQ?=
 =?iso-8859-1?Q?5KLh2Omx+7lzYNqRH4JmbG3bZ9AiXjq66M10oxGEpVsfP2ZSHS0uycxrrn?=
 =?iso-8859-1?Q?V/lc+uzjBuW9du5+BtPOW1nrYsDPNwGF16NXKKPsUi7A4m6O5unWNkIdvA?=
 =?iso-8859-1?Q?LxDmq+tEYb+H8+SOiioKlgwGt9W8p7g1jAYm/SNurl7wGJ0IYqPt1N73Ed?=
 =?iso-8859-1?Q?DJMHsDTboEgSyZ0DwOG5PSZwpldbx78MhSLsO+DgfZz77Cn1ttMshkhbWu?=
 =?iso-8859-1?Q?hb2yblEJLuz0XLvkKVmzRUaxLKeAkE2bUgZnXI4u5EA98S5NRBPcSL6BQo?=
 =?iso-8859-1?Q?BcoU+8lbdmBiqB9Na2BvUOz5p09mge59p4mtc7fjcJrHsr6n4naG9YmmA3?=
 =?iso-8859-1?Q?5oCU6wZJpTLN2I7gTWVWtTWIGD97f5wt8iUyuq9/IHJzZUUfFD+eIvIdvw?=
 =?iso-8859-1?Q?Hw1s13xpNYH/xMzYqsqdISes4d2LFexqZ6DVuUiImVWnt/dB74t2Q9CKu6?=
 =?iso-8859-1?Q?5cp8a3Ztd37zy97kaSLsdUakYaFP8C1QpyoNvqCGbiyv/6mYTg9uUV9g?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36031f8f-c213-4a20-0bec-08dd70602d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 14:27:33.2560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/xnG3qCZ/bJoUgkFCOP9Q8jIqfaEF/2hoTvdTBZ1iWmCiI7ybtcLeav6PRKsYNjVpaHas3ywgwyBsSqHdYkvuTnuX0ciNcBk7WrnOQm0MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4911
X-Proofpoint-GUID: m2T27vNCE2TYL4V712y5osdyx7_9B0uQ
X-Proofpoint-ORIG-GUID: m2T27vNCE2TYL4V712y5osdyx7_9B0uQ
X-Authority-Analysis: v=2.4 cv=IOICChvG c=1 sm=1 tr=0 ts=67eaa65f cx=c_pps a=bBmKWSAFnWdIcMY9C64tuA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Uwzcpa5oeQwA:10 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=yutHOF6BAAAA:8 a=1XWaLZrsAAAA:8 a=IiweX4PvAAAA:8 a=hVcwujEvAAAA:8 a=i0EeH86SAAAA:8 a=Nfo4Gj4nzSk6AZZhg1gA:9
 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22 a=p9TLLz150Om7V_NzouHt:22 a=4UppLPHNXRjA7phoqhyY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310103

Hello Jonathan,=0A=
=0A=
looks good for me, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Monday, March 31, 2025 14:12=0A=
To:=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc:=A0David Lechner <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com>=
; Cosmin Tanislav <demonsingur@gmail.com>; Roan van Dijk <roan@protonic.nl>=
; Jyoti Bhayana <jbhayana@google.com>; Nishant Malpani <nish.malpani25@gmai=
l.com>; Eugene Zaikonnikov <ez@norphonic.com>; Jean-Baptiste Maneyrol <Jean=
-Baptiste.Maneyrol@tdk.com>; Shen Jianping <Jianping.Shen@de.bosch.com>; Lo=
renzo Bianconi <lorenzo@kernel.org>; Matti Vaittinen <mazziesaccount@gmail.=
com>; Yasin Lee <yasin.lee.x@gmail.com>; Andy Shevchenko <andy.shevchenko@g=
mail.com>; Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Subject:=A0[PATCH 15/37] iio: imu: inv_icm42600: Switch to sparse friendly =
iio_device_claim/release_direct()=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
These new functions allow sparse to find failures to release=0A=
direct mode reducing chances of bugs over the claim_direct_mode()=0A=
functions that are deprecated.=0A=
=0A=
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
---=0A=
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 21 ++++++++-----------=0A=
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c =A0| 21 ++++++++-----------=
=0A=
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c =A0| =A07 +++----=0A=
 3 files changed, 21 insertions(+), 28 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_accel.c=0A=
index 388520ec60b5..1a67f5ce1800 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
@@ -685,11 +685,10 @@ static int inv_icm42600_accel_read_raw(struct iio_dev=
 *indio_dev,=0A=
 =0A=
 	switch (mask) {=0A=
 	case IIO_CHAN_INFO_RAW:=0A=
-		ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
-		if (ret)=0A=
-			return ret;=0A=
+		if (!iio_device_claim_direct(indio_dev))=0A=
+			return -EBUSY;=0A=
 		ret =3D inv_icm42600_accel_read_sensor(indio_dev, chan, &data);=0A=
-		iio_device_release_direct_mode(indio_dev);=0A=
+		iio_device_release_direct(indio_dev);=0A=
 		if (ret)=0A=
 			return ret;=0A=
 		*val =3D data;=0A=
@@ -747,20 +746,18 @@ static int inv_icm42600_accel_write_raw(struct iio_de=
v *indio_dev,=0A=
 =0A=
 	switch (mask) {=0A=
 	case IIO_CHAN_INFO_SCALE:=0A=
-		ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
-		if (ret)=0A=
-			return ret;=0A=
+		if (!iio_device_claim_direct(indio_dev))=0A=
+			return -EBUSY;=0A=
 		ret =3D inv_icm42600_accel_write_scale(indio_dev, val, val2);=0A=
-		iio_device_release_direct_mode(indio_dev);=0A=
+		iio_device_release_direct(indio_dev);=0A=
 		return ret;=0A=
 	case IIO_CHAN_INFO_SAMP_FREQ:=0A=
 		return inv_icm42600_accel_write_odr(indio_dev, val, val2);=0A=
 	case IIO_CHAN_INFO_CALIBBIAS:=0A=
-		ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
-		if (ret)=0A=
-			return ret;=0A=
+		if (!iio_device_claim_direct(indio_dev))=0A=
+			return -EBUSY;=0A=
 		ret =3D inv_icm42600_accel_write_offset(st, chan, val, val2);=0A=
-		iio_device_release_direct_mode(indio_dev);=0A=
+		iio_device_release_direct(indio_dev);=0A=
 		return ret;=0A=
 	default:=0A=
 		return -EINVAL;=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
index 591ed78a55bb..70bac8ca28fa 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
@@ -591,11 +591,10 @@ static int inv_icm42600_gyro_read_raw(struct iio_dev =
*indio_dev,=0A=
 =0A=
 	switch (mask) {=0A=
 	case IIO_CHAN_INFO_RAW:=0A=
-		ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
-		if (ret)=0A=
-			return ret;=0A=
+		if (!iio_device_claim_direct(indio_dev))=0A=
+			return -EBUSY;=0A=
 		ret =3D inv_icm42600_gyro_read_sensor(st, chan, &data);=0A=
-		iio_device_release_direct_mode(indio_dev);=0A=
+		iio_device_release_direct(indio_dev);=0A=
 		if (ret)=0A=
 			return ret;=0A=
 		*val =3D data;=0A=
@@ -653,20 +652,18 @@ static int inv_icm42600_gyro_write_raw(struct iio_dev=
 *indio_dev,=0A=
 =0A=
 	switch (mask) {=0A=
 	case IIO_CHAN_INFO_SCALE:=0A=
-		ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
-		if (ret)=0A=
-			return ret;=0A=
+		if (!iio_device_claim_direct(indio_dev))=0A=
+			return -EBUSY;=0A=
 		ret =3D inv_icm42600_gyro_write_scale(indio_dev, val, val2);=0A=
-		iio_device_release_direct_mode(indio_dev);=0A=
+		iio_device_release_direct(indio_dev);=0A=
 		return ret;=0A=
 	case IIO_CHAN_INFO_SAMP_FREQ:=0A=
 		return inv_icm42600_gyro_write_odr(indio_dev, val, val2);=0A=
 	case IIO_CHAN_INFO_CALIBBIAS:=0A=
-		ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
-		if (ret)=0A=
-			return ret;=0A=
+		if (!iio_device_claim_direct(indio_dev))=0A=
+			return -EBUSY;=0A=
 		ret =3D inv_icm42600_gyro_write_offset(st, chan, val, val2);=0A=
-		iio_device_release_direct_mode(indio_dev);=0A=
+		iio_device_release_direct(indio_dev);=0A=
 		return ret;=0A=
 	default:=0A=
 		return -EINVAL;=0A=
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio=
/imu/inv_icm42600/inv_icm42600_temp.c=0A=
index 213cce1c3111..f77645d92efd 100644=0A=
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c=0A=
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c=0A=
@@ -56,11 +56,10 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_de=
v,=0A=
 =0A=
 	switch (mask) {=0A=
 	case IIO_CHAN_INFO_RAW:=0A=
-		ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
-		if (ret)=0A=
-			return ret;=0A=
+		if (!iio_device_claim_direct(indio_dev))=0A=
+			return -EBUSY;=0A=
 		ret =3D inv_icm42600_temp_read(st, &temp);=0A=
-		iio_device_release_direct_mode(indio_dev);=0A=
+		iio_device_release_direct(indio_dev);=0A=
 		if (ret)=0A=
 			return ret;=0A=
 		*val =3D temp;=0A=
-- =0A=
2.48.1=0A=
=0A=
=0A=

