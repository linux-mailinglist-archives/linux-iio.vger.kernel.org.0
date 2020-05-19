Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C61D947D
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgESKhr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 06:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgESKhq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 06:37:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC34C061A0C
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2020 03:37:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n18so2908479wmj.5
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2020 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aXsJU44GCIYk2OgRQy7d759a/u1ue6myLJURyVBYd8A=;
        b=CLcZ236jj0tlYpqLtFL3ioPxwkbu37Ip4CxCdOnYn9axGgoRWAgEiXb7medhtvS0aw
         S8hfrC0JE0DYi3y30LTInIHDQfUDxzoII2CXXieMTgbi1b1gYcMUOpdhRR6fT2H3Bd4z
         9InwXKX+yA6Pgj5Mu5UVPY+nzaBFzQxntiWBtIW28S/h+WQAOi/KVfliYPqW+QiZru7P
         HHnBRRp0qgbgl0dABgTBbXxni+72y9ObnZH/ZW9Zh7bbV116bT8hmzG+Ml3Za9DbLzQS
         hZy8scnazhAh3wj7771MVayMozXxjHz47wvkYN+o+NoxKlD3sZ0x8v65BmuKr5/OAPPH
         n2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aXsJU44GCIYk2OgRQy7d759a/u1ue6myLJURyVBYd8A=;
        b=Jc+fZ/P3i+21L+fZt8Ldqa7qfagnWMibtvl9dqwOauOJ9UVFNfKtODybEBaLLc7oof
         sXPyyCgFp9zQ6za+R6tMbUoAYGtX+aK40iaQHvEi90FXZPpx9fiiyyfISkch6KXktG7U
         jSCdUs7HEvJLHaQb6GDxMpD7++e1F1InneXwvgdiYZEMIW9vDMPexVm57qA2cpHRcPh6
         bFN1xYMwb03jC7gzaMhzYM0emK7Pv7/8kP9uh5/1wTrlFbfjVeuU9pqRbxYeTCfLZzdZ
         lx8RWVs6DJdD1aHJ9e6xQdpJQTlybPJup9w3SHgXbs7aL4nFcCuoez58vOb/HyvjmtZ/
         xweQ==
X-Gm-Message-State: AOAM530P7wkL+EOVx0OMkQZP8eHVrPLlf7p5J0b7FsWlm/H5Cwyz/3F8
        wyiUNPLGimWLUwMHiO5PM2D/Kw==
X-Google-Smtp-Source: ABdhPJxiAzyUerOuMTk5FRcIW0Jcjoj2ZL7CECmIr6mC4isdh9wLpToG+AphXu0YHNWUccUjNP0TCw==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr4859380wmd.61.1589884664183;
        Tue, 19 May 2020 03:37:44 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id q2sm3433181wmq.23.2020.05.19.03.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:37:43 -0700 (PDT)
Date:   Tue, 19 May 2020 11:37:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 2/6] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200519103741.GW271301@dell>
References: <20200430155810.21383-1-sravanhome@gmail.com>
 <20200430155810.21383-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430155810.21383-3-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Apr 2020, Saravanan Sekar wrote:

> mp2629 is a highly-integrated switching-mode battery charge management
> device for single-cell Li-ion or Li-polymer battery.
> 
> Add MFD core enables chip access for ADC driver for battery readings,
> and a power supply battery-charger driver
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/mfd/Kconfig        |  9 +++++
>  drivers/mfd/Makefile       |  2 +
>  drivers/mfd/mp2629.c       | 79 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mp2629.h | 17 ++++++++
>  4 files changed, 107 insertions(+)
>  create mode 100644 drivers/mfd/mp2629.c
>  create mode 100644 include/linux/mfd/mp2629.h

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
