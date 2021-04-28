Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF69236DBA9
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhD1Pbv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 11:31:51 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23198 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229624AbhD1Pbu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 11:31:50 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFQEw3025051;
        Wed, 28 Apr 2021 11:30:46 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2057.outbound.protection.outlook.com [104.47.36.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 3865r9pnma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 11:30:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9ODnsdov8PBuJPajEJn8byYtfVSkQFmEyGglz6oAtk8VSKaTpIrfeqdJqfC9N3+Er2g/LzqJp0J0nJLQc1yoh9Jj/sTSsX74Q5JwV21m+4cidA+PlwybwGioga0PQtv9Own642GRDRx38SkY+D2sx0Lq6FUpqXYZZ0+FPOGq+Nj5GBIKkN6lvTSJGVkrHY8WDKj5fOX2Aupo30B56ppwCEF2Y6AFykqOxlKB9+WVJTthDKi4t6jMZaMIB1+rjiMIYXxF6/hAPmDVqHZRjUwWKKlzzMPj8JuL04F0oUnSfywIxlbihPBmt+1CQSY378rqpEQ/mkSQOE2f3JxGIVkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdbtMFCIiSW7IE+hoAFbLOyEB/rR9rN8GAAmhNvGmA4=;
 b=mZ9oXXnVt/qIgiyqC5fb51p9RDGO9fwPCwYyWnvLLLUoXYKzza/QhAn2qdHNWpr45BJPfi8Tnud0W94JoBcjSP+sM9hSY43/Ucp1FdZyFOOjsrYN9oCR/oDx17+feuWzB2DR5y9bzXHc4NXhsLQDFhW82PlSmy84GxQmEF27rj4w/hX5hgfpDa/azXHKWchWXvXh6ZNTNDoqgrgG4tkPq3caJQwiKhB8ozUmFtiqKwwnq75zsxkVPpODExghRay1Z839mDSZoQYaJz/GknvSytGoth9o4MjMVtLHo+Fxb2zhLpduUq3fNRmiIt5yxLcDPx639c0gnp8NuD56iabm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdbtMFCIiSW7IE+hoAFbLOyEB/rR9rN8GAAmhNvGmA4=;
 b=r9jNdvAaGM4aCEds6hahtmj761D/55aXRmtYN5cCBWH966YvMw5BkWH8lQ2izF4pnzVT7+A5CNnM4DyVMB5aVBnTvlRhH0tlFE9GNDNxZGeQaEoGtT4VOl36Y/WllQwA+qBtXKe2Ax2T+Jlu8PAVxI5Q8vHuDiVkEdAuSLY9/zY=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY4PR03MB2743.namprd03.prod.outlook.com (2603:10b6:903:6b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:30:43 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:30:43 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
Thread-Topic: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
Thread-Index: AQHXPEBt7lP4jf8Fa0q9Q53QuBs0oarKDhSA
Date:   Wed, 28 Apr 2021 15:30:43 +0000
Message-ID: <CY4PR03MB3112198E9789BF3D95959E6F99409@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210428150815.136150-1-paul@crapouillou.net>
In-Reply-To: <20210428150815.136150-1-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcGRh?=
 =?us-ascii?Q?dGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUz?=
 =?us-ascii?Q?NWJcbXNnc1xtc2ctYjA4MmE0ODEtYTgzNi0xMWViLThiNDMtZmM3Nzc0MjFm?=
 =?us-ascii?Q?Y2FlXGFtZS10ZXN0XGIwODJhNDgzLWE4MzYtMTFlYi04YjQzLWZjNzc3NDIx?=
 =?us-ascii?Q?ZmNhZWJvZHkudHh0IiBzej0iMTM1NCIgdD0iMTMyNjQwOTc0NDE4MTkxMDA0?=
 =?us-ascii?Q?IiBoPSJsdmFSRVFCcWcyMTFuR2tsdGtnTHBQYmtheXc9IiBpZD0iIiBibD0i?=
 =?us-ascii?Q?MCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFJWURBQUNjb3R0?=
 =?us-ascii?Q?eVF6elhBZXhDY1B0NFpvMUQ3RUp3KzNobWpVTUZBQUFBQUFBQUFBQUFBQUFB?=
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
authentication-results: crapouillou.net; dkim=none (message not signed)
 header.d=none;crapouillou.net; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:25a4:df01:5c98:212a:483b:818e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55e16f12-e14d-4325-34ec-08d90a5a9646
x-ms-traffictypediagnostic: CY4PR03MB2743:
x-microsoft-antispam-prvs: <CY4PR03MB27433E4FF70D704CA305D8BE99409@CY4PR03MB2743.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vLOOHD1VQ7cTg9ioigxMD3ZVIN2HIXFCWipUBsq5gdiJcSc1Z1oIZhFuwh0a+kESg9miEC+ACFWGQofKvouRT3hcHdyJo4zACH+f56O3v4Lwh5/Ncg/0ftLp0pytTrNuqzdz16bljUWON3z9l6vcNZzaRkj/QDY8jDnD/BWlxOnBpKsI+56MG1JwAnShtLdnUuR14NI317AViNjCDyMfBw8xGrdIurpaHWzDvbi7z1lyrzHVIFYSeDFWhloNxnn4UVZbD7Mrd9jtRTCfR3lzODCI/4pzW5N314c7X2BgFtVLKLwgamWvCSEiPuZNAX2mtZNVj+cs4CKBvbL7HVjj3UVIjBlwzah1M+gEAN/qq+z8cy0mTtyNze634K6zlC7vJSglFnzasrZ4CqkoPzJt4JUjfBlMoh/RHVQ7uQtSAXnSwN4NDds2WCmnbN/o6hQHORujgelizg5Xx6z20Di7c2xlBComBkGFNJCggnxPX5+YZ/LkzSM0gXmrHTmvggn12hPQadDV3Pei+ahY0c7uJLiD2IBtneUNm7gfdUpy6dg9fYiYzTXPy34HsDCMI0oQJn7onkXK37ctUJymPZxyPxqWKghpFLfYa88J9tjzOI8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(71200400001)(76116006)(4326008)(83380400001)(33656002)(54906003)(110136005)(478600001)(122000001)(186003)(64756008)(66476007)(86362001)(6506007)(7696005)(2906002)(9686003)(52536014)(8936002)(55016002)(5660300002)(66446008)(8676002)(66946007)(53546011)(316002)(38100700002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oskVjZPn3wBhYWhWLY1O4t7HV06nnBnHEfB2BCwxhxJSQxqIJUGSpKv/AFwt?=
 =?us-ascii?Q?1jSZbMl3GLJq+wFaUSA4d5Zt7l5Ui8SEJALUHsUkqX8bTf0VpgckpUxNq/Wk?=
 =?us-ascii?Q?hK3CFV/rhJRyWW2DTYHW5Dy1Lj7us1/IaKpvT6mLGFNeiLzAxnrfzPnf/ogC?=
 =?us-ascii?Q?AjQEFSxla053JGLOJyJ/2qTM4RaObCNO6E7mK0YgQOxNTKyXJgQgVUBzcol6?=
 =?us-ascii?Q?ZUVR1geTARkpY625xUs8LwrmgXf4F61mdpY4r5eGWEVNf9eJZtj+QrvdUHM4?=
 =?us-ascii?Q?jJKKKnNrUv+hVjb1UNm1ra+InjKCDprYmbqMWK3P+7SvaAK2S6enu3MJbG2Y?=
 =?us-ascii?Q?0AJSNLsw1wButWNO4FggYWdT9/A32Tak1wq6aJx1rRfP9WL87i78+UCwHdZV?=
 =?us-ascii?Q?j/tQp9oC07BUIzU9Nn/LDLJargYBvnk8KQG557QKx+Y32eozOAjvjdpSzqr5?=
 =?us-ascii?Q?UhCcJOtHtdAoh2+CjWYmk6VvTZdShYQXMNhPIeOIVMARQy9cnuu3KY0my+0A?=
 =?us-ascii?Q?a7kpWFWKkCj/87ZZ3dhlBOFCZ8n3KwHKlAku95aP96hTM7OR92aEyybmHb3H?=
 =?us-ascii?Q?rJzlA1tEEaKguKe16gyUxZz0uIrpiJlrHXDa0kPNzNNvmTJWbKHwFzdMTBWx?=
 =?us-ascii?Q?Raej4o8yUszDPwHl+DPoDlcyvHesKe5ZSITILrwSkSf+m0TI+1EekE45Y/xd?=
 =?us-ascii?Q?vVEhPv6ggBFmI20Lw9gTm17Pc7SVtfiQVH3ywW9AInNJvnnC8CEodrD0uFf1?=
 =?us-ascii?Q?OxQak+tbQjWkjlK9VYId1cHp0fiCzkXpvuiqAGf9/kEiNZhXWLUjVl5JdwkU?=
 =?us-ascii?Q?L/pgfVm9KkalXvK2KBeQt9g9X4i+4xNEygE6xYQAmMerybu/wIrJU3wy3xpr?=
 =?us-ascii?Q?zcufZRLMSSEB83jb9zvjltjYpxxuP4diB6ua6jMufTiBg0oimftBemvlcZfu?=
 =?us-ascii?Q?NCGfWCYzqdjDWGJ8Sbudkks+YjzebbBMbhnTKEpEaQBID8gUPT/cRcV4HRaw?=
 =?us-ascii?Q?hhS3AZE/ZZHDV9b+nlmL5li/MCmjhL45YMgqy45DF90sNLO1mrkGd5246KTN?=
 =?us-ascii?Q?aTSqLStZs4pKDuvkQ8tRmX1Gh0768L0tCUihlggjRFlor405McyZ+767NakQ?=
 =?us-ascii?Q?kPufF/YGVPOY3XHqLedcNFjveCtbNCMRmLTEkOKqMAXKR6b2ANTFPQGX3AzR?=
 =?us-ascii?Q?tlYr9JWd4krQwqF8Od3ulfyX9aUulKUhJ8N9V0q91dF3Mhq9sOrwbp0nsnKc?=
 =?us-ascii?Q?9R12+gR5EZawf/NtMICxpIYQAZ5MxAo5xi0ElCG48SfCMguPx4J5S87q8E4S?=
 =?us-ascii?Q?HdE0e1K4mxBjB+ASbn1mKGQiNzSvoJhs0hzfH8yf+/drdxnUrzXB3wtmKlSN?=
 =?us-ascii?Q?j5di5tRpVvVYgkKs1vQU2AvwAjQq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e16f12-e14d-4325-34ec-08d90a5a9646
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:30:43.3194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X54tSeX+k3kK/iHtiHTIRYPpdUC1Pjk3xwMwT+9XDbP8849bWutMBNNBGty9X8/1KugqPePH1r4ss7NnM4JTew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2743
X-Proofpoint-ORIG-GUID: 5mi0tGPcxwm2yp-1yIvY5bxFK5KdqaOQ
X-Proofpoint-GUID: 5mi0tGPcxwm2yp-1yIvY5bxFK5KdqaOQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_09:2021-04-28,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280101
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Paul Cercueil <paul@crapouillou.net>
> Sent: Wednesday, April 28, 2021 5:08 PM
> To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Paul
> Cercueil <paul@crapouillou.net>
> Subject: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
>=20
>=20
> The ioctrl() call will return errno=3DEINVAL if the device does not
> support the events interface, and not ENODEV.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> ---
>  tools/iio/iio_event_monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/iio/iio_event_monitor.c
> b/tools/iio/iio_event_monitor.c
> index bb03859db89d..cdd9a84f18fa 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -323,7 +323,7 @@ int main(int argc, char **argv)
>  	ret =3D ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
>  	if (ret =3D=3D -1 || event_fd =3D=3D -1) {
>  		ret =3D -errno;
> -		if (ret =3D=3D -ENODEV)
> +		if (ret =3D=3D -EINVAL)
>  			fprintf(stderr,
>  				"This device does not support
> events\n");
>  		else
> --
> 2.30.2

