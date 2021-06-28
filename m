Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579163B5983
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jun 2021 09:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhF1HMG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Jun 2021 03:12:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52604 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhF1HMF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jun 2021 03:12:05 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S70oLV014175;
        Mon, 28 Jun 2021 03:09:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 39dx376rtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 03:09:21 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15S75TlF020615;
        Mon, 28 Jun 2021 03:09:21 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 39dx376rtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 03:09:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpikGizWr1B56dwLIsw8L0bWHAn7Q21q8KHHrU5yv3nGlgWCwApb76NHYWnOoUmTn3cto+toVusXtUUFfeYM0XzZe6wYxgzX3qW18Uh8vsdZuTdO4L0/TzH5FlT9M0wDqDYuPsg5g15WYiuxcr0wvN6k6+8/se9prOfgtpmRGa811QP4z17sdN1I3lWeWYM6tHaX8luC43V52gmNuFqYNFnwyWV3Fe+xC1MV7084+4UUXNQA0YfzvKq/XGzj8mjWGcgOuJHmPuOpuOrgq16spKfFxl9lr0ZwBEIzGDHIqgI9vZPN4e8Mr9P2HAgsAYBmdYDIXZUrN8YpYoFeVLITIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emjkQa3XJtSngh6HCXJUxuXLPGE+w24ybImbZDoB644=;
 b=CBoTd7KBR1e+RnDw2RKV4GQbUceq0r4T2ziTfEQFTVP9B6dAqds81e8dVhWILNgoy6LaUs8buRrkhUF6rVrQR+BldFobYND0P/7H7PTsn2R2QUiCOahsitMWdOtmLs8ss0So2KnC0sYiRKEY5bxwKuhCyvpvPSsvgilDyz+961FgawogjrF/MKy666ynmOwpO8DzFP39wwR7kc1Wg9PWINRTMWGg4FzbLUTGwsdMtMZkjtxpFjHM2lOS1xdjCN0Z7etQ2UtIuHolf391w2PacpKUqSvJmlpNl8/rnJmJDGBfJ0/BAS+kt8I4ubpQ4Mr37vy2loMCGrqTCRjcq5nm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emjkQa3XJtSngh6HCXJUxuXLPGE+w24ybImbZDoB644=;
 b=wR/AAiMkqPjHC80gvFHCNfMo4bpRK2RhRP6kOCu/11Cxx79Rdxa8fNHNCPBPoBOU4bgK9Y9qu0Nv4z9m5drd35LW7ZZFe8HaAaZ7AS0Vrd7sK9er2bx6CxrFi+1yyZroP+1oBTwQmse+dVB133fxm4XUDY/JMJszd+UyJfrIcbc=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5765.namprd03.prod.outlook.com (2603:10b6:510:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 07:09:18 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Mon, 28 Jun 2021
 07:09:18 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ricardo Ribalda <ribalda@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        Michael Welling <mwelling@ieee.org>
Subject: RE: [PATCH 00/15] dt-bindings: iio: dac: Add most missing binding
 documents.
Thread-Topic: [PATCH 00/15] dt-bindings: iio: dac: Add most missing binding
 documents.
Thread-Index: AQHXa3HH5fUld04HWUaH046H0XvfkKspANng
Date:   Mon, 28 Jun 2021 07:09:18 +0000
Message-ID: <PH0PR03MB6366F34DC0B3D7EB7A56B6A499039@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210627163244.1090296-1-jic23@kernel.org>
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYzAyZGQ2NGYtZDdkZi0xMWViLThiNjgtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGMwMmRkNjUwLWQ3ZGYtMTFlYi04YjY4LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMzA4MCIgdD0iMTMyNjkzMzc3NT?=
 =?iso-8859-1?Q?c4MTIwMTE2IiBoPSJyQU8yZytYRzE3S0FRbmpwdzVONEJEeW9yV2c9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUMwTTVlQzdHdlhBYnRJdUZQSit2SzV1MGk0VThuNjhya0ZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQUJPWUdjZ0FBQUFBQUFBQUFBQUFBQUo0?=
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
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCaEFISUFhUUJoQUY4QVpBQn?=
 =?iso-8859-1?Q?BBR01BZEFCcEFHOEFiZ0JoQUhJQWVRQmZBSFFBYVFCbEFISUFNUUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBY2dCcEFHRUFYd0JrQUdrQVl3QjBB?=
 =?iso-8859-1?Q?R2tBYndCdUFHRUFjZ0I1QUY4QWRBQnBBR1VBY2dBeUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?iso-8859-1?Q?Q0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:24bb:8901:ddf8:6a82:bd3f:ad32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0625f3d1-3d59-485e-39c6-08d93a03a552
x-ms-traffictypediagnostic: PH0PR03MB5765:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB576556729347FBF4D6AF91F099039@PH0PR03MB5765.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wGLmt5LO36ZSYwcaLaodr39DGmhPEfmbn8oPsxG96uLTwHDnsWC6Xg12Z97IH27n+AVZN3ZL2ixTjCR3iqdXAPVnhFYDYx8E+e7FOJGu3fwn7dTnUd4jlxWhCzqLxdVtVRjY0Noea4j/fNjvGNmR2lkdlkKJ9Eg1zEwNyZt4Ytscikn+P9R2ai8ISfu1g/LBWDO6AoJueMkZAGBsXgaNV+ow5iN0Rl8jh91arkUiM2pMLx+P02wE83NWVdQcoNVctq+8KBXzC5xCzCGfPGarS8rVdmSwIOVGA4pBvqlppu0RPitydrfrZusRBj4wC21N8LKsy3GWmLwcIYPT+QcsJwi8hOm6b2eWVO3SJyKLfV8b3NhDwte6SaJlrVEOWd0DfM6KSQbUHONkIaTEfGIRqzpKMBEQuDni3AtESc+2aDpdYuIN+SKX09ueXWy1KiwWXEQGGXF8hURL9V0onK3AcNJTxISiCdUYADmo0rKaO2JGMNi8YVMG2b+77faRwQ6dbvBL4j8fU5+ITCZSD+jUUehmhnBg+Mj5Dg+/hpe1p0eV3xKl1Vp09OS8dKGycggjaXNYuPHDKE7cRfQHtuH+2sBSBkdxn+6CJqigXERkV0Bycjr7I558uVtVfN2AChcH306y6s8+2I26Xn6tjvHPPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(86362001)(76116006)(71200400001)(8676002)(2906002)(55016002)(4326008)(186003)(9686003)(66446008)(110136005)(122000001)(83380400001)(38100700002)(64756008)(478600001)(316002)(52536014)(8936002)(66556008)(6506007)(66476007)(7696005)(53546011)(66946007)(54906003)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tm/vNCh6Q4oB7STNv9mzF8Myi+8u0IOMjX5LQpThZ1p57JfBIxbT+1VA4W?=
 =?iso-8859-1?Q?JOzo/8EMzQcPRwUDMGL2R9bMb0tcBvwfM0dguQ78zdaFKAvMDeaAn1BwbM?=
 =?iso-8859-1?Q?g+mGAT4XW3uYIYlQ1xyfCRTyVn7Jc9KJDLQiNDNp+CP/ZVdnJCwr79Ty8n?=
 =?iso-8859-1?Q?ob72xzURB5VYgV0sZ9ZEljgZ2s1x90/KNYITflgezDp/yPIs9FBx6gmP5v?=
 =?iso-8859-1?Q?GBseVxgWQx96/z8itPdA7GrVMTx5DHdzMf3D1x9JoZoCI4rcetbCrg+Tzz?=
 =?iso-8859-1?Q?VxSx9oJUEB2I11/pUckD9u48Yrtc/6aIaPkeixKayULJun4CPkbiH849vW?=
 =?iso-8859-1?Q?0Ikb0xITJdo3cYHwFsln/Ad6F6jJQsbqvZoN1PCXx3HQ/De3Hw764xSsIt?=
 =?iso-8859-1?Q?6m2JUXbsJIWmfDyYefFrjiDJkMzXeVT9si5Fbo+3KtDvNAfrW7aA9oW50J?=
 =?iso-8859-1?Q?pLJrsH5OLn3ldezOD6vd81Dw4druaVAjRnmDm12WNpcRN8xqG2oyN+SIyU?=
 =?iso-8859-1?Q?JQyYX+zwFkfLFCPHYcI+M8z4fhFu/JrtD/QXWzbQ9pSWeUHz4t8+FXUGQN?=
 =?iso-8859-1?Q?mxLbBrb3r9TwxsM1QOwgdItKsnzYFrMbMo6iXY7bT2ABgL1PZdjw9xPuqW?=
 =?iso-8859-1?Q?4/8me9xjGYEx1//bzBHsAGxQPk7hZmPW2D1YcUY78HlpPWhidJtdysxzBb?=
 =?iso-8859-1?Q?6DlUcSiQWmjYrZNyhBKDTLaqNzuSTj+ApgHVFthMzsTBuilAfpFI/TZuF0?=
 =?iso-8859-1?Q?pKa5Z+FOYgFkBskOUDGxj4aHUZpXhM1j0ZwFZfYlr7vTuIXJm0h/r2L9ec?=
 =?iso-8859-1?Q?NaOEJCDNqc8s5mLs2Di8HKJ+ZW7JOpzxiaj0L+ghULwyj0S0nMNC5sZPqB?=
 =?iso-8859-1?Q?p+c6Do+A98Zl86qe2+VSZ3mtSl6tm984Ox4/hqQq3zAoNI4qLERdEm/7CN?=
 =?iso-8859-1?Q?R2E2dMyQXOS3yKMCUCEwhMjIS4SOI4GRT5K3rKRowGsYZmVCe5G/yCSA87?=
 =?iso-8859-1?Q?LCyZO9zqJtgORwwAIxtJk1LxkVf6sxfa5cGvs4ayx/5EhO5HaQoRsmJxbX?=
 =?iso-8859-1?Q?smNJcMfEq2DttAlX9YlXXVup/S0JIADpNeK1/GbE92RS7D98+Q6ZafBLOb?=
 =?iso-8859-1?Q?TfGE0Z5lIM0LRlKi8l6DrBUs1ufrsdH8bagWwuoSUysCaFgy5+2OIG58lt?=
 =?iso-8859-1?Q?1aYWBBLs2KqR/2TZUT/+0aXzE2JPMT1UJ9xuK9nVxcKeiRpydYGCaNgMK8?=
 =?iso-8859-1?Q?hkINuBfjFTdNEqlOM8DVrwZvnLXajKhibWmWu3V62OZ7Per6QE4aE4MZnq?=
 =?iso-8859-1?Q?0uCT8HDWx2OF56FRD0Ar0rZ4xEf9PXOsdDihvbQEnnElq47T6dno7aq3cB?=
 =?iso-8859-1?Q?spIfR7WEcUalCvX9/PwzlsEzovN+HOUEbTDUP559rgLdumW81YkvA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0625f3d1-3d59-485e-39c6-08d93a03a552
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 07:09:18.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hrS9TydoFLc5X+F/Usjax+eueP3hr+EubFi5+J+ynUCvpO//P4b8PCV73OfirlwqtVUXe/R+kradfSBasOtBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5765
X-Proofpoint-GUID: zQEQ3bqSnehb8fuKnqqwQ-OIs-0_-XIv
X-Proofpoint-ORIG-GUID: ti_aUdhADR5v1InoKsoyXI1GrugiAO4c
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_05:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280049
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, June 27, 2021 6:32 PM
> To: linux-iio@vger.kernel.org; Rob Herring <robh+dt@kernel.org>;
> devicetree@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Lars-Peter
> Clausen <lars@metafoo.de>; Ricardo Ribalda <ribalda@kernel.org>;
> Hennerich, Michael <Michael.Hennerich@analog.com>; Gwenhael
> Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>; Michael
> Welling <mwelling@ieee.org>
> Subject: [PATCH 00/15] dt-bindings: iio: dac: Add most missing binding
> documents.
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> We have quite a few drivers in IIO that date back to the days of
> platform
> data.  Many of them either worked out of the box with device tree
> due to the spi core using the spi_device_id to match against
> device tree compatibles, or were updated to use newer interfaces in
> the
> intervening years.  As such, they mostly 'work' with device tree but
> can have some slightly odd quirks (particularly around naming of
> supplies).
> As we have no way of knowing what is out in the wild, we need to
> support
> these interesting bits of regulator naming.
>=20
> I would ultimately like all such bindings to be documented both to
> facilitate
> automated check of device trees and to make things easier for people
> trying
> to write device tree files using these devices.
>=20
> This series fills in the majority of the absent bindings for DACs.
> There are some outstanding
> * max517 - some platform data configuration needs porting over to
> device tree.
> * m62332 - this passes a consumer mapping in as platform data and will
> need
>   careful porting over the dt way of doing that.
>=20
> There is one 'fixlet' in here for the driver to deal with a case were the
> code was intended to allow the presence of a regulator to dictate
> whether
> an internal reference was used, but did not use the optional regulator
> get.
>=20
> I've mostly nominated maintainers based on original authorship +
> where
> I was feeling guilty or couldn't find anyone still active I've listed mys=
elf.
>=20
> I got bored half way through of producing brief descriptions of
> the devices so stopped doing so. If anyone wants to provide one for
> these
> parts I'm happy to add it!
>=20
> Future series will cover the c. 40 bindings that I've identified as missi=
ng
> for other types of devices.  I've also kept notes of easy cleanups in
> drivers spotted whilst working these out, so will probably follow up
> with
> those soon as well.
>=20
> Note I haven't tested all of these so there may well be errors or
> elements
> I've missed.
>=20

LGTM... Just wondering if we could not add the adi,ad5421 directly into
the trivial-devices yaml as it looks to be the only one without any odd
regulator name?

Anyways, feel free to add:

Acked-by: Nuno S=E1 <nuno.sa@analog.com>
