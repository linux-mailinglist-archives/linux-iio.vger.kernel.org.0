Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D25F6162A3B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 17:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRQSD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 11:18:03 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:5223 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbgBRQSC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 11:18:02 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IFwsgh001535;
        Tue, 18 Feb 2020 08:03:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=TUqj8wpPMy9YH9zwURemdCYF2XW0EXCfFubOGfGl4HQ=;
 b=LKRy8wJ/+o1rujkZ8G1U7vaLs3Ca/8GyO8/Hy2GwmeT2WcFVhu1WU2FTThZK1bGer5nX
 NtElAFtoWCzC/O72KuIAJ3tJ10mHbpOEtsxiQC3sz1XSp8UpsRGykys2kDWWdo5xhRyC
 Kvb7k7+PIOidD6aGVvWrZo+nlsuh8vNLM78eiZ9KT7Ure5WqJlO/1drwGGEd1nNWtA6T
 KToevzSHPDP7ZpjG9Uxm+vk8wtiBLRg1gTgtsQj5rUSW3EPkBshCkrSoaD2YGsloZh/5
 tyyWdyFeztOimeWqVG+eVejSpsb6q4W2aruix9TLzLytiYQ8SYqABmdhUmMA2KHSn93m iQ== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by mx0b-00328301.pphosted.com with ESMTP id 2y6dfss8f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 08:03:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd6fu5IK5BSDAZr4+Z43+6qb3Sfg6C5Y8sXeRgyyH+7wkdOYciZ9PqH8xr791faBa40gr2R39ch+WLZDnQDUSXxQ0KRqUprzv7KOx/UoKQLGgAzvH65alfcjgZBvmtAuOV1d2csZxiomUbCdT1Bt2ExZjcbV8sN2VW4js8z3xKyX2Y1a4x4NQPw8X2V/IgWx2kg5K7t2kEeX33Umn8ZmZet7GT3uLev2PS9trH/PEGmfZgCivCCAIjY9xbO+5CSwq/IWm/zALo3V22weIPunBPyW+NqbTlUAP0ydhMjnR6DJlV99W9g0Vyqe+aQaQwfkMDgtRB9o86hpjdBYGET57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUqj8wpPMy9YH9zwURemdCYF2XW0EXCfFubOGfGl4HQ=;
 b=gcNMnx6xJoLBPf7WoP/AfpqK1KsA5gMa3GwIHsXbFlDHwohqybV4xz/TuBJtEbFGlgzy1roUsa2BKAVdr4Y+1fHbfW1KolTaUwaNrfH6G/OotfuaeiXDReWmxTSt7tKY0gjySf4/z7TmmsrmYybLS9UJv5XitRphhpBbPcnm0ySD+t865uYCFVxNQv4WS3ll/2OYlRx9jMtfspHlvG32WrCwktAFjodbeehIk2PPUpmEPbt+iBOGjbLNRamcsIknKOZ8E7vMVDpkdkkNPLVEFAoP2SU2oytzAP/R2OwKUBS5rnEXSWo/A7dIYjYKcdiLb9ldWuQfqDGOgorMMGZAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUqj8wpPMy9YH9zwURemdCYF2XW0EXCfFubOGfGl4HQ=;
 b=Lj8m+nMivKrjh8ZIGGqp2dz5qQIacN0FmR5EFaSh8OkZuObZdWwJd0f7Z8yZsR4GF52UUgjINkp9u9SJSVu1uXeQEpzlNe9zyP3ij16ujIAMD4qvH9t9qGA2XQ74GoOKnVg6sfgHjsT4qzbHm1aiJYP98EbH8kBcy96aFbW5UZ4=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4216.namprd12.prod.outlook.com (20.180.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 16:03:31 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 16:03:31 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 01/13] iio: imu: inv_mpu6050: enable i2c aux mux bypass
 only once
Thread-Topic: [PATCH 01/13] iio: imu: inv_mpu6050: enable i2c aux mux bypass
 only once
Thread-Index: AQHV4cuhgOyeT/j6FkyC3hCRce9016gch4YAgASd1iM=
Date:   Tue, 18 Feb 2020 16:03:31 +0000
Message-ID: <CH2PR12MB4181C91F701528E7082E5AB1C4110@CH2PR12MB4181.namprd12.prod.outlook.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
        <20200212174048.1034-2-jmaneyrol@invensense.com>,<20200215173004.7569c210@archlinux>
In-Reply-To: <20200215173004.7569c210@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 673a1cd1-8441-4065-8530-08d7b48c1994
x-ms-traffictypediagnostic: CH2PR12MB4216:
x-microsoft-antispam-prvs: <CH2PR12MB42162B4057805E9BA2CF33B0C4110@CH2PR12MB4216.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(366004)(39850400004)(199004)(189003)(316002)(9686003)(66946007)(66446008)(4326008)(66556008)(6506007)(478600001)(64756008)(91956017)(76116006)(55016002)(52536014)(71200400001)(66476007)(8936002)(2906002)(5660300002)(86362001)(81156014)(33656002)(81166006)(53546011)(26005)(8676002)(54906003)(6916009)(186003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4216;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lWZTm3rKAhWf5AuU/Grm03wyZoL7dlkeH8xYuJGvPc6R0O7LbtZTFZDtV7XYE19WxBgXThMHylwO10yl3reX3/HXo0nkPJUNkQeMaf2t8leFTCTrfHUT7nDkCsploOrwlLz6w5RXrWOSfF1bydq4HlbcSAzrWVteepwMUB9r26MaXwuf5+ZXVsoS6rhZ8Xm2BVfC+OC6b7WardKFfMewU//cICqM08JILFR62jFi7/Rt3YyVb1OdjbEaUESjN4+EfFqY+d7G1mYaDY39J4bCMaqKMXlXusXq/MjDtR3ZaAY5H0FlPkeFIk+u7oAjGPjgDOwXGLWkbaJxKzkFkmCayW/2GpjeJTNP/g6Rn22ulGsG25TUEYa0NxqUGo6GcfDWpREPNSDflNJRIOplWjElh9uVpSkNTqbTpkGQ3dHw7/VUQ4NsYVVyIC2biyS9nMn
x-ms-exchange-antispam-messagedata: 7qguPHIgH5+vYo7vW0Ept8tN6nD8kmspUNbqtM6uj4QGPJGEtOUSK/UXAZ4dGgxGFQZlbMpNCCEzundCQ2xuS3FlK9yED1p4PmrjtoUhA8llqCoK5STURlaexxVSUuNcNQj5G4paq+EQymMmKceZ2w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673a1cd1-8441-4065-8530-08d7b48c1994
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 16:03:31.1066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBhNzxvHC5DOmS3fYkibzQNqUxilE3KGxVZhiO4GpZU38x5AA3fTFd9GFbHNOd7YLDOZvP1J+HCFSMUpQlbv83WYOPhaD5hh1A0Klz/5nzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_04:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180120
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
sorry first for the desastrous text formatting.=0A=
=0A=
The main idea behind is to be backward compatible with existing setup. Othe=
rwise using i2c-mux to do nothing is not very useful. But this way we ensur=
e backward compatibility and gain the advantage of not having to do i2c tra=
nsaction with the mpu chip before every transaction with the auxiliary chip=
.=0A=
=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Sent: Saturday, February 15, 2020 18:30=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Peter Rosin <ped=
a@axentia.se>=0A=
=0A=
Subject: Re: [PATCH 01/13] iio: imu: inv_mpu6050: enable i2c aux mux bypass=
 only once=0A=
=0A=
=A0=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
On Wed, 12 Feb 2020 18:40:36 +0100=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> i2c auxiliary mux is done by analog switches. You do not need to=0A=
=0A=
> set them for every i2c transfer.=0A=
=0A=
> Just set i2c bypass bit at init and do noting in i2c de/select.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Fair enough.=A0 Given we are making the decision based on DT and that=0A=
=0A=
can't change on reprobing etc so this change makes sense to me I think.=0A=
=0A=
=0A=
=0A=
It does leave us making rather odd use of the mux code, so I'd=0A=
=0A=
just like Peter to take a quick look at this before I apply it.=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 71 +++++++++--------------=
=0A=
=0A=
>=A0 1 file changed, 28 insertions(+), 43 deletions(-)=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_i2c.c=0A=
=0A=
> index 1363d3776523..24df880248f2 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
=0A=
> @@ -20,38 +20,6 @@ static const struct regmap_config inv_mpu_regmap_confi=
g =3D {=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 ch=
an_id)=0A=
=0A=
>=A0 {=0A=
=0A=
> -=A0=A0=A0=A0 struct iio_dev *indio_dev =3D i2c_mux_priv(muxc);=0A=
=0A=
> -=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
=0A=
> -=A0=A0=A0=A0 int ret;=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0 ret =3D inv_mpu6050_set_power_itg(st, true);=0A=
=0A=
> -=A0=A0=A0=A0 if (ret)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_unlock;=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0 ret =3D regmap_write(st->map, st->reg->int_pin_cfg,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
->irq_mask | INV_MPU6050_BIT_BYPASS_EN);=0A=
=0A=
> -=0A=
=0A=
> -error_unlock:=0A=
=0A=
> -=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0 return ret;=0A=
=0A=
> -}=0A=
=0A=
> -=0A=
=0A=
> -static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 ch=
an_id)=0A=
=0A=
> -{=0A=
=0A=
> -=A0=A0=A0=A0 struct iio_dev *indio_dev =3D i2c_mux_priv(muxc);=0A=
=0A=
> -=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0 /* It doesn't really matter if any of the calls fail */=0A=
=0A=
> -=A0=A0=A0=A0 regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);=
=0A=
=0A=
> -=A0=A0=A0=A0 inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
> -=0A=
=0A=
> -=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> -=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> @@ -79,19 +47,20 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> -/*=0A=
=0A=
> - * MPU9xxx magnetometer support requires to disable i2c auxiliary bus su=
pport.=0A=
=0A=
> - * To ensure backward compatibility with existing setups, do not disable=
=0A=
=0A=
> - * i2c auxiliary bus if it used.=0A=
=0A=
> - * Check for i2c-gate node in devicetree and set magnetometer disabled.=
=0A=
=0A=
> - * Only MPU6500 is supported by ACPI, no need to check.=0A=
=0A=
> - */=0A=
=0A=
> -static int inv_mpu_magn_disable(struct iio_dev *indio_dev)=0A=
=0A=
> +static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev)=
;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct device *dev =3D indio_dev->dev.parent;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct device_node *mux_node;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /*=0A=
=0A=
> +=A0=A0=A0=A0=A0 * MPU9xxx magnetometer support requires to disable i2c a=
uxiliary bus.=0A=
=0A=
> +=A0=A0=A0=A0=A0 * To ensure backward compatibility with existing setups,=
 do not disable=0A=
=0A=
> +=A0=A0=A0=A0=A0 * i2c auxiliary bus if it used.=0A=
=0A=
> +=A0=A0=A0=A0=A0 * Check for i2c-gate node in devicetree and set magnetom=
eter disabled.=0A=
=0A=
> +=A0=A0=A0=A0=A0 * Only MPU6500 is supported by ACPI, no need to check.=
=0A=
=0A=
> +=A0=A0=A0=A0=A0 */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 switch (st->chip_type) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case INV_MPU9150:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 case INV_MPU9250:=0A=
=0A=
> @@ -107,7 +76,24 @@ static int inv_mpu_magn_disable(struct iio_dev *indio=
_dev)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* enable i2c bypass when using i2c auxiliary bus */=0A=
=0A=
> +=A0=A0=A0=A0 if (inv_mpu_i2c_aux_bus(dev)) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_set_power_itg(s=
t, true);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, st->r=
eg->int_pin_cfg,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_set_power_itg(s=
t, false);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error;=
=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> +error:=0A=
=0A=
> +=A0=A0=A0=A0 inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /**=0A=
=0A=
> @@ -151,7 +137,7 @@ static int inv_mpu_probe(struct i2c_client *client,=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu_core_probe(regmap, client->irq, n=
ame,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 inv_mpu_magn_disable, chip_type);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 inv_mpu_i2c_aux_setup, chip_type);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (result < 0)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
>=A0 =0A=
=0A=
> @@ -160,8 +146,7 @@ static int inv_mpu_probe(struct i2c_client *client,=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* declare i2c auxiliary bus=
 */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->muxc =3D i2c_mux_alloc(c=
lient->adapter, &client->dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1, 0, I2C_MUX_LOCKED | I2C=
_MUX_GATE,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_mpu6050_select_bypass,=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_mpu6050_deselect_bypass);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_mpu6050_select_bypass, NULL);=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->muxc)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retu=
rn -ENOMEM;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->muxc->priv =3D dev_get_d=
rvdata(&client->dev);=0A=
=0A=
=0A=
=0A=
