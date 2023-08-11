Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42C8778F26
	for <lists+linux-iio@lfdr.de>; Fri, 11 Aug 2023 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjHKMSt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Aug 2023 08:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjHKMSs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2023 08:18:48 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2070e.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::70e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CB630CD;
        Fri, 11 Aug 2023 05:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4XfnLInqzi1vOh9CFqGkGHakv4JDqNJVWO5tJcyMPbsh77hp1uBnzr0unSHmHcVsVqq00Bt0Cn4SzMzEz1Z3STUtoTGpAdY+OwCMK8tr4FovGsnvSXbi5aQiUO+xyQggr8FybheP5cOUZEn1yfZLFkV1b88mhAGIhNiwDwzMJdcHjgg2Gl/szmZ9a8TNpv5B+RARDvgF5GHOYQmRKKEWY+UeuViZGM/T35foJ9JARMJRBSDaBIPGBLn9HNoaw5MupO4DzjI67eDgpChCimw3fR7hNHNACCuDX72H923qPfhwGQ3fNwN47t+ktPziN3XYfz7AjThkxI4CbUKyPw69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfem1byaGMfdt6YOmnssDyGCehDUhfCiuvS96olgqIE=;
 b=JLB2NwlVx1kfkwILmzx1cRdfYKcF4fhalMwF9wkxp8EXxbvt3eDYaqgtcm+AKBaRVnDgIXolP1TMHsTRs8K6BKQTRIQLM4g42wVCT3lDAenjUfbwztn8fHqXzEmYEtpsQ1+ll8ZiH0PNmECK7vS6vJ3VfYEWfkyJusp1IeoGKc1Rraa7+8F2JzaMxAML93vPROGwwLsbvnFvwDCBndj24/pXHkb8puaUPyxG3R1VHmOSCezYC5Kpgo6GZe5KRaiCCk8p/rL0aOPIL5RsEd5XzdCACzmNzY4+mrW98zsn6PIcqv0SOiQJIWYuTnMDKsXl3JE3Swa7kGuwuOZZRNCvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfem1byaGMfdt6YOmnssDyGCehDUhfCiuvS96olgqIE=;
 b=WW+qEaed2f7Ig8Gb+heeX7zysOYKMnd+D4lsAPzSWly+A/Z38B+kwOuA8cLEFXTM+KmZKh/2XrfiNcCbqF4ofC6G0Zcfj+X/+X2ROIimzdhwWKOSx8j4cKoqylA34e/70yjtIpPMrkx1U4eqIVApShW9GIl4Ks7Tk4crQwAzpFg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9901.jpnprd01.prod.outlook.com (2603:1096:400:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31; Fri, 11 Aug
 2023 12:17:05 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f4c1:5f6e:abd1:2bf9]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f4c1:5f6e:abd1:2bf9%6]) with mapi id 15.20.6652.031; Fri, 11 Aug 2023
 12:17:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andi Shyti <andi.shyti@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Crt Mori <cmo@melexis.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: magnetometer: ak8975: Simplify probe()
Thread-Topic: [PATCH 2/2] iio: magnetometer: ak8975: Simplify probe()
Thread-Index: AQHZyVQ9524VQMB69UuVzKcagMnErK/gX3AAgAReuDA=
Date:   Fri, 11 Aug 2023 12:17:05 +0000
Message-ID: <OS0PR01MB59224AE5EBD61C3CAB7ED4228610A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230807172548.258247-1-biju.das.jz@bp.renesas.com>
 <20230807172548.258247-2-biju.das.jz@bp.renesas.com>
 <ZNI9rIWa7bxNW9+P@smile.fi.intel.com>
In-Reply-To: <ZNI9rIWa7bxNW9+P@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9901:EE_
x-ms-office365-filtering-correlation-id: 89241877-8036-47e2-ea02-08db9a64e040
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ec8J2KYo2Z95SaGRxz+xZHakCYF/cUlWURFmzkqmNsTa0EprSYQK7Q+xQZppfHmoFPqmBQCPJqCqwk6k+cyYBpqf1YoiChRRn3LTih78sQp3uU4P8AsnSFHLg4shsnAy5oidogyMrxtg25ekfyXtdQTLJHKfYWOaMbZZXN2WnFizeKrZXyjivwyPuRTkTMgfN18KwPSrfyMW4X5ddGvtqmJMO1ustfHhCLp1mSapy2JNLOgHyL660ajXMUv2MYCTB1TuabjftAivezeOIEZY/pyLNxk3mtNE4nCFmlJSEGCEfRhP3bWEAG5Q+FocKs/Ti2IF0oe5ndUfnCWEfnLZYJ5U/7A3mjTJ6KpoiEz0S2Qkf0owww1PUHlcYnltJs1aANEquC33tm8tW08sPDbNw0k5WewT+r6JV7dKi63RodsY4k7IHUXsv0xS3EPBAXXbngR6MZshPilul+2BbRubpDzvWbI2HiLIz7ApltmZeu8e+9HbAlR/T7899oYkGVhbLnVU7Mp8HfsyumIkl4OttspXmI+ZSayy6OGw9LSE8O6YiSMwUXJc3H5AK4eAJkcpF9nkYPmcFCI2IQPBfO+FoWtrbQOFlYY60EOXI6CspyOm8CYBrS2BlWPXETnUhNdd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(186006)(1800799006)(8936002)(6506007)(8676002)(26005)(41300700001)(33656002)(2906002)(4744005)(38100700002)(122000001)(38070700005)(86362001)(7416002)(55016003)(52536014)(5660300002)(9686003)(66446008)(66556008)(66476007)(6916009)(76116006)(4326008)(64756008)(66946007)(478600001)(7696005)(54906003)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rGEx3Usmp/boq6kNPaHA7HuEtLoQprQnfcKYCh8J/NtIXiH4vwWtmrN5aw?=
 =?iso-8859-1?Q?YIEjx4YmLhQCQO6MuILnBYicg4OSh5vbK4d0ioc9B2t2hUcAGzIMNQesfX?=
 =?iso-8859-1?Q?FDSYV6+bIYx4RO6lwgOGisvS0RsWBT+jd8YR5ZpTr29ksKuXvPxpHh9/Pf?=
 =?iso-8859-1?Q?zBFQFePpQRuZTbdVl9z+rqGx1t6CVkY24314AsN/7+DLD/6YHfGtMqDchv?=
 =?iso-8859-1?Q?y/StLCIVLBWL5gGZlp2sp1b75BjmTPOXUTSojwihPG23Njz0IbOnJ+1CKI?=
 =?iso-8859-1?Q?IRH2l3EqebK1Cpfine7dk+eFdlSrTsEPBoq7ne8I+RdeO7K4A/fBPCYvaT?=
 =?iso-8859-1?Q?BnqTWzatKtqN3bb8juerJUZI9mybmK6OcJdqY4zLhYvjvfJ/GVFVy8wC4o?=
 =?iso-8859-1?Q?QCcny4dxpmgJddPIsr4yrPSa7wThsCO3yHQl/ecibzBlOM7f8MsQE3QQJd?=
 =?iso-8859-1?Q?VigzF5JykTW5VoIuZpLFvoxX8oL573anH+OllqcsuQbp8jb2UdSy+c+EGB?=
 =?iso-8859-1?Q?e6l/kZgIZIKi2scj5dodacpJrE4G4UtcmWxVBvCA+LubZILxI/UdK4kg61?=
 =?iso-8859-1?Q?FfHgSx01IEjWoaTQNSa4aGiESMys8UL3w0vcryD3nwpQ6Nd4TFljcZrTYV?=
 =?iso-8859-1?Q?E9cYJ8uRs9hdR7ejLOyMC5bnlPrF0v9LmIwe9w48b/0SFlaArpFWqGmlYY?=
 =?iso-8859-1?Q?g80kHEeAO2xthIWke67j10HrKCJ71RTPYyuCQsZJRVdL2JYM2ofAiW/GFy?=
 =?iso-8859-1?Q?I6Kh/68sXMjS1glo5NxHcjpyZyrOKTqfXgpuzWdHlJ+hI5IaM+CPVkByG/?=
 =?iso-8859-1?Q?km9y0y8CP/JipdGb1la1zmU3oocW/IIFvvxVwgah4dYEW9jheSAYhfA8jM?=
 =?iso-8859-1?Q?HS0E1T8A0H+cPP5bRNg6PLoKH42J6Ze0VcRXINpYiYWjYRZg4lIojoNm3T?=
 =?iso-8859-1?Q?RBh12P60c1Qp6I5bYRGjetqnIBAnmpygG/8O/V6rIrVwMj4hatRPKhaqcu?=
 =?iso-8859-1?Q?SYuHHfifI9R6lbsV4mT3xiIUYTbBFzaM7ehWN485aHsSzldWvhcL9bXsik?=
 =?iso-8859-1?Q?tLH5RUFSMMxBvLRAWRUeBlEt7lGgC/pa0w0FgkI3BOKBkZOBtbHeB/9aVU?=
 =?iso-8859-1?Q?VP7nSheg0aqxCEjNZnuTWPHsIdcpze+H9jia3aqkdqUSoSSaLKen2hgkvQ?=
 =?iso-8859-1?Q?9wurE9bMcvJaAycjWfQEpS6qUSPdC/NnHQ9vaUvRSBYeh7jfQVuktWP8fF?=
 =?iso-8859-1?Q?aSOHi8ivB04Y7lMtFcGgcHYLqu0qPuhq0C12Cbjd5Q+tJZxB44ePWxUb4W?=
 =?iso-8859-1?Q?7XbaOYqHiCqGHTqhK7KEjmn9yXcEDb7s6128erIm8+NfkVK5u9O3CXLQz0?=
 =?iso-8859-1?Q?h2i7ijmiaBt476fKpnj/fTICXx5Y2l2w6NQQ2JnM9hLn/yyrDOQK89VXpH?=
 =?iso-8859-1?Q?dW3TugxjySHUi/2KUsVZbrw6N9aQ1D+EzUpJ/jnoFEkjkxv8KpCWXoCbCv?=
 =?iso-8859-1?Q?EHBvf+bVTBdqRXvfd8yqdLmRcN6Fnu8zowzpyUCpWsEqbQztf42Sn4yqRH?=
 =?iso-8859-1?Q?DspzHjDV1rbLdTpYL4q3+VFCwpPgRZ/i+PfvFd6StGhDXCESv+1WMmIHP7?=
 =?iso-8859-1?Q?DY2dvBe15ucI9RED28ZKTyw/U6SDqvGm5R?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89241877-8036-47e2-ea02-08db9a64e040
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 12:17:05.2583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpeU7Xih/GIKlh/csxAgv+aDjM05OjJ0kh3WvuThIe4hsb0ywUebjmxArel+f6iwcJU8lLIWW4oGlbARyA+0si6Qs++4UDBDhtaMd2kwxwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9901
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy Shevchenko,

Thanks for the feedback.

> Subject: Re: [PATCH 2/2] iio: magnetometer: ak8975: Simplify probe()
>=20
> On Mon, Aug 07, 2023 at 06:25:48PM +0100, Biju Das wrote:
> > Simplify the probe() by replacing device_get_match_data() and
> > i2c_client_get_device_id by i2c_get_match_data() as we have similar
> > I2C, ACPI and DT matching table.
>=20
> ...
>=20
> > -		name =3D dev_name(&client->dev);
>=20
> > -		name =3D id->name;
>=20
> > -	indio_dev->name =3D name;
> > +	indio_dev->name =3D dev_name(&client->dev);
>=20
> I believe this is an ABI breakage.

OK, will drop this patch as future=20
device_get_match_data() any will treat this as legacy table.

Cheers,
Biu


