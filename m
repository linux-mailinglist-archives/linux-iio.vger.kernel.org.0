Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D093B60C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbfFJNb2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 09:31:28 -0400
Received: from mail-eopbgr710073.outbound.protection.outlook.com ([40.107.71.73]:63568
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390345AbfFJNb2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Jun 2019 09:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5aummxxU1hYNcU4kpvKgQlJrTanJ8YpXj96zFsOaw0=;
 b=x6+0Y7Qh9uIEheDQYsUUVNOHxF+83Up5PPDi8sYwQheFToGVO1ggNk8FYfglioRo8oSAvkp67SneRhgJ9xYUnX0Fk+7nQuLUbTOqbw5Xb8f30v/1KoHqfJSpjwwV5UtUD5Ftqoax43UPkWbL6oZmabGOUBrPvC12lz7lOuoEhiI=
Received: from BN3PR03CA0115.namprd03.prod.outlook.com (2603:10b6:400:4::33)
 by BN6PR03MB3123.namprd03.prod.outlook.com (2603:10b6:405:44::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Mon, 10 Jun
 2019 13:31:25 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN3PR03CA0115.outlook.office365.com
 (2603:10b6:400:4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15 via Frontend
 Transport; Mon, 10 Jun 2019 13:31:25 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Mon, 10 Jun 2019 13:31:25 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5ADVO5U021077
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Jun 2019 06:31:24 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Mon, 10 Jun 2019 09:31:24 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [RFC] Supporting CLK frequencies above 4.29 Ghz
Thread-Topic: [RFC] Supporting CLK frequencies above 4.29 Ghz
Thread-Index: AQHVH5DMT+gj9BELpEK8P9ZZfFsVrg==
Date:   Mon, 10 Jun 2019 13:31:23 +0000
Message-ID: <3cceaaaa8fbbc0086dccbd6b009129c05519bdc0.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B03CB295FEC9F54E8793CC9A7CB694B4@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(199004)(189003)(2351001)(2501003)(126002)(305945005)(36756003)(8936002)(70206006)(70586007)(476003)(486006)(450100002)(7636002)(2616005)(966005)(26005)(7736002)(186003)(8676002)(246002)(2906002)(102836004)(14454004)(478600001)(6116002)(316002)(5640700003)(3846002)(54906003)(50466002)(106002)(47776003)(5660300002)(6306002)(6916009)(118296001)(336012)(86362001)(2486003)(23676004)(7696005)(426003)(436003)(356004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3123;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50f44bfa-676e-46dd-0146-08d6eda7ef9d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BN6PR03MB3123;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3123:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <BN6PR03MB31235A52B342FD703E75C42BF9130@BN6PR03MB3123.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0064B3273C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: S73Pj6jUt6DTYVd3HrAhj79Igx9aeRdRKRMdK7JIbTpg/exyZaGWAayHxzJpy7qNnicoPgd3EbWsGnnmiS3jHuceftV4MyBTqls3e7seQz9XH2fqqYJ/58N0ypzFRBrHYDJmrfQm38ITDYl3D46FJrYeWR6nDpcRDJBae2rMk1YwEybIQjpwGzQ101+jrzmaqyquz7bTIxGNfptMfF6vPD5aU1pCH11brsyupshO8C/t+0rllmqdzL33fHkh4Pd+0bKtkynIIMokugex3aZjxqpUUyQl5k1L2zV08yvt8sXty9awpTivIiYsyv2Ow7HZ2UOQypf8nIL6R1/IQadZmu3FbMa8+42+SQBZ//Em5Uy9B8dug1wYKPnBEcAgvnm7o0h4ZuQzuCXI1TZ+g4neDYb2iGytcrFUkZoFk0ADMUM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2019 13:31:25.1456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f44bfa-676e-46dd-0146-08d6eda7ef9d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGV5LA0KDQoNClRoaXMgZW1haWwgaXMgdGFyZ2V0ZWQgbW9zdGx5IHRvIHRoZSBDTEsgc3Vic3lz
dGVtL2ZyYW1ld29yay4NCldlJ3ZlIGluY2x1ZGVkIHRoZSBJSU8gc3Vic3lzdGVtIGFzIHdlbGws
IGFzIHRoZSBkcml2ZXJzIHRoYXQgd2UnbGwgY29uc2lkZXIgd3JpdGluZyB3aWxsIGJlIGFkZGVk
IHVuZGVyDQpkcml2ZXJzL2lpby9mcmVxdWVuY3kgYW5kIHJlZ2lzdGVyIGFzIFtPRl0gQ0xLIHBy
b3ZpZGVycy4NClRoZSByZWFzb24gZm9yIGluY2x1ZGluZyB0aGVtIHVuZGVyIElJTywgaXMgdHlw
aWNhbGx5IHRoZSBmYWN0IHRoYXQgd2UgcHJlZmVyL2xpa2UgdGhlIHN5c2ZzIGNvbnRyb2wgdGhh
dCBJSU8gaGFzLg0KDQpMb25nLXN0b3J5LXNob3J0ICh0aGUgaW50cm8gd2Fzbid0IHRvbyBzaG9y
dCksIHdlIGhhdmUgc29tZSBDTEsgY2hpcHMgdGhhdCB3ZSdyZSB3cml0aW5nIHNvbWUgZHJpdmVy
cyBmb3IsIHRoYXQgZ28gdXAgdG8NCjMyIEdoei4gQW5kIHdlIGhhdmUgYSBmZXcgbW9yZSBvZiB0
aGVtIHRoYXQgZ28gYWJvdmUgNC4yOSBHaHouDQoNClRoZSBzdGFuZGFyZCBgY2xrX3tnZXQsc2V0
fV9yYXRlKClgIHN1cHBvcnQgb25seSBgdW5zaWduZWQgbG9uZ2AgKHUzMikuDQoNCkludGVybmFs
bHkgKGluIG91ciB0cmVlKSB3ZSB1c2UgYW4gbWVjaGFuaXNtIChub3QgdXBzdHJlYW1lZCkgZm9y
IHdvcmtpbmcgYXJvdW5kIHRoZSA0LjI5IEdoeiBjYXAsIGJ5IHByb3ZpZGluZw0KbXVsdGlwbGll
cnMvc2NhbGVzLg0KQW5kIHNvbWUgZ2V0L3NldCB2YXJpYW50cywgY2FsbGVkIGBjbGtfe2dldCxz
ZXR9X3JhdGVfc2NhbGVkKClgDQpFeGFtcGxlczoNCmh0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dk
ZXZpY2VzaW5jL2xpbnV4L2Jsb2IvbWFzdGVyL2luY2x1ZGUvbGludXgvY2xrL2Nsa3NjYWxlLmgN
Cmh0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dkZXZpY2VzaW5jL2xpbnV4L2NvbW1pdC9mNjFhNjdl
YzY1YjkxOTEwMjFkN2FmYTU2ZDM5YWJlOTU1YWMwZDQxI2RpZmYtMTE4ODg2NDI5Yzk0ZTY1Nzdm
YmU1ZmU1OGI5OGU0OTgNCg0KQnV0LCB3ZSB0aG91Z2h0IHdlJ2Qgc3RhcnQgYSBkaXNjdXNzaW9u
L1JGQyBhYm91dCBwb3RlbnRpYWxseSBzd2l0Y2hpbmcgZnJvbSB1MzIgKG9yIHVuc2lnbmVkIGxv
bmcpIHRvIHU2NCAodW5zaWduZWQNCmxvbmcgbG9uZykgdHlwZXMuDQpUaGF0IHdvdWxkIGFsbG93
IGZvciBzaWduaWZpY2FudGx5IGhpZ2hlciBmcmVxdWVuY2llcyB0aGFuIDQuMjlHaHoganVzdCB2
aWEgYGNsa197Z2V0LHNldH1fcmF0ZSgpYA0KDQpUaGVyZSBhcmUgc29tZSBodXJkbGVzIHRvIGRv
IGl0LCBhcyBtYW55IGRyaXZlcnMgc2hvdWxkIG5lZWQgc29tZSBpbnZlc3RpZ2F0aW9uL2NoYW5n
aW5nLg0KSSdkIGJlIHdpbGxpbmcgdG8gaGVscCB3aXRoIHRoZSBjb252ZXJzaW9uIGlmIHRoYXQn
cyBhIHBsYW4uDQoNCldoYXRldmVyIHRoZSBjb25zZW5zdXMgd291bGQgYmUgKHN3aXRjaGluZyB0
byB1NjQsIG9yIGltcGxlbWVudGluZyBhIGNsb2NrX3NjYWxlIHN0cnVjdC9tZWNoYW5pc20pIGlz
IGZpbmUgZnJvbSBteSBzaWRlLg0KV2Ugd291bGQgZmluZCBhIHdheSB0byBhZGFwdCBvdXIgZHJp
dmVycyB0byBlaXRoZXIgdmFyaWFudC4NCkludGVybmFsbHkgKGluIG91ciBncm91cCksIHRoZXJl
IGlzIGEgcHJlZmVyZW5jZSB0byB0aGUgc3dpdGNoIHRvIHU2NC4NCg0KVGhhbmtzDQpBbGV4DQo=
