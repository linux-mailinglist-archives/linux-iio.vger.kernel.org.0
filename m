Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE731AF3FE
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 20:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgDRS6h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 14:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726086AbgDRS6h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2020 14:58:37 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CA3C061A0C;
        Sat, 18 Apr 2020 11:58:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z26so5535929ljz.11;
        Sat, 18 Apr 2020 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dj6gxh78iTr/nqo+x5cdc1Pc/5Q+3/7zF1q1lmk/SYA=;
        b=eHE56v2FPZyj2jphYl8E5RUXUJLL0WrGR/hZhiXOIKhKo4jp/HZAPu6q0iVpGwSU+H
         cYbwCbiOx13wXtq867i4fCiLZfbfdlqTzCQCdKzcYyeJiUWNztZHDE+ZIDbcGCceGs9t
         2kwwvLdFn7Hezol1gB/XucCgYk2sgjh80/8Z4NKbBGeX11ys5lxPr07yLHNt5pU0N6Qo
         tukMhTvY0yv2iXKPmuCW+IHk0uihJVXylhFieyVNielcggh/M7HYQJN4vLfF06Tttvp7
         p/BD+sljquTqef/mERfsEbpiSUYDlnRj4sZspaMK0MJtNZTjhgEQ1Bz10g7Etpg3Yz6g
         1JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dj6gxh78iTr/nqo+x5cdc1Pc/5Q+3/7zF1q1lmk/SYA=;
        b=jKOda6nZHddaKt3DPR2Q1qbMWIpJwbixISsRyjH/ly1Vs1QLgVl61BtLttMrUT1FOt
         xrrle8C07bpE+JPLvBm8wvjuKfP+N8MtMC5FfQ8JZF9gON4EeiM4JFY/FZBhgwIQm6PM
         EWwq4+nu4vcr0XuV9EusxEcVremSnWtzPD6G4NGt5s7FGutJOoZYll2yaMp/Nab6GDi2
         4hjiQDkna/d7jeGFv/IdhKzWQnk1VQ3V8rmDVNWhUlgqQgz/R6rOyo0hWtGWEzLTHl+i
         1mPuPfnz6Fx/fO+MDV+rwOJdNaXjbfGfDrYu7slAsBr9/taBfHXdZNfs6UUmCwMVRLOU
         sr/Q==
X-Gm-Message-State: AGi0PuYOGmCBYvxyfKs/Ek2Ybxo/PJCMqpaBJ262NKfThOz2ZjgDfK83
        CmVVXb/7l35/o2SDpcnLU6QMeVcr
X-Google-Smtp-Source: APiQypKJ5eOYQAgEg46LJSr0ViweR75vxySLSUaWfBVZQugcY5w2kqBMQA6ltWrtGVxfxti9xurM6g==
X-Received: by 2002:a2e:8954:: with SMTP id b20mr5173635ljk.176.1587236314241;
        Sat, 18 Apr 2020 11:58:34 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id l7sm22390675lfg.79.2020.04.18.11.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 11:58:33 -0700 (PDT)
Subject: Re: [PATCH v3] iio: magnetometer: ak8974: Silence deferred-probe
 error
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200418171244.2320-1-digetx@gmail.com>
 <20200418192145.57fa291b@archlinux>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <92c2e6d7-8085-b448-f789-9ceecb6a4f74@gmail.com>
Date:   Sat, 18 Apr 2020 21:58:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418192145.57fa291b@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

18.04.2020 21:21, Jonathan Cameron пишет:
> On Sat, 18 Apr 2020 20:12:44 +0300
> Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> It's not uncommon that voltage regulator becomes available later during
>> kernel's boot process. This patch adds info message about unavailable
>> regulators in a case of the deferred-probe error and also amends the
>> error message with a error code.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to play with it.

Awesome, thank you :)
