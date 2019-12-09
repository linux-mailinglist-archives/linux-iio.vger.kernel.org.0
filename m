Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269AF117A8E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 23:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLIW4g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 17:56:36 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37414 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbfLIW4e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Dec 2019 17:56:34 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so6524635pjb.4
        for <linux-iio@vger.kernel.org>; Mon, 09 Dec 2019 14:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=A4KHxg3gak/AwtAzed2CDRcu2q9WfrU2oLQqZp0iE2c=;
        b=JgkAL/tQtnHUIJMXDnJ5JRXCF1Z71qc3TDDuhsTpEFP3RllanM9RKF62rKGTwwyE/r
         3F+sOGcm/Qoo6PW/gV1WjGbEzl/FeQLN+9Cq8B6o/Q5lXLaIFwTagn+oFLmSHZSxT5wq
         b6JzhAPMN4dgoOvUd1T3L/akyP5q6rTfPhBp8ysDtUbavt46I8knRWQ1TyRgkUNuONAt
         qVaaz5V4bS8bcd0C+ZgUiZqe9VyiD+g9s7SdS3JyZKfqnWVaMR7XIgdMTaMdsMH6huO/
         MRbO40lHiN8iUZ5O6HRQubJqB+jrkEfqlDhDNoF58bhwN74s2mubGrtzDOFQSagWQg9K
         07zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=A4KHxg3gak/AwtAzed2CDRcu2q9WfrU2oLQqZp0iE2c=;
        b=UtRCdEKA9eCxP9pt+Vph548N5zlb69vKOrokGskvkqNxF6861TX4up+r4cMgFuiZO8
         cLeNYKiE8tM42sf4qcCmOaq0QkVzrHh8DQACsoI9qlwqeq3hBg3qquPWl7pa1lcCrCs9
         vAKhODxIj2LiahDFKCiciVtlihSoCNPCY79q+URCnHVQLIThx/gpYBRSIsMdtIwZydWe
         fQcfsOgZCMVMy1gHHgOetqDwj95Y5xdYsLqdaaxREfGmcl0vChQFtfSZeX9d6ZBRdyVU
         vgbh2aoIGItz9PNuYvAO5pfz1K9KvKBNcIW6wnVrRrN8TI+fSNQeNnI6LVktaXKiF/Oh
         b5lw==
X-Gm-Message-State: APjAAAXwLfJtDYNjo/HjdJ3mWOZam+1D5RBUPXUNkA/jF+kAm7ykVEQK
        HvXhEXzWuRNHwg360bcLBWY1XQ==
X-Google-Smtp-Source: APXvYqwfy57KUmDE1VA2LS08T92dACffdsdnOJYy9Qvwq4eLq3TN5C71lFIUbtBnAecTSV5jsNQ1Bg==
X-Received: by 2002:a17:902:7884:: with SMTP id q4mr30505852pll.285.1575932193897;
        Mon, 09 Dec 2019 14:56:33 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g19sm504235pfh.134.2019.12.09.14.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 14:56:33 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: a1: add saradc controller
In-Reply-To: <1575358332-44866-1-git-send-email-xingyu.chen@amlogic.com>
References: <1575358332-44866-1-git-send-email-xingyu.chen@amlogic.com>
Date:   Mon, 09 Dec 2019 14:56:32 -0800
Message-ID: <7hpngxqfa7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Xingyu Chen <xingyu.chen@amlogic.com> writes:

> The saradc controller in Meson-A1 is the same as the Meson-G12 series SoCs,
> so we use the same compatible string.
>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>
> ---
> This patch is based on A1 clock patchset at [0].
>
> [0] https://lore.kernel.org/linux-amlogic/20191129144605.182774-1-jian.hu@amlogic.com
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index 7210ad0..cad1756 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -93,6 +93,21 @@
>  				clock-names = "xtal", "pclk", "baud";
>  				status = "disabled";
>  			};
> +
> +			saradc: adc@2c00 {
> +				compatible = "amlogic,meson-g12a-saradc",
> +					     "amlogic,meson-saradc";
> +				reg = <0x0 0x2c00 0x0 0x48>;

Why 0x48 here?  AXG uses 0x38 and you're not adding any more registers
to this driver.

Kevin
