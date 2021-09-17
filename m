Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C9640EEA2
	for <lists+linux-iio@lfdr.de>; Fri, 17 Sep 2021 03:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbhIQBNt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Sep 2021 21:13:49 -0400
Received: from mail-eopbgr1310131.outbound.protection.outlook.com ([40.107.131.131]:37376
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230435AbhIQBNk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 Sep 2021 21:13:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb679cXRvzUCwZbGi+Huz9jVqROisgDBLWhjM6uyvaUJTxvKC7zWvyXLtlneo5wJybIjYi96KKZLYgi1T5ekvNwgDMbKnAZ+m5VvfmQh02MwoIfjjmzsxL2yn4DQZZIAviammd0p+PxTWDyBI/+DXdy8bsX1bNkJb9Sy2c1Iz+tMoExnu4F+s4bGgOfVV6bzGLZDrX1VwBJOQ5zHdkRu+oitt/VASepjxo3u/KVPBRxTyvZbNO0RjgrlGNVntIDkoeO7ZfgV6Un2E6aiZ+vu3a0G4u5SDxbcCSkHtnSqiAUjo9Ta9g5vgLmq47C2yQVOkMjq3BpBjhE8scQ7gdq5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SQUHKh8Dzhm/cwclk+ZhQGB3YQD9w3hjEl3XDb+0/YI=;
 b=e8luKdoZxKzUldZ5MM0k8hBzjKZH7JmUfUruD5/g77tkFOGYEbXsJkH+/d4XHuBcuukKlTM3pq0i1rHWbo4bleMJ9tmiYsTGQ6Ilxnk4jtHf1t20IfmnljrEUjvkEt2oqu5xWuhuKBiL//LRG55+WSEOgZ+q55sZirNqB/5D6+1RuTXBDFh/ij+LBtxOkV/VIjuYJi6PX97aCND2Ki/enWTrToqGOTJscOONDpQ5RSQXEVb3drZDed424OHxWTE6ij1goI+UjjpRkuRwUFMPXuhnkwOnTIQd3VDnj7Y1hmSIheLmfBeZ2Zu2URp5FALpc6gKu3I1jXAu+6UVJYGlsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQUHKh8Dzhm/cwclk+ZhQGB3YQD9w3hjEl3XDb+0/YI=;
 b=K392SVTGjbEWwUOTLpKJHeThyGSJffsVi6ve/ngfxAmFqQs1Xf+S4FixFcXfY9emDCuWlrvEX7F5UosOfeyioIAtu1PgWXdVz1QJY5etPofjyBg3vpC/mb4NP2zMvklTEFYRAk1woJfS8cGzHXUil8rO7M1VYdr8+GhsBv67iB6JxyhaTrZvcGRPFLNzmAiSbu+9dRTmh8s4lXPenn8ghfmjm/4UDw67oY7fzVZVRxGBxAIv8C355R/lgtnJP57kFiO8bHpavDvIEjG4ZjEb7MvoPGTme5TOi724NSFM2SajyqrFtRT592aZLqoHgXJJ1YIKnSpGqnj6cPxW2XYmAw==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB3826.apcprd06.prod.outlook.com (2603:1096:203:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Fri, 17 Sep
 2021 01:12:13 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::8d9e:5d92:ad14:6515]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::8d9e:5d92:ad14:6515%5]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 01:12:13 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v6 07/11] iio: adc: aspeed: Fix the calculate error of clock.
Thread-Topic: [v6 07/11] iio: adc: aspeed: Fix the calculate error of clock.
Thread-Index: AQHXqHQgFRjVWjPurUeUzP9TebODvKun90oA
Date:   Fri, 17 Sep 2021 01:12:13 +0000
Message-ID: <1A7A8472-1AAA-4F51-A9CF-08BF1837F9EB@aspeedtech.com>
References: <20210913075337.19991-1-billy_tsai@aspeedtech.com>
 <20210913075337.19991-8-billy_tsai@aspeedtech.com>
In-Reply-To: <20210913075337.19991-8-billy_tsai@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad7cc8eb-3020-4400-59f2-08d979782e98
x-ms-traffictypediagnostic: HK0PR06MB3826:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB382678434686696F113965AE8BDD9@HK0PR06MB3826.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:254;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I17imtJKZoShe23klYsEvpVKTtKTJl8mVin7bfYoeU6hh8b/cjdYqj6Aj6EKW/NhXqnLvZfIVvs3A5OzHTfM87B2kF1Yfk/9whTvjPYl8r2RA9qXWPLglmyIHNrrBANO25Z7ru3xuqNgRK+QjbF+tSoWHxdMRT7LTzc3Fe5rTwB5Wv4KaIRE7sMQ0XhAu+IaF4f+bUN3l4isDWE8d8rXkRTDFh/0A8UTX9CEm7bXcBe+GtUD46zuk+baQD+pqMQkhQw3Va6bDP1Yc/EpSmkWRiux+7cMwX9Sr+5EYs55Fxpm+VPGj/P7OGIWwWWmaH+hZK3eVvyV9pkos1lfGe41gJYxi4oC9bKcVfr7mEyisb38bzEqo7RVHBba/7/QZvwo0SJkr9SAZ9xElhx0l0EgwfUBIoByPTk0nymy/UKB9tD7x99Nihn5Lgh+L9/6mRHhzxKEU0zc93tW8X9CbVgGwG7xTDKJzsKA+rD51gTngSvsGNIcBexIC7LDpPD6alRJV5klYTe0UXJzJnoC3XTVlb5sWlLLYCDmwGjE77sDNm2DmfezKLk0sqvg3QoI6hefX2hycm03jSM4qX0Q8Qhnh0VQOaV0jlN3LdA7BuiQHtLHA+mzTfvrIZ+hrjLSkhIu19K2PZeY0CwU7G7TygZPmXMFYhPaPRKoVRBwFwBFZno+y6pw44aiQGy7Zle35AKo/fI0Kg6KBb6AvNrZfoT5CNH/LPXiZ7Ij2eFRmfrELu0M9D9gbgD8fePNv5wyuC3/T2NQE8WxZaBU55+MCRwKnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(346002)(136003)(366004)(66446008)(110136005)(316002)(76116006)(26005)(508600001)(66946007)(64756008)(66476007)(921005)(122000001)(66556008)(36756003)(6486002)(8936002)(83380400001)(2616005)(33656002)(38100700002)(86362001)(53546011)(71200400001)(107886003)(186003)(6512007)(6506007)(4326008)(2906002)(7416002)(8676002)(38070700005)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG94YjgvaCtVQjQyRnJ6NkRuZE1xMG5UMnVpQit6MXBybzdET2RTTCtoc0Jq?=
 =?utf-8?B?RWRSVWRPQks4ckJJamZiYy9oeWpJNi9Hb1VjaEtWTjdIOWNMc3NBSzFFblZP?=
 =?utf-8?B?czhEK0lMTEpGT1hxUVBpUTlIM3hRUnEya0tyam92YWFTWHR2YnNJSzQvNTlj?=
 =?utf-8?B?bElhWnlDejVmQWd3Q0FjNldYN2pSaE9qKzJ1SStJRjYxOGZJQVpsaVVrcDVo?=
 =?utf-8?B?ZEFSU1lIcllSQU5SWnlqVVRmWTB4Wmpyb0ZWQjQ3amxxZW1BaEhMako4VkZK?=
 =?utf-8?B?QzYvWSs4YWZCckxEYStaQ1k3NXZvZ3JZNEdXcnduYzVyMnRicDcvTHo2cXhD?=
 =?utf-8?B?QkpSeGZiZmFKWXRaUXFDZThUdmQvYkpRRnVrKzZDT2p5WGUwb1BxamVUOUQx?=
 =?utf-8?B?MURYdmZYYWxDTUpOR2N3L0dmNldkK1lic2pNc3hRTlRGS0JGdjdsb0ZXWURy?=
 =?utf-8?B?S05QNlRab09pM2t6SlpEMjFUV1dBdXRDcHNlWWJMaWJ0OUwyRmpGaVhNZTNq?=
 =?utf-8?B?MHBGOTZUbGZFQlBUc294QjF0Z3NwQ2drYW9hLzcyR2lKVFoxMG4vbW5Hc3lE?=
 =?utf-8?B?d2l3b1JYT29KTDZjKzJETWxCVGJpRUVZQVlqZERJcnNNYkJxMkVEQkdyTjVI?=
 =?utf-8?B?TWpHeDJXck54MDdaVlVHN0h6UkMzempNLzZZN29FeTZEODU0ZVBLZmdsaEw2?=
 =?utf-8?B?aWVqQjJIckRaQitvdm5UbWQ5SmJUOERKdm1uTFNjVXFtZTRJMjNrYWNEbWtu?=
 =?utf-8?B?MlQya1FEZ1RTTklvN2dWOWdKSzV5cWFvKzJMMllOV1QrWGFBYXlsa3Fyc3h6?=
 =?utf-8?B?cUFnbk9OMHRkeGJpYlAySHVuZ3pwQkhIbjhMQVJXcFk1U2JRa2wzMjBoeUlU?=
 =?utf-8?B?NGpTN2FYcWRiRGpDN3BncW9ZN3VsQTAydkVDVHF6VHdtUTcvd3ZYVyszT0du?=
 =?utf-8?B?bERva0hNaG16R3JDUGlCL0FETk5nRm4wWG9lVkpmNXlQa0JtbTIzQ25DNmMv?=
 =?utf-8?B?a2s5bngwU3AzZ0hlZ0FjaXFvRTVTdG9STTVoZjlnVSswQkpDVHpTcUJubUhw?=
 =?utf-8?B?RHdGdFo1TG1keDZ5NERiOVNGTjlRekhXdlFtZzlzV2JxZHlBemZBamdTcHJ5?=
 =?utf-8?B?WlF1TjdvZFVITk1ySHJYNmFDMFpXMTNoZFNDemM1dXNQN2NUQ0dMZ3haOExN?=
 =?utf-8?B?OXRMdXQ2ZnFlcFNFaUcwUi85OHNrT1dPRjdoSXM0ZHhjUWRDS1MxVXBUMkRX?=
 =?utf-8?B?bXZlMDNVdWNhbytTZ1ZydjdwdnAzdjM3OENPU21SUGFZWjB1L2lYRHIxYWR2?=
 =?utf-8?B?RHlQZE1ESFMydU5jbCtNaGJOeHBWTVVIQ09Td2dxd3JZTnBuQUphdXE3SW56?=
 =?utf-8?B?UE1RYXhOMXNKZHNQUnllL01PckZKbnN5blR1UjhrMWhFaUhRZXViT1hwL2x1?=
 =?utf-8?B?NmludFRPbHFQcDEvK25FRWJRQityRFJlcnZ4bzg5TEdlK1pIYTd0Zm9KN2ZS?=
 =?utf-8?B?SW9peWRyd1EwVWM5U0RHYllrUlkxQ3BXUFE1WVArbFFyMVR5WHowN2tlTC91?=
 =?utf-8?B?UlFwditkekJNbUhMamlkZTY3a0FrYkMwb2QzQ1F1eFc0aGNCUGloUWVRL3hC?=
 =?utf-8?B?SFVsdFRlenJnWDBLN3dWMWphOTV6ZDdFUW9sRjhWcGRiYjNNdXNteUNKRTNH?=
 =?utf-8?B?ZHJGd1I5Nm02OVBwSllaandHYzBhSGoyQkFIQUNSWE9XSTNmV3V4a0tWaHhm?=
 =?utf-8?B?SXZBMnEzeFoxb3UzYmhhYW1aUk1kMk00a1lIV1hCQ0VqdkhUd28vc0N0UFox?=
 =?utf-8?B?aVBxTU53NHRnMHgyYnBtUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED73D617192CAE44A6318445BCEEDD2E@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7cc8eb-3020-4400-59f2-08d979782e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 01:12:13.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXXIXLgWuHx1sQvcKxW8ZGhnivlpxpA5xFb7J6QbLglspTRSfovlGQ73MvbXmRZID78/28a/toMvfg9l1MUr90t1AKzfQSByqxDrYzM9XuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3826
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMjAyMS85LzEzLCAzOjUxIFBNLCAiQmlsbHkgVHNhaSIgPGJpbGx5X3RzYWlAYXNwZWVkdGVj
aC5jb20+IHdyb3RlOg0KDQogICAgPiBUaGUgQURDIGNsb2NrIGZvcm11bGEgaXMNCiAgICA+IGFz
dDI0MDAvMjUwMDoNCiAgICA+IEFEQyBjbG9jayBwZXJpb2QgPSBQQ0xLICogMiAqIChBREMwQ1sz
MToxN10gKyAxKSAqIChBREMwQ1s5OjBdICsgMSkNCiAgICA+IGFzdDI2MDA6DQogICAgPiBBREMg
Y2xvY2sgcGVyaW9kID0gUENMSyAqIDIgKiAoQURDMENbMTU6MF0gKyAxKQ0KICAgID4gVGhleSBh
bGwgaGF2ZSBvbmUgZml4ZWQgZGl2aWRlZCAyIGFuZCB0aGUgbGVnYWN5IGRyaXZlciBkaWRuJ3Qg
aGFuZGxlIGl0Lg0KICAgID4gVGhpcyBwYXRjaCByZWdpc3RlciB0aGUgZml4ZWQgZmFjdG9yeSBj
bG9jayBkZXZpY2UgYXMgdGhlIHBhcmVudCBvZiBBREMNCiAgICA+IGNsb2NrIHNjYWxlciB0byBm
aXggdGhpcyBpc3N1ZS4NCg0KICAgID4gU2lnbmVkLW9mZi1ieTogQmlsbHkgVHNhaSA8YmlsbHlf
dHNhaUBhc3BlZWR0ZWNoLmNvbT4NCiAgICA+IC0tLQ0KICAgID4gIGRyaXZlcnMvaWlvL2FkYy9h
c3BlZWRfYWRjLmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAgICA+ICAxIGZp
bGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KDQogICAgPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vYWRjL2FzcGVlZF9hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9hc3BlZWRfYWRjLmMNCiAg
ICA+IGluZGV4IDNlYzRlMWEyZGRkMy4uMjYyYjVmODBjNzI4IDEwMDY0NA0KICAgID4gLS0tIGEv
ZHJpdmVycy9paW8vYWRjL2FzcGVlZF9hZGMuYw0KICAgID4gKysrIGIvZHJpdmVycy9paW8vYWRj
L2FzcGVlZF9hZGMuYw0KICAgID4gQEAgLTQsNiArNCwxMiBAQA0KICAgID4gICAqDQogICAgPiAg
ICogQ29weXJpZ2h0IChDKSAyMDE3IEdvb2dsZSwgSW5jLg0KICAgID4gICAqIENvcHlyaWdodCAo
QykgMjAyMSBBc3BlZWQgVGVjaG5vbG9neSBJbmMuDQogICAgPiArICoNCiAgICA+ICsgKiBBREMg
Y2xvY2sgZm9ybXVsYToNCiAgICA+ICsgKiBBc3QyNDAwL0FzdDI1MDA6DQogICAgPiArICogY2xv
Y2sgcGVyaW9kID0gcGVyaW9kIG9mIFBDTEsgKiAyICogKEFEQzBDWzMxOjE3XSArIDEpICogKEFE
QzBDWzk6MF0gKyAxKQ0KICAgID4gKyAqIEFzdDI2MDA6DQogICAgPiArICogY2xvY2sgcGVyaW9k
ID0gcGVyaW9kIG9mIFBDTEsgKiAyICogKEFEQzBDWzE1OjBdICsgMSkNCiAgICA+ICAgKi8NCg0K
ICAgID4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCiAgICA+IEBAIC04NSw2ICs5MSw3IEBAIHN0
cnVjdCBhc3BlZWRfYWRjX2RhdGEgew0KICAgID4gIAlzdHJ1Y3QgcmVndWxhdG9yCSpyZWd1bGF0
b3I7DQogICAgPiAgCXZvaWQgX19pb21lbQkJKmJhc2U7DQogICAgPiAgCXNwaW5sb2NrX3QJCWNs
a19sb2NrOw0KICAgID4gKwlzdHJ1Y3QgY2xrX2h3CQkqZml4ZWRfZGl2X2NsazsNCiAgICA+ICAJ
c3RydWN0IGNsa19odwkJKmNsa19wcmVzY2FsZXI7DQogICAgPiAgCXN0cnVjdCBjbGtfaHcJCSpj
bGtfc2NhbGVyOw0KICAgID4gIAlzdHJ1Y3QgcmVzZXRfY29udHJvbAkqcnN0Ow0KICAgID4gQEAg
LTE5Nyw2ICsyMDQsMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9faW5mbyBhc3BlZWRfYWRj
X2lpb19pbmZvID0gew0KICAgID4gIAkuZGVidWdmc19yZWdfYWNjZXNzID0gYXNwZWVkX2FkY19y
ZWdfYWNjZXNzLA0KICAgID4gIH07DQogDQogICAgPiArc3RhdGljIHZvaWQgYXNwZWVkX2FkY191
bnJlZ2lzdGVyX2ZpeGVkX2RpdmlkZXIodm9pZCAqZGF0YSkNCiAgICA+ICt7DQogICAgPiArCXN0
cnVjdCBjbGtfaHcgKmNsayA9IGRhdGE7DQogICAgPiArDQogICAgPiArCWNsa19od191bnJlZ2lz
dGVyX2ZpeGVkX2ZhY3RvcihjbGspOw0KICAgID4gK30NCiAgICA+ICsNCiAgICA+ICBzdGF0aWMg
dm9pZCBhc3BlZWRfYWRjX3Jlc2V0X2Fzc2VydCh2b2lkICpkYXRhKQ0KICAgID4gIHsNCiAgICA+
ICAJc3RydWN0IHJlc2V0X2NvbnRyb2wgKnJzdCA9IGRhdGE7DQogICAgPiBAQCAtMzIxLDYgKzMz
NSwxOSBAQCBzdGF0aWMgaW50IGFzcGVlZF9hZGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCiAgICA+ICAJc3Bpbl9sb2NrX2luaXQoJmRhdGEtPmNsa19sb2NrKTsNCiAgICA+
ICAJc25wcmludGYoY2xrX3BhcmVudF9uYW1lLCBBUlJBWV9TSVpFKGNsa19wYXJlbnRfbmFtZSks
ICIlcyIsDQogICAgPiAgCQkgb2ZfY2xrX2dldF9wYXJlbnRfbmFtZShwZGV2LT5kZXYub2Zfbm9k
ZSwgMCkpOw0KICAgID4gKwlzbnByaW50ZihjbGtfbmFtZSwgQVJSQVlfU0laRShjbGtfbmFtZSks
ICIlcy1maXhlZC1kaXYiLA0KICAgID4gKwkJIGRhdGEtPm1vZGVsX2RhdGEtPm1vZGVsX25hbWUp
Ow0KICAgID4gKwlkYXRhLT5maXhlZF9kaXZfY2xrID0gY2xrX2h3X3JlZ2lzdGVyX2ZpeGVkX2Zh
Y3RvcigNCiAgICA+ICsJCSZwZGV2LT5kZXYsIGNsa19uYW1lLCBjbGtfcGFyZW50X25hbWUsIDAs
IDEsIDIpOw0KICAgID4gKwlpZiAoSVNfRVJSKGRhdGEtPmZpeGVkX2Rpdl9jbGspKQ0KICAgID4g
KwkJcmV0dXJuIFBUUl9FUlIoZGF0YS0+Zml4ZWRfZGl2X2Nsayk7DQogICAgPiArDQogICAgPiAr
CXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkYXRhLT5kZXYsDQogICAgPiArCQkJCSAg
ICAgICBhc3BlZWRfYWRjX3VucmVnaXN0ZXJfZml4ZWRfZGl2aWRlciwNCiAgICA+ICsJCQkJICAg
ICAgIGRhdGEtPmNsa19wcmVzY2FsZXIpOw0KDQpJIGZvdW5kIHRoYXQgdGhlIHBhcmFtZXRlciBh
c3BlZWRfYWRjX3VucmVnaXN0ZXJfZml4ZWRfZGl2aWRlciBpcyB3cm9uZy4NCkkgd2lsbCBzZW5k
IHBhdGNoIHY3IGFmdGVyIHRoZSBvdGhlciBwYXRjaGVzIGFyZSByZXZpZXdlZC4NCg0KVGhhbmtz
DQoNCiAgICA+ICsJaWYgKHJldCkNCiAgICA+ICsJCXJldHVybiByZXQ7DQogICAgPiArCXNucHJp
bnRmKGNsa19wYXJlbnRfbmFtZSwgQVJSQVlfU0laRShjbGtfcGFyZW50X25hbWUpLCBjbGtfbmFt
ZSk7DQoNCiAgICA+ICAJaWYgKGRhdGEtPm1vZGVsX2RhdGEtPm5lZWRfcHJlc2NhbGVyKSB7DQog
ICAgPiAgCQlzbnByaW50ZihjbGtfbmFtZSwgQVJSQVlfU0laRShjbGtfbmFtZSksICIlcy1wcmVz
Y2FsZXIiLA0KICAgID4gLS0gDQogICAgPiAyLjI1LjENCg0K
