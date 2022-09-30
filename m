Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19DD5F05FB
	for <lists+linux-iio@lfdr.de>; Fri, 30 Sep 2022 09:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiI3Hsk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Sep 2022 03:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiI3Hsj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2022 03:48:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35EC1FCC8F
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2022 00:48:31 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U6LDvO003640;
        Fri, 30 Sep 2022 03:48:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jwu428frc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 03:48:06 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28U7MUHt030428;
        Fri, 30 Sep 2022 03:48:06 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jwu428fr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 03:48:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JODGztcbYcc71MVFzibU1kdBKRiIV0ziCfYdDOH/5QURS+dSk/eX2j4KtvtP4RmQYX0Iw7eIuNu0XpETqaIUf+bnolJOMJxJjiU0Me9XdezWyJETkjQSb2untCyY4yOX4bUha+hX33J/asukWgeQnD8Pej9lc/h9O8fuREkpcVMIUixcRVDVZI0FVT4JgfiHPiebhTSLaa2bFbguffC8jpIk0VjijkeJub52SS1AkyovHMwY/4x0b02mTtwG83aO2qERgtcxo/4b8/Rqq3zxshfG3MmOMhoaQVzZqNn0FFmtADEkeRoGrNlTINg5hY41B3Hqlhv1DDNG1N+YxiVjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XotgUM6AlUHVtZPVDCRJf+U6OpDm/xmgoBcP1QSaKJ8=;
 b=ccrar33OOLHPhOxHnqFYJMu+6v1Y09Wmt6ZVHhtgoRfr/JtSbmM4b8jVq7sVoeLBNCH40hoNyEzp5+i2H6K47iiAtA7MdjzzoDxpDa7PCaEKpKIyAfO91Ki2DTEIY+e/dQ/FnqmkaosNMkMtAKpZrUbj/IG8ik0xGJDBfSCBa85fxd08EqYccPqLYSvoSMgVcKFaBlvewTuevRcen+6GAjz32SQg0WCZHmtYlHLdIrCTDdvXSrWUD1lGjkwjBZhM+jvlvd+cUJ3muAn/Pf9vBAC6yMbxF+QPGRETu3Y36fRUplM2/mu6ZbaU0PraiNPQY5AYFLrULMOwEqgOgYvgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XotgUM6AlUHVtZPVDCRJf+U6OpDm/xmgoBcP1QSaKJ8=;
 b=hTr4JW3lVLOIKhtESXjdOSsO+RQfnEsRXqqq81EO4V95GxMaRLhLuIiw5/EBvQTDH1C4lbN6HdLOIkCR8qyUKPvHHdEcEMz7M871+aPKQwrrp5+f0dwsLb+UYci0SDAs4Vfw8VQ2AveEfr9n1Kxk7C8doPomDvyytG/S77sMpWs=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by MN2PR03MB4974.namprd03.prod.outlook.com (2603:10b6:208:1a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 07:48:03 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 07:48:03 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Regus, Ciprian" <Ciprian.Regus@analog.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: ltc2496: Fix possible null-ptr-deref in
 ltc2496_probe()
Thread-Topic: [PATCH] iio: adc: ltc2496: Fix possible null-ptr-deref in
 ltc2496_probe()
Thread-Index: AQHY0u0hNSJPcvZkYkKQIFeyvtXASa33m+cw
Date:   Fri, 30 Sep 2022 07:48:03 +0000
Message-ID: <SJ0PR03MB67786C9720517BAC816AAC5E99569@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20220928040949.581092-1-weiyongjun@huaweicloud.com>
In-Reply-To: <20220928040949.581092-1-weiyongjun@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMzQ3ZWExMDktNDA5NC0xMWVkLWI2YjQtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDM0N2VhMTBiLTQwOTQtMTFlZC1iNmI0LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTcyMyIgdD0iMTMzMDg5OTc2OD?=
 =?iso-8859-1?Q?A4NzI3MTI5IiBoPSJBaW1MbldlV1ZDOU54WmViM0ZrKzFUemhPVlU9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJaWXRuMm9OVFlBVVZVdjNGRTRrenJSVlMvY1VUaVRPc0RBQUFB?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|MN2PR03MB4974:EE_
x-ms-office365-filtering-correlation-id: fb7a95f2-a24b-48be-338d-08daa2b81abb
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sCAH8FaI7w7BUA6WvzFOBDcfGb640i17kCc8spZzq8yEuuF+luQS1J3KRYeIeMzBZwlK/KMRuI4Jddr/4oUqyzlfyQboi3cAD5rnfZp9RvvNx3fWP3YUpBw8kxqdKWVrTs09hVN41PS9nTIZYmgAoPyHIqrmf10+Nrl9y+w/AcLqCz8KGkm+usawFu9uNhSl6mugo25SnY1coAynDFPVb0ameuMqaom0UgxkuGSv8Af/ymDaJZuab/P+LZmF5FZvukpk//7x7XZo9kTBydgaItAXaa0rhgQWlcuVJb8opllcEH7vPBjvicduG56FASZATS58MQjiswcBMEvUMYLjoURXym7ds71UZnKgbF7X5Ne7GN9T/excqOtTREujBsmXb/d7ilQez8ptSBsj3wNptmx4vjFpTRraQ2zycYru1SxL7h+QtGkOP0zMDh6TgOuF1YtrvqxqTEaUFDxfwoCg3505X2PxEdmJ7UGoDH9js2r7sBc9U5PLT/ERUA9LU05RrGKQ1h886RyNg30+HttltN3FjgdkzBqn+flUc+Jh3kBbBB/ug9Kp5lb7CI/cdqF117aNSkn9LRYyR1gdKhnfmrOTUfo08JCSWzXXJGw9DJeKYX0q2/A76sN5JErReJP8bbBfndI+z4N3pUULLsVMp8zJkwDDoM/klKzgOOY4Tp5VtpV/JW9X5xfR3q+80yTjSQrGdHsJ3ZvYx6KKb5L8nn6tCEUkGgrF2OH+cSEqoZFsV6m05LKtbm4bNXZoifX1CklI0dWjxdy2o1hXCxLbxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199015)(71200400001)(38100700002)(122000001)(38070700005)(478600001)(52536014)(316002)(6636002)(6506007)(54906003)(110136005)(41300700001)(7696005)(4326008)(53546011)(66946007)(66556008)(66476007)(66446008)(5660300002)(33656002)(64756008)(76116006)(83380400001)(186003)(8676002)(26005)(8936002)(9686003)(2906002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nBHQ8btkMLUYALwdldUkV4ZoA9HO66Qm+LquZOxxopiJyOTOEGbGqVi7yr?=
 =?iso-8859-1?Q?O9WKGZbySjjZOE5YXjpKpmNsfs0VuPr71V6pAi09EAdCWyzU5P/CAc3EdN?=
 =?iso-8859-1?Q?M9BUCkoZkfq4Mt1HNHDMRONPMMiQbtJLqLX7P+OQnd+txoFPYJ+HyaY5QJ?=
 =?iso-8859-1?Q?b647tTftKJRPq3WGJea1Js9aiJA1JSd9zd5XquC/RdqV96uRRFnOe7tptj?=
 =?iso-8859-1?Q?/1nlJr8c8EiisvjhWI+mGC/3GWPW4H9lAwdTO/OBCRuhdRFBxQhAee2hPC?=
 =?iso-8859-1?Q?R6E65dTd/ZHynFuUBrkzKUYlmfG5iDAxl57TUKhnEp9mUk6B7le6B6XyYR?=
 =?iso-8859-1?Q?WP7V3eHQ0fNLfWh9kIpMZeWq7XBRcR29DIkse6kD4uzHkswET286UTlRln?=
 =?iso-8859-1?Q?IWsAWbJ5OGmcoZFMSi4rjSQ4KL/gRTy9L3YmKbLZ7cGleeEGcM7LOPTezQ?=
 =?iso-8859-1?Q?tSlpFV7ccz5azBmu+5qWtjHkF26YrkfZ0+Tq/g4WKM6n0jeGo9AUUyoTwN?=
 =?iso-8859-1?Q?djD/4iNbQq4KObsuooeOia8QfJostCcutHDLmYOgL5aUGQ7klxzWCKHL+h?=
 =?iso-8859-1?Q?+Ta0ylBSHHyDpRDdW3BRcFgSILF8x6lhUk7Z2zi25ak3yG5Mb8B0X1EqId?=
 =?iso-8859-1?Q?+YT7eGc6wQ/jpcQTbRxxDsQXq5EzAf0nBb0nm0gW9hAvFNhNjIFQdxAaT1?=
 =?iso-8859-1?Q?zGdXGdgz/wX26IeKSnlBU7O8KAI2/l7RTJRm9UtipHP3lmCNWZHs82j/gg?=
 =?iso-8859-1?Q?K/CsRbJLyZkIbKU24kRE/dCQjOJ7MhQso53i/ZvJ+maX/3tT8z3Z+ZiSFY?=
 =?iso-8859-1?Q?tW5PoXOr2a4JhiWbizw4SmlSvefOHygb7w7n+JfjUID7C5S+W3/7tGc3BO?=
 =?iso-8859-1?Q?pxGth7G037PtRDJHcEXJByVYbubDSOl07GEm83nqTyrc2CcpCQ3uowMQck?=
 =?iso-8859-1?Q?l6suVsosW2mgTwJD0k5ex7RSwGkKuw5vZwvRWsJ5tfZJiBATtKaoA3t+Bb?=
 =?iso-8859-1?Q?LJ8LIynhW9tBvaoEhe0w/JUrzLv0U2Tf+7fkvLsET1QiKUdVReHW7/nsY6?=
 =?iso-8859-1?Q?f4Yf+B18vEhj29dj7J1sSsBD9gVHwhpMmFB/11z2brhC2GcV2KE0RD3s+D?=
 =?iso-8859-1?Q?U7V0lJkE8owEhS3MZcGE3Fjde3MA3qxEwhmQ57uqtZykQ0XpoqV5jL3Nvz?=
 =?iso-8859-1?Q?QctsjMgxVaxbrxEFbfIawBufUV983rHG/4RB6llTxFpujL/gnRmeeXDINv?=
 =?iso-8859-1?Q?KTqa433yMm9ptuP49AeZgltaZ9ulq0F/Q3J2TG3bl0gwXBJsqY3TK1fnut?=
 =?iso-8859-1?Q?d6a0PWwZAXvnyiPy9kkJwDa4JDpkhP0sGHLP1U2s1MwkphIP64wQ0krHkJ?=
 =?iso-8859-1?Q?d8CoMQouNyxEj8C9UrbUn4igkaB17zWEq7oOiyaK7O9Gx+XrMI7kLfL5xi?=
 =?iso-8859-1?Q?cOXMHaR3Y4DvxKDYoxKa7U+GTWumxpMBsVrpEGi4QtRyvV7aPn4Mb7A1dW?=
 =?iso-8859-1?Q?1IRtI5hR1qM/hb8esvtQJ2OMVHNAamzTvSPlFJiG0GS6RNTvhDJKLAc/0M?=
 =?iso-8859-1?Q?EhbT1/G1u6m0xeQfmpGwVMJZK0ntYp4o/kqQ/wtkj6vlK77ACXLjs4kMi3?=
 =?iso-8859-1?Q?O1J/w9UAPUVs+aZu5oRgl++MeE+jeFJsVv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7a95f2-a24b-48be-338d-08daa2b81abb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 07:48:03.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56K8X7sY7/BpmUxJmrYdfh/mOAwRVNhbTYI/QyImoHjAKvVNfPwLKNM/ONXDI5itErhZ0dbaXckLbkASm1QRVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4974
X-Proofpoint-ORIG-GUID: P3_L61SNqmV7l2UjxCo1w9ekKeaPuoi_
X-Proofpoint-GUID: SX-W6cOddR37vqwg-kaLVVvzb6fauUdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=935
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300047
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Wei Yongjun <weiyongjun@huaweicloud.com>
> Sent: Wednesday, September 28, 2022 6:10 AM
> To: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> Regus, Ciprian <Ciprian.Regus@analog.com>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; linux-iio@vger.kernel.org
> Subject: [PATCH] iio: adc: ltc2496: Fix possible null-ptr-deref in
> ltc2496_probe()
>=20
> [External]
>=20
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> KASAN report null-ptr-deref as follows:
>=20
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 282 Comm: python3 Tainted: G N 6.0.0-rc7-next-20220927+ #153
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> 04/01/2014
> RIP: 0010:ltc2497core_probe+0x77/0x440 [ltc2497_core]
> Call Trace:
>  <TASK>
>  ltc2496_probe+0xf4/0x150
>  spi_probe+0x158/0x1f0 drivers/spi/spi.c:421
>  call_driver_probe drivers/base/dd.c:560 [inline]
>  really_probe+0x207/0x750 drivers/base/dd.c:639
>  __driver_probe_device+0x229/0x2a0 drivers/base/dd.c:778
>  device_driver_attach+0xb8/0x1e0 drivers/base/dd.c:1105
>=20
> This happend when probe ltc2496 device with spi device id but without
> dts, device_get_match_data() return null chip_info. Fix it by adding
> null check for chip_info in ltc2496_probe().
>=20
> Fixes: 1695c52a1260 ("drivers: iio: adc: ltc2497: Rename the LTC2499 iio
> device")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>=20

Thanks!

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

