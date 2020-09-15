Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7DF26A308
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIOKUt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 06:20:49 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:14948 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgIOKUp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 06:20:45 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FAFKL6025910;
        Tue, 15 Sep 2020 06:20:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 33h7pr8ha6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 06:20:25 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FAI45e028151;
        Tue, 15 Sep 2020 06:20:24 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 33h7pr8ha4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 06:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckBv4Ogc7YHlDJU/GloFuqmm3YyPELJnU+5dZ7j6BffVGMeZpc5A1giRuaa5oCTb5Se7neSgL2CKgWf6To2HNrYUGAkeDj2eaQEYb9zx7yBYlsKaumOnd0EFoS9/RK0VTaWahFnsAts2LbXDBDSWnU+UXmAz9nMBwTYLKnRcWRBg4ZAYPNAqFMMfdlD8lc7oZAWOqoMmaUADXjaAaGc0t7MmPRzDbqMqn1VtavbTIm/40MNKc6RJo20uQqm+T5dPmvzP8Pox7QAFLL+1EB5xQ4c6KmYLXOxfvTbu6wcfblJu4wgpX+FkQZBWiDlE1dVtKxsdiGcv8hP+H+wTsxMMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd+sLl/ULTJUPIlSq8q8GUPQaPZbBD+wYOziIBFAKl0=;
 b=YufeeK18zVdJYDqxk7z1f6ZP+ReXwlSIwtHRHc4aoFEFXWBFftxAsH5YuecYiWx+OGlORQCJV3elzOU/4BKTmqH15HkKQLuTOmk7uqprOJSxSRP/xcUgUIexiWdnln/EEoJJIxszENzsV1hmTgzdHx/h6ogR2xSlZk966zfEAsOCHOt8vKAYxb8mNLcDLKpUP9BmbjlysSEJrlZ4DFQkE2/30z+vklTJO7eMOhGABE6pEUsRzPVr8zDm/EF2hBUVhFX0f5w3Cew24b2rKDYh6uaTsXSnbOuu1pQPlfRCxkmf0Y2Y1hjWMI0hd4Ekwc9g4h0D1BZvKoYJnfw2bCL5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd+sLl/ULTJUPIlSq8q8GUPQaPZbBD+wYOziIBFAKl0=;
 b=Tvj/gicmAEnLQVztGgPJgO7sojl0Wemow4uyr8vPDnNt+icn5Zq700SaLI65w3IkkAKVvt938TmEiOX3PEBkUwnLifmXntbXry/W66UmISvQLPgb+Nf5cJKLFlH2YbBUkyRECsrbomlQRt9RAZhvRDuVTSzidsDrXK8sQasLezM=
Received: from CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:74::18)
 by CY4PR03MB3272.namprd03.prod.outlook.com (2603:10b6:910:5b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 15 Sep
 2020 10:20:21 +0000
Received: from CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::355a:8cf8:4345:1ce8]) by CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::355a:8cf8:4345:1ce8%10]) with mapi id 15.20.3370.019; Tue, 15 Sep
 2020 10:20:20 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [PATCH 10/10] iio: adis: Drop non Managed device functions
Thread-Topic: [PATCH 10/10] iio: adis: Drop non Managed device functions
Thread-Index: AQHWi0MyJJMBeI/ZRE+uSeHkfWLyealpekmAgAACMuA=
Date:   Tue, 15 Sep 2020 10:20:20 +0000
Message-ID: <CY4PR03MB2631DD532FE132207FCE3E9799200@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20200915093345.85614-1-nuno.sa@analog.com>
        <20200915093345.85614-11-nuno.sa@analog.com>
 <20200915111015.00004707@Huawei.com>
In-Reply-To: <20200915111015.00004707@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMTJlZDQ3NDUtZjczZC0xMWVhLThhYTQtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDEyZWQ0NzQ3LWY3M2QtMTFlYS04YWE0LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iOTM3NCIgdD0iMTMyNDQ2Mzg4Mj?=
 =?iso-8859-1?Q?gwOTQ2NzU2IiBoPSJJZTBxSWx2eFpOM3A3M00xZzErU1ZUMFJnTDQ9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJFOEVUVlNZdldBV1EvVkcwWm9CYTNaRDlVYlJtZ0ZyY0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQWRFS2R6d0FBQUFBQUFBQUFBQUFBQUo0?=
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
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea998ae0-c085-4703-a73f-08d85960f37d
x-ms-traffictypediagnostic: CY4PR03MB3272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB32726E7F0115F1B9AB909AC999200@CY4PR03MB3272.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKKWC/sPDdfw3/hjnFENByABBhbnHwQsXhNY8NDRoMjjPp04GsWsn3ajRx4CHJcKQSNO9xX5l7Ua/4TlJidkSydmBct2TICIbnb2t0afZ4J45etSPgN6S9c2X4rOW4fS0YLxC/PmXFVUSpKVwg3V4d7lRXD4HFTrbOe5JNd7osLauQo9+0eseif+nQD2xzzod7RIUXXR3k4rUqkq8q2pUwD1VikQv9a4ID+zUaYDwQfHkd1nCiat6f42tmHcydFEWmBNVI56UXsyw0XxvgZxhx/nwLGtI0KYkH4geIXyGe2XC+R5/YF2icINi5ED0Vo5KiibZz+hyrPgdng7iPEgRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2631.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(53546011)(86362001)(6916009)(8936002)(2906002)(9686003)(71200400001)(55016002)(7696005)(5660300002)(52536014)(66556008)(316002)(54906003)(478600001)(64756008)(6506007)(107886003)(66946007)(76116006)(66446008)(66476007)(33656002)(83380400001)(4326008)(8676002)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XG0fsRKCqLsclfDsP/o416PIvKxuNodmxlOYi8qTqtF8+S5jnEU6y4d6B2PoOdicXHpXsOdVx/uOWTwvc5tDFhoDNUw80M/S3Uy9wsaDm2R+yeo3OZwtRm2LUljaKFHqtdd/zpa+LURNDNE3nQcswRkB5vY7ueEvWBAzoN2oGOkS/E609VsAjsAlze5LyRtQCFsbT2pGRBBdZ6ee7MZWY4lIcJ2CqXZ0ACWC5U9kbNpz8j8XQBSbnVC9oRgak3dzZAT+wbdmmiNJSxzfeneHfBI3gBoM/GsdOaH17wt0K/8CHYqCo/k2/IZBxAIT7Im5Ojz1hQ1Tuzm5ydk9I5PwAWf+GEEW1/2qZEvG1rxJzDpOjuyDFCPU8pH36ISl42U0AQoc3NR+adLwDmqlfvwi+Qjv62/B/E3ax0zKYZPYXYzjM0PW4K3npy+x0QpwllDQc+FjRFb9Y6/kxcxT0fYHIbOej0BGc4Yg5rUt8j89z/YzQ4464dP5gZFotOeVLQTv2VUfeADVsOX3EsWqpxxpk2NSBmThMonnTSVllv+M/CjaZnbCkOxWOVaN1EXoyKpl4cwxh3mPQ9sMdWLl+R4vIz1V2ruBM6BXWGJeiWz07HHgLlX2XjdSeeeiIH5pgDvkSGZdmSnDWEUD3b6GzyImxg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2631.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea998ae0-c085-4703-a73f-08d85960f37d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 10:20:20.7716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0sOvqrNFhvLY5F+hL0208JvrX1MfCm8DEbD4XzqSR/FuFjjVVRI+V3JA/IyKwehypLPGHJN7eNmmoUu7frd/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3272
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_05:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009150089
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Tuesday, September 15, 2020 12:10 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: linux-iio@vger.kernel.org; devel@driverdev.osuosl.org; Lars-Peter
> Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> Hartmut Knaack <knaack.h@gmx.de>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>; Bogdan, Dragos <Dragos.Bogdan@analog.com>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>
> Subject: Re: [PATCH 10/10] iio: adis: Drop non Managed device functions
>=20
> [External]
>=20
> On Tue, 15 Sep 2020 11:33:45 +0200
> Nuno S=E1 <nuno.sa@analog.com> wrote:
>=20
> > Drop `adis_setup_buffer_and_trigger()`. All users were updated to use
> > the devm version of this function. This avoids having almost the same
> > code repeated.
> >
> > Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
>=20
> Good to see this cleanup, as long as we tidy up the few issues in the
> earlier patches.
>=20
> Note I think I only commented on first instance of each thing to fix.
> Please carry them through all the patches.
>=20
> Thanks,
>=20
> Jonathan

So, I did thought about further cleaning the probe functions in order to ge=
t
rid of the remove function but it felt like a different series to me. Anywa=
ys, since
it's fine with you to include those changes here I will send a v2.

- Nuno S=E1
=20
> > ---
> >  drivers/iio/imu/adis_buffer.c  | 64 +++-------------------------------
> >  drivers/iio/imu/adis_trigger.c | 60 -------------------------------
> >  include/linux/iio/imu/adis.h   | 27 --------------
> >  3 files changed, 4 insertions(+), 147 deletions(-)
> >
> > diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffe=
r.c
> > index 5b4225ee09b9..df6144285470 100644
> > --- a/drivers/iio/imu/adis_buffer.c
> > +++ b/drivers/iio/imu/adis_buffer.c
> > @@ -169,48 +169,6 @@ static void adis_buffer_cleanup(void *arg)
> >  	kfree(adis->xfer);
> >  }
> >
> > -/**
> > - * adis_setup_buffer_and_trigger() - Sets up buffer and trigger for th=
e
> adis device
> > - * @adis: The adis device.
> > - * @indio_dev: The IIO device.
> > - * @trigger_handler: Optional trigger handler, may be NULL.
> > - *
> > - * Returns 0 on success, a negative error code otherwise.
> > - *
> > - * This function sets up the buffer and trigger for a adis devices.  I=
f
> > - * 'trigger_handler' is NULL the default trigger handler will be used.=
 The
> > - * default trigger handler will simply read the registers assigned to =
the
> > - * currently active channels.
> > - *
> > - * adis_cleanup_buffer_and_trigger() should be called to free the
> resources
> > - * allocated by this function.
> > - */
> > -int adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev
> *indio_dev,
> > -	irqreturn_t (*trigger_handler)(int, void *))
> > -{
> > -	int ret;
> > -
> > -	if (!trigger_handler)
> > -		trigger_handler =3D adis_trigger_handler;
> > -
> > -	ret =3D iio_triggered_buffer_setup(indio_dev,
> &iio_pollfunc_store_time,
> > -		trigger_handler, NULL);
> > -	if (ret)
> > -		return ret;
> > -
> > -	if (adis->spi->irq) {
> > -		ret =3D adis_probe_trigger(adis, indio_dev);
> > -		if (ret)
> > -			goto error_buffer_cleanup;
> > -	}
> > -	return 0;
> > -
> > -error_buffer_cleanup:
> > -	iio_triggered_buffer_cleanup(indio_dev);
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(adis_setup_buffer_and_trigger);
> > -
> >  /**
> >   * devm_adis_setup_buffer_and_trigger() - Sets up buffer and trigger f=
or
> >   *					  the managed adis device
> > @@ -220,7 +178,10 @@
> EXPORT_SYMBOL_GPL(adis_setup_buffer_and_trigger);
> >   *
> >   * Returns 0 on success, a negative error code otherwise.
> >   *
> > - * This function perfoms exactly the same as
> adis_setup_buffer_and_trigger()
> > + * This function sets up the buffer and trigger for a adis devices.  I=
f
> > + * 'trigger_handler' is NULL the default trigger handler will be used.=
 The
> > + * default trigger handler will simply read the registers assigned to =
the
> > + * currently active channels.
> >   */
> >  int
> >  devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev
> *indio_dev,
> > @@ -248,20 +209,3 @@ devm_adis_setup_buffer_and_trigger(struct adis
> *adis, struct iio_dev *indio_dev,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_adis_setup_buffer_and_trigger);
> >
> > -/**
> > - * adis_cleanup_buffer_and_trigger() - Free buffer and trigger resourc=
es
> > - * @adis: The adis device.
> > - * @indio_dev: The IIO device.
> > - *
> > - * Frees resources allocated by adis_setup_buffer_and_trigger()
> > - */
> > -void adis_cleanup_buffer_and_trigger(struct adis *adis,
> > -	struct iio_dev *indio_dev)
> > -{
> > -	if (adis->spi->irq)
> > -		adis_remove_trigger(adis);
> > -	kfree(adis->buffer);
> > -	kfree(adis->xfer);
> > -	iio_triggered_buffer_cleanup(indio_dev);
> > -}
> > -EXPORT_SYMBOL_GPL(adis_cleanup_buffer_and_trigger);
> > diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trig=
ger.c
> > index 8afe71947c00..64e0ba51cb18 100644
> > --- a/drivers/iio/imu/adis_trigger.c
> > +++ b/drivers/iio/imu/adis_trigger.c
> > @@ -55,53 +55,6 @@ static int adis_validate_irq_flag(struct adis *adis)
> >
> >  	return 0;
> >  }
> > -/**
> > - * adis_probe_trigger() - Sets up trigger for a adis device
> > - * @adis: The adis device
> > - * @indio_dev: The IIO device
> > - *
> > - * Returns 0 on success or a negative error code
> > - *
> > - * adis_remove_trigger() should be used to free the trigger.
> > - */
> > -int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
> > -{
> > -	int ret;
> > -
> > -	adis->trig =3D iio_trigger_alloc("%s-dev%d", indio_dev->name,
> > -					indio_dev->id);
> > -	if (adis->trig =3D=3D NULL)
> > -		return -ENOMEM;
> > -
> > -	adis_trigger_setup(adis);
> > -
> > -	ret =3D adis_validate_irq_flag(adis);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret =3D request_irq(adis->spi->irq,
> > -			  &iio_trigger_generic_data_rdy_poll,
> > -			  adis->irq_flag,
> > -			  indio_dev->name,
> > -			  adis->trig);
> > -	if (ret)
> > -		goto error_free_trig;
> > -
> > -	ret =3D iio_trigger_register(adis->trig);
> > -
> > -	indio_dev->trig =3D iio_trigger_get(adis->trig);
> > -	if (ret)
> > -		goto error_free_irq;
> > -
> > -	return 0;
> > -
> > -error_free_irq:
> > -	free_irq(adis->spi->irq, adis->trig);
> > -error_free_trig:
> > -	iio_trigger_free(adis->trig);
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(adis_probe_trigger);
> >
> >  /**
> >   * devm_adis_probe_trigger() - Sets up trigger for a managed adis devi=
ce
> > @@ -137,16 +90,3 @@ int devm_adis_probe_trigger(struct adis *adis,
> struct iio_dev *indio_dev)
> >  }
> >  EXPORT_SYMBOL_GPL(devm_adis_probe_trigger);
> >
> > -/**
> > - * adis_remove_trigger() - Remove trigger for a adis devices
> > - * @adis: The adis device
> > - *
> > - * Removes the trigger previously registered with adis_probe_trigger()=
.
> > - */
> > -void adis_remove_trigger(struct adis *adis)
> > -{
> > -	iio_trigger_unregister(adis->trig);
> > -	free_irq(adis->spi->irq, adis->trig);
> > -	iio_trigger_free(adis->trig);
> > -}
> > -EXPORT_SYMBOL_GPL(adis_remove_trigger);
> > diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.=
h
> > index 2df67448f0d1..01ba691da2f3 100644
> > --- a/include/linux/iio/imu/adis.h
> > +++ b/include/linux/iio/imu/adis.h
> > @@ -517,14 +517,8 @@ struct adis_burst {
> >  int
> >  devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev
> *indio_dev,
> >  				   irq_handler_t trigger_handler);
> > -int adis_setup_buffer_and_trigger(struct adis *adis,
> > -	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void
> *));
> > -void adis_cleanup_buffer_and_trigger(struct adis *adis,
> > -	struct iio_dev *indio_dev);
> >
> >  int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_d=
ev);
> > -int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
> > -void adis_remove_trigger(struct adis *adis);
> >
> >  int adis_update_scan_mode(struct iio_dev *indio_dev,
> >  	const unsigned long *scan_mask);
> > @@ -538,33 +532,12 @@ devm_adis_setup_buffer_and_trigger(struct adis
> *adis, struct iio_dev *indio_dev,
> >  	return 0;
> >  }
> >
> > -static inline int adis_setup_buffer_and_trigger(struct adis *adis,
> > -	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *=
))
> > -{
> > -	return 0;
> > -}
> > -
> > -static inline void adis_cleanup_buffer_and_trigger(struct adis *adis,
> > -	struct iio_dev *indio_dev)
> > -{
> > -}
> > -
> >  static inline int devm_adis_probe_trigger(struct adis *adis,
> >  					  struct iio_dev *indio_dev)
> >  {
> >  	return 0;
> >  }
> >
> > -static inline int adis_probe_trigger(struct adis *adis,
> > -	struct iio_dev *indio_dev)
> > -{
> > -	return 0;
> > -}
> > -
> > -static inline void adis_remove_trigger(struct adis *adis)
> > -{
> > -}
> > -
> >  #define adis_update_scan_mode NULL
> >
> >  #endif /* CONFIG_IIO_BUFFER */
>=20

