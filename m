Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB683A1628
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhFINyt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 09:54:49 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47030 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234624AbhFINys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 09:54:48 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159DpruI023590;
        Wed, 9 Jun 2021 09:52:32 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 391jh9srqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 09:52:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuDr+1f1pZpz2if3Y868H4uwHBnzFgzMclIdcycwUq20/C5nTgKfDeMX3WUjLSUs0lg8+GgB2SovNo12FFSP7Z/rJNNmDyhsAa1flJd0CAJZBMssNmLWVMr/jKMB8TYdPv+TLi6axAWjZYtAhRmyZVOKIfKEyRBhuXPWwpKRcOMYUxMjoEaCSZ4Vf9sYwecSAt/hPkI6rooOTO/plygEjREjpqjO8pXoierYgqCwmY4TucC1eevPnxGll+Q1lWnDGXcaxBnmS7y6KocQPYJZT5H7AAaEhZlSYsb3t14ebPB/U9L4gAD920BJrQ0gbHwEGhMXP8/8Lz4mJ5pxaPGqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ9WtKx2WJHXfQPRuYF1QdcVFDc2p9VKupk4FIHsJec=;
 b=XWtbcumnu7LPxX1VuJ6O3obXs7hkqMOYb+GMPLS2NO9p1oiKlHGbkytw9cOcqvpTE91WS8nN/NTpWw4dX2fU28exYhC8BwEsL5M/7xgYEnVpCMHHtAQ2UuDl1bC8I9uaOFy0VvzFvEt9ff+P+fB2uaGyAE7U2j7zmEtDGyVVqm2oJD92ldi0tKQoZplJKdTG6gPzPd4tHsjR7SlnCiFRiN/uJKLoR21lwDwp61RJzz+r/OTnEfRRUbsa1I5UA2tDG7003aEFgnrxBQwKcn3v5HKNBSdndS97I8/k+jAabuC/IncKW4GdEdIJGGJB5Kuj8JubSQ6sPcNeLbErYsHWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ9WtKx2WJHXfQPRuYF1QdcVFDc2p9VKupk4FIHsJec=;
 b=MU1mK+JPt2V1Jgg88jKL4vxEVh5XKh9tqHarPvqFx3/NSNnX4Z++3A7EUAOy1lBhh5PmOG9HrDM+89mvRrMNe6V5ILdk5Iafpvu+eAEvbBhsv1pd1Q7XuDPAJl8ze6lO72UesDdLZLxCEjZDW6ociyy2n7dMzUD833TJH7OFC3o=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 9 Jun
 2021 13:52:30 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4173.022; Wed, 9 Jun 2021
 13:52:28 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Henk Medenblik <iio-developer@freedom.nl>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: RE: active_scan_mask
Thread-Topic: active_scan_mask
Thread-Index: AQHXUmASyfzZ4ByQ/kKjlMLrysFaD6r3CVGAgAARwQCAEVbWAIAC5ImAgAAR4YCAAA0+AIAAC+kAgABEjACAAAHpUA==
Date:   Wed, 9 Jun 2021 13:52:28 +0000
Message-ID: <PH0PR03MB6366B5602B652A7215B168F199369@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <08a77a5c-9399-e615-f2df-3251756ed890@freedom.nl>
 <CA+U=Dsq23-y7OBuc6+YCVwpUARNO-PBCDh4Mnaqpe51k=M8Dtw@mail.gmail.com>
 <46567041-1dbf-2b00-3500-011fd722e2fc@freedom.nl>
 <CA+U=Dsp6GqpkTm1RVQdw3S_RF+4jHabM9SNyjD1vhY3qq3gKkw@mail.gmail.com>
 <b5a7e616-5d3b-5899-5c51-255c82a33e40@freedom.nl>
 <PH0PR03MB6366D542CBF7F389134F3E9999369@PH0PR03MB6366.namprd03.prod.outlook.com>
 <2bf66558-8a90-f27c-6c8a-b149a79aaa0e@metafoo.de>
 <f09cae31-1be5-4693-7629-d172724db85a@freedom.nl>
 <63bf4b2f-b56f-5245-5c50-89da583d22cb@metafoo.de>
In-Reply-To: <63bf4b2f-b56f-5245-5c50-89da583d22cb@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpXTXlNRGN4TURndFl6a3lPUzB4TVdWaUxUaGlOV0l0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHVmpNakEzTVRCaExXTTVNamt0TVRGbFlpMDRZ?=
 =?utf-8?B?alZpTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpT0RBd0lp?=
 =?utf-8?B?QjBQU0l4TXpJMk56Y3lNRE0wTmpjMU1qTTBNRE1pSUdnOUlrVkNSMmhoV1Zj?=
 =?utf-8?B?NFNHRjFhbm8zVlhkRlZtVlNWRWR5TW5JeGJ6MGlJR2xrUFNJaUlHSnNQU0l3?=
 =?utf-8?B?SWlCaWJ6MGlNU0lnWTJrOUltTkJRVUZCUlZKSVZURlNVMUpWUms1RFoxVkJR?=
 =?utf-8?B?VWxaUkVGQlFreFdXRzExVG13eldFRmhkbTl6UjAxU1pubFZTM0VyYVhkWmVF?=
 =?utf-8?B?WXZTbEZ2UmtGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZJUVVG?=
 =?utf-8?B?QlFVRlhRWGRCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZS?=
 =?utf-8?B?UVVKQlFVRkJRazlaUjJOblFVRkJRVUZCUVVGQlFVRkJRVUZCU2pSQlFVRkNh?=
 =?utf-8?B?RUZIVVVGaFVVSm1RVWhOUVZwUlFtcEJTRlZCWTJkQ2JFRkdPRUZqUVVKNVFV?=
 =?utf-8?B?YzRRV0ZuUW14QlIwMUJaRUZDZWtGR09FRmFaMEpvUVVkM1FXTjNRbXhCUmpo?=
 =?utf-8?B?QldtZENka0ZJVFVGaFVVSXdRVWRyUVdSblFteEJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVVkJRVUZCUVVGQlFVRkJaMEZCUVVG?=
 =?utf-8?B?QlFXNW5RVUZCUjBWQldrRkNjRUZHT0VGamQwSnNRVWROUVdSUlFubEJSMVZC?=
 =?utf-8?B?V0hkQ2QwRklTVUZpZDBKeFFVZFZRVmwzUWpCQlNFMUJXSGRDTUVGSGEwRmFV?=
 =?utf-8?B?VUo1UVVSRlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZSUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUTBGQlFVRkJRVU5sUVVGQlFWbFJRbXRCUjJ0QldIZENla0ZIVlVGWmQw?=
 =?utf-8?B?SXhRVWhKUVZwUlFtWkJTRUZCWTJkQ2RrRkhiMEZhVVVKcVFVaFJRV04zUW1a?=
 =?utf-8?B?QlNGRkJZVkZDYkVGSVNVRk5aMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?Q1FVRkJRVUZCUVVGQlFVbEJRVUZCUVVGS05FRkJRVUpvUVVoSlFXRlJRbWhC?=
 =?utf-8?B?UmpoQldrRkNjRUZIVFVGa1FVSndRVWM0UVdKblFtaEJTRWxCWlZGQ1prRklV?=
 =?utf-8?B?VUZoVVVKc1FVaEpRVTFSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJSVUZCUVVGQlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSFJV?=
 =?utf-8?B?RmpaMEp3UVVkRlFWaDNRbXRCUjJ0QldYZENNRUZIYTBGaWQwSjFRVWRGUVdO?=
 =?utf-8?B?blFqVkJSamhCWkVGQ2NFRkhWVUZqWjBGNVFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZC?=
 =?utf-8?Q?QT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:2444:9f01:25b2:379:392:475c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09b2b317-31c1-494f-aa69-08d92b4dd229
x-ms-traffictypediagnostic: PH0PR03MB6366:
x-microsoft-antispam-prvs: <PH0PR03MB6366C742ADE643F2A97EFA2399369@PH0PR03MB6366.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yAlR7uB5wLum7xS3yjLXxwjXzsZWqKs3p62mNxJeLAxOSLV86kAWNKkpRYnTaf9Rtk12VNQwmcanL6rbTmA+oWF2KZsOxDYTuHyVOj9vdnf+fPeK3xogKs2LshYjRw98/cNzi8IvcAkYFyF3h7OM40XWwkfWjjWpFnIgMGRimYTpnbH6usZUjNj5EzhX3t4pCH5uyMh8yzwVZKJ1I36Pz0ZPFntewhRdQ9jJ2TjXArm3FpZ543hslPqNJRYnIVBJCKZXa1uNrRDbv2WuYHvoYi8dioV9jm1J6QHkG2VoVOwYTSxVYeXfRgjESEWjHOwS+JHKRr4cHPQBo6BUvz2XNCwTqfXieGjOvkKuVzNKDGz/vMfqVz/AqyfXJDfBzjA7yOQz3pEW7fiSCb/12QSWILxuIjDB0vjdhDkT5S5ds61wgON+FpgBFfnC3P8GVBlkGL/X9ucWrH/FhlxAA8siNjjN9pLM7Vs3+54LkJRWAZP63M1LkQ65k7QYM66N9gggp2xP1K8iMGOMKHVZc93F6Klsv+emoTEZHgPpvKsDrLRksdpMgzZeyAollZT3PNw1UWqXNwKRVNL2JKX91JE7B3awlbyjOogJV2MX6GdxWO4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(8676002)(316002)(5660300002)(66556008)(186003)(53546011)(52536014)(83380400001)(7116003)(6506007)(7696005)(55016002)(122000001)(4326008)(9686003)(38100700002)(8936002)(2906002)(66446008)(64756008)(86362001)(33656002)(110136005)(478600001)(4744005)(66476007)(66946007)(71200400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L25UYU5Qc0VWWFEwY2NRL2hrbWdZTlVUSDZwUG5ZU2M4dzYrOFpQRVh6am9D?=
 =?utf-8?B?Ky9UOVNPcWwvNjQzL29ydElsREpqNy9WN1VRV2szanRBdzRYS1ZLdUJyMnE2?=
 =?utf-8?B?UUpyN0h4Z3FmdU1MdkQyakNoZ0k1cExPMEIzZnZkKzFhYWhUenZrUnJySkhJ?=
 =?utf-8?B?aW04NHNQNEEzSkxiV1JRQXV4SisxcGF3d1NYUk1oK1NBZHJmU3JmNW05OFpT?=
 =?utf-8?B?elV1cStmZm5taUNWVFgzV2JLcnFSR09SK2s1VjZBWEU4Sk12R2laVFVVUDQ1?=
 =?utf-8?B?WUdQeVd3TnFhQThaSEM5YlQvTXdaSVV6S09JWW5ja0E1bDBZa3ZERVhBUkhD?=
 =?utf-8?B?bWpHMnlPZlJpd2N3elgzdWhTT0FnRzlkOVl5TUt5clROK290ck9rcWFyc3g4?=
 =?utf-8?B?N08ycEtuY2FsczFFTDZCcTdERG5FQ0xIcHlDZ1g4TTh1RFY5TWN3WVV6em0w?=
 =?utf-8?B?d2QrUW4rdkRBTEowdm0vVFVZblFkekxLYW1MdCtDbDBIaHVUZEcrL3RTZmNa?=
 =?utf-8?B?dFo5cE1ZQllXMGZtUnZ0SlhpZndMWjUvcVp0THdRWmE3bWJoRllIZW5xVTJL?=
 =?utf-8?B?ZEJLNFdtMkhtQ0RkbW1MelRPNXJXZFFYSFNNMjltWDNHREpiV2FVZXJoSkdw?=
 =?utf-8?B?RjUrZUwvU1g1VFpPSC9ITUhtdVFKOW5ZNGx6NWV2cytmc3Jrek5udEpCeE1h?=
 =?utf-8?B?a3czZVFCQmxLTkhjaUJ3c2tOd2szSlZxbEZtamdDM0dBNW9EeEJReWRvUGdm?=
 =?utf-8?B?ZkRLNnJraFUzUUxFZmZock9iYlBGWGZNTk1jTnlzTkQzZDFXNTZ3MHBjK0Vr?=
 =?utf-8?B?VVpxRWRBL052ZnZ4c2ZLcWk1K0tVbXkwaHVNalZoT3BjcGg1K3pDTkhVTWoy?=
 =?utf-8?B?OUhGRUhuTTU0LzcyNzZHd1lwRnpyV042ekVLcXNxK3V2Q2NZODV2c2d0OE8v?=
 =?utf-8?B?T2dZbGg3U2ZJRGhkVVdHMllFKzNwRFhqNFdXZFVBS2tNdTdvWTQ5ZGs1cllt?=
 =?utf-8?B?Vk01N3lzMDExWFJ5U3ROam4rSVV4QysyekpNSTNET0xqKzVxRUliWEtST3dS?=
 =?utf-8?B?eWVuWW1CbGJOeXNZWkNzUFBsRzhuT01rdm10aGpEMDNUbVJPN0ZTUTdHZG0v?=
 =?utf-8?B?NHRVaUJGSEVkbzFqc3g0OXJ0REUzb0xyVWt2bzc4SGxOK3dGVFowVm1NdjdL?=
 =?utf-8?B?NXkvWGxKQkxiY1RvdFpPL09wZ2lZN21uc3VHeExaMGhIN3lRejU4N3RCdUhH?=
 =?utf-8?B?OWcwd0pKVnY4Mm9wZmZqaWtLSzI4NENNMVFtclFsdVh6OVFhM1ZFWnV1K0pI?=
 =?utf-8?B?ZmlVU1l4WUMwMHFGWTZiNitPS29ScERpN1E2c1lZWVhKV3dnNkRlaE9idUhJ?=
 =?utf-8?B?OUlHak5mQ0t5Q09ubjlQQXRCcDlPSnFRVzI1NTJxOUlkUXR1VGJleDU5eE5q?=
 =?utf-8?B?dnZFRDBzRUloR25kUTJUMFJwbzNyREtjY3lHMy9QbmpqeHdSc1o3TnVJcGcv?=
 =?utf-8?B?SGZuVzlMekcwWUhLSzlvUFVUc2NlNFV1cWFhYXBDMDRPOXlsNGJkVU5kbjVj?=
 =?utf-8?B?WDRlbExVMWdpREtuUmRUTGl5QkJLTll6Y3BTYjFieFJ2ekZVSFQreEc5ZXBv?=
 =?utf-8?B?V3dLMDZPRHA2RXpBMklNTzFmWlVYWmc2a1puNTZSdlpObi9WZDBYM1ZWWmdW?=
 =?utf-8?B?MEhPTjA4a2VMa3Y3N2FnMGRwa1U5Y0RhMmZZTG1pcnVMK1lvMnV3MmtlUEFy?=
 =?utf-8?B?ZGUvWlBjUlBISkw4UXlLQWlpbUo0VzBxdXpmS3BUM2lDemxoY0RuaFlYenBC?=
 =?utf-8?Q?h1hxwuLXGUdgkLF1cXTXGy7Y9UBNI2DW79UtQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b2b317-31c1-494f-aa69-08d92b4dd229
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 13:52:28.6932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2APazscN9nOLf90VU+G4oGVDBiqC8L+myjHi/kNlUmRWi0QoRAVjt++VIa8E3tDgZ7MqZQd7e24zZCXV1+4FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6366
X-Proofpoint-ORIG-GUID: ymxybYoeU7FszehMjZOuPzno3mlZPW3S
X-Proofpoint-GUID: ymxybYoeU7FszehMjZOuPzno3mlZPW3S
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_04:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090069
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBKdW5lIDksIDIwMjEgMzo0MyBQTQ0KPiBUbzogSGVuayBNZWRlbmJsaWsgPGlpby1k
ZXZlbG9wZXJAZnJlZWRvbS5ubD47IFNhLCBOdW5vDQo+IDxOdW5vLlNhQGFuYWxvZy5jb20+OyBB
bGV4YW5kcnUgQXJkZWxlYW4NCj4gPGFyZGVsZWFuYWxleEBnbWFpbC5jb20+DQo+IENjOiBsaW51
eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBhY3RpdmVf
c2Nhbl9tYXNrDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiA2LzkvMjEgMTE6MzcgQU0sIEhl
bmsgTWVkZW5ibGlrIHdyb3RlOg0KPiA+IEkgYWdyZWUsDQo+ID4NCj4gPiBUaGUgcGF0Y2ggd29y
a3MuDQo+ID4gQExhcnMsIGNhbiB5b3UgY3JlYXRlIHRoZSBwYXRjaCBhbmQgcHVzaCBpdCBpbiB5
b3VyIGFuYWxvZyBkZXZpY2VzDQo+ID4ga2VybmVsIHRyZWUgc291cmNlcyA/DQo+IA0KPiBIaSwN
Cj4gDQo+IEkgY2FuJ3QgOikgQnV0IEknbSBzdXJlIE51bm8gd2lsbCBiZSBhYmxlIHRvIGRvIGl0
Lg0KPiANCg0KSSBjYW4sIEkgY2FuJ3QganVzdCBwcm9taXNlIHdoZW4gOikuIFdpbGwgdHJ5IHRv
IGRvIGl0IHNvb24gZW5vdWdoLi4uDQpIZW5rLCBJZiB5b3UgYXJlIGluIGEgaHVycnkgZm9yIGl0
LCB5b3UgYXJlIG1vcmUgdGhhbiB3ZWxjb21lIHRvIHNlbmQgYSBwdWxsIHJlcXVlc3QuDQoNCi0g
TnVubyBTw6ENCg==
