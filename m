Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6497A3603C9
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhDOH7P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 03:59:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:24124 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhDOH7O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 03:59:14 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F7uor0024157;
        Thu, 15 Apr 2021 03:58:39 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 37xg85g6fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 03:58:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzXAlnRoYPEo/aFPHmASKvs93nwZ1NhAL8KtU5gcqvV+7D+fgYYvZq2Bcp7zUOsm4+6JZ9szz5aozzzn40W4N5ufXt/2bn/10k2d34F7jdYU7YL298NDHkUJ72MyQRSjpDursyviKdqY66bK6JJbFDD4Q9vzxx7xU2Z9MP9MWmvCAmvRRYACzBy39dm/LEUnMOo0fx2NdI3aENADkfl9gQ1DQT5LJO7yF5U3+w52N6NiVvvlInnJMVC4QQsbZ0gLP/LT50PQVdodIBArGCg1YdKAkGwBuZ+ASLGneAbCeEpVKCQiV0bulTUfh7VkqB3gTJ/4D0nalv9t5XDqfsv6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbI2xLU/QZ5t+uvZu+gR1grFgpRP3gcWLWDS5NCpNY0=;
 b=EIhc3cxUckmzCBCBxtFPMjP8FNP8Oxrifxk3o21ETBYVOP45yhTLnh+nxV51R/n2M29DLsE5EdIULTagAw7I9k+aS7a5yJBfoC87l/EUT4+6jNUkqHzRWJ4rF3MAKH8kLI01zUJdthVSWd/60vEe2ZoQ0nyC3CAB3zLMWa8tp5jjoymejP8VawbHFjaHlhHvQgX4KY4/z08OnKBLOrib1jAjRAWD0ivNFM55yWe03awUs1/b3ZO5Qs0hRvnlizrYP93gzRFohQdWHxrdDyDdGnZxHb+aRze7sh31NSSqThlRAobTZtphn7XB0f0Y0b/GKZWKrhCachyYiN3oviX64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbI2xLU/QZ5t+uvZu+gR1grFgpRP3gcWLWDS5NCpNY0=;
 b=wlSfcLvOVxopBMpoV9or6eeQzRwIlV8mbG0VfXSQ16lHDxxdXLCofFtoTGUKP0eh3ZHj13T73g+6mHEIMedNktX+HOhNvNk0vYi4LAv6ChPJjl9LJcDOFgjl/G/IoafFw3dQnCh7FHZXyX4MuPYIVXlKY86LpXC1xC+ye3qvyuk=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY1PR03MB2251.namprd03.prod.outlook.com (2a01:111:e400:c616::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 07:58:37 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4020.022; Thu, 15 Apr 2021
 07:58:36 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH 7/7] iio: adis_buffer: update device page after changing
 it
Thread-Topic: [PATCH 7/7] iio: adis_buffer: update device page after changing
 it
Thread-Index: AQHXMFb1KVJbnmdA1USetDauEnRSx6qzobyAgAGXVfA=
Date:   Thu, 15 Apr 2021 07:58:36 +0000
Message-ID: <CY4PR03MB311236A292933D2C89CB9B53994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
 <20210413112105.69458-8-nuno.sa@analog.com>
 <CA+U=DsrBUFcwkO900StwY8-8W9fn3z+LZOaJ7YR=9qBQsFi_2w@mail.gmail.com>
In-Reply-To: <CA+U=DsrBUFcwkO900StwY8-8W9fn3z+LZOaJ7YR=9qBQsFi_2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5qQTFObVpsTlRRdE9XUmpNQzB4TVdWaUxUaGlNMkV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEWXdOVFptWlRVMkxUbGtZekF0TVRGbFlpMDRZ?=
 =?utf-8?B?ak5oTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRnM05T?=
 =?utf-8?B?SWdkRDBpTVRNeU5qSTVORGN4TVRVd056QTJPVGt3SWlCb1BTSmphV1kzTDNN?=
 =?utf-8?B?NWRrdGxTbmxGTkdaNlNqaFdiazgxTXpSVlUwVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRjFhMkU0YVhwVVNGaEJWMm8yYTA5bFNGQkxXazloVUhGUk5U?=
 =?utf-8?B?UmpPSEJyTkVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a70eb98e-f9c2-409d-0780-08d8ffe44649
x-ms-traffictypediagnostic: CY1PR03MB2251:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR03MB2251CEC10F6637B0C2D87D74994D9@CY1PR03MB2251.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JXZZXj1lc1j/ZzgDt7er/Y+NfqKCKFaEKmqrMhDTg1SR2ubW4Kjz1Gmp+NfQvWeL0+zu/bNuXUTGvliFntv9lgnY8N7gkxbM4fCBV9/We70XJaCERCVTp8ETWngxN2exqnPNFmDFhFR/8ar7zjCGx0TjmuGEDa9NMMj0X+lblY4FAzpwgSh9utytnkQS4mTMEK6Uno92eA6oeFai6WlWWp9ahLPF2M3ZDEs+UGDmFbQSjpUvmpnd4rks5+1WicIBXUAEBpV/9N4gcjgGvA4onXtr4htJk3tA6PfTxc3BRDrv3pJfAIghq8gngVyfxSAwKVvnQgU6OZc5hx2hD2SvjbUaK7KBzFUTdWxqHXSFqbQS/IS8w2QJu+DGSv/Pnnhn/ECKVI7Mq4FsLKrh7tlomyLkiWjfVGY55j3+1jr0ouNfP6vCmlUJ6A4z3zfad/aADYyn9RLH/WBNLJ2ahpqhk2voRw4Iw1+Co+TbnX9U/RukQlbUfbvmqxtRXKGKCIyfKi6Y3u/eMQ3IiYwLXdVV+Z07uS81Nj8IOjIR7HzpdB3XRbOIWUw2NycroiNvJwbMOGoBIkw1AOceg3AxKYzrzD8PXlOQdyCpdeLXa1Fv9Ys=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(316002)(4326008)(122000001)(9686003)(54906003)(186003)(15650500001)(8936002)(478600001)(8676002)(38100700002)(55016002)(83380400001)(2906002)(26005)(71200400001)(64756008)(6916009)(7696005)(33656002)(76116006)(66476007)(66946007)(66446008)(86362001)(53546011)(66556008)(5660300002)(52536014)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MWhzckhIUTJQMU9TdUlzbDVVSjRTdm5ZcXViZDBmZHFpTjR1SDBaOENock80?=
 =?utf-8?B?WFJrb09SUGExREJneVpUYmhSRGtxQlpjSS9ZbXczRzFxTHBDcFU2NitUQ2lv?=
 =?utf-8?B?N25BYzJaNDl4Sk9icUphUU0yK3l1SXA5azFOY3Y4NlFsc2ZBL3JCbnBqeFZQ?=
 =?utf-8?B?V1RGOUFabjhCTkZWVkVnd3V5TjF3bUpwZC9vYmFXMDdvdGhhWWhtaitQLytr?=
 =?utf-8?B?MUxVWWlIa1pTbjZhNEQzLzhGZmo4RTVnOVNYd0hNQWNLTWFldVAzRm5zY3Zz?=
 =?utf-8?B?K1ZRWDZ2bE5kN09PQjh4Q1ByNWZibkJtOTFPNXprVjdXRWlTYnJmUC9JOU9Z?=
 =?utf-8?B?RXEwRDNqWlVKNHNocGRaRmlySW5Zek40NHJmSjBvUUIrQXo0amRhUFgzaTA5?=
 =?utf-8?B?c2kwYWc2WE1UVG9sNy9ycnBkZEZBMXRNeHh3TDBYQVVEVHVMSkREcWkvbWJL?=
 =?utf-8?B?SkJGZHhveXB5M0Fxdjk0byt3eXZOYXZPeENET0p3UXFiOWlUWlg3YmhTRDJm?=
 =?utf-8?B?NTBkbnBGSUhRWGl3WG1UWVdiM0JMQmJkQk5qam4rbm5jTEZBdU4rOGxNd2dv?=
 =?utf-8?B?QmpmTXFKS1o3djdhUmZNRHNvcjl0VnRycitUZkZmRzBxZjgvaHRDWmU2QkNZ?=
 =?utf-8?B?VlFoU2szdHRGbVZQV2x2QXJBbGdBYWNEajg1SGxpR0k5L3dHTjlENzU0alZt?=
 =?utf-8?B?aG5FS1cwL2RLNVh0RXBkTFRVTWlOZDdsdWpTdGlyQlpIRDF2V3o0YzhVZWJh?=
 =?utf-8?B?V1BlcTVXTWI0NGRuMXlrL0k5WE9wdjdnNUNZSHdWMURWTUhWd085RnhVODZK?=
 =?utf-8?B?d0dJWGRnaFlVOGZyOENiZTJFYm83azRraVMxNU52c2ZKbllpbCtIR0xBblRV?=
 =?utf-8?B?Zko0cTY5OHIwS1loTVdPRC9SQ0k0dldTbEF2T3I0MG1CUzBlbEJHb0VHczVp?=
 =?utf-8?B?cGRMQ1N3Y1FIemZidEJnTG1OOTBQMThCNnczaXVoU29EL2hBdlp0VGZXL0ox?=
 =?utf-8?B?QTJJYmNWZkUxZVhEdFloaFIwamU5UEo2QzgyKzZKSXZKRnM1N01Vb1lRS1JX?=
 =?utf-8?B?cVFzRGczUnJMTzhDV2xYODh4MkhDUGJjSEttOWxIbmRPSjE3VlRBb05NalBu?=
 =?utf-8?B?WW9maUx2eGJJSDIvSkVSWEVxVm9SQWdZbUpHZTdObjc2RXBYeDdFeXdJTTJO?=
 =?utf-8?B?RC9JL25FWnRpaVJ1MFlNTmZUUlVaTFFpMmNXV2NuVlJZZ3k3MkhrMmQzOSt2?=
 =?utf-8?B?RWRWU0owRXJkL1JJdWhaYTQxdzQwZ1I5V3lTSHMzeGRKS0lMTkwwOWowSERS?=
 =?utf-8?B?V3M2NzZLdGhxVCt5RG9EbjROd1VrbTdONHRVLzJmUGVLYno1MmtJLzFYd3lO?=
 =?utf-8?B?SXBpRy9CcUVaR2ZSYnJ1eVpXSWVzS0FDcTdDSThYYlBNNHE5MWN6NnNGUzNT?=
 =?utf-8?B?MkJUdTZYQjdtQVNIb1VpSXVFRHJzbmEzNDMxbFdocnNxL1ZxQ0RmMmhBL2dL?=
 =?utf-8?B?dUh2T2tUVVdLZWlrb2MyaEFPWjZsWmNKTk5XdGlESUtwUDErY0VaSE8wS1Jh?=
 =?utf-8?B?VlZJU3lBTFBEYnJyTmN6dW1id3J4NU9EQVBzVDc2Q01ERzFUdUwxWjZCdmsw?=
 =?utf-8?B?cDVUeEZnV24xVml0YXZvZjBQajNnbVRWblVYTFM1ZlBkV1ZNSzZrRXRJeEtF?=
 =?utf-8?B?QU9nU0Mvb2xPbHdGN1hJN1hnMkJGZlpiQmc3RURHb1J4RTBKSWZEZTZGb3RZ?=
 =?utf-8?Q?CjPoM1czZnex2L40EoLbQVgx0YVV+Qk47IFiXic?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70eb98e-f9c2-409d-0780-08d8ffe44649
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 07:58:36.8639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CI33FypMfNKdBhlrhL+ox9keAWlPOd1/XaXzof0A+N0vcSYh1Oa+ue3mpUFdiibKwk7RTCn5fWmC0Dvp2rnxZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2251
X-Proofpoint-GUID: GRjE6T4GDYy2NW-kQV9jD3h76Pukzker
X-Proofpoint-ORIG-GUID: GRjE6T4GDYy2NW-kQV9jD3h76Pukzker
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhcmRlbGVhbmFsZXhAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE0
LCAyMDIxIDk6MzkgQU0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENj
OiBsaW51eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1lcm9u
DQo+IDxqaWMyM0BrZXJuZWwub3JnPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhl
bm5lcmljaEBhbmFsb2cuY29tPjsgTGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28u
ZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNy83XSBpaW86IGFkaXNfYnVmZmVyOiB1cGRhdGUg
ZGV2aWNlIHBhZ2UgYWZ0ZXINCj4gY2hhbmdpbmcgaXQNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+
IE9uIFR1ZSwgQXByIDEzLCAyMDIxIGF0IDU6NDUgUE0gTnVubyBTYSA8bnVuby5zYUBhbmFsb2cu
Y29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFdpdGggY29tbWl0IDQxZjI3NzBhMDdlMCAoImlpbzog
YWRpc19idWZmZXI6IGRvbid0IHB1c2ggZGF0YSB0bw0KPiBidWZmZXJzIG9uDQo+ID4gZmFpbHVy
ZSIpLCB3ZSByZXR1cm4gaWYgJ3NwaV9zeW5jKCknIGZhaWxzIHdoaWNoIHdvdWxkIGxlYXZlDQo+
ID4gJ2FkaXMtPmN1cnJlbnRfcGFnZScgaW4gYW4gaW5jb2hlcmVudCBzdGF0ZS4gSGVuY2UsIHNl
dCB0aGlzIHZhcmlhYmxlDQo+ID4gcmlnaHQgYWZ0ZXIgd2UgY2hhbmdlIHRoZSBkZXZpY2UgcGFn
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vaW11L2FkaXNfYnVmZmVyLmMgfCA2ICsrKy0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1ZmZlci5jDQo+IGIvZHJp
dmVycy9paW8vaW11L2FkaXNfYnVmZmVyLmMNCj4gPiBpbmRleCA3Mzc5MGI3MTEwMmIuLmFhMzc5
ODFjMjhmMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1ZmZlci5jDQo+ID4gQEAgLTE0Miw2ICsx
NDIsOCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYWRpc190cmlnZ2VyX2hhbmRsZXIoaW50IGlycSwN
Cj4gdm9pZCAqcCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIo
JmFkaXMtPnNwaS0+ZGV2LCAiRmFpbGVkIHRvIGNoYW5nZSBkZXZpY2UNCj4gcGFnZTogJWRcbiIs
IHJldCk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGlycV9kb25l
Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgYWRpcy0+Y3VycmVudF9wYWdlID0gMDsNCj4gDQo+IElmIHRoZSBhYm92ZSBz
cGlfd3JpdGUoKSBmYWlscywgdGhpcyBhZGlzLT5jdXJyZW50X3BhZ2UgaXNuJ3QgcmVzZXQuDQo+
IE1heWJlIHJlc2V0IHRoaXMgYXMgdGhlIGZpcnN0IHRoaW5nIGluIHRoaXMgaWYgYmxvY2s/DQo+
IA0KDQpJZiB0aGUgJ3NwaV93cml0ZSgpJyBmYWlscyBpdCBtZWFucyB0aGF0IHdlIGNvdWxkIG5v
dCBjaGFuZ2UgdG8gcGFnZTAsDQpzbyB3ZSBzaG91bGQgbm90IHVwZGF0ZSB0aGUgY3VycmVudF9w
YWdlLi4uDQo=
