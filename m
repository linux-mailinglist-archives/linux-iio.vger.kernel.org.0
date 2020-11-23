Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E172C0280
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 10:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgKWJui (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 04:50:38 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:26987 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgKWJuh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 04:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606125037; x=1637661037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1U4giIt3XH6zbhLVwM5cMemU5Yd85t4keQFi3mXrfnU=;
  b=fsgJ0JcLPAJAAY+LQHikLgiwZxPrwBJ0137KFwtfI4b/Y9qoc6Yl5Fb7
   Wwwb/4FGHJCnCJTYjAt1gaAFYw5jAczM20o7G5AzVnQEDHl3Rb3ePBUJc
   9ejK9VrvweA7unusPPbkieUSrlKnaQ5an9imNivX9k6zChvu7VDr7uCJs
   1KwdQyd9Zlz0POZIFzEQ/CQdU5WiUEiGYlQHIJu5XfUBLXHbqt/psKDCp
   aKYNYq4+GvWgIToXSEzMc9z4UTJcbFc1aq8iar9QL9BRMlySyv2nYdcV2
   KGIL99McjiBBbxaxJUX6GLGe8RlxFmnjxSZuJYxFOv9FjvDZZPVzj+zIy
   g==;
IronPort-SDR: Cm+hMPPFwNzz2ioNwIYKxxJVNOy4dPRodrYeV8lvVPjZv8MbAzJpQBJb1i5wMVjTnPWT8ONeuM
 t8/XTksKhZpgk2KkGwpB0HxBGjwZSLm2jq+oTv7pA40v3zHY0wiCn1IlCUjwCt8FXOK8yKkr4L
 V6aiDOXUlRT4BCgxb8MgVAlVE66dbrtcTC3B51NBZrmRyBGxhRWh4ZnuvvXwn5O9fhA9bUH6kn
 JcH7mSj5drQdV8R7HIfVpxlXV2VRX4k+WIPjVSVpd9s6i+6Yj0DRh2nJEk7NMZSdgOV4veNdRv
 g/0=
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="34674082"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2020 02:50:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 23 Nov 2020 02:50:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 23 Nov 2020 02:50:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InZcjHugOOnF2kyBjbtYysyNdvK0MXBPCssnOzqfMJWWw7jQHUVNVsP5glbyUarfDsDZa/2JyCRSZSfyAnm+gwJ0WXvTPJUgEAr7Ir83ndfzC9r0U+j+ru7ZPkPZqaG8HywUTwQY4vzXuOgeqU7Aqoa/zEhyeRQq8rEvG1Vmzi/tMxPiFs0AMNloIND4Og4yNuwMNidjq+WNwxwQWKJYwVlFP5QpMSb+VLeA53WumNbwyqO3fUcCjfPZ6Ff84/9XruOA+HVnwlSj4H3hxzFEsFfptvHrUzmkCipWUSvA2PtwAvTXcl95LaLTQKanS+L+1AZyFJ5SJ1TI57QLccnHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXroJJLFUDIe25nfiiEEAQdITdhOQ6g7Ey6rnyYOsIQ=;
 b=eNJeTHfKYx5q3IiNQzOysL3xgFvlDiXXsUJM/b2HQG37olnjjvuqOTNd9b6iPcEcMXWz8dwIIErJu1ON/IFJmfgl3ytepEq2uBco+xB1sEapMzoIyINoqh7oJZ797rLwq8IHypLQgS2yhAqpY6htmbFBzRiatoq4S0e5YA8EZ42PC+4G1FW+5ipqGirYBj2wQ7nqg0Pdiq2VlPnijxUjt4IhfdFDAJ3A11K1rv5sXbUA9C2x2l2zo1VsPJVtrJa+/sbiqaDn/tcIzpfZQgdhXgOZQ+pzgdqR8JO6asdAkCw4dU8RqEK3zkNBybbirzzvzNMNecNLr4FQ5kdDIG3mhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXroJJLFUDIe25nfiiEEAQdITdhOQ6g7Ey6rnyYOsIQ=;
 b=FK/Zh7xn7nJ6niM9RRd8+UgxDm0Yg8b1mQef9jLGJ1UHCFzH9kF2UrpQ11N7pZgHpR2QsH+WN0u1RMginGjNeI5AjUopJD5qfIRc8LnyjodhHW/cXEQGlmK+G4zyelKrufb4dmcgNQUVvPNuRMPHdMzJ+cu/iZlP2ICJDH8AbvU=
Received: from BYAPR11MB3477.namprd11.prod.outlook.com (2603:10b6:a03:7c::28)
 by BYAPR11MB3303.namprd11.prod.outlook.com (2603:10b6:a03:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Mon, 23 Nov
 2020 09:50:34 +0000
Received: from BYAPR11MB3477.namprd11.prod.outlook.com
 ([fe80::712e:b004:b0c0:6dca]) by BYAPR11MB3477.namprd11.prod.outlook.com
 ([fe80::712e:b004:b0c0:6dca%3]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 09:50:34 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <vilhelm.gray@gmail.com>, <jic23@kernel.org>
CC:     <kamel.bouhara@bootlin.com>, <alexandre.belloni@bootlin.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <joe@perches.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] MAINTAINERS: Add Kamel Bouhara as TCB counter driver
 maintainer
Thread-Topic: [PATCH v3] MAINTAINERS: Add Kamel Bouhara as TCB counter driver
 maintainer
Thread-Index: AQHWwX4W51UXP5UMT0u18aYb6eJOJg==
Date:   Mon, 23 Nov 2020 09:50:34 +0000
Message-ID: <df14f643-e80e-6ae6-dcef-90adefe6d733@microchip.com>
References: <20201121185824.451477-1-vilhelm.gray@gmail.com>
In-Reply-To: <20201121185824.451477-1-vilhelm.gray@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [2a01:cb1c:8c:b200:1047:dcdb:b744:3fbc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dddf7599-872a-4dc0-9524-08d88f953932
x-ms-traffictypediagnostic: BYAPR11MB3303:
x-microsoft-antispam-prvs: <BYAPR11MB3303AFBA1D55014B302CEB2FE0FC0@BYAPR11MB3303.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: STL9kg0sr/r+4ZPLDYtR2EXTXw2W1LOG9aDYj/NsG0iDcM7tEi5/0QuWf1D98EDdTmw4ywjfPF3mrxkiGDAUHxZmMpCr3B7pAAd1mGdP4LX+9FE4sn5/MWVb1P/xJlaBntsiQXTczRsi6xHb69rNztgryYPhiFo+Bp/Ql7hCZaRWl/PJSe8IFB9aoLc+8opDp/aFNOEWruGK0tBXxwUW4UZxgkCBS4R3QWPhq0I6sJaf1hgkM6lFeAKYbrmd8hS2b/3QwjvJZJYmgfQYOs24Q2PzEo5Ja10OjdX+sbXLfFV2jKk4I72QXOwowBJslncmYy7YGWJHQXvu14Fdi6E9os9duXzx/JFkhgO0yJ7O/pco8U4Dm1MKoBo3rjFb8GQ0HqF1Nj+jDVFUGqhzQS15nqUPo/2OnkInXWCukwEf3E3GSnTSsAIWy7iTgXRxR8ZO5iytGPmuQyeP8XCeBlzbL5fatiHrj/NED0HcKsU54Y0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3477.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(366004)(39860400002)(53546011)(186003)(6506007)(31686004)(966005)(5660300002)(2616005)(8676002)(86362001)(8936002)(6486002)(2906002)(83380400001)(71200400001)(6512007)(36756003)(110136005)(316002)(54906003)(4326008)(66446008)(31696002)(91956017)(76116006)(66946007)(66476007)(64756008)(478600001)(66556008)(43740500002)(15866825006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?CBIC5UCpKoQI0oYP7VFK/sN9QhiNH+4fdaIc/NkIOuSBpMtGTtppEWzu?=
 =?Windows-1252?Q?JGnE9JhHX/MrUaJALc9UECJbSLkEzFHII2ZUIQCKSz+ZifHADxhXH+Ip?=
 =?Windows-1252?Q?xBW2EP70MtluBPy/9LBItfKKcaY0aaepxmp/b964Qp7Qx6E0+PipcuKJ?=
 =?Windows-1252?Q?tbRGsYbyN2/AQX60U4ljH20nZJzMFIw4OxtBRpMJzP9xUkcbbzJsfXu9?=
 =?Windows-1252?Q?w56sB4yncpEDJwYpq7Yjp0j9hVtvpGdasjvao60QVA9Umi2IcvIHUY+i?=
 =?Windows-1252?Q?pOY+jrzEq8IeXQUxp04h4LWHnrI4rRhVfqQyF4u4+o7yrNtcZf9ccw9t?=
 =?Windows-1252?Q?wclGTeexYD3Q5YfNeRbiho6dU3/+xMMNH4evxAqoRfuQp9wOxlxO4+PY?=
 =?Windows-1252?Q?C6gt+fXLkdCeWmaBJ1I1cMdRFjkr+m/kNXR8yeKVtfoxhHqjM/urNSSv?=
 =?Windows-1252?Q?SBIcwdS4SRTEIJf1jlF9g9Y40zsopALS82dKX1OnoqxLVKWHeA+lFc8a?=
 =?Windows-1252?Q?Ue7jacwc1RkpnDNn9nczFInGRtxNhuGH25dWanYaHck8B0yam+3CtfNS?=
 =?Windows-1252?Q?QYPm+BhD0G0Cj1wiawvdep/X5ZX9w4qN1WA2OdJPNBt+gServkhEN7Ac?=
 =?Windows-1252?Q?OnSfDB3iSeOFAi8aPkMssOFgcA/BAy7G1/6GZweE8Kwo1CezFrLRsM0w?=
 =?Windows-1252?Q?sINwixiUf9g6SIq/D8k1ipGvRaSE7om4tmP63E0ugElxcO/Fjla5VrhW?=
 =?Windows-1252?Q?ou9Snxfkbk5f18bmKCtDYMoXvMSjfm+2qBUDbliOK/E4pjDVAHfyFvMT?=
 =?Windows-1252?Q?scPrCTWoiSZeNwZr7IhdcIeVJlH9Xnj4skJLMghsUDmd7cp6xtRe/f+N?=
 =?Windows-1252?Q?xKXlNAdyjCsn6JJbV9w0DkxdgfAZxYLYOUHPfnAxwcAhlocNejt0F76y?=
 =?Windows-1252?Q?oVvbmoMbV+s9jHtvW2Ixt2NZ0+rfG7PG8HQVQ4KOHRC55fCh7HNcmFNf?=
 =?Windows-1252?Q?XdCvYyf/bJbAm1tHSKVU5duasCoG7A=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <66FF9A3E80B6C64DB3EC6E7D995E1507@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3477.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddf7599-872a-4dc0-9524-08d88f953932
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 09:50:34.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KeUdQf30O3lDHTX7Xwq3Qu6J/GCg85ID40MoximSzj/4YQcXuv7NNK/+z7oGPV811DOZAreEijkAZZyyEnNjEiZ3lkIXIcUj1XuIKL6sIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3303
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21/11/2020 at 19:58, William Breathitt Gray wrote:
> Acked-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>   Changes in v3:
>    - Reorder entries to match preferred MAINTAINERS ordering
>=20
>   MAINTAINERS | 7 +++++++
>   1 file changed, 7 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 913b5eb64e44..1ee380dfe189 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2104,6 +2104,13 @@ S:       Supported
>   F:     arch/arm64/boot/dts/microchip/
>   N:     sparx5
>=20
> +ARM/Microchip Timer Counter Block (TCB) Capture Driver

Nit: we don't use the ARM/Microchip string for drivers which could be=20
multi-architecture. Only AT91 and Sparx5 families have these entries.

I'm not holding the patch for this:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> +M:     Kamel Bouhara <kamel.bouhara@bootlin.com>
> +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> +L:     linux-iio@vger.kernel.org
> +S:     Maintained
> +F:     drivers/counter/microchip-tcb-capture.c
> +
>   ARM/MIOA701 MACHINE SUPPORT
>   M:     Robert Jarzmik <robert.jarzmik@free.fr>
>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscrib=
ers)
> --
> 2.29.2
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20


--=20
Nicolas Ferre
