Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B424C5BEA2F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiITP1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiITP1a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 11:27:30 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EAD66117
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 08:27:29 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KEQbpK021293;
        Tue, 20 Sep 2022 11:27:26 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3jn80atgup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 11:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/wESrOEii6useWp/f0R6zytl6x02XlcY/3aDwPQsKp8isinLL8Basw/3LtHCRz51Vct/v5VFBmnQS3/dtrWNrowaAYEl1clxpKXLAtNa/fi+56gFPu9v2nidV/EeT4vyNmJlrSD6IApFd31skacCbaU2UilJJZGdjl7mbV1bPeihFoCwR6iw21kl6qTOQ5RQDmQfFYYylxgV7qRW4/43y3WsFEUpoa1nMIgJKt/8KHS9Xwt6rGkSdv85BF+5sTbMBAu+dcrorymSFRAGG/N3vBy1L2zzRlSjCp8k85r1/2vkeBGr02GSmDkLBw0TQfTGNrM2JGegRCCgBdAMaichw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G93nJhMhqNbaUENMU1fDAdhzQDj9zPu5AgI8ZqY+FM=;
 b=R/mWMZNR5u9g6EDPFK4l5KKajJYdeEJD1SGcyrVVRmSONC+5Te6nOpIbIoJW5AOEGSd/Znq26VYzmylSI2Ay1dYgmEGseGHzeoF4nwhQEhN1N0q6f7VZhG6SVn2kFR1k9RhPy4A+VAnoElkhlhr771s/B84vzi+i/1Yf3IT//2LIhudmZrr+Bc3MxPq1wJ/rFsUp6eCv7FoVP2ItOGjcDNlR1uEeNlPNnLOhO9XGNeMJHtD3GlkUGaq9gGPmYmOpKeZLfUpNR+jWaKX/awCl2LRpeuYPo/lKdZlh3DlPGDE1GrZSff+cFxqR3cxAsAH6SZjJMttG0pBGeH+s8RT2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G93nJhMhqNbaUENMU1fDAdhzQDj9zPu5AgI8ZqY+FM=;
 b=PdlgUeY45ewHtUpgQ33mkHZBxGYchqMFMF32WRaDIWZ987ulu7/8T+JIlbyrfu68B3q7n+k/N6IlLRlz06vMLby7krBAnKCNoBZJ7AEuC9/lN+qwxkUwdEaTPFMu4ZXsSeIBF/k9QxG24dcEjmSV/j/G6kQD9n92iF4sLGLb9Wo=
Received: from DM8PR03MB6247.namprd03.prod.outlook.com (2603:10b6:8:3b::6) by
 CO1PR03MB5729.namprd03.prod.outlook.com (2603:10b6:303:96::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14; Tue, 20 Sep 2022 15:27:23 +0000
Received: from DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::781c:6cba:d36:2971]) by DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::781c:6cba:d36:2971%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 15:27:23 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bolucu, Nurettin" <Nurettin.Bolucu@analog.com>
Subject: RE: [PATCH v4 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Thread-Topic: [PATCH v4 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Thread-Index: AQHYw5JP5vq0TCFqOUGKBsln0Je6mq3lXbOAgAMjZOA=
Date:   Tue, 20 Sep 2022 15:27:23 +0000
Message-ID: <DM8PR03MB62477EAB8BCF6862032B30C5964C9@DM8PR03MB6247.namprd03.prod.outlook.com>
References: <20220908144924.205547-1-Ibrahim.Tilki@analog.com>
        <20220908144924.205547-3-Ibrahim.Tilki@analog.com>
 <20220918162211.7a5ebdac@jic23-huawei>
In-Reply-To: <20220918162211.7a5ebdac@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaWJyYWhpbS50?=
 =?us-ascii?Q?aWxraVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLWI1ZjFhZWUwLTM4ZjgtMTFlZC04ZTVl?=
 =?us-ascii?Q?LTdjYjI3ZDcyMzFhYlxhbWUtdGVzdFxiNWYxYWVlMS0zOGY4LTExZWQtOGU1?=
 =?us-ascii?Q?ZS03Y2IyN2Q3MjMxYWJib2R5LnR4dCIgc3o9IjgxNzAiIHQ9IjEzMzA4MTYx?=
 =?us-ascii?Q?MjQwNzAzNjg1OSIgaD0iczBhaEo5S0wzd2tyTUhWNlBnd3NXVXVjRnMwPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?RW9DQUFDN1c2aDVCYzNZQWRLMlo2bmkvdEtjMHJabnFlTCswcHdEQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQVFBQkFBQUFYNWwyS3dBQUFBQUFBQUFBQUFBQUFKNEFBQUJo?=
 =?us-ascii?Q?QUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFk?=
 =?us-ascii?Q?QUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxB?=
 =?us-ascii?Q?R01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpR?=
 =?us-ascii?Q?QnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFI?=
 =?us-ascii?Q?QUFjZ0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIv?=
 =?us-ascii?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR03MB6247:EE_|CO1PR03MB5729:EE_
x-ms-office365-filtering-correlation-id: 9929f8c2-bbf5-48c8-53e1-08da9b1c9da7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KPlf4nCC+kdrUWwNb1NtIb30jAxezmQkToIebzDkAJG5q/22ctdkZMmuHlNFvmVjcgu12QryvJx0Hs1cY3Ii+nHfyvJfnCpJZ0cZc36KpDh8HYoY/+7Hy//JDSGqcYRN09kkHXOBKq02i0cO2QDf2dIhwYDqOd6obgH9bQI5gSVWoK3EmCoxyEnsUlsyAMFS8fWvy50LI0irTKDUJBHRGBo7J/DuCWF3gTQeOwv/8DwKYPdwWJ82RrvX9n602hQQk6AiFFQfixNcYzlXsZ3dRAOGz1xT3eWqVDxDVPtNmI+4FeIniMrUmR0yB+652+zELYVUKblm9+5e9KxjmJacobxaGTCXKbaSC0pOumQmGmM0Rj+Qpflp9LFjyusFcJtYeE//unH6r3E9qsIABT0Y2RjHjy5HKujh5Rv4YiaAXu1xYhm5shCHSE1pbWcjdYs/1s9pkpAt66/+lvCXsLh+McLNOiKh9S5U+d2bJ2GOPx+sZFXdM7EJuszvX1eWLteoR1QgiXCa9W2/+IyM9CvUHufS28hB6OHsWiPB43n720vUETcCZODbXqTIi0C8FbI/HCEYpSvN7xAABL5LJkGUELWwERYB0wF9UHmwyIB+ZCMRISLxZ/36kMa0qVam7+J4UCSI8DP0NelTJazS4YUwC8WYQkFImDzFkXgx6iDCtmXF2WSoI+JHfouekdx7kyYwn3jlJU7WMuQxXiKxi6P/TioVflAxWUppIKwY/vn6DL4tP9oFAWz7p7JASpyq8P9+rbKH5SSUQzP/0aw9xxVERIq1AGj5aLOzO/PB45p34QAd+gd6fdUpDg14hVC2rjvDo7Q+7ZZaU0hAcaoqAKzSWlk7bDSyjQaNqlZB44IEuPk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6247.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(2906002)(966005)(5660300002)(38100700002)(52536014)(8936002)(478600001)(316002)(122000001)(107886003)(33656002)(6916009)(54906003)(86362001)(8676002)(64756008)(66446008)(66476007)(66556008)(4326008)(66946007)(76116006)(55016003)(71200400001)(41300700001)(38070700005)(6506007)(7696005)(83380400001)(186003)(9686003)(26005)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qtd+QS3WWGhulUDoi95yOjIs6EtEJynbHU/Glc3QNTESvKPoB71pRfr4PDy+?=
 =?us-ascii?Q?I9JubkZe9+hlxW/SOXCdSE5i2F/rzFcePcI8tPAKgB0uCUq9oRoWFLVQTX/q?=
 =?us-ascii?Q?TNpbm0qcAo+uNNkEKS/f18i8KWddeShlqvK+Aw5env/28mf7DYvhkehxnD/h?=
 =?us-ascii?Q?A8WoONH168d/8B+VrVohA8AzoFXirU51KaMWnGVRoWS16EXitH74He13/nhq?=
 =?us-ascii?Q?KOIQ4U73e/owJnX79snAXp24D1bzJPArHAGslW+wyiD8XNLoUHajPuVgxHaD?=
 =?us-ascii?Q?bQmwaFXwEwJqkP1dRyuByRTXudVh8J8K52LZjRyvOrWEbkrg9N/zPe3WcZVU?=
 =?us-ascii?Q?3bwbX/04cJScHy0wzs4KYnZwHUByVvD2Zv06OvmkzCcFJ0iNuwrI5yj+J+fB?=
 =?us-ascii?Q?XwwVsB9j4Q1mm9A3k3I6Myq6DpdzO924PkgWIZWcHvdfp8Vp14Ca9LfbPUBM?=
 =?us-ascii?Q?WlN0yiq1AhcX8DN1sdnGKyGVP15ghIP5EqmA1dEw0kUtqZM2V5QW4wv5W0Hq?=
 =?us-ascii?Q?DW46tIs3xjQ5JHv0mgKFvsHRCrG477oozIV8CV0RsmaDHwp2L/mZbaryaxAW?=
 =?us-ascii?Q?GKM5uMJkSBbjwG6SuwDFklYhYGHoUEqz1S8OUtTcBzCvng0+lfXqhhPxPKc8?=
 =?us-ascii?Q?swkjf/BgRT3lJ0hRRyiuXhpOiFHip7/5uGBfyQKSRF3W9fBIvnbIRpa9zk4a?=
 =?us-ascii?Q?mSywqZZ/0m6vlW60XxPjdGTcvbxOeR+Q7KsxRTrSPs+YJCA6eMOxAuhTBm+9?=
 =?us-ascii?Q?qS9eT9z3d7We4vW4CoNJXjOXUtxogzB1rZ+vMYs5rviH5DDVoApq/joouWAW?=
 =?us-ascii?Q?heL0OVT0D0GHeh365g2cR5VTBeesIIj01go7IaWGPJIb616X2N4ukcnu8+qa?=
 =?us-ascii?Q?f3QMR03SoEQ+UEaV3UUAeHLbQRqFrAnqMS86aewvievYwtxtaQY792n50vMo?=
 =?us-ascii?Q?a92i9NlU0f0866eKZs6mq0KyRMJPGAixJ80h/K+WJ2kaLAAOViyPRKDI6vNS?=
 =?us-ascii?Q?FXxJiWSEJB8xyQMMwjt02UxY4oseVTCRV04BAhGbKpBQEd1ylcZpjAhZG825?=
 =?us-ascii?Q?KoEeaIu+apk6xPr8PpWHg2hUEZC1L11QZTu4KJM93J2GgCNRChGU7lnzAmC4?=
 =?us-ascii?Q?6fER7yxr6GxueinBP3uYWWkRHzz3dQq9nBsQ1YA7VCAki9/D7suwYzzzes1M?=
 =?us-ascii?Q?WxpZ90t77vZvE5xRbg5Yfsypwe4je7YssIm0sdNgPu5vcTn+ZwiYqpUzICfT?=
 =?us-ascii?Q?Lozk1PSMYMav5qM52+hC6EhBzOzV5u1tYICbbH82Z9qDWTXRXkdZk3HROeQw?=
 =?us-ascii?Q?kzwlBay+PfLMferp7Cn6OL1QxPurAmHc/zK6e+LKEQ5dj/RsAYzofAbYlYuB?=
 =?us-ascii?Q?0026T6oSL9sQH4yzEjB6fOzvc7gktxGT+umnMtoMqQT0Hm6WdFT2M7eRxPfP?=
 =?us-ascii?Q?NDMujRcLwwx+9AHB7rUT14UhMrFm1hfDVtLYQQl4sAsmwl0vlTkiqiLbLl+e?=
 =?us-ascii?Q?ZiT5YakuOMOUdeZBnNS/pYsq0VilrWD30xBCrXvnMWboIYiHkSBlszXBwhiY?=
 =?us-ascii?Q?CkvVdOp/xtwTXdS/6pRkz2c4enVK9y2F8FaysuGN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6247.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9929f8c2-bbf5-48c8-53e1-08da9b1c9da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 15:27:23.2412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s220IhXlEw3LEjQdcBe1m5xoqhZXvZMHHYX4XnrfiXwHYem/+WSL+VnWgFpnyCCacjjH8hT6KcmQAlnVjOkopbMwnb284PB+xkuGk28KcJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5729
X-Proofpoint-GUID: iADf1WUGlNMaWsfg4pXWoN3DMfeAZCy4
X-Proofpoint-ORIG-GUID: iADf1WUGlNMaWsfg4pXWoN3DMfeAZCy4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=762 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200091
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> On Thu, 8 Sep 2022 17:49:23 +0300
> Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:
>=20
> > Adding devicetree binding documentation for max11410 adc.
> >=20
> > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,max11410.yaml        | 174 ++++++++++++++++++
> >  1 file changed, 174 insertions(+)
> >  create mode 100644=20
> > Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> >=20
> > diff --git=20
> > a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml=20
> > b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > new file mode 100644
> > index 000000000..3ffab284b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > @@ -0,0 +1,174 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright 2022=
=20
> > +Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id:=20
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/iio/adc/adi
> > +,max11410.yaml*__;Iw!!A3Ni8CS0y2Y!9LhA6Qy9HXqdtKQfrUEeHtQ7xhm_bIEYwWU
> > +8CyFFP9qvWNxJ5EE2jJ90UG_gph6M7EecEx_r5PuFIsbL$
> > +$schema:=20
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> > +aml*__;Iw!!A3Ni8CS0y2Y!9LhA6Qy9HXqdtKQfrUEeHtQ7xhm_bIEYwWU8CyFFP9qvWN
> > +xJ5EE2jJ90UG_gph6M7EecEx_r5ClUIiuZ$
> > +
> > +title: Analog Devices MAX11410 ADC device driver
> > +
> > +maintainers:
> > +  - Ibrahim Tilki <ibrahim.tilki@analog.com>
> > +
> > +description: |
> > +  Bindings for the Analog Devices MAX11410 ADC device. Datasheet can=20
> > +be
> > +  found here:
> > +    https://datasheets.maximintegrated.com/en/ds/MAX11410.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max11410
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
>=20
> Why?  If someone wants to wire both lines, they can do so.
> Then it will be up to the driver to pick which one to use.
> Given we have names, we will know which is which and be able to pick our =
favourite line to use.
>=20

Done

> > +
> > +  interrupt-names:
> > +    description: Name of the gpio pin of max11410 used for IRQ
> > +    maxItems: 1
> > +    items:
> > +      enum:
> > +        - gpio0
> > +        - gpio1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  avdd-supply:
> > +    description: Necessarry avdd supply. Used as reference when no exp=
licit reference supplied.
> > +
> > +  vref0p-supply:
> > +    description: vref0p supply can be used as reference for conversion=
.
> > +
> > +  vref1p-supply:
> > +    description: vref1p supply can be used as reference for conversion=
.
> > +
> > +  vref2p-supply:
> > +    description: vref2p supply can be used as reference for conversion=
.
> > +
> > +  vref0n-supply:
> > +    description: vref0n supply can be used as reference for conversion=
.
> > +
> > +  vref1n-supply:
> > +    description: vref1n supply can be used as reference for conversion=
.
> > +
> > +  vref2n-supply:
> > +    description: vref2n supply can be used as reference for conversion=
.
> > +
> > +  spi-max-frequency:
> > +    maximum: 8000000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - avdd-supply
> hmm.
>=20
> If explicit references are supplied and used, then will we query the volt=
age of the avdd supply?  If not, it doesn't need to be supplied. Power is n=
eeded but it might be coming from a fixed regulator no one bothered to put =
in the device tree.  Perhaps we just don't care about that corner case?
>=20

That is correct. If all of the channels use external vref, then avdd-supply
is no longer required. It is fine by me if we ignore this corner case.

Current driver checks for avdd-supply unconditionally. Maybe we can change =
the
driver so that it results in error only if one of the channels use avdd as =
reference
in the absence of avdd-supply?


> > +
> > +patternProperties:
> > +  "^channel(@[0-9a-f]+)?$":
>=20
> name isn't that flexible as we only allow reg 0-9
>=20

I changed it to "^channel(@[0-9])?$" in v5 but will this allow us to define
more than 10 channels? Sharing analog inputs accross multiple channels is
supported by driver. But I don't know how to correctly specify it here.
For example following configuration is valid:

  channel@0 {
    reg =3D <0>;
  };
  channel@1 {
    reg =3D <1>;
  };
  channel@2 {
    reg =3D <2>;
  };
  channel@3 {
    reg =3D <3>;
  };
  channel@4 {
    reg =3D <4>;
  };
  channel@5 {
    reg =3D <5>;
  };
  channel@6 {
    reg =3D <6>;
  };
  channel@7 {
    reg =3D <7>;
  };
  channel@8 {
    reg =3D <8>;
  };
  channel@9 {
    reg =3D <9>;
  };
  channel@a {
    diff-channels =3D <1 2>;
  };
  channel@b {
    diff-channels =3D <7 9>;
  };


> > +    $ref: "adc.yaml"
> > +    type: object
> > +    description: Represents the external channels which are connected =
to the ADC.
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel number in single-ended mode.
> > +        minimum: 0
> > +        maximum: 9
> > +
> > +      adi,reference:
> > +        description: |
> > +          Select the reference source to use when converting on
> > +          the specific channel. Valid values are:
> > +          0: VREF0P/VREF0N
> > +          1: VREF1P/VREF1N
> > +          2: VREF2P/VREF2N
> > +          3: AVDD/AGND
> > +          4: VREF0P/AGND
> > +          5: VREF1P/AGND
> > +          6: VREF2P/AGND
> > +          If this field is left empty, AVDD/AGND is selected.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1, 2, 3, 4, 5, 6]
> > +        default: 3
> > +
> > +      adi,input-mode:
> > +        description: |
> > +          Select signal path of input channels. Valid values are:
> > +          0: Buffered, low-power, unity-gain path (default)
> > +          1: Bypass path
> > +          2: PGA path
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1, 2]
> > +        default: 0
> > +
> > +      diff-channels: true
> > +
> > +      bipolar: true
> > +
> > +      settling-time-us: true
> > +
> > +      adi,buffered-vrefp:
> > +        description: Enable buffered mode for positive reference.
> > +        type: boolean
> > +
> > +      adi,buffered-vrefn:
> > +        description: Enable buffered mode for negative reference.
> > +        type: boolean
> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +additionalProperties: false
>=20
> This now needs to use the new spi-peripheral-props.yaml
> https://lore.kernel.org/all/20220816124321.67817-1-krzysztof.kozlowski@li=
naro.org/=20
>=20
> Your series crossed with that cleanup / binding documentation refactor.
>=20

Updated in v5

> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      adc@0 {
> > +        reg =3D <0>;
> > +        compatible =3D "adi,max11410";
> > +        spi-max-frequency =3D <8000000>;
> > +
> > +        interrupt-parent =3D <&gpio>;
> > +        interrupts =3D <25 2>;
> > +        interrupt-names =3D "gpio1";
> > +
> > +        avdd-supply =3D <&adc_avdd>;
> > +
> > +        vref1p-supply =3D <&adc_vref1p>;
> > +        vref1n-supply =3D <&adc_vref1n>;
> > +
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        channel@0 {
> > +          reg =3D <0>;
> > +        };
> > +
> > +        channel@1 {
> > +          reg =3D <1>;
> > +          diff-channels =3D <2 3>;
> > +          adi,reference =3D <1>;
> > +          bipolar;
> > +          settling-time-us =3D <100000>;
> > +        };
> > +
> > +        channel@2 {
> > +          reg =3D <2>;
> > +          diff-channels =3D <7 9>;
> > +          adi,reference =3D <5>;
> > +          adi,input-mode =3D <2>;
> > +          settling-time-us =3D <50000>;
> > +        };
> > +      };
> > +    };

