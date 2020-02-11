Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717EB158AD6
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 08:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBKHvr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 02:51:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39718 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBKHvr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 02:51:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id o15so10427122ljg.6
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2020 23:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgdXEI6JDSFS3pt+rYa0nTov0L2yZsdOlWEnF1jO+qI=;
        b=ddLBv4uY/qPo4/WTa/6s7tVhISjcyuYVDvgQOt5lPYCUhn46Lxqx2yGRttA4M21jJ2
         XkwMHB2igDABKHrdvt4nVls/8e0kQFJsmxyreR1Q61+ucKy/eeV8Q9bDiWEjjSidoZ7k
         Gx39B1vhT0TaWXqsqA3kkNyLJr3KFZfyC1jg76rEv9vZlhAJ67OnTzGy+7/GjFqvdN7P
         wtxXdKK1FaKDVoOL+su8cwMhwUqVp9mUQp/6jcCE0sVkt5uRAiV5F7Z6lstP9G2avxdU
         +x9OfGyUApmKDtWgbFDbec+yjxe7/X9lDveUTBZFbGATUAlJEqoUkYnKnYyHuyY8PTVF
         vnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgdXEI6JDSFS3pt+rYa0nTov0L2yZsdOlWEnF1jO+qI=;
        b=sUG1dO2Ifs774sDJln8iti/CbZQ/xnZYIwTB3bUJCapdGM6UNfVT65pceAlo3q3DRB
         AOKD+WKAqnO3kbiBhmoZ2M9MN9tJnx4Jh29bFC4ctk4X+EcdQFX7e5OuD8gNfeP/RRFu
         JEw2TG+lc1eMZ8DScx4CYdy0vrLjwQQGe/iCBclHisr973pRQxmbsqWl9yDud5tiBJ1+
         DlhJbSxB2/O7IsnBmKoEOYXv17Ke1Tv7zQE5V5lReUc0eya1S9k+lwiN/JMok2t19F0h
         i2FnSpRs4BMQgwoakFtSZzfEiPgjoNhpPnb4efhrLWNBIfrHw7Ah3GM9FZ+hAo4jZPSe
         zWCA==
X-Gm-Message-State: APjAAAVHR6zv2lZqjpRC/IWDhV6g0XrX5ilN7GLZ9fOHegs0FWftZqgU
        3SeBkSkHm6DbUSxO12GNvOA8JD3wO9Hyx9Aqll1bhQ==
X-Google-Smtp-Source: APXvYqxJnQiE7JS2C880wGFnRgKbIHzgQWhPhVIMYC44J9kQAOsRaBs5fWMhUIFhqiIqmsjxjXlsnNnqXnI9FCpfo+s=
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr3314342ljo.125.1581407504815;
 Mon, 10 Feb 2020 23:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20200208123359.396-1-linus.walleij@linaro.org>
 <74ab4b7b-eae2-0c6f-bb4a-eabbd3b4d042@gmail.com> <CACRpkdau3ei4OXcpucctxKqb7baHsMf8a0Q6sQ4P=gOf=bxQ5A@mail.gmail.com>
 <395b3e38-cea4-9376-1544-f1ef85abf171@gmail.com> <BYAPR10MB34797AABF2536F03BC3B4065A3190@BYAPR10MB3479.namprd10.prod.outlook.com>
 <9797aa15-eed1-932c-3cd6-64d7ccbf9d5e@gmail.com>
In-Reply-To: <9797aa15-eed1-932c-3cd6-64d7ccbf9d5e@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 11 Feb 2020 08:51:33 +0100
Message-ID: <CACRpkdb38q0iDa+Y18bE82haoSTXzbuORjer=g9yMtsw4COuJA@mail.gmail.com>
Subject: Re: [PATCH] RFT: iio: gp2ap002: Replace LUT with math
To:     Gregor Riepl <onitake@gmail.com>
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 11, 2020 at 8:15 AM Gregor Riepl <onitake@gmail.com> wrote:

> How about this, then?
> With a full-range lookup table (47 values), it's even possible to avoid
> additional constants and simply clamp to the size of the table.

This looks VERY good!

Can you provide a patch against upstream (Jonathan's tree)
or do you want me to pick the method and send a patch (I can
add in your Signed-off-by in that case, if you approve).

Yours,
Linus Walleij
