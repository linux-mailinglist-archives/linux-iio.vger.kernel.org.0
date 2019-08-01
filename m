Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B98EF7D781
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfHAIZi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 04:25:38 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:19486 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbfHAIZh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 04:25:37 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x718NAfK032522;
        Thu, 1 Aug 2019 04:25:33 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u3dkcbpqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR1lMTwTp6ycFXtn1FD5ECoEL2At9rzEvXz6LtN1PSLpCABcYXj+Opmf7SQ/nWgKEpUZACGI9Wuq3Phe9jFgzMdsGVl3B6Qdi3COw4KCZ5RT26KHgHHqHhntDdg+06lmb0pAJ8naWxvz0JIz0cT/q8h6HIr8vePZ4BDRN5smp4awNzHQUUGD+37P8qfpBITNREsC8Utz31BeOOqwNUPvRWH6XxqToDeKbUOU70yPc1H2wCfSbxgMDyMSQXjSyrQepXABrX65a/rQWx4hk6PKgFu5MvD9gKFTxlcTeLMQzzlYEhKfyJsjF6fD/USm2o/D8S2hlf0Xug/LIbDKHGuBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26t7SLHeIrzxz8eU7C7wWxy0taOMzvXRKGuo0GgCqT4=;
 b=MuNlPPQOkwGUc5KmruG1HSceLfrApxBVuPKpyDAqqltUNNdrk9XnEbiezLmFhjkOmymNiUDG4Z8QVOhYECT2Sq6tzHB5cm2IJIdVmKKs2iXMVuDvNoSA6vM5pZcQl839euw+U3hJDF4OGL5u6iWXPD8FPC0A8k82ZRQcGCY4iufIDpIQ1rdCmaEBTfynUNdiS0fam/G6LItDgXdOZsOkgM49XPAJQLjb6w79TEjOenjjCrZNeBj1X6Ou19XLf1wkzLC4LdRkYxXYLpIhdjBW13FKZHi5AdFSws6/yKIo0p5bo3uFCUKIYbfKwsnW28PwWnPE/u2wdkkxYwOuv4m2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26t7SLHeIrzxz8eU7C7wWxy0taOMzvXRKGuo0GgCqT4=;
 b=WKLDmr3uAlmjxOnLRa9rpKNEAs1//INZxTrrZVA9tjR7uZS958WDyoFjVUuuoZJVBj9eJ2Mxtd3QAz4KDbrKL0DY8prQkFsBahokh9i4sNJF9nwy2IFUP7qIraj3gF6hJHjezH129VBUm9/NlBn65gzO74CYvN/3tL3hEOPb4kc=
Received: from BN8PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:94::31)
 by BYAPR03MB3847.namprd03.prod.outlook.com (2603:10b6:a03:6e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14; Thu, 1 Aug
 2019 08:25:31 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN8PR03CA0018.outlook.office365.com
 (2603:10b6:408:94::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.16 via Frontend
 Transport; Thu, 1 Aug 2019 08:25:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Thu, 1 Aug 2019 08:25:31 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x718PU3Z019099
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Aug 2019 01:25:30 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 1 Aug 2019 04:25:30 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio:pressure: do not allocate/de-allocate buffer
 here but link setup_ops to st_sensors_buffer
Thread-Topic: [PATCH 5/5] iio:pressure: do not allocate/de-allocate buffer
 here but link setup_ops to st_sensors_buffer
Thread-Index: AQHVR+pa5UDnJUY6nUuqNQ55tiGlVabmat6A
Date:   Thu, 1 Aug 2019 08:25:29 +0000
Message-ID: <2a5c4a21fa2e2e9f2e2ba635bc4aa691e119b106.camel@analog.com>
References: <20190731215250.16403-1-denis.ciocca@st.com>
         <20190731215250.16403-6-denis.ciocca@st.com>
In-Reply-To: <20190731215250.16403-6-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.109]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <900B5C26BF6DF54D836BD319DCE52E98@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(2501003)(102836004)(70206006)(6246003)(478600001)(2906002)(6116002)(3846002)(86362001)(118296001)(2201001)(316002)(76176011)(8936002)(2616005)(476003)(36756003)(26005)(11346002)(446003)(5660300002)(426003)(70586007)(2486003)(23676004)(126002)(7736002)(7696005)(7636002)(436003)(50466002)(106002)(110136005)(336012)(8676002)(356004)(14454004)(246002)(47776003)(186003)(305945005)(486006)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3847;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5fd6ae3-f4df-43c9-2ae5-08d71659d140
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3847;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3847:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3847605DBE713AA0100232BDF9DE0@BYAPR03MB3847.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7wke1R9/Ct0E742RmiFvuMPH9c4YeWE5M3jpn8RSVEoADqVqlRxlbJJ4tEZbN//EC+5ZylBnLrB7RoK77wCOgZVTEWvBlOL4mvxKJCyk3lzk3/cJeWqKNx4PkA1zMsfPh6CaHtPBTJ3K3jFKLmtb1+rq4Esbov+hF428eiQ+pWKx1tni4mg9+TGs6cp5mtFL9c2cRPX8JTfJDsCGnzGKadEiKPLD2Zye8i07FSoxxx1MFmD1Z7imGeFP60Oou6i2D6XYFYnoAOTHo0/nP5AqbZ+qc8t7s+SIqmO/GnjcxGrJ2QtH/uVtVBLK9ld3bRtP+M54T4MqB+Pw8rMSMW0Oo1ss+GJ6pKkR6j/ejsXnafLv7NJBQvZmmnxMOC5D7GKxWvAGl90b9oYq3fnZ62RyNj6u5M8z2nf4JGCOQWdP/Y4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 08:25:31.1785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fd6ae3-f4df-43c9-2ae5-08d71659d140
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3847
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
L2lpby9wcmVzc3VyZS9zdF9wcmVzc3VyZV9idWZmZXIuYyB8IDE0ICsrKy0tLS0tLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9wcmVzc3VyZS9zdF9wcmVzc3VyZV9idWZmZXIuYyBi
L2RyaXZlcnMvaWlvL3ByZXNzdXJlL3N0X3ByZXNzdXJlX2J1ZmZlci5jDQo+IGluZGV4IDc3Y2Iy
ZDg2MmYxOS4uNDMwNjU0MTk1M2QwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9wcmVzc3Vy
ZS9zdF9wcmVzc3VyZV9idWZmZXIuYw0KPiArKysgYi9kcml2ZXJzL2lpby9wcmVzc3VyZS9zdF9w
cmVzc3VyZV9idWZmZXIuYw0KPiBAQCAtMzEsMTcgKzMxLDExIEBAIGludCBzdF9wcmVzc190cmln
X3NldF9zdGF0ZShzdHJ1Y3QgaWlvX3RyaWdnZXIgKnRyaWcsIGJvb2wgc3RhdGUpDQo+ICANCj4g
IHN0YXRpYyBpbnQgc3RfcHJlc3NfYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldikNCj4gIHsNCj4gLQlzdHJ1Y3Qgc3Rfc2Vuc29yX2RhdGEgKnByZXNzX2RhdGEgPSBp
aW9fcHJpdihpbmRpb19kZXYpOw0KPiAgCWludCBlcnI7DQo+ICANCj4gLQlwcmVzc19kYXRhLT5i
dWZmZXJfZGF0YSA9IGttYWxsb2MoaW5kaW9fZGV2LT5zY2FuX2J5dGVzLA0KPiAtCQkJCQkgIEdG
UF9ETUEgfCBHRlBfS0VSTkVMKTsNCj4gLQlpZiAoIXByZXNzX2RhdGEtPmJ1ZmZlcl9kYXRhKQ0K
PiAtCQlyZXR1cm4gLUVOT01FTTsNCj4gLQ0KPiAgCWVyciA9IGlpb190cmlnZ2VyZWRfYnVmZmVy
X3Bvc3RlbmFibGUoaW5kaW9fZGV2KTsNCj4gIAlpZiAoZXJyIDwgMCkNCj4gLQkJZ290byBzdF9w
cmVzc19mcmVlX2J1ZmZlcjsNCj4gKwkJcmV0dXJuIGVycjsNCj4gIA0KPiAgCWVyciA9IHN0X3Nl
bnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIHRydWUpOw0KPiAgCWlmIChlcnIgPCAwKQ0KPiBA
QCAtNTEsMTQgKzQ1LDExIEBAIHN0YXRpYyBpbnQgc3RfcHJlc3NfYnVmZmVyX3Bvc3RlbmFibGUo
c3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gIA0KPiAgc3RfcHJlc3NfYnVmZmVyX3ByZWRp
c2FibGU6DQo+ICAJaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0K
PiAtc3RfcHJlc3NfZnJlZV9idWZmZXI6DQo+IC0Ja2ZyZWUocHJlc3NfZGF0YS0+YnVmZmVyX2Rh
dGEpOw0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgc3RfcHJlc3Nf
YnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gIHsNCj4gLQlz
dHJ1Y3Qgc3Rfc2Vuc29yX2RhdGEgKnByZXNzX2RhdGEgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0K
PiAgCWludCBlcnIsIGVycjI7DQo+ICANCj4gIAllcnIgPSBzdF9zZW5zb3JzX3NldF9lbmFibGUo
aW5kaW9fZGV2LCBmYWxzZSk7DQo+IEBAIC02NywxMyArNTgsMTQgQEAgc3RhdGljIGludCBzdF9w
cmVzc19idWZmZXJfcHJlZGlzYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiAgCWlm
ICghZXJyKQ0KPiAgCQllcnIgPSBlcnIyOw0KPiAgDQo+IC0Ja2ZyZWUocHJlc3NfZGF0YS0+YnVm
ZmVyX2RhdGEpOw0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgaWlvX2J1ZmZlcl9zZXR1cF9vcHMgc3RfcHJlc3NfYnVmZmVyX3NldHVwX29wcyA9IHsN
Cj4gKwkucHJlZW5hYmxlID0gJnN0X3NlbnNvcnNfYnVmZmVyX3ByZWVuYWJsZSwNCj4gIAkucG9z
dGVuYWJsZSA9ICZzdF9wcmVzc19idWZmZXJfcG9zdGVuYWJsZSwNCj4gIAkucHJlZGlzYWJsZSA9
ICZzdF9wcmVzc19idWZmZXJfcHJlZGlzYWJsZSwNCj4gKwkucG9zdGRpc2FibGUgPSAmc3Rfc2Vu
c29yc19idWZmZXJfcG9zdGRpc2FibGUsDQo+ICB9Ow0KPiAgDQo+ICBpbnQgc3RfcHJlc3NfYWxs
b2NhdGVfcmluZyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0K
