Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BDD444FF7
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhKDINz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:13:55 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:47000 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230229AbhKDINy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:13:54 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A42KRWk003246;
        Thu, 4 Nov 2021 04:11:14 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3c3e2pea04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Nov 2021 04:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWy5/OvFfh8MStURcDJ3HF2VuLSsUNgX7p5LoIw6eCZHOWV8ZmwlsKj22Xj2YjYYg8j7La8rKEFX1N4CP165CYdiUmV8OLM1hNOB5U3YB2tW1KtV2LDb6JQoemO6GQ6zJCGG8kshqPYr+gMTp1LMVxbF1hwfKuK6g9kTz73tcjim12Sg9bZ8SJlpDqYeX01s7ToddAscRdwyrStN2ad8rr/wEeYn6fJYZg+9m3tuFInbf3+HcZAWCYU6JaAyz5k9AA0TpIUQGfc94SquGadq4C6p2BmcOSemB2JlLneJ+/Kq73iEG0DKj9T5f/QfWy4RW1/ODPQ3AWgaqtfdegDmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycCe+zQGyk2skRUAzD6fV08rY7WtRYDhMIwV4gW94EQ=;
 b=Oz1OSPKunuiZ1z8kHuAHDeGovWRx0noAZnhddAkIYYXR0W0yTpg9lWqo+x6BUES/ogooif/4xH5lCYtuQ7J9Yb1HJLRrTOv8Ap86KYJ57YomzAnl/rGrDUZGUbT2hiJVjEUaH3bNe98igmvm1mQVEUE7eq5s1F7+h4VHUiMCBWdJXjUdyX3LtbCDh7gA3gFS6O+PpurT5wWf3YRqrovjpFUvgx+F9v9o2qZTlmqcKvhoYagNbulfjxNT2qXVzpfKiBAAxB+Fd5dEH+ejeVQeMKfkds0Fh5qqKcTTZQI61RZriobYdXYOQzvjpSjTNHGRJOlSs+fI5/zp6iaS1pFm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycCe+zQGyk2skRUAzD6fV08rY7WtRYDhMIwV4gW94EQ=;
 b=oaHk98+vvMouasiHTxhdoegU9lavTfQZjHKFvXvFdmW1EERLALWnFqIeSBhM+sSVyO4h0gsqg5cfZdJlV/ODwQhvg1iFTX4eyZoIMNElTEilJ9WBGR806YHaNjDznkHeLQdVmqvzkpaiR/P6L4a86IoK+Qe/2a461/UV75E8NAU=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB4631.namprd03.prod.outlook.com (2603:10b6:a03:12e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 4 Nov
 2021 08:11:12 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::3523:ea80:f2cf:48c8]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::3523:ea80:f2cf:48c8%9]) with mapi id 15.20.4608.025; Thu, 4 Nov 2021
 08:11:12 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] iio: frequency: admv1013: add support for ADMV1013
Thread-Topic: [PATCH v3 1/2] iio: frequency: admv1013: add support for
 ADMV1013
Thread-Index: AQHXzwfgGHROvFVBxUSS1cWk9SZT/6vwAwkggAI6uACAAMOZ0A==
Date:   Thu, 4 Nov 2021 08:11:12 +0000
Message-ID: <SJ0PR03MB6359234D6DA5D0CC58DB1113998D9@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20211101100420.70304-1-antoniu.miclaus@analog.com>
        <PH0PR03MB6366548C1CE5476989662F74998B9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20211103200325.3416988c@jic23-huawei>
In-Reply-To: <20211103200325.3416988c@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFl6UXpaR000T1RRdE0yUTBOaTB4TVdWakxUaGlPVGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHTTBNMlJqT0RrMUxUTmtORFl0TVRGbFl5MDRZ?=
 =?utf-8?B?amszTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTkRZMk55?=
 =?utf-8?B?SWdkRDBpTVRNeU9EQTBPRGN3TnpBeU5UYzROamswSWlCb1BTSnJUVloyZDFW?=
 =?utf-8?B?dFRGZHNTa0ZrYzNGYVJFRjZSVFZIWVdNMGRHTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVRkhVRXQxUjFVNVNGaEJXVTFFVUhkdVNqRTNVV1ZuZDAwdlEy?=
 =?utf-8?B?TnVXSFJDTkVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ac6afea-7dfb-4250-f644-08d99f6aaa9a
x-ms-traffictypediagnostic: BYAPR03MB4631:
x-microsoft-antispam-prvs: <BYAPR03MB46310558288D555FC33C5E55998D9@BYAPR03MB4631.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GWn2LKCARLm+4L4iVQtECsOWeAr8+vAadsdtAo0iuiKgSz/quyFyQ9tN2Rh9URkUkT3IZLc65R7JI8O8arOav56S22uFgGkU3AZFvJwNSV3iuPKZhH6uw7fcO6qgK5IfOOVlweGQaxX4iEmWrgr5UEg4MQDCMNTQD1o/qjGhVAnqkamb0a8ZscXGJx1fwc695fVyY+Rcg+M8B5EG4yfBiWB1wo/rvjMiZ4PnUllG+ukXd0ul3EODPOOknUAwBwfc+MlEfkFXQbmp5AUquoKq229j5Vjrt7OqV1dvbInAkbLSkwssyS+jKVNzhJ+QOa4qakymYPDVVdDnrzLgcs1lV1eO+rCJ821h0YrjO80FNZ8j2hTYbSYa2QPZnEie1KBXv5MToCJCNNja2uOyOUlODyzpUjolkzWe2/UDaYpnzHohJQ8+BiWPXy0T7U0OwxGWcnUAzczFgQVcn3626UYdoLZCYnBdv9L9hQ8NRfg2zRxygC94TqIopaa5bakiruLMH3Wde3oGkjjyYb5j6P9pZsI5/9p+iLPcuYbx+1V7j5Ms7H840+oE2cIqwpMf3PUF+1p0Ix+ZfpMmuiIIVK7l+plclAE5wZOlsuijD0ydyAVK0gnJw/DcF4wUIhgmNSwysVbl17DwbXy7uLW1qeJcugrA34gnmvYJ08I4o6bOJo9WlwXyuMtelFQTzhog552XXlKu1jHDgLZ8CC0YErl2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(26005)(52536014)(66446008)(83380400001)(316002)(66946007)(7696005)(8676002)(66476007)(55016002)(186003)(8936002)(86362001)(76116006)(5660300002)(38070700005)(54906003)(122000001)(2906002)(4326008)(64756008)(38100700002)(66556008)(71200400001)(6506007)(33656002)(6916009)(53546011)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkJUTkE5THhCQndINml3TEtIclFwK1BGa2hyR0pYZ21qVXlLNnRyNDV4T3dF?=
 =?utf-8?B?VnhOUm9DY09LNHpVbEpKU1lER015dkdRYkpnTXVaRE55OW5JT0s1S3pFa0Ns?=
 =?utf-8?B?M3VyZU5uKzRuRUIreS9kUVowak9jendibnRyMXlhL1dSVUhEYVpiMDdXL1hN?=
 =?utf-8?B?dGcwMjRjZEgwSGVPb1VQRWdRakhMdTQ3RGdvZnZURjlSeDdETWErMGx5M0E3?=
 =?utf-8?B?STBLMGVwajdzNzZlVjZTNnFRR1ZDNXNYK1dLME9hTFcxcEpBR2ZkbUFOSGdu?=
 =?utf-8?B?clI5dWRlRzNDektPbEVFNHBrVHRHa2VtZUNqSWZFSDA2akhXZE10V2xjK01r?=
 =?utf-8?B?b3NDcEprQ3pOeXJvSWtMbDIyYWtDTkRYcmpGOUVXVkFPL2xpNU52a3RrZ25Z?=
 =?utf-8?B?M214SCtkOFJhMGpGa1VoYnhpd3ZhRElGQ1FzQWxpU3BaK3NmVHlJN1ppYmp0?=
 =?utf-8?B?TUtneldIdUVub3d6QUcvZHZ0Q0wzZFFQVkRRTGNWQVB1NUQ5anNtNE1kaXhK?=
 =?utf-8?B?LzRsZk80d0FVejIvZEtLZW03U084MzNYVGVYakJpQXRoS1Z0S3ZyNkhZTEZv?=
 =?utf-8?B?WlNDcEUySjlLeHovWkV2eWZULzRPSTlFamM3SS9LelNKbVJySzA4eEt2ZUd1?=
 =?utf-8?B?ckhlU3RDdmpkcVJyY1JBK3F6eDRoZFFVekhKZWRPV1QrT2ZVeGZmUXJPVEZG?=
 =?utf-8?B?M2QvRjkrdHdlNVdZMlAwSHpVRG8xVUtmM2tXbVVvbjc4S2NDcE0vL25INklN?=
 =?utf-8?B?eS9zMUxhWVpkR3BFcitBcnkrWkZTa0x6VmZnZmYyejE5TW5OWHNsSkJkRW1n?=
 =?utf-8?B?eEFub1NWVmd1VTJUaHd5a2g3eGJyM3d1cHQwYnI2MEtZSW9BNzRtNkwxbjAz?=
 =?utf-8?B?cWV0Vkc0K0w4bWkxMTdOS1F2dG94ZXdabmkzRDJMVFJnbU1hYWhMeVZuRnp5?=
 =?utf-8?B?VmdaMXlaaXBpckRyWThuZTNNLzdOS0t2WG1RNEJ3V3R0eWR2QldGKzhqR2xE?=
 =?utf-8?B?aGh3YlBaaHhTcjV6TWZiSGI1dThpV0Rlc3pDcnZTS3hlazN0RldBa1JmS3px?=
 =?utf-8?B?WlZjbVMzRTZaMEtacnhoUm9aZVR1ZmdzZ0ZJbWF6R0tEOUdOL3V3UUNFcG9n?=
 =?utf-8?B?R3VQYlA5UUhiOGk5cklMU3FNV2VVcExsaWZFNnFSM1NHbDdtUTdkQS9ITFRG?=
 =?utf-8?B?WmFUNjRzM0dTQTVVSVZDcU5rUjBEZ1Q3Ynp3NkhXNEdEZ3I3RnB1USs0NU9Y?=
 =?utf-8?B?U3ZYZ3o4NXg2U1dOU3JxTDRndHh6STlpTFBhclFDa1BXMzBKa0F6NlR5cnA3?=
 =?utf-8?B?UkllaU9GRHcrSmxBT2E5cUt3NXg5TWd6S3I5dWRiLzFwTnR2d0c3VTBuU1pF?=
 =?utf-8?B?SHJwUkRidTM2elNCMnZHdi9MTVFhM29wOXJzQzlqbEFPa2J4UnlOTXBMc3Av?=
 =?utf-8?B?Qk1nWTdSTC9MRjEwMVMrakxVNFpycUtyQWJXUE4reHhhelo4ak44Um1qWXdm?=
 =?utf-8?B?V1d6U2l1SE43dEpNeVNXeXBvWnpSYk5tQzY3S1BXQlhnWVNmRjlPN0hMN0ky?=
 =?utf-8?B?MEtZZitlVEtxNjd6cTFMOHdvTDU5NzNta0pRRzNYM2lMeDcyTmFaWkVJYnY3?=
 =?utf-8?B?ZEJSZVZ2OVFjeVA5ZzR0L3ZJTnlLaHJtQVFUWVhYRi9mYVBGU2NmWUQ3K2d5?=
 =?utf-8?B?V1VCMTI1WFBJTUkvVnM4akdRUXZlcFU1clhZbnBPaDdwQms2N0xCRVF3NzBS?=
 =?utf-8?B?ZWxGTGs1aFJYNTlKS1h4d1dnQUI0d1lmSTJTVWVQOHR5Mk9zSzhRQ3VkZVBj?=
 =?utf-8?B?ZzJPUzFmdWFyMEV6Ty9jeWwreEJibWZGdTl1eFZSZXU3UkJSOFNkREJvUURP?=
 =?utf-8?B?eHF3QW1tKzFhSXQ3TlFGR1JPYVF0d3dnNXlEZ2pkSDNVU3pJWU1oODNvS2FB?=
 =?utf-8?B?UmVGVjdJR3hnWEMwWlpqak9McnR1Vzg5Wms1Q0FQL0hNbUVXNm50RTF1ZVpO?=
 =?utf-8?B?U0ZXaklGWHpteU11aUxZV1JoU2x5dHI4eXBaQkRXOEhINkxTbDhjUUtuR3N6?=
 =?utf-8?B?TTNVWFJVbWJxYnQ5ZWhrQzloOTFmQVdtYWxRL3BITXUwM21zdk9tSk1oZDlO?=
 =?utf-8?B?RVpKbU1NejdFbWwwMEdXaUdLczI3TzZnRVczZDNKTDh1UG5hekMvOHFQbHc5?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac6afea-7dfb-4250-f644-08d99f6aaa9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 08:11:12.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +DW5qAXy8CxrPy91WAnQI5B3Kx8/vq6RNn613VcPKx0OsCGVr5QqGRzdMyzjb84XHzt5O/4TJ8FQOJ8inPV6pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4631
X-Proofpoint-ORIG-GUID: 1gDjnER_gB67ALW80kX79XEsn__kisfl
X-Proofpoint-GUID: 1gDjnER_gB67ALW80kX79XEsn__kisfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_02,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040033
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQo+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgTm92ZW1iZXIgMywgMjAyMSA5OjA0IFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5T
YUBhbmFsb2cuY29tPg0KPiBDYzogTWljbGF1cywgQW50b25pdSA8QW50b25pdS5NaWNsYXVzQGFu
YWxvZy5jb20+Ow0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5v
cmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8yXSBpaW86IGZyZXF1ZW5jeTogYWRt
djEwMTM6IGFkZCBzdXBwb3J0IGZvcg0KPiBBRE1WMTAxMw0KPiANCj4gW0V4dGVybmFsXQ0KPiAN
Cj4gT24gVHVlLCAyIE5vdiAyMDIxIDEwOjA5OjE1ICswMDAwDQo+ICJTYSwgTnVubyIgPE51bm8u
U2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gKyNkZWZpbmUgQURNVjEwMTNfQ0hBTl9Q
SEFTRShfY2hhbm5lbCwgcmZfY29tcCkgewkJXA0KPiA+ID4gKwkudHlwZSA9IElJT19BTFRWT0xU
QUdFLAkJCQkJXA0KPiA+ID4gKwkubW9kaWZpZWQgPSAxLAkJCQkJCVwNCj4gPiA+ICsJLm91dHB1
dCA9IDEsCQkJCQkJXA0KPiA+ID4gKwkuaW5kZXhlZCA9IDEsCQkJCQkJXA0KPiA+ID4gKwkuY2hh
bm5lbDIgPSBJSU9fTU9EXyMjcmZfY29tcCwJCQkJXA0KPiA+ID4gKwkuY2hhbm5lbCA9IF9jaGFu
bmVsLAkJCQkJXA0KPiA+ID4gKwkuaW5mb19tYXNrX3NlcGFyYXRlID0gQklUKElJT19DSEFOX0lO
Rk9fUEhBU0UpCQlcDQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsjZGVmaW5lIEFETVYxMDEz
X0NIQU5fQ0FMSUIoX2NoYW5uZWwsIHJmX2NvbXApIHsJCVwNCj4gPiA+ICsJLnR5cGUgPSBJSU9f
QUxUVk9MVEFHRSwJCQkJCVwNCj4gPiA+ICsJLm1vZGlmaWVkID0gMSwJCQkJCQlcDQo+ID4gPiAr
CS5vdXRwdXQgPSAxLAkJCQkJCVwNCj4gPiA+ICsJLmluZGV4ZWQgPSAxLAkJCQkJCVwNCj4gPiA+
ICsJLmNoYW5uZWwyID0gSUlPX01PRF8jI3JmX2NvbXAsCQkJCVwNCj4gPiA+ICsJLmNoYW5uZWwg
PSBfY2hhbm5lbCwJCQkJCVwNCj4gPiA+ICsJLmluZm9fbWFza19zZXBhcmF0ZSA9IEJJVChJSU9f
Q0hBTl9JTkZPX0NBTElCQklBUykJXA0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjIGFkbXYxMDEzX2NoYW5uZWxzW10gPSB7DQo+ID4g
PiArCUFETVYxMDEzX0NIQU5fUEhBU0UoMCwgSSksDQo+ID4gPiArCUFETVYxMDEzX0NIQU5fUEhB
U0UoMCwgUSksDQo+ID4gPiArCUFETVYxMDEzX0NIQU5fQ0FMSUIoMCwgSSksDQo+ID4gPiArCUFE
TVYxMDEzX0NIQU5fQ0FMSUIoMCwgUSksDQo+ID4gPiArCUFETVYxMDEzX0NIQU5fQ0FMSUIoMSwg
SSksDQo+ID4gPiArCUFETVYxMDEzX0NIQU5fQ0FMSUIoMSwgUSksDQo+ID4gPiArfTsNCj4gPiA+
ICsNCj4gPg0KPiA+IEhtbSwgSWYgSSdtIG5vdCBtaXNzaW5nIG5vdGhpbmcgdGhpcyBsZWFkcyB0
byBzb21ldGhpbmcgbGlrZToNCj4gPg0KPiA+IG91dF9hbHR2b2x0YWdlMF9pX3BoYXNlDQo+ID4g
b3V0X2FsdHZvbHRhZ2UwX3FfcGhhc2UNCj4gPiBvdXRfYWx0dm9sdGFnZTBfaV9jYWxpYmJpYXMN
Cj4gPiBvdXRfYWx0dm9sdGFnZTBfcV9jYWxpYmJpYXMNCj4gPiBvdXRfYWx0dm9sdGFnZTFfaV9j
YWxpYmJpYXMNCj4gPiBvdXRfYWx0dm9sdGFnZTFfcV9jYWxpYmJpYXMNCj4gPg0KPiA+IFRvIG1l
IGl0IGlzIHJlYWxseSBub24gb2J2aW91cyB0aGF0IGluZGV4IDEgYWxzbyBhcHBsaWVzIHRvIHRo
ZSBzYW1lDQo+ID4gY2hhbm5lbC4gSSBzZWUgdGhhdCB3ZSBoYXZlIHRoaXMgbGlrZSB0aGlzIHBy
b2JhYmx5IGJlY2F1c2Ugd2UNCj4gPiBjYW4ndCB1c2UgbW9kaWZpZWQgYW5kIGRpZmZlcmVudGlh
bCBhdCB0aGUgc2FtZSB0aW1lLCByaWdodD8NCj4gPg0KPiANCj4gSW5kZWVkLCB0aGlzIGlzIHRo
ZSBwcm9ibGVtIHlvdSBtZW50aW9uZWQgaW4gdGhlIGRpc2N1c3Npb24gb24gdjINCj4gTXkgc3Vn
Z2VzdGlvbiBvZiBtYWtpbmcgaXQgY2xlYXIgaXQgaXMgYSBkaWZmZXJlbnRpYWwgY2hhbm5lbCBh
bmQgdGhlbg0KPiBhcHBseWluZyBjYWxpYmJpYXMgdG8gdGhlIHBhcnRzIGRvZXNuJ3Qgd29yayBh
cyBpdCB3b3VsZCBuZWVkIHRvDQo+IGhhdmUgYm90aCBtb2RpZmllcnMgYW5kIGEgc2Vjb25kIGNo
YW5uZWwgaW5kZXguDQo+IEFzIGZvciB3aHkgdGhhdCBpcyBhbiBpc3N1ZSwgaXQgY29tZXMgZG93
biB0byB0cnlpbmcgdG8ga2VlcCB0aGUNCj4gZXZlbnQgaW50ZXJmYWNlIGRlc2NyaXB0aXZlLCBi
dXQgc3RpbGwgbWluaW1hbC4gIFdlIGJhc2ljYWxseSByYW4NCj4gb3V0IG9mIGJpdHMgYW5kIGF0
IHRoZSB0aW1lIEkgY291bGRuJ3QgdGhpbmsgb2YgYSByZWFzb24gd2UnZCB3YW50DQo+IGJvdGgg
ZGlmZmVyZW50aWFsIGFuZCBhIG1vZGlmaWVyLi4uDQoNCkknbSBub3QgcmVhbGx5IHNlZWluZyB0
aGUgaXNzdWUgd2l0aCB0aGUgZXZlbnQgaW50ZXJmYWNlIGJ1dCB0aGF0IGlzIG1vc3RseQ0KYmVj
YXVzZSBJIHN0aWxsIG5ldmVyIGhhZCB0byBkZWFsIHdpdGggaXQsIHNvIEkgbmV2ZXIgbG9va2Vk
IHRoYXQgZGVlcGx5IGludG8NCnRoZSBjb2RlLiBNaWdodCBiZSBhIGdvb2QgdGltZSBrbm93IDop
DQoNCj4gPiBKb25hdGhhbiwgSSdtIG5vdCBzdXJlIHdoYXQgc2hvdWxkIGJlIHRoZSBkb25lIGhl
cmUuLi4gRnJvbSB0aGUgdG9wDQo+IG9mIG15DQo+ID4gaGVhZCAgSSBndWVzcyB3ZSBjYW4gZWl0
aGVyOg0KPiA+DQo+ID4gKiBkcm9wIHRoZSBtb2RpZmllcnMgKG5vdCBwZXJmZWN0IGJ1dCBhbHNv
IG5vdCB0aGF0IGJhZCBJTU8pDQo+ID4gKiB0d2VhayBzb21ldGhpbmcgYWRkaW5nIGV4dGVuZGVk
IGluZm8gKG5vdCByZWFsbHkgbmVhdCkNCj4gVHJ1ZSwgaXQncyBub3QgbmVhdCBidXQgbWlnaHQg
YmUgdGhlIHdheSBmb3J3YXJkcyBmb3IgJ25vdycuLiBXZSBkb24ndA0KPiBoYXZlDQo+IGV2ZW50
cyBvciBhbnl0aGluZyBvbiB0aGlzIGRyaXZlciwgc28gd2UgY291bGQgbWFrZSBpdCBsb29rIHJp
Z2h0DQo+IHdpdGhvdXQgYW55DQo+IHJpc2sgb2Ygbm90IGJlaW5nIGFibGUgdG8gZXh0ZW5kIGl0
LiAgSG93ZXZlciBpdCB3aWxsIHByb2JhYmx5IGNvbWUgYmFjaw0KPiB0byBiaXRlDQo+IHVzIGFu
ZCB1c2Vyc3BhY2UgbWF5IG5vdCBleHBlY3Qgd2hhdGV2ZXIgd2UgZG8uDQo+IEhvcnJpYmxlIHRo
b3VnaCBpdCBpcyB5b3UgY291bGQgdXNlIGV4dGVuZF9uYW1lIC0gd2hpY2ggd2FzIG9yaWdpbmFs
bHkNCj4gaW50ZW5kZWQNCj4gdG8gbGV0IHVzICdsYWJlbCBzcGVjaWFsIHB1cnBvc2UgY2hhbm5l
bHMnLiAgSXQgd2FzIGEgYmFkIGlkZWEsIGJ1dCBpcyB0aGVyZQ0KPiBhbmQNCj4gbm90IGdvaW5n
IHdheSBhbnkgdGltZSBzb29uLg0KPiANCj4gSWYgeW91IGRpZCB0aGUgZGlmZmVyZW50aWFsIHRo
aW5nIGFuZCBzZXQgZXh0ZW5kX25hbWUgPSAiaSIgZXRjIHRoYXQNCj4gbWlnaHQgZ2V0IHVzIGFy
b3VuZCB0aGUgaW50ZXJuYWwgaXNzdWUgb2YgcmV1c2luZyBjaGFubmVsMiBmb3IgbW9kIGFuZA0K
PiBkaWZmZXJlbnRpYWwNCj4gY2hhbm5lbC4NCg0KQ291bGRuJ3Qgd2UgdXNlIHRoZSBsYWJlbCB0
byBhY2hpZXZlIGtpbmQgb2YgdGhlIHNhbWU/IE9yIGRvIHlvdSB0aGluaw0KdGhhdCBoYXZpbmcg
dGhlICJpIiBhbmQgInEiIGluIHRoZSBmaWxlbmFtZXMgaXMgcmVhbGx5IG1hbmRhdG9yeT8gSSBj
YW4NCnVuZGVyc3RhbmQgaWYgeW91IHRoaW5rIHRoZXkgYXJlIGFzIHRoZXkgYXJlIHZhbGlkIG1v
ZGlmaWVycy4gT1RPSCwNCklJUkMsIHdpdGggdGhlIGxhdGVzdCBwYXRjaGVzIGZyb20gUGF1bCwg
YWRkaW5nIHRoZSBleHRlbmRlZF9uYW1lIHdpbGwNCmF1dG9tYXRpY2FsbHkgZ2V0IHVzIHRoZSBs
YWJlbCBzeXNmcyBmaWxlIHdoaWNoIG1pZ2h0IGJlIGEgbGl0dGxlIG9kZCBidXQgSQ0KZ3Vlc3Mg
dGhhdCdzIGFscmVhZHkgdHJ1ZSBmb3IgYWxsIHRoZSBsZWdhY3kgZHJpdmVycyB1c2luZyBpdC4u
LiBTbyB5ZWFoLA0KYmV0d2VlbiB0aGlzIG9yIGV4dGVuZGVkIGluZm8sIHdlIG1pZ2h0IGhhdmUg
b3VyICJiYW5kIGFpZCIgZm9yIHRoaXMuDQoNCj4gPiAqIG9yIGhhbmRsaW5nIHRoaXMgaW4gdGhl
IGNvcmUgd2l0aCBhIG5ldyB2YXJpYWJsZS4gT2YgY291cnNlLCB3ZQ0KPiB3b3VsZCBuZWVkDQo+
ID4gdG8gYmUgY2FyZWZ1bCB0byBub3QgYnJlYWsgZXhpc3RpbmcgZHJpdmVycy4uLg0KPiANCj4g
V2Ugd291bGQgZW5kIHVwIHNvbWV0aGluZyBoYXJkbHkgZXZlciB1c2VkIHNvIEknbSBkb3VidGZ1
bCB0aGF0J3MgYQ0KPiBnb29kDQo+IGlkZWEgdW50aWwgd2UgaGF2ZSBzb21lIHZpc2liaWxpdHkg
b2YgaG93IGNvbW1vbiBpdCB3b3VsZCBiZS4NCg0KVHJ1ZSwgbW9zdCBsaWtlbHkgd2Ugd291bGQg
ZW5kIHVwIHdpdGggYSBwdWJsaWMgdmFyaWFibGUgb25seSB1c2VkIGluDQp0aGlzIHVzZSBjYXNl
Li4uIEJldHRlciB0byB3YWl0IGlmIHNvbWUgdXNlcnMgbGlrZSB0aGlzIHBvcCB1cC4NCg0KLSBO
dW5vIFPDoQ0K
