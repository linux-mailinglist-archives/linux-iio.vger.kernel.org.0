Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621F36B244D
	for <lists+linux-iio@lfdr.de>; Thu,  9 Mar 2023 13:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCIMib (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Mar 2023 07:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCIMia (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Mar 2023 07:38:30 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938BE6132F
        for <linux-iio@vger.kernel.org>; Thu,  9 Mar 2023 04:38:28 -0800 (PST)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329B1kIr025612;
        Thu, 9 Mar 2023 07:38:09 -0500
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3p6xfde8h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 07:38:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOTDChBJ0DFrB24Yu7jpRjiLX7CUNZxB821Zy66Zm0eifQIhrxIHVF0k8X6tA5WGx0O754jmVa9Tl5YfLFnWdseImWmCI4uwAbWND+Tmq2oq0+nyb3Pwtqd295x3LDGlaMKa11KaRsJwhUBrM3qiUVkLG1WMU/Ueo6us7auhV8Dz87ZOJkwCM6Sow8xT36Ppky9INgZo5KoKuDWqv+283MQFbfqCAch1r3EyA/G9PdG7wYv5Az8sKSRovM7OlNu+kYvXYVqSysObjTpzD/mJDn+0e82Wi9of+lAZgvdlIsC7BUyYJJG2RlguXbXqP7GZ0bP/a+HO+x3/dHoQLJyAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leTO+QRCDu8N1N4ZkHe1HMz16D2d0Xjv32rIfkAlYPg=;
 b=Lzy4kqeyR+09SkHa7gixL9FGQBDrTpPi0AWvJFfJiKLMHTCtgbAACm8/OEUETQW3VI3VKpfCZT0dQRBScFuS++CBmW8aYAHNxVRBXLzCFZrjoqSHqP24Wqv1Hs+H3liYNhU1EfoBJT1w1mVwe0i/wcd/xppbpKSkwa8JoF3HpDWD5X3lCKDBV5vb2rfkdJCY2NycqeoIYXOHOyzYw76z/57MCdFczxtfh/KLirv6uPH2gN1NYsh+GaUgSboncHkdVWGg9b+VM+skHU1dVXU6R1spI39ajFfAhYx3erw3pOfDn6tZUljKWQFY31J9sMRh2NECv+leI0WGW6el/neocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leTO+QRCDu8N1N4ZkHe1HMz16D2d0Xjv32rIfkAlYPg=;
 b=FflWSQdQ18WQaRlMzbEvMR6JaYFWt6uQSb8imoKgW0CADSxzb1j/4AjZExYpRYL/SGtk/NvFFkAFjzdfiUVAB+VYX+S/r1f6bQZ0Xz2pMkHKPFe0e+xDGImfw4/IfzNgq1z1jFIn0fxj5gPVtjdXw2m4a6tt7WLyot8iCqhQaf4=
Received: from CY4PR03MB2488.namprd03.prod.outlook.com (2603:10b6:903:39::12)
 by SJ0PR03MB6614.namprd03.prod.outlook.com (2603:10b6:a03:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 9 Mar
 2023 12:37:54 +0000
Received: from CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::b89b:3127:323d:3bbe]) by CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::b89b:3127:323d:3bbe%5]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 12:37:54 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: adc: max11410: fix read_poll_timeout() usage
Thread-Topic: [PATCH] iio: adc: max11410: fix read_poll_timeout() usage
Thread-Index: AQHZUNpdsqUOPaeVjUWWzMEGkdttR67yZJmA
Date:   Thu, 9 Mar 2023 12:37:54 +0000
Message-ID: <CY4PR03MB24888E9F4583FA53C7D8076596B59@CY4PR03MB2488.namprd03.prod.outlook.com>
References: <20230307095303.713251-1-nuno.sa@analog.com>
In-Reply-To: <20230307095303.713251-1-nuno.sa@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYVdKeVlXaHBiUzUwYVd4cmFWeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxUTTBNMkk1TmpBd0xXSmxOemN0TVRGbFpDMDRaVGRo?=
 =?utf-8?B?TFRkallqSTNaRGN5TXpGaFlseGhiV1V0ZEdWemRGd3pORE5pT1RZd01TMWla?=
 =?utf-8?B?VGMzTFRFeFpXUXRPR1UzWVMwM1kySXlOMlEzTWpNeFlXSmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpJM016WWlJSFE5SWpFek16SXlPRE01TURjeE5qazFOVFkxTXlJ?=
 =?utf-8?B?Z2FEMGlUSEF3YjFSSVMybERkekJaZUcxbkt5OUZXREprT0RsVVUzb3dQU0ln?=
 =?utf-8?B?YVdROUlpSWdZbXc5SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZN?=
 =?utf-8?B?VkpUVWxWR1RrTm5WVUZCUlc5RFFVRkJSbGhMTnpKbk1VeGFRV1pLUVdGSVdr?=
 =?utf-8?B?c3ZXRGhFT0d0Q2IyUnJjamxtZDAxRVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVoQlFVRkJSR0ZCVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVVZCUVZGQlFrRkJRVUZSWkdsck5WRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUpvUVVkUlFXRlJRbVpCU0UxQldsRkNha0ZJVlVGalow?=
 =?utf-8?B?SnNRVVk0UVdOQlFubEJSemhCWVdkQ2JFRkhUVUZrUVVKNlFVWTRRVnBuUW1o?=
 =?utf-8?B?QlIzZEJZM2RDYkVGR09FRmFaMEoyUVVoTlFXRlJRakJCUjJ0QlpHZENiRUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSFJVRmFRVUp3UVVZNFFXTjNRbXhC?=
 =?utf-8?B?UjAxQlpGRkNlVUZIVlVGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hkQ01FRklU?=
 =?utf-8?B?VUZZZDBJd1FVZHJRVnBSUW5sQlJFVkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJXVkZDYTBGSGEw?=
 =?utf-8?B?RllkMEo2UVVkVlFWbDNRakZCU0VsQldsRkNaa0ZJUVVGalowSjJRVWR2UVZw?=
 =?utf-8?B?UlFtcEJTRkZCWTNkQ1prRklVVUZoVVVKc1FVaEpRVTFuUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVRTlQU0l2?=
 =?utf-8?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB2488:EE_|SJ0PR03MB6614:EE_
x-ms-office365-filtering-correlation-id: 24646363-d8b4-467c-5753-08db209b1a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gK2sibk5ANSeG4bPMDIW8HMNz2wZ0iLul9HsIesUthWuUFjKT5cytAR3xt3jN9pc9AHI0cWZx9O1FRiusObm4kwCwsH0f9ltevVA7U943Z4sCeUDC9+N0ss+0BxPHdcfk8I7nUiXSRWMfz26Md2wPiVx6VIwlk4ryvO6KxKtHkKz89r8NgZd6lENaFVHqPkm8XpQDHtJk5K75RxxNzU0oPsulTWUg3uyVt0z4w9KK3GiY0QI2202/7M5WFfd/XW7CLwI2BsEFETRM67Eig/MpVDmLbs5pkIyZSBj+Kn/7a+LB4VBcBRdJnMcML429bx2mEm3T6/J4L+NQ2NjPFPHujEUpZdCYP1jWYroNqAGk16iQD1G0tUoHS5N3Pwq0jFibYDYGPq/HIajOXiqcTdXZC8RhJostHfVcAvscGPY5U3rSnDJmHf9t0mXnpi47+FnDT6m2ejBiGQrvWJaDAKh08aSsrbCPwJ71NPXTYAUskrm766D3jVaAGaJqjMZ5OaDwHs/9M+DHozUZ98fJz62P/uWcjPvL98szq4jNMvhdlEztLZ9Oc43WrsZxI64d7pHQ6/PhlfX3ANDFlEtugFQakZiF3vW3GL4pqlH8127a5ar0+2X01XMQZ7vdq0nkHwoB6rDMlV7L6dIyoszeZfrp5j5J6QvkjGyHdrE+5X6DYFo5xsltx8jrSE/lGUyHiS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2488.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199018)(38100700002)(71200400001)(9686003)(186003)(38070700005)(26005)(6506007)(122000001)(83380400001)(86362001)(33656002)(55016003)(2906002)(8936002)(8676002)(316002)(66446008)(5660300002)(64756008)(76116006)(66946007)(66556008)(66476007)(110136005)(52536014)(4326008)(7696005)(41300700001)(54906003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1NJNEJHWGI3UE4xbmdwRGtSY2hBcVY0OUNIUVZpVzFHOXU5UW93V21kT1dt?=
 =?utf-8?B?NGZDdTNoUVorYi8zUk1Tc1NrMDNVenN6OUJseDlBVXJuUkEvWFZNYkliM00y?=
 =?utf-8?B?MzBMRFlPbk82STJTUDdqZGd3cnVaKzNuM2tiL005M2FyWGh3UDFmUHRtUmh1?=
 =?utf-8?B?VHg2N1Q5a0swOTJlZWp3MDdGRE9Fd2wvNnE0YVIvS3U1Vk5RR2QyVHV3MWx6?=
 =?utf-8?B?R0luWmhBT1Fjb09NS3IwYzJqa3l2NkJqMHh2OHFvYUpaUnBFbHpvcUUyTGZB?=
 =?utf-8?B?UHF6NEg2UndnS2w0R3BQQTl3OGo1L25uUExqbkZIcFlaZldYd0tGekRnMVVJ?=
 =?utf-8?B?cUNrUHN2dlBxR0JqVjR5UjZhdGJ1S1VOanNkYzBiME9MMVQzWU9nQ2ZoR08r?=
 =?utf-8?B?SzBQZFQ0bTB6TGdlcFp1bUVQcG0yRStUOVFmam9VcTBkcjJQMnFRcG94a1Rp?=
 =?utf-8?B?TGcySjA1T2pla1VFR0c4RFhmNG8wMm5FNjNPODVKUDlXdnA1dUxCcEZrTTY0?=
 =?utf-8?B?eXU3SlgxV3hxNUxWamlGSlBhWElzSFVDWWZ1bGtlZEhodDhhRDNJQWF0STQ0?=
 =?utf-8?B?RSt2WjZaT3JMUzRRWEJDT1AvZVFLT2o0Vmd1RzcySkp4OHNSQncydVl3Qnpi?=
 =?utf-8?B?dnFSN2lkQkhpdm04eTExVmphMlJWMWxYbW5BbHI5RGpRemMxMVFqeGdLZ0w0?=
 =?utf-8?B?QUNWWjdRK2pRVndENWxIUktVWWRZUnhKSkNmdVpmMWhHaGEwS3BaSFBYMElk?=
 =?utf-8?B?N2dqZjBhMFVVaUNKYTNDR2d1elJ2S0RxellycTkzdDNJd0dLeG5maXJzSVRB?=
 =?utf-8?B?Y2pjczBIUy92Z3NaS24yR2cvR0lENmdBWTJVRDQ2ZHp6TXVGYkszaURsSmpa?=
 =?utf-8?B?aWpRak9INFArTVNMZThFWHpKTXVCeTJGUjJzZWlISFhnLzM4V0s5TzFaVm4y?=
 =?utf-8?B?RGYrU0VFOCs2dUVJTUZhVlFTTXBTSFp5dlRUc2ZycVBpeUpFdGJJTzc2MVhl?=
 =?utf-8?B?S25iV0xjUC91ZHpGczJoeFo2VG41MHBHeFNkMFhkbHpJZWtDUWRmbzR2bU5r?=
 =?utf-8?B?WnpDU3J3MDFUcWprZWJ5T3p4M1hVQ1U0VlhBYlFNbVNkaUJrQjhQS2NSVGtD?=
 =?utf-8?B?RGZRZGxET0J4ZVVYTUF3YWVQU29ZOWpaT1hoYVdtNXM0ZG5sanlObW13WkpE?=
 =?utf-8?B?a0x6N1FlQWNKcWdxVGYybkVCcnR4SFQ5RUhHWUlWeGEyS2dVN1gzM0VZVXox?=
 =?utf-8?B?ZHVaeFlzd0x5RjRvSXZsejFPa0FGQklCUHViSWR5dEFNa0VCRkc2UFp1WlFW?=
 =?utf-8?B?bEtySk0wWEdhS0JtdDlReFpUalhsRVJSMDdlZlFDV2xnM2krTVRUSE55TDU5?=
 =?utf-8?B?a0dSMm5iMUV4QjcrT3ZFQjRJcWluMGxvb0hoS1FZQUNuZmdxNU1UdlRQYXpU?=
 =?utf-8?B?UWxtSElyZ09xYjAwQUc1QndENWFiZ2VxeUZhcGtSMFhwRDFDVk1ZbFU3UldJ?=
 =?utf-8?B?N2ZRYXV6YXBnUndGRlNwN3oxMlo5U2pST21NVHFpcnBhbytsMkVTZjkzUlNo?=
 =?utf-8?B?empDZ28xN1k4YWxPR2tEeFIrS0t6czEwYm80aVp1a0lpbmx3bDExcWsxRm45?=
 =?utf-8?B?eWo0bFYxVEVjc0RoUDRTZG9nQkh2bUIzOUF3bEZua3Q3VTdvM04yS2RYS1VB?=
 =?utf-8?B?MWhNQi9TSjQra1NxbFRrV1RvQjAxUzdRbnpUQ1VPOHBldzRtZHMyZEt0elhY?=
 =?utf-8?B?S2JWUlJVTTJpbno3K1VseHVpTS9EcWpHdVptdkNTMHZPTnF1cE9TYk5RcjFn?=
 =?utf-8?B?c1d0aDljWUlzUUg3dnNLR0tDWVRFMXFJOWloOFNnc1VPSmF0UlE0Z1NEWjJF?=
 =?utf-8?B?R3pIcERZcm9iVVI2ZC85NTFsZytQbGg1ZlpkelZDdXZaZEh0V09aRXNhaXgv?=
 =?utf-8?B?QUF0bWQ0eE5DL3hSaWwzVXVJQVpEU3dDWSs5d0lDNU9vQ2pmcyt5SHZ3L3pO?=
 =?utf-8?B?bGhhaEI5NjlyVTZuNk9HeWRiSEprQitOL1NvRmJCQXlDT2FKRExzTGdoR052?=
 =?utf-8?B?MHE0K0tXRWd3c3ZXcnNBV1Fqc25oaCtOemFOTDJoL3V6dTFpV3c3TnMvanhM?=
 =?utf-8?Q?VP8Hotoc2XkWXpnD0Ql3H7977?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2488.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24646363-d8b4-467c-5753-08db209b1a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 12:37:54.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET8JqBXlt4Ifhag+k+x3POcLd8XmWYY/S1qAoUf/sUfcqZz6xE23MQ2haI/vuqrax4NDH+TmmzxWWjQOGNU7cpY5uhN7C5+glhpilw6ZqpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6614
X-Proofpoint-ORIG-GUID: LRQr4Rdr1g5ue37MFmAvMoDx3GSlD-Kb
X-Proofpoint-GUID: LRQr4Rdr1g5ue37MFmAvMoDx3GSlD-Kb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_06,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090102
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBFdmVuIHRob3VnaCB3ZSBhcmUgcGFzc2luZyAncmV0JyBhcyBzdG9wIGNvbmRpdGlvbiBmb3IN
Cj4gcmVhZF9wb2xsX3RpbWVvdXQoKSwgdGhhdCByZXR1cm4gY29kZSBpcyBzdGlsbCBiZWluZyBp
Z25vcmVkLiBUaGUgcmVhc29uDQo+IGlzIHRoYXQgdGhlIHBvbGwgd2lsbCBzdG9wIGlmIHRoZSBw
YXNzZWQgY29uZGl0aW9uIGlzIHRydWUgd2hpY2ggd2lsbA0KPiBoYXBwZW4gaWYgdGhlIHBhc3Nl
ZCBvcCgpIHJldHVybnMgZXJyb3IuIEhvd2V2ZXIsIHJlYWRfcG9sbF90aW1lb3V0KCkNCj4gcmV0
dXJucyAwIGlmIHRoZSAqY29tcGxldGUqIGNvbmRpdGlvbiBldmFsdWF0ZXMgdG8gdHJ1ZS4gVGhl
cmVmb3JlLCB0aGUNCj4gZXJyb3IgY29kZSByZXR1cm5lZCBieSBvcCgpIHdpbGwgYmUgaWdub3Jl
ZC4NCj4gDQo+IFRvIGZpeCB0aGlzIHdlIG5lZWQgdG8gY2hlY2sgZm9yIGJvdGggZXJyb3IgY29k
ZXM6DQo+ICAqIFRoZSBvbmUgcmV0dXJuZWQgYnkgcmVhZF9wb2xsX3RpbWVvdXQoKSB3aGljaCBp
cyBlaXRoZXIgMCBvcg0KPiBFVElNRURPVVQuDQo+ICAqIFRoZSBvbmUgcmV0dXJuZWQgYnkgdGhl
IHBhc3NlZCBvcCgpLg0KPiANCj4gRml4ZXM6IGE0NGVmN2M0NjA5NyAoImlpbzogYWRjOiBhZGQg
bWF4MTE0MTAgYWRjIGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IE51bm8gU8ODwqEgPG51bm8u
c2FAYW5hbG9nLmNvbT4NCg0KQWNrZWQtYnk6IElicmFoaW0gVGlsa2kgPElicmFoaW0uVGlsa2lA
YW5hbG9nLmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL21heDExNDEwLmMgfCAy
MiArKysrKysrKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9u
cygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMv
bWF4MTE0MTAuYyBiL2RyaXZlcnMvaWlvL2FkYy9tYXgxMTQxMC5jDQo+IGluZGV4IDIzN2IyY2Uz
ZjI2NC4uNmFmODI5MzQ5YjRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvbWF4MTE0
MTAuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTE0MTAuYw0KPiBAQCAtNDE0LDEzICs0
MTQsMTcgQEAgc3RhdGljIGludCBtYXgxMTQxMF9zYW1wbGUoc3RydWN0IG1heDExNDEwX3N0YXRl
ICpzdCwgaW50ICpzYW1wbGVfcmF3LA0KPiAgCQlpZiAoIXJldCkNCj4gIAkJCXJldHVybiAtRVRJ
TUVET1VUOw0KPiAgCX0gZWxzZSB7DQo+ICsJCWludCByZXQyOw0KPiArDQo+ICAJCS8qIFdhaXQg
Zm9yIHN0YXR1cyByZWdpc3RlciBDb252ZXJzaW9uIFJlYWR5IGZsYWcgKi8NCj4gLQkJcmV0ID0g
cmVhZF9wb2xsX3RpbWVvdXQobWF4MTE0MTBfcmVhZF9yZWcsIHJldCwNCj4gLQkJCQkJcmV0IHx8
ICh2YWwgJiBNQVgxMTQxMF9TVEFUVVNfQ09OVl9SRUFEWV9CSVQpLA0KPiArCQlyZXQgPSByZWFk
X3BvbGxfdGltZW91dChtYXgxMTQxMF9yZWFkX3JlZywgcmV0MiwNCj4gKwkJCQkJcmV0MiB8fCAo
dmFsICYgTUFYMTE0MTBfU1RBVFVTX0NPTlZfUkVBRFlfQklUKSwNCj4gIAkJCQkJNTAwMCwgTUFY
MTE0MTBfQ09OVkVSU0lPTl9USU1FT1VUX01TICogMTAwMCwNCj4gIAkJCQkJdHJ1ZSwgc3QsIE1B
WDExNDEwX1JFR19TVEFUVVMsICZ2YWwpOw0KPiAgCQlpZiAocmV0KQ0KPiAgCQkJcmV0dXJuIHJl
dDsNCj4gKwkJaWYgKHJldDIpDQo+ICsJCQlyZXR1cm4gcmV0MjsNCj4gIAl9DQo+ICANCj4gIAkv
KiBSZWFkIEFEQyBEYXRhICovDQo+IEBAIC04NTEsMTcgKzg1NSwyMSBAQCBzdGF0aWMgaW50IG1h
eDExNDEwX2luaXRfdnJlZihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICANCj4gIHN0YXRpYyBpbnQg
bWF4MTE0MTBfY2FsaWJyYXRlKHN0cnVjdCBtYXgxMTQxMF9zdGF0ZSAqc3QsIHUzMiBjYWxfdHlw
ZSkNCj4gIHsNCj4gLQlpbnQgcmV0LCB2YWw7DQo+ICsJaW50IHJldCwgcmV0MiwgdmFsOw0KPiAg
DQo+ICAJcmV0ID0gbWF4MTE0MTBfd3JpdGVfcmVnKHN0LCBNQVgxMTQxMF9SRUdfQ0FMX1NUQVJU
LCBjYWxfdHlwZSk7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAgCS8q
IFdhaXQgZm9yIHN0YXR1cyByZWdpc3RlciBDYWxpYnJhdGlvbiBSZWFkeSBmbGFnICovDQo+IC0J
cmV0dXJuIHJlYWRfcG9sbF90aW1lb3V0KG1heDExNDEwX3JlYWRfcmVnLCByZXQsDQo+IC0JCQkJ
IHJldCB8fCAodmFsICYgTUFYMTE0MTBfU1RBVFVTX0NBTF9SRUFEWV9CSVQpLA0KPiAtCQkJCSA1
MDAwMCwgTUFYMTE0MTBfQ0FMSUJfVElNRU9VVF9NUyAqIDEwMDAsIHRydWUsDQo+IC0JCQkJIHN0
LCBNQVgxMTQxMF9SRUdfU1RBVFVTLCAmdmFsKTsNCj4gKwlyZXQgPSByZWFkX3BvbGxfdGltZW91
dChtYXgxMTQxMF9yZWFkX3JlZywgcmV0MiwNCj4gKwkJCQlyZXQyIHx8ICh2YWwgJiBNQVgxMTQx
MF9TVEFUVVNfQ0FMX1JFQURZX0JJVCksDQo+ICsJCQkJNTAwMDAsIE1BWDExNDEwX0NBTElCX1RJ
TUVPVVRfTVMgKiAxMDAwLCB0cnVlLA0KPiArCQkJCXN0LCBNQVgxMTQxMF9SRUdfU1RBVFVTLCAm
dmFsKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJcmV0dXJuIHJl
dDI7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgbWF4MTE0MTBfc2VsZl9jYWxpYnJhdGUoc3Ry
dWN0IG1heDExNDEwX3N0YXRlICpzdCkNCg==
