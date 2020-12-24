Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DAA2E23FE
	for <lists+linux-iio@lfdr.de>; Thu, 24 Dec 2020 04:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgLXDQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Dec 2020 22:16:49 -0500
Received: from mail-mw2nam12on2116.outbound.protection.outlook.com ([40.107.244.116]:64609
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728578AbgLXDQs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Dec 2020 22:16:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdGoGwyIvVzRqUqb+mI/TUwMUTq6DdcHAHin/JMt0wm+JFfo5JBVs197xsDJcL5JgJmCrHwgpN4aKCG2zxprscCTSXAZa6TyIHUnSEOzPQhJgdoqmsMHLJ8/g9gLDm7mOYg4XcqWTNEKMWxC4w8SfN/0x9ZAttjOqgtGZllkAsJ90Y7ektoN3zf1PCygvS2YbqohgYAqxI8o39C/1v6Dz5sOa7Vco4kgBGLSCyD9D0X2tsufE/Z9gPvoBm6EdZ4kOgIVt9dRSqqYKSeSjewyXyFLFJJp3tq1KATp80VwaRGodkGim9uNeAcc+Xc3MN5LOWZXBJrnIr/x53meM48eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+iYLfRsmpxhNdxJ42hAm5NcWfPIou1qG3Z523khnYU=;
 b=ie1uJBs8j53McFrOYUpWTfdI1HNABlEICFAHDjT0RLxxI/IASvj4Rj+1T/y98gQTYJrr2TkjnEF4hR3srBt9elQRgaKSKWYAC+ZZMElKWhEe0tkT1GyegBj1D5Dpt69HVgmHuewjXpimpZFJ11HdhVPan/pe4yyhJ74+dfCggU0z2FJLbVQCiWAIZqXrrDO0sVAqTdVlLhw2UJgYCYIsHLXa8uBWXKA55NZcA6W+UApPFXUtX+a2lwW9R0PQvK134SnpYBKTrS5u7EjjkFClGpF2adeR7xySISCBWIvTNjndS/Oc8zrCew7rJXy8PcD2V4A1W99hIKViIY3Xdv/whw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+iYLfRsmpxhNdxJ42hAm5NcWfPIou1qG3Z523khnYU=;
 b=jN1eGy7JOkVA1uRdgHyVM4FSPnng9f9rNxkSrLzz0BOTONJzdw7UVH+NkDJPW6hbepzU94Fnpw/kZpXMqJLmml8iwt+NHd/FBNxZXd4MLoC6+Xus4QwdpqKxC+Kb74as1em5I3mTHp6kYh2DP592tGXleix59bZotWW1uZlIr/k=
Received: from SN6PR08MB5565.namprd08.prod.outlook.com (2603:10b6:805:100::20)
 by SN6PR08MB5342.namprd08.prod.outlook.com (2603:10b6:805:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Thu, 24 Dec
 2020 03:15:55 +0000
Received: from SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041]) by SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041%6]) with mapi id 15.20.3676.033; Thu, 24 Dec 2020
 03:15:55 +0000
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
Thread-Index: AQHW2ZJfsXXsNRhKIU23+9Zg5xYZMaoFcfppgAAdK/Q=
Date:   Thu, 24 Dec 2020 03:15:55 +0000
Message-ID: <SN6PR08MB55657ED2F83CE43C97C9C1749ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
References: <20201224011607.1059534-1-linus.walleij@linaro.org>,<SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=licor.com;
x-originating-ip: [2603:80a0:801:c200:7551:df18:fd64:c52e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31cd2a92-9baf-4043-053a-08d8a7ba3a4c
x-ms-traffictypediagnostic: SN6PR08MB5342:
x-microsoft-antispam-prvs: <SN6PR08MB534272F9F58F0E3116D038B79ADD0@SN6PR08MB5342.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blM+oYKxXlXsBjnMquDFBNi04HCF9Lq+V+Eg8O9iGthgB9Eyk8weNV7FcreBYvvZrwEV4xsdL0LSYnQHCp99mzG77jreg2Wyj/WTZLTBeGHywTJ9t33qGOOzRY9jo1PmrfcRLVh7/PYqwkeWbNzWtrN9xt4idtwTv0TiR4mHhhcMIKUBoswvgFx2CQBkdfwd7cJvCO8LQfKWR+oqpS+x5iX+3tvqXpsJ+QyD3AoChxiEuEdDS+bJP+po1KNYG8w8Eq0MoRLOuIqO0qOBa3nqVdihUkZ4/llHCLMTQ22+gjtX2GUXsKpaJrrMi0bT2ZRjgaBTNDDt9kUhiCKRUv38qhrn2gFYWAhf0T49Sa9MstBVAwqu5g3VniKCVyrFHbYCB2H3+xQQlccL+2RukWAveg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5565.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(478600001)(64756008)(9686003)(110136005)(53546011)(66946007)(186003)(8936002)(316002)(8676002)(44832011)(54906003)(66556008)(66476007)(52536014)(7696005)(55016002)(5660300002)(76116006)(66446008)(2906002)(4326008)(2940100002)(33656002)(83380400001)(6506007)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Tov1sIlDI1oV8gjD1ZQP2V9OyfgMMPXDA8wZb5JWzyuTPxEbWuKWMmGvza?=
 =?iso-8859-1?Q?dgCTA4d4TA5uDt8vED8OW2dtAefXCBZlwdWK8dfJOPyTcpLvB/Ep+MAYWJ?=
 =?iso-8859-1?Q?7YmrDyl5/r5se8WSfRHJd2a136RerTWNyO8MLMLoOnXEfPKLYQhNkixVQW?=
 =?iso-8859-1?Q?TydPVpfkDaMMPGV447NDtK7/hzmoeialTosVLAJODNkU5y4E+W3YLUd2Bp?=
 =?iso-8859-1?Q?6Fm0zkRm1WglXeLCw05rfgwVvUTqwmZQ2xhbHiBh7KaYuRNawORsXSHnuF?=
 =?iso-8859-1?Q?A9+SUk1XcV+T+pemJEZoSRNLghY3tO4v67fGq9QQE8UM45+8AOkniQ0e7g?=
 =?iso-8859-1?Q?84g1Hwpy1z3LOzl0JgwQFBjVqLxkzvExmIksMPowN5AJEUntmutEKSdEYl?=
 =?iso-8859-1?Q?WsY5yA/Vo+Cc4QpmzP6nmBgxZexRNKDqEgJw58HY7zc+/AvT0/k5rLYTvg?=
 =?iso-8859-1?Q?EJq+/+J5as5gI6l/t5EZSV1svm/YdnHiFTMvorL0HUg13GPF4wglfmm0ft?=
 =?iso-8859-1?Q?Aux57yIpTAU/fXqKKhFCbmTTR4VhvTuTTLNM8WXlxD/c9r21MkRrbwO+6O?=
 =?iso-8859-1?Q?dusDaLup0foBsmM5ocyfG2dJvmFignyAjQRVUCYh5g6YEgy/xPHEXOcyXH?=
 =?iso-8859-1?Q?MpnTHtWYu2FnQtYXAyaxhAcjHVI+jeWLSN9YBrddnGMIYDbm6ddGPGx4dT?=
 =?iso-8859-1?Q?y37JZW0MYa+ZAU2JFcqzc2cW4sG4PqykWxdzFtcg4zWEqGr4cw3HgJXoMj?=
 =?iso-8859-1?Q?q5ZfIEMerj7FFR5C0yDPtaoythCWuW7AzM0xCOCmVsxMedxdT4PenyJIpg?=
 =?iso-8859-1?Q?1yPgcLN3GNJAH/DUO6DxBohIVdpbga60VTopxJWWV6RVscr+AVclIC7wtU?=
 =?iso-8859-1?Q?AUFCWYGf9OSTQqwcNaVA3aOUEwNAsjM1ZnqaVgLj1dM3O1dfSnG9VtnlbZ?=
 =?iso-8859-1?Q?aZkk+gJLmlMvV2JFrBzi4Iah2cYf1F18jKQnHvBLBtkFfH0Fioc6X/nZXo?=
 =?iso-8859-1?Q?ZxK6lYbD96m6liYds149hm4fhIzr5P6N/zMwfxoazV/mKwv7ZHIs0xScbY?=
 =?iso-8859-1?Q?jPxGP+Rq8Kj/dSR9vR6IiEU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5565.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cd2a92-9baf-4043-053a-08d8a7ba3a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2020 03:15:55.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1/I7L0ucgXl/fR/D0nIHo1APc+olxdikH26MVT5J75WjBteSMrXdxzDvVOMYw5nAVnv4CShIc3qg42qWNeHKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5342
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A closer reading of the "iio: inkern: pass through raw values if no scaling=
"=0A=
commit leads me to believe that even when the sensor provides no scale,=0A=
the returned value is expected to be in the correct units.=0A=
=0A=
If that is true, there was a bug in the commit.=0A=
It failed to apply the caller supplied scale that ntc_thermistor.c relies o=
n=0A=
to convert from milliVolts to microVolts.=0A=
=0A=
Linus, would this change address your original problem?=0A=
=0A=
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c=0A=
index fe30bcb6a57b..79787474d511 100644=0A=
--- a/drivers/iio/inkern.c=0A=
+++ b/drivers/iio/inkern.c=0A=
@@ -587,7 +587,7 @@ static int iio_convert_raw_to_processed_unlocked(struct=
 iio_channel *chan,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Just pass raw values as processed if n=
o scaling is=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* available.=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 *processed =3D raw;=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *processed =3D raw * scale;=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;=0A=
=A0 =A0 =A0 =A0 }=0A=
=0A=
=0A=
=0A=
=0A=
From: Chris Lesiak <chris.lesiak@licor.com>=0A=
Sent: Wednesday, December 23, 2020 7:39 PM=0A=
To: Linus Walleij <linus.walleij@linaro.org>; Jean Delvare <jdelvare@suse.c=
om>; Guenter Roeck <linux@roeck-us.net>=0A=
Cc: linux-hwmon@vger.kernel.org <linux-hwmon@vger.kernel.org>; Peter Rosin =
<peda@axentia.se>; Jonathan Cameron <jic23@cam.ac.uk>; linux-iio@vger.kerne=
l.org <linux-iio@vger.kernel.org>=0A=
Subject: Re: [PATCH v2] hwmon: (ntc_thermistor): try reading processed =0A=
=A0=0A=
Please don't use iio_read_channel_processed and convert from milliVolts to=
=0A=
microVolts by multiplying by 1000.=A0 My use case requires the additional=
=0A=
precision that iio_read_channel_raw followed by iio_convert_raw_to_processe=
d=0A=
with the 1000X scaler provides.=0A=
=0A=
But I'm unsure about keeping the fallback 12-bit ADC in place.=A0 I kept it=
 so as=0A=
not to break Naveen Krishna Chatradhi's use case.=A0 But I'm not sure it st=
ill works=0A=
after commit adc8ec5ff183d09ae7a9d2dd31125401d302ba63=0A=
"iio: inkern: pass through raw values if no scaling".=A0 Before the commit,=
=0A=
iio_convert_raw_to_processed returned a negative number if there was no=0A=
scaling available.=A0 Now, it returns the raw value.=0A=
Does that mean that the raw value is already scaled to the correct units?=
=0A=
Or does that mean that the scale is unknown and all you get is counts?=
