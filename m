Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A393F270C
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 08:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhHTGrp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 02:47:45 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:22182 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238646AbhHTGro (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 02:47:44 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JKBXgc022238;
        Fri, 20 Aug 2021 02:47:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahka2nhyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 02:47:01 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17K6h3jv015877;
        Fri, 20 Aug 2021 02:47:01 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahka2nhyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 02:47:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNj0BQBOsnM9o4Lht8C6BZSoH3rl32H5BZRpRGJkPY/wlCrnButBIMGoVXEEB8UZaL+7Iaja4Ry6vmvWr1TBK7rXxJuioBuc6ke7TxoTivTa+U6prF20joXBxpksyKRZZjoVBGRpXLnsuWybBYNSZa33BdyfcMYHxP0QU9WWS5npQ/bdMs9mC0wHFtLlTwkbIQoiMquM5pWjTyDwDnPygm8h9L79ApNR5oJWylUiZ5v3zihVy2xrEFXB/PoAR5RC2TlPQjbZm+6vbq1kO+iiOpfyL+JwlQ4/lyz+SCc+9xHnwLmMPNfPGJ4kF/8Yrbhynn5cnjlZVUDR+cUv0wDyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3XKqFfrxJaBvG6/Gu/0TcLz9RHGb+BgzXobfkcjzq4=;
 b=I0qz8wIqfbAy5AjxcBx+72FDK2OXI0UOZZwl6ZmDe/ma7GA6zgLZOgxt1JyqZsfu+9NdX6M+O5zpNrxZ9XD/VihpPP3q/XPKkhaZoUi2uPw9VR8rDM5WUHTastbK5lKXRvbkxbkK4PUVIj00n11t7AZ9PHMhvwzA7SYpDYMJypw97iMGk3te4aRfF/1l3wuSx91puDk0tau4RhK28u7cWr6ytX7V0oVGwuB/AcuDC+kYJaWow6MPCHqfr+z4pLlovIKYsSup9qeL93Lqv9jETBEZEO+k3Wo45T+vOfYF2chXkptkbnbfH09rzowpc9+qlegyGGQmWYT/gmfVbfVGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3XKqFfrxJaBvG6/Gu/0TcLz9RHGb+BgzXobfkcjzq4=;
 b=VSG3wbHhobFJ/6IxJA3WIdfCOLZhYGeoKPfv8c4P9G2YW8G0F25HFgxqhCCBDfEgtNgvx7JRb67yRyxYFq53l6kSlVUu55Mj9PW4cnYi0pu/6/UJ3RqQywmPfXBDunKASZD+qhi2eGTniS/TycYSTzpUwiJ0liFFHXAu08LTVJQ=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BY5PR03MB4982.namprd03.prod.outlook.com (2603:10b6:a03:1f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 06:46:59 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 06:46:59 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "prabhakar.mahadev-lad.rj@bp.renesas.com" 
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: RE: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in
 rzg2l_adc_pm_runtime_resume()
Thread-Topic: [PATCH -next] iio: adc: add missing clk_disable_unprepare() in
 rzg2l_adc_pm_runtime_resume()
Thread-Index: AQHXlPy48JiOOdL4gUiL2TkFopD9Eqt7EywAgADg15A=
Date:   Fri, 20 Aug 2021 06:46:59 +0000
Message-ID: <SJ0PR03MB635988DC2F6E54D545337FDF99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210819132416.175644-1-yangyingliang@huawei.com>
 <CAHp75Vd22aP098s9iXCGmBG505dW1vmZgvy3h9NoNA=J-eQ-CQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd22aP098s9iXCGmBG505dW1vmZgvy3h9NoNA=J-eQ-CQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5qa3hOakpoWXpFdE1ERTRNaTB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEWTVNVFl5WVdNekxUQXhPREl0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRBeE5D?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVFUyTVRjeU5qRTFNRFE1SWlCb1BTSkNhRTUwVmpC?=
 =?utf-8?B?RmVVSjBjWFpvU0hkdWNqbFVjekpMUjFwM1RsVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTktURmhSY21vMVdGaEJaa0ZMUkZwa05FUm5VVkE0UVc5T2JE?=
 =?utf-8?B?Tm5UMEpCT0VaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 4ea80b4a-7159-48a8-884c-08d963a64f34
x-ms-traffictypediagnostic: BY5PR03MB4982:
x-microsoft-antispam-prvs: <BY5PR03MB49820DEB4F3268B775F150D099C19@BY5PR03MB4982.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5YIAq2i5iRxXXCDo5jWMpyT7LHXD5iWJiArrHaJYcLZcvYTQJkmfhdKRPkP4EDlzro4q9CoTfLT0UCUvDgVolMRblCQjn6VlzydwOpanqOujBJWTva6YHQ5sw8HBt/OSu03bAV5rFHzPeZVaqQAOLgiH8TBk0s6XKTpnnSPPf3JqSE1zngLhlTidsRqqvjTXC8yJd9pSdQJ+rBHcanVckwS/6gNnJylsQowPsNIdZLzOjVamBBkesT1g6G9a58jCGGWTRLtag4uYRuUZYFkCuYfzaMitWdtwGd0H4vqMGsLQI5BAxZDm1oEbCMXv0fgeW7+dWgupkmE9XvcQaFrNBLjxYiaNQHUgLUgZP9eJYm8EdvU1T/4vgtTMuZ7CZU1koT0SO7Os0LNhAH9+7500QPZLOc1dfZliEnDvMSc4omgYW45hj6cq3XWbqy5HTmMqJKDSb6b6W2HvhfP7NofEKgmJRWblae467QX0zV/LCoEncXnoVJ47Buij5CHimdivw6mXQOKp/yZ6V+Me8KBm4F1ZEdCK56686Fz6AIXrORlyNSBJ6IwEgnDo/KeWjbsWvGXzjPrsVRwwDkppzjp7MTO8bP046Bwm+oJKyFHazU6aBw2vxMXcUHoP78whqVp46OipdfLxm5z3Hq6NfbjYZUUmz0XhVs6NZgIsWkIrC5pGfAsIfOqqkYQC2OxzjOMPoGf1rHfr/OeRsmefwhaxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(508600001)(54906003)(33656002)(316002)(110136005)(186003)(2906002)(86362001)(4326008)(38070700005)(52536014)(38100700002)(55016002)(8676002)(26005)(53546011)(8936002)(4744005)(6506007)(9686003)(122000001)(5660300002)(66946007)(7696005)(76116006)(66446008)(83380400001)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGs3OUx1VmJTdmdsbGN2b2R2M21MaWhYanhsZkVHaFFja3FRSE1zcmJjNlV3?=
 =?utf-8?B?elFKdkc1QVRRN21zUWpVNmx0TzRPbXVhZ0VRUFAvZGxCRVJRRGlianQ3ZVJB?=
 =?utf-8?B?UlJXTFdrMVVRVFBERDI0L1ZTdEJ4WldQVkVUVnYzZFZtcVFNbVgycWZSY2Nh?=
 =?utf-8?B?RktVZ0lQNmhYZEloSDBraHZ3RjJFTUVCN2loMnMwbGZFeFFubTFZZEVEL0VP?=
 =?utf-8?B?VXRaZUl0QVJCS200MXNqa0lSYjhmU1poYzlTc3dWd0FQNzFydWxDUGRqeDdG?=
 =?utf-8?B?Z3gxY3BYVWpIcU43ZEtmVmxMSmRpSHEzVTkvcjYxN0V5VDhlNjRqSElRMW5I?=
 =?utf-8?B?TjQrZi9VU2k0LzJyZExVQW5nTjQ2Y1Z4aGkyWXBxcTdVWmRIeEt4WEZxWExB?=
 =?utf-8?B?c3hpK3VHN3c5YUxyWUgvTURuMDQvTGVNY2ltWTB2K0ZqREU4c1d2d0lWNXhL?=
 =?utf-8?B?WHlPM2gxUVFBRDlIbVJPZ3FQR1MrNkRLb29MSG1YZW4rQmJiMUlFRGlidDVR?=
 =?utf-8?B?MlJSTmdRMnFkQ0QrYlpqY3lsS1dtOTRLcG1DN1BiMjY2amsrNHRZNEJaR0wz?=
 =?utf-8?B?WWp1c1VoTEthRlg5bS8veEs5WU1NLzN1M0JLZUJVeTZ6M2NQZE1BRmJhSE9r?=
 =?utf-8?B?TnNNRERWUmxkQVdmanpTdkVQcG05NFFuWHgxemtxM0J2SHpQb1YxV3VIR1ND?=
 =?utf-8?B?cm5HN2p4dTIxY0hNL2p6aXRrT0NGM1lXYm1TMzFrR09CdU5EWGt4R0szLzFP?=
 =?utf-8?B?QjhPNVBFQW9jRTJGZTFOclVpRjEwSW5xNEJQU3ViMkh4aU5SelVMaVlnOThV?=
 =?utf-8?B?VkN1elFoOGZ0anl0OE1VV2c0eS9HS0VvZ1JpZVUxTGpHeWh1RHljU3d3VFZw?=
 =?utf-8?B?YVlWQXp3T1R3SVMxL1NjZWptWFo2NUhKT0I2V3RvUWlDdjVyMmoxQzJXeW5w?=
 =?utf-8?B?ZGkzTkhoU0QwR3Y5QndrK3pEVUlvV0FhazlHcXpXVGtzQjZzU3hHRFNuZWxK?=
 =?utf-8?B?THdqSkVNOVhkdytZNE9kN2lVb2RpVGpwQklheHF4WHZtQlhCenZaUnU4bGlW?=
 =?utf-8?B?TXhWK3hmT0srZ0hpVlBuRjM3T1JsbnpSRkI5VGRzR2UzZDlDNWVsRU5hb1hO?=
 =?utf-8?B?VmRoUVhKelFSSmJ4ZEdyaFd4VCtiVzVrTnJPREVhOEw0SXdsVFZYS2lVd0hy?=
 =?utf-8?B?b3haK0ozc3BOL3JYRWxzVG9BcGs1dVNRM0xHOUlCN2xDN2ZZL0FOc1puTDN6?=
 =?utf-8?B?aTZsMDJvdEJCSmNtMnVJM20xdlgyNkszSXNSMWQvQUF0RXpsK0ZRbWx6NVcz?=
 =?utf-8?B?UWZrMXVjaGZRWUZFYW1qelFiZitXSFNDOW9iNVNPRjNaWjNLdnM0Z2d3QWM4?=
 =?utf-8?B?R3IvYVdBVjIrWG5KbXRVc0xpMXlETEJUUWZvTHprbWZ2alZieTNHNDBOeFAy?=
 =?utf-8?B?eTV1ajFSRDAxT2tHMXE0ZGlPZG9lY1QzbXVpUVRmaEkrZ1ovUUlKNjI1VGVQ?=
 =?utf-8?B?dzdoMVZtUldaOU1qdmpvRlVLM1Z2ZEtJV0U1UnZuWmZLdFlpYjRtUDlEY29K?=
 =?utf-8?B?VHZ6Y2M1QXk4SXVCa3dYTnh5aVdVaFpTK0tWVG1tblhWdElXYjJkcHEzWWlq?=
 =?utf-8?B?TEQ4Y1U4cEpoQzY0TTZCeVhZdXdmVVpuR3ByMnNKYmZ0ZTZtcmRLb0l6Q0hQ?=
 =?utf-8?B?SFZZeE84WDJCUGR6Um5VQWlQQUVZMXBLYmRySFBCUkd5SU1MSE9jUTVkc2pp?=
 =?utf-8?Q?h7lgsUZt7e7AvFJS9pAy487ifEZtsFOjXCzP6Iv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea80b4a-7159-48a8-884c-08d963a64f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 06:46:59.3771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RiEZDpYc4XT0F9X9kkmDybPLj3/2GRFGNigUfRTP4CtR+GK/wAAZh9LQnJSi5XTguyE4kKE858XlhPr1aEJSQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4982
X-Proofpoint-ORIG-GUID: t1JcqdyZNkA6Q6ust1qCa3dpwWJWqKio
X-Proofpoint-GUID: eRRrve-tp6EsWiJA4LjQDCtkAYdN3RFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200036
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNl
bnQ6IFRodXJzZGF5LCBBdWd1c3QgMTksIDIwMjEgNzoyMSBQTQ0KPiBUbzogWWFuZyBZaW5nbGlh
bmcgPHlhbmd5aW5nbGlhbmdAaHVhd2VpLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+IHByYWJoYWthci5tYWhhZGV2
LWxhZC5yakBicC5yZW5lc2FzLmNvbTsgamljMjNAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIC1uZXh0XSBpaW86IGFkYzogYWRkIG1pc3NpbmcNCj4gY2xrX2Rpc2FibGVfdW5wcmVw
YXJlKCkgaW4gcnpnMmxfYWRjX3BtX3J1bnRpbWVfcmVzdW1lKCkNCj4gDQo+IE9uIFRodSwgQXVn
IDE5LCAyMDIxIGF0IDQ6MTkgUE0gWWFuZyBZaW5nbGlhbmcNCj4gPHlhbmd5aW5nbGlhbmdAaHVh
d2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBZGQgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkgb24g
ZXJyb3IgcGF0aCBpbg0KPiByemcybF9hZGNfcG1fcnVudGltZV9yZXN1bWUoKS4NCj4gDQo+IC4u
Lg0KPiANCj4gPiAgICAgICAgIHJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShhZGMtPmFkY2xrKTsN
Cj4gPiAtICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAg
ICAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShhZGMtPnBjbGspOw0KPiA+ICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgfQ0KPiANCj4gSHVoPyENCj4gDQoNCkhh
ZCB0aGUgc2FtZSByZWFjdGlvbiB3aGVuIGxvb2tlZCBhdCB0aGlzIHBhdGNoLiBMb29rIGF0IHRo
ZQ0KY2xvY2sgbmFtZXMgOikuDQoNCi0gTnVubyBTw6ENCg==
