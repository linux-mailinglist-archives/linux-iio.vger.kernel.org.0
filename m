Return-Path: <linux-iio+bounces-21438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCE9AFBA71
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 20:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C887916BE7F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B7263C9F;
	Mon,  7 Jul 2025 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="K5bFUNbJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC91EE03D
	for <linux-iio@vger.kernel.org>; Mon,  7 Jul 2025 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912059; cv=fail; b=YkW/k968Yy69GQI6HPVwtQDbSc9dlObVvRWKhstSq5sNUskM2elmtsSWmVIAHuQQXneS8kpDI732q7qDOUmqN97ITv9RpexoE/gt1H8ZVwtvWtKsUr1OYXK/sR28jMTc3pEE5sdRct6RysqqpDeuGpX3iH1jgyxRpb0ZRgH+BYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912059; c=relaxed/simple;
	bh=2/iEZ5ZZMtuY6krQfBd7TPgLk8fNwWUnatj9kf6z5ok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+p/zjwQtxBNuY1PUez0aYhCVyBffDuz+o4Qv+auFpG61Dx94iLD6GNZg0Ubf9GZfJHhXiCW3saWmyFN2TqfizVJoBBTCdAdIM2GQn4kFOfktwn8i7VMYvK4UjrRok1k3V/M6Wht0M/QykjqgjPymIV71ngHIxZeuT/JmVTGfB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=K5bFUNbJ; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567HodBV018346;
	Mon, 7 Jul 2025 18:13:48 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012018.outbound.protection.outlook.com [40.107.149.18])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 47pwe3se2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 18:13:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWpF7Ygov517n+OIqld7NtibSse/5E4sMNpDmzAibjm3MzYUZv1ygy7wmMWdZPX27Eyws85p7HrXTxo6ksqDi3KmpiYDNQpbmW4WUHISP9s47OjRKME8mczhQsU4xn1AgusV8I1rDcrzSS/K7vFtdfLWx2Zc17aZZ507UpGyhIvdnPbFFLNuyoFFkUCMXgXjJuE414/cw8U/el+NF3amvC/py16euBUPRspKj9ADPpYhcmyyK9/woxgYOEn1eyFBhsBP/tv/6D4PXTw8GcP82cigyZ3KyaaX5X4i6esrNj7ttDcRwxEkBjn+Im6dHgpKcp7B9ubCFwI5+HRi5p9Q+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/iEZ5ZZMtuY6krQfBd7TPgLk8fNwWUnatj9kf6z5ok=;
 b=WrRzonLiU4wJQfNRP6+ojCimaKUdIvMzKMx7RJDufXQrwi8f2yIoZzh51u/uwrOwOLZA7KkQ/ivOeOJJGc4skPsBUPe3DR2fOU9U+d8BgTxgEm5aZWIfuDobzoBY0qSz2YANU5xtjVbXhsHFE7k/Np5XtSsNpHf8HInK0gekZfmsGJPwL7yEaukpxzxlW2X+p49MfUyDyDa3vjAMo6It6rCD+NXw5+wb1Qxcy640Woi2iSaukBySe9iUhPwY0p+KT+ud623CRImbtXJ+dFOm4L65HA3l/f9dNYbVF/ZRTyQpptBmPNYeYeSPx8a4PU11vEbRv+N6ReLaT+0+bP2QbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/iEZ5ZZMtuY6krQfBd7TPgLk8fNwWUnatj9kf6z5ok=;
 b=K5bFUNbJhLSu/u6/IwdwqJmCjy0tNi6mWZAFdSe359uiM2gX5Vh62/wi+AVKp2iledpdGEKXIJ2jG1CCS8nTyiF0LcOQRS7MnCsAqUTaVy/MEZKDqGEAjE9JVeF58yxXi5JHmO6aUHXPcsEZOMo71tfiYLVJjhRJEXJ2TmHxh3+EOTm66wxpca6BgPlXSYKMJD5BtQwKYDQGyjHHYweKNmpzUPKeoKOVl5kKo76Kdeeud1YbZQzHchUIo/qcTot+9zMRuAum5j1QFHH8Dh6gYwLbyVOpIsi/LLHLRPHybwvDnpxBAxz9AacNWQnbbH5n/gR0wFbLqzt1w3GVGonKCw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB0201.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:12::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 18:13:33 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%7]) with mapi id 15.20.8880.026; Mon, 7 Jul 2025
 18:13:33 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Sean Nyekjaer <sean@geanix.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Andy Shevchenko
	<andy@kernel.org>
Subject: Re: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Argument
Thread-Topic: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Argument
Thread-Index: AQHb701xWPPwUANIV0SBqYJxy5Bpk7Qm9S4i
Date: Mon, 7 Jul 2025 18:13:33 +0000
Message-ID:
 <FR3P281MB1757FE243D78E8F78DA6C576CE4FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o>
In-Reply-To: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB0201:EE_
x-ms-office365-filtering-correlation-id: 83ccc2f0-510f-4f86-073e-08ddbd81fc23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|19092799006|376014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Q5IGA4+KETU+qO7aji+9z3m/xlNRsZp1dqDU51+ZorXrHFugg7ZqQZKNIT?=
 =?iso-8859-1?Q?f5Ixah+zlOpKLJDTIzBINfm3EhEoTojPmMjZ45xtLP8KKZfHRahdvB/7xr?=
 =?iso-8859-1?Q?SMhmGjqw1bhJaDesnHuxQMmMlxciT+uFy8J5Bpz8kHgntUfatJZdBUIhcj?=
 =?iso-8859-1?Q?wxiix9JDhLsR2ccclpgbvbZYGTmvqnTsDXYiVYZZj95ixN1xWjS9uT/EQk?=
 =?iso-8859-1?Q?HDjgcWbBaGSek8MCoBB7lhD+oPI+NijUHIHv7r5V+kei/AbYMH4JLf/kfC?=
 =?iso-8859-1?Q?1ewLOoL8YW77lSlAKqjphOLZTcIk/oukRJDxkpxU6AvqLqRjgCxlXyHADp?=
 =?iso-8859-1?Q?yCW2F7jUvv0dL1lWQV0bGOWNkvoAGUd49QhIhsAY4omCZtLmzaNZP2Q9CY?=
 =?iso-8859-1?Q?KbhC+e1ppcTnrWecgcZGWJQUh0ckFPwXxfSfFDy+WFBgKWY9Y3exyxIkdj?=
 =?iso-8859-1?Q?1DRkE9qorNs2bx29Ixt+09TiswARyQmxI8XKGE6vUsol1YdJTCNMQkGUPc?=
 =?iso-8859-1?Q?4WC0hPD+HDJ3JRe5Daze5hNb2X241wlh0vY6VPMjiyGFwJEkxHI2L4uZes?=
 =?iso-8859-1?Q?HrArpz0xMLfRjqbujED1MlOn6BZF5f8TkfLBvVaHTG3al/EkOcCW1fYlWD?=
 =?iso-8859-1?Q?8TCjg9PrOxBunOu7043zJ1zTRkph+cFTBwPCtU5f8/DvTy2gemwsoxyGdX?=
 =?iso-8859-1?Q?6RcIPvJxxK8cbDWEScNagRpSCbI6lCTXbW4r1MST7pOGI5ceaYmXnF2v9r?=
 =?iso-8859-1?Q?W4Hr7tecp/0j9beHOrFocFTPL8YilTWM8K06S2CXzpUsmfaKpqpNPawxlZ?=
 =?iso-8859-1?Q?eUQVKSaoI7wKmlnT37SyTAicRjOlH0fGVLVoVVv8cBHd1lzGT3dPLQJ6hJ?=
 =?iso-8859-1?Q?7hIgRvTm4GBZH7FOECmq2fXP4KSkc3yT8PPUH/so9lJ+M0Ez36Tie2waf7?=
 =?iso-8859-1?Q?3e3aK36f9/VZ5RWUBYKqwvnH+0inX+rUZBIOHCO/GbVjRtnrXfWOxTf0vR?=
 =?iso-8859-1?Q?KZehOucoC3agttGLjzqpKbRaqOQFsx8EoFAiaCNZVuzbcSWFyNQ6vJDaeu?=
 =?iso-8859-1?Q?1B6cHsfFc1GGR9jbFWCcSHmdc39RetdKiZCmk4ougFMLFeIb1Cw/C4xgOy?=
 =?iso-8859-1?Q?N/pjmcQ8CfX7XSbtWoj7mzGZdtm494qRnb0rbM6mpV3GMqrBqE8UvCa8ut?=
 =?iso-8859-1?Q?6fm9LJwlrZcr+vkEQz6X7C4067AJWE2IXPNGpspHAKOBw7FzU3XynFi/Ew?=
 =?iso-8859-1?Q?jftSdS5p3OfjcK0GAR1bCy/skdUaDWJzwHV8QghtJiahd6UDfmP4sROrM0?=
 =?iso-8859-1?Q?lsNK9PfOjvhPwd1KOWGqu6mWml6W3EoH5yPKVVqqkUHkwzfIySN8LSSDDO?=
 =?iso-8859-1?Q?IPppG+qwy1V5FeaBDjDgqVsv9DDTLjAYYVgTGS2YOlexGFEoaqk6gG+Giy?=
 =?iso-8859-1?Q?WLX0PB93Em4AQR+RHqUW3FKnoYVQ6k+1Rjkg6I0LRFhElHzf0sFcSaTLel?=
 =?iso-8859-1?Q?X6FEemPqwYB2UnwlTU39G9fiN/sl9yUQC9135sdOS6NKeSIlfASADjM6Pt?=
 =?iso-8859-1?Q?YI/TEtmaGD9XYQ/20i6EqxlR7nRH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(19092799006)(376014)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FSWnRfTQxl6fMlzi5z8TgmpqZSHdek7OTR08XTaf+0ULQCDNZ9ypVNZt4V?=
 =?iso-8859-1?Q?NSzYD+xUPPD6QNLGzcQd21nN6wNxMrO1qnmr7BXGfFVQiMn331njTzk5/K?=
 =?iso-8859-1?Q?xNaHCn4wZzJjP6yg3nUEMOXV9I5eF9DAfolTgxJs3lnbW4qbSMwMHznqnL?=
 =?iso-8859-1?Q?9dkW6xtaXeAMFliFGfMgcnJU2T/yZdfczTw+3EdMSG50IZQccj8+qVnAmP?=
 =?iso-8859-1?Q?3RFxmpTUhENPjnTfOpkobRc1d11FsrgF2kmTU4CFXCoQSjrTbIZDo/OJxv?=
 =?iso-8859-1?Q?dkZqjcmYM1Aa7/RK4y6UZOMkoA1IWWzkSSoyrRWMzEc0ESPdQU4XznvVtm?=
 =?iso-8859-1?Q?AP31jVtvjIaJrKoEcvN+RFoi0Wo2nlKKTo9S6/sdd8etE5kAS+96s5gK45?=
 =?iso-8859-1?Q?gjcL07UiuR06cqJlWWZVrlmcta8/jnV9WsoGnWo5KeKf9bLV7l+cpzjFet?=
 =?iso-8859-1?Q?bcI7Ierk7Yx0ACxfU5JjI1tMPjQ4Xazn2nmujwUz7fXb8D+idvv2yqsy09?=
 =?iso-8859-1?Q?TG7Ab80D7wqzjCdCNS8neZAqEuQL67OsddQpqJFdirHpikFdL7HOYcrvv1?=
 =?iso-8859-1?Q?RqmkRD8WHYYtUH43US8aLV11mCtXTnieemtu4627S8nqKfRnqOf/wCdNRM?=
 =?iso-8859-1?Q?e6PkyVpNC+ctnPt9oNzNGL2k2PRETWLOf7PIttz5fHBHXOzGP7pgIdZ1z7?=
 =?iso-8859-1?Q?LcI8RnqpTfKqdbnbZZp2pxlAoeSTBTpE/q1UssnEU66wD1UC0KR8O0usQ4?=
 =?iso-8859-1?Q?w61jJCwFb8ZIJ9060F35eOATBwfGVsNyVijF/r0TV/lBOLIbgq8w4A2unJ?=
 =?iso-8859-1?Q?uQo1etrjohHacdeTHbcgrCbACdjGUasbuTVIofI4jPx20wJ7VXY0Y5k+iP?=
 =?iso-8859-1?Q?s5VjJMA+NLSaRB9AtrUXRRnBbt8I1TtpsjbAM1aK8MJed5rPgIEu6JeQ4j?=
 =?iso-8859-1?Q?eheH9+K2hhClZk6SeXwkoAllGg12HYIEeV61BzAiNGvNRDxr+BVE0+Q62s?=
 =?iso-8859-1?Q?MVTL5yOMpA87WD9YIV1uk25FwsDIzvl0XKA8j1Is5a6aCpOKw22zDtbZBW?=
 =?iso-8859-1?Q?vP5Q3lhJmKrWSRYgn8dYeCakSEXbfKJQgSjCYe+VaKdLAeCpmmHtusm0Af?=
 =?iso-8859-1?Q?YYa3+utMOvUZtL6wNpYYP4GNDyfA4BlCTtcc/FASxspcgAitd9L/HUmYVV?=
 =?iso-8859-1?Q?1WUmeIGbMlQta3TaM0pY/C9DXhOICZ0kaeoiOQRyzMvotx3jRzWPXyeMAF?=
 =?iso-8859-1?Q?LkeB/PHMFOhmHSbKCCkxJZ5BeqqTUdxRozB7jn5aMEFoBsk8Z9cQBuHsBK?=
 =?iso-8859-1?Q?Nw9ob+IjRIBgNeWWdugBF+zOHvjLbszrnlTtJwllMCWu3mm36HZYwg3X+Y?=
 =?iso-8859-1?Q?xccwrGLMVsvXiF1AwhgQIabjrjcuDgRXPHGbF5YXFffa9ISwtia76Q9EgN?=
 =?iso-8859-1?Q?OnxxMuDVD/XlJ0F1pHHNsuGaT5a1P+0cf7LjV0xlONcNsPSrlnVm8Jpxut?=
 =?iso-8859-1?Q?ZL/J/DGu8Cgb7ckpPgOK0naOEvT+u673xzOwsxJmbHtasuF+nRyDeitK40?=
 =?iso-8859-1?Q?RSd1V5/t0dtPXrAEcu38ax+VGYsLwcS2ukCyQ3Dl5IMqlqUFLfYVFNsbhc?=
 =?iso-8859-1?Q?eCFVdf3rJErtuFoWZDHmQQyHWgDOIcin3iU8iSwzFic3S7o+jlpBuOelFc?=
 =?iso-8859-1?Q?wZYSiY12WLClb6uWKf553rB1dpqwh91N2427ryVKJkOh2ncJV3tzcttdbh?=
 =?iso-8859-1?Q?/pVQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ccc2f0-510f-4f86-073e-08ddbd81fc23
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 18:13:33.4761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HgJ2wfb2Q4UxsJfKV/qzYl/iyyWmh4mZqWBbtxFCFylI0nymJhkkv+SaWaAxF9G+IioTCgrkw8SXRYNGJWgQf9EbzDQ0wx9kS4Z1JGfLrrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0201
X-Authority-Analysis: v=2.4 cv=W6w4VQWk c=1 sm=1 tr=0 ts=686c0e5b cx=c_pps
 a=5NL3v2yKTvONhDxV9W2bFw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10 a=Uwzcpa5oeQwA:10
 a=bCmIK4stgvh7_BLXmqkA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDExOCBTYWx0ZWRfX5I0WQ2dDxqmX
 nehSN18Vgt6D564KRHNE6+0dYssBVNC2ZSNwvVwDLIf+whajlqYYfleIdXNsMjz52zsdH+eSzmq
 logWAEBf6t56jnEeb45gdtbC74mxwwaj4E1ofT0q6s7lxknOWmu4b751KqP9Iv1xMb4R5w9QWkN
 qXswb2MuRgwWYDHuWnEW7Pry34KGBkc1A97UDAyAmS1hfQOXlAaxkkdIuHeMPYLnatZIilzAJDM
 5ELUJhE66Dokdz5XuVk9xGbYsRv4Ek52gDKGoZQp/dVIha0Fl4obN1I86bNfiY4zneOK73JtHfU
 FkfrYsC98W+t3pBhAQmA0w+qZJFDpjr4uvAgDa6e9Uy1uIDode6j5DXAduindlxiDhJgyzTmo54
 JcamW6FqKwQrbcWndBENCRdg5+oLVev2TybzW3UIU4TEAqtUYQ4486ZHS5osULGmHztIonx7
X-Proofpoint-ORIG-GUID: dUx9C3g3qbfc00rJi3zhivQeQ1bvdZdH
X-Proofpoint-GUID: dUx9C3g3qbfc00rJi3zhivQeQ1bvdZdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxlogscore=982 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070118

>Hi,=0A=
>=0A=
>I'm having some weird issues with reading the temperature of the icm42605.=
=0A=
>Kernel version: 6.16.0-rc5=0A=
>=0A=
># cat /sys/bus/iio/devices/iio:device2/name=0A=
>icm42605-accel=0A=
>=0A=
>When reading the temperature I get:=0A=
># cat /sys/bus/iio/devices/iio:device2/in_temp_raw=0A=
>cat: read error: Invalid argument=0A=
>=0A=
>But if I read from the accelerometer first, I will go better:=0A=
># cat /sys/bus/iio/devices/iio:device2/in_accel_x_raw=0A=
>-378=0A=
># cat /sys/bus/iio/devices/iio:device2/in_temp_raw=0A=
>600=0A=
>=0A=
>Then after "some" time, I re-read the temperature I recieve=0A=
>"Invalid argument" again.=0A=
>=0A=
>I have traced the -EINVAL to inv_icm42600_temp_read() because I receive=0A=
>INV_ICM42600_DATA_INVALID.=0A=
>=0A=
>Register dump diff:=0A=
>--- invalid-read=0A=
>+++ ok-read=0A=
>@@ -10,14 +10,14 @@=0A=
> 0x1a =3D 0x00000010=0A=
> 0x1b =3D 0x00000000=0A=
> 0x1c =3D 0x00000000=0A=
>-0x1d =3D 0x00000080=0A=
>-0x1e =3D 0x00000000=0A=
>-0x1f =3D 0x00000080=0A=
>-0x20 =3D 0x00000000=0A=
>-0x21 =3D 0x00000080=0A=
>-0x22 =3D 0x00000000=0A=
>-0x23 =3D 0x00000080=0A=
>-0x24 =3D 0x00000000=0A=
>+0x1d =3D 0x00000002=0A=
>+0x1e =3D 0x00000038=0A=
>+0x1f =3D 0x000000fe=0A=
>+0x20 =3D 0x00000085=0A=
>+0x21 =3D 0x000000fe=0A=
>+0x22 =3D 0x000000df=0A=
>+0x23 =3D 0x000000f8=0A=
>+0x24 =3D 0x0000003a=0A=
> 0x25 =3D 0x00000080=0A=
> 0x26 =3D 0x00000000=0A=
> 0x27 =3D 0x00000080=0A=
>@@ -26,7 +26,7 @@=0A=
> 0x2a =3D 0x00000000=0A=
> 0x2b =3D 0x00000000=0A=
> 0x2c =3D 0x00000000=0A=
>-0x2d =3D 0x00000000=0A=
>+0x2d =3D 0x00000008=0A=
> 0x2e =3D 0x00000000=0A=
> 0x2f =3D 0x00000000=0A=
> 0x30 =3D 0x000000ff=0A=
>@@ -59,11 +59,11 @@=0A=
> 0x4b =3D 0x00000000=0A=
> 0x4c =3D 0x00000032=0A=
> 0x4d =3D 0x00000099=0A=
>-0x4e =3D 0x00000000=0A=
>+0x4e =3D 0x00000002=0A=
> 0x4f =3D 0x00000009=0A=
> 0x50 =3D 0x00000009=0A=
> 0x51 =3D 0x00000016=0A=
>-0x52 =3D 0x00000000=0A=
>+0x52 =3D 0x00000060=0A=
> 0x53 =3D 0x0000000d=0A=
> 0x54 =3D 0x00000031=0A=
> 0x55 =3D 0x00000000=0A=
>=0A=
>Will the iio core retry a read? If the -EINVAL is returned,=0A=
>inv_icm42600_accel_read_raw() is call once more.=0A=
>=0A=
>One more thing...=0A=
>When I'm removing the module, the kernel prints this:=0A=
>inv-icm42600-i2c 1-0068: Runtime PM usage count underflow!=0A=
>=0A=
>I will continue investigate this=0A=
>Br,=0A=
>Sean=0A=
=0A=
Hello Sean,=0A=
=0A=
this is expected behavior since the temperature returned is not the externa=
l=0A=
temperature but the temperature of the mechanical component (MEMS). It will=
=0A=
only work if the chip is on, meaning accelerometer and/or gyroscope is on.=
=0A=
=0A=
That's why you can get temperature after reading accel data since it is=0A=
turning the chip. But after a short while autosuspend is putting the chip=
=0A=
back off and you cannot read temperature anymore.=0A=
=0A=
You need to turn one sensor continuously on with a buffer, and then you can=
=0A=
read temperature all the time since the chip is running.=0A=
=0A=
Temperature data are here only to do temperature compensation of the accel=
=0A=
and gyro data.=0A=
=0A=
Thanks,=0A=
JB=

