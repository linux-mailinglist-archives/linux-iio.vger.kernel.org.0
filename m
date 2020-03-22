Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF40318ED4E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 00:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCVXgL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 19:36:11 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38184 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgCVXgL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 19:36:11 -0400
Received: by mail-pj1-f66.google.com with SMTP id m15so5199892pje.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 16:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZZN17605p3Wkg+GwpkypM2qbP4Tm2zfjDHOlZTvOO4=;
        b=CZklPp4Gm+W8yjuSlg1T59mDHIcxG8wVZSOvFaZPGjT+U4uuxfSZG5a1SVdAN0QdHl
         42ZWF2PIZ/u0oWCrlub7zHLdlhm+Hh0W1/xx6OXqDYT7akVytAXvYkiHyv/Pl413xLxx
         t3tB2AYMv5jZtcT7u2QeEWiVeSFSy8xDh/x/bmQuME1qA/VRX8F9DSKxMsTVCleaIntp
         YiIqlE8X92zFzXOqIxDGrqn8Bbjr40cIaSZrYABTslYYrgTFNnl1g2o8axerhqZ31PUj
         OIEyOJrbsNIwzKc2JNVmZCJK5JcUtG0uwCh1RV8XLQVQikD4R16hfIy/RgzyCwHXgC/0
         W4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZZN17605p3Wkg+GwpkypM2qbP4Tm2zfjDHOlZTvOO4=;
        b=joQkPQRwW7w5ma6TC+SEfUkBscU+esOIUyrIqlvYhsKRdor0SGwvKInlMLHbpz9IIu
         KPLMTEH1Mhb3XeE/6VOFXlAiddJLUnd1VQh/efuTxfn1gAa+Alq+9TjJZmBKsjxtEVg8
         V+lidxuK9GZkX3mt3Qy0uHKi7g33Kp+EtEgQCr0mMp9Hy63takBweZsMBcP8t+VAUATd
         zJ/NP6JlsWf5ptx7QXAyPpyPgANRDueVPXBexZuCxoM8vfewucnWAe3NuACO1KLpya/l
         mLT7TSfNdm9+qMOntnhZxOmnlFrYB8csmLZWHrTDp3/GvxOGymw6AsQzKq/N/enppNXK
         lZPg==
X-Gm-Message-State: ANhLgQ0CLmBfPzC186VQ56Xl8nXY5hc77wAdnh4UAeRSh9hGyOCynQOi
        wdJPiYd/ads5+QKBF1pOpylDMKY/W9hGViA/Ros=
X-Google-Smtp-Source: ADFU+vvuH3O6GLPsqCu4t2RbBH4ldHLcJkKeqT8bgagMvuak3I4XsW0iFE2DEYH4k5ID8OEsgzk/3cvPnE8ci1cY7xg=
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr22345063pjn.8.1584920170006;
 Sun, 22 Mar 2020 16:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200322185350.GA12377@deeUbuntu>
In-Reply-To: <20200322185350.GA12377@deeUbuntu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Mar 2020 01:35:58 +0200
Message-ID: <CAHp75VcP1O_QwepgAHPBaTLcr_3=ynV6hsmcgvYnBCz7DdoWxw@mail.gmail.com>
Subject: Re: [PATCH v2] media: staging/intel-ipu3: Reformat pointer initialization
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 8:54 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
>
> Reformat pointer initialization to make it more readable as per the
> coding standards. Problem detected by checkpatch.

> -       struct imgu_v4l2_subdev *imgu_sd =
> -               container_of(ctrl->handler, struct imgu_v4l2_subdev, ctrl_handler);
> +       struct imgu_v4l2_subdev *imgu_sd = container_of(ctrl->handler,
> +                                                       struct imgu_v4l2_subdev,
> +                                                       ctrl_handler);

I'm sorry I don't see benefit of this change, actually an opposite.

-- 
With Best Regards,
Andy Shevchenko
