Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21E5158A3C
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 08:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgBKHP6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 02:15:58 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33209 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbgBKHP6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 02:15:58 -0500
Received: by mail-ed1-f50.google.com with SMTP id r21so3506999edq.0;
        Mon, 10 Feb 2020 23:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2DJLZrAT6KEVcAXpu4BJfYuNUP1TBwp0KrRVnv2Hc8=;
        b=XI3tgiMezL1GBGF36o0ELMqD3OfotwxFfS/sPQctYrIlZzwo0Tg7BsTpYaT9M+de4d
         uXeQfWwgbUV8GgcmRPgooUhh1G/papd93Y9+ijblZXI1VBvZmAxiy0PeSWcZFL5Ky2q9
         NDBWBFy/LeJKBq7kaZ+EHzkBQh+mmD2x5AvHVKPipzVwYFGVk8uZhSSXr5Px5StsOX2q
         64sjZgCdUQe4qsYNxG78ob6sdpsMuwcaPzPK+xFdj3qzjG7i9rdK7BXQEaRECVT5pJhz
         Kn/663xI6sHgAWwU+Qcxt5cKx+P+uB2C+7DHTKihwGsUvxu4/C0AXCb5pPTgvxKZHbaf
         yaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L2DJLZrAT6KEVcAXpu4BJfYuNUP1TBwp0KrRVnv2Hc8=;
        b=I+cFeuo/6pyJzZdvwydEQDp9UeDplmXBpNf/eqQ83jC4OFlffcqkgT6xUSTe2Rnbnp
         22Od/8vdXN6cFcNxhsIfh7k0Mc8M9UFEIcB6I0TevfiIfJlO4XV3Nu8TrecWzTj8o1ej
         FZvkrwkM+muUN68YfFL+8B+mpzuk+JXDzFWHattr/3LsPzMUZreJH2N3eG9wwTGtdAbF
         bhKIZWLnpQ81Qzkc34/cGZnTaseqTz/KzB/dVKEmCbW5KIAvMIfBu3fSdLSzldw0ktWP
         l1mQufeN3SL1T96JNMwphxNVtsN2gBvKF3GHYzM55yqcBFWtqBrsZ9cz8QdFMDW9U70g
         s4iw==
X-Gm-Message-State: APjAAAVTPN1FDHBby9fK9YUcKKXQC/GnUwxtFkt48CE7CvV0FPsv7xNf
        lLrHrA3USbi+ZSClZmfWiCxuGeRHJ3Q=
X-Google-Smtp-Source: APXvYqwptK9DxIFrUUunwSFwYE8Tb7HjLXl+TpUMGuUYyRjOqKTu0DO6EQm5BqfKBELriTAnOneY2A==
X-Received: by 2002:a50:8ad3:: with SMTP id k19mr4601972edk.224.1581405355940;
        Mon, 10 Feb 2020 23:15:55 -0800 (PST)
Received: from [10.153.222.254] ([213.55.225.141])
        by smtp.googlemail.com with ESMTPSA id q3sm281284eju.88.2020.02.10.23.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 23:15:55 -0800 (PST)
Subject: Re: [PATCH] RFT: iio: gp2ap002: Replace LUT with math
To:     Jonathan Bakker <xc-racer2@live.ca>,
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
 <BYAPR10MB34797AABF2536F03BC3B4065A3190@BYAPR10MB3479.namprd10.prod.outlook.com>
From:   Gregor Riepl <onitake@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=onitake@gmail.com; prefer-encrypt=mutual; keydata=
 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
 WFSiKQ==
Message-ID: <9797aa15-eed1-932c-3cd6-64d7ccbf9d5e@gmail.com>
Date:   Tue, 11 Feb 2020 08:15:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR10MB34797AABF2536F03BC3B4065A3190@BYAPR10MB3479.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Just an FYI - the ADC_MIN should probably be 0 for full darkness,
> but I understand the concept and like it :)
> 
> I believe the light sensor part to be a Sharp GA1A light detector or similar,
> based on the fact that DigiKey had a page (1) that
> mentions both together and that the specs for the GA1A1S202WP (2) line up quite well with
> those of the GP2AP002.  Note that the datasheet for the GA1A1S202WP even mentions the
> illuminance = 10 ^ (current / 10) formula, re-arranged as
> current = 10 * log(illuminance), although it specifies uA as opposed to mA which is the same
> as the Android libsensors (both the Nexus S (crespo) (3) and Galaxy Nexus (tuna) (4)) versions.
> I suspect that this should be adjusted after the call to iio_read_channel_processed().

How about this, then?
With a full-range lookup table (47 values), it's even possible to avoid
additional constants and simply clamp to the size of the table.


/*
 * This array maps current and lux.
 *
 * Ambient light sensing range is 3 to 55000 lux.
 *
 * This mapping is based on the following formula.
 * illuminance = 10 ^ (current[mA] / 10)
 *
 * When the ADC measures 0, return 0 lux.
 */
static const u16 gp2ap002_illuminance_table[] = {
	0, 1, 1, 2, 2, 3, 4, 5, 6, 8, 10, 12, 16, 20, 25, 32, 40, 50, 63, 79,
	100, 126, 158, 200, 251, 316, 398, 501, 631, 794, 1000, 1259, 1585,
	1995, 2512, 3162, 3981, 5012, 6310, 7943, 10000, 12589, 15849, 19953,
	25119, 31623, 39811, 50119,
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

	/* ensure we don't under/overflow */
	clamp(res, 0, ARRAY_SIZE(gp2ap002_illuminance_table) - 1);
	lux = gp2ap002_illuminance_table[res];

	return (int)lux;
}
