Return-Path: <linux-iio+bounces-4052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3B8984F8
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEAA1C215AF
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443A7605E;
	Thu,  4 Apr 2024 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="DIf2I2lL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4374C09;
	Thu,  4 Apr 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226527; cv=fail; b=pfCJxz5sS/USuFapDLxhZN4W/i7mgeHCiwkSHmPVAILb9/72XegYBqFJ2yvmN8ymj69Uq3TJyrRQObNhMYCMm293MNgWrnKRAYGMioYju1kQkxyM4RuF2/3F+1o60dzUTTGR6eMNNhcoGVLNxw+p2QeErrLg/mdlZTIii4cbSHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226527; c=relaxed/simple;
	bh=L++Wv0j6yRb7XSXnsZXQHUEA+uFTzYt5vrq5Z885fAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lx8e4RfMVbmiopKyHGRLbcsnLhJlNv8Dr/lWekILxfczGdHY0zazu9dyD7cI1PEj5DYjm17VuYjmoNf0PZtMFZS33AetWFhaf41IX7Tkpbf2MMkUsqHg1psrfV1OuQ8pAlpgXC9WIGv2LvBQsjhv2BmDHXM3Aq9hqthELHMTYPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=DIf2I2lL; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433MuWaS006507;
	Thu, 4 Apr 2024 10:28:16 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2169.outbound.protection.outlook.com [104.47.7.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3x9ek7gfg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 10:28:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPmL6PVLWqKGyYEbub5TJ/xUMpoTLWzXu2v4czMbxd9K2fpLQ9m7JQ60TtReB/vSD7ZbkIbf7vx8oz0g6oiaAfuoWxr19L05/RQ4mj6bTQsZX92jrw/Cdlx/mI3OsfYPAN3MjBVzPLOjWUpevGHKUDvD9MPgL0bJOVMx8bhhRhd000T78AABvO6iR2Ue85AIkDpIbn1FyBY84xuSDZjmQggfgnRxoqc/wRQ11aSltpVEIrdzx3dxKMzN8gucjyK190TOVmbbvkpbO58IhR3F6aGvkbbnbPVmK4y3UZKQ2sSH0D+OpKZ5EZzCO6e6/9KKB4pU36fX9GBDmHg86bFuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ85zgp4iQDNT6L0NNrDUO/Q69B9WvT3KFvIzjhn3ME=;
 b=RvgI5QrVT38EJeaPQuua866Yx5covsEPskd811EqQRxRu/gGBCvOWw6yzVdf9wnSzoZFVPWQb6p0C+j3t87vfm8tRk8l1scvcsDcal3ZSRfUw06fY+bLS2O+ewoZDwsRL36x4HcK7LpbMadcLGhaXkycUSUV4jLVNLNkqm/+mS/rKLoqRiPV56RjJ8XmrtU8TYXq9YKtX4BfN8z8x3gYtldhRzb13T42mNtGb9TiKJOTLTEQSPo38Fn+scvV0+5tETVsazb6uWuTH3SYoISDur1jgLwi560SiDuA8YNEYC/Ax4waRsv4vlpAcKO+0LGVbaHUjJ6jOuqiSNsVc2z0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ85zgp4iQDNT6L0NNrDUO/Q69B9WvT3KFvIzjhn3ME=;
 b=DIf2I2lL3+rdLgSTxCh5ZJ4jOME2vQwK0KAyQm+rQ8Lp6YYAkScgE9tb13IK/gANMGmNAip+dXgbjalye2HplsrMvrZv6LHC3ZMxPPa5jdOearZgT5LUMQaUocnZbO984/4JyxdWghflSkk/lwPb31JUUrYKU+uxm3AumVQ0rUY17/5t6o3TTATRj7V/kh7S2TSmWaweaNWNJeSR6AdpTRycfyTw2x/7IAfL8GG39+mEfMR9HWDjk4l82y+RyWlhFyK23v66ihzff5WCWfRuw46suAqENT2q07Fag0X40ryHtjaNm7EUrmGztwU2RF4ziJXaIxX2yFZQ4BhhGkizcg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR4P281MB4042.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:fe::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 10:28:09 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 10:28:09 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        INV Git Commit
	<INV.git-commit@tdk.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: add icm42688 inside
 inv_icm42600
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: imu: add icm42688 inside
 inv_icm42600
Thread-Index: AQHahNxQA8UEZVUHqU6SqTwDjxfe5LFXsquAgAA4GGs=
Date: Thu, 4 Apr 2024 10:28:09 +0000
Message-ID: 
 <FR3P281MB175794A23F9A706C6E532836CE3C2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240402090046.764572-1-inv.git-commit@tdk.com>
 <20240402090046.764572-2-inv.git-commit@tdk.com>
 <beb68fc5-1ad8-4052-80c6-b706b62c267b@linaro.org>
In-Reply-To: <beb68fc5-1ad8-4052-80c6-b706b62c267b@linaro.org>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR4P281MB4042:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KRIRUPKDS5ZF0X3y7w+qhBHw2jxxHnB2Hho+6YyhbWsNxxBM2PnNuPSihOrht/4KeZinlkKVqlnd3UnPhOGX24xTtyEdAPG+IZZVD4KmCrUilajiGfCvWeNz49jW5/j3eceD1mRe9Svw06rwYi2Pi89hCFq1IaXDzfdCc5ValnFQL5y5tB9QFoKQTDYi4kgmmct6LZDoXvEUeYKnMHsOc503XbEbHVz1+m37xJrD2p0cgO9K/+L73InJIgR1wKlsTXO8S0tDNUWBlclAwL/oREv/ZtW4KRnlDdsASjNn9AnbTz0CvaV3pXfMc54bY7YtQyer9U8pqbteQx57tED2Aol/WtTsQNPc2uIjrs/92tNU3HqQnA27dcvRol00qCp8mNlo2r0geZ/1JsDgGAW8cpt0k7Zs2BX3SXT8U6D6a+28a/0K4s1CXzcZdhj1hsFFe2tvptIy5Q7gTXe7htmNhL57ARMOnByy1ikKzX6f1lve9y1Mbv4A2YPnAzJ1KOdKop+8mvr8BQ4XKExQxpYnZnxqELOIPof0kAoUIMT/U7qWOqD/FM0y5m2kDPbWhQcFDIbTaOIAMMkiiCssriMUUqhKGxt0qJf2Tgu/Gt5l0kA3EFvgooW7Ta54DQiw4AEXuG7cRd46Iy5PEkbBwUSiJnTzeVv2l9zF4eAsX1Exzvwp95rk6KoFjw0ol6oPMC6TJZrRo5j5YHknimV8hyHTrA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(3613699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?JMyIuZCdaarHx2gBa64wWbdfUpxUtwrtiA32Ef0NLvPyTGotuhk7u5hz/u?=
 =?iso-8859-1?Q?bzDmTXipgFLBc5NvU1/LVpLw/FQpifnXrDH1PIfxz0j2MTWBIH2jJD8cff?=
 =?iso-8859-1?Q?sipCyvDddVGaAycXLkn2zYcKb/mEVucInIsYGxQ9iKCdqGtJlXuD1iyrB2?=
 =?iso-8859-1?Q?TsKmyluGDwKfd8pYErBmLvDtS+iZQkbWlwFy8ZV+J75JxxGQcSUnEDwPDH?=
 =?iso-8859-1?Q?y7TjUIfF4Ir8J128v18C2hxsfsd2T9XmiJxug/JwhRSZrZm56ecUkCuALx?=
 =?iso-8859-1?Q?iJrCBDwF2SCpdLJN/ruOX6XT6k7LLB/+68rk6X/EB4co9/EzmqFmaZtM6c?=
 =?iso-8859-1?Q?mDKrQzFSgYsd541K/L7BjBNP4RabMcoXqRkMuXEuDkEL1O8nSK73M9PKN0?=
 =?iso-8859-1?Q?YZQPyjZG3OzbynOWHdTkJNhDmlgZAe8g0VPAvbm8kASw+bYW+s8Hvt/VUD?=
 =?iso-8859-1?Q?rsPsudUPmBYgxZf7dwBPtRoNQW7eh4Qxi43FgNJUApzKr8GLqDRfS6Ylrn?=
 =?iso-8859-1?Q?BjV0uRDPca/5gm07nbuNeKbndTanywMVdiYCw2JA1QtbYUNXskMM7x6tKh?=
 =?iso-8859-1?Q?4HWIvO9vMLD+TxWhdcxWjH4SqHEmCoZcju723Qs7L4vpdD6HinoyZfUUxg?=
 =?iso-8859-1?Q?3Z98Tk641HHmFoBg8VN1w3/rt+1nrCRTSJG9xV4gCCBx1WSXxYX9kMVOS6?=
 =?iso-8859-1?Q?jqxfn4Un+TjqZbtOtLIdlgwzZoWDz5bYmut0yJ/Oo+iojLK1WAi9eq681A?=
 =?iso-8859-1?Q?aRq4S0l47AAhkcTegIuqb1JlVOSHcD92TH6613lPhJkeBBU02h+2rxqH9N?=
 =?iso-8859-1?Q?dj0mvVA9WaQjo2k8eSQfbXEfeIp0xgIigIHb+YGeAMuRIqgG7OJu64uFBZ?=
 =?iso-8859-1?Q?SN3UezPR+RAxLaNYkBlFDtNHkeIMSV1KTF8KefG6NbE5KKrPPouMtXJumM?=
 =?iso-8859-1?Q?alWfZ46rL4UT8QWpeFfh5eBa/aCDSejaY9GO8o1PPC743tQVT912/tiujf?=
 =?iso-8859-1?Q?up4ZY1vnV39bMLEVSMCF/t98V8IlDrv4Oyw9H+vgE1+gLToGfAPAXyrpLV?=
 =?iso-8859-1?Q?NcxtI+AGomiLmR97KYIF9XfUQOmehD5k4wmsU7BD+dFD2okE546lb6vijt?=
 =?iso-8859-1?Q?dRcG6AMbrNz7e5vQsTjWyFwm9WFDJJh7kDJNgBC+H1Z1faYzyDzSnml15p?=
 =?iso-8859-1?Q?j0Mp3VToLMrbZgwAPz1B7YWHsHEz8yBiidej7G0DZSG6exw9Gg/IL+JooV?=
 =?iso-8859-1?Q?CqLRi7LnOGh0QWeR54n2eAOBtJWmPJsTINTA2aiZOgrPPgwOolWwCOKeSU?=
 =?iso-8859-1?Q?OeG9jFyJl6ISPPOFaCzoVWKmbESxeUdcS9fPMflRhX3UadWs4A++79+ZkO?=
 =?iso-8859-1?Q?CGoNLEGDsyv331owX4s7aQ4usKXzPFduMwIhVOjyBPADc89IRL73n1Nfyk?=
 =?iso-8859-1?Q?/DlE7tgjAEL3lt5dRme1nH8twitUNGUyxMSNe5jzqt7dm6AwfTcQU7BhyS?=
 =?iso-8859-1?Q?CYuBBm7EOfI+rMaXY03y4pbZiqy4u0p+RCDtNjSkx+/5HmBOA80uHHVnkb?=
 =?iso-8859-1?Q?P0G5Rfbs9bmMicgl75M5CH46OLwHUGImmkhD9h+7mEsKLprzaaCtQ7vQx1?=
 =?iso-8859-1?Q?LkK8XFv/yEUjDc6TsteilXvSnDlkS4z803TRvnNhm6me3obtKxshQ81g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02973304-a8ee-4a6a-0324-08dc5491ec53
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 10:28:09.1347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3+kKE8omSg6oumiExxYVVUAxgQ0llS32xk4nmwHoMXxqdeBdqvS1wOZcfZDdE6fVlj4GVnrtngf5c/JaJZQkFSmxk45FPLPe/cusvC0/g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4042
X-Proofpoint-ORIG-GUID: -huxLb7_-aME7Ii6GmnzTsVEO_cHRatT
X-Proofpoint-GUID: -huxLb7_-aME7Ii6GmnzTsVEO_cHRatT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_06,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404040071

Hello,=0A=
=0A=
sorry about this mess, this is due to a problem in mail system configuratio=
n.=0A=
=0A=
These patches are obviously not confidential. And IP from TDK-Micronas obvi=
ously is not applying to TDK-InvenSense products.=0A=
=0A=
I will resend the patches when the issue is fixed.=0A=
=0A=
Sorry for the inconvenience.=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
From:=A0Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=0A=
Sent:=A0Thursday, April 4, 2024 09:03=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>; jic23@kernel.org <jic23@kern=
el.org>; robh@kernel.org <robh@kernel.org>; krzysztof.kozlowski+dt@linaro.o=
rg <krzysztof.kozlowski+dt@linaro.org>; conor+dt@kernel.org <conor+dt@kerne=
l.org>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org=
>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Subject:=A0Re: [PATCH v2 1/2] dt-bindings: iio: imu: add icm42688 inside in=
v_icm42600=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On 02/04/2024 11:00, inv.git-commit@tdk.com wrote:=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Add bindings for ICM-42688-P chip.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> ---=0A=
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +=
=0A=
>  1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm4260=
0.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=
=0A=
> index 7cd05bcbee31..5e0bed2c45de 100644=0A=
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=
=0A=
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=
=0A=
> @@ -32,6 +32,7 @@ properties:=0A=
>        - invensense,icm42605=0A=
>        - invensense,icm42622=0A=
>        - invensense,icm42631=0A=
> +      - invensense,icm42688=0A=
> =0A=
>    reg:=0A=
>      maxItems: 1=0A=
> --=0A=
> 2.34.1=0A=
> =0A=
> TDK-Micronas GmbH=0A=
> Company Headquarters / Sitz der Gesellschaft: Freiburg i. Br. - Municipal=
 Court of / Amtsgericht: Freiburg i. Br. HRB 6108. VAT ID / USt-IdNr.: DE 8=
12878184=0A=
> Management / Gesch=E4ftsf=FChrung: Sam Maddalena=0A=
> =0A=
> This e-mail and any files transmitted with it are confidential informatio=
n of TDK-Micronas and intended solely for the use of the individual or enti=
ty to whom they are addressed. If you have received this e-mail in error pl=
ease notify the sender by return e-mail and delete all copies of this e-mai=
l message along with all attachments. If you are not the named addressee yo=
u should not disseminate, distribute or copy this e-mail.=0A=
=0A=
Don't send patches which are confidential. Community cannot take them.=0A=
=0A=
Best regards,=0A=
Krzysztof=0A=
=0A=

