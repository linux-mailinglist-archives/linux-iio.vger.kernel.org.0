Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0470C780E60
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377902AbjHROzr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377917AbjHROzN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 10:55:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2101.outbound.protection.outlook.com [40.107.114.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E719ACD;
        Fri, 18 Aug 2023 07:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWknxvzXGDF8PwgCe5NohRoWa6ZpDG6x6A6tvF3/n5w2D7y19RS+963fOTY86yZXhwo7cckRXtCjPE/aAqSj0YZGU1F9oKk/g8DfYv5/Xw5x/ULT7TEcfajub55as15VjHa8DHHxSXL7oBQz3WF2GecGc6v1FtMgn8/NLJBADcCNWCLkbHne9B8UNHsGsRH4H+MNQm1lHrTa0apDUlMtK3a6xLJN1v5NYwHdNbEJT0YshnI03kLX+PpPggeLhc5yBHbalP1J8I3ZkpqVQzLODQx5QBxCN7E7CzDmDMCpO36PufFXe6MTEkXTKVd20MNi+hT/ZHHXEC8OPmdpwxWcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r11iZorlEkm0p2cDg8gK9y0mKcgz2IGVQ1yh/TTAtTA=;
 b=K1T/lQImZlPJRxj7SrvvNLHYg0jO7RhUo13fTFFmNb5rv/Axe8RVYfrHFSTEIXwWx146EOnO4aexBrPc64TWJrevOKwV0Uh6pmmjhuAgYFSku4x39BnW1YW0AeOFoRc2D5SKIiQKeS/9lRhfw9+JbPybTOo9ut5QpETg9/k0AD/uwsXg6+4hVtDeOG+ov6LCJAG6O5BwmaC3vHWEdxCW5GlXGEf5DeIL1mWOOJWJ+BmdwQYWpE3A5P9+P5Sz2xHxvkU8KIFpBaoSTOuP9XvfBIuO1mCAdBL4fpqVzwHVBYcLJ48HW+eipBZ32HEQ/X28EWuhAiFXcj+imI1ToJ9YRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r11iZorlEkm0p2cDg8gK9y0mKcgz2IGVQ1yh/TTAtTA=;
 b=CQpHP14qLXgFdCN4man3mimmiXhGRNVzDqycYysiSaOv2fjXpCzPxIDReUwTC2pvBdAFbjMc2Xh0yJgRmXGJu7XcQLjCprZ7XY7jf5xrBCq2Mvui3B3cQZkK9XA/PRAunZzta+OMeqBlQRNxXzXQlh68WJw9KE25UgsqGruPYAs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYVPR01MB11118.jpnprd01.prod.outlook.com (2603:1096:400:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 14:55:06 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 14:55:06 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] iio: chemical: atlas-ezo-sensor: Simplify probe()
Thread-Topic: [PATCH] iio: chemical: atlas-ezo-sensor: Simplify probe()
Thread-Index: AQHZzTrgenQtz1lphU29hoocaXQ0rq/rdGOAgAS462A=
Date:   Fri, 18 Aug 2023 14:55:06 +0000
Message-ID: <OS0PR01MB59226DF48BFEE94A293969A6861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812163425.206044-1-biju.das.jz@bp.renesas.com>
 <ZNuQBXtiuiRIsI8T@smile.fi.intel.com>
In-Reply-To: <ZNuQBXtiuiRIsI8T@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYVPR01MB11118:EE_
x-ms-office365-filtering-correlation-id: f8f58e1c-3be0-4ae9-91fe-08db9ffb1c6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mUfD2oVA/bg0BY+6lFk5/AOqWr8bcZIindR7d1Eg+CJtymPDeleyx2DJ6FR7D7VkWPb537b9Kn+4BY6EBe9upayzlR3nSMQHGNG13iAoO7s34NLzjvCcOAUaTzn/jUUctLP28JVffoDVrsVUWRc426t0BVM8vDzWZVbXKFi3k9++FGH4txgLSRUPvY7sr7AjTqty/IR4qS/ma/DLTaw2amFnrVnnZ715g00s1PS6mRvZOjgthazVy4W1D6MncZGtrxGhJnqY8urTslMf+l+KoloTm0hwhwW4PRYSaUZa4LOg5/o99EkgKui5hJsxGnqaHb9rUSvmBfK4xMzJcxHGu6jy5haept49hymDa2N1wW25PvPVs+304Guk3SnFIVJ51Ha6GzPpVtOsYQeFrv8Yr530INRlzvlHTW37g/I0bxAqTT+w6so8W3UiP8EpdKDhYoqqU08ZHky/8pO+9y/O2e2JiMLGrf+IJ7iS5kmQlIDxMLsxe4YbyDCTgvMff8iKmIa6jaAi7N6/Aq8YZudDeRtih3HgbhAF6uHAng1rXNt4B4dhUVWzdLDrsyXP4pApNH0hfRhCS1IFYXf8Q/h8r5AC0EAHErx72/SK/3mOJohCMDonOwTdqrOx90ss/g8f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(316002)(71200400001)(26005)(6506007)(7696005)(9686003)(83380400001)(4326008)(5660300002)(8936002)(8676002)(52536014)(2906002)(4744005)(478600001)(41300700001)(76116006)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(38100700002)(38070700005)(122000001)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mdwIF3i0O5AdoGdnYdeNFmYyXBatWuaaSpZcUhMIROJO8SzZd6wSZThl0A?=
 =?iso-8859-1?Q?w6ZrOm1OpVUsMgqMmvX9pjmcbE9Gq7+AQhT/OSHLbzUvnAhF+dTnQTtW2y?=
 =?iso-8859-1?Q?+6P/q092RNBuRbqacrfh1smJLWDk8Fa/XoZ3zE4u+bTVBxfzaD+RMb5kXb?=
 =?iso-8859-1?Q?Rj1BBGpPgpb+XCcbIu5xmURxbRaTLLZmkRhK3sBsr7G+1zFxmxIol4pSiu?=
 =?iso-8859-1?Q?ZXF3P5ukbRS+Dg8Gr4w8rTK5Gk3zcOU6dDg6owOmUoP3hNrfOFdtVVSJUT?=
 =?iso-8859-1?Q?KRHZrjVDGe8LKcyM4MH20DrIOHmOQ1yg1l1+BQ6jAYMOm2aQqJUjjb2N1z?=
 =?iso-8859-1?Q?5JcYL4NKXF0mKuHBrHggL8IFjuLqn+bA4EyCR+yl2ho7sEQQ0kIF5E3Yu1?=
 =?iso-8859-1?Q?vk4g2+OaYqZbYe3n1/ud6Hq0l6BRFelQzrDA/VMAUQIQhw7nVdxI1wvylr?=
 =?iso-8859-1?Q?W24tfTb4AuC8LvIH03PlVWO5uK8vy0jAghCcftlbStuMXNwDDW1OBp0oht?=
 =?iso-8859-1?Q?yyrju2qtFe6geVNAB/4skPpxh5o3lNebBvG9DCxaLw18emZHQmnJySQTiK?=
 =?iso-8859-1?Q?woqbbjsfyL+ReK0/cIcR4vd6xEFUgvPwCYPlDKjlc46lK0JyES/fn+pKNl?=
 =?iso-8859-1?Q?Bf8t+WGU9ucUqPBvi0icd7yJta30+DuHwk2FjpkZ5sPSjhMmdg0FZcvNwT?=
 =?iso-8859-1?Q?2aTCAAGG5JwhU8uWriIx7T94l0YLRsEy7YboLfmL4vNlhUV2X7OoIqtrmq?=
 =?iso-8859-1?Q?uDw5ejosCt7/QpwIkhz54S1baxMVPWNxZX3KPppCWYj/TICxm2hp1OSSFB?=
 =?iso-8859-1?Q?cXmfrTAbpA/SsacXTt1b7Kn38AIWRHfCuurHbML6uMstLcQ2jjQOxbLcz4?=
 =?iso-8859-1?Q?vHJxt43/bA2KHEk5pghrdqg6raDB7IeBhfMCk+GczocGjB70/DNubqZIYC?=
 =?iso-8859-1?Q?K0usNZFMDxWWQ0YdOb+os5gLkFFJ6xzwZEp3Vwk0TP3r2I6KiogOt/Tdnk?=
 =?iso-8859-1?Q?TIKxRds9dkTKhZ29w7Orjtzrnd05KRLzCGTdf6fL0FpGLJ3ignxDSqpMbJ?=
 =?iso-8859-1?Q?D9J5nDzZHpHK9F7BD7qRHjPEZJHiVFYGx/wyBsNwW4TBCGN9cYFRwpk8SD?=
 =?iso-8859-1?Q?PzP9Rb2L41AxWfX3gqTsRYw1uECb+pW6tepKGN9/u7rvyJX2ptiFLbhBUX?=
 =?iso-8859-1?Q?Gz/3eXJMXrzgwMpVTUg2Ol832bj4FnbOUsE00jt6B3izcjuv3wj84oxIV+?=
 =?iso-8859-1?Q?rC49glujJ/SuwazFkly7OfEHFaJEHOdWzrxkm3NfDS17l2RjC16B6kgGnH?=
 =?iso-8859-1?Q?Db/E9R3tdgpgj0/5EO2tHxBZlQfTJ02jYhE9f1XT8HQdpkF0qtUOEUuIw1?=
 =?iso-8859-1?Q?/AS62Q3SxugNbALcK1Kv+Erqz2/T5bQbH1Pa1WZpL8ve/JSIF2VpkMFIzs?=
 =?iso-8859-1?Q?SbTHf0dPoA1lfhHO6a/CDFRybjrtU7AR/MGmVXnZPfetqUwy0nojlhNyKY?=
 =?iso-8859-1?Q?5W+EqK6kSU6vPH6CY5aV/at/jhJvW7XnHX6tq3PD+gG8LgH1OXrpmW0UT1?=
 =?iso-8859-1?Q?Mho7sXOjNU14FGDHzxpS4DCpT7fNlTzafO9BcgMy2Ck5j5ms3NmMAwZazd?=
 =?iso-8859-1?Q?B9aR++Si2mw2f+/8OgaSyX3P6DSaCJE9Wb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f58e1c-3be0-4ae9-91fe-08db9ffb1c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 14:55:06.5151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6qntxg1+vi0L8edyR0ihdiqyJCy0tTPA9ONZNc+Jcl5uvy/X0ks77NCbn9IdAN8jlbHNYAN4U7h7F1gOJvzc+Gv2teryedEYQhA5jIZf8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11118
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

> Subject: Re: [PATCH] iio: chemical: atlas-ezo-sensor: Simplify probe()
>=20
> On Sat, Aug 12, 2023 at 05:34:25PM +0100, Biju Das wrote:
> > Simplify the probe() by replacing device_get_match_data() and ID
> > lookup match by i2c_get_match_data() as we have similar I2C and
> > DT-based matching table.
>=20
> > While at it, drop id variable from probe() as it is unused.
>=20
> As somebody noticed, this "while at it" part is misleading.
> It's integral part of the change.

Agreed, will drop this and send v2.

Cheers,
Biju

>=20
> With that fixed,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

