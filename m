Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE18256F71
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgH3RHc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 13:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgH3RH3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Aug 2020 13:07:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F2C061573;
        Sun, 30 Aug 2020 10:07:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so3249058pfn.5;
        Sun, 30 Aug 2020 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMjyFGBWWFv0LuuBdjLpLERWkVOrqJ19BFy0/U/TZ4k=;
        b=ouJNefUDJiMdBSDEi5xOTaJJyioWu+vSjkCfg5bh70XhBqnuGzlDp4yA5MxbiWN4ub
         VDWR6TAeHIlrxIW4VsYEOgcOl4RtjUYcvbvqlVidmYMjnX/FTYxBvOAO/6jBblvHL1SH
         JTdEkalFmXccGDoeCkNjyHOneDOI0vnic0ENcWxGTg9ceuDHroYgZ+ndiPYB+DRBKZkS
         xWfQXqmMeUA0vkFuFO1Pv0GaHPzzbYyq/In8VrAMsFloRkYaudTsj/5qL1/jbbCSqSwp
         qQlyTOa6u/J4QCEyTDA/CKas2QpVni2ngYaevVEnAigjZUcWFGbiKSYIQpIJMSKl5qGU
         4gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMjyFGBWWFv0LuuBdjLpLERWkVOrqJ19BFy0/U/TZ4k=;
        b=FDeqO+6qQJez0NqYHEfeP9TgyO1fgdssX6rpuF93fLMaNGXwvcsoaP0oyAz3m6yW+8
         /g/8Q0e22t8vRF0RjphGexQP2RkUoRXwtWhywLVWrTe5SAn8DEuGspuTNvZInCJ/0SE/
         3nXCRw9xtTY1u4oW6BEa1PSFqZ+ftoZ8dH4nwO9PIdp1+NAchZ8UbyEHmnfl6iPZh97c
         25is1+Tm2vlkZFgRiDTHy81gSxUtPU5togUNonC7VJgkqnnHT+6GS+InMaE3WrqAGoXD
         nhCX2itqO9FefK3mj3ML+6X5p57I+9mFL4j+LtzF9CQvwYIFVJ27algwpCzwMs7Bxa8+
         qsuA==
X-Gm-Message-State: AOAM5309gxJFghFCSnxTOt/bsdSAgiG0+LTMc9PtFJywbn1zSipPeN6U
        yovaS45V/6q9K1Vi4WQr33h5NFGUZghR0/gZfWbEQgM/imDETw==
X-Google-Smtp-Source: ABdhPJz6MTJTNv/YcqhFKeWQsVO4HFCc408Ke9R/sb8IOV1QV6lPH51hKfb+XOvv9an8xE+tfmTe+sZvuzHyy0ZgWXc=
X-Received: by 2002:a62:7c86:: with SMTP id x128mr1059391pfc.268.1598807246571;
 Sun, 30 Aug 2020 10:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
In-Reply-To: <20200824054347.3805-1-william.sung@advantech.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Aug 2020 20:07:09 +0300
Message-ID: <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     William Sung <william.sung@advantech.com.tw>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 24, 2020 at 8:54 AM William Sung
<william.sung@advantech.com.tw> wrote:
>
> To use ad5593r more flexibly, we use the module parameter to setting the
> channel modes dynamically whenever the module probe up.

> Users can pass
> the channel modes to the module parameter for allocating the
> functionality of channels as desired.

NAK. We have a sysfs interface.

> For example:
> * Use in the kernel command line:
> Users can add the module parameter in the kernel command line such as
>
>     "ad5593r.ch_mode_cmdline=88001122"
>
> "88001122" means the channel mode setting for each channel. The most
> left side indicates the mode of channel 7, and the most right side
> indicates the mode of channel 0.
>
> * Use when manually probe the module:
> Similar to the kernel command line usage, users can enter
>
>     "modprobe ad5593r ch_mode_probe=88001122"
>
> to start the ad5593r module with the desired channel mode setting.

Again NAK, this basically should come from Device Tree or ACPI.

-- 
With Best Regards,
Andy Shevchenko
