Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2C2E2371
	for <lists+linux-iio@lfdr.de>; Thu, 24 Dec 2020 02:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgLXBke (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Dec 2020 20:40:34 -0500
Received: from mail-bn7nam10on2099.outbound.protection.outlook.com ([40.107.92.99]:25953
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726288AbgLXBke (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Dec 2020 20:40:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuvThA4VPbEx+mFkDBNhA+2dCowoEDIF0MeGoWgZpBVJ02/gzkWhrZ+Q+S2zG9MFIxLOhCYbdLKq622qIiYttr0ymczr+tTE7i3Fcspq+G77iad2IdGOXPjGVthDVOzdAQWjxMZVZqhybw6mPKgF4g98YdamsWQozUGQ1H8LTZXK8pp1VTIsjZjJ8QToFXFTl2ZfEsF5RH2Sj2hjT4EGoyTmPJc9NZgz2ddZG5Z1xCc77/yU6GzPc+M/lxvq6fNGpoMt+xZGvgivXMppcVz3+2T5JxTizPrh64yqlBvqiAuL0YzRo66DJj8GfjLDGZ2aoIXl0xq3pf403zJvzW1ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asJcjVmMAfqtlOaUIJur06HqIYwFQdpqG+ZFXXUv7hk=;
 b=e99Qsl3uwI68knzcpAAsXzbvDwaNvnFwtiCXdNP2ASobqcW56kCtyIEI3VVof8cm6f5I74fSaNlz9swoMaYNGBdo99PKx4u2h7y4bV+wgtaPgvowsmB2fBGRtFCxoXe/YPQg2UlFPpj0VCi9vn75wS5cyH7Zrmz4PmWKyQnsL0hWORFh+t8BjquWmDk93JX8n/mnawrD4EMhx4pbHqLMlapW6nOtL37kJE+pkYmeuQkk7IHVJbM+SMl7b+48nX7F7DuzdxEen0wuc47cAakPLoq2p2sgvl9/VFtgCzwvl7qTYL/8pEAFht/VZuCVOz4NKGhF0ejGx6MVYjTk/Jp6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asJcjVmMAfqtlOaUIJur06HqIYwFQdpqG+ZFXXUv7hk=;
 b=R180miw7dEJ9tsqIU5kDhqVVqTksvlg8vvzzHjPeP/dSDp1FUh+JGdGjit57Z5f0tR0i0VybSnGSU1BSOduSvb/TEt5zOe8neeveEbiPqAA9PY+Hx2RjJfck5QgcKesK6/kgxRGDlZV1WIEq8v9L+2EuvMyDj15fgqSKWzTnCqw=
Received: from SN6PR08MB5565.namprd08.prod.outlook.com (2603:10b6:805:100::20)
 by SN6PR08MB4127.namprd08.prod.outlook.com (2603:10b6:805:1e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Thu, 24 Dec
 2020 01:39:40 +0000
Received: from SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041]) by SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041%6]) with mapi id 15.20.3676.033; Thu, 24 Dec 2020
 01:39:40 +0000
From:   Chris Lesiak <chris.lesiak@licor.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] hwmon: (ntc_thermistor): try reading processed
Thread-Topic: [PATCH v2] hwmon: (ntc_thermistor): try reading processed
Thread-Index: AQHW2ZJfsXXsNRhKIU23+9Zg5xYZMaoFcfpp
Date:   Thu, 24 Dec 2020 01:39:40 +0000
Message-ID: <SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
References: <20201224011607.1059534-1-linus.walleij@linaro.org>
In-Reply-To: <20201224011607.1059534-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=licor.com;
x-originating-ip: [2603:80a0:801:c200:7551:df18:fd64:c52e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c0fcd0d-7919-4b21-5d5d-08d8a7acc7e1
x-ms-traffictypediagnostic: SN6PR08MB4127:
x-microsoft-antispam-prvs: <SN6PR08MB41271C2782D2F5720E1ED72D9ADD0@SN6PR08MB4127.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQm1d5ZUib4OTB83Bw//cyMzlhkaZg9R7YHRsNTEVNBOVaV/MwuGfqbvQkw1dnbRmeDUD+HfCn81OjmBPO1cftud8Eb5PzT7/gmYQxKLx/C3QkcxrFtZaAB0co3RkXhrD4YqWShYFMAgfiCFWkhEXuK+XZnDyW6wzSSR+Kc+phRLR0yXqZiQp6ziDOq8bUJrRyouWbj+kPz5WuVIKnFuXoD1DEHYNuZ5JlxjQyPuq56Nk2Qg1qaQP3H5jk12M3+nSRsaTtTUx02SBHmUZBYrt44Wkj9QXWrjy5l0X72CWajNG8N1ejKDimL3QLeTvljNhg/iRDDAs8Irt2GuAtTFI+g7C+HUfHcOPdIXodkfXNXNZFSRQvvKue51EJxsFbQcrhZYzwmOc5B/PI35zmgTmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5565.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39850400004)(396003)(186003)(8936002)(6506007)(33656002)(7696005)(76116006)(71200400001)(66446008)(86362001)(66946007)(4744005)(66556008)(4326008)(66476007)(64756008)(44832011)(8676002)(478600001)(2906002)(110136005)(54906003)(9686003)(316002)(5660300002)(52536014)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?cRu942siUlPXvGsvIbWMjEfg3bdfOYNujIfNBf1GY7R/1AhmqiXXWzB9zk?=
 =?iso-8859-1?Q?eaNBNLBb8SQlq4QVBZo+zE0e8LjyRZIpNhPG3fiarCsqLkqyujfuvtUiRm?=
 =?iso-8859-1?Q?pFzD34InfNsHCq4XJveFkgUdFu6MwD41y9VJCotZWnt8UnUhFBCwOQIlgx?=
 =?iso-8859-1?Q?SrcVMVCqHXyXHR3TGEZXOh9BlN2UKLEhWLe0WzdlIX+emhuQmoSlsOkinF?=
 =?iso-8859-1?Q?1fP4Ih92C3kXyC/XVaGP/vQ753bcrFAlqAbG3BULOfzL+NJCE7QH6SmgzF?=
 =?iso-8859-1?Q?LT5aFdGkOky4elhLm/aFEQts8VyXKyGLaa1lQjMXgzCLFMgXAWlWizLx/5?=
 =?iso-8859-1?Q?c7bqRwhFwtYCxBArHSi/b6sNTJhU/OKWgcOZb7odhXmSyFBdg9oLr7mrjO?=
 =?iso-8859-1?Q?GCu+hMqpeGx1HtRis1Vac0z1CJwNZ0oQMYwWzXL3kdopJzUTVv6BmZReSw?=
 =?iso-8859-1?Q?nJx1G9Y/YkDxNKUEda9g51uiXcJ/ekt9QcaqGAlfjeRa/vxYmonLVJ+ddk?=
 =?iso-8859-1?Q?nHmJu9lB1bPncMKYTLrTe0Qb5DYSG5bDAvGSruLFMK6bvSXBj+8rJ6GpwG?=
 =?iso-8859-1?Q?wE9WoO8AEOBuvLGDrZ21Ef6CmePRs/TfwsDqBIHtw+ig5QKb1+TRzgnX5Q?=
 =?iso-8859-1?Q?56BxG4pIJ99ee9g4zZgEZtNbXmVhYoEpvREJhgplXF9fXod5wy7Qp9INGy?=
 =?iso-8859-1?Q?ZF3Wih23P5rAcQ0n2KXwZI1Xx/F1B8cFT434uTEJ9hodpPYPnPF4TJtm4y?=
 =?iso-8859-1?Q?A8hFQ/EslEfOkonneOb4WLiovgA1/NtmJPC+WqTB8BiCcEBNDaxf+kU2JE?=
 =?iso-8859-1?Q?RPMEFD8dNLlYVS+bNjDjco2QC4jpiswuzVPKrth1hknVr+MZLiZh2vLwVh?=
 =?iso-8859-1?Q?9XwNqmQR75ZSQEhvbhYcDUxCWsXlGBh8S8UWRKqHZDcAtc5++RwHdOLoLn?=
 =?iso-8859-1?Q?T5TOyUvmTsOmkJoNNgijv/0/vmR+C/+dV+VNmICyulLpgy+XAFFFS3YKq5?=
 =?iso-8859-1?Q?Boeg4/Ndih5CYI68OUA+xwTo3KsfrechdqTU9D0Pcw7vEBjhMWikIehCZl?=
 =?iso-8859-1?Q?g6yTt5ImhK4bGCYptAuJVvc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5565.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0fcd0d-7919-4b21-5d5d-08d8a7acc7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2020 01:39:40.1744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8dwCyIsRH/s0Gouuv57O2YuQAXDh/AJkRcUYSzdDAeTIY64wIqZssNcC79EzybEsLKAQ0X9gDb8r/RgYP9/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4127
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Please don't use iio_read_channel_processed and convert from milliVolts to=
=0A=
microVolts by multiplying by 1000.  My use case requires the additional=0A=
precision that iio_read_channel_raw followed by iio_convert_raw_to_processe=
d=0A=
with the 1000X scaler provides.=0A=
=0A=
But I'm unsure about keeping the fallback 12-bit ADC in place.  I kept it s=
o as=0A=
not to break Naveen Krishna Chatradhi's use case.  But I'm not sure it stil=
l works=0A=
after commit adc8ec5ff183d09ae7a9d2dd31125401d302ba63=0A=
"iio: inkern: pass through raw values if no scaling".  Before the commit,=
=0A=
iio_convert_raw_to_processed returned a negative number if there was no=0A=
scaling available.  Now, it returns the raw value.=0A=
Does that mean that the raw value is already scaled to the correct units?=
=0A=
Or does that mean that the scale is unknown and all you get is counts?=
