Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 090AC124D5D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfLRQYW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:24:22 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:27760 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfLRQYM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:24:12 -0500
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
IronPort-SDR: bf1H/xFMqKgXahp31c/tqJTXlbFQMSYHPhVaCTR8lMFEVk6ZzRD/DmfN0ALSD08X96EUJ94J3D
 6coHAHi46/HczHjSark5kIa60a+lySkeoNcP0JaZDJQFXYnVNOx29Ev4THBrQGdZjapDjTdIS9
 3Ey64sXJDJDHNUwFtPZ17rduDRM/FJXNiWX8j6F2w3OTuv03S+a77kBLOFgEN9gfB0INqTSKcv
 XuOp/leJJlHgnvWW3tNJ6l0BgDAFHr5SjeEGKK0sMmeR4sDPV81CHVyo17p5gugO/62Vvogy+M
 IO4=
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="58200070"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Dec 2019 09:24:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 09:24:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Dec 2019 09:24:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjqbQJ5bhPrCZgsKks3OTmO2HmMqJLnJ7XHMcORDAb971Nfn1bbF/jI0qtODIDSUfThKotWuHAHyJrNDLfmGSTLimgUDMqTUWpavEoyneVBvRVUkffPf+moeBrGY4CwVs1KP0gu+XWj5rmV8oJCbOdZ7FHcu2g1cw3sMQ5K8eDcRCXzDAIz3Xr0QZLr4Ua00yPTT8U8W6ZFXfE6yDxQBgyAPyNgMtdPDLEfhJD81xV7s3uDIaBfT2U4pmTykRfLSGMCqklW1JrOUT7mBIPyU+4GItSFG8K4AwiqdhgwCVklW1Kl6wlB1Nn5bDkmYmhe3UzlR8CD7ihCqhmHBxY1T8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP5UvQD1MTEBjelpPd3B3IN7q5WR77UDFIA46K2YJt4=;
 b=W5+QYH4iwdK1I5EnevLpMSBh0oq3h+hlnKXwfF5S+93SnVUeZON/OjW19sXXjPyFc3xq5+GzK0ipKtEhKdHo65CBKk5Jxpl7Wq1dwtAo7xaf++kjBoYdXAYIplx76dffuBxXPV+kzCXcR8NuH0FF//UAUngo9Wpu2LLwec/bXia1OnUICPrV9XTjbT0qPPRFtiTEhIDgGTFE45Fsx9xcUYIGutgFxV05hOMFlwnsqRmqc1o4lKq8zMLYD4DJKJ5awOWDOnEaoYREutD1TrDTwTAM2lbJ+qlhZpkyItvjiRwv9nChQ21bdazhUz/Qr2hpcimD/PDD73BsfUO+aqA+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP5UvQD1MTEBjelpPd3B3IN7q5WR77UDFIA46K2YJt4=;
 b=uzc0bar1kIiZZ4sfbl85qzHvShLhNWvFGvnJ5BuZQ+kGkm0oqu/V7hfqi6yrlfzsoH/fDqZQrChi35sdTTkIpE75UrW7y/xIjnAvCLiQ2KuK9j8aM6swj8vkEuitHyu6VQxpeUGcpGGcdZxgarpvkHmgkdo/PxC7t41FTyYPdbM=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1913.namprd11.prod.outlook.com (10.175.87.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 16:24:05 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 16:24:05 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 10/10] ARM: dts: at91: sama5d2_xplained: enable
 rtc_adc_trigger
Thread-Topic: [PATCH 10/10] ARM: dts: at91: sama5d2_xplained: enable
 rtc_adc_trigger
Thread-Index: AQHVtb+QPhJ2pL0iFUaSi+H+uVoRXA==
Date:   Wed, 18 Dec 2019 16:24:03 +0000
Message-ID: <1576686157-11939-11-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d24aa346-f9db-44dd-63eb-08d783d6b3a3
x-ms-traffictypediagnostic: DM5PR11MB1913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB19131E4EFDAFDE18415BA94FE8530@DM5PR11MB1913.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(4744005)(2616005)(66556008)(316002)(107886003)(8676002)(71200400001)(8936002)(66476007)(26005)(6506007)(2906002)(64756008)(66446008)(66946007)(81156014)(76116006)(81166006)(5660300002)(478600001)(36756003)(54906003)(186003)(4326008)(86362001)(6512007)(110136005)(91956017)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1913;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVp+s0zvuU3EAgjepAKGnY5P/yQvUVPIRH3MGIwKVEo0kP9qbLQRsgEaMuBV3FmqIJ+k25QPLKSqXFvRqe/GE7WSidN4Kq2X7CWSpQqwrx+8/n5MM59u5Rp3Djb0RiF+TbhaqTOXtY80qvveSFx3ErgqDyxL2zhC8eFCQtQ68adVvfQafW49AFHCQ3r0T0o4gsWhfQlqRNuCH8nJCTONYIx0vp7tvP2jdHpODHlTKkTVs0p/SvXbQk2ni7X1LSUeeHQXV3iMgGnGwI6RgyQBT+BB+tfo4wxqH3qpmc9fbQtLciNzTfwB6/RQdVXivsEFsAkc2aA5KCUfZKd6uQkUo2Jl1yZ5eRmbtOlGqFXjC3CO/RxlhbRulc5jx14keDpeqpcWhqXd4tTCkvbgIhCFtqJtPGkvVBKRMGblqbAs7BEQhDdiraZDPZi1gwlIlHgY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d24aa346-f9db-44dd-63eb-08d783d6b3a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 16:24:03.8902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hot+cqMGsu1fuiD/NY2uOYGx8Rf1m9uh9Sx5vHJFeC/mLsYvg2+HiEy2wAKpeWtU/+tyoBkj06FKxXvp95pJISFCnRFlH7HDws8gFY2318k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1913
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Enable the rtc_adc_trigger node.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dt=
s/at91-sama5d2_xplained.dts
index 9d0a7fb..606ca70 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -645,3 +645,7 @@
 		};
 	};
 };
+
+&rtc_adc_trigger {
+	status =3D "okay";
+};
--=20
2.7.4
