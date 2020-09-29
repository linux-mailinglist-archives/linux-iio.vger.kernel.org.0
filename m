Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60F027CE9A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgI2NJl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI2NJl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 09:09:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82696C061755;
        Tue, 29 Sep 2020 06:09:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h23so1496862pjv.5;
        Tue, 29 Sep 2020 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAvojDEwPP77Cf1Vn+zoDW7yhX4boGzv0zKIJzb7HK0=;
        b=s8utigraGsRng0q8D2toVYXL0YC3jjPm0r0HaEv0zz28/W6Se/BswR2VTDqDNHMJrR
         6paAWZguxV7XmEYk4CI6BIDd+hKhedrUTf8gOQ7LcgbiXNJET94ht8BKPGLVW+lNsT3P
         9Tuk3ELyVjAygaKdF7dBTSfKRN7dciAjJE41VQQADIzuIJ18EVx/PqmTFTfaRJYXqzg7
         B53OBojjYOzgFUmGp+9no4FGl9bbZQ53b0+N9AOKBJpGcB6xGNSBVQrs9Yjq3z0DXYQD
         +1ImBvp2FNt0YW0p1+y1Oc7oI6yxkd4jYbUduYlJ8v8jjlimnFe8aYf6yMOGFT8xKJYs
         K1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAvojDEwPP77Cf1Vn+zoDW7yhX4boGzv0zKIJzb7HK0=;
        b=ezfD4lzO4DJ+Tjc3zaJ7SRpzczaQ46exvT/PK4AIF3HBInLxVRnHoPlxX7KSRI1xty
         6UQVVIiOPc+VYJEtAFFFbdY2JLnQ4DXzFQ6I4sp1UoDklF3xb+1uZ3cEZhuOEysqagC6
         DLkSIvdiJ9SkCGcsluzW2wdcEmTUns1ZS0+5kZ2qIWqYGtefRQmfH1YsrYJNouzzaoEB
         UbWEH2vn+hI8t4+MuPFCgXRwHom8Kp8pmLDTGjuOF1Kd7TpfXg4I6TF9PR5cfuWOAWNq
         qAH9vMvImlCosiOfIXpRn9gyA+Avz0IPsYilkrY+HT5a8zobEHBme5DThV1bkUJnNPK0
         kbXw==
X-Gm-Message-State: AOAM532Oplv467sTp8yz7Z9yCjBEAUGC7mAd0tdWMqR/2ua8reYw5d98
        D7g2TIpNUkZ//9o1KcNyI4CUXMLiRtERiLEiuhw=
X-Google-Smtp-Source: ABdhPJz43usza+2e6m35ZxXuL/DIBXQoKpFuq77G2llkzWVkcSlh22Fn0hVML6oDua2jbhX86McCdeQ0OtAs33gDNRQ=
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr3904635pjb.129.1601384981090;
 Tue, 29 Sep 2020 06:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200929125949.69934-1-alexandru.ardelean@analog.com> <CAHp75VeQVEwtKGZcM6w=wfWuAvAD4xtveNUzT-7eXn5FVdheJQ@mail.gmail.com>
In-Reply-To: <CAHp75VeQVEwtKGZcM6w=wfWuAvAD4xtveNUzT-7eXn5FVdheJQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Sep 2020 16:09:22 +0300
Message-ID: <CAHp75Vf4dvVKMZo1C5sWWg3cjFgDM5pizJEtwGFieXruMQBS1Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] iio: remove iio_buffer_set_attrs() and assign
 buffer attrs during alloc
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        groeck@chromium.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 29, 2020 at 4:09 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Sep 29, 2020 at 3:55 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > This is a v2 & v3 for [1]:
> >   https://lore.kernel.org/linux-iio/20200925083743.46469-1-alexandru.ardelean@analog.com/
> >
> > It also includes a at91-sama5d2_adc cleanup patch in this series:
> >   https://lore.kernel.org/linux-iio/20200924102902.136169-1-alexandru.ardelean@analog.com/
> > This patch is required, in order to make the removal of
> > iio_buffer_set_attrs() a bit cleaner in the at91-sama5d2_adc driver.
> >
> > Following the discussion from [1], this patchset implements the
> > following:
>
> Makes sense to me, FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenjko>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
