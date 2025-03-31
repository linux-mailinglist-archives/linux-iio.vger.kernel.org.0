Return-Path: <linux-iio+bounces-17476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDABA7685F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 16:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291D33A66B8
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00903221F0C;
	Mon, 31 Mar 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="RGsah+Hg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D221ABCF
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431711; cv=fail; b=IMk9JhoE9nhXzDW4Ggl+8XMxKgkBthZ+4xJed5KTP9N6RWCdKfYH4vQ6mJev8fzNUtWtVM1yS9G7HzLxdQCxJ6YmNE/mkYtcCsN+EOt3gj2rRq1b7yaMvL8zfYXDTB9qgdwFH0LNBuGsnOQPhmoxjVIuWrLPBh/FHiTt4Fcs02s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431711; c=relaxed/simple;
	bh=QTCY+7cy1NqJXuU3sXYiXTz5ZlVys7cHBsM/klFt1FQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jcII7xUE1rfB7UiW/OrHTgHk9ANdd6/q1c4rx008VBJHvL6SpYFlMAhEJvN8ACGudF2Cta/1giHDZ87MG2akPcNRj+DS2TK4A9NSvz+bVu8V2t7wp6AU4Thf8nSVcGpAJXyaZvlSf4LIe+Pevw+YEbSqESNganyQUF+s8UhqEHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=RGsah+Hg; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UNHH8B000561;
	Mon, 31 Mar 2025 13:57:35 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010005.outbound.protection.outlook.com [40.93.77.5])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 45pa7n1hgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 13:57:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3bNsFmS4c4GRit90ZfEwMl5VlJZTCBYlXajvtTZNlj+1PR8s1v70GtLCDnfRMyGYRxSfcgJrQRyHtQUf6wVl7tS4jhhyr63y2vZDWc8x/kJTrr8MaaXCqVdgi2wWZ/9t35SvPSnUSxPW2T89OKgEVCahjIfobyuXaCt24Buf16O/vk23Hn6x/OyTnO4/JlR1fOY9YEfiDbl2kBrk0dqgXMP/umAz/tNtVm7NrDOeqpfWjgbRNo/XTjfgdidtqr0xzHcfh5UEfatCBWN9z9nWPjc/cyq9p+Qix5YcMLMG/eVRz2cWnatf8BAhqCB4zft2RyJONPAScKYBpWz0Gp5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BFZPXKBgvuRBKRztlip1TeiXgI5Cy/UcA+qc2UMQUE=;
 b=vnvkkVu6kElyKboonPiwdCDgIH68/n7nLFyELsp0TTyoiI0dmqqc3IdpgpVBRM9LjfIZzw27cDtkj7s1ByKHLTcs6aIDWjcbUSxWA6hYOB37EgMnNO++M0FGMKZAhsohx6fBj7SDsdY++2oJDbcEUeISD8BZGo6MURgQX1r+8brN3YG34pB1jV73TUkhvS7QgJzdB1okkx8To7388ttn8xDq66ZqLRIn8O521GiQ9wK38AdmWJb3227ZoTnhl9TrqUrRsVSHHYSA+TscQdR3NcMPalB3uYEIM1gqJUZzh/2zWPSbzpCQNDpm1dhgFRX1ZTSqKN+gdGKtPgqm4GWwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BFZPXKBgvuRBKRztlip1TeiXgI5Cy/UcA+qc2UMQUE=;
 b=RGsah+Hgn+7rcfd80jwKln08MEZlmTPVXkVl3/N7msk5lRAkx3jyc3zb41JX19KvRytyONCCFnsIFQciC1tr9CRbFye6lSPBUSfVzjSQNA6RjryCl8eEYfcz10FvmX9nxjvcsqcaGF+mJszFarb8+PxlXJOXBsm1tT/DamDqHrfAmLa6g+AkzoquHqgQ3GcoZvy/WsOqkppRBE/OmXC6V7LxglsVvc2DZKMYBTpXBNqW/cmdVPRdlP0XyHvEQH5erPJrRJjtOb26pULDPR7stcIQfpL56iH+KV0GqRYGUFX/tehv+Bo71/ASwaxT+Ad/aI2w5c3bTq4S60VlRI0SmA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB2336.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 13:57:29 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 13:57:28 +0000
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
Subject: Re: [PATCH 16/37] iio: imu: inv_mpu6050: Switch to sparse friendly
 iio_device_claim/release_direct()
Thread-Topic: [PATCH 16/37] iio: imu: inv_mpu6050: Switch to sparse friendly
 iio_device_claim/release_direct()
Thread-Index: AQHbojaWez4ID2T69kSfFYdORQ2dabONRFwu
Date: Mon, 31 Mar 2025 13:57:25 +0000
Message-ID:
 <FR3P281MB17574F4FB982A29030108845CEAD2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-17-jic23@kernel.org>
In-Reply-To: <20250331121317.1694135-17-jic23@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR0P281MB2336:EE_
x-ms-office365-filtering-correlation-id: 17999117-7c97-4a47-d5b6-08dd705bf7e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?uXxbNfCvL+wt7b2W0vUsxRWaj93WOrr+Mv1eN3T4MaRFLihOLpQo/E+wvP?=
 =?iso-8859-1?Q?oo1yOCU0ydFupYQOCfZ4Twb+zbaBHpYxke5L+Q/fK8X8AmAcqDiVQLyk9f?=
 =?iso-8859-1?Q?AbKmTh63XuPX4oKHb9NWU6QZZ6h4ZjJnCBybTLUiNYlL76cAYmEv2J6wkz?=
 =?iso-8859-1?Q?Kb0pfyAOXc8QWFiFvHZ/PSNJzPA0RNPTskd9TGdvRQe+xy3VA6hvx3/nGk?=
 =?iso-8859-1?Q?OSZw64Jy3yR6FLhHvJ1PXu33thhplszFo6FT/Djh+neTc5azch2Ef+HDt2?=
 =?iso-8859-1?Q?oarAAwqii5U2Yhlb+8vjyJln9xUtbsQF3ARbekx9TF9rM8Ci3JfYDvMPsR?=
 =?iso-8859-1?Q?UT0KMSokPrfQJF+lIAH91ZZZVCzm76Stl3Y7Dd4F3axIhXd5aGixhroARl?=
 =?iso-8859-1?Q?fD+Oujtq6uUx22Ok2Fx8S9gN58W7zJfej20LusYuPz0fIf+ll+EV66OV2/?=
 =?iso-8859-1?Q?z/b5uqmmbvegxneiLMLT3b0hTPI1oA7cY8vB4SpME3shqUKYQ4Ma94ySTi?=
 =?iso-8859-1?Q?hfkjYsz/+wsNRqh98mcu9KfuxBoRrBGtjqAwSKfOF/f5Ve+kvp3mgWSvvI?=
 =?iso-8859-1?Q?lIMuuoV0g2lJZd5SiWy14CYAcZvbzSFHYRlGlseOsIue7vUA60w7z57d01?=
 =?iso-8859-1?Q?VzirFryoUOkH77OtzNUBG0zKGJQeipfO36eIUnynJLGlysCxcoN00nSFdV?=
 =?iso-8859-1?Q?Iu4ewSgB/4XOjPh+h0sMhs2gubBMnwyYcXqrMIgBsHb7hoKcJqMY3XbKJq?=
 =?iso-8859-1?Q?AmqSbzMCLgkaLzYQqWAmDilw8AtqvxjU7sDpya40QTYTdiHdLDxJOsEy8A?=
 =?iso-8859-1?Q?R8fdfr+P7wmlfbST4usk0lZ1kIu2QP/FjzjbTZiLIUsgUJX43dbdsYGlZ3?=
 =?iso-8859-1?Q?7+YcBJk0yJmkH9UYkYf1YapFVtYagLV8VSdyA8ZrEZzWBDZfx+Z8RPXwpm?=
 =?iso-8859-1?Q?W7QZ5lmGW/6jax0GWa5VB02quqUthr3A/muIpcHWWqN9vsD+lRglwWmwb0?=
 =?iso-8859-1?Q?4poLT7kLpsog1ZKdn92gOiX5hzzKmYTBnp/F3MWcKhAvVVXodaP/TiR1BD?=
 =?iso-8859-1?Q?Rv0iZaM3lu5LkFnMMELJQ/iO49iy68O9D+CrBJfXDA9DirDWzQsTiaC/4K?=
 =?iso-8859-1?Q?GHVmOeXrzh7euebG/fQw7jQJWe0kEriznh/SIQFZV2KvOAuOVvMjbej13y?=
 =?iso-8859-1?Q?qC03AkBZPo7Lnu/vY2kPAVNp0FOUq5v6WL5iZx8dqKIIW7X9TTOSnSUFim?=
 =?iso-8859-1?Q?BBIJBmsSiW1RnVd0AzV1J9h/G0CiKZiTMDoP9SIHCyHhTc+juK627MkTS4?=
 =?iso-8859-1?Q?rWhbQfT3Co3TKZgpBLutar1G4YD3ShOhShpGzJKfcu09H0/c1ZGnCrt82Z?=
 =?iso-8859-1?Q?HBW/9HoZ09cVl35qQ+mVhzB6rPMhDqO5BY/UEzZlFRAgAVPFJbC0M6twaW?=
 =?iso-8859-1?Q?WmXze0xWJiCNik/Fb6vs54VVM+2G+nmOoP4Kym2pmYVoKB9zC0kRT2Ii+A?=
 =?iso-8859-1?Q?fJ3JK/V4DxbVQkRxl5bIHLbyoUBaGhWlgd3rn+Dktn4IBIOOZVmFO/P8V5?=
 =?iso-8859-1?Q?tcH6JzEfcM8nO/p/M+lhY/b95Snz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?j3+GrecILa36F42N4HSzv+/JVWIciWFTmNa1ymfqZYKX4lgs0wKNFrbS+F?=
 =?iso-8859-1?Q?x1teDhqsuqnAS/V1wh6s9AttBLrYeSTffQQCiY3bkT02HIzG+hkNiVwqmg?=
 =?iso-8859-1?Q?ToIpBsyCrO+bKDVdo4/sKp8UBlSiDaRUGhDrwvBTv91uOwj9X/hZ0F6nMQ?=
 =?iso-8859-1?Q?eqcECnO0SNPQ/f1rymxvrjJYkh4sY8PU5nrf9qsL6NnJPVdTFVCH0TENXP?=
 =?iso-8859-1?Q?4F7Ot4k1XYK+xADLNrsQHUbrWd/P+fbC/3yNo/+sjmlbO2uMGrqxHD9XJx?=
 =?iso-8859-1?Q?K1AyNRogXeII4PBWLyz8whcDcWCLD6Tz1gvOB+lQ3sFxR4ffxrQNHpbxmL?=
 =?iso-8859-1?Q?NUcYJp+VAA0aK98fEsu71Su7KkY7uhS3Nc3gYViBABNBFlwULNMLzxcoaV?=
 =?iso-8859-1?Q?rikpr33FbDDbqxRiajS9DnUyNho1VzW+wWyA4g7muFj7DIXh58itcLC4o4?=
 =?iso-8859-1?Q?qfMYRVsp2vwAk08/AKL93Gz4WfgdaiCCxEp4W0X2a4B7k94S1kZQ/JN98f?=
 =?iso-8859-1?Q?GFX8olEdRnaT/j++/dtONrwBaZy9rDdXu26HaedgQmUcu8msgr+Qr0+Bcc?=
 =?iso-8859-1?Q?VcONdV6JRmkTIbKH7ODg8GJUYbMv0j1e6b16o0L9XSgW1eWkrFpKtgRqFJ?=
 =?iso-8859-1?Q?+kOfCNgtdFSjp+8aINye/+SoNJCweMmrSdK1/9P6PWhQsTCo/6ou7rFKNE?=
 =?iso-8859-1?Q?o80jGiuHRLvQLYqYjOKbN3Oly14x+iGpkcwHvHkXFxJtQXkgxR7B7SPxV5?=
 =?iso-8859-1?Q?9vAW0gXqB7IVkbaakHf5qO9FYXo6FL7deFCoUGJMrFyl6aXcyj2+28ZE2E?=
 =?iso-8859-1?Q?nRHIqsbgegKwU39zMwxz0iqRtOcW39p/c80UbMnPZTdQsHQhLdB7yHj1BY?=
 =?iso-8859-1?Q?qaxIuSvElxj96MkozX2Qd/z9Stz3+OaJeen3i7wYp1NF6MF9oZDV/4z4/m?=
 =?iso-8859-1?Q?A15lt4zXOIygmACenNNhn8KbM83u19chrOqJAucNklkQg63pmHOdcyeQR5?=
 =?iso-8859-1?Q?Dknonz/IBfsui0XVlZbiaMPZSrBd9bV60jFiCY/YtEZC5H7pe/4U2hP0oG?=
 =?iso-8859-1?Q?m0BbYu0RMQwWIOKnsdzd11Bm6xAbB7395wsEMZXTke28as8CKWPNx5R4IW?=
 =?iso-8859-1?Q?vOzdVUh8oUoGssbI2brQs54+tYXSmRZnAKY/52sLJkW1CIHPzzHoWwa+p0?=
 =?iso-8859-1?Q?iunVnt7opAr6CRVOsb8hYcqW8/qgR1FRN8IQMEZkOEi2A+u+ZlgmtnYpwq?=
 =?iso-8859-1?Q?2OnH9jJjJDFqxYosnDvyqNfA0SO1s3CSJHUFPAMQYjUqey5paMLA2EL2Uo?=
 =?iso-8859-1?Q?b0HmG4zGWDE6gqhDqjmHKsE2MM1ah6TUojrdRmPzwxI5FwZNE9ERSGAjAN?=
 =?iso-8859-1?Q?oVSi2lzYziBPBNgkudrK9JRMgLZWj/LTZY0Nqu8g03XQYFVJFBH+AoRQmu?=
 =?iso-8859-1?Q?3gjpyF09ED+SO4mPlKDBWQIh1o+lM4HOown7T2L90VJhK/1dkRKtlwGSgC?=
 =?iso-8859-1?Q?PiSHcPPfE8SJd3dDVzBQ/pqAdAs9Y1p/DTeIK9AeW7Nnbr6dSroVad9bOp?=
 =?iso-8859-1?Q?UjfM23F5oE6mrhUYXZy1T/a1oLy0w/Dd31chJrYS/JBaOKlWa20O8iKWju?=
 =?iso-8859-1?Q?ke9xwwVcLuLbyAFBPcjLHd4SHhghmVIoGHmyVVZglDe+DXNqADJUGWcw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17999117-7c97-4a47-d5b6-08dd705bf7e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 13:57:25.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sll+fevVPTqK30SlwZztkO/SO7Gv+KS4/qiiersliDy7jaUp/aVC0k1VtfkrZOjdTBIsJ/mG2A07nNtwYig1JiRI4hc+XXO6JqxtaCTpsDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2336
X-Proofpoint-GUID: hgklhbpoSeih0ucdwsT6KMWlOggnOqxs
X-Proofpoint-ORIG-GUID: hgklhbpoSeih0ucdwsT6KMWlOggnOqxs
X-Authority-Analysis: v=2.4 cv=Z9DsHGRA c=1 sm=1 tr=0 ts=67ea9f4f cx=c_pps a=R7FP+GcjGvC27S5kEK8ApA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Uwzcpa5oeQwA:10 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=yutHOF6BAAAA:8 a=1XWaLZrsAAAA:8 a=IiweX4PvAAAA:8 a=hVcwujEvAAAA:8 a=i0EeH86SAAAA:8 a=CF3zxFjyZVKtA2M-1nwA:9
 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22 a=p9TLLz150Om7V_NzouHt:22 a=4UppLPHNXRjA7phoqhyY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310100

Hello Jonathan,=0A=
=0A=
looks good, thanks for the patch.=0A=
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
Subject:=A0[PATCH 16/37] iio: imu: inv_mpu6050: Switch to sparse friendly i=
io_device_claim/release_direct()=0A=
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
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 14 ++++++--------=0A=
 1 file changed, 6 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 5bcd5e797046..b8656c02354a 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -755,13 +755,12 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,=0A=
 =0A=
 	switch (mask) {=0A=
 	case IIO_CHAN_INFO_RAW:=0A=
-		ret =3D iio_device_claim_direct_mode(indio_dev);=0A=
-		if (ret)=0A=
-			return ret;=0A=
+		if (!iio_device_claim_direct(indio_dev))=0A=
+			return -EBUSY;=0A=
 		mutex_lock(&st->lock);=0A=
 		ret =3D inv_mpu6050_read_channel_data(indio_dev, chan, val);=0A=
 		mutex_unlock(&st->lock);=0A=
-		iio_device_release_direct_mode(indio_dev);=0A=
+		iio_device_release_direct(indio_dev);=0A=
 		return ret;=0A=
 	case IIO_CHAN_INFO_SCALE:=0A=
 		switch (chan->type) {=0A=
@@ -895,9 +894,8 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_=
dev,=0A=
 	 * we should only update scale when the chip is disabled, i.e.=0A=
 	 * not running=0A=
 	 */=0A=
-	result =3D iio_device_claim_direct_mode(indio_dev);=0A=
-	if (result)=0A=
-		return result;=0A=
+	if (!iio_device_claim_direct(indio_dev))=0A=
+		return -EBUSY;=0A=
 =0A=
 	mutex_lock(&st->lock);=0A=
 	result =3D pm_runtime_resume_and_get(pdev);=0A=
@@ -944,7 +942,7 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_=
dev,=0A=
 	pm_runtime_put_autosuspend(pdev);=0A=
 error_write_raw_unlock:=0A=
 	mutex_unlock(&st->lock);=0A=
-	iio_device_release_direct_mode(indio_dev);=0A=
+	iio_device_release_direct(indio_dev);=0A=
 =0A=
 	return result;=0A=
 }=0A=
-- =0A=
2.48.1=0A=
=0A=

