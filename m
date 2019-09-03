Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D69AA6BFA
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfICO4G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 10:56:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39671 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbfICO4F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Sep 2019 10:56:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so16211597qki.6
        for <linux-iio@vger.kernel.org>; Tue, 03 Sep 2019 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+9Lj6cBBBL3exZ7mZakN+ZO8p9XERfCaQQWM4gueO0=;
        b=y9oDUNmHg8whqlJ+7lPVYqa7oky/csN8uq+jOFRia0xKQQ4G1071JJDZ87jslD75V8
         mIWsTBem2t4J7JZZwH3d7tNLNp+RuThBiatMyUzU0idrjO04gADt/gpM930ebct4/gMG
         5eHXiZaa7SVs1CrTl9DBAVupbglC5mgoQfzJUYWHeVcPqjh+8aeUX/sULEyhijkac859
         K1x6on+ijmel1yI83Bv0GoGJo8pVui1HReZ+pGGkWZxkxtnzeSCdqYvstGDXgrb/WPRB
         9nRNbejcu8MWTXKyTGUAl4tR79bI/eHPq9zBejLN7D+5H8+I4uPI5x/KvhkJyBXNx4cl
         bpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+9Lj6cBBBL3exZ7mZakN+ZO8p9XERfCaQQWM4gueO0=;
        b=s3P6ZAzuOskRWLdq2Do2P6++gKrLiIbL7CWAXsqFOjyTcgAzwm/4ZHCw8Ieg3d20ky
         K2BNpgg4fzd60JZ5yW29/iCwR1c/WytJ6jfsdncihdK/6EpIyfiR1xg/YUTcbMpIx8hE
         K0k12zFuutm3Yeu/CPPsFSoPTvKxxuh9pJY10Gc/iwSoFzhZVPNOgwq+EGwmkq85UYcq
         F5TLaUyggNwHSqlbggqjQiDjV1xI9CFbJD+V5zMyXjsi6pFAimazjifBlMy679AVcaL7
         knnb9O3Gzb46wmBCzFT5yvDeK5HDMd7YoB8RsstuyLjpUmmHO9OXB7c8gEWy2UWLOvtZ
         oYdA==
X-Gm-Message-State: APjAAAXUYw6/c6TTgoGIBnYfiF7fxH6m5KkZG8Mvph60xX28vRjAC9SC
        3EDmstT34bdblPliVED3pQVqLADwnJsHoYKbbOWKQg==
X-Google-Smtp-Source: APXvYqwWLNljDiHPpLPGCQkfwq/M7dJWIM1aJg9x/uzdSXIxAylKPrpiEM3ePCr/XBvFdLlKe0HGdCpjEQjqmlmxJns=
X-Received: by 2002:a37:4747:: with SMTP id u68mr34372233qka.42.1567522563779;
 Tue, 03 Sep 2019 07:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190822145233.18222-1-linus.walleij@linaro.org>
 <20190822145233.18222-7-linus.walleij@linaro.org> <20190826094643.6d4f5cfa@archlinux>
In-Reply-To: <20190826094643.6d4f5cfa@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Sep 2019 16:55:52 +0200
Message-ID: <CACRpkdZuEMGfrhYX=cgFa2PaAhNmT+RQ8eeu42HAQxOM0c=Mkg@mail.gmail.com>
Subject: Re: [PATCH 6/8 v2] iio: adc: New driver for the AB8500 GPADC
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 26, 2019 at 10:46 AM Jonathan Cameron <jic23@kernel.org> wrote:
> Linus Walleij <linus.walleij@linaro.org> wrote:

> Note we have standardized the specification of ADC channels since
> v1.  See Documentation/devicetree/bindings/iio/adc/adc.txt
> It's fairly similar to what you have though so easy tweak
> to bindings. I don't think any change in here is needed.

I've aligned it in both the patch to the bindings and my device
tree patch, thanks!

> Some minor stuff inline otherwise.
> Fix those up and you can add
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

> What is your merge plan for these?

I was planning to rebase them for v5.4-rc1 and merge through Arm SoC,
but since most of it is ADC-related maybe it makes more sense to merge
the whole thing through IIO? (Except the DTS patch that I will take through
the ARM SoC tree anyway.)

Yours,
Linus Walleij
