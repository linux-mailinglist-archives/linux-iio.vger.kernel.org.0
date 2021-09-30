Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0701441E14C
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 20:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344036AbhI3ShW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 14:37:22 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:57306 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344033AbhI3ShW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Sep 2021 14:37:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UDahup003156;
        Thu, 30 Sep 2021 20:35:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=vWOMk4bw3WdyZ1TYt/ho+K2vzHiWUrNtSqULU0mDDiI=;
 b=eAA9HFp2QCcFzOEO9Yrs0k6Y3nkSAnoi91Afw5wS0sTEAjuR2O2yViN9S5+cz4DudcBa
 hAR4vDGgwbEHFZ/ZnrbNb5GuPuWqzqcEMkDuKQrdi6imTMtigslL4BsRizDYt0FM+iKU
 Ejl+19WQhwCu2UQtOLRWf63Dy/TDSAfN7cNf3mywPiFweBxIJdIo0iRmLt74lgycGQRB
 F8VG617tF+7gwr2l9lJG7/+BorJm0IXogoB9gHcjpRIfpTehMb67uC4tcXFZY/jsx4AL
 opsghv8bWXCFscuqkzOIW3OUlimi2lWJFkQ4eJvLw3FzLha8ArZJDbQ9pihi4SNkRkHF 1g== 
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2055.outbound.protection.outlook.com [104.47.9.55])
        by mx07-00178001.pphosted.com with ESMTP id 3bdaa6uah8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 20:35:24 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwoY55OlXJPLgDcM8CpIlVFOV2WSxtdT9Y9ev/KTvxzjUfSULWp7AAGU3CzdCX7lGGZP59vGPpWyT1cZk6/icXJdJhC4OCrbgDJs/Lb9V1kkkKgU4EDhG588ZRd0Cts0yAZU0s0Qui57pkBqKw+o/mqZqE5Iu09ksiGf4ccaj2dq5DuaSRwLuipZ812m9cKaa7erEeY/ecguAlq37XOgKFCgI3lfQl4cNwkBxQjvFrIvwwUU/09IOsiii5qf15ayUcguErx5mmbt1QIQ+WI7mSTn/KcF9nGWlbK90R8fHS+2K6Bta3T3KmjXMjy9wt2lGium6rbLXtlO5KgUtVwM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vWOMk4bw3WdyZ1TYt/ho+K2vzHiWUrNtSqULU0mDDiI=;
 b=YK3leGOEV8G6+snSKLgqcJoDAKxm3wW8nZYnEzDS+1PM1kfyiECP/ztIp3f4XqVGC0i360tbFzao1P+D12ifbDgbPpZMttLZYGythWgv6BuY2azxP6vunRvKoN+aPNz1/Kdg0eGSCz5GaQNY1JXdUVi9NLF+3Wt7M/a+pNHuj8JyE6LjNDeczMH9QPQKPrZX49nb1ESSr/UBVWPqZd8ZAQsy+yEGuXaTLy8k4RbB8ut92BEiYv6Tht8B5hzfH4OizhaVg32NM1K9oSB9etGvhnwpYqO/7uHJxv3+/PRixOys4t22cxoyyMX8otsFdRuypSK7W+SjvbVCuiLySJtbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:360::23)
 by AM9PR10MB4823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:412::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 18:35:23 +0000
Received: from AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dca8:7592:14a0:7b96]) by AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dca8:7592:14a0:7b96%4]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 18:35:23 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Mark Brown <broonie@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: st_pressure_spi: Add missing entries SPI to device
 ID table
Thread-Topic: [PATCH] iio: st_pressure_spi: Add missing entries SPI to device
 ID table
Thread-Index: AQHXs6WZbL2LZ5wAIUS0WAh/0vD5pau8zAIAgAAeRwA=
Date:   Thu, 30 Sep 2021 18:35:23 +0000
Message-ID: <AM8PR10MB4801DD2B605277F3D97CAF87EDAA9@AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM>
References: <20210927134153.12739-1-broonie@kernel.org>
 <20210930173852.208f1815@jic23-huawei>
In-Reply-To: <20210930173852.208f1815@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=st.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98cb91b4-3026-4a08-a0ad-08d984411093
x-ms-traffictypediagnostic: AM9PR10MB4823:
x-microsoft-antispam-prvs: <AM9PR10MB48237308576D0F01FE5147ACEDAA9@AM9PR10MB4823.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PJYHCFL6wwxROSSX+p6Jndlua59rTPgcNX6dSJYvAbXn0GSD7CR/rHdL+8vI3nDVitjpxsGoJfe/O2FiphWM2lZMRP7w5B/SKzlSIQCMjQgK2pBMJOGKsgGEFrFlrv7dDnhmYO0yHul0XdMsj/Db9x5JoL1P56YpxMPBRcDNJ2vCzeSlb/fbJw+yVbfSRS5BBTbciQ5kc4kTt8++Mh5Ooa1jOBGoVtWsydi3G/v7SQRox85eNg1jQ9cdJBnoa3khgL6HZYwHK0pK8FvWiNWGv3UxxksB0nFGLp2ltLM0L2iOgT9IMnd4zc25PvjKxr1QT0WkPuPexoYPFYGtBzQf98wqHXTKWQLOvAaMg2hpqWFBgHIs7cFKksXPKoz3bLVa3flUPLk2QUZlz4aaB8gPBsjDgSLy6B3XTH73DblXKizlaf2UbabReX4qluD4kzmtXcb/rOmizazYN5f6TKDXJppMtmytvsqJjzjGRNBdibzqUM5epr4AVi6jiLWnNSBVLcfbTfTqsWccjU3ZY8h8cXHfArpaI+zHN1YO7yxcCvGDVsHgkc9UOFsu7kJdzhjMauDw1nf0jNzY28lbQPCg6q7fh4U6YudM2GIRGG5+F6OiKm+hH8UsyeRXkTqW9kvBEpBKG5nhnlZhsXA+88q3WNWvsIqACt4VNNb29jx6thLyD4PUJS1DKHmLICyNQIIaKUZNMmilCRECfEUoYxqpxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(83380400001)(66446008)(64756008)(66476007)(66946007)(55236004)(6506007)(53546011)(9686003)(55016002)(26005)(71200400001)(508600001)(316002)(8676002)(110136005)(54906003)(38070700005)(86362001)(38100700002)(5660300002)(122000001)(4326008)(186003)(2906002)(33656002)(7696005)(76116006)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LrGmRsS+xizjUeQhXFdEMGP5WrtENvn7XaFr4aVt4cE5liaLN7Ls7QVZ3d8y?=
 =?us-ascii?Q?784eJfF/dTI+4GV2HrceUZxxImdLF0ckjXoCRAH8xpYkue1Rz5bmK+c+MDed?=
 =?us-ascii?Q?eKOiTzeP2sfxQ37Ueg/Itz8fPtEmm+wqhWRDL2Vg7j8DA6bkq2tcz2pTIOI6?=
 =?us-ascii?Q?C899eD9kn9VyKHOcTFAVw1h1ez6euYBLuIOP6UoBg+tl9Rhs211bX5qP568A?=
 =?us-ascii?Q?NGQX80bhY5h09xscDWswHBat6uZxCaUXIv28JJwvsckV85ycaV9Vl9zRkrji?=
 =?us-ascii?Q?4jr3Tgwb1csOPmBuNi+A3B70yzQ6+9fzfiErO3nPsKdYyY3NVlePY57eK8Pp?=
 =?us-ascii?Q?3I5LbTgka7cMQeAMNnIIz6ttM24EHkiVNHDppgR/fndKeQNFegAT83aBBF9k?=
 =?us-ascii?Q?h4AfolKF9RcPgyLKmGFAeQn4FjxgALHPv2BC+wmG3QhrcrDg1lZRAAR2KKSv?=
 =?us-ascii?Q?SyuHt3sckBShjiSeGOdtXZJv+CRYhhXCFDeR/NFAJKGoj6xyYT5uII/i+8i3?=
 =?us-ascii?Q?rkLiIMTgXsLGjBPQR9+oRZxyp8tDaUPru/wnJ2Vgkr7J0EJ5OX42hAH8hnR7?=
 =?us-ascii?Q?VQe84K0+uLwXgkdwVyOGHvqQHUf7K7uWq5/nAGQf8F508lt6mXZtkxRkpvRJ?=
 =?us-ascii?Q?seP3vJQuHhiP6ZlWL7WKcCddRmHXmk2UDlNbbZ7WTTXbmRQK88KlcOt8hGMg?=
 =?us-ascii?Q?72RaYVASpo+XM/UwYYqCPHVkIYFbIOIlZ/SoRttB0svOYhDJq8Wop3hyqF5z?=
 =?us-ascii?Q?oURq0/t2SKaxmMqM6LW0ZMKvg7tENpBpcrFJnBkdmlSqH+u4EOUeRSD4YIfI?=
 =?us-ascii?Q?lNvo2jDtSZ0l7SyzET8NgLJqWbzXeTmCnwBeYUfFdG/pyCuuDaq/7BQOuxWa?=
 =?us-ascii?Q?81emgR/h5mcr2DIOGgkz2AqcAVBxeOY5k6a7igDowNe+JucQ0t6am3sPb6OG?=
 =?us-ascii?Q?vGHHLhHfcYb4ZdC9QMf0VpWUPKIdinq0MJ3Ne3fa2rW+SpSHTMRxHD7uH7Mg?=
 =?us-ascii?Q?QdA57AGzdfr2mZzZNQaDULpra/kGpguzJskRGA6HLWSjwm+/5F2SH6aUAiJU?=
 =?us-ascii?Q?/mtzeKsFJ33BmknSG4hRovAUnrudffGcsvEqhidRSYjwjxomHG+EQll2E9it?=
 =?us-ascii?Q?Wrv+09pcv+LdfCBy/VXuPYMrc6tepP7cD/d3p1n7y7pTDX7yXZf9YzPVaCJZ?=
 =?us-ascii?Q?AIoSKb6X5TbTSJPRYOtkhrQxZvNM1nqzGDn8PLIzwxEP0B0zVhni9q7XOLDN?=
 =?us-ascii?Q?06oe4kXd9ZczCGhOAxpE9xwms8FWjU03J3+xtNC+jVYyeKvuT2y3JTde+1f5?=
 =?us-ascii?Q?Mur3mHKNkQbusBUsPBXGxJCG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cb91b4-3026-4a08-a0ad-08d984411093
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 18:35:23.4969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtJybquj9LyfndHbMoCyhKc6uQnU6EZvlZCRCd/TYqf3DtngoU6K4nOtzgXBoxlNzgOa2Ecv75Ui7EMvVH3r5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4823
X-Proofpoint-GUID: WqvoWDeJ-oefPKHUJfBnj9Nm2KN5UxaO
X-Proofpoint-ORIG-GUID: WqvoWDeJ-oefPKHUJfBnj9Nm2KN5UxaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_06,2021-09-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300113
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan, Mark,

I am not very familiar with how much the kernel would like to keep 'probing=
 id' consistent. I perfectly understand the value of doing this (maintain I=
D compatibility) but I also see increase confusion in maintaining half in a=
 way and half in another.
I personally think that we should drop the '-press' thing for all the devic=
es since they all are single-chip (meaning that the name used identify univ=
ocally that is a pressure sensor).
If you think that compatibility is more important here, I think the patch i=
s fine but this should be done in the i2c part as well so that it's at leas=
t congruent withing the driver.

Let me know what you think.

Thanks,
Denis



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Thursday, September 30, 2021 9:39 AM
> To: Mark Brown <broonie@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; linux-iio@vger.kernel.org; Deni=
s
> CIOCCA <denis.ciocca@st.com>
> Subject: Re: [PATCH] iio: st_pressure_spi: Add missing entries SPI to dev=
ice ID
> table
>=20
> On Mon, 27 Sep 2021 14:41:53 +0100
> Mark Brown <broonie@kernel.org> wrote:
>=20
> > Currently autoloading for SPI devices does not use the DT ID table, it
> > uses SPI modalises. Supporting OF modalises is going to be difficult
> > if not impractical, an attempt was made but has been reverted, so
> > ensure that module autoloading works for this driver by adding SPI IDs
> > for parts that only have a compatible listed.
> >
> > Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> > Signed-off-by: Mark Brown <broonie@kernel.org>
>=20
> Whilst these IDs are deprecated, we should at least be consistent that th=
ey
> either work or not rather than current situation.
>=20
> +CC Denis as driver author.  I'll let it sit on list a little longer so
> +Denis can
> take a look.
>=20
> Thanks
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/pressure/st_pressure_spi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/iio/pressure/st_pressure_spi.c
> > b/drivers/iio/pressure/st_pressure_spi.c
> > index 9b2523c5bc94..d6fc954e28f8 100644
> > --- a/drivers/iio/pressure/st_pressure_spi.c
> > +++ b/drivers/iio/pressure/st_pressure_spi.c
> > @@ -97,6 +97,10 @@ static const struct spi_device_id st_press_id_table[=
]
> =3D {
> >  	{ LPS33HW_PRESS_DEV_NAME },
> >  	{ LPS35HW_PRESS_DEV_NAME },
> >  	{ LPS22HH_PRESS_DEV_NAME },
> > +	{ "lps001wp-press" },
> > +	{ "lps25h-press", },
> > +	{ "lps331ap-press" },
> > +	{ "lps22hb-press" },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(spi, st_press_id_table);

