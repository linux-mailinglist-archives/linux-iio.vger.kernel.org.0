Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2B443C3E9
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbhJ0Hdl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 03:33:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48770 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231144AbhJ0Hdk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Oct 2021 03:33:40 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QIbWY0014767;
        Wed, 27 Oct 2021 03:31:15 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bx4fayggx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Oct 2021 03:31:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsABgsjZnuzECTUCF6T5SkvTmfgcJzBXq054Y4yKqF5bv2Wx9+HxdNYp0TzePRMZNTPfHBZhelnuzqXp/9AtZNgSp20FoNzr0cvCa7D6a/LZcp+uGWK3NDJR1VPm8UFbXiuqvZFnRO1yfbGga3H2egTVp7O8K5Gs2reYiTLd/nN9ZmEXQHRA9ZnWCnKsNXc938E0iFnFHtDjq0L2aZCxHJVOMsptKrv0JtPh587YpiP456OzJibHRlLobnn2GKUlDHx/wLEwDVqx7KN69/KZty7to1z7KSShFR8oOCP9bQ83CWAqFFf8IzN3R77BylOFZz4CYbSOqpPaeNuNxfW3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6xdeRhbTMvxxk8St7xN3R9bZQjC4VMYQLJjLkV/CqE=;
 b=T0JShXkqDDJjeSVZx+4k+rWr2Dxe8VXuVjxb9lexhiJpBXEohhDrOdrMm1gUtVlTHXWYQ1FqF0PNVDb5xAvqBPkJABRIrTRXL/NRA94C8IhazNaDT/Vh7iZijSudMChXkaCBg67QMf8to2FV4O9Giu4NG8E51S5R+87tOpYhfz8roExi72HyzWKJxOWUUcyFoYDqKW8gVUh0CEkxBA3J5YcOgoGrdRmnuDwmUDvOduPyRMOcDfUx65YV0WSwlD93SIKZr39vz59g7f/B3wcEvqLVOwTJYFK3wjr5EJ84wk59h4h5HHieEdGcrtxoplSDFQ7MaTpWzTI2cIDLfIypHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6xdeRhbTMvxxk8St7xN3R9bZQjC4VMYQLJjLkV/CqE=;
 b=BTg19VUZHavw6QsZ6bHWzxILsOuUf9gu5LZuRxAZSi/sCWiasj25Md/5o6HuPqdSTQliHr3WAm2vDr/+swp25ylgvpmqsfKyuuvZoA066m68ob/6oqhkHaZdElBeyNl31CUUYAZ2Kj+qX5J7D3f1/Yq1rNXm8vbYGa5Hp8WYrtU=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Wed, 27 Oct
 2021 07:31:12 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73%7]) with mapi id 15.20.4628.022; Wed, 27 Oct 2021
 07:31:12 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Subject: RE: [PATCH 1/2] iio: frequency: admv1013: add support for ADMV1013
Thread-Topic: [PATCH 1/2] iio: frequency: admv1013: add support for ADMV1013
Thread-Index: AQHXyn4R0qiBksx9uU6sXmwL9MG/Oavmc47A
Date:   Wed, 27 Oct 2021 07:31:12 +0000
Message-ID: <PH0PR03MB6366162032358FC1A2DB886F99859@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211026152744.129065-1-antoniu.miclaus@analog.com>
 <20211026152744.129065-2-antoniu.miclaus@analog.com>
In-Reply-To: <20211026152744.129065-2-antoniu.miclaus@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcGRh?=
 =?us-ascii?Q?dGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUz?=
 =?us-ascii?Q?NWJcbXNnc1xtc2ctZGE0MjU1ODUtMzZmNy0xMWVjLThiOTQtZTRiOTdhN2Nj?=
 =?us-ascii?Q?NzEwXGFtZS10ZXN0XGRhNDI1NTg3LTM2ZjctMTFlYy04Yjk0LWU0Yjk3YTdj?=
 =?us-ascii?Q?YzcxMGJvZHkudHh0IiBzej0iMjAwODQiIHQ9IjEzMjc5NzkzNDY5ODc2OTI0?=
 =?us-ascii?Q?NCIgaD0iQzNDWnRaZkRCb2VieFF4Y0U2VW85YytDZ05jPSIgaWQ9IiIgYmw9?=
 =?us-ascii?Q?IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9DQUFCY0s2?=
 =?us-ascii?Q?Q2NCTXZYQVlSZlZsUGo4UllKaEY5V1UrUHhGZ2tEQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QVFBQkFBQUFWSUV2b1FBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQWFRQmZB?=
 =?us-ascii?Q?SE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6QUY4QVpn?=
 =?us-ascii?Q?QmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFH?=
 =?us-ascii?Q?VUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2QUdv?=
 =?us-ascii?Q?QVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0YT4?=
 =?us-ascii?Q?=3D?=
x-dg-rorf: true
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff5224c8-4221-40a2-71a2-08d9991bc0d4
x-ms-traffictypediagnostic: PH0PR03MB6351:
x-microsoft-antispam-prvs: <PH0PR03MB63519DFA6D235F3C0AB5B85699859@PH0PR03MB6351.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YkGwymxH0lWaw9FuWX5594E5fYErZA7qYx6edg6xJQtVx5JIcK32Sp9P4jt18oBsTUDBSOWViyhUHYuBVsSLXBfFCZvL2B9vGsPFCNgx7yUL/b7ormHgekddB39zIJqijgYaeY4XUO7hQdHTQt2v+Xf2/FTL6qDQTT/aVqaPbI4jaOkc9MTg41Lgnw+tNI6G1LkiJSqZAoZppFrJoeaDm6BOTMm/o2XvqHL6pTdMZTDMjIHoTr6CirB/zb/14XDgA9W4SR5skhitHQnR9PGUraY98tB8+4U4UlX0gYK5u+MfUojx/1Sny1v3GOq0XOPxE6zgA01WjMTOuApTpia72RU0iqFBMapUe/W9NVd23G1jODqb5bvyCGkqmuXhUkFVIIGzYsn/JUyEUofTq2IbRiBkUmIiVRIPhWlQ0Zxn9k3+8X4pPIRPwLjTNJj04jIERqraIQT5qfRcAEj2i83Z+GDrF3j7SM7bMjYmpthTeVQc/piji5Tt+bWqBrnB/7cpNgDHdcphUMLgfoU9K4GdAvPoEe1pXGncP7ul39abl1EM7mQtGPHHisXDKJNT2A3d/SAlp5qASe7rdv9CaRMvsuSWvBEuJpaI2muSR0u/dsZYdFh4vs0lPH7E0TUZpbHh3OK0dRu0xn0eM6rW29GERR0PPmCPU9sgzOLsWqe//KKam3kE8OQzsltbLO31UX3Z4VY+eINy43uE1StNGK5QiEEi2SePipq6qMuNff7dfOz1SAHfG8L2AAq3hWX+K3j9B0/5sLabuFEEQPSgPiRbAvUHNasH0Z4geMhAJt05wAs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(7696005)(83380400001)(53546011)(64756008)(66446008)(55016002)(6506007)(316002)(4326008)(38100700002)(52536014)(122000001)(71200400001)(30864003)(66556008)(38070700005)(2906002)(8936002)(5660300002)(86362001)(186003)(26005)(9686003)(76116006)(66946007)(66476007)(8676002)(508600001)(107886003)(33656002)(110136005)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YHMsrz9ex1Bk1fA/uAWQMv+vTqHBaL/fP7mFyPherhWYKNaIzEVRdoWQzsuP?=
 =?us-ascii?Q?YfR9kHu4L2xer3RICZn5kZeGvUCo96xIFBmNoNurhskuyzgeN1VzTLCq5Nic?=
 =?us-ascii?Q?oqSj9FGbBRQdhGRi/jPwiTaZdrASBm9A28V8HnctTz0phW88Vl34a6jowDy7?=
 =?us-ascii?Q?VqB44oEk8guEsriWPYTKKXZ668AiofSFS+x2oLXLMdo6/qYT16bD05ob7Xfy?=
 =?us-ascii?Q?5P0KmmBqj15YU276f36n6hdnpBos6ioBa988J/opl3WMwQbNs/wujRvupHGB?=
 =?us-ascii?Q?r/jDnrYIxfoF3o5SAFZg1ziW64qoXRNrins/cTqFgKGxCuS8U9uXMZkTzwg/?=
 =?us-ascii?Q?Dy7uI/dUL2XTriKG8ptzX4vmFPjCr1knu8FH6igypYC+EQ4+UVpreKq1xMSX?=
 =?us-ascii?Q?8WeFlwzRV25nSfAXStdooQyjmvUsN3gvA1SVzAi9Ps++BbaVRFoozwv74GGI?=
 =?us-ascii?Q?aeqxELpR++A6RO/V/kK3Iiz21E3cPM7qANKDlORvNqvO0WNqjNjV0otI4vtd?=
 =?us-ascii?Q?9N27Jk8Fo22EA7SC/ZBYPeZ5JGWlSL2TW0t5LOR6AfqHTyn0uiVxUtmR8e7j?=
 =?us-ascii?Q?zY99WhKxiro+z0K1KMbgtaZf7g63jLag2VFgw0pbB0gU2PoqqnNEPiePqmY/?=
 =?us-ascii?Q?p+Izz0oWmzl7Wu8OssusRnt1fINreA08pNDd70fAS3eZFQZ4TQsmEZArjr7m?=
 =?us-ascii?Q?cNIgesfkLnDAaAIQ7ESDfGYwT3QGJP+lOUuXbIJl5SzgNn2vZbmH7kI1/rlo?=
 =?us-ascii?Q?IcJvueyBg7PxYMYE1fL8PmD7QssRyT/bovbRXQ5J+rPZu6V6LVnDlLY0HqtY?=
 =?us-ascii?Q?ZcOGJqj3qeAte26+ZPdJ4Wazks1L7qs4InWESwzP9A6LIS0DEuA6Wy2VDgUf?=
 =?us-ascii?Q?N8sDHkmQdVF/X+Rh9MnibR4QszOnb5cyBNNUYmD3AZqbELgsxdBk4pHVo9kg?=
 =?us-ascii?Q?0BrMZVI7JP1F2Uhdo2JUg9aMI6BgBQIU8kG61Ay1cwW7bBD3IU23IrXA9b+V?=
 =?us-ascii?Q?G3/kFJkf4Qcfj0EiSzdXNgiTKE4ShoRLXnE2J/S+EgqxGsFojwpUNIVmWDuD?=
 =?us-ascii?Q?5nHawzWk9c49i0hKfPYLB3+iO15LmuG1z1XGAEtFxp/0IvNlgUqEwR1E9avw?=
 =?us-ascii?Q?51oB9ubJ2O1aMNXI0t9OHe+CS7XjS+oImSv2NS97lnDvxPKMJAWc06QX7yrp?=
 =?us-ascii?Q?dIUYc8Qz2s98Kdu+nV5eKPoEP96MwrZka4kF+mHQW/mgA0/efpMxWfypUw5J?=
 =?us-ascii?Q?YMSn+O/6j4vui2stByxAUTs75TgWojIugDg9Y0U8pnsRUZPun+Fvl8/1H3pC?=
 =?us-ascii?Q?YO6byW4EkxyvEgQLBREN/Tk6TntJaRS78OOjiaoQ1zJOFnHqTtLMZdugPD5f?=
 =?us-ascii?Q?fX+6/yFaOvgQtxfFLY9mmTSrFFU6Sc3cj1RwAJ8CqQVlaffeGO3IIZXmSmgS?=
 =?us-ascii?Q?tu1UztHUEW1fjXq1gBd71aYK7PJCrwdJrgmD3pldHAbj4lW4d9iEeh39LH1p?=
 =?us-ascii?Q?ef4Ve4mbagoMVn8JZWtAh9r0cg0qcl1OzjRUtP7CCnTlqvRdp+sqwnwC9/sr?=
 =?us-ascii?Q?JFKR96oWafuCCriQPAAWrmYcAlEGC82wpHQyV/hST6IQ7B8xXrcqgaBq71T/?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5224c8-4221-40a2-71a2-08d9991bc0d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 07:31:12.6307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpvgTpQ0RenL/BxUt7epYwiiS7XUUw9A/DW+VhbzsDn2FgUqu9MhbStehtgztWFTBrbb+8ZpibwdooJgknl19w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6351
X-Proofpoint-GUID: PawXbb3SO71It2X1Ky0J98zpYwy_jPSf
X-Proofpoint-ORIG-GUID: PawXbb3SO71It2X1Ky0J98zpYwy_jPSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110270043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Sent: Tuesday, October 26, 2021 5:28 PM
> To: jic23@kernel.org; robh+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Subject: [PATCH 1/2] iio: frequency: admv1013: add support for
> ADMV1013
>=20
> [External]
>=20
> The ADMV1013 is a wideband, microwave upconverter optimized
> for point to point microwave radio designs operating in the
> 24 GHz to 44 GHz radio frequency (RF) range.
>=20
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-
> sheets/ADMV1013.pdf
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/frequency/Kconfig    |  13 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv1013.c | 579
> +++++++++++++++++++++++++++++++
>  3 files changed, 593 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv1013.c
>=20
> diff --git a/drivers/iio/frequency/Kconfig
> b/drivers/iio/frequency/Kconfig
> index 240b81502512..11792a5e7b83 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -49,5 +49,18 @@ config ADF4371
>=20
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4371.
> +
> +config ADMV1013
> +	tristate "Analog Devices ADMV1013 Microwave Upconverter"
> +	depends on SPI
> +	depends on COMMON_CLK
> +	depends on 64BIT

This can be 'depends on SPI && COMMON_CLK && 64BIT'

> +	help
> +	  Say yes here to build support for Analog Devices ADMV1013
> +	  24 GHz to 44 GHz, Wideband, Microwave Upconverter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called admv1013.
> +
>  endmenu
>  endmenu
> diff --git a/drivers/iio/frequency/Makefile
> b/drivers/iio/frequency/Makefile
> index 518b1e50caef..559922a8196e 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -7,3 +7,4 @@
>  obj-$(CONFIG_AD9523) +=3D ad9523.o
>  obj-$(CONFIG_ADF4350) +=3D adf4350.o
>  obj-$(CONFIG_ADF4371) +=3D adf4371.o
> +obj-$(CONFIG_ADMV1013) +=3D admv1013.o
> diff --git a/drivers/iio/frequency/admv1013.c
> b/drivers/iio/frequency/admv1013.c
> new file mode 100644
> index 000000000000..1d46f96afc23
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -0,0 +1,579 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV1013 driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/unaligned.h>
> +
> +/* ADMV1013 Register Map */
> +#define ADMV1013_REG_SPI_CONTROL		0x00
> +#define ADMV1013_REG_ALARM			0x01
> +#define ADMV1013_REG_ALARM_MASKS		0x02
> +#define ADMV1013_REG_ENABLE			0x03
> +#define ADMV1013_REG_LO_AMP_I			0x05
> +#define ADMV1013_REG_LO_AMP_Q			0x06
> +#define ADMV1013_REG_OFFSET_ADJUST_I		0x07
> +#define ADMV1013_REG_OFFSET_ADJUST_Q		0x08
> +#define ADMV1013_REG_QUAD			0x09
> +#define ADMV1013_REG_VVA_TEMP_COMP		0x0A
> +
> +/* ADMV1013_REG_SPI_CONTROL Map */
> +#define ADMV1013_PARITY_EN_MSK			BIT(15)
> +#define ADMV1013_SPI_SOFT_RESET_MSK		BIT(14)
> +#define ADMV1013_CHIP_ID_MSK			GENMASK(11, 4)
> +#define ADMV1013_CHIP_ID			0xA
> +#define ADMV1013_REVISION_ID_MSK		GENMASK(3, 0)
> +
> +/* ADMV1013_REG_ALARM Map */
> +#define ADMV1013_PARITY_ERROR_MSK		BIT(15)
> +#define ADMV1013_TOO_FEW_ERRORS_MSK		BIT(14)
> +#define ADMV1013_TOO_MANY_ERRORS_MSK		BIT(13)
> +#define ADMV1013_ADDRESS_RANGE_ERROR_MSK	BIT(12)
> +
> +/* ADMV1013_REG_ENABLE Map */
> +#define ADMV1013_VGA_PD_MSK			BIT(15)
> +#define ADMV1013_MIXER_PD_MSK			BIT(14)
> +#define ADMV1013_QUAD_PD_MSK
> 	GENMASK(13, 11)
> +#define ADMV1013_BG_PD_MSK			BIT(10)
> +#define ADMV1013_MIXER_IF_EN_MSK		BIT(7)
> +#define ADMV1013_DET_EN_MSK			BIT(5)
> +
> +/* ADMV1013_REG_LO_AMP_I Map */
> +#define ADMV1013_LOAMP_PH_ADJ_I_FINE_MSK	GENMASK(13, 7)
> +#define ADMV1013_MIXER_VGATE_MSK		GENMASK(6, 0)
> +
> +/* ADMV1013_REG_LO_AMP_Q Map */
> +#define ADMV1013_LOAMP_PH_ADJ_Q_FINE_MSK	GENMASK(13, 7)
> +
> +/* ADMV1013_REG_OFFSET_ADJUST_I Map */
> +#define ADMV1013_MIXER_OFF_ADJ_I_P_MSK
> 	GENMASK(15, 9)
> +#define ADMV1013_MIXER_OFF_ADJ_I_N_MSK
> 	GENMASK(8, 2)
> +
> +/* ADMV1013_REG_OFFSET_ADJUST_Q Map */
> +#define ADMV1013_MIXER_OFF_ADJ_Q_P_MSK
> 	GENMASK(15, 9)
> +#define ADMV1013_MIXER_OFF_ADJ_Q_N_MSK
> 	GENMASK(8, 2)
> +
> +/* ADMV1013_REG_QUAD Map */
> +#define ADMV1013_QUAD_SE_MODE_MSK		GENMASK(9, 6)
> +#define ADMV1013_QUAD_FILTERS_MSK		GENMASK(3, 0)
> +
> +/* ADMV1013_REG_VVA_TEMP_COMP Map */
> +#define ADMV1013_VVA_TEMP_COMP_MSK
> 	GENMASK(15, 0)
> +
> +struct admv1013_state {
> +	struct spi_device	*spi;
> +	struct clk		*clkin;
> +	/* Protect against concurrent accesses to the device */
> +	struct mutex		lock;
> +	struct regulator	*reg;
> +	struct notifier_block	nb;
> +	unsigned int		quad_se_mode;
> +	bool			vga_pd;
> +	bool			mixer_pd;
> +	bool			quad_pd;
> +	bool			bg_pd;
> +	bool			mixer_if_en;
> +	bool			det_en;
> +	u8			data[3] ____cacheline_aligned;
> +};
> +
> +static int __admv1013_spi_read(struct admv1013_state *st, unsigned
> int reg,
> +			       unsigned int *val)
> +{
> +	int ret;
> +	struct spi_transfer t =3D {0};
> +
> +	st->data[0] =3D 0x80 | (reg << 1);
> +	st->data[1] =3D 0x0;
> +	st->data[2] =3D 0x0;
> +
> +	t.rx_buf =3D &st->data[0];
> +	t.tx_buf =3D &st->data[0];
> +	t.len =3D 3;
> +
> +	ret =3D spi_sync_transfer(st->spi, &t, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D (get_unaligned_be24(&st->data[0]) >> 1) &
> GENMASK(15, 0);
> +
> +	return ret;
> +}
> +
> +static int admv1013_spi_read(struct admv1013_state *st, unsigned
> int reg,
> +			     unsigned int *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret =3D __admv1013_spi_read(st, reg, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int __admv1013_spi_write(struct admv1013_state *st,
> +				unsigned int reg,
> +				unsigned int val)
> +{
> +	put_unaligned_be24((val << 1) | (reg << 17), &st->data[0]);
> +
> +	return spi_write(st->spi, &st->data[0], 3);
> +}
> +
> +static int admv1013_spi_write(struct admv1013_state *st, unsigned
> int reg,
> +			      unsigned int val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret =3D __admv1013_spi_write(st, reg, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int __admv1013_spi_update_bits(struct admv1013_state *st,
> unsigned int reg,
> +				      unsigned int mask, unsigned int val)
> +{
> +	int ret;
> +	unsigned int data, temp;
> +
> +	ret =3D __admv1013_spi_read(st, reg, &data);
> +	if (ret)
> +		return ret;
> +
> +	temp =3D (data & ~mask) | (val & mask);
> +
> +	return __admv1013_spi_write(st, reg, temp);
> +}
> +
> +static int admv1013_spi_update_bits(struct admv1013_state *st,
> unsigned int reg,
> +				    unsigned int mask, unsigned int val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret =3D __admv1013_spi_update_bits(st, reg, mask, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int admv1013_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct admv1013_state *st =3D iio_priv(indio_dev);
> +	unsigned int data;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->channel2 =3D=3D IIO_MOD_I) {
> +			ret =3D admv1013_spi_read(st,
> ADMV1013_REG_OFFSET_ADJUST_I, &data);
> +			if (ret)
> +				return ret;
> +
> +			*val =3D
> FIELD_GET(ADMV1013_MIXER_OFF_ADJ_I_P_MSK, data);
> +			*val2 =3D
> FIELD_GET(ADMV1013_MIXER_OFF_ADJ_I_N_MSK, data);
> +		} else {
> +			ret =3D admv1013_spi_read(st,
> ADMV1013_REG_OFFSET_ADJUST_Q, &data);
> +			if (ret)
> +				return ret;
> +
> +			*val =3D
> FIELD_GET(ADMV1013_MIXER_OFF_ADJ_Q_P_MSK, data);
> +			*val2 =3D
> FIELD_GET(ADMV1013_MIXER_OFF_ADJ_Q_N_MSK, data);
> +		}
> +
> +		return IIO_VAL_INT_MULTIPLE;
> +	case IIO_CHAN_INFO_PHASE:
> +		if (chan->channel2 =3D=3D IIO_MOD_I) {
> +			ret =3D admv1013_spi_read(st,
> ADMV1013_REG_LO_AMP_I, &data);
> +			if (ret)
> +				return ret;
> +
> +			*val =3D
> FIELD_GET(ADMV1013_LOAMP_PH_ADJ_I_FINE_MSK, data);
> +		} else {
> +			ret =3D admv1013_spi_read(st,
> ADMV1013_REG_LO_AMP_Q, &data);
> +			if (ret)
> +				return ret;
> +
> +			*val =3D
> FIELD_GET(ADMV1013_LOAMP_PH_ADJ_Q_FINE_MSK, data);
> +		}
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int admv1013_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
> +{
> +	struct admv1013_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		val2 /=3D 100000;
> +
> +		if (chan->channel2 =3D=3D IIO_MOD_I)
> +			ret =3D admv1013_spi_update_bits(st,
> ADMV1013_REG_OFFSET_ADJUST_I,
> +
> ADMV1013_MIXER_OFF_ADJ_I_P_MSK |
> +
> ADMV1013_MIXER_OFF_ADJ_I_N_MSK,
> +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_I_P_MSK, val) |
> +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_I_N_MSK, val2));
> +		else
> +			ret =3D admv1013_spi_update_bits(st,
> ADMV1013_REG_OFFSET_ADJUST_Q,
> +
> ADMV1013_MIXER_OFF_ADJ_Q_P_MSK |
> +
> ADMV1013_MIXER_OFF_ADJ_Q_N_MSK,
> +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_Q_P_MSK, val) |
> +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_Q_N_MSK, val2));
> +
> +		return ret;
> +	case IIO_CHAN_INFO_PHASE:
> +		if (chan->channel2 =3D=3D IIO_MOD_I)
> +			return admv1013_spi_update_bits(st,
> ADMV1013_REG_LO_AMP_I,
> +
> 	ADMV1013_LOAMP_PH_ADJ_I_FINE_MSK,
> +
> 	FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_I_FINE_MSK, val));
> +		else
> +			return admv1013_spi_update_bits(st,
> ADMV1013_REG_LO_AMP_Q,
> +
> 	ADMV1013_LOAMP_PH_ADJ_Q_FINE_MSK,
> +
> 	FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_Q_FINE_MSK, val));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int admv1013_update_quad_filters(struct admv1013_state *st)
> +{
> +	unsigned int filt_raw;
> +	u64 rate =3D clk_get_rate(st->clkin);
> +
> +	if (rate >=3D 5400000000 && rate <=3D 7000000000)
> +		filt_raw =3D 15;
> +	else if (rate >=3D 5400000000 && rate <=3D 8000000000)
> +		filt_raw =3D 10;
> +	else if (rate >=3D 6600000000 && rate <=3D 9200000000)
> +		filt_raw =3D 5;
> +	else
> +		filt_raw =3D 0;
> +
> +	return __admv1013_spi_update_bits(st,
> ADMV1013_REG_QUAD,
> +
> 	ADMV1013_QUAD_FILTERS_MSK,
> +
> 	FIELD_PREP(ADMV1013_QUAD_FILTERS_MSK, filt_raw));
> +}
> +
> +static int admv1013_update_mixer_vgate(struct admv1013_state *st)
> +{
> +	unsigned int vcm, mixer_vgate;
> +
> +	vcm =3D regulator_get_voltage(st->reg);
> +
> +	if (vcm >=3D 0 && vcm < 1800000)
> +		mixer_vgate =3D (2389 * vcm / 1000000 + 8100) / 100;
> +	else if (vcm > 1800000 && vcm < 2600000)
> +		mixer_vgate =3D (2375 * vcm / 1000000 + 125) / 100;
> +	else
> +		return -EINVAL;
> +
> +	return __admv1013_spi_update_bits(st,
> ADMV1013_REG_LO_AMP_I,
> +				 ADMV1013_MIXER_VGATE_MSK,
> +
> FIELD_PREP(ADMV1013_MIXER_VGATE_MSK, mixer_vgate));
> +}
> +
> +static int admv1013_reg_access(struct iio_dev *indio_dev,
> +			       unsigned int reg,
> +			       unsigned int write_val,
> +			       unsigned int *read_val)
> +{
> +	struct admv1013_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	if (read_val)
> +		ret =3D admv1013_spi_read(st, reg, read_val);
> +	else
> +		ret =3D admv1013_spi_write(st, reg, write_val);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info admv1013_info =3D {
> +	.read_raw =3D admv1013_read_raw,
> +	.write_raw =3D admv1013_write_raw,
> +	.debugfs_reg_access =3D &admv1013_reg_access,
> +};
> +
> +static int admv1013_freq_change(struct notifier_block *nb, unsigned
> long action, void *data)
> +{
> +	struct admv1013_state *st =3D container_of(nb, struct
> admv1013_state, nb);
> +	int ret;
> +
> +	if (action =3D=3D POST_RATE_CHANGE) {
> +		mutex_lock(&st->lock);
> +		ret =3D
> notifier_from_errno(admv1013_update_quad_filters(st));
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void admv1013_clk_notifier_unreg(void *data)
> +{
> +	struct admv1013_state *st =3D data;
> +
> +	clk_notifier_unregister(st->clkin, &st->nb);
> +}
> +
> +#define ADMV1013_CHAN(_channel, rf_comp) {			\
> +	.type =3D IIO_ALTVOLTAGE,					\
> +	.modified =3D 1,						\
> +	.output =3D 1,						\
> +	.indexed =3D 1,						\
> +	.channel2 =3D IIO_MOD_##rf_comp,				\
> +	.channel =3D _channel,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_PHASE) |	\
> +		BIT(IIO_CHAN_INFO_OFFSET)			\
> +	}
> +
> +static const struct iio_chan_spec admv1013_channels[] =3D {
> +	ADMV1013_CHAN(0, I),
> +	ADMV1013_CHAN(0, Q),
> +};
> +
> +static int admv1013_init(struct admv1013_state *st)
> +{
> +	int ret;
> +	unsigned int chip_id, enable_reg, enable_reg_msk;
> +	struct spi_device *spi =3D st->spi;
> +
> +	/* Perform a software reset */
> +	ret =3D __admv1013_spi_update_bits(st,
> ADMV1013_REG_SPI_CONTROL,
> +
> ADMV1013_SPI_SOFT_RESET_MSK,
> +
> FIELD_PREP(ADMV1013_SPI_SOFT_RESET_MSK, 1));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __admv1013_spi_update_bits(st,
> ADMV1013_REG_SPI_CONTROL,
> +
> ADMV1013_SPI_SOFT_RESET_MSK,
> +
> FIELD_PREP(ADMV1013_SPI_SOFT_RESET_MSK, 0));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __admv1013_spi_read(st,
> ADMV1013_REG_SPI_CONTROL, &chip_id);
> +	if (ret)
> +		return ret;
> +
> +	chip_id =3D FIELD_GET(ADMV1013_CHIP_ID_MSK, chip_id);
> +	if (chip_id !=3D ADMV1013_CHIP_ID) {
> +		dev_err(&spi->dev, "Invalid Chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D __admv1013_spi_write(st,
> ADMV1013_REG_VVA_TEMP_COMP, 0xE700);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __admv1013_spi_update_bits(st,
> ADMV1013_REG_QUAD,
> +
> ADMV1013_QUAD_SE_MODE_MSK,
> +
> FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, st-
> >quad_se_mode));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D admv1013_update_mixer_vgate(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D admv1013_update_quad_filters(st);
> +	if (ret)
> +		return ret;
> +
> +	enable_reg_msk =3D ADMV1013_VGA_PD_MSK |
> +			ADMV1013_MIXER_PD_MSK |
> +			ADMV1013_QUAD_PD_MSK |
> +			ADMV1013_BG_PD_MSK |
> +			ADMV1013_MIXER_IF_EN_MSK |
> +			ADMV1013_DET_EN_MSK;
> +
> +	enable_reg =3D FIELD_PREP(ADMV1013_VGA_PD_MSK, st-
> >vga_pd) |
> +			FIELD_PREP(ADMV1013_MIXER_PD_MSK, st-
> >mixer_pd) |
> +			FIELD_PREP(ADMV1013_QUAD_PD_MSK, st-
> >quad_pd ? 7 : 0) |
> +			FIELD_PREP(ADMV1013_BG_PD_MSK, st-
> >bg_pd) |
> +			FIELD_PREP(ADMV1013_MIXER_IF_EN_MSK,
> st->mixer_if_en) |
> +			FIELD_PREP(ADMV1013_DET_EN_MSK, st-
> >det_en);
> +
> +	return __admv1013_spi_update_bits(st,
> ADMV1013_REG_ENABLE, enable_reg_msk, enable_reg);
> +}
> +
> +static void admv1013_clk_disable(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static void admv1013_reg_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
> +static void admv1013_powerdown(void *data)
> +{
> +	unsigned int enable_reg, enable_reg_msk;
> +
> +	/* Disable all components in the Enable Register */
> +	enable_reg_msk =3D ADMV1013_VGA_PD_MSK |
> +			ADMV1013_MIXER_PD_MSK |
> +			ADMV1013_QUAD_PD_MSK |
> +			ADMV1013_BG_PD_MSK |
> +			ADMV1013_MIXER_IF_EN_MSK |
> +			ADMV1013_DET_EN_MSK;
> +
> +	enable_reg =3D FIELD_PREP(ADMV1013_VGA_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1013_MIXER_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1013_QUAD_PD_MSK, 7) |
> +			FIELD_PREP(ADMV1013_BG_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1013_MIXER_IF_EN_MSK,
> 0) |
> +			FIELD_PREP(ADMV1013_DET_EN_MSK, 0);
> +
> +	admv1013_spi_update_bits(data, ADMV1013_REG_ENABLE,
> enable_reg_msk, enable_reg);
> +}
> +
> +static int admv1013_properties_parse(struct admv1013_state *st)
> +{
> +	int ret;
> +	struct spi_device *spi =3D st->spi;
> +
> +	st->vga_pd =3D device_property_read_bool(&spi->dev, "adi,vga-
> pd");
> +	st->mixer_pd =3D device_property_read_bool(&spi->dev,
> "adi,mixer-pd");
> +	st->quad_pd =3D device_property_read_bool(&spi->dev,
> "adi,quad-pd");
> +	st->bg_pd =3D device_property_read_bool(&spi->dev, "adi,bg-
> pd");
> +	st->mixer_if_en =3D device_property_read_bool(&spi->dev,
> "adi,mixer-if-en");
> +	st->det_en =3D device_property_read_bool(&spi->dev, "adi,det-
> en");
> +
> +	ret =3D device_property_read_u32(&spi->dev, "adi,quad-se-
> mode", &st->quad_se_mode);
> +	if (ret)
> +		st->quad_se_mode =3D 12;
> +
> +	st->reg =3D devm_regulator_get(&spi->dev, "vcm");
> +	if (IS_ERR(st->reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
> +				     "failed to get the common-mode
> voltage\n");
> +
> +	st->clkin =3D devm_clk_get(&spi->dev, "lo_in");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> +				     "failed to get the LO input clock\n");
> +
> +	return 0;
> +}
> +
> +static int admv1013_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct admv1013_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	indio_dev->dev.parent =3D &spi->dev;

not needed anymore...

> +	indio_dev->info =3D &admv1013_info;
> +	indio_dev->name =3D "admv1013";
> +	indio_dev->channels =3D admv1013_channels;
> +	indio_dev->num_channels =3D
> ARRAY_SIZE(admv1013_channels);
> +
> +	st->spi =3D spi;
> +
> +	ret =3D admv1013_properties_parse(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regulator_enable(st->reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified
> Common-Mode Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(&spi->dev,
> admv1013_reg_disable,
> +				       st->reg);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&spi->dev,
> admv1013_clk_disable, st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	st->nb.notifier_call =3D admv1013_freq_change;
> +	ret =3D clk_notifier_register(st->clkin, &st->nb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&spi->dev,
> admv1013_clk_notifier_unreg, st);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&st->lock);
> +
> +	ret =3D admv1013_init(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "admv1013 init failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(&spi->dev,
> admv1013_powerdown, st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id admv1013_id[] =3D {
> +	{ "admv1013", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, admv1013_id);
> +
> +static const struct of_device_id admv1013_of_match[] =3D {
> +	{ .compatible =3D "adi,admv1013" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, admv1013_of_match);
> +
> +static struct spi_driver admv1013_driver =3D {
> +	.driver =3D {
> +		.name =3D "admv1013",
> +		.of_match_table =3D admv1013_of_match,
> +	},
> +	.probe =3D admv1013_probe,
> +	.id_table =3D admv1013_id,
> +};
> +module_spi_driver(admv1013_driver);
> +
> +MODULE_AUTHOR("Antoniu Miclaus
> <antoniu.miclaus@analog.com");
> +MODULE_DESCRIPTION("Analog Devices ADMV1013");
> +MODULE_LICENSE("GPL v2");
> --
> 2.33.1

