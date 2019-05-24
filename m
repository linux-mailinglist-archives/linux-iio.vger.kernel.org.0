Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9812F2959D
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2019 12:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbfEXKVu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 06:21:50 -0400
Received: from mail-eopbgr720061.outbound.protection.outlook.com ([40.107.72.61]:8032
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389448AbfEXKVt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 May 2019 06:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBGRAchov8McEUo4wsoFXcPR3NM+rkOltDE1yLx6KkI=;
 b=YQ12KJ5lEnnlThPQ9F4KYM/CTlUQLBQURE74yuAOwGLtosm74b7SsHvR4/P/JisMzQpQL6ZiekG+8CkW+DarZpBK0WJ4GoBd9HLuFj1Div7MvvWKs+ItcY9ZHwP+orU+Bru/WEDMZ6PvYb+vatC+vCs9MfE6SKW/F7OKsGP77sA=
Received: from BN8PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:94::36)
 by DM2PR03MB559.namprd03.prod.outlook.com (2a01:111:e400:241d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.18; Fri, 24 May
 2019 10:21:46 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN8PR03CA0023.outlook.office365.com
 (2603:10b6:408:94::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16 via Frontend
 Transport; Fri, 24 May 2019 10:21:46 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Fri, 24 May 2019 10:21:45 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4OALhq9006318
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 24 May 2019 03:21:43 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Fri, 24 May 2019 06:21:43 -0400
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "lucasseikioshiro@gmail.com" <lucasseikioshiro@gmail.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: accel: adxl372: switch to YAML
 bindings
Thread-Topic: [PATCH] dt-bindings: iio: accel: adxl372: switch to YAML
 bindings
Thread-Index: AQHVDcR5Mci+C5pEPkCeH1oSCxQ8+aZ6XHsA
Date:   Fri, 24 May 2019 10:21:42 +0000
Message-ID: <1558693302.3462.1.camel@analog.com>
References: <20190518215542.25140-1-lucasseikioshiro@gmail.com>
In-Reply-To: <20190518215542.25140-1-lucasseikioshiro@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.224.122]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C53913FE1EB7043B92DC25F23B0CAC3@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(199004)(189003)(356004)(14454004)(4744005)(7696005)(2201001)(72206003)(76176011)(86362001)(478600001)(4326008)(2501003)(23676004)(47776003)(50466002)(7416002)(5660300002)(106002)(2486003)(36756003)(8936002)(446003)(8676002)(11346002)(6116002)(3846002)(110136005)(476003)(436003)(2906002)(486006)(426003)(2616005)(70206006)(70586007)(126002)(54906003)(336012)(102836004)(186003)(7736002)(7636002)(246002)(6246003)(229853002)(316002)(103116003)(305945005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB559;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c707a740-9775-4ded-6528-08d6e0319fbe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:DM2PR03MB559;
X-MS-TrafficTypeDiagnostic: DM2PR03MB559:
X-Microsoft-Antispam-PRVS: <DM2PR03MB559EC87CBE7CAF5F97098709D020@DM2PR03MB559.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0047BC5ADE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vtCwws6f0h+/LNkCf9fAR3AToe7pY2+FHu6ERXib3h8AH+GQzBvf8/oaTJHo/lMf0xHWhH5KmDLD+KQzopqqnEIHXmWnr1WpnrJHJOzSWe0Eh4YsDAy5VApGV6eT5vnKjxYf0MHG6yqRwPRdRRsfKYZiS7OjxiyHrJ3NWeuVff5rdOulMp/qgq5fIsD6iDQQhqP1i46o/RY3mN/eSQgI1hP7bmSqK0/aAd9JzZXrUiGu8YiNaTTgvIizhmX5fKHF9vq1M+FKkZNc/HROKNZrSd83eHFwAqCYcsmsnHAiQh9wtlk5YmlyQIYQRniWEjXHqEGqgFvhm6LaULoRC3v24G2MPQqrpERNIADZJOelMJsGsRvrb100iqXeFT00QMHEAVkyCECmefQrWq8zYKp4MW9G2k44+wPbE5+6h+1pGyU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2019 10:21:45.0042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c707a740-9775-4ded-6528-08d6e0319fbe
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB559
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2IsIDIwMTktMDUtMTggYXQgMTg6NTUgLTAzMDAsIEx1Y2FzIE9zaGlybyB3cm90ZToNCj4g
W0V4dGVybmFsXQ0KPiANCj4gDQo+IENvbnZlcnQgdGhlIG9sZCBkZXZpY2UgdHJlZSBkb2N1bWVu
dGF0aW9uIHRvIHlhbWwgZm9ybWF0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHVjYXMgT3NoaXJv
IDxsdWNhc3NlaWtpb3NoaXJvQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUm9kcmlnbyBS
aWJlaXJvIDxyb2RyaWdvcnNkY0BnbWFpbC5jb20+DQo+IENvLWRldmVsb3BlZC1ieTogUm9kcmln
byBSaWJlaXJvIDxyb2RyaWdvcnNkY0BnbWFpbC5jb20+DQo+IC0tLQ0KPiANCj4gSGVsbG8sDQo+
IFdlJ3ZlIGFkZGVkIFN0ZWZhbiBQb3BhIGFzIG1haW50YWluZXIgb2YgdGhlIHlhbWwgZG9jdW1l
bnRhdGlvbiBvZiB0aGlzDQo+IGRyaXZlcg0KPiBiZWNhdXNlIHdlIGZvdW5kIHRocm91Z2ggZ2l0
IHRoYXQgaGUgd2FzIHRoZSBhdXRob3Igb2YgdGhlIG9sZGVyDQo+IGRvY3VtZW50YXRpb24uDQoN
CkFja2VkLWJ5OiBTdGVmYW4gUG9wYSA8c3RlZmFuLnBvcGFAYW5hbG9nLmNvbT4=
