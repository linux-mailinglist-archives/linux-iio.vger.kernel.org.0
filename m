Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90F4613460
	for <lists+linux-iio@lfdr.de>; Mon, 31 Oct 2022 12:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJaLT2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Oct 2022 07:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJaLT1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2022 07:19:27 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80F8DF21
        for <linux-iio@vger.kernel.org>; Mon, 31 Oct 2022 04:19:26 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29V8ZlBL004191;
        Mon, 31 Oct 2022 07:19:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kj6bc9khv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 07:19:21 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29VBJKdf015726;
        Mon, 31 Oct 2022 07:19:20 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kj6bc9khr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 07:19:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz8FkNevwVDAepndoZlahfmyg0q77GltFo6DKpSQviWOkA4osk5KVzkYB9j5nATrEQ/8HB+omUnYQFaDhPXXHDfNtCTaT3THkTfLFmVgKEGN3SSXb9hiiQ2UrwDJc4RlaSvSh4Tcqnf07vAW5h5SPFaSNTNYpi07BTiOWW0H049nBwMTpXmDf4aUfcFLGxTjc9T15IX+PDa0CF/v1tH9oMPpFsJiWAIiMUA9zT5LoPTzXZ33cok1QLgsEpQ0UaFjBr9XGzoCRGd0ysatHCYYzBP7S006wvBpJlacAlz3tXzGo2vmpX4gq7htegU58D1P2W3WWxgZQPBf/Wfs4H8AYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YngEyEAtWR3wrCge5JJMSgwvrXLJxcGA4ZCd3Mfn/Gw=;
 b=XsvAylzEMSkdnkbgpMpsxXcdKH43BVCWV+RKXZL7vf1+Wow5EjBXvXDmEaTYScrY/IP+onFuXqTjtFr6RqgmRwqzbcDwUjSaSfbdmDB4941NJg7VM9WkxIW435bD/q26+k3A92GJGm1kbBDye9anh1sHBwvwk3Rhc92XYFPWh2BXqKyNXawPBBH9ZQxpzRDWnHvZK0vlykd4SLxYkODz/AZ7lkhggrI+Sfd+ClPCeVPqtcjlZdiHke4qg2cPAzEaxfC9kqgSXKQfcxUQbY/C86WbGWGqJHPT1S1MqetOzvzN87Q11ngZdGAci4i6oAwIl7kkbYx5XuN4SlB6dV8EeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YngEyEAtWR3wrCge5JJMSgwvrXLJxcGA4ZCd3Mfn/Gw=;
 b=hJkXetWS9VhSvFrb0ieNBb3ISoNLpmIcgNtffWLKZpx5YBkvU08Gk+e8LXUW90pftkU0KdmxamoDzKwMu6VY10pKpwfK4n9ckBCXCKSs5i1LNw5Cd63UcOdJRlvJxEkSSYZR5QYTnlhbVNDmZ+QbEZUYBBjWj6zglqVBzHRM0MY=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by MW4PR03MB6635.namprd03.prod.outlook.com (2603:10b6:303:12a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 11:19:19 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 11:19:19 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Phani Movva <Phani.Movva@imgtec.com>,
        Naidu Tellapati <naidu.tellapati@imgtec.com>
Subject: RE: [PATCH 0/5] iio: adc: cc10001: Devm conversion
Thread-Topic: [PATCH 0/5] iio: adc: cc10001: Devm conversion
Thread-Index: AQHY4YI1oL2Yr08l/kKHhP3+lN+3Fq4lZRWAgAMK57A=
Date:   Mon, 31 Oct 2022 11:19:19 +0000
Message-ID: <SJ0PR03MB67785AB3EBAF51E84687F31499379@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221016170950.387751-1-jic23@kernel.org>
 <20221029134331.52adcda1@jic23-huawei>
In-Reply-To: <20221029134331.52adcda1@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZDY0M2EzYmItNTkwZC0xMWVkLWI2YjktYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGQ2NDNhM2JjLTU5MGQtMTFlZC1iNmI5LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMjA1NCIgdD0iMTMzMTE2ODg3NT?=
 =?iso-8859-1?Q?c3MTgwODg4IiBoPSJzRE1OS2hPbDVNdFZiQ2R1LzNKb3pIUFkyR1k9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURZdXFTZEd1M1lBWU1OaVgrVmk1WmhndzJKZjVXTGxtRURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVg1bDJLd0FBQUFBQUFBQUFBQUFBQUo0?=
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
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|MW4PR03MB6635:EE_
x-ms-office365-filtering-correlation-id: a0f72d09-3a4d-4ce9-6983-08dabb31c0ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GaGWz2cZpe/RgT3Z34BZaJ/KOTQ177qz3Qe/Qid9Du3hSo7HxILUd1RZS70bDfvvQ9vKrbljJZQ7e3I8QEciyyMCwZ2U/8iqiwl+S8x0w4R+AsGg+GsVlrfJmrEqM2YU8kqZvqvcrGz7KJS79cLLpm2GghHef468ISfPPZKKPQ9v0X3qeU3fnW2dGHX9SXND8v9NSfLp4q6xVAZzAO/W26hpsbeeJL/xwm+fOkYskC2d/O4mYXkiLcn4pHjS0OsZHrj8VfEQvYiT73AoPioYsyRgYhZRdQRYnP6RmIuCvOnF1dG8c54uHRlB0tGzFom0yoTzICSgknF3l8CoTjDxp5k/r4nIQOgpIy4jd1mqg1FL6QwP067rosLHlIkWpbiXcGIgweVsOSngpl9detsxiw7nHyl9AV6l96G8BmM45twG+hdGXuZz/frLnfE3IO/17hhGx/wODQOSltNzzXrBEYhnDjQkjO5rMZh8TyGcnIbIxUqXMfUkNIXiMhRiM/XqVFlSeppsEJZuIF755yQBRPcF36gu9AWbUupoVXRQSCQ6+rngQOtORxAP7n9LqzdS/XGAsdjeZDVnynVfSJT0phwKUyzrBNmuPlKDUavNuhdruNNAv3KIp7vEWFVAeR1FOKA3FSv2rXZA6nyH9ksqI3EW/Gb+rUeAl+BBMt0fWRcT6zIi4EnNQeypky573Jyr5QIB1b1bsvtYrcfaA4ub/79yxfZNYQ/eyJZ1xLZrM3/xyeW0SJ17dWF6uPB7dU7hH+4/h3IixTJcqRLpfoGLgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(38070700005)(55016003)(33656002)(86362001)(38100700002)(122000001)(110136005)(54906003)(8676002)(316002)(53546011)(478600001)(7696005)(6506007)(71200400001)(9686003)(26005)(76116006)(41300700001)(8936002)(5660300002)(52536014)(64756008)(66476007)(83380400001)(66946007)(186003)(66446008)(66556008)(2906002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+c9/sqUSB/JOtjIMQ0wWduvYvs1SOM7sNDwGKTQl+rgQxo3+ffffpQZTct?=
 =?iso-8859-1?Q?V7XfHwwujKzqwYldT18eCLlmKFNovvfRJZddTi30vG8m3Y/8mQ6Z8oNx2F?=
 =?iso-8859-1?Q?xybH3eJmEkokllsiGzRgT7Qx9npgQkh8dubBWj7N9eY8XwJaOxhNCu5dsE?=
 =?iso-8859-1?Q?4muoNWtgpsdV2UMfK2ZNpmImxofSQeLtyEvg/zqzMurGba1wRoGQ1XzMpS?=
 =?iso-8859-1?Q?+fITx+/hE6MgUARkE/Q2BgQgm9yRSZR/GPZErPKhq5nliNHDKPM8zgont3?=
 =?iso-8859-1?Q?X8+qNBPyWkZ6vJ41a5wBhdEWgVwVenBI0LLEWqSdkDtYSMVbHxUezJVTD3?=
 =?iso-8859-1?Q?kcSGOGNE1JaHirYtyZlVRLladK9H1wrqLnbSLC4i5iRMYb8Seh2t0j2/HI?=
 =?iso-8859-1?Q?1rTjwqGrrmcfbBCEha157auvt+pRkJArh9666SmRR28UwFqBDJ86Up8CkS?=
 =?iso-8859-1?Q?t/2ooHJqcpK5a6aQFobGDDnDfxj4r5KEUWMCBQyHvgzkFIIjz7M5a7Lwx/?=
 =?iso-8859-1?Q?YDW1Gt4ce2IayI+V5+/m9RVE5egF2NJSOanUZQTGV7tUjrT3uKTKqRtnQD?=
 =?iso-8859-1?Q?QJ1KuSf+KJF3nGIuxI/PLKBEzwnRNDMJSK0+72r5l2nhr+KgUdiUMhcHKo?=
 =?iso-8859-1?Q?kiopnukKMR5OHzScOwKqYwdDD0MsdJyEAPmZE6St7UOBRnl6+HsL8Cz8i3?=
 =?iso-8859-1?Q?vH2WHKVbKtf8UZw3h1FCl63Rea0qg5ne4A/7fujYGdQEIDz9OM5EqTOIQZ?=
 =?iso-8859-1?Q?h86xE0yZkW2fvdVwN+e/6gV4egzI9fe6xPtTNDbKt8WlWQlgfpQu8H5eKP?=
 =?iso-8859-1?Q?OYL4iMOwuT97e/nLc+VoEjWzdpTEB1qG9pwfMVe8G34BsxxjZAEMHTMCi0?=
 =?iso-8859-1?Q?+6LMTuqdf6j4ZfYB2YWAqn1JezQNushq1yyWmokOYZ5wf0JegYB9mIXB8n?=
 =?iso-8859-1?Q?02Ud6/h2KigOGZTOjzffdtdxsBSRcFRJiDK9KgFHdk2c5boOU+UPZ5H1uy?=
 =?iso-8859-1?Q?anqXERco25YQwdrtuykoHrT8NL1Q49FCYykt/x6PnyyCAxA+oT83Ty/Fbl?=
 =?iso-8859-1?Q?m1zcDsGMuxXDtoG09ZE6Efyer2nlvdaDhqYtFiSjlf92Z53QCGgLOL4aOW?=
 =?iso-8859-1?Q?b8rPDLQzXfVJTSKZ80bohrhtZ6czPJpOk2pE3ThI8gu7HqWEelZpngyd2Z?=
 =?iso-8859-1?Q?oAU6ZB+KSfHET07e4PUHI4FfrCBt50Geh3cFjRg2k7M1D8l3C5JUUomXO4?=
 =?iso-8859-1?Q?N9dq6K9SJgKj7S9OXlEFvIC0huKkJztNDY2Uw14WRZod4lI3ODQI/kelZU?=
 =?iso-8859-1?Q?uuuvW/7yBh9ZpKQAiSvEc9ENDk5OGGcYRAWyZ0HZ2lEjNkm/B5BpJFc4sf?=
 =?iso-8859-1?Q?UrTT3JLClEv4ENkHT4Oog7C3dbuhOQdWtHb1r4n5GXvXyqU4CNQ950IZsE?=
 =?iso-8859-1?Q?hdgsHa0m9My2aqLftDUJ7bqN5iT8ArrahmHaunOfIUHA4VhGEiF7jIHWO8?=
 =?iso-8859-1?Q?AT0IH4OBQOiSVGeITEz8dxE0tY9nPJFcaYMUxlKkt3z8V/l9Gyo8Qeq14e?=
 =?iso-8859-1?Q?eSqb8ZfggyBf7k+9sWPsevfDefkJ1hIfNjhEK+KsQsyjTjzT5g1skr+/Xz?=
 =?iso-8859-1?Q?Y2GeOVImZJbpV/1Lpd+82qHyleVRweaAFQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f72d09-3a4d-4ce9-6983-08dabb31c0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 11:19:19.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmxGy1PC//MWyJaRdWcsSaNev+bD05PC30XgqA6587U64yscgFBPiZiM1FKY1sH4Wlg8D1t76YsQIkhmqcMETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6635
X-Proofpoint-ORIG-GUID: teZlv_q0y7qxe9igM3dFeATYMzGHhBj_
X-Proofpoint-GUID: NCy8cfw5N2BH-sIRWDHfkQjzE29Z9yqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=718 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310071
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, October 29, 2022 2:44 PM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Phani Movva
> <Phani.Movva@imgtec.com>; Naidu Tellapati <naidu.tellapati@imgtec.com>
> Subject: Re: [PATCH 0/5] iio: adc: cc10001: Devm conversion
>=20
> [External]
>=20
> On Sun, 16 Oct 2022 18:09:45 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > A very simple example of how using devm_ managed calls for everything
> > can reduce complexity error handling and removal ordering in a driver.
> >
> > Note I don't have one of these to test so if anyone has a chance to do
> > so or give these a quick look at that would be much appreciated.
> > Note this is a fairly old driver, so relative unlikely original authors
> > still have access.
> >
> > Cc: Phani Movva <Phani.Movva@imgtec.com>
> > Cc: Naidu Tellapati <naidu.tellapati@imgtec.com>
>=20
> If anyone has time for a quick glance at this it would be much appreciate=
d!
>=20
> Old maintainer issue of who is the fall back reviewer for the maintainers
> own patches to old drivers, where the authors etc have probably long sinc=
e
> moved on.
>=20
> Jonathan
> >
> > Jonathan Cameron (5):
> >   iio: adc: cc10001: Add local struct device *dev variable to avoid
> >     repitition
> >   iio: adc: cc10001: Add devm_add_action_or_reset() to disable
> >     regulator.
> >   iio: adc: cc10001: Use devm_clk_get_enabled() to avoid boilerplate.
> >   iio: adc: cc10001: Use devm_ to call device power down.
> >   iio: adc: cc10001: Switch remaining IIO calls in probe to devm_ forms=
.
> >
> >  drivers/iio/adc/cc10001_adc.c | 89 +++++++++++++----------------------
> >  1 file changed, 34 insertions(+), 55 deletions(-)
> >

Only minor comments, so feel free to add:

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
