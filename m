Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9705195793
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 13:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0M4w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 08:56:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40048 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0M4w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 08:56:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id c20so1919450pfi.7;
        Fri, 27 Mar 2020 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCESKrrWnEcLImLZvJm5tR1fjZbwCGME3IqndlFgAd8=;
        b=CoO6ypzNkOmyFHnruT4hQazdZeYV0ej95HEw1xMXx7JHlJ4uiKMUqOfarbksTb9Wok
         458GeF0mY3hW10GFyr0UvYzVY8HIXdfia1EtudKJut1U1SQ1ohhpbYHtn3pC2KbaNM0D
         A5lBJojF4CREWm7yNAO7fN2jxnB1qpbLHOYv6a8nsiwEilysWuWVFffZ5qi3C3kK/v87
         Opq3/TjcWGYtWuoAvMmQvYSh2bEhQR7enzal9/T/4/4/N+9S9oKo78qT7Lbawcg9fn1r
         0h8AGbXDP6L4nB2gu8BUnKK3vit+Gp6qKeiiNEXz0kTmqYXxWa+jXSa1p53IYv6hi/gd
         9X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCESKrrWnEcLImLZvJm5tR1fjZbwCGME3IqndlFgAd8=;
        b=THV0TwWruytPjbg8aAt1DUT3yAdgKzTH+B8lRvfMySWw6z+KEDAgNx/NNpmd5UqWjQ
         pkyf9cYdCqg9p+Q5VUj9ZWpTGqAv4CfHQzGFDJM0uXHNNq737+dSUcaVdXHdtcZdA7B7
         eeVR8ZqFwnjzhsgxa0oRdYF3pEXMcOISZ7XO6VfSvJWScOSSEVhP83lyM6NKElATpNS1
         yoWNK6Z+3+clryWMfj6zCowq6lSRwWIOjJfWzw5kIFRNq1dDykJslcR9mrPg06GarEsg
         +trdXuER5eP2/AmQ+i/RsRMllTS/dQ69P4xZVS24W7q611EcacUB+PLVyVVtN30Djb1l
         I0pA==
X-Gm-Message-State: ANhLgQ1iABUOykD1G1Q/i2+nt6dyeik47V8UJG14EOcq8Zo3umuWrelc
        d5pEa3JwSfqo7hzCIYyCHCCB/TnHesFcNLZvJg4=
X-Google-Smtp-Source: ADFU+vuBprMuWtXdm/FnbYNvjG3ofuWuI6NnR5OtgHiNk04Q2OWyrABc5FzEbeSm7D7BlNrC+5ZwVRZa86bjZgeuRVg=
X-Received: by 2002:a63:798a:: with SMTP id u132mr14441551pgc.203.1585313810224;
 Fri, 27 Mar 2020 05:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200322224626.13160-1-sravanhome@gmail.com> <20200322224626.13160-3-sravanhome@gmail.com>
 <20200327075541.GF603801@dell> <a6098b6a-2b2f-5279-f9fc-85201b9aabde@gmail.com>
 <20200327102221.GA3383@dell> <a679aba5-4cfb-1b6c-8cb0-dab3a644f3e7@gmail.com>
 <20200327112523.GC3383@dell> <45f68c40-8e50-e0a2-a89a-b5a164d6b75c@gmail.com>
In-Reply-To: <45f68c40-8e50-e0a2-a89a-b5a164d6b75c@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Mar 2020 14:56:43 +0200
Message-ID: <CAHp75VcAq-CwsXccbLVxEwGjZjNhdcbMyM-Y-=SEbmexBidCHw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 27, 2020 at 2:41 PM saravanan sekar <sravanhome@gmail.com> wrote:
> On 27/03/20 12:25 pm, Lee Jones wrote:
> > On Fri, 27 Mar 2020, saravanan sekar wrote:
> >> On 27/03/20 11:22 am, Lee Jones wrote:

> > So Andy has reviewed, but you still don't have him on Cc?
> Sorry one of his hint made me removed him in CC unknowingly.
>
> "For the future, hint:
>          scripts/get_maintainer.pl --git --git-min-percent=67 ..."
>

Perhaps I have to elaborate. The above hint for the initial submit.
Then the rule of thumb: Include reviewers into Cc (to the patches they
have reviewed), because you can't know their intention and maybe they
want to follow a development.

> My fault, added him in CC

No problem.

--
With Best Regards,
Andy Shevchenko
