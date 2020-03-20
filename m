Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2398218C805
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 08:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCTHNT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 03:13:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:49732 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgCTHNT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 03:13:19 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02K751Oc023306;
        Fri, 20 Mar 2020 03:12:21 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yu9jb1q8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 03:12:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mgt03p6sRWGAfVSwlyW5Khn9Ap4m+vcfFIsdpXmyGtwbEgDZbeilB5ZfXmxIscs9FZS3M4v94iysKOzPsuejTyKvzMvxhi7+BxNiIyyo5/hEfWCVAt48ekrzpHS/SRdtLwexG2M0r5GBmKVvVFoB7z0LFzbdFEMFeRjaDwTJRaQAujGQksCmTJmNo5j0XlChsw2P93dLZ2dQgD0P6x3KLgGrmoEM8VdYG9iKmsmhDY2Kafx58+ZVebf1erH0T79dYx5a8gSPYFnmNa+8zc+IJg2MjAneyswP1BAZu54ZpytUbWryLcLINqeHKcyvH4j4zbX7lVEE0h32UKeFHBtfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PMpIYKs2eulUh/T7srfGNkYfslRYnCnsqmP0uUwxj0=;
 b=YsPNNtp7KsBzK+Z0Oyo7NUwnGGfhANxBBYk2vSNvi8II+fNNfX6JGzX45r/16+6U7xxbInzh9XMaWQveb5dOrnfGjv8Q+1nchrKDRg8TlNfWiMhCqyl7svDwsBpRESX9V3VfwnlFTCcPgeqxLF+tejlxHql5/YQZkeCmUhKP8l+Xcyi+ysBhdiQpXy6mePdxNhQvjaT5nNf1CTH+An0hsLXsR2d+4M1RIZZ/wxp+/5E2OzNZiT/Gru5WVkYPgcyk8lM9nGzNHhJ0DBzpojT1i/wbiQkwi5hM4jwQyrPzoIurBTMCzLm2xbeLxNjHHhuSrTyrf6+AtUs/c/zw0TYLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PMpIYKs2eulUh/T7srfGNkYfslRYnCnsqmP0uUwxj0=;
 b=J4Dnh7YAJspL5qSILivX2u2mNUt5zjDBYJ2gDQEXPwZCCqYVwThc/6BIRiT6GnsOnMLuNXsv96HaHXrrlv9QjcHVkPV9ll2thfImD2pN4SFqsos8QSiv2Nhd1fT6zuvOK8oAvvtnjTVHvmVkA1NOQTRS0VZAH0XMB/xsDxcXVF4=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3547.namprd03.prod.outlook.com (2603:10b6:5:aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Fri, 20 Mar
 2020 07:12:19 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 07:12:19 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "alazar@startmail.com" <alazar@startmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Thread-Topic: [PATCH v3 2/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Thread-Index: AQHV/gr+PDsQL0XiZ0O93eXWBhyAxKhREqOA
Date:   Fri, 20 Mar 2020 07:12:19 +0000
Message-ID: <2bad089fd8302ed514f673dae4ba8264b35fff16.camel@analog.com>
References: <20200319162937.34664-1-alazar@startmail.com>
         <20200319162937.34664-3-alazar@startmail.com>
In-Reply-To: <20200319162937.34664-3-alazar@startmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a8f2d1d-b552-47f6-2d48-08d7cc9e073a
x-ms-traffictypediagnostic: DM6PR03MB3547:
x-microsoft-antispam-prvs: <DM6PR03MB35470473626B9DB27709C2EAF9F50@DM6PR03MB3547.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(376002)(396003)(199004)(86362001)(2906002)(110136005)(8676002)(316002)(2616005)(81166006)(81156014)(71200400001)(54906003)(8936002)(6486002)(186003)(478600001)(66946007)(6506007)(36756003)(91956017)(76116006)(966005)(4326008)(26005)(6512007)(66556008)(66446008)(5660300002)(66476007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3547;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qg0iP/CI5nYR0CysEoakNez1Fk4OPbCuJLU6hZV83eLHng08dTTG8qP1HrPnPCxhqwO6u2zmlVLXUK3b7fMaw9eqcxdVZeZTd4H0ANSmYb5Q+dGicGSyR5lRJdyK78JCj+i3OOtJmK3uhPD5Zu3Uf0A3slA9DiCNyfuLFVRHrNQsXNFKec9csDLebeQVOQxZheDqFql+bI8peb5hqDFmA7wVvsuYXnLySu6DrbQMoiwW97VZ05a2eF7bVgIFTuxF4pmcmbXcYNmn8kyF50gbxRSSAWPoE5tf3cBW94oTVrFiWNicSQOsmc07Sep9K+aBp0FkYPOLw1BDUm6yLRQnOIvi+SYznZ70BV3TC56xBP5OB8PC+XC6SetBhzrKefB7BfE1/qBybCbMznTso3dq0KAFqsn/jDPD5n8OgXRoBsZq2zld7mj0mx2G66YxBGKSFIAujyfPbrTKuPi8XM1SDBqe27kphVJVD3Pc4sWrCuxhYw28j2bWo6w6sRLlEoKm
x-ms-exchange-antispam-messagedata: q9qmENoxbiO453v3UH8WWjApjBTVGLWnqzkEmQzbjd1lM1Rmc611VhJaBX5H6kwcw2WxdxbnT++p/TJdDvJ7wmEkh4ojQh9pGIf60wR24Raf5OgoWoiekAa2yGsDMQSzELU7sqgrv1J6zEaPtcStEg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <01762B28AC207E44A9E55A9622B14CB8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8f2d1d-b552-47f6-2d48-08d7cc9e073a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 07:12:19.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trLntEvKwk6PBD3uaeb7OggKNRHCyXHCDhPn2ZHiy2RLstlCv1eM8YIK9Cjs8Ur+/X1d26rZv7Z9i08qXGuTXMf+8iWRKL3f78DAIo4Qxfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3547
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_01:2020-03-19,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200030
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTE5IGF0IDE4OjI5ICswMjAwLCBBbGV4YW5kcnUgTGF6YXIgd3JvdGU6
DQo+IEFkZCBkZXZpY2UtdHJlZSBiaW5kaW5ncyBkb2N1bWVudGF0aW9uIGZvciB0aGUgTUFYMTI0
MSBkZXZpY2UgZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IExhemFyIDxh
bGF6YXJAc3RhcnRtYWlsLmNvbT4NCj4gLS0tDQo+ICAuLi4vYmluZGluZ3MvaWlvL2FkYy9tYXhp
bSxtYXgxMjQxLnlhbWwgICAgICAgfCA2MiArKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL21heGltLG1heDEyNDEueWFtbA0K
PiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8v
YWRjL21heGltLG1heDEyNDEueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9paW8vYWRjL21heGltLG1heDEyNDEueWFtbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjI4YzczZWQ3OTVhYQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL21heGltLG1heDEy
NDEueWFtbA0KPiBAQCAtMCwwICsxLDYyIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wDQo+ICsjIENvcHlyaWdodCAyMDIwIElvYW4tQWxleGFuZHJ1IExhemFyDQo+ICsl
WUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9p
aW8vYWRjL21heGltLG1heDEyNDEueWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiArDQo+ICt0aXRsZTogTWF4aW0gTUFYMTI0
MSAxMi1iaXQsIHNpbmdsZS1jaGFubmVsIGFuYWxvZyB0byBkaWdpdGFsIGNvbnZlcnRlcg0KPiAr
DQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBJb2FuLUFsZXhhbmRydSBMYXphciA8YWxhemFyQHN0
YXJ0bWFpbC5jb20+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOiB8DQo+ICsgIEJpbmRpbmdzIGZvciB0
aGUgbWF4MTI0MSAxMi1iaXQsIHNpbmdsZS1jaGFubmVsIEFEQyBkZXZpY2UuIFRoaXMNCj4gKyAg
ZHJpdmVyIHN1cHBvcnRzIHZvbHRhZ2UgcmVhZGluZyBhbmQgY2FuIG9wdGlvbmFsbHkgYmUgY29u
ZmlndXJlZCBmb3INCj4gKyAgcG93ZXItZG93biBtb2RlIG9wZXJhdGlvbi4gVGhlIGRhdGFzaGVl
dCBjYW4gYmUgZm91bmQgYXQ6DQo+ICsgICAgaHR0cHM6Ly9kYXRhc2hlZXRzLm1heGltaW50ZWdy
YXRlZC5jb20vZW4vZHMvTUFYMTI0MC1NQVgxMjQxLnBkZg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0K
PiArICBjb21wYXRpYmxlOg0KPiArICAgIGVudW06DQo+ICsgICAgICAtIG1heGltLG1heDEyNDEN
Cj4gKw0KPiArICByZWc6DQo+ICsgICAgZGVzY3JpcHRpb246IFNQSSBjaGlwIHNlbGVjdCBudW1i
ZXIgZm9yIHRoaXMgZGV2aWNlDQoNClJvYiB3aWxsIHByb2JhYmx5IGNvbXBsYWluIHRoYXQgeW91
IGRvbid0IG5lZWQgdG8gZG9jdW1lbnRbYWRkIGRlc2NyaXB0aW9uXSB0bw0Kc3RhbmRhcmQgYXR0
cmlidXRlcyBbbGlrZSBTUEkncyAncmVnJyBwYXJhbWV0ZXJdDQpKdXN0IGxpc3RpbmcgaXQgaGVy
ZSwgc2hvdWxkIGJlIHN1ZmZpY2llbnQuIFNvLCB5b3UgY2FuIGRyb3AgdGhlIGRlc2NyaXB0aW9u
Lg0KDQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICB2cmVmLXN1cHBseToNCj4gKyAgICBk
ZXNjcmlwdGlvbjoNCj4gKyAgICAgIERldmljZSB0cmVlIGlkZW50aWZpZXIgb2YgdGhlIHJlZ3Vs
YXRvciB0aGF0IHByb3ZpZGVzIHRoZSBleHRlcm5hbA0KPiArICAgICAgcmVmZXJlbmNlIHZvbHRh
Z2UuDQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBzaGRuLWdwaW9zOg0KPiArICAgIGRl
c2NyaXB0aW9uOg0KPiArICAgICAgR1BJTyBzcGVjIGZvciB0aGUgR1BJTyBwaW4gY29ubmVjdGVk
IHRvIHRoZSBBREMncyAvU0hETiBwaW4uIElmDQo+ICsgICAgICBzcGVjaWZpZWQsIHRoZSAvU0hE
TiBwaW4gd2lsbCBiZSBhc3NlcnRlZCBiZXR3ZWVuIGNvbnZlcnNpb25zLA0KPiArICAgICAgdGh1
cyBlbmFibGluZyBwb3dlci1kb3duIG1vZGUuDQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiAr
cmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAtIHZyZWYtc3Vw
cGx5DQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvZ3Bpby9ncGlvLmg+DQo+ICsgICAgc3BpMCB7DQo+ICsgICAgICAjYWRkcmVzcy1jZWxs
cyA9IDwxPjsNCj4gKyAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiArDQo+ICsgICAgICAgIGFk
Y0AwIHsNCj4gKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWF4aW0sbWF4MTI0MSI7DQo+ICsg
ICAgICAgICAgICByZWcgPSA8MD47DQo+ICsgICAgICAgICAgICB2cmVmLXN1cHBseSA9IDwmdmRk
XzN2M19yZWc+Ow0KPiArICAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMD47
DQo+ICsgICAgICAgICAgICBzaGRuLWdwaW9zID0gPCZncGlvIDI2IDE+Ow0KPiArICAgICAgICB9
Ow0KPiArICAgIH07DQo+ICsNCj4gKw0K
