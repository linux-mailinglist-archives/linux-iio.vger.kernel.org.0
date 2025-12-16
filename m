Return-Path: <linux-iio+bounces-27118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 866F9CC4110
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 16:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3188F30C5C54
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265C62F0C6E;
	Tue, 16 Dec 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ZX6DM/2t"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020080.outbound.protection.outlook.com [52.101.69.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BD3644A0;
	Tue, 16 Dec 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899556; cv=fail; b=VyDZccXTXEJRBICaTkxa6OL5jmjrEvb0Lp5W+S6gIcGxg/qKhf6r9vLJsPuARj/1KMobEnx48Pl4p3NSif1wgL8n0k+4z67ey57HLda06BtGnpj3Wk0oaN9cFl7NI1gFC15aXMBZUVti8nGBEN2ckp/SklYwOidDw4K2s5CbwJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899556; c=relaxed/simple;
	bh=yy4O10FrNQ3jp4EnWuz/pNTcw5ueUt9ePj5LB03hcb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K3deAm0RLIKQ+bvBQ2Pi2p3ZhyxQtVjASoG6VZ4EnoffXnnN3pYA8uGVO8lMjMG2vn9fYEVx4/mt3n1JJu+/LLYf7sjPYEDIv8Q/YjcJsepaAqCV79xnY6CfJk0/ySnWmWmEnd8K2TqxZmc7hJ5z73EyyJOPNO6K9fqfbpzeKF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ZX6DM/2t; arc=fail smtp.client-ip=52.101.69.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeUa58Vcm4C1+oGZ80Wz254tz8bk5W4Qk3Z7eDXxOKDzXioI6msjztfeKx46gmudK4LyhNwxVB+nIjXsGLTQL934QAXnaEVzs/hehxJbrNKRgKjn71j4I1xnmd3shdLf9JoAuoSjE7emRVQbLuKAvQunVfoZHaPgPRuohLIiv2eR7jUhh6jbhKl5Knq8x8hcTaHe38OVFvC5PaABTnR3L0DPPPyz8PNOXCI3IKmJuExDDU2xIM0jLq+7DDlNUSQj45t6le3vp1PYI9E75SM6VXK3BDPimk1NB3f9QpOFIZDU9VldKMDVI9HCLjkXG7f/KgIYc+HKunpE+tKhGADxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy4O10FrNQ3jp4EnWuz/pNTcw5ueUt9ePj5LB03hcb8=;
 b=lL2xBhSApefUvP9z9dLu8tC6Wr/SC8HEYN+NjqX1UNy6DTo3d8BnAEs1kWtvRUYWSLPod7YX9sPIWIGqdAN4HiZ5GGw6F5LjRU9LvT+sPNOjeVcQ0s6NkZjWwm5gN8mbfLFh3BZk+QyKZieYbq9S5yEZ4A65uCbWRZl4W1FNJxe4acIdp++zQcbAVyhnoOQUShygvdw1A8nXY/7t62VQFfXpMiXELMhXAYq71TvyFupshaaEY4xnBT+tBaYsUH8AQOIkvf91+R0fgvNUSM9/+X+iT87ZXUhd0HBY5yXjCMHg5NJJLcbCFJNTpsxPOp8bamE54uq5m7bjGzgiru3C/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy4O10FrNQ3jp4EnWuz/pNTcw5ueUt9ePj5LB03hcb8=;
 b=ZX6DM/2t4sz1bwgHfJzxfMWaCJYaWYw9GmqsV03Fb+hJeWVjnEXeeeVKYQ6HR01JrFFKr3P0AUE4O322ELs+41TKhZ03xK3EgnJR/AdP/XyPK3zehCoTDRGJrbCuRC0GMDTwv6HB1/8CIQ5O2MaW4aCxdVp5LZtDVe/tJHY2mfgg0iGe2hm55EfMCZXwhYUSe5Rz4lCmeCddVe20/70q13XDXyJBE/E/HlmvRMumCGPsmlv48Zzm3eGguS4YWVgZUSFQwOF7LPZxF+A4+9bD8PitPWa8KQgzjacDO9hFG77bA7ygggh0/D25i3p0gpAS69Xl7YxtWpm7lCN2Cx5qVw==
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VI1PR06MB6399.eurprd06.prod.outlook.com (2603:10a6:800:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Tue, 16 Dec
 2025 15:39:08 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:39:08 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
To: =?iso-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
Thread-Topic: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
Thread-Index: AQHcboDg2jiPMh+SKEeDKHne+sMY7rUkOemAgABObAA=
Date: Tue, 16 Dec 2025 15:39:08 +0000
Message-ID: <d2cfd1bb-0bc0-47c0-a68a-3967cd64878c@vaisala.com>
References:
 <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
 <2a265681ad73bebf1ad7aeea418fb9399b8350cf.camel@gmail.com>
In-Reply-To: <2a265681ad73bebf1ad7aeea418fb9399b8350cf.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: AMBPR06MB10365.eurprd06.prod.outlook.com
 (15.20.9412.000)
msip_labels:
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Enabled=True;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SiteId=6d7393e0-41f5-4c2e-9b12-4c2be5da5c57;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SetDate=2025-12-16T15:39:07.869Z;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Name=No
 Label;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_ContentBits=1;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Method=Standard;
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR06MB10365:EE_|VI1PR06MB6399:EE_
x-ms-office365-filtering-correlation-id: 3f6e3c74-c3e5-44fb-4b69-08de3cb94074
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3waC7kYRbarhUvK7EN+soYfOtxcMZPgr/rJ/ieRzutTf/hRZXKHSkhvx9Z?=
 =?iso-8859-1?Q?H8so1rHmOYhyanBIcOCcNyV1U6eQq0qLKGs6Mm4hn8DymZwDEfdf/dNZDk?=
 =?iso-8859-1?Q?nLsRZz468lrfo1U7/rz9hiUQ1BAAwkLtj9nUSdJ0WQftLY5Gj9fmh2EIdH?=
 =?iso-8859-1?Q?2C81K4vpgihwJ7z/kEvEEiYYLWtT7krISQABvkLore623vMCxdilZA9Z2k?=
 =?iso-8859-1?Q?V21RtlHD9B+GAVrbOuM/QMt6+oing8sZOiGiNwWMyRxQ9QTFGlFEtuKEFr?=
 =?iso-8859-1?Q?erKT0cFvLNBFcAy6eG23Wobcoo1AK1Uw3mdt0SpnwN/UqHdhGuGsZ4/Dw8?=
 =?iso-8859-1?Q?ZXM2tG87+fxgFsZa9VYloigaFc7zLbXwI8f3rRe7/kKJPicUGR7sIgfZ6q?=
 =?iso-8859-1?Q?0MnuMzm8Nq8CSpvXVnx49J4zp2iUJAL2IU+IuFZGGt0BqrD6cGepLIBQvm?=
 =?iso-8859-1?Q?uCkTcqxwyNbbI6jbwU6RrYhkv+StMejKPkcnAKaO6mmn7dc7AB4OWG6x1M?=
 =?iso-8859-1?Q?1vATXUgMg7t3z9A3GY6rwL96E7XHgI5JEGl1yvld1STQn8J9jjJxUvfc1u?=
 =?iso-8859-1?Q?k5qardHvL4LPT02muhN1qNuRbmk0vXQct1ERUJRyryoZT41tCSx0B07RZZ?=
 =?iso-8859-1?Q?fRrRw+yAe2Xn6mamI9VGlgwVwEX6LdQf4ZQUAdG+jzjgC215kThRIbJ9Ee?=
 =?iso-8859-1?Q?KCwvXre161y3ERfPtrtHCDNp10H8Ibin2CmYbmJquuZ13JpUfBWqQUnv3h?=
 =?iso-8859-1?Q?lxj7EUuUVat1MKhqM/iNp7tPQHfAziMv3uSUiAVCdhSryzm+b4YvxYo6uK?=
 =?iso-8859-1?Q?RObF+DCHGXQzt+d8Wl/1OQDcfwmvUyGetU0ZxyzIvHftlBY61lg38Kd+/T?=
 =?iso-8859-1?Q?PbnU7ctWVM1+YhBINmWUS8qxCckqXmiAjaY4hgU0v7uKPv/e4EQuooOM6F?=
 =?iso-8859-1?Q?2WxQTDlhuXrcsu4FY4EwL5/DRjgrVcCmEdF8vSK+TJEX+0GcAYORpTRDk1?=
 =?iso-8859-1?Q?jPmLa4GwZhdZk32WUgf7DOQiEMRwQF2ki+mj0sAS8gJ9l0q92Or6DgUc5q?=
 =?iso-8859-1?Q?2N+UcudoaAyXMZC7YYNGXQUluhmbtJGww/ML0PpDzRAZphgeSf8DKGvQ9u?=
 =?iso-8859-1?Q?LEoSgIkKwbmo10t82Ihahn6zpz8wqxD5eAdZHk611ktPw2t+G7zDRVrhRJ?=
 =?iso-8859-1?Q?QDDTe07M54Ku0MDq1i+7hlrJZ6LjEni2OUUlh466Lvov+X4ETjuFTJhfah?=
 =?iso-8859-1?Q?7PI2U9vWajVbXoYNAWrJVww/7bMTCvNXXuPpDU80ACYxPry11sRsI2C2JU?=
 =?iso-8859-1?Q?jMIUknSvw3Nvo+AIAfYD8T1Y84VjbmZ7q8AkXcxaz1pSvz1MzLL28HQ03a?=
 =?iso-8859-1?Q?kg++ymaMMXJ+q5UG++5GRZ1cl90lL4AaBlRt/zQGTpXxiuyxEb/x22K1O4?=
 =?iso-8859-1?Q?4PhKwnwf0lVASgdfQnvwmaejv5wW7XN0L0/k4OrmZVLoc/0Avx8fi8qOfE?=
 =?iso-8859-1?Q?+cOxcRnHxxO40ZiQjuAO/UC0VVoFjZPSL6ISrpJIh8Ccyo1Jz7Q5hJyo/j?=
 =?iso-8859-1?Q?iumrPagYQC5KsZjqJYOlqRm8ob59?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oWcuhQzB36hg2mLHbuCEOpWSZkMmxu32YDJ/758QvvP0IaCG6mZBCVIV5v?=
 =?iso-8859-1?Q?Bra3RSjIlAw1z8kHy+xDngxMX+tho7XTOv4RnLlpbusVD13xzc5dfFXIcS?=
 =?iso-8859-1?Q?/VlZzVzcyJAkB52jjVIcDdeJ+uZPYrG4lEhHuZJ6H4yQLrGplm10NFaoN9?=
 =?iso-8859-1?Q?TB0pm+0VtBFpZOomSuF7fFBDP/Z8H8aq+lBPJSo1TfhMYlt5G2AGm5ou99?=
 =?iso-8859-1?Q?1FJNP1wBYv71q6AUInzZLcKe+2YV9+WijXAyWYUXpK5n3MCUV1m63MSQ1+?=
 =?iso-8859-1?Q?G0NFqXYag8RSa6nguChTrpc7h4tJBx8Pejzv7MQjXX8OruVSlLbgDDwYeD?=
 =?iso-8859-1?Q?9fcW5e1FO0/GP2Kb1UcGHRFNK+DKzFG7tfkHqXBR6yKckej2aNv7hqgURH?=
 =?iso-8859-1?Q?GCKwXVJ1hvl8KmyxYxSoejpgEQ4yw7JnY+1UymCB61q1EC0GQK82PXtS2u?=
 =?iso-8859-1?Q?ZIYLPAEmCkGmEio5qSeTX0+vMtWWpv+4CLx/FFL9wKoTQD4SBFv2uYr/T/?=
 =?iso-8859-1?Q?l8AJ9AL2Ontp2zY+IZz9X9o5Riy3nw9WTt+UPktpl2gIeqvFnOJ8BvK1V9?=
 =?iso-8859-1?Q?m2Ps/FMsQDS+o+bDpSYOz/cCmOBh7g+Y6+FIzT54tO9hUFYGEC4Kqz16Oj?=
 =?iso-8859-1?Q?rk+x6N+e4ZfAgm+fyiyQOJNoXRCse5+riBPbI0atVgecIw6FFUPMLrG4jo?=
 =?iso-8859-1?Q?7rtlkdEQ4AydyHmx9FWlp3m0R/iznUOz1y6XREvabm1664xBH7KZgYL4Fy?=
 =?iso-8859-1?Q?yGnxRGCIKcD7guiUa6ReMzvx/6HqWjJcNvshC0gzBvx6Xj/zV8SLKhWSdu?=
 =?iso-8859-1?Q?BwgbamgrI4Cf8XlMNn9Rk/mAMgz596sn2tbfJzOvowYys/06aZWpfai2Tk?=
 =?iso-8859-1?Q?9H1XohpNSQ7X5klnDeU0ctda7aXQ7+cZruyTB1FhEejS8X0Sflps4bIgnP?=
 =?iso-8859-1?Q?lfxDh+ZkMJk92RDcrwgl/A27x4BL07D3WQjFmayv3Fy0MwboeKq32YnVOJ?=
 =?iso-8859-1?Q?we+2xUUAd9MpjXkJwZoF+qn3A7PXpRr2sN9/gJAvG9kv+Ke7d2b+zpN/R/?=
 =?iso-8859-1?Q?I4wZNhnOCVLTowhfKQqfc7A+hxOf+bRvME62QZQvTZvFhWGutlYcdjUF07?=
 =?iso-8859-1?Q?rBolbMRHJ0+SSALkiMiK9lPbYIN+FvJnWAf8vFiIR1KW7+591zwCerMQZ9?=
 =?iso-8859-1?Q?0NpyOiZGRowmUtT5pnYEuCnwmwO8gXfdPUvssPmzLBQ4gfwsTWQqWcBaJ0?=
 =?iso-8859-1?Q?arXiau5eKSAkde1oZo/E/Jma9ht4zJFv40XDSTfVLQBD4Bqsy1JjFrBJCB?=
 =?iso-8859-1?Q?cslf2FN5Ncw/34mh14/GAqmFbSc32yL/GddVlg1YUXadoznuGQCvJG5HhY?=
 =?iso-8859-1?Q?VdXKkcaNxj7oGEHxW0gNS8yZbfy87OUkW9u8ig/YK8WIOS/qZ+5SKPxQvj?=
 =?iso-8859-1?Q?Qt7F+YlYLS4pIN7XFH33f1PMgvo3TL5aOeuiL9gAi7206C2WMy4tpJ+3ra?=
 =?iso-8859-1?Q?xgLVIXv3lddxYmX7hJ8Qo8ixVV69suLoK9KBPlApf3LKNI3+s82s1zE+bo?=
 =?iso-8859-1?Q?NHOSQP2UjNQ1ZvB5OSPIb6doOv6BuFkSMgJaJmSk1m9arfHfGfO+DOZz7+?=
 =?iso-8859-1?Q?WyfHL6F6MFZM1dQ6tUiBzElYz/XyMwJr0H?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E24B28747BBFFB4788549A7CBB14A6C0@VaisalaWorks.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6e3c74-c3e5-44fb-4b69-08de3cb94074
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 15:39:08.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzHaI1abrAJZfvC/71jfpaIS4y4pJFLse5ZT5zPraZm8HkxUK67gaQ9a3CyRdt6M4vX4jIGDWdwgc4o12UlQHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6399

Hi,=0A=
=0A=
On 16/12/2025 14:56, Nuno S=E1 wrote:=0A=
> On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:=0A=
>> Not all users can or want to use the device with an iio-backend.=0A=
>> For these users, let the driver work in standalone mode, not coupled=0A=
>> to the backend or the services it provides.=0A=
>>=0A=
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>=0A=
>> ---=0A=
>=0A=
> Which users? The only usecases (for all the supported devices) we have re=
quire=0A=
> the FPGA backend. So do you have a specific usecase for a specific device=
? If so, I would=0A=
> prefer an explicit boolean in the chip_info struture for the device(s) we=
 know this=0A=
> can happen (unless you have a usecase for all :)).=0A=
=0A=
This is generically for all the devices supported by the ad9467, not=0A=
only a specific device. So it's about how this is used as part of the=0A=
design.=0A=
=0A=
This is aimed at users that do not use the ADI HDL reference backend=0A=
with these devices, but instead have custom backends suited for their=0A=
own needs.=0A=
In that case, we need to be able to skip the backend registration and=0A=
register device as a standalone iio device.=0A=
=0A=
Hopefully this made the use case clearer?=0A=
=0A=
Thanks,=0A=
Tomas=0A=
=0A=
=0A=
>=0A=
> - Nuno S=E1=0A=
>=0A=
=0A=

