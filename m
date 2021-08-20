Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E755C3F277E
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhHTHRV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:17:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9064 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233162AbhHTHRV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:17:21 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JMFhGT024943;
        Fri, 20 Aug 2021 03:16:30 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 3ahdb2fy67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:16:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhDDTrAUTOlOx8eKfdYCZm9R7gb/0HdOYtuADL6tpceLWoLZEa42gyGRPrCMxsUhdZYPOkBR9xtDBvO3rEtUuyof3Zr2jSjrt0yF1C365LlVO/AZTWdp5NTQktWAG+aKmDqse2XyUdlXGRPj7Bx3Fzdpia5yNZBAhC0f1sdVro93DzNmkIB49oE1jbnr3gTOr/8GFGZVI60H/7NszjzozSg7xksVdg0T8a6QOJuVkZnAqmMKdE2px7pbmrezaDsS9WOxa/x1dCkOOQJyLqGaAVV6wRcSpglZniDlmeSFLkz/xACV3gwp+o7NcDcPRzmY4835oyo8MwdpnaGnh7xpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvEvtfzvjQFXcPiawbqIU3QS4ZJaaP9l6rujJVUDl6E=;
 b=nPS1/fhYrMwam4kdGkbpjKhOD8zQ1kz3Wo1c8T+cJcLFVgbWFUdF64iy++btSh2bKDGwm33PlUsfho5hHqxrw5qchmJBygjeadXQonu3pWqAIxCBmbcwTzKj/WMm6Qe5N/qSQU6t5mHX3jECoWszS6t3CclnAR+qAy0fu4AzBKUxf8xLrF+LhYNcPGTXoM4GA3UrGMvDcIZQE7Xigfr5CewNqz1a1o1OieSoogdKBB2Yb2en2Q83reXqVnkCLPRg3OoYTt+KHx9bDa3TdvBfsCjXPPPCAL0ZiR3HdT6mCut+27bk39GOWuX0Hpo7AmN1/PXnQlUrC0QdFiuoSJGPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvEvtfzvjQFXcPiawbqIU3QS4ZJaaP9l6rujJVUDl6E=;
 b=xMpUmAQW8krovwsS/kAl8zT+Id5Zg92NkV77sxa81BrjGNw2ONfoEF5tIyDdeNTFU5TYUDl9vaEaa7nLEPo1UcdogkuBP5h3hIbKpjIk90SWwftqwwBzCI+bPmBNHj7Sch3dSF9Se2rnYyCo9flMVSlHBSq3hYsZN3YWFDoOPFk=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB3656.namprd03.prod.outlook.com (2603:10b6:a02:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 07:16:28 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:16:28 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/16] iio: adc: max1027: Create a helper to configure the
 trigger
Thread-Topic: [PATCH 07/16] iio: adc: max1027: Create a helper to configure
 the trigger
Thread-Index: AQHXlCHbK6fK6v+wDUqyi1djUD2oVat7/bvg
Date:   Fri, 20 Aug 2021 07:16:28 +0000
Message-ID: <SJ0PR03MB635972378471C08B93E42C6099C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-8-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-8-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE9EZGxaRE5oTTJZdE1ERTROaTB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEZzNaV1F6WVRReExUQXhPRFl0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTkRBM01T?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGN6T0RZNU5UUTROVE14SWlCb1BTSTFWbVJOTVc5?=
 =?utf-8?B?dlVqRXlLMVJhV0dRd1kxZE1Uamt3VDAxdGNHTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVUjZPREJXUzJzMVdGaEJXa0phVlcxVmJsWnRhVGhyUm14VFds?=
 =?utf-8?B?TmtWMkZNZDBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVUpQV1VkalowRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZDYUVGSVNVRmhVVUpv?=
 =?utf-8?B?UVVZNFFWcEJRbkJCUjAxQlpFRkNjRUZIT0VGaVowSm9RVWhKUVdWUlFtWkJT?=
 =?utf-8?B?RkZCWVZGQ2JFRklTVUZOVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIw?=
 =?utf-8?B?VkJZMmRDY0VGSFJVRllkMEpyUVVkclFWbDNRakJCUjJ0QlluZENkVUZIUlVG?=
 =?utf-8?B?alowSTFRVVk0UVdSQlFuQkJSMVZCWTJkQmVVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZC?=
 =?utf-8?B?UVVFOUlpOCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf: true
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80008fee-281c-4fe5-d905-08d963aa6db5
x-ms-traffictypediagnostic: BYAPR03MB3656:
x-microsoft-antispam-prvs: <BYAPR03MB3656F17A32609B33CE6FA01099C19@BYAPR03MB3656.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzwJseBKVPMffWQ8oyJxTjLD0OgOLXOsh/eAomXe35Hxh8X3ItBi9RFeN64PwOJ/azYJ+wAOUeCfvpxyVqLB2K+FmEqo09/8n2krJVEQnDdiV89Zul5STzw30ObDDXUP4hm5fGPlSv41sKiVlHYQuyC7/pfyplfFel2zQ5PXaBrOMRbyR4vZRBaLtHXm4kp+4sXL5GYwRMCLfHsIJEh7PerASGeK8RWZG7IAxLdKyGXZteoEN7zR2tJa6Bu1Y+P8WEBi0S1h9h7oy3a3Lh1MS9brKzAdVU1FZ4jqbvA2ZQ2JCV0kvmSZhe31watlpBdkdZmKXw/dQPybNGlOEzCbJw4AWV5aCypezCD3BFuErXUkZAfqubejqYxq3EsIhqfsXFoSrQgDFipMrPbFt3vm7EifgB268oM3WCfuDGBjNF4BADc8JX2i9oqW1FHa86OHwqlW4f2OKBUv07u8I/96PNJVQGWhrnpytLqDjiT8tUVDZF9/Hinqf/gYyLkFcfmmq3e40U0oAuGMGm0Gg/nUqC+shppiQsP1HRAyC+rIQTNnkdMT24tpMrflKWA9dxKQ71JsTg9eDJ0lTTqrWEvCJ23EwmhUWlk0AdGRaPJrOlGYcubgKrDHYKdIq1aidMNLwzfeYotSL/ykjlpeYIPIDnTcNC7Pdhn4KWRg6ozUqwkvx7+hEomISdn5w4fmVTUVztXrHlzqglultnoFyigBsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(66946007)(478600001)(186003)(76116006)(53546011)(66476007)(6506007)(38100700002)(5660300002)(38070700005)(110136005)(122000001)(66446008)(64756008)(66556008)(54906003)(8676002)(316002)(4326008)(7696005)(52536014)(26005)(71200400001)(33656002)(8936002)(86362001)(2906002)(9686003)(55016002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1dUbFI1SWcvZHNVTGFRZ0ZpeEJsOWJ6bFdlSElxeVcwSkxzRUFzbXVkTDNW?=
 =?utf-8?B?aW1qSGlXeHB4YnJJbi8xU3YySzhWbjFmeC9oWldCeFBXd2VUcnJYVUg3NVcx?=
 =?utf-8?B?YTUraVgvcE80anJ5cHJ1SW1BamM2bk15WXY0WlhCREJHeFc5RWZLT1h4ajNH?=
 =?utf-8?B?RHdHMDNtN1ZzSmxBekM3TmRiVDJpNDE2cDFHT1VaaEc2dWFEcmFZZndUMVNC?=
 =?utf-8?B?U3h6YlJFWmxmTTZTdnA4cU42eFJPZnVDeVoyTTlKWVQ2ZWNMbmNuRWFxM2dh?=
 =?utf-8?B?MUREaTA5c0VPcEZMRHVCSWp2MENPZHB5cEVlQXJUaWtzTzVTNFpaWGJzTnBM?=
 =?utf-8?B?TWNwMGVEUmNDR1RKTVBUM0JwQmJsT3Q1a1BNUmRqQ1VoY0hJejhCcVdpc0pG?=
 =?utf-8?B?cDJ6aktPeE8wN2hZNjE5VGxSaGNINmpZZ0RCRU1jYTV3RjErUkcrNlF6MFVr?=
 =?utf-8?B?MmNNWjk3V3RjeDNySktKMnIzM0p2eGNzelZoakh0WE51dXVncWdTcWJwWSth?=
 =?utf-8?B?WHRPaTdCL2JTa1NNNHoxQk1GSU54ZVc0aG5CM1VpTE1yK2dsS3NTNENpdDJj?=
 =?utf-8?B?WVMrZTQ3TVcwa3U3SG1LbGRLSVp2SjdpeTVpWUJFbWVOUEhvQTViNmVsR09i?=
 =?utf-8?B?T3lrWEhaYmMzZGJRS29FS1orL2g5ekQ2bmpmbmxLak9OSGFBL2VndlFmWkdr?=
 =?utf-8?B?d1NRb2NGQW1BSTJXTUlmMUlvazZzR2RtMXRpNHZodzI4VjBMck5sTDJxOU8w?=
 =?utf-8?B?Z3ZjcnZ0a2FJNFptUzhCbTlhU2p0a1dUR0JIU1ZWdU0rTkVjU1VPUmluejly?=
 =?utf-8?B?alk4SVpOMk9zRmVodjFDbDk1R2NkSW5vaU41Y1RLTG1TOThjK0YvaUJSVWtB?=
 =?utf-8?B?TjNHUm1JZlcxUWlNYXRubG5ydGpHeDJnQjJvbU1yL2gxTUc3TkZ4cWwzSC9E?=
 =?utf-8?B?NFpENW1ReVlwNWFTbG10VHhVQ2h0M3QxQklmMGsyOHNYUFhlZDRKYVJOVStq?=
 =?utf-8?B?MXlpVTQ4RHY2Qmsra1dFaFFGSlRtZkpiU0FRR0l5Y3FpUFhSRnRBZndqbEh1?=
 =?utf-8?B?eERCeU12Z1UwbzdVeVZxSnNBaEx1QmF2Ni9Cdmtjb04vYnByZmQrQm1yb2I5?=
 =?utf-8?B?M2RrdGZmNWhadzZ2YkhYY0t3L1BiaDI4UXVicjlzaG1jK2ZIMGxoUUNpc05D?=
 =?utf-8?B?WEZVSlZKZlYvcmtLOUt0SG1UdlcyazhNUmN0aDZlbWFLTnJaQ1RxOThmMCtK?=
 =?utf-8?B?WjViVmcva1NBUGkvSkt5eE4wOGl3SFYxWkFydTNWSHZ5UUgwZTR6S3JTY3V6?=
 =?utf-8?B?M2J2OTd3c0c0TGJ0YkJWd0Z2TFFGQUloWmRSak5LeHlwQTNKSnRVY29ndzJq?=
 =?utf-8?B?TGZOQTNPMWJuandEcTVtRUZqTjZUM0lXU09LLzlMZkcrUWhlaFQ5d0Z4MCtl?=
 =?utf-8?B?RytJUVltMGp1Wkhjb3BLVS9ES2xyL3NhemppNC8vaGJzTmpoUWRYQnpMWWVt?=
 =?utf-8?B?K1Q3K3Fpb2FsaEpkQ3dzc3p3ajljMUtJbGVCdlVLNlFuaEFOYVArY0pGaUx2?=
 =?utf-8?B?cFpOVUIyeWxDS3NKR1hPTklrNkJCRFBaWGlyQ0pCL3NFQ2lyM2JQbzVPSnZD?=
 =?utf-8?B?UlUrL2JRV0tvbnBXWHdvUkVvai83WWlIdEhrRWtZNUMvWFZoUnBPcnVjN1BS?=
 =?utf-8?B?UEs5aXN0YkNwVnpwdkN6RXZYcWtQK01FOXVlcGZjZlFWQUtFRFo3YzJGZVI5?=
 =?utf-8?Q?o2qVOsMNcYTfbYPNs36XcuAEPYtQc9S7LwOiW+N?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80008fee-281c-4fe5-d905-08d963aa6db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:16:28.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zOd0RJzRGaIdPM078MKDrb6rsFxtamOcbD1HQOSz5G4YHU0HiFLfLerr9zs5MuNRxZMMCnV5JI1yx/Jaqkbqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3656
X-Proofpoint-ORIG-GUID: FvDmZkRHqlL1E7ZAzLZJDDhiIRGGdHzm
X-Proofpoint-GUID: FvDmZkRHqlL1E7ZAzLZJDDhiIRGGdHzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200042
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTgs
IDIwMjEgMToxMiBQTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBDYzogVGhvbWFzIFBl
dGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IGxpbnV4LQ0KPiBpaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMDcvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBDcmVhdGUgYSBoZWxwZXIgdG8gY29uZmlndXJlDQo+IHRoZSB0
cmlnZ2VyDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBUaGVyZSBhcmUgdHdvIHdheXMgdG8gcGh5
c2ljYWxseSB0cmlnZ2VyIGEgY29udmVyc2lvbjoNCj4gLSBBIGZhbGxpbmcgZWRnZSBvbiB0aGUg
Y252c3QgcGluDQo+IC0gQSB3cml0ZSBvcGVyYXRpb24gb24gdGhlIGNvbnZlcnNpb24gcmVnaXN0
ZXINCj4gDQo+IExldCdzIGNyZWF0ZSBhIGhlbHBlciBmb3IgdGhpcy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9paW8vYWRjL21heDEwMjcuYyB8IDUyICsrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tDQo+IC0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCsp
LCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbWF4
MTAyNy5jIGIvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0KPiBpbmRleCBhNmViYzk1MWMwOWEu
LjU5OTE0ZmNmZDMyMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0K
PiArKysgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+IEBAIC0yMzIsMTAgKzIzMiwzNyBA
QCBzdHJ1Y3QgbWF4MTAyN19zdGF0ZSB7DQo+ICAJc3RydWN0IGlpb190cmlnZ2VyCQkqdHJpZzsN
Cj4gIAlfX2JlMTYJCQkJKmJ1ZmZlcjsNCj4gIAlzdHJ1Y3QgbXV0ZXgJCQlsb2NrOw0KPiAtDQo+
ICsJYm9vbAkJCQljbnZzdF90cmlnZ2VyOw0KPiAgCXU4CQkJCXJlZyBfX19fY2FjaGVsaW5lX2Fs
aWduZWQ7DQo+ICB9Ow0KPiANCj4gK3N0YXRpYyBpbnQgbWF4MTAyN19jb25maWd1cmVfdHJpZ2dl
cihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiArew0KPiArCXN0cnVjdCBtYXgxMDI3X3N0
YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXN0
LT5yZWcgPSBNQVgxMDI3X1NFVFVQX1JFRyB8IE1BWDEwMjdfUkVGX01PREUyOw0KPiArDQo+ICsJ
LyoNCj4gKwkgKiBTdGFydCBhY3F1aXNpdGlvbiBvbjoNCj4gKwkgKiBNT0RFMDogZXh0ZXJuYWwg
aGFyZHdhcmUgdHJpZ2dlciB3aXJlZCB0byB0aGUgY252c3QgaW5wdXQNCj4gcGluDQo+ICsJICog
TU9ERTI6IGNvbnZlcnNpb24gcmVnaXN0ZXIgd3JpdGUNCj4gKwkgKi8NCj4gKwlpZiAoc3QtPmNu
dnN0X3RyaWdnZXIpDQo+ICsJCXN0LT5yZWcgfD0gTUFYMTAyN19DS1NfTU9ERTA7DQo+ICsJZWxz
ZQ0KPiArCQlzdC0+cmVnIHw9IE1BWDEwMjdfQ0tTX01PREUyOw0KPiArDQo+ICsJcmV0ID0gc3Bp
X3dyaXRlKHN0LT5zcGksICZzdC0+cmVnLCAxKTsNCj4gKwlpZiAocmV0IDwgMCkgew0KPiArCQlk
ZXZfZXJyKCZpbmRpb19kZXYtPmRldiwNCj4gKwkJCSJGYWlsZWQgdG8gY29uZmlndXJlIHJlZ2lz
dGVyICglZClcbiIsIHJldCk7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KDQpJIGRvIG5vdCB0
aGluayB0aGUgZXJyb3IgbWVzc2FnZSBpcyBzbyBpbXBvcnRhbnQgaGVyZSB0aGF0IHdlIGNhbm5v
dA0KbWFrZSB0aGlzIG1vcmUgc2ltcGxlIGFuZCBqdXN0IGRvOg0KDQpyZXR1cm4gc3BpX3dyaXRl
KHN0LT5zcGksICZzdC0+cmVnLCAxKTsNCg0KQW55d2F5cywgbm90IHRoYXQgaW1wb3J0YW50IHNv
Og0KDQpSZXZpZXdlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCg0KPiArCXJl
dHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IG1heDEwMjdfcmVhZF9zaW5nbGVfdmFs
dWUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwNCj4gIAkJCQkgICAgIHN0cnVjdCBpaW9fY2hh
bl9zcGVjIGNvbnN0ICpjaGFuLA0KPiAgCQkJCSAgICAgaW50ICp2YWwpDQo+IEBAIC0yNDgsMTQg
KzI3NSw5IEBAIHN0YXRpYyBpbnQgbWF4MTAyN19yZWFkX3NpbmdsZV92YWx1ZShzdHJ1Y3QNCj4g
aWlvX2RldiAqaW5kaW9fZGV2LA0KPiAgCQlyZXR1cm4gLUVCVVNZOw0KPiAgCX0NCj4gDQo+IC0J
LyogU3RhcnQgYWNxdWlzaXRpb24gb24gY29udmVyc2lvbiByZWdpc3RlciB3cml0ZSAqLw0KPiAt
CXN0LT5yZWcgPSBNQVgxMDI3X1NFVFVQX1JFRyB8IE1BWDEwMjdfUkVGX01PREUyIHwNCj4gTUFY
MTAyN19DS1NfTU9ERTI7DQo+IC0JcmV0ID0gc3BpX3dyaXRlKHN0LT5zcGksICZzdC0+cmVnLCAx
KTsNCj4gLQlpZiAocmV0IDwgMCkgew0KPiAtCQlkZXZfZXJyKCZpbmRpb19kZXYtPmRldiwNCj4g
LQkJCSJGYWlsZWQgdG8gY29uZmlndXJlIHNldHVwIHJlZ2lzdGVyXG4iKTsNCj4gKwlyZXQgPSBt
YXgxMDI3X2NvbmZpZ3VyZV90cmlnZ2VyKGluZGlvX2Rldik7DQo+ICsJaWYgKHJldCkNCj4gIAkJ
cmV0dXJuIHJldDsNCj4gLQl9DQo+IA0KPiAgCS8qIENvbmZpZ3VyZSBjb252ZXJzaW9uIHJlZ2lz
dGVyIHdpdGggdGhlIHJlcXVlc3RlZCBjaGFuICovDQo+ICAJc3QtPnJlZyA9IE1BWDEwMjdfQ09O
Vl9SRUcgfCBNQVgxMDI3X0NIQU4oY2hhbi0NCj4gPmNoYW5uZWwpIHwNCj4gQEAgLTM2MywxMiAr
Mzg1LDEwIEBAIHN0YXRpYyBpbnQNCj4gbWF4MTAyN19zZXRfY252c3RfdHJpZ2dlcl9zdGF0ZShz
dHJ1Y3QgaWlvX3RyaWdnZXIgKnRyaWcsIGJvb2wgc3RhdGUpDQo+ICAJaWYgKGJpdG1hcF9lbXB0
eShpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2ssIGluZGlvX2Rldi0NCj4gPm1hc2tsZW5ndGgp
KQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+ICsJc3QtPmNudnN0X3RyaWdnZXIgPSBzdGF0
ZTsNCj4gIAlpZiAoc3RhdGUpIHsNCj4gLQkJLyogU3RhcnQgYWNxdWlzaXRpb24gb24gY252c3Qg
Ki8NCj4gLQkJc3QtPnJlZyA9IE1BWDEwMjdfU0VUVVBfUkVHIHwNCj4gTUFYMTAyN19DS1NfTU9E
RTAgfA0KPiAtCQkJICBNQVgxMDI3X1JFRl9NT0RFMjsNCj4gLQkJcmV0ID0gc3BpX3dyaXRlKHN0
LT5zcGksICZzdC0+cmVnLCAxKTsNCj4gLQkJaWYgKHJldCA8IDApDQo+ICsJCXJldCA9IG1heDEw
MjdfY29uZmlndXJlX3RyaWdnZXIoaW5kaW9fZGV2KTsNCj4gKwkJaWYgKHJldCkNCj4gIAkJCXJl
dHVybiByZXQ7DQo+IA0KPiAgCQkvKg0KPiBAQCAtMzgyLDEwICs0MDIsOCBAQCBzdGF0aWMgaW50
DQo+IG1heDEwMjdfc2V0X2NudnN0X3RyaWdnZXJfc3RhdGUoc3RydWN0IGlpb190cmlnZ2VyICp0
cmlnLCBib29sIHN0YXRlKQ0KPiAgCQkJcmV0dXJuIHJldDsNCj4gIAl9IGVsc2Ugew0KPiAgCQkv
KiBTdGFydCBhY3F1aXNpdGlvbiBvbiBjb252ZXJzaW9uIHJlZ2lzdGVyIHdyaXRlICovDQo+IC0J
CXN0LT5yZWcgPSBNQVgxMDI3X1NFVFVQX1JFRyB8DQo+IE1BWDEwMjdfQ0tTX01PREUyCXwNCj4g
LQkJCSAgTUFYMTAyN19SRUZfTU9ERTI7DQo+IC0JCXJldCA9IHNwaV93cml0ZShzdC0+c3BpLCAm
c3QtPnJlZywgMSk7DQo+IC0JCWlmIChyZXQgPCAwKQ0KPiArCQlyZXQgPSBtYXgxMDI3X2NvbmZp
Z3VyZV90cmlnZ2VyKGluZGlvX2Rldik7DQo+ICsJCWlmIChyZXQpDQo+ICAJCQlyZXR1cm4gcmV0
Ow0KPiAgCX0NCj4gDQo+IC0tDQo+IDIuMjcuMA0KDQo=
