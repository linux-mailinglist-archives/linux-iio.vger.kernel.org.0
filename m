Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABB42D86EB
	for <lists+linux-iio@lfdr.de>; Sat, 12 Dec 2020 14:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405486AbgLLN1T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Dec 2020 08:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394867AbgLLN1R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2020 08:27:17 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5AC0613D6;
        Sat, 12 Dec 2020 05:26:34 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g20so5324735plo.2;
        Sat, 12 Dec 2020 05:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4VqsG1yFpsFOT9S1zeuPn9KCPXP27bm/uC47zpRqcA=;
        b=RbvZAZsxwmrDQNDBuYEj3EwW2gc2Rhic5bc+rQNzZHuBmnBjwW/M3wj4Z72YXATR3S
         Cu+1cttlKOahJV5IeHZmifQw7GffJ6GPH7xj4EPzVFm/ehtmEn55tydLL+p4S2A4Ooiy
         pHVajpVHXlqdH7O9B/CSrHsiTsj4SG2O7riy+uQoH0t/9ldzY4W2H7ccv+YlDzF35q5u
         BQtQhfZq/h/0yFt8upM0DqOJ+OzdVgLj9tqMgUmYslDaVDwvrpUuYRcuMARWrWg51+lr
         5j1CvD2dOb52wnIpyZERx2SdIkhipXVj24A14SYXKCYLoN478a/nBS1od14MXWGa7MTu
         IdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4VqsG1yFpsFOT9S1zeuPn9KCPXP27bm/uC47zpRqcA=;
        b=AEIVyMr9xI7ovqDecjgWkp8T+8/J/X0abtd+GTbEL/yIc5fK+u1R/CIViKsWkgoEjI
         zJUkD8UxlZBBkTWwUpeTW39yP71fk8jYvUlYh5uiUDb8P4ycRUwwWxceMmTCB3HK7K+S
         Gf9V9NfkZq4WABKZZ33H/XOgzFDFQf8WvJdrXFjdsWAQ4rPY14fj7pWUzOvHAUaAx7YT
         kW/k7q8NROOn2wSj/pgnk4l8dEr1Z6Lu2vgvZUpkFJaThk88DGnHJ8rGAL8HUpmg96LU
         nXoZliLMICzETeBtgERRSLry0j/rFaP7365JtyAZZcLuecYVB7B0gpQvZJD1iM2r43t5
         5SFg==
X-Gm-Message-State: AOAM5310vg3gOwca6ZYyK5b6rWnM1P+cJ0yb8xZA6KEMt4oa6b+UxJiA
        Z8ap48x3Cqwk6m0NZzpTorsDoOeCYa8y4FqcFgMs7/ds4Vc=
X-Google-Smtp-Source: ABdhPJzcKNW1T1DWhsr1jw7ij1ZjETkKiXpgv5FX3b9pBKb89lYbgKuM4LSWQ+6mjAO/wpdPtP1didkm/h94QOi3Siw=
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr17506415pjt.228.1607779593870;
 Sat, 12 Dec 2020 05:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com> <20201209234857.1521453-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20201209234857.1521453-2-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Dec 2020 15:26:17 +0200
Message-ID: <CAHp75Vc1HAndj0qPHFpW+-5Nikz+CqKwD9MWA0vWH3-FtXPvOA@mail.gmail.com>
Subject: Re: [PATCH 1/6] iio:pressure:ms5637: switch to probe_new
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 10, 2020 at 2:01 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Switch to the modern i2c probe_new callback and drop the i2c_device_id
> array.

First part is okay.
The second is interesting. It depends if we would like to keep a
possibility to instantiate devices from user space (strictly speaking
it's an ABI breakage).

-- 
With Best Regards,
Andy Shevchenko
