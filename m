Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21990263330
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 18:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgIIQ7H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 12:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgIIQ67 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 12:58:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A665C061573;
        Wed,  9 Sep 2020 09:58:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o16so1638583pjr.2;
        Wed, 09 Sep 2020 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwWId/wck3bd+vLBnYQNSdgBdWb7exMcGqB9S1NWJKE=;
        b=UbTIs2+2ydRVwB+sLVePiz7hJjucPqR+ntLyd137U6pdYBnUTo/6A9Rb77ECihq95S
         sFATauSuQMctvBVq1NJQ8q93gdLaMg4i+g+lxRbFlE1792i5YNORNVJkdl9aoDF332i4
         f7TpQgbVTlMiKeR0KdGCTs/xB4eHJ6SfTSrdyhWuRF3hQ34hqScbdSfkSX79PX2OAJw1
         EUqyUm9eDZe/Qh8NbMBgtyCneuDzF4n7CLDSEhwl55hdXuD7L+zbKq9zg94jiQKYoQCx
         aehyZEJ3fPMsiMM6wy1Krz+j2muU794mY1VlgKgmcog+UscpVDkHoDy9TFr71RM+W7tN
         cTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwWId/wck3bd+vLBnYQNSdgBdWb7exMcGqB9S1NWJKE=;
        b=sY4YM1yAPa565cBDMPygaUaOD++4rdPuYDaNFvhzZW4MSZMqi6PMoxrPSwdhEp1Y2x
         /qy5gO9RVHpP16yM34RKhMpMO3fGpuZdvi7BiPjALd0lveBqH4G9Cr9CeMcSX/tYmYTV
         Qgf7E+2X1zMscGaUBPz7VucJEtYgxMPCADeSO7VII06jSV+TztJcK6TwZVmw4krUZsvr
         B+kCqQ8zCnbJEzj+U73joFIny611WmAgpWmUcp1LHv24Eo6wW15b3zMdBBhF64NVXhYi
         /aQKdkQckClD7e0jH4Q0JenyE3nSzm6iBffM06u4BnGv/478XzjS9WjIZeqhR3SQ40og
         xI9w==
X-Gm-Message-State: AOAM530xQVqpwmhIE5Ei8QkUxMlutJQ0nCVGB/fUtS0ZCBQQaO2z4xKm
        00umvGbl94+VFS5PmluBCJCc2lL6U9YCeaV/Sgx87MyAU7Nzdg==
X-Google-Smtp-Source: ABdhPJzheBF5r0rY0eVQhDpQnLbgUkatHbevzu+QTXFNxqXzrPI6QkJ1AbupNIWBFOxMGd2Z9B0v0iBmSZl9C5oIpfw=
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr1608163pjb.129.1599670737094;
 Wed, 09 Sep 2020 09:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200909154439.10308-1-ceggers@arri.de>
In-Reply-To: <20200909154439.10308-1-ceggers@arri.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Sep 2020 19:58:39 +0300
Message-ID: <CAHp75VeAoDaBtaSb0Qeb=kHPg6kGvx71_iL2snC5iHh4cKPhRA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: as73211: Increase measurement timeout
To:     Christian Eggers <ceggers@arri.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 9, 2020 at 6:45 PM Christian Eggers <ceggers@arri.de> wrote:
>
> We found some sensors which are much slower (20% at room temperature)
> than nominal. According to the data sheet, up to 27% is possible. Now I
> add 33% to the nominal time out, hopefully this is enough.

I'm wondering if this is a function of temperature.
And if that has an actual thermistor inside...

-- 
With Best Regards,
Andy Shevchenko
