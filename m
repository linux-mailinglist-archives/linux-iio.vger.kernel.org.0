Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA03E3539
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhHGMER (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 08:04:17 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:61362 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230012AbhHGMEQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 08:04:16 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 177BugCa011310;
        Sat, 7 Aug 2021 08:03:56 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0b-00128a01.pphosted.com with ESMTP id 3a9kxdghyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Aug 2021 08:03:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWYuIBjtbT/7B3JMSDUVvs/GCGZQay8UG49OquZKs5G5sRdKa5WTONLOLVyTprCygSlAIV80pEeNPoatfye64MOgDo9rmtiau22U3wwP8vHIerOXiw/ZSx6ksUcksZkD5ZfUiY8wSN1AmbeQ+x2vgNGVN9Qk5bCz9Rw+IkjYNPYLSdBMe2SBKWMPA9OdQeAlEDJ0XdCUU9oY5NogcUqqf8zIbAsBw/qBs92df9ZgVAWorrqxVeitwQ/N55nt8a5pCPfOMaVDjjwHyi1THykaD42c12n5wDs0H5zSvRZTJVBDf0FvM3+f87BpHuct4FTdwibZHUs04qNrqWU9g0/uyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEwHNz2Bun4cKUgVHkKqOgP4AxOgJ7QDBTaJjHwtZSw=;
 b=HOMzP1gO+P6e8uZ/G0yv09hBKi5iRNaNtyRHvVUdmIoOnHlUhQCCR9892Y2Gz4QnW8gJAZRNrlxz9mBXtV/z1S+R7GVPWnzXY6EHfpEbzwWBDPTueRz3JRV/GoHygMCVSYmnNs3w76MY8C6J3JHj0+A1J6j5DZCQWLBxir6YsqBUIe7mBwSmrCkgSm1zMgvIn9vUylunI6wshFa1yCiCHTrKBHc+uR1y6Y+E5vvERQ2X//gVYoKexaK6un912nDToWmumSLS9g44tZhtUkLBaDgPjsG2iWqgif3k9bOeM6gUOvo4K1/Kh3IhZyMwUoej7wBH3kPfU2jiWs2Tf08BZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEwHNz2Bun4cKUgVHkKqOgP4AxOgJ7QDBTaJjHwtZSw=;
 b=GST9gKkWvSM8v2020tXzJob/N15um+ZxE0gBBhgxg73LiwoIKu2W2CtuOQMBonzSGZ9LkFgsKVlL3r+FRReFBcdf/hQL5pckzyfq5e4qScdWeCOAgz3HkncsdjqzUhmBYLdnOXwKgiT/JKvhzlrddfbTDdUoTmG1KGM014D+lMg=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5879.namprd03.prod.outlook.com (2603:10b6:510:35::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Sat, 7 Aug
 2021 12:03:53 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4394.021; Sat, 7 Aug 2021
 12:03:53 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Drew Fustini <drew@pdp7.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: iio: temperature: ltc2983 probe failure
Thread-Topic: iio: temperature: ltc2983 probe failure
Thread-Index: AQHXixmgiwBw0UioSUuDM9h6/JdzVatn6xBw
Date:   Sat, 7 Aug 2021 12:03:53 +0000
Message-ID: <PH0PR03MB636619893B413B5D8088760699F49@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210806232014.GA81404@x1>
In-Reply-To: <20210806232014.GA81404@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctODcwN2I2NTQtZjc3Ny0xMWViLThiN2UtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDg3MDdiNjU1LWY3NzctMTFlYi04YjdlLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iNjA5OCIgdD0iMTMyNzI4MTE0Mz?=
 =?iso-8859-1?Q?E2NzEzMTM1IiBoPSJQSDJ5OHhjdzZReUY3RkNFT05RVU10U2U1ZWc9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUN2SEk1SmhJdlhBVU9icCs5OHRZY1pRNXVuNzN5MWh4a0ZBQUFB?=
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
authentication-results: pdp7.com; dkim=none (message not signed)
 header.d=none;pdp7.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 347463c9-9a6e-4c89-6587-08d9599b6d1a
x-ms-traffictypediagnostic: PH0PR03MB5879:
x-microsoft-antispam-prvs: <PH0PR03MB58798F04B98CB60926DD842899F49@PH0PR03MB5879.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZIjlR5kpKvv1dJTGNka9TtlM7dhPGdt6sSVH1cmXxvd2EL3OFmLFTXPX815hmtQ7NRuNooaEUP7fV3eTokxJgptPVqqDPTufj2KKsKJ86o5wRHXZaq1Vs6h2ISekbyh6480WiJIpl7G5gXtS6NOAR2Xr/WvfaTt/5VPVQ9AhUI49CuqK43UUhiB3StzzZpmgmIbu//WmvA7dZag7u0UqVH1vHy4fEqosBgeHTY/QcpR2wC9Icxs0gIfnxTjYRd9PSRPCng3EFf+to/+7mV1FwjajT4YpI2ME62tuXuL9jf7tz8m4+8C/O4ZFN8PpbkRHPoz/djQoXDGzdQRM2DYLRv2M0TJetFmd0WfhCvtp4B5NEwsbq4tTlwuJEI4Keg778j+d0GfO278oenffjT0ZSwRYh0QLbiCvR/we07ZYQKHwnheBFwNABDBVSDBw5l5ukDAo8Zkbel5Qsh68VxRzUjXB3wpPjNbFpS/AZVwT4HBlfViOI7VKJRb2GVupkn3K9mdkmccQe1AQJkdDNoWz5V5ixNsBdOqdLshcme2lxQswveDoAPrm681kWzLJmaivKkzMEnhunxI1dVVlGPWxxiyOVHQ0+zsvojo7tdCYcjuAorWW1hK5hLeWGMCKifxAT+Khm0ZIDkrLILP1xLoq2crnYWhUr4qfQgFtSrObpGrcVb4ZOVIQZkzjxKiZqc2GHLXxKSVcmfNPn47SNDBSyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(2906002)(7696005)(86362001)(5660300002)(52536014)(316002)(76116006)(66556008)(66476007)(4326008)(6916009)(71200400001)(66946007)(83380400001)(64756008)(186003)(122000001)(66446008)(8936002)(478600001)(55016002)(33656002)(6506007)(53546011)(9686003)(8676002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wFw5b8H+W0tfteMIMRdMn55QHz1iZUUk+77xBnSOOaDF5/w5LwHRB8h1XJ?=
 =?iso-8859-1?Q?xFiyNIhfDRP21P5pHKyeeiRMlSy3sTpUWvbZ0BjYrvV7ry8Vk7k4QyaSCO?=
 =?iso-8859-1?Q?ybrbj3MeyP6SUeZTu/J9c2sMnREdJThSisUP3mbVANHYiTU0WX4ALN7pU7?=
 =?iso-8859-1?Q?Ji/Un/ma+3i8GprLP5DMU4l9ohDXTUxtoWBa8VI5Fvj5VM448HMRslx+bk?=
 =?iso-8859-1?Q?ZJ3Hxoiip0oE0y/r7Wi2Bua4vZI1029wry/JZBhUqpDV1e+TNZwM+RSUWf?=
 =?iso-8859-1?Q?C1ndjg8oahfgsIQisteGc3Kg09fWpmhSzZlHKTPkq5rehrSexwaBqBNiCv?=
 =?iso-8859-1?Q?g5BDlbYHLY9Ajxrd7GwY14gM5iyGWZmnQHANbBNG8lFWHeR7xbiJttQhpy?=
 =?iso-8859-1?Q?WDIftZlQdoPVG4kqXHScwCSSURcdvAXdZKB4VP/O5gWAgyuG85DUAm6f0g?=
 =?iso-8859-1?Q?JH3fuBg+ua344XIZS2r5VuuTYq3+7hgqJNKBzx5YrXlX6PEs0m8Wzh2gWN?=
 =?iso-8859-1?Q?e85cmDHlO5LneN/QHMxYWG9A7VroyHRswZjRsvmCq+QblxoE3uEhzrPNVs?=
 =?iso-8859-1?Q?+h3hd2J75ppUR6omT+xlk2kCoWL1g3MTYqgKFRA7mqFt375lFBuSPZrH/R?=
 =?iso-8859-1?Q?KkPI7MXGSJP2I0cTJEt3DZIzWlVK7JgHPidKgwWTHxqX7UQItz66OAWnha?=
 =?iso-8859-1?Q?tvO2uYhZr9pKQS/eaaUb1DRp15WMztn+WHsR3xE9SWRuqccwHhDt4kzd9J?=
 =?iso-8859-1?Q?Dlmi5bR3zXtOknjY4f5NHgix4C5B3SeslOco86L9p0SoYa0tkQxMk9uaEW?=
 =?iso-8859-1?Q?I4oDaW5+Mno7UT+AyRGlkopGFXZ7KdGN3vNR6Iitn7oAJ9Ew4fdCCxw2Eu?=
 =?iso-8859-1?Q?p6sYArktPMbm0tkAb0s+tJ7T946PfAm8XpTNkePqZAvZWMwG012KmNBDnx?=
 =?iso-8859-1?Q?9NM1I2YcNvDg+XN02VBFW8Ry3yIVf72Bs3KGea5JvCfofNvfZQonines4d?=
 =?iso-8859-1?Q?fBB0NxzfDAa7E9HMkK7PK3ALCe+Pp/F+hD3ReU5k6xwpsKGUVFZKOd51Um?=
 =?iso-8859-1?Q?CvDwSBNhRdyAVNCTnKyMMl+10GMltJJQI47tj0sY1cOQoyhnpMTWvbGQdw?=
 =?iso-8859-1?Q?7bv3+NQYssD+t6L7tgzkyRanbIPZx0X+hN3wFefSgZLZfACSaeXsE1VyYx?=
 =?iso-8859-1?Q?KQzoQnwXGe2m7Ng/f71Vz0OTZXxQH36nGgw28PiiYkvdbOmrTU2ObB7q/l?=
 =?iso-8859-1?Q?mqrudMPwYLaQsB8cPL1WwTW7bc5RZeUnoV6ALvxuY9crlgs6UhAreUVtVD?=
 =?iso-8859-1?Q?xkcgHgcvr1amJG9WbyCKQO0hcDj6cqg2P0HorbotDnfpCM4sC5YFOfisDL?=
 =?iso-8859-1?Q?d/mYds0lUKVNemBkkBJ3yOpH2e+jACx9Y/JUeyDPyZ5+nWUbZ+D6Y=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347463c9-9a6e-4c89-6587-08d9599b6d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2021 12:03:53.2117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: euxj/7ish3/yBASlyZ4DV6b4BOj6EFuRWltbmCgBhtHZyFzIiMNDAQNliIEFbJaU6RVy9p6W89+k3mpuo65N8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5879
X-Proofpoint-GUID: e9tSV4XHmhgMoMaOZkpbYRgyiNHpFcup
X-Proofpoint-ORIG-GUID: e9tSV4XHmhgMoMaOZkpbYRgyiNHpFcup
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-07_04:2021-08-06,2021-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108070081
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Drew,

Thanks for reporting this...

> -----Original Message-----
> From: Drew Fustini <drew@pdp7.com>
> Sent: Saturday, August 7, 2021 1:20 AM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: linux-iio@vger.kernel.org
> Subject: iio: temperature: ltc2983 probe failure
>=20
>=20
> Hello - thank you for developing the LTC2983 driver. I am using that
> part in a project connected a Zynq-7000 SoC. I first tested using spidev
> and I was able to do channel assignment, start conversion and then
> read
> the conversion result. In this test, it was channel 10 configured as a
> single-ended direct ADC.
>=20
> I next replaced spidev with this device tree node inside the spi0 node:
>=20
>         sensor_ltc2983: ltc2983@0 {
>                 compatible =3D "adi,ltc2983";
>                 reg =3D <0>;
>                 spi-max-frequency =3D <4000000>;
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>                 /* ADC0_DATA_RDY (H11) is connected to MIO GPIO[2]
>                  * MIO GPIO[0] is GPIO 54 so MIO GPIO[2] is GPIO 56
> 		 * /
>                 interrupts =3D <56 IRQ_TYPE_EDGE_RISING>;
>                 interrupt-parent =3D <&gpio0>;
>=20
>                 adc10: adc@10 {
>                         reg =3D <10>; /* channel 10 */
>                         adi,sensor-type =3D <30>; /* direct adc */
>                         adi,single-ended;
>                 };
>         };
>=20
> The ltc2983 driver probe then runs at boot, but the probe would
> always
> fail. The cause is that ltc2983_setup() would return -ETIMEDOUT. From
> drivers/iio/temperature/ltc2983.c:
>=20
> 1363 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> 1364 {
> 1365         u32 iio_chan_t =3D 0, iio_chan_v =3D 0, chan, iio_idx =3D 0;
> 1366         int ret;
> 1367         unsigned long time;
> 1368
> 1369         /* make sure the device is up */
> 1370         time =3D wait_for_completion_timeout(&st->completion,
> 1371                                             msecs_to_jiffies(250));
> 1372
> 1373         if (!time) {
> 1374                 dev_err(&st->spi->dev, "Device startup timed out\n")=
;
> 1375                 return -ETIMEDOUT;
> 1376         }
>=20
> I found that if I comment out the "return -ETIMEDOUT" on line 1375
> then
> the drivers work fine. I can read from channel 10 okay:
>=20
>   # cat /sys/devices/iio:device1/in_voltage0_raw
>   4925
>=20
> I have a logic analyzer connected to test points on all the traces going
> to the LTC2983. At power up, the INTERRUPT line is low on and then
> goes
> high after about 100 ms and stays high.  I believe that this is expected
> per the datasheet [1] on page 9:
>=20
>   INTERRUPT (Pin 37): This pin outputs a LOW when the device is busy
>   either during start-up or while a conversion cycle is in progress.
>   This pin goes HIGH at the conclusion of the start-up state or
>   conversion cycle.
>=20
> From page 16:
>=20
>   Start-Up. After power is applied to the LTC2983 (V DD > 2.6V), there
>   is a 200ms wake up period. During this time, the LDO, charge pump,
>   ADCs, and reference are powered up and the internal RAM is
> initialized
>   Once start-up is complete, the INTERRUPT pin goes HIGH and the
> command
>   status register will return a value of 0x40 (Start bit=3D0, Done bit=3D=
1)
>   when read.
>=20
> Why does ltc2983_setup() call wait_for_completion_timeout()?
>=20
> I do not think there would be anyway for
> wait_for_completion_timeout()
> to succeed. I don't see a reason to expect that ltc2983_irq_handler()
> would run. The handler is installed just prior to ltc2983_setup().
>=20
> 1468 static int ltc2983_probe(struct spi_device *spi)
> 1469 {
> <snip>
> 1495         /*
> 1496          * let's request the irq now so it is used to sync the devic=
e
> 1497          * startup in ltc2983_setup()
> 1498          */
> 1499         ret =3D devm_request_irq(&spi->dev, spi->irq,
> ltc2983_irq_handler,
> 1500                                IRQF_TRIGGER_RISING, name, st);
> 1501         if (ret) {
> 1502                 dev_err(&spi->dev, "failed to request an irq, %d", r=
et);
> 1503                 return ret;
> 1504         }
> 1505
> 1506         ret =3D ltc2983_setup(st, true);
> 1507         if (ret)
> 1508                 return ret;
>=20
> Why does the probe assume that that there would be a low to high
> transistion on the INTERRUPT pin after calling devm_request_irq() and
> before calling ltc2983_setup()?

That's a good question. I honestly do to not know why I assumed that
just by requesting the irq before setting up the device, we would get a
low to high transition and enter the handler. And by chance things worked
when I was developing the driver (on a rpi) leaving this unnoticed...

> I believe the transistion happens once ~200ms after power on (I see it
> happen within 100 ms on logic anaylzer) and when conversion
> completes.
> When I read in_voltage0_raw, I can see on the logic analzyer that the
> INTERRUPT goes low when the conversion begins. It later goes high
> again
> and the conversion result is read ok. This works as expected.
>=20
> I could see using wait_for_completion_timeout() as way to sleep until
> the chip startup period is over. However, -ETIMEDOUT should not be
> returned in that case as it causes the probe to fail, even though the
> chip is actually working ok.

Using ' wait_for_completion_timeout() ' just for a sleep is also not neat :=
).
For that we would  replace the whole thing with a 'msleep(250)'.
However, my goal was really to make sure the start up sequence went
fine and the device is in a sane state. And this mechanism is actually ok
when the device is coming out of sleep (on the resume function). Hence,
what we could do here is to poll the status register (with the same
250ms timeout) until we get 0x40. This should work both for probe and
resume... Does this makes sense to you?

Once again, thanks for reporting,
- Nuno S=E1


