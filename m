Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E8B43DE72
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1KKk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:10:40 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:45394 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbhJ1KKj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:10:39 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RLOqR6029265;
        Thu, 28 Oct 2021 06:08:11 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-00128a01.pphosted.com with ESMTP id 3byeneat9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 06:08:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApDxslPBrIaXHVp98ksRp5YzzKpTZGkdicZBIZ+eVzheINihNWkAzehqPVNkLI89Aexk7OEb+2DQ7UstFFmf5XCs8WQXmD6h5gHyzRKqM7T1kOAW4NFtQpFfKp2hrTNEumuH+CpJRtm1OwKEECMoLoHuurTV+grFkVTuozl1RTDm+BusXhziBX8Zov4rN4B9gCgDc87llXsflMc212bB/pUStSr3yaLSiSbM07rUMSUHyT0Py1w70nb2Uvs4GtRthKz/aToDizci8TIT4KdFZCLAdXpw/+/RCBWWgwCk2bfqfuJ8sKaYaojuT6q/z2apnZ9o/LbEDGdUgD9pjyfFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOrjATie1tgmivE/PlwJe4TdYODogaZHE2rhkTpPlnQ=;
 b=OLc8XK6qwtgKTmivlFrnFklhoRf4YHUh9uholYkRE60+zieKedYUv91d/hU9f8jCqPd4emJGrs5DlRFj2S29B3ab0nr92TE3vqDkyvNWcmzhXA5IYtsj+pyvZ9oepx1q8DtHifiAV87gCQGyiTYA9QCyMKbOK0lpVQPD2YRsFkTLZWcEMdFs9EIuHFIIe1inNUbvplesJSw8u5My6gQq1NoOc9rYzSrrIHMGYKm6AIIXWEtBqWNIhrTkj6Wc2I8AlnRJxnVzeaEtJV41humMqnxiM91Q5bOdO/HyWMi6j4mHvIjwRGCxYbV6WiiIp4iLCNsl583jb/hQzI+mE9lLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOrjATie1tgmivE/PlwJe4TdYODogaZHE2rhkTpPlnQ=;
 b=UA3BfAu7XYa3PxhwkpSu4jRgYMnAAGIcsl2nCfPOha2u60a6oIefrXPbdrras2ATnTzdSTJDbZIC1m1fzr7hJe/9Z3lAjj+R8K+o9eok+mT7SDGX66oqnJ2I188dhqe/HA8IEbixyVaxVx2/LV0X/vlfPRnHRsO2g3yXx96lWvE=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY1PR03MB2154.namprd03.prod.outlook.com (2a01:111:e400:c61a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 10:08:08 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0%3]) with mapi id 15.20.4628.023; Thu, 28 Oct 2021
 10:08:08 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: RE: [PATCH v2 1/2] iio: frequency: admv1013: add support for ADMV1013
Thread-Topic: [PATCH v2 1/2] iio: frequency: admv1013: add support for
 ADMV1013
Thread-Index: AQHXyxRYIohS3LGbG0mOBVfjQQd6lKvnHh8AgAEL5aA=
Date:   Thu, 28 Oct 2021 10:08:08 +0000
Message-ID: <CY4PR03MB3399339315289769615E4DCD9B869@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211027092333.5270-1-antoniu.miclaus@analog.com>
 <20211027184324.51811ef1@jic23-huawei>
In-Reply-To: <20211027184324.51811ef1@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1mMGNiZGQ1NC0zN2Q2LTExZWMtYWJkZi?=
 =?iso-8859-2?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcZjBjYmRkNTUtMzdkNi0xMWVjLWFi?=
 =?iso-8859-2?Q?ZGYtZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIxNDM1MyIgdD0iMTMyNz?=
 =?iso-8859-2?Q?k4ODkyODU3MTg0OTkwIiBoPSJlbE1Tdjd4WmthK0w5MTRZcjhFbjhuS3BI?=
 =?iso-8859-2?Q?eWM9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVU?=
 =?iso-8859-2?Q?ZOQ2dVQUFFb0NBQURlVWxHejQ4dlhBVDY2dWRJZWRLSjlQcnE1MGg1MG9u?=
 =?iso-8859-2?Q?MERBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQU?=
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
x-ms-office365-filtering-correlation-id: debcfe99-1788-437e-17d1-08d999fad75b
x-ms-traffictypediagnostic: CY1PR03MB2154:
x-microsoft-antispam-prvs: <CY1PR03MB2154C6A3D60C79C0DE5AB7929B869@CY1PR03MB2154.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9LwxGKcvZgWI7jt6adYjSr2AczXgtAqwNM+FuQ7J80MSJ8hup4E3lQlij+YNm/ratjxI8qrX/gIMG/vb9y1cQeamlGeJ+Wnm55EdujtZfAJuHqwujorYEnvbPS1qKPShGLLwDZyqax/gbXrSCN7QUsxMwtrts8c9kwuHGzJFZsTLO983j1Milr5RduVMGnTkSJOUhUzjWsEPD6VYrWOWv234sE7cjXK00g1rdHj0uJYjxPyJfjIeH86D718ur/dntSUbq4lOKkkEwo0137Plh4GvST70WBB49ELrRQEiHEg7odTgU0fyBPFDRv4DabE8FgHwflrWlp8KjWvgcp74kbnG70ML4Fs1kqVenpcbwiyc7s3XEvW+KsYjtfvgay+BQ/Q0zFoyfMb6j1UvqKIDPjbptbPKTZ6nHFbICMJXPpve7ToyQMBX75LUVpFC8xR1tuJgGhC8IbgVdQSKccX6CcXJO4Aj+p2GzbEOjN0bennBEuxxdS+UyRbwbWqkTicPa595hXKAmHFneCa/3sXwJXQdkIl91drFpg0vsGhI5hRLB9yMZxyCaAz90aBw6W1iyT9SgIv8VLNDbsDQ5A/UXZmK7K1TP4rmyYzQzGH1uXM45g9okz1yrORgWynyBQdNVl/rmRIW9l0lBXzQmCpwDsfDNO3RfhyIodbbfkZ1HIEwSr+T7vTXG0zktx8bVW6PgrhqTwqxSYzwDTfpmyiMjjWgFduwouvw89J3rG0Y/NZg6jxPL81DjnOuruek0kQ87MbR4QgDp+XyFmrHkz50eKvrOdXWZTPhS6f6AjFkcA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(64756008)(30864003)(66556008)(66476007)(122000001)(52536014)(76116006)(38070700005)(7696005)(33656002)(83380400001)(8676002)(38100700002)(8936002)(86362001)(66574015)(66946007)(186003)(55016002)(26005)(966005)(107886003)(53546011)(6506007)(508600001)(71200400001)(4326008)(9686003)(54906003)(5660300002)(2906002)(316002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?70jVAFFmmOlicGucNlZHuz+gfw2C2qf62Rn+pcdzGQIrijWE8iQS7fbSNk?=
 =?iso-8859-2?Q?1gINlrUzZj5u6caVi7W3wAXLVnHeK2z6ANph/eYj6lHk1jqQs1/WuRScgT?=
 =?iso-8859-2?Q?kO3BL59ck1jn4qPuv8tZhnMDUWHEYC+CSOn2NHwStkm2SCNk9hKAXpWXhs?=
 =?iso-8859-2?Q?o+NqDCrjBtiWjH5vgj/B0/HwqKDYGn+EjEFGrsoqZuLGuO4BBINTjSM85u?=
 =?iso-8859-2?Q?ktxiWeEVn1CxPfRtYWajd6yKGkAW/Mm/MI9nmXDNVXg6eq14u1HPR786mi?=
 =?iso-8859-2?Q?hd5cU0Sl7//vzfILFNTuTwMQd3qR+PN50HNLRy/yeYtldJyl4lksj5sAWp?=
 =?iso-8859-2?Q?1J3ilB8f/J6N4OFY29xm57pbLdHDbvadPwIk8oCEcE0+n8Dti5d9Fscw4q?=
 =?iso-8859-2?Q?XdnA7p4xejQl7/mxe5L9JQLa/zMQeKFnHpBJ+4rWljy+B9CasdtxXMOeio?=
 =?iso-8859-2?Q?wy5g/NgeVE+6ksid00mgDUN+ru9DF3QeDwKwVEcuzaBWAXt8eEfcDFdD69?=
 =?iso-8859-2?Q?g2O7JQtleOQ1w4eTce9sy0/z+oLIZxetODTlFTWBKlxKqBn6ArCpK+bbG3?=
 =?iso-8859-2?Q?7TjQgwfWluJm9SELco1cPOly7Weo5J+oJrZ3h8v+I7rxafKI1Et4WyC8dg?=
 =?iso-8859-2?Q?KCc+v1fotyMqqwJYO1jZg2x+YmLDgfpcsykstLD9Z1ce53xiDeKhTOSzop?=
 =?iso-8859-2?Q?INNj4fE82e3wpvBAhsROuQvm+LC6pQv2LobXPnLhsF5A5Wd1/jpxvCW1gI?=
 =?iso-8859-2?Q?z11zj6fVWUTFXdzsI3Drewfb8e2LGh8Hbxu2nS6izTm2yr52z1E/iOMnjQ?=
 =?iso-8859-2?Q?r3k5+VVpzLheAyIJcwag4Ys0v2lTxGqmHBFmJkimZMjGol5PO4j0GhhXAl?=
 =?iso-8859-2?Q?hP1IUlYSUIeue+r3aS4zBIWV2DCOzsaC92nfmTuFEY6gwygxDMi0zWZH4u?=
 =?iso-8859-2?Q?k/T4C1UPVLUXRjkpz1IeZVE1cQjLAPULP5EGivH9ni8k9T64v/CEows/fL?=
 =?iso-8859-2?Q?P9Xuu3inMgOx6QZl5jiozglL4JsZq3vxVjaMH7dCtDpjTGm384IPpr7A67?=
 =?iso-8859-2?Q?nzjJGmFXNDVf1opexGElef+lla8m/TbL2zZiSYvXQrMZaibJzTtiD+kO23?=
 =?iso-8859-2?Q?40fzR4PHNc+LyJGjoCWFeO5iQPYNnSHw8tOiZdyeeNWfeEHHELFhMGR4cP?=
 =?iso-8859-2?Q?t3LVJVZFKrOahdK+PZKxHgqjPk2R96XyT8Szayb8MIwtvbq/bBHiH6oO/L?=
 =?iso-8859-2?Q?bOuMdOnLFDj3YOhoGGHKMrxx1ShFyfr2qIlmXhAIElFvxOLfJJUlIkoJ4X?=
 =?iso-8859-2?Q?ry+JbVwLcr9VgG39TgCxPRrpHZdcn2c9+1GV3YWWkA7siGfHjjEJXcSWK6?=
 =?iso-8859-2?Q?1YQnmWo9mKPsQCHJZ7wiSrbQTct4CyrPOKhdQ8wi4fUlLHqromCTBBT+0w?=
 =?iso-8859-2?Q?v8ncUPkkgYqzeUcxR6na5ssqcjaBJgaxEhuwrRhGyMsnRolvpMdlErWm48?=
 =?iso-8859-2?Q?GShYhQE2AoV8qWFab+0sTJOI7mduaDxWiUH3HqEdl41TeYJNAuLqNgKHj7?=
 =?iso-8859-2?Q?7o+o+euVq8CqQCMIfbnH4zA8tgvaNoxBJ2QptVJcEnuiQ41UKfKxt7EK/v?=
 =?iso-8859-2?Q?jcnLZvsSk9IgDv9nCLOiw3OTs55l/Hb/qNxRG/zHH71ZkK+XtVBiaJMxHa?=
 =?iso-8859-2?Q?/EEvdIUtgjnzi0PViXrrvfJBFKiip+GKES+A8Mnk68Eu7OfnPm4iNhP/qX?=
 =?iso-8859-2?Q?3FGg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debcfe99-1788-437e-17d1-08d999fad75b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 10:08:08.1721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lt2qEXGFjV5wWiYDWi5Eat2vTLyQ2wRj294BQVEisNkKe0Y8YymuaKu+ppPyyc0owg8yyLWQ+Xc0JsI4udh9dOPdhMcIwbhYCE+FlCJc7xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2154
X-Proofpoint-GUID: slx4gS4ZHURI-WUnpg_PolqBl20tgEvW
X-Proofpoint-ORIG-GUID: slx4gS4ZHURI-WUnpg_PolqBl20tgEvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Thanks for the review!

Regarding the interface for the Mixer Offset adjustments:=20
ADMV1013_MIXER_OFF_ADJ_P
ADMV1013_MIXER_OFF_ADJ_N

These parameters are related to the LO feedthrough offset calibration.
(LO and sideband suppression)

On this matter, my suggestion would be to add IIO calibration types, someth=
ing like:
IIO_CHAN_INFO_CALIBFEEDTROUGH_POS
IIO_CHAN_INFO_CALIBFEEDTROUGH_NEG

Looking forward to your feedback.

Regards,
--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Wednesday, October 27, 2021 8:43 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: robh+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Sa, Nuno
> <Nuno.Sa@analog.com>
> Subject: Re: [PATCH v2 1/2] iio: frequency: admv1013: add support for
> ADMV1013
>=20
> [External]
>=20
> On Wed, 27 Oct 2021 12:23:32 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > The ADMV1013 is a wideband, microwave upconverter optimized
> > for point to point microwave radio designs operating in the
> > 24 GHz to 44 GHz radio frequency (RF) range.
> >
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-
> sheets/ADMV1013.pdf
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Hi Antoniu.
>=20
> A few small things inline, but main issue in here is the use of the
> IIO_VAL_INT_MULTIPLE
> There are very very few uses for that type (1 IIRC) and it isn't to combi=
ne
> multiple
> values into a single sysfs attribute as shown here.  As such those offset
> interfaces
> need a rethink.  We may well have to define some new ABI to support them
> but I don't
> see a reason to not maintain the normal sysfs rule of one value per attri=
bute.
>=20
>=20
> ..
>=20
> > diff --git a/drivers/iio/frequency/Makefile
> b/drivers/iio/frequency/Makefile
> > index 518b1e50caef..559922a8196e 100644
> > --- a/drivers/iio/frequency/Makefile
> > +++ b/drivers/iio/frequency/Makefile
> > @@ -7,3 +7,4 @@
> >  obj-$(CONFIG_AD9523) +=3D ad9523.o
> >  obj-$(CONFIG_ADF4350) +=3D adf4350.o
> >  obj-$(CONFIG_ADF4371) +=3D adf4371.o
> > +obj-$(CONFIG_ADMV1013) +=3D admv1013.o
> > diff --git a/drivers/iio/frequency/admv1013.c
> b/drivers/iio/frequency/admv1013.c
> > new file mode 100644
> > index 000000000000..91254605013c
> > --- /dev/null
> > +++ b/drivers/iio/frequency/admv1013.c
> > @@ -0,0 +1,578 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ADMV1013 driver
> > + *
> > + * Copyright 2021 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/device.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> Recheck this list.  Should have
> property.h and mod_devicetable.h
>=20
> > +#include <linux/notifier.h>
> > +#include <linux/regmap.h>
>=20
> and not regmap as you aren't using it.
>=20
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include <asm/unaligned.h>
>=20
> ...
>=20
> > +/* ADMV1013_REG_OFFSET_ADJUST_Q Map */
> > +#define ADMV1013_MIXER_OFF_ADJ_Q_P_MSK
> 	GENMASK(15, 9)
> > +#define ADMV1013_MIXER_OFF_ADJ_Q_N_MSK		GENMASK(8,
> 2)
> Given these two registers have the same form, could you use generic namin=
g
> and just have them defined once?
>=20
> > +
> > +/* ADMV1013_REG_QUAD Map */
> > +#define ADMV1013_QUAD_SE_MODE_MSK		GENMASK(9,
> 6)
> > +#define ADMV1013_QUAD_FILTERS_MSK		GENMASK(3, 0)
> > +
> > +/* ADMV1013_REG_VVA_TEMP_COMP Map */
> > +#define ADMV1013_VVA_TEMP_COMP_MSK
> 	GENMASK(15, 0)
> > +
> > +struct admv1013_state {
> > +	struct spi_device	*spi;
> > +	struct clk		*clkin;
> > +	/* Protect against concurrent accesses to the device */
>=20
> Also against concurrent access to data.  Maybe other state in software as
> well?
> This comment needs to cover everything the lock protects - if it were jus=
t
> serialization of accesses to the device then the spi subsystem would hand=
le
> that fine for us.
>=20
> > +	struct mutex		lock;
> > +	struct regulator	*reg;
> > +	struct notifier_block	nb;
> > +	unsigned int		quad_se_mode;
> > +	bool			vga_pd;
> > +	bool			mixer_pd;
> > +	bool			quad_pd;
> > +	bool			bg_pd;
> > +	bool			mixer_if_en;
> > +	bool			det_en;
> > +	u8			data[3] ____cacheline_aligned;
> > +};
>=20
> ...
>=20
> > +static int admv1013_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val, int *val2, long info)
> > +{
> > +	struct admv1013_state *st =3D iio_priv(indio_dev);
> > +	unsigned int data;
> > +	int ret;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		if (chan->channel2 =3D=3D IIO_MOD_I) {
> > +			ret =3D admv1013_spi_read(st,
> ADMV1013_REG_OFFSET_ADJUST_I, &data);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val =3D
> FIELD_GET(ADMV1013_MIXER_OFF_ADJ_I_P_MSK, data);
> > +			*val2 =3D
> FIELD_GET(ADMV1013_MIXER_OFF_ADJ_I_N_MSK, data);
>=20
> I mention above about generic naming for these masks.  Advantage is then
> that this
> code can be
>=20
> 		if (chan->channel2 =3D=3D IIO_MOD_I)
> 			addr =3D ADMV1013_REG_OFFSET_ADJUST_I;
> 		else
> 			addr =3D ADMV1013_REG_OFFSET_ADJUST_Q;
>=20
> 		ret =3D admv1013_spi_read(st, addr, &data);
> 		if (ret)
> 			return ret;
>=20
> 		*val =3D FIELD_GET(ADMV1013_MIXER_OFF_ADJ_P_MSK,
> data);
> 		*val2 =3D FIELD_GET(ADMV1013_MIXER_OFF_ADJ_Q_MSK,
> data);
>=20
> 		return IIO_VAL_INT_MULTIPLE;
>=20
> However, returning multiple integers is normally reserved for things like
> quaternions where the individual parts have no meaning except when they
> are all present.
> It's not intended for pairs like this. It should also only be used with t=
he special
> read_raw_multi callback.
>=20
> So we need to rethink this interface. I'm not entirely sure what it is
> doing so I'm open to suggestions on what the interface should be!
> The description on the datasheet suggest to me these are for calibration
> tweaking
> in which case they should be related to calibbias not offset as they aren=
't
> something
> we should apply to a raw value in userspace (which is what offset is for)=
.
>=20
>=20
> > +		} else {
> > +			ret =3D admv1013_spi_read(st,
> ADMV1013_REG_OFFSET_ADJUST_Q, &data);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val =3D
> FIELD_GET(ADMV1013_MIXER_OFF_ADJ_Q_P_MSK, data);
> > +			*val2 =3D
> FIELD_GET(ADMV1013_MIXER_OFF_ADJ_Q_N_MSK, data);
> > +		}
> > +
> > +		return IIO_VAL_INT_MULTIPLE;
> > +	case IIO_CHAN_INFO_PHASE:
> > +		if (chan->channel2 =3D=3D IIO_MOD_I) {
> > +			ret =3D admv1013_spi_read(st,
> ADMV1013_REG_LO_AMP_I, &data);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val =3D
> FIELD_GET(ADMV1013_LOAMP_PH_ADJ_I_FINE_MSK, data);
>=20
> As above, the masks match for these two branches of if / else, so with a
> generic
> name you should be able to share more code and only have to select the
> right register.
>=20
> > +		} else {
> > +			ret =3D admv1013_spi_read(st,
> ADMV1013_REG_LO_AMP_Q, &data);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val =3D
> FIELD_GET(ADMV1013_LOAMP_PH_ADJ_Q_FINE_MSK, data);
> > +		}
> > +
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int admv1013_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long info)
> > +{
> > +	struct admv1013_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		val2 /=3D 100000;
> > +
> > +		if (chan->channel2 =3D=3D IIO_MOD_I)
> > +			ret =3D admv1013_spi_update_bits(st,
> ADMV1013_REG_OFFSET_ADJUST_I,
> > +
> ADMV1013_MIXER_OFF_ADJ_I_P_MSK |
> > +
> ADMV1013_MIXER_OFF_ADJ_I_N_MSK,
> > +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_I_P_MSK, val) |
> > +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_I_N_MSK, val2));
>=20
> As above, this isn't in inline with the normal ABI conventions so needs a
> rethink.  As far as I can
> establish these two values are independent though the datasheet provides
> limited information.
>=20
> > +		else
> > +			ret =3D admv1013_spi_update_bits(st,
> ADMV1013_REG_OFFSET_ADJUST_Q,
> > +
> ADMV1013_MIXER_OFF_ADJ_Q_P_MSK |
> > +
> ADMV1013_MIXER_OFF_ADJ_Q_N_MSK,
> > +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_Q_P_MSK, val) |
> > +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_Q_N_MSK, val2));
> > +
> > +		return ret;
> > +	case IIO_CHAN_INFO_PHASE:
> > +		if (chan->channel2 =3D=3D IIO_MOD_I)
> > +			return admv1013_spi_update_bits(st,
> ADMV1013_REG_LO_AMP_I,
> > +
> 	ADMV1013_LOAMP_PH_ADJ_I_FINE_MSK,
> > +
> 	FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_I_FINE_MSK, val));
> > +		else
> > +			return admv1013_spi_update_bits(st,
> ADMV1013_REG_LO_AMP_Q,
> > +
> 	ADMV1013_LOAMP_PH_ADJ_Q_FINE_MSK,
> > +
> 	FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_Q_FINE_MSK, val));
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int admv1013_update_quad_filters(struct admv1013_state *st)
> > +{
> > +	unsigned int filt_raw;
> > +	u64 rate =3D clk_get_rate(st->clkin);
> > +
> > +	if (rate >=3D 5400000000 && rate <=3D 7000000000)
>=20
> To reduce chance of 0s issues you could use the HZ_PER_MHZ definition in
> include/linux/units.h
> Nice to avoid counting so many zeros when reviewing.
>=20
> > +		filt_raw =3D 15;
> > +	else if (rate >=3D 5400000000 && rate <=3D 8000000000)
> > +		filt_raw =3D 10;
> > +	else if (rate >=3D 6600000000 && rate <=3D 9200000000)
> > +		filt_raw =3D 5;
> > +	else
> > +		filt_raw =3D 0;
> > +
> > +	return __admv1013_spi_update_bits(st, ADMV1013_REG_QUAD,
> > +					ADMV1013_QUAD_FILTERS_MSK,
> > +
> 	FIELD_PREP(ADMV1013_QUAD_FILTERS_MSK, filt_raw));
> > +}
> > +
>=20
> > +static int admv1013_reg_access(struct iio_dev *indio_dev,
> > +			       unsigned int reg,
> > +			       unsigned int write_val,
> > +			       unsigned int *read_val)
> > +{
> > +	struct admv1013_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (read_val)
> > +		ret =3D admv1013_spi_read(st, reg, read_val);
>=20
> 		return amdv1013_spi_read() etc is a bit more concise for now
> loss of readability.
>=20
> > +	else
> > +		ret =3D admv1013_spi_write(st, reg, write_val);
> > +
> > +	return ret;
> > +}
> > +
>=20
> ...
>=20
>=20
> > +
> > +#define ADMV1013_CHAN(_channel, rf_comp) {			\
> > +	.type =3D IIO_ALTVOLTAGE,					\
> > +	.modified =3D 1,						\
> > +	.output =3D 1,						\
> > +	.indexed =3D 1,						\
> > +	.channel2 =3D IIO_MOD_##rf_comp,				\
> > +	.channel =3D _channel,					\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_PHASE) |	\
> > +		BIT(IIO_CHAN_INFO_OFFSET)			\
> > +	}
> > +
> > +static const struct iio_chan_spec admv1013_channels[] =3D {
> > +	ADMV1013_CHAN(0, I),
> > +	ADMV1013_CHAN(0, Q),
> > +};
>=20
> ...
>=20
> > +
> > +static int admv1013_properties_parse(struct admv1013_state *st)
> > +{
> > +	int ret;
> > +	struct spi_device *spi =3D st->spi;
> > +
> > +	st->vga_pd =3D device_property_read_bool(&spi->dev, "adi,vga-pd");
> > +	st->mixer_pd =3D device_property_read_bool(&spi->dev, "adi,mixer-
> pd");
> > +	st->quad_pd =3D device_property_read_bool(&spi->dev, "adi,quad-
> pd");
> > +	st->bg_pd =3D device_property_read_bool(&spi->dev, "adi,bg-pd");
> > +	st->mixer_if_en =3D device_property_read_bool(&spi->dev,
> "adi,mixer-if-en");
> > +	st->det_en =3D device_property_read_bool(&spi->dev, "adi,det-en");
>=20
> Comments on these in the binding document.
>=20
> > +
> > +	ret =3D device_property_read_u32(&spi->dev, "adi,quad-se-mode",
> &st->quad_se_mode);
> > +	if (ret)
> > +		st->quad_se_mode =3D 12;
> > +
> > +	st->reg =3D devm_regulator_get(&spi->dev, "vcm");
> > +	if (IS_ERR(st->reg))
> > +		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
> > +				     "failed to get the common-mode
> voltage\n");
> > +
> > +	st->clkin =3D devm_clk_get(&spi->dev, "lo_in");
> > +	if (IS_ERR(st->clkin))
> > +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> > +				     "failed to get the LO input clock\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int admv1013_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct admv1013_state *st;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st =3D iio_priv(indio_dev);
> > +
> > +	indio_dev->info =3D &admv1013_info;
> > +	indio_dev->name =3D "admv1013";
> > +	indio_dev->channels =3D admv1013_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(admv1013_channels);
> > +
> > +	st->spi =3D spi;
> > +
> > +	ret =3D admv1013_properties_parse(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regulator_enable(st->reg);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "Failed to enable specified Common-
> Mode Voltage!\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_add_action_or_reset(&spi->dev,
> admv1013_reg_disable,
> > +				       st->reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D clk_prepare_enable(st->clkin);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_add_action_or_reset(&spi->dev, admv1013_clk_disable,
> st->clkin);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->nb.notifier_call =3D admv1013_freq_change;
> > +	ret =3D clk_notifier_register(st->clkin, &st->nb);
>=20
> There seems to be a devm_clk_notifier_registers() which you should use.
>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_add_action_or_reset(&spi->dev,
> admv1013_clk_notifier_unreg, st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_init(&st->lock);
> > +
> > +	ret =3D admv1013_init(st);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "admv1013 init failed\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_add_action_or_reset(&spi->dev,
> admv1013_powerdown, st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(&spi->dev, indio_dev);
> > +}
> > +
>=20
> ...

