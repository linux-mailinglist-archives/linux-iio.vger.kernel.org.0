Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC753EB3CC
	for <lists+linux-iio@lfdr.de>; Fri, 13 Aug 2021 12:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbhHMKGB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Aug 2021 06:06:01 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44988 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239804AbhHMKF7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Aug 2021 06:05:59 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D9trLa008523;
        Fri, 13 Aug 2021 06:05:19 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 3acw1qn6cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 06:05:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY3B6CKx1NueCsK3ZnQwHQgO5LzAZYOinOhITZVC72GCI2k54FucPwbzY7knoztDaZf0SIxD/b2lNMXZ69l3OdUiG4s242hjhOLyNOc1dkLsJrY6eUL2poFe/95qLUPqSkTXZYnzc8XvRFd6iMO0rFKv7m/HAnE6BdkMcXqgf0MUQaz7YVpwkHTWQc8bx9cFwHcWAs0rUky5ZdDFADqdFK4JnZbQPM7UZX80910xTGXyTR1QvUsGp+MClkQHVALIJKwLx7ecrdwqGppOuEsjIRgNnQn4QfXlszWzYltD0rSjOBdxYDAlOp5fstdXhn3MbXEHmlAuI5Q/AcGO/Btq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+sS1oPdX4NodkAI9/6MjV+5yfiBXAERpw/PWMw/FnU=;
 b=nIFRUC4ZcczJeG1xrDt/tFFGHvcmmcEb00+2g3VR2SCX6nx6yZQsDYCIqQoY+BMTdhw+h53L8rJ/vc4clIli3/Q3AB/zUpUTXv3iGdE/Pv0eO1/VdzdhcXo+TBkXsDkPFf/w55TP1CxgLrkib3RkptdnxvQ9ShvpkgJOGR31G8fp31a7t5fo9b7zLN7RorftuqUF5/dMPTMhkSw5eYlf/trC0tf2DQ8ct0W/mLOM4IoxYivO01UpnefMqPVkWQ3C69RCARocm7r0HbA/7B068FTPTLYQOObSpGv+AWeD+wbl5mD8tUht6r5yEo4tvUKa1626HBTMi8I8YbyLE8oLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+sS1oPdX4NodkAI9/6MjV+5yfiBXAERpw/PWMw/FnU=;
 b=GwzuFEiLJWPssRGSs9RdK8yCAMfqVEh5XU87pZLofS3OzvH2B6RAsl7BX8pNffFxTHa2CPtKwDG6M0aIqNbXpPNY+VUmFIhUY23Bu/+sP72osBnVVRMfZk7BsTHHIdyaComSzKlF33rEsUf1pbix7xYaDIaE/JiB3ToBTFBdUJk=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5861.namprd03.prod.outlook.com (2603:10b6:510:3a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 10:05:17 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 10:05:17 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: ad5770r: make devicetree property reading consistent
Thread-Topic: [PATCH] iio: ad5770r: make devicetree property reading
 consistent
Thread-Index: AQHXjoTpWS49/XePMUytpStcxW5zfKtud/2AgAD4urCAAANBAIAAEoswgAB044CAAQ8qwIAADCQAgAAhX3A=
Date:   Fri, 13 Aug 2021 10:05:17 +0000
Message-ID: <PH0PR03MB63665918437E96CAF35B7CD799FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210811074827.21889-1-nuno.sa@analog.com>
 <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
 <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com>
 <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com>
 <PH0PR03MB63662507607DD7E06995B7EE99FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75Ve=C62FmC20qkLsMVFkc-rbhHqmY2StDtrYqG0=mjtcTw@mail.gmail.com>
In-Reply-To: <CAHp75Ve=C62FmC20qkLsMVFkc-rbhHqmY2StDtrYqG0=mjtcTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpqUXlZVGMxTVdFdFptTXhaQzB4TVdWaUxUaGlPRFV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHWTBNbUUzTlRGakxXWmpNV1F0TVRGbFlpMDRZ?=
 =?utf-8?B?amcxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpJNU1p?=
 =?utf-8?B?SWdkRDBpTVRNeU56TXpNakkzTVRVMU9URTROekF5SWlCb1BTSjBVbkp5TlRk?=
 =?utf-8?B?NVRYVkJOa0ZwTlc1c1VHNXBXVzFzUkVoa1pWRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVSjFSRFJYTWt0d1JGaEJVMFJJSzJWWVUxbDZReXRKVFdZMU5X?=
 =?utf-8?B?UkthazFNTkVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7710ae3-7b1a-43de-678b-08d95e41da42
x-ms-traffictypediagnostic: PH0PR03MB5861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB5861459EF067A28B5F81CD8899FA9@PH0PR03MB5861.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yXaKCA0383/O3CrLGrGYwb1AWHd0JOZ1Qa91aDzCDsQETwE5d5MoxltP3fkn3jVciuPluP6PJxwD2MBe6omMoY78z6TwjnxStreklUC2Ykkc45OaMsFeL/E4Y/UJ7RBMmR2XBq4E5KahCgdW1ADQBKEV6Rwtde10li/d68ntD4BYtjo4oyXQ5uKrct/90b0+q+XuGnaqYH/CMoHOYyk8fmz7MIWADu6FiKtmFlx6E45hB2pylB6owwLYwd75C7zIwk+kVsVIDq/lxeq3QNzYRDbZ8hI5TU8swkLv6yOmMAqWSSDPztnRUA7/T6QOsGlyN3ryHAcBSHBlE8OR7dr+Wg6UAStU6hvMZLD6k+eOEUY2gtk2lwQltsAEs4GYFc0nGBJTxfL6XbJgaCvO3tgnE5jN8t4ITcTc4v0okhrIfZTVozov0g75MwGrkb2M/EDdU4c5a3BpOmILaE7ar88uwcmnPf1XEByQJmcp0hG6w4B64Tr9XRfwwsjKzdiE9zJyWRT5aJRiuun3GFyfSVuQl9Ikx5CJgSLJUrO3C6pN0PzRVY8PODsWhBc4/eioHyZTlA4p8OlTEQx/Wx3O15fcZub50aSnGLj5/O9XtcuLdOB7AEobs/3ZKSCNMB/qsi3V1FjoJpbT8sqRyjpR5Fs1OZQB2jcbPB0q3vNtaJ7igv41J1uJHSZI8VmcfEjwrVrOAaJ1mY6eHGKsN2Sev8tzfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(55016002)(8676002)(9686003)(2906002)(83380400001)(4326008)(508600001)(8936002)(38070700005)(66476007)(6916009)(66946007)(76116006)(316002)(66446008)(66556008)(5660300002)(52536014)(33656002)(122000001)(38100700002)(64756008)(54906003)(7696005)(6506007)(53546011)(71200400001)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGVlbnVrVnM1OHZFZnZUK2RhWmt0TEpldXQ0MmtnVU5zVC9rSkpwRmtqbWtK?=
 =?utf-8?B?R24vZHhQUmx2dlJNQVZSS0twV2tCaVE0YWtpZnFCTzYxZmV3d0NWQVhWK3pE?=
 =?utf-8?B?b1dzcXBIbHBZbUt1OUQvL1duQS9ERmtacXpMWENGdm92VGExMXJYc2NSd2dn?=
 =?utf-8?B?Tm5KSmhqZnVqbjFuT0RxcmVaUTA1WXNRUkNvRjlkVGZpeHlTV3dSU09pNjBu?=
 =?utf-8?B?SksvL1FSeUJ5VWtITDR6dDAwbVZCUlppRHZybm4wQkF0RDhhV0J1cGM5elRs?=
 =?utf-8?B?cmtLUExQVTlCTXJmOHd0TmJkM1paZk4zRk9TbkVBc2Z6N0ZvdUtva3ZGeS9o?=
 =?utf-8?B?akhPaDU3RExXRGtYckN0UktNRmZrTk9LbmhHbi9vbGVGNVpENWV4VDhZZmpL?=
 =?utf-8?B?SHBSSUZHelNOOWdNOCtLcnlScENSUHZpSFpHRWhXY0x4MlB5aG1sNDg1MURu?=
 =?utf-8?B?VXhHQTJRK2pOd1FSbmF6MTlaVlhVUVYzWGVvMXpGVFVudTN3eUM4NkZKbWpl?=
 =?utf-8?B?OHY5U2hsNDNiajZvTnRsbkEzc3RxSkcwT0JhbnBuRjJGMjU5NjBIOXcxczdr?=
 =?utf-8?B?VEM4NGdKNjMxaHhaK1cxUUFxeHdIT3hRT2IzVnJGbnRidG5iaGxIWGF4dlRG?=
 =?utf-8?B?d3NWTzNJczFaL2tlZW5NM1Fxa0xCbk1xMGM4cGZFSEZvYkYwbjZpZzdkS2tn?=
 =?utf-8?B?ZkFnRG9zSDBqVUxqTVlUYXRMQnM3QWIxaG1EOEtCaE1yUmMwS05WTVVBNG9z?=
 =?utf-8?B?OHMrTXBQTUJ1SEFPcG9Bb2RjZUJ0bVk1cjdJK0didFpkY0FFSElEZHN0eUtM?=
 =?utf-8?B?bWx2RGwwM2Q4aFRabDE4bitQKzl3RHlwTThnNEhYcjhqb3R5SlE1U2orVWpT?=
 =?utf-8?B?aE0rcUhPK3JubURvKzJRc3grZGN0WVRheUZtZzFldCtoWHFYSldJRUUrWjJV?=
 =?utf-8?B?UXhrWStEYm1BaE5lWCtJSldMRFFjelUxVzhDZk5QekgyaWRLSTViZFJrT1c3?=
 =?utf-8?B?eWNsbUlBRFhUck1QVGxQYytCZTQwNG9JMDRxNjB5VG5IaHdpYll2WTRFVm8z?=
 =?utf-8?B?ZmNkNHlpdkVDRjNZQTVWbU5MWjRDUFBSRTVTaUQwNXFhb3RYNE9NOXJGZ3VR?=
 =?utf-8?B?KzQrS2xNS2Y0bkxXOVVDb2RNcHdPbGZRV2NEdm5VOWdiSHVTYlM1ZzdUWGxP?=
 =?utf-8?B?U25Zd2lKemFjaGpKT1YwVVl2S0diMFZQVWZvODdSaUpsZzRDWjc3V01ubDBz?=
 =?utf-8?B?T0JYSnpyYWFwWVU1QkZDMk10WnlHVmlJMmxnMzk5a0RXWVZxY24yMHp0T1Yx?=
 =?utf-8?B?emNwZFhpeU10SVlHdnlpWFVya285d2Fvd3JUUWlsV1Y5Zy9RMXpQeWlsWjFQ?=
 =?utf-8?B?UHN2Y2RSL29iRDhVQVpVRW9uQkE3bEZXdVFkYWhEcWZBOG13TG1abUY0Q0cx?=
 =?utf-8?B?bjY5TjV2elAwb2d2RGhKK2VVYU5JL2RFMk9EanpZeWZUb0IrRldOam02QU5M?=
 =?utf-8?B?MDlnNVFuaUdKQ2JtQzlxdHhFdXB0OFhjVWRQVkJydGVVNmI4OHc0YUovN25a?=
 =?utf-8?B?L20wNTN0dHhvRlJhaXBCM3VKNlgyTHhVYVROMVdIOXV0dVFNRUhNWjhQeVI1?=
 =?utf-8?B?UDl2VkFWMmNKSFVvOUd3ODk4QzE5dThna0lUbVBXMDNKUk1qR050MEhVY3BF?=
 =?utf-8?B?b0NLaFlOc2dQYjd3TUY3NWpoU2p6VGR2Y05hc0hkS3hsS2lKQWNSTE5HN2RL?=
 =?utf-8?Q?5B0fOV/99WH7LLccRf3EwKrE7y27ifVKjHcUA0u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7710ae3-7b1a-43de-678b-08d95e41da42
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 10:05:17.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UaDx5ws38STmPsZWaLp999JLh2TdpAXICIR8qGIQ98d/I4kTqgQO6smwXhLpkNhRm70qJSwG3b97jifq2tg0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5861
X-Proofpoint-GUID: E0KEy7CbeCBx6bDLBLyHNBmXi3VMNpKN
X-Proofpoint-ORIG-GUID: E0KEy7CbeCBx6bDLBLyHNBmXi3VMNpKN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-13_03:2021-08-12,2021-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130060
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAxMywg
MjAyMSAxMDowNSBBTQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gQ2M6
IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1paW8gPGxpbnV4LQ0KPiBp
aW9Admdlci5rZXJuZWwub3JnPjsgSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
DQo+IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IExh
cnMtUGV0ZXINCj4gQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBpaW86IGFkNTc3MHI6IG1ha2UgZGV2aWNldHJlZSBwcm9wZXJ0eSByZWFkaW5nDQo+IGNv
bnNpc3RlbnQNCj4gDQo+IE9uIEZyaSwgQXVnIDEzLCAyMDIxIGF0IDEwOjQ3IEFNIFNhLCBOdW5v
IDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IHdyb3RlOg0KPiA+ID4gRnJvbTogUm9iIEhlcnJpbmcg
PHJvYmgrZHRAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTIsIDIw
MjEgNToxMSBQTQ0KPiA+ID4gT24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMzoxNCBBTSBTYSwgTnVu
byA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiA+ID4gd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4g
PiA+IENvdWxkIHlvdSBnaXZlIHlvdXIgaW5wdXQgb24gdGhpcyBvbmU/DQo+ID4gPg0KPiA+ID4g
VGhlcmUncyBubyBjb250ZXh0LCBidXQgSSdtIGFzc3VtaW5nIHRoaXMgaXMgaW4gY2hhbm5lbCBu
b2Rlcy4gS2VlcA0KPiA+DQo+ID4gU29ycnkgYWJvdXQgdGhhdC4gWW91ciBhc3N1bXB0aW9uIGlz
IGNvcnJlY3QsIHRoZSBiaW5kaW5nIGlzIGZvciBhDQo+IGNoYW5uZWwNCj4gPiBub2RlIFsxXS4g
VGhlIGRyaXZlciBqdXN0IGdldCdzIGl0IGFzICdudW0nIFsyXSB3aGljaCBpcyBub3QgY29uc2lz
dGVudC4NCj4gPiBOYWl2ZWx5LCBJIGp1c3QgdGhvdWdoIGNoYW5naW5nIHRoZSBkcml2ZXIgdG8g
dXNlIHJlZyB3b3VsZCBiZQ0KPiBlbm91Z2gNCj4gPiBidXQgQW5keSBuaWNlbHkgcmFpc2VkIHRo
ZSBxdWVzdGlvbiBvZiBzb21lb25lIGJlaW5nIGFscmVhZHkgcmVseWluZw0KPiA+IG9uICdudW0n
Li4uDQo+ID4NCj4gPiA+IHRoZSBiaW5kaW5nICdyZWcnIGFuZCBtYWtlIHRoZSBkcml2ZXIgc3Vw
cG9ydCBib3RoIGlmIG5lZWRlZC4NCj4gPiA+IENvbnNpZGVyaW5nIHRoZSBhdXRob3Igb2YgdGhl
IGJpbmRpbmcgYWxzbyBjaGFuZ2VkIHRoZSBiaW5kaW5nDQo+IGZyb20NCj4gPiA+IG51bSB0byBy
ZWcgc2hvcnRseSBhZnRlciBhZGRpbmcgdGhlIGJpbmRpbmcsIEkgZG9uJ3QgdGhpbmsgJ251bScN
Cj4gPiA+IHN1cHBvcnQgaXMgbmVlZGVkLiBJZiBzb21lb25lIHVzZWQgJ251bScgYW5kIGRpZG4n
dCBydW4NCj4gdmFsaWRhdGlvbiwNCj4gPiA+IHdlbGwsIHRoYXQncyB0aGVpciBwcm9ibGVtLg0K
PiA+ID4NCj4gPg0KPiA+IFNvIEkgZ3Vlc3MgdGhlIHNvbHV0aW9uIGhlcmUgaXMganVzdCB0byBj
aGFuZ2UgdGhlIGRyaXZlciB0byBzdXBwb3J0DQo+IGJvdGgNCj4gPiByZWcgYW5kIG51bS4NCj4g
DQo+IEFzIGZhciBhcyBJIGdvdCBSb2IncyBhbnN3ZXIsIGlmIHRoZSBiaW5kaW5nIG5ldmVyIGhh
ZCB0aGUgJ251bScsDQo+IGRyb3BwaW5nIGl0IGZyb20gdGhlIGRyaXZlciBpcyB3aGF0IHdlIHdh
bnQgbm93IChhY3R1YWxseSB5b3VyDQo+IG9yaWdpbmFsIHBhdGNoKSBhbmQgdXNlcnMsIHdobyBh
cmUgJ3RvbyBtdWNoIGNsZXZlcicgOi0pIHNob3VsZCBoYXZlDQo+IGhhZCBydW4gdmFsaWRhdGlv
biBmb3IgdGhlaXIgRFRzIGJlZm9yZSBwcm9kdWN0aW9uLg0KPiANCj4gVGFraW5nIHRoaXMgaW50
byBhY2NvdW50LCBJJ20gZmluZSB3aXRoIHRoZSBwYXRjaCAoYnV0IHVwZGF0ZSBhIGNvbW1pdA0K
PiBtZXNzYWdlIHRvIHN1bW1hcml6ZSB0aGlzIGRpc2N1c3Npb24pDQo+IFJldmlld2VkLWJ5OiBB
bmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IA0KDQpZb3UncmUg
cmlnaHQuLi4gDQpKb25hdGhhbiwgZG8geW91IHdhbnQgYSB2MiB3aXRoIGFuIHVwZGF0ZWQgY29t
bWl0IG1lc3NhZ2U/DQoNCi0gTnVubyBTw6ENCg==
