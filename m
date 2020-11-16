Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABA42B3E6F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Nov 2020 09:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKPISh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Nov 2020 03:18:37 -0500
Received: from mail-eopbgr80107.outbound.protection.outlook.com ([40.107.8.107]:47502
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726176AbgKPISh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Nov 2020 03:18:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGPtm1lJYubs15AJiSTLr4iZk/egdkytUTBY9i/5sBMRvHlbuJivSKOlYwZev2lwjYmcBEThrxSK6qnRCy6m2hswAj9agF5D292gsmgg0sVmmrCcPfKa2ITs3ftTVHT+6BhM5cv144Mod5HgD7zSq/QdATmdCo8hOGSaXVs+72/NLFFdVONg80KhgV0AuyDVPmLGUAuwNHep3f0aMSAizF4Fi/QN26pBbm4sa1TDHq+uE3lWOeG4Abrcrc1Xup7I9bSTascCxTgJZ5+rc6VBLsbzaGmS5Ut42snojVzfYCratucZaJZcrEIpfWgUnepxyVr5vvVVOOlvuzvyS7r96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgjuVBHcgPXtzwNbLUVmGb/ZRgaO034B3JfJHrjSQIs=;
 b=nfDzQhuM/kLzxBE7/z6ZXEGBfLOyXYwGef6O6A4Gbghm45aMKLs9nlGxRZoB53kGNTnYsBCMzRuHzSJtW4ccTxCpTLXO16pM3fRJxSzggiDaHEtKl4uqSdw17lTLR7SlhGbtzZzG7EPTeZxpetb92B74fSzEFcQHKKBPk82PeRXSK66BWxC4zddUXAONOT5TB1K48JFUgZypfi+zKBWs/pCA/H6U6mzcIZZVf87cqC57/Co3H1WMHdZSolHHmrvV6x+811+X22OxND8VGVbPzBpoh0O2cDpTPeagd7A9PjbCmyJQh/+ldYYjqm64gb5QJXztEUCTLqh+23iSiZMlow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgjuVBHcgPXtzwNbLUVmGb/ZRgaO034B3JfJHrjSQIs=;
 b=W8rYp+xxqZTofTrFyssTGXzsJQia+8sqGPJbWUSuZzuwNpLOUmkbv72sI2O2Hiw7KCz1iY5ePc7lCcZOoc8famrU8o8KfByCEHnRCeDgdvmgRQeIivUXpy1JZ+zp6KEhouf5xlKQvAp+jSmVhQ3j7F+ZyYqea9i2pWGb4DTyUoo=
Authentication-Results: pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR02MB3173.eurprd02.prod.outlook.com (2603:10a6:6:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 08:18:32 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::9178:a26c:c1e1:636b]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::9178:a26c:c1e1:636b%4]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 08:18:32 +0000
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
To:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
 <20201115174408.000b05d4@archlinux>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <320464d8-659c-01de-0e08-34e4c744ef16@axentia.se>
Date:   Mon, 16 Nov 2020 09:18:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201115174408.000b05d4@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [213.112.136.71]
X-ClientProxiedBy: HE1PR0401CA0114.eurprd04.prod.outlook.com
 (2603:10a6:7:54::43) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (213.112.136.71) by HE1PR0401CA0114.eurprd04.prod.outlook.com (2603:10a6:7:54::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 08:18:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4466454c-16a2-4991-7f1d-08d88a08343d
X-MS-TrafficTypeDiagnostic: DB6PR02MB3173:
X-Microsoft-Antispam-PRVS: <DB6PR02MB3173C78A9367620C2FF02AC3BCE30@DB6PR02MB3173.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFWDsuySwspwZZNZAFRYCq/zcDrwwZ+h5dDqjr1rHBPXVFmZvHdsqkay1od+11HbOp3ZtCQw9SC3/Yz0P1KOJ2IgTXTPdGapIzbr+L+rbSF/iYx+irvk41xFSoOs/3u5H0WnCBSPWMjU2ors0oKcR69n0/4/G1Zv6/v5C1haR4mlaxWNGau+r8iH6r/1LCWR78LkijQiSGtA+K8hZtalrmrz/Dqoeg2O3AFp7MPyn7UqZguqm/xwxhWWvdjW+uuU3f6eU506LzzIyL7XUPJEUuz5jQh1Vjx1pRWf05zigZbKMvx0iUdot3f6reW2pTxq5bOr/R3RHdjQ4rSNcv7JRwxyVXEGXYBCAuX51upl+R7iA3wV2eYq8QgGa3fQBWnO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(376002)(39830400003)(136003)(5660300002)(26005)(2616005)(186003)(86362001)(4326008)(66946007)(2906002)(66476007)(36916002)(956004)(6666004)(16526019)(52116002)(31686004)(53546011)(66556008)(36756003)(4001150100001)(31696002)(6486002)(16576012)(54906003)(316002)(110136005)(8676002)(478600001)(83380400001)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xvsFk6P78M4yKl2d1/kg76qxMW+tA83UPUQdrLw8jsBtOuAuMCcqrAthCNCDL8JIYF8Leiv0oLVmJZN0mwD5+ytF+5XK0zPK2DSjEyKseTYiYUd2Nq/0dbaL1+Sc3m9DlAOTa8FJI9mWU+T1Kphbnwxl+8kXWiMQF05CYvYI03/tghcxNVEKcdKuCMSpCMqbwPGdIcgDqW5RHAJNkksEoWVdiDbb+sWKJc6oObY8JQ2avk1zGEYZwjJzmBWVygEpQV1vHAHMrMmxVD+R3uD5lqkRkOJnxdhiC+D+ou2dctv6k73ruDZH2SGNpGt/QSz9PL64zBPdfagdFy1ls5Ph3C+dahvJ1bGKQr+YHrzBDz+jmWBgNl3jVM9jn2fcds9w9bCi3zUMXw370tm++UPEDXsJEcqzO1s4X121nYxFTkMxKD3AQXhfV2X+ePfadaCNBwiTPjKPahfiG1yrFpJvzeCJmLCRFf4H7cfUAPBICUxtGb/vh2GKrTrCP2YcbDwXWgh0VROzllFZTpr9hGt7p2xyx0bRycu4IoPT4LDdyEv49uJywLBrbCDVLUym/HJ5Be9dHCx3bFsQ5twjRh1jg04p5+Bfbe0vTctOpBiWYE92Sf0ZLhnS0LzAgS3mdJhqDcnhaV4OSsCPZ9yfXqf9K8nmDvJ4hPHqg7VLpt2wvDV3wSwzjoAY4d7u6KxFEe0YoHQti1RBXfMBMXBER0r0EGB5ohv70FVWLEyhOlQ2beFdtOy6Gl+gUk5DzI2Z/bgBUssjNguQt/CXOPie5nJD3lWtk+a1qnEMOchMXk+zKOeMUBeMrTl/WHZv6VQDPDfN6yG6vp9cvGZtgO1NVRQSjL9ykKjU76PqZtkyipFAmMBO6+9FvQyGbJn4ykmEVK55sWZXK+zJkE6VBobN5QK3kw==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4466454c-16a2-4991-7f1d-08d88a08343d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 08:18:32.2696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ED4zxrEiEKj6zBcXpqwoV/+8jhlQgBWv/wzmfnnysqY+ZoWtJIyCqCaARN2Nu2Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3173
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2020-11-15 18:44, Jonathan Cameron wrote:
> On Mon,  2 Nov 2020 00:22:11 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> It happens that an ADC will only provide raw or processed
>> voltage conversion channels. (adc/ab8500-gpadc.c).
>> On the Samsung GT-I9070 this is used for a light sensor
>> and current sense amplifier so we need to think of something.
>>
>> The idea is to allow processed channels and scale them
>> with 1/1 and then the rescaler can modify the result
>> on top.
>>
>> Cc: Peter Rosin <peda@axentia.se>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Sorry, I kept leaving this to last as it was in the 'needed thought'
> pile - then running out of time and not getting to it.
> 
> Anyhow, I think this is the best we can do for the situation
> you describe so I'm happy with this.
> 
> @Peter, I definitely want your input on this one as well though
> before I apply it!

Yes, sorry about the delay. Same pile here, amplified with way too much
to do at work. My immediate reaction was that this is not that simple,
but after looking at it for a few minutes I also came to think that it's
perhaps the best that can be done.

But it's been a while, so it just took a while for things to dawn on me.

The rescaler passes on IIO_CHAN_INFO_RAW as-is to the underlying
driver in the .read_avail op, and this patch xforms the processed
channel into the raw channel. So that is a mismatch. I don't think
it's easily fixable in the general case because the processed channel
rarely, if ever, implements .read_avail? And I don't know if it
is allowed to return -EINVAL for the .read_avail op for the raw
channel, because that would be the obvious patch to squash-in...

Cheers,
Peter


> Jonathan
> 
> 
>> ---
>>  drivers/iio/afe/iio-rescale.c | 31 +++++++++++++++++++++++++++----
>>  1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>> index e42ea2b1707d..ea90034cb257 100644
>> --- a/drivers/iio/afe/iio-rescale.c
>> +++ b/drivers/iio/afe/iio-rescale.c
>> @@ -29,6 +29,7 @@ struct rescale {
>>  	struct iio_channel *source;
>>  	struct iio_chan_spec chan;
>>  	struct iio_chan_spec_ext_info *ext_info;
>> +	bool chan_processed;
>>  	s32 numerator;
>>  	s32 denominator;
>>  };
>> @@ -43,10 +44,27 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>>  
>>  	switch (mask) {
>>  	case IIO_CHAN_INFO_RAW:
>> -		return iio_read_channel_raw(rescale->source, val);
>> +		if (rescale->chan_processed)
>> +			/*
>> +			 * When only processed channels are supported, we
>> +			 * read the processed data and scale it by 1/1
>> +			 * augmented with whatever the rescaler has calculated.
>> +			 */
>> +			return iio_read_channel_processed(rescale->source, val);
>> +		else
>> +			return iio_read_channel_raw(rescale->source, val);
>>  
>>  	case IIO_CHAN_INFO_SCALE:
>> -		ret = iio_read_channel_scale(rescale->source, val, val2);
>> +		if (rescale->chan_processed) {
>> +			/*
>> +			 * Processed channels are scaled 1-to-1
>> +			 */
>> +			ret = IIO_VAL_FRACTIONAL;
>> +			*val = 1;
>> +			*val2 = 1;
>> +		} else {
>> +			ret = iio_read_channel_scale(rescale->source, val, val2);
>> +		}
>>  		switch (ret) {
>>  		case IIO_VAL_FRACTIONAL:
>>  			*val *= rescale->numerator;
>> @@ -132,8 +150,13 @@ static int rescale_configure_channel(struct device *dev,
>>  
>>  	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
>>  	    !iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
>> -		dev_err(dev, "source channel does not support raw/scale\n");
>> -		return -EINVAL;
>> +		if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
>> +			dev_info(dev, "using processed channel\n");
>> +			rescale->chan_processed = true;
>> +		} else {
>> +			dev_err(dev, "source channel does not support raw+scale or processed data\n");
>> +			return -EINVAL;
>> +		}
>>  	}
>>  
>>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> 

-- 
Peter Rosin
+46 730 746 224
Axentia Technologies AB
