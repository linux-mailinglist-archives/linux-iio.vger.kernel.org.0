Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF215861D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 00:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgBJXUD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 18:20:03 -0500
Received: from mail-oln040092005029.outbound.protection.outlook.com ([40.92.5.29]:41125
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727422AbgBJXUD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Feb 2020 18:20:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVHTvCIVPC0tc8KXvk7CSpEFcXT9mZP3KMPehaD2xUbF2CU+JQxcTNBEUyIkoIOC+xAX+1jQvp7i2LpUOScBOJH4qWi5f0ElJ2oh5dItOhmrdPEopWKAZWoSn2IBzfLSS95GVYHeMdlpJN2COVJK4R1P8NL2uZVJwpucw9EX25jYPNu4LwLkYHz+iyeL9ukQ4IUq5Azi4A51oiqjsJEEuVvtPgl8eVlmQsYWxRs8iITu73FZg0wUz3QoGjsC23oqWue39ttS47Vyqmn2QxdR9BLEfNEl6Ir2ClvMuu912ry9lQWBbe6JTjEEWhP7crEATUwj9e6tlg0sWZ9k+HlaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy2cphUvIDM0nwmBw4Fd2L56B0G/xLD1NLMrYwqZVqw=;
 b=Ubqml/uQlHxs9d3+IFyYcnXJuDm8etXpikiuymPdPSaeAhr7mtz2tkd3C2RRRZH+fZUETUSRC4bNtlcJYeZ0n2q/A/xXx5CzFQ8LJc4jx2yjrPYiC0bV+PNpiLY5t4j0BkuhOAzLgOhkq1iFvtlBXqtuwid9IelPtJ3sIEqQxDahvLWmi498ZsqH/2M+x8JYlMv4oqbAXT6r+cpT8KJNqF4ugOUyiL+VyibZrrqw+dGRlUKMtM27YLEqKL2LNBnQbMpnlao7qthZa8Xz5bRN2MGuDcwBS57GofmMS1LkjUGjs7cAHwAtG8sWZYMPsQtv3rj/pox2Z0/lNJ9Hfpve4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (10.152.74.54) by CY1NAM02HT034.eop-nam02.prod.protection.outlook.com
 (10.152.74.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Mon, 10 Feb
 2020 23:20:00 +0000
Received: from BYAPR10MB3479.namprd10.prod.outlook.com (10.152.74.60) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 23:20:00 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:9A7A3E6CD93C0012FA84CF5B9ADBC3AFECB588A3FAD51516FFD7EBB3083DFB58;UpperCasedChecksum:8B17EDBD233844C44B0366EB8030BB3818BF340ABC2B89EC3A1B0A64BE32870F;SizeAsReceived:9295;Count:49
Received: from BYAPR10MB3479.namprd10.prod.outlook.com
 ([fe80::609c:d845:cbb0:ce16]) by BYAPR10MB3479.namprd10.prod.outlook.com
 ([fe80::609c:d845:cbb0:ce16%7]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 23:19:59 +0000
Subject: Re: [PATCH] RFT: iio: gp2ap002: Replace LUT with math
To:     Gregor Riepl <onitake@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Input <linux-input@vger.kernel.org>
References: <20200208123359.396-1-linus.walleij@linaro.org>
 <74ab4b7b-eae2-0c6f-bb4a-eabbd3b4d042@gmail.com>
 <CACRpkdau3ei4OXcpucctxKqb7baHsMf8a0Q6sQ4P=gOf=bxQ5A@mail.gmail.com>
 <395b3e38-cea4-9376-1544-f1ef85abf171@gmail.com>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BYAPR10MB34797AABF2536F03BC3B4065A3190@BYAPR10MB3479.namprd10.prod.outlook.com>
Date:   Mon, 10 Feb 2020 15:19:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <395b3e38-cea4-9376-1544-f1ef85abf171@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:300:16::26) To BYAPR10MB3479.namprd10.prod.outlook.com
 (2603:10b6:a03:11a::16)
X-Microsoft-Original-Message-ID: <3132a8d5-f2b6-07aa-26cb-77a41893a84c@live.ca>
MIME-Version: 1.0
Received: from [IPv6:2001:569:fb67:7300:9f89:4b96:de0b:cd14] (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by MWHPR13CA0016.namprd13.prod.outlook.com (2603:10b6:300:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.14 via Frontend Transport; Mon, 10 Feb 2020 23:19:59 +0000
X-Microsoft-Original-Message-ID: <3132a8d5-f2b6-07aa-26cb-77a41893a84c@live.ca>
X-TMN:  [3I8V3vXHrZjyYMG37qEE5KI5rg8VRtpwHCW1lj+ElTvBxh2d4Uy7q0MeZYLGraoT]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 6b4e40c7-37de-4634-6dfb-08d7ae7fbfa8
X-MS-TrafficTypeDiagnostic: CY1NAM02HT034:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emp8yhV0zXnOFfFABSoTg1I7iu8zxI0aCRotomJNvz6mVf2ztbfqq9YvlNUdxkg44ct3i2ZhMTSFnYLAzmyDuTv2Pj1px7Ly9zLZQhY6ue6KfFZ0fJW/EzV94l0yS1vUw9Jqw5Jldjyya2zmy6WJibZhp0pgqeLC14E4VQHSeDXWCsvMyy7GAFFfGdd1OTOIOJOCCu0Dcy1WTMF3zMnXmyhqG2u9thft6qWqDsVf1Dk=
X-MS-Exchange-AntiSpam-MessageData: 450hozFQPRe99v0ff5ccW9ZyU9UonF48SybBSPCzbNxKHICLTr1R07U9liG0Rvfa1I/VwQKll2vsSrRIARdyv1wDsYFqoXIt2m8jFx1XZj7rv/Y2XC4QNsJqp7Y/ZJ0pVI3TzQJDzpggw5AioyUg4ee3cdXA9qNyMS/+PZDvvKFYOMExY8U9PApS9czhxl+IA/zLSF/yTOInowqCFw9TTg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4e40c7-37de-4634-6dfb-08d7ae7fbfa8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 23:19:59.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1NAM02HT034
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Just an FYI - the ADC_MIN should probably be 0 for full darkness,
but I understand the concept and like it :)

I believe the light sensor part to be a Sharp GA1A light detector or similar,
based on the fact that DigiKey had a page (1) that
mentions both together and that the specs for the GA1A1S202WP (2) line up quite well with
those of the GP2AP002.  Note that the datasheet for the GA1A1S202WP even mentions the
illuminance = 10 ^ (current / 10) formula, re-arranged as
current = 10 * log(illuminance), although it specifies uA as opposed to mA which is the same
as the Android libsensors (both the Nexus S (crespo) (3) and Galaxy Nexus (tuna) (4)) versions.
I suspect that this should be adjusted after the call to iio_read_channel_processed().

1. https://web.archive.org/web/20130303022051/http://www.digikey.com/catalog/en/partgroup/ga1a-and-gp2a/26402
2. https://web.archive.org/web/20121221163708/http://www.sharpsma.com/download/GA1A1S202WP-Specpdf
3. https://android.googlesource.com/device/samsung/crespo/+/refs/heads/jb-release/libsensors/LightSensor.cpp
4. https://android.googlesource.com/device/samsung/tuna/+/refs/tags/android-4.3_r3/libsensors/LightSensor.cpp

Thanks,
Jonathan

On 2020-02-10 11:33 a.m., Gregor Riepl wrote:
>>> Also: It looks like int_pow doesn't saturate, so even though it uses 64bit
>>> integer math, it might be better to move the range check before the calculation.
>>
>> How do you mean I should be doing that without actually
>> doing the power calculation? (Maybe a dumb question but
>> math was never my best subject.)
> 
> Well, if you clamp the input value to a valid range, there is no risk of
> under- or overflow:
> 
> #define GP2AP002_ADC_MIN 5
> #define GP2AP002_ADC_MAX 47
> /* ensure lux stays in a valid range
>    lux > 10^(5/10)
>    lux < 10^(47/10)
>  */
> clamp(res, GP2AP002_ADC_MIN, GP2AP002_ADC_MAX);
> lux = int_pow(10, (res/10));
> 
> However, there is another problem with this solution:
> If you divide the input value by 10 before raising it to the power of 10, you
> lose a lot of precision. Keep in mind that you're doing integer math here.
> The input range is very limited, so reducing it further will also reduce the
> number of lux steps: int((47-5)/10) = 4, so you will end up with only 4
> luminance steps.
> 
> Instead of messing with the precision, I propose simplifying the original code
> to a simple table lookup.
> This will reduce constant memory usage to 42 values * 16 bit = 84 bytes and
> computational complexity to one single memory reference.
> While I'm sure there is a more optimal solution, I think it's the easiest to
> understand with the least impact on accuracy and performance:
> 
> #define GP2AP002_ADC_MIN 5
> #define GP2AP002_ADC_MAX 47
> 
> /*
>  * This array maps current and lux.
>  *
>  * Ambient light sensing range is 3 to 55000 lux.
>  *
>  * This mapping is based on the following formula.
>  * illuminance = 10 ^ (current[mA] / 10)
>  */
> static const u16 gp2ap002_illuminance_table[] = {
> 	3, 4, 5, 6, 8, 10, 12, 16, 20, 25, 32, 40, 50, 63, 79, 100, 126, 158,
> 	200, 251, 316, 398, 501, 631, 794, 1000, 1259, 1585, 1995, 2512, 3162,
> 	3981, 5012, 6310, 7943, 10000, 12589, 15849, 19953, 25119, 31623,
> 	39811, 50119,
> };
> 
> static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
> {
> 	const struct gp2ap002_illuminance *ill1;
> 	const struct gp2ap002_illuminance *ill2;
> 	int ret, res;
> 	u16 lux;
> 
> 	ret = iio_read_channel_processed(gp2ap002->alsout, &res);
> 	if (ret < 0)
> 		return ret;
> 
> 	dev_dbg(gp2ap002->dev, "read %d mA from ADC\n", res);
> 
> 	/* ensure we're staying inside the boundaries of the lookup table */
> 	clamp(res, GP2AP002_ADC_MIN, GP2AP002_ADC_MAX);
> 	lux = gp2ap002_illuminance_table[res - GP2AP002_ADC_MIN];
> 
> 	return (int)lux;
> }
> 
