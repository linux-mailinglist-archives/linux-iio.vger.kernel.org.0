Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88013AF17
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 17:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgANQTx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 11:19:53 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:22120 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgANQTx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jan 2020 11:19:53 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EGANVs014495;
        Tue, 14 Jan 2020 11:19:31 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xfbvb80gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 11:19:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3aiGquvbvPF7qIRuT8Z31KnlJ8gwvON8pZ/T3bnj50LzbG+u4jynwEylUGDLIDrnueVJPqfKpmJahlZ835MBa1dBdtVZ7+1J4Xl72EjwQ1Yy5z+ee9CqKsP2uJBaMEdOMX5OYfK2c4g6AeSWXL91PrOyH3b+P50Nqhj/kLxh1M3HqJ6k06AygtNfeXWKgIJbewigYJMwRjCHKl0ZyF5y/EdJJvB6whnUATOoOcj/hn8vJJHr+2VseazmL/61edaDhgFyWT5k/D3RqMdWcV+FsuCPNcDFj0Qeh72BRrd8bLGYw/ryTWvLnqSGmE4KW0iw5TrIMzROnXXMVamX4dfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WfxVG0Dfpc11Yt49C/FxAy0/M9andAMqtCAg0LTHcQ=;
 b=JpmTtVf8vED0EL+Wit5+2Q/Lc9xxpoeasZkXot+JVWywspRDRbyx2nYq4wqxYvoDLKj5uA5Q0bJ8XPy2NqxPWteyqj5cKtJgvY1kvCiGHk7sEziF4QHdrwfoO7WV00T6vIUkwyJqXjQDU3FHdU76wbNgAI1CC/DBtwbqEHigFIW90eM4vpod/NmqRNv+dvvQ2xoDVqt8qJ0rshJUTpOOkc+HcoEhjrmJawVD1ZZ511JilmsptmMp6QaPC97qdMOMHX1BA1zBnFck3w4wXsXYNGxtEGNkhp+ILno4ujE4ouNF47rwcStRQCFhDzZeR8+EYkkeeL08m+YnoNxMSLKDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WfxVG0Dfpc11Yt49C/FxAy0/M9andAMqtCAg0LTHcQ=;
 b=3ra3QtoJl7iVGugZ+rLorIxJVhGKg5L277n0zDzSgoXuhEc//bA8oZBWZWYHi6cZFvWrY44WUhr512oSJRIuvKcAgKPs+JujseLJR4SLmcEHonSBOdEbbkt1QlYKRNMR1/mmRpHIeK0MeYLBEyj2X4cOU4kj8w2hzk/0md1fxjg=
Received: from BN6PR03MB2596.namprd03.prod.outlook.com (10.173.142.13) by
 BN6PR03MB3362.namprd03.prod.outlook.com (10.174.232.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 14 Jan 2020 16:19:28 +0000
Received: from BN6PR03MB2596.namprd03.prod.outlook.com
 ([fe80::4c96:2ad:9610:99d4]) by BN6PR03MB2596.namprd03.prod.outlook.com
 ([fe80::4c96:2ad:9610:99d4%3]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 16:19:28 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Bia, Beniamin" <Beniamin.Bia@analog.com>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "biabeniamin@outlook.com" <biabeniamin@outlook.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: RE: [PATCH] iio: frequency: adf4371: Fix divide by zero exception bug
Thread-Topic: [PATCH] iio: frequency: adf4371: Fix divide by zero exception
 bug
Thread-Index: AQHVxVxmuPaZEiKGZ0Wv4SEU2+Ds2qflVEUAgAUMRnA=
Date:   Tue, 14 Jan 2020 16:19:28 +0000
Message-ID: <BN6PR03MB25966D74469371C11AFC4E4C8E340@BN6PR03MB2596.namprd03.prod.outlook.com>
References: <20200107131559.17772-1-beniamin.bia@analog.com>
 <20200111110848.7c45a4f3@archlinux>
In-Reply-To: <20200111110848.7c45a4f3@archlinux>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1hMTNiODcwMS0zNmU5LTExZWEtOGZiYS00ODg5?=
 =?us-ascii?Q?ZTc3Y2RkZWZcYW1lLXRlc3RcYTEzYjg3MDMtMzZlOS0xMWVhLThmYmEtNDg4?=
 =?us-ascii?Q?OWU3N2NkZGVmYm9keS50eHQiIHN6PSIyODg1IiB0PSIxMzIyMzQ5MjM2NjAy?=
 =?us-ascii?Q?OTk5NzIiIGg9Im44cGNQU0RiWkk3TUxTaTFEWjhFYWQ5RWZUYz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUt3QkFB?=
 =?us-ascii?Q?REVUcXhqOXNyVkFhNllmRkFlMDVqa3JwaDhVQjdUbU9RQ0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUE4QVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBWWVqd1pRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFkQUJwQUdVQWNnQXhBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURJ?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca1e9841-8fbb-4256-3120-08d7990d8780
x-ms-traffictypediagnostic: BN6PR03MB3362:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB33623127A6E204FF6C2930448E340@BN6PR03MB3362.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(64756008)(66446008)(76116006)(55016002)(9686003)(66946007)(7696005)(66556008)(26005)(66476007)(110136005)(6506007)(316002)(54906003)(2906002)(86362001)(33656002)(52536014)(5660300002)(4326008)(45080400002)(478600001)(6636002)(186003)(8676002)(53546011)(81156014)(71200400001)(8936002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3362;H:BN6PR03MB2596.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hGLSUYJ+dAg2JIIRDp/ZsjA1yYg+2v7uZfXs06GpHhjCp+gvnzPnZos0nApW7+UYdLD2x3lX+dK939vqSvOWSMbTnOOtTv2M+TaFcD8anKaZxotihZGaAEFQUN/g1xGelHy+VigWnpQ2It7/af4GaOAo5PkYwahsn05FL1Q7ZzVmxeSp5KYjORMWH/fap6ccZPSh8CyoWvSi7/8LxxBpXuwedoD7pl5VNPUBRDBgHVFbyfNz3COylsvtga0D13Gpk0jJ+GbWl4fydGVW2/oQpETyUceOd42lyGDZVD81I1cB3UEDA1W6pPoXhysSe9kb5fA5i5wBtZ1iabrlBP66ZeRyWlTpWbtIkuAFvK4+6G/xXsVgbahXq4NN7W7edlgZjpj4KsT8kjC3uP+oW2ndllfOfgk7yeUiGNJCsOM3iYt0HlI3N/ufn5XB5XWc0+xZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1e9841-8fbb-4256-3120-08d7990d8780
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 16:19:28.1875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: essI/MnM/31vhQd721P0bDEC82ai3Vqv+Nmo71Na9fpmBjgsu5e1A4IWX3+H95AnU3fcd3cnfp+8vrl37wxTMcq4HPQNCPTHfDsvgAwcQQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3362
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_04:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140137
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Samstag, 11. Januar 2020 12:09
> To: Bia, Beniamin <Beniamin.Bia@analog.com>
> Cc: lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> pmeerw@pmeerw.net; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; biabeniamin@outlook.com; knaack.h@gmx.de
> Subject: Re: [PATCH] iio: frequency: adf4371: Fix divide by zero exceptio=
n bug
>=20
> On Tue, 7 Jan 2020 15:15:59 +0200
> Beniamin Bia <beniamin.bia@analog.com> wrote:
>=20
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >
> > During initialization adf4371_pll_fract_n_get_rate() is called on all
> > output channels to determine if the device was setup. In this case
> > mod2 is zero which can cause a divide by zero exception.
> > Return before that can happen.
> I'm confused by this description vs the code.
>=20
> As far as I can see fract_n_get_rate is only called on a sysfs read of th=
e
> frequency.

That's not the case. The failure mechanism comes via adf4371_channel_config=
().
It calls adf4371_pll_fract_n_get_rate() prior adf4371_set_freq() which init=
ializes=20
st->mod2 via adf4371_pll_fract_n_compute(). This only happens the first tim=
e=20
during probe and setup. So the solution was to return 0 if st->mod2 =3D=3D =
0.

-Michael

>=20
> mod2 is set when fract_n_compute is called in the relevant set_freq calls=
.
> This seems to occur on a sysfs set frequency call.
>=20
> So the issue here is that a sysfs read before a write of the frequency wi=
ll cause a
> div zero?  If so, is there a sane set of initial values we can put in mod=
2 and
> friends before exposing them via the device register?
>=20
> If mod2=3D=3D0 is a valid value and indicates for example that the channe=
l is turned
> off, then the description should make that clear.
>=20
> Jonathan
>=20
> >
> > Fixes: 7f699bd149134 ("iio: frequency: adf4371: Add support for
> > ADF4371 PLL")
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> > ---
> >  drivers/iio/frequency/adf4371.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/iio/frequency/adf4371.c
> > b/drivers/iio/frequency/adf4371.c index e2a599b912e5..c21462238314
> > 100644
> > --- a/drivers/iio/frequency/adf4371.c
> > +++ b/drivers/iio/frequency/adf4371.c
> > @@ -191,6 +191,9 @@ static unsigned long long
> adf4371_pll_fract_n_get_rate(struct adf4371_state *st,
> >  	unsigned long long val, tmp;
> >  	unsigned int ref_div_sel;
> >
> > +	if (st->mod2 =3D=3D 0)
> > +		return 0;
> > +
> >  	val =3D (((u64)st->integer * ADF4371_MODULUS1) + st->fract1) * st-
> >fpfd;
> >  	tmp =3D (u64)st->fract2 * st->fpfd;
> >  	do_div(tmp, st->mod2);

