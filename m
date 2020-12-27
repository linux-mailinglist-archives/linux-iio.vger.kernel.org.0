Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB172E3314
	for <lists+linux-iio@lfdr.de>; Sun, 27 Dec 2020 23:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgL0WJO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Dec 2020 17:09:14 -0500
Received: from mail-eopbgr770130.outbound.protection.outlook.com ([40.107.77.130]:61655
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbgL0WJO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Dec 2020 17:09:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDPH00qgalHC3n1J2eHUlfAsdqw6Bn7ZC63FW2b4WRSWebaLg+K6KK7I+CAnitAey7OBIIkA5nOWig7I2OOABqkop2SlLZKDtWn4U7qSl/Pw1zZZxPyPYTBEmN6x4SssJyug5/Y75P0iJHAvxGbNVvVJZwToQPpfSgN5TkBBdYFYX2T79vtqqIU2PfhcUhROFXgIuriu0smtuI4BAb47OUTDLIUxN3iXRUKV/FefSjhHp+H+n37nZpiy+rD4IY3f5zWKhaNgfCu+zqTFVcAFiWjdHxF9hdOzB0U2zmyr1QSFBZA8XXo/1VquDUUQd7q+aT+ee7OWD3RtJ6zUoIUCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ/2jT7BMnBGBZFyqCB1upe4gDB54LGZ7Tt0NaPq13k=;
 b=ZcMez1Mpw03LF3F/0IzlkOoA8cZsCNMV7t7BOoL9c+hVFRIUd9NnbwZ9hmUpkPbTBfSN9Z+7+nI4Lm+7g2FK7cNxsv9IQrA5wD75FZ2o1pGrn0EZe/cM7y/3XFqHT4LnW1tJnBn4n+XnqjN7Ag59s27b5meQlJ4uDcBSu9FqgD3zK6PL0UtyiYu5bD7xp6G7sulekz3Z0xNnw37CevzSseoCCjiwY/Jz49E6TK69IiHsF5AQ+e9CK0EM98wPxU8iGs02E7cHukI+ZYFW1GfuqpGEfNn1CEbn1gFHgqLu7tOr2ttqBE6+Rpx64KF6YeTHhe707TqTuG05R3g4a52fyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ/2jT7BMnBGBZFyqCB1upe4gDB54LGZ7Tt0NaPq13k=;
 b=PQlRdW1umN3KcH9FOnGDEkU1RmLeUKePctLTeQOyuscKpm24QtZWI3JLMkzlbWQLiFeFhan2KxRO/OpTJ/DvDv5frWFv6wImm3kY29HSteNdDh9Y5yQ9JNrMJEr5MzHneasptnrtY3lcyjxQdVrQDi07kLKHkUiTeh7Xih7eDOQ=
Received: from SN6PR08MB5565.namprd08.prod.outlook.com (2603:10b6:805:100::20)
 by SN6PR08MB4494.namprd08.prod.outlook.com (2603:10b6:805:35::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Sun, 27 Dec
 2020 22:08:24 +0000
Received: from SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041]) by SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041%7]) with mapi id 15.20.3700.031; Sun, 27 Dec 2020
 22:08:24 +0000
From:   Chris Lesiak <chris.lesiak@licor.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] hwmon: (ntc_thermistor): try reading processed
Thread-Topic: [PATCH v2] hwmon: (ntc_thermistor): try reading processed
Thread-Index: AQHW2ZJfsXXsNRhKIU23+9Zg5xYZMaoFcfppgAL82ACAACuFAYACX8EAgABSOTiAADRegIAAAkrl
Date:   Sun, 27 Dec 2020 22:08:24 +0000
Message-ID: <SN6PR08MB5565A63054BD03141EC56DC29ADA0@SN6PR08MB5565.namprd08.prod.outlook.com>
References: <20201224011607.1059534-1-linus.walleij@linaro.org>
 <SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <CACRpkdZJT386M5y5cyCLYaWDhS+AnpXgB__VEshvYKbxN_=wPg@mail.gmail.com>
 <SN6PR08MB556511839F0A54D34E898EB79ADB0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <CACRpkdbxzuYrFeU2H2LGaWb3kKqfZ4-SpWu5FiXdFVyz82-zWw@mail.gmail.com>
 <SN6PR08MB55654976327EF62990D4DD919ADA0@SN6PR08MB5565.namprd08.prod.outlook.com>,<CACRpkdYVruMggRHtOLWZ01N5yYx8GqAK3OtKC13Z=669eznurA@mail.gmail.com>
In-Reply-To: <CACRpkdYVruMggRHtOLWZ01N5yYx8GqAK3OtKC13Z=669eznurA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=licor.com;
x-originating-ip: [2603:80a0:801:c200:7551:df18:fd64:c52e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d45121b0-b746-4157-474a-08d8aab3ee1b
x-ms-traffictypediagnostic: SN6PR08MB4494:
x-microsoft-antispam-prvs: <SN6PR08MB449411CE78D0C5BBFE0117C39ADA0@SN6PR08MB4494.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z+S4G5j68u3SioXdN4ZETp8csRw8AjS+5+O1WTZVnlszJIGBv0c2FSJqNsotBdxG+IBzkrdB0E4pRwd2ZR75uknK515DFoiRxYjhnmY1Vl51qddPPfZahr2RLXmr42/hKAYzmMBCzm59wk5tqAHs8BkcL524GdvCDjyJh0jflJuVNWfafYkSc81n+oNScgL1+A9hCTRTqi1ukQnkEdV3oAqoVLFWvvYcNH1YpmIXGKheSC3nmUvcfCNOQ/uWPY/Yzfz7cRFPTfgoRIA7ftFBi70mFyCQSBdMiel3DNmzWSwkZTq3hzeJkIaRyN4cJ5AXemRTKywQSNIVO0RBr4XNqBIfnzNJWbwbhPTsWSvKdRvwp0UCkAyzAP8OKhuxLQ4dQ+vPtqOIBqICauYe+HSbIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5565.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(6916009)(7696005)(44832011)(316002)(478600001)(54906003)(4326008)(8676002)(2906002)(186003)(6506007)(52536014)(71200400001)(33656002)(55016002)(66556008)(66446008)(5660300002)(76116006)(9686003)(66946007)(8936002)(86362001)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?vnZTjiePhuS0kfu5r6ar1mVf/ZLLWM72IQSyoPOul+nymUFyxOBjGmZ/YF?=
 =?iso-8859-1?Q?UIQatyJj/2Vw3s4xEiiVtUg1MFuQxF8Uwf3woNlvxz+ypB6EMOTri2Lqej?=
 =?iso-8859-1?Q?p2ptDRtjA0c0n/cXFYvyOvVC7pfBSlnOjbnFKoBwfKB2XIMl2AK84gFXvy?=
 =?iso-8859-1?Q?LQTYUK7KEISYsfxCeO+MDIQd9/K081PPua6KhCKxM721xsm8YI1AxULPY0?=
 =?iso-8859-1?Q?FVJRJ85vLr3hui6LlTUA9utJyHrDvF8YI/4CMhAedlkcYZC3DNwKPQUR/+?=
 =?iso-8859-1?Q?oo90Lnhn1QZx/HEl5pYrCOMEuCNarRfEQq3HPvCOMkqQ9Y0KdLAd0X4fFm?=
 =?iso-8859-1?Q?xhNwl0UwfzQFJ91zwn5cgD1sNJvLI44/qY3xFSU5UW2hmBzKFeV5HI+cuZ?=
 =?iso-8859-1?Q?BhPJvyN83pGNuAa6MsB95Gu92XQIAAK4qJoHoAK/fN6dMh4Ub53C1h/yWU?=
 =?iso-8859-1?Q?Sre71hsAauOXdT1lWY8tqcGh5SiOGbXr+gE5iEVFlskhP9PE0dTHIgz4sq?=
 =?iso-8859-1?Q?bpcjtC5GAgZ6Y6J8cmcJcX0WHzYtBmlRM1BgzN4wXNy9XnWwN16YfiBl1o?=
 =?iso-8859-1?Q?TnLvCv9ZhJ5AkTOqZJK5he4FC8ioVCU+gffQI7MUcMD5pu9enh3J7qSjut?=
 =?iso-8859-1?Q?4onlgn5WzK8/HcYH3KDnPfxpgU7xGo+5OI7qJlfSBhYK2/5ak1Fbf6CWiM?=
 =?iso-8859-1?Q?LK4oFGZaso0oNt4fi2NcwzjrMAmCTSslM9tJF3qeh9382ipfXfJncAFOpP?=
 =?iso-8859-1?Q?6Cld0W26uVKYVyfLSLqIMUPG8oPiAmlAxpUOkcmlTRLOOYBISBw9y4mKDo?=
 =?iso-8859-1?Q?9/5qThj4iwm9M/UrK0SWDHtkCim86RX6w8SiKwZXaJMJwKegH8rJ8jes/a?=
 =?iso-8859-1?Q?B/L2TGM3xn7ejj4kmwaG577dE26hY/L9Ro0ToRRuPOgdOmOw4anxYWUvKP?=
 =?iso-8859-1?Q?EJD4UWoN+TWISOmoG3JqGtXxndcDtAueGcWIvIv9Is1o/ckga9DUWApESk?=
 =?iso-8859-1?Q?WTT2BGjkjqdXoaqete7bGFpRbx+2pMcYF11CnzfiGS2JkZJBhhvfZGJOmK?=
 =?iso-8859-1?Q?HpKe3HXJLL8uikBRjt3ORuI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5565.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45121b0-b746-4157-474a-08d8aab3ee1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2020 22:08:24.0390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0fT1At2tleKoKGB6uIbPaA5WlEdLL4kTnwGLE7swsyXa/K6Xpwo4kUA2APjytP3it+7hcqHWoFnKqLKVEf9mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4494
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> wrote:=0A=
> Aha you mean that iio_read_channel_processed() loses=0A=
> precision when converting raw to scaled?=0A=
=0A=
Yes.  For example, take a 16-bit ADC with 4.096 V reference.=0A=
The native resolution is 62.5 microVolts.=0A=
Yet iio_read_channel_processed() can only give integer milliVolts.=0A=
iio_read_channel_raw() followed by iio_convert_raw_to_processed()=0A=
with a scale of 1000 will preserve more of the native resolution.=0A=
User space can do this by using floating point numbers when=0A=
converting to processed.=0A=
=0A=
You are likely to lose precision for all ADCs greater than about 12-bit.=0A=
=0A=
Chris Lesiak <chris.leisak@licor.com> wrote:=0A=
>> I'd prefer a solution similar to the existing implementation of=0A=
>> iio_read_channel_processed.=0A=
=0A=
> That seems like the wrong way to work around a problem in=0A=
> the core.=0A=
=0A=
> If iio_read_channel_processed() loses precision we should=0A=
> fix iio_read_channel_processed() and not try to work around=0A=
> the problem in the consumers.=0A=
=0A=
> It's fine to fix all the consumers in the kernel.=0A=
=0A=
> What about changing the signature of:=0A=
=0A=
> int iio_read_channel_processed(struct iio_channel *chan, int *val)=0A=
=0A=
> to:=0A=
=0A=
> int iio_read_channel_processed(struct iio_channel *chan, int *val,=0A=
> unsigned int scale)=0A=
=0A=
> And just augment all calls to pass 1 except the ntc driver=0A=
> which then passes 1000 in the last argument?=0A=
=0A=
> If Jonathan agrees I can fix a patch to alter all the ~50=0A=
> call sites like this and include the change to this NTC=0A=
> driver.=0A=
=0A=
That would meet my needs and does address what I think is a=0A=
shortcoming in the existing iio_read_channel_processed interface.=
