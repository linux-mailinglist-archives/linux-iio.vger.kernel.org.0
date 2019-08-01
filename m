Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0DF7D779
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfHAIYd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 04:24:33 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:39562 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfHAIYd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 04:24:33 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x718NAiv032498;
        Thu, 1 Aug 2019 04:24:29 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2050.outbound.protection.outlook.com [104.47.33.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u3dkcbpfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:24:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJgy7teWM9x+xkz8UXCvGYXnlv12gnenzNmxwAVMd1TcRnT3sFVzxFLkDocfXM8+f5ooeQ+/lMbBa5ZecafV3/TXVgdTLotSs6KSy93viNgIAMhyav4Oj6UxcQyW1ctWPMgvSNoNllOOUCPgNJo+28KZ0NqHqcMM9uXLTATCet80szJNrEetMLTiEZ2b/o4qUHKSLEvhf6zrB1gYPZeAbey4gH3tDOL37h0KbXsCk/pWgNusLYfb+M1oVjRigX3XktITYgzPZFRjieJtQ7v5z/EDDLiEfbiNsUkbhPm1/nf5iw0DonmtuGqUlUHDMTR9m4FwU5+2JRpSw4kzXP0ZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opZD7/H7h83g7PdQrvkGP0w8hXwy9DMdQl3VHyCIL4s=;
 b=K61yctdfxUJgS90g01t59q1cKkboQ7tmuGB4goIhzzXHNhwBxxqE9x1XRl0rVMBOQxEQCJ/qMZLg0fYSRpMuee9SPEY2oXLeC2ssu+bcle7HN9yctOl6q9KYwz9erGcuoYABuh4K3pNO7hv+kIq8WeF5Xq138zmL2bCojRdoYSJvFtcmUDqpRxHx6jUxXp+UGNTviH0i+C2RRTVOYUHWGLW6a/kmvJc31fa0IpBxwiPLFPKC6Q+KvrmPerDcdQLY+9bM0jebSS6gxPOad08Vo2D/USutNe37eDmCw18WB2wGMxwBnIyJCoG4H3tqInqfIujiZkRCbTxV705Tks2HKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opZD7/H7h83g7PdQrvkGP0w8hXwy9DMdQl3VHyCIL4s=;
 b=J6q1mbPnJCVlgVLjaKALcH0buyNARsBsMWhBVOXhejUWs2FLveiktOjisU3MFZpETn1JSdOOil6DhpBygfF1gsscnypwW3LV7cS0bRp5bCe0jdncjyJGwHXSpZsVtvWiCLWdT2sHylg9IYpLZvlpaGl/4qfKnlQcafnETLYvmc0=
Received: from BN6PR03CA0069.namprd03.prod.outlook.com (2603:10b6:404:4c::31)
 by BYAPR03MB3896.namprd03.prod.outlook.com (2603:10b6:a03:66::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Thu, 1 Aug
 2019 08:24:27 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BN6PR03CA0069.outlook.office365.com
 (2603:10b6:404:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.12 via Frontend
 Transport; Thu, 1 Aug 2019 08:24:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Thu, 1 Aug 2019 08:24:26 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x718OPqx018920
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Aug 2019 01:24:25 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 1 Aug 2019 04:24:25 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/5] iio:accel: do not allocate/de-allocate buffer here
 but link setup_ops to st_sensors_buffer
Thread-Topic: [PATCH 2/5] iio:accel: do not allocate/de-allocate buffer here
 but link setup_ops to st_sensors_buffer
Thread-Index: AQHVR+pVSIhKNpu0rU2DzcXhxkItbKbmapKA
Date:   Thu, 1 Aug 2019 08:24:25 +0000
Message-ID: <792e4db0a0a9a86e2d9d88943619dbcb2ab3dc86.camel@analog.com>
References: <20190731215250.16403-1-denis.ciocca@st.com>
         <20190731215250.16403-3-denis.ciocca@st.com>
In-Reply-To: <20190731215250.16403-3-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.109]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <26122707595F9545A8B62AB3F314E691@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(396003)(2980300002)(189003)(199004)(316002)(102836004)(6246003)(2201001)(246002)(305945005)(7636002)(36756003)(478600001)(7736002)(2906002)(47776003)(2501003)(229853002)(8936002)(50466002)(14454004)(6116002)(8676002)(106002)(110136005)(86362001)(356004)(118296001)(3846002)(2616005)(76176011)(126002)(11346002)(446003)(70206006)(336012)(436003)(426003)(70586007)(186003)(23676004)(486006)(7696005)(476003)(5660300002)(2486003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3896;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fbb1a8-4da0-444b-f5d5-08d71659aa84
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3896;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3896:
X-Microsoft-Antispam-PRVS: <BYAPR03MB389646E71CA79840190CDE4DF9DE0@BYAPR03MB3896.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0qN8HIc1n6vMHRHoRHypi0H4VhWwiy9UbjdeFYI0456rtlvPHz5mvSWXAmfeFBuXALt2zJhHmFcc1lqkNjlmM2rhHlZf8Rqeqj4Wv/NN4jWSigVYmy9D2H/Dl9978AClE/LD0WwpwSc7JJtS0bGnasJ5IFSRD2zOtxPJxSekWMh0EqCtkP6JLQk21WYsTUqVHWqAHAdto4dIiMAs13DqBVoe+qKBPLEDUyoH5gyW51oJGVeFlMTXagShs07FmQegeYwSS0bs2xyKOhEfYyNdDVdqwRF4pLRq9uqYvDg1uuPVXViwXZtQXSWZkivynKFs1ZgV/JDYSpZzFG2m8EE1lTIUu5i9J7LWcXGRerzLz8+9LYdwHCmJ17QfEJ4lDFc2zcO2Ko5X4mxY9L1XnfA6Qc7BnTjSmS0GzNRqb8ob5/E=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 08:24:26.2553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fbb1a8-4da0-444b-f5d5-08d71659aa84
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3896
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
L2lpby9hY2NlbC9zdF9hY2NlbF9idWZmZXIuYyB8IDE0ICsrKy0tLS0tLS0tLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lpby9hY2NlbC9zdF9hY2NlbF9idWZmZXIuYyBiL2RyaXZlcnMvaWlv
L2FjY2VsL3N0X2FjY2VsX2J1ZmZlci5jDQo+IGluZGV4IDU5ZGNlZjAyZWMxOS4uZmMxYmE1MjE1
MmFiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hY2NlbC9zdF9hY2NlbF9idWZmZXIuYw0K
PiArKysgYi9kcml2ZXJzL2lpby9hY2NlbC9zdF9hY2NlbF9idWZmZXIuYw0KPiBAQCAtMzEsMTcg
KzMxLDExIEBAIGludCBzdF9hY2NlbF90cmlnX3NldF9zdGF0ZShzdHJ1Y3QgaWlvX3RyaWdnZXIg
KnRyaWcsIGJvb2wgc3RhdGUpDQo+ICANCj4gIHN0YXRpYyBpbnQgc3RfYWNjZWxfYnVmZmVyX3Bv
c3RlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gIHsNCj4gLQlzdHJ1Y3Qgc3Rf
c2Vuc29yX2RhdGEgKmFkYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gIAlpbnQgZXJyOw0K
PiAgDQo+IC0JYWRhdGEtPmJ1ZmZlcl9kYXRhID0ga21hbGxvYyhpbmRpb19kZXYtPnNjYW5fYnl0
ZXMsDQo+IC0JCQkJICAgICBHRlBfRE1BIHwgR0ZQX0tFUk5FTCk7DQo+IC0JaWYgKCFhZGF0YS0+
YnVmZmVyX2RhdGEpDQo+IC0JCXJldHVybiAtRU5PTUVNOw0KPiAtDQo+ICAJZXJyID0gaWlvX3Ry
aWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZShpbmRpb19kZXYpOw0KPiAgCWlmIChlcnIgPCAwKQ0K
PiAtCQlnb3RvIHN0X2FjY2VsX2ZyZWVfYnVmZmVyOw0KPiArCQlyZXR1cm4gZXJyOw0KPiAgDQo+
ICAJZXJyID0gc3Rfc2Vuc29yc19zZXRfYXhpc19lbmFibGUoaW5kaW9fZGV2LA0KPiAgCQkJCQkg
KHU4KWluZGlvX2Rldi0+YWN0aXZlX3NjYW5fbWFza1swXSk7DQo+IEBAIC01OCwxNCArNTIsMTEg
QEAgc3RhdGljIGludCBzdF9hY2NlbF9idWZmZXJfcG9zdGVuYWJsZShzdHJ1Y3QgaWlvX2RldiAq
aW5kaW9fZGV2KQ0KPiAgCXN0X3NlbnNvcnNfc2V0X2F4aXNfZW5hYmxlKGluZGlvX2RldiwgU1Rf
U0VOU09SU19FTkFCTEVfQUxMX0FYSVMpOw0KPiAgc3RfYWNjZWxfYnVmZmVyX3ByZWRpc2FibGU6
DQo+ICAJaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiAtc3Rf
YWNjZWxfZnJlZV9idWZmZXI6DQo+IC0Ja2ZyZWUoYWRhdGEtPmJ1ZmZlcl9kYXRhKTsNCj4gIAly
ZXR1cm4gZXJyOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IHN0X2FjY2VsX2J1ZmZlcl9wcmVk
aXNhYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICB7DQo+IC0Jc3RydWN0IHN0X3Nl
bnNvcl9kYXRhICphZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICAJaW50IGVyciwgZXJy
MjsNCj4gIA0KPiAgCWVyciA9IHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIGZhbHNl
KTsNCj4gQEAgLTc5LDEzICs3MCwxNCBAQCBzdGF0aWMgaW50IHN0X2FjY2VsX2J1ZmZlcl9wcmVk
aXNhYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICAJaWYgKCFlcnIpDQo+ICAJCWVy
ciA9IGVycjI7DQo+ICANCj4gLQlrZnJlZShhZGF0YS0+YnVmZmVyX2RhdGEpOw0KPiAgCXJldHVy
biBlcnI7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2J1ZmZlcl9zZXR1
cF9vcHMgc3RfYWNjZWxfYnVmZmVyX3NldHVwX29wcyA9IHsNCj4gKwkucHJlZW5hYmxlID0gJnN0
X3NlbnNvcnNfYnVmZmVyX3ByZWVuYWJsZSwNCj4gIAkucG9zdGVuYWJsZSA9ICZzdF9hY2NlbF9i
dWZmZXJfcG9zdGVuYWJsZSwNCj4gIAkucHJlZGlzYWJsZSA9ICZzdF9hY2NlbF9idWZmZXJfcHJl
ZGlzYWJsZSwNCj4gKwkucG9zdGRpc2FibGUgPSAmc3Rfc2Vuc29yc19idWZmZXJfcG9zdGRpc2Fi
bGUsDQo+ICB9Ow0KPiAgDQo+ICBpbnQgc3RfYWNjZWxfYWxsb2NhdGVfcmluZyhzdHJ1Y3QgaWlv
X2RldiAqaW5kaW9fZGV2KQ0K
