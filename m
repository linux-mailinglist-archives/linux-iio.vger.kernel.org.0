Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D5FEDA07
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 08:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfKDHlD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 02:41:03 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:29506 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727588AbfKDHlC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 02:41:02 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA47bjZx026988;
        Mon, 4 Nov 2019 02:40:46 -0500
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2056.outbound.protection.outlook.com [104.47.32.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a75gv2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 02:40:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFhTKWEATOnVeqY8TF1z+dSHcxdvLUzeIH3BNkoxO5qeo1/9a3qtaHHlvsU6tMr0qghl+smR3mxC0uqrwHxGjURzX4kTQ+5VaOZucHcdHuT+1MJcv0ylru8Fw4muL4frrDvYMVNCssyYm52enonuR1OCMpCIqIOhf2OUNQXfNOsIhSTUfgH/LbycW6tKhxU2qZsqpjKFiCwc6WDKjgxqWmBSZDndN2+YIY9fUIrpYJoNuzegjRDwX5IpOMKwjlm5/bpWpuYzFuJC2P4WwT/bPBkymu6xieMVLSn3AvFlSKGOerlmuaWrLbwAez1X7GM4k8vqFT+7MBIRmkFiDJqO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNEc46IVEvPVtaoUIFvsaGoLzNaO2a8y9C3QCap2zaM=;
 b=Y2XVRtPFlUyHSc6qytTvtwHeBY3lLpP4QdNnQ6bPjN8Xdr8abtIxxqCOssQvk8EKhPTKmoicB5OcBlwLlT/6KFTPbpJEpf1TjTNA5mndsy+3mu4lIKSsj+x74tFifLKTzl2qH6Ugmi8U02sTUH+OoLojOUDSmtb0hTM0dwjxgaf4bBMtPjmBXpBco+Td+jphYrh+AumCCY3ihlZswicyecSJpHg47RX1IxjW/8jS/BP0RLPfvMr91Jv0hvjMbtF91GL9OKlRVhqusfBMzsyGATAQ4x13p0UDJA7sbrNPIJuvXr4h+CkVE1i2ux5SUeHnMdCIwt3imcuYkhilWXJ6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNEc46IVEvPVtaoUIFvsaGoLzNaO2a8y9C3QCap2zaM=;
 b=IEwheArCPNV/eilH7MZG7sncq/bHIPbPnT+QqpSsFOL6cSwuNQFXLSe35PmoitpUdDj0T0uE5Vsi7yc67m4NMcX8lybls4IkIY7OFDIJDy0uNMyNACahJ5iaQYbsEyvrmYHNE1vJ9Fr+Tes++LStOlnhozNt+dan0/KTsgbflL4=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5159.namprd03.prod.outlook.com (20.180.4.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 07:40:45 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 07:40:45 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 02/10] iio: imu: adis16400: check ret val for non-zero vs
 less-than-zero
Thread-Topic: [PATCH 02/10] iio: imu: adis16400: check ret val for non-zero vs
 less-than-zero
Thread-Index: AQHVkJerZ4HZBYrCqkCbSwLt4qTtGqd5P8yAgAFliwA=
Date:   Mon, 4 Nov 2019 07:40:44 +0000
Message-ID: <6f4b3e17865f2f628acb86c84633b813ad85ee69.camel@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
         <20191101093505.9408-3-alexandru.ardelean@analog.com>
         <20191103102145.2ff4e810@archlinux>
In-Reply-To: <20191103102145.2ff4e810@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d17c0e20-ba6c-4ad9-c85c-08d760fa4d45
x-ms-traffictypediagnostic: CH2PR03MB5159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5159C2EE82372093469BB20EF97F0@CH2PR03MB5159.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(186003)(256004)(76176011)(66946007)(305945005)(7736002)(486006)(478600001)(11346002)(446003)(6436002)(476003)(2616005)(26005)(14454004)(86362001)(2906002)(4326008)(81156014)(229853002)(8936002)(14444005)(81166006)(2501003)(8676002)(66066001)(6916009)(66476007)(76116006)(66446008)(64756008)(66556008)(99286004)(2351001)(5660300002)(6486002)(6246003)(5640700003)(102836004)(118296001)(36756003)(3846002)(6506007)(6116002)(6512007)(54906003)(71190400001)(71200400001)(316002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5159;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzsi/B9EoIM6OlMGIBWmFjc3sRZoFvznXbBufncCCbK6lLvLXaDzHiL2XmtlpUY4fzyiyvk7fmV81icIxu9n8U149p8qkAcrmF0OHZVObDETGsFQnHb4e2jc7i1VMrIeCYrt4AC7qFlTUq/Dh6KqhKK8Cs5RPvf1J+wOK1NWf3mMHkcv/u2+sut0D5Q/bp6ucx9gbKDLYrpIfPQ2ojPKaFGookpkVWRQQwtfR0TC1oC95AmwuH54eyO8hMMJEcbKzZ3RZ/tXtKHAQCE8k8qtzUoZ24K2JvWB1QqHAh0k7ZDuJ/K4h9XZkUDGRO/4h2Ha6UVoLe7mm/+CBVF8NkViZjlCf1Rs1Gu8/66ztt/vv80wWWUxLiyoo/JnZhHXcBtxrFN32toTVaxEAuCYZYc6ZtKk7F2M3fxbmsvkRIj8olUYfVCUXhkYIGGRUPJGl4mc
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA3909E6CFA75348852A40E967A8FD94@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17c0e20-ba6c-4ad9-c85c-08d760fa4d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 07:40:44.9270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qh3fLJn9/Hz67wSIu4e2WgGZAjkflFwB0BuYd00T03H7bNqxA7vEHmkcR/k6JHKxGegFhTlxcnx3DnPSr8VmU5Kn59nYdcupBv8t4yKVcvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5159
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_06:2019-11-01,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911040074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTExLTAzIGF0IDEwOjIxICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDEgTm92IDIwMTkgMTE6MzQ6NTcgKzAyMDANCj4gQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoZSBB
RElTIGxpYnJhcnkgZnVuY3Rpb25zIHJldHVybiB6ZXJvIG9uIHN1Y2Nlc3MsIGFuZCBuZWdhdGl2
ZSB2YWx1ZXMNCj4gPiBmb3INCj4gPiBlcnJvci4gUG9zaXRpdmUgdmFsdWVzIGFyZW4ndCByZXR1
cm5lZCwgYnV0IHdlIG9ubHkgY2FyZSBhYm91dCB0aGUNCj4gPiBzdWNjZXNzDQo+ID4gdmFsdWUg
KHdoaWNoIGlzIHplcm8pLg0KPiA+IA0KPiA+IFRoaXMgY2hhbmdlIGlzIG1vc3RseSBuZWVkZWQg
c28gdGhhdCB0aGUgY29tcGlsZXIgd29uJ3QgbWFrZSBhbnkNCj4gPiBpbmZlcmVuY2VzDQo+ID4g
YWJvdXQgc29tZSBhYm91dCB2YWx1ZXMgYmVpbmcgcG90ZW50aWFsbHkgdW4taW5pdGlhbGl6ZWQu
IFRoaXMgb25seQ0KPiA+IHRyaWdnZXJzIGFmdGVyIG1ha2luZyBzb21lIGZ1bmN0aW9ucyBpbmxp
bmUsIGJlY2F1c2UgdGhlIGNvbXBpbGVyIGNhbg0KPiA+IGJldHRlciBmb2xsb3cgcmV0dXJuIHBh
dGhzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFu
ZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IEFwcGxpZWQsDQo+IA0KPiBBbiBvYnNlcnZhdGlv
biB3aGlsc3QgSSB3YXMgbG9va2luZyBhdCB0aGUgZHJpdmVyIHRob3VnaC4uLg0KPiANCj4gSXQg
aGFzIHNvbWUgY2FzZXMgb2YgZ290byBsYWJlbDsgd2hlcmUgdGhlIGxhYmVsIGRvZXNuJ3QgdGhl
biBkbyBhbnl0aGluZw0KPiBpbiAqX2luaXRpYWxfc2V0dXAuICBEaXJlY3QgcmV0dXJucyB3b3Vs
ZCBiZSBhIGJpdCBuZWF0ZXIuDQo+IA0KPiBSZWFsbHkgbWlub3IgcG9pbnQgYnV0IGlmIHlvdSBo
YXBwZW4gdG8gYmUgdG91Y2hpbmcgdGhhdCBkcml2ZXIgYWdhaW4NCj4gc29vbiBuaWNlIHRvIHRp
ZHkgdXAgOykNCg0KQXMgeW91IGNhbiBwcm9iYWJseSBndWVzcywgYSBsb3Qgb2YgY2xlYW51cHMg
d2lsbCBiZSBjb21pbmcgdG8gdGhlIEFESVMNCmZhbWlseSAmIGxpYnJhcnkuDQpTbywgSSdsbCB0
cnkgdG8gaW5jbHVkZSB0aGlzIGludG8gdGhlIG5leHQgY2xlYW51cCBzZXQuDQoNCkknbGwgdHJ5
IHRvIHJlLXNwaW4gdGhlIEFESVMgbG9jayBjbGVhbnVwLg0KV2Ugc3RpbGwgbmVlZCB0byBkbyB0
aGUgZGV2bV8gdmFyaWFudHMgKyByZWxhdGVkIGNsZWFudXAuDQoNClRoYW5rcw0KQWxleA0KDQo+
IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvaWlvL2ltdS9hZGlzMTY0MDAuYyB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDAwLmMgYi9kcml2ZXJzL2lp
by9pbXUvYWRpczE2NDAwLmMNCj4gPiBpbmRleCAwNTc1ZmY3MDZiZDQuLjQ0ZTQ2ZGM5NmUwMCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDAwLmMNCj4gPiArKysgYi9k
cml2ZXJzL2lpby9pbXUvYWRpczE2NDAwLmMNCj4gPiBAQCAtMjE3LDE2ICsyMTcsMTYgQEAgc3Rh
dGljIHNzaXplX3QNCj4gPiBhZGlzMTY0MDBfc2hvd19zZXJpYWxfbnVtYmVyKHN0cnVjdCBmaWxl
ICpmaWxlLA0KPiA+ICAJaW50IHJldDsNCj4gPiAgDQo+ID4gIAlyZXQgPSBhZGlzX3JlYWRfcmVn
XzE2KCZzdC0+YWRpcywgQURJUzE2MzM0X0xPVF9JRDEsICZsb3QxKTsNCj4gPiAtCWlmIChyZXQg
PCAwKQ0KPiA+ICsJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICANCj4gPiAgCXJl
dCA9IGFkaXNfcmVhZF9yZWdfMTYoJnN0LT5hZGlzLCBBRElTMTYzMzRfTE9UX0lEMiwgJmxvdDIp
Ow0KPiA+IC0JaWYgKHJldCA8IDApDQo+ID4gKwlpZiAocmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7
DQo+ID4gIA0KPiA+ICAJcmV0ID0gYWRpc19yZWFkX3JlZ18xNigmc3QtPmFkaXMsIEFESVMxNjMz
NF9TRVJJQUxfTlVNQkVSLA0KPiA+ICAJCQkmc2VyaWFsX251bWJlcik7DQo+ID4gLQlpZiAocmV0
IDwgMCkNCj4gPiArCWlmIChyZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgDQo+ID4gIAls
ZW4gPSBzbnByaW50ZihidWYsIHNpemVvZihidWYpLCAiJS40eC0lLjR4LSUuNHhcbiIsIGxvdDEs
IGxvdDIsDQo+ID4gQEAgLTI0OSw3ICsyNDksNyBAQCBzdGF0aWMgaW50IGFkaXMxNjQwMF9zaG93
X3Byb2R1Y3RfaWQodm9pZCAqYXJnLCB1NjQNCj4gPiAqdmFsKQ0KPiA+ICAJaW50IHJldDsNCj4g
PiAgDQo+ID4gIAlyZXQgPSBhZGlzX3JlYWRfcmVnXzE2KCZzdC0+YWRpcywgQURJUzE2NDAwX1BS
T0RVQ1RfSUQsICZwcm9kX2lkKTsNCj4gPiAtCWlmIChyZXQgPCAwKQ0KPiA+ICsJaWYgKHJldCkN
Cj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICANCj4gPiAgCSp2YWwgPSBwcm9kX2lkOw0KPiA+IEBA
IC0yNjYsNyArMjY2LDcgQEAgc3RhdGljIGludCBhZGlzMTY0MDBfc2hvd19mbGFzaF9jb3VudCh2
b2lkICphcmcsDQo+ID4gdTY0ICp2YWwpDQo+ID4gIAlpbnQgcmV0Ow0KPiA+ICANCj4gPiAgCXJl
dCA9IGFkaXNfcmVhZF9yZWdfMTYoJnN0LT5hZGlzLCBBRElTMTY0MDBfRkxBU0hfQ05ULA0KPiA+
ICZmbGFzaF9jb3VudCk7DQo+ID4gLQlpZiAocmV0IDwgMCkNCj4gPiArCWlmIChyZXQpDQo+ID4g
IAkJcmV0dXJuIHJldDsNCj4gPiAgDQo+ID4gIAkqdmFsID0gZmxhc2hfY291bnQ7DQo+ID4gQEAg
LTMyNyw3ICszMjcsNyBAQCBzdGF0aWMgaW50IGFkaXMxNjMzNF9nZXRfZnJlcShzdHJ1Y3QNCj4g
PiBhZGlzMTY0MDBfc3RhdGUgKnN0KQ0KPiA+ICAJdWludDE2X3QgdDsNCj4gPiAgDQo+ID4gIAly
ZXQgPSBhZGlzX3JlYWRfcmVnXzE2KCZzdC0+YWRpcywgQURJUzE2NDAwX1NNUExfUFJELCAmdCk7
DQo+ID4gLQlpZiAocmV0IDwgMCkNCj4gPiArCWlmIChyZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsN
Cj4gPiAgDQo+ID4gIAl0ID4+PSBBRElTMTYzMzRfUkFURV9ESVZfU0hJRlQ7DQo+ID4gQEAgLTM1
OSw3ICszNTksNyBAQCBzdGF0aWMgaW50IGFkaXMxNjQwMF9nZXRfZnJlcShzdHJ1Y3QNCj4gPiBh
ZGlzMTY0MDBfc3RhdGUgKnN0KQ0KPiA+ICAJdWludDE2X3QgdDsNCj4gPiAgDQo+ID4gIAlyZXQg
PSBhZGlzX3JlYWRfcmVnXzE2KCZzdC0+YWRpcywgQURJUzE2NDAwX1NNUExfUFJELCAmdCk7DQo+
ID4gLQlpZiAocmV0IDwgMCkNCj4gPiArCWlmIChyZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4g
PiAgDQo+ID4gIAlzcHMgPSAodCAmIEFESVMxNjQwMF9TTVBMX1BSRF9USU1FX0JBU0UpID8gNTI4
NTEgOiAxNjM4NDA0Ow0KPiA+IEBAIC00MTYsNyArNDE2LDcgQEAgc3RhdGljIGludCBhZGlzMTY0
MDBfc2V0X2ZpbHRlcihzdHJ1Y3QgaWlvX2Rldg0KPiA+ICppbmRpb19kZXYsIGludCBzcHMsIGlu
dCB2YWwpDQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJcmV0ID0gYWRpc19yZWFkX3JlZ18xNigmc3Qt
PmFkaXMsIEFESVMxNjQwMF9TRU5TX0FWRywgJnZhbDE2KTsNCj4gPiAtCWlmIChyZXQgPCAwKQ0K
PiA+ICsJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICANCj4gPiAgCXJldCA9IGFk
aXNfd3JpdGVfcmVnXzE2KCZzdC0+YWRpcywgQURJUzE2NDAwX1NFTlNfQVZHLA0KPiA+IEBAIC02
MTUsNyArNjE1LDcgQEAgc3RhdGljIGludCBhZGlzMTY0MDBfcmVhZF9yYXcoc3RydWN0IGlpb19k
ZXYNCj4gPiAqaW5kaW9fZGV2LA0KPiA+ICAJCXJldCA9IGFkaXNfcmVhZF9yZWdfMTYoJnN0LT5h
ZGlzLA0KPiA+ICAJCQkJCQlBRElTMTY0MDBfU0VOU19BVkcsDQo+ID4gIAkJCQkJCSZ2YWwxNik7
DQo+ID4gLQkJaWYgKHJldCA8IDApIHsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gIAkJCW11dGV4
X3VubG9jaygmaW5kaW9fZGV2LT5tbG9jayk7DQo+ID4gIAkJCXJldHVybiByZXQ7DQo+ID4gIAkJ
fQ0KPiA+IEBAIC02MjYsMTIgKzYyNiwxMiBAQCBzdGF0aWMgaW50IGFkaXMxNjQwMF9yZWFkX3Jh
dyhzdHJ1Y3QgaWlvX2Rldg0KPiA+ICppbmRpb19kZXYsDQo+ID4gIAkJCSp2YWwyID0gKHJldCAl
IDEwMDApICogMTAwMDsNCj4gPiAgCQl9DQo+ID4gIAkJbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYt
Pm1sb2NrKTsNCj4gPiAtCQlpZiAocmV0IDwgMCkNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICAJCQly
ZXR1cm4gcmV0Ow0KPiA+ICAJCXJldHVybiBJSU9fVkFMX0lOVF9QTFVTX01JQ1JPOw0KPiA+ICAJ
Y2FzZSBJSU9fQ0hBTl9JTkZPX1NBTVBfRlJFUToNCj4gPiAgCQlyZXQgPSBzdC0+dmFyaWFudC0+
Z2V0X2ZyZXEoc3QpOw0KPiA+IC0JCWlmIChyZXQgPCAwKQ0KPiA+ICsJCWlmIChyZXQpDQo+ID4g
IAkJCXJldHVybiByZXQ7DQo+ID4gIAkJKnZhbCA9IHJldCAvIDEwMDA7DQo+ID4gIAkJKnZhbDIg
PSAocmV0ICUgMTAwMCkgKiAxMDAwOw0K
