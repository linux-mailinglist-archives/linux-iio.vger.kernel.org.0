Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD7E22E8C8
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgG0JWw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 05:22:52 -0400
Received: from mail-am6eur05on2092.outbound.protection.outlook.com ([40.107.22.92]:63489
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbgG0JWw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Jul 2020 05:22:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBMcTddspGBQXTDKn+bztXC1+lxCzzjqme0YekPWC8iMTzSA9uLA0SAhVsoduBmAVfH0wxaC97paEhj4MaVzIHesNo2hhStK6WfYACe4V5NxBRtD3sXnGzk9EXlfQ3miC6QDK++YD1c63nSj7mitAdMX3cVWXwclKlID9vSDISyMwLqnwbe6xmKKkUn7EfUoQA5jHmV5UkMePkj2b4znxAkDoe1nNTn6RKiuZJP8M1su7CqqKufDbgriPu2OWGZPFZEASB1bgXw5EUPSoUVJE8Jsr9GDxFzkdANGq1OUuooQPGrwTsuxck7ZlV3Zvv+jqHaXXw7EbNJOxT+fm+W8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfJj0zmFiTZfKNyiH8FBy6BQ4VGptt8Zehdq7ZKNYWs=;
 b=GMifIwzTCa7F4e3NbKbdjKwUDmGazeN+SJjppBX0kY7MpGYhZuXxeGQWpYdXFmXOKGp22cGAF+zgydphQQxu9RtYAXwH9PfTeur9DgScXEFpRBBqYtbyF2nwIjLN6oevdD+Bpi7cj76D0CaoI2ZXELT9g8vY6Pm3sOaeO79HDZ0xPJOeX9kJazGJxRYpvmJ2dDPbZ/wGiGoLPVk3buMRY5ZwR3YqIFOjLzQPRmMeB/P7XGNzP1b5XuC+HWeH2Rj3MKAZTaThg0YmODJjKwe/8Vi8P3GW8BckfqD1GjnQfEh82GmciWWizQXBQ2jNzqux8iAT9on7xl9baSz/QsrbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfJj0zmFiTZfKNyiH8FBy6BQ4VGptt8Zehdq7ZKNYWs=;
 b=F5ZzFEBheTLctuFHCMt8pVMhqwCbqcwzk5WogtfAesvAOaHgx7L5rmfPAJlylxNqFy924IUYLneetLilUkq5bYTBTHnL/yMIqfeoAmA00hgwo34qmPwpAnoqvfK3514DMQgU3HGTCOPz6GPDwt3sAXZk/bV7mR9NOI4nOt8Ri70=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4106.eurprd02.prod.outlook.com (2603:10a6:10:4c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 09:22:48 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 09:22:48 +0000
Subject: Re: [PATCH 1/2] iio: afe: rescale: Add support for converting scale
 avail table
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     od@zcrc.me, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200210225438.112660-1-paul@crapouillou.net>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <01e20726-ad01-2761-2546-c574bfb3ea88@axentia.se>
Date:   Mon, 27 Jul 2020 11:22:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200210225438.112660-1-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::24) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 09:22:47 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2677fabf-cf27-4add-070e-08d8320ea0ef
X-MS-TrafficTypeDiagnostic: DB7PR02MB4106:
X-Microsoft-Antispam-PRVS: <DB7PR02MB4106197C3BCABFF4A5DB1211BC720@DB7PR02MB4106.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpfL5A3C06SRwXsLa5vxJYyIpw9XdCllnElldqfnDlNkdMCYguWWeF1MoLTKKXqTc8mu88wLeaFMdG7CSVRSwQe6KmatHN0fjL1DYAi8+eJteg9xe656sX9I2PzID/j8mSfRoDUtp8nN9KsFOcI6P8ND5vT+sY9udj0BfbwK/1eu6kok58+JVyv9/RRppHm9AIwEfKG56/dFHhJX3NS9szaOBTIZVP+vAvtHTEv3qm9uY/feqUlV538G4ZUtNQ8ZLULk0VOfpp6rU+cFc2cRb+dKbpPiszcPWtdCNJP4Y3UDNpDfJqDDpFJWaG0376wG3gnvZwjULDO6x/LdB+k6+bl/l3Ndc9sntkhlEhVpvMW5w3N7b/KpzZbrMXFBqHlL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39830400003)(376002)(136003)(346002)(366004)(66946007)(66556008)(956004)(2616005)(31696002)(66476007)(4326008)(110136005)(5660300002)(31686004)(26005)(8676002)(16576012)(16526019)(186003)(83380400001)(36916002)(316002)(2906002)(52116002)(6486002)(53546011)(508600001)(36756003)(8936002)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xx159ila6puXgRYJ3GQihtKcclINU1XTrfU2sSRspPapGMF/NA8I79wF8ZmH6/p24Jell2djnX+li0WM/j++qSJLyq8ED4Jx9UJVId+9Q0wA2A80ne/sOrB9c7Q6JzbGik73dN1/050tiDdtP7upyDgPF0yxu+RBYBJkq+feMOTFW6uj+0fRiHKO50hKZDoBDLOQgfdzh5VVYYT1EF85DGfnbOQIFvBpeFerllaKuNa+vedmKi20D4w329Ox41+OogLdrJVCadH1fSb2aRJtWSgnxDin6tMdAeEuwHdpaFMwJqf4fkR5jBJBP8BTOHgtHcgwGkQXGx547+F36AxZI6paUy88PJ85dHUcGjs8otHSq6IbCwDsxN1MQ2jXvrTea1sD+FAtuAeQoRluQIJsVOmeXEx9Y8QT9CwZ7OvrNI1FexYM/0qXuvw7k3AXUKRUGLFGmqJd4OOnkyBBubpSDHtPXrxX60LH4m4qqm4Hmsc=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2677fabf-cf27-4add-070e-08d8320ea0ef
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 09:22:48.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3b2UhFiz93Sxgob/WLrjstGxG2TzuCjYJj0+HHSPzLf6PMG3q3qEmof41ePfx96j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4106
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2020-02-10 23:54, Paul Cercueil wrote:
> When the IIO channel has a scale_available attribute, we want the values
> contained to be properly converted the same way the scale value is.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/afe/iio-rescale.c | 125 ++++++++++++++++++++++++++++------
>  1 file changed, 103 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index e9ceee66d1e7..95802d9ee25e 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -31,14 +31,45 @@ struct rescale {
>  	struct iio_chan_spec_ext_info *ext_info;
>  	s32 numerator;
>  	s32 denominator;
> +	int scale_type, scale_len;
> +	int *scale_data;
>  };
>  
> +static int rescale_convert(struct rescale *rescale, int type,
> +			   const int val, const int val2,
> +			   int *val_out, int *val2_out)
> +{
> +	unsigned long long tmp;
> +
> +	switch (type) {
> +	case IIO_VAL_FRACTIONAL:
> +		*val_out = val * rescale->numerator;
> +		*val2_out = val2 * rescale->denominator;
> +		return type;
> +	case IIO_VAL_INT:
> +		*val_out = val * rescale->numerator;
> +		if (rescale->denominator == 1)
> +			return type;
> +		*val2_out = rescale->denominator;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_VAL_FRACTIONAL_LOG2:
> +		tmp = val * 1000000000LL;
> +		do_div(tmp, rescale->denominator);
> +		tmp *= rescale->numerator;
> +		do_div(tmp, 1000000000LL);
> +		*val_out = tmp;
> +		*val2_out = val2;
> +		return type;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static int rescale_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
>  {
>  	struct rescale *rescale = iio_priv(indio_dev);
> -	unsigned long long tmp;
>  	int ret;
>  
>  	switch (mask) {
> @@ -47,27 +78,7 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = iio_read_channel_scale(rescale->source, val, val2);
> -		switch (ret) {
> -		case IIO_VAL_FRACTIONAL:
> -			*val *= rescale->numerator;
> -			*val2 *= rescale->denominator;
> -			return ret;
> -		case IIO_VAL_INT:
> -			*val *= rescale->numerator;
> -			if (rescale->denominator == 1)
> -				return ret;
> -			*val2 = rescale->denominator;
> -			return IIO_VAL_FRACTIONAL;
> -		case IIO_VAL_FRACTIONAL_LOG2:
> -			tmp = *val * 1000000000LL;
> -			do_div(tmp, rescale->denominator);
> -			tmp *= rescale->numerator;
> -			do_div(tmp, 1000000000LL);
> -			*val = tmp;
> -			return ret;
> -		default:
> -			return -EOPNOTSUPP;
> -		}
> +		return rescale_convert(rescale, ret, *val, *val2, val, val2);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -85,6 +96,14 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
>  		*type = IIO_VAL_INT;
>  		return iio_read_avail_channel_raw(rescale->source,
>  						  vals, length);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (rescale->scale_len) {
> +			*type = rescale->scale_type;
> +			*length = rescale->scale_len;
> +			*vals = rescale->scale_data;
> +			return IIO_AVAIL_LIST;
> +		}
> +		/* fall-through */
>  	default:
>  		return -EINVAL;
>  	}
> @@ -119,11 +138,65 @@ static ssize_t rescale_write_ext_info(struct iio_dev *indio_dev,
>  					  buf, len);
>  }
>  
> +static int rescale_init_scale_avail(struct device *dev, struct rescale *rescale)
> +{
> +	const int *scale_raw;
> +	unsigned int i;
> +	int ret;
> +
> +	ret = iio_read_avail_channel_attribute(rescale->source, &scale_raw,
> +					       &rescale->scale_type,
> +					       &rescale->scale_len,
> +					       IIO_CHAN_INFO_SCALE);
> +	if (ret)
> +		return ret;
> +
> +	if (rescale->scale_type == IIO_VAL_INT && rescale->denominator > 1)
> +		rescale->scale_len *= 2;
> +
> +	rescale->scale_data = devm_kzalloc(dev,
> +					   sizeof(int) * rescale->scale_len,
> +					   GFP_KERNEL);
> +	if (!rescale->scale_len)
> +		return -ENOMEM;
> +
> +	if (rescale->scale_type != IIO_VAL_INT) {
> +		for (i = 0; i < rescale->scale_len; i += 2) {
> +			ret = rescale_convert(rescale, rescale->scale_type,
> +					      scale_raw[i], scale_raw[i + 1],
> +					      &rescale->scale_data[i],
> +					      &rescale->scale_data[i + 1]);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	} else if (rescale->denominator == 1) {
> +		for (i = 0; i < rescale->scale_len; i++) {
> +			ret = rescale_convert(rescale, IIO_VAL_INT,
> +					      scale_raw[i], 0,
> +					      &rescale->scale_data[i], NULL);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	} else {
> +		for (i = 0; i < rescale->scale_len / 2; i++) {
> +			ret = rescale_convert(rescale, IIO_VAL_INT,
> +					      scale_raw[i], 0,
> +					      &rescale->scale_data[i * 2],
> +					      &rescale->scale_data[i * 2 + 1]);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int rescale_configure_channel(struct device *dev,
>  				     struct rescale *rescale)
>  {
>  	struct iio_chan_spec *chan = &rescale->chan;
>  	struct iio_chan_spec const *schan = rescale->source->channel;
> +	int ret;
>  
>  	chan->indexed = 1;
>  	chan->output = schan->output;
> @@ -142,6 +215,14 @@ static int rescale_configure_channel(struct device *dev,
>  	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW))
>  		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
>  
> +	if (iio_channel_has_available(schan, IIO_CHAN_INFO_SCALE)) {
> +		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_SCALE);
> +
> +		ret = rescale_init_scale_avail(dev, rescale);
> +		if (ret)
> +			return ret;
> +	}
> +

You unconditionally add a channel that in some cases then always return
"not supported" if you try to use it. Is that "safe" or can it cause
trouble for some unsuspecting application?

Cheers,
Peter
