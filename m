Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0539A128EA9
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2019 16:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLVPil (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Dec 2019 10:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfLVPil (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Dec 2019 10:38:41 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9ED620665;
        Sun, 22 Dec 2019 15:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577029120;
        bh=a7bLy4tv+Tle7/kVIxiyYP5eExw49e47BFejagpswKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nH44wjCyUyiP+2TcM51/oEhZ4ub4soA+e7ZtmtRumEztiM+2l7ig9QWF3f83nOjBd
         ltd3qadqTsgokNiOfinEzLjKeeIjr6C6ZS8oKvCaHtTcx/uFhWbtFNwePy7utcJ41Q
         uasM+PY2A0OZ+l60FRLJ/NYxpV1QYzF8Mfoi9cBQ=
Date:   Sun, 22 Dec 2019 15:38:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dan Robertson <dan@dlrobertson.com>,
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
Subject: Re: [PATCH v8 1/3] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191222153835.6976de55@archlinux>
In-Reply-To: <CACRpkdb07VLWeBbSGs1qvmXfXyLFPFZWxiTKVEfan0cAnrbiLw@mail.gmail.com>
References: <20191220160051.26321-1-dan@dlrobertson.com>
        <20191220160051.26321-2-dan@dlrobertson.com>
        <CACRpkdb07VLWeBbSGs1qvmXfXyLFPFZWxiTKVEfan0cAnrbiLw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Dec 2019 17:34:52 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Dec 20, 2019 at 5:16 PM Dan Robertson <dan@dlrobertson.com> wrote:
> 
> > Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> > accelerometer sensor.
> >
> > Signed-off-by: Dan Robertson <dan@dlrobertson.com>  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing.

This one seems straight forward, but if anyone else wants to comment,
I won't be pushing out as non rebasing until next week so can add
tags etc.

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

