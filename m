Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D563E9EFC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 08:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhHLGyx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Aug 2021 02:54:53 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:65304 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234268AbhHLGyx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Aug 2021 02:54:53 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C6jUL1002626;
        Thu, 12 Aug 2021 02:54:14 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ac8k03sgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 02:54:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1pZ455kdUM89FCtcP6Fzr3IyH7PiNClGwFbr/S0k6CnB5i3tmG3Fa075XNe4/r1AMWx7qgwImKur0a+vq1Y94b0b46l5yRQV85hPev88no1dpaomtUzvDgk9I01PxQANofVel76wCBvxE7MGdl1BrN/t3xluwPAXHCAW+W1TkV8OginLSEqaM/1HlAOpAtUoMbDhlDCHzsC09LrukFOVx/ZoPZesCtXOACMJHPfNeBvKKL9maGF1SFOB5B66WzvHSb/7XzMw9bRtSwJcBXjCpnOtROW3VS7yM0a4WxkEQ7C/fKJT8xURi3dcNP95u7f+hvFPmL7NqBXFW2ndHjqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=487ZZIbzUQ/syXiQ7VeSuVzXTPqUG1QXXTfHOVOH75Y=;
 b=VUZzRMPaQnBAQkZm2Lm53wE1OYnP88PzhT3e6K/OVjETjyTQZSGmKfNeje6sCRaCHNkCfH1KVoqYKzPIcnrv78WNlfUx4Q424PhuxehizyBdE70JsPIP30KWMBLc+yfggoiqph73Dy7Ef3JcqTF7utm7uMFcw9cH98h3CBM3KOa7QsOmcprbdSypSKFQ16eQbrWTJlIotVVl1RDk87Mmj2pEdfiP0MaxutDryQrTguDFJgH2vHQxMKhe8BxPvW1C+gmkIrT3qtrv1XdFS0otP9QcAPJkCh6mohy7ebECEUFs0Az38bx5P3LDavK/3Ngh4XVhn4NCzSphOgtC2T6Yrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=487ZZIbzUQ/syXiQ7VeSuVzXTPqUG1QXXTfHOVOH75Y=;
 b=6IPX3YQxtLk/zZb4JrLQLcgHdFWpj6udY8UQe8/87BS1Q8Uaar0+lYfhdhbFR8Oun6NewAWvNpRqbxScidPU6Re0qHTEMHUWHUdr+dr4P+BgFTFp46LwdA6Huy0oDErxhGYhOdsmS+sd2XBLFxKXClXlcl8Gk1gLKxnH9Ywoqc0=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5685.namprd03.prod.outlook.com (2603:10b6:510:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 06:54:13 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 06:54:13 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Drew Fustini <drew@pdp7.com>
Subject: RE: [PATCH v2 1/1] iio: ltc2983: fix device probe
Thread-Topic: [PATCH v2 1/1] iio: ltc2983: fix device probe
Thread-Index: AQHXjrT06XBzL4FKU0yXzNS476nY1qtuesgAgAD02HA=
Date:   Thu, 12 Aug 2021 06:54:13 +0000
Message-ID: <PH0PR03MB6366AC51BA01533E28001A3F99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210811133220.190264-1-nuno.sa@analog.com>
 <20210811133220.190264-2-nuno.sa@analog.com>
 <CAHp75Vfp_u9mbnUzcBXdv_RmFu9m4JK0=R5us6j3bquG4HzRvQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfp_u9mbnUzcBXdv_RmFu9m4JK0=R5us6j3bquG4HzRvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1UZzJOMkpoTVdNdFptSXpZUzB4TVdWaUxUaGlPRFV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhERTROamRpWVRGbExXWmlNMkV0TVRGbFlpMDRZ?=
 =?utf-8?B?amcxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpT1RneElp?=
 =?utf-8?B?QjBQU0l4TXpJM016SXlORGcxTVRFek56QXdOVElpSUdnOUlqTnJWMmhvYjB4?=
 =?utf-8?B?TGFVb3ZjekJSYUdKRlJqSjJWVEJJVjFwelVUMGlJR2xrUFNJaUlHSnNQU0l3?=
 =?utf-8?B?SWlCaWJ6MGlNU0lnWTJrOUltTkJRVUZCUlZKSVZURlNVMUpWUms1RFoxVkJR?=
 =?utf-8?B?VWxaUkVGQlFrVlZPRXhoVW04dldFRlVVbEpTTVVOSlVsQmhWVTVHUmtoVlNX?=
 =?utf-8?B?aEZPWEJSUmtGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZJUVVG?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6491f776-05e2-4f63-c352-08d95d5dfea5
x-ms-traffictypediagnostic: PH0PR03MB5685:
x-microsoft-antispam-prvs: <PH0PR03MB5685E1824A1E67CD17AEB93599F99@PH0PR03MB5685.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T8aULIYc1EtxIHjoQBI5LBhsBEBu7+g8OVKWLOD8AzvpgrM2xd6MP3qeYE2NbbtkoKgI8OiuQKKk1BnooJu9wzD8wXfcGvfbU4OldQDEGwLfhqQjMRjamgrI1N/UZrGHVxlJeSmcWDSsHM3C/TX7IGhsayMeh0rSFsv8MMh8sic6GlEyAYxL3XZdRPGXme4xzQQHgMoWAuHd1p8MYqBirIj+1LmdTJU0Q+nukP80s4RmfGb+PvRzZAgAZgZd3E1nFYoOm/sV8dVsHJoDkHDjJldZgRvGDEAxYfUZRt0WyEG1ejvVANO8Vrg9CdCBEcbbd1+ls1F+OTlFGtxyL+1UApS+Xu5Epqt2E4Id6WGw6o7BKlPEIsgCJCibzKJt8OULmlyP9UXC7oGD4KW8MMkJQ5opQ9kzF+JhboLUQczEPGZJmzJzr6hwsslFYGUYshYElzcr6roL4/N7mT6z/vKNkStoUKXcBTbzIQc2OzeNN9uK+LsJeDv7sXnik/vtSdsXPvmHcpenCeXHm7FZLg27Uho3QhyPAF8N/TYY+a2nmRH/NnHwSyogDaES/USadXyrAbap4j4oyXvmNa0lOZTMhS6Ht9Ddj+VoPnM21kNAzTUyetQQw+K8E7WeIPmr/zTdp3a7lkuPYuXDmBIapq8th5212IMYh9u1OLbhaFyaMyKHresxDiyxRBgXWFUgRUuh/GsKYw9yBQL+JyUXC4LWfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(122000001)(53546011)(71200400001)(6506007)(86362001)(83380400001)(76116006)(38100700002)(38070700005)(26005)(186003)(66946007)(9686003)(64756008)(66446008)(7696005)(8936002)(66476007)(66556008)(8676002)(33656002)(55016002)(6916009)(4744005)(52536014)(5660300002)(2906002)(4326008)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1k3ZnowUXYxOE83ZmJTMmVkSTVoZko4VnFNd0dWL1FtZzhkWHNrTzF6Y2ty?=
 =?utf-8?B?UGtNRHZWS3pLUU5pK0hhL0hSaEpOMjd6enhJQmdZck5USGRncm5FSmduaURG?=
 =?utf-8?B?L1NzTXFvNnBoMDFMTmR2TVZhdE05dnZ0QTVTUWlCL3I3RGhERTRRQUNRSFdD?=
 =?utf-8?B?VzNKZEszSWczQ1FzZk0wdmRNRjdHRzhjTTdwZjVNSFNXZ0VqM2ZLdmJNY1dS?=
 =?utf-8?B?Z1VZaGFsdVVRK05kLzIyWk1xWFhWcWlMTHdLRTZMcjduNDc5ZkhubGp6Zk9O?=
 =?utf-8?B?RXZmUWJ6clZHL3ZrUkFmWkR4Q001WUMxWnc5QTc0UHNicFdJdFNNUlFWRlp1?=
 =?utf-8?B?WFZjT0pYaHM5OVZDQUFqbDM3eXlPRDNJQ2JjRVVFSjc1QkVLZWkrMUpnMFNm?=
 =?utf-8?B?ZDh5bnJhQjBLT1pxbEgyUm9xMzNTYk5QOUFNTFc3NGxOYll0S1p5WDVVcDUr?=
 =?utf-8?B?NHRBMnpoN2ZLR3g3UTNSNEh2ZjM4N1lmaXp1VVZMQTJ2cU1OaC9EVzQ5QWhN?=
 =?utf-8?B?d0U2Y203SXJDVEZya0JPTTlpU2hkTWxWRFpQZGpSZmFBazRpOTBWeG1ETndP?=
 =?utf-8?B?TW4zVXV1OFZQbVpnZ2VQMzZHQlh0em4wbk1iQTdaeXdpR3dremFiL1o5SE1Y?=
 =?utf-8?B?MHRacEdySkZ0V244S2dtRTRJQXhRK2ZPZEZOam4xdnNWeWFwRnd3dTJZZ05n?=
 =?utf-8?B?QmcxUitrbjVxcEFod2RuZTk1SHVNcUtndXlDUUQ4bTQ1dnNvN1diY3BYNU5j?=
 =?utf-8?B?ZUNteEtJREoza0tZYWdZTnRiRXNtd0tCUEQyL1REZWpUR1gxUEtMQUdSUk45?=
 =?utf-8?B?RGo5b2txenlCeDNoWDlSUjFpdndXSWVRVnVUaDZ0UnB6MGxSYlFQWVo5VWdT?=
 =?utf-8?B?K3YrR25aZnhsUDJnbzhDZ294SzhTdytlZTVwRWhFZDNFUFgyOGYvb2ZTNk14?=
 =?utf-8?B?UVdDQTU0Vzl4TDJWNWpiZnlQajc3WWVlYUJKVHFBdmRCWUZ6SXUzdmFPMTZF?=
 =?utf-8?B?YXE2SklDNThBVkNaekFTbG40ZXlreDFCbjlFZXpPa0dqODRGMFhONCsxODZr?=
 =?utf-8?B?UUJzcXU2RFllcllMaXF1b3l5SFFoUTdrNHRFZldzdFFYYWg0OXl0Vk0rdkpq?=
 =?utf-8?B?akY4bW5SNjlqWDVtUmVrcHRXY2l2SnF5aEhSdEJrMzNDL2NxM2dJTXBkN0hk?=
 =?utf-8?B?eVkwMFVXSmhaY2daeVoxUU1EeFhJZElsVXBFQjlCQk9HM3MrckQ2NEhJUVc4?=
 =?utf-8?B?ZXIzTEViOThwUjZZaDZCYUJEOHdRV3pZSFQwOVVUZGFkM2FLeUw4UXhYVzdD?=
 =?utf-8?B?TktiRjNoVkErQlNxWVY0SHQxbnNza0ZVQ3dYNEJGUUtWRURGQmVnZWJxSHg4?=
 =?utf-8?B?MUh0NlN6RE9YZUhpTFdaSnBFN3puMC8wN3o2cjZIWCtMdTlKaTZYT0Vpd1I4?=
 =?utf-8?B?LzlEUDROS1FsTnYxT2pCRnRNWGt6Nk9xMDl1NlhlV1FiQ3hGSnR2TTU2ZTlp?=
 =?utf-8?B?Q3E3UDVXbnVzL1JEQ1BWRVBhQ3BPdmFwTS9VVjJxTE50WXZpMC9vMVJOdDVW?=
 =?utf-8?B?YjJZN2Jkc1VmS2t3bVMrSTNIeFZBQUJyY2Yrb2lhdHcwejZ3MEFPNXM5M3pv?=
 =?utf-8?B?cUQwNWVhU1ZQSEhBOWlFd25UWmVGZy9QVUJZVjlaVzBqMnQyblNOOXM1Q0tn?=
 =?utf-8?B?elR3UXRPODNxNUpmU3c2clFUaGQ5VnJNSFdvWld0QTJjWW9MdW05QnRNNGsx?=
 =?utf-8?Q?lkcOKb0jq4muCnfpOIYNshVcF5kdYdohQabnpd8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6491f776-05e2-4f63-c352-08d95d5dfea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 06:54:13.3521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWcJWmY0Vhg7qbmstXlOMndHHuSJwy5fwsXLPS7tj7dGs0+OdRPbPoJuIoHPQaAo8Ew3/YuCRYjPDvjeN1mD3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5685
X-Proofpoint-GUID: eRp9JYrS_xG75_Y1InYqGZL1O5vRiwUY
X-Proofpoint-ORIG-GUID: eRp9JYrS_xG75_Y1InYqGZL1O5vRiwUY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_02:2021-08-11,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAx
MSwgMjAyMSA2OjE1IFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBD
YzogbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPjsgSm9uYXRoYW4gQ2FtZXJv
bg0KPiA8amljMjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9v
LmRlPjsgRHJldw0KPiBGdXN0aW5pIDxkcmV3QHBkcDcuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDEvMV0gaWlvOiBsdGMyOTgzOiBmaXggZGV2aWNlIHByb2JlDQo+IA0KPiBbRXh0ZXJu
YWxdDQo+IA0KPiBPbiBXZWQsIEF1ZyAxMSwgMjAyMSBhdCA0OjMyIFBNIE51bm8gU8OhIDxudW5v
LnNhQGFuYWxvZy5jb20+DQo+IHdyb3RlOg0KPiANCj4gVGhhbmtzIGZvciBhbiB1cGRhdGUsIG15
IGNvbW1lbnRzIGJlbG93Lg0KPiBEZXBlbmRpbmcgb24gSm9uYXRoYW4ncyB3aXNoZXMgaXQgbWF5
IG9yIG1heSBub3QgcmVxdWlyZSBhIHYzLg0KPiBJZiB5b3UgYWRkcmVzcyB0aGUgbWlub3IgaXNz
dWVzIEkgY29tbWVudGVkIG9uLCB0YWtlIG1pbmUNCj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNo
ZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gDQoNClRoYW5rcyBmb3IgcmV2aWV3
aW5nLi4uIFllYWgsIEkgd2lsbCB3YWl0IGZvciBKb25hdGhhbidzIGZlZWRiYWNrIGJlZm9yZQ0K
c2VuZGluZyBhIHYzLiBJdCBtaWdodCBiZSB0aGF0IGhlIGNhbiBhcHBseSB5b3VyIGlucHV0cyB3
aGVuIGFwcGx5aW5nDQp0aGUgcGF0Y2guDQoNClRoYW5rcyENCi0gTnVubyBTw6ENCg==
