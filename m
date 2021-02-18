Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF031E550
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 06:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhBRFTL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 00:19:11 -0500
Received: from mail-eopbgr40132.outbound.protection.outlook.com ([40.107.4.132]:20100
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229460AbhBRFTL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Feb 2021 00:19:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKjA7kSwzad9KJCCf8RmXCqdgpdxBOX/tjTha8QDiGdWHHN52p4YQo77wFLYZ68hp31m4AdMYXEiHLzQ9IdCz5t4pAcyCIR6SdmOLZAbqOynLf6+MYND3EctxhUo67sZJj4aELnOwsvw8ccxkuUxP1uQgImEMbAU9al1gZcfR+yRjdAhfMLGOz14TgZ2NXSLoxXzOjssHCnivzIzHTllI95Ee/RMPoPz2jJU1V7qJUWWDqI02IqUwx9EQkLckFqEvagBhmf3RPCSP1n3xHuPuQwNueC8k0XmENrDfsEVyjqJkEPDAQ5DBivhXosgPElkuTa05PiRrtem+Z7+Ftsepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMkmJH4gNX1m+VYUn4Wmo09kd9t14yBnYzQ10yvxW1I=;
 b=F4vOjCWmORvCp4vo4EedosWch6Gersmmdh7tXiDXC0mcoQblwfbcpoAqcVTTUKLIZrOc0o+3D+cj726rkrUQUoJXNw4X0JPX759piU+xNIiF7U/ZaMbxzzeaVpi1rvpaYCnH1oFI8zJeyQG1N4rJ3FTGiAh8pbb3Pn3+A0svDe/xhMywYZaJhwhzU/z//ijzioytTUIf6Caa7D2arCgriiQ7WwzB2uUkm+iKnpYxmbbee6fm2j/zoRPJLiTKSB/iUJknWhjPwhmmdSTJp+ABgUC9HlTDA+TVThArP1YhmaHD3Rw1mgz3jeOZWf3DeHYM8afao5xKVh6JqnbACmi9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arcelik.com; dmarc=pass action=none header.from=arcelik.com;
 dkim=pass header.d=arcelik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arcelik.onmicrosoft.com; s=selector1-arcelik-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMkmJH4gNX1m+VYUn4Wmo09kd9t14yBnYzQ10yvxW1I=;
 b=CbFtjNZBEAKGzZya3hYdcBi5aUx+jhXW7HQQQDObvLiO9HWQHocj27th+MfPuxrwCW6/A6zjIFmTZgyslmrcU3gTgXhTi9h9LLlPIY338REGYKtH0fM3hcruT3cAfW2tx0xbuDBlvRGNPr+PyAGdDjMlwwZkjvVYs5/tzJKAsj4=
Received: from AM9PR08MB6083.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::11)
 by AM9PR08MB6081.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Thu, 18 Feb
 2021 05:18:26 +0000
Received: from AM9PR08MB6083.eurprd08.prod.outlook.com
 ([fe80::fda1:facb:77c0:7707]) by AM9PR08MB6083.eurprd08.prod.outlook.com
 ([fe80::fda1:facb:77c0:7707%7]) with mapi id 15.20.3868.028; Thu, 18 Feb 2021
 05:18:26 +0000
From:   =?iso-8859-9?Q?Ekin_B=F6ke?= <ekin_boke@arcelik.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "cengiz@kernel.wtf" <cengiz@kernel.wtf>
Subject: Control Register device tree binding request for Opt3001 
Thread-Topic: Control Register device tree binding request for Opt3001 
Thread-Index: AQHXBbAFH9gYE/Zq80uN4XVTwGmCtQ==
Date:   Thu, 18 Feb 2021 05:18:26 +0000
Message-ID: <AM9PR08MB6083269425D1057113B212709B859@AM9PR08MB6083.eurprd08.prod.outlook.com>
Accept-Language: tr-TR, en-US
Content-Language: tr-TR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=arcelik.com;
x-originating-ip: [84.44.14.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5241e8c-1cfd-4bac-1fb1-08d8d3cc9ec1
x-ms-traffictypediagnostic: AM9PR08MB6081:
x-microsoft-antispam-prvs: <AM9PR08MB608147DB8FC06969A0C3A1089B859@AM9PR08MB6081.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRVVZgCicUzH3DT17dzTGMR7Xt6eEgQBq4DKdcPWSwKEPdNtrSAB3tDppl8IxradFxv4Ox7vpDT94Vbr13PsGZEowVdzAF3OvbXueKk4vYtKK4jZ+/iKHI6fxEmV+JO5kfiQvzsh2BW2WWXdTmflxug930rMvZRd+S+WNejxp1a60Bw4N85F1g3oUn38qnGOydJwUNkEt8B3SvKLHyZ/XqSifr7oj1yWfDNa0hNiwVtAepJmIrPOL46jv/vnQZj1AmLjN+7e0VkawJR4BB1rv+H6dg6LtgGawxtVUPBIhBIrtqs9aKaFrt/ZhOkYKO6+1dxTtG9ZoebE70jrx1+mpk8WlK16wIVdAipzuf3tBSjSPhwLCwoFpeu2DEgs6oZ7Zhd0N7hjq4QohwzJH/J12cpIH4eAxkClx9/zTrmqezbVH7+IYJTuAXOWlbDoEkpeoBoch8nMiO8gKg1T9ofcNGjcxHHxtWJfwcbav1m8PKfapOw/SaihyNh2X3kGaDBoDalhJc+wME4ZwkqhTZ/iVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6083.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(8936002)(8676002)(55016002)(4743002)(4326008)(6506007)(26005)(186003)(9686003)(316002)(7696005)(2906002)(6916009)(66446008)(52536014)(66574015)(66476007)(66946007)(66556008)(64756008)(478600001)(5660300002)(71200400001)(86362001)(33656002)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-9?Q?i3O86V962SRlkYMyrv/oQdJ4axQP3PLrxmaoN0rwtpb6j8uVnt3O+E54hc?=
 =?iso-8859-9?Q?pcJ1UMN6GIh8D3wzEuQBLeGHq7PgD9p35v+1K15anezvbSDXZyGxViBCSh?=
 =?iso-8859-9?Q?bfY8JZkdBtNqa+7oI15IDD4CcC/9EhxPfsLmokcuMVj+Mr/9hI4J/r2I8u?=
 =?iso-8859-9?Q?maIZ0QhGKv0YRpucDgatFeJheHUfZDHx0zliTRzLbytQRF2iOYVvmcnLjv?=
 =?iso-8859-9?Q?OmAUrCPSkmcH116C5ij+w5igN+cZK/VOjlBxQGujmiNZdOyt6m1bDaWVCT?=
 =?iso-8859-9?Q?roIa8WvqhDpIiWaZGmP/35dz91XbxkSNiDgk4Nef2EPp+wVSXNKBOmBR1R?=
 =?iso-8859-9?Q?DteknyJ9dMw/jkLGKmttz9IoIaMXiLzyE+/JVHr/V/pOSCj8wmbhnN/fug?=
 =?iso-8859-9?Q?1iwnWK1jlhjE+mlYQo0i4z9iREOr5vJoa4Yw7r0uGoD0kZLVPn+85R1TTT?=
 =?iso-8859-9?Q?IJGJ754gCaI+6wx2gjjvJbS56Kzm1LLhb8Rx3YSvjFxAiYY1FYYV6l1DEj?=
 =?iso-8859-9?Q?n5CkAifq0lsEqK5XDiHY2CvLT3atZEsYUM4kCMbp9Lt+9LJcjIDwbX4agf?=
 =?iso-8859-9?Q?/kSVaDpkmBL8DWrorsvlxmeoNA7ry04MgSigsdgIOslqvBAh6hfI00GFrS?=
 =?iso-8859-9?Q?vhegFyvDLO9c/vcKo9GBx3r9tjT7DTH4v2S7zyMBSfSkfsSYU/mvRocpOY?=
 =?iso-8859-9?Q?j1vKMDUeqy/uATgj2KtoEPPRrWjIgVADVNAMtWqQjpPsoatVaQCJ++9mgw?=
 =?iso-8859-9?Q?6vrOa/FTokQaWIItPpLLKuAOMp+lrdAHzknofMSQofb+RzYERA3umOntkH?=
 =?iso-8859-9?Q?0lftPFHZFd18qCOIfoJrjlNbSIqjpnlhWo06rDtDSviYOvcvbBaMxz39RL?=
 =?iso-8859-9?Q?+O/FMSe1wDX0qzJpKjp62Nx0Z2VjzAyrlVH1kwORtyRE4NOnTFZPylFLQM?=
 =?iso-8859-9?Q?vFZED3CFqDEJqwpym9egGx2lIo3jB5TiJMlExcGRtNWQ6gwWl+Yl30T1tL?=
 =?iso-8859-9?Q?9Y5LMUq0SonF4kdSJxEj0jwaHmwxGQBvuS1+Wb8wx7di/zxZ7RfXE21wk0?=
 =?iso-8859-9?Q?LQLcNFDF0S7uG5YTZBShzbAcgBWdCWyBi0zJcskNuCaFHG2gahAfF+qR3G?=
 =?iso-8859-9?Q?Pr7NLMqmZ0edeCY55dhDRXY5w6dD59vX/dllW3NpOYK/lGIp78r5aKUA5q?=
 =?iso-8859-9?Q?IdAd3iCLm45jFxA2afc2NZzMU1d4j3ad4NO4BkwX9N+GT9bF9I9IiT6UGx?=
 =?iso-8859-9?Q?gdLs79tX/NB66QQB1WkcSuAjNpHosl40mBllnrgPG94HTWopV+KHE9BoVz?=
 =?iso-8859-9?Q?K8N40bdRtiy6F6w1dVOXheM432ZpnquPaj2LY/0xrpxE3Vc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arcelik.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6083.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5241e8c-1cfd-4bac-1fb1-08d8d3cc9ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 05:18:26.2474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ef5926db-9bdf-4f9f-9066-d8e7f03943f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+itlcC+H/Vdz05sdmOaW5eMw04SsDv96Dzf9OoB3qGBu6Bjqs61FYSeBh8EV3yAzlx3GkVlEKWhIi0qcr08hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6081
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

We are using Opt3001 for a day light control system and according to the da=
ta sheet it has 2 conversion time modes
that are 100 ms(CT=3D0) and 800 ms(CT=3D1) . Configuration register field C=
T controls the conversion time and we want to set the CT parameter at the i=
nitialization to 0 at all times. We could do it by using the in_illuminance=
_integration_time sysfs node at the runtime.

Should we add a parameter to the device tree bindings or is there another w=
ay to set the CT parameter at the initialization?


Best Regards

Ekin



Bu e-posta mesaji kisiye ozel olup, gizli bilgiler iceriyor olabilir. Eger =
bu e-posta mesaji size yanlislikla ulasmissa, icerigini hic bir sekilde kul=
lanmayiniz ve ekli dosyalari acmayiniz. Bu durumda lutfen e-posta mesajini =
kullaniciya hemen geri gonderiniz ve tum kopyalarini mesaj kutunuzdan silin=
iz. Bu e-posta mesaji, hic bir sekilde, herhangi bir amac icin cogaltilamaz=
, yayinlanamaz ve para karsiligi satilamaz. Bu e-posta mesaji viruslere kar=
si anti-virus sistemleri tarafindan taranmistir. Ancak yollayici, bu e-post=
a mesajinin - virus koruma sistemleri ile kontrol ediliyor olsa bile - viru=
s icermedigini garanti etmez ve meydana gelebilecek zararlardan dogacak hic=
bir sorumlulugu kabul etmez. This message is intended solely for the use of=
 the individual or entity to whom it is addressed , and may contain confide=
ntial information. If you are not the intended recipient of this message or=
 you receive this mail in error, you should refrain from making any use of =
the contents and from opening any attachment. In that case, please notify t=
he sender immediately and return the message to the sender, then, delete an=
d destroy all copies. This e-mail message, can not be copied, published or =
sold for any reason. This e-mail message has been swept by anti-virus syste=
ms for the presence of computer viruses. In doing so, however, sender canno=
t warrant that virus or other forms of data corruption may not be present a=
nd do not take any responsibility in any occurrence.
