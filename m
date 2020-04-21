Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD401B1FBB
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 09:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgDUHZF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 03:25:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:64247 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUHZF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Apr 2020 03:25:05 -0400
IronPort-SDR: /X/Aft6/SpRoQTuL0N4mwTkvnzyJrK/TG6Fnk6Vzz1mL+VTQv0k3CzUpGVGigctTFWoTnYZdMM
 S3/QhO2ezGEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 00:25:05 -0700
IronPort-SDR: KzWZwGfjjFV+H5dJytaFfyp3whYIeEPMl40J7HFmm9gR0oP/nuv3lEMDb9a3jsnhocicrDT2P8
 TqFMHfyQC8ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,409,1580803200"; 
   d="scan'208";a="456001158"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2020 00:25:05 -0700
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Apr 2020 00:25:04 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Apr 2020 00:25:04 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.138]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.146]) with mapi id 14.03.0439.000;
 Tue, 21 Apr 2020 15:25:02 +0800
From:   "Xia, Hui" <hui.xia@intel.com>
To:     "Li, Philip" <philip.li@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     lkp <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iio: adc: ti-ads8344: properly byte swap value
Thread-Topic: [PATCH 1/3] iio: adc: ti-ads8344: properly byte swap value
Thread-Index: AQHWFDDmE8xKP+EJp0SuTzhbL03ZEah/O+MAgAPxjzA=
Date:   Tue, 21 Apr 2020 07:25:01 +0000
Message-ID: <2A5F4C9150EECB4DAA6291810D6D61B9745DE89F@shsmsx102.ccr.corp.intel.com>
References: <20200415212257.161238-2-alexandre.belloni@bootlin.com>
 <202004161449.NY5hL54S%lkp@intel.com> <20200416205023.GA437042@piout.net>
 <20200419024948.GK21730@intel.com>
In-Reply-To: <20200419024948.GK21730@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpLCBQaGlsaXAgPHBoaWxp
cC5saUBpbnRlbC5jb20+DQo+U2VudDogMjAyMOW5tDTmnIgxOeaXpSAxMDo1MA0KPlRvOiBBbGV4
YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQo+Q2M6IGxrcCA8
bGtwQGludGVsLmNvbT47IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBrYnVp
bGQtDQo+YWxsQGxpc3RzLjAxLm9yZzsgSGFydG11dCBLbmFhY2sgPGtuYWFjay5oQGdteC5kZT47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPjxsYXJzQG1ldGFmb28uZGU+OyBQZXRlciBNZWVyd2FsZC1T
dGFkbGVyIDxwbWVlcndAcG1lZXJ3Lm5ldD47IEdyZWdvcnkNCj5DTEVNRU5UIDxncmVnb3J5LmNs
ZW1lbnRAYm9vdGxpbi5jb20+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGlpbzogYWRj
OiB0aS1hZHM4MzQ0OiBwcm9wZXJseSBieXRlIHN3YXAgdmFsdWUNCj4NCj5PbiBUaHUsIEFwciAx
NiwgMjAyMCBhdCAxMDo1MDoyM1BNICswMjAwLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90ZToNCj4+
IEhpLA0KPj4NCj4+IE9uIDE2LzA0LzIwMjAgMTQ6MjI6MDMrMDgwMCwga2J1aWxkIHRlc3Qgcm9i
b3Qgd3JvdGU6DQo+PiA+IEhpIEFsZXhhbmRyZSwNCj4+ID4NCj4+ID4gSSBsb3ZlIHlvdXIgcGF0
Y2ghIFlldCBzb21ldGhpbmcgdG8gaW1wcm92ZToNCj4+ID4NCj4+ID4gW2F1dG8gYnVpbGQgdGVz
dCBFUlJPUiBvbiBpaW8vdG9ncmVnXSBbYWxzbyBidWlsZCB0ZXN0IEVSUk9SIG9uDQo+PiA+IHY1
LjctcmMxIG5leHQtMjAyMDA0MTVdIFtpZiB5b3VyIHBhdGNoIGlzIGFwcGxpZWQgdG8gdGhlIHdy
b25nIGdpdA0KPj4gPiB0cmVlLCBwbGVhc2UgZHJvcCB1cyBhIG5vdGUgdG8gaGVscCBpbXByb3Zl
IHRoZSBzeXN0ZW0uIEJUVywgd2UgYWxzbw0KPj4gPiBzdWdnZXN0IHRvIHVzZSAnLS1iYXNlJyBv
cHRpb24gdG8gc3BlY2lmeSB0aGUgYmFzZSB0cmVlIGluIGdpdA0KPj4gPiBmb3JtYXQtcGF0Y2gs
IHBsZWFzZSBzZWUgaHR0cHM6Ly9zdGFja292ZXJmbG93LmNvbS9hLzM3NDA2OTgyXQ0KPj4gPg0K
Pj4gPiB1cmw6ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS8wZGF5LWNpL2xpbnV4L2NvbW1pdHMvQWxl
eGFuZHJlLUJlbGxvbmkvaWlvLWFkYy10aS0NCj5hZHM4MzQ0LWltcHJvdmUtdGhlLWRyaXZlci8y
MDIwMDQxNi0wNzMzNTcNCj4+ID4gYmFzZTogICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC9qaWMyMy9paW8uZ2l0IHRvZ3JlZw0KPj4gPiBjb25maWc6IGM2
eC1hbGx5ZXNjb25maWcgKGF0dGFjaGVkIGFzIC5jb25maWcpDQo+PiA+IGNvbXBpbGVyOiBjNngt
ZWxmLWdjYyAoR0NDKSA5LjMuMA0KPj4gPiByZXByb2R1Y2U6DQo+PiA+ICAgICAgICAgd2dldCBo
dHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vaW50ZWwvbGtwLQ0KPnRlc3RzL21hc3Rl
ci9zYmluL21ha2UuY3Jvc3MgLU8gfi9iaW4vbWFrZS5jcm9zcw0KPj4gPiAgICAgICAgIGNobW9k
ICt4IH4vYmluL21ha2UuY3Jvc3MNCj4+ID4gICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5j
b25maWcgdG8gbGludXggYnVpbGQgdHJlZQ0KPj4gPiAgICAgICAgIENPTVBJTEVSX0lOU1RBTExf
UEFUSD0kSE9NRS8wZGF5IEdDQ19WRVJTSU9OPTkuMy4wDQo+PiA+IG1ha2UuY3Jvc3MgQVJDSD1j
NngNCj4+ID4NCj4+DQo+PiBJIHNwZW50IHNvbWUgdGltZSB0byByZXByb2R1Y2UgYW5kIHRoaXMg
aXMgYWN0dWFsbHkgbm90IHRoYXQgdHJpdmlhbA0KPj4gYmVjYXVzZSB5b3VyIHRvb2xjaGFpbnMg
YXJlIGxpbmtlZCB3aXRoIGxpYmlzbDIyIGFuZCBtb3N0DQo+PiBkaXN0cmlidXRpb25zIHN0aWxs
IHNoaXAgYW4gb2xkZXIgdmVyc2lvbi4gTWF5YmUgeW91IGNhbiBkbyBzb21ldGhpbmcgYWJvdXQg
dGhhdD8NCj5UaGFua3MgZm9yIHRoZSBmZWVkYmFjaywgd2Ugd2lsbCByZXNvbHZlIHRoaXMgdG8g
dXNlIG9sZCB2ZXJzaW9uIGluIGVhcmxpZXN0IHRpbWUuDQpUaGUgY3Jvc3MgdG9vbGNoYWlucyBo
YXMgYmVlbiB1cGRhdGVkIHRvIGxpbmsgd2l0aCBsaWJpc2wxOSB0aGUgc3RhYmxlIHZlcnNpb24u
IFBsZWFzZSByZW1vdmUgdGhlIG9sZCB0b29sY2hhaW4gYW5kIG1ha2UuY3Jvc3MgYWdhaW4uDQpG
ZWVsIGZyZWUgdG8gbGV0IHVzIGtub3cgaWYgc3RpbGwgaGF2ZSBwcm9ibGVtLiBUaGFua3MuDQoN
Cj4NCj4+DQo+PiA+IElmIHlvdSBmaXggdGhlIGlzc3VlLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0
YWcgYXMgYXBwcm9wcmlhdGUNCj4+ID4gUmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxs
a3BAaW50ZWwuY29tPg0KPj4gPg0KPj4gPiBBbGwgZXJyb3JzIChuZXcgb25lcyBwcmVmaXhlZCBi
eSA+Pik6DQo+PiA+DQo+PiA+DQo+PiA+IHZpbSArLzMwMiArOTYgZHJpdmVycy9paW8vYWRjL3Rp
LWFkczgzNDQuYw0KPj4gPg0KPj4gPiAgICAgNzINCj4+ID4gICAgIDczCXN0YXRpYyBpbnQgYWRz
ODM0NF9hZGNfY29udmVyc2lvbihzdHJ1Y3QgYWRzODM0NCAqYWRjLCBpbnQNCj5jaGFubmVsLA0K
Pj4gPiAgICAgNzQJCQkJCSAgYm9vbCBkaWZmZXJlbnRpYWwpDQo+PiA+ICAgICA3NQl7DQo+PiA+
ICAgICA3NgkJc3RydWN0IHNwaV9kZXZpY2UgKnNwaSA9IGFkYy0+c3BpOw0KPj4gPiAgICAgNzcJ
CWludCByZXQ7DQo+PiA+ICAgICA3OAkJdTggYnVmWzNdOw0KPj4gPiAgICAgNzkNCj4+ID4gICAg
IDgwCQlhZGMtPnR4X2J1ZiA9IEFEUzgzNDRfU1RBUlQ7DQo+PiA+ICAgICA4MQkJaWYgKCFkaWZm
ZXJlbnRpYWwpDQo+PiA+ICAgICA4MgkJCWFkYy0+dHhfYnVmIHw9IEFEUzgzNDRfU0lOR0xFX0VO
RDsNCj4+ID4gICAgIDgzCQlhZGMtPnR4X2J1ZiB8PSBBRFM4MzQ0X0NIQU5ORUwoY2hhbm5lbCk7
DQo+PiA+ICAgICA4NAkJYWRjLT50eF9idWYgfD0gQURTODM0NF9DTE9DS19JTlRFUk5BTDsNCj4+
ID4gICAgIDg1DQo+PiA+ICAgICA4NgkJcmV0ID0gc3BpX3dyaXRlKHNwaSwgJmFkYy0+dHhfYnVm
LCAxKTsNCj4+ID4gICAgIDg3CQlpZiAocmV0KQ0KPj4gPiAgICAgODgJCQlyZXR1cm4gcmV0Ow0K
Pj4gPiAgICAgODkNCj4+ID4gICAgIDkwCQl1ZGVsYXkoOSk7DQo+PiA+ICAgICA5MQ0KPj4gPiAg
ICAgOTIJCXJldCA9IHNwaV9yZWFkKHNwaSwgYnVmLCBzaXplb2YoYnVmKSk7DQo+PiA+ICAgICA5
MwkJaWYgKHJldCkNCj4+ID4gICAgIDk0CQkJcmV0dXJuIHJldDsNCj4+ID4gICAgIDk1DQo+PiA+
ICAgPiA5NgkJcmV0dXJuIGJ1ZlswXSA8PCA5IHwgYnVmWzFdIDw8IDEgfMKgYnVmWzJdID4+IDc7
DQo+PiA+ICAgICA5Nwl9DQo+PiA+ICAgICA5OA0KPj4gPg0KPj4NCj4+IEkgdGFrZSBpdCB0aGlz
IGlzIGEgZmFsc2UgcG9zaXRpdmUgYXMgSSBkb24ndCBnZXQgYW55IGVycm9ycyB3aGVuDQo+PiBi
dWlsZGluZyB0aGlzIGRyaXZlciB3aXRoIHRoZSBwcm92aWRlZCB0b29sY2hhaW4uIEhvd2V2ZXIs
IEkgc2VlIGEgZmV3DQo+PiAiaW50ZXJuYWwgY29tcGlsZXIgZXJyb3I6IGluIHByaW9yaXR5LCBh
dCBoYWlmYS1zY2hlZC5jOjE1OTkiDQo+Pg0KPj4gLS0NCj4+IEFsZXhhbmRyZSBCZWxsb25pLCBC
b290bGluDQo+PiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+PiBodHRw
czovL2Jvb3RsaW4uY29tDQo+Pg0K
