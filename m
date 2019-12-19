Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86211125CC6
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLSIfU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 03:35:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44698 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSIfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 03:35:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id u71so5241279lje.11
        for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2019 00:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAoklvrDj2FXXnEjYzoBMnCun02TkYPTQ8a5p79Mfxk=;
        b=B6XbgDX1w5gegqEuEFrSRvmuFJiRJW1pormXwOJI+tuXvRxnzb24ChC5YDTJFY118x
         KSvb9Cq4KlAlA4iUmp1UfVohfwnAmcwjk3KoePyzp015V81NcVhD3rGwy5Gf3xo9H73t
         C8fHnzxnVBd69Sx9CszFQl1VM2Ui4tgBaXyOQv/JcD/f0N8ekBqQbMxiAegdIOLGneKV
         jI4zpuBROHGjFMNWSxZQKffJpdCJ1vqsZCA6U2HPcmhIDC2DxEDcRJxYVobG8dUU7V7H
         +ZG/9WfD9979bx1dvpxpSyd77v2W/NT2Y2z2aoMZy6Tz32knOeHtV8IV9M5wkPEhq5C8
         w3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAoklvrDj2FXXnEjYzoBMnCun02TkYPTQ8a5p79Mfxk=;
        b=NNbbFMhy9UckmzR6nV1aP0XOgiFTrA13JvpXAomQ/wofuLZQOuzNY6qrT5M7QXoEmP
         DBjA0B+Zw7C8d2yL1DnCSLrk5pFmfA+WXupwBg9/n/I8iWrpXuBn+oIT8Vj5P02ceHFw
         5jOEnIl4tooV9OWlGrhbk09fsDFmxIrk1O3yIF+0M7dJG2LQT3X5sYJS0c0O0p7OQwSd
         FdTWqy6ztuGzZzglObYbUh6KE9M0/AWGty9R+ImUooR4prBRajnKUXWNJMlA3L7d8PE5
         wLd+/M/aAujldWXHqY4FRENpvHOObvYVXvxnplNdsyah0kFi4IeLde9aXfSAc3EYeYNc
         f6HQ==
X-Gm-Message-State: APjAAAWmA9eBnyUX0deGyXQQ9a5QfmDNXdBw9UeWypypg1s4pHUQBKC4
        Qj7yt+X3g/AfZnXLWQ1r0lpFcUpxWjupnt9xaDj4Aw==
X-Google-Smtp-Source: APXvYqwd7eUldyVpHzhhNPvPXO+3TWrMWzvrI9RTEi+X0qvW1Mki8vx6zZFbw/xtwDd1awpUn8/jTDBHHvuXdkNEJxk=
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr5177759ljk.77.1576744518396;
 Thu, 19 Dec 2019 00:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20191219041039.23396-1-dan@dlrobertson.com> <20191219041039.23396-4-dan@dlrobertson.com>
In-Reply-To: <20191219041039.23396-4-dan@dlrobertson.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Dec 2019 09:35:06 +0100
Message-ID: <CACRpkdbJJWRvTUGmJ9dsb=n8j-hxuoZtLK17fRy5FtxsV-wifQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] iio: (bma400) basic regulator support
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
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

On Thu, Dec 19, 2019 at 5:27 AM Dan Robertson <dan@dlrobertson.com> wrote:

> Add support for the VDD and VDDIO regulators using the regulator
> framework.
>
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
