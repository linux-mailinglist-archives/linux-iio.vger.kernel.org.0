Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1AEB188F
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 09:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfIMHA1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 03:00:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19488 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbfIMHA0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 03:00:26 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D6mRLJ007587;
        Fri, 13 Sep 2019 03:00:01 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdks5nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 03:00:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXZTp44zZEwx82TBeDDLnfSuffOPZzyXm58zpszLbaEh+lUEOZjNYSg8TZsO4vZcaLtpXlUjL1GBhS/72oIiyLa/RJ0qNc6QZcntWd1m3VYYJtDza2+iywjS9i+7pd6iQWKQGP64JMVfzY9t5qecBecOvbW7or9Fey4joypzb7krXxkCkDPFY8puyHMxFewVPzcpnQIEZl4o+4bjbk1R8nxYiGwx7cwVeq1T8Q/eq3do8KyBr2bvjo3T/9IToPwgf2PWYeFYXZbHzLp87IdeZHGPATPB8edsZzsd3j2Jn7M22Tfp8DJRXT549637URFJrdjyXsUMeRY4tEkjDAth5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULbdTimqQiKqoo3NhwRzs26IuZn3NDoe5nxw3nJOvfQ=;
 b=C7Ku1bpyxnwdtKMJ6xEX65EEuWmHfaELJLzb9Fyq6jQfF4wnQyS9zZnkRw7a4vmoNdSKi3t+BPn2cpOgGE87JEfy48ZYuoH9nqRlM+SBsNfnQlfkwEduTMw8V0U/1vgSAg2bfXcxlIjE/NnmUFm+QRYGSsVBWo4KtsDLnpvyTpmtB1DdLi9lY51+V5sCKBw5AT8ixSry6jSBMtCFc2k2rZ/zkYIUQoqaTEeHkDuAlNHu457u/s1y6oaY7mtYuim49s5Q9Cx5atV3tPr2vXEwKv/+lD9YROjSZcArR8hzcdtqsJ4xNHur2lKtbey1bq7ITG9KU5xsQGa5GYCOgb+QnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULbdTimqQiKqoo3NhwRzs26IuZn3NDoe5nxw3nJOvfQ=;
 b=1mqClNYMBb2HuF8dVDf0E5KeU1FDv2bjtlxZ1o+tOB8UpT8SSXkmyGbu3cuRUDSBmr+Zv8i/pKER0T54W7GkRxgSoQrbMyBEfEwCtvARvx2Z4feGPb+F0Dg6Z720FK3ZHhHx1FeLGzulZZNCYjnudAmuiTvLJOFbdV6L0TUVuXA=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5269.namprd03.prod.outlook.com (20.180.12.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 06:59:59 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.021; Fri, 13 Sep 2019
 06:59:59 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio: ad7949: fix SPI xfer delays
Thread-Topic: [PATCH 3/4] iio: ad7949: fix SPI xfer delays
Thread-Index: AQHVaXh8OMhRTRFePUqeWEVDuQD0yacpYQwA
Date:   Fri, 13 Sep 2019 06:59:59 +0000
Message-ID: <794eb574e4bc9cb4f0b2723d72baeb8f63c07283.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
         <20190912144310.7458-4-andrea.merello@gmail.com>
In-Reply-To: <20190912144310.7458-4-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49b7938e-c0a7-492a-291b-08d73817fe0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5269;
x-ms-traffictypediagnostic: CH2PR03MB5269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5269E92F528B3C51168C2807F9B30@CH2PR03MB5269.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(6486002)(71190400001)(305945005)(118296001)(446003)(14454004)(36756003)(486006)(478600001)(7736002)(476003)(6246003)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(8936002)(53936002)(26005)(8676002)(86362001)(186003)(2616005)(81156014)(3846002)(81166006)(2201001)(6116002)(99286004)(102836004)(4326008)(316002)(256004)(25786009)(5660300002)(11346002)(76176011)(66066001)(14444005)(71200400001)(6506007)(6436002)(110136005)(229853002)(2906002)(2501003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5269;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DtnkC+Qf8WzBV9wPp/aCSfEDWFWoHK+WMc4qTVyzXPEqG6TiUX2OJ5EwMQUkeHu5S0LjYa5fuGlTRTkL4G+Fj7V2KhUCiSYAvHS6qsp556h7dZLEOhgjHRoKzl6YK1f4nv9JaYXIvwLzLBD0pw52c8wgHXK3gbFDQ50C+WTf0H6p6QJ2GiCuQPXsw3Fg8kC+Sf0i8HNz9OrpppdKKx8bToDKreSzkeJzbmpbVeb2qdcFKmOlSDzvgXYBtQdFPSfZSglJlq5/KUFIKaEt1pMANfAlACc2dKu7BamGVxBohjVu3211nSVjDoyq60mOx/GJErAKAJyFJeRi3KP9nosBgojO2iVNhD0PUWXJy17d4bxRSxxSltnyLdAG3OA9G/OtDsa0X9SJkoZeAtS/CTXINcD9nyOPiAO3y2JS+j9WHC8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58DEEADC5E08FC49920B0A5AAB5AC950@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b7938e-c0a7-492a-291b-08d73817fe0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 06:59:59.1322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x40/eiAoZfaUUtGSY1XXqnhHp+tcTE2y2YSdu4n40gIGEX3B/LNMvdC18j2mTOYDpHkYJp9fQLgA3lb0JLEcvlB+tyzlTlTkg02nqaeXeYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5269
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_04:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTEyIGF0IDE2OjQzICswMjAwLCBBbmRyZWEgTWVyZWxsbyB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gVGhlIGRyaXZlciBjYWxscyB1ZGVsYXkoMikgYWZ0ZXIgZWFj
aCBTUEkgeGZlci4gSG93ZXZlciwgYWNjb3JkaW5nIHRvDQo+IHRoZSBzcGVjaWZpY2F0aW9ucywg
dGhlIFNQSSB0aW1pbmcgc2hvdWxkIGJlIGFzIGZvbGxvd3M6DQo+IA0KPiAxLSBUaGUgZW5kIG9m
IFNQSSB4ZmVyIChDTlYvQ1MgcmlzaW5nIGVkZ2UpIGNhdXNlcyB0aGUgZGV2aWNlIHRvIGluaXRp
YXRlDQo+ICAgIHRoZSBjb252ZXJzaW9uIHBoYXNlLCB3aGljaCB0YWtlcyB1cCB0byAyLjJ1Uy4N
Cg0KWWVzLCBidXQgdGhlcmUgZG9lcyBub3Qgc2VlbSB0byBiZSBhIG1pbmltdW0gdGltZSBmb3Ig
Y29udmVyc2lvbi4NCiggMi4yIHVTIGlzIHRoZSBtYXggdmFsdWUgKQ0KDQpUaGlzIGNhbiBiZSBj
b25mdXNpbmcgYSBiaXQgKEkga25vdykuDQpJZiB5b3UgZG8gc2VlIGlzc3VlcyB3aXRoIDIgdVMs
IHdlIGNhbiBwcm9iYWJseSB0cnkgMyB1UyAoKzEgdVMgd2hpY2ggaXMgcm91Z2hseSBoYWxmIHRo
ZSBtYXggdmFsdWUpLg0KVGhvdWdoLCB3ZSBhcmUgYWxyZWFkeSBnYWluaW5nIG1pbiAyMDAgblMg
ZnJvbSB0aGUgZmFjdCB0aGF0IHRoZSBhY3F1aXNpdGlvbiB0aW1lIGlzIDEuOCB1UyBhbmQgdGhl
IGRlbGF5IGlzIDIgdVMuDQoNCkJ1dCBpZiB0aGVyZSBhcmVuJ3QgYW55IHZpc2libGUgaXNzdWVz
LCBJIHdvdWxkIGxlYXZlIDIgdVMuDQpJbmNyZWFzaW5nIHRoaXMgZGVsYXkgY2FuIGFubm95IHBl
b3BsZSB0aGF0IHdvdWxkIGxpa2UgdG8gaGF2ZSBzb21lIHNwZWVkIHdoZW4gcmVhZGluZyBzYW1w
bGVzLg0KSSBrbm93IDEtMiB1UyBpc24ndCBtdWNoIG9mIGEgcGVyZm9ybWFuY2Uga2lsbGVyLCBi
dXQgaWYgdGhlcmUgYXJlbid0IHJlYXNvbnMgdG8gY2hhbmdlIGl0LCBJIHdvdWxkbid0Lg0KDQo+
IA0KPiAyLSBBdCB0aGUgZW5kIG9mIHRoZSBjb252ZXJzaW9uIHBoYXNlLCB0aGUgZGV2aWNlIHN0
YXJ0cyB0aGUgYWNxdWlzaXRpb24NCj4gICAgcGhhc2UgZm9yIHRoZSBuZXh0IGNvbnZlcnNpb24g
YXV0b21hdGljYWxseSAocmVnYXJkbGVzcyB0byB0aGUgc3RhdGUgb2YNCj4gICAgQ05WIHBpbik7
IHRoZSBjb252ZXJzaW9uIHBoYXNlIHNob3VsZCBsYXN0IGF0IGxlYXN0IDEuOCB1Uw0KPiANCj4g
VGhlIHdob2xlIGN5Y2xlIHRpbWluZyBpcyB0aHVzIDR1UyBsb25nLiBUaGUgU1BJIGRhdGEgaXMg
cmVhZCBkdXJpbmcgdGhlDQo+IGFjcXVpc2l0aW9uIHBoYXNlIChSQUMgbW9kZSwgbm8gbmVlZCB0
byB3b3JyeSBhYm91dCAiVGRhdGEiKS4NCj4gDQo+IEluIG9yZGVyIHRvIGJlIGNvbXBsaWFudCB3
cnQgdGhlc2UgdGltaW5nIHNwZWNpZmljYXRpb25zIHdlIHNob3VsZCB3YWl0DQo+IDR1UyBhZnRl
ciBlYWNoIFNQSSB4ZmVyICh0aGF0IGlzIGNvbnNlcnZhdGl2ZSwgYmVjYXVzZSB0aGVyZSBpcyBh
bHNvIHRoZQ0KPiBTUEkgeGZlciBkdXJhdGlvbiBpdHNlbGYgLSB3aGljaCBhdCB0aGUgbWF4aW11
bSBzdXBwb3J0ZWQgY2xvY2sgc2hvdWxkIGJlDQo+IGFib3V0IDMyMG5TKS4NCj4gDQo+IFRoaXMg
cGF0Y2ggZW5sYXJnZXMgdGhlIGRlbGF5IHVwIHRvIDR1UyBhbmQgaXQgYWxzbyByZW1vdmVzIHRo
ZSBleHBsaWNpdA0KPiBjYWxscyB0byB1ZGVsYXkoKSwgcmVseWluZyBvbiBzcGlfdHJhbnNmZXIt
PmRlbGF5X3VzZWNzLg0KPiANCg0KSSBsaWtlIHRoZSBzd2l0Y2ggZnJvbSBleHBsaWNpdCB1ZGVs
YXkoKSB0byBzcGlfdHJhbnNmZXItPmRlbGF5X3VzZWNzLg0KVGhlIGNvZGUgbG9va3MgY2xlYW5l
ci4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgTWVyZWxsbyA8YW5kcmVhLm1lcmVsbG9AZ21h
aWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9hZDc5NDkuYyB8IDEzICsrLS0tLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZDc5NDkuYyBiL2RyaXZlcnMv
aWlvL2FkYy9hZDc5NDkuYw0KPiBpbmRleCA1YzJiMzQ0NmZhNGEuLjI1ZDFlMWIyNDI1NyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkNzk0OS5jDQo+ICsrKyBiL2RyaXZlcnMvaWlv
L2FkYy9hZDc5NDkuYw0KPiBAQCAtNjksNiArNjksNyBAQCBzdGF0aWMgaW50IGFkNzk0OV9zcGlf
d3JpdGVfY2ZnKHN0cnVjdCBhZDc5NDlfYWRjX2NoaXAgKmFkNzk0OV9hZGMsIHUxNiB2YWwsDQo+
ICAJCQkudHhfYnVmID0gJmFkNzk0OV9hZGMtPmJ1ZmZlciwNCj4gIAkJCS5sZW4gPSAyLA0KPiAg
CQkJLmJpdHNfcGVyX3dvcmQgPSBiaXRzX3Blcl93b3JkLA0KPiArCQkJLmRlbGF5X3VzZWNzID0g
NCwNCj4gIAkJfSwNCj4gIAl9Ow0KPiAgDQo+IEBAIC03NywxMSArNzgsNiBAQCBzdGF0aWMgaW50
IGFkNzk0OV9zcGlfd3JpdGVfY2ZnKHN0cnVjdCBhZDc5NDlfYWRjX2NoaXAgKmFkNzk0OV9hZGMs
IHUxNiB2YWwsDQo+ICAJc3BpX21lc3NhZ2VfaW5pdF93aXRoX3RyYW5zZmVycygmbXNnLCB0eCwg
MSk7DQo+ICAJcmV0ID0gc3BpX3N5bmMoYWQ3OTQ5X2FkYy0+c3BpLCAmbXNnKTsNCj4gIA0KPiAt
CS8qDQo+IC0JICogVGhpcyBkZWxheSBpcyB0byBhdm9pZCBhIG5ldyByZXF1ZXN0IGJlZm9yZSB0
aGUgcmVxdWlyZWQgdGltZSB0bw0KPiAtCSAqIHNlbmQgYSBuZXcgY29tbWFuZCB0byB0aGUgZGV2
aWNlDQo+IC0JICovDQo+IC0JdWRlbGF5KDIpOw0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICAN
Cj4gQEAgLTk3LDYgKzkzLDcgQEAgc3RhdGljIGludCBhZDc5NDlfc3BpX3JlYWRfY2hhbm5lbChz
dHJ1Y3QgYWQ3OTQ5X2FkY19jaGlwICphZDc5NDlfYWRjLCBpbnQgKnZhbCwNCj4gIAkJCS5yeF9i
dWYgPSAmYWQ3OTQ5X2FkYy0+YnVmZmVyLA0KPiAgCQkJLmxlbiA9IDIsDQo+ICAJCQkuYml0c19w
ZXJfd29yZCA9IGJpdHNfcGVyX3dvcmQsDQo+ICsJCQkuZGVsYXlfdXNlY3MgPSA0LA0KPiAgCQl9
LA0KPiAgCX07DQo+ICANCj4gQEAgLTExMiwxMiArMTA5LDYgQEAgc3RhdGljIGludCBhZDc5NDlf
c3BpX3JlYWRfY2hhbm5lbChzdHJ1Y3QgYWQ3OTQ5X2FkY19jaGlwICphZDc5NDlfYWRjLCBpbnQg
KnZhbCwNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JLyoNCj4gLQkg
KiBUaGlzIGRlbGF5IGlzIHRvIGF2b2lkIGEgbmV3IHJlcXVlc3QgYmVmb3JlIHRoZSByZXF1aXJl
ZCB0aW1lIHRvDQo+IC0JICogc2VuZCBhIG5ldyBjb21tYW5kIHRvIHRoZSBkZXZpY2UNCj4gLQkg
Ki8NCj4gLQl1ZGVsYXkoMik7DQo+IC0NCj4gIAlhZDc5NDlfYWRjLT5jdXJyZW50X2NoYW5uZWwg
PSBjaGFubmVsOw0KPiAgDQo+ICAJKnZhbCA9IGFkNzk0OV9hZGMtPmJ1ZmZlciAmIG1hc2s7DQo=
