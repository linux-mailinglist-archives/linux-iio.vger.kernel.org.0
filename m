Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14E47A369
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 10:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfG3Iwo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jul 2019 04:52:44 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:52836 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731174AbfG3Iwn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2019 04:52:43 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U8mOO1014313;
        Tue, 30 Jul 2019 04:52:38 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2059.outbound.protection.outlook.com [104.47.42.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u1nhy4p6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 04:52:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiE6+4nc2zF41ni/kbrbRH44M6pQ3bjFOUI/NCGu8DssieFOccbJKmBd3uul+ZRxxWnS3ieupKqRlgVY2bsNMG5rFKfWAx1Bo1r3jbQzoSOvWfKLE8IF/lV9renoSId5stwGrRfMH/U73641FyqQnJk4fRnXDWRelxdL0Pj7l9GThscAW5f6X+gB4Uq6IFi+hYpPEOVnmoEAG2ywlr35IH2vouyxidCdDGj13bnB9/pTf6nqafRNODeyJXKCpLc7i2n/Nzv9d47YBbLdQeszzvvO850jDaBjQIMAfhu23I64xbf4AOlUKY01YX92PJV050NUu4gNO+LxpOajBdQlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/KpyIb0nSE/5V8G96VE4xsEp243GuLQQeJTgAuFc6o=;
 b=b70vcZtaN3m1Htcb5nAmVxnvRmWQSexx9RG3DWb8/qlCnF26rC4eZrxiZQzujodf/H7mL41nlcSY31WlqIOILpcId/W/f73n/VGhptWISmrfIOACoLQwLu2tLlQPyzlxOkJNG3La0PRN/h90LktYZNqCcVlAlIbIDsxxExTkiDg3jbwrnUqqX76KFCmeRrxOXb0DKBbaanpp+Ree+QVnX+Z78jEt/u+8dJuBJtl0H3YTODY9ZRpEaMfwogtPWauFid6U9sFhqaIhCOIGg+B7wzEKQD4WJ3mVvE5aM9vofN1htYT6Cg2fskc6gNB6aPZQUNxfL7uPzgtpmEU4Z3PeLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/KpyIb0nSE/5V8G96VE4xsEp243GuLQQeJTgAuFc6o=;
 b=8vmdodA5SAPJWt+uxuRRb36ht6PBhuv8QCED6OGzOFigs6Na7orPMZhepHU7TUZ0ORdqjBHBhXvrb7TFppfDENfeKZvxh+4A+DO2XYj950fxwkN8/65A/xfvRJmKPFWw2X6RX4NZ5eVVUSfBYYa2JCtjUIa6CwZY6QLSHxXapnc=
Received: from BN6PR03CA0094.namprd03.prod.outlook.com (2603:10b6:405:6f::32)
 by CY4PR03MB3143.namprd03.prod.outlook.com (2603:10b6:910:53::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.15; Tue, 30 Jul
 2019 08:52:36 +0000
Received: from CY1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN6PR03CA0094.outlook.office365.com
 (2603:10b6:405:6f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.15 via Frontend
 Transport; Tue, 30 Jul 2019 08:52:36 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT023.mail.protection.outlook.com (10.152.74.237) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Tue, 30 Jul 2019 08:52:35 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6U8qZ8Z022047
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 30 Jul 2019 01:52:35 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Tue, 30 Jul 2019 04:52:35 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio:gyro: preenable/postenable/predisable fixup for
 ST gyro buffer
Thread-Topic: [PATCH 2/4] iio:gyro: preenable/postenable/predisable fixup
 for ST gyro buffer
Thread-Index: AQHVRmtKT95+Nm5iM0yz0crzSKkxBKbjUMEA
Date:   Tue, 30 Jul 2019 08:52:34 +0000
Message-ID: <d4d9b123f91814b8e8f6ff50787df04c50a26a88.camel@analog.com>
References: <20190730000305.30958-1-denis.ciocca@st.com>
         <20190730000305.30958-3-denis.ciocca@st.com>
In-Reply-To: <20190730000305.30958-3-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.107]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2270D2229764C84C9309D50C78E853BE@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(189003)(199004)(11346002)(446003)(486006)(6246003)(336012)(436003)(106002)(476003)(2501003)(478600001)(126002)(2616005)(316002)(426003)(14454004)(47776003)(76176011)(26005)(6116002)(3846002)(2906002)(23676004)(186003)(110136005)(2486003)(7636002)(7736002)(50466002)(246002)(36756003)(8676002)(8936002)(5660300002)(7696005)(102836004)(118296001)(70586007)(70206006)(356004)(305945005)(229853002)(2201001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3143;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aaf3709-3648-4581-8f2f-08d714cb44a6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CY4PR03MB3143;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3143:
X-Microsoft-Antispam-PRVS: <CY4PR03MB3143A6A46284B13CA7557EB6F9DC0@CY4PR03MB3143.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0114FF88F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2vnOgNnQfx56Q0rcwJGaiVQxrA2IPMHIRlRm8U/AzHSYkwh5a+Ybz19g4uU2h/kil7qrlA4gmmLGg/JlQtSF/MnEmCmTrR4FV3lvAVx2dm68qraX9yiBmI9jsP1ZUmBlqd6FHeb43Z0HUwFatbzOhLlChAghzHVwVpwIZsPzdM397XjQq1p7PGPfmEKibcrQmNA+mMirz9FnDc+kvGQOJYDOb5luaYikAbnb+Cu5G/gNrXaguod1CyTLsZ3FBR3tJEFvsRY2pGoIC4piwQGm45EH577awtAZ9+1McT3CL56/xEBUQC7eGIWqLFefL+uTrgXWNKkUptlgYbDqg9g+q7XGcXeKFV3LxeXxJe9DAiEh6e0qixZfucSIZ6L04ujw+v9WbI01m17pGmGN07HKMNR8U0J0UnIUe0knU5WUNNM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2019 08:52:35.5905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaf3709-3648-4581-8f2f-08d714cb44a6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3143
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300095
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
YW5AYW5hbG9nLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBDaW9jY2EgPGRlbmlzLmNp
b2NjYUBzdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vZ3lyby9zdF9neXJvX2J1ZmZlci5j
IHwgNDUgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDE5IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2d5cm8vc3RfZ3lyb19idWZmZXIuYyBiL2RyaXZlcnMvaWlvL2d5cm8vc3RfZ3ly
b19idWZmZXIuYw0KPiBpbmRleCAyMTM2MDY4MWQ0ZGQuLmJlOWYxZmVjMmI1ZCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9paW8vZ3lyby9zdF9neXJvX2J1ZmZlci5jDQo+ICsrKyBiL2RyaXZlcnMv
aWlvL2d5cm8vc3RfZ3lyb19idWZmZXIuYw0KPiBAQCAtMjksNjIgKzI5LDU1IEBAIGludCBzdF9n
eXJvX3RyaWdfc2V0X3N0YXRlKHN0cnVjdCBpaW9fdHJpZ2dlciAqdHJpZywgYm9vbCBzdGF0ZSkN
Cj4gIAlyZXR1cm4gc3Rfc2Vuc29yc19zZXRfZGF0YXJlYWR5X2lycShpbmRpb19kZXYsIHN0YXRl
KTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBzdF9neXJvX2J1ZmZlcl9wcmVlbmFibGUoc3Ry
dWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gLXsNCj4gLQlyZXR1cm4gc3Rfc2Vuc29yc19zZXRf
ZW5hYmxlKGluZGlvX2RldiwgdHJ1ZSk7DQo+IC19DQo+IC0NCj4gIHN0YXRpYyBpbnQgc3RfZ3ly
b19idWZmZXJfcG9zdGVuYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiAgew0KPiAt
CWludCBlcnI7DQo+ICAJc3RydWN0IHN0X3NlbnNvcl9kYXRhICpnZGF0YSA9IGlpb19wcml2KGlu
ZGlvX2Rldik7DQo+ICsJaW50IGVycjsNCj4gIA0KPiAgCWdkYXRhLT5idWZmZXJfZGF0YSA9IGtt
YWxsb2MoaW5kaW9fZGV2LT5zY2FuX2J5dGVzLA0KPiAgCQkJCSAgICAgR0ZQX0RNQSB8IEdGUF9L
RVJORUwpOw0KPiAtCWlmIChnZGF0YS0+YnVmZmVyX2RhdGEgPT0gTlVMTCkgew0KPiAtCQllcnIg
PSAtRU5PTUVNOw0KPiAtCQlnb3RvIGFsbG9jYXRlX21lbW9yeV9lcnJvcjsNCj4gLQl9DQo+ICsJ
aWYgKCFnZGF0YS0+YnVmZmVyX2RhdGEpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiAgDQo+IC0J
ZXJyID0gc3Rfc2Vuc29yc19zZXRfYXhpc19lbmFibGUoaW5kaW9fZGV2LA0KPiAtCQkJCQkodTgp
aW5kaW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNrWzBdKTsNCj4gKwllcnIgPSBpaW9fdHJpZ2dlcmVk
X2J1ZmZlcl9wb3N0ZW5hYmxlKGluZGlvX2Rldik7DQo+ICAJaWYgKGVyciA8IDApDQo+IC0JCWdv
dG8gc3RfZ3lyb19idWZmZXJfcG9zdGVuYWJsZV9lcnJvcjsNCj4gKwkJZ290byBzdF9neXJvX2Zy
ZWVfYnVmZmVyOw0KPiAgDQo+IC0JZXJyID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJs
ZShpbmRpb19kZXYpOw0KPiArCWVyciA9IHN0X3NlbnNvcnNfc2V0X2F4aXNfZW5hYmxlKGluZGlv
X2RldiwNCj4gKwkJCQkJICh1OClpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2tbMF0pOw0KPiAg
CWlmIChlcnIgPCAwKQ0KPiAtCQlnb3RvIHN0X2d5cm9fYnVmZmVyX3Bvc3RlbmFibGVfZXJyb3I7
DQo+ICsJCWdvdG8gc3RfZ3lyb19idWZmZXJfcHJlZGlzYWJsZTsNCj4gIA0KPiAtCXJldHVybiBl
cnI7DQo+ICsJcmV0dXJuIHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIHRydWUpOw0K
PiAgDQo+IC1zdF9neXJvX2J1ZmZlcl9wb3N0ZW5hYmxlX2Vycm9yOg0KPiArc3RfZ3lyb19idWZm
ZXJfcHJlZGlzYWJsZToNCj4gKwlpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlv
X2Rldik7DQo+ICtzdF9neXJvX2ZyZWVfYnVmZmVyOg0KPiAgCWtmcmVlKGdkYXRhLT5idWZmZXJf
ZGF0YSk7DQo+IC1hbGxvY2F0ZV9tZW1vcnlfZXJyb3I6DQo+ICAJcmV0dXJuIGVycjsNCj4gIH0N
Cj4gIA0KPiAgc3RhdGljIGludCBzdF9neXJvX2J1ZmZlcl9wcmVkaXNhYmxlKHN0cnVjdCBpaW9f
ZGV2ICppbmRpb19kZXYpDQo+ICB7DQo+IC0JaW50IGVycjsNCj4gKwlpbnQgZXJyLCBlcnIyOw0K
PiAgCXN0cnVjdCBzdF9zZW5zb3JfZGF0YSAqZ2RhdGEgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0K
PiAgDQo+IC0JZXJyID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYp
Ow0KPiArCWVyciA9IHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIGZhbHNlKTsNCj4g
IAlpZiAoZXJyIDwgMCkNCj4gLQkJZ290byBzdF9neXJvX2J1ZmZlcl9wcmVkaXNhYmxlX2Vycm9y
Ow0KPiArCQlnb3RvIHN0X2d5cm9fYnVmZmVyX3ByZWRpc2FibGU7DQo+ICANCj4gIAllcnIgPSBz
dF9zZW5zb3JzX3NldF9heGlzX2VuYWJsZShpbmRpb19kZXYsIFNUX1NFTlNPUlNfRU5BQkxFX0FM
TF9BWElTKTsNCj4gLQlpZiAoZXJyIDwgMCkNCj4gLQkJZ290byBzdF9neXJvX2J1ZmZlcl9wcmVk
aXNhYmxlX2Vycm9yOw0KPiAgDQo+IC0JZXJyID0gc3Rfc2Vuc29yc19zZXRfZW5hYmxlKGluZGlv
X2RldiwgZmFsc2UpOw0KPiArc3RfZ3lyb19idWZmZXJfcHJlZGlzYWJsZToNCj4gKwllcnIyID0g
aWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiArCWlmICghZXJy
KQ0KPiArCQllcnIgPSBlcnIyOw0KPiAgDQo+IC1zdF9neXJvX2J1ZmZlcl9wcmVkaXNhYmxlX2Vy
cm9yOg0KPiAgCWtmcmVlKGdkYXRhLT5idWZmZXJfZGF0YSk7DQo+ICAJcmV0dXJuIGVycjsNCj4g
IH0NCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fYnVmZmVyX3NldHVwX29wcyBzdF9n
eXJvX2J1ZmZlcl9zZXR1cF9vcHMgPSB7DQo+IC0JLnByZWVuYWJsZSA9ICZzdF9neXJvX2J1ZmZl
cl9wcmVlbmFibGUsDQo+ICAJLnBvc3RlbmFibGUgPSAmc3RfZ3lyb19idWZmZXJfcG9zdGVuYWJs
ZSwNCj4gIAkucHJlZGlzYWJsZSA9ICZzdF9neXJvX2J1ZmZlcl9wcmVkaXNhYmxlLA0KPiAgfTsN
Cg==
