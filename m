Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CE3F27A2
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhHTH3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:29:11 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18976 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238692AbhHTH3K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:29:10 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JKqgiO022441;
        Fri, 20 Aug 2021 03:28:19 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahka2nr9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:28:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lK417zZUIjrS8Ygwq4Lx7PYjIfvDcLfb5ttj9NiWdHR4IMBA2bctMEAj/K5aLIghhheuaEQOi4XdkpTkei/jYEGyGiWzw5a36ZptcUki6b1XMLmlnT6Veh+acYGLCFSL9JMO473a9hxCTy0xTeqIlOWVnZkmL3PMbeiOtiR7DJUKlxg9triD/HyDYAqMx0O9E2lBxGa+z5tXG0Bv8yQfSuQzrjYnP2oDH61CVgNKHRq1dw2D4VxJ/2e87Fm3hcfUnbZQ1thiEFNFogxZHlErhrUUTPgTsGY45e4rgggsANBgBKZDjCmM5+2I/ozkf+9M2fLcn7qbE1ECsbauXPGoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhCR55amxqQC29btJ5K0RQuaUtzdyuLg1lN/8+yTd4Q=;
 b=Y+XnmznXaeS4Y7PGW+I+NYzq1jP1AZ6qui/rRJc8aCkOqMJjdt7d0gyaXX0RTt3CU+7KKhvOS0dDnbIkuGFSiZxzx/kq2q+JvZU4ulo/NOprrO+ExQaA6yJCqKsiD2ixmtyvuD0D1txZ6hScR8/V0FBcSODxE6hpu7i2NEI3eZ1DDRIL5/dSndtTmDJXG8v+0SIb/9sXaXWo6sRI96v+HiXDn6bMIKFr1BLB8FuDaCsN4mPTPbAH1Ufe+x6v8wR0x99gl9wVD3wILwe8jpue1EhnetKRHGbSfRYLJ1inFwxxmgFFBLjiCLo7c/xyovnuUMkOTvvWzNGgi/fWZOUPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhCR55amxqQC29btJ5K0RQuaUtzdyuLg1lN/8+yTd4Q=;
 b=Bq2B64b5kHBEGur/pnarN1pCMZCebiswv72+P91lXN3qcjm8/JQr2wr0KWh7c4RcKH3CPjuaci1DNskwz1wKfXscFMhOCZCxIBGRGi08AwrdHRRlYV5i9SbCc+UHNS5TfoMiXlCjDcBAYHPlffeh11WVrtEsDyZfe/Bo7lwCAPk=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB4437.namprd03.prod.outlook.com (2603:10b6:a03:c4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 07:28:17 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:28:17 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 12/16] iio: adc: max1027: Introduce an end of conversion
 helper
Thread-Topic: [PATCH 12/16] iio: adc: max1027: Introduce an end of conversion
 helper
Thread-Index: AQHXlCHpXxt7HWxMkUGy8nQV2cSGzqt8AS3Q
Date:   Fri, 20 Aug 2021 07:28:17 +0000
Message-ID: <SJ0PR03MB635976F76F5121FFF26E858B99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-13-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-13-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1tVXpORFJoT0RJdE1ERTRPQzB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhESmxNelEwWVRnMExUQXhPRGd0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpjME5T?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGd3T1RVME1qUXlNVFE0SWlCb1BTSXpNbVpZYlZs?=
 =?utf-8?B?SGNXOUdhV2RYVW5VMVpUTkZOVFJWY2pRek5FRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVSnJla2t6ZDJ4S1dGaEJWbmRhZGtOeFVrNUxWemxZUW0wNFMz?=
 =?utf-8?B?QkZNSEJpTUVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVUpQV1VkalowRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90d2f895-f1df-4c86-f6cb-08d963ac1451
x-ms-traffictypediagnostic: BYAPR03MB4437:
x-microsoft-antispam-prvs: <BYAPR03MB4437B330DBCC49B7FA17EE1C99C19@BYAPR03MB4437.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/1GYntDOMuWj01ZPAr6MeBGWLBS7jYuOr2znPVFQnLBBKu5qFhW7LYpdMEd7qDAN+tV58RGUw9SPLrySVTqFg3gsUjqZGT6+0IaIqCVdUf3oq7YU/TRrQgvb2aryN36RNxFGbzxojTJ2yHRYvszQLxHTffYylMJyy59qwVCoqBfOHw8aACxIPkw/OFpx/SOGBHsArLEwTDs4SKRLttCfJN8WzpRMfY09+eJ0BMzDJlciCvtTxNHALtvma1+SxLdoZHFqR2s72HlgxsYAKQ+BCvGhCtsqOxT90/XFLKNr30ot2o4PMXai16WGQsTgfQiINz0Sq6cWlgYvoT8xT/eC/e6l1cXZ2nHhpQYyDQSO+Xuj9ZCIE5aNbh+LlUHPTo84nGCZ3cxta4UzYjFfsDV+wW9eoVqee1X8YNSFdF0lqYt0rAYcYotWBq3ukDlkEyxJpWXDSPOCB5PX81Z6JhksDNeagGpxYQ27r5ADRiayxkj1DDLdwOCLFFM5uMt6Mjhuux0IqUejLamDsS8celWtNwJ/bDqXexrKxXf0Up4I+hAFv9hmN6lIBBkZBO252DWWNYWJ/H4rrmf7bwtHk00wCPLWUI20Fz3CYgWudlD87Z78N3ptzbaLModYGU6cHY+VogIn+tO7IOiz6Lbtjk+YaL3+9M3U2o8QXkUsBpwT8xhqOMSQYH5C2l7XnRkywjsh2LD8S73T8F0L/+qDp1XKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(54906003)(86362001)(2906002)(66446008)(478600001)(83380400001)(9686003)(6506007)(38100700002)(64756008)(8936002)(5660300002)(52536014)(186003)(8676002)(110136005)(316002)(71200400001)(38070700005)(66946007)(66476007)(26005)(7696005)(76116006)(33656002)(66556008)(4326008)(122000001)(55016002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnRGMXMwVVdPTHc0YmpiVytBaXhEM0xqL2E3N3JYY2xKUnlnVGt6bTBNQThu?=
 =?utf-8?B?bVpYcG9UWlhKUHVRbStTRFcrSkVsY1RiNEhTU0RNbkFSS3did0Jld3hkODhh?=
 =?utf-8?B?ZjZDWEdjYVA3UnNJQnp0YUFWTjNjbUhYTW1vbXNiR0ExT2FIOWJOUHBlRWtC?=
 =?utf-8?B?a2kvcDdBbDhQWkgrd1hVaFUrTjNmWXZhNGNWbkNRTytTenZUYjR2b2ZSYjI0?=
 =?utf-8?B?blU0bjczcUwyVmlqcCtNc3gvcFdBMHo3OXBvM0pMMDd2cjBiS0VwbUMwcXBt?=
 =?utf-8?B?KzBQemdid0RZKzBwREROZ0J6S3loZWhyb0hEMmpKaWNhb3MzWTkrMEhQdnZv?=
 =?utf-8?B?b2pacWJLOGl3OFZ3N2RmejBvdll5TFhuTzhuMGNHb21VNnhmUVA5RE1ERlp3?=
 =?utf-8?B?S2tyd2pDeW5yOHhhNHNqTk8rQm1vQVB0Nk41SDIvOTd3NXFNMUlXRTdyckU3?=
 =?utf-8?B?Z296VVpVaFdSbUU2V05Camk4KzBCU0hWNThhZG0wVCs1V0VidHVKeDh4RC9S?=
 =?utf-8?B?RDlBRFpNNDBPRERwdDNmdUxhczR5WXlRV2lrRUs1T3YxS3JlK1owbFNYZGZD?=
 =?utf-8?B?bm5mTXRsT3BhUUMvTDNMMi9nNW92dVg2L0F2Y2ZlTEdhYzYveVdLbDQxWkZ2?=
 =?utf-8?B?OHk5NVM0WkZBeFpPWExxU2wwN0l5dUFqM1NqVHJHTWZYV01GWmU5d0tHUGx0?=
 =?utf-8?B?YjQyWHlkUGR6aEF0THVSZ1hDbnNQeVpweEM3WGRlcE92WVY3Z01XZm5MNlJo?=
 =?utf-8?B?eUpkMnFCMGtOblY2dVoyUm5zVFMweWhhakt0NFEwN3Azbzh4TUo2RHBXQ2N6?=
 =?utf-8?B?SEdrTjNMZElTYVJJL2NpL2VFS29JVTk1SlpLUXJBNmRRZFVjaFVSL1NPZWtC?=
 =?utf-8?B?YmhueTRwenEwWnd5WjVXNU5oUFNSb1VTdm1UdTJXS3NzRDd4dUgyMUJSYmRU?=
 =?utf-8?B?V1QvQVRoVktTUEU5bjZGb2ZiODNIa20vNEJSYWl6TUpwMjdjL0FOWHBUUVhl?=
 =?utf-8?B?V09GOUN2TmdTWmttMndxcFZ5WnVCS0hIWXE3WTM4UVRjNDlHekF4d2p4c2pu?=
 =?utf-8?B?VVJySWNsd2t4Vnl2ZGpEbE92T3JBQTh1NXRmMkVVNkJVSFY4S1VNc25QZGM5?=
 =?utf-8?B?T2J1Mk5GZnZwNDFheTViNDBGbWt0Z2cxRldpdS9GTWdhdlNjL0ZUcDA3azdE?=
 =?utf-8?B?bjZ2YTVDUEJndG14VnZjampyNms2Q2pBNDhUa1lKOGZiZThmRGtHcnRRQ3hF?=
 =?utf-8?B?aHFWaE1pOG95aXRzSURObmZpRmx0SW1xa214eFU5WkM5U3FlaW4wVzVkRHFN?=
 =?utf-8?B?czczaW81K3o4aTFNMHBQc0F4VldYWHhIajJFMzRZYU1kZGsvUGp5ZGxUaGJj?=
 =?utf-8?B?SE5HeVUxbmN5cVFZS25MNFd1cnRnR3IwSzZrd2UvYTJ4bGprTDNPUTQ2YkRh?=
 =?utf-8?B?KzlTTk4vaG05aitUSlFhZFk4ZmtVV3orZ3N4KzhFU2d2Q3BOdVZyNW94MW1l?=
 =?utf-8?B?VlpsZ1hlNS9xQ0hCaEMxZ0F3SHJCY21VTnROdDcvdDRlSTE4TThLVnF0azlY?=
 =?utf-8?B?ZjBiWUJDTThicTdiNGRaMlZWOGd3ZE5sZGJWeUJIWGZiMXpsZk9LdUV1VnBG?=
 =?utf-8?B?R1d5THNqTk4vc1ZuMFphQUdGYXVVdHFUNDVwV0RFSkpLQUF5RE1OOW1WbHNH?=
 =?utf-8?B?MThFSUhqcW1hVnIveGh2eU5JTUY3eFkrZUZhUXQ4NVlsTFNJcXVFaU9lN1Yw?=
 =?utf-8?Q?cG1SdaNfABcn80vNEM3wjPvChuk5PTdaeph+7at?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d2f895-f1df-4c86-f6cb-08d963ac1451
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:28:17.5678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5ZytviBRIGfvvLu/oagm8fx/kmVVuSI2yPdQ6VvzawXSy1RxNe2tGzN+sc+VjmZcHbgS8DUdpDR2TWufURBBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4437
X-Proofpoint-ORIG-GUID: fpW_cEQGPvMf08SMyDoKBn6-3UC2pcLA
X-Proofpoint-GUID: fpW_cEQGPvMf08SMyDoKBn6-3UC2pcLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTgs
IDIwMjEgMToxMiBQTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBDYzogVGhvbWFzIFBl
dGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IGxpbnV4LQ0KPiBpaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMTIvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBJbnRyb2R1Y2UgYW4gZW5kIG9mDQo+IGNvbnZlcnNpb24gaGVs
cGVyDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBGb3Igbm93IHRoaXMgaGVscGVyIG9ubHkgd2Fp
dHMgZm9yIHRoZSBtYXhpbXVtIGR1cmF0aW9uIG9mIGENCj4gY29udmVyc2lvbiwNCj4gYnV0IGl0
IHdpbGwgc29vbiBiZSBpbXByb3ZlZCB0byBwcm9wZXJseSBoYW5kbGUgdGhlIGVuZCBvZiBjb252
ZXJzaW9uDQo+IGludGVycnVwdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwg
PG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL21h
eDEwMjcuYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MjEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lpby9hZGMvbWF4MTAyNy5jIGIvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0KPiBpbmRl
eCBhZmMzY2U2OWY3ZWEuLjJkNjQ4NTU5MTc2MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8v
YWRjL21heDEwMjcuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+IEBAIC02
MCw2ICs2MCw5IEBADQo+ICAjZGVmaW5lIE1BWDEwMjdfTkFWR18zMiAgICgweDAzIDw8IDIpDQo+
ICAjZGVmaW5lIE1BWDEwMjdfQVZHX0VOICAgIEJJVCg0KQ0KPiANCj4gKy8qIERldmljZSBjYW4g
YWNoaWV2ZSAzMDBrc3BzIHNvIHdlIGFzc3VtZSBhIDMuMzN1cyBjb252ZXJzaW9uDQo+IGRlbGF5
ICovDQo+ICsjZGVmaW5lIE1BWDEwMjdfQ09OVkVSU0lPTl9VREVMQVkgNA0KPiArDQo+ICBlbnVt
IG1heDEwMjdfaWQgew0KPiAgCW1heDEwMjcsDQo+ICAJbWF4MTAyOSwNCj4gQEAgLTIzNiw2ICsy
MzksMjAgQEAgc3RydWN0IG1heDEwMjdfc3RhdGUgew0KPiAgCXU4CQkJCXJlZyBfX19fY2FjaGVs
aW5lX2FsaWduZWQ7DQo+ICB9Ow0KPiANCj4gK3N0YXRpYyBERUNMQVJFX1dBSVRfUVVFVUVfSEVB
RChtYXgxMDI3X3F1ZXVlKTsNCj4gKw0KPiArc3RhdGljIGludCBtYXgxMDI3X3dhaXRfZW9jKHN0
cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICt7DQo+ICsJdW5zaWduZWQgaW50IGNvbnZlcnNp
b25fdGltZSA9DQo+IE1BWDEwMjdfQ09OVkVSU0lPTl9VREVMQVk7DQo+ICsNCj4gKwlpZiAoaW5k
aW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNrKQ0KPiArCQljb252ZXJzaW9uX3RpbWUgKj0gaHdlaWdo
dDMyKCppbmRpb19kZXYtDQo+ID5hY3RpdmVfc2Nhbl9tYXNrKTsNCj4gKw0KPiArCXVzbGVlcF9y
YW5nZShjb252ZXJzaW9uX3RpbWUsIGNvbnZlcnNpb25fdGltZSAqIDIpOw0KPiArDQo+ICsJcmV0
dXJuIDA7DQo+ICt9DQo+ICsNCj4gIC8qIFNjYW4gZnJvbSAwIHRvIHRoZSBoaWdoZXN0IHJlcXVl
c3RlZCBjaGFubmVsICovDQo+ICBzdGF0aWMgaW50IG1heDEwMjdfY29uZmlndXJlX2NoYW5zX3Rv
X3NjYW4oc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldikNCj4gIHsNCj4gQEAgLTMxMCw5ICsz
MjcsMTEgQEAgc3RhdGljIGludCBtYXgxMDI3X3JlYWRfc2luZ2xlX3ZhbHVlKHN0cnVjdA0KPiBp
aW9fZGV2ICppbmRpb19kZXYsDQo+ICAJLyoNCj4gIAkgKiBGb3IgYW4gdW5rbm93biByZWFzb24s
IHdoZW4gd2UgdXNlIHRoZSBtb2RlICIxMCIgKHdyaXRlDQo+ICAJICogY29udmVyc2lvbiByZWdp
c3RlciksIHRoZSBpbnRlcnJ1cHQgZG9lc24ndCBvY2N1ciBldmVyeSB0aW1lLg0KPiAtCSAqIFNv
IHdlIGp1c3Qgd2FpdCAxIG1zLg0KPiArCSAqIFNvIHdlIGp1c3Qgd2FpdCB0aGUgbWF4aW11bSBj
b252ZXJzaW9uIHRpbWUgYW5kIGRlbGl2ZXINCj4gdGhlIHZhbHVlLg0KPiAgCSAqLw0KPiAtCW1k
ZWxheSgxKTsNCj4gKwlyZXQgPSBtYXgxMDI3X3dhaXRfZW9jKGluZGlvX2Rldik7DQo+ICsJaWYg
KHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCg0KSSdtIGEgYml0IGNvbmZ1c2VkIGhlcmUuLi4gV2h5
IGFyZSB3ZSBsb29raW5nIGF0IHRoZSBhY3RpdmVfc2Nhbl9tYXNrPw0KQXJlbid0IHdlIHByZXZl
bnRpbmcgdGhpcyBmb3IgcnVubmluZyBjb25jdXJyZW50bHkgd2l0aCBidWZmZXJpbmc/DQoNCi0g
TnVubyBTw6ENCj4gDQo+ICAJLyogUmVhZCByZXN1bHQgKi8NCj4gIAlyZXQgPSBzcGlfcmVhZChz
dC0+c3BpLCBzdC0+YnVmZmVyLCAoY2hhbi0+dHlwZSA9PSBJSU9fVEVNUCkgPw0KPiA0IDogMik7
DQo+IC0tDQo+IDIuMjcuMA0KDQo=
