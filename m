Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C158377CEA4
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbjHOPDs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjHOPDn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 11:03:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E78A138;
        Tue, 15 Aug 2023 08:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoVMsa1+FZ6LQPV+N/uBS22jqn6pbIOLFPJhKSo6nqlCtSqp9s8Je7lysQov4HLaM/QsdRKiYcuTg4lXnwEHKLmyE9YOx3YwywWViIxBloAIrOLEeggclNsMT+SCMeacv+k3iE6quwNC34W2XpSlbkNiuJ7zEDF+blmXneJUE2MkmJ/At+Ofhhqj7aSFverRWFvSmCU6w2lzCGNT7tlVh5JdRMmmHR9gOWED0FYNaJ56CZeHxSUrNRq/pvbvRvItDnz7E7NjDvvvV9Ol1Y148VuveO4pzQEHmTZPe0duoRUxFZ7WdHi0DQGDgQmYQAIfCrTUic8k1s5tXpIS6DJq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T81yl9phhVbqgqL75taRwcV+4pupWKfeAc44C39vhtc=;
 b=ZGR62hSD6N3RWnzI/P6HEwz5dJus7HB/SSEgD62dinyhdvWeQl3Tfdp2EQDZrIds8y5nl3VFdkDAW6fDZHppZzJdim2pVDOXzYjUqKj11JeUqWptlDK5e5gnSbdGm7wHhtPc6Jj5Nl0knZkKroLLfM0mwDA8agiVqflwqxyiXV4TvLKRJtMaURWoF2Ozf8y1qKim7NMIJb6vY5Quy4PfhBkO1S/xPtKIl15W5ygrQXvI8ZxfW8QYchIo1EmWrwKxWbwz+6fA5zdzgbIpopQ6BIoWLI2gQ3ef3Wk7pEK/fNVpSWDEDkeIiXIF1MHi/gHWfdb25G5Jo2o3/Ae8d7/Uyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T81yl9phhVbqgqL75taRwcV+4pupWKfeAc44C39vhtc=;
 b=NFfWOv6aYoKMZV3NeMretpb2jRqEBP9M/gk01ePv4hEE0YXSRuDjRFtgAorQqeGnItciEaWnrdQXdESDd/I7cXxd0bp6zkEDTH+HwlIrlLrlHTWoNw7T4eYKFv7PJz2ZJUjnK1FXrcPYFv2eoPEi5BJUYZf0pVmfXrETkFastPE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSYPR01MB5350.jpnprd01.prod.outlook.com (2603:1096:604:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:03:37 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.029; Tue, 15 Aug 2023
 15:03:33 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] iio: pressure: bmp280: Use i2c_get_match_data()
Thread-Topic: [PATCH] iio: pressure: bmp280: Use i2c_get_match_data()
Thread-Index: AQHZzUaRY9Oe+Z+u20OndxyqhWBKnK/rdW8AgAAC86A=
Date:   Tue, 15 Aug 2023 15:03:33 +0000
Message-ID: <OS0PR01MB59226970934CE17341201DF38614A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812175808.236405-1-biju.das.jz@bp.renesas.com>
 <ZNuQ+idDAna6XbvH@smile.fi.intel.com>
In-Reply-To: <ZNuQ+idDAna6XbvH@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSYPR01MB5350:EE_
x-ms-office365-filtering-correlation-id: 4ad15d36-cdfe-4735-a35a-08db9da0cb85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yrLJUhtOnMp0I8UwqzFjbVbnuMrfcgA0WSNhvJtO01GnRgswsnGKwNl3xFkD72uSovXeVNQyxX8W2DbJyJ2GhTIk5ty9cnfUnL2kqCQMENMUGoHZva9Tk7M4TvDH2CA6HDTI8DLwkROfVEpjIwJ37JJJYEHpeHwR2RL+RXRCyk7Iv2Tlm5tF4PoTJWviOCl+c/7t8ucKfuX+lPcRijkeSsBzwRTZQrfGa04KRHks45dso7VUdfCxdCR20bd4kGk4SpgtgNxQWI7bImuUxw8Xb0xSAofR1ULQYa9ng6MrO4FPXXi1GM99h6jm5ZW6H5XinS8WAQLZABCLSU2nOBFER7ac+g84vX2AYYgQuKbdyY3H57HDWXEjP530en/gohBlMtyrrfsIfOWpsEvcoVVcurQBzNOuws1ceuNXKkpqW5QNMQsRW02OEmxEwt/ar3Hd8uc95nhbNvEixvPdXoFLuQl3UP6OwK2wu/7kW0EHPPD/+Nou4cSaqi4TezAu92nhOhDUPmvKWp8s/RvKZQ6CmcUgILX8SxhLRFdZexDnW+CtOPZmwNdAnVwNpGJr9nD8FpSh/nxTZyX53hx2dALXs7+3+8UCqqTxcNPlmz/bZ48BBNd+WKFtTw5+WBnFbbB7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(54906003)(71200400001)(8676002)(8936002)(478600001)(38070700005)(6506007)(2906002)(66556008)(66446008)(64756008)(66476007)(55016003)(76116006)(4326008)(66946007)(7696005)(122000001)(6916009)(316002)(86362001)(4744005)(38100700002)(52536014)(41300700001)(5660300002)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0E1G32spzvPJTzVvaRDVTbBnt9hEeuMVJ3vjkrRnZ7fEe9s59QUcDjcN6W?=
 =?iso-8859-1?Q?ud+s3VbCXNxHkluwSLZw6KpJSn9rfSWUIwhjGMfF8y3Lk+JO3DZTKIKmSh?=
 =?iso-8859-1?Q?Zzw1srisYjLsWdnYFtralOua7Uc5z9h5S7MMN+7GqyYOuVZBwgncYRyto4?=
 =?iso-8859-1?Q?H+DmYEKavGsqRF1bF5S9IfsJt6mVqkNPXKNojsuUirSQEttcEuTk0skSI6?=
 =?iso-8859-1?Q?Jb/kBizEp3xsDwU5zHGyHYiiqrMwIrc2eGade7XGIAa5pafu01XO9li5tF?=
 =?iso-8859-1?Q?40Zb6Zt074cPswLg+weMXCrnzZJ4nIigOOWPk6noJS362e4h5Q540KrhU+?=
 =?iso-8859-1?Q?y5F0yNoerd72v5YptgrP6p+f3ahR8dRP3nxUM3lAaHmKBilX2hs+Xa5e3z?=
 =?iso-8859-1?Q?KhOqNSR4jYVKhVo/9ZNFBX7t1nDqGxnO7dpFHvoCoZdJ2lnzzXcUMmkvh2?=
 =?iso-8859-1?Q?gpX1i+2Ub7COJ2z6f6I+rZtG2Bp4FQRqcIOFGoM3nVcI6vDJYy9kPbdq6q?=
 =?iso-8859-1?Q?NeDK94/4Dlpc7iKyWSNOA5G9V0ZC79XUGxwqgQtyoqyHfKsldlmAsbwbX7?=
 =?iso-8859-1?Q?e7iG3mFbEYXcfQNjF8g4/8iBLuVAiCtFzQ6Qxsor7m+P7YWdysSSHmTBc7?=
 =?iso-8859-1?Q?fIcw23xFnQs4F+kwntf1VTtGWLhfoWWaSf3icZQrXm7oQrVtXubQ+yLurU?=
 =?iso-8859-1?Q?X6PU26DJtDK+sZ8ekJDRAuys7TGJp2Jok6oiC+XmNBFyOaO4ouVEmMKyh/?=
 =?iso-8859-1?Q?d2stcKdUhjZiMlCiD4V7GNAaMCR9i9mD4Q7Fw133MwEQj9O1fmDTZCRKnQ?=
 =?iso-8859-1?Q?Hwo3bn88DPQZZaZZ+x4Fe8Bn7xm4IbzTmCLfFD7OMtex2LwSveugN4Us7X?=
 =?iso-8859-1?Q?4nfbCQRBsOk9Dfs1tO5Hg2CcQ97Q5ycY+uYrEWq9jCtsKCrBCnEU8ZjKyM?=
 =?iso-8859-1?Q?DcKyj4D0r8QXFi/oaGNMZdPBleoyluc0h3YKw54Zgmu+dmEw2Vp1+iWyXA?=
 =?iso-8859-1?Q?H6/yQZNo0pKhW7rkOhkGQnxRxcvj8LMxR7o/zTkCoFiVSDycgb8Qjp2clw?=
 =?iso-8859-1?Q?5CM1ZADXdaSGN5i8jmeImGmMgFAcpuoXZtzZ0eY9vKsmGNU7pNzKSqLrFD?=
 =?iso-8859-1?Q?yxY6b/By27GH0zMSXvTl58LUn4pcpRkFtwp4EEEVBcsgozQ8QCWnW9SuLO?=
 =?iso-8859-1?Q?r3RvMLrMez4DGma7s49e9zzi6UXJLJksajWjh0Mj/c4F8izLqq0IUtLesf?=
 =?iso-8859-1?Q?4NNpV4/cLbbTVTS6EGQqA5Jd/1FkFm51V0ASykAjmn8HTQo3mGlRn8yM7z?=
 =?iso-8859-1?Q?Nj4Ik3x2+hHktWea1PxuJ2KSb8OrhASXPvXi6+us82hl1sTyidmSAvF5U4?=
 =?iso-8859-1?Q?6PdBBioiTQ+gXLsI+cfJt28c7DJ0L7OecTjeB/1AATrEmxaFXS0UFj/KlO?=
 =?iso-8859-1?Q?xWS7eD6M8M0sJvzO0gah8FeWiI6anJcpE+sdUiBWO+a7seiFb3OIU89p/J?=
 =?iso-8859-1?Q?TufvySMa5OAMgN8iHI11fDivwEOnCywzWXwu7kjTL7Rqa2jcxcWbNKTWqg?=
 =?iso-8859-1?Q?6r+OukcGqse0/dmAFZ/1XeumlCdXvanPRNGo/PhQBMDsNe8LQt6LYPB1RH?=
 =?iso-8859-1?Q?ySpMdgg86QF54=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad15d36-cdfe-4735-a35a-08db9da0cb85
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 15:03:33.7089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZD8P7lslVgBh8558fCUUK7wkNlaVj0MH8VD6krN4dSrV1qHxiYNtHpYftohQgIIv71Tm1hk8nV2/XmMZyV4qzaNdPUtoxHmK1DUrIVrXDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5350
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

> Subject: Re: [PATCH] iio: pressure: bmp280: Use i2c_get_match_data()
>=20
> On Sat, Aug 12, 2023 at 06:58:08PM +0100, Biju Das wrote:
> > Replace device_get_match_data() and id lookup for retrieving match
> > data by i2c_get_match_data().
>=20
> ...
>=20
> >  	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
> >
> > -	chip_info =3D device_get_match_data(&client->dev);
> > -	if (!chip_info)
> > -		chip_info =3D (const struct bmp280_chip_info *) id->driver_data;
> > +	chip_info =3D i2c_get_match_data(client);
>=20
> Is id still in use?

Yes down,

return bmp280_common_probe( ..,id->name,..);

Cheers,
Biju
