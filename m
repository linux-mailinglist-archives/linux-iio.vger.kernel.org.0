Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D667A39B
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfG3JCa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jul 2019 05:02:30 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:61286 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbfG3JCa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2019 05:02:30 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U92IJo004748;
        Tue, 30 Jul 2019 05:02:24 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2053.outbound.protection.outlook.com [104.47.48.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u2hg2r86j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 05:02:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCjuyEfdPleWxen5M+Hd+SfRwVUIsYWFyeOE9sDBwQeZRmd1Mm04je5tsjWNWSNFqpb/RtkX2SLrY02iyXzUZawMo7OodfrwF5lGodfEhsD0WHqEcx5ieks8QSSrestf7gcB7tEijwZY5mcMBp4BbFNqutuHlaLTX9GjpxU/0Fg5b4+j+Ec4r6G8S2Iaagave7QqG/Im8ebgybaW8/Wsk1jb3Dl8GMpbvhKaZU2WaGp9HIvkV0elaJb8K1SrZ/cHGGnTyLK/vN8ZpwZTPDZ3RHUgYCJIZHtXFFvnQv4JHLQkfHhBqzy6rn6tKLIPXxH4qH1lrErYwLfrypXr/E6YwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzGor+R9KLWvI2O1L15PJg/H1GqhxPozVIkMqbcyHu0=;
 b=kCsNW4lm5YzawJk38GyMNY5dIbWpbDEDvlUyl0SmxNKCIsOzTNxLAMFdaIURyZPVv9ZR4iDkGDGtDWUPJRUr3YZOT/tboV4XNbQdPPieCfNL/xK4Snmn9cK0upkZrt9I6VL4yTI1M512Bf5DVcOYqwIEKHkc1ADOvxnNRtS4N9Rsbgy0hPMaKpPlz2TBSq9YhQO81Hy4FFSr3kcfmnPdZVh81sFmrHWEcmhOsnSgbkJFRos894UrDDrZaDgyi3pehxBjlj1mvU9bOHaH+GM07O1iqm5AwrkXGinHMy6+UjaJ5k8eFBiQRCtSBuHoqPOPjrmjAIXIoFXHBaCHHcdm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzGor+R9KLWvI2O1L15PJg/H1GqhxPozVIkMqbcyHu0=;
 b=g4PZHYMxJ6kld4PumKNdSfeG8qhKxwN6zwmPQIWBBXkVVA+oiaYKgzR5u7NW3POuyPAdLyndFZ5MHFccbTOjy0J5cXLeAQdiHY4nF2aAp54D7DSv8CeZYi+NyPf3hsOtkSxyVqlmjX1BZGVt169rScE6IQR1cUNmeIIUU1aoFho=
Received: from CY4PR03CA0077.namprd03.prod.outlook.com (2603:10b6:910:4d::18)
 by BLUPR0301MB2081.namprd03.prod.outlook.com (2a01:111:e400:c474::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17; Tue, 30 Jul
 2019 09:02:22 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CY4PR03CA0077.outlook.office365.com
 (2603:10b6:910:4d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10 via Frontend
 Transport; Tue, 30 Jul 2019 09:02:22 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Tue, 30 Jul 2019 09:02:21 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6U92Iji015440
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 30 Jul 2019 02:02:18 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Tue, 30 Jul 2019 05:02:21 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio:pressure: preenable/postenable/predisable fixup
 for ST press buffer
Thread-Topic: [PATCH 4/4] iio:pressure: preenable/postenable/predisable
 fixup for ST press buffer
Thread-Index: AQHVRmtMbiZafreu3ECyaDkYRYEN1KbjU32A
Date:   Tue, 30 Jul 2019 09:02:20 +0000
Message-ID: <c73657b4203d8112636751413c85f525f57dcc2a.camel@analog.com>
References: <20190730000305.30958-1-denis.ciocca@st.com>
         <20190730000305.30958-5-denis.ciocca@st.com>
In-Reply-To: <20190730000305.30958-5-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.107]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ECFA5FE2E655A45BFE8500A93E66F75@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(189003)(199004)(118296001)(14454004)(50466002)(305945005)(6116002)(6246003)(3846002)(8936002)(8676002)(246002)(102836004)(356004)(7636002)(7736002)(47776003)(316002)(110136005)(36756003)(70586007)(486006)(76176011)(106002)(2616005)(26005)(70206006)(86362001)(186003)(2486003)(23676004)(2501003)(229853002)(336012)(2201001)(446003)(476003)(11346002)(7696005)(126002)(478600001)(2906002)(5660300002)(426003)(436003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB2081;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f204a960-37f7-438b-7087-08d714cca20a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BLUPR0301MB2081;
X-MS-TrafficTypeDiagnostic: BLUPR0301MB2081:
X-Microsoft-Antispam-PRVS: <BLUPR0301MB20811357D1491EE7A603E1ECF9DC0@BLUPR0301MB2081.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0114FF88F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Kc3KjA9mUSm7EL6/iom7SVA8hS7jFqGENebSPu2gmPMrI0DuvW2jpg2hj8sQ5WxpXCFLBQ5nWeUhmDduOtdOw9IJ0JLLt2UxCKsTaXIqLOn20PQlLzCTcnbgPrGcMeS9VNeQaY5rIPaKH6SI0j53PNBnp6aRgaOYZ8h5MALUcKshUu2SuywxHLuFsfW77aEK1/V9n/0Y6K9tPmt0QboUPdUR1aF7hNwVXPsNye6yJ+CX8FiDobNOEAool+vqEhrBzv3h0D+JxFtoHLw8A1UEJVbAODLR6An93RyWhzWz7L2Y6WFClXtp8RfHvAajRAwlXxD+Zgnezn8DknniMOWxtkhzAPNiCgpqKNqWevaRa9gP+EmOsses1ZDstPGpFnc3eXo5RvNZ1UxK6SJRrxU+/GgoCrpb81tVe0tMbXPJbdY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2019 09:02:21.7809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f204a960-37f7-438b-7087-08d714cca20a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB2081
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA3LTI5IGF0IDE3OjAzIC0wNzAwLCBEZW5pcyBDaW9jY2Egd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgdHJ5aW5nIHRvIGNsZWFudXAgZm9yIGdv
b2QgdGhlIGJ1ZmZlcnMgb3BlcmF0aW9uIGZ1bmN0aW9ucy4NCj4gVGhlcmUgaXMgbm8gbmVlZCBv
ZiB1c2luZyBwcmVlbmFibGUsIGFsbCBjYW4gYmUgZG9uZSBpbnRvDQo+IHBvc3RlbmFibGUuIExl
dCdzIGFsc28gdXNlIGxvZ2ljYWwgc2VxdWVuY2Ugb2Ygb3BlcmF0aW9ucyBhcw0KPiBhbHJlYWR5
IGRvbmUgaW4gYWNjZWwgZHJpdmVyLg0KPiBGaW5hbGx5IGFsc28gcmVuYW1lIHRoZSBnb3RvIGxh
YmVsIHVzaW5nIG9wZXJhdGlvbiB0byBwZXJmb3JtIGFuZCBub3QNCj4gd2hlcmUgaXQgZmFpbHMu
DQo+IA0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxl
YW5AYW5hbG9nLmNvbT4NCg0KDQpVbnJlbGF0ZWQgdG8gdGhpcyBwYXRjaCwgSSB3YXMgdGhpbmtp
bmcgdGhhdCBpdCB3b3VsZCBiZSBhIG5lYXQgaWRlYSB0byBtb3ZlIHRoZSBgYnVmZmVyX2RhdGFg
IGFsbG9jYXRpb24gaW4NCmBkcml2ZXJzL2lpby9jb21tb24vc3Rfc2Vuc29ycy9zdF9zZW5zb3Jz
X2J1ZmZlci5jYA0KDQpUaGlzIHdvdWxkIHJlbW92ZSBzb21lIGR1cGxpY2F0aW9uIG9mIHRoaXMg
YWxsb2MgKyBmcmVlIGluIGRyaXZlcnMuDQoNCk1heWJlIGluIHN0X3NlbnNvcnNfdHJpZ2dlcl9o
YW5kbGVyKCkgc29tZXRoaW5nIGxpa2U6DQoNCmlmICghc2RhdGEtPmJ1ZmZlcl9kYXRhKSB7DQog
ICAgc2RhdGEtPmJ1ZmZlcl9kYXRhID0gZGV2bV9rbWFsbG9jKCkNCiAgICBpZiAoIXNkYXRhLT5i
dWZmZXJfZGF0YSkgew0KICAgICAgICBkZXZfZXJyKGluZGlvX2Rldi0+ZGV2LCAiRmFpbGVkIHRv
IGFsbG9jYXRlIGJ1ZmZlciBkYXRhXG4iKTsNCiAgICAgICAgZ290byBzdF9zZW5zb3JzX2dldF9i
dWZmZXJfZWxlbWVudF9lcnJvcjsNCiAgICB9DQp9DQoNClVzaW5nIGRldm1fa21hbGxvYygpIG9y
IGEgc2ltaWxhciBkZXZtXyB2YXJpYW50IHdvdWxkIGJlIG5lYXQsIHNpbmNlIGl0IGdldHMgZnJl
ZSdkIHdoZW4gdGhlIGRldmljZSBnZXRzIHJlbW92ZWQuDQoNClRoYW5rcw0KQWxleA0KDQo+IFNp
Z25lZC1vZmYtYnk6IERlbmlzIENpb2NjYSA8ZGVuaXMuY2lvY2NhQHN0LmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2lpby9wcmVzc3VyZS9zdF9wcmVzc3VyZV9idWZmZXIuYyB8IDMyICsrKysrKysr
LS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMjEg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vcHJlc3N1cmUvc3Rf
cHJlc3N1cmVfYnVmZmVyLmMgYi9kcml2ZXJzL2lpby9wcmVzc3VyZS9zdF9wcmVzc3VyZV9idWZm
ZXIuYw0KPiBpbmRleCBmMjFiNjMwYWJhYTAuLjU0ODIzY2ZjZmFiNSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9paW8vcHJlc3N1cmUvc3RfcHJlc3N1cmVfYnVmZmVyLmMNCj4gKysrIGIvZHJpdmVy
cy9paW8vcHJlc3N1cmUvc3RfcHJlc3N1cmVfYnVmZmVyLmMNCj4gQEAgLTI5LDUzICsyOSw0MyBA
QCBpbnQgc3RfcHJlc3NfdHJpZ19zZXRfc3RhdGUoc3RydWN0IGlpb190cmlnZ2VyICp0cmlnLCBi
b29sIHN0YXRlKQ0KPiAgCXJldHVybiBzdF9zZW5zb3JzX3NldF9kYXRhcmVhZHlfaXJxKGluZGlv
X2Rldiwgc3RhdGUpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IHN0X3ByZXNzX2J1ZmZlcl9w
cmVlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gLXsNCj4gLQlyZXR1cm4gc3Rf
c2Vuc29yc19zZXRfZW5hYmxlKGluZGlvX2RldiwgdHJ1ZSk7DQo+IC19DQo+IC0NCj4gIHN0YXRp
YyBpbnQgc3RfcHJlc3NfYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2Rl
dikNCj4gIHsNCj4gLQlpbnQgZXJyOw0KPiAgCXN0cnVjdCBzdF9zZW5zb3JfZGF0YSAqcHJlc3Nf
ZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICsJaW50IGVycjsNCj4gIA0KPiAgCXByZXNz
X2RhdGEtPmJ1ZmZlcl9kYXRhID0ga21hbGxvYyhpbmRpb19kZXYtPnNjYW5fYnl0ZXMsDQo+ICAJ
CQkJCSAgR0ZQX0RNQSB8IEdGUF9LRVJORUwpOw0KPiAtCWlmIChwcmVzc19kYXRhLT5idWZmZXJf
ZGF0YSA9PSBOVUxMKSB7DQo+IC0JCWVyciA9IC1FTk9NRU07DQo+IC0JCWdvdG8gYWxsb2NhdGVf
bWVtb3J5X2Vycm9yOw0KPiAtCX0NCj4gKwlpZiAoIXByZXNzX2RhdGEtPmJ1ZmZlcl9kYXRhKQ0K
PiArCQlyZXR1cm4gLUVOT01FTTsNCj4gIA0KPiAgCWVyciA9IGlpb190cmlnZ2VyZWRfYnVmZmVy
X3Bvc3RlbmFibGUoaW5kaW9fZGV2KTsNCj4gIAlpZiAoZXJyIDwgMCkNCj4gLQkJZ290byBzdF9w
cmVzc19idWZmZXJfcG9zdGVuYWJsZV9lcnJvcjsNCj4gKwkJZ290byBzdF9wcmVzc19mcmVlX2J1
ZmZlcjsNCj4gIA0KPiAtCXJldHVybiBlcnI7DQo+ICsJcmV0dXJuIHN0X3NlbnNvcnNfc2V0X2Vu
YWJsZShpbmRpb19kZXYsIHRydWUpOw0KPiAgDQo+IC1zdF9wcmVzc19idWZmZXJfcG9zdGVuYWJs
ZV9lcnJvcjoNCj4gK3N0X3ByZXNzX2ZyZWVfYnVmZmVyOg0KPiAgCWtmcmVlKHByZXNzX2RhdGEt
PmJ1ZmZlcl9kYXRhKTsNCj4gLWFsbG9jYXRlX21lbW9yeV9lcnJvcjoNCj4gIAlyZXR1cm4gZXJy
Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IHN0X3ByZXNzX2J1ZmZlcl9wcmVkaXNhYmxlKHN0
cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICB7DQo+IC0JaW50IGVycjsNCj4gIAlzdHJ1Y3Qg
c3Rfc2Vuc29yX2RhdGEgKnByZXNzX2RhdGEgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiAtDQo+
IC0JZXJyID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiAt
CWlmIChlcnIgPCAwKQ0KPiAtCQlnb3RvIHN0X3ByZXNzX2J1ZmZlcl9wcmVkaXNhYmxlX2Vycm9y
Ow0KPiArCWludCBlcnIsIGVycjI7DQo+ICANCj4gIAllcnIgPSBzdF9zZW5zb3JzX3NldF9lbmFi
bGUoaW5kaW9fZGV2LCBmYWxzZSk7DQo+ICANCj4gLXN0X3ByZXNzX2J1ZmZlcl9wcmVkaXNhYmxl
X2Vycm9yOg0KPiArCWVycjIgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlv
X2Rldik7DQo+ICsJaWYgKCFlcnIpDQo+ICsJCWVyciA9IGVycjI7DQo+ICsNCj4gIAlrZnJlZShw
cmVzc19kYXRhLT5idWZmZXJfZGF0YSk7DQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gIA0KPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fYnVmZmVyX3NldHVwX29wcyBzdF9wcmVzc19idWZmZXJf
c2V0dXBfb3BzID0gew0KPiAtCS5wcmVlbmFibGUgPSAmc3RfcHJlc3NfYnVmZmVyX3ByZWVuYWJs
ZSwNCj4gIAkucG9zdGVuYWJsZSA9ICZzdF9wcmVzc19idWZmZXJfcG9zdGVuYWJsZSwNCj4gIAku
cHJlZGlzYWJsZSA9ICZzdF9wcmVzc19idWZmZXJfcHJlZGlzYWJsZSwNCj4gIH07DQo=
