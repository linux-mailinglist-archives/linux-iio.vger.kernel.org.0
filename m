Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA7D3336B6
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 08:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhCJH4G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 02:56:06 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3722 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhCJH4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Mar 2021 02:56:02 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12A7exJ7015847;
        Wed, 10 Mar 2021 02:55:46 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 3747h9jmtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 02:55:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mnxx6dC8JGJDn3KpP5Uj4fid/JmV/FPc8ALJa0i7+dehSsq+GhaD/7aX4Sm8Q6jBA+2Fod8M675cRGugnFeZSqaoq2uizH4uaAyefk6JUFzsFAnoKCWXVBRVE1Xu93JR6JBkugNaRew0gUef4M5/gDw9iC9A2hx9xNjpjgfg+V6Tq6+ITSxyBj40a5sTLl902pi7dZO5d1z6ezidJ6cVS8qk/8GTMGB4uYbM6u71jlMxhT4MqmotSk4yyHFW/oPWpwvL+QzIOUOY7C3hMknQEVeYnUCJq6zjU9S9kl9scl+tGSDdbiXhgEQeZCMp7IB++ExE/BpeHcWSzepe+XdTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vkE0mumqyQWHN+ANHrz8DeTKy8aSsm/BDf8UalsHVA=;
 b=XwwOB70Al0KAssTz3m4C7NeBX3/25Pl+5gP3zLURNQ93KXXg3UaPgOYAye/4ZOyzzJRytchmEjx9znzKrlx5nD8gu6LUjViauDmTpi8JqmXaZ8DT0MZJxXQqiKJKk59DamlqgiM7RfB2njQ+T+EH5Q3Im2ClPerUg2CIQhYa48bUdY1Cqv2nCvcgq9hHQIac6/nOyN3a6Y06XxR0w+x5/lBEDOmL9jyUgMJR6CJvRiIRU4HqbidxXRoRWFSJ4OXXK4Ik2QrZ7n1ZmUIgrozUSNaZYSmbfWUpyN7UfJWWTCzU7Zrd10YK9DoClJd8VaULJZsP5VT5Lu0Qbgtnnfbz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vkE0mumqyQWHN+ANHrz8DeTKy8aSsm/BDf8UalsHVA=;
 b=txPyTY0l8/WR+5E5Lb3SoO6QK7Ia8rLj5/RvD76KCS95JCml8AWcsfRUK2aUZHc67WKg7UcjmzRm0b1Cx6L5o2YkXBoJsMb2mPXcP6itNkraPgrAIZ/fEXXKMgOXoD0FBBVS1Ny+LS+YOkbW8ptuKAKz/l5+cWxZ4DR4MrxLL8k=
Received: from CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:74::18)
 by CY1PR03MB2378.namprd03.prod.outlook.com (2a01:111:e400:c615::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 07:55:43 +0000
Received: from CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::b439:cc16:d1ec:1c5e]) by CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::b439:cc16:d1ec:1c5e%5]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 07:55:43 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Gwendal Grignou <gwendal@chromium.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v4 3/8] iio: adis_trigger: Remove code to set trigger
 parent
Thread-Topic: [PATCH v4 3/8] iio: adis_trigger: Remove code to set trigger
 parent
Thread-Index: AQHXFRuaNgGQQ1SoGkyywtj3XdJJCKp82pNg
Date:   Wed, 10 Mar 2021 07:55:43 +0000
Message-ID: <CY4PR03MB2631FFB026005FFF5DBCD6FE99919@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210309193620.2176163-1-gwendal@chromium.org>
 <20210309193620.2176163-4-gwendal@chromium.org>
In-Reply-To: <20210309193620.2176163-4-gwendal@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcGRh?=
 =?us-ascii?Q?dGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUz?=
 =?us-ascii?Q?NWJcbXNnc1xtc2ctMDIwOGI3MjYtODE3Ni0xMWViLThiMjYtZmM3Nzc0MjFm?=
 =?us-ascii?Q?Y2FlXGFtZS10ZXN0XDAyMDhiNzI4LTgxNzYtMTFlYi04YjI2LWZjNzc3NDIx?=
 =?us-ascii?Q?ZmNhZWJvZHkudHh0IiBzej0iODczIiB0PSIxMzI1OTgzNjU0MTUyMjcxNTYi?=
 =?us-ascii?Q?IGg9IlpWV20wTmRPNnZGTWFKQlN1RGNsUDZWcFZ1az0iIGlkPSIiIGJsPSIw?=
 =?us-ascii?Q?IiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUlZREFBQVVQMS9F?=
 =?us-ascii?Q?Z2hYWEFlUWlNazhKQm45TDVDSXlUd2tHZjBzRkFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFIQUFBQUFXQXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFR?=
 =?us-ascii?Q?QUJBQUFBYkpQU2RRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFhUUJmQUhN?=
 =?us-ascii?Q?QVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFGOEFaZ0Jo?=
 =?us-ascii?Q?QUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFB?=
 =?us-ascii?Q?QUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VB?=
 =?us-ascii?Q?WHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0Fa?=
 =?us-ascii?Q?UUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJoQUhJQWFRQmhB?=
 =?us-ascii?Q?RjhBWkFCcEFHTUFkQUJwQUc4QWJnQmhBSElBZVFCZkFIUUFhUUJsQUhJQU1R?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFjZ0JwQUdFQVh3QmtBR2tBWXdCMEFH?=
 =?us-ascii?Q?a0Fid0J1QUdFQWNnQjVBRjhBZEFCcEFHVUFjZ0F5QUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?QT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:2523:9b01:887b:8b3f:4563:d96a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ae6873d-503d-462b-0e2f-08d8e399e830
x-ms-traffictypediagnostic: CY1PR03MB2378:
x-microsoft-antispam-prvs: <CY1PR03MB23788C482DBF1180FBB557E899919@CY1PR03MB2378.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zg4+s6+gteNegcnd7yI6GwWUotivldp3opLlBGHitPzhp9y+k9tKKE2aKPh3JHt1w6nV+Qzuel8/BIuGc00HpS5VQJnItHjZiyU6ks6bzxkIm9UtMZXpwbeYQhbk+c5dLdToytgyZJKcLkocIkZp7tf/Rk1dOHQ/oNTh8+Z0MOoIEJphCWH0KaWuYiGPLMfB0Gq0UZQ3kKIr6/IcE9mCZCkLk2C1Hxgx0/3aphx1FxRK+GeFYduwzW+S8vrVddMbU2UKUB4wNY9gz3QQbwmdh6ATXj2XoQ8yj0EiemoAJb/ZqRhy1ZZjrIGfITVPz8l3YNCbs6ZFbGsPsi3Up/6FBP2w2rUjAlKYPewNXRwme9TDMP7wyinttDj3yjgL0d0A9F+kCeny4SQjuDdZOT/yHv2x0t7/jsx44MnSKY/xgRO6ctHglpeNWyMw+MIrL9aL13aLzuMTgnIdLQPZDaygcsCeuoOucBkYOs9uRNnL3MoZ8I+mhpMKUE8WE7IICOCbWdZEVXwPdELt99kG7/1NsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2631.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39850400004)(366004)(346002)(83380400001)(8936002)(8676002)(478600001)(53546011)(6506007)(2906002)(7696005)(86362001)(316002)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(5660300002)(71200400001)(4326008)(186003)(110136005)(55016002)(33656002)(52536014)(9686003)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4cCs/80ogNLKFa5AxYLyjcwjMw339RV78lHzfBxJlqc6evu7tRovPXNLYPfu?=
 =?us-ascii?Q?Vun8q0DU5zA7FUgS69mPatInGtuzJlF9z6JdBVHqnS94uZAK+w5mfnWQPImU?=
 =?us-ascii?Q?EN4xdVlGa1aUDELynFGb7BROPtFy5kdSNr165iGcPbnzISAxVkpSmbgWr+Gk?=
 =?us-ascii?Q?XpiEIIIuvHNs6Kzmy7xxSB/fZ3JShcwV0ZGmfbr8sKW1qx64ADhBshOgH2s3?=
 =?us-ascii?Q?eJ7yrwkjD1TP/VgZ6vI9hQckEmliUEFLYBLEraHzR7EGg1DmpiptHPNMxEKb?=
 =?us-ascii?Q?9/4cAVg0bDQw1InS5nXlONf6QGQOpiCA5Rro2xiDavccV8rL25hc0NbmJwZa?=
 =?us-ascii?Q?FKoD1Qitt/HW/X861S+HWED/cqoeC2JLnEZ349otjYRCgL6L2HBmjMwe5qDC?=
 =?us-ascii?Q?tS+4N9ltn9ffP2CKZRqVQxWq/gWVc/GJA/+pbMARYMI1UJjRVFRBK+Q2PXAd?=
 =?us-ascii?Q?ede34KV1wJtXVJFe+c1lUOmGY7+5i1MbzBWLbRffvSI8vwtzjLWZZtBULf3k?=
 =?us-ascii?Q?d9YmMc6cuRWGQ1KAnVZqnwwL4A9KI2o3A6vqqVIbcCKKGddW9/cwCDMDGAA7?=
 =?us-ascii?Q?HFRiUs52PdPeDqJrXOnaGemhroIYzc/eSfjeeFUoAa1XcffC+Bsi4RWALpFw?=
 =?us-ascii?Q?RtSb/20vo4hC+IBzaX0gHpasZcj8oqgPgFuGLMmiV/rrxvR4fJOahPkdFn2v?=
 =?us-ascii?Q?tBbvxpy12+nNT5J4SB7AFVrbh1AO9DFS71c6AEgnwSdtbuRGVA3aCcTyrpjf?=
 =?us-ascii?Q?0PzGdRuc+9kimWBvs7G972z0dqUisQfqzbh/hup6uSgCvV3dGKoN5kSRePd1?=
 =?us-ascii?Q?mWj0H1DkMcXs+8irtfGS2fpFW4z4AU12lBuVzLONS8U51cIi7DrzACapahvY?=
 =?us-ascii?Q?FtUtOq3fE9QrEyEXdzC4TmPVqqcU8VWs9xzajBrUNwB2KV9ueLtYJ1d9l8TJ?=
 =?us-ascii?Q?V11gK5JpFMSbDxsR0QQ0b650uZYTsNk8OvrNsHRnUtoX0h+kY5cr1lLORCkF?=
 =?us-ascii?Q?PfQW8kKfxHYRQThuTctekaC1UPd01Qrumhp6WwJLzMG0BoD3Ic+QxXoH8spj?=
 =?us-ascii?Q?NqfBbj8crWBwoRVFRDXuw0/DLrzCyTVSgVliuoPvv2P+rj05n8b4WAM0ROVl?=
 =?us-ascii?Q?kLu7n+8q87ujzvqGYogZ78pk2QNUSEcYj8gMiW12/hPhSiTPpxT9abjHvAZ9?=
 =?us-ascii?Q?V33Kq+6HIKn4ADewVwjlABsjUccNftRHMG0t4pNKX0mHtN7xAxDPi/BJhjNR?=
 =?us-ascii?Q?k8c+eSEfdSjY/HpIcrw1a/R3ximVubE9SueyAl7YqDs8KgwG/FRSzOF1k22U?=
 =?us-ascii?Q?J4FZeT60vDTzdiEigdfkJFhoQOY4aSJGCR23y+i5XTtQNTUgSVi3vHuNv36y?=
 =?us-ascii?Q?R070MOk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2631.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae6873d-503d-462b-0e2f-08d8e399e830
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 07:55:43.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K76DvoJnWblXWdlOVoayTqpFpHcCPxMuaS6uL3GFRl5nCRt/iyjGaR56zxBSWcJLgsfsav02F59eCpZWEaO6ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2378
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_04:2021-03-09,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100037
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Gwendal Grignou <gwendal@chromium.org>
> Sent: Tuesday, March 9, 2021 8:36 PM
> To: jic23@kernel.org; lars@metafoo.de;
> andy.shevchenko@gmail.com; ardeleanalex@gmail.com
> Cc: linux-iio@vger.kernel.org; Gwendal Grignou
> <gwendal@chromium.org>
> Subject: [PATCH v4 3/8] iio: adis_trigger: Remove code to set trigger
> parent
>=20
>=20
> iio_trigger_set_drvdata() sets the trigger device parent to first
> argument of viio_trigger_alloc(), no need to do it again in the driver
> code.
> Remove adis_trigger_setup() to match other drivers where setting the
> trigger is usually done in the probe() routine.
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
