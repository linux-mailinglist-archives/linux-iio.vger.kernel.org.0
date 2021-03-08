Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52F0330F01
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 14:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCHNSg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 08:18:36 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13394 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhCHNSC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 08:18:02 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128DGFNu003369;
        Mon, 8 Mar 2021 08:17:47 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 3747h9cbje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 08:17:47 -0500
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 128DHlHn004555;
        Mon, 8 Mar 2021 08:17:47 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00128a01.pphosted.com with ESMTP id 3747h9cbjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 08:17:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cThC7qunjz5K3rrJfdGm7FnGCO2JkW9/gL1xBf92qnap81QsXvL5RaauuRJZuNfoE17NRkjknZDbm/+PN6Seh88xUR13C9IXCVsi2nYs5T37llCsdT7pXwQ23KFqpYd76G9SmNjlSKmFCh/9spXqlhSSH/SbQ43Ofpyi4vm5fiX/NVUZeZ3DmApCFpz5+zzqK0ueLO768iIkwQRvNKRlRwH63IZWq9dEuGYBfWXeXLV8wX79tJU3s6QGGPqqMWyzYm3Jva0gujhv0PCqgrYjvv6uu6ZUtE1JwRWov8kYWSRensVMEYkjV6vGyPuGrwr4gV3IvHDT3ZqrupXMNdQzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIacBxeKpxgzz+dHrBFl8YLSp1AAT8JWFk4enpwulD8=;
 b=TsJjiGibo3sLb3vAxml5swQq66BEYj1Unvo+4JTc0YSVUEP5w/YFaBHKJyOVAaWNc2sw+MvkDcnnHmBzIasgjY4kYfWVhSoj80bwl/6z7h0qWxywGGsn7GAGsSUHjEWB1BiYwOrwD3/WIFf1LJMUgjbDu9/69Wlb66TmfWGoey22Pf/g8t3aRhHEAVd8azZYDocyCO8ZSulF9TfElbumUSlcJpU4izhX4YXdissc9H5sa56CPrEPRoReBzyHGLHnzah5PXEpBsnl6IIt3QWQIXVaiLf0EmclpiVhLFTKEkxh4S06ixsM5qiK+XLM6x66/28aixaOLb5wD3S/1I0pbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIacBxeKpxgzz+dHrBFl8YLSp1AAT8JWFk4enpwulD8=;
 b=lfu+WN8coiSIKkHik6l2AUcJSLOiY6s5I3lz1RoXO6LfqWTijXO1ZssIc6JNrIfu+aZNGLliO8PYKLZMijV2G5hlfJdILJErbbJfqt2Ch/P5u43FGaSo6gXw9J5q/s8ZntQPd6j3701eWVdWU2dEE0s69fHTo4WVoty5JsyTDiA=
Received: from CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:74::18)
 by CY1PR03MB2299.namprd03.prod.outlook.com (2a01:111:e400:c611::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Mon, 8 Mar
 2021 13:17:43 +0000
Received: from CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::b439:cc16:d1ec:1c5e]) by CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::b439:cc16:d1ec:1c5e%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 13:17:43 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "zzzzArdelean, zzzzAlexandru" <alexandru.Ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH v3 0/6] iio: Add output buffer support
Thread-Topic: [PATCH v3 0/6] iio: Add output buffer support
Thread-Index: AQHXBrxjq9QBbWMRtka/kQD4wV/AUapihP4AgBKolACAAiL4gIACpXPggAAfcoCAABE7cIAABlKg
Date:   Mon, 8 Mar 2021 13:17:43 +0000
Message-ID: <CY4PR03MB26318D0C0553CB04E53DA21299939@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
        <20210221120106.00ae1078@archlinux>
        <BN8PR03MB497724AAAFA43E6555554DC98E969@BN8PR03MB4977.namprd03.prod.outlook.com>
        <20210306173449.06f2f32b@archlinux>
        <CY4PR03MB26318300B44C07A5890067B499939@CY4PR03MB2631.namprd03.prod.outlook.com>
 <20210308115203.00006230@Huawei.com>
 <CY4PR03MB26318FE58CDB5301224EAC9399939@CY4PR03MB2631.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB26318FE58CDB5301224EAC9399939@CY4PR03MB2631.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYTg4ZjU1M2EtODAxMC0xMWViLThiMjQtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGE4OGY1NTNjLTgwMTAtMTFlYi04YjI0LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iNDA1OSIgdD0iMTMyNTk2ODMwNj?=
 =?iso-8859-1?Q?E3NTM2NTg1IiBoPSJERzdEZ0lKbFZ2clBCOVFiaDFKN0c3OW5LdEk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUJKQ0UxckhSVFhBVXdVM1JDUnl6Zi9UQlRkRUpITE4vOEZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQWJKUFNkUUFBQUFBQUFBQUFBQUFBQUo0?=
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
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:24bd:6c01:a1f5:689b:a546:7acf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b2ce7b2-b2cc-4a32-e675-08d8e2348eca
x-ms-traffictypediagnostic: CY1PR03MB2299:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR03MB22994193B63D3F23031FCDD699939@CY1PR03MB2299.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yxXKrvZjcMqYfggPsnuAVSZ96sKOOKaPsYNvPFgoYRHYn12coDnUaITAxoZ7PsvqWO2LqIIDUPpd1aciSb/m/k+qxDSmrr9/t3LCD0lmCb6BEaP017301w6K0YrXxI9h+Gvf6IQtBE7urh7OFaj1IIfkk/nZamD7cJqWA0mBM3u40N7xvxv6UQhtWyTBvfTyuFicjnRlFCq3ZDbmEEG70qhPKOHSKaHsPIVtG58dcA5Vw4I6TVftkC1bFCFDRNlJDwBQxgAXwJ+6XD9F3K2QYSnWHy13VeUFb/Bwz+8E7DHClIgNso8IXKX1OvOWHNY39ViiFsPlg03kZbDMmYDyMariomAkXA6D7bx0rHaV1abM6DC25StJ4I0ebTnFrelQJuJhXdGs/ui6BWO7jCuseHYUS8I/bBtO4h0Qvq40X1lRjl7meqF1fYkj3G4BUkXDs8n+cJ/lxkKsGdQdlR3stvgEGKPNn9p12UQk3cfMamTuW6S6RK/XzW0EY6LedvlLuNOVLVemtMoU108/527yMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2631.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(52536014)(55016002)(478600001)(66946007)(66556008)(66476007)(186003)(5660300002)(71200400001)(2906002)(107886003)(83380400001)(2940100002)(66446008)(64756008)(9686003)(8936002)(4326008)(8676002)(7696005)(316002)(110136005)(54906003)(76116006)(6506007)(53546011)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?112YDWpR5MVMkmTk0qDx5lALPEXKtnc1Avabgt/4VySZA6iThSkBpbcaU4?=
 =?iso-8859-1?Q?30D5Dytn4pysDDdGHwGE2qvEZ0iOcOD3XFISmMzpNC8bEv5fZIYF8Pmlom?=
 =?iso-8859-1?Q?GXcZRZrO4+YebaeXZWB8pGXsgzKCVQlfHC4UjSKKAcOWRIGOZczmt7NcyG?=
 =?iso-8859-1?Q?aQueP17bbmvX1qg3Yo/QJ6Hlbaq1L6kWy5AeM1X5wQV8U/ZdTnQyjljQOB?=
 =?iso-8859-1?Q?IVvtVXkgi8BW7RJaPvv29jV87BXXSMcQHzdry2pqoCuP69+q9TpqtkCsex?=
 =?iso-8859-1?Q?hagZgTPT2tBW793LT3NCEVAVT+M2KQOH4niX+R4nsFQz8K/DkgzHtXW9yg?=
 =?iso-8859-1?Q?5HFIfl39MB0Ffgi2D49JI6oxYVwSr+K1wG9HO5aVvF+FanK9HuGA0x54q2?=
 =?iso-8859-1?Q?pSfFuacF/MzBaknH7tsEMw5x+K3J2XbOG85yK6h9q7eYwb9cfonCUbNlwf?=
 =?iso-8859-1?Q?azF1/45wAp1IcblpM9NSAJpnL73UC3GtID8f3PxVwu4JbNuuAlpl181qIk?=
 =?iso-8859-1?Q?9GuPt4IS6ZijKztJQSRrapd5FUonNHjN6GLN3U9z1h5P42wtJ5kyqBNCJl?=
 =?iso-8859-1?Q?Zz1vOg2ixTx3s3TorCiBEme01N/H1ZyZt82w5pA1zYRtX1E7H7nnB0mvVZ?=
 =?iso-8859-1?Q?sOxv+pHrYG3KGQLagSG8b9ZBwpqBXYY2tfMDe/HARdIUg32OcP1SEFeMa3?=
 =?iso-8859-1?Q?B69sTFqxXr0/R6HDCI9p1sC0gPrks1WJMR5qQlzZjpjv56GPIaW/H5pGVs?=
 =?iso-8859-1?Q?AZSLjJsbj/GQ+wV+yWOb38RHEXvYjtK/gAnvcgim3NAse8ZL45AtM5Pt+F?=
 =?iso-8859-1?Q?Dz7eNLmPuXr04IZLh/2+GjGFd3uOkAeyYyA23xs7qlOPDOGSDyHYXw9uC5?=
 =?iso-8859-1?Q?WO9Obqj3/0RI6KR5Qid8B8xeBaIUyuQ71Oz9+eaQ/M1OZ5VGCetcrS6Wy2?=
 =?iso-8859-1?Q?6xL+xkHoQjLYsTZeK22MY5m9hle5kAO49G2cMEKLiTRJfkUx+vM89ryW/M?=
 =?iso-8859-1?Q?VjM6JHCx//h7zVx9uVD9s5bwoWu3jPdvBHX6TqdE1Yq8TFwUrTBCBKwzKT?=
 =?iso-8859-1?Q?yDC+Y7wPFh3bZVcWFNoe/PQ9GRiEJcdBC1b9RHnw5RX5tUPthPAJ7wpKoU?=
 =?iso-8859-1?Q?TbcOspvjP8iClnxkIV/OdZXhX1Nhmxum4D5A2LbZ5g/5+30hlHJlT6L03x?=
 =?iso-8859-1?Q?h+xR8V0hFwg4HkQmL8ISykdWuUwWh16y6VMvyyTtzmGnKXfiNpVj2/zbH1?=
 =?iso-8859-1?Q?QB02cq7Ubepr5MkiBF+QMzxjM5MILNYcXIX/JbVaX1ySVyIXSNLddvO8Hf?=
 =?iso-8859-1?Q?3QRj3+FSzssQuzDIT90148AdciVm4mk8Fo1UAEOTKBDzrSW8E3R8NU6ZXZ?=
 =?iso-8859-1?Q?AsNYMO4vWWNTY86BgWyR9V3Izk1UQ40kBayywBWTTmqnxruWZ6RoByhFG0?=
 =?iso-8859-1?Q?XIeV/C6MbmdtBGvH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2631.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2ce7b2-b2cc-4a32-e675-08d8e2348eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 13:17:43.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8TNLz/BJFvjtRbNMTenJ07aBAEUeRYY6JNiNzsZIpTXkpQscAwjhNgfinVdcGvkzvXqzARaM+YbdDq+lPaJgyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2299
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_08:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080071
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Sa, Nuno <Nuno.Sa@analog.com>
> Sent: Monday, March 8, 2021 2:01 PM
> To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>; Jonathan
> Cameron <jic23@kernel.org>
> Cc: Hennerich, Michael <Michael.Hennerich@analog.com>;
> zzzzArdelean, zzzzAlexandru <alexandru.Ardelean@analog.com>;
> linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> lars@metafoo.de; Bogdan, Dragos <Dragos.Bogdan@analog.com>
> Subject: RE: [PATCH v3 0/6] iio: Add output buffer support
>=20
> [External]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Monday, March 8, 2021 12:52 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>; Jonathan Cameron
> > <jic23@kernel.org>
> > Cc: Hennerich, Michael <Michael.Hennerich@analog.com>;
> > zzzzArdelean, zzzzAlexandru <alexandru.Ardelean@analog.com>;
> > linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > lars@metafoo.de; Bogdan, Dragos <Dragos.Bogdan@analog.com>
> > Subject: Re: [PATCH v3 0/6] iio: Add output buffer support
> >
> > [External]
> >
> > On Mon, 8 Mar 2021 10:07:05 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Saturday, March 6, 2021 6:35 PM
> > > > To: Hennerich, Michael <Michael.Hennerich@analog.com>
> > > > Cc: zzzzArdelean, zzzzAlexandru
> > <alexandru.Ardelean@analog.com>;
> > > > linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > > > lars@metafoo.de; Sa, Nuno <Nuno.Sa@analog.com>; Bogdan,
> > Dragos
> > > > <Dragos.Bogdan@analog.com>
> > > > Subject: Re: [PATCH v3 0/6] iio: Add output buffer support
> > > >
> > > > On Fri, 5 Mar 2021 08:57:08 +0000
> > > > "Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:
> > > >
> > > > > Hi Jonathan and others,
> > > > >
> > > > > With output/dac buffer support the semantics of the
> > scan_element
> > > > type may change.
> > > > >
> > > > > Today the Format is
> > [be|le]:[s|u]bits/storagebitsXrepeat[>>shift].
> > > > >
> > > > > While shift (if specified) is the shift that needs to be applied
> prior
> > to
> > > > masking out unused bits.
> > > > >
> > > > > So far so good and it sounds universal.
> > > > >
> > > > > However, we use the right shift (operator) for that, which
> makes
> > > > sense for capture devices.
> > > > > For output devices the more logical operator would be the left
> > shift.
> > > > >
> > > > > I'm not proposing a new Format here. I just want to get some
> > > > agreement that for an output device
> > > > >
> > > > > le:s12/16>>4
> > > > >
> > > > > is understood as a left shift of 4, since the unused bits are the=
n
> > on
> > > > the LSB.
> > > >
> > > > Good question. Guess I wasn't thinking ahead when I came up
> with
> > > > that :)
> > > >
> > > > I'm not sure I'd mind if we did decide to define a new format for
> > > > output
> > > > buffers. Feels like it should be easy to do.
> > > >
> > > > What do others think?
> > > >
> > >
> > > I guess the most straight forward thing would be just to add a
> 'shift_l'
> > variable
> > > to 'struct scan_type'' and make sure either 'shift_l' or 'shift' is
> defined
> > and then
> > > properly export either ">>" or "<<" to userspace?
> >
> > Given we already know it's an output channel, can we not just use
> that
> > to make the decision?
> >
> > Jonathan
>=20
> I would argue that having two variables gives us more flexibility for
> whatever
> the future brings us :). But if we can sanely say that an output buffer
> will
> always use left shifts, then we could definitely use that information... =
I
> mean,
> we are already doing that assumption for input buffers and right
> shifts...

Hmm, giving it a bit more thought I think you can disregard the above.
Using the information that it's an output channel should be more than
enough...

- Nuno S=E1
