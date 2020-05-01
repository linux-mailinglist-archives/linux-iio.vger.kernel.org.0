Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575471C10A1
	for <lists+linux-iio@lfdr.de>; Fri,  1 May 2020 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgEAKL4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 May 2020 06:11:56 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:57572 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728268AbgEAKLz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 May 2020 06:11:55 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041AAx5j017691;
        Fri, 1 May 2020 06:11:51 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-00128a01.pphosted.com with ESMTP id 30r7d194ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awAdnCr9G5jOippOXvl5sj9nZQNUZfxATQ/TxRAily+eCSCNLpe7SkrqqBtLgrCmm8E1SeLqGf0chO6P+XYNZ/w8KqazkrgizJ34Srzc/lp03rAnKshc3eFvowU6jaIIsk7GyoqwGe+IkUDIsgX134RSsHNAw9mVFu7XNfmSFqooStPkgZL4waBBwKQr3QxFhH624LJfJWvPPFUwMhlk2TF3LM9tpBsjlWSz79aeIy81T4kNYwMlZp3Uy/xouC4TpVCSqYlC/1rLc9lMvHXF6oaHHatuxt/VkY7hu/0X30oFPY5QMR3AcTvnPH7AWF07ShZwmC7D05YzDaxyyVoeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvoVBDQIq/bCvyY0FToWLvxtSdl3lQfsvQMyviVKXXY=;
 b=jo/k896/s6K3p9j55sqRt7fNtTJ95IPkYOMo5689455rChArBeoTahxIKd4WU30liysXQWIo6VeptSZZ078WxfKk22CyAgpJKCgDcH0GTIv5751Fqom26emIB+ZT7woPtvc3G4aHGjFARaHsKo4hgY0zpadGHIqaVdxEjCmQ4g98TfHKtu7RPd3jKwAnK3AF4ZwRVTi3KHxEcdFcQJ4obRZiSACyLMrxC1xFwDjDn/cpgCCjrdwFszDisFE+3qQTWdDS9yYOW0dMA2lU08OX2VMUn25dplVTDtPQD+sLMM+v1qmZakI2G6queQhlLBcLBWsaBdjGLgP1pAuir+9pLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvoVBDQIq/bCvyY0FToWLvxtSdl3lQfsvQMyviVKXXY=;
 b=fbj5PVS8jPZirLlA90DH4Od3LhpRf7gqJiIl6LHHK8s2JzrqwK4NzdsRvuVUJv00FP//ToU8eNwKN/XqenLiHz7l50uHYJZkwF5BS3gQIFSvvA9Dm4liKooEKP3k0KX6+gRXtho4eKAvfikLAOeXnM5HO6WDlOsMXWWiS6KmzDQ=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 1 May
 2020 10:11:50 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2937.028; Fri, 1 May 2020
 10:11:49 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [bug report] iio: adc: ad7476: Add IIO_CHAN_INFO_RAW for AD7091R
Thread-Topic: [bug report] iio: adc: ad7476: Add IIO_CHAN_INFO_RAW for AD7091R
Thread-Index: AQHWH5140/mBh9IxAEWMCnXRDvKb1KiTAp4A
Date:   Fri, 1 May 2020 10:11:49 +0000
Message-ID: <bb2386ea4b011e2475f19f4169fce3bea5d9fa7e.camel@analog.com>
References: <20200501094449.GA960353@mwanda>
In-Reply-To: <20200501094449.GA960353@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2726781a-6889-411d-05bc-08d7edb8104e
x-ms-traffictypediagnostic: DM6PR03MB5196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB51961CD2837031D5FAD16F41F9AB0@DM6PR03MB5196.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0390DB4BDA
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHZgfWimrK3yImgR54OK40qBofIx2r38sCKeUK9gPlFHSRaW8PQDjpiFBDDZcdlwE5KCenaB9MEQQ0kObjtZaI+DEINRQAGs1xCIrDi0BSEMQpTESEq/go4gRcHHgIX/ts2WjWkTfc5Tyrrhr5f2xwTozIz7B7UDzCj0AkpsddcFZUhIKr/ldCHIlngoIRkDIkNgzbnXyJHVmyAoPVC7umfk9bPh8eWUTQ55njZmNmXYv1Akr2QfeZ2EOH8X6Hl+geY80ll4QtxHtNFclSnu9dOFuekdIxNFSYsDuMYrjblb3CKXvnCX9k81KcpFbjZptP5ODN1P2zQEoDQUi963jQR9g+k/YHGATD98fhhxKDvno7MpQDbhjuGYYs36hSEo6rcRSx+GVHpKOOJFN3xPWRUMh6t0/LrR/6vSw2jbVdKwFdIKisYJhuH65uZArp0VqfjuW3VWdWTZ7iE9+avs/WysqoU8WrVohWhW8dKVR2w569VHuteKJ62XkhpqMHK8pukElfwmoR/aFZXtYyel6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(136003)(366004)(346002)(396003)(76116006)(91956017)(186003)(71200400001)(66946007)(2906002)(86362001)(966005)(66476007)(66556008)(64756008)(66446008)(6506007)(6636002)(2616005)(4326008)(36756003)(26005)(478600001)(8936002)(110136005)(316002)(8676002)(5660300002)(6512007)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5/wWPa6aM2oB7jhECHRH7qC5XSceZnSoq7a3pbYFvluejRn7XOnUkovr6DL9/7E/JngLJqUWJHjaenHJxG2MBFcmuSbJyNDPoYrHFnEkP3EQxl4lyFwEGbguJketDKzyl3YQz0sOWsUW6pOZTm6c8PSmdfpKPZyNj8KNFHKFPFkzrQO7zBHp/JRbFXh+5wwNu/OLm1NfqJMrRk+Zy6+jNd/IYX8PuXT5pRDgjYhMy3J76bT+A9+GiTBybEryGSbhJsvLPeBx2z1H1/V6Pv8NqdtolkQEmgxwzUKy1E0JkPjPeeD1axb8q75thn9GnTDuTnZDxkaeaazjfbva+bzZBwESBMeXPYKNnsqRkiyFdJzOUfikgtUpjvHFo0DXncSm0NubwkGMHbUYQgMzR1p77/1uhfT9F0MiXqO7Vj9Sol+0s81N4+kHtf2ulAMSjuPWxUs2hQmmsWf+/DL6zxX27A7jl2oS4rKXRgO29excFlVfI5rEiNM5JmVYxowhyyrJGLXdCV1s+3eRKOqA315eF8pKjGqRVkCLklK4Bftb/+FeJWSeZZdQ8Jfrzzb2zC6KXXl5GHadVUxgUnM8ga9Bv0UFZyQnPOphL1Nhh4N10P/Lq8wHtb4xQcI/oErUA1WLIlJArIKz6LMYzuVDW9FPz3rnCjHMFloZ3/haibl4vpSCqein9tGE0ErvC6z4sQEI4e7slghWW5tZMOGCcxTQAl73K8mu3AsnbFltAC1+IqFqks0xzGcl0bEQ9muBkrYj90JyLx5X9HEKpy6GoLZwysjMDdJHxQ9jpC4QNzdMAY8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <053897449A531448B25ABD99B9C55E32@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2726781a-6889-411d-05bc-08d7edb8104e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2020 10:11:49.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9l/B+EfKZRqKtblgLHrxUkmcIDJ6qWjfC9LnT8zaIcC8X/g7BTtr4Cd4qa7n0s2vcBMqGZO7sWoINU/gY63dhy0X2jU+2GxHxaPeEHC+C+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5196
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_04:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0
 spamscore=0 mlxlogscore=960 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010079
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTAxIGF0IDEyOjQ0ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBbRXh0ZXJuYWxdDQo+IA0KPiBIZWxsbyBEcmFnb3MgQm9nZGFuLA0KPiANCj4gVGhlIHBhdGNo
IDNhNmFmOTNkZDY2ZTogImlpbzogYWRjOiBhZDc0NzY6IEFkZCBJSU9fQ0hBTl9JTkZPX1JBVyBm
b3INCj4gQUQ3MDkxUiIgZnJvbSBNYXIgMTEsIDIwMjAsIGxlYWRzIHRvIHRoZSBmb2xsb3dpbmcg
c3RhdGljIGNoZWNrZXINCj4gd2FybmluZzoNCj4gDQo+IAlkcml2ZXJzL2lpby9hZGMvYWQ3NDc2
LmM6MzEyIGFkNzQ3Nl9wcm9iZSgpDQo+IAl3YXJuOiB0aGlzIGFycmF5IGlzIG5vbi1OVUxMLiAn
c3QtPmNoaXBfaW5mby0+Y29udnN0X2NoYW5uZWwnDQo+IA0KPiBkcml2ZXJzL2lpby9hZGMvYWQ3
NDc2LmMNCj4gICAgMjg4ICAgICAgICAgIHJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgm
c3BpLT5kZXYsIGFkNzQ3Nl9yZWdfZGlzYWJsZSwNCj4gICAgMjg5ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdCk7DQo+ICAgIDI5MCAgICAgICAgICBpZiAocmV0KQ0K
PiAgICAyOTEgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAyOTIgIA0KPiAgICAy
OTMgICAgICAgICAgc3QtPmNvbnZzdF9ncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoJnNw
aS0+ZGV2LA0KPiAgICAyOTQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgImFkaSxjb252ZXJzaW9uLQ0KPiBzdGFydCIsDQo+ICAgIDI5NSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHUElPRF9PVVRfTE9X
KTsNCj4gICAgMjk2ICAgICAgICAgIGlmIChJU19FUlIoc3QtPmNvbnZzdF9ncGlvKSkNCj4gICAg
Mjk3ICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoc3QtPmNvbnZzdF9ncGlvKTsNCj4g
ICAgMjk4ICANCj4gICAgMjk5ICAgICAgICAgIHNwaV9zZXRfZHJ2ZGF0YShzcGksIGluZGlvX2Rl
dik7DQo+ICAgIDMwMCAgDQo+ICAgIDMwMSAgICAgICAgICBzdC0+c3BpID0gc3BpOw0KPiAgICAz
MDIgIA0KPiAgICAzMDMgICAgICAgICAgLyogRXN0YWJsaXNoIHRoYXQgdGhlIGlpb19kZXYgaXMg
YSBjaGlsZCBvZiB0aGUgc3BpIGRldmljZSAqLw0KPiAgICAzMDQgICAgICAgICAgaW5kaW9fZGV2
LT5kZXYucGFyZW50ID0gJnNwaS0+ZGV2Ow0KPiAgICAzMDUgICAgICAgICAgaW5kaW9fZGV2LT5k
ZXYub2Zfbm9kZSA9IHNwaS0+ZGV2Lm9mX25vZGU7DQo+ICAgIDMwNiAgICAgICAgICBpbmRpb19k
ZXYtPm5hbWUgPSBzcGlfZ2V0X2RldmljZV9pZChzcGkpLT5uYW1lOw0KPiAgICAzMDcgICAgICAg
ICAgaW5kaW9fZGV2LT5tb2RlcyA9IElORElPX0RJUkVDVF9NT0RFOw0KPiAgICAzMDggICAgICAg
ICAgaW5kaW9fZGV2LT5jaGFubmVscyA9IHN0LT5jaGlwX2luZm8tPmNoYW5uZWw7DQo+ICAgIDMw
OSAgICAgICAgICBpbmRpb19kZXYtPm51bV9jaGFubmVscyA9IDI7DQo+ICAgIDMxMCAgICAgICAg
ICBpbmRpb19kZXYtPmluZm8gPSAmYWQ3NDc2X2luZm87DQo+ICAgIDMxMSAgDQo+ICAgIDMxMiAg
ICAgICAgICBpZiAoc3QtPmNvbnZzdF9ncGlvICYmIHN0LT5jaGlwX2luZm8tPmNvbnZzdF9jaGFu
bmVsKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXg0KPiBUaGlzIGlzIGFuIGFycmF5LCBub3QgYSBwb2ludGVyIGFu
ZCBpdCBpdCdzIGluIHRoZSBtaWRkbGUgb2YgdGhlIHN0cnVjdA0KPiBzbyBpdCBjYW4ndCBwb3Nz
aWJseSBiZSBOVUxMLg0KDQpJIHRoaW5rIHRoZXJlJ3MgYWxyZWFkeSBhIHBhdGNoIGFwcGxpZWQg
Zm9yIHRoaXMuDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9qaWMyMy9paW8uZ2l0L2NvbW1pdC8/aD10ZXN0aW5nJmlkPTRkMjJhYjc0NDZjNjlmN2ViYmM4
YzhhNDg2ZWJkOWFiYTY4ODIzYzANCg0KDQo+IA0KPiAgICAzMTMgICAgICAgICAgICAgICAgICBp
bmRpb19kZXYtPmNoYW5uZWxzID0gc3QtPmNoaXBfaW5mby0+Y29udnN0X2NoYW5uZWw7DQo+ICAg
IDMxNCAgICAgICAgICAvKiBTZXR1cCBkZWZhdWx0IG1lc3NhZ2UgKi8NCj4gICAgMzE1ICANCj4g
ICAgMzE2ICAgICAgICAgIHN0LT54ZmVyLnJ4X2J1ZiA9ICZzdC0+ZGF0YTsNCj4gICAgMzE3ICAg
ICAgICAgIHN0LT54ZmVyLmxlbiA9IHN0LT5jaGlwX2luZm8tPmNoYW5uZWxbMF0uc2Nhbl90eXBl
LnN0b3JhZ2ViaXRzIA0KPiAvIDg7DQo+ICAgIDMxOCAgDQo+ICAgIDMxOSAgICAgICAgICBzcGlf
bWVzc2FnZV9pbml0KCZzdC0+bXNnKTsNCj4gICAgMzIwICAgICAgICAgIHNwaV9tZXNzYWdlX2Fk
ZF90YWlsKCZzdC0+eGZlciwgJnN0LT5tc2cpOw0KPiAgICAzMjEgIA0KPiANCj4gcmVnYXJkcywN
Cj4gZGFuIGNhcnBlbnRlcg0K
