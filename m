Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327933BE82E
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 14:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhGGMtP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jul 2021 08:49:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:11814 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231383AbhGGMtO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jul 2021 08:49:14 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167CEhxI005793;
        Wed, 7 Jul 2021 08:32:38 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0b-00128a01.pphosted.com with ESMTP id 39masxe2hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 08:32:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PivWIIgn1POMj5cTgPjH10pakbekxTAuDJ99iyIBk+sxyWDps76F2OBDx3iZIzqy1HOHlYYCVjX0uhF1Iz8t7ETuXyV0lGtKBCtuK98p5Qz+D85hDq+dz11o6gc4m8m4hFMOeNqj1zYvBXTHpgXfLxkV4GvL911QFzqcTRqVwTLLJtHukhoksB4ReoolRWtEg+fk11BHSHz4nAkvSELvB691xLMZFyTsz0HpPq1g4ir3QnnMUjlzMMv4CH5AWW5AQWoooHbUEDUTlTeU4ON+O5aCZ43PLSDCSzeZyBcBHm8K4NvLKd4px9c76Vv9LqZHSAEksOy3JCb78ny85jb7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKgRjKShYP2vZK+dnbnaUzyeDQo3CDySPwYlJNnMWLo=;
 b=nzTsM/LaTf6unuzTN0kLOzNiZY13iIMdRI93u+na6xs+rIzFcSTTG9/qqyenFlhNEAbNw8m0qvwWsH5/A6i72hrSNEhz1yWB2EqU8NSxFM6QYqgMEosI6IIwH6F1HjH/FrbHrfDmhL41wU8uxTF5is8YZN6HuVxW8PtJf/E6iYzgIGfBXJG+IjcpJDz8rwgAxet/+yPBKaXyPRQgyJ8HMpzkdYa3sCAk6stu4oq7iO4sRhqsh9x9WI1ksa5jCbgPs/RSJqz/FjBiOMkLj6Uy4Lf6DmTQh0apv6z4y2J/JP1zKL5S1Cg5cCGcRqpDvXZTSap1Bg7t8Ld7AVQCo9/r0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKgRjKShYP2vZK+dnbnaUzyeDQo3CDySPwYlJNnMWLo=;
 b=lYB8SndSUnSod5yPEHy3DEx7YvUGGf11JdyWc79RrcbfPfMj8nEwK1UYK5PNokuT8o8nWpbR7k7uMsMed58ffbVAhEqQ0PTVJ7OOikdXyP0RTH/92DUuQBjhJMMmRqP5y/MoxGvlspfr20OO14Zz9l6qSun6na9n8k2TAhCt8j8=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5943.namprd03.prod.outlook.com (2603:10b6:510:30::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 12:32:37 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Wed, 7 Jul 2021
 12:32:37 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Hannu Hartikainen <hannu@hrtk.in>,
        =?iso-8859-1?Q?Antti_Ker=E4nen?= <detegr@rbx.email>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: RE: [RESEND PATCH] iio: adis: set GPIO reset pin direction
Thread-Topic: [RESEND PATCH] iio: adis: set GPIO reset pin direction
Thread-Index: AQHXcklvdTRDzb/7JkGBcbv7kuO7Zas3MR5QgAA3tQCAAAcwgA==
Date:   Wed, 7 Jul 2021 12:32:36 +0000
Message-ID: <PH0PR03MB6366378FECFFB05F37B24EFC991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210706092922.v555jjvxbyv52ifw@haukka.localdomain>
        <PH0PR03MB63661EDEE130924514602A84991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <60e595b9.1c69fb81.5284.9247@mx.google.com>
In-Reply-To: <60e595b9.1c69fb81.5284.9247@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNjc3ZTA2MTAtZGYxZi0xMWViLThiNmYtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDY3N2UwNjExLWRmMWYtMTFlYi04YjZmLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMjkwNyIgdD0iMTMyNzAxMzQ3NT?=
 =?iso-8859-1?Q?Q5NTM0NDkwIiBoPSIxMnY5ZHBLSHlCdU5JQ25qYkJNRTZvTlJDN1U9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUFhMmVjcExIUFhBZC9KSDRrdVNuVXkzOGtmaVM1S2RUSUZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQUJPWUdjZ0FBQUFBQUFBQUFBQUFBQUo0?=
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
authentication-results: hrtk.in; dkim=none (message not signed)
 header.d=none;hrtk.in; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09f058c4-39bc-486d-09f6-08d941434da8
x-ms-traffictypediagnostic: PH0PR03MB5943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB59432BEECAC3BDB4F6C1745C991A9@PH0PR03MB5943.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D4ljp8WcWeP7mAHSDtsPj7iObSw5LOIR3Y2u5qD+l+2O4H8Pv3wBGVO3yWdUHU6CS5uXh7EpFBjFrLsvHtmGteO7VVGKYC0ogQJf0FMUz7cLpRShVsd7vy8EVZ3y0+yBD2/kqGxQLycERDGc7EX9SBotlUEIkxghkKKilK23v8MaG7tsvCTyp8OYLwiVs1Db7975rgbrJbtp2hWAz6yLb/OXpWC327Qp+CZoa0/t3eGmGdN80pIcjwLd0dW+xk7gsPhNjz2RFPyZWOHskAcR4HJwrH9dvkVPkaxBl8d5aI0f9vXPxRUMj7q7IkMaJWBUMRPqGCwvEGmRqQ7fGmzYlLgJbLxZYadHzqMn0FxrF/Zj5ZmvsjPXeCPXLVU4mH85sF71ChBvBYzvCLSRJoBvDIZUuvNWRLTrnPO5/HhZ0M6lJq/i6o+Xfm1XthTUBG+1nZg4i+cRWzziuOPDg/yZXkwQM4TOLEvXtW+r3d8r9evC7LxL7NwlZ4YnwMIYt4fYFp3B+E5GBNSvc3I86wIS0tUglO/nxrhNB1cnc6BQvnkny97DxgYcDXCX7FrnSkHpjn6PRK5n5IZ1FGKP3elhI/bptm2E6pxWkEE4J+YBsN1BPdTZs9ANzDmr79XIkhvtzdrBBbNGZwpnqVJxnD906Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(66446008)(38100700002)(86362001)(2906002)(83380400001)(8936002)(9686003)(76116006)(71200400001)(66946007)(5660300002)(55016002)(122000001)(53546011)(8676002)(186003)(7696005)(66574015)(64756008)(6506007)(66556008)(54906003)(316002)(52536014)(478600001)(4326008)(33656002)(66476007)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZpD0c9I+Ur6GeyVOvjyhczGMDqWqTvZXUgJWD/PPtO8ijRn1IS9zNuqb2T?=
 =?iso-8859-1?Q?Lxo8YSiNCQ+v6fz/3O5ockZAyQDlzqTKvnsyEFH1dYslGMLC4sGVlqm3/R?=
 =?iso-8859-1?Q?SpQOpZb4ChJJb43mmgajzq4cyTo8j4jg9i5Fqbg+vwFkQwcAz6QljKJ0Ja?=
 =?iso-8859-1?Q?OoDEF1xr75KaLYyXN7+ET3MJ2MzGkQChThvHOJyzHhu1+upU7CrjiUHMde?=
 =?iso-8859-1?Q?1bKXtMMNqTBCVPQU4t+F7adncvvSxMs9sAjnK0jqN9ZdZq382csLkCcqDk?=
 =?iso-8859-1?Q?sVjKSN7CT5PbwaPFCjoxRwLM+QsEGcU5iEtYt9XDX30HHol2ZHb50wD6YZ?=
 =?iso-8859-1?Q?ns6kSCU9349AGCD7zV2RK9zW2bZxq+zDAQwaxkyiweBWAL02imuat+Qw+o?=
 =?iso-8859-1?Q?XQyPg6ycyikGyV1ewHAmMqaemam7Msfo3fr0bBcSdxt20eRJWFdyuUMXkb?=
 =?iso-8859-1?Q?0i2i2nAPZHrIcPhIPo5Dm3qYoR8OyElWYPSsXVs1LmaxxyhohqG3zcA65P?=
 =?iso-8859-1?Q?ZCtHs8/7vIKg25cvyzRAmgMjKSWMy56RMBH5Gte6kz6IDyqD2SBNOz4YoU?=
 =?iso-8859-1?Q?12XSPlTuW2m9l0nax6xEXBIWUqZwMmYTz9MHllawPfJqoV/Yphhh+EkiJI?=
 =?iso-8859-1?Q?jVhdTxcLfVH/c4Ik3vNe+AZNz5MXnckyBKVUEAOHFHDDyNDM3T+QOaDdF8?=
 =?iso-8859-1?Q?8XSXEXHT1hLLOWx6GYd9d8pWG1lIxYDc0z+R0lPVYZzwS3VCHgsoAn7g/n?=
 =?iso-8859-1?Q?rOKJ/i34iuybg3TGt/yCqxmBJrufa0G+a9K+uyePkeJskWpTgYH+WcEucM?=
 =?iso-8859-1?Q?r16lpKRUvXE3HgK/WYWA0duX9o/Wnlly0XkIu2EaAAwy6R4wxhS2oCGYxj?=
 =?iso-8859-1?Q?z6HY9WC1CEmbd1vmr1Cgp11dcz/6oulFxvvyFfuIIJnmOrmwsRiwfwEcY0?=
 =?iso-8859-1?Q?Vbgqp8KMK7vDup7WBpDZqSoNBZOl4MlVQwxN9pFe8LdugLGRBlY+5We48k?=
 =?iso-8859-1?Q?fHBAzpadAJ3LIqwpG2fIa16clehGseqcuUJE3DVEAJqobbjCOOCzvB/wJs?=
 =?iso-8859-1?Q?okMnyLT608mtqu+JZud/s5eXqLcpHmc5Cf5SPvuh5ppGB/fLiND3+rfiTk?=
 =?iso-8859-1?Q?IV9yyJasOpOQzs9pY/gYO9JG9whSayYHtQpGCTXw8OrQDJ6bRdEIC+yMW7?=
 =?iso-8859-1?Q?yodmKSPVOfSw5yxCx9H/3tnKMyb/tlyEykszL7ObK/wQww9ZNpMareY8R6?=
 =?iso-8859-1?Q?ljEDTf9ZHcLTpVs8qcINwnrwQig/lZmr8pzGLMA6eTFR8foNeuXY79RDJc?=
 =?iso-8859-1?Q?8AeK2VYvzq0z25akHPua0avQ5Q0vsppU/7QWLjdiMj9rsw5ffjj0b3ZaZP?=
 =?iso-8859-1?Q?bpBcWKppJ90dYUyQ9pXg0i92T8g0PfGBcWyFV7O1T2sh1H5OwtnNYFhRug?=
 =?iso-8859-1?Q?N77C5QXarzCMvPxe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f058c4-39bc-486d-09f6-08d941434da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 12:32:36.9744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atDWUWi0vOvnGIeAwDoS47bf/SkQXjhebst21zgr4K/+X3XEnLhCSs7+wlto3orqhhtyCPCi9tnzpRRIZGUFJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5943
X-Proofpoint-GUID: lb8jOO6H6wvmf5twE9IEEwaGH7VPT8_T
X-Proofpoint-ORIG-GUID: lb8jOO6H6wvmf5twE9IEEwaGH7VPT8_T
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_06:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070075
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

> From: Hannu Hartikainen <hannu@hrtk.in>
> Sent: Wednesday, July 7, 2021 1:53 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>; Antti Ker=E4nen
> <detegr@rbx.email>; linux-iio@vger.kernel.org
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>
> Subject: RE: [RESEND PATCH] iio: adis: set GPIO reset pin direction
>=20
> Hi!
>=20
> Thanks for reviewing the patch. I'll also chime in. We were working on
> an ADIS device together with Antti so I've read some of the relevant
> code, documentation and datasheets.
>=20
> On Wed, 7 Jul 2021 08:36:47 +0000, "Sa, Nuno"
> <Nuno.Sa@analog.com> wrote:
> > Thanks for the patch. Forcing the device reset was intentional
> > (thus the GPIO_ASIS). But what Lars is suggesting is a good idea
> > and a neat improvement here.
>=20
> I don't understand what you mean. The GPIO consumer
> documentation[0]
> states that if GPIO_ASIS is used, the pin direction must be set in
> driver code later. AFAICT that doesn't happen.
>=20
> If a pin was defined as input by default by the manufacturer, I don't
> think there's a way to make an ADIS device work with RST on it without
> patching the driver. Device trees couldn't be used to do that IIRC. I.e.
> this patch is needed so the device reset works.

Yes, you're right. This is pretty much assuming that the pin is already an =
output
one. Though you can typically make sure that the pin will be configured as
an output one (through pinctrl) which is what we are doing in the devicetre=
e
overlays for the adis16475 device for example (in ADI trees).

> On Wed, 7 Jul 2021 10:18:57 +0200, Lars-Peter Clausen
> <lars@metafoo.de> wrote:
> > How about requesting it as GPIOD_OUT_HIGH and removing the
> > gpiod_set_value_cansleep(gpio, 1) to avoid unnecessary toggling of
> the pin.
>=20
> GPIOD_OUT_LOW and GPIOD_OUT_HIGH have different
> semantics.[1] Is setting
> the pin to use wrong semantics to save one line of code and possibly
> toggle the pin one time less worth it? (The ADIS devices whose
> datasheets I've read have the RST pin as active low, ie.
> GPIOD_OUT_LOW
> is semantically correct.)

Well, AFAIK all the ADIS devices so far have the RST pin active low
so this a very fair assumption to make and use GPIOD_OUT_HIGH.
It can always be changed afterwards or even add a flag to the adis_data
structure...

> If we really want that, I think the better choice is to use GPIO_ASIS,
> gpiod_direction_output and gpiod_set_raw_value_cansleep and skip
> semantically describing the pin altogether.

Yes, we want to make sure a reset is done on the device. So, personally,
I'm fine with either approach. Either using GPIOD_OUT_HIGH or GPIO_ASIS
with the extra 'gpiod_direction_output()'...

- Nuno S=E1
