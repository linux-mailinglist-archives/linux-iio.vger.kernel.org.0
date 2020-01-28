Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F190A14B48A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 13:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgA1M5m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 07:57:42 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:26260 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgA1M5m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jan 2020 07:57:42 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: JSws7CzWmz80kRcLRP3qQDtkluliM2IrPYRN9C14MMkzlnbmhjDDTVNuPWoUYrMTMP6m+51bGe
 GMTa87UEm2gS1YPmuY5ptSSXXEnxEeHX9ALzD4y1q9X6x1+oXWdctm3OrwaWD1GJ8K2maAQ2TK
 d4OTAKDr8dIdrUQW4tHXOYEBBhasRzh/XCLWqLZw5CwLqQZa4zFiKerYI1yELiYQQP4ITj7gCZ
 bSAAVHsC9YyQ+n/DYOeb2V8QdJuTsxXdeRQzpYvNf3f69X7dz92euXSq5ftUapDgz+iBPqkPAa
 /JQ=
X-IronPort-AV: E=Sophos;i="5.70,373,1574146800"; 
   d="scan'208";a="62378751"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jan 2020 05:57:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 Jan 2020 05:57:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 28 Jan 2020 05:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bevj6+aOdzVtukN7AdYEoPgpr+Uv5SoAms/g90d/5SM+M1hYOiIpQYppWTDRZlSpQlBt388K9m8Bmun7PDaKrSg/yb0pRxOXtIrda0vUezkf69D0zxw3Pyecw4N6VicJryw/Ql6yqGwEOWDAfAjWgoOI92g6NwwtEPzoMXzZWxrXxymczf1yy02FqDieS8/8GVW5m3vkfPopOL742vG9mJl7EAvFuH2QA67QplYAajce1Qu78JWe7DmAJIkTP4FAJ1bc/ZNG9yiCcQ+5w9fhb+0hHjXeOdAlZjc4HW4aL+rDnfb/PX3t/AVfPV9elJxm9irQyVBf69wrNtBUpV7D/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LynQkMfEN6ieeuRwzzFsYfdh/YibJxTyBXxJS79s2C0=;
 b=UdRgfqpDHv33P/DWS9f4iQkAgCMBMjCacXQbtDRLTvP/sna9YRBuEVjeRs+n2aTzVgIZw7B7G573P88/9nFvuFsQnKFQrcFrtnscLNWwJ+yfYtGGQLn0ah+08+RG4BvFgESif41gBv8NOUzfrWG/sC2c+QKbW10wl+8uXWmJAhzE4onyR0HJVPqt10xK24v8ShUNHlAUMQ47ghMPbwfdw5f+koql9idUOfbHg5P/+Q2ztYf4+q6bP4YjA/CTQAibmiNeLXDW5bVx1l3DmhzpzPp2GEe5CYv5un3KomNaZTKnHBCF2fmLNSzG9pzSiXcG1AVpE44UaLcnKPkqSjwQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LynQkMfEN6ieeuRwzzFsYfdh/YibJxTyBXxJS79s2C0=;
 b=ZQwhwWD71ArZhQs//xgMGZyW205hnuDL0FPfoNkL7fe8AiU/6Fk/60hXmXJW9Pr9zCXBqoxD25tS5oxXu1LfrfpYLAeXmL5wKwjl8sKrIAJzcFmktY7gKKNXBUKqYHilOPcZN7N5Ga7XGptanPRNQdDT3EWGcnb/d6d5OoMzHvg=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1852.namprd11.prod.outlook.com (10.175.90.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 12:57:39 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79%6]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 12:57:38 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <alexandru.ardelean@analog.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 0/3] Enhancements to at91-sama5d2_adc driver
Thread-Topic: [PATCH v3 0/3] Enhancements to at91-sama5d2_adc driver
Thread-Index: AQHV1dqE6i9D/FbS9kyqZS4fjgNafw==
Date:   Tue, 28 Jan 2020 12:57:38 +0000
Message-ID: <1580216189-27418-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3c53368-f853-4e01-b2bd-08d7a3f1a790
x-ms-traffictypediagnostic: DM5PR11MB1852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB18521BB491A2A31F47B1623FE80A0@DM5PR11MB1852.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(189003)(6512007)(2616005)(107886003)(76116006)(54906003)(91956017)(110136005)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(8936002)(6486002)(186003)(5660300002)(71200400001)(81156014)(4326008)(2906002)(81166006)(478600001)(4744005)(36756003)(86362001)(6506007)(8676002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1852;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4GKe7Q7/ycJXEh+kalI5k3jPig1nnC92nvkY0YXrNS/nfFSn9H7+oW5A6ePK1bV6+4qrrRQTgD81AK/vXDl1wmgE7PgEYUgsFsJh7smZpqOieQxaOj1rvV/4273O6CBIz7AtxlBE77N1KROysXO7cviLNlI1mYNQeEUwZie0cM+coSZyJ7A1dNJXKWXDgK3YtOy78nu5zZw6h2xwGAq8/2M4G5zmmT2/zZlMJ68f8QDseVleuFKEFxRSwWWp6tNVw7xtHO7D3WQSoFMdj2AvwoI8tOT2wuZvEMCRb/ll60LMAb/TnTZ+YcIw4eyLKqZf6JzsVbucsxSQstpuFnpQp5TYlS1vo6rOCOltWi+TW5aDBeNepKqyY8kMxePMcfuVKMMlwDUq5e6YOpOMa9dcau1thVwXOkhdZQbL5tK+1ZJN7E9jDJc/oNjZZ1PILLs
x-ms-exchange-antispam-messagedata: KONzbF2ldJb+rShGglfhxefS03yRwSvhoAtc7ODzJcUxQGqGzg8m9frlTwWYz/DFOPaMGTY/fmIoX+9bRYjfYnGXMgcIHkkLIBBcICFrgOyHKKCzS8EMwsMZinIE0nAfIJWX1QZ678YCRdTLa+M8IQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c53368-f853-4e01-b2bd-08d7a3f1a790
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 12:57:38.8608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HixP/uyZZFJeScuMs9qv06hEuZ0PFbEGZK1Sso64+Mbshz7x5AEpwUcoMxbjYFh237glgOwzKxam8BT8kggjNQeCpXGrLt91lJYLb/aYop0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1852
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

This is a rework of the first patches from
[PATCH 00/10] Enhancements to at91-sama5d2_adc and rtc trigger

I reworked according to Jonathan's review.
The RTC triggering part is still work in progress and I will send it separa=
tely

Changes in v3:
- Addressed feedback (each patch has changelog) from Jonathan on ML on the =
v2
of this series:
[PATCH v2 0/3] Enhancements to at91-sama5d2_adc driver

Eugen Hristev (3):
  iio: adc: at91-sama5d2_adc: fix differential channels in triggered
    mode
  iio: adc: at91-sama5d2_adc: handle unfinished conversions
  iio: adc: at91-sama5d2_adc: update for other trigger usage

 drivers/iio/adc/at91-sama5d2_adc.c | 167 ++++++++++++++++++++++++---------=
----
 1 file changed, 109 insertions(+), 58 deletions(-)

--=20
2.7.4
