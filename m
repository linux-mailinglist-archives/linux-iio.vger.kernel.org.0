Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7109F1C530A
	for <lists+linux-iio@lfdr.de>; Tue,  5 May 2020 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgEEKW1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 06:22:27 -0400
Received: from ms8.pegatroncorp.com ([43.251.62.78]:36486 "EHLO
        ms8.pegatroncorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEKW0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2020 06:22:26 -0400
Received: from pps.filterd (ptwppsf02.pega.corp.pegatron [127.0.0.1])
        by ptwppsf02.pega.corp.pegatron (8.16.0.21/8.16.0.21) with SMTP id 045AKpDc062936;
        Tue, 5 May 2020 18:21:42 +0800
Received: from ptw-ex-cas12.pega.corp.pegatron ([172.18.6.20])
        by ptwppsf02.pega.corp.pegatron with ESMTP id 30u560gbd2-1
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 05 May 2020 18:21:42 +0800
Received: from PTW-EX-38.PEGA.CORP.PEGATRON ([fe80::c52b:4934:6819:9fa]) by
 PTW-EX-CAS12.PEGA.CORP.PEGATRON ([::1]) with mapi id 14.03.0487.000; Tue, 5
 May 2020 18:21:42 +0800
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
Subject: =?utf-8?B?5Zue5pS2OiBbUEFUQ0hdIEFTb0M6IHRhczU4MDVtOiBBZGQgVEFTNTgwNU0g?=
 =?utf-8?Q?amplifier_driver?=
Thread-Topic: [PATCH] ASoC: tas5805m: Add TAS5805M amplifier driver
Thread-Index: AdYixvf4D4BtzZxFTY+hYGcvSoPNIA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 5 May 2020 10:21:41 +0000
Message-ID: <754706C925201D4896E92CCAD6B38E4401F0F7B915@PTW-EX-38.PEGA.CORP.PEGATRON>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.192.178.208]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

TGVzbGllIEhzaWEo5aSP6YKm6YCyX1BlZ2F0cm9uKSDluIzmnJvlm57mlLbpgJnlsIHpg7Xku7Yg
W1tQQVRDSF0gQVNvQzogdGFzNTgwNW06IEFkZCBUQVM1ODA1TSBhbXBsaWZpZXIgZHJpdmVyXeOA
gg0KDQoNClRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudCBtYXkgY29udGFpbiBpbmZvcm1h
dGlvbiB0aGF0IGlzIGNvbmZpZGVudGlhbCBvciBwcml2aWxlZ2VkLCBhbmQgYXJlIHNvbGVseSBm
b3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbCB0byB3aG9tIHRoaXMgZS1tYWlsIGlzIGFkZHJl
c3NlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvciBoYXZlIHJlY2Vp
dmVkIGl0IGFjY2lkZW50YWxseSwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUgc2VuZGVy
IGJ5IHJlcGx5IGUtbWFpbCBhbmQgZGVzdHJveSBhbGwgY29waWVzIG9mIHRoaXMgZW1haWwgYW5k
IGl0cyBhdHRhY2htZW50LiBQbGVhc2UgYmUgYWR2aXNlZCB0aGF0IGFueSB1bmF1dGhvcml6ZWQg
dXNlLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRpb24gb3IgY29weWluZyBvZiB0aGlzIGVtYWlsIG9y
IGl0cyBhdHRhY2htZW50IGlzIHN0cmljdGx5IHByb2hpYml0ZWQuDQoNCuacrOmbu+WtkOmDteS7
tuWPiuWFtumZhOS7tuWPr+iDveWQq+acieapn+WvhuaIluS+neazleWPl+eJueauiueuoeWItuS5
i+izh+ioiu+8jOWDheS+m+acrOmbu+WtkOmDteS7tuS5i+WPl+aWh+iAheS9v+eUqOOAguWPsOer
r+WmgumdnuacrOmbu+WtkOmDteS7tuS5i+WPl+aWh+iAheaIluiqpOaUtuacrOmbu+WtkOmDteS7
tu+8jOiri+eri+WNs+WbnuimhumDteS7tumAmuefpeWvhOS7tuS6uu+8jOS4pumKt+avgOacrOmb
u+WtkOmDteS7tuS5i+aJgOacieikh+acrOWPiumZhOS7tuOAguS7u+S9leacque2k+aOiOasiuiA
jOS9v+eUqOOAgeaPremcsuOAgeaVo+S9iOaIluikh+ijveacrOmbu+WtkOmDteS7tuaIluWFtumZ
hOS7tuS5i+ihjOeCuu+8jOeahuWatOagvOemgeatoiDjgIINCg0K
