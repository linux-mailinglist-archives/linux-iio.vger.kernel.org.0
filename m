Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE5818F4B3
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 13:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgCWMeK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 08:34:10 -0400
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:64559
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728149AbgCWMeJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 08:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSLkl4b73ohu0SbVxfzxjWkhToCf/xktkOt/hHH7pF8=;
 b=P5W6e8mEKh0PAFOxIt+tJ4M+kECvLmuPQSQSvD+Hn0gtg8Wde/NecKo281H229J+Gc9zBi7kdV3K7P8zzDUUkstNoRZ/jxZ+P236LmsSgm8h4IihlaVRID+qKoNcOqDEveJkFwA5LnLB/3uxp8f6MJ/6dAWXQfECNyOoZO59KFw=
Received: from AM6PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:20b:2e::25)
 by VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 12:34:03 +0000
Received: from HE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::85) by AM6PR05CA0012.outlook.office365.com
 (2603:10a6:20b:2e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Mon, 23 Mar 2020 12:34:03 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; pmeerw.net; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;pmeerw.net; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 HE1EUR01FT055.mail.protection.outlook.com (10.152.1.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 23 Mar 2020 12:34:02 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (104.47.4.59) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 23 Mar 2020 12:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvPEOSbUwnsF/gffgqVH89lbTePz5mH4WM2i71+KQLkMb/9vJQvP2HLa84sQB+j/RiGXwoUQMC8IhjKiTLF2Jq2be0WzMwhLVyQIoC5/eU/4RHshR+L4HMjyLrk3TSfqSUo3XLu8oAIbCBi2ywHlpjS9hv/pezyPf6X0jRZyg2b4gnzAM9nUf/Y1nJo0wiH/mIg3RceqGwHPLP8Z6AFU+6CBPuyWBlojYC/Dp/TPNU9N1m94lioIX7PHb8WlvX1WI/Z5J/+N9ThG+jNRhVxqV55AT0VwhkgcMGP2AN4e/mU3SIiFOMCbIeTB0Ie1SS6JRbjYgzArgBIC3Ex9ZHKtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSLkl4b73ohu0SbVxfzxjWkhToCf/xktkOt/hHH7pF8=;
 b=MncUmN8i2YIEvjPmK+9GwC5nQThgRiD69utiOnwOIIQ6hpDF0T2FUo1Gzj8dvhDtRGkZsEqKaxMczwiSV7EKM9Z4wE8AKlDyJkPkRVqHFKLSoDWLkKYfAXqNfyvhxrUDOwGQeDz54bCHjKzglCCUq66U9Hf0cDUf13IhPnl24Lcad3l5phIUe2BZYKzMCVvW7Lii2pDRNgIqg1UjQbtfF1N/Sqgm/lKal4h7YKyfjR4XWYZCbyJKHbhHZUskNkA44kygfaoPa59GB2CnegTgUpp0n5ZshMHb/g2cfJ3E4TdTPGS1z9Q6Bm5pQbjaQ1LMaPms6otZnFbmEWeHoCCTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSLkl4b73ohu0SbVxfzxjWkhToCf/xktkOt/hHH7pF8=;
 b=oM8kWcLDn01S89C571xLuLsr69ciqaYosOStd1lTda4qdlrWSAKIlfJ8sXuAXWaKof+DW+hjy2KA2EyHBuLNkng+0t25qWLG/59eoq5K2u9Fa9HPjolc5ktMlDidN16v6BAscq4lQQ6uEoUjx4DdSxkpIFinf6YWoB1Zg4ued2M=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 12:33:59 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 12:33:58 +0000
Subject: Re: [PATCH v4] iio: accel: Add support for the Bosch-Sensortec BMI088
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
References: <20200323092830.29708-1-mike.looijmans@topic.nl>
 <20200323113120.GI1922688@smile.fi.intel.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <35eef6af-bf1f-53e0-56a7-aa8161b4f867@topic.nl>
Date:   Mon, 23 Mar 2020 13:33:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200323113120.GI1922688@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0032.eurprd07.prod.outlook.com
 (2603:10a6:205:1::45) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM4PR07CA0032.eurprd07.prod.outlook.com (2603:10a6:205:1::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.12 via Frontend Transport; Mon, 23 Mar 2020 12:33:58 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186770c0-ac8d-421d-5d30-08d7cf267872
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3771:|VI1PR04MB5344:
X-Microsoft-Antispam-PRVS: <VI1PR04MB5344EC3878C18E1545FAEA1396F00@VI1PR04MB5344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;OLM:4125;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39840400004)(199004)(6916009)(2616005)(956004)(31696002)(16576012)(44832011)(53546011)(4326008)(8676002)(36756003)(52116002)(36916002)(31686004)(66476007)(66556008)(66946007)(5660300002)(508600001)(2906002)(6486002)(316002)(81156014)(81166006)(8936002)(42882007)(186003)(16526019)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: x+13mSonjrwQHyOu0vm13fPrQWWe01dTNb3eRlWARS9XmgV0THMtHZ37xo2reRbq2kPLieKXc1wGPbKg/pTJ4Nq1PDJwlxB0STP5APLiL5z5nDuELjAKAc6KjVuYFNBeTWFW/BO3v6fzLoXi14tkvYHk83E8iA5TyqJWmO5Q2edDCWCc8ojDe46NDLd43fWQVPpXtZvY72xVNTUI8BN+mCVx9O0g63mCi2FFZgQkPxwc21X1O3HD8+EgBLf+KST+puI41MxSAipMM50iHZrMs74oLv43Lm4WYvgAqIpFpWjgHJ4J+TlxhJ5lKs+ZK6L2XmixdiWfswAEbCjc8j1FIH8E5APbZRoTmYzO4u6/0T71jUi5+0zL/dlV6k2SderZMyyELiUjCtXmNkz6kW/HdM7Dm7ssJuT1FFAvjA4ySHAPAI6gjgHDH0HwrTTTm9bk
X-MS-Exchange-AntiSpam-MessageData: kmG+qw1Zg5AgbauILzF9cHxpVgubph9Zb0+aWVRoDtkxBf+3jglCtqbDfqqm/0akdLIsdcpuCiMGSwND/bs97WsWQqCG1zbRfIX6G9fCmV2za7O2VVrJ5JtslOKUM/Qx7DrjYifYISd7dVTU7QtPdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
X-CodeTwo-MessageID: c849ad19-01bf-4657-9b8d-c86b2423f6c2.20200323123400@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39840400004)(346002)(396003)(376002)(199004)(46966005)(356004)(53546011)(36916002)(31686004)(2906002)(246002)(5660300002)(70206006)(70586007)(36756003)(6916009)(8676002)(31696002)(8936002)(82310400001)(508600001)(2616005)(44832011)(956004)(26005)(336012)(42882007)(16526019)(47076004)(186003)(7596002)(7636002)(6486002)(4326008)(16576012)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5344;H:westeu13-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu13-emailsignatures-cloud.codetwo.com;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a830abc3-81df-4982-35ac-08d7cf2675c3
X-Forefront-PRVS: 0351D213B3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NO1uyMwIWMcwz/vO4hcNY0+A4FMNC6FDzEQftsNueO2LEvKB6diVhh2txd0s69kPaq9NF7rNELi+urXCQLg7p7ng+mr6VZUE6j6GmRAUrpepGKgH0UVcrmJGhgzlBsfsBAh9cnnwVMsRwRU167KTYLKq0v1jmQ+35tLS4MgySpvVkWHUhAZny+MZVrMLzWiFVA0qS196U4f6qIpqt5z/dysrmoUjys1eQuLzdxXZ83beQGcTF5Qy0DOjjkmF7jTn3HMt6uT9wmZToRRufeV42xkyXXoh/K2IH2tNd2n2ow9KDBJQ0VUA2aBhLsyem4FPF2ASXn75jcRt/Fp+zSlwRAvtBP7vkTmjwRCpPvW7gSP8gP3EKQUZl8AvwkW1CAjNur6Wyf95KBrRlzI6rfWtE7lkFrawv1PtD+q7EbHgKaIwlwMvBN1TTDD7/BrOgTWdLmUrDKXYvUnmgYkcX2YvzGhBDEr97QX5ZPJP3Zu5PnfiS1p3+SfYLfhUZmES0Eds699eCycxG2KqrbfNPkLxrw==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 12:34:02.9993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186770c0-ac8d-421d-5d30-08d7cf267872
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5344
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23-03-2020 12:31, Andy Shevchenko wrote:
> On Mon, Mar 23, 2020 at 10:28:30AM +0100, Mike Looijmans wrote:
>> The BMI088 is a combined module with both accelerometer and gyroscope.
>> This adds the accelerometer driver support for the SPI interface.
>> The gyroscope part is already supported by the BMG160 driver.
> 
> 
> Thank you, the comment about shared buffer given to v3 still applies.
> Also see below.
> 
> ...
> 
>> +enum bmi088_accel_axis {
>> +	AXIS_X,
>> +	AXIS_Y,
>> +	AXIS_Z,
> 
>> +	AXIS_MAX,
> 
> If it's a terminator entry, comma is not needed.

Actually it isn't used at all, I'll remove it.

> 
>> +};
> 
> ...
> 
>> +/* Available ODR (output data rates) in Hz */
>> +enum bmi088_odr_modes {
>> +	BMI088_ACCEL_MODE_ODR_12_5 = 0x5,
>> +	BMI088_ACCEL_MODE_ODR_25 = 0x6,
>> +	BMI088_ACCEL_MODE_ODR_50 = 0x7,
>> +	BMI088_ACCEL_MODE_ODR_100 = 0x8,
>> +	BMI088_ACCEL_MODE_ODR_200 = 0x9,
>> +	BMI088_ACCEL_MODE_ODR_400 = 0xa,
>> +	BMI088_ACCEL_MODE_ODR_800 = 0xb,
>> +	BMI088_ACCEL_MODE_ODR_1600 = 0xc,
>> +};
> 
> I'm wondering if you need this enum at all? Only 3 out of 8 are in use, and 25
> of them can be still derived from the 12.5 one.
> 
> Maybe replace with comment and ranges?
> 
> (But it's up to you, I have no strong opinion here)

Comment and ranges sounds better, it's all power-of-two stuff, and the 
values aren't actually being used.

> 
> ...
> 
>> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data, bool on)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +
>> +	if (on) {
>> +		ret = pm_runtime_get_sync(dev);
> 
> 		if (ret < 0)
> 			pm_runtime_put_noidle(dev);
> 
> See below.
> 
>> +	} else {
>> +		pm_runtime_mark_last_busy(dev);
>> +		ret = pm_runtime_put_autosuspend(dev);
>> +	}
>> +
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed: %s(%d)\n", __func__, on);
> 
>> +		if (on)
>> +			pm_runtime_put_noidle(dev);
> 
> Perhaps refactor as above?
> 
> In this case it maybe simple...
> 
>> +
>> +		return ret;
>> +	}
>> +
>> +	return 0;
> 
> ...like this
> 
> 	if (ret < 0)
> 		dev_err(dev, "Failed: %s(%d)\n", __func__, on);
> 
> 	return ret < 0 ? ret : 0;
> 
> (I guess compiler is clever enough to avoid condition twice, but again, I have
>   no strong opinion)

As most of the method body depends on that "bool" argument, I would 
actually just split it into separate "enable" and "disable" methods. 
Simpler to read and understand, and probably doesn't make a difference 
in compiled size either.

> 
>> +}
> 
> ...
> 
>> +static int bmi088_accel_enable(struct bmi088_accel_data *data, bool on_off)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +
> 
>> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CTRL,
>> +			   on_off ? 0x4 : 0x0);
> 
> I think
> 
> 	u32 val = on_off ? 0x4 : 0x0;
> 	...
> 	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CTRL, val);
> 
> will look better.
> 

Agree

> 
>> +	if (ret) {
>> +		dev_err(dev, "Error writing ACC_PWR_CTRL reg\n");
>> +		return ret;
>> +	}
> 
>> +	return 0;
>> +}
>> +
>> +/* In suspend mode, only the accelerometer is powered down. */
>> +static int bmi088_accel_set_mode(struct bmi088_accel_data *data,
>> +				enum bmi088_power_modes mode)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +
>> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CONF,
>> +			   mode == BMI088_ACCEL_MODE_SUSPEND ? 0x3 : 0x0);
> 
> Ditto.
> 
>> +	if (ret) {
>> +		dev_err(dev, "Error writing ACCEL_PWR_CONF reg\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +static int bmi088_accel_set_bw(struct bmi088_accel_data *data,
>> +				enum bmi088_odr_modes odr_mode,
>> +				enum bmi088_osr_modes osr_mode)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +	u8 value = (osr_mode << 4) | (odr_mode & 0xF);
> 
> _MASK (GENMASK() + _SHIFT? (See also below)
> 
> 	u8 value = (osr_mode << _SHIFT) | (odr_mode & _MASK);
> 	int ret;
> 
> (note reverse xmas tree ordering)
> 
>> +
>> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_CONF, value);
>> +	if (ret) {
>> +		dev_err(dev, "Error writing ACCEL_PWR_CONF reg\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmi088_accel_get_sample_freq(struct bmi088_accel_data *data,
>> +					int* val, int *val2)
>> +{
>> +	unsigned int value;
>> +	int ret;
> 
>> +	value &= 0xf; /* ODR in lower 4 bits */
> 
> _MASK? See above.
> 
>> +	if (value == BMI088_ACCEL_MODE_ODR_12_5) {
>> +		*val = 12;
>> +		*val2 = 500000;
>> +		ret = IIO_VAL_INT_PLUS_MICRO;
>> +	} else {
>> +		*val = 25 << (value - BMI088_ACCEL_MODE_ODR_25);
>> +		*val2 = 0;
>> +		ret = IIO_VAL_INT;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> ...
> 
>> +
>> +static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
>> +{
>> +	unsigned int value = BMI088_ACCEL_MODE_ODR_1600;
>> +
>> +	if (val < 12 || val > 1600)
>> +		return -EINVAL;
>> +
> 
>> +	value = fls(val) + (BMI088_ACCEL_MODE_ODR_12_5 - 4);
> 
> Wouldn't be
> 
> 	value = fls(val) + 1;
> 
> more obvious? Or, perhaps,
> 
> 	roundup_pow_of_two()
> 
> ?
> 
>> +	return regmap_update_bits(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
>> +				  0x0f, value);
> 
> _MASK ?
> 
>> +}
> 
>> +	if (ret)
>> +		return ret;
>> +
> 
>> +	*val = temp >> 5;
> 
> Magic shift.
> 
> ...
> 
>> +	s16 raw_val;
> 
>> +	ret = regmap_bulk_read(data->regmap,
>> +			       BMI088_ACCEL_AXIS_TO_REG(chan->scan_index),
>> +			       data->buffer, 2);
>> +	raw_val = get_unaligned_le16(data->buffer);
> 
> 
> I'm wondering if you can simple use le16_to_cpu()? I guess that buffer is
> always aligned and since you access it always by even addresses, it implies
> aligned access. Applies to other places as well.
> 
> ...
> 
>> +		case IIO_ACCEL:
> 
>> +		{
> 
> Why do you need block?
> 
>> +			ret = regmap_read(data->regmap,
>> +					  BMI088_ACCEL_REG_ACC_RANGE, val);
>> +			if (ret)
>> +				return ret;
>> +
> 
>> +			*val2 =  15 - (*val & 0x3);
> 
> Extra spaces.
> 
>> +			*val = 3 * 980;
>> +
>> +			return IIO_VAL_FRACTIONAL_LOG2;
>> +		}
>> +		default:
>> +			return -EINVAL;
>> +		}
> 
> ...
> 
>> +static const unsigned long bmi088_accel_scan_masks[] = {
>> +	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
>> +	0
> 
> + comma or is it agreed value for termination the list?
> 
>> +};
> 
> ...
> 
> 
>> +	usleep_range(BMI088_ACCEL_MAX_STARTUP_TIME_MS * 1000,
>> +		BMI088_ACCEL_MAX_STARTUP_TIME_MS * 1000 * 2);
> 
> 	unsigned long /* or what is used */ sleep = BMI088_ACCEL_MAX_STARTUP_TIME_MS * USEC_PER_MSEC;
> 	...
> 	usleep_range(sleep, 2 * sleep);
> 
> ?
> 
> ...
> 
>> +	addr[0] |= 0x80; /* bit7 = RW = '1' */
> 
> BIT(7) ?
> 
> ...
> 
>> +static const struct spi_device_id bmi088_accel_id[] = {
> 
>> +	{"bmi088_accel", 0},
> 
> ', 0' part is not needed.
> 
>> +	{}
>> +};
> 
> 
> 
>> +++ b/drivers/iio/accel/bmi088-accel.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef BMI088_ACCEL_H
>> +#define BMI088_ACCEL_H
>> +
>> +extern const struct regmap_config bmi088_regmap_conf;
>> +extern const struct dev_pm_ops bmi088_accel_pm_ops;
> 
> Do you need extern?

probably not.

> 
>> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>> +			    const char *name, bool block_supported);
>> +int bmi088_accel_core_remove(struct device *dev);
> 
> This needs
> 
> #include <linux/types.h>
> 
> struct device;
> struct regmap;
> 

Hmm, and "struct regmap_config" as well I guess (see above)


-- 
Mike Looijmans
