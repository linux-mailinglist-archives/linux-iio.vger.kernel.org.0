Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F57268A1A
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 13:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgINLck (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 07:32:40 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:5399 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgINLbF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 07:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600083065; x=1631619065;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=zhNOmfgXRrcN4mEuYqwroVgEDgqHCywDLKDjeJXFv5Y=;
  b=qIdC1KzgHph5FUBiBkXvQa6Awb47gSaxD7WqfRQ7HDhKKS/7x0aCn5C2
   AGRCF+nF2p54xkoiF8rJi2DlZ7DS6gvvYguN9/xEscXqiyElN2GpOWSKm
   YiQlMKgcv4rQPPX/7SoyMt35yTD92WMFzW5iDDqtbCcElBI3WyE+a7M6I
   VSZHoeK1m4vwxnw0iPHCfdt+VQdBcBZ34DoeTSZhuaKAiL5R/D1yP/Qir
   PIhkTn2PXgvlxubSswk9uMLT7mgbwoJb7iJt+rsRahzYXQZEWO1QKEZUP
   d0TnFTmK3m+D0Joh02HLvi0VNrQcuNPXJmecupZkBLlg24kMcuvm54MTp
   g==;
IronPort-SDR: savFxbHuRMY0FQSXX0vtgaV2/f7Y8OJNkN+DAntQqLk94YScB8Ml0gHFNdzKSY2yGVKx8DPw+B
 KGO1+guy7Qh+dE4l0GDvdchATx5ukkHcRdJSnuzH3k12YHAn+1T/anuSu6EVLhllKSRFlv/5Z8
 ovgexdqPNsL6Dwz8fmx621uOBOUl4FK/tBbvAQPgFWdOoygWJabJYZv9dDUj4kUaBZEXbDtWHD
 gk0yW6fA4OpNZm287rjRiV9cleIG3wXAoZeRYy50Y0OpFRkDBb1e+QTI3C9DV4G+udXIU9wpU4
 6aE=
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; 
   d="scan'208";a="90885049"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 04:30:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 04:30:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 14 Sep 2020 04:30:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbpzmfYrb5aPYoDhP0FUFRByam8UlAZ0NyuTVJwYDmKF5AbeX257JXqU1fkeuL3bEgm2UaxoIRQHIFXzW62pwHZ/BgEKd8+qhLImWc+OdzlD9NTMmMqA+o/65CPloEq+4R+hF6BZfvUb2hkDTQX8DMWI1K604EiFhF5g7e0QNXJnZrHCfEAWyIDEXETFSfhZdEJWcK9o92w1oxlYUiACpcdlxJlnsHi41ocCBSHBYM+F7TC0bRNEe12eeMe5beayMy1TgS+qwR40pbW0dOTkxZIF69bUOkOylqEuiwsXDnuxK4tPXikyIwdrsHOk8eEepR2Gz6e2ZFs5DAvj3bX3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhNOmfgXRrcN4mEuYqwroVgEDgqHCywDLKDjeJXFv5Y=;
 b=eoMy0/Q9Wi7nUbXBMtRg1AjG6JqZ6MRpVbm2yWzOViTN+3SUtsG9SrgJ7GVbcYDBDDZw42Lion522OrfDwk1qB2KY4ZBj73Np75LyRVTz+6Dpbd3cdbIS7ARXGhSvsoDqUK09MDdt7IJ2LoyQVU5hVaTh3jcOVUW318YYooeJEcAnO6Es48BKBy9nO1GU/IOV9df8ZXVh4gO+4TpCfNBdtC8orHiCaUpxQvXHrGBF2YdG1hPmtXspxv/8iRM/XbuZPXElmlGmwnJY/QODI4EvqH5pAF2x1DBhc66Orv//Z1+UsIOdfKSTOxIuBgr/K6SZi9TU7oc+IXr2+0GjOh4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhNOmfgXRrcN4mEuYqwroVgEDgqHCywDLKDjeJXFv5Y=;
 b=NgqVc7/FD1rz6ukXaPkcQEn6oyns+pzUea87DKebO6Tm5/gNZF8gZRRHvwYdXTgzh8tBtUv/hiwsNgv/vejpi9JPxgmBiJLfM6kwH2xr8lj/ZM8YjQMc0VXkHM7ofinXlVBp1WnfSuOfHOe6Nmn2s3hUREafkormYMLM6PBFGLw=
Received: from BYAPR11MB2999.namprd11.prod.outlook.com (2603:10b6:a03:90::17)
 by BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Mon, 14 Sep
 2020 11:30:39 +0000
Received: from BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::3956:c6f:11a4:b79]) by BYAPR11MB2999.namprd11.prod.outlook.com
 ([fe80::3956:c6f:11a4:b79%7]) with mapi id 15.20.3370.018; Mon, 14 Sep 2020
 11:30:39 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandru.ardelean@analog.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: at91-sama5d2_adc crash
Thread-Topic: at91-sama5d2_adc crash
Thread-Index: AQHWiop494KNL5F21kmzJvvymHWACQ==
Date:   Mon, 14 Sep 2020 11:30:39 +0000
Message-ID: <e0822209-0010-f314-39eb-4fae33fb6661@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.24.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7d06546-caf9-4c17-324b-08d858a19b50
x-ms-traffictypediagnostic: BY5PR11MB4165:
x-microsoft-antispam-prvs: <BY5PR11MB416516B1F14D235A055EAA37E8230@BY5PR11MB4165.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VpjFGykrednX07Mnndm2ovePsdDiDHow1yDs8J2qM4KCO0NB5yYgwTUDQnMryj2msn5Df7Qi92YC+Nxzb7VGdkja6T/4D7o/qRY1mW/7xgn/ewsDkG/NVBdlF8QgxtD08JO6xx51wm8Yt+IVlArhBGiuet0VkSt/bAKwOaCbdZDggNUYzmWnjheCMDIfVOeCGlFW0v4WjNQkNIcCgoiM9QCW+7SomDc7bfWe+aDk0361uGlT1l8mNgDgMB//IUCGq2P9M2dsF6sMHSx1UjGN3KHpgS2rG8qhYZGca/ZJUt4+H8OJ3NirItB5W3zGqS6fSqjzLtWxV0jClUuh05G3Z/wf3D+UBjrRIO+Sqfe6eEqdJLbqFwBoif1DxC0xicMV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(4326008)(83380400001)(5660300002)(26005)(478600001)(66556008)(31696002)(66476007)(6512007)(64756008)(8676002)(66946007)(91956017)(6506007)(76116006)(71200400001)(8936002)(186003)(66446008)(31686004)(86362001)(6486002)(54906003)(2906002)(6916009)(2616005)(36756003)(316002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Cj8kQ/Ewc9sTkwo0QNi7ArRbWewFILnqe344DkZsl2/nnzGqkEKnvEHNxHCDfEuN+YVw0+roXo+OUemCL6ow78sFmnlgo03IJwhS0/AZLFSIBgyDrQrE7+DaRfpx3Psr0Xlq3+O+eTbB8dsxCvPs7suoaFoiaGzMUEmNtdB7/6CLtrDYB53PbdHUrOpsFh+dx2SwTMKHwwBjcIZJHBYdDt3/I/9ATGZc1B16BHaVB3PToSKe6FA6yX/Ze7gz0tVzgROi35pk8o7ZIP1ZJuFDhVKNaADKuu4Ymku03sYKPD4QGR887gOIEdmK6uuBnB0jtPilPa5jswrYDlDPBtZ9rHP+Sic2vGZc6oL9dIjlnyUh1Gzlc1Sp9OV2K+Ij7aAgsg/HEhCTQVMKI7+c4+Ae9JxjEVrUtDX6uPlShCdi7ii0itqCgfVMbnBuh6iRkFPAdPA475Vo+7m69FrLP64Sm7q/QgL74bWbSpslGFVw2JgJGIjBiowCs/GHclfqb01uc9XivPXhyoIcmD/7TYszDzdrc1V3WoOs/ubdGs0XV3eU8fhViWCwMbzSwOHDB2/K0ED2Euylsg1+9c6heWZ/39G4FBvj40lQE+L2UI1/MoHlqjWnHDj7ifTdJi9R8yrBsWqqh1/b1UWKPeOyfJsphA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D265EFFAC069B40900DE7E0CEEAFCBA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d06546-caf9-4c17-324b-08d858a19b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 11:30:39.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HK2GVurMiB9z9uC9+M73VxomW9vBJnqnziYFJwR7mYP2YB79T9jbjbY149AFyE3GAXjxl7X53coRplWkdxQE+105XjKu56nCjLBmFqBsE7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4165
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGVsbG8gQWxleCwNCg0KU29ycnkgdG8gZGlzdHVyYiBidXQgd2UgaGF2ZSBpc3N1ZXMgYWdhaW4g
d2l0aCB0aGlzIHBhdGNoIDoNCg0KDQoNCmYzYzAzNGY2MTc3NSAoImlpbzogYXQ5MS1zYW1hNWQy
X2FkYzogYWRqdXN0IA0KaWlvX3RyaWdnZXJlZF9idWZmZXJfe3ByZWRpc2FibGUscG9zdGVuYWJs
ZX0gcG9zaXRpb25zIikNCg0KSSByZWNlbnRseSBkaXNjb3ZlcmVkIGEgY3Jhc2ggd2hlbiB1c2lu
ZyBidWZmZXJlZCB0cmlnZ2VyIHdpdGggRE1BIHdpdGggDQp0aGlzIGRyaXZlcjoNCg0KIyBlY2hv
IDEwMCA+IC9zeXMvYnVzL2lpby9kZXZpY2VzL2lpb1w6ZGV2aWNlMC9idWZmZXIvbGVuZ3RoDQoj
IGVjaG8gMTAwID4gL3N5cy9idXMvaWlvL2RldmljZXMvaWlvXDpkZXZpY2UwL2J1ZmZlci93YXRl
cm1hcmsNCiMgZWNobyAxID4gL3N5cy9idXMvaWlvL2RldmljZXMvaWlvXDpkZXZpY2UwL3NjYW5f
ZWxlbWVudHMvaW5fdm9sdGFnZTRfZW4NCiMgaWlvX2dlbmVyaWNfYnVmZmVyIC1uIGZjMDMwMDAw
LmFkYyAtdCANCmZjMDMwMDAwLmFkYy1kZXYwLWV4dGVybmFsX3Jpc2luZyAtYyA1DQppaW8gZGV2
aWNlIG51bWJlciBiZWluZyB1c2VkIGlzIDANCmlpbyB0cmlnZ2VyIG51bWJlciBiZWluZyB1c2Vk
IGlzIDANCi9zeXMvYnVzL2lpby9kZXZpY2lpL2lpbzpkZXZpY2UwIGZjMDMwMDAwLmFkYy1kZXYw
LWV4dGVybmFsX3Jpc2luZ28gDQppaW86ZGV2aWNlMDogdXNpbmcgZG1hMGNoYW4xMCBmb3Igcngg
RE1BIHRyYW5zZmVycw0KDQpEaXZpc2lvbiBieSB6ZXJvIGluIGtlcm5lbC4NCkNQVTogMCBQSUQ6
IDI0MyBDb21tOiBpcnEvMTgyLWZjMDMwMDAgTm90IHRhaW50ZWQgNS44LjAtcmMxICMxDQpIYXJk
d2FyZSBuYW1lOiBBdG1lbCBTQU1BNQ0KWzxjMDEwY2FmMD5dICh1bndpbmRfYmFja3RyYWNlKSBm
cm9tIFs8YzAxMGEwMzQ+XSAoc2hvd19zdGFjaysweDEwLzB4MTQpDQpbPGMwMTBhMDM0Pl0gKHNo
b3dfc3RhY2spIGZyb20gWzxjMDNhODkyYz5dIChMZGl2MCsweDgvMHgxMCkNCls8YzAzYTg5MmM+
XSAoTGRpdjApIGZyb20gWzxjMDNhODhmYz5dIChfX2FlYWJpX3VpZGl2bW9kKzB4OC8weDE4KQ0K
WzxjMDNhODhmYz5dIChfX2FlYWJpX3VpZGl2bW9kKSBmcm9tIFs8YzAzNTkyZDQ+XSAoZGl2X3M2
NF9yZW0rMHgzYy8weGM0KQ0KWzxjMDM1OTJkND5dIChkaXZfczY0X3JlbSkgZnJvbSBbPGMwNWVk
MzQ0Pl0gDQooYXQ5MV9hZGNfdHJpZ2dlcl9oYW5kbGVyKzB4Y2MvMHg0OTQpDQpbPGMwNWVkMzQ0
Pl0gKGF0OTFfYWRjX3RyaWdnZXJfaGFuZGxlcikgZnJvbSBbPGMwMTQ5NDRjPl0gDQooaXJxX3Ro
cmVhZF9mbisweDFjLzB4NzgpDQpbPGMwMTQ5NDRjPl0gKGlycV90aHJlYWRfZm4pIGZyb20gWzxj
MDE0OTZkYz5dIChpcnFfdGhyZWFkKzB4MTI0LzB4MWQwKQ0KWzxjMDE0OTZkYz5dIChpcnFfdGhy
ZWFkKSBmcm9tIFs8YzAxMzI1YjQ+XSAoa3RocmVhZCsweDEzOC8weDE0MCkNCls8YzAxMzI1YjQ+
XSAoa3RocmVhZCkgZnJvbSBbPGMwMTAwMTQ4Pl0gKHJldF9mcm9tX2ZvcmsrMHgxNC8weDJjKQ0K
RXhjZXB0aW9uIHN0YWNrKDB4ZGU0OWRmYjAgdG8gMHhkZTQ5ZGZmOCkNCmRmYTA6ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIA0K
MDAwMDAwMDANCmRmYzA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwIA0KMDAwMDAwMDANCmRmZTA6IDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDEzIDAwMDAwMDAwDQpEaXZpc2lvbiBieSB6ZXJvIGlu
IGtlcm5lbC4NCkNQVTogMCBQSUQ6IDI0MyBDb21tOiBpcnEvMTgyLWZjMDMwMDAgTm90IHRhaW50
ZWQgNS44LjAtcmMxICMxDQpIYXJkd2FyZSBuYW1lOiBBdG1lbCBTQU1BNQ0KWzxjMDEwY2FmMD5d
ICh1bndpbmRfYmFja3RyYWNlKSBmcm9tIFs8YzAxMGEwMzQ+XSAoc2hvd19zdGFjaysweDEwLzB4
MTQpDQpbPGMwMTBhMDM0Pl0gKHNob3dfc3RhY2spIGZyb20gWzxjMDNhN2UyND5dIChMZGl2MF82
NCsweDgvMHgxOCkNCls8YzAzYTdlMjQ+XSAoTGRpdjBfNjQpIGZyb20gWzxjMDM1OTM0ND5dIChk
aXZfczY0X3JlbSsweGFjLzB4YzQpDQpbPGMwMzU5MzQ0Pl0gKGRpdl9zNjRfcmVtKSBmcm9tIFs8
YzA1ZWQzNjA+XSANCihhdDkxX2FkY190cmlnZ2VyX2hhbmRsZXIrMHhlOC8weDQ5NCkNCls8YzA1
ZWQzNjA+XSAoYXQ5MV9hZGNfdHJpZ2dlcl9oYW5kbGVyKSBmcm9tIFs8YzAxNDk0NGM+XSANCihp
cnFfdGhyZWFkX2ZuKzB4MWMvMHg3OCkNCls8YzAxNDk0NGM+XSAoaXJxX3RocmVhZF9mbikgZnJv
bSBbPGMwMTQ5NmRjPl0gKGlycV90aHJlYWQrMHgxMjQvMHgxZDApDQpbPGMwMTQ5NmRjPl0gKGly
cV90aHJlYWQpIGZyb20gWzxjMDEzMjViND5dIChrdGhyZWFkKzB4MTM4LzB4MTQwKQ0KWzxjMDEz
MjViND5dIChrdGhyZWFkKSBmcm9tIFs8YzAxMDAxNDg+XSAocmV0X2Zyb21fZm9yaysweDE0LzB4
MmMpDQpFeGNlcHRpb24gc3RhY2soMHhkZTQ5ZGZiMCB0byAweGRlNDlkZmY4KQ0KZGZhMDogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgDQowMDAwMDAwMA0KZGZjMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgDQowMDAwMDAwMA0KZGZlMDogMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMTMgMDAwMDAwMDANCnNjaGVkOiBSVCB0aHJv
dHRsaW5nIGFjdGl2YXRlZA0KDQoNCkl0IGxvb2tzIGxpa2UgY3Jhc2ggaXMgdGhlcmUgc2luY2Ug
NS44LXJjMSBpbnRyb2R1Y2VkIGJ5IHRoYXQgcGF0Y2gNCg0KSSBsb29rZWQgaW4gdGhlIGNvZGUg
YW5kIGl0IGxvb2tzIHNvbWV0aGluZyBpcyB6ZXJvLCBwcm9iYWJseSB0aGUgDQpyZWNlaXZlZCBi
dWZmZXIgc2l6ZS4gSXQgaXMgbGlrZWx5IHRoYXQgdGhlIERNQSBzdGFydHMgdG9vIHNvb24gYmVm
b3JlIA0KdGhlIGJ1ZmZlciBpcyBwcm9wZXJseSBzZXR1cCA/DQoNCkNhbiB5b3UgaGVscCB3aXRo
IGZpeGluZyB0aGlzID8gb3IgeW91IGtub3cgaG93IHdlIGNhbiBkbyBpdCA/DQpBbHNvIGNvdWxk
IHlvdSByZW1pbmQgbWUgd2h5IHdlIGVuYWJsZSBhbmQgc3RhcnQgdGhlIERNQSBvbiBwcmUtZW5h
YmxlIA0Kb2YgdGhlIGJ1ZmZlciBpbnN0ZWFkIG9mIHBvc3QtZW5hYmxlIG9mIHRoZSBidWZmZXIg
Pw0KSW4gcHJlLWVuYWJsZSwgZG8gd2UgaGF2ZSBldmVyeXRoaW5nIHJlYWR5IGluc2lkZSBJSU8g
dG8gYmUgYWJsZSB0byANCnN0YXJ0IHRoZSBETUE/IE9yIGl0J3MgYmV0dGVyIHRvIGhhdmUgaXQg
YXQgcG9zdC1lbmFibGUgdGltZSA/DQoNCkkga25vdyB5b3Ugd2FudCB0byBkaXRjaCB0aGUgcG9z
dC1lbmFibGUgYW5kIHByZS1kaXNhYmxlIGhvb2tzLCBidXQgaXQgDQpsb29rcyB0aGlzIGRyaXZl
ciBuZWVkcyB0aGVtLCBvciB3ZSBuZWVkIHRvIGZpbmQgYSB3YXkgdG8gbWFrZSBpdCB3b3JrIA0K
cHJvcGVybHkNCg0KVGhhbmtzICENCkV1Z2VuDQo=
