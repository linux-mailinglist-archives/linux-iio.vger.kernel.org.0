Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D044B917
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 23:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhKIW7a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 17:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbhKIW71 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 17:59:27 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90817C097E91
        for <linux-iio@vger.kernel.org>; Tue,  9 Nov 2021 14:43:12 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v64so1392363ybi.5
        for <linux-iio@vger.kernel.org>; Tue, 09 Nov 2021 14:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E14wsnocZsNPMsjFRvpJekIeY+Vz8I74zIl8XM95qHY=;
        b=QbagfwCP8UafCbTrbAyxDcOCArf0wenwUPJGXCk9+LFai5aEll8MPNAnOnKHA9p04u
         j/l5awP1dE5+A0o6rR3+zYXPdDBlymOr+VZuy5FqU8KmkCBYxLuemDF0+eCZD/Zo/QIs
         qsl8R0XdR5FP0X5zd7VRL7HMAHVe/ttj3tDJwKYVg6rciVlllUVJCURvHe3bI/u/P8dP
         lSjUcOG0RJivSPsTksX1++LntdoRhlG1589fSAA/KNTn2QNUPHkhHWsJ53MRVxcz72QM
         8ORusLrvoc7oH6vh7+Aqs67asfCiClBb6ABpyK2UPtbD67cgj/0krRE2+ykzEtb43j56
         HNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E14wsnocZsNPMsjFRvpJekIeY+Vz8I74zIl8XM95qHY=;
        b=WkJDzPXrRRaB7zNQ6Q2Wb5Wz5ESEzvZ//CZ8KvOkSrgkZk8UDbSu+dOv4alPjU7Kw6
         t2eyx5MWJzH7BRU7l85npl07lpGXVtEZBW8Ww3nENqEc535Z/OwfaHw3f8VqsS+XrsIj
         62UC6JCZPr4w04q28FPFLGAMBTcYs7x74tBOxdBFz7RJUkhHZrsXBeW5+2twr/rrMNoQ
         XRRSmbBvY9s2X31mWWvf5C76HxEZvRwXImEODJzfBWNNPVIwCKAE/PzBcQYkHOqXx9/s
         KsupQcahNyYntq5EjVbBhvtu1Ko7EKG7v9uwmlwLlf0mTSaN+0fct9T+p1zF4o6q7Uuu
         XLfQ==
X-Gm-Message-State: AOAM532uI5aAA6sMQCCg19VURfkcvjN3NykbNJ5+zWxCjfFDKZPhreWJ
        WGwD1ekNGG+HR+Qg37eiSFBeqmgTVjOqgUl9e5udng==
X-Google-Smtp-Source: ABdhPJy1awYRVTWTUHGP/Ep/Ov9QcLzj0ggJK4twrVUy3+OJAFCebsv6wIw14C0uifTK9bLEdYzpfCLv/lzQjrSw/gI=
X-Received: by 2002:a25:dbd4:: with SMTP id g203mr11886892ybf.508.1636497791666;
 Tue, 09 Nov 2021 14:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20211109200840.135019-1-puranjay12@gmail.com>
In-Reply-To: <20211109200840.135019-1-puranjay12@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 9 Nov 2021 14:42:35 -0800
Message-ID: <CAGETcx9-WoAa8VbEPSthseYNz=L-gnoXLcHFtHrD_+yhQXmJnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] device property: Adding fwnode_irq_get_byname()
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 9, 2021 at 12:09 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> The first patch in this series adds the fwnode_irq_get_byname() which is
> the generic version of the of_irq_get_byname(). It is used to get the
> IRQ number from name of the interrupt.
>
> The second patch in this series uses the fwnode_irq_get_byname()
> function in the IIO driver of the ADXL355 accelerometer. The driver has
> been tested after applying this patch on a Raspberry PI. The ADXL355 was
> connected to the Raspberry Pi using I2C and fwnode_irq_get_byname() was
> used to get the IRQ number for the "DRDY" interrupt. Earlier this driver
> was using of_irq_get_byname() to get this IRQ number.

Why do we need these changes though? Is there a non-OF device this
driver would ever probe?

-Saravana
