Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456667A36A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 10:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbfG3Iyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jul 2019 04:54:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2586 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731108AbfG3Iyq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2019 04:54:46 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U8sC32006024;
        Tue, 30 Jul 2019 04:54:38 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u1nfbvtu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 04:54:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2jlmp/atUZPTOtX7lBqp4kNTEs14BiaJe7EOVIGVTiTj4lElQ8a+T6iECsMvLgyHNJ2gJP4m6nhay0l7P4RJrlBGGPPR6QfOb6b3KcZjy7ng6yB1f9fddpwj1iAESILOPfZ+6yzAiXZzBGVSz09cjnL2taK1C4e6PZcoGPrJmOxb21w+MQ16Kd1e6/ckIFOrFz2BgX9C53uuBjbKW2r0xICSpENIdonJvLVdCFvqM0XOT83NIkaoldgsASGpKViliTcufSpFjCpJ/ngOFdUVS5JPdXhCKwSWRvEuP3l2lr/xV+vpZVarE6h5wTx0/aOlscvK9LJ0OmY6rnUh0VaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOkqesCmNgVY26gTLQqYZ8hQloZQ/kMh8qqcDkLm3Do=;
 b=DNmGIhUtgq5sWyuY3PyFuoRtvad2TdZkUGRi0zva7shEPOCYor3KGNX2c+TOn+UWRsce6YoaFao2SzC/WpxDxfgjYNRfkKESSnpsheSyAsojAk6L9X7fSHfxWW+LD7P2glH9DC9zqbuGT2/qI7hU/vsAlBtXCgiDcqcfRIvdi+AduWus+ytjKgNYD4ilj/mvOHmCDgrq2OnwRsx9nQuO3K74u23ZkXJ+XiUdWuMs8tS8qhhyMuknWyzIfr4qTh9PcQps7gPO0bTnnpeynfQl9F9BO+JcFFfDwcLPZq1C0cG0a8KPxrvCZxboUOiuB5WE6tYAO0ETeORxr7es9+rgWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOkqesCmNgVY26gTLQqYZ8hQloZQ/kMh8qqcDkLm3Do=;
 b=8agPhzeesLpbRQe9JPNZnD2C3MucD3vx731UTLybcHFuhCDm2PHaiu17WweMPf3vvRHsGJUsX0CiOSeTkIC3cHj4oxgtyhywboMLdciXoEDs3NFWZHlQHYQ9GQIYuLF6nJmCxmp8ty1rwlTZdubhGgyvTrmJWf9u5zT0GC3ct1Q=
Received: from DM6PR03CA0027.namprd03.prod.outlook.com (2603:10b6:5:40::40) by
 BN8PR03MB4803.namprd03.prod.outlook.com (2603:10b6:408:9f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 08:54:36 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by DM6PR03CA0027.outlook.office365.com
 (2603:10b6:5:40::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.15 via Frontend
 Transport; Tue, 30 Jul 2019 08:54:36 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Tue, 30 Jul 2019 08:54:36 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6U8sZZs022465
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 30 Jul 2019 01:54:35 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Tue, 30 Jul 2019 04:54:35 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio:magn: preenable/postenable/predisable fixup for
 ST magn buffer
Thread-Topic: [PATCH 3/4] iio:magn: preenable/postenable/predisable fixup
 for ST magn buffer
Thread-Index: AQHVRmtM1fnjuWUHtUWCm35MK1BOwabjUVMA
Date:   Tue, 30 Jul 2019 08:54:35 +0000
Message-ID: <914540f8bad2184f637175ce9593fce8b1379496.camel@analog.com>
References: <20190730000305.30958-1-denis.ciocca@st.com>
         <20190730000305.30958-4-denis.ciocca@st.com>
In-Reply-To: <20190730000305.30958-4-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.107]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <88B9D4D216470B468CC73EEA17A801F6@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(199004)(189003)(126002)(76176011)(2906002)(70586007)(70206006)(478600001)(356004)(486006)(7736002)(446003)(86362001)(305945005)(11346002)(426003)(436003)(2616005)(47776003)(5660300002)(476003)(7636002)(336012)(14454004)(8676002)(246002)(110136005)(2486003)(6246003)(23676004)(118296001)(186003)(8936002)(36756003)(2501003)(106002)(3846002)(229853002)(26005)(102836004)(2201001)(50466002)(316002)(7696005)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB4803;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c30686b-fff7-492b-49c0-08d714cb8c50
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BN8PR03MB4803;
X-MS-TrafficTypeDiagnostic: BN8PR03MB4803:
X-Microsoft-Antispam-PRVS: <BN8PR03MB48035F9B68F03CBBADA5A49AF9DC0@BN8PR03MB4803.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0114FF88F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lb5W9cJCgjwwwIruVYHeOkNVprB5Z9rS29ZMFRBdi5XsV6XR0HwkroGBgl/PWlGb1bp1/hkqe3MmJ8E6eesaOPe5QzVdAqPPLH9qCc7gNg9yIIS1zaLBuuSE9ddLvQ5c001IDqDJuz5Z4JhyXZV/QN+1LvVKsUsaYJozXKxNLgulNFq6Qp1A4CvBfmsHULqaX5qiEO5dcyl4betf3bcLzZUxYWLksL2RoDGyHy00P7pQIdak7K8oYsZuVhjYsZa9POiNY6dku5mwnkR77BIs2lNO12541R5069uYK9zdVJfbb8zxeTbCAG3N8aXOZuDYHfcZ3TB/1ZgrxMz7c2ZjDzP8SE80PO7BDxHtPSf4yf2IA0kSfHGt4wCWJwRFdAMZdvtsUYRNe2kJvJET1RkG8JBngkSyiGURXctN/7bALsc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2019 08:54:36.0262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c30686b-fff7-492b-49c0-08d714cb8c50
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4803
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300096
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA3LTI5IGF0IDE3OjAzIC0wNzAwLCBEZW5pcyBDaW9jY2Egd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgdHJ5aW5nIHRvIGNsZWFudXAgZm9yIGdv
b2QgdGhlIGJ1ZmZlcnMgb3BlcmF0aW9uIGZ1bmN0aW9ucy4NCj4gTGV0J3MgcmVuYW1lIHRoZSBn
b3RvIGxhYmVsIHVzaW5nIG9wZXJhdGlvbiB0byBwZXJmb3JtIGFuZCBub3QNCj4gd2hlcmUgaXQg
ZmFpbHMuDQoNCjEgbWlub3IgY29tbWVudCBpbmxpbmUNCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRy
dSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IERlbmlzIENpb2NjYSA8ZGVuaXMuY2lvY2NhQHN0LmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2lpby9tYWduZXRvbWV0ZXIvc3RfbWFnbl9idWZmZXIuYyB8IDIyICsrKysrKysrKy0t
LS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL21hZ25ldG9tZXRlci9zdF9t
YWduX2J1ZmZlci5jIGIvZHJpdmVycy9paW8vbWFnbmV0b21ldGVyL3N0X21hZ25fYnVmZmVyLmMN
Cj4gaW5kZXggOWRiYTkzNTM5YTk5Li44ZDA2NjQzYTA0MmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaWlvL21hZ25ldG9tZXRlci9zdF9tYWduX2J1ZmZlci5jDQo+ICsrKyBiL2RyaXZlcnMvaWlv
L21hZ25ldG9tZXRlci9zdF9tYWduX2J1ZmZlci5jDQo+IEBAIC0zMSw0MCArMzEsMzYgQEAgaW50
IHN0X21hZ25fdHJpZ19zZXRfc3RhdGUoc3RydWN0IGlpb190cmlnZ2VyICp0cmlnLCBib29sIHN0
YXRlKQ0KPiAgDQo+ICBzdGF0aWMgaW50IHN0X21hZ25fYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0
IGlpb19kZXYgKmluZGlvX2RldikNCj4gIHsNCj4gLQlpbnQgZXJyOw0KPiAgCXN0cnVjdCBzdF9z
ZW5zb3JfZGF0YSAqbWRhdGEgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiArCWludCBlcnI7DQoN
ClRoaXMgbG9va3MgbW9yZSBsaWtlIHN0eWxlLWNoYW5nZTsgYnV0IG5vdCBhIHByb2JsZW0uDQoN
Cj4gIA0KPiAgCW1kYXRhLT5idWZmZXJfZGF0YSA9IGttYWxsb2MoaW5kaW9fZGV2LT5zY2FuX2J5
dGVzLA0KPiAgCQkJCSAgICAgR0ZQX0RNQSB8IEdGUF9LRVJORUwpOw0KPiAtCWlmIChtZGF0YS0+
YnVmZmVyX2RhdGEgPT0gTlVMTCkgew0KPiAtCQllcnIgPSAtRU5PTUVNOw0KPiAtCQlnb3RvIGFs
bG9jYXRlX21lbW9yeV9lcnJvcjsNCj4gLQl9DQo+ICsJaWYgKCFtZGF0YS0+YnVmZmVyX2RhdGEp
DQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiAgDQo+ICAJZXJyID0gaWlvX3RyaWdnZXJlZF9idWZm
ZXJfcG9zdGVuYWJsZShpbmRpb19kZXYpOw0KPiAgCWlmIChlcnIgPCAwKQ0KPiAtCQlnb3RvIHN0
X21hZ25fYnVmZmVyX3Bvc3RlbmFibGVfZXJyb3I7DQo+ICsJCWdvdG8gc3RfbWFnbl9mcmVlX2J1
ZmZlcjsNCj4gIA0KPiAgCXJldHVybiBzdF9zZW5zb3JzX3NldF9lbmFibGUoaW5kaW9fZGV2LCB0
cnVlKTsNCj4gIA0KPiAtc3RfbWFnbl9idWZmZXJfcG9zdGVuYWJsZV9lcnJvcjoNCj4gK3N0X21h
Z25fZnJlZV9idWZmZXI6DQo+ICAJa2ZyZWUobWRhdGEtPmJ1ZmZlcl9kYXRhKTsNCj4gLWFsbG9j
YXRlX21lbW9yeV9lcnJvcjoNCj4gIAlyZXR1cm4gZXJyOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMg
aW50IHN0X21hZ25fYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikN
Cj4gIHsNCj4gLQlpbnQgZXJyOw0KPiAgCXN0cnVjdCBzdF9zZW5zb3JfZGF0YSAqbWRhdGEgPSBp
aW9fcHJpdihpbmRpb19kZXYpOw0KPiArCWludCBlcnIsIGVycjI7DQo+ICANCj4gIAllcnIgPSBz
dF9zZW5zb3JzX3NldF9lbmFibGUoaW5kaW9fZGV2LCBmYWxzZSk7DQo+IC0JaWYgKGVyciA8IDAp
DQo+IC0JCWdvdG8gc3RfbWFnbl9idWZmZXJfcHJlZGlzYWJsZV9lcnJvcjsNCj4gIA0KPiAtCWVy
ciA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUoaW5kaW9fZGV2KTsNCj4gKwllcnIy
ID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiArCWlmICgh
ZXJyKQ0KPiArCQllcnIgPSBlcnIyOw0KPiAgDQo+IC1zdF9tYWduX2J1ZmZlcl9wcmVkaXNhYmxl
X2Vycm9yOg0KPiAgCWtmcmVlKG1kYXRhLT5idWZmZXJfZGF0YSk7DQo+ICAJcmV0dXJuIGVycjsN
Cj4gIH0NCg==
