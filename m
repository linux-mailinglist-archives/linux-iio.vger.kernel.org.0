Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121E8780E93
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 17:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377967AbjHRPHL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377962AbjHRPGp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 11:06:45 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194F3E40;
        Fri, 18 Aug 2023 08:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AexQEAmfFdnY1Nr/DCbafjPGKocR2cL22965ufCLbybajb2RQu4kUsRvBjKqnZhTrY8YJscV0v1G+Iybz+jNnUvfhiAY+ZT1kImeXIl7iI+SLNxu08dwW3VgfeBJhnfXsttaYOjvbtY0fDNdBTb4b+Hu8lM8dN+HCz+ll6YT3BaZveTyI31fvcT4biGWRyjN5nsEQdJRz5qKd8wbsVjGGsOqsZY+OFfWE+krzPVdHFf9RCkjtfIYPc18jcagaz5y6dCknAZRNZq/dDMAYveCqsmRqY5MUk97pqj8biOzK7jcaXg1if5QIP0lKb1m9b6r3W8xN9yRuHtt7tSJvnf7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/6BqiHYIk8YHKpN118+ZR6Vc6hCGgkEDnxJ0oItAn4=;
 b=cg+PzW8BPVkIXXAz9KhW5zAWwxZy/2S72FdcaLYncCNFsKgbHwbXWeE/06UDDdyrFi1//3jAq0slqf+XPNXtuiUGqKWrJCzAGzFYMdQIXUsYONvydJU0M4Es1N17iKtc5NxHu2dvF2l/0Rw9KxKi5fCgqNO+J+mLijA2sCEdWcV9FQ3YaI1d41dIRWIzZoEtwTeo7DNDJJ51DWFNZtddjD7Sra3Jc70Z7MbzDLmarWtZTCnFKDH3nmcgT/2ANU/q+h7rPS7jGfsC2kDvutSFtShCuOOkwnog2ia5s6YELo2lyolZjbM2/8iuWayaCGWwfIlRggKazR12MG5VWM24JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/6BqiHYIk8YHKpN118+ZR6Vc6hCGgkEDnxJ0oItAn4=;
 b=KF/iz+qxyY+v+fwLJMrofBHCQhoKS+Xs5jfQwHQ4a8Gg881/yem/N+ztdyRMcP9BUd46bQkwo5QR5lV/dcQM8ZynlXIQXMMGymbNnZT/0Qd9q1sP4ysUDk5GcE2pKt9b836oB+kRkahSMmLc1VLeBvb/BPQwH+jcwBmc14ce8dQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8018.jpnprd01.prod.outlook.com (2603:1096:604:163::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 15:06:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 15:06:39 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Thread-Topic: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Thread-Index: AQHZ0al+MNQOBUPx202UR8p64ZlFNa/v63YAgAACD9CAADj4AIAAAE4w
Date:   Fri, 18 Aug 2023 15:06:39 +0000
Message-ID: <OS0PR01MB5922B5219DA5411219178994861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
 <ZN9WVvo+pixspCsw@smile.fi.intel.com>
 <OS0PR01MB5922F95816931D3392CDAB8A861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZN+H2qiRxMh/x2In@smile.fi.intel.com>
In-Reply-To: <ZN+H2qiRxMh/x2In@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8018:EE_
x-ms-office365-filtering-correlation-id: 9ff1cf02-bf8e-426f-893e-08db9ffcb9a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVBK91nMJ2UYtnpMua8CFsODp5uY/cjlwsTr0oy4b49yUqnRWXYztpayWbIU0QgFTriAJDUQX7HbjRaOyYOZSq9x8/eoBlNZO7p2qnVatyxgdff00yvATduRAkQbYThgbfIpXBxZuUHWs4MYaaOSOGfhLMrm9uZGw0wC1r8uAADw3FBqjgAqTqgerDN18Ir1t/mysy6e7O99V/KjsSJsfjElmImwj3ftxRw3zfkDyh5fScBJILBHY8FWHKTnGC/zwRwkPaeoyro6FzlD3+2HjelBYkaBFeYBgfjZWwXXLKdF5OzSecKDze4cLL/0RiTWtM4cZR4Nv52iEUBpXUAJpqaqZJ3OfY9he3AzNKlAeV22fpGlZOsXVv19w2TvkVAjKc91EqUmV+i8HGJowDHqJ51caLfnObYyFWusAPysJ5Hvp70/HLOsFGpb4ViM6EEx+4zTTpSBdM37/h0WDWvUIH8LxRkXkZUKVyAT12glxhdI6NK3A82FufZ2HoHKXLcwolhkv1QI9TiNCCvfBK9EsaJlVJtB2iVxnZwhlv7JkI2FkpM6T+f3l3VQyprdtfux6sJ73D/hd6z/1UhkQ/LaFWk6r1vTtw7f3C2BDZJcxpAA9SKko4ab05vWSH5oT2Dj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199024)(1800799009)(186009)(26005)(71200400001)(7696005)(9686003)(6506007)(83380400001)(4326008)(5660300002)(8936002)(52536014)(8676002)(2906002)(478600001)(41300700001)(76116006)(54906003)(64756008)(316002)(66446008)(66476007)(66556008)(66946007)(6916009)(38070700005)(38100700002)(122000001)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yQoSUcJnR2VrLKNLHNNo+Gpi3gAud/xRIrl20T1eI2MTuUE+1u+ojA0yRm?=
 =?iso-8859-1?Q?pUo9610VF3yvOp+1Wl/Ua4lwO9pAK7iiYTCxcN0UcmHfsfVRGLUxO+c1sI?=
 =?iso-8859-1?Q?tX+obI9oubK99EBtGIm8ySRMmn11p2ed5Z5tWgWgJBjZb+wviAnR1BqT7j?=
 =?iso-8859-1?Q?PyNoFDl9wGhB7bGBxIVEAr6Vpignl0rGyj9zbpfg4y9ivDMeBp6kjzfm2Z?=
 =?iso-8859-1?Q?MtYwFq5D9BQ/51ACOB1S3qn1C2AoXb2mObrKs0+XuZKuZqqGPMJ9/Zf6QN?=
 =?iso-8859-1?Q?uerdlZWXYfm7RxqL8xvi2Myqwo0dQfzE3sQkfSSMuTBqI12lXgfFzhW7SF?=
 =?iso-8859-1?Q?OoN6rGEfRrN1B/TuPzDqi2ck5xI5su85hD4bOfzfN4oKeTJFhf7C+8ONwD?=
 =?iso-8859-1?Q?bTm4LJJdEz83QfYa7f1zqNdRkItg6kMEJB57/9Z9P1w5WB/URtRV546QGf?=
 =?iso-8859-1?Q?6uqYXOQ5Uhf7Dc7VMrDN6c+4AdLYXTZ6mlyYXazZCWEyCPWZxjZizOsy8A?=
 =?iso-8859-1?Q?UoNf0P/MkzzCErrSDaY/ArLqNZ6cqACcDSE8YIc+6XXJqLYJvgGd+8Tovc?=
 =?iso-8859-1?Q?tzWpeWBHK3j3OISifnGtPIibjPSZWSi0VUhCgF4dvPXovMV9uE7UzShGkk?=
 =?iso-8859-1?Q?7ZbWomJAxHxqKPCXa/zQJZF7pV17QHIEHsRgaw3K/XA/JL7PoAjJPk9gPw?=
 =?iso-8859-1?Q?ZFnYsyXuyfuMusn6q22ngfFH7zgs9Fp/SZ1FEliroBtKQVpStxHfqorZkj?=
 =?iso-8859-1?Q?sPlwyaxB0oZ6TfreQzgMsNI86kH8v1MNSwyD3jkNY/ltziCZwQrhcGWGfC?=
 =?iso-8859-1?Q?1bFVEpoFelTNHXcmLC1p+t56P5bicXpQRUs6NVJJo3t3UcgIb9uZ6DSJi4?=
 =?iso-8859-1?Q?5mVSPrb+14E5og9yNbYUupXie2Re7uPsDL1UDlH3YWAwfWkN9/NYDrFQ1O?=
 =?iso-8859-1?Q?2WkKZCl6xb8Fktcj1+e08/cMFjQiKtRjkc1A2d/y9o7k1/8eIKu/awPVGi?=
 =?iso-8859-1?Q?L0tZ0Sg2XIj75GicsLcoqjAwpcasHqCJTRdYfFgpNkRrUTwQNfO9/HCFMd?=
 =?iso-8859-1?Q?FCd60gUuMrUo/N8EdsoSmM6k6xIz3qvo/XNJIVbni7qnP8x/ingto+1jCe?=
 =?iso-8859-1?Q?2tOGJgizmZVBteIR1KfPXbIdUdm5JDQf9xMNTlR3p6+iNVGawmxwaMOaBU?=
 =?iso-8859-1?Q?FuMD8jo7S3ojbsfd2qYW0WhNahHsZjrP8KisbUxaZt8ygkHm+mGwzaCRcn?=
 =?iso-8859-1?Q?ehw4YFcufOPi84YmqJAGk6HnuXwk5I66upmO87VBsLvvRYx0FdHSv2dsiD?=
 =?iso-8859-1?Q?aGNfCm0Dyn1m+fdlNSKFgd5GAia6zGN3B8/72jZXTIPUZvZS6d9X3R6cNV?=
 =?iso-8859-1?Q?tJ9JFVJNqYUpGxE+EHPWQ6/17T320dk+xFO75fRFjzAtmaR2C9+kb1u4J4?=
 =?iso-8859-1?Q?Qpx5FYrm5sSog8fJoG/oCqskus4K0eUEUrX4A658jKho10h3uS2fyvCMiF?=
 =?iso-8859-1?Q?D73p016OgfhrKdF8cJbiUHiCRIKDUX4aMz/p02CI+OuOGrvAnloLtjegU9?=
 =?iso-8859-1?Q?R5NhuKgfKtkrIMo4cei0n1S/aZXuiaREVPf6J/6YSy+kj8quYm1EhQ0wOo?=
 =?iso-8859-1?Q?NWbe1Pzd+JTEBXkLA5mBbWNcsxVi/tHXdp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff1cf02-bf8e-426f-893e-08db9ffcb9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 15:06:39.8461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0re95i1nQtka3Jfr1q7aG2lVD9UNHhj46vUCYF88Ei0KrG4KtdPNM0nROiZYSl++o7T7DZO6GtxpfTf1XNU2jyd6PEnwJ4r+qQG+NsLTpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8018
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy Shevchenko,

> Subject: Re: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
>=20
> On Fri, Aug 18, 2023 at 11:39:03AM +0000, Biju Das wrote:
> > > On Fri, Aug 18, 2023 at 08:56:00AM +0100, Biju Das wrote:
> > > > Sort OF table alphabetically by compatibles.
> > >
> > > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Wrong, I haven't suggested that. See comment to the previous patch.
> > >
> > > And this is definitely wrong as Geert explained already why.
> > > You need to fix the code that handles the ID table first.
> >
> > That rule applicable only for fallback. I checked bindings and there ar=
e
> no fallbacks.
>=20
> You can't check the _whole_ world, so you checked only bindings that are =
in
> tree.
> But it doesn't matter as a user somewhere may use something you have no
> access to.

Yes true, for those not using tree can patch bindings and modify the
driver and dts accordingly.

If they are using tree, they must go with binding docs and update driver/bi=
ndings accordingly.

+ device_tree.

Cheers,
Biju
