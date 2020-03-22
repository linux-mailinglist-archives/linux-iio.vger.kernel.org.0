Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F37318E7B7
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 10:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCVJHO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 05:07:14 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35094 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgCVJHO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 05:07:14 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02M92k1R006949;
        Sun, 22 Mar 2020 05:06:46 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywfu52r0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Mar 2020 05:06:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAXev3HhjDoBcMoS07isc97jynXgikf8Nn809fhxymMicx3lq+X+mMqbJgAz+wqA7X+FQzCLWFnmYUwglgO7Fe/FbZJ2r+aYLQpRlwefvhKFkQTAm+PWzklExDclkEzpoaXkx29+rWzKoVg8lhfnZCAD1yhlH8EfakgdlYJzoswTauRSAwob/odAojj9rAsktI8OISBwtmSetMk1EmljTIYOygDSqgX7Xp53bRFvGS1aYNL8Zs5a36pLBxZUf7IeX9NLLSOBuKKrbcc/zz2R2t1uXDwGqjh+ghdDgxG/GQuFJ9wUchNhSIPC27XgyDQZK0jGBKqbc3XWJPi9LyD4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcXtBYUYK05wQDNiHkFljDDlqYWaoV/E1L/viSxG1AM=;
 b=IVaxPNCc73k2EYeeNhBA0ZPmTPQBXDmhqRLvExH+uXiiRX4ll5uFP31UCKsoJ5nk+92i7wh46pUAopAQ6PNtrz/SozOdMxmhcdQODo2xtJ+ZYGvsOjuy+WTOw4cnXGfhxyiy6KZXlIRNWT4ZAMsbzJVgYYwlg+mZctpWqXwJiaIyNC9S5drIPjhv1Ln+jxnCKOrPGrhYO4bvOucX9U5XakNnl8sFPeJf+16F+HNPxvROQvYxn7yqm0LjuV/HCzxzS2YKuwgsHW5mA9m+35k6qCHjvO51yCRnFBWCfHqjUYwNM8rKDLbf1f8i0aQny/4ROV/pq8sRO5ayChaB7vlAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcXtBYUYK05wQDNiHkFljDDlqYWaoV/E1L/viSxG1AM=;
 b=tD2O6YK26Dvu2tbanuDocM4oM55cOhVcYcxbs0eolR79vTdkmsCyhz/0ymoCyupWxepwL5FsnD5+goSH0uW6CUaE5Y7qg7RQHiF0xZA7p6Z5daMgbdPaoqXu18Uk/ZhDDmz+rniKiq2Ve/167YT6zA/GFPB7Pu9TIdR22spEkVE=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5131.namprd03.prod.outlook.com (2603:10b6:5:1f0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Sun, 22 Mar
 2020 09:06:44 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2814.025; Sun, 22 Mar 2020
 09:06:44 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "mh12gx2825@gmail.com" <mh12gx2825@gmail.com>
CC:     "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "julia.lawall@inria.fr" <julia.lawall@inria.fr>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>
Subject: Re: [Outreachy kernel] Re: [PATCH 2/2] staging: iio: adc: ad7280a:
 Add spaces around operators
Thread-Topic: [Outreachy kernel] Re: [PATCH 2/2] staging: iio: adc: ad7280a:
 Add spaces around operators
Thread-Index: AQHV/N2ybpBps/EzlU+x4vN/65WR1qhN21wAgACaLgCAAAHwAIAAEgeAgAABOICAAAkcgIAA63EA////4QCAAAIeAIAAmGYAgALCqICAAXxagA==
Date:   Sun, 22 Mar 2020 09:06:44 +0000
Message-ID: <9d229b3a96954fda8ed13008511e9e8144e4e6ea.camel@analog.com>
References: <20200318060038.GB1594471@kroah.com>
         <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
         <20200318151924.GB2862853@kroah.com> <20200318162353.GA23226@deeUbuntu>
         <alpine.DEB.2.21.2003181727440.2979@hadrien>
         <20200318170051.GA23498@deeUbuntu>
         <b471d6102a731d577fff9f2175d4e35217a45e18.camel@analog.com>
         <alpine.DEB.2.21.2003190802450.3010@hadrien>
         <f783d807e2e74ae492c83eb9827ac43767411808.camel@analog.com>
         <20200319161608.GA14738@deeUbuntu> <20200321102522.GA3019@deeUbuntu>
In-Reply-To: <20200321102522.GA3019@deeUbuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 318d9e9e-90fc-476d-84e5-08d7ce4057eb
x-ms-traffictypediagnostic: DM6PR03MB5131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB513107544A1126038D5DA9CCF9F30@DM6PR03MB5131.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(346002)(376002)(366004)(136003)(199004)(36756003)(8676002)(81166006)(81156014)(8936002)(2906002)(66476007)(53546011)(66556008)(966005)(66446008)(64756008)(54906003)(316002)(6486002)(86362001)(66946007)(6916009)(91956017)(76116006)(6512007)(6506007)(2616005)(186003)(71200400001)(5660300002)(4326008)(26005)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5131;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LmtBV49T+lrZrCRoXsAHV1wDdyD+E22voLO7Py98tVklHZQl+5nnVWw2YdaSLKCPTiB2dVaZcMAioXQXnxfDamTpX6a7CO5miuFC5kfqtLXVQSSsdqTJGW6oqRfVf9IUnrY/fhuVjwZoNd1kLyUdqTjE+yR4e22U7vsZvhwNQrbBJTKRmXxFKnG6iNp8iDz0riTetXsiDb0dqeJf3k/K1yKCfeMfh8okQ9YSb58N7enLehkW5Kbldw2dl+qVnnES4oIGyKo1TowhHeJYz7a236N70qEK84TVtuM5AnCR60M8v0lBu1UNR1IKLpXEwwHk3Kvpu9gzIiG9guPYPG8/YjwDjcTu78jB8gwlsv+E7sGY6EVb47d4nsFpx7jHOVOQ/IGodybQfd1G34XdBjf9zELXsR4Uto44BKIhtmF3B/HPbc1NUcdEMpoZ4ik0eSiPlvzkM/nYTDJQWsmw5MF2DSW+9c1HAs3c0wR6t16Xy/PVx5Op7Bcgoz1YBS0C6P8zc5h34TtsAv3iPddSuiPIrw==
x-ms-exchange-antispam-messagedata: HP/gFOG7NCjN0wtr6K6muFxCvvdTJSauqaadavUKADm+h5+KUjDo6gz0oTuZWIwGLz9FRS/fieX2OTvmgTdFCjEZ1gShwd77luWc+4DHRsSQTQ+7EbT39H9SZ1jlRuOvEOgVU1aNyyseCoMkRNwdeA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <32C220BB0F663B49816DC1CDAAE01012@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318d9e9e-90fc-476d-84e5-08d7ce4057eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 09:06:44.2447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDhI5T7C99ttp6K5ITg6eSG6UcX+8/k5a5hsj5Ug7rC/hDindwI5xNfE+5xqpgJ37N+lulS6B5U2IZ8wsS22c0tEvb6BJ6/CpUn5mj0VSbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5131
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-22_02:2020-03-21,2020-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1031 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003220053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDIwLTAzLTIxIGF0IDE1OjU1ICswNTMwLCBERUVQQUsgVkFSTUEgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFRodSwgTWFyIDE5LCAyMDIwIGF0IDA5OjQ2OjEwUE0gKzA1
MzAsIERFRVBBSyBWQVJNQSB3cm90ZToNCj4gPiBPbiBUaHUsIE1hciAxOSwgMjAyMCBhdCAwNzow
NzoyMEFNICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiA+ID4gT24gVGh1LCAy
MDIwLTAzLTE5IGF0IDA4OjAzICswMTAwLCBKdWxpYSBMYXdhbGwgd3JvdGU6DQo+ID4gPiA+IFtF
eHRlcm5hbF0NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gT24gVGh1LCAx
OSBNYXIgMjAyMCwgQXJkZWxlYW4sIEFsZXhhbmRydSB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+
ID4gT24gV2VkLCAyMDIwLTAzLTE4IGF0IDIyOjMwICswNTMwLCBERUVQQUsgVkFSTUEgd3JvdGU6
DQo+ID4gPiA+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIFdl
ZCwgTWFyIDE4LCAyMDIwIGF0IDA1OjI4OjE3UE0gKzAxMDAsIEp1bGlhIExhd2FsbCB3cm90ZToN
Cj4gPiA+ID4gPiA+ID4gT24gV2VkLCAxOCBNYXIgMjAyMCwgREVFUEFLIFZBUk1BIHdyb3RlOg0K
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAw
NDoxOToyNFBNICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gT24gV2Vk
LCBNYXIgMTgsIDIwMjAgYXQgMDQ6MTI6MjhQTSArMDEwMCwgTGFycy1QZXRlciBDbGF1c2VuDQo+
ID4gPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gMy8xOC8yMCA3
OjAwIEFNLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFdlZCwgTWFy
IDE4LCAyMDIwIGF0IDA5OjU4OjEzQU0gKzA1MzAsIERlZXBhayBSIFZhcm1hDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBBZGQgc3BhY2VzIGFy
b3VuZCBvcGVyYXRvciBzeW1ib2xzIHRvIGltcHJvdmUNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IHJlYWRhYmlsaXR5Lg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2FybmluZw0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gZmxhZ2dlZCBieSBjaGVja3BhdGNoIHNjcmlwdC4NCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRGVl
cGFrIFIgVmFybWEgPG1oMTJneDI4MjVAZ21haWwuY29tPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gLS0tDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgIGRyaXZlcnMvc3RhZ2luZy9paW8vYWRj
L2FkNzI4MGEuYyB8IDQgKystLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFn
aW5nL2lpby9hZGMvYWQ3MjgwYS5jDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMv
c3RhZ2luZy9paW8vYWRjL2FkNzI4MGEuYw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaW5kZXgg
MTlhNWYyNDRkY2FlLi4zNGNhMGQwOWRiODUgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDcyODBhLmMNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzI4MGEuYw0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gQEAgLTgyNSwxNCArODI1LDE0IEBAIHN0YXRpYyBpcnFyZXR1cm5f
dA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYWQ3MjgwX2V2ZW50X2hhbmRsZXIoaW50DQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBpcnEsIHZvaWQgKnByaXZhdGUpDQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiAgIH0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgc3RhdGljIElJT19ERVZJQ0Vf
QVRUUl9OQU1FRChpbl90aHJlc2hfbG93X3ZhbHVlLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
LQkJCSAgICAgaW5fdm9sdGFnZS0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHZvbHRhZ2VfdGhy
ZXNoX2xvd192YWx1ZSwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsJCQkgICAgIGluX3ZvbHRh
Z2UgLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdm9sdGFnZV90aHJlc2hfbG93X3ZhbHVlLA0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAJCQkgICAgIDA2NDQsDQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiAgIAkJCSAgICAgYWQ3MjgwX3JlYWRfY2hhbm5lbF9jb25maWcsDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiAgIAkJCSAgICAgYWQ3MjgwX3dyaXRlX2NoYW5uZWxfY29uZmlnDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiAsDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgIAkJCSAgICAg
QUQ3MjgwQV9DRUxMX1VOREVSVk9MVEFHRSk7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgIHN0
YXRpYyBJSU9fREVWSUNFX0FUVFJfTkFNRUQoaW5fdGhyZXNoX2hpZ2hfdmFsdWUsDQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAtCQkJICAgICBpbl92b2x0YWdlLQ0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gdm9sdGFnZV90aHJlc2hfaGlnaF92YWx1ZSwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ICsJCQkgICAgIGluX3ZvbHRhZ2UgLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdm9sdGFnZV90
aHJlc2hfaGlnaF92YWx1ZSwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgCQkJICAgICAwNjQ0
LA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAJCQkgICAgIGFkNzI4MF9yZWFkX2NoYW5uZWxf
Y29uZmlnLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAJCQkgICAgIGFkNzI4MF93cml0ZV9j
aGFubmVsX2NvbmZpZw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLA0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IERpZCB5b3UgdHJ5IGJ1aWxkaW5nIHRoaXMg
Y29kZT8NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJdCBj
YXRjaGVzIGV2ZXJ5b25lLi4uDQo+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+
ID4gPiBUaGUgcHJvYmxlbSBpcyBpdCBidWlsZHMuIFRoZSB0b2tlbiBpcyBzdHJpbmd5ZmllZCBh
bmQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gImluX3ZvbHRhZ2UgLSB2b2x0YWdlX3RocmVzaF9oaWdo
X3ZhbHVlIiBpcyBhIHZhbGlkIHN0cmluZy4NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiA+ID4gQWgsIEkgdGhvdWdodCBpdCB1c2VkIHRvIGJyZWFrIHRoZSBidWlsZCB3aGVuIGl0
IGhhcHBlbmVkLiAgT2gNCj4gPiA+ID4gPiA+ID4gPiA+IHdlbGwsDQo+ID4gPiA+ID4gPiA+ID4g
PiBpdCdzIHN0aWxsIGEgZ3JlYXQgInRyaWNrIiB0byBzZWUgaWYgcGVvcGxlIHVuZGVyc3RhbmQg
QyBvcg0KPiA+ID4gPiA+ID4gPiA+ID4gbm90IDopDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiBZZXMsIGl0IGRpZCBidWlsZC4gSSBhbSBzb3JyeSBidXQgSSBhbSBub3QgZm9s
bG93aW5nIHlvdSBmdWxseS4NCj4gPiA+ID4gPiA+ID4gPiBDYW4NCj4gPiA+ID4gPiA+ID4gPiB5
b3UNCj4gPiA+ID4gPiA+ID4gPiBwbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlIGNoYW5nZSBJIGlu
dHJvZHVjZWQgaXMgbm90IGdvb2QuIFlvdQ0KPiA+ID4gPiA+ID4gPiA+IG1heQ0KPiA+ID4gPiA+
ID4gPiA+IHBsZWFzZSBkaXJlY3QgbWUgdG8gYSBkb2N1bWVudCB3aGVyZSBJIGNhbiByZWFkIG1v
cmUgYWJvdXQgaXQuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBUaGUgY29kZSBpbnZv
bHZlcyBhIG1hY3JvLCBhcyBpbmRpY2F0ZWQgYnkgdGhlIGNhcGl0YWwNCj4gPiA+ID4gPiA+ID4g
bGV0dGVycy4gIFlvdQ0KPiA+ID4gPiA+ID4gPiB3aWxsDQo+ID4gPiA+ID4gPiA+IHNlZSB0aGUg
aXNzdWUgd2hlbiB5b3UgbG9vayBhdCB0aGUgZGVmaW5pdGlvbiBvZiB0aGUgbWFjcm8uDQo+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBqdWxpYQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBUaGFuayB5b3UgSnVsaWEgYW5kIGFsbC4gSSBnb3QgbXkgbWlzdGFrZS4gSSB3aWxsIHJldmVy
dCB0aGUgY2hhbmdlLg0KPiA+ID4gPiA+ID4gU29ycnkgZm9yIHRoZSB0cm91YmxlLg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IEknbGwgdHJ5IHRvIG1ha2Ugc29tZSB0aW1lIHRvIGFkZHJlc3MgdGhp
cyBzb21laG93LCBzbyB0aGF0IGNoZWNrcGF0Y2gNCj4gPiA+ID4gPiBkb2Vzbid0DQo+ID4gPiA+
ID4gYnVtcCBpbnRvIHRoaXMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSW4gdGhlIGxhc3QgMi0z
IHllYXJzLCBJIHRoaW5rIEkgc2F3IDMtNCBwYXRjaGVzIHRyeWluZyB0byBhZGRyZXNzDQo+ID4g
PiA+ID4gdGhpcyBbZm9yDQo+ID4gPiA+ID4gdmFyaW91cyBBbmFsb2cgZHJpdmVyc10uDQo+ID4g
PiA+ID4gU28sIGRvbid0IGZlZWwgdG9vIGJhZC4NCj4gPiA+ID4gDQo+ID4gPiA+IE1heWJlIGEg
Y29tbWVudD8NCj4gPiA+IA0KPiA+ID4gQ29tbWVudCB3b3JrcyBmb3Igbm93Lg0KPiA+ID4gQW55
Ym9keSB3YW50cyB0byBkbyBhIHBhdGNoIGZvciB0aGF0Pw0KPiA+ID4gSWYgbm9ib2R5IHNlbmRz
IGEgcGF0Y2ggZm9yIHRoaXMgaW4gMS0yIHdlZWtzLCBJJ2xsIHNlbmQgb25lLg0KPiA+ID4gDQo+
ID4gPiBQYXJ0aWN1bGFybHksIHRoaXMgd291bGQgaGVscCB3aXRoIHJldmlldywgc2luY2UgcGVv
cGxlIHRoYXQgYXJlDQo+ID4gPiB1bmZhbWlsaWFyIHdpdGgNCj4gPiA+IElJTy1zcGVjaWZpYyBt
YWNyb3Mgd291bGQgYWxzbyBmaW5kIGl0IGVhc2llciBhdCByZXZpZXcuDQo+ID4gPiANCj4gPiA+
IFRoZSBnb29kIHBhcnQsIGlzIHRoYXQgaXQncyBvbmx5IG5lZWRlZCBmb3IgQUQ3MjgwQS4NCj4g
PiA+IEFENzE5MiBoYXMgYmVlbiByZS13b3JrZWQsIGFuZCBpcyBubyBsb25nZXIgb24gY2hlY2tw
YXRjaCdzIHJhZGFyLg0KPiA+ID4gSSdtIHJld29ya2luZyBBRDc3OTMgbm93Lg0KPiA+ID4gDQo+
ID4gDQo+ID4gSSB3aWxsIGJlIGhhcHB5IHRvIGFkZCBhIGNvbW1lbnQgYXJvdW5kIHRoZSBjb2Rl
IGFyZWEgdG8gaW5kaWNhdGUNCj4gPiBpZ25vcmUgY2hlY2twYXRjaCB3YXJuaW5nIGZvciB0aGUg
bWVudGlvbmVkIGFyZ3VtZW50LiBQbGVhc2UgY29uZmlybSBpZg0KPiA+IHRoYXQgaXMgd2hhdCB5
b3UgYXJlIGV4cGVjdGluZyB0byBiZSBkb25lLg0KPiA+IA0KPiANCj4gSGVsbG8gQWxleGFuZHJ1
LA0KPiBjb3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gaWYgSSBzaG91bGQgYWRkIGEgY29tbWVudCBh
cm91bmQgdGhlIGNvZGUgaW4NCj4gYWQ3MjgwYS5jIHRvIGF2b2lkIGZ1cnRoZXIgY2hhbmdlcyBi
ZWluZyBtYWRlIHRvIHRoZSBzdHJpbmcgYXJndW1lbnQ/DQoNClN1cmUuDQpQbGVhc2Ugc2VuZCBh
IHBhdGNoLg0KWyBJIGFscmVhZHkgcmVwbGllZCB0aGlzIGEgZmV3IGRheXMgYWdvOyBtdXN0IGhh
dmUgZ290dGVuIGxvc3QgaW4gc29tZSBlbWFpbHMgXQ0KDQoNCj4gDQo+IA0KPiA+IFRoYW5rcywN
Cj4gPiBEZWVwYWsuDQo+ID4gDQo+ID4gPiA+IGp1bGlhDQo+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
RGVlcGFrLg0KPiA+ID4gPiA+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gPiA+ID4gPiBEZWVwYWsu
DQo+ID4gPiA+ID4gPiA+ID4gPiB0aGFua3MsDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiA+IGdyZWcgay1oDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gLS0N
Cj4gPiA+ID4gPiA+ID4gPiBZb3UgcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGJlY2F1c2UgeW91IGFy
ZSBzdWJzY3JpYmVkIHRvIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IEdvb2dsZQ0KPiA+ID4gPiA+ID4g
PiA+IEdyb3Vwcw0KPiA+ID4gPiA+ID4gPiA+ICJvdXRyZWFjaHkta2VybmVsIiBncm91cC4NCj4g
PiA+ID4gPiA+ID4gPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgZ3JvdXAgYW5kIHN0b3AgcmVj
ZWl2aW5nIGVtYWlscyBmcm9tDQo+ID4gPiA+ID4gPiA+ID4gaXQsIHNlbmQNCj4gPiA+ID4gPiA+
ID4gPiBhbg0KPiA+ID4gPiA+ID4gPiA+IGVtYWlsIHRvIG91dHJlYWNoeS1rZXJuZWwrdW5zdWJz
Y3JpYmVAZ29vZ2xlZ3JvdXBzLmNvbS4NCj4gPiA+ID4gPiA+ID4gPiBUbyB2aWV3IHRoaXMgZGlz
Y3Vzc2lvbiBvbiB0aGUgd2ViIHZpc2l0DQo+ID4gPiA+ID4gPiA+ID4gaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9tc2dpZC9vdXRyZWFjaHkt
a2VybmVsLzIwMjAwMzE4MTYyMzUzLkdBMjMyMjYqNDBkZWVVYnVudHVfXztKUSEhQTNOaThDUzB5
MlkhdVU5NWtHOEtPTXZUeHo3UHRnSW0yZ3ppWHJyS1BFZlJEc2xoWUV1RHNyaFBoWGxZeGFZY1gt
NzBhNklwaTFvTHRneWludyQgDQo+ID4gPiA+ID4gPiA+ID4gLg0KPiA+ID4gPiA+ID4gPiA+IA0K
