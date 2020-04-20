Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B070C1B014F
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 08:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgDTGGI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 02:06:08 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57294 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgDTGGH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 02:06:07 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K5xpSG012638;
        Mon, 20 Apr 2020 02:06:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fud750u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:06:06 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K647ed016575;
        Mon, 20 Apr 2020 02:06:06 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fud750tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiwBXMzRM+VTQsT18fUx03/tQ5zAHR6H/ArZmXNEHtmPRm4l4Co4wYaILwarKB3sbVl7zmNp/eUeY+FEch1RIyJN9dIPhst7rvfv+N9euc56sKKydJyCGie+FEzUOPVQbFo1EsiD9X1app0lUUTQeylzt7ngljChkg1f7UuGT0TE3hGVwZQAJxVRwzSZJfJMMqd6SOI2sbWRuEffP7SIp470K2t9An2o81vTnUf1mfkxUSF7PzPhc6jyMNumkfRCFII+H33MkcJPUKzVJotBssbeYmXiAeuKYSK/qht7SqAcCdz6nTOHNe4YE71tbfmL5KfotZsewi26R8uYabfi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9RM9ghW2KvsfcVp6TzNawnn4Mow1n+Kj/nouPkV2xU=;
 b=B96xPbWzH8Wt5cowYrl1b6jYqO60YzVjI1HXW02fabsYCUlG598dFTvkeja9sap8BaRerfIaLSer+5RxQ0+Tn7dppapMuqE4V9VLQhC/kcB1s/qyMmFjwi1J8mS/vOERU633rOy4ISUxDe87G2MhpdakLfDdVYvOnSiQlQzxUzzBCAXO44mlXGRzXp87Butg16YRESK+Xp30lt7mM02Mxr6hrbQdeXMfq44nIBHMIE0kLps95TLitXk65uW/nzZgSokQyccdhPCx2I1iEPPJ6olbwELds33q7Tus3WOIdhGNueJIVPVyfrr/5pDg39rT2tjRCbPZBRrQHLRs7axdxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9RM9ghW2KvsfcVp6TzNawnn4Mow1n+Kj/nouPkV2xU=;
 b=6XUu0z9w9oFIGbpOf13TOIM6/10bo4+skEr/kS22/WcfNeoCUuWMH3q78fjHRH8HH1R/1pyPIt1KxsQeF4gXA1VU8lVMipCQSrTO813n3W1Hxs1fqsNmgj2WnX1r7oHwtgpYv3PY7CLBrLXSK16BcHTNrGDjHpHSnJo1uutXUrQ=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4153.namprd03.prod.outlook.com (2603:10b6:5:5c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 06:06:04 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 06:06:04 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/7] iio: light: gp2ap020a00f: Swap of.h for
 mod_devicetable.h + drop of_match_ptr
Thread-Topic: [PATCH 4/7] iio: light: gp2ap020a00f: Swap of.h for
 mod_devicetable.h + drop of_match_ptr
Thread-Index: AQHWFlvUyi2kBMWEb0OKu2tc5ROIAKiBh/IA
Date:   Mon, 20 Apr 2020 06:06:04 +0000
Message-ID: <89784f279b0daad14b3e8d885e933ce67a7f1077.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
         <20200419150206.43033-5-jic23@kernel.org>
In-Reply-To: <20200419150206.43033-5-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2f8b785-6961-44f4-4633-08d7e4f0e8bf
x-ms-traffictypediagnostic: DM6PR03MB4153:
x-microsoft-antispam-prvs: <DM6PR03MB415359F49699B714A0E029D4F9D40@DM6PR03MB4153.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(346002)(396003)(376002)(39850400004)(366004)(86362001)(36756003)(6512007)(186003)(26005)(71200400001)(6506007)(478600001)(110136005)(2616005)(4326008)(2906002)(66946007)(76116006)(91956017)(8676002)(5660300002)(8936002)(316002)(66446008)(6486002)(64756008)(66556008)(66476007)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZw+Wybf/JpfeW/2nhxJdXOMvPvhgIpnEzECmyWlVYXiqIWcAGa8MbEgkiwzT5Q3bDGyRlB+7RI5j5A47xQIRVj556pVG1AmdftQKbafCfF+BudEHhOb+lae2Fo+2bVrd/FEi4eN2db9XX5xPhIK25smmJUBZ0cpiW8ccN7wQBXZMrUGeAtYXWfNTleY2KJmCZ/VcDOQ3pVBC274RDz9U2P5Lcxu2eZGtL3i+lpOzyuBJzRYR5zjQmQwQ4mftslrK5OLTPqllFOALxS9SfDmgD+L0dHIWwSFtEyuC/N2dA+3EYwCvMYVH0P2cc/7A/YwAQi0yYaZe3bD3bJ9kQNOh8G6TrwvLsUDrELnIdAr9ZTUOiDHc+M67P8PGDONu2Cd7bJxkdlw+9pYvV1joZ5k3iU/RQlLiKXDiJUK1p1b5FK+MlvRSqgZ6k+OZfWh6owb
x-ms-exchange-antispam-messagedata: Gl0KNaYrCX5yhc+Ck7xoRnF7XY3lRarduBbNC6KZDJi9/cHS4VH67VEeXbgjHwuvMrypy9kZ4bMUKGo04bO02Mv+gAq3oh1IH46LFA53g7B5I4R4Bsghsb7LuN1ulv/R3QKnUz8gmidX2eRuENi/0A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F6DE91AD6ACBE43900F675F229FF63D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f8b785-6961-44f4-4633-08d7e4f0e8bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 06:06:04.4138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OyP+LJy3RmyetNKBmMGEpLSX6VC9HMpyi0eJMwJADkn2PSxYNS3+3TPD9MDFReIprqS4qOq0uIAFmyyVVgaWSQKaCwrt+Mh3Jh090QpLLI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4153
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_01:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTE5IGF0IDE2OjAyICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBBbHNvIGRyb3BzIGlmZGVmIHByb3RlY3Rpb25zIGZvciBDT05GSUdfT0YuDQo+IA0K
PiBFbmFibGVzIHByb2JpbmcgdmlhIEFDUEkgUFJQMDAwMSBhbmQgcmVtb3ZlcyBhbiBleGFtcGxl
IHRoYXQgbWlnaHQgYmUNCj4gY3V0IGFuZCBwYXN0ZSBpbnRvIG5ldyBkcml2ZXJzLg0KPiANCg0K
UmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxv
Zy5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2Ft
ZXJvbkBodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2xpZ2h0L2dwMmFwMDIwYTAw
Zi5jIHwgNiArKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQvZ3AyYXAwMjBh
MDBmLmMNCj4gYi9kcml2ZXJzL2lpby9saWdodC9ncDJhcDAyMGEwMGYuYw0KPiBpbmRleCA3ZmJi
Y2UwZDRiYzcuLjA3MGQ0Y2QwY2Y1NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vbGlnaHQv
Z3AyYXAwMjBhMDBmLmMNCj4gKysrIGIvZHJpdmVycy9paW8vbGlnaHQvZ3AyYXAwMjBhMDBmLmMN
Cj4gQEAgLTM4LDggKzM4LDggQEANCj4gICNpbmNsdWRlIDxsaW51eC9pcnEuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9pcnFfd29yay5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L211
dGV4Lmg+DQo+IC0jaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9yZWdt
YXAuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvY29uc3VtZXIuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9zbGFiLmg+DQo+IEBAIC0xNjE3LDE4ICsxNjE3LDE2IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgaTJjX2RldmljZV9pZCBncDJhcDAyMGEwMGZfaWRbXSA9DQo+IHsNCj4gIA0KPiAg
TU9EVUxFX0RFVklDRV9UQUJMRShpMmMsIGdwMmFwMDIwYTAwZl9pZCk7DQo+ICANCj4gLSNpZmRl
ZiBDT05GSUdfT0YNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGdwMmFwMDIw
YTAwZl9vZl9tYXRjaFtdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAic2hhcnAsZ3AyYXAwMjBh
MDBmIiB9LA0KPiAgCXsgfQ0KPiAgfTsNCj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGdwMmFw
MDIwYTAwZl9vZl9tYXRjaCk7DQo+IC0jZW5kaWYNCj4gIA0KPiAgc3RhdGljIHN0cnVjdCBpMmNf
ZHJpdmVyIGdwMmFwMDIwYTAwZl9kcml2ZXIgPSB7DQo+ICAJLmRyaXZlciA9IHsNCj4gIAkJLm5h
bWUJPSBHUDJBX0kyQ19OQU1FLA0KPiAtCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIo
Z3AyYXAwMjBhMDBmX29mX21hdGNoKSwNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gZ3AyYXAwMjBh
MDBmX29mX21hdGNoLA0KPiAgCX0sDQo+ICAJLnByb2JlCQk9IGdwMmFwMDIwYTAwZl9wcm9iZSwN
Cj4gIAkucmVtb3ZlCQk9IGdwMmFwMDIwYTAwZl9yZW1vdmUsDQo=
