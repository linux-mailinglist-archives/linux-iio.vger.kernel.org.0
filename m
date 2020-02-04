Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449E1151D04
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 16:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgBDPRS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 10:17:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37473 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgBDPRS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2020 10:17:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id v17so19016124ljg.4
        for <linux-iio@vger.kernel.org>; Tue, 04 Feb 2020 07:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mx2UZUbrwhk7SJ+dNmWSVpU641I9lVVGne+Y/UBRlrc=;
        b=AKEjN2e8z8rAFB8f2YWE31wm4/h0ks/W9atOZJdlrjuNXW4WqjTtmzNPlIVMbef6x+
         LG/w+KKSjLujoKsnq6QbmmU3iLBsGXJOQX1oc41++7f75YCmzEyEEYEVc2dlXWegYKij
         6fMT2ODIFseLhTN+rqvNlk14S9+3DEajpUniocS7ysqJWBFGm3lSm0bhZdrnC8jNgXMs
         MDkJQfusTHpE3MXFlLnL78Ii2yquvUldAUWr7tpyRQpiwXiGST6S2v9f/wT9W63XgQKn
         W7NtjyFpGefXhyxxaI/GgfrxLmjGD0Cl7246aperPBQuBkix0lpVVSrnnlKktiebJmkx
         vrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mx2UZUbrwhk7SJ+dNmWSVpU641I9lVVGne+Y/UBRlrc=;
        b=LvJU822/6UWAjFuvW6u0PBR99H3ULjmHA4AnjedUoQcrCekIcELDH6JWxcU1IV6T0t
         HdSVRUDzNCuDtu/1IxCFHdvWvnB4NRsxMl24ciLJExKZS4XfzQjDQP0TuB8jmSQvXztp
         oYliZKY0F/fqCedm76N12cIpzVJCE8aAA2uBCeREWoxGA+hW6TOvywedE2tyUVpl8hvH
         6CiZfmgxd9AQy+eOxWazZXuEUbfZCgAaniSOZIIfmB9sSK01D74HYB+dFX7VOiIiO3Ie
         spy+pPJFGGJ9Yt6WoRMHYjXLwNmOaBblv426MpYFCBKjWHAZugtPYfok4glCok/FHt+6
         tpzg==
X-Gm-Message-State: APjAAAVOyPg0GLOFANiTNt29YShAINs0zITyCJ3s6tO2XuA09imkZeNA
        32ftUA2mA/iP/kqeNBlEFKKBFDeN
X-Google-Smtp-Source: APXvYqxnjDObd0XxrBkdItvImSFq1DdAWxMCISWkhN3kyszMm1sPrs7Oo+GAwMO+4/KsPmOSGiOlmg==
X-Received: by 2002:a05:651c:3c4:: with SMTP id f4mr17116564ljp.5.1580829435971;
        Tue, 04 Feb 2020 07:17:15 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id h10sm11617026ljc.39.2020.02.04.07.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 07:17:15 -0800 (PST)
Subject: Re: [PATCH v4 4/7] iio: light: add Dyna-Image AL3010 driver
To:     David Heidelberg <david@ixit.cz>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org
References: <20200204093031.616409-1-david@ixit.cz>
 <20200204093031.616409-5-david@ixit.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c565be90-6560-9aa9-15b7-64be440c68ea@gmail.com>
Date:   Tue, 4 Feb 2020 18:17:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200204093031.616409-5-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

04.02.2020 12:30, David Heidelberg пишет:
> Based on:
> - 3320A in-kernel driver
> - https://www.spinics.net/lists/linux-iio/msg25145.html
> - https://lore.kernel.org/patchwork/patch/684179/
> 
> I decided to keep it aside of AL3320A due to different approach and much
> simpler design of 3010.
> 
> Tested on Nexus 7 2012 (grouper/tilapia).
> 
> Tested-by: David Heidelberg <david@ixit.cz>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Yours signed-off-by tag is duplicated.

> 
> v4:
> - SQUASHed: iio: light: al3010 implement suspend support
> - switched from _remove to devm_add_action_or_reset
> - implement bitfields FIELD_PREP & FIELD_GET, no functionality change
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

> ---

  ^^^

It's more preferred to put the change log under the ---, that way it
won't end up in the commit's message and patch will still apply because
everything in between of --- and the diff is ignored by the `git am`.

...
> +
> +#define AL3010_GAIN_MASK		(BIT(6) | BIT(5) | BIT(4))

What about to use GENMASK macro here:

#define AL3010_GAIN_MASK		GENMASK(6, 4))
