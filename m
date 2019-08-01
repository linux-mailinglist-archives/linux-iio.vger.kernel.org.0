Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B98197D76D
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 10:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfHAIWW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 04:22:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34122 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfHAIWV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 04:22:21 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x718JRZN006918;
        Thu, 1 Aug 2019 04:22:10 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2057.outbound.protection.outlook.com [104.47.50.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u3hrnhewe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:22:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELHRZi9GWFkIHzXmIPDsrHMUmMstqwtN/fvqLMSryKjq5r6DKbhyMQd0quc794b2+kQmNzSKniSprJx2bjfoPdhUYI1p57ARPxXoeig3+9UQdBjRTfvrTOMO/3T0Z2sum/ZVDoo4W3PGV0pJVOXfC+5/tQA1iiWm3kr0/1QkcXmdLG3fgNfb5UhV9adcuQ678wFzgG8VczK2pSvAj/NufEjCU9fPJQHxpndIgC7fJqS+2NHS+2x0bnsq7m0aSXVlkNtZrKCReMIbKuDIFiHXIU74T4/Z2KwsTy2s48PXJHX4UJcYvzlODGP6E4BnOtCwm6FVL+UsngS6GPJe8qGyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=froOxP4QQoOP73PKlCwG2x4zKPNE2umA90fiHKfDSjE=;
 b=PbCdMSdxgZOEfALAwns14boi8LvXQQKi/X6P/zNONOuf8UV8u5tPF1/CLH1mxe4QswIVCCMa6WDmOO4C/ypLEqTori/9C8D86FKK8gpYa2pWSZSa0CJkDeBWu00w7rywvbPGDVaWBtAP+/lI6B3QjoaIHJQ0aWS3Gf8RiIXVrspQiQgRbt6x9FPNjcz0jNmrDzsvIc0K+E70n/0MWKhLeD9cLly0rcwxgFKSi3BeQ/1QYRX1uyeCf1CsCpJEPZMW16ujLt+0fTI/Pu1cCjBUVXWSLDznWIe7Xv38MA/bsoz76V8SHx3aj1O6bGAyDzXGknDtL1ekxg0ivaZX1LQO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=froOxP4QQoOP73PKlCwG2x4zKPNE2umA90fiHKfDSjE=;
 b=QzUZaRDvMSGddibbhoFVhXZ+2kGP0TfK5fyLFinXW33xqOOD8yJytMh2mekbMwMipTZZb+oO5IbgJ6lpTs9wAxOdBafQcCNjUZYweHi6VLneSKnefCL6NkRtO+GKNJP24VZ+N5luaaxtYv032n7ue3u0RFNb5iSQr/R6Xo1p8iI=
Received: from BN3PR03CA0095.namprd03.prod.outlook.com (2603:10b6:400:4::13)
 by BN6PR03MB2867.namprd03.prod.outlook.com (2603:10b6:404:10f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14; Thu, 1 Aug
 2019 08:22:08 +0000
Received: from BL2NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BN3PR03CA0095.outlook.office365.com
 (2603:10b6:400:4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.12 via Frontend
 Transport; Thu, 1 Aug 2019 08:22:08 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT063.mail.protection.outlook.com (10.152.77.121) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Thu, 1 Aug 2019 08:22:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x718M7jM018241
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Aug 2019 01:22:07 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Thu, 1 Aug 2019 04:22:07 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio:magn: preenable/postenable/predisable fixup
 for ST magn buffer
Thread-Topic: [PATCH v2 3/4] iio:magn: preenable/postenable/predisable fixup
 for ST magn buffer
Thread-Index: AQHVR+nS5Da3Zxa+TUOu80WcHSAPw6bmae0A
Date:   Thu, 1 Aug 2019 08:22:07 +0000
Message-ID: <7afb7f9115903663a4da41add9b4d8419ef981ec.camel@analog.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
         <20190731214900.15380-4-denis.ciocca@st.com>
In-Reply-To: <20190731214900.15380-4-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.109]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A9223B97F85994C9E2B43C545D04993@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(199004)(189003)(118296001)(5660300002)(50466002)(2501003)(229853002)(36756003)(2486003)(7696005)(23676004)(106002)(76176011)(478600001)(126002)(486006)(246002)(8676002)(70586007)(8936002)(14454004)(356004)(316002)(47776003)(305945005)(86362001)(2201001)(186003)(11346002)(446003)(476003)(2616005)(2906002)(6116002)(26005)(3846002)(7736002)(6246003)(102836004)(7636002)(436003)(426003)(336012)(110136005)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2867;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8d3b2a0-cda5-4770-5151-08d71659580e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR03MB2867;
X-MS-TrafficTypeDiagnostic: BN6PR03MB2867:
X-Microsoft-Antispam-PRVS: <BN6PR03MB28674991C4E7055F2F1B2EA9F9DE0@BN6PR03MB2867.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: NphYMvvr7KaDG6xuwHzl+x1XxeNREIS0Fx7rSoxJM+4/CTe2/Rl5t84tT1JPmSr+uTOoVdyPQoXER765rfGXcdr7/XtSKaQpznMr0kEoJnFpeeTyq0KGsJYglPVVzz+Ao3oz7/9DH0m1Ur7lBwiGyJZdGPcqdaqeawfxLLBub1+sVKst5bj8JCkGBKKWVyi6C5QQJegoZOdSW+H7+R/skIaxzaL8h8hGAV3/ODCi2/WJJRS1CItZ71S1acq008UTx+vjCmUA8QQUrOwK1LAxy1rBK8DaQ9DH590yFiD8nuUxTIWJph77e+jpYkPpocbfAGOcvsWcWaKKKz1oaqWBYcJ3os/Lehl4sJvCMMXPdvu7zAoMkx7BHAmsyftSwvRLmHrf5BITH0kH51kssZ9BRXxqJThqBM2GVJfsJ6YEw2o=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 08:22:08.0486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d3b2a0-cda5-4770-5151-08d71659580e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2867
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

T24gV2VkLCAyMDE5LTA3LTMxIGF0IDE0OjQ4IC0wNzAwLCBEZW5pcyBDaW9jY2Egd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgdHJ5aW5nIHRvIGNsZWFudXAgZm9yIGdv
b2QgdGhlIGJ1ZmZlcnMgb3BlcmF0aW9uIGZ1bmN0aW9ucy4NCj4gTGV0J3MgcmVuYW1lIHRoZSBn
b3RvIGxhYmVsIHVzaW5nIG9wZXJhdGlvbiB0byBwZXJmb3JtIGFuZCBub3QNCj4gd2hlcmUgaXQg
ZmFpbHMuDQo+IA0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUu
YXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBDaW9jY2EgPGRl
bmlzLmNpb2NjYUBzdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vbWFnbmV0b21ldGVyL3N0
X21hZ25fYnVmZmVyLmMgfCAzMCArKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9zdF9tYWduX2J1ZmZlci5jIGIvZHJpdmVycy9p
aW8vbWFnbmV0b21ldGVyL3N0X21hZ25fYnVmZmVyLmMNCj4gaW5kZXggOWRiYTkzNTM5YTk5Li42
NThkNjI3ZGFkOGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9zdF9t
YWduX2J1ZmZlci5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9zdF9tYWduX2J1
ZmZlci5jDQo+IEBAIC0zMSw0MCArMzEsNDIgQEAgaW50IHN0X21hZ25fdHJpZ19zZXRfc3RhdGUo
c3RydWN0IGlpb190cmlnZ2VyICp0cmlnLCBib29sIHN0YXRlKQ0KPiAgDQo+ICBzdGF0aWMgaW50
IHN0X21hZ25fYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4g
IHsNCj4gLQlpbnQgZXJyOw0KPiAgCXN0cnVjdCBzdF9zZW5zb3JfZGF0YSAqbWRhdGEgPSBpaW9f
cHJpdihpbmRpb19kZXYpOw0KPiArCWludCBlcnI7DQo+ICANCj4gIAltZGF0YS0+YnVmZmVyX2Rh
dGEgPSBrbWFsbG9jKGluZGlvX2Rldi0+c2Nhbl9ieXRlcywNCj4gIAkJCQkgICAgIEdGUF9ETUEg
fCBHRlBfS0VSTkVMKTsNCj4gLQlpZiAobWRhdGEtPmJ1ZmZlcl9kYXRhID09IE5VTEwpIHsNCj4g
LQkJZXJyID0gLUVOT01FTTsNCj4gLQkJZ290byBhbGxvY2F0ZV9tZW1vcnlfZXJyb3I7DQo+IC0J
fQ0KPiArCWlmICghbWRhdGEtPmJ1ZmZlcl9kYXRhKQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4g
IA0KPiAgCWVyciA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3Bvc3RlbmFibGUoaW5kaW9fZGV2KTsN
Cj4gIAlpZiAoZXJyIDwgMCkNCj4gLQkJZ290byBzdF9tYWduX2J1ZmZlcl9wb3N0ZW5hYmxlX2Vy
cm9yOw0KPiArCQlnb3RvIHN0X21hZ25fZnJlZV9idWZmZXI7DQo+ICsNCj4gKwllcnIgPSBzdF9z
ZW5zb3JzX3NldF9lbmFibGUoaW5kaW9fZGV2LCB0cnVlKTsNCj4gKwlpZiAoZXJyIDwgMCkNCj4g
KwkJZ290byBzdF9tYWduX2J1ZmZlcl9wcmVkaXNhYmxlOw0KPiAgDQo+IC0JcmV0dXJuIHN0X3Nl
bnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIHRydWUpOw0KPiArCXJldHVybiAwOw0KPiAgDQo+
IC1zdF9tYWduX2J1ZmZlcl9wb3N0ZW5hYmxlX2Vycm9yOg0KPiArc3RfbWFnbl9idWZmZXJfcHJl
ZGlzYWJsZToNCj4gKwlpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7
DQo+ICtzdF9tYWduX2ZyZWVfYnVmZmVyOg0KPiAgCWtmcmVlKG1kYXRhLT5idWZmZXJfZGF0YSk7
DQo+IC1hbGxvY2F0ZV9tZW1vcnlfZXJyb3I6DQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gIA0K
PiAgc3RhdGljIGludCBzdF9tYWduX2J1ZmZlcl9wcmVkaXNhYmxlKHN0cnVjdCBpaW9fZGV2ICpp
bmRpb19kZXYpDQo+ICB7DQo+IC0JaW50IGVycjsNCj4gIAlzdHJ1Y3Qgc3Rfc2Vuc29yX2RhdGEg
Km1kYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gKwlpbnQgZXJyLCBlcnIyOw0KPiAgDQo+
ICAJZXJyID0gc3Rfc2Vuc29yc19zZXRfZW5hYmxlKGluZGlvX2RldiwgZmFsc2UpOw0KPiAtCWlm
IChlcnIgPCAwKQ0KPiAtCQlnb3RvIHN0X21hZ25fYnVmZmVyX3ByZWRpc2FibGVfZXJyb3I7DQo+
ICANCj4gLQllcnIgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7
DQo+ICsJZXJyMiA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUoaW5kaW9fZGV2KTsN
Cj4gKwlpZiAoIWVycikNCj4gKwkJZXJyID0gZXJyMjsNCj4gIA0KPiAtc3RfbWFnbl9idWZmZXJf
cHJlZGlzYWJsZV9lcnJvcjoNCj4gIAlrZnJlZShtZGF0YS0+YnVmZmVyX2RhdGEpOw0KPiAgCXJl
dHVybiBlcnI7DQo+ICB9DQo=
