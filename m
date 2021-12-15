Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC6A475E33
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 18:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbhLORIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 12:08:30 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31218 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235069AbhLORIa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 12:08:30 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFFu5gT023386;
        Wed, 15 Dec 2021 12:08:08 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cxemcxukw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 12:08:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXZZA/nU2EbEZ2WuYnghwBSaLEJwUGIoUTiFCHNVrT1rAOJxZWumWl5WttLw0ekZApYLXgJyrxIkptAs9hZdvrpwU6JKFplE7hEALf3EYwCLRZNFt1wgGex7eTQEKbEFOiAlIbqG36I6BtiW7Ny+MDba43W/rmdRm/yfzlWu2ev6rNUOZWwhKucN7i2YB/8/Y6tXPPRCibNFc3M6sSPk8JwFziW/JvXIJn2cFvDMK+j26fJ8No74+QwuiJIj+e+o5TkWSAJid0AznWtUmTK4xCgUuPJcmVSTFegaI1H7tTrAnPeqFE5jEqNMOSsgueofc9QOPPa/763PAOdlxNreLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TbNobxtDuuFoj7uz9pNNo3NyEMc72gDHsg/kg8ZHwM=;
 b=UalILSrZoWMiCSWvi7xe2kFEOtaniX1Ek03bDV2rwy2a4oKw85iCnojJ7vbsaqyZPzp+yHwq5Rel+e0AkcigLlT/dGY9CBKPByMms9OYNbeeulLb3kHOe/4LXS9rO9zRJk/hasth8FMrUMFCY4m58psEWF7WjNADTzq2MlX5kuvB19BPzozKl5FhE8r2vTCd8eAig4wbRMVxuqeDOakml2UC+byCVAi5UfRKJDcBELpWzwebtTPfP0h8qFXFZJQsC9tGW8Yp9OwYNz/c4vZWdEMJO/fZGDb4/s520bbASo2umHhuBDIV+sLKCby3pMb/ADT+2hhCVzGBc/npw2xNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TbNobxtDuuFoj7uz9pNNo3NyEMc72gDHsg/kg8ZHwM=;
 b=dkQx9iZpwWJTnNSLrRBtflGbjBWOgvF75iDgbgFjdxluTVJj8/Szl9Nz3VWwnmOWrkCcOFFdT5SB4TuyAsz8YhlI/51vUdg9J5Oh8HJUcjw1Uje59Xk54/MpvqQFmt3bWkb5rMQ9Mx0Tm3FL528gXPAslFPH/y2fzUSJD2jeTn8=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6722.namprd03.prod.outlook.com (2603:10b6:510:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 17:08:07 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::9cf:c1e3:ea42:f47e]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::9cf:c1e3:ea42:f47e%8]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 17:08:07 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 1/3] iio: dac: add support for ltc2688
Thread-Topic: [PATCH 1/3] iio: dac: add support for ltc2688
Thread-Index: AQHX8QuhEU7uaanqVkqKIBVDF63x2qwzWaEAgAAverCAAC37AIAAAXDA
Date:   Wed, 15 Dec 2021 17:08:06 +0000
Message-ID: <PH0PR03MB6786751455C73092ECCCD31399769@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
 <20211214165608.7903-2-nuno.sa@analog.com>
 <001b1c03-3d46-291f-e732-21514a9fd721@metafoo.de>
 <PH0PR03MB67862614BE38CEA3A5C5831599769@PH0PR03MB6786.namprd03.prod.outlook.com>
 <b6c526db-9a21-37c7-70bd-c4de708de566@metafoo.de>
In-Reply-To: <b6c526db-9a21-37c7-70bd-c4de708de566@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1tVTNOak0xTVRNdE5XUmpNUzB4TVdWakxUaGlZVE10Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhESmxOell6TlRFMExUVmtZekV0TVRGbFl5MDRZ?=
 =?utf-8?B?bUV6TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTkRBek5T?=
 =?utf-8?B?SWdkRDBpTVRNeU9EUXdOVGd3T0RReU5qZ3pNalE1SWlCb1BTSmtSazVOYkRV?=
 =?utf-8?B?MFZsVmxZWGt6VEZoSWNUaFBiVlYyYnpSSGIwVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSjRaU3RNZDNwbVNGaEJZakJVVlhvclN6ZEdURmwyVWs1VVVE?=
 =?utf-8?B?UnljMVYwWjBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: ce6a034d-a844-4c44-caad-08d9bfed76da
x-ms-traffictypediagnostic: PH0PR03MB6722:EE_
x-microsoft-antispam-prvs: <PH0PR03MB6722BFDA0946C06177BFD3EB99769@PH0PR03MB6722.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zke+6lFXd5rw2WP4dxfZhShI27gxw6fFfwsDA+ZFkOuentPcwVkX0yQ3A3zZPacUgVbv9Ieb78Nu7293RvsZTaQASkAZYJPq+BYg90x5OALAGB7RXyaNWK7kaCw0PAlaj63pnISXnbsNZKYdrLqb5CaBQqGND8QZ/ytIeobkvEjp7MbZ0K8BAlEdkfNAwmUGjOsGiBZx44EgKU1pTWWItMrQEtmPNpb5nfxd8LjKwh2jo5OEwF7lN8RsPAc7+0qi0CoGxEJQ+Gd8Gut7j5DrZDck5bo/FPb14ovGdNEmf5t2X6WzayvEiWAgxIJTS/MN5Vjh/ySpHyxVwUTLiDljlEdnd8/oluT5iw5LvIH1KfEslfzuVKP4GUK+UCdwVep2JLfoOwnvjZoukvCbhcQDSefAjJQI56nqdV8BU0Em83gt9SnxEmByzOFhyBtX824HNfuC3sy/1pWR9y8WChM681nmIeUTprxgZiyzqflFTIxCC9hhUpf9IrFbRYW5Gxy4epFWSwafbVy/oK/qauR0+2tZtjqgL19JgqQlFnGMQxWHbkkLLNku9RFqCYg5xZAjqBl/M8c1qLM3D3UamPVQcQUXtc8D6R60TL2tAlKq4NT9L8QpXO9N0NkAdcCGuoseVqhytGojgjtEGtc49NU3AB7rP62n1uj6lD5ZuyICJNziCHbnhUyN2dK0EQAT+t629vAQM21A7sXvdpOzUcczWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(33656002)(52536014)(55016003)(7696005)(4326008)(66446008)(86362001)(53546011)(64756008)(9686003)(8936002)(6506007)(5660300002)(38070700005)(122000001)(110136005)(2906002)(38100700002)(76116006)(186003)(316002)(66946007)(107886003)(83380400001)(8676002)(66476007)(54906003)(508600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnpqeEVYZzhjNFljczhlQUw3VXpjZTJwTXlJU0JldGc5YUg5Si93ckFBayt1?=
 =?utf-8?B?c3U5cU5WMTl5bFFzaWc4b1JNZVAxblZTeE9rWnBUZDhBSE55cGNrN2dWUzU2?=
 =?utf-8?B?dndtQTJkdUJLVVNncnNJZUwyNVkxbjJqNVFuWUhRMTJEazk4UVJSbSs0enhX?=
 =?utf-8?B?dnRvV2pzTzIzY2RHWU9pYkovRzF0OXpWRXNuTVVnV2toaVgzNE5FenNhNGEr?=
 =?utf-8?B?ZnllQnZySVRDWFM1TlN3N2lJL0cyTjlpekltNVhsMUFudWRZRlUvL2VndWpJ?=
 =?utf-8?B?V0xDcWk3UURaMzhpWWRhUHNicStyeHpvT2FpelVQby9BM2NXOWJZV2g4cHZK?=
 =?utf-8?B?ZE9hcE85MGxwVUpaTUd2WHJOR3JobDZVbkVxOWhFZmlsL21nR2dJbFBGanVx?=
 =?utf-8?B?SVhEcXlGNjJ3d05jRW14VHZCZkdPTHNJYWxldXc5STg2NElNWG9yN3V2SC8y?=
 =?utf-8?B?UlFmeDBPSWRpMGl1THV3SWRtTm4xb1lIUm55dU5YYlllZk9vTnYrNVNDWnNq?=
 =?utf-8?B?cmFFUzNPamZTUUlSc2czcktNM3dzL2RPMTI3K2JqUzJTL3ZISy9GRG9LTGs5?=
 =?utf-8?B?bWM1U055QnJkWmU1OXQ0N0ZPcXlzUkVBWkRZZWJvUUNuaWlNWDZMSkFkNno4?=
 =?utf-8?B?cVkvbi9ob2x0cUlJTEU3cDl1YnZITkJHRHBaellUZytWbDJvOGJOdnlPUGxs?=
 =?utf-8?B?MURzakR4L2RXdFNvNHNpWjltV0Z2eVlQQ2JyZ1pxd0dYL05adDMzaXlBRmEz?=
 =?utf-8?B?ek1aRkV4UnV0bG1EdnZBYVk1MlBEUDhYV2NnMXY5WDBYbW9rd3NVWXN2Q2c1?=
 =?utf-8?B?V0FaMkNGS1B0dXNLYkRGMkxUK3RhRnFEeUdvcXBYSFlMeml1OW16L1JiOTdB?=
 =?utf-8?B?bitMaGhJRDdHby95bkRMdkE0akdBS2NrckFHUjJxTHdUSEthclhWNzMxSlFx?=
 =?utf-8?B?QXlXQWZJZ0RHYjNMYldSN1ludUhDZUs0VWpsOU5RRnY3ZHpDU1dQeDBQQ2ll?=
 =?utf-8?B?YWo1dFh2Z3RFbzZxUnNyemtmTW9wRStkdzNtRXVJV0xwa2xMTTlJc3QwRnNX?=
 =?utf-8?B?a1FONDVwVEZVWlVCdDllMWg1WTNydnJlS3pQSUdpNy9tMzBxTFo3S1poSVMv?=
 =?utf-8?B?SU4xYmQwbEE3ZjZ5clZlZU9nbDgxbERmWktXd25jT1ducytiV2pLclpITnZq?=
 =?utf-8?B?UVpHN3pEODM0VXBXRVFLeXNwOW5HRDZBeWM5cjFkYUhCQXlZVVpvL3ZqVnlR?=
 =?utf-8?B?WG43azU0VElTaXFDb0x4MDF2R0lDem0zSlVYcW1zSkdRbXNSalk0ZE1uUlo1?=
 =?utf-8?B?WDBOMjNGLytCYW1ta011VWdLMU5zM1d2OFloeHI0czAwaUlnenVCWjFrbnRt?=
 =?utf-8?B?dE80cDMvNjJ5MUc3K2txb1A2a1FlSWNtY3h2R3cyUy9FM1ZWc2laUEYyNFVW?=
 =?utf-8?B?K3A2ME1FenM0VkcwVy80SFk4bnFsOXlCb291ZnVYM1VqTWNHWlovalQxTlg3?=
 =?utf-8?B?WGxPQW1GYXN3cjRXVTRyWGlHNjJIS3JoYkZkT3FSM1JSSGdlMW1EMExXcnJ5?=
 =?utf-8?B?UTlna1lmdWMwUmQ5SEhBc3Q0ZDNSL0wreXBIbzMvbDJVNGFpeXM0SWlQMTdT?=
 =?utf-8?B?NGNjVGM1OEp1RWRTVFJOeTUzRHN0Q29VRTEvWEJBYm9PVktoRWxlZkliN09o?=
 =?utf-8?B?Yy9uM3BZR2dFN2t0QUtHa2x4QkR2MmJLcXR1Q0lGRFk0Y2hKYXpGNXM4SzF3?=
 =?utf-8?B?S2lETWM0emYyNTBubFpUblo0bC9UV0hDYWk3M2QzU3ZaK2p3Z3ZHMjAyOS81?=
 =?utf-8?B?TEhoUmJlK08xaURLb01rVGhkMGVUd1NHenhlMVlYcW9PekdjWG5ONENHSVdn?=
 =?utf-8?B?MHdmQzc3WDhVRitBN2ZCSmwzK21LTUhXU0pBRHhJRThKR3B3Zi9mQytmdUlM?=
 =?utf-8?B?NTRUK1M1SW1IcmVRalBkNStqVTMycTBNZDAwT21yQkZ2VG92WEJpZ2llMTQ2?=
 =?utf-8?B?L2tJbmJBMTRFM0VPS1lkVXZHMVZIOUVteS9aZGphT1d1NFpqS1lhWmRBU0VZ?=
 =?utf-8?B?cHNUUE9lKzlRc3dkNFFvV1RWK05DU2ZJN0RFcm02OGtqS2kzVHpZUlFkekFL?=
 =?utf-8?B?endtMWo0bStFemtURGZLbEV4OEwwSTE1VGthZExRLzFWUDdSNXFhWkNCNjdX?=
 =?utf-8?B?TEZycmhrWlFXazc5MFhSam1NMDczUUFNMUt2WFZKYVdSd0dCUGZNTmJBTEsz?=
 =?utf-8?Q?2O9qgdfU07adZrHW+FvfYY3s596bMToOGKOfCEi2RY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6a034d-a844-4c44-caad-08d9bfed76da
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 17:08:07.0122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KB63Rsqmb/jB+mLP0UON7BZ4X4zinTdMHI2tXxAB4KCu2y8ODkBoDNOJsz+HB4BIuwrZJDNg6GZQhH7YM+CFPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6722
X-Proofpoint-ORIG-GUID: OvXcbM_ysbHqq0RGTbZ7quKwWv7D5bnF
X-Proofpoint-GUID: OvXcbM_ysbHqq0RGTbZ7quKwWv7D5bnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_10,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112150098
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBEZWNlbWJlciAxNSwgMjAyMSA0OjU4IFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5T
YUBhbmFsb2cuY29tPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+
OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgSGVubmVyaWNoLCBNaWNoYWVs
DQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvM10gaWlvOiBkYWM6IGFkZCBzdXBwb3J0IGZvciBsdGMyNjg4DQo+IA0KPiBbRXh0ZXJuYWxd
DQo+IA0KPiBPbiAxMi8xNS8yMSAyOjQwIFBNLCBTYSwgTnVubyB3cm90ZToNCj4gPg0KPiA+Pj4g
KwkJfQ0KPiA+Pj4gK1suLi5dDQo+ID4+PiArCXJldHVybiBsdGMyNjg4X3RncF9zZXR1cChzdCwg
Y2xrX21zaywgdGdwKTsNCj4gPj4+ICt9DQo+ID4+PiArDQo+ID4+PiArc3RhdGljIGludCBsdGMy
Njg4X3NldHVwKHN0cnVjdCBsdGMyNjg4X3N0YXRlICpzdCwgc3RydWN0IHJlZ3VsYXRvcg0KPiA+
PiAqdnJlZikNCj4gPj4+ICt7DQo+ID4+PiArCXN0cnVjdCBncGlvX2Rlc2MgKmdwaW87DQo+ID4+
PiArCWludCByZXQ7DQo+ID4+PiArDQo+ID4+PiArCS8qDQo+ID4+PiArCSAqIElmIHdlIGhhdmUg
YSByZXNldCBwaW4sIHVzZSB0aGF0IHRvIHJlc2V0IHRoZSBib2FyZCwgSWYgbm90LCB1c2UNCj4g
Pj4+ICsJICogdGhlIHJlc2V0IGJpdC4NCj4gPj4+ICsJICovDQo+ID4+IExvb2tpbmcgYXQgdGhl
IGRhdGFzaGVldCBJIGRvIG5vdCBzZWUgYSByZXNldCBwaW4gb24gdGhlIGNoaXAuDQo+ID4gSUlS
QywgaXQncyBjYWxsZWQgQ0xSLi4uIEJ1dCBsb29raW5nIGF0IGl0IGFnYWluIGlmIGZlZWxzIGxp
a2UgYSByZXNldCBwaW4gYnV0DQo+ID4gd2l0aG91dCBkaXJlY3RseSBzYXlpbmcgc28gaW4gdGhl
IGRhdGFzaGVldC4NCj4gb2ssIGJ1dCB0aGVuIHRoZSBncGlvIHNob3VsZCBiZSBjYWxsZWQgImNs
ciIgYW5kIG5vdCAicmVzZXQiLg0KDQpvay4uLg0KDQo+ID4NCj4gPj4+ICsJZ3BpbyA9IGRldm1f
Z3Bpb2RfZ2V0X29wdGlvbmFsKCZzdC0+c3BpLT5kZXYsICJyZXNldCIsDQo+ID4+IEdQSU9EX09V
VF9ISUdIKTsNCj4gPj4gVXN1YWxseSB3aGVuIHdlIGhhdmUgYSByZXNldCB3aGljaCBpcyBhY3Rp
dmUgbG93IHdlIGRlZmluZSBpdCBpbiB0aGUNCj4gRFQNCj4gPj4gYXMgYWN0aXZlIGxvdyByYXRo
ZXIgdGhhbiBkb2luZyB0aGUgaW52ZXJzaW9uIGluIHRoZSBkcml2ZXIuDQo+ID4gQW5kIHRoYXQn
cyBob3cgSSB0ZXN0ZWQgaXQgaW4gZHRzLiBUaGUgJyBHUElPRF9PVVRfSElHSCcgaXMgdG8NCj4g
cmVxdWVzdA0KPiA+IGl0IGluIHRoZSBhc3NlcnRlZCBzdGF0ZSBhbmQgdGhlbiB3ZSBqdXN0IGhh
dmUgdG8gZGUtYXNzZXJ0IGl0IHRvIHRha2UgaXQNCj4gPiBvdXQgb2YgcmVzZXQuIEl0J3MgYWN0
dWFsbHkgdGhlIHNhbWUgcGF0dGVybiB1c2VkIGluIHRoZSBhZGlzIGxpYi4gSUlSQywNCj4gPiB5
b3Ugd2VyZSBhY3R1YWxseSB0aGUgb25lIHRvIHN1Z2dlc3QgdGhpcyA6KQ0KPiBJJ20gc3R1cGlk
Li4uIGp1c3QgcmVhZCBpdCB0aGUgd3Jvbmcgd2F5LCBjb2RlIGlzIGNvcnJlY3QgdGhlIHdheSBp
dCBpcw0KPiA+Pj4gKwlpZiAoSVNfRVJSKGdwaW8pKQ0KPiA+Pj4gKwkJcmV0dXJuIGRldl9lcnJf
cHJvYmUoJnN0LT5zcGktPmRldiwgUFRSX0VSUihncGlvKSwNCj4gPj4+ICsJCQkJICAgICAiRmFp
bGVkIHRvIGdldCByZXNldCBncGlvIik7DQo+ID4+PiArCWlmIChncGlvKSB7DQo+ID4+PiArCQl1
c2xlZXBfcmFuZ2UoMTAwMCwgMTIwMCk7DQo+ID4+PiArCQkvKiBicmluZyBkZXZpY2Ugb3V0IG9m
IHJlc2V0ICovDQo+ID4+PiArCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoZ3BpbywgMCk7DQo+
ID4+PiArCX0gZWxzZSB7DQo+ID4+PiArCQlyZXQgPSByZWdtYXBfdXBkYXRlX2JpdHMoc3QtPnJl
Z21hcCwNCj4gPj4gTFRDMjY4OF9DTURfQ09ORklHLA0KPiA+Pj4gKwkJCQkJIExUQzI2ODhfQ09O
RklHX1JTVCwNCj4gPj4+ICsJCQkJCSBMVEMyNjg4X0NPTkZJR19SU1QpOw0KPiA+Pj4gKwkJaWYg
KHJldCA8IDApDQo+ID4+PiArCQkJcmV0dXJuIHJldDsNCj4gPj4+ICsJfQ0KPiA+Pj4gKw0KPiA+
Pj4gKwl1c2xlZXBfcmFuZ2UoMTAwMDAsIDEyMDAwKTsNCj4gPj4+ICsNCj4gPj4+ICsJcmV0ID0g
bHRjMjY4OF9jaGFubmVsX2NvbmZpZyhzdCk7DQo+ID4+PiArCWlmIChyZXQpDQo+ID4+PiArCQly
ZXR1cm4gcmV0Ow0KPiA+Pj4gKw0KPiA+Pj4gKwlpZiAoIXZyZWYpDQo+ID4+PiArCQlyZXR1cm4g
MDsNCj4gPj4+ICsNCj4gPj4+ICsJcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhzdC0+cmVnbWFw
LA0KPiA+PiBMVEMyNjg4X0NNRF9DT05GSUcsDQo+ID4+PiArCQkJCSAgTFRDMjY4OF9DT05GSUdf
RVhUX1JFRiwgQklUKDEpKTsNCj4gPj4gVGhpcyBpcyBhIGJpdCBjb25mdXNpbmcgc2luY2UgeW91
IGFyZSB1c2luZw0KPiBMVEMyNjg4X0NPTkZJR19FWFRfUkVGDQo+ID4+IGZvcg0KPiA+PiB0aGUg
bWFzayBhbmQgQklUKDEpIGZvciB0aGUgdmFsdWUsIGV2ZW4gdGhvdWdoIGJvdGggYXJlIHRoZSBz
YW1lLg0KPiA+IEkgdHJpZWQgdG8gYmUgbW9yZSBvciBsZXNzIGNvbnNpc3RlbnQuIFNvLCBmb3Ig
bWFza3MgSSB1c2VkIGEgZGVmaW5lDQo+IGFuZA0KPiA+IGZvciB0aGUgYWN0dWFsbHkgdmFsdWUg
SSB1c2VkIHRoZSAicmF3IiBCSVQsIEZJRUxEX1BSRVAsIEZJRUxEX0dFVCBhcw0KPiA+IEkgdGhp
bmsgSm9uYXRoYW4gcHJlZmVycyB0aGF0IHdheS4gSWYgdGhhdCdzIGFsc28gdGhlIHByZWZlcnJl
ZCB3YXkgZm9yDQo+IG1hc2tzLA0KPiA+IEknbSBoYXBweSB0byB1cGRhdGUgaXQuDQo+IA0KPiBK
dXN0IDUgbGluZXMgYWJvdmUgeW91IHVzZSB0aGUgZGVmaW5lIGZvciBib3RoIHRoZSBtYXNrIGFu
ZCB0aGUgdmFsdWUNCj4gOikNCg0KOmZhY2VwYWxtOiEgQXQgbGVhc3QgaW4gbXkgbWluZCBJIHRy
aWVkIHRvIGRvIGl0Li4uDQoNCj4gSSBkb24ndCB0aGluayBpdCBpcyBhIGdvb2QgaWRlYSB0byB1
c2UgcmF3IEJJVCh4KSBpbiB0aGUgY29kZS4gVGhleSBhcmUNCj4ganVzdCBhcyBtYWdpYyBvZiBh
IHZhbHVlIGFzIHdyaXRpbmcgMHg4LiBUaGVyZSBpcyBubyB3YXkgZm9yIGEgcmV2aWV3ZXINCg0K
V2VsbCBCSVQoMykgaXMgc3RpbGwgYmV0dGVyIHRoYW4gMHg4IGJ1dCBJIGdldCB5b3VyIHBvaW50
Lg0KDQo+IHRvIHF1aWNrbHkgc2VlIHdoZXRoZXIgdGhhdCBCSVQoeCkgYWN0dWFsbHkgaXMgdGhl
IHJpZ2h0IHZhbHVlIGZvciB0aGUNCj4gbWFzay4NCj4gDQo+IElmIHlvdSB3YW50ZWQgdG8gZ28g
dGhlIEZJRUxEX1BSRVAgcm91dGUgeW91IGNvdWxkIHdyaXRlIHRoaXMgYXMNCj4gDQo+IC4uLiwg
TFRDMjY4OF9DT05GSUdfRVhUX1JFRiwNCj4gRklFTERfUFJFUChMVEMyNjg4X0NPTkZJR19FWFRf
UkVGLCAxKQ0KPiANCj4gQnV0IG15IHBlcnNvbmFsIHByZWZlcmVuY2UgaXMganVzdCB0byBwYXNz
IHRoZSBtYXNrIGFzIHRoZSB2YWx1ZSB3aGVuDQo+IGNoYW5naW5nIGEgc2luZ2xlIGJpdCB2YWx1
ZS4gTWFrZXMgaXQgY2xlYXIgdGhhdCBpdCBpcyBhIHNpbmdsZSBiaXQNCj4gZmllbGQgYW5kIHlv
dSBhcmUgc2V0dGluZyBpdC4gT3IganVzdCB1c2UgcmVnbWFwX3NldF9iaXRzKCkuDQoNCkkgdGhp
bmsgJ3JlZ21hcF9zZXRfYml0cygpJyBpcyBpZGVhbCBmb3IgdGhlc2UgY2FzZXMgYW5kIHByb2Jh
Ymx5IGludHJvZHVjZWQNCmZvciB0aGluZ3MgbGlrZSB0aGlzLiBBbmQgSSBzdXNwZWN0IHlvdSBw
cmVmZXIgdGhhdCBJIHVzZQ0KJ0xUQzI2ODhfQ09ORklHX0VYVF9SRUYnIGFzIHRoZSBiaXQgYXJn
dW1lbnQgOikNCg0KLSBOdW5vIFPDoQ0K
