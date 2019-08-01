Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 246CF7D780
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfHAIZe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 04:25:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:18792 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbfHAIZd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 04:25:33 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x718NStT010162;
        Thu, 1 Aug 2019 04:25:28 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u3hrnhf5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbXNUz6seRHgonRpYTgKljUe5PJTFufxtaBHylUvSzlV6allNvz0JDrojGgaqQJtjc76xYnd/AqXLuKVJCaeC+Wk1J+7bJmAikPOPUL9vtEMGJDzPuPycJb2ELFn2r1RmvcoJOBuudXN3q2sw5tMPzTixdTY+CBiw51iHS4OC+OXr/LFWok0OjP+/Q5VYsBvh5SWNWzw8pQ2zPOan3zKTZCWYllz8S9GzZhy8meRRxFNSz9DwQfslzS7BeS5dwbKKgStdEy9WVCtD/itQ/PQzLCAX6HsYYPicxTN7VDFqp3KPxXnY8QW7piu8KXOyMy8eV0esCPjtkHr9XHnK7AvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h+1GAbwNFeGUh0UBbeZzGRQCF4nczw55RrqWtMKUec=;
 b=gOQ9AYC+U22LMvlvdK6ug2/+MVLJx7QUSArmYKYWYVIzkCfPVTht9A28Ody8iP//F1x6bZQbe/YrUQPnDHAxnGwCB+09lmE955PYWrY/CJ7OESNRRln5zMgehsZ1k/m3EA5c3B9cF2p4LLVeIqJIBymbYompECOn5/vjGJkwH8Y0JCramLGGQDMkWRdvIROeL3eohgL/b/e6bc2y7V/7uqVcUqvalhHEsRgGi6LAWTzrDhuzR+rgIvey49qeTeZwtu+keerIZ7ULndyRbmrgYgcgaEPJjbLeQvQFISOikID1+f4riC/wEGeKfRrxrGmYN9hSVn3yNfCprLrC0nvJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h+1GAbwNFeGUh0UBbeZzGRQCF4nczw55RrqWtMKUec=;
 b=sZrmSO0/wLHFiQo8yiKhNiAmK4RzzaXRzjoq/W0KtC16248gaySuuZmRsi6OhUeEEPgvQfDSoc+9t25my4qNO6QTyL6ysaGe6MZHo/papp6c/8ii7ZURwwURXMNpp3ed8pbqVWzAYDGLhI4/FWrGatT+dKdvt3HFU0B9f8aGY5E=
Received: from MWHPR03CA0034.namprd03.prod.outlook.com (2603:10b6:301:3b::23)
 by DM5PR03MB3196.namprd03.prod.outlook.com (2603:10b6:4:40::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.16; Thu, 1 Aug
 2019 08:25:24 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by MWHPR03CA0034.outlook.office365.com
 (2603:10b6:301:3b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.16 via Frontend
 Transport; Thu, 1 Aug 2019 08:25:24 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Thu, 1 Aug 2019 08:25:24 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x718PNoQ019081
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Aug 2019 01:25:23 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 1 Aug 2019 04:25:23 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/5] iio:magn: do not allocate/de-allocate buffer here
 but link setup_ops to st_sensors_buffer
Thread-Topic: [PATCH 4/5] iio:magn: do not allocate/de-allocate buffer here
 but link setup_ops to st_sensors_buffer
Thread-Index: AQHVR+pZ4HKQJ0uQ7U+9wMUElKt3rabmatYA
Date:   Thu, 1 Aug 2019 08:25:22 +0000
Message-ID: <6a45b747735b262deb52a3c70f1c4c0691fcfcb7.camel@analog.com>
References: <20190731215250.16403-1-denis.ciocca@st.com>
         <20190731215250.16403-5-denis.ciocca@st.com>
In-Reply-To: <20190731215250.16403-5-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.109]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2387B63D7A9A844AAC8A38D248E847E6@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(199004)(189003)(6246003)(118296001)(6116002)(356004)(3846002)(14454004)(7696005)(2486003)(23676004)(5660300002)(478600001)(8676002)(2501003)(2201001)(47776003)(8936002)(106002)(110136005)(316002)(305945005)(246002)(7636002)(50466002)(7736002)(36756003)(486006)(70206006)(70586007)(229853002)(2906002)(76176011)(26005)(86362001)(186003)(436003)(126002)(476003)(2616005)(446003)(102836004)(11346002)(426003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3196;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b73aaf86-7617-42c6-2676-08d71659cd05
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR03MB3196;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3196:
X-Microsoft-Antispam-PRVS: <DM5PR03MB31965671855FF5B24F194FC4F9DE0@DM5PR03MB3196.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3WJuuvV8ChIaB8m669mrOaqnVGVvIt8jPXos5pTZKNcjJvGwS7i6A4DTqootLjI8wf/QD4QihAOVed8r/PDDlq+BNMQ8t0f1oNaYCjXS9IPa62YvpVmxC+ezns2S3zaQUoo7DMA+l1ob/PeZpw87pV19wXvPkYVd0+bp+tWyovmK1la71MrlCUyPZxbFKVSGaIvWf7uBMuhmkIHN8hmZPMLfq/MsiIJbm7amRQxW8wuyMgv38nnXGF8NFYmY2sp/mCj4hupiTIBXQopUmGFcBFHLHmmzvrwi7LbocmVKof2ZXf82Kg6tkxtOgi8T4+CJZDmY5ZfGBZonP/9RjUXwdiyxqaZNbD4LtQGMfeeqasxh56kr1MxKt2nXubZ6ulKximA8zU92U3PNXI1hS1pblfLm4Y8isVLnD2glLZ4Fprc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 08:25:24.1246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73aaf86-7617-42c6-2676-08d71659cd05
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3196
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
IFtFeHRlcm5hbF0NCj4gDQo+IFNldHVwIGJ1ZmZlcl9zZXR1cF9vcHMgcHJlL3Bvc3QgZW5hYmxl
L2Rpc2FibGUgdG8gdXNlDQo+IHN0X3NlbnNvcl9idWZmZXJzIGZ1bmN0aW9ucyBmb3IgbWVtb3J5
IGFsbG9jYXRpb24vZGUtYWxsb2NhdGlvbi4NCj4gDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUg
QXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KDQo+IFNpZ25lZC1vZmYt
Ynk6IERlbmlzIENpb2NjYSA8ZGVuaXMuY2lvY2NhQHN0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2lpby9tYWduZXRvbWV0ZXIvc3RfbWFnbl9idWZmZXIuYyB8IDE0ICsrKy0tLS0tLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvc3RfbWFnbl9idWZmZXIuYyBi
L2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9zdF9tYWduX2J1ZmZlci5jDQo+IGluZGV4IDY1OGQ2
MjdkYWQ4ZS4uNTkyOTcyZjY0NTBlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9tYWduZXRv
bWV0ZXIvc3RfbWFnbl9idWZmZXIuYw0KPiArKysgYi9kcml2ZXJzL2lpby9tYWduZXRvbWV0ZXIv
c3RfbWFnbl9idWZmZXIuYw0KPiBAQCAtMzEsMTcgKzMxLDExIEBAIGludCBzdF9tYWduX3RyaWdf
c2V0X3N0YXRlKHN0cnVjdCBpaW9fdHJpZ2dlciAqdHJpZywgYm9vbCBzdGF0ZSkNCj4gIA0KPiAg
c3RhdGljIGludCBzdF9tYWduX2J1ZmZlcl9wb3N0ZW5hYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRp
b19kZXYpDQo+ICB7DQo+IC0Jc3RydWN0IHN0X3NlbnNvcl9kYXRhICptZGF0YSA9IGlpb19wcml2
KGluZGlvX2Rldik7DQo+ICAJaW50IGVycjsNCj4gIA0KPiAtCW1kYXRhLT5idWZmZXJfZGF0YSA9
IGttYWxsb2MoaW5kaW9fZGV2LT5zY2FuX2J5dGVzLA0KPiAtCQkJCSAgICAgR0ZQX0RNQSB8IEdG
UF9LRVJORUwpOw0KPiAtCWlmICghbWRhdGEtPmJ1ZmZlcl9kYXRhKQ0KPiAtCQlyZXR1cm4gLUVO
T01FTTsNCj4gLQ0KPiAgCWVyciA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUoaW5k
aW9fZGV2KTsNCj4gIAlpZiAoZXJyIDwgMCkNCj4gLQkJZ290byBzdF9tYWduX2ZyZWVfYnVmZmVy
Ow0KPiArCQlyZXR1cm4gZXJyOw0KPiAgDQo+ICAJZXJyID0gc3Rfc2Vuc29yc19zZXRfZW5hYmxl
KGluZGlvX2RldiwgdHJ1ZSk7DQo+ICAJaWYgKGVyciA8IDApDQo+IEBAIC01MSwxNCArNDUsMTEg
QEAgc3RhdGljIGludCBzdF9tYWduX2J1ZmZlcl9wb3N0ZW5hYmxlKHN0cnVjdCBpaW9fZGV2ICpp
bmRpb19kZXYpDQo+ICANCj4gIHN0X21hZ25fYnVmZmVyX3ByZWRpc2FibGU6DQo+ICAJaWlvX3Ry
aWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiAtc3RfbWFnbl9mcmVlX2J1
ZmZlcjoNCj4gLQlrZnJlZShtZGF0YS0+YnVmZmVyX2RhdGEpOw0KPiAgCXJldHVybiBlcnI7DQo+
ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgc3RfbWFnbl9idWZmZXJfcHJlZGlzYWJsZShzdHJ1Y3Qg
aWlvX2RldiAqaW5kaW9fZGV2KQ0KPiAgew0KPiAtCXN0cnVjdCBzdF9zZW5zb3JfZGF0YSAqbWRh
dGEgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiAgCWludCBlcnIsIGVycjI7DQo+ICANCj4gIAll
cnIgPSBzdF9zZW5zb3JzX3NldF9lbmFibGUoaW5kaW9fZGV2LCBmYWxzZSk7DQo+IEBAIC02Nywx
MyArNTgsMTQgQEAgc3RhdGljIGludCBzdF9tYWduX2J1ZmZlcl9wcmVkaXNhYmxlKHN0cnVjdCBp
aW9fZGV2ICppbmRpb19kZXYpDQo+ICAJaWYgKCFlcnIpDQo+ICAJCWVyciA9IGVycjI7DQo+ICAN
Cj4gLQlrZnJlZShtZGF0YS0+YnVmZmVyX2RhdGEpOw0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+
ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2J1ZmZlcl9zZXR1cF9vcHMgc3RfbWFnbl9i
dWZmZXJfc2V0dXBfb3BzID0gew0KPiArCS5wcmVlbmFibGUgPSAmc3Rfc2Vuc29yc19idWZmZXJf
cHJlZW5hYmxlLA0KPiAgCS5wb3N0ZW5hYmxlID0gJnN0X21hZ25fYnVmZmVyX3Bvc3RlbmFibGUs
DQo+ICAJLnByZWRpc2FibGUgPSAmc3RfbWFnbl9idWZmZXJfcHJlZGlzYWJsZSwNCj4gKwkucG9z
dGRpc2FibGUgPSAmc3Rfc2Vuc29yc19idWZmZXJfcG9zdGRpc2FibGUsDQo+ICB9Ow0KPiAgDQo+
ICBpbnQgc3RfbWFnbl9hbGxvY2F0ZV9yaW5nKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo=
