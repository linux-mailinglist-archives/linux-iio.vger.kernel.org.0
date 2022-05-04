Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA4F51A02E
	for <lists+linux-iio@lfdr.de>; Wed,  4 May 2022 15:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbiEDNHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 May 2022 09:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350140AbiEDNHS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2022 09:07:18 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641DD3B03E
        for <linux-iio@vger.kernel.org>; Wed,  4 May 2022 06:03:42 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2448sXLk031286;
        Wed, 4 May 2022 09:01:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3frxvb4vc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 09:01:01 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 244Csevg031873;
        Wed, 4 May 2022 09:01:01 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3frxvb4vbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 09:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kb8lLHee8FR8EEWb1ka9qm1ADjumXWPSfa92HRK1Z23TOgwP4BvZG+vPJr9MRXfMo4jDXiHRqHHRY/gk53w7vYL2uwNgSUuv97pujCbl5isopqNkhTz2h3/wT9G4p9immoA9w/91dDFgStR1cjcfrXJCK/h2vE24GF3tZQK2xVYxYenN31OW7wLsvKXLNVBzvVB+3y9ASKTzjkmBOoUYIXh2UlypkpDmQP9SG2U/3lhWsEA95MXRExYp+8Mfhv/3fj2TE1BANDCPvg9qua9zOfMv15GDa6iZB606ZzTQ7a3nSFsmMKZgxuMZ1oRxMcweULNVwndreJVd9N/G01fTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx61+iO0J7ml90AvvQuaBamWkZcD6A/XzoSmPkDRzog=;
 b=W8+7t6bd2QBjdZTMDRsuR8NpgKaTybHXqfTnRaqBhlnHdPybYME7aWIuWf4pe97wrwTr7PI5d3KF8oA5+xrC4F1TfhQ9jF40RgrFmwqiZGqZAlY4c+0dA6L2w00HSgEF3BzS/vspS4DHNZOCwZzemUXwYpMwYZwAnAERr09diIfObNHyX0yZDgWC0+/PL0afni9nISuP5gB+ZLRjE/rKhnBqNpe223FAApL44VEX71hT+YK8VzysIpVidP4J9CeAyqKWg9ZM6PldWwmv+YG2x1OEJPIwM4g/MYKVHcSQe9CKp1uf2oUS/fvkBetSytHv6KuNOCjfBE1ADPpFsm2emQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx61+iO0J7ml90AvvQuaBamWkZcD6A/XzoSmPkDRzog=;
 b=LphmBH8wgKuCoyBe0z58uu2NTUSYktuQd1qkMYcwXkZ0be6BrUvsQCJn2c/BT509k3tr/rtXLzxNGuJxlEedoBnDxHOJtOU/jIgvnuwZP2/WGSfPnK1405H1KDBf4CZ8F0XYORPgdW9nzvb3E24M6ORo2o1xVyz1m7Sr+7KRX+U=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by BN9PR03MB6090.namprd03.prod.outlook.com (2603:10b6:408:11b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 13:00:58 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::d4d8:c051:a366:8003]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::d4d8:c051:a366:8003%7]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 13:00:58 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?utf-8?B?TcOlcnRlbiBMaW5kYWhs?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: RE: [PATCH 00/92] IIO: Fix alignment of buffers for DMA
Thread-Topic: [PATCH 00/92] IIO: Fix alignment of buffers for DMA
Thread-Index: AQHYXssJBUPqWvjKIEm2yU43LpheWK0OqMrA
Date:   Wed, 4 May 2022 13:00:58 +0000
Message-ID: <PH0PR03MB67861B4A26E0297578E90CFC99C39@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220503085935.1533814-1-jic23@kernel.org>
In-Reply-To: <20220503085935.1533814-1-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE0ySTVPR001WkRNdFkySmhZUzB4TVdWakxUaGlaVFV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhETmlPVGhqT1dRMExXTmlZV0V0TVRGbFl5MDRZ?=
 =?utf-8?B?bVUxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTXpVM015?=
 =?utf-8?B?SWdkRDBpTVRNeU9UWXhOREk0TlRVNE56RXpOVFV3SWlCb1BTSXpaMEZ2WWtw?=
 =?utf-8?B?elNuWlpXWEJHTUdNNFRESm9RbTFMUWsxSk1tTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUlBSV2hNSzNSc0wxbEJaakkzVmtwdGNVSmpSbU12WW5SVmJX?=
 =?utf-8?B?RnZSbmRXZDBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4318d9a7-58c4-45fa-31f1-08da2dce21f4
x-ms-traffictypediagnostic: BN9PR03MB6090:EE_
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-microsoft-antispam-prvs: <BN9PR03MB60905FC918888B876257C92099C39@BN9PR03MB6090.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SeaqXZTFNNH/eYy1vm8BdXGJDXhxAm+evbDx1edPllb0KqinA0mgKIPIKy284Zlq+SeX+VLtHQUfreUE+DVnX6CR8Tr824GhXnxT4mmWHqb3TDSOqS2BudrXy16NduJN8oJRhBNfN5Kffj+lRNGhoQ4cmCLxS5sjwayQANsXmgGKIVMW000KHHbjtHGAOYpsAIX0+c27DX+659ldLXZTesD0z0l3xUYm71rL43BFxmjSbEtEmTK9/Uw6q3ja8YwPodB3Gg2J9QLntWq3WHb1rzhq7XffCAqDFfy/4iM2a1CbrfuCYXE/38J5ZMyPCNjM/xP8uYw+kLarUgv3eTA6gJ1GfAGak5GKZhVxdZouM1pEXlx6hKUw8GH0iqJcRnxnCKbRgEgA4Viu3SQFhSkVzhRJNvc1Bawt2dMfCXSLixYUioBxc48BusOydipiAby/Jafj4V2VfOnFRb1nngo9gTO1mkoOAoGA1u4eGunAew1dXIlFSWsvSfVOSY0qHynciLlrFUvj6D6i4fQypTfdHQIlkDgR1QCZvj9njIZJSdk3aIHvx7/npz72Pib+cI1rV3VgWi0maU7DFkzp/tOARTkn2OVaun4KPEPtCZ+KxqOY6nqhy8CpQhFNioBEINC0FwFUMcJJ4bgZy0mFuOLkWf9yf+E99/i+U0Skeq78XH+HrOKsgZi5hnLA/Si6BDwN2DPhzz9rHf1HDY4W9EkoFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(9686003)(26005)(66574015)(33656002)(66556008)(66476007)(64756008)(66946007)(8676002)(54906003)(66446008)(4326008)(76116006)(186003)(55016003)(316002)(110136005)(38100700002)(5660300002)(86362001)(7416002)(6506007)(38070700005)(8936002)(53546011)(71200400001)(52536014)(83380400001)(2906002)(508600001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGVrNmluL3BhL1pFRVJiWVVadTN4R1V6Mi9TMXNJK3dPUUtESjlVUDBQcEZr?=
 =?utf-8?B?WjQ3elBZS0xCMk5xdjVnTldFTTdEVHVMVWM3RTd0ZmFqNFhRbXVTVGphcEhV?=
 =?utf-8?B?Um9XZWRaOWF6eVlGWDI3MUxYSWwxS1ExbWZETU1CcGYrN0Z0QytRRUR0WVZJ?=
 =?utf-8?B?em9ubC9tSFFEelZhc2c2bGNRYVlydTFxZ3pOc3BjUFNvRm0yVmZYaWxMZFU4?=
 =?utf-8?B?ZjAzd3NVRzEzRVIrN3lmM0thb0w4L2pPeHVwbmtsZkVKSjQ2dnJKSzNSeURz?=
 =?utf-8?B?OWgvbUkrY3VpZlZHakVmQU5lSURaOXN5VHBwbDhGbFNkL1JEZUovSGhwc3lC?=
 =?utf-8?B?ZlYydFJsWUQ3V3pmd2doaVJlNGIxZG43MlcxOEFFWmNzR0ZPNzNmOFpvdGpE?=
 =?utf-8?B?VXlXb21TaE1Kc1dZSkxqazdwVVh5MXprWWJaMnhkZWdIL3U3dFFSSzE2a0Fk?=
 =?utf-8?B?emFHdmg1K0ZnNmptQnVGVVJvWHVBZ2ZQN2h5MGw5M2w1Y0pLOHVkUmEvcm5s?=
 =?utf-8?B?dDRBVW0ycmVsZ1NQT0FqVEkvNm9VVkFmYjVad09QaUFrdVNETVpMaFg3NDc5?=
 =?utf-8?B?MzdqRlJvNTJGY0g5MWVuSUxzdlhmM2tDeWo0aHZxdnc3ek5NaGdLRzNCUGMw?=
 =?utf-8?B?aGdsRWZIYk8rbEZvOEROZHgwNjdpNU41SzQyalp4MWJ6NG9jYUFDL3BRenVi?=
 =?utf-8?B?MW5PbkNlOWNZcERCQXhmZGRiR1lra1RRZm4xM1NmZlJrWlF1enZHS3Jnc3Ju?=
 =?utf-8?B?dkVKSkdQL1FDZlovWmRXYlhEZ1k5TnFNdWZ1WXA3bUFSZEhVaWN2RVRsRUYv?=
 =?utf-8?B?SUVCNTJwalhHMFl6NmVWdlBoR2M0b2VnVWFBdDBmVmNzWFVyOE0ycCtFelJ5?=
 =?utf-8?B?c05ZdDdCemJ4YkVjZjVsSk0yRmxqWE9iejBCelBlejVsdFlVVmRwWGJtL0lM?=
 =?utf-8?B?MzZhb2ZEd0hyL1FGSkpwakpVU2RIVkdEb2VBcHZQV21WSEhWMDJkMjVUR2Y0?=
 =?utf-8?B?Smc4WElsMlVhb0tPZHZYTnVleTBnTzFHd2hmL2VINW1mdUZiZ3RFMTZSMjV4?=
 =?utf-8?B?YVlIN2J0c3Y3Wmx2Umh1c0psckZLa296c3FwN1FxU2xqWnZic2p0V0F6enZP?=
 =?utf-8?B?UE5PZWN6aVpCSkZjWmlsekdSYWFPVVlDTVdxaVVlL2ptYUtPZzhtWXVTb2Jk?=
 =?utf-8?B?cUF2Z1pLQVlLWGk0N1I5cTNsNnpCMHVRVFYwUnVnQy9lZUh2RUhCUm1FRUUx?=
 =?utf-8?B?TTNWZHd3TE9sVm9oemdaVi8zSWtwTGljZEIxUFBtRThJRE1lUVQyMklmTWY4?=
 =?utf-8?B?WUJwQXhzRUdWcnNvS29qekI5K0twMDU1R2d5ZzVKaEVvOEFvSWtoTWwzRmNO?=
 =?utf-8?B?WFI3THYvemdtVGJ0TlNVK2h1cStuSzR5ODB3amM4M0VRNXJRbysxNmFiTElB?=
 =?utf-8?B?c28zcEt4WkVZcE1zMGhiNWQzem5tU1d5V0kvOTRZYVc5UUNIb3UyTmdJUmJN?=
 =?utf-8?B?V2FCMlNna3oxUU1IUTQ4bGVObTZTeDB4QlcvaFZtempENU9WY3JKbUlrcFlT?=
 =?utf-8?B?NXA5bTh2Tkp6VEc1TFRUbXlCbml2eDdZWlZmZ3JDc0IzUEpnVHd6Tm9ZMnU0?=
 =?utf-8?B?VlR0eVVpUHgxUmcvT3dHWjFlTk1PdjZnQmZjN2FDRkZtTmZyT0cyWE1EMGd4?=
 =?utf-8?B?RFBsRGp6YjBUYlI4ZWQ0Y3VJYmdxenRqMEtaNzltWFJ3YU42Q0s2ZUlhNVhi?=
 =?utf-8?B?L1RQZE9VU2p5Z09vRHhHZCs0d3NqMC9jMTFSTUl0bW5EdXVjZFMvbHhvQWVM?=
 =?utf-8?B?T0xocXV0RjlzU0svZlU4UmJQQTdkZjBPUGpIY29xL2xLemlWdm1sMTZBaExB?=
 =?utf-8?B?KzRtYzZwN2V5bDZwZzhJTHVNa0x1Tzd2REFGdktDTWhnRXNiL0w0TFhremJy?=
 =?utf-8?B?NUIxMzV4SENYTjIvRnA3NEVxa0l6OUgvM2VqQW9hVzBvWndodkR0by9KYnQx?=
 =?utf-8?B?OTE1V1QvOFozTFFmamhXL0xGRWFKMUJhSjB1Y3dKNEVNYWxuLzBvTW4wREd0?=
 =?utf-8?B?eEQvN2FZd2hIZUtpUVh0U0xHcUFtQ1N3WGNRc1N5VlRodUhaRFdUTGZXQSs3?=
 =?utf-8?B?WXBwT2dsdTBYNjZVMU11NTJJcGFJU2Q1TGJpc0VJSTBVU2syOUhPWmliVHgy?=
 =?utf-8?B?R210Slc2YURDQnE0dDB4b0FxTGRwZDJOdWZIU0ZXMGFYcjFSZlNwaDJ1Z3Zh?=
 =?utf-8?B?VVVOd2dRbW9KQzRtcEZpK3ptMUhkZzZXNHJPTy9RdWtsaTFqRDkxR3FEdDVz?=
 =?utf-8?B?ajRWSWkvNlpxNWNTWHppWkNLRnh4WERWZzVTT2hrd2U0RTY5R3Qzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4318d9a7-58c4-45fa-31f1-08da2dce21f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 13:00:58.2198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwIIps/9dr1znW6hx6eUrOwiT/9A9wk2jyQYiqu2UrzMJkQdCMCuucFo+8SLBBFnddIAX72Zz1aImSklpEVavw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6090
X-Proofpoint-ORIG-GUID: upJFfsLE7hlj0igj62AKCQ9U9eubJ7OB
X-Proofpoint-GUID: GhBRT1F-3NH7wdG-KiWhUtP5gDx_6vQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 suspectscore=0
 bulkscore=0 adultscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040084
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9y
Zz4NCj4gU2VudDogVHVlc2RheSwgTWF5IDMsIDIwMjIgMTA6NTggQU0NCj4gVG86IGxpbnV4LWlp
b0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFraW5vYnUgTWl0YSA8YWtpbm9idS5taXRhQGdtYWls
LmNvbT47IEFsZXhhbmRydSBMYXphcg0KPiA8YWxhemFyQHN0YXJ0bWFpbC5jb20+OyBUYWNoaWNp
LCBBbGV4YW5kcnUNCj4gPEFsZXhhbmRydS5UYWNoaWNpQGFuYWxvZy5jb20+OyBNaWNsYXVzLCBB
bnRvbml1DQo+IDxBbnRvbml1Lk1pY2xhdXNAYW5hbG9nLmNvbT47IENoYXJsZXMtQW50b2luZSBD
b3VyZXQgPGNoYXJsZXMtDQo+IGFudG9pbmUuY291cmV0QGVzc2Vuc2l1bS5jb20+OyBUYW5pc2xh
diwgQ29zbWluDQo+IDxDb3NtaW4uVGFuaXNsYXZAYW5hbG9nLmNvbT47IENyaXN0aWFuIFBvcA0K
PiA8Y3Jpc3RpYW4ucG9wQGFuYWxvZy5jb20+OyBEYXZpZCBMZWNobmVyIDxkYXZpZEBsZWNobm9s
b2d5LmNvbT47DQo+IEl2YW4gTWlraGF5bG92IDxpLm1pa2hheWxvdkB5YWRyby5jb20+OyBKYWNv
cG8gTW9uZGkNCj4gPGphY29wbytyZW5lc2FzQGptb25kaS5vcmc+OyBKZWFuLUJhcHRpc3RlIE1h
bmV5cm9sDQo+IDxqbWFuZXlyb2xAaW52ZW5zZW5zZS5jb20+OyBMYXJzLVBldGVyIENsYXVzZW4N
Cj4gPGxhcnNAbWV0YWZvby5kZT47IE1hcmNlbG8gU2NobWl0dCA8bWFyY2Vsby5zY2htaXR0MUBn
bWFpbC5jb20+Ow0KPiBNw6VydGVuIExpbmRhaGwgPG1hcnRlbmxpQGF4aXMuY29tPjsgTWF0dCBS
YW5vc3RheQ0KPiA8bXJhbm9zdGF5QGdtYWlsLmNvbT47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8
TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IE1pY2hhZWwgV2VsbGluZw0KPiA8bXdlbGxp
bmdAaWVlZS5vcmc+OyBNdWdpbHJhaiBEaGF2YWNoZWx2YW4NCj4gPGRtdWdpbDIwMDBAZ21haWwu
Y29tPjsgTmF2aW4gU2Fua2FyIFZlbGxpYW5naXJpDQo+IDxuYXZpbkBsaW51bWl6LmNvbT47IFNh
LCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+OyBQYXVsDQo+IENlcmN1ZWlsIDxwYXVsQGNyYXBv
dWlsbG91Lm5ldD47IFBoaWwgUmVpZA0KPiA8cHJlaWRAZWxlY3Ryb21hZy5jb20uYXU+OyBQdXJh
bmpheSBNb2hhbg0KPiA8cHVyYW5qYXkxMkBnbWFpbC5jb20+OyBSaWNhcmRvIFJpYmFsZGEgPHJp
YmFsZGFAa2VybmVsLm9yZz47DQo+IFJvYmVydCBKb25lcyA8cmpvbmVzQGdhdGV3b3Jrcy5jb20+
OyBSdWkgTWlndWVsIFNpbHZhDQo+IDxydWkuc2lsdmFAbGluYXJvLm9yZz47IFNlYW4gTnlla2ph
ZXIgPHNlYW4ubnlla2phZXJAcHJldmFzLmRrPjsNCj4gVG9tYXMgTWVsaW4gPHRvbWFzLm1lbGlu
QHZhaXNhbGEuY29tPjsgVG9taXNsYXYgRGVuaXMNCj4gPHRvbWlzbGF2LmRlbmlzQGF2bC5jb20+
OyBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUtDQo+IGtvZW5pZ0BwZW5ndXRyb25peC5kZT47
IEpvbmF0aGFuIENhbWVyb24NCj4gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT47IGNhdGFs
aW4ubWFyaW5hc0Bhcm0uY29tDQo+IFN1YmplY3Q6IFtQQVRDSCAwMC85Ml0gSUlPOiBGaXggYWxp
Z25tZW50IG9mIGJ1ZmZlcnMgZm9yIERNQQ0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gRnJvbTog
Sm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPiANCj4gTWFu
eSB5ZWFycyBhZ28sIElJTyBzdGFydGVkIHVzaW5nIF9fX19jYWNoZWxpbmVfYWxpZ25lZCB0byBl
bnN1cmUNCj4gdGhhdCBidWZmZXJzIHRoYXQgbWlnaHQgYmUgdXNlZCBmb3IgRE1BIHdlcmUgbm90
IHNoYXJpbmcgYSBjYWNoZWxpbmUNCj4gd2l0aCBvdGhlciBkYXRhIHRoYXQgbWlnaHQgbGVhZCB0
byBETUEgc2FmZXR5IGlzc3Vlcy4NCj4gDQo+IEFzIGl0IHR1cm5zIG91dCwgdGhhdCB3YXMgZmlu
ZSBhdCB0aGUgdGltZSwgYnV0IG5vdCBiYXNlZCBvbiB0aGUNCj4gY29ycmVjdCBhbGlnbm1lbnQg
cmVxdWlyZW1lbnQgKHRob3VnaCBJIGJlbGlldmUgaXQgd2FzIGEgY29uc2VydmF0aXZlDQo+IGNo
b2ljZSBhdCB0aGUgdGltZSkuICBOb3RlIHRoYXQgb24gbWFueSBhcmNoaXRlY3R1cmVzIHRoaXMg
d2FzDQo+IGludHJvZHVjaW5nDQo+IHVuZWNlc3NhcnkgcGFkZGluZy4gIFdlIHNob3VsZCBoYXZl
IGJlZW4gdXNpbmcNCj4gQVJDSF9LTUFMTE9DX01JTkFMSUdODQo+IGFzIG90aGVyIHN1YnN5c3Rl
bXMgc3VjaCBhcyBjcnlwdG8gaGF2ZSBkb25lIGZvciBhIGxvbmcgdGltZS4NCj4gDQo+IFBhdGNo
IDEgZGlzY3JpcHRpb24gY29udGFpbnMgbW9yZSBpbmZvcm1hdGlvbiBidXQgaW4gc2hvcnQsIHRo
ZXJlIGFyZQ0KPiBBUk02NCBTb0NzIG91dCB0aGVpciB0aGF0IGhhdmUgYSBsYXJnZXIgY2FjaGxp
bmUgc2l6ZSBmb3IgY2FjaGVzDQo+IGJleW9uZA0KPiBMMS4gSW4gbWFueSBjYXNlcyB0aGV5IG1h
aW50YWluIGNvaGVyZW5jeSBmb3IgYWxsIERNQSBkZXZpY2VzDQo+IGF0dGFjaGVkDQo+IGFuZCBz
byB0aGlzIGlzbid0IGEgcHJvYmxlbSwgYnV0IHRoZXJlIGFyZSBleGNlcHRpb25zIHRoYXQgZG8g
bm90Lg0KPiANCj4gU28sIHRoaXMgaXMgYSByYXRoZXIgbGFyZ2UgcGF0Y2ggc2V0IGFuZCBqdXN0
IGNvdmVycyB0aG9zZSBkcml2ZXJzDQo+IHRoYXQgYXJlIGluIHRoZSBsYXN0IGtlcm5lbCByZWxl
YXNlIGFuZCBpbiBkcml2ZXJzL2lpby4NCj4gDQo+IE1hbnkgb2YgdGhlc2UgZHJpdmVycyBhcmUg
c29tZXdoYXQgb2xkIHNvIEkgaGF2ZW4ndCBzcGVjaWZpY2FsbHkNCj4gY2MnZCBhbnlvbmUgc28g
d2lsbCBiZSByZWx5aW5nIG9uIHRob3NlIGtpbmQgZW5vdWdoIHRvIHNhbml0eSBjaGVjaw0KPiBw
YXRjaGVzIG9uIGRyaXZlcnMgdGhhdCBhcmUgYmV5b25kIHRoZWlyIG93bi4NCj4gDQo+IEdpdmVu
IHRoZXJlIGlzIG9uZ29pbmcgZGlzY3Vzc2lvbiBhcm91bmQgcmVkdWNpbmcgdGhlIGFsaWdubWVu
dA0KPiByZXF1aXJlbWVudHMgd2hlcmUgcG9zc2libGUsIEkndmUgYWRvcHRlZCB0aGUgZXhpc3Rp
bmcgSUlPX0FMSUdODQo+IGRlZmluZSB0aHJvdWdvdXQuICBUaGF0IHdheSB3ZSBoYXZlIGEgc2lu
Z2xlIHBvaW50IHRvIHVwZGF0ZSBpZg0KPiB0aGF0IGJlY29tZXMgcmVsZXZhbnQgaW4gZnV0dXJl
Lg0KPiANCg0KTmljZSB0byBzZWUgdGhpcyBpbi4uLiBTaW5jZSB3ZSBhcmUgaGVyZSwgSSBndWVz
cyBpbiBhIGNvdXBsZSBvZiBwYXRjaGVzIHdoZXJlIHdlIGhhdmU6DQoNCnN0cnVjdCB7DQoJLi4u
DQoJdTggcnhbXSBfX2FsaWduZWQoKTsNCgl1OCB0eFtdIF9fYWxpZ25lZCgpOw0KfTsNCg0Kd2Ug
Y291bGQgbWFrZSBpdCBzdWNoIHRoYXQgb25seSB0aGUgZmlyc3QgbWVtYmVyIGlzIGFsaWduZWQu
IEJ1dCBiYWgsIEkgZ2V0IHRoYXQgdGhpcw0KaXMgYWxyZWFkeSBhIGh1Z2UgcGF0Y2hzZXQgdG8g
ZGl2ZXJnZSBmcm9tIGl0LiBBbnlob3csDQoNCkFja2VkLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBh
bmFsb2cuY29tPg0KDQo=
