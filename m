Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7861DE081
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 08:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEVG6e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 02:58:34 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:9304 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgEVG6d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 02:58:33 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04M6v33p013436;
        Fri, 22 May 2020 02:58:15 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0b-00128a01.pphosted.com with ESMTP id 313ca0yctx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 02:58:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFEVMKeexNs/gB5Bz4FnnmXfOsJdeRd9Y6iyuGc7PzzOI87vvN3j5UofLo98Ceozw5HPQ7KXOZjsZ0QvEOSRTAn2OeMqwymhLrZmVcZ9M2JDla1BusD/bvtY8I60gcKUgifQsmst4C1HpsAMBNYC8IcbkdYz2VvrqZeIJk7qVXokT7nixX164flX6+/rSH+6t7d1srunMwUc8xGjp7pK7+M5t9Ym5jVkh14rdr+wjUsjBPpq3T1MhKv/0B3VaFcKqX6gYIKQV6xDfXR+zoluzN0T8sRv5gCtgL8y1HZXJrlTVTFFMLh4Hgw1J973/eGcCaOOQD7XJenlSEjcBuBbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqpm9cJle8mS8eWU/lzTG0FHehjV7gpIAlftNBMArUI=;
 b=OTIGeHSAJKs/I5ovmbjt68veXlo4itL1nyL5redzJTe+x4ml18E4z5tbFOUs0N3OPDglg4pwaH8WlEQS+IPCnwOhysj479xuDDJEsUAYAk8I7eAl5moxw0UeriHXLgc+UtKa3lvakvOPVKqwUofYBQcvCtKL7aDy0RT8780j0qz7NhFsynKwkotNCZcuztbp+wURrGM445z28M1bH1z1p8rd/uPUPdkfy51WROYhdMkFSJbFcc/kgRNBdVZTbxS1Y+Otvqo4jOtOmp7NW7FUt6KEI0pNfWvu2CEQqTqtV2rzzFwjaw08NNcjE4S2L/l0PbId2nTS+QHm7JqDPdZ4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqpm9cJle8mS8eWU/lzTG0FHehjV7gpIAlftNBMArUI=;
 b=E4FRsdkj78eJc3RCYKFBrKqUvwojTANVuxi2sv8F3XjDW1vG0jv8dLEp9g2aD5ri5Lacz9A3+hNnlsvUXR9j2B+nonDM+cYrGtljCH9VAxy7Fl3kgsgscYiwxphN7NWPL4Sv/IrwoaGh09cDjnjUUNXPPkVjQuCIu13KDe9iVJo=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (20.178.27.206) by
 DM6PR03MB3753.namprd03.prod.outlook.com (20.176.115.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23; Fri, 22 May 2020 06:58:13 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 06:58:13 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "ak@it-klinger.de" <ak@it-klinger.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 0/8] iio: core: wrap IIO device into an iio_dev_opaque
 object
Thread-Topic: [PATCH v2 0/8] iio: core: wrap IIO device into an iio_dev_opaque
 object
Thread-Index: AQHWKfIQtA84O2YmVUKBckGu9/wX+qizuNoA
Date:   Fri, 22 May 2020 06:58:13 +0000
Message-ID: <036bd63f14707d9c99273e334ac21eb68b29ea4c.camel@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200514131710.84201-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37f839b6-f8d6-4563-cc48-08d7fe1d7ef4
x-ms-traffictypediagnostic: DM6PR03MB3753:
x-microsoft-antispam-prvs: <DM6PR03MB3753407AE1D4F4A431D7A153F9B40@DM6PR03MB3753.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HcE+fAwxjhuY85/A5gc2AQkkk5JWOKIxkt2n115Q7pEi5gr7tp5ajZw0lek0WxD3hykOFGPXOnTyr3cMdcSVOd/l9eHiPrRCLUGkXdpzg2bXTxbHbi9DlL64/jGjCDM5PXC+THNgT7ZtZ/MsjnWaOm+mV68PtusCZtN/ugjaixkLvpRD2/jfV6EDkjzzuPKIwwiw1N3oY2EG2oStfXR3oNJEbrye+upvi+v+peFxoiiXDWLrw18Lrv2RdJQ8gYX+fHIkKzhSfurH3bS1ab9ytRXck+TM2bqc6bDdXgpJ6MSBbPO3kufMMhvZDrukTrum
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(39860400002)(396003)(346002)(366004)(6506007)(2616005)(2906002)(186003)(64756008)(66946007)(5660300002)(7416002)(91956017)(76116006)(71200400001)(66446008)(66476007)(66556008)(36756003)(110136005)(478600001)(26005)(316002)(8676002)(8936002)(6512007)(4326008)(86362001)(54906003)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5UAaZcD0DKzZRJ1tvQHK38MmIjjEcdkDlB49XhuKebGdIFT9iHk7Cr/L5Cfa68qNbg523Z9k7inuOQaCa54B/2qWrUDoAKUzi+P1MRymUbV0ZvENlYgneWIPzLvUoRdb3KN80OSZDB++62tFQ6G7XOeM5bgpZ2RURQg5XVOlCcjIDV8Rtr6gcMzdIDCqWkgFsgGvW7LPwK2gT18n0R/RqV5NprPJ51Fdsc37LdhLBAcPKzuk+ZGFjk22EWNwvdWZnAZ3CCqrRxcv4dEZ4ZzdbDl2sGfHl3mlrBTS63AkqIdLpgNqM/lhMKLClMEzImBqGiIrmCWh+p6DNb1bWEDWbFZZjQ//rIUbLh0+yjIsSrtdSzDGaf3B/so9bFVxdzosGh/Cd+tFBK9WkdZijnqTmF89n3zIG+1R3favizmTa8+JeAuFLLSUBxetgQEHipmWlWaDfUvMF8YRBkQntdIqfBzPfFtfuR6v+PofRMH/+ck=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CE88329049E3340AF14D968CD77C921@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f839b6-f8d6-4563-cc48-08d7fe1d7ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 06:58:13.1994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFkIgbBO1xnLeF9DTMRadeGAqT3I+R8cq698FTzovGifEq/KXGc5pKzfgc7JjJJ9ypUaYrvk3QgJZ9N4xQGVaYt9gkBHoDGsdNUONXr7LEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3753
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_02:2020-05-21,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 cotscore=-2147483648 clxscore=1015 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220055
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTE0IGF0IDE2OjE3ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFRoaXMgY2hhbmdlIHN0YXJ0cyB0byBoaWRlIHNvbWUgaW50ZXJuYWwgZmllbGRzIG9m
IHRoZSBJSU8gZGV2aWNlIGludG8NCj4gdGhlIGZyYW1ld29yay4NCj4gDQo+IEJlY2F1c2UgdGhl
IGlpb19wcml2X3RvX2RldigpIHdpbGwgYmUgaGlkZGVuIHNvbWUgcHJlLXdvcmsgaXMgZG9uZSB0
bw0KPiB0cnkgdG8gcmVtb3ZlIGl0IGZyb20gc29tZSBpbnRlcnJ1cHQgaGFuZGxlcnMuDQo+IGlp
b19wcml2X3RvX2RldigpIHdpbGwgYmVjb21lIGEgZnVuY3Rpb24gY2FsbCBhbmQgd29uJ3QgYmUg
ZXhwYW5kYWJsZQ0KPiBpbnRvIHBsYWNlIChhcy1pcyBub3cgYXMgYW4gaW5saW5lIGZ1bmN0aW9u
KS4NCj4gDQoNCkknbGwgZGVmZXIgdGhpcyBzZXJpZXMuDQpBIGNsZWFudXAgb2YgaWlvX3ByaXZf
dG9fZGV2KCkgZG9lc24ndCBsb29rIGxpa2UgYSBiaXQgZGV0b3VyLg0KDQoNCj4gQ2hhbmdlbG9n
IHYxIC0+IHYyOg0KPiAtIGFkZCBwcmUtd29yayBwYXRjaGVzIHRoYXQgcmVtb3ZlIHNvbWUgY2Fs
bHMgdG8gaWlvX3ByaXZfdG9fZGV2KCkgZnJvbQ0KPiAgIGludGVycnVwdCBoYW5kbGVycw0KPiAt
IHJlbmFtZWQgaWlvX2Rldl9wcml2IC0+IGlpb19kZXZfb3BhcXVlDQo+IC0gbW92ZWQgdGhlIGlp
b19kZXZfb3BhcXVlIHRvICdpbmNsdWRlL2xpbnV4L2lpby9paW8tb3BhcXVlLmgnIHRoaXMgd2F5
DQo+ICAgaXQgc2hvdWxkIGJlIHVzYWJsZSBmb3IgZGVidWdnaW5nDQo+IC0gdGhlIGlpb19wcml2
KCkgY2FsbCwgaXMgc3RpbGwgYW4gaW5saW5lIGZ1bmN0aW9uIHRoYXQgcmV0dXJucyBhbg0KPiAg
ICdpbmRpb19kZXYtPnByaXYnIHJlZmVyZW5jZTsgdGhpcyBmaWVsZCBpcyBhZGRlZCB0byAnc3Ry
dWN0IGlpb19kZXYnOw0KPiAgIHRoZSByZWZlcmVuY2UgaXMgY29tcHV0ZWQgaW4gaWlvX2Rldmlj
ZV9hbGxvYygpIGFuZCBzaG91bGQgYmUNCj4gICBjYWNoZWxpbmUgYWxpZ25lZA0KPiAtIHRoZSB0
b19paW9fZGV2X29wYXF1ZSgpIGNvbnRhaW5lciBpcyBpbiB0aGUNCj4gICAnaW5jbHVkZS9saW51
eC9paW8vaWlvLW9wYXF1ZS5oJyBoZWFkZXI7IGl0J3Mgc3RpbGwgaW1wbGVtZW50ZWQgd2l0aA0K
PiAgIHNvbWUgcG9pbnRlciBhcml0aG1ldGljOyBvbmUgaWRlYSB3YXMgdG8gZG8gaXQgdmlhIGFu
DQo+ICAgJ2luZGlvX2Rldi0+b3BhcXVlJyBmaWVsZDsgdGhhdCBtYXkgc3RpbGwgYmUgYW4gb3B0
aW9uaWYgdGhlcmUgYXJlDQo+ICAgc29tZSBvcGluaW9ucyBpbiB0aGF0IGRpcmVjdGlvbg0KPiAN
Cj4gQWxleGFuZHJ1IEFyZGVsZWFuICg4KToNCj4gICBpaW86IHByb3hpbWl0eTogcGluZzogcGFz
cyByZWZlcmVuY2UgdG8gSUlPIGRldmljZSB2aWEgY2FsbC1zdGFjaw0KPiAgIGlpbzogYXQ5MS1z
YW1hNWQyX2FkYzogcGFzcyByZWYgdG8gSUlPIGRldmljZSB2aWEgcGFyYW0gZm9yIGludA0KPiAg
ICAgZnVuY3Rpb24NCj4gICBpaW86IGF0OTFfYWRjOiBwYXNzIHJlZiB0byBJSU8gZGV2aWNlIHZp
YSBwYXJhbSBmb3IgaW50IGZ1bmN0aW9uDQo+ICAgaWlvOiBzdG0zMi1kZnNkbS1hZGM6IHBhc3Mg
aWlvIGRldmljZSBhcyBhcmcgZm9yIHRoZSBpbnRlcnJ1cHQgaGFuZGxlcg0KPiAgIGlpbzogc3Rt
MzItYWRjOiBwYXNzIGlpbyBkZXZpY2UgYXMgYXJnIGZvciB0aGUgaW50ZXJydXB0IGhhbmRsZXIN
Cj4gICBpaW86IGNvcmU6IHdyYXAgSUlPIGRldmljZSBpbnRvIGFuIGlpb19kZXZfb3BhcXVlIG9i
amVjdA0KPiAgIGlpbzogY29yZTogc2ltcGxpZnkgYWxsb2MgYWxpZ25tZW50IGNvZGUNCj4gICBp
aW86IGNvcmU6IG1vdmUgZGVidWdmcyBkYXRhIG9uIHRoZSBwcml2YXRlIGlpbyBkZXYgaW5mbw0K
PiANCj4gIGRyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgfCAgNyArKy0NCj4gIGRy
aXZlcnMvaWlvL2FkYy9hdDkxX2FkYy5jICAgICAgICAgfCAgNSArLQ0KPiAgZHJpdmVycy9paW8v
YWRjL3N0bTMyLWFkYy5jICAgICAgICB8IDEwICsrLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9zdG0z
Mi1kZnNkbS1hZGMuYyAgfCAgNiArLS0NCj4gIGRyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3Jl
LmMgICAgfCA3NSArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvaWlv
L3Byb3hpbWl0eS9waW5nLmMgICAgICAgfCAgNSArLQ0KPiAgaW5jbHVkZS9saW51eC9paW8vaWlv
LW9wYXF1ZS5oICAgICB8IDI3ICsrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L2lpby9paW8u
aCAgICAgICAgICAgIHwgMjQgKysrLS0tLS0tLQ0KPiAgOCBmaWxlcyBjaGFuZ2VkLCA5OSBpbnNl
cnRpb25zKCspLCA2MCBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2xpbnV4L2lpby9paW8tb3BhcXVlLmgNCj4gDQo=
