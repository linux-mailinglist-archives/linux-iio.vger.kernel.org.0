Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D351585C3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 23:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgBJWxV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 17:53:21 -0500
Received: from mail-dm6nam12olkn2084.outbound.protection.outlook.com ([40.92.22.84]:5171
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbgBJWxV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Feb 2020 17:53:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr4uTGXbblTAjpDa462XmE/6r6hiI8O33+pLUVf6VFgJ+uiikuR8Ru0qUXyFbolzsjaEJZ7qCtUVCLV4MNRkQ2oz9wQnRlsp6VAY2dNHPZUXXKqMzpqgEt2oEl4rNv45Az50ebDRxS7Rpyno4gmbRue0b/2ATUiQMwhBMDz7QvBfxXHciQNLbclpm1dqstLxfwncB8UHFTFoBXtlXvF+DeRV3UXa5c6ojnl4oGfboVCeaHaCbpe2Hb1Uucr8TBZCFojdESYi5PM5Wq4BOmBjCIiQVbLyWYfJAbUbHb9aEfYUzPgn2lamGO3FPqJRGZAMqxBSOhjQRbzzwFBu78uC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvol4RmJ6Rd94M//HxyRihI+XD20/55NnmFIHnpHkOs=;
 b=HYa6a8EGlQaDIfhl/gzuRZfgL5TPS5Gwdyzvno4CjHnPeLcTkYEro0JdDw/EZOBLm+I11FOxFZkoElqv8jdWpqjDR2cO7TiMglxMc5OGRn3d/QEbIY5hp/U5EQIpBlW+2FCXa0bdIRi4Che3p7B8QMsSaMKANgki+Ca+LF7ZuuFcbJReLJ/sGCBv+ioqoLaImFHyU6JazJSNDR9GaONvFcxgczd1etoWuscI5ZVRnFRvEhdsSfsc3NXH9MRuUBILkPgrau/Q751kmEILGw64AHcDcG1nxU5+4M48KwcJCGKk1X30cNED+Io4gIcN/n/lQW5CEvf4mm66XFUtjf3oHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM12FT013.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::37) by
 BN8NAM12HT019.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::387)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.10; Mon, 10 Feb
 2020 22:53:17 +0000
Received: from BYAPR10MB3479.namprd10.prod.outlook.com (10.13.182.55) by
 BN8NAM12FT013.mail.protection.outlook.com (10.13.182.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Mon, 10 Feb 2020 22:53:17 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:3E50AC6ECAFB7DB039BE6AEE108B2F62DCAC7E165E11EB198F42FBC05EEEC0C6;UpperCasedChecksum:7F56E281B9D995169C7217B5FF86F0E97400ABE102B705F6612CBF0592167F92;SizeAsReceived:9047;Count:49
Received: from BYAPR10MB3479.namprd10.prod.outlook.com
 ([fe80::609c:d845:cbb0:ce16]) by BYAPR10MB3479.namprd10.prod.outlook.com
 ([fe80::609c:d845:cbb0:ce16%7]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 22:53:17 +0000
Subject: Re: [PATCH] RFT: iio: gp2ap002: Replace LUT with math
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org
References: <20200208123359.396-1-linus.walleij@linaro.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <BYAPR10MB3479CA8AAFC7CA02A5827B01A3190@BYAPR10MB3479.namprd10.prod.outlook.com>
Date:   Mon, 10 Feb 2020 14:53:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <20200208123359.396-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0022.namprd22.prod.outlook.com
 (2603:10b6:300:ef::32) To BYAPR10MB3479.namprd10.prod.outlook.com
 (2603:10b6:a03:11a::16)
X-Microsoft-Original-Message-ID: <8196ec96-1999-ded8-005a-1f37ca38a702@live.ca>
MIME-Version: 1.0
Received: from [IPv6:2001:569:fb67:7300:9f89:4b96:de0b:cd14] (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by MWHPR22CA0022.namprd22.prod.outlook.com (2603:10b6:300:ef::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 22:53:15 +0000
X-Microsoft-Original-Message-ID: <8196ec96-1999-ded8-005a-1f37ca38a702@live.ca>
X-TMN:  [lXslJ8Fa6v9eiq3KGAwiPIrFTBltzXquQ0+aseneyoEjpCLwcLvPe4KOBEnzQ0Z2]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 189afcb6-0c92-4d16-bed4-08d7ae7c0399
X-MS-TrafficTypeDiagnostic: BN8NAM12HT019:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StE9o6bPwKIotRFWjqo76TVeRQL5ifZWJkwHGFfI2TyC5AnEmcf+NvACScJcnL3secADH69NlbKNAYAchfUAymKglw5VTQcOhzxDs1bL9HdrBndDQRpA/sHPh8Pys7Ak5MtJ3Hf1gfbrPWZ+kP1MVk3igBWpoDvndKCqdb59GtNeS6TagaZJjmYEcTrTj5fG
X-MS-Exchange-AntiSpam-MessageData: R2AFwWwVU8o+bSOiBVV3Ne1iBA8WbHnm60AH/7W3XilQ5683qPLOZ9PFBD67qEPCwYBWrN0+0Nit3plxoGyZ0eIr+Q1TsjRKR6ZM+nLoXqb/zcA5OjSHHTpU70FYb4oGdsh9NLoq8eWm08IM7xyh31B4y4beb/bwaZXI9hSiiqcMXPKzfQSwCAUXv2X2HP4laqiISu+wE/9pK4Thvz95wQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189afcb6-0c92-4d16-bed4-08d7ae7c0399
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 22:53:17.6677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT019
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Linus,

After implementing a small shim from the voltage ADC on my device, I was able to test this.
Please see my inline comments.

On 2020-02-08 4:33 a.m., Linus Walleij wrote:
> This replaces the current-to-lux look up table with some
> integer math using int_pow() from <linux/kernel.h>.
> Drop the unused <linux/math64.h> in the process.
> 
> Cc: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I would appreciate testing that this give the right
> result. Using math does look a lot better.
> ---
>  drivers/iio/light/gp2ap002.c | 94 +++---------------------------------
>  1 file changed, 7 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index 433907619268..153ae0a163ab 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -33,7 +33,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/interrupt.h>
>  #include <linux/bits.h>
> -#include <linux/math64.h>
>  #include <linux/pm.h>
>  
>  #define GP2AP002_PROX_CHANNEL 0
> @@ -205,71 +204,10 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
>  	return IRQ_HANDLED;
>  }
>  
> -struct gp2ap002_illuminance {
> -	unsigned int curr;
> -	unsigned int lux;
> -};
> -
> -/*
> - * This array maps current and lux.
> - *
> - * Ambient light sensing range is 3 to 55000 lux.
> - *
> - * This mapping is based on the following formula.
> - * illuminance = 10 ^ (current / 10)
> - */
> -static const struct gp2ap002_illuminance gp2ap002_illuminance_table[] = {
> -	{ .curr		= 5, .lux	= 3 },
> -	{ .curr		= 6, .lux	= 4 },
> -	{ .curr		= 7, .lux	= 5 },
> -	{ .curr		= 8, .lux	= 6 },
> -	{ .curr		= 9, .lux	= 8 },
> -	{ .curr		= 10, .lux	= 10 },
> -	{ .curr		= 11, .lux	= 12 },
> -	{ .curr		= 12, .lux	= 16 },
> -	{ .curr		= 13, .lux	= 20 },
> -	{ .curr		= 14, .lux	= 25 },
> -	{ .curr		= 15, .lux	= 32 },
> -	{ .curr		= 16, .lux	= 40 },
> -	{ .curr		= 17, .lux	= 50 },
> -	{ .curr		= 18, .lux	= 63 },
> -	{ .curr		= 19, .lux	= 79 },
> -	{ .curr		= 20, .lux	= 100 },
> -	{ .curr		= 21, .lux	= 126 },
> -	{ .curr		= 22, .lux	= 158 },
> -	{ .curr		= 23, .lux	= 200 },
> -	{ .curr		= 24, .lux	= 251 },
> -	{ .curr		= 25, .lux	= 316 },
> -	{ .curr		= 26, .lux	= 398 },
> -	{ .curr		= 27, .lux	= 501 },
> -	{ .curr		= 28, .lux	= 631 },
> -	{ .curr		= 29, .lux	= 794 },
> -	{ .curr		= 30, .lux	= 1000 },
> -	{ .curr		= 31, .lux	= 1259 },
> -	{ .curr		= 32, .lux	= 1585 },
> -	{ .curr		= 33, .lux	= 1995 },
> -	{ .curr		= 34, .lux	= 2512 },
> -	{ .curr		= 35, .lux	= 3162 },
> -	{ .curr		= 36, .lux	= 3981 },
> -	{ .curr		= 37, .lux	= 5012 },
> -	{ .curr		= 38, .lux	= 6310 },
> -	{ .curr		= 39, .lux	= 7943 },
> -	{ .curr		= 40, .lux	= 10000 },
> -	{ .curr		= 41, .lux	= 12589 },
> -	{ .curr		= 42, .lux	= 15849 },
> -	{ .curr		= 43, .lux	= 19953 },
> -	{ .curr		= 44, .lux	= 25119 },
> -	{ .curr		= 45, .lux	= 31623 },
> -	{ .curr		= 46, .lux	= 39811 },
> -	{ .curr		= 47, .lux	= 50119 },
> -};
> -
>  static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
>  {
> -	const struct gp2ap002_illuminance *ill1;
> -	const struct gp2ap002_illuminance *ill2;
>  	int ret, res;
> -	int i;
> +	u64 lux;
>  
>  	ret = iio_read_channel_processed(gp2ap002->alsout, &res);
>  	if (ret < 0)
> @@ -277,31 +215,13 @@ static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
>  
>  	dev_dbg(gp2ap002->dev, "read %d mA from ADC\n", res);
>  
> -	ill1 = &gp2ap002_illuminance_table[0];
> -	if (res < ill1->curr) {
> -		dev_dbg(gp2ap002->dev, "total darkness\n");
> -		return 0;
> -	}
> -	for (i = 0; i < ARRAY_SIZE(gp2ap002_illuminance_table) - 1; i++) {
> -		ill1 = &gp2ap002_illuminance_table[i];
> -		ill2 = &gp2ap002_illuminance_table[i + 1];
> -
> -		if (res > ill2->curr)
> -			continue;
> -		if ((res <= ill1->curr) && (res >= ill2->curr))
> -			break;
> +	lux = int_pow(10, (res/10));

Unfortunately, this doesn't seem to work.  Since it's integer math, it means we
only have an output of 100, 1000, or 10000 depending on the reading.  A LUT is
probably a much better solution.

> +	if (lux > INT_MAX) {
> +		dev_err(gp2ap002->dev, "lux overflow, capped\n");
> +		lux = INT_MAX;
>  	}
> -	if (res > ill2->curr) {
> -		dev_info_once(gp2ap002->dev, "max current overflow\n");
> -		return ill2->curr;
> -	}
> -	/* Interpolate and return */
> -	dev_dbg(gp2ap002->dev, "interpolate index %d and %d\n", i, i + 1);
> -	/* How many steps along the curve */
> -	i = res - ill1->curr; /* x - x0 */
> -	/* Linear interpolation */
> -	return ill1->lux + i *
> -		((ill2->lux - ill1->lux) / (ill2->curr - ill1->curr));

However, this also apparently didn't really work either as I was having what appeared to be
overflow errors (ie when a raw ADC value of 37, this calculation pulls out -52961).

Here's a few entries after add a debug print right after the gp2ap002_get_lux() call in
gp2ap002_read_raw():

gp2ap002 11-0044: read 33 mA from ADC
iio iio:device4: read value of -94193
gp2ap002 11-0044: read 37 mA from ADC
iio iio:device4: read value of -52961
gp2ap002 11-0044: read 39 mA from ADC
iio iio:device4: read value of -32345
gp2ap002 11-0044: read 42 mA from ADC
iio iio:device4: read value of -1421
gp2ap002 11-0044: read 39 mA from ADC
iio iio:device4: read value of -32345
gp2ap002 11-0044: read 29 mA from ADC
iio iio:device4: read value of -135425
gp2ap002 11-0044: read 48 mA from ADC
gp2ap002 11-0044: max current overflow
iio iio:device4: read value of 47
gp2ap002 11-0044: read 33 mA from ADC

My apologies for not catching this first time around.

> +
> +	return (int)lux;
>  }
>  
>  static int gp2ap002_read_raw(struct iio_dev *indio_dev,
> 

Thanks,
Jonathan Bakker
