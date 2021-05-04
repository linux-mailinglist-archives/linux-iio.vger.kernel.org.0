Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309BD372658
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 09:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhEDHLd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 03:11:33 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:49712 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229995AbhEDHLc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 03:11:32 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1447523S008627;
        Tue, 4 May 2021 03:10:21 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-00128a01.pphosted.com with ESMTP id 38amtctbvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 03:10:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdsJTML4E/SRU9jgt5iknzX/D2k3W/AAQx3b7SuYIiFaGKolXNtCX27qI7/CB1OtfbpgN5hLBy7VnhIEpDzquHV1T56dbI3+1k9/+jYQsajyFksmyg/tdcV30fziCV9Y48n4SKyw78Y44Jvkmh92NW6cCdVO0u724sLqiT0RP0mvF4AB7tvk9A9fyj9u30WQwGya3LyRs/WA4d/9qVCqShthYoJbFseemkCZtWowaCy5VCqXamGZVD9MBgsYsfSzh8RaNcNJqTrZOvk1WBXbDZi8mYt/eBOjuVKz+8EJ2GAKwEy2FR4h76qfX/VaP0D9z+jaNIwmUZDECFu+5hRPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkL8pnI56av7lojWqeOKmc9v0ucFCJxLlbgqmftZ5PY=;
 b=Tj0/Xxnk6QNC2I80VdudTihMWtsP9dvsd+nwfwua2CwO4W+sPK+8aUP1tYxgaJi/PqLSYlbrysTOIfI2vbljBp4KQQSN6+w01sLM0IlnwHHjuotWhJcWqcDToKFuIEuI4iBb79BaXYb3cDy3OgUOA8wZzLtPHQlWMv0T79lx1Nyecg/c+IYxyYzRwpS1eALcPrdSgI08jK+gSDpeOhsqAtlp3YA8l7st19aWQSSuLcAk+RzLS5Xh5zQ4R+eP2V7IvujQoZLN8v8SZzfVL1DpmxRL3QVDzl/r5icJGkjh1b67y+lNMG88O3NnTipvVWpiBbuc+Q/JnL+Lbos8knLvow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkL8pnI56av7lojWqeOKmc9v0ucFCJxLlbgqmftZ5PY=;
 b=6gK0ZmHdU9TXHP0XJe1a52miuvxjKzswaUl8xBDZO2FQfqyJ0CkNjkLmkTc3yILIaX/ooAmEUlKjS8JO8zjJ0Y7i9Z2H1CVlBXQeJRSmHrtC9xl6Gq9iM2GssqvM2oHDrrt7saCSkwRYgZJjNq8H2u2bTdLMz3nuM1bjLDbZzGI=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5765.namprd03.prod.outlook.com (2603:10b6:510:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 07:10:19 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::811f:3542:ef73:92ef]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::811f:3542:ef73:92ef%6]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 07:10:19 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: RE: [PATCH] iio: core: return ENODEV if ioctl is unknown
Thread-Topic: [PATCH] iio: core: return ENODEV if ioctl is unknown
Thread-Index: AQHXQCrCxfTLsNo77UuEgqa1zoIhb6rS6BuQ
Date:   Tue, 4 May 2021 07:10:19 +0000
Message-ID: <PH0PR03MB6366BD5B07B0E42FD436774B995A9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210503144350.7496-1-aardelean@deviqon.com>
In-Reply-To: <20210503144350.7496-1-aardelean@deviqon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYzcwMDcyYjQtYWNhNy0xMWViLThiNDktZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XGM3MDA3MmI2LWFjYTctMTFlYi04YjQ5LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMjU1MCIgdD0iMTMyNjQ1ODU4MT?=
 =?iso-8859-1?Q?czMzEyNDc3IiBoPSJSZDJqMm5BMHQyK3dLM1pKQ3dNaVVMVVUrcU09IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQURkM1ZpSnRFRFhBUkEyMHF5VW1HT3dFRGJTckpTWVk3QUZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQWJKUFNkUUFBQUFBQUFBQUFBQUFBQUo0?=
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
authentication-results: deviqon.com; dkim=none (message not signed)
 header.d=none;deviqon.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b8352e3-79cf-4289-d475-08d90ecbad18
x-ms-traffictypediagnostic: PH0PR03MB5765:
x-microsoft-antispam-prvs: <PH0PR03MB5765A177DAFF454FFE001AC5995A9@PH0PR03MB5765.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pbgDqcmwRqYZhKcxgHkDib/mfCu2uGe5dqIInCxYq9+TWM4Dash67+tLaJbxapxMqw0QdwAv1hGhEjdXJvmPtcSh87FMIZUHNZZ0+sil3NDMwXRZbvL2/yxBI2ImXoJJzMlIdEMaaQwCZZJjKZaHkGDvTPfLXjXFysMdOJpqfWKGf9WmxjnQdZuKq0+UvdPKtcRLXgnb42ObHjr897eL7XkQtvjii6HDYXoPaiQBcWpv1woB/WsZJK3xA/gg7lNTD/lKn0QhtcajhhuH1YPRVsAboqDOIZIVxSQx7DUHHrHrsnZjeY1udDDuZDZzQ2lEx4s0erbMSL1V18y05me3JhvvpULtyY72InaBO5h/zlVSJD0nUaQHIUzmQ+A6h+AN4f6ZvmanMmMEhdtbbDxZsmLQsmWmJXKd1BgI0VCblCmAGfos3uMusZkEZd+Mw6hxQ/Tt1OxJ4y0HqScBpheU8tjER5I3SDzNkXeOgJY18O40x3WpXSG3sIrqumsfHlEyv+DV/u3vbKsUSxu2EH4vdyXkTnVbEJJEy1ybf2RPEkLp6uEA3pDLV3AzSmu3Ubhbc/ruYA75CpYgIPOchI00qgMayrGIdSeX6nuXvAp7YnhPcgS7dsNbs2othDzPRAwU7JVaV8ffyeEpF7zoPlT3aMAgENNiTo6cZWuxGXIKxol0joDU/QRJqjLrzWf4ifC6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(66946007)(7696005)(55016002)(9686003)(2906002)(316002)(76116006)(26005)(64756008)(53546011)(122000001)(66476007)(4326008)(66446008)(6506007)(186003)(966005)(86362001)(71200400001)(110136005)(5660300002)(478600001)(33656002)(38100700002)(83380400001)(8676002)(66556008)(8936002)(52536014)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ZKDHHlP3OmAHEnYmpRwNlx69JGnJqSfOei9JC+RMB+nwOmJ8tT7lCSGtSS?=
 =?iso-8859-1?Q?xE0/CEUeUIz+10VJwMDXbM4MesIJkMmvSVat+wBZPnzBoTbJtkDOt6dDh9?=
 =?iso-8859-1?Q?ChjW5yEkuNczNiAsasx/oB4ERcraw/Euo//QwFBfUVkOnYD61kvXiylXEO?=
 =?iso-8859-1?Q?r/nY5R9PN6+hXzVo//Q/Wl41AHNTzplaHH2xsDBuMsuOFQ+LovN+WJSLoH?=
 =?iso-8859-1?Q?SqPek9w/kV1ipBb0dskqkTy7GxNYoeWuJ951lBKhthJwAmuYXweanRxtPr?=
 =?iso-8859-1?Q?1UAlwGLt/Tb5WqpymhCZNzhAQdRyyyuc0aicWWij1DfG/kJahhAoUX90CZ?=
 =?iso-8859-1?Q?cGTrQHguss3HaeHu0VGCq6p/cWWZ0B4amwbHAMr8dOj9LNy0T5eJ1HkAgB?=
 =?iso-8859-1?Q?AznjmjFXQIuENSE5TQjh0OsPZzFRBMqntz0Cf8WhW6HD1tIXw53NPSmz+U?=
 =?iso-8859-1?Q?iKXoySvvaK+r6ib3my4gJc1Hbs665Nr3vwgcKpbh4sguWVWq3dcPMrCj0y?=
 =?iso-8859-1?Q?Xpr8iTa8mEOV0lnxsUenpRIXjvvV2Gf2ykAbClJCPK+C8dEEmOuP/cTdd4?=
 =?iso-8859-1?Q?somwb/SXj7q+jamtXBIAeOmxnIjUIvC9wteHWWIGnl8g5QVRjUBAfxHNl5?=
 =?iso-8859-1?Q?qC0hG2z8EWIsAX/hIODvCimx+asiy1rx4FFqeEhIOoulGoLPEDxcTemiMy?=
 =?iso-8859-1?Q?yj9Ot6YBgx2+P/8EqCxCWZmp+KCbhL6AreEiQoe2m2eS0uarwOkBATbNid?=
 =?iso-8859-1?Q?be7SPRH0WN2ped531Lbv4cZ9W+8OQ01eVqBHNwKaAiMjrvSvw+Ar7YzuTh?=
 =?iso-8859-1?Q?tFgwS2wh8N3ieDmRrCvE4DWbPzihAyRxi4JNXdBMiQLvWrjIUY3CIKVSBM?=
 =?iso-8859-1?Q?iUeH44TeC93R39SLpC0UFus00ZQvaRydBp4BDXJsjEjcg1bi87K6WrtIat?=
 =?iso-8859-1?Q?mPGYIwoTM5UrEymspS5B9z2jeBwXBOmtYP8hX/xn+pRpK5pJ9cPrtPLj+H?=
 =?iso-8859-1?Q?lf9suvzUUYV0eqkwia3RxC0TZYumelznVHKDeJIrlyxfAy7K0LAczlQzml?=
 =?iso-8859-1?Q?Fbn05X+QosLOHrQzh/Sn/D5j3MC6yKR/Jj5B4VSH3run7xgoo9W66E905w?=
 =?iso-8859-1?Q?0JLe8rYroo4KTTPTNCMSpmPZbKUL6c0FmPj0m8UEfaw9E4R4KIlCjrcfXo?=
 =?iso-8859-1?Q?BvCSGspx9e01bFEmuW4VFWoIMPpuas3qCtLgsZpWD7w/T1+Xs/iOYz4y40?=
 =?iso-8859-1?Q?4o8AvwcBupfwBjCIOcnXAtEpnm6aUdyy0INaWqFtuvCGxmu5BiM5xmCiZw?=
 =?iso-8859-1?Q?JXgalt5PrE03aOq//TGoH0K+hi3/NsYQPbYGXKpeB0j2dUAcERrclXKIaq?=
 =?iso-8859-1?Q?7ZsHSQACI+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8352e3-79cf-4289-d475-08d90ecbad18
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 07:10:19.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOq+w/KvP7h1eNuHDwEguz4BnprFL21B/rfzzVFTLVCarjBc2WGd+yONe3DWmnUFtzGrV4F8FaLeOxaf5U66Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5765
X-Proofpoint-ORIG-GUID: b9UTAdaCSmx5GYpGNUcov_kQ7RRfmfjt
X-Proofpoint-GUID: b9UTAdaCSmx5GYpGNUcov_kQ7RRfmfjt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_02:2021-05-03,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Alexandru Ardelean <aardelean@deviqon.com>
> Sent: Monday, May 3, 2021 4:44 PM
> To: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: jic23@kernel.org; lars@metafoo.de; Alexandru Ardelean
> <aardelean@deviqon.com>; Linus Walleij <linus.walleij@linaro.org>;
> Paul Cercueil <paul@crapouillou.net>; Sa, Nuno
> <Nuno.Sa@analog.com>
> Subject: [PATCH] iio: core: return ENODEV if ioctl is unknown
> =20
> When the ioctl() mechanism was introduced in IIO core to centralize
> the
> registration of all ioctls in one place via commit 8dedcc3eee3ac ("iio:
> core: centralize ioctl() calls to the main chardev"), the return code was
> changed from ENODEV to EINVAL, when the ioctl code isn't known.
>=20
> This was done by accident.
>=20
> This change reverts back to the old behavior, where if the ioctl() code
> isn't known, ENODEV is returned (vs EINVAL).
>=20
> This was brought into perspective by this patch:
>   https://urldefense.com/v3/__https://lore.kernel.org/linux-
> iio/20210428150815.136150-1-
> paul@crapouillou.net/__;!!A3Ni8CS0y2Y!rbiZhkgdYhOPdii_YEAgO0BlX
> UxYANj3juvQuoWtaH61DSon2xK5i_BRar5Jyw$
>=20
> Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main
> chardev")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

>  drivers/iio/industrialio-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-
> core.c
> index efb4cf91c9e4..9a3a83211a90 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1803,7 +1803,6 @@ static long iio_ioctl(struct file *filp, unsigned
> int cmd, unsigned long arg)
>  	if (!indio_dev->info)
>  		goto out_unlock;
>=20
> -	ret =3D -EINVAL;
>  	list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers,
> entry) {
>  		ret =3D h->ioctl(indio_dev, filp, cmd, arg);
>  		if (ret !=3D IIO_IOCTL_UNHANDLED)
> @@ -1811,7 +1810,7 @@ static long iio_ioctl(struct file *filp, unsigned
> int cmd, unsigned long arg)
>  	}
>=20
>  	if (ret =3D=3D IIO_IOCTL_UNHANDLED)
> -		ret =3D -EINVAL;
> +		ret =3D -ENODEV;
>=20
>  out_unlock:
>  	mutex_unlock(&iio_dev_opaque->info_exist_lock);
> --
> 2.31.1

- Nuno S=E1

