Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5721E5C42
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 11:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgE1JnU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 05:43:20 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:55180 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728300AbgE1JnT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 05:43:19 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04S9aM3B018629;
        Thu, 28 May 2020 05:43:00 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-00128a01.pphosted.com with ESMTP id 316wkb5n1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 05:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcZFZgQp2W0x6+CJ2DlmIC9z0cy1eURktvMI2CBfXcbKEejViDTTnQYHOC12L9mMyd/AqnsI/AzKUw+7M9LgjsWGibGSUF5GpNPY20YTSiojq3XIsdT7MnWZJ34a0askiP4R3hiXVAHn8edJh+wKmRNGQUDulXKy3j4XKs2bpaXWIWwGldgHwaffUXrRGyyPrrPsiBeDQWQ7W8AW50Qm0SIQi46fR8Qy36Ls5bbP3fWmI2lVDVkgziiNKiHmQyX+/+m2WL1EiWvvTZezkZAuQ6L8MFKpuMDNIL82Xs4iMg/FO6Z3fEgeamrX/1iHAqtigFFC/TECWb3hZwQhFrAFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0Fk8IyUHuQa7Q+i/BR9vNy1BYJpdd4sRxo6RwsTBcA=;
 b=VvFEhJvfnej4Btk/eZ6NhosEaqY1bCSQZtBPiT4zuEzPQGjXlDYvMJE7ECWqn9Y28RUyUPsZ1J2L3MLXX9pNbIjHT+hsos1PQ9sRBrzASMLM/vUhgWJvhN0QUXTpK2LycJBOCk6OK3Pvrcuhne95PLGGe1ocPTdX2RmnJvPG78aB1dF/2RW2ZmrkRTbRv+vFo5ToCZHeaGZP4sWULdByjz/fL1uJzSKPu2CbtQJzbDAxGs52xvavLhvSJ+PwcoM0kGPuLyx8vfs3wJLix1PKts8b8LKzUhCYdGSv3998Wlri2xEL5Dt5aXp/spzEp8HrBcENR4nkiBI+0FoayfGyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0Fk8IyUHuQa7Q+i/BR9vNy1BYJpdd4sRxo6RwsTBcA=;
 b=u1iRWfH762VNxvGILdwNZN0mlGKrLazzHijs5hcFSxQR4W3YS1P7mZHVJNu+4cJ4lyFnJLd+xqV9N8YiptDCISIabLoKl73t4WNdaCdYEsHp1JUzrpS7kK1C9D7T2I6laISXa3muyw5URixgjQz/eLICkVO7g73MOW5Mu90Pcqs=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4380.namprd03.prod.outlook.com (2603:10b6:5:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Thu, 28 May
 2020 09:42:56 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 09:42:56 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "hslester96@gmail.com" <hslester96@gmail.com>
CC:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.cercueil@analog.com" <paul.cercueil@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH v2] iio: amplifiers: ad8366: Add the missed check for
 devm_gpiod_get()
Thread-Topic: [PATCH v2] iio: amplifiers: ad8366: Add the missed check for
 devm_gpiod_get()
Thread-Index: AQHWNLrqjELUbIiCO02AUu0RU7WKsai9P0OA
Date:   Thu, 28 May 2020 09:42:56 +0000
Message-ID: <9d08ae7284e1b0b57c5328545c5c5bbe96b210ef.camel@analog.com>
References: <20200528064027.546944-1-hslester96@gmail.com>
In-Reply-To: <20200528064027.546944-1-hslester96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bea55141-9ad1-4b30-4161-08d802eb8015
x-ms-traffictypediagnostic: DM6PR03MB4380:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB43803494EBB65CD2DD42A300F98E0@DM6PR03MB4380.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GljcM85qwXeGbu9l4GHLeGhz8iu3Mvrws3TX1/pCFe2RPgWwqKIehlT7WBWa5dz8G7/HO2vM3jxH4LVzlBP/J1AC3pRWHgy7V02ROxlsZrpO7fcyw7vF/4lpx8bV5WOZBh/U39eMuZB4eAaJRopJfZMM6cc9hp2MOa6R65qI6Csr5kO2f9tSHzeki/iC+7730ZnUr2pA+eYQaV+hqGUm8O/QRyRtDovraNJrgCB0COUwF5zMDq8/QscvtYbyVcaHe7OTbmQQEl9iuteSpqIc96SNgINETrKXCmU0ydWjCvx9BBrf1ysSc/h4BoZpyUAKhiKfCx2zpQHSPmCkGLPQiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(376002)(39860400002)(346002)(4326008)(6486002)(6506007)(66446008)(2906002)(66476007)(64756008)(66556008)(26005)(186003)(316002)(8676002)(6916009)(54906003)(5660300002)(8936002)(86362001)(478600001)(76116006)(66946007)(91956017)(6512007)(36756003)(2616005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /YGCvb2X5SdMjljCmTfez3oaLke/uFQf1qurOt8A+CM843Tnibj3BexDkXGIMOXhG2VtAMIRogNhdzjfI6NHpaVTlFv5etrtLKP0/9PswjNARyWmM7MdMj1nzMPY5K8o99PbzFdFX7dy/f1XHrFABKPZc4LrmYnKLJvPtjmQ1mxh0CLQe9yr3+mUqY0hL2V+MPFrgGK/gd5JGyhPORGnBfrNIJizOk7gKRsYzwkcbExHIg0RxjzKqtI01ERsFBtwWNBvMfndSueidgtfwiuNMsfRv0MvcScOYtjpI0Ci0VHmNFQKBsP6Vk2vgGXrZbmy7nHgYcH+HGSZx0P+1CNdEc2ZQ0sS/8xJoxfjNQDZIChHPRp25t+3M6ulon5cT4Ugc2bEcbWyv7xojbIFjZTtlScn6FMGmnHlaZEqrmWzoP+bfxDraU5laoG+tp1SCPOkEbozIqWZZkbgPRRtn/yEyQawMo3y6bzSIOGi1aACj1XPXNYc1IG+8kHYl8drdZtX
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB40F26227D5B142ABBA12D838E3031F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea55141-9ad1-4b30-4161-08d802eb8015
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 09:42:56.1092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnBNUK1U18PzzzPO/x9hjT+vT7B4ZvFhg8lJlPSyHGtKt8OcHcLYzIJMOtpZPIO0TdXok41isk+66hV/CaSHDffUwtIhdAw/qgNdsbhH6rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4380
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_02:2020-05-28,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 cotscore=-2147483648 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280065
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTI4IGF0IDE0OjQwICswODAwLCBDaHVob25nIFl1YW4gd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IGFkODM2Nl9wcm9iZSgpIGZvcmdldHMgdG8gY2hlY2sgdGhlIHJl
dHVybiB2YWx1ZSBvZiBkZXZtX2dwaW9kX2dldCgpLg0KPiBBZGQgdGhlIG1pc3NlZCBjaGVjayB0
byBmaXggaXQuDQo+IA0KPiBGaXhlczogY2VlMjExZjRlNWEwICgiaWlvOiBhbXBsaWZpZXJzOiBh
ZDgzNjY6IEFkZCBzdXBwb3J0IGZvciB0aGUNCj4gQURBNDk2MSBER0EiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBDaHVob25nIFl1YW4gPGhzbGVzdGVyOTZAZ21haWwuY29tPg0KPiAtLS0NCj4gQ2hhbmdl
cyBpbiB2MjoNCj4gICAtIEFkZCBmaXhlcyB0YWcuDQo+IA0KPiAgZHJpdmVycy9paW8vYW1wbGlm
aWVycy9hZDgzNjYuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FtcGxpZmllcnMvYWQ4MzY2LmMNCj4g
Yi9kcml2ZXJzL2lpby9hbXBsaWZpZXJzL2FkODM2Ni5jDQo+IGluZGV4IDYyMTY3Yjg3Y2FlYS4u
Yjk5NjgyM2M4ZDUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hbXBsaWZpZXJzL2FkODM2
Ni5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FtcGxpZmllcnMvYWQ4MzY2LmMNCj4gQEAgLTI2NCw2
ICsyNjQsMTAgQEAgc3RhdGljIGludCBhZDgzNjZfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNw
aSkNCj4gIAljYXNlIElEX0hNQzExMTk6DQo+ICAJCXN0LT5yZXNldF9ncGlvID0gZGV2bV9ncGlv
ZF9nZXQoJnNwaS0+ZGV2LCAicmVzZXQiLA0KPiAgCQkJR1BJT0RfT1VUX0hJR0gpOw0KDQp0aGlz
IGlzIHNlbWktaW50ZW50aW9uYWwgaSBndWVzczsNCmluIHRoZSBzZW5zZSB0aGF0IGlmIHRoZXJl
IGlzIG5vIEdQSU8sIG5vdGhpbmcgaGFwcGVuczsNCg0KbWF5YmUgY29udmVydCB0aGlzIHRvIGRl
dm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKCkNCm90aGVyd2lzZSwgaWYgdGhlcmUgaXMgbm8gcmVzZXQg
R1BJTywgdGhpcyBjYW4gZmFpbCB0aGUgcHJvYmU7IGFuZCB0aGUgR1BJTw0KaXMgbm90IG9wdGlv
bmFsOw0KcmVzdCBvZiB0aGUgY29kZSBsb29rcyBmaW5lICh3aXRoIHRoZSBkZXZtX2dwaW9kX2dl
dF9vcHRpb25hbCgpDQptb2RpZmljYXRpb24pDQoNCj4gKwkJaWYgKElTX0VSUihzdC0+cmVzZXRf
Z3BpbykpIHsNCj4gKwkJCXJldCA9IFBUUl9FUlIoc3QtPnJlc2V0X2dwaW8pOw0KPiArCQkJZ290
byBlcnJvcl9kaXNhYmxlX3JlZzsNCj4gKwkJfQ0KPiAgCQlpbmRpb19kZXYtPmNoYW5uZWxzID0g
YWRhNDk2MV9jaGFubmVsczsNCj4gIAkJaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMgPSBBUlJBWV9T
SVpFKGFkYTQ5NjFfY2hhbm5lbHMpOw0KPiAgCQlicmVhazsNCg==
