Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219331A05FE
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDGE6e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 00:58:34 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:40258 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgDGE6d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 00:58:33 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0374oVVc005584;
        Tue, 7 Apr 2020 00:58:31 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 306pv6qnq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 00:58:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PugDEsdqpBLcLsS6eTI3f1Z9JxptgUBp7mXKkdI50KQZpnUAseTI2ndr8nfwwTd3ueeqsqujmRLuXw9SjJx3zcfm2lf9XQ4nVqcaiyFaBHwfKn+nqyftKLaUMWAN1KNEY0hCN6eLin9shqTDggi5hJDHzx678RIwOJi8aCKw7k1hhAa7XxGoO4aStEIx49vM6LwaYXl9B0IH8IMNPr4/9aWzCAraIKVZF+kIEd5AbQKPWFFCNPmRaUrJ1VlqTwi6Zjc1UPwwGoApcDEd+cEVJeo7OXG6uAr/Xknd4/7cg7m91bHI5tZzCwNw+EEICHcF4SCSE2SeA70Qy9OtbU1/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMeiTJl0GGLfBI+XAIVfmlw+nBgv3BX+pLqpifQoHYo=;
 b=N23avWSweY+L4zSLBg+u2gH81FzgIaNRoJKfxpEqYZk5hJ1dZN5Bw/NeBwrU26y/Ydc8khMnwGRP3AXtXAXEAZjB5X5uygtdKtPoZ0p9xDZGQ/JNQ842uk/z1cZZpSiv+Bwe1aOa6G7lBOkMfd2/9XqOajcUgscQsVGIqoUTjGfoFUIxjmKzT0jwtBuNoY/OAIaYp6nfO3giijxFr95IIA/GSW1QcxWiHvvJkEGiCSd8jtoSiLLrVFAPqmtVxCUnVoqHPj81KDHNVechjS53yyutO2yjkigiYTRyKqtBCVNpcYNO6l0VEkadIfhPDbHEorOUrKfKZL4y5tbbsf5GeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMeiTJl0GGLfBI+XAIVfmlw+nBgv3BX+pLqpifQoHYo=;
 b=XO1qDdIHXBdr5Y/HWY73Zz4cFU1tFZdNiq9Wmm2OJj5d/G4myMHYWPTtgbOiyy2ql1cdwiC7vRz0sSSmcGEGloXg6BSV21asNtLRrNqq1DvhUGA1BpVisfx3cRNuRcCK2TjR81uFmDxpoJBHplpbHdWaWqZBKJSlOOpaOM39iAY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4345.namprd03.prod.outlook.com (2603:10b6:5:10f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Tue, 7 Apr
 2020 04:58:28 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 04:58:28 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: core: move 'indio_dev->info' null check first
Thread-Topic: [PATCH] iio: core: move 'indio_dev->info' null check first
Thread-Index: AQHWDEkhKFaiQSYROEmBGFoZTClxX6htGtSA
Date:   Tue, 7 Apr 2020 04:58:28 +0000
Message-ID: <8a13307a8973efcf1adac349208f274d480f0f02.camel@analog.com>
References: <50f3bbed-c46c-b28d-cf7d-101582df1c53@web.de>
In-Reply-To: <50f3bbed-c46c-b28d-cf7d-101582df1c53@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96f37c86-a370-4c80-39cd-08d7dab04fe4
x-ms-traffictypediagnostic: DM6PR03MB4345:
x-microsoft-antispam-prvs: <DM6PR03MB434591CDAF204B28393887A9F9C30@DM6PR03MB4345.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(396003)(136003)(376002)(39850400004)(366004)(66476007)(8676002)(81156014)(2616005)(66556008)(66446008)(4744005)(4326008)(71200400001)(64756008)(81166006)(91956017)(76116006)(186003)(316002)(86362001)(66946007)(8936002)(54906003)(6512007)(6486002)(478600001)(26005)(5660300002)(110136005)(6506007)(2906002)(36756003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+9FBiPOZj8bmhfezGtWAeEZemoILkEbGrGfkCfeKiEwkC8MUBi/zLnTffcxFQ7RxSFaY9vUNbpi6EG1dtQmiXYRPHCiLPeqWojI3Ns+uH8waD8gvy7gmDhasEBzhlj4kEnGxMMZ6mNE0Hkl7WSjKxfzNRtXOvRkvjvZM32HNqNMvXJ7AhD03vGaW2gpAiCwMmyRKXAHOzLFfn+sFhVJGDoo6oHitUubu4qYt1TICuNJWeGas0yuo/0o5hPv8BhFqRy23O8wTCfS1vwNYBnGMu0c/lPmr3cFCq1dU/FgBFfwVv0CC+kptbc/Y5hrSASa5gJ3g/EjAAJzi780o6uRg3vJ6WyP8ZLQht3RVnrD8dxLl8u2hCZ9r4uZhjlqgHHAIna3WvcUl3ixR1xikwkql335IWvDreqZ00p5uCMrXTJ1BqNB7UoPTa66baMlLZiL
x-ms-exchange-antispam-messagedata: aohrRgJ7l10UbmJZcWIa+ByYdGdvHdoBVtf9JJNuMU0w7soAkKEPVILMC8yU7JqweeSjJ9nAXn4AlHJacr6Pv2M9Fkuk0zALY9TCIBTX8cg6F1UiGHhZ2d9EdHMCtdnalsnWBchwwmsLMLZmednRfg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <435CE2222D4F3645BA6CDC906D461EBB@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f37c86-a370-4c80-39cd-08d7dab04fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 04:58:28.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kF+jnH9Qq3YwexU+Y4p0YIbhTu49BJB8kKCGDMDNkFqD8A4xqvgKWzYrZzLbKJA8wfJ7eZwEV5pxIyPQinyDm2Sp/W1Lcwtgk0bGgB9hyE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4345
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_01:2020-04-07,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004070039
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTA2IGF0IDIxOjI1ICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gPiBEb2Vzbid0IGZpeCBhbnl0aGluZy4gSnVzdCBtb3ZlcyB0
aGlzIHRvIGJlIHRoZSBmaXJzdCBjaGVjaywgYXMgaXQncyB2ZXJ5DQo+ID4gc2ltcGxlIGFuZCBm
YWlscyB0aGUgcmVnaXRyYXRpb24gZWFybGllciwg4oCmDQo+IA0KPiBIb3cgZG8geW91IHRoaW5r
IGFib3V0IHRvIHVzZSB0aGUgd29yZCDigJxyZWdpc3RyYXRpb27igJ0gaW4gdGhlIGNoYW5nZQ0K
PiBkZXNjcmlwdGlvbj8NCg0KV2lsbCBmaXguDQpUaGFua3MNCg0KPiANCj4gUmVnYXJkcywNCj4g
TWFya3VzDQo=
