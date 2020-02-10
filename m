Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3661C1583C5
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 20:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgBJTdT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 14:33:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41884 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgBJTdT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 14:33:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so1717710eds.8;
        Mon, 10 Feb 2020 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w36s0BPm77BtIMuulCGapzg9CWOiNHppbNkMRE8NHG4=;
        b=YzTsA+wkKDG075Nf8XE9yHWoLixAPqqzahbqJuowbazDImV6P8Sup8vVB9CfAXp+0x
         pUoWOQsm2WmPfGZq7IowHRAhQujYdKN42L7ODR4tgPTQX0YkhysbBelSB0ZCW8hMEnF8
         S9uCXz/ezfs3XlI4wotg++3TFb7eU74rQ2Xynw7VYke/lvEE63mlH7fT1T92T4jKwd3S
         bdiR1TPEgWKimYSmhxX664aqcF+YCAA326azj39GsuqcMoUSR9FPWB0Qr2o9QNXE2bNn
         11nCVVDUxodz7msBDKnsNgwv47taLmUpdPgYrbPWxgQkqq6m/ITVkbWsoC3eQKR6ss2w
         gScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=w36s0BPm77BtIMuulCGapzg9CWOiNHppbNkMRE8NHG4=;
        b=m+tb5bxFOAOM6Hut1CCyfIzZQwHrfkzfDsoj+rStqHN8ZYFmwsveMCe1HiCwjG5VMe
         N/4IhRivypw1RVtYZXT+rOpLJ6dGYXqvwPvy7lZc6GscaG1vtucLwsJ+ngGqUsM/x7s2
         Hy09iQcfws/1fbi3Dwo3yjA+rJODVc3qugwVtfaBBP1mtWcdM8kiqmyuDHwPQA7aWtjw
         Bd9ONgb+GmiO81GUaf7mvEEoMd30jDFkpiy1ma/GMEG9qNx1JQK3Fq0QAX12bjpu4pMq
         V5XS7qPIicT1dVABj/V1u64r3KZNnmEIMof0pdcLzQhSoZRrTWxQEWXS9vIA0Led0yx2
         Knsw==
X-Gm-Message-State: APjAAAW2mvRrkABUONrNznPsq2VPPtSIbg0Is1SEZvzCEnChKNFHvN2k
        iUbwJhnsiYDoXvvtflX1Rpsc2AsdeRA=
X-Google-Smtp-Source: APXvYqzPIJcSWUtbXBj27wM6EvP3Fgl1/B8SrsCSAhzC2XzuUDnuf6YXsTEYxE2N/CT8Kwq4ZKRP2w==
X-Received: by 2002:aa7:d294:: with SMTP id w20mr2685781edq.134.1581363197666;
        Mon, 10 Feb 2020 11:33:17 -0800 (PST)
Received: from ?IPv6:2a02:168:575a:b00b:bdbc:c867:2267:5ad0? ([2a02:168:575a:b00b:bdbc:c867:2267:5ad0])
        by smtp.googlemail.com with ESMTPSA id cf2sm84986edb.2.2020.02.10.11.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 11:33:17 -0800 (PST)
Subject: Re: [PATCH] RFT: iio: gp2ap002: Replace LUT with math
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Input <linux-input@vger.kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>
References: <20200208123359.396-1-linus.walleij@linaro.org>
 <74ab4b7b-eae2-0c6f-bb4a-eabbd3b4d042@gmail.com>
 <CACRpkdau3ei4OXcpucctxKqb7baHsMf8a0Q6sQ4P=gOf=bxQ5A@mail.gmail.com>
From:   Gregor Riepl <onitake@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=onitake@gmail.com; prefer-encrypt=mutual; keydata=
 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
 WFSiKQ==
Message-ID: <395b3e38-cea4-9376-1544-f1ef85abf171@gmail.com>
Date:   Mon, 10 Feb 2020 20:33:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdau3ei4OXcpucctxKqb7baHsMf8a0Q6sQ4P=gOf=bxQ5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>> Also: It looks like int_pow doesn't saturate, so even though it uses 64bit
>> integer math, it might be better to move the range check before the calculation.
> 
> How do you mean I should be doing that without actually
> doing the power calculation? (Maybe a dumb question but
> math was never my best subject.)

Well, if you clamp the input value to a valid range, there is no risk of
under- or overflow:

#define GP2AP002_ADC_MIN 5
#define GP2AP002_ADC_MAX 47
/* ensure lux stays in a valid range
   lux > 10^(5/10)
   lux < 10^(47/10)
 */
clamp(res, GP2AP002_ADC_MIN, GP2AP002_ADC_MAX);
lux = int_pow(10, (res/10));

However, there is another problem with this solution:
If you divide the input value by 10 before raising it to the power of 10, you
lose a lot of precision. Keep in mind that you're doing integer math here.
The input range is very limited, so reducing it further will also reduce the
number of lux steps: int((47-5)/10) = 4, so you will end up with only 4
luminance steps.

Instead of messing with the precision, I propose simplifying the original code
to a simple table lookup.
This will reduce constant memory usage to 42 values * 16 bit = 84 bytes and
computational complexity to one single memory reference.
While I'm sure there is a more optimal solution, I think it's the easiest to
understand with the least impact on accuracy and performance:

#define GP2AP002_ADC_MIN 5
#define GP2AP002_ADC_MAX 47

/*
 * This array maps current and lux.
 *
 * Ambient light sensing range is 3 to 55000 lux.
 *
 * This mapping is based on the following formula.
 * illuminance = 10 ^ (current[mA] / 10)
 */
static const u16 gp2ap002_illuminance_table[] = {
	3, 4, 5, 6, 8, 10, 12, 16, 20, 25, 32, 40, 50, 63, 79, 100, 126, 158,
	200, 251, 316, 398, 501, 631, 794, 1000, 1259, 1585, 1995, 2512, 3162,
	3981, 5012, 6310, 7943, 10000, 12589, 15849, 19953, 25119, 31623,
	39811, 50119,
};

static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
{
	const struct gp2ap002_illuminance *ill1;
	const struct gp2ap002_illuminance *ill2;
	int ret, res;
	u16 lux;

	ret = iio_read_channel_processed(gp2ap002->alsout, &res);
	if (ret < 0)
		return ret;

	dev_dbg(gp2ap002->dev, "read %d mA from ADC\n", res);

	/* ensure we're staying inside the boundaries of the lookup table */
	clamp(res, GP2AP002_ADC_MIN, GP2AP002_ADC_MAX);
	lux = gp2ap002_illuminance_table[res - GP2AP002_ADC_MIN];

	return (int)lux;
}
