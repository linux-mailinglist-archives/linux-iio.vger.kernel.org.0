Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB25424B5F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 02:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbhJGAuG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Oct 2021 20:50:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58846 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234538AbhJGAuG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Oct 2021 20:50:06 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1970fojK007552;
        Thu, 7 Oct 2021 02:47:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=NeASeQeoQ3FLHxgeh95k9PVWB/YpfOrDqPZ39nCrhjY=;
 b=ooZR/NLxRZwhddOf1lLdagEhUHZfU7Es8cWcYb8FIY8BiaoPLl4RLxTGteyi1g4dfS53
 QBOmsWlwG+KdFMuoNavZUWDv5Yexnd+CUQJye5A5jVFGhvdP1wq0Gq/lKaEJT/LNtpY+
 YBFxtUGPpui9JYNJGjrtH6cAk2P7+K9EjGm4VsuYKXZch63jszpHla1Av5UOD4CLIfyJ
 arsQMo0zIHqv3FmNXGtfdECaa95N/B8komZTvwBFjXks0y9NkqJWvPiB14cCDLcE4de2
 0erQ2MRyYRkG3O58gKLmGz1YcyFFvTE79BfgZRkuvSQ1z1yTVRgUW+xSajFizJI3KZl5 Kg== 
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
        by mx07-00178001.pphosted.com with ESMTP id 3bhpjrr0tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 02:47:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnKo70zRH+/vL6BynrAC6h4G6jeRMsr8J6LFgfriFE8hTQ5UGViLB44R3lEOGYAtAHZb3CTpm/Gqpf8DQQQqtAhvP+SWpeA4oa40dXK0VIFQrkIWEvVv2k5bTHfbDesxbNfv1PjBigtmwYBHdpOE08ZEpjXXeYfh7+33xXtB5ppd8vqrtzw95du27MBxnPrZC4PXNJ/+xQutg1ZVREFTEQYPOUQaHaV/7msExaMEFRcOdTTmgdj/Vo1QzO8tDZIMOPk7l4+poXJSTCOHejnWnCDwGbTB6D3szUtEfEmytOgj84ljDAmOb32wn0HMZbbdk5kwVCMsjIoj6bsfnoWP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeASeQeoQ3FLHxgeh95k9PVWB/YpfOrDqPZ39nCrhjY=;
 b=NJ7ZsMKAL+yg84FGhk8UV3aMgPW1cJYLaXj7aGOCeAnDA9nBLFspk3+zA2zkbCtcf2m/BtdpT66jficEFumYMEDKKgi4Y6g+AR9IT56wmQQG6Q0Z93NlzncehLaX6gpCEM/9DJwAtLrHjWO8KYVmP1hHFuwniZVPfac2qVYqdDD4pjLQOO5BxujbzsjZoNrnnI4n/DzaQP4NdMKyGhZcjsScjCOF1L9IGtjb2VyuMg7wvf4Icnapeb78cHnlDI7JLh5Jkk+AnehKTucYVffDFPq1nsuHbvCjml1okyQMwzUIt2749DVwe5hYNm9bRD3o+2UeH7EA2POEwKjg4gMVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:360::23)
 by AM0PR10MB2738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:131::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Thu, 7 Oct
 2021 00:47:56 +0000
Received: from AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dca8:7592:14a0:7b96]) by AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dca8:7592:14a0:7b96%5]) with mapi id 15.20.4587.019; Thu, 7 Oct 2021
 00:47:56 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: st_pressure_spi: Add missing entries SPI to device
 ID table
Thread-Topic: [PATCH] iio: st_pressure_spi: Add missing entries SPI to device
 ID table
Thread-Index: AQHXs6WZbL2LZ5wAIUS0WAh/0vD5pau8zAIAgAAeRwCAASunAIAIq3Gg
Date:   Thu, 7 Oct 2021 00:47:56 +0000
Message-ID: <AM8PR10MB4801DB5353ADA0656510E920EDB19@AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM>
References: <20210927134153.12739-1-broonie@kernel.org>
 <20210930173852.208f1815@jic23-huawei>
 <AM8PR10MB4801DD2B605277F3D97CAF87EDAA9@AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM>
 <20211001121944.GA5080@sirena.org.uk>
In-Reply-To: <20211001121944.GA5080@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=st.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea4f018a-c295-4a22-cde3-08d9892c1a3a
x-ms-traffictypediagnostic: AM0PR10MB2738:
x-microsoft-antispam-prvs: <AM0PR10MB2738FBB0289C7AFB7FBF7BC9EDB19@AM0PR10MB2738.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q17VvlKZr39T6RdmRl6d9yszodAQNhcrI15Of27ro4YhZZe3opEid0NUN9JmYqGABZXU7VjfQYtvcL6Qi1Yb7D7KadAiyQb6BqXHNOnxYm7utdKxIvEJhNIotUtbv8I6FjCx4y2wI1J7Xxh0GD8p2XqTn3jOHj7UHCsW852F3oSM3Xbea2lWFZkwCxMPw2ix4zEwmxhRjYT2YQu75FRv/Zb5Z9WLc37uHEtPk2d8htZCASh1kC6RwA4lTQDhDla2C6IQmWkw9cWIQGI40Om1qK6oXQuPpQFxB7/ScWitBFLD3GxoYUqaPQcZMv1aimr6TY3IvvsQuwBdizJht7DvPjYer0aXcDaCPsxUnAq5M+lUuJkahzqapfhAtOrFuP4L/A4qUHZHxehi1oDMTrQSDvnsOR7wJY48yHFhTMwPZ1ne+uVmPQb3teS1YMnmRpc0l36uzgJnM2uvCP/ssCeROkprOWXUAdRScSglkJ0DiqD5/hez85rY5zU5RBa6TXQr7xT/0+f9WtmgCfwRwoG/zCKrtBXxxLrQ8Mfl9iTNFYe3K5CNXBwJSsimgPxE2YLU0lbyiCok4D3HfFmhV6omrZ7qgkNOrJRovofWQIhaadpd86L6CJ0949yexYoJ+LweD9/ZZdre6AcdGs+H3heXrS3apMgopD+XeD8niMA2spo/TfQarjbu841qe98FDyornvj/fDixkdwAco/KH81X0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(66476007)(38070700005)(122000001)(54906003)(64756008)(38100700002)(8936002)(66946007)(66556008)(4326008)(86362001)(76116006)(9686003)(53546011)(5660300002)(66446008)(8676002)(55016002)(508600001)(6506007)(2906002)(55236004)(316002)(71200400001)(6916009)(83380400001)(186003)(26005)(7696005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?53FKYx3NEBGEkPoiGtWHU/iT4K0vLXPLIsEaYmfT+FpVz//UIeHM5WXKvYA1?=
 =?us-ascii?Q?UUFW4cEhDZKlJc8lrqdhvXvcSvsO/nCjgvQInNtUiX10kOlJNKXh5ilzolPj?=
 =?us-ascii?Q?OKKpBe+Y3gzIWw0wCov7U6mFBB6TiK2IjZ+wgtUKYVGyDmTVN672arkv/ycu?=
 =?us-ascii?Q?LIszdmGP2+POi92jCnKxZXRoxe1pdvAcow+NEbHXIKGRaw0ZVG6EqAet9V6P?=
 =?us-ascii?Q?e6cQwaXzKlOMgrBhBmVcGcCfvx/xkIeb7kVaUQzYSRACEbV/TZ48pf7IS2FH?=
 =?us-ascii?Q?1S2XhZdCFxu9gadJZNhLk8VRkfxePt/F//baYQTTIlcjtY6rXLsLTD0iqaqp?=
 =?us-ascii?Q?cj2M/lceIjYa2lFOG9rjX9g6qA4UHmIVwWn1szwXM6kIbhfo/ExvRZenYHjl?=
 =?us-ascii?Q?Z2HasDMXycRVsLRX1p7zviEYA3G/7ox8EOgFMgTxtR0++n349ZEH60Zpv8MZ?=
 =?us-ascii?Q?/f7Vtim3ooaD3RIoXKY1UsUXa9rZQ/sRz+xk06TqwfcCduBLjcpsF6vet0o+?=
 =?us-ascii?Q?c7QLgn6F4HAeTvE1xEyNReYs9I6q1jqGef2ibULm5agX0O3tZh6HqaTCaKco?=
 =?us-ascii?Q?zOLMGqcb9OPbLiWFshwrQr/9VrDtWwepSgVdz5aJcFJEGX6w9JAHGSTqVtP5?=
 =?us-ascii?Q?HCrPL66yHJKdkvPmjsAh2U/+6lqZxmGL2ss+lp9C2QcOqJ5uBRgz0CgMavOV?=
 =?us-ascii?Q?LjRfdTIAG878b9pJ0GOJZqRlfAp62npscqoWU0o9Owv31gUHF1awJGCNj/Fr?=
 =?us-ascii?Q?h9ZsQfndk1iwJc4+7H6R3IDlPUufv8vidqKc11W+D6CpB7wE2Dcl4O4l3eLZ?=
 =?us-ascii?Q?sgzMiVaeDsj71aEPTY+h1HXtncYZioD8yEfuerAnLxmDmhw4xkIToTVfdR6P?=
 =?us-ascii?Q?QirezWZ0+WQ75SR7D9mmHdRLs/0lhf2mFjKs/dgzKBYe+2wuO+q+XgBio+fu?=
 =?us-ascii?Q?huPV8mo1yjgCb0A+RPyaV5SiWbZvkUhHXSKeAmB9/8eENn7S3vy3WSHhaNZR?=
 =?us-ascii?Q?1kBiYL9Y90GNT9vfp1kDOVccH9HEdj5o/pNxAh/OB88lyXWzgb8FIj2VxxX/?=
 =?us-ascii?Q?7tH5/GsFIuoA1gNdA8SV+Jd2HIZp2REBEkUxJguKi1QJvIopgz1KYQOIPE78?=
 =?us-ascii?Q?TasQgQT3QCO/YA2gaFf23iRoqgETNMRkt3lQDtBo3lHwZ9ZZxEsvMwVuNd5z?=
 =?us-ascii?Q?XBL9EEwTUlU9w7j/pSO+qMylEyVz+2IVvmYvovhX5wWPfgW7F5YoOHX69O9E?=
 =?us-ascii?Q?W3+MDqwkosHFLvtxBAcityW4XMzmosgo5nHDeD50Mc1gtFRYDmcO65N8Db/g?=
 =?us-ascii?Q?DBrZx43z46b0fU+lkYS6WM3V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4801.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4f018a-c295-4a22-cde3-08d9892c1a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 00:47:56.0835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBybImiHOtMOxpc/lUwEHiKyzoAANkLhBMo9JFUiBJ6clNnqjj53eG4bwj7C75/14ltZVxn2tPZRH/j8OetcQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2738
X-Proofpoint-ORIG-GUID: nXQeoezZ4fe3oEQb0fMliLE3OjYcr3aa
X-Proofpoint-GUID: nXQeoezZ4fe3oEQb0fMliLE3OjYcr3aa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 mlxlogscore=898 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070001
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, October 1, 2021 5:20 AM
> To: Denis CIOCCA <denis.ciocca@st.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>; linux-iio@vger.kernel.org
> Subject: Re: [PATCH] iio: st_pressure_spi: Add missing entries SPI to dev=
ice
> ID table
>=20
> On Thu, Sep 30, 2021 at 06:35:23PM +0000, Denis CIOCCA wrote:
>=20
> > I am not very familiar with how much the kernel would like to keep
> 'probing id' consistent. I perfectly understand the value of doing this
> (maintain ID compatibility) but I also see increase confusion in maintain=
ing
> half in a way and half in another.
>=20
> The goal is not to maintain compatibility, the goal is to be able to
> load the driver as a module on DT systems.  For historical reasons SPI
> uses the platform device IDs to load modules bound with DT, if there is
> no platform ID for a DT ID then userspace won't be able to find and load
> the module.

Ok now it is clear. I wasn't aware of that.
In this case it is good to me (I didn't do any testing).

>=20
> > I personally think that we should drop the '-press' thing for all the d=
evices
> since they all are single-chip (meaning that the name used identify
> univocally that is a pressure sensor).
>=20
> The DT bindings are an ABI, you can't really remove compatibles only
> deprecate them.

Yeah I guessed this was the case.

>=20
> > If you think that compatibility is more important here, I think the pat=
ch is
> fine but this should be done in the i2c part as well so that it's at leas=
t
> congruent withing the driver.
>=20
> I2C doesn't have this issue with modaliases so it's not an issue there.

Clear.

>=20
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
