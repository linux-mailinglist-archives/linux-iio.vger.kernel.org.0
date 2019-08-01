Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7E67D76F
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfHAIW0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 04:22:26 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36340 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfHAIW0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 04:22:26 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x718LbfX006626;
        Thu, 1 Aug 2019 04:22:21 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2051.outbound.protection.outlook.com [104.47.40.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u2q4nxf3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:22:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtZUW7K+J6qh5nebTXpbSqlypSInJpcpr916OSz9Ylc1QWq4UOBhmC8Y1+tuD285YRdTRY9OliNLmoDW9m/FH3MA2cunj3HWy6hyZhbFWGz+37krNXS6x1Pz/ncpIkI1ksc24d40hR716cuXsOzvg2VMCjTSi5ibAEdo/DiAMUyAkOuZzf3IGMCiauywgm/bOU8cFyDRiIQn7D8Du0xurbaYr92ko8PMXjPXV/l8ezvZX0C1GFuLEEIbje2qb/ivhOHMlqxyF984XjhfBebrfvx2oqJW4VEJMiPfy/0pPVCRdEAMUfNbQ2iusDxAFR9TCYHqmNmgmuj0c3yzucN3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgaLwqRdr1+ZpTVVX9gydn7jr3jxF2nq1x14DgFMGzs=;
 b=P/rpTuYMhqjS9Jje8papLFs9mHMVL9kEXslRugsuG+tNLn6FZaGvhwD9YOvbjcp99BiQwycPqKJf8EjNmCu0bbCYgYHJ5hLg2Dd+AdvCsirKe8v/A9hQ+HRL/JjfKuYYcpRW7saJKJTCBLjCOaGbi8QjGr02Clltzdsor434IwbrvCNs+Nc46PSapw41r2eAAQgK/QknOHnonsuM7XYK8eRGonZs1b1K+X+kOfV1h9xcZgUFDCp7lR3ng6ta/HYoG8kpvcMoILMN8LHiLUfpsRq9aNTAoeK/qj0IA39rOcoZagooA8cObdMCl4DLeaUjfV9tgFh8a1L9N3DByn5ANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgaLwqRdr1+ZpTVVX9gydn7jr3jxF2nq1x14DgFMGzs=;
 b=vj70YYMfW0LkW4VLI1aUdBeMz5GLydYh0h3KD50+4ZgJqOUi2srjmi2Iz9qSb2fq96bH9RNCicbMoGsA3ol7tVcp9G8MSNBEL8VOP7Mv2Nx75MrcCgNmKlAY/w2wetUp0Rxj3IINk6iLxr0Vljnudg5U6nMEOuacK8+5Jaq/b14=
Received: from BN3PR03CA0075.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::35) by DM6PR03MB3418.namprd03.prod.outlook.com
 (2603:10b6:5:a9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Thu, 1 Aug
 2019 08:22:18 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN3PR03CA0075.outlook.office365.com
 (2a01:111:e400:7a4d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.16 via Frontend
 Transport; Thu, 1 Aug 2019 08:22:18 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Thu, 1 Aug 2019 08:22:17 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x718MGkO018325
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Aug 2019 01:22:16 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 1 Aug 2019 04:22:16 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio:pressure: preenable/postenable/predisable
 fixup for ST press buffer
Thread-Topic: [PATCH v2 4/4] iio:pressure: preenable/postenable/predisable
 fixup for ST press buffer
Thread-Index: AQHVR+nV8gSZu4sp5EyxUkRPXazkZ6bmafkA
Date:   Thu, 1 Aug 2019 08:22:16 +0000
Message-ID: <c6ea32319e4d2dc0e8e2b7854cbdf903841bbeb2.camel@analog.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
         <20190731214900.15380-5-denis.ciocca@st.com>
In-Reply-To: <20190731214900.15380-5-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.109]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3694E9F6BE58E42A02280B20F8B3B22@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(189003)(199004)(70206006)(8676002)(426003)(11346002)(436003)(486006)(2486003)(47776003)(476003)(2616005)(36756003)(126002)(316002)(76176011)(5660300002)(86362001)(102836004)(23676004)(106002)(118296001)(8936002)(14454004)(3846002)(6116002)(7696005)(50466002)(229853002)(446003)(70586007)(2501003)(6246003)(110136005)(2201001)(7736002)(186003)(7636002)(26005)(356004)(2906002)(478600001)(336012)(246002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3418;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed4550d9-f098-46e8-9efc-08d716595dda
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DM6PR03MB3418;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3418:
X-Microsoft-Antispam-PRVS: <DM6PR03MB34189D8706D79E48AF95B0A8F9DE0@DM6PR03MB3418.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FZDQZQ8EICKwy9YfN5QYp+O13gVZtU3AEMrXBjroSEpbvLwZdOaxMrL6bI748SsUrm4CHLZzA7bG94tZcqDx8l8ghQD1R4dPJXK5/yzmDpmNJ8YDyTBviA/58J3qdF5HrJSTwozkP9GQVzyX7+fQRHTc1vYJ4H8dejGbbiatJtRXUXIwgrOXiVpuFE88glXtJ/YZug/CW3+NM0suP1MFs6NyMQ23SoBzyikmDe/SbCNIYXp/FgM5wVmldS0L6oRh5QfoQpP80ASpgUUo122dI703lG7LNjbcuWEgm84OMQH1T6U2DUTZumSxku/S4CGg29De11jaj7P+bukF+cSO1iPvL4mjegnenJvSB7P7IJmR8WHE0pUucUOTrf/3g+7XP7XRz4R7tsMarjFQezzQZ11Ws87ui2YPNYWzBVrHThQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 08:22:17.6213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4550d9-f098-46e8-9efc-08d716595dda
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
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTMxIGF0IDE0OjQ5IC0wNzAwLCBEZW5pcyBDaW9jY2Egd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgdHJ5aW5nIHRvIGNsZWFudXAgZm9yIGdv
b2QgdGhlIGJ1ZmZlcnMgb3BlcmF0aW9uIGZ1bmN0aW9ucy4NCj4gVGhlcmUgaXMgbm8gbmVlZCBv
ZiB1c2luZyBwcmVlbmFibGUsIGFsbCBjYW4gYmUgZG9uZSBpbnRvDQo+IHBvc3RlbmFibGUuIExl
dCdzIGFsc28gdXNlIGxvZ2ljYWwgc2VxdWVuY2Ugb2Ygb3BlcmF0aW9ucyBhcw0KPiBhbHJlYWR5
IGRvbmUgaW4gYWNjZWwgZHJpdmVyLg0KPiBGaW5hbGx5IGFsc28gcmVuYW1lIHRoZSBnb3RvIGxh
YmVsIHVzaW5nIG9wZXJhdGlvbiB0byBwZXJmb3JtIGFuZCBub3QNCj4gd2hlcmUgaXQgZmFpbHMu
DQo+IA0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxl
YW5AYW5hbG9nLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBDaW9jY2EgPGRlbmlzLmNp
b2NjYUBzdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vcHJlc3N1cmUvc3RfcHJlc3N1cmVf
YnVmZmVyLmMgfCAzOCArKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDE3IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL3ByZXNzdXJlL3N0X3ByZXNzdXJlX2J1ZmZlci5jIGIvZHJpdmVycy9paW8vcHJl
c3N1cmUvc3RfcHJlc3N1cmVfYnVmZmVyLmMNCj4gaW5kZXggZjIxYjYzMGFiYWEwLi43N2NiMmQ4
NjJmMTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL3ByZXNzdXJlL3N0X3ByZXNzdXJlX2J1
ZmZlci5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL3ByZXNzdXJlL3N0X3ByZXNzdXJlX2J1ZmZlci5j
DQo+IEBAIC0yOSw1MyArMjksNDkgQEAgaW50IHN0X3ByZXNzX3RyaWdfc2V0X3N0YXRlKHN0cnVj
dCBpaW9fdHJpZ2dlciAqdHJpZywgYm9vbCBzdGF0ZSkNCj4gIAlyZXR1cm4gc3Rfc2Vuc29yc19z
ZXRfZGF0YXJlYWR5X2lycShpbmRpb19kZXYsIHN0YXRlKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGlj
IGludCBzdF9wcmVzc19idWZmZXJfcHJlZW5hYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYp
DQo+IC17DQo+IC0JcmV0dXJuIHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIHRydWUp
Ow0KPiAtfQ0KPiAtDQo+ICBzdGF0aWMgaW50IHN0X3ByZXNzX2J1ZmZlcl9wb3N0ZW5hYmxlKHN0
cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICB7DQo+IC0JaW50IGVycjsNCj4gIAlzdHJ1Y3Qg
c3Rfc2Vuc29yX2RhdGEgKnByZXNzX2RhdGEgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiArCWlu
dCBlcnI7DQo+ICANCj4gIAlwcmVzc19kYXRhLT5idWZmZXJfZGF0YSA9IGttYWxsb2MoaW5kaW9f
ZGV2LT5zY2FuX2J5dGVzLA0KPiAgCQkJCQkgIEdGUF9ETUEgfCBHRlBfS0VSTkVMKTsNCj4gLQlp
ZiAocHJlc3NfZGF0YS0+YnVmZmVyX2RhdGEgPT0gTlVMTCkgew0KPiAtCQllcnIgPSAtRU5PTUVN
Ow0KPiAtCQlnb3RvIGFsbG9jYXRlX21lbW9yeV9lcnJvcjsNCj4gLQl9DQo+ICsJaWYgKCFwcmVz
c19kYXRhLT5idWZmZXJfZGF0YSkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gIAllcnIg
PSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKGluZGlvX2Rldik7DQo+ICAJaWYgKGVy
ciA8IDApDQo+IC0JCWdvdG8gc3RfcHJlc3NfYnVmZmVyX3Bvc3RlbmFibGVfZXJyb3I7DQo+ICsJ
CWdvdG8gc3RfcHJlc3NfZnJlZV9idWZmZXI7DQo+ICANCj4gLQlyZXR1cm4gZXJyOw0KPiArCWVy
ciA9IHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIHRydWUpOw0KPiArCWlmIChlcnIg
PCAwKQ0KPiArCQlnb3RvIHN0X3ByZXNzX2J1ZmZlcl9wcmVkaXNhYmxlOw0KPiArDQo+ICsJcmV0
dXJuIDA7DQo+ICANCj4gLXN0X3ByZXNzX2J1ZmZlcl9wb3N0ZW5hYmxlX2Vycm9yOg0KPiArc3Rf
cHJlc3NfYnVmZmVyX3ByZWRpc2FibGU6DQo+ICsJaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlz
YWJsZShpbmRpb19kZXYpOw0KPiArc3RfcHJlc3NfZnJlZV9idWZmZXI6DQo+ICAJa2ZyZWUocHJl
c3NfZGF0YS0+YnVmZmVyX2RhdGEpOw0KPiAtYWxsb2NhdGVfbWVtb3J5X2Vycm9yOg0KPiAgCXJl
dHVybiBlcnI7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgc3RfcHJlc3NfYnVmZmVyX3ByZWRp
c2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gIHsNCj4gLQlpbnQgZXJyOw0KPiAg
CXN0cnVjdCBzdF9zZW5zb3JfZGF0YSAqcHJlc3NfZGF0YSA9IGlpb19wcml2KGluZGlvX2Rldik7
DQo+IC0NCj4gLQllcnIgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rl
dik7DQo+IC0JaWYgKGVyciA8IDApDQo+IC0JCWdvdG8gc3RfcHJlc3NfYnVmZmVyX3ByZWRpc2Fi
bGVfZXJyb3I7DQo+ICsJaW50IGVyciwgZXJyMjsNCj4gIA0KPiAgCWVyciA9IHN0X3NlbnNvcnNf
c2V0X2VuYWJsZShpbmRpb19kZXYsIGZhbHNlKTsNCj4gIA0KPiAtc3RfcHJlc3NfYnVmZmVyX3By
ZWRpc2FibGVfZXJyb3I6DQo+ICsJZXJyMiA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2Fi
bGUoaW5kaW9fZGV2KTsNCj4gKwlpZiAoIWVycikNCj4gKwkJZXJyID0gZXJyMjsNCj4gKw0KPiAg
CWtmcmVlKHByZXNzX2RhdGEtPmJ1ZmZlcl9kYXRhKTsNCj4gIAlyZXR1cm4gZXJyOw0KPiAgfQ0K
PiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBfb3BzIHN0X3ByZXNz
X2J1ZmZlcl9zZXR1cF9vcHMgPSB7DQo+IC0JLnByZWVuYWJsZSA9ICZzdF9wcmVzc19idWZmZXJf
cHJlZW5hYmxlLA0KPiAgCS5wb3N0ZW5hYmxlID0gJnN0X3ByZXNzX2J1ZmZlcl9wb3N0ZW5hYmxl
LA0KPiAgCS5wcmVkaXNhYmxlID0gJnN0X3ByZXNzX2J1ZmZlcl9wcmVkaXNhYmxlLA0KPiAgfTsN
Cg==
