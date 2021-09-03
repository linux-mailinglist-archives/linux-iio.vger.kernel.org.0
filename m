Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F3400122
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349252AbhICOVd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 10:21:33 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34338 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232812AbhICOVb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:21:31 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1838x6Ld008649;
        Fri, 3 Sep 2021 10:20:15 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 3augp61dqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 10:20:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gyu6CbCv6nULjFkrTaHLF7JR9OU+aKLntR/drwyVL0OyXuEELIAYgz65tIZq0F7ZngXy056lisRyLQAWugGNiFdA9zHB8abkpRaVa2Qqs4b6+PSsdL0io67v0v8tdRuRNfrFAllOvehfFw6ywFFCp6V9jcIBK6f9u502rub4DeESgAur7QK6Wr5VQKBOsTI87Qan1qyg1O9xpAC9KfGVCK2WhPuLDrKLbK7dhr2NVG4FoTC7nvdMQV5M0XH0+DYy5M/CSSRy2dRJUXFcMuqy5JAjZxmAnYeSE0vyX33pjEXmYVcAFmC+qBV4x7lbD8UM/Ee+zsJMhs0+G/HqVmCuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZS3a4cuixJ5H8TqAoDKd8y13FOVlVeLbJvXbVp1aKK0=;
 b=k6OWn9HbKbU7wbmgfgVDjpFZWYi7X3ewJT4LnArxpHHQwXXLkaWMMpW2b+nye25iYmjzRnX5equngGGT7on9OH61Kpa7k7pU5zQB8ih8nCnzVj+1nn7Wg6VUaMI10qDQSkWSjpxnVVf7x3xtkYQfRe5KV7COrt217Zfp/KEgQNOOGGbj7jwKZd03RoN9UPS8Q+ruoN4IO8fhHw4yBo181zQHdQhqjrulNE1ESJ2q7exCCWiQ4MxZ7p2zn6Mm9SplJa/kcTk27FhufCuF2jc3J5K8UHpkDKeXqEb5uEF+sjVgMOZDhOwi5dd0us+tXC+KKl5dU0WaQ4QUMn9lyVoMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZS3a4cuixJ5H8TqAoDKd8y13FOVlVeLbJvXbVp1aKK0=;
 b=CPS54xlXAFJQhv2pB280qzYJqJ43SVT04wWHu/dMqtQ4aMaB0bXb2hXVTRkZ1aJqrQzrcZ+KNZ01z/BysrtyobbtI/VwdmapmDtTgaIwhXNzal8KPeuIHMDctGiFRI3x/Otef/Nzaklo8NAj3pnuDOdbq0w1kAvyP5MDKfTurIs=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB3445.namprd03.prod.outlook.com (2603:10b6:a02:b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Fri, 3 Sep
 2021 14:20:13 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 3 Sep 2021
 14:20:13 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 15/16] iio: adc: max1027: Support software triggers
Thread-Topic: [PATCH 15/16] iio: adc: max1027: Support software triggers
Thread-Index: AQHXlCHmtYQ56hYJOEuQ9hENpTeKm6t8BnvAgBS8eACAAbJNMA==
Date:   Fri, 3 Sep 2021 14:20:12 +0000
Message-ID: <SJ0PR03MB635941F33691ED40DE2C0F4599CF9@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-16-miquel.raynal@bootlin.com>
        <SJ0PR03MB63594E162F7246874CD1A72599C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
 <20210902142526.55fca207@xps13>
In-Reply-To: <20210902142526.55fca207@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1HSTBZalJtT1RjdE1HTmpNaTB4TVdWakxUaGlPR010WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEQmlOR0kwWmprNUxUQmpZekl0TVRGbFl5MDRZ?=
 =?utf-8?B?amhqTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTkRRNE1T?=
 =?utf-8?B?SWdkRDBpTVRNeU56VXhOVEkwTVRBME56UXhOREV3SWlCb1BTSmtOazloWVVo?=
 =?utf-8?B?SVkySllVVEJ3Vmt4dWIybzNPRGxxUkdGNU0yYzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRnBiM0ZtVG5weFJGaEJZbEpJZEhKeVduaGFNVkowUldVeWRY?=
 =?utf-8?B?UnVSbTVXUlVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVmh0V21kcWQwRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
x-ms-office365-filtering-correlation-id: e2ac2214-9a02-4238-adc3-08d96ee5f1a6
x-ms-traffictypediagnostic: BYAPR03MB3445:
x-microsoft-antispam-prvs: <BYAPR03MB34454E6286194FF4A5CFAFD199CF9@BYAPR03MB3445.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxttenliBPBq2Hh9c1/2fLadqkgzIR2eFKZwrqFgzeo4Y6HW2bZlcnqxUjnlSjnRli5YW9XoTBmg8z/BOxrSXqEec29HXrgswWJLBOI57GHGUjWDdr6pW2eEyxsgMXMxBbO92gQ3vnQZnYNEMyMqmW7dUdH70iVSKYHW9VSTwWpb1c22aSIwTD94OndeUznbqoeKsskuvi90jzyGycmg8uyBi9BKrOZ79HGXM0yQaRhdqwRB6oGfqtyjnKmqLNErxonNdkBsTITqxYT4/LvMVyPNCj1SJVUubRjNVFsbv4cx/55nwbbr9BeRQngAXLoHuM2d7Jx+bDx7/jLsP266y1kwwiPgf1JS8SUVP3Iv2Syx6Ur5YNigg/zDRzo1Bsf1dFuESga5yFKiIqoM9USSuY4XyjuISXH7CAojieYr5zWJlwzgfYPAu8fgnviHkHyy/9vwETr/Fq/mqDlVWg/JI4MU2v4rEAgRge+tWbNEdruECVIJJM8C11p5MEuAwv3uS/J+MbGeumm1XCHR2DXy5qMMCQdNcTJ8YOf7E9qQLN2Y1fRaKJ94wThO4tMJ0toOa5UTuJ449mV2mEAJdW8dag/gGiqIycFNE2Xu2V+JJIfeG7TmgchmRKGLXYWMhT9JoFy9fAqahdIZJya4Z1EOIvxwx1mRMEpeDt2ebgyh6LJEf8eTFWD0gaydk7hFNE6LBvD91/lscf7lvhavt3W4qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(9686003)(64756008)(186003)(66446008)(83380400001)(26005)(4326008)(66476007)(76116006)(478600001)(52536014)(66556008)(33656002)(53546011)(6506007)(66946007)(71200400001)(5660300002)(38100700002)(54906003)(122000001)(316002)(7696005)(86362001)(38070700005)(55016002)(2906002)(8936002)(8676002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTZzK3pzZnAzQ3dXKzlQQURWU2pVTThnWERZRTFiU0xOaDdMZXNWOER6eThZ?=
 =?utf-8?B?VlQzZzdlVUVEaVdUTlBnM016NUpJSjNtdXd0Mzd3WXlxTERMYmQyT29FR3R1?=
 =?utf-8?B?cHFCeWcyWGlHRTBGUHIzVVlSdDUvbkZjTEpSYmttMmtqQVBvWGtuS054eEV4?=
 =?utf-8?B?blgrenJucWcvakZPckhzeWdZQWFubFN1eS84eU5ncDNsK1RJaVB0N2pITE5s?=
 =?utf-8?B?SHYvQjlDVHBwWU52NFFldHJxSi9Za3NLY0pOd1M1T2lXcTBCTWwvb3RTV1pQ?=
 =?utf-8?B?WDJVSEhzdU1yaVdmdzhjWHpSRjBUY2RyLzVsRTNTMno3RjFCWjk1Nk1wUEtq?=
 =?utf-8?B?Ni91U0R0ZFRiVDMxaUd4QVBzRkFiVFdRN3hRRjFVOVpWUnc3TVdjZEZ1QTVI?=
 =?utf-8?B?MGJFeXUweHRseG42OVJ3SmMwc2NDWDBZd05KbldvY3hRSzBHVkR0UkFnaUpE?=
 =?utf-8?B?U3pXR0VpRWdHNjQvYnM1dThVUTlSMmFRbTR0OFg3WllHRzNoTGN4QmdIc1pT?=
 =?utf-8?B?Q0NNUEhnRUUrR01QZmNadUJjZ0ZGL1BUcGw5K3hIOEwzaythSllrUUpFSHdL?=
 =?utf-8?B?V1VYNVNKdU5oS011Rjc2eFVUVXB6ZWlXNWNwbFNvNGkvQWMrR3YzQlI3R3Zj?=
 =?utf-8?B?NmE0SE13ZHlnQzJtcFVRdUtRVWtCcVkvcExkS0VYOWpVYTBuUVZLZThQOGRs?=
 =?utf-8?B?aFlYUEJjSW5UYUFMODJGejgyMEhpQ1YramM1S1NyMmZPZTZBWUZvc2NIOG1a?=
 =?utf-8?B?a1lDMkJCaUF6QmJOTE8xWDV2c2tyMnZVVDJTbTFtUlg5OVhaUHpIWTJtM1JK?=
 =?utf-8?B?OU9Qays3VG94Y3FCOWlJaHNzRDBxYk1adDEwdXRFbmpLdUw4djRyQi90SWFC?=
 =?utf-8?B?QzhBQm1vSHRSUVpmVTU2WkdxQy93OVZEZkZ4TnJFTXBmSkpqTytja25SZ2xl?=
 =?utf-8?B?N1ZOQTJkSlNhaXlqTWFuMGlnZ252cUdEWFZsSDJLbnBoNWpmanJhTUNmaUhj?=
 =?utf-8?B?UkI3MGFoOGVDeEg1U0hjbnVKdEcvWXJzanh5alFOWkozTCtTN001bDNvN3Rx?=
 =?utf-8?B?K1Y1VUp6WHFYTTladm1lVU1iaUk5QVBWUHQ3NzhVVjJqa1ZWNHlYLzA0aitZ?=
 =?utf-8?B?Y2tSRGJ5NUErZHE3QmpSVHcwL0pQbXV5TXNnN2RmK1BxbU9NaUF5TEc0NW53?=
 =?utf-8?B?THYxdFBHQVlNZXFSa2FYUXlSYmJ4aWpCTXlvNUJadmZ0Rk5SWlZkMnVJck5J?=
 =?utf-8?B?b2JHU3lOVTU0MG1ad2dyRXRuc1pRTXhDUUxMS3JvVkpqUktRK2JuU0I1VWJl?=
 =?utf-8?B?bUR0QllUNlB2STJZRE9teitFVmRJeUNHMFZBV0o5cGxuUU9XQjNDSGllSmZP?=
 =?utf-8?B?ZStuU21QQmFCZy9vU1l3YVVVWUlwRTJVcWNUeUxuYXlWa3RjVSthU203eDBW?=
 =?utf-8?B?bDlxU3IyWjR2T1dOZkI4Zmk2ZUkycENlV0RQem5XSGdnSmhpRnlrMUZrYjQ0?=
 =?utf-8?B?SjQxUk1BQVFraVBRKzIyOEpjZU9Ta0NCUU1NMGg3cHNzNmpnaVZadkx3Z0xM?=
 =?utf-8?B?TWhmMTV3ZzlkQ2tnZ1J5bjEvUWt2Zk5QVUxjN3RSUTJIbForUWlhbG1kbnZU?=
 =?utf-8?B?MnFhejN3WXRnZUV0NEZyZE9BTnIwb1pvSDdRSjNlVUg5L0xHTGNLTjU1citk?=
 =?utf-8?B?ekVTQXRLZjZscVJGK0dseHQwdk1PelFyeVE5N1lzWVBubHQ1WFB6RmYwSHNL?=
 =?utf-8?Q?mqAcxlxcDYwnQXTCZzBhVmN/m80DR73fAEWp7/T?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ac2214-9a02-4238-adc3-08d96ee5f1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 14:20:12.8572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeLpNxE6c+Jk7M4FlHiTcGOCFIPaCW83DlsFr3q8nIwC4B2+6mgsPf1DEUwJiyeG8o86FPh//8cyHR8K29Qvrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3445
X-Proofpoint-GUID: 5uF-y95to2zYU8-KwS9ihTQiCidWnWOy
X-Proofpoint-ORIG-GUID: 5uF-y95to2zYU8-KwS9ihTQiCidWnWOy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_05,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030089
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAy
LCAyMDIxIDI6MjUgUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENj
OiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgTGFycy1QZXRlciBDbGF1c2Vu
DQo+IDxsYXJzQG1ldGFmb28uZGU+OyBUaG9tYXMgUGV0YXp6b25pDQo+IDx0aG9tYXMucGV0YXp6
b25pQGJvb3RsaW4uY29tPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxNS8xNl0gaWlvOiBh
ZGM6IG1heDEwMjc6IFN1cHBvcnQgc29mdHdhcmUNCj4gdHJpZ2dlcnMNCj4gDQo+IFtFeHRlcm5h
bF0NCj4gDQo+IEhpIE51bm8sDQo+IA0KPiAiU2EsIE51bm8iIDxOdW5vLlNhQGFuYWxvZy5jb20+
IHdyb3RlIG9uIEZyaSwgMjAgQXVnIDIwMjEgMDc6NTg6MjUNCj4gKzAwMDA6DQo+IA0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1pcXVlbCBSYXluYWwgPG1p
cXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAx
OCwgMjAyMSAxOjEyIFBNDQo+ID4gPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVs
Lm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA+ID4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiA+
IENjOiBUaG9tYXMgUGV0YXp6b25pIDx0aG9tYXMucGV0YXp6b25pQGJvb3RsaW4uY29tPjsgbGlu
dXgtDQo+ID4gPiBpaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBNaXF1ZWwgUmF5bmFsDQo+ID4gPiA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4g
PiA+IFN1YmplY3Q6IFtQQVRDSCAxNS8xNl0gaWlvOiBhZGM6IG1heDEwMjc6IFN1cHBvcnQgc29m
dHdhcmUgdHJpZ2dlcnMNCj4gPiA+DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPg0KPiA+ID4gTm93
IHRoYXQgbWF4MTAyN190cmlnZ2VyX2hhbmRsZXIoKSBoYXMgYmVlbiBmcmVlZCBmcm9tDQo+IGhh
bmRsaW5nDQo+ID4gPiBoYXJkd2FyZQ0KPiA+ID4gdHJpZ2dlcnMgRU9DIHNpdHVhdGlvbnMsIHdl
IGNhbiB1c2UgaXQgZm9yIHdoYXQgaXQgaGFzIGJlZW4gZGVzaWduZWQNCj4gaW4NCj4gPiA+IHRo
ZSBmaXJzdCBwbGFjZTogdHJpZ2dlciBzb2Z0d2FyZSBvcmlnaW5hdGVkIGNvbnZlcnNpb25zLiBJ
biBvdGhlcg0KPiA+ID4gd29yZHMsIHdoZW4gdXNlcnNwYWNlIGluaXRpYXRlcyBhIGNvbnZlcnNp
b24gd2l0aCBhIHN5c2ZzIHRyaWdnZXIgb3INCj4gYQ0KPiA+ID4gaHJ0aW1lciB0cmlnZ2VyLCB3
ZSBtdXN0IGRvIGFsbCBjb25maWd1cmF0aW9uIHN0ZXBzLCBpZToNCj4gPiA+IDEtIENvbmZpZ3Vy
aW5nIHRoZSB0cmlnZ2VyDQo+ID4gPiAyLSBDb25maWd1cmluZyB0aGUgY2hhbm5lbHMgdG8gc2Nh
bg0KPiA+ID4gMy0gU3RhcnRpbmcgdGhlIGNvbnZlcnNpb24gKGFjdHVhbGx5IGRvbmUgYXV0b21h
dGljYWxseSBieSBzdGVwIDIgaW4NCj4gPiA+ICAgIHRoaXMgY2FzZSkNCj4gPiA+IDQtIFdhaXRp
bmcgZm9yIHRoZSBjb252ZXJzaW9uIHRvIGVuZA0KPiA+ID4gNS0gUmV0cmlldmluZyB0aGUgZGF0
YSBmcm9tIHRoZSBBREMNCj4gPiA+IDYtIFB1c2ggdGhlIGRhdGEgdG8gdGhlIElJTyBjb3JlIGFu
ZCBub3RpZnkgaXQNCj4gPiA+DQo+ID4gPiBBZGQgdGhlIG1pc3Npbmcgc3RlcHMgdG8gdGhpcyBo
ZWxwZXIgYW5kIGRyb3AgdGhlIHRyaWdnZXINCj4gdmVyaWZpY2F0aW9uDQo+ID4gPiBob29rIG90
aGVyd2lzZSBzb2Z0d2FyZSB0cmlnZ2VycyB3b3VsZCBzaW1wbHkgbm90IGJlIGFjY2VwdGVkIGF0
DQo+IGFsbC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9paW8vYWRj
L21heDEwMjcuYyB8IDI2ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jIGIvZHJpdmVycy9paW8vYWRj
L21heDEwMjcuYw0KPiA+ID4gaW5kZXggOGM1OTk1YWU1OWYyLi5iYjQzN2U0M2FkYWYgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+ID4gPiArKysgYi9kcml2
ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+ID4gPiBAQCAtNDEzLDE3ICs0MTMsNiBAQCBzdGF0aWMg
aW50DQo+IG1heDEwMjdfZGVidWdmc19yZWdfYWNjZXNzKHN0cnVjdA0KPiA+ID4gaWlvX2RldiAq
aW5kaW9fZGV2LA0KPiA+ID4gIAlyZXR1cm4gc3BpX3dyaXRlKHN0LT5zcGksIHZhbCwgMSk7DQo+
ID4gPiAgfQ0KPiA+ID4NCj4gPiA+IC1zdGF0aWMgaW50IG1heDEwMjdfdmFsaWRhdGVfdHJpZ2dl
cihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiA+ID4gLQkJCQkgICAgc3RydWN0IGlpb190
cmlnZ2VyICp0cmlnKQ0KPiA+ID4gLXsNCj4gPiA+IC0Jc3RydWN0IG1heDEwMjdfc3RhdGUgKnN0
ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiA+IC0NCj4gPiA+IC0JaWYgKHN0LT50cmlnICE9
IHRyaWcpDQo+ID4gPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+IC0NCj4gPiA+IC0JcmV0dXJu
IDA7DQo+ID4gPiAtfQ0KPiA+ID4gLQ0KPiA+ID4gIHN0YXRpYyBpbnQgbWF4MTAyN19zZXRfY252
c3RfdHJpZ2dlcl9zdGF0ZShzdHJ1Y3QgaWlvX3RyaWdnZXIgKnRyaWcsDQo+ID4gPiBib29sIHN0
YXRlKQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IGlpb190
cmlnZ2VyX2dldF9kcnZkYXRhKHRyaWcpOw0KPiA+ID4gQEAgLTUxMiw3ICs1MDEsMjEgQEAgc3Rh
dGljIGlycXJldHVybl90DQo+IG1heDEwMjdfdHJpZ2dlcl9oYW5kbGVyKGludA0KPiA+ID4gaXJx
LCB2b2lkICpwcml2YXRlKQ0KPiA+ID4NCj4gPiA+ICAJcHJfZGVidWcoIiVzKGlycT0lZCwgcHJp
dmF0ZT0weCVwKVxuIiwgX19mdW5jX18sIGlycSwNCj4gPiA+IHByaXZhdGUpOw0KPiA+ID4NCj4g
PiA+ICsJcmV0ID0gbWF4MTAyN19jb25maWd1cmVfdHJpZ2dlcihpbmRpb19kZXYpOw0KPiA+ID4g
KwlpZiAocmV0KQ0KPiA+ID4gKwkJZ290byBvdXQ7DQo+ID4gPiArDQo+ID4gPiArCXJldCA9IG1h
eDEwMjdfY29uZmlndXJlX2NoYW5zX3RvX3NjYW4oaW5kaW9fZGV2KTsNCj4gPiA+ICsJaWYgKHJl
dCkNCj4gPiA+ICsJCWdvdG8gb3V0Ow0KPiA+ID4gKw0KPiA+ID4gKwlyZXQgPSBtYXgxMDI3X3dh
aXRfZW9jKGluZGlvX2Rldik7DQo+ID4gPiArCWlmIChyZXQpDQo+ID4gPiArCQlnb3RvIG91dDsN
Cj4gPiA+ICsNCj4gPiA+ICAJcmV0ID0gbWF4MTAyN19yZWFkX3NjYW4oaW5kaW9fZGV2KTsNCj4g
Pg0KPiA+IFRoZXJlJ3Mgc29tZXRoaW5nIHRoYXQgSSdtIG5vdCBnZXR0aW5nLi4uIEhvdyBhcmUg
d2UgY2hlY2tpbmcgdGhhdA0KPiA+IHdlIGhhdmUgc29mdHdhcmUgdHJpZ2dlcnM/IFRoaXMgQVBJ
IGlzIGNhbGxlZCBvbmx5IGlmIHRoZSBkZXZpY2UNCj4gPiBhbGxvY2F0ZXMgaXQncyBvd24gdHJp
Z2dlciB3aGljaCB3aWxsIGhhcHBlbiBpZiB0aGVyZSdzIGEgc3BpIElSUS4NCj4gPg0KPiA+IEkn
bSBwcm9iYWJseSBtaXNzaW5nIHNvbWV0aGluZyBhcyB0aGlzIHNlcmllcyBpcyBmYWlybHkgYmln
IGJ1dCB0aGUgd2F5DQo+ID4gSSB3b3VsZCBkbyBpdCBpcyAoaW4gdGhlIHByb2JlKToNCj4gPg0K
PiA+IC0gYWx3YXlzIGNhbGwgJ2Rldm1faWlvX3RyaWdnZXJlZF9idWZmZXJfc2V0dXAoKScgZnVu
Y3Rpb24gYW5kDQo+IHByb3Blcmx5IHVzZQ0KPiA+IGJ1ZmZlciBvcHMgWzFdIChmb3IgZXhhbXBs
ZSwgeW91IGNhbiB1c2UgJ3ZhbGlkYXRlX3NjYW5fbWFzaygpJyB0bw0KPiBzZXR1cCB0aGUNCj4g
PiBjaGFubmVscyB0byByZWFkKTsNCj4gPiAtIG9ubHkgYWxsb2NhdGUgYSB0cmlnZ2VyIGlmIGFu
IElSUSBpcyBwcmVzZW50IGluIHdoaWNoIGNhc2UsIHdlIGFzc3VtZQ0KPiBIVw0KPiA+IHRyaWdn
ZXJpbmcgaXMgc3VwcG9ydGVkLg0KPiANCj4gSSB0aGluayB0aGVzZSBhcmUgdGhlIGV4YWN0IHN0
ZXBzIHRoYXQgYXJlIGVuZm9yY2VkIGluIHRoZSBuZXh0IHBhdGNoLA0KPiBJIGNhbiBzcXVhc2gg
dGhlbSBpZiB5b3Ugd2lzaCBidXQgSSB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBoYXZlIGl0IGlu
DQo+IHR3byBzdGVwcy4NCj4gDQoNClllYWgsIG15IGJhZCBoZXJlLi4uDQoNCi0gTnVubyBTw6EN
Cg==
