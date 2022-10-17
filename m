Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062E36006B8
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 08:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJQGaU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 02:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiJQGaT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 02:30:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDAB3134E
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 23:30:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b2so15988228lfp.6
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b09P+MxFZecGyxS3ZeNm5VKWma2gzdq3aWfTA35sKf4=;
        b=Upw3iMknJuuqgRJX2Taz1CWUYYh47ZMf87RKclrbkTAfm3zFwcwmpMaj1PO2SvCeRU
         hbHK1T+L47f3gIsuJOh3uClXStyceIbpxudAG54v2bq8SHdzGARs+BXRrq4i5fDu2x5m
         VnC+6pNV9PKNiw723Kwgu8MxNsH0z8lfYYt2hv2gKNedhpJtVrMstthBkqV3E7x4T9P7
         EVLiTGlTzQYvY5rvzP1cP1WqkwzuEQKUdYsQtQ3CY+BVsi0YYo/3Uqg1eHuQBcQL6AeT
         8452PLTmHp2x5r4zxoDGXQyIM3cI7p0U+lt9beP171Tkrfc4g1E6v2jTIuJYyPhdgVwJ
         Pw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b09P+MxFZecGyxS3ZeNm5VKWma2gzdq3aWfTA35sKf4=;
        b=JUOute0IvY7o8YNZlsDzNZPakuQwOSfadsOKGuy5G4fGiif43LO1FlqlwEXO22FDv4
         JmNLJVcvXlFFY7luq4r6wMuGB7JTBSFmyd49QBoZrS2eHQUrzaI3I05/2k+Q4GmY7us5
         kN23zTyrjVy98EeEBMaFUtJ0Bk0owaLLlrULqkTnqiiT4FHGChPVfPXpEQFFTsWZbiCF
         sQRp9p5/JEWgGRUIkhqcvkccpSJNFAQYXcLmWUIkFt/LbzuBZki2rfR0362M0mibWWWx
         adn1nQX1norqQaZLzM4G5kHP1AFtnKxlajq6Qxcc5Mipqm7no6W0kOCogEhcyTiXmMOC
         3UsQ==
X-Gm-Message-State: ACrzQf0WfhiLr9+YwBcLYPhqo3NLl2oujARHFTAOWufn46Jyhr+xRuI8
        WFaXcaYIMehr/Si0Ann3GX4=
X-Google-Smtp-Source: AMsMyM7yP3MRYessBmblfOzL/R4wN9yer9VLwjwW//N2c7GnYWJi7S/2aL9zEhdZv+Zp7KrkmHJmgg==
X-Received: by 2002:a05:6512:318d:b0:4a2:515c:6195 with SMTP id i13-20020a056512318d00b004a2515c6195mr3148369lfe.249.1665988213842;
        Sun, 16 Oct 2022 23:30:13 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512214c00b0048b3926351bsm1308631lfr.56.2022.10.16.23.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 23:30:13 -0700 (PDT)
Message-ID: <b6427817-6b44-c3c6-1e6d-4472e3eb066a@gmail.com>
Date:   Mon, 17 Oct 2022 09:30:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 14/14] iio: pressure: ms5611: Switch to fully devm_
 managed registration.
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20221016163409.320197-1-jic23@kernel.org>
 <20221016163409.320197-15-jic23@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221016163409.320197-15-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/16/22 19:34, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> All the remaining calls in probe() have devm_ equivalents so
> switching to those allows the remove() callbacks to be deleted.
> No functional change.

Right :) So please ignore my last comment in the patch 13/14 :) The one 
concerning the commit message is still valid though :)

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomasz Duszynski <tduszyns@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/pressure/ms5611.h      |  1 -
>   drivers/iio/pressure/ms5611_core.c | 17 +++--------------
>   drivers/iio/pressure/ms5611_i2c.c  |  6 ------
>   drivers/iio/pressure/ms5611_spi.c  |  6 ------
>   4 files changed, 3 insertions(+), 27 deletions(-)
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

