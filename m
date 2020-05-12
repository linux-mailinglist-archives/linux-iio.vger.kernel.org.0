Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5EA1CED00
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgELG1M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 02:27:12 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:36866 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgELG1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 02:27:11 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04C6QMkq018035;
        Tue, 12 May 2020 02:26:57 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0b-00128a01.pphosted.com with ESMTP id 30wp9b7ajh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 02:26:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAVY7bAfb3JJjfs0NEWR29N1G+Ck+TvQW+y4Uv/LBL3JDrThY2Nwof1AWFruLuoBclXR+p35c1VMZvKakUkze3iCPYVNEk6FDSeut9TfY50T77eKi/y5UK4YRhn4XlpGnMUxNJ4ocZC9gQQKtwsBtrqNpI6ZvyafzPb8zrO67YqPe4esEy2lbiv3fIsTsI3xoht5KJ7oCu9oDR6YggmKXkX84rStOSo0t8Y9oKIzOWb2rLVZEQR2/lyFbk04l/VUSR+3jxvl7FZAdkuu8NBngEqddKqMRCwwjM9hOQ60P9drt7wxMQ6zkPjcrFQEE1XW0LdRXpjLFT2oOejWbG7icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZV1uAzsaJCsoCSrKPy//fPAEpgDXkzEAXyyiLWd2PE=;
 b=kq9wuGT7EHa7wEQDgmy7WeGR/fQqo6OvIalbq4V+B+Y4YAFVDOjyAYxyhtgntIQCOJG7CoFGSLpaML8QFGZUJUJAxkBBwxbY+kKaeAdw+KbXXFbKbdBZhOJQnLoheJZEQjlpfkEgshYQ3x3V0TlV9/JT+i6ieya7svQo3Ba7WtLgeD4f5PIFWs04sFgrSGQDaCi2fcUD+lz6CWE5gOwFnfDu1+aBOEQPTJ44z4OxUQJBFQaOxdd+W8rWbK4x56/2DD6ysEMiTGuAaV7L67eIBYZDFdxubll1IL330alW0+D5cOlOj29dKyfpavtqa/PO7pToZ+iMm/cJdo4R2P3R3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZV1uAzsaJCsoCSrKPy//fPAEpgDXkzEAXyyiLWd2PE=;
 b=MYE/XtP8WcAmXeJqI18fFkGRR1ZeUTKyYdTCcnhysqLQi8hwdRDIe75Eu7/ZJ5FW4o0QG+ZJzF9MRMiygLb5azbQaAOcHQc93NVbYWf27N4EI3lJkj3ndta/bnHxhSz8zurDQY/PVl6bB9ZY5PKgTa0C5oomesC/uFECpFNtXx4=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4267.namprd03.prod.outlook.com (2603:10b6:5:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 06:26:54 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 06:26:54 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Thread-Topic: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Thread-Index: AQHWJUAdPxP6vzcVf0GdP2M4m7Jctaifc8QAgAGoDQCAAZjjAIAAAUIAgAAoyACAAAXVAIAACUqAgAAQVwCAAFPeAIAAsBSA
Date:   Tue, 12 May 2020 06:26:54 +0000
Message-ID: <a85270a78093c78cf90d7503f1652da66b6dd28b.camel@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
         <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
         <20200510110958.29046a18@archlinux>
         <8c5d9ef5ed4ea9037c5459daa2044d1cd7c5db7a.camel@analog.com>
         <c88b17c3-a9d6-e755-04e8-bc9f225e2a3b@metafoo.de>
         <554fe46f0cdd1cafb313f534c0edd93f5686b806.camel@analog.com>
         <7d2c8174e345bf8e241d48de65066d2606143503.camel@analog.com>
         <9ae7e69b-f4ce-dd2b-d70b-2aac66b19814@metafoo.de>
         <04fda2eb89244dd2bf8e024d4b4405eceffd016c.camel@analog.com>
         <fb6cc3f4-b133-4ba4-a8fb-84349355ebc3@metafoo.de>
In-Reply-To: <fb6cc3f4-b133-4ba4-a8fb-84349355ebc3@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e551f1e6-1b52-4e3c-2930-08d7f63d76da
x-ms-traffictypediagnostic: DM6PR03MB4267:
x-microsoft-antispam-prvs: <DM6PR03MB42670F96FC915CED0623D83AF9BE0@DM6PR03MB4267.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PKm2XcMCi0kIoGz/4EI9kvbn08v6f5nHtzSjr1TDG8ebQR32gyvlE3yWZ+kciPmlyfZM7+jj/NnsQrxA1u2xV9lmRvY8m7LW9dhVRyfkYhAMXdzAoiIKutxxQFkdvhDG6qzR9XUrBy/E2EVpNQUo72GQrWE4ijVokNB0yddvsYw9l7G9xZ2EEp60Btcbjbdp+IjzHVTLijYEltO6S2K4W2IuZLWcDXvuMAmSCFnXZUEgPaE1R+infZJJilJaNTEF/ESEe30yoczqmJcpi+NcrbxtaYwdNmebdaAvXONMXLdMmiYp06IZ1BD9avGdFUhJAGqFex6db10xTFlgXtz8NuuLXgwJlNrnsdU4b7f2SvSRdz9euAiUOg8evd8L6cs4OqwtWXh6basG0wYI7QCWXOHjiE3jcorbNZmA31PwvgMj6vOQtYh9MCLREXcFLqEK2J7GCoX81mnIorXz/uqRApe48fj3YqUXmCFNydF0zBLukRT3kOmjdMLcFpe7xdkyjdaZ9IOzmOAAei6U16tNKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(33430700001)(6506007)(66446008)(186003)(4326008)(64756008)(53546011)(2616005)(2906002)(26005)(110136005)(66946007)(54906003)(478600001)(71200400001)(66556008)(6486002)(316002)(66476007)(36756003)(33440700001)(8936002)(6512007)(86362001)(76116006)(91956017)(8676002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: G3y5rXGK2n3gXJ8jcAOL1ahWrJkvofbzBAO6WLitEFhL7qns0ztknNKWsADb6MUpu7rczrqupjyBrtmMYn2b9k514HfuDnvWESlN7vriv83AuF2mdUDhjU3YOZ8N9G4L3diTLWD75nYxu6pioD5froma/1cQaKcnTw9dETW3vnFR2sau8omFkGiDjl5TFfBK19G/1lw9QwUS8XmMP8kLTrBaqTXgKnRYJBG0V2ybiWBGSToKzoHfBdcn6AIJ5+5Gu2/w+L973IqzmiPOJvFWcVkBpGN1Oektw+7oTRbo1iT2Qk7MmxsKNauf/NKs79+UzT3d9u3rg8KpL1eguFbvrMTapLT574iYN57obL0uR5gou1WZUQLsYT0inYHbW81y7IoTen2NzLA8xwxklbveVVMSvBlp+JQZcUDA+lOya5l2Hr45N0zXYz7j92uPI3M4Nt9zq6k29RT5tStxicQF747Lg7IiNPF1XJUJmQ5ZPKI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <90A77944340FC041A2294416FFF06353@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e551f1e6-1b52-4e3c-2930-08d7f63d76da
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 06:26:54.1842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t09ntN/IfRFmHRQlKmxPsk8zWzU+XW4pOcZ9V7iI8m14HuMs5lKh10OGXfeJBHji03iP/jFlrlqjUTo9MXyL0tSoK+ZDp/C8FXzE7f7syz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4267
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_01:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120057
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA1LTExIGF0IDIxOjU2ICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDUvMTEvMjAgNDo1NiBQTSwgQXJkZWxlYW4sIEFs
ZXhhbmRydSB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjAtMDUtMTEgYXQgMTU6NTggKzAyMDAsIExh
cnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToNCj4gPiA+IFtFeHRlcm5hbF0NCj4gPiA+IA0KPiA+ID4g
T24gNS8xMS8yMCAzOjI0IFBNLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiA+ID4gPiBP
biBNb24sIDIwMjAtMDUtMTEgYXQgMTM6MDMgKzAwMDAsIEFyZGVsZWFuLCBBbGV4YW5kcnUgd3Jv
dGU6DQo+ID4gPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIE1vbiwg
MjAyMC0wNS0xMSBhdCAxMjozNyArMDIwMCwgTGFycy1QZXRlciBDbGF1c2VuIHdyb3RlOg0KPiA+
ID4gPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPbiA1LzExLzIw
IDEyOjMzIFBNLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBT
dW4sIDIwMjAtMDUtMTAgYXQgMTE6MDkgKzAxMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+
ID4gPiA+ID4gPiA+ID4gW0V4dGVybmFsXQ0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiA+IE9uIFNhdCwgOSBNYXkgMjAyMCAxMDo1MjoxNCArMDIwMA0KPiA+ID4gPiA+ID4gPiA+IExh
cnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gPiA+IE9uIDUvOC8yMCAzOjUzIFBNLCBBbGV4YW5kcnUgQXJkZWxl
YW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+IFsuLi5dDQo+ID4gPiA+ID4gPiA+ID4gPiA+
IFdoYXQgSSBkb24ndCBsaWtlLCBpcyB0aGF0IGlpbzpkZXZpY2UzIGhhcyBpaW86YnVmZmVyMzow
ICh0bw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAzKS4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBp
cyBiZWNhdXNlIHRoZSAnYnVmZmVyLT5kZXYucGFyZW50ID0gJmluZGlvX2Rldi0+ZGV2Jy4NCj4g
PiA+ID4gPiA+ID4gPiA+ID4gQnV0IEkgZG8gZmVlbCB0aGlzIGlzIGNvcnJlY3QuDQo+ID4gPiA+
ID4gPiA+ID4gPiA+IFNvLCBub3cgSSBkb24ndCBrbm93IHdoZXRoZXIgdG8gbGVhdmUgaXQgbGlr
ZSB0aGF0IG9yDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHN5bWxpbmsgdG8NCj4gPiA+ID4gPiA+ID4g
PiA+ID4gc2hvcnRlcg0KPiA+ID4gPiA+ID4gPiA+ID4gPiB2ZXJzaW9ucyBsaWtlICdpaW86YnVm
ZmVyMzpZJyAtPiAnaWlvOmRldmljZTMvYnVmZmVyWScuDQo+ID4gPiA+ID4gPiA+ID4gPiA+IFRo
ZSByZWFzb24gZm9yIG5hbWluZyB0aGUgSUlPIGJ1ZmZlciBkZXZpY2VzIHRvDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ICdpaW86YnVmZmVyWDpZJw0KPiA+ID4gPiA+ID4gPiA+ID4gPiBpcw0KPiA+ID4g
PiA+ID4gPiA+ID4gPiBtb3N0bHkgdG8gbWFrZSB0aGUgbmFtZXMgdW5pcXVlLiBJdCB3b3VsZCBo
YXZlIGxvb2tlZCB3ZWlyZA0KPiA+ID4gPiA+ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+ID4gPiA+
ID4gPiBkbw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAnL2Rldi9idWZmZXIxJyBpZiBJIHdvdWxkIGhh
dmUgbmFtZWQgdGhlIGJ1ZmZlciBkZXZpY2VzDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICdidWZmZXJY
Jy4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+IFNvLCBub3cgSSdt
IHRoaW5raW5nIG9mIHdoZXRoZXIgYWxsIHRoaXMgaXMgYWNjZXB0YWJsZS4NCj4gPiA+ID4gPiA+
ID4gPiA+ID4gT3Igd2hhdCBpcyBhY2NlcHRhYmxlPw0KPiA+ID4gPiA+ID4gPiA+ID4gPiBTaG91
bGQgSSBzeW1saW5rICdpaW86ZGV2aWNlMy9paW86YnVmZmVyMzowJyAtPg0KPiA+ID4gPiA+ID4g
PiA+ID4gPiAnaWlvOmRldmljZTMvYnVmZmVyMCc/DQo+ID4gPiA+ID4gPiA+ID4gPiA+IFdoYXQg
ZWxzZSBzaG91bGQgSSBjb25zaWRlciBtb3ZpbmcgZm9yd2FyZD8NCj4gPiA+ID4gPiA+ID4gPiA+
ID4gV2hhdCBtZWFucyBmb3J3YXJkPw0KPiA+ID4gPiA+ID4gPiA+ID4gPiBXaGVyZSBkaWQgSSBs
ZWF2ZSBteSBiZWVyPw0KPiA+ID4gPiA+ID4gPiA+ID4gTG9va2luZyBhdCBob3cgdGhlIC9kZXYv
IGRldmljZXMgYXJlIG5hbWVkIEkgdGhpbmsgd2UgY2FuDQo+ID4gPiA+ID4gPiA+ID4gPiBwcm92
aWRlDQo+ID4gPiA+ID4gPiA+ID4gPiBhDQo+ID4gPiA+ID4gPiA+ID4gPiBuYW1lDQo+ID4gPiA+
ID4gPiA+ID4gPiB0aGF0IGlzIGRpZmZlcmVudCBmcm9tIHRoZSBkZXZfbmFtZSgpIG9mIHRoZSBk
ZXZpY2UuIEhhdmUgYQ0KPiA+ID4gPiA+ID4gPiA+ID4gbG9vaw0KPiA+ID4gPiA+ID4gPiA+ID4g
YXQNCj4gPiA+ID4gPiA+ID4gPiA+IGRldmljZV9nZXRfZGV2bm9kZSgpIGluIGRyaXZlcnMvYmFz
ZS9jb3JlLmMuIFdlIHNob3VsZCBiZSBhYmxlDQo+ID4gPiA+ID4gPiA+ID4gPiB0bw0KPiA+ID4g
PiA+ID4gPiA+ID4gcHJvdmlkZSB0aGUgbmFtZSBmb3IgdGhlIGNoYXJkZXYgdGhyb3VnaCB0aGUg
ZGV2bm9kZSgpDQo+ID4gPiA+ID4gPiA+ID4gPiBjYWxsYmFjay4NCj4gPiA+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiA+ID4gV2hpbGUgd2UgYXJlIGF0IHRoaXMsIGRvIHdlIHdhbnQgdG8g
bW92ZSB0aGUgbmV3IGRldmljZXMgaW50bw0KPiA+ID4gPiA+ID4gPiA+ID4gYW4NCj4gPiA+ID4g
PiA+ID4gPiA+IGlpbw0KPiA+ID4gPiA+ID4gPiA+ID4gc3ViZm9sZGVyPyBTbyBpaW8vYnVmZmVy
MDowIGluc3RlYWQgb2YgaWlvOmJ1ZmZlcjA6MD8NCj4gPiA+ID4gPiA+ID4gPiBQb3NzaWJseSBv
biB0aGUgZm9sZGVyLiAgSSBjYW4ndCBmb3IgdGhlIGxpZmUgb2YgbWUgcmVtZW1iZXIgd2h5DQo+
ID4gPiA+ID4gPiA+ID4gSQ0KPiA+ID4gPiA+ID4gPiA+IGRlY2lkZWQNCj4gPiA+ID4gPiA+ID4g
PiBub3QgdG8gZG8gdGhhdCB0aGUgZmlyc3QgdGltZSBhcm91bmQgLSBJJ2xsIGxlYXZlIGl0IGF0
IHRoZQ0KPiA+ID4gPiA+ID4gPiA+IG15c3RlcmlvdXMgIml0IG1heSB0dXJuIG91dCB0byBiZSBo
YXJkZXIgdGhhbiB5b3UnZCB0aGluay4uLiINCj4gPiA+ID4gPiA+ID4gPiBIb3BlZnVsbHkgbm90
IDspDQo+ID4gPiA+ID4gPiA+IEkgd2FzIGFsc28gdGhpbmtpbmcgYWJvdXQgdGhlIC9kZXYvaWlv
IHN1YmZvbGRlciB3aGlsZSBkb2luZyB0aGlzLg0KPiA+ID4gPiA+ID4gPiBJIGNhbiBjb3B5IHRo
YXQgZnJvbSAvZGV2L2lucHV0DQo+ID4gPiA+ID4gPiA+IFRoZXkgc2VlbSB0byBkbyBpdCBhbHJl
YWR5Lg0KPiA+ID4gPiA+ID4gPiBJIGRvbid0IGtub3cgaG93IGRpZmZpY3VsdCBpdCB3b3VsZCBi
ZS4gQnV0IGl0IGxvb2tzIGxpa2UgYSBnb29kDQo+ID4gPiA+ID4gPiA+IHByZWNlZGVudC4NCj4g
PiA+ID4gPiA+IEFsbCB5b3UgaGF2ZSB0byBkbyBpcyByZXR1cm4gImlpby8uLi4iIGZyb20gdGhl
IGRldm5vZGUoKSBjYWxsYmFjay4NCj4gPiA+ID4gPiBJIGFkbWl0IEkgZGlkIG5vdCBsb29rIGNs
b3NlbHkgaW50byBkcml2ZXJzL2lucHV0L2lucHV0LmMgYmVmb3JlDQo+ID4gPiA+ID4gbWVudGlv
bmluZw0KPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiBhcyBhcyBnb29kIHByZWNlZGVudC4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBCdXQsIEkgbG9va3MgbGlrZSAvZGV2L2lucHB1dCBpcyBhIGNs
YXNzLg0KPiA+ID4gPiA+IFdoaWxlIElJTyBkZXZpY2VzIGFyZSBhIGJ1c190eXBlIGRldmljZXMu
DQo+ID4gPiA+ID4gU2hvdWxkIHdlIHN0YXJ0IGltcGxlbWVudGluZyBhbiBJSU8gY2xhc3M/IG9y
Pw0KPiA+ID4gPiBXaGF0IEkgc2hvdWxkIGhhdmUgaGlnaGxpZ2h0ZWQgW2JlZm9yZV0gd2l0aCB0
aGlzLCBpcyB0aGF0IHRoZXJlIGlzIG5vDQo+ID4gPiA+IGRldm5vZGUoKQ0KPiA+ID4gPiBjYWxs
YmFjayBmb3IgdGhlIGJ1c190eXBlIFt0eXBlXS4NCj4gPiA+IEJ1dCB0aGVyZSBpcyBvbmUgaW4g
ZGV2aWNlX3R5cGUgOikNCj4gPiBNYW55IHRoYW5rcyA6KQ0KPiA+IFRoYXQgd29ya2VkIG5pY2Vs
eS4NCj4gPiANCj4gPiBJIG5vdyBoYXZlOg0KPiA+IA0KPiA+IHJvb3RAYW5hbG9nOn4jIGxzIC9k
ZXYvaWlvLyoNCj4gPiAvZGV2L2lpby9paW86ZGV2aWNlMCAgL2Rldi9paW8vaWlvOmRldmljZTEN
Cj4gPiANCj4gPiAvZGV2L2lpby9kZXZpY2UzOg0KPiA+IGJ1ZmZlcjAgIGJ1ZmZlcjEgIGJ1ZmZl
cjIgIGJ1ZmZlcjMNCj4gPiANCj4gPiAvZGV2L2lpby9kZXZpY2U0Og0KPiA+IGJ1ZmZlcjANCj4g
PiANCj4gPiANCj4gPiBJdCBsb29rcyBsaWtlIEkgY2FuIHNoaWZ0IHRoZXNlIGFyb3VuZCBhcyBu
ZWVkZWQuDQo+ID4gVGhpcyBpcyBqdXN0IGFuIGV4cGVyaW1lbnQuDQo+ID4gSSBtYW5hZ2VkIHRv
IG1vdmUgdGhlIGlpbyBkZXZpY2VzIHVuZGVyIC9kZXYvaWlvLCB0aG91Z2ggcHJvYmFibHkgdGhl
IElJTw0KPiA+IGRldmljZXMgd2lsbCBzdGlsbCBiZSBhcm91bmQgYXMgL2Rldi9paW86ZGV2aWNl
WCBmb3IgbGVnYWN5IHJlYXNvbnMuDQo+ID4gDQo+ID4gVHdvIHRoaW5ncyByZW1haW4gdW5yZXNv
bHZlZC4NCj4gPiAxLiBUaGUgbmFtZSBvZiB0aGUgSUlPIGJ1ZmZlciBkZXZpY2UuDQo+ID4gDQo+
ID4gcm9vdEBhbmFsb2c6L3N5cy9idXMvaWlvL2RldmljZXMjIGxzIGlpb1w6ZGV2aWNlMy8NCj4g
PiBidWZmZXIgICAgICAgICAgaW5fdm9sdGFnZTBfdGVzdF9tb2RlICAgICAgICAgICBuYW1lDQo+
ID4gZXZlbnRzICAgICAgICAgIGluX3ZvbHRhZ2UxX3Rlc3RfbW9kZSAgICAgICAgICAgb2Zfbm9k
ZQ0KPiA+IGlpbzpidWZmZXI6MzowICBpbl92b2x0YWdlX3NhbXBsaW5nX2ZyZXF1ZW5jeSAgIHBv
d2VyDQo+ID4gaWlvOmJ1ZmZlcjozOjEgIGluX3ZvbHRhZ2Vfc2NhbGUgICAgICAgICAgICAgICAg
c2Nhbl9lbGVtZW50cw0KPiA+IGlpbzpidWZmZXI6MzoyICBpbl92b2x0YWdlX3NjYWxlX2F2YWls
YWJsZSAgICAgIHN1YnN5c3RlbQ0KPiA+IGlpbzpidWZmZXI6MzozICBpbl92b2x0YWdlX3Rlc3Rf
bW9kZV9hdmFpbGFibGUgIHVldmVudA0KPiA+IA0KPiA+IA0KPiA+IFJpZ2h0IG5vdywgZWFjaCBi
dWZmZXIgZGV2aWNlIGlzIG5hbWVkICdpaW86YnVmZmVyOlg6WScuDQo+ID4gT25lIHN1Z2dlc3R0
aW9uIHdhcyAgJ2lpbzpkZXZpY2VYOmJ1ZmZlclknDQo+ID4gSSdtIHN1c3BlY3RpbmcgdGhlIGxh
dHRlciBpcyBwcmVmZXJyZWQgYXMgd2hlbiB5b3Ugc29ydCB0aGUgZm9sZGVycywgYnVmZmVycw0K
PiA+IGNvbWUgcmlnaHQgYWZ0ZXIgdGhlIGlpbzpkZXZpY2VYIGZvbGRlcnMgaW4gL3N5cy9idXMv
aWlvL2RldmljZXMuDQo+ID4gDQo+ID4gSSBkb24ndCBmZWVsIGl0IG1hdHRlcnMgbXVjaCB0aGUg
ZGV2aWNlIG5hbWUgb2YgdGhlIElJTyBidWZmZXIgaWYgd2Ugc3ltbGluaw0KPiA+IGl0DQo+ID4g
dG8gYSBzaG9ydGVyIGZvcm0uDQo+ID4gICANCj4gPiBJJ20gZ3Vlc3NpbmcsIHdlIHN5bWxpbmsg
dGhlc2UgZGV2aWNlcyB0byBzaG9ydC1oYW5kICdidWZmZXJZJyBmb2xkZXJzIGluDQo+ID4gZWFj
aA0KPiA+ICdpaW86ZGV2aWNlWCc/DQo+IA0KPiBJIHRoaW5rIHRoYXQgd291bGQgYmUgYSBiaXQg
ZXhjZXNzaXZlLiBPbmx5IGZvciB0aGUgbGVnYWN5IGJ1ZmZlciB3ZSANCj4gbmVlZCB0byBoYXZl
IGEgc3ltbGluay4NCj4gDQo+ID4gWy4uLl0NCj4gPiAyLiBJIGtub3cgdGhpcyBpcyBbc3RpbGxd
IHN0dXBpZCBub3c7IGJ1dCBhbnkgc3VnZ2VzdGlvbnMgb25lIGhvdyB0byBzeW1saW5rDQo+ID4g
L2Rldi9paW86ZGV2aWNlMyAtPiAvZGV2L2lpby9kZXZpY2UzL2J1ZmZlcjAgPw0KPiA+IA0KPiBE
b2VzIG5vdCBzZWVtIHRvIGJlIHBvc3NpYmxlLiBVc2Vyc3BhY2Ugd2lsbCBoYXZlIHRvIHRha2Ug
Y2FyZSBvZiBpdC4gDQo+IFRoaXMgbWVhbnMgd2UgbmVlZCB0byBrZWVwIGxlZ2FjeSBkZXZpY2Vz
IGluIC9kZXYvIGFuZCBvbmx5IG5ldyBidWZmZXJzIA0KPiBpbiAvZGV2L2lpby8uDQoNCk9uZSB0
aG91Z2h0IGFib3V0IHRoaXMsIHdhcyB0aGF0IHdlIGtlZXAgdGhlIGNoYXJkZXYgZm9yIHRoZSBJ
SU8gZGV2aWNlIGZvcg0KdGhpcy4NCmkuZS4gIC9kZXYvaWlvOmRldmljZVggYW5kIC9kZXYvaWlv
L2RldmljZVgvYnVmZmVyMCBvcGVuIHRoZSBzYW1lIGJ1ZmZlci4NClRoaXMgbWVhbnMgdGhhdCBm
b3IgYSBkZXZpY2Ugd2l0aCA0IGJ1ZmZlcnMsIHlvdSBnZXQgNSBjaGFyZGV2cy4NClRoaXMgYWxz
byBzZWVtcyBhIGJpdCBtdWNoL2V4Y2Vzc2l2ZS4gTWF5YmUgYWxzbyBpbiB0ZXJtcyBvZiBzb3Vy
Y2UtY29kZS4NCkl0IHdvdWxkIGF0IGxlYXN0IG1lYW4gbm90IG1vdmluZyB0aGUgZXZlbnQtb25s
eSBjaGFyZGV2IHRvICdpbmR1c3RyaWFsaW8tDQpldmVudC5jJywgT1IgbW92ZSBpdCwgYW5kIGhh
dmUgdGhlIHNhbWUgY2hhcmRldiBpbiAzIHBsYWNlcyBbJ2luZHVzdHJpYWxpby0NCmV2ZW50LmMn
LCAnaW5kdXN0cmlhbGlvLWJ1ZmZlci5jJyAmICdpbmR1c3RyaWFsaW8tYnVmZmVyLmMnDQoNCk1h
eWJlIHRoaXMgc29ydC1vZiBtYWtlcyBzZW5zZSB0byBoYXZlIGZvciBhIGZldyB5ZWFycy9rZXJu
ZWwtcmV2aXNpb25zIHVudGlsDQp0aGluZ3MgY2xlYW4tdXAuDQoNCkkgZ3Vlc3MgYXQgdGhpcyBw
b2ludCwgdGhlIG1haW50YWluZXIgc2hvdWxkIGhhdmUgdGhlIGZpbmFsIHNheSBhYm91dCB0aGlz
Lg0KDQo+IA0KPiANCg==
