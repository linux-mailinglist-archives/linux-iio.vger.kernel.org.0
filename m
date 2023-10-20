Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED17D09A0
	for <lists+linux-iio@lfdr.de>; Fri, 20 Oct 2023 09:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376396AbjJTHjq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Oct 2023 03:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376317AbjJTHjq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Oct 2023 03:39:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5EDAB;
        Fri, 20 Oct 2023 00:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwRsRsaRMRfZQlIkJx2YFUx9sE0TDc9wD6CGD9R51sscQBfCTPYdh5jXB/QHaIgi6HlOT+oLUkaTjtwb9p7mB+NYFWCc8q2IET/WIJ4y7qC3pYwRA9wZk7mWKezgJa00Qv8UVuNgOr3rv7FPOOrjRhtzMeEHxhxTFYbj6+wWgSW4BLAkmxnJ9to9GgTrZa5rHCTO2Y4SYfQkGqUOJ+8NcoHjyl2LvoW6k+mjZtC605UToiv4IVQPmiy6/xkmnWST44Sj9TdO29tHF9L8NEwNUrGSJYu2FNNVj8AHsoEdJrEduXzlNQ6SQdKBS8G/b1d9KJMATzJfiMdTMyROu8r4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udpc5rNL9uwwGXsxrVhOOqxuTuvoi+B8VbAdl7zVtYs=;
 b=PIlsDG7rX3AB9A+LS4NIGbDa368LrndnojkM2WinHCwPrJU25zZBji0P+sOEnrBrL6Xer9qQ7hZmUJ0Sovb91YjsFUgoNQT+6isW5DsH+lhYPqWSlNElfVnF1C3N2HPv1LhvYHWtY7URoOm3fEMzXhZEx9z0BSeD1V7Wg+1yBLJVaOOgw8Aca5OwisvXNJYinV1RgfBno5e5Q3+XHjuR+IoRm0RrqumXBXTGUT4ToFe6HfThEAc2OXE1+4CY2v4AALtbDhsXb0BE+lXtXD8b19kCgpqaXUUBrcN+bOOMmlrjTULbyKbTGUMKif/ZrJmCM0qliv0BFEdGrWEOtBvrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udpc5rNL9uwwGXsxrVhOOqxuTuvoi+B8VbAdl7zVtYs=;
 b=d2SwZ7Qc2vK2ZCvsICZPcpcIrpgtChIlIP6CA+CAF+dgetC2e4+W97lPXBE+FFU1Dnf9cfkWDpW3vqb5t1Tx49SXcvnnAHztRl0UsxYoZpFuwTa7T88TPXcZ6GbS7x/7S51Zp/DFkM2DMr3wlRoHlvDV+AOwyXuMlAMTaL2HJR4=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB7851.jpnprd01.prod.outlook.com
 (2603:1096:604:160::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 07:39:39 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::c848:a091:c2f8:c7f8]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::c848:a091:c2f8:c7f8%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 07:39:38 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Andr=E9_Apitzsch?= <git@apitzsch.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Thread-Topic: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Thread-Index: AQHZ0al0blpUu/Wm+0SusYyQOb+0BLBO2cgAgAClowCAANSSgIAACZOAgACvvWCAAAQnMIAAJZEAgAAEsqCAAK6WAIAAwo6w
Date:   Fri, 20 Oct 2023 07:39:38 +0000
Message-ID: <TYCPR01MB11269399FE198E67DAD1CA6F986DBA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
         <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
         <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
         <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
         <20231018204533.39399b0b@jic23-huawei>
         <82b99e17f45b09623eeaed12e4fac12609c15426.camel@apitzsch.eu>
         <TYCPR01MB11269EEF17ABCE541CC7B38CE86D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
         <TYCPR01MB11269D21D7DD5356A64E5679586D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
         <ZTD0UN4+wQjguCDF@smile.fi.intel.com>
         <TYCPR01MB11269269A3237CC119644F4D286D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <6191b1a5e4891fda992f6c0d57ea8f101429428a.camel@apitzsch.eu>
In-Reply-To: <6191b1a5e4891fda992f6c0d57ea8f101429428a.camel@apitzsch.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB7851:EE_
x-ms-office365-filtering-correlation-id: 6d95d36b-95b3-49c8-fc31-08dbd13fb700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UNlV8G4v7+0Pd9McCYmsb0w7E5zT93YQNZibF8CrMyYaoY1zgsKViRyicHioLdWED+sp3rIzK/XPsCGKkBliJEmxQVvPBb9rXLJ9FR9s2bAq8fCp8JsFf34OdvrSaP6oTGHYD7ahuFL9A3n+8X0n4Sp6Bx0wupYu4rUNDYwT4jYuYteCA0shUt3Carr73TvOitDrmN0AJQ/pFyFYmz7IA8pbLmRI73cHOEbt9iHtd3OEUBkG7C/ZzxW65DTeauUGQ7iXcOrSubD9iZxCabAMdj54AUzd+y/5GOFW8CLw5eN07HDlWrRh8MQ6RVb6wVvZ//ecLD/uiJJ46TNK7+nSGYL954y4mnU3KXfE8ko91aaH545RUZ/Wf7OqZBt6EAfRbz5m1IY9iLWPcCp5FK7tdDtGTO5rxtdnwvVvOiynmoMxW/xI7fj1tvVQlpx05IWuaq3oLH2J8E+xFpwlIGkN1vnJsIGmAughU2307cfRRiFga+rPlLo0JkV15KUllUoHWqoylTx8WOtR4zFFNr5uBbqw/uc94bukHScVgUeM+R1okUGSrn3iEz1zX855obMwbUxpTuui1IBPoiAURFb6wGPbFkvvh2ljBp+XKp6pteRHEiibUcWH+LBgWwbQo8fd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(122000001)(26005)(83380400001)(86362001)(38100700002)(33656002)(9686003)(38070700009)(5660300002)(55016003)(71200400001)(478600001)(7696005)(6506007)(2906002)(41300700001)(76116006)(64756008)(110136005)(66556008)(54906003)(66446008)(316002)(52536014)(66476007)(66946007)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7F+sQzyXPq58D/gxWRAHfu84INhgfMa2J0f2ogwhnKhOMlXS/jgdUb1AWW?=
 =?iso-8859-1?Q?W+Yim28+1fXixAft1wqzN/W4V1sFlxfVTHNQa5C4sGET6Mx/z1x/YlPyfy?=
 =?iso-8859-1?Q?nSH5EZlp7kwfgDegOJs5KSpKHKMNJhYHqdzXUnhqqdRLnGa8CeliGzgNQQ?=
 =?iso-8859-1?Q?GP2j9OM0VTMxIKXicXSY5C8zXX9EeoeltoqvubAkzhUJAf1NP8zjS08+ZX?=
 =?iso-8859-1?Q?rpBnTDAVapBcwEUaULyKc0JhzUb7+1BYYKUab+Pt7n20UDOP7cf/5rAM72?=
 =?iso-8859-1?Q?ezKngOAszBn8XXZnv5HGa6ne5pdxsHgrENxh2KEjsbcl+iR8SdemvuRC/T?=
 =?iso-8859-1?Q?2fjYAIapOGmDw7plsGGbHjTADlVBC+Mb3xELd0nKDUMcdZAyaEWgX+DUKh?=
 =?iso-8859-1?Q?Zv8rjfcZbCxMosAZ0yXBx2APiiMfI1BeKtpRlLKTvIENEw4xLdd5gCyYzX?=
 =?iso-8859-1?Q?MAp0FTjNSKhJu3D2M1Eg8dPUuv80upsXT015qEF44tIOJJM0Fnbb/OXuLY?=
 =?iso-8859-1?Q?qfh3Lpt00GPXD88xxrLZ12uH/nS5FaDRBmUD/+qG8JCFa9A0/Al+qg+6ep?=
 =?iso-8859-1?Q?qN7N+JwHTWzEYGglbIGQfPomsS1iiDz0STeTRE1GoiM0kzQsT0yHnOX6hh?=
 =?iso-8859-1?Q?0CG0mp/Jr8zAc14QFY45uAFfpyKtkr8YHM02q0OYj3SWiC08DcFqcH9mGg?=
 =?iso-8859-1?Q?rIE/99HCWeeKxQf6lZUtspVPppaHBqtj+R8T8K8ANuZfO1AJrmLmvRS0hJ?=
 =?iso-8859-1?Q?VDoVZHcgKOgIRiqdfNt8ObgoMNU+gVcmJtaq3HXzgy/8sHLXSaN1ajX8Ix?=
 =?iso-8859-1?Q?ZgYMSFXcRBfdeckaFuXgkktDSjhZwzl3s7zAxmzfVInyFkChsAbkA4omjc?=
 =?iso-8859-1?Q?o6aRPJnE1zyVXhzQJkiqt01mEBt6KDqolUXk/ttwDyaOXhkRuCyaFH/bU4?=
 =?iso-8859-1?Q?zvrHdKpJH1CIuGP24cP78n6jG97qRTLkuvKAxEgfUfaHivAcZxtf1spKyO?=
 =?iso-8859-1?Q?tcE8akqt/Vo7TZEINf/YNstLfusLF/FGkxcnpsPoByqpyw0w1hhCsTgU+t?=
 =?iso-8859-1?Q?TNWZuIs4HbbHCOxsnn4W2yzUHbN/yj8CICe0DLODKz42ZXY5COGAi8PCtp?=
 =?iso-8859-1?Q?W24XXFOvvOBqppaw0pn8L75sIiBppA3Az0j6yUQ9OdxNb5YAgvAObR2TuY?=
 =?iso-8859-1?Q?rfjlS1GwFoNK8nyd04LQ5arjilkpJdypuVRKxT0nbaZoWCPd4er0RjGKxx?=
 =?iso-8859-1?Q?ynXH+LgUgJ181qezMBwwhEPEBss2csb0Q/so3y0X0GPjjQ3NpSSWeWXfc4?=
 =?iso-8859-1?Q?BOsQGZwN2YXbIkjMt+TE+w/kiOgNxkK9Mt+64YxAUj/LpwrQ8rjp0/yz1a?=
 =?iso-8859-1?Q?DeUmPW0er7PPhrWF5C+KUUf2ac08YRiMJlvti31hxrWl9DX9F8d6uhOxB4?=
 =?iso-8859-1?Q?keTT17OeG6RNGxI2ay15cUHhP0DvyGBONzP2gHfxDzalGUE0nOVRXb0viq?=
 =?iso-8859-1?Q?t1ES2Ww6ziYmLHw6Tp4YhzNOWAReuH/I8gE8WIOfYPt8p5zQIFRGtQbRpG?=
 =?iso-8859-1?Q?C+M/XISPaazEAT5KPZXy788+cydmj3iF5puURrxyn3INGIuzfYKNPEJs0w?=
 =?iso-8859-1?Q?B2CcQPdWn8DczK1jJuj4y+jVkYrhgp6r4g4rzQuLfEx8sqCAp8hNpDmw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d95d36b-95b3-49c8-fc31-08dbd13fb700
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 07:39:38.5912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyfybKR/wlUxSmECZ01AdE8jcfoZb82J1c/76pk089lqWoRiCj103mRtIQWj1MFuAl0WV4XwTpfnV96aH+PK5LJaRqHAwC53uNW84tDN4yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7851
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andre,

> Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum-
> >pointer for data in the match tables
>=20
> Am Donnerstag, dem 19.10.2023 um 09:41 +0000 schrieb Biju Das:
> > > Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert
> > > enum-
> > > > pointer for data in the match tables
> > >
> > > On Thu, Oct 19, 2023 at 07:08:23AM +0000, Biju Das wrote:
> > > > > Subject: RE: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert
> > > > > enum-
> > >
> > > ...
> > >
> > > > > As mentioned in the patch.
> > > > > /* If enumerated via firmware node, fix the ABI */
> > > > >
> > > > > Looks like this issue is not introduced by this patch.
> > > > > The previous code uses device_get_match_data() which returns a
> > > > > match as it uses DT node and it uses dev_name(&client->dev)
> > > > > instead of
> > > > > id->name;
> > > > >
> > > > > Am I missing anything here? If it is just a test program, can it
> > > > > be
> > > fixed??
> > > > >
> > > > > Please correct me if I am wrong.
> > > >
> > > > I just realized that there is no .data in previous code for OF
> > > > tables.
> > > >
> > > > Maybe we should add a check, if it is DT node, return id->name?
> > > >
> > > > Is there any API to distinguish DT node from ACPI??
> > >
> > > Of course, but I discourage people to use that, you have to have a
> > > very good justification why you need it (and this case doesn't sound
> > > good enough to me, or please elaborate). Hence I leave it as a
> > > homework to find those APIs.
> >
> > Andre, complained that his test app is broken with this patch. I am
> > waiting for his response whether he can fix his test app?
> > If not, we need to find a solution. One solution is adding a name
> > variable and use consistent name across OF/ACPI/I2C tables for various
> > devices.
>=20
> Just to make it clear, the functionality of the test application
> (hwtest) is not affected by this patch. Only a less/none telling name is
> shown now in the Model column of its output.
>=20
> I'm not that familiar with the interfaces provided by the kernel. Is ther=
e
> another way to get the device name if not from for example
>=20
> /sys/bus/iio/devices/iio:device2/name
>=20
> (which now shows '0-000d' instead of 'ak09911')
>=20
> For the bmi160 device[1] the following code is used to get the name
>=20
> 	if (id)
> 		name =3D id->name;
> 	else
> 		name =3D dev_name(&client->dev);

This looks good, but what about introducing a new api to get device names f=
or
fwnodes. (strip vendor from compatible for OF and use name from ACPI id tab=
le)??
So that driver don't depend upon I2C ID to get device names for fw nodes??

Cheers,
Biju
