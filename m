Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E248D16F83D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2020 07:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgBZGyZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 01:54:25 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23504 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbgBZGyZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Feb 2020 01:54:25 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q6kxFS010605;
        Wed, 26 Feb 2020 01:54:23 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydcjt92px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 01:54:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTze9Z+B/t2ne7QYW4se4CDp24C+KZYXbAYZt+Mw8SwsEhpMDVXRJwO3g+6O+fdF92gj16KZXFtNxPIa2TaDFM0tOuWDV5tkvtemw4nbD3ECZiFNVJ7Gb9A/U+bxN0kp0+qjvyK0WA1FdF3C4bvHta6qDMDieqqBgwkgn3WLALKP2bWMEa9oeDVdKdwoA6DWBCltkpbcbzSe3CXWvRzsc7PWasjJHtHKQRUYjTST1WxA4vDACI0dIh6x9KWOZXCQJPxAi3AeXIMgTMHvMvVQeuyNGDNRph76FWD6RufgEdD9VcNFeq5oh3C4P0adUniRMKzan6cjJBUn4108GeGe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHffDI1IYWg8+y+vQA5UxH1XwO10YQrPtJHHzxsJV7w=;
 b=ZXfBPpYrpOEWebKXNFnOPVZmWbT24ECwp6B+OeE0easjtQrjsA+W0cEZQsEzl5JeW+aWzuXt4+t/tev3PM2BvDtV9ID+GEmKHFWMBqke/0u3PTYnjZVxAStmnNhVagQOF/aePXSv00Wy9+dhFFEcpRn1gvU6giEDlTvqC2IeoOOtDTP1ZhAtvOosntIyZC2CtrEsHuwAkV7zXkDcOWOzH9pnuNuq0mCpK1NQ/830XZPXDaaD2VFhgo9vk1olwSerRIqlwFv3KES0R5FbQ8KLabNpd+YR/hKsaxm8fCh71amU8MhiN9f+fjIt5NV2f5sC1A2dCOJD1N0OShxJQn7QZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHffDI1IYWg8+y+vQA5UxH1XwO10YQrPtJHHzxsJV7w=;
 b=lXi5sso6gdT7e21iiMhfLuFISlex1FLWN3HbndOzxr12034+ph0ZQorekok0utgzk5cExgiuVy80gvzbfXYxgMoBEGxlvipxsNfQmzDRvWKKBO7MzBG5y7baaUph/hUllhEaL9Rn0eBUX/8uH7CMVrHxfx3GOoWrrBG3r90mc2w=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5272.namprd03.prod.outlook.com (2603:10b6:610:a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 26 Feb
 2020 06:54:22 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 06:54:22 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "rohitsarkar5398@gmail.com" <rohitsarkar5398@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: query about locking in IIO
Thread-Topic: query about locking in IIO
Thread-Index: AQHV6/66Pk/plpKKl0GYGdml23kVmqgtC/oA
Date:   Wed, 26 Feb 2020 06:54:21 +0000
Message-ID: <67108b1b3172e5f51d54a51fbe5a23c7ff4ce5ba.camel@analog.com>
References: <20200225171150.GD24663@SARKAR>
In-Reply-To: <20200225171150.GD24663@SARKAR>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8865fcdb-a651-4845-7763-08d7ba88b58e
x-ms-traffictypediagnostic: CH2PR03MB5272:
x-microsoft-antispam-prvs: <CH2PR03MB527255704DD9EB1C68283B2BF9EA0@CH2PR03MB5272.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(36756003)(86362001)(186003)(6512007)(8676002)(2616005)(478600001)(81156014)(81166006)(8936002)(71200400001)(6506007)(316002)(110136005)(6486002)(26005)(64756008)(66476007)(5660300002)(2906002)(66446008)(76116006)(91956017)(66946007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5272;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzuQreCvIf4t722a0VS7q6tJIfmAhhqstRRYL9dUD28u4uSYB48EkwshbqdheOK02w/IPQ9bPFUtjWY2zNtUsUT0Dxi1Vju65n01meg/iTPbva8JyirkWretpyi/37B4EMVvty2+JRu5Si77a53BRh8MzA50ykrNOXd9e0GRdiI2/tmPyfSpEGCbBCxTh31xjg1pj2GjLzgSsaRHaicewpYwCvk77NZwMEvVC259A1g334jQq9Hd+GWrCvuXq/OxDzZ0m8DWmUl6RzFezbPSYTQdI7p5zI5Pxz3N0189Z1hGu+fXD3Djw54I4vHUsIlRW79i6+S7+tF/UNajOa2iNvNiWtg+7PgHt6dBPbDbIckMVIz/VRBkkh9795hzuQHrAf4ec5x0gAHLyadXlmdKnTUJa8A1GrxAsRXuN+abldhjgZppRJQVWsNzFTpHi8QS
x-ms-exchange-antispam-messagedata: LhnpYslRiX3jAX7ifSuIPp+W4h/bERSNR9Pa0xH9Bml5AXZsr3EAdSZSB7pUJ6MWwxuJslzS/4Y3E1YUfrfSMUzar5QgtQX6jft8D52argOBch8nF5Pl4D/9r5N98YpHT7pWXnLY72tjeh43HpUmbg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B32F6C60C4299B4D951C8730033E30C1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8865fcdb-a651-4845-7763-08d7ba88b58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 06:54:21.9191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YMgG+NoN0jteWEz9/55nCOlRnK2j2zqDENIzXP34tPnurvvaEymNBRMtTsVK9rDDrsnLTUSSPpv3VniuvUQXCfKbOc9dwktZfeN3RO9MyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5272
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_01:2020-02-25,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=708
 spamscore=0 clxscore=1031 priorityscore=1501 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260049
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTI1IGF0IDIyOjQxICswNTMwLCBSb2hpdCBTYXJrYXIgd3JvdGU6DQo+
IEhpLA0KPiBDb3VsZCBzb21lb25lIGV4cGxhaW4gd2h5IHVzaW5nIGluZGlvX2Rldi0+bWxvY2sg
ZGlyZWN0bHkgaXMgYSBiYWQgaWRlYT8NCj4gRnVydGhlciBleGFtcGxlcyBvZiBjYXNlcyB3aGVy
ZSBpdCBjYW5ub3QgYmUgcmVwbGFjZWQgd2lsbCBiZSBoZWxwZnVsDQo+IA0KDQpKb25hdGhhbiBt
YXkgYWRkIG1vcmUgaGVyZS4NCg0KQnV0IGluIGdlbmVyYWwsIGVhY2ggZHJpdmVyIHNob3VsZCBk
ZWZpbmUgaXQncyBvd24gZXhwbGljaXQgbG9jayBpZiBpdCBuZWVkcyB0by4NClNvbWUgZHJpdmVy
cyBuZWVkIGV4cGxpY2l0IGxvY2tpbmcsIHNvbWUgZG9uJ3QuDQoNCkEgbG90IG9mIG90aGVyIGZy
YW1ld29ya3MgYWxyZWFkeSBkZWZpbmUgbG9ja3MgYWxyZWFkeS4NCkxpa2UsIGZvciBleGFtcGxl
LCB3aGVuIGFuIElJTyBkcml2ZXIgdXNlcyBzb21lIFNQSSB0cmFuc2ZlcnMsIHRoZSBTUEkgZnJh
bWV3b3JrDQphbHJlYWR5IHVzZXMgc29tZSBsb2Nrcy4gU28sIHlvdSBkb24ndCB0eXBpY2FsbHkg
bmVlZCBleHRyYSBsb2NraW5nOyB3aGljaCBmb3INCnNvbWUgSUlPIGRyaXZlcnMgdHJhbnNsYXRl
cyB0bzogbm8gZXh0cmEgZXhwbGljaXQgbG9ja2luZy4NCg0KSSBndWVzcyBKb25hdGhhbiBhbHNv
IHdhbnRzIHRvIG1vdmUgdGhlIG1sb2NrIHRvIGJlIHVzZWQgb25seSBpbiB0aGUgSUlPDQpmcmFt
ZXdvcmsuDQpJbiBzb21lIGNhc2VzLCBpZiBkcml2ZXJzIHVzZSB0aGlzIG1sb2NrLCBhbmQgdGhl
IGZyYW1ld29yayB1c2VzIGl0LCB5b3UgY2FuIGVuZA0KdXAgdHJ5aW5nIHRvIGFjcXVpcmUgdGhl
IHNhbWUgbWxvY2sgdHdpY2UsIHdoaWNoIGNhbiBlbmQtdXAgaW4gYSBkZWFkbG9jay4NClRoZXNl
IHRoaW5ncyBjYW4gc29tZXRpbWVzIHNsaXAgdGhyb3VnaCB0aGUgY29kZS1yZXZpZXcuDQoNCkkg
Z3Vlc3MgdGhlIGRvY3MgbmVlZCBhIGJpdCBvZiB1cGRhdGUuDQpCZWNhdXNlOg0KDQoqIEBtbG9j
azogICAgICAgICAgICAgIFtEUklWRVJdIGxvY2sgdXNlZCB0byBwcmV2ZW50IHNpbXVsdGFuZW91
cyBkZXZpY2Ugc3RhdGUNCiogICAgICAgICAgICAgICAgICAgICAgY2hhbmdlcw0KDQpJIHRoaW5r
IGl0IHNob3VsZCBiZSBjb252ZXJ0ZWQgdG8gW0lOVEVSTl0NCg0KPiBUaGFua3MsDQo+IFJvaGl0
DQo+IA0K
