Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81244110A1
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhITIEc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 04:04:32 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51114 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235258AbhITIEY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 04:04:24 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18K5d87A006281;
        Mon, 20 Sep 2021 04:02:32 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b6bv89x2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 04:02:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNQjmJJ0JcwICfyQkUKzSJzW4xUjcEWXnWHMz5nkAGGgM9yD/9r5dVlZUniX/xSxQiC+6wNylJRFx1BkPli3kBfK1PHiV3RGAfCKsG03YKOB2+X7sgPcD8rP2vLVU1mvMLC0FVBRS8p974fV0vEig4iFO3ov+cG5Iy/HrMMl2GsHz9MStwN0RxG663yToXfCje2HfoUFkStTDNa0SweAt3hmhrCAlY3VoX1kSYpdZxVsEo2k0nha/gLAebbT8wGqWTUyUYvZXxwqzvS68+ftzVWJozIC2lL3eSIAZUzBlZvrV/Tpl94M9NW4vTJTouueJWS0QqrhuHDgr6MxOi6mLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CJsOau8m6rwSYZuGiM4aTCW4fOXp3BxEth28921CJIc=;
 b=e0zB6Q6AWKlcQnulZs3W3jX/+V3C4Ubcdfkg+0tUmIpfdbh57cZddTL2BXVrhBwptZ1Ysj+39nBUVGLZcmKQPRZ67eRRjXxNIVr3MyZJshEg0zKtR7cQrPzQw/V2+W9lCrQRRPtybCTO+wFuZS5LGxWvRWsB0pA8E/hF674VWVFZfE/zgICjuWizolv7C4OfD/GplM2+el9fQWYvawMvdLBjjUDnNMCcabUM4GqmIyxD5w5j8JYbH4CmnKNzG8twIMADNg97LDQNEnz+UOYcSRb1C/qxf9/dTM+WveMFV6bRLvxHOGbgNd551M5aXOvzrlwyslpYtImiJbRhr8bCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJsOau8m6rwSYZuGiM4aTCW4fOXp3BxEth28921CJIc=;
 b=NW1nejkULNd+I6zOkGF+BjZQSQSogqH13heVHSA8Uz4NDywt5I8i31sRmcoMVoPip0tCvylRfghW3WTEPYJd2CACDERhjp+AQJn8Ck6REl7HIbdBbDGuDORZZYX2ZqQOb0ZKGsNa9NsPTRe2CJ9T8zwGbh6RmQFYkWYQUNpIHTI=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BY5PR03MB5233.namprd03.prod.outlook.com (2603:10b6:a03:22c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 08:02:29 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Mon, 20 Sep 2021
 08:02:29 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Chindris, Mihail" <Mihail.Chindris@analog.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>
Subject: RE: [PATCH v5 1/6] iio: Add output buffer support
Thread-Topic: [PATCH v5 1/6] iio: Add output buffer support
Thread-Index: AQHXqyjKrXUJwSdvXk2Y2LY3yk+oNaurmgIAgAD6g3A=
Date:   Mon, 20 Sep 2021 08:02:29 +0000
Message-ID: <SJ0PR03MB6359EFF08F0830A5D0EE181199A09@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
        <20210916182914.1810-2-mihail.chindris@analog.com>
 <20210919180244.1f935bcd@jic23-huawei>
In-Reply-To: <20210919180244.1f935bcd@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMTcyODFhOTYtMTllOS0xMWVjLThiOTAtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDE3MjgxYTk4LTE5ZTktMTFlYy04YjkwLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iNTEyNCIgdD0iMTMyNzY1OTg1ND?=
 =?iso-8859-1?Q?U4NTA4NDM1IiBoPSJ6UDJrV3d1WU90QTJBWW1jdXpYUEN4eHd0TG89IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUNUVW9MWjlhM1hBWlFiRHdXVmlGWmtsQnNQQlpXSVZtUURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQU9ZMFFLZ0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d51be62-977d-47dc-baf4-08d97c0cfe41
x-ms-traffictypediagnostic: BY5PR03MB5233:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR03MB5233A07A0C8ACF5984F750A399A09@BY5PR03MB5233.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UNISl2kSzGtLD0Ql8/p5nCBjR6JA1Lz5O5sSFKEFMczngrjbPL07RJLsxX0WBj3I7tijKmlCKT5bwk/syoCAPRHVPK/PaZA0J16gqdfoVQrvimHQYFN0hCXmIbP+IxsSEWZtd2z93oVCzsQ9XLB3/OQG7x3z53362Bbw4GCVnGsJLi15qA+Bkl/ibw9Kdn7SJiVoXIR6iN64+gH/0Ekftt5P9oS/bsnmvlLsqtgXVSmJN7vARZs42LM+SV3Aws+IcKCqO/lKXlVf+6RU/eZrPIHKOBCE2/Edptjj7/e7BCzQaM4o9/45GHe9hWMCptWevam5XgvEwn08iOcwW83Pc5BXJFwRwebBeYqr1QlacASlxxQ6GmrbJDVRtaSOEl8hfyAbbKFI2ZN8eCZZ9IegCPFEnJ22Bf6D+dBdAoCwOcvzW37dscnbOZ9Xo7TiZ3S+tDyxxDwWh145D0ocQRSvDBtNm6Fa9cMskZ8RQfKPFjSnXCb/2nYq1v49oKSKEbxfNBDN35FD8OThgLhOIDWpzwOBwfOGjAZlkumMXq/BDL2vD8+NxMXpPhvxTnv7SxIP1WxdmS1QdGwMTJLvQ9jtrLIASdc5+LCMJVAU/2bQVDwx3QMsaru+gkL2ZBDtOX8Yj3YmJSXaUYD+ldZdLOqIohciw77wq4WNttE/x7V+zymBmZgWWEq9cOYxhJvuytIX/+K8LmyP6VBfjJqIhjRi/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(6636002)(110136005)(8936002)(186003)(86362001)(122000001)(54906003)(5660300002)(66446008)(64756008)(38100700002)(26005)(52536014)(4326008)(316002)(76116006)(7696005)(55016002)(38070700005)(83380400001)(66556008)(66476007)(33656002)(478600001)(66946007)(8676002)(53546011)(9686003)(6506007)(2906002)(107886003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J0XBd5hIu6xJGJoqZW8Uf0ojF0VSiUtF82+R8o/5CQjJWecuinh7+XhWYz?=
 =?iso-8859-1?Q?g4tQf+TXHe4CAVnDLcu1Dm658K3PkwBHLYfVJCZtpkmDNkDQM4H/iZkZq/?=
 =?iso-8859-1?Q?+j7ZoMBP4a4BWQtVpGHa9+EI+g+IxkQ+9pjU9miZ5zCyPFqIMvrmK2KIx7?=
 =?iso-8859-1?Q?YcVmuz/WI+O5hlCj9OdAKecKLI4M4GB2FpDaMFlVReHZmKliGQxlSEsTow?=
 =?iso-8859-1?Q?fEYaLnn9ZinILf/HSjceC56WZaxWr7jnhOOhYHJG1l/Nc+qHp8S9Ov3mCn?=
 =?iso-8859-1?Q?sNthG1qjxrizggtkyNVZlPkxbgZL3C8xfUu0YouRw78Ili8jGOhcqjvjJb?=
 =?iso-8859-1?Q?6MprUxow7WQgSyTeOcBxPGlIUsFJsyc3SpFZU1gNBwh03uuUsKh8/lN5UM?=
 =?iso-8859-1?Q?n0p25DOdKq1vHN0meKH9fBSoxi1ftdT5lqPNQn74O8Kcz2TUa4lVOOFCY+?=
 =?iso-8859-1?Q?Q1SccFZnlIx12t3ftCRV8WTRo3nd6AHG7cIuAZT8lXNtEEdjpPdr40L/3N?=
 =?iso-8859-1?Q?qDYPf9qn+YwMShGVH89v9OV5/mf1+q+CIBHJEtPszh4xZy+JfSzYJbzSzn?=
 =?iso-8859-1?Q?AmCjSDvd4m/jcyZG4us9Ju3PhjSDxco+FYHl8IjaAVA7WwQTwEYPrACXXk?=
 =?iso-8859-1?Q?lj4QWcVyT8DV7QnyITZDIa2DU2OhInkcM9WNdF9SolTPe0ZoIw+cxhMRH6?=
 =?iso-8859-1?Q?IpPqrERkLKuml1Z1r7Duq1qLGdeNPLEWXFQSWgoQUlznvD/yvFG/c0tWcQ?=
 =?iso-8859-1?Q?pz8GRkaIjQ20Js/ClhSB1RHm17G7mYPbWrYRhwm6F4Xvi/vG+bspyCXAia?=
 =?iso-8859-1?Q?jz5PtadIaJSZTy9gffObJgsawCb87+zvcdfQm7pO7vpLsQCvvVIxj2kNs1?=
 =?iso-8859-1?Q?aJeq70nz8x1mQ88GdPtzPahh8Efn7xeMKNjYodZZWwTTnzkCkx3CXbgF0a?=
 =?iso-8859-1?Q?RUTMkvpz9j2nRJHeY5bVi9o7fz9952d34SHGlQ8wel1KbQgyRVNu9Pg4S2?=
 =?iso-8859-1?Q?RxWICt6Gq9f/JKjdZAxoWotkhNWBksWYFYSjYN16LLQCI5guVqN+9fV4I2?=
 =?iso-8859-1?Q?bfk2cNC3RGJxHefbTx8mmvmut1wpS9jIZxsYT4xqfM4GCnvRZhSMNGfbhJ?=
 =?iso-8859-1?Q?+Y+xiXYbMABlByyRT3dfseVLs0SeFeOzxcuJUl/x6iO3vUGDZBaOqbwfMk?=
 =?iso-8859-1?Q?9KJeAXB3ts6CQ0wfpn0xCJMe6FFft3AJYudpEqbDAiqIRODP+MTrqsxFNV?=
 =?iso-8859-1?Q?EUotOk/W6hmoKlSqKnej5LlBkslOyt56giiPGb40gZI+jgKO/JGNySBLqs?=
 =?iso-8859-1?Q?5otDb2GaUkR9j3tontsyHOvDLwu8KVM6cE2mxStkCLoIA6wCvqYrRfY3FG?=
 =?iso-8859-1?Q?cn+D6hSma8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d51be62-977d-47dc-baf4-08d97c0cfe41
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 08:02:29.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 894GaJCeSfVDWE/5cIK9CBTAAllFZE3iGWi9OX2IzRIl66o//sr6pPzUZBgfDvqU+bvkRnZBdXninhY8IZB4Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5233
X-Proofpoint-GUID: AlwMpkkYu5YCdisu7Es4mTG7-Zbo6u65
X-Proofpoint-ORIG-GUID: AlwMpkkYu5YCdisu7Es4mTG7-Zbo6u65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_03,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200048
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, September 19, 2021 7:03 PM
> To: Chindris, Mihail <Mihail.Chindris@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> lars@metafoo.de; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; Bogdan, Dragos
> <Dragos.Bogdan@analog.com>; alexandru.ardelean@analog.com
> Subject: Re: [PATCH v5 1/6] iio: Add output buffer support
>=20
> On Thu, 16 Sep 2021 18:29:09 +0000
> Mihail Chindris <mihail.chindris@analog.com> wrote:
>=20
> > Currently IIO only supports buffer mode for capture devices like
> ADCs. Add
> > support for buffered mode for output devices like DACs.
> >
> > The output buffer implementation is analogous to the input buffer
> > implementation. Instead of using read() to get data from the buffer
> write()
> > is used to copy data into the buffer.
> >
> > poll() with POLLOUT will wakeup if there is space available.
> >
> > Drivers can remove data from a buffer using iio_pop_from_buffer(),
> the
> > function can e.g. called from a trigger handler to write the data to
> > hardware.
> >
> > A buffer can only be either a output buffer or an input, but not both.
> So,
> > for a device that has an ADC and DAC path, this will mean 2 IIO
> buffers
> > (one for each direction).
> >
> > The direction of the buffer is decided by the new direction field of
> the
> > iio_buffer struct and should be set after allocating and before
> registering
> > it.
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean
> <alexandru.ardelean@analog.com>
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
>=20
> A few minor things inline.  I would have expected the missing check
> on insert_buffer to have resulted in a nasty deference of a null pointer
> though which does make me nervous about whether we have tested
> this
> series enough.
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/iio_core.h            |   4 +
> >  drivers/iio/industrialio-buffer.c | 120
> +++++++++++++++++++++++++++++-
> >  drivers/iio/industrialio-core.c   |   1 +
> >  include/linux/iio/buffer.h        |   7 ++
> >  include/linux/iio/buffer_impl.h   |  11 +++
> >  5 files changed, 141 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > index 8f4a9b264962..61e318431de9 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file
> *filp,
> >  				 struct poll_table_struct *wait);
> >  ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
> >  				size_t n, loff_t *f_ps);
> > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user
> *buf,
> > +				 size_t n, loff_t *f_ps);
> >
> >  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> >  void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
> >
> >  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)
> >  #define iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> > +#define iio_buffer_write_outer_addr
> (&iio_buffer_write_wrapper)
> >
> >  void iio_disable_all_buffers(struct iio_dev *indio_dev);
> >  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> > @@ -83,6 +86,7 @@ void iio_device_detach_buffers(struct iio_dev
> *indio_dev);
> >
> >  #define iio_buffer_poll_addr NULL
> >  #define iio_buffer_read_outer_addr NULL
> > +#define iio_buffer_write_outer_addr NULL
> >
> >  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev
> *indio_dev)
> >  {
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-
> buffer.c
> > index a95cc2da56be..a2a34c5652a7 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -161,6 +161,62 @@ static ssize_t iio_buffer_read(struct file *filp,
> char __user *buf,
> >  	return ret;
> >  }
> >
> > +static size_t iio_buffer_space_available(struct iio_buffer *buf)
> > +{
> > +	if (buf->access->space_available)
> > +		return buf->access->space_available(buf);
> > +
> > +	return SIZE_MAX;
> > +}
> > +
> > +static ssize_t iio_buffer_write(struct file *filp, const char __user
> *buf,
> > +				size_t n, loff_t *f_ps)
> > +{
> > +	struct iio_dev_buffer_pair *ib =3D filp->private_data;
> > +	struct iio_buffer *rb =3D ib->buffer;
> > +	struct iio_dev *indio_dev =3D ib->indio_dev;
> > +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > +	int ret;
> > +	size_t written;
> > +
> > +	if (!indio_dev->info)
> > +		return -ENODEV;
> > +
> > +	if (!rb || !rb->access->write)
> > +		return -EINVAL;
> > +

As the buffer implementation can support both 'read()' and 'write()', the f=
ollowing
check might make sense:

if (rb->direction !=3D IIO_BUFFER_DIRECTION_OUT)
      return -EPERM;

If going with this, we should add an extra patch to do a similar thing on t=
he read side...

- Nuno S=E1

