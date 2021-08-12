Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCBE3E9EFF
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 08:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhHLGz5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Aug 2021 02:55:57 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:58866 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233996AbhHLGz4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Aug 2021 02:55:56 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C6tJVY019523;
        Thu, 12 Aug 2021 02:55:19 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0b-00128a01.pphosted.com with ESMTP id 3acqxas8m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 02:55:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIZ5WZ/2h7NWVvGVuI0AMXBUxg2hNT5MulhKQ/gnk7Ev+cz0bKoOIdV2WE8S4zTsUXbhh6KKevMAWV1c+NMauJpmIpG6H41fK2vFovcgDTwIUNGdDMoXbgs23snicKEMLVZOlyQIZhMhUmTYxw9kfN5h0xo8Y5fUqsViM/ns0VBwbnVEFnBtQ9884Rb/8G5AUkt2g/1m+rmdTOWDxP4gjWP1DSu0AFu82nqp1koVqLyTHzv0lGB5Qt91I4ZwpWAihF9kyxzj+URzfU7FXPn1aEvA64fqXCaO0uRYEUFLFL6WfjLj44xoG7vtfEa8fBBB1vo/DIynsA7zbIha53k8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1J5v9tgqIMfVYpLEJ37x6CgKiVW4SPiEvmp6BHKT8U=;
 b=odv+uSNWa26VLQK95HoVbHYOTSHAF4GzWNKl/GiN7abp86TkbbQg7P+13896zbHGYcFdT/IzoPLcf/JIAXNzg5zlRQQnIslUfWFedhGddituCIBYmZciyMqlhy+N3GjnsI5MEjIEArvaigM80kS2RXWK11yjOfUxyoSZTW2oTZVn1JTgyJ0SaG+qiIm30bN13sozWRmBm/VwSe0yFJKrmuSail0xgJadMDarSuawnS6lUibRurOWlLV22xVWoJGpTvduEzZ0sSaG5mnu/Vmyg0/ehwza/+89Hmsu4NIlgry338JTVqxYkf0J+KW1AyqLQa1YkvoIRNLnOG3AAnpolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1J5v9tgqIMfVYpLEJ37x6CgKiVW4SPiEvmp6BHKT8U=;
 b=MsHoqav3TA2OZVVvKfJbneg+7v2uxNFJDNq769dsKR+NO3iaLi/FhUWWp7LPDcrwozusfTD0EX3uX7d/NjN9OaePN4duTF7aZ9vWi0OB10qtIxDI6bZNTpxystgv4nC9Y9TUGyIl8p+ajzfgDtKgrN3eEqS1piC/RgvZRVv2uiY=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6333.namprd03.prod.outlook.com (2603:10b6:510:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 06:55:13 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 06:55:13 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: ad5770r: make devicetree property reading consistent
Thread-Topic: [PATCH] iio: ad5770r: make devicetree property reading
 consistent
Thread-Index: AQHXjoTpWS49/XePMUytpStcxW5zfKtud/2AgAD4urA=
Date:   Thu, 12 Aug 2021 06:55:12 +0000
Message-ID: <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210811074827.21889-1-nuno.sa@analog.com>
 <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
In-Reply-To: <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE0yTTBOemhtTURNdFptSXpZUzB4TVdWaUxUaGlPRFV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhETmpORGM0WmpBMUxXWmlNMkV0TVRGbFlpMDRZ?=
 =?utf-8?B?amcxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRBNE1D?=
 =?utf-8?B?SWdkRDBpTVRNeU56TXlNalE1TVRFek1qRXhOalk0SWlCb1BTSnJXV1JDVkZa?=
 =?utf-8?B?V2VqTldVVzlMZUVsVFNXeDFLMEYxTUV4cmFFVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRlZjelpJSzFKdkwxaEJXbmhvU2tKNlkxSnBObk51UjBWclNF?=
 =?utf-8?B?NTRSMHh4ZDBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: a5250424-14ab-4b19-6837-08d95d5e222e
x-ms-traffictypediagnostic: PH0PR03MB6333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB63334A974D98E1E78ACD819699F99@PH0PR03MB6333.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/ingW61x+hR7PpnkPb8XvEWf6gvmZOkUD0WKDK6GMRUqyO6jBGa9hUMRESaap9U9z/mY/8mGaVYqb9fQfACSD9l2E4lDS11RQuye/3MX6lWo/yIOAd68OLeQQDORwxZaLLDkoayhjIoRIPXA2lm0XStPDnJkpYGSkRhXTsaquWJ5nA6Dx98QP0RVE5mPf/Qi5hAyGfh/Wc9aU2XMdBLLfMyDET2NG8lC+hWmjiuxSymZ0OjG1uuekd2NKG+Jmj+Mo2UDm44W2EPvsmGdDteJdXM8E4zkWsDK/4w7eTXrww0kYF5pf8PasSNwlpEv+Ldl+Xms+tA7hGd7Sbu3HfY4D+Ol9zWz8HWycl944Kep9MpkLcIjX/wJh9BHmPmRW9uHAzfNZqovo7YglwzLyGhlY/8Wz7nZV5QKUV3zBtHkRYcJZBPpRSoFAQ27glCKqjRIgjfc3mInWBrJCf5MtR4Za1NB1eSfpTaKdyB9EFE4qLOlCiuMEDV+NqZi0x/gak96SFloHC00DWLmjS4RGAZkRQuqLhnd8RIPUa+ktAryImaKkb0L0IfIA9yihdC79Ly0VPJOs1/bEJ07prk7cHS1Axor6/8cEd7cpJI9dTQ1Ph4lFZu3W2emLQbW0leGImrG/9ratfgO35omnWgGfpS6WIjmakhOz4R4JE9Y+6Kjb4tRgH7STw/Gwd8tNl2hG7SXI2FbOT3WvXVTZi9jU0qFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(2906002)(9686003)(316002)(6916009)(6506007)(122000001)(53546011)(8936002)(71200400001)(478600001)(8676002)(4744005)(52536014)(86362001)(55016002)(38100700002)(66446008)(64756008)(66556008)(186003)(33656002)(26005)(76116006)(66946007)(5660300002)(4326008)(54906003)(7696005)(66476007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2hYV0JwMWJIS3B0QkdHTjU4ZEVpQ3QxQWk4T3VQYks4aHBIYUdoekxWdjZH?=
 =?utf-8?B?UUQ5ZTNOS1c4d25TcHZIY3NvUUREaW1wQlFFTGxzcktxeS9JNklaTHJHWm9U?=
 =?utf-8?B?NjMvSW1EbnllVXNjdUlzZ2RDelh6eDZJZ2RkR0g1a3I0Q1VXSHN5dURlemx2?=
 =?utf-8?B?Z2FYL1VieWZqcXQwd3kwMXNmanJTUEVJMGVIMG5wMHFWaDhQLyt1RGRCVkpP?=
 =?utf-8?B?bUFDVDQwQTh5Nm9iaGphcXBMMC9tTlZINjAvNjcwbXFTMVgwRFZtT1VSeHNr?=
 =?utf-8?B?dHJtUDZ3bFIwSE5qTFN6OW81U1o4TW00Sjd6LzhGeWk5VEVrSlU0dUc2ODNB?=
 =?utf-8?B?RXluallDWnp6SjRUQ1UzQ2RXOWpFMnFqTk9uVmNzeDcvUS9kMHVuSVZYNm5I?=
 =?utf-8?B?SEhlQWQzK1YrZjlSS3JLWUtsbWpYdGJSdFBnRjIwMGpUY1Z2RkNHUEkzRmVH?=
 =?utf-8?B?di9xZzUxZlJwWDVGcHVJS2JDRnhFK3IwcE5pOVRxZmtzWWZXOXNjMkFTQnlZ?=
 =?utf-8?B?V25ZZ011U0pGb0tPQkk2UXVEV3BvRENBZzhLRzZWZ3c0L21zT0NVVWI1dU5P?=
 =?utf-8?B?SExLMHpnbS81Q05xckRVcDlzM09pNmVBY2NmbXVQalZNWS9lR1I1MFdiOGVG?=
 =?utf-8?B?Z1MzcGlieWtnNENQSkpzeVNzK0YrbEl0ZFhpeHByNzA0dElmNEpBZ2RzRHJl?=
 =?utf-8?B?elE5djJ3NnNWcm5pRTRnYU1KMVMrbktBY1JtY1J2SDJ0ejhaUHBDdlIxejB6?=
 =?utf-8?B?QnViMVhjbGVNZnp5RnBWeHpCNkxhejRmS296WHh2SnphWVY5ZlMwQ1Baditm?=
 =?utf-8?B?MldtS3ZDdUVid0ZETmdJYStnbXQ0OHZIK0ZoZ3BQMGhmeHpIektGZnQ3QlJt?=
 =?utf-8?B?Q0hSNjJ4dGo0SUVtMkQvRVVYTWgreVlUMkZiNG5aUjlMaWNTbGg4bjlWYWJX?=
 =?utf-8?B?KzU1d2NWbnl5SUxkdGdKZTFnc3dDL1YxNHVGL1dnWFJ3VkFHL29xMVpLeW5n?=
 =?utf-8?B?T3ZRYVRkQloxVmVsOS9USzVvQVRpbzAwWG51RmxhdEpjRGFhblpwd242K2xH?=
 =?utf-8?B?K3F3OXZZRHNMQVBNV2ViblhJTFVvSlVWOWZWQXMyRlJldGJ1clpOanAwRWhD?=
 =?utf-8?B?N3FUdTFJSGdFdGdwRXFvTEFMUDJFRXpTOUFEV2tSSDFseHowSU42ZGlCWSs5?=
 =?utf-8?B?bFp4ajhDdDlIVmwxUW40TlZhQkVmdEV1V2NocGZUdDkrMVprVTVSdkYxN1hQ?=
 =?utf-8?B?eXRuUkZNZktUeEtIWWFIaTBYVGVZaUVjR2dCeU1mUVhGUHMvVit4NU9Kc1BN?=
 =?utf-8?B?d3VSekNsdFNZR25vZ2FEV080WjFSc2kvTmtudFdlZ1hyb1Jmc0dlZjBRU211?=
 =?utf-8?B?NW5laWhpUW1KYitrbXE4YnBRcVlqRFlLNWJqeUFOamJTK2JlOXB0TG9wTVhO?=
 =?utf-8?B?T3ZuajZPdk5KNXUrbU16YzBUaGhNZkg1U0liVEorQS9mVGZ2blUvaGszRE9h?=
 =?utf-8?B?K0JDeUREOVZhZlhWSlNsbnVnTERvZmZrbmxzdUMwYnZNOWhWLzZnYVBjTFFR?=
 =?utf-8?B?Yjd5Tk11REROQ01kTnFLMmV3RVVVVXlWRVhUODFiYlV5UjQzbnl6SWVET3Fl?=
 =?utf-8?B?azN2ZUNVaU11NXN5Ykx1S2RySEV3T3lZTWdPdks1T3JocFB5U1BkYXpVZ202?=
 =?utf-8?B?NS9PS3NNc2pzRVdUeWwyRVdrZ1IrMS9EMUlTbEtTRUx6dGdmaXpzN2FST0Zz?=
 =?utf-8?Q?XAv5x2E0E7w6YM3NL5zYUVRkJPws0dP9kFgZP4i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5250424-14ab-4b19-6837-08d95d5e222e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 06:55:12.9808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HeKo7CBBCH/5EwALKmKH4hWT2hlrUcxcN7QbVBc6XvTKaRBjZmtlDFIRvBJATwSWbbfxP13J4lYysMIA/pwHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6333
X-Proofpoint-ORIG-GUID: U1q7oQtSB9DsWBbxyXN1t4uSIDngm2nF
X-Proofpoint-GUID: U1q7oQtSB9DsWBbxyXN1t4uSIDngm2nF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_02:2021-08-11,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=860 impostorscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108120044
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgQXVndXN0IDExLCAyMDIxIDY6MDQgUE0NCj4gVG86IFNhLCBOdW5vIDxO
dW5vLlNhQGFuYWxvZy5jb20+DQo+IENjOiBsaW51eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5l
bC5vcmc+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqaWMyM0BrZXJuZWwub3JnPjsgSGVubmVyaWNo
LCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgTGFycy1QZXRlciBD
bGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlpbzog
YWQ1NzcwcjogbWFrZSBkZXZpY2V0cmVlIHByb3BlcnR5IHJlYWRpbmcNCj4gY29uc2lzdGVudA0K
PiANCj4gT24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgMTA6NDYgQU0gTnVubyBTw6EgPG51bm8uc2FA
YW5hbG9nLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgYmluZGluZ3MgZmlsZSBmb3IgdGhp
cyBkcml2ZXIgaXMgZGVmaW5pbmcgdGhlIHByb3BlcnR5IGFzICdyZWcnIGJ1dA0KPiA+IHRoZSBk
cml2ZXIgd2FzIHJlYWRpbmcgaXQgd2l0aCB0aGUgJ251bScgbmFtZS4gVGhpcyBwYXRjaGVzIG1h
a2VzDQo+IHRoZQ0KPiANCj4gIlRoaXMgcGF0Y2hlcyBtYWtlcyB0aGUuLi4iIC0tPiAiTWFrZSB0
aGUuLi4iDQo+IA0KPiA+IGRyaXZlciBjb25zaXN0ZW50IHdpdGggd2hhdCBpcyBkZWZpbmVkIGlu
IHRoZSBiaW5kaW5ncy4NCj4gDQo+IFdoaWxlIGl0IHNlZW1zIG9rYXksIGl0IG1heSBiZSBub3cg
YSBjaGlja2VuLWVnZyBpc3N1ZSAoc29tZWJvZHkNCj4gY3JlYXRlZCBhIERUIHdpdGggIm51bSIg
cHJvcGVydHkpLg0KPiANCg0KQXJnaGgsIEkgc2VlLiBXZWxsLCBtYXliZSBsZXQncyBnbyB0aGUg
b3RoZXIgd2F5IGFyb3VuZCBhbmQgY2hhbmdlIHRoZQ0KYmluZGluZ3MgZG9jIHRvICdudW0nPw0K
DQotIE51bm8gU8OhDQo=
