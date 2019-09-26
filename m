Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083E3BF0CF
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 13:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfIZLHH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 07:07:07 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58976 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbfIZLHH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 07:07:07 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QB2uEM031383;
        Thu, 26 Sep 2019 07:06:41 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2056.outbound.protection.outlook.com [104.47.32.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hj96sf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 07:06:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW0MFpmPzitxxNO3eeOcmbHo47CE/SyGaC7tJoG1wIstcx+7L395XTXVzHpQk4tcBC2yt9hMhx0DVP4W8nDdLue1GgdXLnKx0OUQT3Fozzudf09Jbx1ut0fSpzc9BcEZSyut6P2cJgdZDv8dugYTo7qKIcB0KWS77dhJZs3VObUoZ/0BgbhK+4IYSVDt8K9ctoCyXaAK5W/yu5qVltF3ZdobSlPVzsVIGHEFs10sQgYkE5ofq7+2FSBROwDsc5BEn8+mXjdT9zMFFttVP9/EBs61c+sKp0Nsr6wtUmehCNV7j3TIjXQlEnhUJARvRLcKc8Orae+ziArb7DOtDnTAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgvt+OiduMGDQr9EgLQ10Zn9ODrDtDyB7iE/Fn7IFY4=;
 b=Hlb+/0AHBeYNr3/FmLeM2LjEZumJqRcwu2eifEpOHowiTA/nk8ZuBZ6yG1GdxJaSvpxiorpja+yD3iT5beEmzkDPTue+tX7CkHZBXAXpauQmwmKYcmmmoIBpmHu6i7dwvn8AOb9AILOKMa5pBgDGCEpO1BdV5H+QhJTOoS9vurNDsDgIz9oA3dHiASv3JGZGXCrt5AgmuHPuabmO/D/chikL0ZAqLU4mJXOwBV/ZqkfLoavn5yGlC9+r7FUxHNe2GHtKkPqyUTqTNBqZGdXqFb0QM0TuKcN5hkP9r78lWVGW2nIOTHj1A6uXacJstE/H5sImPM/8UkPNyTExdOe7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgvt+OiduMGDQr9EgLQ10Zn9ODrDtDyB7iE/Fn7IFY4=;
 b=Cs/A8M/IyeCc1ON2xWXaul44DHjRkKTG276PeaO1E9SeU7dP7iGVRh4CKplMWhs8+fF7zwj9t5foQx2VSkR3OvWZ8ulf9of2dhYYmiEurg98vtjoKVYLITQX99BcFIsq9bsYUjSFejT7qjcJuT4Z+Wy6UUkVtVGNAW52xuWhXA4=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5207.namprd03.prod.outlook.com (20.180.15.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 11:06:39 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2305.017; Thu, 26 Sep 2019
 11:06:39 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: imu: adis16480: clean up a condition
Thread-Topic: [PATCH] iio: imu: adis16480: clean up a condition
Thread-Index: AQHVdEI+uKReFAaziESjQBeEHo58sqc9zGoA
Date:   Thu, 26 Sep 2019 11:06:39 +0000
Message-ID: <9e40c550310d6f30e6481329e01061beb474bc33.camel@analog.com>
References: <20190926081016.GA2332@mwanda>
In-Reply-To: <20190926081016.GA2332@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53e38fd1-049c-4870-91d2-08d742719b36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5207;
x-ms-traffictypediagnostic: CH2PR03MB5207:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB520770776D5307E6FB36AFD9F9860@CH2PR03MB5207.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39860400002)(189003)(199004)(51914003)(6506007)(25786009)(102836004)(4744005)(26005)(2906002)(66066001)(5660300002)(2501003)(76176011)(6116002)(3846002)(99286004)(6436002)(316002)(54906003)(6486002)(4326008)(110136005)(6246003)(71200400001)(71190400001)(6512007)(14444005)(118296001)(305945005)(7736002)(229853002)(66446008)(64756008)(66556008)(66476007)(256004)(66946007)(2616005)(76116006)(81156014)(446003)(81166006)(8936002)(11346002)(8676002)(14454004)(186003)(486006)(86362001)(476003)(478600001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5207;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PWNY5UQvONMk8rlE7Hahwh8wxUjOfbOJQEBXJXrmRyvUm8U//3vsH3xEwoiSgndZDtGQYX7ubjAWkjHpEkVZ3CoFILhuXlUWWce/P5hMq1tMiwtOTz3WThamSzyLkAz9PmmJDXXMeuKpvm7t2Yc3kn6am+8wVaktGgsQruuROggedYtHgIYfvmZji7vI0vtkR+JBMd6t3AWulWzQB0W86gvBMZh2l1YvNfDH5MZdPKPUpgi35bqWnylyM1skDyjD0c9QWIF9+HXwzpsDvEKlNCLcEvANkki8uXImO++JtQOSrI1LaX61ljWPmvSCPl+5aveEsIQWhknbYRhDY0NqF9UBSHCid/l3nTMqF+3hmo6NmsaI+tlERHB/dNe09RewoNxDGjk2Rk5/ydVcQb9qtzdOjWquiA6fCMq0XGSYGY4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B89F48AD3F5F0409C89AA520500715D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e38fd1-049c-4870-91d2-08d742719b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 11:06:39.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5gWr8vtatepAzJRfFOvnpSxirqGCJ6Tr+KsOamRzi9TKpQHk8sixtolwCY7N+MBF2t1RDuVqK004m8KIT0MzR2I+EpIsZCauufjp7U4O8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909260105
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTI2IGF0IDExOjEwICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBbRXh0ZXJuYWxdDQo+IA0KPiBUaGUgInQiIHZhcmlhYmxlIGlzIHVuc2lnbmVkIHNvIGl0IGNh
bid0IGJlIGxlc3MgdGhhbiB6ZXJvLiAgV2UgcmVhbGx5DQo+IGFyZSBqdXN0IHRyeWluZyB0byBw
cmV2ZW50IGRpdmlkZSBieSB6ZXJvIGJ1Z3Mgc28ganVzdCBjaGVja2luZyBhZ2FpbnN0DQo+IHpl
cm8gaXMgc3VmZmljaWVudC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRh
bi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9pbXUvYWRpczE2
NDgwLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDgwLmMgYi9k
cml2ZXJzL2lpby9pbXUvYWRpczE2NDgwLmMNCj4gaW5kZXggYjk5ZDczODg3YzlmLi5lMTQ0ZTU2
NzY3NWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0ODAuYw0KPiArKysg
Yi9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDgwLmMNCj4gQEAgLTMxOCw3ICszMTgsNyBAQCBzdGF0
aWMgaW50IGFkaXMxNjQ4MF9zZXRfZnJlcShzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LCBp
bnQgdmFsLCBpbnQgdmFsMikNCj4gIAl1bnNpZ25lZCBpbnQgdCwgcmVnOw0KDQpJIHdvdWxkIGp1
c3QgY2hhbmdlIHRoZSB0eXBlIG9mICJ0IiB0byAiaW50Ii4NCkVzcGVjaWFsbHksIHNpbmNlICJ2
YWwiICYgInZhbDIiIGFyZSAiaW50Ii4NCg0KVGhhbmtzIGZvciB0aGUgY2F0Y2ggOikNCkFsZXgN
Cg0KPiAgDQo+ICAJdCA9ICB2YWwgKiAxMDAwICsgdmFsMiAvIDEwMDA7DQo+IC0JaWYgKHQgPD0g
MCkNCj4gKwlpZiAodCA9PSAwKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIA0KPiAgCS8qDQo=
