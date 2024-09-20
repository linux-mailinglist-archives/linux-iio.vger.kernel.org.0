Return-Path: <linux-iio+bounces-9666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5342797D630
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 15:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EEB1F234F2
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BCA158DB1;
	Fri, 20 Sep 2024 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="qBBqWT0M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92A1531D6
	for <linux-iio@vger.kernel.org>; Fri, 20 Sep 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839308; cv=fail; b=ln3xQeFQUObLS5hJPVFq7XENZM/vdO/Nd9bjTfy9fwR2IdBKKLJhr3uLDywhzVbagIlYgxvYtAgbD14/tOizHlUu3QAXrQLEKF0hmfv1fuex7CG2CxeCOBG75kX/JSygaN72NXnJ/ZDgHt/0JyYyngqy8PuY1MM7ZSqruUg/bnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839308; c=relaxed/simple;
	bh=FOxcdnaqvhd6LDrE7+rw/rGSHiVkNt5pOH6QewOVrb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQSGbbBLdhRcM9r5YTVRG4pF1R9gaukS8Ho72tO82V3YFK9gLbawVCtZhkwqyNNMebg2bmotYbHKnpTm79l0/qgVZBFK31MQGngp4P2lZHzmjpWBDWbQqOsIdTrc5H8DcqvZLePSnrx+Vq3MacmTEu6tpwXxuMUvd8Oa+ndV8o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=qBBqWT0M; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JMS9Se021879;
	Fri, 20 Sep 2024 13:34:48 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012048.outbound.protection.outlook.com [40.93.78.48])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41nt89v1b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 13:34:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH7OwuykveS1PzVr2UrPG+DGg2ukMEf93R5ZXXY8yRJU+aXgpmSLSxmuRED/WzLf76wXUmaEbD0WU6k01G2Tk9gXI79J75UN8YnLgNIsic57IbOx8dVh/GTUGZVamEKzH/6HqW4nr4SipAb1zZhKdUz7z63eclUFVS9hBWf5VfRYD8S2T5NApT/8jM0kCzN8sM6P88/b0i0xg54A3z7zXuaglJlKyjRB0FY7vELzf4Cex7silQ2dUaD+LkE0MBjb1F+3ylvJ7+Ywbg8EJcHNEEEaLzaTn65L2lBk93AmjbBjOcVoK/Soat1y+UwgESwCJBmQoAjAM0oshJYNn0orEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOxcdnaqvhd6LDrE7+rw/rGSHiVkNt5pOH6QewOVrb4=;
 b=TLBFPurcG6GZ8mheq9f1X5oTJxZ4+ExkZKwCEQV+8ha0hWU0CtyFw1cRDYAjJz8XCI6GBuj3Ug1oe7A7imimMmkXHDx83KarvUpnONtloYNq4Uix7xU/6S3859XII5N4bKN6mabw83Y1qmK8VOvOSEtQf3/00VGqlgNKNTlka0wF57s3rNiLQEuo2BcqA2aq/GBLvXwJGDDof3E1gZwBcH1Kxt/RzMsrbt0EOV24SdzC74UA7+VLn2Kbww5odUxrhEjl4Z8xdxkJq3s87glkg45IthOecz4mW+bJs8dtzywQJxQyu47eDjmU6fuTQFBM7V3I+990aGOyAqCoDUW4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOxcdnaqvhd6LDrE7+rw/rGSHiVkNt5pOH6QewOVrb4=;
 b=qBBqWT0MrGxnFc0ggMUB99986dU+zXyUW29vRi6Jx2tAs47qTFhvvgZPSPulLPUBfSDTnTBuGcl05lFGL4V04wseRUGTJPojMSopS3AGZNqwx7gPq98QQKgloImkit1BgmrkEGEhcAhseGAB2z2JaPKS5XoJgdFb+G8ejooLfKZgbu9LVsCyACRC6H6bz5Vte/CZfLXE/u/UaisngW0qI5AD6cKz1T2uJCkhdkB67XV8TvYuryFxhAPvu8J1E4hoR7d+/gZpfQFZTw9xaHPymvC7Sbku2FkgezKL9PjCUwqeh/qBtwZ/7A4/cRF3H+Lu3k9XaOmaD5oeKwOyamDCGA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB1770.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 13:34:44 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:34:43 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        INV Git Commit
	<INV.git-commit@tdk.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp
 bindings to mpu6050
Thread-Topic: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp
 bindings to mpu6050
Thread-Index: AQHbCqAYP8c1j2LTTEyckuwJ+4jprrJgiKyAgAAllic=
Date: Fri, 20 Sep 2024 13:34:43 +0000
Message-ID:
 <FR3P281MB1757F775FA4EE7DB81498DF5CE6C2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240919142719.162431-1-inv.git-commit@tdk.com>
 <20240919142719.162431-2-inv.git-commit@tdk.com>
 <6345d621-9cd0-4e0d-b5a4-feea8dcc1738@kernel.org>
In-Reply-To: <6345d621-9cd0-4e0d-b5a4-feea8dcc1738@kernel.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR0P281MB1770:EE_
x-ms-office365-filtering-correlation-id: 1c6f21aa-d0ee-4b1c-cd1e-08dcd978fcb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?eCjpL1K0LIqXRkfnEq0LVWx0YNAPvrFaYl2lTSmQ2b8GjNPFEQycy5LGkc?=
 =?iso-8859-1?Q?r6qr8dDk0PwyWXdsKvH+zYS0F+WxNndoBIqietn/YOohjcYtH8tT5MKW7R?=
 =?iso-8859-1?Q?XA/aHMF/CeHp4J2RdHzMtbULJupmfEq3h4RonTPIHP8euDUJyPoLoxopYY?=
 =?iso-8859-1?Q?A/PdzrgnlOtDdcW/9OiPS/7cCKiJBVVOPv8HvyRWOtUAse3Tx77Bd3uyGw?=
 =?iso-8859-1?Q?Q0F0MjapMuPmtKhm6hrNKQHRKDLJXhZ4uSVV+YBtEba4l5ZAuBUSqlpNOa?=
 =?iso-8859-1?Q?SOMrk1VhnyWPEJLFRgTZFZ6pEoRmB+1YeAjzi/SOO53zEMYaxtUAeoXWPy?=
 =?iso-8859-1?Q?SZjBP0s6q0yEcatr6zFn4DujUKlyvJnQm1F2NOtGN2tGps6wBdQgM6V0nM?=
 =?iso-8859-1?Q?y6r/IJB1iyFbZfVusb7S6we96DADT3nSW/+h6HgsynulNHPZ6E0l+cbhaC?=
 =?iso-8859-1?Q?+BZGdBVrprO41I8XCvNJ9Mrv7zOJK4HW/xppb9TklakPk3G7QqV3O8rCaW?=
 =?iso-8859-1?Q?XtF5diQVGo2+CTHu6dc3RC4+a2lGxe5GVKxcvzXEqe4LSqB4irAXeKTU+d?=
 =?iso-8859-1?Q?SoEWwqxnT67KQMRGuxXkAnGFE7qP5hvatII5egwUcvRhzD1ruUiemMzOJL?=
 =?iso-8859-1?Q?QOEPfgz1kMwY7jpNZwUYtRPYICvxhRS/bEIUxJ6AWyFmpLbCkw3ODkFowr?=
 =?iso-8859-1?Q?xJrCxCsKZhd2pFC559EcNFYjFjY9EzqNc2ALiFqxC3U3e6o9NIlD8ZLdIM?=
 =?iso-8859-1?Q?3fFtZX5u9kgCDMmY1Rf4a2XK3XYauxCNKVhrRqNj0Om7CQgHWbzQAqg5vs?=
 =?iso-8859-1?Q?nFYkie3eXuoROuvUK9jPY5jLTWlHNtZNJzZZGK1ZefaopwTFNbOyucVCfs?=
 =?iso-8859-1?Q?X5cXy9d6Qv6eQQNB9d0+Un8qN6ZLcWt+kP6+zEJJjLW3AXhQmaebRgWxU+?=
 =?iso-8859-1?Q?uV+AaLtqmQFibpTfq3R9I5SvWiZNtP3+/bBUh7jN4mdLngtM8l+uEfd9hz?=
 =?iso-8859-1?Q?Bwum3WzJUuC4Wa2RHlM8OCT0bybk4gDc+ex0wmjalKBrepyXe2Uf0CDVd+?=
 =?iso-8859-1?Q?z6U7jTqzvTlxtvbJH1OdviOSXp8z/siDF1LJPQM0ZokJqoPvLpDgBiXWHz?=
 =?iso-8859-1?Q?dF8NK7HUznD8LoGaExBWE41AHgARZraXJS5C+NFAq1GdKDq8Gbh3EGh5Hk?=
 =?iso-8859-1?Q?gM31WaduTHuDc9qFxyyAs1Zjg0R1LsCGpMLHfmM3Rr+l9qXD6Jpf4iHpyb?=
 =?iso-8859-1?Q?nvFHACi6+n0vxKtQOmdIsLbmniyWtaDVYQ0RELhqaYyRP1qr9v73eTsNLE?=
 =?iso-8859-1?Q?syYuntofoZWFTahKQUKLeJ0VEBd214pqLMJapXTSsz7HU2jwF4++ZQG7vW?=
 =?iso-8859-1?Q?hWXIpp7GG1YSDVZUkCI53M1T8ZGI/8Pg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lVpaaHBDUqvvp5a2aiGtK8yIEMLt4OaN49OzRvklFu1HPzvU5pzot5gy+c?=
 =?iso-8859-1?Q?MrOIvD6+nmi7o6mL8djQFMOZ/miTq8idAvukaxesnL9r2X6LshU3w+oUpO?=
 =?iso-8859-1?Q?lKV24H5FnDrFhSZaIqs5gpHuLbS6h5juTkWRWmrk/hYAGKn4cV2sVvU6yU?=
 =?iso-8859-1?Q?y3VK05p568WaM6xneuE4HGSC5XDdHwGzkGX5SB800ILtXQeOVuzMSd8kJI?=
 =?iso-8859-1?Q?+mPxTwzyGN3UVI51nw6i3I+vQBDJSHJZgx26ofcJhe0ePIWrTT7R77DSui?=
 =?iso-8859-1?Q?7pa+VramjWyzf19uOeySPXJrfO2Nlf4KJG8l0efuzRWiX0i+dDkIlpULou?=
 =?iso-8859-1?Q?gj2IBNAI1s7zHN34c3gVUw9vMZs6xtTJnlAW1/zp9x16rPV8eFEqDLLscL?=
 =?iso-8859-1?Q?OJRfTko1EHmQre20t4BAOHjV9gXHukR0ixSDBMR/9O+qQCHd1Ir/ZAKrEH?=
 =?iso-8859-1?Q?FL8ZSebf7GWExzsbZqihOprkQYDxFLZL0mgCipfOVYeYz9F+sCweasR3jH?=
 =?iso-8859-1?Q?6pXFXP4aeGpLIH/AnZnpWiZIp9tBQ8MOHeq0HDgMxbn24NkM8E7uvR9iqY?=
 =?iso-8859-1?Q?P6o0dd4DrNbC7LxtC8zySxRT0T7KEmWrKhkynFgckC/RinD+MSCRMBPkR1?=
 =?iso-8859-1?Q?2HTcpYSRO/y7oBpHarI2sj/80oC4VhKHZB6XR6Tw/Z1+ivEb61YG+aLPs7?=
 =?iso-8859-1?Q?caNKnP861aGN87uZl7AzGswwufT97ZiIuMIs837l7u85zLPBhOZIrf0CGG?=
 =?iso-8859-1?Q?Lt5Yop76dtxlnVrM6WcQHyTc5wioAxxzzrW5ClXo2lZ+iPcBiPzXN+cqQ+?=
 =?iso-8859-1?Q?thWFg1nBY4JfSY+etnjA3ZgldbgYkgUdqtPQWVK4lFBgbzYeheh3FQbX0j?=
 =?iso-8859-1?Q?SJVcVKvbHSayECGs0P7lN713TD1c6G13Ysy/u5W0SdDr5rfFXzeaOMU5GQ?=
 =?iso-8859-1?Q?RpWFs64zXzB16WNi8VUG5unFB5MEqyc9o7YF8989d6b9NfjvY9/DpdZCga?=
 =?iso-8859-1?Q?AXjlMhBbVvFO3Kw4NFTOUslfax28N1dqJ1MEqZgNkNcMCZDPihv+IlA28j?=
 =?iso-8859-1?Q?DbFS2JXWQQYm78ynUHroKZ6ocXiwnEI15Wf5Uryh4B1i14Yd1znzptePLV?=
 =?iso-8859-1?Q?Td/KdiBbSC8RNdqX0IijuZkcM/qYG2jinf0v/rRvflq6CKwsd1vtZr4yLh?=
 =?iso-8859-1?Q?AALtzR4OOcHy3DgOHB5l8PddnkmUewdjKfe8uxyESydhMvqMdGOJD22bBR?=
 =?iso-8859-1?Q?IcU4d65QvXNvcWvdd6Qrk48uNbmArZvLsy02dWGrP8ZOLRdYoJQ0mXlzBM?=
 =?iso-8859-1?Q?2CBl4s+UKsrY1RwaIah+6+fAmwBZwJ8I3CTiAskCFgJTpiuK8SmV2Y+RQE?=
 =?iso-8859-1?Q?5yElac17H/6aXJCi3cyh34nxnql9GWGlI0Gu4bOUcM8KfBLJY7m8dBteX3?=
 =?iso-8859-1?Q?VxtAUqRaKvuhkFhajj3M/peviYUNIFsFCVmZR5Xb3o52fJvRKauej8AiIX?=
 =?iso-8859-1?Q?zEOQjfoLjRng3Pbl10rG9+XzoYBlzYbhRj8tdeW1IIy9OV3ulMURgPvBXQ?=
 =?iso-8859-1?Q?5QSvGgzBIZX7QfTu4tTzSqCFESFPRdP9qQu7XyNHtJkxSj+Zj++wkcdGmL?=
 =?iso-8859-1?Q?TYkHv/sf5NIDlo1N7QQ54QD03K39DDQ9zs+zQYTCfjruKaOaUCQdgdA11u?=
 =?iso-8859-1?Q?PgEPRGzmzPb8yc2ozGSn8A+QvRkSCOpsRky24eKbtrVNvd5IQhSnHB3/L1?=
 =?iso-8859-1?Q?eTig=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6f21aa-d0ee-4b1c-cd1e-08dcd978fcb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 13:34:43.8514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LcdcDWV+qlZzDniDUeidB6QQCSpokFOqi28CNAVvCElDLlymAHdJHCxYfUB7dvcTZYlwr4OXgOXuOZ00k6avQTP7/wajbZXbwg7IY9jhjTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1770
X-Proofpoint-ORIG-GUID: JuPXfSW0X1jFzuIwvp3PyQQsJQ-TPLPj
X-Proofpoint-GUID: JuPXfSW0X1jFzuIwvp3PyQQsJQ-TPLPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200098

Hello,=0A=
=0A=
sorry, my mistake.=0A=
=0A=
I'm resending it to the right lists and persons.=0A=
=0A=
Sorry for the inconvenient.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent:=A0Friday, September 20, 2024 13:19=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>; jic23@kernel.org <jic23@kern=
el.org>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com=
>=0A=
Subject:=A0Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Add iam20680ht/h=
p bindings to mpu6050=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On 19/09/2024 16:27, inv.git-commit@tdk.com wrote:=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
Sender does not match SoB... Maybe you need to use use b4 relay.=0A=
=0A=
<form letter>=0A=
Please use scripts/get_maintainers.pl to get a list of necessary people=0A=
and lists to CC. It might happen, that command when run on an older=0A=
kernel, gives you outdated entries. Therefore please be sure you base=0A=
your patches on recent Linux kernel.=0A=
=0A=
Tools like b4 or scripts/get_maintainer.pl provide you proper list of=0A=
people, so fix your workflow. Tools might also fail if you work on some=0A=
ancient tree (don't, instead use mainline) or work on fork of kernel=0A=
(don't, instead use mainline). Just use b4 and everything should be=0A=
fine, although remember about `b4 prep --auto-to-cc` if you added new=0A=
patches to the patchset.=0A=
=0A=
You missed at least devicetree list (maybe more), so this won't be=0A=
tested by automated tooling. Performing review on untested code might be=0A=
a waste of time.=0A=
=0A=
Please kindly resend and include all necessary To/Cc entries.=0A=
</form letter>=0A=
=0A=
=0A=
Best regards,=0A=
Krzysztof=0A=
=0A=

