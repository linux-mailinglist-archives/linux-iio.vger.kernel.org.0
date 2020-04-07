Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1C1A0601
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 06:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgDGE7F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 00:59:05 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:58042 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgDGE7F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 00:59:05 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0374o1Q4005391;
        Tue, 7 Apr 2020 00:59:03 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 306pv6qnsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 00:59:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coA5zrzN8P4huoaA3ULAQgdGsq8QHPGFi25o+Q+1KFta01+YAO8eiFk0iNtmsgT010xgkLz4xPKzIzMegRtEoftspJuEaFOyeaAaH1aI112xRffMr6wmeyC8tipiJbjDf6SKuviqPQv89S61OS04K7xhGkTBlUuYMr/xCX4imTFMLFQHiy1NzHLx9OwIWhUMms32eAbMMmt9mnZRYv8+9I0vqfYKx8SRFuDslj63aTgiFtqwf8Of++0dxDjqaC9Y4BCz4q3IBI6VcaZOnOSjYxB70/ATLGic1EMZGQNKMcK07ftq3eCZsqNvNb5OqhR+edAOhpChjMZDIaPzyHmtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlab9YmkP+d5iy1TTYtbOnpQiaH7sOjYCN9a0W3/fEA=;
 b=EacRcpQkOAXAHAZ59vihZzP0w5BuBGcFUmhnX6o5ZneEZc6epSZi0DIrtBe/Kdnb+13JM3ESG37E86MpfP0vKXXQ5GBJUPMvtUudK7idNiDbB5Jq8PNZc/hb/DfEoO+nBCwQezHJTd0Jc29UoyjDkO+oyTTQdzxdhat8IedbmDa1pN/hJT/9xBfyRpUTgd1SaiAQDNt9bqfB1pdesF9a1xM1DCz5EkslTN26jizaRhXLvkcYpj3e3kWvDQ5ZWt4wpFPNdQLrjwAagcdRn7kQiTEy2umMa9VMS9Iz7xMihR8O76nqanDclxFrceXJtf2h3U8M/x8vyuJFBMIzwGcrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlab9YmkP+d5iy1TTYtbOnpQiaH7sOjYCN9a0W3/fEA=;
 b=Hc4f86YXdTb4b7ktYKanq24mGP78pIn/oSkD0gOHy/PGojrBEpCXqXr5QlBUoRdCYwmyRyiifTBaJ/k648wlk0fVOsu1lTIkukOJoD3Mi4YGkUTDdakQRcoTaYh6aKYBuHgdP7sim9vpZpb9ZmU9J91FNbcHdUR08qqQaVbPoR8=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4345.namprd03.prod.outlook.com (2603:10b6:5:10f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Tue, 7 Apr
 2020 04:59:02 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 04:59:02 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7192: fix null de-ref crash during probe
Thread-Topic: [PATCH] iio: adc: ad7192: fix null de-ref crash during probe
Thread-Index: AQHWDEwtiqqYgDYlh0+16YCEgc/Z3qhtGvUA
Date:   Tue, 7 Apr 2020 04:59:01 +0000
Message-ID: <7ef930850988a24ce0d24cf2fd7f22a0b08b59af.camel@analog.com>
References: <4ff0776f-b5de-536a-ccf9-7516f1a65d87@web.de>
In-Reply-To: <4ff0776f-b5de-536a-ccf9-7516f1a65d87@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6aea7e89-16a0-459e-1cd9-08d7dab063e2
x-ms-traffictypediagnostic: DM6PR03MB4345:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB434517CD55AFA9F333468A3EF9C30@DM6PR03MB4345.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(396003)(136003)(376002)(39850400004)(366004)(66476007)(8676002)(81156014)(2616005)(66556008)(66446008)(4744005)(4326008)(71200400001)(64756008)(81166006)(91956017)(76116006)(186003)(316002)(86362001)(66946007)(8936002)(966005)(54906003)(6512007)(6486002)(478600001)(26005)(5660300002)(110136005)(6506007)(2906002)(36756003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ny80eEoH+Uh8/nRZPb42CSMiu3WW7QrIge7XIgUGRez8MaNP2YdoMjS+XfyrLO9Ei0PgycZStRDgv3/HDEmWjcZhw8j0iF0+bFbUQ7dxmtOtjSqwElht4xVfJkjKYuoVrW/lurkyWIblV4T1PwqLYFcAIr9zWxrGInOh8Q2U29B4zLEd6TNAh2/GKXdR0DuGfm4qvYVFhtbuen3RS/t39d7lRg4rJVID7kP90Ke37/pQruBpVM2KT/wYz8GbHtWqhTUMalIuMomGdsREa3jUzEavqbT5sZ90skOrx8hmm1rY6LPPGypGHmtCINV0h/ktbxytYFaYqoWm8K8OCK0Rqg2jEZdRnN6yMbF2JyjSNO3SDqH5Gi41hK/b6Rk/tmr5uNngP3264+INfFkGqg22Yz8dYoBPgb8iqYXGUp0Kx3BQYu4KGercmysRl36Jd4206yFLKjGMQFmTqgAcBqNhQP2XEnoRWL3UR+WhwI0KCBk2iMOm4bifrMInh7rEPAiqHif60Z9vPeWxmJwqbKrprA==
x-ms-exchange-antispam-messagedata: n2f9AUvxOIZ0AV9rT24E9NJApt0dx8t9AkC6zq/VcQLPubq3ca49OaA9Tdo2+ayoYxmZl1zB5ud9jPBQBKyYJJa0A3LPjzNyDAQj6Tw9jLFNdrxznhlKPJ3ofmzgCfZgw8ymAnopzBGMM8zwpUOiNg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BAB9C12DF758D44A244743E417726F6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aea7e89-16a0-459e-1cd9-08d7dab063e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 04:59:01.9417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dT6PvmrFRveZyVszHFmTu6p5oFDev1+Odey/At3A+nemR/T91GFFqrsNX8vBjYUqU5X60IaMpbufE3B3l+hS9NyXr4YkAQ3CsA/ff56JLQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4345
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_01:2020-04-07,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004070039
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTA2IGF0IDIxOjQ2ICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gPiBBZnRlciB0aGF0IHBhdGNoICdzcGlfZ2V0X2RldmljZV9pZChzcGkpJyByZXR1cm5zIE5V
TEwsIHNvIHRoaXMgY3Jhc2hlcw0KPiA+IGR1cmluZyBwcm9iZSB3aXRoIG51bGwgZGUtcmVmLg0K
PiANCj4gSG93IGRvIHlvdSB0aGluayBhYm91dCB0byB1c2UgdGhlIHRlcm0g4oCcbnVsbCBwb2lu
dGVyIGRlcmVmZXJlbmNl4oCdDQo+IGluIHRoZSBjb21taXQgbWVzc2FnZT8NCg0KZGVwZW5kcyBo
b3cgbG9uZyB0aGUgY29tbWl0IHRpdGxlIHdpdGggYmUNCndpbGwgdGFrZSBhIGxvb2sNCg0KPiAN
Cj4gDQo+ID4gRml4ZXMgNjY2MTRhYjJiZTM4OiAoInN0YWdpbmc6IGlpbzogYWRjOiBhZDcxOTI6
IHJlbW92ZWQgc3BpX2RldmljZV9pZCIpDQo+IA0KPiBQbGVhc2UgY29ycmVjdCB0aGlzIHRhZy4N
Cj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRp
b24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2lkPTdlNjM0MjA4NDdhZTVmMTAzNmU0
ZjdjNDJmMGIzMjgyZTczZWZiYzIqbjE4M19fO0l3ISFBM05pOENTMHkyWSF1azliT2FEXzQ0OU4w
UHh3dFFfV2lrV1lZNUtucHlrZVpUcC1yYnJSVGp1N0ZaTTZmUGQ0OHpDRDFwZTdyVFNZeXBLWWtn
JCANCj4gDQo+IFdoeSB3YXMgYSBjb2xvbiBtaXNwbGFjZWQgaGVyZT8NCg0Kd2lsbCBmaXgNCnRo
YW5rcw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJrdXMNCg==
