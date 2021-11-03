Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B949D44439A
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 15:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKCOdi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 10:33:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1512 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231590AbhKCOdi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Nov 2021 10:33:38 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A3BiECO001061;
        Wed, 3 Nov 2021 10:30:59 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c3dv7bgg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 10:30:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOIyTTpsYrcroPc9Xl2j/S23yMnekdBtUYiJyjrh9aGC2LWCZVPl2rk9uzNm1gW3zgodj6N0kFMPLvU/Px2jbIt8adf2jrDPkw42LmDvWt+Fi8e+nnJb9xAPSoZaklgSUZ6gG4GRy88yTuFi6TpNHZO0a1iFnnWdl2x6MdwkakvWvs98gdqAJh9mUWmPlVTNjL/PZOKfCup6o0XGKKnMH1YRccCsd97i5lEjOhlYSwBrcVHduNBCOHKRedkFKaYpAfRW+rZ85RwaRO0RNkvLzoan9BduQrxgW8C+T3oV+1kRguEY3CGd2d/uqtYc6ZdbQc4ZG7xU6HYwd6/4t8ki+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnBVBlFBlFTa64MgJv5qNMidbTt3IQgc5kI76FlQs0A=;
 b=fKu5wGqzAzwVYfDNPJQZH/zuAPFfCPsPIVE7D+zV9s/emOpp8etDjJOISryJdQ9ja+X3vRw3t63jYcdbPs6xqEZTKmTucEukKpbr015WxVMOCJNTbstjZ9Qwb5QAImSeqiZVrRnEw8DWUX9s+j7PeBeVy6OqfOVNlZ3rasmy0CherDu9CoB6vXINFfU1dJ3kdV8K6r55olERKSx2XVrZPGg3FdzvaQD+mbCDkfPRBuD18R2DqhzjwM5zCkeVsPWVYdMpqPvvW2ONFX6wEgz+sCtmySvYHEP2pl/+xypDXzjosmfPd1xODOhfAsX3ZJfUfZ1fdWyHlj6GRuQJz1BGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnBVBlFBlFTa64MgJv5qNMidbTt3IQgc5kI76FlQs0A=;
 b=PtfOb4jNRqBBuEiA4eAJOy7DOsDayTNKhLqidz6yNwVd9kIS/V+QX++uRwlmT6Wg0Woc6t0+BknvGQs/N30NMv7e7bpTfvIVhmXaZjIJmzt0XBUCHQmk4ClChBd6IHBb9zvZxttPsQElmDGjRA3L3GVX4cr29Evr8oPYshM3thk=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY4PR03MB2504.namprd03.prod.outlook.com (2603:10b6:903:3c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 14:30:56 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0%3]) with mapi id 15.20.4649.019; Wed, 3 Nov 2021
 14:30:56 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: RE: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
Thread-Topic: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
Thread-Index: AQHXzwfj21y5Dnr/k0eZeDeswgk2M6vwhjwAgADvSCCAAGjUYA==
Date:   Wed, 3 Nov 2021 14:30:56 +0000
Message-ID: <CY4PR03MB3399682ABFC08090528FED2C9B8C9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211101100420.70304-1-antoniu.miclaus@analog.com>
 <20211101100420.70304-2-antoniu.miclaus@analog.com>
 <YYF6cPSDroPz/wun@robh.at.kernel.org>
 <CY4PR03MB3399E5DC1D8A966C7CFC8C049B8C9@CY4PR03MB3399.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB3399E5DC1D8A966C7CFC8C049B8C9@CY4PR03MB3399.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1hNWE1MTAwYy0zY2IyLTExZWMtYWJlNS?=
 =?iso-8859-2?Q?0xNGFiYzVmM2QzMjhcYW1lLXRlc3RcYTVhNTEwMGUtM2NiMi0xMWVjLWFi?=
 =?iso-8859-2?Q?ZTUtMTRhYmM1ZjNkMzI4Ym9keS50eHQiIHN6PSI1NTYyIiB0PSIxMzI4MD?=
 =?iso-8859-2?Q?QyMzQ1MzI4NzcxNzQiIGg9IitqZWtHalBNZDNwejFmUGQ2UVpRK09kelJ5?=
 =?iso-8859-2?Q?cz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBQjI4LzludjlEWEFSMnd6QmhHc3RvU0hiRE1HRWF5MmhJ?=
 =?iso-8859-2?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBWFEvampRQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-2?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-2?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-2?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-2?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-2?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-2?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd35d680-fedb-4046-477b-08d99ed68c87
x-ms-traffictypediagnostic: CY4PR03MB2504:
x-microsoft-antispam-prvs: <CY4PR03MB25042D81427264C772DA5AE49B8C9@CY4PR03MB2504.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TesgVAGpt9a/jZAiOr3ywxxD6AizVob6KlnBCkMInvO+1Hqj7mEGHC0umpaeRyn4jwSuuvRcQZOu5PG5bIRp9sOn2dpqQ0ghSMiCE0dr9GRseUwcFcubKQ0NFx5cVhs7uuq0hW2QJR3CJ4PYcczmvlmncItsR+aO4iw3vAblQ2s6ABT8LgnYHcLoPsWeMpzCeM+Q+Oz3XlywhqC5saXyOcGc1da7RNCNsIeMEgcjmJkCI5MHMeCljP15UPAj7iehvF59Afml9MvqgBxFLD9iqh0QQP7il7izmOnkHdzFo9hucSLy7lnQuojrsfgMy/t/A5tDZQGRuopbgEfQLDfjsv0s3uyMwflNrrv7GuPSvoURUP3IUqT3HT2vNwn0PruQWEUQa7nEu1IZIO9ICK3s1k8qkNRRuNvFsvQmum0ED3e+peXhytZLkL0CFyh3XPgrqpGLk8GvHD2EgTF3Vxb0Rbgn/HzTL8V55CL2KhkhRVMkI1Uo9NgR75nIIG1nFPRb8ZRgocUoc+EcWLn/ZdWtREkab7kySbE5CZkFuNBFMN/XkW1xfxrixREN7OuQW7PsQ+9mX0OtpMJJbSBzi+rzKP8FU3TpU6SMGmdWNKZKB8zl4cEkxghae8N8FpHT5oEQgZDHSSV5ganKwS42xziQFEHj+53RxVi//3fbbJS3xrKhm4zrfqTzk/X+jVtH5LzqGPlZKNjIs7dZboSqx3QbtnzURcjodAq01Q8szbERbm7ZfwqT6Vxl5yxqnEUPwCE8kh24LhXlXBszdTZGbjwPYgJ5wH1oUYM1d7rzAqYMzGOU7ps0bj1T1ZrTJVets6/pKEweHgALw/1XyZwTo1wftg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2940100002)(8936002)(55016002)(6916009)(26005)(107886003)(86362001)(53546011)(66556008)(52536014)(54906003)(966005)(5660300002)(76116006)(4326008)(66946007)(316002)(64756008)(8676002)(38070700005)(66476007)(186003)(66446008)(9686003)(6506007)(71200400001)(7696005)(66574015)(38100700002)(508600001)(33656002)(83380400001)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?fBWRduyt5I9D+BzISDJWURCD5/XtW9yH7IbQHQ4gHZanrxdNDAaVNJulAv?=
 =?iso-8859-2?Q?rx/Zx713/zhfV+55jalI20K2eeSUhTRzTZhowei0BqFY6j6SJQxIDJlWrW?=
 =?iso-8859-2?Q?+vIKr7L/1AJS2tmR52JRwEMReOhMT4uq4NEGrlkGs/Dm4Gy1RlzG5nT7Yp?=
 =?iso-8859-2?Q?j/Pj6/R8qZ9hQqdgyWb1yym3Tiq8saNjAfftlNDsCwhPaULL0ESt7D5/OZ?=
 =?iso-8859-2?Q?6U/pgiJ6NnDgckyibavIgNDsmDhS/sbRyUXVZmZ6+EO0HsZDj8bXF4It4K?=
 =?iso-8859-2?Q?f2ZPvBz3hMaYBzVzMxWmBIcKFlSFnC0VRvfp7SvJv2i1Snc1lIWIVyvuXF?=
 =?iso-8859-2?Q?qfcVfttDNYAyN9K/woTYI+r5Syp2Sk2QAo7nKiZ1v8siJJSQcf6p4/RCqh?=
 =?iso-8859-2?Q?rFoJmM2TaJRhk8bVmGf0F93f8LHaXAmNDvcJHxUMWYnEKXKxY573JkTkDi?=
 =?iso-8859-2?Q?gnnPR2i+CYZzuictoUWJvquLj9NjeYwtgCeDtGGIAUgii+xJ3kE9eLRb2N?=
 =?iso-8859-2?Q?Z3KARrQaiyYTonRjhdO+Vtvxk2XBoR7rY6GRBpn9gblkIwteEkHD3v7rK4?=
 =?iso-8859-2?Q?JCOafb7qvalxGCkJq2AL0lP/oOu4S6TB21lHiodzSU4a6x3E9x57QLsqAj?=
 =?iso-8859-2?Q?khmybFfJb973sscHFE3s6yvvQIgtcNm8uNttJIP4Q84DL3u6QH/YthW/RJ?=
 =?iso-8859-2?Q?DCEPttaRx5iA0JloIE7efnwEm4xa3RsScidVv3W0WXrUPJfaqPaDNTdJG5?=
 =?iso-8859-2?Q?Y6YCAF5tt4wrs5WfGk05lK6GylrDjFOwAzKlAPqU42f1My9tp9ulc9nrfQ?=
 =?iso-8859-2?Q?LZ906PQsBluK5ebzGPq8QGJqnXxca4NHcJqj8P+4fRdx8Es+NJ0qNEiMp7?=
 =?iso-8859-2?Q?x2m6lVPem7DHfWaHlZgC0wlLWSxhX/kzwyTx9NSvkRNRFcADUHyOv5zVdK?=
 =?iso-8859-2?Q?qkJbMco5hYUKz82dSMqJLRfOtOYSWC5rO0C4Blnd3jStSQ77OTen6t3Yhs?=
 =?iso-8859-2?Q?INfJW5riy7etn0uENSNbR44ya4WEXEKMttLf7oMHuxdQhyturpcTbc/41I?=
 =?iso-8859-2?Q?YFfqd66P6Ls/fiHlxAM29IEKtFOqMKsWo8HjvNbjQ4Z0zMen69OTQmzRGo?=
 =?iso-8859-2?Q?jLu5WpOrxDIMdlm6gRG1BTUldOXU6uDZLM8qYaCciJxyIYKD5uvAHou3fh?=
 =?iso-8859-2?Q?RcdKfL6bhypYDqHP/cBD6GFXlMVWRiYHA/NFxCL2Jmb+Gb/3pg5j69w06g?=
 =?iso-8859-2?Q?aVs5FmbECesDxzm7PaTXRJ1up7qK73HhRJEU4Xc16UvQbbZCECDaFeTJEf?=
 =?iso-8859-2?Q?CzOWiguUanJivrGO473nH/SGVe0oFji2v3cXy6FaKTiLDCZge7cPE2HEa8?=
 =?iso-8859-2?Q?Y5WRtPbiW8PACqFIjFAGPMzpkdItKwKKKA+7IyF++WVX+KBoNVxEIB9uLi?=
 =?iso-8859-2?Q?Vv+l8t6GbW9MhiEx69GaS0BtImGEKTwhXI9O0H8vrF5Mrwhawjz1iSwzmk?=
 =?iso-8859-2?Q?Wk8D4FXJhTw+opXpk77tiMqxVhI7LSH3l8NPsxQ+UXvCY8dGDNIlrnYoKM?=
 =?iso-8859-2?Q?Ol7cbILJ2C1CT9wapQ2HinmdJrUfULLNJPAS+OrUn2MwmFxcA0INVFq7Bs?=
 =?iso-8859-2?Q?2YHDCklaT2t5//wqr+RfoTqq8J34yk7HyOTGkd2FDRafaebKrE9ibhtODU?=
 =?iso-8859-2?Q?ftcZz5H/HxLPTvKAojCUW+Y1vuP0el8TequddffZlK0KZ53sC2jkbVTnpM?=
 =?iso-8859-2?Q?2KmA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd35d680-fedb-4046-477b-08d99ed68c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 14:30:56.2304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyyo3ca7RPrXZCMnzyxINbwDbcnm6kSw6hWMStvSVPnv4XAfMW9/A2o1zP1lFDQBmTpxZ/EBU5pdn2C6prKMKPINiRS0Tv+WOFnUeoJ3CiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2504
X-Proofpoint-GUID: 7uo2-bt34Dt942G88vQX8Z1zhVZTbd_9
X-Proofpoint-ORIG-GUID: 7uo2-bt34Dt942G88vQX8Z1zhVZTbd_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_04,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111030082
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Example:
In the setup that we tested the driver, we had a clock chip that was hardwa=
re-routed only to the positive side of the local oscillator input (LOP pin)=
 from admv1013.

Therefore, I think keeping the property in the DT might be useful.

Regards,
--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Miclaus, Antoniu
> Sent: Wednesday, November 3, 2021 10:09 AM
> To: Rob Herring <robh@kernel.org>
> Cc: jic23@kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kernel.o=
rg;
> linux-kernel@vger.kernel.org; Sa, Nuno <Nuno.Sa@analog.com>
> Subject: RE: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
>=20
> Hello Rob,
>=20
> These properties are fixed and available in the datasheet (binary format)=
:
> https://www.analog.com/media/en/technical-documentation/data-
> sheets/ADMV1013.pdf
>=20
> Please see Page 37 of 39, Table 15, QUAD_SE_MODE.
>=20
> Regards,
> --
> Antoniu Micl=E3u=BA
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, November 2, 2021 7:51 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: jic23@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Sa, Nuno <Nuno.Sa@analog.com>
> > Subject: Re: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 d=
oc
> >
> > [External]
> >
> > On Mon, Nov 01, 2021 at 12:04:20PM +0200, Antoniu Miclaus wrote:
> > > Add device tree bindings for the ADMV1013 Upconverter.
> > >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > >  .../bindings/iio/frequency/adi,admv1013.yaml  | 119
> > ++++++++++++++++++
> > >  1 file changed, 119 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > >
> > > diff --git
> > a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > > new file mode 100644
> > > index 000000000000..47993253a586
> > > --- /dev/null
> > > +++
> > b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > > @@ -0,0 +1,119 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:
> >
> https://urldefense.com/v3/__http://devicetree.org/schemas/iio/frequency
> >
> /adi,admv1013.yaml*__;Iw!!A3Ni8CS0y2Y!uTDPalOgj6YS_vZ6bsDSbA_Qna6Q
> > OwMpoRxzo6nn06i5TNuGWZEk9PvtbC6SKQGXrugy$
> > > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-
> >
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!uTDPalOgj6YS_vZ6bsDSbA_Qna6Q
> > OwMpoRxzo6nn06i5TNuGWZEk9PvtbC6SKYugV1fM$
> > > +
> > > +title: ADMV1013 Microwave Upconverter
> > > +
> > > +maintainers:
> > > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > +
> > > +description: |
> > > +   Wideband, microwave upconverter optimized for point to point
> > microwave
> > > +   radio designs operating in the 24 GHz to 44 GHz frequency range.
> > > +
> > > +   https://www.analog.com/en/products/admv1013.html
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,admv1013
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 1000000
> > > +
> > > +  clocks:
> > > +    description:
> > > +      Definition of the external clock.
> > > +    minItems: 1
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: lo_in
> > > +
> > > +  clock-output-names:
> > > +    maxItems: 1
> > > +
> > > +  vcm-supply:
> > > +    description:
> > > +      Analog voltage regulator.
> > > +
> > > +  adi,vga-powerdown:
> > > +    description:
> > > +      Power Down the Voltage Gain Amplifier Circuit available at
> > > +      BG_RBIAS2 pin.
> > > +    type: boolean
> > > +
> > > +  adi,mixer-powerdown:
> > > +    description:
> > > +      Power Down the Mixer Circuit. Enable to put the block in
> > > +      a power down state.
> > > +    type: boolean
> > > +
> > > +  adi,quad-powerdown:
> > > +    description:
> > > +      Power Down the Quadrupler. Enable to put the block in
> > > +      a power down state.
> > > +    type: boolean
> > > +
> > > +  adi,bg-powerdown:
> > > +    description:
> > > +      Power Down the Transmitter Band Gap. Enable to put the part in
> > > +      a power down state.
> > > +    type: boolean
> > > +
> > > +  adi,mixer-if-enable:
> > > +    description:
> > > +      Enable the Intermediate Frequency Mode. Either IF Mode or I/Q
> Mode
> > > +      can be enabled at a time.
> > > +    type: boolean
> > > +
> > > +  adi,detector-enable:
> > > +    description:
> > > +      Enable the Envelope Detector available at output pins VENV_P a=
nd
> > > +      VENV_N. Disable to reduce power consumption.
> > > +    type: boolean
> > > +
> > > +  adi,quad-se-mode:
> > > +    description:
> > > +      Switch the LO path from differential to single-ended operation=
.
> > > +      Set value 6 for Single-Ended Mode, Negative Side Disabled.
> > > +      Set value 9 for Single-Ended Mode, Positive Side Disabled.
> > > +      Set value 12 for Differential Mode.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [6, 9, 12]
> >
> > All these vendor properties are fixed based on the board design or
> > something a user may want to change? The latter does not belong in DT.
> >
> > Rob
