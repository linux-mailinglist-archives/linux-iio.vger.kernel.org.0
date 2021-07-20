Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1450D3CFA90
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 15:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGTMvD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 08:51:03 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5626 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238531AbhGTMjN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 08:39:13 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KDBVX1004569;
        Tue, 20 Jul 2021 09:17:47 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 39wfmqjtu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 09:17:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcZD050aO8rjOZymsD8Qdg+hqfI/IhlCE/o8AQfJUYkKDF2EalfpI+jx5ExmxmWUdyVujIsFVOUscaBmAojDJQRHLFeBQZLzFUNUIMDaOCzS5VjqchqskWEhRjRce6Z0iuch9UVHgeuKv3mjRFBosQE0I83JXlWJ6ereWIrXsSAAEz5gIHu+8ZpAcT77ei+GDMNwBNAG28ac+VWVNRwm70C+0IS9xn4UA8kPtdBXlz0A6In/3zayCi9vW1DAzJdt8CASvkkWOKN4cGGJ1+8Y2C4SEWa9wKXtHl/y2JPK9kyQK5WTEPdIHicLsH2KCP5E4PZ7D98istxlJQk2nMnbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mce7cE1Aehor0fjtt9KntY4GLvodotO5ylTp5CXPQEA=;
 b=ehpaAtST+AGiEM5QYcYc/xQsv1yuONDkC1DjtsA5ENSJRzyZPsL/S7z4sq27xHp7D98O5p/GAIiXk+yfkb6/MqOYwnZMod+OcfytKsfit6o9XFSlLNmdanNqeHedNNMfv0qu6AS7sKBPBOOOsVWtdZaL1q3cM11GwVaIBwHe7aSdUaRXBLmoxeW5NVIx2P8xoIKgaCouVMLoVROu5aM81ePXW8PzEvUbGyGFdIKtTEJKI43IQEn2Po/vPUW4qAc4mpBvMEq2oEz8gjtw704sVSsJK0NvQC+jMVx5DF1zJK2lUYMtQtMyHrgm6OXAE1vxbiCJHal1yCr1IjjCcN4uJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mce7cE1Aehor0fjtt9KntY4GLvodotO5ylTp5CXPQEA=;
 b=key0F+39epbHjKIguBerdnWfI2zYzVdx1Iga6N6SLYgNXB/4uFpkNGorPXR2xKQUhd0qt36C73rFJRjIPJuUhbLoiPAVr2MqdqjIZwmss04qCZ4DdrG/B19ecq2VA6sC0mc34Ifk5zuTq0yGCwjvCrAaevTV3zNcFxJecOC5bsg=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY1PR03MB2140.namprd03.prod.outlook.com (2a01:111:e400:c61a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 13:17:46 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::d078:2202:7a5c:8e39]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::d078:2202:7a5c:8e39%7]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 13:17:46 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] iio: frequency: adrf6780: add support for ADRF6780
Thread-Topic: [PATCH v6 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Thread-Index: AQHXejemy+Zld3yeGkqXu4f9qC/DS6tFsDUAgAYdZ5A=
Date:   Tue, 20 Jul 2021 13:17:46 +0000
Message-ID: <CY4PR03MB3399083DDE3A03C55D3153FE9BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
 <CAHp75VcNhJrp4YGZQu1ZB2J4ARtuT2T2p-72H1qn4F+KtZDVoQ@mail.gmail.com>
In-Reply-To: <CAHp75VcNhJrp4YGZQu1ZB2J4ARtuT2T2p-72H1qn4F+KtZDVoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFrWXpnek56RmpaQzFsT1RWakxURXhaV0l0WVdJNU1DMHhOR0Zp?=
 =?utf-8?B?WXpWbU0yUXpNamhjWVcxbExYUmxjM1JjWkdNNE16Y3hZMlV0WlRrMVl5MHhN?=
 =?utf-8?B?V1ZpTFdGaU9UQXRNVFJoWW1NMVpqTmtNekk0WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlOalkxSWlCMFBTSXhNekkzTVRJMk1EWTJNak0xTURFM01UVWlJR2c5SWpK?=
 =?utf-8?B?a2EwTXZka3QxZFhCWFZuSnJWakJoYW1OM1lUZ3JWMUZhY3owaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVbFpSRUZCUTFScVVVdG1ZVmd6V0VGa1dYVXhhSGxhY2xOSVNU?=
 =?utf-8?B?RnBOMWRJU20xMFNXTm5Sa0ZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVGWFFYZEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlJHMTFaSFJSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSm9RVWhK?=
 =?utf-8?B?UVdGUlFtaEJSamhCV2tGQ2NFRkhUVUZrUVVKd1FVYzRRV0puUW1oQlNFbEJa?=
 =?utf-8?B?VkZDWmtGSVVVRmhVVUpzUVVoSlFVMVJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJt?=
 =?utf-8?B?ZEJRVUZIUlVGalowSndRVWRGUVZoM1FtdEJSMnRCV1hkQ01FRkhhMEZpZDBK?=
 =?utf-8?B?MVFVZEZRV05uUWpWQlJqaEJaRUZDY0VGSFZVRmpaMEY1UVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZE?=
 =?utf-8?Q?QUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b90b37c-b157-4f18-1435-08d94b80c3c9
x-ms-traffictypediagnostic: CY1PR03MB2140:
x-microsoft-antispam-prvs: <CY1PR03MB214082D92783240A17400D6E9BE29@CY1PR03MB2140.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VMFE4TBiKQhJJ+N4DqfuhfVqteNW+MisNxR94VB8ma5o0hJORZMEdC0vVAdKRqiEpQ1ViZiPeM4bt+B4h7QsxJFQzpdEXJ9DFrxMU+zjnourbUAuFvjdYpBAFFOaYDRzSnxjNMhQVFHW0k9xbqJq1dQa39OjxlQDuXhY8T+kK90y4sxHIhStBRLNwlvw4Kf2wS2H9QmzrQB4/Khy52bhI6gOYq+SFgrF5MmpeOOdASf0oyCTmq1n0PS/E2ZS+wT7hL5B4waeQhPmPGi87qMNM8iI4kN1hdrrSeY4QUjNwCkHsUgt9inqd0a9zl1rTu6c5SVNniJ/QSPjU6jpjMbcolh+bAXM7cOPLcMAmfEeMJkpXg4FA+bPaD+D2S0FWQR7yYt4/uXdS0TBQuEi+DVOdpeCxKUsYR7g1+QFGuCD+3pl0dsPCDMV51RmZQVkUGdCbo67ovszU+WDPc2k5/L5h6EIM3dwJnaCJWUYq+QZWCwf1mzG9eoFRjlT9HPWBBJjSTsJSV45QGbFoIHUJ60/Mm0IUI6MH+lK6kqAMFq2uavOBKNGxRPwP48Ddcw465e67tivJplrnzVq+7zSB/dll5qrOxQWDpbTe+9wMV8laIm0zl3W/Q+4FSr2alSVI+//QZAv+TmDiDuLcWNYgqRbGT23s3wu04BqtOxqX7kmL+8kFwksMR7P2ccnlmvSBLOpQrKO3LOJJRLKolafWP4o6Nr7xGPpwBjRyYJvQ8+rDoYKXgtCaamduwnFL5DBJhoK2t33adjbGYmSKPExrEw+0PZkD4gPVo91G0NyuszjK39q8OSQGqIKycqlTMRTsuZo0VchybOjgSofONI3XtUFKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(6506007)(76116006)(316002)(38100700002)(53546011)(186003)(83380400001)(54906003)(9686003)(71200400001)(4326008)(6916009)(26005)(8676002)(66946007)(55016002)(66446008)(7696005)(8936002)(122000001)(64756008)(5660300002)(33656002)(2906002)(52536014)(478600001)(966005)(86362001)(66556008)(66476007)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2JkdnJhR3BwT0NMQ3RuNnlienIrTTVCREYzd1IvcjR0T3VVNUJxbWpJZzhH?=
 =?utf-8?B?WEE5RUdEM3pyMzdUV080aFJQOWdyQlhrdVBZb1o1NjlGR3cydENhd09Kd0tP?=
 =?utf-8?B?R0dKOTlIYzB1YnJFSVZTdmhVT2RPVFRYaUQ4OVhWSDU2K3h5TkhCVlVEcmlX?=
 =?utf-8?B?TGQvRHR3Z2xhcktvbHpMRlo4dHV2V1FoVHlPczdVUmd0a3ZYMlVYSjF0YlVB?=
 =?utf-8?B?eGdhaEtQbFV5eUhhNHgzZ1B1SDVQVUZ3c2pLSk11UG5Sem5jRGltTXNuMFNF?=
 =?utf-8?B?dldDKzhIcVpnOUpPdU9NMXhiUGFJbmozamo4NVRtSVJaT2s3Y2Q5ZnMxZnh1?=
 =?utf-8?B?bVg2blZpNlZDenhLRGtTakZmSFk5SWFhaER1eXNuVGlvOERud1pCL0ErSnBl?=
 =?utf-8?B?c1JoZit3QTBBTGJnN2lCVDduQlBvVGlVaXpLeDlBYzNjNEVYcE1pMzVWVEg1?=
 =?utf-8?B?ZVN0VXVrRTBlWm5NRS9pWkVpNHFwS05DRE85dzdiZktXdlozYUVMVGNXWkx3?=
 =?utf-8?B?WWl1a0I0d0ZHOWM1ZG9XY0lnT0RlcDV6aGU5LzFpVmM0UE4vMHNVY0s3Q25z?=
 =?utf-8?B?UFJJUmtiaXlLZjluY1pIamNOREp4VWVXSDNPdC9TUVlmaU9WRGNRZW9EczZR?=
 =?utf-8?B?MlF6TDVHcCt2WHdrYS9DTkhBdmdBaXRTWHZ3dXNMVUJoTGhFczBHOW4wQkFE?=
 =?utf-8?B?MVZJTnJlc2hrNkFqTlpUZnVkY1N2NXdQdTBMQXN5d0U1dlRBMFdqd2FCWnds?=
 =?utf-8?B?bEd6V0pIUktTQlowQUVVcStaQ0kycUxDK1NmQjZ2UTZFMFgrbVNmbWROeG5q?=
 =?utf-8?B?ZFVleDlFM1dVZTNESjJUZzgrcXZBRjAvSWFmZjAwMUs1WDlzWU1wakUwaStT?=
 =?utf-8?B?S01nd0JrOHR2dkdydzFNVWFTa0FQd2RJdzVQVnZTZDVuSUFHSnBRdmVsRmVZ?=
 =?utf-8?B?anR1cENHTG4reFZpNVh5cWJReEcwSEMzRTN2bGRXcVhaSXNsRmVyM2l6QnVB?=
 =?utf-8?B?azAwOTdnalBaeDQyQUY5cjl2MXJvMmdYMjdRcFVveEhMcVM2cDNJbTkxUE1h?=
 =?utf-8?B?RXluV1NFSUxvZWQzeWlSUDZCTDA4aXlpSWRtSVZKcTFoZ2sya1paeGhBVU9H?=
 =?utf-8?B?eXN4d2gzdFZ6UWg5OFA3T21YczZ3UCtRMTZVaU5IOGlQajg2dmd6dkY5QTFW?=
 =?utf-8?B?SFpwaWl3eWZWUWZvWnVvcS9hM1JNVUhtT0k3REpaNXhiY2NLRXZRWG84cmlp?=
 =?utf-8?B?QU9VekRnN2RRd003bWNHWTRhdUlPNlhEOE9mRmM5bWRRSUVsbFB5c1V6U05D?=
 =?utf-8?B?Ykw0eVdPQ0hVSkErZmZVcWtRbEJkS1A1UE1tV1ZUcnVNMzJEendJY1VORER4?=
 =?utf-8?B?WnZKclVPVU5pV1dyOEl6QWg5czM0UXhxMmdCZkI0U0tCZTh2M21aaEZyZXdK?=
 =?utf-8?B?VldneUkzbWphQTlMbHJjWjAyWU1ERUxZRFdwZVU0dGhKM3hGOVFMVFZ3MjZZ?=
 =?utf-8?B?b1luaU9mY2pSZGZBWTlRZXhnRzBJQ3o3V1IrRUQyOFVMRXpKaWp2amFFNUlm?=
 =?utf-8?B?YTB3WXJIa29IU3pFQmlZR1pMUlBMdmVJZ2ppUko5eGhET0FvaGVrSG0vSFZR?=
 =?utf-8?B?YmJJMmZkSm5uTW9nY3RkT3h2NUthdlJkcDZQRFY4SXo5Zng0eldrNjJUWElz?=
 =?utf-8?B?ZEx1TXVOQVFFT2pzamdROTlkUnZPZ1ZpZEg2ZWtLYnorNDdRVU5aNlc2WWI0?=
 =?utf-8?Q?B68QkZt+LOENEs825Q=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b90b37c-b157-4f18-1435-08d94b80c3c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 13:17:46.1428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tM1GIuKLJSutNpnK0qpy7sdjqci/Gi2Eh6lLeMiFqO5l7rvRVHDshfIpWB3qVnExmqJJD404tgEejgrCSocrNWBm1PD/Ko/0HBlzURTU2bI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2140
X-Proofpoint-ORIG-GUID: TXbahj2-WkfsRetDRlN3AMPt_8qcWhiW
X-Proofpoint-GUID: TXbahj2-WkfsRetDRlN3AMPt_8qcWhiW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_07:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107200086
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGVsbG8gQW5keSwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Og0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdt
YWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDE2LCAyMDIxIDU6NTMgUE0NCj4gVG86IE1p
Y2xhdXMsIEFudG9uaXUgPEFudG9uaXUuTWljbGF1c0BhbmFsb2cuY29tPg0KPiBDYzogbGludXgt
aWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gamlj
MjNAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NiAxLzJdIGlpbzogZnJlcXVlbmN5OiBhZHJmNjc4MDogYWRkIHN1cHBvcnQgZm9y
DQo+IEFEUkY2NzgwDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIEp1bCAxNiwgMjAy
MSBhdCAyOjQzIFBNIEFudG9uaXUgTWljbGF1cw0KPiA8YW50b25pdS5taWNsYXVzQGFuYWxvZy5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIEFEUkY2NzgwIGlzIGEgc2lsaWNvbiBnZXJtYW5pdW0g
KFNpR2UpIGRlc2lnbiwgd2lkZWJhbmQsDQo+ID4gbWljcm93YXZlIHVwY29udmVydGVyIG9wdGlt
aXplZCBmb3IgcG9pbnQgdG8gcG9pbnQgbWljcm93YXZlDQo+ID4gcmFkaW8gZGVzaWducyBvcGVy
YXRpbmcgaW4gdGhlIDUuOSBHSHogdG8gMjMuNiBHSHogZnJlcXVlbmN5DQo+ID4gcmFuZ2UuDQo+
IA0KPiA+IERhdGFzaGVldDoNCj4gPiBodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3Rl
Y2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtDQo+IHNoZWV0cy9BRFJGNjc4MC5wZGYNCj4gDQo+
IElzIGl0IG9uZSBsaW5lPyBJZiBub3QsIHBsZWFzZSBwdXQgb24gb25lIGxpbmUgYW5kIGRyb3Ag
YmVsb3cgdGhlDQo+IGJsYW5rIGxpbmUgc28gaXQgd2lsbCBnbyBhcyBhIHRhZy4NClllcywgaXQg
aXMgb25lIGxpbmUuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW50b25pdSBNaWNsYXVz
IDxhbnRvbml1Lm1pY2xhdXNAYW5hbG9nLmNvbT4NCj4gDQo+IEZpcnN0IHF1ZXN0aW9uIGlzIHdo
eSBub3QgdG8gdXNlIHRoZSByZWdtYXAgQVBJIChJIGhhdmUgaGVhcmQgaXQgaGFzDQo+IGdhaW5l
ZCBzdXBwb3J0IG9mIDE3IGJpdCk/DQoNCkluaXRpYWxseSB0aGF0IHdhcyB0aGUgcGxhbiwgYnV0
IGFmdGVyIHRoaXMgcGF0Y2g6DQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29t
bWl0LzQxOTFmMTk3OTJiZjkxMjY3ODM1ZWIwOTBkOTcwZTljZDYyNzdhNjUNCnRoZSBjdXN0b20g
d3JpdGUgZm9ybWF0cyBmb3IgcmVnbWFwIGFsbG93IHRoZSByZWFkIG9ubHkgdmlhIGNhY2hlZCBy
ZWdpc3RlcnMuDQoNClRoZXJlZm9yZSwgSSBwcmVmZXJyZWQgdXNpbmcgc3BpIHRyYW5zZmVycyBm
b3Igd3JpdGUvcmVhZCB0by9mcm9tIHRoZSBkZXZpY2UuDQo+IC4uLg0KPiANCj4gPiArICAgICAg
ICBkZXBlbmRzIG9uIENPTU1PTl9DTEsNCj4gDQo+IElzIGl0IG1hbmRhdG9yeSBmb3IgYW55IGZ1
bmN0aW9uIGluc2lkZSB0aGUgZGV2aWNlPw0KDQpZZXMuIEl0IHdpbGwgc2VydmUgYXMgTE8gaW5w
dXQgdG8gdGhlIGRldmljZS4NCj4gDQo+IC4uLg0KPiANCj4gPiArc3RhdGljIGludCBhZHJmNjc4
MF9zcGlfcmVhZChzdHJ1Y3QgYWRyZjY3ODBfZGV2ICpkZXYsIHVuc2lnbmVkIGludCByZWcsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50ICp2YWwpDQo+ID4g
K3sNCj4gPiArICAgICAgIGludCByZXQ7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgc3BpX3RyYW5zZmVy
IHQgPSB7MH07DQo+IA0KPiA+ICsgICAgICAgZGV2LT5kYXRhWzBdID0gMHg4MCB8IChyZWcgPDwg
MSk7DQo+IA0KPiBUaGlzIDB4ODAgSSBndWVzcyBpcyBwcmV0dHkgbXVjaCBzdGFuZGFyZCBhbmQg
cmVnbWFwIFNQSSBzdXBwb3J0cyBpdC4NCj4gDQo+ID4gKyAgICAgICBkZXYtPmRhdGFbMV0gPSAw
eDA7DQo+ID4gKyAgICAgICBkZXYtPmRhdGFbMl0gPSAweDA7DQo+ID4gKw0KPiA+ICsgICAgICAg
dC5yeF9idWYgPSAmZGV2LT5kYXRhWzBdOw0KPiA+ICsgICAgICAgdC50eF9idWYgPSAmZGV2LT5k
YXRhWzBdOw0KPiA+ICsgICAgICAgdC5sZW4gPSAzOw0KPiA+ICsNCj4gPiArICAgICAgIHJldCA9
IHNwaV9zeW5jX3RyYW5zZmVyKGRldi0+c3BpLCAmdCwgMSk7DQo+ID4gKyAgICAgICBpZiAocmV0
KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArICAgICAgICp2
YWwgPSAoZ2V0X3VuYWxpZ25lZF9iZTI0KCZkZXYtPmRhdGFbMF0pID4+IDEpICYgR0VOTUFTSygx
NSwgMCk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gPiArfQ0KPiANCj4gLi4u
DQo+IA0KPiA+ICsgICAgICAgdXNsZWVwX3JhbmdlKDIwMCwgMjUwKTsNCj4gDQo+IE5lZWRzIGEg
Y29tbWVudC4NCldpbGwgYWRkIGluIG5leHQgcGF0Y2ggdmVyc2lvbi4NCj4gDQo+IC0tDQo+IFdp
dGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg0KUmVnYXJkcywNCkFudG9uaXUN
Cg==
