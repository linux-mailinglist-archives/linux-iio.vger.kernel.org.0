Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3304258CF
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbhJGRGW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 13:06:22 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:48044 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243001AbhJGRGV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2021 13:06:21 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197EWO9t000941;
        Thu, 7 Oct 2021 13:04:10 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 3bhrack8yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 13:04:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOErsNoi4x2h/+jHNswsVK+67533LBqOKie5QTuN9Z29LSCqt3x+c6fm7KWhu85fFcQosMikUcQ5br74AwMFMj+VG6w/6v9Yw8GVxtZOIl/FHcuDFh419+lYKwhDFrhtGD8lzOYf7PNzfPng87dkAqY1bO02FrQ1anTxSeW15M999+aDzDtHS5dsqlQRqmnapbFs6GXEs9XLJFt7AHMsB2bTPZ5J2L4Vqot2QZfRskNweRNVRWpwKbydPRNL7aevoZy+rXPrZcZ3T40pyFEIuM1r06C+idou83UD0yYKLlOiqcNvnJjdJYCnpiChK8/rtXels98zdpCrIDcUKVvnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO4bGQHynWTKmWd8Tn3toVE983Mmiv7FU4TaMIAJOVs=;
 b=Gbp67Y85+bUi9ghIGoCh7RZG9gH0WVzD6lIlQoaPlUXPNpvpTKfhOHcXRZ3a2T0aBK1WB633W//9v+wAEb/Nv8AJsjFsG5ch9+wg29HiMLaZ/SRhM96u0cj05aCalgm0vK6nf++YUE6mqgsNw3AE85D6k/MWzIJbMlZL/m1X4nfG+QtQS5Ar1FYce3Mg6e1AqxH2vtGC1jNEkCOsSyDPOBUpvGuMwcEFAA0kDi0A1QQuSvI6rsEQ2vB9XYZLqk4bxc55MGwM+2ewtMHT+CSWqAqm7bz0u1zBq0cR8EVvJS0jQ9oGi+m5T9skQRwJr5oF+fAyBhrzdQq6JMvnwcGY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO4bGQHynWTKmWd8Tn3toVE983Mmiv7FU4TaMIAJOVs=;
 b=qKE9YxA8ZWLIPmdoxXr4wMIQBwzv0jl+2EWZWy4beSvRYaujQ65mhzekR8y9xxe31S9O46tnr5z2IrsM7zyLcCPrFxqO2VPsi1ImX5c3JACoLusCVgTCGP/U+eOSfsatiHcXYXQOLbDNpSP2sLU7NeWxhyXV55eT0omb6szcmRU=
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com (2603:10b6:a03:2d4::23)
 by BYAPR03MB3719.namprd03.prod.outlook.com (2603:10b6:a02:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Thu, 7 Oct
 2021 17:04:05 +0000
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4]) by SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4%5]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 17:04:05 +0000
From:   "Chindris, Mihail" <Mihail.Chindris@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: RE: [PATCH v6 1/6] iio: Add output buffer support
Thread-Topic: [PATCH v6 1/6] iio: Add output buffer support
Thread-Index: AQHXu1GAuXtaMoqEMkGpFIvXr5kPIKvHs62AgAAC7lCAAA1C4A==
Date:   Thu, 7 Oct 2021 17:04:05 +0000
Message-ID: <SJ0PR03MB57918A7DDAF795C58AA7BF4199B19@SJ0PR03MB5791.namprd03.prod.outlook.com>
References: <20211007080035.2531-1-mihail.chindris@analog.com>
        <20211007080035.2531-2-mihail.chindris@analog.com>
 <20211007170533.5e314199@jic23-huawei>
 <SJ0PR03MB579191849B3BD15610A721AE99B19@SJ0PR03MB5791.namprd03.prod.outlook.com>
In-Reply-To: <SJ0PR03MB579191849B3BD15610A721AE99B19@SJ0PR03MB5791.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWNoaW5kcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy05MjE4Mzg5ZC0yNzkwLTExZWMtODQwMS05OGU3?=
 =?us-ascii?Q?NDNlYTZmNDhcYW1lLXRlc3RcOTIxODM4OWYtMjc5MC0xMWVjLTg0MDEtOThl?=
 =?us-ascii?Q?NzQzZWE2ZjQ4Ym9keS50eHQiIHN6PSIxNjEyMSIgdD0iMTMyNzgwOTk4NDMx?=
 =?us-ascii?Q?ODgyMjY3IiBoPSJJbjllSzdrdlV5Ri9SNWF2OHJ5MG9zSEo1QWc9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NB?=
 =?us-ascii?Q?QUFiUEhSVW5idlhBY0RwSHV5TlMwTnJ3T2tlN0kxTFEyc0RBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?YVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpB?=
 =?us-ascii?Q?RjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFk?=
 =?us-ascii?Q?UUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFE?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9t?=
 =?us-ascii?Q?ZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dba7309-4321-4acb-3e51-08d989b47861
x-ms-traffictypediagnostic: BYAPR03MB3719:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR03MB37193171572C96384E7C957B99B19@BYAPR03MB3719.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fjjRzmtMo+k5HK72VsOZLGCoo40O0GTAexUz7odZsLYDtIcrAcTDj7+1rJAje5FIitju9rH3sMWfV+CM4UMB6QKCRUSz8DiKlUDAzbZsywy0/jS7OF/MuL0rJ+UR4QjyZYc6OR5wVBLVbqW7LXefo/CGc+bG/QKMMA9IKdZpgdXXIbkErgqcTWMIUkfXYVVwp1EZQIQt3g0QZaK97ECLXYuYUQDYAd9/qU+jb9V335f5qLJWNIeILcjY8U3AAZT2xqGY2JclfP7D8ErOoLnx4DcjU+sZEIxzPa4jGhtVujVvxIFhWmTxibv1QvkbAGckiotFdwYbV3AuqF/B1Wudn0Lw8A5Ay3CnIkrlpgcb2uFYkovC9SlDEs1pLwTn0tcP0Kn3kKFJPX6aY7CbptKKRtLjA+QpB5HoT89mrMC+xof97C08dfETfL3lim6b69ojGiIJYT5Y6D6JNvORbVFxw7MLZZJ1/RbMG86dDg9gOE8MW4TZwSM3LSeESxGnOT0377KgUdwncBpU7WthS/RYkJP4LibLjnsbwlXq8cDlbeaNwGLr1LPFAi9Ox9bx4PqJPSwrLS7MQ2fZwQREcmUm0ZxUHt5SXBxe5aQre8bP09ZKNsc8zfSxVKUDmG7U2ZSPzf7Y4BKd3GFb9mmoLRh4CgswpIp5cPwt/lCD1fgRCIgwFObrR/2xpyEOIWLr4ctXZXcamX5ijtd7QPBVOQuynmZeya7+ZzWn62eTrwUhAdHkPPTaPKnxFMPLNkg+ZHAGWARDUc4l/3P+zxC60hVqtDRDlQ/ybZ1dzWSS5HoyZjU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5791.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(9686003)(55016002)(38100700002)(122000001)(30864003)(6916009)(316002)(54906003)(4326008)(71200400001)(7696005)(52536014)(8676002)(66946007)(8936002)(186003)(33656002)(966005)(508600001)(86362001)(83380400001)(53546011)(6506007)(38070700005)(2906002)(2940100002)(66446008)(64756008)(66476007)(66556008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/qpg4yduSUzJIbG45wwrHt6mdFvvU8qP6+jRkIZmwFBQtF6h1gniWtpnOUIN?=
 =?us-ascii?Q?Vr2NiusReyFF1Q3GP6wSgGtlE3sNEZGUpoAl0yf3v9yAWn4IdrnAsYrFEpmy?=
 =?us-ascii?Q?6k44K6KLbSxV7W97xDBB27J/nugeg4kZPoj5o5p4OdNE00Nij0OkW5z/G4ah?=
 =?us-ascii?Q?/KNZegbmeYaAEEOfYlBx1sVT1UyYbRM6oP0Vr262J12MS0uTwfX5o5z4eWGy?=
 =?us-ascii?Q?F3UpiC5sy5q7AmHpiFTODkVoeuT0TRYCbwvla2xgHf+b6eELRPUAhqIkUQ9D?=
 =?us-ascii?Q?n1Yl8NLBFVwyIc66f1QaemH9MzVtb5uj8WQ/jGutT2RqRpHnV7WIwWahplcv?=
 =?us-ascii?Q?pVApm2/6b+3lv0HgmH1wOq0c1zHEh9/NERSYqcHttMLppTLZYznn6327qL5B?=
 =?us-ascii?Q?TNiLviMqNSdy39YFoVfAwMzb5VERe5DGd7XjF2/OTsjYaNhOrW7YeN/+BfoF?=
 =?us-ascii?Q?9ri3ttFYZFv8bu5sOBvv4NYXAqR4JYH7bxhh5ayVrDN0QKQLVpGMVWLU8ms8?=
 =?us-ascii?Q?y864etxFGdVikmG2TAnHC1n9vhGhHYJDLyTzvCLCISezSmf1xnOBCTfFUzzF?=
 =?us-ascii?Q?XORk0QDMTqrqHZzsnz1hGDKgoEOKMeMc8U9UcWK49/61cWLESTJCuAiaUBuE?=
 =?us-ascii?Q?gBlCbZN+LQtW2aHMbmk/VpCBU7w6VQYwe5u2mZfCoq7eOC1PdVzu3EtaLy3U?=
 =?us-ascii?Q?ocMehMYgfoCy5xuD/aVXMKyZ4kepW5yHDQAnz8wx8pHMoKZn7x/ndiIZzBS7?=
 =?us-ascii?Q?7z0p7rBv95KyhpUNJW10a9xF8vrvpWhEQU7RZqizx5oqSgwlX1xVtWSz61NJ?=
 =?us-ascii?Q?KBqv8kE2bpvbAm+KoeJwZp9H4PVF/y2dv5pOK7k+CORBFojVWRFmSBZtezAK?=
 =?us-ascii?Q?oFwijh5TFi/J1f6+XG1FA0AbLaXlu0mTeTXtp0CQeG0oLYEOdgX/6vwl/9zN?=
 =?us-ascii?Q?vuzAtkdNRP81fc9w9PgZ3a9FMqoa/2rL18/y9i+fh50lNo1cLGgHVAfyJIg7?=
 =?us-ascii?Q?Lwy6wdBWJoYanER0RM9Ok6idnDMGe9nfox4AHzrJ/ZSLav4d27UPLKVW1RkZ?=
 =?us-ascii?Q?rjBiFYPas+3A7lpaGIVk6R3JWjsxSlrwZ8mVbiFGpN68IWmnayyOT2Wzs3lU?=
 =?us-ascii?Q?+li3O9Wb1lRuOSYMySwPFUWr0ZVZFvUlAjCUyzQ9hIB0VWiEZInR3GnxCCkY?=
 =?us-ascii?Q?UIFaUQ77LSao/8bUxyWU2F8dN3rkfreluJSnggzEnpTWfi0gGGokxrZ1r3gm?=
 =?us-ascii?Q?Y6GKd7styQv6iD7uuso1QH/2TTliFCmLcyiSmqLranTCsCuXew3Le32o9Psg?=
 =?us-ascii?Q?TiXcVaqsaJSGUKi7eMoqMIdPGC8G7ATxw3+r/zCebI7fn/Mo33iy0KWKcjY/?=
 =?us-ascii?Q?VUjqkQB0OT2/PDOJSUmTgNKwkbvZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5791.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dba7309-4321-4acb-3e51-08d989b47861
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 17:04:05.1345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5fOzmyWeIVtOWc0/o7Mw+l3hG/s/Z5PLZIJdHNmjgSTayHm1XvtKWWlC48hMAkfxYRd7bKt6sTtFe1Csjf+9wwOzFbj1UZOT3T+LCqMpyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3719
X-Proofpoint-GUID: ePlQ4lHz3WWFnDhNw9D48Q8QMnMKeb9q
X-Proofpoint-ORIG-GUID: ePlQ4lHz3WWFnDhNw9D48Q8QMnMKeb9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070110
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Chindris, Mihail
> Sent: Thursday, 7 October 2021 19:25
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Sa, Nuno <Nuno.Sa@analog.com>; Bogdan, Dragos
> <Dragos.Bogdan@analog.com>; alexandru.ardelean@analog.com
> Subject: RE: [PATCH v6 1/6] iio: Add output buffer support
>=20
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Thursday, 7 October 2021 19:06
> > To: Chindris, Mihail <Mihail.Chindris@analog.com>
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > Sa, Nuno <Nuno.Sa@analog.com>; Bogdan, Dragos
> > <Dragos.Bogdan@analog.com>; alexandru.ardelean@analog.com
> > Subject: Re: [PATCH v6 1/6] iio: Add output buffer support
> >
> > On Thu, 7 Oct 2021 08:00:30 +0000
> > Mihail Chindris <mihail.chindris@analog.com> wrote:
> >
> > > Currently IIO only supports buffer mode for capture devices like ADCs=
.
> > > Add support for buffered mode for output devices like DACs.
> > >
> > > The output buffer implementation is analogous to the input buffer
> > > implementation. Instead of using read() to get data from the buffer
> > > write() is used to copy data into the buffer.
> > >
> > > poll() with POLLOUT will wakeup if there is space available.
> > >
> > > Drivers can remove data from a buffer using iio_pop_from_buffer(),
> > > the function can e.g. called from a trigger handler to write the
> > > data to hardware.
> > >
> > > A buffer can only be either a output buffer or an input, but not both=
.
> > > So, for a device that has an ADC and DAC path, this will mean 2 IIO
> > > buffers (one for each direction).
> > >
> > > The direction of the buffer is decided by the new direction field of
> > > the iio_buffer struct and should be set after allocating and before
> > > registering it.
> > >
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> >
> > Hi Mihail,
> >
> > I'm fine with this series now, but one question for this patch on
> > whether we can clarify the author chain.
> >
> > The above might mean one of two things.
> > 1) Lars wrote the code and Alex and yourself just 'handled' the patch o=
n its
> >    way to posting.  If that were the case it should have a From: for
> > Lars
> > 2) All 3 were involved in changes to this patch.  In that case we
> > should have
> > Co-developed-by: lines for lars and Alex as described:
> > https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/so
> > urce/
> > Documentation/process/submitting-
> > patches.rst*L475__;Iw!!A3Ni8CS0y2Y!t1IaOEZX3w2pZXl-
> > RyAlXgPPvxFtCON74ppfGuMgV_pKZcNjsLs-dKSk_mA34IsmlOU$
> >
> > This patch has a history well predating the Co-developed-tag but I'm
> > happy to add that if you can confirm that matches with the intent.
> >
> > Good to leave on the list for a few days anyway in case anyone else
> > wants to take a quick look.
> >
> > I'm looking forwards to merging this and thinking back to when Lars
> > originally discussed this feature with me rather a lot of years back!
> >
> > Jonathan
> >
> >
>=20
> Hi Jonathan,
>=20
> What I have done with the patch was to take the V3 that Alex has left and
> implement the feedback. So I think this is considered as 'handled' from m=
y
> side.
> What happened before V3 I think is better if Alex spokes for himself beca=
use
> I don't really know :)
>=20
> Mihail
>=20

CC: Alexandru Ardelean <ardeleanalex@gmail.com>

> >
> > > ---
> > >  drivers/iio/iio_core.h            |   4 +
> > >  drivers/iio/industrialio-buffer.c | 127
> > +++++++++++++++++++++++++++++-
> > >  drivers/iio/industrialio-core.c   |   1 +
> > >  include/linux/iio/buffer.h        |   7 ++
> > >  include/linux/iio/buffer_impl.h   |  11 +++
> > >  5 files changed, 148 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h index
> > > 8f4a9b264962..61e318431de9 100644
> > > --- a/drivers/iio/iio_core.h
> > > +++ b/drivers/iio/iio_core.h
> > > @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file *fil=
p,
> > >  				 struct poll_table_struct *wait);  ssize_t
> > > iio_buffer_read_wrapper(struct file *filp, char __user *buf,
> > >  				size_t n, loff_t *f_ps);
> > > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __use=
r
> *buf,
> > > +				 size_t n, loff_t *f_ps);
> > >
> > >  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> > > void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
> > >
> > >  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)  #define
> > > iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> > > +#define iio_buffer_write_outer_addr (&iio_buffer_write_wrapper)
> > >
> > >  void iio_disable_all_buffers(struct iio_dev *indio_dev);  void
> > > iio_buffer_wakeup_poll(struct iio_dev *indio_dev); @@ -83,6 +86,7 @@
> > > void iio_device_detach_buffers(struct iio_dev *indio_dev);
> > >
> > >  #define iio_buffer_poll_addr NULL
> > >  #define iio_buffer_read_outer_addr NULL
> > > +#define iio_buffer_write_outer_addr NULL
> > >
> > >  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev
> > > *indio_dev)  { diff --git a/drivers/iio/industrialio-buffer.c
> > > b/drivers/iio/industrialio-buffer.c
> > > index a95cc2da56be..7286563e6234 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -120,6 +120,9 @@ static ssize_t iio_buffer_read(struct file
> > > *filp, char
> > __user *buf,
> > >  	if (!rb || !rb->access->read)
> > >  		return -EINVAL;
> > >
> > > +	if (rb->direction !=3D IIO_BUFFER_DIRECTION_IN)
> > > +		return -EPERM;
> > > +
> > >  	datum_size =3D rb->bytes_per_datum;
> > >
> > >  	/*
> > > @@ -161,6 +164,65 @@ static ssize_t iio_buffer_read(struct file
> > > *filp, char
> > __user *buf,
> > >  	return ret;
> > >  }
> > >
> > > +static size_t iio_buffer_space_available(struct iio_buffer *buf) {
> > > +	if (buf->access->space_available)
> > > +		return buf->access->space_available(buf);
> > > +
> > > +	return SIZE_MAX;
> > > +}
> > > +
> > > +static ssize_t iio_buffer_write(struct file *filp, const char __user=
 *buf,
> > > +				size_t n, loff_t *f_ps)
> > > +{
> > > +	struct iio_dev_buffer_pair *ib =3D filp->private_data;
> > > +	struct iio_buffer *rb =3D ib->buffer;
> > > +	struct iio_dev *indio_dev =3D ib->indio_dev;
> > > +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > > +	int ret;
> > > +	size_t written;
> > > +
> > > +	if (!indio_dev->info)
> > > +		return -ENODEV;
> > > +
> > > +	if (!rb || !rb->access->write)
> > > +		return -EINVAL;
> > > +
> > > +	if (rb->direction !=3D IIO_BUFFER_DIRECTION_OUT)
> > > +		return -EPERM;
> > > +
> > > +	written =3D 0;
> > > +	add_wait_queue(&rb->pollq, &wait);
> > > +	do {
> > > +		if (indio_dev->info =3D=3D NULL)
> > > +			return -ENODEV;
> > > +
> > > +		if (!iio_buffer_space_available(rb)) {
> > > +			if (signal_pending(current)) {
> > > +				ret =3D -ERESTARTSYS;
> > > +				break;
> > > +			}
> > > +
> > > +			wait_woken(&wait, TASK_INTERRUPTIBLE,
> > > +					MAX_SCHEDULE_TIMEOUT);
> > > +			continue;
> > > +		}
> > > +
> > > +		ret =3D rb->access->write(rb, n - written, buf + written);
> > > +		if (ret =3D=3D 0 && (filp->f_flags & O_NONBLOCK))
> > > +			ret =3D -EAGAIN;
> > > +
> > > +		if (ret > 0) {
> > > +			written +=3D ret;
> > > +			if (written !=3D n && !(filp->f_flags & O_NONBLOCK))
> > > +				continue;
> > > +		}
> > > +	} while (ret =3D=3D 0);
> > > +	remove_wait_queue(&rb->pollq, &wait);
> > > +
> > > +	return ret < 0 ? ret : n;
> > > +}
> > > +
> > >  /**
> > >   * iio_buffer_poll() - poll the buffer to find out if it has data
> > >   * @filp:	File structure pointer for device access
> > > @@ -181,8 +243,18 @@ static __poll_t iio_buffer_poll(struct file *fil=
p,
> > >  		return 0;
> > >
> > >  	poll_wait(filp, &rb->pollq, wait);
> > > -	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > > -		return EPOLLIN | EPOLLRDNORM;
> > > +
> > > +	switch (rb->direction) {
> > > +	case IIO_BUFFER_DIRECTION_IN:
> > > +		if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > > +			return EPOLLIN | EPOLLRDNORM;
> > > +		break;
> > > +	case IIO_BUFFER_DIRECTION_OUT:
> > > +		if (iio_buffer_space_available(rb))
> > > +			return EPOLLOUT | EPOLLWRNORM;
> > > +		break;
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >
> > > @@ -199,6 +271,19 @@ ssize_t iio_buffer_read_wrapper(struct file
> > > *filp,
> > char __user *buf,
> > >  	return iio_buffer_read(filp, buf, n, f_ps);  }
> > >
> > > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __use=
r
> *buf,
> > > +				 size_t n, loff_t *f_ps)
> > > +{
> > > +	struct iio_dev_buffer_pair *ib =3D filp->private_data;
> > > +	struct iio_buffer *rb =3D ib->buffer;
> > > +
> > > +	/* check if buffer was opened through new API */
> > > +	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
> > > +		return -EBUSY;
> > > +
> > > +	return iio_buffer_write(filp, buf, n, f_ps); }
> > > +
> > >  __poll_t iio_buffer_poll_wrapper(struct file *filp,
> > >  				 struct poll_table_struct *wait)  { @@ -231,6
> +316,15 @@ void
> > > iio_buffer_wakeup_poll(struct iio_dev
> > *indio_dev)
> > >  	}
> > >  }
> > >
> > > +int iio_pop_from_buffer(struct iio_buffer *buffer, void *data) {
> > > +	if (!buffer || !buffer->access || !buffer->access->remove_from)
> > > +		return -EINVAL;
> > > +
> > > +	return buffer->access->remove_from(buffer, data); }
> > > +EXPORT_SYMBOL_GPL(iio_pop_from_buffer);
> > > +
> > >  void iio_buffer_init(struct iio_buffer *buffer)  {
> > >  	INIT_LIST_HEAD(&buffer->demux_list);
> > > @@ -1156,6 +1250,10 @@ int iio_update_buffers(struct iio_dev
> > *indio_dev,
> > >  	if (insert_buffer =3D=3D remove_buffer)
> > >  		return 0;
> > >
> > > +	if (insert_buffer &&
> > > +	    (insert_buffer->direction =3D=3D IIO_BUFFER_DIRECTION_OUT))
> > > +		return -EINVAL;
> > > +
> > >  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> > >  	mutex_lock(&indio_dev->mlock);
> > >
> > > @@ -1277,6 +1375,22 @@ static ssize_t
> > iio_dma_show_data_available(struct device *dev,
> > >  	return sysfs_emit(buf, "%zu\n",
> > > iio_buffer_data_available(buffer));
> > >  }
> > >
> > > +static ssize_t direction_show(struct device *dev,
> > > +			      struct device_attribute *attr,
> > > +			      char *buf)
> > > +{
> > > +	struct iio_buffer *buffer =3D to_iio_dev_attr(attr)->buffer;
> > > +
> > > +	switch (buffer->direction) {
> > > +	case IIO_BUFFER_DIRECTION_IN:
> > > +		return sprintf(buf, "in\n");
> > > +	case IIO_BUFFER_DIRECTION_OUT:
> > > +		return sprintf(buf, "out\n");
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > >  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR,
> iio_buffer_read_length,
> > >  		   iio_buffer_write_length);
> > >  static struct device_attribute dev_attr_length_ro =3D __ATTR(length,
> > > @@
> > > -1289,12 +1403,20 @@ static struct device_attribute
> > dev_attr_watermark_ro =3D __ATTR(watermark,
> > >  	S_IRUGO, iio_buffer_show_watermark, NULL);  static
> > > DEVICE_ATTR(data_available, S_IRUGO,
> > >  		iio_dma_show_data_available, NULL);
> > > +static DEVICE_ATTR_RO(direction);
> > >
> > > +/*
> > > + * When adding new attributes here, put the at the end, at least
> > > +until
> > > + * the code that handles the length/length_ro &
> > > +watermark/watermark_ro
> > > + * assignments gets cleaned up. Otherwise these can create some
> > > +weird
> > > + * duplicate attributes errors under some setups.
> > > + */
> > >  static struct attribute *iio_buffer_attrs[] =3D {
> > >  	&dev_attr_length.attr,
> > >  	&dev_attr_enable.attr,
> > >  	&dev_attr_watermark.attr,
> > >  	&dev_attr_data_available.attr,
> > > +	&dev_attr_direction.attr,
> > >  };
> > >
> > >  #define to_dev_attr(_attr) container_of(_attr, struct
> > > device_attribute, attr) @@ -1397,6 +1519,7 @@ static const struct
> > file_operations iio_buffer_chrdev_fileops =3D {
> > >  	.owner =3D THIS_MODULE,
> > >  	.llseek =3D noop_llseek,
> > >  	.read =3D iio_buffer_read,
> > > +	.write =3D iio_buffer_write,
> > >  	.poll =3D iio_buffer_poll,
> > >  	.release =3D iio_buffer_chrdev_release,  }; diff --git
> > > a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > index 2dbb37e09b8c..537a08549a69 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -1822,6 +1822,7 @@ static const struct file_operations
> > iio_buffer_fileops =3D {
> > >  	.owner =3D THIS_MODULE,
> > >  	.llseek =3D noop_llseek,
> > >  	.read =3D iio_buffer_read_outer_addr,
> > > +	.write =3D iio_buffer_write_outer_addr,
> > >  	.poll =3D iio_buffer_poll_addr,
> > >  	.unlocked_ioctl =3D iio_ioctl,
> > >  	.compat_ioctl =3D compat_ptr_ioctl,
> > > diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> > > index b6928ac5c63d..fe2e680d9b5e 100644
> > > --- a/include/linux/iio/buffer.h
> > > +++ b/include/linux/iio/buffer.h
> > > @@ -11,8 +11,15 @@
> > >
> > >  struct iio_buffer;
> > >
> > > +enum iio_buffer_direction {
> > > +	IIO_BUFFER_DIRECTION_IN,
> > > +	IIO_BUFFER_DIRECTION_OUT,
> > > +};
> > > +
> > >  int iio_push_to_buffers(struct iio_dev *indio_dev, const void
> > > *data);
> > >
> > > +int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
> > > +
> > >  /**
> > >   * iio_push_to_buffers_with_timestamp() - push data and timestamp
> > > to
> > buffers
> > >   * @indio_dev:		iio_dev structure for device.
> > > diff --git a/include/linux/iio/buffer_impl.h
> > > b/include/linux/iio/buffer_impl.h index 245b32918ae1..e2ca8ea23e19
> > > 100644
> > > --- a/include/linux/iio/buffer_impl.h
> > > +++ b/include/linux/iio/buffer_impl.h
> > > @@ -7,6 +7,7 @@
> > >  #ifdef CONFIG_IIO_BUFFER
> > >
> > >  #include <uapi/linux/iio/buffer.h>
> > > +#include <linux/iio/buffer.h>
> > >
> > >  struct iio_dev;
> > >  struct iio_buffer;
> > > @@ -23,6 +24,10 @@ struct iio_buffer;
> > >   * @read:		try to get a specified number of bytes (must exist)
> > >   * @data_available:	indicates how much data is available for
> reading from
> > >   *			the buffer.
> > > + * @remove_from:	remove scan from buffer. Drivers should calls
> this to
> > > + *			remove a scan from a buffer.
> > > + * @write:		try to write a number of bytes
> > > + * @space_available:	returns the amount of bytes available in a
> > buffer
> > >   * @request_update:	if a parameter change has been marked,
> > update underlying
> > >   *			storage.
> > >   * @set_bytes_per_datum:set number of bytes per datum @@ -49,6
> > +54,9
> > > @@ struct iio_buffer_access_funcs {
> > >  	int (*store_to)(struct iio_buffer *buffer, const void *data);
> > >  	int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
> > >  	size_t (*data_available)(struct iio_buffer *buffer);
> > > +	int (*remove_from)(struct iio_buffer *buffer, void *data);
> > > +	int (*write)(struct iio_buffer *buffer, size_t n, const char
> > > +__user
> > *buf);
> > > +	size_t (*space_available)(struct iio_buffer *buffer);
> > >
> > >  	int (*request_update)(struct iio_buffer *buffer);
> > >
> > > @@ -80,6 +88,9 @@ struct iio_buffer {
> > >  	/**  @bytes_per_datum: Size of individual datum including
> > timestamp. */
> > >  	size_t bytes_per_datum;
> > >
> > > +	/* @direction: Direction of the data stream (in/out). */
> > > +	enum iio_buffer_direction direction;
> > > +
> > >  	/**
> > >  	 * @access: Buffer access functions associated with the
> > >  	 * implementation.

