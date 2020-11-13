Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA03B2B16C3
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 08:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKMHzq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 02:55:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13094 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMHzp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 02:55:45 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD7nnjV031819;
        Fri, 13 Nov 2020 02:55:26 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 34npab4rfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 02:55:25 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AD7sPWK006832;
        Fri, 13 Nov 2020 02:55:25 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 34npab4rf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 02:55:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6F4UrLx2D5RjM9vbXebeYNEYh1w3+4pza18nFwEvEgBk/jKOut63mlUXF6oQzBlueA0ppPgrLdQZn94P/kjI/buoU9lPXIYbvmzI6jEbZyz3jSAPw9DwQErVsXp31l5BRBk31Spf8debwieQSECb1ZaVcyblvSP+vmttLbQA5Z8DFZiOX19/U7aCFPXbq6Y8z8XNT9j+VVQdXzGfozzTQxpUXa4Z536nIExivUSVwS7jyRBxuR49d8nhi0q0PUh1FjsfCBKWstXkVeVj1u7HOJpsycXv/QCHDkXnXcqeBQsa3m40ZOonFdnRi3OaUFzKIwu9uyhXvnbrs1Mgazl0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5iQILqTrK8bECNPqeYIIPqlrCLETdcNizv98fnRth8=;
 b=kNORiwikDgb8MVql2Ux0M+RaqYooTDZp9eijarl1uc22jCvRbpsBhyZdzlJJ08YuAN/3oLFdiCNKuDxZyTPAzEhHfSi4Fqqh+XoHhJTzmiggqOLQ5QcyrgWdK12kTKLpuXMbfub0qgIvjzbLPx3DIuSm+Uq1lLhdh58nKqNKdjCcpi28ae+9TlTGQWQINB7gdRUuyHtR+Du0jLKZuJKx7l6L6EdyRcEzgw5+qstt40C23vt/9Di+53BJioA2xTX9g7NlmN6vEfEo9lfS6SjksIGIdGmsGwD/4ZCJvoYB8epzipsi+Y0QEHnygKEZsPCXuswk3hAfZmaDBnzKaDn1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5iQILqTrK8bECNPqeYIIPqlrCLETdcNizv98fnRth8=;
 b=SoEqdjADw8YRglxGNb7CLtb0Jk0+qEY5LJ8LlaFExq5ZahFSG3jFPu27tlf1uzwOnwE6G03Hf2GwFdH26/LhKx2M/mRsm3e0ePu0qkIh7SJMVdfIbCtKfYxRquoJTebwpnJX8K6zzs90duW0543i+tzX8+f21ZSWtt9bWdxjM5g=
Received: from CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:74::18)
 by CY4PR03MB2455.namprd03.prod.outlook.com (2603:10b6:903:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 07:55:22 +0000
Received: from CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::355a:8cf8:4345:1ce8]) by CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::355a:8cf8:4345:1ce8%10]) with mapi id 15.20.3541.025; Fri, 13 Nov
 2020 07:55:22 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: RE: [PATCH] iio: buffer: Fix demux update
Thread-Topic: [PATCH] iio: buffer: Fix demux update
Thread-Index: AQHWuQH4Y31Qb/eZaEC2EE4Td3QVe6nEwGuAgADq9gA=
Date:   Fri, 13 Nov 2020 07:55:21 +0000
Message-ID: <CY4PR03MB263146ADC49222DE28BB028999E60@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20201112144323.28887-1-nuno.sa@analog.com>
 <20201112172821.0000088b@Huawei.com>
In-Reply-To: <20201112172821.0000088b@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctOTIzMWRlZTItMjU4NS0xMWViLThhZDItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDkyMzFkZWUzLTI1ODUtMTFlYi04YWQyLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTcxMiIgdD0iMTMyNDk3Mjc3MT?=
 =?iso-8859-1?Q?kxMDg2NTgxIiBoPSIxT00zT0s5RE1acnVvWXYyUWI3cy9SWE9JUWM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUQxWWE1VWtybldBY3UwR294ZkhpZ2x5N1FhakY4ZUtDVURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQWRFS2R6d0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:24fd:9701:4c7b:9126:961d:513c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db0aaeba-c2f8-42f0-4373-08d887a978ea
x-ms-traffictypediagnostic: CY4PR03MB2455:
x-microsoft-antispam-prvs: <CY4PR03MB24555205591A77891CABDC2D99E60@CY4PR03MB2455.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhlLHLi4sBloBquAHIZOh5fUi1pqmEQu2vt537ICvS54e1rwc0vf4u8+u/hglJnHgUZYJetoWH6ROj87AyiL3ZcTJ3AbKmfZ9S4iCb2+CiFbRHespxNQkp5AZz/FmULSHRAbS2c53d6lLFu+yS7ZWu9LYEPhNYCrhEg+KRrgHNCpUqJk925KDih+hxVT0yvIyyevfcmQCDTs9al58JR8BEV7iYYvalJUGgvECbl0vbT+AxaN1/r17M8DyAhfmAk21Uoz+yXmizcZpj8kr9nhS3l0g3MZaORyIUd36mfnJjCOq9zsM0Cz/ydWr5LUNMGjPCn1J3UvjkM8TcZmFGFtow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2631.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(15650500001)(52536014)(71200400001)(6916009)(478600001)(66556008)(5660300002)(33656002)(76116006)(8676002)(186003)(83380400001)(4326008)(6506007)(66476007)(86362001)(66946007)(53546011)(2906002)(9686003)(316002)(54906003)(55016002)(8936002)(7696005)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ByqWY5lRKkm2Cc/c58SugMOqwYaah0MLTs5mwT5bjt4kc/PKkrCB6Bhdf2?=
 =?iso-8859-1?Q?08NM5mu3fCCZZ9Wf+lSdGQZXeCaw+uIJ+omdascQ/KSmo4XzJWB5J55SHD?=
 =?iso-8859-1?Q?5BJ9kgjfmYRbGz7VYCrkmPtAOZetQZk2Fc7sSRsBFeY6v6spXnyxINalzM?=
 =?iso-8859-1?Q?/WLTo9eRECdwmS3f0+Xb44kyKgV5CqdTna+W9FWev8tC1ywafX1X5lCeHw?=
 =?iso-8859-1?Q?OL86HDTg5XBxVYbJuF/UqVYnUDmSyevmd/pp02gpnqLL8cP9d+WlpMtzhN?=
 =?iso-8859-1?Q?8wMj1OLICQsc44YawDMX+OPYfUcCXQuXgG7B0EbkMjPV5mRn2DH5ySpgde?=
 =?iso-8859-1?Q?gyNh9EgoOIqFCqggUxZ+pAHt2UXrCuXh/4134wPsK67cfgZeyTHzTWqiqI?=
 =?iso-8859-1?Q?CBlQNq4JYKUU5r3Ri2q7skzlNq4YP1vCmnBT2I/QJusYcyelrV1NdOMx+C?=
 =?iso-8859-1?Q?EkNfABiMPgI+aZZSUS1M1m0n+0HOlCXGYdMiw1ktSfazPNQR72MhWA2jfT?=
 =?iso-8859-1?Q?6Y/CCCLu1Ke39X0up0ZBh1Ha1sLUT64jRRsOgQ0kbEQ3GSKi1CKG2yuw66?=
 =?iso-8859-1?Q?u/UbNdtKyKwYuHfrYGK1aTzlmC/rY8j6EwZ7KVgLwKBpKGaOp4PjCbm9iY?=
 =?iso-8859-1?Q?B4WORD+949Lnd0OOPxNByFeAN2IIROwMCBm+c3HO+InoTASAC6GvMBZ6eH?=
 =?iso-8859-1?Q?YjjAC2uCPDNj+wb8r3OaX2FfX5JFrV4W+GaE2xFEhByuNRWY/463pvIdpO?=
 =?iso-8859-1?Q?cZL+TtO3V903TGqFoP5px9hydnmKb1O13UFH4a0mnlUeDN20dXk512fZPQ?=
 =?iso-8859-1?Q?6IyojVJraD5+3okrNdflcZvzX4TJtP5G6E497WSUFWqYuDxzWmMxcdQUJo?=
 =?iso-8859-1?Q?ugLcTszdACHtQGq8BlYyg6FKE9x1F7tCuzoziAWZRzMCMcATr1T6tMET/N?=
 =?iso-8859-1?Q?KD5Uy+KCTBVyc0gy8RUkbybcX3NoaD9CIwMW1yxaeJGPfJXcZ2yAPw=3D?=
 =?iso-8859-1?Q?=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2631.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0aaeba-c2f8-42f0-4373-08d887a978ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 07:55:21.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1o14fyGpe6TpGYgBRiJvWkGb/DrkbKlNL3j7p8J3c9JT2PSWOMRC+po+e/teImQDEkHWvbxGEPsGQsLxcZ/d5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2455
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_05:2020-11-12,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130046
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Thursday, November 12, 2020 6:28 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: linux-iio@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>;
> Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>
> Subject: Re: [PATCH] iio: buffer: Fix demux update
>=20
>=20
> On Thu, 12 Nov 2020 15:43:22 +0100
> Nuno S=E1 <nuno.sa@analog.com> wrote:
>=20
> > When updating the buffer demux, we will skip a scan element from
> the
> > device in the case `in_ind !=3D out_ind` and we enter the while loop.
> > in_ind should only be refreshed with `find_next_bit()` in the end of
> the
> > loop.
> >
> > Fixes: 5ada4ea9be16 ("staging:iio: add demux optionally to path from
> device to buffer")
> > Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
>=20
> Yikes that's been there a long time.
>=20
> Could you provide an example of a particular layout and the result of
> this being wrong?
>=20

Hi Jonathan,

Let's say:

iio_dev_mask: 0x0111
buffer_mask: 0x0100

We would get out_ind =3D 2 and in_ind =3D 0 and  enter the loop. In the fir=
st
iteration we call find_next_bit() before doing the in_ind=3D0 computation w=
hich means we=20
will skip it and go directly to bit 1... And if we continue the path flow, =
we see that bit 2 will
be computed two times, so if we are lucky and scan_index0_len =3D=3D scan_i=
ndex2_len this
will go unnoticed...

Honestly, I didn't test this but it looks one of those things more or less =
clear by reading
the code or am I missing something here?

- Nuno S=E1

> Thanks,
>=20
> Jonathan
>=20
