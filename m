Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B673F291D
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhHTJaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 05:30:11 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:50984 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235201AbhHTJaK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 05:30:10 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JK2ml8020324;
        Fri, 20 Aug 2021 05:29:18 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahk6ypc3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 05:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzWRVZh2g2wrGI8sStOguh+oL2iVIORH4H00sts1qFUuB+RAmvRnqbMyGMQD8SL0oX8bZQCuJ9G8As1kdSXO5U+Uffn3BOm++WvS5L8lp2uEQB8e35jiTpJGN559+CMYVh1JFeFgRff33XcXeYd6+VEvfhEURDrCl2q+d9Kdsa/IfuYKHsS1ojpHltacKQNv/oF9o0N93LiyLk0NY2U9eshsCF3bxlkHFzc6UcUi+buifEq6X/u0Pa0whY4AztSxHgw5JSBb53fgO/PEMGHYxKcydQRvB1UW1bGH3oKWq2rQlvzbSVN/ZvS+E0vPKAwCw/CroAcsMOCVrY/1KcDJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhLLnu7qt7ZHrLwozHejPMOuZTcWfn4O00UHPZn5H9w=;
 b=BTFQqPeVuL4fLs1fSx/8wRm3aGjiPafuD5j2DHJjneTiHibSHbD295wiebWIepAI3PIf3khHL+JK+969O8vTKeAJqLjKyCPJQnwNFedyoBQL9aytz+sryb+JlwcV6bLoW+lghMrWg3DfrqNSMO35MfF93ulLf2EDZWdq+qsKF+lE32nxfWYbLbwXrDUlYGYENavh7nUUSv8uQpnlzL6ZN1EyttP7OyQe6FIjwLfR6YVSASpfvYCd/4wFuxPOT+DkTDjfqB0i7JXxrqvGCgoq6zAxp0PmK0/hdRwW4mvqXagiAHKefWgOokKfgNJaupIbW7Cb+8tGZvDAsvQpfcdMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhLLnu7qt7ZHrLwozHejPMOuZTcWfn4O00UHPZn5H9w=;
 b=KC0lZWWKB6jW/jvTr3PAYD8LScgNKHPxe9zWZh/ItTlzu3kSIxqRRvHNdocQVVCWhlywq+hhYC9qjc4pz1EHMz89E+EQCq1eQ7jlUX4KmufOlxmG/7O5yCXXkZWFjOCnA7mqPYr7YArWmWvQd8KJUrxbNYoTBsMq8dgZlIPHkxM=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB3829.namprd03.prod.outlook.com (2603:10b6:a03:67::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 09:29:17 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 09:29:17 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Subject: RE: [PATCH 1/2] iio: ltc2983: add support for optional reset gpio
Thread-Topic: [PATCH 1/2] iio: ltc2983: add support for optional reset gpio
Thread-Index: AQHXlZAEw8Cp9hamfE+zlTHLEe4sGqt8DZ2AgAASExA=
Date:   Fri, 20 Aug 2021 09:29:16 +0000
Message-ID: <SJ0PR03MB6359B7B5B7BF6975590879EC99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210820065535.6994-1-nuno.sa@analog.com>
 <CA+U=Dso61XreVxxz8a3cSO+LJrdQAJAi--3Nuv5nRG=buuVCcQ@mail.gmail.com>
In-Reply-To: <CA+U=Dso61XreVxxz8a3cSO+LJrdQAJAi--3Nuv5nRG=buuVCcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1UUTVZMkV6WVdVdE1ERTVPUzB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhERTBPV05oTTJJd0xUQXhPVGt0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpZNU9T?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNalV6TlRNNU1qTXlPVEEzSWlCb1BTSjNUR1ZHSzJK?=
 =?utf-8?B?a2MzQndTV3RUWkd4alQwUmFjelpGYWtGV2VUZzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTk1NMUJVVjNCYVdGaEJaRzlYVTBsalRXWkVaVVl5YUZwSmFI?=
 =?utf-8?B?ZDRPRTQwVlVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 32ff48c9-c9a4-45d2-6901-08d963bcfb4a
x-ms-traffictypediagnostic: BYAPR03MB3829:
x-microsoft-antispam-prvs: <BYAPR03MB382906C10486D8CF95C819EF99C19@BYAPR03MB3829.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BmfMavxbVXuBCLDsqyfXTFPF4Kfe5y2Q5VngfeyycKdn0xldVQk72C+52eov2ZM27Qm0U6ipbhWHWlZ3Cooih0xoxunewi2SN54k5FNvItRyzKHxOOVLfzkzd7PLgnXlaqxePQ8jz1LefPyMjRVsdkUEfnXlB4+tZqeDleT/KmyY5h8tVjq/3lXR52wkox6uSlkF/RB6hCq80FyVTsR+IfReVoS1FMVmf3COIbvJOJ8PLgwlnn04q79aObVKSoST0Onhjh56YhkQPi4F91RvRVEo1VZge+RQSx1AxBtlzIF4IkprXICQe60YMo1czUMa7XQZwD5XxEtwyWQOtgId4jtg0LZsOgdl78mbPxafJyfmze1KNgweLOdwfEgdWQgvKJYApAR36B5X2Cuh7tsJ2E2G9Z9QjC+s7wUbWbbffTe3i1vvVNPD5yii6J3NkwKPWpEV2OHNL2NnzqwMC05c8MLFRvdeAHEZns2Ehi51EJvitZb2nJTSAhFJ5nI0PwfMNEhTVNEpr1yxL2de3bOA8pID0xTKgTgOIHd0HepBq02o/wGqMP3Eq6AwurwAwmjX3rl4NPKpxs09MUybwAZTuDk4s6el9ap4yXXn0Az4guNLRgnamaj4rXExzlC6ELzbN2zM8SA5KxI5gPA2aILJF9/T3q48EnYFI7LkExCgLE0BAyin23zHCUODS7QS9K6cu1mtC2YZGSmCBXnJVX4N4mAaPucVFIxI2DK0wdoUiNy0rWqRxGg204+qQHgermCdUkXfCUeTftdqLpxT1lVyz42soZJi5s0ux4Osv5exA1E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(9686003)(7696005)(8936002)(6916009)(83380400001)(5660300002)(8676002)(33656002)(38070700005)(55016002)(71200400001)(2906002)(52536014)(64756008)(66476007)(54906003)(122000001)(66556008)(66446008)(66946007)(86362001)(76116006)(4326008)(966005)(478600001)(6506007)(316002)(38100700002)(53546011)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTN1Y0ZxVnNXRTlaWWhyZFd4UGs5L0wxSndHV0wrbi9PUXZJb2U4aFl2ek5y?=
 =?utf-8?B?NjYwcGl3UGpYcEl1V05JRTNVTy9GK2V6aEZYUVRmQzdjUHpSUGpIZjE0UGo2?=
 =?utf-8?B?QW9EYlM1Nzl0VVNJT29HUGh4ZjZPaGllZC9obGVLVFpLZEZraTlLV25qNDZV?=
 =?utf-8?B?S0VVWHgwb2FOTGZjdW5KSEx4N0hnUmNBV0NqeU9UdmQ4NXNKNkluTzJDMFFm?=
 =?utf-8?B?Um5IRVNwZ291eE1OckNUaEZtdGxIYmZTN29tUnJGNHdkSEtXVFFuRjZ4b0pI?=
 =?utf-8?B?NGRjUnhqUXRrbHBZS3FqeENCVncxZEFXVUQ5UG5MWms3TFhUOVQvYzQ2S1FP?=
 =?utf-8?B?N0tUOXJpZEJ0WE9BT0xsMjZReHNHWVFHaUthOGNuVTZ5Q2hrSEVGOTIrYk1D?=
 =?utf-8?B?NmQ2RmdkOGFJOFplWE1JeGJjaUZqWkliVEZHMjlLUFVPWVBXdG5oMDlCV2VU?=
 =?utf-8?B?ZmNLK3BKQ29HZy93SElWNm0xd0FPZTJ3UFR0Y2ZIb1VUSm1sV0FHd0Y3clJh?=
 =?utf-8?B?a21KWWNOdzBMWlVHVkxMUll3ajNndW9rcnIvRHZObzZKV1lTNCtvSUc2U0xm?=
 =?utf-8?B?eWFMNGJUZk54a1FRQkFQaklhK0tFV0xpSHdkSlRKSm1BZ0VSTXZaSU1PYXZC?=
 =?utf-8?B?TVZWN1JEK3ZHOWE2V0VpUFN3dHl6dWZhWmV2cFN5eGpKeGtvRHJGS0pwUHZy?=
 =?utf-8?B?TFBCQ2JGbGZsaURZaWVLdGcyMVJrVDZPSzdMcXZYVzdRUnpseTVuVElvcnkx?=
 =?utf-8?B?WDJIUDU4Ym41aklyMDFDY2ZBTStCVXBYRFhNNk1ZWm1aUW9XUEZIUmRwZTk3?=
 =?utf-8?B?dUxiUDEzZTNQZjlCWUdrMHN4cDVzQ1JYb05aWWE0amdiU2llMllRQzNpTmFy?=
 =?utf-8?B?TXJ3YTU3MWlpWVlVOVpvV20xZ0JLcVhUNlNicWc1VEM5R21mOHNCaE5PYnpm?=
 =?utf-8?B?ekVQQW9EK3hmV2RZQzYyVG9GaTA5bDJMdlJCSW1YUzRNL1R5Q3JXbVBIbVo4?=
 =?utf-8?B?T2ZRSkoyT0lSaTBqTUFlOERISWRzb0VsRzdkU3pMTmRXRDNHNjFjSEw0OWVp?=
 =?utf-8?B?THBZdGVzYjR1N0JERHVIR00xemdVc254cGJDb2VHUGNSQ0pFNm85cENXWitp?=
 =?utf-8?B?OTRPOXcxc0FuZmErRWUyamo2bU01SUZxY1JKelJ2OVBaTTRKdFRtdVhDMjlR?=
 =?utf-8?B?Ti91bDA4V2lNSlNBUm40eVhiNzNYQnJCbE5DdXlZeHF4VHFRUElFT2V5V3hL?=
 =?utf-8?B?aE8yMHRIeDNzNm5rYXVENUt5TWtvYmlObURKTHpxZDlaQ05xSWVoZnpUZjNT?=
 =?utf-8?B?c0JpckxESTg5L1M4ZnczSVNzWW1MZzJBbWY2by90akJCMm02SEVqYU9GaHZQ?=
 =?utf-8?B?SG5QTDNUbDgwMTE3elgxSmNPUFRLdldwQkZDNjRFWUw0WVBSdmpMcXhMN0RG?=
 =?utf-8?B?ekhELy81SnBuSjJSNW5YNXl1VHRvM0JCYmUxVXhnN2RBanlOVU14c2QyMm92?=
 =?utf-8?B?MkgrWEpYKzJ4cGQ2eGphdTNKYWQydnRTRHZWdE1hT1p0T2V0Uk9VVjVYR2Q3?=
 =?utf-8?B?Lzc3ZDF4NW1mbkZObUlDTG1kRDVGcDJrRW9XNklQcE9NQlN2NXJkK2FOWmRB?=
 =?utf-8?B?RzgvaDhrRXBoSVZ4NFg4N09NUlRjY3lwTnhrU01vcW1RVUdmeEV5SlNhWUZm?=
 =?utf-8?B?c3FOK29PY0hhTTgxa2Z2RUxEVXZmRWVvb2pKcEdxRkVtNUVHbDlZR0VRNUc5?=
 =?utf-8?Q?cSwRTdPadyzNaDe6i+Rytnd2Dc9bK+vhK/cKwCh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ff48c9-c9a4-45d2-6901-08d963bcfb4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 09:29:16.7140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9K0OFb7BYcqGxS9R1PsuNX8TMDcGZCC2Dv13YMJHFrf/bdAVQ8PLQvB3Suxgk0tJwIKiiLTddul3bOj4Yt8XHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3829
X-Proofpoint-ORIG-GUID: in_xNUoyWcK4m8JBQvpiveRb9catHdZ8
X-Proofpoint-GUID: in_xNUoyWcK4m8JBQvpiveRb9catHdZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_03,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200053
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhcmRlbGVhbmFsZXhAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAyMCwg
MjAyMSAxMDoyMSBBTQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gQ2M6
IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IEpvbmF0aGFuIENhbWVyb24N
Cj4gPGppYzIzQGtlcm5lbC5vcmc+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5k
ZT47IERyZXcNCj4gRnVzdGluaSA8ZHJld0BwZHA3LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzJdIGlpbzogbHRjMjk4MzogYWRkIHN1cHBvcnQgZm9yIG9wdGlvbmFsIHJlc2V0DQo+IGdw
aW8NCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIEZyaSwgQXVnIDIwLCAyMDIxIGF0IDk6NTMg
QU0gTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBDaGVj
ayBpZiBhbiBvcHRpb25hbCByZXNldCBncGlvIGlzIHByZXNlbnQgYW5kIGlmIHNvLCBtYWtlIHN1
cmUgdG8NCj4gcmVzZXQNCj4gPiB0aGUgZGV2aWNlLg0KPiA+DQo+IA0KPiBKdXN0IG9uZSBub3Rl
L3F1ZXN0aW9uIGlubGluZS4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8u
c2FAYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vdGVtcGVyYXR1cmUvbHRj
Mjk4My5jIHwgMTEgKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9sdGMy
OTgzLmMNCj4gYi9kcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9sdGMyOTgzLmMNCj4gPiBpbmRleCAz
YjRhMGU2MGU2MDUuLjM3OTAzZTlmYjkwZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby90
ZW1wZXJhdHVyZS9sdGMyOTgzLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9s
dGMyOTgzLmMNCj4gPiBAQCAtMTQ3MCw2ICsxNDcwLDcgQEAgc3RhdGljIGludCBsdGMyOTgzX3By
b2JlKHN0cnVjdCBzcGlfZGV2aWNlDQo+ICpzcGkpDQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVj
dCBsdGMyOTgzX2RhdGEgKnN0Ow0KPiA+ICAgICAgICAgc3RydWN0IGlpb19kZXYgKmluZGlvX2Rl
djsNCj4gPiArICAgICAgIHN0cnVjdCBncGlvX2Rlc2MgKmdwaW87DQo+ID4gICAgICAgICBjb25z
dCBjaGFyICpuYW1lID0gc3BpX2dldF9kZXZpY2VfaWQoc3BpKS0+bmFtZTsNCj4gPiAgICAgICAg
IGludCByZXQ7DQo+ID4NCj4gPiBAQCAtMTQ5NCw2ICsxNDk1LDE2IEBAIHN0YXRpYyBpbnQgbHRj
Mjk4M19wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZQ0KPiAqc3BpKQ0KPiA+ICAgICAgICAgaWYgKHJl
dCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPg0KPiA+ICsgICAgICAgZ3Bp
byA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKCZzdC0+c3BpLT5kZXYsICJyZXNldCIsDQo+IEdQ
SU9EX09VVF9ISUdIKTsNCj4gPiArICAgICAgIGlmIChJU19FUlIoZ3BpbykpDQo+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiBQVFJfRVJSKGdwaW8pOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChn
cGlvKSB7DQo+ID4gKyAgICAgICAgICAgICAgIC8qIGJyaW5nIGRldmljZSBvdXQgb2YgcmVzZXQg
Ki8NCj4gPiArICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDEwMDAsIDEwMDUpOw0KPiA+ICsg
ICAgICAgICAgICAgICBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoZ3BpbywgMCk7DQo+IA0KPiBE
YXRhc2hlZXQgbWVudGlvbnMgdGhhdCBpdCB0YWtlcyB1cCB0byAxMDAgbXMgZm9yIHRoZSBkZXZp
Y2UgdG8gZnVsbHkNCj4gc3RhcnQtdXAuDQo+IEl0IGFsc28gbWVudGlvbnMgdGhhdCB0aGUgKGNv
bW1hbmQpIHN0YXR1cyByZWdpc3RlciB3aWxsIGJlDQo+IHVuYXZhaWxhYmxlIHRvIHRoZSB1c2Vy
IGJlZm9yZSB0aGlzIHBvaW50Lg0KPiBQYWdlIDE2LCBDb252ZXJzaW9uIFN0YXRlIERldGFpbHMg
c2VjdGlvbiwgc2Vjb25kIHBhcmFncmFwaC4NCj4gDQo+IEkgdGhpbmsgdGhlcmUgc2hvdWxkIHBy
b2JhYmx5IGJlIGEgc2xlZXAgaGVyZSBvZiAxMDAgbXMuDQo+IA0KPiBPdGhlciB0aGFuIHRoYXQg
Y2hhbmdlIGxvb2tzIGdvb2QuDQo+IA0KDQpJbiB0aGUgc2V0dXAgZnVuY3Rpb24gd2UgZG8gYSBw
b2xsZWQgcmVhZCBvbiB0aGUgc3RhdHVzIHJlZ2lzdGVyIHVudGlsDQp3ZSBnZXQgdGhlIGluZGlj
YXRpb24gd2UgYXJlIHVwLiBUaGlzIHdhcyBhY3R1YWxseSBhIGZpeCBzZW50IHJlY2VudGx5DQpb
MV0uDQoNClsxXTogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWlp
by9wYXRjaC8yMDIxMDgxMTEzMzIyMC4xOTAyNjQtMi1udW5vLnNhQGFuYWxvZy5jb20vDQotIE51
bm8gU8OhDQoNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gICAgICAgICByZXQgPSBsdGMyOTgz
X3NldHVwKHN0LCB0cnVlKTsNCj4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gICAgICAgICAgICAg
ICAgIHJldHVybiByZXQ7DQo+ID4gLS0NCj4gPiAyLjMzLjANCj4gPg0K
