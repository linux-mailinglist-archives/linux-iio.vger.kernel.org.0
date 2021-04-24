Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA07369EEB
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 07:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhDXE6w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 00:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhDXE6w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Apr 2021 00:58:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB2FC061574;
        Fri, 23 Apr 2021 21:58:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y4so40318760lfl.10;
        Fri, 23 Apr 2021 21:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a/RO6+FvE3kXQ+8npkkEY+xEAPWUQZ6kpW2OWxzDF7w=;
        b=T8Br2P6B9akN5tV8qbEolTp6pdmIa/h7nfHSMpxrK5pc3lUU8tsi1bzmtT+6EDFSO7
         oQyq1ZxWV0ohcbSUP8Zn6c6Hy9dbJj3Nr/+Ph01TcTyvFBsMZ2KYfRcEepijRFkUmZ6r
         //Owc1euvC0OfC/0cjl4zCbJSmqQjEI9RI+b/5b6gJ67MM/knKqZDL+rlSLqCYZljsUz
         3m4SET1CHF9OUqs0/7kKjSnAiebuojsLpHX1w8R2Af+ErjLdWfHQx8MzpBzbXQqc5hF3
         FGzfuhPrxalZHwVveIjfroOnRdFtcLx9M8fWS9yr/EEbEo30ONptDpcsy/FaXqGnn+h9
         92xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a/RO6+FvE3kXQ+8npkkEY+xEAPWUQZ6kpW2OWxzDF7w=;
        b=Av/v9ZIUuXhCyhTz+e8s5TjGaQ0CEIOOtw+FMWr4qhNUf8Vr+dvNSXMUHD8wjMKtfd
         vICo16XWW/yD6SIX2VFo42tQJgUskw7XppNJinMEgoKkZdaYs+/TR4LErY/oLG+/ll2I
         WE7swfkvuLAGr9S7rQo0D2FYLTNvUfCcVtWqMNJdKgnt/lP2XV450+MJBcRPUIXOD7k3
         K793+TKlKw0Tk/T+ZENeBmAocG4kezdmLcEDQ87/yM+yA8YQ/x1l/oz7IOzLe+CgeGgd
         ZSkNsjSxDO7rnw/bw29nFre1BFzI3FfrtsZdvJkC2AkiFRNMcwwbGZiSieg7TNgKmWX3
         BAog==
X-Gm-Message-State: AOAM530vc3SGknqZ9ZHxIFMl2XJMJqVvBD/pN+cs+kBNiup+TDR/dE5S
        7AZ5kOXLNXUgMuIU3kcmd58sezdoihM=
X-Google-Smtp-Source: ABdhPJwMZcy+121C4CMY16Kpzu9tInro2H9NFAapjK8Hti8rdjBpMxbTCIvr1N1bMEYE6Omlv/ZpRQ==
X-Received: by 2002:a05:6512:110f:: with SMTP id l15mr4981027lfg.258.1619240289347;
        Fri, 23 Apr 2021 21:58:09 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.googlemail.com with ESMTPSA id x3sm740012ljm.90.2021.04.23.21.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 21:58:08 -0700 (PDT)
Subject: Re: [PATCH v3] iio: gyro: mpu3050: Fix reported temperature value
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210423020959.5023-1-digetx@gmail.com>
 <BL0PR12MB5011563BCD5E11683D51F34EC4459@BL0PR12MB5011.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <edd85a7f-4c1f-9d2f-0425-93a6e45f13bb@gmail.com>
Date:   Sat, 24 Apr 2021 07:58:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BL0PR12MB5011563BCD5E11683D51F34EC4459@BL0PR12MB5011.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

23.04.2021 13:14, Jean-Baptiste Maneyrol пишет:
> Hello,
> 
> thanks for this work.
> 
> Temperature value should obviously be 16 bits signed, thanks for the fix. By looking at our internal datasheets, I can confirm the values for MPU-30x0 family (div by 280 and 23000 offset LSB).
> 
> I'm sorry I don't have access to these more than 1 decade old chips, so I cannot test on my side. But there is no reason it wouldn't be OK.
> 
> Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Thank you very much for confirming that the equation is correct, very
appreciate that.
