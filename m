Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D60D216148
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2019 11:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfEGJou (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 May 2019 05:44:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35022 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGJou (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2019 05:44:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so19048422wmd.0
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2019 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tBpp/bG/ZmwTb4vBiTX4r+mHSsHGogQ7hhruU5zMJ7o=;
        b=IzDbYDwYnXtOG1djPxlvt2LH/gq3sVbvwRxtcnZgh6Xe8g4j7rqnzNmj0GBVChEvaJ
         sCrDxLQtGvvbltABdIA7Q3iAnHOjsjJS2V5BCXI33456vJ76skhl8UNDLNGV/Kg45ktt
         3iTiKjG6v6Rsgc0Ss9yrXs3ASwzs4oAwJDEXE5DMhaehSneauawPeGroDKnJJtQe8poa
         /AQJW6XWId70OxT2gxdI34ZmYbN598BCI4E49YeRnEWa/HLGQhvU6NbtaxsSZRiF3iGa
         IjBc2ucSTG7XWWcY4I4HKU0plyMf70gDpWlbD9bpR+EFGF8ZIFfPoAUqAn0xNzW59Waf
         +c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tBpp/bG/ZmwTb4vBiTX4r+mHSsHGogQ7hhruU5zMJ7o=;
        b=qtLc3dS+wKJFNDt7JIgLZc1AgjRakLuEfhMMv0A0MqJhW1XIA7Rs4fxy1QQmG1aGEe
         Na1nwPn6tCOVrDnXZ8O08KF3QFDptVr9Q5DYFsqP6AG7ya/JmEgS23yy/NTdCWeOU6lC
         4bzhU20ayZWY+xFMj/YcNAKvhuuZbFRc2RKW7BayZmsY0nuaYtliKSfjgF7vIQ7GUVPI
         o+LVXGBGwRPLg2wechqNYJMs6onix60X8ljWJpyxAKep1HApsx21GE7gqf/wyb7wjWgp
         qArbPFELXb27QrKaXBT6aE53hHYU4pzir6ReESM9TL7ypLsOLgsyVPsLTu/AN3YpzRd7
         8tug==
X-Gm-Message-State: APjAAAWZ78VilHxSjg03z+KyEo3zpqQRBxz/8HJGVPAguUsfZKFD4xuj
        rjfyVd6JURzRItnNHL+L+bYoXg==
X-Google-Smtp-Source: APXvYqycfwgVAYDhFRxFI6FyrSmaV7Jpwm1mE2kT04bW6crWZrdbMErveEz28TjLhod7S7fOIVm3OA==
X-Received: by 2002:a7b:c415:: with SMTP id k21mr7780514wmi.29.1557222288438;
        Tue, 07 May 2019 02:44:48 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id 195sm27122082wme.32.2019.05.07.02.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 02:44:47 -0700 (PDT)
Date:   Tue, 7 May 2019 10:44:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, broonie@kernel.org,
        cychiang@chromium.org, tiwai@suse.com, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 00/30] Update cros_ec_commands.h
Message-ID: <20190507094446.GD4529@dell>
References: <20190503220233.64546-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503220233.64546-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 03 May 2019, Gwendal Grignou wrote:

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
>  include/linux/mfd/cros_ec_commands.h | 3735 +++++++++++++++++++++-----
>  sound/soc/codecs/cros_ec_codec.c     |    8 +-
>  2 files changed, 2997 insertions(+), 746 deletions(-)

Again, it would be good to get 1 or 2 more Chromium Acks, given the
extent of the changes.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
