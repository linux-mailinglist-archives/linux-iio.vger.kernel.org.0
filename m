Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866C71280BA
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 17:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLTQfG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Dec 2019 11:35:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36353 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLTQfG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 11:35:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so10620822ljg.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Dec 2019 08:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFD+CvYm7Gs/8aaJTbwleryPqt5gW339MOqPPhNFq9o=;
        b=IyF45XxxDXiGY6jDbxeu85FHtjr663+33QiXXrgFqCh56VoTspJPrWueAWdfucQvlj
         adUXTWQzzTfKrZVUOfHUuaJcBMnBjVDLsWz2K1l/unH6ddJJ7EuqW3JAdNoWzdoPMibj
         QzQ3vKcFqEWbqysmA5J67Di27QwrtpVVtiIGWjNzuQjmGKOzeCGLO2BFRI+qKVV46lcK
         X6pRsSaIgYWDjzWS+7bKuqxdyFy5WleDV9KDWg3AG//y8LuF686wl/hBKzRXE9UQA1yp
         pdycq3dArRK2mZSElb+4zdDs3T2oSNa3nHnR3n4M7+phtTVVNDP8jrCHtybB50lOQd9t
         Dktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFD+CvYm7Gs/8aaJTbwleryPqt5gW339MOqPPhNFq9o=;
        b=pMZXSD37MWy5l7VQT60h9WXvttjQDE+GfBBB07axYy91Fb03oMxhHdM70//LxoNW1A
         OEbCj6jjjz0W95XBabsEkQfZoQ2KZGi7DfeV9TcJvFt1HtfcZzo4wASnZOFmW3minL/F
         rP4A+/YqzapTzIPCyEMSh8DUbeMGzwb8b3tNnT8kgA9BPu+UxPmgeFNq60rgMmXbE6BP
         Bs7R6p3q9uGw8BWACsOcpNiZhzEIOGHcB2BiXXCgXMuIawcZZ64jg7+Sri75WMzyRNTA
         CD6VUsviCoR+NSG7h7V4aU0eOq/NjkZOg7R1i6qdsPZkC+k8I2+L8Z8PHGgcHrPoR4pm
         oJSw==
X-Gm-Message-State: APjAAAUO2nDZ5qc1EJj3k+gmXNKYAGyfr9BlBwHjig2VgQYAa7KBGNww
        s2zM5ycmV1JfD/NrJmrfjrhY3G2kyYhXQHZmZPbq3w==
X-Google-Smtp-Source: APXvYqwnxwRhpuCJTLl02hGFZHqGl/wXHiSfUc5kYi6vlhPqmWMXlT4pYIgRpn7fCDsZAXO5yrdUS+peE9jjnXA5JEE=
X-Received: by 2002:a2e:a490:: with SMTP id h16mr8361295lji.251.1576859704348;
 Fri, 20 Dec 2019 08:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20191220160051.26321-1-dan@dlrobertson.com> <20191220160051.26321-2-dan@dlrobertson.com>
In-Reply-To: <20191220160051.26321-2-dan@dlrobertson.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Dec 2019 17:34:52 +0100
Message-ID: <CACRpkdb07VLWeBbSGs1qvmXfXyLFPFZWxiTKVEfan0cAnrbiLw@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: iio: accel: bma400: add bindings
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 20, 2019 at 5:16 PM Dan Robertson <dan@dlrobertson.com> wrote:

> Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> accelerometer sensor.
>
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
