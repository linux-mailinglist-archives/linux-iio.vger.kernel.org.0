Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB07E3FE7A2
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 04:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhIBC2R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 22:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhIBC2Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 22:28:16 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061E7C061575;
        Wed,  1 Sep 2021 19:27:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y144so511174qkb.6;
        Wed, 01 Sep 2021 19:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2bQ/MwPCTbrlkKoza/EVPxViIYBE0qHwqdYXeHVEcM=;
        b=IumXDT07dit1hpnuKUTUl635o9PnhYHsDFfM3ZN3AaTTbH/aZUSwEBdOpn7KZC0MNq
         3s87u7qPN2oi61zYOqR8ogz4N9FNZiiQ4J2TqGbjvUgFnYEVjgtCfEox/7QS3gfcYRiG
         1y+Wiyub/ZmJTYb/el1tiu5GHrK5Dv/picTVzKujAodLrYmAreZcWUgCWNB1IYLc8k0C
         4inCOPJ1SBufjT/c5+qi5j/6wTpGJAMexDFFgPYvdTT72pXFwgjnqyXp2JqwTOvCX0cP
         U/NgvqTQN6Boy1H5NNpHN/8FVqUjRP9hRQDj0ccod3qCmTY/fgzuIw56Fp+oEhLv05eE
         26+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2bQ/MwPCTbrlkKoza/EVPxViIYBE0qHwqdYXeHVEcM=;
        b=OAfk4Jb0ksMcR2fSsmV/FV1lSqRI0qaf2hNxMp/t1nWFX0rn0+Ps6gKOahryb2aKmR
         mjcIEDMllI+wiGt1FUgEvWYfhoN2lbyKXMJR8/M2pnOdAi0ddjo7/NfPjSNHwJif7Vlo
         xGplTJf0Z0SENnydh4FPN4MvXZ7HvyMkQiIsDLzaCMOMwdXIcLfNa4u1UxEL1qdkxrDH
         tTFPP8PqyQ3bqvwquIVknjAz2fFBHUn1v3Ui16w6EQMNDKh3dI77Qk22jxdxVrdsTvqp
         bbjLTpbsjhOgJT4rHxaB9DnYAKg0cLcUAcxHW/ILJZNSgOEaHhxBi8nNrW2QWi8VVuHx
         vjCQ==
X-Gm-Message-State: AOAM532R+sdVuWA2eNQFFkIb7va4jg7nRLyfXn7obCZvF9OLAJnaz11x
        l2MvLwiFPc9wHQX4fzFEkzXt/DmQ56Y=
X-Google-Smtp-Source: ABdhPJyd4t5wC1YlCk/a0i8EavBwMFZ/4uNPlfsuKyh6+27EayDo3pY2J3DOHnB4WTNS0AVm02Gzlw==
X-Received: by 2002:a05:620a:1aa8:: with SMTP id bl40mr1097903qkb.180.1630549638131;
        Wed, 01 Sep 2021 19:27:18 -0700 (PDT)
Received: from shaak ([198.48.202.89])
        by smtp.gmail.com with ESMTPSA id a24sm227570qto.18.2021.09.01.19.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 19:27:17 -0700 (PDT)
Date:   Wed, 1 Sep 2021 22:27:15 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
 fractional scales
Message-ID: <YTA2g2iHB3WtEMBp@shaak>
References: <20210820191714.69898-1-liambeguin@gmail.com>
 <20210820191714.69898-10-liambeguin@gmail.com>
 <2d028a60-d1fe-7fa1-da4a-0d80f8d468ea@axentia.se>
 <20210830122224.3efc5a63@jic23-huawei>
 <e1542f14-f271-a0a3-eaa1-092e12c3ed6c@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1542f14-f271-a0a3-eaa1-092e12c3ed6c@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 30, 2021 at 04:30:54PM +0200, Peter Rosin wrote:
> On 2021-08-30 13:22, Jonathan Cameron wrote:
> > On Mon, 23 Aug 2021 00:18:55 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> > 
> >> [I started to write an answer to your plans in the v7 thread, but didn't
> >> have time to finish before v8 appeared...]
> >>
> >> On 2021-08-20 21:17, Liam Beguin wrote:
> >>> From: Liam Beguin <lvb@xiphos.com>
> >>>
> >>> The approximation caused by integer divisions can be costly on smaller
> >>> scale values since the decimal part is significant compared to the
> >>> integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
> >>> cases to maintain accuracy.  
> >>
> >> The conversion to int-plus-nano may also carry a cost of accuracy.
> >>
> >> 90/1373754273 scaled by 261/509 is 3.359e-8, the old code returns 3.348e-8,
> >> but the new one gets you 3.3e-8 (0.000000033, it simply cannot provide more
> >> digits). So, in this case you lose precision with the new code.
> >>
> >> Similar problem with 100 / 2^30 scaled by 3782/7000. It is 5.032e-8, the old
> >> code returns 5.029e-8, but the new one gets you the inferior 5.0e-8.
> >>
> >> I'm also wondering if it is wise to not always return the same scale type?
> >> What happens if we want to extend this driver to scale a buffered channel?
> >> Honest question! I don't know, but I fear that this patch may make that
> >> step more difficult to take??
> >>
> >> Jonathan, do you have any input on that?
> > 
> > I'm a bit lost.  As things currently stand IIO buffered data flows all use
> > _RAW.  It's either up to userspace or the inkernel user to query scale
> > and use that to compute the appropriate _processed values.  There have been
> > various discussions over the years on how to add metadata but it's tricky
> > without adding significant complexity and for vast majority of usecases not
> > necessary.  Given the rescaler copes with _raw and _processed inputs, we
> > would only support buffered flows if using the _raw ones.
> > 
> > If nothing changes in configuration of the rescaler, the scale should be
> > static for a given device.  What format that 'scale' takes is something
> > that userspace code or inkernel users should cope fine with given they
> > need to do that anyway for different devices.
> 
> Ok, if 'scale' (and 'offset') of the source channel is to be considered
> static, then it is much safer to ignore the "island problem" and rescale
> each value independently on a case-by-case basis. We should add an
> explicit comment somewhere that we make this assumption.
> 
> Sorry for wasting time and effort by not realizing by myself (and earlier).

No worries, I was also under the impression that the source channel
scale (and offset) could change.

> 
> Maybe something like this?
> 
> /*
>  * The rescaler assumes that the 'scale' and 'offset' properties of
>  * the source channel are static. If they are not, there exist some
>  * corner cases where rounding/truncating might cause confusing
>  * mathematical properties (non-linearity).
>  */
> 

If this is more of a general assumption, is there a place in the
Documentation/ that we could put this comment?

If not, I'll add it here.

> I then propose that we rescale IIO_VAL_FRACTIONAL as before if that works,
> thus preserving any previous exact rescaling, but if there is an overflow
> while doing that, then we fall back to new code that rescales to a
> IIO_VAL_INT_PLUS_NANO value. Trying the gcd-thing as it ended up in v7 still
> seems expensive to me, but maybe I overestimate the cost of gcd? Anyway, my
> guts vote for completely skipping gcd and that we aim directly for
> IIO_VAL_INT_PLUS_NANO in case of overflow while doing the old thing.

I agree with you, I'd much rather drop gcd() from rescale_process_scale()
altogether.

I was planning on keeping IIO_VAL_FRACTIONAL and IIO_VAL_FRACTIONAL_LOG2
combined, but getting rid of the 100ppm condition in favor of a simple
if (rem).

> 
> Having said that, if 'scale' and 'offset' indeed are static, then the gcd
> cost can be mitigated by caching the result. Exact rescaling is always
> nice...
> 
> If IIO_VAL_INT overflows while rescaling, we are SOL whichever way we turn,
> so ignore doing anything about that.

I was thinking of using check_mul_overflow() to do something about the
overflow, but I'm happy to leave it out for now.

> 
> Liam, was it IIO_VAL_FRACTIONAL or IIO_VAL_FRACTIONAL_LOG2 that was your
> real use case? Anyway, your 100 ppm threshold is probably as good a
> compromise as any for this case. However, that threshold does nothing for
> the case where the conversion to IIO_VAL_INT_PLUS_NANO throws away way
> more precision than the existing operations. It would probably be good
> to somehow stay with the old method for the really tiny values, if there
> is a viable test/threshold for when to do what.
> 

My original issue was with IIO_VAL_FRACTIONAL.
I'll look into what we can do for small IIO_VAL_FRACTIONAL_LOG2 values,
and will add more tests for that too.

Thanks,
Liam

> Cheers,
> Peter
