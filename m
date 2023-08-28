Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640EE78B0D4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 14:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjH1MoS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjH1Mn5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 08:43:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878C100;
        Mon, 28 Aug 2023 05:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgR6P069CKi7ETJCa1ppOXECOu+i5FLPHgLcXe8DqsIf/vFCQGoUzXbA8/huMoBsDBHB3kqiwbCE9k+LfFcJY1ykP1s/vFCkrxCDCuTUvKzY0D+hymsFAXJoM/hWKG1qN1jh/LThcDpyR/YuNsNliJfsFSrbaKv5JjpPJFus8b6gBuLO6eDVTDJU61titzHqj/U4UwxyTRMcj2fZMIESImJG7YXgnp1CvAB8AALUC+2ljBXyHV9dWmaNPixjiQhcAyy6WgmkgrkezczP9M9xiMvJzHlcoisXv8v847S1YfB31PF8QOE1OupRFqYdySM/mOD0NljK5l75wGUNZA8VEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMeUNvIBbjS3vAlAqWuHAQWP5TUfuR99t0MpXZb34w4=;
 b=Q+cFQmj83NEprR4QlKXFy7eJpt9gQz+ubNCUJnFckle4pKdMuzoAraquUhxbQbKzR5QNPqBk6izGQwGgA9zPQMFWmw2Wqh6boufmBmfqDfLNb1d4K3v4V5coxJwQosqoAIFvTTLE4NlNR3TUAe3HDrO7WdMtnBHAMstSS/96aa1Lr9QOoIsVjUuSez/sybhAROo7H71rnxc3jVgG0dXK7wv6dJ+y6HjzSWgajBr7EWUl4MIc63lH78v8PIcEH33vAmb7dcIULa4vSYZJoiIDE/Ay+K8epXzztLWQPD1WGsJYauY9cF6Bw4ww46kZ0QPAqT9XPnvyHVSs4mGCHyJG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMeUNvIBbjS3vAlAqWuHAQWP5TUfuR99t0MpXZb34w4=;
 b=LULIQZmFcms1uU6QXyr3+bHC6Isojmrg8aSKZPfcATMyn+t+kNhwP3GE7/RdpMnvWJohLw+bt8RbDxOlml4G14B2Sv7E0UBaIaKxbBd78ln1z23Ll79A7g2+Eu/SNse1a7KYd69pFj+IMr0HC1srZu64cfEQWpJlg4dUpXKO3nw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB7776.jpnprd01.prod.outlook.com (2603:1096:400:181::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:43:51 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:43:51 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: RE: [PATCH v2] iio: chemical: vz89x: Convert enum->pointer for data
 in the match tables
Thread-Topic: [PATCH v2] iio: chemical: vz89x: Convert enum->pointer for data
 in the match tables
Thread-Index: AQHZ0gbUmy/zC4DAjkC8+0qQGcYEt6//tC6AgAAASjA=
Date:   Mon, 28 Aug 2023 12:43:51 +0000
Message-ID: <OS0PR01MB59225F5472B4BE500429394C86E0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230818190429.338065-1-biju.das.jz@bp.renesas.com>
 <20230828133525.5afaea4f@jic23-huawei>
In-Reply-To: <20230828133525.5afaea4f@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB7776:EE_
x-ms-office365-filtering-correlation-id: b9e25fc8-c20b-47a2-ef6a-08dba7c46e76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8fpzKDrY34gnn/gusDmAKF45mo7myywHLjZQXiHhXUNWUnORWcqSkK5aqqvRTw/88/0141aJ81FAVTc5JyyPpdWzW6cd5MlR5Ag2LCwQlXHAhmo+k/43Xs2GNzwEsw/B4vP1PjUxtvjxH0oQZ2Pfr0xqiE+wqh3ovXNmb+g1KhbS7/Xn+TVj39g03+6RCfxbnARXWrUYgx2YyPk2sNp6+FvE2QfIN3MWtrMbKidWM5w2lwNi8ZKMOeOnELATGfRwp/nyN3iAchtfWwbpmLkgfhmfULz/YW1QbI2at7XHSQ08JtQ+bocG6ZvZcXXs2dq01WzkxzcWUjp4ezZCsxowKWVYoFhX2LNbNk8+gf4IAQTi4f/Y7osRg85AYBhOdRSrfgznULLA3T2EkXSEs5ZoyNf7ILMlAROgdPRUnugQXnCrpmNHFktU3x5XLC5ne8pu1xceOkZh9UXmav0eR5YLd86/8zQ86N7wxmoJCWhaYR7nHiFl+QwV5+QkNsmwTFKL313AZtXHjiRex1CTk+1Dfs18k1NrenXDZ8vtH2P+xQCEuvSoVPf2m6qMKiUzWz3u054b67Dg24NwKGKBS5OcALiCLaSWHQ7kIHUUtkLuH30vKalFxkjij671cVaO55q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(122000001)(38100700002)(86362001)(83380400001)(478600001)(38070700005)(71200400001)(26005)(9686003)(7696005)(6506007)(55016003)(76116006)(66946007)(66476007)(54906003)(6916009)(2906002)(64756008)(33656002)(66446008)(66556008)(316002)(5660300002)(8676002)(8936002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u0cQ7yA3bcH/TA0kmy1iar1SCPcFH55duVn4F2dY/vt/wtBtSqzqEaeFPO?=
 =?iso-8859-1?Q?yYQAscj91IMzSPdJk5L+2QeVbSP0VxNw+u5EG5DjDON9LskUb79y0w8zEK?=
 =?iso-8859-1?Q?2gptMapaaYDnPQALf/34CkLMhs3/SPvu4uimvSOTn7q4Z4ygD7tvPVgzMJ?=
 =?iso-8859-1?Q?FsisECInIHfy61INvz70SLSexUM40ummh8o51H0AXHiOH+bdKwiyaWw+Mj?=
 =?iso-8859-1?Q?arf6Tt3VHfHtVGWdgLl8avFXg+IOsfgj1dG8X3FgJeED0+CQNxyMVBC5TS?=
 =?iso-8859-1?Q?UqaJ53LEp7xFjmV7v2rSwqct6AfUuJX7IJWHMegCRFpEBVqfZRuPN7J2LV?=
 =?iso-8859-1?Q?VJVlQEjXAVU1MVDfy+x4y+IdlhgdKnZq4xT/uT4DBHD/+T6alvmwws0Hk/?=
 =?iso-8859-1?Q?CAYKPSN7c5PSfFoHPT0bqlC8Pj0JMc5xX02NlNXi+bhn8tJVJ3mqq9jKTM?=
 =?iso-8859-1?Q?Z7TPcBIEgNSqNblJI7msrCBJuBDuDR9KETrfppnxBikGBv537T8kQtHF9N?=
 =?iso-8859-1?Q?6LBp5ZxAJdkNwgSv2pRbzgD9yr3Ww/IOKMeB1rYnkQI+PgBZ6oEdGGW5tl?=
 =?iso-8859-1?Q?OugDWWgUqFHfMhfqS9edO9Al8f+PW3GbaXz33Qzgyy33GoDrb5KCf2a7OH?=
 =?iso-8859-1?Q?2FZ+8J1vLKOqEWxkuo6yY45n+0MqULVFIfr1Te9v98dwx3Vatqt2zc1wNm?=
 =?iso-8859-1?Q?dlT8l3I2DP3l1kMTV/UEwVNEsDmGo+qdVtXxysmLyIz7TJbHCmBgPqiNkF?=
 =?iso-8859-1?Q?6a1DFEhXBUN1QeW1bsLUNVexHn2eAj5r3SkWpAjBecn6nicOIWPFNg9llt?=
 =?iso-8859-1?Q?x463y6HXLGeckzw0XkldOPKvT3xF7f8FSUnY9z4TuZlIYwLdFyJdqxOPdi?=
 =?iso-8859-1?Q?HSrfxzgIHyQXKRh36hFQHhJYz37wTcQSb9QFU7H7MHA1ofNTicCZZGm+K0?=
 =?iso-8859-1?Q?kAxsnvPU5MLZIX7NMmXIYWj2+tm3T0pyqKfuDediIY+CGUfHvCRFNMU3JN?=
 =?iso-8859-1?Q?oP/nLos1qUa+gVAvl4bGX6wTm1ZFRifA2Klx/SWb/INVJwV2O0pYcB1oX0?=
 =?iso-8859-1?Q?Dby09GsD5HgUeQt6QzyE6absPXTxTMFEswKd1CioL+3YnVX0kIAcljoMWH?=
 =?iso-8859-1?Q?SOJGdaqT68fWqlRJ6GKbQ/kwdb+hm0umSg3EbMstcZYQkN6eWvn4HY3s7X?=
 =?iso-8859-1?Q?9IvOmrfLUNO2pTxsPGjh9L1Ttv5NfncHuWM/xEfg6CL45OO9lpq1fY3kAM?=
 =?iso-8859-1?Q?DAl+CISjjbkjDG3dXEvcx8uRg0mNyYLN4EM2rCemYp+s7paOYm0cySZuek?=
 =?iso-8859-1?Q?WlXQtYpiReDVmbXURK3jbtNR7GU0xtaWfJAk72izzwFdizOj82Z5U9Eyjw?=
 =?iso-8859-1?Q?l3Fn0060pVZowOsmQd3WC9S/hnPUPpxLm5UhGkYcAad8d7h5qQQqzCAwsa?=
 =?iso-8859-1?Q?CtuwxERy0vNhlp7FIOeyZDrdBXSo3v8m8lsm9O4OFck2eqTAiWfiQ17J/s?=
 =?iso-8859-1?Q?dE1hXD1pj6u32SdwV0J7jHaUE2RBTkhHPvtQEUiFY5ntOQAXuutXQJe/LN?=
 =?iso-8859-1?Q?yh3TxbqLsOD/h/blXksIWvY6Tz77eHdtbvlZ/YHUDVV3f+MQBoMXmtF2bB?=
 =?iso-8859-1?Q?Qe4INNPcm28vHmOd5pL6G7EO+cDBN249YjlUHTjP8jJjyB60GATMNHww?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e25fc8-c20b-47a2-ef6a-08dba7c46e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 12:43:51.1233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tP+ESJgTLE+9oAOREkQZM842KuWA6BfSA1QlexR0VBMUqBctoFCwBCwTAk+cl/6a/gGBGZZcaMRhB4/csvuTJbNUCWbQ7NIFQjpVSOoIws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7776
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan Cameron,

> Subject: Re: [PATCH v2] iio: chemical: vz89x: Convert enum->pointer for
> data in the match tables
>=20
> On Fri, 18 Aug 2023 20:04:29 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Convert enum->pointer for data in the match tables, so that
> > device_get_match_data() can do match against OF/ACPI/I2C tables, once
> > i2c bus type match support added to it.
> >
> > Replace enum->struct *vz89x_chip_data for data in the match table.
> > Simplify the probe() by replacing device_get_match_data() and ID
> > lookup for retrieving data by i2c_get_match_data().
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Biju,
>=20
> Make sure you cc the driver authors etc.

Normally, I ran a script against the patch to get details and additionally =
I add Geert, renesas-soc , Andy in Cc list.
So far the patch worked correctly. Not sure I need to enhance the script to=
 get driver authors name (for eg: Matt in this case)??

#!/bin/bash
PROGRAM_DIRECTORY=3D"$(cd "$(dirname "$0")"; pwd; )"

source "${PROGRAM_DIRECTORY}/get_recipients_lib.sh"

MUST_HAVE+=3D("Geert Uytterhoeven <geert+renesas@glider.be>")
#MUST_HAVE+=3D("Chris Paterson <chris.paterson2@renesas.com>")
#MUST_HAVE+=3D("Fabrizio Castro <fabrizio.castro.jz@renesas.com>")
MUST_HAVE+=3D("Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>")
MUST_HAVE+=3D("linux-renesas-soc@vger.kernel.org")

MUST_DROP+=3D("linux-kernel@vger.kernel.org")

populate_to_list
populate_cc_list

the script uses below commands to add relevant to and cc field.
./scripts/get_maintainer.pl ${PATCH_FILES} | grep maintainer

Cheers,
Biju

>=20
> I'll queue this one up, but Matt feel free to comment if you have time
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> > ---
> > v1->v2:
> >  * Added Rb tag from Andy.
> >  * Dropped id variable removal from commit description.
> > ---
> >  drivers/iio/chemical/vz89x.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/vz89x.c
> > b/drivers/iio/chemical/vz89x.c index 13555f4f401a..5b358bcd311b 100644
> > --- a/drivers/iio/chemical/vz89x.c
> > +++ b/drivers/iio/chemical/vz89x.c
> > @@ -342,19 +342,17 @@ static const struct vz89x_chip_data
> > vz89x_chips[] =3D {  };
> >
> >  static const struct of_device_id vz89x_dt_ids[] =3D {
> > -	{ .compatible =3D "sgx,vz89x", .data =3D (void *) VZ89X },
> > -	{ .compatible =3D "sgx,vz89te", .data =3D (void *) VZ89TE },
> > +	{ .compatible =3D "sgx,vz89x", .data =3D &vz89x_chips[VZ89X] },
> > +	{ .compatible =3D "sgx,vz89te", .data =3D &vz89x_chips[VZ89TE] },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
> >
> >  static int vz89x_probe(struct i2c_client *client)  {
> > -	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
> >  	struct device *dev =3D &client->dev;
> >  	struct iio_dev *indio_dev;
> >  	struct vz89x_data *data;
> > -	int chip_id;
> >
> >  	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> >  	if (!indio_dev)
> > @@ -369,14 +367,10 @@ static int vz89x_probe(struct i2c_client *client)
> >  	else
> >  		return -EOPNOTSUPP;
> >
> > -	if (!dev_fwnode(dev))
> > -		chip_id =3D id->driver_data;
> > -	else
> > -		chip_id =3D (unsigned long)device_get_match_data(dev);
> > +	data->chip =3D i2c_get_match_data(client);
> >
> >  	i2c_set_clientdata(client, indio_dev);
> >  	data->client =3D client;
> > -	data->chip =3D &vz89x_chips[chip_id];
> >  	data->last_update =3D jiffies - HZ;
> >  	mutex_init(&data->lock);
> >
> > @@ -391,8 +385,8 @@ static int vz89x_probe(struct i2c_client *client)
> > }
> >
> >  static const struct i2c_device_id vz89x_id[] =3D {
> > -	{ "vz89x", VZ89X },
> > -	{ "vz89te", VZ89TE },
> > +	{ "vz89x", (kernel_ulong_t)&vz89x_chips[VZ89X] },
> > +	{ "vz89te", (kernel_ulong_t)&vz89x_chips[VZ89TE] },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, vz89x_id);

