Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841CB779642
	for <lists+linux-iio@lfdr.de>; Fri, 11 Aug 2023 19:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjHKRiY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Aug 2023 13:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbjHKRiY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2023 13:38:24 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC69D30DD
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 10:38:21 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso2012222276.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691775501; x=1692380301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qb0DxbIEnd+91uAoWR6VkiWru/Hz3LURUP8+bHFcf8=;
        b=H7IltmzKGGkLpOykRxU54AYbQ3jYGWe+gwn5M8tHXcfBgvWrKyEg9fk8y5fr+7cJXb
         +nvdyhtpXD7vnvGE2flbHkQJuaQEfNn2QHIx1dUJmt7xthBdvlAf96NSssti7YeHVoIs
         khvJYxHq7l6mrM5kmsBisYWCP4Az7sDc42To4A4dDwPOFCrKSl3O8+l/YA2mfP9TgU1U
         6VuWgQ7DIEbi1IqbI+sx8utitFMUr83deaERsuVr78QnetXWb9h2byr+znZBqm2Gcpun
         cNI2YwwlhYS9HmGAdn2yMsFPeH0+dP5tXM5tCB85XUShd7zM7vLYFkE/s73+D75zcwiX
         4PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775501; x=1692380301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qb0DxbIEnd+91uAoWR6VkiWru/Hz3LURUP8+bHFcf8=;
        b=ZpTz2P6il2V5Ud3rufb1HSopXKIMCGwRurmCnElO9K1xBg3tMZk1+wGTi4mYpT/HMY
         BwzGtih6lF+ixKeuHU8uBxMgsyFp0SayXIizegLzj38QL1S5hdgDgAZ2KJY0DerBq5wR
         LkRDNJF4y4teUrtTegoaJLCzYqa18vonGqBXk+/AxcJkHHx6IosF+EpT2N/CcWYT6WWa
         BQeWpjwl3+2a/I3R98MUmxWNllWJaEE8UCCxzT5y6CopL+c+Mu5rBG9/louZfXZhMFhd
         oDUFszca3gBCgarkxYhUVa7C2G0E4XdMUtMQ3mppHCMEWr42wQMss9sh7Wy+RVHENGnu
         FOog==
X-Gm-Message-State: AOJu0Yy0kyxmNfCmy0jfRxErnLq8WF6dSaOUvuN7OMWwHO8i6ChDHs1T
        s2uCb0qCfT1wEbGsPW02hhSG5FtMBX7SKCqcGuCFOg==
X-Google-Smtp-Source: AGHT+IGGrxK3yduCOGuALlBjdp3RhbYxrKjSqh1qqDPVwzRKMFT2CgopQIeO5zOmudtygydYsUjPqJxYd5EN5UCOtd4=
X-Received: by 2002:a25:2e07:0:b0:d12:25d:fd60 with SMTP id
 u7-20020a252e07000000b00d12025dfd60mr2277109ybu.9.1691775501079; Fri, 11 Aug
 2023 10:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230811155829.51208-1-phil@raspberrypi.com>
In-Reply-To: <20230811155829.51208-1-phil@raspberrypi.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Aug 2023 19:38:09 +0200
Message-ID: <CACRpkdb6fo9YCZ+fC9VP4p+D8QC_eoTJ0vK51RPmC21x=UwRgg@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: Fix NULL pointer exception
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 11, 2023 at 5:58=E2=80=AFPM Phil Elwell <phil@raspberrypi.com> =
wrote:

> The bmp085 EOC IRQ support is optional, but the driver's common probe
> function queries the IRQ properties whether or not it exists, which
> can trigger a NULL pointer exception. Avoid any exception by making
> the query conditional on the possession of a valid IRQ.
>
> Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC i=
nterrupt")
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>

Looks like a logic mistake.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
