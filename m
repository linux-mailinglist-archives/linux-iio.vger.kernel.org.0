Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E203489DFB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jan 2022 18:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbiAJREj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jan 2022 12:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiAJREj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jan 2022 12:04:39 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BCCC06173F
        for <linux-iio@vger.kernel.org>; Mon, 10 Jan 2022 09:04:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g26so46645305lfv.11
        for <linux-iio@vger.kernel.org>; Mon, 10 Jan 2022 09:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OucdhFM6jmRjO7w+OrNatwgwUpKYYH6g9Yld4XK2Xmc=;
        b=g1AU2ibnkdn+3RKmRbjZoA1vqG851dJHx0gr8btWYcOcLUTzGwsXLY3UO/bT6XQmbf
         Pzc9ywoA8RT3kjR4zow5XwhZJQFBermQ0sVfsz6NFY8cZM2KuGlJikJAERPMjPwpx0ji
         hjFcUujoeKs1BHcc5f5sB+V7mkL1A8KQxxFjjA/KSY+KqaZOmB6d3LD/Pl3rMuMxuo3x
         sGCcdrGkbdNYjnKD/T6qYm5SVcD0UAT8dHjouwt83j4DfbrZkZfKp2p6IVuQcenLr7hB
         kG681C+JY/4xwdm90Lk3TyiQYB4A5Q73twENVIJ/H/IAJ7ixYxPbiWZlmPupxjH0x+2W
         wACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OucdhFM6jmRjO7w+OrNatwgwUpKYYH6g9Yld4XK2Xmc=;
        b=Q0oB4fIuv7IyCSD4v3I5TaaRkxu5COFn5LdBE3LTqbhtBfiXttZxSgPrmbr/qfVaY3
         3d0dMqq9SmO8CjIfeRghG2N6k568jS8m+bxTykt7cgn4AmpsvBK/cNyeb2b+hE+vFVbT
         vQ2JkeyjVQtT3DprwwmuXJ1KFzZV8o1VkHLGJM+hj9B8vTTo2oWF2TvSwtE9srkDW4q2
         u2MKN2WOn+0D46ttC8geqN9pvTWTgNpUpQGk39vpExWn+hovjBbvpXQUjnqXa+FYWvro
         Md1Ogtngm+DjA2i6SojLw1/kxpWxICWn6EKWjBTMX7jmBzZieW7Kikh5nRTivueQ+AWi
         4jaw==
X-Gm-Message-State: AOAM531OtRJeZ0w5lCKJrRnXZw1rDPzm1Zd6pqtrhGtBZKJVrp1u7CSS
        wtjNbjNjrPW6kJJ3IerFI+W0RA==
X-Google-Smtp-Source: ABdhPJzwHX4zS4POTMojF63lfj+cMn0gL12hekHszIWUXM6zc+DtvhI8YpaygfUI77VoNFID8vpetw==
X-Received: by 2002:a05:651c:994:: with SMTP id b20mr291726ljq.70.1641834276991;
        Mon, 10 Jan 2022 09:04:36 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id y7sm1079782lfb.272.2022.01.10.09.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 09:04:36 -0800 (PST)
Message-ID: <0f7d5c44-2119-97ba-5a3e-7f0f40d41605@cogentembedded.com>
Date:   Mon, 10 Jan 2022 20:04:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3] iio: st_sensors: don't always auto-enable I2C and SPI
 interface drivers
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220110152432.3799227-1-nikita.yoush@cogentembedded.com>
 <YdxWZEz1GXXxQ+7h@smile.fi.intel.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <YdxWZEz1GXXxQ+7h@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



10.01.2022 18:53, Andy Shevchenko wrote:
> On Mon, Jan 10, 2022 at 06:24:32PM +0300, Nikita Yushchenko wrote:
>> This patch makes I2C and SPI interface drivers for STMicroelectronics
>> sensor chips individually selectable via Kconfig.
>>
>> The default is kept unchanged - I2C and SPI interface drivers are still
>> selected by default if the corresponding bus support is available.
>>
>> However, the patch makes it possible to explicitly disable drivers
>> that are not needed for a particular target.
> 
> ...
> 
> The same question as per v2.
> 
>> +	default I2C && IIO_ST_ACCEL_3AXIS
> 
> What will be the results when I2C=y and the second ones =m?

$ grep CONFIG_I2C= .config
CONFIG_I2C=y
$ grep IIO_ST_ACCEL .config
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
# CONFIG_IIO_ST_ACCEL_SPI_3AXIS is not set

$ vim .config
<remove CONFIG_IIO_ST_ACCEL_I2C_3AXIS line>
$ grep IIO_ST_ACCEL .config
CONFIG_IIO_ST_ACCEL_3AXIS=m
# CONFIG_IIO_ST_ACCEL_SPI_3AXIS is not set

$ make menuconfig
<immediately exit>

$ grep IIO_ST_ACCEL .config
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
# CONFIG_IIO_ST_ACCEL_SPI_3AXIS is not set

CONFIG_IIO_ST_ACCEL_I2C_3AXIS was set to =m by default. I believe this is correct behavior.

Nikita
