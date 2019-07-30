Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D67A366
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 10:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfG3IwW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jul 2019 04:52:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53016 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbfG3IwV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2019 04:52:21 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U8mK64001385;
        Tue, 30 Jul 2019 04:52:15 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2056.outbound.protection.outlook.com [104.47.42.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u1nfbvtk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 04:52:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SblxishdcYVKhHrtUgqqxZeavR2O01d28srzsh5mf+0Hu0Mvesylt9RsaGwChRvJnP32qLCWRNRheWxVaZCZBdMj/5wb1VZfauva6fk0Vn7JgqR+KFPw2VI3YPTZ6QFYdOoVS98iUwofQeS08HH48R9x6eFTQxYxIIJkDbzfuWIGmD52yV3o76G6ZrH0qMBYWAzsA3ejzyOj07c7U78syxVJ8wXCj3pUGKwF7/dDupaePkRsse7cJuYjEUuIryWgSY7LFIohycQokPidiwA5nVQzOhkE2rPJ2CW9OvPNl4zXrJq2jW//KN3+2/Lh0Q+Hm6KuwcEp/388A2BxK18IVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnHltITySSuxPEPC8hFZQXmyUXGhQo4M/t3liLiZ/ZQ=;
 b=nGro4C5/8taXEA42cCAf2F7Ews3HheyhHwM0KY9wn7wvtwF93NOVFwM6K4cXIZFeDnMHO35sZX+vm5fQXf3GJtZHpXlFrNN2QC1hSLQLX0Fv4Nxh/sJea84i+bh9vUdGjn3bRsKRXTH/0nYoibb36C3NLf5Z23gDyLW0JVqg8dUM+EcQn9W2NOyu8801nwBHefPgMosXWmeJ8PlNlClTpNs2W/f16vaY8ewTCRe1w2qnTpi+zAl7Ry77C3t6sx4CZNS1/FZAeVSBMCBBtbxfQ7NzQr8VpwJvku87yvay3XARbd1byJIN66Ha1YWSpTtYVK7IBBGq8RW46bC5vQQ52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnHltITySSuxPEPC8hFZQXmyUXGhQo4M/t3liLiZ/ZQ=;
 b=eGSQcPLHQjSzsoRei1cvgPHyWn1iq2+v8aN6aiL/4dLnjZ7gCTsFAD1l6N6ZpnZ+Wqgc7h0AMEuwr1uw23+9OVMME/x2y2NPzE31w8pGtFm0LChMw9jXPEmBtq+TPX9cOltgGX/IFH24jK+WMFq35xEZ3VfRXus65r+FiVmPGZc=
Received: from MWHPR03CA0047.namprd03.prod.outlook.com (2603:10b6:301:3b::36)
 by BYAPR03MB4838.namprd03.prod.outlook.com (2603:10b6:a03:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Tue, 30 Jul
 2019 08:52:13 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MWHPR03CA0047.outlook.office365.com
 (2603:10b6:301:3b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10 via Frontend
 Transport; Tue, 30 Jul 2019 08:52:13 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Tue, 30 Jul 2019 08:52:13 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6U8qAJf013047
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 30 Jul 2019 01:52:10 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Tue, 30 Jul 2019 04:52:12 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio:accel: preenable/postenable/predisable fixup
 for ST accel buffer
Thread-Topic: [PATCH 1/4] iio:accel: preenable/postenable/predisable fixup
 for ST accel buffer
Thread-Index: AQHVRmtJBMdjlbVqCU2quu5A8vrRBqbjUKiA
Date:   Tue, 30 Jul 2019 08:52:12 +0000
Message-ID: <b50940d1c40d0a152dff1500d232db3097ace08b.camel@analog.com>
References: <20190730000305.30958-1-denis.ciocca@st.com>
         <20190730000305.30958-2-denis.ciocca@st.com>
In-Reply-To: <20190730000305.30958-2-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.107]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DE1C33721822343AE17FBF4DACD66AA@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(199004)(189003)(486006)(70206006)(426003)(102836004)(106002)(436003)(76176011)(2486003)(50466002)(11346002)(126002)(23676004)(7696005)(8676002)(110136005)(7636002)(2501003)(14454004)(70586007)(336012)(5660300002)(86362001)(305945005)(7736002)(2906002)(316002)(186003)(47776003)(246002)(2201001)(26005)(8936002)(229853002)(3846002)(476003)(6116002)(118296001)(6246003)(2616005)(478600001)(446003)(356004)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4838;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc8a1fbe-f802-41b2-8cc9-08d714cb3734
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4838;
X-MS-TrafficTypeDiagnostic: BYAPR03MB4838:
X-Microsoft-Antispam-PRVS: <BYAPR03MB48384AF9DDB6B043E71A7108F9DC0@BYAPR03MB4838.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0114FF88F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ja34s4twsmgnfXXLoS5pIo3EXGQsSuKw8MtI8o9IxHIbKaTYo4j9piMEnmNCOuoaDESqmRYtStuoL20E4XcTjqP0UuHOPKqL7XYzB83vmOK0Fii5J4fnBWBQw/mMagH9qN7m3aBGYXcrpBSs5aD9OpCF8VWDbFAQ259F1EzBWGyYT26/7WZWiysem7LY7o1LGwS8znCDlRi0CnYSI9vro2SyTkOUogoxJBrUOFlphM/UXwq0NTPwGS3qRGMOhgDkhbQKZ7kbriLbOomt4x7vYHf9sc+SsgWRrjcaZV8ikuSj3B622ysRgKypQuUEYx4ADYzhojs6GA4EDdFAnkBbYyCJUtfUEarcY+8N1dHlMPsNHSdzcmDokSomkepFnplYvzxway2hxYoQjN0kRztrv+r4zczh8zopN31mI3X/mgE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2019 08:52:13.2100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8a1fbe-f802-41b2-8cc9-08d714cb3734
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4838
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA3LTI5IGF0IDE3OjAzIC0wNzAwLCBEZW5pcyBDaW9jY2Egd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgdHJ5aW5nIHRvIGNsZWFudXAgZm9yIGdv
b2QgdGhlIGJ1ZmZlcnMgb3BlcmF0aW9uIGZ1bmN0aW9ucy4NCj4gVGhlcmUgaXMgbm8gbmVlZCBv
ZiB1c2luZyBwcmVlbmFibGUsIGFsbCBjYW4gYmUgZG9uZSBpbnRvDQo+IHBvc3RlbmFibGUuDQo+
IExldCdzIGFsc28gcmVuYW1lIHRoZSBnb3RvIGxhYmVsIHVzaW5nIG9wZXJhdGlvbiB0byBwZXJm
b3JtIGFuZCBub3QNCj4gd2hlcmUgaXQgZmFpbHMuDQo+IA0KDQpSZXZpZXdlZC1ieTogQWxleGFu
ZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiBTaWduZWQt
b2ZmLWJ5OiBEZW5pcyBDaW9jY2EgPGRlbmlzLmNpb2NjYUBzdC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9paW8vYWNjZWwvc3RfYWNjZWxfYnVmZmVyLmMgfCAzNyArKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDI0IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FjY2VsL3N0X2FjY2VsX2J1
ZmZlci5jIGIvZHJpdmVycy9paW8vYWNjZWwvc3RfYWNjZWxfYnVmZmVyLmMNCj4gaW5kZXggMDVm
OWFlYTQzMWUyLi44MWY4OWRhMTI1YWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FjY2Vs
L3N0X2FjY2VsX2J1ZmZlci5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FjY2VsL3N0X2FjY2VsX2J1
ZmZlci5jDQo+IEBAIC0yOSw1NiArMjksNDYgQEAgaW50IHN0X2FjY2VsX3RyaWdfc2V0X3N0YXRl
KHN0cnVjdCBpaW9fdHJpZ2dlciAqdHJpZywgYm9vbCBzdGF0ZSkNCj4gIAlyZXR1cm4gc3Rfc2Vu
c29yc19zZXRfZGF0YXJlYWR5X2lycShpbmRpb19kZXYsIHN0YXRlKTsNCj4gIH0NCj4gIA0KPiAt
c3RhdGljIGludCBzdF9hY2NlbF9idWZmZXJfcHJlZW5hYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRp
b19kZXYpDQo+IC17DQo+IC0JcmV0dXJuIHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYs
IHRydWUpOw0KPiAtfQ0KPiAtDQo+ICBzdGF0aWMgaW50IHN0X2FjY2VsX2J1ZmZlcl9wb3N0ZW5h
YmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICB7DQo+IC0JaW50IGVycjsNCj4gIAlz
dHJ1Y3Qgc3Rfc2Vuc29yX2RhdGEgKmFkYXRhID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gKwlp
bnQgZXJyOw0KPiAgDQo+ICAJYWRhdGEtPmJ1ZmZlcl9kYXRhID0ga21hbGxvYyhpbmRpb19kZXYt
PnNjYW5fYnl0ZXMsDQo+ICAJCQkJICAgICBHRlBfRE1BIHwgR0ZQX0tFUk5FTCk7DQo+IC0JaWYg
KGFkYXRhLT5idWZmZXJfZGF0YSA9PSBOVUxMKSB7DQo+IC0JCWVyciA9IC1FTk9NRU07DQo+IC0J
CWdvdG8gYWxsb2NhdGVfbWVtb3J5X2Vycm9yOw0KPiAtCX0NCj4gKwlpZiAoIWFkYXRhLT5idWZm
ZXJfZGF0YSkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gIAllcnIgPSBpaW9fdHJpZ2dl
cmVkX2J1ZmZlcl9wb3N0ZW5hYmxlKGluZGlvX2Rldik7DQo+ICAJaWYgKGVyciA8IDApDQo+IC0J
CWdvdG8gc3RfYWNjZWxfYnVmZmVyX3Bvc3RlbmFibGVfZXJyb3I7DQo+ICsJCWdvdG8gc3RfYWNj
ZWxfZnJlZV9idWZmZXI7DQo+ICANCj4gIAllcnIgPSBzdF9zZW5zb3JzX3NldF9heGlzX2VuYWJs
ZShpbmRpb19kZXYsDQo+ICAJCQkJCSh1OClpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2tbMF0p
Ow0KPiAgCWlmIChlcnIgPCAwKQ0KPiAtCQlnb3RvIHN0X3NlbnNvcnNfc2V0X2F4aXNfZW5hYmxl
X2Vycm9yOw0KPiArCQlnb3RvIHN0X2FjY2VsX2J1ZmZlcl9wcmVkaXNhYmxlOw0KPiAgDQo+IC0J
cmV0dXJuIGVycjsNCj4gKwlyZXR1cm4gc3Rfc2Vuc29yc19zZXRfZW5hYmxlKGluZGlvX2Rldiwg
dHJ1ZSk7DQo+ICANCj4gLXN0X3NlbnNvcnNfc2V0X2F4aXNfZW5hYmxlX2Vycm9yOg0KPiArc3Rf
YWNjZWxfYnVmZmVyX3ByZWRpc2FibGU6DQo+ICAJaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlz
YWJsZShpbmRpb19kZXYpOw0KPiAtc3RfYWNjZWxfYnVmZmVyX3Bvc3RlbmFibGVfZXJyb3I6DQo+
ICtzdF9hY2NlbF9mcmVlX2J1ZmZlcjoNCj4gIAlrZnJlZShhZGF0YS0+YnVmZmVyX2RhdGEpOw0K
PiAtYWxsb2NhdGVfbWVtb3J5X2Vycm9yOg0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+ICANCj4g
IHN0YXRpYyBpbnQgc3RfYWNjZWxfYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldikNCj4gIHsNCj4gLQlpbnQgZXJyLCBlcnIyOw0KPiAgCXN0cnVjdCBzdF9zZW5zb3Jf
ZGF0YSAqYWRhdGEgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiAtDQo+IC0JZXJyID0gc3Rfc2Vu
c29yc19zZXRfYXhpc19lbmFibGUoaW5kaW9fZGV2LCBTVF9TRU5TT1JTX0VOQUJMRV9BTExfQVhJ
Uyk7DQo+IC0JaWYgKGVyciA8IDApDQo+IC0JCWdvdG8gc3RfYWNjZWxfYnVmZmVyX3ByZWRpc2Fi
bGVfZXJyb3I7DQo+ICsJaW50IGVyciwgZXJyMjsNCj4gIA0KPiAgCWVyciA9IHN0X3NlbnNvcnNf
c2V0X2VuYWJsZShpbmRpb19kZXYsIGZhbHNlKTsNCj4gIAlpZiAoZXJyIDwgMCkNCj4gLQkJZ290
byBzdF9hY2NlbF9idWZmZXJfcHJlZGlzYWJsZV9lcnJvcjsNCj4gKwkJZ290byBzdF9hY2NlbF9i
dWZmZXJfcHJlZGlzYWJsZTsNCj4gKw0KPiArCWVyciA9IHN0X3NlbnNvcnNfc2V0X2F4aXNfZW5h
YmxlKGluZGlvX2RldiwgU1RfU0VOU09SU19FTkFCTEVfQUxMX0FYSVMpOw0KPiAgDQo+IC1zdF9h
Y2NlbF9idWZmZXJfcHJlZGlzYWJsZV9lcnJvcjoNCj4gK3N0X2FjY2VsX2J1ZmZlcl9wcmVkaXNh
YmxlOg0KPiAgCWVycjIgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rl
dik7DQo+ICAJaWYgKCFlcnIpDQo+ICAJCWVyciA9IGVycjI7DQo+IEBAIC04OCw3ICs3OCw2IEBA
IHN0YXRpYyBpbnQgc3RfYWNjZWxfYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldikNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fYnVmZmVyX3Nl
dHVwX29wcyBzdF9hY2NlbF9idWZmZXJfc2V0dXBfb3BzID0gew0KPiAtCS5wcmVlbmFibGUgPSAm
c3RfYWNjZWxfYnVmZmVyX3ByZWVuYWJsZSwNCj4gIAkucG9zdGVuYWJsZSA9ICZzdF9hY2NlbF9i
dWZmZXJfcG9zdGVuYWJsZSwNCj4gIAkucHJlZGlzYWJsZSA9ICZzdF9hY2NlbF9idWZmZXJfcHJl
ZGlzYWJsZSwNCj4gIH07DQo=
