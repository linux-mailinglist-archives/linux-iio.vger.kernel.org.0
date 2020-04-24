Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520DB1B6F6A
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 09:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgDXHvS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 03:51:18 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13656 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbgDXHvS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 03:51:18 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O7o1OY014195;
        Fri, 24 Apr 2020 03:51:05 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fud7nnqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 03:51:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNLckmWIG1HOznS/dWG5NdlXuUp6EvmSNd/VqqlQCMf/l8HtYJl4G8NEr73nzHA+IHlGqxOMk/Qoj7Vs4j/swU4fVVCvLSpUSUoIZWHUUAoFsWdrPoGH94XhOewRtm1jj26vQv7eygPIeGFBRx/6B1U41yJl4ZrjxK//PfkVueXIUn0e5hpyrjsbqYlzw035qxEwpK0PTxGfVS4qmopgNWmq60Cs3QgN1AJd0Z/pRWDgFzWaMyNv9clfIMRT58Vkm0dpg4tej9CavLX7w3yOZYKOs9nCcl7YuUIMjdXpR+nWjNZVHDZLo6eaPXKeNwYUMUiGaw07LrlbuFF7OyP4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52pug1Ec0jPbs+PHy721ghcIUkvPULW4/CLjiXJhsOo=;
 b=A/BA3PerdHS1AWTnMNLXoVAEuOZdkTZ9hveKLyeNbfV3ceFG9/tiE+0N9iqtZovDX8j/0j1Ul6u5czG7hj1blJHzuQgtc51DvYebr/5YDpv5zrml8hC9QH9Bv4YnoKRuYm/ynjo/SXx/mK0Qong/y1sBZwfR3cjI3MmDRecDZMujO1+KD3xtQH98anOX0Ov4igCBV9i44VFXR0Xks1S608ZPHEo9hTjyKwjLVSTB9mbEiGoZMNCo1XylVNGdl1mtOCuTIz6kbU1ua0bFw//WPjPLJc2qj9oaKXDSHvOP/YWW3ASa0qIqT2eNawra/b+MM0SsHsnpneXpaRBi29UyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52pug1Ec0jPbs+PHy721ghcIUkvPULW4/CLjiXJhsOo=;
 b=awYOQWod5qeb6cE9EucH/nGyGV1npXOPeiyAgGD8i06PyTtt3bBJJLOGIWp6KlIKc4ZEtwgrGJXam1w2H/zYrh0G3x5F9jGz7ijxUOg84qqA6NuaBll4Sh8zJxk3bvkHu/U6NSHAwCHYSZKJh6gvz/KaCf94duSful8QhizkXHc=
Received: from CY4PR03MB3350.namprd03.prod.outlook.com (2603:10b6:910:55::24)
 by CY4PR03MB2485.namprd03.prod.outlook.com (2603:10b6:903:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 07:51:03 +0000
Received: from CY4PR03MB3350.namprd03.prod.outlook.com
 ([fe80::e483:8557:31ac:d59b]) by CY4PR03MB3350.namprd03.prod.outlook.com
 ([fe80::e483:8557:31ac:d59b%4]) with mapi id 15.20.2921.027; Fri, 24 Apr 2020
 07:51:03 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [RFC PATCH 0/4] iio: scan_mask rework to track enabled channels
 on per-channel basis
Thread-Topic: [RFC PATCH 0/4] iio: scan_mask rework to track enabled channels
 on per-channel basis
Thread-Index: AQHWGffAWBNJoKCU8UKZv3J4cR98RKiH4CvA
Date:   Fri, 24 Apr 2020 07:51:02 +0000
Message-ID: <CY4PR03MB3350FBD3C1AE562371E5CF4799D00@CY4PR03MB3350.namprd03.prod.outlook.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200424051818.6408-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNTczYWZiMTktODYwMC0xMWVhLThhNTItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDU3M2FmYjFhLTg2MDAtMTFlYS04YTUyLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTMzOSIgdD0iMTMyMzIxODgyNj?=
 =?iso-8859-1?Q?IyMzM4MzczIiBoPSJhdTVRcFFLQXdsZzZEYm5OTXBIblVuWG1PYUE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJGSmJjWkRScldBUWJXNVU0bVltNldCdGJsVGlaaWJwWURBQUFB?=
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
x-originating-ip: [2001:a61:24cc:eb01:701a:32:5e81:fad2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d5fb2e0-fd21-4f79-8f90-08d7e8243cb7
x-ms-traffictypediagnostic: CY4PR03MB2485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB2485227262FEACC9B44B6B6499D00@CY4PR03MB2485.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3350.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(39860400002)(136003)(366004)(9686003)(55016002)(54906003)(6506007)(53546011)(8936002)(8676002)(33656002)(7696005)(81156014)(110136005)(2906002)(5660300002)(316002)(186003)(71200400001)(478600001)(76116006)(66476007)(66446008)(64756008)(52536014)(107886003)(4326008)(66556008)(66946007)(86362001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rlh+Hg2yijM+Avrk9DAtQ8NhewQGa7kS34C5uJT/NoSjydQHrXDLe95r5a8EksqZ36S0hXoxpRxnRwIjN9XvyPj0Oi/ReEoUvzyKWkIyOvCiy6TYZdB7eVoTFYoODPN8ESfftzHbN/p7zoms+5Lwo1ZTt6vsEX6QQPxsc0RpI8LRBX0gKkuAwiXnIxkaA0uswbge0aeWYg61X1JV5wP4s7Tv2XPtmV6OjHa73EyHCJKHTz/zU7Xu3AiAnAC55RVFAGMgkfKyj1vc7SMxEae6JDrnudCr9rGOjQD02lkVzUV4QuWDD4wwBOnHGzmKjWRA3vhIy8pGCO7QbrM4FT/NxVCpoIeB6CZ56HqxNWgbrh55rGJn/mFPFobd6K5ugh6ouIzfHltS9W05UJfvdxZSem0OQTtfuWafthLCW2YuHF+0RsI2lgA4Gg33XE61xyuV
x-ms-exchange-antispam-messagedata: oJpMiXzOuya3cijf5eBqbUYf3C8DrwqWkUiGiUc7wiGxD4liXm+fkpZKYn1JhPpG6FcTSXT0ebBq8H5DPlBoDvgS8fQbTtA2xzbtf7JZ9sl0QvPuqaq/oEwEoeXbg6rlpwhqUBO33AsSXFMsKA3pG1n6X75xyyQqiET5V91AvxPaY8nJq1kApjLg5pQD9GtFcvJFn7dg76lEcOq2cJHpkA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5fb2e0-fd21-4f79-8f90-08d7e8243cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 07:51:02.9884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+U99eM9qi7y2tSxNdki6fXirAkTTxHT1wN+/wFGxflxunr/lY67RzMq1trN/MiDfUSl5Aph12g+LTrXwKnB1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2485
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_02:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240060
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>
> On Behalf Of Alexandru Ardelean
> Sent: Freitag, 24. April 2020 07:18
> To: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: jic23@kernel.org; lars@metafoo.de; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>
> Subject: [RFC PATCH 0/4] iio: scan_mask rework to track enabled channels =
on
> per-channel basis
>=20
>=20
> From my side, I'll admit that the specific use-cases for these patches
> are a bit outside of my scope of understanding.
> I did my best to re-apply them on a newer tree, and dig-up the
> information from the ADI tree [where they've been living for a while
> now].
>=20
> Also, I don't have any idea if there was a prior discussion about this.
> I could not find anything on a quick search.
>=20
> I'm hoping that the author would have some input on them/
>=20
> Hence the RFC.
>=20

Yeah, I remember I stumbled against this when looking to some of our driver=
s where we have (IIRC) a 16
channel ADC where 1 channel occupies 1 bit. I just gave a quick look on thi=
s and it looks good to me
(naturally it needs a deeper look :D). I just have one remark/question inli=
ne in patch 4.

- Nuno S=E1

