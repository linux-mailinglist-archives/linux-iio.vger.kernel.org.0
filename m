Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740E01B014E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 08:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgDTGFy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 02:05:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47754 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgDTGFy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 02:05:54 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K62U6Q031082;
        Mon, 20 Apr 2020 02:05:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vn6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:05:51 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03K62bfE031141;
        Mon, 20 Apr 2020 02:05:51 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf5vn6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 02:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMZK8w2GaoplI7+CyhRUm4fHdRG0WMuyEZdBdRFFr1gj4hOZKwBvFcKv47q4AibvitpINcDiunYOPSumG9HwnMBk2KVbBBMrawed+aqZCO8NQXmi6OMO/bXh3jcdPVItPRA3TvN+1UW57eBDnvrocr+3J+J0/s4Yu3nCBnPg3iqZXHdtX+N4LfhFLmJdccD3/P4u+RpWmqI5B1RhoPY5blkfDrpB5ONgzktsDtW21m0nrnE0oiRLi4aqTasZIInUuoWmQ/2FrfFFVoCZt/NUgvPKXLuvJpRWrWjDvBV1M6ILbC3b0TdnSkngznoPnkPs+3mw0QzNnsinKTzCogEBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keVUYd8+oWudcxVP79bNyg+zzt9BQEG8iGkCp6lDSk8=;
 b=m/Y3ZRsEk3j1YqZaZDO/nE7Z9oijMGKUzVPlD6P7VSeSemFBO7nPtr/jZPaYkTVtuTyaJ/nXv+DORmAAJLj2BCk5vYEPLKWjIZbF3M5WTQUPNGtRejJsFtG7TRV5KTQx4HknAKJK5yfdSxnNulmBxk25ExuS3qscR7vNih/MlTUmcfl6ETosAST88w16lBKIVj0CwBe8I4++yIfnMyvwsinzubGtttKmnMhJTTjKqcgilI9UinL15cdECzrmKWkrSdLSxVXrH8qQ4CmznFS6zYUyVbNT8UZkvkOXQz8FtdzlWFw1XZluv3bWyBOqpHcmdLCxdhP3+rIvDTb0Dm4MCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keVUYd8+oWudcxVP79bNyg+zzt9BQEG8iGkCp6lDSk8=;
 b=dFY0qcavCNkWzIdUV12qGlClPJlebPYm4f8CIM+oqmnU4m7s1XT6lnbNKCqPlJmgpX+Y90p49NqiWQYbjcKQGPxrk3/rA28mxBy9EuQtB0io2JPRRieIxykBiVTtFOE2tIz2hHjXsYR7wLHzMej7K/xnkbipJiqktFaRSoTWuLc=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4153.namprd03.prod.outlook.com (2603:10b6:5:5c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 06:05:50 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 06:05:50 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/7] iio: light: cm3232: Add mod_devicetable.h include and
 drop of_match_ptr
Thread-Topic: [PATCH 3/7] iio: light: cm3232: Add mod_devicetable.h include
 and drop of_match_ptr
Thread-Index: AQHWFlvTfhf8uQ26JEaLpXS5cEUl3qiBh+EA
Date:   Mon, 20 Apr 2020 06:05:50 +0000
Message-ID: <c3b2f690b6aeafee5e35e4bf2b8c71aa9f1fbc01.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
         <20200419150206.43033-4-jic23@kernel.org>
In-Reply-To: <20200419150206.43033-4-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7822f311-c9b0-4be9-9c3f-08d7e4f0e052
x-ms-traffictypediagnostic: DM6PR03MB4153:
x-microsoft-antispam-prvs: <DM6PR03MB4153CEEB01446F3782F99B5AF9D40@DM6PR03MB4153.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(346002)(396003)(376002)(39850400004)(366004)(4744005)(86362001)(36756003)(6512007)(186003)(26005)(71200400001)(6506007)(478600001)(110136005)(2616005)(4326008)(2906002)(66946007)(76116006)(91956017)(8676002)(5660300002)(8936002)(316002)(66446008)(6486002)(64756008)(66556008)(66476007)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q5IXqeU4iG8yN40WoMoVjqLnL8Ks3PdVQ+YFZCz65ewE2vGL6//9Rih/TowbzOUbHXGPWsWhI2v7gUD+Npcgi5p42QxdgZwz/jfBCRD+sx1LPbjM0wQu4Pg8NwkvmacsDEy1jG1MSYckzBEp/TYPqrt1JEGv7LvKFLW9nWXofB8AV8SppKTjW3wVg/Tdp4J+Sibe8grWYE4RztPy9yJAnFkbConE1w1uRNjeXKjCOBTPoXsiefTJr/KdfiCPTWjKSpS2C7J+1g2eWPY+aNVRtNcqIPzJlw10Hk9ucOFgnywFx3oyqZXpqENQCsFpu7Omwr8DaAV2p4e430WnxbBzE+u9WNUtTbiGPNdjyMZ/E8BUzQecPWZkY+QcrbhIM5GCEr9ETwSFJ5rlEQBUxpdK/+zCjYrpgeQz6omQsQlaKWY8StlKMFwU6qsqyFZ28QEl
x-ms-exchange-antispam-messagedata: tX6wtriDF5rBUHYN3PPzhiRa2FaGCzu60Jr9B5ouLRngIT+qORk5IUKVGzpomYtlKywRwXghAWvEpc1VnwybxEtCEyB/6pNHzGmL9dzoA98bhgN7sTabwLZUWl7UvZtvVVEFzLgJx8AhCm/aej++XQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD0BD2E4C4872F44B1FBFEC9CA2475D8@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7822f311-c9b0-4be9-9c3f-08d7e4f0e052
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 06:05:50.2129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpcXXW3fB58JeCBXYg/RpQv0jDCwxPvdjecSybQPJCod7fbuaKo/lFlxcPmtSi7vetvHZ3d2DgiIfePb/UK5Ca/r0QhzyS9U1xObxqYTHHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4153
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_01:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200053
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTE5IGF0IDE2OjAyICswMTAwLCBqaWMyM0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBFbmFibGVzIEFDUEkgcHJvYmluZyB2aWEgUFJQMDAwMSBhbmQgcmVtb3ZlcyBhbiBl
eGFtcGxlIHRoYXQgbWlnaHQNCj4gYmUgY3V0IGFuZCBwYXN0ZSB0byBhIG5ldyBkcml2ZXIuDQo+
IA0KDQpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5A
YW5hbG9nLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhh
bi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vbGlnaHQvY20zMjMy
LmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2xpZ2h0L2NtMzIzMi5jIGIvZHJp
dmVycy9paW8vbGlnaHQvY20zMjMyLmMNCj4gaW5kZXggY2QzY2ZiN2QwMmJkLi44NjcyMDA4MjU2
ODYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2xpZ2h0L2NtMzIzMi5jDQo+ICsrKyBiL2Ry
aXZlcnMvaWlvL2xpZ2h0L2NtMzIzMi5jDQo+IEBAIC0xMCw2ICsxMCw3IEBADQo+ICANCj4gICNp
bmNsdWRlIDxsaW51eC9pMmMuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gKyNp
bmNsdWRlIDxsaW51eC9tb2RfZGV2aWNldGFibGUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9paW8v
aWlvLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaWlvL3N5c2ZzLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvaW5pdC5oPg0KPiBAQCAtNDE4LDcgKzQxOSw3IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2Ys
IGNtMzIzMl9vZl9tYXRjaCk7DQo+ICBzdGF0aWMgc3RydWN0IGkyY19kcml2ZXIgY20zMjMyX2Ry
aXZlciA9IHsNCj4gIAkuZHJpdmVyID0gew0KPiAgCQkubmFtZQk9ICJjbTMyMzIiLA0KPiAtCQku
b2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIoY20zMjMyX29mX21hdGNoKSwNCj4gKwkJLm9m
X21hdGNoX3RhYmxlID0gY20zMjMyX29mX21hdGNoLA0KPiAgI2lmZGVmIENPTkZJR19QTV9TTEVF
UA0KPiAgCQkucG0JPSAmY20zMjMyX3BtX29wcywNCj4gICNlbmRpZg0K
