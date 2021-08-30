Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845583FB64D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 14:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhH3Mp7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 08:45:59 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:16330 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229957AbhH3Mp6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2021 08:45:58 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17TMJpoa017171;
        Mon, 30 Aug 2021 08:44:51 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0b-00128a01.pphosted.com with ESMTP id 3arjxhav1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Aug 2021 08:44:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekEEyKLUL8WBhpFlrjaRCKS8B/tegbIAdgL/4k3BSPisbSbA79TGkl7hljSAbULAG8upL7MwXRF7oD+1I1K40L0lqmk04W9RM+SaYjADiCoJ6BCioh6MKyLJs67c+3KORiFWkTm9oCI+42Ofklc+w7ENs2ury71duCHw09Mcp51eG9zka/tCighUHoYPhDpbQHa5BZYxjiR0xrgI1PpWf6Mmr8R/xwW0BbYobZrY+9yPDYzLVsgEM0+MmTjaDw4xdlRAo/jPBc7J+zJUfdNsp2rbG/uS66vJVfoq8MGixO+Aa76C6xp5CphWHt37OGqULc7O6+G3VOH2rgogtOb0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6ZVBcoQhDKMN2ybb9LayBxehv+5kDe9nYWb2XgPKoc=;
 b=UQYiSELKhv4vG82tozFIdgtRsOWcGOwxn9eYzmhk1cg+4LVgyZSem8d3Xc/Jt4btmmlpXm6QO3ShLlfb7QWU6DJ3zEvJf9Z4AkLxxXVdD6c6TV/xR/aQIZPfWHntCwxJN3BG0/Kwj/mBsRQI4Ye0OQWCw1VZxC7eqvza46iJYuoNVvV3XED+Rk4bZfvBMeDT9HdCzkZDJhbQX5wZZPTMX6FHBw5AE0nw+MNo/PD1OfPMXuG2PbrN9twsumoYNUCFn0dZuxJyeYF6CFtyYYTfxBvaORjLaeD1JUZF5Zao4Vs8qLa7RXS/Jpz2R/0BLxx5g3bKDmGn+cbWudzWu0hVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6ZVBcoQhDKMN2ybb9LayBxehv+5kDe9nYWb2XgPKoc=;
 b=E1KrcvOakcyi6dDr6uEN44FOhg85HUVBpKokfWAfFtiqxoJ4FP3o/PKg7gRwqyUjSooXZA+tQQPm6MLUjaDJgDhZtogGLJQZnFzkb2BfMdwGPAjepwbiucil7tw+66VAAYAn6ntFRJ/7lXl9c0kAPcC7PtGUMRwuKQ58+Eq6cZg=
Received: from MW4PR03MB6363.namprd03.prod.outlook.com (2603:10b6:303:11e::10)
 by MWHPR03MB2878.namprd03.prod.outlook.com (2603:10b6:300:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 12:44:49 +0000
Received: from MW4PR03MB6363.namprd03.prod.outlook.com
 ([fe80::3c5f:4b91:b79f:b1b4]) by MW4PR03MB6363.namprd03.prod.outlook.com
 ([fe80::3c5f:4b91:b79f:b1b4%7]) with mapi id 15.20.4415.023; Mon, 30 Aug 2021
 12:44:49 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 14/16] iio: adc: max1027: Consolidate the end of
 conversion helper
Thread-Topic: [PATCH 14/16] iio: adc: max1027: Consolidate the end of
 conversion helper
Thread-Index: AQHXlCHtfQrdofpSQUuVZBISb03GLauL7bwAgAAgYGA=
Date:   Mon, 30 Aug 2021 12:44:48 +0000
Message-ID: <MW4PR03MB6363F50DC6A4B5D682BA16E299CB9@MW4PR03MB6363.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-15-miquel.raynal@bootlin.com>
 <20210830113716.1f7cdc6f@jic23-huawei>
In-Reply-To: <20210830113716.1f7cdc6f@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMGU2MjUxOTQtMDk5MC0xMWVjLThiOGMtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDBlNjI1MTk1LTA5OTAtMTFlYy04YjhjLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMzk0NyIgdD0iMTMyNzQ4MDEwOD?=
 =?iso-8859-1?Q?c0MDU5NjA3IiBoPSJqc1RhemlDZ0RpT3NMME53aStpWkx3cnhEL0k9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUJYdThuUW5KM1hBV1BDbytyNDB1amdZOEtqNnZqUzZPQUZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVhtWmdqd0FBQUFBQUFBQUFBQUFBQUo0?=
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
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1df2216-47f1-47a4-9c36-08d96bb3f438
x-ms-traffictypediagnostic: MWHPR03MB2878:
x-microsoft-antispam-prvs: <MWHPR03MB28787A211D95784E45C89EF499CB9@MWHPR03MB2878.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJdcZJiSUqsjdRNSk/g0S+Xd71bNYb4d3RwLRThVf5c5bOlu31/eU+PONQa7bumli9gkFR/F51v5NdnDEZ3Q2Nxpn3IeqQdRR+GANSkQWTEpjVj8nXKpBzYkmxePBWS7jR4v0vrZnJreIS/qZK5nSsl9cKTav9u7ag+2XbeY0dEuFUgym7e1Bhrfnq3cg8qfEh4vQ4VEq7/pcDyMrCvVWoZAa2xwxe43IL/2bFTH60ViOcln8FU41XWRAXlutRFh0aZwvKRbBAzXaj9xucjH7lz/rhTokFSO/TiOlZJZ6ouOia/3kiVWFj++v03dbhBhto+5dWo7dT9dbg58tJ2NMWIzkyfJYZh6A67ZeVt0F7uXUEHCeuoEMzmpz4VMWHQouwvZkXdzqO7dlwblzwtg1a3twrjhaNTBw9zjkbUuiWaMPlhmumsnJUZiKtEGFjIV8M3RrZ0FaKorLZCwIv4DOmmdaftWZlxORa/67Q20eK6hv3O7YG+eEPB5+liY6gKsL2Nhg/UEStwEb4nA8PQXhCYSfDdqo7m9u2uNZeBLWof4ym67X5ZEvaY7O8wG5msHlas77OkriOBNjYQZjYk01LPIw37Xi5F1P8ryvxYa1vIPkbVnlJztVXkENfqXhtEhJWc6WRpke1IlxtstHAJ23bJ+xuBlqpxWdr9Ph19cLkLtS+vErGUx/oVzrjP5vveia85J7vEg9kLWMaCEBhONlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6363.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(6506007)(8676002)(8936002)(4326008)(54906003)(2906002)(38100700002)(66476007)(71200400001)(64756008)(33656002)(316002)(5660300002)(55016002)(7696005)(122000001)(110136005)(478600001)(186003)(26005)(53546011)(66446008)(38070700005)(83380400001)(86362001)(52536014)(76116006)(66556008)(66946007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5s1sz/xhkbXtPYc88Jpm/65YFxVvmfdQXXCG8r17/o2O060Oua/+HIHcJJ?=
 =?iso-8859-1?Q?7uZvi/igvTIAE1fiZVzBFkGhgOq84JNudLRERx6+OHRJJ1QcTReFSelAA6?=
 =?iso-8859-1?Q?o6ysd9znuHUGDgK61/PH7UWQ0GH0cJ4vWoHY1jXm7tystQXr7WYXWsUqns?=
 =?iso-8859-1?Q?yAZtvrLFsBykPdt3sYrdauXywJAIVGNYXNEbb/j2hAhBpxJW+Qx1NwVrlu?=
 =?iso-8859-1?Q?2ZSOXKRPt01w9zN4Hj04dmsTYm2sC6ROadnPKzKk1AQtvfVSSGIV0NPDZ5?=
 =?iso-8859-1?Q?CFz0kftOzUkLwLbWk8jJY4NYWOwExahoTef36Ki8pHYcJ3ix9KT0VYMYXP?=
 =?iso-8859-1?Q?wnL8BjRvoA0vYIQhSYxWV6qLXzwi/Gj0FcwoLIHnGiTePoRj58EjK5yvaW?=
 =?iso-8859-1?Q?36BcfMje5NzshUJ5ues44YsW7uzZT20TvKRi5QoBQEFSs2YtS/sgQTspga?=
 =?iso-8859-1?Q?SEPb9dkNlq0YOdCyQrKklqywjLQHlRmVZN8REaI4RxBbnY5JmIpCQCl36q?=
 =?iso-8859-1?Q?DQGQoSD+M+cic1WNwvP2s5LndHOg283opi6HAd9twFkzwXo483FB3Srn19?=
 =?iso-8859-1?Q?QFqqS5rJvxqDQLCqs9PmeRyPFZOaD/DbugGv/TxNrK2awtKK3kDabkxBl0?=
 =?iso-8859-1?Q?3hZqBGHmHjYChOMJaEGC57MdglUhSdzWxKSxkBz/U8rZARdpDuY8Wu53a2?=
 =?iso-8859-1?Q?oDkiHQJYNjWHzxuufQ8wobUIbxvSYjPSpHb+Dm4I5PFUuz0rljFDU9ddJK?=
 =?iso-8859-1?Q?xmXfiWQCpeKpI+hQn9SeHx/dY2oFP55Kkj6AobURNG5FsqgWlZXbxbb+96?=
 =?iso-8859-1?Q?1LPirGqWDMHRCNL5iKzz+hR1vbPCuBOLM/ZnM5PUaYIUUUPcUbKkZSIQFV?=
 =?iso-8859-1?Q?wLoHtxd00kxayn8OXerk5+DLiGiYu3pHtqo/F5eUWorTs1CSjJhokPI+Oe?=
 =?iso-8859-1?Q?dApwsYKU7BMNCS5vldoBjRCKpZEZ/MkvfjUon52kRjJobcRd/a0aZ2pGCI?=
 =?iso-8859-1?Q?tCOHKq/TCKN7MzL8bBgfSg6XQ/HIe/MR4i5c2keaWTwBdoxI1FUSHnnQRm?=
 =?iso-8859-1?Q?PAYpTBK/9A2gUXXqmO9O2T7eCluwRvuGxvx+8DJuCzzTLpm9pI888jgst+?=
 =?iso-8859-1?Q?KFT8IynVDK3apJ01P0y/5yjAJ7A+aupHPH3Ao8IOcwW0/jC7mtv9UZGqLE?=
 =?iso-8859-1?Q?guEYPJBJnljzQfq+5Jr5x70lto3hNj465pT7As+ioIvIGL1gjNaR2OSQpm?=
 =?iso-8859-1?Q?IVL6NaYhlMrYwAOiw2blqwtPz2cRnX9EQ6T0WHLJgCiUdZVo2m2dOESUcC?=
 =?iso-8859-1?Q?UoJbAIjsvwzmHr9vfPB5WlU7vHYkKc/NggDT4iqM9yH2sLYkPuEVpdvFhT?=
 =?iso-8859-1?Q?bUuGMHt9Vj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6363.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1df2216-47f1-47a4-9c36-08d96bb3f438
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 12:44:48.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlXtg8f7DwQECXMBQZek/3MBUlb8HUMF3Z1SO/w3uf/ga27BAFLbl8nyzsBwHayBf2tbAMoG9kbPB0rELWZpfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2878
X-Proofpoint-ORIG-GUID: 5I0ha0KOmDsPQ2MiD4Be88jOMJwYxZ7r
X-Proofpoint-GUID: 5I0ha0KOmDsPQ2MiD4Be88jOMJwYxZ7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-30_05,2021-08-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300091
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, August 30, 2021 12:37 PM
> To: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Thomas Petazzoni
> <thomas.petazzoni@bootlin.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 14/16] iio: adc: max1027: Consolidate the end of
> conversion helper
>=20
> On Wed, 18 Aug 2021 13:11:37 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > Now that we have a dedicated handler for End Of Conversion
> interrupts,
> > let's create a second path:
> > - Situation 1: we are using the external hardware trigger, a
> conversion
> >   has been triggered and the ADC pushed the data to its FIFO, we
> need to
> >   retrieve the data and push it to the IIO buffers.
> > - Situation 2: we are not using the external hardware trigger, hence
> we
> >   are likely waiting in a blocked thread waiting for this interrupt to
> >   happen: in this case we just wake up the waiting thread.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/adc/max1027.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > index 8d86e77fb5db..8c5995ae59f2 100644
> > --- a/drivers/iio/adc/max1027.c
> > +++ b/drivers/iio/adc/max1027.c
> > @@ -235,6 +235,7 @@ struct max1027_state {
> >  	struct iio_trigger		*trig;
> >  	__be16				*buffer;
> >  	struct mutex			lock;
> > +	bool				data_rdy;
> >  	bool				cnvst_trigger;
> >  	u8				reg ____cacheline_aligned;
> >  };
> > @@ -243,12 +244,22 @@ static
> DECLARE_WAIT_QUEUE_HEAD(max1027_queue);
> >
> >  static int max1027_wait_eoc(struct iio_dev *indio_dev)
> >  {
> > +	struct max1027_state *st =3D iio_priv(indio_dev);
> >  	unsigned int conversion_time =3D
> MAX1027_CONVERSION_UDELAY;
> > +	int ret;
> >
> > -	if (indio_dev->active_scan_mask)
> > -		conversion_time *=3D hweight32(*indio_dev-
> >active_scan_mask);
> > +	if (st->spi->irq) {
> > +		ret =3D
> wait_event_interruptible_timeout(max1027_queue,
> > +						       st->data_rdy, HZ /
> 1000);
> > +		st->data_rdy =3D false;
> > +		if (ret =3D=3D -ERESTARTSYS)
> > +			return ret;
> > +	} else {
> > +		if (indio_dev->active_scan_mask)
> > +			conversion_time *=3D hweight32(*indio_dev-
> >active_scan_mask);
> >
> > -	usleep_range(conversion_time, conversion_time * 2);
> > +		usleep_range(conversion_time, conversion_time * 2);
> > +	}
> >
> >  	return 0;
> >  }
> > @@ -481,6 +492,9 @@ static irqreturn_t
> max1027_eoc_irq_handler(int irq, void *private)
> >  	if (st->cnvst_trigger) {
> >  		ret =3D max1027_read_scan(indio_dev);
> >  		iio_trigger_notify_done(indio_dev->trig);
> > +	} else {
> > +		st->data_rdy =3D true;
> > +		wake_up(&max1027_queue);
>=20
> I can't see why a queue is appropriate for this.  Use a completion and
> have
> one per instance of the device.  No need for the flag etc in that case as
> complete() means we have had an interrupt.
>=20

In the case that 'st-> cnvst_trigger' is not set but the spi IRQ
is present, we will wait until we get 'wake_up()' called from here. I wonde=
r if
that is a good idea as the device own trigger is not being used. FWIW, I th=
ink this
sync logic is a bit confusing... I would still use the normal trigger infra=
structure
('iio_trigger_generic_data_rdy_poll()') and use the 'cnvst_trigger' flag in=
 the
trigger handler to manually start conversions + wait till eoc. But I might =
be missing
something though.

Regarding this handler, I just realized that this is the hard IRQ handler w=
hich
might end up calling 'max1027_read_scan()' which in turn calls 'spi_read()'=
. Am I
missing something here?

- Nuno S=E1
