Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A074569BAF
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 21:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfGOTui (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 15:50:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40922 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbfGOTui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 15:50:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so8215371pgj.7
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lQwGFBSJrHwE56v+sMPF66PmP6cnKf9PXAh7/ixpFm8=;
        b=kvofDYs+CxOi4c6fxfaQSVUUMlY8Kie3qdAMQOhymbNdqrVlywpHwjG4tRgJE/LmHg
         zSn3iji6OYuYG5lYDY6q8aKvPyEfsXmeDDExSU01MwqkdAU3a4Pu0ketbzDOFszRfI+h
         yQtf0Vx3mZL2dySLvv0O4yVYJXK20aAu20fBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQwGFBSJrHwE56v+sMPF66PmP6cnKf9PXAh7/ixpFm8=;
        b=jKsY7OmXpmFUETooajDhAUOYAE56WurS6QSPOZ5+dx272DZ0XvpTkP3LqjJKz3a9Th
         6BIFhsKtrE+I69EMbDgLKpO7qAWJxEsaxvDBdOJKIKMsbGFveIKPEfDgYRexXchlD/nk
         +jyS1My3qLFwtO/3uDx9YH1QQGTtymZguq9topvwf3wq9TvN6ATyv5pGFp+A/fbcYPDF
         H1+vN7DzYGIwzfJeVlfAEzuoYzeBYUF+GguUEj4BK9lcOHu+so+NCViIX1y7sKg2aTJS
         T9wbBn5Dcamp/6f0RoFVOhiqNAsyPqHKOy78lZ4nySWGEcufCr1ApatiAFTuGuJM/Yxs
         ajZg==
X-Gm-Message-State: APjAAAVB2VwuBjou1/t8sM29z65vqAXqCR80yIGIe9dj0bbZ6UNxXfl5
        jAP3LTkDnaxQGN8jIAvMrtv6DA==
X-Google-Smtp-Source: APXvYqz4l02Bj/OF1K57cTxt0+V+l7ssKwbhcEzYZrCJfJvHbS1Dg7KWSl0MzEx8ubXag1rcxlgaAA==
X-Received: by 2002:a17:90a:d151:: with SMTP id t17mr30870146pjw.60.1563220238045;
        Mon, 15 Jul 2019 12:50:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k22sm18338251pfk.157.2019.07.15.12.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 12:50:37 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:50:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Always release lock when
 returning from _read()
Message-ID: <20190715195023.GS250418@google.com>
References: <20190715191017.98488-1-mka@chromium.org>
 <CAD=FV=WT6TT+iyGVNUhNcmAsVJip6X4mytuNJPGwMkk4F4i75g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=WT6TT+iyGVNUhNcmAsVJip6X4mytuNJPGwMkk4F4i75g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 15, 2019 at 12:40:42PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 15, 2019 at 12:10 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Before doing any actual work cros_ec_accel_legacy_read() acquires
> > a mutex, which is released at the end of the function. However for
> > 'calibbias' channels the function returns directly, without releasing
> > the lock. The next attempt to acquire the lock blocks forever. Instead
> > of an explicit return statement use the common return path, which
> > releases the lock.
> >
> > Fixes: 11b86c7004ef1 ("platform/chrome: Add cros_ec_accel_legacy driver")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/iio/accel/cros_ec_accel_legacy.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> See also <https://lkml.kernel.org/r/39403a4c-bf7f-6a98-890c-57397fa66493@collabora.com>
> 
> Actually, the "Fixes" tag is wrong here, though.  The problem only
> exists because we have <https://crrev.com/c/1632659> in our tree, AKA
> ("FROMLIST: iio: cros_ec : Extend legacy support to ARM device").
> Before that there was no mutex.  For upstream purposes this could
> probably be squashed into the original patch.

Oops, I didn't realize that upstream doesn't have the mutex. In this
case the entire patch as is with it's commit message doesn't make much
sense.
