Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA073CFCFE
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 17:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhGTO0o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 10:26:44 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:45062 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239531AbhGTNwn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 09:52:43 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KEIPS8008650;
        Tue, 20 Jul 2021 10:33:13 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0b-00128a01.pphosted.com with ESMTP id 39wjfkabu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 10:33:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7BR3m1wTCYldeLDsbx2diY81sqrypT1rQcnwJxEqlRhklp9SmpStIZreWbJfIDSTBVaY1ULRv0RUeTmNdJ7Fv2Apr20o/VenGyByuO1kCHNukvwJNnih+DzaROIX1zQ4TR8sI9ku5SsCRZ6FasNBb6JlpMGSwGaz5PdF0JxQgvqA1XBpNIsstlhrQib+dCm18JB6TCDVv89XAGH11tvk/WktFSyxG36cCZo1OmM2EWzo1f+M1Chu8FVfjoV3tEvyBIBoZr3IgyZ6YxuS8kGgA6Wc8ZOthTKA3+YQmh8kBUeCZXIyH5z7pi4kSP6mwSmyCb2pA3IAR9eEnLrrcx8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O71PPsoQCMRoFYwFBkgYCUTObORM33pHKwUvpmHTZ5c=;
 b=b2166DtNHT2PKvBNgmZFmUvJ7vTwTZeC4CcTyN7bWnKOD+OZytOeT59kTFhn3mDfzeVOkM0cQjiFQPa8rFbJguflGv5sbcLZg/l2XiNgtbXBMx6CEOb4hJv5nBYG39cwdCKKe8C8MUX5dVsvaNiW8kcI4fRbDAmrJbnrwjb/qhn/3gTOhv3Gmuv8UD3VzNC7BcvmOtEnLXLUrDbe4JsJCtJ+HhbCCAOCeh1llfLbln608e3AMcoNIJX1s1Nl1UiqZJIpD3QJ2OOTK1AxUi1S7MkahzP1/Dlb4BB8b3mJ/8p2B2if2gqk0+/fvFBaxbEYNxq/gzlUZqdM54Y0WNplpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O71PPsoQCMRoFYwFBkgYCUTObORM33pHKwUvpmHTZ5c=;
 b=H0YwLjROlTEAPhI7WiQKAJmYqyVoDHXJvCcZSSGWYDYdoTuECrh2/2AtVFk2E8TtPqiKgWK3BM5CCyjzIxMEqrFxVm8f4bbgbBKZ/LdUpIN61Ftx2SHM96j/GykFuWIAiO5dRFUX47vt0ksLW4JM15g3tnANiSOmLDaLk1X/hyM=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY4PR03MB2869.namprd03.prod.outlook.com (2603:10b6:903:136::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 14:33:10 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::d078:2202:7a5c:8e39]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::d078:2202:7a5c:8e39%7]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 14:33:10 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] iio: frequency: adrf6780: add support for ADRF6780
Thread-Topic: [PATCH v6 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Thread-Index: AQHXejemy+Zld3yeGkqXu4f9qC/DS6tFsDUAgAYdZ5CAAB8dgIAAAXSg
Date:   Tue, 20 Jul 2021 14:33:10 +0000
Message-ID: <CY4PR03MB339939479450FC5F3E8172D39BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
 <CAHp75VcNhJrp4YGZQu1ZB2J4ARtuT2T2p-72H1qn4F+KtZDVoQ@mail.gmail.com>
 <CY4PR03MB3399083DDE3A03C55D3153FE9BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
 <CAHp75VcN2fjVDMfkpgyE2tqu=21ku4KBowNDKJxvpbKzwuEPew@mail.gmail.com>
In-Reply-To: <CAHp75VcN2fjVDMfkpgyE2tqu=21ku4KBowNDKJxvpbKzwuEPew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAyTldZeE1UWXpOeTFsT1RZM0xURXhaV0l0WVdJNU1DMHhOR0Zp?=
 =?utf-8?B?WXpWbU0yUXpNamhjWVcxbExYUmxjM1JjTmpWbU1URTJNemd0WlRrMk55MHhN?=
 =?utf-8?B?V1ZpTFdGaU9UQXRNVFJoWW1NMVpqTmtNekk0WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlNekE1SWlCMFBTSXhNekkzTVRJMk5URTROemszTmpjNU5qY2lJR2c5SW1O?=
 =?utf-8?B?UGVIQlNXbTlxUjNSVlFsVmxXblJuU1VKMFp6VnNhbVZrV1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVbFpSRUZCUTJaWU16UnZaRWd6V0VGWFVrZ3llRVJOYzFWR05s?=
 =?utf-8?B?cEZabUpGVFhsNFVWaHZSa0ZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-office365-filtering-correlation-id: e01db256-aab6-4c24-6573-08d94b8b4c6b
x-ms-traffictypediagnostic: CY4PR03MB2869:
x-microsoft-antispam-prvs: <CY4PR03MB28693C07095660F06F7EC4B09BE29@CY4PR03MB2869.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MglQiqup7xExVWManZdn/knZ9lA2UvveLJlu8iZVogiikJosVJNL4f+OsiuvCukyag3azmgPY41RjLba8n4JsZRkiR5Nk8MzGqNr/VaFx/dI/8XOWuH8ab/9JlY5gJFHjq3+46dpFS6dEhF3SdTChE+0pYAzHl7Dq/2g3ipH5QXRbqCjpdfgpLMbG7/DDDmFMrPhtpqrSgKQ4/VBovjtl1kgJ8zjiN197op+tN31MSTT9599aE4v0fBft5mfQrmAQWrwm1BPRwGQAvTmBI8hixihCFJBnlknOnzUXpHY4tdqaoKnAeE2WElFKEVXjmkf59GV/5MDU5OUNWy+AQ9BmznJVSui97I2yumIRvzUB+YS5ngwds5dtx5Rsv1AUkwerzFNjmh/NXK7xu3TqpnPzFUOEq/o5bULbbobJSpoATbsMA1vYygHSxAe9wY9WRN5N3DalauTDYfJwQXuA3qicjJ3BkD0N4pGglUiL9HkkkC6byl01+qwl7P2Ap3FFTmI4HsxsAdFIax4e+LQehBcWLhGkY3Rf2tuKaRSDk6/54dVoLS/ObcrvuhCeZxGuZQwy6zQA1x2OGKXM3wE1xKhOsdSMtktiRplvlH8hOe2dN2f94CMXAAo3DaqW6I8zzBQFKhInYt4FvbrrNzZjy0+o8srqD2jhdg3WS/yANguZK6gSntpOp1PjauvOl/k6jZ5UOmggfsXBfbUB/WWQmTvlSlhypBPWooMfUzIaL7C7CKcCu2CEFdX8KWqWfsedkhjgre76p78gvuqzVDi+tfEwvLVgRT2gbsalSma7s6QYDYR62he6HzpLPofin2bZObvxCuLIVriVnyaK7wz4cPXgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(478600001)(7696005)(55016002)(8676002)(5660300002)(83380400001)(53546011)(86362001)(38100700002)(33656002)(2906002)(4326008)(26005)(966005)(9686003)(8936002)(6506007)(186003)(54906003)(122000001)(64756008)(316002)(66476007)(66556008)(76116006)(66446008)(66946007)(71200400001)(6916009)(52536014)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0VhNXVQblVtU3FDSlFXVmM4enl2V0VTZlkvUDEwMkc0eWorRElsdE1ZY1Zl?=
 =?utf-8?B?K1Q3TC9CQUlKSDB6RzRwR2hrQmxEMHRtRUttWE5XWm00SElucDdUMFdxYkdj?=
 =?utf-8?B?eThmSFlqVkNXSytxd2NiK3hSZVpOc2o5Si9scUI3VzdhcWorSnhXelNoSkhi?=
 =?utf-8?B?dEkvQW1qS29CQ2lYOW1yU2RjbjNIUjdmdGIzUzUwQk9wZFBsSzhUVjVZQWZv?=
 =?utf-8?B?ZkpYQm9FVlVoZnhBdFhaa01RdjZBOTdJUEw2TExlaVNIV0I3Tzg0T3BzWSta?=
 =?utf-8?B?MUdHQmY3UnRUQkJudWZYNG04SWZDeU5ZSG01S3hxL00rSVQxMGxSS0FmdnlM?=
 =?utf-8?B?cFBVTU1RTkIwVFR2WFBOZ3lhOTR4c2RWamJSK1g4NGpldks0NUlqK3hTcXFN?=
 =?utf-8?B?Z1VMNjBrTGxaS0duZ3Y0aVFacnNCeUVSUTJzQXphTFQ4aUZyY1d3Ukw3RnBF?=
 =?utf-8?B?Y3Z1QllNWHpaZXRNZ2w2QTQrQnJ1a2JQZWt2VXF4TlNGMzlFZjhQaWRNeVVC?=
 =?utf-8?B?WEZKQitmbUFMRnpFT2VGQ1RnWHV4RitBMjlEMDVBc29uaHdQOUx5M2x5ckUx?=
 =?utf-8?B?ZDhrbHFvYWtaTzcxRkpkVXFJWE5XcjhyOXJuM0FCSXNzWDRXMDNwSGo5c3g0?=
 =?utf-8?B?NmltSjViVlBPQ1g0ZG1vdTNqbHVHWG96d2d1a3JaaWhLVElSdDdaa29HZG82?=
 =?utf-8?B?OWV5MDc2VytwT01DRE5vRjFCTHN3M1dkQVR1M2trUXNVWEFIVUNuZlVKeTAz?=
 =?utf-8?B?WEY3ZFNQSDRBaS93MWlvWmpKRnF0dW1qNkYwNHdTNXM1Y1IwbUx5ejBFT1Fa?=
 =?utf-8?B?elZHZHVHcU9HalJLRDBkMVJCM1pLTG9HVFVCcDZJOVdSdGI0ZHBDNlBRUCto?=
 =?utf-8?B?YndpbXlUVXJnckVTVFJLanJPYS9STVRvalFHckxrTGxCc2Era243UEpocXg2?=
 =?utf-8?B?SU9oOThvYkl2WXpZdW11NTdMN2ZjdkMzZFhLMFE3bWgzRGNYSEFSOUVPRnJX?=
 =?utf-8?B?M0ZOMFRjN0IyVzQyN284U1pVdVk0dDFlaEM4S0ZjQm9CM2QxNmlEOHZNa3Jj?=
 =?utf-8?B?NlBnZmNOZnN2NVNBQlRwRFIwYWkyWWJqcDNXNTE0N2VNZkwyMHRZKzZtRitF?=
 =?utf-8?B?L1dtSHVwZ0lJaXYrV0dsVTIwa05NdldLV2U5dzZzZkx2eUNRRHJrRG5wdEFR?=
 =?utf-8?B?c0dVMWVvUlAxQnN3Tnk0NGZaTlF2K0FvYkNhTjRuVWNBTmZJQXYrN084MXdZ?=
 =?utf-8?B?NzVjTW54aUVYZWVVT0pzZnJwVmtrUEszNHJhbldRbUdVaGo2OUNrK0ZlTmZy?=
 =?utf-8?B?bEkvbUc4UmtHekdXSFFKSjQwRzRreGtYUzcwMEltdGhqa2JYY0JOcGp0NmJz?=
 =?utf-8?B?ZTRtTjBlZXFsdzFDaUpRRzA1OGJRVStMMFZHaXF1Z1dKT09ma2dWNkNHYVJW?=
 =?utf-8?B?VkZnMXh4QkIwWTFTM05NUTdtL3lkMHg3MWlDUEtUUm54L1VMWkJOWkNPYUdQ?=
 =?utf-8?B?cEJELzM1aDFwTkR6Mlh3bEVYWEJyQlFyUTVpYWRVcUhHeG9YeE5pUVdhbldv?=
 =?utf-8?B?bm5OQmJhUjBZWDNIczFZT2JrMHU3VFBid1lTWFFEc2xGNlJCR0ZUQzIvMlN1?=
 =?utf-8?B?VHFISkNaY05HNElCYlBNWVRuY0lDcW5KMUlDR1BqKzNNQlJaUENoeFM1cXA3?=
 =?utf-8?B?VnhqZU4zWGF3ZWFnQmFLU253NEYyOGV4NTRPN3RKREN6YzNKMUVRbFFRSS9C?=
 =?utf-8?Q?5N5ZiW0GEDsWxMeLNtvqDkTmbEvmEx6QIVUzazR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01db256-aab6-4c24-6573-08d94b8b4c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 14:33:10.2880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2hd2WCgzbHMYlx0J684V78zq7uY344lOICgS5Oe8HU0luy8m6upY4xU05W5Hm6tA47BsejasRKHwNutrclouvdCTGnwRYpptCK/DPkvLiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2869
X-Proofpoint-ORIG-GUID: JT4ooF2N6OTi6HLa6X3WNTUBxqii9J43
X-Proofpoint-GUID: JT4ooF2N6OTi6HLa6X3WNTUBxqii9J43
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_09:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107200090
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjAsIDIwMjEg
NTowOCBQTQ0KPiBUbzogTWljbGF1cywgQW50b25pdSA8QW50b25pdS5NaWNsYXVzQGFuYWxvZy5j
b20+DQo+IENjOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBqaWMyM0BrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDEvMl0gaWlvOiBmcmVxdWVuY3k6IGFkcmY2Nzgw
OiBhZGQgc3VwcG9ydCBmb3INCj4gQURSRjY3ODANCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9u
IFR1ZSwgSnVsIDIwLCAyMDIxIGF0IDQ6MTcgUE0gTWljbGF1cywgQW50b25pdQ0KPiA8QW50b25p
dS5NaWNsYXVzQGFuYWxvZy5jb20+IHdyb3RlOg0KPiA+ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBKdWx5IDE2
LCAyMDIxIDU6NTMgUE0NCj4gPiA+IE9uIEZyaSwgSnVsIDE2LCAyMDIxIGF0IDI6NDMgUE0gQW50
b25pdSBNaWNsYXVzDQo+ID4gPiA8YW50b25pdS5taWNsYXVzQGFuYWxvZy5jb20+IHdyb3RlOg0K
PiANCj4gLi4uDQo+IA0KPiA+ID4gRmlyc3QgcXVlc3Rpb24gaXMgd2h5IG5vdCB0byB1c2UgdGhl
IHJlZ21hcCBBUEkgKEkgaGF2ZSBoZWFyZCBpdCBoYXMNCj4gPiA+IGdhaW5lZCBzdXBwb3J0IG9m
IDE3IGJpdCk/DQo+ID4NCj4gPiBJbml0aWFsbHkgdGhhdCB3YXMgdGhlIHBsYW4sIGJ1dCBhZnRl
ciB0aGlzIHBhdGNoOg0KPiA+DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvY29tbWl0LzQxDQo+IDkxZjE5NzkyYmY5MTI2Nzgz
NWViMDkwZDk3MGU5Y2Q2Mjc3YTY1X187ISFBM05pOENTMHkyWSFwdFVWMFlDMm5mRA0KPiA2QWRI
X3k1VTB6aXlFTGw0QjlwREwwdWJrZHBGSEZ0ckZORV9OcVVTX1RXbV9nRS1TbEhWMzE1QWskDQo+
ID4gdGhlIGN1c3RvbSB3cml0ZSBmb3JtYXRzIGZvciByZWdtYXAgYWxsb3cgdGhlIHJlYWQgb25s
eSB2aWEgY2FjaGVkDQo+IHJlZ2lzdGVycy4NCj4gPg0KPiA+IFRoZXJlZm9yZSwgSSBwcmVmZXJy
ZWQgdXNpbmcgc3BpIHRyYW5zZmVycyBmb3Igd3JpdGUvcmVhZCB0by9mcm9tIHRoZQ0KPiBkZXZp
Y2UuDQo+IA0KPiBOb3Qgc3VyZSBJIGZvbGxvdyB5b3UuIFRoYXQgcGF0Y2ggaXMgdXBzdHJlYW0u
IERvZXMgaXQgcHJldmVudCB5b3UNCj4gZnJvbSBzd2l0Y2hpbmcgdG8gcmVnbWFwIFNQSSBBUEk/
DQoNCkl0IGRvZXMgbm90IHByZXZlbnQgbWUgZnJvbSBzd2l0Y2hpbmcgdG8gcmVnbWFwIFNQSSBB
UEkuDQpJdCB3aWxsIHByZXZlbnQgbWUgZnJvbSB1c2luZyByZWdtYXBfcmVhZCB0byByZWFkIGRp
cmVjdGx5IGZyb20gZGV2aWNlLg0KaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Nv
bW1pdC80MTkxZjE5NzkyYmY5MTI2NzgzNWViMDkwZDk3MGU5Y2Q2Mjc3YTY1I2RpZmYtM2UwYjdk
MmYwYTU1YWRiNjU3MzY5M2E1MTRjYjgwMjRhODFhNTVkYTg0OGNiMjI2MzJhYjVmZDRkZDZkZDRl
NFIzOQ0KDQo+IA0KPiAuLi4NCj4gDQo+ID4gPiA+ICsgICAgICAgIGRlcGVuZHMgb24gQ09NTU9O
X0NMSw0KPiA+ID4NCj4gPiA+IElzIGl0IG1hbmRhdG9yeSBmb3IgYW55IGZ1bmN0aW9uIGluc2lk
ZSB0aGUgZGV2aWNlPw0KPiA+DQo+ID4gWWVzLiBJdCB3aWxsIHNlcnZlIGFzIExPIGlucHV0IHRv
IHRoZSBkZXZpY2UuDQo+IA0KPiBCdXQgY2FuIHRoZSBkZXZpY2Ugd29yayB3aXRob3V0IGl0ICh3
aXRoIGxpbWl0ZWQgZnVuY3Rpb25hbGl0eSk/DQpUaGlzIGFzcGVjdCBpcyBub3QgY2xlYXJseSBz
dGF0ZWQgaW4gdGhlIGRhdGFzaGVldCwgYnV0IHNpbmNlIHRoZSBFbmFibGUgcmVnaXN0ZXIgaGFz
IHRoZSBMTyBlbmFibGVkIGJ5IGRlZmF1bHQsIEkgY29uc2lkZXJlZCB0aGlzIGFzcGVjdCBhcyBi
ZWluZyBtYW5kYXRvcnkuDQpJIHdpbGwgdHJ5IHRvIGZpbmQgb3V0IG1vcmUgaW5mb3JtYXRpb24g
ZnJvbSB0aGUgaGFyZHdhcmUgZ3V5cyB3aG8gZGV2ZWxvcGVkIHRoZSBwYXJ0Lg0KDQo+IA0KPiAt
LQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
