Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13BCE1390BB
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 13:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAMMHQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 07:07:16 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:16181 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAMMHP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 07:07:15 -0500
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
IronPort-SDR: UG2XOZWtlQqYcFtvOM/FzO5FQzCtMHN7g4O8M1FISpULjERs1+JZngOnZgimMZ/eV0dyOZYGXU
 CIzfN560lKDaZ2mdqN1LCP3kt6wIAM7WsVRTyUJnWJGinvxrIb0pIHzJR+5aGrbGeTnNXdSrJ1
 ZdvjnXZIDaIJMDLzoAkzzdSh2xvG3LWaJewRyw86u/rec8BlBoQ9JVDvuwbN7u1jhoa3RN7Dy6
 pxKax+P8KypdPprIMfLhkJSond6MoAu0jR0xIiT8OV2/EqTpmxs1rjj5TfKfyoyNTNz3rlU1G+
 PJU=
X-IronPort-AV: E=Sophos;i="5.69,428,1571727600"; 
   d="scan'208";a="60596789"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2020 05:07:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 Jan 2020 05:07:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 13 Jan 2020 05:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGrnQBuGae+xUT+CBvGTKxyNVkm5xgrTm5zku92m9KDgO3Eb8E2g6afzLh+TLIQLz8Nj6uLyUIXoFd/6fN+6ACBjL4TgLknxJqkjp1IaLZjecBHCr3WAAa7IreD/YH7+EIVS0IcosQknjvytOgcP9H5VrbZOWE5whvgO1bXX4jDkgGv/hB6dFaLkGYEl13zc/DgtczQVbmgiEhfhyGZCEol3hdeGc6INtSqV1TO4LjmYzlPJs+pGZ9wHfItumIcOhJmbaLhUeqGfZV30CbOzHVrWsXkqXEs7mcz6SiWPzD+vq+xR+6RO7hVVtYyHeA1I+6NHWAIJpoCXTvNKBKh3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zObBFVOaV743hPoGmpYR1GrF4EzW0AsEqoznqzoztxU=;
 b=TBhu3mg0bmCdegvPrfqiN5XxkhHLbtbSg+xNH7NCuI2m+HW4k0Wysgx8Nh+1YyO/Uro7TYAlfoajMcwJZk/IE7dZwWGQDFRlSIvncmufoa2T6yC0yF5+r/Yf9IkrKfa6CD46ixVBiFywp+X6cLrp7JuIJq1uLmzlxYA+ggsDqYH3ydA/gmVhO14XLvQtsjhyuyzmfmFyujLC97iiT3DEbMCcSmd6u6S53SUm/p845zGoJYA5vR0naJcV+J7Wj7BnErJ2Ic/o+qm45RBPXjDUDbCXpm+BGJz8fHz/jTC4z25lvT9zyW0kjucve2ODzFTVXXTBZuuJjBfzaBRh5bepqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zObBFVOaV743hPoGmpYR1GrF4EzW0AsEqoznqzoztxU=;
 b=juy6yBYZZiOMnIr7qh9+M4lK1nBdqMMQQOjl+SgP6DyndqvOca7qhv7znxksC09HKY33lIzYsEDtFx8MnTMy956yrVaKPgYulJ7zy6dJBigFieLh51EMJPTqcfUpS1kQoY9GMBQDd1NPFUNOQftv01Qt5VJRrXi2JGQ0S2JQhw4=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0011.namprd11.prod.outlook.com (10.164.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Mon, 13 Jan 2020 12:07:08 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 12:07:08 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH v2 0/3] Enhancements to at91-sama5d2_adc driver
Thread-Topic: [PATCH v2 0/3] Enhancements to at91-sama5d2_adc driver
Thread-Index: AQHVygn6p8yaS6a+gUC2vsDSH/esQA==
Date:   Mon, 13 Jan 2020 12:07:08 +0000
Message-ID: <1578917098-9674-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1953e6c-6d9e-4e9a-ca3e-08d798211d33
x-ms-traffictypediagnostic: DM5PR11MB0011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB001130B1640F1EC5C6D42225E8350@DM5PR11MB0011.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(8936002)(4326008)(71200400001)(8676002)(81166006)(81156014)(5660300002)(91956017)(478600001)(86362001)(76116006)(66946007)(4744005)(6506007)(54906003)(110136005)(6486002)(186003)(316002)(36756003)(26005)(2906002)(107886003)(66446008)(6512007)(66476007)(66556008)(64756008)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0011;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoBVqVIIi6pLTbwlzCzrGj6ZHWFSrnj1xElF2xE+S7basxG2br8UKr1u+uvAwC7R09GWDy+oXbq1Gi4nbcxl+30ZCZLgrzlhVxc8xDABZ+kGA/5ZIiDMtY/eroVC6Dg0hjjkVlxLZ0msmy5oBj3/HJNb3JlDWKH53bq40QB2lJG7LwVOWqiVa2VRVXLQD1Xppub28qmKoZ1jnnHJc9G6qnNAhWPDLRtfsPcEuCf6kqW15qHuSlHWPiaIqa78ELhMYz+XNE8f8RnKR5hOXvlWz+mmh6atj2e77cUxzEjuibkSTYbZhpNtG3x6YtBRjYrmupA0nxx1ZTObLtNm2zofFMPW1MWaMpLGEqqMGrMuJB8eXNal6lhZFo/FGvFZ6z0zwsLM2AQf4JImFiMTY8akcuUbz6EpEm6gjaMabktfPlDjE7Mm8o1E5LZ99V6wMfn4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c1953e6c-6d9e-4e9a-ca3e-08d798211d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 12:07:08.5971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KFBeQdwNuX5Lq/COdQGnR//51jDwECa9xvD9zmq+aXp49sC6A0oCPJZQkRY0PTp6YwAwDw79GcbNpoQiKH7izoQVhuq9YToCD4lEoHxud4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0011
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

Eugen Hristev (3):
  iio: adc: at91-sama5d2_adc: fix differential channels in triggered
    mode
  iio: adc: at91-sama5d2_adc: handle unfinished conversions
  iio: adc: at91-sama5d2_adc: update for other trigger usage

 drivers/iio/adc/at91-sama5d2_adc.c | 171 ++++++++++++++++++++++++---------=
----
 1 file changed, 111 insertions(+), 60 deletions(-)

--=20
2.7.4
