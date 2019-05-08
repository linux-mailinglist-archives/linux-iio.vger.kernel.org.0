Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062741763A
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2019 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfEHKsS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 May 2019 06:48:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45087 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfEHKsR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 May 2019 06:48:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so26527998wra.12
        for <linux-iio@vger.kernel.org>; Wed, 08 May 2019 03:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IHBkjP3F1gQzdLI0B9hmLYiz6sC0JHsPy/fl7iXQGM0=;
        b=b2PA7sqeZZejwZ/i8avg/YCIsAgZ3efU77WJvZ98MfNCr1e8YBnFIillDuirrzgYJN
         EePFMBcZ6Uq1LskRV3xNAlibuwCckfRUU2oVR9KVVP5fnlNlBpYagRgtXSO6ZtBcEQxz
         w/Q2mrEj4onbbPQOhe6JSnlMG2u9mL+WxiaH8IxxJU7JUhokiOM71d4kjIqWHYThozPH
         jZKJC+fO8tCG5YK6/1S4nFT3NfwPADW0HPd+C54j806icgctlFNK47DhDBxwfJYSxEQS
         L9OoNuKqO9rI4xxdUjQaClZy6IJZAhe2IHRwl0S+czFexunuE9TL8Uj8cxvUy6wWbBd3
         89NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IHBkjP3F1gQzdLI0B9hmLYiz6sC0JHsPy/fl7iXQGM0=;
        b=eANNLlNiEov5f7WSjTe/1VAGPFAVO6ZJ6qqCQGSeCqFhK5ygleSYiVQu52KiWSV8QB
         SzmsZUuGndH9eGJGc2xtGennQ84Xcj2P9qb04X832s4Y6i2u5XWkvvfIstyoZ9s7bXjn
         fvs6HfpCYH06p+34RzFLVrVEVxdhY9955AsTEeKHEPnEQaIGwB2m3Fzp80RrJEeW+YTv
         3HlzRNrzGjQa8Xa1QAS97V6xkux93lQBaZo0p7I9y686fk9aBglNr2krMO1E+nAoydg0
         NYL3JRQSYNvgIdHKS2Zhs2vuBkNuBpAT4XsUO8SLFZQ9ammqhTVSN/1vLeapuUF+z5ou
         JGbw==
X-Gm-Message-State: APjAAAWJY5gjNRTNzbtXF7NXRoLXsLUId+klxIpct9Pn+HrDFRrDtYUY
        Ywh13PGayJJmICIF0rEQNI6kow==
X-Google-Smtp-Source: APXvYqw/3wkGeFghmafjWglBIuxZXSMRfucMxPcCx2MWIyaG8I3hP0tpm83IOexxo4PXkiZiibTDMg==
X-Received: by 2002:adf:83c6:: with SMTP id 64mr25278976wre.81.1557312496080;
        Wed, 08 May 2019 03:48:16 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id i17sm3584718wmb.0.2019.05.08.03.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 03:48:15 -0700 (PDT)
Date:   Wed, 8 May 2019 11:48:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] iio: cros_ec: Add lid angle driver
Message-ID: <20190508104813.GM3995@dell>
References: <20190425002932.126740-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190425002932.126740-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Apr 2019, Gwendal Grignou wrote:

> Add a IIO driver that reports the angle between the lid and the base for
> ChromeOS convertible device.
> 
> Tested on eve with ToT EC firmware.
> Check driver is loaded and lid angle is correct.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v6:
> - Fix lock held in an error path error.
> 
> Changes in v5:
> - Remove unnecessary define.
> - v4 was the wrong patch file
> 
> Changes in v3:
> - Use static channel array, simplify code because index is always 0.
> 
> Changes in v2:
> - Fix license, remove driver_module field.
> 
>  drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
>  drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
>  .../cros_ec_sensors/cros_ec_lid_angle.c       | 139 ++++++++++++++++++

>  drivers/mfd/cros_ec_dev.c                     |  13 +-

Since there aren't any built-time dependencies between them, this
change should be pulled out into a separate patch, which will go in
via the MFD tree.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
