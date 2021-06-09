Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506E63A0EAA
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 10:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhFIIVr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 04:21:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54964 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236161AbhFIIVq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 04:21:46 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1598BEgO001558;
        Wed, 9 Jun 2021 04:19:30 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by mx0a-00128a01.pphosted.com with ESMTP id 391jh9rf3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 04:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfeAuUQURUwxulpHEPc6f0tgUXcxpFGBC+8mWrSetDq1NAnh9h5qvCeIbTYJgaOfDLkB4m2tSt70cre/xybxVhTLGGNFUbzowc8a89ILK2bvRWY/QXn0bgyqFBUb6/aQoMsF0VHV25WeLr5jsOFM7eVtdvVm7n9Tlcx97pNiPuWxl34R+RzQM713q6Rzko2+a4HQDt3jG/DK9cwN4Y4B+KXdyXOYbypZgDgx3JkUWhP3xl2mUwR6tJT3R0FOYzeZMglkaSoDh05HIYh/PTjsiWBwOaiKEIS22KpIzdcHVYhs1oCzIeKLkp1C53vj4yQo6FwJWkFAZLC65dlCfEyLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiWy+yX00e5+7O9ZvXOz25UhQygtWFE3DXswBc/CrSc=;
 b=fFZi0qK1kDVYdgkXvneDBYrxJHA4Urrrr9R+i59YSILIg/6pRZI2H7qR5rt5RwtYAxfk6FzPM0CestJA77XJ6jC99JuDrQ7e86YNGHO4QI5U9zPxorSi30ryYK2i91HGKh6+q1OYmQ7VpBVuDtWEBxsbGye01/n2YvH3SYjx6o3tjKGqW7NsNz89G1s1KejqAZgUKR5Gjfr+GD9GaPdAe6b9NCS40CTQCbRzkCRj7xaLAuP/8IeB4j+/TlMz73WA6O8fKru/U6m5Rba9bgRQ2onnjMRfcrVcZTPQaFNn9QaROLPRwfwfKTv/09mu/xR9iK+uBv4tKPP7RpLadwn2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiWy+yX00e5+7O9ZvXOz25UhQygtWFE3DXswBc/CrSc=;
 b=uV4T6hyP9mG5W9tq90s1I+8tCXgwWKB+jDamBqJ/pMboTL2lZUDbOVgESkSb/3nA3wMRk7O0z+MfxnDz2gBNgVcHHETJ1kAnTM+Whm84LqAxmMbqxkuUP8E+GWeH0LXm5QEAl//XASk8w7cd37bnt7WF2WEyjjQGyipRKWkjRXc=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5912.namprd03.prod.outlook.com (2603:10b6:510:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Wed, 9 Jun
 2021 08:19:27 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4173.022; Wed, 9 Jun 2021
 08:19:27 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Henk Medenblik <iio-developer@freedom.nl>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: active_scan_mask
Thread-Topic: active_scan_mask
Thread-Index: AQHXUmASyfzZ4ByQ/kKjlMLrysFaD6r3CVGAgAARwQCAEVbWAIAC5ImAgAAR4YA=
Date:   Wed, 9 Jun 2021 08:19:27 +0000
Message-ID: <PH0PR03MB6366D542CBF7F389134F3E9999369@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <08a77a5c-9399-e615-f2df-3251756ed890@freedom.nl>
 <CA+U=Dsq23-y7OBuc6+YCVwpUARNO-PBCDh4Mnaqpe51k=M8Dtw@mail.gmail.com>
 <46567041-1dbf-2b00-3500-011fd722e2fc@freedom.nl>
 <CA+U=Dsp6GqpkTm1RVQdw3S_RF+4jHabM9SNyjD1vhY3qq3gKkw@mail.gmail.com>
 <b5a7e616-5d3b-5899-5c51-255c82a33e40@freedom.nl>
In-Reply-To: <b5a7e616-5d3b-5899-5c51-255c82a33e40@freedom.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5qWTJPR0kxTm1RdFl6aG1ZaTB4TVdWaUxUaGlOV0l0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEWTJOamhpTlRabExXTTRabUl0TVRGbFlpMDRZ?=
 =?utf-8?B?alZpTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTWpNeE5T?=
 =?utf-8?B?SWdkRDBpTVRNeU5qYzNNREF6TmpVNU9ERTFPREF6SWlCb1BTSmFjMEZ6WjFo?=
 =?utf-8?B?dlNXOXZTVzVDY1ZoVFJVUXJZbkJuTmk5RE9UQTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVSTNjWGRGY0VOR00xaEJaWE12YUVaMldUVndaVmMyZWl0RlZ6?=
 =?utf-8?B?bHFiV3cxV1VaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: freedom.nl; dkim=none (message not signed)
 header.d=none;freedom.nl; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:2444:9f01:25b2:379:392:475c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 605d6544-4d72-4fab-fac1-08d92b1f4c95
x-ms-traffictypediagnostic: PH0PR03MB5912:
x-microsoft-antispam-prvs: <PH0PR03MB59120E7EAE844B442A48BA4799369@PH0PR03MB5912.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6dvLWBBAhj/7gilYpwEMbm5jaaa3A4L2nwwgyXjrrSegwy1tHPS6J6PgtZkEjFGCLA43ikdyyKpIdx5KNm5NFLJCQJIuPTvs+X/rSsLFPYKluTbl7w9/DBODEblZA/SSqmF844+TzAjalsIavPw0SrFjkKJ7p9o2IURd4zDv2I9ffWwj0T0tMCiU83fP4YGY3ThrV6p93WnbEyCxo1SKl56UAJNvR0Dn5vUpZcml2EyHoT9msK6SB1ioIF4YEkQUSF0/n1/noDpr4P0KnGP3xplF0JMRw4hQPqju6quvQZm9Ke5R2C9nwmxHY2p2ZdDYPBy/nTtAKDOpNbEPcaDx81FQHerYyk97xrPrUep/S14IJoP4H52wAzEgJzHRqWliPkqhgbSaHjtm1tTLKcmT4lQA3dGSvlZ+57NL4CmhiysNw3IDqDqdRpeR/ei8dzkqGWQnlEtaHFUqHpdZDWqnQXnoX+wUGpLzz3ziVd606GWUzE/avvXhfTAphFuyc2VHvDl2XUlM/NJtdVBpc+NJpUVVoFTqQrituQ/gdh+Lo4btMNywRT79xkdaeN4oTtBgERKIuizybhJXXwhM44xk3LEGkcjKGjDSsmKpUqzmq6UozRrZTALM05DG58TziWxP4J5BHFjIvWaPdFtnbmwIPhux+t1CsgN6dSnBbXlK/1piyKflxNnOpQirPKqGxEK7ogPjyGZDhaCW/0ojkXl9Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(52536014)(9686003)(186003)(76116006)(966005)(54906003)(8676002)(6506007)(2906002)(316002)(4326008)(66556008)(66946007)(66476007)(64756008)(66446008)(86362001)(5660300002)(122000001)(71200400001)(7696005)(83380400001)(8936002)(478600001)(33656002)(53546011)(38100700002)(7116003)(55016002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHlKc1h6V2NtcGd1NGJReDIzcUZvMVVlK3RYN1gzdzErL09Pc3Zlbk9NRmFy?=
 =?utf-8?B?M3BxTHhXOWIwL0gzTDlaZ0p1bW1pVStjSXNkVzRCb1orSm1UNHcrZ0VMK3I5?=
 =?utf-8?B?VUl4V2cwREtLbzJicmlSclI0SEVia3gyN0ZLWjRpKzJ2ZGRuQ1pUWkdLd0gy?=
 =?utf-8?B?VXl1QmlxWlNnbzJsNFJYNnlyc1pkTDNraHd2MVVyK1ArWEFmTENrMjQvTjZS?=
 =?utf-8?B?QXE3Ym1pdG5VK0xGcGFveFlNenp0Rm0zNGZWT3VXZU1HSGlYdDFQc1NJRmZD?=
 =?utf-8?B?STlYS2pHbDlOenI0N1dNa0Q0bXlNdFI1eDltbzF3dG1RZUwzTklZcFUxa3c2?=
 =?utf-8?B?T1h1WGRGVjMxMjA1b2FWL1BON0xwYVBXWklvbzhNV1k0ZTBMc21RL3FiSWZZ?=
 =?utf-8?B?NkZyVkJ0L2FiZUtIUWJ6M1F1T1haaWdhMUpmeElwUkc3S3g0NDZnUnpYRUtY?=
 =?utf-8?B?UkovalVIWW1OcktjMDVCQThLaTZsZ24wcXVFaHZmNW9XTkYvM1ZxL3RYU3Jq?=
 =?utf-8?B?VWlDTTRXWHNKUXZjcGVvb2tBSmh3VVovSFd6UVcybU1PN1g4U0tFRkYydXhJ?=
 =?utf-8?B?ejR5OXdmL2Vhc3ppZDRJSUJSNzVGMG1XWkp1UEd0ZzZMK1RKekE0RWlEQlE4?=
 =?utf-8?B?ZldjL2NGbjlLS2FUMlVuUVRZdS9SUTE2eHQwcERzSmVmUngvc3J3ZVhjNDVV?=
 =?utf-8?B?dEFsSThSaFQrMW1taFJzRWFpQ1YrTG1KT1Rsd3ZPVjlsTUlrcERvZkZXeUFx?=
 =?utf-8?B?QkthL05XSTRGbmptOEJRdXptMDYyNkJ1c2RJLzBpc2lCbE9CTTZWOGc5aXFV?=
 =?utf-8?B?S1c1UFpXTnk3Z2x3cGplQS9teFBTbmlTU2xvZGtReXBlclkyVm5oa0t3TXk4?=
 =?utf-8?B?T09JYkpqZGYvUkw4VU9IL2VnS3U4dVJTVHdnMW92QW1UTzFIZllZWG1iVG5E?=
 =?utf-8?B?VDFNc2JmTndSZ0F5Z1FXamdraW53b2ZWMHdlb29BS1BraUEyZloxQWFjTnc3?=
 =?utf-8?B?SzJrc0FVcnFNWHA3a2RmQ0g3S0h4blVERGZmZVNKOURUdUE1alFlNERNNTdB?=
 =?utf-8?B?S1gwNDNpdVlnUWFBTUZKUkFkUzlvMHZ3RUJHcjhwMys3aWVTNlVaVHVHYlV5?=
 =?utf-8?B?Zkd0MFZESmkvajFJMEJJbTNMSWc0R1ZSL3I3TnlHVVhUZlRONFdJT0FWYVdv?=
 =?utf-8?B?Mm9wL2JZTkVUL3UxTDlzQjc2SkRIeC9aSlpjTUJhZy9wYmZDSW1KUXhwcm5X?=
 =?utf-8?B?UGppQktRWFo4TzBMYStESXdZaWo4T0F5ZVdPaDZXY0w2di9FUVhJVTVOd0wz?=
 =?utf-8?B?WmRwOWN4SlY4a2FTb2tqakNuNkNRa2pabVdnQkI3N1cveGJaZjJBV0Q5WHNi?=
 =?utf-8?B?TEpWdllnZGJpZGd1RTJJK0Q0U1pjbTVkRWV6V2VjVHF0QS81OHJmcjNkSEtX?=
 =?utf-8?B?RGViTUNzOVBwaFdLcnJMQ3hYWnViRlZVSDZuU1ZQOGRVRXZpMGxpMnVKUUJF?=
 =?utf-8?B?a1BQbnVxRFY3YUwvbHBUcnlhQ04rUlVsb0w4RmpENUV4c1o4WDJPUURTNWxz?=
 =?utf-8?B?QWgwOXVhTjZQV3RhTjlsdUZqeFR2MVJvcUN4c0dTRlgxMnRucXhHYUVrOGdX?=
 =?utf-8?B?R1pNVFFwQ2dZR3dqYmUzZ1EzUkV0dUl5ZFhmdWdjVWYvby9uSml1N094aVZQ?=
 =?utf-8?B?VGZKVmFnR2p3dCt2dExZT0lNMXY2YWg5NzhDTGF5bzZDNkU2L3Z4R1crMWhS?=
 =?utf-8?B?akhMT0k2SWpvWm1laUhjcExjUm5aOGhScEtTTU0xM2xHWEpJR0sySVZtaVVB?=
 =?utf-8?Q?AUJrvO5oQzKvv8mYm+2icL66v83U/ynHBbLWo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605d6544-4d72-4fab-fac1-08d92b1f4c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 08:19:27.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgNVm15hYVy+QS7UNG7LcD7z5IRiLhK19PmjKdki93KVSGSuupOf853tXEUSPA3I1oQqRbB4Oa62ehX05x1pKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5912
X-Proofpoint-ORIG-GUID: T_WGcoD7ySFOXENQ8Bw4QIGmZ-GAZX55
X-Proofpoint-GUID: T_WGcoD7ySFOXENQ8Bw4QIGmZ-GAZX55
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_04:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090035
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSGVuaywNCg0KPiBGcm9tOiBIZW5rIE1lZGVuYmxpayA8aWlvLWRldmVsb3BlckBmcmVlZG9t
Lm5sPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgOSwgMjAyMSA5OjA0IEFNDQo+IFRvOiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFyZGVsZWFuYWxleEBnbWFpbC5jb20+OyBIZW5rIE1lZGVuYmxpaw0K
PiA8aWlvLWRldmVsb3BlckBmcmVlZG9tLm5sPg0KPiBDYzogbGludXgtaWlvIDxsaW51eC1paW9A
dmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogYWN0aXZlX3NjYW5fbWFzaw0KPiANCj4g
W0V4dGVybmFsXQ0KPiANCj4gRGVhciBBbGV4YW5kcnUsDQo+IA0KPiA+IEhtbSwgc28gdGhlICJ6
ZXJvY29weSIgYnJhbmNoIGlzbid0ICBhdCB2MC4yMS4NCj4gPiBJdCdzIHNvbWV0aGluZyBtdWNo
IG9sZGVyIFsgfjYgeWVhcnMgPyBdLg0KPiA+IFRob3VnaCB0aGUga2VybmVsIGFjdGl2ZSBzY2Fu
IG1hc2sgaXMgdW5yZWxhdGVkIHRvIGxpYmlpbywgc2luY2UNCj4gPiBpaW9fcmVhZGRldiBpcyBi
ZWluZyB1c2VkIGluIGRpZmZlcmVudCBzZXNzaW9ucy4NCj4gPg0KPiA+IFRoZSA0LjE0IHZlcnNp
b24gb2YgdGhlIGtlcm5lbCwgaXNuJ3QgcXVpdGUgbmV3Lg0KPiA+IFRoZXJlIHdhcyBzb21lIHJl
Y2VudCBmaXggd2l0aCByZWdhcmRzIHRvIGFjdGl2ZSBzY2FuLW1hc2sNCj4gY29tcHV0YXRpb24u
DQo+ID4gQnV0IEkgYW0gbm90IHN1cmUgaWYgaXQncyByZWxhdGVkIHRvIHRoaXMuDQo+ID4NCj4g
PiBXaWxsIHRyeSB0byBtYWtlIHNvbWUgdGltZSB0byBkbyBzb21lIHRlc3Rpbmcgb24gdGhpcy4N
Cj4gPg0KPiBJIGJlbGlldmUgaXQgaXMgYSBidWcgd2hpY2ggc3RpbGwgZXhpc3RzIGluIHRoZSBh
ZGkgbGludXgga2VybmVsIHNvdXJjZXMuDQo+IEluIGluZHVzdHJpYWxpby1idWZmZXIuYyA6DQo+
IA0KPiBzdGF0aWMgaW50IGlpb19jaGFubmVsX21hc2tfY2xlYXIoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldiwNCj4gIMKgwqDCoCBzdHJ1Y3QgaWlvX2J1ZmZlciAqYnVmZmVyLCBpbnQgYml0KQ0K
PiB7DQo+ICDCoMKgwqAgdW5zaWduZWQgaW50IGNoOw0KPiANCj4gIMKgwqDCoCBjbGVhcl9iaXQo
Yml0LCBidWZmZXItPmNoYW5uZWxfbWFzayk7DQo+IA0KPiAgwqDCoMKgIG1lbXNldChidWZmZXIt
PnNjYW5fbWFzaywgMCwNCj4gQklUU19UT19MT05HUyhpbmRpb19kZXYtPm1hc2tsZW5ndGgpKTvC
oCA8LS0tLS0tLS0tDQo+ICDCoMKgwqAgZm9yX2VhY2hfc2V0X2JpdChjaCwgYnVmZmVyLT5jaGFu
bmVsX21hc2ssIGluZGlvX2Rldi0NCj4gPm51bV9jaGFubmVscykNCj4gIMKgwqDCoCDCoMKgwqAg
c2V0X2JpdChpbmRpb19kZXYtPmNoYW5uZWxzW2NoXS5zY2FuX2luZGV4LCBidWZmZXItDQo+ID5z
Y2FuX21hc2spOw0KPiAgwqDCoMKgIHJldHVybiAwOw0KPiB9DQo+IA0KDQpUYWtlIGEgbG9vayBh
dCBbMV0gZm9yIG1vcmUgZGV0YWlscy4gTG9uZyBzdG9yeSBzaG9ydCwgSSB0aGluayB0aGlzIGlz
IGhlcmUgYmVjYXVzZSB3ZSBoYXZlDQpzb21lIGRldmljZXMgd2hlcmUgd2UgaGF2ZSBiaXQgZ3Jh
bnVsYXJpdHkuIEhlbmNlLCB3ZSBtYXAgYWxsIGNoYW5uZWxzIHRvIHRoZSBzYW1lDQpzY2FuX2lu
ZGV4IGFuZCB0byBkaXN0aW5ndWlzaCB3aGljaCBjaGFubmVscyBhcmUgZW5hYmxlZCwgd2UgY291
bGQgbm90IHVzZSB0aGUgY3VycmVudA0KdXBzdHJlYW0gaW1wbGVtZW50YXRpb24uIEkgcmVtZW1i
ZXIgc29tZSB0YWxrcyBhYm91dCB0aGlzIGJ1dCBub3QgYWN0dWFsIHBhdGNoZXMgDQpjYW1lIGZy
b20gaXQgKEkgd2lsbCBoYXZlIHRvIGdvIG92ZXIgdGhvc2UgZW1haWxzIHRvIHNlZSBpZiBJIGNh
biBjb21lIHVwIHdpdGggc29tZQ0KcGF0Y2hlcykuDQoNClJlZ2FyZGluZyB0aGUgbWVtc2V0LCB0
aGF0IGxvb2tzIGxpa2UgYSBidWcuIEkgZ3Vlc3Mgd2Ugd2FudDoNCg0KbWVtc2V0KGJ1ZmZlci0+
c2Nhbl9tYXNrLCAwLCBCSVRTX1RPX0xPTkdTKGluZGlvX2Rldi0+bWFza2xlbmd0aCkgKiBzaXpl
b2YoKmJ1ZmZlci0+c2Nhbl9tYXNrKSk7DQoNCkNjaW5nIExhcnMgYXMgaGUgaW1wbGVtZW50ZWQg
dGhpcyBwYXRjaGVzIGFuZCBtaWdodCBoYXZlIHNvbWV0aGluZyB0byBhZGQgdG8NCnlvdXIgcXVl
c3Rpb25zLg0KDQpwczogZmVlbCBmcmVlIHRvIHB1c2ggYSBQUiB0byBBREkgdHJlZSBpZiB5b3Ug
Zml4IHRoaXMgOikNCg0KLSBOdW5vIFPDoQ0KDQpbMV06IGh0dHBzOi8vZ2l0aHViLmNvbS9hbmFs
b2dkZXZpY2VzaW5jL2xpbnV4L2NvbW1pdC84MWQwMDc5NWIxNTM3YThjZmQzZWI1MTUyYjMwYWU0
MDdjMGUxNmU3DQo=
