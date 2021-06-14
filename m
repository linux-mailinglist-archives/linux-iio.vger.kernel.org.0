Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FBF3A62D4
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhFNLFi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbhFNLDZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 07:03:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CD9C061766;
        Mon, 14 Jun 2021 03:59:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso9133832wmc.1;
        Mon, 14 Jun 2021 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DInj5R/rNTKUYa5MmlypGH7NbsxUi8WQZHc0g/L+2II=;
        b=SwQMghAd2tiujUIYjjOvp2St1pgSPAKFzajBy3XPoY7fNrVZ590U1YGUyAN21Hz1cL
         jagwLJO0+b3MR23EDIrF3bn7fPHF9ZRk3l+E0MMXhRRbIP4YwolhSehmOKLjqsLsNeFf
         NWZqPO5ZVAmYshtaUVYWPJdHB4Rza9/16COhJdgrkApyZX5rP3sVUMv/ipICtQYwcOaQ
         UxfCNTpscEML7PfdTAbPrjmD93tZkHuJUaTc0b213oaenFiIo+s/F1mUG24M25s/m9rt
         8Spszo1L1buCA3TI3s8XLwbLj4R4BkXNgBuQkPVuGL1iUl9Mzp8AkqIw1NI2nNb6qTqC
         dd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DInj5R/rNTKUYa5MmlypGH7NbsxUi8WQZHc0g/L+2II=;
        b=NwuvvQuam49xGmZsgYqzZ51HoMhWYrw+RhyNykVxOg4/MfvDMzg3ZSfINrYtxgmTqR
         c3G+FBVVWywHs6lwsvk/odDuN1JoL/wDTXpYS3sUx8LTQFDHJsaOxbgSnxxSRk9P3NVC
         SEMRz+Mep6juwDQH7Pw0l+ytll16bmZgDxQLUuhwgCnjHkgMjFFkMiUd9+aYC/eqDNAz
         0iEXSYoxvXTLjKvo9S0pzkDiyOCmRPp8Ow1QhGhXCR0huzrv/Px9RebcnuuUubzQZEdw
         /TYJukdoXhTsEV0WpWSYvwi534gy120S4+uzMCMu5F9eASvOvbZLt3Nn2xHQvmAs1O6+
         Fzdw==
X-Gm-Message-State: AOAM533GgKGbMzg8REJZs7YDNzXRqIDKZ+uPuY7cFRjb5A+tnt/WOEwj
        qVTKyyLLNv8Xnxcb1gdNN2w=
X-Google-Smtp-Source: ABdhPJzqIhzR3eBera18ZhIQ2iXKOA2JCGNvCir3radAJRGDkjWiUqciaO4g9SLiNCcRpw1eSVm0/A==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr31924804wmg.19.1623668393533;
        Mon, 14 Jun 2021 03:59:53 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id h18sm8660772wrs.64.2021.06.14.03.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:59:53 -0700 (PDT)
Message-ID: <b4e88ed9da1afa4e0738bb04a72700271071f9b8.camel@gmail.com>
Subject: Re: [PATCH 1/7] iio: ep93xx: Prepare clock before using it
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Date:   Mon, 14 Jun 2021 12:59:52 +0200
In-Reply-To: <20210614115043.07ea0ae1@jic23-huawei>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
         <20210613233041.128961-2-alexander.sverdlin@gmail.com>
         <20210614115043.07ea0ae1@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan!

On Mon, 2021-06-14 at 11:50 +0100, Jonathan Cameron wrote:
> > ...
> > ep93xx-adc ep93xx-adc: Cannot enable clock
> > ep93xx-adc: probe of ep93xx-adc failed with error -108
> > 
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> From cover letter I'm assuming you want these to go through same route as
> the common clock conversion?  If not shout and I can pick this one up.

Thank you for the quick reply!
Yes, it makes sense to take the same route as the CCF conversion, I'll try it
first. Maybe I'll need to strip these stacktraces as well, I've
got the whole bunch of complaints on them...

-- 
Alexander Sverdlin.


