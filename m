Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D453ED16A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 11:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhHPJ6r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 05:58:47 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:24634 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235336AbhHPJ6q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 05:58:46 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17G063QF009534;
        Mon, 16 Aug 2021 05:58:02 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0b-00128a01.pphosted.com with ESMTP id 3afd66sa5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 05:58:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V72SWN4+bNywvmActcpfcnKr4VVDeSjPFpup+wUIFbDN+nwoBOJVztdoEF7BhVhtlRsNLQ56f0jut/WenLQtWvaOM7uOAJ/ur6qIBJ1Bb8J8bmqJ/fotcL8XouCHsQH8n8eYkay0i5bq2yxZfo13iqa0jLiU0094XiwDf0mTXZtauxO/P9aLec0FIfFl6DMdm3kwX2P4Q3kTjBZRWKQSwXLBZwUJ8Mc0/+gc68cEH2LvPeA7S1OXTRnizZNzbjoEqd3b0bXxdLM82mVinMIb2t8D0cDnA/xu0UJqcH/QWn747fDKTxK3f+MLnfN/z+dspecEuuZHoawavDrBiP2p1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ3BJKeCtlXFgZh2YXjADP0Us3/ID5oF6M4KYnBdM10=;
 b=b0jBBhODublRGSNkRaDSqd0+0+C8H+5rQEuAp/FtuoL5K54zUv7hFuK6j+N4FOnaufb+0lOkoIORw9nGjBTDuXYb5vU/nScrh1cQnlyMJN3qXWO0LOA82b531IdzIrl0UsMg3Aa5jFt3CIyDkk+zPMW7aUJ52LIBhxWD3DVXaVwLoKECLb+3mLXVsbmlXWfzBhAQYKZlrwqMR5YWh9b6RI0AVnnlO7vhFATHqyVi3wpXiz4MkwUeqGZ5Ej0sdDtihY63mXJdB4TJIkZs7+NrWk1ovHrRPCF4BiMnCnSe3ItYS3yIuCIIquH7lj3wWyEUT9OSb0527PK0AtMsn5ZcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ3BJKeCtlXFgZh2YXjADP0Us3/ID5oF6M4KYnBdM10=;
 b=mucxhfr4FFH3cmIItg8YUc8fsvRIHBIR9x/760pFDmnL1iAIynv1r7zc0J3E/8AZVCSNVluAeto0MBWP/yvandbWfWJQZgOvNNwD4IicHcoGJupzZpX03AV9egNcVWJelx1nAp4srHdyyi7+L15nEbkI0myo4n3cXTWm94Ec5kA=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5880.namprd03.prod.outlook.com (2603:10b6:510:32::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Mon, 16 Aug
 2021 09:58:00 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.021; Mon, 16 Aug 2021
 09:58:00 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: ad5770r: make devicetree property reading consistent
Thread-Topic: [PATCH] iio: ad5770r: make devicetree property reading
 consistent
Thread-Index: AQHXjoTpWS49/XePMUytpStcxW5zfKtud/2AgAD4urCAAANBAIAAEoswgAB044CAAQ8qwIAADCQAgAAhX3CAAfbiAIACmpHAgAAFwQCAABOREA==
Date:   Mon, 16 Aug 2021 09:58:00 +0000
Message-ID: <PH0PR03MB63663C0120F48B89EDF4990199FD9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210811074827.21889-1-nuno.sa@analog.com>
 <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
 <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com>
 <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com>
 <PH0PR03MB63662507607DD7E06995B7EE99FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75Ve=C62FmC20qkLsMVFkc-rbhHqmY2StDtrYqG0=mjtcTw@mail.gmail.com>
 <PH0PR03MB63665918437E96CAF35B7CD799FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210814170204.387bf394@jic23-huawei>
 <PH0PR03MB6366A5DE7A67BE19759E929499FD9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75VcMG9F33y0YrNrGc=weFZkZ6m7h6_tkjY=ygxPOnagXZg@mail.gmail.com>
In-Reply-To: <CAHp75VcMG9F33y0YrNrGc=weFZkZ6m7h6_tkjY=ygxPOnagXZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5tVmxZbU0wTkRZdFptVTNPQzB4TVdWaUxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEWmxaV0pqTkRRM0xXWmxOemd0TVRGbFlpMDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWprNE5T?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTFPREUwTnpnMk56STROekk1SWlCb1BTSmpVbTg0U0Vo?=
 =?utf-8?B?MGFsaHVSVmRIU3pCM1oyUXZjbXh6YkVSRVVrazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRmFkekZWZUdoYVRGaEJWSFZMU2tsamJtRmpXRUpQTkc5cmFI?=
 =?utf-8?B?bGtjSGhqUlVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 757c7c00-5f6b-4dbc-8f7e-08d9609c54ec
x-ms-traffictypediagnostic: PH0PR03MB5880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB58805FCFC76893F303877ED099FD9@PH0PR03MB5880.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5S/sRsl7Fx5I3k8qU0uNeOjL4rlAZ2X+CbTYY4ZXHnXm5+8F6ReowDYJBoL6cdD4KlV+Q3NORQ90nqXjhbirVpCUA2omgvDC2MICiEH9buy54pz8zJHaqYGxzGcGLRzoqpFZdFF9jBAldA8jApA1f/rTt/cIiCU7rhuIF9fYNadA38xaC1b6GvsnQSgBki1F4fVNpsbt+uo+6T16eFUuZ6gCBTPpxXFrvpqxwVnniJzK97C3J3mZBhCZjeDaYwmEWI00bRB19JJQQDrCPN36RN8oNsBlnYH1warFczxkam4S7KQqvYoQeoXhekbCIrBPpAY162bLzlARlEnGqcv8nzGzoHNSwuWLPvcFnjf4f/Nou2JW1xL2nzKGuC3U2446pUWncy5tndAg3vgZygPAcLGoBeKsdM9UjJsBe3Z/fHK61c1nVXC0ziVb4pdKskaJl9pheVHN7VADe+Yx1CywRaqxATiCa3AZLVOgQjcknBbt+tV4mugwzKn/WHnSzJ0YTVWX+ANMtQ6ZglShZh4bmUcUfyhE41mMHsh4xI1+oiE0UTTSGJZI5IVdRL0A615AYZ7yGSZaPD/b5WNP7NEtB3ojbCKXTyiKJhtqFH2OMjzxdgZ6Bw6R0UkLjVwJFwh8UPstvflpoqYxMN0JdAQW9BL0ndaBECWqreozmT+FlhfBWT6VuxDGFbb9Wmdo4zV+ebQMMLiNmNljQgv7HoTEG/K6AZeBi+LiKdvoAnrANmk14sLHPK1jfbyZsKiH7ci4sIeh/YrZqu0dDTizd1c5DcpHpiLfrxqxdnTfKasgWW0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(53546011)(316002)(4326008)(6506007)(7696005)(86362001)(38100700002)(966005)(478600001)(54906003)(122000001)(9686003)(52536014)(55016002)(66556008)(66446008)(186003)(66476007)(8676002)(76116006)(64756008)(5660300002)(2906002)(66946007)(8936002)(38070700005)(83380400001)(26005)(71200400001)(33656002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDlUUmxCaGM0ZUZhTUhkYjlEN1ZZMCtKMjFJdk9mR1NnUjlJT3dLRkc4M0hE?=
 =?utf-8?B?b055dXJ4REh5cE9mNXNKdjRaUFl3YzVoZWRkNkZqdXZyWWdPNDhwcXRpTkRJ?=
 =?utf-8?B?M2tuVThjVDhzTTdRdGtLWU83Z1dOak9aWXc4SUxFK3g1aVNxV0ljK0ZFeWFN?=
 =?utf-8?B?V2lQY2pUN3RoZWZuak5BMmFpN042aThieUFFamhUQkFqQXZHQkxBdVNLaENM?=
 =?utf-8?B?QnIwNnk0TWQwQnhzZTNWYWZKMW0zWWk0NStMTEVoWjh5aFlkRnIzb0EyTUdu?=
 =?utf-8?B?STM0V1lzcjgzU2JFQVdZcTZERFQyelBndW5Tdk51ZnVubWFaSHVmMTVoMFRD?=
 =?utf-8?B?M1A3RW9vblluZmg3TGN3MDdZQ0Jib3d3dklCYnhQN2EvN085b2o2Wm1nWkN4?=
 =?utf-8?B?U0tNTFFPZHRsRUE2S2FmV296YW15YzR4WkFzYW1VNlIwYkRzOENuNkZDVXd6?=
 =?utf-8?B?aDJRNFpLeDI2WUJPeXdZUE1UcUtRTU9sQVB1QWROdUlObi95dkg2ZnFjVDNu?=
 =?utf-8?B?cU4yblJVSjhjZGpSc1ZnSzFZd1htOWw3aWFpNmg3VTZ3WkpSQ0VnT1ZzNVdh?=
 =?utf-8?B?amtQdWJYblRueHFXVkJLeDJNZUc1cytkL1Q3V204R3hsanp6SjRYMnlabjZs?=
 =?utf-8?B?TXpLWm5uSUJCWWFRZ3ZkU1hoejQ1bDRhWW1GT1FFb1ZGRExPU0lnNmZaVE9Q?=
 =?utf-8?B?dCtaamlxYUs0Z1paMktKMERZUC9UZGdmVllBdmhiSGhadldUSWJZdVdPUFRI?=
 =?utf-8?B?MTdUeHBRWEVUMmdQUmwwZTlXZmxiWm9xSXVFbERWVERKQndzM0NObkhtVnhX?=
 =?utf-8?B?T0pFaGMwb2JBeFRDTHhkS2QxamlpaGltNmhJOG8wTk11dWxRcnVsdUJsUmE3?=
 =?utf-8?B?aWZtemdHVzNIQU12OExWS2M1bUFLUjROaXoyamVhRENaY215blZEa3BkOU5m?=
 =?utf-8?B?akVtOWdXKzlxU0tNK09adHJxbTBxQ1dWWUpGMjdVRzk0eUFDbFFwYjNuY1pS?=
 =?utf-8?B?ems1K3ZZRDhEb25BeGpyQUY5Y3NTZDBHTzdwTE5WOWlLUlJGWnE1QStEU3NL?=
 =?utf-8?B?Y1dHRzYxd2ZocS96dUsyRzVJZks5VWNoNzdRNmVHMDNrTzJpV21ZWFBLdmpK?=
 =?utf-8?B?QU9EYnRPOTQvRjMySHlhMlVjYjF4R2J5NUJCRmNtdUova1QzNXBEZ21WZ1lY?=
 =?utf-8?B?anA5THpLY1cwOXdxdkx2UithbWM0ZEZZb2ZERDlBU0RqRlpPcjZGSTl5Rzhl?=
 =?utf-8?B?bHZlTThHR0xPQWpZWDJrUHo5L1pnU21BWSsvS3lvOWFYbWd3VVczb1BpM2N0?=
 =?utf-8?B?L2I3SWFuS0VVZzkvcVhWWVMyaktsMkRHYjZxMnFGeFdkN2hyNUxmNXNqaVdi?=
 =?utf-8?B?WVMvL2t4cDR2MWlWSVZHMXRCeVFWL012MTBBTWYyL1FnR2xlZXp3ZHNWaEVB?=
 =?utf-8?B?SmdzcFNaYy9Zd1dEYit4RHNFYUpaVk42K3VPU1RqL05JUTVRNE1UVVZNTVBw?=
 =?utf-8?B?WTNhMEg0VEdyL0RWS21OcC95cHdmK0VnYUwvR1lKcGkzcFpuYndRSTY2eUJU?=
 =?utf-8?B?K2tGRWpPcHJZVXFUZ0NtMzlQQlJXdTFGTE5CNzFhalV4RmwwUS9uVHcyR1ll?=
 =?utf-8?B?WWZzRi81S01wbFFwdC9RRE80VFJKU2pVOUhwbXVQSUxhLzhMSVdXU2xqSUVO?=
 =?utf-8?B?b2UyWGtDeWVvSFNuZlVXanJsRVdoNWQ3T1VXWkt6R1dvYzJNdXB2M0Y1UzBB?=
 =?utf-8?Q?l+jmLbO06vDoJFs0oAXrBNTBdkulwGI3r86TOMR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757c7c00-5f6b-4dbc-8f7e-08d9609c54ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 09:58:00.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjTfOKdyGAovNhMJy2xfq8bv9EyEcHgHmluQES3eIp8O1DeHQbxdaBNwEI4azQJPnYJ6lEHspSnlV2hq0SmI+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5880
X-Proofpoint-ORIG-GUID: xLVnc8p8WT0bIR3Kn7jqk81b8dUT169I
X-Proofpoint-GUID: xLVnc8p8WT0bIR3Kn7jqk81b8dUT169I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-16_03,2021-08-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108160062
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAxNiwg
MjAyMSAxMDoxMCBBTQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gQ2M6
IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZw0KPiA8cm9i
aCtkdEBrZXJuZWwub3JnPjsgbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPjsN
Cj4gSGVubmVyaWNoLCBNaWNoYWVsIDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsgTGFy
cy1QZXRlcg0KPiBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGlpbzogYWQ1NzcwcjogbWFrZSBkZXZpY2V0cmVlIHByb3BlcnR5IHJlYWRpbmcNCj4gY29u
c2lzdGVudA0KPiANCj4gT24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMTA6NTQgQU0gU2EsIE51bm8g
PE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4gV2VsbCwg
SXQgc2VlbXMgd2UgbmVlZCB0byBnbyB0aHJvdWdoIHRoZSBzdXBwb3J0IGJvdGggJ251bScgYW5k
DQo+ICdyZWcnDQo+ID4gcm91dGUuLi4gSSBkaWQgc29tZSBnaXQgYmxhbWluZyBhbmQgaXQgdHVy
bnMgb3V0ICdudW0nIHdhcyBhY3R1YWxseQ0KPiBzdXBwb3J0ZWQNCj4gPiBpbiB0aGUgYmluZGlu
Z3MgWzFdLiBBZnRlciBzb21lIHRpbWUgaXQgd2FzIHJlcGxhY2VkIGJ5ICdyZWcnIFsyXQ0KPiBs
ZWF2aW5nIHRoZQ0KPiA+IGRyaXZlciB1bmNoYW5nZWQuLi4gSSBndWVzcyB3ZSBoYXZlIGEgc2ln
bmlmaWNhbnQgd2luZG93IG9mIHRpbWUNCj4gaGVyZQ0KPiA+IHdoZXJlIHNvbWVvbmUgY291bGQg
ZGVwbG95IGEgKnZhbGlkYXRlZCogZGV2aWNldHJlZSB1c2luZyAnbnVtJy4uLg0KPiA+IElmIG5v
IG9iamVjdGlvbnMsIG9uIHYyIEkgd2lsbCBqdXN0IHRyeSB0byBnZXQgJ3JlZycgYW5kIGlmIG5v
dCBwcmVzZW50LA0KPiBmYWxsYmFjaw0KPiA+IHRvICdudW0nIGJlZm9yZSBlcnJvcmluZyBvdXQu
DQo+IA0KPiBPdWNoLCB0aGFua3MgZm9yIGRpZ2dpbmcgdGhpcyBvdXQhDQo+IA0KPiBTbywgaXQg
bWVhbnMgdGhlIGZvbGxvd2luZzoNCj4gMSkgYWRkICJudW0iIGFzIF9vYnNvbGV0ZV8gcHJvcGVy
dHkgdG8gRFQgYmluZGluZ3MNCj4gMikgYWRkIHN1cHBvcnQgb2YgInJlZyIgdG8gdGhlIGRyaXZl
cg0KPiANCj4gPiBbMV06DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgvaw0KPiBlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0L2NvbW1pdC8/aWQ9ZWE1MmMyMTI2OGU2OGNmZGMxYWFiZTY4NmINCj4gMTU0ZDczZDhiZjRk
N2VfXzshIUEzTmk4Q1MweTJZIXBYWWxrZWtzZXIyUEdicXJKWldwQ1hRMG94cDQNCj4gT1VOZE9w
UmwwM1g5alJoZ3JqLWpQYUVfV0I3aHNBV0VBQSQNCj4gPiBbMl06DQo+IGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgvaw0KPiBl
cm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9MmNmMzgxOGYxOGIyNjk5MmZm
MjBhNzMwZGY0DQo+IDZlMDhlMjQ4NWZkNjdfXzshIUEzTmk4Q1MweTJZIXBYWWxrZWtzZXIyUEdi
cXJKWldwQ1hRMG94cDRPDQo+IFVOZE9wUmwwM1g5alJoZ3JqLWpQYUVfV0I3ZV92MUQ0ZyQNCj4g
DQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KDQpIaSBSb2IsDQoNCkFzIEFuZHkgc3VnZ2Vz
dGVkIEknbSB0cnlpbmcgdG8gYWRkIHRoZSAnbnVtJyBwcm9wZXJ0eSBiYWNrIHRvIHRoZSBiaW5k
aW5ncw0Kd2l0aCBhICdkZXByZWNhdGVkOiB0cnVlJyB2YWx1ZSBmb3IgdGhlIHByb3BlcnR5LiBJ
IHdhcyB0cnlpbmcgdG8gZ2V0IHNvbWV0aGluZw0KbGlrZSAodGhlIG1haW4gaWRlYSBpcyB0byBo
YXZlIGVpdGhlciByZWYgb3IgbnVtIGRlZmluZWQpOg0KDQpjaGFubmVsQDA6DQouLi4NCiAgcHJv
cGVydGllczoNCiAgICAtIG9uZW9mOg0KICAgICAgICAtIHJlZzoNCiAgICAgICAgICAgIC4uLg0K
ICAgICAgICAtIG51bToNCiAgICAgICAgICAgIC8qIG5vdCBzdXJlIGlmIGl0IG1ha2VzIHNlbnNl
IHRvIGdpdmUgdGhlIHNhbWUgdmFsdWVzIChkZXNjcmlwdGlvbiBhbmQgcG9zc2libGUgdmFsdWVz
KQ0KICAgICAgICAgICAgICAgICBhcyBmb3IgJ3JlZycgKi8NCiAgICAgICAgICAgIGRlcHJlY2F0
ZWQ6IHRydWUNCg0KSG93ZXZlciwgSSdtIGZhaWxpbmcgdG8gZ2V0IHBhc3MgdGhyb3VnaCB2YWxp
ZGF0aW9ucy4gSXMgdGhlcmUgYSB3YXkgdG8gbWFrZSB0aGlzIGEgb25lT2YgYXMgSSdtDQp0cnlp
bmcgdG8/IEknbSBmZWVsaW5nIHRoYXQgdGhlc2UgY2hhbm5lbCBub2RlcyBzaG91bGQgaGF2ZSBh
IHJlcXVpcmVkIGtleSB3aGVyZSB3ZSBjb3VsZCB1c2UNCm9uZU9mIA0KDQpNb3Jlb3ZlciwgaXQg
c2VlbXMgdGhhdCB0aGUgdmFsaWRhdGlvbiBlbmZvcmNlcyB0aGUgJ3JlZycgb3IgJ3Jhbmdlcycg
Zm9yIGNoYW5uZWwgbm9kZXMNCmxpa2UgdGhpcyAobWF5YmUgdGhlIGZpeCBbMV0gd2FzIGFjdHVh
bGx5IGJlY2F1c2Ugb2YgdGhpcykgc28gSSB3b25kZXIgYWJvdXQgbXkgc3RhdGVtZW50IG9mDQph
bnlvbmUgaGF2aW5nICJ2YWxpZGF0ZWQiIGRldmljZXRyZWVzIHdpdGggdGhlIG9sZCAnbnVtJyBw
cm9wZXJ0eS4uLg0KDQpbMV06IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTJjZjM4MThmMThiMjY5OTJm
ZjIwYTczMGRmNDZlMDhlMjQ4NWZkNjcNCi0gTnVubyBTw6ENCg==
