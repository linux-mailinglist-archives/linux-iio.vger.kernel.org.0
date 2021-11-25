Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ED145DF56
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 18:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhKYRIL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 12:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbhKYRGJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 12:06:09 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4204C0613B3
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 08:56:52 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so10288932otg.4
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 08:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/MKsi0UT9fEDSNAYACI6GQbp1DFoYRScCU+tMfqG3g=;
        b=Gp8N7404rgXFWrMhmsZdmqpK8WGen5XmXGXB66luZwx+vZNdq05FL4KwwKKEI4mMe3
         AMMytlG0W4nwLNanyyUOu6z+SrFkjLhiYIoifUe5U4LCfe2aj9oGeV/HBgC/pClTv80p
         nC/Y4bChpkCe84e3Cr5893FSV/5nMgYCfXfkoArYBXbFWogk9vv5RkrzGQ71PJLj3yI0
         RyNThTToQ47WyeN3oG6nG4JgJXQ8Lipv/uFmKwQFJDzx3Bn0juKJ9pmYjAGH+gY9Fgo9
         cGpdaHu7WrouIrqQOgwtA7k3Die2xfqtZYQwx8j+NNAybgqqFk+xjIfs3Aje+FzJvWz2
         TBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/MKsi0UT9fEDSNAYACI6GQbp1DFoYRScCU+tMfqG3g=;
        b=Fs+ZUdqC1MzVDblixs0D8tGmPJEJaxAspD75SK8v2sKfQj78JIDAp/3JjiuoKx3EaI
         43ZsPmt5fBYUXYouvGyQd6Gl6yjfe85uGp4j9WHR0+SmAvtEc4vjW4e3QyEHITdOkczv
         dVCN7hzzPTw5lMaUhWwasdRvN9+Gsa+9TU3IRf0k9xfiq69juhO7UpZ1pevpc7DnEYJZ
         TcIoGqiXYkihgfcK9dvkN9CBYZiSIyvm9OxDbpqYXjKChUn6q8UbPS1N7GJ6WMa3c62f
         73y7+vZMQ8Shuy3T4KAs1OH4SkObDOKsLGF5sz46iBHQRb/pYKXvcpWCq5/xHHVflQTI
         PfJQ==
X-Gm-Message-State: AOAM532s1bLRVVhaNfVQWH74bXR/Q+Alb/oglOnZU6UrWiBQGJ1y1/MR
        lUMV2WoCFWMII+/KLAUW6Hk5KEvQoC9+LBWYrG2VdQ==
X-Google-Smtp-Source: ABdhPJyx0Knx2uETiXexAozebh9GtLizf0fYobHvZJSQZt5sQxYU1UcJuavaXjp1gutAxmu0tS42aKXqbfNct/o2P1Y=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr21710193otl.237.1637859412173;
 Thu, 25 Nov 2021 08:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <20211123211019.2271440-42-jic23@kernel.org>
In-Reply-To: <20211123211019.2271440-42-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Nov 2021 17:56:40 +0100
Message-ID: <CACRpkda9cxmhxOAEmaU-CqgQZOGQsMzijFs2HK0J5dr5ki6Rxw@mail.gmail.com>
Subject: Re: [PATCH 41/49] iio:pressure:bmp280: Switch from CONFIG_PM guards
 to pm_ptr() / __maybe_unused
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 23, 2021 at 10:07 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM support is simpler and less error prone than the
> use of #ifdef based config guards.
>
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
