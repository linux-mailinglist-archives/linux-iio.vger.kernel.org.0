Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B7453489
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 15:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbhKPOqW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 09:46:22 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:14420 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237528AbhKPOqP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 09:46:15 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG9J6OV017378;
        Tue, 16 Nov 2021 09:43:16 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3cbv2rcugm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 09:43:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFxyXOPQYu2X2oaoPtL4yVrP4Z7YZG0aL4eOToQv9u5uVy2pvlJPN71oLxovsOFJgJvcjWSJbrSW0HQGUp6nyO1Ed0eqIqSN1cNxIRu22LquwX6sjrF3TyJX7Wa4eZzCrHknfariM1onUnb+m5hUWlAlFepd6dpgLqRTuRCvwpIQ0CnINlNc+eM6gbhW8oaGnzVgH3RByQJtUDA6hxcFRK+XIGEh1FuIW5hLOqvpHi01K8VQa0/KLFU//ofE0OLt9ZEKSbCrdMjocLATtz8VoAnGsINKCBsFbHDuYebU/6DGEsy7HWpHmytYBDkRdjAuongQUJ+apx+459HPIMUh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13Add9PHKaLBHBzBbA3E9cE0ZByXBLDB5Eiue84CQDY=;
 b=P0+VpKPPlXP9eCsPw6n8eEHHG+jzoskRgdaHSd5bN6puyNDDxFouLaEyGIKify2v2x3+TNgf+1E8iLZ1xyCBmzeA+SMtJWL9O1VxctrCehc/vEUSZU3ADHZK/KfjbM1lBFS7v8B38FexJgQTzkrsKub3d9Y4fRpCxit2X12g+qEQaQEgN5uatS93m39404mhSioyPADIITF6NTcaijtwSaH9gDykwGygQTqusQOFnWCkMfbLKh+p8egUa/n1xz6/Poaj5rUvQrkMPRStl4RIeGK85mludCAv6gS0u/OfxjIZbHBuneg2AOOppmO7dn1zLyRsElh7jyJGnIuvPJg6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13Add9PHKaLBHBzBbA3E9cE0ZByXBLDB5Eiue84CQDY=;
 b=FOVs9e8nFYELKSoVQ2cO9qAq5N/jwS0U4vmNxodR3Yo/UR1ymKX8tlcVj3m8l/Yr/txRFYGnygqe2ZFWbgKcTXrCT7cFLch8nvsqIm/0vhNw60Ip/h5I12Y/iFXMTdeyX1YXXpurdrjny1dqHEI2rSMQIqJBqZn2xyXe4L3ehiU=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY1PR03MB2139.namprd03.prod.outlook.com (2603:10b6:600:1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 14:43:14 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::70e8:1ee0:f071:3de5]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::70e8:1ee0:f071:3de5%5]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 14:43:14 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
Thread-Topic: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
Thread-Index: AQHX1WXROa8gBfces0OdmTnnZfx+/6wAL4SAgAYQw/A=
Date:   Tue, 16 Nov 2021 14:43:14 +0000
Message-ID: <CY4PR03MB339956D5EAA5D20C9D6579419B999@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
        <20211109123127.96399-4-antoniu.miclaus@analog.com>
 <20211112174601.3c1f6b4b@jic23-huawei>
In-Reply-To: <20211112174601.3c1f6b4b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy04NTI0ZDc5MS00NmViLTExZWMtYWJlZi?=
 =?iso-8859-2?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcODUyNGQ3OTItNDZlYi0xMWVjLWFi?=
 =?iso-8859-2?Q?ZWYtZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSI0NjY1IiB0PSIxMzI4MT?=
 =?iso-8859-2?Q?U0NzM5MTk2MTg3MzciIGg9Im5UbU5CQUZHdDlKZDdxVTZEditGbURqR0kz?=
 =?iso-8859-2?Q?WT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBQ3hicWRIK05yWEFZRGpuR0xpbzMwL2dPT2NZdUtqZlQ4?=
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
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b440263-6bd6-4075-b1fb-08d9a90f6b75
x-ms-traffictypediagnostic: CY1PR03MB2139:
x-microsoft-antispam-prvs: <CY1PR03MB213976D2DDFFB7F16BE9D0E49B999@CY1PR03MB2139.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6IOUAmt5L/FgYSV3VdCGvj8iik0nENgeGPt0Xq0ND/y4mOOKSjPCc30140m3asragk+l/YUjDH5kNrIG3JdQ4+iSQKO6FRFScPANcvjxMpXZhA7L/CPCToEWgtxA+UNQjd5Y637XY97m8jwqX42pCGE8e+EeIB2tVy89gqELbmucR6fEbmiqfs9+iGC0Z7jFJVdLXmvd0zVcace4E+QKGscfWTv1V/vNf5B4D4B+ycwpOFyFPPYhCjNWdOtZwmbTc4wN/d9KbA3UMdx2tUVnZuJEe4i7hk2Sq9Fg3Xx9aseNDXZilxpSWeg5kwlrb/nS7LhBeAiFQMJhVhRNH+q5usM5tqRmwn4zLyuZ2GsyvHOQWEx5+lDc+gHTRHHC9Ar+B75RpZBuQ1QATDB6PcUbmvwYyptM3lIswpG+jRJKnqWE1izn7yPln7tZzZeHygof66RzPhmwOVglZN/uvFiEI6M1IekvbEiyP7Uucsk/VIzgZ0DcuhqKuOSLhac3jgLqH5aw/JwdNYtA1eM7+PrpTSZO5MZUspV3Ppzq8hX0kuL6Dyf7XMyCgr6+QGX4hSdSniRMBsAAT2Ws+5o8sOqY4ahhBuE0KyimawNDPSw+SbZ0DYv3wam0KdCyTGFjMuCpiAwi/YNA4Sp1jXFAQ7ZyEIvH83H22aWvUvIRhlozTCjP44qpM4unl5yDxsYgEKIyTbJcw4a5u8C2CfEcJpoVXG4dAwIbPRIfUzhEgwE98nn78F4bsJejfUjTvs4A+40FoFKA3wL9FGHrWjtOKGnETZimy86ojdqOFZvJ6fzzo0WjtzGcTWcoFCAcbxDVCESVMqphVlL3re/f4RBdeqznA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(7696005)(52536014)(86362001)(26005)(5660300002)(66946007)(2906002)(66446008)(54906003)(64756008)(508600001)(186003)(76116006)(66476007)(8936002)(66556008)(966005)(71200400001)(83380400001)(4326008)(33656002)(53546011)(9686003)(55016002)(8676002)(6506007)(316002)(122000001)(38100700002)(66574015)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?hZnAywYx3sWKs/lDpe3bqXdy/4EHjvQTMv877DOPv15lO2UBMQAo+s+jae?=
 =?iso-8859-2?Q?zbWGG6nE9Y8zSpsYl058s9tnscKBMemUVjVjpjfNVu8bOTFqbX0sEazjcr?=
 =?iso-8859-2?Q?ic1ExIhJK3aYhfSAouqij/w966TamlFY2hjiVrRuETNbUQzMTdQQSbbGXG?=
 =?iso-8859-2?Q?wZXTnDO96XpbBOQqW4pUOR9MG4ut3FL1fD0QjOVZ/636iEroMcOVgyJp7L?=
 =?iso-8859-2?Q?nFLkWEFqjSvTyxliPu+Q+vZV0RccRI2c1ui5B8ZE6wBSz/FN1+SIEaKlhA?=
 =?iso-8859-2?Q?Zlx47Dqbt46gXtiBmDfRUFDY1l4wF7rrUIzJKFqFAblg8wwSgzBTDu8Pn+?=
 =?iso-8859-2?Q?Q0z2QLy27N1+LTRcYRueSRxKSgBc5lNaEqcW1cvCDwUhV/vhTegRd1y/wo?=
 =?iso-8859-2?Q?XSC7RCrHxVyc11LulI+E3E9t8WecUvC51FZiwZS5RtBnYPcRWmmvfqD00X?=
 =?iso-8859-2?Q?0H7+PM/gqcCD2AYiVHRTV27/yehpYYLv02yPu2xIFZsItQ0PzRTo0Bc/ZV?=
 =?iso-8859-2?Q?v0BNasIVmFS6NQhKVnp64K41j/tF4sqC08/zcFoPJNQWZIzCqOUoxc/pzw?=
 =?iso-8859-2?Q?yumB0ayv1Tgscd8ZM/G5L+xVtwx1Tl32v9guFpXxJgoolb2dAJkCaUGLkx?=
 =?iso-8859-2?Q?VJRWYIQcQM5Wj0PaVFkwUlllPpxUTUGVRRyTq8w7LrjjkQzAHzGZrnwQaH?=
 =?iso-8859-2?Q?MYBvJGv8f2V9C7xZcAqHWmY87bDsJhnV6mFGtGXQQ61r23itMzQMU8MUFK?=
 =?iso-8859-2?Q?+JCynci0j9YExbPoiPbgVY3yVA8AxgAhAeFO2vMDqVU+LjG7xwnLHGjL4z?=
 =?iso-8859-2?Q?zeHX9Ql2T7C6Q/aSok2Tnj3ofn/46hEzEmQGXv4sFct3xjJXdqexaUEOVV?=
 =?iso-8859-2?Q?5AwvGjAulZK7rDez+CzGpjuopQzqvoC3o0BUElZyGsvtK/ijNQETSc7BJD?=
 =?iso-8859-2?Q?QouGvwquSjJyiv4Qxhs3Y7/FBcC753FfUMoD/hIQvWKnpB7gsTdtm3yXFe?=
 =?iso-8859-2?Q?l+C8XZAiZLWmvpogc9AHVG0jzI+Htu7STZeGDpQtVOIKxbnrRrN4cu/tp5?=
 =?iso-8859-2?Q?vFwtKfpIghZ3G9F2bSVsr8P7Yft1fM0G2LdWDJRkFslREY+aeKSmpExO+l?=
 =?iso-8859-2?Q?MA4U9V2PPCH4WafMEj6+kkzfPFT2X97xjjutCEvbdxZ04cQMmg05Lo+JGo?=
 =?iso-8859-2?Q?G9NoxU2EHvWMpSL9VIoaqpVbgqREYAdFFqdcC/+fTP2j5xgBLD7ikAFWVT?=
 =?iso-8859-2?Q?3NJX8a0QVL3WEax86GiOAb2D5hThTvpUlQn66/vMeiQQv1boNgdNKbKBeq?=
 =?iso-8859-2?Q?evX9XcUsBh+eOI1Y6LVgcp4hiShREQhQhJYu4vy7ub/hsWE5W0fefuwaiZ?=
 =?iso-8859-2?Q?XvQSgvcFKENClWEOi7Mq2mdBha3PrVE6h5vdIlJwSj/jCN6S+DiOJSfnIX?=
 =?iso-8859-2?Q?cg7YXPJPkVdjpZAfroY7JgQ1u2+M0fxq43HU+LgmVeGSPD08RyeiFsZsYq?=
 =?iso-8859-2?Q?68WAF95CrIpxZC03zcxSsQiotu61FZawFwh1uB3Af5epKouKDkUfAOrYAZ?=
 =?iso-8859-2?Q?iSs/IV/54uMo+b7T4SN6tsRtE81hfyn89wbDoeGbKN3ZJnoF/RQwh24Ukv?=
 =?iso-8859-2?Q?NFK34dr9gzgGWLwUOtN+K2NERHQ81oFXJKPVNLyXrEuGf6eHwq8VZQ7QSi?=
 =?iso-8859-2?Q?5j7ZUzwIH0trgkPu405gcPghLIpuZir9unIMSD8C6FHs2tVvPFakbMK6S2?=
 =?iso-8859-2?Q?Poog=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b440263-6bd6-4075-b1fb-08d9a90f6b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 14:43:14.1055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pZK4/bOOxr6QM9AveBQFEn6+EVhNxqfZHiZ4oHkQhlxnYS7kX3UyC6DzEV7uK9EyR6nstDBlAp9XwU6weKvuUxOZfrU1/uIUCQQUwOQLuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2139
X-Proofpoint-GUID: CC-RWWJHY8S-x0d5f0g1_hHC0rTma3oO
X-Proofpoint-ORIG-GUID: CC-RWWJHY8S-x0d5f0g1_hHC0rTma3oO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-16_02,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160072
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Friday, November 12, 2021 7:46 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: robh+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/4] dt-bindings:iio:filter: add admv8818 doc
>=20
> [External]
>=20
> On Tue, 9 Nov 2021 14:31:26 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add device tree bindings for the ADMV8818 Filter.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  .../bindings/iio/filter/adi,admv8818.yaml     | 78 +++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> >
> > diff --git
> a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > new file mode 100644
> > index 000000000000..d581e236dbdc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > @@ -0,0 +1,78 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> https://urldefense.com/v3/__http://devicetree.org/schemas/iio/filter/adi,=
a
> dmv8818.yaml*__;Iw!!A3Ni8CS0y2Y!qkKokhmcgS0YEIy3uC6OfOOF7Bq3yE_r
> Ny91yIkDRTXFe54x-cHq_BtsyzDOedLohB5D$
> > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!qkKokhmcgS0YEIy3uC6OfOOF7Bq3
> yE_rNy91yIkDRTXFe54x-cHq_BtsyzDOeYdHtx0a$
> > +
> > +title: ADMV8818 Digitally Tunable, High-Pass and Low-Pass Filter
> > +
> > +maintainers:
> > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +
> > +description: |
> > +    Fully monolithic microwave integrated circuit (MMIC) that
> > +    features a digitally selectable frequency of operation.
> > +    The device features four independently controlled high-pass
> > +    filters (HPFs) and four independently controlled low-pass filters
> > +    (LPFs) that span the 2 GHz to 18 GHz frequency range.
> > +
> > +    https://www.analog.com/en/products/admv8818.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,admv8818
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 10000000
> > +
> > +  clocks:
> > +    description:
> > +      Definition of the external clock.
> > +    minItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: "rf_in"
>=20
> Is this what we'd normally think of as a clock signal?  I'd not expect
> a nice squarewave on that pin for example so this seems an odd way to
> define it.
>=20
The only actual use of this part, until now, was to filter the output of th=
e following part:
https://www.analog.com/en/products/adf5610.html
This is the reason of using the clock framework in the driver. Moreover, th=
e clock input is
optional inside the driver.
> > +
> > +  clock-output-names:
> > +    maxItems: 1
> > +
> > +  adi,bw-hz:
> > +    description:
> > +      Allows the user to increase the Bandpass Filter (BPF) bandwidth
> > +      in Hz. Normally when invoked by the clk notifier, the driver
> > +      sets the HPF cutoff close below the frequency and the LPF cutoff
> > +      close above the frequency, and thus creating a BPF.
>=20
> I don't understand this item at all.  Why do we need a control to
> basically change how the other filter parameters are expressed?
>=20

Indeed, this property was requested by the users of the application in whic=
h this part was involved.
Same goes for the filter modes and the bandwidth in the ABI documentation.

If you think these attributes/properties are way too custom, I can drop the=
m.

Let me know your thoughts.
> > +    $ref: /schemas/types.yaml#/definitions/uint64
> > +
> > +  '#clock-cells':
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      admv8818@0 {
> > +        compatible =3D "adi,admv8818";
> > +        reg =3D <0>;
> > +        spi-max-frequency =3D <10000000>;
> > +        clocks =3D <&admv8818_rfin>;
> > +        clock-names =3D "rf_in";
> > +        adi,bw-hz =3D /bits/ 64 <600000000>;
> > +      };
> > +    };
> > +...
> > +

