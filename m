Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48955124D57
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLRQYH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:24:07 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:27743 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfLRQYG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:24:06 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Y9GxzBKjwxMKk91CRCvooY4M6Ci4515qSPgr6P7Wmy1CHUjJJOsUT7pkEBLLb49AA8TZw+bZgz
 dST1xJ1qL2+djKS/PGmpo/knWFmjXYEedVfHJYfvQEv5NarzCm/WvPDjuPTrUmUi/ImEobyNk6
 fNgqRXOsJ7QpufYzuXgzlzzmFxTKk6UPLskPaospsbVP7KYHLqKSFAZaJntceGkWKTbbZiL06/
 LaqfC95hRqPRgrWRb6Cpbl+LqPjjzUq5vKs1JThUsK8VSfUXoJTBcw0T3amiA2oRsEQlfuAqOM
 IaI=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="58200036"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:24:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:24:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 09:24:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb196qMDMsEd19zPkZURzdCDF4S2+aZaV8jery0q1pFsvjkF/cf0f+dbCGbhqF6mchwvp30lCyqZK9ve0KVQKBOdQtIGCqsSjK4CFOyv/CHQFa37N/6OzYWymtf9rAxMecOwIHaZ/cEGTIjENIeMig96GTdCXnHDxHmHA6ctJ+iZ3hV7EzLNDC1Ryl45VZXVJLqUSc6Xvsli5zBYXjGE+GuoGLQ8hx+rynkbVlK941WbkrOrJxzp3UDFfY2KzoI1Y60DhPADGIbV8qw7qx4hEQY9M6u++1+2mkItltg3GRcSpkzAkLcyETw6O6+fICi57RKn0pT37T/t8QJxqFPqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXQ8udlvtPyUpfphdiMvqq84W70x+9q2C0IoOL59urs=;
 b=nXGOf0B/OX1Ub3qDfqIzoEpRyVip4J6HA1TzP0pzxpy1qgspLGogHoCNU/1qam0eIf7ESNC3v3BdLq+X34qoOjpJByrLTgDS8DM7K0NwEev6JBMjfzErbWqslK2pEFDTftJY/W4pvS0zqI8igvNTyCojREuD/cQGjA8zArX+rIElHd8KzjoCGpu3mMgQWUCl9LylTeZ8DI+KVvUdB+xZXID10pW7B7Oh/pIoWoO9C55Pg8VRTmJu3NXu4+12IK5kFtxMhWVsMb7BS7O6p2byKR4TjREhxSnY9Ta8OgOT4ZWaJARB9QpBmrg9my8UOMoB18TkVq41Iwu4A5Re1gzhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXQ8udlvtPyUpfphdiMvqq84W70x+9q2C0IoOL59urs=;
 b=DDm9mMDP2ewKYQp48JY2d7O1tiNijswLe8wAy5zNTTfSF0KRA/NITLZTM6Yvg4+6K2mW07ufVePX9pAakUMWuoB9OtcF27jJfjSptLsCTwbzbL062pD+xdZg/l610fDQMnbxHCOSVJyvf2+yNuzc7aNbNFgeivwwOfEGkAhEoww=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1769.namprd11.prod.outlook.com (10.175.87.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Wed, 18 Dec 2019 16:24:01 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:24:01 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 04/10] rtc: at91rm9200: use of_platform_populate as return
 value
Thread-Topic: [PATCH 04/10] rtc: at91rm9200: use of_platform_populate as
 return value
Thread-Index: AQHVtb+OEQqavda3i02bVS64GBIv7Q==
Date:   Wed, 18 Dec 2019 16:24:00 +0000
Message-ID: <1576686157-11939-5-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bbf8bd1-17d7-4956-04b1-08d783d6b138
x-ms-traffictypediagnostic: DM5PR11MB1769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1769DAA34D00588E03AFC285E8530@DM5PR11MB1769.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(66476007)(66946007)(66446008)(76116006)(91956017)(2616005)(64756008)(66556008)(86362001)(186003)(316002)(110136005)(8676002)(54906003)(8936002)(71200400001)(81166006)(478600001)(2906002)(6512007)(26005)(81156014)(36756003)(4744005)(4326008)(6506007)(5660300002)(6486002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1769;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlcrGL6nAuOZ5gZwwvVWGXr0FzA//wNGwJJ2RJ8yp0VbF8wtggpIE1O6w4DFZ9HCfVou4z5Nf5zSlCW7QlUUVBt+oHaVMTXhqJ4v5poNYTTzqSXlgLviZ5mfavHFLLjWG4p3orcfUOQ2t54FguYNfkhcyZQw3BhAoUg0IIOB7OxeXZ/OTJOJOP8+l5u4cxbvb9rzHsg9mjJUZdLmUNm4B5vtPzLfRy6dJJepBypshohnPQb9hxqNoDt0ywnq1h2koXwLsmHpwf70BEWVatC6mFF22iYYvS50gvt7+xvXskIAHYIAUukapaxQV/8IHnKkZHcVB7PVW7YlDvmcDZhFNAsOZNiD/uikfDqD5yYi/LbYHVW7vpnSFQVrIdxasFytHZCOnkAKqx2Ws8w61KkCnGtuhg7J5I5n20FOzSTNJMU/wacbxnryNk0+v0SNnDE2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbf8bd1-17d7-4956-04b1-08d783d6b138
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:24:00.4408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRYxaDwzzllJZJ/0TgHIU60guO1+YiM9iWtk/CA4vQhFdpMdkSwnX/Sv8uzwnZUHxwMYeuE1rl+sIvgtuP3j9e6GbWYKuYpwEb6uybX8M/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1769
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

This allows the RTC node to have child nodes in DT.
This allows subnodes to be probed.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/rtc/rtc-at91rm9200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 3b833e0..f1b5b3d 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -421,7 +421,7 @@ static int __init at91_rtc_probe(struct platform_device=
 *pdev)
 	at91_rtc_write_ier(AT91_RTC_SECEV);
=20
 	dev_info(&pdev->dev, "AT91 Real Time Clock driver.\n");
-	return 0;
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
=20
 err_clk:
 	clk_disable_unprepare(sclk);
--=20
2.7.4
