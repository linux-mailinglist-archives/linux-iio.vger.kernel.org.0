Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE5340D810
	for <lists+linux-iio@lfdr.de>; Thu, 16 Sep 2021 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhIPK7T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Sep 2021 06:59:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64480 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237635AbhIPK7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Sep 2021 06:59:15 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18G1ENlh013459;
        Thu, 16 Sep 2021 06:57:42 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b3v3ba481-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 06:57:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVc3yETipxi4n/24xcgby+d1G4EX5/jCXS6JquWZwgIDjES5jZ76JxB1jcV1hwZ1+FSZvWn9WyOZQ50YHp1uJmuWs6U7D/OSyqiA3QAqPY4AiCzDNHIklq7Lmz0RQoMHPdh3n3uJ8smI2ObiDI3A2CC+z4Zl8gQCKrZc8of2HTcqwiFDQk0rNB/3qzabDFHg5bHbDWm86LeoIJnGaOVovvkIJkKWYdRAcsxAr6BIfiOdehQLR9dIlsAngX8PtFWaC2RwHGc/oBGp5DE7XHiGpadD8Zhq0LvCm5L1RFDLDyaOGNhC+6EjGE6kDB+thsft8rUVGxSqIxRIqZI5/dImbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JJ1sojXmag5XK44B6ldKVpSPrBVnLaCwCYh7axyDNOE=;
 b=NnKHIvlLlrf7Yd7yIXEgwG1G8dmgHeiLZFDRQ/30UYU9nkqPrKSVJASRxF/+D/ZT854ahwZQbZxjFwAtBGOT+c4+I+YMqcIxP6yZMhqYbHYbeh+RhANz8q2dszIFshMTMZfTkGjay2Sh8Bbk5useTr18XNFCy100K8Lx4fWaQ5EvuDNUt7n57opp3EtHC5z3m/F1rV+kNkbsRmO1NR5/oI+FOOnQW5rXTLdBzYTXDIoskmN7RYIY1MvNsIAWd/snqnUzQRzyv/bPe+Fva+W7U9nN+WX+g3GJhkF6kajOsma+Hrny84/OfBv8s1qFW5J/Zo98/VpFlXezHYWVQ5AHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ1sojXmag5XK44B6ldKVpSPrBVnLaCwCYh7axyDNOE=;
 b=GkBnNTbnRvtoxAB//A9JcWeKaYhQasVTr0bTtoCx5+7a7zW1rL2kzEPgB/553bKkMmwB8kK3aVnK22VeXtYn6527AftxPqH0/LkeCetc0DCa9JoWPjtNO3HSXcSnCNGabryBFjq9ccwA29sE0I88XYBY0qI41gZ19r2/9+8wxn0=
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com (2603:10b6:a03:2d4::23)
 by SJ0PR03MB5869.namprd03.prod.outlook.com (2603:10b6:a03:2d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 10:57:38 +0000
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4]) by SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4%4]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 10:57:38 +0000
From:   "Chindris, Mihail" <Mihail.Chindris@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>
Subject: RE: [PATCH v4 1/6] iio: Add output buffer support
Thread-Topic: [PATCH v4 1/6] iio: Add output buffer support
Thread-Index: AQHXleT0RPu5QhuEYE2Ka8Lq9NDbTquMRgmAgBkMPJA=
Date:   Thu, 16 Sep 2021 10:57:38 +0000
Message-ID: <SJ0PR03MB579102D7D6E1E6D95E8FBA4A99DC9@SJ0PR03MB5791.namprd03.prod.outlook.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
        <20210820165927.4524-2-mihail.chindris@analog.com>
 <20210830170555.25887e82@jic23-huawei>
In-Reply-To: <20210830170555.25887e82@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWNoaW5kcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1lNWM4NzY1Ny0xNmRjLTExZWMtODNmNi05OGU3?=
 =?us-ascii?Q?NDNlYTZmNDhcYW1lLXRlc3RcZTVjODc2NTgtMTZkYy0xMWVjLTgzZjYtOThl?=
 =?us-ascii?Q?NzQzZWE2ZjQ4Ym9keS50eHQiIHN6PSIxNjk0NiIgdD0iMTMyNzYyNjM0NTY1?=
 =?us-ascii?Q?OTE2MTc3IiBoPSI5NUtucUp6QmJma0tiRWRJUktyNjArYnJIT1E9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NB?=
 =?us-ascii?Q?QUFSRnIrbzZhclhBVjNNbUhhSk4wMUJYY3lZZG9rM1RVRURBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQU9ZMFFLZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?YVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpB?=
 =?us-ascii?Q?RjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFk?=
 =?us-ascii?Q?UUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFE?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9t?=
 =?us-ascii?Q?ZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0fb8645-d976-4cf3-ea55-08d97900cc30
x-ms-traffictypediagnostic: SJ0PR03MB5869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR03MB5869F365902F721180BCF14399DC9@SJ0PR03MB5869.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpDYMy+P5GiTXmmyj1Ya3CWUd9CECjVkvH+PzvnoerbosH4xDkSTnwb1ujxcRNFkihjvEmvYZpEY0+s4MPRpmB+QxHS32IPmCuOH9YlRqa4kDtqgpr+CR3uhlYVKaL1GYrm0G+oh5xFKtlWNvY9oSlGC8iOcekCZiYgaq/UvdkYlpybSjyo94nRksZfDq0QnABpS6eTlqI2mYT5KZTh07mphq9VradROdZwBiGUI2ZUhRXNHvIseTUglrWeBlBnjB8Sc2LRVCglPkaNDW8Km1mp/GQ8xmFINWiNwkRnrFKDUbLp9YRrjzhTthMynVTLFDdBuslYh3QKL3Es8zNUzhPqT8ke/beNaFKM7oLP17iW8Vr4+9WyJvaPjjkzhdE8IEBZN/WZMILVlTfIvu24BcznMw7pVlkCgw49qFB7h+pNSXsQV8/hRHKIrm63+XwXt1ACHLhBWxlC2dwkTyIzf145hJi5151iqzRDp55Yzl5GVqPFKtgQT73kj8XIvL3xaJGfNWky+jy6cK6CtS+PZFgoXunaM+qemOUfLoHWVZGhtVu+9NoaO5J4iaPdB4qqe08I4nRmLJE6OTIIkblTOawXqX5e5ruLISZQELF/nihBFaQmQPpVaB4Yiz0mclBkFkBzvLQB/5TkvjFr7Q3W2Ot4jckXhX99isjWfvdNeaGbxR9QK9AbALgT/a+OY4P20UArxeOD70h1cwA67d5vQ/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5791.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(6506007)(86362001)(76116006)(122000001)(2906002)(26005)(8676002)(71200400001)(64756008)(8936002)(33656002)(66556008)(478600001)(66946007)(38100700002)(186003)(53546011)(5660300002)(6916009)(316002)(52536014)(66446008)(83380400001)(66476007)(9686003)(54906003)(7696005)(55016002)(38070700005)(107886003)(4326008)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j3NcAof+jPTfnheVb6wJ9Zb9PT+aErTo6MEG2LQblJ7sMJKjwSsWTWdvvlOc?=
 =?us-ascii?Q?UJIxSqAZg12LODaBtzleUH8+988aVRcMZlQ09XWDKMXFheo7KAG7x5ZTE5CV?=
 =?us-ascii?Q?yqtUho1wqt0dk4ChM3VZzC2bkdAw0GAgHzn19TH84g+x94pLuipehUzJoGM+?=
 =?us-ascii?Q?oQJpPPtvQDamNZbeDYCMY7MDccos6ll8pWpF0mIS4mJVUaAQBnTYNcFpyJt0?=
 =?us-ascii?Q?mPTzH4g+nkD+uV2UQgJ1dd4zSK4iCHy1oaYPNlJqsk2O3HdhbsZC8skUwFNE?=
 =?us-ascii?Q?Syimk5hNBfxZ4zZB+x1ck4/xulrdWFivZnUzcKp9OaRdQDXXHsG3UNVUxEbp?=
 =?us-ascii?Q?rjaFGEaueL+C2qspw4M5fmD5qLeqU7H1j1NYk7tipDBtkBpQm/S1tz1xZNpt?=
 =?us-ascii?Q?//z7NmtIAOBaF8gEIEjvjI694Ina4V4n3FU9RAdoVxo4O2rRCuqLVtxbGnJo?=
 =?us-ascii?Q?wb+luWi0UjfywKFGEonmOPTjnzbLF0Mu0DSXU8IGmVzaktSbUgtuLbOFsU8I?=
 =?us-ascii?Q?cgiJN9PzV/LYJYp/6viZxbjqrdIZAU4jE4UrgdSjSnqQvsc6eCCbYbS7fP2b?=
 =?us-ascii?Q?tzjvRZ8D7TSs9vg0HOfNGcLjAiuRQhL7qN9YlfryYWgJXopGAnCtXaaH6IqA?=
 =?us-ascii?Q?h0I7DDf42pzrwDtqOuzb/Jey6lr1oH8qs0t7OgD7D1n+X+VVLs4ff4Wq/SzG?=
 =?us-ascii?Q?kslqW28wEcbAocn8j9NTNL2zpXfAAd5mY/+uT9NgBiJSDoZyUbST0W7dyGRB?=
 =?us-ascii?Q?LclMima0SDO+vWQIJTqUNwl+lTHGY2MUM0TFb65T4lbMFreFC7qxvd3pALH2?=
 =?us-ascii?Q?kGhyFm4BRMX7c/CrqoecamTaghwAD4SkrIAQFd8ygdefvlfuPFeP4O4CbRjQ?=
 =?us-ascii?Q?Dzdnah8J0No+v2ebyVtT5usI2ueg99xadTAy4q/eoferpYCjlldyA3Woj6Br?=
 =?us-ascii?Q?DqwG1kCv9lIDx+lQejxawA6IteAvTVQWTQZ2r4t2aszlNWZUnQl1PRm0iUYs?=
 =?us-ascii?Q?DGsO9j+FXAg4yvj5GQzKroPOXJsYnX5VcruVhC0QyS+Mp8piXSHrs7uw1Uny?=
 =?us-ascii?Q?sZUFPwZ4sbsYVq3aYPlrJt6P6yDvWomReu/z9c7Itz2uJR6c7RRJqEDlxiDP?=
 =?us-ascii?Q?ZH3clhcYSWRdXmCbz6/AxYFdiJ3aoFMzFcQ97zkWuIZxJJFKH/QKPyA2kASY?=
 =?us-ascii?Q?/plc8uLrTA8MHsePeNkN3tUos0QL/EQ9b786O92yIgFQOq8/bIpoiNw3644W?=
 =?us-ascii?Q?yzouRM5Qo4H0x1yMvm5I9jreuOYz4r8acjmX4him81JoZslc6DegHqRbqu80?=
 =?us-ascii?Q?IOo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5791.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fb8645-d976-4cf3-ea55-08d97900cc30
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 10:57:38.0283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EacCfdV7KwLoCRp7s+gcCQbGS+kSU0TdjdqFMxcpv19FN8BqsBHPkIg89k1y2V/pAiaOtgcspUNKtdjN/KjRtj/Yn+hpiEEwretbJVo7b2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5869
X-Proofpoint-ORIG-GUID: lf8knRlb2CD0R07CowM70RZF0UxpxZbD
X-Proofpoint-GUID: lf8knRlb2CD0R07CowM70RZF0UxpxZbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_03,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160069
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, 30 August 2021 19:06
> To: Chindris, Mihail <Mihail.Chindris@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; lars@metafoo=
.de;
> Hennerich, Michael <Michael.Hennerich@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; Bogdan, Dragos <Dragos.Bogdan@analog.com>;
> alexandru.ardelean@analog.com
> Subject: Re: [PATCH v4 1/6] iio: Add output buffer support
>=20
> On Fri, 20 Aug 2021 16:59:22 +0000
> Mihail Chindris <mihail.chindris@analog.com> wrote:
>=20
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >
> > Currently IIO only supports buffer mode for capture devices like ADCs.
> > Add support for buffered mode for output devices like DACs.
> >
> > The output buffer implementation is analogous to the input buffer
> > implementation. Instead of using read() to get data from the buffer
> > write() is used to copy data into the buffer.
> >
> > poll() with POLLOUT will wakeup if there is space available for more
> > or equal to the configured watermark of samples.
> >
> > Drivers can remove data from a buffer using
> > iio_buffer_remove_sample(), the function can e.g. called from a
> > trigger handler to write the data to hardware.
> >
> > A buffer can only be either a output buffer or an input, but not both.
> > So, for a device that has an ADC and DAC path, this will mean 2 IIO
> > buffers (one for each direction).
> >
> > The direction of the buffer is decided by the new direction field of
> > the iio_buffer struct and should be set after allocating and before
> > registering it.
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> Hi Mihial,
>=20
> Welcome to IIO (I don't think I've seen you before?)
>=20
> Given the somewhat odd sign off trail I'd add some comments to the
> description (probably not saying that everyone who works on this ends up
> leaving Analog.
> It's not cursed! Really it's not ;)  Lars and I discussed this at least 7=
+ years ago
> and he lasted ages at Analog after that *evil laugh*
>=20
> I'm not really clear how the concept of a watermark applies here. It feel=
s like
> it's getting used for two unrelated things:
> 1) Space in buffer for polling form userspace.  We let userspace know it =
can
>    write more data once the watermark worth of scans is empty.
> 2) Writing to the kfifo.  If a large write is attempted we do smaller wri=
tes to
>    transfer some of the data into the kfifo which can then drain to the h=
ardware.
>    I can sort of see this might be beneficial as it provides batching.
> They are somewhat related but it's not totally clear to me they should be=
 the
> same parameter.  Perhaps we need some more docs to explain how watermark
> is used for output buffers?
>=20
> As it stands there are some corner cases around this that look ominous to=
 me...
> See inline.
>=20
Hi Jonathan,
Yes, it my first time here, nice to meet you.

I will remove the watermark related code in the next version. It seems in o=
ur
Kernel it is not used and I can't think of an use case where it can really =
be needed.

> > ---
> >  drivers/iio/iio_core.h            |   4 +
> >  drivers/iio/industrialio-buffer.c | 133 +++++++++++++++++++++++++++++-
> >  drivers/iio/industrialio-core.c   |   1 +
> >  include/linux/iio/buffer.h        |   7 ++
> >  include/linux/iio/buffer_impl.h   |  11 +++
> >  5 files changed, 154 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h index
> > 8f4a9b264962..61e318431de9 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file *filp,
> >  				 struct poll_table_struct *wait);  ssize_t
> > iio_buffer_read_wrapper(struct file *filp, char __user *buf,
> >  				size_t n, loff_t *f_ps);
> > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user =
*buf,
> > +				 size_t n, loff_t *f_ps);
> >
> >  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> > void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
> >
> >  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)  #define
> > iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> > +#define iio_buffer_write_outer_addr (&iio_buffer_write_wrapper)
> >
> >  void iio_disable_all_buffers(struct iio_dev *indio_dev);  void
> > iio_buffer_wakeup_poll(struct iio_dev *indio_dev); @@ -83,6 +86,7 @@
> > void iio_device_detach_buffers(struct iio_dev *indio_dev);
> >
> >  #define iio_buffer_poll_addr NULL
> >  #define iio_buffer_read_outer_addr NULL
> > +#define iio_buffer_write_outer_addr NULL
> >
> >  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev
> > *indio_dev)  { diff --git a/drivers/iio/industrialio-buffer.c
> > b/drivers/iio/industrialio-buffer.c
> > index a95cc2da56be..73d4451a0572 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -161,6 +161,69 @@ static ssize_t iio_buffer_read(struct file *filp, =
char
> __user *buf,
> >  	return ret;
> >  }
> >
> > +static size_t iio_buffer_space_available(struct iio_buffer *buf) {
> > +	if (buf->access->space_available)
> > +		return buf->access->space_available(buf);
> > +
> > +	return SIZE_MAX;
> > +}
> > +
> > +static ssize_t iio_buffer_write(struct file *filp, const char __user *=
buf,
> > +				size_t n, loff_t *f_ps)
> > +{
> > +	struct iio_dev_buffer_pair *ib =3D filp->private_data;
> > +	struct iio_buffer *rb =3D ib->buffer;
> > +	struct iio_dev *indio_dev =3D ib->indio_dev;
> > +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > +	size_t datum_size;
> > +	size_t to_wait;
> > +	int ret;
> > +
> > +	if (!rb || !rb->access->write)
> > +		return -EINVAL;
> > +
> > +	datum_size =3D rb->bytes_per_datum;
> > +
> > +	/*
> > +	 * If datum_size is 0 there will never be anything to read from the
> > +	 * buffer, so signal end of file now.
> > +	 */
> > +	if (!datum_size)
> > +		return 0;
> > +
> > +	if (filp->f_flags & O_NONBLOCK)
> > +		to_wait =3D 0;
> > +	else
> > +		to_wait =3D min_t(size_t, n / datum_size, rb->watermark);
>=20
> Why is the watermark relevant here?  We need enough space for the data as
> written whatever the watermark is set to.
> Been a while since I looked at equivalent write path, but I think there w=
e are
> interested in ensuring a hwfifo flushes out.  I'm don't think the same co=
ncept
> exists in this direction.
>=20
> > +
> > +	add_wait_queue(&rb->pollq, &wait);
> > +	do {
> > +		if (!indio_dev->info) {
> > +			ret =3D -ENODEV;
> > +			break;
> > +		}
> > +
> > +		if (iio_buffer_space_available(rb) < to_wait) {
> > +			if (signal_pending(current)) {
> > +				ret =3D -ERESTARTSYS;
> > +				break;
> > +			}
> > +
> > +			wait_woken(&wait, TASK_INTERRUPTIBLE,
> > +				   MAX_SCHEDULE_TIMEOUT);
> > +			continue;
> > +		}
> > +
> > +		ret =3D rb->access->write(rb, n, buf);
> > +		if (ret =3D=3D 0 && (filp->f_flags & O_NONBLOCK))
> > +			ret =3D -EAGAIN;
>=20
> Do we need to advance the buf pointer here and reduce n?  We may have
> written some but not all the data.
>=20
> > +	} while (ret =3D=3D 0);
> > +	remove_wait_queue(&rb->pollq, &wait);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * iio_buffer_poll() - poll the buffer to find out if it has data
> >   * @filp:	File structure pointer for device access
> > @@ -181,8 +244,18 @@ static __poll_t iio_buffer_poll(struct file *filp,
> >  		return 0;
> >
> >  	poll_wait(filp, &rb->pollq, wait);
> > -	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > -		return EPOLLIN | EPOLLRDNORM;
> > +
> > +	switch (rb->direction) {
> > +	case IIO_BUFFER_DIRECTION_IN:
> > +		if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > +			return EPOLLIN | EPOLLRDNORM;
> > +		break;
> > +	case IIO_BUFFER_DIRECTION_OUT:
> > +		if (iio_buffer_space_available(rb) >=3D rb->watermark)
>=20
> That's interesting.  We should probably make sure we update docs to make =
it
> clear that it has a different meaning for output buffers.  Guess that mig=
ht be
> later in this set though.
>=20
> > +			return EPOLLOUT | EPOLLWRNORM;
> > +		break;
> > +	}
> > +
> >  	return 0;
> >  }
> >
> > @@ -199,6 +272,19 @@ ssize_t iio_buffer_read_wrapper(struct file *filp,
> char __user *buf,
> >  	return iio_buffer_read(filp, buf, n, f_ps);  }
> >
> > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user =
*buf,
> > +				 size_t n, loff_t *f_ps)
> > +{
> > +	struct iio_dev_buffer_pair *ib =3D filp->private_data;
> > +	struct iio_buffer *rb =3D ib->buffer;
> > +
> > +	/* check if buffer was opened through new API */
>=20
> This is new.  We don't need to support the old API.  If we can make sure =
it
> never appears in the old API at all that would be great.
>=20
If I don't add this function I can't write to /dev/iio:deviceX from bash an=
d our current tools
won't work without it, ex. Libiio/iiod as I found doing some test. So, I th=
ink it will be useful
to have it, if it is ok.
> > +	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
> > +		return -EBUSY;
> > +
> > +	return iio_buffer_write(filp, buf, n, f_ps); }
> > +
> >  __poll_t iio_buffer_poll_wrapper(struct file *filp,
> >  				 struct poll_table_struct *wait)
> >  {
> > @@ -231,6 +317,15 @@ void iio_buffer_wakeup_poll(struct iio_dev
> *indio_dev)
> >  	}
> >  }
> >
> > +int iio_buffer_remove_sample(struct iio_buffer *buffer, u8 *data)
>=20
> sample or scan?  Sample would be a single value for a single channel, sca=
n
> would be updates for all channels that are enabled.
>=20
> > +{
> > +	if (!buffer || !buffer->access || buffer->access->remove_from)
> > +		return -EINVAL;
> > +
> > +	return buffer->access->remove_from(buffer, data); }
> > +EXPORT_SYMBOL_GPL(iio_buffer_remove_sample);
> > +
> >  void iio_buffer_init(struct iio_buffer *buffer)  {
> >  	INIT_LIST_HEAD(&buffer->demux_list);
> > @@ -807,6 +902,8 @@ static int iio_verify_update(struct iio_dev *indio_=
dev,
> >  	}
> >
> >  	if (insert_buffer) {
> > +		if (insert_buffer->direction =3D=3D IIO_BUFFER_DIRECTION_OUT)
> > +			strict_scanmask =3D true;
>=20
> As below, I'm surprised we can get to here..
>=20
> >  		bitmap_or(compound_mask, compound_mask,
> >  			  insert_buffer->scan_mask, indio_dev->masklength);
> >  		scan_timestamp |=3D insert_buffer->scan_timestamp; @@ -
> 948,6 +1045,8
> > @@ static int iio_update_demux(struct iio_dev *indio_dev)
> >  	int ret;
> >
> >  	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list,
> > buffer_list) {
> > +		if (buffer->direction =3D=3D IIO_BUFFER_DIRECTION_OUT)
> > +			continue;
>=20
> Given the below, how did it get into the list?  I think that check should=
 be
> enough that we don't need to check it elsewhere.
>=20
> >  		ret =3D iio_buffer_update_demux(indio_dev, buffer);
> >  		if (ret < 0)
> >  			goto error_clear_mux_table;
> > @@ -1159,6 +1258,11 @@ int iio_update_buffers(struct iio_dev *indio_dev=
,
> >  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> >  	mutex_lock(&indio_dev->mlock);
> >
> > +	if (insert_buffer->direction =3D=3D IIO_BUFFER_DIRECTION_OUT) {
>=20
> Can you do this outside of the lock as a sanity check before this functio=
n really
> gets going?
>=20
> > +		ret =3D -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> >  	if (insert_buffer && iio_buffer_is_active(insert_buffer))
> >  		insert_buffer =3D NULL;
> >
> > @@ -1277,6 +1381,22 @@ static ssize_t
> iio_dma_show_data_available(struct device *dev,
> >  	return sysfs_emit(buf, "%zu\n", iio_buffer_data_available(buffer));
> >  }
> >
> > +static ssize_t direction_show(struct device *dev,
> > +			      struct device_attribute *attr,
> > +			      char *buf)
> > +{
> > +	struct iio_buffer *buffer =3D to_iio_dev_attr(attr)->buffer;
> > +
> > +	switch (buffer->direction) {
> > +	case IIO_BUFFER_DIRECTION_IN:
> > +		return sprintf(buf, "in\n");
> > +	case IIO_BUFFER_DIRECTION_OUT:
> > +		return sprintf(buf, "out\n");
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> >  		   iio_buffer_write_length);
> >  static struct device_attribute dev_attr_length_ro =3D __ATTR(length, @=
@
> > -1289,12 +1409,20 @@ static struct device_attribute dev_attr_watermark_=
ro
> =3D __ATTR(watermark,
> >  	S_IRUGO, iio_buffer_show_watermark, NULL);  static
> > DEVICE_ATTR(data_available, S_IRUGO,
> >  		iio_dma_show_data_available, NULL);
> > +static DEVICE_ATTR_RO(direction);
> >
> > +/**
> > + * When adding new attributes here, put the at the end, at least
> > +until
> > + * the code that handles the lengh/length_ro & watermark/watermark_ro
> > + * assignments gets cleaned up. Otherwise these can create some weird
> > + * duplicate attributes errors under some setups.
> > + */
> >  static struct attribute *iio_buffer_attrs[] =3D {
> >  	&dev_attr_length.attr,
> >  	&dev_attr_enable.attr,
> >  	&dev_attr_watermark.attr,
> >  	&dev_attr_data_available.attr,
> > +	&dev_attr_direction.attr,
> >  };
> >
> >  #define to_dev_attr(_attr) container_of(_attr, struct
> > device_attribute, attr) @@ -1397,6 +1525,7 @@ static const struct
> file_operations iio_buffer_chrdev_fileops =3D {
> >  	.owner =3D THIS_MODULE,
> >  	.llseek =3D noop_llseek,
> >  	.read =3D iio_buffer_read,
> > +	.write =3D iio_buffer_write,
> >  	.poll =3D iio_buffer_poll,
> >  	.release =3D iio_buffer_chrdev_release,  }; diff --git
> > a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 2dbb37e09b8c..537a08549a69 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1822,6 +1822,7 @@ static const struct file_operations
> iio_buffer_fileops =3D {
> >  	.owner =3D THIS_MODULE,
> >  	.llseek =3D noop_llseek,
> >  	.read =3D iio_buffer_read_outer_addr,
> > +	.write =3D iio_buffer_write_outer_addr,
> >  	.poll =3D iio_buffer_poll_addr,
> >  	.unlocked_ioctl =3D iio_ioctl,
> >  	.compat_ioctl =3D compat_ptr_ioctl,
> > diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> > index b6928ac5c63d..e87b8773253d 100644
> > --- a/include/linux/iio/buffer.h
> > +++ b/include/linux/iio/buffer.h
> > @@ -11,8 +11,15 @@
> >
> >  struct iio_buffer;
> >
> > +enum iio_buffer_direction {
> > +	IIO_BUFFER_DIRECTION_IN,
> > +	IIO_BUFFER_DIRECTION_OUT,
> > +};
> > +
> >  int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
> >
> > +int iio_buffer_remove_sample(struct iio_buffer *buffer, u8 *data);
> > +
> >  /**
> >   * iio_push_to_buffers_with_timestamp() - push data and timestamp to
> buffers
> >   * @indio_dev:		iio_dev structure for device.
> > diff --git a/include/linux/iio/buffer_impl.h
> > b/include/linux/iio/buffer_impl.h index 245b32918ae1..8a44c5321e19
> > 100644
> > --- a/include/linux/iio/buffer_impl.h
> > +++ b/include/linux/iio/buffer_impl.h
> > @@ -7,6 +7,7 @@
> >  #ifdef CONFIG_IIO_BUFFER
> >
> >  #include <uapi/linux/iio/buffer.h>
> > +#include <linux/iio/buffer.h>
>=20
> >
> >  struct iio_dev;
> >  struct iio_buffer;
> > @@ -23,6 +24,10 @@ struct iio_buffer;
> >   * @read:		try to get a specified number of bytes (must exist)
> >   * @data_available:	indicates how much data is available for reading f=
rom
> >   *			the buffer.
> > + * @remove_from:	remove sample from buffer. Drivers should calls this =
to
> > + *			remove a sample from a buffer.
> > + * @write:		try to write a number of bytes
> > + * @space_available:	returns the amount of bytes available in a buffer
> >   * @request_update:	if a parameter change has been marked, update
> underlying
> >   *			storage.
> >   * @set_bytes_per_datum:set number of bytes per datum @@ -49,6 +54,9
> > @@ struct iio_buffer_access_funcs {
> >  	int (*store_to)(struct iio_buffer *buffer, const void *data);
> >  	int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
> >  	size_t (*data_available)(struct iio_buffer *buffer);
> > +	int (*remove_from)(struct iio_buffer *buffer, void *data);
> > +	int (*write)(struct iio_buffer *buffer, size_t n, const char __user *=
buf);
> > +	size_t (*space_available)(struct iio_buffer *buffer);
> >
> >  	int (*request_update)(struct iio_buffer *buffer);
> >
> > @@ -80,6 +88,9 @@ struct iio_buffer {
> >  	/**  @bytes_per_datum: Size of individual datum including timestamp.
> */
> >  	size_t bytes_per_datum;
> >
> > +	/* @direction: Direction of the data stream (in/out). */
> > +	enum iio_buffer_direction direction;
> > +
> >  	/**
> >  	 * @access: Buffer access functions associated with the
> >  	 * implementation.

