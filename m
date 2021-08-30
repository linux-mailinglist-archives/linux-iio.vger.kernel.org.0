Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9CF3FB289
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhH3Igv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 04:36:51 -0400
Received: from mail-eopbgr1300109.outbound.protection.outlook.com ([40.107.130.109]:6116
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233318AbhH3Igu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 04:36:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK56sauOhd9EFwxyfBlwWjgmgkDYOxQWa/SahlkrBpNMHz992saD5VJAgwx1h9FOWrPvL+BgnZ9/y6C8qc+BQKqC/1WnSA5T+EyAUS+ZzDLcKM9UnTabeaFLdDHTc0+KmEbeSCOcqVTFcNwSpBtgUsNPYTFPXWvmxcl5XErOya1F3zS00PXJBAHjENf5bmIJJwwazcOgPsGcP+pMf74sNjVeoTovXnamtCJp2JaxLJgNoMsW/dHisxanuVsPbc8zLbMfyK1n6Hfb88BiosVcSKndQmydKrjBEjiIL5470ej99doilJn2cTVWoLY39U951n2tlKNjxwkIURRK1TEfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAw82U5o9rp1AgnAK7LiqX+JlnihDxwwJZVQDqJk4Vc=;
 b=SoT3Y1xsJFm8lm7gUCCoLFAlgUckV4joYqyvYxPvADu/GcFUfCaVyy1qxZMq1TYCWCsg09Q5NaKsCmKhGt4fn8V1WW9jnTDr6Fv0Lo1zGJj9BbQi3jZxtfBNjWeSE6nucNVTfr8MaI6Kt5L7mm2i6vI9Vs2Q3kfgVFcNhmlydiC+LrQDCCKCDgomNuFU2sewxlcj/3PFWQa3amS7b1GhnzASNPxWC8+D2eU8YTKB61oZ5F5sLO0fz7JKeEIGmRLKGW288c+eJ3lGf8p4IGN2KHE1kfQAy0vK5xb/Vy7N0/4iEV7s7vxdeDjUNYRWtXnGRNqIoemA0KsFvbky53tFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAw82U5o9rp1AgnAK7LiqX+JlnihDxwwJZVQDqJk4Vc=;
 b=F5gh+3DiJdMHzTHN22/u0WkIU4SBLCqu1xfs50YhNl4iq4cGLY6oadBG548Uhxz4NKRMiIaEKbG2FzAps/tK6DDvNI7+p35A4gurkoLdNvgtB2ME+kjJsUXrmZakKld/y2xY9rYk45DZJhvUzzSyvhUjso4Q8zGP5/1dRAI9IJMO2sPl11EQ3b6uebvkkos/TGAvX804WJ64sJRd/rU1pT62J4+huMy9P9BABk3E4GUYF+eo8YOhaZ/NVZgC4g2kKWIJvpRwL36rRJPCrQdMSraC9uRYbwAxQ1HltCmE/8himPcbfiLioUCzDWv3Dm6UN0VVbwaI5I0jSZncwOC9ew==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2130.apcprd06.prod.outlook.com (2603:1096:203:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Mon, 30 Aug
 2021 08:35:53 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::10fc:291d:32b8:dcb4]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::10fc:291d:32b8:dcb4%7]) with mapi id 15.20.4436.025; Mon, 30 Aug 2021
 08:35:53 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [RESEND v4 12/15] iio: adc: aspeed: Add func to set sampling
 rate.
Thread-Topic: [RESEND v4 12/15] iio: adc: aspeed: Add func to set sampling
 rate.
Thread-Index: AQHXnOtGanZsbH3nSEydpTOzzlCKGauMQFoA
Date:   Mon, 30 Aug 2021 08:35:53 +0000
Message-ID: <FE947284-E67B-49DB-B538-3ECAD8317BD4@aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
 <202108250003.17P03KRU092474@twspam01.aspeedtech.com>
 <20210829163659.2f7f5974@jic23-huawei>
In-Reply-To: <20210829163659.2f7f5974@jic23-huawei>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4f23b9f-12a1-42de-ab24-08d96b912df5
x-ms-traffictypediagnostic: HK0PR06MB2130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2130F28FAC329D7DF980B59E8BCB9@HK0PR06MB2130.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYS0jA4g5ZjkWwTnW65crgOLvIzjNhwH+RqE0/dfHR+qOyY2Go+/9WeoseX3ntjYY2qvgg+2RevrvetlDLPCahbag+XAz/tNEt2JBVObTv4VPXHYF2KjgzeNt2O7uYgMO4ijP9BuHCYpkTiWgk+9roZfkJ1FNXTcmuwvkzfxCaCFbYDU812AdDotDUM7wdffAfyaD7VtYx7Six19Umz6dk6jdXGZpdfWhMatJbbTozwywhbc5WUEsM8VJyCivAROC58qihQyhfZBhiSesig5EpZcGxGSo8Wy3Xy1kqOysnpwdySjssflQRz8fexVKyf2NsoFybPIkWWlpijBAo20ciSrDwJONt5VJ3eM5QMgZrEbk6qb3jh0MV8Ghfh6z2COUS4iFkiBUyUxoCxTsyG7b0/6Fv6yWcamj+GrUN5sX/pP6ZUMzOrh0ANlhBmQC2gtluyCOnwM8wdp84y/7UD+U9kjW4tf8usZl2BohlMZRslBniPLZ1sd+7/gEwmKDkdtr+l783e+ck54iEi8fGTKqEs2gEqM9usAclrd0r8AWqQiUqUFcS/Ds7txz1minsiTtVBn8w7gm/OxFAB2e19on6pCedgc6WnHg9JBCeFsjYf8tStpBMzYjVsECv5F1o//BJY7phS545dHjCGLPy5V4e8bdwUqHNJ/iw9Zn5/YUiyz0T2WcByvRBEKy3ybOpdd5rUt312f/ctmEfchJsyGz6AVtiWW56TJrFlc0tTiDcNO1RY4lGPbYhIQJusZf+Nw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(136003)(39840400004)(346002)(186003)(76116006)(8936002)(2906002)(6512007)(66556008)(64756008)(66946007)(66476007)(66446008)(2616005)(26005)(4326008)(107886003)(8676002)(71200400001)(6486002)(33656002)(53546011)(122000001)(86362001)(478600001)(7416002)(6506007)(38070700005)(83380400001)(316002)(54906003)(36756003)(6916009)(5660300002)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm1DMmhzQlIyTWpyUEtBSnBvU3BTMlNhNjZCYXBtK1gwUm5PODVSQld0d1VR?=
 =?utf-8?B?SFVlMnZ0WUNRTW1FWUFQNi9jUjFxWmlid3M3MWR2M0lFd3RCRk9XUEovVW1E?=
 =?utf-8?B?MkNiKzZ4VjlDQ1VmWk5KTTViWGE2bmhlZ1BnWlpDQWU1bWZwK0xLOXBLaFVW?=
 =?utf-8?B?UUYxZmZNWWMwdkNGd24rb3Y0bjJlQmR4VHg1cUUzOUpRMTBIeUF6M1diZWd1?=
 =?utf-8?B?YnViZmhTd1U2Mmo5UWdVZE40KzVVUXN3ZVJtWWE5UGVsMkMzcXV5b1ZGRW1D?=
 =?utf-8?B?MTFadlg4WmM5MGQ1V3p3eUEwZ05wdkRES291SWttL0VlekFhNXlHM3J6Z2g3?=
 =?utf-8?B?K2JIaDFGR3F2bnJYbm5ueUhUaUdRc2szMFBUQjVWb3JkeUhpZ0dtNE5taGZJ?=
 =?utf-8?B?bWpOTEovOHZTZHFSeWpJYWdYc3VmeUxXUy9jemtNVXEzTjQwbEw1cnFINTVT?=
 =?utf-8?B?WXNGc0VleU54VmN1a21aWWRBODVwTmhVMEJiZVVDa0Q5WGhBckdVZFpUeG0x?=
 =?utf-8?B?YjFNUnRtVmdBSTBWeUlLbUZ3Y3ptZ0pSNk9jMEMra1VvYzZ3MGMyaXBJNmh5?=
 =?utf-8?B?WGwwRHJ1MEt1cm4xQXVzNlppZERHUE9OeUVWSmMwSnB0djUrL3F3RWx1dEcz?=
 =?utf-8?B?RU53REdlSStwa1lINTBTNmRtRUNRVkl0YS96eWVHQWlHeGRsUFhOdzlwVEdx?=
 =?utf-8?B?Z3dka2ZreUdLTVVWUTJEQ01EREM2SnVHRXVUQXp6a0QyMlgwbjc4QmlwOGpW?=
 =?utf-8?B?Z3NQMjdtRFMwWlMzVnJjKzZZbytjK0JEUjl5WDJmcFp5VDJmdXRudGZXeHFN?=
 =?utf-8?B?aWxOUjNETCt3c3V5dDhsaUlhcllNWlRObHpKbEJIZzhZNFBnbmNJaitYSzdr?=
 =?utf-8?B?VDVULzhsbEEzZmhaRUFuNDFUNHg5cXFkd3NqRFlkNDBzVGlaRnp3ZWl6cmVH?=
 =?utf-8?B?MFlxaUVlZkdiSUxyczlhMWVybzNQQ3BnRGVpYVRSdG1BeEpWcWpUQWl6VjBJ?=
 =?utf-8?B?dzlWa0tYTS9YNTlXZEYzbmRhZFZTMWd2YjR1dGtKSEpMNEJmeDZTS1pLN1RE?=
 =?utf-8?B?b0JYNzZFcWMwRXJxb1A1NFpVdFJhaUN3emd1b25CeTZJd3lLcXFickZtZHZs?=
 =?utf-8?B?RDRwZExkNGJ4TU1aMkVkZlVZTWsva1c4U3Q5RUJkQVQrK0ZqdFJ3c01ZTUNO?=
 =?utf-8?B?bkVuaGNKbVNvSlV0dVhmSzNLeG5VYlVPemVsandpclFIMkNLU01aY2lXQ0tG?=
 =?utf-8?B?U005MzIvL1BianBOUjhvam9UdkI2VnlVaU0vWXZKMG9wZ0ZmMkxEeVprNVlK?=
 =?utf-8?B?bWEwLzg3U21ZTmJaK2NOVEt6OVRERTB2b0xTb3BHNldlMmRCcndKT1ZKSlM4?=
 =?utf-8?B?L1NEYmt4eG56ZEIvWmFScnFlekRtbEV6UzRTNFQwTkd4Uk13MlJYMUFlWWJ1?=
 =?utf-8?B?Vi9ic0JJMlN4Y2c1L1hHVWkyOG02cEFxa3lkZTFmZnBKaFlCZ0NuQ1RCaU43?=
 =?utf-8?B?Z1hlMGJGdnJ1cVhHdEVNZXdKVFMxYjFsQSt3cjcwcEtXNDA5WW0ySGpEWVBH?=
 =?utf-8?B?RUl6c3VqQXFyOUZUWUI5VC94cGtVdDhuMlRGWEJqMVY4UWFyNmhkd3VwOHRj?=
 =?utf-8?B?RW1JeTNidmhEb24rcTZPMFUwRCttMTZyNjVESmhZQjVLckhMbUpnOURJemZC?=
 =?utf-8?B?L2NkS3kyMWtSaXF0WVhKYTR5UkFlb3VoNVpzb3pkTTJ4VDNPT1ZFYWlNL2dE?=
 =?utf-8?B?MEZXRVZxZTQ3RzducWlKMUtKdW9jMGx6cWJPL1p1RXNmM3c5cnFzZktDN2Ri?=
 =?utf-8?B?bEcxUnZqSFl4VFFKalRWUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C82C4700F4F6A44AAC33E05F6FBDC36@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f23b9f-12a1-42de-ab24-08d96b912df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 08:35:53.2602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9Khiiu73HNFWxol2hQpE8yaHfWW0sjf8jO3OAHVJO4ltNJf97xpSKZChz5MVdT82N3QkvBb0++h3ERlyFdOvYpgvhmG0weWrns46/5OfEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2130
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCk9uIDIwMjEvOC8yOSwgMTE6MzMgUE0sICJKb25hdGhhbiBDYW1lcm9u
IiA8amljMjNAa2VybmVsLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBUdWUsIDI0IEF1ZyAyMDIxIDE3
OjEyOjQwICswODAwDQogICAgQmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4g
d3JvdGU6DQoNCiAgICA+PiBBZGQgdGhlIGZ1bmN0aW9uIHRvIHNldCB0aGUgc2FtcGxpbmcgcmF0
ZSBhbmQga2VlcCB0aGUgc2FtcGxpbmcgcGVyaW9kDQogICAgPj4gZm9yIGEgZHJpdmVyIHVzZWQg
dG8gd2FpdCB0aGUgbGFzdGVzdCB2YWx1ZS4NCiAgICA+PiANCiAgICA+PiBTaWduZWQtb2ZmLWJ5
OiBCaWxseSBUc2FpIDxiaWxseV90c2FpQGFzcGVlZHRlY2guY29tPg0KDQogICAgPiBXaHkgbW92
ZSB0aGUgY29kZSBhcyB3ZWxsIGFzIGZhY3RvcmluZyBvdXQgdGhlIHNldHRlciBmdW5jdGlvbj8N
CiAgICA+IEkgZG91YnQgaXQgZG9lcyBhbnkgaGFybSwgYnV0IEknZCBsaWtlIHRvIHVuZGVyc3Rh
bmQgd2h5IHlvdSBkaWQgaXQuDQoNCiAgICA+IEpvbmF0aGFuDQoNCiAgICA+PiArCXJldCA9IGNs
a19wcmVwYXJlX2VuYWJsZShkYXRhLT5jbGtfc2NhbGVyLT5jbGspOw0KICAgID4+ICsJaWYgKHJl
dCkNCiAgICA+PiArCQlyZXR1cm4gcmV0Ow0KICAgID4+ICsNCiAgICA+PiArCXJldCA9IGRldm1f
YWRkX2FjdGlvbl9vcl9yZXNldChkYXRhLT5kZXYsDQogICAgPj4gKwkJCQkgICAgICAgYXNwZWVk
X2FkY19jbGtfZGlzYWJsZV91bnByZXBhcmUsDQogICAgPj4gKwkJCQkgICAgICAgZGF0YS0+Y2xr
X3NjYWxlci0+Y2xrKTsNCiAgICA+PiArCWlmIChyZXQpDQogICAgPj4gKwkJcmV0dXJuIHJldDsN
CiAgICA+PiArDQogICAgPj4gKwlyZXQgPSBhc3BlZWRfYWRjX3NldF9zYW1wbGluZ19yYXRlKGlu
ZGlvX2RldiwgQVNQRUVEX0FEQ19ERUZfU0FNUExJTkdfUkFURSk7DQogICAgPj4gKwlpZiAocmV0
KQ0KICAgID4+ICsJCXJldHVybiByZXQ7DQogICAgPj4gKw0KICAgID4+ICAJcmV0ID0gYXNwZWVk
X2FkY192cmVmX2NvbmZpZyhpbmRpb19kZXYpOw0KICAgID4+ICAJaWYgKHJldCkNCiAgICA+PiAg
CQlyZXR1cm4gcmV0Ow0KICAgID4+IEBAIC00MTMsMTYgKzQ0NSw2IEBAIHN0YXRpYyBpbnQgYXNw
ZWVkX2FkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KICAgID4+ICAJfQ0K
ICAgID4+ICANCiAgICA+PiAgCS8qIFN0YXJ0IGFsbCBjaGFubmVscyBpbiBub3JtYWwgbW9kZS4g
Ki8NCg0KICAgID4gV2h5IG1vdmUgdGhpcyBjb2RlIHVwPw0KDQpCZWNhdXNlIHRoZSBBREMgY2xv
Y2sgaXMgcmVxdWlyZWQgd2hlbiBpbml0aWFsaXppbmcgdGhlIEFEQyBkZXZpY2UuDQpJbiBvdXIg
c3lzdGVtLCB0aGUgY2xvY2sgaXMgYWx3YXlzIG9uLiBUaHVzLCB0aGUgbGVnYWN5IGRyaXZlciB3
b24ndCBlbmNvdW50ZXIgYW55IGlzc3Vlcy4NCkkgbW92ZSB0aGUgY2xrX3ByZXBhcmVfZW5hYmxl
IGFoZWFkIG9mIGluaXRpYWxpemluZyBwaGFzZSBmb3IgbWFraW5nIHRoZSBkcml2ZXIgcHJvYmUg
bG9naWNhbGx5IGNsb3NlciB0byB0aGUgaGFyZHdhcmUuIA0KDQogICAgPj4gLQlyZXQgPSBjbGtf
cHJlcGFyZV9lbmFibGUoZGF0YS0+Y2xrX3NjYWxlci0+Y2xrKTsNCiAgICA+PiAtCWlmIChyZXQp
DQogICAgPj4gLQkJcmV0dXJuIHJldDsNCiAgICA+PiAtDQogICAgPj4gLQlyZXQgPSBkZXZtX2Fk
ZF9hY3Rpb25fb3JfcmVzZXQoZGF0YS0+ZGV2LA0KICAgID4+IC0JCQkJICAgICAgIGFzcGVlZF9h
ZGNfY2xrX2Rpc2FibGVfdW5wcmVwYXJlLA0KICAgID4+IC0JCQkJICAgICAgIGRhdGEtPmNsa19z
Y2FsZXItPmNsayk7DQogICAgPj4gLQlpZiAocmV0KQ0KICAgID4+IC0JCXJldHVybiByZXQ7DQog
ICAgPj4gLQ0KICAgID4+ICAJYWRjX2VuZ2luZV9jb250cm9sX3JlZ192YWwgPQ0KICAgID4+ICAJ
CXJlYWRsKGRhdGEtPmJhc2UgKyBBU1BFRURfUkVHX0VOR0lORV9DT05UUk9MKTsNCiAgICA+PiAg
CWFkY19lbmdpbmVfY29udHJvbF9yZWdfdmFsIHw9DQoNCg0KQmVzdCBSZWdhcmRzLA0KQmlsbHkg
VHNhaQ0KDQo=
