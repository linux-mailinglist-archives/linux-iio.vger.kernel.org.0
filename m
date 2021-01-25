Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9839130483C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 20:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbhAZFre (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 00:47:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44718 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726215AbhAYJRW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 04:17:22 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10P9GBTt014993;
        Mon, 25 Jan 2021 04:16:21 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-00128a01.pphosted.com with ESMTP id 368ehadq7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 04:16:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XA6346OgcxGnZIBXuZCO9DgtdkMA2cYmUXs61pxX7Acgfzvrnc6msrjy4M4XAwgoizN3U5h7XVuTid9lulk7D3yYEJ7tghD5Fc0jp+Z1nSI/k08t728h//f9tl8LT/hqzs9ZdI5hl7EE4Hl+L6Hx3e/XPvCPhbMPXHsbzxNo1yo6GZCMeRj8u18uEUCPmEn7ZvTI9/q9wZiHnId5gX7PdUwnMz3kXZka53kQ4oBsZVVSsDjRmVL0bGQyRwpna8GFMFN184nO/+vbacriVO5EzAfr4QeamFAnVqNUqycW2aBw4gaZPuDzsAWm414cK4gmV55eXhrl2FFe2gvFc0V5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vUW3FgzmUv3NHcFtLmTnFPjbVSU0CNuQDNM/IC/100=;
 b=TRlJq+AzPaw7qyjduqzc6d/IwjiZhILafX/GLgzAHr8LopNVgmghoJf8/lh8qL6gsv4N/3E/szWy1jOhUQIEqofXXtExDyFFJ/k2BNxpTKXMcErHlT5YrnaN29ncZ3p7CBzghP5Hgx5jo4hUHT5EWeOVFgUAfnyP26Snzm7Ak06v+r2RT5HkaRC9pyG601/TvODzqt9wetHUmoJ51MKTApFT9IgUgOzM9l2eRHzdHmJwo+rUZrx2fzY0Rr4hMOL8MxuWHRvrGJbEsSTprqMOr7JpxSxfvt/yFmJrEbtPzQHB5cx4t0D4Kzs1XUxqXgRmpG4OAOxhVCAGjNq4Fpz27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vUW3FgzmUv3NHcFtLmTnFPjbVSU0CNuQDNM/IC/100=;
 b=2urjZC+DAfIKgPdZZOq6gV25Np7D4JqnTycoltaW1nst8nBlXtOo+5NA1N1SRVsQYQDl3mgHdAgszrTiJUnX5r/bW7EXOthKDZKE1xZ/i7GTfM2qrYDrimn4SjUluECR/K1SNYwWc4CbgLn13bLPbabnrrFJjMuhpsrLYpm90W0=
Received: from CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:74::18)
 by CY4PR03MB3127.namprd03.prod.outlook.com (2603:10b6:910:5a::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 09:16:19 +0000
Received: from CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::1c75:7035:43d8:f03b]) by CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::1c75:7035:43d8:f03b%7]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 09:16:19 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [PATCH 0/4] Fix/Improve sync clock mode handling
Thread-Topic: [PATCH 0/4] Fix/Improve sync clock mode handling
Thread-Index: AQHW7+yvwBAeo8fdc0Cjm2mWkJ3cmao22FAAgAE1aFA=
Date:   Mon, 25 Jan 2021 09:16:19 +0000
Message-ID: <CY4PR03MB2631C3338B5930546C5EB6C399BD9@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210121114954.64156-1-nuno.sa@analog.com>
 <20210124142036.44f7d58f@archlinux>
In-Reply-To: <20210124142036.44f7d58f@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFptRTNZbU0wWkRJdE5XVmxaQzB4TVdWaUxUaGlNREl0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHWmhOMkpqTkdRekxUVmxaV1F0TVRGbFlpMDRZ?=
 =?utf-8?B?akF5TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTlRVek5T?=
 =?utf-8?B?SWdkRDBpTVRNeU5UWXdNemszTnpjNE9UUTNNVE13SWlCb1BTSXdRVzFsZEZo?=
 =?utf-8?B?QmRVMVZUVWQyT0VSRFEyaE1ZbWRVUzNOS1kwMDlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRTJSRTloT0N0MlRGZEJXamw0UlU5VVVIWTNWVTl1TTBWUk5V?=
 =?utf-8?B?MHJMM1JSTkVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRUzloZUdSTlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
x-originating-ip: [2001:a61:25ba:fd01:81d3:5715:13ec:f57a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab476165-36c1-4e01-eb1b-08d8c111e051
x-ms-traffictypediagnostic: CY4PR03MB3127:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3127CB3264676F241CECE59899BD9@CY4PR03MB3127.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x7OitV+YBttznCyiUU3DNqainZTjqpKweZ4ehTKUUhFxY6Iz5MhQrJZNJsb/VjSAjNPx0sjTpMryaeruQH+a1WYGOjX1HJK+apeOKeOaJwd4T7KlZdPk5aMk26Pe/iruN/tWNuxw13b8VGlIQqjTpoalGciCxz0EBE8lFY857SpDRUvjUA8jdsAIvrvIaZlnvv88C8E+432JQF7OV17NWjiWPBR3y65Wz7qAYUmP0s/cnuwR/kxqfXeJVZ/KvdRq5ft4VfQv6X8HbszBHV5kKQgs28hdzKrso8bQcn6uRY/eqgAw1stxCgWwmQ3AJoOnf6rBbkraJf2ftno78FtPp9NOYbGKtKIOyQ4gSKO6/x3h0yam1YQfkKZ59QIBVeH42A9f3ykX0IHQTHkpzCfaLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2631.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(66946007)(76116006)(2906002)(52536014)(6916009)(7696005)(66476007)(66446008)(64756008)(66556008)(86362001)(54906003)(55016002)(8676002)(107886003)(8936002)(186003)(33656002)(316002)(9686003)(5660300002)(478600001)(6506007)(53546011)(83380400001)(71200400001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?amdJbmJxUG5HTUpUeitBZFVMS3h0cm14UEtvZVZrOVNlc3FXR1BmeWdOWXJp?=
 =?utf-8?B?SGo2bDBPMWdRc3MycVd3ekI3ejlPeVN1a090Qy9DWFVONkZLVzN6eXdiZWVW?=
 =?utf-8?B?L0JQOXFtNWlxZGRZQlcrTmo2R1VaUTBidWQwWm0rVmVXZW9paGlYUzMzWGdQ?=
 =?utf-8?B?ZTY3WTdBVmZGM1UyNndZNk0xZGQ3R3J0T0hmb3pjN00xRUp4TzZCbDVzc1ho?=
 =?utf-8?B?T1VZWWlJRG00VElqdkRrSnF4cTlVV0FPZFRRSjNpNlFBWWx4UHF2c3RBcGQz?=
 =?utf-8?B?Mm05bjhXVnUrZ1BLRDI3eThYZnhVTVpUT3hIZWFUYUwxc3FZVmJ6blFkQVIr?=
 =?utf-8?B?cExBaGhkbFdQRnlJRExJSkdvTGlRb2tSTVkxeTAwM0o0NjkvMGdQL1BWOFVG?=
 =?utf-8?B?NitlNklacjNjTFhzblNqblVvZWRpelBpYVZkaWlQYTZoS0IyaTdwcVl2YWpZ?=
 =?utf-8?B?NElTd1A3YnluZkFWcW1pV3ZjMFBjbVE3VlV6ZlZhVHY1RVl3STBvRno3V3Yw?=
 =?utf-8?B?UUpsalZCUlltTVRxQXBzMzgzaWhkMElNVXFFN29zWXNBRTRvVGhwWDJvUkts?=
 =?utf-8?B?K3A3Vi9ZLzJUZ3ovZXZMQkI2VDA1RVJ4amcvNHNYZUZoZHRpSlZESFpNT3N2?=
 =?utf-8?B?Tm9wWHFGQ3RVN2k5clovYXNIOGtydkhRMlF5N01oZDRqOW5HMGhWaXNvdVpU?=
 =?utf-8?B?T05xMFZseG5Sb001Q2FPWExudUlVaDlSYUx0eDFwT0l4NkFFcFM1WjZ6Mnl5?=
 =?utf-8?B?by9TcFh2TXJ5cmhQQlpRQzA2bjRUZDUxYjk4ZmdXVTc4a2lZa1ZxNkloT0FV?=
 =?utf-8?B?ODRBSXNvTGQvamorUXlDY0NLTndmYVBmcUVUaHlWZGozSUNvSnJUZGNNN1JF?=
 =?utf-8?B?WGc2cmR6VlN3Q2srbmlhb2crOE9HclhzSnRjamszWmlDNDg0NlMzUVdpdkdm?=
 =?utf-8?B?VC9UVG4wczRFaGVOR0t4b2J5STBaYnhYNk1xTW1VZGJoc29GVEowM1hwMnFT?=
 =?utf-8?B?a2ZaS01pVERkcW5RSTJyL0laRFlkMEd0UnZQWE0zdWRPbEpaY3B3VTZUOWtD?=
 =?utf-8?B?Y2RKbE10TmlpVzArR05QT3k3aCtneWRWSTZwSCtQbXQyRHdpOGJwNzFmY3ZI?=
 =?utf-8?B?WEM0eFptWnozTTR5NjRQQWgwWkdYVXAzbGQzS2dTT0Q4Y2FuamZPUmZoNSsv?=
 =?utf-8?B?UFQ5UjJLOHoxandQaVhlY0Y5czZZNEo2K2g3cWNWTGJKWWV6OUEvUlltMytv?=
 =?utf-8?B?VFVXaXZKTnczTG5ldkh2ay9NcUdkY1ZzM2cveG0rOFdoVXJuazVXSXkvN1RP?=
 =?utf-8?B?eHJtclhScDQzdk9FeHFuLzZVUEdyMkhvNHBRc2JPRHJ2WFBGRDVNSVlrWTdK?=
 =?utf-8?B?ZHVvZGxkSmI4ejlDak9TQlIvY0ZrV1l3NnBERUpOaEVLejh4UW9sWmZWb2Qw?=
 =?utf-8?B?N1I1UTFKdDU3cldrMWZMZGlWYkFqNllNR01XNGJiQ2YwdG5jdENwQjZOcU9i?=
 =?utf-8?Q?7/b9njN7zDj4XcSzhRFgRZmYdiR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2631.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab476165-36c1-4e01-eb1b-08d8c111e051
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 09:16:19.2456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nAulmWGSsMlqKw7QsAVFVe3laqTE7WO8qVmiUggdXisDRf7AZMygMV8NlPwowUXSclns2xaruIHk6mAz2Sevw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3127
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_03:2021-01-22,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250056
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBKYW51YXJ5IDI0LCAyMDIxIDM6
MjEgUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENjOiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgUm9iDQo+IEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IFBldGVyIE1lZXJ3YWxkLVN0YWRsZXINCj4gPHBt
ZWVyd0BwbWVlcncubmV0PjsgTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+Ow0K
PiBIZW5uZXJpY2gsIE1pY2hhZWwgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBBcmRl
bGVhbiwNCj4gQWxleGFuZHJ1IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAwLzRdIEZpeC9JbXByb3ZlIHN5bmMgY2xvY2sgbW9kZSBoYW5kbGlu
Zw0KPiANCj4gDQo+IE9uIFRodSwgMjEgSmFuIDIwMjEgMTI6NDk6NTAgKzAxMDANCj4gTnVubyBT
w6EgPG51bm8uc2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoZSBmaXJzdCBwYXRjaCBp
biB0aGlzIHNlcmllcyBpcyBqdXN0IGEgc2ltcGxlIGhlbHBlciB0byBsb2NrL3VubG9jaw0KPiA+
IHRoZSBkZXZpY2UuIEhhdmluZyB0aGVzZSBoZWxwZXJzIG1ha2UgdGhlIGNvZGUgc2xpZ2h0bHkg
bmVhdGVyDQo+IChJTUhPKS4NCj4gPg0KPiA+IFRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBpbnRyb2R1
Y2VzIGNoYW5nZXMgaW4gdGhlIHNhbXBsaW5nIGZyZXF1ZW5jeQ0KPiA+IGNhbGN1bGF0aW9uIHdo
ZW4gc3luYyBzY2FsZS9wcHMgbW9kZXMgYXJlIHVzZWQuIEZpcnN0LCBpdCdzIGltcG9ydGFudA0K
PiA+IHRvIHVuZGVyc3RhbmQgdGhlIHB1cnBvc2Ugb2YgdGhpcyBtb2RlIGFuZCBob3cgaXQgc2hv
dWxkIGJlIHVzZWQuDQo+IExldCdzDQo+ID4gc2F5IG91ciBwYXJ0IGhhcyBhbiBpbnRlcm5hbCBy
YXRlIG9mIDQyNTAgKGUuZyBhZGlzMTY0OXggZmFtaWx5KSBhbmQNCj4gdGhlDQo+ID4gdXNlciB3
YW50cyBhbiBvdXRwdXQgcmF0ZSBvZiAyMDBTUFMuIE9idmlvdXNseSwgd2UgY2FuJ3QgdXNlIHRo
aXMNCj4gPiBzYW1wbGluZyByYXRlIGFuZCBkaXZpZGUgYmFjayBkb3duIHRvIGdldCAyMDAgU1BT
IHdpdGggZGVjaW1hdGlvbg0KPiBvbi4NCj4gPiBIZW5jZSwgd2UgY2FuIHVzZSB0aGlzIG1vZGUg
dG8gZ2l2ZSBhbiBpbnB1dCBjbG9jayBvZiAxSFosIHNjYWxlIGl0IHRvDQo+ID4gc29tZXRoaW5n
IGxpa2UgNDIwMCBvciA0MDAwIFNQUyBhbmQgdGhlbiB1c2UgdGhlIGRlY2ltYXRpb24gZmlsdGVy
IHRvDQo+IGdldA0KPiA+IHRoZSBleGFjdCBkZXNpcmVkIDIwMFNQUy4gVGhlcmUgYXJlIGFsc28g
c29tZSBsaW1pdHMgdGhhdCBzaG91bGQgYmUNCj4gPiB0YWtlbiBpbnRvIGFjY291bnQgd2hlbiBz
Y2FsaW5nOg0KPiA+DQo+ID4gICogRm9yIHRoZSBkZXZpY2VzIGluIHRoZSBhZGlzMTY0NzUgZHJp
dmVyOg0KPiA+ICAgICAgLSBJbnB1dCBzeW5jIGZyZXF1ZW5jeSByYW5nZSBpcyAxIHRvIDEyOCBI
eg0KPiA+ICAgICAgLSBOYXRpdmUgc2FtcGxlIHJhdGU6IDIga1NQUy4gIE9wdGltYWwgcmFuZ2U6
IDE5MDAtMjEwMCBzcHMNCj4gPg0KPiA+ICAqIEZvciB0aGUgYWRpczE2NDl4IGZhbWlseSAoYWRp
czE2NDgwIGRyaXZlcik6DQo+ID4gICAgIC0gSW5wdXQgc3luYyBmcmVxdWVuY3kgcmFuZ2UgaXMg
MSB0byAxMjggSHoNCj4gPiAgICAgLSBOYXRpdmUgc2FtcGxlIHJhdGU6IDQuMjUga1NQUy4gIE9w
dGltYWwgcmFuZ2U6IDQwMDAtNDI1MCBzcHMNCj4gPg0KPiA+IEknbSBub3QgMTAwJSBjb252aW5j
ZWQgb24gaG93IHRvIGhhbmRsZSB0aGUgb3B0aW1hbCBtaW5pbXVtLiBGb3INCj4gbm93LA0KPiA+
IEknbSBqdXN0IHRocm93aW5nIGEgd2FybmluZyBzYXlpbmcgd2UgbWlnaHQgZ2V0IGludG8gdHJv
dWJsZSBpZiB3ZSBnZXQNCj4gYQ0KPiA+IHZhbHVlIGxvd2VyIHRoYW4gdGhhdC4gSSB3YXMgYWxz
byB0ZW1wdGVkIHRvIGp1c3QgcmV0dXJuIC1FSU5WQUwgb3INCj4gPiBjbGFtcCB0aGUgdmFsdWUu
IEhvd2V2ZXIsIEkga25vdyB0aGF0IHRoZXJlIGFyZSBBREkgY3VzdG9tZXJzIHRoYXQNCj4gPiAo
Zm9yIHNvbWUgcmVhc29uKSBhcmUgdXNpbmcgYSBzYW1wbGluZyByYXRlIGxvd2VyIHRoYW4gdGhl
IG1pbmltdW0NCj4gPiBhZHZpc2VkLg0KPiANCj4gU28gdGhlIG9wZW5pbmcgcXVlc3Rpb24gSSdk
IGhhdmUgaGVyZSBpcyBob3cgY3JpdGljYWwgaXMgdGhlIGFjdHVhbA0KPiB1c2Vyc3BhY2Ugc2Ft
cGxpbmcgcmF0ZSB0byB5b3VyIHVzZXJzPyAgIE9mdGVuIHRoZXkgZG9uJ3QgbWluZA0KPiBnZXR0
aW5nIGEgbGl0dGxlIG1vcmUgZGF0YSB0aGFuIHRoZXkgYXNrZWQgZm9yIChzYXkgMjAwLjVIeiB3
aGVuIGFza2luZw0KPiBmb3IgMjAwKSBhbmQgY2FuIGFsd2F5cyByZWFkIGJhY2sgdGhlIGF0dHJp
YnV0ZSBhZnRlciB3cml0aW5nIGl0IHRvDQo+IGRpc2NvdmVyIHRoaXMgaGFzIGhhcHBlbmVkLg0K
DQpXZWxsLCBob25lc3RseSBJJ20gbm90IHJlYWxseSBzdXJlIGhlcmUuIEkgY2FuIGp1c3Qgc2F5
IChmcm9tIHRoZSBpbmZvIEkgZ290IGludGVybmFsbHkpIHRoYXQgc29tZQ0KdXNlcnMgYXJlIHJl
YWxseSB1c2luZyB0aGVzZSBwYXJ0cyB3aXRoIGEgZGF0YSByYXRlIGxvd2VyIHRoYW4gdGhlIGFk
dmlzZWQuIEhvd2V2ZXIsIEknZCBzYXkNCnRoYXQgdGhpcyB3b3VsZCBkZXBlbmQgb24gdGhlIHVz
ZSBjYXNlLiBGb3Igc29tZSBjcml0aWNhbCBjYXNlcywgSSB3b3VsZCBleHBlY3QgdGhhdCB1c2Vy
cyByZWFsbHkNCndhbnQgdG8gaGF2ZSBhbiBleGFjdCBzYW1wbGUgcmF0ZS4gVGhvdWdoIEknZCBh
cmd1ZSB0aGF0IGluIHRob3NlIGNhc2VzLCB0aGV5IHNob3VsZCBrbm93IHdoYXQNCnRoZXkgYXJl
IGRvaW5nIGFuZCBwcm92aWRlIGFuIG91dHB1dCByYXRlIHRoYXQgZml0cyBuaWNlbHkgKG11bHRp
cGxlIG9mIGJvdGggdGhlIGlucHV0IGNsb2NrIGFuZCBJTVUNCmludGVybmFsIHNhbXBsZSByYXRl
KS4gQW5kIGFzIHlvdSBzYWlkLCB0aGV5IGNhbiBhbHdheXMgcmVhZGJhY2sgdGhlIHZhbHVlIHRv
IGNoZWNrIGlmIHRoZXkgYXJlDQpnZXR0aW5nIHNvbWV0aGluZyB0aGF0IGlzIG5vdCByZWFsbHkg
d2hhdCB0aGV5IGV4cGVjdC4uLg0KDQo+IEFzIHN1Y2gsIG9uY2UgeW91J3ZlIGRpc2NvdmVyZWQg
dGhhdCB2YWx1ZSBkb2Vzbid0IGhhdmUgYW4gZXhhY3QNCj4gbWF0Y2gsIHBlcmhhcHMgdHdlYWsg
dGhlIG91dHB1dCBkYXRhIHJhdGUgdW50aWwgaXQgZml0cyBuaWNlbHk/DQoNCkkgZGlkIHRob3Vn
aHQgYWJvdXQgdGhpcy4gVGhlIHJlYXNvbiB3aHkgSSBkaWRuJ3Qgd2VudCBmb3IgaXQgaW4gdGhp
cyBmaXJzdCB2ZXJzaW9uIGlzIGJlY2F1c2Ugb2YgdGhvc2UNCndobyBzZWVtcyB0byByZWFsbHkg
d2FudCB0byBydW4gdGhlIHBhcnQgYXQgbG93ZXIgcmF0ZXMuIExldCdzIGFzc3VtZSB3ZSBoYXZl
IGFuIGlucHV0IGNsb2NrIG9mDQoxSFogYW5kIHNvbWVvbmUgd3JpdGVzIGFuIG91dHB1dCByYXRl
IG9mIDMwMDBTUFMuIFRoZSBvbmx5IHdheSB0byBhY2NvbXBsaXNoIHRoaXMgaXMgdG8gc2V0DQpz
eW5jX3NjYWxlIGF0IDMwMDAgYW5kIGxldCB0aGUgSU1VIHJ1biBhdCAzMDAwU1BTIHdpdGggZGVj
aW1hdGlvbiBvZmYgKERFQ19SQVRFPTApLiBJZiB3ZSBhcmUNCmdvaW5nIHRvIHR3ZWFrIHRoZSBv
dXRwdXQgcmF0ZSB0byBmaXQgbmljZWx5LCB3ZSB3b3VsZCBoYXZlIHRvIGZvcmNlIGl0IHRvIDQw
MDBTUFMgd2hpY2ggaXMNCnNpZ25pZmljYW50bHkgZGlmZmVyZW50IGZyb20gdGhlIGRlc2lyZWQg
MzAwMFNQUy4NCg0KPiBBIGJpdCBvZiBxdWljayBpbnZlc3RpZ2F0aW9uIHN1Z2dlc3RzIChieSBt
eSB3aWZlIHdobyBoYXBwZW5lZA0KPiB0byBiZSBzYXQgYWNyb3NzIHRoZSByb29tKSBzdWdnZXN0
cyB0aGF0IHlvdSBoYXZlIGEgaGlkZW91cyBzZXQNCj4gb2YgbG9jYWwgbWluaW1hIHNvIHlvdXIg
YmVzdCBiZXQgaXMgdG8gYnJ1dGUgZm9yY2Ugc2VhcmNoDQo+IChub3QgdGhhdCBiYWQgYW5kIHdl
IGRvbid0IGV4cGVjdCB0byBjaGFuZ2UgdGhpcyBhIGxvdCEpDQoNCkhtbSwgbm90IHN1cmUgd2hh
dCBkbyB5b3UgaGF2ZSBpbiBtaW5kIGhlcmUgOik/DQoNCi0gTnVubyBTw6ENCg0KPiA+DQo+ID4g
VGhhdCBzYWlkLCB0aGUgcGF0Y2ggZm9yIHRoZSBhZGlzMTY0ODAgZHJpdmVyIGlzIGEgZml4IGFz
IHRoaXMgbW9kZSB3YXMNCj4gPiBiZWluZyB3cm9uZ2x5IGhhbmRsZWQuIFRoZXJlIHNob3VsZCBu
b3QgYmUgYSAic2VwYXJhdGlvbiIgYmV0d2Vlbg0KPiB1c2luZw0KPiA+IHRoZSBzeW5jX3NjYWxl
IGFuZCB0aGUgZGVjX3JhdGUgcmVnaXN0ZXJzLiBUaGUgd2F5IHRoaW5ncyB3ZXJlDQo+IGJlaW5n
IGRvbmUsDQo+ID4gd2UgY291bGQgZWFzaWx5IGdldCBpbnRvIGEgc2l0dWF0aW9uIHdoZXJlIHRo
ZSBwYXJ0IGNvdWxkIGJlIHJ1bm5pbmcNCj4gd2l0aA0KPiA+IGFuIGludGVybmFsIHJhdGUgd2F5
IGxvd2VyIHRoYW4gdGhlIG9wdGltYWwgbWluaW11bS4NCj4gPg0KPiA+IEZvciB0aGUgYWRpczE2
NDc1IGRyaXZlcnMsIHRoaW5ncyB3ZXJlIG5vdCByZWFsbHkgd3JvbmcuIFRoZXkgd2VyZQ0KPiBq
dXN0DQo+ID4gbm90IG9wdGltYWwgYXMgd2Ugd2VyZSBmb3JjaW5nIHVzZXJzIHRvIHNwZWNpZnkg
dGhlIElNVSBzY2FsZWQNCj4gaW50ZXJuYWwNCj4gPiByYXRlIG9uY2UgaW4gdGhlIGRldmljZXRy
ZWUuIENhbGN1bGF0aW5nIHRoaW5ncyBhdCBydW50aW1lIGdpdmVzIG11Y2gNCj4gPiBtb3JlIGZs
ZXhpYmlsaXR5IHRvIGNob29zZSB0aGUgb3V0cHV0IHJhdGUuDQo+ID4NCj4gPiBOdW5vIFPDoSAo
NCk6DQo+ID4gICBpaW86IGFkaXM6IGFkZCBoZWxwZXJzIGZvciBsb2NraW5nDQo+ID4gICBpaW86
IGFkaXMxNjQ4MDogZml4IHBwcyBtb2RlIHNhbXBsaW5nIGZyZXF1ZW5jeSBtYXRoDQo+ID4gICBp
aW86IGFkaXMxNjQ3NTogaW1wcm92ZSBzeW5jIHNjYWxlIG1vZGUgaGFuZGxpbmcNCj4gPiAgIGR0
LWJpbmRpbmdzOiBhZGlzMTY0NzU6IHJlbW92ZSBwcm9wZXJ0eQ0KPiA+DQo+ID4gIC4uLi9iaW5k
aW5ncy9paW8vaW11L2FkaSxhZGlzMTY0NzUueWFtbCAgICAgICB8ICAgOSAtLQ0KPiA+ICBkcml2
ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMgICAgICAgICAgICAgICAgICAgfCAxMTAgKysrKysrKysr
KysrLS0tLQ0KPiA+ICBkcml2ZXJzL2lpby9pbXUvYWRpczE2NDgwLmMgICAgICAgICAgICAgICAg
ICAgfCAxMjAgKysrKysrKysrKysrKy0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvaWlvL2ltdS9h
ZGlzLmggICAgICAgICAgICAgICAgICB8ICAxMCArKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDE3
OCBpbnNlcnRpb25zKCspLCA3MSBkZWxldGlvbnMoLSkNCj4gPg0KDQo=
