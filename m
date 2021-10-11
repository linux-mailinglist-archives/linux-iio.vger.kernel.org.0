Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525474288F5
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 10:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhJKIkA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 04:40:00 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12924 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235042AbhJKIkA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 04:40:00 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B35236021605;
        Mon, 11 Oct 2021 04:37:47 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bm7b1andg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 04:37:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTLHN3ne2btzrZ4mtkxpGiJibCo2rIdSb3GBZoeiEPYfPNmbB9oaAopKJZDD0VNFGCb9SR7PYO0Hdq64iLg4LhsdyxGfsVU6odAxoAuJP0t//PJFf0DZrXqm+mYm/9ps7MZznhL1p8Ml1LeKgGyjWYczZ9dxrtHEZERs67uI2sNGYvcy8TON6QpDBT8IqhGf3+2AkwjCe4+NV5OEJRvRj/xFlqLCwpz6+NSOXZMoHBYe4VwsZbUrRVs7hnoB/8Hz3Xg5gugENthnWESfZc0YU4JSYR0I0B5IReyLDS6z4CP+kRoUZg4tMrZhE6L5QIp2k4NsC4YqVrU7Z4TE9yuj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qCCdjV+U5AAet/RvNqVvV3Gp4Z6nx/aArEN5/FpsLw=;
 b=Lavm2h2cG0zKaYJVG+LmiZF3rUOjF7lEgdNxM+CZZX9d3PEw3gkhOFEXHEWa7oqpSrClTqnhAtYD+g/iowsh/rn6BqGJcTr9Fb7FXjanfeRmK2HT64C34RbR7fKE9wLnL/c6GVVXTBRI74yD0dFQWjcYCGg0KyHd/pxt3l3DQC60Yu52P/SI7KSYqS9Rq1TAYIPTsZdXy7MZ8GHVf7jj/QsDX+O8Lsh4tnBM/NWq2AXHB3WVb/mTEZ0AOlRkudnvOC2kqfDlpcog90Pqq5poYk5Ut/NhSVbWQsOhJaONZMd+yPqQAGMXUquWgxvxI6U8WHTmHeGQV8ZsS3z+tPUOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qCCdjV+U5AAet/RvNqVvV3Gp4Z6nx/aArEN5/FpsLw=;
 b=yreHe0UcqOapvx5CJmWO97TIR3OHCLUKCy4hRQUSfnqtHcJiPdkhOQs05hN4XnHxk+xPqCu4Zc8GNGNLjRxiONIiw2+m4K4k6I4wvdlyqWRENE/nxV8qOlccOmCCNkCNlJcuGix7OK2nIV/0euIts6ATppzaWB4k5eBEt/5kNbE=
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com (2603:10b6:a03:2d4::23)
 by SJ0PR03MB5471.namprd03.prod.outlook.com (2603:10b6:a03:284::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 08:37:45 +0000
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4]) by SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:37:45 +0000
From:   "Chindris, Mihail" <Mihail.Chindris@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Thread-Index: AQHXvEGRIjsnpKblJ0WUOSy/0OdO8avMU2MAgAEpwAA=
Date:   Mon, 11 Oct 2021 08:37:44 +0000
Message-ID: <SJ0PR03MB5791AE72F7666812DFD726B299B59@SJ0PR03MB5791.namprd03.prod.outlook.com>
References: <20211008123909.1901-1-mihail.chindris@analog.com>
        <20211008123909.1901-2-mihail.chindris@analog.com>
 <20211010154856.29f4fd11@jic23-huawei>
In-Reply-To: <20211010154856.29f4fd11@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWNoaW5kcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy03ZmEzYzk2Yi0yYTZlLTExZWMtODQwMS05OGU3?=
 =?us-ascii?Q?NDNlYTZmNDhcYW1lLXRlc3RcN2ZhM2M5NmQtMmE2ZS0xMWVjLTg0MDEtOThl?=
 =?us-ascii?Q?NzQzZWE2ZjQ4Ym9keS50eHQiIHN6PSI5NzcyIiB0PSIxMzI3ODQxNTA2Mjgz?=
 =?us-ascii?Q?MTA5NzUiIGg9IkRvRmR6YWcrWndSZXYrMnFvKzlmam9TK0FEbz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Qy9ud0JDZTc3WEFXeW5UaFVIZExuYmJLZE9GUWQwdWRzREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 630f16bb-88fc-4072-9327-08d98c9265ff
x-ms-traffictypediagnostic: SJ0PR03MB5471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR03MB5471204143389E06A2B69B2399B59@SJ0PR03MB5471.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n6P4C11SnG6YeBhbMbok//kGqGkXHbpqKNxFcMKnI12zSU9lhGnhI9f68YKmC0K4TGKgcpxEmIBTbZMGILvcAEeZhCqbvBmISKYCJld2IMj0yiW/u2V6tsuLTx4lUW5+2P0Qb4esrWLtHK1FVM2uCtpN+MKPTVYm8eEvILLVYeA4GqhRtPVtD1DN1RxYiNc1r2vyrdY7OOrrVH28lYgnRtrUk7aCsXaD38o7xJToLfKsemvNLsRrj2CnXleYMKUiFi8Nuf+lr2ZfsZhQrju67MvjZlyHbu4MHh+Pw52iXKfGOOJNHlyJZdhdUDK5kBhPU3chpE4f+1F51NLq4aYTJnyox7k1EjGkMLJbalnhUzrUMVSoucepqt+IwIE/cZIom4zC+AGn4jaXPIPDvRyGkwjlBoQXuYWbYIGoU1Q4/pB4ARvYM4RXwG+t7CAGaI8uj+bkHNBQPwHCmVTNS7ddz3BbRjq64acI64aoO1DyI5NnUj+KTpnPujul38YYlqFwaEINaEU0Hmpj5WdBAdkOu4OKvdJJp21uJMNSK+eunNsjz3VsinsNlcMXwdH4Food+k7gkz6idDN4S0zqiHyqKFglJeE10D6JR1M0GR5oaXqs9n087lBrhFuBYrPenah+nWCearlu+Y2P016C2Xk6EBc9Qhs09N//X2elkZm6aPQxirrZz6pX+pzeylI3PSD1kz/ijYlFb3gFoItS9w87aF83dvXgeOl5iCP82QQEeJBjxCqQO3nbmBU4BUoydkVvgdTezwZtn0kFs+XQMYUnLe6Nw/GbLuo8BUicdBUeXHzuLDVc+YwxQEakXYQb78Ty8j7iNru4VLJdd/PBxehf5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5791.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(5660300002)(54906003)(38070700005)(316002)(33656002)(6916009)(2906002)(122000001)(38100700002)(53546011)(83380400001)(66446008)(7696005)(8676002)(6506007)(64756008)(4326008)(8936002)(66946007)(76116006)(66476007)(66556008)(966005)(71200400001)(508600001)(26005)(55016002)(9686003)(52536014)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SnJ4S5dgFtmRAr/JSU4lSs1DTi/3Q+tW5BtveUaOUhiwHpdlU2WGCEtn73PG?=
 =?us-ascii?Q?SOhuN1siBHQOozBlcfFVDXDgrnistTJfaKZr34VIRG8oCeESFLI7JyZdJEO8?=
 =?us-ascii?Q?iKLcWu4a1rP4vHf+CzvqPhD9xqpATp6TfRZ+BVOn0OjNCCdpd2OUsWK4lcEV?=
 =?us-ascii?Q?VdSUm9IMv6E4IT6UEo8/skI4hvGG+QDH7k3PklQSqT8ra3W1nQu6OnCuKUyh?=
 =?us-ascii?Q?Nz09e0KB6wpS2KjaEVtf79cuOtJnlcHKQB79tk5ZsUY779PLayuegg4HSOVf?=
 =?us-ascii?Q?tXUv7HOzud+bQj5m4ezgnDuPsd7KerAy08fEnCvrC5hvnoS39BGSBz6lt++F?=
 =?us-ascii?Q?eZ1xsVyw59kX806W9DTySF8w4Yz1fQu3j2AjNeyWMIvjnmCl/S350Pr/gwac?=
 =?us-ascii?Q?hgyRZ3BzkUfm/YqwBv/QLTwTP7e1wPZ3rDg5Zl/obvKYqf9kdDYDdcS8Jg5g?=
 =?us-ascii?Q?cOnC+ZfikhIrv+Tm/gEcdK4yukqhvy8BvnCk2U7kijlmPpa/vazqqTLuXYbu?=
 =?us-ascii?Q?EQ2r6xhFSaFYVwHxs64VnbD5bGXoqW4tNzAeeVdKzMNRRI+AdBhOkFIWjgZI?=
 =?us-ascii?Q?di9DfrEzW0/amEEUmEUx+PRUyxzY6ZU+myLB0ZSrdVbx3RPmDtMNS40VSPT+?=
 =?us-ascii?Q?mL8+eHht73m7laCIGGQmOXlqMUGX/1dJNntiN+9pBmnxHj4G+zF185m2U91A?=
 =?us-ascii?Q?entHE91nCjrMd6h66qQl1mIFuU4ecvClzUYn6rT/rIXtuCqcpa0OMmFbcgSp?=
 =?us-ascii?Q?qHUieQmKtjMs+qa2sG9QGZbd5hwbtOV4AvnXfHkg4xLwnPn3CP+Dt0STFK4H?=
 =?us-ascii?Q?bXDDtqr7DDvGtI1OsMt4pgSYFZAxuvDix8rdUl3E3HRYnIrF8d0MyfPWRheu?=
 =?us-ascii?Q?JN1W2G5QRJ5IEuF+Z3a5Eexp2iEunrQJYXUmxoYd3E4/Iq1XpcHSSY18cTVN?=
 =?us-ascii?Q?xgDFfSOfRsqKFnSwjtZMB+qNA6/ZC1cQe+SY6Gj5K5R5EtiMJjSdScZKUpNc?=
 =?us-ascii?Q?FAlv5dZmz77NebLvcp0aggzt7iSQDD7O/H9Uf0C3Q1mz0GblI3VpymEcSTNh?=
 =?us-ascii?Q?UMka8rleMR7WId8GC3mWxBj8YKus0kn80R+KCHB2BXFF8mBPD7Ca2GZGyF9z?=
 =?us-ascii?Q?dNiSW3nmfUt93A/WapyUShlVHF8ZM11mqYQu9lQ11Jg2Vg4XXx6Qfef0t3Ib?=
 =?us-ascii?Q?11259hX6UPywhltYSGGO9m33SSv9U1L5vrsmgBybZizgYi6VqTiZpu9sJA9Q?=
 =?us-ascii?Q?/i6tEVV01gLpNAf4zEI/rVMdT8nYjvsXuHH6mz5/B1gel/Kx2LrOHhV6c8/Q?=
 =?us-ascii?Q?ZzLFk7qucYOrr+XoD3+y57iq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5791.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630f16bb-88fc-4072-9327-08d98c9265ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 08:37:44.8820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fL7VzEXsYWsl7FHZbqYkrWAxTAl7JhFF22ZAHdR54uoiU3HySUV2a4PxwKsgF9asV7SEPC0GhujLGdurMYYS1pDhdQjEMVAH5Y9O14//uSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5471
X-Proofpoint-GUID: WKihA6_7KtVX--MOkMHXYWgARUYq2C-d
X-Proofpoint-ORIG-GUID: WKihA6_7KtVX--MOkMHXYWgARUYq2C-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110049
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, 10 October 2021 17:49
> To: Chindris, Mihail <Mihail.Chindris@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Sa, Nuno <Nuno.Sa@analog.com>; Bogdan, Dragos
> <Dragos.Bogdan@analog.com>; alexandru.ardelean@analog.com; Mark
> Brown <broonie@kernel.org>
> Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
>=20
> On Fri, 8 Oct 2021 12:39:08 +0000
> Mihail Chindris <mihail.chindris@analog.com> wrote:
>=20
> > Add documentation for ad3552r
> >
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> Hi Mihael,
>=20
> A few comments inline.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  .../bindings/iio/dac/adi,ad3552r.yaml         | 199 ++++++++++++++++++
> >  1 file changed, 199 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > new file mode 100644
> > index 000000000000..1086e935d330
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > @@ -0,0 +1,199 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright 2020
> > +Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/iio/dac/adi
> >
> +,ad3552r.yaml*__;Iw!!A3Ni8CS0y2Y!pqvd1NyV8G8KXIcfAtV1erPpylxLUGXD
> 1Tx5
> > +UoK2MMNNgQpv5RSyFb6NQDSL0sEuJOI$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/core.y
> >
> +aml*__;Iw!!A3Ni8CS0y2Y!pqvd1NyV8G8KXIcfAtV1erPpylxLUGXD1Tx5UoK2
> MMNNgQ
> > +pv5RSyFb6NQDSL3G5680U$
> > +
> > +title: Analog Devices AD2552R DAC device driver
> > +
> > +maintainers:
> > +  - Mihail Chindris <mihail.chindris@analog.com>
> > +
> > +description: |
> > +  Bindings for the Analog Devices AD3552R  DAC device. Datasheet can
> > +be
>=20
> Extra space before DAC, and doesn't mention the other supported part.
> One option to avoid a never ending list is "and similar."
>=20
> > +  found here:
> > +
> > + https://www.analog.com/media/en/technical-documentation/data-
> sheets/
> > + ad3552r.pdf
>=20
> Good to have datasheet for the other part as well as I don't think this i=
s a
> shared datasheet?
>=20
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad3552r
> > +      - adi,ad3542r
>=20
> Alphabetical order preferred.
>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 30000000
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  ldac-gpios:
> > +    description: |
> > +      If a LDAC gpio is specified it will generate a LDAC pulse each t=
ime the
> > +      trigger handler sends data to the chip.
>=20
> Trigger handler is a linux concept. You need to write this more generical=
ly.
> Something like.
>=20
> "LDAC pin is used as a hardware trigger to update a set of DACs."
>=20
>=20
> > +    maxItems: 1
> > +
> > +  vref-supply:
> > +    description:
> > +      The regulator to use as an external reference. If it does not ex=
ists the
> > +      internal reference will be used. External reference must be
> > + 2.5V
> > +
> > +  adi,vref-out-en:
> > +    description: Vref I/O driven by internal vref to 2.5V. If not set,=
 Vref pin
> > +      will be floating.
> > +    type: boolean
> > +
> > +  adi,sdo-drive-strength:
> > +    description: |
> > +      Configure SDIO0 and SDIO1 strength levels:
> > +        - 0: low SDO drive strength.
> > +        - 1: medium low SDO drive strength.
> > +        - 2: medium high SDO drive strength.
> > +        - 3: high SDO drive strength
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3]
> > +
> > +patternProperties:
> > +  "^channel@([0-1])$":
> > +    type: object
> > +    description: Configurations of the DAC Channels
> > +    properties:
> > +      reg:
> > +          description: Channel number
> > +          enum: [0, 1]
> > +
> > +      custom-output-range-config:
>=20
> Not a generic property so I think this needs an adi prefix.

I tried with adi prefix but I get weird errors while running dt_binding_che=
ck for properties with adi prefix and with type:object
Do you have any suggestion for this issues?

> > +        type: object
> > +        description: Configuration of custom range when
> > +          adi,output-range-microvolt is not present.
> > +          The formulas for calculation the output voltages are
> > +            Vout_fs =3D 2.5 + [(GainN + Offset/1024) * 2.5 * Rfbx * 1.=
03]
> > +            Vout_zs =3D 2.5 - [(GainP + Offset/1024) * 2.5 * Rfbx * 1.=
03]
> > +        properties:
> > +          adi,gain-offset:
> > +            description: Gain offset used in the above formula
> > +            $ref: /schemas/types.yaml#/definitions/int32
> > +            maximum: 511
> > +            minimum: -511
> > +          adi,gain-scaling-p:
> > +            description: |
> > +              Scaling p:
> > +               0: 1.0
> > +               1: 0.5
> > +               2: 0.25
> > +               3: 0.125
>=20
> Given this is just a mapping to a simple set of values, could we just hav=
e the
> values or express it as 1/(2^GainP) in the equation above and call it
> adi,gain-scalling-inv-log2 or something like that?
>=20
> If we can avoid a mapping table that is always a nice to have
>=20
>=20
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            enum: [0, 1, 2, 3]
> > +          adi,gain-scaling-n:
> > +            description: |
> > +              Scaling p:
> > +               0: 1.0
> > +               1: 0.5
> > +               2: 0.25
> > +               3: 0.125
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            enum: [0, 1, 2, 3]
> > +          adi,rfb-ohms:
> > +            description: Feedback Resistor
> > +        required:
> > +          - adi,gain-offset
> > +          - adi,gain-sacling-p
> > +          - adi,gain-sacling-n
> > +          - adi,rfb-ohms
> > +    required:
> > +      - reg
> > +
> > +    oneOf:
> > +      # If adi,output-range is missing, custom-output-range-config
> > + must be used
>=20
> adi,output-range-microvolt is missing...
>=20
> > +      - required:
> > +        - adi,output-range-microvolt
> > +      - required:
> > +        - custom-output-range-config
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,ad3542r
> > +    then:
> > +      patternProperties:
> > +        "^channel@([0-1])$":
> > +          type: object
> > +          properties:
> > +            adi,output-range-microvolt:
> > +              description: |
> > +                Voltage output range of the channel as <minimum, maxim=
um>
> > +                Required connections:
> > +                  Rfb1x for: 0 to 2.5 V; 0 to 3V; 0 to 5 V;
> > +                  Rfb2x for: 0 to 10 V; 2.5 to 7.5V; -5 to 5 V;
> > +              oneOf:
> > +                - items:
> > +                    - const: 0
> > +                    - enum: [2500000, 3000000, 5000000, 10000000]
> > +                - items:
> > +                    - const: -2500000
> > +                    - const: 7500000
> > +                - items:
> > +                    - const: -5000000
> > +                    - const: 5000000
> > +          required:
> > +            - adi,output-range-microvolt
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,ad3552r
> > +    then:
> > +      patternProperties:
> > +        "^channel@([0-1])$":
> > +          type: object
> > +          properties:
> > +            adi,output-range-microvolt: |
> > +                Voltage output range of the channel as <minimum, maxim=
um>
> > +                Required connections:
> > +                  Rfb1x for: 0 to 2.5 V; 0 to 5 V;
> > +                  Rfb2x for: 0 to 10 V; -5 to 5 V;
> > +                  Rfb4x for: -10 to 10V
> > +              oneOf:
> > +                - items:
> > +                    - const: 0
> > +                    - enum: [2500000, 5000000, 10000000]
> > +                - items:
> > +                    - const: -5000000
> > +                    - const: 5000000
> > +                - items:
> > +                    - const: -10000000
> > +                    - const: 10000000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-max-frequency
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ad3552r {
> > +            compatible =3D "adi,ad3552r";
> > +            reg =3D <0>;
> > +            spi-max-frequency =3D <20000000>;
> > +            channel@0 {
> > +                    reg =3D <0>;
> > +                    adi,output-range-microvolt =3D <0 10000000>;
> > +            };
> > +            channel@1 {
> > +                    reg =3D <1>;
> > +                    custom-output-range-config {
> > +                            adi,gain-offset =3D <5>;
> > +                            adi,gain-scaling-p =3D <1>;
> > +                            adi,gain-scaling-n =3D <2>;
> > +                            adi,rfb-ohms =3D <1>;
> > +                    };
> > +          };
> > +      };
> > +...

