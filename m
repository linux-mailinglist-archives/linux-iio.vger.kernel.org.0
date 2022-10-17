Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE00600689
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 08:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiJQGDk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 02:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJQGDf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 02:03:35 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015FC4F19D
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 23:03:31 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j23so12683951lji.8
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 23:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXGeK4kOEGRDTgJ6BHkW1iNNePyOrNftflG7B4aTcyk=;
        b=cLnJfnlPlHAgRboRg23Sd2gPuw3kEbpVnoONNtpUAOFRXFF3A8yFkvAA0MZxYCojfi
         SlBV3DMaQ/VVZoexfeYTufinvLDm3F9tRuYfDaxplAP/mJq6/AygIXlUjIt3opXmjiWH
         tS31a51zQSXfaXFcm5nLdIUepr0HQzu3me9XxgdoHP/waO/rcfcUcbNLGipZKNsMRzDd
         ND9bRzAw4DH0Zby0lAHfFnBvDy2cOiSltGG2Cu7myXEBQLLtZzgyNPKpGO14NPnnmhYs
         L7jqHbqN52sIsR5c+Sc/+tDE6xsP/oChB8JDfgnYNlIhYOzU6N0iRE9FjGBa1ola38VQ
         ywIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXGeK4kOEGRDTgJ6BHkW1iNNePyOrNftflG7B4aTcyk=;
        b=r56UOrIUZu//v7qPODxro9JOLIhqZyhtTMX/VxmAuu8zIpXopmZMr965zvY4WmRQ5E
         +6qGUpHPGGHvBQ/byYWRVv9+/IWTQe+VDxdlxaSjVfC08R7SsZ2iSCNuR9A17Oy29fmo
         n+qF2tMZR9vBeVJfiKeYvG2k64Gu0kINIRrEq0nrCJl+6U+EnYDDk7g2etBG+DOGN4Yw
         m+A9ftYEK5pnUP1JiAsbdL1ZWWycPXjsH8AffTMMaO5MOnhqlwYt3kpOTp4HVIJ3Uvcj
         orWhEweLnVQs82AX/GWs9uu4LrJycgao/Zs9xdpE/CCUw0OdrHL5xIMU8LC4VikI9ECc
         KD+g==
X-Gm-Message-State: ACrzQf2BENUsKLSAEk6dR00hxltIIBF5XLoi84BDK/vbM6hHZZIi+KM7
        TK6WtiswEZPp+yRjapddzpI=
X-Google-Smtp-Source: AMsMyM5xNSERDQuZB4/8tL92j+a/K624oPWxvoGt0t+EztdNiQCRKHbdZcZxWuqQhk91IglFLxCTEw==
X-Received: by 2002:a2e:1606:0:b0:26e:54a:ddca with SMTP id w6-20020a2e1606000000b0026e054addcamr3628747ljd.478.1665986610357;
        Sun, 16 Oct 2022 23:03:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id b17-20020a2eb911000000b0026dd0ee72d1sm1361647ljb.72.2022.10.16.23.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 23:03:29 -0700 (PDT)
Message-ID: <d1d2e1db-a92d-9c6a-0378-433a8a4d70f3@gmail.com>
Date:   Mon, 17 Oct 2022 09:03:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 10/14] iio: light: ltr501: Use
 devm_regulator_bulk_get_enable()
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
 <20221016163409.320197-11-jic23@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221016163409.320197-11-jic23@kernel.org>
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
> This driver only turns the power for some regulators on at probe and off
> via a custom devm_add_action_or_reset() callback. The new
> devm_regulator_bulk_get_enable() replaces all this boilerplate code.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/light/ltr501.c | 27 ++++-----------------------
>   1 file changed, 4 insertions(+), 23 deletions(-)
> 
-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

