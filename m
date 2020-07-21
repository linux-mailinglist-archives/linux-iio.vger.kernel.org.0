Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232ED22892F
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 21:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgGUTdm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgGUTdm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 15:33:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF0AC061794;
        Tue, 21 Jul 2020 12:33:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t11so11182529pfq.11;
        Tue, 21 Jul 2020 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeEe2OI1v4iURMgOM2PIXNNcRebf0mnTL/T9bdHr1Vw=;
        b=sgmLu1h6jyLPC5noDy2zDIALc6i80LcAePkHH28CTkoGCHncr87hpT+0KDv2ZD23gZ
         NaxqhpXEgrCqK2eOlzg4J7yEkpQPeX1Pnw0h44RLz7+jmCgzR/i3iiMe5Uri3YsIv91T
         mk8XC9gNF48S9H7NTUbrsLXSLdfIZoqO0+k96awz/EMWNQgJOHmXVgqUjJ4a99Iupe0K
         wzdY3a67m/NneC28l3zuz1++gyCmMImO+ITB54MkNKuyXs3s9vYyxe51RMWx64yH0haf
         Ut7mXUJr6PbmlNskZu5glTYouFG9yLrfF+Oa0X6RiX5h4eAC6n29uTEgSygHe56wv7oe
         bZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeEe2OI1v4iURMgOM2PIXNNcRebf0mnTL/T9bdHr1Vw=;
        b=lLT4vuu+8ldzQoJeH60K3IH3B7LLQRcED1UO3t5eP+qHfovgPREKFuY7I+LXY6iSHA
         JRWqD0fXbtRgZbVT5qz36Mvsy4oB+kqOrLv/KN846tYTDCQcdGGXsBEoIogsK05o75Wj
         5D3/QIcs1Hg0HoIzNr6+KdrTFBf5/6ae9KPJcbj7sSCwxVP1NCr15NmI2Em1HXpydWmB
         5OjqxFP/v+I4Xuv3S+Sjo3vt06gye19kZjMrjG9qGqPYurGCzCI9UZytKecS9qXCL0wa
         w7hoZckKu69Ddz1mi/QaBIJ3TieKmZNAaGkVms2VZqdUWaTbmezXmYWxXkZIwF/75j6I
         MPvA==
X-Gm-Message-State: AOAM531eUuywEeB4YgFwE3Mi5ow+WNtHcD3Dul6jCri46sy5jEJUDjbS
        OMYBt+RXBKi1EzuTwMvRsyUOXNVSLaO2hm8/5N81W/hP
X-Google-Smtp-Source: ABdhPJz3S4liEiFToNrUgzlpJplq5k7rnbD11RnkZZOq2N+AY0BYuPDqU6G/pAXS80XtXY0HraeKnMqnDqlqTixBIsc=
X-Received: by 2002:a62:7657:: with SMTP id r84mr24687152pfc.130.1595360021508;
 Tue, 21 Jul 2020 12:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200721112409.220536-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200721112409.220536-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 22:33:24 +0300
Message-ID: <CAHp75VfY_6pg=6atYwd=JcPd1MZqHZh5Dj_QYdQyS=5ENHL5aQ@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: ad9523: convert rest of driver to device
 managed functions
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 2:27 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The driver pretty much uses device managed functions. The only left-over is
> the iio_device_register() function, which also requires an action-or-reset
> hook to disable the regulator on the remove and error path.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

...


> +       ret = devm_iio_device_register(&spi->dev, indio_dev);
> +       if (ret == 0)

> +               dev_info(&spi->dev, "probed %s\n", indio_dev->name);
>
>         return ret;

Please, drop this useless spam (I agree here with Greg KH) and use simply
return devm_iio_...(...);

-- 
With Best Regards,
Andy Shevchenko
