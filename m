Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8058438CB9
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 02:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhJYAI3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 20:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhJYAI2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2021 20:08:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFAAC061745
        for <linux-iio@vger.kernel.org>; Sun, 24 Oct 2021 17:06:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u5so8831156ljo.8
        for <linux-iio@vger.kernel.org>; Sun, 24 Oct 2021 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THBqXs11g6zygAvkeupiL3fcZlqfBPSfBA5786ee6Gg=;
        b=otEWCCBIGRMzg6r5SiYOpXE7hYbvNoW4Lc3FnT2syJVB9kFmvzCmF18U2Xo2zK9Yqe
         QhLg6DX6Bc7pU+aFUk1qeoao0B5EvW/J6mkvqP/guRjLmobWi29twrOO0vzcWdhW9Xv+
         SI2csqEQlxC/6OD7wE1l4whXWv7cBNPWv31ccOqhTeylaPoSCPKot2hns28BzK9O9cbu
         fNXGSU9LJpIhQKIFjL2HMECzA1S/YjBSMQ0szfd1SDDnx8SiHr7oVeutcKVLnNxcSBXe
         YH8+cqB18GeTEnrTf+K+bRV9KBCycN8AzcOYn1iG//e+F5r1SZ42ve41gBZ4KVhrdLJz
         lCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THBqXs11g6zygAvkeupiL3fcZlqfBPSfBA5786ee6Gg=;
        b=GYTPio3UDeP+DYP2bEfM0rA/WUpHSLarLl9pGsOognRXLf/L4OkZJu6JHki45hjkN3
         wqD57OnRwagb7DIinVZ0WrvHXZ9si2VNueg8zNxRxE9mtC3agJWv0AjLuePiYF+WKTZ0
         g8YBXX5pa4fcrAkr5lMxyYnoQ5ZOk7X+F2MtJH3T1hvfQhF5NgYPJRCMGNZ+gmU56Lxc
         gxG/vvLNGLh4FE2CfJV7+5FFlq5WTfx9RlRi9wKA3uxDmqrUqG66ggleFRXBZ5lO2If9
         EtsWDMCwvlNNCP1ZDWc8hgX/x7qx7oMZMw/hg6Fr7Ep/CsolmAlbkCA5BBBFdYk6A9/8
         Z7JQ==
X-Gm-Message-State: AOAM530Z/e/zlnMLkNhp029kE0V9Znrw+piXxahDgGGnBxztUrOxcq16
        14FIlXtI9sTZzMa9amuKu/DU5rhsW94gl9EBDd3ZihHhMZ0=
X-Google-Smtp-Source: ABdhPJy+VpEFjv9B7e01W+tvZFJteOU+wsaQcinu9jmhVqIizunF6+WD1UZxX68gG1Jceyc/dYsMxfYr8SUVfTzpyBw=
X-Received: by 2002:a05:651c:a05:: with SMTP id k5mr15416834ljq.288.1635120365267;
 Sun, 24 Oct 2021 17:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211024171251.22896-1-lars@metafoo.de> <20211024171251.22896-2-lars@metafoo.de>
In-Reply-To: <20211024171251.22896-2-lars@metafoo.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Oct 2021 02:05:54 +0200
Message-ID: <CACRpkdZPjYPUPj233csw+jBVc_-VYDztz2k_X0ryoKt9P8V9yA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: kxsd9: Don't return error code in trigger handler
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 24, 2021 at 7:13 PM Lars-Peter Clausen <lars@metafoo.de> wrote:

> IIO trigger handlers need to return one of the irqreturn_t values.
> Returning an error code is not supported.
>
> The kxsd9 interrupt handler returns an error code if reading the data
> registers fails. In addition when exiting due to an error the trigger
> handler does not call `iio_trigger_notify_done()`. Which when not done
> keeps the triggered disabled forever.
>
> Modify the code so that the function returns a valid irqreturn_t value as
> well as calling `iio_trigger_notify_done()` on all exit paths.
>
> Since we can't return the error code make sure to at least log it as part
> of the error message.
>
> Fixes: 0427a106a98a ("iio: accel: kxsd9: Add triggered buffer handling")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
