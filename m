Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012674334FC
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 13:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhJSLs6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 07:48:58 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:51274 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230303AbhJSLs5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 07:48:57 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19J57dkS008382;
        Tue, 19 Oct 2021 07:46:30 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-00128a01.pphosted.com with ESMTP id 3brvpwqst8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 07:46:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfpzL5eribbINfx59eB4pvv721Z9jFHCHg0L8t3o04GP/xHhPos4lK354EEGC1YGbYdAAvXG6zZOjB6sFw1vcp2xBtmWg6TzsabQaIGJO3UxNCzZMjhoXn5h1wo3Zgq1tMm4KyY/eu+Hdygs6ROBNTXZPVXroIZfpXbwmzlUmkeaEFtntqiqou/1v9kME7xvx9h7nVLHjFDSjhGK6cTNzw0k+LuQLcDzZ/bq9XXcvF9QEKgN65wY3TcYItNzVvygZJzxBNKJcAvXu2UXCZZWKBP2att/erTdlfQHXHqZg3zYWylPLEiosxkDc1vHUFC/g6lKtRoTPmzK5HpcvaCHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91NDJcLFy8nCG511rjhMRvyZfDqvDTp7+YbTagzLJLA=;
 b=H9TnMAx3tjT1PBkdEa6qDedbjiU0mCcN6yZVDocIqEEX9OaCFyn3nuYTK1j6dfTXEPUqZ82COh9gcHmVfwuzcZEJ+a9lxg2Qv3HSA4tl7bjhFnnhdCaRH8W9RglCltisBhn52S0zjVQGvfyQG+zsOwhAAdsWRkQNGv3oSkS421oIsQ6QwKA/VUqMmyK3vwKL8+oVz1kvmMNwdy0ocgxLn4ocFahqRKvAku+Qzmjf9+NJCihKU6DGZQ+Yv+iz2j1wXZeqSU6nI4pTgtbAlV/1bNwz4RoDYFHM1ow1yKjSSsOMlnUlr2AxFA4hnSi/J2Yc3VI0AQfECZf+p6Q6J/Ax0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91NDJcLFy8nCG511rjhMRvyZfDqvDTp7+YbTagzLJLA=;
 b=xtUT4H9BNZDigtph8Rjfs3wp65VPSYHyRYS2mTp5+BGw6AhZNPhYbOQQ9wdlQgoyjkdt6aLL8TM/RdNfdDZq4S2Iv+txOlFSOePoCZ5ZkR223eovAFUWEGxNUZxSSWAia8ZGAKT8VDvLqrDDvXO2IL7nn4vkqvwqnmkyaIKgCgY=
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com (2603:10b6:a03:2d4::23)
 by BYAPR03MB4888.namprd03.prod.outlook.com (2603:10b6:a03:134::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 11:46:27 +0000
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4]) by SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 11:46:26 +0000
From:   "Chindris, Mihail" <Mihail.Chindris@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>
Subject: RE: [PATCH v2 2/2] drivers:iio:dac: Add AD3552R driver support
Thread-Topic: [PATCH v2 2/2] drivers:iio:dac: Add AD3552R driver support
Thread-Index: AQHXvEGbYkOuCXJpRESLjJiEqvjycKvMYOOAgA3hg3A=
Date:   Tue, 19 Oct 2021 11:46:26 +0000
Message-ID: <SJ0PR03MB5791E3C382232E22B41247D799BD9@SJ0PR03MB5791.namprd03.prod.outlook.com>
References: <20211008123909.1901-1-mihail.chindris@analog.com>
        <20211008123909.1901-3-mihail.chindris@analog.com>
 <20211010163715.3515a6d1@jic23-huawei>
In-Reply-To: <20211010163715.3515a6d1@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWNoaW5kcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0yZWZjYmE3Ni0zMGQyLTExZWMtODQwMi05OGU3?=
 =?us-ascii?Q?NDNlYTZmNDhcYW1lLXRlc3RcMmVmY2JhNzgtMzBkMi0xMWVjLTg0MDItOThl?=
 =?us-ascii?Q?NzQzZWE2ZjQ4Ym9keS50eHQiIHN6PSI1MTUyNCIgdD0iMTMyNzkxMTc1ODQx?=
 =?us-ascii?Q?OTkzNzQ0IiBoPSJkRVk0RHljc21WT2NXeWt1RG8xWHI1bS81OEE9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NB?=
 =?us-ascii?Q?QUFRVkY3eDNzVFhBVWplV2Y1RHZUbXJTTjVaL2tPOU9hc0RBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?YVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpB?=
 =?us-ascii?Q?RjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFk?=
 =?us-ascii?Q?UUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFE?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9t?=
 =?us-ascii?Q?ZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ada1c76-1e4f-4d9d-1b5d-08d992f61561
x-ms-traffictypediagnostic: BYAPR03MB4888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR03MB488863FFDBDD53A8E14FC3C699BD9@BYAPR03MB4888.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ud+hyKucaZWR7pxxIo389IWz6PoA7U4wN2ijaCTbuzwXjYg8TG9HOOFJUzLE55+YHtynMvY0VLbk716lHKfWu2sQrRwCSO0jg2fzQJvR8LohhgqAkzzklzocw8c4Veeh+M+VPHqKEXhPbeFxt5RVrKpAQ6ayMdOXZW9X6MwbKiPj/75VaYL7toa6hvNQ9vE5eihHxlCPkwW8TtXlsyffuekLsXnwlrNcuLz60yTGnysAQ3LArW7CmZ0KNRN1SSRS4oxQmMlZ/KCrjtPAQyBzJEwUcQF20X9Cyy0EhO6jG0ONr2Ol+NIhdhzaebavnG2cmrg/W/4WAse/XGhkkqaNWMgECoY0jFV+5VxGrHYJdxaEGXrluudjVr3eIxF/nFx+hntMY1hgh0qsvN9MZ8pcff98HW63xdmjpRdaANI1wAvLelU2QDjEV2vMZe4p6dfj8CLpNLac3wJUveNIiuPEUV4yqCbhprl+dRBM5GJCIj55Huf9aXRVVsJF60Lvk8PQr+AKVPqd8hMIhCIL0FCKQy4R3a2RwcjpC8pbFnH62fo5eVJjL1DevNUq/KhG2Pj0rHJCbu2A2pfzsLTTCtUgW3NdWqIF6bZou57VazFrvZKeBAQj/nzX6bzxTAlIFsdDTScmRJDVaz1tYDv4r4gqJ2lP9wR1KRrNg3xROgd6KpfZJ3V9VWp+aVThg2r/dYEwnLKdj4nsIjdvfzBnD4xtDvv3xHYx1CVUzCkAtrc+f0yPV0TPL+Fhn7aCYZh4ZJ+krlTuvRuWitlOcM2uQ/JEXef3cF6hdsrQ2/LNC0wiaHNlMjQymMASNxCRcIzlccOY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5791.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(122000001)(86362001)(5660300002)(966005)(316002)(2906002)(71200400001)(8676002)(8936002)(4326008)(38100700002)(52536014)(38070700005)(30864003)(76116006)(54906003)(66556008)(83380400001)(66476007)(9686003)(6916009)(64756008)(66946007)(66446008)(107886003)(186003)(7696005)(6506007)(33656002)(55016002)(53546011)(559001)(579004)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RX3FB6+420aVJPTRcr341dtsqSWGpMVjQBVfV8r0QSloH2KrIKfHuqFKkaQG?=
 =?us-ascii?Q?aEGz5WiZ1x5VpbNCpOM5pPzuLZj9k560RZQKpzVxxFbpaZJAYzIFOP0PL/mS?=
 =?us-ascii?Q?uk5+6F65YIfueh2bW3t4ZZen/UrhYuu3XFyzYI3jDJWSywxPCh4snTHzPOM8?=
 =?us-ascii?Q?+QQczG8EUiGaL+UWRWBjfNGb+TL1E3gCKwlw29SgHlTiuNpicvAG9GVj98ut?=
 =?us-ascii?Q?uKn9ywe+VQgz8QbPOb/4MePSRtDPGNcwfRfT1QO+rcRHiIb5EBaa8rojVKuK?=
 =?us-ascii?Q?og7PCW2pU4GgwmbzMNwlXE7TIPp8HApAKHR5vr6rHfH/G5Q7DXAl0tVYoYu9?=
 =?us-ascii?Q?aSxGxEoKT+6alC3r8V6bJlnD2HeTVeXqF+2hBfLxYLOZIvcjQ45B5QFsSoJn?=
 =?us-ascii?Q?9uEdmZ73FIOUq3lZMViEve6bY6QwVE2hzL4OvuMQerjKfDgQGm+oC6Ub8jLw?=
 =?us-ascii?Q?/p+UPSZqkclZUpu1DQQAj4VjyNjeXgKP7ehC5nll1i8naBuXDMpsBj9cdMZW?=
 =?us-ascii?Q?HMaM4UP+gbAZs/GSG1DYwQ3KTn+L3SOkzBB7mFzYwvGYYelt3PL3XWGJV2gs?=
 =?us-ascii?Q?n0WJ5N9M4jDWsx3dYw4K4+PK8iONqXPnrucSR4YiEJ8Axk7QqnKFoznmeqHg?=
 =?us-ascii?Q?bqftB8ksTmjmpQ7/QC4cJSu2LTwwzPIu4lu2StQTupOm7+3T1NzE+88LOCle?=
 =?us-ascii?Q?nzgtDn2FMF/sYbw38yF/48EyIS6HnIpyp8dJYXnipOMIqNyclvcXtyhTx2jS?=
 =?us-ascii?Q?rcUUoJwVCy4sp6OzB0Ab2EoY5fNPhEDFFheX3AS9Kq8CFqbjBrYDil1eB627?=
 =?us-ascii?Q?XKg5sq6IXNMr638YfIGRlEx7wrJ+SmhO1xkN4BckZKd/kun4UPvJTzzFJuGO?=
 =?us-ascii?Q?UbgUNoZtM9+QPaJofS0jgwhwOidBZtp8JXDQaCDN7U8mv9HpI2SwCHQZyorU?=
 =?us-ascii?Q?e+XVBgNFQZBL+shGFoJBDeLG0A9iOTL27bHH9+AZjeuWVky5dHqiYRAIRhBH?=
 =?us-ascii?Q?GTMHJD9p4lukfYjcL+GYlP4Kpb4O9/eN+byf1T4bDTW9yxr5HBz/sA0qcmHQ?=
 =?us-ascii?Q?92egykx2rVoWE7giqqsGvbtsHmQe+HvSYU9gzvyRxL/EHrfbLUEg9/pjxQgH?=
 =?us-ascii?Q?4UNphD2U+HS89J80N+jiJhHquIVAeGVQ7/pFuHgUC7uqfP20QpIHgL8Oo5Qj?=
 =?us-ascii?Q?ESIu5Bvz9afuo306usbEHHYFrpovY0Hls7IlSAM0A+Y2KPgrcwXjKga1khzz?=
 =?us-ascii?Q?8Qm0Au6LgmZTSHZdTtFaXsuiiCkzujxxO9Vd6sef/bQYybf8HcURqinCVBPO?=
 =?us-ascii?Q?ecstiayVxHEpBr0uxtoVsAIDcYHoOaRXqx2e2gdMGflcsmi3JRs+f8B1dSly?=
 =?us-ascii?Q?tRveG4Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5791.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ada1c76-1e4f-4d9d-1b5d-08d992f61561
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 11:46:26.6049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEZyduxqh7pEVECPywXt83Sh5LHpfdWI6jNuUMj4gAxwLkp5TRg4cHFiuigcRzHqYNe1Oxs3NUc0LhVGQrhDLG+o+QzIbxPFnaBR9hnzTTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4888
X-Proofpoint-GUID: jH8VA5afAW3e9zmejapZmeVsyfAxndEj
X-Proofpoint-ORIG-GUID: jH8VA5afAW3e9zmejapZmeVsyfAxndEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_01,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190070
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, 10 October 2021 18:37
> To: Chindris, Mihail <Mihail.Chindris@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; lars@metafoo=
.de;
> Hennerich, Michael <Michael.Hennerich@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; Bogdan, Dragos <Dragos.Bogdan@analog.com>;
> alexandru.ardelean@analog.com
> Subject: Re: [PATCH v2 2/2] drivers:iio:dac: Add AD3552R driver support
>=20
> On Fri, 8 Oct 2021 12:39:09 +0000
> Mihail Chindris <mihail.chindris@analog.com> wrote:
>=20
> > The AD3552R-16 is a low drift ultrafast, 16-bit accuracy, current
> > output digital-to-analog converter (DAC) designed to generate multiple
> > output voltage span ranges.
> > The AD3552R-16 operates with a fixed 2.5V reference.
> >
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-sheets/ad
> > 3552r.pdf
> >
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
>=20
> Hi Mihail,
>=20
> I would reduce the use of the attr and single function does everything ap=
proach
> as that is significantly reducing readability.  Sometimes it's worth spen=
ding
> extra lines of code to remove abstractions that end up with a lot of spec=
ial
> casing as is happening here.
>=20
> Other comments inline.
>=20
> > ---
> >  drivers/iio/dac/Kconfig   |   10 +
> >  drivers/iio/dac/Makefile  |    1 +
> >  drivers/iio/dac/ad3552r.c | 1396
> > +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1407 insertions(+)
> >  create mode 100644 drivers/iio/dac/ad3552r.c
> >
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig index
> > 75e1f2b48638..ced6428f2c92 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -6,6 +6,16 @@
> >
> >  menu "Digital to analog converters"
> >
> > +config AD3552R
> > +	tristate "Analog Devices AD3552R DAC driver"
> > +	depends on SPI_MASTER
> > +	help
> > +	  Say yes here to build support for Analog Devices AD3552R
> > +	  Digital to Analog Converter.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ad3552r.
> > +
> >  config AD5064
> >  	tristate "Analog Devices AD5064 and similar multi-channel DAC driver"
> >  	depends on (SPI_MASTER && I2C!=3Dm) || I2C diff --git
> > a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile index
> > 33e16f14902a..dffe36efd8ff 100644
> > --- a/drivers/iio/dac/Makefile
> > +++ b/drivers/iio/dac/Makefile
> > @@ -4,6 +4,7 @@
> >  #
> >
> >  # When adding new entries keep the list in alphabetical order
> > +obj-$(CONFIG_AD3552R) +=3D ad3552r.o
> >  obj-$(CONFIG_AD5360) +=3D ad5360.o
> >  obj-$(CONFIG_AD5380) +=3D ad5380.o
> >  obj-$(CONFIG_AD5421) +=3D ad5421.o
> > diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c new
> > file mode 100644 index 000000000000..42080183b77c
> > --- /dev/null
> > +++ b/drivers/iio/dac/ad3552r.c
> > @@ -0,0 +1,1396 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices AD3552R
> > + * Digital to Analog converter driver
> > + *
> > + * Copyright 2021 Analog Devices Inc.
> > + */
> > +#include <asm/unaligned.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h> #include
> > +<linux/iio/trigger_consumer.h> #include <linux/iopoll.h> #include
> > +<linux/kernel.h> #include <linux/regulator/consumer.h> #include
> > +<linux/spi/spi.h>
> > +
> > +/* Register addresses */
> > +/* Primary address space */
> > +#define AD3552R_REG_ADDR_INTERFACE_CONFIG_A		0x00
> > +#define   AD3552R_MASK_SOFTWARE_RESET			(BIT(7) |
> BIT(0))
> > +#define   AD3552R_MASK_ADDR_ASCENSION			BIT(5)
> > +#define   AD3552R_MASK_SDO_ACTIVE			BIT(4)
> > +#define AD3552R_REG_ADDR_INTERFACE_CONFIG_B		0x01
> > +#define   AD3552R_MASK_SINGLE_INST			BIT(7)
> > +#define   AD3552R_MASK_SHORT_INSTRUCTION		BIT(3)
> > +#define AD3552R_REG_ADDR_DEVICE_CONFIG			0x02
> > +#define   AD3552R_MASK_DEVICE_STATUS(n)			BIT(4
> + (n))
> > +#define   AD3552R_MASK_CUSTOM_MODES			GENMASK(3,
> 2)
> > +#define   AD3552R_MASK_OPERATING_MODES
> 	GENMASK(1, 0)
> > +#define AD3552R_REG_ADDR_CHIP_TYPE			0x03
> > +#define   AD3552R_MASK_CLASS				GENMASK(7,
> 0)
> > +#define AD3552R_REG_ADDR_PRODUCT_ID_L			0x04
> > +#define AD3552R_REG_ADDR_PRODUCT_ID_H			0x05
> > +#define AD3552R_REG_ADDR_CHIP_GRADE			0x06
> > +#define   AD3552R_MASK_GRADE				GENMASK(7,
> 4)
> > +#define   AD3552R_MASK_DEVICE_REVISION			GENMASK(3,
> 0)
> > +#define AD3552R_REG_ADDR_SCRATCH_PAD			0x0A
> > +#define AD3552R_REG_ADDR_SPI_REVISION			0x0B
> > +#define AD3552R_REG_ADDR_VENDOR_L			0x0C
> > +#define AD3552R_REG_ADDR_VENDOR_H			0x0D
> > +#define AD3552R_REG_ADDR_STREAM_MODE			0x0E
> > +#define   AD3552R_MASK_LENGTH				GENMASK(7,
> 0)
> > +#define AD3552R_REG_ADDR_TRANSFER_REGISTER		0x0F
> > +#define   AD3552R_MASK_MULTI_IO_MODE			GENMASK(7,
> 6)
> > +#define   AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE		BIT(2)
> > +#define AD3552R_REG_ADDR_INTERFACE_CONFIG_C		0x10
> > +#define   AD3552R_MASK_CRC_ENABLE			(GENMASK(7,
> 6) |\
> > +							 GENMASK(1, 0))
> > +#define   AD3552R_MASK_STRICT_REGISTER_ACCESS		BIT(5)
> > +#define AD3552R_REG_ADDR_INTERFACE_STATUS_A		0x11
> > +#define   AD3552R_MASK_INTERFACE_NOT_READY		BIT(7)
> > +#define   AD3552R_MASK_CLOCK_COUNTING_ERROR		BIT(5)
> > +#define   AD3552R_MASK_INVALID_OR_NO_CRC		BIT(3)
> > +#define   AD3552R_MASK_WRITE_TO_READ_ONLY_REGISTER	BIT(2)
> > +#define   AD3552R_MASK_PARTIAL_REGISTER_ACCESS		BIT(1)
> > +#define   AD3552R_MASK_REGISTER_ADDRESS_INVALID		BIT(0)
> > +#define AD3552R_REG_ADDR_INTERFACE_CONFIG_D		0x14
> > +#define   AD3552R_MASK_ALERT_ENABLE_PULLUP		BIT(6)
> > +#define   AD3552R_MASK_MEM_CRC_EN			BIT(4)
> > +#define   AD3552R_MASK_SDO_DRIVE_STRENGTH		GENMASK(3,
> 2)
> > +#define   AD3552R_MASK_DUAL_SPI_SYNCHROUNOUS_EN		BIT(1)
> > +#define   AD3552R_MASK_SPI_CONFIG_DDR			BIT(0)
> > +#define AD3552R_REG_ADDR_SH_REFERENCE_CONFIG		0x15
> > +#define   AD3552R_MASK_IDUMP_FAST_MODE			BIT(6)
> > +#define   AD3552R_MASK_SAMPLE_HOLD_DIFFERENTIAL_USER_EN	BIT(5)
> > +#define   AD3552R_MASK_SAMPLE_HOLD_USER_TRIM
> 	GENMASK(4, 3)
> > +#define   AD3552R_MASK_SAMPLE_HOLD_USER_ENABLE		BIT(2)
> > +#define   AD3552R_MASK_REFERENCE_VOLTAGE_SEL		GENMASK(1,
> 0)
> > +#define AD3552R_REG_ADDR_ERR_ALARM_MASK			0x16
> > +#define   AD3552R_MASK_REF_RANGE_ALARM			BIT(6)
> > +#define   AD3552R_MASK_CLOCK_COUNT_ERR_ALARM		BIT(5)
> > +#define   AD3552R_MASK_MEM_CRC_ERR_ALARM		BIT(4)
> > +#define   AD3552R_MASK_SPI_CRC_ERR_ALARM		BIT(3)
> > +#define   AD3552R_MASK_WRITE_TO_READ_ONLY_ALARM		BIT(2)
> > +#define   AD3552R_MASK_PARTIAL_REGISTER_ACCESS_ALARM	BIT(1)
> > +#define   AD3552R_MASK_REGISTER_ADDRESS_INVALID_ALARM	BIT(0)
> > +#define AD3552R_REG_ADDR_ERR_STATUS			0x17
> > +#define   AD3552R_MASK_REF_RANGE_ERR_STATUS			BIT(6)
> > +#define   AD3552R_MASK_DUAL_SPI_STREAM_EXCEEDS_DAC_ERR_STATUS
> 	BIT(5)
> > +#define   AD3552R_MASK_MEM_CRC_ERR_STATUS			BIT(4)
> > +#define   AD3552R_MASK_RESET_STATUS				BIT(0)
> > +#define AD3552R_REG_ADDR_POWERDOWN_CONFIG		0x18
> > +#define   AD3552R_MASK_CH_DAC_POWERDOWN(ch)		BIT(4
> + (ch))
> > +#define   AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(ch)	BIT(ch)
> > +#define AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE		0x19
> > +#define   AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch)		((ch) ?
> GENMASK(7, 4) :\
> > +							 GENMASK(3, 0))
> > +#define AD3552R_REG_ADDR_CH_OFFSET(ch)			(0x1B
> + (ch) * 2)
> > +#define   AD3552R_MASK_CH_OFFSET_BITS_0_7		GENMASK(7,
> 0)
> > +#define AD3552R_REG_ADDR_CH_GAIN(ch)			(0x1C + (ch) *
> 2)
> > +#define   AD3552R_MASK_CH_RANGE_OVERRIDE		BIT(7)
> > +#define   AD3552R_MASK_CH_GAIN_SCALING_N		GENMASK(6,
> 5)
> > +#define   AD3552R_MASK_CH_GAIN_SCALING_P		GENMASK(4,
> 3)
> > +#define   AD3552R_MASK_CH_OFFSET_POLARITY		BIT(2)
> > +#define   AD3552R_MASK_CH_OFFSET_BIT_8			BIT(0)
> > +/*
> > + * Secondary region
> > + * For multibyte registers specify the highest address because the
> > +access is
> > + * done in descending order
> > + */
> > +#define AD3552R_SECONDARY_REGION_START			0x28
> > +#define AD3552R_REG_ADDR_HW_LDAC_16B			0x28
> > +#define AD3552R_REG_ADDR_CH_DAC_16B(ch)			(0x2C
> - (1 - ch) * 2)
> > +#define AD3552R_REG_ADDR_DAC_PAGE_MASK_16B		0x2E
> > +#define AD3552R_REG_ADDR_CH_SELECT_16B			0x2F
> > +#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_16B		0x31
> > +#define AD3552R_REG_ADDR_SW_LDAC_16B			0x32
> > +#define AD3552R_REG_ADDR_CH_INPUT_16B(ch)		(0x36 - (1 -
> ch) * 2)
> > +/* 3 bytes registers */
> > +#define AD3552R_REG_START_24B				0x37
> > +#define AD3552R_REG_ADDR_HW_LDAC_24B			0x37
> > +#define AD3552R_REG_ADDR_CH_DAC_24B(ch)			(0x3D
> - (1 - ch) * 3)
> > +#define AD3552R_REG_ADDR_DAC_PAGE_MASK_24B		0x40
> > +#define AD3552R_REG_ADDR_CH_SELECT_24B			0x41
> > +#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_24B		0x44
> > +#define AD3552R_REG_ADDR_SW_LDAC_24B			0x45
> > +#define AD3552R_REG_ADDR_CH_INPUT_24B(ch)		(0x4B - (1 -
> ch) * 3)
> > +
> > +/* Useful defines */
> > +#define AD3552R_NUM_CH					2
> > +#define AD3552R_MASK_CH(ch)				BIT(ch)
> > +#define AD3552R_MASK_ALL_CH				GENMASK(1,
> 0)
> > +#define AD3552R_PAGE_CH					2
> > +#define AD3552R_MAX_REG_SIZE				3
> > +#define AD3552R_READ_BIT				(1 << 7)
> > +#define AD3552R_ADDR_MASK				GENMASK(6,
> 0)
> > +#define AD3552R_CRC_ENABLE_VALUE			(BIT(6) |
> BIT(1))
> > +#define AD3552R_CRC_DISABLE_VALUE			GENMASK(1,
> 0)
> > +#define AD3552R_CRC_POLY				0x07
> > +#define AD3552R_CRC_SEED				0xA5
> > +#define AD3552R_MASK_DAC_12B				0xFFF0
> > +#define AD3552R_DEFAULT_CONFIG_B_VALUE			0x8
> > +#define AD3552R_SCRATCH_PAD_TEST_VAL1			0x34
> > +#define AD3552R_SCRATCH_PAD_TEST_VAL2			0xB2
> > +#define AD3552R_GAIN_SCALE				1000
> > +#define AD3552R_LDAC_PULSE_US				100
> > +
> > +enum ad3552r_ch_vref_select {
> > +	/* Internal source with Vref I/O floating */
> > +	AD3552R_INTERNAL_VREF_PIN_FLOATING,
> > +	/* Internal source with Vref I/O at 2.5V */
> > +	AD3552R_INTERNAL_VREF_PIN_2P5V,
> > +	/* External source with Vref I/O as input */
> > +	AD3552R_EXTERNAL_VREF_PIN_INPUT
> > +};
> > +
> > +enum ad3542r_id {
> > +	AD3542R_ID =3D 0x4008,
> > +	AD3552R_ID =3D 0x4009,
> > +};
> > +
> > +enum ad3552r_ch_output_range {
> > +	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
> > +	AD3552R_CH_OUTPUT_RANGE_0__2P5V,
> > +	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
> > +	AD3552R_CH_OUTPUT_RANGE_0__5V,
> > +	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
> > +	AD3552R_CH_OUTPUT_RANGE_0__10V,
> > +	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
> > +	AD3552R_CH_OUTPUT_RANGE_NEG_5__5V,
> > +	/* Range from -10 V to 10 V. Requires Rfb4x connection  */
> > +	AD3552R_CH_OUTPUT_RANGE_NEG_10__10V,
> > +};
> > +
> > +static const s32 ad3552r_ch_ranges[][2] =3D {
> > +	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	=3D {0, 2500},
> > +	[AD3552R_CH_OUTPUT_RANGE_0__5V]		=3D {0, 5000},
> > +	[AD3552R_CH_OUTPUT_RANGE_0__10V]	=3D {0, 10000},
> > +	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	=3D {-5000, 5000},
> > +	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	=3D {-10000, 10000}
> > +};
> > +
> > +enum ad3542r_ch_output_range {
> > +	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
> > +	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
> > +	/* Range from 0 V to 3 V. Requires Rfb1x connection  */
> > +	AD3542R_CH_OUTPUT_RANGE_0__3V,
> > +	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
> > +	AD3542R_CH_OUTPUT_RANGE_0__5V,
> > +	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
> > +	AD3542R_CH_OUTPUT_RANGE_0__10V,
> > +	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
> > +	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
> > +	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
> > +	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
> > +};
> > +
> > +static const s32 ad3542r_ch_ranges[][2] =3D {
> > +	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	=3D {0, 2500},
> > +	[AD3542R_CH_OUTPUT_RANGE_0__3V]		=3D {0, 3000},
> > +	[AD3542R_CH_OUTPUT_RANGE_0__5V]		=3D {0, 5000},
> > +	[AD3542R_CH_OUTPUT_RANGE_0__10V]	=3D {0, 10000},
> > +	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	=3D {-2500,
> 7500},
> > +	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	=3D {-5000, 5000}
> > +};
> > +
> > +enum ad3552r_ch_gain_scaling {
> > +	/* Gain scaling of 1 */
> > +	AD3552R_CH_GAIN_SCALING_1,
> > +	/* Gain scaling of 0.5 */
> > +	AD3552R_CH_GAIN_SCALING_0_5,
> > +	/* Gain scaling of 0.25 */
> > +	AD3552R_CH_GAIN_SCALING_0_25,
> > +	/* Gain scaling of 0.125 */
> > +	AD3552R_CH_GAIN_SCALING_0_125,
> > +};
> > +
> > +/* Gain * AD3552R_GAIN_SCALE */
> > +static const s32 gains_scaling_table[] =3D {
> > +	[AD3552R_CH_GAIN_SCALING_1]		=3D 1000,
> > +	[AD3552R_CH_GAIN_SCALING_0_5]		=3D 500,
> > +	[AD3552R_CH_GAIN_SCALING_0_25]		=3D 250,
> > +	[AD3552R_CH_GAIN_SCALING_0_125]		=3D 125
> > +};
> > +
> > +enum ad3552r_dev_attributes {
> > +	/* - Direct register values */
> > +	/* From 0-3 */
> > +	AD3552R_SDO_DRIVE_STRENGTH,
> > +	/*
> > +	 * 0 -> Internal Vref, vref_io pin floating (default)
> > +	 * 1 -> Internal Vref, vref_io driven by internal vref
> > +	 * 2 or 3 -> External Vref
> > +	 */
> > +	AD3552R_VREF_SELECT,
> > +	/* Enable / Disable CRC */
> > +	AD3552R_CRC_ENABLE,
> > +	/* Spi mode: Strandard, Dual or Quad */
> > +	AD3552R_SPI_MULTI_IO_MODE,
> > +	/* Spi data rate: Single or dual */
> > +	AD3552R_SPI_DATA_RATE,
> > +	/* Dual spi synchronous mode */
> > +	AD3552R_SPI_SYNCHRONOUS_ENABLE,
> > +
> > +	/* - Direct register values (Private) */
> > +	/* Read registers in ascending order if set. Else descending */
> > +	AD3552R_ADDR_ASCENSION,
> > +	/* Single instruction mode if set. Else, stream mode */
> > +	AD3552R_SINGLE_INST,
> > +	/* Number of addresses to loop on when stream writing. */
> > +	AD3552R_STREAM_MODE,
> > +	/* Keep stream value if set. */
> > +	AD3552R_STREAM_LENGTH_KEEP_VALUE,
> > +};
> > +
> > +enum ad3552r_ch_attributes {
> > +	/* DAC powerdown */
> > +	AD3552R_CH_DAC_POWERDOWN,
> > +	/* DAC amplifier powerdown */
> > +	AD3552R_CH_AMPLIFIER_POWERDOWN,
> > +	/* Select the output range. Select from enum
> ad3552r_ch_output_range */
> > +	AD3552R_CH_OUTPUT_RANGE_SEL,
> > +	/*
> > +	 * Over-rider the range selector in order to manually set the output
> > +	 * voltage range
> > +	 */
> > +	AD3552R_CH_RANGE_OVERRIDE,
> > +	/* Manually set the offset voltage */
> > +	AD3552R_CH_GAIN_OFFSET,
> > +	/* Sets the polarity of the offset. */
> > +	AD3552R_CH_GAIN_OFFSET_POLARITY,
> > +	/* PDAC gain scaling */
> > +	AD3552R_CH_GAIN_SCALING_P,
> > +	/* NDAC gain scaling */
> > +	AD3552R_CH_GAIN_SCALING_N,
> > +	/* Trigger a software LDAC */
> > +	AD3552R_CH_TRIGGER_SOFTWARE_LDAC,
> > +	/* Hardware LDAC Mask */
> > +	AD3552R_CH_HW_LDAC_MASK,
> > +	/* Rfb value */
> > +	AD3552R_CH_RFB,
> > +	/* Channel select. When set allow Input -> DAC and Mask -> DAC */
> > +	AD3552R_CH_SELECT,
> > +	/* Raw value to be set to dac */
> > +	AD3552R_CH_CODE
> > +};
> > +
> > +struct ad3552r_ch_data {
> > +	u16	gain_offset;
> > +	bool	range_override;
> > +	u8	n;
> > +	u8	p;
> > +	bool	offset_polarity;
> > +	u16	rfb;
> > +	u8	range;
>=20
> Unless there is a strong reason not to, group types as it will use less m=
emory as
> we need less padding.
>=20
> > +	s32	scale_int;
> > +	s32	scale_dec;
> > +	s32	offset_int;
> > +	s32	offset_dec;
> > +};
> > +
> > +struct ad3552r_desc {
> > +	/* Used to look the spi bus for atomic operations where needed */
> > +	struct mutex		lock;
> > +	struct gpio_desc	*gpio_reset;
> > +	struct gpio_desc	*gpio_ldac;
> > +	struct spi_device	*spi;
> > +	struct ad3552r_ch_data	ch_data[AD3552R_NUM_CH];
> > +	struct iio_chan_spec	channels[AD3552R_NUM_CH + 1];
> > +	unsigned long		enabled_ch;
> > +	unsigned int		num_ch;
> > +	enum ad3542r_id		chip_id;
> > +	/*
> > +	 * The maximum spi transfer size consist 1 bytes (reg address)
> > +	 * + 2 registers of 3 bytes + 1 reg of 1 byte (SW LDAC)
> > +	 */
> > +	u8 buf_data[8] ____cacheline_aligned; };
> > +
> > +static const u16 addr_mask_map[][2] =3D {
> > +	[AD3552R_ADDR_ASCENSION] =3D {
> > +			AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> > +			AD3552R_MASK_ADDR_ASCENSION
> > +	},
> > +	[AD3552R_SINGLE_INST] =3D {
> > +			AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> > +			AD3552R_MASK_SINGLE_INST
> > +	},
> > +	[AD3552R_STREAM_MODE] =3D {
> > +			AD3552R_REG_ADDR_STREAM_MODE,
> > +			AD3552R_MASK_LENGTH
> > +	},
> > +	[AD3552R_STREAM_LENGTH_KEEP_VALUE] =3D {
> > +			AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > +			AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE
> > +	},
> > +	[AD3552R_SDO_DRIVE_STRENGTH] =3D {
> > +			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > +			AD3552R_MASK_SDO_DRIVE_STRENGTH
> > +	},
> > +	[AD3552R_VREF_SELECT] =3D {
> > +			AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> > +			AD3552R_MASK_REFERENCE_VOLTAGE_SEL
> > +	},
> > +	[AD3552R_CRC_ENABLE] =3D {
> > +			AD3552R_REG_ADDR_INTERFACE_CONFIG_C,
> > +			AD3552R_MASK_CRC_ENABLE
> > +	},
> > +	[AD3552R_SPI_MULTI_IO_MODE] =3D {
> > +			AD3552R_REG_ADDR_TRANSFER_REGISTER,
> > +			AD3552R_MASK_MULTI_IO_MODE
> > +	},
> > +	[AD3552R_SPI_DATA_RATE] =3D {
> > +			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > +			AD3552R_MASK_SPI_CONFIG_DDR
> > +	},
> > +	[AD3552R_SPI_SYNCHRONOUS_ENABLE] =3D {
> > +			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> > +			AD3552R_MASK_DUAL_SPI_SYNCHROUNOUS_EN
> > +	},
> > +};
> > +
> > +/* 0 -> reg addr, 1->ch0 mask, 2->ch1 mask */ static const u16
> > +addr_mask_map_ch[][3] =3D {
> > +	[AD3552R_CH_DAC_POWERDOWN] =3D {
> > +			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> > +			AD3552R_MASK_CH_DAC_POWERDOWN(0),
> > +			AD3552R_MASK_CH_DAC_POWERDOWN(1)
> > +	},
> > +	[AD3552R_CH_AMPLIFIER_POWERDOWN] =3D {
> > +			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> > +			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(0),
> > +			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(1)
> > +	},
> > +	[AD3552R_CH_OUTPUT_RANGE_SEL] =3D {
> > +			AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> > +			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0),
> > +			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1)
> > +	},
> > +	/*
> > +	 * This attributes are update by the chip on 16B and 24B no matter to
> > +	 * what register the write is done
> > +	 */
> > +	[AD3552R_CH_TRIGGER_SOFTWARE_LDAC] =3D {
> > +			AD3552R_REG_ADDR_SW_LDAC_16B,
> > +			AD3552R_MASK_CH(0),
> > +			AD3552R_MASK_CH(1)
> > +	},
> > +	[AD3552R_CH_HW_LDAC_MASK] =3D {
> > +			AD3552R_REG_ADDR_HW_LDAC_16B,
> > +			AD3552R_MASK_CH(0),
> > +			AD3552R_MASK_CH(1)
> > +	},
> > +	[AD3552R_CH_SELECT] =3D {
> > +			AD3552R_REG_ADDR_CH_SELECT_16B,
> > +			AD3552R_MASK_CH(0),
> > +			AD3552R_MASK_CH(1)
> > +	}
> > +};
> > +
> > +static u8 _ad3552r_reg_len(u8 addr)
> > +{
> > +	switch (addr) {
> > +	case AD3552R_REG_ADDR_HW_LDAC_16B:
> > +	case AD3552R_REG_ADDR_CH_SELECT_16B:
> > +	case AD3552R_REG_ADDR_SW_LDAC_16B:
> > +	case AD3552R_REG_ADDR_HW_LDAC_24B:
> > +	case AD3552R_REG_ADDR_CH_SELECT_24B:
> > +	case AD3552R_REG_ADDR_SW_LDAC_24B:
> > +		return 1;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	if (addr > AD3552R_REG_ADDR_HW_LDAC_24B)
> > +		return 3;
> > +	if (addr > AD3552R_REG_ADDR_HW_LDAC_16B)
> > +		return 2;
> > +
> > +	return 1;
> > +}
> > +
> > +/* SPI transfer to device */
> > +static int ad3552r_transfer(struct ad3552r_desc *dac, u8 addr, u32 len=
,
> > +			    u8 *data, bool is_read)
> > +{
> > +	int err;
> > +	u8 instr;
> > +
> > +	instr =3D addr & AD3552R_ADDR_MASK;
> > +	instr |=3D is_read ? AD3552R_READ_BIT : 0;
> > +	dac->buf_data[0] =3D instr;
> > +	if (is_read) {
> > +		err =3D spi_write_then_read(dac->spi, dac->buf_data, 1,
> > +					  dac->buf_data + 1, len);
> > +		if (err)
> > +			return err;
> > +
> > +		memcpy(data, dac->buf_data + 1, len);
> IIRC spi_write_the_read() doesn't require a dma safe buffer. As such you =
can
> provide the *data pointer directly to the spi_write_the_read call and avo=
id
> copying it twice.
>=20
> Note that's no the case for spi_write(), but you can call spi_write_then_=
read
> with a zero length n_rx if you want to and avoid the explicit memcpy here=
.
>=20
> > +
> > +		return 0;
> > +	}
> > +
> > +	memcpy(dac->buf_data + 1, data, len);
> > +	return spi_write(dac->spi, dac->buf_data, len + 1); }
> > +
> > +static int ad3552r_write_reg(struct ad3552r_desc *dac, u8 addr, u16
> > +val) {
> > +	u8 reg_len;
> > +	u8 buf[AD3552R_MAX_REG_SIZE] =3D { 0 };
> > +
> > +	reg_len =3D _ad3552r_reg_len(addr);
> > +	if (reg_len =3D=3D 2)
> > +		/* Only DAC register are 2 bytes wide */
> > +		val &=3D AD3552R_MASK_DAC_12B;
> > +	if (reg_len =3D=3D 1)
> > +		buf[0] =3D val & 0xFF;
> > +	else
> > +		/* reg_len can be 2 or 3, but 3rd bytes needs to be set to 0 */
> > +		put_unaligned_be16(val, buf);
> > +
> > +	return ad3552r_transfer(dac, addr, reg_len, buf, false); }
> > +
> > +static int ad3552r_read_reg(struct ad3552r_desc *dac, u8 addr, u16
> > +*val) {
> > +	int err;
> > +	u8  reg_len, buf[AD3552R_MAX_REG_SIZE] =3D { 0 };
> > +
> > +	reg_len =3D _ad3552r_reg_len(addr);
> > +	err =3D ad3552r_transfer(dac, addr, reg_len, buf, true);
> > +	if (err)
> > +		return err;
> > +
> > +	if (reg_len =3D=3D 1)
> > +		*val =3D buf[0];
> > +	else
> > +		/* reg_len can be 2 or 3, but only first 2 bytes are relevant */
> > +		*val =3D get_unaligned_be16(buf);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Update field of a register, shift val if needed */ static int
> > +ad3552r_update_reg_field(struct ad3552r_desc *dac, u8 addr, u16 mask,
> > +				    u16 val)
> > +{
> > +	int ret;
> > +	u16 reg;
> > +
> > +	ret =3D ad3552r_read_reg(dac, addr, &reg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	reg =3D (reg & ~mask) | (val << __ffs(mask));
> > +
> > +	return ad3552r_write_reg(dac, addr, reg); }
> > +
> > +static int ad3552r_set_dev_value(struct ad3552r_desc *dac,
> > +				 enum ad3552r_dev_attributes attr,
> > +				 u16 val)
> > +{
> > +	switch (attr) {
> > +	case AD3552R_SPI_MULTI_IO_MODE:
> > +	case AD3552R_SPI_DATA_RATE:
> > +	case AD3552R_SPI_SYNCHRONOUS_ENABLE:
> > +	case AD3552R_CRC_ENABLE:
> > +		/* Not implemented */
> > +		return -EINVAL;
> > +	default:
> > +		return ad3552r_update_reg_field(dac,
> addr_mask_map[attr][0],
> > +						addr_mask_map[attr][1], val);
> > +	}
> > +
>=20
> Can't get here so drop this final return. However, given how simple this =
is I'd
> just put the update_reg inline in the caller locations.
>=20
> > +	return 0;
> > +}
> > +
> > +static int ad3552r_set_offset_value(struct ad3552r_desc *dac, u8 ch,
> > +int val) {
> > +	int err;
> > +
> > +	err =3D ad3552r_write_reg(dac, AD3552R_REG_ADDR_CH_OFFSET(ch),
> > +				val & AD3552R_MASK_CH_OFFSET_BITS_0_7);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D ad3552r_update_reg_field(dac,
> > +				       AD3552R_REG_ADDR_CH_GAIN(ch),
> > +				       AD3552R_MASK_CH_OFFSET_BIT_8,
> > +				       (val >> 8) &
> AD3552R_MASK_CH_OFFSET_BIT_8);
> > +	if (err)
> > +		return err;
> > +
> > +	dac->ch_data[ch].gain_offset =3D val;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad3552r_set_gain_value(struct ad3552r_desc *dac,
> > +				  enum ad3552r_ch_attributes attr,
> > +				  u8 ch,
> > +				  int val)
> > +{
> > +	int reg_mask, err;
> > +
> > +	if (attr =3D=3D AD3552R_CH_GAIN_OFFSET)
> > +		return ad3552r_set_offset_value(dac, ch, val);
> > +
> > +	switch (attr) {
> > +	case AD3552R_CH_RANGE_OVERRIDE:
>=20
> This is more complex than just having a bunch of functions, one for each =
case
> (assuming they are called from multiple locations - if not just have the =
code
> inline).
>=20
> > +		val =3D !!val;
> > +		reg_mask =3D AD3552R_MASK_CH_RANGE_OVERRIDE;
> > +		break;
> > +	case AD3552R_CH_GAIN_OFFSET_POLARITY:
> > +		val =3D !!val;
> > +		reg_mask =3D AD3552R_MASK_CH_OFFSET_POLARITY;
> > +		break;
> > +	case AD3552R_CH_GAIN_SCALING_P:
> > +		reg_mask =3D AD3552R_MASK_CH_GAIN_SCALING_P;
> > +		break;
> > +	case AD3552R_CH_GAIN_SCALING_N:
> > +		reg_mask =3D AD3552R_MASK_CH_GAIN_SCALING_N;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	err =3D ad3552r_update_reg_field(dac,
> AD3552R_REG_ADDR_CH_GAIN(ch),
> > +				       reg_mask, val);
> > +	if (err)
> > +		return err;
> > +
> > +	switch (attr) {
> > +	case AD3552R_CH_RANGE_OVERRIDE:
> > +		dac->ch_data[ch].range_override =3D val;
> > +		break;
> > +	case AD3552R_CH_GAIN_OFFSET_POLARITY:
> > +		dac->ch_data[ch].offset_polarity =3D val;
> > +		break;
> > +	case AD3552R_CH_GAIN_SCALING_P:
> > +		dac->ch_data[ch].p =3D val;
> > +		break;
> > +	case AD3552R_CH_GAIN_SCALING_N:
> > +		dac->ch_data[ch].n =3D val;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* Iterate over mask and write required bytes */ static int
> > +ad3552r_write_codes(struct ad3552r_desc *dac, u32 mask, u8 *data) {
> > +	int err, i, len, k =3D 0, ch_mask;
> > +	unsigned long lmask =3D mask;
> > +	u8 addr, buff[AD3552R_NUM_CH * AD3552R_MAX_REG_SIZE + 1];
> > +	u16 val;
> > +
> > +	/* If writing to consecutive registers do just one transfer */
> > +
> > +	if (mask =3D=3D AD3552R_MASK_ALL_CH) {
> > +		addr =3D AD3552R_REG_ADDR_CH_INPUT_24B(1);
> > +		/* CH1 */
> > +		buff[0] =3D data[2];
> > +		buff[1] =3D data[3];
> > +		buff[2] =3D 0;
> > +		/* CH0 */
> > +		buff[3] =3D data[0];
> > +		buff[4] =3D data[1];
> > +		buff[5] =3D 0;
> > +		len =3D 6;
> > +		if (!dac->gpio_ldac) {
> > +			/* Software LDAC */
> > +			buff[6] =3D AD3552R_MASK_ALL_CH;
> > +			++len;
> > +		}
> > +		err =3D ad3552r_transfer(dac, addr, len, buff, false);
> > +		if (err)
> > +			return err;
> > +
> > +	} else {
> > +		k =3D 0;
> > +		for_each_set_bit(i, &lmask, AD3552R_NUM_CH + 1) {
> > +			/* Writing to mask CH */
> > +			if (i =3D=3D AD3552R_PAGE_CH) {
> > +				addr =3D
> AD3552R_REG_ADDR_INPUT_PAGE_MASK_24B;
> > +				ch_mask =3D AD3552R_MASK_ALL_CH;
> > +			} else {
> > +				addr =3D
> AD3552R_REG_ADDR_CH_INPUT_24B(i);
> > +				ch_mask =3D AD3552R_MASK_CH(i);
> > +			}
> > +
> > +			val =3D be16_to_cpu(*((u16 *)(data + k)));
> > +			k +=3D 2;
> > +			err =3D ad3552r_write_reg(dac, addr, val);
> > +			if (err)
> > +				return err;
> > +
> > +			if (!dac->gpio_ldac) {
> > +				err =3D ad3552r_write_reg(dac,
> > +
> 	AD3552R_REG_ADDR_SW_LDAC_24B,
> > +							ch_mask);
> > +				if (err)
> > +					return err;
> > +			}
> > +		}
> > +	}
> > +
> > +	if (dac->gpio_ldac) {
> > +		gpiod_set_value_cansleep(dac->gpio_ldac, 0);
> > +		usleep_range(AD3552R_LDAC_PULSE_US,
> AD3552R_LDAC_PULSE_US + 10);
> > +		gpiod_set_value_cansleep(dac->gpio_ldac, 1);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad3552r_get_ch_value(struct ad3552r_desc *dac,
> > +				enum ad3552r_ch_attributes attr,
> > +				u8 ch,
> > +				u16 *val)
> > +{
> > +	int ret;
> > +	u16 reg;
> > +	u8  addr;
> > +	u16 mask;
> > +
> > +	/* Attributes not defined in addr_mask_map_ch */
> > +	switch (attr) {
> > +	case AD3552R_CH_CODE:
> > +		return ad3552r_read_reg(dac,
> AD3552R_REG_ADDR_CH_DAC_24B(ch),
>=20
> As below, just have multiple functions rather than trying to hammer this
> complexity into a single get_ch_value function.
>=20
> > +					val);
> > +	case AD3552R_CH_RFB:
> > +		*val =3D dac->ch_data[ch].rfb;
> > +		return 0;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	addr =3D addr_mask_map_ch[attr][0];
> > +	ret =3D ad3552r_read_reg(dac, addr, &reg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mask =3D addr_mask_map_ch[attr][ch + 1];
> > +	*val =3D (reg & mask) >> __ffs(mask);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad3552r_set_ch_value(struct ad3552r_desc *dac,
>=20
> Given the amount of 'special' case code in here for the different attrs I=
'd just
> use separate functions for each of them.
>=20
> > +				enum ad3552r_ch_attributes attr,
> > +				u8 ch,
> > +				u16 val)
> > +{
> > +	int ret;
> > +
> > +	/* Attributes not defined in addr_mask_map_ch */
> > +	switch (attr) {
> > +	case AD3552R_CH_CODE:
> > +		return ad3552r_write_reg(dac,
> AD3552R_REG_ADDR_CH_DAC_24B(ch),
> > +					 val);
> > +	case AD3552R_CH_RFB:
> > +		dac->ch_data[ch].rfb =3D val;
> > +		return 0;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	if (attr >=3D AD3552R_CH_RANGE_OVERRIDE &&
> > +	    attr <=3D AD3552R_CH_GAIN_SCALING_N)
> > +		return ad3552r_set_gain_value(dac, attr, ch, val);
> > +
> > +	/* Update register related to attributes in chip */
> > +	ret =3D ad3552r_update_reg_field(dac, addr_mask_map_ch[attr][0],
> > +				       addr_mask_map_ch[attr][ch + 1], val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Update software structures */
> > +	if (attr =3D=3D AD3552R_CH_OUTPUT_RANGE_SEL)
> > +		dac->ch_data[ch].range =3D val;
> > +
> > +	return ret;
> > +}
> > +
> > +#define AD3552R_CH_DAC(_idx) ((struct iio_chan_spec) {		\
> > +	.type =3D IIO_VOLTAGE,					\
> > +	.output =3D true,						\
> > +	.indexed =3D true,					\
> > +	.channel =3D _idx,					\
> > +	.scan_index =3D _idx,					\
> > +	.scan_type =3D {						\
> > +		.sign =3D 'u',					\
> > +		.realbits =3D 16,					\
> > +		.storagebits =3D 16,				\
> > +		.endianness =3D IIO_BE,				\
> > +	},							\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
> > +				BIT(IIO_CHAN_INFO_SCALE) |	\
> > +				BIT(IIO_CHAN_INFO_ENABLE) |	\
> > +				BIT(IIO_CHAN_INFO_OFFSET),	\
> > +})
> > +
> > +/*
> > + * Channel used to update both CH0 and CH1 with the same value by
> > + * writing only one register.
>=20
> Hmm. This is rather unusual use of the ABI.
> In a similar fashion to us only guaranteeing 'simultaneous sampling'
> when using buffered mode for input devices, I think we should map this on=
ly
> being possible if in buffered output mode.
>=20
> Then this is only useful to either minimise access or when the hardware '=
go'
> signal isn't wired up.  So I'd suggest that path does a check for the sam=
e value
> being written to both channels and uses this if appropriate.
>=20
> > + */
> > +#define AD3552R_CH_DAC_PAGE(_idx) ((struct iio_chan_spec) {	\
> > +	.type =3D IIO_VOLTAGE,					\
> > +	.output =3D true,						\
> > +	.indexed =3D true,					\
> > +	.channel =3D _idx,					\
> > +	.scan_index =3D _idx,					\
> > +	.scan_type =3D {						\
> > +		.sign =3D 'u',					\
> > +		.realbits =3D 16,					\
> > +		.storagebits =3D 16,				\
> > +		.endianness =3D IIO_BE,				\
> > +	},							\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> > +	.modified =3D 1,						\
> > +	.channel2 =3D IIO_MOD_X_AND_Z,				\
> ? Not an obvious choice even if I was happy with this approach in general=
.

So the chip has this feature of updating both channels at the same time wit=
h the same value.
Also, I found this ABI : https://www.kernel.org/doc/html/latest/admin-guide=
/abi-testing.html#abi-sys-bus-iio-devices-iio-devicex-out-voltagey-z-raw
And as per my understanding it maps well to the chip feature.
I don't know a use I just found the ABI and I though it would make sense.
I searched in to the kernel but it seems this modifier is not used anywhere=
 so I couldn't double check it utility.
Should I keep this channel or remove it?

Mihail

>=20
> > +})
> > +
> > +static int ad3552r_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val,
> > +			    int *val2,
> > +			    long mask)
> > +{
> > +	struct ad3552r_desc *dac =3D iio_priv(indio_dev);
> > +	u16 tmp_val;
> > +	int err;
> > +	u8 ch =3D chan->channel;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&dac->lock);
> > +		if (chan->channel =3D=3D AD3552R_PAGE_CH)
> > +			err =3D ad3552r_read_reg(dac,
> > +
> AD3552R_REG_ADDR_DAC_PAGE_MASK_24B,
> > +					       &tmp_val);
> > +		else
> > +			err =3D ad3552r_get_ch_value(dac, AD3552R_CH_CODE,
> ch,
> > +						   &tmp_val);
> > +		if (err < 0) {
> > +			mutex_unlock(&dac->lock);
> > +			return err;
> > +		}
> > +
> > +		*val =3D tmp_val;
> > +		mutex_unlock(&dac->lock);
> > +		break;
> > +	case IIO_CHAN_INFO_ENABLE:
> > +		mutex_lock(&dac->lock);
> > +		err =3D ad3552r_get_ch_value(dac,
> AD3552R_CH_DAC_POWERDOWN,
> > +					   ch, &tmp_val);
> > +		if (err < 0) {
> > +			mutex_unlock(&dac->lock);
> > +			return err;
> > +		}
> > +		*val =3D !tmp_val;
> > +		mutex_unlock(&dac->lock);
> > +		break;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val =3D dac->ch_data[ch].scale_int;
> > +		*val2 =3D dac->ch_data[ch].scale_dec;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		*val =3D dac->ch_data[ch].offset_int;
> > +		*val2 =3D dac->ch_data[ch].offset_dec;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int ad3552r_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val,
> > +			     int val2,
> > +			     long mask)
> > +{
> > +	struct ad3552r_desc *dac =3D iio_priv(indio_dev);
> > +	enum ad3552r_ch_attributes attr;
> > +	int err =3D 0;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (chan->channel =3D=3D AD3552R_PAGE_CH) {
> > +			mutex_lock(&dac->lock);
> > +			err =3D ad3552r_write_reg(dac,
> > +
> 	AD3552R_REG_ADDR_DAC_PAGE_MASK_24B,
> > +						val);
> > +			mutex_unlock(&dac->lock);
> > +
> > +			return err;
> > +		}
> > +
> > +		attr =3D AD3552R_CH_CODE;
> > +		break;
> > +	case IIO_CHAN_INFO_ENABLE:
> > +		attr =3D AD3552R_CH_DAC_POWERDOWN;
> > +		val =3D !val;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(&dac->lock);
> > +	err =3D ad3552r_set_ch_value(dac, attr, chan->channel, val);
> > +	mutex_unlock(&dac->lock);
> > +
> > +	return err;
> > +}
> > +
> > +static int ad3552r_update_scan_mode(struct iio_dev *indio_dev,
> > +				    const unsigned long *scan_mask) {
> > +	u32 mask;
> > +
> > +	mask =3D *scan_mask;
> > +	/* If writing to mask, can't write to other channels */
> > +	if ((mask & AD3552R_MASK_CH(AD3552R_PAGE_CH)) &&
> > +	    (mask & (~AD3552R_MASK_CH(AD3552R_PAGE_CH))))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Device type specific information.
> > + */
> > +static const struct iio_info ad3552r_iio_info =3D {
> > +	.read_raw =3D ad3552r_read_raw,
> > +	.write_raw =3D ad3552r_write_raw,
> > +	.update_scan_mode =3D ad3552r_update_scan_mode };
> > +
> > +static irqreturn_t ad3552r_trigger_handler(int irq, void *p) {
> > +	struct iio_poll_func	*pf =3D p;
> > +	struct iio_dev		*indio_dev =3D pf->indio_dev;
> > +	struct iio_buffer	*buf =3D indio_dev->buffer;
> > +	struct ad3552r_desc	*dac =3D iio_priv(indio_dev);
> > +	char			buff[AD3552R_NUM_CH *
> AD3552R_MAX_REG_SIZE];
> > +	int			err;
> > +
> > +	memset(buff, 0, sizeof(buff));
> > +	err =3D iio_pop_from_buffer(buf, buff);
> > +	if (err)
> > +		goto end;
> > +
> > +	mutex_lock(&dac->lock);
> > +	err =3D ad3552r_write_codes(dac, *indio_dev->active_scan_mask, buff);
> > +	mutex_unlock(&dac->lock);
> > +	if (err)
> > +		goto end;
> Drop this given we are going to exactly where we would otherwise be. Note
> one of the static checkers will probably complain about thsi.
> > +
> > +end:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int ad3552r_check_scratch_pad(struct ad3552r_desc *dac) {
> > +	const u16 val1 =3D AD3552R_SCRATCH_PAD_TEST_VAL1;
> > +	const u16 val2 =3D AD3552R_SCRATCH_PAD_TEST_VAL2;
> > +	u16 val;
> > +	int err;
> > +
> > +	err =3D ad3552r_write_reg(dac, AD3552R_REG_ADDR_SCRATCH_PAD,
> val1);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	err =3D ad3552r_read_reg(dac, AD3552R_REG_ADDR_SCRATCH_PAD,
> &val);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	if (val1 !=3D val)
> > +		return -ENODEV;
> > +
> > +	err =3D ad3552r_write_reg(dac, AD3552R_REG_ADDR_SCRATCH_PAD,
> val2);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	err =3D ad3552r_read_reg(dac, AD3552R_REG_ADDR_SCRATCH_PAD,
> &val);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	if (val2 !=3D val)
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> > +
> > +struct reg_addr_pool {
> > +	struct ad3552r_desc *dac;
> > +	u8		    addr;
> > +};
> > +
> > +static u16 ad3552r_read_reg_wrapper(struct reg_addr_pool *addr) {
> > +	u16 val =3D 0;
> > +
> > +	ad3552r_read_reg(addr->dac, addr->addr, &val);
> What about potential errors?  If we need to mask them then add a comment
> here on why.
> > +
> > +	return val;
> > +}
> > +
> > +static int ad3552r_reset(struct ad3552r_desc *dac) {
> > +	struct reg_addr_pool addr;
> > +	int ret;
> > +	u16 val;
> > +
> > +	dac->gpio_reset =3D devm_gpiod_get_optional(&dac->spi->dev, "reset",
> > +						  GPIOD_OUT_LOW);
> > +	if (IS_ERR(dac->gpio_reset))
> > +		return PTR_ERR(dac->gpio_reset);
>=20
> For a lot of similar paths we should use dev_err_probe() so as to registe=
r a
> 'reason' if we need to defer + provide a bit more debugging info if it is=
 a
> different error.
>=20
> > +
> > +	if (dac->gpio_reset) {
> > +		/* Perform hardware reset */
> > +		usleep_range(10, 20);
> > +		gpiod_set_value_cansleep(dac->gpio_reset, 1);
> > +	} else {
> > +		/* Perform software reset if no GPIO provided */
> > +		ret =3D ad3552r_update_reg_field(dac,
> AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> > +
> AD3552R_MASK_SOFTWARE_RESET,
> > +
> AD3552R_MASK_SOFTWARE_RESET);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +	}
> > +
> > +	addr.dac =3D dac;
> > +	addr.addr =3D AD3552R_REG_ADDR_INTERFACE_CONFIG_B;
> > +	ret =3D readx_poll_timeout(ad3552r_read_reg_wrapper, &addr, val,
> > +				 val =3D=3D AD3552R_DEFAULT_CONFIG_B_VALUE,
> > +				 5000, 50000);
> > +	if (ret) {
> > +		dev_err(&dac->spi->dev, "Err: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D readx_poll_timeout(ad3552r_read_reg_wrapper, &addr, val,
> > +				 !(val &
> AD3552R_MASK_INTERFACE_NOT_READY),
> > +				 5000, 50000);
> > +	if (ret) {
> > +		dev_err(&dac->spi->dev, "Err: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return ad3552r_set_dev_value(dac, AD3552R_ADDR_ASCENSION, 0); }
> > +
> > +static void ad3552r_get_custom_range(struct ad3552r_desc *dac, s32 i, =
s32
> *v_min,
> > +				     s32 *v_max)
> > +{
> > +	s64 vref, tmp, common, offset, gn, gp;
> > +	/*
> > +	 * From datasheet formula (In Volts):
> > +	 *	Vmin =3D 2.5 + [(GainN + Offset / 1024) * 2.5 * Rfb * 1.03]
> > +	 *	Vmax =3D 2.5 - [(GainP + Offset / 1024) * 2.5 * Rfb * 1.03]
> > +	 * Calculus are converted to milivolts
> > +	 */
> > +	vref =3D 2500;
> > +	/* 2.5 * 1.03 * 1000 (To mV) */
> > +	common =3D 2575 * dac->ch_data[i].rfb;
> > +	offset =3D dac->ch_data[i].gain_offset;
> > +	if (dac->ch_data[i].offset_polarity)
> > +		offset *=3D -1;
> > +
> > +	gn =3D gains_scaling_table[dac->ch_data[i].n];
> > +	tmp =3D (1024 * gn + AD3552R_GAIN_SCALE * offset) * common;
> > +	tmp =3D div_s64(tmp, 1024  * AD3552R_GAIN_SCALE);
> > +	*v_max =3D vref + tmp;
> > +
> > +	gp =3D gains_scaling_table[dac->ch_data[i].p];
> > +	tmp =3D (1024 * gp - AD3552R_GAIN_SCALE * offset) * common;
> > +	tmp =3D div_s64(tmp, 1024 * AD3552R_GAIN_SCALE);
> > +	*v_min =3D vref - tmp;
> > +}
> > +
> > +static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac,
> > +s32 ch) {
> > +	s32 idx, v_max, v_min, span, rem;
> > +	s64 tmp;
> > +
> > +	if (dac->ch_data[ch].range_override) {
> > +		ad3552r_get_custom_range(dac, ch, &v_min, &v_max);
> > +	} else {
> > +		/* Normal range */
> > +		idx =3D dac->ch_data[ch].range;
> > +		if (dac->chip_id =3D=3D AD3542R_ID) {
> > +			v_min =3D ad3542r_ch_ranges[idx][0];
> > +			v_max =3D ad3542r_ch_ranges[idx][1];
> > +		} else {
> > +			v_min =3D ad3552r_ch_ranges[idx][0];
> > +			v_max =3D ad3552r_ch_ranges[idx][1];
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * From datasheet formula:
> > +	 *	Vout =3D Span * (D / 65536) + Vmin
> > +	 * Converted to scale and offset:
> > +	 *	Scale =3D Span / 65536
> > +	 *	Offset =3D 65536 * Vmin / Span
> > +	 *
> > +	 * Reminders are in micros in order to be printed as
> > +	 * IIO_VAL_INT_PLUS_MICRO
> > +	 */
> > +	span =3D v_max - v_min;
> > +	dac->ch_data[ch].scale_int =3D div_s64_rem(span, 65536, &rem);
> > +	/* Do operations in microvolts */
> > +	dac->ch_data[ch].scale_dec =3D DIV_ROUND_CLOSEST((s64)rem *
> 1000000,
> > +							65536);
> > +
> > +	dac->ch_data[ch].offset_int =3D div_s64_rem(v_min * 65536, span,
> > +							&rem);
> > +	tmp =3D (s64)rem * 1000000;
> > +	dac->ch_data[ch].offset_dec =3D div_s64(tmp, span); }
> > +
> > +static const char * const gain_dts_names[] =3D {
> > +	"adi,gain-scaling-p",
> > +	"adi,gain-scaling-n",
> > +	"adi,rfb-ohms"
> > +};
> > +
> > +static int ad3552r_find_range(u16 id, u32 *vals) {
> > +	int i, len;
> > +	const s32 (*ranges)[2];
>=20
> Why are we comparing signed and unsigned values in here?
> Should vals be signed as well?
>=20
> > +
> > +	if (id =3D=3D AD3542R_ID) {
> > +		len =3D ARRAY_SIZE(ad3542r_ch_ranges);
> > +		ranges =3D ad3542r_ch_ranges;
> > +	} else {
> > +		len =3D ARRAY_SIZE(ad3552r_ch_ranges);
> > +		ranges =3D ad3552r_ch_ranges;
> > +	}
> > +
> > +	for (i =3D 0; i < len; i++)
> > +		if (vals[0] =3D=3D ranges[i][0] * 1000 &&
> > +		    vals[1] =3D=3D ranges[i][1] * 1000)
> > +			return i;
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
> > +					 struct fwnode_handle *child,
> > +					 u32 ch)
> > +{
> > +	static const enum ad3552r_ch_attributes gain_attrs[] =3D {
> > +		AD3552R_CH_GAIN_SCALING_P,
> > +		AD3552R_CH_GAIN_SCALING_N,
> > +		AD3552R_CH_RFB
> > +	};
> > +	struct device *dev =3D &dac->spi->dev;
> > +	struct fwnode_handle *custom_gain_child;
> > +	u32 val;
> > +	int err, i;
> > +
> > +	custom_gain_child =3D fwnode_get_named_child_node(child,
> > +							"custom-output-
> range-config");
> > +	if (IS_ERR(custom_gain_child)) {
> > +		dev_err(dev,
> > +			"mandatory custom-output-range-config property
> missing\n");
> > +		return PTR_ERR(custom_gain_child);
> > +	}
> > +
> > +	err =3D fwnode_property_read_u32(custom_gain_child, "adi,gain-offset"=
,
> > +				       &val);
> > +	if (err) {
> > +		dev_err(dev,
> > +			"mandatory adi,gain-offset property missing\n");
> > +		goto put_child;
> > +	}
> > +
> > +	err =3D ad3552r_set_ch_value(dac, AD3552R_CH_GAIN_OFFSET, ch,
> > +				   abs((s32)val));
> > +	if (err)
> > +		goto put_child;
> > +
> > +	err =3D ad3552r_set_ch_value(dac,
> AD3552R_CH_GAIN_OFFSET_POLARITY,
> > +					ch, (s32)val < 0);
> > +	if (err)
> > +		goto put_child;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(gain_attrs); ++i) {
> > +		err =3D fwnode_property_read_u32(custom_gain_child,
> > +					       gain_dts_names[i], &val);
> > +		if (err) {
> > +			dev_err(dev, "mandatory %s property missing\n",
> > +				gain_dts_names[i]);
> > +			goto put_child;
> > +		}
> > +
> > +		err =3D ad3552r_set_ch_value(dac, gain_attrs[i], ch, val);
> > +		if (err)
> > +			goto put_child;
> > +	}
> > +
> Don't we need to put the custom_gain_child node in the good path as well =
as
> the bad one?
> > +	return 0;
> > +
> > +put_child:
> > +	fwnode_handle_put(custom_gain_child);
> > +
> > +	return err;
> > +}
> > +
> > +static int ad3552r_configure_device(struct ad3552r_desc *dac) {
> > +	struct device *dev =3D &dac->spi->dev;
> > +	struct fwnode_handle *child;
> > +	struct regulator *vref;
> > +	int err, cnt =3D 0, voltage, delta =3D 100000;
> > +	u32 vals[2], ch;
> > +	bool is_custom;
> > +
> > +	dac->gpio_ldac =3D devm_gpiod_get_optional(dev, "ldac",
> GPIOD_OUT_HIGH);
> > +	if (IS_ERR(dac->gpio_ldac))
> > +		return PTR_ERR(dac->gpio_ldac);
> > +
> > +	vref =3D devm_regulator_get_optional(dev, "vref");
> > +	if (IS_ERR(vref)) {
> > +		if (PTR_ERR(vref) !=3D -ENODEV)
> > +			return PTR_ERR(vref);
> > +		vref =3D NULL;
> > +	}
> > +	if (vref) {
> > +		voltage =3D regulator_get_voltage(vref);
> > +		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
> > +			dev_err(dev, "vref-supply must be 2.5V");
>=20
> I'd be tempted to reduce this to a dev_warn and carry on regardless.
> Whilst the datasheet states it must be a 2.5V reference, I'm not seeing a=
ny
> clear guidance on what happens if say it's just beyond your delta.
>=20
> > +			return -EINVAL;
> > +		}
> > +		vals[0] =3D AD3552R_EXTERNAL_VREF_PIN_INPUT;
> > +	} else {
> > +		if (device_property_read_bool(dev, "adi,vref-out-en"))
> > +			vals[0] =3D AD3552R_INTERNAL_VREF_PIN_2P5V;
>=20
> I would have a separate local variable for the single value and the array=
 cases.
> That will look cleaner than a reader wondering what is in the other eleme=
nts of
> the array when there is nothing there.
>=20
> The vals[1] value is only used in a fairly deeply nested statement, so ju=
st
> introduce the array in the appropriate place.
>=20
> > +		else
> > +			vals[0] =3D AD3552R_INTERNAL_VREF_PIN_FLOATING;
> > +	}
> > +	err =3D ad3552r_set_dev_value(dac, AD3552R_VREF_SELECT, vals[0]);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D device_property_read_u32(dev, "adi,sdo-drive-strength",
> &vals[0]);
> > +	if (!err) {
> > +		if (vals[0] > 3) {
> > +			dev_err(dev, "%s must be less than 4\n",
> > +				"adi,sdo-drive-strength");
> > +			return -EINVAL;
> > +		}
> > +		err =3D ad3552r_set_dev_value(dac,
> AD3552R_SDO_DRIVE_STRENGTH,
> > +					    vals[0]);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	dac->num_ch =3D device_get_child_node_count(dev);
> > +	if (!dac->num_ch) {
> > +		dev_err(dev, "No channels defined\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	device_for_each_child_node(dev, child) {
> > +		err =3D fwnode_property_read_u32(child, "reg", &ch);
> > +		if (err) {
> > +			dev_err(dev, "mandatory reg property missing\n");
> > +			goto put_child;
> > +		}
> > +		if (ch >=3D AD3552R_NUM_CH) {
> > +			dev_err(dev, "reg must be less than %d\n",
> > +				AD3552R_NUM_CH);
> > +			err =3D -EINVAL;
> > +			goto put_child;
> > +		}
> > +
> > +		if (fwnode_property_present(child, "adi,output-range-
> microvolt")) {
> > +			is_custom =3D false;
> > +			err =3D fwnode_property_read_u32_array(child,
> > +							     "adi,output-range-
> microvolt",
> > +							     vals,
> > +							     2);
> > +			if (err) {
> > +				dev_err(dev,
> > +					"mandatory adi,output-range-
> microvolt property missing\n");
> > +				goto put_child;
> > +			}
> > +
> > +			vals[0] =3D ad3552r_find_range(dac->chip_id, vals);
> > +			if ((s32)vals[0] < 0) {
> > +				dev_err(dev,
> > +					"Invalid adi,output-range-microvolt
> value\n");
> > +				err =3D -EINVAL;
> > +				goto put_child;
> > +			}
> > +			err =3D ad3552r_set_ch_value(dac,
> > +
> AD3552R_CH_OUTPUT_RANGE_SEL,
> > +						   ch, vals[0]);
> > +			if (err)
> > +				goto put_child;
> > +		} else {
> > +			is_custom =3D true;
> > +			err =3D ad3552r_configure_custom_gain(dac, child, ch);
> > +			if (err)
> > +				goto put_child;
> > +		}
> > +
> > +		ad3552r_calc_gain_and_offset(dac, ch);
> > +		err =3D ad3552r_set_ch_value(dac,
> AD3552R_CH_RANGE_OVERRIDE, ch,
> > +					   is_custom);
> > +		if (err)
> > +			goto put_child;
> > +
> > +		dac->enabled_ch |=3D BIT(ch);
> > +
> > +		err =3D ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
> > +		if (err < 0)
> > +			return err;
> > +
> > +		dac->channels[cnt] =3D AD3552R_CH_DAC(ch);
> > +		++cnt;
> > +
> > +	}
> > +
> > +	if (cnt =3D=3D AD3552R_NUM_CH) {
> > +		dac->channels[cnt] =3D
> AD3552R_CH_DAC_PAGE(AD3552R_PAGE_CH);
> > +		++cnt;
> > +	} else {
> > +		/* Disable unused channels */
> > +		for_each_clear_bit(ch, &dac->enabled_ch,
> AD3552R_PAGE_CH) {
> > +			err =3D ad3552r_set_ch_value(dac,
> > +
> AD3552R_CH_AMPLIFIER_POWERDOWN,
> > +						   ch,
> > +						   0);
> > +			if (err)
> > +				goto put_child;
>=20
> Do we need to put the child node out here?
>=20
> > +		}
> > +	}
> > +
> > +	dac->num_ch =3D cnt;
> > +
> > +put_child:
> > +	fwnode_handle_put(child);
> > +
> > +	return err;
> > +}
> > +
> > +static int ad3552r_init(struct ad3552r_desc *dac) {
> > +	int err;
> > +	u16 val, id;
> > +
> > +	err =3D ad3552r_reset(dac);
> > +	if (err) {
> > +		dev_err(&dac->spi->dev, "Reset failed\n");
> > +		return err;
> > +	}
> > +
> > +	err =3D ad3552r_check_scratch_pad(dac);
> > +	if (err) {
> > +		dev_err(&dac->spi->dev, "Scratch pad test failed\n");
> > +		return err;
> > +	}
> > +
> > +	err =3D ad3552r_read_reg(dac, AD3552R_REG_ADDR_PRODUCT_ID_L,
> &val);
> > +	if (err) {
> > +		dev_err(&dac->spi->dev, "Fail read PRODUCT_ID_L\n");
> > +		return err;
> > +	}
> > +	id =3D val;
> > +	err =3D ad3552r_read_reg(dac, AD3552R_REG_ADDR_PRODUCT_ID_H,
> &val);
> > +	if (err) {
> > +		dev_err(&dac->spi->dev, "Fail read PRODUCT_ID_H\n");
> > +		return err;
> > +	}
> > +	id |=3D val << 8;
> > +	if (id !=3D dac->chip_id) {
> > +		dev_err(&dac->spi->dev, "Product id not matching\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	return ad3552r_configure_device(dac); }
> > +
> > +static int ad3552r_probe(struct spi_device *spi) {
> > +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> > +	struct ad3552r_desc *dac;
> > +	struct iio_dev *indio_dev;
> > +	int err;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*dac));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	dac =3D iio_priv(indio_dev);
> > +	dac->spi =3D spi;
> > +	dac->chip_id =3D id->driver_data;
> > +
> > +	mutex_init(&dac->lock);
> > +
> > +	err =3D ad3552r_init(dac);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Config triggered buffer device */
> > +	indio_dev->dev.parent =3D &spi->dev;
> > +	indio_dev->name =3D "ad3552r";
>=20
> That name needs to reflect the connected part, not always be ad3552r.
>=20
> > +	indio_dev->info =3D &ad3552r_iio_info;
> > +	indio_dev->num_channels =3D dac->num_ch;
> > +	indio_dev->channels =3D dac->channels;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	err =3D devm_iio_triggered_buffer_setup_ext(&indio_dev->dev,
> indio_dev, NULL,
> > +						  &ad3552r_trigger_handler,
> > +
> IIO_BUFFER_DIRECTION_OUT,
> > +						  NULL,
> > +						  NULL);
> > +	if (err)
> > +		return err;
> > +
> > +	return devm_iio_device_register(&spi->dev, indio_dev); }
> > +
> > +static const struct spi_device_id ad3552r_id[] =3D {
> > +	{ "ad3542r", AD3542R_ID },
> > +	{ "ad3552r", AD3552R_ID },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, ad3552r_id);
> > +
> > +static const struct of_device_id ad3552r_of_match[] =3D {
> > +	{ .compatible =3D "adi,ad3542r"},
> > +	{ .compatible =3D "adi,ad3552r"},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad3552r_of_match);
> > +
> > +static struct spi_driver ad3552r_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "ad3552r",
> > +		.of_match_table =3D ad3552r_of_match,
> > +	},
> > +	.probe =3D ad3552r_probe,
> > +	.id_table =3D ad3552r_id
> > +};
> > +module_spi_driver(ad3552r_driver);
> > +
> > +MODULE_AUTHOR("Mihail Chindris <mihail.chindris@analog.com>");
> > +MODULE_DESCRIPTION("Analog Device AD3552R DAC");
> MODULE_LICENSE("GPL
> > +v2");

