Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C31B18D3
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 09:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfIMHYu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 03:24:50 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28586 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbfIMHYu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 03:24:50 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D7MwZq027707;
        Fri, 13 Sep 2019 03:24:25 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2057.outbound.protection.outlook.com [104.47.40.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdks6p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 03:24:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cROAd5f0vtoUv6fiaMHnPDxdXI0hXmVrCNHzbQTsBelGvtaRN0qPqIjauSnJdDOfrnf2TRYgX3nrgD+v3G1oaLXDkNBmZ6RPVTlhnD9QDuD5Usoxg7n7UyNNyZ1OZPJ/42InrO8xBncBmiGHWPLUuB/JldCudjGqUGXyJ4szkM4hPAzfA/TAs5SrJBtW7JBfIoaVfq80RGzdjTgvIFy8YN0HK2P76fuvLWVuCsqpY2mcykGj2RidubS9pFN+f8hmtsu5Et9xFBs+TAjobGNC/mdJndgbgGDs3Z1l0ni39UFERetAuyMdikM1QmDcvzPjFAGZlLsiG8jDslI0Ve/G6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEGMgEKVYxjpV3+uPwjAM8CpRKV5XYWIDmDO+TdjTGM=;
 b=G3t6pZPvwuXi4ChpnB65G+vJAh6dhRHZREezAstfCl9INV1xfcsFqUhPdCCt4lLanSXp9VkLajgCOu6biVNxI2ysVAxeSz0uM8iWKTMSgue+f9Apeo7PdWKef488HKJ9TZDUiNUcc3L6C3/2wkm9a4s5JxV2CSyQkFHNXHgVI95IuB2AQrNRKllDD94/4NdK7HIdRRr2wS7F77UKwhxMXYy7KAwfIdtBqOKxC2a/xYcpuRPKBr8IHMCzul8LQ2ofdKr6FF7ZfOQl/8oQjzjcqmyHq+RvDWt9PKupuZaOcoFhbu6PuZJGVN5Vsb69kSbuP0K0RCNfEkRderFGUL5Blw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEGMgEKVYxjpV3+uPwjAM8CpRKV5XYWIDmDO+TdjTGM=;
 b=jPEq+h9MfFrOTrBEZPok34OuNHPL5/swpCslT/N6IOKN+CHYbfATfsGvVoH6syDU7jn2eB6SYUbCRB4pXvax2S62IbQtVtJ23+PIHzJ1CfxMOaym5Rek6MPYsDW6T47C05MZxL5dmehiaIP4rSTtQWW1KyjnsXcUJKS9oHuyaaE=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5222.namprd03.prod.outlook.com (20.180.15.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 07:24:23 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.021; Fri, 13 Sep 2019
 07:24:23 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/4] Fixes for ad7949
Thread-Topic: [PATCH 0/4] Fixes for ad7949
Thread-Index: AQHVaXiJvkTPKl6mIkeot7v5rveqP6cpZ9+A
Date:   Fri, 13 Sep 2019 07:24:23 +0000
Message-ID: <1f13820761bbdb4db685a90e9bcf35a388b246cf.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
In-Reply-To: <20190912144310.7458-1-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bae6809-d1de-4f82-74a4-08d7381b66a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5222;
x-ms-traffictypediagnostic: CH2PR03MB5222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5222DC32E1BA6588C8140331F9B30@CH2PR03MB5222.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(51914003)(189003)(199004)(6246003)(2501003)(66066001)(305945005)(2906002)(7736002)(3846002)(6116002)(25786009)(4326008)(66446008)(64756008)(66946007)(66476007)(66556008)(14454004)(76116006)(5660300002)(229853002)(478600001)(36756003)(186003)(476003)(110136005)(11346002)(6436002)(99286004)(2616005)(316002)(6486002)(446003)(8936002)(2201001)(81166006)(86362001)(76176011)(256004)(8676002)(81156014)(6506007)(486006)(26005)(102836004)(53936002)(71200400001)(71190400001)(6512007)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5222;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OPnTsdmnhpE4Fi24LWuSGTOyMkJLnJEldwzT0EqLx775bd94rDFAvWxcduYKO6y0GzKbN13LaVZSa26HtlnAL0z7OeGgNvCCaW8jmuJLn7t41hBim96k30DYkn0Ly1m3/c/+e6ffp4yDNMJ92wceipXepBuKTbckKFwkI5e4Wk2RnEeDMnwAEg1YkR5eHLPW9XUdPsenGfYlhuZa5+ZGOB+py3Pl+NkfM7WQbWx68uoUEHAwnPSvkLCi09wCw/Sq8n9sWP3R7wvnsvuqmsjJTylw+uYTQreuzC5QQbuVRZA3PX2eRvo4wDzjJlgYbCHEwBEIlX27RDAkXHnAuWGwNlWV8S9vTru5SQLtaLkJ7u8aSWrSVkVbbhBO7VO3QvvePJvIStxuaqfDB4T0QmmQHwMEqtq5W8eWg9TIJl4z5uU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12314C3E53D8A5459F55E619D2C1FA25@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bae6809-d1de-4f82-74a4-08d7381b66a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 07:24:23.1387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JFMwg1LPcU83fnJ4NpstP1ydfEnU3LQS9WmmUq56gmXhXtUV5ftFKaK7qMIHK3+We8EM8mho7gr68F8+Zv2YdeLEhw9xP51NuXcV++Zl1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5222
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_04:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=681 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130069
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTEyIGF0IDE2OjQzICswMjAwLCBBbmRyZWEgTWVyZWxsbyB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgZml4ZXMgYWQ3OTQ5IGRyaXZl
ciBpbmNvcnJlY3RseSByZWFkIGRhdGEsIHNpbXBsaWZ5IHRoZQ0KPiBjb2RlLCBhbmQgZW5mb3Jj
ZXMgZGV2aWNlIHRpbWluZyBjb25zdHJhaW50cy4NCj4gDQo+IFRoaXMgaGFzIGJlZW4gdGVzdGVk
IG9uIGEgVWx0cmFaZWQgU09NICsgYSBjdXN0b20gY2FycmllciBlcXVpcHBlZCB3aXRoDQo+IHNl
dmVyYWwgQUQ3Njg5IEEvRHMuIFBhdGNoZXMgaGF2ZSBiZWVuIGRldmVsb3BlZCBvbiBhIFhpbGlu
eCB1cHN0cmVhbQ0KPiBrZXJuZWwgYW5kIHRoZW4gcmViYXNlZCBvbiBsaW51eC1uZXh0IGtlcm5l
bC4NCj4gDQoNCkhleSwNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2hlcy4NCkFkZGVkIENoYXJsZXMt
QW50b2luZSB0byBhbHNvIHRha2UgYSBsb29rLg0KQXBvbG9naWVzIGZvciBub3QgdGhpbmtpbmcg
b2YgYWRkaW5nIGhpbSBzb29uZXIuDQoNCkkgdHlwaWNhbGx5IHRyeSB0byByZXZpZXcgY2hhbmdl
cyBmb3IgQURJIHBhcnRzLCBidXQgaGUgd3JvdGUgaXQsIHNvIGhlIG1heSBoYXZlIG1vcmUgaW5w
dXQgdGhhbiBJIGRvLg0KSm9uYXRoYW4gd2lsbCBsaWtlbHkgYWxzbyB0YWtlIGEgbG9vay4NCg0K
SWYgaXQncyBhZ3JlZWQsIEkgd291bGQgc2F5IHRvIGF0IGxlYXN0IHRha2UgdGhlIGZpcnN0IHBh
dGNoICgiaWlvOiBhZDc5NDk6IGtpbGwgcG9pbnRsZXNzICJyZWFkYmFjayItaGFuZGxpbmcgY29k
ZSIpDQpub3cgYW5kIHNlZSBhYm91dCB0aGUgcmVzdC4NClRoZSByZXN0IGFyZSBhIGJpdCBtb3Jl
IG9wZW4gdG8gZGlzY3Vzc2lvbiwgc28gYSB2MiBtYXkgaGFwcGVuLg0KDQpUaGFua3MNCkFsZXgg
DQoNCj4gQW5kcmVhIE1lcmVsbG8gKDQpOg0KPiAgIGlpbzogYWQ3OTQ5OiBraWxsIHBvaW50bGVz
cyAicmVhZGJhY2siLWhhbmRsaW5nIGNvZGUNCj4gICBpaW86IGFkNzk0OTogZml4IGluY29ycmVj
dCBTUEkgeGZlciBsZW4NCj4gICBpaW86IGFkNzk0OTogZml4IFNQSSB4ZmVyIGRlbGF5cw0KPiAg
IGlpbzogYWQ3OTQ5OiBmaXggY2hhbm5lbHMgbWl4dXBzDQo+IA0KPiAgZHJpdmVycy9paW8vYWRj
L2FkNzk0OS5jIHwgNjQgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gLS0NCj4gMi4xNy4xDQo=
