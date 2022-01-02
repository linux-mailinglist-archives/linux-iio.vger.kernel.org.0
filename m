Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C81482A60
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 07:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiABG6S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 01:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiABG6S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 01:58:18 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1FC061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 22:58:17 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k21so68714603lfu.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 22:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+bzcq7UB/JKHMA/9ptkzQiF8Wl9Ixq3bTrtRrhmcT8=;
        b=lzM10FZ7WYbYyOsCLKkpfOndn11lDxow/Qfdl6Bn5iLWJFIJO42/JimqwEa2OjfJOD
         x11hlXL8Jk+hquHkuX1fKtqOU0OZ2TGM8RSEgdG7jH1MstjpxaMcDJw7Rm3D7QLGWhdI
         A2GR7ikBt2Buzk/Cz+pOtPZaGLJXK5tlbOseK/p8YVObC6VslDGqoeztxKMs/60bmqvx
         a+dU2E/hSGjsX6y8c1izCswQ9//NYsfNlnxlxF8KFi5GsbMO++JVO0c5F+vaY92CsH7D
         4nSh2nJHLpWZaaPac8RQVGQaBys1ZVr9tvQh1E9viF5bV9tNISd08ZGrjcmxfyIS5Ei9
         fAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+bzcq7UB/JKHMA/9ptkzQiF8Wl9Ixq3bTrtRrhmcT8=;
        b=3VV5jKQB5IRxHoUoRIEE5eSVcDTk/19UKYeX0hKbrrG1RoVJDwM8VtgCIA4chbg2sW
         DZ0au9IJNQy4/XumtYq5rW7L4ot9AIm+uU9Kd39g9w2h2uZiu0kjr5en5MoDExGCmau7
         An5sUNEM4dUpepAdHh/JB+/7akYcB65UniFP8BPrNE5YF+FbAmoEwvarDPcPHhEC9TvW
         c1eSedh359ozM+LDRIOvj6ATcCgaOPCwkAwOE8LoA2g8QFQAO+yTfmfjZiexMFP3JUMY
         GtqexcEmQqO2bXeLfFpmI4lLen49hkec8uyGuRkc0vr1amspzGkHbBfdckgeztF5G6LV
         jI1A==
X-Gm-Message-State: AOAM532DdB36qI0hz63WECm6nKVdkoHlzXrL3Oz+UOoxmUbxIQ9eMGXx
        7GomkyjoX+S+BPA8A2nd7QagAsNeEy3WER2cQ89VVA==
X-Google-Smtp-Source: ABdhPJxN8uIycDVKUm8aCKymqldTy/kjpLcv0AELPhelzfJM1eaHoBvEXPJBja1wzuE4wwkseu4aNsbkGLPj6f0iNEg=
X-Received: by 2002:a05:6512:39ce:: with SMTP id k14mr19142392lfu.508.1641106696001;
 Sat, 01 Jan 2022 22:58:16 -0800 (PST)
MIME-Version: 1.0
References: <20211230193331.283503-1-jic23@kernel.org> <20211230193331.283503-13-jic23@kernel.org>
In-Reply-To: <20211230193331.283503-13-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 07:58:03 +0100
Message-ID: <CACRpkdbwL-P__D4kbZs+HOsSNEvVLf-_cwXTUrOUijpFETGb=Q@mail.gmail.com>
Subject: Re: [PATCH 12/13] iio:st-sensors: Remove duplicate MODULE_*
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 8:28 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The core module and type specific core modules are made up of
> several files. There is no benefit in duplicating the MODULE_* macros
> in each file so remove them.
>
> Noticed whilst adding MODULE_IMPORT_NS() as I missed some files and
> it still worked, making it clear not all of these blocks were needed.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Denis Ciocca <denis.ciocca@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
