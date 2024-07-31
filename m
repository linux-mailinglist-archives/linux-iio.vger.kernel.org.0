Return-Path: <linux-iio+bounces-8117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D54943939
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 01:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C091E282CB3
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0116DC2E;
	Wed, 31 Jul 2024 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OSxGm6mq"
X-Original-To: linux-iio@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2042.outbound.protection.outlook.com [40.92.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667516D4DD;
	Wed, 31 Jul 2024 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467543; cv=fail; b=jYD+z1bzoTWgixte25KsLxiBe0KrGqUvGW6xfZpdJeTKtvKt80byEwWr/IhfDAOsfILlOPzIkEYSDyLn1k8jfYTMg0YHnQSIBElJZJL0xhaHVb/JMMJXDvFDq951D/TFCAc10RCEu7ifAVYYXu0hD6ptsqBCuxZM3B1Pc703uJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467543; c=relaxed/simple;
	bh=1poCI6FMiqj3gn86p/edHMjwp81bXFZw26bvGfHlsI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N2xfwbSAIH0MWniz2mS6HsBFuQc5v4F+kmmYOF4TXr9cTH18Dfi7pJUlz7eJS6SY6xGVu4MogobhKWU/ePIDDbV6ywjb+6QuoLuTpOjxuXLXz3Bu2syREIduoLCgxD3tVkcPGQhp4A1qW9eW8xUwMXXJwFW/VQ7DFDbvkpgYP5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OSxGm6mq; arc=fail smtp.client-ip=40.92.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y25ACk8Oj27DuVehAVGzKZUDYoHIHAaU8aQXlddpF6X/wrXzyh9qNAYr1ZZgD1+vSNybA1Qf+at1kYavF2LKJgqfGZhunYTp9gV7JZgT4P/V7Isy6jJtDDpVV9EiV5WhAUh25SqKdug4QOnFwIq/bi3GQqYDnmF3BkwjvJaTEE7cyPN4JwLLnEgPbgl60KxK1J3zjpnALAqVgKjl8f98y8HvTQy9A5nUwEybJkVCv8HOR+qt5RnHC1wVPs9REWR76wXCLHOQtIaErzPMuVat/iFYYj0/9v1nyWkxV1n6av8/MwLD6RqnXa9pWv+3dpIqRhAd/OphzK8GC+MfmRHw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdYVQhaoPgoP+0bhuY5+eaJbVv6IcV2MMddPQWlzO64=;
 b=Sf0J0XsTV7VEfcCw1fAYhqExjeU5oX1T5A7jH53Pr+OIDw/616ufovpdcWnTD6a3pH/IVGPI9DSlDKZ3xkJI4hiVjmB8PJhshdAiGxNklsxHqX1xix7Xt67f3ffSEh7sMlIkAXvijVhKZAbtNIxyPLnlv181XkIWUyFEYWy2EAgtfjn1+7V1rFLeuYqkTvA0kBzPGnrjFJh5Ui/n7WkUyTBeH9tgtG3pP/qz/mymOxrIRqlOFU1eELxlZlZek+ne/zTFcFwInWwEg7XX5YJb6TrAk5sPPGwCNtrUzRCHtCa+UMw900Iiwrdb/1JYba5Am2YVPTL77tHR3jeeEsgJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdYVQhaoPgoP+0bhuY5+eaJbVv6IcV2MMddPQWlzO64=;
 b=OSxGm6mq0Nf8JP72c54IcdPWflCPEF8ca6SCTfMezOYZusu3Td3KyZ4iB1tXdzhxL2LFliyJuCfYh4NXDKxRcI9O4efW6MhQBTgf083Ce2FhVuQ4v/W9tunDdYAzdqqdcfrRqHrlQ723pmLveWqDKqL/vpTJ0hq2qhXLb1mcpn51mW9SqZTxyBKSV8ftc0Jk1IFXWkEJ1PqEQveU4eXY3zV04L4nEpksJk2SRh8USwMBymjaGHYZZM3Lar1El8NOuCqbwmzUZNEkygBwSqzWMoPEKkwWyNtrxfKSqcgKvEea3Oc+zOIfwynZgHlG7ds3fU340NCkIbPQ+vAO9jwobQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB0829.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 23:12:14 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 23:12:14 +0000
Message-ID:
 <MA0P287MB2822D15E938706B620BF86B2FEB12@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 1 Aug 2024 07:12:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add SARADC support on Sophgo SoC
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [F+1BeWT52dJPx8Qi7YoR9gCjEAz4G0Vm]
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <f39499e0-9f53-4757-82b3-12af183ea9f1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB0829:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcfbfd5-6aaa-49ed-ea8b-08dcb1b636b5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|461199028|1602099012|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	ZhgO+Iaf6KSeejlJjwxi8SEd04Ex7O5IaLhIobKaR22NcQW7W4xZ4oHHd7C/ZvtqgQV8NBLwOqrmh4XX0a9acazgV1zNazyI8GDOuvw7o7JHK2yjPNzI8by2enWhJzqntmWaBVnfArG1GfdulV+b+w+MS2FAcgdMOwIGWcKdpNWKzJF+IEFBxAW06nrmiwiskS5NAtM927pAyiRQ2K3fy51EYtuIR0VvPZWhfOgcEwpN1JPcsrDFbivubmg5/b7lFS7D5n/vgPQ4Z47uHpQUtAUGQjtJMeET3yZClGrvZgLEa/C3MUWMuwELgG1nOrZuVVq0xLAMjCnxMTkxudbcLQF9mSwH7Wcx4gwJpHsCQfNZ9rndsEXr2lYBcNFlYxxC6IYCE/uLnDfseLl30HwbZMVmGg9LQV1L/aJAytuC0SNAqhp8E2q7lXWWQc9C7cV+VfzTjj18WwPgk6X5s6YPrseFfy9XwDd4WEXJEv60XTXq0Ht9+3eTtgqdUd3fHh24dO5do0YhXYkcU3Fk0da6g0ERdLvhPX8eaPo1v1YS9JeoyKTKpsl/eX8qGsLRbrbPF7aJNu47oGO4dPcEX0wZJRGerSW8Gi+IOa7hyPjJjwIeh47CtiQO6/gBLrkliCKz8WyIg1ydyFaHz4FEnBHDpGS9rsn+lW7jeHTvPE1gx/4pYRpD/0882mNAEWG+KZuQxr3K1PAAK9hNPMM78URO8Q+emlYjrj0tgu563bm99Oy1hRejj5VSP1GTplPVVkjIAODDZRA6fne4aUQe1lfEpkzkpQl3JNrGPKNe9cYCF3o=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXBBTGdkLzk4a2Y0amo4eVNsU0FqVjlCbWFSNTlLb3JXWlVENjdsOE16UFJQ?=
 =?utf-8?B?cXhRM2xtTnRhSWxjTDZRTlhoaVBFd3F0amhZK3FpcXdCeVNkenFUUXB6alh1?=
 =?utf-8?B?cDgwMEZ6OXo1V2pZWEtxS2lzSXBJZ210VkdyOUZMVjVMaTlGZHpMT0xFaWcv?=
 =?utf-8?B?MkdUWmhJVHMyUG85OG0waWR2WUVscW5ZVzhiNmZiWStCTHFuL3VwZzQ4UEZ5?=
 =?utf-8?B?S1U1MWZDc1BuKzR6R1lDZ2J3WEFvWkxQVG5CRXczUitZZGtxQXF5enUwc09p?=
 =?utf-8?B?YzdIZnFCR2hzSjJ1RFZ5V2MwMHdWM2E1SjhNVlJ6TXJqaklrT0hZdFZRWUtQ?=
 =?utf-8?B?ZVZsRUZnamlhajl0b0lJdWlHallFWjlLMEpmc2N5L2paZmJ0dGhTUW5yaEc0?=
 =?utf-8?B?YTUyNU5JWmdNUGFJT2lTRWZBYml1cStxYVF3anRLTjRheGR3ZkxHMG5kVGJh?=
 =?utf-8?B?K0hnc2h6bHRzOFZzcmh3dnNwbTRoQzA5VXU0U1R0ZHExMW9kNC9JWUlCck5G?=
 =?utf-8?B?V2VMOFJWTlo4UHNCTXpvOWt1eXQvM1JneUJTU3dMMmlvYWkwRXZ0WEZ6SGpu?=
 =?utf-8?B?enJyVGpVaHNXc0NQOVdNQ2hoSllQSE0xNFBiQjFmZGZ6anArODVRZG95NUF2?=
 =?utf-8?B?dUxnTDhXa1g4UzhDdWx3aGFocGFRd0g1NWRkUGN0ZVVJQzdLTEh0MEVpRTZt?=
 =?utf-8?B?Rk83KzVaeHJXZTUxMmVzV01MTVZzRDdseWk0Y3RRZmk4bEx6Rlk4cFFPUlJN?=
 =?utf-8?B?UE9xYlB6aWZML0JHUGhVdEtqRUJwOVlVbXJmM09wU0pGeEpKNEZTVmhPRVg5?=
 =?utf-8?B?b3lBQi9wVVVtUklqVmxPdlllN2JZYjdkd1FjSFRBVTJXZFdSREpubGxDTEM2?=
 =?utf-8?B?Q1JPVktlMGxkd05DWlhWMVY3REZNVVF6QlFEbWUyWVBYb0NZcE5qYVVvQTRP?=
 =?utf-8?B?b01idkhXd2tPYnJqMVBrQlhMVVVUZStlcnc4SjlLQnBhL1Y4YmoxemhJcmFq?=
 =?utf-8?B?MUNhdityQTdlUzA5Zk1Fa25vc0VHZitPMmxPTUwyc2lpVnFMTmZ5Z0FjS2N4?=
 =?utf-8?B?dFIxTStLdXhabnl4OTVQRmVNR2hHR1FqN080b1QweWRSNTZoVms0c1ZKZG5J?=
 =?utf-8?B?dDRZZTZwSnlkWE03VUdwV25aNUl5ayswWllZYzJoUnJESm1KNG5leE1FSkhS?=
 =?utf-8?B?RXBNdnVJR25UZk9lM05QVFFvcVI3MWZodzdEd1Z0NVVlcE9ncGFvR3ZwVWJR?=
 =?utf-8?B?aytxKytrL2Qyc1dDMk0rdjVYU0lyUHJoeEdacWRVMGlneUtkb3lRRWJDVXFt?=
 =?utf-8?B?ZmlLSFp5ck9pVlI4L2FxVjZ4UnNNUWJOYjhYVWdCYVhNQlg3VDVwNWNTcVFj?=
 =?utf-8?B?Qll3U3RJTW83Y2ZvU2QyWm41bkplVkcwWjBlbGo1UUhaRGhIRW8yVnFxUkxS?=
 =?utf-8?B?NWk4azY4R1VRdmFSSWhRT3ZYN1RleC9WNmRtczQ5VEcrY1k2VkxCc3piVWls?=
 =?utf-8?B?eW92QzZvY0JlNVZTa3BYMU4rcHdDMnRQVlc5OEtkaVJnYy9hVk9DZVdvaWll?=
 =?utf-8?B?YUlJOEVsNFh0RmNuMXNUL2xEdFI4RFZaMmlnLzBjcU91Yzh1elU1anFNR1ox?=
 =?utf-8?B?Ui8zcklKQnl0VEtxWWp2VDBnMTZ3VWdJUVgzN0QvdnFReTlrb2JDeVQySUFD?=
 =?utf-8?Q?Ez3z365Au9j8G8iVn6J0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcfbfd5-6aaa-49ed-ea8b-08dcb1b636b5
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 23:12:14.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0829

Please add the code name of the specific chip product to the 
patch/commit/email title for easy distinguish.

Sophgo has several product series, not just cv18xx, for example, sg2042 
etc, and there may be others in the future.

You can refer to this example [1]

[1]: 
https://lore.kernel.org/linux-riscv/IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com/

Thanks,

Chen

On 2024/7/31 20:24, Thomas Bonnefille wrote:
> This patchset adds initial ADC support for Sophgo SoC. This driver can
> work with or without interrupt and in "Active" and "No-Die" domains
> depending on if a clock is provided.
>
> Link: https://github.com/sophgo/sophgo-doc/releases/download/sg2002-trm-v1.0/sg2002_trm_en.pdf
>
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
> Changes in v3:
> - Subdivide default cycle configuration into multiple elementary
>    configurations
> - Fix formatting in the driver
> - Use devm_mutex_init
> - Use devm_clk_get_enabled now because the clock is no more optional
> - Remove handling of Saradc in No-Die Domain as RTC isn't implemented yet
> - Use cv1800-saradc as default compatible instead of a wildcard
> - Link to v2: https://lore.kernel.org/r/20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com
>
> Changes in v2:
> - Drop modifications in MAINTAINERS file
> - Rename the ADC from "sophgo-adc" to "sophgo-cv18xx-adc" to avoid
>    conflict with ADCs available in future Sophgo SoCs.
> - Reorder nodes in DT to match DTS coding style
> - Switch from including <linux/of.h> to <linux/mod_devicetable.h>
> - Use scoped_guard instead of mutex_lock/unlock
> - Check IRQ Status in the handler
> - Change IIO device name
> - Use devm_clk_get_optional_enabled instead of a clock variable
> - Init completion before the IRQ request
> - Removed unnecessary iio_info structure in the private data of the
>    driver
> - Use SoC specific compatible in the bindings and device trees
> - Link to v1: https://lore.kernel.org/r/20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com
>
> ---
> Thomas Bonnefille (3):
>        dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml: Add Sophgo SARADC binding documentation
>        iio: adc: sophgo-saradc: Add driver for Sophgo SARADC
>        riscv: dts: sophgo: Add SARADC description
>
>   .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     |  48 +++++
>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi             |   8 +
>   drivers/iio/adc/Kconfig                            |  10 +
>   drivers/iio/adc/Makefile                           |   1 +
>   drivers/iio/adc/sophgo-cv18xx-adc.c                | 206 +++++++++++++++++++++
>   5 files changed, 273 insertions(+)
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240527-sg2002-adc-924b862cd3f2
>
> Best regards,

