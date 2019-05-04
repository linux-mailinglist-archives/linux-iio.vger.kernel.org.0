Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC79E13972
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 13:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfEDLMe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 May 2019 07:12:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42020 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfEDLMe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 May 2019 07:12:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id f23so7557348otl.9;
        Sat, 04 May 2019 04:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wdgzat9GNRyIGbxR7C3Z7X+GP78JD3qzbFV7NRAacTA=;
        b=okfHOiGDGkWULDmqf0cp2YMr3x6UsqExFume52CnakuFFA4tsOhki4semX533ppbfW
         lvr8xk+teD5FgXm45Ws3KyW15/9sY0BpqX7onpCrvJBEj42+OvoBenp3qSyvJU8I4uyD
         ERsPSWZcqx6RhkTMgqWUaL50+1l1xG4riuQIfpneKp6TpMuTqNzlOCm4IXE2E3Hnw/zX
         T8tEz7GuxHdrQ3XMnL0Q9ww+0VWlYIVigJY8SNDXhEHIsV98ecnfSqEU12XIE4WyXrwX
         N+oKFbOU74lh46JlR/ZF6jv7Qq0GpqnfVXjVC27gR96fNmAizcFeqleL5mXffbPQNBJ2
         BBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wdgzat9GNRyIGbxR7C3Z7X+GP78JD3qzbFV7NRAacTA=;
        b=VRBhDQ3wzLCNs4f0EnDA0s0C3GVnEJXKSq7fr/iTeLsGPLRVRpO3g37HB+7zgqskjl
         GQb7AynfC/fDGJOlUl3rruNCmzS9bFqEdm6nbg1V/btlBQL5zEtC57prS8zln49lkr7p
         TbpQHHrh7XHi8XVZgO8pqeZLXZ2NerZVlg4qPWdtcIc7Zi2I2tUDeV2Vp9WpCOep7yC+
         lsqE/V3sRgnuQudLw3pqLMYBMhb8QsUT+Kx/fAC3mxkXCyp9Nn1pU5CjpYnuwmv7bg1e
         LBqaRMP2fr0pQZbZPgpUlMfbmQxCqvOg0U3Qr9CKqcNzs1pM2QNQT2HPReUzqkqgsi/X
         XLjA==
X-Gm-Message-State: APjAAAUV0tEWw3JApoY1wJy3Zp2GQ/vBMbI6AHxXrjMUZuIff7oLy7AX
        gzgIMgjG/6Bs0BDPuJYPsr03UWKBjggj0xTiVEY=
X-Google-Smtp-Source: APXvYqwWmBzM+pWb1OHLXUNCoiFbZs8cR6lhs9O5+BlpQMMj+fFpPxDmiDkHrb7fFtk2hqYEqd5WtfVBpAAiLUsMEa8=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr4142103otm.66.1556968353301;
 Sat, 04 May 2019 04:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556919363.git.melissa.srw@gmail.com>
In-Reply-To: <cover.1556919363.git.melissa.srw@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 4 May 2019 14:12:22 +0300
Message-ID: <CA+U=DsqiRBAdGK0aqp5Chv-AtuL8W47tu+Bq6O_Pc97HYbewkQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] staging: iio: ad7150: improve driver readability
To:     Melissa Wen <melissa.srw@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 4, 2019 at 1:24 AM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> This patchset solves readability issues in AD7150 code, such as clarify
> register and mask definition, fashion improvement of mask uses, reduce
> tedious operation and useless comments.
>

Hey,

Two patches seem a bit noisy/un-needed.
The other 2 are fine from me.

This driver does need some work to move it out of staging.
I am not sure what would be a big blocker for it, other than maybe it
needs a device-tree binding doc (in YAML format).
Maybe Jonathan remembers.

Some other low-hanging-fruit ideas would be:
1) remove the code for platform_data ; that one seems forgotten from
some other time; the interrupts should be coming from device-tree,
from the i2c bindings
2) you could do a AD7150_EVENT_SPEC() macro (similar to
AD7150_TIMEOUT() macro) and use it in the ad7150_events[] list; that
would reduce a few lines
3) similar to 2), you could do a AD7150_CHANNEL(x) macro ;
4) in ad7150_event_handler() the checks could be wrapped into a macro,
or maybe some function ; i am referring to "(int_status &
AD7150_STATUS_OUT1) && (chip->old_state & AD7150_STATUS_OUT1)" checks
; those seem to be repeated
5) add of_match_table to the driver

I (now) suspect that the reason this driver is still in staging is this comment:
/* Timeouts not currently handled by core */

I wonder if things changed since then ?
If not, it would be interesting to implement it in core.

Thanks
Alex


> Melissa Wen (4):
>   staging: iio: ad7150: organize registers definition
>   staging: iio: ad7150: use FIELD_GET and GENMASK
>   staging: iio: ad7150: simplify i2c SMBus return treatment
>   staging: iio: ad7150: clean up of comments
>
>  drivers/staging/iio/cdc/ad7150.c | 102 ++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 55 deletions(-)
>
> --
> 2.20.1
>
