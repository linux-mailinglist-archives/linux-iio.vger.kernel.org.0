Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB4C1ABA46
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 09:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439687AbgDPHts (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 03:49:48 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35258 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439430AbgDPHtp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 03:49:45 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03G7k5HT013814;
        Thu, 16 Apr 2020 03:49:42 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00128a01.pphosted.com with ESMTP id 30dn7umwkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 03:49:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxXyQP7v/DlEhtydwj7DqqUjjS/QgxUam1b5pTnzf7IHLsUq1eANQSjfTu3d5fgmRWVH1oqGRTI3/C1iJ8LRXIESeYqJ+gLh6OKhgmiT7ytvZ6+EK3EkpLxXiTguPU7H9zYrry3qL3cVh9vPbHQLrDECCvC9GAGWN7GpUG3ZiZ9rHPBtk0PFSJb9FPmWPrLrs3wBO9Fqzj3EV+vhI0xqqTJwYzszupmUtRh9AyZXY2NklCcgi8Jhk1osWtqGxFP/hXW+f8UUeEae+EuiNYPEvchkPB0G6w755/f6CWHmgsIVhinJsPPAH2rVqMy+N0BnzjntkKNbr8UyWoSZTJ1mfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cULanI94ntbr6XwFgmpZMxdaO/gZ2Aq2EMsoukgbQjM=;
 b=JXk/soT0B909K1Jjd+oeSZzR/V7rJMMFgZbSCvAu9T/8UG9Y59wMsa9pDAYjncfrEVC1nm9eSFTXCksgxVUJoI8/0Phpncz2GDjq444BpNGK0AznF9Mhi+C+7XHtDiN2VtdeZwmQEc3f7kXBw2X3gv/NuZ1BCnbmaSafP5a/t5t49/UZz68th0YkQkB2I0IT9a6IbRddfoAqYODluo1Oy26ggtZHmXOAu5JPF3f2R7MUlPkoo5sx1V6SShrMY2YBW2dEsqedlWM1p/Gn8e1bMvh3qvOWjGs/AyhAvqur0MbDKLzt2JZQa/PC35VML3HiWeus453XgHoFK7aY6tIGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cULanI94ntbr6XwFgmpZMxdaO/gZ2Aq2EMsoukgbQjM=;
 b=b+6De6QjbXLOUgsHtbfny4k92MRHrUoQ44rcZOHUIH1x3AZQg73XnJ9XnudQUjctNUzPmq1xGZnIzQXT+J1Ll9phDudTD+F55ch0ssssuOO8LpiZ3KKi7va7yFiUqceutcETcY/sc4A8xBIhjLVJwhp1O1EBCWBNFFOnboU/R1I=
Received: from MWHPR03MB3199.namprd03.prod.outlook.com (2603:10b6:301:3f::29)
 by MWHPR03MB2655.namprd03.prod.outlook.com (2603:10b6:300:46::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Thu, 16 Apr
 2020 07:49:38 +0000
Received: from MWHPR03MB3199.namprd03.prod.outlook.com
 ([fe80::e9db:3ec6:ac32:677e]) by MWHPR03MB3199.namprd03.prod.outlook.com
 ([fe80::e9db:3ec6:ac32:677e%7]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 07:49:38 +0000
From:   "Berghe, Darius" <Darius.Berghe@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "Pop, Cristian" <Cristian.Pop@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: [RFC] IIO way of representing device operation range ?
Thread-Topic: [RFC] IIO way of representing device operation range ?
Thread-Index: AQHWE8OUKu+vWQH2D0Wzqo5csS5WeQ==
Date:   Thu, 16 Apr 2020 07:49:38 +0000
Message-ID: <9d9fd2c70f793a9637f581e7ed0574012a3006f9.camel@analog.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.119.21.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f93ab28-ab66-4cc9-2c3f-08d7e1dab6f9
x-ms-traffictypediagnostic: MWHPR03MB2655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR03MB265548B04C8EF54E3614F1F596D80@MWHPR03MB2655.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR03MB3199.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(366004)(6512007)(2906002)(26005)(8676002)(8936002)(107886003)(6486002)(4326008)(81156014)(91956017)(2616005)(5660300002)(316002)(186003)(478600001)(54906003)(6506007)(66946007)(64756008)(71200400001)(66446008)(66556008)(36756003)(6916009)(76116006)(86362001)(66476007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S0jjadXRB8d5ntYqaphl21wnKcWGoLcW553H5Aq4b8o+XNBPeTu7YLtxGBnmZxa7u6PVTvz10HcphKX0RbIpZckdSQyhgfwJtXOQTS9UhlfcBwS5Wrpgo9tcqr+ETVFpIPYpJVKlueZVAAbnqYQIUAti+OvlJcxnGstQHfKw0WTHqTdWIo74Ue2587lWiKnX+/04m8f9LGhcBOAsCgkcNOhbBPAvgy5IF/D6K9Kk6j0VNW2uhf/SZnviX9z13bpUfaMH926KzVUPfw0T+8jfqR9g4UaVk6t5bOhSu3KM4GvjPr/70aKKWsR89x3Yffq93bODNuWQC3/6DvK5yNsqg1Tq5Y14EbhCInFqX8a4RrxYqD5AcOvUZQ/lo62M0L2e+hTormFjCtgyL5PXF5TCSx87omuifYiPY439g0pUfrtxi7TkxYgoRuNGP/pvrDRV
x-ms-exchange-antispam-messagedata: QgMmtsImGXrjFsALNjbKGTK4qDIC50k3syKUsdK8/ZxkNgZ9wwDdEwXWAXf45OkpoHIkNdCVG05flr5o/VlscuFN7wE91qJDj5mbCgrqVN4+ds2+aruQNP7Prmc+lsWfyvrgdMdBiyOAefnHsevYxg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E11304C48EC0848BB64D840DB79A882@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f93ab28-ab66-4cc9-2c3f-08d7e1dab6f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 07:49:38.2869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjA30KSGRvMLO2Sh4CKtR1i91NGPFaL8K2kLbZsaoL5C2Xu2lnfPvbEvWf2N1WYdwtuVv1T775yqRu+X6eqhA7p5il7sYU51SJNHT+fff6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2655
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_02:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160051
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNClNvbWUgZGV2aWNlcyAodGhpbmsgREFDIG9yIEFEQykgaGF2ZSBzZWxl
Y3RhYmxlIGNvbnRpZ3VvdXMgb3BlcmF0aW9uDQpyYW5nZXMgcGVyIGNoYW5uZWwsIFJtaW4uLi5S
bWF4LCB3aGVyZSBSbWluIGFuZCBSbWF4IGFyZSB0aGUgcmFuZ2UNCm1pbmltdW0gYW5kIG1heGlt
dW0gdmFsdWVzIGV4cHJlc3NlZCBpbiBwaHlzaWNhbCB1bml0cyBhcyBpbiBkYXRhc2hlZXQNCiht
QSwgbVYsIGV0YykuDQoNCkV4YW1wbGUgREFDOg0KICAgICAgICBjdXJyZW50MCAwLi4uNTBtQSAw
Li4uMTAwbUEgDQogICAgICAgIGN1cnJlbnQxIDAuLi4yMDBtQSAtNjAuLi4yMDBtQSAwLi4uMTAw
bUEgLTYwLi4uMTAwbUENCg0KcGh5c2ljYWwgW21WLCBtQSwgZXRjXSA9IChyYXcgKyBvZmZzZXQp
ICogc2NhbGUNCg0KT25lIHdheSBvZiBhcHByb2FjaGluZyB0aGlzIHRoYXQgSSBjb3VsZCBmaW5k
IGlzIGxldCB0aGUgdXNlciBzZWxlY3QNCm9mZnNldCBhbmQgc2NhbGUgZnJvbSBhIGxpc3Qgb2Yg
YXZhaWxhYmxlIG9mZnNldHMgYW5kIHNjYWxlcy4gQnV0IGR1ZQ0KdG8gdGhlIGZvcm11bGEgYWJv
dmUsIG9mZnNldCBoYXMgaGlnaGVyIHByaW9yaXR5IGluIHRoZSBjb21wdXRhdGlvbiBhbmQNCm5l
ZWRzIHRvIGJlIHNlbGVjdGVkIGZpcnN0LiBPbmNlIHRoZSB1c2VyIHNlbGVjdHMgdGhlIG9mZnNl
dCwgdGhlIGxpc3QNCm9mIHNjYWxlcyBtYXkgYmUgcmVjb21wdXRlZCBieSB0aGUgZHJpdmVyLiBB
dCB0aGlzIHBvaW50IHRoZSB1c2VyIG1heQ0KcXVlcnkgYXZhaWxhYmxlIHNjYWxlcyBhbmQgc2Vs
ZWN0IG9uZS4NCg0KVXNhZ2UgZXhhbXBsZSwgdXNlciB3YW50cyB0byBzZWxlY3QgLTYwLi4uMjAw
bUE6DQojIGNkIC9zeXMvYnVzL2lpby9kZXZpY2VzL2lpbzpkZXZpY2UwIA0KIyBjYXQgb3V0X2N1
cnJlbnQxX29mZnNldA0KMC4wDQojIGNhdCBvdXRfY3VycmVudDFfc2NhbGVfYXZhaWxhYmxlDQow
LjAwMzA1MTc1NyAwLjAwMTUyNTg3OCMgY2F0IG91dF9jdXJyZW50MV9vZmZzZXRfYXZhaWxhYmxl
DQowLjAgLTE1MTIzLjAgLTI0NTc2LjANCiMgZWNobyAtMTIzNDU2LjAgPiBvdXRfY3VycmVudDFf
b2Zmc2V0DQojIGNhdCBvdXRfY3VycmVudDFfc2NhbGVfYXZhaWxhYmxlDQowLDAwMzk2NzM2NA0K
IyBlY2hvIDAsMDAzOTY3MzY0ID4gb3V0X2N1cnJlbnQxX3NjYWxlDQoNCg0KQWxsIHRoaXMgaXMg
cmF0aGVyIGNvbXBsaWNhdGVkIGZvciB0aGUgdXNlciwgYmVpbmcgYSB0d28gc3RlcA0KcHJvY2Vk
dXJlLiBBbHNvLCB0aGUgdXNlciBjYW5ub3QgcGljayBhIHJhbmdlIGluIHBoeXNpY2FsIHVuaXRz
IGFzDQpzcGVjaWZpZWQgaW4gdGhlIGRhdGFzaGVldCwgYnV0IGluIGEgZnJhY3Rpb25hbCAoZGlt
ZW5zaW9ubGVzcykgc2NhbGUNCm9yIGEgcmF3IEFEQy9EQUMgcmVnaXN0ZXIgKGRpbWVuc2lvbmxl
c3MpIG9mZnNldC4NCg0KSXMgdGhlcmUgYSBkaXJlY3Qgd2F5IHRvIHNlbGVjdCBhIGNvbnRpZ3Vv
dXMgb3BlcmF0aW9uIHJhbmdlIGluDQpwaHlzaWNhbCB1bml0cyAoYXMgaW4gZGF0YXNoZWV0KSB3
aXRoIHRoZSBjdXJyZW50IHN0YXRlIG9mIHRoZSBJSU8gPyBJDQp3b3VsZCBsaWtlIHRoZSB1c2Vy
IHRvIG9ubHkgY2FyZSBhYm91dCBzcGVjaWZ5aW5nIFJtaW4gYW5kIFJtYXguDQoNClRoYW5rcywN
CkRhcml1cyBCZXJnaGUNCg==
