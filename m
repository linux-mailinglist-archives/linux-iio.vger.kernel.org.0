Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70227D770
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfHAIW3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 04:22:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37786 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfHAIW2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 04:22:28 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x718JVWr006942;
        Thu, 1 Aug 2019 04:22:02 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2058.outbound.protection.outlook.com [104.47.33.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u3hrnhevp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:22:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7bLZdRJnilhEjR5yVk2zd9iUZxAsSJ2JOjnbpCKDEEl0w60Kwn3LAcDfdKz8NZX3Sh/eocanwNkGBK0843ZZ7yuL0NzDURZDgXwbTucq3nR6yd6lJf6fwocsVkwmORKPzIL01RDcSgTXm87vhtWrhzUKqlWsTkB2iD5kqllcFV/UjaKxArUhrLyhXLB3PdehSBNyQwoKrq+Qrwz7TjFbG6EMAsyzKVypPU3A2101k7Qh57v9s5C6u6tvE31U6PWG449QjET+y2CRuvZtkr4b6oyzzWKEG7q4MWdg16/6PtO6evexdlducXJ/a2BYV33x6OwyGxQIKRLmqjvccQHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l613Hnj6HsTfyFqCHWsMMAtduUY9p6uu1+SKfs+PKhg=;
 b=Wfl6P2NMg5MLCjZnt5wleXN4NgseTONWEpobG/jwjM3lZVoPC99X3WBnSvV1XPw8+vIbcZ1qAy1SIJ80Cljy/IWnPM156FN5TncSLr5yTCdKddhNoU+KJGl3vEhYLrrDxCvaacvbBER2nr5LP1NNQVfzjyKjuGox8WaMx0c/RKEIclKbM2PDAKqk8gepwpZhYK2Jvshz8jz8OWEsZVvD3iVB/dwwhngbYyAEW2xcinzrlmxp6Cl5DxAbqzRWHIrOLMDJXpf2a+4Tchau+YgYDk4rADpkC0Q2Aj+TwN07Eut7mV/NFM2XQJLPTr7yIutMGY/zDZfVcfDoSrfQM/fWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l613Hnj6HsTfyFqCHWsMMAtduUY9p6uu1+SKfs+PKhg=;
 b=ZOLvWLk5153DPG5V09x7WT1Pey0fAPvsZZymRboKn3pM+2xmvGouC6bVI4NmAS2C8Z1tHYrovSQZQke/xVx8Q4LvOnOs+kFr5/2Xdv427Hm9VzLCeL2Lj3fB0LuDlcODVfQbsbmM79G5Uw2AT7gcWexJpfFVWtM2KepSGEY4Fg8=
Received: from BN3PR03CA0111.namprd03.prod.outlook.com (2603:10b6:400:4::29)
 by SN2PR03MB2160.namprd03.prod.outlook.com (2603:10b6:804:b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.15; Thu, 1 Aug
 2019 08:21:54 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN3PR03CA0111.outlook.office365.com
 (2603:10b6:400:4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.12 via Frontend
 Transport; Thu, 1 Aug 2019 08:21:54 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Thu, 1 Aug 2019 08:21:54 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x718LrWX018198
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Aug 2019 01:21:53 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Thu, 1 Aug 2019 04:21:53 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iio:accel: preenable/postenable/predisable fixup
 for ST accel buffer
Thread-Topic: [PATCH v2 1/4] iio:accel: preenable/postenable/predisable
 fixup for ST accel buffer
Thread-Index: AQHVR+nRwucGH3JJjU6biwDTjyde9Kbmad0A
Date:   Thu, 1 Aug 2019 08:21:53 +0000
Message-ID: <122928ec4e082f1ec089dc8dfdf7b2acb9380b40.camel@analog.com>
References: <20190731214900.15380-1-denis.ciocca@st.com>
         <20190731214900.15380-2-denis.ciocca@st.com>
In-Reply-To: <20190731214900.15380-2-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.109]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F48EEA7ED534044A84472CD3DC21C4FC@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(189003)(199004)(316002)(23676004)(3846002)(7696005)(110136005)(2486003)(6116002)(478600001)(118296001)(229853002)(26005)(8936002)(486006)(126002)(356004)(8676002)(186003)(36756003)(5660300002)(2201001)(476003)(11346002)(2616005)(47776003)(86362001)(426003)(76176011)(246002)(50466002)(102836004)(70206006)(106002)(7736002)(7636002)(14454004)(70586007)(336012)(305945005)(6246003)(2906002)(2501003)(446003)(436003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2160;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61681fd8-20a0-48de-4dd3-08d716594fbe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:SN2PR03MB2160;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2160:
X-Microsoft-Antispam-PRVS: <SN2PR03MB2160A96A7CCBB89786597EA1F9DE0@SN2PR03MB2160.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hi+cEkc+bOofDxLQbU8d7vdOyitpkVOAbxMx9IjUZf3AdFlu2Pqr2O37rr8k3ixY1EujALBG3ZN0V/3R3sv82EuDqPvWpw7R7IWAaRAxezitjqam7FRTcfOlabcpfXNpXff5d+IQHEf3HMkNdlWw4jpRH5LvunMjm1rpy0Au4zWXxJI3MjpgaAnZa7X0s5weW8eSjcqaItTFYlXV+6ox0OK566V+99WxsAR0C313sjgW9WvMl7EVEHHhDscVAhjMy+pqAN02QdaUK3oPwT14jum4ZHD1KrlYvmr3Z+/jmDhxH6gpyntZRwS+RjghXCvOyiJq7f52px7NaHX6xA3kCfHn3n0UrsRie06LUSf2v0uO2DRlKK8SgHK2pf1xHUy6Pvd69JyDlpXhkpZ3HLf6esM4qhRHuiymXebjmWgwK3E=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 08:21:54.1036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61681fd8-20a0-48de-4dd3-08d716594fbe
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2160
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
ZiB1c2luZyBwcmVlbmFibGUsIGFsbCBjYW4gYmUgZG9uZSBpbnRvDQo+IHBvc3RlbmFibGUuDQo+
IExldCdzIGFsc28gcmVuYW1lIHRoZSBnb3RvIGxhYmVsIHVzaW5nIG9wZXJhdGlvbiB0byBwZXJm
b3JtIGFuZCBub3QNCj4gd2hlcmUgaXQgZmFpbHMuDQo+IA0KDQpSZXZpZXdlZC1ieTogQWxleGFu
ZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiBTaWduZWQt
b2ZmLWJ5OiBEZW5pcyBDaW9jY2EgPGRlbmlzLmNpb2NjYUBzdC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9paW8vYWNjZWwvc3RfYWNjZWxfYnVmZmVyLmMgfCA0NSArKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDI1IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FjY2VsL3N0X2FjY2VsX2J1
ZmZlci5jIGIvZHJpdmVycy9paW8vYWNjZWwvc3RfYWNjZWxfYnVmZmVyLmMNCj4gaW5kZXggMDVm
OWFlYTQzMWUyLi41OWRjZWYwMmVjMTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FjY2Vs
L3N0X2FjY2VsX2J1ZmZlci5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FjY2VsL3N0X2FjY2VsX2J1
ZmZlci5jDQo+IEBAIC0yOSw1NiArMjksNTIgQEAgaW50IHN0X2FjY2VsX3RyaWdfc2V0X3N0YXRl
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
ZShpbmRpb19kZXYsDQo+IC0JCQkJCSh1OClpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2tbMF0p
Ow0KPiArCQkJCQkgKHU4KWluZGlvX2Rldi0+YWN0aXZlX3NjYW5fbWFza1swXSk7DQo+ICAJaWYg
KGVyciA8IDApDQo+IC0JCWdvdG8gc3Rfc2Vuc29yc19zZXRfYXhpc19lbmFibGVfZXJyb3I7DQo+
ICsJCWdvdG8gc3RfYWNjZWxfYnVmZmVyX3ByZWRpc2FibGU7DQo+ICANCj4gLQlyZXR1cm4gZXJy
Ow0KPiArCWVyciA9IHN0X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIHRydWUpOw0KPiAr
CWlmIChlcnIgPCAwKQ0KPiArCQlnb3RvIHN0X2FjY2VsX2J1ZmZlcl9lbmFibGVfYWxsX2F4aXM7
DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gIA0KPiAtc3Rfc2Vuc29yc19zZXRfYXhpc19lbmFibGVf
ZXJyb3I6DQo+ICtzdF9hY2NlbF9idWZmZXJfZW5hYmxlX2FsbF9heGlzOg0KPiArCXN0X3NlbnNv
cnNfc2V0X2F4aXNfZW5hYmxlKGluZGlvX2RldiwgU1RfU0VOU09SU19FTkFCTEVfQUxMX0FYSVMp
Ow0KPiArc3RfYWNjZWxfYnVmZmVyX3ByZWRpc2FibGU6DQo+ICAJaWlvX3RyaWdnZXJlZF9idWZm
ZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiAtc3RfYWNjZWxfYnVmZmVyX3Bvc3RlbmFibGVf
ZXJyb3I6DQo+ICtzdF9hY2NlbF9mcmVlX2J1ZmZlcjoNCj4gIAlrZnJlZShhZGF0YS0+YnVmZmVy
X2RhdGEpOw0KPiAtYWxsb2NhdGVfbWVtb3J5X2Vycm9yOg0KPiAgCXJldHVybiBlcnI7DQo+ICB9
DQo+ICANCj4gIHN0YXRpYyBpbnQgc3RfYWNjZWxfYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlp
b19kZXYgKmluZGlvX2RldikNCj4gIHsNCj4gLQlpbnQgZXJyLCBlcnIyOw0KPiAgCXN0cnVjdCBz
dF9zZW5zb3JfZGF0YSAqYWRhdGEgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiAtDQo+IC0JZXJy
ID0gc3Rfc2Vuc29yc19zZXRfYXhpc19lbmFibGUoaW5kaW9fZGV2LCBTVF9TRU5TT1JTX0VOQUJM
RV9BTExfQVhJUyk7DQo+IC0JaWYgKGVyciA8IDApDQo+IC0JCWdvdG8gc3RfYWNjZWxfYnVmZmVy
X3ByZWRpc2FibGVfZXJyb3I7DQo+ICsJaW50IGVyciwgZXJyMjsNCj4gIA0KPiAgCWVyciA9IHN0
X3NlbnNvcnNfc2V0X2VuYWJsZShpbmRpb19kZXYsIGZhbHNlKTsNCj4gIAlpZiAoZXJyIDwgMCkN
Cj4gLQkJZ290byBzdF9hY2NlbF9idWZmZXJfcHJlZGlzYWJsZV9lcnJvcjsNCj4gKwkJZ290byBz
dF9hY2NlbF9idWZmZXJfcHJlZGlzYWJsZTsNCj4gKw0KPiArCWVyciA9IHN0X3NlbnNvcnNfc2V0
X2F4aXNfZW5hYmxlKGluZGlvX2RldiwgU1RfU0VOU09SU19FTkFCTEVfQUxMX0FYSVMpOw0KPiAg
DQo+IC1zdF9hY2NlbF9idWZmZXJfcHJlZGlzYWJsZV9lcnJvcjoNCj4gK3N0X2FjY2VsX2J1ZmZl
cl9wcmVkaXNhYmxlOg0KPiAgCWVycjIgPSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxl
KGluZGlvX2Rldik7DQo+ICAJaWYgKCFlcnIpDQo+ICAJCWVyciA9IGVycjI7DQo+IEBAIC04OCw3
ICs4NCw2IEBAIHN0YXRpYyBpbnQgc3RfYWNjZWxfYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlp
b19kZXYgKmluZGlvX2RldikNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9f
YnVmZmVyX3NldHVwX29wcyBzdF9hY2NlbF9idWZmZXJfc2V0dXBfb3BzID0gew0KPiAtCS5wcmVl
bmFibGUgPSAmc3RfYWNjZWxfYnVmZmVyX3ByZWVuYWJsZSwNCj4gIAkucG9zdGVuYWJsZSA9ICZz
dF9hY2NlbF9idWZmZXJfcG9zdGVuYWJsZSwNCj4gIAkucHJlZGlzYWJsZSA9ICZzdF9hY2NlbF9i
dWZmZXJfcHJlZGlzYWJsZSwNCj4gIH07DQo=
