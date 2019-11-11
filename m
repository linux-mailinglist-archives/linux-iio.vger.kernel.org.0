Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82FF7359
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 12:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfKKLod (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 06:44:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38394 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfKKLod (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 06:44:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so12860700wmk.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 03:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pBYMKGdeC8uxl71BEDu8lTDLVYM52moP2vRHyLhP634=;
        b=tCmCH4ONJBtSz9KrLfPrqlbp5ENanTkQ9MPa6Ot4BeWo7hY9H99dPFyqc2z9D79lvP
         GJ4VcXKtSQQ/jB5R+tmw1JcOjgzoOeqx6x/c1VTFv1z3vTSU/Vh06PxSBPeYyXyoLkq1
         ABCiQBbM8ybqJYcm5S2O8oa+xuraqiN6oOl9Ubao+mI/qNyaZ5p5CGDyppkysz1d7n/z
         4ehlopU/doGFmsr8Z079zaZLxgvTIUeanbw8le0m2Hj4GIUwlTOFv5+JJtNUvTThCg5T
         oDAnpOcLOv8/ZGXLa1YLNcOvBzekfqoidcJW5s/qT4o2Bt+HfZQl20Qr7DAt6Kshv0ez
         C/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pBYMKGdeC8uxl71BEDu8lTDLVYM52moP2vRHyLhP634=;
        b=gKUleYkKoSZXiajC1ZtPdBrNzdnE3xLezqb0gTYsSXWhgQicEcS++ZMWvmT2IDXpdY
         4AfyNMogUyroNQt1DBigU0t0l2klNQdNOgZrwQLQCcuC1gPsvbryNA/hlyoiG6JqkfYf
         36LH+DZSkT390XMhFq10xTspS0CiiP2+hp5rT1OIPT6JZ0P7SSRpZq0PLEKlVxAiZUhr
         vSOX5aaSD93nFy/A58TxvMy0CrxQHo/qCZyIrfX8SxWuaSdGMFUQCr+N5ktc37i1oO85
         7OR+w0LhAztw9wpJbnskZmy8PFW7YVbH01aP6RRDg9wMQDfEJ2K3ws+atkRJGtdYQY6l
         yqgg==
X-Gm-Message-State: APjAAAW2Wyka3/DB1zjbkBb7wHiC+Zd33ArwK7ZomAVxKzsQPSwONpX2
        MkVgqcgzbynWFfGS9kXrmEKXFg==
X-Google-Smtp-Source: APXvYqy3cV3J5+lGnGuLIWLtIACVWtH8IVzsbXMXLJ4UquBRUy44658weOkpodyltvzp44m/Zo1PXw==
X-Received: by 2002:a1c:a791:: with SMTP id q139mr19589497wme.155.1573472670996;
        Mon, 11 Nov 2019 03:44:30 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id q15sm6929500wrs.91.2019.11.11.03.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 03:44:30 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:44:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 01/17] mfd: cros_ec: Add sensor_count and make
 check_features public
Message-ID: <20191111114423.GN3218@dell>
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-2-gwendal@chromium.org>
 <CAFqH_50q7y-sL0SyA3BDkZ9_YBX_FL90smtXt7v0Z+BW8nrw3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_50q7y-sL0SyA3BDkZ9_YBX_FL90smtXt7v0Z+BW8nrw3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 08 Nov 2019, Enric Balletbo Serra wrote:

> Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dt., 5 de
> nov. 2019 a les 23:28:
> >
> > Add a new function to return the number of MEMS sensors available in a
> > ChromeOS Embedded Controller.
> > It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> > registers to find out.
> >
> > Also, make check_features public as it can be useful for other drivers
> > to know what the Embedded Controller supports.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> 
> Version 3 was acked and I think we can maintain his ack, so:
> 
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Also,
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Lee, how you would like to handle this? I think will be safe for
> patches 1/2/3 go through the platform-chrome tree without an immutable
> branch. Patch 3 thought still needs and Ack from you if is fine.

Please take the entire set, converting:

  s/Acked-for-MFD-by/Acked-by/

... and send me a pull-request to an immutable branch.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
