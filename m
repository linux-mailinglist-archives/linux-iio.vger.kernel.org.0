Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933C54377FD
	for <lists+linux-iio@lfdr.de>; Fri, 22 Oct 2021 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJVNbt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Oct 2021 09:31:49 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:49178 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230264AbhJVNbs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Oct 2021 09:31:48 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MB6Sgd019426;
        Fri, 22 Oct 2021 09:29:29 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-00128a01.pphosted.com with ESMTP id 3bu58qq6pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 09:29:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg7NZtULcpuE6VTfNUkLSto4PvDJISKdfDDpLnCl6ZghqhVZ1a3HG6VLaqMQJEtmA+zsf7URiso0OniRnS4s1Z+bvmww+dqTEHXwqBPdwA+DQwlpfEpdj1NUy0lGW0cI3Z0nXQt/ZucI6njDvx8rLB94JG8+2DBQN+5lejHCbNiLeEbJ9BtaOGQPpWSPGwtw+XzdqLoza2agUC6W4G8okiyMxsYYhjvzOpJhFam6/L9HZk8U/rOEoyN/WgUe7pPSSbkf/kcqC3PsS31sjfyIvG2xRnIns8++EruZg3LFRIOCMjOtaWvwigC/3nWn2mQjy99q614vmUJpzzHhAZi7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=171WzzaWHQJLifRWJ6u4uyxnzwlJ33bxprRhDaMZ3dU=;
 b=fLpok1Ft9jcvOlqX5ndXUULvTG7mSiShbuAllCCna2U4p7P1mNYHP6oXPmm/dq9tFCvwd6gKKpwKzUe8bqtgZjGHnJdEp9O9TaaRF/oveDWUYKdNvc86YUpwNjGgp/jQfve+Lm+pkDc4OjR6xjytul5N9lSL8A1mHib0zPiq0IETAApdoqbujxduZgQWSyd+Ui0PyQW/++IPwzNARcK+JwRzC4YurU9EXhHBD6kyEzwnvWMPqzVbjGGDpv8vOTzw+3Heg7o0a1qh9EBr3K/oezWU3ISD9hE6HSrwrvtxv6fOzq91P1AqYrwU+BvEkZ2NE99qDgLrZE+ySy2n1IfOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=171WzzaWHQJLifRWJ6u4uyxnzwlJ33bxprRhDaMZ3dU=;
 b=v7Cxxd5SqYvoKWQpXFV77/UYCq90zcmLCYucc6h+h5LJ1jkc1sw9XwdAWam7YI7pH2D2JRWYV+SKnMMrMkocfgVXV2NoB4QcMPUtEH7PyAxNFEREfUlnA3KZd6FRiYYPCiY3QDpD5n8vl7ktbJMF+YQChL+mfG8fWomr1sbSu0I=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY1PR03MB2220.namprd03.prod.outlook.com (2a01:111:e400:c636::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 13:29:26 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0%3]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 13:29:26 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v9 1/2] iio: frequency: adrf6780: add support for ADRF6780
Thread-Topic: [PATCH v9 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Thread-Index: AQHXxm9qnckb+vL13EeDWD/hIeOYI6vd4GmAgAEkNwA=
Date:   Fri, 22 Oct 2021 13:29:26 +0000
Message-ID: <CY4PR03MB3399C545AA349198290223939B809@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211021113244.56936-1-antoniu.miclaus@analog.com>
 <20211021210257.746ba5dc@jic23-huawei>
In-Reply-To: <20211021210257.746ba5dc@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0xMTMxYjYzYS0zMzNjLTExZWMtYWJkYi?=
 =?iso-8859-2?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcMTEzMWI2M2MtMzMzYy0xMWVjLWFi?=
 =?iso-8859-2?Q?ZGItZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIxOTk2OCIgdD0iMTMyNz?=
 =?iso-8859-2?Q?kzODI5NjMxNDMyMDcxIiBoPSJmODZWY2Y1WlppaTBOeExIb0Uyb0ZQclFS?=
 =?iso-8859-2?Q?SXM9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVU?=
 =?iso-8859-2?Q?ZOQ2dVQUFFb0NBQUNIbFl2VFNNZlhBU0ZBUVlPMnQ1bzBJVUJCZzdhM21q?=
 =?iso-8859-2?Q?UURBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBRUFBUUFCQUFBQVhRL2pqUUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUo0QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeU?=
 =?iso-8859-2?Q?FHOEFhZ0JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1B?=
 =?iso-8859-2?Q?YVFCMEFHa0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0?=
 =?iso-8859-2?Q?FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFH?=
 =?iso-8859-2?Q?VUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJr?=
 =?iso-8859-2?Q?QUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUU?=
 =?iso-8859-2?Q?Fjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D?=
 =?iso-8859-2?Q?=3D?=
x-dg-rorf: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cfd4f32-3312-4886-2d5c-08d9955ff7f5
x-ms-traffictypediagnostic: CY1PR03MB2220:
x-microsoft-antispam-prvs: <CY1PR03MB2220EE3BEE687422BC5F7A8A9B809@CY1PR03MB2220.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IH/vHK7lxuwWJQH8ymIqN0ZlOg7uP0TJ6eZiJb5PlcazXpF2W9K+k24TK/XFH+5s2pL8vpEq+GKTtPDrJ0uYVAu+Nyxc9pZfSQDKHIeJlVgNG5Dj6WmCiutqHkiregULZi2QgEQs2575nxGJWkZtUfgZ68YJHXeRtreGbcKJBIaIYOuieg9mDj2bkfC1iAi2fkt6DHvZret8UEc1vOsgFWyTv4bqdxy2xOYugaS7ZKUmBM93IBI/uDM5pZme7lUaE8IIOwjlhDOJTyS9MY46pqTVQtxX7bsxjUP/W/UWIaht6prf3y+g5OiMZmVdYN3yYvrq/kftGW2aQztre70F4C8eR+cA8385MXvlCdeYreCvgmvQW+m/vEnrLSqHARU0VxDI17dRAhRjljB19S/ZRT9rK76a0d5Gr5u04Ghhky34ZOCLSBQ0/mUwI6n5QJmdwcJiGr37WNZnflrd7hiNqUtpfZ+W9tVCjDnDmfeEhkm43fOYqc5mGwrL6uZrVNW1bqLQBPkqIJoIlP+j8IBhF6dZ43sVY0qa5AKoz9CCUmeNEHW96ccFA3zz/euG+GZGk5NlvP/4OrgG4XpPjYo1sq6Sbrs8+iw6WxnDJhVzvwYBNTzTm46e5TQmj6bb9gVatz3WdBWaU/7zEmNH8uFppewhfYKldekL8W59hjb6vLmPwmUKmSMIBKZT9EAdUxbFSws/NrEXXRdhwtpLFj0kz/ItPn7WRVK5F48ti8iyYqqbza8GY1Sqh0XK89uzOzMHJC+aRr/YT420peJFJhOuJJfXCwVX1TUA5sex2X/1LmI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(71200400001)(52536014)(6916009)(55016002)(4326008)(186003)(2906002)(30864003)(5660300002)(7696005)(6506007)(8676002)(8936002)(38070700005)(53546011)(64756008)(508600001)(86362001)(316002)(66574015)(33656002)(66946007)(76116006)(54906003)(122000001)(38100700002)(26005)(66446008)(966005)(83380400001)(66556008)(66476007)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?xekNex2renBMo98OosRyhUygsSe/YMkh0hcCtSWVfHo5nq/gsZna3ugfeU?=
 =?iso-8859-2?Q?z6esWvlpdH2ytOMwYLa9OtZsZpLxvXQ1L1onFyc2m6kY0cuUb8J3E3xgCi?=
 =?iso-8859-2?Q?+LAOW93GW0AI5CK8nNSyUGr/6uM0K8SoZa0o+lSwq/MuosdU7JkzsKfq6d?=
 =?iso-8859-2?Q?R6i2AnjzuvgOL+EPQuF7Fg4+PXnidupEKeFefXB2IimJKi/zvhZ8ZUpwQS?=
 =?iso-8859-2?Q?/WNpCjW8zWFO9Kq6g7zSguzCWz1O8t+QD0DFBOeJY3lnUOCsQXetm9mcaR?=
 =?iso-8859-2?Q?DAF1Ljn+3Ox4pCEoP3Pa9G188BCwYHHsRtHC/VubWflJcJ+kHxFnSPWYRG?=
 =?iso-8859-2?Q?3JjNQucSzNQ2s36BpJA5DzRJJ207gOzWNAJg6b4J3jN0zAkHHYUykz9JVy?=
 =?iso-8859-2?Q?bAJmMAXduO0yaTxw3fjttkip2WDlB3noqzhhW8Cy/wlI2nwKDdC7Oppswp?=
 =?iso-8859-2?Q?zPcHKn6fOy7zsVtQrodv8lFOlOZNnb2ntipI++o34pPVZk3wX/mG7V2GG2?=
 =?iso-8859-2?Q?xu1wH8Ukp34BBvCJLyoHunC3MzvKApxigtUViyTd6oGvDBK6hKRKQmSrgT?=
 =?iso-8859-2?Q?dZxh/RhklTUZCGvvktEsUhehbDZuZFWNVmr5/s1VkYtBIl4aW1dqzAy70m?=
 =?iso-8859-2?Q?doaWM7z1jD/LzqOaFFBb3wGtJHoBerpPFKAa6Y4trep2DXO4/wpON9kbAB?=
 =?iso-8859-2?Q?vVXm8QuXWOW2dSxB5Me+gAOeBjc/DyQ4uIJ9r6Vdhhr25FHv/X4G9Cvu32?=
 =?iso-8859-2?Q?YZFvsq2jM2I9gqiRg9Zp5Yw7/fWS4LF3NfZ7SCyqkEHOzoRTNYubPJbRsw?=
 =?iso-8859-2?Q?RfcJ8MFKMTg2EhPe5oPoCtwRCH4BTtPGBM7lB8j+2XRgj/v3AIuTBxG2CZ?=
 =?iso-8859-2?Q?Qy3hvCdE2+YF80w6IEP3NCT/Jlw2d2frAaYQZrg5HlcHgXXo40NYxvQxlE?=
 =?iso-8859-2?Q?SGKOaoiWUJArAG3ceG0zrN1Gr5kfQdCzWXzc2+2Ywt7d/4FnIMvFDc3+v8?=
 =?iso-8859-2?Q?EaxvUsdYBrpda4q4ebZF2ORzs/GUoP/TEcJTDhfrc9hdBT5OUFsYYO1VvY?=
 =?iso-8859-2?Q?dMYOOKNoc22xJaztq9BE5rHhRbLXfR/9g9eut89dKmBT+2HF8Kf/SYSr18?=
 =?iso-8859-2?Q?B/QEfCs1O9BTQ94r5FY5wwmPEJMeG1J7wwlVuOMqUy/xVkSt34lnkajbmm?=
 =?iso-8859-2?Q?+ha8KiDIGua3YRKLHqg4w5yw4K/oNaDuAp1U48BQQQwmZ9vpUuIqYAhNLz?=
 =?iso-8859-2?Q?eMJpz6rUe1ad7OnnrcTZ2dlzqYYDZLoYQgW+xJ6SmAFg9WDjNK+EH29O7Q?=
 =?iso-8859-2?Q?kLBM/g1I68pQwlpeiuVv+qnBo/hWk6B5cf0SZ8R6YKZFgPbbT8Ustf9iPS?=
 =?iso-8859-2?Q?dfRcXfbORZHCYwdkjFDv5OJRdq1jfH67e/AhCElSlgNN2ioREIebAdpxkb?=
 =?iso-8859-2?Q?Lc3kUQA0WiyzVrDNcrCqGMGcelzcEeb8on/6IhSLB0dSoYNxesLca3iZ6v?=
 =?iso-8859-2?Q?FKCrL8PgBmtTtONkCY065N?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfd4f32-3312-4886-2d5c-08d9955ff7f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 13:29:26.2069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Antoniu.Miclaus@analog.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2220
X-Proofpoint-ORIG-GUID: GmZnCIGhkOPs3xQ4oI8LJA5eWca_Sa3z
X-Proofpoint-GUID: GmZnCIGhkOPs3xQ4oI8LJA5eWca_Sa3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220076
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Great! Thanks a lot!

--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Thursday, October 21, 2021 11:03 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org
> Subject: Re: [PATCH v9 1/2] iio: frequency: adrf6780: add support for
> ADRF6780
>=20
> [External]
>=20
> On Thu, 21 Oct 2021 14:32:43 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > The ADRF6780 is a silicon germanium (SiGe) design, wideband,
> > microwave upconverter optimized for point to point microwave
> > radio designs operating in the 5.9 GHz to 23.6 GHz frequency
> > range.
> >
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-
> sheets/ADRF6780.pdf
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Cutting it fine but hopefully we can sneak this one in before
> the merge window as I'm about to push out for a final inclusion
> in linux-next before sending a pull request.
>=20
> Applied to the togreg branch of iio.git - I tweaked the line breaks
> a little, choosing to relax the align with opening brackets in favour
> of having sub 100 char lines,
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> > changes in v9:
> > 	- add locked and unlocked versions for spi operations and use them
> > 	  accordingly
> > 	- rename `dev` -> `st`
> > 	- rename `struct adrf6780_dev` -> `struct adrf6780_state`
> >  drivers/iio/frequency/Kconfig    |  12 +
> >  drivers/iio/frequency/Makefile   |   1 +
> >  drivers/iio/frequency/adrf6780.c | 521
> +++++++++++++++++++++++++++++++
> >  3 files changed, 534 insertions(+)
> >  create mode 100644 drivers/iio/frequency/adrf6780.c
> >
> > diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kcon=
fig
> > index 240b81502512..2c9e0559e8a4 100644
> > --- a/drivers/iio/frequency/Kconfig
> > +++ b/drivers/iio/frequency/Kconfig
> > @@ -49,5 +49,17 @@ config ADF4371
> >
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called adf4371.
> > +
> > +config ADRF6780
> > +        tristate "Analog Devices ADRF6780 Microwave Upconverter"
> > +        depends on SPI
> > +        depends on COMMON_CLK
> > +        help
> > +          Say yes here to build support for Analog Devices ADRF6780
> > +          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
> > +
> > +          To compile this driver as a module, choose M here: the
> > +          module will be called adrf6780.
> > +
> >  endmenu
> >  endmenu
> > diff --git a/drivers/iio/frequency/Makefile
> b/drivers/iio/frequency/Makefile
> > index 518b1e50caef..ae3136c79202 100644
> > --- a/drivers/iio/frequency/Makefile
> > +++ b/drivers/iio/frequency/Makefile
> > @@ -7,3 +7,4 @@
> >  obj-$(CONFIG_AD9523) +=3D ad9523.o
> >  obj-$(CONFIG_ADF4350) +=3D adf4350.o
> >  obj-$(CONFIG_ADF4371) +=3D adf4371.o
> > +obj-$(CONFIG_ADRF6780) +=3D adrf6780.o
> > diff --git a/drivers/iio/frequency/adrf6780.c
> b/drivers/iio/frequency/adrf6780.c
> > new file mode 100644
> > index 000000000000..b3fb0521196b
> > --- /dev/null
> > +++ b/drivers/iio/frequency/adrf6780.c
> > @@ -0,0 +1,521 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ADRF6780 driver
> > + *
> > + * Copyright 2021 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include <asm/unaligned.h>
> > +
> > +/* ADRF6780 Register Map */
> > +#define ADRF6780_REG_CONTROL			0x00
> > +#define ADRF6780_REG_ALARM_READBACK		0x01
> > +#define ADRF6780_REG_ALARM_MASKS		0x02
> > +#define ADRF6780_REG_ENABLE			0x03
> > +#define ADRF6780_REG_LINEARIZE			0x04
> > +#define ADRF6780_REG_LO_PATH			0x05
> > +#define ADRF6780_REG_ADC_CONTROL		0x06
> > +#define ADRF6780_REG_ADC_OUTPUT			0x0C
> > +
> > +/* ADRF6780_REG_CONTROL Map */
> > +#define ADRF6780_PARITY_EN_MSK			BIT(15)
> > +#define ADRF6780_SOFT_RESET_MSK			BIT(14)
> > +#define ADRF6780_CHIP_ID_MSK			GENMASK(11, 4)
> > +#define ADRF6780_CHIP_ID			0xA
> > +#define ADRF6780_CHIP_REVISION_MSK		GENMASK(3, 0)
> > +
> > +/* ADRF6780_REG_ALARM_READBACK Map */
> > +#define ADRF6780_PARITY_ERROR_MSK		BIT(15)
> > +#define ADRF6780_TOO_FEW_ERRORS_MSK		BIT(14)
> > +#define ADRF6780_TOO_MANY_ERRORS_MSK		BIT(13)
> > +#define ADRF6780_ADDRESS_RANGE_ERROR_MSK	BIT(12)
> > +
> > +/* ADRF6780_REG_ENABLE Map */
> > +#define ADRF6780_VGA_BUFFER_EN_MSK		BIT(8)
> > +#define ADRF6780_DETECTOR_EN_MSK		BIT(7)
> > +#define ADRF6780_LO_BUFFER_EN_MSK		BIT(6)
> > +#define ADRF6780_IF_MODE_EN_MSK			BIT(5)
> > +#define ADRF6780_IQ_MODE_EN_MSK			BIT(4)
> > +#define ADRF6780_LO_X2_EN_MSK			BIT(3)
> > +#define ADRF6780_LO_PPF_EN_MSK			BIT(2)
> > +#define ADRF6780_LO_EN_MSK			BIT(1)
> > +#define ADRF6780_UC_BIAS_EN_MSK			BIT(0)
> > +
> > +/* ADRF6780_REG_LINEARIZE Map */
> > +#define ADRF6780_RDAC_LINEARIZE_MSK		GENMASK(7, 0)
> > +
> > +/* ADRF6780_REG_LO_PATH Map */
> > +#define ADRF6780_LO_SIDEBAND_MSK		BIT(10)
> > +#define ADRF6780_Q_PATH_PHASE_ACCURACY_MSK	GENMASK(7,
> 4)
> > +#define ADRF6780_I_PATH_PHASE_ACCURACY_MSK	GENMASK(3,
> 0)
> > +
> > +/* ADRF6780_REG_ADC_CONTROL Map */
> > +#define ADRF6780_VDET_OUTPUT_SELECT_MSK		BIT(3)
> > +#define ADRF6780_ADC_START_MSK			BIT(2)
> > +#define ADRF6780_ADC_EN_MSK			BIT(1)
> > +#define ADRF6780_ADC_CLOCK_EN_MSK		BIT(0)
> > +
> > +/* ADRF6780_REG_ADC_OUTPUT Map */
> > +#define ADRF6780_ADC_STATUS_MSK			BIT(8)
> > +#define ADRF6780_ADC_VALUE_MSK			GENMASK(7,
> 0)
> > +
> > +struct adrf6780_state {
> > +	struct spi_device	*spi;
> > +	struct clk		*clkin;
> > +	/* Protect against concurrent accesses to the device */
> > +	struct mutex		lock;
> > +	bool			vga_buff_en;
> > +	bool			lo_buff_en;
> > +	bool			if_mode_en;
> > +	bool			iq_mode_en;
> > +	bool			lo_x2_en;
> > +	bool			lo_ppf_en;
> > +	bool			lo_en;
> > +	bool			uc_bias_en;
> > +	bool			lo_sideband;
> > +	bool			vdet_out_en;
> > +	u8			data[3] ____cacheline_aligned;
> > +};
> > +
> > +static int __adrf6780_spi_read(struct adrf6780_state *st, unsigned int=
 reg,
> > +			       unsigned int *val)
> > +{
> > +	int ret;
> > +	struct spi_transfer t =3D {0};
> > +
> > +	st->data[0] =3D 0x80 | (reg << 1);
> > +	st->data[1] =3D 0x0;
> > +	st->data[2] =3D 0x0;
> > +
> > +	t.rx_buf =3D &st->data[0];
> > +	t.tx_buf =3D &st->data[0];
> > +	t.len =3D 3;
> > +
> > +	ret =3D spi_sync_transfer(st->spi, &t, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val =3D (get_unaligned_be24(&st->data[0]) >> 1) & GENMASK(15, 0);
> > +
> > +	return ret;
> > +}
> > +
> > +static int adrf6780_spi_read(struct adrf6780_state *st, unsigned int r=
eg,
> > +			     unsigned int *val)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&st->lock);
> > +	ret =3D adrf6780_spi_read(st, reg, val);
> > +	mutex_unlock(&st->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int __adrf6780_spi_write(struct adrf6780_state *st,
> > +				unsigned int reg,
> > +				unsigned int val)
> > +{
> > +	put_unaligned_be24((val << 1) | (reg << 17), &st->data[0]);
> > +
> > +	return spi_write(st->spi, &st->data[0], 3);
> > +}
> > +
> > +static int adrf6780_spi_write(struct adrf6780_state *st, unsigned int =
reg,
> > +			      unsigned int val)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&st->lock);
> > +	ret =3D adrf6780_spi_write(st, reg, val);
> > +	mutex_unlock(&st->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int __adrf6780_spi_update_bits(struct adrf6780_state *st, unsig=
ned
> int reg,
> > +				      unsigned int mask, unsigned int val)
> > +{
> > +	int ret;
> > +	unsigned int data, temp;
> > +
> > +	ret =3D __adrf6780_spi_read(st, reg, &data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	temp =3D (data & ~mask) | (val & mask);
> > +
> > +	return __adrf6780_spi_write(st, reg, temp);
> > +}
> > +
> > +static int adrf6780_spi_update_bits(struct adrf6780_state *st, unsigne=
d
> int reg,
> > +				    unsigned int mask, unsigned int val)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&st->lock);
> > +	ret =3D __adrf6780_spi_update_bits(st, reg, mask, val);
> > +	mutex_unlock(&st->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int adrf6780_read_adc_raw(struct adrf6780_state *st, unsigned i=
nt
> *read_val)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&st->lock);
> > +
> > +	ret =3D __adrf6780_spi_update_bits(st,
> ADRF6780_REG_ADC_CONTROL,
> > +					 ADRF6780_ADC_EN_MSK |
> > +					 ADRF6780_ADC_CLOCK_EN_MSK |
> > +					 ADRF6780_ADC_START_MSK,
> > +
> FIELD_PREP(ADRF6780_ADC_EN_MSK, 1) |
> > +
> FIELD_PREP(ADRF6780_ADC_CLOCK_EN_MSK, 1) |
> > +
> FIELD_PREP(ADRF6780_ADC_START_MSK, 1));
> > +	if (ret)
> > +		goto exit;
> > +
> > +	/* Recommended delay for the ADC to be ready*/
> > +	usleep_range(200, 250);
> > +
> > +	ret =3D __adrf6780_spi_read(st, ADRF6780_REG_ADC_OUTPUT,
> read_val);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	if (!(*read_val & ADRF6780_ADC_STATUS_MSK)) {
> > +		ret =3D -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	ret =3D __adrf6780_spi_update_bits(st,
> ADRF6780_REG_ADC_CONTROL,
> > +					 ADRF6780_ADC_START_MSK,
> > +
> FIELD_PREP(ADRF6780_ADC_START_MSK, 0));
> > +	if (ret)
> > +		goto exit;
> > +
> > +	ret =3D __adrf6780_spi_read(st, ADRF6780_REG_ADC_OUTPUT,
> read_val);
> > +
> > +exit:
> > +	mutex_unlock(&st->lock);
> > +	return ret;
> > +}
> > +
> > +static int adrf6780_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val, int *val2, long info)
> > +{
> > +	struct adrf6780_state *dev =3D iio_priv(indio_dev);
> > +	unsigned int data;
> > +	int ret;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret =3D adrf6780_read_adc_raw(dev, &data);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val =3D data & ADRF6780_ADC_VALUE_MSK;
> > +
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		ret =3D adrf6780_spi_read(dev, ADRF6780_REG_LINEARIZE,
> &data);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val =3D data & ADRF6780_RDAC_LINEARIZE_MSK;
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_PHASE:
> > +		ret =3D adrf6780_spi_read(dev, ADRF6780_REG_LO_PATH,
> &data);
> > +		if (ret)
> > +			return ret;
> > +
> > +		switch (chan->channel2) {
> > +		case IIO_MOD_I:
> > +			*val =3D data &
> ADRF6780_I_PATH_PHASE_ACCURACY_MSK;
> > +
> > +			return IIO_VAL_INT;
> > +		case IIO_MOD_Q:
> > +			*val =3D
> FIELD_GET(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, data);
> > +
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int adrf6780_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long info)
> > +{
> > +	struct adrf6780_state *st =3D iio_priv(indio_dev);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return adrf6780_spi_write(st, ADRF6780_REG_LINEARIZE,
> val);
> > +	case IIO_CHAN_INFO_PHASE:
> > +		switch (chan->channel2) {
> > +		case IIO_MOD_I:
> > +			return adrf6780_spi_update_bits(st,
> ADRF6780_REG_LO_PATH,
> > +
> 	ADRF6780_I_PATH_PHASE_ACCURACY_MSK,
> > +
> 	FIELD_PREP(ADRF6780_I_PATH_PHASE_ACCURACY_MSK, val));
> > +		case IIO_MOD_Q:
> > +			return adrf6780_spi_update_bits(st,
> ADRF6780_REG_LO_PATH,
> > +
> 	ADRF6780_Q_PATH_PHASE_ACCURACY_MSK,
> > +
> 	FIELD_PREP(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, val));
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int adrf6780_reg_access(struct iio_dev *indio_dev,
> > +			       unsigned int reg,
> > +			       unsigned int write_val,
> > +			       unsigned int *read_val)
> > +{
> > +	struct adrf6780_state *st =3D iio_priv(indio_dev);
> > +
> > +	if (read_val)
> > +		return adrf6780_spi_read(st, reg, read_val);
> > +	else
> > +		return adrf6780_spi_write(st, reg, write_val);
> > +}
> > +
> > +static const struct iio_info adrf6780_info =3D {
> > +	.read_raw =3D adrf6780_read_raw,
> > +	.write_raw =3D adrf6780_write_raw,
> > +	.debugfs_reg_access =3D &adrf6780_reg_access,
> > +};
> > +
> > +#define ADRF6780_CHAN_ADC(_channel) {			\
> > +	.type =3D IIO_ALTVOLTAGE,				\
> > +	.output =3D 0,					\
> > +	.indexed =3D 1,					\
> > +	.channel =3D _channel,				\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)	\
> > +}
> > +
> > +#define ADRF6780_CHAN_RDAC(_channel) {			\
> > +	.type =3D IIO_ALTVOLTAGE,				\
> > +	.output =3D 1,					\
> > +	.indexed =3D 1,					\
> > +	.channel =3D _channel,				\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE)	\
> > +}
> > +
> > +#define ADRF6780_CHAN_IQ_PHASE(_channel, rf_comp) {		\
> > +	.type =3D IIO_ALTVOLTAGE,					\
> > +	.modified =3D 1,						\
> > +	.output =3D 1,						\
> > +	.indexed =3D 1,						\
> > +	.channel2 =3D IIO_MOD_##rf_comp,				\
> > +	.channel =3D _channel,					\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_PHASE)		\
> > +}
> > +
> > +static const struct iio_chan_spec adrf6780_channels[] =3D {
> > +	ADRF6780_CHAN_ADC(0),
> > +	ADRF6780_CHAN_RDAC(0),
> > +	ADRF6780_CHAN_IQ_PHASE(0, I),
> > +	ADRF6780_CHAN_IQ_PHASE(0, Q),
> > +};
> > +
> > +static int adrf6780_reset(struct adrf6780_state *st)
> > +{
> > +	int ret;
> > +	struct spi_device *spi =3D st->spi;
> > +
> > +	ret =3D __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
> > +					 ADRF6780_SOFT_RESET_MSK,
> > +
> FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
> > +	if (ret) {
> > +		dev_err(&spi->dev, "ADRF6780 SPI software reset
> failed.\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
> > +					 ADRF6780_SOFT_RESET_MSK,
> > +
> FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 0));
> > +	if (ret) {
> > +		dev_err(&spi->dev, "ADRF6780 SPI software reset disable
> failed.\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adrf6780_init(struct adrf6780_state *st)
> > +{
> > +	int ret;
> > +	unsigned int chip_id, enable_reg, enable_reg_msk;
> > +	struct spi_device *spi =3D st->spi;
> > +
> > +	/* Perform a software reset */
> > +	ret =3D adrf6780_reset(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D __adrf6780_spi_read(st, ADRF6780_REG_CONTROL, &chip_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	chip_id =3D FIELD_GET(ADRF6780_CHIP_ID_MSK, chip_id);
> > +	if (chip_id !=3D ADRF6780_CHIP_ID) {
> > +		dev_err(&spi->dev, "ADRF6780 Invalid Chip ID.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	enable_reg_msk =3D ADRF6780_VGA_BUFFER_EN_MSK |
> > +			ADRF6780_DETECTOR_EN_MSK |
> > +			ADRF6780_LO_BUFFER_EN_MSK |
> > +			ADRF6780_IF_MODE_EN_MSK |
> > +			ADRF6780_IQ_MODE_EN_MSK |
> > +			ADRF6780_LO_X2_EN_MSK |
> > +			ADRF6780_LO_PPF_EN_MSK |
> > +			ADRF6780_LO_EN_MSK |
> > +			ADRF6780_UC_BIAS_EN_MSK;
> > +
> > +	enable_reg =3D FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, st-
> >vga_buff_en) |
> > +			FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, 1) |
> > +			FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, st-
> >lo_buff_en) |
> > +			FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, st-
> >if_mode_en) |
> > +			FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, st-
> >iq_mode_en) |
> > +			FIELD_PREP(ADRF6780_LO_X2_EN_MSK, st-
> >lo_x2_en) |
> > +			FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, st-
> >lo_ppf_en) |
> > +			FIELD_PREP(ADRF6780_LO_EN_MSK, st->lo_en) |
> > +			FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, st-
> >uc_bias_en);
> > +
> > +	ret =3D __adrf6780_spi_update_bits(st, ADRF6780_REG_ENABLE,
> enable_reg_msk, enable_reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D __adrf6780_spi_update_bits(st, ADRF6780_REG_LO_PATH,
> > +					 ADRF6780_LO_SIDEBAND_MSK,
> > +
> FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, st->lo_sideband));
> > +	if (ret)
> > +		return ret;
> > +
> > +	return __adrf6780_spi_update_bits(st,
> ADRF6780_REG_ADC_CONTROL,
> > +
> ADRF6780_VDET_OUTPUT_SELECT_MSK,
> > +
> FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK, st->vdet_out_en));
> > +}
> > +
> > +static void adrf6780_properties_parse(struct adrf6780_state *st)
> > +{
> > +	struct spi_device *spi =3D st->spi;
> > +
> > +	st->vga_buff_en =3D device_property_read_bool(&spi->dev, "adi,vga-
> buff-en");
> > +	st->lo_buff_en =3D device_property_read_bool(&spi->dev, "adi,lo-
> buff-en");
> > +	st->if_mode_en =3D device_property_read_bool(&spi->dev, "adi,if-
> mode-en");
> > +	st->iq_mode_en =3D device_property_read_bool(&spi->dev, "adi,iq-
> mode-en");
> > +	st->lo_x2_en =3D device_property_read_bool(&spi->dev, "adi,lo-x2-
> en");
> > +	st->lo_ppf_en =3D device_property_read_bool(&spi->dev, "adi,lo-ppf-
> en");
> > +	st->lo_en =3D device_property_read_bool(&spi->dev, "adi,lo-en");
> > +	st->uc_bias_en =3D device_property_read_bool(&spi->dev, "adi,uc-
> bias-en");
> > +	st->lo_sideband =3D device_property_read_bool(&spi->dev, "adi,lo-
> sideband");
> > +	st->vdet_out_en =3D device_property_read_bool(&spi->dev,
> "adi,vdet-out-en");
> > +}
> > +
> > +static void adrf6780_clk_disable(void *data)
> > +{
> > +	clk_disable_unprepare(data);
> > +}
> > +
> > +static void adrf6780_powerdown(void *data)
> > +{
> > +	/* Disable all components in the Enable Register */
> > +	adrf6780_spi_write(data, ADRF6780_REG_ENABLE, 0x0);
> > +}
> > +
> > +static int adrf6780_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct adrf6780_state *st;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st =3D iio_priv(indio_dev);
> > +
> > +	indio_dev->info =3D &adrf6780_info;
> > +	indio_dev->name =3D "adrf6780";
> > +	indio_dev->channels =3D adrf6780_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(adrf6780_channels);
> > +
> > +	st->spi =3D spi;
> > +
> > +	adrf6780_properties_parse(st);
> > +
> > +	st->clkin =3D devm_clk_get(&spi->dev, "lo_in");
> > +	if (IS_ERR(st->clkin))
> > +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> > +				     "failed to get the LO input clock\n");
> > +
> > +	ret =3D clk_prepare_enable(st->clkin);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_add_action_or_reset(&spi->dev, adrf6780_clk_disable,
> st->clkin);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_init(&st->lock);
> > +
> > +	ret =3D adrf6780_init(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_add_action_or_reset(&spi->dev, adrf6780_powerdown,
> st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(&spi->dev, indio_dev);
> > +}
> > +
> > +static const struct spi_device_id adrf6780_id[] =3D {
> > +	{ "adrf6780", 0 },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(spi, adrf6780_id);
> > +
> > +static const struct of_device_id adrf6780_of_match[] =3D {
> > +	{ .compatible =3D "adi,adrf6780" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, adrf6780_of_match);
> > +
> > +static struct spi_driver adrf6780_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "adrf6780",
> > +		.of_match_table =3D adrf6780_of_match,
> > +	},
> > +	.probe =3D adrf6780_probe,
> > +	.id_table =3D adrf6780_id,
> > +};
> > +module_spi_driver(adrf6780_driver);
> > +
> > +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
> > +MODULE_DESCRIPTION("Analog Devices ADRF6780");
> > +MODULE_LICENSE("GPL v2");

