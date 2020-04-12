Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F461A5F01
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgDLOb2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 10:31:28 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:53710 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgDLOb2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 10:31:28 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03CEQQP2016216;
        Sun, 12 Apr 2020 10:31:15 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7najdtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Apr 2020 10:31:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZiLUxzdrf2maWyhtbjyidgv/xaJj6ZUayFLbDQjf8IdjufgHYS6vO15thZrAu7jmHDs1HTEUJ05DvTvuVywv2DaPxAxSQNW0OvFAs8WhV+8jYG4jCb4cYtox2VkW8ZZnHiuXi47roNoL7FXdnVPm8xv0JKBZApYyyXmbMuH63cD4r8f7Ll05QfoGZyruWGBosrZbSTnUI4FLQIeRis6IhaakMSx8lSoxtwOCo5GGc/bmF+yK4cJmLn+rvGPCoJpZhkT0VfUH3AcVRQ+jPYnbuq58Dc4+okuZfyl5b1yc/DUAXT5YPOxucGECN1THqWlnhFdyTDVBm2DuyyWT+Akiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Nkjvvp/yHPoO81zoCyb/pIShyxZQAV5i2tJ7JBiqYo=;
 b=Xtbb7lc39D5XOWN/BUP2nHZP/FjohgOO3W4C0wz1LQOT5IYWt30a/LXgoJljv4I6K2HHP4CWOxSJp/W34FflMQQK1n3eKKAEvIyV/F1P16moAyI3sUGhEKLU/Zb52r5pdOp0nxBVOMXS3I/dbEZyt57OkgO+KF7xQn/CBP88CBrkdFiAQlB3Wq+cxKUlm3uTXmrnbH/HJzkVx+hrXQ5k9FfdnGM3oVjXHDYZvjVQanyM1i/Br+ePuVLStLqfFUBNnT/cEKPaWg8uq1DP6GUoWsgh3m/Cupmn22hq7Mq5R0AI3BS8rKdxl2Q9DVLxBw0eCCbcatBysQPWe8/CAE3G0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Nkjvvp/yHPoO81zoCyb/pIShyxZQAV5i2tJ7JBiqYo=;
 b=lfDIisaX26AxDPlTKok/QOW6CZ70MAi7WHDQN5S8/U6Mo7XPCtozsaE+PAdaNMd/jcHxBXnREvHghCt+4ltp5b4EjhcRzDtq6y5oPIGQOfYiyu9m9Z23n82zVzIty/8ihpaMUtt4Q2MRWylLYA+taTDnZSYd+rgnZUtf1Ut4Ntg=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5321.namprd03.prod.outlook.com (2603:10b6:5:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Sun, 12 Apr
 2020 14:31:14 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Sun, 12 Apr 2020
 14:31:14 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer: remove null-checks for 'indio_dev->info'
Thread-Topic: [PATCH] iio: buffer: remove null-checks for 'indio_dev->info'
Thread-Index: AQHWDOz/RJyL8IpUDk68pI+wZiSdc6h1gx0AgAASJoA=
Date:   Sun, 12 Apr 2020 14:31:14 +0000
Message-ID: <950bed7e142e7aa1cbd74fe15e560fe7d584af95.camel@analog.com>
References: <20200407145918.6833-1-alexandru.ardelean@analog.com>
         <20200412143008.3fa722a9@archlinux>
In-Reply-To: <20200412143008.3fa722a9@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b4a2278-4667-4c53-71e7-08d7deee2764
x-ms-traffictypediagnostic: DM6PR03MB5321:
x-microsoft-antispam-prvs: <DM6PR03MB5321D3CFEFFE9418968C03A7F9DC0@DM6PR03MB5321.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0371762FE7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(366004)(39850400004)(376002)(346002)(396003)(6506007)(86362001)(6512007)(6486002)(478600001)(6916009)(81156014)(4326008)(186003)(26005)(36756003)(54906003)(316002)(8936002)(64756008)(66476007)(66446008)(66556008)(66946007)(8676002)(76116006)(91956017)(2906002)(2616005)(71200400001)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hJZWX2JtTC8gxgbUvPUS0b13t9OuhTA4HduPAKddX1CTeAcjsdkkubU9PxkMl/3Kiavx0QPbyyUUK0NFQwArEPDxjrvjvC8ymbiw1htjAhuVA0aOWODa7JXt6OE3kf6ZE51sli29sx67d6lKzJgXN321N+wyhpLbTzIpZrjijzs0d7lnaimuj18P9eyNUv4fQMGsvoK63nz6SetHL2L6iB9N8+C8F6/GyDIwdwcpE2eE5ogPjuof6rmrm2kpDO3fBAFThKr4tZlga1NNLnjaXkJWllg2QmoSgN4/9eMCzP2W7+sOkVauYSMfeDgHjghNTpuNQ1VGuPHjY0S3rAVwb/1lKsqNzckgWuYoc3KzOEUxtGGwHdIKSUMFefTaQZKFIr1LXBY0l+hk19nAYAhdbL7/xyhyEgAu+WIMiUgsID/yjqNn5e6TTItQvhP9HtdK
x-ms-exchange-antispam-messagedata: vVqk52vbnzszkegpeQ2yLZZ2dAnLNph3bJuZd0NCQCJ5d/1jVofy5Z2dgmADpkxtL+YVwtI9bgqZTZzGWPbvrmPHhTydILZ6OU0bs0q0W50mbaKPt6zik/qUIzrSPZfk4X7FfucUJbdF0K9bm8cAEA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E89C56DE5885747AA5D5C080D3E0223@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4a2278-4667-4c53-71e7-08d7deee2764
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2020 14:31:14.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWGN59LYZNbxAS9z0y0x6fsx3J+ZFmE+AnkYtEHFC6UvUBZYt7u63Y6iGxBs48cUUrg6ZWEpUUvSiMpJrqqf4mSrabESM8JM4RRZv90enKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5321
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-12_02:2020-04-11,2020-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004120131
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTEyIGF0IDE0OjMwICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIDcgQXByIDIwMjAgMTc6NTk6MTggKzAzMDAN
Cj4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IENoZWNraW5nIGZvciAnaW5kaW9fZGV2LT5pbmZvJyBpcyBhbiBpbXBvc3Np
YmxlIGNvbmRpdGlvbiwgc2luY2UgYW4gSUlPDQo+ID4gZGV2aWNlIHNob3VsZCBOT1QgYmUgYWJs
ZSB0byByZWdpc3RlciB3aXRob3V0IHRoYXQgaW5mb3JtYXRpb24uDQo+ID4gVGhlIGlpb19kZXZp
Y2VfcmVnaXN0ZXIoKSBmdW5jdGlvbiB3b24ndCBhbGxvdyBhbiBJSU8gZGV2aWNlIHRvIHJlZ2lz
dGVyIGlmDQo+ID4gJ2luZGlvX2Rldi0+aW5mbycgaXMgTlVMTC4NCj4gPiANCj4gPiBJZiB0aGF0
IGluZm9ybWF0aW9uIHNvbWVob3cgYmVjb21lcyBOVUxMLCB0aGVuIHdlJ3JlIGxpa2VseSBidXN0
ZWQgYW55d2F5DQo+ID4gYW5kIHdlIHNob3VsZCBjcmFzaCB0aGUgc3lzdGVtLCBpZiB3ZSBoYXZl
bid0IGFscmVhZHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFu
IDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gSSdtIGdsYWQgdGhlcmUgd2FzIGEg
Y29tbWVudCBpbiB0aGVyZSB0byByZW1pbmQgbWUgb2Ygd2hhdCB3YXMgZ29pbmcgb24gaGVyZS4N
Cj4gDQo+IFRoaXMgaXMgdGhlIHJlc3VsdCBvZiBhbiBhbmNpZW50IHNldCBmcm9tIChJIHRoaW5r
KSBMYXJzIGhhcmRlbmluZyBJSU8NCj4gYWdhaW5zdCBmb3JjZWQgcmVtb3ZhbC4NCj4gDQo+IFRo
ZSBpbmRpb19kZXYtPmluZm8gPT0gTlVMTCBpcyBkZWxpYmVyYXRlbHkgc2V0IHRvIHRydWUgYnkg
dGhlIElJTyBjb3JlDQo+IGR1cmluZyBkZXZpY2UgcmVtb3ZlIGluIG9yZGVyIHRvIGRlYWwgd2l0
aCBhbnkgaW5mbGlnaHQgZGF0YS4NCj4gDQo+IFJlZmVyZW5jZSBjb3VudGluZyBzaG91bGQgZW5z
dXJlIHRoZSBkZXZpY2UgZG9lc24ndCBnbyBhd2F5IGJ1dCB3ZSBuZWVkDQo+IHRvIGF2b2lkIGFj
dHVhbGx5IGRvaW5nIGFueXRoaW5nIGlmIHRoaXMgb2NjdXJzLiAgVGhhdCBwb2ludGVyIHdhcyBh
DQo+IGNvbnZlbmllbnQgb3B0aW9uIHRvIGF2b2lkIGhhdmluZyB0byBhZGQgYW4gZXhwbGljaXQg
ZmxhZyBvciAnZ29pbmcgYXdheScuDQo+IA0KPiBOb3csIGl0J3MgcG9zc2libGUgd2UgZG9uJ3Qg
bmVlZCB0aGlzIGFueSBtb3JlIGR1ZSB0byBvdGhlciBjaGFuZ2VzIGJ1dA0KPiBJIGNlcnRhaW5s
eSBkb24ndCB3YW50IHRvIHJlbW92ZSBpdCB3aXRob3V0IHRoYXQgYmVpbmcgdmVyeSB0aG9yb3Vn
aGx5DQo+IHZlcmlmaWVkIQ0KPiANCg0KQWdyZWVkLg0KVGhhbmtzIGZvciB0aGUgaW5mby4NCg0K
V2lsbCB0aGluayBhYm91dCB0aGlzIGEgYml0IGxhdGVyLg0KDQpUaGFua3MNCkFsZXgNCg0KDQo+
IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9p
bmR1c3RyaWFsaW8tYnVmZmVyLmMgfCAxOSArLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTggZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIuYyBiL2RyaXZlcnMvaWlv
L2luZHVzdHJpYWxpby0NCj4gPiBidWZmZXIuYw0KPiA+IGluZGV4IGU2ZmExYTRlMTM1ZC4uYzk2
MDcxYmZhZGE4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZm
ZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIuYw0KPiA+IEBA
IC01NCwxMCArNTQsNiBAQCBzdGF0aWMgYm9vbCBpaW9fYnVmZmVyX3JlYWR5KHN0cnVjdCBpaW9f
ZGV2ICppbmRpb19kZXYsDQo+ID4gc3RydWN0IGlpb19idWZmZXIgKmJ1ZiwNCj4gPiAgCXNpemVf
dCBhdmFpbDsNCj4gPiAgCWludCBmbHVzaGVkID0gMDsNCj4gPiAgDQo+ID4gLQkvKiB3YWtldXAg
aWYgdGhlIGRldmljZSB3YXMgdW5yZWdpc3RlcmVkICovDQo+IFRoaXMgY29tbWVudCBtYWtlcyBp
dCBjbGVhciB0aGlzIGlzbid0IGFzICdvYnZpb3VzJyBhcyBpdCBtaWdodCBhdCBmaXJzdCBzZWVt
DQo+IDspDQo+IA0KPiA+IC0JaWYgKCFpbmRpb19kZXYtPmluZm8pDQo+ID4gLQkJcmV0dXJuIHRy
dWU7DQo+ID4gLQ0KPiA+ICAJLyogZHJhaW4gdGhlIGJ1ZmZlciBpZiBpdCB3YXMgZGlzYWJsZWQg
Ki8NCj4gPiAgCWlmICghaWlvX2J1ZmZlcl9pc19hY3RpdmUoYnVmKSkgew0KPiA+ICAJCXRvX3dh
aXQgPSBtaW5fdChzaXplX3QsIHRvX3dhaXQsIDEpOw0KPiA+IEBAIC0xMDksOSArMTA1LDYgQEAg
c3NpemVfdCBpaW9fYnVmZmVyX3JlYWRfb3V0ZXIoc3RydWN0IGZpbGUgKmZpbHAsIGNoYXINCj4g
PiBfX3VzZXIgKmJ1ZiwNCj4gPiAgCXNpemVfdCB0b193YWl0Ow0KPiA+ICAJaW50IHJldCA9IDA7
DQo+ID4gIA0KPiA+IC0JaWYgKCFpbmRpb19kZXYtPmluZm8pDQo+ID4gLQkJcmV0dXJuIC1FTk9E
RVY7DQo+ID4gLQ0KPiA+ICAJaWYgKCFyYiB8fCAhcmItPmFjY2Vzcy0+cmVhZCkNCj4gPiAgCQly
ZXR1cm4gLUVJTlZBTDsNCj4gPiAgDQo+ID4gQEAgLTEzMSwxMSArMTI0LDYgQEAgc3NpemVfdCBp
aW9fYnVmZmVyX3JlYWRfb3V0ZXIoc3RydWN0IGZpbGUgKmZpbHAsIGNoYXINCj4gPiBfX3VzZXIg
KmJ1ZiwNCj4gPiAgDQo+ID4gIAlhZGRfd2FpdF9xdWV1ZSgmcmItPnBvbGxxLCAmd2FpdCk7DQo+
ID4gIAlkbyB7DQo+ID4gLQkJaWYgKCFpbmRpb19kZXYtPmluZm8pIHsNCj4gPiAtCQkJcmV0ID0g
LUVOT0RFVjsNCj4gPiAtCQkJYnJlYWs7DQo+ID4gLQkJfQ0KPiA+IC0NCj4gPiAgCQlpZiAoIWlp
b19idWZmZXJfcmVhZHkoaW5kaW9fZGV2LCByYiwgdG9fd2FpdCwgbiAvIGRhdHVtX3NpemUpKSB7
DQo+ID4gIAkJCWlmIChzaWduYWxfcGVuZGluZyhjdXJyZW50KSkgew0KPiA+ICAJCQkJcmV0ID0g
LUVSRVNUQVJUU1lTOw0KPiA+IEBAIC0xNzEsNyArMTU5LDcgQEAgX19wb2xsX3QgaWlvX2J1ZmZl
cl9wb2xsKHN0cnVjdCBmaWxlICpmaWxwLA0KPiA+ICAJc3RydWN0IGlpb19kZXYgKmluZGlvX2Rl
diA9IGZpbHAtPnByaXZhdGVfZGF0YTsNCj4gPiAgCXN0cnVjdCBpaW9fYnVmZmVyICpyYiA9IGlu
ZGlvX2Rldi0+YnVmZmVyOw0KPiA+ICANCj4gPiAtCWlmICghaW5kaW9fZGV2LT5pbmZvIHx8IHJi
ID09IE5VTEwpDQo+ID4gKwlpZiAocmIgPT0gTlVMTCkNCj4gPiAgCQlyZXR1cm4gMDsNCj4gPiAg
DQo+ID4gIAlwb2xsX3dhaXQoZmlscCwgJnJiLT5wb2xscSwgd2FpdCk7DQo+ID4gQEAgLTExMDAs
MTEgKzEwODgsNiBAQCBpbnQgaWlvX3VwZGF0ZV9idWZmZXJzKHN0cnVjdCBpaW9fZGV2ICppbmRp
b19kZXYsDQo+ID4gIAkJZ290byBvdXRfdW5sb2NrOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCWlm
IChpbmRpb19kZXYtPmluZm8gPT0gTlVMTCkgew0KPiA+IC0JCXJldCA9IC1FTk9ERVY7DQo+ID4g
LQkJZ290byBvdXRfdW5sb2NrOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAgCXJldCA9IF9faWlvX3Vw
ZGF0ZV9idWZmZXJzKGluZGlvX2RldiwgaW5zZXJ0X2J1ZmZlciwgcmVtb3ZlX2J1ZmZlcik7DQo+
ID4gIA0KPiA+ICBvdXRfdW5sb2NrOg0K
