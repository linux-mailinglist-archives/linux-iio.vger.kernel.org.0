Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3404C1A622E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 06:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgDMEcK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 00:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDMEcK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 00:32:10 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3A8C0A3BE0
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2020 21:32:10 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03D4TxJG018435;
        Mon, 13 Apr 2020 00:32:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7namy5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 00:32:07 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03D4W6gE020456;
        Mon, 13 Apr 2020 00:32:06 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-00128a01.pphosted.com with ESMTP id 30b7namy5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 00:32:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMpVf74Ihf8ZZUSS3+9S3UYh4BwSUlerSxsSy53GTshV7ni09SmVW3V/gOIpXJMdRP4yohEFdJh7P+B7XEGjYwlGEllfB3FoHcZuQfF7yBy7jKDUf+wqTolX2LkxA80e2zXFy0KLf9wbCjo7qiALiz508twu40eGFprtzHa0bnASkCAyatnARE9Yk/WZVdnbXtjnNRIpolAcWjLpOTTKENueWXWG8PynJJvLvnheP31/5kn+6IK7UKSx5B7A4zPlhe+OSCCnYui/jvAVuRLX3Vr7u00jAefkFwtvRdm1cmr90zLMc2TQfBaXldjq2CMR4leNT2igTNDcVOEu1qwf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyIB5grJpd8gvXdgoZthnodimSNbpIlM59sxTALq2vE=;
 b=Ytto1YleLSm/CgZXKt/92PmhJehhjSEGWrOoc2wk2S5Ule4MUti21ovFgvSyjLFgQKv4iUe3RRDolfoBDvkgYyk5ysUheB6roGTX3ewIOLKCrDOQYlLbu9IL2/sb07TJatjKB6+35hd3e/8hQoUVVYLvfKQeGZs1vFnDffO0k+ae7sXrGHPkZoNB+JNQ4lFpWH9ckkQ0AbVuBLGTRD0U/Pt4kInkCxOE4jWVBR3a0wULhKHgwAj7HsQGoyN6eeLpD7eODZ9vSUx18yDLKG0Vrt2zBpZNUYdVFcbyOmSlJdlDC10fJXtdODwn10bTXMcBZh43bmR4arwy/p2a2uTcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyIB5grJpd8gvXdgoZthnodimSNbpIlM59sxTALq2vE=;
 b=FH2VoCr2spykeSHDWq5tt7rBcfu9hHYEPxBiEHOMV/wpgxAlQNISBETajw1PI8yIWiGRAoW1jmjF1uh1yoNiRNI/jFtdfLcnLE3iie07D4GLm7tY7Yv5PvbfYd9Rt1SSqYqHGoclQv3LrsgldyYfCubARC43nJIkHH2xKi/lvPs=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3787.namprd03.prod.outlook.com (2603:10b6:5:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Mon, 13 Apr
 2020 04:32:05 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 04:32:05 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "jmaneyrol@invensense.com" <jmaneyrol@invensense.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/6] iio:imu:mpu6050: Tidy up parameters to regmap_bulk
 functions.
Thread-Topic: [PATCH 4/6] iio:imu:mpu6050: Tidy up parameters to regmap_bulk
 functions.
Thread-Index: AQHWC3ThGKY/H0xk5USCWLugEDwG+6h2gyEA
Date:   Mon, 13 Apr 2020 04:32:04 +0000
Message-ID: <a1dd35309eaa573d04bc22102451d74e77e6daea.camel@analog.com>
References: <20200405180321.1737310-1-jic23@kernel.org>
         <20200405180321.1737310-5-jic23@kernel.org>
In-Reply-To: <20200405180321.1737310-5-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8eebd8e2-944e-4ed8-30bc-08d7df639e8c
x-ms-traffictypediagnostic: DM6PR03MB3787:
x-microsoft-antispam-prvs: <DM6PR03MB37879F4429AD52429C36F833F9DD0@DM6PR03MB3787.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(136003)(376002)(396003)(346002)(39850400004)(478600001)(110136005)(5660300002)(6512007)(36756003)(54906003)(2906002)(186003)(76116006)(26005)(316002)(91956017)(66946007)(66476007)(64756008)(66556008)(66446008)(4326008)(81156014)(2616005)(86362001)(8936002)(6486002)(71200400001)(6506007)(8676002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +j+Z9D8wBSxeEo3iVE++mI03vWi3GeKldjiroFoMEyVfXj+G1ROxoiFXOwG+GfvXXfv9sB57EybN8XTQfZVd7XGPX2ceoXISM0fxC8pbP6xwha0Uz8WO9iHPhJkdkkMs/I170wg+NcOtuADER1oeg1+ys0DCeP0kVxLfc3+vguWJyb5OZ4N9ebTk1a3KVh26cBwVzHB9kFWgXoJB72uIko0RDg/KiCeyWBbJrVp+1vS65Jk8Q2L2k6maEASv64JAZo5ez2X7xa/xlC1CELhMAxnzRDH8GpUBuwEUtMDtSz1Pi/zgt+fg2SKC0WsNlX+8KEZayVS6lh/NP3+UcXZVxWyyKR2LbD62GzWHkUtz7XOdKUjNGOBzvHCvmllF3j5lJSgWalbWszvTXr3vEQGugowLrySzrZlNeD9WiCPZDFGq3vEy5c48f6b9SddOO8Gn
x-ms-exchange-antispam-messagedata: R52UBzp4cpMX/KmC3dkNSZ+8/6ean4p3RXevyiEtHZ0wtygAmPXqHowf/MUzhHh6X28jUgknHbXw+lRBDvlL3AD5RxI2zjGseUyZUx6RsbxNnJozSqBxsoE2F/Fy+OlKPYXKdUnVgPod7Qog4lymRw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <56686565F8524E4F97E9D631B42A3E1F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eebd8e2-944e-4ed8-30bc-08d7df639e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 04:32:04.9259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7cyjRpi6wXFzwQlhWU0qJTVeY8yJSXm2PXu6gp6OW3zjfo8A6TW6WwI0f/fK7u78T45GR6/5jH9m289ZIhxYLXMb9WVkPF6zwVOwG2xzng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3787
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_01:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130040
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTA1IGF0IDE5OjAzICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBBIG1peHR1cmUgb2Y6DQo+ICogQ2FzdHMgdG8gdTggKiBmb3IgdGhlIHZhbCBwYXJh
bWV0ZXIgd2hpY2ggaXMgdm9pZCAqIGFuZCBzbyBuZWVkcyBubyBjYXN0Lg0KPiAqIEV4cGxpY2l0
IHNpemVzIHdoZW4gd2UgY2FuIHVzZSBzaXplb2Ygb24gdGhlIGRlc3RpbmF0aW9uIC8gc291cmNl
IHZhcmlhYmxlLg0KPiANCj4gTm90IGJyb2tlbiBpbiBhbnl3YXksIEknbSBqdXN0IHRyeWluZyB0
byB0aWR5IHVwIHRoZSBpcyBpbiB0aGUgc3Vic3lzdGVtIHRvDQo+IGF2b2lkIGl0IGdldHRpbmcg
Y3V0IGFuZCBwYXN0ZSBpbnRvIG5ldyBkcml2ZXJzLg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZXhh
bmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoNCj4gU2lnbmVk
LW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0K
PiBDYzogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8am1hbmV5cm9sQGludmVuc2Vuc2UuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X2NvcmUuYyB8IDQg
KystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9j
b3JlLmMNCj4gYi9kcml2ZXJzL2lpby9pbXUvaW52X21wdTYwNTAvaW52X21wdV9jb3JlLmMNCj4g
aW5kZXggZTRiMGQzNjhjMmY5Li5kMzgxOWI1MTZlYzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL2lpby9p
bXUvaW52X21wdTYwNTAvaW52X21wdV9jb3JlLmMNCj4gQEAgLTUyNiw3ICs1MjYsNyBAQCBzdGF0
aWMgaW50IGludl9tcHU2MDUwX3NlbnNvcl9zZXQoc3RydWN0DQo+IGludl9tcHU2MDUwX3N0YXRl
ICAqc3QsIGludCByZWcsDQo+ICAJX19iZTE2IGQgPSBjcHVfdG9fYmUxNih2YWwpOw0KPiAgDQo+
ICAJaW5kID0gKGF4aXMgLSBJSU9fTU9EX1gpICogMjsNCj4gLQlyZXN1bHQgPSByZWdtYXBfYnVs
a193cml0ZShzdC0+bWFwLCByZWcgKyBpbmQsICh1OCAqKSZkLCAyKTsNCj4gKwlyZXN1bHQgPSBy
ZWdtYXBfYnVsa193cml0ZShzdC0+bWFwLCByZWcgKyBpbmQsICZkLCBzaXplb2YoZCkpOw0KPiAg
CWlmIChyZXN1bHQpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+IEBAIC01NDAsNyArNTQw
LDcgQEAgc3RhdGljIGludCBpbnZfbXB1NjA1MF9zZW5zb3Jfc2hvdyhzdHJ1Y3QNCj4gaW52X21w
dTYwNTBfc3RhdGUgICpzdCwgaW50IHJlZywNCj4gIAlfX2JlMTYgZDsNCj4gIA0KPiAgCWluZCA9
IChheGlzIC0gSUlPX01PRF9YKSAqIDI7DQo+IC0JcmVzdWx0ID0gcmVnbWFwX2J1bGtfcmVhZChz
dC0+bWFwLCByZWcgKyBpbmQsICh1OCAqKSZkLCAyKTsNCj4gKwlyZXN1bHQgPSByZWdtYXBfYnVs
a19yZWFkKHN0LT5tYXAsIHJlZyArIGluZCwgJmQsIHNpemVvZihkKSk7DQo+ICAJaWYgKHJlc3Vs
dCkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAJKnZhbCA9IChzaG9ydCliZTE2X3RvX2NwdXAo
JmQpOw0K
