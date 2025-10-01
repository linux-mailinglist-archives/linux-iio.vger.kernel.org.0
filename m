Return-Path: <linux-iio+bounces-24610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23ADBAFBD4
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 10:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09CD7B0296
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040028B51E;
	Wed,  1 Oct 2025 08:52:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2102.outbound.protection.partner.outlook.cn [139.219.17.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704A1DFDAB;
	Wed,  1 Oct 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308744; cv=fail; b=FThWYZ0Lau6sNLZFw0Den5NHSoBIpG4XaZzuU/a5y6ljFO59xzDIHYhCP/bfd7AD+VJzKwJDC/u6xOq9rNis8IC19XfDlwcgv+xV/FW5sTeuvv6C9mClUPeKp93U9vZYObGEUZMPnF+KoAKhDOiIF5SRTSwR3uoIsjTIV5emQk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308744; c=relaxed/simple;
	bh=eXQsMybBD9oCnhDnT5dQklQLXaznXFjvT5TUbhKkS7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ukbu/UY6L0nTQ769H3Xe4zlo7iEMLXyMrZee+NEENJQ4+VVudUEu04JGaMD9zIOuYA3CFcOLoqTnRAd3s8Ls/8oJDC3m4GSi7wEZKYljEq+0ofHP7myO0fJ0BO8K8U30NK58NLsdIPF7fQTazXpqRetjO1ywQ70VU8YoNGY1PEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqAQeHMnpTRpvmYRvXmyt19mf6SCZaXYc6IpKbQI9aCP0GtSgRBW2vmFZxrf9gf2t6yEHFk7j3ZCSXoizzYKaNyRNu1SX/moEEEZP0Ob+lI2N/x2eG3olVg4qz6ygUZMtfBfoEXTVbRUjPSxFpErtFT1UR+ziTrAr8AXRU67nVzBTAOMa73YLwObfSOwES6t6x9DL+q7dJ4Uj9iqwbRBwTi6smFRPseMs4UH97Uhi+C74SmlIf88Ag3Odt8NmxXrtOoTWhIM994WxZEO9mlVCqieQx5ua9tJskW8kxReXmcIYqDaYAWjLFHzPYEuMXHJAQFuv/9jM8BD8T6+CcaY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKzpqoQQPfThr4PkCY2WiRehng2lKWEcJLMmejN23qg=;
 b=N83kKDnKNQGQ71zLSmmypXDEg53rK/tAtAfVpwnxVi9ovJU7m2BuIN4sJCqi31JLYWRlu+1AhRfw8FrNRSo9pUhYbDbkLct6HYz/B9hkgrC7LlVxJBQfyZuf2T/CqU6ai6a1QyneLVTE3L5PVzXsl6wtBeSxToS3MjXOtqUNIBl0v0SOxzhT2F5/GvC+NO61E4tcVRGsz0QkDqOv+uathpG7E/J7dZg1yMdcXRP37So8diu9fZguimOP3Bvge8hJ3PQxv2OqmhEBGan2WCZB48omcggJKM6KrEOiNEBtEKBFp59VU1Vosx90ZgzicJMbj12LYnZARRxn2eKM5ebpGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0825.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:23::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Wed, 1 Oct
 2025 08:18:57 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::81c4:2724:6a48:a18%7]) with mapi id 15.20.9031.026; Wed, 1 Oct 2025
 08:18:57 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Frank Li <Frank.Li@nxp.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>
CC: "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH v3 1/5] i3c: Add HDR API support
Thread-Topic: [PATCH v3 1/5] i3c: Add HDR API support
Thread-Index: AQHcMkFad+bcsjOpI0mL4TUGrQOFO7Ss8wLA
Date: Wed, 1 Oct 2025 08:18:57 +0000
Message-ID:
 <SH0PR01MB084193AC3C4B8D961F228818F9E62@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
 <20250930-i3c_ddr-v3-1-b627dc2ef172@nxp.com>
In-Reply-To: <20250930-i3c_ddr-v3-1-b627dc2ef172@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0825:EE_
x-ms-office365-filtering-correlation-id: 61f30d47-99ed-47a2-f03b-08de00c32b26
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|41320700013|38070700021;
x-microsoft-antispam-message-info:
 ZI0qzWkbzDvQxs1/UMNgnCY6be5LZYAh+wP197WsvXJSZsI+CvvhwH4rbV1eTPg54V9SaY9H/bTL/Krax3wBhZaChklKMsdcP4i8Dczm7ZATOeAnS3lB5GU/XiZiEP7hclXjFUAxZJTWXPHwRAydS3kbdqqI1VrVzI8GE/hcBfuW/paTU1PA4iZ3DdlZSnNeLJ++fQCShncNd55Sdrgtq2URodksIsRC38UXQGww3oBDuwqPQYzS90TZk4IRVomplQdzsPE1WiIoq1mXXL9Vjf+7vHkbnqbiT48VOrun88SXUJSdPwz1VAG5ghYV7H46OwTg/wyLY5H1V/eN9cgZ0aavaFLKQurcPKIdYB41tnOjkhPlj+5Wlxwz82darenz4sdWYrEhYORyzPPp6pEiyMB+kwrfHbmcxECO42JFThuRAbDjU5dlsspU09j55o6EheMF7JKzB8nI3T5jJpUxjnWu6k1lo/T2CfWOkpCwexLrLm6P4PgffNNzAuX60BxrLcVn+aRnaQJxDI9pec2a3hwD20lqzcLREoZnE/q4Km0ZAuIs7mkcf/rVm5MIR+2o8PFtwXub8F1+GxOVRJNtm1jECU6956qY7S/Tc/ayTNM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(41320700013)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4rY+wOMbDY1eXfkr/3W2u9bybf0ExytTK1l4Hw1uho/mL01zXYJ2SU2KB0?=
 =?iso-8859-1?Q?PX8PjhyZQ+kdcJ9mJk7HxVIzbAPAqQVHRWc/Zy+pGZbIfu0tgNkdQzafKs?=
 =?iso-8859-1?Q?9rJ9O9skAFl+HZiqb/SYF9ekVbGb0buDdC+V9EwofU/ud9xMpd3o6BiTTQ?=
 =?iso-8859-1?Q?FNnhH+gg0tx1ncWhY41T+GiElDyVS4evt/GDXpEFGIq28QABuqq0fZv/TE?=
 =?iso-8859-1?Q?KKoBBIz3jGLMcZc5EF9F632WSR1zGUxqAlC2NW+wDgVdNChodVhs6ywO8v?=
 =?iso-8859-1?Q?LYtrdiVTx1HtNEAWfwR2MXsF6T30qWrIsNWhLO1E0Si+UJbaKb0wf29EJA?=
 =?iso-8859-1?Q?zrCbnLIkmUQyX72IoDaS3qGFw3nYpaFl3tQqp85ogaGMlcIVqbnozOoYo0?=
 =?iso-8859-1?Q?OCCKsWtaCGzVQdduINQRVIRFWN+Cvq5TEM/a9B7KhSq1Pyk0rihUDJ6F+5?=
 =?iso-8859-1?Q?+/CvmKZmSbcQM32cQ3B9eLqVBYUwqdLjEawMZG6LXWOoFGLSWj/jZobR21?=
 =?iso-8859-1?Q?KMI1u0JMZ49QR5up/OSYy8NZqBryPdDo6w7p38Ji2VUjWyj6+sqeTkk5Yz?=
 =?iso-8859-1?Q?MM4UPKYxfOtT/u3t79rfMFjpU8WO/p/A/B24fXEbrD3odOBjq27OI3a6lM?=
 =?iso-8859-1?Q?BQzT5u5oiTEVBvg9eOHZw5BP0wh9jT7IEpPUbfI2jp4XwbiXAFaBhaszrV?=
 =?iso-8859-1?Q?aNF0KEvBM/r6//5mLBrhKglzIgB6PfVu2z16nHqV296t/deJFRwrSi+ILy?=
 =?iso-8859-1?Q?+EOvlkMcPaTHQrCntO6OfRThHmuP58ZcsbzxGbRNbQU8aX9Aprtt/ededD?=
 =?iso-8859-1?Q?9eyG0l6PvHnUA8HQFctVVbUkna/eX0lTdubKuBRkLnarsvDTE11kcCj5vc?=
 =?iso-8859-1?Q?gTAfZ84XxitNvNlAfbaa6v14ba1cqwYAZZ+tbJmXCrSJaWtOZH7Bu+pFCK?=
 =?iso-8859-1?Q?7AF4X8xgFwlehfAdX33RT694MRh77TU5FqI1PNqfl9TZp9z9BmIZSiHc6b?=
 =?iso-8859-1?Q?JHpv94EsLNCFvocrMRv6zXhWYWjhZ6KLYRp85MWAePrBFOh18ZULhFb5Kv?=
 =?iso-8859-1?Q?e6Jw0hPLQfzuDyBNysl0gih24XRV4gjvrWogDAQLLg4+ZX9BUPBlI37IEE?=
 =?iso-8859-1?Q?bfHXWUfIvDJebkl8hpGZAuTwI1TrGKltv3mbVMWJsPCMligyIg0nZiLg7x?=
 =?iso-8859-1?Q?mojEvpyH1kIh5SVIiIWydG2FmqIBlP5wfqBECdKNqEZIT0nRIntStpXsf5?=
 =?iso-8859-1?Q?OhqgqAmOFkT0W//cVMYTiC32nh5MxVIhxoXomihcbsHzS4BCgLNXQm4Ife?=
 =?iso-8859-1?Q?Yttaazvc814/2srTGpLfFzDWJCCqX/KZtHFFbTynh+ZIxkxpkHfSHFS4om?=
 =?iso-8859-1?Q?EMYw4QzqpqP6C7KvnJPrcIDAbXk3dURT99mah8kJzQ2zc7xtdtcZ8rLSCl?=
 =?iso-8859-1?Q?sXpyZBT6yEmEa6fgbsURnO7uGY2jajx3o+/8fwfxmM38HN+SOnhp4vKYP8?=
 =?iso-8859-1?Q?cNI6p4cae9ixI04jGFP9bgixHaaZbkyxtR+Px4mYaRERddPMZo4R9048Ar?=
 =?iso-8859-1?Q?QWsgrB65bed7XwAkRL9NzHL8f+btn8e28TQi8HRWmxQXf/lTpKUsJPEt9Y?=
 =?iso-8859-1?Q?9aqMXi13+oXdr/uzpeUSDhUeszMg9qEXAGB2Tl/1nDCsaAIXOItAUXtg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f30d47-99ed-47a2-f03b-08de00c32b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 08:18:57.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMBTeV5qmdMcfjcy+JHjpfM+UmxJEM8sf+X6WzX7a+dCzAn08aY6qb1asNJ5tAjk3rsBloFz08JHHgqHHJesH/cKdHCqEoowYV+faqbDfsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0825

On Wednesday, October 1, 2025 3:34 AM, Frank Li <Frank.Li@nxp.com> wrote:
> Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the=
 I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3, Te=
chnical Overview.
>
> i3c_xfer will be used for both SDR and HDR.
>
> Add i3c_device_do_xfers() with an HDR mode argument, while keeping
> i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers() =
with I3C_SDR for backward compatibility.
>
> Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with 'rn=
w', since HDR mode uses read/write commands instead of the SDR address bit.
>
> Add .i3c_xfers() callback for master controllers. If not implemented, fal=
l back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once=
 all controllers switch to .i3c_xfers().
>
> Add 'mode_mask' bitmask to advertise controller capability.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Why not add hdr mode in struct i3c_priv_xfer because mode can't be mixed =
in one i3c transfer. for example, can't send a HDR follow one SDR between S=
TART and STOP.
>
> i3c_priv_xfer should be treat as whole i3c transactions. If user want sen=
d HDR follow SDR, should be call i3c_device_do_priv_xfers_mode() twice, ins=
tead put into a big i3c_priv_xfer[n].
>
> change in v3
> - Add Depreciated comment for priv_xfers.
>
> change in v2
> - don't use 'priv_' since it is refer to sdr mode transfer in spec.
> - add 'mode_mask' indicate controller's capibility.
> - add helper function to check master's supported transfer mode.
> ---
>  drivers/i3c/device.c       | 27 ++++++++++++++++++++-------
>  drivers/i3c/internals.h    |  6 +++---
>  drivers/i3c/master.c       | 22 ++++++++++++++++++----
>  include/linux/i3c/device.h | 28 ++++++++++++++++++++++------  include/li=
nux/i3c/master.h |  6 ++++++
>  5 files changed, 69 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c index 2396545763=
ff853097d9f0173787e087f7a6e688..00706b47758bc164178a5578a018b36c5c433f5f 10=
0644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -15,12 +15,12 @@
>  #include "internals.h"
>
>  /**
> - * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to=
 a
> - *				specific device
> + * i3c_device_do_xfers() - do I3C transfers directed to a specific=20
> + device
>   *
>   * @dev: device with which the transfers should be done
>   * @xfers: array of transfers
>   * @nxfers: number of transfers
> + * @mode: transfer mode
>   *
>   * Initiate one or several private SDR transfers with @dev.
>   *
> @@ -33,9 +33,8 @@
>   *   'xfers' some time later. See I3C spec ver 1.1.1 09-Jun-2021. Sectio=
n:
>   *   5.1.2.2.3.
>   */
> -int i3c_device_do_priv_xfers(struct i3c_device *dev,
> -			     struct i3c_priv_xfer *xfers,
> -			     int nxfers)
> +int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xf=
ers,
> +			int nxfers, enum i3c_hdr_mode mode)
>  {
>  	int ret, i;
>
> @@ -48,12 +47,12 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
>  	}
>
>  	i3c_bus_normaluse_lock(dev->bus);
> -	ret =3D i3c_dev_do_priv_xfers_locked(dev->desc, xfers, nxfers);
> +	ret =3D i3c_dev_do_xfers_locked(dev->desc, xfers, nxfers, mode);
>  	i3c_bus_normaluse_unlock(dev->bus);
>
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
> +EXPORT_SYMBOL_GPL(i3c_device_do_xfers);
>
>  /**
>   * i3c_device_do_setdasa() - do I3C dynamic address assignement with @@ =
-260,6 +259,20 @@ i3c_device_match_id(struct i3c_device *i3cdev,  }  EXPORT=
_SYMBOL_GPL(i3c_device_match_id);
>
> +/**
> + * i3c_device_get_supported_xfer_mode - Returns the supported transfer m=
ode by
> + *					connected master controller.
> + * @dev: I3C device
> + *
> + * Return: a bit mask, which supported transfer mode, bit position is de=
fined at
> + *	   enum i3c_hdr_mode
> + */
> +u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev) {
> +	return i3c_dev_get_master(dev->desc)->mode_mask;
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
> +
>  /**
>   * i3c_driver_register_with_owner() - register an I3C device driver
>   *
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h index 0d85=
7cc68cc5d473db733b12ffcec0c1c28d9def..2adba9136f3d147b82c58bd9b491d6d1bc6bf=
df7 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -15,9 +15,9 @@ void i3c_bus_normaluse_lock(struct i3c_bus *bus);  void=
 i3c_bus_normaluse_unlock(struct i3c_bus *bus);
>
>  int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev); -int i3c_dev_do_pr=
iv_xfers_locked(struct i3c_dev_desc *dev,
> -				 struct i3c_priv_xfer *xfers,
> -				 int nxfers);
> +int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev,
> +			    struct i3c_xfer *xfers,
> +			    int nxfers, enum i3c_hdr_mode mode);
>  int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev);  int i3c_dev_e=
nable_ibi_locked(struct i3c_dev_desc *dev);  int i3c_dev_request_ibi_locked=
(struct i3c_dev_desc *dev, diff --git a/drivers/i3c/master.c b/drivers/i3c/=
master.c index 2ef898a8fd8065032b68c97c52dcb12e771525a4..1ba21fd737a3138670=
4e47afb3026c4fc8fc7305 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2749,10 +2749,13 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
>
>  static int i3c_master_check_ops(const struct i3c_master_controller_ops *=
ops)  {
> -	if (!ops || !ops->bus_init || !ops->priv_xfers ||
> +	if (!ops || !ops->bus_init ||
>  	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
>  		return -EINVAL;
>
> +	if (!ops->priv_xfers && !ops->i3c_xfers)
> +		return -EINVAL;
> +
>  	if (ops->request_ibi &&
>  	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
>  	     !ops->recycle_ibi_slot))
> @@ -2808,6 +2811,9 @@ int i3c_master_register(struct i3c_master_controlle=
r *master,
>  	master->dev.release =3D i3c_masterdev_release;
>  	master->ops =3D ops;
>  	master->secondary =3D secondary;
> +	/* Spec require must support SDR mode */
> +	master->mode_mask |=3D BIT(I3C_SDR);
> +
>  	INIT_LIST_HEAD(&master->boardinfo.i2c);
>  	INIT_LIST_HEAD(&master->boardinfo.i3c);
>
> @@ -2942,9 +2948,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev=
)
>  						dev->boardinfo->init_dyn_addr);
>  }
>
> -int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
> -				 struct i3c_priv_xfer *xfers,
> -				 int nxfers)
> +int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *x=
fers,
> +			    int nxfers, enum i3c_hdr_mode mode)
>  {
>  	struct i3c_master_controller *master;
>
> @@ -2955,9 +2960,18 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_de=
sc *dev,
>  	if (!master || !xfers)
>  		return -EINVAL;
>
> +	if (!(master->mode_mask & BIT(mode)))
> +		return -EOPNOTSUPP;
> +
> +	if (master->ops->i3c_xfers)
> +		return master->ops->i3c_xfers(dev, xfers, nxfers, mode);
> +
>  	if (!master->ops->priv_xfers)
>  		return -EOPNOTSUPP;
>
> +	if (mode !=3D I3C_SDR)
> +		return -EINVAL;
> +
>  	return master->ops->priv_xfers(dev, xfers, nxfers);  }
>
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h inde=
x 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..be7d9e4c98e09ec29357d19dc73d1f0=
50d7bde1e 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -40,19 +40,22 @@ enum i3c_error_code {
>
>  /**
>   * enum i3c_hdr_mode - HDR mode ids
> + * @I3C_SDR: SDR mode (NOT HDR mode)
>   * @I3C_HDR_DDR: DDR mode
>   * @I3C_HDR_TSP: TSP mode
>   * @I3C_HDR_TSL: TSL mode
>   */
>  enum i3c_hdr_mode {
> +	I3C_SDR,
>  	I3C_HDR_DDR,
>  	I3C_HDR_TSP,
>  	I3C_HDR_TSL,
>  };

Hi Frank,

Perhaps hdr_mode here no longer be meaningful if SDR were to mix in.
This would more like xfer_mode?
=20
>
>  /**
> - * struct i3c_priv_xfer - I3C SDR private transfer
> + * struct i3c_xfer - I3C data transfer
>   * @rnw: encodes the transfer direction. true for a read, false for a wr=
ite
> + * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00=
=20
> + - 0x7f
>   * @len: transfer length in bytes of the transfer
>   * @actual_len: actual length in bytes are transferred by the controller
>   * @data: input/output buffer
> @@ -60,8 +63,11 @@ enum i3c_hdr_mode {
>   * @data.out: output buffer. Must point to a DMA-able buffer
>   * @err: I3C error code
>   */
> -struct i3c_priv_xfer {
> -	u8 rnw;
> +struct i3c_xfer {
> +	union {
> +		u8 rnw;
> +		u8 cmd;
> +	};
>  	u16 len;
>  	u16 actual_len;
>  	union {
> @@ -71,6 +77,9 @@ struct i3c_priv_xfer {
>  	enum i3c_error_code err;
>  };
>
> +/* keep back compatible */
> +#define i3c_priv_xfer i3c_xfer
> +
>  /**
>   * enum i3c_dcr - I3C DCR values
>   * @I3C_DCR_GENERIC_DEVICE: generic I3C device @@ -297,9 +306,15 @@ stat=
ic __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv=
,
>  		      i3c_i2c_driver_unregister,	\
>  		      __i2cdrv)
>
> -int i3c_device_do_priv_xfers(struct i3c_device *dev,
> -			     struct i3c_priv_xfer *xfers,
> -			     int nxfers);
> +int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
> +			int nxfers, enum i3c_hdr_mode mode);
> +
> +static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
> +					   struct i3c_priv_xfer *xfers,
> +					   int nxfers)
> +{
> +	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR); }
>
>  int i3c_device_do_setdasa(struct i3c_device *dev);
>
> @@ -341,5 +356,6 @@ int i3c_device_request_ibi(struct i3c_device *dev,  v=
oid i3c_device_free_ibi(struct i3c_device *dev);  int i3c_device_enable_ibi=
(struct i3c_device *dev);  int i3c_device_disable_ibi(struct i3c_device *de=
v);
> +u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev);
>
>  #endif /* I3C_DEV_H */
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h inde=
x 043f5c7ff398ff631f1eea6acfc54a2e871016d8..de180511dc65e260885099913141eef=
8d0768f5e 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -474,9 +474,13 @@ struct i3c_master_controller_ops {
>  				 const struct i3c_ccc_cmd *cmd);
>  	int (*send_ccc_cmd)(struct i3c_master_controller *master,
>  			    struct i3c_ccc_cmd *cmd);
> +	/* Depreciated, please use i3c_xfers() */
>  	int (*priv_xfers)(struct i3c_dev_desc *dev,
>  			  struct i3c_priv_xfer *xfers,
>  			  int nxfers);
> +	int (*i3c_xfers)(struct i3c_dev_desc *dev,
> +			 struct i3c_priv_xfer *xfers,
> +			 int nxfers, enum i3c_hdr_mode mode);
>  	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
>  	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
>  	int (*i2c_xfers)(struct i2c_dev_desc *dev, @@ -505,6 +509,7 @@ struct i=
3c_master_controller_ops {
>   * @secondary: true if the master is a secondary master
>   * @init_done: true when the bus initialization is done
>   * @hotjoin: true if the master support hotjoin
> + * @mode_mask: bit mask for supported transfer mode
>   * @boardinfo.i3c: list of I3C  boardinfo objects
>   * @boardinfo.i2c: list of I2C boardinfo objects
>   * @boardinfo: board-level information attached to devices connected on =
the bus @@ -528,6 +533,7 @@ struct i3c_master_controller {
>  	unsigned int secondary : 1;
>  	unsigned int init_done : 1;
>  	unsigned int hotjoin: 1;
> +	unsigned int mode_mask;
>  	struct {
>  		struct list_head i3c;
>  		struct list_head i2c;
>
> --
> 2.34.1
>
>
> --=20
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

