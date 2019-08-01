Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4D7D77D
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 10:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHAIZZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 04:25:25 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:12360 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfHAIZZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 04:25:25 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x718NAY1032492;
        Thu, 1 Aug 2019 04:25:21 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u3dkcbpph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:25:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWGuW3aWaZ4qP7HMvxQTcJCxKvmQ8C39lXyEPVo7ZQb1k2BUmTOb0yuGTMlTNGsCjoXoxugeLjRmYzKg5c5gmwCr/EGHOQnn8OMDLHmZyAam5CQrIhIPLriRYDQ5N6xBnEq5ivPUSoJQllhX2bfy7x4w+QTNUwttrICH7ki2eZE0yGzluhrVyIQ4Ll0uuKtHeHGz6B5qF4Je0zh4VUeu2xNvdkkHUfxRxOdb21aSJwM+u64Ae28+HfEvWIqL3wSRg+yPIGK1Ep6QiRqQwvKqwKm7Mg1HCXFckOKLbRXzlPBqjoLjLYlTKbMJPySYth0mBTg3qkToJfokO9N5Q00o5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbuHWYK0hJ1vCJCT8y10p4wjOERPI0KG4l4bmSX7UgY=;
 b=inE8rNm3Zl+F27o6diBiySkQEz/We0GNMlVNwUAc6c+vOD5z0ohPNey0hT/VqkKRIiH61CGZqfROIUkJEuOt8Vsm5Fsv0tZe0EXTN6ynO8OIcbcZa9Z/hf0EqI/pEjNLvKAdP609plV8WEWL1VC2RsrVP0MliiRf2slnlS4wjqNfrE2iuPreCVnJu/zjSxtC04xA/yEepyZd9k5sQwDpSO0rQ524snRni7xUG4hk+YpaZkOv1run/KfFcCRWdMMaXRHd9NTMgdpFECii7YwfFlArJJjjEa+ZNbR6uk3sOFZy9cOX5g3nNzvZsLNskV18r5pzkSAqOL/YTHmZGtbXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbuHWYK0hJ1vCJCT8y10p4wjOERPI0KG4l4bmSX7UgY=;
 b=tBuIVvGuT2jZ7LxNr96el9dQiGKIwsePw4kXz4a3p9tU20zwq580itZVA0C13pNEywa9gp5DII4f3Yo2FzxlYjpF7kjcRwNUBRUWINwLi7Jod5HT3wqfSZuVY68u9tmHJEAg6U2UJ+1Ux5WyxSF+4nKEzXkXI5Fn4wPEfIA26P4=
Received: from MWHPR03CA0016.namprd03.prod.outlook.com (2603:10b6:300:117::26)
 by BN6PR03MB2932.namprd03.prod.outlook.com (2603:10b6:404:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.13; Thu, 1 Aug
 2019 08:25:18 +0000
Received: from CY1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by MWHPR03CA0016.outlook.office365.com
 (2603:10b6:300:117::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.12 via Frontend
 Transport; Thu, 1 Aug 2019 08:25:16 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT026.mail.protection.outlook.com (10.152.75.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Thu, 1 Aug 2019 08:25:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x718PFo0019028
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Aug 2019 01:25:15 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Thu, 1 Aug 2019 04:25:15 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/5] iio:gyro: do not allocate/de-allocate buffer here
 but link setup_ops to st_sensors_buffer
Thread-Topic: [PATCH 3/5] iio:gyro: do not allocate/de-allocate buffer here
 but link setup_ops to st_sensors_buffer
Thread-Index: AQHVR+pZBFKAPZMFhEmCDNx9ul6jrqbmasuA
Date:   Thu, 1 Aug 2019 08:25:13 +0000
Message-ID: <e711588a5d60b5648aaeaffd39eb46a66c639655.camel@analog.com>
References: <20190731215250.16403-1-denis.ciocca@st.com>
         <20190731215250.16403-4-denis.ciocca@st.com>
In-Reply-To: <20190731215250.16403-4-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.109]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F8C053403B23648B97D94E56AC8ED04@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(199004)(189003)(50466002)(8936002)(8676002)(336012)(246002)(229853002)(36756003)(305945005)(436003)(356004)(316002)(7736002)(486006)(7636002)(106002)(426003)(126002)(14454004)(476003)(2616005)(446003)(478600001)(110136005)(2501003)(11346002)(5660300002)(102836004)(3846002)(70586007)(70206006)(23676004)(118296001)(2486003)(7696005)(47776003)(76176011)(2906002)(6246003)(6116002)(2201001)(86362001)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2932;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbdd140f-4005-4de1-2a97-08d71659c843
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BN6PR03MB2932;
X-MS-TrafficTypeDiagnostic: BN6PR03MB2932:
X-Microsoft-Antispam-PRVS: <BN6PR03MB293220690FACA129BD562C59F9DE0@BN6PR03MB2932.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: dCrB2dC/ZyRbsQKjIJelov9McQ0q2CGo/02W/8rzP9ma4c7IaCSwux3sPAUhjPCgE+gte4TNrwh+pBgVWH+1gYNx9mcXbWi6wkvj3I1AQ5917PWF+N1Bqzls7L3KEkPv9Y84EA1/T9P22RDIrEdGl9ft6Z1CiPnZmE/QuxPQ1VtkHlr6y98GLa9rffL593dCHN+/xyOEtIGW7IKpS1inkUO/dZGCG0iSPlWvet9yu+6Vp3TZTk8f0tvx5/vuigm+n5dUQOEDLjRi2PdIYcAKSP7AVBcBZ1uz1VTPcZQ4XfObkfOaX+IT3mR8v7YsL3UXo5Ko7sDUNw7dUU3ma1YoKCtF3+emXT2yKZOpIi33XfhzOcMetglcrkZN+1JD7TR42quUayjzEykJyPZDGs44w6wScw32LtWkmuN21l4jcg0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 08:25:16.0367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdd140f-4005-4de1-2a97-08d71659c843
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2932
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
L2lpby9neXJvL3N0X2d5cm9fYnVmZmVyLmMgfCAxNCArKystLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vZ3lyby9zdF9neXJvX2J1ZmZlci5jIGIvZHJpdmVycy9paW8vZ3ly
by9zdF9neXJvX2J1ZmZlci5jDQo+IGluZGV4IGM2ZGRmZWNjMWZjMy4uNDg4MTE0NTdhOTQzIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9neXJvL3N0X2d5cm9fYnVmZmVyLmMNCj4gKysrIGIv
ZHJpdmVycy9paW8vZ3lyby9zdF9neXJvX2J1ZmZlci5jDQo+IEBAIC0zMSwxNyArMzEsMTEgQEAg
aW50IHN0X2d5cm9fdHJpZ19zZXRfc3RhdGUoc3RydWN0IGlpb190cmlnZ2VyICp0cmlnLCBib29s
IHN0YXRlKQ0KPiAgDQo+ICBzdGF0aWMgaW50IHN0X2d5cm9fYnVmZmVyX3Bvc3RlbmFibGUoc3Ry
dWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gIHsNCj4gLQlzdHJ1Y3Qgc3Rfc2Vuc29yX2RhdGEg
KmdkYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gIAlpbnQgZXJyOw0KPiAgDQo+IC0JZ2Rh
dGEtPmJ1ZmZlcl9kYXRhID0ga21hbGxvYyhpbmRpb19kZXYtPnNjYW5fYnl0ZXMsDQo+IC0JCQkJ
ICAgICBHRlBfRE1BIHwgR0ZQX0tFUk5FTCk7DQo+IC0JaWYgKCFnZGF0YS0+YnVmZmVyX2RhdGEp
DQo+IC0JCXJldHVybiAtRU5PTUVNOw0KPiAtDQo+ICAJZXJyID0gaWlvX3RyaWdnZXJlZF9idWZm
ZXJfcG9zdGVuYWJsZShpbmRpb19kZXYpOw0KPiAgCWlmIChlcnIgPCAwKQ0KPiAtCQlnb3RvIHN0
X2d5cm9fZnJlZV9idWZmZXI7DQo+ICsJCXJldHVybiBlcnI7DQo+ICANCj4gIAllcnIgPSBzdF9z
ZW5zb3JzX3NldF9heGlzX2VuYWJsZShpbmRpb19kZXYsDQo+ICAJCQkJCSAodTgpaW5kaW9fZGV2
LT5hY3RpdmVfc2Nhbl9tYXNrWzBdKTsNCj4gQEAgLTU4LDE1ICs1MiwxMiBAQCBzdGF0aWMgaW50
IHN0X2d5cm9fYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4g
IAlzdF9zZW5zb3JzX3NldF9heGlzX2VuYWJsZShpbmRpb19kZXYsIFNUX1NFTlNPUlNfRU5BQkxF
X0FMTF9BWElTKTsNCj4gIHN0X2d5cm9fYnVmZmVyX3ByZWRpc2FibGU6DQo+ICAJaWlvX3RyaWdn
ZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiAtc3RfZ3lyb19mcmVlX2J1ZmZl
cjoNCj4gLQlrZnJlZShnZGF0YS0+YnVmZmVyX2RhdGEpOw0KPiAgCXJldHVybiBlcnI7DQo+ICB9
DQo+ICANCj4gIHN0YXRpYyBpbnQgc3RfZ3lyb19idWZmZXJfcHJlZGlzYWJsZShzdHJ1Y3QgaWlv
X2RldiAqaW5kaW9fZGV2KQ0KPiAgew0KPiAgCWludCBlcnIsIGVycjI7DQo+IC0Jc3RydWN0IHN0
X3NlbnNvcl9kYXRhICpnZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICANCj4gIAllcnIg
PSBzdF9zZW5zb3JzX3NldF9lbmFibGUoaW5kaW9fZGV2LCBmYWxzZSk7DQo+ICAJaWYgKGVyciA8
IDApDQo+IEBAIC03OSwxMyArNzAsMTQgQEAgc3RhdGljIGludCBzdF9neXJvX2J1ZmZlcl9wcmVk
aXNhYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICAJaWYgKCFlcnIpDQo+ICAJCWVy
ciA9IGVycjI7DQo+ICANCj4gLQlrZnJlZShnZGF0YS0+YnVmZmVyX2RhdGEpOw0KPiAgCXJldHVy
biBlcnI7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2J1ZmZlcl9zZXR1
cF9vcHMgc3RfZ3lyb19idWZmZXJfc2V0dXBfb3BzID0gew0KPiArCS5wcmVlbmFibGUgPSAmc3Rf
c2Vuc29yc19idWZmZXJfcHJlZW5hYmxlLA0KPiAgCS5wb3N0ZW5hYmxlID0gJnN0X2d5cm9fYnVm
ZmVyX3Bvc3RlbmFibGUsDQo+ICAJLnByZWRpc2FibGUgPSAmc3RfZ3lyb19idWZmZXJfcHJlZGlz
YWJsZSwNCj4gKwkucG9zdGRpc2FibGUgPSAmc3Rfc2Vuc29yc19idWZmZXJfcG9zdGRpc2FibGUs
DQo+ICB9Ow0KPiAgDQo+ICBpbnQgc3RfZ3lyb19hbGxvY2F0ZV9yaW5nKHN0cnVjdCBpaW9fZGV2
ICppbmRpb19kZXYpDQo=
