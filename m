Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400BF3691E9
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbhDWMU7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 08:20:59 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37106 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231312AbhDWMU7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 08:20:59 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NCJX2H025560;
        Fri, 23 Apr 2021 08:20:10 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00128a01.pphosted.com with ESMTP id 382kdbyj23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 08:20:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcKMnG5p91gQRtJiO07ka4LECw5RcShwX4tZEMDkevsv+c83gURyhboNnLOJNuXZOXUW55IGHBDHwNZgVqwHzlkRjV+/tyGN3sTUKit4nTHQcwnJBGQggLwhjadaUs4flM9Rh3uXR/77JHpcehhpc9T06ZCAca/mdhC31d98fzlixuDIwFKFXUaQyAzb29J82fO+YObCbCmFFyX6PGjc69gDY6qGqavu994f1wbCYIXm/9lSu7VnwVzrP9p8GJCom1srWxObYZoczydyqLVIq9DqEG8dj/sEWZ7jU6csmX2xLGiqJKTBd3BEOV/iFLrHVVUZyvp+MDz4XSefEXuXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ3CMopBJbfmoPUBbjxoXg0v1dWVq+2Rqt0ebjdHNBs=;
 b=W2MS8zDnmhTDtY6T5vKXLRry8HzYt0vCulSnrzN3k4QzJuT72v5dOxoGsoIKs5fBcoR1hkaPQtJF8TdjWbIbVon2lX63Wj/r7R0tlgFJ+LvDMvGYhuBxcLVvF45OfwyAM4eYzmtRydy9DUB7V1Pv9s/P+uDhej6Y8C0kBPt6sBSfxE7YgMI5/j1oD8wecGvtysdg8n3V8PykLdaUwu2tw51jClpc/zsVpfXpXoK7VDQxq6nkNaZvGaqRSwuwQvlWaaH6s1viGk1J+PUsjMJHhAUi5yT5BW8n9UivlXYMigNTX9PmPiPDPD2OOCzyWYE3zoXwzQnP5bSGQp9Y6RFBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ3CMopBJbfmoPUBbjxoXg0v1dWVq+2Rqt0ebjdHNBs=;
 b=re/QMUJVVynkhiooM3ZGSSVcn6Qfm6h/ZLHpSDD4M/hn+1oIoQYk90fYXB/+Rb34hn8qiWcGdhbd8Ar7f1VWn6dASQrNDpjZFQ+Cm3vOHe7x8rltX4BLVE0UQzIsmmAWd/0Wppp0lsx00cBk/hd82wSYST089d+I0RCwxaT002s=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY1PR03MB2313.namprd03.prod.outlook.com (2a01:111:e400:c612::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 12:20:07 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 12:20:07 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v2 6/9] iio: adis_buffer: update device page after
 changing it
Thread-Topic: [PATCH v2 6/9] iio: adis_buffer: update device page after
 changing it
Thread-Index: AQHXN2Cp8BnpkysPxkOQt9kSn1xzsKrBtu8AgABMrkA=
Date:   Fri, 23 Apr 2021 12:20:06 +0000
Message-ID: <CY4PR03MB311220A749133B44C778F9F799459@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
 <20210422101911.135630-7-nuno.sa@analog.com>
 <CA+U=Dsphpu97Et6sgjd+9TUEHTw7xq44M5yL=CFtuCEU9QLxQQ@mail.gmail.com>
In-Reply-To: <CA+U=Dsphpu97Et6sgjd+9TUEHTw7xq44M5yL=CFtuCEU9QLxQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE0ySTBNakpsTURRdFlUUXlaUzB4TVdWaUxUaGlOREF0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhETmlOREl5WlRBMUxXRTBNbVV0TVRGbFlpMDRZ?=
 =?utf-8?B?alF3TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTXpBM09D?=
 =?utf-8?B?SWdkRDBpTVRNeU5qTTJOVFF3TURRMU9UYzJPREl5SWlCb1BTSlBia0ZyTlVw?=
 =?utf-8?B?TmNrSkJhbGhJWmpVcmNuWTVTMFZUWXpkTmNVRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVUXlXa3N6T1U5cWFsaEJaR05ITlhKVGJIY3lZMWd4ZDJKdGRF?=
 =?utf-8?B?dFlSRnA0WTBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRV0pLVUZOa1VVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZDYUVGSVNVRmhVVUpv?=
 =?utf-8?B?UVVZNFFWcEJRbkJCUjAxQlpFRkNjRUZIT0VGaVowSm9RVWhKUVdWUlFtWkJT?=
 =?utf-8?B?RkZCWVZGQ2JFRklTVUZOVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIw?=
 =?utf-8?B?VkJZMmRDY0VGSFJVRllkMEpyUVVkclFWbDNRakJCUjJ0QlluZENkVUZIUlVG?=
 =?utf-8?B?alowSTFRVVk0UVdSQlFuQkJSMVZCWTJkQmVVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZC?=
 =?utf-8?B?UVVFOUlpOCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a62:456:d301:47b:9590:7c55:846]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79afa7d7-55e3-445d-d73b-08d9065221a1
x-ms-traffictypediagnostic: CY1PR03MB2313:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR03MB231381C79A9045884C563F5299459@CY1PR03MB2313.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: caiTfkGYJSB9Cdch0YuDYC0ngftVqy1Y7KoylWOtQ3LCzNeVVY6iV9rtI/SAYTiIFhxxxSMN3eeuRzOeakDI+c7AQ3KOD/iWhCVlgvGmzxsEGX8tR1bVrRHax5nLwnBGGFZiMTtevLtkuHZGCc5lF04m1gP306JK7Cs+mOnHp30YuttgI707lfKoITTK/xOYBnUSQ/H6jTGv1KUdiQvlwdyutPh8yoffBXdAHNom3a+LEoEwv8OTvxGezdrpoAqyd8snd9Ka5ZTn7pUCWYhscKB9L7y/DEiSBwDmAUKphdJci7RunsXY/0Kfzn8F+bwm3Ihfwc6BV73vGBXYwwhW5FhsHgQXtfRhS2AHrXknfMT78ZQrz4n7lL+37QwV0XEoeBD4OcdIPGNUa0rNBqRiNrGDQMh6e2VVYWXlQmR+FUr+spihr/+YJrfGuqd1/H5bv2JoqBCmiTisKnYubydcdx2Uah8blEMBCuigj0HOX9lKTKIeIW+3A36+pmIlQaFOAsxktMqDWEqQiWXi8PNKTFPT04YOiNUPhttkKhZlOaRPa3j3bMi3DVf92yy8/j5q9zw37szF8jSTtsEpZCHE22+rchNmEf9Nwdj7YDsvyPtWoeHZxRv9PYW8JP+tbPAi6/L0Z/QiSWxSgJPZME9NQWGAiAQbR8aT4uwaNORjfe0jTbzypWtxsThWZwJzVHIN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39840400004)(136003)(76116006)(66556008)(71200400001)(316002)(66476007)(66946007)(54906003)(15650500001)(55016002)(66446008)(64756008)(86362001)(8936002)(9686003)(186003)(8676002)(966005)(33656002)(7696005)(5660300002)(52536014)(2906002)(478600001)(6916009)(53546011)(6506007)(122000001)(38100700002)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RmVzZmIzdGdRd1ZMRXMwVUFlcTZCNlhVUTJZOS9WRWovVFNzN0Mxb25HWnhY?=
 =?utf-8?B?OUdoR2dhd3UyRldMcFpWd1phTVRzVnROckFnWjVPZHZ2MWIvTUE3Umd6LytF?=
 =?utf-8?B?cDladWFXMFRrdGV3TzRzVUNWRDRuRWkxTlExOWNJZ2VnTFg3WjVud3lUdXR0?=
 =?utf-8?B?Kytlanc2SnhWRy9FS1ZXdllNVVAzS2RKNUdLSUdva3VqRk1lYklta05ROWhT?=
 =?utf-8?B?M2dRdXg3aW1nRFdSbk9NL2Erajk1RVdEWVZodS9zWTNoNmp4aEhLNm9ucmM1?=
 =?utf-8?B?NExUSzQwaVNHME00ZytPZXpzUEZ3T21lcmdIRjhDdWc2WGxVbEVQZm12WEJy?=
 =?utf-8?B?VDRDSXFHZkpkL2RYVGo2bUdVd3dFcnZJYU9WZDBlc3dyZStDSm16eHk1UmFP?=
 =?utf-8?B?bXJ1MXV0N0laTmw2Y256dG5pZWZGZ1ltMGswQmFibjM0Z29jd1ZIcEllOXFG?=
 =?utf-8?B?K2hoS0ZDc2NpOVBPVmFuYjlvSFdXQk5EQXU2R1ZRUkU4bHdFVmo4RGFySmpi?=
 =?utf-8?B?bHlwdjNSS3pKY0hZSXhoNlRnbEVXYXRua2RDMnhyQjQwSytseWlLVUIrb1dU?=
 =?utf-8?B?aHdCUitFR1FpWlpzOUUybUJ2bnlPQjNzbGFUVlJSZkVLT3A5ZjdWYzgvZnh1?=
 =?utf-8?B?RGREYzRhdFZtZlR4NE9idE4ycjJtNTZ2Mi85NnU0N3RncGc4RjNOS1JGUGw3?=
 =?utf-8?B?WkZHRWYra2t1dzhpNS9jbWpZblB2aXhHalhoOXlwZ3o3Uk5LeVJWVEEvT1BM?=
 =?utf-8?B?b01kaWltVVNaWk9ST0x5ck5HR1orTjlPRDd1bjlDL3hWTWtWcmY5dVAyN3cv?=
 =?utf-8?B?MFlabWlxQzI1bVhlTXhsbG5JMXlFK01EL2xsQ1daMmg4SWc1SUZFZzloUEZF?=
 =?utf-8?B?SXdadzZZR3JOWjJIOEVCeGt0bGlzSjVvWmRrcjZkYzJCLytDRndxV3JOSk1L?=
 =?utf-8?B?bVhLS0dEaTZDbTk3aDM4MkZLZ2lkTkhTaThXVzRneGJTSnZQbjRGa1Ztb0JO?=
 =?utf-8?B?R2hxd2tzTGZFazQ3VHVLSDlrbVJwNUc5UTVmOHJPU1lyMk9EeXYrM0puQTZE?=
 =?utf-8?B?ZXF5M1ZsWUpkTGJDd3RBZThvUW9TMXN6OGNMMjh1VFg1RFZ5UGJvNVhGbDBY?=
 =?utf-8?B?SHQ3Vnh4RlA4ZzVIdTlQM2NDVU9xMjBQQkgzVjUzSFV3V3poV0syU3FaSWpH?=
 =?utf-8?B?UlBldkR4RkY2TGRHYUNBZHMxYUp3RGpVcjJUWUNzNHhueFRZaUgrZVdtN2pJ?=
 =?utf-8?B?VmdiM1ZGZFFCbVJlYjUzTk9FbGdVRWRRbjk3OXFtY2NTWkN2RjVCKzlYOUM4?=
 =?utf-8?B?eU4xb3VzK3lkcDNsK0Yrdko5SlFvMXlQZTZXYmg5NXhhenljaDNoN09QMDBM?=
 =?utf-8?B?bzdoMjZ6aTVWWGxWdmI2M016UElEWjBIQ2tvaU9jSllWMjBhLzdKbnJvTTkr?=
 =?utf-8?B?d2tPdGlYazJjOEhOSG5PMG1PMnA4ZW5JTXAyOUdEVEpjRzBYQ2REVDBmZmpU?=
 =?utf-8?B?TEV3MVBmVUIyYUpiTDhqa0tYbGlXUU44OXpCdVFhQWg2OHpvQWpKZ3FGbmR2?=
 =?utf-8?B?alVvSzRDaS96ZXkySS9yNncxV2VNSWsySkpnZExHMm1ZT055R2VuTzAyZlBP?=
 =?utf-8?B?eWRIT0FvdmxzTCtxUS9iMFc0UlFmNzIvTlpveWg2VlNoOFRLb2RrejJrbHJJ?=
 =?utf-8?B?aGtHakdOZitDcDlmemx1bFJUTk5VeUtZb2xtb0c0bUpVUDgrZlBhVkZhRy9x?=
 =?utf-8?B?aFQyN2RNVWNRQzFzSWhNWEx2YXVEVFhyMmNqUGkwbDhmV3ZucUpOQWcray9G?=
 =?utf-8?Q?pXfIk2GBWr5vb89QtfQiHe5SuJE5+2luVNCwI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79afa7d7-55e3-445d-d73b-08d9065221a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 12:20:06.9396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOkLcgwyisVbaUPyp6Q9B5JXtSr5RqMBoTl69Inq+cS3reglMr/j98N1qaDOLxOHSSRM6Fo95uV7gUdq5eGL7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2313
X-Proofpoint-GUID: qiYrEPIL_t5e_OfN_H5iUdPttFYaGnwX
X-Proofpoint-ORIG-GUID: qiYrEPIL_t5e_OfN_H5iUdPttFYaGnwX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_04:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230080
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFyZGVsZWFuYWxleEBnbWFpbC5jb20+DQo+IFNl
bnQ6IEZyaWRheSwgQXByaWwgMjMsIDIwMjEgOTozMyBBTQ0KPiBUbzogU2EsIE51bm8gPE51bm8u
U2FAYW5hbG9nLmNvbT4NCj4gQ2M6IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9y
Zz47IEpvbmF0aGFuIENhbWVyb24NCj4gPGppYzIzQGtlcm5lbC5vcmc+OyBIZW5uZXJpY2gsIE1p
Y2hhZWwNCj4gPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBMYXJzLVBldGVyIENsYXVz
ZW4NCj4gPGxhcnNAbWV0YWZvby5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA2LzldIGlp
bzogYWRpc19idWZmZXI6IHVwZGF0ZSBkZXZpY2UgcGFnZSBhZnRlcg0KPiBjaGFuZ2luZyBpdA0K
PiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24gVGh1LCBBcHIgMjIsIDIwMjEgYXQgMToxNyBQTSBO
dW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gV2l0aCBjb21t
aXQgNThjYTM0N2I5YjI0ICgiaWlvOiBhZGlzX2J1ZmZlcjogZG9uJ3QgcHVzaCBkYXRhIHRvDQo+
IGJ1ZmZlcnMgb24NCj4gPiBmYWlsdXJlIiksIHdlIHJldHVybiBpZiAnc3BpX3N5bmMoKScgZmFp
bHMgd2hpY2ggd291bGQgbGVhdmUNCj4gPiAnYWRpcy0+Y3VycmVudF9wYWdlJyBpbiBhbiBpbmNv
aGVyZW50IHN0YXRlLiBIZW5jZSwgc2V0IHRoaXMgdmFyaWFibGUNCj4gPiByaWdodCBhZnRlciB3
ZSBjaGFuZ2UgdGhlIGRldmljZSBwYWdlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBT
YSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9pbXUvYWRp
c19idWZmZXIuYyB8IDYgKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11
L2FkaXNfYnVmZmVyLmMNCj4gYi9kcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYw0KPiA+IGlu
ZGV4IGEyOWQyMmY2NTdjZS4uZGRhMzY3MDcxOTgwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
aWlvL2ltdS9hZGlzX2J1ZmZlci5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vaW11L2FkaXNfYnVm
ZmVyLmMNCj4gPiBAQCAtMTQwLDYgKzE0MCw4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBhZGlzX3Ry
aWdnZXJfaGFuZGxlcihpbnQgaXJxLA0KPiB2b2lkICpwKQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZhZGlzLT5zdGF0ZV9sb2NrKTsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gaXJxX2RvbmU7DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBhZGlz
LT5jdXJyZW50X3BhZ2UgPSAwOw0KPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICB9
DQo+ID4NCj4gPiBAQCAtMTUxLDEwICsxNTMsOCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYWRpc190
cmlnZ2VyX2hhbmRsZXIoaW50DQo+IGlycSwgdm9pZCAqcCkNCj4gPiAgICAgICAgICAgICAgICAg
Z290byBpcnFfZG9uZTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgaWYgKGFkaXMt
PmRhdGEtPmhhc19wYWdpbmcpIHsNCj4gPiAtICAgICAgICAgICAgICAgYWRpcy0+Y3VycmVudF9w
YWdlID0gMDsNCj4gPiArICAgICAgIGlmIChhZGlzLT5kYXRhLT5oYXNfcGFnaW5nKQ0KPiA+ICAg
ICAgICAgICAgICAgICBtdXRleF91bmxvY2soJmFkaXMtPnN0YXRlX2xvY2spOw0KPiA+IC0gICAg
ICAgfQ0KPiANCj4gU28sIGNvbnRpbnVpbmcgZnJvbSBteSBjb21tZW50IGhlcmUgWzFdOg0KPiAN
Cj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saQ0KPiBudXgtaWlvL3BhdGNoLzIwMjEwNDIyMTAxOTExLjEzNTYzMC02LQ0K
PiBudW5vLnNhQGFuYWxvZy5jb20vX187ISFBM05pOENTMHkyWSF1MVJ5UE5laDhlNW03bFBmRGE1
SDVaalQNCj4gaEE5VGRzTEd2azJtMWtGUUJiQUtlNDBQbXZRUzhPOE4tZi1HRWckDQo+IA0KPiBU
aGlzIGNhbiBiZWNvbWUgbW9yZSBlbGVnYW50LCBiZWNhdXNlIHRoaXMgYmxvY2s6DQo+ICAgICAg
ICBpZiAoYWRpcy0+ZGF0YS0+aGFzX3BhZ2luZykNCj4gICAgICAgICAgICAgICAgIG11dGV4X3Vu
bG9jaygmYWRpcy0+c3RhdGVfbG9jayk7DQo+IA0KPiBjYW4gYmUgbW92ZWQgcmlnaHQgYWZ0ZXIg
InJldCA9IHNwaV9zeW5jKGFkaXMtPnNwaSwgJmFkaXMtPm1zZyk7Ig0KPiANCj4gQW5kIHRoZW4g
dGhlIGR1cGxpY2F0aW9uIGFkZGVkIGluIHBhdGNoIFsxXSBjYW4gYmUgY2xlYW5lZCB1cC4NCj4g
U28gbWF5YmUgYSByZS1vcmRlcmluZyBvZiBwYXRjaGVzIGNvdWxkIHNpbXBsaWZ5L3JlbW92ZSB0
aGUgYWRkZWQNCj4gZHVwbGljYXRpb24uDQo+IA0KDQpIbW1tIEknbSBub3QgZm9sbG93aW5nIHlv
dSA6KS4gV2hhdCdzIHlvdXIgaWRlYT8gWW91IG1lYW4gdGhlIGJsb2NrDQppbnNpZGUgdGhlICdp
ZiAocmV0KScgaW4gY2FzZSBzcGlfc3luYyBmYWlscz8gSWYgc28sIHdlIGNhbiBtb3ZlIGl0IGJ1
dCB0aGVuDQp3ZSBjYW5ub3QgZG8gdGhlIGdvdG8ganVtcC4uLiB5b3UgbWVhbiBzb21ldGhpbmcg
bGlrZT8NCg0KcmV0ID0gc3BpX3N5bmMoKTsNCmlmIChhZGlzLT5kYXRhLT5oYXNfcGFnaW5nKQ0K
CW11dGV4X3VubG9jaygmYWRpcy0+c3RhdGVfbG9jayk7DQppZiAocmV0KSB7DQoJZGV2X2Vycigp
Ow0KCWdvdG8gaXJxX2RvbmU7DQp9DQoNCkkgZG9uJ3QgcGFydGljdWxhcmx5IGxpa2UgdGhlIHBh
Z2luZyBzdHVmZiBhZnRlciB0aGUgc3BpX3N5bmMgYnV0IHRoaXMgYXZvaWRzDQpzb21lIGR1cGxp
Y2F0aW9uIGZvciBzdXJlLi4uIGFuZCByZWR1Y2VzIHNvbWUgbGluZXMgb2YgY29kZSA6KQ0KDQot
IE51bm8gU8OhIA0K
