Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D280A23319
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 13:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfETL5U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 07:57:20 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35128 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbfETL5U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 07:57:20 -0400
Received: by mail-ot1-f52.google.com with SMTP id n14so12710690otk.2
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2019 04:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bgb9Ew3pevEYqcSi2GXYSzmdFw8MXSkjiiYW1t/04RM=;
        b=Rge68e5fGSXeh8KgGq/EnF4PbodqOxy7jOFmFVZLRDKF5r0CuTIviA7uabZCtR9npM
         mcavM7a20moCB/7oc0wDy1luu+Ed4f+wccz0MnkAHk1TeTdnIEJkzF4IRwiFU3+yuyD/
         VuS+cztVQcBXDpih7rqOa1TMEPILgWvqL4/ffoGCbBxnDavlBtX4x8REei6cSl0124Wk
         cnEmN0T/moQ+Zmx2ZeGTjbfQkTL4o09wEM+1eMES36cGHWcqRghUIjpT5gdXHxxVB+tn
         DDuqHTraF7WBJXMozXAludpGDHUbsirZGzJGnVzW5sSxUmdoBy/nMVFKnXlnseHLBKFj
         dLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bgb9Ew3pevEYqcSi2GXYSzmdFw8MXSkjiiYW1t/04RM=;
        b=BufODyaIlLXV72Pq1pxxajyvuw6aPztBpi2Nwgk8VCG1QR+Ub+XGndSYsUsMqhOKV2
         p0WP+vHgWzN6/KxVLrTXoc2dYTqt6uEkeFN5wyDnbGm8HsHKakoP132P4FpOppmD1Xx/
         HYzgSRoro4IkKy9QTRxfx0FRleJ4jwNmAHC4UCTZSNwzLw9h7OqWvYMA4P+oRmZLaRE8
         XSSnFZkiiJqmUEM5FY39xavAtkBSGUzDpvrDp/PI5ZuGnGOsz7r19YmyWiOmdwOvZp2X
         RwfuLUQSwF2Da/EIXD/xdvh4zJBpgzGvtsxORstIiDQ3jjo5jhFDv40ggWdHi+IGcls7
         WzuQ==
X-Gm-Message-State: APjAAAX86kjXQ7mPRwp295gRqvnKEPQfBtohNKUfN88GnXPSV4Q1C3cx
        KSOpuw7BR9Xq10erlrKnGouF5lSejO9zYuNMJY8=
X-Google-Smtp-Source: APXvYqyg0tLn7EZdSx4T+0dgkJu2sWQIeaxqq0sRwUcMh7euLXLDCuOwrUEir0l8RiYC5rHWOaZPG0oKCeOtzqrg6OM=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr24876076oto.224.1558353439267;
 Mon, 20 May 2019 04:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAMyZ8d4ya5VpgnQBS-8isgQP5RcoDbxyRGnxYWhjtL1b2RagwQ@mail.gmail.com>
In-Reply-To: <CAMyZ8d4ya5VpgnQBS-8isgQP5RcoDbxyRGnxYWhjtL1b2RagwQ@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 20 May 2019 14:57:07 +0300
Message-ID: <CA+U=DspSs3xnYwyT_JUgJiYLzWW=d+qOAwg_rryRq7upew_1JA@mail.gmail.com>
Subject: Re: Question about ADIS162XX low voltage status bit
To:     Pedro Sousa <pedroteosousa@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 18, 2019 at 11:51 PM Pedro Sousa <pedroteosousa@gmail.com> wrote:
>
> Hi everyone,
>
> I saw that all iio drivers ADIS162XX have a comment on the low voltage
> status bit specifying 3.15V as a safe lower bound, but this value does
> not match the ones in the datasheet, which are all lower. What is the
> reason for this discrepancy?

Good find.
You are correct. The values should be 2.975V in the driver.
This is a bit hard-to-tell (why it happened to be 3.15 in the driver).

Sometimes, drivers are written before the part is released, and the
specs sometimes change from Rev A to Rev E.
Or the docs get corrected.
Or, sometimes copies a base driver from somewhere else, and forgets to
update things; no idea if that was the case here.

In any case, feel free to send a patch to fix the driver.
If not, we can send to fix them.

Thanks
Alex
