Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6471E1EAA
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgEZJe7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgEZJe5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 05:34:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B01C08C5C1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 02:34:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u12so2549040wmd.3
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uIfXKUCbDucsPOYpYgkjOAmRdJUZDObk3f5/C3vKFFQ=;
        b=oLg3EzO5sInVvZZNdMUReY1VU37G5NrZ3kBSjpnme2iHn/mLV/BmxA0Mo0n0GfZf/n
         lj+UYmqPYbPByclPic5/sFkZ/kokkxdJvkdDu87bglSe6+DoLTbQBunk1n5bfEbv0snV
         xx9+mvNp1yASRai5BFwtpx5FG4W6kk8iaoY6AB/T46B9iZyEvpeh33OILv4HJ+xVhzv4
         XRqO1XWRBCSxRsyl2lxztWFsVJlASL64oNxnEfnSM+Pa9yM/z/zx35H9sS2jj4+PaHfA
         EZXMEIoqDNyIu9rCt3OkBrRR4qN4VCvhxiKAeb8xH1fijdU1ByRTg3XrxqkA8YLKH9xQ
         MzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uIfXKUCbDucsPOYpYgkjOAmRdJUZDObk3f5/C3vKFFQ=;
        b=X9YCTse2qi8vdxcNgxW+tZ513jOc+ZOz/MZZ1P0h6YrEW0pwP1toeBmF61AUAwkwml
         QYFL4JTUw4YJ4VGvoCRJbEhrpw79AxXA5JDie76TlAmE+7j83SKUOEAXmPHR0nezWofB
         Yu5a0oiLjOmE2Bto9P0cYkkD8PudYr6tEu95k87X6vnX/bAl9r9EBxR4iD7XuLS0BKJf
         DiaTz1KEFqNsvZHvr9RsvpzgzTtNxvLEXjf1fd9PaRZ3bOBy1AvdKEEaaEFtjeoFuZ/m
         FoIhhcTt//P7EtKI101XkffroLzD8bz64tjUTcg2BWH2KRjwNF35RiXzynKjN4tXWQNt
         WfgQ==
X-Gm-Message-State: AOAM5319VVNqmFWUPPeB7WHf9ZS9kYnjJIuszqpRZz/InH+BH5Tzc7Ta
        cvRHU+cYrWC4yqwCoBXURftKww==
X-Google-Smtp-Source: ABdhPJzrrxB7FkN/xp0+nIBota9X6mJMdDJrXBjQdIa6PiqyON/o1c2F/P0fkO+zgSyNBPJ1/c0myw==
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr618021wme.26.1590485694696;
        Tue, 26 May 2020 02:34:54 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id x18sm21533655wru.72.2020.05.26.02.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 02:34:54 -0700 (PDT)
Date:   Tue, 26 May 2020 10:34:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v12 0/6] Add battery charger driver support for MP2629
Message-ID: <20200526093450.GM3628@dell>
References: <20200526090646.25827-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526090646.25827-1-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 May 2020, Saravanan Sekar wrote:

> changes in v12:
>  - added SOB Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Looks like you added my Acked-by to every patch, when actually I only
Acked the MFD one.  Fortunately, as I'm the one applying these, I can
strip them off, but please be more careful about which *-bys you apply
to which patches in the future.

> changes in v11:
>  - module_remove part replaced by devm_add_action_or_reset in charger patch
>  - minor review comments solved in mfd and adc patch
> 
> I expect, that Lee will provide an immutable branch for me and
> Jonathan once the MFD bits have been reviewed. Please tell me,
> if I should prepare one instead.

I'll do this now.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
