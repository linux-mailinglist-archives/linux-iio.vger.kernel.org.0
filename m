Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8AF7357
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 12:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKKLnm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 06:43:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46660 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfKKLnj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 06:43:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so14225903wrs.13
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 03:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=btwpyE4DKhSXy4FwJ2ZD9A7dltuQxSGv5JHsll8DI20=;
        b=lmKD+5OS0vjqFt56pnvwLZFFro7OfkevToyeur/XuWHxeJ0Vk+XDK5YjVCvmrD615p
         gWflCdfIAN2jW4H6Y1kMf1wEiOQjzReY1Bd1YX8tUr+Lq8c0vMiDgavy+vGKdet/qXBn
         rZe0PDn9ELo3/RXuNhxhBpR+Q5TgjV8TLFpWQX/a/6xueaBHXGj0fVM2ujqg8m02PwB2
         b+/vWx+ilnjUisD0BXGtA++yPVLfSDAv07zuEn4ZCS6k0R5a3+33/iH0OoUmWgPozECI
         czwHujbbNUYtlVbolr32G/KAIWgUf3gnkZoREabNFo6xsQq/hhjpFNTHa5Sh5Zdma/W5
         z2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=btwpyE4DKhSXy4FwJ2ZD9A7dltuQxSGv5JHsll8DI20=;
        b=c9v6GGYJmBmyb/lHyy6dCnH6t/nJ0KpmNZ7mJW1qWj/xblaBPcxNhPM5EIQ5K3v2GQ
         strjf/BFmcHAWqlWceKIgoMkI5wUIfKhm5SMxfFRXc003O0XCbPMx2oWHViJK/zKe9yj
         mkBSWX1Q+jUng/QZq+IWmEljdrEjfOjf0L+ozUfnne/A86g5ia22qavbMafQmzpjWMvU
         1tDg6wSi0XaUC+Z1FwurRwEbOPwX6RjAJozKh5a8Zy/J+IvT7LSNW3A0pT60nqub1iHd
         82M7tAckqsgKunz1gUxm1e8RIYZk1LGWEIckODUDOcXkeJywsac0D6NEX6OJ6rpLsr3d
         vVlg==
X-Gm-Message-State: APjAAAXuE0OHseiJE3ftrV0gaWNFY1t9FZh4zKQ0PPUGMgWFWTskC7PU
        eqO0hqyh94+8+Ef79Q289voWag==
X-Google-Smtp-Source: APXvYqxe0V7wxbe9LxXQ7Boi59XGm4VrGwzmHV65LvzGKaVJcLUW13/9tnDcvZeFl8ZE8L2l2442Yg==
X-Received: by 2002:a5d:678c:: with SMTP id v12mr8778108wru.116.1573472617414;
        Mon, 11 Nov 2019 03:43:37 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id 4sm17320362wmd.33.2019.11.11.03.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 03:43:36 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:43:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 03/17] platform/mfd:iio: cros_ec: Register sensor
 through sensorhub
Message-ID: <20191111114329.GM3218@dell>
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-4-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105222652.70226-4-gwendal@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 05 Nov 2019, Gwendal Grignou wrote:

> - Remove duplicate code in mfd, since mfd just register
>   cros_ec_sensorhub if at least one sensor is present
> - Change iio cros_ec driver to get the pointer to the cros_ec_dev
>   through cros_ec_sensorhub.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> No changes in v4, v3.
> Changes in v2:
> - Remove unerelated changes.
> - Remove ec presence test in iio driver, done in cros_ec_sensorhub.
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c      |   6 -
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   6 -
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +-
>  drivers/iio/light/cros_ec_light_prox.c        |   6 -
>  drivers/mfd/cros_ec_dev.c                     | 203 ++----------------

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
