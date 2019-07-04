Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71DE25F165
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2019 04:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGDCVR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 22:21:17 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:36771 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGDCVQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 22:21:16 -0400
Received: by mail-ed1-f47.google.com with SMTP id k21so3931220edq.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Jul 2019 19:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WQDxuucyQOhf8t2+jL0l+xbEW3In4RzgoMTN2OnYWeQ=;
        b=Ub5qqHiWg9iOEzxfOsTl0T117Cjn7lLYZkCqvbWCAbJ32p3xaUrSj5Xy4V7e4l4Uv9
         NwPjWsEUJYLYO+pWL+3REjR5lIjcHIWJ7CV7X+IHpl0kxfHr5radcJbtg7IJ3MwJbIZ/
         Kof7qnVcuKtJ+LC2BqHkiiAqVc4J9xF5aM6YRgJ1HXkOjjfUDq8TGgXCQPcV+qFIHdDL
         Xxmxhq5/YSZXlXnTuZF51hK7VtKQEC+JA2fawtoNDNpZ9LLlvE8Y4RRdLKHJi4rVAQFX
         1goiLq0TbHf4PggEYmeIQWLeddJQS5ZNhyiceWszTSzQI/q7JKTwUfzzENk7M4iklZvL
         0tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WQDxuucyQOhf8t2+jL0l+xbEW3In4RzgoMTN2OnYWeQ=;
        b=S+xQbz9to0bL0vHGjcU97iCPYZ8AuzsZUK9i0UF8BfzP1BAC/FcIOVVYy1/AlQwfy9
         Jivk3Gw8LHzNQEzDnuIR5yiBmyjPQoE/37PK7QszXwOaxNhUm5SUS09hW5nOa+It8/AA
         4e/rVN+aqPlk2KnFZle2e7FNahCvQNJW9bq0E3fLrLtKfo4/iwRu6FwDFGnSDgDZHhCC
         y3GV0xvoCqplrPSlz1cvhT7TBUudNXDi+BDITOfECJxBfWYaVb2vHe3P7RUO9ANNsa85
         SjTWknGMDZQtjeKY1ypN5vu9pZQaJPov+mESaJYBDjrhCr1RxUqX/occCGpmTdQPpTqM
         Ta8g==
X-Gm-Message-State: APjAAAX0LmOIn7K3xecQe5dnwktXLzQ3ydeRuGbo6ZOTEFobkmyTcc1e
        1PDOC67Q838cHQ/NBaPB0kYPAaySlnqoQ7lVOZulpuydly8=
X-Google-Smtp-Source: APXvYqxQuEFnE9HgYFs1HkTDo9BLisRw+6NbmMq6NY9OljPIae0n+HLzUSqQkOdGxwEJTmH11bSWbIL68hgYDJR14KQ=
X-Received: by 2002:a50:9153:: with SMTP id f19mr46935160eda.70.1562206875249;
 Wed, 03 Jul 2019 19:21:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:1343:0:0:0:0 with HTTP; Wed, 3 Jul 2019 19:21:14
 -0700 (PDT)
In-Reply-To: <CALAE=UBgn6CoWZ84Gq5a4=pw6pQ0WnCOVMgy8Z7miZ-r3pjwVQ@mail.gmail.com>
References: <CALAE=UBgn6CoWZ84Gq5a4=pw6pQ0WnCOVMgy8Z7miZ-r3pjwVQ@mail.gmail.com>
From:   Martin Kelly <martin@martingkelly.com>
Date:   Wed, 3 Jul 2019 19:21:14 -0700
Message-ID: <CAN8CM3yKvCZOLTs0Q_7JU3PTb3-yEkS62w+MLd0RV6OY0riqhA@mail.gmail.com>
Subject: Re: LSM9DS1 Accel/Gyro Support?
To:     Bobby Jones <rjones@gateworks.com>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/3/19, Bobby Jones <rjones@gateworks.com> wrote:
> Hi Martin and linux-iio,
>
> I have a device using the LSM9DS1 and saw that you added support for
> the magnetometer of the chip but I was unable to follow what was done
> for the accel and gyro of the same part. Was this still something
> you're working on or perhaps those components are compatible with
> another st device?
>

Hi Bobby,

I'm on vacation right now so I'll be able to reply only sporadically,
but I'll do my best.

Basically, the LSM9DS1 accelerometer and gyroscope share a FIFO, which
means they can't be controlled independently. This breaks the current
abstraction of having two separate drivers for accelerometer and
gyroscope. The correct but more difficult solution is to create a
combined driver that supports both functions and understands the FIFO
interaction. No one has done this work yet.

More details here, in which I submitted a patch for accelerometer
support, which was rejected for the above reasons:

https://patchwork.kernel.org/patch/10138321/

Hopefully this answers your question. Let me know if you need more information.

> Thanks,
> Bobby Jones
>
