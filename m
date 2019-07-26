Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2262D76601
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 14:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfGZMgh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 08:36:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12928 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfGZMgh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 08:36:37 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QCXwIC021429;
        Fri, 26 Jul 2019 08:36:13 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2050.outbound.protection.outlook.com [104.47.45.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ty2sxv56m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 08:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPbqZ0I82PqmdbRK2MQLmIKuf///fLPBjygqK/jxG4fhFY2pieiWcytIwrepu9nofE9EgqP6l10h2q2l/SxCgJLkBgdrB7Ywven+qlI/ur6uVUcZ5Ho9t5O7XSGuQWS/ZF//4bzd8qkrBT1hh16/PPhnkRmqvJkyqs889TtlyQDH8ocndUg1uc7aNRl+6g88UCTvFR15P4jXVZVGxBjM40bNSEuZpx6XbbMNqy89kminmiCwszW73gROt1JB2NShHmhCgfhBoo9zcoMUCFEZ3mYGnliB5Uqq6FE1pbQBuAtqF2n4Uejy90AkAnZKmwAY6hlkJvTZE0bCw2zBdpcAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oipdUjAK5hzmQ/JM4ou1UReGRW8SpoWHu+g2ENObC7E=;
 b=oCERLy0RNKGMSwy+b9OLiyQgpB70/7zagj9E8HHWh8TJf6f+QdCS1ctEQOdg/PgCrPpt8sXxMbN90T6sQH6YYd0lS4SxFq+aIawNwI0vJivN1IqSzMj6jjVu/GgDAy1MevfiTghqy1lpQfm0xgNAtuOCpmpnaczVmV0xhB6nULgr8R1T+lD4VKcP+fo2od4xaiQEvkO68Y5fMoAW9/TTgrsiFGVn0GdUC0sjQawtmzOAO6LmUpdi6g/rbhUGMnIL+EJtIHPNxNvNvPUQFH4AXT/iitIFuIeYWwlG045tJ3mXav5QLkEIcxL1ncPQgQYpkNnGi4xJlTWy1Elb9U2P+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=metafoo.de
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oipdUjAK5hzmQ/JM4ou1UReGRW8SpoWHu+g2ENObC7E=;
 b=P+ugyhvey3ZAmhs0GEJTeXSrYN7WlyJet/cCO4h9kQKrDFxH0urF0TqNk7rtdJxtyvKGDI8fEj2B7pOQOH8mdqYlk/aSqSO18Lco9BZUPzz4f6ZZItHE+qjC40CjZx3oKy1f5icM33bAQwxGKqaHDhGkFAFCtQYNWfUVvstT8EY=
Received: from BN6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:404:4c::34)
 by MWHPR03MB2526.namprd03.prod.outlook.com (2603:10b6:300:8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Fri, 26 Jul
 2019 12:36:10 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR03CA0072.outlook.office365.com
 (2603:10b6:404:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.14 via Frontend
 Transport; Fri, 26 Jul 2019 12:36:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Fri, 26 Jul 2019 12:36:09 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6QCa6AW021424
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 26 Jul 2019 05:36:06 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Fri, 26 Jul 2019 08:36:08 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "hslester96@gmail.com" <hslester96@gmail.com>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] staging: iio: ad2s1210: Use device-managed API
Thread-Topic: [PATCH] staging: iio: ad2s1210: Use device-managed API
Thread-Index: AQHVQ6JggMNP1PLwqUm0xUdXwlB9V6bdGScA
Date:   Fri, 26 Jul 2019 12:36:08 +0000
Message-ID: <b7c56658547a972b4e4a2b075b2319192f89c803.camel@analog.com>
References: <20190726110742.20445-1-hslester96@gmail.com>
In-Reply-To: <20190726110742.20445-1-hslester96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A63E865935245049BF784BE23277EBB9@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(86362001)(70586007)(70206006)(1411001)(26005)(102836004)(305945005)(7736002)(7636002)(2501003)(5640700003)(47776003)(3846002)(6116002)(50466002)(106002)(4326008)(6246003)(5660300002)(23676004)(2486003)(7696005)(76176011)(316002)(229853002)(486006)(8676002)(14454004)(476003)(2906002)(126002)(478600001)(2616005)(6916009)(36756003)(356004)(446003)(8936002)(186003)(11346002)(246002)(54906003)(118296001)(436003)(1361003)(336012)(426003)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2526;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b604bfbc-a126-40db-4f65-08d711c5d625
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:MWHPR03MB2526;
X-MS-TrafficTypeDiagnostic: MWHPR03MB2526:
X-Microsoft-Antispam-PRVS: <MWHPR03MB252687DDE7F692B3442099D6F9C00@MWHPR03MB2526.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 01106E96F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WWmZCy4Va2azmEZiYSskYl4CfsEmRVA9N0l+Efz8LsWiHN7vTF4rBKqY3bqcekm0CsFkhouqK5UTIMQnXm8EomoLr4QXKje4ma2MP0rbR/SBxml4bq6fhXdDhsHLbkgfHDrGs3e/XJawd6RMSJKVzEIF3dOk629OfbhejHX8U5teWVceOvILuAOVGFu9RJPAYK6IrEzDhgtl15OOyQkzfrfZqWbi4dxlRAdJJqR3+3HTSWV01/kQ4L1NCvLORJzaV6icvhCb0mQoHS4wX+AJFwETV9/KhxgbYicQIkNKRwpZ0pu2O7IZJyvqcWQh3hvLIQmexoc7n4CMEWnqm/srQOh87xttCetd4KaVrD3eeFueky5PCfHxRjZlkWreVncF5Ba/ERhR+yMU51fONRSj9ZTtH/BN7IFM7NOwfQQw0Bg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2019 12:36:09.4302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b604bfbc-a126-40db-4f65-08d711c5d625
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2526
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260155
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTI2IGF0IDE5OjA3ICswODAwLCBDaHVob25nIFl1YW4gd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFVzZSBkZXZpY2UtbWFuYWdlZCBBUEkgdG8gc2ltcGxpZnkgdGhl
IGNvZGUuDQo+IFRoZSByZW1vdmUgZnVuY3Rpb24gaXMgcmVkdW5kYW50IG5vdyBhbmQgY2FuDQo+
IGJlIGRlbGV0ZWQuDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRy
dS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVob25nIFl1
YW4gPGhzbGVzdGVyOTZAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3RhZ2luZy9paW8v
cmVzb2x2ZXIvYWQyczEyMTAuYyB8IDEyICstLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3N0YWdpbmcvaWlvL3Jlc29sdmVyL2FkMnMxMjEwLmMgYi9kcml2ZXJzL3N0YWdpbmcvaWlv
L3Jlc29sdmVyL2FkMnMxMjEwLmMNCj4gaW5kZXggMGMxYmQxMDhjMzg2Li40YjI1YTNhMzE0ZWQg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vcmVzb2x2ZXIvYWQyczEyMTAuYw0K
PiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL3Jlc29sdmVyL2FkMnMxMjEwLmMNCj4gQEAgLTY3
MSw3ICs2NzEsNyBAQCBzdGF0aWMgaW50IGFkMnMxMjEwX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNl
ICpzcGkpDQo+ICAJaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMgPSBBUlJBWV9TSVpFKGFkMnMxMjEw
X2NoYW5uZWxzKTsNCj4gIAlpbmRpb19kZXYtPm5hbWUgPSBzcGlfZ2V0X2RldmljZV9pZChzcGkp
LT5uYW1lOw0KPiAgDQo+IC0JcmV0ID0gaWlvX2RldmljZV9yZWdpc3RlcihpbmRpb19kZXYpOw0K
PiArCXJldCA9IGRldm1faWlvX2RldmljZV9yZWdpc3Rlcigmc3BpLT5kZXYsIGluZGlvX2Rldik7
DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiBAQCAtNjgzLDE1ICs2ODMs
NiBAQCBzdGF0aWMgaW50IGFkMnMxMjEwX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+
ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgYWQyczEyMTBfcmVtb3ZlKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+IC17DQo+IC0Jc3RydWN0IGlpb19kZXYgKmluZGlvX2Rl
diA9IHNwaV9nZXRfZHJ2ZGF0YShzcGkpOw0KPiAtDQo+IC0JaWlvX2RldmljZV91bnJlZ2lzdGVy
KGluZGlvX2Rldik7DQo+IC0NCj4gLQlyZXR1cm4gMDsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYWQyczEyMTBfb2ZfbWF0Y2hbXSA9IHsNCj4gIAl7IC5j
b21wYXRpYmxlID0gImFkaSxhZDJzMTIxMCIsIH0sDQo+ICAJeyB9DQo+IEBAIC03MTAsNyArNzAx
LDYgQEAgc3RhdGljIHN0cnVjdCBzcGlfZHJpdmVyIGFkMnMxMjEwX2RyaXZlciA9IHsNCj4gIAkJ
Lm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKGFkMnMxMjEwX29mX21hdGNoKSwNCj4gIAl9
LA0KPiAgCS5wcm9iZSA9IGFkMnMxMjEwX3Byb2JlLA0KPiAtCS5yZW1vdmUgPSBhZDJzMTIxMF9y
ZW1vdmUsDQo+ICAJLmlkX3RhYmxlID0gYWQyczEyMTBfaWQsDQo+ICB9Ow0KPiAgbW9kdWxlX3Nw
aV9kcml2ZXIoYWQyczEyMTBfZHJpdmVyKTsNCg==
