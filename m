Return-Path: <linux-iio+bounces-7185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D50924C92
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 02:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B311B2293E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 00:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B9623;
	Wed,  3 Jul 2024 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GEAzyVWz"
X-Original-To: linux-iio@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2108.outbound.protection.outlook.com [40.92.103.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB238621;
	Wed,  3 Jul 2024 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965059; cv=fail; b=hrz3CpXq1BvPUq499/+aEY/0cMnMzjg89DHIZ9LiBqUSev5KSBv7k1ssO5ZU7EWiq1dOIoDVpEywQXht5SSj1/DbNAi/9RfIy5IDkPKlp8D7FfckSHzKdKZs4Vw/Ot5amBmdaFcWE3XXOCXrrAXaBkSBiJN/ll+tK4BWgA01JM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965059; c=relaxed/simple;
	bh=iE7hvV2yW2DM1Uqsea/W6GlBIxq6uendAINhi5EZzsY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=khbuR8innsBQoB+MOg8chNzFZ5Sc4Z8E+2AAk8QYOEnL5CtOYonE2A7FPiHdFqSWjvI9Wxk0E+US7ogu/W/NINiCohGe9QJxLmlUzjO6E+4bz2GthUBywvAh2S54cm568RlQNnsAXREgy8Y1rfPInRvlaxBRvLGCVBi3+MTafCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GEAzyVWz; arc=fail smtp.client-ip=40.92.103.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYtM/RAIm+3ww3QDyCZOndiCyTIHClumV4xDspR8r5ztjr9R4GQJuehdaZLnm9WkK9RC998SJ65HP9M05FIAw79sJoG3uikSMk6HPGek3ZID5b81p4p/7zchBajdeDpi2NFT6no+nm/Hy3Vj4uzi/rZ927piMjDmaZo5c+4ORvTToubit/nUSSsrwbHdRtD7yO+ua7YpHoAVQcuC99OuAop7aXwK7aOgCGHJ/v4z0DUUykoO9wBtbdP3+k6GJdJK6Z+Cpm2umLshMqRv+psdBPrSqm+gdn3iL9UgeuQ5+5TGo29S6+Auo6cPtqZrJ9sz8BGUIHSIIaLiUeG4tadd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/DbTocQ75WCUUKUpBfrv17VAn7B4PfqdRmWujIq+XE=;
 b=jy/6d6cqbnxX0Nue6BVFKnXQ3d6F5VLBWf86028d7Cf4lt2YK39mD+eD/ohs4BTZ4BZAezm49dpHSpP+SEqdrZ/ZrW0u1PCOcjEOqYiiU8ro5g9l7la9FOsySisQ11TOw4EyKfNotgPUx4oLzRMLKLpjxhF2QALP9WMLAUWu8LbDKYeIrESTtTjU97rx/Yy45geLOq7k3PGGpqeWf1Pd4NcDhWKBGmFxj7M3rqoD0KDTXIcw7mO8HOsSxcn6sZxCrFYkW1TVJfjFuZ832cMkUwn3GcVLBj35btLTwq8OWEXtFSzZDxaD4hrmMI0g/FrYNMxaiddceK9Psh+OFkY5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/DbTocQ75WCUUKUpBfrv17VAn7B4PfqdRmWujIq+XE=;
 b=GEAzyVWzozpqebop0ydZ/O++NNn9RxKpL3dggvxGfhw/BrxhuIoIH74N+dzW8jtN0/JSHxuNLDKyEgK+y6XoaQywcpgdt2WqQkW7BwVZMLYdbzT5+8Q/wpNILWV6/tuEORsYzto5pta2st3FA2/J13JyNmt4tXETCXRAlM0O4avwc7O2L4E5W/GNrPOf4IiXcc8ecRJ8pa9pGZmzTtX1kepT0SmshBnFs4dK6BQV+NTp3mO78m0/n5dLzFwlxqhzCe/y5Mc5Nz6J3ImMNj/Y9ug8cZSYOH/sZxmPJPeFy8Sk2NR+Q5FAJ1uiAIkx0n3aYjvheVn9Z+gX5+bOfBT5nw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1019.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Wed, 3 Jul
 2024 00:04:09 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 00:04:09 +0000
Message-ID:
 <MA0P287MB282237CAF989A9D9BBEED139FEDD2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 3 Jul 2024 08:04:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml: Add
 Sophgo SARADC binding documentation
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
References: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
 <20240702-sg2002-adc-v1-1-ac66e076a756@bootlin.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240702-sg2002-adc-v1-1-ac66e076a756@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [Q1riURWJwe7hMgFdG+J4BGz+0LDamAwp]
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <7c90678d-a3a8-4c24-93c8-b07cd54dc85e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1019:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1cca14-a5fa-4f7e-c84c-08dc9af3a8b0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|4302099013|440099028|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	8qsUi2CWx2n+Won1KyL5zPhRGrCK6RC/Jyp5s7k0sWcQ7Gts8Feh3GsJMZM7jLiE4H5NZMc+zeldgcglBLY/zvoNltEtr0UtZKmn3oad2Absk1bHAakWz6lSIaZvC2QYva2RvDcUBcHbuhuVx2H8dhlUvoE3Yq3Q2kZNwAa6pgvJhN6hva86rsvrZi8Jx2oIWkx29f8X8LqH1HhnmdM3wh/DzKEVZst6+Fj9d7E1007pHvCCZD1V7f0FSLyOohwoKcw7KPgEajpR25lRgbNaQiN+orUG4KMoikWumbTgLUfV+oM+KI9mZs9f4c1UH+Vrb3RbhflOgEMCgePNpc2MmlvTsoLAGz1+YSS20Zwx6KAI6uk96QCCVAr+ans60GMrjb1mk5JL3Nmzrz8dODXhXfJ1pRhkvImuPUry2CHsj3mW5SPGj7uB4EE3Ch5POyw2WW5xuvLuXNOZD6kshyOFJqxd22z6+ySoSjpuL8zVO5V3v6++Hbfnit8NbnQnnexdXcAgkV0ZWUXEaXe2EDIpxW7MhUg57CWOiumQixfo78h4g1jjymJ+NwM2fFbDoOyKCEf3ob5b3KnIXM7mzaxS+xhsaNFLSU+aRe0f+8WmeIpSZ4SvJalgOiEYuoZBvtgWH24hrU2Hkd2sP7UBSjFLQOhcpah4TEjC+7IJ0jqUNxABFxxvHWjF5iOGA39Uz6dOkUcNiaBhmYt9fa+Cb/VlKsUnUKRFtQZ85iSRFtOBU2o=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VERNR2xnbDZMYU1vY2Jrb1I3YTBrVzBkRkFoa2oza0xscEhYMEw5OFpMVFFS?=
 =?utf-8?B?WGVZK3QwRkI2bzJObEZFd0xHeUV5Zkc1eDYwc0FwVHl0VW43b1A4QjdXdjZu?=
 =?utf-8?B?RkRyWkhaUkZCcGtpckdxd0E4UjgzclBndGhCQmJKaGM5ZFY4ZzJ1ZzFydDBt?=
 =?utf-8?B?MDRpNFhFOEhpWUhFc0Y1VUlXWlJqQm1scHlFRjVHbEJoR2NQSzFsNTV3KzdH?=
 =?utf-8?B?UWx4OURITDU1OElYS2o3T0pYN1RqdDc4SWlPaGlselJMc0czbklITGk3dElp?=
 =?utf-8?B?U2hSNUNyZWo3SjlhS0ZrdmtGMXZqb0JGYUsvRDZSbjZuWDFoQ205d1A0WkxO?=
 =?utf-8?B?N3htYjhtU0xRY01NeHQ3UmpvWmNVRGh6akR3WjVKbktkdjY3MU9JUkVXVUph?=
 =?utf-8?B?VkRnR25Ea0MvQ3VOODBZU0Irek4wOVBtUmNsRHJoalJIaTZsZ0xaTkh0L05k?=
 =?utf-8?B?OTNvR1o3MUppRlR3MGdPbUpxekNuY1Z1TktQWHd5ai9SbGllcmlTTFg1cFgy?=
 =?utf-8?B?KzdIc1FFd09GQ0xhM3ZuU2V2NzBZWlJEZnVGRHgwZDQxSmlwTFZUOWNaWmc4?=
 =?utf-8?B?NzBJNHRNeEZPRHZhUitxb0cvRk55OWZqRE51VkRhVHhWL2pkTU9RbUcwc1h2?=
 =?utf-8?B?a1gzWXNtQ24rR05lYkxUaG5DdlZDWlNobEFIWnBKSkkyK29GSzlXd3lEZGhE?=
 =?utf-8?B?aFZpZTV2M0VGWHF4dWpIQ0dNZGtJanBjbUFuZmhXRld2MzAxQjR6MVFiTG94?=
 =?utf-8?B?a3hPVVppdHY1VEp2RHVaM0dxODBLRksxcXBuaUNwS1NTWXhVdXlyMmtGQ1cy?=
 =?utf-8?B?VWNTVkVDa091TkxzbVNrSjQ4bDBwQUc5T3lKSG9FUG1zUDRXdjhFeTZEbVhS?=
 =?utf-8?B?K3pIQTBERnpEUXpKaDVjQ0UvdWhPazRHbzAremdYZ2h6cUNTbDE4TUk2aUJz?=
 =?utf-8?B?VE1HK1d4SDFWTE5YeXdnWXFRYkF5WFh6VVp1TSt0UzM5eU8wNlpLMUhRU0wy?=
 =?utf-8?B?UWRtcmpsUVkyam1vbEhLcHN1UDBlc0ZDYnUvcG5UZjVaUFc4VFExbHRVTzhI?=
 =?utf-8?B?eVViYnRLOGNuME9tWS91U1VYRFZEbStRT2M1VCtUTENxQVpBai8xNlIxZTFU?=
 =?utf-8?B?d1N6bFJnd1R2K0t2bURjVDBhbFF4NmxqSHZZNnB6elBLZUdJdWI0NUZSQVVK?=
 =?utf-8?B?cGJNaFhCN2dQbXFJRXRZN0pyRXZ6ajREMlFnTVRQK1Bkek1hcTBqaW1PRnQw?=
 =?utf-8?B?MWsrSWRWMnZDQVlJM1RhREQvRjdXY2Z1dDhZZExSU0hHb1Y4aDVZang3RjNS?=
 =?utf-8?B?SE82QTlVZzhVTzBLanlTVy95NktIMkYxc1QyK1BqVjJEMUhuUWxRZWxlRWFs?=
 =?utf-8?B?Z3hSS05DMHM4UVV0TTdtN3RVT2ZHZkk4N0c0dUJyVlZZVS96d0RSZkE4S2VB?=
 =?utf-8?B?dTN5ank3Z3lubXZYU2luOGgyQ0hsOHlXdW1FZ3FKZkY5Q2RmWWNNOVRDSXBh?=
 =?utf-8?B?U1cwcVZBSUI3TkVCcTJLcWgza3poblIzcUZkVkRaYWd2dVlIcFhxNDJlbUpJ?=
 =?utf-8?B?c3Y0MWQvSHhpVG8wTUg0K2o5L1VqcDlKVWw0dlhnQlNHdVh2OHRjdi9YTHE3?=
 =?utf-8?B?anQxcnJ3RmNmSG81Ym5OZ2FPWCtsTGpHMWRla3pDWkk5V2ozM1E1RnJMdFpO?=
 =?utf-8?Q?ET0DL/vT79Y9bOx+3foY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1cca14-a5fa-4f7e-c84c-08dc9af3a8b0
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 00:04:09.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1019


On 2024/7/2 19:52, Thomas Bonnefille wrote:
> The Sophgo SARADC is a Successive Approximation ADC that can be found in
> the Sophgo SoC.
>
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>   .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 51 ++++++++++++++++++++++
>   MAINTAINERS                                        |  5 +++
>   2 files changed, 56 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> new file mode 100644
> index 000000000000..21fd5dc8e24e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo 3 channels Successive Approximation Analog to Digital Converters
> +
> +maintainers:
> +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> +
> +description:
> +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
> +
> +properties:
> +  compatible:
> +    const: sophgo,cv18xx-saradc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      SARADC will use the presence of this clock to determine if the controller
> +      needs to be explicitly clocked by it (Active domain) or if it is part of
> +      the No-Die Domain, along with the RTC, which does not require explicit
> +      clocking.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    # ADC in the Active domain
> +    adc@30f0000 {
> +      compatible = "sophgo,cv18xx-saradc";
> +      clocks = <&clk CLK_SARADC>;
> +      interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
> +      reg = <0x030F0000 0x1000>;
> +    };
> +  - |
> +    # ADC in the No-Die domain
> +    adc@502c000 {
> +      compatible = "sophgo,cv18xx-saradc";
> +      reg = <0x0502C000 0x1000>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aacccb376c28..dc87898c518c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20901,6 +20901,11 @@ S:	Maintained
>   N:	sophgo
>   K:	sophgo
>   
> +SOPHGO SARADC DEVICE DRIVER
> +M:	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> +
Drop this please, you have mentioned your maintainers info in the 
binding yaml.
>   SOUND
>   M:	Jaroslav Kysela <perex@perex.cz>
>   M:	Takashi Iwai <tiwai@suse.com>
>

