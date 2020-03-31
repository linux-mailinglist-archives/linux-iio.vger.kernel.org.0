Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD961999B2
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgCaPbH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 11:31:07 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5462 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730391AbgCaPbG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 11:31:06 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VFTqdL006351;
        Tue, 31 Mar 2020 11:30:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6j2t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 11:30:48 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02VFUmH7007511;
        Tue, 31 Mar 2020 11:30:48 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6j2t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 11:30:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKFq9EJ0okVQwXuCuO61+k75XplUd0OLsxlgvQvpJINdqgF7GQd5xz+V/DfXK5Mrmkbv/uDXeo6vzehMzHAakqHeNC5Ap2c7ZeWR702mak4vpayEzn6hHCq2SRQBQ4P+v3zGu3wB4GUm/Kh9dFgLt5Qu3jphMBk3nIWORnSj+XPmS3BA1XlessutNqBH8oM+she+qD8T/5rGI4IQ1+WZrYyc+2Dp4/yl0RK6+ru/Q6nM45aUb/eRFHrj6mbxX7Zr8xabFkFlGEfuqribiyLlX+99tAPoH8qZlZMmlQmI7EXm/SrOiJFfx6PD4Bb1SdhJryM48mlxuVwXuKnq2lXwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xin5BUtgFHdwhbaYR8h3fNf0HAWCEq0jm93YOdanraU=;
 b=YGKz3qkUlShskkleckloF3GpJ98mhLc/Q+WGAffTLKPXQblcUPVy/Ng7Vu7N1rybDFlnNmcZcVEDXhYZ9VaTeC3yhgmgfohULZZri81c3d6NqqdAzVMNdVCey+rTqz56XNzrOPaQpNy2R0j48pkVoeP2RWJ0/YjWpzoA0UAkykPdNf2kHfk+C9PJCFF1kart2Gme4q35wI9q4UTEwED1KAXWePJbD/r+PW/aQGQ/RK+2qRYHuPe7/jwOcHcnI/jO47Wjjw6VpGIcHy3os/bjB0ayID2TXcdT5eQm4jdwMw57M/quhUNLpEvnWHde72eNXBt3LMMuVGlpT4WlqLlVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xin5BUtgFHdwhbaYR8h3fNf0HAWCEq0jm93YOdanraU=;
 b=z8AYt/mDY96mDdmORmQ4hIcNL4cQ1rTbbgbBfKdDTNkUcImGVJdbZIjE+OPlM6Yk6tw2oENrWOBtN49E9r4B7/UIubazUX4RhDrFpeUsUKhEpsKgN1kRVUZFV0aTFwObqtTKvLVYFdv4wsDLjHCPeRDJjuCBPwhUf0XQilx2yco=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2788.namprd03.prod.outlook.com (2603:10b6:404:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 15:30:46 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 15:30:46 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
Thread-Topic: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
 DEFINE_SIMPLE_ATTRIBUTE
Thread-Index: AQHWBMsVVhk01u9Q+ku9e2lfo1M2mqhfUfcAgAGNSICAAa0UAIAAA14AgAADS4CAAAhmgIAAPSFQ
Date:   Tue, 31 Mar 2020 15:30:46 +0000
Message-ID: <BN6PR03MB334776C7AD6C7C2B2F4A55A399C80@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200328063456.24012-1-rohitsarkar5398@gmail.com>
 <20200329103818.2fce9529@archlinux>
 <aee10d6bfc5f2fef85d90245304f3e0f368f94ec.camel@analog.com>
 <BN6PR03MB33472A88BA78392686737F9099C80@BN6PR03MB3347.namprd03.prod.outlook.com>
 <74033597-c348-03df-d52f-748bf52c1a12@metafoo.de>
 <5e832756.1c69fb81.19c58.78e8@mx.google.com>
 <5e832e62.1c69fb81.2a0e9.b85d@mx.google.com>
In-Reply-To: <5e832e62.1c69fb81.2a0e9.b85d@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctOTVlZmFiZDEtNzM2NC0xMWVhLThhMzAtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDk1ZWZhYmQzLTczNjQtMTFlYS04YTMwLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTczOSIgdD0iMTMyMzAxNDIyND?=
 =?iso-8859-1?Q?Q3Nzk3MjgyIiBoPSJpWU15dG9GbFMxMy9yd29vNitYRGJ4VkVYVTA9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUFpcEVkWWNRZldBV3dVSXA2bzVuWXBiQlFpbnFqbWRpa0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQTV1R0RXQUFBQUFBQUFBQUFBQUFBQUo0?=
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
x-originating-ip: [2001:a61:25e8:5601:8594:23ee:fc00:bd03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38aa1ad9-c38d-4820-1189-08d7d5887bf5
x-ms-traffictypediagnostic: BN6PR03MB2788:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB27880BC7DC143CB7B520EBC599C80@BN6PR03MB2788.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(53546011)(8936002)(86362001)(33656002)(6506007)(7696005)(66574012)(2906002)(478600001)(5660300002)(8676002)(81166006)(81156014)(66446008)(66946007)(76116006)(52536014)(66556008)(54906003)(9686003)(55016002)(186003)(316002)(4326008)(71200400001)(110136005)(64756008)(66476007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVBlaKT+PA6O6uMsVHbGQw2QaijkI/oTx+FCa2E6UjeKs6m5jTjJd1viYskC6vyRgVaYfhCZrxkcrMHgc4Wb2QydhezHtwkPIrgqy9QmRSUP+W75T38WesWZUJD4SRBTN8rXHYewq7T4J57+xF/SC2StqUkac/zn79mhhF1XNzlq41B73gklo6Gnta+No25fCVjNR42SYaBDZ7RNxLjpnNxICPT3SEB11QgTImQwTOqo2BSRsiduPqIzjBynUu8DiG3Eiwsj54pV8nM0c+EMxIh+piF3XLJARvPuteHzQt7L/sZt88qykosUH9NgyJ1k5vs1tcwcsQeRQXZM2HzjB3gu/dStphzc6VAnF2iytqF4Ivdr8YbTgSRurxIciDDJNOygkd6SUhtbeIhQmLtaiKRpXTwmw44Au3etlsPPGzHFBbuQfjMvwQ6EtaJI1tAs
x-ms-exchange-antispam-messagedata: ajbTwcEKvgXqu++yuYUlni7EKGtl2367qXueBBGCGqOxO6GrbP33RHIIyjYVv8J3dZ9C9FcBNg83S1n4/dhH/aF2+awSNSvUIZGbqb0WYgSm5ZdHdJAvnzMPHoxdZN732PijMm/uqaryfmnW5a2rAbFQiGvKB3DTIMDfjWrAqXNmjU77hm0Obz2mzjO+pTkGRj7sRAedbmv+oyBjv3SN7g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38aa1ad9-c38d-4820-1189-08d7d5887bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 15:30:46.6272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bc6T27/Jf9rMFr0iIJzedEJUg0WNh0rwQ2x2IHQ1yfDy9Fj7ktwSyxIxzNta1XH8700c8aNgEscKQuJswTlouQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2788
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_05:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310140
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Rohit Sarkar <rohitsarkar5398@gmail.com>
> Sent: Dienstag, 31. M=E4rz 2020 13:50
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>; jic23@kernel.org;
> stefan.popa@analog.com; zhongjiang@huawei.com; linux-
> iio@vger.kernel.org; Bogdan, Dragos <Dragos.Bogdan@analog.com>;
> pmeerw@pmeerw.net; knaack.h@gmx.de; Hennerich, Michael
> <Michael.Hennerich@analog.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/2] use DEFINE_DEBUGFS_ATTRIBUTE instead of
> DEFINE_SIMPLE_ATTRIBUTE
>=20
> Hey Nuno,
> > > > >
> > > > I don't have the exact parts that this patch is touching but I have=
 other
> parts where this patch
> > > > applies and should be same. So, the idea to test this is to read th=
e files in
> debugfs? Maybe also
> > > > some unbind + binding?
> > > >
> > > > I will try to test this still today...
> > >
> > > The stress test is to open the debugfs file, then unbind the device a=
nd then
> > > read from the still open debugfs file.
> > Yes, also just to be sure, we need to test DEFINE_DEBUGFS_ATTRIBUTE
> > along with debugfs_create_file_unsafe. I will send out another patch
> > that changes debugfs_create_file to debugfs_create_file_unsafe and then
> > that can be tested.
> Have sent out a v2 that is ready to be tested

So I tested your changes in a different HW but the principle is the same.
It worked as expected. Unbinding the device and doing a read on an opened f=
ile
descriptor afterwards returns error...

- Nuno S=E1
> > > - Lars
> >
> > Thanks,
> > Rohit
> Thanks,
> Rohit
