Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034D245028C
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 11:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbhKOKbw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 05:31:52 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56448 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231142AbhKOKbu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Nov 2021 05:31:50 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AEKmsKO000859;
        Mon, 15 Nov 2021 05:28:54 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ca83a04xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 05:28:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrxdI+Ys9HFrtGkY0sDrHboGk6k0RZisGaBmSMWuJ6shhRn0iNZQrIy5Hi/k1nlkogZupufDflOt7mhKF71wwxlVSOJQdYqA3++Xc2ML/VrqCPYNlkwNKe6PX4BEpJlag2vYr2vljg9cpl3+sZj3lLc+foNYSZmCDnBAaM0E6HgK++wLQj1xLM/v7XLhbQlH4pMgtFwgoM6G6OIQxYOu8ebagdjnOWEtRNIuDgk0OpzCfInGN5jzFuvDhci/PYW0CeVfe5jzhRD1Bpbo7V4qzEK+F0tilO7WIso+iyGw7Qn3zvYZfLp+WA/pIuRlMR6YP20T/6tg5RJUPuvUK4Zq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF4xg5Vq+yA+391eUJ1b1/9GlktWFvkYkezbCMw14lo=;
 b=nOajb5K0itRRQQ/oA02Fn8CtV73ASUHFFTk/7y/G2PnT/wLhH6kedHV8R9T5S65LaL0bQ6+8aLz+++0JuwzujAJS2f9EIkKboqrL6/6DTnk4ELfZ7VFQifwXAuE49mjKSVAXOARGEThxGcm89LwlS+3SkbCL7F2t2KvfPt8jNqrIEeXpGv0FKdVTO+jTdqzaR4YCk0REshQr4AbJnUoBI2i2Dn6c+n2HfFPxPdPmGkKaW+8EDEI0cK3ou2wz4YpjoYFACGDfUvZIQRALe9l8OyGMcoTrbtyBdiu1uPjPkRgTbHn8jTKyo/DDdP4g0fbTWnsrzQ5JT1XKPpghzaXaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF4xg5Vq+yA+391eUJ1b1/9GlktWFvkYkezbCMw14lo=;
 b=cDUHjJyFjg28rCtdaqYITWcD7II3NVQGHAH0r9/sXIwomA8oWcmOUof8/9r2VAHTSWugA5cnCz0G8LGrp1defIgZ73ouO4+03++Kc8hcPWxxzL8d9RMcnxow95rosP2ZDWF+pwi/Z3AnXge86xvyj61TKfKx9wj7EJMkrlvIA9E=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6352.namprd03.prod.outlook.com (2603:10b6:510:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 10:28:51 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73%8]) with mapi id 15.20.4628.022; Mon, 15 Nov 2021
 10:28:51 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [RFC PATCH 0/1] LTC2688 support
Thread-Topic: [RFC PATCH 0/1] LTC2688 support
Thread-Index: AQHX1uthp64f7v0trkGvKxQpqJcVI6wAEu4AgAQrh5A=
Date:   Mon, 15 Nov 2021 10:28:51 +0000
Message-ID: <PH0PR03MB6366BFFE85F122FED1B72BB499989@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211111110043.101891-1-nuno.sa@analog.com>
 <20211112161437.60dbc872@jic23-huawei>
In-Reply-To: <20211112161437.60dbc872@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpERXpaakZsTlRZdE5EVm1aUzB4TVdWakxUaGlPV010WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHUXhNMll4WlRVM0xUUTFabVV0TVRGbFl5MDRZ?=
 =?utf-8?B?amxqTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRFeU1q?=
 =?utf-8?B?SWlJSFE5SWpFek1qZ3hORFExTnpJNE56UTJNekV4TlNJZ2FEMGlVRTVqVjJ0?=
 =?utf-8?B?NmVtdHhUMVl4TlZsWUwxaFFaM1JOWkRNd2RIVkJQU0lnYVdROUlpSWdZbXc5?=
 =?utf-8?B?SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZNVkpUVWxWR1RrTm5W?=
 =?utf-8?B?VUZCUlc5RFFVRkVUREJMWlZSRE9YSllRV1JsWm1SamNsazNWM2RoTVRVNU1Y?=
 =?utf-8?B?bDBhblJpUW05RVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVo?=
 =?utf-8?B?QlFVRkJSR0ZCVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZC?=
 =?utf-8?B?UVZGQlFrRkJRVUZXU1VWMmIxRkJRVUZCUVVGQlFVRkJRVUZCUVVGS05FRkJR?=
 =?utf-8?B?VUpvUVVkUlFXRlJRbVpCU0UxQldsRkNha0ZJVlVGalowSnNRVVk0UVdOQlFu?=
 =?utf-8?B?bEJSemhCWVdkQ2JFRkhUVUZrUVVKNlFVWTRRVnBuUW1oQlIzZEJZM2RDYkVG?=
 =?utf-8?B?R09FRmFaMEoyUVVoTlFXRlJRakJCUjJ0QlpHZENiRUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVGQlFVRkJRVUZuUVVG?=
 =?utf-8?B?QlFVRkJibWRCUVVGSFJVRmFRVUp3UVVZNFFXTjNRbXhCUjAxQlpGRkNlVUZI?=
 =?utf-8?B?VlVGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hkQ01FRklUVUZZZDBJd1FVZHJR?=
 =?utf-8?B?VnBSUW5sQlJFVkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVZGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJXVkZDYTBGSGEwRllkMEo2UVVkVlFW?=
 =?utf-8?B?bDNRakZCU0VsQldsRkNaa0ZJUVVGalowSjJRVWR2UVZwUlFtcEJTRkZCWTNk?=
 =?utf-8?B?Q1prRklVVUZoVVVKc1FVaEpRVTFuUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?Q?BQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78c59fd0-2458-4b44-5623-08d9a822b7f0
x-ms-traffictypediagnostic: PH0PR03MB6352:
x-microsoft-antispam-prvs: <PH0PR03MB6352D5B007C1E56BE6FB245D99989@PH0PR03MB6352.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OMlbMKRZQqzbnln8FENnRibcIUkftdexeqFLg6zI0FZnG+5Ngg+uSWCpmYth9Wcj/uWqY9hfcLd5kpIaY53MV2yWWW2yhPdvSI6Rm8Iusv2fVx1ynp6v0nHAF1orK/Neud0Qb+0afpXNrdzwb5runTgwtWi4NhFIiTc17ZM5jUiaUyl/VjPughZgBlwoHofmr+Y3Yf9um01oj1P9gp9yp5X/yNcVj0tYTKZaB0yEyBY8VnbFKm86cMuv2ZlkSzOhDUwBFimw/LUjYLj+HhfvHZdSbUa6NhlQZYXH8lvnZKLAECAaZSn/HK8LXUjFWDa5bgHz4LmckZmIrSsCI6fJHuI62rS8Hj3VhT6kNjMPiDIojyu1WB8l5lu6Yve4VXCvdfw5A+g4PbKsEBkmdhuG8GiNaE2JoYg1z6cvDszQ5WG6KeKkh2Fs+7WBq/aaoy/1+AcUMn8bFMo/+kfbocFIFGMJAN+wOjipRafXRG2UB4RNPEsNnslxbWlI9lXuynbn7S7w7f/XWn9xpvxw5i/UGYECK2bMboj9n0ZG+16K1LgZ/SwSKsu8ClkWKf1N2kFUQIVuHD/LUzNDBQqvRhD/VfBOUKesqd3N3IVHa1BBJzcw8ZrEWNUW5+Wme6Bl5tMgBpb7CGwo61aq5TAHls98YqS7NwbvfzVtcr7g3NC1ntpQAV7rcBMcOrFq12wp1hpiLKSYUv5RLnp+V+XYJHPPNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(83380400001)(38100700002)(38070700005)(6916009)(186003)(8676002)(316002)(55016002)(122000001)(30864003)(26005)(8936002)(508600001)(53546011)(7696005)(2906002)(86362001)(4326008)(5660300002)(66946007)(6506007)(66556008)(66476007)(71200400001)(64756008)(52536014)(33656002)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW43V0JvRldoNUpTcGlSa2JBeFBmdFFiSitYMlNoSGZaWDRLRFIza3d6MXdH?=
 =?utf-8?B?NFNzbzg1N1dGZXJvbTZ5M0RVRThKdi9ncHdPWEZHcWU4VkI0TUc4eGdOeGNZ?=
 =?utf-8?B?cVdvMUZhdDRxUFlyUjRMWXRMKzIzMEM5ZTk0c080cnRXc1VGLzQxODRSTDU4?=
 =?utf-8?B?bk5rSDI3S1V0RTZEZDdzcEVYT3V2c3JvemtKRnVSZk9CSzdwekF3YmVaMnFy?=
 =?utf-8?B?MG5rSlk4Q040QytIQ3dEWTgxUk5XMUhnbEN5cEoybXJvTFlPQ0k2SGgzU0cy?=
 =?utf-8?B?Z0loUThnUkMzS1hUZ1hKVEFVbVQ4OFlCTEx4OWNXYW1qMnFNU3FNUytkOVdk?=
 =?utf-8?B?OUNyV0FQR1RNN21qNGMvRTRWTTlqUGVpcWRRdTRPOVJNV2pHU1g3cHpDQVFS?=
 =?utf-8?B?TUdNTXRDS21HMlBrWHRJcFhOU0dldmI1MkpRbXdIUFdya1lMMFRFU2ZDeW4w?=
 =?utf-8?B?NzVHVkk5QktFME43czJUL2VUZlVmRWx1MjZhZHlCcWFSY21Qb1pEMnVuVFNp?=
 =?utf-8?B?UHhzLzJ5ZGZNYUR6VC8vbkdOQkhsYi8wNGRBVUw5T0QxYzF5WmVYYmVHa1Q0?=
 =?utf-8?B?cy9jYmhQQ05keXE1OVlSNGQvclBGYVdGWm1BTlZZTjBEWllGWkZ1SWk1aUVT?=
 =?utf-8?B?SElNWlQraU55NndrdmlzbGlVSGtHWS93dEp0UmtRbkVsNFdxUUZuR24xVEVP?=
 =?utf-8?B?T0RWY3pBMEk5dUZqSlVtUEY5a2QrODhZa29ydEZMQ2l1QnYwUjRoNVFkcG5j?=
 =?utf-8?B?dVJkcjdHcmdVVUNWbS9jQ3hnOFpQUVRYS3p2NEVwWWtQeStSL3R3NHp5WDgw?=
 =?utf-8?B?M0xlMTYvZTc2N3VHNGpwVUVMZG5ITnV6cjl2Y21WUFFBSjVycksvY0tuQUN5?=
 =?utf-8?B?azAwTmZpKzZuZm9GL0d2TVVTWFltZHhGVmxHQ25QdlR3cFRJemFHeXh5Wkgw?=
 =?utf-8?B?Q256R0hWRCttNkNwWmhTcFJuQlp5V0xCZjlGMDZZbkV1cVcyN0drZTVBalBL?=
 =?utf-8?B?c3d2M1lSemFrTGUxd3ZLbksvRVRSZ0FHZVhzV05xRlRHTnlQTkNTbzRaNjBG?=
 =?utf-8?B?ZVRHMkRhNHkyQ0RqbkxDenJiSzJWbWRSVVlFM0hHY1NrOHlaZkZXVGt5a0Nk?=
 =?utf-8?B?cHVib0tIZGl5bVcrcWRPVUNpWWVrNnJteXZ4bzdWRkdKaU1Qd0dUeGtHSE1X?=
 =?utf-8?B?QjNhcE84RVNuaHVSMzhRNHFhc3J3Ynk3ZncxbGk5b3M3eGM2Z1pMZGh5MWFK?=
 =?utf-8?B?MDBxZnNtdFBOMm8yUVZTeHlrTXQ0R2sveHhHb25JN3BOL2xGL0hFb2lWVnF3?=
 =?utf-8?B?RzJ6djBlSWxzaW9mWFBScEViRVg1cnZFQTlndkhXeGN2WlpER0ozc2Zub3Fi?=
 =?utf-8?B?c2t4RnNydjR4MnIzeStUSExGZ3hXaHpmZWhCQVozSjJjZE5XeGh1alovRW8z?=
 =?utf-8?B?Y2Vhc3BmbkVJdmg2YVdza1MxMDFvL2UvbUluRmwyakNlTXJNSCtmdkxCaGlq?=
 =?utf-8?B?RDd6OWRKZ1JBQ29iaW1zUk5yVEZ0ZWhrejlmY0xabXRoTUxTQm5BaVJZbGw0?=
 =?utf-8?B?YUFWdkZPOWcvcW5PWWJBZGxGVXg3azUxbjlSKy9PbmxCcTFJNkhMQXpNakZr?=
 =?utf-8?B?ZEdQaWZMS2M1QVVHTTVHVEVYdm11YitYeUcvdktDMDhNZGVwUlJLMlhJQy9E?=
 =?utf-8?B?eWNweGNlTXZnME5zbUdxa0w5dWRwQnFUYlNSS0s0ZmhjQkR0OW8waXR0dGlZ?=
 =?utf-8?B?L1hjMFZTWjZIeEkydmt2dW1DczV6QTUreTBUU1AvdzdKZ3NVQ2J4UUFkVDJr?=
 =?utf-8?B?WnNFODRYaWpIQi9JV2R4RmxGTFRsWHhqK1l3OXFLWDRZZlBtdGU5eTAxVjUx?=
 =?utf-8?B?V21sSTNsQjhZRlE1Wkk1YmF2N2JnL2ZjMk9lcXpQQXhnUzd0LzdseFlhb0cy?=
 =?utf-8?B?NWpkSDZBc0o2czNCZmw1OHpOTTJ3bXpGRkRsVlVMZ3JjcSs2dlZhU2ZWdTZz?=
 =?utf-8?B?Ump5UVI0eEtsQWN4NnpjY1dhSGljenBXOUZDWDlVR0NnelkxM0x0RlkvRHhu?=
 =?utf-8?B?bHY3a3lDd1NnYXJlVWVWNC9CeU40TFM5QXZrNVFReHovUEdiVU9iSmozOVdW?=
 =?utf-8?B?SWYxVGxZOFVINlN3SWFTN2MxK1dMTWxSTjBUUnBUejVqVnZnUXkwamJENksx?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c59fd0-2458-4b44-5623-08d9a822b7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 10:28:51.5801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rZBoF3nErAjS3WB+SKtDYVxIZJ9Cxlqs4b3RW9mqKB93Nik2CKYVpJrc6v9uviMHfx3U2c+8BRluepHQJg92w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6352
X-Proofpoint-GUID: DGv-Xb1bY4kX310lb4CkD-CHfiXCy0sk
X-Proofpoint-ORIG-GUID: DGv-Xb1bY4kX310lb4CkD-CHfiXCy0sk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_09,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150057
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNClRoYW5rcyBmb3IgeW91ciBpbnB1dHMuLi4NCg0KPiBGcm9tOiBKb25h
dGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVy
IDEyLCAyMDIxIDU6MTUgUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+
IENjOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IDAvMV0gTFRDMjY4OCBzdXBwb3J0DQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUaHUsIDEx
IE5vdiAyMDIxIDEyOjAwOjQyICswMTAwDQo+IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+
IHdyb3RlOg0KPiANCj4gSGkgTnVubywNCj4gDQo+ID4gVGhlIHJlYXNvbiB3aHkgdGhpcyBpcyBh
IFJGQyBpcyBiZWNhdXNlIEknbSBzdGlsbCB3YWl0aW5nIGZvciBwcm9wZXIgSFcNCj4gPiB0byB0
ZXN0IHRoaXMgdGhpbmcuIFRoZSByZWFzb24gd2h5IEknbSBzZW5kaW5nIHRoaXMgYWxyZWFkeSBp
cyBiZWNhdXNlDQo+ID4gdGhlcmUncyBzb21lIG5vbiB1c3VhbCBmZWF0dXJlcyB3aGljaCBtaWdo
dCByZXF1aXJlIGV4dHJhIEFCSS4NCj4gSGVuY2UsDQo+ID4gd2hpbGUgd2FpdGluZyBJIHRob3Vn
aHQgd2UgY291bGQgYWxyZWFkeSBzcGVlZCB1cCB0aGUgcHJvY2VzcyBpbg0KPiByZWdhcmRzDQo+
ID4gd2l0aCB0aGUgQUJJLg0KPiANCj4gV2lzZSBtb3ZlIGFzIHRoaXMgaXMgYW4gdW51c3VhbCBi
ZWFzdCA6KQ0KPiANCj4gPg0KPiA+IEkgc3RpbGwgcHVzaGVkIHRoZSBkcml2ZXIgYnV0IHRoZSBp
bnRlbnQgaGVyZSBpcyBub3QgcmVhbGx5IHRvIHJldmlldyBpdC4NCj4gPiBOYXR1cmFsbHksIGlm
IHNvbWVvbmUgYWxyZWFkeSB3YW50cyB0byBnaXZlIHNvbWUgZmVlZGJhY2ssIHRoYXQncw0KPiB2
ZXJ5DQo+ID4gbXVjaCBhcHByZWNpYXRlZCA6KQ0KPiANCj4gPg0KPiA+IE5vdywgdGhlcmUgYXJl
IHRocmVlIG1haW4gaW50ZXJmYWNlcyBkZXBlbmRpbmcgb24gdGhlIGNoYW5uZWwNCj4gbW9kZToN
Cj4gPiAgMSkgZGVmYXVsdCAobm8gbmV3IEFCSSkNCj4gPiAgMikgdG9nZ2xlIG1vZGUNCj4gPiAg
MykgZGl0aGVyIG1vZGUNCj4gPg0KPiA+IFRoZSBjaGFubmVsIG1vZGUgd2lsbCBiZSBhIGRldmlj
ZXRyZWUgcHJvcGVydHkgYXMgaXQgZG9lcyBub3QgcmVhbGx5DQo+ID4gbWFrZSBtdWNoIHNlbnNl
IHRvIGNoYW5nZSBiZXR3ZWVuIG1vZGVzIGF0IHJ1bnRpbWUgZXZlbiBtb3JlDQo+IGJlY2F1c2Ug
dGhlDQo+ID4gcGllY2Ugb2YgSFcgd2UgbWlnaHQgd2FudCB0byBjb250cm9sIHdpdGggYSBjaGFu
bmVsIG1pZ2h0IGJlDQo+IGRpZmZlcmVudA0KPiA+IGRlcGVuZGluZyBvbiB0aGUgc2VsZWN0ZWQg
bW9kZSAoSSdtIGZhaXJseSBzdXJlIG9uIHRoaXMgYmV0d2Vlbg0KPiB0b2dnbGUNCj4gPiBhbmQg
b3RoZXIgbW9kZXMgYnV0IG5vdCBzbyBzdXJlIGJldHdlZW4gZGl0aGVyIGFuZCBkZWZhdWx0IG1v
ZGUpLg0KPiANCj4gSSBhZ3JlZSBvbiB0b2dnbGUgdnMgZGl0aGVyIGRlZmluaXRlbHkgYmVpbmcg
ZGlmZmVyZW50LCBidXQgbm9ybWFsIHlvdQ0KPiBjb3VsZCBpbXBsZW1lbnQgZWl0aGVyIGFzIHNv
ZnR3YXJlIHRvZ2dsZSwgb3IgZGl0aGVyIHdpdGggYSAwDQo+IG1hZ25pdHVkZQ0KPiBzaW5lIHdh
dmUuICBTbyBtaWdodCBub3QgYmUgd29ydGggaW1wbGVtZW50aW5nIGRlZmF1bHQgbW9kZSBhdCBh
bGwuDQo+IE5vIGhhcm0gaW4gZG9pbmcgc28gdGhvdWdoIGlmIHRoZXJlIGFyZSBhZHZhbnRhZ2Vz
IHRvIGhhdmluZyBpdC4NCg0KTXkgZmVlbGluZyBpcyB0aGF0IHdlIGNvdWxkIHByb2JhYmx5IGhh
dmUgZGl0aGVyIGFzIHRoZSAiZGVmYXVsdCBtb2RlIi4NCk1vcmUgb24gdGhpcyBiZWxvdy4uLg0K
DQo+ID4NCj4gPiB0b2dnbGUgbW9kZSBzcGVjaWFsIEFCSToNCj4gPg0KPiA+ICAqIFRvZ2dsZSBv
cGVyYXRpb24gZW5hYmxlcyBmYXN0IHN3aXRjaGluZyBvZiBhIERBQyBvdXRwdXQgYmV0d2Vlbg0K
PiB0d28NCj4gPiBkaWZmZXJlbnQgREFDIGNvZGVzIHdpdGhvdXQgYW55IFNQSSB0cmFuc2FjdGlv
bi4gVHdvIGNvZGVzIGFyZSBzZXQNCj4gaW4NCj4gPiBpbnB1dF9hIGFuZCBpbnB1dF9iIGFuZCB0
aGVuIHRoZSBvdXRwdXQgc3dpdGNoZXMgYWNjb3JkaW5nIHRvIGFuDQo+IGlucHV0DQo+ID4gc2ln
bmFsIChpbnB1dF9hIC0+IGNsayBoaWdoOyBpbnB1dF9iIC0+IGNsayBsb3cpLg0KPiA+DQo+ID4g
b3V0X3ZvbHRhZ2VZX2lucHV0X3JlZ2lzdGVyDQo+ID4gIC0gc2VsZWN0cyBiZXR3ZWVuIGlucHV0
X2EgYW5kIGlucHV0X2IuIEFmdGVyIHNlbGVjdGluZyBvbmUgcmVnaXN0ZXIsDQo+IHdlDQo+ID4g
ICAgY2FuIHdyaXRlIHRoZSBkYWMgY29kZSBpbiBvdXRfdm9sdGFnZVlfcmF3Lg0KPiA+IG91dF92
b2x0YWdlWV90b2dnbGVfZW4NCj4gPiAgLSBEaXNhYmxlL0VuYWJsZSB0b2dnbGUgbW9kZS4gVGhl
IHJlYXNvbiB3aHkgSSB0aGluayB0aGlzIG9uZSBpcw0KPiA+ICAgIGltcG9ydGFudCBpcyBiZWNh
dXNlIGlmIHdlIHdhbm5hIGNoYW5nZSB0aGUgMiBjb2Rlcywgd2Ugc2hvdWxkDQo+IGZpcnN0DQo+
ID4gICAgZGlzYWJsZSB0aGlzLCBzZXQgdGhlIGNvZGVzIGFuZCBvbmx5IHRoZW4gZW5hYmxlIHRo
ZSBtb2RlIGJhY2suLi4NCj4gPiAgICBBcyBJJ20gd3JpdGluZyB0aGlzLCBJdCBraW5kIG9mIGNh
bWUgdG8gbWUgdGhhdCB3ZSBjYW4gcHJvYmFibHkNCj4gPiAgICBhY2hpZXZlIHRoaXMgd2l0aCBv
dXRfdm9sdGFnZVlfcG93ZXJkb3duIGF0dHIgKG1heWJlIHRha2VzIGEgYml0DQo+IG1vcmUNCj4g
PiAgICB0aW1lIHRvIHNlZSB0aGUgb3V0cHV0cyBidXQuLi4pDQo+IA0KPiBIbW0uIFRoZXNlIGNv
cm5lciBjYXNlcyBhbHdheXMgdGFrZSBhIGJpdCBvZiBmaWd1cmluZyBvdXQuICBXaGF0IHlvdQ0K
PiBoYXZlDQo+IGhlcmUgaXMgYSBiaXQgJ2RldmljZSBzcGVjaWZpYycgZm9yIG15IGxpa2luZy4N
Cj4gDQo+IFNvIHRoZXJlIGlzIHByZWNlZGVuY2UgZm9yIEFCSSBpbiB0aGlzIGFyZWEsIG9uIHRo
ZSBmcmVxdWVuY3kgZGV2aWNlcw0KPiBidXQgb25seQ0KPiBmb3IgZGV2aWNlcyB3ZSBzdGlsbCBo
YXZlbid0IG1vdmVkIG91dCBvZiBzdGFnaW5nLiAgRm9yIHRob3NlIHdlDQo+IG5lZWRlZCBhIG1l
YW5zDQo+IHRvIGRlZmluZSBzZWxlY3RhYmxlIHBoYXNlcyBmb3IgUFNLIC0gd2hlcmUgdGhlIHNl
bGVjdGlvbiB3YXMgZWl0aGVyDQo+IHNvZnR3YXJlIG9yLA0KPiBtdWNoIGxpa2UgaGVyZSwgYSBz
ZWxlY3Rpb24gcGluLg0KPiANCj4gb3V0X2FsdHZvdGFnZTBfcGhhc2UwIGV0Yw0KPiANCj4gc28g
SSBndWVzcyB0aGUgZXF1aXZhbGVudCBoZXJlIHdvdWxkIGJlDQo+IG91dF92b2x0YWdlWV9yYXcw
DQo+IG91dF92b2x0YWdlWV9yYXcxDQo+IGFuZCB0aGUgc2VsZWN0aW9uIHdvdWxkIGJlIHZpYSBz
b21ldGhpbmcgbGlrZQ0KPiBvdXRfdm9sdGFnZVlfc3ltYm9sICgwIG9yIDEgaW4gdGhpcyBjYXNl
KS4gLSBub3RlIHRoaXMgaXMgb25seQ0KPiByZWxldmFudCBpZiB5b3UgaGF2ZSB0aGUgc29mdHdh
cmUgdG9nZ2xlLiBBbnkgZW5hYmxlIG5lZWRlZCBmb3INCj4gc2V0dGluZw0KPiBjYW4gYmUgZG9u
ZSBhcyBwYXJ0IG9mIHRoZSB3cml0ZSBzZXF1ZW5jZSBmb3IgdGhlICByYXcwIC8gcmF3MSBhbmQN
Cj4gc2hvdWxkDQo+IGlkZWFsbHkgbm90IGJlIGV4cG9zZWQgdG8gdXNlcnNwYWNlIChjb250cm9s
cyB0aGF0IHJlcXVpcmUgbWFudWFsDQo+IHNlcXVlbmNpbmcNCj4gdGVuZCB0byBiZSBoYXJkIHRv
IHVzZSAvIGRvY3VtZW50KS4NCg0KWWVhaCwgSSB0aG91Z2h0IGFib3V0IHRoYXQuIEkgd2FzIGV2
ZW4gdGhpbmtpbmcgaW4gaGF2aW5nIHNvbWV0aGluZyBsaWtlDQoqX2FtcGxpdHVkZSBmb3IgZGl0
aGVyIG1vZGUuIEluIHNvbWUgY2FzZXMsIHdoZXJlIHdlIG1pZ2h0IGJlIGxlZnQNCmluIHNvbWUg
bm9uIG9idmlvdXMgc3RhdGUgKGVnOiBtb3ZlZCB0aGUgc2VsZWN0IHJlZ2lzdGVyIHRvIGlucHV0
IGIgYW5kDQp0aGVuIHdlIGZhaWxlZCB0byBzZXQgdGhlIGNvZGU7KSwgSSBwcmVmZXIgdG8gbGVh
dmUgdGhpbmdzIGFzIGZsZXhpYmxlIGFzDQpwb3NzaWJsZSBmb3IgdXNlcnNwYWNlLiBCdXQgSSBh
Z3JlZSBpdCBhZGRzIHVwIG1vcmUgY29tcGxleGl0eSBhbmQgaW4NCnRoaXMgY2FzZSwgSSBjYW4g
anVzdCBhbHdheXMgZ28gdG8gJ2lucHV0X2EnIHdoZW4gd3JpdGluZyAncmF3MCcuLi4NCg0KPiBI
b3dldmVyLCBJJ20gbm90IDEwMCUgc3VyZSBpdCByZWFsbHkgbWFwcyB0byB0aGlzIGNhc2UuICBX
aGF0IGRvIHlvdQ0KPiB0aGluaz8NCg0KSSB0aGluayBpdCBjYW4gd29yay4gVGhvdWdoIG91dF92
b2x0YWdlWV9zeW1ib2wgcHJvYmFibHkgbmVlZHMgdG8gYmUNCnNoYXJlZCBieSB0eXBlIHRvIGJl
IGNvaGVyZW50IHdpdGggd2hhdCB3ZSBtaWdodCBoYXZlIHdpdGggVEdQeC4NCk5vdGUgdGhlIHN3
X3RvZ2dsZSByZWdpc3RlciBoYXMgYSBiaXQgbWFzayBvZiB0aGUgY2hhbm5lbHMgd2Ugd2FudCB0
bw0KdG9nZ2xlIHdoaWNoIG1lYW5zIHdlIGNhbiB0b2dnbGUgbXVsdGlwbGUgY2hhbm5lbHMgYXQg
dGhlIHNhbWUgdGltZS4NCkl0IHdvcmtzIHRoZSBzYW1lIHdpdGggVEdQeCBpZiB5b3UgbWFwIG11
bHRpcGxlIGNoYW5uZWxzIHRvIHRoZSBzYW1lDQpwaW4uDQoNClRoZXJlJ3MgYWxzbyB0aGUgcXVl
c3Rpb24gb24gaG93IHRvIGhhbmRsZSB0aGlzIGlmIGEgVEdQeCBpcyBwcm92aWRlZD8NCkkgZ3Vl
c3MgaXQgd2lsbCBqdXN0IG92ZXJyaWRlIHRoZSBwaW4uLi4gQnV0IG1vc3QgbGlrZWx5IGhhdmlu
ZyB0aGVtIGJvdGgNCmF0IHRoZSBzYW1lIHRpbWUgd2lsbCBsZWFkIHRvIG5vbiBkZXNpcmVkIHJl
c3VsdHMgKHVubGVzcyB3ZSBoYXZlIGENCndheSB0byBnYXRlL3VuZ2F0ZSB0aGUgY2xvY2tzKS4u
LiANCiANCj4gSSdtIG5vdCBzdXJlIGlmIHdoZXRoZXIgYSBjaGFubmVsIGlzIGluIHRvZ2dsZSBt
b2RlIGlzIGEgY2lyY3VpdCB0aGluZyBvcg0KPiBub3QuLg0KPiAoYW5kIGhlbmNlIERUIG9yIHVz
ZXJzcGFjZSBjb250cm9sPykNCg0KVGhlIG9ubHkgcmVhc29uIEkgY2FuIHRoaW5rIG9mZiB0byBo
YXZlIGl0IGFzIERUIGlzIHRoYXQgdG9nZ2xlIG1vZGUgc2VlbXMNCnRvIGJlIGZvciBtb3JlIHNw
ZWNpZmljIHVzZSBjYXNlcyBzbyBJIGd1ZXNzIHRoZSBIVyB3ZSB3YW50IHRvIGNvbnRyb2wgKA0K
YW5kIGNvbm5lY3QgdG8gYSB0b2dnbGUgZW5hYmxlZCBjaGFubmVsKSB3aWxsIGJlIGRpZmZlcmVu
dC4NCg0KSSdtIGFsc28gbm90IHNlZWluZyBhbiB1c2UgY2FzZSBmb3IgcGluZyBwb25naW5nIGJl
dHdlZW4gdGhlIG1vZGVzIG1vc3RseQ0KYmVjYXVzZSBvZiB0aGUgYWJvdmUuLi4NCg0KPiBDYW4g
c2VlIHRoYXQgZXZlbiBpbiBhIGNhc2Ugd2hlcmUgeW91IGRpZCB3YW50IHRvIHVzZSBleHRlcm5h
bA0KPiBjb250cm9scyB0bw0KPiBwaWNrIHRoZSB2YWx1ZXMsIHlvdSBtaWdodCBhbHNvIHdhbnQg
dG8gb3ZlcnJpZGUgZnJvbSBzb2Z0d2FyZS4uLg0KPiBHaXZlbiB0aGVyZSBpcyBhIHNvZnR3YXJl
IHRvZ2dsZSBJIGd1ZXNzIHdlIGNhbiB1c2UgdGhhdCBhcyBvdmVycmlkZS4NCj4gQWN0dWFsbHkg
dGhhdCByYWlzZXMgdGhlIHF1ZXN0aW9uIG9mIHdoYXQgdGhlIHBvaW50IGluIGhhdmluZyBub3Jt
YWwNCj4gbW9kZSBpcz8NCj4gQ2FuIHdlIGp1c3QgaW1wbGVtZW50IHRoYXQgYXMgYSBzb2Z0d2Fy
ZSB0b2dnbGUgdG9nZ2xlIG1vZGU/IE9uZQ0KPiBsZXNzIHRoaW5nIHRvDQo+IHdvcnJ5IGFib3V0
IGlmIHdlIGNhbi4NCg0KSSBkaWQgdGhvdWdodCBhYm91dCB0aGUgc3dfdG9nZ2xlIHRoaW5nIChp
dCdzIHNvbWV0aGluZyB0aGF0IGlzIG9ubHkgdmFsaWQNCmZvciBjaGFubmVscyBpbiBkaXRoZXIv
dG9nZ2xlIG1vZGUpLiBNeSByZWFzb25pbmcgd2FzIHRoYXQgZWl0aGVyDQoNCjEpIEkgZGlkIG5v
dCBzdXBwb3J0ZWQgaXQgYW5kIG1hZGUgdGhlIFRHUHggc2VsZWN0aW9uIG1hbmRhdG9yeSAoaW4g
Y2FzZQ0KZGl0aGVyL3RvZ2dsZSBtb2RlIGVuYWJsZWQpIG9yDQoyKSBJIGRpZCBzdXBwb3J0IGl0
ICBhbmQgaGVuY2UgdGhlIHBpbnMgIGFyZSBub3QgcmVhbGx5IG1hbmRhdG9yeS4NCg0KSSB3ZW50
IHdpdGggMSkgYmVjYXVzZSwgaG9uZXN0bHksIEknbSBub3Qgc2VlaW5nIHRoZSBwb2ludCBvZiBo
YXZpbmcgdGhlc2UNCm1vZGVzIGFuZCB1c2Ugc3cgdG9nZ2xlIChhdCBsZWFzdCBvbiBhIHByb2R1
Y3Rpb24gc3lzdGVtKS4gSG93ZXZlciwgaWYgd2UNCndhbnQgdG8gZ2V0IHJpZCBvZiB0aGUgZGVm
YXVsdCBtb2RlIGFuZCBoYXZlIGl0IGFzIHRoZSBkaXRoZXIgbW9kZSwgSSBhZ3JlZQ0Kd2UgbmVl
ZCBzd190b2dnbGUgYmVjYXVzZSBJZiBzb21lb25lIGp1c3Qgd2FudHMgdG8gdXNlIHRoZSBjaGFu
bmVsDQp3aXRob3V0IGFueSBkaXRoZXJpbmcsIHdlIGNhbid0IGhhdmUgYW4gaGFyZCByZXF1aXJl
bWVudCB0byBwcm92aWRlIGENCmV4dGVybmFsIFRHUHguIE1vcmVvdmVyLCBpZiB0aGUgZGVmYXVs
dCBjaGFubmVsIHdpbGwgYmUgYSBkaXRoZXIgY2FwYWJsZQ0Kb25lLCB3ZSBuZWVkIHRvIHByb3Zp
ZGUgZnVsbCBmdW5jdGlvbmFsaXR5IGFuZCBoZW5jZSwgc3dfdG9nZ2xlLg0KDQpBcyBJIHN0YXRl
ZCBiZWZvcmUsIEknbSBqdXN0IG5vdCBzdXJlIG9uIGhvdyB0byBoYW5kbGUgdGhpbmdzIGlmIGEg
VEdQeCBpcw0KYWxzbyBwcm92aWRlZC4gTWF5YmUgdGhleSBzaG91bGQgYmUgbXV0dWFsIGV4Y2x1
c2l2ZT8gSSBtZWFuLCBpZiBzb21lb25lDQp0cmllcyB0byB0b2dnbGUgYSBjaGFubmVsIHdpdGgg
YSBtYXBwZWQgVEdQeCB3ZSByZXR1cm4gc29tZSBlcnJvciBjb2RlPw0KIA0KPiBUaGVyZSBpcyBh
bHNvIHRoZSBxdWVzdGlvbiBvZiB3aGV0aGVyIHNlbGVjdGlvbiBvZiB3aGljaCB0b2dnbGUgcGlu
IGlzDQo+IHVzZWQNCj4gc2hvdWxkIGJlIGEgZHQgdGhpbmcgb3IgYSB1c2Vyc3BhY2UgY29udHJv
bC4uLg0KDQpXZWxsLCB0aGlzIGRlZmluaXRlbHkgbWVhbnMgc29tZSBIVyB3aXJpbmcgdG8gaGF2
ZSB0aGUgZXh0ZXJuYWwgc2lnbmFscyBhbmQNCkknbSBub3Qgc3VyZSBpZiB0aGVyZSdzIGFueSBh
ZGRlZCB2YWx1YWJsZSBpbiBiZWluZyBhYmxlIHRvIGNoYW5nZSB0aGUNCmV4dGVybmFsIHNpZ25h
bCBhdCBydW50aW1lPw0KDQo+ID4NCj4gPiBkaXRoZXIgbW9kZSBzcGVjaWFsIEFCSToNCj4gPg0K
PiA+ICAqIERpdGhlciBvcGVyYXRpb24gYWRkcyBhIHNtYWxsIHNpbnVzb2lkYWwgd2F2ZSB0byB0
aGUgZGlnaXRhbCBEQUMNCj4gPiBzaWduYWwgcGF0aC4gRGl0aGVyaW5nIGlzIGEgc2lnbmFsIHBy
b2Nlc3NpbmcgdGVjaG5pcXVlIHRoYXQgaW52b2x2ZXMNCj4gPiB0aGUgaW5qZWN0aW9uIG9mIGFj
IG5vaXNlIHRvIHRoZSBzaWduYWwgcGF0aCB0byByZWR1Y2Ugc3lzdGVtDQo+ID4gbm9ubGluZWFy
aXRpZXMuDQo+ID4NCj4gDQo+IFRoaXMgaXMgYSBjb21wbGV4IGZlYXR1cmUgdG8gZGVzY3JpYmUg
YXMgKGlmIEkgcmVhZCBpdCBjb3JyZWN0bHkpIHdlIGhhdmUNCj4gYSBkaXRoZXIgY2xvY2tlZCBm
cm9tIGFuIGV4dGVybmFsIHBpbiwgb3IgaW4gdGhlb3J5IGZyb20gc29mdHdhcmUuIFRoYXQNCj4g
Y2xvY2sNCj4gZnJlcXVlbmN5IG11c3QgbWF0Y2ggdGhlIGRpdGhlci4gIFJlYWxpc3RpY2FsbHkg
dGhhdCBtZWFucyBpdCBpcyBhIGNsb2NrDQo+IGluIG91ciBjb250cm9sIG9yIHdlIGhhdmUgdG8g
bWF0Y2ggdGhlIHBlcmlvZCBiZWxvdyB0byB0aGUgZnJlcXVlbmN5DQo+IG9mIHRoYXQNCj4gY2xv
Y2suDQoNClllYWgsIHRoZSBmcmVxdWVuY3kgIG9mIHRoZSBkaXRoZXIgc2lnbmFsIGlzIGZzaWcg
PSBmY2xrIC8gTiwgd2hlcmUgTiBjYW4gb25seQ0KYmU6IFs0IDggMTYgMzIgNjRdLiBTbywgd2Ug
a2luZCBvZiBqdXN0IGhhdmUgdGhlc2UgYXZhaWxhYmxlIG9wdGlvbnMgZm9yIHRoZQ0Kc2lnbmFs
IGZyZXF1ZW5jeSBhbmQgZmNsayBpcyBzb21ldGhpbmcgd2UgY2FuIGNvbnRyb2wgYW5kIGtub3cg
KGFzc3VtaW5nDQp3ZSBoYXZlIFRHUHggbWFwcGluZyB3aGljaCBJJ20gYnVuZGxpbmcgd2l0aCBh
IGNsaykuDQoNClRoZSBvbmx5IHF1aXJrIHdpdGggaGF2aW5nIHRoaXMgd2l0aCBmcmVxdWVuY3kg
cmF0aGVyIHRoYW4gcmF3IE4gaXMNCnRvIGhhbmRsZSB0aGUgc3dfdG9nZ2xlIHdoZXJlIHdlIGhh
dmUgbm8gaWRlYSBhYm91dCBmY2xrPyBXZSBjb3VsZCBhbHNvIA0KdGhpbmsgb2YgdGhpcyBhdHRy
IGFzIHNvbWUga2luZCBvZiBkZWNpbWF0aW9uLi4uDQoNCj4gPiBvdXRfdm9sdGFnZTBfZGl0aGVy
X2VuDQo+ID4gIC0gU2FtZSBhcyBpbiB0b2dnbGUgbW9kZS4NCj4gPiBvdXRfdm9sdGFnZTBfZGl0
aGVyX3BlcmlvZA0KPiA+IG91dF92b2x0YWdlMF9kaXRoZXJfcGhhc2UNCj4gPiAgLSBQZXJpb2Qg
YW5kIHBoYXNlIG9mIHRoZSBzaWduYWwuIE9ubHkgc29tZSB2YWx1ZXMgYXJlIHZhbGlkIHNvDQo+
IHRoZXJlJ3MNCj4gPiAgICBhbHNvICpfYXZhaWxhYmxlIGZpbGVzIGZvciB0aGVzZS4gSSdtIG5v
dCBzdXJlIGlmIHdlIGNhbiB1c2UgdGhlIG1vcmUNCj4gPiAgICBnZW5lcmljIElJT19DSEFOX0lO
Rk9fUEhBU0UgYW5kIElJT19DSEFOX0lORk9fRlJFUVVFTkNZDQo+IGhlcmUgYXMgdGhlc2UNCj4g
PiAgICBwYXJhbWV0ZXJzIGRvbid0IHJlYWxseSBhcHBseSB0byB0aGUgY2hhbm5lbCBvdXRwdXQg
c2lnbmFsLi4NCj4gDQo+IFBvc3NpYmx5IG5vdCBoZWxwZnVsIHRvIGRvIHNvLCBidXQgeW91IGNv
dWxkIGRlc2NyaWJlIHRoZSBjaGFubmVsIGFzIGFuDQo+IG91dF9hbHR2b2x0YWdlIGNoYW5uZWwg
dGhhdCBoYXBwZW5zIHRvIGhhdmUgYSBzaWduaWZpY2FudCBvZmZzZXQgKHRoZQ0KPiBEQw0KPiBs
ZXZlbCkgYW5kIHBoYXNlLCBmcmVxdWVuY3kgZXRjIGFzIGZvciBhIG5vcm1hbCBhbHR2b2x0YWdl
IGNoYW5uZWwuDQo+IFRoYXQgd291bGQgaGlkZSB0aGUgaW50ZW50aW9uIGhlcmUgdGhvdWdoIHNv
IHBlcmhhcHMgbm90IGEgZ29vZCBwbGFuDQo+IGV2ZW4gaWYgaXQgZW5zdXJlcyB3ZSBlbmQgdXAg
d2l0aCBzdGFuZGFyZCBBQkkuDQoNCkkgdGhpbmsgYWx0dm9sdGFnZSBtaWdodCBub3QgYmUgb3B0
aW1hbCBoZXJlICBiZWNhdXNlIHRoZSBwaGFzZSBhbmQgZnJlcXVlbmN5DQphcmUgcmVhbGx5IG5v
dCBjaGFyYWN0ZXJpc3RpY3Mgb2YgdGhlIG91dHB1dCBzaWduYWwgb2YgdGhlIGNoYW5uZWwuDQoN
Cj4gPiBvdXRfdm9sdGFnZTBfaW5wdXRfcmVnaXN0ZXINCj4gPiAgLSBTYW1lIGFzIGluIHRvZ2ds
ZSBtb2RlLiBIb3dldmVyIGluIHRoaXMgbW9kZSB0aGUgY29kZSBzZXQgaW4gdGhlDQo+ID4gICAg
aW5wdXRfYiByZWdpc3RlciBoYXMgYSBzcGVjaWFsIG1lYW5pbmcuIEl0J3MgdGhlIGFtcGxpdHVk
ZSBvZiB0aGUNCj4gPiAgICBkaXRoZXIgc2lnbmFsLg0KPiBEb24ndCBkbyB0aGF0IC0gcHJvdmlk
ZSBhIGRpcmVjdCBhdHRyaWJ1dGUgcmVwcmVzZW50aW5nIHRoZSB2YWx1ZSBvZg0KPiByZWdpc3Rl
cl9iIGFuZCB3aGVuIGl0IGlzIHdyaXR0ZW4gaW1wbGljaXRseSBzd2l0Y2ggdG8gdGhlIHJpZ2h0
IHJlZ2lzdGVyLg0KPiBBbnkgQUJJIHRoYXQgcmVxdWlyZXMgYSBzZXF1ZW5jZSBvZiBldmVudHMg
aXMgaGFyZCB0byB1c2UuDQoNCkkgZ3Vlc3Mgd2UgY2FuIGp1c3QgdXNlIHRoZSBzYW1lIHJhdzEg
YXR0ciBoZXJlPyBFdmVuIHRob3VnaCwgaW4gZGl0aGVyDQptb2RlIHRoaXMgaGFzIHNwZWNpYWwg
bWVhbmluZyAoaXQgaXMgdGhlIGFtcGxpdHVkZSkuLi4NCg0KPiANCj4gPg0KPiA+IE9uZSBzcGVj
aWFsIG1lbnRpb24gdG8gdGhlIGRhYyBzY2FsZS4gSW4gdGhpcyBwYXJ0IHRoaXMgaXMgc29tZXRo
aW5nDQo+ID4gdGhhdCBjYW4gYmUgcHVyZWx5IGNvbnRyb2xsZWQgYnkgU1cgc28gdGhhdCBJJ20g
YWxsb3dpbmcgdXNlcnNwYWNlIHRvDQo+ID4gY2hhbmdlIGl0IHJhdGhlciB0aGVuIGhhdmluZyBp
dCBpbiBkdHMuIFRoZSBhdmFpbGFibGUgc2NhbGVzIGFyZToNCj4gPg0KPiA+ICogWzAgNVZdIC0+
IG9mZnNldCAwDQo+ID4gKiBbMCAxMFZdIC0+IG9mZnNldCAwDQo+ID4gKiBbLTUgNVZdIC0+IG9m
ZnNldCAtMzI2NzgNCj4gPiAqIFstMTAgMTBWXSAtPiBvZmZzZXQgLTMyNzY4DQo+ID4gKiBbLTE1
IDE1Vl0gLT4gb2Zmc2V0IC0zMjc2OA0KPiA+DQo+ID4gV2l0aCB0aGUgYWJvdmUsIHdlIGFsc28g
bmVlZCB0byBoYXZlIHRoZSBvZmZzZXQgY29uZmlndXJhYmxlIGFuZA0KPiByaWdodA0KPiA+IG5v
dyBJJ20gZ29pbmcgdG8gc29tZSB0cm91YmxlIHRvIG1ha2Ugc3VyZSB0aGUgc2NhbGUgKyBvZmZz
ZXQgaXMNCj4gPiBzb21ldGhpbmcgdmFsaWQuIEhvbmVzdGx5LCBJIHRoaW5rIEknbSBvdmVyZG9p
bmcgaXQgYmVjYXVzZSB0aGluZ3MgY2FuDQo+ID4gc3RpbGwgZ28gd3Jvbmcgd2l0aCBbMCAxMFZd
IGFuZCBbLTUgNVZdIGFzIHRoZSBzY2FsZXMgYXJlIHRoZSBzYW1lDQo+ID4gaGVyZS4gRnVydGhl
cm1vcmUsIHRoZXJlJ3Mgbm8gcmVhbCBhcm0gdGhhdCBjYW4gYmUgZG9uZSB0byB0aGUgSFcuDQo+
IElzDQo+ID4ganVzdCB0aGF0IHRoZSByZWFkaW5ncyB3b24ndCBtYXRjaCB3aXRoIHdoYXQgc29t
ZW9uZSBtaWdodCBiZQ0KPiBleHBlY3RpbmcuDQo+ID4gTXkgcGxhbiBpcyB0byBqdXN0IHJlbW92
ZSB0aG9zZSBjaGVja3MgYW5kIGFzc3VtZSBpcyB1cCB0bw0KPiB1c2Vyc3BhY2UgdG8NCj4gPiBt
YWtlIGl0IHJpZ2h0IGFuZCBub3QgaGF2ZSBbLTEwIDEwVl0gc2NhbGUgd2l0aCAwIG9mZnNldCBm
b3IgZXhhbXBsZS4NCj4gDQo+IFNvIHRoaXMgaXMgc29tZXRoaW5nIHdlJ3ZlIGRlYmF0ZWQgYSBm
ZXcgdGltZXMgaW4gdGhlIHBhc3QuDQo+IFRoZXJlIGlzIGEgZmFpcmx5IHN0cm9uZyBhcmd1bWVu
dCBmb3Igb3V0cHV0IGRldmljZXMgdGhhdCB0aGUgcmFuZ2UgaXMNCj4gYSBjaGFyYWN0ZXJpc3Rp
YyBvZiB0aGUgY2lyY3VpdC4gIEF0IHRoZSB2ZXJ5IGxlYXN0IGl0IG1ha2VzIHNlbnNlIHRvDQo+
IHJlc3RyaWN0IGl0IGluIERUIGV2ZW4gaWYgd2UgYWxsb3cgc2FmZSBmb3JtcyBvZiB0d2Vha2lu
ZyBpbiB0aGUgZHJpdmVyLg0KPiBGb3IgYW4gaW5pdGlhbCBkcml2ZXIsIEknZCBqdXN0IGhhdmUg
aXQgaW4gRFQuDQo+IA0KDQpObyBjb21wbGFpbnRzIGFnYWluc3QgdGhhdCBhbmQgbWFrZXMgdGhp
bmdzIHdheSBzaW1wbGVyIHRvIGhhbmRsZS4NCg0KLSBOdW5vIFPDoQ0KDQo=
