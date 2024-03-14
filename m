Return-Path: <linux-iio+bounces-3525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D2F87C177
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 17:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7386E1F21FB3
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14127353F;
	Thu, 14 Mar 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Z/UtLXS9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9953E7351E
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434700; cv=fail; b=fOGIqIe4Dv7ODev7/LmBC46/dvccWjDAc77xu/1A2EI6MFg7jc9I20fS484qJT24uo5Otp28CHM+Ld+Jcb95lk5PT/qjBao44L5YpAfZVUkBU6Mdki+TMLzXJtgDhqmP3gxKt9tnEZ5VuMumol0zzWSAMTQ59xxogbszm+XGWZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434700; c=relaxed/simple;
	bh=7WyVtiSOIf7LgPO0rdyE4XXq5zKiYCMYlXCPeC3FlZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LzJkL/YxPEuP9kMMWgF0003DXBwWqyA8JRDkXFvSlbrIHPXSKnM2SLwqCU241ukmedHaBhyjuHlXMmJ/akWkF97tJm+7pNpVubwdO6GvARw4eQj0/Moq7yy4oXMAFC2JQo7f1xY2f9OTOiooYgvsvmgOGOBKAoTbyMMA+QRxZA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Z/UtLXS9; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E8ox5w017131;
	Thu, 14 Mar 2024 16:44:29 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2169.outbound.protection.outlook.com [104.47.11.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wrh4j429x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 16:44:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONysB3BrKT9kdqBjNI3jt9LXpEf/w7WMOPII2Ce9z8uksDeeg5HaaQ8H1oHucapaaJgube/dp80VmM4rWv3GUBnKXyXlpFyf9zQIrT9ClcQMkLz/SFoUSqTNK6QreqPaHJmaTwDkcS07319Ui/zLvmLuyJYDp4jcf0UDmBNUX41aA6RkjBr8S8IOdnGddqA+sHFsllQEoyF4jU9h39h9NV+Ec7OUmHwlh0ahuB+BgRWAh+KO+3kwoyASECxZ9KIO+jDqFl9vgFkbSXryTLrhWdaL/x6z3f8c4oe+QMo3dCN1/IBinySYIISu8Ql+qKOMzpwDXPAXyXMScPKkKghYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icDN2T+gyAbNJEaeSxfGgiW0wbEaeqYdYYsnuU0ZhgU=;
 b=Q1L3dBFH1YD2pvgjKaKM9jBl+v/fj+y9WAY3wMJm36ZqJlpVe92C35BvY1B2tB5rclNk/vfibUzNyQIUNMmW2xKMcj9jDWsYPpO6wKqt86s/MVLo8d8hfGhJflwvWMadiIhUTSIOCV9PcJvao44Znr64Jyo03M5UoDjErbmpBed8XSUOKbZkpUKT49UZ7a0HMk9nCrLnKGuV9RZ+fU8pac6sMICMTKH+2MQFBOSI2gDCDBhYGjzPAtLjNop25XdffgMIPlgiPb9cuJoZIK9WPV6dOr/XDz5pZ3LYapYoLveec9LzP3eujvzLc+k4rHc7ya5CZzE9h24vCMyOcvmBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icDN2T+gyAbNJEaeSxfGgiW0wbEaeqYdYYsnuU0ZhgU=;
 b=Z/UtLXS9s42IKFEXWvngakZ3ZBX/XP8crwRT/dVIb6L4Q/mQC7+m6cn/nLRDuv6fd5FI+PHlxEl/EmHhQBRfKL0UYOSbcFtmfKJW4M7MiUJzyKD1/l7OrEL87ZUF3IU3FmKykxpYMT5sG4642OofNwHYstdKbWy2p5XpWK548BIKxaKxzP0jHocotDPDsEtnRWrf1p8k/BimTzkcFTHJNZz/K9W0EsKBJBKAGXP1q4vtDLZf0GtIoZtEEdJjoR4e2kHZSCg2MjOQqKbfyy5KGKsCVZd0vBYHydweWKpF6oEMxjf1j1pdYsbFYyjaGf8ML1dFlJsp1Zjsqn3RPlnoUA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR4P281MB3936.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 16:44:25 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ed6d:53c2:7987:ea18%4]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 16:44:24 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: imu: inv_mpu6050: add WoM suspend wakeup with
 low-power mode
Thread-Topic: [PATCH v2 4/4] iio: imu: inv_mpu6050: add WoM suspend wakeup
 with low-power mode
Thread-Index: AQHacWrhGCnfq07WOk+C2mA4kWuckrE3W6QAgAATdYQ=
Date: Thu, 14 Mar 2024 16:44:23 +0000
Message-ID: 
 <FR3P281MB17573CB0387765756C5820A1CE292@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240308151023.379705-1-inv.git-commit@tdk.com>
	<20240308151023.379705-5-inv.git-commit@tdk.com>
 <20240314145230.4fb5fc86@jic23-huawei>
In-Reply-To: <20240314145230.4fb5fc86@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR4P281MB3936:EE_
x-ms-office365-filtering-correlation-id: 14a05d21-3664-4fc8-167b-08dc444600d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /JeKS2EVF0DW4P3Umtm2BdQ7dIVJzFZoQ1tVAo33SuomgIQHAA4MIGYeqQd5H1sETg+VhTjB8ES2wcPHdncY/ZNhtnblL37X2ajfnMd/CP0GyyK2vkOrGJyCdRyvTkj5MqFy1fes5VBHPVNORpjE6s1eNfD9v62Z8EJ2SrR6zg1/vOGIj5qpyNQsmkQWyO8b9H5iGIu6r8q7wZKRE+oEnFN+SXjHqLWMH5DF3EiRX0G99MlPsei/mAboU/sWvaCp5mY+IK5HnkWiaklHTWYGYKtZqRni2c2clVUn7DRfOeBAuMSuAyhqdClvJzinhwqXFqklTOI3qh/P6awasbI7+8YUa5dGQE7gX93sg1W7Om0DQNGVT/HIeLVmM7xP63dmRlSzooO7JKrtdiQ5TkEu+P8rHDVJpYj8IDx+56MVruADHWTbK8KNZKY4s1MnEs+l407Z605jQ244T634o96ejuko6LG/vFG+gz1NVR7Q+K4vT9ulCzpcQmbtXj9IqIaasdBKsyqwKSejKICPLR8q1kjAwjX6NpfsO4RXg8X5PP/EhUhB86bgV3BfUaNSKFP3ndkQ/5DHZeUHTUYz6S8buRjDoaSnDMIDUplONWLFGRwBmrZ5/R19UoXI/CMSgnqkOi3chvwN0kaog/+LmLsuvrfsoI4jN6u7HAXgLwb6TqJ8oKFXV7CgtTYeu+HBvACcQdrrsXlIvcR2ORfHucew4dejA7lLXrjsVh3whJl5ucitf5/rzXGkQxgI2Sb94TEz
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009)(3613699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?UJI8fPgEOb6g69rss3UDBTlZI+WwJfRY1FFNa4Hx2Qx/oahusWqyhfJD67?=
 =?iso-8859-1?Q?s0n9BE/8zSYaXe33k3eO2Erg07TdA4lqY5BY37j5MpxQSgTO5Xj9N0lcTu?=
 =?iso-8859-1?Q?sxLWi79zt8QEdE7Q2JDccEB/cjJUcwWCtisMF2WobAZLzF86zyrQYGS6v7?=
 =?iso-8859-1?Q?NsBpPJX26rDbChswZ8t62bOW9YQIaR1tnpkjS+D6PNtHLLhRk2PQxp7/GU?=
 =?iso-8859-1?Q?5Qa7eTnembnYAIYhudj65lBegQpoXQEfazjAC0qbwv2o1hwVYCX73hbhM1?=
 =?iso-8859-1?Q?StTtN/7oTQaZD1C53VltzguG1G1c2LCLZf51q9jWzOs/7JNaBgV8qoijHv?=
 =?iso-8859-1?Q?9s3bkFhn/fMGh91AujBgJbObcFnRGlqM9Qd/aIqAr4AWiqKknxThJf4085?=
 =?iso-8859-1?Q?JZ1wXiP5U+v6sfhBgMO4R30U9WAEOvhUuH7+0OCGjS6fm+bINHlw4jT1ya?=
 =?iso-8859-1?Q?ZW6v+2O/Yo/jkxfgmVr3zQsb22sfFmYUV2AkHIZxaAFy+59d9T4Db9VnXT?=
 =?iso-8859-1?Q?X7XSroUxpPWvFZRYRyt+P4KAJ4+v3Djdq2l/tN/yDykHCugfC/DUebMdLw?=
 =?iso-8859-1?Q?m1/+NTDxdNReZDoXoMl/zLkWoDWT2DXWO1j2fkX9yrd1rQ+cz4C4bKvmC6?=
 =?iso-8859-1?Q?h0Okvyt7MXCVx8r9uvQDMTU/niWuB7dXTyzOTUE5AWyFuwx3m0rKfa09Il?=
 =?iso-8859-1?Q?uw7kErt5mpaaOs4bDAgg/YBQ1Ie+B7TbLrxMUBz+IVocERunURpOij2YYF?=
 =?iso-8859-1?Q?rEtXJses9kQ8wWWGEqYu3iOtk1uxH1b+Kr0y5VjMuY0xWFlRYeKS3kz1BB?=
 =?iso-8859-1?Q?veWH5oobe/NSxwq1FWFWigq7WzrDaqR3PiPdE4KwZPxKulQar2T5rBZheY?=
 =?iso-8859-1?Q?XCmUAlqTYI7XHZbIYX5LyBf95KuW20Wd/nmI7Gre6MSHLrQyaCjRQXHyeZ?=
 =?iso-8859-1?Q?K1KnTCo8SQC8c0H8RJ/HBmc0PTJMOtaKuwN0Msm+LKjILn0DX21lZPloc9?=
 =?iso-8859-1?Q?mXP5t+pP0nmSpIf7/T95LYcX7PvsJO3n5Fia3Vg56CmZXkivSsbMhNTutF?=
 =?iso-8859-1?Q?6ZQlyKssuHbbI/+JmvSHUTtziMUlsc/cCviGjLuhtNnBdmJlD/9S8okTAv?=
 =?iso-8859-1?Q?Th+mJ0fTUfzboDATWnp2pB4xQTGEbYw6KF2ZTkkRT5cM9NUIe/5BfhgRZs?=
 =?iso-8859-1?Q?bKeuDoDlXyDsbma1zQFDA3B92PHSAC9Fhx16GZjle0jv5zJBWWiKq2HoI/?=
 =?iso-8859-1?Q?ICLa9HLMGO6pVeZl9j7DF8ZSpDNqxUnG93satkfuDyqJ9a8CAtR3KIPgC0?=
 =?iso-8859-1?Q?tK+ulStrNlG26htWB38obr3C92kcw1rymgZKaO0MgSnEYDWYA/eXREl6dp?=
 =?iso-8859-1?Q?uz+6RT9GX4m374eCPBmPhryithNoEmjRB9mW1F8UgsgpH4EumNCNJmryhK?=
 =?iso-8859-1?Q?qV9lb9TKuqIkzUBloAgJ8YRUFy061Qmu2p8UE3B7/RxvIxnnivHiwIlIk/?=
 =?iso-8859-1?Q?OhcktQTm/PIJ7wQfGJ2VMaTVB3J6wFjGvTXkpsnwaOVqioh9foeQA1oEE6?=
 =?iso-8859-1?Q?QNaNgnoA+jEqbkk4NAbka3Wf3NqxI6cbGAlnrSWeEMUzMR5P0KrN6UIRF2?=
 =?iso-8859-1?Q?tsnBo+lt6mJ4k2I6rhZuQFCrKUDaXAHOV6VXTi7Hgyp9q6t0FApoY99GYb?=
 =?iso-8859-1?Q?1qZ+IgNe7q32ocVZzc5OvOEQFAv45o0pnbvR/JaBOiw1LL/rbrv1fznnKj?=
 =?iso-8859-1?Q?dt1w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a05d21-3664-4fc8-167b-08dc444600d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 16:44:23.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVM3u3FnoRtrdN7TRZ/cXgftlvDDirbkWDtxJrhovCqNh4ZFN/VUxttCen6vYOuvYEr+EJ3GUVvYJuMs2eWdG6BKDpWGEqSAGFTicTYExeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3936
X-Proofpoint-ORIG-GUID: OM-89RmjAbIzfhMXHr7EdRIU6shlAZbf
X-Proofpoint-GUID: OM-89RmjAbIzfhMXHr7EdRIU6shlAZbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403140126

Hello Jonathan,=0A=
=0A=
I already issued a V3 of this patch.=0A=
=0A=
I have switched to guard(mutex) in the V3, but too bad I didn't get your co=
mments sooner.=0A=
Certainly, we could use BIT() macro, but I didn't want to change the other =
defines or have 1 BIT() in the middle. But do as you prefer.=0A=
=0A=
Thanks for reviewing V3 of the series and for your comments,=0A=
JB=0A=
=0A=
From:=A0Jonathan Cameron <jic23@kernel.org>=0A=
Sent:=A0Thursday, March 14, 2024 15:52=0A=
To:=A0INV Git Commit <INV.git-commit@tdk.com>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com=
>=0A=
Subject:=A0Re: [PATCH v2 4/4] iio: imu: inv_mpu6050: add WoM suspend wakeup=
 with low-power mode=0A=
=A0=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=A0=0A=
On Fri,  8 Mar 2024 15:10:23 +0000=0A=
inv.git-commit@tdk.com wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> =0A=
> Add wakeup from suspend for WoM when enabled and put accel in=0A=
> low-power mode when suspended. Requires rewriting pwr_mgmt_1=0A=
> register handling and factorize out accel LPF settings.=0A=
> Use a low-power rate similar to the chip sampling rate but always=0A=
> lower for a best match of the sampling rate while saving power=0A=
> and adjust threshold to follow the required roc value.=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
A few comments inline, but nothing significant that needs changes.=0A=
Not sure why this didn't send the other day - just found it still open :(=
=0A=
=0A=
Jonathan=0A=
=0A=
> ---=0A=
=0A=
> +=0A=
> +static int inv_mpu6050_set_wom_lp(struct inv_mpu6050_state *st, bool on)=
=0A=
=0A=
You could just split this given almost nothing shared between the two branc=
hes.=0A=
=0A=
> +{=0A=
> +	unsigned int lp_div;=0A=
> +	int result;=0A=
> +=0A=
> +	if (on) {=0A=
> +		/* set low power ODR */=0A=
> +		result =3D inv_mpu6050_set_lp_odr(st, INV_MPU6050_FREQ_DIVIDER(st), &l=
p_div);=0A=
> +		if (result)=0A=
> +			return result;=0A=
> +		/* disable accel low pass filter */=0A=
> +		result =3D inv_mpu6050_set_accel_lpf_regs(st, INV_MPU6050_FILTER_NOLPF=
);=0A=
> +		if (result)=0A=
> +			return result;=0A=
> +		/* update wom threshold with new low-power frequency divider */=0A=
> +		result =3D inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_thres=
hold, lp_div);=0A=
> +		if (result)=0A=
> +			return result;=0A=
> +		/* set cycle mode */=0A=
> +		result =3D inv_mpu6050_pwr_mgmt_1_write(st, false, true, -1, -1);=0A=
> +	} else {=0A=
> +		/* disable cycle mode */=0A=
> +		result =3D inv_mpu6050_pwr_mgmt_1_write(st, false, false, -1, -1);=0A=
> +		if (result)=0A=
> +			return result;=0A=
> +		/* restore wom threshold */=0A=
> +		result =3D inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_thres=
hold,=0A=
> +						       INV_MPU6050_FREQ_DIVIDER(st));=0A=
> +		if (result)=0A=
> +			return result;=0A=
> +		/* restore accel low pass filter */=0A=
> +		result =3D inv_mpu6050_set_accel_lpf_regs(st, st->chip_config.lpf);=0A=
> +	}=0A=
> +=0A=
> +	return result;=0A=
> +}=0A=
> +=0A=
>  static int inv_mpu6050_enable_wom(struct inv_mpu6050_state *st, bool en)=
=0A=
>  {=0A=
>  	struct device *pdev =3D regmap_get_device(st->map);=0A=
> @@ -1847,6 +1933,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
rq, const char *name,=0A=
>  			irq_type);=0A=
>  		return -EINVAL;=0A=
>  	}=0A=
> +	device_set_wakeup_capable(dev, true);=0A=
>  =0A=
>  	st->vdd_supply =3D devm_regulator_get(dev, "vdd");=0A=
>  	if (IS_ERR(st->vdd_supply))=0A=
> @@ -2012,16 +2099,27 @@ static int inv_mpu_resume(struct device *dev)=0A=
>  {=0A=
>  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);=0A=
>  	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
> +	bool wakeup;=0A=
>  	int result;=0A=
>  =0A=
>  	mutex_lock(&st->lock);=0A=
A very good case for using guard(mutex)(&st->lock); but that can be a futur=
e series.=0A=
=0A=
> -	result =3D inv_mpu_core_enable_regulator_vddio(st);=0A=
> -	if (result)=0A=
> -		goto out_unlock;=0A=
>  =0A=
> -	result =3D inv_mpu6050_set_power_itg(st, true);=0A=
> -	if (result)=0A=
> -		goto out_unlock;=0A=
> +	wakeup =3D device_may_wakeup(dev) && st->chip_config.wom_en;=0A=
> +=0A=
> +	if (wakeup) {=0A=
> +		enable_irq(st->irq);=0A=
> +		disable_irq_wake(st->irq);=0A=
> +		result =3D inv_mpu6050_set_wom_lp(st, false);=0A=
> +		if (result)=0A=
> +			goto out_unlock;=0A=
> +	} else {=0A=
> +		result =3D inv_mpu_core_enable_regulator_vddio(st);=0A=
> +		if (result)=0A=
> +			goto out_unlock;=0A=
> +		result =3D inv_mpu6050_set_power_itg(st, true);=0A=
> +		if (result)=0A=
> +			goto out_unlock;=0A=
> +	}=0A=
>  =0A=
>  	pm_runtime_disable(dev);=0A=
>  	pm_runtime_set_active(dev);=0A=
> @@ -2031,7 +2129,7 @@ static int inv_mpu_resume(struct device *dev)=0A=
>  	if (result)=0A=
>  		goto out_unlock;=0A=
>  =0A=
> -	if (st->chip_config.wom_en) {=0A=
> +	if (st->chip_config.wom_en && !wakeup) {=0A=
>  		result =3D inv_mpu6050_set_wom_int(st, true);=0A=
>  		if (result)=0A=
>  			goto out_unlock;=0A=
...=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h=0A=
> index e97a63ad2c31..6ba9d42b2537 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> @@ -304,6 +304,7 @@ struct inv_mpu6050_state {=0A=
>  #define INV_MPU6050_REG_PWR_MGMT_1          0x6B=0A=
>  #define INV_MPU6050_BIT_H_RESET             0x80=0A=
>  #define INV_MPU6050_BIT_SLEEP               0x40=0A=
> +#define INV_MPU6050_BIT_CYCLE               0x20=0A=
>  #define INV_MPU6050_BIT_TEMP_DIS            0x08=0A=
=0A=
Side note but why don't we use BIT(x) for these?=0A=
=0A=
>  #define INV_MPU6050_BIT_CLK_MASK            0x7=0A=
>  =0A=
> @@ -335,6 +336,7 @@ struct inv_mpu6050_state {=0A=
>  /* mpu6500 registers */=0A=
>  #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D=0A=
>  #define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0=0A=
> +#define INV_MPU6500_REG_LP_ODR              0x1E=0A=
>  #define INV_MPU6500_REG_WOM_THRESHOLD       0x1F=0A=
>  #define INV_MPU6500_REG_ACCEL_INTEL_CTRL    0x69=0A=
>  #define INV_MPU6500_BIT_ACCEL_INTEL_EN      BIT(7)=0A=
> @@ -451,6 +453,18 @@ enum inv_mpu6050_filter_e {=0A=
>  	NUM_MPU6050_FILTER=0A=
>  };=0A=
>  =0A=
> +enum inv_mpu6050_lposc_e {=0A=
> +	INV_MPU6050_LPOSC_4HZ =3D 4,=0A=
> +	INV_MPU6050_LPOSC_8HZ,=0A=
> +	INV_MPU6050_LPOSC_16HZ,=0A=
> +	INV_MPU6050_LPOSC_31HZ,=0A=
> +	INV_MPU6050_LPOSC_62HZ,=0A=
> +	INV_MPU6050_LPOSC_125HZ,=0A=
> +	INV_MPU6050_LPOSC_250HZ,=0A=
> +	INV_MPU6050_LPOSC_500HZ,=0A=
> +	NUM_MPU6050_LPOSC,=0A=
=0A=
Trivial but no comma needed on a NUM type last entry as we'll never=0A=
add anything after it.=0A=
=0A=
> +};=0A=
> +=0A=
>  /* IIO attribute address */=0A=
>  enum INV_MPU6050_IIO_ATTR_ADDR {=0A=
>  	ATTR_GYRO_MATRIX,=0A=
=0A=

