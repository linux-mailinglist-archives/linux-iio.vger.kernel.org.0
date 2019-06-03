Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96E03304B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfFCMxR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 08:53:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43828 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFCMxQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 08:53:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id r18so2931135wrm.10
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mJzvhiGffEycEWujL+bss26vNVFhjmchmuQXEPVt3OI=;
        b=i336iScQCfCZvbvTGweyXXgI7STx9ES6GbBUErWAbm2GYjsrk15DzygvtflxAU75bw
         7zytegesZVYlVbKGZQl2/uIhWWJLVtIB42A7hmZakjv5JVueeBrWMm6YSSJtVlMdtPEu
         6BS5T8Nzfd4M/xL4YMfXi7rwAtZ+RcQH5RAVDIramgsZf91yFBzp7pqCwOhqc+14iMv2
         k6i1pJeIxiMLnLrjUBpYDHmESWhAfOV6uapL12RaqR4azwGZxYYhiO+BCDffN6O90661
         6HD5JtgDf3Vn7KATsxAB91xl0IhFjSUR8bnZnOe3m9rHBgba5fZbGmYl6BbASR1XySRS
         JaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mJzvhiGffEycEWujL+bss26vNVFhjmchmuQXEPVt3OI=;
        b=LS0UIIb5tyJjIljllUJjDX1uVU0LdSwtUFxFbuautDqlkyb2F3HSyHw8YT6FdFaZL7
         Zvi+CbXiIJbxyWulhnUvI/2AzKANYq6iPBa6chzM7wUJkM6QYKyWdBnpZG6K/P1YSq9O
         ZfJvBnmVT5Dy/QxpFC1IirS4+aYWK5lSRYdPsImUoMRl9gStpTuWT6zXTpKSJ8wrtK2O
         aTyszNkd7IXXtOGy9XnS7JHBCMTqEKZGFAZbojpnC2CllEccK2l2KxHG30+m9ChBaCm5
         2AP38y9LVbK37tEI+xgLFdxAlgBqhyfTrZGLWesnTXvw+YE0JA/3YC41zbBXjq1xKiIh
         y9Vw==
X-Gm-Message-State: APjAAAW/rv0rdkaKPesY8KXmTcUfX8xJV4rEVWRbmNlWaxmDW1k2vzyT
        ibadBLu8DFjNVKkm9dbqzL3Xuw==
X-Google-Smtp-Source: APXvYqxFE0118CiSNYTdmHv39GS0d43c8AFGtSRqVsdLZ2291NPcyMYGAd6S+TG69G1rOWsB4WIMmg==
X-Received: by 2002:a5d:6849:: with SMTP id o9mr2541732wrw.196.1559566395383;
        Mon, 03 Jun 2019 05:53:15 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id g8sm1176779wmf.17.2019.06.03.05.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 05:53:14 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:53:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, broonie@kernel.org,
        cychiang@chromium.org, tiwai@suse.com, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190603125313.GU4797@dell>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 09 May 2019, Gwendal Grignou wrote:

> The interface between CrosEC embedded controller and the host,
> described by cros_ec_commands.h, as diverged from what the embedded
> controller really support.
> 
> The source of thruth is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> 
> That include file is converted to remove ACPI and Embedded only code.
> 
> From now on, cros_ec_commands.h will be automatically generated from
> the file above, do not modify directly.
> 
> Fell free to squash the commits below.
> 
> Changes in v3:
> - Rebase after commit 81888d8ab1532 ("mfd: cros_ec: Update the EC feature codes")
> - Add Acked-by: Benson Leung <bleung@chromium.org>
> 
> Changes in v2:
> - Move I2S changes at the end of the patchset, squashed with change in
>   sound/soc/codecs/cros_ec_codec.c to match new interface.
> - Add Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Gwendal Grignou (30):
>   mfd: cros_ec: Update license term
>   mfd: cros_ec: Zero BUILD_ macro
>   mfd: cros_ec: set comments properly
>   mfd: cros_ec: add ec_align macros
>   mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
>   mfd: cros_ec: use BIT macro
>   mfd: cros_ec: Update ACPI interface definition
>   mfd: cros_ec: move HDMI CEC API definition
>   mfd: cros_ec: Remove zero-size structs
>   mfd: cros_ec: Add Flash V2 commands API
>   mfd: cros_ec: Add PWM_SET_DUTY API
>   mfd: cros_ec: Add lightbar v2 API
>   mfd: cros_ec: Expand hash API
>   mfd: cros_ec: Add EC transport protocol v4
>   mfd: cros_ec: Complete MEMS sensor API
>   mfd: cros_ec: Fix event processing API
>   mfd: cros_ec: Add fingerprint API
>   mfd: cros_ec: Fix temperature API
>   mfd: cros_ec: Complete Power and USB PD API
>   mfd: cros_ec: Add API for keyboard testing
>   mfd: cros_ec: Add Hibernate API
>   mfd: cros_ec: Add Smart Battery Firmware update API
>   mfd: cros_ec: Add I2C passthru protection API
>   mfd: cros_ec: Add API for EC-EC communication
>   mfd: cros_ec: Add API for Touchpad support
>   mfd: cros_ec: Add API for Fingerprint support
>   mfd: cros_ec: Add API for rwsig
>   mfd: cros_ec: Add SKU ID and Secure storage API
>   mfd: cros_ec: Add Management API entry points
>   mfd: cros_ec: Update I2S API
> 
>  include/linux/mfd/cros_ec_commands.h | 3658 ++++++++++++++++++++------
>  sound/soc/codecs/cros_ec_codec.c     |    8 +-
>  2 files changed, 2915 insertions(+), 751 deletions(-)

Okay, I'm ready to apply this now.  Could you collect all of the Acks
you received and submit a RESEND please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
