Return-Path: <linux-iio+bounces-8919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18C96719E
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 14:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EABFDB21D83
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDBD180A80;
	Sat, 31 Aug 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iQRr2TVl"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2091.outbound.protection.outlook.com [40.92.22.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB60156F33;
	Sat, 31 Aug 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725108634; cv=fail; b=IKxKMf4jYBvGhrjbXO2duIRAZiJE6e3o2UlPUBVb9JECTlKPVwsKBnktyRrAUSn7kEyBjOG04sbzUbm411XWdCTJ7GAnvZmVz1AA+TtRFY6utdvtcuvQ2UHZwzN0Fx6BZEN0yGYC+HrNZ5uubAj8RP+Sk+hUw8PpX2n/NbDStO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725108634; c=relaxed/simple;
	bh=eIszTYoby2JSHBGokfgE6XFeqLReWtXKW0s78llwlSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NlKYGJlSfGBsE457nlUSwWu+J8XaUNhpVSMp1bspOz5dCI9HyuvjTlf9qeApG1NaK9K+cNLNfUo/I3mVSwoB6fyyCcXb8N2TNZoOYUI3ewaIDZhqMmaSJHTUN8KakqLIM0vYutQzaMSkG0mFrWluxEaFQ+mXkOY//Mj9SutLh1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iQRr2TVl; arc=fail smtp.client-ip=40.92.22.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b93SAggySumWhQY1UH24Y5ObU9ErEDJA57EhR02hZaVlcSC2Bwd71e1yw2B4VpAunPM0pYfoxffgK5AeSDFMNqh9q8hciAb1q5D0ih8enmwI+yi07gHVKyN6bQIvhyWVLPWyqKjNHgD01xcFK1vuo67AxtXHiVpfBmBrQDF/860229B7p59yU9MLyG8EPfKF4tmRRSygOdntYu1aBFzz39FOIFrq9lljd+99jTsWQW7givL0VqUKhYUPQ9fmQLSZ8rUBYf3+ZX7tY66uafZ69tctWVhmYJA4zHFCZHagaj54wDUf0fPUUxMpr3BK0Bsth3PWKoZ7vydl1Na4e7NCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3Ou6QGMWo8zlhDWbSGmZohoUM3EnSPHsv1WauRXB4s=;
 b=ysQUMnDlWcBJjGlN6ec1RU4/tumHWHbRrRs9aOVALPtmRlIMMq2jvzI2Dv/JP6A+UIOQODgnfXlJvWwPJedOpAWF9HFQc3StzEUl8ssbXz1MzcqY1eIT+uJnrpNo/BtnNSzZ3ivcyMgp5ju+kFQpFB/iX2HHG+xUTZJgtm6809SXQWFV7RjoCg5zNoRwHuPW/kX4OAfgRvF7N//ejk9PuyzBVV0+WfADp0lrkBC0eff1dK9Z3WxfOc/KptMCO2WFU6HCa8SWQd6OMcWtG+r8jNtGqbmTLvKGuQ0+IozblpK/6aeXtyLhFECRwPGSgj8mfIidNgh1NcJg/KXvlTx1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3Ou6QGMWo8zlhDWbSGmZohoUM3EnSPHsv1WauRXB4s=;
 b=iQRr2TVlFMPMMzLrrXwHQreMzyZr5yX1tlBN5yxymj+LcOridD/hIcOqYBkFjec40nKJOwI2GPCj6Vejsk4emuPzJGtgJLmLn+zEflhPAlN/I893X3MWeSmzZplDpomFDDAnEeFl3GRhugZuckfw9FSdD0cNASB1JNokMGzbDFKS1dy2NgBu0TF0ZpMnsw12gLbqI3HF6Q9TwX+CPtv3I44OH8EwLB0iIyjI6+GfPbua6NRdtzIWzpADa8e2zbcUC8QgqQ4vbhspoIJZTE+uKpPmXm/0VLBA4xURY75F7tgODD1S4ZOdazKaM8BpiBOEpqz/rFL71mPPqo4o0CKckA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB4870.namprd20.prod.outlook.com (2603:10b6:8:a7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Sat, 31 Aug 2024 12:50:31 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Sat, 31 Aug 2024
 12:50:31 +0000
Date: Sat, 31 Aug 2024 20:49:22 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 3/3] riscv: dts: sophgo: Add SARADC description for
 Sophgo CV1800B
Message-ID:
 <IA1PR20MB495323339EFB06E194204904BB902@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
 <20240829-sg2002-adc-v5-3-aacb381e869b@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-sg2002-adc-v5-3-aacb381e869b@bootlin.com>
X-TMN: [RTaxg5BeMszIwm92en9TJOJKa7sl1mrSYjJhS2Nu4io=]
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <g23kyccfmoatb5m4z2bnn62rwj2qapgssrb3j3435loz7xxlrg@lployqd4rg4m>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: b401b7ce-85ec-4acb-ae90-08dcc9bb7f5a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|5072599009|6090799003|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	juEnqUSxrUAVFFi2zLtcTQkOFetjPrmWAWHmOOX2wROC5olc9iWq0YcW0uBv0p7pnCYYD7LW/q8wLCMDlXQAFxnnt53l0BLd2xpmIajyaSul73EPHEGWIJe94l6d59GZQZbCOVjKTUP6fIgA7z7OuRnfnrROk1AJeZxTu4g6geNGr9LXG9zTmyD8TVtUKirl1uNbtqpZR7sbuGp/ju9H9bfBHlfS0nUg5g64OEfuMCDCb8vwusgz+7mEfucQMMoLMeFYldHQzWDx5LfrlY+LlnihOlqMO6o0+/S+2fYkALGvSHKjdwfoD4JKxGCcKqnQP6DtBq3xR3NZd7z6u6kLrkLyunh3t1NL8EFIo8licydkiYdXq1qtMwBYbadprqXlPFv+xIJ3GzAj3Ml28Fmq/ivDtGG/DGQs0WBtayLCZplAoZa9GKUxu/ehzXpzLeUlgc9FYXMHh/gvcqFDtsNVWPCxE2D3HO4I847pd2mF8kXOXtkcrVBwUtSeLgVyyKe4asIDUVoXXbfGi6zP9ZNn1txTIi0zF9afCFStauFDKaXhWRzdDt3N3ABPyL4Xvk6Y7B25vl130KvJUwYSCDSKJAdiUAm33LO8WcOFuHpRTy0TeoFD50wNnRDzpZDRbx4ix2cG6FaYD8IOzoztna5IBz+Bfk5AnSdfNSJZrLy2jE4e2hplogliVCkjkXS34cr20Xyiqtt6LW76ArkpKvkFlhjJf1mxOyMTobshdd6f3Gsy/yuDZoE6pDcPCQM5DLGIGHC1eU6A3gEy2tJhB9QuTw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvOXUY6q8Od/qS7+93T1Q/xJw8zLycQCqI3YMC8nDmcV6dyEptqRBVBxlEpn?=
 =?us-ascii?Q?G8y/BJgplTmcXoKT5COKpsjZMC3Tlfv+4H3R7ojbL+BfHuoQe7KwseS0uJWE?=
 =?us-ascii?Q?Lqij0z6lG3FeGZc0r9yQ5F7wCd0iyxvXzM2L6nApx/Paqk+tkjkLHidpXnGD?=
 =?us-ascii?Q?SUc+itNfvWVxBsZhX19aMo3QEBjPYKz3YPz+ifvNGM3qgOg4VhQ4v105XV2j?=
 =?us-ascii?Q?yxYqDvKrM6jjrSYRWKuN5BBNuN5PQt/FaOYy0ZIfvxQeDJyIQ0rQ4v2+zbY7?=
 =?us-ascii?Q?2XYaLSEwBMqUaWd5W76xrkiil/qscc4jVyW1+sumA48he6gfAz/zhwXvVsSM?=
 =?us-ascii?Q?YyFvAHTcoLX+QUwoinmQckkvFdSysYeUzKU+e4zL5YqjJZzgbDYdF5QOnq7S?=
 =?us-ascii?Q?PkALt4KcFmW4QdS8rR6ir9bL0mbxteNbjMsb7DHjAQwzx7sdli9OKyXxUW4z?=
 =?us-ascii?Q?RepVSFpZIkwaUaJNlCy79L3d57d2qOzFANiNjsubD3WpJHX0lP72xT1/9JMS?=
 =?us-ascii?Q?ERa1qFH/xEUtfmL+37k+uZ2LFGJe339O88w4pIjWBkzAwNg2jN+6UzNUE7fx?=
 =?us-ascii?Q?/I1aVC07PIvWiwtNCSa9avNJUL+IhTEmT0FyYvf1frmVWPQ6ZFG6FrqLpdpD?=
 =?us-ascii?Q?Lg1fPnTz1nTxpnp5ZprbmqbxVzUWNvl24Sw18w/6EN643IAy/wfLmgOSFfmA?=
 =?us-ascii?Q?2oFcbJ9PKhnpZ7heN1ylZVP2wBGE8mDT3D+ef+Qh2xz/uZJayQGG7ucmUfmt?=
 =?us-ascii?Q?254+vxQzSxzOr7PssirAch27I9B7Q4Wsw0tgDnA/iWtbBvqH/HY606hY8S7O?=
 =?us-ascii?Q?Z1/hANCYGTfC7ho4hpKje5l6T2v93t6PwkHep11VtlUQnGo9YFgNsN4NR+FU?=
 =?us-ascii?Q?3jrDwQL71oeoj8c0kkxXDwGTfimQL/3pU4PA1mwO41pbU/wziEKwJlVa8XS8?=
 =?us-ascii?Q?tQDCOo97XzZnec3ZJ7/Frl40sSzyZfrPt7MU10bq5h+vM+GfLb1X3kGwZMfF?=
 =?us-ascii?Q?m4gSshaIF0+zbn/Z6MO4VBusuEw5S2NWBD/q+MPVoS/Fa8YshoTpwFrQwXzJ?=
 =?us-ascii?Q?eE/nRU0FDOgnATIpeRvB8DAE/vwQ7DY9d3rkgFse5y3cYZh87n2x6IeQAFiH?=
 =?us-ascii?Q?0uJ95PVf6JofMjYo32CDDqdYMsHp4sBG/dQmbtneu99uzxMqR7O4PlFOtmDE?=
 =?us-ascii?Q?sQT6CLCZiugMKgns3Ls+xYrTr2K799lbMdn7/JHUnmy2/L0j2FvoCwNNY1Mf?=
 =?us-ascii?Q?5kgL39oQiRRYWbl2UDjM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b401b7ce-85ec-4acb-ae90-08dcc9bb7f5a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 12:50:31.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB4870

On Thu, Aug 29, 2024 at 02:31:52PM GMT, Thomas Bonnefille wrote:
> Add SARADC node for the Successive Approximation Analog to
> Digital Converter used in Sophgo CV1800B SoC.
> This patch only adds the active domain controller.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 891932ae470f..da1ac59e976f 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -133,6 +133,28 @@ portd: gpio-controller@0 {
>  			};
>  		};
>  
> +		saradc: adc@30f0000 {
> +			compatible = "sophgo,cv1800b-saradc";
> +			reg = <0x030f0000 0x1000>;
> +			clocks = <&clk CLK_SARADC>;
> +			interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +

> +			channel@0 {
> +				reg = <0>;
> +			};
> +
> +			channel@1 {
> +				reg = <1>;
> +			};
> +
> +			channel@2 {
> +				reg = <2>;
> +			};

I think it may better to move channel definition to board file.

> +		};
> +
>  		i2c0: i2c@4000000 {
>  			compatible = "snps,designware-i2c";
>  			reg = <0x04000000 0x10000>;
> 
> -- 
> 2.46.0
> 

