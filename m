Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2359478AB7
	for <lists+linux-iio@lfdr.de>; Fri, 17 Dec 2021 13:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhLQL77 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 06:59:59 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:16052 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230463AbhLQL77 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 06:59:59 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGLXaKP005153;
        Fri, 17 Dec 2021 06:59:43 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3cywc8mq41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Dec 2021 06:59:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsq2cKKailrzZtnMjcV5XmOX/P9l5uNDWgidHopDSnZBeKm1O63+ujS6kiYqPOm85MQR35jwAwZ7J+UYVakgNPU9iws1i+qFyFrTOwNTgFkFXkB0uPSaN4GO+ssAlmy5RhM157G0zOrWLHMKcV3KhPhIUsER0Hw66Ekbwg0nwxIoXlAtE2I9bF8i2H6IIFCXoULPj9eTWps8E7dPT/CDsqv+R7IcpY7QIHUdZmXMleb2QRNrPysth9SvIy0QRfJOaRhWzmmWULCIKiloVhzMD3vbQd8S4t8saxSJaWSmNz5SS2lWXv7YVFZUUpH8nFDLQ+WPSjyliGbqvhLI4+7kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=begQXEtGYtEVlPTOGlKYCcNkoX5PMXhJUWEgJ6/z5UQ=;
 b=A26MnxpKP/ldPIZVNkpDxBlm+BGzInsLv+vneqa1qvQOvVAg3aveiz80G489JuV3NYPvFbbeLt8qtdvu8Y2ypg3/U66Vjz31Bug6Fh74m8c1fRQ60wnqrWYZZOq4LArCuikvStaaLCBR/ZEqIe1/3KuHYzOQDYWgRSJOOBDDXfZhB/L+HUaeA3w6CunSy7zrxmQYzVb0YjE6pOEybV1cyKvXPKFq9/3/41q5P91uqye086wqXBLlaZbRzvRZV1TX9tx7Kh9v2WpQFbXn9hY8ypNGgejS5tGhKexQLBTbJqXRhrDDXnRoaDH+axYNRk7V3rAzovbLZPVGNC+wsOSeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=begQXEtGYtEVlPTOGlKYCcNkoX5PMXhJUWEgJ6/z5UQ=;
 b=uOC4v2Wj5aIHc8gmSHfTQicWcm5XRi1EwR7hvApcF/VkQfVVHBcC/+tAt0bFsgUYxiaAsnNp+JI0E3oWzdeI+p46Jqvp2bJjslGP4OUXXWxe2o7ndbbSpjtQYmL0ogF4LqQOCtHhAtsipAk1O+tWaYguNoDdb922E/7MGFs9SeU=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6622.namprd03.prod.outlook.com (2603:10b6:510:b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 11:59:40 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::e4d7:ba4c:b6d0:aa6]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::e4d7:ba4c:b6d0:aa6%6]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 11:59:40 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 2/3] iio: ABI: add ABI file for the LTC2688 DAC
Thread-Topic: [PATCH 2/3] iio: ABI: add ABI file for the LTC2688 DAC
Thread-Index: AQHX8Qui2N+qTdIOqEGtX2q27Db9Tqw1IWkAgAFo3fA=
Date:   Fri, 17 Dec 2021 11:59:40 +0000
Message-ID: <PH0PR03MB67861FF3A4EF2A66D194F24899789@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
        <20211214165608.7903-3-nuno.sa@analog.com>
 <20211216133458.307acea4@jic23-huawei>
In-Reply-To: <20211216133458.307acea4@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFkyWXdObUl4WXpjdE5XWXpNQzB4TVdWakxUaGlZVFV0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHTm1NRFppTVdNNUxUVm1NekF0TVRGbFl5MDRZ?=
 =?utf-8?B?bUUxTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTVRZNU9T?=
 =?utf-8?B?SWdkRDBpTVRNeU9EUXlNVFU1TnpnNE16UXlOamMwSWlCb1BTSlNkREZ5YTBz?=
 =?utf-8?B?Mk0xQnBaamhJY21oaFVVdExZelpWTjNSbldEUTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVTlRVRmRIVWxCbVVGaEJaV2QxTW1sRWNrUklhWG8yUXpkaFNV?=
 =?utf-8?B?OXpUV1ZNVFVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: e785c3f1-599e-4298-5df4-08d9c154b4df
x-ms-traffictypediagnostic: PH0PR03MB6622:EE_
x-microsoft-antispam-prvs: <PH0PR03MB66222C5EEBA7EAAC758D0E3899789@PH0PR03MB6622.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nIYIzhX8VssL2+YMtzi8uQKlx5Wz2mU645ho+nWIBVbxODbpZUNsJXsyGE6di9VeODUStueEieWm8QiMmwsE+W7Ud+F0rX2kynxKVHYmSxKeEssm/YIBYFz3lwzdYnlnOD0OTJxv11832+GLsWo3NYX19BLIkubHjpb4xtknvPqTojenC55BTd0YsEE2FnjmyNEv2jyTXx30azQcyALyo9qRxOdKRkX3Jy68tWEHhJKKmA1kyD59HM6vfynry7VkYW+D08YHqhYmVAlGffSG8v6Ai4lckJFAIdQrkCG1TFl0/NFpHo9FiAcD27BRDeK7LRxxIRGrjoEafmghkscRlTiQzrJ0hAtshIFU9YUyVBLOwd7CfXmj9jPDZEXydz4e3KFVYS7EUea8C59qQzrGWeKhoEsh3vmfhiGkK6KEdXhL/ccJ1C7FagErqvYLdfpR8t4dww6EbLdbogQkVprYd1Mr1DSBbCUPz+4Bm/stOV4esi/N1cYf4uVhZIzOXrRLZA2wI0LLRCMCwy+s6NgZAXOQQtfAUH8PEc0xrkSNJjnVaF/mURj9Og2QTBjMOJ2/TZk179SHWzY1u9jjX05NsP4ztjoXJoHeb41tx/hPGPDbi9wY0FH2+gQ7vo4nLRJ+nVDuxiykqZrICiRb7COOjqJR4ggK0aEFvwxnvm+h3hB3lfqSKW/oi/TU0rQx+BgzEuqTfolhxzBziaad7xqPRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(5660300002)(316002)(83380400001)(9686003)(6916009)(38100700002)(86362001)(8936002)(2906002)(8676002)(54906003)(4326008)(52536014)(71200400001)(76116006)(64756008)(7696005)(33656002)(66946007)(66476007)(66556008)(107886003)(55016003)(66446008)(186003)(508600001)(53546011)(38070700005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUlzazNlYkhZVzN6V05uOFYxTG54TWpjdTFPZ3ZGVzZSUlM2Vmlyc25LVEph?=
 =?utf-8?B?ZXZUT1o0bzNVcFFKNEtJTTBIS0dSNFFDcXU3c0FTNWpOVFB0dWZyQjVDVUlq?=
 =?utf-8?B?bXlLOEE5R1c5Y0g0TTFQendLSmxrZm1yamt0RlN6TTkvdFBZZlBGbEl2eTht?=
 =?utf-8?B?MFpJTzZKaktlZ1I4SnNuT3diTSthaWZtNVAySFFsVmV6dy8wdmZjTzZrTzA3?=
 =?utf-8?B?UHYvaXNwT01aYnZNcFNXMTN1SEp1K0xQNm9RQXFraHJLZTVUQVU3TGkyYWI5?=
 =?utf-8?B?a2ErTmlPcHBtQUZuWTNVODczMmRkNll5UDd2dzZ6VmUzTHR3a1dXQ3RTR1Iw?=
 =?utf-8?B?OUo3VEtzYzFmUkQ1WnAvQWxqTWJXOVhaTXF5TjlncG5ROFduMkxxVjNjU2M3?=
 =?utf-8?B?QkxyQUoyTUl6NmR1RDlwbzQ2Uyt5aDEzQWFpVHdSdDliSllDTVJDVE1Xa2o5?=
 =?utf-8?B?TjEwdlZDVmg0UjBVU3NUb1BwV3QxSVEwRTFDZGFMMUd1WEpxa3F2b1NlWjcw?=
 =?utf-8?B?b1JDN21TTWF1bUFiQXVBVkFMdEU5M2JZVjhnTGFCdGtVRm1FckpXUUcyWklD?=
 =?utf-8?B?WG81YXpsMnUxVjRsVDNNU1dWTHN3YTJTSEFjbVAzc3BFUm9UNEtRWU0wUTVr?=
 =?utf-8?B?OGJmVUdIaEJVYmVRamtIRnB2SWZjSk9Pa0lsblNMdzNtTkZqZHdxL050OFJG?=
 =?utf-8?B?Wmd0eWw1NHdrRVlpbHVvamt0d25zbFlCMThDbUpWbm9rekZ5WlBkUTRubGIz?=
 =?utf-8?B?Y0lzNTRoaXZZMDJDakpsMS81VHRBYUNpWXZhcyszQUJ1d3ZFUFZ4eW5UVWpJ?=
 =?utf-8?B?YXY0cXE4WCtqcVhGWW5TV0xiZk93cnZicmV2QUZ4Zklwd1FrK083cmdtaXpW?=
 =?utf-8?B?NTF6UzNlUThuQWNqOCtRUDZWbFJlUnJKbEQ2MkwwSkVxVDNmNFBCaXo4dmp6?=
 =?utf-8?B?NTNINHppcWtlU0p1Rk1sN0I2bW5YT1orVnZkV2FZdFIwaFN3a1BRWm1RaitU?=
 =?utf-8?B?Q05nT2pJVUJ0c1ZTSnBEU1JjNWVhWjVFWFI5UmVRU0xVbmdDNTNCSm1mV0Nk?=
 =?utf-8?B?Q05hRmJsbU1IYTVzWmJvVUp6VitmTjkxL09HdTVwcXNXQ3h4NE85YWJVaTVo?=
 =?utf-8?B?ZWpmWWtzVVUwdmp2RllHcTNseXJ4Tnk4WVE4WkRxaHA0a0NhVUFLTWFOaEhO?=
 =?utf-8?B?cVBHa3hUQ2RNajJ6TkJ6T3VnbVE2RCtldmNQcWVzTlhGSmJTN1Rkd2RFaHJm?=
 =?utf-8?B?TGd4SUlRUTcyN2NhK3JKWTIzbFBEeTlqTmg3QjFUSG5jYmNBM3VHSlEvKzI3?=
 =?utf-8?B?WmFkdm1jYkxrTEJPb2dZU2N1R0pESzRETW0wS04wdmF5Vnc0UEhSMTdLY2F2?=
 =?utf-8?B?MCtxVDNSWFN3TERZMkFPdm1KQVpKUXA4azdwVW9pME5rOEVXZG8wRWJoSEJC?=
 =?utf-8?B?eHJianVwUTB6b09uckRTREZtbFFiaXF4S25iTUpKb1Q0bUx0MjJQSXNzcmdT?=
 =?utf-8?B?bGNQZWc4Wm1RWnJuejJOLzhDWHlDWFdJN3FndCtQZStGbjBmRFZwWkVQMzE4?=
 =?utf-8?B?Y29Jck9VOG9UdDAwU3pFdlQ2NDgzeUxlNk5iMEUrWkdWNEVsTHdFcXpydFMx?=
 =?utf-8?B?Qit6YkovNWd5SHVsS1lZcVhjRXlYcXNMSDdrMmMxL29rTEdjYXJGb1l1aFlD?=
 =?utf-8?B?VDdlZmt3OXp0WWY0Q01WQjVJaE1OTVFHVTIzbWpzY0pBMVFTTi9vbjFzTi9h?=
 =?utf-8?B?MHZPbEdEWHpLOFVLb0FUeDVmdzlpZ2Q2b09naEF5YjkwenA0RHZxRDh2cDMx?=
 =?utf-8?B?WURxTUt4YmpUZXZSWWZBNXF3NDJ5TlE3OXg2NU5PSVRlS3g3VDRDa01CZkNp?=
 =?utf-8?B?TElXcjhEWEp0ZmFxdUU2dGJxWGttRSt0V0x0UU1JZDBPQ3N3VldFc2I3NWtr?=
 =?utf-8?B?eGdPeTVobDJlRDUrMjZKaW44bWEwTFVvNGhxR0JoNUxTb3BHTXh3MG55aUFn?=
 =?utf-8?B?QjBRaVpCbEx2R1FUV0Z3dFA4akIreFU1eTRyYkhuK3owYTZ1Ryt5R0VIVW1x?=
 =?utf-8?B?cCtZam1xWWFCQnBOZVB1dGNOTXBpM0xuZldKNE9LWVI2ZEc5c252cGEzY1No?=
 =?utf-8?B?cGtpdEhiY1ZQaDZiNmFaTVI2azhwMWlyUW40U3MyeXVkNUVwVGlIYndjdXFj?=
 =?utf-8?B?WE5NelluS2YwdnpsZkdac3lOY0tQNkd4eEJwdForWHNwVSswbWxPL2Z2S3R1?=
 =?utf-8?Q?wKJamvlLGqba23SXpvy004/yO08nwapXoCdj0mTOM4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e785c3f1-599e-4298-5df4-08d9c154b4df
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 11:59:40.4180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2nUdBLw4bF3cHLs4uVkSZM1SBMMqdHkombTi8CFU/KoCPUncO+bfh1i4vcyX1l1+hDEZ//qm2+mmybX95rhDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6622
X-Proofpoint-ORIG-GUID: lGGPSvubneOnluNCgcoFqLC81oSY2RjB
X-Proofpoint-GUID: lGGPSvubneOnluNCgcoFqLC81oSY2RjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-17_04,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=891 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170069
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAamljMjMucmV0cm9zbnViLmNvLnVrPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1i
ZXIgMTYsIDIwMjEgMjozNSBQTQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4N
Cj4gQ2M6IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBSb2INCj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTGFycy1QZXRlciBDbGF1
c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+OyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPE1pY2hhZWwu
SGVubmVyaWNoQGFuYWxvZy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBpaW86IEFC
STogYWRkIEFCSSBmaWxlIGZvciB0aGUgTFRDMjY4OCBEQUMNCj4gDQo+IFtFeHRlcm5hbF0NCj4g
DQo+IE9uIFR1ZSwgMTQgRGVjIDIwMjEgMTc6NTY6MDcgKzAxMDANCj4gTnVubyBTw6EgPG51bm8u
c2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IERlZmluZSB0aGUgc3lzZnMgaW50ZXJmYWNl
IGZvciB0b2dnbGUgb3IgZGl0aGVyIGNhcGFibGUgY2hhbm5lbHMuDQo+IERpdGhlcg0KPiA+IGNh
cGFibGUgY2hhbm5lbHMgd2lsbCBoYXZlIHRoZSBleHRlbmRlZCBpbnRlcmZhY2U6DQo+ID4NCj4g
PiAgKiBvdXRfdm9sdGFnZVlfZGl0aGVyX2VuDQo+ID4gICogb3V0X3ZvbHRhZ2VZX2RpdGhlcl9y
YXcNCj4gPiAgKiBvdXRfdm9sdGFnZVlfZGl0aGVyX3Jhd19hdmFpbGFibGUNCj4gPiAgKiBvdXRf
dm9sdGFnZVlfZGl0aGVyX2ZyZXF1ZW5jeQ0KPiA+ICAqIG91dF92b2x0YWdlWV9kaXRoZXJfZnJl
cXVlbmN5X2F2YWlsYWJsZQ0KPiA+ICAqIG91dF92b2x0YWdlWV9kaXRoZXJfcGhhc2UNCj4gPiAg
KiBvdXRfdm9sdGFnZVlfZGl0aGVyX3BoYXNlX2F2YWlsYWJsZQ0KPiA+DQo+ID4gVG9nZ2xlIGVu
YWJsZWQgY2hhbm5lbHMgd2lsbCBoYXZlOg0KPiA+DQo+ID4gICogb3V0X3ZvbHRhZ2VZX3RvZ2ds
ZV9lbg0KPiA+ICAqIG91dF92b2x0YWdlWV9yYXcxDQo+ID4gICogb3V0X3ZvbHRhZ2VZX3N5bWJv
bA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4N
Cj4gPiAtLS0NCj4gDQo+ID4gK1doYXQ6DQo+IAkvc3lzL2J1cy9paW8vZGV2aWNlcy9paW86ZGV2
aWNlWC9vdXRfdm9sdGFnZVlfcmF3MQ0KPiANCj4gSSB3YXMgdGhpbmtpbmcgbW9yZSByYXcwIGFu
ZCByYXcxIHJhdGhlciB0aGFuIG5vdCBoYXZpbmcgdGhlIDAgZm9yIHRoZQ0KPiBmaXJzdCBvbmUu
ICAgSWYgc29tZW9uZSBoYXMgdGhlIGRldmljZSBpbiBhIGNpcmN1aXQgd2hlcmUgdGhleSB3YW50
IHRvDQo+IHVzZQ0KPiB0aGUgdG9nZ2xlIG1vZGUgdGhlbiBJJ2QgYXNzdW1lIHRoZXkga25vdyBh
Ym91dCB0aGUgc3BlY2lhbCBBQkkgYW5kDQo+IGNhbg0KPiBjb3BlIHdpdGggdGhpcy4NCj4gDQoN
CkhtbSBJIHNlZS4gVGhhdCBtZWFucyBtb3JlIHByb2JlIHRpbWUgaGFuZGxpbmcgYnV0IHdlbGws
IHdlIGFyZSBkb2luZw0KYSBsb3QgYW55d2F5cyB0aGF0IGEgYml0IG1vcmUgd29uJ3QgaHVydCA6
KS4NCg0KLSBOdW5vIFPDoQ0K
