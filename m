Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA4171133
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 08:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbgB0HAg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 02:00:36 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52434 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbgB0HAf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 02:00:35 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R6u31B018315;
        Thu, 27 Feb 2020 02:00:33 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrx28nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 02:00:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2nxMqCuEQetIwGuIyE6KJcND1HzfSxtmtWOPY0JAP7kmXa0JO71bEaYA4EbqWltXYiF2qwzDBgyOUXASAxrHWyfuoASGp9YoIJ3EKuaEOLxaRgcXG+1Ne8zxygm9frtCmChD3qIaEbYmUdrlQ9QGBerqe7id0/IwWsaVcugu8MjC8UWZfjrELRvj5BpaQp5swsXRN4fY1L1O+CHfEmPEpk8pT+T1s4E2PxacOShtDXYfdpCJVXCDHtj3h6pUajNvwCIag2Q8g0VqTy3Yp7Ei4OAeLdSon1nyaSEZuYjpUCvhqkjiXdbgjFOyN2ugr9p1jep+GwmJVqtmat9oHIBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkUpwb0+BmnLIjjVDdoM6rJlvJrZbDkGtl29AjoO9SQ=;
 b=NHlu2VIy/NpxUePTOGn0oAB6yFoBjz+FJlcEdFfUp2VYNklaUiyTuxCI/yVriVKwlt9PQIXAp5FtRsZCEYze8Eca5OZaFtu0Beo5t9dZ9acSAaifkWvN4Gaev4BshgT6NZ+O62/7Y9PmXGkFBx/pgX2ahKXA5es4KjtiN/dQMdofIUsZgJa999sP+CUTH5NoGMJfRX7beMV+MPtrZdYeNo+Zxv9f8scI/0w0wvsgNYhWse6QiqeEKfqhvubMFcXe1oNJQ3T8cdufcJmZWCmWqFBd90C0NFieGu5UahBwq7ThXZv+Sxl+QNii3qvzyBJzbtY97PZLyflTFCLhkHaLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkUpwb0+BmnLIjjVDdoM6rJlvJrZbDkGtl29AjoO9SQ=;
 b=nrMU8VQCNEkv18oM0bYXSqbywv4T3tOIo58BJh1aoyOv3aeuEZG/M1AuWBynOWOEZhc29/BTv4zcYqC63vrs+Se8UmnT9DH1pk2oRpecj+kA2wJeJI/nWE69pKzxm2KKEpiK+NQJ7rPX/NOEF5W/vtXGTZxDBoNxXJsA9LAGeRo=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5160.namprd03.prod.outlook.com (2603:10b6:610:a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 07:00:32 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 07:00:31 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "rohitsarkar5398@gmail.com" <rohitsarkar5398@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: adc: max1363: replace mlock with own lock
Thread-Topic: [PATCH] iio: adc: max1363: replace mlock with own lock
Thread-Index: AQHV7NWLP2z6pFzH0EqHq0Zf9/CJ4agunluA
Date:   Thu, 27 Feb 2020 07:00:31 +0000
Message-ID: <b52bf5db819308d1a7456dc37882fa35508a06bf.camel@analog.com>
References: <5e56bdc3.1c69fb81.c3b20.9153@mx.google.com>
In-Reply-To: <5e56bdc3.1c69fb81.c3b20.9153@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bb72606-3df0-4e33-9e35-08d7bb52bc6a
x-ms-traffictypediagnostic: CH2PR03MB5160:
x-microsoft-antispam-prvs: <CH2PR03MB5160A905898993424E3FE0C9F9EB0@CH2PR03MB5160.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(186003)(5660300002)(2906002)(26005)(86362001)(478600001)(66446008)(64756008)(91956017)(76116006)(66476007)(66556008)(81156014)(81166006)(36756003)(8676002)(66946007)(2616005)(6506007)(110136005)(6512007)(4326008)(8936002)(71200400001)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5160;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pTC0zTk5zn7nV1M3faj/XhUHfuXalz4sYDIayoBqpOsXvPFND++FxeLVCx/OpKbiR3cRB9490NvMaTI+dWeV+8nPxYUZZmOEFD66azwxqwUYPSCp2hqib0SObb18L9iF+OB+bvz9F+eKdS+R3yZNn1rIHI2gmye2zc7QCIbeHOPcuw1E/8CvzTNzi1OFQM9zz0KbBn5QLG/u6mPAXI1Ic2SXb2bLp9m+OxNSDZPFXjlB9PVC7PITU1alJvgkpPuomPgvJPVzxaM6Bu7clAG9qQ6ckttw/XXzrw1OpWKx+n0VDEu5r3Ekc3j5KdCWimgO0BQB0druFlvc6mRiRfMh29bsTUydECJ2XdeZMaKdp0Pb8FH/gG3yIQQ0T4hpiO+RUcTWXu1T6L57kUjpAW2O6MuE46Y2UeZhhJi7ZYWrm1tB+PKsr7hFH4i3q2orz8j5
x-ms-exchange-antispam-messagedata: s7k2i54f2PyKQgmGCRLb6b18Zi2gzMxExqpe5H0nFWONe/LLKc53jbeTLh3YHJjRee2x6HMVucV8S90GfiU/3BF3zzABe2VpYpaqK18WaMaq3oTqAsa+PX9PFNz3vh0xg+nZoAvPyCvIqepe80Pk8w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AF9956E5E60A842B225D02DE9B7C083@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb72606-3df0-4e33-9e35-08d7bb52bc6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 07:00:31.8343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KV8oTgdOf76RXfwN5RIbVXDiPYC4oVbL7Btz+9ifFGZz1nIG1xpqaxA1UfgwebRSQSajVchmhnhgg39rqROaJD8UyEe49bEsAzydfngkVzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5160
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_01:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270054
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTI3IGF0IDAwOjE5ICswNTMwLCBSb2hpdCBTYXJrYXIgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFRoaXMgY2hhbmdlIHJlcGxhY2VzIGluZGlvX2RldidzIG1sb2Nr
IHdpdGggdGhlIGRyaXZlcnMgb3duIGxvY2suIEluDQo+IGVhY2ggY2FzZSB0aGUgbG9jayBpcyBu
ZWVkZWQgdG8gcHJvdGVjdCB0aGUgZHJpdmVyJ3Mgb3duIHN0YXRlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUm9oaXQgU2Fya2FyIDxyb2hpdHNhcmthcjUzOThAZ21haWwuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvaWlvL2FkYy9tYXgxMzYzLmMgfCAxMyArKysrKysrLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaWlvL2FkYy9tYXgxMzYzLmMgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTM2My5j
DQo+IGluZGV4IDVjMmNjNjFiNjY2ZS4uYjk1NTdmOTU3ZjNjIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2lpby9hZGMvbWF4MTM2My5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9tYXgxMzYzLmMN
Cj4gQEAgLTE2OSw2ICsxNjksNyBAQCBzdHJ1Y3QgbWF4MTM2M19zdGF0ZSB7DQo+ICAJY29uc3Qg
c3RydWN0IG1heDEzNjNfbW9kZQkqY3VycmVudF9tb2RlOw0KPiAgCXUzMgkJCQlyZXF1ZXN0ZWRt
YXNrOw0KPiAgCXN0cnVjdCByZWd1bGF0b3IJCSpyZWc7DQo+ICsJc3RydWN0IG11dGV4IGxvY2s7
DQoNClRoZSAnbG9jaycgZmllbGQgc2hvdWxkIGJlIGFsaWduZWQgd2l0aCAqcmVnICYgcmVxdWVz
dGVkbWFzay4NCg0KQWxzbywgaXQncyBhIGdvb2QgaWRlYSB0byBkbyBhICdtdXRleF9pbml0KCZz
dC0+bG9jayknIGluIG1heDEzNjNfcHJvYmUoKS4NClNvbWV3aGVyZSBhZnRlciAnc3QgPSBpaW9f
cHJpdihpbmRpb19kZXYpOycNCg0KUmVzdCBsb29rcyBnb29kDQoNCj4gIA0KPiAgCS8qIFVzaW5n
IG1vbml0b3IgbW9kZXMgYW5kIGJ1ZmZlciBhdCB0aGUgc2FtZSB0aW1lIGlzDQo+ICAJICAgY3Vy
cmVudGx5IG5vdCBzdXBwb3J0ZWQgKi8NCj4gQEAgLTM2NCw3ICszNjUsNyBAQCBzdGF0aWMgaW50
IG1heDEzNjNfcmVhZF9zaW5nbGVfY2hhbihzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0K
PiAgCXN0cnVjdCBtYXgxMzYzX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ICAJ
c3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHN0LT5jbGllbnQ7DQo+ICANCj4gLQltdXRleF9s
b2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gKwltdXRleF9sb2NrKCZzdC0+bG9jayk7DQo+ICAJ
LyoNCj4gIAkgKiBJZiBtb25pdG9yIG1vZGUgaXMgZW5hYmxlZCwgdGhlIG1ldGhvZCBmb3IgcmVh
ZGluZyBhIHNpbmdsZQ0KPiAgCSAqIGNoYW5uZWwgd2lsbCBoYXZlIHRvIGJlIHJhdGhlciBkaWZm
ZXJlbnQgYW5kIGhhcyBub3QgeWV0DQo+IEBAIC00MDUsNyArNDA2LDcgQEAgc3RhdGljIGludCBt
YXgxMzYzX3JlYWRfc2luZ2xlX2NoYW4oc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldiwNCj4g
IAl9DQo+ICAJKnZhbCA9IGRhdGE7DQo+ICBlcnJvcl9yZXQ6DQo+IC0JbXV0ZXhfdW5sb2NrKCZp
bmRpb19kZXYtPm1sb2NrKTsNCj4gKwltdXRleF91bmxvY2soJnN0LT5sb2NrKTsNCj4gIAlyZXR1
cm4gcmV0Ow0KPiAgDQo+ICB9DQo+IEBAIC03MDUsOSArNzA2LDkgQEAgc3RhdGljIHNzaXplX3Qg
bWF4MTM2M19tb25pdG9yX3N0b3JlX2ZyZXEoc3RydWN0IGRldmljZQ0KPiAqZGV2LA0KPiAgCWlm
ICghZm91bmQpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+IC0JbXV0ZXhfbG9jaygmaW5k
aW9fZGV2LT5tbG9jayk7DQo+ICsJbXV0ZXhfbG9jaygmc3QtPm1sb2NrKTsNCj4gIAlzdC0+bW9u
aXRvcl9zcGVlZCA9IGk7DQo+IC0JbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4g
KwltdXRleF91bmxvY2soJnN0LT5tbG9jayk7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
QEAgLTgxMCwxMiArODExLDEyIEBAIHN0YXRpYyBpbnQgbWF4MTM2M19yZWFkX2V2ZW50X2NvbmZp
ZyhzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiAgCWludCB2YWw7DQo+ICAJaW50IG51
bWJlciA9IGNoYW4tPmNoYW5uZWw7DQo+ICANCj4gLQltdXRleF9sb2NrKCZpbmRpb19kZXYtPm1s
b2NrKTsNCj4gKwltdXRleF9sb2NrKCZzdC0+bWxvY2spOw0KPiAgCWlmIChkaXIgPT0gSUlPX0VW
X0RJUl9GQUxMSU5HKQ0KPiAgCQl2YWwgPSAoMSA8PCBudW1iZXIpICYgc3QtPm1hc2tfbG93Ow0K
PiAgCWVsc2UNCj4gIAkJdmFsID0gKDEgPDwgbnVtYmVyKSAmIHN0LT5tYXNrX2hpZ2g7DQo+IC0J
bXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCj4gKwltdXRleF91bmxvY2soJnN0LT5t
bG9jayk7DQo+ICANCj4gIAlyZXR1cm4gdmFsOw0KPiAgfQ0K
