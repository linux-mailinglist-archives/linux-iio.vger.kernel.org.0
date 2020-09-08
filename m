Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED1726078B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 02:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgIHA3C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 20:29:02 -0400
Received: from mail-dm6nam11olkn2069.outbound.protection.outlook.com ([40.92.19.69]:14112
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbgIHA3B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 20:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+NyPvosW0pqp7cqxU1WOZTO5rwJPWY4J8X8oYRvSBFHrQGhS1X3IpmvRYu+fGzRFUQf5V+FtIiMQb3EvgyGHkFyuhc+THbXjM3ThGk+///rXKjuFXzGwRVUFCko3P3Sslp4RJ/LATRR92R/YNKyYVlqZrUp3I1UK+rVGIARN2wLfVoBNDCt1n6NNsT3la8t0tsLgH5EZaOGBnUgmmyYnwuLruPRe4yX6swINQOTu86sA0jM0lEOBp5Pv1a0Y6VpdmoV+5CXJ2uBKY3NI/jPXsv6mQx91FtSxB8lpexRMSPLttgc3OqyDt5EYGYDdENkc338X3K1bbC26z2BYum+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3N1AuyMACUPavKKqXqF2WT6pRgKILXwHTpE9w6tznI=;
 b=RySDqYayan422FkmAV/qYMZDrSTLQkj95yy39cx8RaIdten5LE3TaDAwoH34/y59pN12+AERnzEbG5lUkYkDi7+LffZBZ6ZpITe4oN8OzO1yC1XL3tPNusC24RfwL7dWXK1bYURTRrS9rQ8TawD2ysbZne7qdEw6zBjvMXwpT7TUkD5VVUA0GPc1L43ZPt9+AsUelkmNbyDufKHPHqGXBViYsi/GBe0H0m3y21byhfSthyIVMjdz3XSqTfwhGcsM4zwk1FNCSvtk/KtraXXndYiAcAdtMHm+qY7UtWPGtZAs5+AM9HYHemVlPPU4GtT9wD+jJixxe+PXuHLK2Z3DXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::47) by
 DM6NAM11HT127.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::173)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Tue, 8 Sep
 2020 00:28:59 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::4a) by DM6NAM11FT064.mail.protection.outlook.com
 (2a01:111:e400:fc4d::234) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 8 Sep 2020 00:28:59 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:2A931EF18A50EB819341FE5AEF4E469EA8487410AC98E03086BCAAE1D373C31C;UpperCasedChecksum:5F2EC04B40DDA8D36DCB770B7E4E18200FC4EFE157354A8DE97D042357E79125;SizeAsReceived:9325;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::303b:a75b:d03e:bd04%3]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 00:28:59 +0000
Subject: Re: [RFT 25/25] ARM: dts: s5pv210: align DMA channels with dtschema
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-26-krzk@kernel.org>
 <25178674-e4af-ba35-b7f0-42091208e0e8@live.ca>
Message-ID: <BN6PR04MB06601A7FC9D1A697481EA37FCB290@BN6PR04MB0660.namprd04.prod.outlook.com>
Date:   Mon, 7 Sep 2020 17:28:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <25178674-e4af-ba35-b7f0-42091208e0e8@live.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <cd8f9450-2d74-35d6-f368-8a62469c4fff@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2001:569:fb68:9c00:8067:f823:1e15:7520] (2001:569:fb68:9c00:8067:f823:1e15:7520) by MW3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:303:2b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.9 via Frontend Transport; Tue, 8 Sep 2020 00:28:56 +0000
X-Microsoft-Original-Message-ID: <cd8f9450-2d74-35d6-f368-8a62469c4fff@live.ca>
X-TMN:  [8gb0dIQq4GXvh1ciJhPU4B9dDh9c+FhY8tCvGwlkx7uIdvDvEj5YZPH1QtDQhU/I]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: b48fd2c4-b8c9-422a-84be-08d8538e2d97
X-MS-TrafficTypeDiagnostic: DM6NAM11HT127:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8cSbXkDhgEGfvhC2RHYtzqVcTOmcQs3hKOkV/M2j21v6UL9UPAfNo6C3/G6jM6jkQnBQL9SGVaC1+L/CfN3H0976RHNrPChNjMT8K3zKgNpCoddOsK0yr7nr8ZJDfLoacOX2CPfJOw8mojG/vnsNmmblOAQVW5WEAhIipq9K67xo/presD2FkAj61aInAo8yQeAL+lqqcWkhZG/JMjRyQ==
X-MS-Exchange-AntiSpam-MessageData: 4ovq0SWyMfmLWjhKV2KAogH7o4Ox72SskzNSTK/qctrk0O0NOPqK6fxWF/Ntnl3DdgLb/xjyy8ZSyu2cKeEdHZFFbpppItRTo6Mezp1PTH1NexFHp4SDHw+7gVCBj4hlbe3uVJM0gcp2pz0khObS1Li5j8Tebh4vAEhHmbCbRXB/KbK3WVINJd9sY73HtDHNTEfKcD7JTyDU/Y9u1XHdfw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48fd2c4-b8c9-422a-84be-08d8538e2d97
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 00:28:59.1649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Ah, I figured out why the dma stopped working.  In s5pv210-aries.dtsi the dma's for i2s0
are overriden to use pdma0 instead of pdma1.  That also needs changing for this to
work properly.

Thanks,
Jonathan

On 2020-09-07 5:17 p.m., Jonathan Bakker wrote:
> Initial testing on both an i9000 and an SGH-T959P are showing that the audio has
> stopped working with this.  I'm not 100% convinced as I've had DMA issues in the
> past.  However trying to play something just results in a hang after 1.5s while
> it works just fine without this patch.
> 
> Thanks,
> Jonathan
> 
> On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
>> dtschema expects DMA channels in specific order (tx, rx and tx-sec).
>> The order actually should not matter because dma-names is used however
>> let's make it aligned with dtschema to suppress warnings like:
>>
>>   i2s@eee30000: dma-names: ['rx', 'tx', 'tx-sec'] is not valid under any of the given schemas
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
>> index 96e667ba1c3f..72fb9d9f7ba3 100644
>> --- a/arch/arm/boot/dts/s5pv210.dtsi
>> +++ b/arch/arm/boot/dts/s5pv210.dtsi
>> @@ -240,8 +240,8 @@
>>  			reg = <0xeee30000 0x1000>;
>>  			interrupt-parent = <&vic2>;
>>  			interrupts = <16>;
>> -			dma-names = "rx", "tx", "tx-sec";
>> -			dmas = <&pdma1 9>, <&pdma1 10>, <&pdma1 11>;
>> +			dma-names = "tx", "rx", "tx-sec";
>> +			dmas = <&pdma1 10>, <&pdma1 9>, <&pdma1 11>;
>>  			clock-names = "iis",
>>  				      "i2s_opclk0",
>>  				      "i2s_opclk1";
>> @@ -260,8 +260,8 @@
>>  			reg = <0xe2100000 0x1000>;
>>  			interrupt-parent = <&vic2>;
>>  			interrupts = <17>;
>> -			dma-names = "rx", "tx";
>> -			dmas = <&pdma1 12>, <&pdma1 13>;
>> +			dma-names = "tx", "rx";
>> +			dmas = <&pdma1 13>, <&pdma1 12>;
>>  			clock-names = "iis", "i2s_opclk0";
>>  			clocks = <&clocks CLK_I2S1>, <&clocks SCLK_AUDIO1>;
>>  			pinctrl-names = "default";
>> @@ -275,8 +275,8 @@
>>  			reg = <0xe2a00000 0x1000>;
>>  			interrupt-parent = <&vic2>;
>>  			interrupts = <18>;
>> -			dma-names = "rx", "tx";
>> -			dmas = <&pdma1 14>, <&pdma1 15>;
>> +			dma-names = "tx", "rx";
>> +			dmas = <&pdma1 15>, <&pdma1 14>;
>>  			clock-names = "iis", "i2s_opclk0";
>>  			clocks = <&clocks CLK_I2S2>, <&clocks SCLK_AUDIO2>;
>>  			pinctrl-names = "default";
>>
