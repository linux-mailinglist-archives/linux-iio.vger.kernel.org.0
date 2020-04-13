Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE91A6233
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 06:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgDMEd5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 00:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDMEd4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 00:33:56 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67AFC0A3BE0
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2020 21:33:56 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03D4PBcN025293;
        Mon, 13 Apr 2020 00:33:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30b7r5x860-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 00:33:53 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03D4XrO0000837;
        Mon, 13 Apr 2020 00:33:53 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00128a01.pphosted.com with ESMTP id 30b7r5x85v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 00:33:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzYpGCeTC/bsgUNEoQ3sjv3Tm2crHelOUj44I0D5AQ38qCutJc15w0KUx80jeRh76HhFUBf6A6YH/Lu1G47VOGf6Ov1kfdPWO3Hmw7GvTbYTWmDZpguYH2WRR1+OW1kRZL2rkY7rUhvrI/Yj9tShOnkMQ+nki9va1Tx3TpQ0APQDy6bmDzfZsAf+hi95HW8eky4Wj6i3CLJ65GHdtfNaJukz0TGwDcKWL0rOg+Y+MQx73zli2ldDMkRYGCk4MdHCLhywKsXlU9YUxjWqqDCGFlzkvC0aWraqqaNAO7xkuttb7hMu+7ITu+Oi38wNDMSKEsBvXP/a2pZOxSrrvu4kcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MswOodp37Bkvqevoh74z6ZjJIplksGrIss5wvgu6FmU=;
 b=Ms9Ezk/Eh3/dO7Oml9u35SyOdavPuKpCbCht7FItMikv1FlhI2e0ZhifHATP3vKvvkei1ZUmlHwTEwyy2USkGOIOFiiZt4nvLNbTCFkWI3FfEMVU1nyFuP7oZgujUd8aEU3NJX02J1tW6II3ukTW7FsuvYQFsrczkaRKeAaGJEJN+YXPfEh5WAhl00gVNYsWYlNPwtr3md/QRzXoGi39ObB/VHuZ88FGa8Xa+Cpd3Z11imsLzHui5c/ji5JRN8RMsxia0kLTBi2SPw4KzwQcyGW81bz7nk3/Pj3/rbx+AWGJf5eXNWOce/fMQE2URcAjiee0Wwe3q6iD+0pU0TkJUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MswOodp37Bkvqevoh74z6ZjJIplksGrIss5wvgu6FmU=;
 b=G1OmWAGpYXFdh03cJt2y+k7khkjXuvZbsq6wKKzsN8MiwwgHNqlx5eQviD3WjVHkHUbDh7XS1vwIXmMPubwvUSBzXEKMq4Riz0sGLQTFHHTugt2uFTzKdp81fLgZ9wHzif1KEjMIUAGRvZH7K8THD83MM/iBR+OObhtMn/egKtQ=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3787.namprd03.prod.outlook.com (2603:10b6:5:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Mon, 13 Apr
 2020 04:33:52 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 04:33:52 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6/6] iio:light:ltr501: Drop unnecessary cast of parameter
 in regmap_bulk_read
Thread-Topic: [PATCH 6/6] iio:light:ltr501: Drop unnecessary cast of parameter
 in regmap_bulk_read
Thread-Index: AQHWC3TituJ7Pln+PE6oZqTNJf1Njah2g6GA
Date:   Mon, 13 Apr 2020 04:33:51 +0000
Message-ID: <e68e57d2693421c4cb55eb122dca08b9341c6019.camel@analog.com>
References: <20200405180321.1737310-1-jic23@kernel.org>
         <20200405180321.1737310-7-jic23@kernel.org>
In-Reply-To: <20200405180321.1737310-7-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8d88c4a-2f64-487d-072a-08d7df63de53
x-ms-traffictypediagnostic: DM6PR03MB3787:
x-microsoft-antispam-prvs: <DM6PR03MB378724C4F7591BB372DAACD3F9DD0@DM6PR03MB3787.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(136003)(376002)(396003)(346002)(39850400004)(478600001)(110136005)(5660300002)(6512007)(36756003)(54906003)(2906002)(186003)(76116006)(26005)(316002)(91956017)(66946007)(66476007)(64756008)(66556008)(66446008)(4744005)(4326008)(81156014)(2616005)(86362001)(8936002)(6486002)(71200400001)(6506007)(8676002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9bOLZNWXCF2cJXJZvDrQ1bSDpW+ET3S8bLfAvKVzawg19APIy+q+8xUtTsc4Ep9bWFkKbig/fWwAz2wj9atVLJc1o+JfW40JP36ew4a+RqLCedfurJNx/ywSxrx0k2mcwSY0SlkxzGgWxCQ4VkMI+/IZECTFyhe16X8KOoeqLuRYoA3KiXiXbTCsi2GoD31CwDs1GbWq3YXkh7MMJxVUVMPwtyApCnyWKVEvOZaJOLuU3+cf7MwOhw81nbdimgmqINBDtgQwZa3D57nQ03dPefLManeqQ+a+aLC3Wx+kHK/2lRirmQ6g544+QeJovNEjQ/OZbW/z+0Vr9Wh1ng4FduLKeAuRBpaVOcEkKIhs9/luyjykHLfbCR+cuWmVUlfl7Is5uMZhRXf96/096hVzR+kDvSwgQj3ZnLAb67X8aFtnPOMCqL4zfpUMedb0hvfz
x-ms-exchange-antispam-messagedata: CO1z+sMzYrLrlDviXgCI9i6/F0drpXUA9iMfobbyx9la2KWAG8Hwpr1aR8JI3e1lfuY4JHL2pmI+JGZLxRv6/VT9qltyd52S/R2qJn5SOjP3aH+6NAKW17bAo+W2MKlPVJVJ0CBYPQgerp/UxkO7Zw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <709C6BD50A85BA42B33AA597267C75C1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d88c4a-2f64-487d-072a-08d7df63de53
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 04:33:52.0124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFAxDn6QE3yTm0A4KvWf+Iyou6zgEX0JsPX4NKVqglOfvvUxFq/YbDYFr3McAY9wcy041J3+70BU3k2vISTfHlOTBxTy3Wm4kdjdZaGgDy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3787
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_01:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130039
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTA1IGF0IDE5OjAzICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBUaGlzIG9ubHkgb2NjdXJzIG9uY2UgaW4gdGhlIGRyaXZlciBhbmQgaXNuJ3QgbmVl
ZGVkIGluIHRoaXMgY2FzZSBlaXRoZXIsDQo+IHNvIGRyb3AgaXQuDQo+IA0KDQpSZXZpZXdlZC1i
eTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0K
PiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdl
aS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vbGlnaHQvbHRyNTAxLmMgfCAyICstDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lpby9saWdodC9sdHI1MDEuYyBiL2RyaXZlcnMvaWlvL2xpZ2h0L2x0
cjUwMS5jDQo+IGluZGV4IDcxZjk5ZDJhMjJjMS4uMDYyNjkyNzI1MWJiIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2lpby9saWdodC9sdHI1MDEuYw0KPiArKysgYi9kcml2ZXJzL2lpby9saWdodC9s
dHI1MDEuYw0KPiBAQCAtMTI2Myw3ICsxMjYzLDcgQEAgc3RhdGljIGlycXJldHVybl90IGx0cjUw
MV90cmlnZ2VyX2hhbmRsZXIoaW50IGlycSwgdm9pZA0KPiAqcCkNCj4gIA0KPiAgCWlmIChtYXNr
ICYgTFRSNTAxX1NUQVRVU19BTFNfUkRZKSB7DQo+ICAJCXJldCA9IHJlZ21hcF9idWxrX3JlYWQo
ZGF0YS0+cmVnbWFwLCBMVFI1MDFfQUxTX0RBVEExLA0KPiAtCQkJCSAgICAgICAodTggKilhbHNf
YnVmLCBzaXplb2YoYWxzX2J1ZikpOw0KPiArCQkJCSAgICAgICBhbHNfYnVmLCBzaXplb2YoYWxz
X2J1ZikpOw0KPiAgCQlpZiAocmV0IDwgMCkNCj4gIAkJCXJldHVybiByZXQ7DQo+ICAJCWlmICh0
ZXN0X2JpdCgwLCBpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2spKQ0K
