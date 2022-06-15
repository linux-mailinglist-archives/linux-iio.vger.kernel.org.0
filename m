Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A180554C51D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 11:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346206AbiFOJwO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiFOJwO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 05:52:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9624E49931;
        Wed, 15 Jun 2022 02:52:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so22070137ejj.10;
        Wed, 15 Jun 2022 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2d94UGsGvMGNq3E5FlbqsEwX5l7DPXjVnfOqe97Myh4=;
        b=nUq5wRtuiPL5DfL+y3mSe9/eaTVnLo07rrQp+8nbW05xvzKCo8XcNt867JClW6Xfrv
         p981As4aLxeRx4oe23iJDcNczy7kysJ0O+ThPla1s/2LufWljTu0QEFw+oDNzu1GgQFt
         BohAPFTwwpjg0g6oXcxL1uW7yYQgi1pKPlACC4EXuV+i462HyOsbD+ZGc6d3NaycxS3S
         DwVgwAYGnpz/EfoeTekCFpLYL7modzG9bDmL//SwZibgPaescfj6Zmaos/aXwWYfp+6e
         +Vq7ATIE117a959CUlRevBhxqHAS7hpg/t2F/NSmEUskR+Gg/+odiebitTnpxUG80FKr
         eTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2d94UGsGvMGNq3E5FlbqsEwX5l7DPXjVnfOqe97Myh4=;
        b=ZUyDHYoxNv1uJLt+6AxbgHsETbdrd/mOgGQ9hPkb9SWEivUpsE3Ua2KyrGBllDYIkg
         Kf+MByLO3/+7UXMqU8z+m2I+A60w/Zr77sDeMlsn4yZbWkEEYJnuvmSpYJxHnVrVwFYr
         XlEiy/+6FNfcoPuVL7gt/fUD13ypujwgQFe0u4tlFS04mksW8EnhNAfa4ZOmgTUaoQUB
         Jroay8J3HlLuVvdTWYHt9opXqZVtN6elcm0p/lLTZH565SqnLvc/SeQDpRiKnkFtQ+sy
         /ZADhXzEeG3kD6hjHj9tC8VxB3VDlAHug9o9XWuyaezsA1HtE22vSe5B9lpLnvZe+jne
         OtZQ==
X-Gm-Message-State: AOAM532AW+yV79G9z2OQE8p6bs56esQfYwNgLjq/OYK5vktLHfngN3Vz
        x3KsD1BmJEyA5aonPpKa9otEvPsg2a2F3tHBckrI1G4AZkkKBw==
X-Google-Smtp-Source: ABdhPJxSHsie5MrccfhGp2VK2b5KuzAP6yBzxUWuyelTh0jGk8Aai0SqNKINfIA8xwNXsjSBS5pH3HDHd9ZL1uWbLSU=
X-Received: by 2002:a17:906:d9d9:b0:710:f2ae:b455 with SMTP id
 qk25-20020a170906d9d900b00710f2aeb455mr8043815ejb.77.1655286732107; Wed, 15
 Jun 2022 02:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220614194225.2226447-1-sravanhome@gmail.com> <20220614194225.2226447-6-sravanhome@gmail.com>
In-Reply-To: <20220614194225.2226447-6-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 11:51:34 +0200
Message-ID: <CAHp75Vc1PTJ-u6uMqQnCipbC1Dihx4fftc92rXRKGSeaZVZPfw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] power: supply: mp2629: Add usb fast charge settings
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Tue, Jun 14, 2022 at 9:42 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> Allows the user to change the usb device fast charge setting to advertise
> host on enumeration helps to accelerate the charging cycle. Altering this
> value resets USB existing connection.

...

> +Description:
> +               Represents a usb device fast charge settings.Altering this

USB

> +               value resets usb existing connection

USB

> +               USB DP:DM[0:0] 0.6V : Hi-Z
> +               USB DP:DM[0:1] 3.3V : 0.6V
> +               USB DP:DM[1:0] 0.6V : 0.6V
> +               USB DP:DM[1:1] 0.6V : 3.3V
> +
> +                Access: Read, Write
> +
> +                Valid values: Represented in bit DP & DM setting. Valid
> +                             range is [0, 3].

-- 
With Best Regards,
Andy Shevchenko
