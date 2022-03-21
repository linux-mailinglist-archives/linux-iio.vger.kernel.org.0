Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C4F4E2356
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 10:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345890AbiCUJaR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345886AbiCUJaQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 05:30:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A38E11A2D
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 02:28:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b24so17026229edu.10
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJw8ow9u9D0H7HqPib2CvrkN2LYmifWPMHo8sOIdRrA=;
        b=BJeZJXsZV8R3gm8CimX6Ls1ylHYCUj9dTY5XM7+Uk/yTdFsn7jYc2gPTR/oMrC1BG1
         58w0Yp+x+6SCLys074ONHSTuTPNCwT89NNaItjbYHBpfy9ZKlsQYCqdY0d7bJoqiEnY0
         IhOfh07U/ZLvHD/uJUFXVsvC7GEGvPecdjZxNiIgOxN+oxULl50mXD6AuS1SHsBO0mms
         J3PgVpKLm+ohdYhnCLTxwIyo2rU53Slo/QaqWG03DHm5E5KJm7sjmv6Vn6ljrThufcZm
         zpS6Zw9A72dDPabRgZDzWQB2xu22qkO3kd93HzNik/trdc70JQhOlsvVBRAVhLTI7xuG
         qLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJw8ow9u9D0H7HqPib2CvrkN2LYmifWPMHo8sOIdRrA=;
        b=Hgyixi4CPel63iY+gUx+R2FLE4PC8Oj0ZM1HhBTvhrPd9eZY4PxfsFOjIlKAZjYkHN
         +/me8Bgiq1h32Afk8x8mpRZCdqdoImQW5x8XkrFO3mzyOpiMLVViSdou8uJQWdBCIF4I
         R99rhvDPxw72xj26dAI1hocTPOpAJRKr/ExICxYG/GZwxsht3kjFJ+SedAl9oMGvA+9X
         aN5V8uQKMTKcpgI65vF+5Cj32T93Zo9gHq9yoVSD8UerRcbwcziPWyxLJukwCYWpsrW7
         QIeWjXDAfIsWjpHBm+dq2XZQmkHZpfhB+rYw7ct7FgJrD51IZAa8ScigmJmwYLUEgHrs
         6JDA==
X-Gm-Message-State: AOAM531vwfRem6FMU/amF46JlSEZI0+coUqcLe7Zq10rIYOvhWvlArhs
        lgP5kcHI2jHqQQEBvupPXw+UiYm6a3A9/3BxEtk=
X-Google-Smtp-Source: ABdhPJys91eTPhhxUX2V5B5Q/zRa2pf8gLLbN6NXt591K9Q6wVs7yTZ7OZzyhxguNXKAc00R8CGpyvqXaB3bWKIyd7o=
X-Received: by 2002:aa7:d1ce:0:b0:419:19ed:725a with SMTP id
 g14-20020aa7d1ce000000b0041919ed725amr12900392edp.270.1647854929823; Mon, 21
 Mar 2022 02:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220320181428.168109-1-marex@denx.de> <20220320181428.168109-10-marex@denx.de>
In-Reply-To: <20220320181428.168109-10-marex@denx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 11:27:39 +0200
Message-ID: <CAHp75Vekt0aOcKMfXDhZJaC80DoqTZH30pMj6qFDhgG-guSdcg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] iio: adc: ti-ads1015: Switch to read_avail
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:
>
> Replace sysfs attributes with read_avail() callback. This also permits
> removal of ads1115_info, since the scale attribute tables are now part
> of chip data.

...

> +static const int ads1015_fullscale_range[] = {
>         6144, 4096, 2048, 1024, 512, 256, 256, 256

Keep a comma at the end.
Also applies to the rest of the modified data structures below.

>  };

-- 
With Best Regards,
Andy Shevchenko
