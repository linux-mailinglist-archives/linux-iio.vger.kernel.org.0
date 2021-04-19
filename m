Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87385363CF4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 09:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhDSHsj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 03:48:39 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:38312 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231637AbhDSHsj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Apr 2021 03:48:39 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13J7jTUO019745;
        Mon, 19 Apr 2021 03:47:57 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0b-00128a01.pphosted.com with ESMTP id 37yseccd2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 03:47:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBfz3A2Wd+KCXbcV+ODJNUDGK+TPpigdWDwWP5/yLD6kdrIur7PffoJJin/pnB0U93lZv131yvz2yUg8jY+bRCr96ySnvvf/LZ/Jsx1ZjC1dx9FoktRLIkZv4SO4VxZwM5JBy1afFRagM4yP0FyeBWiW3nJYtHR5MazYUs5axnLgX0Fvl9HXcz9k11jJHBN2P/oR9gKrsveBlGS70UZEZrf5fcIP2ivH5d9l89RoMeMPXnLrOWNifS+I+THZZSmjLkvYnS0hFhmrKmEJjyQD7SG1igHCx2XwCPpINPxYgCmia7rukviTAKcf/Tyqt0KFieStCAS/bcRUKSIxBK72RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhAqgs7Y5vyvw5E5wL6pz4PVstnf0oZ5wtVJ1odUBbs=;
 b=ARAE/1kY1yXmgFRXhT1Dr/9RopkA7FsmMUUygLhwVIZX90chx1nzHsbdFv2xQCflByi57FatTqrJj3oHn4WDwjl+vWpr/9bmRfNJ8HWePzueZpx7/oMaaG0hLj8c6aNwSzuYeBhgwyKa4YiCTBhdg2e+wNGLTqjIoR5ow8I7nUKnk4NBiMro6LhiRkn+fkUTs/pOv9voJxkxDQBiRSwYpd2lNQ1raA4GkcYyRm1kXm/rSVzYLznMI/0dtKMvqqLTgRx0NzgySFAWd1TwU4fyCcuBLUeml54MsXknOGxJVsoYEBlH3noidXh9nOEKVY1WazHBhbJQClOylTc4CPNG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhAqgs7Y5vyvw5E5wL6pz4PVstnf0oZ5wtVJ1odUBbs=;
 b=Yq9q11lPlJOqVHvTJk+1/V+rMx9ef1p8n7SYw5OvlnsjBNavYjjfZ6yaO9zgjyKC8zPpX+3o80xLrc4cbTWP5S1KMk3aHtQRrwt5UXG7/1gY8/Zux7bgRu7JNd3pNgH34GxW98IDrNUb3bstC6eKAHhpZvB9OjBNe7FoCRHmh68=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY4PR03MB2917.namprd03.prod.outlook.com (2603:10b6:903:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 07:47:55 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 07:47:55 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH 4/7] iio: adis16475: re-set max spi transfer
Thread-Topic: [PATCH 4/7] iio: adis16475: re-set max spi transfer
Thread-Index: AQHXMFbUjw8K/uCRQ0qG6XJFfEfrAqqznvwAgAGVJPCAAAgPEIAE3C8AgAFipiA=
Date:   Mon, 19 Apr 2021 07:47:55 +0000
Message-ID: <CY4PR03MB311289981955B0889BE539F499499@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
        <20210413112105.69458-5-nuno.sa@analog.com>
        <CA+U=DsqeiRRGp+Q+yZ7OVOE719aBiyMoBLsFTZL3amGfWHtgkg@mail.gmail.com>
        <CY4PR03MB3112C342E901F4E308D0AFF0994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
        <CY4PR03MB3112BFAA334A280B0E04CB88994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
 <20210418112058.7bb04fa6@jic23-huawei>
In-Reply-To: <20210418112058.7bb04fa6@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctOGJiZDk3MDktYTBlMy0xMWViLThiM2MtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDhiYmQ5NzBhLWEwZTMtMTFlYi04YjNjLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iNTI5NiIgdD0iMTMyNjMyOTIwNz?=
 =?iso-8859-1?Q?M4NzQyMjA0IiBoPSIyclJIdHBHR0ppaUZWMkRRNjJEcEl6NjdpUDA9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUM4dnlkTzhEVFhBVzRCZmJrZ3drWDFiZ0Y5dVNEQ1JmVUZBQUFB?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:25ab:ca01:b4b4:5ede:e2f0:4573]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b713613-8b67-4e2f-4ede-08d9030771b7
x-ms-traffictypediagnostic: CY4PR03MB2917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB29173C436976037A2E9E014B99499@CY4PR03MB2917.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FYL2orXkFxA8jVCYr4+2QdJO35L7AWiqFGcA8n/QeSYnqhWCNmgp9qcHfetEHl+OB8ygJjQiayxXrtulZwi2gRGJZA+MuWG8vzYIJZAx0kqRY8VsD/CtjHjaV571L+JHFgYzJW87khjeOnySInkMoTzqLbzxHWX6Ga9uF4sSmkhhOvh3JC9Wzb0jPA3oxbImdY8Xf8dI9omP91+oSd0+kLIBa6PQ4gfXkkSlTyGwneisscvwNXJMwcqylSQ33QgDhzlL2S5z0GakN6TLY4/kuQ9A8OJhEGv5LxCGhckM4ZKkErJ+z2CSucOob/Eb5ZO7hbtmQuXVyUH75Qzlrw8WgATTLKYKuCReqJwCNllPnLoujeFQEF6YyKjb40/GnyyX3FTZ2HhuINVGR9CmH+35+qUzog7TO1m5LBvrDgylR33LnLmOyFX00/SjzpizCBD37GsBHS2RQABHM5H36fJPXj/C88Cg/KsGRkibndK0OHyv0PN1PlWr3yqn8c8YrctLpJgSBgxMQ1ddU3fRPuCIzEui0w8B/SiaQ0aIry1PGVLbHb/DnnPs+J9XI425tZI7ZpFnmNEazx/w6kittR/1LhYprLxwFSH6Bc1jwkzzNW+6/fuh0RDkweePrITR8cdnvQrLunNQDNAt0UjGzYFI0KVrx+x2bVGXqp1wuVV27jBUOYq4oLexV93sqDgLjStg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(66476007)(64756008)(66446008)(66556008)(6506007)(6916009)(53546011)(8676002)(478600001)(38100700002)(2906002)(76116006)(66946007)(186003)(86362001)(122000001)(7696005)(83380400001)(5660300002)(33656002)(4326008)(52536014)(71200400001)(54906003)(55016002)(966005)(316002)(8936002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?jQGI3FCKGzchI0bqaRWPgHYl1vN9UJgX5F+7Jj1yzix3UTYuW8vRvSXa4E?=
 =?iso-8859-1?Q?DXLUbKSX6Cbt/hu4g1aLsRJDUM8+0V28yD92q5S0cKuQoYvGM6N53TFx2o?=
 =?iso-8859-1?Q?gaIlVw0AuJtVMs/RI15JVLdzBkNhHedl0JP+l42M/hpbI+uMjid+xxZjo+?=
 =?iso-8859-1?Q?sqCZUoWWv6KPLPCwQXN+YYcShxigrcKfeJTZi930gDICpsgffDCO6dODwN?=
 =?iso-8859-1?Q?FvpokSDSBuSNRFHZYxe4pjLIryX2Eda/0EBXpvEhOMuvzFXddeFV3/jLno?=
 =?iso-8859-1?Q?AXP2FnmfbGaAFtbma2KjBJokaVy311LrnAUqpryygCAfD7FYS5bCluUulz?=
 =?iso-8859-1?Q?Bl6O+Y6oCz85W6ZXXv1VSGiLTSFxEvb9+JeVkyGsH2LJju+XcxwJNzh2AV?=
 =?iso-8859-1?Q?+kwd3cDaNWLp1e8fl5ankjBZMORNd9/+B5xFrVQI6M7yX9lN4GRHP2KjJU?=
 =?iso-8859-1?Q?bGE4A1QkiFNJsIncekSgHyj4OWu0yTyFc1U0iBjGCJD7JseJXYunrxGZFs?=
 =?iso-8859-1?Q?wzyyubUGlEMd2ynYh6ZYshvoqizvvuA2nT6f5GtBAs88M8/ro8mfEeCuX5?=
 =?iso-8859-1?Q?PRPuxaxxo21D2uKPc58qX8dIDtslyU93AsVgMzWIJtIaZpVwwd8DFzZs1n?=
 =?iso-8859-1?Q?Khp9B0AihSvD1wWUyVEjTcRapUBk9IzyoxIZtUQj1/ggKG7C5Woo0dsddf?=
 =?iso-8859-1?Q?xjtoF+u8fRsyxpz6KkH3JOWWw59VYdzOmkvEnT4Z344usNfnCGV8HlR4lK?=
 =?iso-8859-1?Q?UFzgW7eZj2MQ+5VlaDlQxvmlSMlg2mF4WktKhCpr5F2vtMIgEthasBs/KU?=
 =?iso-8859-1?Q?690h6iY5pYm+vIPViRazaPbG+QMcTwziWnuAWUFW3ynqqu0M18UmTbET+8?=
 =?iso-8859-1?Q?nrDe0U99EpXpQYDk5YFX3hYsoglmLYobflJAKQ+YvbnwVYNnClJLDG4us6?=
 =?iso-8859-1?Q?d7154bgTUy7U/9xTtjs6/rOIwywYDzJA6BWQKS/pkCdCZobV2PEYH7Y6nA?=
 =?iso-8859-1?Q?T1rwBBkoWAbnZOdJTVLLsm106VSy+m9EGctsqpu2wpGTU0dtCSpnWaeTOl?=
 =?iso-8859-1?Q?PSxuWFvlQfkVAsHBxt3+UrdAKKZhpKfAnMXsF100KGoFeZfOa2UyxBIW0W?=
 =?iso-8859-1?Q?G4rjQYVoRWlG1zH1QzaXVYwvXmbTzRjmbHDQV+LVUMUW+D+AafO0dRJolm?=
 =?iso-8859-1?Q?AsUiyHWAZsktsnKdOlKegP9qWV7a1PTevxiOMhgWecffebzqBKvhXGLS0S?=
 =?iso-8859-1?Q?7ZbDoXYFc9m6IfgnENHK0yo6VV9GLkHwfT4pRif8N/aFz/yv4oaonohsbB?=
 =?iso-8859-1?Q?RFg5989bMRmHw+ub7ZKRZyYqMiAqK70Nb5YboGE2+d2HjvqM2L9mhRTnXP?=
 =?iso-8859-1?Q?6BoSEnPyBXgrS/u/s9aokl7xUYzbxpfab5jt0CQfeo2NDuMK+ujPXQtxY1?=
 =?iso-8859-1?Q?DlO7mFnBPtA0N0Y5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b713613-8b67-4e2f-4ede-08d9030771b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:47:55.5879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZabbA5xDspaN+/XkpFieKLyZWj3iXgE4KzoOZfs/6RyM70P7wr3nwNe+iFQU8T5oEo+EBFYiIacT9uWO2AZqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2917
X-Proofpoint-ORIG-GUID: RRYcJ7jbM7jMWnu016C-cZyrWJb5YbM0
X-Proofpoint-GUID: RRYcJ7jbM7jMWnu016C-cZyrWJb5YbM0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_02:2021-04-16,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, April 18, 2021 12:21 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>; linux-iio <linux-
> iio@vger.kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>
> Subject: Re: [PATCH 4/7] iio: adis16475: re-set max spi transfer
>=20
> [External]
>=20
> On Thu, 15 Apr 2021 08:16:30 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Sa, Nuno <Nuno.Sa@analog.com>
> > > Sent: Thursday, April 15, 2021 9:54 AM
> > > To: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > > <jic23@kernel.org>; Hennerich, Michael
> > > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > > <lars@metafoo.de>
> > > Subject: RE: [PATCH 4/7] iio: adis16475: re-set max spi transfer
> > >
> > > [External]
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > > Sent: Wednesday, April 14, 2021 9:29 AM
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > > > <jic23@kernel.org>; Hennerich, Michael
> > > > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > > > <lars@metafoo.de>
> > > > Subject: Re: [PATCH 4/7] iio: adis16475: re-set max spi transfer
> > > >
> > > > [External]
> > > >
> > > > On Tue, Apr 13, 2021 at 5:45 PM Nuno Sa <nuno.sa@analog.com>
> > > > wrote:
> > > > >
> > > > > In case 'spi_sync()' fails, we would be left with a max spi
> transfer
> > > > > which is not the one the user expects it to be. Hence, we need
> to
> > > re-
> > > > set
> > > > > it also in this error path.
> > > > >
> > > > > Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
> > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > ---
> > > > >  drivers/iio/imu/adis16475.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/iio/imu/adis16475.c
> > > b/drivers/iio/imu/adis16475.c
> > > > > index 51b76444db0b..9dca7e506200 100644
> > > > > --- a/drivers/iio/imu/adis16475.c
> > > > > +++ b/drivers/iio/imu/adis16475.c
> > > > > @@ -1067,8 +1067,10 @@ static irqreturn_t
> > > > adis16475_trigger_handler(int irq, void *p)
> > > > >         adis->spi->max_speed_hz =3D
> ADIS16475_BURST_MAX_SPEED;
> > > > >
> > > > >         ret =3D spi_sync(adis->spi, &adis->msg);
> > > >
> > > > Purely stylistic here.
> > > > But, the restore from the cached variable could be done here in a
> > > > single line.
> > > > So. just moving [1] here.
> > >
> > > You mean also doing it in the label? I thought about that and the
> > > reason
> > > why I didn't is that on a normal run, I want to reset the max freq as
> > > soon
> > > as possible so that if someone concurrently tries to read 'direct
> mode'
> > > attrs
> > > gets the max freq. This was my reasoning but I admit that it's not
> that
> > > important so I will leave this to Jonathan's preference...
> > >
> > > Hmm now that I spoke about the concurrently access to IIO attr
> and
> > > being paranoid about
> > > the compiler, I wonder if we should not use
> > > WRITE_ONCE(adis->spi->max_speed_hz,
> > > ADIS16475_BURST_MAX_SPEED)...
> >
> > Hmmm, actually WRITE_ONCE would not be any help since the spi
> core
> > does not use READ_ONCE. So, if we are going to be paranoid about
> the
> > compiler and load/store tearing, I guess the only safe way here is to
> > acquire the adis lock [btw, I'm a bit paranoid with this stuff :)]...
> >
> > Anyways, arguably the likelihood for this to happen is really, really
> small...
>=20
> Really small, but needs fixing.  We shouldn't have a window in which
> this

Agreed!

> can happen.  So either we need to stop those attributes from reading
> whilst
> we are in buffered mode (via claim_direct_mode pattern) or we need
> to put
> a lock around this.  As an alternative, could we use the speed_hz field
> in appropriate spi_transfer structures to tweak in this path without
> affecting others?  That should make this concurrency problem an issue
> for the spi core (which I'd assume handles this).

Hmm, I like the 'speed_hz' approach as there's no reason to grab
the lock because of a spi core tweak. As you said, with this, we push thing=
s
to spi core. Going one step further, I think the most appropriate thing to =
do
is actually come up with a new member in the 'adis_data' struct
(like burst_max_speed_hz) and tweak the burst mode transfers accordingly in
'adis_update_scan_mode_burst()' (as there's no need to set this on every
burst sample)...

If we are going the above path, what would be your preference? To add the
patches to this series? Or to just fix this patch and [1] and push another =
series
with the above changes? Hmm, since [1] would also depend on this, I guess t=
he
later approach would be better?

[1]: https://patchwork.kernel.org/project/linux-iio/patch/20210413092815.28=
626-1-nuno.sa@analog.com/

- Nuno S=E1
