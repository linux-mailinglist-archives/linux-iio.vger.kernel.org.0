Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F764412D97
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 05:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhIUD5s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 23:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhIUD5s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 23:57:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5B3C061574;
        Mon, 20 Sep 2021 20:56:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n2so9868265plk.12;
        Mon, 20 Sep 2021 20:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zJAWbTbtyiVV7uOo+mDsm9uo2qLj5KO+w6YsLxdV8aI=;
        b=FxcYVqAUIlVaXwkVdmoTb5l/ygAZat1eAaluc8hm4gzd+OUag0eLCroJoW2+c1knpw
         WOXh1MGDVDPPgcaE2iyqZKPrqgEU+PNBu5XjbDaheO2KzhcA+OjXa3Gae5ee8+k8X6fB
         EWxQC3sfSsZuBzUY3JVVvcB5QZxX7UTssS3h+NZMbNo3Bz8oKjWbf6bVEkK47LFW7HJV
         9nyXfzsj+boVApAMZtl5et2wYSsRJLVOPDr+JVfktO+qlfjd5QM2bg+/JF1OTQIkDsD7
         NztHuPrFVxM9QztX+41w9R024nAHJglb9sGgVyySrH/D6zc1KEqYahciAH/Ex8XsfgDl
         shcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJAWbTbtyiVV7uOo+mDsm9uo2qLj5KO+w6YsLxdV8aI=;
        b=4TWpeCp5eGHPOB6ShE84Dh+ITqgG1Fzbp8E9jMtwHFkLOmh6lNAgoVc7NAhiwcKumg
         c6l1TALtFl4YLj399n+oMhS4EBjHhCIP70RPhfOD+NaaUIOtnR9Gp8hjNlI1oiBRx55G
         YFGlvnORt7IfbH7tH710jP9PkpYHbHxDizL+gzyCcEGHdoaFU0ey1bd2KklVRaIdJFuO
         RYvErKWWqr6STSwoFFtF4Y8OI6wq4FUnb5DYgCC9Qa99f0fzVq68PcHUsgwcmIj8XcKi
         lullh/U+++t/8uagfvbBStkHVXZuTMFI2PelB5FZvocShK15iHqmkHQisTHNfkF06gRY
         IXMg==
X-Gm-Message-State: AOAM532HskzSEzjBhVIBj+qFlSM2gp6GcNy8E/W8KiuCopiWYJqWPVZR
        5bdhsn1GKg8oQaSZwslPGkk=
X-Google-Smtp-Source: ABdhPJxc3C0sxwrmvyzi9MgS2eb4xLRPFICQZTt6QY2qCsl5IT8HsUT04X4kmYaPpgkJyZyYmvcEcA==
X-Received: by 2002:a17:90a:53:: with SMTP id 19mr2736128pjb.159.1632196580034;
        Mon, 20 Sep 2021 20:56:20 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a5b4:f272:6a63:5b57])
        by smtp.gmail.com with ESMTPSA id z190sm563345pgz.35.2021.09.20.20.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 20:56:19 -0700 (PDT)
Date:   Mon, 20 Sep 2021 20:56:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 05/47] dt-bindings: touchscreen: ti,am3359-tsc: Remove
 deprecated text file
Message-ID: <YUlX4DE59z1Lhfj4@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
 <20210915155908.476767-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915155908.476767-6-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 15, 2021 at 05:58:26PM +0200, Miquel Raynal wrote:
> Now that the three hardware peaces described in this file have been
> translated in yaml in 3 dedicated files (MFD, touchscreen controller and
> ADC) it is time to remove this text file.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Rob Herring <robh@kernel.org>

I expect this will be merged through MFD tree with the rest of the
patches, so

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
