Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C2E24A5D7
	for <lists+linux-iio@lfdr.de>; Wed, 19 Aug 2020 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHSSTe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 14:19:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39610 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725997AbgHSSTb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2020 14:19:31 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JIDZfF032661;
        Wed, 19 Aug 2020 20:19:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=1dZ5JwiICEQR5poBR3TPamxp3f7fQYhvKi3VmA5K6wY=;
 b=wtmr15UPn81inTaWWnztqX7dPHMn8XOzTrSNbL8K3PU9gB5SwC6Jqn49/SxutE8cPzuU
 0WVdr0WmO2Jf4+mzp2Wlhdd/Q1Aj1SjFFajLZZ69Rky0j9W+14Voe9VqpEo/LNKa/yGp
 8wuFQ6znbZI7Y+3AMlNSrxorFAFhVNTzbBXLcA+OmufE44vDAyy7x81Dt43iEP6X4gJ/
 3PwbFa+YnKBw1tIO3N9A+Gkr8uOullz9sWWPQxSJBPpU4Go4oNOjyxqI/Wz2HyNXvLnP
 AOcmS1+X63nG2T1SsTgm3orXTJELAEkftff2aexqWyFDL6XtjOeuX17psjjKZpBM8eRM 7w== 
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
        by mx07-00178001.pphosted.com with ESMTP id 330jg7e452-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 20:19:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROSGPfyZgefeKi/5M9m/pPnE4yY2DfRqWUzbLitxp2T5RN84yBh+gPNemKloA8f2kvXwEaxG0YH6z+4gSUDQckeMW6BOiwSxmjHZjdUCfLnBPAGF9UshxVsS2tM75aiId9i4ClATkmzkmY9xzJ9EkZyVJHedd1gMKM6nQIfgFec0PFgjZZGN6cRcfZE77chRXEfI5TperzRDQG2XSpUQjWhnXHflDFP013oUobIrsE0XpDpFu3rNk1xcmdABtm8IWPFTRgt7BySqHZ/DyEKn9i6LdNzLywzf2m+paMsxMF9cAqPHj3347618j6rGa1ZJSwlV8wSMuxHsPMD2s97vHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dZ5JwiICEQR5poBR3TPamxp3f7fQYhvKi3VmA5K6wY=;
 b=Jk7fx56IcbGCOLjKJGv0OvYNbm6LKz6zCT8EwEifnhyaG5gEkAoQK9er0keqD67qbcDitvNqXA1h0n0zqSoibuiQC+cYunKuWp1MuluBpmcR9gpx35o6dFt/6D49k+oJrb5N96nExvhSjzhS8JkXfS5K0wgmSW6D5Y2IGG/MdG5ZpfC3KWfEANHj3ykrolPYrJyd/VNxkZQPhX2kCDz7oSX/9xqaIjcGWKeJrq1MijDb/f9frjQnl+SxXfZ/EPKYRfbxMeotPVtuc8hlqAZLVjePcdAInIUVySniZCkqjL/+QSqjTB8MIt7vNsW4CyCTgZiLIPCMIzAm0XLLsIb4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:136::13)
 by AM7PR10MB3543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 18:19:22 +0000
Received: from AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75f8:4324:56d6:4986]) by AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75f8:4324:56d6:4986%9]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 18:19:21 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>, Mario TESI <mario.tesi@st.com>
Subject: RE: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and
 SC7A30E
Thread-Topic: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and
 SC7A30E
Thread-Index: AQHWb+ZLsXoWyR0t0k2/cwSueTdhG6k6hvKAgAAixoCABR/csA==
Date:   Wed, 19 Aug 2020 18:19:21 +0000
Message-ID: <AM7PR10MB3670BE44AE8227C29E8AC48CED5D0@AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM>
References: <20200811134846.3981475-1-daniel@0x0f.com>
 <20200811134846.3981475-3-daniel@0x0f.com>
 <CAHp75VcreDeik-pCQPXV2RQVAEPFNRjGS8Mutvxwog1khVka4g@mail.gmail.com>
 <CAFr9PXma7_FUVZbGk7kzfc1xgYH8WdMWj6FZuO4wO=kNp=iR-w@mail.gmail.com>
In-Reply-To: <CAFr9PXma7_FUVZbGk7kzfc1xgYH8WdMWj6FZuO4wO=kNp=iR-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=st.com;
x-originating-ip: [165.225.34.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 774bef3a-5a01-44eb-ec18-08d8446c6549
x-ms-traffictypediagnostic: AM7PR10MB3543:
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR10MB35435D80E157074C25383713ED5D0@AM7PR10MB3543.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ex3i+ggpBCaW2BvFUhgv4mvQ15hrSUi2+RScihHOkLyTs92qGNrTIf3vVwRjsAvLQWrrbUSwBGSoVOIAoVZMTi7HtcJI3Xqab1Xrj2WZs7hFDMqoIA8/bwU6HErzfHk0mZRRfqkqc35sDABODkZNCDuJ9tDG0AWXIOq/2Sih5L7137XGw6GXdD8D5ZPjGr2cBAb1kP5EHM1n3caOzqnQUNBKE9wHYzZ+Q1uoezuIEffh+jZjRp7HtDDObc2bjddOZxKOzhFLtMvKupxEGx1Tymvw83HQLM2ZiaBsQ6Vu+rKCNCAzJ5SbAZxHID0hL2XYRFqsiWPQ9z1GX7B8oiAtDaFjiZEe07wNOWlhcyhZvx+jegoa1JOq2iP/PNkTl8tTplwnVh0jzW+BmN0hnJ68wfKwrYO/8ReE3OcfihtscyzFJbH4ZWVOaRrwysSNa9Maak0Kc1Pb+w3NNc9U1XN6ZtbaoWS8CTz/b7cXT3rHpVY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(66476007)(54906003)(8936002)(9686003)(53546011)(6916009)(2906002)(19273905006)(4326008)(6506007)(55016002)(7696005)(966005)(186003)(52536014)(26005)(478600001)(8676002)(66446008)(66946007)(76116006)(64756008)(66556008)(33656002)(5660300002)(55236004)(83380400001)(71200400001)(86362001)(316002)(562404015)(563064011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: u2IHiQABaRbFVxmZFtN/Lv2ekCokiDRiKbhz00ndSfgzcwDvkTM7k/AViMIQx9BzGUnLreBzHn2Isebw7orU62yuOYgpT+NzaAVLGS72CKXjlET0NX6wQMxKzRu2B9dkm12KaKXDuF2ikyKBPhjMH9RBtQ79CwJz4mhuQZtfdwExqI4unkHNTy2DPfdls13A8fUYqxivsYLDiIREQdypHyc4aS2/rnyWDH6Iz3ps308mstTwE5rahjBeHakbA/gc4zrRITAlGxCU6CDuL+LRxLcsNvTqhjvK4kL5+U+hNJz/5huCs07YY7W53AWyU0FmFYkEgw+KN/KDcDLDxAqCUyaRgZGBTvHSt6k7tckwNc+d24uf2n2eK35owLhqDxRPLcPLsTTFe4PzuH3sIYbTRNH/HJ/YpXLi3cX3qVKxaCCAtBMR1bj7damaZjGI64VqPPAMObTBuSUCa+7LtAgWgQdz8LEhZaVmR9mBdaXyWvuUoNfqTOod4QoHsJy8rTztwMhdtCJTqVqAaAOAr1f8G2uBrkiwjDsx6RCzG7pQKZuwxgkSfhuKI2J/ER7KUJ8iBH334GfArFtI/sLCA9cu5O9p9cMz1FByB7Nki1B1xpncTODkwXgdX8OnPOKY3B+HUc67ZHsY89J3P7g+XE+k6A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3670.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 774bef3a-5a01-44eb-ec18-08d8446c6549
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 18:19:21.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3R9jEQl7iTevzjyR14XUMkAJAxZhHybtAlaO/ql8hXU62QOs2ZlaI3H3UP8JZyz6VoPUG5o26tRZeeif/ie5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3543
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_11:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190149
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCkkgc3Ryb25nbHkgZGlzYWdyZWUgdGhhdCB0aGVzZSBwYXJ0cyB3aWxs
IGJlIHN1cHBvcnRlZCBieSBTVE1pY3JvZWxlY3Ryb25pY3MgZHJpdmVyLg0KV2UgRE8gTk9UIHdh
bnQgdG8gZmluZCBvdXQgb25lIGRheSB0aGF0IHdlIG5lZWQgdG8gbW9kaWZ5IG91ciBzdHJ1Y3R1
cmUgaW4gb3JkZXIgdG8gc3VwcG9ydCBjb21wZXRpdGlvbi4gSWYgdGhleSBuZWVkIHRvIHN1cHBv
cnQgdGhpcyBjaGlwLCBwbGVhc2UgcHJvdmlkZSBhIG5ldyBkcml2ZXIgZm9yIHRoYXQgcGFydCBs
ZWF2aW5nIFNUTWljcm9lbGVjdHJvbmljcyBkcml2ZXIgbWFuYWdpbmcgb3VyIHBhcnRzLg0KDQpU
aGFua3MgJiBCciwNCkRlbmlzDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IGxpbnV4LWlpby1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWlpby1vd25lckB2
Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJlaGFsZiBPZiBEYW5pZWwgUGFsbWVyDQo+IFNlbnQ6IFN1
bmRheSwgQXVndXN0IDE2LCAyMDIwIDU6MDAgQU0NCj4gVG86IEFuZHkgU2hldmNoZW5rbyA8YW5k
eS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gQ2M6IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIu
a2VybmVsLm9yZz47IEpvbmF0aGFuIENhbWVyb24NCj4gPGppYzIzQGtlcm5lbC5vcmc+DQo+IFN1
YmplY3Q6IFJlOiBbUkZDIFBBVENIIDIvMl0gaWlvOiBzdC1hY2NlbDogQWRkIHN1cHBvcnQgZm9y
IFNpbGFuIFNDN0EyMCBhbmQNCj4gU0M3QTMwRQ0KPiANCj4gSGkgQW5keSwNCj4gDQo+IE9uIFN1
biwgMTYgQXVnIDIwMjAgYXQgMTg6NTUsIEFuZHkgU2hldmNoZW5rbw0KPiA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gTm8gU29CIHRhZz8hIEhpbnQ6IGBnaXQgY29tbWl0
IC1hIC1zIC0tYW1lbmRgIHdvdWxkIGZpeCB0aGlzIGlmIHlvdQ0KPiA+IGhhdmUgcHJvcGVybHkg
Y29uZmlndXJlZCBHaXQuDQo+ID4NCj4gDQo+IFNvcnJ5IEkgd2Fzbid0IGF3YXJlIGl0IHdhcyBu
ZWVkZWQgZm9yIGFuIFJGQy4NCj4gDQo+ID4gT24gdG9wIG9mIHRoYXQsIGNhbiB5b3UgYWRkIERh
dGFzaGVldDogdGFnIHdpdGggbGlua3MgdG8gdGhlIGFjdHVhbA0KPiA+IGNvbXBvbmVudCBkYXRh
c2hlZXRzPw0KPiANCj4gSSB3aWxsIGRvIHRoYXQgZm9yIHRoZSB2MSBvZiB0aGUgcGF0Y2ggc2Vy
aWVzLiBBbGwgb2YgdGhlIGRhdGFzaGVldHMgSSd2ZSBmb3VuZCBzbw0KPiBmYXIgYXJlIG1vc3Rs
eSBDaGluZXNlIGJ1dCB0aGUgcmVnaXN0ZXIgdGFibGVzIGFyZSBpbiBFbmdsaXNoLiBJJ3ZlIGNv
bGxlY3RlZA0KPiB0aGVtIHRvZ2V0aGVyDQo+IGhlcmU6IGh0dHA6Ly9saW51eC1jaGVueGluZy5v
cmcvc2lsYW4vaW5kZXguaHRtbA0KPiANCj4gQ2hlZXJzLA0KPiANCj4gRGFuaWVsDQo=
