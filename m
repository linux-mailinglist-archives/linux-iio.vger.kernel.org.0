Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C452B6F40
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 20:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKQTsN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 14:48:13 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35517 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgKQTsN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 14:48:13 -0500
Received: by mail-ej1-f68.google.com with SMTP id f23so31192403ejk.2;
        Tue, 17 Nov 2020 11:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZEbq9Ojyeaz+AjZfTkCv1Ig5gfub3rl1Ykya58LSZgw=;
        b=kblwmpH/d4BRR4TXOrDTIOkat3IBleus4vQt/tzVsh+P/t8gM9U6QW4OsV5H2eAxgm
         OIJzSTwoUgZxNaPhj7Rqe/M9LVczhSPejUjLsY0pDbvQlYIWto9eB4GyrPwXr2ChI+rP
         LLY6+9urEhMwJfrFKEwnjfTQLC3TJKeBiQmDJR1WSGnLT/KotBUHSDT/vBBPjB7j7XYJ
         2HC372q/+UTXhkTrWgN/G3vADOmxeUesl7t55jN9U9YmJNuc+SkS4lGFNNHr1qzb7ysf
         7cZBl+2BHw2GRrQUpLPLiMo7rrZlz350UXq2vpkMybGXMNXZcZhy2rwsl1cl/ANpKiBN
         jh1w==
X-Gm-Message-State: AOAM530KaWmDUPm2IjUM25Mu6HeA0L5mX4wZCRSMNU9HqEVcA+hc4qD+
        CryeJjC6pzZyZgd8bX1Um7E=
X-Google-Smtp-Source: ABdhPJxVO0lwKr/2PxvftzpZdJk6UEgx6GvaGNlD2+CKJQ2vAMd4kMW2WRjEtE/wjVnikuloWhMZpQ==
X-Received: by 2002:a17:906:2313:: with SMTP id l19mr19150100eja.443.1605642491025;
        Tue, 17 Nov 2020 11:48:11 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id cz14sm12375671edb.46.2020.11.17.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:48:10 -0800 (PST)
Date:   Tue, 17 Nov 2020 20:48:08 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 8/9] arm64: dts: exynos: Drop incorrect use of
 io-channel-ranges property.
Message-ID: <20201117194808.GD108045@kozik-lap>
References: <20201115192951.1073632-1-jic23@kernel.org>
 <20201115192951.1073632-9-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201115192951.1073632-9-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 15, 2020 at 07:29:50PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This property is for consumers of io-channels. Here it is used in
> providers of those channels.
> 
> Note dt_schema will currently flag this as an error due to a dependency
> between this property and io-channels.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 1 -
>  arch/arm64/boot/dts/exynos/exynos7.dtsi    | 1 -
>  2 files changed, 2 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

