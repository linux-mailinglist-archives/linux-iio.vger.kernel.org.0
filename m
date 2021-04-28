Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A636DBBC
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 17:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhD1Ped (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 11:34:33 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16864 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239791AbhD1Pe3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 11:34:29 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFQC4R025028;
        Wed, 28 Apr 2021 11:33:26 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00128a01.pphosted.com with ESMTP id 3865r9pp01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 11:33:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC2quvC6wlQ31n5UrVIS5xQ5y1Ve8ixF5pBAZHjJSEoqeMGCVX7U+mT0o3kgHkF3AEbv4EVqTuzoGIhwIAT7EGvQvV+oVgDcs+rmkg8HwCB8Irv78RU+Vy7uEhjpE2iWgP6CSYk3pI1guXLx6CWJO0JzLst9OYOzEieU96v6QbGoEMo10k/IqoCg8FvdOyD0aJVyzzQnT2lR3zhbAUtTujCCz1qOM1zJfJbR/Hevf7hAvLntg6xBbxUsOl11LCWf+h4nA+cLZvT6mY0U+lieaEmMMA5/rThhn2WVc75gmxATMAwOAi5qINIhTnGbGzyKKEzyjKL8O9ogPqyaxqbmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtGNT4iJrD6OJsYN7eNs03yAt5hH+MP9HmnKJilydxI=;
 b=Uf2qRaCVsa2ikFvBAXUJjQ2LBAkkYI56VdFQ1q+PMurlYcfbTEWX55tGcvfC+tQut7akFaw5Sy8hUpbHcf36ISkopHKUZaPF5uLnXegcC3jiw5zkrNIdsQAi8f3g7RcgdYBOshgzKbYv5JdA2T33bD2ZOZwIhNg7YsqKHSkgiJfww5dephAjDI2jZrcJnjY9nzSMl8MVd1avswsmifBRecfnA7ltUFP2UZPwnmgylcpeFO9ZovlWFft7EHcKR/EKE/a8VZnTyHgPyH6v7KK9MpfZqu1eONwQh3By9+3uQI7X1jRxGFO1MmT7w6ZLG5OAM0XDIlWhiiKgRumBemFcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtGNT4iJrD6OJsYN7eNs03yAt5hH+MP9HmnKJilydxI=;
 b=Y+9d8tlW42ac3A+TMuFowQD+3wSGAp1j+AsK8MKP4ry9gt8FCSdAWwQFMjDKUki26t04jBhTu9+Hki90Vg8y5hEodijka1rrqfi5Mgo8rUcXuNMxCla6mKvJ+C0IK0gKnt1CdJJ8DfKaSPOfFB/Y7gstNSD140ZVUReWmmqNfwg=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY1PR03MB2410.namprd03.prod.outlook.com (2a01:111:e400:c617::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:33:23 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:33:22 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
Thread-Topic: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
Thread-Index: AQHXPEBt7lP4jf8Fa0q9Q53QuBs0oarKDhSAgAAAjtA=
Date:   Wed, 28 Apr 2021 15:33:21 +0000
Message-ID: <CY4PR03MB311245DA10E715A44DDC10C099409@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210428150815.136150-1-paul@crapouillou.net>
 <CY4PR03MB3112198E9789BF3D95959E6F99409@CY4PR03MB3112.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB3112198E9789BF3D95959E6F99409@CY4PR03MB3112.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMGVkZDQxYzctYTgzNy0xMWViLThiNDMtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDBlZGQ0MWM5LWE4MzctMTFlYi04YjQzLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTIwNyIgdD0iMTMyNjQwOTc2MD?=
 =?iso-8859-1?Q?AxMTg0NTkwIiBoPSJTU2M2SWxiUGpYTldad1lQckM1b3ZuVDlFODA9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUJPTXpiUlF6elhBVGltOFpEL25kZjJPS2J4a1ArZDEvWUZBQUFB?=
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
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:25a4:df01:5c98:212a:483b:818e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d44196f-c105-47b4-1166-08d90a5af4ce
x-ms-traffictypediagnostic: CY1PR03MB2410:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR03MB24106B361C0CDFAE3CE78FCF99409@CY1PR03MB2410.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OoyNtAGwXm5mD8vXPHOSZc53n1QYpyYw5Zb0EIirVMhVcUqqOnaDc1nxfUyuf/Xo758uSxz4L6kdAu0qiSJeLuZuImzc+FSR+SAd0TAUgLpo+uuhZMlrW7QHpQHPSbt+a35GxZtBEyapPlbCHlhxjd5b11NDfwzCF6nWVwuTiI2yfDQQWpHOnkGlE2yakw2nROUFYTx5L7CfAaIC8gfsDfNR2nAMVAYwsv3Otkv4dzGf1l7BNW/7MG+nzp7VvLvRyeRAfLgcpKyH1PjoH7sSoWOkKzCOJER/Zs0vbpi6jRCP1xHumyB8YDyBaMfsr8a9gld+OkFGsh2AkWMLgJEZ9V5DBbX99ESY3tFYvkUBB2kmR38hNXEgWKJs8NKqWHwstlDYpSjCpwLmIe04lypkhVy/NZsubJbZHiqlnOG0HhdNPonEk4hSB57kwGqpHjDbYXmf3tx+WkjVe9wDWLWglak/BgriwiBOIkwPCrYhVTfLmsie4glDfNiEXH/Lw39KfBnNmLZLZm3diE2A3HFoEId6uAg6CdbproHbvYUI+nLwz7i/2ke8E+N8WDvNNVyJermPOZLmxZ9494F4/C2mYFwMHtDHxpY1IIxj5/erMXc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(64756008)(2906002)(6506007)(53546011)(478600001)(9686003)(66446008)(8676002)(186003)(66476007)(55016002)(71200400001)(316002)(4326008)(33656002)(7696005)(122000001)(2940100002)(5660300002)(38100700002)(54906003)(4744005)(86362001)(110136005)(76116006)(66946007)(52536014)(8936002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?5UgqzwEveF07kuZeDVBmaKn1QjyZ4JBJ55fG0jeoeql8YtzSDg7OioidlM?=
 =?iso-8859-1?Q?cRy1m6HctPcwH75TLixbkPf6BOMDehS1H9sQuDY2u7Z9EzNBHnp2oacgOV?=
 =?iso-8859-1?Q?ydcsbSTyOC8dMJSYvZsb06LDK2rhGdenicShiPhyyU2dZsvIxzrQ/J2wjX?=
 =?iso-8859-1?Q?eH3xrrKv6jGoDEdBk0WAUb1vR+c2/47FONNm+EAGUWo3Q0p5V4OQgasO1s?=
 =?iso-8859-1?Q?Zxm/o2EO4beH+PWFpQDwpNwcVjUb9/awYxVzt8sfxqOEjNe1IOTjd8AfMF?=
 =?iso-8859-1?Q?oE/bcTjEhI3EcMdvgMHAKLn2hi/dANBsjCGyJlBAxGuFH0UclkKiFRVR2g?=
 =?iso-8859-1?Q?cfbNMo2RpZcvVMlIAFrQ+X+fh9ToHgK+pdBkWTShPyApAcbRNkz+dw2EDA?=
 =?iso-8859-1?Q?ExRuWAfIim/nmGB1cH6t2qEg8UswSu0n+/FrfkwyP10HOHENrZehjpf6xW?=
 =?iso-8859-1?Q?0kjTXs7O4nb+pMIk/OrperhPXqDmf1oMupaoS7Iyv63hfy+5YCPgQEy9Bf?=
 =?iso-8859-1?Q?z2gNuJ0ZQZhraGFyoz+lmBDGWzKClpxuMiKYqxEX1li5bBU1zElY+8hbj/?=
 =?iso-8859-1?Q?l49XIEmRyqqQ9sx75hxPxQC5VkWn7ViDFwyRz9vr7T1zkDR8Fg0QDARrpp?=
 =?iso-8859-1?Q?K0cS22O28bVujSjdA++1bZbSIBa8lWiRNthfgddMnM36NaWCuoDVvqnIf2?=
 =?iso-8859-1?Q?3AUpqtosf4RTf0Y1HjuXtz6S+wSpAReJsGY2huyYHP11DLNYmp35KF5+Sy?=
 =?iso-8859-1?Q?V/RYyxvWJziPvcaoyHpTFIRvyolOIV/OVmj8UrYzIXAao0BEL7G0ttwUGW?=
 =?iso-8859-1?Q?EjtsVfeoTUnB6Jsb+QwLuGM72KeACLTCeuR1Y73xRZXI6whPFsYZPIV2OV?=
 =?iso-8859-1?Q?8fi1RrjEti9/9+F9lneMwz8RmxueOehvwp1lpYrwO2NIDjSD23WREQzleC?=
 =?iso-8859-1?Q?CMXej2qps5STwp/jm7mTlWDofUNW6yCVynsMN0fG6USrUHRzF1TduWG5Ou?=
 =?iso-8859-1?Q?7IpAYeT6+l8DIQuTnJzjBCOouGrgBuxbbVJHb3/IRs1j6GzLpzlY3TfmQC?=
 =?iso-8859-1?Q?X8BjInlko2dmlCjQPf6CufDCHnsnTRkUmR7EsHXzmimYmUzjjcDzZmmE4V?=
 =?iso-8859-1?Q?r99ao9ivyP4dXTDuwyiCf3NLsaXiw13IwGlAhSk8qs4NBIvtiAHttEugPo?=
 =?iso-8859-1?Q?HuiUIqLMN5aUQ6N6ARVquIsin7u/7PMiss3JUNl+iVzS8iz8gAA7sT9CGV?=
 =?iso-8859-1?Q?AP5WcqNNT2NjltIKizwN0cKl818P2Sx+cJtUO+34HpaQ/7X5WWGSxzw9T/?=
 =?iso-8859-1?Q?fPB784gv2nwTcMGYM5k+5J+z4t+lKU+Xf90jLinb6Qfqu2u37bUOtkrrMT?=
 =?iso-8859-1?Q?sVGXbXT79+nDIiyiBVEedHqlERHa+LLG/31rU48mxzFVC1LXS47Z2t9wSZ?=
 =?iso-8859-1?Q?rD29mjCkC11zj3Da?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d44196f-c105-47b4-1166-08d90a5af4ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:33:21.8976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQFEVv59RBo3kk5yzNkPa/mgM0N2mSm/cBA3UCoDDIvICzFDeMfOaV51PMhaes4bca+i4EanHNWKLIszYTjieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2410
X-Proofpoint-ORIG-GUID: _G08ApiLia1j_jj9hfIXc0i7G5HkV2no
X-Proofpoint-GUID: _G08ApiLia1j_jj9hfIXc0i7G5HkV2no
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_09:2021-04-28,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280101
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Sa, Nuno <Nuno.Sa@analog.com>
> Sent: Wednesday, April 28, 2021 5:31 PM
> To: Paul Cercueil <paul@crapouillou.net>; Jonathan Cameron
> <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Peter
> Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
>=20
>=20
> > From: Paul Cercueil <paul@crapouillou.net>
> > Sent: Wednesday, April 28, 2021 5:08 PM
> > To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>; Peter Meerwald-Stadler
> > <pmeerw@pmeerw.net>
> > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Paul
> > Cercueil <paul@crapouillou.net>
> > Subject: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
> >
> >
> > The ioctrl() call will return errno=3DEINVAL if the device does not
> > support the events interface, and not ENODEV.
> >
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20

I guess this should have a Fixes: tag...

- Nuno S=E1
