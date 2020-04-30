Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE841BF72A
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 13:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgD3LxM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 07:53:12 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55782 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgD3LxM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 07:53:12 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UBq6Oo014322;
        Thu, 30 Apr 2020 07:53:10 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30mj45kceh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 07:53:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NndaVZl3X7JSks7/d0VbNAZslQ8v3lJ2PvOtJc+n6uLsY7jMB7NDyAc6x3ZusVGsNMQZLVY82AGoDOIuBWB0nGn4XY+WCg2oHsnLL+dkrbn816SBBU1c2aDp4c0RxmYCn00AmTkIAN7fToX8LyWf/HbV1NQPUmoezSW37XLjAM7+gd1AwIkM9vIS1vK5qDnAOxyTRSsGOXIhW2Fa+N7k8bkJEFJUMhDroM9qmEvpfn06LiEQJ69qYs36BThM7M9UeIKSSfmtiJ9BK07ZM821J5xNnSjrkEeCPrGzCs/7pPpITC8zQsx89u53dPXCYqUkUr3Klq6iEapFarQpFptaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T5bMBHe0hS7QKSl/fN6yd/jt9WnqMmaK1Edj8VVc48=;
 b=LS2VfGRm2SBRYZjSNfgXBUFKQNhKVtqDnNP3U4m6p0wRVmX98b1hLgYMF8Jn2+T/tkXWb4l9qfgHcO+NwzdlwlYCQRny71dcmIxlGtnNbGJrFsOLBOoYravVpTTP8eDFEwR6uh+FHw7ISqNKAXLL2j4JaLBVFRKSlnnwPj/5cYlqCni9FHcG2aB4XQJsqZXN7PzIiwUcSkoBlymsNa/wIFiFASAWiVHjOSUbKXMebuWhfhAtwtIKCVuRkfnSFbQgha0THp1AUJYydoyFDBLYMPclPB0TVCI8P8U54jWZIZNus8yDkgm942C12yfjB9NXrqOgqqbWoroNZAnCy2QHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T5bMBHe0hS7QKSl/fN6yd/jt9WnqMmaK1Edj8VVc48=;
 b=mJ0aSnDBAyd6AeFaoUzERsyur6RUmC9G3voIXmQYO+mepoDkZRgLoAUhK7SPhzt1NkEDXh0J8S+7kQatqqkrQQhMho0c9PuGDmM9AblRVRqi7qlq71AWqU6oeX49l8SU+RN0kmjxtywTTElUSn9ZVjK3m9M6YE7dncWBGZqhVp8=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB3202.namprd03.prod.outlook.com (2603:10b6:405:42::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 11:53:08 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::21b1:c085:e156:cfe7]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::21b1:c085:e156:cfe7%4]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:53:08 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [PATCH] iio: imu: adis16xxx: use helper to access iio core
 debugfs dir
Thread-Topic: [PATCH] iio: imu: adis16xxx: use helper to access iio core
 debugfs dir
Thread-Index: AQHWHt8WygP08mSDgE+lJ8nVfIqj1qiRjaSQ
Date:   Thu, 30 Apr 2020 11:53:08 +0000
Message-ID: <BN6PR03MB3347761C636F1406DCA6F23199AA0@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200430110422.7472-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200430110422.7472-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMjgzOTEzOTMtOGFkOS0xMWVhLThhNTYtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDI4MzkxMzk1LThhZDktMTFlYS04YTU2LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTE1MiIgdD0iMTMyMzI3MjExOD?=
 =?iso-8859-1?Q?g1NzgxMDExIiBoPSJFRVRWQnd1VmZzWUh4cDZPZHdMbWhpeXhicmM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUFUNEpIcTVSN1dBWGplK21JdkYyNXdlTjc2WWk4WGJuQURBQUFB?=
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
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:25e3:eb01:8485:f8a6:dea4:3871]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d39af665-023f-48f0-b752-08d7ecfd0cee
x-ms-traffictypediagnostic: BN6PR03MB3202:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB3202AB65E9679895809F95A299AA0@BN6PR03MB3202.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(136003)(396003)(366004)(346002)(8676002)(6506007)(4326008)(71200400001)(478600001)(53546011)(5660300002)(9686003)(110136005)(316002)(54906003)(55016002)(33656002)(8936002)(2906002)(66476007)(66556008)(66446008)(64756008)(7696005)(4744005)(52536014)(66946007)(186003)(76116006)(107886003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQz2sFehwQn5iXS8lSCEiTPmST6lTX913/m6RI2k7ukVeEadYZi8myU/W73Ok238Qy5538Qgptv18LuM6fGGwzmIMc4z/BdUVzXINefQzfXVF0uA7fbj6zJni1XAyuy52jredaSyFVzlI+Wlz5Y/9urVsYwJY+VUXWVSc2C163Sy6zgrBbUlUKfiKHnzY1WbS0zru6AieDwi/llsTx1V7UeboCDC1vTbc/aS4/wfo5i5OGLVpv8MV1hFDQLScnl5JZpvNJnwD8GaYGoIf5bG9aGIkUgdL9n7Ui8OMQMeDuks/DXOXP2fvw/nmlRpM3PurEpZgGlCfYjRQmogRdLPC5GiRAumYjbS3kouHeYr1djWncmzf5XaIkdGs3IaplYkKIL/CeFFVXvw27E2ECZ8tj3JT7k0O+tEKN5KAgVCyANv+UCeaEiTCK7jkTFaaija
x-ms-exchange-antispam-messagedata: a+1DOGWn+P5ahR1oLG8bOxIA0FEHLs7AuknnDkrMKCEx9de81MUMMpDhlixFWy/nEs5gwzKwqNHiErHLnZGRALFnVXn/VxE+EOcI61oyblHx6a66whByyvt2sHvw8LmnxZLZpyWbbvDz92lJsggc4JUIAnMoJ/YfAgARK4rYwA0XVODFCPd6W5TrrG/3X0/9nDqE60EpkA66kuCcjvvvXWiFwBgV+fQbTzB9e4fIHnbisq7QAmidG3YIAV4Yrl8f4XMI/xr00tiNZS3g7PWLOADVkc4fk3vUGNc5BjyAzGmGR30vXA/mLielS2ouPS8Bf+y1LC9ISM/m4tIL0S+2Uhk/Gnygzfsaw5MDWF8PC71lnYoDi7l4pGfYw5Bh7zhd8BQwQ6UR5bxSAqrLskgaUhag3fp1NFUoSCmR+x7dbFiqDi8o9xTQqlUuQcHKm5vZyt5zgKpklNrxbN03Rt0bmSG9jeFrzmXG5yDtaKPOgG7e7NKpYNbQXI2GBy5zcGIrhjIo++zjqJSGxuocahsl5BbPstEAFlAqMUsVJrAnebdyzLscczbpZNbKQvH7krX15WwUREEi2jJV2iUVPiKqnJoT0d2yN9YhSJp+/ihLHiiF+REHyTL2QXxwoEZEetLzNJhfFXBB159MQHDQ/AcGQt6+AdPb3XfYycscRjJxUfJaB5gaJ6NU0/jnKCsSU1VnlHHHx9IyyM+3Ws8/AXhe/5stUGFufAuuJ5R27hE7g8LpF/4J5r4oO+eoBwSlx0D/BTv+F8FqQGeVDrnZ8iQ829Nd40Wd4BrTQUptBHKOEvyFXleBkHkJc3744/2BhXsUkff/mSD5PDkxpATgnuk7QxHoD7MIgoxR1FNqxqaodXA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39af665-023f-48f0-b752-08d7ecfd0cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 11:53:08.2957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UjL8jLYfSvM1+PcVdLwjwQ6ZXm0BFzZb637QdGwWXfxWb4L6SzhX+eAYeOFl3fgP37tOa7+U8tW9uEYxIWmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3202
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_07:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=951 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300099
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Sent: Donnerstag, 30. April 2020 13:04
> To: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Bogdan, Dragos <Dragos.Bogdan@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; jic23@kernel.org; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>
> Subject: [PATCH] iio: imu: adis16xxx: use helper to access iio core debug=
fs dir
>=20
> The IIO core provides a iio_get_debugfs_dentry() helper.
> It seems that the ADIS IMU drivers access that field directly.
>=20
> This change converts them to use iio_get_debugfs_dentry() instead.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/gyro/adis16136.c | 10 ++++------
>  drivers/iio/imu/adis16400.c  | 10 ++++------
>  drivers/iio/imu/adis16460.c  | 10 ++++------
>  drivers/iio/imu/adis16475.c  | 15 ++++++---------
>  drivers/iio/imu/adis16480.c  | 16 ++++++----------
>  5 files changed, 24 insertions(+), 37 deletions(-)
>=20

Acked-by: Nuno S=E1 <nuno.sa@analog.com>
