Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81A42A2B1
	for <lists+linux-iio@lfdr.de>; Tue, 12 Oct 2021 12:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhJLK6x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbhJLK6w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 06:58:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C738CC061570
        for <linux-iio@vger.kernel.org>; Tue, 12 Oct 2021 03:56:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o20so65475161wro.3
        for <linux-iio@vger.kernel.org>; Tue, 12 Oct 2021 03:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7IHQW+klBLa8AAAQhMgTLFrZ1dvyLmJAZmPIs/4cI74=;
        b=u77wdNYCxxWmmVx40mDxHpGXVHHMl6MTjLR2kOccMboGj0zoxDca/RCAKSbGCJ0gIB
         Gf7mT/S/Qb5HuAxETw8brZXnXDVE6c0X3dYS+McglfeCQKoe+cZyWMbjH0OLFpyk4lnV
         dhOh1EENx33KzBH/QNvuzJfoQuaQzAuDrMQs2SSqBujLpOQWUWNYlwgMyCIgD4rzDn3K
         413gHkn6acbcTtLeVwp+52HSKSYdrOj42s4SabfBZQcFcUytU7bI4ogZ5qe7eHiLjsi/
         vJUAfOCf62dHcgkCuwHEs1S4/8JfaNVzxtguUVbD9YTWKnYzeIQzhlAutjkQFDvSNOfK
         Hxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7IHQW+klBLa8AAAQhMgTLFrZ1dvyLmJAZmPIs/4cI74=;
        b=cV5sRei97orIFXueh0qC7XdQEpWd79CDh9oYRMd1v1QgRXXjuviev0t2G+wRtrP77v
         5WFco59REJJY2mBUZMGF1d/Cy+J62Io8ia6+GOMHVoW1TWIf5lJKvfWYS/AYLBCxEgws
         wXCOwDkHYc/FuKEJkbdrjdhBAIQLdPyKmgCRRzItmayPjworlC5TfLoUfm90hQSbxYyU
         9hQY8/Rk9sbF7TlBwNmASFqCMhXUWe0sb0sM1WBY/d2I29yfgRdOQZ2kiahttzD5n3GF
         QLauTyzSK4IBAcVNbXpe4uJZH/0aVvIui9G/CFLvMp1ljhOaUncXrU80MOqTvimjSPWV
         RJKQ==
X-Gm-Message-State: AOAM530+GOThebqf+iuHIZL5C0afgxI3sZGpmZNJF5ia/kmfblOiCBzY
        Yjp9/RfLrbIrvwgDwiggDt2SzA==
X-Google-Smtp-Source: ABdhPJyDuhvsm44TAGtih3wqsCVUf9JrK216s70IpR50kV9Uh8u0s78M1rB5hWqryVOmaFuYyjsC0A==
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr2285112wrx.378.1634036209215;
        Tue, 12 Oct 2021 03:56:49 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id e5sm10387986wrd.1.2021.10.12.03.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 03:56:48 -0700 (PDT)
Date:   Tue, 12 Oct 2021 11:56:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Ryan Barnett <ryan.barnett@collins.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5] mfd: ti_am335x_tscadc: Add ADC1/magnetic reader
 support
Message-ID: <YWVp7pftLsmm40zZ@google.com>
References: <20211004155319.1507652-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004155319.1507652-1-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 04 Oct 2021, Miquel Raynal wrote:

> Introduce a new compatible that has another set of driver data,
> targeting am437x SoCs with a magnetic reader instead of the
> touchscreen and a more featureful set of registers.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> 
> Changes in v5:
> * Let the 48 v4 patch series aside, while only resending this patch that
>   triggered a robot warning. Use the use_mag boolean instead of sticking
>   to tscmag_wires which was not optimal anyway, silencing the 'not used'
>   warning while keeping the code simple and clear.
> 
> 
>  drivers/mfd/ti_am335x_tscadc.c       | 37 ++++++++++++++++++++++------
>  include/linux/mfd/ti_am335x_tscadc.h |  6 +++++
>  2 files changed, 36 insertions(+), 7 deletions(-)

Okay, so I've been battling with this set for a while.  I've finally
managed to figure out how to apply the whole set including this
straggler, but Patch 10 is not applying to my tree.  Could you please
rebase and resend the whole set with this one included please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
