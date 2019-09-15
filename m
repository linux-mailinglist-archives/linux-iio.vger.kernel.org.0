Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E34B3067
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfION65 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 09:58:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46270 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfION65 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2019 09:58:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so20881081pfg.13;
        Sun, 15 Sep 2019 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QjVD1MMdk/FXtNa009HogFi/QLJcL3y6VpTbyueyzoo=;
        b=NvvDQikmIwMOgHRAQDAxT0PD2iF4nFXe2Jokw9BcMZCtgEfAbCTelvVXqbA6fAJGjU
         wi4r7R8Yb9mZ2oBochAwcerd82HYYRcqoyf90BWUClWYYi57qKGqrIRpLZmgcwVMzDP/
         RTfY50BWTDkk+zgseeKQmVIk27+5/whx76zrs+Z8NSFLioWrC+2jwH04VnvFasAkxtcz
         ApXv4m9kFDAfu9Mhc5ZtucmZYTzn9ivDwfTwEKyQkQnO8EdKNiKsOf2WIkbY85m43e5U
         IhablPk5A0J0sOmPYJIR5NOjYPmFD003JSBv2K3DS3cCGbu2aK21jGDEkIFNpUk8tUvn
         /Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QjVD1MMdk/FXtNa009HogFi/QLJcL3y6VpTbyueyzoo=;
        b=hjTVBb0gWOOpIZOTTeT0dpaC2nPrYxTa5QMzFt42dT4s9G/M2fua/QNl18nFmlo1Wl
         0hWk8N2u4FNiSRdMTqZX5NLFuCzqO12MhajBLc+TDooe55TKsKKAiAakBK5ryY/fXku8
         JZmfIrnRa3rTjWF8IRcpun1wyU36NK3+oabAiql+q6lkw1CzmQlHPLki2zA2XLygDs6s
         Qte0MKPiZ8dBwXaHpu2+m059XVuvb+cmvKOZ1T3B9t9Z+CW1Kdq6IYRC6UwPmHORlw02
         TcmYI2YEiJWc+V0bnRWp1vXO0ewl7zorwZ2MFABTaqkuz2Z424MEn/WOlYPE+pbrBH1i
         frkA==
X-Gm-Message-State: APjAAAWtAknKCOBygrSKJz8Hn6Hqryu5E+XiObeZeqiVuojDNz2cwPV8
        9SSv29jdTj2CScpW3G/0AoXGa351
X-Google-Smtp-Source: APXvYqwh2yppXgwN1J4EuZt2a8HhwcJABa2EVvyOMUuxKziF4GY/wSD0JqJCR9/km02SneP5owDcCg==
X-Received: by 2002:a63:f07:: with SMTP id e7mr23157797pgl.238.1568555935172;
        Sun, 15 Sep 2019 06:58:55 -0700 (PDT)
Received: from icarus ([2001:268:c144:8b8a:e7a2:82ca:6689:77bb])
        by smtp.gmail.com with ESMTPSA id r6sm4786675pfh.1.2019.09.15.06.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 06:58:54 -0700 (PDT)
Date:   Sun, 15 Sep 2019 22:58:23 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFC 1/4] counter: Simplify the count_read and count_write
 callbacks
Message-ID: <20190915135823.GA445580@icarus>
References: <20190915055759.408690-1-vilhelm.gray@gmail.com>
 <20190915055759.408690-2-vilhelm.gray@gmail.com>
 <20190915143917.61385369@archlinux>
 <20190915144700.0f7a361d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190915144700.0f7a361d@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 15, 2019 at 02:47:00PM +0100, Jonathan Cameron wrote:
> On Sun, 15 Sep 2019 14:39:17 +0100
> Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> 
> > On Sun, 15 Sep 2019 14:57:56 +0900
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > 
> > > The count_read and count_write callbacks are simplified to pass val as
> > > unsigned long rather than as an opaque data structure. The opaque
> > > counter_count_read_value and counter_count_write_value structures,
> > > counter_count_value_type enum, and relevant counter_count_read_value_set
> > > and counter_count_write_value_get functions, are removed as they are no
> > > longer used.
> > > 
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>  
> > 
> > Seems like a sensible bit of excessive abstraction removal to me.  I'm not
> > totally sure why these got so complex in the first place though.
> Ah. I should have read the cover letter rather than just diving in the code :)
> All explained there I see.
> 
> > 
> > Can you recall the reason as it might help to judge why we no longer
> > think the same?
> > 
> > Thanks,
> > 
> > Jonathan

The cover letter probably explains it well enough, but it may be good
anyway for posterity to add on a bit about the origins of the opaque
structures.

If I recall correctly, it was from early on when I had a dedicated set
of functions for "quadrature counters" as opposed to "simple counters"
-- eventually we abandoned that design and decided instead to keep the
interface simple since devices could be represented robustly enough with
just the core Count, Signal, and Synapse components.

I decided to keep the opaque structures anyway in the hope that they
could be used in the future to restrict the attributes exposed to a
certain set of "counter types" defined for the Counter subsystems; i.e.
"position" counters would only expose spatial coordinates, "tally"
counters would expose tally units, etc.

However, I've come to realized that this type of organization is best
left to the userspace application and that the kernelspace code should
instead be focused on maintaining a simple and robust interface for
representing the core concept of a "counter" device.

William Breathitt Gray
