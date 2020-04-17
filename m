Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1593D1ADEA7
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 15:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgDQNoJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730597AbgDQNoI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 09:44:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5631C061A0C;
        Fri, 17 Apr 2020 06:44:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u65so1091130pfb.4;
        Fri, 17 Apr 2020 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hypx42ccjADqrNdu/0IOmFKhH6R33idYzXzHm/EnhEw=;
        b=ZT7PjufsZsPZjTJHLwSoJ7jYG4w1hxevVhuSBlwzjSgPZHt7NlstEuYjGBT5ObI6Tw
         WpmtoQRsZsZE3m/vdrA1mKsn/Qfilg/F+UTXImWXB+iFfw8G+xnN8RhGNNImi0WwXHbD
         EZ2SyLUdbdcV1oeN0y8dq/hFQt7OIz+ku57gZ2fVywOZJmnvYiHRhUuooiOLC8ag/tKS
         XJcz/YhhY5pS/tZUz/22D9MJw3NLvjPj6ph8Li6IggzolY+/tjlpBgKLET3pH5hbf+Mq
         FfRixnoqBHXys9yK6T21BZwDgE3QmdMp+0YPkrFEU95vyBNl+MTZ4TrLYH1CSyYsGDYs
         y1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hypx42ccjADqrNdu/0IOmFKhH6R33idYzXzHm/EnhEw=;
        b=NKr9xZJ36nJjF5JEa4iLQsJvcE3hQyyfs6cUaZUNUkUbjOwvZFx8lE1o3dooku9aTl
         xO7GgOGpj5lv34kbKlZ8rjqeGjiwonf0qxmYxZF4zaWD4JJb8bqAnjJ9P6F71YpnzYn4
         Wrgf2gTVgAmMvqBHi5oDUSsjVVcFGrxOmuL5V82qUPdc5xqXwS4+sRH235n15dkk6KV2
         fpHqOTfFbkRdtQcZ58vUNjSqeH8UIauYOy9Z5ypMoBzfuqnRG9A4d3N72AnGQgRLWCd+
         6mKfJvx/TzthLIYz7Xroq6+y3n3ihY7Gszo7FACaQgP/Ks7qBdksZN+Hbd3Dni5QxmsI
         ALcA==
X-Gm-Message-State: AGi0PuZF/Yulmazqk6hP3LpvQgMHKtlwKDS8LJc8vHZTnbhC2SE9zM4i
        NzrpB28BrPpz2aqpzTh46gZbUXlu0dbpz313vSE=
X-Google-Smtp-Source: APiQypLkTua337zuJMWiFuNImJfW46iP7m0JHWsWSVfhhzhf9YiUFNIAIwewwNBx/JUPCPyrCEH1en0LXSbUj+9qCE0=
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr3263398pfr.36.1587131048293;
 Fri, 17 Apr 2020 06:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200416205428.437503-1-alexandre.belloni@bootlin.com>
 <20200416205428.437503-2-alexandre.belloni@bootlin.com> <CAHp75Vddt-UKkP+b8W2CDYjt5kzggwQ+gTjrieigeYhM=e4Tig@mail.gmail.com>
 <CAHp75VeUdj4kkGMaapZu2i96faxmdnhC4a4GF1UoGfSKAVtg6g@mail.gmail.com> <20200417111302.GZ34509@piout.net>
In-Reply-To: <20200417111302.GZ34509@piout.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 16:43:59 +0300
Message-ID: <CAHp75VcyViadqUtCzFRMhyybi4sNd=0fa=F1fBL_tGn7riyF7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads8344: properly byte swap value
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 2:13 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 17/04/2020 13:47:33+0300, Andy Shevchenko wrote:
> > On Fri, Apr 17, 2020 at 1:44 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Apr 16, 2020 at 11:55 PM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:

> Both ADC families are not related, I don't think this is your issue. The
> ADS8344 was from Burr-Brown.

Thanks for clarification.

-- 
With Best Regards,
Andy Shevchenko
