Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033961BF3A5
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgD3JBx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 05:01:53 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:26764 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbgD3JBw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 05:01:52 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U90cVk025047;
        Thu, 30 Apr 2020 05:01:49 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-00128a01.pphosted.com with ESMTP id 30qpmkrrt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 05:01:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mITVdOMj8KDJGE7vs4k8mCjPae8JwY453/hX7OV/KBfQZb2i30weGe6U7GZ/sW/w7SxGTH6O7c5wGSwnrO4OWb0M5fujc3Ak3sYZDP7OXzMz4jYUzsIE+Ou9aIqTuQa5f8x+8ufPV1cVJ76y7nqQe5svJAmfV/xEvZolxFg5ynHYCifpXo917ZgPpjWsn9sQEBroLpwJMHGBBkGc5bjHJhMonXu2xtArqZ7YuPaXBeSXnEnP1b6GSK22vlT03uSZ3vvPn3UZIpIBPHsG+pAN9+LA/u7mWWE1sh/x0nU0A1uncWipZc+V/XtTEdgqKkhKJkkvQG1bP/sCR5j1Rc56EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zAXrWHaXbbXzPjCNLLxz8xoCRf/nVxs/0adGGDZxs4=;
 b=aq3/nxGnrx+XCtcT5UhO/Nzc54xTSwIwRWfpNQSbkVbjt52+2gN8IDtnRsPzGXzj+L6vyGH6syao2bW3A7sBJBaPTAc7PbiS/HSW/nyIYQ75pHATZR6BnuIRD6e5N/rFS1KH32M8MkJiei1S1ppBWrYmffVaZq0ecV0aBcuJU+gkKrO2RgEs/X0r1YsgAFCdXRsCuVfn3FI1NMi99+8Ki+bpcT1pegYmFxhN5YIGnwoeYnCzLyzZNegpvlkJ5LDngRTJAxq2IXcQYRHTQ1MRHXQAuahwyO9NI/bD/ojrXNAd18kAtEwW7y/hN8nLfQFWuKGBvGmWsVmSNjb2Z2ghNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zAXrWHaXbbXzPjCNLLxz8xoCRf/nVxs/0adGGDZxs4=;
 b=QoiUY2uJFRgtqT2qj5ydoNCRVDYzeTnS/aU3rmjUgIRpu84PZfr4Nya5+hfIr/vgifyo5D3t/BGX0cOajzm8oBTJhl5w3VtZmmu5YGzO/kulKf+ZD4cj7zppPG123V0huAR6+YHc8uZptyCXcT/BSi7ETn5eeVdwePhjth+s4Yo=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4939.namprd03.prod.outlook.com (2603:10b6:5:1e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 09:01:47 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 09:01:47 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: remove iio_get_debugfs_dentry() helper
Thread-Topic: [PATCH] iio: remove iio_get_debugfs_dentry() helper
Thread-Index: AQHWHsy40MLdMllzmEKvJVaOo73qP6iRXliA
Date:   Thu, 30 Apr 2020 09:01:47 +0000
Message-ID: <b09ec4355ee35b03522afdac552aef38f08819db.camel@analog.com>
References: <20200430085259.2829-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200430085259.2829-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eaf433ba-b2ee-467a-66a4-08d7ece51d04
x-ms-traffictypediagnostic: DM6PR03MB4939:
x-microsoft-antispam-prvs: <DM6PR03MB4939775C9CBE1751A6C3005CF9AA0@DM6PR03MB4939.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OdT3Ho1gDLudxQuoeCIUAXx1DBLPDoTy8wSjFPzEDfAA0agHqv53ToG34gk9gmAixKCC6tjMvXPONTFVCr/TY0V6dhs0cHYtsZ1h0eDF+mh45QF4Zs3PbiNGWnN42G/wYlyXlnczj50d0YN6EAvsXTyVkx7071W5nCPjV7No/ibnHbZvPazkogbfEYKFdN+EwjgEA5vhDDZniEjkCxoX8XHkmFDRY+QUNw3xfPyHrkLfiY6h5SI3vYhaXnSr76aWFkqqMbcZe7XeNd00NVtxa7YCOIcm8+ICHmPtKEnONpIvqkNxcPyMIB5TWolbN7QdP9oGLLzrCXLZ2SO4WOnjUgKFDRkSUtkOnWI//ItZ4R5o6P0AiQ2NlNlNyW0S6spA/AoIOkLGcjtkf5+lsRk6qixsc9G4QL2LWg3rCgUbdv0EnWNASlfwUozMln5mzH8+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(346002)(39860400002)(136003)(6512007)(316002)(110136005)(2616005)(2906002)(478600001)(6486002)(76116006)(4326008)(66476007)(66556008)(64756008)(66446008)(66946007)(86362001)(91956017)(36756003)(6506007)(71200400001)(186003)(26005)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vHMLyzz1vp3mBiDxPCNoAc+XeYa53rlHUYI5zH3VkJxgZJO81xB+BMqt50orpjm1xT9VChUBMPwFupLklqxIo8LXksJrCrxgN78tPpKPisSIBMOhIGpl7Ig0HU+B+eIArTkhgyEuE/LrPdoar0kuxmXP9J2ymbXEAXZGxFglVhEPvPE//e8Ed8/YoJtWEVvELdww6hunA2VMB7xkE8c0M+uxaW1xdrxkRQuYjlDh4y/w8+DbKzG0MjBCUECcIiyE3P5ajwOhpa/YMAetHqrfvQLGBmQaaa5+W5jQVNbhGzdgz4SXDtf6vg0cbp0vTEGv1tg9Mpk5EpyeSNcC2i3/tQnJebrOzVo4klJzChmNhPyC+NzZ1ZDxw/Mig0IEBvojS/FZPvb/1dWGL1SOLzF+bNmvkRR8uDOTri60Iq4JeBiDxDjXAP6IxLMh58yaO1KbYZf/8x+7RjQ2L4+HiIi1F/0Mb16FVRa7tO0YtzgRIUQ2Dy8EK8qT8lvA3SUMqvpG8djSKAGedKY9Y4/d3Uxu+DzKD8HqSOSM56IX/Y1rvPUXujlYAQqmnW9Ls0GlTBc+MGKdvF4vIRJmaE8PB/WBQnGxZIVu00CiYyACeDVsWr5cxuqUOWWpmlqDoT/PBx8ROTd0KBttYeh278x7Xuw5tbYrmKzlb8hJnS7UqTWlXqPVUp7su4Y/zWUhhV0b3Hq9Po5KMqCU5kvGUIq33lSS9OFwDiIYuDYkQW6lQ7EwI3ebyOo8ohZv7bt8Thd9fQAcykcwBIPfpDnAxDMU7qv2e+X6eSTIpgpy6KxrHvEjROc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F026FE8BA3E63B4989C406A56DD0D0E4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf433ba-b2ee-467a-66a4-08d7ece51d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 09:01:47.3019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bE0b+IRQWnYhFNGxoJlEtkHipI2wq0mPie3gTJ2pxg835D+q0/o15wHbw51BLbZj0Ec/z5PXKd6Bf+kV5b1lrlO5Yrh7+8KgXO5TvB2vcJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4939
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_03:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTMwIGF0IDExOjUyICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IE5vdCB1c2VkIGFueXdoZXJlLg0KPiBMb29rcyBsaWtlIGl0IHdhcyBmb3Jnb3R0ZW4g
aW4gaWlvLmgNCj4gDQoNCkFjdHVhbGx5LCBkaXNyZWdhcmQgdGhpcy4NCkkndmUgZm91bmQgcGxh
Y2VzIHdoZXJlICdpbmRpb19kZXYtPmRlYnVnZnNfZGVudHJ5JyBpcyBhY2Nlc3NlZCBkaXJlY3Rs
eSBhbmQNCnRoYXQgc2hvdWxkIGhhdmUgdXNlZCB0aGlzIGluc3RlYWQuDQoNCkFwb2xvZ2llcyBm
b3IgdGhlIHNwYW0uIA0KDQoNCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxh
bGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2lp
by9paW8uaCB8IDE2IC0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lpby9paW8uaCBiL2lu
Y2x1ZGUvbGludXgvaWlvL2lpby5oDQo+IGluZGV4IDM4YzRlYTUwNTM5NC4uMWExZGE1MmM1NWNm
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lpby9paW8uaA0KPiArKysgYi9pbmNsdWRl
L2xpbnV4L2lpby9paW8uaA0KPiBAQCAtNjk2LDIyICs2OTYsNiBAQCBzdGF0aWMgaW5saW5lIGJv
b2wgaWlvX2J1ZmZlcl9lbmFibGVkKHN0cnVjdCBpaW9fZGV2DQo+ICppbmRpb19kZXYpDQo+ICAJ
CSAgIElORElPX0JVRkZFUl9TT0ZUV0FSRSk7DQo+ICB9DQo+ICANCj4gLS8qKg0KPiAtICogaWlv
X2dldF9kZWJ1Z2ZzX2RlbnRyeSgpIC0gaGVscGVyIGZ1bmN0aW9uIHRvIGdldCB0aGUgZGVidWdm
c19kZW50cnkNCj4gLSAqIEBpbmRpb19kZXY6CQlJSU8gZGV2aWNlIHN0cnVjdHVyZSBmb3IgZGV2
aWNlDQo+IC0gKiovDQo+IC0jaWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpDQo+IC1zdGF0aWMg
aW5saW5lIHN0cnVjdCBkZW50cnkgKmlpb19nZXRfZGVidWdmc19kZW50cnkoc3RydWN0IGlpb19k
ZXYNCj4gKmluZGlvX2RldikNCj4gLXsNCj4gLQlyZXR1cm4gaW5kaW9fZGV2LT5kZWJ1Z2ZzX2Rl
bnRyeTsNCj4gLX0NCj4gLSNlbHNlDQo+IC1zdGF0aWMgaW5saW5lIHN0cnVjdCBkZW50cnkgKmlp
b19nZXRfZGVidWdmc19kZW50cnkoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldikNCj4gLXsN
Cj4gLQlyZXR1cm4gTlVMTDsNCj4gLX0NCj4gLSNlbmRpZg0KPiAtDQo+ICBzc2l6ZV90IGlpb19m
b3JtYXRfdmFsdWUoY2hhciAqYnVmLCB1bnNpZ25lZCBpbnQgdHlwZSwgaW50IHNpemUsIGludCAq
dmFscyk7DQo+ICANCj4gIGludCBpaW9fc3RyX3RvX2ZpeHBvaW50KGNvbnN0IGNoYXIgKnN0ciwg
aW50IGZyYWN0X211bHQsIGludCAqaW50ZWdlciwNCg==
