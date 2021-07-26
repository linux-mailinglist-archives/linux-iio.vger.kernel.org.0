Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0963D5427
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 09:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhGZGlG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 02:41:06 -0400
Received: from mail-eopbgr1310098.outbound.protection.outlook.com ([40.107.131.98]:29024
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231774AbhGZGlF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Jul 2021 02:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsoZfZwXviF6/vYnv6kdndEntGtYpQYHlHMJR1x9GfSoU1KCSgw3590QN3vdxi8FF4wRZS3fU/G22K8XU+VK9rbnvZAqqCLheHmsdbybbW3bFDDNLahdk7yOk1/EHxGefbzn+I/9Jbv/k6y6V9toT43Wak+vmVelv1qMxdyI/VoQVnZJBk/q2vJtYLZ0EQQsphdOBSGZSN2rdZH6kIQ/wt3R3UG/mEQPZ0IrYhsBGwJnyJzLEa0Dkb4v6NROGexLJIeU5SclEZ1a/ZMEtp0fZ+yAHF9hRIMoT1wy/XlHBYmy3Eh5k9tuG92nAvfiGjGJstLbm3ieqvFRHLZUiZJB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHTQIR14x3cgSrTv/tRFfxg/eWHk0jjnQJIzS/Tr3z4=;
 b=DwZUF5bJq/a6HK5iIkQeyjyaWgRo0fwSSypFawRKiAvEiE1FPK/Hb9dtGFLzXAqtI9w2KHO3gytEa5OTCUUDUy4Tjp6uYN1zBOcSGd6rCxUwpNZON8BcKJP60GobtOeJ7OrUbUFkiqB981QIb7f3l4gcxcrmf/1Nnqk6GSScKyYx+VdKOSAcy5bBAsK+Pp7KpaUAkdNEOHw3rz49TA/0B+z/36inFdjduzdadSiYPfaeFmxZrn/yl7miSNJJzm5v58+N7NYu6cjWb1t3T9wrDIcWfRfwuv1f2mg8zMQIUvRLTWs1qAR9tMoz68lR/X+Rzs4JyPW8xpPvXaPJowFDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHTQIR14x3cgSrTv/tRFfxg/eWHk0jjnQJIzS/Tr3z4=;
 b=Z5mxFmvK2vjMtlT7dmBzxWxSUuY9Q+5MmlfJnkSdBf0k54KPHzQHAKBEWL9hlTsGCuO8i9E6qHHxHoALgzk+O/DBJTHkkCnLdUYgtHehTcKlJzmgh6Yh0O+T0YkrDSvTpznBZELroTr5wt6VLIo0Ont9PzlK6sY2I+aAf2CkImvDTyL9/Kaowh0ANqr+9JONUK6JQvn+KQhn/srSU66/1qWNsJ+BXj8N2P+FrthuCAMglSpOFSgbpjRO03E+qN7Tx1tRHCKLF31Dz/l8zIYO+bCbdEkT6eWEhE6+67WhthZAtAnMF6SuIx+2/OkEEBQqMi15Q1nieXMxFyWRvQC2RA==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2514.apcprd06.prod.outlook.com (2603:1096:203:63::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 07:21:29 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27%4]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 07:21:29 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v2 2/8] dt-bindings: iio: adc: Binding ast2600 adc.
Thread-Topic: [v2 2/8] dt-bindings: iio: adc: Binding ast2600 adc.
Thread-Index: AQHXf5rvPcPGvGefq0qulT4TGT2ZratQpUiAgAS/UQA=
Date:   Mon, 26 Jul 2021 07:21:29 +0000
Message-ID: <8D93D26B-AE57-4E38-A1AD-FA62894F2947@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
 <20210723081621.29477-3-billy_tsai@aspeedtech.com>
 <20210723155141.000039ee@Huawei.com>
In-Reply-To: <20210723155141.000039ee@Huawei.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e43e27fb-1174-4d2c-c5cc-08d95005fc9c
x-ms-traffictypediagnostic: HK0PR06MB2514:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2514A6FFB7FDF4CC67E848B48BE89@HK0PR06MB2514.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlouHvUiGHBFQXqrg3DQLdDPZaIxP0fvBLr4rSkqBVMSwglgrsRH848my2+3muX89sIYzHsZvgQk4t52T0eUaGo16oOQuRy6qTk7KcKz0MIkjuM23tS2OfTqK79tX3nsBMB4OhKA8lLTN0kgEya6m+0A3K0pObVlipXcVYFilcpCkfPMU+3Xuuw/GKY3L3u9BPk8rPD5hCeJWQnA2s823dgz2p5usjKcH/sMVMlgXKoDvHa2DlT4daxOFlXDGAMNcYv5EHP8+5AYBpHoaogvJOd2h4zHpLLKKSJpasE/yBPXjLmPAj1PM0+zteaeZo9fZnjV83adjlPjDkZhQ9zgLfPD2IbkXtYUSlWOYOuj5lR7tSWmg9018IOTem209qdG1nQXQwo7OFn8ViGq22xHptIHayKoOyPWzQnbxTWQpcTA35e7LBqBrZ/RiO6u2sx9vOFvyydpTYhPl1WgpwPMzQ6IAiBMY0xV78b7lrgqYYOnR2Hcg/h8qbTs8aOx2DwH+8kv8BXunryVhAvrkTYAT25F9oGttm5yKoqEw/dkqZeqUB/VK98FbTiiYt47/vVjh2HSZzZgaaEC2bFtYXhE8yLbyNDN5u/DEVU3Qdxkoi6b4UGZMXhmfpz34VVM7sc45VsDyhVarBbSNYq7NnxV3KOxqNLuqYxtTjtoIpnuiANdU0d9BvJxYXZoVtfCsvQ5KpSymesc+v8klYwiC27IpLeQzQGb2lCsvgEQpKYPvS1uLTiT80KeWyqjAAJgVt82
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39840400004)(376002)(346002)(71200400001)(38100700002)(6512007)(2906002)(26005)(8936002)(8676002)(122000001)(6486002)(508600001)(6506007)(186003)(55236004)(7416002)(107886003)(64756008)(66556008)(66446008)(5660300002)(36756003)(66476007)(66946007)(86362001)(2616005)(53546011)(4326008)(6916009)(54906003)(76116006)(316002)(33656002)(45980500001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzBvcGVDMFJxam9sdlRxZGtuV2NXeXZQczRocHNEZWZXS0ZHTzhsS0VaSFNx?=
 =?utf-8?B?OWM2dWh2RVl1bllOekF0WFZTOGVZdUxUbDJ2cExHSkhUTFRxK255M1JzSEov?=
 =?utf-8?B?Z0NpYkVEdUhWRzZKY200dklnSy9MUEpkenpGS2Zxa2VBckxKVHluUitWRkJY?=
 =?utf-8?B?N1pQNkZXYk9FNWMwVzZkaGtqU2ZTUGtRVzk2K0pkMDh4c2hGOFBVYm9BdFpj?=
 =?utf-8?B?cHBoQUJ2UzJNMFRiTnphZXU0UFRSSXFhUWFZRXFFZFJRcW96aEQyZlF4V25H?=
 =?utf-8?B?ZXM0NWk3UXhBVFkwQlBzbFJLYW45NHYrMEpqMC9pcEMwUU5vd0p4NzlBeDlD?=
 =?utf-8?B?UmpEeHVjOFhLSTF0ZTRYUnNCaGxXV2Z2RERlSDV1djBFWnV6RDYyMk42MFJT?=
 =?utf-8?B?QVNtem00TjhmdHBaOWhhU3BCZGkzSG5oL20zTFk5UW5pYUUrYWNDSVQ2R3gz?=
 =?utf-8?B?K0ZXUTUyS1JmandNdGRZaExqN0ZlSkVwSVE3NnQvUnlPcHI0STdDVTJOTTBQ?=
 =?utf-8?B?VkJSSWk4UlZHcjJvVmkwQmFYTk1yaFM4Z2l1cVpwRVB6ajVhYlk1S1dGZkp3?=
 =?utf-8?B?Z3MvYWRPeWtvM2tFVTJ1SklRRTVIQlVwZWRsRDFOY0RZWnBqZkdNMHloSnVw?=
 =?utf-8?B?UWt3UU5tVU5STHdmSGp2anJXOEJJVXFtVlU1MXgzS1JONFJtTkZYS3Iya1N1?=
 =?utf-8?B?SDZPa1FnekxZYUh1L3R0cENFa1BnYkdUcy8wb2xqTExQQTkvclp5ekFrRStD?=
 =?utf-8?B?SnhCVUsyQkt0QlNKSWNyNmswTlJaSkF3NnBZcE1tc0lpZlNtMnBienNBTkhh?=
 =?utf-8?B?K1RPTS93Q2VoSXBEMVRkT3VVZ0YzVTJGZVh5ZUhFZHpjRVZiUkxvcGhrdmkz?=
 =?utf-8?B?aC9xRmtYSnZmVzF5N1F2dWthOUJXVjhCWlA0azVGZ2JwR0w1NkRKYmMyR0Vj?=
 =?utf-8?B?VnBUQzRxUWRRTWJ2ckQ0SG0zR0ZvU0djM3ZZOXg3ZWZickNrMUQ4d3l6bnhH?=
 =?utf-8?B?NUJ1WTRWQWNjSnpjc2JrbE5JZFExYnhKSDJnVWlCRVVFSHFpMVBnWVE5UWNw?=
 =?utf-8?B?Z3B5cnBrUStiK3puWm5vR283cW1SY28zN3BjNlc1cG80bm9nWGJZdFhPcURu?=
 =?utf-8?B?ZmFxYjFCVjAxSkVXR2FUZEpiVzFCTmlKUlZLWktTMTRpY0RlODNUekJrWkJz?=
 =?utf-8?B?dG9PYUwwcHIxNHY4VU43ZmU2c29jZFRuejArNUNjQlhZQVFpSHIzMkVvWEwv?=
 =?utf-8?B?dVQyNFFqT05aa1hvZHBZTmgzRmtsekQxTkpuSUJXVHNPSitLOTFYVnlwK1hK?=
 =?utf-8?B?dVdrRHJQU2FUZHMyV0pCNHdqTE9xQW9jVm9aaEo4ckRzNkxOZ3NIYnJ6Sm5E?=
 =?utf-8?B?d0V2MVhMUmVSQVk5azd3R1Nad0RtOUt6WmgvQ0xmcGpjdlpSQXI2Vm9QRS83?=
 =?utf-8?B?YlUrTTN1SHE3MFN0dXNBODJyUVNJZE8va2dXdmU0ZklWMmZ6Z1hYK3VjSTFJ?=
 =?utf-8?B?RGVFU3hNNk1KMHNwckJiTldYSU9lS0J6YjZlR2xnNUFrSXpiOVpHUUdRV1RO?=
 =?utf-8?B?a29nVTN6SHhNamZZZTU5QlF2UnpycUc0SjNLc1FuRDZJbk5JM1ZBcmp6VVlQ?=
 =?utf-8?B?Uk55Ty95Qjg0S3M1Q2FaT2Uyd2crVGQ5MnJJakpHOWJwRGxNM1pZK2FsSW9K?=
 =?utf-8?B?VXhsY2xsYWRMUFY0UlNKaEhkbDlrNUJlOFNHRWVFcEIvOHFaazR4cnk5dXRT?=
 =?utf-8?Q?6FJJriyaOzB2CkxYXcqdn31VhdwDn/qd0FA6n7W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F19EFE1B9603549A6E375AAC263E689@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43e27fb-1174-4d2c-c5cc-08d95005fc9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 07:21:29.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFeHbUtAKN/L3qJlepGKjjzCzfcXi46b8KmOVbnavN96RNdXUvu7hZK6MvpYdeJVzO9syG5LZbilmWMF0s1PCLbOgjrFoZA9a5n8fl1PboI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2514
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuIEkgd2lsbCBmaXggdGhlbS4N
CkFib3V0IHRoZSB2cmVmIEkgcmVwbHkgaW5saW5lLg0KDQpPbiAyMDIxLzcvMjMsIDEwOjUyIFBN
LCAiSm9uYXRoYW4gQ2FtZXJvbiIgPEpvbmF0aGFuLkNhbWVyb25ASHVhd2VpLmNvbT4gd3JvdGU6
DQoNCiAgICBPbiBGcmksIDIzIEp1bCAyMDIxIDE2OjE2OjE1ICswODAwDQogICAgQmlsbHkgVHNh
aSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4gd3JvdGU6DQoNCiAgICA+ICAgPiArICDigKIg
SW50ZXJuYWwgb3IgRXh0ZXJuYWwgcmVmZXJlbmNlIHZvbHRhZ2UuDQogICAgPiAgID4gKyAg4oCi
IFN1cHBvcnQgMiBJbnRlcm5hbCByZWZlcmVuY2Ugdm9sdGFnZSAxLjJ2IG9yIDIuNXYuDQogICAg
PiAgID4gKyAg4oCiIEludGVncmF0ZSBkaXZpZGluZyBjaXJjdWl0IGZvciBiYXR0ZXJ5IHNlbnNp
bmcuDQogICAgPiAgID4gIA0KICAgID4gICA+ICBwcm9wZXJ0aWVzOg0KICAgID4gICA+ICAgIGNv
bXBhdGlibGU6DQogICAgPiAgID4gICAgICBlbnVtOg0KICAgID4gICA+ICAgICAgICAtIGFzcGVl
ZCxhc3QyNDAwLWFkYw0KICAgID4gICA+ICAgICAgICAtIGFzcGVlZCxhc3QyNTAwLWFkYw0KICAg
ID4gICA+ICsgICAgICAtIGFzcGVlZCxhc3QyNjAwLWFkYw0KICAgID4gICA+ICANCiAgICA+ICAg
PiAgICByZWc6DQogICAgPiAgID4gICAgICBtYXhJdGVtczogMQ0KICAgID4gICA+IEBAIC0zMyw2
ICs0NSwxOCBAQCBwcm9wZXJ0aWVzOg0KICAgID4gICA+ICAgICIjaW8tY2hhbm5lbC1jZWxscyI6
DQogICAgPiAgID4gICAgICBjb25zdDogMQ0KICAgID4gICA+ICANCiAgICA+ICAgPiArICB2cmVm
Og0KICAgID4gICA+ICsgICAgbWluSXRlbXM6IDkwMA0KICAgID4gICA+ICsgICAgbWF4SXRlbXM6
IDI3MDANCiAgICA+ICAgPiArICAgIGRlZmF1bHQ6IDI1MDANCiAgICA+ICAgPiArICAgIGRlc2Ny
aXB0aW9uOg0KICAgID4gICA+ICsgICAgICBBREMgUmVmZXJlbmNlIHZvbHRhZ2UgaW4gbWlsbGl2
b2x0cy4NCg0KICAgID4gICBJJ20gbm90IGNsZWFyIGZyb20gdGhpcyBkZXNjcmlwdGlvbi4gIElz
IHRoaXMgZGVzY3JpYmluZyBhbiBleHRlcm5hbGx5DQogICAgPiAgIGNvbm5lY3RlZCB2b2x0YWdl
IHJlZmVyZW5jZT8gIElmIHNvIGl0IG5lZWRzIHRvIGJlIGRvbmUgYXMgYSByZWd1bGF0b3IuDQog
ICAgPiAgIElmIGl0J3MgYSBjbGFzc2ljIGhpZ2ggcHJlY2lzaW9uIHJlZmVyZW5jZSwgdGhlIGR0
cyBjYW4ganVzdCB1c2UNCiAgICA+ICAgYSBmaXhlZCByZWd1bGF0b3IuDQoNCkluIHRoZSBhc3Qy
NjAwLCB0aGUgQURDIHN1cHBvcnRzIHR3byBpbnRlcm5hbCByZWZlcmVuY2Ugdm9sdGFnZXMgb2Yg
MS4ydiBvciAyLjV2LA0KYXMgd2VsbCBhcyBleHRlcm5hbCB2b2x0YWdlcy4gV2hlbiB0aGUgdXNl
ciBzZWxlY3RzIGEgdm9sdGFnZSBvZiAxLjJ2IG9yIDIuNXYsIG15DQpkcml2ZXIgd2lsbCBmaXJz
dCBzZWxlY3QgdG8gdXNlIHRoZSBpbnRlcm5hbCB2b2x0YWdlLiANCkFzIHlvdSBtZW50aW9uIGF0
IHBhdGNoICM0LCB5b3Ugc3VnZ2VzdCB0byB1c2UgdHdvIHByb3BlcnR5IHRvIGhhbmRsZSB0aGlz
IGZlYXR1cmUuDQp2cmVmOiBpbmRpY2F0ZSB0aGUgcmVndWxhdG9yIGhhbmRsZXIuIExpa2Ugb3Ro
ZXIgZHQtYmluZGluZ3MgdXNlZC4NCmFzcGVlZCxpbnRfdnJlZl9tdjogaW5kaWNhdGUgdGhlIGNo
b3NlbiBvZiAxLjJ2IG9yIDIuNXYNCmFuZCB1c2UgIm1vZGVsX2RhdGEtPnZyZWZfZml4ZWQiIHRv
IGV4Y2x1ZGUgYXN0MjQwMCBhbmQgYXN0MjUwMA0KSXMgaXQgcmlnaHQ/DQoNClRoYW5rcw0KDQog
ICAgPiAgID4gKw0KICAgID4gICA+ICsgIGJhdHRlcnktc2Vuc2luZzoNCiAgICA+ICAgPiArICAg
IHR5cGU6IGJvb2xlYW4NCiAgICA+ICAgPiArICAgIGRlc2NyaXB0aW9uOg0KICAgID4gICA+ICsg
ICAgICBJbmZvcm0gdGhlIGRyaXZlciB0aGF0IGxhc3QgY2hhbm5lbCB3aWxsIGJlIHVzZWQgdG8g
c2Vuc29yIGJhdHRlcnkuDQoNCiAgICA+ICAgVGhpcyBpc24ndCAoSSB0aGluaz8pIGEgc3RhbmRh
cmQgZHQgYmluZGluZywgc28gaXQgbmVlZHMgYSBtYW51ZmFjdHVyZXINCiAgICA+ICAgcHJlZml4
Lg0KDQogICAgPiAgIGFzcGVlZCxiYXR0ZXJ5LXNlbnNpbmcNCg0KQmVzdCBSZWdhcmRzLA0KQmls
bHkgVHNhaQ0KDQoNCg==
