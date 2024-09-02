Return-Path: <linux-iio+bounces-8961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB0D9683C7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8121C22797
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B8344C76;
	Mon,  2 Sep 2024 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="NQKOo/QQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324A1D3184;
	Mon,  2 Sep 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270878; cv=fail; b=UV6S3apmIjfuZwESw5ZeWEv1c0Qk5AwfV28at6dYTH6IjEqARmKR4beQbImk+nvNp9Zs9mROV+bEl5QKuRraklW3HU+nUd53rDYDTEd7n9Cq4dSOt8l4ruHDF8GUulcbUq2fQrscYf328sSJX/zcXWVv3LOVWcjKFNr1qMnV1DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270878; c=relaxed/simple;
	bh=0g4k0pel7lxMVsMAP2L4FcsWvSsAvwIGjnnpjxwWfIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZkV4RH/Ux34ruEQSc15JdyVdKO9JC7QIu0Wb8wX/IbEuurvBlcLek3CwhLnssqQH5wfwK9k1IeMnASoAXemX8+mxSg+UPXa8gH3cIV42x0pR3vVzZx4plffyue8ry4VvcJ2hwDU8vQGpT4SAis2quB7avYcRqlFziM221HKt4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=NQKOo/QQ; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 481NQ0df015092;
	Mon, 2 Sep 2024 09:54:19 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazlp17012048.outbound.protection.outlook.com [40.93.78.48])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41bvhk14gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Sep 2024 09:54:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRZsCzOrOLh1iMtlBpJ7UbH503bkx8r/cUNy7XFsNP/er/lUrM7U8rP+hFswzJiatwf9zPB6UmDu3tO7Aamz70xb7707uB7MsdsZba9mrohIbcyGe2f0IuU0f/ickeWFHrGhYeBbj1X0JL1ciw2P11ULZHD/yYPPD0QLrWvZ3RrX/KiOP9KVRak69Er4zmDZPI8rNnDNkbe//9pssqgSqyv2ba7gad4F0hG8D3eiotFHOk7y5+cQ1SKr95iy3+X2IL5GnVO9oJ/N+glDDQ1lgz1PUZQ04infXecj0iqnvz9s4wFLqUPHfF9AtjgxQrRxQ2ZE5zyEi8+rZ/WB85n38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g4k0pel7lxMVsMAP2L4FcsWvSsAvwIGjnnpjxwWfIQ=;
 b=RE9u0QEQnqtYvlLRsQ12KZsTr1oXiKxXAjS1JavpXVvoptJJOeqg0QmTHitBONJHal0ShyxrDgqf5Q9CdNfIrEAh+l/qyu/r0rEphVMHGb+Rb2cZVYzzwcwri6rCISUm2fKwLGjaN4PbV6CCFw/MGmxPRXScJGHm/S7lMDXpUF9fWNjqdO8DIVF5hXx6RYjvUCINEfk9yZ8e3RNDhA/PgimeR7Q2Fd4X2LxWlfWgS4RD/1qRsbIBFaAEVvKzidpP+AytHcFaxdE29hSjxCQAaee4lTLCgxEdVdv8pHtHZblltQVhk6R8hfwz0Jw7mCORIFEeYMyo0C7k9JSzay3CKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g4k0pel7lxMVsMAP2L4FcsWvSsAvwIGjnnpjxwWfIQ=;
 b=NQKOo/QQb8Hp5xeJVrClZUWvLgB6fcQZvUypVO2sGNBkHreaAitVQ1X5gVB0yCalWp2d+nGoFOA3D7z6TvIoR7uXoIC8HqUdYkjsm6WLNzqIKad7fIqJLWrRwxB0HUjUymLH5notpwEY3q0opUTifywJRbXIW1Qjypx4jJ/zDoRAuwKHYOUDuAyxy0T+AK8Vs19fOqzHEy2R1sf2UtFSSMqpFuruR2+ckPDZiOznSk0SKovbvXQoEbQ58Qf9Ch+zjNjTtg4gc9G7SpFR/+oB77Oa48ZCdJaI8GZzSj5wAWufhHwv+cNiEyeMGe0g9E88ZpRXYIjx4hxH45ndWgyrDQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR3P281MB2973.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 09:54:14 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 09:54:14 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Markus Elfring <Markus.Elfring@web.de>, Gyeyoung Baek <gye976@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: iio: imu: inv_mpu6050: Remove duplicate code between labels
Thread-Topic: iio: imu: inv_mpu6050: Remove duplicate code between labels
Thread-Index: AQHa/Js2bVPz5JbY30SJnAB17cgd3rJDvlOAgABDXgCAAECZtg==
Date: Mon, 2 Sep 2024 09:54:14 +0000
Message-ID:
 <FR3P281MB175727DBF709CA59B1064C68CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240901091214.15199-1-gye976@gmail.com>
 <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
 <CAKbEznv-TmCr2FAodrM2SKK5A5pbV9p5-OvXPdmuk_4xXmh=Rw@mail.gmail.com>
 <7b827ee0-9116-4e8c-96e1-1fa5f7267f33@web.de>
 <CAKbEznu=+Bkw4kmoo7qG9h2wM=2XV54j_SYzHMAH1uWhtUPCvg@mail.gmail.com>
 <3c60e167-7815-49c8-89f1-fe1139879d6b@web.de>
In-Reply-To: <3c60e167-7815-49c8-89f1-fe1139879d6b@web.de>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR3P281MB2973:EE_
x-ms-office365-filtering-correlation-id: 55d6d24b-fdb3-4f60-e3a4-08dccb3533e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?qMb9F3dV3LCMqXLjYc8tFk0lMa2E/S2fS8Hrv3XzMCgTtC5x4fxcDrop?=
 =?Windows-1252?Q?tYXErikg6amHinyNG6xW2kcbH1zRB0VxqQkbKVa18b7n2QBkMps27hSt?=
 =?Windows-1252?Q?pEKVNpFsVOGY1IpR+LVwTlRtRfLGe3vweS920/NaJ9pKLVLnVclxsSCY?=
 =?Windows-1252?Q?NgnKR6VQGb0TzAV1hGAKr6LyGbX3WOeZUviGZCiKGzgVfjo8DllwuQ7D?=
 =?Windows-1252?Q?W8zuDNQJ1S/+xyF3sk0XkhShhFy1XKTmYFI/ZKovH6FjuRJm+9sQWzbL?=
 =?Windows-1252?Q?vvLmCKI3E256a1kkgxXPKLB84ypDdP+xb+AK6FBqo4+vXNktKxfwNjEt?=
 =?Windows-1252?Q?jv5Ld4RA/jZZPyO/eVjkqC/uzXMaoSpdjezcSeNFln98w/WP0KtVSrEl?=
 =?Windows-1252?Q?gy+0U+she6BXJGXdAkM2S9TsCKzq1FcJ/PHDsEX6zMnRK7vNBemPQgQg?=
 =?Windows-1252?Q?uc8I2mGWN4qbGf9cwerFFG3Emy07WJoh/uIurQeYw8BZq0NcNSA3jue2?=
 =?Windows-1252?Q?a4kNetZWYYMDnF5sfqqxyNn+1Ix6nY2lIkZT3RHB78Hyv60X8C6Gq0jO?=
 =?Windows-1252?Q?Z5vvItcx3ckBU8dy7IZEIgom4xH3fWVhyvg4YkvKYwPbqhBE7mg921L5?=
 =?Windows-1252?Q?Hd92RCAveFTXQG50xYtf4BTZ9AjkKORAen7XyodrR+F+cQxVTyTgIfU1?=
 =?Windows-1252?Q?jXj5zjUO+S6Emy/qOAjT89IKDE7AaaFJ7GRh4bdhs3GnXBtag/Nt/vCC?=
 =?Windows-1252?Q?kYSl8UYy2+cDqrFx9qujx3IncBVGQJWE2V8RY6Ph/HUwd0c/RpiCAxVh?=
 =?Windows-1252?Q?IqUEuwrJsEQTsPSP9me1ov9kWjgXQLfMhbhPKZPtX1U/8yzYcYMzHzXd?=
 =?Windows-1252?Q?NRyfSHPJci1KzFs9fpsU19RTYBlHHBF9EVhWWR6wP/rr/ENyH4NkZC/c?=
 =?Windows-1252?Q?bwag6dGejsHuTL3YPpRknoM18xjnAKPipWATHJ01Pjvx8YYVfl7gwiog?=
 =?Windows-1252?Q?3KgSFb370Sx/szE3QJEWYV8kdrDTe6GjekLtmwcTA3Ycos8FoTcDZxOU?=
 =?Windows-1252?Q?TsI6Rq3Tz+4GjlPwEqoINVUi99vGFLC29jXdNdM8KfXBwbOeIe7va5+q?=
 =?Windows-1252?Q?W5LENQC3WH4r0lYOHZYLuKYMjwXr5E8hFotKIzNp+SmL5flF5GsmU+c0?=
 =?Windows-1252?Q?RfB5bLeXQuUm79977FULNRNVa202HyibiP776UYyhU5spoQ9ZHGhowkn?=
 =?Windows-1252?Q?kP2caQMR7Mdtnx3AzmKPihTXj/+DSeGb9KUPwBzrrlVcP0YuR28P5ihZ?=
 =?Windows-1252?Q?3tAywJM5JJza5ocijIEKF7ovI7JO4vibawHz2FiuTjPQuqH8kgsh98hw?=
 =?Windows-1252?Q?YfsUJg37b65btVSAE2t4mURhf3Mu2oD1+7Nr4J1cVDWxF7FnbImKeUnJ?=
 =?Windows-1252?Q?J2AlI2qihtai5Bmk71n58OqqebdjvmMx0c4n3iCfTYNAmEXFyfJ34/4L?=
 =?Windows-1252?Q?LcP2w9hRsYMVQ4OMpvmXAfmKZc22xyZ6317Trcki8/TkhnLi0t56Atay?=
 =?Windows-1252?Q?A4WQ/VlDuwtwX12H?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?xwMMwfzuscMuI8cpCuBkM9/Lw6cEtA0G+4taRXYs38wMMwK7hNdIU4oS?=
 =?Windows-1252?Q?RVJPl9ZxD2mBQeW9edqaXG6DTEQS9sQ8EzI6RFjCEr9bEFaE66sb1DO4?=
 =?Windows-1252?Q?8cRzjzszJlUJ/22B8Mud+jO5s+Cpuch2NQvjMzISYfNVPtrUXAhFS7yl?=
 =?Windows-1252?Q?Sr6cfarwEX8OOPTGBaIZp4+V57zakAnnoSGlOS9+jvXvPX3OY8hsmfpm?=
 =?Windows-1252?Q?ezhQsp6Q2scQMF8X3SmYOW2DPed+gn1S6KYplPOC1v+H6Djmh4jmodpL?=
 =?Windows-1252?Q?OerEdSql+GdjXxJBJ0l/4JCiTt1yXaEj0o/EkrMijCKkJoFU4PCuqAeg?=
 =?Windows-1252?Q?JKWwEH6LEytM0Ht8OToq5N4p82HA5nqfWpCkKYNIUICY9n0bHDmffo+o?=
 =?Windows-1252?Q?8R38z1GP7E8MaZ5CGmbHAD4EDuyLxeZxPThYuC3fIV3Gw2dwxLtQHk3H?=
 =?Windows-1252?Q?0qJx0BddmUsRbWdFTc4knNcqCTVuykpWNo+0bkJwbQDtPQpC96rIVZQr?=
 =?Windows-1252?Q?sZaZjFSOfyItHWkcF2HID6jSkCNsqDmGEYWe0aeeJNfeB4ldh3lTjUUS?=
 =?Windows-1252?Q?KecMCj1PIgzv2bqhdBhM78M9qYg/cpWCqRyHLqhqTmRAm4IbEh9jzBTs?=
 =?Windows-1252?Q?Rva+cqlWJmLTTgvbss6CbmICtTILNGFXo3iidbH23ut21aezM07mToW+?=
 =?Windows-1252?Q?7Is7UpXNvh8WS8dha7nZdNDn6/BIHQVW6DvyfPcq1C443lfzuGL8F6n1?=
 =?Windows-1252?Q?3RhwD27xx2Uthy39/W8229qSP++zfqflhgBvZi2DyMaeeT7Gw9U73cqJ?=
 =?Windows-1252?Q?+DD3gBGZR7iRzbUjzXRaFlY2qXjICsFTFFIbFiYGcbiTrQpzEy400sJn?=
 =?Windows-1252?Q?yCu86RdoqozoP6iI8s9gsnhqpWTyVJFikMqXQE5UAuPZR0lBFaFfWZAr?=
 =?Windows-1252?Q?9fh1n47i/xmv+1zfT3wUy1T9XQi19Y5imOp5UKKJCIruZkxAXOGn1jdq?=
 =?Windows-1252?Q?T/2oi35byFwE3QqX5OsTsUtURRg5XzwN//YxxDWMcVRn3JVJyqHhOg+7?=
 =?Windows-1252?Q?1RdZ+hYBDZiT+ZxLxwhiYmKU2pmcq5To34Fq5pCZAwpuDrCvKEpFKbAO?=
 =?Windows-1252?Q?Em7TuRceSmDZHrqARIojQaJ7ULJISe8x081Q2uSAT5pLgopsL8WoGotU?=
 =?Windows-1252?Q?qZtI7V4Li4IM+u7jGQi/OWgJT+9ffCfwq0okAp7DSLF6JFHCgHv3UrTK?=
 =?Windows-1252?Q?NQzcXrFURC/omy1Y7gdPokcvQc6AM2AOT1KPvwxQgdtOiygPhxdVZXTy?=
 =?Windows-1252?Q?w7Gp694Z0yRydmzlqaGhnd4iyeWL2SU0DTyxGTAyFCTSR5cP/m5UiTG+?=
 =?Windows-1252?Q?udXrlGygtpqtoCHNbheIiMhUU7nxHyuDDsKReHQmzy2dUjPz5IYD3a6v?=
 =?Windows-1252?Q?dYqE1fBbqXfsbCEKiNsQDuUMfO83eSzymVrlcbdCyAs7/5LSqPM0frX4?=
 =?Windows-1252?Q?Yq5kQ6zEUoG+mzCa+d1xbbbxwLEpEKJZBaxx2/5rTeM4zmXkNj79Zejo?=
 =?Windows-1252?Q?DZGozjNAz1YroiqFw9DLKAm32DE/w/QAxiIt+4E7rwqkT8/b4nSoY2SZ?=
 =?Windows-1252?Q?ZZ0tJDV4a4TLg+ij+sx63lF4OrXnabd8fjgLrvMs0dvEY2zTRNMoO5wS?=
 =?Windows-1252?Q?CCis+21OSfBj/VO+3k48JdKVlJM3G/hi9pu1AHfy5C3yZxXbgvBTtQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d6d24b-fdb3-4f60-e3a4-08dccb3533e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 09:54:14.3595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zlhf0w5VSe8oDI6QqskUxBOEwW8QhtEUmAmd6x8g/bz27PU4sGcFz7NbsD2/FRhPvdkzYARyrlqm6QB9nokhL7LwlWrOGgbKX9Mwdpw0mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2973
X-Proofpoint-GUID: P7ZazreXiz1JX-QukkHlTNsukh0kYIQU
X-Proofpoint-ORIG-GUID: P7ZazreXiz1JX-QukkHlTNsukh0kYIQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-02_02,2024-09-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=778 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409020081

Hello,=0A=
=0A=
beware this patch is buggy. It will break the IRQ handler function of inv_m=
pu6050 driver.=0A=
=0A=
The normal code path is going through end_session label without goto, and e=
xpect the function return before executing inv_reset_fifo. Without it, the =
reset FIFO function will be called for every interrupt and is breaking norm=
al functioning of the driver.=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Markus Elfring <Markus.Elfring@web.de>=0A=
Sent:=A0Monday, September 2, 2024 08:00=0A=
To:=A0Gyeyoung Baek <gye976@gmail.com>; linux-iio@vger.kernel.org <linux-ii=
o@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen=
 <lars@metafoo.de>=0A=
Cc:=A0LKML <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: iio: imu: inv_mpu6050: Remove duplicate code between labels=
=0A=
=A0=0A=
This Message Is From an Untrusted Sender=0A=
You have not previously corresponded with this sender.=0A=
=A0=0A=
>>> Hello, I apologize for the insufficient explanation.=0A=
>>=0A=
>> How will the commit message be improved further?=0A=
=85=0A=
> Since the code is short,=0A=
=0A=
This implementation detail can be nice.=0A=
=0A=
=0A=
> I think it's fine for now.=0A=
=0A=
Please reconsider such a view once more.=0A=
Are imperative wordings also more desirable for a better change description=
?=0A=
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git=
/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=3Dv=
6.11-rc6*n45__;Iw!!FtrhtPsWDhZ6tw!Hb9yipjKJXmB-DO9gWKADZfQZHI84WEFUc6Ns1iGh=
pAfvAAyjrnLQRJZLU2Ha0nI8Fs-HBqHFlFbq0Kl-O1CJwYLe776xbRywQ$[git[.]kernel[.]o=
rg]=0A=
=0A=
Regards,=0A=
Markus=0A=
=0A=

