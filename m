Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB7114B1D
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2019 15:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfEFNpz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 May 2019 09:45:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32890 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFNpz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2019 09:45:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id 66so2056340otq.0;
        Mon, 06 May 2019 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mho6r9R8qB+R89740KTmEYIDUGpuPD/z9tJtgya6iwI=;
        b=C1WwNR/uyN8DUo8bqzmozq6YwE9xtmV567DRX/yr/gn5miBGjepqn4D1dD/uNKjRVY
         V+WWR3DtVlInyfMVNvZdVKV5euhsGfRkzka0aWY4V2tLmp8YQOKidnXgL6iAbhk9jliD
         IQb2sJGLFHui9Uka14XbJKW9g0UMz9IZrD6eaeyAbNKjd8c5FvyQ2WPgELkZRrH2kPe2
         9UNQJIJIehcJRAu7FV9C+ebxvmsC9qJmxI6hPXD5BNEIisnVMSaKAwc9ymTIQEICpmFk
         U0kmxxp+vnu6LaqLWUcsIG3ksV1vouss9QkyKbsgSpUirr1YSsIbI1XbBkksJQt+/oCl
         xFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mho6r9R8qB+R89740KTmEYIDUGpuPD/z9tJtgya6iwI=;
        b=EKaycPAn516XgxTNTQp7xFlaIn4xrtREdJMv3gmMgt11uyZ+kO8tOYo0zYG/pwlHfQ
         qGN+v59LpSjg+CW47ZodOK7oEGKHru1lqx32qGpxIHfrwYyq42b+/zlpVFLsX4q5MQ7R
         9FrXRd2mLndUN9AQMEXwgvbusFJXg31WOUqckJPxLQu8xSIMM6jN+kXY50FaLO57Ncqh
         k+hid4h6Rxgnpq6DxHsled9itcuxqNQ3/m4v3M/sEVzr0ZEdIpmj0RbBi/LcGbTE91+z
         +51egsqT8q6bk3NIPGZ4vXJPGOYgSgqDipG5lW/tbmjbkhnvRkPm9h7x+V9ua5w4XVjC
         oTEg==
X-Gm-Message-State: APjAAAXoXVggXhS50OvngLaPXB6el6cBeX03em6YhiDOF2u8TeeJy3l4
        sI95DGpQ7UH2nBRsZtJEGiDC0RH6qK+IhF8ejQM=
X-Google-Smtp-Source: APXvYqz+eX9hseSFRaNSMBcu6hqDJT7zFyNmkmoDdZvj7Vr2kevWny5ciXDiaG91pPuFJkd+OFGT6iE2TpsBRTkyxYg=
X-Received: by 2002:a9d:6407:: with SMTP id h7mr17725002otl.35.1557150354521;
 Mon, 06 May 2019 06:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
 <20190422210606.GA8805@kroah.com> <86ea407aaa891e50a3bdaf2c3653636a365076ee.camel@analog.com>
 <20190424133455.00002909@huawei.com> <20190425193736.GA11458@kroah.com>
 <CA+U=DsoyPQyNDX6CDx=xE73H9A=66BGKhTseEvZcZZPnpPAfQw@mail.gmail.com> <20190426142754.GU9224@smile.fi.intel.com>
In-Reply-To: <20190426142754.GU9224@smile.fi.intel.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 6 May 2019 16:45:43 +0300
Message-ID: <CA+U=DspC2gbcWgEoCfTs-K0UaGt9DBLkXoyFufShUXD61uAAbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 26, 2019 at 5:27 PM andriy.shevchenko@linux.intel.com
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Apr 26, 2019 at 12:29:11PM +0300, Alexandru Ardelean wrote:
>
> > Hmm, I actually did not give much thought to that -1.
> > I'll check into this and see about a V3.
> > It may make more sense to just fix the original
> > `__sysfs_match_string()`, but I'll need to go through the users of
> > this function and see.
>
> I was thinking about existing users of such (with "gaps") cases.
> Not all of them have NULL there and would like to avoid some members.
> Though, I think that we may ignore NULL items if -1 is supplied.
>
> Think as well about ARRAY_SIZE() as given to that.
>

I am a bit vague on what you are proposing.
Is it:

a) Leave __sysfs_match_string() as-is and introduce a new
`__sysfs_match_string_with_gaps()` helper/variant ?
b) Fix __sysfs_match_string() to break/exit on the first NULL, only if
-1 is provided ?

Either is fine, but I wanted to clarify.

Thanks
Alex

> And consider to fix match_string() accordingly.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
