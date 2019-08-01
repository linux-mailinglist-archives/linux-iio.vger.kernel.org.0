Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5134A7D778
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 10:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfHAIYW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 04:24:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39246 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfHAIYV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 04:24:21 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x718NStK010162;
        Thu, 1 Aug 2019 04:24:15 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2056.outbound.protection.outlook.com [104.47.40.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u3hrnhf3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:24:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuoAXKRLK6dCPrkDbtBp51ej20Cj0MUhxWMcpbeVgaMcz3ZBnzbTPpLldfo7t8MzAe087zX3Kw4hAmM6EVl/dKoduezzZKQtYhhy+ty2XuX4FknF790/sRtyKH+pFCi/+IM1x70krdvI11JfuuIjZDMfHeFkj+1OvRSq253wqbp4swLr9WtUmRI6N9PysMrOOBFCrGHzK5fSk94O3U1sVOGNqooDgramo3JZMd3rKKlltyzRmkNq8FLgdsdmzbrrnP/p+9jw3COyCYUUNlwvujN4f+44B9csfWvYPyvqCfjmz/IWdPLHjCCrouXSz7FM3RLxYleeL03L5U/gti8iHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC5uRERoGr7ZjJgBf4KDkVRM80AP/lJ9sQANGwl0Mgg=;
 b=DufeipCtDRHOjWp8Bz2kor6IKkJSLzjYIxJ8mpDzInvtTa/8gmfbH2VO/nthIFqRSDzyyfYTBG+qAu6YiGR0cz8f6YPy7GxlRXf0oUomHXKTIhWytmgWpzIRmLOFstzJpTmHDvaHDuFGrH2MVveSUWQ7UXFQRNCPhr8Tt32oJijI7W4RAfX1kHaNHh6AAQ+4VQoEphI4m/t5HZxJtGJcLZAvY64HZRqK0bOtqzgZQi0B7ilmcAMcNed5yc2AyYvlcAyTVunDhhrgjQkMJVoBX8wqEyYgwTYgUPXrpZjHvHg/P1NajNfCDJoV5TMDBZQj0uvb30gswTkGyc8z8q0OrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC5uRERoGr7ZjJgBf4KDkVRM80AP/lJ9sQANGwl0Mgg=;
 b=9zg54TELi9ZQ5LaL4Qzr9G8U94NKB5A5g/u3nJvlvFMzWgOowUr2aeRgd9JKEi996JBrkwc045OnE9NdCQ8Ws4CizOYKpAcSUu7g1mzPrxT2c9kLXiKmAezxg9bdfCgVA+jsa0+Rty0Smuq6Fs3F4/DqeIMCf+gDYeeVWPK22c8=
Received: from BN6PR03CA0069.namprd03.prod.outlook.com (2603:10b6:404:4c::31)
 by DM6PR03MB3418.namprd03.prod.outlook.com (2603:10b6:5:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Thu, 1 Aug
 2019 08:24:14 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BN6PR03CA0069.outlook.office365.com
 (2603:10b6:404:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.12 via Frontend
 Transport; Thu, 1 Aug 2019 08:24:13 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Thu, 1 Aug 2019 08:24:13 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x718OCKd018829
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Aug 2019 01:24:12 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 1 Aug 2019 04:24:12 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio:common: introduce
 st_sensors_buffer_preenable/predisable functions
Thread-Topic: [PATCH 1/5] iio:common: introduce
 st_sensors_buffer_preenable/predisable functions
Thread-Index: AQHVR+pUTCv4Wm0S7ESiCpFB3kL0A6bmaoAA
Date:   Thu, 1 Aug 2019 08:24:10 +0000
Message-ID: <6939dc8b7c28b1f4ed00f33b5ed2cfde17b73d41.camel@analog.com>
References: <20190731215250.16403-1-denis.ciocca@st.com>
         <20190731215250.16403-2-denis.ciocca@st.com>
In-Reply-To: <20190731215250.16403-2-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.109]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B34E0B722D3107468C1F9E580247A1C3@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(189003)(199004)(70206006)(8676002)(426003)(11346002)(436003)(486006)(2486003)(47776003)(476003)(2616005)(14444005)(36756003)(126002)(316002)(76176011)(5660300002)(86362001)(102836004)(23676004)(106002)(118296001)(8936002)(14454004)(3846002)(6116002)(7696005)(50466002)(229853002)(446003)(70586007)(2501003)(6246003)(110136005)(2201001)(7736002)(186003)(7636002)(26005)(356004)(2906002)(478600001)(336012)(246002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3418;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91a8eb06-1645-4fbd-a3c8-08d71659a2a9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DM6PR03MB3418;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3418:
X-Microsoft-Antispam-PRVS: <DM6PR03MB341820162286D20B5995BF08F9DE0@DM6PR03MB3418.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: h4GyjlZJWosu6IbIabVDk80FP/bT43FlhTy2edHKRfhEefifVEhVWxMdyJ/9/pw3OE1n0ForvOM7R5Ey+KSLOEPxaQdhj13I4mE5a92ldCJLjJ6lejXjuHDrwgVY25//E1oVCSFfoGfOsdlDqT4oo8Kcxv4ukRzYf/GMzjDioqI+FrmAonZmfBmAVbW9u8qTaYlGIfHPLkig0cual4aN6fD2ctWDTfBAtAbI05Srl84IY5s4yptppkl0PMZ8E+IZDRqp84xtLbfBVy9CYGeG5g7x2QfSsby783hSnpQs+WcGljYFJ9/bM7nXtWga8LJ53NLxjLJ/P7a2QKvtiQe0AkEdWhk9XN2wPWOK0XWppseFPbfm0ERfczyZme0K3cPGtNbf7BBepv4MLqd1g02Skb1glL6VnoVpbrxNOjX285w=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 08:24:13.0869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a8eb06-1645-4fbd-a3c8-08d71659a2a9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3418
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010086
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTMxIGF0IDE0OjUyIC0wNzAwLCBEZW5pcyBDaW9jY2Egd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgaW50cm9kdWNpbmcgcHJlZW5hYmxlL3Bv
c3RkaXNhYmxlIGluIHRoZSBjb21tb24NCj4gc3Rfc2Vuc29yc19idWZmZXIgY29kZSBpbiBvcmRl
ciB0byByZW1vdmUgdGhlIG1lbW9yeSBhbGxvY2F0aW9uIC8NCj4gZGUtYWxsb2NhdGlvbiBmcm9t
IGVhY2ggc2luZ2xlIHN0IGRyaXZlci4NCj4gDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJk
ZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6
IERlbmlzIENpb2NjYSA8ZGVuaXMuY2lvY2NhQHN0LmNvbT4NCj4gLS0tDQo+ICAuLi4vaWlvL2Nv
bW1vbi9zdF9zZW5zb3JzL3N0X3NlbnNvcnNfYnVmZmVyLmMgfCAyMiArKysrKysrKysrKysrKysr
KysrDQo+ICBpbmNsdWRlL2xpbnV4L2lpby9jb21tb24vc3Rfc2Vuc29ycy5oICAgICAgICAgfCAg
MiArKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vY29tbW9uL3N0X3NlbnNvcnMvc3Rfc2Vuc29yc19idWZmZXIuYyBi
L2RyaXZlcnMvaWlvL2NvbW1vbi9zdF9zZW5zb3JzL3N0X3NlbnNvcnNfYnVmZmVyLmMNCj4gaW5k
ZXggZWVlMzAxMzBhZTIzLi45ZGExYzgxMDQ4ODMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlv
L2NvbW1vbi9zdF9zZW5zb3JzL3N0X3NlbnNvcnNfYnVmZmVyLmMNCj4gKysrIGIvZHJpdmVycy9p
aW8vY29tbW9uL3N0X3NlbnNvcnMvc3Rfc2Vuc29yc19idWZmZXIuYw0KPiBAQCAtODEsNiArODEs
MjggQEAgaXJxcmV0dXJuX3Qgc3Rfc2Vuc29yc190cmlnZ2VyX2hhbmRsZXIoaW50IGlycSwgdm9p
ZCAqcCkNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0woc3Rfc2Vuc29yc190cmlnZ2VyX2hhbmRsZXIp
Ow0KPiAgDQo+ICtpbnQgc3Rfc2Vuc29yc19idWZmZXJfcHJlZW5hYmxlKHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYpDQo+ICt7DQo+ICsJc3RydWN0IHN0X3NlbnNvcl9kYXRhICpzZGF0YSA9IGlp
b19wcml2KGluZGlvX2Rldik7DQo+ICsNCj4gKwlzZGF0YS0+YnVmZmVyX2RhdGEgPSBrbWFsbG9j
KGluZGlvX2Rldi0+c2Nhbl9ieXRlcywNCj4gKwkJCQkgICAgIEdGUF9ETUEgfCBHRlBfS0VSTkVM
KTsNCj4gKwlpZiAoIXNkYXRhLT5idWZmZXJfZGF0YSkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0woc3Rfc2Vuc29yc19idWZm
ZXJfcHJlZW5hYmxlKTsNCj4gKw0KPiAraW50IHN0X3NlbnNvcnNfYnVmZmVyX3Bvc3RkaXNhYmxl
KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICt7DQo+ICsJc3RydWN0IHN0X3NlbnNvcl9k
YXRhICpzZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICsNCj4gKwlrZnJlZShzZGF0YS0+
YnVmZmVyX2RhdGEpOw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChzdF9z
ZW5zb3JzX2J1ZmZlcl9wb3N0ZGlzYWJsZSk7DQo+ICsNCj4gIE1PRFVMRV9BVVRIT1IoIkRlbmlz
IENpb2NjYSA8ZGVuaXMuY2lvY2NhQHN0LmNvbT4iKTsNCj4gIE1PRFVMRV9ERVNDUklQVElPTigi
U1RNaWNyb2VsZWN0cm9uaWNzIFNULXNlbnNvcnMgYnVmZmVyIik7DQo+ICBNT0RVTEVfTElDRU5T
RSgiR1BMIHYyIik7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lpby9jb21tb24vc3Rf
c2Vuc29ycy5oIGIvaW5jbHVkZS9saW51eC9paW8vY29tbW9uL3N0X3NlbnNvcnMuaA0KPiBpbmRl
eCAyOGZjMWY5ZmE3ZDUuLmM2NmViYjIzNmExNSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51
eC9paW8vY29tbW9uL3N0X3NlbnNvcnMuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2lpby9jb21t
b24vc3Rfc2Vuc29ycy5oDQo+IEBAIC0yNTQsNiArMjU0LDggQEAgc3RydWN0IHN0X3NlbnNvcl9k
YXRhIHsNCj4gIA0KPiAgI2lmZGVmIENPTkZJR19JSU9fQlVGRkVSDQo+ICBpcnFyZXR1cm5fdCBz
dF9zZW5zb3JzX3RyaWdnZXJfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpwKTsNCj4gK2ludCBzdF9z
ZW5zb3JzX2J1ZmZlcl9wcmVlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2Rldik7DQo+ICtp
bnQgc3Rfc2Vuc29yc19idWZmZXJfcG9zdGRpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2Rl
dik7DQo+ICAjZW5kaWYNCj4gIA0KPiAgI2lmZGVmIENPTkZJR19JSU9fVFJJR0dFUg0K
