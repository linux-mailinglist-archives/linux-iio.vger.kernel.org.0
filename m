Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EB0291FA7
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgJRUBv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 16:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgJRUBv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 16:01:51 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF8DC061755
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 13:01:51 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r4so10649098ioh.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRw0/o5oGZTZDjjB3gqNIBPtxjJHtDVQ+1IUMXih6zw=;
        b=gvDwqRVNDojHEaRSR9D1CBu8YuHYcAxmjdzaT9DBoFJeXkdNv/dKZqnBe8DOjNgnlL
         nr/JbAzCYLqeXD3NgU3Ranu+PyyI0jhgr1L1b1NoVja30nViV7obzDbT5Ob7+F15u0gt
         h00ddz2XJMsMueX17SmCXYR1PvIkF9U6edigDrX0fdupBWOjIUZLVN8+vvrmvuKkOJ6e
         FUywBdobrBeEXdUlVfVn/PPuwW0wIYir7mEfCTwlxn5/83kQDg39PJWUVgRuTTmnwBeF
         tdqsfGjU6xR4svByJOpkuWvG1QKrqtlP4M6Jmsjpi8StAPhwYNjDfyAOnUZC8Le+Gw2Y
         JLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRw0/o5oGZTZDjjB3gqNIBPtxjJHtDVQ+1IUMXih6zw=;
        b=Fw5vQFXyGRiaaErqONL6nuQRy58CDxfpbRDxb4gaZtFrLT3wJdmRst8dgtD/7aKpxS
         zP4AOcpq6FMOc+WfnhK+u9t9oyYS6wylhvzQ3Ogv/pC2/HfD5SUbBjujmNVeBLPDejBY
         6mMhymO4dDRsuNM7bSBX/Q7gs3yrdr6rvjyTifBvsI2HRcwn86BJOZcFi2hfnOUjHPo7
         tSr+ftXzIZFZhyAzBYvVDHnzjSlhIe2ePsbXJ86cNuU+qe09PAY6BQT4gxd3Zp98iAtj
         gEfTJFMyTuAsfFlL1TZ9HBoxe+iZoIq3nWEz0XuxoUnim0U2FjA8EJC691vvafQBSgLr
         TXbg==
X-Gm-Message-State: AOAM5319IyaXo/EnG5JE+ucumCDx5HP0CXvNGTX1mLf2uqOk3Zqkpk4h
        AsIhH+Ja+iffp5xMddMcjQz3QFc40vINJ9Lwkrxk
X-Google-Smtp-Source: ABdhPJwSkNVofX2Rs4udoFZfsL1pIQx70wVs4ruhTz3vz35pvUxHZs8N+2Bm/9qad7XzQYL36FuETG0/KDTY+IzxMKU=
X-Received: by 2002:a02:6cd0:: with SMTP id w199mr9067803jab.121.1603051310571;
 Sun, 18 Oct 2020 13:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201018150442.GA219064@ubuntu> <CAHp75Vch2jPwZm8gVC6zRs6k=BR23Mb15Q4R4VbpMZ5FwshNLQ@mail.gmail.com>
In-Reply-To: <CAHp75Vch2jPwZm8gVC6zRs6k=BR23Mb15Q4R4VbpMZ5FwshNLQ@mail.gmail.com>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Mon, 19 Oct 2020 01:31:39 +0530
Message-ID: <CALudOK5Hy3cU6W+yWAgpqxP-27K2MXiwSwR1x3z=mJjq3y3K8w@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: vcnl4035 add i2c_device_id
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 11:59 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Oct 18, 2020 at 6:47 PM Vaishnav M A <vaishnav@beagleboard.org> wrote:
> >
> > Add i2c_device_id table for the vl53l0x-i2c driver,
> > helps in device instantiation using i2c_new_client_device
>
> In all your patches please refer to the functions like function().
> For example, here is i2c_new_client_device().
>
> > or from userspace in cases where device-tree based description
> > is not possible now (Example: device on a gbphy i2c adapter
> > created by greybus)
>
> Don't forget proper English punctuation, like periods at the end of sentences.
>
> --
> With Best Regards,
> Andy Shevchenko

Thank you Andy for your review, I have updated v4 patch with your suggestions,
https://lore.kernel.org/patchwork/patch/1322219/ (sorry about the
incorrect driver
name in the first-line of the commit message in the v3 version). This is
also fixed in the v4 submission.

Thanks,
Vaishnav
