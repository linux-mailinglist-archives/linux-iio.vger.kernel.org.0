Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FA3F6C6C
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 02:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhHYAHu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 20:07:50 -0400
Received: from mail-eopbgr1320122.outbound.protection.outlook.com ([40.107.132.122]:44507
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S233909AbhHYAHs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Aug 2021 20:07:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khLuJofA+ZJCBpf/rsEKkAb3bTRsT09gYa3mx/NOXsgx6jnH0iRLadMbI1NsiCwLMrfHvmFaYA6aUEGH2uJxmhylLzXppSytdfqgDgbISOdGhS+TYtTM7x3OjrNYCpov2jgOWVn/FOeUD30qruJz3L1eV5BdsTejHDh0B82pjbCLaxUOYfRtmtlrqrz5lePq+2rSRnrOTghQB+ED3ZmH0ZQZXxeyx4ZgT5dEGYMA65q1vwAGSdNX0d1W389jUi9g4S3TqARtfy2qulw0pVoYkmCZzx8VRN6aqD2v4y/aE/VtPFHCB7nKftceGtqkeSPum/mHX+/yeZopW8JVNckz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xooJYk7Fq7UQ0glrEhRiT0l3mxf1NuA4Omzhok/bkSQ=;
 b=Pzn9GvQ49BUR6laGb+GO8w0zOXbHK3eHYUO4XpprfyO4mW3BjHnh7e26OCLFdJSGbnfChHckHS6XdCSU3TwuA3QcqKOVmSlDC0sJrob0riHwlUgMBwwdhzeRCa3sOisK89izjlW4s+wPmQgMS+3nBiA/EXP473WTpvML3weumVFBjW720tEf2BypwCetjc2i9r9rZ02RHwQf5uX0poCo4ElbQp3eCXhaznEwAE0xw8slxPEB/39KzaWbZohcpbFEwrzVUurcOEXe3uVvXRM2H5ya0dVTukdoIzzjAt/VwxNsI9v5tubS+r3Fuq294Y0RohGAqY1WJklsthXPB8Du0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xooJYk7Fq7UQ0glrEhRiT0l3mxf1NuA4Omzhok/bkSQ=;
 b=lGXn64kpkkNDPJ72lERBY43frvLsUg2c4pyb4pbDt9jKgzhPpRtzUVzDjYy75T9SLNSoToEPshjXkb+/p7um3ORbFYou7FxehyDSLWf4TF0Q0cC2o2YmFpAchZ3KWMj11pRTWnBKma4IdtlNTKigzpGgYKP/IPKHq/TGCb96QMaGqfNg0xLyYdmLtBuDemt9UD1DoQVz9lo5KgdcYsHtN1Bh8Kirt/0yjYnUQxlKDcECMN42PjJ9OA0wTdCMRg4XVEdHMTFmNeED4weqEpwVpXDBG1qqZW1Fx68brNwfA5tHMtHf8HkYMuPQQ4r516imHMoDy6zSaXeQeF9Q3rLRWw==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK2PR0601MB1986.apcprd06.prod.outlook.com (2603:1096:202:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 00:06:48 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::10fc:291d:32b8:dcb4]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::10fc:291d:32b8:dcb4%7]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 00:06:48 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
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
Subject: Re: [v4 01/15] dt-bindings: iio: adc: Add ast2600-adc bindings
Thread-Topic: [v4 01/15] dt-bindings: iio: adc: Add ast2600-adc bindings
Thread-Index: AQHXl+y93beyisjT+0ajoJAVlSMgVquCku4AgAFNhAA=
Date:   Wed, 25 Aug 2021 00:06:47 +0000
Message-ID: <DEB9D606-6489-4993-A5E7-6E4F3226EE5A@aspeedtech.com>
References: <20210823070240.12600-1-billy_tsai@aspeedtech.com>
 <20210823070240.12600-2-billy_tsai@aspeedtech.com>
 <YSTiUPQa+HYSA63t@robh.at.kernel.org>
In-Reply-To: <YSTiUPQa+HYSA63t@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5dc6520-7e3b-4110-0df9-08d9675c3b64
x-ms-traffictypediagnostic: HK2PR0601MB1986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0601MB198602A474D1E0B3AFD8E8CD8BC69@HK2PR0601MB1986.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1gUFqz01+j4JbHaDAN+PTY6+SAcX2gIs6UGBxMqKKkLmY2zLHmjuAnJ34PhJAdqHcPtONah4ik72l/WvIeqZ8WP939WT5v7usMfxf4pnj/CmxQnEa72N+wzdTokaWoyIY5ZjbHdDyftbCIQDiZHe4mHsmZ2R+xcFmGAtV3HI+U7nZDbbzbqudPuDWbZJorSTAcd4lg3OCOGrNp0nFqS0g9VWP20KLt6BxpG3WjFUE8LhnaB+Z1hrqf/fUDnHhQGcq5Y59j3z1Xp7YkE2zHr2MpNSNWiyU0sAGfoZ56F57KswacamXwaVt8WUhYsgricE+15LzL6Jg/lH81MbeaS9XPYnI/S0R2Of0bp+AnNuxLTszNBKFUurUAvOMnGpKlwaSjaWh4qudPb5tQLpklGWQg4g9uqbMJcWKhYDipybRKm4yBy9VKhL1CMioyutZpCQqoqDxCWkIwOVfSn3khWU+O1W3wTDmAz111dfiVawX3bx8C0G8wNAK2UKoca6P0wBKaMuZhus676DlWkPvj6IIFwwF/FoxTfKwWkhg4fNHV3DCAhaa8axogaXg7KPkDYwhCrlfW0R/fJNQR6jGou2KWeozJgP3Z57Ap726BIieSzyP32QAdLCepwTzjYdE6hI974OaIkwgS/ebU0XQL8oJVm2qonghSkzdR7e9Pj+A5BBtpcEQ2Q/W+/Vca2o9+8SiBXzLvk4JAt15nnzYeCJ7xFSEfcqjAb74N8THi3d+7nNbI9pztch0DZBybR+NAj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39830400003)(346002)(376002)(54906003)(8936002)(316002)(2906002)(7416002)(8676002)(4744005)(36756003)(66476007)(6512007)(38070700005)(26005)(122000001)(6916009)(2616005)(6486002)(107886003)(38100700002)(76116006)(66946007)(4326008)(66446008)(6506007)(478600001)(53546011)(186003)(71200400001)(5660300002)(86362001)(64756008)(33656002)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2liZ3VCVzhBQndheVYrOE9SVlkySmphd3M4K3pzQVhzdXVhOGErMlUyYWIr?=
 =?utf-8?B?dXB1RWVpaFhsN3k3TytEdXVFamZnak9kaVBua1h5Sjg1RHlaaGdtQWRaMGNP?=
 =?utf-8?B?VVNOL1QwSUllSm8yb3Fqck5ZZU92d1ZpMlAvaS9YRWxzKzluK3B5a1BkVENI?=
 =?utf-8?B?RkczWU9DcDJlZXJOVThBM3dOMmdOS1d5a3pQbXZrT3ZwT25ERkgvT1NCbGhl?=
 =?utf-8?B?UWxSMnZmUmFDQlIrOE00QlJDODM4SXcveFI3K3FhRzJTWHMvVWdVYkZGcnly?=
 =?utf-8?B?UDBzTmZmRnlWdG05VWN4QVB5TENOTzhhQUhVSWF1aVEzU2p4eHhQVUFQNlFT?=
 =?utf-8?B?UjF0T1hibHU3MnpQWndYSEc2MW1SVHNwMW12emhxVEsrVVE2SVFvYjhtZ2hv?=
 =?utf-8?B?RW9VRVQ2QXlNNk5ENG1KVFQvcDBCVHU1dTJWM2x5SDZMWHJIV21vNDRXTWR4?=
 =?utf-8?B?SG9yWGgwUG5mS2hGMGtERnBRQU9JZm14dHlEMm5ZdXZac1RhcjRseDVuVmFw?=
 =?utf-8?B?WVJhU3EwU1QzSklTSUV1VERCL3BpU09wT2lWWk5jdTE5cG8yVnd4MXFUeU9u?=
 =?utf-8?B?YWtsMEV2NFVVN2lTMUg2anRyRWpmZDRWR2VFTG5TdTN4UGxvdERiVEV5eEl4?=
 =?utf-8?B?ZWdqVzhxa3EvcTJ4OXl5ZXM1bFIrenNDTEhnTFRSL2plZnBjTVE0Z0paUjhn?=
 =?utf-8?B?U2F4NjgvZWh5eTN2Z2dWWHoydDBDVXJoVkJsOWlJOCtrcVpUUk5HT3NmQmkv?=
 =?utf-8?B?c25LK3JOcmQwM2ZNdmFQNGw1OUc2UHFXRGY5RExxV2creTZhUHZnU3Bqc3JF?=
 =?utf-8?B?OHU3Z25QQWtYY0UzSU9Na0dHd2dha2ppNnBnSVg3cHpQY0IyTmE1a0t5Ri9a?=
 =?utf-8?B?R2ZvM0Q4cS9yUG4yM2dtay84WTBIMUU1bnBBMTVUbTAvcGVvRWIvSEpIdTlM?=
 =?utf-8?B?S3h4ZGtpeVdWU1dvQWgrdVd0UVI3b3I4UVNyVGl2QTZtYXlLRGsxSEUrcjhH?=
 =?utf-8?B?RUM0UTFVOFhnZ2dSNXdScGVkeG13TTEyVjRWOGt3OVBWSHVmWUY5WUdYRUxV?=
 =?utf-8?B?Rkdhd3Frb3h2K2xlM3FqRmtsQ0tCYjVnb293aXdndUZ4cWxGVUhqQkZGNys2?=
 =?utf-8?B?YTFJR1JCT2lGNzRHKzdnMUswL1NKcXYySWZkbE1SSzBwQzJod3FEcDQyZ0dk?=
 =?utf-8?B?dzRacEJVZ1lQa2NYVjkyakxFRkI0ZmFRbGxCNUs2SWd5THYzaFNHNzV3VWMz?=
 =?utf-8?B?QWhGRy9WOXp2MXYrWVhEOVRBT3g0U3FneWZDeWFFaGl4SC96d1NEV3A5M0Jx?=
 =?utf-8?B?K3pHTkRlWjNjOVgxdGVCVXllN1ByaG5mVFRNZ1ZqTWFIRkFvN2kxalhyczA2?=
 =?utf-8?B?Snd2bFp4YnhsT0EzclFmaXlSYzZjendnNi9HeVQ5S1NkTHF6dVBDclVzemli?=
 =?utf-8?B?NEF0d0pBaDhuQzUzUFFZMEVHencyMGl0azlUVmpZTG1TOG5BcHVDRFNBYi92?=
 =?utf-8?B?QWJFYTVzZTQyZE41dzVrT05wSFcyd3F4RWY2b0Z5RHpZeERITFN3TS81TVFa?=
 =?utf-8?B?M2tIN1V2bXVnWWY2YThGY3dId1JFN2VoY0dib2w5d0M1SG1Ua1l5VHlScmpO?=
 =?utf-8?B?YmZiY2xhcGtlYmxodGxyeGxPaVd0c3FHTlN3b1NzS1ZRd0VCU1JuRmxFbDk4?=
 =?utf-8?B?bnRnajBKTklIemdJMFgybm9kaDArM1luM0lGVmdSVFFlTkdtODl2N0p4dXVD?=
 =?utf-8?B?WUkyN2RYemhMd2kxRW56eU1CYU1OQy94MGRYVlpITHlXUktZMmEwWE8yTHBj?=
 =?utf-8?B?eFFabFY2NzlRS2ZMc3d6UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <782B960864F10040A8140E26310C2FA7@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dc6520-7e3b-4110-0df9-08d9675c3b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 00:06:47.8362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26yVbvSXSV7+n2vmjIUL+b3Kf9AbZ5VroZKJKlqc8liVf15Pvxb+RCyEsNmkwHnmko0Q9BSjmQanhv2Yc+5HFfJpMI1XTIiDZyILNLxLuvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1986
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgUm9iLA0KDQpPbiAyMDIxLzgvMjQsIDg6MTMgUE0sICJSb2IgSGVycmluZyIgPHJvYmhAa2Vy
bmVsLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBNb24sIEF1ZyAyMywgMjAyMSBhdCAwMzowMjoyNlBN
ICswODAwLCBCaWxseSBUc2FpIHdyb3RlOg0KICAgID4gICA+ICtwcm9wZXJ0aWVzOg0KICAgID4g
ICA+ICsgIGNvbXBhdGlibGU6DQogICAgPiAgID4gKyAgICBlbnVtOg0KICAgID4gICA+ICsgICAg
ICAtIGFzcGVlZCxhc3QyNjAwLWFkYzANCiAgICA+ICAgPiArICAgICAgLSBhc3BlZWQsYXN0MjYw
MC1hZGMxDQoNCiAgICA+IFdoYXQncyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIDAgYW5kIDE/DQoN
ClRoZWlyIHRyaW1taW5nIGRhdGEsIHdoaWNoIGlzIHVzZWQgdG8gY2FsaWJyYXRlIGludGVybmFs
IHJlZmVyZW5jZSB2b2xhZ2UsDQpsb2NhdGVzIGluIGRpZmZlcmVudCBhZGRyZXNzIG9mIE9UUC4N
Cg0KQmVzdCBSZWdhcmRzLA0KQmlsbHkgVHNhaQ0KDQogDQoNCg==
