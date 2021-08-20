Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83F73F2754
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhHTHLq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:11:46 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:43562 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233162AbhHTHLo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:11:44 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JKBXie022238;
        Fri, 20 Aug 2021 03:10:51 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahka2nnk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:10:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdgUiwrMod7CAoLf4ZQZiUYNBm5SE96JGL0MzHjEkzDcDO2x90gqjQdSaO035LGk6Bh6e1122ffKWDWy1aglV+vkWwwkMPkX3Tz1xfHMirmzhDODA85d3oYovChrU+W1X9vqCf5VxI9t5TKiFdskcebHkHGxbVfZnSm2//7OXdfitMjyfTzyR/JpPjxVhLWPZrcdAhOuzeEYPg0mIiCjRGPOQICZc8sHx3JlUkbTsVqM6Cq3+59Yx+yGGDt6VYwA8GJQ63C8SolKXfw+p8BE9HBoVWwl83zk+CsQ1lRij4LBZXXH1Rh+gw4/4+FXF/RIXimntrkvF5XiL8ukojbZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWIU9eJKWWUdCMbBZypjP2xKfXN+VMEtoBGdagUyJ68=;
 b=JlMKlC9KNl9W6xuz5AmtPY5n5K3c+xncdLcHd5wURSGGN9zYN2UO1zzqe+Zx1N3Y7Cgvg/JMTumZi/jb9le83d3pZAHzDxunQbvPsbgPj0ZuzBuqjwgt6a0xqvI9ScHstmezEC1CnBTSZdVBYpQKzwqEbCF2OT4bcOsONxyB34ywPJ9pgFnGO6PANG0s5LZfc0UdSa8s9O39Qbbmj8IVy1MHdeTioDJnCoRgc5UnqYGldApuzUkWzndLobsQRp0PHI6RB9EGUcXCuUv60l8oc3u3sYZXEpFRpLjTznu9gcKad48eJoVU9ZlJTmxviSPzg5Fux/8PLBVZKNMXS93Hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWIU9eJKWWUdCMbBZypjP2xKfXN+VMEtoBGdagUyJ68=;
 b=gM6JfqLZz0s2asLa/rjmAmafNBjX9eFHbjecuHsTQMjnTKrU9A+jkVxUzyY5anTvuQxpoBDVM42zWWxzqOTriPYpVg42G5rzq/hI4TsVGpbVe2760BSyX92bs/K+0RCSY7uorfJGve+QtWwD4yVFstKcZeC3T/ISxPutM7BlrbQ=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB4630.namprd03.prod.outlook.com (2603:10b6:a03:13d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 20 Aug
 2021 07:10:48 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:10:48 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/16] iio: adc: max1027: Push only the requested samples
Thread-Topic: [PATCH 03/16] iio: adc: max1027: Push only the requested samples
Thread-Index: AQHXlCHZcvfItjMzgEq4yH/BqTkNM6t7+sRQ
Date:   Fri, 20 Aug 2021 07:10:48 +0000
Message-ID: <SJ0PR03MB6359415E120CFD3EFAF417F599C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-4-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-4-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFltUXpZakUyTVRrdE1ERTROUzB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHSmtNMkl4TmpGaExUQXhPRFV0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTXprME5D?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGN3TkRjd01ERTFPREEwSWlCb1BTSnJZa3RtVEdR?=
 =?utf-8?B?eFFYTlFjVFZMYzFNMVJHRTRUa05aVDJRNGVVMDlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRTRUVFpXTDJ0d1dGaEJaR0pqV1hCamJsUlNaM1V4ZEhocGJI?=
 =?utf-8?B?bGtUa2RETkVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: b408d923-d353-4d23-e8c0-08d963a9a300
x-ms-traffictypediagnostic: BYAPR03MB4630:
x-microsoft-antispam-prvs: <BYAPR03MB4630D161DE1D53F32EAD965699C19@BYAPR03MB4630.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6e8Fh0kRuAd4qBn+9prs7MOzpjGH/dgjpbuYYvGdL9+N4sOsNSauFzAJCaN+3LC6aTGuomJGR5b94TXKUVNWznwzRn5lOaOHGZR7P9I3t8cz3sH0HvNXbzmAb2/s7GdPC8FxM9Ii1xXdXBApdTaFmVYU4kF4sSncdzWTJCxCXHAabTOtNnSjifyDQFc/T73pkRo1y4stn6WrGgO9gNURH0MzyjoAoRlwJWZq8/wicjos/QeOkpirxVVzp74Ipebodw+vRmAr4hcXeCu+g1EQuW7Jjf8A+B9d+lmOoVa4rOvUTUx0ffpqY7wmooSmjflr/8WGA8DzG1kMqGgKPUk8XCrGAePJYAkl6XgyyTYR2NgA1+SO3xDHzIt45CGDdbXEPovyV83SyfvkFPX93qw959GsPOBB+Uy7L1EGkgVWOOhU0RJ81yyQC/WTy/Pvo2LKw+++kaAJzgQ2KFsEHmdQYyB4mcM9kGJTlM+hmhIjlYbvKqBlBn48kMBUWcFRBqMWf2a152+NU7lQ9GkIKLP90ZC3WJK8LTbliRZ341x47PYi0reDCc4mMBX1xyQf1I9k4vBh6ONEzmFyNYp9snz5JRG/tMJ+nnqB02GSnIPQAlPCesoqwPlPpyRy4BfedWOWqSYQP/Lu7Rj9ccXOuwqvTHzUPcdZeu9QcvzIasxuCVeZMUg3rbSdjj6M0Jof6n/7XEC5dtzFeb4zAzn2rYALA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(71200400001)(186003)(8676002)(76116006)(2906002)(4326008)(498600001)(110136005)(7696005)(5660300002)(9686003)(122000001)(55016002)(38100700002)(6506007)(66946007)(53546011)(66476007)(83380400001)(66556008)(64756008)(86362001)(66446008)(52536014)(26005)(33656002)(8936002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTA3ZnJwNE1aeER5Mlk0aUNxVHMrSHZpSTJxY3VIMmo3QkhqOFIvbWNkNGJj?=
 =?utf-8?B?d1RjY1NmTk5iSnVSNlVDZFFrbVRxNzZpRW54SFZjY3RzZTJoUmRlVENLVUYw?=
 =?utf-8?B?VVp4dXVvN082VlMwZ2RzeGR5RGdZLzgyRVYreVg2ekwwNVlSbVArV1hLRVR3?=
 =?utf-8?B?MjkwNWZ3ZTB5elNMM1RnTnZJTWxxRmVmQm15NDJXZHNVSGM0MWFuc0JpU0pS?=
 =?utf-8?B?VytSeERGR29Ub3dCbld5N2R1UUg4VFBHSkRMQnFFYkFPSEVwSjBGN0JhcFZi?=
 =?utf-8?B?czFRbCtQQnBack4zVEYwWS9Vc3lNTkloSHh6TnpYdnNvc0VXU3ozaks4K0E3?=
 =?utf-8?B?TSs1SDR1Z1BnZ0Ewa3RESHMrVXRUUWdlUE0yb3hGQWk0OC9KWllSclhwc21Q?=
 =?utf-8?B?SzlmdU44YWJrczFPeGcrM2lybU90Y0MyQmVvKy9aUUF5WmVRNE1VcmpseGVK?=
 =?utf-8?B?ekxPS2Y3U2hiS0x0ZFFHU3dheDM1OHVYOFRnaFhOVi9sR3NlUkRLTkdPS05R?=
 =?utf-8?B?djlFS2NRcFQ3empRV0ZyaGJuc29NekE1M3JPcS9BdzJHRyt5b1hFaUpiOTIz?=
 =?utf-8?B?Z0xscnVwSmxNTXB0TGJMYkdEdkpVUXIwbjVOVlROcDdFRFdvYnVBcUgzOHJ3?=
 =?utf-8?B?ZWZvNGR1WlV3M2xUVUlKMVZTZzNlcHVSUkI5ZmlxYVJxR0NrVHpJSGxnd3lD?=
 =?utf-8?B?YW1UM1U5L0o5cC9KR3BSYzRuUnI4OVdyQ0Y2UDJ4VjZNSWN1RUpiUW9UcTl4?=
 =?utf-8?B?eDJEbTlWQ1VINXdhcVhFZTI3WFFIeFNaclJ6bGozVGlzZFUrN3hjTGRwSnNU?=
 =?utf-8?B?MVZ1Q0t1d3FOdVJBMXlCb0d3R2NOU2s2REk2bW05NExCbVV0ZjZ3dzRvVDVJ?=
 =?utf-8?B?QXRMcGkyMk1YODhoOHlSTXlSM0laZTBLT3VIOW4xWjYxWmg5a2x1T0VadzE2?=
 =?utf-8?B?WmIxL1V5TTZGWjhpVTBITEgweS80aUc4M0E1S0MwZTYvWkN0TFQ0QzQ3blFM?=
 =?utf-8?B?NHB1YjRTVkpvaG9DendOQi9GbDMvandMMnJWRUNWYTdtMTFxQWdQNUJORUg1?=
 =?utf-8?B?QVlJb3NxeUI1Yk9WZ1QzbTYzQ2ZDWS9XdExDdzVMTUd6U1BKQVRuQWpGTk9F?=
 =?utf-8?B?eGYzQTBKS0RSb0xTSmRQL2Qva244R0JueFh6OFAvLzM4NEFyNXV4VnFPd0VI?=
 =?utf-8?B?dEJKSEljL0wyQXhGTHZFMXJrcTduWHhYMkplbHJDTDJXZEY1MDV5Z3RPZmgx?=
 =?utf-8?B?UGliVUViWDVVTzhJcGoxZ0VMT29iUlpMZG4vZlVNbURIb2VXL3orcjRJUVl2?=
 =?utf-8?B?NE5LeGJqcHlpRm5SRUhQcGpvSGpOcWZEeVd0dFFJNno3eHRVQUtnTG9XOXMy?=
 =?utf-8?B?TzJEaE5maGdzSWdTaEx1eGROZnltRDBnYnhkNWxjVUFacnlONXBieVZQcmFB?=
 =?utf-8?B?MnVNYVVjUzhraUt5ZzNDdWF0cVVSN2R5VnIySkhCS08va1k2TGlDeU5oVmtv?=
 =?utf-8?B?UFhUdC9JaVh0aVI5em5SZkdBNzJIUkducVRBbGhNdmUrVXF5OS9PMkV6d2ZC?=
 =?utf-8?B?NE5pc1pZTks0YldpMTcyZzVPNFNMalh2SVZCR3JuKy80cWtKd2ZpSERyRWFC?=
 =?utf-8?B?TURFZXNMWUhhb09iQXZtMHNBTDlFaVFZa3pFVTBmQnVRQnZLMjcxWTJPQk5V?=
 =?utf-8?B?eFdVbFl6c0t1YVk3UEl6QlBzeE1GQXV6R2V5SW4zV2tGVXBtSGQ0cUVhb1Q5?=
 =?utf-8?Q?MqAsshkIEOLAXTIK2vOFMu/3J+Agsp8+dpE3FLA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b408d923-d353-4d23-e8c0-08d963a9a300
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:10:48.4636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWtW9XBn5blDxSaWfCvw65SD6iaxukh3iqRDiOP/NpV+2HVVKHkCZLmux2vlcRiRIzOra6OtlIkSi+S2CqRa3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4630
X-Proofpoint-ORIG-GUID: IbNxMT0xUBsbg-X2dVf4O_fUb1lwzY-J
X-Proofpoint-GUID: IbNxMT0xUBsbg-X2dVf4O_fUb1lwzY-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200041
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTgs
IDIwMjEgMToxMSBQTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBDYzogVGhvbWFzIFBl
dGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IGxpbnV4LQ0KPiBpaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMDMvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBQdXNoIG9ubHkgdGhlIHJlcXVlc3RlZA0KPiBzYW1wbGVzDQo+
IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBXaGVuIGEgdHJpZ2dlcmVkIHNjYW4gb2NjdXJzLCB0aGUg
aWRlbnRpdHkgb2YgdGhlIGRlc2lyZWQgY2hhbm5lbHMgaXMNCj4ga25vd24gaW4gaW5kaW9fZGV2
LT5hY3RpdmVfc2Nhbl9tYXNrLiBJbnN0ZWFkIG9mIHJlYWRpbmcgYW5kDQo+IHB1c2hpbmcgdG8N
Cj4gdGhlIElJTyBidWZmZXJzIGFsbCBjaGFubmVscyBlYWNoIHRpbWUsIHNjYW4gdGhlIG1pbmlt
dW0gYW1vdW50IG9mDQo+IGNoYW5uZWxzICgwIHRvIG1heGltdW0gcmVxdWVzdGVkIGNoYW4sIHRv
IGJlIGV4YWN0KSBhbmQgb25seQ0KPiBwcm92aWRlIHRoZQ0KPiBzYW1wbGVzIHJlcXVlc3RlZCBi
eSB0aGUgdXNlci4NCj4gDQo+IEZvciBleGFtcGxlLCBpZiB0aGUgdXNlciB3YW50cyBjaGFubmVs
cyAxLCA0IGFuZCA1LCBhbGwgY2hhbm5lbHMgZnJvbQ0KPiAwIHRvIDUgd2lsbCBiZSBzY2FubmVk
IGJ1dCBvbmx5IHRoZSBkZXNpcmVkIGNoYW5uZWxzIHdpbGwgYmUgcHVzaGVkIHRvDQo+IHRoZSBJ
SU8gYnVmZmVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5y
YXluYWxAYm9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL21heDEwMjcuYyB8
IDI1ICsrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlv
L2FkYy9tYXgxMDI3LmMgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+IGluZGV4IGI3NTM2
NThiYjQxZS4uOGFiNjYwZjU5NmI1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvbWF4
MTAyNy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMNCj4gQEAgLTM2MCw2ICsz
NjAsOSBAQCBzdGF0aWMgaW50IG1heDEwMjdfc2V0X3RyaWdnZXJfc3RhdGUoc3RydWN0DQo+IGlp
b190cmlnZ2VyICp0cmlnLCBib29sIHN0YXRlKQ0KPiAgCXN0cnVjdCBtYXgxMDI3X3N0YXRlICpz
dCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICAJaW50IHJldDsNCj4gDQo+ICsJaWYgKGJpdG1h
cF9lbXB0eShpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2ssIGluZGlvX2Rldi0NCj4gPm1hc2ts
ZW5ndGgpKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KDQpJJ20gbm90IHN1cmUgdGhpcyBj
YW4gYWN0dWFsbHkgaGFwcGVuLiBJZiB5b3UgdHJ5IHRvIGVuYWJsZSB0aGUgYnVmZmVyDQp3aXRo
IG5vIHNjYW4gZWxlbWVudCwgaXQgc2hvdWxkIGdpdmUgeW91IGFuIGVycm9yIGJlZm9yZSB5b3Ug
cmVhY2gNCnRoaXMgcG9pbnQuLi4NCg0KPiAgCWlmIChzdGF0ZSkgew0KPiAgCQkvKiBTdGFydCBh
Y3F1aXNpdGlvbiBvbiBjbnZzdCAqLw0KPiAgCQlzdC0+cmVnID0gTUFYMTAyN19TRVRVUF9SRUcg
fA0KPiBNQVgxMDI3X0NLU19NT0RFMCB8DQo+IEBAIC0zNjgsOSArMzcxLDEyIEBAIHN0YXRpYyBp
bnQgbWF4MTAyN19zZXRfdHJpZ2dlcl9zdGF0ZShzdHJ1Y3QNCj4gaWlvX3RyaWdnZXIgKnRyaWcs
IGJvb2wgc3RhdGUpDQo+ICAJCWlmIChyZXQgPCAwKQ0KPiAgCQkJcmV0dXJuIHJldDsNCj4gDQo+
IC0JCS8qIFNjYW4gZnJvbSAwIHRvIG1heCAqLw0KPiAtCQlzdC0+cmVnID0gTUFYMTAyN19DT05W
X1JFRyB8IE1BWDEwMjdfQ0hBTigwKSB8DQo+IC0JCQkgIE1BWDEwMjdfU0NBTl9OX00gfCBNQVgx
MDI3X1RFTVA7DQo+ICsJCS8qDQo+ICsJCSAqIFNjYW4gZnJvbSAwIHRvIHRoZSBoaWdoZXN0IHJl
cXVlc3RlZCBjaGFubmVsLiBUaGUNCj4gdGVtcGVyYXR1cmUNCj4gKwkJICogY291bGQgYmUgYXZv
aWRlZCBidXQgaXQgc2ltcGxpZmllcyBhIGJpdCB0aGUgbG9naWMuDQo+ICsJCSAqLw0KPiArCQlz
dC0+cmVnID0gTUFYMTAyN19DT05WX1JFRyB8DQo+IE1BWDEwMjdfU0NBTl8wX04gfCBNQVgxMDI3
X1RFTVA7DQo+ICsJCXN0LT5yZWcgfD0gTUFYMTAyN19DSEFOKGZscygqaW5kaW9fZGV2LQ0KPiA+
YWN0aXZlX3NjYW5fbWFzaykgLSAyKTsNCj4gIAkJcmV0ID0gc3BpX3dyaXRlKHN0LT5zcGksICZz
dC0+cmVnLCAxKTsNCj4gIAkJaWYgKHJldCA8IDApDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiBAQCAt
MzkxLDExICszOTcsMjIgQEAgc3RhdGljIGlycXJldHVybl90DQo+IG1heDEwMjdfdHJpZ2dlcl9o
YW5kbGVyKGludCBpcnEsIHZvaWQgKnByaXZhdGUpDQo+ICAJc3RydWN0IGlpb19wb2xsX2Z1bmMg
KnBmID0gcHJpdmF0ZTsNCj4gIAlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gcGYtPmluZGlv
X2RldjsNCj4gIAlzdHJ1Y3QgbWF4MTAyN19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYp
Ow0KPiArCXVuc2lnbmVkIGludCBzY2FubmVkX2NoYW5zID0gZmxzKCppbmRpb19kZXYtDQo+ID5h
Y3RpdmVfc2Nhbl9tYXNrKTsNCj4gKwl1MTYgKmJ1ZiA9IHN0LT5idWZmZXI7DQoNCkkgdGhpbmsg
c3BhcnNlIHdpbGwgY29tcGxhaW4gaGVyZS4gYnVmZmVyIGlzIGEgX19iZTE2IHJlc3RyaWN0ZWQN
CnR5cGUgc28geW91IHNob3VsZCBub3QgbWl4IHRob3NlLi4uIA0KPiArCXVuc2lnbmVkIGludCBi
aXQ7DQo+IA0KPiAgCXByX2RlYnVnKCIlcyhpcnE9JWQsIHByaXZhdGU9MHglcClcbiIsIF9fZnVu
Y19fLCBpcnEsDQo+IHByaXZhdGUpOw0KPiANCj4gIAkvKiBmaWxsIGJ1ZmZlciB3aXRoIGFsbCBj
aGFubmVsICovDQo+IC0Jc3BpX3JlYWQoc3QtPnNwaSwgc3QtPmJ1ZmZlciwgaW5kaW9fZGV2LT5t
YXNrbGVuZ3RoICogMik7DQo+ICsJc3BpX3JlYWQoc3QtPnNwaSwgc3QtPmJ1ZmZlciwgc2Nhbm5l
ZF9jaGFucyAqIDIpOw0KPiArDQo+ICsJLyogT25seSBrZWVwIHRoZSBjaGFubmVscyBzZWxlY3Rl
ZCBieSB0aGUgdXNlciAqLw0KPiArCWZvcl9lYWNoX3NldF9iaXQoYml0LCBpbmRpb19kZXYtPmFj
dGl2ZV9zY2FuX21hc2ssDQo+ICsJCQkgaW5kaW9fZGV2LT5tYXNrbGVuZ3RoKSB7DQo+ICsJCWlm
IChidWZbMF0gIT0gc3QtPmJ1ZmZlcltiaXRdKQ0KPiArCQkJYnVmWzBdID0gc3QtPmJ1ZmZlclti
aXRdOw0KDQpTaW5jZSB3ZSBhcmUgaGVyZSwgd2hlbiBsb29raW5nIGludG8gdGhlIGRyaXZlciwg
SSByZWFsaXplZA0KdGhhdCBzdC0+YnVmZmVyIGlzIG5vdCBETUEgc2FmZS4gSW4gSUlPLCB3ZSBr
aW5kIG9mIHdhbnQgdG8gZW5mb3JjZQ0KdGhhdCBhbGwgYnVmZmVycyB0aGF0IGFyZSBwYXNzZWQg
dG8gc3BpL2kyYyBidXNlcyBhcmUgc2FmZS4uLiBNYXliZQ0KdGhpcyBpcyBzb21ldGhpbmcgeW91
IGNhbiBpbmNsdWRlIGluIHlvdXIgc2VyaWVzLg0KDQotIE51bm8gU8OhDQoNCiA+ICsJCWJ1Zisr
Ow0KPiArCX0NCj4gDQo+ICAJaWlvX3B1c2hfdG9fYnVmZmVycyhpbmRpb19kZXYsIHN0LT5idWZm
ZXIpOw0KPiANCj4gLS0NCj4gMi4yNy4wDQoNCg==
