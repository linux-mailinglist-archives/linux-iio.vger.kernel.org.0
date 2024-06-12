Return-Path: <linux-iio+bounces-6194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DCB90526C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 14:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7372E1C240B6
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34716F845;
	Wed, 12 Jun 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Irs8bqWF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6616F0F3
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195366; cv=fail; b=atMvj+JUmRB5XvL+10e0RpHP2FWK92cgZPqobAhJTWFMV7W40C26GjzaKOsndyo/wE+l2NXelciedoCkNfmfZVZG+qdTl+gq+z4siN2jgStlJHLe0JEmtiLOFahvOuT37WZgif5Mq1jTPD/cgdM/QgJv2L/opcpUUXW22oQ658E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195366; c=relaxed/simple;
	bh=T1bp98thNRgtGuYLNChKlbTJsVkZoGL42NuT4gTNrDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GAqPcyYv+Pq6UsejAUV5ffEtGpBi4aGSB5TPwZ3kRIOykxzmqecK58s0eAgQUnw/eGay6Z8cBGUKtOcCMSJA9PwebfbZ6AWl0G3gNrR/XwhV39qJps5zRfVl6WCPJ1xPdVpr30R32yqrL0rLMDd03GRO40hG+hb2sILA8PusKqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Irs8bqWF; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CC0IGs013792;
	Wed, 12 Jun 2024 12:28:55 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3ymgnjtxfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 12:28:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK85oWOmcG2gZemITJf4j8o7P68HxOh4uH5DRS1sZ8T9d7/TBt+sDehSfHt7Lu2nuj+MQ+LWY+SxlD0V+FZY+8oYfBmEC7B/I1/bfJEHx2Aa2qpTXOTzvUATh5jWdsM2drL+m/XeCyl6MCzus/snUNlqbfVKqm8tl/wi7NicXkoYCFdnNFFq3GaOcU9prMhohPJ9l/l8qZqQClHdCmDGID+94ArGY9ywwbO7Cszy9Lyd5pXnG/m5c0NqxcLwH174o6YvfTPEyLPqqR9+p+2A9INpjPNIKbOmEEZ+Ocu2WwbHFLJ/FNSaImxqNypchwTCnjt9R/Zul4GojFKsxJ+z0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOlN+yfxXMS5yBAPwzdDiENXaLXo/3DWCnXL2dfJq0E=;
 b=GzGRPGHUO06/eAFF3/9poHoeY4v7OeQGWiY9EnpuLsCYLWujrFZYVcaLUbd5sfV7VVPIokEVj2A6RChOCeHRtWRJWq3otGCTocPObXXPx8AtBn7OMwCaKDdl2I89eaQXAspnpPhmYaj84XeC781QMsrVsFb22Lt2fSWh1vnmyLnny3lownK3cQhrRGPhNMdUW2VSbXrnLv/SbaLJF4wIdO6X4nbCE4B5phhUh16bBd3/AleC6NEpsCl+e/avlBbjmQvO3oYsIr0da4lvUheKQpTmJ21gq9jS4oLCsYOFgauH0RxKQ5ZdrkpMBGTvGlGMpCcNRQt0WR3sS0//o0MGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOlN+yfxXMS5yBAPwzdDiENXaLXo/3DWCnXL2dfJq0E=;
 b=Irs8bqWF/1c6lFmvgwlRo4MZ2qA+FjtltE/bjhvw6WW6pgDOLBj2bs/doxi++iTRLUDUb2PepEC4RNuBlb6GlHy1gGZlS3tDfa/auanA3G4kSiFS1WUSHtr/na52wuaXEbmZqE62XbN4gCclCWu2Dpj6yZ1/1AS3dKhUuaLuX0sesgu6TEEB+T9WizZyFvY5R7BL4RsbvDkzif1AxV9HwTXg2LAam2pR5Myw9oyMblOT4A+PflEj6iyYbCwNYpOw23E2wcI5O0J8Twt4yOnU2KlVHzWWmZ33YfFZ2K+V0LINaASrn8PHZs0eG7IoMZBxBJT04aH2hF4/7t7/s+pHpw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR0P281MB1805.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 12:28:50 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 12:28:50 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        INV Git Commit
	<INV.git-commit@tdk.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] iio: imu: inv_icm42600: add support of accel low
 power
Thread-Topic: [PATCH v4 0/2] iio: imu: inv_icm42600: add support of accel low
 power
Thread-Index: AQHat4L8cbJIXzJ47kOwU7fm8X4PGbG/OzYAgATdmZU=
Date: Wed, 12 Jun 2024 12:28:50 +0000
Message-ID: 
 <FR3P281MB17573989B841EE3886CD2580CEC02@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240605195949.766677-1-inv.git-commit@tdk.com>
 <20240609110930.2f40d3d3@jic23-huawei>
In-Reply-To: <20240609110930.2f40d3d3@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR0P281MB1805:EE_
x-ms-office365-filtering-correlation-id: c1729a02-25a8-4ca8-91b7-08dc8adb3724
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230032|1800799016|366008|376006|38070700010|3613699004;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?B134rWmH3ZM5ZLC7gDYsZMMfEiMM2TsaKwoIFpNAbC6EJ9CmMaD3yyAZ50?=
 =?iso-8859-1?Q?Dp8zrGGXiKMaZqRqlZVHOlzwesrZ4CFwqW92In5+V8xBxZckNFbsJp23Vl?=
 =?iso-8859-1?Q?hs5WcniJAt61XHqVe6/7ehRo80V/5WBSedhqmWG8v124Qwj8HP/3ES/a1G?=
 =?iso-8859-1?Q?jCo4lIB/0N6FPnkl5HW/idqSEBy1p37W/oJC9sKBwtISaXgdwRhpy6JsiU?=
 =?iso-8859-1?Q?msg/qGE3Z49bC1dGFQ90hCMKvZA9H8Sk02G4W94TOQIzux64bvicMyBQpq?=
 =?iso-8859-1?Q?qImoQWjsKHDUkvkm8bkPaejXlXKz3NvvQvDGuJUprGrYls46R4fKQssszI?=
 =?iso-8859-1?Q?3qVtIa9uqY4wV1CsMuFLxTx5v54xtXG7AjmCBZ4m2ef15hzIxbaxPrQVC8?=
 =?iso-8859-1?Q?DRepkn++E4oSpWfSpAcpw6kpoukAuGTgMahHu5qAXHFodx6kT5fOa+isrZ?=
 =?iso-8859-1?Q?2+OoN8mRkaJ8PugMP3gzOhRWDz4siP5YMwO3nDHSuxmtctNmHTUQSrtcvA?=
 =?iso-8859-1?Q?LUUDrYUvBr40uKHglzR1t4wzUmVr0JssDs9b0Ai4c2I/Z1Hzd/bguqHPb6?=
 =?iso-8859-1?Q?twV9M2ALl/mxDATaweLwhlz8CNH9L6cm9pDugM0IiaJG8EZ4y9nXN7Fp7K?=
 =?iso-8859-1?Q?k1OORKIyRHpMIrRFNqPAKBBj18OxvmJ9ov4RH1TMhrkJ6qrEkzEOnvZpOr?=
 =?iso-8859-1?Q?bRwqIIAYBLQPju9IY+bYc/6i7eqQjWF0o3cdlEXBK76mhTBfKBN4TFDGwk?=
 =?iso-8859-1?Q?Z45ju7waiTzw1z0rg8wOhTzpsm5/jJQanenA7o3lhLVcW1fWRaBEVH5OMY?=
 =?iso-8859-1?Q?HeQTsym3jQ8FoNVjiHlBW4G/lAD4SO+vUWgtIgKAO0XSD+Tcymp5xZqb2m?=
 =?iso-8859-1?Q?zpRRXD81rg5DRpebFdccphearzQt+irCYm10bPSjIttPpYfkIY6PRrSvM2?=
 =?iso-8859-1?Q?pglvnm6AbAtlNdH2ZIieFoQ086YA/bzOapa+KXy13lAw13gqlfet5kHcfL?=
 =?iso-8859-1?Q?dmf2ufM6nX1DV52lJV0paWiswCC5fFV/Dg4QWDZOFBp+a2EieAx0RfD5fI?=
 =?iso-8859-1?Q?FMHrmuJ/WahefyjpGS5NH1roW8p28itNnFZYDf2m1Cwg3bNWm1c4F7wy6T?=
 =?iso-8859-1?Q?ElTRGBVCRaKycVKBFL4iEoQ+AOiR5e1fZ8hmD0/buEug8Kbd3bFnXOpv69?=
 =?iso-8859-1?Q?a2TJWSKw95FnN3gzIpRh+D1YSriy27NDe4E4j+YmfXJtUZzKdDjOyoOdXN?=
 =?iso-8859-1?Q?nwiJ2tErLkv9Q8prVdgyDy1xdOKSehxbEc+nq1XBDzJedwJFAQ8pls5V+E?=
 =?iso-8859-1?Q?FDYgBdP20RgCfxN7r/dW0tS5OaPrxav/oZceMkUjyI8FenDjM3uS/yMbxn?=
 =?iso-8859-1?Q?FXRd91df9bkgtpimYDThN3AMzQ6nzdfbnnp+KhWJIfAc+qK81WlRFwAsfC?=
 =?iso-8859-1?Q?t/qREA5IEAfgD0rCWgiLE0P9UTO0BgADAgxYVg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(38070700010)(3613699004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?CJAnTNrvUAguhZ/IQGUuxgxBEQdFIjtyjd19XYOTqbpGuH6SunGuFkZbGJ?=
 =?iso-8859-1?Q?4rXXhZB/QOD/h99HfEe2rPXrwd00vlDg/Rb4H0+orJsI+OGKWmxRm5Gs51?=
 =?iso-8859-1?Q?sTfOcOnn3QM5v4O/VIcJ/wjA1zD8GoK47+WNcu/6t3Yu3YCOhPrhIl89UG?=
 =?iso-8859-1?Q?+4A9VnfBDmh1e+rK81XD+UroXCEgUJpQXqO77sG710o1bKGErh5LwM7Jzz?=
 =?iso-8859-1?Q?SLvVsULuHV1SxCIvyoAGJ9kCYkyCZwHnOdnVHwGtd5pbFLbti6llFOhkCU?=
 =?iso-8859-1?Q?XYBlGBm3nxsxW5RSkYdJwNAp7nAVYNVj8wFiQZmTW9vgie9LrwuA/8QR6Z?=
 =?iso-8859-1?Q?CQ3Pne7kS57xC0J5KT8zHaG7X4cRSpfz0mbZw/6iVQEtAN/0/h85tc15/s?=
 =?iso-8859-1?Q?PSEjnuZyQTZrF2aDOG6s6wK+boFnprpwnsZFWwFSv9fh//9Hh3mEljsqsd?=
 =?iso-8859-1?Q?K1I0VtAhzwbiN27XvN9t2cppDa8aG3TTGySXnzmq4CCPCpo+JdE7n2l7ui?=
 =?iso-8859-1?Q?X45ZZBqmSPmvA7Og3VdCct51HJVNcqSfdTyoC6crO0eDwifTjHqybC+mY5?=
 =?iso-8859-1?Q?U9A8NzW50KTUg8ablrNMDGxfPbS+wOHlDE8tlddawaTM+nRNpGTgADL/Tk?=
 =?iso-8859-1?Q?7jym5HW2pDkSQqrwZncEk8vkNm/31Lk0OC3VVuLfpODGN112LX93RJB2BX?=
 =?iso-8859-1?Q?x/rSRI+UoS/cASFbq/hI698baYB1xeD6o4hixJtlvcYf+VyEyWa5gzcGCV?=
 =?iso-8859-1?Q?0fsK4k2CIjA0DgVxXS9Ky05+2ZfUocKDDmc7j89hDs+1ormNx9EHpA95TV?=
 =?iso-8859-1?Q?s/ZVIOj2XoKGTMWkmxJhU4wqMQZ8UnuajVizgLC8SqjQbt7pwpfnkX3dMn?=
 =?iso-8859-1?Q?AszDatG9tWcDolQq47eVO6NQAhhe23vpA7OpcITrQJlp7lLPw6CTkSayh6?=
 =?iso-8859-1?Q?VzjtNAylx3BH0YvdbWjCpMsTTkJKBUr4pFK094qikQChuGYzJ4lQ0OGMkF?=
 =?iso-8859-1?Q?HnLuqROnCMDWT7umc8d6G4mvJQqp/VzWioRQSaOmiYtyIJu5rE9p7NlhDp?=
 =?iso-8859-1?Q?VbXwYsXtEXFRDTQTjQ5yXgNyg9PVLiTGUqoxoxO6AvNUz+VLb8ECTd7XBF?=
 =?iso-8859-1?Q?+Lv6SAnMYTwx4Kim+ab4rhMRsqqkezJSwbt3oW3d8MLuBhBF9C7lCXfy0U?=
 =?iso-8859-1?Q?bWHC0dfBAMOm+yqsKOxQeeDXIM+4XCYKCWLjhPYZXV66rTLd6P8z0Jknb5?=
 =?iso-8859-1?Q?l/WuBTyESn8dqV8xBT8Hlpvzq4HDT7zOVwWlwG8En6L0X6iVJxxB3nZInt?=
 =?iso-8859-1?Q?GlJ5zSMNBNFIMyAJIEZP7ZZrDem5+iEAaa5S9bDIBXMOCOe8ouTKreKZpq?=
 =?iso-8859-1?Q?9+TgxwYo3ENWErKwJH9nCKxJYc+zJIrD5U+/IRF8JPI9l2F7RWfATR11zj?=
 =?iso-8859-1?Q?2CkbI540FYN7CWEjFa2zT5BqZMC2uYdM2QpMhLsWdksi3eY3Ir0DNrdUSJ?=
 =?iso-8859-1?Q?O7a64oCA1GAkGQR2IymMcux6tsvWDxXyCHjNTWYGs1Z65Fser6Wz9BECiV?=
 =?iso-8859-1?Q?+jiCnh4yA/NU9F8tXbP/4yjVwLCWdZt0p6W7T/yOemL08GFCDRMwt2bI/F?=
 =?iso-8859-1?Q?pQISoHym4uGAOMfeYqLYAgPC/gnmAz6NGGdPlB6BV4GcuLGMg0N6Enp9yr?=
 =?iso-8859-1?Q?rdIex97YRUFocecRCjQ8yJadw5T7knRLNLTeNl39zxKL1r6ByQVV55/g37?=
 =?iso-8859-1?Q?9DBA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1729a02-25a8-4ca8-91b7-08dc8adb3724
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 12:28:50.7096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXqe2V+1ZJLoB94zKAVwbdmLGktPikPKmlY/zmV5KvpGyOBj1KYLiZHZOWerwQa52B8WIB+8RpYO126NDBFW7rRs4u2wxOG5l5gU+vJa9fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1805
X-Proofpoint-GUID: 9orwcUCoaD2lZpHwY_DxkJ6rN09b5aq7
X-Proofpoint-ORIG-GUID: 9orwcUCoaD2lZpHwY_DxkJ6rN09b5aq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120090

Hi Jonathan,=0A=
=0A=
I'm sorry I am not able to find this patch in togreg branch currently.=0A=
=0A=
Am I not looking at the correct place or there is a problem somewhere?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Sunday, June 9, 2024 12:09=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com=
>=0A=
Subject:=A0Re: [PATCH v4 0/2] iio: imu: inv_icm42600: add support of accel =
low power=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Wed,  5 Jun 2024 19:59:47 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Add accel low power support, enabling use of lower ODR below 12.5Hz.=0A=
> =0A=
> Add new sysfs API for controlling the power mode and enforce power mode u=
sed=0A=
> when using an ODR that supports only 1 mode (ODR < 12.5Hz or ODR > 500Hz)=
.=0A=
Applied to the togreg branch of iio.git and pushed out as testing for 0-day=
 to=0A=
poke at it.=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
> =0A=
> Changelog=0A=
> =0A=
> V2:=0A=
> - fix patch missing Signed-off tag=0A=
> =0A=
> V3:=0A=
> - make all ODRs available and switch power mode automatically for ODR sup=
porting=0A=
>   only 1 mode.=0A=
>  =0A=
> V4:=0A=
> - prevent power mode setting when the ODR is not supported=0A=
> - return the actual power mode when sensor is on, otherwise the requested=
 one.=0A=
> - add sysfs ABI documentation=0A=
> =0A=
> Jean-Baptiste Maneyrol (1):=0A=
>   iio: imu: inv_icm42600: add support of accel low-power mode=0A=
> =0A=
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   4 +=0A=
>  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 124 +++++++++++++++++-=
=0A=
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  27 ++++=0A=
>  3 files changed, 151 insertions(+), 4 deletions(-)=0A=
> =0A=
=0A=

