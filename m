Return-Path: <linux-iio+bounces-21006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47629AEBFC8
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 21:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1660F1C468F5
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 19:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2857E20AF9C;
	Fri, 27 Jun 2025 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sesame.org.jo header.i=@sesame.org.jo header.b="Z7kXra/6"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022085.outbound.protection.outlook.com [52.101.71.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E621F0E25;
	Fri, 27 Jun 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052580; cv=fail; b=q0+TZU6kJy8wAW0AxeO+XZ8I5WhwSE8RkJwxK55tlziCyzHPNsEpaUHwKCUy8zsNhYNaRfXLRUo124PzOa3Lm0J0eAqnnWA4Bt/WQoWFaqQK9TIjIGPljwrz0WWwZK0KHKZswLTvw1fy5inOXIZJogeIfvZMbKfXkG2iL3wLgr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052580; c=relaxed/simple;
	bh=vpZK6xBIcvqPOcrw+IXFi/F9DDSbIUuQcxsMYFC3oXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jgQOL2kDmXGpxaoLR49ZD1K7AGcwizeofDmbuMpeAGRLY39sNXwv//XhAhq8C/NjErdu7JBvFrWkvGTcJlOUNW3FucyKklotcOCGWmRnkf6dv6cQbQ+4fdSFvTCjsVrn9N/JwIBXKS7ysbKc2SBtu1tjZ/2Hq0orkbvXlUGhQq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sesame.org.jo; spf=pass smtp.mailfrom=sesame.org.jo; dkim=pass (1024-bit key) header.d=sesame.org.jo header.i=@sesame.org.jo header.b=Z7kXra/6; arc=fail smtp.client-ip=52.101.71.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sesame.org.jo
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sesame.org.jo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+o6C5U/4rPx7oujdXMsGfPuAfKrWRmj+WZvzD4LrCZ1dN9P+vLcLfqtTA+UhL1exVc9juX+/yNV2gAgkiRMGDxARRjwGPGV891DhiOUiCCt7XnuJqPngd47kkk3P4seyHsZMW/1yuCDakXj/T12beyffA3HuNtEpnoXD4SOgJ6cnUvUhFbw1uzgU1dqXzdgMxTiGNpLBNGzTLp0cSYpqUwe6o01BkMJAAXmm+3+JueXubX/pX5mfadRHXKnntf3D2Anst5BR9ElOCzliywK8sHZlM5jLS9z5Q72s1kwUyv6Mx1XGW8ysf4mApngF806sKIDmZP2Fz71Enm5eimJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpZK6xBIcvqPOcrw+IXFi/F9DDSbIUuQcxsMYFC3oXM=;
 b=x3e2YkVkdBwoSz5GMfWXODXyZmpqJ0AR9q3B2i+/lX6xEIDokq5cR9pIHc+4wP2oqMd8gV/DzGrdnYJSD/eLWtwXkCAEF8N467zYhX6rmwCy17E3w1OOvFGy/q/6WgxdWbyyDQzJ2MTGZbIGhVDuj5kWepaHAkMODEGDYOuoXEJwIh77RxOiIMrwq8smNfN3n+l0jAcoheZCpl9vpBwzWOcd4vlpxZ6ALDB0mR1+1tHtP58fmzfKu+gLSuzPFIs4OzeFOVbDdVuqvnMeat9zCffIE4fLDa/6j84oSKiBEqbAESoRyhQJpAu7rKHnj3Ss3vOc+sS37Q3jDe801Lu8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sesame.org.jo; dmarc=pass action=none
 header.from=sesame.org.jo; dkim=pass header.d=sesame.org.jo; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sesame.org.jo;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpZK6xBIcvqPOcrw+IXFi/F9DDSbIUuQcxsMYFC3oXM=;
 b=Z7kXra/6H2z59v5tZVY+hdn1px7GWF9DdSoqAZpfh+fgJscEx28NdUKppYjF9D9CXqDo/mWvVtpZwE8C85TgbPR/6yytiTCAt8NPOINWP2JvAM6rGd4zClVOEzXSi+GSLHhvXCM9dK9GkWRyf82xsRzWgkkTicraHZJSNvAJerQ=
Received: from AM9PR08MB6114.eurprd08.prod.outlook.com (2603:10a6:20b:287::8)
 by PAXPR08MB6608.eurprd08.prod.outlook.com (2603:10a6:102:150::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Fri, 27 Jun
 2025 19:29:36 +0000
Received: from AM9PR08MB6114.eurprd08.prod.outlook.com
 ([fe80::e7d:2350:5c10:a839]) by AM9PR08MB6114.eurprd08.prod.outlook.com
 ([fe80::e7d:2350:5c10:a839%5]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 19:29:36 +0000
From: Abdalla Ahmad <Abdalla.Ahmad@sesame.org.jo>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Gabriel Shahrouzi <gshahrouzi@gmail.com>, open
 list <linux-kernel@vger.kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
	<linux-iio@vger.kernel.org>, "open list:STAGING SUBSYSTEM"
	<linux-staging@lists.linux.dev>
Subject: Re: [PATCH] drivers: staging: iio: frequency: ad9832.h: Fixed TODO
 note.
Thread-Topic: [PATCH] drivers: staging: iio: frequency: ad9832.h: Fixed TODO
 note.
Thread-Index: AQHb54wYGKmukPAvzEyOKvcw++VNsbQXVVCAgAAPAeY=
Date: Fri, 27 Jun 2025 19:29:36 +0000
Message-ID:
 <AM9PR08MB6114261F0CA8CD89EC443E59A145A@AM9PR08MB6114.eurprd08.prod.outlook.com>
References: <20250627175114.548076-1-abdalla.ahmad@sesame.org.jo>
 <aF7kW6xRxRb0VN5H@smile.fi.intel.com>
In-Reply-To: <aF7kW6xRxRb0VN5H@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sesame.org.jo;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR08MB6114:EE_|PAXPR08MB6608:EE_
x-ms-office365-filtering-correlation-id: 69eadc96-a30c-4df9-8a9f-08ddb5b0f3c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|41320700013|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?iTlh8q1jlaknaXb/942MX1F5O0EqL+FpQkN9jdpRr4myQ1XmTAaAaTYiIe?=
 =?iso-8859-1?Q?MhYmG0aWuNshzFdjd71bqOtMLXeNOGC+4T7V2abHNCc2m1pSmhGq2MEyd6?=
 =?iso-8859-1?Q?8H+f022Eink8hS7KY8YO185I8kYO8f40zKHXSEpa7sfwjXrKoqCzljjL4R?=
 =?iso-8859-1?Q?yHWvcBSXizWZJIlyX6gbLgBA24bEr1dBhtEo9NsgiFfce3E9rSxs66Sunt?=
 =?iso-8859-1?Q?NSWF7x6E+BXgvBq5tpUY5UIeOY/9peaCjzGQk6ejc7pqObFXUnZYpdAj1d?=
 =?iso-8859-1?Q?4iYywMQwR0wrucdTC2CQVpozxWh0c+hw2Hp85oTVK4MlhPHUKhEIbJgeCQ?=
 =?iso-8859-1?Q?SrRb3yhlHFFK0IOANc26iv2ekcFS3UbvZ/vjTwixh3FOz6eo3fM7pd8kAV?=
 =?iso-8859-1?Q?KZPlP1Z9oED2eNoP9p77JRcE+OEkCzg/g6f/yJMVtzt8ZnVqGxTe9LcpYW?=
 =?iso-8859-1?Q?JDRw2yKXg5YMuh4hW+xNJ8H53kGj8R7OaKQWaSt/O0q0+PR8TDk9041fMe?=
 =?iso-8859-1?Q?hXHJeGJrMRxsfhLVAqs0iTThDb5tqtgU7Oc69VER6LBK0MMY7Xmkv9/307?=
 =?iso-8859-1?Q?WC/NCK2oDBTuquY+ZEJ4RzRqwCzOQtN4sTxheslKgcm1HrOlxFVon829Bo?=
 =?iso-8859-1?Q?jWJjp8duhD7wQhy6XNSe+ty05UW875ZKB11BBAc8s+2L3bzkkxuxC8cmbE?=
 =?iso-8859-1?Q?hZD2oRX2j74yAqKb85eaz+IAO67oKxihKCoOtoybh5DvhKRxUnifBWnzlk?=
 =?iso-8859-1?Q?CtItpLJy0QDu4YM8IZqxf6ablshy3vTeA2JTKVlEcQCwfSYcCSq9/g+FKl?=
 =?iso-8859-1?Q?xyk2jjjoHQmkJV0IIITgT4xuIol207vZhjw7N6AzdVitFw1kBsAF27O4N+?=
 =?iso-8859-1?Q?f5jouPpKMUI50BtLCzP7qdtKCLJD8CW50ISFf1oL6lyc5Tm7IXjORmscn5?=
 =?iso-8859-1?Q?lu5grOWwiqs5YMvkjl2EEp6BbnbEmVadwjXfyyRJPJeYof2VfPZ810e/hQ?=
 =?iso-8859-1?Q?L/OjQCUPvkRXiLA2EENFIj6hr1iu7PraqhUyWNz58/ueQxsZYyPRNImjmI?=
 =?iso-8859-1?Q?jOnmL7LnPWjErEsrHqBVPv5a2Jo+gPARbuOPr04zT536nzYu5EkhLe2xm/?=
 =?iso-8859-1?Q?j0baJFWv1ve28NDn4PzADNnn0JllYqPBumhnEhvZtOwZSpfgEEsPBSEoNk?=
 =?iso-8859-1?Q?gnd76boX+22pB7rzuln2twL/WHQ7VmAmGb7yRxy58JTjFPyxQ2iac7vKv5?=
 =?iso-8859-1?Q?nV5LbnhZPcEJuhYxsAL7bC4nOoVbRVdJthqC7Uw+U8QfAtZZhcksFBcIFc?=
 =?iso-8859-1?Q?AF1r94gEZS2+7dxRfeQJ1iJ96b/XNRFVgJDaocaXpkfotTU2AqoeVFhhwg?=
 =?iso-8859-1?Q?vwfD9uZ6ITDpFJEdwibUcGNrzrV5A26snnjUne/aaiqYDsSoMZq1VpSC8j?=
 =?iso-8859-1?Q?D3p56Jswqji1cERvqkcNFAveL8q1mtHXTCBLz6Ee/435r4m8B4m4kPfhD0?=
 =?iso-8859-1?Q?0bDIeRdfV3aY6YXGSAXG09gXTnSP8OPL8vjg5KhdQhGg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6114.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(41320700013)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7WDaux/MUalM3TWBFTqS5uTZicwyAV0hBJyL6cGkK8q1OxrnvSoSbs7Wp4?=
 =?iso-8859-1?Q?HDLAMnU9C6Pb+rcn9WbMR/IQJqzFTaXSE2E/BVB1CC9tMK2NnrMf5IyYOU?=
 =?iso-8859-1?Q?m+jegBI1TUttkHp5Wf4o9bh0FzXAMuHksJoT/DQpBRUMuv3xr1xt+5erAf?=
 =?iso-8859-1?Q?+znSAmvpTm20nDUTjux5vkY5xFQLihefuixtVf46ag29v+5QCU7IJY3C0D?=
 =?iso-8859-1?Q?Q+/jUj1z6IUOCZAtSyqDNlNoisNd5ZQF90A8tqgIB0OHGRDMK+WmJSu7Hs?=
 =?iso-8859-1?Q?TgcsUY6ODg1Hvyh08UJWR8AEB2FPWPJAKrBOA2Y3nFNoKWpdzfI3IQ/88t?=
 =?iso-8859-1?Q?aperg7fKt4gWXPBo294UQQ2Wc0to4+SVLnwkMv9+9/a6NP1THuMoskrOiE?=
 =?iso-8859-1?Q?MY/vzw65KwXBnE87r/KqO16oiSKcl0yIQioAYOEoTqO8HNUvk9Gk2u51+o?=
 =?iso-8859-1?Q?kKfAXw/bTg7O6m0T8jTUhzpB6Dw5jeLgv/Ca+NLCs0Wzl96BY6JQui6fju?=
 =?iso-8859-1?Q?1GH41xM4ijLGgmBLSg1/eh4clFsDdMab8LBW0vnDW3JuJFGimY5tMqOlVK?=
 =?iso-8859-1?Q?5TyUAHJ5IF6wLmCNbJcpW7LzvqEFwy60TboLKGvJmUz72PGX/ZwiFjBDFK?=
 =?iso-8859-1?Q?RzgDNh1c6PE/Qzl3Tz2zSmRt8tMo1c/SBal6qoDJe927Cmo1n7BSpBUB1Q?=
 =?iso-8859-1?Q?bGKDRMe0WUOsXVUvDUmQfLV1DGWcCod7vbbdHFm+fVB0h4TKI2NhocF52X?=
 =?iso-8859-1?Q?+WQCcs8B/8jdv3k2TPGlE5CgOMOFdwN0oUWwzCtgPb7rG3yWJWZRhMKSsa?=
 =?iso-8859-1?Q?x1F+NxavnXyDs0rxXjU6nzvldMv5j+Td43Q8A23WGz+JdRkSR4HJMgM3tk?=
 =?iso-8859-1?Q?17+sZoC3BZdfHcJoT6HfrRYMIM37GXbveeK1KDAIdmnhH/e2uEFbaS4jOL?=
 =?iso-8859-1?Q?qSgVUbzbe2Bk5Vt4ZI7ArNatdIU688QC/AiJsV8E0QufwHkmA6ZHCCe9+6?=
 =?iso-8859-1?Q?fwAZM0Tz5JSxPiYnoZWCoyLQ+6xsep/9NJhqb/1dQ3GJ0V17vnLBtwwb9p?=
 =?iso-8859-1?Q?Y+dFdfkM2kogRZtCcyfjxUOZqXASbDgO753o2ZJHkIMWStSHBa1cRSBZtG?=
 =?iso-8859-1?Q?U2YjsHbd2JPBwYHG3zWAqLst1FdSCbkujlZowOBzEbwysx3DsvfbPSkZQI?=
 =?iso-8859-1?Q?nIbM+I041spdDaMTyq6tK2tRs1GAGSxcgxH4X2yYvgaBXcM2QfBtF8OCfS?=
 =?iso-8859-1?Q?9Ki/KFks3fmDaA+4azLZEOHe+ARZImAU7s1vM7vzbl0tKvAcLlasKEwVkg?=
 =?iso-8859-1?Q?txoDOxB3kNqi0ljRlihUm4x+/8EBGIzsUaujCkJoBr7tPu1YCuH1enRZBm?=
 =?iso-8859-1?Q?q1EGtpkDph+uvrWxLrBXfqb649Xm53PM6XWAkjr7tHqfJe1opBoninrvtK?=
 =?iso-8859-1?Q?7k+EVYTB5++Z61IND5+LHCetHLG9LyH+dXLQtILYSrh7US3t6BXMhaoOEa?=
 =?iso-8859-1?Q?dPfXoseEqw8/Ipf3yD+a7FwfMsMb1JAdw2F0kmkLAhFZuhTx2IfYey7UCd?=
 =?iso-8859-1?Q?3TyG0itk4ZfwNKUgx8zSPo47sMwTi8cek1DffUxJuoUs8NZxHq7+RA0lvQ?=
 =?iso-8859-1?Q?uikKB4i3TY14JAfIvdURYsBq61wOUgqpOn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sesame.org.jo
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6114.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eadc96-a30c-4df9-8a9f-08ddb5b0f3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 19:29:36.5269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0788906c-6e04-423a-b37e-862cc7808738
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLTdSFKBdFEybPTtOyChgs1G9igXmOpq92bBznu0RZJ6UEXJfNP24jfabtoJZR3DH+Q5PPX4fGsApVmdFWdcZSgXO33hmDmPAid8AgMN9Oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6608

Hi=0A=
=0A=
> Nothing of the above explains "why you are doing this".=0A=
=0A=
The original TODO in drivers/staging/iio/frequency/ad9832.h was:=0A=
> TODO: struct ad9832_platform_data needs to go into include/linux/iio=0A=
So I guess if it really needs to go into include/linux/iio and ad9832 being=
 a DAC, then include/linux/iio/dac/ is the appropriate place. Otherwise, th=
e TODO note needs to be removed.=0A=
=0A=
> Also it sounds like you put three different things in one basket.=0A=
I don't think it is; the header file is now empty (like some of the header =
files), subsequently the header moved to a new location and the c source ne=
eds to include the new file.=0A=
=0A=
> Haven't you added -M -C when preparing the patch? This will make sure you=
 are really copying / moving the context and show only the differences.=0A=
Both gave exact patch file.=0A=
=0A=
> Ideally this should be dropped from any global header file. If one needs =
something like this, it can be propagated via software nodes.=0A=
Well, Including it in include/linux/iio/ made sense to me, would you please=
 elaborate?=0A=
=0A=
=0A=
Best Regards,=0A=
Abdalla=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Andy Shevchenko <andriy.shevchenko@intel.com>=0A=
Sent:=A0Friday, June 27, 2025 9:35 PM=0A=
To:=A0Abdalla Ahmad <Abdalla.Ahmad@sesame.org.jo>=0A=
Cc:=A0Lars-Peter Clausen <lars@metafoo.de>; Michael Hennerich <Michael.Henn=
erich@analog.com>; Jonathan Cameron <jic23@kernel.org>; David Lechner <dlec=
hner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com>; Andy Shevchenko <andy@k=
ernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Gabriel Shahro=
uzi <gshahrouzi@gmail.com>; open list <linux-kernel@vger.kernel.org>; open =
list:IIO SUBSYSTEM AND DRIVERS <linux-iio@vger.kernel.org>; open list:STAGI=
NG SUBSYSTEM <linux-staging@lists.linux.dev>=0A=
Subject:=A0Re: [PATCH] drivers: staging: iio: frequency: ad9832.h: Fixed TO=
DO note.=0A=
=A0=0A=
On Fri, Jun 27, 2025 at 08:51:14PM +0300, Abdalla Al-Dalleh wrote:=0A=
> - drivers/staging/iio/frequency/ad9832.c: Changed .h file location=0A=
> - drivers/staging/iio/frequency/ad9832.h: Removed struct definition=0A=
=0A=
Nothing of the above explains "why you are doing this".=0A=
=0A=
> - include/linux/iio/dac/ad9832.h: Added header file according to the=0A=
>=A0=A0 TODO note.=0A=
=0A=
Also it sounds like you put three different things in one basket.=0A=
=0A=
...=0A=
=0A=
>=A0 #include <linux/iio/iio.h>=0A=
>=A0 #include <linux/iio/sysfs.h>=0A=
> -=0A=
=0A=
This blank line should stay. It will delimit the groups of headers.=0A=
=0A=
> -#include "ad9832.h"=0A=
> +#include <linux/iio/dac/ad9832.h>=0A=
>=A0=0A=
>=A0 #include "dds.h"=0A=
=0A=
> +++ b/include/linux/iio/dac/ad9832.h=0A=
> @@ -0,0 +1,33 @@=0A=
=0A=
Haven't you added -M -C when preparing the patch? This will make sure you a=
re=0A=
really copying / moving the context and show only the differences.=0A=
=0A=
...=0A=
=0A=
> +struct ad9832_platform_data {=0A=
> +=A0=A0=A0=A0 unsigned long=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 freq0;=0A=
> +=A0=A0=A0=A0 unsigned long=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 freq1;=0A=
> +=A0=A0=A0=A0 unsigned short=A0=A0=A0=A0=A0=A0=A0=A0=A0 phase0;=0A=
> +=A0=A0=A0=A0 unsigned short=A0=A0=A0=A0=A0=A0=A0=A0=A0 phase1;=0A=
> +=A0=A0=A0=A0 unsigned short=A0=A0=A0=A0=A0=A0=A0=A0=A0 phase2;=0A=
> +=A0=A0=A0=A0 unsigned short=A0=A0=A0=A0=A0=A0=A0=A0=A0 phase3;=0A=
> +};=0A=
=0A=
Ideally this should be dropped from any global header file. If one needs=0A=
something like this, it can be propagated via software nodes.=0A=
=0A=
--=0A=
With Best Regards,=0A=
Andy Shevchenko=0A=
=0A=

