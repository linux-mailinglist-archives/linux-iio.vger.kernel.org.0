Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB81569E1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2020 11:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgBIK1F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Feb 2020 05:27:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37022 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgBIK1F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Feb 2020 05:27:05 -0500
Received: by mail-ed1-f67.google.com with SMTP id cy15so5178126edb.4;
        Sun, 09 Feb 2020 02:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FJtq+xQUY7uLDEaGHAx5SQx7lLCI9RhPLUyx6oWX/t8=;
        b=UAaM1Xjgq/zcjwdcxxEzIda2rZqGEytWZgFWZrN/aLhIqQXyiHcIpCt2WjwXY4qgfe
         TYv7UARq/G4QmxdYPRc4h+94BrIo/jXyQo0TyAWZWU1Z6ZjQQtEa6N9LL2+V0814pIVa
         a5lOrm4MTUsLJl3c/AY5JoEMb3437Fz3c6OwWxKWQgQaMPhvqJYrH+btXBCFAMZfwCTY
         4lqNYGTBkKHjB4h/bIgbBfv9rywO1Gach6EzWEUe+vITXba25WRW6yx2eon167n9lHpV
         V5yHyFEkgqohVyQT3/0oGFX09i1u5cGTnlNrxP1WPh/vroRYmxgaojVdt/tHqc5/vEuX
         2NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FJtq+xQUY7uLDEaGHAx5SQx7lLCI9RhPLUyx6oWX/t8=;
        b=iQOR4vLAzQQavW5OdHb+NhEtsID8lP2WAKgsZHmxs54EkF7fdM3+F9z3Lv0ALN9/UD
         5N8jW39MRs+Cx15l92UKThqZY+CNkZSM+853zpBxPOR7mR9h7cuZbYPYPrIe4yEmoWm+
         UTOtHoOg0Rz3pTFddUdtZvDqvD1NIL3APkwLINBKx2ASm8wpclcMmdVkkispKuNlprnE
         pKeYZ5UI/mLHjjSPo4tg50iTDVHBeO5haBkyDNuYgBRwP66nith5DbnNg4ZaQX1m7vGf
         OWg63xDdz2AjsHzFO8XyeGWt+zxp4LQRcI8liEXVDi50xjZi8jaT0+8NNIanqh9WhKnb
         1Mjg==
X-Gm-Message-State: APjAAAUspVyBf0i9VqQRtGB0/kPgXyRCLd9PIEXyYNcpWKv3rx1f+PnU
        FmA+0QLDlwz0p5ZWM+Aqalk=
X-Google-Smtp-Source: APXvYqzDrdMHVvFa5ZlMZIUXmHEid9EM5ibMNraAthZmjYtwcUlt60bAxbs7t/QAFSfvejjSENh5KA==
X-Received: by 2002:a05:6402:355:: with SMTP id r21mr5808658edw.60.1581244022476;
        Sun, 09 Feb 2020 02:27:02 -0800 (PST)
Received: from ?IPv6:2a02:168:575a:b00b:bdbc:c867:2267:5ad0? ([2a02:168:575a:b00b:bdbc:c867:2267:5ad0])
        by smtp.googlemail.com with ESMTPSA id qk16sm1183311ejb.71.2020.02.09.02.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 02:27:01 -0800 (PST)
Subject: Re: [PATCH] RFT: iio: gp2ap002: Replace LUT with math
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>
References: <20200208123359.396-1-linus.walleij@linaro.org>
From:   Gregor Riepl <onitake@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=onitake@gmail.com; prefer-encrypt=mutual; keydata=
 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
 WFSiKQ==
Message-ID: <74ab4b7b-eae2-0c6f-bb4a-eabbd3b4d042@gmail.com>
Date:   Sun, 9 Feb 2020 11:27:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200208123359.396-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


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
...

> -	for (i = 0; i < ARRAY_SIZE(gp2ap002_illuminance_table) - 1; i++) {
> -		ill1 = &gp2ap002_illuminance_table[i];
> -		ill2 = &gp2ap002_illuminance_table[i + 1];
> -
> -		if (res > ill2->curr)
> -			continue;
> -		if ((res <= ill1->curr) && (res >= ill2->curr))
> -			break;

That seems like a really, really contrived way to do a table lookup.
According to the table above, all successive input values between 5 and 47 are
covered, so shouldn't this be simple array indexing?

Something like:

#define gp2ap002_value_min 5
#define gp2ap002_value_max 47
static const unsigned int gp2ap002_value_to_illuminance_table[] = {
	3, 4, 5, 6, 8, ...... 39811, 50119
};
#define gp2ap002_table_size ARRAY_SIZE(gp2ap002_value_to_illuminance_table)
if (res < gp2ap002_value_min)
	return gp2ap002_value_to_illuminance_table[0];
if (res > gp2ap002_value_max)
	return gp2ap002_value_to_illuminance_table[gp2ap002_table_size - 1];
lux = gp2ap002_value_to_illuminance_table[res - gp2ap002_value_min];

And since res is linear, interpolation won't even be needed.

What am I missing?

> +	lux = int_pow(10, (res/10));
> +	if (lux > INT_MAX) {
> +		dev_err(gp2ap002->dev, "lux overflow, capped\n");
> +		lux = INT_MAX;
>  	}

This is certainly better, but I wonder if it's worth the computational cost.

Also: It looks like int_pow doesn't saturate, so even though it uses 64bit
integer math, it might be better to move the range check before the calculation.
