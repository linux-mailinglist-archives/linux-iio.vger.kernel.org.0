Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B193A57B8
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 12:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhFMKis (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 06:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhFMKis (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Jun 2021 06:38:48 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6355C061574
        for <linux-iio@vger.kernel.org>; Sun, 13 Jun 2021 03:36:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x16so4114854pfa.13
        for <linux-iio@vger.kernel.org>; Sun, 13 Jun 2021 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVJ9vqYx7qVTDbZekyP4JYvNXyni62W5vJpzNObwoLE=;
        b=L/Y4RCIPGczxbx5tcUE/RAhOLL/JJH1JawtVp8XrC/4wL+4MM2oMhf3GDC26YPk9aC
         COMUcbhbsGOzzf2g3hwiL6c50f9iIA/R2izkLQTUZa5doiY40bubVDw4jaGeVhv+WrKp
         giuQLXMInw3HuPg3poBSHcW49pTkvy9EqhWSgifRIk36+jksHZjuiJ5gouJ/ow1xYWWb
         AnDh6wWRisuTwsfpPJ9neFD6SGFVwDN4ICitBy7jOfrju9z2yCXksnn7fiYdwN0fjuln
         9i2YmpOBoW1hi36f4HMR7kNt20FEErNj6DZbFuK9WOGJpE/WM3tkTaGaatLdquqFgV4c
         HxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVJ9vqYx7qVTDbZekyP4JYvNXyni62W5vJpzNObwoLE=;
        b=DLVXtwEJPwC53b3yoSsnQMMkWmqHw9owpF7WCxQV7Rmu/Bb4Mi+DmIzCFRCf++yIJN
         VvcNg1cY9drozQvZTbEekQToH9DWJn2JYGJJb0dAj52aNYHKpewdEp20EUElcME6zAng
         Dx3KQQh5olXBt7rslPyfMW9oFpChxB5tMVVczGrLEN+UV37ylRI8MDezLQuhUBqwkOnT
         3ct+Z9JMU58WKgpG4ya0+To8RvGHoNHM97Ncr7xhUHpPU/pJt6zWxrRFUaQmoQEvmG/I
         wyrN+CgrqRfU4OTwydPSkcoznbLiDOTc4G+tqJNz1Tg5I7LRv//e7siFsthHdfIqG3q2
         MdOQ==
X-Gm-Message-State: AOAM531JhZr+N/8gOX1/gVZ+jwdDDL8q2Ym5sxQDclOqpubxd5WtMnjV
        iN71k70JzrLGPNQKHhkxNdUC4Vox7ALoUMs68hw=
X-Google-Smtp-Source: ABdhPJyJu9HtQhSoi+jqEWvnSMgXutXL/DKIcKX1oCWXbjt8s80gTqcIwdTBTnDUz3FxLnDEGMTHJzYV9fgsNAEA/v0=
X-Received: by 2002:a05:6a00:139c:b029:2f7:102c:5393 with SMTP id
 t28-20020a056a00139cb02902f7102c5393mr10063087pfg.40.1623580593260; Sun, 13
 Jun 2021 03:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210611115558.796338-1-jarkko.nikula@linux.intel.com> <20210611115558.796338-2-jarkko.nikula@linux.intel.com>
In-Reply-To: <20210611115558.796338-2-jarkko.nikula@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Jun 2021 13:36:16 +0300
Message-ID: <CAHp75VfBoOvGp7O3-WSWFuXGbQP0EbSQYaJi5B28oBkazkV8+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] counter: intel-qep: Use to_pci_dev() helper
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 2:57 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> Use to_pci_dev() helper instead of container_of(d, struct pci_dev, dev);

...

> -       struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +       struct pci_dev *pdev = to_pci_dev(dev);
>         struct intel_qep *qep = pci_get_drvdata(pdev);

Why not change both lines to dev_get_drvdata()?

> -       struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +       struct pci_dev *pdev = to_pci_dev(dev);
>         struct intel_qep *qep = pci_get_drvdata(pdev);

Ditto

-- 
With Best Regards,
Andy Shevchenko
