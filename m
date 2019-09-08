Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301EEACCA1
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 14:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfIHMT6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 08:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbfIHMT6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 08:19:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84751214D9;
        Sun,  8 Sep 2019 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567945198;
        bh=fnkqAfVLUJ4qvZ5PJf1M7+UzktzaEfSD/LXhQephNIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YbIwTzpBZ2RGH4AGcmyQEX5Lf4QyoCa2z0MtzEZiAytP54z5eDIWjA9SxTPsB6Tba
         IcAgbBj6bVstSwnjw5xMR7cJxxTw/86hJe9YPTsm5nPxa2qfelJhX8vcRZGQM15viN
         0obVfzM/qVnCsBM85Y6uzRy4Xre0WXb2Unwh7I8w=
Date:   Sun, 8 Sep 2019 13:19:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: Re: [PATCH 6/8 v2] iio: adc: New driver for the AB8500 GPADC
Message-ID: <20190908131953.50fdb416@archlinux>
In-Reply-To: <CACRpkdZuEMGfrhYX=cgFa2PaAhNmT+RQ8eeu42HAQxOM0c=Mkg@mail.gmail.com>
References: <20190822145233.18222-1-linus.walleij@linaro.org>
        <20190822145233.18222-7-linus.walleij@linaro.org>
        <20190826094643.6d4f5cfa@archlinux>
        <CACRpkdZuEMGfrhYX=cgFa2PaAhNmT+RQ8eeu42HAQxOM0c=Mkg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Sep 2019 16:55:52 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Aug 26, 2019 at 10:46 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > Linus Walleij <linus.walleij@linaro.org> wrote:  
> 
> > Note we have standardized the specification of ADC channels since
> > v1.  See Documentation/devicetree/bindings/iio/adc/adc.txt
> > It's fairly similar to what you have though so easy tweak
> > to bindings. I don't think any change in here is needed.  
> 
> I've aligned it in both the patch to the bindings and my device
> tree patch, thanks!
> 
> > Some minor stuff inline otherwise.
> > Fix those up and you can add
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Thanks!
> 
> > What is your merge plan for these?  
> 
> I was planning to rebase them for v5.4-rc1 and merge through Arm SoC,
> but since most of it is ADC-related maybe it makes more sense to merge
> the whole thing through IIO? (Except the DTS patch that I will take through
> the ARM SoC tree anyway.)

I'm happy either way.  Just let me know.

Jonathan

> 
> Yours,
> Linus Walleij

