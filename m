Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CF9E98F0
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2019 10:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfJ3JMR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Oct 2019 05:12:17 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63224 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfJ3JMQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Oct 2019 05:12:16 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9U97lWe031093;
        Wed, 30 Oct 2019 05:12:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhjh5qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 05:12:14 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id x9U97gax031076;
        Wed, 30 Oct 2019 05:12:14 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhjh5q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 05:12:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPcrhi2Wf0dK2NuyY+bOKBEuW3bUL1oeezG/QuPsLLTrtzjHlEaOwKSGUGD0k46FTJEbL/SEldT5n1bB8KPAu+1GapgZqRKV32ZVKRRRR8464vWVJmDNGdRI7OiebnNYliWvZZu+zsEan+G5IPRTNWNWM+OvNrx0rtgHa0bX0cyZtetksBUxeEje5NhhSX6GYQhx3nzTM57FD1fNNdce7p5Pr7ZzFu/Ee+x49ge86SziQ2cB3IdRTiJna45Z4K4LMYlp094PAvD4gRC/MfRy98c0dbOPE92648lel0wfpftGAbn8Moktr04GhTDoe5q9HdH1X9q6WZ2mafDXloimcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nub0k3/qnKxfkr7s9+E/YMSZIW6FwmOJB70S5nC7LOA=;
 b=gEjY9cfJrQo7GJgdhjnpC3KntPdxv/KrEwfQ+d1Uv2cu5OF2spShbs2J8H/Zl5GryTIZTqJu5VOgbWmnLQZpGJ31JDcETDhWdZYrLiPObFvO7VvbLeoX2HNy8pyRfr7qVSTxn3DzcAn3K2wpw0vGRBLBt4BQWhT1Vg3g+b9eMOu0UjWwCG/yZ5E0BB6IWjCdsRn1X8p0zOjQvbzAXPJufddpPDEqRU/271fkLyZptiu5nmsu1SxGKWNlG1+yGfoqwge8QeU1Oh4kuTR9/anRcTzuuv49qwYjj1ui9bk7M637w/NGnmHIK1gtOYVmmyNVZbHrMx3FyXlTpa9ZAQ/wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nub0k3/qnKxfkr7s9+E/YMSZIW6FwmOJB70S5nC7LOA=;
 b=LpJgEYtqtlSLFx6vsmY4NMIzwpIkAHFwVdK4oYvOv6BjsPpr7WHlEFT0I92B6RyWyNL+EcTno0j+T0gp2MEvYmDCaLEgOdQt/pozGHGnYBQSrrxG/e5d+9IAB/MTy0RTI8EiY2Y6xDvOItffsnj1hmyzQzq9M7Ex+Vf0ZZ1iheU=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5288.namprd03.prod.outlook.com (20.180.15.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 09:12:10 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 09:12:10 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs
 fops
Thread-Topic: [PATCH 0/2] iio: use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs
 fops
Thread-Index: AQHVjvtwgzUOGNv/IEWoF+OkPK8cUqdy5j+A
Date:   Wed, 30 Oct 2019 09:12:10 +0000
Message-ID: <e32709c02e455b6a97b18f16c19e17d9658fe8f1.camel@analog.com>
References: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91f8d1b9-33ed-4127-1e9e-08d75d193f07
x-ms-traffictypediagnostic: CH2PR03MB5288:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5288D620B4B5BA24B4F6B24CF9600@CH2PR03MB5288.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(51914003)(476003)(110136005)(6246003)(36756003)(118296001)(6506007)(229853002)(316002)(256004)(86362001)(99286004)(2906002)(486006)(11346002)(2501003)(76116006)(6512007)(6116002)(186003)(54906003)(4326008)(66946007)(26005)(14454004)(2616005)(446003)(478600001)(66476007)(66556008)(81166006)(6436002)(8676002)(81156014)(66446008)(64756008)(4001150100001)(102836004)(305945005)(71200400001)(71190400001)(25786009)(5660300002)(76176011)(4744005)(8936002)(6486002)(3846002)(7736002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5288;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBs3dYUmleKZUqClqfZMs1TB99U9KfpSm1KrsDSsfzdX3oyeSaeLmJKwd5tavoUolcbg1P4FH4VTEWmrIC/yhU57wzOazNxZl77MOU+Lw936ApRrz0QQLe0NBI/sw6dW+daheRDICzeVmn38s+EwV/Ant1AN+7i8mZuK0lXzRfnSFHXaTjd9JxtCqTmkevYYa1NT2/6cGN6URG98tEC+ujkZqmMt2Apo9EtmGDBaYs4ezckDv+VgDRKqzBorzqHhoVyrKrRKIPUlz/CqztgZAkczFMVCRzrYAQMdbvfLpA0I5htLbRxYtEYp92mLFudFXABJVBuvGCS2SijoyE0kBAgSAB8SHGZy6Q6FaIg9v6x1Sm2CeS26DRwUrDeyTsBO055ocCqBbb+QuxAbJ7eaHggCacfL1votR9lK68WJ/E0puwVGjTNnhps3neE6PT+R
Content-Type: text/plain; charset="utf-8"
Content-ID: <479D86EA034A644091F18F66869CBABA@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f8d1b9-33ed-4127-1e9e-08d75d193f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 09:12:10.7299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2CuKy3icadHqzzmZfYpTA6YjEZFoELBn7+bIWCTmMRZatO9iuwHpxIJJCWUCPud0aoOlpcmuopFpmvHsgiKsLpn6Ajl7iZmKVNaG5q6uhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5288
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_04:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910300092
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTMwIGF0IDE2OjE5ICswODAwLCB6aG9uZyBqaWFuZyB3cm90ZToNCj4g
W0V4dGVybmFsXQ0KPiANCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2hlcy4NClRoZXkgbG9vayBnb29k
Lg0KDQo+IFRoZSBpc3N1ZSBpcyBkZXRlY3RlZCB3aXRoIHRoZSBoZWxwIG9mIGNvY2NpbmVsbGUu
DQo+IA0KPiB6aG9uZyBqaWFuZyAoMik6DQo+ICAgaWlvOiBpbXU6IGFkaXMxNjQ2MDogdXNlIERF
RklORV9ERUJVR0ZTX0FUVFJJQlVURSB0byBkZWZpbmUgZGVidWdmcw0KPiAgICAgZm9wcw0KPiAg
IGlpbzogaW11OiBhZGlzMTY0MDA6IHVzZSBERUZJTkVfREVCVUdGU19BVFRSSUJVVEUgdG8gZGVm
aW5lIGRlYnVnZnMNCj4gICAgIGZvcHMNCj4gDQo+ICBkcml2ZXJzL2lpby9pbXUvYWRpczE2NDAw
LmMgfCA0ICsrLS0NCj4gIGRyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NjAuYyB8IDYgKysrLS0tDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo=
