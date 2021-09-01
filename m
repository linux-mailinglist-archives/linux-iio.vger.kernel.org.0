Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBECC3FD5FD
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 10:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbhIAI4L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 04:56:11 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:2522 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241376AbhIAI4H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 04:56:07 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1818EVuh032613;
        Wed, 1 Sep 2021 04:54:55 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0b-00128a01.pphosted.com with ESMTP id 3asef2xr94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 04:54:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atO46nnnxQS+UBRY/ODfLI2ImqrrrznbOhNP5jd9U5/08lefhfHBQ7qobzjRp+0fbxjpO0vUzwXMm5QjTy4waoGm/GI48+CyHGIpD/4GWuhcdGmLrAGNlzcwjWiVElHkKKD0OO2+jopBVjHPHacZJhCnsZzoIIiKzgBbaEF6ycCuC837JDzCUaZuOLEzVwko2ATsWaGUKeZOPJsbAfaUWUyNlK8N0xTPRiLf8NNWyTG6RjTy46G3n8BRgjX1mTt99bGYnphGwAolpCWbWQB2H2R08b6M2ZmI+aJ14QCgUgCMNbUounv7SU/DQy5+wuDfsEIlc1FKUPGn749jiiXCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCMC2VXgXcOK8G1LJtCKGyKOnj4PCGe2yUbb/lAyyfA=;
 b=DH464eFCIRyCjNxthgWeQbo4AnoXAjPhWkmkini5N+eJQQilrBqIP/rokl4kQGd5J0dUyoi0zloJ4nkPF5yErYKJiHHtjHCaTz+nOqbUu0sCtz3ZRUT9fRzY7HZMyMiwrBW+pwRlWzeKqL/nt3MK0sQ4LsxBmjWIJhvCUVhQcCTbR72B28eu7Gg02xlE7fwsIwI2QXjA37u3oT+1GcMcdgb7Ty3Y41clDtG7XrG+E4h3GoEoPaCNjBtmFnjr33SXvV51xq8+BTe5QZ9SDYdyTmv6RKV5UepA/H+6FAafayC2G0XBGN53cGP6yH0ez0niQN/LA2y0BkWgNKrI8MlkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCMC2VXgXcOK8G1LJtCKGyKOnj4PCGe2yUbb/lAyyfA=;
 b=RAYbD5N7kUso4tmzwqeSvErTqm4SZWU7ofC/P2VTqv1ova3JH8d80Pqz7i5jfXOQqDqMsgy5ZUmrOrejw8hCG0K64XNlC9bJfazCVz2lbkf2RxdPI3QBNYMNGN25jO8OQd+PuUQ19LiNiM8reXo1z2GTGhxSfJzJwggO1JH7FK0=
Received: from MW4PR03MB6363.namprd03.prod.outlook.com (2603:10b6:303:11e::10)
 by CO2PR03MB2213.namprd03.prod.outlook.com (2603:10b6:102:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 08:54:53 +0000
Received: from MW4PR03MB6363.namprd03.prod.outlook.com
 ([fe80::3c5f:4b91:b79f:b1b4]) by MW4PR03MB6363.namprd03.prod.outlook.com
 ([fe80::3c5f:4b91:b79f:b1b4%7]) with mapi id 15.20.4415.023; Wed, 1 Sep 2021
 08:54:53 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Chindris, Mihail" <Mihail.Chindris@analog.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH v4 1/6] iio: Add output buffer support
Thread-Topic: [PATCH v4 1/6] iio: Add output buffer support
Thread-Index: AQHXleT0N2m0zDe7+06uFYH/Sjzz9auMRgmAgAKrF4A=
Date:   Wed, 1 Sep 2021 08:54:52 +0000
Message-ID: <MW4PR03MB636324E990C3ED6BF8D6D94399CD9@MW4PR03MB6363.namprd03.prod.outlook.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
        <20210820165927.4524-2-mihail.chindris@analog.com>
 <20210830170555.25887e82@jic23-huawei>
In-Reply-To: <20210830170555.25887e82@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNDQzNWE3NTAtMGIwMi0xMWVjLThiOGMtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDQ0MzVhNzUyLTBiMDItMTFlYy04YjhjLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iOTY2MCIgdD0iMTMyNzQ5NjAwOT?=
 =?iso-8859-1?Q?E0MDI2Mjg0IiBoPSJBM2VnSExnRmNtNHVkeEpoTVhmZG5FOXhQU1k9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUFzTDQ0R0Q1L1hBWmpiUHd5Vi93MFhtTnMvREpYL0RSY0ZBQUFB?=
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
x-ms-office365-filtering-correlation-id: 45c5e915-afe7-4fc7-a588-08d96d262a11
x-ms-traffictypediagnostic: CO2PR03MB2213:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR03MB2213F6BB3D8B3BFA01F8F9E499CD9@CO2PR03MB2213.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XDnUYLAwJyPzugx6d34YrotmXh3CO9vhEHinmfvbTKjKcnpQVhal4EArR7xpiTN43923N5p2ghj5D021hgRIsye0XZVxXs5dpHyPeIy6Yvh0F8kwBxRLASpmA9ZvlLtEcXgDWjWpqqOUa30UXNAs7nd/Qxs9X65OnET8TkkL+Dh1wRmbhA16mvyBX4MQCTftbWYqgCYDlPcVF2l+EipTG2+WlFzsI8knJ0zAg5X0SCIj0UYMFEGGctKvyLOdtY4Cyh96D+NyAQUModSQMestbcj7dJ6Zvv+ZfBcleB7RyezEICGll7KT0jG/DlDCPSrTwoxqygOXW9D5ZKVpwo0iV+O5axEPCMunhrMpcSPwQUrFTqlTW6IBdzkjXPNQ+DUb8NIQ+uxza3mmwJ64ng1ttPBN0LIhaOdQMVLqNfn0vUobYZAlEBFisG9m+M//ewpk90bFNoBOZdQ9tyZ7P1nEmuc6snAFD829rF2pDd8Yqxwt3Nws3J5bu+E5AIrhiAHF0tIekhjfecyzo9uCK4hebm/6/4AWkWyBlFi+TlqP5ERqarXEhGp1aitL38oqwmkAV1XzRvoVkkyVxZ8qIIabNrSF62YLrEWUQmj6dlWsSCku+hvw2tflISbNi/u3ic5Gyu8/ITBC7FVUpZ5Xgdy8YaStStwmunO+GyjAspMexRpOnxGZnooKtn94uJ6C8B8Ts8UgBcV9z6vnvDQBjSEECQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6363.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(71200400001)(2906002)(8936002)(5660300002)(6636002)(54906003)(478600001)(53546011)(8676002)(110136005)(122000001)(33656002)(4326008)(107886003)(7696005)(52536014)(316002)(6506007)(38100700002)(26005)(186003)(66556008)(66446008)(76116006)(9686003)(83380400001)(64756008)(86362001)(38070700005)(66946007)(66476007)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z8oh5AVLr/bY+lfCHO/mGARTrmPGXApMDvF7QcFk16mujP4DtjTMyVFx/R?=
 =?iso-8859-1?Q?F+gRe8QTE+reY59X4O7kSjMtfL5v/qKGEP3Pgt3KGewKQ9YUWfSr6l88sO?=
 =?iso-8859-1?Q?Whe26e6K/x6YSoohtWa52WQZ2pdIAsqtzhO7qn21jIunuDVzixMu7Oq6oD?=
 =?iso-8859-1?Q?Ub54F8NcIlW3PJZ/ZDgv8lPy9gc9NNRgYv1xHqjs2rDj7wySvO+8spYD02?=
 =?iso-8859-1?Q?8MfZG2ZSAjp5USI2mnwU1ePwLlOqhE1aVc/ef74SzYBLeSE7gcUTv41P6a?=
 =?iso-8859-1?Q?/JCIjfrnhsyA9jLjmsh4ZkV3UEiFgJXn3BJP4cNkMdK6ZMRIA9SSMm3axz?=
 =?iso-8859-1?Q?YtmySdUjMoa3cMm1LcI/tj8Pp91UWOoypE4lBo+P+xiYJSmomT1KtrzZKo?=
 =?iso-8859-1?Q?y9QRQM9Sim+8UQc6VXc0IBV5PU8fhT/Mpn1kpecbtvrruhgY0rAalEdj2p?=
 =?iso-8859-1?Q?62H8/QkIBnRL3OFSx0r2Cjb/9bN/1FXjKbQCgGuJpG+7tXjM4w/RlWB6XR?=
 =?iso-8859-1?Q?r9JQrfDdXvTztF93k3ZufYT1VwfkcCBNaVt/oCbagvBoilpeZH2wtN4pzn?=
 =?iso-8859-1?Q?MdrGGLwOjqL9qApLfdXc2KKkOSh04NKX6Z9g/5efzL79Bs5sLx0XLBj05Z?=
 =?iso-8859-1?Q?2Kbv7y8ztCWV/wlfrK5Af2AN9eD0Ij2ezc+xLE+aPtN+GeiRcZn9fdYNvY?=
 =?iso-8859-1?Q?XLls91kAwpuDeoCE6IWElDp2c+i+zo/7BVIbKS5X3UUQE9jtb2OXYKI7TM?=
 =?iso-8859-1?Q?K1a95CSGtpJI6xg0fKnRBYHCfo+GjmOfnnFSU+YxA+C/UVDJaKZ0K7vccP?=
 =?iso-8859-1?Q?rpjTbuuObaMGGv4TweZ7rKrt1SqjL9kcuY0WSk4DvoFbmtOYRY+ZBK6WQN?=
 =?iso-8859-1?Q?XaVjChJ3mUjAjNlHLQqDX+L5RV8NKclIP93JYFyPmfGJXOoYJK3AV57aQp?=
 =?iso-8859-1?Q?ALco+oCmIs+NENrLOWZPzPbIA3koQZOVKzAYPRcNuzQE1SpbN0oDnDH9Vh?=
 =?iso-8859-1?Q?UX2kz3T8iYdVbYXq6RPiXECgXLcITQ9DCGd9L/P5Dhobqg83hNJb2knunm?=
 =?iso-8859-1?Q?ETAD3IW/dJpBN/WJlHQs2mLi6IO7ngjvq80UyBa9IJzhcK2enPibUo295d?=
 =?iso-8859-1?Q?q9xeud5iEEImUAJoVV+CSASGthTqkFPfw5hNSz9yo83qC0Z/dKDmKTNCev?=
 =?iso-8859-1?Q?nbFZghDQdK/SYZASsfTDg9t3CdQpJRTe0CHOxvE5suPMcA2wvdy8RjQnIp?=
 =?iso-8859-1?Q?WN222kJ03yXRr7HJ4zmEXAAGSO5vKbGvHKRdW5rW/fLBUEcB52L0t4hqFu?=
 =?iso-8859-1?Q?2rmddiQP6AFtjEfFAOZ3AkSf3f6Xdizw666cb3fois16h1twJxL/KpTBAI?=
 =?iso-8859-1?Q?Npj1RRHiTN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6363.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c5e915-afe7-4fc7-a588-08d96d262a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 08:54:52.9927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1vuwilZXXn/2c9rwgHis7hcJY/G9HBG5zIhRBi8/Fzs6Q7rPwy8NlOdcgiKPxrewAtmReyqFMPNoYSlIgNMhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2213
X-Proofpoint-GUID: ps7yww2VaC4RQy0CqkzHER96UjU4oCxV
X-Proofpoint-ORIG-GUID: ps7yww2VaC4RQy0CqkzHER96UjU4oCxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-01_03,2021-08-31_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2109010051
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, August 30, 2021 6:06 PM
> To: Chindris, Mihail <Mihail.Chindris@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> lars@metafoo.de; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; Bogdan, Dragos
> <Dragos.Bogdan@analog.com>; alexandru.ardelean@analog.com
> Subject: Re: [PATCH v4 1/6] iio: Add output buffer support
>=20
> On Fri, 20 Aug 2021 16:59:22 +0000
> Mihail Chindris <mihail.chindris@analog.com> wrote:
>=20
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >
> > Currently IIO only supports buffer mode for capture devices like
> ADCs. Add
> > support for buffered mode for output devices like DACs.
> >
> > The output buffer implementation is analogous to the input buffer
> > implementation. Instead of using read() to get data from the buffer
> write()
> > is used to copy data into the buffer.
> >
> > poll() with POLLOUT will wakeup if there is space available for more
> or
> > equal to the configured watermark of samples.
> >
> > Drivers can remove data from a buffer using
> iio_buffer_remove_sample(), the
> > function can e.g. called from a trigger handler to write the data to
> > hardware.
> >
> > A buffer can only be either a output buffer or an input, but not both.
> So,
> > for a device that has an ADC and DAC path, this will mean 2 IIO
> buffers
> > (one for each direction).
> >
> > The direction of the buffer is decided by the new direction field of
> the
> > iio_buffer struct and should be set after allocating and before
> registering
> > it.
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean
> <alexandru.ardelean@analog.com>
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> Hi Mihial,
>=20
> Welcome to IIO (I don't think I've seen you before?)
>=20
> Given the somewhat odd sign off trail I'd add some comments to the
> description
> (probably not saying that everyone who works on this ends up leaving
> Analog.
> It's not cursed! Really it's not ;)  Lars and I discussed this at least 7=
+
> years
> ago and he lasted ages at Analog after that *evil laugh*
>=20
> I'm not really clear how the concept of a watermark applies here. It
> feels
> like it's getting used for two unrelated things:
> 1) Space in buffer for polling form userspace.  We let userspace know it
> can
>    write more data once the watermark worth of scans is empty.
> 2) Writing to the kfifo.  If a large write is attempted we do smaller
> writes to
>    transfer some of the data into the kfifo which can then drain to the
> hardware.
>    I can sort of see this might be beneficial as it provides batching.
> They are somewhat related but it's not totally clear to me they should
> be the
> same parameter.  Perhaps we need some more docs to explain how
> watermark is
> used for output buffers?
>=20
> As it stands there are some corner cases around this that look ominous
> to me...
> See inline.
>=20
> > ---
> >  drivers/iio/iio_core.h            |   4 +
> >  drivers/iio/industrialio-buffer.c | 133
> +++++++++++++++++++++++++++++-
> >  drivers/iio/industrialio-core.c   |   1 +
> >  include/linux/iio/buffer.h        |   7 ++
> >  include/linux/iio/buffer_impl.h   |  11 +++
> >  5 files changed, 154 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > index 8f4a9b264962..61e318431de9 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file
> *filp,
> >  				 struct poll_table_struct *wait);
> >  ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
> >  				size_t n, loff_t *f_ps);
> > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user
> *buf,
> > +				 size_t n, loff_t *f_ps);
> >
> >  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> >  void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
> >
> >  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)
> >  #define iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> > +#define iio_buffer_write_outer_addr
> (&iio_buffer_write_wrapper)
> >
> >  void iio_disable_all_buffers(struct iio_dev *indio_dev);
> >  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> > @@ -83,6 +86,7 @@ void iio_device_detach_buffers(struct iio_dev
> *indio_dev);
> >
> >  #define iio_buffer_poll_addr NULL
> >  #define iio_buffer_read_outer_addr NULL
> > +#define iio_buffer_write_outer_addr NULL
> >
> >  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev
> *indio_dev)
> >  {
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrial=
io-
> buffer.c
> > index a95cc2da56be..73d4451a0572 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -161,6 +161,69 @@ static ssize_t iio_buffer_read(struct file *filp,
> char __user *buf,
> >  	return ret;
> >  }
> >
> > +static size_t iio_buffer_space_available(struct iio_buffer *buf)
> > +{
> > +	if (buf->access->space_available)
> > +		return buf->access->space_available(buf);
> > +
> > +	return SIZE_MAX;
> > +}
> > +
> > +static ssize_t iio_buffer_write(struct file *filp, const char __user
> *buf,
> > +				size_t n, loff_t *f_ps)
> > +{
> > +	struct iio_dev_buffer_pair *ib =3D filp->private_data;
> > +	struct iio_buffer *rb =3D ib->buffer;
> > +	struct iio_dev *indio_dev =3D ib->indio_dev;
> > +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > +	size_t datum_size;
> > +	size_t to_wait;
> > +	int ret;
> > +
> > +	if (!rb || !rb->access->write)
> > +		return -EINVAL;
> > +
> > +	datum_size =3D rb->bytes_per_datum;
> > +
> > +	/*
> > +	 * If datum_size is 0 there will never be anything to read from
> the
> > +	 * buffer, so signal end of file now.
> > +	 */
> > +	if (!datum_size)
> > +		return 0;
> > +
> > +	if (filp->f_flags & O_NONBLOCK)
> > +		to_wait =3D 0;
> > +	else
> > +		to_wait =3D min_t(size_t, n / datum_size, rb-
> >watermark);
>=20
> Why is the watermark relevant here?  We need enough space for the
> data
> as written whatever the watermark is set to.
> Been a while since I looked at equivalent write path, but I think there
> we are interested in ensuring a hwfifo flushes out.  I'm don't think
> the same concept exists in this direction.
>=20
> > +
> > +	add_wait_queue(&rb->pollq, &wait);
> > +	do {
> > +		if (!indio_dev->info) {
> > +			ret =3D -ENODEV;
> > +			break;
> > +		}
> > +
> > +		if (iio_buffer_space_available(rb) < to_wait) {
> > +			if (signal_pending(current)) {
> > +				ret =3D -ERESTARTSYS;
> > +				break;
> > +			}
> > +
> > +			wait_woken(&wait, TASK_INTERRUPTIBLE,
> > +				   MAX_SCHEDULE_TIMEOUT);
> > +			continue;
> > +		}
> > +
> > +		ret =3D rb->access->write(rb, n, buf);
> > +		if (ret =3D=3D 0 && (filp->f_flags & O_NONBLOCK))
> > +			ret =3D -EAGAIN;
>=20
> Do we need to advance the buf pointer here and reduce n?  We may
> have written
> some but not all the data.
>=20
> > +	} while (ret =3D=3D 0);
> > +	remove_wait_queue(&rb->pollq, &wait);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * iio_buffer_poll() - poll the buffer to find out if it has data
> >   * @filp:	File structure pointer for device access
> > @@ -181,8 +244,18 @@ static __poll_t iio_buffer_poll(struct file
> *filp,
> >  		return 0;
> >
> >  	poll_wait(filp, &rb->pollq, wait);
> > -	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > -		return EPOLLIN | EPOLLRDNORM;
> > +
> > +	switch (rb->direction) {
> > +	case IIO_BUFFER_DIRECTION_IN:
> > +		if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > +			return EPOLLIN | EPOLLRDNORM;
> > +		break;
> > +	case IIO_BUFFER_DIRECTION_OUT:
> > +		if (iio_buffer_space_available(rb) >=3D rb->watermark)
>=20
> That's interesting.  We should probably make sure we update docs to
> make
> it clear that it has a different meaning for output buffers.  Guess that
> might be later in this set though.
>=20
> > +			return EPOLLOUT | EPOLLWRNORM;
> > +		break;
> > +	}
> > +
> >  	return 0;
> >  }
> >
> > @@ -199,6 +272,19 @@ ssize_t iio_buffer_read_wrapper(struct file
> *filp, char __user *buf,
> >  	return iio_buffer_read(filp, buf, n, f_ps);
> >  }
> >
> > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user
> *buf,
> > +				 size_t n, loff_t *f_ps)
> > +{
> > +	struct iio_dev_buffer_pair *ib =3D filp->private_data;
> > +	struct iio_buffer *rb =3D ib->buffer;
> > +
> > +	/* check if buffer was opened through new API */
>=20
> This is new.  We don't need to support the old API.  If we can make
> sure
> it never appears in the old API at all that would be great.
>=20
> > +	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
> > +		return -EBUSY;
> > +
> > +	return iio_buffer_write(filp, buf, n, f_ps);
> > +}
> > +
> >  __poll_t iio_buffer_poll_wrapper(struct file *filp,
> >  				 struct poll_table_struct *wait)
> >  {
> > @@ -231,6 +317,15 @@ void iio_buffer_wakeup_poll(struct iio_dev
> *indio_dev)
> >  	}
> >  }
> >
> > +int iio_buffer_remove_sample(struct iio_buffer *buffer, u8 *data)
>=20
> sample or scan?  Sample would be a single value for a single channel,
> scan would be updates for all channels that are enabled.

Maybe iio_pop_from_buffer()? To be consistent with iio_push_to_buffer()...

- Nuno S=E1
