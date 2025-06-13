Return-Path: <linux-iio+bounces-20598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76537AD8D80
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B21F3B9C36
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4062D188CC9;
	Fri, 13 Jun 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="brBqnsvz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E0433D9;
	Fri, 13 Jun 2025 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822278; cv=fail; b=kbVXDNqx/fjtlf6K57f3D7EoOzL5tWu1N5S5fMeA2eP+MduOgABtut92ZhYBpL++eWxhmIxdHvngQBi5NVSNig3jnO25xWxCzbLeJao/RzaD8YZgv4/0CxOFNdG87ZkV2MeyIVHa/WQm+pnFxp1VnzJ3LSWZoW6EbpgkKE3ctOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822278; c=relaxed/simple;
	bh=Q2WMst5wFVwGw5oNoIFXDfg65RSPR6oHZ9SdqfiwQVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPTHwKnnAH+BDM+9LrMnjsKtRfD2kFUEgEajsIhNjeQ31qrleHcVVum8wMe8KysFQeiV9zbxKFpGkOaKk1zkmLskpJpEKpOO+43+tsun0BLtLXTIjC08gyEoGmAEma7M0rZ3o52Z1ZsekNWY2U3QYt0m8/0WWILcQp1nZT0EyqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=brBqnsvz; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCmeAf002757;
	Fri, 13 Jun 2025 13:44:04 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012042.outbound.protection.outlook.com [40.107.149.42])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 474esnmtt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 13:44:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhEx5lzbcT3FOC0lwCy/NpZUXJrx0qJYg7MkGFbMiO0TrSZ8WMmKw5Ag6gmU2TusNCqzPkjkU0en7xiadx4hWTI5kMvO2W0te0XTe4OLvlCyNmdnnDqhDcIAw3b0KFfKEBFi2sxln+LxQmP2SjwDvmatxOajyR+kngAjckN4NvigSVV2ZrFFGKbmtHi13BVaw51zEwmeKKimYWeJ4tspVKpUtIHC5cOgSR/Yciof4SEUYcofTxo9tLatZORIGSkcDdhQOXRiogf3o3dmtkmEfpA21J0GGQ5c0gmuzr4VpTpbiTSOGU5OBiTDjcM8FQqBm4wiiu85qMfeKb2mofC5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FD2GvJLIa4legIF2pPgGuCE0PQbsQ0KmDAIb0bhSQI=;
 b=ldEwn9h3OWTLDtR1j5S5WdyGBUQbJX1zYH4XssqLU8kpwbzIl6u/O+KiBX8C3rAyhpZRSuexKf2/OSHZ08LF0TRjmz2fOBS2Mhvaftwa3N+jltzuO4bgmc3rRuceGQEznU6ZNo95+c6sa1/mZCidWM9GVaEB2bqsHWsXnBih3vSL6Y8mHgA18UIUTnEucA/FWqG6N0MJyq+YbhBM2+zVX3VcOwtmjshLRZc9RBpGw+SEh/uVNUbKKDBslNccTaF9ogsqvgy3pjGnvE0ganuPpUKt/xdleRN1wBkKMCZBKZTDdpPP44dZsP2ahrYP8bu2zL6ekCjXNs8B/uvp2BIOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FD2GvJLIa4legIF2pPgGuCE0PQbsQ0KmDAIb0bhSQI=;
 b=brBqnsvzVIyEyNarMddab94QgxANpM345C7xad3X0lcujoq56/dc4ONxyEhNd2R9DUFBoQUUNsum0Jyo/zM75E/We0sEgMVl49AnyMj1Ajncrt5swT/TSd+0WNkaJEwbYLLq99/IDLUTvizjzL3HYMHc/zGgFAKanSIaiqGi3Is6iKmg78g9IR8KDD/F/KKvvKQOFMtVnAzhJl9jA4i0wLiyqbKHLeBWffp4y+em9VQxKUiOYZhZ3cKCPjeARCyYA9TqekwTh+ThlA8zqZkAE65skIRAV4Z0cehkeRrB5RZplLzqvVfE+bA0psFL101nvDTZvTR5yPNwEwlxu+ZgFQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB2872.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 13:43:59 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 13:43:58 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Topic: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Index: AQHb3DWiaJg6fqmsLkOWVuHD5p4+yLQAwiAAgAA2IOiAABOvAIAAADkAgAAI6ao=
Date: Fri, 13 Jun 2025 13:43:58 +0000
Message-ID:
 <FR3P281MB1757AEF932A3CE2AB9637046CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
 <aEvhZiXHLLIRe41-@smile.fi.intel.com>
 <FR3P281MB17578B82AC67F49552E24EB3CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <aEwfUMgLTnQxOh_k@smile.fi.intel.com> <aEwfgP3tiio52Rj-@smile.fi.intel.com>
In-Reply-To: <aEwfgP3tiio52Rj-@smile.fi.intel.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1P281MB2872:EE_
x-ms-office365-filtering-correlation-id: 72914188-4d3d-42ee-e55c-08ddaa80594e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SkH4zX1cD5T4WJYmJXil67SX9EveOGbKaV+gwF7HZYGWKcYpWIX9Qbfe49?=
 =?iso-8859-1?Q?Rsl37ksf9wgudP8JuV1hmYqo26J2La2rpP6gjKAV5qsuksA3weoaShMn2p?=
 =?iso-8859-1?Q?iq/enPWHFH9JgZidlKTHOKZkEdaWkTZoldO33M+QPJdwcxu/a43XDQxRN4?=
 =?iso-8859-1?Q?5UmGM8BYHJ8jDelzveVuq1jhGBiL7jtt36FEPhpjlgb/mJa1tegylQuuaV?=
 =?iso-8859-1?Q?QoAp2QCFtKo+MU+FrPfzNIec6djZ9mUIJdsKR/R5wOtOFzJABRrcUtnq31?=
 =?iso-8859-1?Q?+9CQtuVxwFBL71TiVhuI+Pdkzqq3yp9OVZAG34eeos/B8lp/szrl5GkQCa?=
 =?iso-8859-1?Q?n7MXaZp0F3Lx55ZnjWTXF8h5DuNmQ2DTV/CpBffDWZBmsfcbs+QpTgEeWI?=
 =?iso-8859-1?Q?zhhO98zjxs/z8JF1izo+lHUkslde7AsOe/iuSL9ppqkqfI/cecdd14T/NJ?=
 =?iso-8859-1?Q?8gf7AzoU37Z3E+jvxG2dtJ6ygi9kGbn5tL5IV53KFH+Wnn51cyKMEVXaHy?=
 =?iso-8859-1?Q?ju6MYor5XGok6k379HVc7T7DzvVfCY5oIaPXfwKVxpgEJRkLv3alDLZTV2?=
 =?iso-8859-1?Q?2sUecrVbt3qwtMcUeK9aGR4gix9r06FoVPl9P+cH122W5ceP+j3Ps3F2Og?=
 =?iso-8859-1?Q?/sbylXF4lG8Ik4tIjHFwyioOCi5zi22GAU3neCaNPKpZ+BgkykIzWpe/fZ?=
 =?iso-8859-1?Q?IB2W8RCOcNRH2cOa9lZc1OCHLGox5el3WCfHfplyL+DWOprhhb7+fp+sry?=
 =?iso-8859-1?Q?icr0iJzZwj/6s7RJPja7xWHzxN4GDwTJ2qjed6gxUAB3Dy32SR91zbejnA?=
 =?iso-8859-1?Q?mvopufuovFSnWCx9I6cDjcI0qVwc0whcZw+L8+2N8vkfrTWHLcYiLAubHH?=
 =?iso-8859-1?Q?EzHhtsDwnuUsRfpJYj4Z5cGGl4dWeJVJoFDJ/3H/CFpqOu0j2sC46COZm2?=
 =?iso-8859-1?Q?X5l/9rKIHhYxAGVCPMjbonm4TyURx2uauAQkzZjh7NVXLeVeJFYMnUMvr5?=
 =?iso-8859-1?Q?hdtOxaxvw79wa5UuXsi75CMa/9t+Zg0f4fapbTjZpw1FvRghYzXOq+Ae6b?=
 =?iso-8859-1?Q?md5yAWu+V2Ic6TrKiScLjIM+bpBSSozMUFi85iU9Kk++xB962y50Bm0g+t?=
 =?iso-8859-1?Q?MYGn64PeBJDT4MLs/931lD141hht+h7uT1sIAZhCaMnwBVQHV4WIjExXH9?=
 =?iso-8859-1?Q?1yrgx+dQTrDu1PHmB80ZDsf7OmAPzvfIeHSngSDu8mrr0zEVRUylXVuwzN?=
 =?iso-8859-1?Q?6r48uwJjpd7npt7u3oTkrhX+o+JmVWDd1h+zVOiSZ5hOwB04Kw4UffAXw6?=
 =?iso-8859-1?Q?ArLEX0YAqQKpz5Axa2aCWf7CEqrBmEE1TqnFHicorGfYPvLa6IXm6bPGqw?=
 =?iso-8859-1?Q?KYJRQSMfvzeEnQXubXXAkSyKRdaWDE+uvFfznBuAVl12zFpIy1DENj+48R?=
 =?iso-8859-1?Q?cat86vAMtRX4YMQV1jjmvzsGUCYXzBaqekJyRPpivMs0h9Q6td+zJ04N7K?=
 =?iso-8859-1?Q?fS31nhdamvXJx8KApVqKNsCW04SKYIGBd6Z8HQ2lqXE0h9OrNBTK5DnNs7?=
 =?iso-8859-1?Q?lhQZUZXF8NEsPjoJqUPad99mEMoC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sa0D/Yr7f0HAJ1VvGzCx1q6r4St53/iOMhvWhaQmvciOV1kQyZGhs9hOeM?=
 =?iso-8859-1?Q?n+DRTW63viTG9NhZH6Lm8xb+sNNVeymS9bRlX8RbcBk3TyY/15zYEbjPOh?=
 =?iso-8859-1?Q?AU6gb/CfOfe9MaisX+WrSeDTUkcDj2JkrUfAvJYzCcvzJ6Q1vTK9RO+R9F?=
 =?iso-8859-1?Q?F35kfRheL0UUrCnnjXMFAKLO/rzcrJY6vBuel7+6WwMajRcWALOZYVpu9u?=
 =?iso-8859-1?Q?HzSJhzOZsZkpPkeK0e77QVqtWAE2JmyxIS6TA7Rbqw5xXYLwKHY0Lo7inN?=
 =?iso-8859-1?Q?2vO/5yOra6m55YSKw02ea6aW035/6gBzQft/WmSyNWlQbsAWG44V8gvpf6?=
 =?iso-8859-1?Q?x4y6YZZsYoyZMOqzuD1zUjn67J+X/QF1zGSQd17TeMPcKKyzmGjiLc9oFe?=
 =?iso-8859-1?Q?8Z9YvvIkbyqKOmhhL5ggHVZiAT5lFBwyMiCAEk04EFfkae9OxXvYvW7ZTP?=
 =?iso-8859-1?Q?xa4SS/iwtKzVDP0lAHIoPZzOMJslotybVByI1h8XH3VY/ZJY7jscKtdGki?=
 =?iso-8859-1?Q?JW3YvUz8/yQfWkEF0ne6crGTANaWmby/tgQOBbmrjjpW+HNPOGLC5fLfk2?=
 =?iso-8859-1?Q?7wCLr+EHqSOrYOsVVg+ErQUikG8/fgYmDWCrfwLZydMCy2hLCRaF6TfjrS?=
 =?iso-8859-1?Q?9RLMUd+ubc2Eia4luWjkvIVsCgoXFSGMaf6uFwq3Waq65s77FwxUHQtTt+?=
 =?iso-8859-1?Q?sTxCizDwZ5HoNMB/f3EGEF+t1okFqzc5kRoYwzfB/XQfukYbbaPIxRCr6q?=
 =?iso-8859-1?Q?b9MKyZsqziQHBbios4dBBZ/0NdTjeGpOOKpJM2mrywyKveaXKm6S3EK1A9?=
 =?iso-8859-1?Q?U0XO1HuKLe32JxHJdnaWtru0FS5VRohqFCJhjkQmK9tepiWN4EpTx/EX71?=
 =?iso-8859-1?Q?Mu+5MZlevFVETT3jG11hDlihXzKptbCIrIBZkYe3mVUl+hmFbpFE6VfZou?=
 =?iso-8859-1?Q?OOS+zeaHmDNS6X8h0dqtyuGUC69yXGrWz6g3AnvjhIcXTNxoCjuqf/uoNu?=
 =?iso-8859-1?Q?ZXc/MsS4Bu5aLPXHIXghgIBbWkuWny+tRUobdxMoZDQW09LA0LuK+9ccSA?=
 =?iso-8859-1?Q?llJl8HZkQaK4t1q4ZFZLMh8iEfthDbKDlsDAC6mbQHiZOl4N9sNt1dkW81?=
 =?iso-8859-1?Q?7jYT8PBdNLOkbFggDjpAg+owNtFJAaPbFgXqmpyFbjAsKOp5akg740qErq?=
 =?iso-8859-1?Q?BeSHKskvc5XL8yzV+v0d/nWw+zaa2kAy0s0c/chWBgO+syNE6V3UaKwHD1?=
 =?iso-8859-1?Q?1RdE2iwwxZD4uHVdan6StHpkvHAz94lIScAE0Gq+U3NABq2BJHouWMRqe7?=
 =?iso-8859-1?Q?GnawYyt60Ds3kVVAUWPvxwUvUe5bUw0zWRYVmLB8AOsnLhA0a6i2zX0Cj9?=
 =?iso-8859-1?Q?Qeis0yJFRHc8asBUHfaFiZ36A8yNn1igNA3o8eSBO8cOnz2Bk83pJeEhDz?=
 =?iso-8859-1?Q?IDLmbxWUTxXq5YUzhR8GLChsZEqdndaDQLCnhYsZb+2cLyRvTTPcJs1ByK?=
 =?iso-8859-1?Q?TCr+gSZ/JBoS7ZSSDPEln9bwg6YbicgqgkcASP18xBiV9vd1HntcYVT68Q?=
 =?iso-8859-1?Q?nwDCVx55wEqf81df3xAmvaq9MugV4ZXnOe8H0SLFINebg69DpMTDb7+Mrs?=
 =?iso-8859-1?Q?dVG8PpQzUP9BZoA99mEwUjJVV3nVQ/1q55qdjw1Tx7mDZ4ubrvfBv8YEyx?=
 =?iso-8859-1?Q?igD1KlEgsAbGHZgBn1tRL8FtXKkAzE+pubWEkWL5pek2zOq4tQ0oqaanps?=
 =?iso-8859-1?Q?uEng=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72914188-4d3d-42ee-e55c-08ddaa80594e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 13:43:58.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9dhaOcaLZZQm6h82PQCcZDqoaICCpPFX0gi5UCO9qsgkPk1WN8md8sNi2/JvvOMWU9U0cZsXYTaid+DsE2U59m+FvRZ6HM60XJg8AN1iMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2872
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEwMCBTYWx0ZWRfX3VKoRGWiLXH9
 qJBBFekhJ0skAQbq3/iFVEp8PWFoFKlB2MtPZiJEFUN5y8XaY/2TTTdsKbndEfjnRnok1MolniV
 hrS7r2n49yRHJURvzdc9PBJjaGiQT+agnkpa7cIu83bTFsYWWKC1HLH1RsFEjUvDR6K4pAu7DxA
 MgtxxlZ1f7qPdWPV6kDYvlG411l+OEqnKzDPpFuvNHntP979/5Sm5FU7qSO3Lg3OH76WQhej8PU
 gRXEGb+bupOhAeMJ24B0BasdGLRdui8y+X+40ovLF+eK8aldjhqB8L1i4Rmu7yZc1a00qQMjCcX
 uQyx/dAGIbJQqFCuBYJkeFJ2VPBIN0bw8U+ODnlsH9ogVZdTi9ST6pBMkajd6pOVkHAnMAhAAc2
 klqPs7oIs1M6nqqYi3xBhjo5ZpOYRr3orj2AiOFvErBtL53dkC/n7BMbyjxBZv8kB+2ppYEv
X-Proofpoint-GUID: R0DCU5doaCBdZbRZWoiRaWdbFocRc5C_
X-Proofpoint-ORIG-GUID: R0DCU5doaCBdZbRZWoiRaWdbFocRc5C_
X-Authority-Analysis: v=2.4 cv=P6Y6hjAu c=1 sm=1 tr=0 ts=684c2b23 cx=c_pps
 a=YO+KiMsvsh3rWD89CMFbsA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=QyXUC8HyAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=5oJRwxC-VJ8zwEdryuYA:9 a=wPNLvfGTeEIA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130100

>________________________________________=0A=
>From:=A0Andy Shevchenko <andriy.shevchenko@intel.com>=0A=
>Sent:=A0Friday, June 13, 2025 14:54=0A=
>To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
>Cc:=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafo=
o.de>; David Lechner <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com=
>; Andy Shevchenko <andy@kernel.org>; linux-iio@vger.kernel.org <linux-iio@=
vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.or=
g>=0A=
>Subject:=A0Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Fri, Jun 13, 2025 at 03:53:36PM +0300, Andy Shevchenko wrote:=0A=
>> On Fri, Jun 13, 2025 at 12:46:46PM +0000, Jean-Baptiste Maneyrol wrote:=
=0A=
>> > >From:=A0Andy Shevchenko <andriy.shevchenko@intel.com>=0A=
>> > >Sent:=A0Friday, June 13, 2025 10:29=0A=
>> > >On Fri, Jun 13, 2025 at 09:34:26AM +0200, Jean-Baptiste Maneyrol via =
B4 Relay wrote:=0A=
>=0A=
>...=0A=
>=0A=
>> > >Overall, looking to this patch again, I think it would be better to p=
repend it=0A=
>> > >by replacing *int*_t types by the respective uXX ones. Because in thi=
s patch=0A=
>> > >we add dozens of new ones which increases an unneeded churn in the fu=
ture.=0A=
>> > >=0A=
>> > In my opinion, to respect the rule don't mix *int*_t and uXX types, it=
 is better=0A=
>> > to keep *int*_t types. If it need to be changed, we can change afterwa=
rd the=0A=
>> > whole driver types with a replace tool and send it in a separate patch=
.=0A=
>> =0A=
>> It will be never ending story, sorry. We need someone to solve this tech=
 debt.=0A=
>> And since this patch adds more than 3 new users of it, I think it's a ca=
ndidate=0A=
>> to embrace the burden.=0A=
>=0A=
>For your convenience I can mock-up a change...=0A=
=0A=
It looks like there's something I don't understand in the kernel Documentat=
ion about=0A=
types then.=0A=
Quoting Documentation/process/coding-style.rst, section 5.d:=0A=
---=0A=
New types which are identical to standard C99 types, in certain exceptional=
 circumstances.=0A=
=0A=
Although it would only take a short amount of time for the eyes and brain t=
o become accustomed=0A=
to the standard types like uint32_t, some people object to their use anyway=
.=0A=
=0A=
Therefore, the Linux-specific u8/u16/u32/u64 types and their signed equival=
ents which are=0A=
identical to standard types are permitted -- although they are not mandator=
y in new code=0A=
of your own.=0A=
=0A=
When editing existing code which already uses one or the other set of types=
, you should=0A=
conform to the existing choices in that code.=0A=
---=0A=
=0A=
My understanding is that uXX are not mandatory for new code. You can use ty=
pes like *int*_t.=0A=
But you need to conform afterward to the existing choice. That's why this d=
river was=0A=
done initially with *int*_t types, and that patches are conforming to this =
choice.=0A=
=0A=
By looking at all Linux drivers, there are plenty of them using *int*_t, ev=
en=0A=
inside iio:=0A=
adc/xilinx-xadc.h:	uint16_t threshold[16];=0A=
adc/xilinx-xadc.h:	uint16_t temp_hysteresis;=0A=
adc/xilinx-xadc.h:	uint16_t *data;=0A=
adc/xilinx-xadc.h:	int (*read)(struct xadc *xadc, unsigned int reg, uint16_=
t *val);=0A=
adc/xilinx-xadc.h:	int (*write)(struct xadc *xadc, unsigned int reg, uint16=
_t val);=0A=
adc/xilinx-xadc.h:	uint16_t *val)=0A=
adc/xilinx-xadc.h:	uint16_t val)=0A=
adc/xilinx-xadc.h:	uint16_t *val)=0A=
adc/xilinx-xadc.h:	uint16_t val)=0A=
adc/xilinx-xadc-events.c:	uint16_t cfg, old_cfg;=0A=
adc/xilinx-xadc-core.c:	uint16_t val)=0A=
adc/xilinx-xadc-core.c:	uint16_t *val)=0A=
adc/xilinx-xadc-core.c:	uint16_t *val)=0A=
adc/xilinx-xadc-core.c:	uint16_t val)=0A=
adc/xilinx-xadc-core.c:	uint16_t mask, uint16_t val)=0A=
adc/xilinx-xadc-core.c:	uint16_t tmp;=0A=
adc/xilinx-xadc-core.c:	uint16_t mask, uint16_t val)=0A=
adc/xilinx-xadc-core.c:	uint16_t val;=0A=
adc/xilinx-xadc-core.c:	uint16_t val16;=0A=
adc/xilinx-xadc-core.c:	uint16_t val16;=0A=
chemical/scd4x.c:static int scd4x_write(struct scd4x_state *state, enum scd=
4x_cmd cmd, uint16_t arg)=0A=
chemical/scd4x.c:				uint16_t arg, void *response, int response_sz)=0A=
chemical/scd4x.c:static int scd4x_read_meas(struct scd4x_state *state, uint=
16_t *meas)=0A=
chemical/scd4x.c:		uint16_t val;=0A=
chemical/scd4x.c:static int scd4x_read_poll(struct scd4x_state *state, uint=
16_t *buf)=0A=
chemical/scd4x.c:	uint16_t buf[3];=0A=
chemical/scd4x.c:	uint16_t value;=0A=
chemical/scd4x.c:	uint16_t val, arg;=0A=
chemical/scd4x.c:		uint16_t data[3];=0A=
dac/ad7303.c:	uint16_t config;=0A=
dac/ti-dac7612.c:	uint16_t cache[2];=0A=
dac/ad5766.c:	uint16_t val;=0A=
dac/ad5766.c:	uint16_t val;=0A=
dac/ad5766.c:	uint16_t val;=0A=
dac/ad5449.c:	uint16_t dac_cache[AD5449_MAX_CHANNELS];=0A=
dac/ad8460.c:	uint16_t sym;=0A=
gyro/adis16136.c:	uint16_t lot1, lot2, lot3, serial;=0A=
gyro/adis16136.c:	uint16_t flash_count;=0A=
gyro/adis16136.c:	uint16_t t;=0A=
gyro/adis16136.c:	uint16_t val16;=0A=
gyro/adis16136.c:	uint16_t prod_id;=0A=
humidity/ens210.c:	uint16_t part_id;=0A=
imu/adis16400.c:	uint16_t prod_id;=0A=
imu/adis16400.c:	uint16_t flash_count;=0A=
imu/adis16400.c:	uint16_t t;=0A=
imu/adis16400.c:	uint16_t t;=0A=
imu/adis16400.c:	uint16_t val16;=0A=
imu/adis16400.c:	uint16_t prod_id, smp_prd;=0A=
imu/adis16400.c:	int16_t val16;=0A=
imu/adis16460.c:	uint16_t t;=0A=
...=0A=
=0A=
=0A=
Then, why it is mandatory to change this driver to use uXX instead?=0A=
=0A=
>=0A=
>-- =0A=
>With Best Regards,=0A=
>Andy Shevchenko=0A=
>=0A=
=0A=
Thanks,=0A=
JB=

