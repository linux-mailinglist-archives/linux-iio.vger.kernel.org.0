Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3693A5E58
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhFNI2E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 04:28:04 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:1294 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhFNI2D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 04:28:03 -0400
X-Greylist: delayed 1352 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jun 2021 04:28:03 EDT
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E8C0KD000766;
        Mon, 14 Jun 2021 04:25:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 394sj7p3e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 04:25:55 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15E8Pso3022648;
        Mon, 14 Jun 2021 04:25:54 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-00128a01.pphosted.com with ESMTP id 394sj7p3e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 04:25:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xynfh83XFpHyRde7tdLXjyuX75q1yipNwzZ3xGNcdQ7pOwcXHxtPvYuuRLACl+L/NObApXGHLVYbBuxe4IvgpXWzy9s4tQcpDqpMrLPPwnPYynZ9tP5QEbzshKUWdqRCUyJWyKV7st91hpx/nBkGdOOZl8/UHiYaeVjUaYbjjc/0cR8eB3eVUCQAKPA/cCj6lZy3MmP+zfPoUFCaYSJ43CL3/OOjZwKxsJ4F2Po7MfmjXwc+z0G2ARAKNvMcWtvWQQva7nNQoO8QdQYnav0LbpdEJtsKsapBb2AcpAbevayy/YyPZQaCt06/dUfgOeAJbRDDVwk7m1irew2AwSqI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QrMkm/MHWP8KrD1FaR1Fz9a98TK607dTB6NkS+QADw=;
 b=N9VGUbqXnZ8Vqucmtu75Y9yU5UvgpjIUJ4rGqAEvD7nn2JoS/ZFwxZ2MBhLo0VmKtQk1EpNvoQzUGDqaTgeAbMU68J+rJWk7p8RwmJvBV+E4edUMvGqUclp+0t67IeWxClj6I3/4VxZy+U9R1B9IfWxSZcwMtUFC1IS5rF5jQ9r8TjiJzKydmlUvh6nULjyN9scoUiWZpxWJfUkcJs/nWHH0rQaqRJEeXssuUQXXYMAZThnh9RKMoxpXD9+aG66yWuwqFyMtSvBBDftzNY9Z9wwhYLGHdCtnOy+qRBPLTdWcZ1gdUQn/SM6t1tFGZoduMCwpDEErsPro9fSdM0wRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QrMkm/MHWP8KrD1FaR1Fz9a98TK607dTB6NkS+QADw=;
 b=o+ro4hrOdaNaz4wCMyZthSce7kvgvQAUW9YQYQqICTK5Fzo/j+x2fwKNswwhFIWecYkmVVJdvZfbZZwoCN/gLKWudtWKaGLPedcVOrJ+s6ZZL16jQR87OY6I4xHFJ1uOyvWEfcTWFxjnRAigO/od9MWCLu1VROX9EJcaN5FutR0=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6333.namprd03.prod.outlook.com (2603:10b6:510:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 08:25:52 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4173.022; Mon, 14 Jun 2021
 08:25:52 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 4/4] iio: imu: adis16400: Fix buffer alignment
 requirements.
Thread-Topic: [PATCH v2 4/4] iio: imu: adis16400: Fix buffer alignment
 requirements.
Thread-Index: AQHXYGYKyxRlAnsM5kiqdmzkAsSTPKsTLOkw
Date:   Mon, 14 Jun 2021 08:25:52 +0000
Message-ID: <PH0PR03MB63669A3FBEF0EE4FB385531199319@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210613151039.569883-1-jic23@kernel.org>
 <20210613151039.569883-5-jic23@kernel.org>
In-Reply-To: <20210613151039.569883-5-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1qQmtOalUyTURBdFkyTmxZUzB4TVdWaUxUaGlOV1V0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhESXdaRFkxTmpBeUxXTmpaV0V0TVRGbFlpMDRZ?=
 =?utf-8?B?alZsTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTWprd015?=
 =?utf-8?B?SWdkRDBpTVRNeU5qZ3hNekkzTlRJd05ERTVPRGd5SWlCb1BTSkNTVU5tTUVS?=
 =?utf-8?B?Vk5GUk1Ra2hqYXl0U2MwaEVVelJLTVZKNldsRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRnhhME0zYWpsdFJGaEJXVkZLVVdSSWFUWjRhbTlvUVd4Q01H?=
 =?utf-8?B?Vk1ja2RQWjBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:255b:f101:f55e:b075:2abb:d2f5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5951820c-e2f4-4e7b-dd6d-08d92f0e05c9
x-ms-traffictypediagnostic: PH0PR03MB6333:
x-microsoft-antispam-prvs: <PH0PR03MB6333204DBE6A6A0A1A4C523999319@PH0PR03MB6333.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: asFWijXXXMbcaLk+g60LUKSxEsA/vidc4cXAifmEooEmd5K2jez7g0TwrESWm1QDrMUMN9dmzzILI3ShzlQwVmIcHV4C9TOPqELDz7sy3wbOSIoU7FsFMByBHSZeNJ83s8as8n6OFWBFnd+pKzNo1CIcFNSNrWr9GKMpLoBIW+YJtoliay3hIz609o0eLsFdxXfbi2m3FZVRvHP9GmuE16VrqZ3sETaPGgSyr3iseR3M2iSCZc+xxiQ3Ye6GJg2jmxORtI6D0LSKlXX1tcKDE/4RrR5XuIMWVLpP5epTi6M9zfwRUabGdwGp/P8czHclgz3i02Fi4WYQdJctbPXX6i0oJw7rNvd65Nd/h3cx1Po1VMrBe5XS3I+uijU0RAZdRCpvGo7SnRlKR+wRz74BgZL7+LO5NLWz++so5fkZi3ksqG6ra1OFE5cvPFy07AMNeOFZbTz6tQ54D9gMi8xibUXczxCPMN6f40WUZiRpqGUL6Mb0uAHLGGxqb3R+QkEz0yegzSiDNOHif2S6dqBQVU5RNWQrIho07eGWkLTaLeO1Vt1Fe15AgkcFB/Jrv/zYRXQvUHQJadJESOiwYhJLVmHfAmVDsh8lEvYZxmlhR00=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(83380400001)(66476007)(64756008)(33656002)(38100700002)(122000001)(9686003)(66446008)(66556008)(55016002)(76116006)(66946007)(8936002)(2906002)(478600001)(4326008)(86362001)(53546011)(6506007)(5660300002)(8676002)(71200400001)(7696005)(52536014)(186003)(110136005)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N21NbXlEYnB4bUl3Q2VyMGRaU1A2aFVscGtCWFlPRzdGcjFwOGRYekJUTThs?=
 =?utf-8?B?OVVRTjBlN1c1OHZrWFlabkJBbndwVG1iazl1OUR6UkVra05Cd0FRUmFBV1ZD?=
 =?utf-8?B?VVNUU1FzNHArZU12Um00Ui9yZEk5NVRLb2ZTUlNmbkd2OVdvdS9JU0oyeXYw?=
 =?utf-8?B?MWtyVjlkSzBBa1YzWTZ3cENBeldONlUyaUpRbEozVjBSSGltY3MzbW94bEp0?=
 =?utf-8?B?eDNLTEU3MXBLT1ZBZWZOd1o5WUJEQ2l6N1NyemVQcEpyWXl2Z2dxNVcyeXl1?=
 =?utf-8?B?c3piTVhmL2RUWTlGQzFUcE5SNVlKc21VV2EwczRXMDJVRENZZmZMZEhHVzlt?=
 =?utf-8?B?VFEwOCtMMm9lbGcrYlRMVmR3bStQcVhVc1czWDJOQ1B0OUphSTBCSjF5aER4?=
 =?utf-8?B?Z00xdVNzWTBwQzlId2xMMUNaWnhhNnZDcGJ4QkZjOVFnK0xzVmNYRW55UExj?=
 =?utf-8?B?TllaZHpnckJFYkxHblNSblRiMzRJZFFxN3B0QmVwSG1mV1MwNEJvZmIxUXVl?=
 =?utf-8?B?M3BaQ2xKcWJwV000R0hWb0RFMW1xamdhcTE5MG9WSWVWcHhqWWRDUUZ5czZN?=
 =?utf-8?B?MStYTjB1ck9KOXB4WmdNK1EvTFJrYmU3d2NaTE1FS0xJZmlEQWV0VWhVZXlM?=
 =?utf-8?B?WlFza3AySGx0dmtNQ0F5TURUUHg5SFRrbHdjNWRTUzV5dnRQSFUrYzJmUGxk?=
 =?utf-8?B?WHlQTHdpNFdXTXVyd0ovb0VYUzlQWlVLS2tYRU1pdDZoS3RodjVuamJUNTVY?=
 =?utf-8?B?d0FiNUZEYUl2VTNweEwwQWJGa2NEaGh4NHYwWWpnNjY0TXFQR0gybjUvalRQ?=
 =?utf-8?B?Z2xWaW1vYkQzQlFubjU4Yi8xVm9DcmNVaitMMjUwNVpwY0ViOW5QV0NVanZQ?=
 =?utf-8?B?WnJuK1VpUm91ZEdVQ0FvbURaNGsrY00yaHlJMkdnWEp1bUttV3QwVDBtZktM?=
 =?utf-8?B?b1I1R29EQUNVNUtKZUNucFJyTVB6VDVNNjNDVlZQRE1mc3hpalI4ZjVmSEI5?=
 =?utf-8?B?a05xMG9hVXlzUzBvaU1CUE0vRGV6OHRJNG14OVc0R0RrckxpbGFVQ0crOHdv?=
 =?utf-8?B?RXdnM2FRVjdTZzNDeDVucmRnK0p5UWMwOC9zR1RlMzhBdU9uTG51VUFBWDhU?=
 =?utf-8?B?R3lVaXpCcHVxd2JCcDFhcGJ1VmRBajJhUmdsNDZLdnRadXVLZ2h3WUZUbjJk?=
 =?utf-8?B?ZCsyamNYL0hmcHFITGQ2L3MzcVgvL3pFVzJuMlYxbDRtV0NscnY0NWRsRjZz?=
 =?utf-8?B?NUdzSElKaEdCU0txRVpXelQ4ZWpkcjhVdytDTU1oOHNDVjBTV2tOejZQeGda?=
 =?utf-8?B?Z2tNV05jSTd1UklkTk1yV1B6eUhOQUdIdkJJWWpEV2FQZUk2Z3EwTFJCbHhq?=
 =?utf-8?B?RWJYV2trdy9hZER3Q1l0cjZzQWcrcUpvcTRaZ2hPc2c5NS91WVlCQS9yQ2VT?=
 =?utf-8?B?UmhFcEt3dDFnaS9obkt1bTNUUWRZZXdUZjNwRjVIWWEzUFd0NTdGc2ViNEZD?=
 =?utf-8?B?M2x0QWgraGZLajd3cmp5TEZUVG1lVWJMNnRGeXV0SXVzYzRVZEUvc0ZISmRL?=
 =?utf-8?B?eElWWGZMRWNUd2lJYXlpbllDZ3dHQUNiUlZTVjhoY0JYV1k1ZFNjSVhSVkN1?=
 =?utf-8?B?ZEZVRXlmY3Y4SzcxVUFmekFEVURITjRlRVVQaHczQzJzL2ZmaDliY2ZzRkRG?=
 =?utf-8?B?S3NORDlEcnpxMTY0RHVCZ2JYTXJXMDFqczNmRWI4cEV3SXZUU0dpRXdLV0RI?=
 =?utf-8?B?Qm1IUjFoRmZOSGxCYU81Qi81V0NsSGdaM2MrYS9zQmNuN2F1SVlTRE9vTys3?=
 =?utf-8?B?OTlzQTVhUStuckw5bTNGemM3MUo2RlZmZFJscjF5a1A2RlhPUVJ4ZDJVN2lM?=
 =?utf-8?Q?nqBnuDpdeTOwe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5951820c-e2f4-4e7b-dd6d-08d92f0e05c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 08:25:52.1415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ORUBzGyA3qIQb/5641Yms2kTICfErO0iM9EuMybkyrvqr0nfrrBzQEn5PMlrXEh0WfZ/4dCFwN2QKKag1LJZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6333
X-Proofpoint-ORIG-GUID: AEprzU4j2kY4ezfYs5ZgL8HVDDZwgb4x
X-Proofpoint-GUID: jVR23lWwlx0Vycq5REso_P2KF6aRt7OH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_01:2021-06-11,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140060
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5k
YXksIEp1bmUgMTMsIDIwMjEgNToxMSBQTQ0KPiBUbzogbGludXgtaWlvQHZnZXIua2VybmVsLm9y
ZzsgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgU2EsIE51
bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gQ2M6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz47IEphbiBLaXN6a2ENCj4gPGphbi5raXN6a2FAc2llbWVucy5jb20+OyBK
b25hdGhhbiBDYW1lcm9uDQo+IDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+OyBTYSwgTnVu
bw0KPiA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgNC80XSBpaW86
IGltdTogYWRpczE2NDAwOiBGaXggYnVmZmVyIGFsaWdubWVudA0KPiByZXF1aXJlbWVudHMuDQo+
IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5D
YW1lcm9uQGh1YXdlaS5jb20+DQo+IA0KPiBpaW9fcHVzaF90b19idWZmZXJzX3dpdGhfdGltZXN0
YW1wKCkgcmVxdWlyZXMgdGhhdCB0aGUgYnVmZmVyDQo+IGlzIDggYnl0ZSBhbGlnbm1lbnQgdG8g
ZW5zdXJlIGFuIGluc2VydGVkIHRpbWVzdGFtcCBpcyBuYXR1cmFsbHkNCj4gYWxpZ25lZC4NCj4g
DQo+IFRoaXMgcmVxdWlyZW1lbnQgd2FzIG5vdCBtZXQgaGVyZSB3aGVuIGJ1cnN0IG1vZGUgaXMg
aW4gdXNlIGJlYXVzZQ0KPiBvZiBhIGxlYWRpbmcgdTE2LiBVc2UgdGhlIG5ldw0KPiBpaW9fcHVz
aF90b19idWZmZXJzX3dpdGhfdHNfdW5hbGlnbmVkKCkNCj4gZnVuY3Rpb24gdGhhdCBoYXMgbW9y
ZSByZWxheGVkIHJlcXVpcmVtZW50cy4NCj4gDQo+IEl0IGlzIHNvbWV3aGF0IGNvbXBsZXggdG8g
YWNjZXNzIHRoYXQgYWN0dWFsIGRhdGEgbGVuZ3RoLCBidXQgYQ0KPiBzYWZlIGJvdW5kIGNhbiBi
ZSBmb3VuZCBieSB1c2luZyBzY2FuX2J5dGVzIC0gc2l6ZW9mKHRpbWVzdGFtcCkgc28NCj4gdGhh
dA0KPiBpcyB1c2VkIGluIHRoaXMgcGF0aC4NCj4gDQo+IE1vcmUgZWZmaWNpZW50IGFwcHJvYWNo
ZXMgZXhpc3QsIGJ1dCB0aGlzIGVuc3VyZSBjb3JyZWN0bmVzcyBhdCB0aGUNCj4gY29zdCBvZiB1
c2luZyBhIGJvdW5jZSBidWZmZXIuDQo+IA0KPiBGaXhlczogNTA3NWUwNzIwZDkzICgiaWlvOiBp
bXU6IGFkaXM6IGdlbmVyYWxpemUgYnVyc3QgbW9kZSBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1i
eTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiBSZXZp
ZXdlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2lpby9pbXUvYWRpczE2NDAwLmMgfCAyMCArKysrKysrKysrKysrKystLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vaW11L2FkaXMxNjQwMC5jIGIvZHJpdmVycy9paW8vaW11L2FkaXMx
NjQwMC5jDQo+IGluZGV4IGNiOGQzZmZhYjZmYy4uNjZhODNlYmQzMTA5IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDAwLmMNCj4gKysrIGIvZHJpdmVycy9paW8vaW11L2Fk
aXMxNjQwMC5jDQo+IEBAIC02NDgsMTMgKzY0OCwyMyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QNCj4g
YWRpczE2NDAwX3RyaWdnZXJfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpwKQ0KPiAgCWlmIChyZXQp
DQo+ICAJCWRldl9lcnIoJmFkaXMtPnNwaS0+ZGV2LCAiRmFpbGVkIHRvIHJlYWQgZGF0YTogJWRc
biIsDQo+IHJldCk7DQo+IA0KPiAtCWlmIChzdC0+dmFyaWFudC0+ZmxhZ3MgJiBBRElTMTY0MDBf
QlVSU1RfRElBR19TVEFUKQ0KPiArCWlmIChzdC0+dmFyaWFudC0+ZmxhZ3MgJiBBRElTMTY0MDBf
QlVSU1RfRElBR19TVEFUKSB7DQo+ICAJCWJ1ZmZlciA9IGFkaXMtPmJ1ZmZlciArIHNpemVvZih1
MTYpOw0KPiAtCWVsc2UNCj4gLQkJYnVmZmVyID0gYWRpcy0+YnVmZmVyOw0KPiArCQkvKg0KPiAr
CQkgKiBUaGUgc2l6ZSBoZXJlIGlzIGFsd2F5cyBsYXJnZXIgdGhhbiwgb3IgZXF1YWwgdG8gdGhl
DQo+IHRydWUNCj4gKwkJICogc2l6ZSBvZiB0aGUgY2hhbm5lbCBkYXRhLiBUaGlzIG1heSByZXN1
bHQgaW4gYSBsYXJnZXINCj4gY29weQ0KPiArCQkgKiB0aGFuIG5lY2Vzc2FyeSwgYnV0IGFzIHRo
ZSB0YXJnZXQgYnVmZmVyIHdpbGwgYmUNCj4gKwkJICogYnVmZmVyLT5zY2FuX2J5dGVzIHRoaXMg
d2lsbCBiZSBzYWZlLg0KPiArCQkgKi8NCj4gKwkJaWlvX3B1c2hfdG9fYnVmZmVyc193aXRoX3Rz
X3VuYWxpZ25lZChpbmRpb19kZXYsDQo+IGJ1ZmZlciwNCj4gKwkJCQkJCSAgICAgIGluZGlvX2Rl
di0NCj4gPnNjYW5fYnl0ZXMgLSBzaXplb2YocGYtPnRpbWVzdGFtcCksDQo+ICsJCQkJCQkgICAg
ICBwZi0+dGltZXN0YW1wKTsNCj4gKwl9IGVsc2Ugew0KPiArCQlpaW9fcHVzaF90b19idWZmZXJz
X3dpdGhfdGltZXN0YW1wKGluZGlvX2RldiwNCj4gKwkJCQkJCSAgIGFkaXMtPmJ1ZmZlciwNCj4g
KwkJCQkJCSAgIHBmLT50aW1lc3RhbXApOw0KPiArCX0NCj4gDQo+IC0JaWlvX3B1c2hfdG9fYnVm
ZmVyc193aXRoX3RpbWVzdGFtcChpbmRpb19kZXYsIGJ1ZmZlciwNCj4gLQkJcGYtPnRpbWVzdGFt
cCk7DQo+IA0KPiAgCWlpb190cmlnZ2VyX25vdGlmeV9kb25lKGluZGlvX2Rldi0+dHJpZyk7DQo+
IA0KPiAtLQ0KPiAyLjMyLjANCg0KUmV2aWV3ZWQtYnk6IE51bm8gU8OhIDxudW5vLnNhQGFuYWxv
Zy5jb20+DQo=
