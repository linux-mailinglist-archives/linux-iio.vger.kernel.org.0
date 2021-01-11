Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4646A2F220F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jan 2021 22:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbhAKVns (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 16:43:48 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:44556 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbhAKVns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 16:43:48 -0500
Received: by mail-ot1-f42.google.com with SMTP id r9so293595otk.11;
        Mon, 11 Jan 2021 13:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fcKIaMcxU0OWXFBkioaDQeX7jenRmoDB3irHUsMxURA=;
        b=JWvqwn5VPdU19ZYfR6tG5hjJJSxdcV6xjJUeEyJSq+Y00JwO4FNBFCPagMuvnnXuGf
         d/5dY9GUwuaJVhnqC9Vdpq4qxET2nsoPjVHAwMgUELpk0Y0HAU599YkEzgIW/CmXnMr4
         Q9XBOZ7+zTaJAO2JTXTRyVEiN+RFfVHH5CSKX+2dDDhXxdekT7W2jcdDFaTBjj4FVe7+
         sg5NJ84yxaEfNXmjfACUsQt7Ev5S0BpjsiD222x/+zTCD4eM466+BYtsvg2XnKnaQIWH
         y5JdoVc8ZWjj7Nz0jeQLTH+M5rVWmIk6eFcC8IuP5QQfv5biFEzy2zzA+cVhhPHcB5re
         hzOQ==
X-Gm-Message-State: AOAM5327dWAeHXW/bMPXm8XSQhPSrWiydCMQ/9t0JpQlDbOJwZT88mw0
        bErZOmla+V5UMpgS5CXazQ==
X-Google-Smtp-Source: ABdhPJyYI51KqJz7W16K5WDJ9i+R3iN8MezEC8aloxZARmyuXU0D8VPWNoa4qiG0wu8bGaBW5/x+qA==
X-Received: by 2002:a9d:27e9:: with SMTP id c96mr740169otb.15.1610401387204;
        Mon, 11 Jan 2021 13:43:07 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g92sm209205otb.66.2021.01.11.13.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:43:06 -0800 (PST)
Received: (nullmailer pid 3111033 invoked by uid 1000);
        Mon, 11 Jan 2021 21:43:05 -0000
Date:   Mon, 11 Jan 2021 15:43:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings:iio:health:ti,afe4404: Fix wrong compatible
 value.
Message-ID: <20210111214305.GA3110985@robh.at.kernel.org>
References: <20201230121919.238335-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230121919.238335-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Dec 2020 12:19:19 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Cut and paste error.
> 
> Documentation/devicetree/bindings/iio/health/ti,afe4403.example.dt.yaml:
> heart_mon@0: 'spi-max-frequency' does not match any of the regexes:
> 'pinctrl-[0-9]+'
> 
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: f494151b5eba ("dt-bindings:iio:health:ti,afe4404: txt to yaml conversion")
> ---
>  Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
