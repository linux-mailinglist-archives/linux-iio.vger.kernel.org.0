Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2119F116
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDFHoB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 03:44:01 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18092 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgDFHoB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 03:44:01 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0367dmpi002545;
        Mon, 6 Apr 2020 03:43:36 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00128a01.pphosted.com with ESMTP id 306pv6mwqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 03:43:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB7y9x6BeP8LVs1p6aRQTKqfix3i3TXlVmKpYLuawCwqd2S+gPH9DBym1acc/nyL45FzFi+LAIT+M2mjEzmbh5kDiADWTwkVKC6/qI8qN6Y9eyvD96egndXCdxc/H/gDYsVcC3KTea0bSsPeduijGdvKeT3SOryOPPjoqrekqkJjlzKYG9JCdlWN0fftL44P32hVmlaxqfNFtZdFjtk3lYH5FN2X+8wntdNXUARharDWJSkICVicV48N+i+TrnkxXgqfaRSJXKA++u3LggyK5EGtGcJCto0kLYHkCixATaYdzbn/1VCb7nLxUeLojylLmsE5iBujGSYiXqHKByUh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLH3eYxeGjoOW32wlmiv/8OVUrJbktX15FZWjEFBVHs=;
 b=AN0XFCYTyysjNY5OR+HxzHvlForwBfph+1CBiwa/V+kWJPO7f9uJTFJfSMLPgn+e+hZjK0rNAwEah4aan0egge3lwwPEk7zhT42QzefVDnCUWdYUhx5PE/eS/DeXwEGVB+35RLNlye6JxvoSH1k+E8DXj/5XqmXtoqPjTASn5Z/+cyCBuL/2sav0v/uHNQwXElQQLadEOP9Y2avlRTxLrMHf4PYu9436892dvk9gwPoeD55CdzSHvyI/ihU0JwTbUFoB57kXlh2L7iJkGkBIWbjxemdJ6/qZ+VBJaANQeK2RUNcuKNsjUObsJmDldaYMrfwNAzCxuLG/DJdYHaU3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLH3eYxeGjoOW32wlmiv/8OVUrJbktX15FZWjEFBVHs=;
 b=l63BMsjhwM+aM9uCpF1MF0QhB3pDh+uZBbiE8X0OA+tR/1FC+Y1ZlGseq1BVvbhaaohCHiOHKQDjZAQF0tSIiRs/Rtel2pIRyoyDIyiLOYz5+4cQiVF8Gc64E+hTJBOY03rrvjvPIeB3SR8TSFIiN34aNKsUpou40whza1nvuQs=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3833.namprd03.prod.outlook.com (2603:10b6:5:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 07:43:34 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 07:43:34 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 3/3] staging: iio: ad5933: use
 iio_device_attach_kfifo_buffer() helper
Thread-Topic: [PATCH 3/3] staging: iio: ad5933: use
 iio_device_attach_kfifo_buffer() helper
Thread-Index: AQHWCCWQ4hJnvSmMUEmnOA6mGrgaNKhqX4uAgAFeToA=
Date:   Mon, 6 Apr 2020 07:43:34 +0000
Message-ID: <d6622323388d02be2a06b35e009a37577b09036c.camel@analog.com>
References: <20200401125936.6398-1-alexandru.ardelean@analog.com>
         <20200401125936.6398-3-alexandru.ardelean@analog.com>
         <20200405114945.67110eb2@archlinux>
In-Reply-To: <20200405114945.67110eb2@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2c7ce80-6343-4286-48e8-08d7d9fe35e1
x-ms-traffictypediagnostic: DM6PR03MB3833:
x-microsoft-antispam-prvs: <DM6PR03MB38336892491FB479858DE082F9C20@DM6PR03MB3833.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(376002)(136003)(39850400004)(396003)(366004)(6486002)(54906003)(86362001)(2906002)(2616005)(478600001)(26005)(6916009)(6506007)(8676002)(8936002)(81156014)(81166006)(316002)(6512007)(5660300002)(186003)(36756003)(4326008)(66446008)(66476007)(64756008)(66556008)(91956017)(76116006)(66946007)(71200400001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Khmgr5MdnbtrQOHPnTHYJGxVU3lSKPUaHhXp/UKVTcCc3izy+BraAFtsAaT5kyIE8jlybNPB7dsTD4uxXW/rEGUDhNkkIe0orYCr8wkLqA4j58UaPI+ETgZ5tJ+IcWsieBOWs+6W5WBPve64xJgBOFUm0TuHKMwI/Eji4vu70KplVApzMV3CVQBHkaG3mg5zhjbTkB+Sa0IOIoRsJoz0NgugUicdZZrU+nYCF8ueyjCYKnu2PJpdZRVwGlpE1MgAQ1D8cgIYibeWJ0FFrdU2ZqjY+KgIXjWoN7Wea+ZMWA0I6/ACMPkaFI1V6I9bdW42WaHV2KLYZSPkfPQV+RMXJGQm2o1pMMYZuBoQbdeR7VixeTUzdr14AbjN7y/pC4doMAMO9wv/EUOd9GRJ+kL4NxCKZF/bBNxI7skIAGnc9K5z0VN3NT5RMXtzNujMNOVU
x-ms-exchange-antispam-messagedata: jT5jlba8w7IRwEnSf/yrwSiSG+HSdmPSZr6soEUBPzIUxbilSz4MJRfTpbEktAySKgJhkTNvEoqJkfHStWStbHJre3mfYmd88m9fHz+b8jj2Rd5cvFqRw3QYUWGBlJFPwg06SOEmnyCKkE6850OQgA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <100150EA7852F74BB5DE28AF71326B1D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c7ce80-6343-4286-48e8-08d7d9fe35e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 07:43:34.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqK7iFGwgLL1T4otB4356ZeqU56QIEY96U8UPj738T5NaCl5j9/3WMw8lEU9GfIp0gL3imUlfGFRN8tL1COhrGG2dDAWr7b3QQAtvMdmgUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3833
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_03:2020-04-03,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004060065
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTA1IGF0IDExOjQ5ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBXZWQsIDEgQXByIDIwMjAgMTU6NTk6MzYgKzAzMDAN
Cj4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IFRoaXMgZHJpdmVyIGNhbGxzIGlpb19rZmlmb19hbGxvY2F0ZSgpIHZzIGRl
dm1faWlvX2tmaWZvX2FsbG9jYXRlKCkuIEJ1dA0KPiA+IHRoZSBjb252ZXJzaW9uIGlzIHN0aWxs
IHNpbXBsZXIgaGVyZSwgYW5kIGNsZWFucy11cC9yZWR1Y2VzIHNvbWUgZXJyb3INCj4gPiBwYXRo
cy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRy
dS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiANCj4gVGhpcyBtaXhlcyBkZXZtIG1hbmFnZWQgc3R1
ZmYgYW4gdW5tYW5hZ2VkLiAgSGVuY2UgaXQgZmFpbHMgdGhlICdvYnZpb3VzbHkNCj4gY29ycmVj
dCcNCj4gdGVzdC4gIElmIHlvdSB3YW50ZWQgdG8gZG8gdGhpcyB5b3UnZCBmaXJzdCBuZWVkIHRv
IHNvcnQgb3V0IHRoZSB1bm1hbmFnZWQNCj4gYml0cyB0byBiZSBhdXRvbWF0aWNhbGx5IHVud291
bmQgKHJlZ3VsYXRvcnMgYW5kIGNsb2NrcykuIE9yIHBvdGVudGlhbGx5DQo+IHJlb3JkZXINCj4g
dGhlIGRyaXZlciBzbyB0aG9zZSBoYXBwZW4gYWZ0ZXIgdGhpcyBhbGxvY2F0aW9uIGlzIGRvbmUu
DQo+IA0KDQpZZWFoLg0KSSB3YXMgYSBiaXQgc2xvcHB5IGhlcmUuDQpJIHRoaW5rIHRyaWVkIGEg
YnJvYWRlciBjbGVhbnVwL3Jld29yayB3b3VsZCBiZSBhIGJldHRlciBpZGVhIGhlcmUuDQoNCg0K
PiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL3N0YWdpbmcv
aWlvL2ltcGVkYW5jZS1hbmFseXplci9hZDU5MzMuYyAgIHwgMjggKysrKy0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9pbXBlZGFuY2UtYW5h
bHl6ZXIvYWQ1OTMzLmMNCj4gPiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vaW1wZWRhbmNlLWFuYWx5
emVyL2FkNTkzMy5jDQo+ID4gaW5kZXggYWYwYmNmOTVlZThhLi43YmRlOTNjNmRkNzQgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9pbXBlZGFuY2UtYW5hbHl6ZXIvYWQ1OTMz
LmMNCj4gPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2ltcGVkYW5jZS1hbmFseXplci9hZDU5
MzMuYw0KPiA+IEBAIC02MDIsMjIgKzYwMiw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2J1
ZmZlcl9zZXR1cF9vcHMNCj4gPiBhZDU5MzNfcmluZ19zZXR1cF9vcHMgPSB7DQo+ID4gIAkucG9z
dGRpc2FibGUgPSBhZDU5MzNfcmluZ19wb3N0ZGlzYWJsZSwNCj4gPiAgfTsNCj4gPiAgDQo+ID4g
LXN0YXRpYyBpbnQgYWQ1OTMzX3JlZ2lzdGVyX3JpbmdfZnVuY3NfYW5kX2luaXQoc3RydWN0IGlp
b19kZXYgKmluZGlvX2RldikNCj4gPiAtew0KPiA+IC0Jc3RydWN0IGlpb19idWZmZXIgKmJ1ZmZl
cjsNCj4gPiAtDQo+ID4gLQlidWZmZXIgPSBpaW9fa2ZpZm9fYWxsb2NhdGUoKTsNCj4gPiAtCWlm
ICghYnVmZmVyKQ0KPiA+IC0JCXJldHVybiAtRU5PTUVNOw0KPiA+IC0NCj4gPiAtCWlpb19kZXZp
Y2VfYXR0YWNoX2J1ZmZlcihpbmRpb19kZXYsIGJ1ZmZlcik7DQo+ID4gLQ0KPiA+IC0JLyogUmlu
ZyBidWZmZXIgZnVuY3Rpb25zIC0gaGVyZSB0cmlnZ2VyIHNldHVwIHJlbGF0ZWQgKi8NCj4gPiAt
CWluZGlvX2Rldi0+c2V0dXBfb3BzID0gJmFkNTkzM19yaW5nX3NldHVwX29wczsNCj4gPiAtDQo+
ID4gLQlyZXR1cm4gMDsNCj4gPiAtfQ0KPiA+IC0NCj4gPiAgc3RhdGljIHZvaWQgYWQ1OTMzX3dv
cmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgYWQ1OTMz
X3N0YXRlICpzdCA9IGNvbnRhaW5lcl9vZih3b3JrLA0KPiA+IEBAIC03MzgsMjYgKzcyMiwyNSBA
QCBzdGF0aWMgaW50IGFkNTkzM19wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KPiA+
ICAJaW5kaW9fZGV2LT5kZXYucGFyZW50ID0gJmNsaWVudC0+ZGV2Ow0KPiA+ICAJaW5kaW9fZGV2
LT5pbmZvID0gJmFkNTkzM19pbmZvOw0KPiA+ICAJaW5kaW9fZGV2LT5uYW1lID0gaWQtPm5hbWU7
DQo+ID4gLQlpbmRpb19kZXYtPm1vZGVzID0gKElORElPX0JVRkZFUl9TT0ZUV0FSRSB8IElORElP
X0RJUkVDVF9NT0RFKTsNCj4gPiArCWluZGlvX2Rldi0+bW9kZXMgPSBJTkRJT19ESVJFQ1RfTU9E
RTsNCj4gPiAgCWluZGlvX2Rldi0+Y2hhbm5lbHMgPSBhZDU5MzNfY2hhbm5lbHM7DQo+ID4gIAlp
bmRpb19kZXYtPm51bV9jaGFubmVscyA9IEFSUkFZX1NJWkUoYWQ1OTMzX2NoYW5uZWxzKTsNCj4g
PiAgDQo+ID4gLQlyZXQgPSBhZDU5MzNfcmVnaXN0ZXJfcmluZ19mdW5jc19hbmRfaW5pdChpbmRp
b19kZXYpOw0KPiA+ICsJcmV0ID0gaWlvX2RldmljZV9hdHRhY2hfa2ZpZm9fYnVmZmVyKGluZGlv
X2RldiwgSU5ESU9fQlVGRkVSX1NPRlRXQVJFLA0KPiA+ICsJCQkJCSAgICAgJmFkNTkzM19yaW5n
X3NldHVwX29wcyk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCWdvdG8gZXJyb3JfZGlzYWJsZV9t
Y2xrOw0KPiA+ICANCj4gPiAgCXJldCA9IGFkNTkzM19zZXR1cChzdCk7DQo+ID4gIAlpZiAocmV0
KQ0KPiA+IC0JCWdvdG8gZXJyb3JfdW5yZWdfcmluZzsNCj4gPiArCQlnb3RvIGVycm9yX2Rpc2Fi
bGVfbWNsazsNCj4gPiAgDQo+ID4gIAlyZXQgPSBpaW9fZGV2aWNlX3JlZ2lzdGVyKGluZGlvX2Rl
dik7DQo+ID4gIAlpZiAocmV0KQ0KPiA+IC0JCWdvdG8gZXJyb3JfdW5yZWdfcmluZzsNCj4gPiAr
CQlnb3RvIGVycm9yX2Rpc2FibGVfbWNsazsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAg
DQo+ID4gLWVycm9yX3VucmVnX3Jpbmc6DQo+ID4gLQlpaW9fa2ZpZm9fZnJlZShpbmRpb19kZXYt
PmJ1ZmZlcik7DQo+ID4gIGVycm9yX2Rpc2FibGVfbWNsazoNCj4gPiAgCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShzdC0+bWNsayk7DQo+ID4gIGVycm9yX2Rpc2FibGVfcmVnOg0KPiA+IEBAIC03NzIs
NyArNzU1LDYgQEAgc3RhdGljIGludCBhZDU5MzNfcmVtb3ZlKHN0cnVjdCBpMmNfY2xpZW50ICpj
bGllbnQpDQo+ID4gIAlzdHJ1Y3QgYWQ1OTMzX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rl
dik7DQo+ID4gIA0KPiA+ICAJaWlvX2RldmljZV91bnJlZ2lzdGVyKGluZGlvX2Rldik7DQo+ID4g
LQlpaW9fa2ZpZm9fZnJlZShpbmRpb19kZXYtPmJ1ZmZlcik7DQo+ID4gIAlyZWd1bGF0b3JfZGlz
YWJsZShzdC0+cmVnKTsNCj4gPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShzdC0+bWNsayk7DQo+
ID4gIA0K
