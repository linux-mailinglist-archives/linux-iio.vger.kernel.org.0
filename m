Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82ED354E5F
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 10:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhDFIR6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 04:17:58 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:63642 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232355AbhDFIR5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 04:17:57 -0400
X-Greylist: delayed 1588 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 04:17:57 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1367mfgP008993;
        Tue, 6 Apr 2021 00:51:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=63VoceIJ8QaZAofXyYBRNfAaseFDQYnk4ag3wXgl36w=;
 b=K7++Vs5y5cGwQTisJQ/8bNGojG1+NM4zsFcfu2KqrzFvq9oUxT0FQAdpucuD/DiIRcF0
 luD+Ks62hWuAvuMwbHcEgQ2LY6sNVrkLIK7J8u5ttTV/wV63FQNwqcp8BKpJk/CbcRIT
 Gd0aUzpsL8C4ZJ9ei/pwOyJrYRBNP+T8rAp92hrhBiXV5vI00Yrc0nSlIwsXmW/PYGh8
 P0KC4mPvrSEuoYWI4BQ5RlYULzjPfBlKkhl31huGCsbqe1gxJYiCNHatstekn0vdgfdh
 TgjplQcJ1xVODgSBAJZR/D0s4YwECNHajHbFZSZyLBkJRhGTkCt+r6Aeq2SZ/zwvYLRS xA== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by mx0b-00328301.pphosted.com with ESMTP id 37q2ndh774-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 00:51:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwdryYndLQqnst++cM1/uzcxsP6FGKHiX7ehhgeNmd3Q9xmfzrC9w5V+5gl2QI9kxbDJhqw/WNegXlt7df7mv4nSGMt78ONVZ0YkAolqjtHcKW5grmGGWQJL3Dj7PWfamOUzrpJrELgzDj8HqKNZ6Fvr9SH+Rd87Vgd6etxeN1vX/XaXnR3sXuzd2R/uyn8jcpkvNJz34ol2cPp56sHHDnET8KBHc3HXxHZDqVo/TF6zcDj48SNEKkzScoKp/tqhbngF/RsMVOuVySu+Kkw2edg7jX0b0C89jIdVDaJq5jlFaXnVoPqstaZJThcD5AjQUK9lliN5X6cW5pYqkcrZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63VoceIJ8QaZAofXyYBRNfAaseFDQYnk4ag3wXgl36w=;
 b=ikgibeJOnf58+K/53NEFG+Lql//04PPHcQuNQ9pZMWFj84or2mzAwiGT/5TOpoYRRmYYg0SQvOCSSdI7ojazWRvM1tm2wtaLh2OmMGAp3FOT7iV4KUDxLog1lTT6V5+NbeVWreLjk9ieCKDp4N/0Samghxih5jqnX/hqWVO5oHG6lnUyvZcWn8e+oHWJwAD2+sKLjmhoPbBmH6BR9bc/M5nQC+sniJ08BoGjXvQ5N9UFPpGGifRE6jB/83ZIVGMBLOw+30Miof59a5pEuq5N1R2C2d4LxQaBKAcsPX+MCyrs/4pMTa2hmDln0EEpabKhp/4IxW+M3gX8CExKPTN5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63VoceIJ8QaZAofXyYBRNfAaseFDQYnk4ag3wXgl36w=;
 b=MOZfinigVbDhedWZ0krG8xcHhYcdcbu0i9vpGRLdxoCdmGGys6+oNpiwfYSs/zGnfGMIGYUvF37VTxmqh3MVosdcQ+/ROBdG72Cff81I+WSj0QOOrmTvTacKDpaxFQMgvMiO4GScWQcjwYA9HEqzFMQHGIOO1MKS0/hZiENSL30=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 07:51:05 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::a408:8724:ea62:dd38]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::a408:8724:ea62:dd38%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 07:51:05 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: inv_mpu6050: Fully validate gyro and accel scale
 writes
Thread-Topic: [PATCH] iio: inv_mpu6050: Fully validate gyro and accel scale
 writes
Thread-Index: AQHXKhEr6tDFF5kbDk6ETVQfcTvKyaqmA0oAgAEagm0=
Date:   Tue, 6 Apr 2021 07:51:05 +0000
Message-ID: <BL0PR12MB5011889BC549865552ECE88AC4769@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210405114441.24167-1-lars@metafoo.de>,<20210405155526.78ef4363@jic23-huawei>
In-Reply-To: <20210405155526.78ef4363@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 751541ad-3759-4fdc-ac7b-08d8f8d0bb77
x-ms-traffictypediagnostic: MN2PR12MB4376:
x-microsoft-antispam-prvs: <MN2PR12MB4376D0627ABFB6C4BF8A7001C4769@MN2PR12MB4376.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0RzK+LhLLMenq3YZgegK/3dIkAMRPvd1JPu80/gTJper4HT3DzLbmWhg3xBACpfoSbja2YBv0qVpP+L6p3OKhJ16TRKYcA1KIu/ozTWmjJsTuMlvd2zahwZHSXH9r5tuJx02jyCcuLqWXM+bOfPCNw7/k5d5CNutrrCFpdzcXLxnUXmqh1b+38l+LsJFf/QlhmUuG2JdMl+TckEWxKaGZHsCnV9gSk3bjsg50tJiTOfdMQddD0PG/jNR/Cqwav24TyOacEJSMTV9/bdxTj+UHm0u4CesvAYi2bXyLFbwm9GPJtiBJLZtP0wzOqQgWKv+9tRWVEI/YHmmnQC8HZwbqMPVvBevEbk49rloWxCJqrFWsgXzGsU2N0HpBBhW+4XXqBIOyyXhqw9fP/sPJYvD7PTFYuiraj9W+alnrCwR2e8CQMEQzIaNaUGpCwNBBvrUuPgPcAKREmR0d5qpLaT7s7Z2c9RNPgKBRnzZ8c6BKlbQ7/JJ3sY16CQuasXKDI82+pkefZbOJDjjyL8i94NLDZqpE3gRCnib3dYjRGUxoxd7IG5xD3ouE+M4ztRslWxfESBsHZ/2HOUzHXnnarh8X2TM6NMsxA5+FUBkfBBKfwnvzJW5xLlm3oMRfQ7Gv6O6IfE3ZOWAeAVhfw6/dCjIbc/1fdDdrMe/+mK6N+TOX00=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(346002)(366004)(376002)(5660300002)(186003)(26005)(71200400001)(2906002)(478600001)(66946007)(66476007)(8676002)(38100700001)(64756008)(8936002)(52536014)(83380400001)(6506007)(55016002)(316002)(76116006)(15650500001)(66556008)(53546011)(9686003)(91956017)(7696005)(86362001)(110136005)(4326008)(66446008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?x0LCq+0PuO3VBUJzP6FFU6fJsmcyyLHpvj2znCqa8NzIckI6ntmUx3w6HD?=
 =?iso-8859-1?Q?NWIKGMi83j7fHlPUlrqqN6OkqXzVip5x77k0mn8Kx27I3vryNylZFe/PQA?=
 =?iso-8859-1?Q?z+5FOSKOFdYocFri+MQkykKFsogYjDLOiSXvhE1vrXkPJI8CTNr0ZX0zds?=
 =?iso-8859-1?Q?2cfwbgf907lenyCmuJVEPqMAt1gUaqtNi2DQGTO3oefhtR4RIIwvt+yJ1z?=
 =?iso-8859-1?Q?u59mvSD9wh0h12aCiu2dscAiC+lN83zwFIb3zDByyL2BO0uyBMvg0UO1fN?=
 =?iso-8859-1?Q?f1boy+4ZpXW9HbHpBvHIC6BXaEJL2T65cF47AxiqR62q10OqNfXXig2prL?=
 =?iso-8859-1?Q?MNbkySUi/c8u/nCLdpVoe1Ww5YJVBIAeWzrBIUY4lWJn2Dn+hGEw4WpnBr?=
 =?iso-8859-1?Q?7GpGycPQ69ujuSbPt2lrWjY3cIPAXfqY+O7AEgGlHk3QKcvmWzA2L/5AVT?=
 =?iso-8859-1?Q?xL/oLGVyt+FImkPnXDfRUo4P+Gjd3v+PcRhfWOnmxZI3b3++hjF0CuY5jV?=
 =?iso-8859-1?Q?r6+VPmfXii9No3P6ZBVBozqKRiUjYU7BOvHgrliuAF3mlTANwcWTqF/oUH?=
 =?iso-8859-1?Q?+w7P1hcXEQ+WB225EzuXwaV+ZCQdak9+7LYhaYIheA5L3P1l1pvWwluBY0?=
 =?iso-8859-1?Q?jlhHgU7wu2cLv/gewx0yb5KVy2PK4gCCOapeCR6TYU93be5Se6JXNTONay?=
 =?iso-8859-1?Q?9O2BHBXkqaHUD8Vx0MhlH9z16lADA9gxJgGBS7DChiQaTL6VDWWC/HaRp9?=
 =?iso-8859-1?Q?jqu/3WqWp0oAwGjP+zxnvnlIhg9ODU9n27ta16P7tQ6lQ6jjnScczBsvK6?=
 =?iso-8859-1?Q?Z9fehhegLRVDwNoOUZRfEdkdm+M4xoo/C/4vwa1/cpe/S6Hjj2UqBEgU20?=
 =?iso-8859-1?Q?FSa6GaqEUE/N543kmwDRUAfwqAyu11/Yu3/dAgCKmUzK91wqjU70IHHRAZ?=
 =?iso-8859-1?Q?Gl/izeKobPIJ2V1hzvGI6zGO7kepkeBVUtfuWMxiERD/zXN0v9ItCYd45G?=
 =?iso-8859-1?Q?4MzLwH7H1neharrRrpkTkua7QvJQlKOasMFhQip0ev+TXuTu19sJSIbG+Z?=
 =?iso-8859-1?Q?Hxah5IfMy4s65Pty25MfIxbX/tmtseeqrnHAGCBAv/7sgNAGf0cj4hsWgr?=
 =?iso-8859-1?Q?MOpcuR2RIM1gBT0rqFYaMz/RF78dQywz+qpXoNogav6QuBg7Nfw9hwZs2V?=
 =?iso-8859-1?Q?YAJNPXPXDYyGNnIoj/S1wka3bchGZYU/AMrBnZ6cDoD3QjKTOgkfXizs9U?=
 =?iso-8859-1?Q?Mpmf85vYuao9mqFPCIq/lcq8+9v0lnE/S5HaIsOFwpT+EEtubGjVse5bcz?=
 =?iso-8859-1?Q?h6/jSnAbT2NNdsO8xNo1RjELohH4IAnlLT+iN7I1fhJVyGI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751541ad-3759-4fdc-ac7b-08d8f8d0bb77
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 07:51:05.4535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oc1sWD+b6v/9cKcbcqMYv6iBuFkQuXJvOuZXdottSlYUJMUbVFSZYz+cS9H+ltyCoVqlBLbCSmTozF2+3MwckKCaU0Js659IgYHZAZzWv0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
X-Proofpoint-ORIG-GUID: foSk6aE6KG7M5eoEr173udMnGq-hbtVO
X-Proofpoint-GUID: foSk6aE6KG7M5eoEr173udMnGq-hbtVO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_01:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan, Lars-Peter,=0A=
=0A=
thanks for letting me having a look. This is effectively as obvious as it l=
ooks.=0A=
Never think of testing that, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Monday, April 5, 2021 16:55=0A=
To: Lars-Peter Clausen <lars@metafoo.de>=0A=
Cc: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; linux-iio@vger.kerne=
l.org <linux-iio@vger.kernel.org>=0A=
Subject: Re: [PATCH] iio: inv_mpu6050: Fully validate gyro and accel scale =
writes =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Mon,=A0 5 Apr 2021 13:44:41 +0200=0A=
Lars-Peter Clausen <lars@metafoo.de> wrote:=0A=
=0A=
> When setting the gyro or accelerometer scale the inv_mpu6050 driver ignor=
es=0A=
> the integer part of the value. As a result e.g. all of 0.13309, 1.13309,=
=0A=
> 12345.13309, ... are accepted as a valid gyro scale and 0.13309 is the=0A=
> scale that gets set in all those cases.=0A=
> =0A=
> Make sure to check that the integer part of the scale value is 0 and reje=
ct=0A=
> it otherwise.=0A=
> =0A=
> Fixes: 09a642b78523 ("Invensense MPU6050 Device Driver.")=0A=
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>=0A=
Looks like this is in the 'obviously' correct category to me but=0A=
will leave it on list to give Jean-Baptiste a chance to look at it.=0A=
=0A=
As ever, give me a poke if I seem to have lost it down the back of the=0A=
sofa in a few weeks time.=0A=
=0A=
Thanks=0A=
=0A=
Jonathan=0A=
=0A=
> ---=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 20 ++++++++++++++------=
=0A=
>=A0 1 file changed, 14 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
> index 453c51c79655..69ab94ab7297 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
> @@ -731,12 +731,16 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0 }=0A=
>=A0 =0A=
> -static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, in=
t val)=0A=
> +static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, in=
t val,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int val2)=0A=
>=A0 {=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result, i;=0A=
>=A0 =0A=
> +=A0=A0=A0=A0 if (val !=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
>=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(gyro_scale_6050); ++i) =
{=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (gyro_scale_6050[i] =3D=3D val) =
{=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (gyro_scale_6050[i] =3D=3D val2)=
 {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resu=
lt =3D inv_mpu6050_set_gyro_fsr(st, i);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (=
result)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
> @@ -767,13 +771,17 @@ static int inv_write_raw_get_fmt(struct iio_dev *in=
dio_dev,=0A=
>=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
>=A0 }=0A=
>=A0 =0A=
> -static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, i=
nt val)=0A=
> +static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, i=
nt val,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int val2)=0A=
>=A0 {=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result, i;=0A=
>=A0=A0=A0=A0=A0=A0=A0 u8 d;=0A=
>=A0 =0A=
> +=A0=A0=A0=A0 if (val !=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=0A=
>=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(accel_scale); ++i) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (accel_scale[i] =3D=3D val) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (accel_scale[i] =3D=3D val2) {=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d =
=3D (i << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resu=
lt =3D regmap_write(st->map, st->reg->accl_config, d);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (=
result)=0A=
> @@ -814,10 +822,10 @@ static int inv_mpu6050_write_raw(struct iio_dev *in=
dio_dev,=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 switch (chan->type) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case IIO_ANGL_VEL:=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
inv_mpu6050_write_gyro_scale(st, val2);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
inv_mpu6050_write_gyro_scale(st, val, val2);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 brea=
k;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case IIO_ACCEL:=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
inv_mpu6050_write_accel_scale(st, val2);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D =
inv_mpu6050_write_accel_scale(st, val, val2);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 brea=
k;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default:=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resu=
lt =3D -EINVAL;=0A=
