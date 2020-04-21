Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051DE1B1EE5
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 08:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgDUGj7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 02:39:59 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37976 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgDUGj7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 02:39:59 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L6VGtR000484;
        Tue, 21 Apr 2020 02:39:41 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-00128a01.pphosted.com with ESMTP id 30fuabg01k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 02:39:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPJq87kGhXIfpXG4iDZWtkAVOgXMVwz+B8RoNx8GpRV5xunx8eMzDnUFP7+BNGOO+y9oKsFVPUzHFlbXDzXbUzts9ZUHULz0w9APp7SghWgCiNXOCJvkadZdqG9uz28n1kFfESCAWJrRdcsS98suwlBUwRor8oezOwa2U3g4wJqkHufgOG4QcRC8bFU813d4eCw2VDmUtcdcMhs0FKZ2akmFUwTSVyAZPGcwACTkMVUVA5AaNlwPugNcHbFDzgp7x9Vx1kQXNMQd7lbH5VMmqL6uK8zwTseu0TMn0Rj5+e8h5UjpTnhHSR/Pr5sNl/jLn6XbjRyfol1jcyM+Da3cvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4wSQ146tqbiuEbYjqJCT9839SrRdKS7EaXBwqL+96U=;
 b=JFiQLpkXIDw7tPHufpKCcIAPhD27uDjjR44J1bfaW26UzigZ/C0sT6ZWlnlAGNm34kbW7ymktDhBruxMvSror7nGv/tLIBTY6NGEBw5tvDK2QAmB5yqCqLnu8+RpZKOktstF09JoOUVQmDlJezLcqLQcpdADN3+onN7H8KdLLsrSM8UQFFuH5Md858rMNXM72VDyTkYiscJAbZM+6Ib84WuAWvrMxgkKXsg1oJ49+rp1qxkGBby04kAgCSmVEGiQFWYtq2438EIew9voyCT4Bee54a4mgZHbSLiVtT+YTxkvDaqPQ+1wlakfaPlQ2mcvbO3B3e/h/zM8euP4uElpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4wSQ146tqbiuEbYjqJCT9839SrRdKS7EaXBwqL+96U=;
 b=lxmm0H3nTl/qOrLUTh+ZLBsyhLEpHrMvDyo6OWlNLSoSmHjc6BRes5WmHY7BKCA6iCrFH7C1OHDVi+eza+LASMknupTbsQvjoEgUaY3vbZefGam4rcpQfGL9JOin+u93d/t2FTVCEUq9Fe+5uT3J+1XSLApWTB3NuldeyhI3fhU=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2594.namprd03.prod.outlook.com (2603:10b6:404:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 06:39:39 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 06:39:39 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v1 07/16] iio: gyro: adis16130: Use get_unaligned_be24()
Thread-Topic: [PATCH v1 07/16] iio: gyro: adis16130: Use get_unaligned_be24()
Thread-Index: AQHWF3RHR6mnt5BmBkCUtg31wbsN26iDH8IA
Date:   Tue, 21 Apr 2020 06:39:39 +0000
Message-ID: <BN6PR03MB33476B78E7AB1265F0724E5599D50@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
 <20200421003135.23060-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200421003135.23060-7-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZGQ3MDhiMWQtODM5YS0xMWVhLThhNGYtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGRkNzA4YjFmLTgzOWEtMTFlYS04YTRmLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iOTcxIiB0PSIxMzIzMTkyNDc3Nj?=
 =?iso-8859-1?Q?E4NzY0NzEiIGg9Ik5pMlUyOVFQVFpGZUpqZGR5d1F2MzNBT2g1WT0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBRDNKY3VmcHhmV0FaeFN2QXlueDJuTW5GSzhES2ZIYWN3REFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBNXVHRFdBQUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-originating-ip: [2001:a61:2420:e701:28a3:c430:6480:d41c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ab46024-0b7c-4b6d-8e5f-08d7e5bec422
x-ms-traffictypediagnostic: BN6PR03MB2594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2594A9FC41A8F32152FDBE4399D50@BN6PR03MB2594.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(366004)(2906002)(71200400001)(4744005)(5660300002)(86362001)(9686003)(55016002)(8936002)(8676002)(4326008)(316002)(107886003)(478600001)(186003)(33656002)(7696005)(76116006)(52536014)(110136005)(66446008)(66556008)(66946007)(66476007)(64756008)(53546011)(6506007)(54906003)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K7MBoTnXMbBwkmpJihOo/mab2GyyP6DZNXQQbBNwlMNjONZzi+coKr+umYum3p8SbW7cG/PH8OXsut6Qiy/VT+lPrKHe2IFQfJSJ3dKmTZFYsWbrX1prSLjAqTgyd+FO3zEZ8ds28jo4cBdK1iGbZnlqqkgOB37D3f1hvYMN1pQ24llTwML1o+AhujyjcyKpTCpP4x/OieuO3ib0PZ0Q+3ZpOujkXH/Kjn69VflcUcNXxFReWPvriWGAShMKQw3e2RgkrpVLQPMQ4XsgEimzghhlXsKtE3apRfklTDQgvoIi+kD8euj2Wys7Hc8Uzggkf/hBIMjKSG+9EIRh3/3u8igNmkzbEqu9k9XKmDLWTJSmdMQikMtUHcHnS1VFtyoudixgDGulsbC9yO/xwj4jErifG8o3BTVKgunLAQcWlpsta48d6hpm4hxRWCeKGNNN
x-ms-exchange-antispam-messagedata: 7aLJFqa+wSgfNRXnlsRCM4eFvhwwcUpdO28DbS9Nu8oxVeF+djar54Fq31mIUKo/2DE1YX5rTbLWicyVktFIZTbGxsMTYacRcdsLM3Ydkuc84aviodFU8MohnF6iVFQ1sRdeGJdq85AdqAMTgzvq7mi54Myc1h15R9QwcuO8eFuUjYX4b9ZGJsJUrn2Vf/N5u5rJnuwkfAxRJ0+YVozJug==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab46024-0b7c-4b6d-8e5f-08d7e5bec422
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 06:39:39.1041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAg7p810FpmmWpd9RhFFkmQisC5CGgFtWJcP41q/prgjIoiTK7237SmFe79VgvNmyMxtb9z453vBy5PagY+dPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2594
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_02:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=757 adultscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> On Behalf Of Andy Shevchenko
> Sent: Dienstag, 21. April 2020 02:31
> To: Jonathan Cameron <jic23@kernel.org>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Lars-Peter
> Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>
> Subject: [PATCH v1 07/16] iio: gyro: adis16130: Use get_unaligned_be24()
>=20
>=20
> This makes the driver code slightly easier to read.
>=20
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/gyro/adis16130.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Acked-by: Nuno S=E1 <nuno.sa@analog.com>
