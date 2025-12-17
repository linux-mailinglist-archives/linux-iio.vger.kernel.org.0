Return-Path: <linux-iio+bounces-27128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5635CC6171
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 06:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B70A1302F68F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 05:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BD32D061F;
	Wed, 17 Dec 2025 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="GjWvSGKF"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021081.outbound.protection.outlook.com [40.107.130.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417A2BF015;
	Wed, 17 Dec 2025 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949894; cv=fail; b=hef7e53xTtBkiDtg1iNegBJsZqjSozJrykjkr+dGfhq0aMtBa3HUFT6B0cK4NbLstP9YgsEkQY13GBJeWxUNeeM6lU5273T+y42FYfNmBEVOGvmOnS8Ka1tfHSxGOim2NqzZgo7VnrnT9NIZWZyUEsMU0g9FH2+OrpJHCCreSEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949894; c=relaxed/simple;
	bh=K6C20dSDNNbn6JkgeuyPa45/Fk51BSnE/QyCd7kwMKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QjShI+mrCKFdXRWEGx9kx5lxZvAvRfdDRjHn1qgwtBuMj5aG21HtEgsxhVn+z4+Sy3Ul6WAArcNerumwmawcryu3rPFCCemUtiGvk6ieeXxESWxB9WAONtqm4AHR8RMeiec5HA5OY7HZEYVHtM4VIX8oXpkirpSlU/v4NyOC7nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=GjWvSGKF; arc=fail smtp.client-ip=40.107.130.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUjIyR8O1WFkuEYc5ihMEzUCMBwFVUZ25pYJf+1STvL3F00+bRGioYzWOtLRL5FH9482sBsA/sH3tWfR9AIuGzqzA0gB32Lrw7ByEcT4mMA6xxiRRafZ9Ui+pTkUXkg+Gjl7E6WWY79fl2084Yaa47NvI4FUMkrg/VnL+c3FEGVwCQ6UD3smAkju/Qvo/ciy+Th89QWi7U0KB+9TBdDy0KSEEBDoLRhqI7vp0fRGxvjt1adbyqxTaj+4hjO4JPhAwNmhkGykzQeZxFdTSJ+Ql/A1oPFvpCCjWIu/4MplNoBvuxvwgpzKR1SGKpgX9IZtc1Lg/1ODxf+uyPxzVVYDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6C20dSDNNbn6JkgeuyPa45/Fk51BSnE/QyCd7kwMKU=;
 b=H+tXDxFGEia+FJ1AGwwzxEvfz15IJ/9GBoFM4ljNcJ6oloDjmvF64MMK/ueMB4KQgvxLFCtjJTHhGqX9cR8A8T18krnnyer9l2gB4OSNjqtBGnKl5wC0oPraLXvB/X30RKjTzhZT69nlPfVn3s3nzx0sh1kAIWAsQl4IFaq6K4go7MiGzxeNQy4cJWdOQLZtYi1I0CBl6FykkTX+k4qiLxLrk4OZFmQ1Y8M2UzKxGx1T/2KxjO0E0DKeUlDHES2Jhww+4JVA7jjBypDaaixSs9S2MzKGJZiQL9DXLenxL0ytSTMvX8ogu6glvk3RE03IiS/YnJUtdu8+tV4bPw5WrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6C20dSDNNbn6JkgeuyPa45/Fk51BSnE/QyCd7kwMKU=;
 b=GjWvSGKFKRPDKf+Izb3s3OasSKLmDDWKuiTpFMvIc1F+2crJpl2v7tB+ovTMgcMOJNue8N8TEorzx8JtVr/rRNkAwwHWiKtwJFpUgRFvlo9EG3Jn6bAoyFAK4CXd3yhEJ6++qe6ky2bJRb7XFHzXuLFzjpCOtzQQ7bgxQtIjKeT4lFwtOU4YSsrb3xRpxu0/5mxeXALOyyClfNn2qoF2lFa1fIFoa51/+HzE5MqZTGthM4nS40djRJ9GJ4fO/jgJauTNfQZZXWBaoGbE8VqXtlGvafBactqxCUHD4U9QzpARIiw6+1dcBVlKAcSsP7nYu11130qvw1HfezbR25TUZA==
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AM0PR06MB6387.eurprd06.prod.outlook.com (2603:10a6:208:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 05:38:05 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 05:38:05 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
To: David Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan
 Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
Thread-Topic: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
Thread-Index: AQHcboDg2jiPMh+SKEeDKHne+sMY7rUkOemAgABObACAAEApAIAAqn8A
Date: Wed, 17 Dec 2025 05:38:05 +0000
Message-ID: <84bb3751-178f-4577-9952-2b3ad5d11dad@vaisala.com>
References:
 <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
 <2a265681ad73bebf1ad7aeea418fb9399b8350cf.camel@gmail.com>
 <d2cfd1bb-0bc0-47c0-a68a-3967cd64878c@vaisala.com>
 <2f45fdbd-44a3-41a2-9fc0-7c446bd7ca35@baylibre.com>
In-Reply-To: <2f45fdbd-44a3-41a2-9fc0-7c446bd7ca35@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: AMBPR06MB10365.eurprd06.prod.outlook.com
 (15.20.9434.000)
msip_labels:
 MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Enabled=True;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SiteId=6d7393e0-41f5-4c2e-9b12-4c2be5da5c57;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_SetDate=2025-12-17T05:38:05.052Z;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Name=No
 Label;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_ContentBits=1;MSIP_Label_7246d30e-a6af-4059-9b44-a42233242e28_Method=Standard;
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR06MB10365:EE_|AM0PR06MB6387:EE_
x-ms-office365-filtering-correlation-id: 6d387ff1-97c5-45a0-6850-08de3d2e73bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VwuDLp9uWPlVIr0N10VAFPGu6oMZC3OV6gvdVr3Pw7anzbjGEjVRZwmY6z?=
 =?iso-8859-1?Q?qJjWxmu7kkqQRf7+3W+IJguaRgn6oWgo5qRFumgb2MJkqy7TGI03oEsxiZ?=
 =?iso-8859-1?Q?zvrDXU8gI1HRUXWQ3b/Xy0rDWtfsIt2qshnStCdbCc94UEGJnyukF+PFZL?=
 =?iso-8859-1?Q?9pF61iymO9pwUEsBSfBYss+MmsA3itEUe4chX5Kd4+NxO8KVA9LEJ0mtmo?=
 =?iso-8859-1?Q?Ui8ZeFczncMaKHi9jTj2YyP/HTfTRfxxwCmZMIXs+ysP6SOXD6sCDB7nuS?=
 =?iso-8859-1?Q?MR1PdMWKdRfrhQan++B3JU2MRLCd66SB11QS2LwIJGr5HUUSWd1rtHjYRW?=
 =?iso-8859-1?Q?TMrxQoeShZZfNeQ3+Ry/XiIBMmBghKvAIww7n9HkG3MtEehST6EYuX4upe?=
 =?iso-8859-1?Q?mAqBR+ZdAmDdZx129vDMRr7U7Y9m/Gaip27B4MFGn3x9GyOyXmiNs9TaqZ?=
 =?iso-8859-1?Q?n7ygJKlSOnNRDhvvxOZD5CzZHgbqEMeW2jf0KB2SQJVdBcBElOAge5ZSft?=
 =?iso-8859-1?Q?S3zye44Zn09gWoQFCc3fge+Rtr6poZA2LQqku6S7MoAw3svqC/0QOgEw/n?=
 =?iso-8859-1?Q?QhIVjj31QUILh5+SbMEn2uJq/HrXh30eGjSqOKUbTCzQ0xa2nOr2gWDEuy?=
 =?iso-8859-1?Q?2xGeSsXJ2hEnbPyGyBKmV+9ebddKAHlAi30uFCT7rY8eNDNQWF2QJhb06P?=
 =?iso-8859-1?Q?roJAwkHsrm9Ys4nQKQN+5Ymc4+Fr+NzVvkssgSLqZEbAm7s9p/yEwbRTJ+?=
 =?iso-8859-1?Q?MzJSxZwEqHI8bEEwg73uygYNX1BIPgA6CyHnX6wHrF7Vdd+XgNjJzvJV8r?=
 =?iso-8859-1?Q?/qAW0RGFLgpOB5KHx6AWzPAaATAnUU2GzW3KJylc4mGh6nATDTRXJEHQpj?=
 =?iso-8859-1?Q?2oURd/0Omx02v5L3Vb7ZnNSLhWUHhHCEQznfDyIEqliFmTrp/5SzteJcsA?=
 =?iso-8859-1?Q?6Mp9qv9H0CI1sTO0N23l1wAPSRC3kPfKw9iK3ATHEM/Kci/yqB0u/6LLnQ?=
 =?iso-8859-1?Q?HLg6QaaleBkvn35s3lfdliFuY0m8qYfdq/CdKjzEhiFal852ivwVDMMgic?=
 =?iso-8859-1?Q?Iwg4Zk5tm/7CRLKwVzErzCOEapKqKZYmmuKv4xbBGLj56NSSL4pbkRr0QS?=
 =?iso-8859-1?Q?A+/xq19+6GXjBPDoTQRxJXFGi2HG9GLlSPz8DNQ505GX9HuWcHyzdhOUWK?=
 =?iso-8859-1?Q?xuxVkH4Z3n7euQrgkYrB6Vgmvcwu5ohl5Es4NlBaqaOzz9QkzPpoe5jng1?=
 =?iso-8859-1?Q?e16pyXK+pPGPOnIIfViBqHFL2mZG9JgnM/S9HAxlvSkv+HyR1bD/xFxtm5?=
 =?iso-8859-1?Q?C5RDKYRBcoXWtd2V7G+m/agRk+VpwhJaxrng9pBAbcvzoN64TWAAej0E/5?=
 =?iso-8859-1?Q?ftDTt45fUJ65aBGBlv540CJpIdFeS/ZfDYHgOjgqdvuCt2EFGkj34GC9/s?=
 =?iso-8859-1?Q?U2VtTAeWnGqbpAlxXmFOFSD+YTZkp0oB03snDxpYhy2iVCfztsy180IdJc?=
 =?iso-8859-1?Q?ADvXa2FdkE09Wvp+TA6Sr+pI6O3+3+TZfq6tKaLJeQ7ei5yd9FNiVUM3aY?=
 =?iso-8859-1?Q?ZxGoYkUXhz2IA/r04SqbLgimu0sQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Co6ar7NwFDOgWyr0ftIVU3P00YnV3hrC8ukIwcKPcqMWzBKOchBGEJDOrO?=
 =?iso-8859-1?Q?FsOH7v6PMKK7DQwOYe4XuefCABsJAWA5PpsuHwuG8B0WuuGnmSqiTEb0kj?=
 =?iso-8859-1?Q?luS7JFnQGMxRgN3TLevcbybGK/2uVt6g7Tog50y68XoQuoaJFoTucdi3o9?=
 =?iso-8859-1?Q?Omr3cxc3IaUReRcbwYu5mkv8bu6ZKMNAYWXGlYuLWLRDneLEp+WC9O2L67?=
 =?iso-8859-1?Q?3ZDH6kX7nf0kpxI8FPLVYGWh41efrICiRrhAIDpy+k2x3jGc50nIVgfItf?=
 =?iso-8859-1?Q?FUyVGSrOhOTwz0yqz1W/H54OCLtG6DFSLwkbMs7hdNhLXhCyF1CjunIDYX?=
 =?iso-8859-1?Q?ltTxKKsd8xkSFZugykGt8yOwEKGpYZm3uDw0QFI0CfLGGJpJpMYnpo5Hsk?=
 =?iso-8859-1?Q?Z1LrimDNNddRbBHvznNjnP+ewlLT9c6P8V8GoItRdggaP7aAdTsDCUtMX5?=
 =?iso-8859-1?Q?4rjWCAn68ci/c7RzxGKiXBQ6A5e7iB1fYfRO7RI15IpwEQytoOqhrZBWVV?=
 =?iso-8859-1?Q?3zVs3slVR5ZTfRbXlwPF/yDZjpA5d/Xsz0w60Ktkz1hE+5TlnGGifhQo+C?=
 =?iso-8859-1?Q?Q40dtkt3sVpsvp708wMSvYjh6QTO/isbb1FbGgAThikNtuezQ6oc2AkTn4?=
 =?iso-8859-1?Q?qdhrcKE15yBanaJ2550tAJX73AspSXRT/RDFIBlNdvhHKYctJ28HZ85s4R?=
 =?iso-8859-1?Q?pqzkXwZUn0z2nAVy6T8iObs9EVXaqOxZorawmQdzIKcqb5zwqTgzApp/f8?=
 =?iso-8859-1?Q?SMA3yKDEpFYpASufo5jdf2dc26izR4GIRdv7tUB2e6NEhxVe8UswzOl4kb?=
 =?iso-8859-1?Q?j/VPTLykfWPMFwXvcs6p0vH7ZHheFDNdoUhgKHSr1Es48Uk34bnMjGHN3J?=
 =?iso-8859-1?Q?nGLDbSRSpwrSl3u8eOGqWe2L+ZbCXbe79rz/pnGFLmMiff4Jz74QYCa/Qd?=
 =?iso-8859-1?Q?DYX9v3QPKMG/BnoK9RvHHMID+19Bd8p7bafmIriWDelBfQkscDLxY+twFn?=
 =?iso-8859-1?Q?HcJWOIQj//FNNgHX1i7j3u62iRyQS+3Z5p7hjphaTCekQuhYlvdvYoYmZ3?=
 =?iso-8859-1?Q?6CefRxq6sLgZptcpB4P9GGjC7CYcFuIyiXHqUWafqyzBx4W3eztVypuM+q?=
 =?iso-8859-1?Q?nmPBM4PBDfiHB7hbU/Ze97UpiI3b8qA0yECEnNz3mz+m5fKDWY3ZAoyqsW?=
 =?iso-8859-1?Q?W/2POlDOA6jjTm6jOFwDQIU7jGqhv+swRfXtEL2jWQEnL32kvCJPJvKAhY?=
 =?iso-8859-1?Q?m2st8Ii5MzSUIXzD+L7Gmg8OK4zY6Yds1Tt33QI+Au95Ypp8l6q0/Rva1B?=
 =?iso-8859-1?Q?+nY724BWRxYZ218dk07JtlGQe0rg6xJIeVFJdtDn4Uc6Fp68pkL4KBjUZ1?=
 =?iso-8859-1?Q?YZVRqCweTRgXMoM+GLEZ4S2dYHx+U2Ofg4wx8DDcE0d+L7+yoIAgWZzBR/?=
 =?iso-8859-1?Q?hI7sCsFDdnDjU+E17946SZt4HvZ9hl3c1OGAEyUv2Yqd8U7UHsjEqK9SWy?=
 =?iso-8859-1?Q?A3svktdqjByeOR7wPIOdqPjklGUYhV2bGAx6f46Sv7zzd4DggHS+IDw+GT?=
 =?iso-8859-1?Q?qunmJ3SUOK4wIeM2xgbAEW2jD/g8IJw1GecLthgYD71xeCYhV6h+syElnz?=
 =?iso-8859-1?Q?p3FCTr3lrb87txMvsNm6g0rpG4NuJUEZfy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CFF289CADCBD7643AA27C5EE6AC700F5@VaisalaWorks.onmicrosoft.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d387ff1-97c5-45a0-6850-08de3d2e73bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 05:38:05.2645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xl/pJdX/c4pGQ+cNUKD52eW9TGrD9wPtTfSzVDe6ImPe7TBDAhl2mGzaY+ScBB2ynOojO0tltvgu/b0ZeX/zww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6387

Hi,=0A=
=0A=
On 16/12/2025 23:27, David Lechner wrote:=0A=
> On 12/16/25 9:39 AM, Tomas Melin wrote:=0A=
>> Hi,=0A=
>>=0A=
>> On 16/12/2025 14:56, Nuno S=E1 wrote:=0A=
>>> On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:=0A=
>>>> Not all users can or want to use the device with an iio-backend.=0A=
>>>> For these users, let the driver work in standalone mode, not coupled=
=0A=
>>>> to the backend or the services it provides.=0A=
>>>>=0A=
>>>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>=0A=
>>>> ---=0A=
>>>=0A=
>>> Which users? The only usecases (for all the supported devices) we have =
require=0A=
>>> the FPGA backend. So do you have a specific usecase for a specific devi=
ce? If so, I would=0A=
>>> prefer an explicit boolean in the chip_info struture for the device(s) =
we know this=0A=
>>> can happen (unless you have a usecase for all :)).=0A=
>>=0A=
>> This is generically for all the devices supported by the ad9467, not=0A=
>> only a specific device. So it's about how this is used as part of the=0A=
>> design.=0A=
>>=0A=
>> This is aimed at users that do not use the ADI HDL reference backend=0A=
>> with these devices, but instead have custom backends suited for their=0A=
>> own needs.=0A=
> =0A=
> If you have your own backend, why would it not use the IIO backend=0A=
> framework?=0A=
> =0A=
> I can understand if this custom backend sends the data somewhere else=0A=
> besides an IIO buffer and we don't want to create the buffer for the IIO=
=0A=
> device. But I would still think that there needs to be some sort of=0A=
> communication between the IIO device and the backend.=0A=
=0A=
True, there needs to some kind of backend, but they don't all have iio=0A=
backends or other kernel drivers. Data will flow when the device starts=0A=
sending without much further need to configure. Adding a backend driver=0A=
in these cases could have some benefits, but often it would just be an=0A=
unneeded complication.=0A=
=0A=
And even if there were a custom iio-backend available, it would not be=0A=
compatible with the current assumptions about ADI backend wrt=0A=
calibration, test mode enabling and iio buffering. So having a strict=0A=
dependency on an iio-backend does not really work in a generic use case.=0A=
=0A=
> =0A=
> Maybe you could explain more how this custom backend is intended to work?=
=0A=
=0A=
I hope the explanation above helps. There is real use case behind, this=0A=
is not some imaginary nice to have feature. Before the introduction of=0A=
the iio backend, the driver was even more dependent on the backend. At=0A=
that point, needed to carry some out of tree patches to remove the=0A=
dependency and make it a standalone iio driver. Thankfully with the=0A=
introduction of the iio-backend, this is now more loosely coupled and I=0A=
see opportunity for making this standalone mode possible also in mainline.=
=0A=
=0A=
Thanks,=0A=
Tomas=0A=
=0A=
> =0A=
>> In that case, we need to be able to skip the backend registration and=0A=
>> register device as a standalone iio device.=0A=
>>=0A=
>> Hopefully this made the use case clearer?=0A=
>>=0A=
>> Thanks,=0A=
>> Tomas=0A=
>>=0A=
>>=0A=
>>>=0A=
>>> - Nuno S=E1=0A=
>>>=0A=
>>=0A=
> =0A=
=0A=

