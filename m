Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BEA39B579
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 11:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhFDJHE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 05:07:04 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:7484 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229955AbhFDJHD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2021 05:07:03 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15494jhg002489;
        Fri, 4 Jun 2021 09:04:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-0064b401.pphosted.com with ESMTP id 38y8c3gbg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Jun 2021 09:04:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNDvXG36eIOLLlWwsOIXL9N61bEqrjasZ6RQ0LOLQg+tqZVJp+Pc/6pM0dJKk/55CQRj7Uo5oSk77Gm3My8zsVDDRegj8NUlP8fo+Pod0u7wW9ZMT8D+B3VfyN0RHOPdx64SKFbSe4A6xffrxqb/xJKJepcyqlTrzcyh4kINMsuiHtXmy/Rqu7XMo2dtErffH1tYoV2fbBWqG4lke5OJNIrbhdcNTGK5peHJpMFXVik7Y/DN6Ee0DdxyLC5dHAqd8BFtj8cj+it/uEoogVfTvGdSEzuuUy4chq84gQsof/mYODCDE0suu7EI0jt8nKEzoALCkAIFM+2stqoSi4zMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqM2N4yBOEOdy7o4oNFZBhpawQROpbfQzeCB+n91NTc=;
 b=OieVtTf/8pg3CrMFHcnwRp0wA78X8go/tV2ccutUI/+g2wPTI6uEK9yQ7af0h7Q9NWRrfVB4WeRfv/dTrstZhiw/xDbuAy8yEHgWKP7KrNabfiJPdImHWvrKNaPLmRxA6aqjjgK4gms91cwL8CNHJzf74B3ZBHeC+prK9lsxaksgXrMoDZ8J/bMwZ+O6Q6evNP2VyutU54WUsB7GjXMtt/NPB53/VhV2Gff/o/A81Fy8e5eGgs+BNdLQ0gH6z8wyGFxf1Db87iEsEq69Id8ohDsVIP5PoHJoJffWznrBWha0afiDn1hQPl/6aFgSWDTuvKsu4Zk46fzkJSyT4ouwMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqM2N4yBOEOdy7o4oNFZBhpawQROpbfQzeCB+n91NTc=;
 b=lb90oh9QxldvcQi1bBSqJdMdSq3Xays2v+W8VFQjDImFdEY52NL2SzIGexm6z4ZE0QtUNsF865gpLij3OfTrWv0ZYtD1vLewaFcQOnJp8M7Hl+mB4WtJgVEJSAVlq0p5WVzkE4Px2eE716RoEdR0iVervljTVczwHyz99ZJ0ixg=
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB4936.namprd11.prod.outlook.com (2603:10b6:510:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 09:04:48 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49%9]) with mapi id 15.20.4173.030; Fri, 4 Jun 2021
 09:04:48 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Topic: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Index: AQHXVsiLZJqFig5jYEW95MUVkHO9fqsCeyaAgACcmKCAAEwegIAACGBAgAAbOICAAAkbAIAAAzWw
Date:   Fri, 4 Jun 2021 09:04:48 +0000
Message-ID: <PH0PR11MB51916BF5C390C90F66385E8BF13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20210601092805.18385-1-Meng.Li@windriver.com>
 <20210603172025.314b5ced@jic23-huawei>
 <PH0PR11MB5191C26AA8B6D2B855E19D67F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20210604061319.pbj5ptnhxfsz4cec@pengutronix.de>
 <PH0PR11MB519190E44082ED1B0B0D4C90F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20210604092043.0b13f24a@jic23-huawei>
 <20210604085318.dpgazzldn3g3xpq6@pengutronix.de>
In-Reply-To: <20210604085318.dpgazzldn3g3xpq6@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cd36ffd-ad1b-4d9b-808c-08d92737ce2b
x-ms-traffictypediagnostic: PH0PR11MB4936:
x-microsoft-antispam-prvs: <PH0PR11MB493628277C9C6648218E2AABF13B9@PH0PR11MB4936.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o+B9jtJZ7+VW337aTI0vhfQHeyGb9oYI1o2i/JPJjYd3Rn35PipWkJyely6t25ojJ0veidIbArLnSVVUsPCSxuGyE0eq+4FhdXMM+3HibBMeqETlXAfdoxeytV3SrFJ4HMy692wqGTCJT4KOj0lQ+OSeWJ/Vsy4XTgZ6HIK9GJ5xXeAkpv2sA2LJdB8WzgAkZOBuy0762rRL7ZXaRB0TLO/XoGLu4BbbOPCoQVpwvQ2FvL+HToAn5zgdYKVzWAkE10GEw8ogk7+AwNla5Gp7MZhIb/x88uom+MWxcnaZKpuZq/NE1P5EXkhtBnEraXGmIUU5y2hfrq9p5qvF+x70IACxI2wdncPYqIBJnM7TGCgBFJ1hvfdfW8WHNi4ImhR8ycJKDHX91ftiytlIWlOK1XFNBW1pwFmyaxb3bwCSkbpuiZBxjlOo2EyHUy2SNgcVJTeD7UBQYIWsKUNxYDSrM+vN6mxN9ugPCxjjU1hDGbqOl4vOJJMe4Eyrz3npYcmnaoTd/hXPpB+a7cCW9LNfQe7Fe0QkrBtU8w9GjAW/hAi21piRlr5s+dglWwwm4jOryDebKA/B3GDk5pU+qYPoXCfdhRhkbOoxhwLEBdfFDdXN8qMwGyMffSoVjSoRdGD2Mm0H44Wep1CV//HQamiv5Rp1HiMgunjzqmjAq/M1/Yq5tWXrSF+28zckhs+1A/3PcVrH6C101U1XgPAIBnUCtuUnvqrqWU2ZCztYcRySI/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(136003)(396003)(376002)(186003)(26005)(53546011)(6506007)(7696005)(54906003)(110136005)(316002)(4326008)(966005)(478600001)(9686003)(55016002)(8676002)(8936002)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(71200400001)(2906002)(5660300002)(38100700002)(122000001)(52536014)(33656002)(86362001)(83380400001)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?gQpl4o5qq/4kS+7LBfG73tkoYMyzsKMfcWog1/E1xlHw3XUhRj4uxFqgbf?=
 =?iso-8859-1?Q?Wa2XCREU0WZaPZsQLHuVcNxNCB9QLn3bPsmcSB+pQ3U2cj8hbvoZUNDO2s?=
 =?iso-8859-1?Q?F14C3NDkSzHB4zrLk4JFia0JgvvOYRIHSM7lFLjHmfFaGgMxDzNwYOap4t?=
 =?iso-8859-1?Q?RYTcvnlRvU86WhQd233k2iIwaU5soOhjSGQchELpRWI+OKQnACyF5/OAfo?=
 =?iso-8859-1?Q?HpVVUmCD+OKgcI2UFD94CGowacXplguFHNKFqLMDu2rQ7iQ/AE+brofDny?=
 =?iso-8859-1?Q?UAgI9LxlNg9hB4KXxCWXM6Z9+VDkpMvHkOaLMMLx8Nh91eNOOpeaR5M0Fb?=
 =?iso-8859-1?Q?QWyd5D3IkBoQ7anlGa5b7nCP/D90XSaCJLSmcrt+xy1kXPuMfNLJr8j0I4?=
 =?iso-8859-1?Q?kEhAC0QzcsZLiCNzeXLhl+hbS+umBgpYZ7h5KgHuqLRoTvZ8sfCtAqmGh4?=
 =?iso-8859-1?Q?AoPiKzyCAR745i3IrQyG70KpHmqNglnd82Q8eBYhoOmVAHlncoIwqtLvuo?=
 =?iso-8859-1?Q?2xc97tAfCdiO3aKxAu+9DA9R/sCRde4J0QsEaNkprdXCXgJLgEwfCtMurT?=
 =?iso-8859-1?Q?35mkCPOkENnF4hz7eG+AnSxfRltgV1CpSSUwZC3Vh+INzXMcLEqMlu/ECC?=
 =?iso-8859-1?Q?F8reA6yxYf3KzPJYJXk+Qj8iW1wcjAkugW43t9bXYnEfoSWxaza9F4pCTt?=
 =?iso-8859-1?Q?0JbwFXZr9i52RCCKlmeOxdQul2N1/2c3xDqBvJ4R4gq3sHwbLAWJGcN/Vm?=
 =?iso-8859-1?Q?G6muWF9sOgUulbxTSpsq+3Xt5s8U6fRoGX8oIEouPGNJUIFwsgNjn8Ccyk?=
 =?iso-8859-1?Q?5sixj8fntu7KIbcOzr+O342TRvvbWwzblAxl694ucOYpq3G4d/AR9gBGTK?=
 =?iso-8859-1?Q?fejZKBmuDJ3mVKDJHRDRXhilXeAV+9aCZuIg/Xtc8ZeIHbN+U9GFBuiAZN?=
 =?iso-8859-1?Q?vQEmQaDpF5nTmrOaIUvzvBD2LwS3H2WFBVO241E9tyX1CAnr/h49IhAf5Z?=
 =?iso-8859-1?Q?j5WZFNvqAygbJsL/4hpWJTX9BEUJ8fImZQ075RqWR3g1Z/Qx6Q2EbPNJCb?=
 =?iso-8859-1?Q?POLys+yStHlnSIY5F/C1lvPQHDHehSbABg95oDB/fmrNZf7LEkm7hEv/4m?=
 =?iso-8859-1?Q?I1kvwYr6S64OYZkY9fHN8eAYl9W7voDhv+hs3v2/4ARmCHrZqOs3LqWJ7S?=
 =?iso-8859-1?Q?thdjBlnu4AIfQB2rZTUKgrXMVFWOuYqHNmlZ9413zkDydx7lfZaVAwg2ro?=
 =?iso-8859-1?Q?mMlp5gv73aMK3k7JfwnwyNc91Smhg0zQmhw2yXhK4N5LRCEJgttY3pQefX?=
 =?iso-8859-1?Q?AVBKChjURO+HxV8W7XSlozj0zMCjJgOIOOhG6qUpghB0su5DPGYXSbqdS5?=
 =?iso-8859-1?Q?lQmXj81H/E?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd36ffd-ad1b-4d9b-808c-08d92737ce2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 09:04:48.3177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4/87MnL6yfqZ2Vygg6uy6TnHAGQDt5Sann/JoATMPnip1+u8+jQEqiGUdH/M/ZRGlu+byjUuV8zjhH2RQRoqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4936
X-Proofpoint-GUID: 3pgJjhnh7Hw0mlSfeU8A4siTI4GstIoz
X-Proofpoint-ORIG-GUID: 3pgJjhnh7Hw0mlSfeU8A4siTI4GstIoz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_05:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040071
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Friday, June 4, 2021 4:53 PM
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Li, Meng <Meng.Li@windriver.com>; lars@metafoo.de;
> Michael.Hennerich@analog.com; pmeerw@pmeerw.net; linux-
> kernel@vger.kernel.org; linux-iio@vger.kernel.org
> Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading =
the adc
> conversion value
>=20
> On Fri, Jun 04, 2021 at 09:20:43AM +0100, Jonathan Cameron wrote:
> > On Fri, 4 Jun 2021 06:43:20 +0000
> > "Li, Meng" <Meng.Li@windriver.com> wrote:
> >
> > > > -----Original Message-----
> > > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > Sent: Friday, June 4, 2021 2:13 PM
> > > > To: Li, Meng <Meng.Li@windriver.com>
> > > > Cc: Jonathan Cameron <jic23@kernel.org>; lars@metafoo.de;
> > > > Michael.Hennerich@analog.com; pmeerw@pmeerw.net; linux-
> > > > kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > > > Subject: Re: [PATCH] driver: adc: ltc2497: return directly after
> > > > reading the adc conversion value
> > > >
> > > > Hello,
> > > >
> > > > On Fri, Jun 04, 2021 at 02:16:39AM +0000, Li, Meng wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > > Sent: Friday, June 4, 2021 12:20 AM
> > > > > > To: Li, Meng <Meng.Li@windriver.com>
> > > > > > Cc: lars@metafoo.de; Michael.Hennerich@analog.com;
> > > > > > pmeerw@pmeerw.net; u.kleine-koenig@pengutronix.de; linux-
> > > > > > kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > > > > > Subject: Re: [PATCH] driver: adc: ltc2497: return directly
> > > > > > after reading the adc conversion value
> > > > > >
> > > > > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > > > >
> > > > > > On Tue,  1 Jun 2021 17:28:05 +0800 Meng.Li@windriver.com
> > > > > > wrote:
> > > > > >
> > > > > > > From: Meng Li <Meng.Li@windriver.com>
> > > > > > >
> > > > > > > When read adc conversion value with below command:
> > > > > > > cat /sys/.../iio:device0/in_voltage0-voltage1_raw
> > > > > > > There is an error reported as below:
> > > > > > > ltc2497 0-0014: i2c transfer failed: -EREMOTEIO This i2c
> > > > > > > transfer issue is introduced by commit 69548b7c2c4f ("iio:
> > > > > > > adc: ltc2497: split protocol independent part in a separate
> module").
> > > > > > > When extract the common code into ltc2497-core.c, it change
> > > > > > > the code logic of function ltc2497core_read(). With wrong
> > > > > > > reading sequence, the action of enable adc channel is sent
> > > > > > > to chip again during adc channel is in conversion status. In
> > > > > > > this way, there is no ack from chip, and then cause i2c trans=
fer
> failed.
> > > > > > > In order to keep the code logic is the same with original
> > > > > > > ideal, it is need to return direct after reading the adc conv=
ersion
> value.
> > > >
> > > > As background about the choice of the .result_and_measure callback:
> > > > A difference between the ltc2497 (i2c) and ltc2496 (spi) is that
> > > > for the latter reading the result of the last conversion and
> > > > starting a new is a single bus operation and the one cannot be done
> without the other.
> > > >
> > > > > > > v2:
> > > > > > > According to ltc2497 datasheet, the max value of conversion
> > > > > > > time is
> > > > > > > 149.9 ms. So, add 20% to the 150msecs so that there is
> > > > > > > enough time for data conversion.
> > > > > >
> > > > > > Version change logs go below the --- as we don't want to
> > > > > > preserve them forever in the git history.
> > > > > >
> > > > > > I may have lost track of the discussion, but I thought the
> > > > > > idea was that perhaps the longer time period would remove the
> > > > > > need for the early
> > > > return?
> > > > > >
> > > > >
> > > > > No!
> > > > > I think the ret is essential.
> > > >
> > > > I'd like to understand why. Currently ltc2497core_read() looks as
> > > > follows (simplified by dropping error handling, and unrolling the
> > > > result_and_measure callback for the i2c case):
> > > >
> > > > 	ltc2497core_wait_conv()
> > > >
> > > > 	// result_and_measure(address, NULL)
> > > > 	i2c_smbus_write_byte(client, LTC2497_ENABLE | address);
> > > >
> > > > 	msleep_interruptible(LTC2497_CONVERSION_TIME_MS)
> > > >
> > > > 	// result_and_measure(address, val);
> > > > 	i2c_master_recv(client, &buf, 3);
> > > > 	i2c_smbus_write_byte(client, LTC2497_ENABLE | address);
> > > >
> > > >
> > > > With the early return you suggest to introduce with your patch you
> > > > save the last i2c_smbus_write_byte call. The data sheet indeed
> > > > claims to start a new conversion at the stop condition.
> > > >
> > > > So either the reading of the conversion result and programming of
> > > > the
> > > > (maybe) new address has to be done in a single i2c transfer, or we
> > > > have to do something like your patch.
> > > >
> > > > What I don't like about your approach is that it changes the
> > > > semantic of the callback to result_*or*_measure which is something
> > > > the spi variant cannot implement. With the current use of the
> > > > function this is fine, however if at some time in the future we
> implement a bulk conversion shortcut this hurts.
> > > >
> > > > So I suggest to do:
> > > >
> > > > ---->8----
> > > > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > Date: Fri, 4 Jun 2021 08:02:44 +0200
> > > > Subject: [PATCH] iio: ltc2497: Fix reading conversion results
> > > >
> > > > After the result of the previous conversion is read the chip
> > > > automatically starts a new conversion and doesn't accept new i2c
> > > > transfers until this conversion is completed which makes the functi=
on
> return failure.
> > > >
> > > > So add an early return iff the programming of the new address isn't
> needed.
> > > > Note this will not fix the problem in general, but all cases that
> > > > are currently used. Once this changes we get the failure back, but
> > > > this can be addressed when the need arises.
> > > >
> > > > Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol
> > > > independent part in a separate module ")
> > > > Reported-by: Meng Li <Meng.Li@windriver.com>
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  drivers/iio/adc/ltc2497.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > > > --- a/drivers/iio/adc/ltc2497.c
> > > > +++ b/drivers/iio/adc/ltc2497.c
> > > > @@ -41,6 +41,19 @@ static int ltc2497_result_and_measure(struct
> > > > ltc2497core_driverdata *ddata,
> > > >  		}
> > > >
> > > >  		*val =3D (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> > > > +
> > > > +		/*
> > > > +		 * The part started a new conversion at the end of the above
> i2c
> > > > +		 * transfer, so if the address didn't change since the last call
> > > > +		 * everything is fine and we can return early.
> > > > +		 * If not (which should only happen when some sort of bulk
> > > > +		 * conversion is implemented) we have to program the new
> > > > +		 * address. Note that this probably fails as the conversion
> that
> > > > +		 * was triggered above is like not complete yet and the two
> > > > +		 * operations have to be done in a single transfer.
> > > > +		 */
> >
> > I'm a little confused by this comment.  It seems to say it will fail
> > if we ever do have a different address?  That doesn't seem very helpful=
...
>=20
> It's not a real problem in the sense that it triggers today. If you want =
to read
> out (say) the channels 1, 5, 6 and 7, you could do:
>=20
> 	start conversion for channel 1
> 	wait for the conversion to complete
> 	read out conversion for channel 1 and start channel 5
> 	wait for the conversion to complete
> 	read out conversion for channel 5 and start channel 6
> 	wait for the conversion to complete
> 	read out conversion for channel 6 and start channel 7
> 	wait for the conversion to complete
> 	read out conversion for channel 7
>=20

 Have you tested above case on real hardware? Or only a inference based on =
data sheet?

Thanks.
Limeng

> With this procedure the step "read out conversion for channel X and start
> channel Y" has to (and can) be done in a single transfer. But the status =
quo is,
> that when these channels are to be read the following
> happens:
>=20
> 	start conversion for channel 1
> 	wait for the conversion to complete
> 	read out conversion for channel 1 and (implicitly) start another
> conversion for channel 1
>=20
> 	wait for the conversion to complete
>=20
> 	start conversion for channel 5
> 	wait for the conversion to complete
> 	read out conversion for channel 5 and (implicitly) start another
> conversion for channel 5
>=20
> 	wait for the conversion to complete
>=20
> 	...
>=20
> and ltc2497_result_and_measure is well suited to handle this.
>=20
> So maybe reword the comment to:
>=20
> 	The part started a new conversion at the end of the above i2c
> 	transfer. With the current implementation of how reading is
> 	implemented in ltc2497core it never happens that this new
> 	conversion should be done for a different channel which would
> 	require writing a new channel address. (Actually writing such a
> 	new address requires more effort, either another delay must be
> 	added or the now two transfers must be combined into a single
> 	one.)
>=20
> 	So check the assumption that the channel really didn't change
> 	and then return early which does the right thing today.
>=20
> ?
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
