Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C9A355382
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 14:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbhDFMUv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 08:20:51 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:65526 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239518AbhDFMUu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 08:20:50 -0400
X-Greylist: delayed 1945 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 08:20:50 EDT
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136Bl2HU013544;
        Tue, 6 Apr 2021 07:48:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 37q2pnwkuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 07:48:16 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 136BmFEG016524;
        Tue, 6 Apr 2021 07:48:15 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0b-00128a01.pphosted.com with ESMTP id 37q2pnwkud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 07:48:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa+iM9Jo8SFrH3DOOpws9JY+5D+GOx71PXewQTPGO/XHy6nhXkR07l9+n+zs5a4MQE0YGBifM6d9HXyMrvzzi10IxbS0zYxTeNDrYX8b9DypEVhSva3+LAe3MtYNGt6qxovkFWWA48cNPdd7KoGNYYtMIqTYBuuU0S9v7lxVt3fZ3yawHc2SffNgW3NZt0elalQCh3C8WbjCdjNTlBn6jVCQRr3l0hPg+H/zeOzaXqyIvOd1WHRLfvsOPbim9VeE3pNVFI9vkZQZeYdbcKHsy1m6VQqjZGQpPJo/GtWhvYk/JoYvJsmYz2IB11tYacClvH5nCzokuPmMjcM6lUhm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7ipbfGS5OIdD38+T5wlm0G45IiOBOhar5ETDhaD+TM=;
 b=iNpAWCwqIpaxs16LdZzdhg2AuA+iaqI98hiy/p8KK+ihdhdxrZwKThjUy8JGFBcOlITLj97aZR4TeglmdLernRzEf95mCC0UJVQeJEhGrpIAshl0N5sQ0dn3+L8QPbBPf1unA/qUw18lN6AOnxeTgeYx6uxe+nbkMbo8zpW+vKm4y9H79OlIPLwgtJ529+hADf3N0YKoibrd91P/APuwF3pra8FA0TqgJzhDCeuaAeESAcRzWdsVcppX0kEcmKMIDo30gHRQi/lbUvFU4Ixfr0gf7Q2VLcDpYUAC2CRqBm+3tAKDbyJ5RMyh42WTznaSXq5WTO+ye0sk+1qDG3Zd7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7ipbfGS5OIdD38+T5wlm0G45IiOBOhar5ETDhaD+TM=;
 b=IaSWp+GSfDolelNF6SQSCL2sgoQL3Rwk52BcATStheDoeRO1mBp6SP5/l9og4ODm9VMrBjSF7NMd9YXizxzDYQmxunlaJAL8dawMc+Tn24OUkNMviRQ91VWbvWcdzMLiqjP2U8QWeFgloDYDQhdYPzXXrpecwzNAefVpJn9KejM=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY1PR03MB2410.namprd03.prod.outlook.com (2a01:111:e400:c617::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 11:48:13 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 11:48:13 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH 6/7] iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq
 request then disable
Thread-Topic: [PATCH 6/7] iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq
 request then disable
Thread-Index: AQHXJ/C08rEDJH9rWkKFAHvX2NUyJaqhsCeAgARTPYCAAWHLsA==
Date:   Tue, 6 Apr 2021 11:48:13 +0000
Message-ID: <CY4PR03MB31128CFA46F80999BFFEA94099769@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210402184544.488862-1-jic23@kernel.org>
        <20210402184544.488862-7-jic23@kernel.org>
        <a733aa9b11684bb990f0bc6a50b101e5@hisilicon.com>
 <20210405154035.403edea1@jic23-huawei>
In-Reply-To: <20210405154035.403edea1@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcGRh?=
 =?us-ascii?Q?dGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUz?=
 =?us-ascii?Q?NWJcbXNnc1xtc2ctZjQzZmU4YmQtOTZjZC0xMWViLThiMzMtZTRiOTdhN2Nj?=
 =?us-ascii?Q?NzEwXGFtZS10ZXN0XGY0M2ZlOGJmLTk2Y2QtMTFlYi04YjMzLWU0Yjk3YTdj?=
 =?us-ascii?Q?YzcxMGJvZHkudHh0IiBzej0iNTQ2MSIgdD0iMTMyNjIxODMyODg1MzcyNDMz?=
 =?us-ascii?Q?IiBoPSJJR0oxWThrdFhZQWRDWWd6OEdhT3RqbmpKYmc9IiBpZD0iIiBibD0i?=
 =?us-ascii?Q?MCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFJWURBQUFSQnBp?=
 =?us-ascii?Q?MjJpclhBYlRSR0lSYk5jeXl0TkVZaEZzMXpMSUZBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?UUFCQUFBQWJKUFNkUUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFCZkFI?=
 =?us-ascii?Q?TUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhBWmdC?=
 =?us-ascii?Q?aEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdV?=
 =?us-ascii?Q?QVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29B?=
 =?us-ascii?Q?WlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCaEFISUFhUUJo?=
 =?us-ascii?Q?QUY4QVpBQnBBR01BZEFCcEFHOEFiZ0JoQUhJQWVRQmZBSFFBYVFCbEFISUFN?=
 =?us-ascii?Q?UUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBY2dCcEFHRUFYd0JrQUdrQVl3QjBB?=
 =?us-ascii?Q?R2tBYndCdUFHRUFjZ0I1QUY4QWRBQnBBR1VBY2dBeUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2835e7ae-80f5-4351-4e0e-08d8f8f1dbe7
x-ms-traffictypediagnostic: CY1PR03MB2410:
x-microsoft-antispam-prvs: <CY1PR03MB2410600689F78E471FC8A19999769@CY1PR03MB2410.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTOMHctdil/V/AYgoyfUhW2+qJBhgAz+kX0uc8jDzJP1mcu4zUwdsdvOMNh4Iojx3c3Uy0IykoP1+vmP+RQZaFkjPM0g7xfeMI70ngKHQT3S0D29bJ1UqNn/ZFN0xH1M0p6itU6LtY+MbWPn++MPxXLOOLVPSQaRC3cfeqUWE8KzBfj3cMg5SQkEz76jLcTVpU18w1O2nF68gtvGPKPr3bWZndEmQ0lN2shu3sMlb8xDigMOTcMPqWIth8FW7pJKul+QxO7k14WXXTMwPk3P2UECQnAjfNABsXvBYA6ttP23QDnv06okFpmCBfdtrTcx8u6JWNXThV1LHrMa6wPduo+N85xtwRMXQZz3sQrcok1NYlulKM5RuUwpqbEByw1WHW/UDdH12VWER5ljuTTGrpTTZ5EiDvUQwgX66xoTBDQpVpF4L8FPBqGrgn230ZDUWkXDIrHYi2A31JLJS2hoYqatNb7NPakloy5mefciwH2cjxp4LKy1HJqYM2ZdtoNGdmKYJyn5DoChdNDvTnV1BeN8ob+5l+yGaOj2EqYHdMK7mWWwb8KpabW8Nf4+PKNgJIP+1xkWB3OBX8gpgPxWxLEaL/CQABjBD2P2m0OuKe26kjLfg/pXsUyFg2Rds7KN7YWFE1dWjBv6RtS+ioVierwFnIHIcGno4LMsB+mjx9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39850400004)(366004)(346002)(4326008)(52536014)(26005)(66476007)(8676002)(186003)(33656002)(38100700001)(316002)(64756008)(66446008)(54906003)(66946007)(8936002)(5660300002)(110136005)(71200400001)(55016002)(86362001)(2906002)(76116006)(83380400001)(7696005)(66556008)(478600001)(6506007)(9686003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?auDcuprBBP67gaC0CWuzAyJDIWAvpkoN7rXcose6sXDo6Nwk3diw/g0i6Ks4?=
 =?us-ascii?Q?PDdNAC6nFu29V0EV4u8CNyr2hAPBxrzWN1jrV7me2l2/45ppdAsn/CAYGLGC?=
 =?us-ascii?Q?rc1Yww+D8IKpEQrQSFd0MQfoKaOIzpV1XPgE4eWV5IprSfkyQun9iVl3pHYb?=
 =?us-ascii?Q?oUQhAeLY1wn+17GA4NaNPdTEXiantN2EpI9pu3tBqKCmSJfGzWmQQiloAR9G?=
 =?us-ascii?Q?vpTQ5j0Y9GIsercr0HtGkceYa5tAMMF86kZ25gBR5PNbw+FTpngTf5igPUZW?=
 =?us-ascii?Q?lwG+CXHvDJumzhwZ1FKyERBQeNB9VOgw1F+h4yp5WQBukF04j/oslRF/X6Yv?=
 =?us-ascii?Q?PSPYIyNNpcU+BC8n15+1jN4zT7LMLuvhw0tTewvz0ZWs2ZtCs/8Tm1zbO7pr?=
 =?us-ascii?Q?l2rXULJPDf3b3l9IwasWvMwC4ZeuasRuTsEagPkZsS5p2nP/4izQRYBzvhqo?=
 =?us-ascii?Q?yKJO0v9iu8hatf0/kjXyXyeng1AEbkQERjN6jtUtVrDnv/Rum1cixdXRRrgE?=
 =?us-ascii?Q?WWLWhz/Cx2Hzr4nXgKUovaODEF/hO+4OauwxSGIrPhrZPY7poem6y01iS7NI?=
 =?us-ascii?Q?lAqRTHQ802sO5PXCEMA0KSy5+rIEkka+btBGahHqL/8jkP6tZFt1LMQWH/dG?=
 =?us-ascii?Q?saYQQb7JMuwY+cfmYJb8Nen+GC5wvOK2L0T2+ZBQ9ohL20DxbiEAN3kJC+bB?=
 =?us-ascii?Q?u0FI73KOId+lPn7AQhMye8CFjv41lepKvpda8SKSLf31VDpslwL+l5PMg2oU?=
 =?us-ascii?Q?IL6/A5h2sYZD5cQafE6oCd8em8C9BBh84YIkucIhFCdwI8DujfbkeQrhps+K?=
 =?us-ascii?Q?xLKM69MwPxk3uNgSWTKtiH2+11meacVQ7D6j8p9/UQmUtT6btucHF46mUh5v?=
 =?us-ascii?Q?erbu3bq0+r0gAhWVKhoVtyZ/Y4jsqvqajpUqsQLuC7hIAFWSuUSGXrhEuZaX?=
 =?us-ascii?Q?E5kGjjnedNNaW7tsA0BEM9KxSGOCopsCCFepfdfWbX3kkceXLh0b722JjsSb?=
 =?us-ascii?Q?S2x6P6TuoBIfLaiJTHngeWrYnkRKn1p1u80jq5aY12d7axqP8AP80OJSHwNX?=
 =?us-ascii?Q?fSngweZSeMsQDRggxc2+DqAN/qZMIZhErRqAlOL3p2DE2uZgITtfqM7QiAFf?=
 =?us-ascii?Q?FkvoDDTqqPdDz/AiN2+EpNnxd5g5mCN17/nSG58XOYRDGX+2V/YhnSgukCLS?=
 =?us-ascii?Q?CGg9P3ncx+zpGSg/eqU1JpkQJJ0SHMw3qmCkWqEKcK+Thf/u36jOMg0zYbVC?=
 =?us-ascii?Q?JvJ/06Lgpp92qPUSPB11dYopKM8ClpYQEk0yXrodzR0rmukTCOsMMw7pJgty?=
 =?us-ascii?Q?lsM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2835e7ae-80f5-4351-4e0e-08d8f8f1dbe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 11:48:13.1292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKRBd78zb87VFcFPfC7QveQlAhEhTx69HpJsvh+4SQ2udDeScZxzCaT6/Y4xkVWvFHqaWZ6ViBPkIyMoojG83A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2410
X-Proofpoint-GUID: u1TQji9Uwp4v1br1WFjwYYsZQbOAC40x
X-Proofpoint-ORIG-GUID: 69AL0wHSVQVpzhrZmHxoUiBMR-VNgZP-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_02:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060082
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, April 5, 2021 4:41 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: linux-iio@vger.kernel.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Alexandru Ardelean
> <ardeleanalex@gmail.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> tiantao (H) <tiantao6@hisilicon.com>
> Subject: Re: [PATCH 6/7] iio:imu:adis: Use IRQF_NO_AUTOEN instead
> of irq request then disable
>=20
> On Fri, 2 Apr 2021 20:37:37 +0000
> "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > > Sent: Saturday, April 3, 2021 7:46 AM
> > > To: linux-iio@vger.kernel.org
> > > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> Jonathan Cameron
> > > <jonathan.cameron@huawei.com>; Alexandru Ardelean
> <ardeleanalex@gmail.com>;
> > > Nuno Sa <Nuno.Sa@analog.com>
> > > Subject: [PATCH 6/7] iio:imu:adis: Use IRQF_NO_AUTOEN instead
> of irq request
> > > then disable
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > This is a bit involved as the adis library code already has some
> > > sanity checking of the flags of the requested irq that we need
> > > to ensure is happy to pass through the IRQF_NO_AUTOEN flag
> untouched.
> > >
> > > Using this flag avoids us autoenabling the irq in the adis16460 and
> > > adis16475 drivers which cover parts that don't have any means of
> > > masking the interrupt on the device end.
> > >
> > > Note, compile tested only!
> > >
> > > Signed-off-by: Jonathan Cameron
> <Jonathan.Cameron@huawei.com>
> > > Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > Cc: Nuno Sa <Nuno.Sa@analog.com>
> > > ---
> > >  drivers/iio/imu/adis16460.c    |  4 ++--
> > >  drivers/iio/imu/adis16475.c    |  5 +++--
> > >  drivers/iio/imu/adis_trigger.c | 11 ++++++-----
> > >  3 files changed, 11 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/iio/imu/adis16460.c
> b/drivers/iio/imu/adis16460.c
> > > index 74a161e39733..73bf45e859b8 100644
> > > --- a/drivers/iio/imu/adis16460.c
> > > +++ b/drivers/iio/imu/adis16460.c
> > > @@ -403,12 +403,12 @@ static int adis16460_probe(struct
> spi_device *spi)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > +	/* We cannot mask the interrupt, so ensure it isn't auto
> enabled */
> > > +	st->adis.irq_flag |=3D IRQF_NO_AUTOEN;
> > >  	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis,
> indio_dev, NULL);
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	adis16460_enable_irq(&st->adis, 0);
> > > -
> > >  	ret =3D __adis_initial_startup(&st->adis);
> > >  	if (ret)
> > >  		return ret;
> > > diff --git a/drivers/iio/imu/adis16475.c
> b/drivers/iio/imu/adis16475.c
> > > index 8f6bea4b6608..1de62fc79e0f 100644
> > > --- a/drivers/iio/imu/adis16475.c
> > > +++ b/drivers/iio/imu/adis16475.c
> > > @@ -1258,6 +1258,9 @@ static int adis16475_config_irq_pin(struct
> adis16475 *st)
> > >  		return -EINVAL;
> > >  	}
> > >
> > > +	/* We cannot mask the interrupt so ensure it's not enabled at
> request */
> > > +	st->adis.irq_flag |=3D IRQF_NO_AUTOEN;
> > > +
> > >  	val =3D ADIS16475_MSG_CTRL_DR_POL(polarity);
> > >  	ret =3D __adis_update_bits(&st->adis,
> ADIS16475_REG_MSG_CTRL,
> > >
> ADIS16475_MSG_CTRL_DR_POL_MASK, val);
> > > @@ -1362,8 +1365,6 @@ static int adis16475_probe(struct
> spi_device *spi)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	adis16475_enable_irq(&st->adis, false);
> > > -
> > >  	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> > >  	if (ret)
> > >  		return ret;
> > > diff --git a/drivers/iio/imu/adis_trigger.c
> b/drivers/iio/imu/adis_trigger.c
> > > index 0f29e56200af..39b50d6fdb6a 100644
> > > --- a/drivers/iio/imu/adis_trigger.c
> > > +++ b/drivers/iio/imu/adis_trigger.c
> > > @@ -29,18 +29,19 @@ static const struct iio_trigger_ops
> adis_trigger_ops =3D {
> > >
> > >  static int adis_validate_irq_flag(struct adis *adis)
> > >  {
> > > +	unsigned long direction =3D adis->irq_flag &
> IRQF_TRIGGER_MASK;
> > >  	/*
> > >  	 * Typically this devices have data ready either on the rising
> edge or
> > >  	 * on the falling edge of the data ready pin. This checks
> enforces that
> > >  	 * one of those is set in the drivers... It defaults to
> > > -	 * IRQF_TRIGGER_RISING for backward compatibility wiht
> devices that
> > > +	 * IRQF_TRIGGER_RISING for backward compatibility with
> devices that
> > >  	 * don't support changing the pin polarity.
> > >  	 */
> > > -	if (!adis->irq_flag) {
> > > -		adis->irq_flag =3D IRQF_TRIGGER_RISING;
> > > +	if (!direction) {
> >
> > Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
> >
> > Though a better way might be:
> >
> > if (direction =3D=3D IRQF_TRIGGER_NONE)
> Agreed.  That makes it a tiny bit more obvious what is going on.
>=20
> Applied with that change (seems unlikely to affect other's tags)
> to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to see if they can find anything we missed.
>=20
> As normal, whilst 0-day and friends are working their magic, there
> is time for any additional feedback anyone would like to share.

If not too late :)...

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
