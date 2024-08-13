Return-Path: <linux-iio+bounces-8456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE195109D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 01:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9910C28490D
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3010B1AC439;
	Tue, 13 Aug 2024 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="V8Ud9w06"
X-Original-To: linux-iio@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2096.outbound.protection.outlook.com [40.92.102.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650D198E78;
	Tue, 13 Aug 2024 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591964; cv=fail; b=Cp6Mjc3+2mHv5dW+8UgJu3lakRrL2oZhsOnCUsVAeWSFnx4XlLTBPu8BQzAvyWQwaKEFD9yTGbgbOP0Ss04lHqkbcYDrAMtbJJSVzeU3hHArjIWXXOUkIhdqP7GosegCLi8IbS77v+t65gj040La1xj4FhwX++bNfUnFxMl4d2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591964; c=relaxed/simple;
	bh=Zug6C+ggIYEM9KBcmXAq167VyM+UcehzLOTlPb+uFFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r4pPiApEc6pGsggCX0ylgyF0HI/gTaNFQV1UZNBSg4idQWl7N5hlRc7IAUCICplWJ0a/vWO4W63t7gqiWPI/wh5Lq5OXX79yMjKIMgTaAbrrGAnTaYtXMRWDT9OnVYGMJTYKx10eckDUIq4Sz4NgQDeCT46UL2KXOKKAuYx+8as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=V8Ud9w06; arc=fail smtp.client-ip=40.92.102.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcgeXwF/Sa5QcEYxP+sztZvk1EBscfqgClYEk1ySV0+Iiq4sxEfFyqhIy+QOf84s9JeGtC7abmGSJKEh9VLvEboHmP6DpYbkDjMzjYzKYg33JYdW0Q8N7Vi4rQEpa5dNnhK7o6oRClfoja8jkuoc9UjcPUAPIPJxXoKhgKRWEf+DWTXji5BCFGR5+ky9HobxGlSe4KiWcwJHYlDdJ88WGG8cwH+jQcdFp6LMWRTla70JUKPu237hBFciHW58WU3ezuMQSgWS4JWmr2f6sG2ZbTK8nwek6rAwA31jij55ScdoorRh28GWEfk7nv/mZIz4NzLt4hHgz5nVoSg9RelZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49xJd+JcuO6VjDl018rGQoKKtrVRClgvILiQLHxRLj0=;
 b=Y+JXsCoR1KoIW7cTqfw1PMYKPnoAQAdLbM4kwJrXPxjCExgvZwP4qJAz5JiF1HxbjOgPX6IoDgqUlfbok4scZkzfLNXWgYyNtcRrip8SQ/4U4mpeX6weyt5KId1C4BcrCkhOVNCroQEWy6u6ZMvDvx1qUTRcmKmYLDkwZvoTNi58UyX47WbiD/zUvD53KJBBkYsk4aPoovwmhMjRWivuvY7IU1cWZc2A766NLZNZGNm/pF7PqwCq483cPUo+CImjZApHot93LIYFbN+ZeqsZjRX1eH3Ko84WTsLTAKg3fA+vmwbzt8uGJ6MlrzKIrIElMPBweTnV3N9UTTVAcLjzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49xJd+JcuO6VjDl018rGQoKKtrVRClgvILiQLHxRLj0=;
 b=V8Ud9w06ZAwDCJlhXmxYb0Qb7hkD8Rg97afZnJzOAw1EKXG4askcFnRmdiSyekGPr9Qq9ejol6Xn3+uH31V8Gya5Npn+U79w9TR7XQTPtFyuKykQ1bqn7MfKwyArDC/ozJpTTeUhY4Tkn07UvosrHxz7ZErfpLUtBkwKBoI6xCdg+VNdlrw/rHuDoV+/ON/wRYbffIV1cjp+2sJVvafXoPVtcAPOs9UCdmVyHXNcm0y66HD6a15h0OpAP92s41wC2ugUzAPa4Sa75uan5qPrZfGxfjCy6HNxDP0RQhiOZasrRI73NuXBTAXM1RXe+fdQ/tZUDR61pOxLoJ+kxqHEmg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0773.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 23:32:32 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 23:32:32 +0000
Message-ID:
 <MA0P287MB28229B43DEFC2996023F8CDCFE862@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 14 Aug 2024 07:32:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] riscv: dts: sophgo: Add SARADC description for
 Sophgo CV18XX
To: Inochi Amaoto <inochiama@outlook.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
 <20240812-sg2002-adc-v4-3-599bdb67592f@bootlin.com>
 <MA0P287MB282209542C6D70839466B733FE862@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB4953ACCECC151ABCC7E0E49ABB862@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953ACCECC151ABCC7E0E49ABB862@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [+sKd1eS/CXvUiENxYOzMdg5ZDf9qcLVQ]
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0bb3699a-3f75-4976-9b2a-2ff6e5691855@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0773:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b9a0fe-b820-4704-e33a-08dcbbf032ff
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799003|5072599009|19110799003|461199028|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	+ppqFkdJI4TxIx1bCvJNQH8KzL0101A4dGdyIe9mqqcaeYxVsGOuULC3XRez+a/i4r1W1Hb/oFALIGOfNiixJij1W0OQV2ImjqDqBM5adforlVWUcUxTqT3wwx1cIrAOFTcy7q3UHrlANuNaBQ7DWtR/OioFf2Sjnn0svCth0m3ZIHKn/S/BD3JpZUXCzs2GBsEGSKav3LeWnFr9PLio5cAqwZc+mKWfALD+Y6NAsW/5rHoee1V74yx1kYV1nwOriDqQEXLPBT0j/lkNI/NhYAY+XwEcfJbl+IVZQrMOxEDuSXJn7K43XH3MGXeWsIxOmIT9Ci2ErhOKSVWmfgjW/RC854iCGcnUyWO631gTcJSA8tyW2BpAQwN3D4N8oYdb6ew5EL2VmeYSz2yf8+IjUBMMRQiZe8OLVkwAayWUJeW2mu2Erz9kX29ioRLFYBS2mAUZnBgtYVpLuESLmInVw1/LjRfXBP6EmA2iPGx5BF6TDoeyOifvqnIIh+qhG7bJLYUZNZQLkhIYvapSlZgfY7/1lOEZrlQdvxy+huZbg87RWvHsovtouxN/z4/02qgxKVvr4hXESmylyLfCOKxLKmSoeyyOjSfsgndhuU9l4tRZ1H2fB598utQlKfHSqnV0GhgEh2L1/6ZE+ssKySGGu1bZ1X/9t/PZFFmMv7KnZKEkQ1klN91Xn6MMZddPDN568bqeRTk7IYLdmE/3qsnpkA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkJQeU1LbXU2Wkowb3paNDk3dzNhTmhaZndYSEpZMDBOQTB2cmZMRmxVbmRr?=
 =?utf-8?B?RUs2cm50aVRXaW81SzFQREhpY2cyTUI4bXBLYUJRRG9NNDJ2Y1ZvTkpvYmYx?=
 =?utf-8?B?SmRxeUhPeWdqM2RjYXY0em50ZU5XV3ZFNllhb1prR0s1UlQwcGxDcGJ5WWxl?=
 =?utf-8?B?MW5ycE9SUG0ybjRkOWdSeVIwZXZ6cVVURFRZY0lqUFR5SXJSbmdGN0pZM1kw?=
 =?utf-8?B?ZU9MbGtTcEp3WFhGNGgySmdxamhnQ0dmWlhsZUZjcUJKTkUveXNhUmhHMTIw?=
 =?utf-8?B?SlB0Z3d2dGEyN2pycjRJN0NSTWlrMmh5N3RGOW9oK2dnbWwrMFFMNXhVMnQv?=
 =?utf-8?B?Ny91dUhKRmd1RXZieHdLVXM3UmEwUWZQenMzclgxOW5qVzQ2RE13SnFNUjNN?=
 =?utf-8?B?UStiSVBxZEhSdllzeWRMTWhSSUFlT0JRcDM1NUZ6anFJYUVkU2p1ZXlPYnBs?=
 =?utf-8?B?Mm42MGliUW84U0VpT1Y3WUpNZWFsRndnY2R3WXVkOHUrTWtpVUZRUlBIekJB?=
 =?utf-8?B?bjNJZEx2dWROWWt6T1Zqd08vMEZMOVhtYXEwUjVjckZkMmVibGJyUXIyczlz?=
 =?utf-8?B?SkxjUkVHYmpVTkhPLzZmREplS29WQXhKWlZHNTZzazNQRGtpTUNEMnpXTHN0?=
 =?utf-8?B?Mm5rS2dvWk1sVHg4ckg3bGFld1BzMzVjYmxvc291a0FmZDI0S1dzVnBzV01K?=
 =?utf-8?B?K1JwQVZJK2swcDc2YlhwYzArQzF2ZjVEek56Q1FmOEJlSEtqMXk1Y1RXUksz?=
 =?utf-8?B?dGxiRE9rd05rYUhXWFBoNjdCbFRObVhGd0F0RUMvNzlpSjkxRjAxWmVwcFg2?=
 =?utf-8?B?R1drbXNsdWZ1cE1OTkxDa25PREN3VHZYekcvcGlVZ3hwbWhSQXdkY0x3Zk9v?=
 =?utf-8?B?UlVXT1VxN3Njb25VYklVemhMejJURGJhckFqd0hvZUJ6d0I3bktXcm9BYjVW?=
 =?utf-8?B?aUtLTjBLWUJEMkZYYkZWSGNxQXZYZ0Fyb0p1dEI2dk9BRVdwcGZqZ2xiVUli?=
 =?utf-8?B?ZllvTHQ4eXMzWHJ1Vng5OTBnY3BGaVJFZHJsbzNrcnlyUmUza1BVUGdKRFUx?=
 =?utf-8?B?R0Vuc0t3R3FIOU54eWMvUUtteXZnUFhWTkxYZCtyam0zeERvZHdFQTJJMW9M?=
 =?utf-8?B?c045eUlLclBVenk0NjJnUGJjSjQ5RmpycGdXdHU1Q3ZoRkFZTFY5Wkc5T3Ny?=
 =?utf-8?B?MXhEUjd2ZjlVdksvNWxSN2NGbW1FcjVPOTFXUUxTSUFrbEphazhnQm1LNExT?=
 =?utf-8?B?bDhnV0pKcDkzMmFHcmhjOGVjZWcxM0V0SVM1cTVNV2tqcGVFeEg3eHdzZHk2?=
 =?utf-8?B?UjVKSHJlSjlFaFZUVGRUT09tb0YwOGhneFpCOHFpZEpFa0kzdTRLc2FFNTRu?=
 =?utf-8?B?VFRyL0ttbWhuYUhvWTZzUHNwL1BpZEIwa2ZFZzJYRG5LSlMzVW94OTNwS1B3?=
 =?utf-8?B?WmxIR0ZkUHFKQ003VE1PdjhtQ3hpODlBaU8wdTlnR2dOalRackUxOVVyN3l3?=
 =?utf-8?B?YXVsa1JYMFlnMWhGdHh4TnZUMy9BekkwMVJ6U2xheEpmQXJKVTByK3BnZlJN?=
 =?utf-8?B?YXBJL1ZkWXhWaml2RXp3dU42YmlPTzBnTE5LK0JiRENKaE1NQi8wRGpOUEov?=
 =?utf-8?B?dDd0SGRmV09Td3JxUWJCbHdLc2IwYmxCdHNlTWhTQXBnc2Vqb0dVZDYzWnlE?=
 =?utf-8?Q?vtUYY4UNufK/KdS/BYHJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b9a0fe-b820-4704-e33a-08dcbbf032ff
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 23:32:32.1535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0773


On 2024/8/13 9:50, Inochi Amaoto wrote:
> On Tue, Aug 13, 2024 at 09:45:53AM GMT, Chen Wang wrote:
>> On 2024/8/12 23:00, Thomas Bonnefille wrote:
>>> Adds SARADC nodes for the common Successive Approximation Analog to
>>> Digital Converter used in Sophgo CV18xx series SoC.
>>> This patch adds two nodes for the two controllers the board, one in
>>> the Active domain and the other in the No-Die domain.
>> Where is the node for the No-die domain?
> I have suggested Thomas not add the node for the RTC domain.
> It is not clear that which clock is used for the RTC domain,
> it will good to add this node after the RTC is implemented.
OK，so please update the commit message and mention this.
>
>>> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>>> ---
>>>    arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 20 ++++++++++++++++++++
>>>    1 file changed, 20 insertions(+)
>>>
>>> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>>> index 891932ae470f..71a2618852fa 100644
>>> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>>> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>>> @@ -133,6 +133,26 @@ portd: gpio-controller@0 {
>>>    			};
>>>    		};
>>> +		saradc: adc@30f0000 {
>>> +			compatible = "sophgo,cv1800b-saradc";
>>> +			reg = <0x030f0000 0x1000>;
>>> +			clocks = <&clk CLK_SARADC>;
>>> +			interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			status = "disabled";
>>> +
>>> +			channel@0 {
>>> +				reg = <0>;
>>> +			};
>>> +			channel@1 {
>>> +				reg = <1>;
>>> +			};
>>> +			channel@2 {
>>> +				reg = <2>;
>>> +			};
>>> +		};
>>> +
>>>    		i2c0: i2c@4000000 {
>>>    			compatible = "snps,designware-i2c";
>>>    			reg = <0x04000000 0x10000>;
>>>

