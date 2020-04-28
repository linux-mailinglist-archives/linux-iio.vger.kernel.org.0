Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64A31BBB4B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 12:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgD1KeL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 06:34:11 -0400
Received: from ms10.pegatroncorp.com ([192.72.126.90]:60666 "EHLO
        ms9.pegatroncorp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726276AbgD1KeL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 06:34:11 -0400
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2020 06:34:10 EDT
Received: from pps.filterd (ptwppsf03.pega.corp.pegatron [127.0.0.1])
        by ptwppsf03.pega.corp.pegatron (8.16.0.21/8.16.0.21) with SMTP id 03SATbeo024161;
        Tue, 28 Apr 2020 18:33:28 +0800
Received: from ptw-ex-cashub15.pega.corp.pegatron ([172.18.6.20])
        by ptwppsf03.pega.corp.pegatron with ESMTP id 30nvwmnqyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 18:33:28 +0800
Received: from PTW-EX-37.PEGA.CORP.PEGATRON ([fe80::5466:11cb:50e:8c0e]) by
 PTW-EX-CASHUB15.PEGA.CORP.PEGATRON ([::1]) with mapi id 14.03.0279.002; Tue,
 28 Apr 2020 18:33:28 +0800
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
Subject: =?utf-8?B?5Zue5pS2OiBbUEFUQ0hdIHN1YnN5c3RlbTogQW1wbGlmaWVyIGRyaXZlciBm?=
 =?utf-8?Q?or_TAS5805M,Texas_instruments?=
Thread-Topic: [PATCH] subsystem: Amplifier driver for TAS5805M,Texas
 instruments
Thread-Index: AdYdSHQUPiejJoGiQP+tgEu7AqbpKA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 17
X-FaxNumberOfPages: 0
Date:   Tue, 28 Apr 2020 10:33:27 +0000
Message-ID: <754706C925201D4896E92CCAD6B38E4401F0F733C0@PTW-EX-37.PEGA.CORP.PEGATRON>
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
W1tQQVRDSF0gc3Vic3lzdGVtOiBBbXBsaWZpZXIgZHJpdmVyIGZvciBUQVM1ODA1TSxUZXhhcyBp
bnN0cnVtZW50c13jgIINCg0KDQpUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnQgbWF5IGNv
bnRhaW4gaW5mb3JtYXRpb24gdGhhdCBpcyBjb25maWRlbnRpYWwgb3IgcHJpdmlsZWdlZCwgYW5k
IGFyZSBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwgdG8gd2hvbSB0aGlzIGUt
bWFpbCBpcyBhZGRyZXNzZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQg
b3IgaGF2ZSByZWNlaXZlZCBpdCBhY2NpZGVudGFsbHksIHBsZWFzZSBpbW1lZGlhdGVseSBub3Rp
ZnkgdGhlIHNlbmRlciBieSByZXBseSBlLW1haWwgYW5kIGRlc3Ryb3kgYWxsIGNvcGllcyBvZiB0
aGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNobWVudC4gUGxlYXNlIGJlIGFkdmlzZWQgdGhhdCBhbnkg
dW5hdXRob3JpemVkIHVzZSwgZGlzY2xvc3VyZSwgZGlzdHJpYnV0aW9uIG9yIGNvcHlpbmcgb2Yg
dGhpcyBlbWFpbCBvciBpdHMgYXR0YWNobWVudCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLg0KDQrm
nKzpm7vlrZDpg7Xku7blj4rlhbbpmYTku7blj6/og73lkKvmnInmqZ/lr4bmiJbkvp3ms5Xlj5fn
ibnmrornrqHliLbkuYvos4foqIrvvIzlg4XkvpvmnKzpm7vlrZDpg7Xku7bkuYvlj5fmlofogIXk
vb/nlKjjgILlj7Dnq6/lpoLpnZ7mnKzpm7vlrZDpg7Xku7bkuYvlj5fmlofogIXmiJboqqTmlLbm
nKzpm7vlrZDpg7Xku7bvvIzoq4vnq4vljbPlm57opobpg7Xku7bpgJrnn6Xlr4Tku7bkurrvvIzk
uKbpirfmr4DmnKzpm7vlrZDpg7Xku7bkuYvmiYDmnInopIfmnKzlj4rpmYTku7bjgILku7vkvZXm
nKrntpPmjojmrIrogIzkvb/nlKjjgIHmj63pnLLjgIHmlaPkvYjmiJbopIfoo73mnKzpm7vlrZDp
g7Xku7bmiJblhbbpmYTku7bkuYvooYzngrrvvIznmoblmrTmoLznpoHmraIg44CCDQoNCg==
