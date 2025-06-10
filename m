Return-Path: <linux-iio+bounces-20362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D74AD3B8A
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D603165E80
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1424246BAF;
	Tue, 10 Jun 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="cZPKLqVx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8B19A2A3;
	Tue, 10 Jun 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566685; cv=fail; b=c0WozgCIptKPdr3E0gIKHQQ6TZ4lM9aIf+HZSXm2BK6CH1MqQww0fT7oCyNTmFsTmJUdAAt26NbCKCdIyHjw/wT8dQmCFhxwydRWBotGyoyx4qBsj2mAXFszf98aIQAXKseCCsqv3N7VWbRolJXPm6osPz38Rm7n1dNlcNvusaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566685; c=relaxed/simple;
	bh=6LfxSUML9beU4uwF+W6dd9vo3ph6xtzv68cdW8yE+G0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aAIrc609JtipI+kx+e8SxRrfNWCEc+BYzRcUCzUB50NBPvbO3X2NJbokDST707BFgnRVqEacNg+zVs7kqOtKfrlRSswAPH5ILCKMIT9SFg5fGRNiFkUoVRi7HHw4/HiBO0hcTE5Fd/VHVu9rmy8rUoZY9j3odA57ocoP/BORg9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=cZPKLqVx; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559LcjLs005179;
	Tue, 10 Jun 2025 14:18:56 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010012.outbound.protection.outlook.com [52.101.169.12])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 474bt3280c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 14:18:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pS2F/pkuTNmJEhetkrw+QqwBEdvXpUqFZT5xeOVWQ+XDdNKWmiWxvj6xMLI1jkL7//o+HVjsE78hBY1u/oaV0iYK5X4+qyiHXVgr3AmsT3RAltAh/4xLiaQLRs9pK0mRR/ksPbZpI8bcLvPfm79o7+tGElKTayn+bMecb2mup2R7bO4gGQrVoiLNLEWe2Sp3I8kVOIr77AAjEtqkl9IzHNCwbub7Uar/lNE+AE6v18WcsuPJw/fETLGoIZYQO9c0aNTWKR1EywG1vmtVAlb1Krx2B3YrIXw54rMV2/ykOpP9Aj8AcDsgEXB0Z1fwaV4VsbvSSXpYUv7TbIIs3K0ipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RWdi0z7HBRNTxUmiZwupKrduSu9NhykTZ6phDgtaR8=;
 b=fX3zaLlml6kujdMMzWhS8mTQbKEFihTEDDMcIQg/Az13koG2/5n7IhRWp3L+PfcYJb0qAAU6v+mUtQH9K+ZGUHT3WLdd4BJIZQ3AW3GRKhhJrqqThyilwCDroePB08qRXxz2hN0dAL/j3oHd4G2fosTsh/+Oi73bRIZxiB8n9J9GZv88Mxe1xoixuhbaVs1xoCPrSlwZIg16dW5obTXmFf0ymctFJM2K8sokFTucmbNejrtp2o2ZNK8VP/4ZHe+jqNFLvoolCLrm1nESxVXFXdLYCnmzDpLPi+GRRF+PNR7KQ57IrKGV3FU9QCZdl9Kd4I3kH9WygGfazlRGs+tc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RWdi0z7HBRNTxUmiZwupKrduSu9NhykTZ6phDgtaR8=;
 b=cZPKLqVxbNLEEx2kuCTdQCHusynrHe9JNVFubSLF51dMe28Buaerj4DD3VQb+E/6DgGTdFTOAn8+sEwMzGRjR/wQmHCCetVnXqTAQ2hDUyFCfWtliOmpCfdKlGeWjfDIiEndWRjnzHKYM3hr60X1G7eqzm15Egyav6dnpwMtRKoNYGXaeWhHQXzvDEAYX/o2vgGwo4i5Q3jVBRFSTOXzE8vEK/V8vk19PoiVFuOQBcX8Vp5Tfv95uJhtq3VG39vc/MbkT9NnROduoaKKyiHq1MS5hvhye48HBE7t/gKKB5UpneNuPrj2wlfDEyRV2TXePLvwjhsWSnYM9pxYXzEjdQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.18; Tue, 10 Jun 2025 14:18:52 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 14:18:52 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner
	<dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Topic: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Index: AQHbsH2o0EUo+C/wbEygXsbiYpM8dLOt9PwAgE7N0aE=
Date: Tue, 10 Jun 2025 14:18:52 +0000
Message-ID:
 <FR3P281MB1757A06D0F591758F066DB89CE6AA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com>
	<20250418-losd-3-inv-icm42600-add-wom-support-v3-1-7a180af02bfe@tdk.com>
 <20250421114858.72a726c9@jic23-huawei>
In-Reply-To: <20250421114858.72a726c9@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB0012:EE_
x-ms-office365-filtering-correlation-id: f977fdc3-c4b9-4dc9-250a-08dda829b9eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?JEw3QsShU1EmtnmUx92Ex4qfjCs8DGnMlDV8kQGxkc82QCgUDAuGIT+bQv?=
 =?iso-8859-1?Q?H8FZ/LluNzgznFd1Nq17FEFqsWLmvqUpcQUJipzdV3FMio3woP5XarlOcF?=
 =?iso-8859-1?Q?d6yCrMBEHiRay8RKl6/SEFgJz/lIZODMYcp81Y1kvSGmCqMX7XzZOrU3NR?=
 =?iso-8859-1?Q?NZBAAcTXO82gMBLiYunmCqwjoWhTyjVJL279t2iVdJ5yrwLoZPYfvppjK8?=
 =?iso-8859-1?Q?EjsltZLqdYFLaMN5DEExBQiTA1k6ebAj/luwnoRkUXz1vGVBCEyjUoVXKt?=
 =?iso-8859-1?Q?xCHyY2PhzQW5Xtf0QJAMSEPTfeRVf92GFVS27cIZhtVr9Y2TLmGhnCHanR?=
 =?iso-8859-1?Q?Ah9KE6GlKl5PEKaJMGX7Uuw10+8vXP1QYGcqsvomTG1ODuSEFrdAO3gfBy?=
 =?iso-8859-1?Q?HiNcC0cRWAxj5HLazMvIjlxXri0UQPZ0tltfARYJgfhxBI/7IszKWLjDYC?=
 =?iso-8859-1?Q?ee4bQVou2463jLR2VH6S6sXxCUy80d3Han/Vb2BpJre55fCqEC6bBD5kiX?=
 =?iso-8859-1?Q?I+yY9lv/Y3M5TuZZhsTdgJqcE1IFhU3cnWNOloT3fIdHaDnlRb1TfpwjpT?=
 =?iso-8859-1?Q?sbypnV5Y4fL9yFtFyQyIIb1uwGAYlxMDpH5r5FSAkfXYkWwNFwE/rfF+Ti?=
 =?iso-8859-1?Q?oO6sjTt6GtIo49Mwh5JVYrGeh/et3x1PsvVxCDHwm4yxgmuSzNfyvQLtlO?=
 =?iso-8859-1?Q?pFKXmxjIcmUEic1ZVTsyK1gME+z59I6Hw64eCbFYhHXSJHoo4gOSmGmA9o?=
 =?iso-8859-1?Q?wVignxmdAzyOU079SX8m6sJ1Pznw/9L+UJQW2xBcCgpH55R91cO/LuL22j?=
 =?iso-8859-1?Q?JVqlBCgo7KIIdQZyYPio6krxj/q2aqg5EKsiF8w8FH7/oX1FgxXujSFHVl?=
 =?iso-8859-1?Q?Xxx6VX5gzadhY+1tqp5fHhcFBClj+T1/tU8i0aYHbyPVq9YlbXQqdwEIIS?=
 =?iso-8859-1?Q?QvbmCq8hKi/Q5nE/cQLbAW7rprwWEZLNwpA6h8Bpsw9/nEjQviW4U1wFmR?=
 =?iso-8859-1?Q?LkwtPsMCWkJcrMH9i7xc/64aEzcuPMb5CFowx9TywQr1Mk9fXS6zzIhxwy?=
 =?iso-8859-1?Q?EsgNt4f0au9mWiVnFWfSI6s6+9oEHcdBhto+I15HWhvRr0cBeKOU7wLrZe?=
 =?iso-8859-1?Q?Zud/4q7c1CT4lVI4OkoyjGmdD/Lj6130BONC75H2wPWm0UVLqVNVsDx4/k?=
 =?iso-8859-1?Q?98Hk7rvL9yWcmncvMjSh0BwrOTxpNE98Cbgh7KDR9Y/N9nsehAEyd2A3JX?=
 =?iso-8859-1?Q?PQVHLIjoiU/g+h0EbWFz7uyMpqDR4QmDKzyDB8GVcxrcos+O4SB6S3vtRp?=
 =?iso-8859-1?Q?bRzXJwpei3dXgPpkKt6cpAXBhbVt0erpGWf5RtvGXjyV92xpt6e1uXZW2o?=
 =?iso-8859-1?Q?ntk3ZOfAoff9EtXfLYGynuomfOxOCq96iTOU4OE/FHmAVu5A2mNwnoQ318?=
 =?iso-8859-1?Q?syGk0MkXsHmwjnEFNy9gGthnfkZuirXezzorkdz6tqsVBkWF5p8tNNVuLS?=
 =?iso-8859-1?Q?+ErjU10TIBAReEu3zX2rPisUv4nNx8bLPkHsyC9eaU2BRsHO4u6cEKdpvM?=
 =?iso-8859-1?Q?9VD9e0Wtif5IiCyKFFjtbrmXkthN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5jBUNEsHvjc9eFy0xQs8N8NaJV5tjO0/amrJzqTrNGkyarDnB6fXxcs7zK?=
 =?iso-8859-1?Q?doODmMWVrXiLqhnToR32EIjXC36Yv84gaJ0asfBYdIKnl7htgyT+AnobkQ?=
 =?iso-8859-1?Q?1arJOkjaA/S4MAODyXWt9l/s4w3DsykvsoF79+ESYixyZ2OHEGl0qJ2JY5?=
 =?iso-8859-1?Q?YF3yFnjwDb5kT49gdjjI1ZUrXQsEU9J/v3fAH7/cA/0qCPRKro78QQBYM9?=
 =?iso-8859-1?Q?ggg9zXBYGUDyo73A08k1+zPLBTmJTIVRgm+FhIGLH/UaVH4YyEEcKC8GPm?=
 =?iso-8859-1?Q?2SSF58mWQBtcyzRobJs9dixZQrwa9h5zsXKDs6iXHr1lujoMOG3ZAmhEq5?=
 =?iso-8859-1?Q?9OrIgPKoGOxXw4wkcFFJyPaxUoC3ryBkbd6MpgDOZVV2LgqKXhtNVT9DH7?=
 =?iso-8859-1?Q?ki+0DQkgDcM5Dq9Qmh5WokToN0P65SEczpOVTiEQR+rmaaPRYMLyrNOpAH?=
 =?iso-8859-1?Q?ASlRkYKDz8BFLaWK3YXgYTmgSLbcq4/eQdWIhU22BG2RcbAVsAg13BW9Sm?=
 =?iso-8859-1?Q?AMUYb/wNDMpk9Y/E7lmk65TmoWtki7Vadj66k6Dkd3sIXnQ7C+Glg22mkf?=
 =?iso-8859-1?Q?vwfVlFUveEl0JZXzDPbQF+wIanY6+rLobWTYvaihMEbCuJFVZme6eeGXg2?=
 =?iso-8859-1?Q?ab8e8wayhwEFzpSPX2jxt6FSYiG/tqnKo2OY6lUKxMwK+h9Jn+Mrf/BHZm?=
 =?iso-8859-1?Q?t/1LJ2uDWNBgAq0lUWg1XZLflyGfkHySc6RA2WejVdwy8h+RuDkouxqEu3?=
 =?iso-8859-1?Q?YEeDvNsDEeMlS/KXMw7vmdztmhkqpuLvrbi6KqO4SagTxf14AnKt0qoPsl?=
 =?iso-8859-1?Q?+JUw8hw6H+AGEpmo9N86vSMb5A3axCvq8yOHJE8KZfKQ7WG/wtCyzCW1/3?=
 =?iso-8859-1?Q?R7bNgwmzbyNnvAh3CS3KwXMWDuaEncxsC+W6wt2Ia9lIVJ5V3XiiXngKgO?=
 =?iso-8859-1?Q?GCoDfZwzkDSDghsxPu4Acuc1awIHXPbyA0iP5NU5Sab8ZOSGedX9to1Vdf?=
 =?iso-8859-1?Q?BLI0uP1sjmqu2IO6goRH1Klxv3LYNvhdIR52C0EpYxlJwRq0W+3Gg2kPQX?=
 =?iso-8859-1?Q?F5fznk2jJQj5T9JHfYs7Dm1tUIq2ND73IK3FgsVGy69bYjlJB776zeYpOd?=
 =?iso-8859-1?Q?psq1Y+iyeItn8YdgY3y/JsLvKpVanjBJW1HcHDWXx8p3ELZsChs8kC0hcf?=
 =?iso-8859-1?Q?WwTYPyCkp8zNKUf6AVp8kAJSywqGMQEBmLdpKi2HEtp4Vl9D3OhKW/sdFA?=
 =?iso-8859-1?Q?XlVoZMLpLrDvK7oJe7HxKJFQzVC87lNt1FyXIFepNE8tP6XGlUKSr2tNah?=
 =?iso-8859-1?Q?EOOYC2Tz8fnWRm8eRnFz1pxbybPk4uiXdKGd+ewvxHh8XDyOELA1uzYbO5?=
 =?iso-8859-1?Q?D5DHTv4/GP0TUy/XBIPeKFsEGcnht3CtsI4EcSL/MTAFG8L20gECLAmIqk?=
 =?iso-8859-1?Q?0C0CL/N/pHLiaMj9HpJViss2Y7aQwJThit1uZpqTrPVZDgb/nUei6VHN3q?=
 =?iso-8859-1?Q?TgT9Jl4Soq1fl5WBpqfk3sWQOu/jBGZayVaSqzSoh6OIAz3yJa+znZXInC?=
 =?iso-8859-1?Q?YZe3Z2hqbVUct/+6PV9fV7ZDg4OtjeNMAR9Ql4T+h6KwhAzPClZsRTF3nk?=
 =?iso-8859-1?Q?e6S4tfKvgAwlXdJk4c18jx7C0yP0N4nhMIDxHpkmsns0PnV3XSV3ambhjY?=
 =?iso-8859-1?Q?MR79llF+Ofy0JpXYFqRz4ROv8CQgTsNFGt0SqX3M1INm4NIrS6T18qwYI1?=
 =?iso-8859-1?Q?JArQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f977fdc3-c4b9-4dc9-250a-08dda829b9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 14:18:52.2639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1o3el5W+SJSs6uWVJFPvJ4ARqoa//xFimKoU6Vs9j292wysUp/vrTnYsfWaP3LAWKsAGi5y/BTjgun3Gnt3FjLjpKDt2R4JkcDxhBTIm2t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0012
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExMiBTYWx0ZWRfX7ucReJZ4UFIH
 qnumnNl6QDSkZFwT3Sa1nOrsVCPe/p0GKa9Id9P+CvN/qiWkeZ9C44Bi4wVakvKdObVC9sBjDCF
 Ktd+SyZAEySEvVgd0ESypzoiLuvaLZyJY9XRrM+Ow36GR0mTwsMDLRBZxxJPwFvPwOJBHaCvwop
 mNFxs7M48H8QAl6esUg9zLVRdOgDmati/BlmQQ/Vuyzgx8H8zM8xQX8g3gwgypYf63SKYvG6V3/
 pwe0FnINFZ6spzV2woreKeFiWqdq7mxqK26ZoxyvzKFfC9FVobhBwB0aS0o96gUces+fV1rOJV7
 fu1ZBGWTSJjXwABOHfnsWjv1Tk0f+rA8PX7wUKcdYzB1bskhI7A+2M2aJi87PerQTSRlYWtkYUB
 S7230Mca1Yd8ilGfODa9Hc+TweylBWSESdqnqPl35RZuSZmtYqryC8/V0TbLOVnIlZ0tof3h
X-Proofpoint-GUID: SeEEVv0JXU3fqECMSJaICXvarUDQzV90
X-Authority-Analysis: v=2.4 cv=Fas3xI+6 c=1 sm=1 tr=0 ts=68483ed0 cx=c_pps
 a=CdQbbTpX32uztjO2l8KuTA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=PnaujPPS9STJQx54qOoA:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: SeEEVv0JXU3fqECMSJaICXvarUDQzV90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100112

Hello Jonathan,=0A=
=0A=
sorry for the very late response, here are my answers.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
>________________________________________=0A=
>From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
>Sent:=A0Monday, April 21, 2025 12:48=0A=
>To:=A0Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.=
tdk.com@kernel.org>=0A=
>Cc:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-Peter =
Clausen <lars@metafoo.de>; David Lechner <dlechner@baylibre.com>; Nuno S=E1=
 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; linux-iio@vger.ke=
rnel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>=0A=
>Subject:=A0Re: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Fri, 18 Apr 2025 18:19:02 +0200=0A=
>Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.co=
m@kernel.org> wrote:=0A=
>=0A=
>> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
>> =0A=
>> Add WoM as accel roc rising x|y|z event.=0A=
>> =0A=
>> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=
=0A=
>Hi Jean-Baptiste,=0A=
>=0A=
>One thing on mixing gotos and scoped_guard().  It might be fine but we've=
=0A=
>had weird issues with compilers and this stuff + the guidance in cleanup.h=
=0A=
>suggests not mixing the two approaches.=0A=
>=0A=
>Easy enough to sort out here with a helper function and I think the=0A=
>end result will both avoid that issue and be easier to read.=0A=
>=0A=
>Jonathan=0A=
>=0A=
>> ---=0A=
>>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  54 +++-=0A=
>>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 279 ++++++++++++++=
++++++-=0A=
>>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-=0A=
>>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  58 +++++=0A=
>>  4 files changed, 385 insertions(+), 8 deletions(-)=0A=
>> =0A=
>> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/i=
mu/inv_icm42600/inv_icm42600.h=0A=
>> index f893dbe6996506a33eb5d3be47e6765a923665c9..bcf588a048836f909c26908f=
0677833303a94ef9 100644=0A=
>> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
>> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
>> @@ -135,6 +135,14 @@ struct inv_icm42600_suspended {=0A=
>>  	bool temp;=0A=
>>  };=0A=
>>  =0A=
>> +struct inv_icm42600_apex {=0A=
>> +	unsigned int on;=0A=
>> +	struct {=0A=
>> +		uint64_t value;=0A=
>> +		bool enable;=0A=
>> +	} wom;=0A=
>> +};=0A=
>> +=0A=
>>  /**=0A=
>>   *  struct inv_icm42600_state - driver state variables=0A=
>>   *  @lock:		lock for serializing multiple registers access.=0A=
>> @@ -148,9 +156,10 @@ struct inv_icm42600_suspended {=0A=
>>   *  @suspended:		suspended sensors configuration.=0A=
>>   *  @indio_gyro:	gyroscope IIO device.=0A=
>>   *  @indio_accel:	accelerometer IIO device.=0A=
>> - *  @buffer:		data transfer buffer aligned for DMA.=0A=
>> - *  @fifo:		FIFO management structure.=0A=
>>   *  @timestamp:		interrupt timestamps.=0A=
>> + *  @apex:		APEX features management.=0A=
>=0A=
>Maybe give a little more info on what APEX is somewhere?=0A=
=0A=
No problem, it stands for Advanced Pedometer and Event detection. It is a s=
mall=0A=
compute core that runs algo like pedometer, gestures, ...=0A=
=0A=
>=0A=
>=0A=
>=0A=
>> +static int inv_icm42600_accel_enable_wom(struct iio_dev *indio_dev)=0A=
>> +{=0A=
>> +	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);=
=0A=
>> +	struct inv_icm42600_sensor_state *accel_st =3D iio_priv(indio_dev);=0A=
>> +	struct device *pdev =3D regmap_get_device(st->map);=0A=
>> +	struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSOR_CONF_INIT=
;=0A=
>> +	unsigned int sleep_ms =3D 0;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	ret =3D pm_runtime_resume_and_get(pdev);=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
>> +=0A=
>> +	scoped_guard(mutex, &st->lock) {=0A=
>> +		/* turn on accel sensor */=0A=
>> +		conf.mode =3D accel_st->power_mode;=0A=
>> +		conf.filter =3D accel_st->filter;=0A=
>> +		ret =3D inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);=0A=
>> +		if (ret)=0A=
>> +			goto error_suspend;=0A=
>=0A=
>As below.  Compilers are not great at the more complex scope vs goto stuff=
.=0A=
>This one may be fine buf in general we avoid it.=0A=
=0A=
Will fix it.=0A=
=0A=
>=0A=
>> +	}=0A=
>> +=0A=
>> +	if (sleep_ms)=0A=
>> +		msleep(sleep_ms);=0A=
>> +=0A=
>> +	scoped_guard(mutex, &st->lock) {=0A=
>> +		ret =3D inv_icm42600_enable_wom(st);=0A=
>> +		if (ret)=0A=
>> +			goto error_suspend;=0A=
>=0A=
>This doesn't follow the guidance in cleanup.h about never mixing gotos and=
=0A=
>scoped cleanup. Two options here, either factor out everthing after the=0A=
>pm handling and have=0A=
=0A=
Will change it.=0A=
=0A=
>	ret =3D pm_runtime_resume_and_get(pdev);=0A=
>	if (ret)=0A=
>		return ret;=0A=
>=0A=
>	ret =3D __inv_icm62600_accel_enabled_wom();=0A=
>	if (ret) {=0A=
>		pm_runtime_mark_last_busy(pdev);=0A=
>		pm_runtime_put_autosuspend(pdev)'=0A=
>		return ret;=0A=
>	}=0A=
>=0A=
>	return 0;=0A=
>=0A=
>The rest of the cases are fine.=0A=
>=0A=
>> +		st->apex.on++;=0A=
>> +		st->apex.wom.enable =3D true;=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +=0A=
>> +error_suspend:=0A=
>> +	pm_runtime_mark_last_busy(pdev);=0A=
>> +	pm_runtime_put_autosuspend(pdev);=0A=
>> +	return ret;=0A=
>> +}=0A=
>=0A=
>=0A=
>=

