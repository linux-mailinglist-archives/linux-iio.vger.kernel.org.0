Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6BB495700
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jan 2022 00:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348025AbiATXdS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jan 2022 18:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347893AbiATXdR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jan 2022 18:33:17 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF470C061401
        for <linux-iio@vger.kernel.org>; Thu, 20 Jan 2022 15:33:16 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e9so3158136pgn.4
        for <linux-iio@vger.kernel.org>; Thu, 20 Jan 2022 15:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6MVnd0IKMjHWYEmmxJTDcJXHRZaug6BXKl0q4y+4uMI=;
        b=M9ya/H2QbKv+DT6FgaakqIC7dPcTc7oBL8mueaQ0XgNOxObwAaAKgcB0lyUZLXBG7u
         KI3aBLqztwvYNviAd8c3qHAA2Ci7JceCJf/EeToAOEi1/gmk55Vz6LuYrtq83sfONgnA
         2zL8A2asbnOXokDvljLlJqjWxiODlniiTpBhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6MVnd0IKMjHWYEmmxJTDcJXHRZaug6BXKl0q4y+4uMI=;
        b=v+Wwf3zHFdognH3FfYmrSJoN30ghVNjqhcICv0+51Tz0rgMvYuC7bS9Ob3Qoulx+R6
         wIZaUNka0VUZO8fykScxpCerrqunivzwOymUFfe+z+ezpI+cpHk7UFDxPMR8OII8PnO5
         DfzNFJQdO3ho4A8g4HLCtNHNVe5RZOhXdMAuOiD10D9dt9a48PehpXnIboUVrLe3zAja
         9vdbG7EAAJMk8AjbLpMeMw3CA88QghF8/boFeVI5YwRw4SnEnKXU2j3laNAhIqvsCGiA
         WfQ3XuRb8l3VkMAsf+14JjgZd9ubYheqFabrmrLbPSFkhT/WZtaPs42+r/hAhKkAcwuu
         7eew==
X-Gm-Message-State: AOAM533xLBdHXtzDx4H/9SmhWRCFcjFxrNwnsThbXKFXIwRKXbyvTMDL
        iWa3B09pFhphksOOeQX/PrMTLw==
X-Google-Smtp-Source: ABdhPJwASg0kPCe1MkR2JePEm9F4SawZKuWOOIcp69MU41InM7haztXd7PayUp+v6dppVLa6KqOrYg==
X-Received: by 2002:a65:5a8c:: with SMTP id c12mr923567pgt.54.1642721596146;
        Thu, 20 Jan 2022 15:33:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bt6sm5274341pjb.3.2022.01.20.15.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:33:15 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:33:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iio: hw_consumer: Use struct_size() helper in
 kzalloc()
Message-ID: <202201201532.1F9C5BD@keescook>
References: <20220120225243.GA37225@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120225243.GA37225@embeddedor>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 20, 2022 at 04:52:43PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/iio/buffer/industrialio-hw-consumer.c:63:23: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
