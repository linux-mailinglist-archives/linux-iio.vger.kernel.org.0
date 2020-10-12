Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC628BDFF
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbgJLQaK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 12:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403832AbgJLQaA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2020 12:30:00 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C851BC0613D2
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 09:30:00 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id o9so12009520ilo.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HwXz0lIm3u1bgx4NJ2iqS1dY/U9dQBE6p7ql4v1EMnc=;
        b=WvRRTC2FY86H+vZSq6zL5S7owb4Lioj8J+fpwVYPHaO77mVtgZHpHBY1N7pK7V1rrd
         8tyV0bks1Is+hm+8a6ekqgFqO4pXdkiudWQjTjVXlcjfTtWg7Jvja1SBLMxep0oBjQwI
         VGUQ1ZKbreJnEdZBXpQvuP39nK+yeIMumo7q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HwXz0lIm3u1bgx4NJ2iqS1dY/U9dQBE6p7ql4v1EMnc=;
        b=t3SG5/MbuKNpP62uYLdDSSD13I6MAOJNn5xDDo+XCmOmWOhwft7+IcCiG6dI19xxUz
         OFPiKSBvZkPDYIbtYurAQb5wGUs5S6sOsSI2JgvG9LgHuKrOawrNp4GspTAFZWbRNZ6r
         8bKMVhMDtZOsP8Zs+HVzyOIf0f56oBSwhA2hHLy+vcX1xLiGFt+25Y+NwX5ulb5Emt9m
         8YMFJz+btcv6Y2hZRbZ4GUaIi+8oQCRtPqu4F6SFUDaTtXqlZ1qiUM1ui+x7cOLRv8/G
         nUdcjhEFK0o/bKhq8X1fsayIFaw/dAz3nGY3doVSD0OqrrRaiUcvmZnmKTOvK+4gr1X6
         BWZA==
X-Gm-Message-State: AOAM530bcCh3UJMHDLlLrRZcf0WyjyZoLaU1LZIotZTkw3fztJHBfslL
        37y9zWlnmJ74UaiIT/Z8BzHNuXVHurzwpW+Q6SaIWQ==
X-Google-Smtp-Source: ABdhPJxBh6HvvOLZAbR6K59Zj8bX8eUob9gLrihj7TV0LUKDwxqSPNkfr06YGIMALj3YSWDpcdRd3BDrNpSlJRn+zVk=
X-Received: by 2002:a05:6e02:e4f:: with SMTP id l15mr11184274ilk.142.1602520198670;
 Mon, 12 Oct 2020 09:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201011170749.243680-1-jic23@kernel.org> <20201011170749.243680-2-jic23@kernel.org>
In-Reply-To: <20201011170749.243680-2-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 12 Oct 2020 09:29:47 -0700
Message-ID: <CAJCx=gn8QEgrt-YEo_H3CQK1-zht_pDbYTQngqGES+UbFsvzKw@mail.gmail.com>
Subject: Re: [PATCH 01/29] dt-bindings:iio:humidity:hdc100x Drop separate doc
 + add to trivial-devices
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 11, 2020 at 10:10 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Very simple binding for this i2c device with no properties beyond
> reg and compatible.  Hence doesn't need it's own document.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  .../bindings/iio/humidity/hdc100x.txt           | 17 -----------------
>  .../devicetree/bindings/trivial-devices.yaml    | 10 ++++++++++
>  2 files changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt b/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
> deleted file mode 100644
> index c52333bdfd19..000000000000
> --- a/Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -* HDC100x temperature + humidity sensors
> -
> -Required properties:
> -  - compatible: Should contain one of the following:
> -       ti,hdc1000
> -       ti,hdc1008
> -       ti,hdc1010
> -       ti,hdc1050
> -       ti,hdc1080
> -  - reg: i2c address of the sensor
> -
> -Example:
> -
> -hdc100x@40 {
> -       compatible = "ti,hdc1000";
> -       reg = <0x40>;
> -};
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 25cfcc904240..9f8531d4d33e 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -352,6 +352,16 @@ properties:
>            - ti,ads7830
>              # Temperature Monitoring and Fan Control
>            - ti,amc6821
> +            # Temperature and humidity sensor with i2c interface
> +          - ti,hdc1000
> +            # Temperature and humidity sensor with i2c interface
> +          - ti,hdc1008
> +            # Temperature and humidity sensor with i2c interface
> +          - ti,hdc1010
> +            # Temperature and humidity sensor with i2c interface
> +          - ti,hdc1050
> +            # Temperature and humidity sensor with i2c interface
> +          - ti,hdc1080
>              # Temperature sensor with 2-wire interface
>            - ti,lm73
>              # Temperature sensor with integrated fan control
> --
> 2.28.0
>
