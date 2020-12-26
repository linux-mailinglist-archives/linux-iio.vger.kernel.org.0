Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B711A2E2CD3
	for <lists+linux-iio@lfdr.de>; Sat, 26 Dec 2020 02:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgLZBqX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Dec 2020 20:46:23 -0500
Received: from mail-eopbgr690093.outbound.protection.outlook.com ([40.107.69.93]:23776
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbgLZBqW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Dec 2020 20:46:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5GWpz2t31eWJLsNRVWAthP1f5rPtIPVfgNRxKdhC+M6HvaJlI0cou6rhmzpVLkQ6KBfFP71ZLJmERA4lrhqJHS3xYjMH2fvTxy6y7X2GZk3WmY2m7pJtcS69I7fvcz/oCOeuG8aXSOZ4ALXa/OYlWQjYzhCEYJMMRzOIA66q+K46dcWYBoaSCLqYSeUG6RNlEVphASrolGYeuJpgT+6TyBoBZJb8DvosdLvTVMEyIX307k8/EYRTxPMEyysZ5Gs0fZw/Xtw4kwiccJ2q7ZkKAYUFrFXrGHOzRsS1MLrN87/5VZ6AzTlfHLTxjWB7fuuzhbviEqBHqFEoWy1ASxssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhyy2PWXC+TXu09oKefu1lxqNsXGsT7iBFWaRxz4eQA=;
 b=Kc0psWeUBIJ5joOPV6ke/5JrEsuIuXSmY4uopg7XpibFOs1uLvWVTdk1g9ylDQUbASqMN8D+qnT0D/tcS4XkDoj2shWICshi1MHS3NH6fBDLaCFBALjJBk8rpgmaDZ0hDUtzn/dp5abnU9rmCbk0F1zqNkcmT85Ua0vqygCrARY4NuTyFh3rpASB2GoOUqxZ/9fgZybZLJGCkPXCiZy34PPHSc0VPdmKomX7wJ+SdXBgyyFaTd+JcVz9cugahdIwRoBi6LMHAvOuC9yqVSng6i1QDfVrKEB0G0IthX9nT/4q742nNxuXXVFnREr3gSiAoYCBtSXTgicjwOG5EAgMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhyy2PWXC+TXu09oKefu1lxqNsXGsT7iBFWaRxz4eQA=;
 b=DxZotT+Y4v5Vampr1o3hXYCGRSX7pv+gLEVrndC2w2YED44Q1Ae4mCtJeG9xLBh8NuDq8mWW8gvSXc6uiI9uk6VvQfkP3HYwTZE+i5yPaRRcetUMRG9HdN5Lj/nQy0223+JrGQs/dgTSb1vp7OPtO1IbZRUg4Ygb5FuSpFFv61k=
Received: from SN6PR08MB5565.namprd08.prod.outlook.com (2603:10b6:805:100::20)
 by SN4PR0801MB3805.namprd08.prod.outlook.com (2603:10b6:803:49::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.30; Sat, 26 Dec
 2020 01:45:33 +0000
Received: from SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041]) by SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041%6]) with mapi id 15.20.3676.033; Sat, 26 Dec 2020
 01:45:33 +0000
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
Thread-Index: AQHW2ZJfsXXsNRhKIU23+9Zg5xYZMaoFcfppgAL82ACAACuFAQ==
Date:   Sat, 26 Dec 2020 01:45:33 +0000
Message-ID: <SN6PR08MB556511839F0A54D34E898EB79ADB0@SN6PR08MB5565.namprd08.prod.outlook.com>
References: <20201224011607.1059534-1-linus.walleij@linaro.org>
 <SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>,<CACRpkdZJT386M5y5cyCLYaWDhS+AnpXgB__VEshvYKbxN_=wPg@mail.gmail.com>
In-Reply-To: <CACRpkdZJT386M5y5cyCLYaWDhS+AnpXgB__VEshvYKbxN_=wPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=licor.com;
x-originating-ip: [2603:80a0:801:c200:7551:df18:fd64:c52e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 853f15a3-0bb8-4e2f-9e53-08d8a93fef71
x-ms-traffictypediagnostic: SN4PR0801MB3805:
x-microsoft-antispam-prvs: <SN4PR0801MB38057FDE4108C501E33E4CFB9ADB0@SN4PR0801MB3805.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FHU11P7VwuB8gxBolXLJv2ZzhFDgTrx8yX0t1AbQJqBIJe30qqstAOuVc4UYKJlivpQ9J2BhaYPCGl4N/WjJJuHGpjdIleDF3MSuxDiFKkW4CKA/d0HQk2MMviov9HfM4VggikRNKV5ct+NCWhuK/gnEP5Xu2SGkj0q0OcYqIuQCD7iM0OUBwFBbhHvYAIncCaNVPT3vD0bCNhnkaLfgeuZdjrguXdh0euOmQ08phAWbK67AObYDA9rG7JTQ9ZOPH5AZ0GO9S0immQSYD5rI60NM/N4yJywSuCC27jkXa8CwLm+WZTqKdrpV//Q+XMR2EFDjJw7PMJhH16/QQcaz/oCmVNFHirrGnmQvE0dHGQY01nKzWzmuoYoiLXzDCmPsj1RQQzbiRLelXuu4gmmlHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5565.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39840400004)(346002)(396003)(376002)(86362001)(76116006)(9686003)(44832011)(64756008)(66476007)(66946007)(478600001)(33656002)(66446008)(316002)(66556008)(4326008)(8936002)(52536014)(54906003)(2906002)(6916009)(186003)(55016002)(6506007)(71200400001)(8676002)(7696005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?KL3nOaY9cAI/QJnP1PNIiEuz7ozG9moaRwKzmbRFpI3wg+6xcL9lesEtPy?=
 =?iso-8859-1?Q?ToWTIqAr8XJUoHo5OZKTmJeKD6E793msZd5BekMa2v0/bDDc1V/Ej7wuLh?=
 =?iso-8859-1?Q?3VusiEVJMhzLwTUMy7Rpc9jI5EpzS4cFeYHky/USh6tREXffWTUnyG6QxR?=
 =?iso-8859-1?Q?zTkJgtrg0TFUfUNlXcoghqDZW2n6mfasOoBoBipiZi247HhrBIjXOQs7mK?=
 =?iso-8859-1?Q?RLYnm7BOOZk4wrp7Q9JAG6uvYzwWRhb2IFfkP2tnUhwufC3aYGcV6jdruv?=
 =?iso-8859-1?Q?e4R2hBorX+QDNJcXxqZxEVwnm2+XIHKqWVbEGV+jhzcQCKA+UwxfUe2WwS?=
 =?iso-8859-1?Q?l+ni+8udfRf/47nio6AK5tm9gZoybWSl1sMG3AnRO06lUJvCSz+mbbeheU?=
 =?iso-8859-1?Q?0glZk2BDRvUpbandq89IcDsigWfA4m4lNFM89h1ZRVfxB2AQOywczOATAI?=
 =?iso-8859-1?Q?WJgbEPoA/dXglVXyZg9COlVfo6bkqY7H1/W7GFS0BFddI+j3y8FE4gy0pI?=
 =?iso-8859-1?Q?bAgFn0BWgdnMGKZGtnM5RDGrKUMvL3uU3jAWHwJH07x55yTTWApWKwf+Np?=
 =?iso-8859-1?Q?wuX2MBCVAr2ShzsXquV/WTIs/RRsjDLyOSpJ1qvNr+qXN5xZUXHy6rMpA3?=
 =?iso-8859-1?Q?oXhS95lakJME7z59tHZwH/yumfVnrJ5UQccvYXWem2Rg1b31xGPxecf0Uw?=
 =?iso-8859-1?Q?/rgGNgfn2bvTgq9Wnk8eWHrz0iBSMfRkOImipgr5PJv0Zww5a1IH6j6RnR?=
 =?iso-8859-1?Q?Wpp8KT1jwTGT5k6FhciKGS+6OMTmKfX9YbpzWKdTQNMsL10XK2sSUF4mDh?=
 =?iso-8859-1?Q?+CqSUqxX29A01Mi2EBz3vGqdfEjN14/ZwFbVqkYklu2r6Uf0SvbNupP5xp?=
 =?iso-8859-1?Q?w8ZNg0kndV7dpzs7oNGTwx/seAhPpgan/k1m1X8fenoBjre39S5QI1ABtW?=
 =?iso-8859-1?Q?o3i0AXdPyskxEFG0L9iYpe0FQDjB8rRvcGZRG/+Otnskm9nWIEZy3f+poH?=
 =?iso-8859-1?Q?rKxe42e1Hmw6fBTMjiomuNzA4mMcdAfeL406bD5gizXYOGehsjnE5pMGkQ?=
 =?iso-8859-1?Q?0EV5YDYTaOgtk55YyLUPHR4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5565.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853f15a3-0bb8-4e2f-9e53-08d8a93fef71
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2020 01:45:33.7020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ix/TbzlOJe9vd/JohHuY4ETb+mh9X2UBe8cALKxlRTjATLvcnBzrVMNAR10L975vwwXLXPipkP2SBVm5huGNJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB3805
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org>wrote:=0A=
> I have to do this change because my ADC driver only provides processed=0A=
> channels (drivers/iio/adc/ab8500-gpadc.c). It provides raw values and=0A=
> it provides processed values but no scale. That means your code will=0A=
> not work, sadly. It will result in the raw value being used without scali=
ng.=0A=
=0A=
> The reason that the ADC cannot provide scaling is that the scale is not=
=0A=
> linear and based on calibration. IIO scaling is only linear.=0A=
=0A=
I haven't been able to find detailed documentation on the ab8500-gpadc,=0A=
so I have a couple of questions / comments:=0A=
=0A=
1. The driver appears to support temperature output directly.  Why do=0A=
you need ntc_thermistor?=0A=
=0A=
2. I don't understand how the ab8500_gpadc_read_raw output of processed=0A=
data could possibly be correct.=0A=
=0A=
        if (mask =3D=3D IIO_CHAN_INFO_PROCESSED) {=0A=
                processed =3D ab8500_gpadc_ad_to_voltage(gpadc, ch->id, raw=
_val);=0A=
                if (processed < 0)=0A=
                        return processed;=0A=
=0A=
                /* Return millivolt or milliamps or millicentigrades */=0A=
                *val =3D processed * 1000;=0A=
                return IIO_VAL_INT;=0A=
        }=0A=
=0A=
Note that both processed and *val are both of type int.=0A=
=0A=
If *val really does end up with milliVolt units, then processed must=0A=
have had Volt units.  And you only have single Volt resolution.=0A=
=0A=
Either you are working with a lot higher voltages than I usually see,=0A=
or something must be wrong.=
