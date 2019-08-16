Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD068FABF
	for <lists+linux-iio@lfdr.de>; Fri, 16 Aug 2019 08:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfHPGRQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Aug 2019 02:17:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:50946 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbfHPGRQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Aug 2019 02:17:16 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7G62agO029430;
        Fri, 16 Aug 2019 02:16:31 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ud8vh9we6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 02:16:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtTcCA/Lc9IVtaM0s1oZPYgZYWzh5NOS6dRQsFE8Fjns3VTqRkdvW8y0tWdHGG1uX+218livSCaICiDr1UtfFezQU9cEohKJvp9x0L1roJU02MXazKu+TPrsXVy+XPAkhMokVQ7yi54G1WujItT0iSoDtyZMyCq8PbLQDasy1fcSS+dy1A5n5VXIKdrHkCKaXpctO85blykGtxCNV34ywUziHMQDr+DyxIjRkBhYgvCr/Bugt7EjQxedJqYJjFZU5lOdf0razyVxAm9o4Dg6kAe6+NYDFeoycg4rv6wi8B/kTsloUtx/U5vuo2VAYlJipsvy53vDvFnIEC6Iu7DEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7nFq1yuNviaGuBAh8K9RJE10/Pxl+uqz5VtovTa48M=;
 b=d3ZlSydyuUcPTSIScgKMr0z8PJbUCOtSGhEfN8302nKQX0V1+j/sPGRiHMGB9DgFwlAa1hlt0ALLvl5tFFu9k5K9BnSj7k348a7aeX6BX+hR5QyZMedhXphqv0jyA1UEbAX/l8IqNuVn5L/ftV30EHqauM8ZfzeBsWZxeAeihxRrRJX0AX0toWMNkWqoFU2MLWBFZaa6ArSQKYgdbZ0sPp+P+yubyabi1crLJTc9n2W+8oomg30UMLtptVWsl+CdxpL3ofV0tmKniIktRs88ItV6Uo2Gl5z1VuZw5W0NgicYGPeNM6IcR3ajHu/e8bLwJNpnp0KkMldC8kdiHBxJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7nFq1yuNviaGuBAh8K9RJE10/Pxl+uqz5VtovTa48M=;
 b=yHhjG65ZH5tg53gBGtXj3sm8Y1iEd+w+LcG6XJo6rjPg9giu4RdePNcQQNmM8hrqbXu1yfSQw+aQ1ma6zOIrtvYwwti0bEAO6gfK8wwU9ru3bykppJaTgT8TupecxnJfP+VdwWfwhWFPLwdDxfH8FCHDA0f3RanLqu5XoawquNU=
Received: from BN6PR03CA0061.namprd03.prod.outlook.com (2603:10b6:404:4c::23)
 by DM5PR03MB2587.namprd03.prod.outlook.com (2603:10b6:3:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15; Fri, 16 Aug
 2019 06:16:28 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR03CA0061.outlook.office365.com
 (2603:10b6:404:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Fri, 16 Aug 2019 06:16:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Fri, 16 Aug 2019 06:16:28 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7G6GR2Y016154
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 15 Aug 2019 23:16:27 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Fri, 16 Aug 2019 02:16:27 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5380: fix incorrect assignment to val
Thread-Topic: [PATCH] iio: dac: ad5380: fix incorrect assignment to val
Thread-Index: AQHVU2DVcUTbIyeCc0SBNqWjcq+zu6b9kIuA
Date:   Fri, 16 Aug 2019 06:16:26 +0000
Message-ID: <876a4d5190828619f75365863cc6bf2cfea4ffea.camel@analog.com>
References: <20190815115846.21800-1-colin.king@canonical.com>
In-Reply-To: <20190815115846.21800-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.113]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <833613ECA080C2478097736B0521250A@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(189003)(199004)(36756003)(229853002)(6246003)(14454004)(2501003)(3846002)(4326008)(186003)(336012)(8676002)(478600001)(6116002)(8936002)(7736002)(305945005)(7636002)(436003)(2201001)(86362001)(26005)(102836004)(476003)(7696005)(356004)(23676004)(110136005)(76176011)(426003)(106002)(246002)(118296001)(126002)(70206006)(11346002)(47776003)(2616005)(14444005)(446003)(5660300002)(2486003)(50466002)(70586007)(486006)(2906002)(54906003)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2587;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c4babc2-4314-4418-f885-08d72211464e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DM5PR03MB2587;
X-MS-TrafficTypeDiagnostic: DM5PR03MB2587:
X-Microsoft-Antispam-PRVS: <DM5PR03MB2587142E38E7BFBB0F2CE90EF9AF0@DM5PR03MB2587.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0131D22242
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jSCLMuc/+wZO/p0EgK4ViwjIwA3mw1NYY2vypapzMMTzDJMm25rK/6dxNPyRD+4PrCr+3C7qacMnJmuYueAO4s5WjXFdGA/xSyJGt1AC+LnZcVYsikKpMRZBvEtG8WsRNP2b8M/voM7YJcAsSU9WOqeQ+bSmb/tTgLRUfHGqREb2F6O+MUEkvMbwoC/TTpoHGW4XMLZMDoXQPb/Al0IweLyWlgpA+Zpl9/U/eWbkDu82d3B28paiYzccfeXL0PKSs3aiK/PJagSoxmN0c8uLvrUctEAr+JcwIRia4ZzOih2P1s8H4IZGcNv4ArBk1oxIJdVfqv8jwxPrdoZDgixRS2Jrvqtb/b+Er7eCxcOuzTr1F7jSstYssMJkJ6WHSBolAJ7B6iEcJnHlxtrVkgYvKg+FbWfhh3Hh2PUYLG3653k=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2019 06:16:28.4412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4babc2-4314-4418-f885-08d72211464e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2587
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160066
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTE1IGF0IDEyOjU4ICswMTAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5k
cnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4u
a2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gQ3VycmVudGx5IHRoZSBwb2ludGVyIHZhbCBpcyBi
ZWluZyBpbmNvcnJlY3RseSBpbmNyZW1lbnRlZA0KPiBpbnN0ZWFkIG9mIHRoZSB2YWx1ZSBwb2lu
dGVkIHRvIGJ5IHZhbC4gRml4IHRoaXMgYnkgYWRkaW5nDQo+IGluIHRoZSBtaXNzaW5nICogaW5k
aXJlY3Rpb24gb3BlcmF0b3IuDQo+IA0KPiBBZGRyZXNzZXMtQ292ZXJpdHk6ICgiVW51c2VkIHZh
bHVlIikNCj4gRml4ZXM6IGMwM2YyYzUzNjgxOCAoInN0YWdpbmc6aWlvOmRhYzogQWRkIEFENTM4
MCBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0Bj
YW5vbmljYWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2RhYy9hZDUzODAuYyB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2RhYy9hZDUzODAuYyBiL2RyaXZlcnMvaWlvL2RhYy9h
ZDUzODAuYw0KPiBpbmRleCA0MzM1MjE0ODAwZDIuLjJlYmUwODMyNjA0OCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9paW8vZGFjL2FkNTM4MC5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2RhYy9hZDUz
ODAuYw0KPiBAQCAtMjIwLDcgKzIyMCw3IEBAIHN0YXRpYyBpbnQgYWQ1MzgwX3JlYWRfcmF3KHN0
cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+ICAJCWlmIChyZXQpDQo+ICAJCQlyZXR1cm4gcmV0
Ow0KPiAgCQkqdmFsID4+PSBjaGFuLT5zY2FuX3R5cGUuc2hpZnQ7DQo+IC0JCXZhbCAtPSAoMSA8
PCBjaGFuLT5zY2FuX3R5cGUucmVhbGJpdHMpIC8gMjsNCj4gKwkJKnZhbCAtPSAoMSA8PCBjaGFu
LT5zY2FuX3R5cGUucmVhbGJpdHMpIC8gMjsNCj4gIAkJcmV0dXJuIElJT19WQUxfSU5UOw0KPiAg
CWNhc2UgSUlPX0NIQU5fSU5GT19TQ0FMRToNCj4gIAkJKnZhbCA9IDIgKiBzdC0+dnJlZjsNCg==
