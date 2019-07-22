Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6301D70CD0
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2019 00:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfGVWjs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 18:39:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44692 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfGVWjs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 18:39:48 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so77522792iob.11;
        Mon, 22 Jul 2019 15:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vbYJ1O4G2anAmYf7p+jL+t/fXFFpVBorexxI1DxrCus=;
        b=kVOa//ATg7xTCtlIDkwl2pq+NgXVIgpvInTXuC/D3mPUY08Q1scY7BSl2+ehQAk5Ax
         wLG7/om7/ihWPM8tj0JvB7kWjwhnLyB+V9/f7Blv69Rhlf9vtiaADQl3aCpW8AmHwCKy
         NiGMF891nvqhkz7DS8VaeJYNyWs4WsxQIUMP38+amL/GO2xUfQ9UncyY2n2SVqDklwH0
         x0KKQgE7cBGMNvp91K3be35IX/jH6/mWmO5UvpiKNpzVzP6Tpk5ft5S5CuRX/qQ3Y0Qv
         6liE3aJSjDXuYLOfBZOTw6yCkS15KYh/DzyyBGD4bDb+QsZ4ctxoXIzIwktoeUSM/XaS
         tO+w==
X-Gm-Message-State: APjAAAVAa26S9imJsJgC6IwLqdLxg/7wKXQ9wDtXLzza+lrF1t6qiM9U
        abzD+oX7IzlWhE9OJpgI8g==
X-Google-Smtp-Source: APXvYqz2rXSLBVRmYKW3bDLuiyIkgSKd7PAkcXVE4fqzDz9El6EEZFJJL8B0WF+F9CA+J5gCOOixnw==
X-Received: by 2002:a5d:80c3:: with SMTP id h3mr58962379ior.167.1563835186840;
        Mon, 22 Jul 2019 15:39:46 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id p63sm41904054iof.45.2019.07.22.15.39.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 15:39:46 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:39:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Dirk Eibach <eibach@gdsys.de>
Subject: Re: [PATCH] hwmon: Remove ads1015 driver
Message-ID: <20190722223944.GA9166@bogus>
References: <1562004758-13025-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562004758-13025-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 01, 2019 at 11:12:38AM -0700, Guenter Roeck wrote:
> A driver for ADS1015 with more functionality is available in the iio
> subsystem.
> 
> Remove the hwmon driver as duplicate. If the chip is used for hardware
> monitoring, the iio->hwmon bridge should be used.
> 
> Cc: Dirk Eibach <eibach@gdsys.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Current plan is to queue this removal for v5.4 (not v5.3) in the hwmon
> tree.
> 
>  .../devicetree/bindings/hwmon/ads1015.txt          |  73 -----
>  .../devicetree/bindings/iio/adc/ads1015.txt        |  73 +++++

I assume no change or I should review it again?

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/hwmon/ads1015.rst                    |  90 ------
>  Documentation/hwmon/index.rst                      |   1 -
>  MAINTAINERS                                        |   8 -
>  drivers/hwmon/Kconfig                              |  10 -
>  drivers/hwmon/Makefile                             |   1 -
>  drivers/hwmon/ads1015.c                            | 324 ---------------------
>  drivers/iio/adc/Kconfig                            |   2 +-
>  9 files changed, 74 insertions(+), 508 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ads1015.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ads1015.txt
>  delete mode 100644 Documentation/hwmon/ads1015.rst
>  delete mode 100644 drivers/hwmon/ads1015.c
