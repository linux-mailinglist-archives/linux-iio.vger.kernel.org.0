Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C620C48FDCB
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 17:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiAPQTQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 11:19:16 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:43908 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232279AbiAPQTP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 11:19:15 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20G7mgWP031469;
        Sun, 16 Jan 2022 11:18:53 -0500
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3dkus8k98f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jan 2022 11:18:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyISFuRq/ULvOLUh7j+yKLBRIIcJ41bK3LCd86AnNfh1mRev8CZwZN9CkHbTIPLUtkmJX3MHIZ+IdeExJh3p58UlRTsso3mar7e5vNBBjZlexyoo9IFA/9bBEzMeJWVuzDT/fsTQVkfTiHS6yTeSBgm7QXWRJdf5iVgB7++ehIFayel4I6cjj5lV7z8jP1EkfiMSbDr+qarcg8j/zQeKTJweMefJr3xbwR0gqYVGxL+ZPTWIjqVj8NCT9mA+C8ijhFVQzWfbD4P+wp/uQ2jBDJrHxKbYRte54ktqUZzKYjiKZerEYN3iBv6NFwVQzuX5DPs+ky6bqAci4Jd8k4Lgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLJzTs6rMwWJeAPAAbFOHqK9etQn/KC42wRY4shDR6M=;
 b=HyprRv96HZyTtzc5Chc5AmRkPUWSh6hPtGTn4IlcXZUX7DiAEDTskFfpLiS9gLIoL9BvG2dvQnXLo8aZ1rtiyP22rQC1lCc2NVxJj5ex4oi+/dcA13ixjebVXQpjsIk/SD2ynp4+Aug3lOexFB9SOoRmBzLrqvg5cSmJMW3uG8CjpOPZDswqacgk86kH21fDfViTSeUTZVZQvISaVTTpj1R1hjIKw9y6krFCvdNDonbwTDl3acw6XtsemKZkR8/YTZzODSkh1W5o+DrB5/6xdGppUWUVgD0LY6NWmzfoY1WSntyrYfcStAziteBE37XA9HdaO5LHPIz3ZGrRWQygrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLJzTs6rMwWJeAPAAbFOHqK9etQn/KC42wRY4shDR6M=;
 b=k5xu5NMUcLqJvJYOcG2Z0Vwkit9WSxRAbUHRPlmpmSp2HhaI0R9haUhSMJhI1ExjtAsVzGisl7d8o2hBPJajsXy2y9p9zrY1uCb4vYdyF5JYT61cBAI6n9IhNC/d1/RU83DEGPHOAdX9UHrYeI6mYLl8nUc9U383Vh4CjyhY5SQ=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6677.namprd03.prod.outlook.com (2603:10b6:510:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Sun, 16 Jan
 2022 16:18:52 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5%5]) with mapi id 15.20.4844.016; Sun, 16 Jan 2022
 16:18:51 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v2 3/3] dt-bindings: iio: Add ltc2688 documentation
Thread-Topic: [PATCH v2 3/3] dt-bindings: iio: Add ltc2688 documentation
Thread-Index: AQHYCfIrs8fitsUpqkGPF+0Qvpeg6KxljcOAgABGl0A=
Date:   Sun, 16 Jan 2022 16:18:51 +0000
Message-ID: <PH0PR03MB67864683C080FC21D28CB5F199569@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220115092705.491-1-nuno.sa@analog.com>
        <20220115092705.491-4-nuno.sa@analog.com>
 <20220116120143.18e3e0f0@jic23-huawei>
In-Reply-To: <20220116120143.18e3e0f0@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFptTTRZVGd3T1dZdE56WmxOeTB4TVdWakxUaGlZamd0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHWmpPR0U0TUdFeExUYzJaVGN0TVRGbFl5MDRZ?=
 =?utf-8?B?bUk0TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTmprek1D?=
 =?utf-8?B?SWdkRDBpTVRNeU9EWTRNak0xTWprNE1qWXpNVFUxSWlCb1BTSlBjMGhxWW1G?=
 =?utf-8?B?ek1HcFZZbTF2VEhSNmVFTmlMM1ZFZG14aFUzTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSjZNRTlMS3psQmNsbEJWVWhwWmxCcU5FNVBMM0JSWlVvNEsx?=
 =?utf-8?B?Qm5NRGNyYTBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36658c4e-bf3d-4f26-93b9-08d9d90be29e
x-ms-traffictypediagnostic: PH0PR03MB6677:EE_
x-microsoft-antispam-prvs: <PH0PR03MB6677B0C6F21D418094888B6999569@PH0PR03MB6677.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WBLlgD0Ey9YfU3GFeUYysOpOJZ4+TjPHp5+K3lJ5SCaS79nvhfsFxOGHobFhhIoYDmOUjIafFZkNoyNJdSIDr48jsDx7RYcqPkW/jyXucISAjPvYxrZ/tvPm2Pzewf8Gn4dBlRnyiKuVgMuvw+O5bqP5rbjnwL93BDbxjNHJvDAKYONRKwNDJyXU9cuSAzg9O8mC4fgbcRmeN6H8BQRkYbdcJXwW15splOL3RZC1X0/TFjdJPDC01Tqava8hfcpfvlg4bQIjeiB5XVADB863PrccR49RL1B6G0Qv/SEC+ktmOK75+++tvHrev0U0lW1OPkjVWu6qpjBp4zrbSb4WOUzHpICJEjbPISb+LRlmRRWdcsQqe8+XrI9IyHPTWVG7sILnmTupbUAehf5WpSYZCG5RJTDs+xOQThQCNa4oO0zgDd8YnmYkTOiC29Xr16PMpc1gqIFj/bG6ZgQWYooLsMUBS4S49LTP9U2Z3U/Toi6bGAMfPvG9yKOSHk6+3XsXniWCjnbY4JzrsFEpE5QPeeMo4KmV8SribZeGrWLx7AsJYdp6vybmdLDvblBn5Ic9Mchuafv1BqjQlkDvTr26uGzVOOkjXy2tfiM4x3Frw9V5cW44dJ3KRvijxSfMSs+vHLqpu0xbvn+lS6DXmChXjdeIUQMu1Lb4EFQPWQE29uey131nBC8ffKjTiWyjV9mbLhyNclGWqUPefHZbfNJp+hYFlOZGDw1mS1ZzuOzJ4Rwi6p5fblZ89rDN8KTlxr/gccTlE79881StWutG9AoCXFVRC7QxRnt9jEI1fVztdfcCt0UJeroI5BVY5pZJ2hBjBgYiwF6Lt5sEO1AmoA3BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(508600001)(7696005)(186003)(122000001)(8676002)(76116006)(4326008)(966005)(55016003)(54906003)(38100700002)(38070700005)(52536014)(2906002)(316002)(107886003)(66446008)(33656002)(6506007)(6916009)(64756008)(66476007)(66556008)(86362001)(9686003)(66946007)(83380400001)(71200400001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE01RElWVG5mZHo5cUp4bTcraGRPZy9SVGZ1SHNCRjdkbWo5QThHb3RMVTBO?=
 =?utf-8?B?aG84ejExZlUzSlYxQ3E2UEEyb01UWHlkRFV4TUhBZ2V3WlJmSHVLdEJuS1JX?=
 =?utf-8?B?TUNGcFlPeFhZV1J1UjZMelQyV1ZmNFpiL3BIQUV2RXBLbEJYQmN4U0FpeVZL?=
 =?utf-8?B?a1NjZmxkMGJTei9MT21QT29aVTRURFRzZmcrTVpJbTY4Z0FqSzhjZ0tFUmhp?=
 =?utf-8?B?YkxEQmpSdXhXajRmNnRZOFNrOEcyM3VwOUUrUEN5N1A0dGQ3ZThWNmVjalBo?=
 =?utf-8?B?Rlg5cEI4QVBuenZSU1p0UGM5ZnFjMDFGNjVjWFNGejdPOURpdng4VUFpeHZz?=
 =?utf-8?B?U3B6d0dLR2x4Zml5VzNjbkQ4RHBQUzVkdkF4dG9ENmUyTzY4RlVLUHZENmds?=
 =?utf-8?B?a3hiUDlWaGRQeGxpZnltaUNqN3lpZWRpWkJFVzZpZEt6QWtwY2NTUmFod1lV?=
 =?utf-8?B?V3NDcjhRWkJBbThaSlQ2S3N3UzF3ZURBNXFKcDdNWjdvV3lRZEJENC84ZSt6?=
 =?utf-8?B?bnZOamZaZWdNUnF1eGtJdldXblgxbW54eDBrL01kYk5WeFdjWW1qNHlzbVBu?=
 =?utf-8?B?aDJkQy9rUHZqUWUvckkvSlpwK1pxeENma0Q2VG5odURxZCtVeklzb1BaMmtE?=
 =?utf-8?B?dTNDNUtWckp1NUcxUkMwSHBVOGQ5V2x5dk90RjBXZHpSa3RUMEtzWUJtQ2pi?=
 =?utf-8?B?M3ZvdXk1NXkwZGd6anpycXVxNTdhakpFTlZyUDFjdmdkQis0WVBON1lRbW9S?=
 =?utf-8?B?b3RieEZDREoxQjZBT2VEcC9OeXExNllvNXhUMnRlUHMrd3pCWXRqMFFUYUJK?=
 =?utf-8?B?aVV4T1dOVGlOdFdZc01PS3JlL2VBRzB0N3ZVTy9MTWFJWWhzMFJnRlZERWph?=
 =?utf-8?B?aEJyN2xGQUY0djlKNkZ1NVJGbG9TandtTUFveFI2dExNV0h3elJUZGZyd0gy?=
 =?utf-8?B?bTBLZUNzMW5YUU8xU0R3eTRCSXdkQUI0U2xYdHpQSkpvd3VESGdiSXphY2J4?=
 =?utf-8?B?cWtUTzYwM0lVZWRxUlVXUlIrZGtycDJ4YlFvUFRidTRqNlpka3lZelZacm5Z?=
 =?utf-8?B?REQvbnVBZy80UVB2TklYdmluckpzWlZHN0NaNHdLK0R0eHE0R1BBalNha0F0?=
 =?utf-8?B?ZG5GY1pJeU5XYkpSaTBkTllPYU5rMlFRV0F3aW9teVdPOWRVeStwY3VyYnNj?=
 =?utf-8?B?bVA3L2duWTUrR01Fd200Q01zU1MrUUdZS3l3SjBNYVhkMFdMSldKbFlqdElG?=
 =?utf-8?B?Y25LU1kwbk42VkpwTlBCaEhQdjJoRmIvbUJGZ0liTzZrNlpXaC9zS1NJMmFZ?=
 =?utf-8?B?cVh3WTR4UGRTbFpQd0dkTFA0TzgrOXcrNzRqbitSRWNaN3l1dWE5WmhOWFpF?=
 =?utf-8?B?WkxHZVZhUG8rSUhmMGJuTXJqdWxTQmZacG9RNGtLdlNZK2Y4OVUwbzVuWVk3?=
 =?utf-8?B?TjRSUDZkSVVKaDZOM291MFNZZFl2dWF1bS9IdHFyeC8xbEczcHZ2bDRQVHpD?=
 =?utf-8?B?WEMva2xNZU9iZXN3YTNzbVBsSFBpd1J1RUZybFJFZW05QzJzU0VOS1M5SldD?=
 =?utf-8?B?MktHellVRUk2TldQTXZDQy9NVmlVOEdzeVByUUZ5Z2RSL21rOEx4SkRXQW1r?=
 =?utf-8?B?YWVCNkdrUEo2UFRpVVYzZjZxbjdCT212Z0dRbnBjek91Q2prMDZmcEl5YUJS?=
 =?utf-8?B?MWlMK1VuT0tTakhKZ3lYTjQvTlpBdEt3WlFFUzBoTFp6WUtOK0RIcWxpekRH?=
 =?utf-8?B?d1V5aWpLazFBTGlDbDhxZzcvOWdBQUovVHBYSjZHdmdZbDJMMGlZTVpVZEEx?=
 =?utf-8?B?RjVZOTFkTWFId0NDY2J2RFZBaXpzOWxrU0xnTXBMR3lsNjdaVkJweUpZUkZS?=
 =?utf-8?B?S1JvbGZuTGpIOXRKL0IyZVpQcE1RNE8xalhVN1JBeUVMRWNMRlpWUW4wb0NJ?=
 =?utf-8?B?R0xPbUc3cGk3N05BNCtzRXQrak5TWmR3MHlkajRtOThBei9zUE9yenJrWUxq?=
 =?utf-8?B?VG1lMGF3SVRXeVd5c0p2eHppMzE1U3lBUGpmbGduTnRuOTgzcEdQT2NqdzND?=
 =?utf-8?B?Vy9kcjA2ZkRhT2JIcmtXbE5DY0Vjb1hOeW1OUlpTemlMM2svcUwycEU2ZHlY?=
 =?utf-8?B?dGh2U2xFd2kvazIxMUEvWktYYVNiVzAyRU9USzFobXIwSG16OU8xSi9tSjFF?=
 =?utf-8?B?UFdCL3JTZ0Z0SVkvWTlUWnNDRU5GbkpzNnRTWUFCYm5NMzNkMlNnSzl5Q1ZL?=
 =?utf-8?Q?SJfs1b3v5D2YXaN/yD05OoJEaTZGkU6Y/vki1wJ7z8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36658c4e-bf3d-4f26-93b9-08d9d90be29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2022 16:18:51.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkSQn5NC3kN2yRtLiHjeDKEGTZo2pzjLlargc06ZIW+rCSIlvCv0UEHdozv/glZp7lZZ8sU6zXmPYQ8a6WKWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6677
X-Proofpoint-GUID: mlbaIxmvVoKw_BnxWB_2heCFRlieAhrs
X-Proofpoint-ORIG-GUID: mlbaIxmvVoKw_BnxWB_2heCFRlieAhrs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-16_06,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201160107
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU3VuZGF5LCBKYW51YXJ5IDE2LCAyMDIyIDE6
MDIgUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENjOiBsaW51eC1p
aW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgUm9iDQo+IEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0Bt
ZXRhZm9vLmRlPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFs
b2cuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM10gZHQtYmluZGluZ3M6IGlpbzog
QWRkIGx0YzI2ODgNCj4gZG9jdW1lbnRhdGlvbg0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24g
U2F0LCAxNSBKYW4gMjAyMiAxMDoyNzowNSArMDEwMA0KPiBOdW5vIFPDoSA8bnVuby5zYUBhbmFs
b2cuY29tPiB3cm90ZToNCj4gDQo+ID4gRG9jdW1lbnQgdGhlIExUQzI2ODggZGV2aWNldHJlZSBw
cm9wZXJ0aWVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5h
bG9nLmNvbT4NCj4gSGkgTnVubywNCj4gDQo+IEEgZmV3IG1pbm9yIGNvbW1lbnRzIGlubGluZS4g
IEkndmUgcmV2aWV3ZWQgdGhpcyBmaXJzdCBzbyBtaWdodA0KPiBmaW5kIGFuc3dlcnMgdG8gc29t
ZSBvZiB0aGVtIHdoZW4gcmVhZGluZyB0aGUgZHJpdmVyIGNvZGUuDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiBKb25hdGhhbg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2lpby9kYWMvYWRp
LGx0YzI2ODgueWFtbCAgICAgICAgIHwgMTQ3DQo+ICsrKysrKysrKysrKysrKysrKw0KPiA+ICBN
QUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDE0OCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2RhYy9hZGksbHRj
MjY4OC55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2lpby9kYWMvYWRpLGx0YzI2ODgueWFtbA0KPiBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vZGFjL2FkaSxsdGMyNjg4LnlhbWwNCj4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZWNkMDk0M2ZiODEzDQo+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9paW8vZGFjL2FkaSxsdGMyNjg4LnlhbWwNCj4gPiBAQCAtMCwwICsxLDE0NyBAQA0KPiA+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkN
Cj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9paW8vZGFjLw0KPiBhZGks
bHRjMjY4OC55YW1sKl9fO0l3ISFBM05pOENTMHkyWSFxaGNqRkZEWTkzOWh2M0xvMmlUMWZBSWJT
T2J0DQo+IFlzY0tvWGpBbkxnV1pSTkc2X1dFMldYZ1o4QWRFNEZVd2ckDQo+ID4gKyRzY2hlbWE6
DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS0NCj4gc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUEzTmk4Q1MweTJZIXFoY2pGRkRZOTM5aHYz
TG8yaVQxZkFJYlMNCj4gT2J0WXNjS29YakFuTGdXWlJORzZfV0UyV1hnWjhCT3pJdk45ZyQNCj4g
PiArDQo+ID4gK3RpdGxlOiBBbmFsb2cgRGV2aWNlcyBMVEMyNjg4IERBQw0KPiA+ICsNCj4gPiAr
bWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+
ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gPiArICBBbmFsb2cgRGV2aWNlcyBMVEMyNjg4IDE2
IGNoYW5uZWwsIDE2IGJpdCwgKy0xNVYgREFDDQo+ID4gKyAgaHR0cHM6Ly93d3cuYW5hbG9nLmNv
bS9tZWRpYS9lbi90ZWNobmljYWwtDQo+IGRvY3VtZW50YXRpb24vZGF0YS1zaGVldHMvbHRjMjY4
OC5wZGYNCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiAr
ICAgIGVudW06DQo+ID4gKyAgICAgIC0gYWRpLGx0YzI2ODgNCj4gPiArDQo+ID4gKyAgcmVnOg0K
PiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgdmNjLXN1cHBseToNCj4gPiArICAg
IGRlc2NyaXB0aW9uOiBBbmFsb2cgU3VwcGx5IFZvbHRhZ2UgSW5wdXQuDQo+ID4gKw0KPiA+ICsg
IGlvdmNjLXN1cHBseToNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBEaWdpdGFsIElucHV0L091dHB1
dCBTdXBwbHkgVm9sdGFnZS4NCj4gPiArDQo+ID4gKyAgdnJlZi1zdXBwbHk6DQo+ID4gKyAgICBk
ZXNjcmlwdGlvbjoNCj4gPiArICAgICAgUmVmZXJlbmNlIElucHV0L091dHB1dC4gVGhlIHZvbHRh
Z2UgYXQgdGhlIFJFRiBwaW4gc2V0cyB0aGUgZnVsbC0NCj4gc2NhbGUNCj4gPiArICAgICAgcmFu
Z2Ugb2YgYWxsIGNoYW5uZWxzLiBCeSBkZWZhdWx0LCB0aGUgaW50ZXJuYWwgcmVmZXJlbmNlIGlz
IHJvdXRlZA0KPiB0bw0KPiA+ICsgICAgICB0aGlzIHBpbi4NCj4gDQo+IFBlcmhhcHMgIklmIG5v
dCBwcm92aWRlZCB0aGUgaW50ZXJuYWwgcmVmZXJlbmNlIGlzIHVzZWQgYW5kIGFsc28NCj4gcHJv
dmlkZWQgb24gdGhlDQo+IFZSRUYgcGluIi4NCg0KU3VyZS4uLg0KDQo+ID4gKw0KPiA+ICsgIGNs
ci1ncGlvczoNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBJZiBzcGVjaWZpZWQs
IGl0IHdpbGwgYmUgYXNzZXJ0ZWQgZHVyaW5nIGRyaXZlciBwcm9iZS4gQXMgdGhlIGxpbmUgaXMN
Cj4gPiArICAgICAgYWN0aXZlIGxvdywgaXQgc2hvdWxkIGJlIG1hcmtlZCBHUElPX0FDVElWRV9M
T1cuDQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICAnI2FkZHJlc3MtY2VsbHMn
Og0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgJyNzaXplLWNlbGxzJzoNCj4gPiAr
ICAgIGNvbnN0OiAwDQo+ID4gKw0KPiA+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4gPiArICAiXmNo
YW5uZWxAKFswLTldfDFbMC01XSkkIjoNCj4gPiArICAgIHR5cGU6IG9iamVjdA0KPiA+ICsNCj4g
PiArICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgIHJlZzoNCj4gPiArICAgICAgICBkZXNjcmlw
dGlvbjogVGhlIGNoYW5uZWwgbnVtYmVyIHJlcHJlc2VudGluZyB0aGUgREFDIG91dHB1dA0KPiBj
aGFubmVsLg0KPiA+ICsgICAgICAgIG1heGltdW06IDE1DQo+ID4gKw0KPiA+ICsgICAgICBhZGks
dG9nZ2xlLW1vZGU6DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgICAgICBT
ZXQgdGhlIGNoYW5uZWwgYXMgYSB0b2dnbGUgZW5hYmxlZCBjaGFubmVsLiBUb2dnbGUgb3BlcmF0
aW9uDQo+IGVuYWJsZXMNCj4gPiArICAgICAgICAgIGZhc3Qgc3dpdGNoaW5nIG9mIGEgREFDIG91
dHB1dCBiZXR3ZWVuIHR3byBkaWZmZXJlbnQgREFDDQo+IGNvZGVzIHdpdGhvdXQNCj4gPiArICAg
ICAgICAgIGFueSBTUEkgdHJhbnNhY3Rpb24uIEl0IHdpbGwgcmVzdWx0IGluIGEgZGlmZmVyZW50
IEFCSSBmb3IgdGhlDQo+ID4gKyAgICAgICAgICBjaGFubmVsLg0KPiANCj4gVGhlIEFCSSBiaXQg
aXMgYSBsaW51eCBzcGVjaWZpYyBwYXJ0IHNvIHNob3VsZG4ndCBiZSBpbiB0aGUgYmluZGluZy4g
IEp1c3QNCj4gbGVhdmUNCj4gaXQgdW5zYWlkLg0KDQpNYWtlcyBzZW5zZS4uLg0KPiA+ICsgICAg
ICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArDQo+ID4gKyAgICAgIGFkaSxvdXRwdXQtcmFuZ2UtbWlj
cm92b2x0Og0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBTcGVjaWZ5IHRoZSBjaGFubmVsIG91
dHB1dCBmdWxsIHNjYWxlIHJhbmdlLg0KPiA+ICsgICAgICAgIG9uZU9mOg0KPiA+ICsgICAgICAg
ICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgICAgICAtIGNvbnN0OiAwDQo+ID4gKyAgICAgICAg
ICAgICAgLSBlbnVtOiBbNTAwMDAwMCwgMTAwMDAwMDBdDQo+ID4gKyAgICAgICAgICAtIGl0ZW1z
Og0KPiA+ICsgICAgICAgICAgICAgIC0gY29uc3Q6IC01MDAwMDAwDQo+ID4gKyAgICAgICAgICAg
ICAgLSBjb25zdDogNTAwMDAwMA0KPiA+ICsgICAgICAgICAgLSBpdGVtczoNCj4gPiArICAgICAg
ICAgICAgICAtIGNvbnN0OiAtMTAwMDAwMDANCj4gPiArICAgICAgICAgICAgICAtIGNvbnN0OiAx
MDAwMDAwMA0KPiA+ICsgICAgICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgICAgICAtIGNv
bnN0OiAtMTUwMDAwMDANCj4gPiArICAgICAgICAgICAgICAtIGNvbnN0OiAxNTAwMDAwMA0KPiAN
Cj4gTm90IG5lY2Vzc2FyaWx5IGEgdGhpbmcgdG8gZG8gbm93LCBidXQgdGhpcyBpcyBjb21tb24g
ZW5vdWdoIHdlDQo+IHNob3VsZA0KPiBtYWtlIGl0IGEgc3RhbmRhcmQgREFDIGNoYW5uZWwgcHJv
cGVydHkuDQo+IA0KPiA+ICsNCj4gPiArICAgICAgYWRpLG92ZXJyYW5nZToNCj4gPiArICAgICAg
ICBkZXNjcmlwdGlvbjogRW5hYmxlIDUlIG92ZXJyYW5nZSBvdmVyIHRoZSBzZWxlY3RlZCBmdWxs
IHNjYWxlDQo+IHJhbmdlLg0KPiA+ICsgICAgICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArDQo+ID4g
KyAgICAgIGNsb2NrczoNCj4gPiArICAgICAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICAg
ICAgYWRpLHRvZ2dsZS1kaXRoZXItaW5wdXQ6DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246DQo+
ID4gKyAgICAgICAgICBTZWxlY3RzIHRoZSBUR1B4IHBpbiB0byBiZSBhc3NvY2lhdGVkIHdpdGgg
dGhpcyBjaGFubmVsLiBUaGlzDQo+IHNldHRpbmcNCj4gPiArICAgICAgICAgIG9ubHkgbWFrZXMg
c2Vuc2UgZm9yIHRvZ2dsZSBvciBkaXRoZXIgZW5hYmxlZCBjaGFubmVscy4gSWYNCj4gPiArICAg
ICAgICAgIEBhZGksdG9nZ2xlLW1vZGUgaXMgbm90IHNldCBhbmQgdGhpcyBwcm9wZXJ0eSBpcyBn
aXZlbiwgdGhlDQo+IGNoYW5uZWwgaXMNCj4gPiArICAgICAgICAgIGFzc3VtZWQgdG8gYmUgYSBk
aXRoZXIgY2FwYWJsZSBjaGFubmVsLiBOb3RlIHRoYXQgbXVsdGlwbGUNCj4gY2hhbm5lbHMNCj4g
PiArICAgICAgICAgIGNhbiBiZSBtYXBwZWQgdG8gdGhlIHNhbWUgcGluLiBJZiB0aGlzIHNldHRp
bmcgaXMgZ2l2ZW4sIHRoZQ0KPiA+ICsgICAgICAgICAgcmVzcGVjdGl2ZSBAY2xvY2sgbXVzdCBh
bHNvIGJlIHByb3ZpZGVkLiBNYXBwaW5ncyBiZXR3ZWVuDQo+IHRoaXMgYW5kDQo+ID4gKyAgICAg
ICAgICBjbG9ja3MNCj4gDQo+IFRoYXQncyBub3QgY2xlYXIsIG1hcHBpbmcgYmV0d2VlbiB0aGlz
IGFuIGlucHV0IHBpbiBpcyBwcm9iYWJseSBtb3JlDQo+IGFjY3VyYXRlPw0KDQpZZWFoLCB5b3Un
cmUgcmlnaHQuIFdoZW4gSSBhZGRlZCB0aGlzLCBJIGhhZCB0aGUgY2xvY2stbmFtZXMgcHJvcGVy
dGllcyB3aXRoIA0KdGhlc2UgZXhhY3QgbmFtZXMuIFNvLCBpbiB0aGUgZmlyc3QgdmVyc2lvbiBp
dCB3YXMgbW9yZSBhY2NlcHRhYmxlIGJ1dCBzaW5jZQ0KSSByZW1vdmVkIGNsb2NrLW5hbWVzLCB0
aGlzIGlzIG5vdCBjbGVhciBhbnltb3JlLi4uDQoNCj4gPiArICAgICAgICAgICAgMCAtIFRHUDEN
Cj4gPiArICAgICAgICAgICAgMSAtIFRHUDINCj4gPiArICAgICAgICAgICAgMiAtIFRHUDMNCj4g
PiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzIN
Cj4gPiArICAgICAgICBlbnVtOiBbMCwgMSwgMl0NCj4gPiArDQo+ID4gKyAgICBkZXBlbmRlbmNp
ZXM6DQo+ID4gKyAgICAgIGFkaSx0b2dnbGUtZGl0aGVyLWlucHV0OiBbIGNsb2NrcyBdDQo+ID4g
Kw0KPiA+ICsgICAgcmVxdWlyZWQ6DQo+ID4gKyAgICAgIC0gcmVnDQo+ID4gKw0KPiA+ICtyZXF1
aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsNCj4gPiArYWRk
aXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAt
IHwNCj4gPiArDQo+ID4gKyAgICBzcGkgew0KPiA+ICsgICAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+ID4gKyAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArICAgICAgICAg
IGx0YzI2ODg6IGx0YzI2ODhAMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAiYWRpLGx0YzI2ODgiOw0KPiA+ICsgICAgICAgICAgICAgICAgICByZWcgPSA8MD47DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICAgICAgICB2Y2Mtc3VwcGx5ID0gPCZ2Y2M+Ow0KPiA+ICsgICAg
ICAgICAgICAgICAgICBpb3ZjYy1zdXBwbHkgPSA8JnZjYz47DQo+ID4gKyAgICAgICAgICAgICAg
ICAgIHZyZWYtc3VwcGx5ID0gPCZ2cmVmPjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxs
cyA9IDwwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgY2hhbm5lbEAwIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICByZWcgPSA8MD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgYWRpLHRvZ2dsZS1tb2RlOw0KPiANCj4gQ2FuIGRvIHRoaXMgd2l0aG91dCBhZGksdG9n
Z2xlLWRpdGhlci1pbnB1dD8NCg0KWWVzLCBJbiB0aGlzIGNhc2UgaXQgd2lsbCBhc3N1bWUgU1cg
dG9nZ2xlIGFuZCBleHBvc2UgdGhlIF9zeW1ib2wNCmludGVyZmFjZS4uLg0KDQotIE51bm8gU8Oh
DQo=
