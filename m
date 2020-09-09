Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01122636BF
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 21:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgIITnm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 15:43:42 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38348 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITnk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 15:43:40 -0400
Received: by mail-ej1-f66.google.com with SMTP id i22so5289230eja.5;
        Wed, 09 Sep 2020 12:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GYrujSeHLlrIuqFch9Co1kvUCUdPKeLia6WoU1oQSBE=;
        b=PzxisdhuyGKwd1NF0wXCG8TZiNpTl/KT+E1P1mbcNrDTa6lc+7jTRB0/XR+CJP9Gsn
         51XUr7ewOpCpFcybyzVelCDpQ++22dYuKGSNy69tw5hWstwsbZ5hqZvoa2peDsfh6iZu
         T/a4CWOZUE7IYqTkEgQnXkhbosgwdqyuMhr5JT7rWdCV/PmZpnBKKf+uYtEBEViyEclt
         rTO7w+0nJRddHwPTg/CK2jsQ4BewdtU6JPIETgXTR63cl9G+ax1AOeUXhkbkATzzysgo
         6ii6Lh+vPoBOZVAxp2Z/xyq+uFG7+3MBbde9sSnXYiSowjtWUWqsBJQO6ngfFU4Ooc4L
         VKXQ==
X-Gm-Message-State: AOAM530RvkG3HXUkOwq0Z41oUwrLwdhkoCRml4LPs/J/8U/7yPTqYk77
        EZRcww5TDspiLbytWEMqxlQ=
X-Google-Smtp-Source: ABdhPJypFVYMywNXOVcZc2Z0ISwLTR57hTvYVWqB8kCnxxkMBCNZkwQ5wttH+UwTNdi5iMmd0d7plg==
X-Received: by 2002:a17:907:9ed:: with SMTP id ce13mr5081258ejc.180.1599680618145;
        Wed, 09 Sep 2020 12:43:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id z21sm3537912eja.72.2020.09.09.12.43.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Sep 2020 12:43:37 -0700 (PDT)
Date:   Wed, 9 Sep 2020 21:43:34 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/25] ARM: dts: s5pv210: add RTC 32 KHz clock in Aquilla
Message-ID: <20200909194334.GC21431@kozik-lap>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-11-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907161141.31034-11-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 06:11:26PM +0200, Krzysztof Kozlowski wrote:
> The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
> However there is no such clock provider but rather a regulator driver
> which registers the clock as a regulator.  This is an old driver which
> will not be updated so add a workaround - a fixed-clock to fill missing
> clock phandle reference in S3C RTC.
> 
> This fixes dtbs_check warnings:
> 
>   rtc@e2800000: clocks: [[2, 145]] is too short
>   rtc@e2800000: clock-names: ['rtc'] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-aquila.dts | 17 +++++++++++++++++

Applied 10-19.

Best regards,
Krzysztof

