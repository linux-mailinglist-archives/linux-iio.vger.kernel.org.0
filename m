Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936C514D141
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 20:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgA2Tjs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jan 2020 14:39:48 -0500
Received: from esa1.tennantco.iphmx.com ([68.232.153.187]:2550 "EHLO
        esa1.tennantco.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgA2Tjs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jan 2020 14:39:48 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2020 14:39:47 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tennantco.com; i=@tennantco.com; q=dns/txt;
  s=selector1; t=1580326787; x=1611862787;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=xL/KPbavYkby/HwrUuoAGKyK63XBPlZQ8VzG2CLDyTU=;
  b=N0B/cbZnQynBmyzb0m61fAqEc1LsK9qtMR7flUo05NOc5zN/a6ItL4/E
   s/8H5ekDr2z9DZinZ+CIdMfM+vHRhSYFDVPAU1kwwMTqb5MhoBcTdF1+H
   OrQ9nemHpvN99ahuJ3sy8guHHuD2hJ2imgT4d6lBNvZrosCfj5DQAeptx
   CkYpnm79HtcCSf5WFJXRE+5PHP82aL06hXDA6EUkZ9/2RRGJSha+aS5v7
   ap63h9ZTn+jlAfl3Jov4YmuQ5t2BnAZB4lqOpARLt4skqfbwewkZK84uu
   GcGTyN6l+l1gyrokqfZblf7cldD1wXMp1ObF+bpf+Vz+X7pmnMHLRt9So
   A==;
IronPort-SDR: fxEwxsvA4Sg7VutVF3i9ZJKxWkOZs7ze/zXfK1M69X700E+7hG7Gq6DXYy9XnyoC2WT+D5aOhm
 3PU6m8FMhC1fMxH5UDDDcdAg/Nykc3Pf7okM5LGF5gJ7ZVrkTgiqhgU7GDdxmO6vk3GzZAXw/z
 nq7genOe1s55xrIEc1R6jeVFbiR+HMf8FvE8XUIrFCizR04CIWu7OxdoV5HFFr4gqcXksGSDno
 Fw8xYJA+MoWwQVYrANCugg7u+Qno/EnphKyBFXdUHV8WtUhYEuL615yOHiWcRR4b3FC/w8YGnV
 aok=
IronPort-PHdr: =?us-ascii?q?9a23=3AIlMuYhx7j/KfHOnXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uoRIJqq85mqBkHD//Il1AaPAdyHrakawLOM6OigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4VvJ6c+xh?=
 =?us-ascii?q?fUvHdFdfldyWd0KV6OhRrx6dq88ZB5/yhMp/4t8tNLXLnncag/UbFWFiktPX?=
 =?us-ascii?q?ov5M3suxnDTA+P6WUZX24LjBdGABXL4Q/jUJvpvST0quRy2C+BPc3rVr80Qi?=
 =?us-ascii?q?it771qSBDzligKMSMy/XzNhcxxiKJbpw+hpwB6zoXJboyZKOZyc6XAdt4cWG?=
 =?us-ascii?q?FPXNteVzZZD428cYUBEvYBM+hboYn8u1QAohSxCBKwBOz00DJEmmP60bE43u?=
 =?us-ascii?q?knDArI3BYgH9ULsHnMotv0NKMSXvqzzKLVzzvDaP1X1in96YPVdR0vr/GNXb?=
 =?us-ascii?q?ZqfsrX00UhFQTFj1uOpo3lJD6VyvoCs26d7+V6U+Kvl3IoqwZrrjezwccsj5?=
 =?us-ascii?q?DEi4QIwV7H7SV02Js5KcG3RUJhbtOpEoFcuiOGO4dsX88uX2FltD4nxrACup?=
 =?us-ascii?q?O3ZjYGxIgoyhLFZfGKfZKE7gz/WOqNJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8vlKLFwzm6bGN5It26M9mI?=
 =?us-ascii?q?IRvEjaGS/5g1v5gLWRdkU55uin8OPnYqjgppCBLYN0khv+MqMymsOhHes4Lg?=
 =?us-ascii?q?kOX2+d+eim073j4FH5QLFNjv0xkanVqozVJcMepqKhAg9V1Jgs6wqnAju7zN?=
 =?us-ascii?q?gVkmMLIV1HdR6djYXlJ0vCLO3kAfq/m1islS1kx/HCPr3vGJXNKX3Dna/vc7?=
 =?us-ascii?q?d9705T0gwzwcpd6ZJTBLAOPvLyV1TttNPGCB85NRa7w+D7CNph0YMSQ36AAq?=
 =?us-ascii?q?icMK/Kq1+H+vovI/WQZI8SoDv9L/kl5/jzjX42gFMdfKip3ZwMZXCmEfRpPV?=
 =?us-ascii?q?+ZbWDvgtgfC2cKuBQxTOjwhF2FSz5TaCX6Y6VprDU6Dp+2SIbCQaizj7Gbmi?=
 =?us-ascii?q?S2BJtbYiZBEF/GWSPsdoOZS7INaSW6PMBsiHoHWKKnRotn0guh4lzU0b1ie8?=
 =?us-ascii?q?bF/iQe/bLky9Vkr7n/hBU783pUCNuQwkmRQmdyl2UUTDhw16d69x8ugmyf2L?=
 =?us-ascii?q?R11qQLXedY4OlEB19gb8zV0vB6BtbuWwnIYtaOThO8T867BS0qEIJj2McANk?=
 =?us-ascii?q?B6HdjqzgvO2SanGfc0r/SKH9R1l8CUxH3tP4B4wnfC2rMmigwKU89GMyuGgb?=
 =?us-ascii?q?Fy5iDPCojPmkOFnKHsfqMZj2bA?=
X-IPAS-Result: =?us-ascii?q?A2EbGgAQ3TFe/2lGL2hmgkOBPgIBEVBegQgDBAsqCoQKg?=
 =?us-ascii?q?0YDhFxehTiaboEvgSMDVAkBAQEBAQEBAQEHAS0CAQEChFeCODwCDQIDAQwBA?=
 =?us-ascii?q?QEEAQEBAQEFAgEBAQECaYU3AQuCOyJxcQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQUCgQxWEREMAQERJxEBIgIFIQIEDSMLChIENYVPA?=
 =?us-ascii?q?y4BoWM+AiMBPwILgQUpiGEBAXSBMoJ/AQEFgkSCOhhXgTUJgQ4oAwEBjCyBT?=
 =?us-ascii?q?D+FZoZVMoIskFWfBweCPAR4lS8ngjgBmEaOYJsNAgQCBAUCDgEBBYIADIFYM?=
 =?us-ascii?q?xojgzxQGA2ONYNbilNDMYEFJIwOAYEPAQE?=
X-IronPort-AV: E=Sophos;i="5.70,378,1574143200"; 
   d="scan'208";a="17982307"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.tennantco.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 13:32:41 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9DVWx58GHdnCegODuOqqxqD4dk5zHht5RIVZyc2mY8u6u931D9SlW58VkcjjeytAVoJZRI0WdAwmuqYBig8k4H71Vgq7NjbFH07687Jdt26o8rZfh/Q0bbFXl/7BMJoRk//y5OXBplrhk/08itT0szzzm+ySO/z76+5MUM8Dh4DGumEUrANnbmDdpCbroV1muc8+6Yb7zYf75nb6uYWsJDC94zKCgg9XkHBcuTwBn8XxK5ZoS5r/wHZrV4Pp6Ax6tUyKO/EjwTt7fczaPQj4X/D/qprx/6G8atdrsh+NEDcua7u+dMwaa7fXqWynbWmaDRetV2fUwaIv0hO/Mh4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL/KPbavYkby/HwrUuoAGKyK63XBPlZQ8VzG2CLDyTU=;
 b=DFJf/oL7k9+4sTtFNm/SiIqcoHSko20hLhz98Fy6xfRHyyFlfEIcjdYJSTVvloOOWZXB9RBRHm/nU+POxVrAFxk5iKPBsysjCnjSobeaLYW/FgCTnyAwOjJPNX4M2YV37MM7GA2hPcTXqIeNUTU1zMuw+Lrxi4cjt6sB65y/2awOZcSac1MPY80oO1kmuxqa3Pr5Vu4FmqRn9K+vWlSrcyZos6S/eMKq3wwP83uN4TMyrsr3jhUlTIx5JQH0Mz9n8QGH/iO3tFafDXCKkURdDSnVPKmLi7iuzGOHYikZaX7zhoqjgekZq2JhvtWQMHJdU7YHLYlEwT5JwAz8WShDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tennantco.com; dmarc=pass action=none
 header.from=tennantco.com; dkim=pass header.d=tennantco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tennantco.onmicrosoft.com; s=selector2-tennantco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL/KPbavYkby/HwrUuoAGKyK63XBPlZQ8VzG2CLDyTU=;
 b=Xk/eajT8Zn+1Gzlcys4G6YACqPZo/aWv1oIPUN7T7GTSAjW06N4yO3kz3hrXRxyX7lBTnTqrXL5bbP8Z0UY37EqJWDXRDSbBKMpgoQegy4YvOJTtf+YLH5ovoc78WkLefdXkc3Wi9C+oEghbRP5M8XB1W3GrTVkCyHDnJr+MAgw=
Received: from CH2PR20MB3271.namprd20.prod.outlook.com (10.255.156.30) by
 CH2PR20MB3206.namprd20.prod.outlook.com (52.132.231.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 19:32:40 +0000
Received: from CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::2d07:5edf:bb4b:8fb]) by CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::2d07:5edf:bb4b:8fb%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 19:32:40 +0000
Received: from tennantco.com (198.204.33.200) by DM5PR06CA0035.namprd06.prod.outlook.com (2603:10b6:3:5d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Wed, 29 Jan 2020 19:32:39 +0000
From:   Dylan Howey <Dylan.Howey@tennantco.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Temperature support for FXLS8471Q accelerometer
Thread-Topic: Temperature support for FXLS8471Q accelerometer
Thread-Index: AQHV1treuS4I4GIzvkaivF8Eh2le8g==
Date:   Wed, 29 Jan 2020 19:32:40 +0000
Message-ID: <20200129193237.GA14494@tennantco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR06CA0035.namprd06.prod.outlook.com
 (2603:10b6:3:5d::21) To CH2PR20MB3271.namprd20.prod.outlook.com
 (2603:10b6:610:2::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dylan.Howey@tennantco.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [198.204.33.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d82be832-772f-426a-2765-08d7a4f200d7
x-ms-traffictypediagnostic: CH2PR20MB3206:
x-microsoft-antispam-prvs: <CH2PR20MB3206D2CD719C618E91403718EF050@CH2PR20MB3206.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(39850400004)(396003)(199004)(189003)(4744005)(478600001)(2906002)(33656002)(316002)(6916009)(36756003)(55016002)(16526019)(186003)(6666004)(956004)(2616005)(7696005)(52116002)(26005)(81156014)(8936002)(1076003)(81166006)(8676002)(8886007)(71200400001)(66476007)(64756008)(66446008)(66946007)(66556008)(86362001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR20MB3206;H:CH2PR20MB3271.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: tennantco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3SryQdYlsmNOH5sQyrxRe4SNVFIKbcV2GMRUCBtr2t+dSeUUlx5HJLq02BEhs9DzEPA492iRBksNnTwPyLIYtigBvu0BXHZiiZBK/FGR69aWaxgL0JUb/XD3E9k07Kf+YQBVTm9Rrwz3T6szmDAOaaRyxAFLVgDLV+zy2Fpk7v5+2i+61wxLlkJRjnb0SSvPL6hF+ie5OhtrvbHdh4Ud8v7x21CS7jJAWic0aUF2/BA+AAZGmLzMlWB54ABPgzldTD4+F/hGhE0gu0WmXY0pOJ9lLc0lJf9PpfvewNhBlniB5WNpS8Mf5gKbT0HTGrnYOey0ffnkYhFBIJBwcsxUFN/AueaSyN67/Gbd81PcJXSsGkCPH5cp/onFjKNMGgy9XA8CxeRwWif9wBuMvFpNobayVqT2u27R5gjllLjfgJ13k9J9WZoGgqn2F+sevB/s
x-ms-exchange-antispam-messagedata: uay6SkRsGz9dxpzfNTdSRDibvridAEoHfbcPTZ4p1uhfgH8RN3c+BM+iGeeLbtgvnJ/BBoeUUyimBysSCkeDGHKq2CYkaL+5scjs6atUuYYXd26BQMuLoV0EDcJkzkwBTYxlJXgnhyeqind9KR+NWQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9FB44BC1BAF66438B767D0FCFDAB0F9@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tennantco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82be832-772f-426a-2765-08d7a4f200d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 19:32:40.0804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 854ee4fb-bf50-420c-8a26-5b96d626ac37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KSPD2CXK1V6N1t6V32nDThcpQMaP+R9v1ifuSW+ids+F9HqCIvcJbs60sPM3Zk/Yc+Zio666ff+f2zD6YW+kyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR20MB3206
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgYWxsLA0KDQpUaGUgbW1hODQ1MiBkcml2ZXIgc3VwcG9ydHMgTU1BODQ1eCwgTU1BODY1eCBh
bmQgRlhMUzg0NzFRIGRldmljZXMuDQoNClRoZSBGWExTODQ3MVEgaXMgdW5pcXVlIGFtb25nIHRo
ZXNlIGRldmljZXMgaW4gdGhhdCBpdCBoYXMgdGhlDQphZGRpdGlvbmFsIGFiaWxpdHkgdG8gbWVh
c3VyZSB0ZW1wZXJhdHVyZS4NCg0KQ3VycmVudGx5IHRoZXJlIGlzIG5vIHN1cHBvcnQgaW4gbW1h
ODQ1MiB0byBtZWFzdXJlIHRlbXBlcmF0dXJlIHdoZW4NCnRoZSBkZXZpY2UgaXMgRlhMUzg0NzFR
LiBXb3VsZCBhbnlvbmUgYmUgb3Bwb3NlZCB0byBtZSBhZGRpbmcgc3VwcG9ydD8NCkkgaGF2ZSBo
YXJkd2FyZSBhbmQgd291bGQgYmUgYWJsZSB0byB0ZXN0IG15IGNoYW5nZXMuDQoNClRoYW5rcywN
Cg0KLS0gDQpEeWxhbg0K
