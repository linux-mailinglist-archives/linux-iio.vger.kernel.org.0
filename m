Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB4F1A0C66
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgDGLBa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 07:01:30 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:50874 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728146AbgDGLBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 07:01:30 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 037B1SAb012656;
        Tue, 7 Apr 2020 07:01:28 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00128a01.pphosted.com with ESMTP id 306q55j3b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 07:01:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL8fuJzvfWusUC+r8oI7glsTHOEwszc56GtQEiZZZmyLCzG2vov9s35Z0yjY9OGOVjzBOkPZ0lGAz2MRLUSYFKAP9btiFdbVW3PPkFNIodGBVH56XE8yLWQfaHjMGpF/i8Yi5c597aK9ksEtKtUGTEraeDRAcAhMCK3Z9Pbo42vbrW6+vV7r/19yIpJQ9znqJIT0/BKFTphSQ9Kjy3E1xyUFyZWmikMxPQtAjNK35kXJi26XUZfkVxzH/ZgEoRQJLUwH5Zl+IN6KMmkhIT3LVIknCHYsk4ieRngvcMSgiYWsPt15ciquBQF8kQ0CeMVLLr5kzSG/A7Fk4Vlt/4bJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9MFHYZXF7SdHf5Ltxl2TxrPw+isNcAmZO0cNAPKd8U=;
 b=EhLkG5VgVq2T2OFdgj/KBNJ6rMOTe9dXwQDDXh8OZKsUPKG4fKLsJcMt19ou6G7Q9vu6OeLsE5ZzyUlhMAu/Tv0LiktYYwZEGNLwjykPWVcM9PcNkLtZ55knttFQ8SWNKmqTLW6hI/s9BADWMBUk/VL10TLnbkCBeHKiBOBOMuMI7KgzQ2ayK/yS3XPe8FxfIi+IFZTvDF3ylhIsDswyMaKhNTv0Cr4eaafH/suelclb3MYePT7/bi8msIN5RFhl6W4d8Lu1mplq5YDKFrYFJC+lly+Tnu0Q3QX7F7w+i6j8QOUDP2QExyi/tWzjWMJd0J0vt8sYuIKhz7Hyg1dBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9MFHYZXF7SdHf5Ltxl2TxrPw+isNcAmZO0cNAPKd8U=;
 b=Mz/zvYDgqyXKXqm2LT9ftaqztUopsBJ0sFU6B27Q2BfPidwpbuqFAnpSP3dRc+6D8qgPMC0o0dL8f4o2yrLWe4koxygziq6oseXF4U5qb2eWWAvCn67FWmUCjxyyWgMtJHaC7Qo8z8vqmrgbfL7D6ehuWfEfNVMWW5adhMDx5QI=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5033.namprd03.prod.outlook.com (2603:10b6:5:1e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Tue, 7 Apr
 2020 11:01:23 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 11:01:23 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2] iio: core: move 'indio_dev->info' null check first
Thread-Topic: [v2] iio: core: move 'indio_dev->info' null check first
Thread-Index: AQHWDMlSZrUp5iveZ0qk1mOyXvaT86htfiwA
Date:   Tue, 7 Apr 2020 11:01:23 +0000
Message-ID: <d25190f18a171d82f3300f00b00f50f62f636d28.camel@analog.com>
References: <cb300eeb-6045-bd91-3e0e-902dd3b5d5d8@web.de>
         <3725f882accda683815f04c0eff0bb36c285fe62.camel@analog.com>
         <39d24c67-e83a-e414-e27e-041c7d5cea1a@web.de>
In-Reply-To: <39d24c67-e83a-e414-e27e-041c7d5cea1a@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e8375f6-7029-40a1-b8a1-08d7dae302e8
x-ms-traffictypediagnostic: DM6PR03MB5033:
x-microsoft-antispam-prvs: <DM6PR03MB503375A6B93E8DB92D9E0D7EF9C30@DM6PR03MB5033.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(39860400002)(396003)(376002)(366004)(346002)(71200400001)(8936002)(6512007)(186003)(8676002)(54906003)(86362001)(4744005)(26005)(110136005)(478600001)(2616005)(316002)(6486002)(4326008)(66946007)(66476007)(91956017)(76116006)(6506007)(5660300002)(2906002)(36756003)(81166006)(81156014)(66556008)(64756008)(66446008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 98XM18tH3Tas/HDsjAHuYimKB0jauC24WZTFwWv2FLmLt7nIV8T9Sf6w+W8/Hy47huEbd6/3tMt9IrRfBm+KEGm8+TIiPwI3heGUd/TFQduAFbuoy76RQD5SocK5YSv0cLAboy22b0A4Wn4wF/xZsXzbLC+7JGhbCJ9VUyLmdLdmB9GmYsDyKC+gGiK56xGl++8J1J58Kb6lHmELCTrSzkHEomJ0yIR7tyJ2wsiu+alagqj8eACyAJgsQCYZbrYhHJP5QR2Y2s3yeyXghbNNGxo9TbC3S6gDzEOVpDzsfQEHieGHTPTVae69NHYnapB0g+cz2JYxtibg/lwnk+ANPf0KfLJzpmBEq/zqYFxuAKfETkLBa5JQGsz+DCKJhHyofZuQjWd67by0rQlYb3RpJ2MlFHqQ/4m88Df9MX0PwBSjYHzvqdFaYv1T4WMfLITj
x-ms-exchange-antispam-messagedata: xDCJDP6p3ValM/WBVSTvhKLp+FSz3ztdPEwP4nXGNROxLEx1DLLC9rbW20FvOhwenixepGGuMix24X03VADY0OihsyANtqLREVao4TADRI7POlSWRtUOf72sB2xqNHKIWHzmHqpeGqHIdci+ohrTiQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD47960F5ACF7A4FBF88E432A1741231@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8375f6-7029-40a1-b8a1-08d7dae302e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 11:01:23.6572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6a4BGGnN+mX2WPE6J3sbqf3GMToz5j70fNLuVJddAifgL90R3EjbJ7uMQLcOjmxBVRBgIhGAjkQoFRHOamjN0I9NPX9k5wj7a2ezgr6NQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5033
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_03:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTA3IGF0IDEyOjQyICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gPiBTbywgb3ZlciB0aW1lIEkgZ290IHRoZSBoYWJpdCBvZiBt
ZW50aW9uaW5nICdEb2Vzbid0IGZpeCBhbnl0aGluZy4nDQo+IA0KPiBJIHN1Z2dlc3QgdG8gcmVj
b25zaWRlciBzdWNoIGluZm9ybWF0aW9uIG9uY2UgbW9yZS4NCj4gV2UgY29tZSBhbG9uZyBkaWZm
ZXJlbnQgaW50ZXJwcmV0YXRpb25zIGZvciByZW1hcmthYmxlIHNvZnR3YXJlIGFkanVzdG1lbnRz
Lg0KPiANCj4gDQo+ID4gaWYgdGhlIHBhdGNoIGRvZXNuJ3QgZml4IGFueXRoaW5nLg0KPiANCj4g
RG8geW91IGltcHJvdmUgdGhlIGlucHV0IHBhcmFtZXRlciB2YWxpZGF0aW9uIGEgYml0IGluIHBy
aW5jaXBsZSBoZXJlPw0KDQpJIHRob3VnaHQgdGhhdCB3YXMgb2J2aW91cyBmcm9tIHRoZSByZXN0
IG9mIHRoZSBkZXNjcmlwdGlvbiArIHBhdGNoLg0KSSBndWVzcyBpdCBpc24ndC4NCg0KSSdsbCBz
ZWUuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0K
