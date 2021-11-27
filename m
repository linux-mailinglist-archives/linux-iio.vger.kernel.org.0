Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A754600FF
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 19:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355988AbhK0S5N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 13:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356043AbhK0SzN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 13:55:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8EFC061757;
        Sat, 27 Nov 2021 10:51:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1505060F07;
        Sat, 27 Nov 2021 18:51:02 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 05C43C53FAD;
        Sat, 27 Nov 2021 18:50:56 +0000 (UTC)
Date:   Sat, 27 Nov 2021 18:55:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: add AD74413R
Message-ID: <20211127185556.5d91fd83@jic23-huawei>
In-Reply-To: <CACRpkdY6gCz3X_DWUj+BZEeMYGHN3T2ty5Kq7_W+Hq3jgjaKjw@mail.gmail.com>
References: <20211126160219.674665-1-demonsingur@gmail.com>
        <20211126160219.674665-3-demonsingur@gmail.com>
        <CACRpkdY6gCz3X_DWUj+BZEeMYGHN3T2ty5Kq7_W+Hq3jgjaKjw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 27 Nov 2021 02:23:26 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Nov 26, 2021 at 5:03 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
> > +  adi,rsense-resistance-ohms:
> > +    description:
> > +      RSense resistance values in Ohms.  
> 
> This description is very terse. If it is existing for the same purpose as
> shunt-resistor-micro-ohms in
> Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> then you should just recycle the standard binding
> shunt-resistor-micro-ohms instead of inventing this custom one.

Good point.  I'd forgotten about that one.  We had to make that generic
as a current sense shunt inherently doesn't have a vendor :)

Thanks Linus!

Jonathan
> 
> Yours,
> Linus Walleij

