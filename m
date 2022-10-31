Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CEF61345D
	for <lists+linux-iio@lfdr.de>; Mon, 31 Oct 2022 12:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiJaLR0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Oct 2022 07:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJaLRZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2022 07:17:25 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D9BDF17
        for <linux-iio@vger.kernel.org>; Mon, 31 Oct 2022 04:17:24 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29V8cK6Z004202;
        Mon, 31 Oct 2022 07:17:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kj6bc9k90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 07:17:14 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29VBGgAA008026;
        Mon, 31 Oct 2022 07:17:14 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kj6bc9k8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 07:17:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQLwKI5KzEjiwTL6eNQ5tFUznPch0xN8Bt8pB7AjmOoHAzhQ7Ls+0dbp8TUUZ9x5lumDRQFErQZHf+wvyFfhg9NqpFSeIBY2EkZrKe0CNhS7O5HlzQP6pjiENH1fJ8/CCER69OkMDDkwDsDsem8ll9uJbi17ZgCBp4aqb3RB85FehvH2JQIJdUqQJlLGrB9N28pZvChGTzAsAvl9Uv2Tpnvpg8NU/G3d8tMVYn/sopHnsl7nQnuAKwgW3o/HillF6HcoEwP1xOOkCrMFaT7I2Bf92si17j6YHmvfpfq5F6OpzYnDPcWAu1TMy/CivRsxo+zflQVXbkPKvPjOJUB6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A8UuCH2qagcZjk60H9AypixOkuSQKsGfFavV2PsLzg=;
 b=CnIf4qLoSSBk8jJhV+aKRmhHy7wuNL3d45vSFldv//6nwRwwvYTSI6n+T/a/TehO0n2o74ro49sbBI/0cH5lOZWkHagff+6KnRtuWltHxPKWS3ZAQqB7FrUfZVA2gDAB0HzRu3iUKaUFAlVwxrrASICtqQXfYpQlpLDo3BDMIN+LkfJV5zuZHNJJaQNM+m0yZQXqzR0W7ti5C6lo7VOtZ4V9e82PanYnj0M1998EPq9Gh86GmFu49em7TUdTE44ErcDe6IDKT3i5MvBBRYfoyJqPzbfZDJezNX48O+N9AOjfAhs5QvS03b1nFe9u0uQt4BOESbXSBTbHjKwrUuNKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A8UuCH2qagcZjk60H9AypixOkuSQKsGfFavV2PsLzg=;
 b=pq4+i0R5ITqn1iIcA21Yg1ziuQXPMruEvqaNNLNgAWZ7MPwqB9ZbHTVDAWW+jum4sg5H8YDsMj/wO7coSxYC7mY4wYseeuirN4nciwJrYdTs7rolcafuwBcyGWd6AHPqTgkDyOSiEIlsglonnkfm6gTUZ5IdUFsvJRcayZDSqH8=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by MW4PR03MB6635.namprd03.prod.outlook.com (2603:10b6:303:12a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 11:17:12 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 11:17:11 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 5/5] iio: adc: cc10001: Switch remaining IIO calls in
 probe to devm_ forms.
Thread-Topic: [PATCH 5/5] iio: adc: cc10001: Switch remaining IIO calls in
 probe to devm_ forms.
Thread-Index: AQHY4YIysqW5l1L3TEijn+P5jws2bq4ob+3A
Date:   Mon, 31 Oct 2022 11:17:11 +0000
Message-ID: <SJ0PR03MB6778101A495B0F3C6069E2CD99379@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221016170950.387751-1-jic23@kernel.org>
 <20221016170950.387751-6-jic23@kernel.org>
In-Reply-To: <20221016170950.387751-6-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctOGVhNTA0NDMtNTkwZC0xMWVkLWI2YjktYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDhlYTUwNDQ0LTU5MGQtMTFlZC1iNmI5LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTkyMCIgdD0iMTMzMTE2ODg2Mj?=
 =?iso-8859-1?Q?k0NDIwMDkxIiBoPSJwUFRZNWozNkF1cUFrS1RURU0rTlVIREw5WFk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUI3V2k5Ukd1M1lBYzE2eGt2T01xUFh6WHJHUzg0eW85Y0RBQUFB?=
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
x-ms-office365-filtering-correlation-id: 9a6bd59a-eb34-4ea7-9233-08dabb31751a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcbcHN/ep3KZKUGcKXvykdkpHKykmjS31YfrBMdKUfD7fWrUSbBP6TAX5KQbCz5j6qNhsNFy2jvZT7udYxiKdhuuTF1uZrwLjzEzAO8xyExjiq6nR19Kx4OWIu8Qp260DP1/TSYloIttFsahtZxEvCEKCEeWKOqGPveov84vbPO2f2H7VGay/0MRO1q0FRaskh/cvQskueBu2f5xtfdbXT4mWmQgtFKohpFQEkkOoasrex5/sXDYdhCmqRggFZ16lozkgXV8hsATTErFm7qNUg/uY6If1e/MSsgS66Tm9av80ozJTZbdPiEhg12dC0gH5hQ619RQxrSsDjSKnpA5UtjlwxwRZlfmS/b8p61zA7Y5Bd3PV+X7p+uiWjcwX89juQmBRasNKbMFaw0mrNyxBYjJd5slDmdfgVJ9NpscoXSnq6NL8XRaJzGFd60PrcxVoby9ML4lWcMbnrm9xxMTU+ofzUcWosG4vr5fptwltBfiDr0FQcIUEvwp7R8Xk6y1+hTtxdetn/PxTWe15KJ6FazJXxjbyJJUsraLzcYjKOqZJDfQkO9zncG03Ek50bs1DBEMV4gybTzb21kXLxp6evMbCC8uZlNReF2HbhzHMXOnYiOzLHmRducTwcOWleeU5DD6Ro6flzViiO5iStYun/3zHJ5duv6cqzv02a2HDovj1IxVpvXFTn1223Goc0bR+f3D7aWjqQIpgNvP7TUU1IA+MI0Irv6zBvOmctSe3yonIvlxgMiuVP2IoR/471eyq0coD4RsZwB47RVatMxtiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(38070700005)(55016003)(33656002)(86362001)(38100700002)(122000001)(110136005)(8676002)(316002)(53546011)(478600001)(7696005)(6506007)(71200400001)(9686003)(26005)(76116006)(41300700001)(8936002)(5660300002)(52536014)(64756008)(66476007)(83380400001)(66946007)(186003)(66446008)(66556008)(2906002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rhamsuwm/svjL31lkKe8ZJSmb1LhXvJgCIQAPmvnKJZFT2IeuXfTmRhLdk?=
 =?iso-8859-1?Q?v+u2tpsrUHZHcbCV++wzsIPZa0SGjTOdrThecpKgJAxJVGaTkZ3bJSP3X4?=
 =?iso-8859-1?Q?CohMfnDMeVrlTxzAcZ86LXHF4OdOJp+Z9YcaNZtM/7qmPUj9MmC8Kce3EO?=
 =?iso-8859-1?Q?58YZdP5HQCFvu/4Bka6dTHH8vTwfD2+H9aRouy/Xrb/De8sVJKmK8K8WiK?=
 =?iso-8859-1?Q?2+JHkxN2mI5aR+w7kYIW1HHx/zpflRIgCA4l+TwT5E/DVQ5aJq6ki9or+G?=
 =?iso-8859-1?Q?feC1F8tOQTBhgFxy7EnvQTlMvcH+XI5NRuZsl75tbK8ECEjeU78wwT/cDq?=
 =?iso-8859-1?Q?u3fOfccwDdo55o3sYyBMpQ3mvN2RVVKffNTj400ygK4Bbq4dAKSe/mY+aF?=
 =?iso-8859-1?Q?tGEs0KYOxHyYL9LOVNl59d3vkSUiX3omXz+/Xos7V6OmgawNw8a3T0otbM?=
 =?iso-8859-1?Q?vaPO527w0w8Be+WKL+J44/21hwE1jyI5N/BpR7EAgrmFreGWMUG3P2m6MJ?=
 =?iso-8859-1?Q?YsyZplBph/1qyjHJGzqF+U8lw8YdhJl/9DBr6h/EDxfIXACgpADPaCRef/?=
 =?iso-8859-1?Q?v1/iHYyh+pQfeWpDOL56PlKoFMZWk6au6I0pZBGCMkQxjIRqauziZnU/oW?=
 =?iso-8859-1?Q?1ElZyF68A7yq1KBfuV9DabCu6IMD8AguK8zCJjvcLZSqu7Z2jJSYQNLuEE?=
 =?iso-8859-1?Q?DgEXwbbkoXL4JZ613Txr5pAL46VGLi+0dkE0/wyTbWSMlRw0vVvLtP0FZQ?=
 =?iso-8859-1?Q?Wm9xGCXlrw+U/ran8lhM9r64M8Fojcv/Pa0foV9Yg1i711yDhRtkhbbzRD?=
 =?iso-8859-1?Q?h1NYWrDf86k7a93stGlVukQQBIMdmul+uhsPjsR2Vac2EMwXP6S5MM7f1W?=
 =?iso-8859-1?Q?G69qoKYh5ulTpyIp2uRuVeElVfB/b/mmXHrIw3obwsNS0wsUy35TBaRJsO?=
 =?iso-8859-1?Q?vWGouPcnKuk8wnA/YQ0HE0yM+vSjLbIn8a/VDcuCeGpHJ5xN88IMcVydZ4?=
 =?iso-8859-1?Q?S3rsZCBqlJyHFsUi1tlL5fZSbah+j461UP63Duq0skOuNk/o4H9YLUDFq3?=
 =?iso-8859-1?Q?7wyW2rHnV4h8INYF+1QniTIcsc8hLGJECyQl6LqdvpYK38QU11XU3w2DmT?=
 =?iso-8859-1?Q?sVZ21IzfZpWY1iSRsPjhRmY6y2yKoa6kKFNwX1JoSDTsxzh7v6YVlf5tOF?=
 =?iso-8859-1?Q?4DVOdjlu2VzgRWTRsIghWBtHpU6rnTfmuq/DFlu2gDBAvGdiVzcCiMFFCZ?=
 =?iso-8859-1?Q?sVt/FSz0qbnZd6vwPJPw78f+s3wc999fyhQ3l93vmV9YmAadBXG4qnnboB?=
 =?iso-8859-1?Q?Xrt1C+iZrJwYcgy2hTS/WMNM3e+aEbyZkUlbR2zG/rCe8pbgYS18ZbJH1K?=
 =?iso-8859-1?Q?711g3UO5fAKqb04LsruDYpSG24ppqbsp0gvcnlJGuED5qBFpVG2M0rA5Jo?=
 =?iso-8859-1?Q?Ggtb06I2IqGapPMYdhq2JI0J0X/sHLQhTbfUOq3CYYC/vQcuMxKGC63p5R?=
 =?iso-8859-1?Q?Yoyyi60jwJHElNjf0hKxK7rA16Qg0meDTT+8ch8+SPVaGoiQx2vWH8DUPg?=
 =?iso-8859-1?Q?D7YVNtlgv6mcR5nE5FuHJAzRf+bJYgH63u8vDXZY+dK6BWK7RVSWvtxSpc?=
 =?iso-8859-1?Q?pvjwmT33fLnAdybCJY/IS6NPcAr6OK5D/G?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6bd59a-eb34-4ea7-9233-08dabb31751a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 11:17:11.8501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBaSV0JMqueEl5FfY+Lz1y+Zv93y77fyT3LZIJQHfRXQbQsfbbWAdgZKEmbyXAy5L9YN7z+Q70BhTgMwssc1dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6635
X-Proofpoint-ORIG-GUID: YfF1aM4qeoSLNPcMQzedlETr0zcgPj_J
X-Proofpoint-GUID: 9pbHIuThyB7eM2aFUKINjGD651uTrynY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
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
> Sent: Sunday, October 16, 2022 7:10 PM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Subject: [PATCH 5/5] iio: adc: cc10001: Switch remaining IIO calls in pro=
be to
> devm_ forms.
>=20
> [External]
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> As everything else is now handled by devm managed releases the
> triggered buffer setup and IIO device registration can also be
> moved over to their devm forms allowing dropping of remove().
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/cc10001_adc.c | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.=
c
> index b0daaec7ff16..ab71004ea8f1 100644
> --- a/drivers/iio/adc/cc10001_adc.c
> +++ b/drivers/iio/adc/cc10001_adc.c
> @@ -390,33 +390,12 @@ static int cc10001_adc_probe(struct
> platform_device *pdev)
>=20
>  	mutex_init(&adc_dev->lock);
>=20
> -	ret =3D iio_triggered_buffer_setup(indio_dev, NULL,
> -					 &cc10001_adc_trigger_h, NULL);
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      &cc10001_adc_trigger_h, NULL);
>  	if (ret < 0)
>  		return ret;
>=20
> -	ret =3D iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto err_cleanup_buffer;
> -
> -	platform_set_drvdata(pdev, indio_dev);
> -

I wonder if it's obvious to everyone that removing this call as a consequen=
ce
of not needing  .remove() is clear enough that it does not deserve a mentio=
n
in the commit message?

Note that I don't find it particular important so I will still ack it and l=
eave it
up to you :)


- Nuno S=E1
