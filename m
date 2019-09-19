Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC519B7375
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbfISGxJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 02:53:09 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32908 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbfISGxJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 02:53:09 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8J6mJUN026345;
        Thu, 19 Sep 2019 02:52:38 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v3vbdhc96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 19 Sep 2019 02:52:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcxSE8ChiFw0qZwPqhi4cLWndmYNS1RorrYVr/c7IoY8U4HyW7AnDKtLsilqlmEVpW0TMC63yndRGhMLcs2Wbvmdw1CqvqIml9qS/jnmLf8fRcYAZA4gXoEG+isbR4SucOGxJu2HhEZTHCB/uArXlt6UOoXzJ6ym6bomnI5Yimkohos2J8VjjYkkp4PrHD2lJK63DJFM28awm0TKNfqSQsy+hw1Okx3vE1MBmYVOjxtPRGEmowMMg/UWkhK9Buf0S+pVle2AQeAqbZQTrcgOVwWDvBaZ8N92832CvifAit8JJLDwYiS+h05DgvyNMLDJCSt17+hBQnUtH3Xeumcn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjcTaZqWSphY2UyF1zfNVACp3lpptr5f8jhk5WDX1S4=;
 b=Hz2fL/Y0uR3Sbus7iv4NYlOXJ83xLLMGQvJRVqG/53xbhO+/2fIjaa6/SIDl/mZNL8+ip53vAgX0WgVPBo3Y7P3UkupGXn/sXoy2BO89R5fkPP+ZKmpZZcHZ3uLdLWSQxQmKkCXP7Avpm4RaKjM9Hn2p2Ewz+qT/KFTYtyYoeAxrFag6EHTR2GpKW/IpTPdrGvkhmAy3tvOYg+1jDoSlKDMJI6Zq7J70bb+S2CkDgTiTxhzOtcA116Oar9r0RPUHK+OoxxIKkwN231JxWcKH7ceXedRzp5m7oBGbm4cJh1mh1mf+lFz8zzGmR8rrvjqdf0Scv0uh7F4W0q+w0x/69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjcTaZqWSphY2UyF1zfNVACp3lpptr5f8jhk5WDX1S4=;
 b=NkuDuICewadg4KGlQW4+Ks1cw4zGtz/bkDrl3HCGEpTO/CHQBDURlAw/q2Z7UsJpm5WV26175n+Io90rc/4/a7+IIImem9EqFzcYcfTQWB7IlsKzo9egnylMaIs9jye9WZyq9uz/AvUMVybn7zvb9bnbOIMHU68nN9b9k5pFcuw=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5349.namprd03.prod.outlook.com (20.180.14.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 06:52:36 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 06:52:36 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "navid.emamdoost@gmail.com" <navid.emamdoost@gmail.com>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: imu: adis16400: fix memory leak
Thread-Topic: [PATCH] iio: imu: adis16400: fix memory leak
Thread-Index: AQHVbkMAbT5q7RcMUEenCtthND7agKcyw2SA
Date:   Thu, 19 Sep 2019 06:52:36 +0000
Message-ID: <76a7c8d43f8c03a0549d157bbf278b515cfbc047.camel@analog.com>
References: <20190918170306.4779-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190918170306.4779-1-navid.emamdoost@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65e5f6d6-3b46-4720-5ead-08d73ccdf4c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5349;
x-ms-traffictypediagnostic: CH2PR03MB5349:
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5349133072B2AA9366F4EB31F9890@CH2PR03MB5349.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(54906003)(66066001)(86362001)(6246003)(478600001)(7736002)(2616005)(71190400001)(8676002)(36756003)(71200400001)(14454004)(305945005)(7416002)(118296001)(316002)(1361003)(229853002)(6486002)(14444005)(81156014)(256004)(6916009)(6436002)(5640700003)(6512007)(486006)(26005)(186003)(11346002)(99286004)(76176011)(102836004)(446003)(66476007)(66946007)(476003)(66556008)(64756008)(6506007)(5660300002)(66446008)(4326008)(6116002)(2351001)(76116006)(2501003)(3846002)(25786009)(2906002)(4744005)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5349;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7ldS5Q169LSI8wnCjhEENOW3eWKSgRoXGzb49FVpRIyiThJ/mWjGZcpgr1K/l//CgrlWjadMX9BJK2oJgKaPvb0Fe+eVdcq+ZDwKSrTRjBP5DXHXqaHL5+pD1u43Lm4alcbwIm3tIN6m6kpnsJ0hVI68cHWbywY94ZQFjpXyJyo0lkzXvZEpVF4RZjCAc+A880NLiEbDbnVkzJw0B4SXYd68vwwE96Krs3Rn4bpN3DOklLMaYb2ey9Y6P5NIOs9Qc2zdALOrIjzlio3aYXv7LuXknOtVXawQkT+vVyhtDnCKmvr0cx4XAXj0bPobpDh3+9y1AgN5b9lfLfOH7X0UPR04i2ujXA1kIC/CT26OuWYYOpwKNrTiibDTDV2yYbpQtDeojZ26c2Z4fuG3T1V6iJYViDzycd4KyBYqW/WCiYU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38128D78B20F614385FF0F2BB212B26F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e5f6d6-3b46-4720-5ead-08d73ccdf4c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 06:52:36.7447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+Lor/ZuHRqVD7UocPxTwRqlCL4PafM4R8RdHR6RaJlkZiSmbIxcgy8Sx3G7h9sTgR6hGxE0KWdr6FLQ7zrxpja782/8kpWS4LgX0LyK/TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_02:2019-09-18,2019-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=970 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909190063
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA5LTE4IGF0IDEyOjAzIC0wNTAwLCBOYXZpZCBFbWFtZG9vc3Qgd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQoNCkhleSwNCg0KVGhhbmtzIGZvciB0aGlzIHBhdGNoIGFzIHdl
bGwuDQpDb21tZW50cyBpbmxpbmUgaGVyZSBhcyB3ZWxsLg0KDQo+IEluIGFkaXNfdXBkYXRlX3Nj
YW5fbW9kZV9idXJzdCwgaWYgYWRpcy0+YnVmZmVyIGFsbG9jYXRpb24gZmFpbHMgcmVsZWFzZQ0K
PiB0aGUgYWRpcy0+eGZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5hdmlkIEVtYW1kb29zdCA8
bmF2aWQuZW1hbWRvb3N0QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lpby9pbXUvYWRp
c19idWZmZXIuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1
ZmZlci5jDQo+IGIvZHJpdmVycy9paW8vaW11L2FkaXNfYnVmZmVyLmMNCj4gaW5kZXggOWFjODM1
NmQ5YTk1Li4xZGJlMjU1NzJhMzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9hZGlz
X2J1ZmZlci5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzX2J1ZmZlci5jDQo+IEBAIC0z
NSw4ICszNSwxMCBAQCBzdGF0aWMgaW50IGFkaXNfdXBkYXRlX3NjYW5fbW9kZV9idXJzdChzdHJ1
Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gIA0KPiAg
CWFkaXMtPmJ1ZmZlciA9IGt6YWxsb2MoYnVyc3RfbGVuZ3RoICsgc2l6ZW9mKHUxNiksIEdGUF9L
RVJORUwpOw0KPiAtCWlmICghYWRpcy0+YnVmZmVyKQ0KPiArCWlmICghYWRpcy0+YnVmZmVyKSB7
DQo+ICsJCWtmcmVlKGFkaXMtPnhmZXIpOw0KDQpTYW1lIGFzIHRoZSBvdGhlciBwYXRjaDogaXQg
d291bGQgYmUgYSBnb29kIGlkZWEgdG8gZG8gImFkaXMtPnhmZXIgPSBOVUxMIg0KaGVyZS4NCg0K
PiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gKwl9DQo+ICANCj4gIAl0eCA9IGFkaXMtPmJ1ZmZlciAr
IGJ1cnN0X2xlbmd0aDsNCj4gIAl0eFswXSA9IEFESVNfUkVBRF9SRUcoYWRpcy0+YnVyc3QtPnJl
Z19jbWQpOw0K
