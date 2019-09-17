Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF3B4E23
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfIQMmf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 08:42:35 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:7578 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727911AbfIQMme (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 08:42:34 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8HCX1HJ010411;
        Tue, 17 Sep 2019 08:41:49 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2050.outbound.protection.outlook.com [104.47.32.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v0sy965ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 08:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSQwVerefO9ommNsc7t3VI8j/IOzGvw/CNv0STQz7Bkcxr8BWcvuoFfEIIfeBtPq6pf5Z0i4XrT2rxak83hSADhy+KyhwjuQeGF67HPk3MfTFRH/qsOjcmUeNzTW1ZFD5QxUaK6efumy0d+dQ7YVLo9jOvcowwNIPCu4JgV9ZPWczFpG6gENLgp6Q6Yt4Mn7s7tYboRZ92LmtCSOr9YQ1cuXSKr50XaZFrnAyzjYEyHhXbnN6nUy1skKId/s5YQnWjUNtvrR2NyAgA/kZ1qprLHTuv2pXsWrN+ji/HzD90+u76mNOzJKqFqK0fyO1cNEQ6rJTn7oFcOTzjNg+x2roQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKvF/cl1a5s9/BZnHZo0qtQExBVgNC5oeGHhhtDrcxA=;
 b=lovamGejWnPtIrKuqk9AqI/yD0pOmEv5K8xPhkjPE4Rw8SvdNehsqBhSZPp2AxMjyxy1PM1dKlz5YQzFq+jUlpwEvZHrmR9A4j+m7673FWnlHvtyAKXxGHfB34TIf5oouFqmcdoiyRZjrRAWz7m8jAC/4D/T0A7l0btU5p85fyPOHPDZhy7JlN38Lyvh4eAhdK1nqDGkE44pFoZr9GyGiwgB+ktipuSJEO9au8yM0Z1QYWiTODICrHhLOzW/yCSDRVB2RroJZeetoE8kzMgEY2zfmML6JQtIODrvKQw+kzvulzdKgJKNq9+viT2Xc74EKhkUXOZLm3hRsriu2R9CAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKvF/cl1a5s9/BZnHZo0qtQExBVgNC5oeGHhhtDrcxA=;
 b=yO2p28NWJC1OC7CgnCBZ3/3h//4EmaXv+6VL0iSM483ua1ugysOLFcdt4QGJGJoyc95Pp0EBD+SyOmFTFjkwyUEiSyY7HsNO4XU0GM2F/EtNdG1kj2+STrT8L7yv9KoK85ozrF+awYt8CZgkeqheWu1I0lWDCRe2+hRTAi/4GoI=
Received: from BY5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:1e0::16)
 by BL0PR03MB4225.namprd03.prod.outlook.com (2603:10b6:208:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.19; Tue, 17 Sep
 2019 12:41:48 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BY5PR03CA0006.outlook.office365.com
 (2603:10b6:a03:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.19 via Frontend
 Transport; Tue, 17 Sep 2019 12:41:47 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Tue, 17 Sep 2019 12:41:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8HCfkHf000480
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 17 Sep 2019 05:41:46 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Tue, 17 Sep 2019 08:41:46 -0400
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: accel: adxl372: Fix/remove limitation for
 FIFO samples
Thread-Topic: [PATCH v2 1/3] iio: accel: adxl372: Fix/remove limitation for
 FIFO samples
Thread-Index: AQHVZ+YlMHuxckaaik6e85r3MwFblqctBcmAgAMW5oA=
Date:   Tue, 17 Sep 2019 12:41:45 +0000
Message-ID: <1568723869.10585.17.camel@analog.com>
References: <1568126612-13134-1-git-send-email-stefan.popa@analog.com>
         <20190915142705.028cb015@archlinux>
In-Reply-To: <20190915142705.028cb015@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.226.41]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EB083F564B937458B4A112583A106F7@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(47776003)(3846002)(6116002)(5660300002)(14454004)(6916009)(356004)(316002)(50466002)(106002)(86362001)(54906003)(76176011)(36756003)(246002)(2906002)(8936002)(7696005)(8676002)(2486003)(23676004)(70586007)(436003)(426003)(476003)(11346002)(336012)(2501003)(126002)(446003)(2351001)(2616005)(103116003)(26005)(186003)(478600001)(486006)(102836004)(70206006)(6246003)(7736002)(7636002)(4326008)(229853002)(5640700003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR03MB4225;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a55cffb-e732-4035-6bae-08d73b6c6782
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:BL0PR03MB4225;
X-MS-TrafficTypeDiagnostic: BL0PR03MB4225:
X-Microsoft-Antispam-PRVS: <BL0PR03MB42256E44A0901DF2F4D1FF4C9D8F0@BL0PR03MB4225.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01630974C0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ASWzoYBZ3PNLU+6DEGtwx9dWLD+i8dxwdtcMtvSqNM/7u5d5hnx0Krpg2j/EYpnkHl4VFTo+6+3Oa1AbzEg8d1L1uTClkaw4zIuPqd4gkVkw1y/KCDfqiipnlzplRBcqYrkt/EdTFlpyoXDlEmATrHRS5rz71DDEW35mAvdqGhm8xtHd0ldN+jIVuStSOx7VCFInj9B9rBN82PHdj2sgQfjVhM4KneqkK+Rcd1u8PrTlU1bVucSQ2DZSCrlvfJ91+lIbN6gVTruplCLci4XYOk7dS4sOMatiKsISvJnRmBzpbHz98JNYOkBj7P/1z5tYLUBjV688HwiPJOMGosG1oONg8d/HwyowlUTGOgoMJcoSGZ9NKuUXjwVcTy832XebyETZ9EqSDNj26k1jCXIEWRaJYtELrd7f2pW3kq6JZMY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2019 12:41:47.4140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a55cffb-e732-4035-6bae-08d73b6c6782
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR03MB4225
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-17_06:2019-09-17,2019-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909170127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRHUsIDIwMTktMDktMTUgYXQgMTQ6MjcgKzAxMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6
DQo+IA0KPiANCj4gDQo+IE9uIFR1ZSwgMTAgU2VwIDIwMTkgMTc6NDM6MzIgKzAzMDANCj4gU3Rl
ZmFuIFBvcGEgPHN0ZWZhbi5wb3BhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiAN
Cj4gPiANCj4gPiANCj4gPiBDdXJyZW50bHksIHRoZSBkcml2ZXIgc2V0cyB0aGUgRklGT19TQU1Q
TEVTIHJlZ2lzdGVyIHdpdGggdGhlIG51bWJlciBvZg0KPiA+IHNhbXBsZSBzZXRzIChtYXhpbXVt
IG9mIDE3MCBmb3IgMyBheGlzIGRhdGEsIDI1NiBmb3IgMi1heGlzIGFuZCA1MTIgZm9yDQo+ID4g
c2luZ2xlIGF4aXMpLiBIb3dldmVyLCB0aGUgRklGT19TQU1QTEVTIHJlZ2lzdGVyIHNob3VsZCBz
dG9yZSB0aGUNCj4gPiBudW1iZXINCj4gPiBvZiBzYW1wbGVzLCByZWdhcmRsZXNzIG9mIGhvdyB0
aGUgRklGTyBmb3JtYXQgaXMgY29uZmlndXJlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
dGVmYW4gUG9wYSA8c3RlZmFuLnBvcGFAYW5hbG9nLmNvbT4NCkhpIEpvbmF0aGFuLA0KDQo+IA0K
PiANCj4gDQo+IEZpeGVzIHRhZ3M/IEkgdGhpbmsgaXQnc8KgDQo+IEZpeGVzOiBmNGY1NWNlMzhl
NWYgKCJpaW86YWR4bDM3MjogQWRkIEZJRk8gYW5kIGludGVycnVwdHMgc3VwcG9ydCIpDQo+IA0K
PiBDaGVjayBJIGdvdCB0aGF0IHJpZ2h0IHRob3VnaC4NClllcywgdGhhdCdzIHJpZ2h0ISBUaGFu
ayB5b3UhDQotU3RlZmFuDQo+IA0KPiANCj4gDQo+IA0KPiBPbmUgdHJpdmlhbCBpbmxpbmUgdGhh
dCBJIGhhdmUgdGlkaWVkIHVwIHdoaWxzdCBhcHBseWluZy4NCj4gDQo+IEFwcGxpZWQgdG8gdGhl
IGZpeGVzLXRvZ3JlZyBicmFuY2ggb2YgaWlvLmdpdC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpv
bmF0aGFuDQo+IA0KPiANCj4gPiANCj4gPiANCj4gPiANCj4gPiANCj4gPiAtLS0NCj4gPiBDaGFu
Z2VzIGluIHYyOg0KPiA+IAktIHN0LT53YXRlcm1hcmsgbmVlZHMgdG8gc3RvcmUgdGhlIG51bWJl
ciBvZiBzYW1wbGUgc2V0cyzCoA0KPiA+IAnCoMKgdGhlIHRvdGFsIG51bWJlciBvZiBzYW1wbGVz
IGlzIGNvbXB1dGVkIGluDQo+ID4gCcKgwqBhZHhsMzcyX2NvbmZpZ3VyZV9maWZvKCkgZnVuYy4N
Cj4gPiANCj4gPiDCoGRyaXZlcnMvaWlvL2FjY2VsL2FkeGwzNzIuYyB8IDExICsrKysrKysrLS0t
DQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hY2NlbC9hZHhsMzcyLmMgYi9kcml2
ZXJzL2lpby9hY2NlbC9hZHhsMzcyLmMNCj4gPiBpbmRleCAwNTUyMjdjYi4uN2RlNWUxYiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9hY2NlbC9hZHhsMzcyLmMNCj4gPiArKysgYi9kcml2
ZXJzL2lpby9hY2NlbC9hZHhsMzcyLmMNCj4gPiBAQCAtNDc0LDEyICs0NzQsMTcgQEAgc3RhdGlj
IGludCBhZHhsMzcyX2NvbmZpZ3VyZV9maWZvKHN0cnVjdA0KPiA+IGFkeGwzNzJfc3RhdGUgKnN0
KQ0KPiA+IMKgCWlmIChyZXQgPCAwKQ0KPiA+IMKgCQlyZXR1cm4gcmV0Ow0KPiA+IMKgDQo+ID4g
LQlmaWZvX3NhbXBsZXMgPSBzdC0+d2F0ZXJtYXJrICYgMHhGRjsNCj4gPiArCS8qDQo+ID4gKwnC
oCogd2F0ZXJtYWsgc3RvcmVzIHRoZSBudW1iZXIgb2Ygc2V0czsgd2UgbmVlZCB0byB3cml0ZSB0
aGUNCj4gPiBGSUZPDQo+IHdhdGVybWFyaw0KPiANCj4gPiANCj4gPiANCj4gPiANCj4gPiANCj4g
PiArCcKgKiByZWdpc3RlcnMgd2l0aCB0aGUgbnVtYmVyIG9mIHNhbXBsZXMNCj4gPiArCcKgKi8N
Cj4gPiArCWZpZm9fc2FtcGxlcyA9IChzdC0+d2F0ZXJtYXJrICogc3QtPmZpZm9fc2V0X3NpemUp
Ow0KPiA+IMKgCWZpZm9fY3RsID0gQURYTDM3Ml9GSUZPX0NUTF9GT1JNQVRfTU9ERShzdC0+Zmlm
b19mb3JtYXQpIHwNCj4gPiDCoAkJwqDCoMKgQURYTDM3Ml9GSUZPX0NUTF9NT0RFX01PREUoc3Qt
PmZpZm9fbW9kZSkgfA0KPiA+IC0JCcKgwqDCoEFEWEwzNzJfRklGT19DVExfU0FNUExFU19NT0RF
KHN0LT53YXRlcm1hcmspOw0KPiA+ICsJCcKgwqDCoEFEWEwzNzJfRklGT19DVExfU0FNUExFU19N
T0RFKGZpZm9fc2FtcGxlcyk7DQo+ID4gwqANCj4gPiAtCXJldCA9IHJlZ21hcF93cml0ZShzdC0+
cmVnbWFwLCBBRFhMMzcyX0ZJRk9fU0FNUExFUywNCj4gPiBmaWZvX3NhbXBsZXMpOw0KPiA+ICsJ
cmV0ID0gcmVnbWFwX3dyaXRlKHN0LT5yZWdtYXAsDQo+ID4gKwkJCcKgwqDCoEFEWEwzNzJfRklG
T19TQU1QTEVTLCBmaWZvX3NhbXBsZXMgJiAweEZGKTsNCj4gPiDCoAlpZiAocmV0IDwgMCkNCj4g
PiDCoAkJcmV0dXJuIHJldDsNCj4gPiDCoA==
