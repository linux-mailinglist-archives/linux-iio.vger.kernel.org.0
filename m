Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 241F324059
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 20:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfETS2v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 14:28:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45162 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfETS2s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 14:28:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so15655713wrq.12
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2019 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=1FK2DXKOFB3m2S1KpmmuQv43CteVea0a4jQ56pD1zGU=;
        b=MKO23OSaVzWu2iXq1D/NoheHxvM//TR5El/kkQWNWAzfwY7e7J8R+enPDRvIUbcqyZ
         NGjqLknvjtxjieY11283DVblu86q3rTCxZdPRE6GthHzIt14xZqzra6jDX8IfVhEOK1/
         /dEo62OMajZdNoyVKHqPkx+lHxc1FV3t3UhJnYKtkjDl2Y8it0vSpPJvUDkDMsMGfn6a
         gA0PWm0KnRhdrdWs3nwI8OEBx+LXru7EBryVdEbd4vsoerDD76wUxbeTHeNylKy0aBbA
         muSMpvm/t3fHZZPRMZ/auAhltKn3kuz76uRjZVNj2P8gpjWuBFOPvKqhGhAug5LKeXrZ
         v5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=1FK2DXKOFB3m2S1KpmmuQv43CteVea0a4jQ56pD1zGU=;
        b=jbr9pIGwmZ+RvvfN7UbCxPFCAgDFLOruEy2eeXnHk0HiiDg9tj0pE0pnUmpCX5I+d1
         j8y/eAxsFydEUvKwtxJCKUNBb9dIuqKo8VlFD+HKnEVYacuoMSTpypEdNkM2bqqm6JQR
         ZwSLv1HFCFD/nVfzd65nmoi519UCenQwJKAN4szFbDnZ671pVcv1cZZqW/GUNfk2urxB
         jWSvfuEYLzvu5Y01IqCIymDGwjv0xKuHgLaCXwzY7NSuoQJ4QKv3k9nF1xuyqs14D5JQ
         TsbMlWybPwMm+IYnSDf45srSTj1T/1sK3T+/iNOADZvcmvGA4Dn3qN+4jBLXu4im6F+1
         nXSQ==
X-Gm-Message-State: APjAAAVa7qm3gtervApgnBaAFD3LvdM03UKT2sz076z25kH+rwni9NdR
        XvlEIp/6j4o/n3k5eDzPx1creA==
X-Google-Smtp-Source: APXvYqz1r9onPeVavfsoGIY5wwRXwdggSKOmpXExBfHgCEti4JqdGoRECSwavjBIMt+Lt5YrV3VNfg==
X-Received: by 2002:a5d:51d0:: with SMTP id n16mr34573876wrv.167.1558376926448;
        Mon, 20 May 2019 11:28:46 -0700 (PDT)
Received: from [192.168.1.77] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id a62sm600078wmh.11.2019.05.20.11.28.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 11:28:45 -0700 (PDT)
Message-ID: <5CE2F1DD.4070700@baylibre.com>
Date:   Mon, 20 May 2019 20:28:45 +0200
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson_saradc: update with SPDX Licence identifier
References: <20190520140228.29325-1-narmstrong@baylibre.com> <CAFBinCD8Gkb0aRXWPb1uuezSHuS9DxQmnhuuSttspDzWHNAV1w@mail.gmail.com>
In-Reply-To: <CAFBinCD8Gkb0aRXWPb1uuezSHuS9DxQmnhuuSttspDzWHNAV1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Martin,

Le 20/05/2019 19:55, Martin Blumenstingl a écrit :
> Hi Neil,
> 
> On Mon, May 20, 2019 at 4:02 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/iio/adc/meson_saradc.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> index 510d8b7ef3a0..e39d95734496 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -1,14 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> the original license text didn't mention "... or later"
> personally I'm happy with either GPL-2.0 or GPL-2.0+
> 

I'll fix and re-spin, thanks for reviewing.

Neil
