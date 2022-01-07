Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C124879DD
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jan 2022 16:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbiAGPo5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jan 2022 10:44:57 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:14158 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239665AbiAGPo5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jan 2022 10:44:57 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207DT6i6010953;
        Fri, 7 Jan 2022 10:44:19 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3depemgaax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jan 2022 10:44:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOXeZesNwsmWdr4EKEKZQaL9KqR6hPpixnV73515bryPc29DR1K6dU01jkgjgIZBQKn5rExbsHq2ZTouAlDDlLs2kaRdDL75yy8ISD18jKCQNkTsZK+WFunsyqGPgbKhJ/xn1ETgs44uxgpDpPlwvefRRb62NSUGcQvh6bbx9E6J4MEBTZn0JcGlDw9c9xwaUgUl7EVIbLdje1/NAjjulD8huRg5dYCLcYMmKIokBlAvje0Dz130YLsOgj+1x92BM8eZjZMKXt/XU3A0RbuQOnkIZD9nUaL7uLZGZzI0K1RM635lkQghaCPUpglGjkQd+Ihk7oyDdeghIBdGPDBOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4MRjNp27Vk5AMiYI5/stEHgIXU0ORw6xkkKR3jPY1g=;
 b=jBuhOGM/nudyn+y0VukvcLSKdntnkw/CpNFOoUNLX+T6iiRpRRIBJa5ep0WTVV4QnA/0pz0G8LSxupR7gqoqRzHWbbOGPb55IZx3lDKFVrbmum8+Wz8WK95hfozhbDGcNN85WtAfAKxI7nvqJG+Jr6QtxB3whMYX2peNSk0FBDM2A5pidQ7dDGQgjfmAhslrpaVxFjIrMJiibvuXAbscjFcNJM0PvaAi7Ik+xnNP0LZ6vDYLhGLB2jchZHFnBHWqfD/gQD6BnIvTJ8Ny+fClppXc8S76tWiE0ScbxwrTyrEuHdbWDHd/uOWI2z5DtrEng5s59XggIm25NYDEbdk/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4MRjNp27Vk5AMiYI5/stEHgIXU0ORw6xkkKR3jPY1g=;
 b=JbNFGn32RZ6zIHGqWEI+XR62TGmpkIGuO8ysdddvtdnI2R1CzI0iNdbvx1yuH0v2x6eub8qYprNoVkchszSg5+uZQe+87dSJXxjjMQAKaROcZ/pPR+GhP6JE5hXDlocx84fUBCkeprDQvgVNNXj9QRD44sFvaDDvFlHpFfKrK2Q=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6689.namprd03.prod.outlook.com (2603:10b6:510:110::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 15:44:15 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5%5]) with mapi id 15.20.4844.016; Fri, 7 Jan 2022
 15:44:15 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 1/3] iio: dac: add support for ltc2688
Thread-Topic: [PATCH 1/3] iio: dac: add support for ltc2688
Thread-Index: AQHX8QuhEU7uaanqVkqKIBVDF63x2qw1K4eAgAFtoECAFKh8AIAMlAGQ
Date:   Fri, 7 Jan 2022 15:44:15 +0000
Message-ID: <PH0PR03MB6786FE5D10EEF4D0EDDC5DB5994D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
        <20211214165608.7903-2-nuno.sa@analog.com>
        <20211216141110.0a4dc0c3@jic23-huawei>
        <PH0PR03MB67867E372410B3C707FE9F2999789@PH0PR03MB6786.namprd03.prod.outlook.com>
 <20211230152816.56d4abed@jic23-huawei>
In-Reply-To: <20211230152816.56d4abed@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFlUazJaVE13WVRRdE5tWmtNQzB4TVdWakxUaGlZakV0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHRTVObVV6TUdFMUxUWm1aREF0TVRGbFl5MDRZ?=
 =?utf-8?B?bUl4TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTVRBMk5q?=
 =?utf-8?B?TWlJSFE5SWpFek1qZzJNRFF6T0RVek9UazFPVE0xTWlJZ2FEMGlORzl3VlRa?=
 =?utf-8?B?bWEyMXpNMHdyWjJacFVrRmtWVXhuY3psR05HRkpQU0lnYVdROUlpSWdZbXc5?=
 =?utf-8?B?SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZNVkpUVWxWR1RrTm5W?=
 =?utf-8?B?VUZCUlc5RFFVRkJOR1pQUW5JelVWQlpRV05PU0hSUE5uVjJhM0pNZHpCbE1E?=
 =?utf-8?B?ZHhOaXRUYzNORVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVo?=
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
x-ms-office365-filtering-correlation-id: f50ce7d8-0f25-4a2c-faa5-08d9d1f48f76
x-ms-traffictypediagnostic: PH0PR03MB6689:EE_
x-microsoft-antispam-prvs: <PH0PR03MB6689AE080C9590E3189B7951994D9@PH0PR03MB6689.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjVyaY7IJRYyr5b4Lhz6ds2/YUYl4257eHGext8oi5gHNnSMcuWDsXef/oT9ywtrvWprjy4HXokczFgTsIyb1yiX007Q2h98uQnqIfLyR9wVVs3ZsS5QiHvWgay35x7qlkNyemV7MB633XcZLv3G/fFMgzS+KvYLlm3d6bAVRADAL8+ejPXcyVhsiX5WNz/qp62/8es5AAik0FeGWpLVBps30jPJZ0EU4wiChXE8hcF3u0Ae4uIV/EZpqMQb4o3lPEQUmHnmbOMAFZDjMxMrwfhvVZZtWN+7fKjBrfjUfddxecqQ+J4roYFiMxamZKLO/Qy+vPC6Y2PzmpU+WfY0Bj0KLSqmlImeUo8zc6RVQM5uKNDAWZ4+6rCSsAbTZthuBlnwo4z4X48b+e0XgAWth295odLhUGN8DYnEuu67E6tqy4jSUilQm39BVUNzqOIbsDWYUl+nixF40jJlySE553zhgn8VkwQClxcC7yz03P3sksyq2j9ioZANUFFql4WpiNVhsVOR+k8EgH1xBlPeSxcMib1KdewL4g7J8JzyOSY+Sl71w1unWySooxMFOxpD2PHEpQphzs/x9tUePTJrGI5IEQlIFg6Ivvz9e0tW9pCYy9YElztpH13YwTegApiorhZ8MKWfqbXDHGoUZ0bmA9geVokRdgKs4DjBd4CpxlYz7/VR4/k5hqrmBdmgm6/f2xMRnhqidTv9mvqtgPGIgkNsy7R+WnKuEH2grgMRIgNB5rkNhkWxUUN7eHcJrjCOcqNQt58zmKBDt9U0BqEHwPpBLHhvMjY7RL/jhtiF87A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(52536014)(64756008)(71200400001)(66476007)(2906002)(7696005)(86362001)(38100700002)(38070700005)(6506007)(53546011)(66556008)(8936002)(66946007)(83380400001)(8676002)(966005)(186003)(76116006)(316002)(66446008)(54906003)(33656002)(4326008)(107886003)(122000001)(55016003)(508600001)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amlhZzhSaFFLcERENGZ5UkNVYXJtVUNtTmlZTkw4TERaKzRCdlQ3MTFEbkVa?=
 =?utf-8?B?bzIyQ0VNVVc2Wi85Z1hXV05kekxKZHdha2ZkZzIvdXhvWHVLTE83Slo3OVhx?=
 =?utf-8?B?K0pqVzlRVjBlb1ZhWWVsUlhzZ2ZuSXVYajFuaS81dHRkdi82d0hTUllJNHFs?=
 =?utf-8?B?L1NJV3BqbjNCR3FvRzVEcUVaSEVmR1dqNHN0aGVETDgyaGNoOWVtbnY1dU9x?=
 =?utf-8?B?Tk9oalRJVzBYWkM1b21TUk93TFFPcjByU2U5YXNMNTZMbUg2UisyTENNTTkx?=
 =?utf-8?B?dzJwT2ZXbWxxWDJTUjg1ejZaRUFxRmlKbE1MYWxSQ0FMOXlINlVobnRvaHdJ?=
 =?utf-8?B?RnJUOU5yOVlXemJ3Nm92OEJUbnpTdmFTYm44dGZtVnIrVmU0dGRPVW1zckxK?=
 =?utf-8?B?T1gyWVo4cG1PK0p0T1dVa2pSZzd3b1VoTFVQK2Y1VmZqeFphZ1prSXV4dmtz?=
 =?utf-8?B?aFVSOXJvYTlxbWJMaXlMMTZ5SUdXWHE5Rm1TcGNYZ215UXhYZGY5NGdyUm04?=
 =?utf-8?B?SUJEM2lUUmJmWTJ1Z09Ca3o0bnlYdmJlRS9CNHliNGp1L25DejNYcitqeFFO?=
 =?utf-8?B?UHBOQTZhTjErbVN2VUlqa3RLNFBiSW9ZdVZ5QzVWbDZoZ1ovbk9jakY2UHgy?=
 =?utf-8?B?bjN2ZlV1R1lzSlJFNC9yVzl0a2FKdEdUQWpjV1docURRaTBRcWpQL0hiYVFu?=
 =?utf-8?B?ejlCOXNURFp0YmJMbWVNdXdLMkpRSDMxSmxNaWszUlhpTFprN0t2WjY0aGtQ?=
 =?utf-8?B?ZWh2MDJFZi9wUnArRDI2bmVDaHZvejNyczV1TWNlOUJlY1o1YjA3djFxekxQ?=
 =?utf-8?B?ZGZiaC9WNUNIS0xHeUFyUW5vcmFnTTNDM2U2cVh0RTJzMGRYZVJEaTJneE1t?=
 =?utf-8?B?NEdzWkU1SENVR21qUjhSOEFGRjVlZ2JDejcvejBhaG1SSjh4VFZNVnBNQ2Q0?=
 =?utf-8?B?VVExNWNGTVMwN0tJc1VNK0IweDBob3pDVXFvTmdmd3p3STMwc0tyMWdUWVls?=
 =?utf-8?B?YjlzbmNpdWFTQjF5SkRhODdsazY5NHNrZHJ4Z1EvaWQyaWtqRVZ0MW9JV0Jx?=
 =?utf-8?B?dE1HRlI1bUJ5QWd5NHRRR2dxaE9yMCtHNFM4UkdoZ0kxaHJzS0pDcFlWOG9I?=
 =?utf-8?B?L2VaUWxXZi9URUhveDRPNDlFTUo4THJ5VjVZcmZoY016Mk96VUtqYU9POCt5?=
 =?utf-8?B?YStYek12S1Y2NlpjYlZ4WlQyaXVRQzNKVHo2T1pwN0Z3Zlg2a3pMQUFwM3VT?=
 =?utf-8?B?c1RFYXVOTUpyRS92Z0UwYmdyNzdvZkdmOG1yWkd3R2VXQkxDYjRUbEo1YklN?=
 =?utf-8?B?cUJ2Vk9tWE8za1BkWnlWMjQxZjVpQUlJYzEzRkF6MXZ1eThWbmY5VnJvdk92?=
 =?utf-8?B?MUdCNm9nSnNkQ1hqT3duWnhHMGt4ODlTL1FQOVVuT1FNZXgvVDI2L2t2T0Ja?=
 =?utf-8?B?aGpsVStnVDc2U1pUQ0ZjUk03eDJhV3pYMjNsVVMveGJHVm1WcUJmNE1ocmFo?=
 =?utf-8?B?ekQ3cGZRaXFnZkloZDhpOVkybVJyT1l3WXYxNDRtWEtJOVIxaytUc0lxelNF?=
 =?utf-8?B?d2VvS1d4NDNJZm83VnA2eEY1VzV2aU9QU0JtVlNZdkdvcHBSUlk4T0V3VE9q?=
 =?utf-8?B?YXlSRFJ2dGxtMzNDbDdyUndRdnR3QjNiVmM2bStGZlhGUGZMUWQvck1TOXQ3?=
 =?utf-8?B?Y2dqeEhnR29HT3h5T0twRWFnV2gwVWJSbFI3Q1Ird002MWs1Rkh2RmdqVmgv?=
 =?utf-8?B?WEl2d0tuOWVZKzVXbjJHTEdCLzlzeWlSN2hHYlgycXl1cEMxWG1OTGdkTHhv?=
 =?utf-8?B?N1B5clhFL1VWaXI5Ym1ObFEzbHY4UGxHTmlnOFc2c1pxR0tmR1NVS3Z3SUNK?=
 =?utf-8?B?R3c5MXN3d2Q1MVpEM1dUQjFKNDdvZEg2cWtJWVRQMWJQUU8yT0NwaDVjVDd6?=
 =?utf-8?B?RjMwK0JpbndidEk4RWRZamlBRFZXaDh1aTRvdThXSFZYL1k0bGhFREZBaHoz?=
 =?utf-8?B?dlZBZHZjS1gwckJTRGNSc0pDSEZOYXVZUXpUaUU5V3lNeGpRWU9LeXdiajEr?=
 =?utf-8?B?T1ZRUGtTWXJEdCtkWTlYcnloNXNCSDZGbEg2YmpGQWVkR1MzS3hqTStFbldw?=
 =?utf-8?B?MFJjUnpvYzlQelU4S1FkNDkyT3k1KzRzclpob0IyM1N4OTF1MHlJM2FreW1Z?=
 =?utf-8?B?QzJha25uVE1YSXI5RndDWHhQNUgwN1V5T2JUQk04YmYyQ0VHRVdEdDBqZFdm?=
 =?utf-8?Q?vrBQm0NX5+Iw1A9KxjqNNKxDYD6Ymw0WJoyOIrfkvg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50ce7d8-0f25-4a2c-faa5-08d9d1f48f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 15:44:15.7707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ePIkLyMNl/VIISQC7HOH+x903R75cgsp4ZJWvbV8D14dLFbTF2eFphu/N245ClLGEDuG+abQdgJ0r20+qy6xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6689
X-Proofpoint-ORIG-GUID: -ykWbfkP2LeiEuc98pnRXXg3zBFG6JjB
X-Proofpoint-GUID: -ykWbfkP2LeiEuc98pnRXXg3zBFG6JjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_06,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070107
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BqaWMyMy5yZXRyb3NudWIuY28udWs+DQo+
IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAzMCwgMjAyMSA0OjI4IFBNDQo+IFRvOiBTYSwgTnVu
byA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBDYzogbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IFJvYg0KPiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+OyBMYXJzLVBldGVyIENsYXVzZW4NCj4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmlj
aCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzNdIGlpbzogZGFjOiBhZGQgc3VwcG9ydCBmb3IgbHRjMjY4OA0KPiANCj4g
W0V4dGVybmFsXQ0KPiANCj4gT24gRnJpLCAxNyBEZWMgMjAyMSAxMjozMTo1NyArMDAwMA0KPiAi
U2EsIE51bm8iIDxOdW5vLlNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiA+IEZyb206IEpv
bmF0aGFuIENhbWVyb24gPGppYzIzQGppYzIzLnJldHJvc251Yi5jby51az4NCj4gPiA+IFNlbnQ6
IFRodXJzZGF5LCBEZWNlbWJlciAxNiwgMjAyMSAzOjExIFBNDQo+ID4gPiBUbzogU2EsIE51bm8g
PE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gPiA+IENjOiBsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgUm9iDQo+ID4gPiBIZXJyaW5nIDxyb2JoK2R0
QGtlcm5lbC5vcmc+OyBMYXJzLVBldGVyIENsYXVzZW4NCj4gPiA+IDxsYXJzQG1ldGFmb28uZGU+
OyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPiA+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29t
Pg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGlpbzogZGFjOiBhZGQgc3VwcG9ydCBm
b3IgbHRjMjY4OA0KPiA+ID4NCj4gPiA+IFtFeHRlcm5hbF0NCj4gPiA+DQo+ID4gPiBPbiBUdWUs
IDE0IERlYyAyMDIxIDE3OjU2OjA2ICswMTAwDQo+ID4gPiBOdW5vIFPDoSA8bnVuby5zYUBhbmFs
b2cuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IFRoZSBMVEMyNjg4IGlzIGEgMTYgY2hhbm5l
bCwgMTYgYml0LCArLTE1ViBEQUMgd2l0aCBhbiBpbnRlZ3JhdGVkDQo+ID4gPiA+IHByZWNpc2lv
biByZWZlcmVuY2UuIEl0IGlzIGd1YXJhbnRlZWQgbW9ub3RvbmljIGFuZCBoYXMgYnVpbHQgaW4N
Cj4gPiA+ID4gcmFpbC10by1yYWlsIG91dHB1dCBidWZmZXJzIHRoYXQgY2FuIHNvdXJjZSBvciBz
aW5rIHVwIHRvIDIwIG1BLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFPD
oSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+ID4NCj4gPiA+IEknbSBub3QgdGhhdCBrZWVuIG9u
IHRvZ2dsZSBoYXZpbmcgdG8gYmUgY2xvY2sgZHJpdmVuLCBidXQgSSBndWVzcw0KPiB3ZQ0KPiA+
ID4gY2FuDQo+ID4gPiBhbHdheXMgY2hhbmdlIHRoYXQgbGF0ZXIgd2hlbiB1c2VjYXNlcyBjb21l
IGFsb25nLg0KPiA+ID4NCj4gPg0KPiA+IEkgZGlkIHdyb3RlIGFib3V0IHNvbWUgY29uY2VybnMg
d2l0aCB0b2dnbGUgKGFtb25nIG90aGVycykgaW4gdGhlDQo+IGNvdmVyLg0KPiA+IFdoZW4geW91
IGhhdmUgdGhlIHRpbWUsIHNvbWUgZmVlZGJhY2sgaW4gdGhlcmUgd291bGQgYmUgdmVyeQ0KPiB3
ZWxjb21lIDopLg0KPiANCj4gRG9oLiAgR3Vlc3MgSSBkaWRuJ3QgbG9vayBhdCB0aGUgY292ZXIg
bGV0dGVyLiBOb3cgcmVwbGllZCB0byB0aGF0IGFzDQo+IHdlbGwuDQo+IA0KPiA+DQo+ID4gQW55
d2F5cywgZm9yIHRvZ2dsZSBtb2RlLCBJIGRvIGFncmVlIHRoYXQgImhhcyB0byBiZSBjbG9jayBk
cml2ZW4iIGlzDQo+IGxpa2VseSB0byBoYXJzaC4NCj4gPiBSaWdodCBub3cgaWYgYSB0b2dnbGUg
Y2hhbm5lbCBpcyBhc3NvY2lhdGVkIHdpdGggYSBUR1B4IHBpbiwgdGhlbiBhDQo+IGNsb2NrIGlz
DQo+ID4gbWFuZGF0b3J5IGFuZCB0aGF0J3MgdGhlIGNvbmRpdGlvbiB0aGF0IHByb2JhYmx5IHNo
b3VsZCBiZSBtYWRlDQo+IG9wdGlvbmFsLg0KPiA+IFNvbWVvbmUgY2FuIHZlcnkgd2VsbCB3YW50
IHRvIGRyaXZlIHRoZSBvdXRwdXRzIHdpdGggYSBHUElPIGV2ZW4NCj4gdGhvdWdoDQo+ID4gaW4g
dGhhdCBjYXNlIHdlIGNvdWxkIGFyZ3VlIHRvIHVzZSB0aGUgU1dfVE9HR0xFLg0KPiANCj4gSSB3
b25kZXIgaWYgd2UgYWxzbyBuZWVkIHRoZSBjYXNlIHdoZXJlIHRoZSB0b2dnbGUgc291cmNlIGlz
IGludmlzaWJsZQ0KPiB0byB1cw0KPiBhcyBpdCdzIHRoZSBvdXRwdXQgb2Ygc29tZSBvdGhlciBo
YXJkd2FyZS4gIE9idmlvdXNseSB3b3VsZCBiZSBuaWNlIHRvDQo+IG1vZGVsDQo+IHRoYXQgaGFy
ZHdhcmUgaW4gRFQgYnV0IHRoYXQgbWlnaHQgbm90IGFsd2F5cyBiZSBwb3NzaWJsZS4NCg0KWWVh
aCwgY291bGQgZmFsbCBpbnRvIHRoZSBob3N0IEdQSU8gdXNlY2FzZS4gV2UgZG9uJ3QgcmVhbGx5
IGNvbnRyb2wgaXQNCmluIHRoZSBkcml2ZXIgYnV0IHRoZSB1c2VyIGNhbiBzdGlsbCB1c2UgaXQg
dG8gZHJpdmUgdGhlIGRhYyBvdXRwdXQuIEFueXdheXMsDQphcyBzdGF0ZWQgaW4gdGhlIGNvdmVy
LCBsZXQncyBsZWF2ZSB0aGluZ3MgYXMgaXMgZm9yIG5vdy4uLg0KDQo+IA0KPiA+ID4gPiArDQo+
ID4gPiA+ICtzdGF0aWMgaW50IGx0YzI2ODhfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmluZGlv
X2RldiwNCj4gPiA+ID4gKwkJCSAgICBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBjb25zdCAqY2hhbiwg
aW50ICp2YWwsDQo+ID4gPiA+ICsJCQkgICAgaW50ICp2YWwyLCBsb25nIG0pDQo+ID4gPiA+ICt7
DQo+ID4gPiA+ICsJc3RydWN0IGx0YzI2ODhfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2
KTsNCj4gPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJc3dpdGNoIChtKSB7
DQo+ID4gPiA+ICsJY2FzZSBJSU9fQ0hBTl9JTkZPX1JBVzoNCj4gPiA+ID4gKwkJcmV0ID0gbHRj
MjY4OF9kYWNfY29kZV9yZWFkKHN0LCBjaGFuLT5jaGFubmVsLA0KPiA+ID4gTFQyNjg4X0lOUFVU
X0EsDQo+ID4gPiA+ICsJCQkJCSAgICB2YWwpOw0KPiA+ID4gPiArCQlpZiAocmV0KQ0KPiA+ID4g
PiArCQkJcmV0dXJuIHJldDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCQlyZXR1cm4gSUlPX1ZBTF9J
TlQ7DQo+ID4gPiA+ICsJY2FzZSBJSU9fQ0hBTl9JTkZPX09GRlNFVDoNCj4gPiA+ID4gKwkJcmV0
dXJuIGx0YzI2ODhfb2Zmc2V0X2dldChzdCwgY2hhbi0+Y2hhbm5lbCwgdmFsKTsNCj4gPiA+ID4g
KwljYXNlIElJT19DSEFOX0lORk9fU0NBTEU6DQo+ID4gPiA+ICsJCSp2YWwyID0gMTY7DQo+ID4g
PiA+ICsJCXJldHVybiBsdGMyNjg4X3NjYWxlX2dldChzdCwgY2hhbi0+Y2hhbm5lbCwgdmFsKTsN
Cj4gPiA+DQo+ID4gPiBJJ20gbm90IGFnYWluc3QgZnVuY3Rpb25zIHJldHVybmluZyB0aGUgSUlP
X1ZBTF8qIGxpa2UgdGhpcywgYnV0IGlmDQo+IHRoZXkNCj4gPiA+IGFyZSBJIGV4cGVjdCB0aGUg
ZnVuY3Rpb24gdG8gc2V0IHZhbDIgYXMgd2VsbC4NCj4gPiA+DQo+ID4gPiBJJ2Qgc3VnZ2VzdCBy
ZXR1cm4gMCBvbiBzdWNjZXNzIGFuZCB0aGVuIGRvIHNpbWlsYXIgdG8gd2hhdCB5b3UNCj4gaGF2
ZQ0KPiA+ID4gZG9uZSBmb3IgY29kZV9yZWFkIGFib3ZlLg0KPiA+DQo+ID4gVHlwaWNhbGx5IEkg
ZG8gbGlrZSB0byBzYXZlIGxpbmVzIG9mIGNvZGUgd2hlbiBkb2FibGUgYW5kIHJlYWRhYmlsaXR5
IGlzDQo+ID4gbm90IGh1cnQgd2hpY2ggaXMgdGhlIGNhc2UuIEknbSBub3QgZG9pbmcgdGhlIHNh
bWUgZm9yIHRoZSBjb2RlX3JlYWQNCj4gPiBiZWNhdXNlIHRoYXQgb25lIGlzIGFsc28gdXNlZCBm
cm9tIHRoZSBleHRlbmRlZF9pbmZvIGludGVyZmFjZS4NCj4gVGhhdA0KPiA+IHNhaWQsIEkgZG9u
J3QgaGF2ZSBzdHJvbmcgZmVlbGluZyBhYm91dCB0aGlzIHNvIEkgY2FuIGRvIGFzIHlvdSBzdWdn
ZXN0Lg0KPiANCj4gRWl0aGVyIG9wdGlvbiBpcyBmaW5lIGZvciBtZS4gIFNldCB2YWwyIGluc2lk
ZSBfc2NhbGVfZ2V0KCkgb3IgcmV0dXJuIDANCj4gZnJvbSB0aGF0IGFuZCB0aGVuIGRvIGEgcmV0
dXJuIElJT19WQUxfSU5UX1BMVVNfTUlDUk8gaGVyZS4NCj4gDQo+IFRoZSBwYXJ0aWN1bGFyIGNv
bWJpbmF0aW9uIGF0IHRoZSBtb21lbnQgaXMgcmF0aGVyIGluY29uc2lzdGVudCBhcw0KPiB2YWws
IHZhbDIgYW5kIHRoZSByZXR1cm4gdmFsdWUgc2hvdWxkIGFsbCBjb21lIGZyb20gdGhlIHNhbWUg
J3NvdXJjZScNCj4gd2hldGhlciBpdCdzIGhlcmUsIG9yIGluIF9zY2FsZV9nZXQoKQ0KDQpBbHJl
YWR5IGRpZCBhcyB5b3UgZmlyc3QgYWR2aXNlZC4uLg0KDQo+ID4NCj4gPiA+ID4gKwljYXNlIElJ
T19DSEFOX0lORk9fQ0FMSUJCSUFTOg0KPiA+ID4gPiArCQlyZXQgPSByZWdtYXBfcmVhZChzdC0+
cmVnbWFwLA0KPiA+ID4gPiArCQkJCSAgTFRDMjY4OF9DTURfQ0hfT0ZGU0VUKGNoYW4tDQo+ID4g
PiA+Y2hhbm5lbCksIHZhbCk7DQo+ID4gPiA+ICsJCWlmIChyZXQpDQo+ID4gPiA+ICsJCQlyZXR1
cm4gcmV0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJCS8qIEp1c3QgMTMgYml0cyB1c2VkLiAyTFNC
IGlnbm9yZWQgKi8NCj4gPiA+ID4gKwkJKnZhbCA+Pj0gMjsNCj4gPiA+IEZJRUxEX0dFVCgpIHdv
dWxkIGdldCByaWQgb2YgbmVlZCBmb3IgdGhlIGNvbW1lbnQuDQo+ID4gPg0KPiA+ID4gPiArCQly
ZXR1cm4gSUlPX1ZBTF9JTlQ7DQo+ID4gPiA+ICsJY2FzZSBJSU9fQ0hBTl9JTkZPX0NBTElCU0NB
TEU6DQo+ID4gPiA+ICsJCXJldCA9IHJlZ21hcF9yZWFkKHN0LT5yZWdtYXAsDQo+ID4gPiA+ICsJ
CQkJICBMVEMyNjg4X0NNRF9DSF9HQUlOKGNoYW4tDQo+ID4gPiA+Y2hhbm5lbCksIHZhbCk7DQo+
ID4gPiA+ICsJCWlmIChyZXQpDQo+ID4gPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArDQo+
ID4gPiA+ICsJCXJldHVybiBJSU9fVkFMX0lOVDsNCj4gPiA+ID4gKwlkZWZhdWx0Og0KPiA+ID4g
PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICt9DQo+IA0KPiAuLi4N
Cj4gDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbHRjMjY4
OF9kaXRoZXJfcGhhc2VbXSA9IHsNCj4gPiA+ID4gKwkiMCIsICI5MCIsICIxODAiLCAiMjcwIiwN
Cj4gPiA+ID4gK307DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaWlv
X2VudW0gbHRjMjY4OF9kaXRoZXJfcGhhc2VfZW51bSA9IHsNCj4gPiA+ID4gKwkuaXRlbXMgPSBs
dGMyNjg4X2RpdGhlcl9waGFzZSwNCj4gPiA+ID4gKwkubnVtX2l0ZW1zID0gQVJSQVlfU0laRShs
dGMyNjg4X2RpdGhlcl9waGFzZSksDQo+ID4gPiA+ICsJLnNldCA9IGx0YzI2ODhfc2V0X2RpdGhl
cl9waGFzZSwNCj4gPiA+ID4gKwkuZ2V0ID0gbHRjMjY4OF9nZXRfZGl0aGVyX3BoYXNlLA0KPiA+
ID4gPiArfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArI2RlZmluZSBMVEMyNjg4X0NIQU5fRVhUX0lO
Rk8oX25hbWUsIF93aGF0LCBfc2hhcmVkKSB7CVwNCj4gPiA+ID4gKwkubmFtZSA9IF9uYW1lLAkJ
CQkJXA0KPiA+ID4gPiArCS5yZWFkID0gbHRjMjY4OF9yZWFkX2V4dCwJCQlcDQo+ID4gPiA+ICsJ
LndyaXRlID0gbHRjMjY4OF93cml0ZV9leHQsCQkJXA0KPiA+ID4NCj4gPiA+IEknbSBub3QgcmVh
bGx5IGNvbnZpbmNlZCBiaWcgbXVsdGlwbGV4ZXIgZnVuY3Rpb25zIGFyZSBhIGdvb2QgaWRlYQ0K
PiBoZXJlLg0KPiA+ID4gVGhleSBzZWVtIHRvIHNhdmUgbGl0dGxlIGNvZGUgYW5kIGh1cnQgcmVh
ZGFiaWxpdHkgYSBiaXQuDQo+ID4NCj4gPiBJIHRoaW5rIHRoaXMgaXMgYSB2ZXJ5IGNvbW1vbiBw
YXR0ZXJuIHNlZW4gaW4gSUlPIGFuZCBwcm9iYWJseQ0KPiBIV01PTiBubz8NCj4gPiBBbnl3YXlz
LCBJJ20gb2sgd2l0aCBlaXRoZXIgd2F5IHNvIEkgY2FuIGp1c3QgZXh0ZW5kIHRoZSBtYWNybyB0
bw0KPiBhY2NlcHQNCj4gPiB0aGUgaW5kaXZpZHVhbCBmdW5jdGlvbnMuIEkgaGF2ZSB0byBhZG1p
dCB0aGF0IGluIHNvbWUgY2FzZXMgKHdoZW4NCj4gbG9ja2luZyBpcw0KPiA+IHJlcXVpcmVkIGlu
IHNvbWUgY2FzZSBibG9ja3MpIEknbSBhbHNvIG5vdCBhIGJpZyBmYW4gb2YgdGhlc2UNCj4gbXVs
dGlwbGV4ZXMNCj4gPiBmdW5jdGlvbnMuIEFuZCBJIHRoaW5rIEknbSBjYWxsaW5nIGluZGl2aWR1
YWwgZnVuY3Rpb25zIGluIGFsbCB0aGUgY2FzZQ0KPiBibG9ja3MNCj4gPiBhbnl3YXlzLi4uDQo+
IA0KPiBDb21tb24gcGF0dGVybiwgYnV0IG5vdCBhbHdheXMgYSBnb29kIGlkZWEuICBBbGwgZGVw
ZW5kcyBvbiBob3cNCj4gbXVjaA0KPiBjb21tb24gY29kZSB0aGVyZSBpcy4gIEluIHRoaXMgY2Fz
ZSBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGVub3VnaCBmb3IgaXQNCj4gdG8gbWFrZSBzZW5zZS4N
Cg0KQWdyZWVkLiANCg0KPiA+DQo+ID4gPiA+ICsJLnByaXZhdGUgPSAoX3doYXQpLAkJCQlcDQo+
ID4gPiA+ICsJLnNoYXJlZCA9IChfc2hhcmVkKSwJCQkJXA0KPiA+ID4gPiArfQ0KPiA+ID4gPiAr
DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiA+ICsJICovDQo+ID4gPiA+ICsJTFRDMjY4OF9DSEFOX0VY
VF9JTkZPKCJkaXRoZXJfZnJlcXVlbmN5IiwNCj4gPiA+IExUQzI2ODhfRElUSEVSX0ZSRVEsDQo+
ID4gPiA+ICsJCQkgICAgICBJSU9fU0VQQVJBVEUpLA0KPiA+ID4gPiArCUxUQzI2ODhfQ0hBTl9F
WFRfSU5GTygiZGl0aGVyX2ZyZXF1ZW5jeV9hdmFpbGFibGUiLA0KPiA+ID4gPiArCQkJICAgICAg
TFRDMjY4OF9ESVRIRVJfRlJFUV9BVkFJTCwNCj4gPiA+IElJT19TRVBBUkFURSksDQo+ID4gPiA+
ICsJSUlPX0VOVU0oImRpdGhlcl9waGFzZSIsIElJT19TRVBBUkFURSwNCj4gPiA+ICZsdGMyNjg4
X2RpdGhlcl9waGFzZV9lbnVtKSwNCj4gPiA+ID4gKwlJSU9fRU5VTV9BVkFJTEFCTEUoImRpdGhl
cl9waGFzZSIsIElJT19TRVBBUkFURSwNCj4gPiA+ID4gKwkJCSAgICZsdGMyNjg4X2RpdGhlcl9w
aGFzZV9lbnVtKSwNCj4gPiA+ID4gKwlMVEMyNjg4X0NIQU5fRVhUX0lORk8oImRpdGhlcl9lbiIs
DQo+ID4gPiBMVEMyNjg4X0RJVEhFUl9UT0dHTEVfRU5BQkxFLA0KPiA+ID4gPiArCQkJICAgICAg
SUlPX1NFUEFSQVRFKSwNCj4gPiA+ID4gKwlMVEMyNjg4X0NIQU5fRVhUX0lORk8oInBvd2VyZG93
biIsDQo+ID4gPiBMVEMyNjg4X1BPV0VSRE9XTiwgSUlPX1NFUEFSQVRFKSwNCj4gPiA+ID4gKwl7
fQ0KPiA+ID4gPiArfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBp
aW9fY2hhbl9zcGVjX2V4dF9pbmZvIGx0YzI2ODhfZXh0X2luZm9bXSA9IHsNCj4gPiA+ID4gKwlM
VEMyNjg4X0NIQU5fRVhUX0lORk8oInBvd2VyZG93biIsDQo+ID4gPiBMVEMyNjg4X1BPV0VSRE9X
TiwgSUlPX1NFUEFSQVRFKSwNCj4gPiA+ID4gKwl7fQ0KPiA+ID4gPiArfTsNCj4gPiA+ID4gKw0K
PiA+ID4NCj4gPiA+ID4gKw0KPiA+ID4gPiArZW51bSB7DQo+ID4gPiA+ICsJTFRDMjY4OF9DSEFO
X1REX1RHUDEsDQo+ID4gPiA+ICsJTFRDMjY4OF9DSEFOX1REX1RHUDIsDQo+ID4gPiA+ICsJTFRD
MjY4OF9DSEFOX1REX1RHUDMsDQo+ID4gPiA+ICsJTFRDMjY4OF9DSEFOX1REX01BWA0KPiA+ID4g
PiArfTsNCj4gPiA+DQo+ID4gPiA+ICsvKiBIZWxwZXIgc3RydWN0IHRvIGRlYWwgd2l0aCBkaXRo
ZXIgY2hhbm5lbHMgYmluZGVkIHRvIFRHUHgNCj4gcGlucyAqLw0KPiA+ID4gPiArc3RydWN0IGx0
YzI2ODhfZGl0aGVyX2hlbHBlciB7DQo+ID4gPiA+ICsJdTggY2hhbltMVEMyNjg4X0RBQ19DSEFO
TkVMU107DQo+ID4gPiA+ICsJdTggbl9jaGFuczsNCj4gPiA+ID4gK307DQo+ID4gPiA+ICsNCj4g
PiA+IGJpdG1hcCBwZXJoYXBzIGdpdmVuIG9yZGVyaW5nIGRvZXNuJ3QgbWF0dGVyIChJIHRoaW5r
KQ0KPiA+ID4NCj4gPg0KPiA+IFllYWgsIGRpZCBub3QgdGhvdWdodCBhYm91dCBpdCBidXQgSSB0
aGluayBpdCB3aWxsIGxvb2sgYmV0dGVyIHdpdGggYQ0KPiBiaXRtYXAgeWVzLg0KPiA+IEFsdGhv
dWdoIEknbSBub3Qgc3VyZSBpZiBJIHdpbGwgY29udGludWUgd2l0aCB0aGlzIGFwcHJvYWNoIG9y
IG1ha2UNCj4gdGhlIGNsb2Nrcw0KPiA+IHByb3BlcnR5IGEgcGVyIGNoYW5uZWwgb25lIChtb3Jl
IG9uIHRoaXMgaW4gdGhlIGNvdmVyIGxldHRlcikuDQo+IA0KPiBJJ20gbm90IHN1cmUgaG93IHRo
ZSBwZXIgY2hhbm5lbCB2ZXJzaW9uIHdpbGwgbG9vayBzbyBsZWF2aW5nIHRoaXMNCj4gZW50aXJl
bHkNCj4gdXAgdG8geW91IQ0KPiANCj4gPiA+DQo+ID4gPiAuLi4NCj4gPiA+DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gK3N0YXRpYyBpbnQgbHRjMjY4OF9jaGFubmVsX2NvbmZpZyhzdHJ1Y3QgbHRjMjY4
OF9zdGF0ZSAqc3QpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJc3RydWN0IGZ3bm9kZV9oYW5kbGUg
KmZ3bm9kZSA9IGRldl9md25vZGUoJnN0LT5zcGktDQo+ID4gPiA+ZGV2KSwgKmNoaWxkOw0KPiA+
ID4gPiArCXN0cnVjdCBsdGMyNjg4X2RpdGhlcl9oZWxwZXIgdGdwW0xUQzI2ODhfQ0hBTl9URF9N
QVhdID0NCj4gPiA+IHswfTsNCj4gPiA+ID4gKwl1MzIgcmVnLCBjbGtfaW5wdXQsIHZhbCwgbWFz
aywgdG1wWzJdOw0KPiA+ID4gPiArCXVuc2lnbmVkIGxvbmcgY2xrX21zayA9IDA7DQo+ID4gPiA+
ICsJaW50IHJldCwgc3BhbjsNCj4gPiA+ID4gKw0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgeW91IG5l
ZWQgdG8gc2FuaXR5IGNoZWNrIHlvdSBoYXZlIGEgZndub2RlDQo+ID4NCj4gPiBBRkFJQ1QsIGl0
J3MgZG9uZSBieSB1cyBhbHJlYWR5IDopDQo+ID4NCj4gPg0KPiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3MNCj4gb3Vy
Y2UvZHJpdmVycy9iYXNlL3Byb3BlcnR5LmMqTDc0MV9fO0l3ISFBM05pOENTMHkyWSFzeFZBcDhQ
OFhTDQo+IDBSNXNSNDQ3aEttVnU3ZEswMWZkc01mTDZfYzR3b3o3a0RzYnNJMmZLTEtmV29wSzRt
T1EkDQo+IA0KPiBBaC4gIEdvb2QgcG9pbnQuIElnbm9yZSB0aGF0IG9uZSB0aGVuLg0KPiANCj4g
Pg0KPiA+ID4gPiArCWZ3bm9kZV9mb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfbm9kZShmd25vZGUs
IGNoaWxkKSB7DQo+ID4gPg0KPiA+ID4gSSBndWVzcyB0aGlzIGlzIGJlY2F1c2Ugb2YgdGhlIHdo
b2xlDQo+ID4gPiBkZXZpY2VfZm9yX2VhY2hfYXZhaWxhYmxlX2NoaWxkX25vZGUoKSBub3QNCj4g
PiA+IGV4aXN0aW5nIGRpc2N1c3Npb24gdGhhdCBpc24ndCByZXNvbHZlZC4NCj4gPg0KPiA+IGV4
YWN0bHkuLi4gSSB3YW50ZWQgdGhlIGF2YWlsYWJsZSBvcHRpb24gYW5kIHRoaXMgd2FzIHRoZSBv
bmx5IHdheSBJDQo+ID4gY291bGQgZmluZC4uLg0KPiA+DQo+IA0KPiBIbW0uIEkgbmVlZCB0byBy
ZXZpc2l0IHRoYXQgZGlzY3Vzc2lvbiBhbmQgc2VlIHdoZXJlIHdlIGdvdCB0by4NCj4gDQo+ID4g
Pg0KPiA+ID4gPiArc3RhdGljIGJvb2wgbHRjMjY4OF9yZWdfd3JpdGFibGUoc3RydWN0IGRldmlj
ZSAqZGV2LCB1bnNpZ25lZA0KPiBpbnQNCj4gPiA+IHJlZykNCj4gPiA+ID4gK3sNCj4gPiA+ID4g
KwlpZiAocmVnIDw9IExUQzI2ODhfQ01EX1VQREFURV9BTEwgJiYgcmVnICE9DQo+ID4gPiBMVEMy
Njg4X0NNRF9USEVSTUFMX1NUQVQpDQo+ID4gPg0KPiA+ID4gSXNuJ3QgVVBEQVRFX0FMTCB0aGUg
bGFzdCByZWdpc3Rlcj8gIFNvIGhvdyBkbyB5b3UgZ2V0IGhpZ2hlciB0aGFuDQo+ID4gPiB0aGF0
Pw0KPiA+ID4gRGVmaW5pdGVseSBuZWVkcyBhIGNvbW1lbnQgaWYgdGhlcmUgaXMgYSByZWFzb24g
dGhhdCBjaGVjayBpcw0KPiA+ID4gbmVjZXNzYXJ5Lg0KPiA+DQo+ID4gSWYgeW91IGxvb2sgYXQg
dGhlIGNvbW1hbmRzIHRhYmxlIHlvdSBzZWUgdGhhdCBvbiB0aGUgd3JpdGUgc2lkZQ0KPiA+IHdl
IGp1bXAgZnJvbSAweDc2IHRvIDB4NzggKFVQREFURV9BTEw9MHg3YykuIDB4NzcgcmVmZXJzIHRv
DQo+ID4gcmVhZGluZyB0aGUgdGhlcm1hbCBzdGF0dXMgcmVnIHdoaWNoIGlzIG5vdCB3cml0YWJs
ZS4gQWN0dWFsbHkgaW4gdGhlDQo+ID4gZW5kLCBhcyBpdCdzIGEgcmVhZCB0aGUgY29tbWFuZCBm
b3IgcmVhZGluZyB0aGUgdGhlcm1hbCBzdGF0dXMgd2lsbA0KPiA+IGJlIDB4ZjcuDQo+IA0KPiBJ
J20gbG9zdCBvbiB0aGlzLiAgIE15IGNvbmZ1c2lvbiBpcyBob3cgeW91IGdldCA+DQo+IExUQzI2
ODhfQ01EX1VQREFURV9BTEwNCj4gUG9zc2libHkgdGhhdCdzIHdoYXQgeW91IGFyZSByZWZlcnJp
bmcgdG8gd2l0aCB0ZWggcmVhZCBjb21tYW5kIGJlaW5nDQo+IDB4Zi4uLg0KDQpFeGFjdGx5Li4u
IFNvIEknbSBiYXNpY2FsbHkgdXNpbmcgdGhlIHJlZ21hcCByZWFkIGJpdCB0byBnZXQgdGhlIHJl
YWQgY29tbWFuZA0KYXMgaW4gdGhlIGRhdGFzaGVldC4gQW5kIHRoYXQgYml0IGlzIHN0aWxsIG5v
dCBzZXQgd2hlbiB3ZSBnZXQgaW50byB0aGVzZSBjYWxsYmFja3MNCndoaWNoIG1lYW5zIHlvdSBj
YW4gZ2V0IDB4NzcgaGVyZSB3aGljaCBpcyA8IExUQzI2ODhfQ01EX1VQREFURV9BTEwgYnV0DQpz
dGlsbCBub3Qgd3JpdGFibGUuLi4NCg0KSSBkaWQgaGFkIGEgY29tbWVudCBmb3IgdjIuIExldCdz
IHNlZSBpZiBpdCdzIGdvZCBlbm91Z2ggOikNCg0KLSBOdW5vIFPDoQ0K
