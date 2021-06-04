Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EC439B049
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 04:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFDCSu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 22:18:50 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:2024 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFDCSt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jun 2021 22:18:49 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1542Gfvd023242;
        Fri, 4 Jun 2021 02:16:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0064b401.pphosted.com with ESMTP id 38y3b3gb6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Jun 2021 02:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li33hOziknIBtVVrF26TRgyRB8+mLAkXIfWpPqpR8I3phhfy+6xmTJAkDCH4m7IB5lVXVQ8HvJ9pVcyyvrk7K5NlUquVLPhK4oXKKEF+EFx2YDLxLrNjsPHqM3Vsp8KXoh0tx0awkKOoFd+2YpThz6PWuFxGiVB7+6je4vUXeyVWe5sln9vrLPsYFfxiL/KKIP4x/DkRQIrlD1AJ9RRryF8SaSw74G2EO860zDEi7dQSAYQSeFAubW3eM7f+QibMzQT9++8+82pcagGGNBc/uUEoTrYOysxQZAJ+hvq/6gRpxS4RuKZYYz1+Plun5CbrPEAVF4zOelSyeB2n21sPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPcVTs4nSi6HUHPtLVJEbrPfiWIulmCJpeuHeLu2GeU=;
 b=Dx4BhRPaYvyQ5WhwAJxYJdt8xWQoyJvtoqUEeBBXcnVJ36qe7byn5weVP9x0zq+rnByHMHCmWeworlTK+JTWESl4kQMHz2PIZba+nqCfCZcAbmofiPHavBCg5wNFQDbZ1xXtXvvE5E/H1FaZZY7iZkz89nAN1oORYYmNXeUqQHsANJB/zhHy+FAvtMX1zMGUpYc6rc7BQ6+LsQpGzSduxur+iOJFvIYjfSTsVjp0EyVOn9dgvecdytPS3zYeFA1PMLEH9qUu6HO1twPEF63D+Sv3IlYuOMraSxan1F00IfiJs+nDjxDmbjNun5072K+lYS0Bdh/LpCvCxf22IBAsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPcVTs4nSi6HUHPtLVJEbrPfiWIulmCJpeuHeLu2GeU=;
 b=iKi17JPirSWgI+FynzG+2V9BdZMtUlv7hVPGprnz/Gqw0L/gUj/kYBqI0EkkoCS8imISABNhVJdRBSDu/fSMOdGlxNtiYi6dGp9p8o+fi9zSzPEq4LyAvM+f9IBS/qB2vx5JjeF9dt3AfacpzrRcGhx0ODWnXW4BtqGA5E5R280=
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 4 Jun
 2021 02:16:39 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49%9]) with mapi id 15.20.4173.030; Fri, 4 Jun 2021
 02:16:39 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Topic: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Index: AQHXVsiLZJqFig5jYEW95MUVkHO9fqsCeyaAgACcmKA=
Date:   Fri, 4 Jun 2021 02:16:39 +0000
Message-ID: <PH0PR11MB5191C26AA8B6D2B855E19D67F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20210601092805.18385-1-Meng.Li@windriver.com>
 <20210603172025.314b5ced@jic23-huawei>
In-Reply-To: <20210603172025.314b5ced@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ecd410b-8435-4352-4eb9-08d926fec997
x-ms-traffictypediagnostic: PH0PR11MB5064:
x-microsoft-antispam-prvs: <PH0PR11MB506476D97EF63EDA6FDA9E08F13B9@PH0PR11MB5064.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dFLBhMuTtfQIOXXik1F5gEf9DinTfHbqgM1+iudurCaVt2tJAU1RPcd+6wciZ3tBFNuEkEkpsGK1elglUCzr4zmFqMRCAN+x7SOXMP3vsl4nXA0JFaqAEHa/vzJP/n5XMYRyWlWsTPzJjGMcGitV8qhH+VEs+uFH3TgpigMosRRBxIqSFppyoOQuPgzKm4EbygCpgjp0IxB//hBirbCBW3yTVGvXEp43n9pX86KKoW24KjTKwoMCdzhv9du2xqFhAzXkjC1p1xmDbVMGR0KHZhZf+MEZkWPH7qYE1wHi5FpFs+wP0a+ewzfhXGk1oiTNItUeYMcrhc9b1wxqdRF/IFGiaE7nwcubt8UzER795GGWCfpgzO2vPci37UfDCFIynevS+lYyt7snRGSmamsK0IfPviqhWfKxTb5zlF/UgfrjMx6fjHfM4mS8eGdNECnLQFqV93kQNo0GDXj79K9czs/JncxU2XjHKCJzT3p0kWEaqhZcIjq5xwL0CLkOrOPVReaarQ563Tx6COY8s9wMwbiYiCrqzD7gZBhbcP0W4Q4f5Qycnn9Ppfv1QYRiQnWHqiHBdW5nNMHTWwIt22kdxsrgRidzj/RASV6L6kwXPUs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(376002)(396003)(346002)(136003)(478600001)(83380400001)(26005)(6916009)(316002)(52536014)(53546011)(54906003)(6506007)(33656002)(122000001)(38100700002)(9686003)(2906002)(66476007)(66946007)(64756008)(66556008)(55016002)(66446008)(86362001)(71200400001)(4326008)(8676002)(186003)(76116006)(7696005)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HOrD15iUfW+X4AXH5C/gidIEw4vPkDQN0i5aWABW9RIXhVp8rZ+Ntvl5rEK7?=
 =?us-ascii?Q?GWHkcmnlFK+sW0bcCIBVQ96hdckhoNMTk2eLkFbtI6vYk0CXrix8IOFHfbIR?=
 =?us-ascii?Q?mJGMr4UZeD7S1TGLI5N1pZlATlIBdkjJTYxVyAO/0b90SotfUTtu8InUgz3t?=
 =?us-ascii?Q?N0ObT6xtAtNR4mzXatkwK+UlsItXmu1AWuJiCk7GTIF5DInCkQQ2Ale4Jqiw?=
 =?us-ascii?Q?p8J5RXL2lZi658sNpoS7UYX/ehkesmggiDuYFbkbCVfBwpoESbMvbemXDoO1?=
 =?us-ascii?Q?HhKoH2pGFi2a0kThM6CQaggfhVHYplyjFvzFmHlMPKHsnP959YkBy4ry7otJ?=
 =?us-ascii?Q?7xmUP0VRLHCQS6435FNd/ARJ3qbtQiNF0++c+qs5adXsV52VGnDY1X4Blxhu?=
 =?us-ascii?Q?PqKnmqW9gwyNiP7wxylC760V0AOKIgHe5vJ0GYDXGseLLIB78oaq8qgzlkLT?=
 =?us-ascii?Q?0hGQ3rflYexPZzefTd/OmsVtfqRJrItvTvpBXwgd6EQb6oEf4OTtZF4AMOAx?=
 =?us-ascii?Q?x/JKNsVINqAdhxrQnl8nNOCmi4SiGjHzT2s5Q6WJbv119S592G+J/bYsWYPd?=
 =?us-ascii?Q?sBG0We4v94kmApBKDiZhS0wO3lvHUlcdHwlP7MBJOGxqF6Bzs7GTjAeFMM9V?=
 =?us-ascii?Q?jUbRYcKf/Ld+qpgNZJn9ht7MEo8eV5yCGpA9JfxVWGz9pjmB5ToLOMG+pXOo?=
 =?us-ascii?Q?aqeiwbcLsK10omGiG1ovFbl963UPqdVfoDeLK1J9LNs/ZM6SoYmO7WCaCrxU?=
 =?us-ascii?Q?XdCtYJQ98AO41d4jLtC8vjWFCN9zzyPSi7qI3o1LsRoXrK4JlM55rKvlSfdN?=
 =?us-ascii?Q?J3oD/hQ8ri6VACaJFwV0YSqInW9NgJrHdVX9gAmgJ+fAK6XASLE2eY0u45/N?=
 =?us-ascii?Q?XWtQaQq2mCWudqmqdRe2Mn0brMgYYYGUwo+8dYtU571z0I8MbDjR+vmscjlt?=
 =?us-ascii?Q?wvKmIRL+b2oPNWUcp8nhgoLj0kuUZY+2zC5OM2ayhFPqwAKDnnKSHNywNrUP?=
 =?us-ascii?Q?aqdEW32zhTadjnu9OGhjbjHlxk003yG3eZIwch0/RMK9X6YxgVfdeda+IKYl?=
 =?us-ascii?Q?C4m6ZMPVnV5Rt4gj+cvHpX4C59vUIN7LM7ryIgLLrNUprx395qVqn8X8zO7D?=
 =?us-ascii?Q?A/gjxD0uhhk9qC+a3mnw5c+sGfZ7K0gncSfjTnB7u/4rXTIDFt/2s2BFxAnM?=
 =?us-ascii?Q?QD93CJaGXjLwDKuar6VY1YDBUaM85uGmBYE4XSKtGVeCqrNpfnLFuwCS/ufI?=
 =?us-ascii?Q?J7Zn3QhPjJRLXYHhlqpCel87Hz4RoYobP1i9+naYUwQwu0JQzAI6AFcJdbJ6?=
 =?us-ascii?Q?tn8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecd410b-8435-4352-4eb9-08d926fec997
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 02:16:39.3568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DI+/KtJqHh/+vreg1ZwROklQ2+Wq6KB61EZMQUr3h4i7hfPgCj4HVXfMdsU/mRfCSYI4/CL8EB6cQz8jgVJS3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-Proofpoint-GUID: JEcGszEvOYU15W51Vo7jJqlHb9BqEHD_
X-Proofpoint-ORIG-GUID: JEcGszEvOYU15W51Vo7jJqlHb9BqEHD_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_01:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040015
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Friday, June 4, 2021 12:20 AM
> To: Li, Meng <Meng.Li@windriver.com>
> Cc: lars@metafoo.de; Michael.Hennerich@analog.com;
> pmeerw@pmeerw.net; u.kleine-koenig@pengutronix.de; linux-
> kernel@vger.kernel.org; linux-iio@vger.kernel.org
> Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading =
the adc
> conversion value
>=20
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>=20
> On Tue,  1 Jun 2021 17:28:05 +0800
> Meng.Li@windriver.com wrote:
>=20
> > From: Meng Li <Meng.Li@windriver.com>
> >
> > When read adc conversion value with below command:
> > cat /sys/.../iio:device0/in_voltage0-voltage1_raw
> > There is an error reported as below:
> > ltc2497 0-0014: i2c transfer failed: -EREMOTEIO This i2c transfer
> > issue is introduced by commit 69548b7c2c4f ("iio:
> > adc: ltc2497: split protocol independent part in a separate module").
> > When extract the common code into ltc2497-core.c, it change the code
> > logic of function ltc2497core_read(). With wrong reading sequence, the
> > action of enable adc channel is sent to chip again during adc channel
> > is in conversion status. In this way, there is no ack from chip, and
> > then cause i2c transfer failed.
> > In order to keep the code logic is the same with original ideal, it is
> > need to return direct after reading the adc conversion value.
> >
> > v2:
> > According to ltc2497 datasheet, the max value of conversion time is
> > 149.9 ms. So, add 20% to the 150msecs so that there is enough time for
> > data conversion.
>=20
> Version change logs go below the --- as we don't want to preserve them
> forever in the git history.
>=20
> I may have lost track of the discussion, but I thought the idea was that
> perhaps the longer time period would remove the need for the early return=
?
>=20

No!
I think the ret is essential.
Because when call i2c_master_recv() to receive data from chip, there is a s=
top bit sent to chip at the last step.
When the chip receive the stop bit, it will start the next conversion opera=
tion.=20
So, if we send any command on I2C bus when the chip is in conversion status=
, there will be a i2c error occurred.

Thanks,
Limeng

> Thanks,
>=20
> Jonathan
> >
> > Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent
> > part in a separate module ")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Meng Li <Meng.Li@windriver.com>
> > ---
> >  drivers/iio/adc/ltc2497.c | 2 ++
> >  drivers/iio/adc/ltc2497.h | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > index 1adddf5a88a9..fd5a66860a47 100644
> > --- a/drivers/iio/adc/ltc2497.c
> > +++ b/drivers/iio/adc/ltc2497.c
> > @@ -41,6 +41,8 @@ static int ltc2497_result_and_measure(struct
> ltc2497core_driverdata *ddata,
> >               }
> >
> >               *val =3D (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> > +
> > +             return ret;
> >       }
> >
> >       ret =3D i2c_smbus_write_byte(st->client, diff --git
> > a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h index
> > d0b42dd6b8ad..e451930837d8 100644
> > --- a/drivers/iio/adc/ltc2497.h
> > +++ b/drivers/iio/adc/ltc2497.h
> > @@ -2,7 +2,7 @@
> >
> >  #define LTC2497_ENABLE                       0xA0
> >  #define LTC2497_CONFIG_DEFAULT               LTC2497_ENABLE
> > -#define LTC2497_CONVERSION_TIME_MS   150ULL
> > +#define LTC2497_CONVERSION_TIME_MS   180ULL
> >
> >  struct ltc2497core_driverdata {
> >       struct regulator *ref;

