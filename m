Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F13EC02E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKAJAK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:00:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38513 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfKAJAK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:00:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id z19so4233983wmk.3
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2019 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z6VIallazyVW2gnaDH0dlgNEJHptgWdXOaqvgfmB32A=;
        b=V95yI61YpqLnaov22fsDZlcPX6FzYrjNU5v/MzYOrYhrPUZmX4Ywqs5SFxl6LY+Ap7
         erhMI26+MpwlhxrZAs4NOTKSLlIxpRMJOpMcXJVzbTi75KV+h2xk9VUmuX84ap4nKVnL
         oDW3LUfjaorx/E7gqsh3ItFTYdquNRrcqZ+fjnxDtcJz7qvaPFaE8ayb9GX3I3Mtzd2I
         zITDdIpSXeBl70dmO6Pyiv9YYpe5lcO/o8vcqpJcS5M2mfUSffyE9XCQASai6XNL0hdY
         opjXFr3mBteogYUHjR3n73kNAue3ioX68PQFVhMdRt8euhfsEaBQcEXkq4Zoj3sKLtJW
         brbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z6VIallazyVW2gnaDH0dlgNEJHptgWdXOaqvgfmB32A=;
        b=SjNQnI2MboJj5A8g3FKJHOvjc8omv8Nk157GS8HWBaFDI+hHiXIthAKtlzwLMTcTDh
         WimjqRrHfOw7Or9QxTQFgeu6tqmhoGEuGYQDX9sl9y0AOYEI+G1SrZ4bZnLZjalkPpC1
         xp4CI84hwtIF55JckhitcpCLYaoprR8nqpFSSkpwdVJBsQbIhVb6rSJJpSCkel1patcC
         JfePL//cfCsNIRQlAb3MMK8kYs6HRpmgGWY21qsvoryYC7A8/5xRKN7P8/1zQkzEB0c5
         KLEH9uuw1gcACXiCwJlxp53qXCtCChxaxoq0ZSICHnREFxMuIRNfA6R7KyD31ln+GfdP
         ArCg==
X-Gm-Message-State: APjAAAX4s4fURcQVI8dQQlwQf1J1hjXLGCpPcdOiz4AzQHziX6bkIwUw
        eSg+oCUPcnt/nKKJJIH3YpHo6Q==
X-Google-Smtp-Source: APXvYqw5xpkWweDsElT5oorj6ZqZwyiP5jmbGdBy2KGR6B9RaT1x4myrBMtVs6piCQ2/e6+4ilEtjg==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr378855wmd.39.1572598807344;
        Fri, 01 Nov 2019 02:00:07 -0700 (PDT)
Received: from dell ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id v128sm8370576wmb.14.2019.11.01.02.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 02:00:06 -0700 (PDT)
Date:   Fri, 1 Nov 2019 09:00:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 02/18] mfd: cros_ec: Add sensor_count and make
 check_features public
Message-ID: <20191101090004.GF5700@dell>
References: <20191021055403.67849-1-gwendal@chromium.org>
 <20191021055403.67849-3-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021055403.67849-3-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Oct 2019, Gwendal Grignou wrote:

> Add a new function to return the number of MEMS sensors available in a
> ChromeOS Embedded Controller.
> It uses MOTIONSENSE_CMD_DUMP if available or a specific memory map ACPI
> registers to find out.
> 
> Also, make check_features public as it can be useful for other drivers
> to know what the Embedded Controller supports.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v2:
>   Fix spelling in commit message.
>   Cleanup the case where DUMP command is not supported.
>   Move code from mfd to platform/chrome/
> 
>  drivers/mfd/cros_ec_dev.c                   |  32 ------
>  drivers/platform/chrome/cros_ec_proto.c     | 116 ++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |   5 +
>  3 files changed, 121 insertions(+), 32 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
