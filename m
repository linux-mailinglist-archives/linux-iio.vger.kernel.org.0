Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E37D76C
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 10:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfHAIWV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 04:22:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:33298 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfHAIWU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 04:22:20 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x718M0kp007148;
        Thu, 1 Aug 2019 04:22:10 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2050.outbound.protection.outlook.com [104.47.41.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u2q4nxf35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:22:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7pV+sPEmushEcCn6mQ/5T5vdmUyIssAbi/YudYS6mjhDraK3EIBxqg4OWmJPRJ4TpoEMwxntDi7t4iJwavjsaJdDJPN92u5GegIfeFy1YLfAfvk+fGcXIFA5BXTjDchAAhgBLetgqu66nLxsSeqEDbbGf9WD2DJEnKVU+IKhKYbaMgICtVsbOcp56ANMijjNh8Bk6EDvgK6xqucGxZe/ORnqGE4UEQKni7381/jGEzfGwL+h+uh5cjn0WN8rDmJQgnRXvEY2i1fGaL9q/pcV0DD+xeW39yI3hcmyrrKsF+5heuV57QeNfHBkueM878YheGONqyd61P367ol2SqO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgjKDyv27qba77GwhvyCXxH1/IVITHMW6VW9dtlmJKM=;
 b=Roxgw6GvxBECmziK+LCUCI2DMKGMPaeFxoknXj/t5mroaEOLXAOb95zVxDc/bGr5vLqOqaLmJxQt/ki/KMJ8TmPRwc1bXamEkrh+cuLj8O7nqB4C1XdHuBALGs7Nng8Bs94B/Zqm9szcTNKN6cETWrrc0UjoeZNMnFBvHGyZN5CXMjSYbc2LJbv0QY37bV5QKK5hdqau+p2rAv8t+cwmognDW8AYGVU8EGdJxsQEjJZN8y+r6GzBsMienmaW2SpFm/it/GWPdlZ4C8zgy1Q41GpDGiuC/VXrYmukikl0lE/Sr24gMNgP3Q7jKu5xyvcIlvu6ZbWzfWliCE/CGwhzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgjKDyv27qba77GwhvyCXxH1/IVITHMW6VW9dtlmJKM=;
 b=92OOw0zZAZeuiTw8uk37ue0poysYyRTZxYb/0HQ+B6Mf1xSEm1z0WxogNClWLFAgdlN51FyRIxrSSJ05BKNYW6vUWvS6FVmjJ+x+YGBdy3EjnziemzLV6chBzeFgIueHlgtIzLlnlohq+96NB81Nmqd606wE5SWvnxDdHUDfzBI=
Received: from CY4PR03CA0081.namprd03.prod.outlook.com (2603:10b6:910:4d::22)
 by DM2PR0301MB0912.namprd03.prod.outlook.com (2a01:111:e400:501d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.13; Thu, 1 Aug
 2019 08:22:02 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR03CA0081.outlook.office365.com
 (2603:10b6:910:4d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10 via Frontend
 Transport; Thu, 1 Aug 2019 08:22:02 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Thu, 1 Aug 2019 08:22:02 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x718M1gU018219
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Aug 2019 01:22:01 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 1 Aug 2019 04:22:01 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iio:gyro: preenable/postenable/predisable fixup
 for ST gyro buffer
Thread-Topic: [PATCH v2 2/4] iio:gyro: preenable/postenable/predisable fixup
 for ST gyro buffer
Thread-Index: AQHVR+nTcdac4W3fBUSpVFLuapNP5abmaeYA
Date:   Thu, 1 Aug 2019 08:22:00 +0000
Message-ID: <f1d17225c26696b6f311e5b412fe3ebdac124b03.camel@analog.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
         <20190731214900.15380-3-denis.ciocca@st.com>
In-Reply-To: <20190731214900.15380-3-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.109]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8062533D0061F749AB492F5C2DBF1AD2@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(189003)(199004)(106002)(8676002)(118296001)(2906002)(246002)(2501003)(316002)(14454004)(8936002)(70586007)(70206006)(3846002)(26005)(356004)(50466002)(47776003)(6116002)(110136005)(86362001)(6246003)(2201001)(229853002)(186003)(478600001)(36756003)(76176011)(102836004)(336012)(476003)(126002)(486006)(5660300002)(446003)(436003)(426003)(11346002)(7736002)(305945005)(7696005)(2616005)(7636002)(23676004)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0301MB0912;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a30040e-f49f-4015-4f65-08d71659547b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DM2PR0301MB0912;
X-MS-TrafficTypeDiagnostic: DM2PR0301MB0912:
X-Microsoft-Antispam-PRVS: <DM2PR0301MB091254E11C7FE557BA54BB98F9DE0@DM2PR0301MB0912.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ynybpHaobdAy4lqc6Yt8hpfmSZC7+oCiQTmzYcXIqBLLzpFqBB0A4CLBTDbwcFIHolXTrgD53qSKKGWJicSjxveftGikcNAglJm/xQGGxkX9yxD64zaeCQ1vf7RM0bIXBH3df3yTmnwX7Sh6SkJuREa6rZnEaf8H1Tg3VdBpsuonTVgjE41pAC0AsCDSN/yBDO8gBoWbKRmcxlBBkXOXPSB+kVivNwyqos08GAOdm+EQzdguhK+HvZ+VjnZ98TD4xfGoxvJHSyGuRtZyjZAfW3o5/AupXiOCuPA9fXrVQBLK/e/GX02rxpFdQZlsn4mFU2SGdX+UX86bUl+hQlrv+ZqcR15t13nxv3is//F0EiGZPV9modLcSG/jo0xKRmpZBmeEIh0y3gBrpLVyOfTft5lwj3CyBfNxAoSPaPxQEgQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 08:22:02.0423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a30040e-f49f-4015-4f65-08d71659547b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0301MB0912
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
b2QgdGhlIGJ1ZmZlcnMgb3BlcmF0aW9uIGZ1bmN0aW9ucy4NCj4gVGhlcmUgaXMgbm8gbmVlZCBv
ZiB1c2luZyBwcmVlbmFibGUsIGFsbCBjYW4gYmUgZG9uZSBpbnRvDQo+IHBvc3RlbmFibGUuIExl
dCdzIGFsc28gdXNlIGxvZ2ljYWwgc2VxdWVuY2Ugb2Ygb3BlcmF0aW9ucyBhcw0KPiBhbHJlYWR5
IGRvbmUgaW4gYWNjZWwgZHJpdmVyLg0KPiBGaW5hbGx5IGFsc28gcmVuYW1lIHRoZSBnb3RvIGxh
YmVsIHVzaW5nIG9wZXJhdGlvbiB0byBwZXJmb3JtIGFuZCBub3QNCj4gd2hlcmUgaXQgZmFpbHMu
DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBh
bmFsb2cuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBDaW9jY2EgPGRlbmlzLmNp
b2NjYUBzdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vZ3lyby9zdF9neXJvX2J1ZmZlci5j
IHwgNDkgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2d5cm8vc3RfZ3lyb19idWZmZXIuYyBiL2RyaXZlcnMvaWlvL2d5cm8vc3RfZ3ly
b19idWZmZXIuYw0KPiBpbmRleCAyMTM2MDY4MWQ0ZGQuLmM2ZGRmZWNjMWZjMyAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9paW8vZ3lyby9zdF9neXJvX2J1ZmZlci5jDQo+ICsrKyBiL2RyaXZlcnMv
aWlvL2d5cm8vc3RfZ3lyb19idWZmZXIuYw0KPiBAQCAtMjksNjIgKzI5LDYxIEBAIGludCBzdF9n
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
aWYgKCFnZGF0YS0+YnVmZmVyX2RhdGEpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJ
ZXJyID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZShpbmRpb19kZXYpOw0KPiArCWlm
IChlcnIgPCAwKQ0KPiArCQlnb3RvIHN0X2d5cm9fZnJlZV9idWZmZXI7DQo+ICANCj4gIAllcnIg
PSBzdF9zZW5zb3JzX3NldF9heGlzX2VuYWJsZShpbmRpb19kZXYsDQo+IC0JCQkJCSh1OClpbmRp
b19kZXYtPmFjdGl2ZV9zY2FuX21hc2tbMF0pOw0KPiArCQkJCQkgKHU4KWluZGlvX2Rldi0+YWN0
aXZlX3NjYW5fbWFza1swXSk7DQo+ICAJaWYgKGVyciA8IDApDQo+IC0JCWdvdG8gc3RfZ3lyb19i
dWZmZXJfcG9zdGVuYWJsZV9lcnJvcjsNCj4gKwkJZ290byBzdF9neXJvX2J1ZmZlcl9wcmVkaXNh
YmxlOw0KPiAgDQo+IC0JZXJyID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZShpbmRp
b19kZXYpOw0KPiArCWVyciA9IHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIHRydWUp
Ow0KPiAgCWlmIChlcnIgPCAwKQ0KPiAtCQlnb3RvIHN0X2d5cm9fYnVmZmVyX3Bvc3RlbmFibGVf
ZXJyb3I7DQo+ICsJCWdvdG8gc3RfZ3lyb19idWZmZXJfZW5hYmxlX2FsbF9heGlzOw0KPiAgDQo+
IC0JcmV0dXJuIGVycjsNCj4gKwlyZXR1cm4gMDsNCj4gIA0KPiAtc3RfZ3lyb19idWZmZXJfcG9z
dGVuYWJsZV9lcnJvcjoNCj4gK3N0X2d5cm9fYnVmZmVyX2VuYWJsZV9hbGxfYXhpczoNCj4gKwlz
dF9zZW5zb3JzX3NldF9heGlzX2VuYWJsZShpbmRpb19kZXYsIFNUX1NFTlNPUlNfRU5BQkxFX0FM
TF9BWElTKTsNCj4gK3N0X2d5cm9fYnVmZmVyX3ByZWRpc2FibGU6DQo+ICsJaWlvX3RyaWdnZXJl
ZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiArc3RfZ3lyb19mcmVlX2J1ZmZlcjoN
Cj4gIAlrZnJlZShnZGF0YS0+YnVmZmVyX2RhdGEpOw0KPiAtYWxsb2NhdGVfbWVtb3J5X2Vycm9y
Og0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgc3RfZ3lyb19idWZm
ZXJfcHJlZGlzYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiAgew0KPiAtCWludCBl
cnI7DQo+ICsJaW50IGVyciwgZXJyMjsNCj4gIAlzdHJ1Y3Qgc3Rfc2Vuc29yX2RhdGEgKmdkYXRh
ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gIA0KPiAtCWVyciA9IGlpb190cmlnZ2VyZWRfYnVm
ZmVyX3ByZWRpc2FibGUoaW5kaW9fZGV2KTsNCj4gKwllcnIgPSBzdF9zZW5zb3JzX3NldF9lbmFi
bGUoaW5kaW9fZGV2LCBmYWxzZSk7DQo+ICAJaWYgKGVyciA8IDApDQo+IC0JCWdvdG8gc3RfZ3ly
b19idWZmZXJfcHJlZGlzYWJsZV9lcnJvcjsNCj4gKwkJZ290byBzdF9neXJvX2J1ZmZlcl9wcmVk
aXNhYmxlOw0KPiAgDQo+ICAJZXJyID0gc3Rfc2Vuc29yc19zZXRfYXhpc19lbmFibGUoaW5kaW9f
ZGV2LCBTVF9TRU5TT1JTX0VOQUJMRV9BTExfQVhJUyk7DQo+IC0JaWYgKGVyciA8IDApDQo+IC0J
CWdvdG8gc3RfZ3lyb19idWZmZXJfcHJlZGlzYWJsZV9lcnJvcjsNCj4gIA0KPiAtCWVyciA9IHN0
X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIGZhbHNlKTsNCj4gK3N0X2d5cm9fYnVmZmVy
X3ByZWRpc2FibGU6DQo+ICsJZXJyMiA9IGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRpc2FibGUo
aW5kaW9fZGV2KTsNCj4gKwlpZiAoIWVycikNCj4gKwkJZXJyID0gZXJyMjsNCj4gIA0KPiAtc3Rf
Z3lyb19idWZmZXJfcHJlZGlzYWJsZV9lcnJvcjoNCj4gIAlrZnJlZShnZGF0YS0+YnVmZmVyX2Rh
dGEpOw0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
aWlvX2J1ZmZlcl9zZXR1cF9vcHMgc3RfZ3lyb19idWZmZXJfc2V0dXBfb3BzID0gew0KPiAtCS5w
cmVlbmFibGUgPSAmc3RfZ3lyb19idWZmZXJfcHJlZW5hYmxlLA0KPiAgCS5wb3N0ZW5hYmxlID0g
JnN0X2d5cm9fYnVmZmVyX3Bvc3RlbmFibGUsDQo+ICAJLnByZWRpc2FibGUgPSAmc3RfZ3lyb19i
dWZmZXJfcHJlZGlzYWJsZSwNCj4gIH07DQo=
