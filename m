Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03E9B2184
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbfIMOAe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 10:00:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33078 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388610AbfIMOAd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 10:00:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id o9so27195841edq.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2019 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wQZMPduMO/AGfff6QWqX5As21nc9QyC0AE0tu1+LlCI=;
        b=NPvDM7j+PZm2sXotF5svQGUCg4o8IoL59R/ruI3zb9WPKxH+wzbL6TZUk4MzZGyBEF
         3uI1pNHqrnp5NpuSvqnkDFYu0G9dBdfF2h+MO3VnSCLa3yxwk+p5khPgZpOzIq4BEnO9
         WCAqaFVz2SpLTE2/O/JX7FM2fQOmGHsO3/5c/SrTpwku4sBPKEu4slTxpDavtbmcmml7
         74NvbchxJPhISEOYj7MKOUx8CUtOOjkua5MIbKcOD1XEOdXjVSABUlIe4Pe+Fpqp+xDV
         vOdaGcDIlLBocCJFg2/aQACO05l7x6rAx/2i3fjQlwjioIiS4a8bqF+RTXS3p2MbZAWL
         GZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wQZMPduMO/AGfff6QWqX5As21nc9QyC0AE0tu1+LlCI=;
        b=MT5MnK41m299/5FYcAYwDfo2zRHrlAY8Bde9+j5/aYQhoKTd6aKuPWs7D/57ZqDPkn
         jPKFOAVCNo9pbQRuQLsWD41wEiwxeHkcFf0nQrrtN4S4y2keN9KPYtguev8OhvvfTcqb
         nJA+dITA+JfoENQyNh7IJ/zhkJUQJ/NX/PTOjAB8xL+tkCQQp0jl/H2ZNhv+LpC44L6g
         AbLjnK4FLu8/T7UU35p511w47XcNka5bSi+8wc2eynZ9Gl+9CgLei/yUAzRQ2/NmTEnI
         9CyLQS8L0WKNWPFinf/6UyC4KwowNo/uVBn0HM7TIzHlAD68MBqk0TqSTgf+6F3tzZ3D
         DWWQ==
X-Gm-Message-State: APjAAAU/IQXAb2ygKdSlmy14cE7eFbEgkLFfwS1MajYYDmUnOwbdtXcE
        pLFd8yg1hlBLG+n3PrEBL+2vp+x/IQs=
X-Google-Smtp-Source: APXvYqyxWOAdp49zwOgiVHg16wNgR7r92CJrMbyf3dR+nCwRJE2xOfgwftLaLbfJ6rzpfU3maBxEYQ==
X-Received: by 2002:a50:fd96:: with SMTP id o22mr43801749edt.218.1568383231349;
        Fri, 13 Sep 2019 07:00:31 -0700 (PDT)
Received: from [192.168.1.31] (230.120-247-81.adsl-dyn.isp.belgacom.be. [81.247.120.230])
        by smtp.gmail.com with ESMTPSA id j10sm5395213ede.59.2019.09.13.07.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 07:00:30 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fixes for ad7949
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <1f13820761bbdb4db685a90e9bcf35a388b246cf.camel@analog.com>
From:   Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <2b7ab6c3-6ff6-69b5-bbd4-f8a1966b6b57@essensium.com>
Date:   Fri, 13 Sep 2019 16:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1f13820761bbdb4db685a90e9bcf35a388b246cf.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Le 13/09/2019 à 09:24, Ardelean, Alexandru a écrit :
> On Thu, 2019-09-12 at 16:43 +0200, Andrea Merello wrote:
>> [External]
>>
>> This patch series fixes ad7949 driver incorrectly read data, simplify the
>> code, and enforces device timing constraints.
>>
>> This has been tested on a UltraZed SOM + a custom carrier equipped with
>> several AD7689 A/Ds. Patches have been developed on a Xilinx upstream
>> kernel and then rebased on linux-next kernel.
>>
> Thanks for the patches.
> Added Charles-Antoine to also take a look.
> Apologies for not thinking of adding him sooner.
>
> I typically try to review changes for ADI parts, but he wrote it, so he may have more input than I do.
> Jonathan will likely also take a look.
>
> If it's agreed, I would say to at least take the first patch ("iio: ad7949: kill pointless "readback"-handling code")
> now and see about the rest.
> The rest are a bit more open to discussion, so a v2 may happen.

Hi,

Don't worry. Due to the fact I don't have on my mail client access to 
the whole discussions, I'm making a complete answer there based on the 
archive of the mailing list. Sorry for that.


For the patch 1, I approve it too. This part of code is useless because 
the feature was removed. RIP my code. :D

For the patch 2, the cache information was added due to comment from 
Jonathan Cameron when I developed the driver. The comment was:

> Look very carefully at the requirements for a buffer being passed
> to spi_sync.  It needs to be DMA safe.  This one is not.  The usual
> way to do that easily is to put a cacheline aligned buffer in your
> ad7949_adc_chip structure.
>
> Lots of examples to copy, but it's also worth making sure you understand
> why this is necessary.

For the endianess thing, it shouldn't be required to make an explicit 
conversion into the driver. According to the spi.h documentation:

> * In-memory data values are always in native CPU byte order, translated
> * from the wire byte order (big-endian except with SPI_LSB_FIRST). So
> * for example when bits_per_word is sixteen, buffers are 2N bytes long
> * (@len = 2N) and hold N sixteen bit words in CPU byte order.
So from my point of view the SPI subsystem always converts to the right 
endianess. We don't have to take care about it.


For patch 3, I didn't use delay_usecs fiels due to the timings 
definition in the datasheet in "READ/WRITE SPANNING CONVERSION WITHOUT A 
BUSY INDICATOR" mode. During the delay, the chip select line must be 
released which is not the case when we use delay_usecs field. So I add 
the delay instruction after the write step to be compliant with these 
timings.


For patch 4, I explained a bit in the other thread. Maybe we have a 
difference of behaviour due to the choice of the timings "modes"?


BTW, from my point of view the datasheet is not totally clear about the 
timings and what is mandatory or not in the expected behaviour.

Regards,

Charles-Antoine Couret

