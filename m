Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E62E327E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Dec 2020 19:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgL0SzO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Dec 2020 13:55:14 -0500
Received: from mail-co1nam11on2105.outbound.protection.outlook.com ([40.107.220.105]:5697
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbgL0SzN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Dec 2020 13:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqrTQ9xFEhchat4h9RjsvC0+Amxn2MaiZEc/kiEvVwV3FT195ljdvxBJ4nUdf7R7maglaxZVtsM5/F3OsuskUE6WpaJxCnXCj77QhzbiN7S8sF4KAd4vJ/O5WdPCNkCQ46R6P+77wj3dP583DfsUlJSHRsz0IwrXRAzp5z4/EGeB2Xcpb30UlrSzfAUrKRtP3209mKE/oZz7cZCY0Pe6bvNq1D3ZaUI++8eGSjF2u93WsaMTj0TuWy6HpqkcvTclyY63dkgSBcNnzziu4/dBEurjjS5QTzqkoGsnbRogdhqII2TWLMu3leL9IerPuKccMz3ZVDz77YZdpaO+9SjQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBpe2Lw6q2GemsELJ3uazcfUoNhwp84fyKRXrh7Tw8w=;
 b=m2LdnEgdg2C4t9Dmymws7zwPKLTpVYxzBHTw+zFuGssQP26KAlPzUVNJGGZKTpLDIUaga/B4IgiixmugD69vZXJMo44dQdb3yrh0Wty8DTU4w6ak/IDG05QVB0cbWU0KJWS6cpQ92DhJ7j9e6XLSQSGpclU5ylzM1h6zsy0+9iPiif5A0FB31GSCC/NA6K8ndNrD1z0xhdcJmFD1CO3xSCbwdHxze2oHwBm/SZB8tfVc8z9SbPcgxqFi6STAEjNjFVrk/Iw2HhbF7ChnQbUNk3uXV3ks4M+xLvy44eaA0e7M4IdB/S8rq+2qewIHMszJQ4MmOUTtyCA1YGuDTxdR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBpe2Lw6q2GemsELJ3uazcfUoNhwp84fyKRXrh7Tw8w=;
 b=VsjIH0rpAq29q9i584UuFhDPWXMqfy51yYoswphHtGXl4q6skKgNQviA3J4/xNtosK3NL3MH45IQJ+8zye0QyrjoM3kQrQ+xd4XuHvrWN7KoSEZNyw+VH2GCkgWgCAIqfab1naJJfo4CaeSN+fITso1lB7ICoGgyQMdU/LmsPjc=
Received: from SN6PR08MB5565.namprd08.prod.outlook.com (2603:10b6:805:100::20)
 by SN6PR08MB5071.namprd08.prod.outlook.com (2603:10b6:805:75::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Sun, 27 Dec
 2020 18:54:20 +0000
Received: from SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041]) by SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041%6]) with mapi id 15.20.3676.035; Sun, 27 Dec 2020
 18:54:20 +0000
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
Thread-Index: AQHW2ZJfsXXsNRhKIU23+9Zg5xYZMaoFcfppgAL82ACAACuFAYACX8EAgABSOTg=
Date:   Sun, 27 Dec 2020 18:54:19 +0000
Message-ID: <SN6PR08MB55654976327EF62990D4DD919ADA0@SN6PR08MB5565.namprd08.prod.outlook.com>
References: <20201224011607.1059534-1-linus.walleij@linaro.org>
 <SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <CACRpkdZJT386M5y5cyCLYaWDhS+AnpXgB__VEshvYKbxN_=wPg@mail.gmail.com>
 <SN6PR08MB556511839F0A54D34E898EB79ADB0@SN6PR08MB5565.namprd08.prod.outlook.com>,<CACRpkdbxzuYrFeU2H2LGaWb3kKqfZ4-SpWu5FiXdFVyz82-zWw@mail.gmail.com>
In-Reply-To: <CACRpkdbxzuYrFeU2H2LGaWb3kKqfZ4-SpWu5FiXdFVyz82-zWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=licor.com;
x-originating-ip: [2603:80a0:801:c200:7551:df18:fd64:c52e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f280300-6b85-47e4-f47a-08d8aa98d19a
x-ms-traffictypediagnostic: SN6PR08MB5071:
x-microsoft-antispam-prvs: <SN6PR08MB5071B055D39744DDD36459A99ADA0@SN6PR08MB5071.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YndHCZnzFbJNFP/0CNK8qvifT2TjSRgBncu7dZmc/v7vHdzC+zBRCWzi8oJDEWzOehfC3+iP/mhnRNLKVpQj06I9KqSBqvCdk9KisGvFshQIqw4EhBLKZKmS9x8YtTr97JeDfbZXKbLRdyqpfegK/u6Gg2t73nR/5lBKt/i/eHY65TO6op+m0AeVIK4Lt3LOD4OvsgMFqv0v06rD74+zyOwTzV1/ZsBsIflqO2QWLYucH/6XpH2CguY2IMkAbSlej+W06XKqSj7iRTXHnfMoR+TledsQgAtsFGg62iEBqQP+rarwfN6SG3rx2IDeCkNo6pD/dd29Hzh/Pfzo7KtTbYlfZZ3k+rd6a+uS+izXhXTCc/3z8eptYzEPLPi8fqYD+t0YhzCbnLAMjGZJg2H9+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5565.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(346002)(136003)(396003)(376002)(8936002)(9686003)(316002)(86362001)(33656002)(5660300002)(4744005)(6916009)(7696005)(54906003)(66946007)(4326008)(52536014)(71200400001)(186003)(44832011)(55016002)(76116006)(66556008)(66446008)(478600001)(2906002)(83380400001)(6506007)(8676002)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Z35/YzfjhSMAoYQIjC7XYk5NF67T1kODxlrY1LWOEveCG2+weTMTTZG3QA?=
 =?iso-8859-1?Q?6zCP6o2fczMUAbCJxJyjdgIra+dvwjfp5wFvXpV9Ae9GSY3xOVqgqF9iA8?=
 =?iso-8859-1?Q?MsDpgQT9ZJyziTL3sj/z2wEtalSblkg9Hstg3Lkcac74JBO8uwpyD8vbSa?=
 =?iso-8859-1?Q?ybq0jmaappTwxmloJs92XONyHYVItCsEtqWnvLnhZUR7xptgCYR7trzVoP?=
 =?iso-8859-1?Q?gbCRwmAqSsIS23bYYsy+OoIbtbvHF7dljjdeG2fyBETowSN8DGpMOPT9OO?=
 =?iso-8859-1?Q?pmgSFNgZFGK9NRepKK9NRYszCStvhBT0JHIBQ9tpOwFU7HnG+Q7Knsijqz?=
 =?iso-8859-1?Q?7R7rIoQTL+YuJLfHmTjqVhP6Q4UQL/slLlCAUfkwcUNr1dp0ewwxU3mwas?=
 =?iso-8859-1?Q?BBd43WdjZVWEYKx0zy7xhZEGuMkX7VE1KcT3xkpUQ95UWz4NU2lePWqwNt?=
 =?iso-8859-1?Q?MdxOoAtf2+61Axky7SY16OMYxmhJz6xKKkmvNhyZmUm6aaKRsH6XB+cr8d?=
 =?iso-8859-1?Q?dX/1uTdJQ/eXOr6xJ+OrNSactX9imM2+PsAWOd1DS3UWMap6pdvi1Ij3U6?=
 =?iso-8859-1?Q?ibTQXZk7jTrXtXbym5GSRd14n/z6HDRtKJ2iScSi2xhhPeh36lMtkaIzqc?=
 =?iso-8859-1?Q?mhWw/QW02l/UZdYQUXIX96Bp2HI0uQ0Nbof4WA8G2NOoJ24Qmd2dkx0mxt?=
 =?iso-8859-1?Q?rZYTV+1DVSvaM6GXiVGHc4ILmZxYAFBgipymPGq1sDNo/EMCzC782N7XKr?=
 =?iso-8859-1?Q?kNA86AgPDDvd2JE5RWhpnx87qCjyFzXn3oZ16PAuZzK1svPPsZLnCl59XO?=
 =?iso-8859-1?Q?26n3MAaS//2msd6F+qIj64Jyq5ny0ZfLsK+/MGUaQ9h6B8P9miCdoJxq2Q?=
 =?iso-8859-1?Q?gHAvlFB9YXg6fKhPM4iUHjn3G8Ur2m8O/uVPcIvaTC21g8nucmqxly2ZJS?=
 =?iso-8859-1?Q?9oiUnIS7S9A/gjSRSqhy5+L+MFf5D97D5BXoaGndhHrCHtchWKA28NRVid?=
 =?iso-8859-1?Q?GnolUzPo9tRkcq4AEcrU+ZCaUxq7T/wzgtJ2ML8hde52+5+7AvEUJlaXLi?=
 =?iso-8859-1?Q?UKU1s7Ai37Ff7Dccwgzz2L8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5565.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f280300-6b85-47e4-f47a-08d8aa98d19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2020 18:54:19.8880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haTKSTdy0vwiF2oAa3SbpcwQZNhjsTt8R7sYmMJeFx0BNM8LYFhnFY7oxzGJBS3uO1I6pEJYeilJnzq/Dbasig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5071
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> wrote:=0A=
> But do you agree with the general stance that we should=0A=
> give precedence to using iio_read_channel_processed()=0A=
> and multiply the result with 1000? It should work with=0A=
> any driver I think.=0A=
=0A=
In order to preserve resolution of the microVolt value for existing code,=
=0A=
I'd prefer a solution similar to the existing implementation of=0A=
iio_read_channel_processed.   Sans error handling:=0A=
=0A=
int uv;=0A=
if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {=0A=
        int mv;=0A=
        iio_read_channel_processed(channel, &mv);=0A=
        uv =3D 1000 * mv;=0A=
} else {=0A=
        int raw;=0A=
        iio_read_channel_raw(channel, &raw);=0A=
        iio_convert_raw_to_processed(channel, raw, &uv, 1000);=0A=
}=0A=
return uv;=
