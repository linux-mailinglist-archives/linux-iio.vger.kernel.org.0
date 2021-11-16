Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD97F45348B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 15:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbhKPOq3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 09:46:29 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:17662 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237517AbhKPOqQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 09:46:16 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG9FuAd016478;
        Tue, 16 Nov 2021 09:43:18 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3cbv2rcugr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 09:43:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR9ewHiUHv8OnPNilfjIbSIBnQvoiluS97qP1RPo0X3gk99cWmuvfUWECFeeTemHI0R6HmIdYafpCVnOMarWhTFiKCGuuaR7gzdZXRkl3cGtIYIwXUK+iN+b74dKsqgE3f2jms3elfWpG2bJMzDEgpZDd3jRyRmxYt9Jz+poHpbJH+sy6+uy/WK/tT3715heqdqzX4pdHmegy7EZDZKmqQWyVGaxVDGtANQiRZaEXA/T2nFBOi9fSzGFP891y5TxB2QtVtt4sb+MwHtC1BlWN/dnTFmNE4FZ6tOCu4GGdNTsSUJr0+0fxn0fE+vW4mzB+8OxR5T4sIo17/RbsEeS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8EH71NoIAsNt/WsREsTTZPcKokuMFUv97sNScTrma4=;
 b=BXLQ9or/Gy3S5bT5CQXpGIq0vFR3MbYWZ9T+tyfooS5+Q5CG4HCQ2YMXo3zWCY+d/Gprl/Br1Zub1/6kTUVbU5BZ+I14k8MEJXTwGUPfu3Xzh1DqBIP4LCoLnQWjk7zsrxd3PuH/vEzM93wFMuBSrvM8WNEtlgpYPnFAxDUIpUEbshu7Ulm9gyCX1s7OCJ/3Xhdmkor+HkbvHKRwRN5emRPb7VBuIK7uD4PFX4rNFn26qRQatbdDf+zrBG3ufHzEzszRRzUtyyw5R4/mhyPeJupwEXNKwdSNZIO4T9ScFsdXBhnFOGkw3lFz707lDssRjbyTsnWfXNGksdriYN1I/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8EH71NoIAsNt/WsREsTTZPcKokuMFUv97sNScTrma4=;
 b=Pr/dLV19LCPLUMACSmevpgZO4xrqjIAAgKoLg+d9j79E7MYjD+MjPCqUvu1Pe8hd/Ypwl40Fpvrxn8n0ovZet5XIIbYzCTHFNyjpX2M8zEy1QHrQBo/eCVj21+wtKmTWnC1BCRBCoXOOAWnEyORvs2HsAzN+PeaUuJAumKHLi/U=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY1PR03MB2139.namprd03.prod.outlook.com (2603:10b6:600:1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 14:43:16 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::70e8:1ee0:f071:3de5]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::70e8:1ee0:f071:3de5%5]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 14:43:16 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] iio:filter:admv8818: Add sysfs ABI documentation
Thread-Topic: [PATCH 4/4] iio:filter:admv8818: Add sysfs ABI documentation
Thread-Index: AQHX1WXUh8uqCQuOgE+nA/Mnv7J7+KwAMmyAgAYQViA=
Date:   Tue, 16 Nov 2021 14:43:16 +0000
Message-ID: <CY4PR03MB3399908F8ED22DF23C89A09E9B999@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
        <20211109123127.96399-5-antoniu.miclaus@analog.com>
 <20211112175625.4a9f393d@jic23-huawei>
In-Reply-To: <20211112175625.4a9f393d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy04NTI0ZDc5Ni00NmViLTExZWMtYWJlZi?=
 =?iso-8859-2?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcODUyNGQ3OTctNDZlYi0xMWVjLWFi?=
 =?iso-8859-2?Q?ZWYtZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSI2MDA1IiB0PSIxMzI4MT?=
 =?iso-8859-2?Q?U0NzM5MzYzOTM5NzEiIGg9InBpcGdMZzBKUjdWa25lOGZnQkh2R21qUFEx?=
 =?iso-8859-2?Q?ST0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBRHpacWRJK05yWEFSWSttZzN2RktJRUZqNmFEZThVb2dR?=
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
x-ms-office365-filtering-correlation-id: 7f8c5895-f164-4c06-eeda-08d9a90f6cd9
x-ms-traffictypediagnostic: CY1PR03MB2139:
x-microsoft-antispam-prvs: <CY1PR03MB2139220AC0B3D20492CFE3A99B999@CY1PR03MB2139.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eiCMtVxum8e1zI4yWGPzv6G/vHEFCMq/AA1gyHFitOiXJJ3y55pPM7vUDrJwXHmGUYAxiutxX/PGQvpqjkAjBrsjbEGdxlxxTJtXm1u4xAhtdyGCtwCHazIdPLpKrJrx1mkya354S2sJpr+eiYgKv9IAhTBFrEkGeXwChcofJuwOAUxUmmKQlievLKMIi7ZpwmIJl9nIWXOkfBUsWi0kBHTt69A0Otcgq5WuuIPtuK3x4XOeya6x49DwfXF67fmMcmM+MctbXne4xx++qu+MZOGHGZUzsibV/DLUPXTMVUD8Bza3cqoQMlIKVMTuj0oSRCNSLobbCgDEUBBi2KmpV4ktRYc9R3z4oam0dJ/U3etmh+MoijH/6kFN+ReDWIWqn4GIiTxdCMRhmbFsl4wJsa+jdOAROtYaKYR4Dn9DelF4mfXV6cTyu7jTaopCizBepbjBQ2HYT6zX29qRmSTgVHaDWp0HwpYjE1dH2m+OLAZFTfnYE6bWSVt3QJ+kyfm5xZFb3swypHR+2XSXyCkm8Zy+Fv2/wfZ4YTMeA6ZXYCTQQUBShgS7auxmDLSGRWVluvunw9ytNzP1ZTTtiIhl6fOgkenZAwMIuzDBhqicrcaIkqzfXm4KXpcn+xWG5X0tjLKymG8OIgohzNy9veToVHo4shAlG2z22qyx+MZ8tDCoHd84PUNbhTP3gHZsWu++HWkx7oF7jqTQYr/+ESsehA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(7696005)(52536014)(86362001)(26005)(5660300002)(66946007)(2906002)(66446008)(54906003)(64756008)(508600001)(186003)(76116006)(66476007)(8936002)(66556008)(71200400001)(83380400001)(4326008)(33656002)(53546011)(9686003)(55016002)(8676002)(6506007)(316002)(122000001)(38100700002)(66574015)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?609CtTgmF/dN0REJ49G1YfFPZl8TcspRBKP0hVCkOjknX/K5g6x9j+aw99?=
 =?iso-8859-2?Q?9hWUBZMhNy78NMMoE5v5dCp7vgnYh+nj8wxtsZvQ86SVuEuwBiGL/DxkKc?=
 =?iso-8859-2?Q?v2DyGSlMdZfuPpd8rooUHyLiKUoJMgyZcTGwJafDoFJ92bgnZ66xDqEPWC?=
 =?iso-8859-2?Q?iASySTVxgbq7H02Dpo0DBtEbdOWyGSS5UE6ZFqjbDW0T+Ra215ehxRBpdp?=
 =?iso-8859-2?Q?Vxyhb9N0Wqp3If6rpp438rOOYjfzsYUgsMVTxX7dyJlQghwKyQsZ4JoeKB?=
 =?iso-8859-2?Q?Vy8N2l8joaHHWW/brkWvmCC+qUgy0jPJviPHcBGBRT3qfR3DKs8sTg9i7Z?=
 =?iso-8859-2?Q?WIjj5wFumQwHBuWfHj4/58B/yK8rUJVBKwdvWxMqr1leeXu9k8LqLEiJ7V?=
 =?iso-8859-2?Q?lPHY6iSlDDjO6WAhc3Fi/2Nx+sLPmZvsCu613e5DhLixYCVnDyQZmJGL7f?=
 =?iso-8859-2?Q?OwLfLRntZ4Eem/y0dpUjJNeZ6GMr7oFKiZIcD0Ws89YLA5TfyXct9ISZKy?=
 =?iso-8859-2?Q?h+BYnnzjwpPsaexiZSYB4IXDKNqKCivwJGqNXuu5km+bSNBPsb6JtjnnIR?=
 =?iso-8859-2?Q?JiuwYfkgfeZ+ke5SljW5j9Gl4dfHScBoOG0sJ2DdZMsZFQ26W4Ov9BDmmv?=
 =?iso-8859-2?Q?UvEnoVJOzj+iHngeHc5RJMNEoeXLWAuV6vh2ceFP+ttiXKZ36NR5CtZBOh?=
 =?iso-8859-2?Q?QOWMVa+uyEFqr76qrKvDE5W60oRb/Li6hM9Rs4bmyxguIOHuFQckisaKrC?=
 =?iso-8859-2?Q?qx4Y/qCf8rSqS6aw69HHruSyqkW7MGkqzz5KCdRRo5HnL037Pt+3xU8vR5?=
 =?iso-8859-2?Q?UwbZVuhBNfVJKXNQBiPrzqRj0GrMoEqFZciBAgL2jBazooYAKvs0+JTuHp?=
 =?iso-8859-2?Q?aV+ICg3VVYPkDXWWurhsbIEmWzQuZTYocVuN2Is0aWiC4hLI40++U57oSK?=
 =?iso-8859-2?Q?W+BUs5RNDwzPwarskS7KAfKLHY9fsHvAUhJ6+gsB7bW64oKT1NCxsbrONO?=
 =?iso-8859-2?Q?tKcawN5s9p79PJM7XzS1K6E4xj0H7iGYbT0KO1JMlb+AIiVVbRpsk8M8Ly?=
 =?iso-8859-2?Q?Vov05MTb5vk3s+qPu6It/rFt2r2ejCRQzaXFXxgyhuHq8UhM8XaOG2+Lam?=
 =?iso-8859-2?Q?DIEehcLdBNHHNb1YXMca68MMAUnrKpRpxfz7NrDm4l3zaoa+ftnQwf2YLL?=
 =?iso-8859-2?Q?KDMaBNgrrwP90j6Lbtb/5OGvAf/in/azuCIq41NEbPmJ3A7503DK88Kepp?=
 =?iso-8859-2?Q?iJOHjL74M7DpSbqYlFlAyw7G+gvtEvXIvj8eIR/lhY0rZZqhiuPgZ5+/MW?=
 =?iso-8859-2?Q?KjQuxDwt8NOCVFLVEEjqtqHJS6dvYNCwbaKk1fBVPUbW49l5hxzBVZgtaY?=
 =?iso-8859-2?Q?ZXRuSt3gLEnw//1pPQtgwI23GXdY8G5e3fh7VQ/54D4CoxrYgm7b7LyfvM?=
 =?iso-8859-2?Q?A8dV6UB4pnv/4lfzsmRGb8EdWl6oWbQ2eHz1V7exXBtKEUNlhqD8bzr4VJ?=
 =?iso-8859-2?Q?SP+bBn0dKbzPbkc/WqmAT2sWbGNVEOIIFSC9oTALbxzg5s80OaSkpQvGiF?=
 =?iso-8859-2?Q?uctyRU12W1Nxhbk3/6N/zxgh5u8K1M566poOjBGkoBE9iFcdP8pr8r0xO1?=
 =?iso-8859-2?Q?FUTK7nzJ7UchWNBdWKx6zOtBMBUl9aj035s8pgkcj0upsmLaghqGv32YGK?=
 =?iso-8859-2?Q?JmjrNgC7h7BfjKF00AmS+Y6Kq+3gEaKoTfxMfV+puGzyr1yZcx9y1Uz0xx?=
 =?iso-8859-2?Q?kP+g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8c5895-f164-4c06-eeda-08d9a90f6cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 14:43:16.4721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMHwgcfJkHgf3lbYKfCZgDzH21LHzZbwp/LvVwaaIx4IZ6RE2LXTXxjTdKwerQ1wT/8eXyidNYlfVMPVGZjzg9Sd3PZC5Z32oSoVoIp38vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2139
X-Proofpoint-GUID: gZVKHi3NGzVL6kTaA43_T1Hu3n21zc81
X-Proofpoint-ORIG-GUID: gZVKHi3NGzVL6kTaA43_T1Hu3n21zc81
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
> Sent: Friday, November 12, 2021 7:56 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: robh+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 4/4] iio:filter:admv8818: Add sysfs ABI documentation
>=20
> [External]
>=20
> On Tue, 9 Nov 2021 14:31:27 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add initial ABI documentation for admv8818 filter sysfs interfaces.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  .../ABI/testing/sysfs-bus-iio-filter-admv8818 | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-
> admv8818
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> > new file mode 100644
> > index 000000000000..7fa5b0819055
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> > @@ -0,0 +1,60 @@
> > +What:
> 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_high_pass_3
> db_frequency
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The cut-off frequency of the ADMV8818 high pass filter. The
> value is scaled using
> > +		the `out_altvoltageY_scale` attribute so that GHz frequencies
> are valid inputs,
> > +		The accepted range of values for the frequencies is between
> 1.75GHz and 19.9GHz.
> > +
> > +		The default value for the scale is 1000000, therefore MHz
> frequency values are
> > +		passed as input.
>=20
> I don't think this ABI really works unfortunately.  What we are talking h=
ere is
> a bunch of
> selectable filters and one high pass + one low pass filter max can be ena=
bled
> at a time.
>=20
> So two options, we either have simply a single
> out_altvoltage_filter_low_pass_3db_frequency
> out_altvoltage_filter_high_pass_3db_frequency
> Probably both with index 0 and index free channels are a silly idea given=
 it's
> fine to just have
> one with index 0.
>=20
> or if there is sufficient reason to setup a selectable set of options the=
n
> we could look at indexed filters and a _symbol type selection which may
> seem
> odd but generalises fairly well from Phase Shift Keying type symbol stuff=
 we
> have had before (though still in staging because no one has cleaned the
> drivers
> up yet).
>=20
>=20
> > +
> > +What:
> 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_low_pass_3
> db_frequency
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The cut-off frequency of the ADMV8818 low pass filter. The
> value is scaled using
> > +		the `out_altvoltageY_scale` attribute so that GHz frequencies
> are valid inputs,
> > +		The accepted range of values for the frequencies is between
> 2.05GHz and 18.85GHz.
> > +
> > +		The default value for the scale is 1000000, therefore MHz
> frequency values are
> > +		passed as input.
> > +
> > +What:
> 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Scale high pass and lowpass filter frequency values to Hz.
> > +
> > +What:
> 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_mode_available
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Reading this returns the valid values that can be written to
> the
> > +		on_altvoltage0_mode attribute:
> > +
> > +		- auto -> enable/register the clock rate notifier
>=20
> Hmm I'm wondering about the usecases of this.
>=20
> If this is being used with a clk device, then I think only the notifier o=
ption
> makes much
> sense.  If it's not a clk that linux is aware of then manual makes more s=
ense.
>=20
> > +		- manual -> disable/unregister the clock rate notifier
> > +		- bypass -> bypass LPF/HPF and disable/unregister the clock
> rate notifier
>=20
> This should be separate enable for the two filters though I think we've u=
se
> the value 0
> to mean this in the past.  The bypasses look to be per filter anyway, so =
a
> single
> mode is insufficiently flexible.
>=20
> In the vast majority of cases, mode attributes are not used because they =
are
> always device
> specific and hence generic code has no idea what to do with them.
>=20

As I mentioned also in the dt-bindings comments, these attributes were adde=
d =20
because they were requested by the users of the application in which this p=
art
was involved.

If you think these attributes/properties are way too custom, I can drop the=
m.

Same goes for the bandwidth attribute.

> > +
> > +What:
> 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_mode
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		This attribute configures the filter mode.
> > +		Reading returns the actual mode.
> > +
> > +What:
> 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_band_pass_
> bandwidth_3db_frequency
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Store the band pass bandwidth frequency value applied.
> > +		Reading returns the bandwidth frequency scaled.
>=20
> The device has no concept of bandpass that I can find so why are we
> introducing it?
> Let the user set the two filters to achieve this result.  Userspace can d=
o the
> maths for us :)
>=20
> > +
> > +
> > +What:
> 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_band_pass_
> center_frequency
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Store the band pass center frequency value applied.
> > +		Reading returns the center frequency scaled.

