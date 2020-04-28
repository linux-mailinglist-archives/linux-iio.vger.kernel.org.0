Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EBC1BC802
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgD1S2l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 14:28:41 -0400
Received: from ms10.pegatroncorp.com ([192.72.126.90]:57742 "EHLO
        ms9.pegatroncorp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729192AbgD1S2k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 14:28:40 -0400
Received: from pps.filterd (ptwppsf03.pega.corp.pegatron [127.0.0.1])
        by ptwppsf03.pega.corp.pegatron (8.16.0.21/8.16.0.21) with SMTP id 03SIAIxX033230;
        Wed, 29 Apr 2020 02:27:48 +0800
Received: from ptw-ex-hub04.pega.corp.pegatron ([172.18.6.20])
        by ptwppsf03.pega.corp.pegatron with ESMTP id 30nvwmqa7g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 29 Apr 2020 02:27:48 +0800
Received: from PTW-EX-37.PEGA.CORP.PEGATRON ([fe80::5466:11cb:50e:8c0e]) by
 PTW-EX-HUB04.PEGA.CORP.PEGATRON ([fe80::61de:87d8:fb23:fac6%24]) with mapi id
 14.03.0279.002; Wed, 29 Apr 2020 02:27:47 +0800
From:   =?utf-8?B?TGVzbGllIEhzaWEo5aSP6YKm6YCyX1BlZ2F0cm9uKQ==?= 
        <Leslie_Hsia@pegatroncorp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SGVybWVzIEhzaWVoKOisneaXu+WKrV9QZWdhdHJvbik=?= 
        <Hermes_Hsieh@pegatroncorp.com>,
        "jesse.sung@canonical.com" <jesse.sung@canonical.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] subsystem: Amplifier driver for TAS5805M,Texas
 instruments
Thread-Topic: [PATCH] subsystem: Amplifier driver for TAS5805M,Texas
 instruments
Thread-Index: AQHWHVBtGCDb3Z/sSkKJhFF9f0UEJ6iO2ssO
Date:   Tue, 28 Apr 2020 18:27:45 +0000
Message-ID: <C84B7899-1FC4-43CC-9FAE-8FECE09E8D4E@pegatroncorp.com>
References: <754706C925201D4896E92CCAD6B38E4401F0F733E3@PTW-EX-37.PEGA.CORP.PEGATRON>,<20200428113033.GE5677@sirena.org.uk>
In-Reply-To: <20200428113033.GE5677@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgTWFyaywNCg0KWWVzLCBJIGFncmVlIHRoYXQgdGhlIGNvZGUgZGlkbuKAmXQgaW50ZWdyYXRl
IHdpdGggQUxTQSBBUEksDQphbmQgd2Ugb25seSBuZWVkIHRvIGluaXRpYWxpemUgaTJjIHJlZ2lz
dGVycyBkdWUgdG8gbWFrZSB0aGUgYW1wbGlmaWVyIHdvcmtzIHByb3Blcmx5LA0KYW5kIEkgZG8g
ZmluZCB0aGVyZSBpcyBhbHJlYWR5IGFuIGFtcGxpZmllciBkcml2ZXIgaW4gL2RyaXZlcnMvaWlv
L2FtcGxpZmllci8sDQp0aGF04oCZcyB3aHkgSSBzZW50IHRoZSBwYXRjaCB0byBKb25hdGhhbiwN
Ckkgd2FudCB0byBwdXQgdGhpcyBkcml2ZXIgaW50byAvZHJpdmVycy9paW8vYW1wbGlmaWVyLywN
CmJ1dCBoZSB0aG91Z2h0IHRoYXQgdGhpcyBpcyBhbiBhbXBsaWZpZXIgZHJpdmVyLA0KYW5kIHdl
IHNob3VsZCBwdXQgaXQgaW50byAvc291bmQvZG9jL2NvZGVjcy8sDQpzbyB3b3VsZCB5b3UgcGxl
YXNlIGdpdmUgbWUgYW4gYWR2aWNlIGFib3V0IHRoZSBkcml2ZXIgYmVsb25ncyB0byB3aGljaCBz
dWJzeXN0ZW0/DQpKb25hdGhhbiwgd2hhdCBkbyB5b3UgdGhpbms/DQoNCkJlc3QgUmVnYXJkcywN
Ckxlc2xpZQ0KDQo+IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4g5pa8IDIwMjDlubQ0
5pyIMjjml6Ug5LiL5Y2INzozMCDlr6vpgZPvvJoNCj4NCj4g77u/T24gVHVlLCBBcHIgMjgsIDIw
MjAgYXQgMTA6NDM6MThBTSArMDAwMCwgTGVzbGllIEhzaWEo5aSP6YKm6YCyX1BlZ2F0cm9uKSB3
cm90ZToNCj4+ICogICBBdXRob3I6IExlc2xpZSBIc2lhDQo+PiAqICAgQW1wbGlmaWVyIGRyaXZl
ciBmb3IgVEFTNTgwNU0sIGluaXRpYWwgdGhlIGFtcGxpZmllciBhbmQgc2V0IHRoZSBzb3VuZCBw
YXJhbWV0ZXIuDQo+PiAqICAgU2lnbmVkLW9mZi1ieTogTGVzbGllIEhzaWEgPExlc2xpZV9Ic2lh
QHBlZ2F0cm9uY29ycC5jb208bWFpbHRvOkxlc2xpZV9Ic2lhQHBlZ2F0cm9uY29ycC5jb20+Pg0K
Pg0KPiBQbGVhc2UgZm9sbG93IHRoZSBwYXRjaCBzdWJtaXNzaW9uIHByb2Nlc3MgdGhhdCBpcyBk
ZXNjcmliZWQgaW4NCj4gRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5y
c3QgaW4gdGhlIGtlcm5lbCBzb3VyY2UuICBUYWtlDQo+IGEgbG9vayBhdCBvdGhlciBzdWJtaXNz
aW9ucyBvbiB0aGUgbGlzdCBhbmQgZm9sbG93IGEgc2ltaWxhciBwcm9jZXNzLg0KPiBUaGVyZSBh
bHNvIGFwcGVhciB0byBiZSBib3RoIElJTyBhbmQgQVNvQyBkcml2ZXJzIGluIHRoZXJlIHdoaWNo
IGlzIGF0DQo+IGJlc3QgYSBiaXQgd2VpcmQuDQo+DQo+IEhhdmluZyBkb25lIGEgcXVpY2sgc2Nh
biB0aHJvdWdoIHlvdXIgY29kZSBpdCBkb2Vzbid0IGFjdHVhbGx5IHNlZW0gdG8NCj4gaW50ZWdy
YXRlIHdpdGggdGhlIHN1YnN5c3RlbSBhdCBhbGwgKHRoZXJlJ3Mgbm8NCj4gc25kX3NvY19yZWdp
c3Rlcl9jb2RlYygpKQ0KPg0KPiBQbGVhc2Ugc3VibWl0IHBhdGNoZXMgdXNpbmcgc3ViamVjdCBs
aW5lcyByZWZsZWN0aW5nIHRoZSBzdHlsZSBmb3IgdGhlDQo+IHN1YnN5c3RlbSwgdGhpcyBtYWtl
cyBpdCBlYXNpZXIgZm9yIHBlb3BsZSB0byBpZGVudGlmeSByZWxldmFudCBwYXRjaGVzLg0KPiBM
b29rIGF0IHdoYXQgZXhpc3RpbmcgY29tbWl0cyBpbiB0aGUgYXJlYSB5b3UncmUgY2hhbmdpbmcg
YXJlIGRvaW5nIGFuZA0KPiBtYWtlIHN1cmUgeW91ciBzdWJqZWN0IGxpbmVzIHZpc3VhbGx5IHJl
c2VtYmxlIHdoYXQgdGhleSdyZSBkb2luZy4NCj4gVGhlcmUncyBubyBuZWVkIHRvIHJlc3VibWl0
IHRvIGZpeCB0aGlzIGFsb25lLg0KDQoNClRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudCBt
YXkgY29udGFpbiBpbmZvcm1hdGlvbiB0aGF0IGlzIGNvbmZpZGVudGlhbCBvciBwcml2aWxlZ2Vk
LCBhbmQgYXJlIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbCB0byB3aG9tIHRo
aXMgZS1tYWlsIGlzIGFkZHJlc3NlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lw
aWVudCBvciBoYXZlIHJlY2VpdmVkIGl0IGFjY2lkZW50YWxseSwgcGxlYXNlIGltbWVkaWF0ZWx5
IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJlcGx5IGUtbWFpbCBhbmQgZGVzdHJveSBhbGwgY29waWVz
IG9mIHRoaXMgZW1haWwgYW5kIGl0cyBhdHRhY2htZW50LiBQbGVhc2UgYmUgYWR2aXNlZCB0aGF0
IGFueSB1bmF1dGhvcml6ZWQgdXNlLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRpb24gb3IgY29weWlu
ZyBvZiB0aGlzIGVtYWlsIG9yIGl0cyBhdHRhY2htZW50IGlzIHN0cmljdGx5IHByb2hpYml0ZWQu
DQoNCuacrOmbu+WtkOmDteS7tuWPiuWFtumZhOS7tuWPr+iDveWQq+acieapn+WvhuaIluS+neaz
leWPl+eJueauiueuoeWItuS5i+izh+ioiu+8jOWDheS+m+acrOmbu+WtkOmDteS7tuS5i+WPl+aW
h+iAheS9v+eUqOOAguWPsOerr+WmgumdnuacrOmbu+WtkOmDteS7tuS5i+WPl+aWh+iAheaIluiq
pOaUtuacrOmbu+WtkOmDteS7tu+8jOiri+eri+WNs+WbnuimhumDteS7tumAmuefpeWvhOS7tuS6
uu+8jOS4pumKt+avgOacrOmbu+WtkOmDteS7tuS5i+aJgOacieikh+acrOWPiumZhOS7tuOAguS7
u+S9leacque2k+aOiOasiuiAjOS9v+eUqOOAgeaPremcsuOAgeaVo+S9iOaIluikh+ijveacrOmb
u+WtkOmDteS7tuaIluWFtumZhOS7tuS5i+ihjOeCuu+8jOeahuWatOagvOemgeatoiDjgIINCg0K
