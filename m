Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263F63497BB
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 18:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCYRSO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 13:18:14 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:29282 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbhCYRRw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 13:17:52 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12PH8NUr012501;
        Thu, 25 Mar 2021 10:08:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=VQwFF06ebkAQw9HYc4DdSov5dDWKf5GHuq6a5i9s3Ds=;
 b=M74G4lOqiP/hverfpckVagVTAIFGB2B1GSHQ48YtzrhtothhzqXSedQJxWvDn2n9WHoa
 0EX+pmA+h/MkPuxBVRciPmGuPYKv0ZInSt416dNboAo3sgJdzpQicczHZuSHgxTCsIsG
 P3adKd4Jqf0/4jVbKTpOFacpstJ2HNdplJCiwaT1F/q57DCH8UsosNgJ1b7AoiWawE9T
 1thN9aI03533il/n/mR2xDWmQl/GCujJP45DpeQTJ89Fhe6XGytif3GqvSw8hmvdWfK+
 cu1wfnvU/t8qCp+kWXV0Gqa6uYOZxkgZwoVgrRCWtqIZcTGK5b0Uqr9ROJxdf0yOwsAg +Q== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0b-00328301.pphosted.com with ESMTP id 37dd0nbcjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 10:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHFBJcqV9iSzB59xHnOv1yKW0tqZgRsL1Yf2lNpV/BsJVGYTtOZdbbRNFmjfNKqkiBjtiEOsE+DVJ5GyRGTYhOcq8R/Q/dq2HMqSbi7SL53iKgrMfdaUh2MRiFWXsZ1QRG3YYexxbmV5nk2hSGH1Gtr/qmF9IkRUhy5wEu1Ee2U6kf2DaQO0E2YkQc6ADMu4bJNPvxX4yiKldwlqmom/+SynuclI6MxZZZT5Hwd9+Mqflawjz9GtXbvAKYHbeHC2S8qL0vLVT8k+f1l0nBrsANGLDODjnYzglwiPOK/WqKG/2udB+NiRI2q3Zm4Yt2HP1ynZ6XnHDeNuOG1gBvF9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQwFF06ebkAQw9HYc4DdSov5dDWKf5GHuq6a5i9s3Ds=;
 b=oSOegTlNd7LlXiT+Tv2moeTpf5hC8t+CNcGywuA4wefGHhZLOuUiHf0D4kirn9Wt9Qn8piGTOBtRaQofwk2ej0MlC6Q+kdS66zsnfuamzWxenQmEhcgbvbDUpiCZOnzdClEv0hu4bksmqWuh1a+Unpk2S5Dgr52vZ8LoE24FVZsqdgHVKgkPOOUHAlbmMkCshZj/7+9DavnI7bEm+jfKeGksC6tYhRchZkDY9CJTtrASH6//ZOcArpDqRXaljvUaN9zYdXyL8p6VVMmDvul2+exoYbJSGZoALTls3O1v82dTeC+qrnmtOuSxLdz2mEhqXfvKsGC97X/oRtcLiAfp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQwFF06ebkAQw9HYc4DdSov5dDWKf5GHuq6a5i9s3Ds=;
 b=jW2dATmqpKZVGK9AM1TClufyVV8VCWGX07UAaRJUjvLZYDgGh/wrgzAKjiEQ76xyhTsQHpmafr+h8OGd6pybVB8rGse75d9hfFqiFjz6hyR8VXHjR80zg4fadPoE7tovW6UXp3VzqSIvUY7W62kATil/Z1WjanaJeAAJv+UeUpk=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB3664.namprd12.prod.outlook.com (2603:10b6:208:159::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 17:08:19 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::a408:8724:ea62:dd38]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::a408:8724:ea62:dd38%4]) with mapi id 15.20.3977.024; Thu, 25 Mar 2021
 17:08:19 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Use as standalone trigger
Thread-Topic: [PATCH v2] iio: imu: inv_mpu6050: Use as standalone trigger
Thread-Index: AQHXHx6pYrhS2lWHdk604AKHwe1RaaqU88ER
Date:   Thu, 25 Mar 2021 17:08:19 +0000
Message-ID: <BL0PR12MB501168E715C96BBDF34D1ACCC4629@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210322132408.1003443-1-linus.walleij@linaro.org>
In-Reply-To: <20210322132408.1003443-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f78556e-981a-49df-bfb4-08d8efb096e3
x-ms-traffictypediagnostic: MN2PR12MB3664:
x-microsoft-antispam-prvs: <MN2PR12MB3664B41FB09A7D5800DAAE4DC4629@MN2PR12MB3664.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30ClTcJ4Y3eanODdG3d3xQLDVvwQ+7I4cIoe+lbDpcwE5zPggSBZEWcmGv34MPW8Nb+XDH1ko83zmPeYLccCollSruepSqyxyjSdFUDYVbzfMBmUYPF2VPhVRpeyZNf/9qpdgSOqDpdaSytqNko6Fq3ofH1A5T4Fs/92FzdLxAsGhIonsWFKov4txpC14GOhwzp798Il28e9gJkP5gil7g8wR2vLCK/1GHE03/KbwToBQnGfxjDkcSeMTl0Ne444gEP+M1GsKYsudF5ohzOwm655LO4FqH4+3rHNOwUGM/eqEPDqT42pmXwn6I7/xxtuSgzUOxsB/UJ5ZGt/vInvO7sjmOdDMOQsNjMlcvsVLEL4Ar1WoGwjnvR+o1uBa4pl8UdmFyRDPBY50ck+K0DActfWZAWV/ndqY1PKZTlqaahW2+6LdMSEXndJGXtly3f5Q98Ak4NCL3xwCH0zhU2sSuBs7VtEw5CMvfYSxDZcaVmsrIEzXZJMdo0OeRYz+j1WphecVeNlrwBoGDh8JZZ4iu/PTajiVktdSBolndiw4O8OO8wjYKoFG4/4x7M7Q8VzlRMkC5wAIzJCgT0UahrRz0ZDtKzThCr9LxyEXIT9V9zcan/1X5fY/GsgYXQsDWWGiZzueeB/sI9TcEyxdJqCqgFQqUMh+ZUoWxVgnFSsJFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(366004)(39850400004)(6506007)(316002)(7696005)(8936002)(4326008)(53546011)(71200400001)(478600001)(8676002)(52536014)(2906002)(55016002)(110136005)(86362001)(54906003)(38100700001)(64756008)(76116006)(66476007)(66556008)(91956017)(33656002)(66946007)(66446008)(9686003)(5660300002)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?+e8u88yMWig/wOAkzV4NjBItdorqsYY5FrKVHW9lMjLEJjoLMqiQc1ZEPK?=
 =?iso-8859-1?Q?Zpji6u1wqck/LyeY5Kgue5awN5/NoiUAMxK/3vhxNr8eQ5/nSKntW8jwi0?=
 =?iso-8859-1?Q?QD/c1G4SKbleBLUOzjsdEmJ1lDlFPjH3/pGU0LAXgjxQ9CRHgn2rsRyr9T?=
 =?iso-8859-1?Q?xvHhG3da4/gv2kLY4c24zqHWWtOoVeEvzi8gUtwDz1rwKWrXeAWbS7S0FJ?=
 =?iso-8859-1?Q?UPVNtlkCIUH3ZZ952ElRS0+lrtq3ZcbWAONyWgnepqcWC1RrNp/C+EyXPm?=
 =?iso-8859-1?Q?sfe4fwdVllpwfyYEfDTm4NI49Xr8Ix8WrfdnT3Z4kuupJJ2TO+8xjAfr/F?=
 =?iso-8859-1?Q?ZocxYvxvQ9ji5usFPvS38zU3PGcquKcX8xAzOFs2HPj079BddOwEWjCmZk?=
 =?iso-8859-1?Q?q6cePwnatfhagspcGc3dQmZIzI+fCbetFj8EFKU3WmRYQ6EqOsWkrmgaIg?=
 =?iso-8859-1?Q?ZDnYaghx9ARcgh9/qXV/TovR1RhEqjiMdtxcJ//g29fPVT9HKDulgXdUAS?=
 =?iso-8859-1?Q?wxUInvTCScZoaxLIqXevZzUvwLj9CZ9X01DvuipUCdmuf9BfpZSrV+GXwS?=
 =?iso-8859-1?Q?QAwVA3Z3xz2Dj44VQ+nmrw6sslKGRSVjqLnR1aE+SyyRfyP5xqcelsDGEX?=
 =?iso-8859-1?Q?X56G3MLowwNy3SPv33mLT9eV2u54jZWeGEsZMuIIwttom9+fDD46f7m9xf?=
 =?iso-8859-1?Q?Jl9HQ+8tQaFKCq93F+qtT7BKGjZNNAgq+YFYpQ9qkdi/fPNRU8Pev0ipli?=
 =?iso-8859-1?Q?9Fd3DMt9IBVrzIUgof8JC8A2Z7TusMdCZltWAR3uKzHlXreM0eJLJAFMO7?=
 =?iso-8859-1?Q?MNc68bpDlDgR+6/rE6UhMUt200DljGHEYixOuumfyalTgfg+Azpw6zpnNX?=
 =?iso-8859-1?Q?zEmzPy+v0o0MRZF5yBPrmzru/GaehFQPf5sCubHXI3H212VIGq4tu8gR75?=
 =?iso-8859-1?Q?JF8FzeUo3UD3bFOPIxiBeXvNY3w3wt55tEE2priDU8r8strdhFfoONGVL4?=
 =?iso-8859-1?Q?gTiHl8zPE4MYR4r3a4cJbhNZ3Hc6VIGdRYiMo1PQmgc6XmbuBqJMHa5FQk?=
 =?iso-8859-1?Q?2jB3oWMd3oP+SKxTlUvxDY7LfaZp2nJ+8opKZQQoLG/WuawpLd1WXyq7Z8?=
 =?iso-8859-1?Q?BAIiMcLsUotgzZmfWoWOyxkP3TwPAw7k6u8amunvOERgK9KZ/G+FaaDkwm?=
 =?iso-8859-1?Q?4vfAbaJWl9uNlsurSqFzSJ13FfRGJxhVfuAgUkt7TOufGXsKeCW3qhevKJ?=
 =?iso-8859-1?Q?wYM0AlDwThtZOxb0pOwwXGD/m/IHore5xz1696QknZo7+ttGIaE4HWvLR3?=
 =?iso-8859-1?Q?Rr5Kd5zHeNG3UmTHqaEOEPEm5l7DINLEYngRmk0ii6kXPbc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f78556e-981a-49df-bfb4-08d8efb096e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 17:08:19.7058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROBaKzEUdLVaheF83tZrDfMVlcax6lJT8XJyjDeUx2LFsxfYyiBMopxnyKRdm3zbreCmbThN2RER2DXtle9rI7Dwi1t4NUt0ajy4OPhAgOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3664
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_05:2021-03-24,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250124
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
looks good for me, thanks for the patch. Here is my ack.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
We're lucky this is working without any sensor running, it was not obvious.=
=0A=
On which chip have you tested that?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Linus Walleij <linus.walleij@linaro.org>=0A=
Sent: Monday, March 22, 2021 14:24=0A=
To: Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>=0A=
Cc: Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>;=
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Linus Walleij <linus.walleij@l=
inaro.org>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Subject: [PATCH v2] iio: imu: inv_mpu6050: Use as standalone trigger =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
It may happen that the MPU6050 is the only hardware=0A=
trigger available on your system such as this:=0A=
=0A=
> lsiio=0A=
Device 003: hscdtd008a=0A=
Device 001: mpu6050=0A=
Device 002: gp2ap002=0A=
Device 000: ab8500-gpadc=0A=
Trigger 000: mpu6050-dev1=0A=
=0A=
And when you want to use it to read periodically from=0A=
your magnetometer like this:=0A=
=0A=
> iio_generic_buffer -a -c 100 -n hscdtd008a -t mpu6050-dev1=0A=
=0A=
Then the following happens:=0A=
=0A=
[=A0 209.951334] Internal error: Oops: 5 [#1] SMP ARM=0A=
(...)=0A=
[=A0 209.981969] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Sup=
port)=0A=
[=A0 209.988925] PC is at inv_scan_query_mpu6050+0x8/0xb8=0A=
[=A0 209.993914] LR is at inv_mpu6050_set_enable+0x40/0x194=0A=
=0A=
This is because since we are not using any channels from the=0A=
same device, the indio_dev->active_scan_mask is NULL.=0A=
=0A=
Just checking for that and bailing out is however not enough:=0A=
we have to enable some kind of FIFO for the readout to work.=0A=
So enable the temperature as a dummy FIFO and all works=0A=
fine.=0A=
=0A=
Fixes: 09a642b78523 ("Invensense MPU6050 Device Driver.")=0A=
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>=0A=
---=0A=
ChangeLog v1->v2:=0A=
- Add Fixes: tag, this is the initial commit but I do not=0A=
=A0 think backporting makes sense, this is a non-regression=0A=
=A0 non-critical fix.=0A=
- Fix a nit found by Andy (return mask value directly).=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 10 ++++++++++=0A=
=A01 file changed, 10 insertions(+)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_trigger.c=0A=
index f7b5a70be30f..de8ed1446d60 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
@@ -11,6 +11,16 @@ static unsigned int inv_scan_query_mpu6050(struct iio_de=
v *indio_dev)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state=A0 *st =3D iio_priv(indio=
_dev);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int mask;=0A=
=A0=0A=
+=A0=A0=A0=A0=A0=A0 /*=0A=
+=A0=A0=A0=A0=A0=A0=A0 * If the MPU6050 is just used as a trigger, then the=
 scan mask=0A=
+=A0=A0=A0=A0=A0=A0=A0 * is not allocated so we simply enable the temperatu=
re channel=0A=
+=A0=A0=A0=A0=A0=A0=A0 * as a dummy and bail out.=0A=
+=A0=A0=A0=A0=A0=A0=A0 */=0A=
+=A0=A0=A0=A0=A0=A0 if (!indio_dev->active_scan_mask) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.temp_fifo_enabl=
e =3D true;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return INV_MPU6050_SENSOR_TEMP;=
=0A=
+=A0=A0=A0=A0=A0=A0 }=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.gyro_fifo_enable =3D=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(INV_MPU6050_SCAN_=
GYRO_X,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 indio_dev->active_scan_mask) ||=0A=
-- =0A=
2.29.2=0A=
