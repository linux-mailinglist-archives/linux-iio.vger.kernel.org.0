Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E92D8942
	for <lists+linux-iio@lfdr.de>; Sat, 12 Dec 2020 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439730AbgLLS1N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Dec 2020 13:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436509AbgLLS1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2020 13:27:13 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF6C0613CF;
        Sat, 12 Dec 2020 10:26:32 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id j1so6424382pld.3;
        Sat, 12 Dec 2020 10:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=priY+gMifRi9SXBuHcjr1reGmyMklvNrzc4Nr2fnS9Q=;
        b=VZKP0fs8LF7hQa1pTcSvuxBeTtWQF+gDl/Bn3za06fUJMryGc/RyjZXn5qdUbxqU7+
         ttugcx06d2j0fndpQ3+adqR/4jniLSdLxc5im7DKfvTgDTVwrq0L0rO4ATdk+DfgQYvP
         FccsHypPr5/fRftFBTaTDTgPVh9c+DYa54hstdtJZKgavUCudoS60Ug84TKng6PqFqRW
         wBczxNkNN5ZT8cY0RwTdGG8ztaxx7xmS4ZZaP+5Y+JyhYwJy6QF3orO2TQljaYdxBj/F
         X1KnsfashpFgKkKrqfo7Qa+XbEKIjHUcmn9LlY2Tzta0T7z8pTD8SPlpNwIQ9ZW9snQr
         DUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=priY+gMifRi9SXBuHcjr1reGmyMklvNrzc4Nr2fnS9Q=;
        b=R/vxuAqvrshPvwdxlGx8O3iZyv+qUGtoPeCOjBXEtfsKAEikhDxBDf688wVeQcf0Cd
         xZfug5ISw3HohV0OriMRHPsvgppUdmzlpau+Tj6P3bV724JILa9R+6MvKok6n1ztK1Ug
         e2GkoqT5Qa6nUvJL9Kpr08w4yYlGhdwWh781IQRuvK4KuKF0M8/9odTzTWvbiVGvylGh
         o78GI8hmVZpWg5zca7DsI6lnNW8ZsuvbUpvfNti01C9NSI13JriPGGcO7nrdZtFRlFCM
         fvBqMBeG7EdoDEZLl3UHJujabfItAzfJgBwMoPIUTitYj7pWfI/67Snc4tWecO8zgaFb
         aHHg==
X-Gm-Message-State: AOAM532PkoBxTBbCnv7Jf+Er+Ev3iKSr/zgOplJjhYHjTVhdifhs5elz
        Pf6LYU1CK9Klh9X9bD5LrURg5W2TTIMssZvLd/6OwpZM0HA=
X-Google-Smtp-Source: ABdhPJyj+rxm2eGnQb+B2ILCmYQhOJCwmN8Q3Tq+oc6ufek3ysjnd2Yv27lefU8KvCziIzC3PM5ADf1C//6bbnYamNo=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr18709466pjb.129.1607797592321;
 Sat, 12 Dec 2020 10:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com> <20201209234857.1521453-4-alexandre.belloni@bootlin.com>
In-Reply-To: <20201209234857.1521453-4-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Dec 2020 20:26:16 +0200
Message-ID: <CAHp75Vf7A7e4RC2_wjizsPiGn3EjSPhxq4RA2vSQ0BtKaU1T0Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] iio:pressure:ms5637: limit available sample frequencies
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

On Thu, Dec 10, 2020 at 2:03 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Avoid exposing all the sampling frequencies for chip that only support a
> subset.

> +static ssize_t ms5637_show_samp_freq(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +       struct ms_tp_dev *dev_data = iio_priv(indio_dev);
> +       int i, len = 0;
> +
> +       for (i = 0; i <= dev_data->hw->max_res_index; i++)
> +               len += scnprintf(buf + len, PAGE_SIZE - len, "%u ", ms5637_samp_freq[i]);

Doesn't IIO core have a helper?
Also, it's better to use sysfs_emit().

> +       buf[len - 1] = '\n';
> +
> +       return len;
> +}

-- 
With Best Regards,
Andy Shevchenko
